Return-Path: <linux-kselftest+bounces-3298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA00835E74
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 10:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B98B288C22
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B066139AF1;
	Mon, 22 Jan 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFGBX0Od"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035639AE3;
	Mon, 22 Jan 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916720; cv=none; b=aqEDBIAqemISEtAEBOkHhsmnunC0JfJKWX+qTsTXwvMnopCuqG5iPyYzJkYE5vmQsZdFRClAbnjKayFBBk5uPnBGIHC4QTjAGWnIOl4/oKcALyVxvzbQr5Kq9LnXIUO/ktqjwFR55H9eR0gXEuW7UtY2UowJNATnVwXCcsRZABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916720; c=relaxed/simple;
	bh=lqenUsxnlYiKlH3WvazTEAbGzWcHa9q1eM9R45SW/XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxq0OzAoC/z0nhcDotR1v29d44v5otaSp6kxMPN94X0/QqUs35gXuZzHcMVVu/Vde08ORSqNLF22LfMg1UMQPXIGUBu0VrZRHPMSzc0Bc4S0yHR4cZixj9wLwSnLgjNBN7d7i/rpQLMWmZu4lZ+//F7sk1rI6liYskyDWb0yxyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFGBX0Od; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705916719; x=1737452719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lqenUsxnlYiKlH3WvazTEAbGzWcHa9q1eM9R45SW/XE=;
  b=iFGBX0OdPIqTSq0EcEbtH7HbytxjYOjvVRCA727rFtMzge9DyUVosYY/
   BSj318BtwRcYH1XzeLpUAuO/KN4U/hAyTsxniCyhtwFSR+BI8537SOpBy
   MPtVXpa6u+lEYS/ecsz6Xg/fdePWZrFghBRRi/WCGII26VoTQ81zbf8mn
   AcIsV7I65hBecI2IDUjyKuitMawnbf4utI86a7tQuPLUDuI93CeE0tbLq
   nLQOlybfJnUjM0GSJVMjX4rRq8hq3ZEZAAS9USglzQz7ieXBVCmUQDC86
   QBkodO0RNuWUf3gehDpclfB7I23xfnMedDBFJ+J/Up87kpjBqx+2mhtZ+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22641522"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22641522"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778535272"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778535272"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 01:45:07 -0800
From: Haibo Xu <haibo1.xu@intel.com>
To: 
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	wchen <waylingii@gmail.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Minda Chen <minda.chen@starfivetech.com>,
	Samuel Holland <samuel@sholland.org>,
	Sean Christopherson <seanjc@google.com>,
	Like Xu <likexu@tencent.com>,
	Peter Xu <peterx@redhat.com>,
	Vipin Sharma <vipinsh@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Thomas Huth <thuth@redhat.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org
Subject: [PATCH v5 01/12] selftests/kvm: Fix issues with $(SPLIT_TESTS)
Date: Mon, 22 Jan 2024 17:58:31 +0800
Message-Id: <d59687d00c7d0554cad903b14e8a9805a6384fac.1705916069.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705916069.git.haibo1.xu@intel.com>
References: <cover.1705916069.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Bonzini <pbonzini@redhat.com>

The introduction of $(SPLIT_TESTS) also introduced a warning when
building selftests on architectures that include get-reg-lists:

    make: Entering directory '/root/kvm/tools/testing/selftests/kvm'
    Makefile:272: warning: overriding recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
    Makefile:267: warning: ignoring old recipe for target '/root/kvm/tools/testing/selftests/kvm/get-reg-list'
    make: Leaving directory '/root/kvm/tools/testing/selftests/kvm'

In addition, the rule for $(SPLIT_TESTS_TARGETS) includes _all_
the $(SPLIT_TESTS_OBJS), which only works because there is just one.
So fix both by adjusting the rules:

- remove $(SPLIT_TESTS_TARGETS) from the $(TEST_GEN_PROGS) rules,
  and rename it to $(SPLIT_TEST_GEN_PROGS)

- fix $(SPLIT_TESTS_OBJS) so that it plays well with $(OUTPUT),
  rename it to $(SPLIT_TEST_GEN_OBJ), and list the object file
  explicitly in the $(SPLIT_TEST_GEN_PROGS) link rule

Fixes: 17da79e009c3 ("KVM: arm64: selftests: Split get-reg-list test code", 2023-08-09)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3e0c36b8ddd5..c5e9abb185b6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -257,32 +257,36 @@ LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
 LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
-SPLIT_TESTS_TARGETS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
-SPLIT_TESTS_OBJS := $(patsubst %, $(ARCH_DIR)/%.o, $(SPLIT_TESTS))
+SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
+SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH_DIR)/%.o, $(SPLIT_TESTS))
 
 TEST_GEN_OBJ = $(patsubst %, %.o, $(TEST_GEN_PROGS))
 TEST_GEN_OBJ += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
 TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_OBJ))
 TEST_DEP_FILES += $(patsubst %.o, %.d, $(LIBKVM_OBJS))
-TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TESTS_OBJS))
+TEST_DEP_FILES += $(patsubst %.o, %.d, $(SPLIT_TEST_GEN_OBJ))
 -include $(TEST_DEP_FILES)
 
-$(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): %: %.o
+x := $(shell mkdir -p $(sort $(OUTPUT)/$(ARCH_DIR) $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
+
+$(filter-out $(SPLIT_TEST_GEN_PROGS), $(TEST_GEN_PROGS)) \
+$(TEST_GEN_PROGS_EXTENDED): %: %.o
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBKVM_OBJS) $(LDLIBS) -o $@
 $(TEST_GEN_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
-$(SPLIT_TESTS_TARGETS): %: %.o $(SPLIT_TESTS_OBJS)
+$(SPLIT_TEST_GEN_PROGS): $(OUTPUT)/%: $(OUTPUT)/%.o $(OUTPUT)/$(ARCH_DIR)/%.o
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
+$(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH_DIR)/%.o: $(ARCH_DIR)/%.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
 EXTRA_CLEAN += $(GEN_HDRS) \
 	       $(LIBKVM_OBJS) \
-	       $(SPLIT_TESTS_OBJS) \
+	       $(SPLIT_TEST_GEN_OBJ) \
 	       $(TEST_DEP_FILES) \
 	       $(TEST_GEN_OBJ) \
 	       cscope.*
 
-x := $(shell mkdir -p $(sort $(dir $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ))))
 $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
@@ -296,7 +300,7 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
 
 x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
-$(SPLIT_TESTS_OBJS): $(GEN_HDRS)
+$(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
 $(TEST_GEN_OBJ): $(GEN_HDRS)
-- 
2.34.1


