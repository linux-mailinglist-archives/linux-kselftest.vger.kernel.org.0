Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1D57A93B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiGSVqM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbiGSVp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F16211177;
        Tue, 19 Jul 2022 14:45:43 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj6Kn002595;
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
Subject: [PATCH 14/17] selftests/nolibc: add a "defconfig" target
Date:   Tue, 19 Jul 2022 23:44:46 +0200
Message-Id: <20220719214449.2520-16-w@1wt.eu>
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

While most archs will work fine with "make defconfig", not all will
do, and it's not always easy to remember the most suitable choice to
use for a specific architecture.

This adds a "defconfig" target to the Makefile so that one may easily
run "make -C ... defconfig" and make sure to clean and rebuild a fresh
config. This is *not* used by default because we want to preserve the
user's config by default.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4a2ab0e73ce2..c104719eae8b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -22,6 +22,15 @@ IMAGE_riscv   = arch/riscv/boot/Image
 IMAGE         = $(IMAGE_$(ARCH))
 IMAGE_NAME    = $(notdir $(IMAGE))
 
+# default kernel configurations that appear to be usable
+DEFCONFIG_i386    = defconfig
+DEFCONFIG_x86     = defconfig
+DEFCONFIG_arm64   = defconfig
+DEFCONFIG_arm     = multi_v7_defconfig
+DEFCONFIG_mips    = malta_defconfig
+DEFCONFIG_riscv   = defconfig
+DEFCONFIG         = $(DEFCONFIG_$(ARCH))
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -46,6 +55,9 @@ initramfs: nolibc-test
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
+defconfig:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
-- 
2.17.5

