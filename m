Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF5765D77
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjG0UeZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjG0UeY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:34:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B730EB;
        Thu, 27 Jul 2023 13:34:04 -0700 (PDT)
X-QQ-mid: bizesmtp81t1690490035tu076myn
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:33:54 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: Y6Kc/cQg3lYdDDFJ90mtjrutfwesBX2jEXConbTZEba2sKx27B/oxMiaMAba8
        hwIK0o+c2wffDHiHcQbDmpwB0Qe+iEUiXS2aUmAoTZ1ib/u8Sk7n+NB1Fqkwei5rt8DBMso
        iW4QXw1X8ZnkHvRR6B92r5ZAnW8XaDKAjDhUEgbAYsjKMFUDpOi782Q5XaU2P+dOcLMuoJQ
        Md4aoZU8FdsNorryyB+6OuScHeZ3G3x+A/jXSFpqSkGT1FcVD11ifzf47aNta6MJytc3G/d
        42KABhdRngyeOs++ddJWhwi2MruJcGkZNO8+eoF6S15ywZB0GYaTvLrbMOr/Ae79OM1xrOP
        kYVjm5o7KLAZd6L2iEWwbpbF5qvqOdn/2euao0AsIel3rA4fgywiqU8iwD36MiCFw+KY+yK
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10885213077665245786
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 11/12] selftests/nolibc: tinyconfig: add support for 32/64-bit powerpc
Date:   Fri, 28 Jul 2023 04:33:53 +0800
Message-Id: <983843582e52e83fba79ad45cea6c79e1f62ec6c.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds extra config options for ppc, ppc64le and ppc64, now, it is
able to use tinyconfig as the minimal config target to speed up the run
target of powerpc:

    $ for arch in ppc ppc64 ppc64le; do \
        mkdir -p $PWD/kernel-$arch; \
        make defconfig run DEFCONFIG=tinyconfig ARCH=$arch O=$PWD/kernel-$arch | grep status ; \
      done

rerun with architecture specific run.out:

    $ for arch in ppc ppc64 ppc64le; do \
        mkdir -p $PWD/kernel-$arch; \
        make rerun ARCH=$arch O=$PWD/kernel-$arch RUN_OUT=$PWD/run.$arch.out | grep status ; \
      done

report with existing test log:

    $ for arch in powerpc powerpc64 powerpc64le; do \
        make report RUN_OUT=$PWD/run.$arch.out | grep status ; \
      done

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/configs/ppc.config     | 3 +++
 tools/testing/selftests/nolibc/configs/ppc64.config   | 3 +++
 tools/testing/selftests/nolibc/configs/ppc64le.config | 4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc64.config
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc64le.config

diff --git a/tools/testing/selftests/nolibc/configs/ppc.config b/tools/testing/selftests/nolibc/configs/ppc.config
index b1975f8253f7..29123cee14c4 100644
--- a/tools/testing/selftests/nolibc/configs/ppc.config
+++ b/tools/testing/selftests/nolibc/configs/ppc.config
@@ -1,3 +1,6 @@
+CONFIG_COMPAT_32BIT_TIME=y
+CONFIG_PPC_PMAC=y
+CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
 CONFIG_SERIAL_PMACZILOG=y
 CONFIG_SERIAL_PMACZILOG_TTYS=y
 CONFIG_SERIAL_PMACZILOG_CONSOLE=y
diff --git a/tools/testing/selftests/nolibc/configs/ppc64.config b/tools/testing/selftests/nolibc/configs/ppc64.config
new file mode 100644
index 000000000000..4e17f0cdb99f
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/ppc64.config
@@ -0,0 +1,3 @@
+CONFIG_PPC64=y
+CONFIG_PPC_POWERNV=y
+CONFIG_HVC_OPAL=y
diff --git a/tools/testing/selftests/nolibc/configs/ppc64le.config b/tools/testing/selftests/nolibc/configs/ppc64le.config
new file mode 100644
index 000000000000..713b227f506f
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/ppc64le.config
@@ -0,0 +1,4 @@
+CONFIG_PPC64=y
+CONFIG_PPC_POWERNV=y
+CONFIG_HVC_OPAL=y
+CONFIG_CPU_LITTLE_ENDIAN=y
-- 
2.25.1

