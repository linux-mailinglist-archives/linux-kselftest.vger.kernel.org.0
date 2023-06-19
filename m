Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22FA7356D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFSM2j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFSM2j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:28:39 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9648194;
        Mon, 19 Jun 2023 05:28:37 -0700 (PDT)
X-QQ-mid: bizesmtp81t1687177707tmneyvcl
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 20:28:26 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 5q30pvLz2ic279cw/a00XjnqZBNnxTgxLNGC6G7VMExOCnBfI7C0htyxxzWKY
        LA5v3ik8/oYs8zCaHGKjtZ/1V4+e1Iwh4i0Rpn+oiq9SYoh6jr/S99wvl/1vEr8p0R4z3ms
        lgaKQkeqhhNBuB42rTLW0FAGdmmwyykpGkXnchmNDkOAZZ2ilQ+0MpMlTmlCIa9kQYeOtlY
        BEZOrE68ogo7OmquvaAJweTQn7BQflcMhTRoZ62o4IY59iZqqBLjqz9z2aUByaD/FfITuvj
        6WkOZamXc1txAV3HCZJMNwX/kUVydRmuN1Ep+b7mcNTrFyElbsr7yRiHP3vb4XQ/d423peo
        hKWy5deLwn5KsqDutzogRy0HI4veS/4vusbw+UVoxz58OxqseAmqa5ffwrsFA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4499761798430525214
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v5 4/5] tools/nolibc: add kernel and nolibc specific ARCH variables
Date:   Mon, 19 Jun 2023 20:28:23 +0800
Message-Id: <be68f6023139b94152ae13f101caef8b4d671a3a.1687176996.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687176996.git.falcon@tinylab.org>
References: <cover.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Like the KARCH added for tools/testing/selftests/nolibc/Makefile, adds
KARCH for tools/include/nolibc/Makefile too, at the same time, adds
NARCH for the ARCH supported by nolibc (arch-<NARCH>.h).

It allows users to customize both kernel and nolibc specific ARCH
variables for different architectures and their variants easily.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 64d67b080744..14a6416fa57f 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -23,8 +23,14 @@ else
 Q=@
 endif
 
-nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
-arch_file := arch-$(nolibc_arch).h
+# kernel supported ARCH names by architecture
+KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
+
+# nolibc supported ARCH names by architecture
+NARCH_arm64      = aarch64
+NARCH            = $(or $(NARCH_$(ARCH)),$(ARCH))
+
+arch_file := arch-$(NARCH).h
 all_files := \
 		compiler.h \
 		ctype.h \
@@ -83,8 +89,8 @@ headers:
 	fi > $(OUTPUT)sysroot/include/arch.h
 
 headers_standalone: headers
-	$(Q)$(MAKE) -C $(srctree) headers
-	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) headers
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
 
 clean:
 	$(call QUIET_CLEAN, nolibc) rm -rf "$(OUTPUT)sysroot"
-- 
2.25.1

