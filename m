Return-Path: <linux-kselftest+bounces-8024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29948A5A97
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 21:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62D71C22DE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C515625A;
	Mon, 15 Apr 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyUe+HpK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48715624B;
	Mon, 15 Apr 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209586; cv=none; b=XkVa/AoRlHr7f4glDS1S63ah9WdUq3iWSrXPJ6fL0JDmUh+QAXuObPv22R4i32k2zFMq+LFjf4XTZaFISV74SZopUsTn11axB5fpusHrR8aMOs/V6e6L7DnxlKav6piDRMw2SDTjVE8iTtzx/M1k7Ghm4EZbYVb6WsHnHDUm6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209586; c=relaxed/simple;
	bh=ewtXcxBi/g3Mukc+04qUVmTRw+lNYQSgV7Jr/0/OlJY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=svmx7+tY6K7SGRkB25vEr2ihXb70FxbrIMqTCCvztpuA8/LpJo6yH2V249AnY5PDn8KqzPXn6u4N/tzEE4FwQkXFGiV+GManMvmPejHPfcyCfYnudlWkRIYGpDyPdoCNV2OQTs1mtxp6e+DZWoAHFSOAEfODH4o/NNkmngRP/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyUe+HpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A6C113CC;
	Mon, 15 Apr 2024 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713209585;
	bh=ewtXcxBi/g3Mukc+04qUVmTRw+lNYQSgV7Jr/0/OlJY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=lyUe+HpKGXX11vc8OBrG6w5xItlzUB09LNaodC8u19LlI8Az0WK8PcikXJnU9GsoH
	 6iPSr711P5BgP7pJyxj0dSb1AKwhxeir3oKAxDUrYQl5NWynYoR8Xm+eCupCJedCvV
	 ggB1hfsYo/QWJuwfiq7I5TpFj4a4R7ZNVvf478xK4Zv0J0XbQmatJtqQhp+fKH5MBg
	 lq8n30eICioepzN//K3BO3ODbO08Bha/SjEF+XZYmpTMVuquhkGE3HiW3WilQIYm+3
	 qyhbw9nBD4hzNpaVJIwQfHbXx+MwN1qanfuq8O62xvE99+ScHpNqBah1c6Et3YiyOm
	 MtMG/6MC+V1wA==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Apr 2024 22:32:57 +0300
Message-Id: <D0KY3YSZCLTG.24OGZPYS4AKDY@kernel.org>
Cc: <linux-security-module@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <bpf@vger.kernel.org>, <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
 <linux-integrity@vger.kernel.org>, <wufan@linux.microsoft.com>,
 <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>, <hch@lst.de>,
 <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>, <jannh@google.com>,
 <dhowells@redhat.com>, <jikos@kernel.org>, <mkoutny@suse.com>,
 <ppavlu@suse.com>, <petr.vorel@gmail.com>, <mzerqung@0pointer.de>,
 <kgold@linux.ibm.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v4 03/14] digest_cache: Add securityfs interface
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <akpm@linux-foundation.org>, <shuah@kernel.org>,
 <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
 <mic@digikod.net>
X-Mailer: aerc 0.17.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-4-roberto.sassu@huaweicloud.com>

