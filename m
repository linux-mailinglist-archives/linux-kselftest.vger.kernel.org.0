Return-Path: <linux-kselftest+bounces-8026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128228A5B5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF75288AE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D49158875;
	Mon, 15 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZytW0oE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF515575F;
	Mon, 15 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209989; cv=none; b=oMhZnE/rx5puJrlJWV7GAnOOvmwTxiYoiQA0NBZjWmh5PGC6zrCWBKJsLzGnlE5B4985Ri2/qdzm5UaaOI+t4exQJJ9Y36zCYqQshm0O0UlPWpv//2ENPYTYL+3ToXLgonLlJwJXSmcJZfGEoEFXYe0zGoBWkIhrmFjwQQgEqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209989; c=relaxed/simple;
	bh=B2rrTSLf/yO4n0yVmhQnML5N6isc00kk9QweZdFKH2A=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Z5fCB8MAwyAx/c/YSSj8GMqIBbcbXx8pnbqlSItIxHvo/CLcoueU2P97JZUpfSPc7Vyui3aq5f2W9/wEKMP0sL01T8ozlpC20QdoC4XD98rGXSIbMSWS9M3zE6Wm60WVwsOihFLKub3fIgnnGq+OdJd4AdojSC9cOO/67hj5nIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZytW0oE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC0EC113CC;
	Mon, 15 Apr 2024 19:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209989;
	bh=B2rrTSLf/yO4n0yVmhQnML5N6isc00kk9QweZdFKH2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZytW0oE4MUiGy/aESrfmLsUbpKd+r6vdko71Xa6INXsB7OSkbUDgtkvWCkJUvguf
	 yTUcaOj+Qeag7kASaf24nHHdLPBCGC3Rq5nxd4HiEs2+tPhsBtA+XZ/6JdRot5ao74
	 U46y3E23K8/G56GXOUVCzQAHXkK1MEjg95CkE9dQ6ywzGrOgcVt88YEs42ukhzqgMF
	 RQkwwVMb66VOWeQ1eNO2tg6bT6hyEfR3ROXbtGeKn5PBXliYoGCSdNZn5wUKbIKyoU
	 AcaY7vrDAF31XqU4KsLxVf+1nvl7MRDv56XaJDK03KtUn8mUCbETgWD4sAekUkJVAd
	 UcvhW6AkgftlA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:39:40 +0300
