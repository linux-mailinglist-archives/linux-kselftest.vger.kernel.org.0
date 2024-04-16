Return-Path: <linux-kselftest+bounces-8123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A9F8A6813
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFC1F21C0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEB31272CB;
	Tue, 16 Apr 2024 10:16:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969B1272AA;
	Tue, 16 Apr 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262584; cv=none; b=m4bZ0cJPfqO4cRAvhIySDSwuV4rIQvzZOt+yCMsxS1EKMtPoYq5HBjTijBphSmaFwdCXLMOMJ/7bsOIWL00g5D5e1nY/yV3r1puYQYpwrMo/sGkT8VhAThDUigfnk2gd5Hk0BrLEShMrip5MCj5eIDJGjU2q+122eQwZSrxG96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262584; c=relaxed/simple;
	bh=f0FsJk9FNilNAUik9wYD4dFl/kdk/i7363GF9x1B79g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9USGeIo6W4xvrIMRsnKW1m45JGQtyHnDlwOG2oGUjydL6dEBqX2c5q6+ra+oboVaC2bvxbfHnqQuwfeK1w1G1c15g1GLoyyOQan6x5nHmMKlGJD6DDmLvqI6kVaLOlEaMN2RkJUVqTXL4l00l0OOEZ8jTXtBBq+vv7GmO1kTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJffD242mz9xGhN;
	Tue, 16 Apr 2024 17:59:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 440B1140444;
	Tue, 16 Apr 2024 18:16:18 +0800 (CST)
Received: from [10.45.159.171] (unknown [10.45.159.171])
	by APP1 (Coremail) with SMTP id LxC2BwC3qhPcTx5m7FtbBg--.13343S2;
	Tue, 16 Apr 2024 11:16:17 +0100 (CET)
Message-ID: <d50530db-4a5e-4f58-997f-82090797398b@huaweicloud.com>
Date: Tue, 16 Apr 2024 12:15:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] digest_cache: Add securityfs interface
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, akpm@linux-foundation.org,
 shuah@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 mic@digikod.net
Cc: linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 linux-integrity@vger.kernel.org, wufan@linux.microsoft.com,
 pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org,
 pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com,
 jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com,
 mzerqung@0pointer.de, kgold@linux.ibm.com,
 Roberto Sassu <roberto.sassu@huawei.com>
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
 <20240415142436.2545003-4-roberto.sassu@huaweicloud.com>
 <D0KY3YSZCLTG.24OGZPYS4AKDY@kernel.org>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <D0KY3YSZCLTG.24OGZPYS4AKDY@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwC3qhPcTx5m7FtbBg--.13343S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7GryUCr43WFWDXF45trb_yoW3JFy5p3
	9Fk3WUKr4xZF13Awn2y3W7CF1Sg398KF47Cr4DW343AFZxuwnYva40yr1UuryUXr4UZa4I
	yr4j9r13Xr4qqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOlksDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5x85wACs+

