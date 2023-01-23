Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87298678371
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAWRkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAWRkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:40:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16129403;
        Mon, 23 Jan 2023 09:40:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4E47B80E25;
        Mon, 23 Jan 2023 17:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878B8C433EF;
        Mon, 23 Jan 2023 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674495603;
        bh=eO55qfKvtMu63BQUrDky3UENeIXxrLrV4t3szXMZ/ik=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jYGSrtYRrU0cILJtXxtsqEBOXhiRjlbPkldyLtg+E0hlr4mlfChEaiFpnJRmMDDal
         1UH9CAuT32dgjpEugVevsCQNoHr7VZsb8x47vMgHTDavZOg2wSrMs8mSetPFLNipOs
         AbFMegsbpEQKHzQhilajU1iMvIczKO7GDDbMd6M9hE6utrzvMr2r/IlelJK/1RonJx
         wZ+I2AV0RfQBCvXJvGh+Dwa83cqDjWF9e2AKMeKZtv+rjPP23ZL/etJLQ/pT7EoMPP
         MP9+CaX4VmpKhDwL4bZWzAQX3yKrSDK8aOjgaNd5iYZ2HOHQlNsaKA4SYCx4tM60FA
         +xTalIQC/DCtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F4B25C0510; Mon, 23 Jan 2023 09:40:03 -0800 (PST)
Date:   Mon, 23 Jan 2023 09:40:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2023 at 12:31:01AM +0700, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 06:20:16PM +0100, Willy Tarreau wrote:
> > Ah now I think I understand Paul's question. I didn't know that the
> > userland version was not always provided. I've always had both side
> > by side.
> > 
> > > It would be great if we can avoid building qemu from the source. But if
> > > not, let's go with that.
> > 
> > As Paul indicated, it's really trouble-free and I think I've only done
> > that since the very first day I started to use QEMU, reason why I probably
> > never noticed that not everything was packaged.
> > 
> > Then at least to respond to Paul, it could make sense to add a note that
> > on some distros the userland version might not always be provided and
> > might require a pretty simple rebuild of QEMU.
> 
> Ah well...
> 
> I figured it out. It turned qemu-user is a different package.
> So I have "qemu-system" installed, but not "qemu-user".
> 
> Without building from source, just do this on Ubuntu:
> 
>   $ sudo apt-get install qemu-user -y
>   ...
>   Preparing to unpack .../qemu-user_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
>   Unpacking qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
>   Selecting previously unselected package qemu-user-binfmt.
>   Preparing to unpack .../qemu-user-binfmt_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
>   Unpacking qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
>   Setting up qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
>   Setting up qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
>   Processing triggers for man-db (2.10.2-1) ...
> 
>   $ which qemu-x86_64
>   /usr/bin/qemu-x86_64
> 
>   $ sudo make run-user
>   MKDIR   sysroot/x86/include
>   make[1]: Entering directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>     INSTALL /home/ammarfaizi2/work/linux.work.cc/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[1]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>     CC      nolibc-test
>   83 test(s) passed.
> 
> Sorry for that. I didn't know that they come from different packages.
> It works fine for me now.

I looked for that, but didn't find it, so thank you!

(Yes, I should have used dpkg, but I was lazy.)

Except that when I install Ubuntu 20.04's version, I get this:

------------------------------------------------------------------------

$ sudo make run-user
  MKDIR   sysroot/x86/include
make[1]: Entering directory '/home/git/linux-rcu/tools/include/nolibc'
make[2]: Entering directory '/home/git/linux-rcu'
make[2]: Leaving directory '/home/git/linux-rcu'
make[2]: Entering directory '/home/git/linux-rcu'
  INSTALL /home/git/linux-rcu/tools/testing/selftests/nolibc/sysroot/sysroot/include
make[2]: Leaving directory '/home/git/linux-rcu'
make[1]: Leaving directory '/home/git/linux-rcu/tools/include/nolibc'
  CC      nolibc-test
32 gettimeofday_null = -1 EFAULT        [FAIL]
See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out

------------------------------------------------------------------------

I have attached run.out.

In contrast, with my hand-built qemu-x86_64, all tests passed.

This might be just a version-related bug, but figured I should let you
guys know.

							Thanx, Paul

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Description: run.out
Content-Disposition: attachment; filename="run.out"

