import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';

@Entity('weapons')
export class Weapon {
  @PrimaryGeneratedColumn()
  id!: number; // Tambahkan !

  @Column({ type: 'varchar', length: 255 })
  name!: string; // Tambahkan !

  @Column({ type: 'varchar', length: 100 })
  type!: string; // Tambahkan !

  @Column({ type: 'text', nullable: true })
  description!: string; // Tambahkan !

  @Column({ type: 'int' })
  stock!: number; // Tambahkan !

  @Column({ type: 'varchar', length: 255, nullable: true })
  image!: string; // Tambahkan !

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  price!: number; // Tambahkan !
}