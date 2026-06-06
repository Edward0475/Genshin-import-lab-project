import { Entity, Column, PrimaryGeneratedColumn, CreateDateColumn } from 'typeorm';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 100, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  password?: string;

  @Column({ type: 'enum', enum: ['admin', 'user'], default: 'user' })
  role: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  oauth_provider?: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  oauth_id?: string;

  @Column({ type: 'varchar', length: 255, nullable: true })
  bearer_token?: string;

  @CreateDateColumn()
  created_at: Date;
}