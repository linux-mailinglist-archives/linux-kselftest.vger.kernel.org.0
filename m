Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69DF59EB57
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiHWSrN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Aug 2022 14:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiHWSqc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Aug 2022 14:46:32 -0400
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [IPv6:2001:1600:4:17::8faa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED321277
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 10:10:59 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBwjV0d9zzMpvs1;
        Tue, 23 Aug 2022 19:10:54 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBwjS5SGBzlh8TF;
        Tue, 23 Aug 2022 19:10:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661274654;
        bh=ngBbph48Cc2OEBE2YRaI2w0GxYjvGMB00XD5rFqgT34=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=1vIMqY/6ru8pRh2onGMbx+M+qxNCH0xPAC8stGGto7p4q2CeBxlyW1mdEQdVrHWh2
         2o/vaNUxQGjcOzf61M5VaWeSAyiGP9CDsgAWcG4m0f4DWlVl9tdBAEn8euJHSyPpsL
         FCveDDc1bTzU8TM25gG3qgQLJrlXaEdWbJYu/wd0=
Message-ID: <c369c45d-5aa8-3e39-c7d6-b08b165495fd@digikod.net>
Date:   Tue, 23 Aug 2022 19:10:52 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <YwPWN/d15S24PuLS@nuc>
 <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
 <YwPyuX7oao6EqTvJ@nuc> <72ca592e-ff1b-120e-3d00-5c79aefbc247@digikod.net>
 <b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
In-Reply-To: <b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 22/08/2022 23:53, Casey Schaufler wrote:
> On 8/22/2022 2:21 PM, Mickaël Salaün wrote:
>>
>>
>> On 22/08/2022 23:18, Günther Noack wrote:
>>> On Mon, Aug 22, 2022 at 12:35:18PM -0700, Casey Schaufler wrote:
>>>> On 8/22/2022 12:17 PM, Günther Noack wrote:
>>>>> Hi!
>>>>>
>>>>> Very exciting to see! Thank you for sending this! :)
>>>>>
>>>>> I'm just throwing in some comments based on the very similar truncate
>>>>> patch set, in the hope that it helps. (But obviously, Mickaël Salaün
>>>>> has the last word on this code.)
>>>>>
>>>>> Slightly higher level question: Should we start to group the
>>>>> functionality of multiple LSM hooks under one Landlock flag? (Will it
>>>>> be harder to change the LSM hook interface in the future if we
>>>>> continue to add one flag per hook? Or is this structure already
>>>>> exposed to userspace by other LSMs?)
>>>>
>>>> I'm not a landlock expert. The question is nonsensical, yet somewhat
>>>> frightening nonetheless. Could you put just a touch more context into
>>>> what you're asking for?
>>>
>>> By "Landlock flags", I meant the integer that Landlock uses to
>>> represent the set of possible operations on a file hierarchy:
>>>
>>> Landlock's file system access rights (access_mode_t on the kernel
>>> side) are defined with an integer with flags (LANDLOCK_ACCESS_FS_*)
>>> for different operations that one might do with files. They get used
>>> from userspace to control what is permitted on which parts of the file
>>> system. (Docs: https://docs.kernel.org/userspace-api/landlock.html)
>>>
>>> Currently most of the available Landlock flags map pretty closely to
>>> one of the file- and path-related LSM hooks. (See various hook
>>> implementations in security/landlock/fs.c)
>>>
>>> The file system operations that Landlock doesn't cover yet (as of
>>> kernel 5.19) are listed below, and there are potentially a few more
>>> that might be missing. I suspect/hope that there will be more patches
>>> in the style of the truncate/chmod/chown patches, which will add that
>>> coverage.
>>>
>>> The question is basically:
>>> When these patches get added, how should the userspace-exposed
>>> Landlock file system access rights map to the LSM hooks for these
>>> upcoming Landlock features? Should each of the newly covered
>>> operations have its own flag, or is it better to group them?
>>>
>>> (It's well possible that the right answer is "one flag per feature",
>>> but I feel it still makes sense to ask this before all these patches
>>> get written?)
>>
>> Landlock is not strictly tied to the current LSM hooks, but they fit
>> well (because they are designed to be flexible enough to be use by
>> multiple access control systems). In fact, Landlock already uses
>> orthogonal access rights such as LANDLOCK_ACCESS_FS_REFER (using the
>> path_link or path_rename hooks), LANDLOCK_ACCESS_FS_MAKE_* (using the
>> path_mknod and path_mkdir hooks)…
>>
>> Anyway, the LSM framework is evolving, we can add new hooks and modify
>> others (e.g. see the security_path_rename hook modification for
>> FS_REFER) as long as mainline access control systems don't break and
>> subsystem maintainers are OK with such changes. Like any kernel API,
>> the LSM API is not stable, but this is not an issue for mainline code.
>>
>> Landlock's goal is to find the sweet spot between flexibility for
>> different sandboxing use cases and an understandable/simple-enough
>> access control system. The access rights should then be meaningful for
>> users, which are already familiar with the UAPI/syscalls, hence the
>> current Landlock access rights (which are not very original, and that
>> is a good thing). This is why I'm wondering if it is worth it to
>> differentiate between chmod and chgrp (and add a dedicated access
>> right per action or only one for both).
> 
> The lesson from capabilities is that differentiating between chmod, chown and chgrp is
> pointless, and CAP_DAC_CHMOD, CAP_DAC_CHOWN and CAP_DAC_CHGRP should have just been
> CAP_DAC_OVERRIDE. On the other hand, those who argue that SELinux proves the value of
> fine granularity would likely have you go with separate rights. What's important is
> that you don't tie your rights too tightly to the underlying implementation. That has
> the potential to expose details of how the code work that user-space has no business
> basing decisions on.

Indeed, for a sandboxing feature like Landlock, it may not be useful to 
duplicate other access rights. From a user point of view, I think it 
would make sense to split the file metadata modification into 
potentially-security related or not. That would means three access rights:
- modify user/informative metadata (e.g. dates, user.* xattr);
- modify security-related metadata (e.g. chown, chmod, chgrp, any other 
xattr);
- read any metadata.

This require some LSM hook changes to handle paths instead of inodes 
(e.g. security_inode_setattr, security_inode_setxattr…).
