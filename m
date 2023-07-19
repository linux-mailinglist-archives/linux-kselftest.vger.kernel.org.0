Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197E57596E7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGSNdB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGSNdB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:33:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF610A;
        Wed, 19 Jul 2023 06:32:58 -0700 (PDT)
X-QQ-mid: bizesmtp79t1689773568tihiumin
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:32:47 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: vrqOr+ppv0uPJA1yEKpWWkVnlUVqK6PuuvjdcyUHTrqkd/pqeEmMWxHZikDYj
        CkZ8/RJXIHvgLJf2jqgOcGTFxCd/FQ5bl379HoWrd8vkibnH47pU5q0kP+sxxDjREvmZU+e
        be2EPxscjn2d7Dfo95eemVORbMsNqsAUq5tF5GbGkP5HsHyifNSJktBae+cshFgImccttiP
        47/eb2g/JI2ocs7p12XfFJuF0kjb2M2KZRL7Ly1g1lw/eOebxaWOu/oZoA/re3h4LpsrvO2
        jkRTyhWJYBER4Mk/Ustf6yzF1N4ex+pClTbjBlYQqEP6IRtHjD+qNfNume0CK7azkie0Tyr
        cJmGlgv+Ywb02/GEHq9Pt9+CZN8PGY7gnG7AVQ+U/bJJ/ycN9CF698Aq+ekGQbC0vx2kUfv
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3748257128951603751
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 14/14] selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc
Date:   Wed, 19 Jul 2023 21:32:46 +0800
Message-Id: <15b47c6901f79a22b985a53efeae71dc7b172a5f.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
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

Firstly, add extra config files for powerpc, powerpc64le and powerpc64.

Second, QEMU_TIMEOUT is configured as 60 seconds for powerpc to allow
quit qemu-system-ppc even if poweroff fails. In normal host machine, ~20
seconds may be enough for boot+test+poweroff, but 60 seconds is used
here to gurantee it at least finish even in a very slow host machine or
the host machine is too busy. Both powerpc64le and powerpc64 can
poweroff normally, no need to configure QEMU_TIMEOUT for them.

It is able to use tinyconfig as the minimal config target to speed up
the run target of powerpc:

    $ for arch in powerpc powerpc64 powerpc64le; do \
        rm -rf $PWD/kernel-$arch; \
        mkdir -p $PWD/kernel-$arch; \
        make tinyconfig run XARCH=$arch O=$PWD/kernel-$arch | grep status ; \
      done

rerun with architecture specific run.out (for later report):

    $ for arch in powerpc powerpc64 powerpc64le; do \
        mkdir -p $PWD/kernel-$arch; \
        make rerun XARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out | grep status ; \
      done

report:

    $ for arch in powerpc powerpc64 powerpc64le; do \
        make report RUN_OUT=$PWD/run.$arch.out | grep status ; \
      done

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile                   | 1 +
 tools/testing/selftests/nolibc/configs/powerpc.config     | 3 +++
 tools/testing/selftests/nolibc/configs/powerpc64.config   | 3 +++
 tools/testing/selftests/nolibc/configs/powerpc64le.config | 4 ++++
 4 files changed, 11 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc64.config
 create mode 100644 tools/testing/selftests/nolibc/configs/powerpc64le.config

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f42782fa78a9..b01346323e35 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -103,6 +103,7 @@ QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=N
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # QEMU_TIMEOUT: some architectures can not poweroff normally, especially for tinyconfig
+QEMU_TIMEOUT_powerpc     = 60
 QEMU_TIMEOUT             = $(QEMU_TIMEOUT_$(XARCH))
 
 # OUTPUT is only set when run from the main makefile, otherwise
diff --git a/tools/testing/selftests/nolibc/configs/powerpc.config b/tools/testing/selftests/nolibc/configs/powerpc.config
index b1975f8253f7..29123cee14c4 100644
--- a/tools/testing/selftests/nolibc/configs/powerpc.config
+++ b/tools/testing/selftests/nolibc/configs/powerpc.config
@@ -1,3 +1,6 @@
+CONFIG_COMPAT_32BIT_TIME=y
+CONFIG_PPC_PMAC=y
+CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
 CONFIG_SERIAL_PMACZILOG=y
 CONFIG_SERIAL_PMACZILOG_TTYS=y
 CONFIG_SERIAL_PMACZILOG_CONSOLE=y
diff --git a/tools/testing/selftests/nolibc/configs/powerpc64.config b/tools/testing/selftests/nolibc/configs/powerpc64.config
new file mode 100644
index 000000000000..4e17f0cdb99f
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/powerpc64.config
@@ -0,0 +1,3 @@
+CONFIG_PPC64=y
+CONFIG_PPC_POWERNV=y
+CONFIG_HVC_OPAL=y
diff --git a/tools/testing/selftests/nolibc/configs/powerpc64le.config b/tools/testing/selftests/nolibc/configs/powerpc64le.config
new file mode 100644
index 000000000000..713b227f506f
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/powerpc64le.config
@@ -0,0 +1,4 @@
+CONFIG_PPC64=y
+CONFIG_PPC_POWERNV=y
+CONFIG_HVC_OPAL=y
+CONFIG_CPU_LITTLE_ENDIAN=y
-- 
2.25.1

