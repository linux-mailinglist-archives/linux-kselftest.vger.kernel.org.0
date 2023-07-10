Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2C74D1FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 11:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjGJJl0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGJJkH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 05:40:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD2AF;
        Mon, 10 Jul 2023 02:38:14 -0700 (PDT)
X-QQ-mid: bizesmtp73t1688981884t4rkrc4n
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Jul 2023 17:38:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: LE7C6P2vL8RGulXWTTLak/FJgpC06HXYHJXna8U9Rvijr2d5ERUfvBqGDha1x
        b1tPGNP525l7fT41EwJznFm+ZOtPyhXfmCHnzoWR+lv7vL7mTdecQnlfSU39qpAUJ3t2yG6
        DhopTKAoQKMaYjjQqxh8q4Aj4pKK9i1JySCvas93o1RNAz6pcI/bF9WOPBCUzj9xYvi38XV
        dtngXn6p08Gee1Vga18pIq+nnEAUGchlF/VHPcYCn8j9VjX/bL/i/O71370Sf5NZXzMisb9
        m4MP22cmvvU0Hbe95Ri439YVylIba5E/yegjdMUvnwuTF7aY73e5sN/HEUUCcSRfdD38qIG
        nJ4WiteaHTlD6ogMXWzJTirzDwIcQyQ1speXw0bN9ZcI3R6ebqnoLm69/2e/iX/wZz2Cmic
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18422767944919631440
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net
Subject: Re: [PATCH v4 13/18] selftests/nolibc: prepare /tmp for tmpfs or ramfs
Date:   Mon, 10 Jul 2023 17:38:03 +0800
Message-Id: <20230710093803.19587-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZKurvsvTp92y7sfU@1wt.eu>
References: <ZKurvsvTp92y7sfU@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Mon, Jul 10, 2023 at 01:06:00PM +0800, Zhangjin Wu wrote:
> > > On Sat, Jul 08, 2023 at 02:38:57AM +0800, Zhangjin Wu wrote:
[...]
> > Now, we use "/tmp" directly in vfprintf, and we use argv0 for chmod_exe and
> > chroot_exe, so, the only user of "/tmp" is vfprintf currently. In this case, it
> > is a simple normal writable directory to allow create tmp files there, so,
> > agree very much to only reserve the mkdir part:
> > 
> >     /* create /tmp if not there. Silently fail otherwise */
> >     mkdir("/tmp", 0755);
> 
> OK, then I'll do that.
>

Thanks.

> > Another consideration before is whether it is required to be consistent with
> > the normal Linux systems, let the "/tmp" directory mounted as tmpfs at most of
> > the time,
> 
> That's not what I'm seeing on most of the systems I'm having access to,
> where /tmp is on a plain file system (either / or link to /var/tmp but
> always on disk, likely due to the huge size of the stuff stored there
> that is rarely used and that should not eat memory).
> 
> > but "/tmp" means ramfs for CONFIG_TMPFS=n currently even mount it
> > explicitly (ramfs is a fallback of tmpfs in such case), so, this assumption of
> > "/tmp" means tmpfs is not true currently.
> >
> > What I'm worried about is people in the future assume "/tmp" as tmpfs at the
> > first glance and use the features only provided by TMPFS but not provided by
> > RAMFS (I'm not sure which one they will use). so, I even tried to create a
> > "/tmp/tmpfs" flag for TMPFS and "/tmp/ramfs" flag for RAMFS before, since there
> > is no user to explicitly prefer TMPFS to RAMFS currently, at last, I removed
> > these flags from the sent patchsets. Based on the same logic, The removal of
> > tmpfs mount is of course ok.
> 
> Indeed, and also, please keep in mind what the purpose of nolibc-test is:
> make sure that the syscalls wrappers we write do work as expected, in part
> by allowing us to compare against another libc to figure whether it's
> the libc, the test or the kernel that causes any difference. The rest is
> purely out of scope. Thus it's not this test's business to verify that a
> tmpfs is indeed present after trying to mount it under /tmp, however it's
> this test business to make sure that options passed to mount() do work as
> expected, and that when a writable area is needed for a test, a working
> one is assigned. Thus for the specific case you mention, we don't care.
> And I'd go further, there can and should be reasonable prerequisites to
> run this test.
>

Ok.

> > So, Willy, is it ok for you to remove that mount line with corresponding update
> > of the commit message (and the subject title), or require me to send a revision
> > for this patch?
> 
> No worries, I've modified it accordingly with the following commit message,
> just let me know if you want to change anything:
> 
>   commit 11fddb386bd663a554cc08c5950d9da2c87a7267 (HEAD)
>   Author: Zhangjin Wu <falcon@tinylab.org>
>   Date:   Sat Jul 8 02:38:57 2023 +0800
> 
>     selftests/nolibc: prepare /tmp for tests that need to write
>     
>     create a /tmp directory. If it succeeds, the directory is writable,
>     which is normally the case when booted from an initramfs anyway.
>     
>     This will be used instead of procfs for some tests.
>     
>     Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
>     Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
>     Link: https://lore.kernel.org/lkml/20230710050600.9697-1-falcon@tinylab.org/
>     [wt: removed the unneeded mount() call]
>     Signed-off-by: Willy Tarreau <w@1wt.eu>
>

Perfectly, Thanks a lot.

Best regards,
Zhangjin

> Thanks!
> Willy
