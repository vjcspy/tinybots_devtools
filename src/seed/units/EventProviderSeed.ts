import { AbstractSeed } from '../core/AbstractSeed'
import type { SeedContext } from '../core/SeedContext'

export type EventProviderRefs = { providerId: number; name: string }

export class EventProviderSeed extends AbstractSeed<EventProviderRefs> {
  constructor() { super('event_provider') }
  async seed(ctx: SeedContext): Promise<EventProviderRefs> {
    const name = `seed-provider-${ctx.scope}`
    const p = await ctx.tinybots.event_provider.upsert({ where: { name }, update: {}, create: { name, description: 'seed provider' } })
    return { providerId: p.id, name }
  }
  async clean(ctx: SeedContext, refs?: EventProviderRefs): Promise<void> {
    await ctx.tinybots.event_provider.deleteMany({})
  }
}
