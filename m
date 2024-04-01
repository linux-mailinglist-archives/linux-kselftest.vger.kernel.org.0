Return-Path: <linux-kselftest+bounces-6935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C888938CB
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC561F21549
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4673BA3F;
	Mon,  1 Apr 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgJSwzBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1E1113;
	Mon,  1 Apr 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958804; cv=none; b=k2WBj6LH/QnrDp3/CzBuuekMkSQ7j1kykM50N4eGqBWyFYO+eGDHhHol/bWlNpc49giejZR5Ea5X17BvMXBTCmkIck+vGsFAR8eymvXMA6Hht4oP+x3UHx/WNIbtCZI0S/N+cCkvkUiwK7J5sKHUZMg27rmvgnrDlKxwScW4Xn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958804; c=relaxed/simple;
	bh=HXl89clGCBmFMUQwsMNffueQqIafNclJQm4lGSgRHks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tv6pIxwmVa5UBGu8tTsbK2wJ+GhqgRLHxlp0/LyU4DikR3HxMUe0h4q1wzuxP5i+Xd7LFLmEqjvzBOsJAyLdk59Ywu7CY/eieXGDFQJFP8TPJuW40cZw4mWlF61DdCg5NMbRuBVKD0FkXWoe9GXcR8NCP1a9g90MB6qZE8MeYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgJSwzBp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711958802; x=1743494802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HXl89clGCBmFMUQwsMNffueQqIafNclJQm4lGSgRHks=;
  b=TgJSwzBpY2KickNloCs9wrum5AU8mJqML4Td/YX3Ci4WFN6QPlknFYtc
   ULk5qFKX0vECHUAKO9aupp3wQdCvWczKymLlOW0OlkNBiFhud4zDkcTYx
   MRX7BuJ5WAv7iJJpfCeb0kAWgz8pw8xcrKWLstxxEajmxAtbcYyBkQ5kC
   mreOyg0x8eFp5xb3bNqRj/OaEU5o7YAMsHCiF028b/74pFNYw1LTgtN8C
   rcrJmuOD6Ech2YtnkayF0vfcBZEvqKSmSjQ5xzFLVjXjnMhINl3BdRMSS
   HBm440HrXqp4nSxuxfjLWCFv/FHLWvBtL9H0RLmb9FFM3zl5s4sxm8Uqq
   g==;
X-CSE-ConnectionGUID: BdqdgPRSSzCjaCdGZfu8bw==
X-CSE-MsgGUID: Ji9+nn1KSzCXQNz5FGoexg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="29553376"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="29553376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 01:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="22386789"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orviesa004.jf.intel.com with ESMTP; 01 Apr 2024 01:06:37 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: ajones@ventanamicro.com
Cc: xiaobo55x@gmail.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] KVM: riscv: selftests: Add SBI base extension test
Date: Mon,  1 Apr 2024 16:20:18 +0800
Message-Id: <20240401082019.2318193-1-haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first patch to enable the base extension selftest
for the SBI implementation in KVM. Test for other extensions
will be added later.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/riscv/processor.h   |  8 +-
 tools/testing/selftests/kvm/riscv/sbi_test.c  | 95 +++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/riscv/sbi_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 741c7dc16afc..a6acbbcad757 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -189,6 +189,7 @@ TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
+TEST_GEN_PROGS_riscv += riscv/sbi_test
 TEST_GEN_PROGS_riscv += arch_timer
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index ce473fe251dd..df530ac751c4 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -178,7 +178,13 @@ enum sbi_ext_id {
 };
 
 enum sbi_ext_base_fid {
-	SBI_EXT_BASE_PROBE_EXT = 3,
+	SBI_EXT_BASE_GET_SPEC_VERSION = 0,
+	SBI_EXT_BASE_GET_IMP_ID,
+	SBI_EXT_BASE_GET_IMP_VERSION,
+	SBI_EXT_BASE_PROBE_EXT,
+	SBI_EXT_BASE_GET_MVENDORID,
+	SBI_EXT_BASE_GET_MARCHID,
+	SBI_EXT_BASE_GET_MIMPID,
 };
 
 struct sbiret {
diff --git a/tools/testing/selftests/kvm/riscv/sbi_test.c b/tools/testing/selftests/kvm/riscv/sbi_test.c
new file mode 100644
index 000000000000..b9378546e3b6
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/sbi_test.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sbi_test - SBI API test for KVM's SBI implementation.
+ *
+ * Copyright (c) 2024 Intel Corporation
+ *
+ * Test cover the following SBI extentions:
+ *  - Base: All functions in this extension should be supported
+ */
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+/*
+ * Test that all functions in the base extension must be supported
+ */
+static void base_ext_guest_code(void)
+{
+	struct sbiret ret;
+
+	/*
+	 * Since the base extension was introduced in SBI Spec v0.2,
+	 * assert if the implemented SBI version is below 0.2.
+	 */
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_SPEC_VERSION, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error && ret.value >= 2, "Get Spec Version Error: ret.error=%ld, "
+			"ret.value=%ld\n", ret.error, ret.value);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_ID, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error && ret.value == 3, "Get Imp ID Error: ret.error=%ld, "
+			"ret.value=%ld\n",
+			ret.error, ret.value);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_IMP_VERSION, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error, "Get Imp Version Error: ret.error=%ld\n", ret.error);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, SBI_EXT_BASE,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error && ret.value == 1, "Probe ext Error: ret.error=%ld, "
+			"ret.value=%ld\n",
+			ret.error, ret.value);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MVENDORID, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error, "Get Machine Vendor ID Error: ret.error=%ld\n", ret.error);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MARCHID, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error, "Get Machine Arch ID Error: ret.error=%ld\n", ret.error);
+
+	ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_GET_MIMPID, 0,
+			0, 0, 0, 0, 0);
+	__GUEST_ASSERT(!ret.error, "Get Machine Imp ID Error: ret.error=%ld\n", ret.error);
+
+	GUEST_DONE();
+}
+
+static void sbi_base_ext_test(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, base_ext_guest_code);
+	while (1) {
+		vcpu_run(vcpu);
+		TEST_ASSERT(vcpu->run->exit_reason == UCALL_EXIT_REASON,
+			    "Unexpected exit reason: %u (%s),",
+			    vcpu->run->exit_reason, exit_reason_str(vcpu->run->exit_reason));
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			fprintf(stderr, "Guest assert failed!\n");
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	sbi_base_ext_test();
+
+	return 0;
+}
-- 
2.34.1


