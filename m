Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50259CAC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbiHVVWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiHVVWF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:22:05 -0400
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DA1520B1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:22:03 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MBQKk0cnDzMpvsm;
        Mon, 22 Aug 2022 23:22:02 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MBQKh1Bfqzlh8T4;
        Mon, 22 Aug 2022 23:22:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1661203322;
        bh=OSYzzvdz84yPbQEGoIIrPXVz95TLy36MFz4gk4sipWQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=vMH/NwTXLN0eBDfx3zhrak/cpsAvtGELH43/eaZ5antgDtLsNj7IfQnOYKtTShNu3
         2m1uXNRDqEhc469/RqF2qA6eNMkNal8c10It5bMv4NRU9nUnvCOz+nU8RS4pcYpL0V
         8XYdpM6zeZEbIQqw6/mTHoYOl5DuhSnNZngi9s9k=
Message-ID: <72ca592e-ff1b-120e-3d00-5c79aefbc247@digikod.net>
Date:   Mon, 22 Aug 2022 23:21:59 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <YwPWN/d15S24PuLS@nuc>
 <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
 <YwPyuX7oao6EqTvJ@nuc>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
In-Reply-To: <YwPyuX7oao6EqTvJ@nuc>
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



On 22/08/2022 23:18, Günther Noack wrote:
> On Mon, Aug 22, 2022 at 12:35:18PM -0700, Casey Schaufler wrote:
>> On 8/22/2022 12:17 PM, Günther Noack wrote:
>>> Hi!
>>>
>>> Very exciting to see! Thank you for sending this! :)
>>>
>>> I'm just throwing in some comments based on the very similar truncate
>>> patch set, in the hope that it helps. (But obviously, Mickaël Salaün
>>> has the last word on this code.)
>>>
>>> Slightly higher level question: Should we start to group the
>>> functionality of multiple LSM hooks under one Landlock flag? (Will it
>>> be harder to change the LSM hook interface in the future if we
>>> continue to add one flag per hook? Or is this structure already
>>> exposed to userspace by other LSMs?)
>>
>> I'm not a landlock expert. The question is nonsensical, yet somewhat
>> frightening nonetheless. Could you put just a touch more context into
>> what you're asking for?
> 
> By "Landlock flags", I meant the integer that Landlock uses to
> represent the set of possible operations on a file hierarchy:
> 
> Landlock's file system access rights (access_mode_t on the kernel
> side) are defined with an integer with flags (LANDLOCK_ACCESS_FS_*)
> for different operations that one might do with files. They get used
> from userspace to control what is permitted on which parts of the file
> system. (Docs: https://docs.kernel.org/userspace-api/landlock.html)
> 
> Currently most of the available Landlock flags map pretty closely to
> one of the file- and path-related LSM hooks. (See various hook
> implementations in security/landlock/fs.c)
> 
> The file system operations that Landlock doesn't cover yet (as of
> kernel 5.19) are listed below, and there are potentially a few more
> that might be missing. I suspect/hope that there will be more patches
> in the style of the truncate/chmod/chown patches, which will add that
> coverage.
> 
> The question is basically:
> When these patches get added, how should the userspace-exposed
> Landlock file system access rights map to the LSM hooks for these
> upcoming Landlock features? Should each of the newly covered
> operations have its own flag, or is it better to group them?
> 
> (It's well possible that the right answer is "one flag per feature",
> but I feel it still makes sense to ask this before all these patches
> get written?)

Landlock is not strictly tied to the current LSM hooks, but they fit 
well (because they are designed to be flexible enough to be use by 
multiple access control systems). In fact, Landlock already uses 
orthogonal access rights such as LANDLOCK_ACCESS_FS_REFER (using the 
path_link or path_rename hooks), LANDLOCK_ACCESS_FS_MAKE_* (using the 
path_mknod and path_mkdir hooks)…

Anyway, the LSM framework is evolving, we can add new hooks and modify 
others (e.g. see the security_path_rename hook modification for 
FS_REFER) as long as mainline access control systems don't break and 
subsystem maintainers are OK with such changes. Like any kernel API, the 
LSM API is not stable, but this is not an issue for mainline code.

Landlock's goal is to find the sweet spot between flexibility for 
different sandboxing use cases and an understandable/simple-enough 
access control system. The access rights should then be meaningful for 
users, which are already familiar with the UAPI/syscalls, hence the 
current Landlock access rights (which are not very original, and that is 
a good thing). This is why I'm wondering if it is worth it to 
differentiate between chmod and chgrp (and add a dedicated access right 
per action or only one for both).


> 
> —Günther
> 
>>> For example, some of the "missing" operations listed on the Landlock
>>> documentation could also be grouped roughly as:
>>>
>>> Modifying files:
>>>   - truncate
>>>
>>> Modifying file metadata:
>>>   - chmod
>>>   - chown
>>>   - setxattr
>>>   - utime
>>>
>>> Observing files (check presence and file metadata):
>>>   - access
>>>   - stat
>>>   - readlink, following links (can observe symlink presence)
>>>   - chdir (can observe dir presence and 'x' attribute)
>>>
>>> Ungrouped:
>>>   - flock
>>>   - ioctl
>>>   - fcntl
>>>
>>> Do you have opinions on this?

That could indeed help users identifying currently missing pieces for 
their use case.


>>>
>>> —Günther
>>>
>>> On Mon, Aug 22, 2022 at 07:46:56PM +0800, Xiu Jianfeng wrote:
>>>> hi,
>>>>    this patchset adds chmod and chown support for landlock
>>>>
>>>> Xiu Jianfeng (5):
>>>>    landlock: expand access_mask_t to u32 type
>>>>    landlock: add chmod and chown support
>>>>    landlock/selftests: add selftests for chmod and chown
>>>>    landlock/samples: add chmod and chown support
>>>>    landlock: update chmod and chown support in document
>>>>
>>>>   Documentation/userspace-api/landlock.rst     |   8 +-
>>>>   include/uapi/linux/landlock.h                |   8 +-
>>>>   samples/landlock/sandboxer.c                 |  12 +-
>>>>   security/landlock/fs.c                       |  16 +-
>>>>   security/landlock/limits.h                   |   2 +-
>>>>   security/landlock/ruleset.h                  |   2 +-
>>>>   security/landlock/syscalls.c                 |   2 +-
>>>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>>>   tools/testing/selftests/landlock/fs_test.c   | 234 ++++++++++++++++++-
>>>>   9 files changed, 274 insertions(+), 12 deletions(-)
>>>>
>>>> --
>>>> 2.17.1
>>>>
>>> --
> 
> --
