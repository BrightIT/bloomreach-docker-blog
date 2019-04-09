-- Create users
CREATE USER 'cms_user'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'site_user'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'sa'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'wpm_user'@'localhost' IDENTIFIED BY 'password';

-- Create databases
CREATE DATABASE bloomreachcms;
CREATE DATABASE bloomreachsite;
CREATE DATABASE targeting;
CREATE DATABASE wpm;

-- Grant permissions to users
GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, LOCK TABLES, SELECT, UPDATE ON bloomreachcms.* TO 'cms_user'@'%' IDENTIFIED BY 'password';
GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, LOCK TABLES, SELECT, UPDATE ON bloomreachsite.* TO 'site_user'@'%' IDENTIFIED BY 'password';
GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, LOCK TABLES, SELECT, UPDATE ON targeting.* TO 'sa'@'%' IDENTIFIED BY 'password';
GRANT ALTER, CREATE, DELETE, DROP, INDEX, INSERT, LOCK TABLES, SELECT, UPDATE ON wpm.* TO 'wpm_user'@'%' IDENTIFIED BY 'password';
