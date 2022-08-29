Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD15A433E
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 08:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiH2GaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2GaJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 02:30:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F19FCC;
        Sun, 28 Aug 2022 23:30:07 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGL9G2F7ZzGpt2;
        Mon, 29 Aug 2022 14:28:18 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 14:30:03 +0800
Subject: Re: [PATCH -next v2 3/6] landlock: add chmod and chown support
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
 <20220827111215.131442-4-xiujianfeng@huawei.com> <Ywpw66EYRDTQIyTx@nuc>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <ecc41701-71eb-cc4b-9ea6-1e3d0e78d138@huawei.com>
Date:   Mon, 29 Aug 2022 14:30:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <Ywpw66EYRDTQIyTx@nuc>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

在 2022/8/28 3:30, Günther Noack 写道:
> Hello!
> 
> the mapping between Landlock rights to LSM hooks is now as follows in
> your patch set:
> 
> * LANDLOCK_ACCESS_FS_CHMOD controls hook_path_chmod
> * LANDLOCK_ACCESS_FS_CHGRP controls hook_path_chown
>    (this hook can restrict both the chown(2) and chgrp(2) syscalls)
> 
> Is this the desired mapping?
> 
> The previous discussion I found on the topic was in
> 
> [1] https://lore.kernel.org/all/5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net/
> [2] https://lore.kernel.org/all/b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com/
> [3] https://lore.kernel.org/all/c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net/
> 
> In my understanding the main arguments were the ones in [2] and [3].
> 
> There were no further responses to [3], so I was under the impression
> that we were gravitating towards an approach where the
> file-metadata-modification operations were grouped more coarsely?
> 
> For example with the approach suggested in [3], which would be to
> group the operations coarsely into (a) one Landlock right for
> modifying file metadata that is used in security contexts, and (b) one
> Landlock right for modifying metadata that was used in non-security
> contexts. That would mean that there would be:
> 
> (a) LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES to control the
> following operations:

LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES looks too long, can we use 
LANDLOCK_ACCESS_FS_MOD_SEC_ATTR and LANDLOCK_ACCESS_FS_MOD_NONSEC_ATTR?

