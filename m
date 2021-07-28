Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208983D8E02
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhG1MkG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 08:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235220AbhG1MjL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 08:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED73E6023D;
        Wed, 28 Jul 2021 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475928;
        bh=yvEqHQkCmVBHrcGahvYUR705mlKex1EWskeUv+sIRHE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nx/atzupU7286Sir6se2KeQSiLfs2viLafPfbPQ+tbFshV4sUcVHRGFGYz0hN0bw0
         JdAvd6N8bMowi62nU1UyxO+qXQa48q+9RMcEsfcPhXBLT2IKvdkqIX17PGqZ/3XUF7
         XjROMxVf9vNZza8g/ZzJ59jttg7Go8LwhnCwBQvhaYb1RtBVnu+ZhEIjaVlhuABuRN
         QO7x76fayTH7wwbzW/z70XgQcFxXS+hA4MgZPH6xvi0epBs8FvtuBYdBcLxKQ215Ay
         6DUf8T1m9zACdgbYUsgxIHz628iz0qtXtr7gz7FnUUkXruH86M/GKeaQ5rdAPvI9bl
         BZtRHEs+bfjUA==
Date:   Wed, 28 Jul 2021 14:38:42 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     <zohar@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 06/12] diglim: Interfaces - digest_list_add,
 digest_list_del
Message-ID: <20210728143842.2db6e28c@sal.lan>
In-Reply-To: <20210726163700.2092768-7-roberto.sassu@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-7-roberto.sassu@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Mon, 26 Jul 2021 18:36:54 +0200
Roberto Sassu <roberto.sassu@huawei.com> escreveu:

> Introduce <securityfs>/integrity/diglim/digest_list_add, which can be used
> to upload a digest list and add the digests to the hash table; passed data
> are interpreted as file path if the first byte is / or as the digest list
> itself otherwise. ima_measure_critical_data() is called to calculate the
> digest of the digest list and eventually, if an appropriate rule is set in
> the IMA policy, to measure it.
> 
> Also introduce <securityfs>/integrity/diglim/digest_list_del, which can be
> used to upload a digest list and delete the digests from the hash table;
> data are interpreted in the same way as described for digest_list_add.

