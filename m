Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B6F59CB26
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238141AbiHVVxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238369AbiHVVxR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:53:17 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE706CEB
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661205194; bh=fLqGByfEzWlCEhJSksWt4vK5bBn60323rZp1GKVGlS0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CPYzIYaW10L5I4fSNXmbeeCrQ8xsfsK+PFbkT3LWEUCqxV4AGLb+MjYVyFSmBL5ubPXPTNPQXnqhVMms8h6SuTxxeTTFyXENQAfjwJLpjp7D0/Ex1J7f/ymc70vf9d7MdKNCALH8lZvJTh5Qom95tuw1lvKYL8boHTeVvpbzxgjBZiJyZAe22BD/V4rKEbMmNQMjO707V7DCH1T21WYdxm2bYFLKuh8dFZ0DLxVHP8t45InYqCWWYvzSmJR9ZLacGX53/AhbXiCphGgs5zHU9Azm0AAw6v0v4RnfsjRDTtIQ0IkMRp0j4Ce/CBv24rlMdFESDaAM46zqW9HagqYF0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1661205194; bh=xPdVikjp3/385E9i4rwjDrrg8pgwvogDhQn9v9e+AhF=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CIOeYU3KtEiwy3vX8d2CF2ji4eQ44goPEB6PXsgjwWt1GAKWDJIlVs+SReq00ZI8JnvFaWREQq1vHZg3I6+mSYCvOFoLyDH28MtDM5ai+MpNjgLdxgINmvSpTYDhEgSgfFtT9vUSMBE2tUs8yetHxhZW/lj0sNOZye6N/ofsSOq59VbMh6A6NniVSO3TAmkLyuWVKuPLPQG4MVNX+AHsfvptuzt5a8QaVUsgBGG6FSfzhexeicGuha/A2xWHRtsbixrDBnStSwZorG82SqaQPupWNfVaGS8wmkEHAmK3pyM3fl/k/lLREY9BcJ1rs2KgaMOizkVR6cBw5eRwAN384g==
X-YMail-OSG: aE4KJ6gVM1kGTFBADa2f5WQQzFqCqUrSXYTgTFStwPEQG3kRutTlw.NjglF33sW
 7s8TUgDzo2Nz5EJTn6iUC6vD4ArO82.N1O9iTIQOaD0bD9n0LLZMHOSe4s5BVOrWqyW3zqqxoYhr
 5Kej.FkiIRTC2aw6W.N1ljG4Iw8sKbZhCJ2GRS8AWRrfy2aur_mJDy1m51rL.nmtceiaJdFVZcnv
 GlwAb16LrM9uMbwdNi_ebD1rydm1U9BYzBgGwvQBzUVPMh85XohmZuFY3NLtXIdTtgWdJdFXvaFQ
 jQtw3xhwA4udXi1AN8w5JchjoEQUhdy1Exuktf5Bp1vAoaj8mlCQwMdQJwutl227EDyMyCiOERPS
 cWrnZDpVTcg1FgIIbBnZWvID2EcbYTjdExh2_D8INLe_mAEQ25iP9eHyh4qNOb1CJUM4Ur3aJyeD
 ZUTmz87k_dO7QELtSsTcoknTsluUGJWrpYYmxDHxvP8ZV2Z_z2pEzukdROf569jmolSVJbNtuBXd
 8hgILjvjzG8HPhHiIUw5FOaIgx50iBuL8LGSBhkCDbr0F.WtnY9TQcDPvIaGr96cBWzLLnl5gBuu
 JrSAV6h3GKguUwFmdU0B1YuA6hX8VQxZ1_ZMCkaXJy1EDrojMuKofvBJG0z569NE25gTIJEOgDpg
 QZxkquazqIpiB_b9f.DakZBTudW3Iqo1.uMvtjt8YXjxp5OL1PkV884lKYUyA5hW1xCTalhQHPmz
 alIO8RiseNvOXd3RR9p.v3jaLLDJvJLBh1QvkhUIaRXS48IZiemzNDe_bjA57Bz37cJ75xEmXQ5D
 XnqUoiM6q.usvC8z_WKYeWX.Mco1vzqsKJTvIjZnD0uHD_qmm15hl49fdz.4ia_eAfAgvICJOuvb
 Adw.Y.tT0HI8h79qrhw3gA1KQ4qaaUM.rReIo7nGrjR9eSzqTR1DjZGE1fTrfS0_p29P1X0UHhe0
 7c9ELj0cp8XW6a5JipgWqr73X_xBnVSJ8So1Q4NqK3C6eT6A1qvHjavFkrAvOkCDRJ3bu.p7qhP7
 _R1hzEbA4jY59W.eeLBbHpH0TfhLqpMErcyCsvoc9HOlFPqlQgs2k2rPVPEvo27C0_30q1.Uw7Tp
 ul2x5LBMb1674NOMjNNfdaGHDquu.DKm3RWdnVq3ECwbP5mvZMh8t929ZYIvSGtrmZiqZHKQcUX6
 QlYBP4DdRmLrkMnDpu.qVUgmK_xS8oi0QqJHVAX92wlu2px9eCpER0eJiPobq0OBuS.Iv6fp9idk
 qnfUUNSJS6ZrfjN_sgIdixJSx60DQJNeVQK1uM9xe1Y6XEEoA73Sbs9iK_cOxuTVi4XPq8HiLbpS
 7FqwLPlA8w7Be_hElM3r_muGLFpbxlxlnThs1as72vw.h7_m4z_60uyklf5gQiRRQ9G.esFf2_eg
 6Wy6Wns_rmz7iiQVKA9CQW8pw1XFQyk3SPV9_zayziCSgHH_Yl_DrwJezX5dTfW3Qipr13Z1_Uub
 kp0ivUqR5EB6UAi6Do8.e9MWD1.jRiIRO64ypPT.DLkKM0fgTHwcwV_nDPjcBP4Vgd0XdXsmp0UO
 VNadMy3L6hgAOjDgqMcL9QIo1DDNnfSO7Gbb7A30Sl4s.5wL.0JTfscST958FI1nYvTn7wetPSDm
 UJ.XGIGUFfbgMz.1JCn6cpYjg6EYjGJF1ggyRMOPRgFGXx2RunjM6ce4J0xaRCjVoOOEjt1beyum
 ENH8tKPjdplNl9xn20Mgf2hpN6TrRitfkgpnkROpW94Q.TRpKz6BhuiAKYwRS8dn9b799uPvKrgK
 sFSHlTFBhtdXGvQbl6oaqGmNtnTG1hjKsjo.Zb.5vpTOFq2aE.0eiFNd3zZurGL2.M5JysA6qmBZ
 Y8DpsDeNOTiLspOWGWGG4in5EVyjTjeW0WSZC.03Uicsyf8oe9lmtVVA3_LmCd4K1509nWJsVqZJ
 TOuF6rOVPbyZ9ODOGpybJQ5mO7PCrkcqtzZ2LthUFu5hAaN6C6tL2Z_zTPZzwA0s6KZ.0SLjyi1K
 kjHFCQZUQi3oDJjV4jkM6fpmHjuXFWoEmguxLE72ZXVqHgoCqZ61F6xnTbUpfnFSBqS.UMPL6MTl
 8gFt9S.prS1b9W3XWmrxWIJs5ccGyob7LASENmONBhMUmK9_Mi1ypfDqhdoVOcscA7CLOkd5.scY
 Rv80wFpnc.mr0AgBvXrwdFYlYi60U4AQxXEs5XUCkkA2l5AlcQo1FrpKIBdQA2OcVU6D7k7eJUOH
 VJ9yqogExpxJ5R2hmxR4JXCdMLIax9UqBla_sDbqezEAUzfmSCX2KMoE84tDiAvG45tBhDbkCUzD
 x8mCWWdK4Mmxp0qEOOj2arRI-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 22 Aug 2022 21:53:14 +0000
