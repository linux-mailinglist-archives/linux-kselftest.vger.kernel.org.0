Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3957A940
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240526AbiGSVq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiGSVqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:46:02 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 055F2DF35;
        Tue, 19 Jul 2022 14:45:50 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj6im002598;
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
Subject: [PATCH 17/17] selftests/nolibc: add a "help" target
Date:   Tue, 19 Jul 2022 23:44:49 +0200
Message-Id: <20220719214449.2520-19-w@1wt.eu>
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

It presents the supported targets, and becomes the default target to
save the user from having to read the makefile. The "all" target was
placed after it and now points to "run" to do everything since it's
no longer the default one.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile | 27 ++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 210f5369fdfc..69ea659caca9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -65,7 +65,32 @@ endif
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables
 LDFLAGS := -s
 
-all: nolibc-test
+help:
+	@echo "Supported targets under selftests/nolibc:"
+	@echo "  all          call the \"run\" target below"
+	@echo "  help         this help"
+	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  initramfs    prepare the initramfs with nolibc-test"
+	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
+	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
+	@echo "  run          runs the kernel in QEMU after building it (uses \$$ARCH, \$$TEST)"
+	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$ARCH, \$$TEST)"
+	@echo "  clean        clean the sysroot, initramfs, build and output files"
+	@echo ""
+	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
+	@echo ""
+	@echo "Currently using the following variables:"
+	@echo "  ARCH          = $(ARCH)"
+	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
+	@echo "  CC            = $(CC)"
+	@echo "  OUTPUT        = $(OUTPUT)"
+	@echo "  TEST          = $(TEST)"
+	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$ARCH]"
+	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$ARCH]"
+	@echo ""
+
+all: run
 
 sysroot: sysroot/$(ARCH)/include
 
-- 
2.17.5

