
# Three Tier Architecture

![alt text](./three-tier-architecture.drawio.png)

---
when deleting terraform and creating new one - either. change name of secretsmanager(new name) or force delete using below
as it dont allow you to create it again due to policy

```bash
aws secretsmanager delete-secret --secret-id rds_db_password --force-delete-without-recovery
```