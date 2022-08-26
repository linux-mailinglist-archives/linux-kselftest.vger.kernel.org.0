Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479135A26AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 13:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiHZLOi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHZLOh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 07:14:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97BDD59A8;
        Fri, 26 Aug 2022 04:14:35 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDcYx6hJmzYcrc;
        Fri, 26 Aug 2022 19:10:13 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 19:14:33 +0800
Subject: Re: [PATCH -next 2/5] landlock: add chmod and chown support
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
CC:     <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <shuah@kernel.org>, <corbet@lwn.net>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-3-xiujianfeng@huawei.com> <YwPKG3G9PlStYPkz@nuc>
 <5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net>
 <6d6edd60-5ed7-0f5d-d641-75e006c0e60e@huawei.com>
 <8cb3b7df-fb2f-3e3f-7805-4b14cf1bdf90@digikod.net>
 <c447b4d3-8bc7-5277-5d49-7f4ffd0b5a5b@huawei.com>
 <8b4aa750-91f3-ca95-bb50-b2023676bc4e@digikod.net>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <f5f968d5-3e48-7e1a-d942-59136e0da4a5@huawei.com>
Date:   Fri, 26 Aug 2022 19:14:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <8b4aa750-91f3-ca95-bb50-b2023676bc4e@digikod.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

