Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5A754A94
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGOSQx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSQw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:16:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856530DF;
        Sat, 15 Jul 2023 11:16:48 -0700 (PDT)
X-QQ-mid: bizesmtp68t1689444997to9m2n2x
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:16:36 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000B00A0000000
X-QQ-FEAT: BoqqHjHGw8QIh40ItNs6exZvJ4gbv0malU/c/MueNUUZ1Cgz1KKOZnWPrjC/i
        Ft9RWa10BoU5bv7TTYCyz+hSqEp4N/n8RR1qMA396tH8VL/yoambGOA5DN9EuK+/me5VuB3
        kh5h5YSlipjpgTDBRSa/RuFF3pGNq+JqEhFAPdWD1a94YZruOqGdSsGUQSloE6XIskqQNUS
        3AQZ5oZS48U4BTWY2dRuWBMzJsyUIKZT6ASBOPpt26gDj07wkOFeElprjP5RlB7+d8d4vN4
        /6+F2NG6nQeMnRz8cIgT+QDHMxg68RiyYgTTavwl+4gV0hFfd036ImWhQF4dJC2ehS6wsEV
        Tcv11+YUeNcpEhOlmunr0YMSgI2yw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1381827740692131380
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 00/18] tools/nolibc: shrink arch support
Date:   Sun, 16 Jul 2023 02:16:36 +0800
Message-Id: <cover.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

Thanks very much for your careful review and great suggestions, now, we
get v4 revision of the arch shrink series [1], it mainly include a new
fixup for -O0 under gcc < 11.1.0, the stackprotector support for
_start_c(), new testcases for startup code and two new test targets.

All of the tests passed or skipped (tinyconfig + few options +
qemu-system) for both -Os and -O0:

                arch/board | result
                ------------|------------
            arm/versatilepb | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
            arm/vexpress-a9 | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
                   arm/virt | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
               aarch64/virt | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
                    i386/pc | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
                  x86_64/pc | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
               mipsel/malta | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
           loongarch64/virt | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
               riscv64/virt | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.
      s390x/s390-ccw-virtio | 165 test(s): 158 passed,   7 skipped,   0 failed => status: warning.

And more, for both -Os and -O0:

    $ for r in run-user run-nolibc-test run-libc-test; do make clean > /dev/null; make $r | grep status; done
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 153 passed,  12 skipped,   0 failed => status: warning

    // for make run-user, the euid0 and 32bit limit related tests are
    // skipped
    $ make clean && make run-user
    $ grep -i skip run.out
    17 chroot_root                                                  [SKIPPED]
    39 link_dir                                                     [SKIPPED]
    62 limit_intptr_min_32                                          [SKIPPED]
    63 limit_intptr_max_32                                          [SKIPPED]
    64 limit_uintptr_max_32                                         [SKIPPED]
    65 limit_ptrdiff_min_32                                         [SKIPPED]
    66 limit_ptrdiff_max_32                                         [SKIPPED]
    67 limit_size_max_32                                            [SKIPPED]

    // for run-libc-test, the _auxv variables, euid0, 32bits limit and 
    // stackprotector related tests are skipped
    $ make clean && make run-libc-test
    $ grep -i skip run.out
    9 environ_auxv                                                  [SKIPPED]
    10 environ_total                                                [SKIPPED]
    12 auxv_addr                                                    [SKIPPED]
    17 chroot_root                                                  [SKIPPED]
    39 link_dir                                                     [SKIPPED]
    62 limit_intptr_min_32                                          [SKIPPED]
    63 limit_intptr_max_32                                          [SKIPPED]
    64 limit_uintptr_max_32                                         [SKIPPED]
    65 limit_ptrdiff_min_32                                         [SKIPPED]
    66 limit_ptrdiff_max_32                                         [SKIPPED]
    67 limit_size_max_32                                            [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

    $ make clean >/dev/null; make run-libc-test CC=/labs/linux-lab/src/examples/musl-install/bin/musl-gcc  | grep status
    165 test(s): 151 passed,  12 skipped,   2 failed => status: failure

    // The failures are expected for musl has disabled both sbrk and brk
    // but not the sbrk(0); the _auxv variables, euid0, 32bits limit and
    // stackprotector related tests are skipped for musl too

    $ grep FAIL -ur run.out 
    9 sbrk = 1 ENOMEM                                               [FAIL]
    10 brk = -1 ENOMEM                                              [FAIL]

    $ grep "SKIP" -ur run.out 
    9 environ_auxv                                                  [SKIPPED]
    10 environ_total                                                [SKIPPED]
    12 auxv_addr                                                    [SKIPPED]
    17 chroot_root                                                  [SKIPPED]
    39 link_dir                                                     [SKIPPED]
    62 limit_intptr_min_32                                          [SKIPPED]
    63 limit_intptr_max_32                                          [SKIPPED]
    64 limit_uintptr_max_32                                         [SKIPPED]
    65 limit_ptrdiff_min_32                                         [SKIPPED]
    66 limit_ptrdiff_max_32                                         [SKIPPED]
    67 limit_size_max_32                                            [SKIPPED]
    0 -fstackprotector not supported                                [SKIPPED]

For stackprotector, gcc 13.1.0 is used to test on x86_64 standalonely:

    $ make run-user CROSS_COMPILE=x86_64-linux- | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    $ grep stack -ur run.out 
    0 -fstackprotector                                               [OK]
    $ make run-nolibc-test CROSS_COMPILE=x86_64-linux- | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    $ grep stack -ur run.out 
    0 -fstackprotector                                               [OK]

Changes from v3 --> v4:

* tools/nolibc: arch-*.h: add missing space after ','
  tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0

    Both of the above changes are for _start, it is able to merge them
    if necessary.

    The first one is old for format errors reported by
    scripts/checkpatch.pl

    The second one is for -O0 failure under gcc < 11.1.0, applied the
    optimize("-Os", "omit-frame-pointer") suggestion from Thomas. 

* tools/nolibc: remove the old sys_stat support

    As suggested by Willy, Document carefully about the statx supported
    Linux version info.

* tools/nolibc: add new crt.h with _start_c

    The code is polished carefully for smaller size and better
    readability.

* tools/nolibc: stackprotector.h: add empty __stack_chk_init for !_NOLIBC_STACKPROTECTOR
  tools/nolibc: crt.h: initialize stack protector

    As suggested by Thomas, init stackprotector in _start_c() too.

* tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c

    Removed the stackprotector initialization from _start too, we
    already have it in _start_c().

* selftests/nolibc: add EXPECT_PTRGE, EXPECT_PTRGT, EXPECT_PTRLE, EXPECT_PTRLT
  selftests/nolibc: add testcases for startup code

    Add a new startup test group to cover the testing of argc,
    argv/argv0, envp/environ and _auxv.

    Some testcases are enhanced, some are newly added from after the
    discussion during v3 review.

* selftests/nolibc: allow run nolibc-test locally
  selftests/nolibc: allow test -include /path/to/nolibc.h

    Two new test targets are added to cover more scenes.

Hope you like this revisoin ;-)

