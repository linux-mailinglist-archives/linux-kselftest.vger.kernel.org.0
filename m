Return-Path: <linux-kselftest+bounces-8127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD63E8A6888
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C359282905
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC0B127E11;
	Tue, 16 Apr 2024 10:34:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5884FA0;
	Tue, 16 Apr 2024 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263695; cv=none; b=r8o6f7cdqmB0qbVLGsR1kjbydvGV1Z0zyRlY7KSpGEbwKxHrUFCMaSmHZ6jnSB4scjLXBRWpNq3DlGe4kytrBRWX1jUyUcx33ZeaT3a4+BTxjq7mwtoyQIuy758ARidnhAdL+/Y7KlMXGtcZ790pqwgTLRxLcOKoGMnfXihzOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263695; c=relaxed/simple;
	bh=BRQfSPe9u/4IhnLCzGPdrQqdL5QMUhCogp4wm/S2DMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pO7wLDYecdjVBKpPtE9AdZhlHskPTSLQHkliab3rLmAeJt6/vpEhYyNpUeKxUi+VJOuxEZ6zq2qHTqyu7d7/INiSdO9V8TKzHMQxrkxzx5wrXHPQ/7IgbMUNIgsHP2ROgkZysxagqrb9QV2w++3vaUnn7TY8EkgRtJ72sWsIBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VJg3b5zkcz9v7gL;
	Tue, 16 Apr 2024 18:18:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id AE432140801;
	Tue, 16 Apr 2024 18:34:40 +0800 (CST)
Received: from [10.81.220.53] (unknown [10.81.220.53])
	by APP2 (Coremail) with SMTP id GxC2BwBnUycsVB5mMStUBg--.12154S2;
	Tue, 16 Apr 2024 11:34:39 +0100 (CET)
Message-ID: <62562bb3-b09d-4b0c-8a16-f2238d249394@huaweicloud.com>
Date: Tue, 16 Apr 2024 12:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/14] digest cache: Prefetch digest lists if requested
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
 <20240415142436.2545003-11-roberto.sassu@huaweicloud.com>
 <D0KYBIKEMVBJ.3TUUWH3M4XW7I@kernel.org>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <D0KYBIKEMVBJ.3TUUWH3M4XW7I@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:GxC2BwBnUycsVB5mMStUBg--.12154S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJFykuF13Cw1ruFWxGry7Awb_yoW8AF13Co
	ZYkF4xZw48uFyUurs8CF1xAa1Uua4Fg34xAr4kGFZ8Z3WvyFWUW3ZrC3WkJFW5Xr18JFZ7
	Zw1xJ3yUJFW8t3s3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIx
	AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1ebytUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBF1jj5x9EQABsK

