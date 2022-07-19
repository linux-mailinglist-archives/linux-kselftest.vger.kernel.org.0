Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFE57A951
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240598AbiGSVrs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiGSVrd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:47:33 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9F4613CED;
        Tue, 19 Jul 2022 14:47:10 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj6uf002594;
        Tue, 19 Jul 2022 23:45:06 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 13/17] selftests/nolibc: add a "kernel" target to build the kernel with the initramfs
Date:   Tue, 19 Jul 2022 23:44:45 +0200
Message-Id: <20220719214449.2520-15-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "kernel" target rebuilds the kernel with the current config for the
selected arch, with an initramfs containing the nolibc-test utility.

Since image names depend on the architecture, the currently supported
ones are referenced and resolved based on the architecture.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index fd0a67082334..4a2ab0e73ce2 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -12,6 +12,16 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# kernel image names by architecture
+IMAGE_i386    = arch/x86/boot/bzImage
+IMAGE_x86     = arch/x86/boot/bzImage
+IMAGE_arm64   = arch/arm64/boot/Image
+IMAGE_arm     = arch/arm/boot/zImage
+IMAGE_mips    = vmlinuz
+IMAGE_riscv   = arch/riscv/boot/Image
+IMAGE         = $(IMAGE_$(ARCH))
+IMAGE_NAME    = $(notdir $(IMAGE))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -36,6 +46,9 @@ initramfs: nolibc-test
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
+kernel: initramfs
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+
 clean:
 	$(call QUIET_CLEAN, nolibc-test)
 	$(Q)rm -f nolibc-test
-- 
2.17.5

