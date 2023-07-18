Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE675868F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjGRVK2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjGRVK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:10:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48781BCB;
        Tue, 18 Jul 2023 14:09:58 -0700 (PDT)
X-QQ-mid: bizesmtp62t1689714584t1v0xb12
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:09:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: RmDZc/K2LPHRRX1ziPaMNp2KF6y/A9L2nQGox1+F18Ejlrxpb6oFcdf+CRNjj
        1hWaWirBP8guBjmHD9EyBSyq5r1m6iH0qXET1c4IguV0WkgWmRM2mtcYb7xXYGejD4BDIIf
        6zN8wjfBHf9UF3DhUdyXKRtUOjmNmp9VUANi0eJ9x8KcjONpbuEux/eHxCwVrRK3EUpRPvc
        kS6vIfkYv+iwyHpzQNgnalVr0eyITwuactFBx4TtQrjo7etOasNLPTwFUBa96GZEzqQoMDv
        03tggFk8OMvgpfgzK/YiPHRGOLp4FuawkUujbwzAfNTNSeIHTdr06vNMogh/drIZGVZy+NS
        8xntVYr1wqWhPOQY84Uma4jnK68BERyofScFgpwmfde6iq4EcZgaXtcqFtJeg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11760767951132339982
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 0/8] tools/nolibc: add 32/64-bit powerpc support
Date:   Wed, 19 Jul 2023 05:09:42 +0800
Message-Id: <cover.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Here is the powerpc support, includes 32-bit big-endian powerpc, 64-bit
little endian and big endian powerpc.

All of them passes run-user with the default powerpc toolchain from
Ubuntu 20.04:

    $ make run-user DEFCONFIG=tinyconfig XARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    $ make run-user DEFCONFIG=tinyconfig XARCH=powerpc64 CROSS_COMPILE=powerpc64le-linux-gnu- | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning
    $ make run-user DEFCONFIG=tinyconfig XARCH=powerpc64le CROSS_COMPILE=powerpc64le-linux-gnu- | grep status
    165 test(s): 157 passed,   8 skipped,   0 failed => status: warning

For the slow 'run' target, I have run with defconfig before, and just
verified them via the fast tinyconfig + run with a new patch from next
patchset, all of them passes:

    165 test(s): 156 passed,   9 skipped,   0 failed => status: warning

Note, the big endian crosstool powerpc64-linux-gcc from
https://mirrors.edge.kernel.org/pub/tools/crosstool/ has been used to
test both little endian and big endian powerpc64 too, both passed.

Here simply explain what they are:

* tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64

    32-bit & 64-bit powerpc support of nolibc.

* selftests/nolibc: select_null: fix up for big endian powerpc64

    fix up a test case for big endian powerpc64.

* selftests/nolibc: add extra config file customize support

    add extconfig target to allow enable extra config options via
    configs/<ARCH>.config

    applied suggestion from Thomas to use config files instead of config
    lines.

* selftests/nolibc: add XARCH and ARCH mapping support

    applied suggestions from Willy, use XARCH as the input of our nolibc
    test, use ARCH as the pure kernel input, at last build the mapping
    between XARCH and ARCH.

    Customize the variables via the input XARCH.

* selftests/nolibc: add test support for powerpc

    Require to use extconfig to enable the console options specified in
    configs/powerpc.config

    currently, we should manually run extconfig after defconfig, in next
    patchset, we will do this automatically.

* selftests/nolibc: add test support for powerpc64le
  selftests/nolibc: add test support for powerpc64

    Very simple, but customize CFLAGS carefully to let them work with
    powerpc64le-linux-gnu-gcc (from Linux distributions) and
    powerpc64-linux-gcc (from mirrors.edge.kernel.org)

The next patchset will not be tinyconfig, but some prepare patches, will
be sent out soon.

Best regards,
Zhangjin
---

Zhangjin Wu (8):
  tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: select_null: fix up for big endian powerpc64
  selftests/nolibc: add extra config file customize support
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add test support for powerpc
  selftests/nolibc: add test support for powerpc64le
  selftests/nolibc: add test support for powerpc64

 tools/include/nolibc/arch-powerpc.h           | 170 ++++++++++++++++++
 tools/testing/selftests/nolibc/Makefile       |  55 ++++--
 .../selftests/nolibc/configs/powerpc.config   |   3 +
 tools/testing/selftests/nolibc/nolibc-test.c  |   2 +-
 4 files changed, 217 insertions(+), 13 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc.config

-- 
2.25.1

