Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB03759661
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjGSNRY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGSNRK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:17:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3801A6;
        Wed, 19 Jul 2023 06:17:06 -0700 (PDT)
X-QQ-mid: bizesmtp66t1689772614tyh1wr0y
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:16:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: k0mQ4ihyJQPTmw+A9oK+u2PtB5uAvc7wlhDPNeQTJWoGMiWrU95CEy2hIh8i9
        59kcct7KyWxHVho8yTeYOvtKr6yH4TCgcfpJQks7Nudk2azuUuIVcH8lO+XYjwZw0JSgFih
        ASyyZUksydOG+jiwFuRS1y6q9QWrbnYUSz0rrpHXaaEZiU7lXczJxw0Eq5c2XxC4FYtnR1W
        T8i2Rmrf58wvp551SMc0wu82S/gkCYChDRAVoHVSSiuJFKJvZG3q28ZJlpfVhgex7t2TYEV
        HOuzV1ElP37VvDOO/mFedZymoHz41nO6o4P+wwq3YC/6Fh71pGGG+JK6Mqwv7FzLz8838Ui
        CU2fDFgi6CcKsnrvYBmBND3XhUto739JL8Xx9OL08HEBIuPlXg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8223366213678110786
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 00/14] selftests/nolibc: add minimal kernel config support - part1
Date:   Wed, 19 Jul 2023 21:16:52 +0800
Message-Id: <cover.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
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

Hi, Willy, Thomas

Here is the first part of v2 of our tinyconfig support for nolibc-test
[1], the patchset subject is reserved as before.

As discussed in v1 thread [1], to easier the review progress, the whole
tinyconfig support is divided into several parts, mainly by
architecture, here is the first part, include basic preparation and
powerpc example.

This patchset should be applied after the 32/64-bit powerpc support [2],
exactly these two are required by us:

    * selftests/nolibc: add extra config file customize support
    * selftests/nolibc: add XARCH and ARCH mapping support

In this patchset, we firstly add some misc preparations and at last add
the tinyconfig target and use powerpc as the first example. 

Tests:

    // powerpc run-user
    $ for arch in powerpc powerpc64 powerpc64le; do \
        rm -rf $PWD/kernel-$arch; \
        mkdir -p $PWD/kernel-$arch; \
        make run-user XARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out | grep "status: "; \
      done
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

    // powerpc run
    $ for arch in powerpc powerpc64 powerpc64le; do \
        rm -rf $PWD/kernel-$arch; \
        mkdir -p $PWD/kernel-$arch; \
        make tinyconfig run XARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out; \
      done

    $ for arch in powerpc powerpc64 powerpc64le; do \
        make report XARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out | grep "status: "; \
      done
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

    // the others, randomly choose some
    $ make run-user XARCH=arm O=$PWD/kernel-arm RUN_OUT=$PWD/run.arm.out CROSS_COMPILE=arm-linux-gnueabi- | grep status:
    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning
    $ make run-user XARCH=x86_64 O=$PWD/kernel-arm RUN_OUT=$PWD/run.x86_64.out CROSS_COMPILE=x86_64-linux-gnu- | grep status:
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    $ make run-libc-test | grep status:
    165 test(s): 153 passed,  12 skipped,   0 failed => status: warning 

    // x86_64, require noapic kernel command line option for old qemu-system-x86_64 (v4.2.1)
    $ make run XARCH=x86_64 O=$PWD/kernel-x86_64 RUN_OUT=$PWD/run.x86_64.out CROSS_COMPILE=x86_64-linux-gnu- | grep status
    $ make rerun XARCH=x86_64 O=$PWD/kernel-x86_64 RUN_OUT=$PWD/run.x86_64.out CROSS_COMPILE=x86_64-linux-gnu- | grep status
    165 test(s): 159 passed,   6 skipped,   0 failed => status: warning

tinyconfig mainly targets as a time-saver, the misc preparations service
for the same goal, let's take a look:

* selftests/nolibc: allow report with existing test log

    Like rerun without rebuild, Add report (without rerun) to summarize
    the existing test log, this may work perfectly with the 'grep status'

* selftests/nolibc: add macros to enhance maintainability

    Several macros are added to dedup the shared code to shrink lines
    and easier the maintainability

    The macros are added just before the using area to avoid code change
    conflicts in the future.

* selftests/nolibc: print running log to screen

    Enable logging to let developers learn what is happening at the
    first glance, without the need to edit the Makefile and rerun it.

    These helps a lot when there is a long-time running, a failed
    poweroff or even a forever hang.

    For test summmary, the 'grep status' can be used together with the
    standalone report target.

* selftests/nolibc: fix up O= option support

    With objtree instead srctree for .config and IMAGE, now, O= works.

    Using O=$PWD/kernel-$arch avoid the mrproer for every build.

* selftests/nolibc: add menuconfig for development

    Allow manually tuning some options, mainly for a new architecture
    porting.

* selftests/nolibc: add mrproper for development
  selftests/nolibc: defconfig: remove mrproper target

    Split the mrproper target out of defconfig, when with O=, mrproper is not
    required by defconfig, but reserve it for the other use scenes.

* selftests/nolibc: string the core targets

    Allow simply 'make run' instead of 'make defconfig; make extconfig;
    make kernel; make run'.

* selftests/nolibc: allow quit qemu-system when poweroff fails

    When poweroff fails, allow exit while detects the power off string
    from output or the wait time is too long (specified by QEMU_TIMEOUT).

    This helps the boards who have no poweroff support or the kernel not
    enable the poweroff options (mainly for tinyconfig).

* selftests/nolibc: allow customize CROSS_COMPILE by architecture
* selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

    This further saves a CROSS_COMPILE option for 'make run', it is very
    important when iterates all of the supported architectures and the
    compilers are not just prefixed with the XARCH variable.

    For example, binary of big endian powerpc64 can be compiled with
    powerpc64le-linux-gnu-, but the prefix is powerpc64le.

    Even if the pre-customized compiler not exist, we can configure
    CROSS_COMPILE_<ARCH> before the test loop to use the code.

* selftests/nolibc: add tinyconfig target
  selftests/nolibc: tinyconfig: add extra common options
  selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc

    Here is the first architecture(and its variants) support tinyconfig.

    powerpc is actually a very good architecture, for it has 'various'
    variants for test.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687706332.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1689713175.git.falcon@tinylab.org/


Zhangjin Wu (14):
  selftests/nolibc: allow report with existing test log
  selftests/nolibc: add macros to enhance maintainability
  selftests/nolibc: print running log to screen
  selftests/nolibc: fix up O= option support
  selftests/nolibc: add menuconfig for development
  selftests/nolibc: add mrproper for development
  selftests/nolibc: defconfig: remove mrproper target
  selftests/nolibc: string the core targets
  selftests/nolibc: allow quit qemu-system when poweroff fails
  selftests/nolibc: allow customize CROSS_COMPILE by architecture
  selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc
  selftests/nolibc: add tinyconfig target
  selftests/nolibc: tinyconfig: add extra common options
  selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc

 tools/testing/selftests/nolibc/Makefile       | 102 ++++++++++++++----
 .../selftests/nolibc/configs/common.config    |   4 +
 .../selftests/nolibc/configs/powerpc.config   |   3 +
 .../selftests/nolibc/configs/powerpc64.config |   3 +
 .../nolibc/configs/powerpc64le.config         |   4 +
 5 files changed, 98 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/nolibc/configs/common.config
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc64.config
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc64le.config

-- 
2.25.1

