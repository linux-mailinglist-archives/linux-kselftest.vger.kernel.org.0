Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2788757A92E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiGSVpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGSVpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:20 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A992B7E4;
        Tue, 19 Jul 2022 14:45:16 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj2jB002580;
        Tue, 19 Jul 2022 23:45:02 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 00/17] nolibc: add preliminary self tests
Date:   Tue, 19 Jul 2022 23:44:31 +0200
Message-Id: <20220719214449.2520-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paul,

as previously promised, here comes the nolibc update which introduces the
minimal self-test infrastructure that aims at being reasonably easy to
expand further.

It's based on your branch "dev.2022.06.30b" that contains the previous
minor fixes that aimed at addressing Linus' concerns about the build
process inconsistencies.

The way it works tries to mimmick as much as possible the regular build
process, so that it reuses the same ARCH, CC, CROSS_COMPILE to build the
test program, that will be embedded into an initramfs and the kernel is
(re)built with that initramfs. Then you can decide to run that kernel
under QEMU for the supported archs, and the output of the tests appears
in an output text file in a format that's easily greppable and diffable.
A single target "run" does everything.

By default it will reuse your existing .config (so that developers
continue to use their regular config handling), though it can also
create a known-to-work defconfig for each arch. The reason behind this
is that it took me a moment to figure certain defconfig + machine name
combinations and I found it better to put them there once for all.

I've successfully tested it on arm, arm64, i386, x86_64. riscv64 works
except two syscalls which return unexpected errors, and mips segfaults
in sbrk(). I don't know why yet, but this proves that it's worth having
such a test.

There are not that many tests yet (71), those that have to run can be
filtered either from the program's command line or from a NOLIBC_TEST
environment variable so that it's possible to skip broken ones or to
focus on a few ranges only.

Tests are numerically numbered, and are conveniently handled in a
switch/case statement so that a relative line number assigns the number
to the test. That's convenient because the vast majority of syscall tests
are one-liners. This sometimes slightly upsets check-patch when lines get
moderately long but that significantly improves legibility.

There are expectation for both successes and failures (e.g. -1 ENOTDIR).
I'm sure this can be improved later (and that's the goal). Right now it
covers two test families:
  - syscalls
  - stdlib    (str* functions mostly)

I suspect that over time we might want to split syscalls into different
parts (e.g. core, fs, etc maybe) but I could be wrong.

The program can automatically modulate QEMU's return value on x86 when
QEMU is run with the appropriate options, but for now I'm not using it
as I felt like it didn't bring much value, and the output is more useful.
That's debatable, and maybe some might want to use it in bisect scripts
for example. It's too early to say IMHO.

Oh, I also arranged the code so that the test also builds with glibc. I
noticed that when adding a new test that fails, sometimes it's convenient
to see if it's the nolibc part that's broken or the test. I don't find
this critical but the required includes and ifdefs are there so that it
should be easy to maintain over time as well.

I'm obviously interested in comments, but really, I don't want to
overdesign something for a first step, it remains a very modest test
program and I'd like that it remains easy to hack on it and to contribute
new tests that are deemed useful.

I'm CCing the few who already contributed some patches and/or expressed
interest, as well as Linus who had a first bad experience when trying to
test it, hoping this one will be better. I'm pasting below [1] a copy of
a test on x86_64 below, that's summed up as "71 test(s) passed" at the
end of the "run" target.

If there's no objection, it would be nice to have this with your current
series, as it definitely helps spot and fix the bugs. In parallel I'll see
if I can figure the problems with the two tests that fail each on a
specific arch and I might possibly have a few extra fixes for the current
nolibc.

Thank you!
Willy

[1] example output
----8<----
Running test 'syscall'
0 getpid = 1                             [OK]
1 getppid = 0                            [OK]
5 getpgid_self = 0                       [OK]
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
30 getdents64_root = 120                 [OK]
31 getdents64_null = -1 ENOTDIR          [OK]
32 gettimeofday_null = 0                 [OK]
38 ioctl_tiocinq = 0                     [OK]
39 ioctl_tiocinq = 0                     [OK]
40 link_root1 = -1 EEXIST                [OK]
41 link_blah = -1 ENOENT                 [OK]
42 link_dir = -1 EPERM                   [OK]
43 link_cross = -1 EXDEV                 [OK]
44 lseek_m1 = -1 EBADF                   [OK]
45 lseek_0 = -1 ESPIPE                   [OK]
46 mkdir_root = -1 EEXIST                [OK]
47 open_tty = 3                          [OK]
48 open_blah = -1 ENOENT                 [OK]
49 poll_null = 0                         [OK]
50 poll_stdout = 1                       [OK]
51 poll_fault = -1 EFAULT                [OK]
52 read_badf = -1 EBADF                  [OK]
53 sched_yield = 0                       [OK]
54 select_null = 0                       [OK]
55 select_stdout = 1                     [OK]
56 select_fault = -1 EFAULT              [OK]
57 stat_blah = -1 ENOENT                 [OK]
58 stat_fault = -1 EFAULT                [OK]
59 symlink_root = -1 EEXIST              [OK]
60 unlink_root = -1 EISDIR               [OK]
61 unlink_blah = -1 ENOENT               [OK]
62 wait_child = -1 ECHILD                [OK]
63 waitpid_min = -1 ESRCH                [OK]
64 waitpid_child = -1 ECHILD             [OK]
65 write_badf = -1 EBADF                 [OK]
66 write_zero = 0                        [OK]
Errors during this test: 0

Running test 'stdlib'
0 getenv_TERM = <linux>                  [OK]
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
Errors during this test: 0

Total number of errors: 0
---->8----


--

Willy Tarreau (17):
  tools/nolibc: make argc 32-bit in riscv startup code
  tools/nolibc: fix build warning in sys_mmap() when my_syscall6 is not
    defined
  tools/nolibc: make sys_mmap() automatically use the right __NR_mmap
    definition
  selftests/nolibc: add basic infrastructure to ease creation of nolibc
    tests
  selftests/nolibc: support a test definition format
  selftests/nolibc: implement a few tests for various syscalls
  selftests/nolibc: add a few tests for some stdlib functions
  selftests/nolibc: exit with poweroff on success when getpid() == 1
  selftests/nolibc: on x86, support exiting with isa-debug-exit
  selftests/nolibc: recreate and populate /dev and /proc if missing
  selftests/nolibc: condition some tests on /proc existence
  selftests/nolibc: support glibc as well
  selftests/nolibc: add a "kernel" target to build the kernel with the
    initramfs
  selftests/nolibc: add a "defconfig" target
  selftests/nolibc: add a "run" target to start the kernel in QEMU
  selftests/nolibc: "sysroot" target installs a local copy of the
    sysroot
  selftests/nolibc: add a "help" target

 MAINTAINERS                                  |   1 +
 tools/include/nolibc/arch-riscv.h            |   2 +-
 tools/include/nolibc/sys.h                   |   4 +-
 tools/testing/selftests/nolibc/Makefile      | 135 ++++
 tools/testing/selftests/nolibc/nolibc-test.c | 757 +++++++++++++++++++
 5 files changed, 896 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/nolibc/Makefile
 create mode 100644 tools/testing/selftests/nolibc/nolibc-test.c

-- 
2.17.5