Received: by hermes--production-ne1-6649c47445-jb4gk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 94984fe3b88a583bcfc62931de86be49;
          Mon, 22 Aug 2022 21:53:10 +0000 (UTC)
Message-ID: <b1d69dfa-6d93-2034-7854-e2bc4017d20e@schaufler-ca.com>
Date:   Mon, 22 Aug 2022 14:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next 0/5] landlock: add chmod and chown support
Content-Language: en-US
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        corbet@lwn.net, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, casey@schaufler-ca.com
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
 <YwPWN/d15S24PuLS@nuc>
 <39df1a34-51dc-da55-ff1c-59cab896c8a0@schaufler-ca.com>
 <YwPyuX7oao6EqTvJ@nuc> <72ca592e-ff1b-120e-3d00-5c79aefbc247@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <72ca592e-ff1b-120e-3d00-5c79aefbc247@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20560 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/22/2022 2:21 PM, Mickaël Salaün wrote:
>
>
> On 22/08/2022 23:18, Günther Noack wrote:
>> On Mon, Aug 22, 2022 at 12:35:18PM -0700, Casey Schaufler wrote:
>>> On 8/22/2022 12:17 PM, Günther Noack wrote:
>>>> Hi!
>>>>
>>>> Very exciting to see! Thank you for sending this! :)
>>>>
>>>> I'm just throwing in some comments based on the very similar truncate
>>>> patch set, in the hope that it helps. (But obviously, Mickaël Salaün
>>>> has the last word on this code.)
>>>>
>>>> Slightly higher level question: Should we start to group the
>>>> functionality of multiple LSM hooks under one Landlock flag? (Will it
>>>> be harder to change the LSM hook interface in the future if we
>>>> continue to add one flag per hook? Or is this structure already
>>>> exposed to userspace by other LSMs?)
>>>
>>> I'm not a landlock expert. The question is nonsensical, yet somewhat
>>> frightening nonetheless. Could you put just a touch more context into
>>> what you're asking for?
>>
>> By "Landlock flags", I meant the integer that Landlock uses to
>> represent the set of possible operations on a file hierarchy:
>>
>> Landlock's file system access rights (access_mode_t on the kernel
>> side) are defined with an integer with flags (LANDLOCK_ACCESS_FS_*)
>> for different operations that one might do with files. They get used
>> from userspace to control what is permitted on which parts of the file
>> system. (Docs: https://docs.kernel.org/userspace-api/landlock.html)
>>
>> Currently most of the available Landlock flags map pretty closely to
>> one of the file- and path-related LSM hooks. (See various hook
>> implementations in security/landlock/fs.c)
>>
>> The file system operations that Landlock doesn't cover yet (as of
>> kernel 5.19) are listed below, and there are potentially a few more
>> that might be missing. I suspect/hope that there will be more patches
>> in the style of the truncate/chmod/chown patches, which will add that
>> coverage.
>>
>> The question is basically:
>> When these patches get added, how should the userspace-exposed
>> Landlock file system access rights map to the LSM hooks for these
>> upcoming Landlock features? Should each of the newly covered
>> operations have its own flag, or is it better to group them?
>>
>> (It's well possible that the right answer is "one flag per feature",
>> but I feel it still makes sense to ask this before all these patches
>> get written?)
>
> Landlock is not strictly tied to the current LSM hooks, but they fit
> well (because they are designed to be flexible enough to be use by
> multiple access control systems). In fact, Landlock already uses
> orthogonal access rights such as LANDLOCK_ACCESS_FS_REFER (using the
> path_link or path_rename hooks), LANDLOCK_ACCESS_FS_MAKE_* (using the
> path_mknod and path_mkdir hooks)…
>
> Anyway, the LSM framework is evolving, we can add new hooks and modify
> others (e.g. see the security_path_rename hook modification for
> FS_REFER) as long as mainline access control systems don't break and
> subsystem maintainers are OK with such changes. Like any kernel API,
> the LSM API is not stable, but this is not an issue for mainline code.
>
> Landlock's goal is to find the sweet spot between flexibility for
> different sandboxing use cases and an understandable/simple-enough
> access control system. The access rights should then be meaningful for
> users, which are already familiar with the UAPI/syscalls, hence the
> current Landlock access rights (which are not very original, and that
> is a good thing). This is why I'm wondering if it is worth it to
> differentiate between chmod and chgrp (and add a dedicated access
> right per action or only one for both).