On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the digest_cache_path file in securityfs, to let root change/read the
> default path (file or directory) from where digest lists are looked up.
>
> An RW semaphore prevents the default path from changing while
> digest_list_new() and read_default_path() are executed, so that those rea=
d
> a stable value. Multiple digest_list_new() and read_default_path() calls,
> instead, can be done in parallel, since they are the readers.
>
> Changing the default path does not affect digest caches created with the
> old path.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/digest_cache/Kconfig    |  4 ++
>  security/digest_cache/Makefile   |  2 +-
>  security/digest_cache/internal.h |  1 +
>  security/digest_cache/main.c     | 10 +++-
>  security/digest_cache/secfs.c    | 87 ++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+), 2 deletions(-)
>  create mode 100644 security/digest_cache/secfs.c
>
> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfi=
g
> index e53fbf0779d6..dfabe5d6e3ca 100644
> --- a/security/digest_cache/Kconfig
> +++ b/security/digest_cache/Kconfig
> @@ -14,3 +14,7 @@ config DIGEST_LIST_DEFAULT_PATH
>  	default "/etc/digest_lists"
>  	help
>  	  Default directory where digest_cache LSM expects to find digest lists=
.
> +
> +	  It can be changed at run-time, by writing the new path to the
> +	  securityfs interface. Digest caches created with the old path are
> +	  not affected by the change.
> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makef=
ile
> index 48848c41253e..1330655e33b1 100644
> --- a/security/digest_cache/Makefile
> +++ b/security/digest_cache/Makefile
> @@ -4,4 +4,4 @@
> =20
>  obj-$(CONFIG_SECURITY_DIGEST_CACHE) +=3D digest_cache.o
> =20
> -digest_cache-y :=3D main.o
> +digest_cache-y :=3D main.o secfs.o
> diff --git a/security/digest_cache/internal.h b/security/digest_cache/int=
ernal.h
> index 5f04844af3a5..bbf5eefe5c82 100644
> --- a/security/digest_cache/internal.h
> +++ b/security/digest_cache/internal.h
> @@ -49,6 +49,7 @@ struct digest_cache_security {
> =20
>  extern struct lsm_blob_sizes digest_cache_blob_sizes;
>  extern char *default_path_str;
> +extern struct rw_semaphore default_path_sem;
> =20
>  static inline struct digest_cache_security *
>  digest_cache_get_security(const struct inode *inode)
> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
> index 14dba8915e99..661c8d106791 100644
> --- a/security/digest_cache/main.c
> +++ b/security/digest_cache/main.c
> @@ -18,6 +18,9 @@ static struct kmem_cache *digest_cache_cache __read_mos=
tly;
> =20
>  char *default_path_str =3D CONFIG_DIGEST_LIST_DEFAULT_PATH;
> =20
> +/* Protects default_path_str. */
> +struct rw_semaphore default_path_sem;
> +
>  /**
>   * digest_cache_alloc_init - Allocate and initialize a new digest cache
>   * @path_str: Path string of the digest list
> @@ -274,9 +277,12 @@ struct digest_cache *digest_cache_get(struct dentry =
*dentry)
> =20
>  	/* Serialize accesses to inode for which the digest cache is used. */
>  	mutex_lock(&dig_sec->dig_user_mutex);
> -	if (!dig_sec->dig_user)
> +	if (!dig_sec->dig_user) {
> +		down_read(&default_path_sem);
>  		/* Consume extra reference from digest_cache_create(). */
>  		dig_sec->dig_user =3D digest_cache_new(dentry);
> +		up_read(&default_path_sem);
> +	}
> =20
>  	if (dig_sec->dig_user)
>  		/* Increment ref. count for reference returned to the caller. */
> @@ -386,6 +392,8 @@ static const struct lsm_id digest_cache_lsmid =3D {
>   */
>  static int __init digest_cache_init(void)
>  {
> +	init_rwsem(&default_path_sem);
> +
>  	digest_cache_cache =3D kmem_cache_create("digest_cache_cache",
>  					       sizeof(struct digest_cache),
>  					       0, SLAB_PANIC,
> diff --git a/security/digest_cache/secfs.c b/security/digest_cache/secfs.=
c
> new file mode 100644
> index 000000000000..d3a37bf3588e
> --- /dev/null
> +++ b/security/digest_cache/secfs.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Implement the securityfs interface of the digest_cache LSM.
> + */
> +
> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
> +#include <linux/security.h>
> +
> +#include "internal.h"
> +
> +static struct dentry *default_path_dentry;
> +
> +/**
> + * write_default_path - Write default path
> + * @file: File descriptor of the securityfs file
> + * @buf: User space buffer
> + * @datalen: Amount of data to write
> + * @ppos: Current position in the file
> + *
> + * This function sets the new default path where digest lists can be fou=
nd.
> + * Can be either a regular file or a directory.
> + *
> + * Return: Length of path written on success, a POSIX error code otherwi=
se.
> + */
> +static ssize_t write_default_path(struct file *file, const char __user *=
buf,
> +				  size_t datalen, loff_t *ppos)
> +{
> +	char *new_default_path_str;
> +
> +	new_default_path_str =3D memdup_user_nul(buf, datalen);
> +	if (IS_ERR(new_default_path_str))
> +		return PTR_ERR(new_default_path_str);
> +
> +	down_write(&default_path_sem);
> +	kfree_const(default_path_str);
> +	default_path_str =3D new_default_path_str;
> +	up_write(&default_path_sem);
> +	return datalen;
> +}
> +
> +/**
> + * read_default_path - Read default path
> + * @file: File descriptor of the securityfs file
> + * @buf: User space buffer
> + * @datalen: Amount of data to read
> + * @ppos: Current position in the file
> + *
> + * This function returns the current default path where digest lists can=
 be
> + * found. Can be either a regular file or a directory.
> + *
> + * Return: Length of path read on success, a POSIX error code otherwise.
> + */
> +static ssize_t read_default_path(struct file *file, char __user *buf,
> +				 size_t datalen, loff_t *ppos)
> +{
> +	int ret;
> +
> +	down_read(&default_path_sem);
> +	ret =3D simple_read_from_buffer(buf, datalen, ppos, default_path_str,
> +				      strlen(default_path_str) + 1);
> +	up_read(&default_path_sem);
> +	return ret;
> +}
> +
> +static const struct file_operations default_path_ops =3D {
> +	.open =3D generic_file_open,
> +	.write =3D write_default_path,
> +	.read =3D read_default_path,
> +	.llseek =3D generic_file_llseek,
> +};
> +
> +static int __init digest_cache_path_init(void)
> +{
> +	default_path_dentry =3D securityfs_create_file("digest_cache_path", 066=
0,
> +						     NULL, NULL,
> +						     &default_path_ops);
> +	if (IS_ERR(default_path_dentry))
> +		return -EFAULT;

Nit: when overwriting error value with another error value it would be
best to document it with an inline comment. Otherwise, it is fine.

> +
> +	return 0;
> +}
> +
> +late_initcall(digest_cache_path_init);


BR, Jarkko

