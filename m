Return-Path: <linux-kselftest+bounces-8023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE48A5A8B
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B922B219A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC084156255;
	Mon, 15 Apr 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDV5CSfE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C5155A27;
	Mon, 15 Apr 2024 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209469; cv=none; b=bhioTDCKdGT+C4ovXFMBbMAxkkWt6uHRP97/kv6nRmURZa+02Pck2Qre4+dAS6AOlUEosSRelbW88H5PV0qIKdlr1BtiiAOrGIt1hutm+tigA8JMj9dyNlZ1skC+LJ5wh46du6w3loHboOdrUQCkPDJXIWNjTdCJM5wyqKBKT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209469; c=relaxed/simple;
	bh=0BFk36JPOYr+jS2Jvsedu4hhRnXQizaVPCnZMu198Ms=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FNP85zjFQ+fyyyJ3qrmKTB7mXC7LLx6DjoHvsYpFlWQQBIHKCfXMLoNrZqov4ChCnCGe/ShZ5WnMzziibGMwLtJghnzF7jw1mUFwwhM/3PyjnrOVg+nc2hmFD/injo5iP9Qhmxg3s1XGM3AnpZkkNJ/FN0A0y3UuyKTBddobrm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDV5CSfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D28C32786;
	Mon, 15 Apr 2024 19:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209469;
	bh=0BFk36JPOYr+jS2Jvsedu4hhRnXQizaVPCnZMu198Ms=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sDV5CSfEzdXGup8KVGQ+8/vLsrYoV3czbyv9sz9bi6yqxqd6/HGXgm2NCDrNGLFgS
	 Zl8TT+85NV8FOD2g62a7rXZEw0klQ8KSI0QY+Xp4A1STNtrGFOrHk9wKOCqqMuVgIw
	 HofR4F7DSDfZ1gsc3VXofbttoUc+CYPHmPPNmy6kwKr6bs4qxMwsPyFEeIGy0wxZvk
	 y0/Rz+x5rxqRahrmLj+Opq/JFemiS7i9B7kix927ZVR6uflTOK5hjy8Y+BSReuj6Jh
	 IlLEbzFnjnfX7MvtBd4NowmpTdzbaDbcSCIggXJrIeZbGcdAcDKAVgSGjrnaTB5AXq
	 BaAxTJo/Wvn1Q==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:31:01 +0300