Next patchset is powerpc & powerpc64 support, after that we will send
the v2 of tinyconfig support, at last the left rv32 patches (mainly
64bit time).

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/20230715100134.GD24086@1wt.eu/

Zhangjin Wu (18):
  tools/nolibc: arch-*.h: add missing space after ','
  tools/nolibc: fix up startup failures for -O0 under gcc < 11.1.0
  tools/nolibc: remove the old sys_stat support
  tools/nolibc: add new crt.h with _start_c
  tools/nolibc: stackprotector.h: add empty __stack_chk_init for
    !_NOLIBC_STACKPROTECTOR
  tools/nolibc: crt.h: initialize stack protector
  tools/nolibc: arm: shrink _start with _start_c
  tools/nolibc: aarch64: shrink _start with _start_c
  tools/nolibc: i386: shrink _start with _start_c
  tools/nolibc: x86_64: shrink _start with _start_c
  tools/nolibc: mips: shrink _start with _start_c
  tools/nolibc: loongarch: shrink _start with _start_c
  tools/nolibc: riscv: shrink _start with _start_c
  tools/nolibc: s390: shrink _start with _start_c
  selftests/nolibc: add EXPECT_PTRGE, EXPECT_PTRGT, EXPECT_PTRLE,
    EXPECT_PTRLT
  selftests/nolibc: add testcases for startup code
  selftests/nolibc: allow run nolibc-test locally
  selftests/nolibc: allow test -include /path/to/nolibc.h

 tools/include/nolibc/Makefile                |   1 +
 tools/include/nolibc/arch-aarch64.h          |  57 +---------
 tools/include/nolibc/arch-arm.h              |  83 ++-------------
 tools/include/nolibc/arch-i386.h             |  62 ++---------
 tools/include/nolibc/arch-loongarch.h        |  46 +-------
 tools/include/nolibc/arch-mips.h             |  76 ++-----------
 tools/include/nolibc/arch-riscv.h            |  69 ++----------
 tools/include/nolibc/arch-s390.h             |  63 ++---------
 tools/include/nolibc/arch-x86_64.h           |  58 ++--------
 tools/include/nolibc/crt.h                   |  61 +++++++++++
 tools/include/nolibc/stackprotector.h        |   2 +
 tools/include/nolibc/sys.h                   |  63 ++---------
 tools/include/nolibc/types.h                 |   4 +-
 tools/testing/selftests/nolibc/Makefile      |  12 +++
 tools/testing/selftests/nolibc/nolibc-test.c | 106 ++++++++++++++++++-
 15 files changed, 246 insertions(+), 517 deletions(-)
 create mode 100644 tools/include/nolibc/crt.h

-- 
2.25.1

