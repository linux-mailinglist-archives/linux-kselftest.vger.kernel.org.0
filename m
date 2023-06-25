Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67A773D1F6
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFYQLM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:11:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEC134;
        Sun, 25 Jun 2023 09:11:07 -0700 (PDT)
X-QQ-mid: bizesmtp64t1687709456tv1c7j71
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:10:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: KsDwwU1VpmJ4cvjoI/75hmeukCJId3nZP+iIvuKwWYCZfl43c0YFcNq7zOdGP
        oW9/VvYS93ytxkh0HO9NrqybQKYHwZ7lp/xCxW32+4VfTYkG+8Ags0tde+l42pf1fRLbgGu
        DMyre5cj4HAzZ1+ip/t885T9K+2Iv8CggKlTP7L8+ewseCbGFw14dBObzRuQcHX/iylD83O
        ZVbacwwKjWu+bxQ1GzmQP0+T9qySUPX1r5ikqfcFqvSMEQe1jJPTHiqyrlVPeaskVQ9xN34
        i/qXG3r5gGR56tvJWPkpwzmVLDuR/yB7Lkk7oGSIzmCjNimLzbQtbKN+DADgJalGSVJ7T+u
        Ib2qqtmurMJOvRd/+E=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16976959707686393999
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config support
Date:   Mon, 26 Jun 2023 00:10:46 +0800
Message-Id: <cover.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Willy, Thomas

We just sent the 'selftests/nolibc: allow run with minimal kernel
config' series [1], Here is the 'minimal' kernel config support, with
both of them, it is possible to run nolibc-test for all architectures
with oneline command and in less than ~30 minutes - 1 hour (not fullly
measured yet):

    // run with tiny config + qemu-system
    // Note: rv32 and loongarch require to download the bios at first
    $ time make run-tiny-all QUIET_RUN=1

    // run with default config + qemu-system
    $ time make run-default-all QUIET_RUN=1

    // run with qemu-user
    $ time make run-user-all QUIET_RUN=1

Besides the 'tinyconfig' suggestion from Thomas, this patch also merge
the generic part of my local powerpc porting (the extconfig to add
additional console support).

This is applied after the test report patchset [2] and the rv32 compile
patchset [3], because all of them touched the same Makefile.

Even without the 'selftests/nolibc: allow run with minimal kernel
config' series [1], all of the tests can pass except the /proc/self/net
related ones (We haven't enable CONFIG_NET in this patchset), the
chmod_net one will be removed by Thomas from this patchset [4] for the
wrong chmodable attribute issue of /proc/self/net, the link_cross one
can be simply fixed up by using another /proc/self interface (like
/proc/self/cmdline), which will be covered in our revision of the [1]
series.

Beside the core 'minimal' config support, some generic patch are added
together to avoid patch conflicts.

* selftests/nolibc: add test for -include /path/to/nolibc.h

  Add a test switch to allow run nolibc-test with nolibc.h

* selftests/nolibc: print result to the screen too

  Let the run targets print results by default, allow disable by
  QUIET_RUN=1

* selftests/nolibc: allow use x86_64 toolchain for i386

  Allow use x86_64 toolchains for i386

* selftests/nolibc: add menuconfig target for manual config

  a new 'menuconfig' target added for development and debugging

* selftests/nolibc: add tinyconfig target

  a new 'tinyconfig' compare to 'defconfig', smaller and faster, but not
  enough for boot and print, require following 'extconfig' target

* selftests/nolibc: allow customize extra kernel config options

  a new 'extconfig' allows to add extra config options for 'defconfig'
  and 'tinyconfig'

* selftests/nolibc: add common extra config options
  selftests/nolibc: add power reset control support
  selftests/nolibc: add procfs, shmem and tmpfs

  Add common extra configs, the 3rd one (procfs, shmem and tmpfs) can be
  completely reverted after [1] series, but as discuss with Thomas,
  procfs may be still a hard requirement.

* selftests/nolibc: add extra configs for i386
  selftests/nolibc: add extra configs for x86_64
  selftests/nolibc: add extra configs for arm64
  selftests/nolibc: add extra configs for arm
  selftests/nolibc: add extra configs for mips
  selftests/nolibc: add extra configs for riscv32
  selftests/nolibc: add extra configs for riscv64
  selftests/nolibc: add extra configs for s390x
  selftests/nolibc: add extra configs for loongarch

  Add architecture specific extra configs to let kernel boot and
  nolibc-test print. The rv32 added here is only for test, it should not
  be merged before the missing 64bit syscalls are added (still wait for
  the merging of the __sysret and -ENOSYS patches).

* selftests/nolibc: config default CROSS_COMPILE
  selftests/nolibc: add run-tiny and run-default

  both run-tiny and run-default are added to do config and run together,
  this easier test a log.

* selftests/nolibc: allow run tests on all targets
  selftests/nolibc: detect bios existing to avoid hang

  Further allow do run-user, run-tiny and run-default for all
  architectures at once, the -all suffix is added to do so.

Since some generic patches are still in review, before sending the left
rv32 patches, I'm will send more generic patches later, the coming one
is arch-xxx.h cleanup, and then, the 32bit powerpc porting support.

For the compile speedup, the next step may be add architecture specific
'O' support, which may allow us rerun across architectures without
mrproper, for a single architecture development, this 'minimal' config
should be enough ;-)

Thanks.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1687344643.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/cover.1687156559.git.falcon@tinylab.org/
[3]: https://lore.kernel.org/linux-riscv/cover.1687176996.git.falcon@tinylab.org/
[4]: https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/

Zhangjin Wu (22):
  selftests/nolibc: add test for -include /path/to/nolibc.h
  selftests/nolibc: print result to the screen too
  selftests/nolibc: allow use x86_64 toolchain for i386
  selftests/nolibc: add menuconfig target for manual config
  selftests/nolibc: add tinyconfig target
  selftests/nolibc: allow customize extra kernel config options
  selftests/nolibc: add common extra config options
  selftests/nolibc: add power reset control support
  selftests/nolibc: add procfs, shmem and tmpfs
  selftests/nolibc: add extra configs for i386
  selftests/nolibc: add extra configs for x86_64
  selftests/nolibc: add extra configs for arm64
  selftests/nolibc: add extra configs for arm
  selftests/nolibc: add extra configs for mips
  selftests/nolibc: add extra configs for riscv32
  selftests/nolibc: add extra configs for riscv64
  selftests/nolibc: add extra configs for s390x
  selftests/nolibc: add extra configs for loongarch
  selftests/nolibc: config default CROSS_COMPILE
  selftests/nolibc: add run-tiny and run-default
  selftests/nolibc: allow run tests on all targets
  selftests/nolibc: detect bios existing to avoid hang

 tools/testing/selftests/nolibc/Makefile | 125 ++++++++++++++++++++++--
 1 file changed, 119 insertions(+), 6 deletions(-)

-- 
2.25.1

