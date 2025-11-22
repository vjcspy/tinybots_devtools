import 'dotenv/config'
import { createContext, destroyContext } from './core/SeedContext'
import { Orchestrator } from './core/Orchestrator'
import { RobotAccountStatusSeed } from './units/RobotAccountStatusSeed'
import { RobotAccountSeed } from './units/RobotAccountSeed'
import { EventProviderSeed } from './units/EventProviderSeed'
import { EventSchemaSeed } from './units/EventSchemaSeed'
import { IncomingEventCleanerSeed } from './units/IncomingEventCleanerSeed'

async function main() {
  const args = process.argv.slice(2)
  const scopeArg = args.find(a => a.startsWith('--scope='))
  const clean = args.includes('--clean')
  const dryRun = args.includes('--dry-run')
  const scope = scopeArg ? scopeArg.split('=')[1] : `${Date.now()}`
  const ctx = await createContext(scope)
  try {
    const status = new RobotAccountStatusSeed()
    const robot = new RobotAccountSeed()
    const provider = new EventProviderSeed()
    const schema = new EventSchemaSeed(1, false)
    const seeds = [status, robot, provider, schema]
    const orchestrator = new Orchestrator(seeds, ctx)
    if (clean) {
      const cleanOnly = new Orchestrator([new IncomingEventCleanerSeed(), ...seeds], ctx)
      await cleanOnly.clean()
      return
    }
    const snapshot = await orchestrator.run(dryRun)
    console.log(JSON.stringify(snapshot, (_k, v) => typeof v === 'bigint' ? v.toString() : v, 2))
  } finally {
    await destroyContext()
  }
}

main()
