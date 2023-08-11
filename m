Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D815779898
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 22:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjHKUbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjHKUbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 16:31:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCE1AE;
        Fri, 11 Aug 2023 13:31:40 -0700 (PDT)
X-QQ-mid: bizesmtp67t1691785895tgum3qxa
Received: from linux-lab-host.localdomain ( [116.30.128.116])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 12 Aug 2023 04:31:34 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: lO87fmWkX3EYb0Z7DGgry/wBfLkTIiP63iqaOMGbl7n0jyIq9h0d3cq/ertgc
        MeIquG7TCOysshgbb7okgSY+I4eDb/L3IAFJfDNtB4nw+Sd4msegnZ52pFUcuEl26bSjI/k
        qO7LEfawsjRxaUHQsyEqK3tiDLQtQkb0/ITp7Hal1qOplMe+8blEjU0ba4cHzl9pI8XnIJN
        VYWTwBBDJ8UqZ1cHPJXYxB/+VJDc+r5wGpTHYeewjLk+weEJK+CY9TcKQp90AKIOrxxTcOo
        XM8oj3KBvlLdSv9b+9GcBL3i8saH5/eWxO6l67GXIkugSvVPTLDKpiy8AlbVZr8UqaOQovz
        syhlvGLM+GetFKNUyPVX+N/12H2wOPvpt7T5hZA39S055CVQii1oNoEop91X5G16hPmgCzG
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18124793566430197416
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org, w@1wt.eu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH v2 4/7] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Sat, 12 Aug 2023 04:31:33 +0800
Message-Id: <3526b34a6ba674c978015a0e3a106e47dd524930.1691783604.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691783604.git.falcon@tinylab.org>
References: <cover.1691783604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some cross compilers are not just prefixed with XARCH, customize them by
architecture may simplify the test a lot, especially, when iterate with
XARCH.

After customizing this for every architecture or its variant, the
minimal test argument will be architecture or variant itself, no
CROSS_COMPILE required to be passed.

If the prefix of installed cross compiler is not the same as the one
customized, we can also pass CROSS_COMPILE as before or even pass
CROSS_COMPILE_$(XARCH) and CC from command line.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 91ccfc27780f..5aff60d31d72 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
-include ../../../scripts/Makefile.include
 # We need this for the "cc-option" macro.
 include ../../../build/Build.include
 
@@ -55,6 +54,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
+# CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
+
+# Make CC is always prefixed with $(CROSS_COMPILE)
+include ../../../scripts/Makefile.include
+
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386       = defconfig
 DEFCONFIG_x86_64     = defconfig
-- 
2.25.1