On 4/15/2024 9:42 PM, Jarkko Sakkinen wrote:
> On Mon Apr 15, 2024 at 5:24 PM EEST, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> A desirable goal when doing integrity measurements is that they are done
>> always in the same order across boots, so that the resulting PCR value
>> becomes predictable and suitable for sealing policies. However, due to
>> parallel execution of system services at boot, a deterministic order of
>> measurements is difficult to achieve.
>>
>> The digest_cache LSM is not exempted from this issue. Under the assumption
>> that only the digest list is measured, and file measurements are omitted if
>> their digest is found in that digest list, a PCR can be predictable only if
>> all files belong to the same digest list. Otherwise, it will still be
>> unpredictable, since files accessed in a non-deterministic order will cause
>> digest lists to be measured in a non-deterministic order too.
>>
>> Overcome this issue, if prefetching is enabled, by searching a digest list
>> file name in digest_list_dir_lookup_filename() among the entries of the
>> linked list built by digest_cache_dir_create(). If the file name does not
>> match, read the digest list to trigger its measurement. Otherwise, also
>> create a digest cache and return that to the caller. Release the extra
>> reference of the directory digest cache in digest_cache_new(), since it was
>> only used for the search and it is not going to be returned.
>>
>> Prefetching needs to be explicitly enabled by setting the new
>> security.dig_prefetch xattr to 1 in the directory containing the digest
>> lists. The newly introduced function digest_cache_prefetch_requested()
>> checks first if the DIR_PREFETCH bit is set in dig_owner, otherwise it
>> reads the xattr. digest_cache_create() sets DIR_PREFETCH in dig_owner, if
>> prefetching is enabled, before declaring the digest cache as initialized.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
>>   include/uapi/linux/xattr.h       |  3 +
>>   security/digest_cache/dir.c      | 55 +++++++++++++++++-
>>   security/digest_cache/internal.h | 11 +++-
>>   security/digest_cache/main.c     | 95 +++++++++++++++++++++++++++++++-
>>   security/digest_cache/populate.c |  8 ++-
>>   security/digest_cache/verif.c    |  5 +-
>>   6 files changed, 170 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
>> index 8a58cf4bce65..8af33d38d9e8 100644
>> --- a/include/uapi/linux/xattr.h
>> +++ b/include/uapi/linux/xattr.h
>> @@ -57,6 +57,9 @@
>>   #define XATTR_DIGEST_LIST_SUFFIX "digest_list"
>>   #define XATTR_NAME_DIGEST_LIST XATTR_SECURITY_PREFIX XATTR_DIGEST_LIST_SUFFIX
>>   
>> +#define XATTR_DIG_PREFETCH_SUFFIX "dig_prefetch"
>> +#define XATTR_NAME_DIG_PREFETCH XATTR_SECURITY_PREFIX XATTR_DIG_PREFETCH_SUFFIX
>> +
>>   #define XATTR_SELINUX_SUFFIX "selinux"
>>   #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
>>   
>> diff --git a/security/digest_cache/dir.c b/security/digest_cache/dir.c
>> index 7bfcdd5f7ef1..a7d203c15386 100644
>> --- a/security/digest_cache/dir.c
>> +++ b/security/digest_cache/dir.c
>> @@ -54,6 +54,7 @@ static bool digest_cache_dir_iter(struct dir_context *__ctx, const char *name,
>>   	new_entry->seq_num = UINT_MAX;
>>   	new_entry->digest_cache = NULL;
>>   	mutex_init(&new_entry->digest_cache_mutex);
>> +	new_entry->prefetched = false;
>>   
>>   	if (new_entry->name[0] < '0' || new_entry->name[0] > '9')
>>   		goto out;
>> @@ -127,6 +128,7 @@ int digest_cache_dir_create(struct digest_cache *digest_cache,
>>    * @digest_cache: Digest cache
>>    * @digest: Digest to search
>>    * @algo: Algorithm of the digest to search
>> + * @filename: File name of the digest list to search
>>    *
>>    * This function iterates over the linked list created by
>>    * digest_cache_dir_create() and looks up the digest in the digest cache of
>> @@ -149,7 +151,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
>>   		if (!dir_entry->digest_cache) {
>>   			cache = digest_cache_create(dentry, digest_list_path,
>>   						    digest_cache->path_str,
>> -						    dir_entry->name);
>> +						    dir_entry->name, false,
>> +						    false);
>>   			/* Ignore digest caches that cannot be instantiated. */
>>   			if (!cache) {
>>   				mutex_unlock(&dir_entry->digest_cache_mutex);
>> @@ -158,6 +161,8 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
>>   
>>   			/* Consume extra ref. from digest_cache_create(). */
>>   			dir_entry->digest_cache = cache;
>> +			/* Digest list was read, mark entry as prefetched. */
>> +			dir_entry->prefetched = true;
>>   		}
>>   		mutex_unlock(&dir_entry->digest_cache_mutex);
>>   
>> @@ -171,6 +176,54 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
>>   	return 0UL;
>>   }
>>   
>> +/**
>> + * digest_cache_dir_lookup_filename - Lookup a digest list
>> + * @dentry: Dentry of the file whose digest list is looked up
>> + * @digest_list_path: Path structure of the digest list directory
>> + * @digest_cache: Digest cache
>> + * @filename: File name of the digest list to search
>> + *
>> + * This function iterates over the linked list created by
>> + * digest_cache_dir_create() and looks up a digest list with a matching file
>> + * name among the entries. If there is no match, it prefetches (reads) the
>> + * current digest list. Otherwise, it returns the digest cache pointer from
>> + * digest_cache_create() to the caller.
>> + *
>> + * Return: A digest cache pointer if the digest list if found, NULL otherwise.
>> + */
>> +struct digest_cache *
>> +digest_cache_dir_lookup_filename(struct dentry *dentry,
>> +				 struct path *digest_list_path,
>> +				 struct digest_cache *digest_cache,
>> +				 char *filename)
>> +{
>> +	struct digest_cache *cache;
>> +	struct dir_entry *dir_entry;
>> +	bool filename_found;
>> +
>> +	list_for_each_entry(dir_entry, &digest_cache->dir_entries, list) {
>> +		mutex_lock(&dir_entry->digest_cache_mutex);
>> +		filename_found = !strcmp(dir_entry->name, filename);
>> +		if (!filename_found && dir_entry->prefetched) {
>> +			mutex_unlock(&dir_entry->digest_cache_mutex);
>> +			continue;
>> +		}
>> +
>> +		cache = digest_cache_create(dentry, digest_list_path,
>> +					    digest_cache->path_str,
>> +					    dir_entry->name, false,
>> +					    filename_found ? false : true);
>> +
>> +		dir_entry->prefetched = true;
>> +		mutex_unlock(&dir_entry->digest_cache_mutex);
>> +
>> +		if (filename_found)
>> +			return cache;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>>   /**
>>    * digest_cache_dir_free - Free the stored file list and put digest caches
>>    * @digest_cache: Digest cache
>> diff --git a/security/digest_cache/internal.h b/security/digest_cache/internal.h
>> index b7afca8e04da..c13b35f6b2c0 100644
>> --- a/security/digest_cache/internal.h
>> +++ b/security/digest_cache/internal.h
>> @@ -17,6 +17,7 @@
>>   #define INIT_IN_PROGRESS	0	/* Digest cache being initialized. */
>>   #define INVALID			1	/* Digest cache marked as invalid. */
>>   #define IS_DIR			2	/* Digest cache created from dir. */
>> +#define DIR_PREFETCH		3	/* Prefetching requested for dir. */
>>   
>>   /**
>>    * struct readdir_callback - Structure to store information for dir iteration
>> @@ -37,6 +38,7 @@ struct readdir_callback {
>>    * @digest_cache: Digest cache associated to the directory entry
>>    * @digest_cache_mutex: Protects @digest_cache
>>    * @seq_num: Sequence number of the directory entry from file name
>> + * @prefetched: Whether the digest list has been already prefetched
>>    * @name: File name of the directory entry
>>    *
>>    * This structure represents a directory entry with a digest cache created
>> @@ -47,6 +49,7 @@ struct dir_entry {
>>   	struct digest_cache *digest_cache;
>>   	struct mutex digest_cache_mutex;
>>   	unsigned int seq_num;
>> +	bool prefetched;
>>   	char name[];
>>   } __packed;
>>   
>> @@ -205,7 +208,8 @@ digest_cache_from_file_sec(const struct file *file)
>>   /* main.c */
>>   struct digest_cache *digest_cache_create(struct dentry *dentry,
>>   					 struct path *digest_list_path,
>> -					 char *path_str, char *filename);
>> +					 char *path_str, char *filename,
>> +					 bool prefetch_req, bool prefetch);
>>   
>>   /* htable.c */
>>   int digest_cache_htable_init(struct digest_cache *digest_cache, u64 num_digests,
>> @@ -236,6 +240,11 @@ digest_cache_dir_lookup_digest(struct dentry *dentry,
>>   			       struct path *digest_list_path,
>>   			       struct digest_cache *digest_cache, u8 *digest,
>>   			       enum hash_algo algo);
>> +struct digest_cache *
>> +digest_cache_dir_lookup_filename(struct dentry *dentry,
>> +				 struct path *digest_list_path,
>> +				 struct digest_cache *digest_cache,
>> +				 char *filename);
>>   void digest_cache_dir_free(struct digest_cache *digest_cache);
>>   
>>   #endif /* _DIGEST_CACHE_INTERNAL_H */
>> diff --git a/security/digest_cache/main.c b/security/digest_cache/main.c
>> index 15f1486610a3..a5616fd07c1d 100644
>> --- a/security/digest_cache/main.c
>> +++ b/security/digest_cache/main.c
>> @@ -83,6 +83,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
>>    * @digest_list_path: Path structure of the digest list
>>    * @path_str: Path string of the digest list
>>    * @filename: Digest list file name (can be an empty string)
>> + * @prefetch_req: Whether prefetching has been requested
>> + * @prefetch: Whether prefetching of a digest list is being done
>>    *
>>    * This function first locates, from the passed path, the digest list inode
>>    * from which the digest cache will be created or retrieved (if it already
>> @@ -109,7 +111,8 @@ static void digest_cache_free(struct digest_cache *digest_cache)
>>    */
>>   struct digest_cache *digest_cache_create(struct dentry *dentry,
>>   					 struct path *digest_list_path,
>> -					 char *path_str, char *filename)
>> +					 char *path_str, char *filename,
>> +					 bool prefetch_req, bool prefetch)
> 
> 
> This has enough parameters to consider separate "digest_cache_descriptor"
> or whatever. In some architectures this is beyond register parameters,
> which is IMHO good threshold to consider that.
> 
> This will make e.g. tracing easier as you have to map only one parameter
> to a known struct to inspect the values.

Uhm, seems still good (6 parameters). Sure, I can make a structure to 
encapsulate the parameters, but will be used only for this purpose. Not 
sure the code understandability will improve.

Thanks

Roberto

>>   {
>>   	struct path file_path;
>>   	struct digest_cache *digest_cache = NULL;
>> @@ -148,6 +151,16 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
>>   				 dentry->d_name.name);
>>   			goto out;
>>   		}
>> +
>> +		if (prefetch) {
>> +			/* Fine to fail, we are just prefetching. */
>> +			ret = digest_cache_populate(NULL, digest_list_path,
>> +						    path_str, filename);
>> +			pr_debug("Digest list %s/%s %s prefetched\n",
>> +				 path_str, filename,
>> +				 !ret ? "has been" : "cannot be");
>> +			goto out;
>> +		}
>>   	}
>>   
>>   	dig_sec = digest_cache_get_security(inode);
>> @@ -176,6 +189,11 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
>>   
>>   	/* Make the other lock contenders wait until creation complete. */
>>   	set_bit(INIT_IN_PROGRESS, &dig_sec->dig_owner->flags);
>> +
>> +	/* Set DIR_PREFETCH if prefetching was requested. */
>> +	if (prefetch_req)
>> +		set_bit(DIR_PREFETCH, &digest_cache->flags);
>> +
>>   	mutex_unlock(&dig_sec->dig_owner_mutex);
>>   
>>   	if (S_ISREG(inode->i_mode)) {
>> @@ -220,6 +238,52 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
>>   	return digest_cache;
>>   }
>>   
>> +/**
>> + * digest_cache_prefetch_requested - Verify if prefetching is requested
>> + * @digest_list_path: Path structure of the digest list directory
>> + * @path_str: Path string of the digest list directory
>> + *
>> + * This function verifies whether or not digest list prefetching is requested.
>> + * If dig_owner exists in the inode security blob, it checks the DIR_PREFETCH
>> + * bit (faster). Otherwise, it reads the new security.dig_prefetch xattr.
>> + *
>> + * Return: True if prefetching is requested, false otherwise.
>> + */
>> +static bool digest_cache_prefetch_requested(struct path *digest_list_path,
>> +					    char *path_str)
>> +{
>> +	struct digest_cache_security *dig_sec;
>> +	bool prefetch_req = false;
>> +	char prefetch_value;
>> +	struct inode *inode;
>> +	int ret;
>> +
>> +	inode = d_backing_inode(digest_list_path->dentry);
>> +	dig_sec = digest_cache_get_security(inode);
>> +	if (unlikely(!dig_sec))
>> +		return false;
>> +
>> +	mutex_lock(&dig_sec->dig_owner_mutex);
>> +	if (dig_sec->dig_owner) {
>> +		/* Reliable test: DIR_PREFETCH set with dig_owner_mutex held. */
>> +		prefetch_req = test_bit(DIR_PREFETCH,
>> +					&dig_sec->dig_owner->flags);
>> +		mutex_unlock(&dig_sec->dig_owner_mutex);
>> +		return prefetch_req;
>> +	}
>> +	mutex_unlock(&dig_sec->dig_owner_mutex);
>> +
>> +	ret = vfs_getxattr(&nop_mnt_idmap, digest_list_path->dentry,
>> +			   XATTR_NAME_DIG_PREFETCH, &prefetch_value, 1);
>> +	if (ret == 1 && prefetch_value == '1') {
>> +		pr_debug("Prefetching has been enabled for directory %s\n",
>> +			 path_str);
>> +		prefetch_req = true;
>> +	}
>> +
>> +	return prefetch_req;
>> +}
>> +
>>   /**
>>    * digest_cache_new - Retrieve digest list file name and request digest cache
>>    * @dentry: Dentry of the inode for which the digest cache will be used
>> @@ -230,13 +294,19 @@ struct digest_cache *digest_cache_create(struct dentry *dentry,
>>    * with that file name. If security.digest_list is not found, this function
>>    * requests the creation of a digest cache on the parent directory.
>>    *
>> + * On prefetching, if the default path is a directory and if
>> + * security.digest_list is found, this function first retrieves the directory
>> + * digest cache, and then calls digest_cache_dir_lookup_filename() to retrieve
>> + * the desired digest cache in that directory.
>> + *
>>    * Return: A new digest cache on success, NULL on error.
>>    */
>>   static struct digest_cache *digest_cache_new(struct dentry *dentry)
>>   {
>>   	char filename[NAME_MAX + 1] = { 0 };
>> -	struct digest_cache *digest_cache = NULL;
>> +	struct digest_cache *digest_cache = NULL, *found;
>>   	struct path default_path;
>> +	bool prefetch_req = false;
>>   	int ret;
>>   
>>   	ret = kern_path(default_path_str, 0, &default_path);
>> @@ -273,9 +343,28 @@ static struct digest_cache *digest_cache_new(struct dentry *dentry)
>>   	pr_debug("Found %s xattr in %s, default path: %s, digest list: %s\n",
>>   		 XATTR_NAME_DIGEST_LIST, dentry->d_name.name, default_path_str,
>>   		 filename);
>> +
>> +	if (filename[0])
>> +		prefetch_req = digest_cache_prefetch_requested(&default_path,
>> +							default_path_str);
>>   create:
>> +	/* On prefetching, retrieve the directory digest cache. */
>>   	digest_cache = digest_cache_create(dentry, &default_path,
>> -					   default_path_str, filename);
>> +					   default_path_str,
>> +					   !prefetch_req ? filename : "",
>> +					   prefetch_req, false);
>> +	if (!digest_cache)
>> +		goto out;
>> +
>> +	if (prefetch_req) {
>> +		/* Find the digest cache with a matching file name. */
>> +		found = digest_cache_dir_lookup_filename(dentry, &default_path,
>> +							 digest_cache,
>> +							 filename);
>> +		/* Release ref. to the directory digest cache. */
>> +		digest_cache_put(digest_cache);
>> +		digest_cache = found;
>> +	}
>>   out:
>>   	path_put(&default_path);
>>   	return digest_cache;
>> diff --git a/security/digest_cache/populate.c b/security/digest_cache/populate.c
>> index 9c2fc2295310..17e7b011c367 100644
>> --- a/security/digest_cache/populate.c
>> +++ b/security/digest_cache/populate.c
>> @@ -143,6 +143,12 @@ int digest_cache_populate(struct digest_cache *digest_cache,
>>   		return ret;
>>   	}
>>   
>> +	/* The caller wants just to read digest lists. */
>> +	if (!digest_cache) {
>> +		ret = 0;
>> +		goto out_vfree;
>> +	}
>> +
>>   	data_len = digest_cache_strip_modsig(data, ret);
>>   
>>   	/* Digest list parsers initialize the hash table and add the digests. */
>> @@ -151,7 +157,7 @@ int digest_cache_populate(struct digest_cache *digest_cache,
>>   	if (ret < 0)
>>   		pr_debug("Error parsing digest list %s%s%s, ret: %d\n",
>>   			 path_str, filename[0] ? "/" : "", filename, ret);
>> -
>> +out_vfree:
>>   	vfree(data);
>>   	return ret;
>>   }
>> diff --git a/security/digest_cache/verif.c b/security/digest_cache/verif.c
>> index 04023240d3b4..c42ae93261e2 100644
>> --- a/security/digest_cache/verif.c
>> +++ b/security/digest_cache/verif.c
>> @@ -33,7 +33,7 @@ static void free_verif(struct digest_cache_verif *verif)
>>    * This function lets a verifier supply verification data about a digest list
>>    * being read to populate the digest cache.
>>    *
>> - * Return: Zero on success, -ENOMEM if out of memory.
>> + * Return: Zero on success, -ENOMEM if out of memory, -ENOENT on prefetching.
>>    */
>>   int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
>>   			   size_t size)
>> @@ -41,6 +41,9 @@ int digest_cache_verif_set(struct file *file, const char *verif_id, void *data,
>>   	struct digest_cache *digest_cache = digest_cache_from_file_sec(file);
>>   	struct digest_cache_verif *new_verif;
>>   
>> +	if (!digest_cache)
>> +		return -ENOENT;
>> +
>>   	/*
>>   	 * All allocations must be atomic (non-sleepable) since kprobe does not
>>   	 * allow otherwise (kprobe is needed for testing).
> 
> 
> BR, Jarkko


