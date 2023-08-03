Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E050F76E75C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 13:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjHCLvH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCLvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 07:51:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE72D54;
        Thu,  3 Aug 2023 04:50:59 -0700 (PDT)
X-QQ-mid: bizesmtp75t1691063449tqmo2qcn
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 19:50:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: mRz6/7wsmIj3dfIjjNVLcgKGmUWx0z0rhG3IvarZHhF2M7vaSx63g6eOTeTaZ
        uHBgDLGmUrfQEdz7oHgfhMEwAOJCN6zBQMELEfoCfQ8msY6ksEOYpkzJEfVXqdH3o6kK1XT
        YZP/mn27FGUkoliO7GuSlhGZsJwdzwgTqCvxVGB2FdzsXiPESZqCT3m02NuvDTmw21pX11A
        C3LVEaiUynRo+baIxth+sDuzdG6Vi2sMehODujYsHsFOZ4hSSudBJ7naq5vzeugs9Tkw6ny
        Qad89TXcK5NDGUXxL2zsY3mW60k0dHThvcM9wMjuT820x8NdOZavjbPiR0aI0+alO+aLLLR
        +7EFmGWVBzpxCdGpYA7P+mmkfsSt1t8D75zBfWkL59u6EQIC3pvrDWUbB0//k2qLOQG0TNr
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10404998446730890993
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org
Subject: [PATCH v5 7/8] selftests/nolibc: allow customize CROSS_COMPILE by architecture
Date:   Thu,  3 Aug 2023 19:50:48 +0800
Message-Id: <8d7f208be1b85528114ead3b63aeb954371a996e.1691062722.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691062722.git.falcon@tinylab.org>
References: <cover.1691062722.git.falcon@tinylab.org>
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
index ec290cd82e21..6e34d364a177 100644
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

