import 'dotenv/config'
import { PrismaClient as TinybotsPrismaClient } from '../generated/prisma/tinybots'
import { PrismaClient as DashboardPrismaClient } from '../generated/prisma/dashboard'

export const tinybots = new TinybotsPrismaClient()
export const dashboard = new DashboardPrismaClient()

export async function connectAll() {
  await tinybots.$connect()
  await dashboard.$connect()
}

export async function disconnectAll() {
  await Promise.all([tinybots.$disconnect(), dashboard.$disconnect()])
}