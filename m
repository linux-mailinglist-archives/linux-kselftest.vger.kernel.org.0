Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1269059CA7E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbiHVVH6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237772AbiHVVH5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:07:57 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3261540556
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:07:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBQ1J67JzzMpvC3;
        Mon, 22 Aug 2022 23:07:48 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBQ1H1tThzlh8TB;
        Mon, 22 Aug 2022 23:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661202468;
        bh=JmtV3UMZPlyFX03yNAu0hELxyKITVf4OtztEZawP3OQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=MZuL163gBM9K6Nn7SX3lOXbrxpasXILbWwvB3YS8nQcmxTBAeTRZKUhBYCM15dSzb
         6abQ5wv2+22Oa+imLzgMp7H/0aE4apw69iaJ58ZP409QgFLb/oZxBow6+zMf+H6Jot
         VXjsieAVPtHzYwDYHcpmUR9SNsDNEMFa1ytl5QyY=
Message-ID: <5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net>
Date:   Mon, 22 Aug 2022 23:07:46 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-3-xiujianfeng@huawei.com> <YwPKG3G9PlStYPkz@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next 2/5] landlock: add chmod and chown support
In-Reply-To: <YwPKG3G9PlStYPkz@nuc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 22/08/2022 20:25, Günther Noack wrote:
> Hi!
> 
> Thanks for sending this patch set! :)
> 
> On Mon, Aug 22, 2022 at 07:46:58PM +0800, Xiu Jianfeng wrote:
>> Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHOWN to
>> support restriction to chmod(2) and chown(2) with landlock.
>>
>> Also change the landlock ABI version from 3 to 4.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   include/uapi/linux/landlock.h                |  8 ++++++--
>>   security/landlock/fs.c                       | 16 +++++++++++++++-
>>   security/landlock/limits.h                   |  2 +-
>>   security/landlock/syscalls.c                 |  2 +-
>>   tools/testing/selftests/landlock/base_test.c |  2 +-
>>   tools/testing/selftests/landlock/fs_test.c   |  6 ++++--
>>   6 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
>> index 735b1fe8326e..5ce633c92722 100644
>> --- a/include/uapi/linux/landlock.h
>> +++ b/include/uapi/linux/landlock.h
>> @@ -141,13 +141,15 @@ struct landlock_path_beneath_attr {
>>    *   directory) parent.  Otherwise, such actions are denied with errno set to
>>    *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>>    *   efficiently deal with an unrecoverable error.
>> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
>> + * - %LANDLOCK_ACCESS_FS_CHOWN: Change the owner and/or group of a file.

This section talk about "access rights that only apply to the content of 
a directory, not the directory itself", which is not correct (see 
LANDLOCK_ACCESS_FS_READ_DIR). I'd like these access rights to remain 
here but this kernel patch and the related tests need some changes.

What about a LANDLOCK_ACCESS_FS_CHGRP? I'm not sure if we need to 
differentiate these actions or not, but we need arguments to choose.


