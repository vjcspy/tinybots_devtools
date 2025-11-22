import {AbstractSeed} from '../core/AbstractSeed'
import type {SeedContext} from '../core/SeedContext'
import type {RobotAccountStatusRefs} from './RobotAccountStatusSeed'

export type RobotAccountRefs = { robotId: number; username: string }

export class RobotAccountSeed extends AbstractSeed<RobotAccountRefs> {
    constructor(private readonly status: { refs?: RobotAccountStatusRefs } = {}) {
        super('robot_account')
    }

    async seed(ctx: SeedContext): Promise<RobotAccountRefs> {
        const username = `robot-${ctx.scope}`
        const existing = await ctx.tinybots.robot_account.findUnique({where: {id: 1}})
        let r;
        if (!existing) {
            r = await ctx.tinybots.robot_account.create({
                data: {
                    id: 1,
                    username: "username-1",
                    password: 'seed', role: 'robot', account_status_id: 1
                }
            })
        } else {
            r = existing
        }
        return {robotId: r.id, username}
    }

    async clean(ctx: SeedContext, refs?: RobotAccountRefs): Promise<void> {
        await ctx.tinybots.robot_account.deleteMany({})
    }
}
