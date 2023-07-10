Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE274CDBB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 08:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjGJG5O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 02:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGJG5N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 02:57:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A38C5E5;
        Sun,  9 Jul 2023 23:57:11 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36A6v2KP018009;
        Mon, 10 Jul 2023 08:57:02 +0200
Date:   Mon, 10 Jul 2023 08:57:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net
Subject: Re: [PATCH v4 13/18] selftests/nolibc: prepare /tmp for tmpfs or
 ramfs
Message-ID: <ZKurvsvTp92y7sfU@1wt.eu>
References: <20230709093821.GH9321@1wt.eu>
 <20230710050600.9697-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710050600.9697-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Mon, Jul 10, 2023 at 01:06:00PM +0800, Zhangjin Wu wrote:
> > On Sat, Jul 08, 2023 at 02:38:57AM +0800, Zhangjin Wu wrote:
> > > create a /tmp directory and mount tmpfs there, if tmpfs is not
> > > mountable, use ramfs as tmpfs.
> > > 
> > > tmpfs will be used instead of procfs for some tests.
> > 
> > Just curious, in which cases do you need this ? We're building an
> > initramfs for the root that's already read-write, so without mounting
> > anything you already have write access. I'm taking it anyway for now,
> > but if you figure it's not needed we can later drop it (or just drop
> > the mount part and keep mkdir).
> >
>  
> This "/tmp" directory is originally created to check the 'TMPFS' existence for
> the old vfprintf/memfd_create (from old version of the minimal config support),
> it is used to skip the whole vfprintf tests if the TMPFS (or HUGETLBFS) is not
> there. BTW, Thomas's patch [1] shows, MEMFD_CREATE is able to work with ramfs
> too.

OK but here we're neither using it nor even checking its success.

> And it is later used by the old chmod_tmpdir/chmod_tmpfile and chroot_tmpfile
> too (from old version of the minimal config support), so, it is important to
> align with the normal Linux systems to let "/tmp" means TMPFS mount.

I think I didn't explain myself well. I'm not contesting a writable /tmp,
I was asking why *tmpfs*, because we have a root on ramfs by default, so
when you create /tmp, the sole fact that it succeeds implies that whatever
you'll put into it will already work without having to remount a tmpfs
inside.

> Now, we use "/tmp" directly in vfprintf, and we use argv0 for chmod_exe and
> chroot_exe, so, the only user of "/tmp" is vfprintf currently. In this case, it
> is a simple normal writable directory to allow create tmp files there, so,
> agree very much to only reserve the mkdir part:
> 
>     /* create /tmp if not there. Silently fail otherwise */
>     mkdir("/tmp", 0755);

OK, then I'll do that.

> Another consideration before is whether it is required to be consistent with
> the normal Linux systems, let the "/tmp" directory mounted as tmpfs at most of
> the time,

That's not what I'm seeing on most of the systems I'm having access to,
where /tmp is on a plain file system (either / or link to /var/tmp but
always on disk, likely due to the huge size of the stuff stored there
that is rarely used and that should not eat memory).

> but "/tmp" means ramfs for CONFIG_TMPFS=n currently even mount it
> explicitly (ramfs is a fallback of tmpfs in such case), so, this assumption of
> "/tmp" means tmpfs is not true currently.
>
> What I'm worried about is people in the future assume "/tmp" as tmpfs at the
> first glance and use the features only provided by TMPFS but not provided by
> RAMFS (I'm not sure which one they will use). so, I even tried to create a
> "/tmp/tmpfs" flag for TMPFS and "/tmp/ramfs" flag for RAMFS before, since there
> is no user to explicitly prefer TMPFS to RAMFS currently, at last, I removed
> these flags from the sent patchsets. Based on the same logic, The removal of
> tmpfs mount is of course ok.

Indeed, and also, please keep in mind what the purpose of nolibc-test is:
make sure that the syscalls wrappers we write do work as expected, in part
by allowing us to compare against another libc to figure whether it's
the libc, the test or the kernel that causes any difference. The rest is
purely out of scope. Thus it's not this test's business to verify that a
tmpfs is indeed present after trying to mount it under /tmp, however it's
this test business to make sure that options passed to mount() do work as
expected, and that when a writable area is needed for a test, a working
one is assigned. Thus for the specific case you mention, we don't care.
And I'd go further, there can and should be reasonable prerequisites to
run this test.

> So, Willy, is it ok for you to remove that mount line with corresponding update
> of the commit message (and the subject title), or require me to send a revision
> for this patch?

No worries, I've modified it accordingly with the following commit message,
just let me know if you want to change anything:

  commit 11fddb386bd663a554cc08c5950d9da2c87a7267 (HEAD)
  Author: Zhangjin Wu <falcon@tinylab.org>
  Date:   Sat Jul 8 02:38:57 2023 +0800

    selftests/nolibc: prepare /tmp for tests that need to write
    
    create a /tmp directory. If it succeeds, the directory is writable,
    which is normally the case when booted from an initramfs anyway.
    
    This will be used instead of procfs for some tests.
    
    Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
    Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
    Link: https://lore.kernel.org/lkml/20230710050600.9697-1-falcon@tinylab.org/
    [wt: removed the unneeded mount() call]
    Signed-off-by: Willy Tarreau <w@1wt.eu>

Thanks!
Willy