>>    *
>>    * .. warning::
>>    *
>>    *   It is currently not possible to restrict some file-related actions
>>    *   accessible through these syscall families: :manpage:`chdir(2)`,
>> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
>> + *   :manpage:`stat(2)`, :manpage:`flock(2)`,
>> + *   :manpage:`setxattr(2)`, :manpage:`utime(2)`,
> 
> *formatting nit*
> We could fill up the full line width here
> 
>>    *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>>    *   Future Landlock evolutions will enable to restrict them.
>>    */
>> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>>   #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
>>   #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
>>   #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
>> +#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 15)
>> +#define LANDLOCK_ACCESS_FS_CHOWN			(1ULL << 16)
>>   /* clang-format on */
>>
>>   #endif /* _UAPI_LINUX_LANDLOCK_H */
>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>> index c57f581a9cd5..c25d5f89c8be 100644
>> --- a/security/landlock/fs.c
>> +++ b/security/landlock/fs.c
>> @@ -147,7 +147,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>>   	LANDLOCK_ACCESS_FS_EXECUTE | \
>>   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
>>   	LANDLOCK_ACCESS_FS_READ_FILE | \
>> -	LANDLOCK_ACCESS_FS_TRUNCATE)
>> +	LANDLOCK_ACCESS_FS_TRUNCATE | \
>> +	LANDLOCK_ACCESS_FS_CHMOD | \
>> +	LANDLOCK_ACCESS_FS_CHOWN)
>>   /* clang-format on */
>>
>>   /*
>> @@ -1146,6 +1148,16 @@ static int hook_path_truncate(const struct path *const path)
>>   	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
>>   }
>>
>> +static int hook_path_chmod(const struct path *const dir, umode_t mode)

This is not a "dir" but a "path".


>> +{
>> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHMOD);
>> +}
>> +
>> +static int hook_path_chown(const struct path *const dir, kuid_t uid, kgid_t gid)

Same here.


>> +{
>> +	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHOWN);
>> +}
> 
> One implication of this approach is that the chown+chmod right on a
> directory's contents are always going together with the same rights on
> the directory itself.
> 
> For example, if you grant chmod+chown access rights for "datadir/",
> the command "chmod 0600 datadir/file1" will work, but so will the
> command "chmod 0600 datadir". But the approach of checking just the
> parent directory's rights is also inflexible if you think through the
> kinds of rights you can grant with it. (It would also not be possible
> to grant chmod+chown on individual files.)

Good point. For an initial chmod/chown/chgrp access right, I'd prefer to 
be able to set these access rights on a directory but only for its 
content, not the directory itself. I think it is much safer and should 
be enough for the majority of use cases, but let me know if I'm missing 
something. I'm not sure being able to change the root directory access 
rights may be a good idea anyway (even for containers). ;)

A path_beneath rule enables to identify a file hierarchy (i.e. the 
content of a directory), not to make modifications visible outside of 
the directory identifying the hierarchy (hence the "parent_fd" field), 
which would be the case with the current chmod/chown access rights.


> 
> Do you have any thoughts on how to resolve this if this flexibility
> might be needed?
> 
> I wonder whether the right way to resolve this would be to give users
> a way to make that distinction at the level of landlock_add_rule(),
> with an API like this (note the additional flag):
> 
>    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>                            &path_beneath, LANDLOCK_STRICTLY_BENEATH);
>                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Multiple calls of landlock_add_rule() on the same file are already
> today joining the requested access rights, so it would be possible to
> mix-and-match "strict beneath" with "beneath" rights on the same
> directory, and it would work in the same way for other access rights
> as well.

This kind of option is interesting. For now, some access rights are kind 
of "doubled" to enable to differentiate between a file and a directory 
(i.e. READ_DIR/READ_FILE, REMOVE_DIR/REMOVE_FILE, WRITE_FILE/MAKE_*) 
when it may be useful, but this is different.

I think this "strictly beneath" behavior should be the default, which is 
currently the case.


> 
> To be clear: I'm proposing this approach not because I think it should
> be part of this patch set, but because it would be good to have a way
> forward if that kind of flexibility is needed in the future.
> 
> Does that seem reasonable?

This is the kind of questions that made such access rights not 
appropriate for the initial version of Landlock. But we should talk 
about that now.


> 
>> +
>>   /* File hooks */
>>
>>   static inline access_mask_t get_file_access(const struct file *const file)
>> @@ -1199,6 +1211,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
>>   	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
>>   	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
>>   	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
>> +	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
>> +	LSM_HOOK_INIT(path_chown, hook_path_chown),
>>
>>   	LSM_HOOK_INIT(file_open, hook_file_open),
>>   };
>> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
>> index 82288f0e9e5e..08858da7fb4f 100644
>> --- a/security/landlock/limits.h
>> +++ b/security/landlock/limits.h
>> @@ -18,7 +18,7 @@
>>   #define LANDLOCK_MAX_NUM_LAYERS		16
>>   #define LANDLOCK_MAX_NUM_RULES		U32_MAX
>>
>> -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
>> +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHOWN
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
> 
> ABI version 3 has not made it into a stable kernel yet; I wonder
> whether it wouldn't be easier to just bundle the truncate, chmod and
> chown rights as part of ABI version 3 (assuming that the patches make
> it into a stable release together)?
> 
> Mickaël, do you have an opinion on this?

I'll make sure to only have one ABI version bump per kernel release, but 
it is OK to bump it for this patch series in case it is not ready for 
the next merge window. I'll change it if required when merging into my 
tree. It is easier to change the code to decrease the version, so please 
keep it as is. ;)