在 2022/8/26 17:36, Mickaël Salaün 写道:
> 
> On 26/08/2022 10:36, xiujianfeng wrote:
>> Hi,
>>
>> 在 2022/8/24 19:44, Mickaël Salaün 写道:
>>>
>>> On 23/08/2022 14:50, xiujianfeng wrote:
>>>>
>>>>
>>>> 在 2022/8/23 5:07, Mickaël Salaün 写道:
>>>>>
>>>>> On 22/08/2022 20:25, Günther Noack wrote:
>>>>>> Hi!
>>>>>>
>>>>>> Thanks for sending this patch set! :)
>>>>>>
>>>>>> On Mon, Aug 22, 2022 at 07:46:58PM +0800, Xiu Jianfeng wrote:
>>>>>>> Add two flags LANDLOCK_ACCESS_FS_CHMOD and 
>>>>>>> LANDLOCK_ACCESS_FS_CHOWN to
>>>>>>> support restriction to chmod(2) and chown(2) with landlock.
>>>>>>>
>>>>>>> Also change the landlock ABI version from 3 to 4.
>>>>>>>
>>>>>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>>>>>> ---
>>>>>>>     include/uapi/linux/landlock.h                |  8 ++++++--
>>>>>>>     security/landlock/fs.c                       | 16 
>>>>>>> +++++++++++++++-
>>>>>>>     security/landlock/limits.h                   |  2 +-
>>>>>>>     security/landlock/syscalls.c                 |  2 +-
>>>>>>>     tools/testing/selftests/landlock/base_test.c |  2 +-
>>>>>>>     tools/testing/selftests/landlock/fs_test.c   |  6 ++++--
>>>>>>>     6 files changed, 28 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/uapi/linux/landlock.h
>>>>>>> b/include/uapi/linux/landlock.h
>>>>>>> index 735b1fe8326e..5ce633c92722 100644
>>>>>>> --- a/include/uapi/linux/landlock.h
>>>>>>> +++ b/include/uapi/linux/landlock.h
>>>>>>> @@ -141,13 +141,15 @@ struct landlock_path_beneath_attr {
>>>>>>>      *   directory) parent.  Otherwise, such actions are denied with
>>>>>>> errno set to
>>>>>>>      *   EACCES.  The EACCES errno prevails over EXDEV to let user
>>>>>>> space
>>>>>>>      *   efficiently deal with an unrecoverable error.
>>>>>>> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a 
>>>>>>> file.
>>>>>>> + * - %LANDLOCK_ACCESS_FS_CHOWN: Change the owner and/or group of a
>>>>>>> file.
>>>>>
>>>>> This section talk about "access rights that only apply to the 
>>>>> content of
>>>>> a directory, not the directory itself", which is not correct (see
>>>>> LANDLOCK_ACCESS_FS_READ_DIR). I'd like these access rights to remain
>>>>> here but this kernel patch and the related tests need some changes.
>>>>>
>>>>> What about a LANDLOCK_ACCESS_FS_CHGRP? I'm not sure if we need to
>>>>> differentiate these actions or not, but we need arguments to choose.
>>>>>
>>>>>
>>>>>>>      *
>>>>>>>      * .. warning::
>>>>>>>      *
>>>>>>>      *   It is currently not possible to restrict some file-related
>>>>>>> actions
>>>>>>>      *   accessible through these syscall families:
>>>>>>> :manpage:`chdir(2)`,
>>>>>>> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>>>>>>> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`,
>>>>>>> :manpage:`utime(2)`,
>>>>>>> + *   :manpage:`stat(2)`, :manpage:`flock(2)`,
>>>>>>> + *   :manpage:`setxattr(2)`, :manpage:`utime(2)`,
>>>>>>
>>>>>> *formatting nit*
>>>>>> We could fill up the full line width here
>>>>>>
>>>>>>>      *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
>>>>>>> :manpage:`access(2)`.
>>>>>>>      *   Future Landlock evolutions will enable to restrict them.
>>>>>>>      */
>>>>>>> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>>>>>>>     #define LANDLOCK_ACCESS_FS_MAKE_SYM            (1ULL << 12)
>>>>>>>     #define LANDLOCK_ACCESS_FS_REFER            (1ULL << 13)
>>>>>>>     #define LANDLOCK_ACCESS_FS_TRUNCATE            (1ULL << 14)
>>>>>>> +#define LANDLOCK_ACCESS_FS_CHMOD            (1ULL << 15)
>>>>>>> +#define LANDLOCK_ACCESS_FS_CHOWN            (1ULL << 16)
>>>>>>>     /* clang-format on */
>>>>>>>
>>>>>>>     #endif /* _UAPI_LINUX_LANDLOCK_H */
>>>>>>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>>>>>>> index c57f581a9cd5..c25d5f89c8be 100644
>>>>>>> --- a/security/landlock/fs.c
>>>>>>> +++ b/security/landlock/fs.c
>>>>>>> @@ -147,7 +147,9 @@ static struct landlock_object
>>>>>>> *get_inode_object(struct inode *const inode)
>>>>>>>         LANDLOCK_ACCESS_FS_EXECUTE | \
>>>>>>>         LANDLOCK_ACCESS_FS_WRITE_FILE | \
>>>>>>>         LANDLOCK_ACCESS_FS_READ_FILE | \
>>>>>>> -    LANDLOCK_ACCESS_FS_TRUNCATE)
>>>>>>> +    LANDLOCK_ACCESS_FS_TRUNCATE | \
>>>>>>> +    LANDLOCK_ACCESS_FS_CHMOD | \
>>>>>>> +    LANDLOCK_ACCESS_FS_CHOWN)
>>>>>>>     /* clang-format on */
>>>>>>>
>>>>>>>     /*
>>>>>>> @@ -1146,6 +1148,16 @@ static int hook_path_truncate(const struct
>>>>>>> path *const path)
>>>>>>>         return current_check_access_path(path,
>>>>>>> LANDLOCK_ACCESS_FS_TRUNCATE);
>>>>>>>     }
>>>>>>>
>>>>>>> +static int hook_path_chmod(const struct path *const dir, umode_t
>>>>>>> mode)
>>>>>
>>>>> This is not a "dir" but a "path".
>>>>>
>>>>>
>>>>>>> +{
>>>>>>> +    return current_check_access_path(dir, 
>>>>>>> LANDLOCK_ACCESS_FS_CHMOD);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int hook_path_chown(const struct path *const dir, kuid_t 
>>>>>>> uid,
>>>>>>> kgid_t gid)
>>>>>
>>>>> Same here.
>>>>>
>>>>>
>>>>>>> +{
>>>>>>> +    return current_check_access_path(dir, 
>>>>>>> LANDLOCK_ACCESS_FS_CHOWN);
>>>>>>> +}
>>>>>>
>>>>>> One implication of this approach is that the chown+chmod right on a
>>>>>> directory's contents are always going together with the same 
>>>>>> rights on
>>>>>> the directory itself.
>>>>>>
>>>>>> For example, if you grant chmod+chown access rights for "datadir/",
>>>>>> the command "chmod 0600 datadir/file1" will work, but so will the
>>>>>> command "chmod 0600 datadir". But the approach of checking just the
>>>>>> parent directory's rights is also inflexible if you think through the
>>>>>> kinds of rights you can grant with it. (It would also not be possible
>>>>>> to grant chmod+chown on individual files.)
>>>>>
>>>>> Good point. For an initial chmod/chown/chgrp access right, I'd 
>>>>> prefer to
>>>>> be able to set these access rights on a directory but only for its
>>>>> content, not the directory itself. I think it is much safer and should
>>>>> be enough for the majority of use cases, but let me know if I'm 
>>>>> missing
>>>>> something. I'm not sure being able to change the root directory access
>>>>> rights may be a good idea anyway (even for containers). ;)
>>>>>
>>>>> A path_beneath rule enables to identify a file hierarchy (i.e. the
>>>>> content of a directory), not to make modifications visible outside of
>>>>> the directory identifying the hierarchy (hence the "parent_fd" field),
>>>>> which would be the case with the current chmod/chown access rights.
>>>>>
>>>>>
>>>>>>
>>>>>> Do you have any thoughts on how to resolve this if this flexibility
>>>>>> might be needed?
>>>>>>
>>>>>> I wonder whether the right way to resolve this would be to give users
>>>>>> a way to make that distinction at the level of landlock_add_rule(),
>>>>>> with an API like this (note the additional flag):
>>>>>>
>>>>>>      err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>>>>>>                              &path_beneath, 
>>>>>> LANDLOCK_STRICTLY_BENEATH);
>>>>>>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>
>>>>>> Multiple calls of landlock_add_rule() on the same file are already
>>>>>> today joining the requested access rights, so it would be possible to
>>>>>> mix-and-match "strict beneath" with "beneath" rights on the same
>>>>>> directory, and it would work in the same way for other access rights
>>>>>> as well.
>>>>>
>>>>> This kind of option is interesting. For now, some access rights are 
>>>>> kind
>>>>> of "doubled" to enable to differentiate between a file and a directory
>>>>> (i.e. READ_DIR/READ_FILE, REMOVE_DIR/REMOVE_FILE, WRITE_FILE/MAKE_*)
>>>>> when it may be useful, but this is different.
>>>>>
>>>>> I think this "strictly beneath" behavior should be the default, 
>>>>> which is
>>>>> currently the case.
>>>>>
>>>>>
>>>>>>
>>>>>> To be clear: I'm proposing this approach not because I think it 
>>>>>> should
>>>>>> be part of this patch set, but because it would be good to have a way
>>>>>> forward if that kind of flexibility is needed in the future.
>>>>>>
>>>>>> Does that seem reasonable?
>>>>>
>>>>> This is the kind of questions that made such access rights not
>>>>> appropriate for the initial version of Landlock. But we should talk
>>>>> about that now.
>>>>
>>>> Hi Günther and Mickaël,
>>>>
>>>> Thanks for your comments, so I think the conclusion here is that we 
>>>> have
>>>> to make sure that in this patchset chown/chmod access rights can be set
>>>> on a directory only for its content, not the directory itself, right?
>>>> any good idea about how to implement this? :)
>>>
>>> In such hook code, you need to get the parent directory of the path
>>> argument. This require to use and refactor the
>>> check_access_path_dual/jump_up part in a dedicated helper (and take care
>>> of all the corner cases).
>>> .
>>
>> Sorry, I don't quite understand what you mean, but I have another idea,
>> how about this?
>>
>> static int hook_path_chown(const struct path *const path, kuid_t uid,
>> kgid_t gid)
>> {
>>           int ret;
>>           struct dentry *parent_dentry;
>>           struct path eff_path;
>>
>>           eff_path = *path;
>>           path_get(&eff_path);
>>           if (d_is_dir(eff_path.dentry)) {
>>                   parent_dentry = dget_parent(eff_path.dentry);
>>                   dput(eff_path.dentry);
>>                   eff_path.dentry = parent_dentry;
>>           }
>>           ret = current_check_access_path(&eff_path,
>> LANDLOCK_ACCESS_FS_CHGRP);
>>           path_put(&eff_path);
>>
>>           return ret;
>> }
> 
> This is close but it ignores mount points (e.g. path being used multiple 
> time as a mount point). This is why we need to use follow_up(), hence my 
> previous comment. This is the kind of corner case that require tests.
> 
> This helper could look like this:
> enum walk_result walk_to_visible_parent(struct path *path)
> It could then return either WALK_CONTINUE, WALK_DENIED, or WALK_ALLOWED.
> .

Thanks, It's more clear now, except the return type, I think void type 
like follows maybe ok:

static void walk_to_visible_parent(struct path *path)
{
         struct dentry *parent_dentry;

         path_get(path);
         /* don't need to follow_up if not dir */
         if (!d_is_dir(path->dentry))
                 return;

jump_up:
         if (path->dentry == path->mnt->mnt_root) {
                 if (follow_up(path)) {
                         /* Ignores hidden mount points. */
                         goto jump_up;
                 } else {
                         /*Stops at the real root. */
                         return;
                 }
         }
         parent_dentry = dget_parent(path->dentry);
         dput(path->dentry);
         path->dentry = parent_dentry;
}

static void walk_to_visible_parent_end(struct path *path)
{
         path_put(path);
}

static int hook_path_chown(const struct path *const path, kuid_t uid, 
kgid_t gid)
{
         int ret;
         struct path eff_path;

         eff_path = *path;
         walk_to_visible_parent(&eff_path);
         ret = current_check_access_path(&eff_path, 
LANDLOCK_ACCESS_FS_CHGRP);
         walk_to_visible_parent_end(&eff_path);

         return ret;
}

