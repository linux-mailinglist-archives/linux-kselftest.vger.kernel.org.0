Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6439C59F8C0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiHXLpD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHXLpB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 07:45:01 -0400
X-Greylist: delayed 137959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 04:44:57 PDT
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6764D4C0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 04:44:57 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MCPQv52G4zMqBfr;
        Wed, 24 Aug 2022 13:44:55 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MCPQt0Xxwzlh8TD;
        Wed, 24 Aug 2022 13:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661341495;
        bh=1A9w6LBApFmHy8AyI91NBSquKjP8ISZPMKdkvU7c3qU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=ELdnmWIYHEW0cpvK8yP+KBxoP+OZ3AsDLeVhLwbdZOuSJRUGKAh8nALszvrZcHiBI
         y+IEb4AcfPcXHE3tmXwOTcBgbcwEqswwR581B1vKVoyvBlpRDEtnw+yenjdP8yC5Eu
         EptJG+SP34k9or7OMx1YGjN5TzIKbeB090t+hNYs=
Message-ID: <8cb3b7df-fb2f-3e3f-7805-4b14cf1bdf90@digikod.net>
Date:   Wed, 24 Aug 2022 13:44:52 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, corbet@lwn.net,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <20220822114701.26975-3-xiujianfeng@huawei.com> <YwPKG3G9PlStYPkz@nuc>
 <5873455f-fff9-618c-25b1-8b6a4ec94368@digikod.net>
 <6d6edd60-5ed7-0f5d-d641-75e006c0e60e@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next 2/5] landlock: add chmod and chown support