Message-Id: <D0KY93YU8UHT.1B9WG77UEFRX5@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 09/14] digest_cache: Add support for directories
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-10-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-10-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> In the environments where xattrs are not available (e.g. in the initial r=
am
> disk), the digest_cache LSM cannot precisely determine which digest list =
in
> a directory contains the desired reference digest. However, although
> slower, it would be desirable to search the digest in all digest lists of
> that directory.
>
> This done in two steps. When a digest cache is being created,
> digest_cache_create() invokes digest_cache_dir_create(), to generate the
> list of current directory entries. Entries are placed in the list in
> ascending order by the <seq num> if prepended to the file name, or at the
> end of the list if not.
>
> The resulting digest cache has the IS_DIR bit set, to distinguish it from
> the digest caches created from regular files.
>
> Second, when a digest is searched in a directory digest cache,
> digest_cache_lookup() invokes digest_cache_dir_lookup_digest() to
> iteratively search that digest in each directory entry generated by
> digest_cache_dir_create().
>
> That list is stable, even if new files are added or deleted from that
> directory. A subsequent patch will invalidate the digest cache, forcing
> next callers of digest_cache_get() to get a new directory digest cache wi=
th
> the updated list of directory entries.
>
> If the current directory entry does not have a digest cache reference,
> digest_cache_dir_lookup_digest() invokes digest_cache_create() to create =
a
> new digest cache for that entry. In either case,
> digest_cache_dir_lookup_digest() calls then digest_cache_htable_lookup()
> with the new/existing digest cache to search the digest. Check and
> assignment of the digest cache in a directory entry is protected by the
> per entry digest_cache_mutex.
>
> The iteration stops when the digest is found. In that case,
> digest_cache_dir_lookup_digest() returns the digest cache reference of th=
e
> current directory entry as the digest_cache_found_t type, so that callers
> of digest_cache_lookup() don't mistakenly try to call digest_cache_put()
> with that reference.
>
> This new reference type will be used to retrieve information about the
> digest cache containing the digest, which is not known in advance until t=
he
> digest search is performed.
>
> The order of the list of directory entries influences the speed of the
> digest search. A search terminates faster if less digest caches have to b=
e
> created. One way to optimize it could be to order the list of digest list=
s
> in the same way of when they are requested at boot.
>
> Finally, digest_cache_dir_free() releases the digest cache references
> stored in the list of directory entries, and frees the list itself.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/digest_cache/Makefile   |   2 +-
>  security/digest_cache/dir.c      | 193 +++++++++++++++++++++++++++++++
>  security/digest_cache/htable.c   |  22 +++-
>  security/digest_cache/internal.h |  45 +++++++
>  security/digest_cache/main.c     |  12 ++
>  5 files changed, 271 insertions(+), 3 deletions(-)
>  create mode 100644 security/digest_cache/dir.c
>
> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makef=
ile
> index 37a473c7bc28..e417da0383ab 100644
> --- a/security/digest_cache/Makefile
> +++ b/security/digest_cache/Makefile
> @@ -4,7 +4,7 @@
> =20
>  obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> =20
> -digest_cache-y :=3D main.o secfs.o htable.o populate.o modsig.o verif.o
> +digest_cache-y :=3D main.o secfs.o htable.o populate.o modsig.o verif.o =
dir.o
> =20
>  digest_cache-y +=3D parsers/tlv.o
>  digest_cache-y +=3D parsers/rpm.o
> diff --git a/security/digest_cache/dir.c b/security/digest_cache/dir.c
> new file mode 100644
> index 000000000000..7bfcdd5f7ef1
> --- /dev/null
> +++ b/security/digest_cache/dir.c
> @@ -0,0 +1,193 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Manage digest caches from directories.
> + */
> +
> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
> +#include <linux/init_task.h>
> +
> +#include "internal.h"
> +
> +/**
> + * digest_cache_dir_iter - Digest cache directory iterator
> + * @__ctx: iterate_dir() context
> + * @name: Name of file in the accessed directory
> + * @namelen: String length of @name
> + * @offset: Current position in the directory stream (see man readdir)
> + * @ino: Inode number
> + * @d_type: File type
> + *
> + * This function stores the names of the files in the containing directo=
ry in
> + * a linked list. If they are in the format <seq num>-<format>-<name>, t=
his
> + * function orders them by seq num, so that digest lists are processed i=
n the
> + * desired order. Otherwise, if <seq num>- is not included, it adds the =
name at
> + * the end of the list.
> + *
> + * Return: True to continue processing, false to stop.
> + */
> +static bool digest_cache_dir_iter(struct dir_context *__ctx, const char =
*name,
> +				  int namelen, loff_t offset, u64 ino,
> +				  unsigned int d_type)
> +{
> +	struct readdir_callback *ctx =3D container_of(__ctx, typeof(*ctx), ctx)=
;
> +	struct dir_entry *new_entry, *p;
> +	unsigned int seq_num;
> +	char *separator;
> +	int ret;
> +
> +	if (!strcmp(name, ".") || !strcmp(name, ".."))
> +		return true;
> +
> +	if (d_type !=3D DT_REG)
> +		return true;
> +
> +	new_entry =3D kmalloc(sizeof(*new_entry) + namelen + 1, GFP_KERNEL);
> +	if (!new_entry)
> +		return false;
> +
> +	memcpy(new_entry->name, name, namelen);
> +	new_entry->name[namelen] =3D '\0';
> +	new_entry->seq_num =3D UINT_MAX;
> +	new_entry->digest_cache =3D NULL;
> +	mutex_init(&new_entry->digest_cache_mutex);
> +
> +	if (new_entry->name[0] < '0' || new_entry->name[0] > '9')
> +		goto out;
> +
> +	separator =3D strchr(new_entry->name, '-');
> +	if (!separator)
> +		goto out;
> +
> +	*separator =3D '\0';
> +	ret =3D kstrtouint(new_entry->name, 10, &seq_num);
> +	*separator =3D '-';
> +	if (ret < 0)
> +		goto out;
> +
> +	new_entry->seq_num =3D seq_num;
> +
> +	list_for_each_entry(p, ctx->head, list) {
> +		if (seq_num <=3D p->seq_num) {
> +			list_add(&new_entry->list, p->list.prev);
> +			pr_debug("Added %s before %s in dir list\n",
> +				 new_entry->name, p->name);
> +			return true;
> +		}
> +	}
> +out:
> +	list_add_tail(&new_entry->list, ctx->head);
> +	pr_debug("Added %s to tail of dir list\n", new_entry->name);
> +	return true;
> +}
> +
> +/**
> + * digest_cache_dir_create - Create a directory digest cache
> + * @digest_cache: Digest cache
> + * @digest_list_path: Path structure of the digest list directory
> + *
> + * This function iterates over the entries of a directory, and creates a=
 linked
> + * list of file names from that directory.
> + *
> + * Return: Zero on success, a POSIX error code otherwise.
> + */
> +int digest_cache_dir_create(struct digest_cache *digest_cache,
> +			    struct path *digest_list_path)
> +{
> +	struct file *dir_file;
> +	struct readdir_callback buf =3D {
> +		.ctx.actor =3D digest_cache_dir_iter,
> +	};
> +	int ret;
> +
> +	dir_file =3D dentry_open(digest_list_path, O_RDONLY, &init_cred);
> +	if (IS_ERR(dir_file)) {
> +		pr_debug("Cannot access %s, ret: %ld\n", digest_cache->path_str,
> +			 PTR_ERR(dir_file));
> +		return PTR_ERR(dir_file);
> +	}
> +
> +	buf.head =3D &digest_cache->dir_entries;
> +	ret =3D iterate_dir(dir_file, &buf.ctx);
> +	if (ret < 0)
> +		pr_debug("Failed to iterate directory %s\n",
> +			 digest_cache->path_str);
> +
> +	fput(dir_file);
> +	return ret;
> +}
> +
> +/**
> + * digest_cache_dir_lookup_digest - Lookup a digest
> + * @dentry: Dentry of the file whose digest is looked up
> + * @digest_list_path: Path structure of the digest list directory
> + * @digest_cache: Digest cache
> + * @digest: Digest to search
> + * @algo: Algorithm of the digest to search
> + *
> + * This function iterates over the linked list created by
> + * digest_cache_dir_create() and looks up the digest in the digest cache=
 of
> + * each entry.
> + *
> + * Return: A digest_cache_found_t value if the digest if found, zero oth=
erwise.
> + */
> +digest_cache_found_t
> +digest_cache_dir_lookup_digest(struct dentry *dentry,
> +			       struct path *digest_list_path,
> +			       struct digest_cache *digest_cache, u8 *digest,
> +			       enum hash_algo algo)
> +{
> +	struct digest_cache *cache;
> +	struct dir_entry *dir_entry;
> +	int ret;
> +
> +	list_for_each_entry(dir_entry, &digest_cache->dir_entries, list) {
> +		mutex_lock(&dir_entry->digest_cache_mutex);
> +		if (!dir_entry->digest_cache) {
> +			cache =3D digest_cache_create(dentry, digest_list_path,
> +						    digest_cache->path_str,
> +						    dir_entry->name);
> +			/* Ignore digest caches that cannot be instantiated. */
> +			if (!cache) {
> +				mutex_unlock(&dir_entry->digest_cache_mutex);
> +				continue;
> +			}
> +
> +			/* Consume extra ref. from digest_cache_create(). */
> +			dir_entry->digest_cache =3D cache;
> +		}
> +		mutex_unlock(&dir_entry->digest_cache_mutex);
> +
> +		ret =3D digest_cache_htable_lookup(dentry,
> +						 dir_entry->digest_cache,
> +						 digest, algo);
> +		if (!ret)
> +			return (digest_cache_found_t)dir_entry->digest_cache;
> +	}
> +
> +	return 0UL;
> +}
> +
> +/**
> + * digest_cache_dir_free - Free the stored file list and put digest cach=
es
> + * @digest_cache: Digest cache
> + *
> + * This function frees the file list created by digest_cache_create(), a=
nd puts
> + * the digest cache if a reference exists.
> + */
> +void digest_cache_dir_free(struct digest_cache *digest_cache)
> +{
> +	struct dir_entry *p, *q;
> +
> +	list_for_each_entry_safe(p, q, &digest_cache->dir_entries, list) {
> +		if (p->digest_cache)
> +			digest_cache_put(p->digest_cache);
> +
> +		list_del(&p->list);
> +		mutex_destroy(&p->digest_cache_mutex);
> +		kfree(p);
> +	}
> +}
> diff --git a/security/digest_cache/htable.c b/security/digest_cache/htabl=
e.c
> index d2d5d8f5e5b1..8cf7400dfcf4 100644
> --- a/security/digest_cache/htable.c
> +++ b/security/digest_cache/htable.c
> @@ -8,6 +8,8 @@
>   */
> =20
>  #define pr_fmt(fmt) "DIGEST CACHE: "fmt
> +#include <linux/namei.h>
> +
>  #include "internal.h"
> =20
>  /**
> @@ -210,10 +212,26 @@ digest_cache_found_t digest_cache_lookup(struct den=
try *dentry,
>  					 struct digest_cache *digest_cache,
>  					 u8 *digest, enum hash_algo algo)
>  {
> +	struct path digest_list_path;
> +	digest_cache_found_t found;
>  	int ret;
> =20
> -	ret =3D digest_cache_htable_lookup(dentry, digest_cache, digest, algo);
> -	return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;
> +	if (!test_bit(IS_DIR, &digest_cache->flags)) {
> +		ret =3D digest_cache_htable_lookup(dentry, digest_cache, digest,
> +						 algo);
> +		return (!ret) ? (digest_cache_found_t)digest_cache : 0UL;

s/(!ret)/!ret/

I'd consider tho just use plain if-statement, ternary operator is best
to be avoided other than macros

> +	}
> +
> +	ret =3D kern_path(digest_cache->path_str, 0, &digest_list_path);
> +	if (ret < 0) {
> +		pr_debug("Cannot find path %s\n", digest_cache->path_str);
> +		return 0UL;
> +	}
> +
> +	found =3D digest_cache_dir_lookup_digest(dentry, &digest_list_path,
> +					       digest_cache, digest, algo);
> +	path_put(&digest_list_path);
> +	return found;
>  }
>  EXPORT_SYMBOL_GPL(digest_cache_lookup);
> =20
> diff --git a/security/digest_cache/internal.h b/security/digest_cache/int=
ernal.h
> index 4929d25e7972..b7afca8e04da 100644
> --- a/security/digest_cache/internal.h
> +++ b/security/digest_cache/internal.h
> @@ -16,6 +16,39 @@
>  /* Digest cache bits in flags. */
>  #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
>  #define INVALID			1	/* Digest cache marked as invalid. */
> +#define IS_DIR			2	/* Digest cache created from dir. */
> +
> +/**
> + * struct readdir_callback - Structure to store information for dir iter=
ation
> + * @ctx: Context structure
> + * @head: Head of linked list of directory entries
> + *
> + * This structure stores information to be passed from the iterate_dir()=
 caller
> + * to the directory iterator.
> + */
> +struct readdir_callback {
> +	struct dir_context ctx;
> +	struct list_head *head;
> +};
> +
> +/**
> + * struct dir_entry - Directory entry
> + * @list: Linked list of directory entries
> + * @digest_cache: Digest cache associated to the directory entry
> + * @digest_cache_mutex: Protects @digest_cache
> + * @seq_num: Sequence number of the directory entry from file name
> + * @name: File name of the directory entry
> + *
> + * This structure represents a directory entry with a digest cache creat=
ed
> + * from that entry.
> + */
> +struct dir_entry {
> +	struct list_head list;
> +	struct digest_cache *digest_cache;
> +	struct mutex digest_cache_mutex;
> +	unsigned int seq_num;
> +	char name[];
> +} __packed;
> =20
>  /**
>   * struct digest_cache_verif
> @@ -83,6 +116,7 @@ struct htable {
>  /**
>   * struct digest_cache - Digest cache
>   * @htables: Hash tables (one per algorithm)
> + * @dir_entries: List of files in a directory and the digest cache
>   * @ref_count: Number of references to the digest cache
>   * @path_str: Path of the digest list the digest cache was created from
>   * @flags: Control flags
> @@ -93,6 +127,7 @@ struct htable {
>   */
>  struct digest_cache {
>  	struct list_head htables;
> +	struct list_head dir_entries;
>  	atomic_t ref_count;
>  	char *path_str;
>  	unsigned long flags;
> @@ -193,4 +228,14 @@ size_t digest_cache_strip_modsig(__u8 *data, size_t =
data_len);
>  /* verif.c */
>  void digest_cache_verif_free(struct digest_cache *digest_cache);
> =20
> +/* dir.c */
> +int digest_cache_dir_create(struct digest_cache *digest_cache,
> +			    struct path *digest_list_path);
> +digest_cache_found_t
> +digest_cache_dir_lookup_digest(struct dentry *dentry,
> +			       struct path *digest_list_path,
> +			       struct digest_cache *digest_cache, u8 *digest,
> +			       enum hash_algo algo);
> +void digest_cache_dir_free(struct digest_cache *digest_cache);
> +
>  #endif /* _DIGEST_CACHE_INTERNAL_H */
> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
> index f3475b36e566..15f1486610a3 100644
> --- a/security/digest_cache/main.c
> +++ b/security/digest_cache/main.c
> @@ -50,6 +50,7 @@ static struct digest_cache *digest_cache_alloc_init(cha=
r *path_str,
>  	digest_cache->flags =3D 0UL;
>  	INIT_LIST_HEAD(&digest_cache->htables);
>  	INIT_LIST_HEAD(&digest_cache->verif_data);
> +	INIT_LIST_HEAD(&digest_cache->dir_entries);
>  	mutex_init(&digest_cache->mutex);
> =20
>  	pr_debug("New digest cache %s (ref count: %d)\n",
> @@ -68,6 +69,7 @@ static void digest_cache_free(struct digest_cache *dige=
st_cache)
>  {
>  	digest_cache_htable_free(digest_cache);
>  	digest_cache_verif_free(digest_cache);
> +	digest_cache_dir_free(digest_cache);
>  	mutex_destroy(&digest_cache->mutex);
> =20
>  	pr_debug("Freed digest cache %s\n", digest_cache->path_str);
> @@ -185,6 +187,16 @@ struct digest_cache *digest_cache_create(struct dent=
ry *dentry,
>  			/* Prevent usage of partially-populated digest cache. */
>  			set_bit(INVALID, &digest_cache->flags);
>  		}
> +	} else if (S_ISDIR(inode->i_mode)) {
> +		set_bit(IS_DIR, &dig_sec->dig_owner->flags);
> +
> +		ret =3D digest_cache_dir_create(digest_cache, digest_list_path);
> +		if (ret < 0) {
> +			pr_debug("Failed to create dir digest cache, ret: %d (keep digest cac=
he)\n",
> +				 ret);
> +			/* Prevent usage of partially-populated digest cache. */
> +			set_bit(INVALID, &dig_sec->dig_owner->flags);
> +		}
>  	}
> =20
>  	/* Creation complete, notify the other lock contenders. */


BR, Jarkko