Running test 'syscall'
0 getpid = 2270744                       [OK]
1 getppid = 2270743                      [OK]
3 gettid = 2270744                       [OK]
5 getpgid_self = 2270584                 [OK]
6 getpgid_bad = -1 ESRCH                 [OK]
7 kill_0 = 0                             [OK]
8 kill_CONT = 0                          [OK]
9 kill_BADPID = -1 ESRCH                 [OK]
10 sbrk = 0                              [OK]
11 brk = 0                               [OK]
12 chdir_root = 0                        [OK]
13 chdir_dot = 0                         [OK]
14 chdir_blah = -1 ENOENT                [OK]
15 chmod_net = 0                         [OK]
16 chmod_self = -1 EPERM                 [OK]
17 chown_self = -1 EPERM                 [OK]
18 chroot_root = 0                       [OK]
19 chroot_blah = -1 ENOENT               [OK]
20 chroot_exe = -1 ENOTDIR               [OK]
21 close_m1 = -1 EBADF                   [OK]
22 close_dup = 0                         [OK]
23 dup_0 = 3                             [OK]
24 dup_m1 = -1 EBADF                     [OK]
25 dup2_0 = 100                          [OK]
26 dup2_m1 = -1 EBADF                    [OK]
27 dup3_0 = 100                          [OK]
28 dup3_m1 = -1 EBADF                    [OK]
29 execve_root = -1 EACCES               [OK]
30 getdents64_root = 672                 [OK]
31 getdents64_null = -1 ENOTDIR          [OK]
32 gettimeofday_null = -1 EFAULT        [FAIL]
34 gettimeofday_bad1 = -1 EFAULT         [OK]
35 gettimeofday_bad2 = -1 EFAULT         [OK]
36 gettimeofday_bad2 = -1 EFAULT         [OK]
38 getpagesize = 0                       [OK]
39 ioctl_tiocinq = 0                     [OK]
40 ioctl_tiocinq = 0                     [OK]
41 link_root1 = -1 EEXIST                [OK]
42 link_blah = -1 ENOENT                 [OK]
43 link_dir = -1 EPERM                   [OK]
44 link_cross = -1 EXDEV                 [OK]
45 lseek_m1 = -1 EBADF                   [OK]
46 lseek_0 = -1 ESPIPE                   [OK]
47 mkdir_root = -1 EEXIST                [OK]
48 open_tty = 3                          [OK]
49 open_blah = -1 ENOENT                 [OK]
50 poll_null = 0                         [OK]
51 poll_stdout = 1                       [OK]
52 poll_fault = -1 EFAULT                [OK]
53 read_badf = -1 EBADF                  [OK]
54 sched_yield = 0                       [OK]
55 select_null = 0                       [OK]
56 select_stdout = 1                     [OK]
57 select_fault = -1 EFAULT              [OK]
58 stat_blah = -1 ENOENT                 [OK]
59 stat_fault = -1 EFAULT                [OK]
60 symlink_root = -1 EEXIST              [OK]
61 unlink_root = -1 EISDIR               [OK]
62 unlink_blah = -1 ENOENT               [OK]
63 wait_child = -1 ECHILD                [OK]
64 waitpid_min = -1 ESRCH                [OK]
65 waitpid_child = -1 ECHILD             [OK]
66 write_badf = -1 EBADF                 [OK]
67 write_zero = 0                        [OK]
Errors during this test: 1

Running test 'stdlib'
0 getenv_TERM = <xterm>                  [OK]
1 getenv_blah = <(null)>                 [OK]
2 setcmp_blah_blah = 0                   [OK]
3 setcmp_blah_blah2 = -50                [OK]
4 setncmp_blah_blah = 0                  [OK]
5 setncmp_blah_blah4 = 0                 [OK]
6 setncmp_blah_blah5 = -53               [OK]
7 setncmp_blah_blah6 = -54               [OK]
8 strchr_foobar_o = <oobar>              [OK]
9 strchr_foobar_z = <(null)>             [OK]
10 strrchr_foobar_o = <obar>             [OK]
11 strrchr_foobar_z = <(null)>           [OK]
12 memcmp_20_20 = 0                      [OK]
13 memcmp_20_60 = -64                    [OK]
14 memcmp_60_20 = 64                     [OK]
15 memcmp_20_e0 = -192                   [OK]
16 memcmp_e0_20 = 192                    [OK]
17 memcmp_80_e0 = -96                    [OK]
18 memcmp_e0_80 = 96                     [OK]
Errors during this test: 0

Total number of errors: 1
Exiting with status 1

--6c2NcOVqGQ03X4Wi--
