Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74535719625
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 10:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjFAI6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjFAI6a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 04:58:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56447132;
        Thu,  1 Jun 2023 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685609909; x=1717145909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lAcYtInKsopDQxJmwLovdpYraiB6bLABcfqZaZEP/bA=;
  b=hr0E/i/Carr7jpUivviGHY0neE+xZHcet2QuN1XNukBmT92nT/QkvFVi
   dlRRyrf7iqm4wYed0vJB+S191FHgMPQZJwAlpq5i3hOyYAUXc2VSWNb/1
   mLA53OybmI8tkw1f0AMzQSpYRN72yxpjQ5jr0EKeOm7pTk8feh7b6MhHY
   kKwk4fUZYGZFMy0W/udbLqBFC3rgsWXImnlBL93iu4OszNM67hij2MfvZ
   uyKyNOgyzZKQo/4M+Bu9cgZ82CvaKlYbf5uSaT4DueKa9jEGs4MecJFVk
   XdVoaqQqlntI+T9aqVwwWKjwX0pvLUnMHHZbk1RLwzXtdLu0JbThJlQGI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="354354439"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="354354439"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 01:58:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="710411048"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; 
   d="scan'208";a="710411048"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jun 2023 01:58:25 -0700
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     seanjc@google.com, pbonzini@redhat.com, shuah@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] KVM: selftests: Add new CFLAGS to generate dependency files
Date:   Thu,  1 Jun 2023 16:03:38 +0800
Message-Id: <20230601080338.212942-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add "-MD" in CFLAGS to generate dependency files. Currently, each
time a header file is updated in KVM selftest, we will have to run
"make clean && make" to rebuild the whole test suite. By adding new
compiling flags and dependent rules in Makefile, we do not need to
make clean && make each time a header file is updated.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
v3: Strip the $(OUTPUT) prefix from source files to fix the build
    failure reported by kernel test robot <lkp@intel.com> in
    https://lore.kernel.org/oe-kbuild-all/202305302015.D8PglEU7-lkp@intel.com/

v2: Use "-MD" in CFLAGS instead of "EXTRA_CFLAGS". [Sean]
---

 tools/testing/selftests/kvm/Makefile | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 7a5ff646e7e7..dd16969aaf6c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -183,6 +183,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))
 
+OVERRIDE_TARGETS = 1
+
 # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
@@ -197,7 +199,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
-	-Wno-gnu-variable-sized-type-not-at-end \
+	-Wno-gnu-variable-sized-type-not-at-end -MD\
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
@@ -224,7 +226,18 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
 
-EXTRA_CLEAN += $(LIBKVM_OBJS) cscope.*
+TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
+TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
+-include $(TEST_DEP_FILES)
+
+$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
+$(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c

base-commit: 56f413f2cd373d6ed7c4ecb2e0e3e740cc2fdc8c
-- 
2.25.1

