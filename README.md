<div align="center">
<p align="center">
  <p align="center">
    <h3 align="center">MariaDB Secure</h3>
    <p align="center">
      Automate <code>mysql_secure_installation</code> for MariaDB.
    </p>
  </p>
</p>
</div>

## About

A bash script to automate the running of `mysql_secure_installation` for MariaDB. This has been tested on the following systems:

```
openSUSE Leap 15.2 (MariaDB 10.4.13)
```

Based on the script by [Vladimir Chumak](https://gist.github.com/coderua), forked from https://gist.github.com/coderua/5592d95970038944d099.

## Dependencies

```
expect
```

## Usage

Setup MariaDB root password:

```bash
./mysql_secure.sh 'your_current_root_password'
```

Change MariaDB root password:

```bash
./mysql_secure.sh 'your_old_root_password' 'your_new_root_password'
```
