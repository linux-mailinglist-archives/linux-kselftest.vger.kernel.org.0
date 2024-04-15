Return-Path: <linux-kselftest+bounces-8029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3828A5B81
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5023B219E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EF915B134;
	Mon, 15 Apr 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY3Dth1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D83156997;
	Mon, 15 Apr 2024 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210307; cv=none; b=oTZgOE/rt7tD+pyfncWuNw3AsgW+4Hi4GJEFyIaJ8QiarT9t3aAFl+yCp8lcz2D5BT+6JHTFmpxGhP7BB6iNw0HJR6ZT267dwjZpPZdutX6SkbNUIaa56eQIsZ8uN4dJG48lNzkfLbuvA2oueh1mR2A7ibdWkoDvgAH3NvWb7yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210307; c=relaxed/simple;
	bh=Xt7lH/+5TOk+T6Zhl5qSkmdun7eJd8jjuto5481Wung=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WNqQmeH7AoC1cfaR4ojrx06/ocWhzBtoIDeIcLzaIX3V903z2Ynrmi465SYPoMS9W/YUSa8d9upm5uH8pQHlj9et+4cu9D7B4I2ah5v7C98rW+7tMWHkRfmBmmlA+LW8G827bKLy6MNj6zQRyBrX28qEfN6ugzza5kasAFZS7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY3Dth1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26F7C113CC;
	Mon, 15 Apr 2024 19:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210307;
	bh=Xt7lH/+5TOk+T6Zhl5qSkmdun7eJd8jjuto5481Wung=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pY3Dth1XUXYJ0DOBdanqw20EMfSBCABEwXlEMHmaz2HYH+YK2kvUJC/n2ptWpTmcQ
	 W7R62NeXez1xcRLX5YzlXriiIhN1LFWOE3snDtnN/GQhDQKukcy9hddSt9Vj2ut3Tq
	 FnHFKiFzA5aO4KlyQqp2gZ7+ZMcY7E45zFoDFvhpiQAW5NVGWbaqKxsvBQJ5CSaY0d
	 sHKkJvB+yl/6a+WQcxsUu9vpf62rl77B8HjyemroRGVwyOt2bkwdRUq+QTJxV08ImN
	 kzhZY6VRcakCeir6SrUIN5j0QsQYGK1BRrSYhVvd0ftQ00za+M8xSmM/a6unZW/6J0
	 uKb5sVFG5DyeQ==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:44:59 +0300
Message-Id: <D0KYD68AC7LR.9E01ZR9Q216J@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 11/14] digest_cache: Reset digest cache on
 file/directory change
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-12-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-12-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Register six new LSM hooks, path_truncate, file_release, inode_unlink,
> inode_rename, inode_post_setxattr and inode_post_removexattr, to monitor
> digest lists/directory modifications.
>
> If an action affects a digest list or the parent directory, the new LSM
> hook implementations call digest_cache_reset_owner() to set the RESET bit
> (if unset) on the digest cache pointed to by dig_owner in the inode
> security blob. This will cause next calls to digest_cache_get() and
> digest_cache_create() to respectively put and clear dig_user and dig_owne=
r,
> and request a new digest cache.
>
> If an action affects a file using a digest cache, the new LSM hook
> implementations call digest_cache_reset_user() to set the RESET_USER bit
> (if unset) on the digest cache pointed to by dig_user in the inode securi=
ty
> blob. This will cause next calls to digest_cache_get() to put and clear
> dig_user, and retrieve the digest cache again.
>
> That does not affect other users of the old digest cache, since that one
> remains valid as long as the reference count is greater than zero. Howeve=
r,
> they will be notified in a subsequent patch about the reset, so that they
> can eventually request a new digest cache.
>
> Recreating a file digest cache means reading the digest list again and
> extracting the digests. Recreating a directory digest cache, instead, doe=
s
> not mean recreating the digest cache for directory entries, since those
> digest caches are likely already stored in the inode security blob. It
> would happen however for new files.
>
> Dig_owner reset for file digest caches is done on path_truncate, when a
> digest list is truncated (there is no inode_truncate, file_truncate does
> not catch operations through the truncate() system call), file_release,
> when a digest list opened for write is being closed, inode_unlink, when a
> digest list is removed, and inode_rename when a digest list is renamed.
>
> Dig_owner reset for directory digest caches is done on file_release, when=
 a