Message-Id: <D0KY2HE7TMDH.2X3BQUDMRK17U@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 02/14] security: Introduce the digest_cache LSM
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-3-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the digest_cache LSM, to collect digests from various sources
> (called digest lists), and to store them in kernel memory, in a set of ha=
sh
> tables forming a digest cache. Extracted digests can be used as reference
> values for integrity verification of file data or metadata.
>
> A digest cache has three types of references: in the inode security blob =
of
> the digest list the digest cache was created from (dig_owner field); in t=
he
> security blob of the inodes for which the digest cache is requested
> (dig_user field); a reference returned by digest_cache_get().
>
> References are released with digest_cache_put(), in the first two cases
> when inodes are evicted from memory, in the last case when that function =
is
> explicitly called. Obtaining a digest cache reference means that the dige=
st
> cache remains valid and cannot be freed until releasing it and until the
> total number of references (stored in the digest cache) becomes zero.
>
> When digest_cache_get() is called on an inode to compare its digest with
> a reference value, the digest_cache LSM knows which digest cache to get
> from the new security.digest_list xattr added to that inode, which contai=
ns
> the file name of the desired digest list digests will be extracted from.
>
> All digest lists are expected to be in the same directory, defined in the
> kernel config, and modifiable (with a later patch) at run-time through
> securityfs. When the digest_cache LSM reads the security.digest_list xatt=
r,
> it uses its value as last path component, appended to the default path
> (unless the default path is a file). If an inode does not have that xattr=
,
> the default path is considered as the final destination.
>
> The default path can be either a file or a directory. If it is a file, th=
e
> digest_cache LSM always uses the same digest cache from that file to veri=
fy
> all inodes (the xattr, if present, is ignored). If it is a directory, and
> the inode to verify does not have the xattr, a subsequent patch will make
> it possible to iterate and lookup on the digest caches created from each
> directory entry.
>
> Digest caches are created on demand, only when digest_cache_get() is
> called. The first time a digest cache is requested, the digest_cache LSM
> creates it and sets its reference in the dig_owner and dig_user fields of
> the respective inode security blobs. On the next requests, the previously
> set reference is returned, after incrementing the reference count.
>
> Since there might be multiple digest_cache_get() calls for the same inode=
,
> or for different inodes pointing to the same digest list, dig_owner_mutex
> and dig_user_mutex have been introduced to protect the check and assignme=
nt
> of the digest cache reference in the inode security blob.
>
> Contenders that didn't get the lock also have to wait until the digest
> cache is fully instantiated (when the bit INIT_IN_PROGRESS is cleared).
> Dig_owner_mutex cannot be used for waiting on the instantiation to avoid
> lock inversion with the inode lock for directories.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  MAINTAINERS                                   |   6 +
>  include/linux/digest_cache.h                  |  32 ++
>  include/uapi/linux/lsm.h                      |   1 +
>  include/uapi/linux/xattr.h                    |   3 +
>  security/Kconfig                              |  11 +-
>  security/Makefile                             |   1 +
>  security/digest_cache/Kconfig                 |  16 +
>  security/digest_cache/Makefile                |   7 +
>  security/digest_cache/internal.h              |  86 ++++
>  security/digest_cache/main.c                  | 404 ++++++++++++++++++
>  security/security.c                           |   3 +-
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  12 files changed, 567 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/digest_cache.h
>  create mode 100644 security/digest_cache/Kconfig
>  create mode 100644 security/digest_cache/Makefile
>  create mode 100644 security/digest_cache/internal.h
>  create mode 100644 security/digest_cache/main.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b1ca23ab8732..72801a88449c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6193,6 +6193,12 @@ L:	linux-gpio@vger.kernel.org
>  S:	Maintained
>  F:	drivers/gpio/gpio-gpio-mm.c
> =20
> +DIGEST_CACHE LSM
> +M:	Roberto Sassu <roberto.sassu@huawei.com>
> +L:	linux-security-module@vger.kernel.org
> +S:	Maintained
> +F:	security/digest_cache/
> +
>  DIGITEQ AUTOMOTIVE MGB4 V4L2 DRIVER
>  M:	Martin Tuma <martin.tuma@digiteqautomotive.com>
>  L:	linux-media@vger.kernel.org

Nit: afaik, MAINTAINER updates should be split.

> diff --git a/include/linux/digest_cache.h b/include/linux/digest_cache.h
> new file mode 100644
> index 000000000000..e79f94a60b0f
> --- /dev/null
> +++ b/include/linux/digest_cache.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>

Nit: Git has an author field in commit granularity so adding author
fields to files is sort of old world.

> + *
> + * Public API of the digest_cache LSM.
> + */
> +
> +#ifndef _LINUX_DIGEST_CACHE_H
> +#define _LINUX_DIGEST_CACHE_H
> +
> +#include <linux/fs.h>
> +
> +struct digest_cache;

Is this declaration necessary?

I don't think you need forward declaration here as this does compile:

#include <stdio.h>

struct digest_cache *digest_cache_get(void)
{
        return NULL;
}

int main(void)
{
        return (long)digest_cache_get();
}


