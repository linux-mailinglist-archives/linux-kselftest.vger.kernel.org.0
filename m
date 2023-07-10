Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16174D870
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jul 2023 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGJOFM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jul 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjGJOEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jul 2023 10:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F50DF;
        Mon, 10 Jul 2023 07:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39A4F60FF1;
        Mon, 10 Jul 2023 14:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E5C433AD;
        Mon, 10 Jul 2023 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688997884;
        bh=hs7GwSl+FqTSStPohNdswNUI8t4j3YJj1gez6OZzqvg=;
        h=From:Date:Subject:To:Cc:From;
        b=b5cGIfFl/KbEHaUGRTPKlqxzASkdEX80F8pwuoDRh9aQ4ZCsN0wW3PXANw4xa7fH9
         brPiw66cOr+o9ON+tZkLFwtpsfYiR95OSBdBh9RpvrgTj9wsexU6LIceUihFfnDWjg
         Sz8is7qVczK9+W8njIsLNKPuqa1Pos6oyAgABi1yMA3Ui1XqRPE64oyo8yymOd6coi
         2R/QlQLRaYZXPZpQPlL5V91RG8elNaz9s4gdpyuTCRpl+fLdgbvr0OeIhskF9BV1y2
         OqiHEilsrS6G7AUaA9pX64XadZgkv5W4On8d0oY/PTzhJtDh/u5xv7yVKbNC6i6nQB
         sKSyoFBRJDOwA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 10 Jul 2023 15:04:21 +0100
