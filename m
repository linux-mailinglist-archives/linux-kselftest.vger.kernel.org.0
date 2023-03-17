Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154E6BE5B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 10:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCQJfY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQJfX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 05:35:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C75DCF44;
        Fri, 17 Mar 2023 02:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679045722; x=1710581722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qgmcHKskhHCJITYAWgk1kE+Wq/nXM6omsyrWE8kleY=;
  b=GfnFEsdQoTCwFxuY/Hy822d89lxMk8zO9g+IJNFVfS4nt0vT6iLSXFM2
   3uxMlYcGnVoxCtRSzBhU3m2Drkx+eYmFOlubP/0rOMSPgvyroRLfZJJc3
   /GqJGqk1e5CXcdeQBHW5yC3oiqKc7RXKqNs/5Fwgyi4oOGFy68LPI0v9v
   LK8BsbT2moag3yX0v/Sp0j+Uc7+sffOq+mmQyWiJfWoL9fY47ZIz8m2ez
   KzU2BXC6hjwM8+0uW/toP0h/dBX4rRDkzCMJj0tYDhzfGPikRKN4+QA/T
   BAtEyjOIGNpd+pBz7/IK+TDfCoEpI4+bSdO3XkFxIotdDN0UKbz/daFWt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400802155"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400802155"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 02:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="657502661"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="657502661"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2023 02:35:19 -0700
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com,
        kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: selftests: Add new CFLAGS to generate dependency files
Date:   Fri, 17 Mar 2023 16:43:00 +0800
Message-Id: <20230317084300.1375487-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
v2: Use "-MD" in CFLAGS instead of "EXTRA_CFLAGS". [Sean]
---
 tools/testing/selftests/kvm/Makefile | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 84a627c43795..105f5fca5548 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -181,6 +181,8 @@ TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))
 
+OVERRIDE_TARGETS = 1
+
 # lib.mak defines $(OUTPUT), prepends $(OUTPUT)/ to $(TEST_GEN_PROGS), and most
 # importantly defines, i.e. overwrites, $(CC) (unless `make -e` or `make CC=`,
 # which causes the environment variable to override the makefile).
@@ -195,7 +197,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
-	-Wno-gnu-variable-sized-type-not-at-end \
+	-Wno-gnu-variable-sized-type-not-at-end -MD\
 	-fno-builtin-memcmp -fno-builtin-memcpy -fno-builtin-memset \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
@@ -222,7 +224,18 @@ LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
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
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
+EXTRA_CLEAN += $(LIBKVM_OBJS) $(TEST_DEP_FILES) $(TEST_GEN_OBJ) cscope.*
 
 x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c

base-commit: d8708b80fa0e6e21bc0c9e7276ad0bccef73b6e7
-- 
2.25.1

