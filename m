Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822774CC1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjGJFT4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 01:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGJFTe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 01:19:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A149DC;
        Sun,  9 Jul 2023 22:13:58 -0700 (PDT)
X-QQ-mid: bizesmtp68t1688965561t6naos8a
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 13:06:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: lO87fmWkX3HaW2taDfSs1R2OvsTmxaaDoJO0KeobxemAPs/y0vAjAAG+ceg1U
        aRywlrn6iekitbZolZ8HVumUutuczuLTcDuK1yUynq/HUbN0HNUIpXYssnICOSXZEclQeX4
        OShbbEncp+Qzd0ncHv81++CrYJbb1iRyl1r7WzywMrLt13h4UavuRtZr0A+eu9gtllRTV9Z
        mepmWqt54jVzgPb4JPBkfuyflF69WVFLADjDTLG98GhQsLcHEHz5ueUhc+3iTzGlpsHN8xD
        gm2BxvotdF1oz05lhjU3oH/O6xtjqZfhBPIfcQrVc5Sa+KgoUwvyLnBgT+ksD8ALbooB5K3
        GZVk86Pu4WciOxpGddcCeFJ6AckMT1iNhW6oI4Pm/vXDSjvt9Em1Aa6RQxKCw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 655532314049486488
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net
Subject: Re: [PATCH v4 13/18] selftests/nolibc: prepare /tmp for tmpfs or ramfs
Date:   Mon, 10 Jul 2023 13:06:00 +0800
Message-Id: <20230710050600.9697-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230709093821.GH9321@1wt.eu>
References: <20230709093821.GH9321@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Sat, Jul 08, 2023 at 02:38:57AM +0800, Zhangjin Wu wrote:
> > create a /tmp directory and mount tmpfs there, if tmpfs is not
> > mountable, use ramfs as tmpfs.
> > 
> > tmpfs will be used instead of procfs for some tests.
> 
> Just curious, in which cases do you need this ? We're building an
> initramfs for the root that's already read-write, so without mounting
> anything you already have write access. I'm taking it anyway for now,
> but if you figure it's not needed we can later drop it (or just drop
> the mount part and keep mkdir).
>
 
This "/tmp" directory is originally created to check the 'TMPFS' existence for
the old vfprintf/memfd_create (from old version of the minimal config support),
it is used to skip the whole vfprintf tests if the TMPFS (or HUGETLBFS) is not
there. BTW, Thomas's patch [1] shows, MEMFD_CREATE is able to work with ramfs
too.

And it is later used by the old chmod_tmpdir/chmod_tmpfile and chroot_tmpfile
too (from old version of the minimal config support), so, it is important to
align with the normal Linux systems to let "/tmp" means TMPFS mount.

Now, we use "/tmp" directly in vfprintf, and we use argv0 for chmod_exe and
chroot_exe, so, the only user of "/tmp" is vfprintf currently. In this case, it
is a simple normal writable directory to allow create tmp files there, so,
agree very much to only reserve the mkdir part:

    /* create /tmp if not there. Silently fail otherwise */
    mkdir("/tmp", 0755);

Another consideration before is whether it is required to be consistent with
the normal Linux systems, let the "/tmp" directory mounted as tmpfs at most of
the time, but "/tmp" means ramfs for CONFIG_TMPFS=n currently even mount it
explicitly (ramfs is a fallback of tmpfs in such case), so, this assumption of
"/tmp" means tmpfs is not true currently.

What I'm worried about is people in the future assume "/tmp" as tmpfs at the
first glance and use the features only provided by TMPFS but not provided by
RAMFS (I'm not sure which one they will use). so, I even tried to create a
"/tmp/tmpfs" flag for TMPFS and "/tmp/ramfs" flag for RAMFS before, since there
is no user to explicitly prefer TMPFS to RAMFS currently, at last, I removed
these flags from the sent patchsets. Based on the same logic, The removal of
tmpfs mount is of course ok.

So, Willy, is it ok for you to remove that mount line with corresponding update
of the commit message (and the subject title), or require me to send a revision
for this patch?

Best regards,
Zhangjin

---
[1]: https://lore.kernel.org/lkml/20230703224803.GF4378@monkey/

> Willy