Subject: [PATCH] selftests: Fix arm64 test installation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOUPrGQC/x2M2wpAUBAAf0X7bGsPOkd+RR7EYnPtrKTk320ep
 2nmAeUorFAlD0S+RGXfDFyaQDe128govTFklOUUHOGsvAwn64mD3NjG1RfYmXSeyJV9ACuPyCb
 /a9287wf1qf41ZQAAAA==
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hs7GwSl+FqTSStPohNdswNUI8t4j3YJj1gez6OZzqvg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrA/5NstbPEeg2o7L6IbsIwzqJdqzohj2rbJ/ke+V
 B4IkzJSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZKwP+QAKCRAk1otyXVSH0CXXB/
 4/bgJuTOwONho4qmgKAB4/VJ/iudGX+X0AXuR0lb063MN0jOaC/NZwkeO6kGnIb4DQTd1PreN+c2aQ
 JgQuflSQ977mS0B8kb0yPmb3E0R2/gl/tpSNjQ0+U2e8d9jqguk1v28/kLzHx+WNCs9zK0QN9iM8CX
 jlRRK43f4gbHN4FdvSYhukjORh+0Y7S5mfESNZbNWJB/JO2UngBXBJH3K6yjF/RytQdWZlJXozgslP
 xqjfApZs2SDI/T20n5H1NqH45eR5222IDbza+nIjBI0ZnA4CPIel3ukpA9fwxWBeJ2RT0EjHBVOVDK
 QykBMIoiI3n7hn4rmIAdfEbvJkglBF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The recent change fc96c7c19df ("selftests: error out if kernel header
files are not yet built") to generate an error message when building
kselftests without having installed the headers is generating spurious
failures during the install step which breaks the arm64 selftests (and
only the arm64 selftests):

Emit Tests for arm64
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[5]: *** [../../lib.mk:81: kernel_header_files] Error 1
make[4]: *** [Makefile:26: all] Error 2

Presumably the arm64 tests are doing something unusual in their build
setup which could be adjusted but I didn't immediately see it and since
this is having a serious impact on test coverage in automation let's
just revert for now.

This is causing failures in KernelCI with the command:

   make KBUILD_BUILD_USER=KernelCI FORMAT=.xz ARCH=arm64 HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- CC="ccache aarch64-linux-gnu-gcc" O=/tmp/kci/linux/build -C/tmp/kci/linux -j10 kselftest-gen_tar

and also when building using tuxmake.

Full log: https://storage.kernelci.org/mainline/master/v6.5-rc1/arm64/defconfig/gcc-10/logs/kselftest.log

Fixes: 9fc96c7c19df ("selftests: error out if kernel header files are not yet built")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/Makefile | 21 +--------------------
 tools/testing/selftests/lib.mk   | 40 +++-------------------------------------
 2 files changed, 4 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..405683b8cb39 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -146,12 +146,10 @@ ifneq ($(KBUILD_OUTPUT),)
   abs_objtree := $(realpath $(abs_objtree))
   BUILD := $(abs_objtree)/kselftest
   KHDR_INCLUDES := -isystem ${abs_objtree}/usr/include
-  KHDR_DIR := ${abs_objtree}/usr/include
 else
   BUILD := $(CURDIR)
   abs_srctree := $(shell cd $(top_srcdir) && pwd)
   KHDR_INCLUDES := -isystem ${abs_srctree}/usr/include
-  KHDR_DIR := ${abs_srctree}/usr/include
   DEFAULT_INSTALL_HDR_PATH := 1
 endif
 
@@ -165,7 +163,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-all: kernel_header_files
+all:
 	@ret=1;							\
 	for TARGET in $(TARGETS); do				\
 		BUILD_TARGET=$$BUILD/$$TARGET;			\
@@ -176,23 +174,6 @@ all: kernel_header_files
 		ret=$$((ret * $$?));				\
 	done; exit $$ret;
 
-kernel_header_files:
-	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                          \
-	if [ $$? -ne 0 ]; then                                                     \
-            RED='\033[1;31m';                                                  \
-            NOCOLOR='\033[0m';                                                 \
-            echo;                                                              \
-            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
-            echo "Please run this and try again:";                             \
-            echo;                                                              \
-            echo "    cd $(top_srcdir)";                                       \
-            echo "    make headers";                                           \
-            echo;                                                              \
-	    exit 1;                                                                \
-	fi
-
-.PHONY: kernel_header_files
-
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d17854285f2b..05400462c779 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -44,26 +44,10 @@ endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
 
-ifeq ("$(origin O)", "command line")
-  KBUILD_OUTPUT := $(O)
+ifeq ($(KHDR_INCLUDES),)
+KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
-ifneq ($(KBUILD_OUTPUT),)
-  # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
-  # expand a shell special character '~'. We use a somewhat tedious way here.
-  abs_objtree := $(shell cd $(top_srcdir) && mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
-  $(if $(abs_objtree),, \
-    $(error failed to create output directory "$(KBUILD_OUTPUT)"))
-  # $(realpath ...) resolves symlinks
-  abs_objtree := $(realpath $(abs_objtree))
-  KHDR_DIR := ${abs_objtree}/usr/include
-else
-  abs_srctree := $(shell cd $(top_srcdir) && pwd)
-  KHDR_DIR := ${abs_srctree}/usr/include
-endif
-
-KHDR_INCLUDES := -isystem $(KHDR_DIR)
-
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
 # custom build rule and prevent common build rule use.
@@ -74,25 +58,7 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
-all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
-     $(TEST_GEN_FILES)
-
-kernel_header_files:
-	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
-	if [ $$? -ne 0 ]; then                                                 \
-            RED='\033[1;31m';                                                  \
-            NOCOLOR='\033[0m';                                                 \
-            echo;                                                              \
-            echo -e "$${RED}error$${NOCOLOR}: missing kernel header files.";   \
-            echo "Please run this and try again:";                             \
-            echo;                                                              \
-            echo "    cd $(top_srcdir)";                                       \
-            echo "    make headers";                                           \
-            echo;                                                              \
-	    exit 1; \
-	fi
-
-.PHONY: kernel_header_files
+all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230710-kselftest-fix-arm64-c023160018d7

Best regards,
-- 
Mark Brown <broonie@kernel.org>

