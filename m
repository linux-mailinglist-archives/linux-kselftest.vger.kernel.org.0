Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F076ECFF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 16:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjHCOpV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 10:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjHCOpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 10:45:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F6272A;
        Thu,  3 Aug 2023 07:45:01 -0700 (PDT)
X-QQ-mid: bizesmtp68t1691073889t4khgjyo
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 22:44:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: IcCSTr/hHjOY6VEm71/IgqzXpvSKtnkkeAhaXGC6ywTF2cpGNkzcpdx/TKfBR
        hiT/uimJdY9bSUpyUuSaerHKZybT6bxkLtzpKWPzP4ooH8Q94U9UtiRcBQ3eFczhrRwN0sP
        b4pn/bUfnf6T2k4b4Fv80z+bDiHCUHDykgviC0pI3DKArvoIjWychyt0uvjPLtexRtVLQx5
        pU4R/Quxhus+VsmVZ6eOZH5iVH/ob+OX1ILvDCjEkeaYJWleLJOER+TqdX2+vAzvDLswN3O
        q8BOXHnGwEIhwM+sJs2a4ElA7H7t8fgMjeA19g2jg7owR+VT0XL665E/HiEvaKafzk9JWY+
        +/sXOyNDWMr9NK7kd0RcSvv4+qaaME1X7G1Y8NPx/JA2YLJAOgRmSVXABKMtA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16889210508808416794
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v1 1/3] selftests/nolibc: allow report with existing test log
Date:   Thu,  3 Aug 2023 22:44:47 +0800
Message-Id: <a2879d1ef44fd482a63a8d1a41527289ebcd501b.1691073180.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691073180.git.falcon@tinylab.org>
References: <cover.1691073180.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

After the tests finish, it is valuable to report and summarize with
existing test log.

This avoid rerun or run the tests again when not necessary.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 16cc33db54e3..51fef5e6a152 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -225,6 +225,10 @@ rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+# report with existing test log
+report:
+	$(Q)$(REPORT) $(CURDIR)/run.out
+
 clean:
 	$(call QUIET_CLEAN, sysroot)
 	$(Q)rm -rf sysroot
-- 
2.25.1