On 4/15/2024 9:32 PM, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Add the digest_cache_path file in securityfs, to let root change/read the
>> default path (file or directory) from where digest lists are looked up.
>>
>> An RW semaphore prevents the default path from changing while
>> digest_list_new() and read_default_path() are executed, so that those read
>> a stable value. Multiple digest_list_new() and read_default_path() calls,
>> instead, can be done in parallel, since they are the readers.
>>
>> Changing the default path does not affect digest caches created with the
>> old path.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   security/digest_cache/Kconfig    |  4 ++
>>   security/digest_cache/Makefile   |  2 +-
>>   security/digest_cache/internal.h |  1 +
>>   security/digest_cache/main.c     | 10 +++-
>>   security/digest_cache/secfs.c    | 87 ++++++++++++++++++++++++++++++++
>>   5 files changed, 102 insertions(+), 2 deletions(-)
>>   create mode 100644 security/digest_cache/secfs.c
>>
>> diff --git a/security/digest_cache/Kconfig b/security/digest_cache/Kconfig
>> index e53fbf0779d6..dfabe5d6e3ca 100644
>> --- a/security/digest_cache/Kconfig
>> +++ b/security/digest_cache/Kconfig
>> @@ -14,3 +14,7 @@ config DIGEST_LIST_DEFAULT_PATH
>>   	default "/etc/digest_lists"
>>   	help
>>   	  Default directory where digest_cache LSM expects to find digest lists.
>> +
>> +	  It can be changed at run-time, by writing the new path to the
>> +	  securityfs interface. Digest caches created with the old path are
>> +	  not affected by the change.
>> diff --git a/security/digest_cache/Makefile b/security/digest_cache/Makefile
>> index 48848c41253e..1330655e33b1 100644
>> --- a/security/digest_cache/Makefile
>> +++ b/security/digest_cache/Makefile
>> @@ -4,4 +4,4 @@
>>   
>>   obj-$(CONFIG_SECURITY_DIGEST_CACHE) += digest_cache.o
>>   
>> -digest_cache-y := main.o
>> +digest_cache-y := main.o secfs.o
>> diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
>> index 5f04844af3a5..bbf5eefe5c82 100644
>> --- a/security/digest_cache/internal.h
>> +++ b/security/digest_cache/internal.h
>> @@ -49,6 +49,7 @@ struct digest_cache_security {
>>   
>>   extern struct lsm_blob_sizes digest_cache_blob_sizes;
>>   extern char *default_path_str;
>> +extern struct rw_semaphore default_path_sem;
>>   
>>   static inline struct digest_cache_security *
>>   digest_cache_get_security(const struct inode *inode)
>> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
>> index 14dba8915e99..661c8d106791 100644
>> --- a/security/digest_cache/main.c
>> +++ b/security/digest_cache/main.c
>> @@ -18,6 +18,9 @@ static struct kmem_cache *digest_cache_cache __read_mostly;
>>   
>>   char *default_path_str = CONFIG_DIGEST_LIST_DEFAULT_PATH;
>>   
>> +/* Protects default_path_str. */
>> +struct rw_semaphore default_path_sem;
>> +
>>   /**
>>    * digest_cache_alloc_init - Allocate and initialize a new digest cache
>>    * @path_str: Path string of the digest list
>> @@ -274,9 +277,12 @@ struct digest_cache *digest_cache_get(struct dentry *dentry)
>>   
>>   	/* Serialize accesses to inode for which the digest cache is used. */
>>   	mutex_lock(&dig_sec->dig_user_mutex);
>> -	if (!dig_sec->dig_user)
>> +	if (!dig_sec->dig_user) {
>> +		down_read(&default_path_sem);
>>   		/* Consume extra reference from digest_cache_create(). */
>>   		dig_sec->dig_user = digest_cache_new(dentry);
>> +		up_read(&default_path_sem);
>> +	}
>>   
>>   	if (dig_sec->dig_user)
>>   		/* Increment ref. count for reference returned to the caller. */
>> @@ -386,6 +392,8 @@ static const struct lsm_id digest_cache_lsmid = {
>>    */
>>   static int __init digest_cache_init(void)
>>   {
>> +	init_rwsem(&default_path_sem);
>> +
>>   	digest_cache_cache = kmem_cache_create("digest_cache_cache",
>>   					       sizeof(struct digest_cache),
>>   					       0, SLAB_PANIC,
>> diff --git a/security/digest_cache/secfs.c b/security/digest_cache/secfs.c
>> new file mode 100644
>> index 000000000000..d3a37bf3588e
>> --- /dev/null
>> +++ b/security/digest_cache/secfs.c
>> @@ -0,0 +1,87 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2023-2024 Huawei Technologies Duesseldorf GmbH
>> + *
>> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
>> + *
>> + * Implement the securityfs interface of the digest_cache LSM.
>> + */
>> +
>> +#define pr_fmt(fmt) "DIGEST CACHE: "fmt
>> +#include <linux/security.h>
>> +
>> +#include "internal.h"
>> +
>> +static struct dentry *default_path_dentry;
>> +
>> +/**
>> + * write_default_path - Write default path
>> + * @file: File descriptor of the securityfs file
>> + * @buf: User space buffer
>> + * @datalen: Amount of data to write
>> + * @ppos: Current position in the file
>> + *
>> + * This function sets the new default path where digest lists can be found.
>> + * Can be either a regular file or a directory.
>> + *
>> + * Return: Length of path written on success, a POSIX error code otherwise.
>> + */
>> +static ssize_t write_default_path(struct file *file, const char __user *buf,
>> +				  size_t datalen, loff_t *ppos)
>> +{
>> +	char *new_default_path_str;
>> +
>> +	new_default_path_str = memdup_user_nul(buf, datalen);
>> +	if (IS_ERR(new_default_path_str))
>> +		return PTR_ERR(new_default_path_str);
>> +
>> +	down_write(&default_path_sem);
>> +	kfree_const(default_path_str);
>> +	default_path_str = new_default_path_str;
>> +	up_write(&default_path_sem);
>> +	return datalen;
>> +}
>> +
>> +/**
>> + * read_default_path - Read default path
>> + * @file: File descriptor of the securityfs file
>> + * @buf: User space buffer
>> + * @datalen: Amount of data to read
>> + * @ppos: Current position in the file
>> + *
>> + * This function returns the current default path where digest lists can be
>> + * found. Can be either a regular file or a directory.
>> + *
>> + * Return: Length of path read on success, a POSIX error code otherwise.
>> + */
>> +static ssize_t read_default_path(struct file *file, char __user *buf,
>> +				 size_t datalen, loff_t *ppos)
>> +{
>> +	int ret;
>> +
>> +	down_read(&default_path_sem);
>> +	ret = simple_read_from_buffer(buf, datalen, ppos, default_path_str,
>> +				      strlen(default_path_str) + 1);
>> +	up_read(&default_path_sem);
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations default_path_ops = {
>> +	.open = generic_file_open,
>> +	.write = write_default_path,
>> +	.read = read_default_path,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>> +static int __init digest_cache_path_init(void)
>> +{
>> +	default_path_dentry = securityfs_create_file("digest_cache_path", 0660,
>> +						     NULL, NULL,
>> +						     &default_path_ops);
>> +	if (IS_ERR(default_path_dentry))
>> +		return -EFAULT;
> 
> Nit: when overwriting error value with another error value it would be
> best to document it with an inline comment. Otherwise, it is fine.

Seems to make sense to return the right error. Will check why this one 
(I probably took from somewhere).

Thanks

Roberto

>> +
>> +	return 0;
>> +}
>> +
>> +late_initcall(digest_cache_path_init);
> 
> 
> BR, Jarkko