> new digest list is written in the digest list directory, on inode_unlink,
> when a digest list is deleted from that directory, and finally on
> inode_rename, when a digest list is moved to/from that directory.
>
> Dig_user reset is always done on inode_post_setxattr and
> inode_post_removexattr, when the security.digest_list xattr is respective=
ly
> set or removed from a file using a digest cache.
>
> With the exception of file_release, which will always be executed (cannot
> be denied), and inode_post_setxattr and inode_post_removexattr, which are
> executed after the actual operation, the other LSM hooks are not optimal,
> since the digest_cache LSM does not know whether or not the operation wil=
l
> be allowed also by other LSMs. If the operation is denied, the digest_cac=
he
> LSM would do an unnecessary reset.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/digest_cache/Kconfig    |   1 +
>  security/digest_cache/Makefile   |   3 +-
>  security/digest_cache/dir.c      |   6 +
>  security/digest_cache/internal.h |  14 +++
>  security/digest_cache/main.c     |  19 +++
>  security/digest_cache/reset.c    | 197 +++++++++++++++++++++++++++++++
>  6 files changed, 239 insertions(+), 1 deletion(-)
>  create mode 100644 security/digest_cache/reset.c
>
> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfi=
g
> index cb4fa44e8f2a..54ba3a585073 100644
> --- a/security/digest_cache/Kconfig
> +++ b/security/digest_cache/Kconfig
> @@ -2,6 +2,7 @@
>  config SECURITY_DIGEST_CACHE
>  	bool "Digest_cache LSM"
>  	select TLV_PARSER
> +	select SECURITY_PATH
>  	default n
>  	help
>  	  This option enables an LSM maintaining a cache of digests
> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makef=
ile
> index e417da0383ab..3d5e600a2c45 100644
> --- a/security/digest_cache/Makefile
> +++ b/security/digest_cache/Makefile
> @@ -4,7 +4,8 @@
> =20
>  obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> =20
> -digest_cache-y :=3D main.o secfs.o htable.o populate.o modsig.o verif.o =
dir.o
> +digest_cache-y :=3D main.o secfs.o htable.o populate.o modsig.o verif.o =
dir.o \
> +		  reset.o
> =20
>  digest_cache-y +=3D parsers/tlv.o
>  digest_cache-y +=3D parsers/rpm.o
> diff --git a/security/digest_cache/dir.c b/security/digest_cache/dir.c
> index a7d203c15386..937177660242 100644
> --- a/security/digest_cache/dir.c
> +++ b/security/digest_cache/dir.c
> @@ -148,6 +148,12 @@ digest_cache_dir_lookup_digest(struct dentry *dentry=
,
> =20
>  	list_for_each_entry(dir_entry, &digest_cache->dir_entries, list) {
>  		mutex_lock(&dir_entry->digest_cache_mutex);
> +		if (dir_entry->digest_cache &&
> +		    test_bit(RESET, &dir_entry->digest_cache->flags)) {
> +			digest_cache_put(dir_entry->digest_cache);
> +			dir_entry->digest_cache =3D NULL;
> +		}
> +
>  		if (!dir_entry->digest_cache) {
>  			cache =3D digest_cache_create(dentry, digest_list_path,
>  						    digest_cache->path_str,
> diff --git a/security/digest_cache/internal.h b/security/digest_cache/int=
ernal.h
> index c13b35f6b2c0..c816929c4743 100644
> --- a/security/digest_cache/internal.h
> +++ b/security/digest_cache/internal.h
> @@ -18,6 +18,8 @@
>  #define INVALID			1	/* Digest cache marked as invalid. */
>  #define IS_DIR			2	/* Digest cache created from dir. */
>  #define DIR_PREFETCH		3	/* Prefetching requested for dir. */
> +#define RESET			4	/* Digest cache to be recreated. */
> +#define RESET_USER		5	/* Dig_user pointer to be released. */
> =20
>  /**
>   * struct readdir_callback - Structure to store information for dir iter=
ation
> @@ -247,4 +249,16 @@ digest_cache_dir_lookup_filename(struct dentry *dent=
ry,
>  				 char *filename);
>  void digest_cache_dir_free(struct digest_cache *digest_cache);
> =20
> +/* reset.c */
> +int digest_cache_path_truncate(const struct path *path);
> +void digest_cache_file_release(struct file *file);
> +int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry);
> +int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_=
dentry,
> +			      struct inode *new_dir, struct dentry *new_dentry);
> +void digest_cache_inode_post_setxattr(struct dentry *dentry, const char =
*name,
> +				      const void *value, size_t size,
> +				      int flags);
> +void digest_cache_inode_post_removexattr(struct dentry *dentry,
> +					 const char *name);
> +
>  #endif /* _DIGEST_CACHE_INTERNAL_H */
> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
> index a5616fd07c1d..ce3518a33c80 100644
> --- a/security/digest_cache/main.c
> +++ b/security/digest_cache/main.c
> @@ -169,6 +169,11 @@ struct digest_cache *digest_cache_create(struct dent=
ry *dentry,
> =20
>  	/* Serialize check and assignment of dig_owner. */
>  	mutex_lock(&dig_sec->dig_owner_mutex);
> +	if (dig_sec->dig_owner && test_bit(RESET, &dig_sec->dig_owner->flags)) =
{
> +		digest_cache_put(dig_sec->dig_owner);
> +		dig_sec->dig_owner =3D NULL;
> +	}
> +
>  	if (dig_sec->dig_owner) {
>  		/* Increment ref. count for reference returned to the caller. */
>  		digest_cache =3D digest_cache_ref(dig_sec->dig_owner);
> @@ -403,6 +408,13 @@ struct digest_cache *digest_cache_get(struct dentry =
*dentry)
> =20
>  	/* Serialize accesses to inode for which the digest cache is used. */
>  	mutex_lock(&dig_sec->dig_user_mutex);
> +	if (dig_sec->dig_user &&
> +	    (test_bit(RESET, &dig_sec->dig_user->flags) ||
> +	     test_bit(RESET_USER, &dig_sec->dig_user->flags))) {
> +		digest_cache_put(dig_sec->dig_user);
> +		dig_sec->dig_user =3D NULL;
> +	}
> +
>  	if (!dig_sec->dig_user) {
>  		down_read(&default_path_sem);
>  		/* Consume extra reference from digest_cache_create(). */
> @@ -491,6 +503,13 @@ static void digest_cache_inode_free_security(struct =
inode *inode)
>  static struct security_hook_list digest_cache_hooks[] __ro_after_init =
=3D {
>  	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
>  	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
> +	LSM_HOOK_INIT(path_truncate, digest_cache_path_truncate),
> +	LSM_HOOK_INIT(file_release, digest_cache_file_release),
> +	LSM_HOOK_INIT(inode_unlink, digest_cache_inode_unlink),
> +	LSM_HOOK_INIT(inode_rename, digest_cache_inode_rename),
> +	LSM_HOOK_INIT(inode_post_setxattr, digest_cache_inode_post_setxattr),
> +	LSM_HOOK_INIT(inode_post_removexattr,
> +		      digest_cache_inode_post_removexattr),
>  };
> =20
>  /**
> diff --git a/security/digest_cache/reset.c b/security/digest_cache/reset.=
c
> new file mode 100644
> index 000000000000..e07222b0e0e8
> --- /dev/null
> +++ b/security/digest_cache/reset.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Reset digest cache on digest lists/directory modifications.
> + */
> +
> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
> +#include "internal.h"
> +
> +/**
> + * digest_cache_reset_owner - Reset dig_owner
> + * @inode: Inode of the digest list/directory containing the digest list
> + * @reason: Reason for reset
> + *
> + * This function sets the RESET bit of the digest cache pointed to by di=
g_owner
> + * (if unset), so that digest_cache_get() and digest_cache_create() resp=
ectively
> + * release and clear dig_user and dig_owner in the inode security blob. =
This
> + * causes new callers of digest_cache_get() to get a new digest cache.
> + */
> +static void digest_cache_reset_owner(struct inode *inode, const char *re=
ason)
> +{
> +	struct digest_cache_security *dig_sec;
> +
> +	dig_sec =3D digest_cache_get_security(inode);
> +	if (unlikely(!dig_sec))
> +		return;
> +
> +	mutex_lock(&dig_sec->dig_owner_mutex);
> +	if (dig_sec->dig_owner &&
> +	    !test_and_set_bit(RESET, &dig_sec->dig_owner->flags))
> +		pr_debug("Resetting %s (dig_owner), reason: %s\n",
> +			 dig_sec->dig_owner->path_str, reason);
> +	mutex_unlock(&dig_sec->dig_owner_mutex);
> +}
> +
> +/**
> + * digest_cache_reset_user - Reset dig_user
> + * @inode: Inode of the file using the digest cache
> + * @reason: Reason for reset
> + *
> + * This function sets the RESET_USER bit (if unset), so that digest_cach=
e_get()
> + * clears the dig_user pointer in the inode security blob and determines=
 again
> + * the digest list inode to get a digest cache from.
> + */
> +static void digest_cache_reset_user(struct inode *inode, const char *rea=
son)
> +{
> +	struct digest_cache_security *dig_sec;
> +
> +	dig_sec =3D digest_cache_get_security(inode);
> +	if (unlikely(!dig_sec))
> +		return;
> +
> +	mutex_lock(&dig_sec->dig_user_mutex);
> +	if (dig_sec->dig_user &&
> +	    !test_and_set_bit(RESET_USER, &dig_sec->dig_user->flags))
> +		pr_debug("Resetting %s (dig_user), reason: %s\n",
> +			 dig_sec->dig_user->path_str, reason);
> +	mutex_unlock(&dig_sec->dig_user_mutex);
> +}
> +
> +/**
> + * digest_cache_path_truncate - A file is being truncated
> + * @path: File path
> + *
> + * This function is called when a file is being truncated. If the inode =
is a
> + * digest list, it resets the inode dig_owner, to force rebuilding the d=
igest
> + * cache.
> + *
> + * Return: Zero.
> + */
> +int digest_cache_path_truncate(const struct path *path)
> +{
> +	struct inode *inode =3D d_backing_inode(path->dentry);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	digest_cache_reset_owner(inode, "file_truncate");
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_file_release - Last reference of a file desc is being re=
leased
> + * @file: File descriptor
> + *
> + * This function is called when the last reference of a file descriptor =
is
> + * being released. If the inode is a regular file and was opened for wri=
te, or
> + * the parent inode is the digest list directory and the file was create=
d, it
> + * resets the inode dig_owner, to force rebuilding the digest cache.
> + */
> +void digest_cache_file_release(struct file *file)
> +{
> +	struct inode *dir =3D d_backing_inode(file_dentry(file)->d_parent);
> +
> +	if (!S_ISREG(file_inode(file)->i_mode) || !(file->f_mode & FMODE_WRITE)=
)
> +		return;
> +
> +	digest_cache_reset_owner(file_inode(file), "file_file_release");
> +	if (file->f_mode & FMODE_CREATED)
> +		digest_cache_reset_owner(dir, "dir_file_release");
> +}
> +
> +/**
> + * digest_cache_inode_unlink - An inode is being removed
> + * @dir: Inode of the affected directory
> + * @dentry: Dentry of the inode being removed
> + *
> + * This function is called when an existing inode is being removed. If t=
he
> + * inode is a digest list, or the parent inode is the digest list direct=
ory and
> + * the inode is a regular file, it resets the affected inode dig_owner, =
to force
> + * rebuilding the digest cache.
> + *
> + * Return: Zero.
> + */
> +int digest_cache_inode_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct inode *inode =3D d_backing_inode(dentry);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return 0;
> +
> +	digest_cache_reset_owner(inode, "file_unlink");
> +	digest_cache_reset_owner(dir, "dir_unlink");
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_inode_rename - An inode is being renamed
> + * @old_dir: Inode of the directory containing the inode being renamed
> + * @old_dentry: Dentry of the inode being renamed
> + * @new_dir: Directory where the inode will be placed into
> + * @new_dentry: Dentry of the inode after being renamed
> + *
> + * This function is called when an existing inode is being moved from a
> + * directory to another (rename). If the inode is a digest list, or that=
 inode
> + * is moved from/to the digest list directory, it resets the affected in=
ode
> + * dig_owner, to force rebuilding the digest cache.
> + *
> + * Return: Zero.
> + */
> +int digest_cache_inode_rename(struct inode *old_dir, struct dentry *old_=
dentry,
> +			      struct inode *new_dir, struct dentry *new_dentry)
> +{
> +	struct inode *old_inode =3D d_backing_inode(old_dentry);
> +
> +	if (!S_ISREG(old_inode->i_mode))
> +		return 0;
> +
> +	digest_cache_reset_owner(old_inode, "file_rename");
> +	digest_cache_reset_owner(old_dir, "dir_rename_from");
> +	digest_cache_reset_owner(new_dir, "dir_rename_to");
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_inode_post_setxattr() - An xattr was set
> + * @dentry: file
> + * @name: xattr name
> + * @value: xattr value
> + * @size: size of xattr value
> + * @flags: flags
> + *
> + * This function is called after an xattr was set on an existing inode. =
If the
> + * inode points to a digest cache and the xattr set is security.digest_l=
ist, it
> + * resets dig_user in the inode security blob, to force retrieving a fre=
sh
> + * digest cache.
> + */
> +void digest_cache_inode_post_setxattr(struct dentry *dentry, const char =
*name,
> +				      const void *value, size_t size, int flags)
> +{
> +	if (strcmp(name, XATTR_NAME_DIGEST_LIST))
> +		return;
> +
> +	digest_cache_reset_user(d_backing_inode(dentry), "file_setxattr");
> +}
> +
> +/**
> + * digest_cache_inode_post_removexattr() - An xattr was removed
> + * @dentry: file
> + * @name: xattr name
> + *
> + * This function is called after an xattr was removed from an existing i=
node.
> + * If the inode points to a digest cache and the xattr removed is
> + * security.digest_list, it resets dig_user in the inode security blob, =
to
> + * force retrieving a fresh digest cache.
> + */
> +void digest_cache_inode_post_removexattr(struct dentry *dentry,
> +					 const char *name)

nit:

void digest_cache_inode_post_removexattr(struct dentry *dentry, const char =
*name)

would be fine too

> +{
> +	if (strcmp(name, XATTR_NAME_DIGEST_LIST))
> +		return;
> +
> +	digest_cache_reset_user(d_backing_inode(dentry), "file_removexattr");
> +}


BR, Jarkko