The lesson from capabilities is that differentiating between chmod, chown and chgrp is
pointless, and CAP_DAC_CHMOD, CAP_DAC_CHOWN and CAP_DAC_CHGRP should have just been
CAP_DAC_OVERRIDE. On the other hand, those who argue that SELinux proves the value of
fine granularity would likely have you go with separate rights. What's important is
that you don't tie your rights too tightly to the underlying implementation. That has
the potential to expose details of how the code work that user-space has no business
basing decisions on. 

>
>
>>
>> —Günther
>>
>>>> For example, some of the "missing" operations listed on the Landlock
>>>> documentation could also be grouped roughly as:
>>>>
>>>> Modifying files:
>>>>   - truncate
>>>>
>>>> Modifying file metadata:
>>>>   - chmod
>>>>   - chown
>>>>   - setxattr
>>>>   - utime
>>>>
>>>> Observing files (check presence and file metadata):
>>>>   - access
>>>>   - stat
>>>>   - readlink, following links (can observe symlink presence)
>>>>   - chdir (can observe dir presence and 'x' attribute)
>>>>
>>>> Ungrouped:
>>>>   - flock
>>>>   - ioctl
>>>>   - fcntl
>>>>
>>>> Do you have opinions on this?
>
> That could indeed help users identifying currently missing pieces for
> their use case.
>
>
>>>>
>>>> —Günther
>>>>
>>>> On Mon, Aug 22, 2022 at 07:46:56PM +0800, Xiu Jianfeng wrote:
>>>>> hi,
>>>>>    this patchset adds chmod and chown support for landlock
>>>>>
>>>>> Xiu Jianfeng (5):
>>>>>    landlock: expand access_mask_t to u32 type
>>>>>    landlock: add chmod and chown support
>>>>>    landlock/selftests: add selftests for chmod and chown
>>>>>    landlock/samples: add chmod and chown support
>>>>>    landlock: update chmod and chown support in document
>>>>>
>>>>>   Documentation/userspace-api/landlock.rst     |   8 +-
>>>>>   include/uapi/linux/landlock.h                |   8 +-
>>>>>   samples/landlock/sandboxer.c                 |  12 +-
>>>>>   security/landlock/fs.c                       |  16 +-
>>>>>   security/landlock/limits.h                   |   2 +-
>>>>>   security/landlock/ruleset.h                  |   2 +-
>>>>>   security/landlock/syscalls.c                 |   2 +-
>>>>>   tools/testing/selftests/landlock/base_test.c |   2 +-
>>>>>   tools/testing/selftests/landlock/fs_test.c   | 234
>>>>> ++++++++++++++++++-
>>>>>   9 files changed, 274 insertions(+), 12 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>> -- 
>>
>> -- 
