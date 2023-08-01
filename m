Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B1776BDFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHATnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHATnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:43:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2F5B4;
        Tue,  1 Aug 2023 12:43:47 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690919018teg55b9x
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:43:36 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi2xncCjfYqLvJjjsbmRl6823fPDREAyxCfDLSYkITqMOhNFYQoTq
        fivLI5x5TaCGmPT/OKdI79+yUj/BuxvA81Sdh8jMTIBfzX33G8EXZBxNLzldQkmaunbFXhb
        2L4G45fpUSVcUWoTtL3GH4uEdr/tr/25txzbX8dYoTsQeYfMCxbmvQm5s3jyFSFMWvhgauJ
        hM76g5fiRw+WiGJbh2uN12XBTiXUjLY6PYQqtzXDszvM87qr67HPKvHxbvWgNIImRDsZdO2
        VpUuzBlQkSTDF6XWH7WfGvVRko/YrkRNdWSTokLRhhDWCplQeThc78G5BFgQcgV0tUEPLg9
        TGcpqsRA6KWERb8Qg9gxan+4pFA3stL8pZC/N+g5X3n6juuX/LqiaARi7QhiA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13231898566651143164
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 07/12] selftests/nolibc: add help for nolibc-test-config target
Date:   Wed,  2 Aug 2023 03:43:36 +0800
Message-Id: <8302ff1aebab6906a9c26349db1f1fd178c92cb8.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
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

Both the nolibc-test-config target and the NOLIBC_TEST_CONFIG marco are
listed in the help output.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 42 +++++++++++++------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f01b258ef19b..3c9e3963fbad 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -119,30 +119,32 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
-	@echo "  all          call the \"run\" target below"
-	@echo "  help         this help"
-	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
-	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
-	@echo "  libc-test    build an executable using the compiler's default libc instead"
-	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  initramfs    prepare the initramfs with nolibc-test"
-	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
-	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
-	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
-	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  clean        clean the sysroot, initramfs, build and output files"
+	@echo "  all                    call the \"run\" target below"
+	@echo "  help                   this help"
+	@echo "  sysroot                create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test            build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  libc-test              build an executable using the compiler's default libc instead"
+	@echo "  run-user               runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  initramfs              prepare the initramfs with nolibc-test"
+	@echo "  nolibc-test-config     create a fresh new \$$(CONFIG) config with extra options from \$$NOLIBC_TEST_CONFIG files (uses \$$XARCH)"
+	@echo "  defconfig              do nolibc-test-config with default config (uses \$$XARCH)"
+	@echo "  kernel                 (re)build the kernel with the initramfs (uses \$$XARCH)"
+	@echo "  run                    runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
+	@echo "  rerun                  runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  clean                  clean the sysroot, initramfs, build and output files"
 	@echo ""
 	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
 	@echo ""
 	@echo "Currently using the following variables:"
-	@echo "  ARCH          = $(ARCH)"
-	@echo "  XARCH         = $(XARCH)"
-	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
-	@echo "  CC            = $(CC)"
-	@echo "  OUTPUT        = $(OUTPUT)"
-	@echo "  TEST          = $(TEST)"
-	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$XARCH]"
-	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$XARCH]"
+	@echo "  ARCH                   = $(ARCH)"
+	@echo "  XARCH                  = $(XARCH)"
+	@echo "  CROSS_COMPILE          = $(CROSS_COMPILE)"
+	@echo "  CC                     = $(CC)"
+	@echo "  OUTPUT                 = $(OUTPUT)"
+	@echo "  TEST                   = $(TEST)"
+	@echo "  QEMU_ARCH              = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$XARCH]"
+	@echo "  IMAGE_NAME             = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$XARCH]"
+	@echo "  NOLIBC_TEST_CONFIG     = $(strip $(foreach c,$(NOLIBC_TEST_CONFIG),$(wildcard $(CURDIR)/configs/$c))) [determined from \$$XARCH]"
 	@echo ""
 
 all: run
-- 
2.25.1

