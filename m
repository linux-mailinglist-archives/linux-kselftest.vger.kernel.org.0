Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9479E77DC7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbjHPIiD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 04:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243063AbjHPIhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 04:37:06 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB01935B6;
        Wed, 16 Aug 2023 01:36:03 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37G8ZWHQ016519;
        Wed, 16 Aug 2023 10:35:32 +0200
Date:   Wed, 16 Aug 2023 10:35:32 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Message-ID: <ZNyKVGn1wBkUz2+n@1wt.eu>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
 <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
 <ZNvIkD1oxZENVkoe@1wt.eu>
 <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a03aa3-3d6e-3b16-d113-7d7f5a84bfb4@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Shuah,

On Tue, Aug 15, 2023 at 03:06:39PM -0600, Shuah Khan wrote:
> > I've pushed a tag named 20230815-for-6.6-2 in the repo below:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> > 
> > Please let me know if you want me to resend a PR.
> > 
> 
> Pull worked fine and my verify_fixes script failed on the following patches.
> 
> Commit: 6c931bf0c732 ("selftests/nolibc: avoid buffer underrun in space printing")
> 	Fixes tag: Fixes: 8a27526f49f9 ("selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER")
> 	Has these problem(s):
> 		- Target SHA1 does not exist

Sadly this one was within the same branch and got rebased, now fixed.
Another one had the same issue after the fix, I've dropped the fixes
tag.

> Commit: 40f12898b479 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
> 	Fixes tag: Fixes: ecb7fe2cd610 ("selftests: line buffer test program's stdout")
> 	Has these problem(s):
> 		- Target SHA1 does not exist

This one mentioned a commit that's only in linux-next, I simply dropped
the fixes tag.

> Will you be able to add the right commit IDs and resend the pull, so there
> are no mistakes if I guess it wrong.

Please use the new following one instead.

Thanks!
Willy

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ tags/20230816-for-6.6-3

for you to fetch changes up to 938315d721db3b08c958e92b8237fb4986c66b7e:

  tools/nolibc: avoid undesired casts in the __sysret() macro (2023-08-16 10:31:17 +0200)

----------------------------------------------------------------
Ryan Roberts (1):
      tools/nolibc/stdio: add setvbuf() to set buffering mode

Thomas Weiﬂschuh (22):
      selftests/nolibc: drop test chmod_net
      selftests/nolibc: simplify call to ioperm
      tools/nolibc: completely remove optional environ support
      selftests/nolibc: make evaluation of test conditions
      selftests/nolibc: simplify status printing
      selftests/nolibc: avoid gaps in test numbers
      selftests/nolibc: avoid buffer underrun in space printing
      tools/nolibc: drop unused variables
      tools/nolibc: fix return type of getpagesize()
      tools/nolibc: setvbuf: avoid unused parameter warnings
      tools/nolibc: sys: avoid implicit sign cast
      tools/nolibc: stdint: use __SIZE_TYPE__ for size_t
      selftests/nolibc: drop unused variables
      selftests/nolibc: mark test helpers as potentially unused
      selftests/nolibc: make functions static if possible
      selftests/nolibc: avoid unused parameter warnings
      selftests/nolibc: avoid sign-compare warnings
      selftests/nolibc: use correct return type for read() and write()
      selftests/nolibc: prevent out of bounds access in expect_vfprintf
      selftests/nolibc: don't strip nolibc-test
      selftests/nolibc: enable compiler warnings
      MAINTAINERS: nolibc: add myself as co-maintainer

Willy Tarreau (3):
      selftests/nolibc: avoid warnings during intptr tests
      tools/nolibc: keep brk(), sbrk(), mmap() away from __sysret()
      tools/nolibc: avoid undesired casts in the __sysret() macro

Yuan Tan (2):
      tools/nolibc: add pipe() and pipe2() support
      selftests/nolibc: add testcase for pipe

