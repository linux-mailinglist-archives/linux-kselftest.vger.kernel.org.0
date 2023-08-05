Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E777118D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHESqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHESqU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:46:20 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533A1BE4;
        Sat,  5 Aug 2023 11:46:15 -0700 (PDT)
X-QQ-mid: bizesmtp74t1691261166tr51mwlx
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:46:04 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: +bXiSo2NuBc72kCN4qQlj4Lqddv9gwYnm8KLDRKgB14qter2jdJhaXimrmWeM
        D52Gx8aygUqGks7WCB4egYTk1EGgdkEO4Mcwot44W9Y1Q5PwQDzn/l3o57xypA2QSzQWQu0
        DnzqJnukzzvI8wlNJRM0jRPfJe0mWtRftQSA/HyBAaeRbWRkI3IPKW+M5xzHwJNw5iqVaZm
        b/20AAOOucrtZI9C3sFm+h4XTl+69Z8g7H83NEc29mgajdCYmDy6M52xcVVR+r7HnZnIqDg
        YrQ4R+/JYYUcRGAj/PPPw/j9whd6kALZXTQqEXji6V6l+THjFC+8sFgdOaMum5HNx+d9nC5
        a8RBztzXYf3FvbezqbF5bH6jxV0m64GqVZ3NjvXYVBl0onb/QMkQ/UMYY040Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10931000458716054793
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: [PATCH v6 7/8] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Sun,  6 Aug 2023 02:46:03 +0800
Message-Id: <8f21df212f07a43d7534dedfd2beb4c8a2e05308.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691259983.git.falcon@tinylab.org>
References: <cover.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some cross compilers may not just be prefixed with ARCH, customize them
by architecture may simplify the test a lot, especially, when iterate
with ARCH.

After customizing this for every architecture, the minimal test argument
will be architecture itself, no CROSS_COMPILE required to be passed.

If the prefix of installed cross compiler is not the same as the one
customized, we can also pass CROSS_COMPILE as before or even pass
CROSS_COMPILE_<ARCH>.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 452d8e424d28..45d231b9c5c2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -55,6 +55,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
+# CROSS_COMPILE: cross toolchain prefix by architecture
+CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
+
+# make sure CC is prefixed with CROSS_COMPILE
+$(call allow-override,CC,$(CROSS_COMPILE)gcc)
+
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386       = defconfig
 DEFCONFIG_x86_64     = defconfig
-- 
2.25.1

