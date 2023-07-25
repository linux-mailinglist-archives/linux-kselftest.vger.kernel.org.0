Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA4760D50
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 10:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjGYIll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 04:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjGYIlG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 04:41:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04141BF9;
        Tue, 25 Jul 2023 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690274436; x=1721810436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2wO0q4ILsU3O3hi98H8TBrQbxNa7G+2qqW6h7tSE++c=;
  b=CFWm2ZXazV5tNPr9qhU3uUNkwQmrFAUAxBmZRUNcH2+0Ydsd6ysPSaWx
   9ep9XB9Ehnw2WM942DRiYK/J1FVI46YEM/Y5vN0Ykyt/fK1G+F6nSwWk4
   mpXe2BgQQZJ1imsg+EkTJKnmsmmYDY6fEvKbBTBwiYp7YC0laOGnA0fGb
   0lU6f02Pzf0w1yIhjJCTiWKPzRKwcosUGGbmxv3dMusRmxqdWMjCRV71Z
   fF5eU2R68x1NHeXqOtoHZ620DP137kCFlMUHEUEDkF520RZxWBFmA0Zlv
   V8KD8YwyI5qoIVh+QhXBNHzSVk94DeHsF+ljb7LESvQHQcoeWtMISiJT0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371265258"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="371265258"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761131404"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761131404"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:39:09 -0700
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        maz@kernel.org, oliver.upton@linux.dev, seanjc@google.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Shuah Khan <shuah@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ricardo Koller <ricarkol@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Colton Lewis <coltonlewis@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Subject: [PATCH v6 13/13] KVM: riscv: selftests: Add get-reg-list test
Date:   Tue, 25 Jul 2023 16:41:39 +0800
Message-Id: <9aff20f1f04f40949aeed9aa291e0e2a02a3eb5d.1690273969.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690273969.git.haibo1.xu@intel.com>
References: <cover.1690273969.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

get-reg-list test is used to check for KVM registers regressions
during VM migration which happens when destination host kernel
missing registers that the source host kernel has. The blessed
list registers was created by running on v6.5-rc3

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/riscv/processor.h   |   3 +
 .../selftests/kvm/riscv/get-reg-list.c        | 780 ++++++++++++++++++
 3 files changed, 784 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/riscv/get-reg-list.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 95f180e711d5..72ba48fcdc66 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -176,6 +176,7 @@ TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
 TEST_GEN_PROGS_riscv += demand_paging_test
 TEST_GEN_PROGS_riscv += dirty_log_test
+TEST_GEN_PROGS_riscv += get-reg-list
 TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
 TEST_GEN_PROGS_riscv += kvm_page_table_test
 TEST_GEN_PROGS_riscv += set_memory_region_test
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index d00d213c3805..5b62a3d2aa9b 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -38,6 +38,9 @@ static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
 					     KVM_REG_RISCV_TIMER_REG(name), \
 					     KVM_REG_SIZE_U64)
 
+#define RISCV_ISA_EXT_REG(idx)	__kvm_reg_id(KVM_REG_RISCV_ISA_EXT, \
+					     idx, KVM_REG_SIZE_ULONG)
+
 /* L3 index Bit[47:39] */
 #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
 #define PGTBL_L3_INDEX_SHIFT			39
diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
new file mode 100644
index 000000000000..e80f93114ac9
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Check for KVM_GET_REG_LIST regressions.
+ *
+ * Copyright (c) 2023 Intel Corporation
+ *
+ */
+#include <stdio.h>
+#include "kvm_util.h"
+#include "test_util.h"
+#include "processor.h"
+
+#define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
+
+bool filter_reg(__u64 reg)
+{
+	/*
+	 * Some ISA extensions are optional and not present on all host,
+	 * but they can't be disabled through ISA_EXT registers when present.
+	 * So, to make life easy, just filtering out these kind of registers.
+	 */
+	switch (reg & ~REG_MASK) {
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+bool check_reject_set(int err)
+{
+	return err == EOPNOTSUPP;
+}
+
+static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
+{
+	int ret;
+	unsigned long value;
+
+	ret = __vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(ext), &value);
+	if (ret) {
+		printf("Failed to get ext %d", ext);
+		return false;
+	}
+
+	return !!value;
+}
+
+void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
+{
+	struct vcpu_reg_sublist *s;
+
+	/*
+	 * Disable all extensions which were enabled by default
+	 * if they were available in the risc-v host.
+	 */
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
+		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
+
+	for_each_sublist(c, s) {
+		if (!s->feature)
+			continue;
+
+		/* Try to enable the desired extension */
+		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(s->feature), 1);
+
+		/* Double check whether the desired extension was enabled */
+		__TEST_REQUIRE(vcpu_has_ext(vcpu, s->feature),
+			       "%s not available, skipping tests\n", s->name);
+	}
+}
+
+static const char *config_id_to_str(__u64 id)
+{
+	/* reg_off is the offset into struct kvm_riscv_config */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CONFIG);
+
+	switch (reg_off) {
+	case KVM_REG_RISCV_CONFIG_REG(isa):
+		return "KVM_REG_RISCV_CONFIG_REG(isa)";
+	case KVM_REG_RISCV_CONFIG_REG(zicbom_block_size):
+		return "KVM_REG_RISCV_CONFIG_REG(zicbom_block_size)";
+	case KVM_REG_RISCV_CONFIG_REG(zicboz_block_size):
+		return "KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)";
+	case KVM_REG_RISCV_CONFIG_REG(mvendorid):
+		return "KVM_REG_RISCV_CONFIG_REG(mvendorid)";
+	case KVM_REG_RISCV_CONFIG_REG(marchid):
+		return "KVM_REG_RISCV_CONFIG_REG(marchid)";
+	case KVM_REG_RISCV_CONFIG_REG(mimpid):
+		return "KVM_REG_RISCV_CONFIG_REG(mimpid)";
+	}
+
+	/*
+	 * Config regs would grow regularly with new pseudo reg added, so
+	 * just show raw id to indicate a new pseudo config reg.
+	 */
+	return strdup_printf("KVM_REG_RISCV_CONFIG_REG(%lld) /* UNKNOWN */", reg_off);
+}
+
+static const char *core_id_to_str(const char *prefix, __u64 id)
+{
+	/* reg_off is the offset into struct kvm_riscv_core */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CORE);
+
+	switch (reg_off) {
+	case KVM_REG_RISCV_CORE_REG(regs.pc):
+		return "KVM_REG_RISCV_CORE_REG(regs.pc)";
+	case KVM_REG_RISCV_CORE_REG(regs.ra):
+		return "KVM_REG_RISCV_CORE_REG(regs.ra)";
+	case KVM_REG_RISCV_CORE_REG(regs.sp):
+		return "KVM_REG_RISCV_CORE_REG(regs.sp)";
+	case KVM_REG_RISCV_CORE_REG(regs.gp):
+		return "KVM_REG_RISCV_CORE_REG(regs.gp)";
+	case KVM_REG_RISCV_CORE_REG(regs.tp):
+		return "KVM_REG_RISCV_CORE_REG(regs.tp)";
+	case KVM_REG_RISCV_CORE_REG(regs.t0) ... KVM_REG_RISCV_CORE_REG(regs.t2):
+		return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.t%lld)",
+			   reg_off - KVM_REG_RISCV_CORE_REG(regs.t0));
+	case KVM_REG_RISCV_CORE_REG(regs.s0) ... KVM_REG_RISCV_CORE_REG(regs.s1):
+		return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.s%lld)",
+			   reg_off - KVM_REG_RISCV_CORE_REG(regs.s0));
+	case KVM_REG_RISCV_CORE_REG(regs.a0) ... KVM_REG_RISCV_CORE_REG(regs.a7):
+		return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.a%lld)",
+			   reg_off - KVM_REG_RISCV_CORE_REG(regs.a0));
+	case KVM_REG_RISCV_CORE_REG(regs.s2) ... KVM_REG_RISCV_CORE_REG(regs.s11):
+		return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.s%lld)",
+			   reg_off - KVM_REG_RISCV_CORE_REG(regs.s2) + 2);
+	case KVM_REG_RISCV_CORE_REG(regs.t3) ... KVM_REG_RISCV_CORE_REG(regs.t6):
+		return strdup_printf("KVM_REG_RISCV_CORE_REG(regs.t%lld)",
+			   reg_off - KVM_REG_RISCV_CORE_REG(regs.t3) + 3);
+	case KVM_REG_RISCV_CORE_REG(mode):
+		return "KVM_REG_RISCV_CORE_REG(mode)";
+	}
+
+	TEST_FAIL("%s: Unknown core reg id: 0x%llx", prefix, id);
+	return NULL;
+}
+
+#define RISCV_CSR_GENERAL(csr) \
+	"KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
+#define RISCV_CSR_AIA(csr) \
+	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
+
+static const char *general_csr_id_to_str(__u64 reg_off)
+{
+	/* reg_off is the offset into struct kvm_riscv_csr */
+	switch (reg_off) {
+	case KVM_REG_RISCV_CSR_REG(sstatus):
+		return RISCV_CSR_GENERAL(sstatus);
+	case KVM_REG_RISCV_CSR_REG(sie):
+		return RISCV_CSR_GENERAL(sie);
+	case KVM_REG_RISCV_CSR_REG(stvec):
+		return RISCV_CSR_GENERAL(stvec);
+	case KVM_REG_RISCV_CSR_REG(sscratch):
+		return RISCV_CSR_GENERAL(sscratch);
+	case KVM_REG_RISCV_CSR_REG(sepc):
+		return RISCV_CSR_GENERAL(sepc);
+	case KVM_REG_RISCV_CSR_REG(scause):
+		return RISCV_CSR_GENERAL(scause);
+	case KVM_REG_RISCV_CSR_REG(stval):
+		return RISCV_CSR_GENERAL(stval);
+	case KVM_REG_RISCV_CSR_REG(sip):
+		return RISCV_CSR_GENERAL(sip);
+	case KVM_REG_RISCV_CSR_REG(satp):
+		return RISCV_CSR_GENERAL(satp);
+	case KVM_REG_RISCV_CSR_REG(scounteren):
+		return RISCV_CSR_GENERAL(scounteren);
+	}
+
+	TEST_FAIL("Unknown general csr reg: 0x%llx", reg_off);
+	return NULL;
+}
+
+static const char *aia_csr_id_to_str(__u64 reg_off)
+{
+	/* reg_off is the offset into struct kvm_riscv_aia_csr */
+	switch (reg_off) {
+	case KVM_REG_RISCV_CSR_AIA_REG(siselect):
+		return RISCV_CSR_AIA(siselect);
+	case KVM_REG_RISCV_CSR_AIA_REG(iprio1):
+		return RISCV_CSR_AIA(iprio1);
+	case KVM_REG_RISCV_CSR_AIA_REG(iprio2):
+		return RISCV_CSR_AIA(iprio2);
+	case KVM_REG_RISCV_CSR_AIA_REG(sieh):
+		return RISCV_CSR_AIA(sieh);
+	case KVM_REG_RISCV_CSR_AIA_REG(siph):
+		return RISCV_CSR_AIA(siph);
+	case KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
+		return RISCV_CSR_AIA(iprio1h);
+	case KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
+		return RISCV_CSR_AIA(iprio2h);
+	}
+
+	TEST_FAIL("Unknown aia csr reg: 0x%llx", reg_off);
+	return NULL;
+}
+
+static const char *csr_id_to_str(const char *prefix, __u64 id)
+{
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CSR);
+	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
+
+	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	case KVM_REG_RISCV_CSR_GENERAL:
+		return general_csr_id_to_str(reg_off);
+	case KVM_REG_RISCV_CSR_AIA:
+		return aia_csr_id_to_str(reg_off);
+	}
+
+	TEST_FAIL("%s: Unknown csr subtype: 0x%llx", prefix, reg_subtype);
+	return NULL;
+}
+
+static const char *timer_id_to_str(const char *prefix, __u64 id)
+{
+	/* reg_off is the offset into struct kvm_riscv_timer */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_TIMER);
+
+	switch (reg_off) {
+	case KVM_REG_RISCV_TIMER_REG(frequency):
+		return "KVM_REG_RISCV_TIMER_REG(frequency)";
+	case KVM_REG_RISCV_TIMER_REG(time):
+		return "KVM_REG_RISCV_TIMER_REG(time)";
+	case KVM_REG_RISCV_TIMER_REG(compare):
+		return "KVM_REG_RISCV_TIMER_REG(compare)";
+	case KVM_REG_RISCV_TIMER_REG(state):
+		return "KVM_REG_RISCV_TIMER_REG(state)";
+	}
+
+	TEST_FAIL("%s: Unknown timer reg id: 0x%llx", prefix, id);
+	return NULL;
+}
+
+static const char *fp_f_id_to_str(const char *prefix, __u64 id)
+{
+	/* reg_off is the offset into struct __riscv_f_ext_state */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_FP_F);
+
+	switch (reg_off) {
+	case KVM_REG_RISCV_FP_F_REG(f[0]) ...
+	     KVM_REG_RISCV_FP_F_REG(f[31]):
+		return strdup_printf("KVM_REG_RISCV_FP_F_REG(f[%lld])", reg_off);
+	case KVM_REG_RISCV_FP_F_REG(fcsr):
+		return "KVM_REG_RISCV_FP_F_REG(fcsr)";
+	}
+
+	TEST_FAIL("%s: Unknown fp_f reg id: 0x%llx", prefix, id);
+	return NULL;
+}
+
+static const char *fp_d_id_to_str(const char *prefix, __u64 id)
+{
+	/* reg_off is the offset into struct __riscv_d_ext_state */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_FP_D);
+
+	switch (reg_off) {
+	case KVM_REG_RISCV_FP_D_REG(f[0]) ...
+	     KVM_REG_RISCV_FP_D_REG(f[31]):
+		return strdup_printf("KVM_REG_RISCV_FP_D_REG(f[%lld])", reg_off);
+	case KVM_REG_RISCV_FP_D_REG(fcsr):
+		return "KVM_REG_RISCV_FP_D_REG(fcsr)";
+	}
+
+	TEST_FAIL("%s: Unknown fp_d reg id: 0x%llx", prefix, id);
+	return NULL;
+}
+
+static const char *isa_ext_id_to_str(__u64 id)
+{
+	/* reg_off is the offset into unsigned long kvm_isa_ext_arr[] */
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_ISA_EXT);
+
+	static const char * const kvm_isa_ext_reg_name[] = {
+		"KVM_RISCV_ISA_EXT_A",
+		"KVM_RISCV_ISA_EXT_C",
+		"KVM_RISCV_ISA_EXT_D",
+		"KVM_RISCV_ISA_EXT_F",
+		"KVM_RISCV_ISA_EXT_H",
+		"KVM_RISCV_ISA_EXT_I",
+		"KVM_RISCV_ISA_EXT_M",
+		"KVM_RISCV_ISA_EXT_SVPBMT",
+		"KVM_RISCV_ISA_EXT_SSTC",
+		"KVM_RISCV_ISA_EXT_SVINVAL",
+		"KVM_RISCV_ISA_EXT_ZIHINTPAUSE",
+		"KVM_RISCV_ISA_EXT_ZICBOM",
+		"KVM_RISCV_ISA_EXT_ZICBOZ",
+		"KVM_RISCV_ISA_EXT_ZBB",
+		"KVM_RISCV_ISA_EXT_SSAIA",
+	};
+
+	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
+		/*
+		 * isa_ext regs would grow regularly with new isa extension added, so
+		 * just show "reg" to indicate a new extension.
+		 */
+		return strdup_printf("%lld /* UNKNOWN */", reg_off);
+	}
+
+	return kvm_isa_ext_reg_name[reg_off];
+}
+
+static const char *sbi_ext_single_id_to_str(__u64 reg_off)
+{
+	/* reg_off is KVM_RISCV_SBI_EXT_ID */
+	static const char * const kvm_sbi_ext_reg_name[] = {
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_RFENCE",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SRST",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL",
+		"KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR",
+	};
+
+	if (reg_off >= ARRAY_SIZE(kvm_sbi_ext_reg_name)) {
+		/*
+		 * sbi_ext regs would grow regularly with new sbi extension added, so
+		 * just show "reg" to indicate a new extension.
+		 */
+		return strdup_printf("KVM_REG_RISCV_SBI_SINGLE | %lld /* UNKNOWN */", reg_off);
+	}
+
+	return kvm_sbi_ext_reg_name[reg_off];
+}
+
+static const char *sbi_ext_multi_id_to_str(__u64 reg_subtype, __u64 reg_off)
+{
+	if (reg_off > KVM_REG_RISCV_SBI_MULTI_REG_LAST) {
+		/*
+		 * sbi_ext regs would grow regularly with new sbi extension added, so
+		 * just show "reg" to indicate a new extension.
+		 */
+		return strdup_printf("%lld /* UNKNOWN */", reg_off);
+	}
+
+	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_MULTI_EN:
+		return strdup_printf("KVM_REG_RISCV_SBI_MULTI_EN | %lld", reg_off);
+	case KVM_REG_RISCV_SBI_MULTI_DIS:
+		return strdup_printf("KVM_REG_RISCV_SBI_MULTI_DIS | %lld", reg_off);
+	}
+
+	return NULL;
+}
+
+static const char *sbi_ext_id_to_str(const char *prefix, __u64 id)
+{
+	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_SBI_EXT);
+	__u64 reg_subtype = reg_off & KVM_REG_RISCV_SUBTYPE_MASK;
+
+	reg_off &= ~KVM_REG_RISCV_SUBTYPE_MASK;
+
+	switch (reg_subtype) {
+	case KVM_REG_RISCV_SBI_SINGLE:
+		return sbi_ext_single_id_to_str(reg_off);
+	case KVM_REG_RISCV_SBI_MULTI_EN:
+	case KVM_REG_RISCV_SBI_MULTI_DIS:
+		return sbi_ext_multi_id_to_str(reg_subtype, reg_off);
+	}
+
+	TEST_FAIL("%s: Unknown sbi ext subtype: 0x%llx", prefix, reg_subtype);
+	return NULL;
+}
+
+void print_reg(const char *prefix, __u64 id)
+{
+	const char *reg_size = NULL;
+
+	TEST_ASSERT((id & KVM_REG_ARCH_MASK) == KVM_REG_RISCV,
+		    "%s: KVM_REG_RISCV missing in reg id: 0x%llx", prefix, id);
+
+	switch (id & KVM_REG_SIZE_MASK) {
+	case KVM_REG_SIZE_U32:
+		reg_size = "KVM_REG_SIZE_U32";
+		break;
+	case KVM_REG_SIZE_U64:
+		reg_size = "KVM_REG_SIZE_U64";
+		break;
+	case KVM_REG_SIZE_U128:
+		reg_size = "KVM_REG_SIZE_U128";
+		break;
+	default:
+		TEST_FAIL("%s: Unexpected reg size: 0x%llx in reg id: 0x%llx",
+			  prefix, (id & KVM_REG_SIZE_MASK) >> KVM_REG_SIZE_SHIFT, id);
+	}
+
+	switch (id & KVM_REG_RISCV_TYPE_MASK) {
+	case KVM_REG_RISCV_CONFIG:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CONFIG | %s,\n",
+				reg_size, config_id_to_str(id));
+		break;
+	case KVM_REG_RISCV_CORE:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CORE | %s,\n",
+				reg_size, core_id_to_str(prefix, id));
+		break;
+	case KVM_REG_RISCV_CSR:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_CSR | %s,\n",
+				reg_size, csr_id_to_str(prefix, id));
+		break;
+	case KVM_REG_RISCV_TIMER:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_TIMER | %s,\n",
+				reg_size, timer_id_to_str(prefix, id));
+		break;
+	case KVM_REG_RISCV_FP_F:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_F | %s,\n",
+				reg_size, fp_f_id_to_str(prefix, id));
+		break;
+	case KVM_REG_RISCV_FP_D:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_FP_D | %s,\n",
+				reg_size, fp_d_id_to_str(prefix, id));
+		break;
+	case KVM_REG_RISCV_ISA_EXT:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_ISA_EXT | %s,\n",
+				reg_size, isa_ext_id_to_str(id));
+		break;
+	case KVM_REG_RISCV_SBI_EXT:
+		printf("\tKVM_REG_RISCV | %s | KVM_REG_RISCV_SBI_EXT | %s,\n",
+				reg_size, sbi_ext_id_to_str(prefix, id));
+		break;
+	default:
+		TEST_FAIL("%s: Unexpected reg type: 0x%llx in reg id: 0x%llx", prefix,
+				(id & KVM_REG_RISCV_TYPE_MASK) >> KVM_REG_RISCV_TYPE_SHIFT, id);
+	}
+}
+
+/*
+ * The current blessed list was primed with the output of kernel version
+ * v6.5-rc3 and then later updated with new registers.
+ */
+static __u64 base_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(isa),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(mvendorid),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(marchid),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(mimpid),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.pc),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.ra),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.sp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.gp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.tp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t0),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t1),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t2),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s0),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s1),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a0),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a1),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a2),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a3),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a4),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a5),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a6),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.a7),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s2),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s3),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s4),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s5),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s6),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s7),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s8),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s9),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s10),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.s11),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t3),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t4),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t5),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(regs.t6),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CORE | KVM_REG_RISCV_CORE_REG(mode),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sstatus),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sie),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(stvec),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sscratch),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sepc),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scause),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(stval),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(sip),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(satp),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(scounteren),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(time),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(compare),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_A,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_C,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_V01,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_TIME,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_IPI,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_RFENCE,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_SRST,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_HSM,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_PMU,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_EXPERIMENTAL,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_SINGLE | KVM_RISCV_SBI_EXT_VENDOR,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_MULTI_EN | 0,
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_SBI_EXT | KVM_REG_RISCV_SBI_MULTI_DIS | 0,
+};
+
+static __u64 base_rejects_set[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(frequency),
+};
+
+/*
+ * The skips_set list registers that should skip set test.
+ *  - KVM_REG_RISCV_TIMER_REG(state): set would fail if it was not initialized properly.
+ */
+static __u64 base_skips_set[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | KVM_REG_RISCV_TIMER_REG(state),
+};
+
+static __u64 h_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_H,
+};
+
+static __u64 zicbom_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM,
+};
+
+static __u64 zicboz_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicboz_block_size),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ,
+};
+
+static __u64 zicbom_rejects_set[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicbom_block_size),
+};
+
+static __u64 zicboz_rejects_set[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CONFIG | KVM_REG_RISCV_CONFIG_REG(zicboz_block_size),
+};
+
+static __u64 svpbmt_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT,
+};
+
+static __u64 sstc_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC,
+};
+
+static __u64 svinval_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL,
+};
+
+static __u64 zihintpause_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE,
+};
+
+static __u64 zbb_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB,
+};
+
+static __u64 aia_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA,
+};
+
+static __u64 fp_f_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[0]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[1]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[2]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[3]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[4]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[5]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[6]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[7]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[8]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[9]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[10]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[11]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[12]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[13]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[14]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[15]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[16]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[17]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[18]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[19]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[20]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[21]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[22]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[23]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[24]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[25]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[26]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[27]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[28]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[29]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[30]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[31]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(fcsr),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_F,
+};
+
+static __u64 fp_d_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[0]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[1]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[2]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[3]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[4]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[5]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[6]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[7]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[8]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[9]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[10]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[11]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[12]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[13]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[14]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[15]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[16]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[17]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[18]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[19]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[20]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[21]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[22]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[23]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[24]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[25]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[26]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[27]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[28]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[29]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[30]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(f[31]),
+	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | KVM_REG_RISCV_FP_D_REG(fcsr),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D,
+};
+
+#define BASE_SUBLIST \
+	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
+	 .rejects_set = base_rejects_set, .rejects_set_n = ARRAY_SIZE(base_rejects_set), \
+	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
+#define H_REGS_SUBLIST \
+	{"h", .feature = KVM_RISCV_ISA_EXT_H, .regs = h_regs, .regs_n = ARRAY_SIZE(h_regs),}
+#define ZICBOM_REGS_SUBLIST \
+	{"zicbom", .feature = KVM_RISCV_ISA_EXT_ZICBOM, .regs = zicbom_regs, .regs_n = ARRAY_SIZE(zicbom_regs), \
+	 .rejects_set = zicbom_rejects_set, .rejects_set_n = ARRAY_SIZE(zicbom_rejects_set),}
+#define ZICBOZ_REGS_SUBLIST \
+	{"zicboz", .feature = KVM_RISCV_ISA_EXT_ZICBOZ, .regs = zicboz_regs, .regs_n = ARRAY_SIZE(zicboz_regs), \
+	 .rejects_set = zicboz_rejects_set, .rejects_set_n = ARRAY_SIZE(zicboz_rejects_set),}
+#define SVPBMT_REGS_SUBLIST \
+	{"svpbmt", .feature = KVM_RISCV_ISA_EXT_SVPBMT, .regs = svpbmt_regs, .regs_n = ARRAY_SIZE(svpbmt_regs),}
+#define SSTC_REGS_SUBLIST \
+	{"sstc", .feature = KVM_RISCV_ISA_EXT_SSTC, .regs = sstc_regs, .regs_n = ARRAY_SIZE(sstc_regs),}
+#define SVINVAL_REGS_SUBLIST \
+	{"svinval", .feature = KVM_RISCV_ISA_EXT_SVINVAL, .regs = svinval_regs, .regs_n = ARRAY_SIZE(svinval_regs),}
+#define ZIHINTPAUSE_REGS_SUBLIST \
+	{"zihintpause", .feature = KVM_RISCV_ISA_EXT_ZIHINTPAUSE, .regs = zihintpause_regs, .regs_n = ARRAY_SIZE(zihintpause_regs),}
+#define ZBB_REGS_SUBLIST \
+	{"zbb", .feature = KVM_RISCV_ISA_EXT_ZBB, .regs = zbb_regs, .regs_n = ARRAY_SIZE(zbb_regs),}
+#define AIA_REGS_SUBLIST \
+	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
+#define FP_F_REGS_SUBLIST \
+	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
+		.regs_n = ARRAY_SIZE(fp_f_regs),}
+#define FP_D_REGS_SUBLIST \
+	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
+		.regs_n = ARRAY_SIZE(fp_d_regs),}
+
+static struct vcpu_reg_list h_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	H_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list zicbom_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	ZICBOM_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list zicboz_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	ZICBOZ_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list svpbmt_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	SVPBMT_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list sstc_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	SSTC_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list svinval_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	SVINVAL_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list zihintpause_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	ZIHINTPAUSE_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list zbb_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	ZBB_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list aia_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	AIA_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list fp_f_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	FP_F_REGS_SUBLIST,
+	{0},
+	},
+};
+
+static struct vcpu_reg_list fp_d_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	FP_D_REGS_SUBLIST,
+	{0},
+	},
+};
+
+struct vcpu_reg_list *vcpu_configs[] = {
+	&h_config,
+	&zicbom_config,
+	&zicboz_config,
+	&svpbmt_config,
+	&sstc_config,
+	&svinval_config,
+	&zihintpause_config,
+	&zbb_config,
+	&aia_config,
+	&fp_f_config,
+	&fp_d_config,
+};
+int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.34.1

