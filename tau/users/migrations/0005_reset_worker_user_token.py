# Generated by Django 3.1.7 on 2021-05-23 14:03

from django.db import migrations

def create_worker_user_token(apps, schema_editor):
    User = apps.get_model('users', 'User')
    u = User.objects.get(username='worker_process')
    Token = apps.get_model('authtoken', 'Token')
    Token.objects.get_or_create(user=u)

def remove_worker_user_token(apps, schema_editor):
    User = apps.get_model('users', 'User')
    u = User.objects.get(username='worker_process')
    token = u.auth_token
    token.delete()

class Migration(migrations.Migration):

    dependencies = [
        ('users', '0004_create_token_for_worker_user'),
    ]

    operations = [
        migrations.RunPython(remove_worker_user_token, reverse_code=create_worker_user_token)
    ]