Zhangjin Wu (76):
      selftests/nolibc: add a standalone test report macro
      selftests/nolibc: always print the path to test log file
      selftests/nolibc: restore the failed tests print
      tools/nolibc: fix up #error compile failures with -ENOSYS
      tools/nolibc: fix up undeclared syscall macros with #ifdef and -ENOSYS
      tools/nolibc: sys.h: add a syscall return helper
      tools/nolibc: unistd.h: apply __sysret() helper
      tools/nolibc: sys.h: apply __sysret() helper
      tools/nolibc: unistd.h: reorder the syscall macros
      tools/nolibc: arch-*.h: fix up code indent errors
      toolc/nolibc: arch-*.h: clean up whitespaces after __asm__
      tools/nolibc: arch-loongarch.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
      tools/nolibc: arch-mips.h: shrink with _NOLIBC_SYSCALL_CLOBBERLIST
      tools/nolibc: add missing my_syscall6() for mips
      tools/nolibc: __sysret: support syscalls who return a pointer
      tools/nolibc: clean up mmap() routine
      tools/nolibc: clean up sbrk() routine
      selftests/nolibc: export argv0 for some tests
      selftests/nolibc: prepare: create /dev/zero
      selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
      selftests/nolibc: add sbrk_0 to test current brk getting
      selftests/nolibc: add mmap_bad test case
      selftests/nolibc: add munmap_bad test case
      selftests/nolibc: add mmap_munmap_good test case
      selftests/nolibc: add run-libc-test target
      selftests/nolibc: stat_fault: silence NULL argument warning with glibc
      selftests/nolibc: gettid: restore for glibc and musl
      selftests/nolibc: add _LARGEFILE64_SOURCE for musl
      selftests/nolibc: fix up int_fast16/32_t test cases for musl
      tools/nolibc: types.h: add RB_ flags for reboot()
      selftests/nolibc: prefer <sys/reboot.h> to <linux/reboot.h>
      selftests/nolibc: fix up kernel parameters support
      selftests/nolibc: link_cross: use /proc/self/cmdline
      tools/nolibc: add rmdir() support
      selftests/nolibc: add a new rmdir() test case
      selftests/nolibc: fix up failures when CONFIG_PROC_FS=n
      selftests/nolibc: prepare /tmp for tests that need to write
      selftests/nolibc: vfprintf: remove MEMFD_CREATE dependency
      selftests/nolibc: chdir_root: restore current path after test
      selftests/nolibc: stat_timestamps: remove procfs dependency
      selftests/nolibc: chroot_exe: remove procfs dependency
      selftests/nolibc: add chmod_argv0 test
      selftests/nolibc: report: print a summarized test status
      selftests/nolibc: report: print total tests
      selftests/nolibc: report: align passed, skipped and failed
      selftests/nolibc: report: extrude the test status line
      selftests/nolibc: report: add newline before test failures
      tools/nolibc: arch-*.h: add missing space after ','
      tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0
      tools/nolibc: remove the old sys_stat support
      tools/nolibc: add new crt.h with _start_c
      tools/nolibc: stackprotector.h: add empty __stack_chk_init for !_NOLIBC_STACKPROTECTOR
      tools/nolibc: crt.h: initialize stack protector
      tools/nolibc: arm: shrink _start with _start_c
      tools/nolibc: aarch64: shrink _start with _start_c
      tools/nolibc: i386: shrink _start with _start_c
      tools/nolibc: x86_64: shrink _start with _start_c
      tools/nolibc: mips: shrink _start with _start_c
      tools/nolibc: loongarch: shrink _start with _start_c
      tools/nolibc: riscv: shrink _start with _start_c
      tools/nolibc: s390: shrink _start with _start_c
      selftests/nolibc: add EXPECT_PTRGE, EXPECT_PTRGT, EXPECT_PTRLE, EXPECT_PTRLT
      selftests/nolibc: add testcases for startup code
      selftests/nolibc: allow run nolibc-test locally
      selftests/nolibc: allow test -include /path/to/nolibc.h
      selftests/nolibc: mmap_munmap_good: fix up return value
      tools/nolibc: add support for powerpc
      tools/nolibc: add support for powerpc64
      selftests/nolibc: add XARCH and ARCH mapping support
      selftests/nolibc: add test support for ppc
      selftests/nolibc: add test support for ppc64le
      selftests/nolibc: add test support for ppc64
      selftests/nolibc: allow report with existing test log
      tools/nolibc: stackprotector.h: make __stack_chk_init static
      selftests/nolibc: libc-test: use HOSTCC instead of CC
      tools/nolibc: silence ppc64 compile warnings

 MAINTAINERS                                  |   1 +
 tools/include/nolibc/Makefile                |   1 +
 tools/include/nolibc/arch-aarch64.h          |  85 +---
 tools/include/nolibc/arch-arm.h              | 111 +----
 tools/include/nolibc/arch-i386.h             |  86 +---
 tools/include/nolibc/arch-loongarch.h        |  83 +---
 tools/include/nolibc/arch-mips.h             | 147 +++----
 tools/include/nolibc/arch-powerpc.h          | 221 ++++++++++
 tools/include/nolibc/arch-riscv.h            |  83 +---
 tools/include/nolibc/arch-s390.h             |  77 +---
 tools/include/nolibc/arch-x86_64.h           |  86 +---
 tools/include/nolibc/arch.h                  |   2 +
 tools/include/nolibc/crt.h                   |  61 +++
 tools/include/nolibc/nolibc.h                |   9 +-
 tools/include/nolibc/stackprotector.h        |   5 +-
 tools/include/nolibc/stdint.h                |   2 +-
 tools/include/nolibc/stdio.h                 |  27 ++
 tools/include/nolibc/stdlib.h                |  12 +-
 tools/include/nolibc/sys.h                   | 534 +++++++----------------
 tools/include/nolibc/types.h                 |  22 +-
 tools/include/nolibc/unistd.h                |  13 +-
 tools/testing/selftests/nolibc/Makefile      | 111 +++--
 tools/testing/selftests/nolibc/nolibc-test.c | 609 ++++++++++++++++++++-------
 23 files changed, 1221 insertions(+), 1167 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h
 create mode 100644 tools/include/nolibc/crt.h