>    * chmod(2)-variants through hook_path_chmod,
>    * chown(2)-variants and chgrp(2)-variants through hook_path_chown,
>    * setxattr(2)-variants and removexattr(2)-variants for extended
>      attributes that are not "user extended attributes" as described in
>      xattr(7) through hook_inode_setxattr and hook_inode_removexattr
> 
> (b) LANDLOCK_ACCESS_FS_MODIFY_NON_SECURITY_ATTRIBUTES to control the
> following operations:
>    * utimes(2) and other operations for setting other non-security
>      sensitive attributes, probably through hook_inode_setattr(?)
>    * xattr modifications like above, but for the "user extended
>      attributes", though hook_inode_setxattr and hook_inode_removexattr
> 
> In my mind, this would be a sensible grouping, and it would also help
> to decouple the userspace-exposed API from the underlying
> implementation, as Casey suggested to do in [2].
> 
> Specifically for this patch set, if you want to use this grouping, you
> would only need to add one new Landlock right
> (LANDLOCK_ACCESS_FS_MODIFY_SECURITY_ATTRIBUTES) as described above
> under (a) (and maybe we can find a shorter name for it... :))?
> 
> Did I miss any operations here that would be necessary to restrict?
> 
> Would that make sense to you? Xiu, what is your opinion on how this
> should be grouped? Do you have use cases in mind where a more
> fine-grained grouping would be required?
> 
> —Günther
> 
> P.S.: Regarding utimes: The hook_inode_setattr hook *also* gets called
> on a variety on attribute changes including file ownership, file size
> and file mode, so it might potentially interact with a bunch of other
> existing Landlock rights. Maybe that is not the right approach. In any
> case, it seems like it might require more thinking and it might be
> sensible to do that in a separate patch set IMHO.
> 
> On Sat, Aug 27, 2022 at 07:12:12PM +0800, Xiu Jianfeng wrote:
>> Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHGRP to
>> support restriction to chmod(2) and chown(2) with landlock.
>>
>> If these two access rights are set on a directory, they only take effect
>> for its context, not the directory itself.
>>
>> This patch also change the landlock ABI version from 3 to 4.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   include/uapi/linux/landlock.h                | 10 +++--
>>   security/landlock/fs.c                       | 43 +++++++++++++++++++-
>>   security/landlock/limits.h                   |  2 +-
>>   security/landlock/syscalls.c                 |  2 +-
>>   tools/testing/selftests/landlock/base_test.c |  2 +-
>>   tools/testing/selftests/landlock/fs_test.c   |  6 ++-
>>   6 files changed, 56 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>> index 735b1fe8326e..07b73626ff20 100644
>> --- a/include/uapi/linux/landlock.h
>> +++ b/include/uapi/linux/landlock.h
>> @@ -141,14 +141,16 @@ struct landlock_path_beneath_attr {
>>    *   directory) parent.  Otherwise, such actions are denied with errno set to
>>    *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>>    *   efficiently deal with an unrecoverable error.
>> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
>> + * - %LANDLOCK_ACCESS_FS_CHGRP: Change the owner and/or group of a file.
>>    *
>>    * .. warning::
>>    *
>>    *   It is currently not possible to restrict some file-related actions
>>    *   accessible through these syscall families: :manpage:`chdir(2)`,
>> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
>> - *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>> + *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`setxattr(2)`,
>> + *   :manpage:`utime(2)`,:manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
>> + *   :manpage:`access(2)`.
>>    *   Future Landlock evolutions will enable to restrict them.
>>    */
>>   /* clang-format off */
>> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>>   #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>> +#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 15)
>> +#define LANDLOCK_ACCESS_FS_CHGRP			(1ULL << 16)
>>   /* clang-format on */
>>
>>   #endif /* _UAPI_LINUX_LANDLOCK_H */
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index 4ef614a4ea22..6ac83d96ada7 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -185,7 +185,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>>   	LANDLOCK_ACCESS_FS_READ_FILE | \
>> -	LANDLOCK_ACCESS_FS_TRUNCATE)
>> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
>> +	LANDLOCK_ACCESS_FS_CHMOD | \
>> +	LANDLOCK_ACCESS_FS_CHGRP)
>>   /* clang-format on */
>>
>>   /*
>> @@ -690,6 +692,31 @@ static inline int current_check_access_path(const struct path *const path,
>>   	return check_access_path(dom, path, access_request);
>>   }
>>
>> +static inline int
>> +current_check_access_path_context_only(const struct path *const path,
>> +				       const access_mask_t access_request)
>> +{
>> +	const struct landlock_ruleset *const dom =
>> +		landlock_get_current_domain();
>> +	struct path eff_path;
>> +	int ret;
>> +
>> +	if (!dom)
>> +		return 0;
>> +	eff_path = *path;
>> +	/* if it's dir, check its visible parent. */
>> +	if (d_is_dir(eff_path.dentry)) {
>> +		path_get(&eff_path);
>> +		/* dont care if reaches the root or not. */
>> +		walk_to_visible_parent(&eff_path);
>> +		ret = current_check_access_path(&eff_path, access_request);
>> +		path_put(&eff_path);
>> +	} else {
>> +		ret = current_check_access_path(&eff_path, access_request);
>> +	}
>> +	return ret;
>> +}
>> +
>>   static inline access_mask_t get_mode_access(const umode_t mode)
>>   {
>>   	switch (mode & S_IFMT) {
>> @@ -1177,6 +1204,18 @@ static int hook_path_truncate(const struct path *const path)
>>   	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>>   }
>>
>> +static int hook_path_chmod(const struct path *const path, umode_t mode)
>> +{
>> +	return current_check_access_path_context_only(path,
>> +					LANDLOCK_ACCESS_FS_CHMOD);
>> +}
>> +
>> +static int hook_path_chown(const struct path *const path, kuid_t uid, kgid_t gid)
>> +{
>> +	return current_check_access_path_context_only(path,
>> +					LANDLOCK_ACCESS_FS_CHGRP);
>> +}
>> +
>>   /* File hooks */
>>
>>   static inline access_mask_t get_file_access(const struct file *const file)
>> @@ -1230,6 +1269,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>>   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>>   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>>   	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
>> +	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
>> +	LSM_HOOK_INIT(path_chown, hook_path_chown),
>>
>>   	LSM_HOOK_INIT(file_open, hook_file_open),
>>   };
>> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
>> index 82288f0e9e5e..7cdd7d467d12 100644
>> --- a/security/landlock/limits.h
>> +++ b/security/landlock/limits.h
>> @@ -18,7 +18,7 @@
>>   #define LANDLOCK_MAX_NUM_LAYERS		16
>>   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>>
>> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
>> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHGRP
>>   #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>>   #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>>
>> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
>> index f4d6fc7ed17f..469e0e11735c 100644
>> --- a/security/landlock/syscalls.c
>> +++ b/security/landlock/syscalls.c
>> @@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
>>   	.write = fop_dummy_write,
>>   };
>>
>> -#define LANDLOCK_ABI_VERSION 3
>> +#define LANDLOCK_ABI_VERSION 4
>>
>>   /**
>>    * sys_landlock_create_ruleset - Create a new ruleset
>> diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
>> index 72cdae277b02..9f00582f639c 100644
>> --- a/tools/testing/selftests/landlock/base_test.c
>> +++ b/tools/testing/selftests/landlock/base_test.c
>> @@ -75,7 +75,7 @@ TEST(abi_version)
>>   	const struct landlock_ruleset_attr ruleset_attr = {
>>   		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
>>   	};
>> -	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
>> +	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
>>   					     LANDLOCK_CREATE_RULESET_VERSION));
>>
>>   	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
>> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
>> index debe2d9ea6cf..f513cd8d9d51 100644
>> --- a/tools/testing/selftests/landlock/fs_test.c
>> +++ b/tools/testing/selftests/landlock/fs_test.c
>> @@ -404,9 +404,11 @@ TEST_F_FORK(layout1, inval)
>>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>>   	LANDLOCK_ACCESS_FS_READ_FILE | \
>> -	LANDLOCK_ACCESS_FS_TRUNCATE)
>> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
>> +	LANDLOCK_ACCESS_FS_CHMOD | \
>> +	LANDLOCK_ACCESS_FS_CHGRP)
>>
>> -#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
>> +#define ACCESS_LAST LANDLOCK_ACCESS_FS_CHGRP
>>
>>   #define ACCESS_ALL ( \
>>   	ACCESS_FILE | \
>> --
>> 2.17.1
>>
> 
> --
> .
> 