> +
> +#ifdef CONFIG_SECURITY_DIGEST_CACHE
> +struct digest_cache *digest_cache_get(struct dentry *dentry);
> +void digest_cache_put(struct digest_cache *digest_cache);
> +
> +#else
> +static inline struct digest_cache *digest_cache_get(struct dentry *dentr=
y)
> +{
> +	return NULL;
> +}
> +
> +static inline void digest_cache_put(struct digest_cache *digest_cache)
> +{
> +}
> +
> +#endif /* CONFIG_SECURITY_DIGEST_CACHE */
> +#endif /* _LINUX_DIGEST_CACHE_H */
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 33d8c9f4aa6b..832b3aea5c26 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -64,6 +64,7 @@ struct lsm_ctx {
>  #define LSM_ID_LANDLOCK		110
>  #define LSM_ID_IMA		111
>  #define LSM_ID_EVM		112
> +#define LSM_ID_DIGEST_CACHE	113
> =20
>  /*
>   * LSM_ATTR_XXX definitions identify different LSM attributes
> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
> index 9463db2dfa9d..8a58cf4bce65 100644
> --- a/include/uapi/linux/xattr.h
> +++ b/include/uapi/linux/xattr.h
> @@ -54,6 +54,9 @@
>  #define XATTR_IMA_SUFFIX "ima"
>  #define XATTR_NAME_IMA XATTR_SECURITY_PREFIX XATTR_IMA_SUFFIX
> =20
> +#define XATTR_DIGEST_LIST_SUFFIX "digest_list"
> +#define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_S=
UFFIX
> +
>  #define XATTR_SELINUX_SUFFIX "selinux"
>  #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
> =20
> diff --git a/security/Kconfig b/security/Kconfig
> index 52c9af08ad35..99f99cbd94cc 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -194,6 +194,7 @@ source "security/yama/Kconfig"
>  source "security/safesetid/Kconfig"
>  source "security/lockdown/Kconfig"
>  source "security/landlock/Kconfig"
> +source "security/digest_cache/Kconfig"
> =20
>  source "security/integrity/Kconfig"
> =20
> @@ -233,11 +234,11 @@ endchoice
> =20
>  config LSM
>  	string "Ordered list of enabled LSMs"
> -	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,=
apparmor,bpf" if DEFAULT_SECURITY_SMACK
> -	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smac=
k,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> -	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf" if DEFAUL=
T_SECURITY_TOMOYO
> -	default "landlock,lockdown,yama,loadpin,safesetid,bpf" if DEFAULT_SECUR=
ITY_DAC
> -	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,=
apparmor,bpf"
> +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,smack,se=
linux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,apparmor=
,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,tomoyo,b=
pf" if DEFAULT_SECURITY_TOMOYO
> +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,bpf" if =
DEFAULT_SECURITY_DAC
> +	default "digest_cache,landlock,lockdown,yama,loadpin,safesetid,selinux,=
smack,tomoyo,apparmor,bpf"
>  	help
>  	  A comma-separated list of LSMs, in initialization order.
>  	  Any LSMs left off this list, except for those with order
> diff --git a/security/Makefile b/security/Makefile
> index 59f238490665..e9b43e7b715a 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+=3D lockdown/
>  obj-$(CONFIG_CGROUPS)			+=3D device_cgroup.o
>  obj-$(CONFIG_BPF_LSM)			+=3D bpf/
>  obj-$(CONFIG_SECURITY_LANDLOCK)		+=3D landlock/
> +obj-$(CONFIG_SECURITY_DIGEST_CACHE)	+=3D digest_cache/
> =20
>  # Object integrity file lists
>  obj-$(CONFIG_INTEGRITY)			+=3D integrity/
> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfi=
g
> new file mode 100644
> index 000000000000..e53fbf0779d6
> --- /dev/null
> +++ b/security/digest_cache/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config SECURITY_DIGEST_CACHE
> +	bool "Digest_cache LSM"
> +	default n
> +	help
> +	  This option enables an LSM maintaining a cache of digests
> +	  (e.g. of file data or metadata).
> +
> +	  This LSM can support other kernel components in making access
> +	  control decisions.
> +
> +config DIGEST_LIST_DEFAULT_PATH
> +	string
> +	default "/etc/digest_lists"
> +	help
> +	  Default directory where digest_cache LSM expects to find digest lists=
.
> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makef=
ile
> new file mode 100644
> index 000000000000..48848c41253e
> --- /dev/null
> +++ b/security/digest_cache/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for building the digest_cache LSM.
> +
> +obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> +
> +digest_cache-y :=3D main.o
> diff --git a/security/digest_cache/internal.h b/security/digest_cache/int=
ernal.h
> new file mode 100644
> index 000000000000..5f04844af3a5
> --- /dev/null
> +++ b/security/digest_cache/internal.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>

ditto

> + *
> + * Internal header of the digest_cache LSM.
> + */
> +
> +#ifndef _DIGEST_CACHE_INTERNAL_H
> +#define _DIGEST_CACHE_INTERNAL_H
> +
> +#include <linux/lsm_hooks.h>
> +#include <linux/digest_cache.h>
> +
> +/* Digest cache bits in flags. */
> +#define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
> +
> +/**
> + * struct digest_cache - Digest cache
> + * @ref_count: Number of references to the digest cache
> + * @path_str: Path of the digest list the digest cache was created from
> + * @flags: Control flags
> + *
> + * This structure represents a cache of digests extracted from a digest =
list.
> + */
> +struct digest_cache {
> +	atomic_t ref_count;
> +	char *path_str;
> +	unsigned long flags;
> +};
> +
> +/**
> + * struct digest_cache_security - Digest cache pointers in inode securit=
y blob
> + * @dig_owner: Digest cache created from this inode
> + * @dig_owner_mutex: Protects @dig_owner
> + * @dig_user: Digest cache requested for this inode
> + * @dig_user_mutex: Protects @dig_user
> + *
> + * This structure contains references to digest caches, protected by the=
ir
> + * respective mutex.
> + */
> +struct digest_cache_security {
> +	struct digest_cache *dig_owner;
> +	struct mutex dig_owner_mutex;
> +	struct digest_cache *dig_user;
> +	struct mutex dig_user_mutex;
> +};
> +
> +extern struct lsm_blob_sizes digest_cache_blob_sizes;
> +extern char *default_path_str;
> +
> +static inline struct digest_cache_security *
> +digest_cache_get_security(const struct inode *inode)
> +{
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	return inode->i_security + digest_cache_blob_sizes.lbs_inode;
> +}
> +
> +static inline struct digest_cache *
> +digest_cache_ref(struct digest_cache *digest_cache)
> +{
> +	atomic_inc(&digest_cache->ref_count);
> +	pr_debug("Ref (+) digest cache %s (ref count: %d)\n",
> +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
> +	return digest_cache;
> +}
> +
> +static inline struct digest_cache *
> +digest_cache_unref(struct digest_cache *digest_cache)
> +{
> +	bool ref_is_zero =3D atomic_dec_and_test(&digest_cache->ref_count);
> +
> +	pr_debug("Ref (-) digest cache %s (ref count: %d)\n",
> +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));
> +	return (ref_is_zero) ? digest_cache : NULL;
> +}
> +
> +/* main.c */
> +struct digest_cache *digest_cache_create(struct dentry *dentry,
> +					 struct path *digest_list_path,
> +					 char *path_str, char *filename);
> +
> +#endif /* _DIGEST_CACHE_INTERNAL_H */
> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
> new file mode 100644
> index 000000000000..14dba8915e99
> --- /dev/null
> +++ b/security/digest_cache/main.c
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement the main code of the digest_cache LSM.
> + */
> +
> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
> +#include <linux/namei.h>
> +#include <linux/xattr.h>
> +
> +#include "internal.h"
> +
> +static int digest_cache_enabled __ro_after_init =3D 1;
> +static struct kmem_cache *digest_cache_cache __read_mostly;
> +
> +char *default_path_str =3D CONFIG_DIGEST_LIST_DEFAULT_PATH;
> +
> +/**
> + * digest_cache_alloc_init - Allocate and initialize a new digest cache
> + * @path_str: Path string of the digest list
> + * @filename: Digest list file name (can be an empty string)
> + *
> + * This function allocates and initializes a new digest cache.
> + *
> + * Return: A digest_cache structure on success, NULL on error.
> + */
> +static struct digest_cache *digest_cache_alloc_init(char *path_str,
> +						    char *filename)
> +{
> +	struct digest_cache *digest_cache;
> +
> +	digest_cache =3D kmem_cache_alloc(digest_cache_cache, GFP_KERNEL);
> +	if (!digest_cache)
> +		return digest_cache;
> +
> +	digest_cache->path_str =3D kasprintf(GFP_KERNEL, "%s%s%s", path_str,
> +					   filename[0] ? "/" : "", filename);
> +	if (!digest_cache->path_str) {
> +		kmem_cache_free(digest_cache_cache, digest_cache);
> +		return NULL;
> +	}
> +
> +	atomic_set(&digest_cache->ref_count, 1);
> +	digest_cache->flags =3D 0UL;
> +
> +	pr_debug("New digest cache %s (ref count: %d)\n",
> +		 digest_cache->path_str, atomic_read(&digest_cache->ref_count));

Nit: kretprobe can be used to grab the same information easil and
do e.g. statistics and stuff like that. Traces for return values
are not very useful.


> +
> +	return digest_cache;
> +}
> +
> +/**
> + * digest_cache_free - Free all memory occupied by the digest cache
> + * @digest_cache: Digest cache
> + *
> + * This function frees the memory occupied by the digest cache.
> + */
> +static void digest_cache_free(struct digest_cache *digest_cache)
> +{
> +	pr_debug("Freed digest cache %s\n", digest_cache->path_str);

ditto for the above trace

> +	kfree(digest_cache->path_str);
> +	kmem_cache_free(digest_cache_cache, digest_cache);
> +}
> +
> +/**
> + * digest_cache_create - Create a digest cache
> + * @dentry: Dentry of the inode for which the digest cache will be used
> + * @digest_list_path: Path structure of the digest list
> + * @path_str: Path string of the digest list
> + * @filename: Digest list file name (can be an empty string)
> + *
> + * This function first locates, from the passed path, the digest list in=
ode
> + * from which the digest cache will be created or retrieved (if it alrea=
dy
> + * exists).
> + *
> + * If dig_owner is NULL in the inode security blob, this function create=
s a
> + * new digest cache with reference count set to 1 (reference returned), =
sets
> + * it to dig_owner and consequently increments again the digest cache re=
ference
> + * count.
> + *
> + * Otherwise, it simply increments the reference count of the existing
> + * dig_owner, since that reference is returned to the caller.
> + *
> + * Incrementing the reference count twice before calling path_put() ensu=
res
> + * that the digest cache returned is valid even if the inode is evicted =
from
> + * memory (which decreases the reference count).
> + *
> + * Releasing the dig_owner_mutex lock does not mean that the digest cach=
e is
> + * ready for use. digest_cache_create() callers that found a partially
> + * instantiated digest cache have to wait until the INIT_IN_PROGRESS bit=
 is
> + * cleared by the caller that is actually creating that digest cache.
> + *
> + * Return: A new digest cache on success, NULL on error.
> + */
> +struct digest_cache *digest_cache_create(struct dentry *dentry,
> +					 struct path *digest_list_path,
> +					 char *path_str, char *filename)
> +{
> +	struct path file_path;
> +	struct digest_cache *digest_cache =3D NULL;
> +	struct digest_cache_security *dig_sec;
> +	struct inode *inode =3D d_backing_inode(digest_list_path->dentry);
> +	bool dig_owner_exists =3D false;
> +	int ret;
> +
> +	if (S_ISDIR(d_backing_inode(digest_list_path->dentry)->i_mode) &&
> +	    filename[0]) {
> +		ret =3D vfs_path_lookup(digest_list_path->dentry,
> +				      digest_list_path->mnt, filename, 0,
> +				      &file_path);
> +		if (ret < 0) {
> +			pr_debug("Cannot find digest list %s/%s\n", path_str,
> +				 filename);
> +			return NULL;
> +		}
> +
> +		digest_list_path =3D &file_path;
> +		inode =3D d_backing_inode(file_path.dentry);
> +
> +		/*
> +		 * Cannot request a digest cache for the same inode the
> +		 * digest cache is populated from.
> +		 */
> +		if (d_backing_inode(dentry) =3D=3D inode) {
> +			pr_debug("Cannot request a digest cache for %s and use it as digest l=
ist\n",
> +				 dentry->d_name.name);
> +			goto out;
> +		}
> +
> +		/* No support for nested directories. */
> +		if (!S_ISREG(inode->i_mode)) {
> +			pr_debug("%s is not a regular file (no support for nested directories=
)\n",
> +				 dentry->d_name.name);
> +			goto out;
> +		}
> +	}
> +
> +	dig_sec =3D digest_cache_get_security(inode);
> +	if (unlikely(!dig_sec))
> +		goto out;
> +
> +	/* Serialize check and assignment of dig_owner. */
> +	mutex_lock(&dig_sec->dig_owner_mutex);
> +	if (dig_sec->dig_owner) {
> +		/* Increment ref. count for reference returned to the caller. */
> +		digest_cache =3D digest_cache_ref(dig_sec->dig_owner);
> +		dig_owner_exists =3D true;
> +		mutex_unlock(&dig_sec->dig_owner_mutex);
> +		goto exists;
> +	}
> +
> +	/* Ref. count is already 1 for this reference. */
> +	digest_cache =3D digest_cache_alloc_init(path_str, filename);
> +	if (!digest_cache) {
> +		mutex_unlock(&dig_sec->dig_owner_mutex);
> +		goto out;
> +	}
> +
> +	/* Increment ref. count for reference set to dig_owner. */
> +	dig_sec->dig_owner =3D digest_cache_ref(digest_cache);
> +
> +	/* Make the other lock contenders wait until creation complete. */
> +	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
> +	mutex_unlock(&dig_sec->dig_owner_mutex);
> +
> +	/* Creation complete, notify the other lock contenders. */
> +	clear_and_wake_up_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
> +exists:
> +	if (dig_owner_exists)
> +		/* Wait until creation complete. */
> +		wait_on_bit(&dig_sec->dig_owner->flags, INIT_IN_PROGRESS,
> +			    TASK_UNINTERRUPTIBLE);
> +out:
> +	if (digest_list_path =3D=3D &file_path)
> +		path_put(&file_path);
> +
> +	return digest_cache;
> +}
> +
> +/**
> + * digest_cache_new - Retrieve digest list file name and request digest =
cache
> + * @dentry: Dentry of the inode for which the digest cache will be used
> + *
> + * This function locates the default path. If it is a file, it directly =
creates
> + * a digest cache from it. Otherwise, it reads the digest list file name=
 from
> + * the security.digest_list xattr and requests the creation of a digest =
cache
> + * with that file name. If security.digest_list is not found, this funct=
ion
> + * requests the creation of a digest cache on the parent directory.
> + *
> + * Return: A new digest cache on success, NULL on error.
> + */
> +static struct digest_cache *digest_cache_new(struct dentry *dentry)
> +{
> +	char filename[NAME_MAX + 1] =3D { 0 };
> +	struct digest_cache *digest_cache =3D NULL;
> +	struct path default_path;
> +	int ret;
> +
> +	ret =3D kern_path(default_path_str, 0, &default_path);
> +	if (ret < 0) {
> +		pr_debug("Cannot find path %s\n", default_path_str);
> +		return NULL;
> +	}
> +
> +	/* The default path is a file, no need to get xattr. */
> +	if (S_ISREG(d_backing_inode(default_path.dentry)->i_mode)) {
> +		pr_debug("Default path %s is a file, not reading %s xattr\n",
> +			 default_path_str, XATTR_NAME_DIGEST_LIST);
> +		goto create;
> +	} else if (!S_ISDIR(d_backing_inode(default_path.dentry)->i_mode)) {
> +		pr_debug("Default path %s must be either a file or a directory\n",
> +			 default_path_str);
> +		goto out;
> +	}
> +
> +	ret =3D vfs_getxattr(&nop_mnt_idmap, dentry, XATTR_NAME_DIGEST_LIST,
> +			   filename, sizeof(filename) - 1);
> +	if (ret <=3D 0) {
> +		pr_debug("Digest list path not found for file %s, using %s\n",
> +			 dentry->d_name.name, default_path_str);
> +		goto create;
> +	}
> +
> +	if (strchr(filename, '/')) {
> +		pr_debug("%s xattr should contain only a file name, got: %s\n",
> +			 XATTR_NAME_DIGEST_LIST, filename);
> +		goto out;
> +	}
> +
> +	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
> +		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
> +		 filename);
> +create:
> +	digest_cache =3D digest_cache_create(dentry, &default_path,
> +					   default_path_str, filename);
> +out:
> +	path_put(&default_path);
> +	return digest_cache;
> +}
> +
> +/**
> + * digest_cache_get - Get a digest cache for a given inode
> + * @dentry: Dentry of the inode for which the digest cache will be used
> + *
> + * This function tries to find a digest cache from the inode security bl=
ob of
> + * the passed dentry (dig_user field). If a digest cache was not found, =
it calls
> + * digest_cache_new() to create a new one. In both cases, it increments =
the
> + * digest cache reference count before returning the reference to the ca=
ller.
> + *
> + * The caller is responsible to call digest_cache_put() to release the d=
igest
> + * cache reference returned.
> + *
> + * Lock dig_user_mutex to protect against concurrent requests to obtain =
a digest
> + * cache for the same inode, and to make other contenders wait until the=
 first
> + * requester finishes the process.
> + *
> + * Return: A digest cache on success, NULL otherwise.
> + */
> +struct digest_cache *digest_cache_get(struct dentry *dentry)
> +{
> +	struct digest_cache_security *dig_sec;
> +	struct digest_cache *digest_cache =3D NULL;
> +	struct inode *inode =3D d_backing_inode(dentry);
> +
> +	if (!digest_cache_enabled)
> +		return NULL;
> +
> +	dig_sec =3D digest_cache_get_security(inode);
> +	if (unlikely(!dig_sec))
> +		return NULL;
> +
> +	/* Serialize accesses to inode for which the digest cache is used. */
> +	mutex_lock(&dig_sec->dig_user_mutex);
> +	if (!dig_sec->dig_user)
> +		/* Consume extra reference from digest_cache_create(). */
> +		dig_sec->dig_user =3D digest_cache_new(dentry);
> +
> +	if (dig_sec->dig_user)
> +		/* Increment ref. count for reference returned to the caller. */
> +		digest_cache =3D digest_cache_ref(dig_sec->dig_user);
> +
> +	mutex_unlock(&dig_sec->dig_user_mutex);
> +	return digest_cache;
> +}
> +EXPORT_SYMBOL_GPL(digest_cache_get);
> +
> +/**
> + * digest_cache_put - Release a digest cache reference
> + * @digest_cache: Digest cache
> + *
> + * This function decrements the reference count of the digest cache pass=
ed as
> + * argument. If the reference count reaches zero, it calls digest_cache_=
free()
> + * to free the digest cache.
> + */
> +void digest_cache_put(struct digest_cache *digest_cache)
> +{
> +	struct digest_cache *to_free;
> +
> +	to_free =3D digest_cache_unref(digest_cache);
> +	if (!to_free)
> +		return;
> +
> +	digest_cache_free(to_free);
> +}
> +EXPORT_SYMBOL_GPL(digest_cache_put);
> +
> +struct lsm_blob_sizes digest_cache_blob_sizes __ro_after_init =3D {
> +	.lbs_inode =3D sizeof(struct digest_cache_security),
> +};
> +
> +/**
> + * digest_cache_inode_alloc_security - Initialize inode security blob
> + * @inode: Inode for which the security blob is initialized
> + *
> + * This function initializes the digest_cache_security structure, direct=
ly
> + * stored in the inode security blob.
> + *
> + * Return: Zero.
> + */
> +static int digest_cache_inode_alloc_security(struct inode *inode)
> +{
> +	struct digest_cache_security *dig_sec;
> +
> +	/* The inode security blob is always allocated here. */
> +	dig_sec =3D digest_cache_get_security(inode);
> +	mutex_init(&dig_sec->dig_owner_mutex);
> +	mutex_init(&dig_sec->dig_user_mutex);
> +	return 0;
> +}
> +
> +/**
> + * digest_cache_inode_free_security - Release the digest cache reference=
s
> + * @inode: Inode for which the digest cache references are released
> + *
> + * Since the inode is being evicted, this function releases the non-need=
ed
> + * references to the digest caches stored in the digest_cache_security
> + * structure.
> + */
> +static void digest_cache_inode_free_security(struct inode *inode)
> +{
> +	struct digest_cache_security *dig_sec;
> +
> +	dig_sec =3D digest_cache_get_security(inode);
> +	if (!dig_sec)
> +		return;
> +
> +	mutex_destroy(&dig_sec->dig_owner_mutex);
> +	mutex_destroy(&dig_sec->dig_user_mutex);
> +	if (dig_sec->dig_owner)
> +		digest_cache_put(dig_sec->dig_owner);
> +	if (dig_sec->dig_user)
> +		digest_cache_put(dig_sec->dig_user);
> +}
> +
> +static struct security_hook_list digest_cache_hooks[] __ro_after_init =
=3D {
> +	LSM_HOOK_INIT(inode_alloc_security, digest_cache_inode_alloc_security),
> +	LSM_HOOK_INIT(inode_free_security, digest_cache_inode_free_security),
> +};
> +
> +/**
> + * digest_cache_init_once - Initialize the digest cache structure
> + * @foo: Digest cache structure to initialize
> + *
> + * This function fills the digest cache structure with zeros.
> + */
> +static void digest_cache_init_once(void *foo)
> +{
> +	struct digest_cache *digest_cache =3D (struct digest_cache *)foo;
> +
> +	memset(digest_cache, 0, sizeof(*digest_cache));
> +}
> +
> +static const struct lsm_id digest_cache_lsmid =3D {
> +	.name =3D "digest_cache",
> +	.id =3D LSM_ID_DIGEST_CACHE,
> +};
> +
> +/**
> + * digest_cache_init - Initialize the digest_cache LSM
> + *
> + * Initialize the digest_cache LSM, by instantiating a cache for the
> + * digest_cache structure and by registering the digest_cache LSM hooks.
> + */
> +static int __init digest_cache_init(void)
> +{
> +	digest_cache_cache =3D kmem_cache_create("digest_cache_cache",
> +					       sizeof(struct digest_cache),
> +					       0, SLAB_PANIC,
> +					       digest_cache_init_once);
> +
> +	security_add_hooks(digest_cache_hooks, ARRAY_SIZE(digest_cache_hooks),
> +			   &digest_cache_lsmid);
> +	return 0;
> +}
> +
> +DEFINE_LSM(digest_cache) =3D {
> +	.name =3D "digest_cache",
> +	.enabled =3D &digest_cache_enabled,
> +	.init =3D digest_cache_init,
> +	.blobs =3D &digest_cache_blob_sizes,
> +};
> diff --git a/security/security.c b/security/security.c
> index cbdc9bebe802..cb084ed58617 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -50,7 +50,8 @@
>  	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0) + \
>  	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> -	(IS_ENABLED(CONFIG_EVM) ? 1 : 0))
> +	(IS_ENABLED(CONFIG_EVM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_DIGEST_CACHE) ? 1 : 0))
> =20
>  /*
>   * These are descriptions of the reasons that can be passed to the
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/=
testing/selftests/lsm/lsm_list_modules_test.c
> index 4d5d4cee2586..d00831edc582 100644
> --- a/tools/testing/selftests/lsm/lsm_list_modules_test.c
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -128,6 +128,9 @@ TEST(correct_lsm_list_modules)
>  		case LSM_ID_EVM:
>  			name =3D "evm";
>  			break;
> +		case LSM_ID_DIGEST_CACHE:
> +			name =3D "digest_cache";
> +			break;
>  		default:
>  			name =3D "INVALID";
>  			break;

BR, Jarkko

