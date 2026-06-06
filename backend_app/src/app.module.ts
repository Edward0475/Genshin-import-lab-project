import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Weapon } from './weapons/weapon.entity';
import { WeaponsModule } from './weapons/weapons.module'; // WAJIB ADA

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'root',
      password: '',
      database: 'genshin_import',
      entities: [Weapon],
      synchronize: false,
    }),
    WeaponsModule, // WAJIB ADA agar API bisa jalan
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}