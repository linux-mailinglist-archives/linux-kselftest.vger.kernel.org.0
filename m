Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82EA67E83F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 15:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjA0O13 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 09:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjA0O11 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 09:27:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E78000C;
        Fri, 27 Jan 2023 06:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674829633; x=1706365633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tQHYwsHuQmv3UmxqSGxgXFuhINcA80Abo3LA82di77s=;
  b=Y7pVM78jO0HE/dAFn2MC+n1QPcxTlf+t0PCaJgf3dKQnetze2zawxNAu
   q69c0J2MEFcOOMiANVxtmQN2YSFCzI/yfSYFrFoL7gih1s6pI1UX1Lqaz
   ebdR9lldf4LLky8ii0uGc63YhYJQVTcR9ws1tNEIry4m1eMLhDDqwUp5h
   Dn9yFRdfhdeLgVSXSJmR1xO7oCDOs3QbxeZ123IW4PXfOd7qfIuuTudvF
   iPudNFbwLbGMIXMiu/sYVEGsJEIRIYeTvL0d017HIw/NebZuJStEhhnyK
   d7tN/yT832fJekgxfUe0dhJ/ea4EwWLWoVmk9sHsrPdEmlplLDFYsFgyp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310716130"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310716130"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 06:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="731859354"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="731859354"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2023 06:27:10 -0800
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: selftest: Add dependency rules in makefile for C source code
Date:   Fri, 27 Jan 2023 21:36:01 +0800
Message-Id: <20230127133601.1165472-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, KVM selftests have to run "make clean && make" to rebuild the
entire test suite each time a header file is modified. Define "-MD" as
an EXTRA_CFLAGS, so we can generate the dependency rules for each target
object, whose prerequisites contains the source file and the included header
files as well. And including those dependency files in KVM selftests' makefile
will release us from such annoyance.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
---
 tools/testing/selftests/kvm/Makefile | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1750f91dd936..b329e0d1a460 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -180,6 +180,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))
 
+OVERRIDE_TARGETS = 1
+
 # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
@@ -198,9 +200,11 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
+	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. \
 	$(KHDR_INCLUDES)
 
+EXTRA_CFLAGS += -MD
+
 no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
         $(CC) -Werror $(CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
 
@@ -218,11 +222,22 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
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
+$(TEST_GEN_OBJ): %.o: %.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(EXTRA_CFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(EXTRA_CFLAGS) $(TARGET_ARCH) -c $< -o $@
 
 $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
-- 
2.25.1