In-Reply-To: <6d6edd60-5ed7-0f5d-d641-75e006c0e60e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 23/08/2022 14:50, xiujianfeng wrote:
> 
> 
> 在 2022/8/23 5:07, Mickaël Salaün 写道:
>>
>> On 22/08/2022 20:25, Günther Noack wrote:
>>> Hi!
>>>
>>> Thanks for sending this patch set! :)
>>>
>>> On Mon, Aug 22, 2022 at 07:46:58PM +0800, Xiu Jianfeng wrote:
>>>> Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHOWN to
>>>> support restriction to chmod(2) and chown(2) with landlock.
>>>>
>>>> Also change the landlock ABI version from 3 to 4.
>>>>
>>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>>> ---
>>>>    include/uapi/linux/landlock.h                |  8 ++++++--
>>>>    security/landlock/fs.c                       | 16 +++++++++++++++-
>>>>    security/landlock/limits.h                   |  2 +-
>>>>    security/landlock/syscalls.c                 |  2 +-
>>>>    tools/testing/selftests/landlock/base_test.c |  2 +-
>>>>    tools/testing/selftests/landlock/fs_test.c   |  6 ++++--
>>>>    6 files changed, 28 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/uapi/linux/landlock.h
>>>> b/include/uapi/linux/landlock.h
>>>> index 735b1fe8326e..5ce633c92722 100644
>>>> --- a/include/uapi/linux/landlock.h
>>>> +++ b/include/uapi/linux/landlock.h
>>>> @@ -141,13 +141,15 @@ struct landlock_path_beneath_attr {
>>>>     *   directory) parent.  Otherwise, such actions are denied with
>>>> errno set to
>>>>     *   EACCES.  The EACCES errno prevails over EXDEV to let user space
>>>>     *   efficiently deal with an unrecoverable error.
>>>> + * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
>>>> + * - %LANDLOCK_ACCESS_FS_CHOWN: Change the owner and/or group of a
>>>> file.
>>
>> This section talk about "access rights that only apply to the content of
>> a directory, not the directory itself", which is not correct (see
>> LANDLOCK_ACCESS_FS_READ_DIR). I'd like these access rights to remain
>> here but this kernel patch and the related tests need some changes.
>>
>> What about a LANDLOCK_ACCESS_FS_CHGRP? I'm not sure if we need to
>> differentiate these actions or not, but we need arguments to choose.
>>
>>
>>>>     *
>>>>     * .. warning::
>>>>     *
>>>>     *   It is currently not possible to restrict some file-related
>>>> actions
>>>>     *   accessible through these syscall families: :manpage:`chdir(2)`,
>>>> - *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
>>>> - *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
>>>> + *   :manpage:`stat(2)`, :manpage:`flock(2)`,
>>>> + *   :manpage:`setxattr(2)`, :manpage:`utime(2)`,
>>>
>>> *formatting nit*
>>> We could fill up the full line width here
>>>
>>>>     *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
>>>>     *   Future Landlock evolutions will enable to restrict them.
>>>>     */
>>>> @@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
>>>>    #define LANDLOCK_ACCESS_FS_MAKE_SYM            (1ULL << 12)
>>>>    #define LANDLOCK_ACCESS_FS_REFER            (1ULL << 13)
>>>>    #define LANDLOCK_ACCESS_FS_TRUNCATE            (1ULL << 14)
>>>> +#define LANDLOCK_ACCESS_FS_CHMOD            (1ULL << 15)
>>>> +#define LANDLOCK_ACCESS_FS_CHOWN            (1ULL << 16)
>>>>    /* clang-format on */
>>>>
>>>>    #endif /* _UAPI_LINUX_LANDLOCK_H */
>>>> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
>>>> index c57f581a9cd5..c25d5f89c8be 100644
>>>> --- a/security/landlock/fs.c
>>>> +++ b/security/landlock/fs.c
>>>> @@ -147,7 +147,9 @@ static struct landlock_object
>>>> *get_inode_object(struct inode *const inode)
>>>>        LANDLOCK_ACCESS_FS_EXECUTE | \
>>>>        LANDLOCK_ACCESS_FS_WRITE_FILE | \
>>>>        LANDLOCK_ACCESS_FS_READ_FILE | \
>>>> -    LANDLOCK_ACCESS_FS_TRUNCATE)
>>>> +    LANDLOCK_ACCESS_FS_TRUNCATE | \
>>>> +    LANDLOCK_ACCESS_FS_CHMOD | \
>>>> +    LANDLOCK_ACCESS_FS_CHOWN)
>>>>    /* clang-format on */
>>>>
>>>>    /*
>>>> @@ -1146,6 +1148,16 @@ static int hook_path_truncate(const struct
>>>> path *const path)
>>>>        return current_check_access_path(path,
>>>> LANDLOCK_ACCESS_FS_TRUNCATE);
>>>>    }
>>>>
>>>> +static int hook_path_chmod(const struct path *const dir, umode_t mode)
>>
>> This is not a "dir" but a "path".
>>
>>
>>>> +{
>>>> +    return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHMOD);
>>>> +}
>>>> +
>>>> +static int hook_path_chown(const struct path *const dir, kuid_t uid,
>>>> kgid_t gid)
>>
>> Same here.
>>
>>
>>>> +{
>>>> +    return current_check_access_path(dir, LANDLOCK_ACCESS_FS_CHOWN);
>>>> +}
>>>
>>> One implication of this approach is that the chown+chmod right on a
>>> directory's contents are always going together with the same rights on
>>> the directory itself.
>>>
>>> For example, if you grant chmod+chown access rights for "datadir/",
>>> the command "chmod 0600 datadir/file1" will work, but so will the
>>> command "chmod 0600 datadir". But the approach of checking just the
>>> parent directory's rights is also inflexible if you think through the
>>> kinds of rights you can grant with it. (It would also not be possible
>>> to grant chmod+chown on individual files.)
>>
>> Good point. For an initial chmod/chown/chgrp access right, I'd prefer to
>> be able to set these access rights on a directory but only for its
>> content, not the directory itself. I think it is much safer and should
>> be enough for the majority of use cases, but let me know if I'm missing
>> something. I'm not sure being able to change the root directory access
>> rights may be a good idea anyway (even for containers). ;)
>>
>> A path_beneath rule enables to identify a file hierarchy (i.e. the
>> content of a directory), not to make modifications visible outside of
>> the directory identifying the hierarchy (hence the "parent_fd" field),
>> which would be the case with the current chmod/chown access rights.
>>
>>
>>>
>>> Do you have any thoughts on how to resolve this if this flexibility
>>> might be needed?
>>>
>>> I wonder whether the right way to resolve this would be to give users
>>> a way to make that distinction at the level of landlock_add_rule(),
>>> with an API like this (note the additional flag):
>>>
>>>     err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
>>>                             &path_beneath, LANDLOCK_STRICTLY_BENEATH);
>>>                                            ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>> Multiple calls of landlock_add_rule() on the same file are already
>>> today joining the requested access rights, so it would be possible to
>>> mix-and-match "strict beneath" with "beneath" rights on the same
>>> directory, and it would work in the same way for other access rights
>>> as well.
>>
>> This kind of option is interesting. For now, some access rights are kind
>> of "doubled" to enable to differentiate between a file and a directory
>> (i.e. READ_DIR/READ_FILE, REMOVE_DIR/REMOVE_FILE, WRITE_FILE/MAKE_*)
>> when it may be useful, but this is different.
>>
>> I think this "strictly beneath" behavior should be the default, which is
>> currently the case.
>>
>>
>>>
>>> To be clear: I'm proposing this approach not because I think it should
>>> be part of this patch set, but because it would be good to have a way
>>> forward if that kind of flexibility is needed in the future.
>>>
>>> Does that seem reasonable?
>>
>> This is the kind of questions that made such access rights not
>> appropriate for the initial version of Landlock. But we should talk
>> about that now.
> 
> Hi Günther and Mickaël,
> 
> Thanks for your comments, so I think the conclusion here is that we have
> to make sure that in this patchset chown/chmod access rights can be set
> on a directory only for its content, not the directory itself, right?
> any good idea about how to implement this? :)

In such hook code, you need to get the parent directory of the path 
argument. This require to use and refactor the 
check_access_path_dual/jump_up part in a dedicated helper (and take care 
of all the corner cases).