LGTM.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  .../security/diglim/implementation.rst        |   9 +
>  MAINTAINERS                                   |   1 +
>  include/linux/kernel_read_file.h              |   1 +
>  security/integrity/diglim/Makefile            |   2 +-
>  security/integrity/diglim/diglim.h            |   2 +
>  security/integrity/diglim/fs.c                | 239 ++++++++++++++++++
>  security/integrity/integrity.h                |   4 +
>  7 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/diglim/fs.c
> 
> diff --git a/Documentation/security/diglim/implementation.rst b/Documentation/security/diglim/implementation.rst
> index 9d679567a037..fc0cd8810a80 100644
> --- a/Documentation/security/diglim/implementation.rst
> +++ b/Documentation/security/diglim/implementation.rst
> @@ -244,3 +244,12 @@ back when one of the steps fails.
>  
>  #. digest_list_parse() deletes the struct digest_list_item on unsuccessful
>     add or successful delete.
> +
> +
> +Interfaces
> +----------
> +
> +This section introduces the interfaces in
> +``<securityfs>/integrity/diglim`` necessary to interact with DIGLIM.
> +
> +.. kernel-doc:: security/integrity/diglim/fs.c
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77c3613c600a..0672128fae7f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5464,6 +5464,7 @@ F:	Documentation/security/diglim/introduction.rst
>  F:	include/linux/diglim.h
>  F:	include/uapi/linux/diglim.h
>  F:	security/integrity/diglim/diglim.h
> +F:	security/integrity/diglim/fs.c
>  F:	security/integrity/diglim/methods.c
>  F:	security/integrity/diglim/parser.c
>  
> diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
> index 575ffa1031d3..636ecdfdc616 100644
> --- a/include/linux/kernel_read_file.h
> +++ b/include/linux/kernel_read_file.h
> @@ -14,6 +14,7 @@
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
>  	id(POLICY, security-policy)		\
>  	id(X509_CERTIFICATE, x509-certificate)	\
> +	id(DIGEST_LIST, digest-list)	\
>  	id(MAX_ID, )
>  
>  #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
> diff --git a/security/integrity/diglim/Makefile b/security/integrity/diglim/Makefile
> index 34e4e154fff3..ac345afdf5dd 100644
> --- a/security/integrity/diglim/Makefile
> +++ b/security/integrity/diglim/Makefile
> @@ -5,4 +5,4 @@
>  
>  obj-$(CONFIG_DIGLIM) += diglim.o
>  
> -diglim-y := methods.o parser.o
> +diglim-y := methods.o parser.o fs.o
> diff --git a/security/integrity/diglim/diglim.h b/security/integrity/diglim/diglim.h
> index 3adc218a0325..819703175eda 100644
> --- a/security/integrity/diglim/diglim.h
> +++ b/security/integrity/diglim/diglim.h
> @@ -22,6 +22,8 @@
>  #include <linux/hash_info.h>
>  #include <linux/diglim.h>
>  
> +#include "../integrity.h"
> +
>  #define MAX_DIGEST_SIZE 64
>  #define HASH_BITS 10
>  #define DIGLIM_HTABLE_SIZE (1 << HASH_BITS)
> diff --git a/security/integrity/diglim/fs.c b/security/integrity/diglim/fs.c
> new file mode 100644
> index 000000000000..07a0d75a0e33
> --- /dev/null
> +++ b/security/integrity/diglim/fs.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2005,2006,2007,2008 IBM Corporation
> + * Copyright (C) 2017-2021 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + *
> + * Functions for the interfaces exposed in securityfs.
> + */
> +
> +#include <linux/fcntl.h>
> +#include <linux/kernel_read_file.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/seq_file.h>
> +#include <linux/rculist.h>
> +#include <linux/rcupdate.h>
> +#include <linux/parser.h>
> +#include <linux/vmalloc.h>
> +#include <linux/namei.h>
> +#include <linux/ima.h>
> +
> +#include "diglim.h"
> +
> +#define MAX_DIGEST_LIST_SIZE (64 * 1024 * 1024 - 1)
> +
> +static struct dentry *diglim_dir;
> +/**
> + * DOC: digest_list_add
> + *
> + * digest_list_add can be used to upload a digest list and add the digests
> + * to the hash table; passed data are interpreted as file path if the first
> + * byte is ``/`` or as the digest list itself otherwise.
> + *
> + * ima_measure_critical_data() is called to calculate the digest of the
> + * digest list and eventually, if an appropriate rule is set in the IMA
> + * policy, to measure it.
> + */
> +static struct dentry *digest_list_add_dentry;
> +/**
> + * DOC: digest_list_del
> + *
> + * digest_list_del can be used to upload a digest list and delete the
> + * digests from the hash table; data are interpreted in the same way as
> + * described for digest_list_add.
> + */
> +static struct dentry *digest_list_del_dentry;
> +char digest_label[NAME_MAX + 1];
> +
> +/*
> + * digest_list_read: read and parse the digest list from the path
> + */
> +static ssize_t digest_list_read(char *path, enum ops op)
> +{
> +	void *data = NULL;
> +	char *datap;
> +	size_t size;
> +	u8 actions = 0;
> +	struct file *file;
> +	char event_name[NAME_MAX + 9 + 1];
> +	u8 digest[IMA_MAX_DIGEST_SIZE] = { 0 };
> +	enum hash_algo algo;
> +	int rc, pathlen = strlen(path);
> +
> +	/* Remove \n. */
> +	datap = path;
> +	strsep(&datap, "\n");
> +
> +	file = filp_open(path, O_RDONLY, 0);
> +	if (IS_ERR(file)) {
> +		pr_err("unable to open file: %s (%ld)", path, PTR_ERR(file));
> +		return PTR_ERR(file);
> +	}
> +
> +	rc = kernel_read_file(file, 0, &data, INT_MAX, NULL,
> +			      READING_DIGEST_LIST);
> +	if (rc < 0) {
> +		pr_err("unable to read file: %s (%d)", path, rc);
> +		goto out;
> +	}
> +
> +	size = rc;
> +
> +	snprintf(event_name, sizeof(event_name), "%s_file_%s",
> +		 op == DIGEST_LIST_ADD ? "add" : "del",
> +		 file_dentry(file)->d_name.name);
> +
> +	rc = ima_measure_critical_data("diglim", event_name, data, size, false,
> +				       digest, sizeof(digest));
> +	if (rc < 0 && rc != -EEXIST)
> +		goto out_vfree;
> +
> +	algo = ima_get_current_hash_algo();
> +
> +	if (!rc || rc == -EEXIST)
> +		actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
> +
> +	rc = digest_list_parse(size, data, op, actions, digest, algo, "");
> +	if (rc < 0)
> +		pr_err("unable to upload digest list %s (%d)\n", path, rc);
> +out_vfree:
> +	vfree(data);
> +out:
> +	fput(file);
> +
> +	if (rc < 0)
> +		return rc;
> +
> +	return pathlen;
> +}
> +
> +/*
> + * digest_list_write: write the digest list path or the digest list itself
> + */
> +static ssize_t digest_list_write(struct file *file, const char __user *buf,
> +				 size_t datalen, loff_t *ppos)
> +{
> +	char *data;
> +	ssize_t result;
> +	enum ops op = DIGEST_LIST_ADD;
> +	struct dentry *dentry = file_dentry(file);
> +	u8 digest[IMA_MAX_DIGEST_SIZE];
> +	char event_name[NAME_MAX + 11 + 1];
> +	enum hash_algo algo;
> +	u8 actions = 0;
> +
> +	/* No partial writes. */
> +	result = -EINVAL;
> +	if (*ppos != 0)
> +		goto out;
> +
> +	result = -EFBIG;
> +	if (datalen > MAX_DIGEST_LIST_SIZE)
> +		goto out;
> +
> +	data = memdup_user_nul(buf, datalen);
> +	if (IS_ERR(data)) {
> +		result = PTR_ERR(data);
> +		goto out;
> +	}
> +
> +	if (dentry == digest_list_del_dentry)
> +		op = DIGEST_LIST_DEL;
> +
> +	result = -EPERM;
> +
> +	if (data[0] == '/') {
> +		result = digest_list_read(data, op);
> +	} else {
> +		snprintf(event_name, sizeof(event_name), "%s_buffer_%s",
> +			 op == DIGEST_LIST_ADD ? "add" : "del", digest_label);
> +
> +		result = ima_measure_critical_data("diglim", event_name, data,
> +						   datalen, false, digest,
> +						   sizeof(digest));
> +		if (result < 0 && result != -EEXIST) {
> +			pr_err("failed to measure buffer digest (%ld)\n",
> +			       result);
> +			goto out_kfree;
> +		}
> +
> +		algo = ima_get_current_hash_algo();
> +
> +		if (!result || result == -EEXIST)
> +			actions |= (1 << COMPACT_ACTION_IMA_MEASURED);
> +
> +		result = digest_list_parse(datalen, data, op, actions, digest,
> +					   algo, "");
> +		if (result != datalen) {
> +			pr_err("unable to upload generated digest list\n");
> +			result = -EINVAL;
> +		}
> +	}
> +out_kfree:
> +	kfree(data);
> +out:
> +	return result;
> +}
> +
> +static unsigned long flags;
> +
> +/*
> + * digest_list_open: sequentialize access to the add/del files
> + */
> +static int digest_list_open(struct inode *inode, struct file *filp)
> +{
> +	if ((filp->f_flags & O_ACCMODE) != O_WRONLY)
> +		return -EACCES;
> +
> +	if (test_and_set_bit(0, &flags))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +
> +/*
> + * digest_list_release - release the add/del files
> + */
> +static int digest_list_release(struct inode *inode, struct file *file)
> +{
> +	clear_bit(0, &flags);
> +	return 0;
> +}
> +
> +static const struct file_operations digest_list_upload_ops = {
> +	.open = digest_list_open,
> +	.write = digest_list_write,
> +	.read = seq_read,
> +	.release = digest_list_release,
> +	.llseek = generic_file_llseek,
> +};
> +
> +static int __init diglim_fs_init(void)
> +{
> +	diglim_dir = securityfs_create_dir("diglim", integrity_dir);
> +	if (IS_ERR(diglim_dir))
> +		return -1;
> +
> +	digest_list_add_dentry = securityfs_create_file("digest_list_add", 0200,
> +						diglim_dir, NULL,
> +						&digest_list_upload_ops);
> +	if (IS_ERR(digest_list_add_dentry))
> +		goto out;
> +
> +	digest_list_del_dentry = securityfs_create_file("digest_list_del", 0200,
> +						diglim_dir, NULL,
> +						&digest_list_upload_ops);
> +	if (IS_ERR(digest_list_del_dentry))
> +		goto out;
> +
> +	return 0;
> +out:
> +	securityfs_remove(digest_list_del_dentry);
> +	securityfs_remove(digest_list_add_dentry);
> +	securityfs_remove(diglim_dir);
> +	return -1;
> +}
> +
> +late_initcall(diglim_fs_init);
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 547425c20e11..ac45e1599c2d 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -6,6 +6,9 @@
>   * Mimi Zohar <zohar@us.ibm.com>
>   */
>  
> +#ifndef __INTEGRITY_H
> +#define __INTEGRITY_H
> +
>  #ifdef pr_fmt
>  #undef pr_fmt
>  #endif
> @@ -283,3 +286,4 @@ static inline void __init add_to_platform_keyring(const char *source,
>  {
>  }
>  #endif
> +#endif /*__INTEGRITY_H*/
