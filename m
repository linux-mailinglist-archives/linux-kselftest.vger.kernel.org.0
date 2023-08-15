Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B477CE9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbjHOPAC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjHOO7i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 10:59:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD00798
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 07:59:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C677C1063;
        Tue, 15 Aug 2023 08:00:18 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7659E3F6C4;
        Tue, 15 Aug 2023 07:59:35 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] kselftest/arm64: build BTI tests in output directory
Date:   Tue, 15 Aug 2023 15:59:31 +0100
Message-Id: <20230815145931.2522557-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm64 BTI selftests are currently built in the source directory,
then the generated binaries are copied to the output directory.
This leaves the object files around in a potentially otherwise pristine
source tree, tainting it for out-of-tree kernel builds.

Prepend $(OUTPUT) to every reference to an object file in the Makefile,
and remove the extra handling and copying. This puts all generated files
under the output directory.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/bti/Makefile    | 45 +++++++++----------
 .../selftests/arm64/bti/gen/.gitignore        |  2 -
 2 files changed, 20 insertions(+), 27 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/bti/gen/.gitignore

diff --git a/tools/testing/selftests/arm64/bti/Makefile b/tools/testing/selftests/arm64/bti/Makefile
index ccdac414ad940..05e4ee523a534 100644
--- a/tools/testing/selftests/arm64/bti/Makefile
+++ b/tools/testing/selftests/arm64/bti/Makefile
@@ -2,8 +2,6 @@
 
 TEST_GEN_PROGS := btitest nobtitest
 
-PROGS := $(patsubst %,gen/%,$(TEST_GEN_PROGS))
-
 # These tests are built as freestanding binaries since otherwise BTI
 # support in ld.so is required which is not currently widespread; when
 # it is available it will still be useful to test this separately as the
@@ -18,44 +16,41 @@ CFLAGS_COMMON = -ffreestanding -Wall -Wextra $(CFLAGS)
 BTI_CC_COMMAND = $(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -c -o $@ $<
 NOBTI_CC_COMMAND = $(CC) $(CFLAGS_NOBTI) $(CFLAGS_COMMON) -c -o $@ $<
 
-%-bti.o: %.c
+$(OUTPUT)/%-bti.o: %.c
 	$(BTI_CC_COMMAND)
 
-%-bti.o: %.S
+$(OUTPUT)/%-bti.o: %.S
 	$(BTI_CC_COMMAND)
 
-%-nobti.o: %.c
+$(OUTPUT)/%-nobti.o: %.c
 	$(NOBTI_CC_COMMAND)
 
-%-nobti.o: %.S
+$(OUTPUT)/%-nobti.o: %.S
 	$(NOBTI_CC_COMMAND)
 
 BTI_OBJS =                                      \
-	test-bti.o                           \
-	signal-bti.o                            \
-	start-bti.o                             \
-	syscall-bti.o                           \
-	system-bti.o                            \
-	teststubs-bti.o                         \
-	trampoline-bti.o
-gen/btitest: $(BTI_OBJS)
+	$(OUTPUT)/test-bti.o                    \
+	$(OUTPUT)/signal-bti.o                  \
+	$(OUTPUT)/start-bti.o                   \
+	$(OUTPUT)/syscall-bti.o                 \
+	$(OUTPUT)/system-bti.o                  \
+	$(OUTPUT)/teststubs-bti.o               \
+	$(OUTPUT)/trampoline-bti.o
+$(OUTPUT)/btitest: $(BTI_OBJS)
 	$(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -nostdlib -static -o $@ $^
 
 NOBTI_OBJS =                                    \
-	test-nobti.o                         \
-	signal-nobti.o                          \
-	start-nobti.o                           \
-	syscall-nobti.o                         \
-	system-nobti.o                          \
-	teststubs-nobti.o                       \
-	trampoline-nobti.o
-gen/nobtitest: $(NOBTI_OBJS)
+	$(OUTPUT)/test-nobti.o                  \
+	$(OUTPUT)/signal-nobti.o                \
+	$(OUTPUT)/start-nobti.o                 \
+	$(OUTPUT)/syscall-nobti.o               \
+	$(OUTPUT)/system-nobti.o                \
+	$(OUTPUT)/teststubs-nobti.o             \
+	$(OUTPUT)/trampoline-nobti.o
+$(OUTPUT)/nobtitest: $(NOBTI_OBJS)
 	$(CC) $(CFLAGS_BTI) $(CFLAGS_COMMON) -nostdlib -static -o $@ $^
 
 # Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
 # to account for any OUTPUT target-dirs optionally provided by
 # the toplevel makefile
 include ../../lib.mk
-
-$(TEST_GEN_PROGS): $(PROGS)
-	cp $(PROGS) $(OUTPUT)/
diff --git a/tools/testing/selftests/arm64/bti/gen/.gitignore b/tools/testing/selftests/arm64/bti/gen/.gitignore
deleted file mode 100644
index 73869fabada42..0000000000000
--- a/tools/testing/selftests/arm64/bti/gen/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-btitest
-nobtitest
-- 
2.25.1

