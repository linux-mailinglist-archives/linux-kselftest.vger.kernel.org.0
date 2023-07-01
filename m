Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E52744966
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Jul 2023 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGANk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Jul 2023 09:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjGANkY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Jul 2023 09:40:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B069423E;
        Sat,  1 Jul 2023 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688218799; x=1719754799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=04wGA9n9pWRWu8KiiczvUSfLNUDBFz5lAJubM4bYVWk=;
  b=YvtHtuDkRm6lBMNnUVCLuS3JobOCzGXhg5ocZMqkCKzsG0Hx4OXaLiQC
   14mktOz80dqJVO2RYTBpTmrKlIV1D+x/5DGL/muYcFHbhMJvNfKWiSSv9
   7IMJ7EzNTVIBxi1qVNZsadJxnDAYRkZE540rRcppw5fVikdDXGctUfDsK
   +YSJ/OXWOoGwgnemERJB9KSFaAIIWbUOFamxwiH+WS+s3aFC8V9WfrmUJ
   I5cVeMcGcYRauedReFT3DXROza/eXI4EAhrQDekgt+QThlKOyxTbpmMcP
   ovNh5m31NO34D1ONYuyggN0khvCx8V5VYYdnT0ADfIR6Boi26kf7jJk/Z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="342926324"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="342926324"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 06:39:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10758"; a="747694290"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="747694290"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2023 06:39:49 -0700
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
Subject: [PATCH v5 12/13] KVM: riscv: Add KVM_GET_REG_LIST API support
Date:   Sat,  1 Jul 2023 21:43:00 +0800
Message-Id: <1674ba5898e86766264df720602cf9a086206ad5.1688010022.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688010022.git.haibo1.xu@intel.com>
References: <cover.1688010022.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GET_REG_LIST API will return all registers that are available to
KVM_GET/SET_ONE_REG APIs. It's very useful to identify some platform
regression issue during VM migration.

Since this API was already supported on arm64, it is straightforward
to enable it on riscv with similar code structure.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 Documentation/virt/kvm/api.rst |   2 +-
 arch/riscv/kvm/vcpu.c          | 375 +++++++++++++++++++++++++++++++++
 2 files changed, 376 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index add067793b90..280e89abd004 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -3499,7 +3499,7 @@ VCPU matching underlying host.
 ---------------------
 
 :Capability: basic
-:Architectures: arm64, mips
+:Architectures: arm64, mips, riscv
 :Type: vcpu ioctl
 :Parameters: struct kvm_reg_list (in/out)
 :Returns: 0 on success; -1 on error
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 8bd9f2a8a0b9..ad420b8676ab 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -657,6 +657,363 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static int copy_config_reg_indices(const struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	int n = 0;
+
+	for (int i = 0; i < sizeof(struct kvm_riscv_config)/sizeof(unsigned long);
+		 i++) {
+		u64 size;
+		u64 reg;
+
+		/*
+		 * Avoid reporting config reg if the corresponding extension
+		 * was not available.
+		 */
+		if (i == KVM_REG_RISCV_CONFIG_REG(zicbom_block_size) &&
+			!riscv_isa_extension_available(vcpu->arch.isa, ZICBOM))
+			continue;
+		else if (i == KVM_REG_RISCV_CONFIG_REG(zicboz_block_size) &&
+			!riscv_isa_extension_available(vcpu->arch.isa, ZICBOZ))
+			continue;
+
+		size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CONFIG | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		n++;
+	}
+
+	return n;
+}
+
+static unsigned long num_config_regs(const struct kvm_vcpu *vcpu)
+{
+	return copy_config_reg_indices(vcpu, NULL);
+}
+
+static inline unsigned long num_core_regs(void)
+{
+	return sizeof(struct kvm_riscv_core) / sizeof(unsigned long);
+}
+
+static int copy_core_reg_indices(u64 __user *uindices)
+{
+	int n = num_core_regs();
+
+	for (int i = 0; i < n; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CORE | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	return n;
+}
+
+static inline unsigned long num_csr_regs(const struct kvm_vcpu *vcpu)
+{
+	unsigned long n = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
+
+	if (riscv_isa_extension_available(vcpu->arch.isa, SSAIA))
+		n += sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
+
+	return n;
+}
+
+static int copy_csr_reg_indices(const struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	int n1 = sizeof(struct kvm_riscv_csr) / sizeof(unsigned long);
+	int n2 = 0;
+
+	/* copy general csr regs */
+	for (int i = 0; i < n1; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CSR |
+				  KVM_REG_RISCV_CSR_GENERAL | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	/* copy AIA csr regs */
+	if (riscv_isa_extension_available(vcpu->arch.isa, SSAIA)) {
+		n2 = sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long);
+
+		for (int i = 0; i < n2; i++) {
+			u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+			u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_CSR |
+					  KVM_REG_RISCV_CSR_AIA | i;
+
+			if (uindices) {
+				if (put_user(reg, uindices))
+					return -EFAULT;
+				uindices++;
+			}
+		}
+	}
+
+	return n1 + n2;
+}
+
+static inline unsigned long num_timer_regs(void)
+{
+	return sizeof(struct kvm_riscv_timer) / sizeof(u64);
+}
+
+static int copy_timer_reg_indices(u64 __user *uindices)
+{
+	int n = num_timer_regs();
+
+	for (int i = 0; i < n; i++) {
+		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_TIMER | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	return n;
+}
+
+static inline unsigned long num_fp_f_regs(const struct kvm_vcpu *vcpu)
+{
+	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
+
+	if (riscv_isa_extension_available(vcpu->arch.isa, f))
+		return sizeof(cntx->fp.f) / sizeof(u32);
+	else
+		return 0;
+}
+
+static int copy_fp_f_reg_indices(const struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	int n = num_fp_f_regs(vcpu);
+
+	for (int i = 0; i < n; i++) {
+		u64 reg = KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	return n;
+}
+
+static inline unsigned long num_fp_d_regs(const struct kvm_vcpu *vcpu)
+{
+	const struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
+
+	if (riscv_isa_extension_available(vcpu->arch.isa, d))
+		return sizeof(cntx->fp.d.f) / sizeof(u64) + 1;
+	else
+		return 0;
+}
+
+static int copy_fp_d_reg_indices(const struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	int i;
+	int n = num_fp_d_regs(vcpu);
+	u64 reg;
+
+	/* copy fp.d.f indices */
+	for (i = 0; i < n-1; i++) {
+		reg = KVM_REG_RISCV | KVM_REG_SIZE_U64 | KVM_REG_RISCV_FP_D | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	/* copy fp.d.fcsr indices */
+	reg = KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_D | i;
+	if (uindices) {
+		if (put_user(reg, uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	return n;
+}
+
+static int copy_isa_ext_reg_indices(const struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	unsigned int n = 0;
+	unsigned long isa_ext;
+
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_ISA_EXT | i;
+
+		isa_ext = kvm_isa_ext_arr[i];
+		if (!__riscv_isa_extension_available(vcpu->arch.isa, isa_ext))
+			continue;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		n++;
+	}
+
+	return n;
+}
+
+static inline unsigned long num_isa_ext_regs(const struct kvm_vcpu *vcpu)
+{
+	return copy_isa_ext_reg_indices(vcpu, NULL);;
+}
+
+static inline unsigned long num_sbi_ext_regs(void)
+{
+	/*
+	 * number of KVM_REG_RISCV_SBI_SINGLE +
+	 * 2 x (number of KVM_REG_RISCV_SBI_MULTI)
+	 */
+	return KVM_RISCV_SBI_EXT_MAX + 2*(KVM_REG_RISCV_SBI_MULTI_REG_LAST+1);
+}
+
+static int copy_sbi_ext_reg_indices(u64 __user *uindices)
+{
+	int n;
+
+	/* copy KVM_REG_RISCV_SBI_SINGLE */
+	n = KVM_RISCV_SBI_EXT_MAX;
+	for (int i = 0; i < n; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
+				  KVM_REG_RISCV_SBI_SINGLE | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	/* copy KVM_REG_RISCV_SBI_MULTI */
+	n = KVM_REG_RISCV_SBI_MULTI_REG_LAST + 1;
+	for (int i = 0; i < n; i++) {
+		u64 size = IS_ENABLED(CONFIG_32BIT) ? KVM_REG_SIZE_U32 : KVM_REG_SIZE_U64;
+		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
+				  KVM_REG_RISCV_SBI_MULTI_EN | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+
+		reg = KVM_REG_RISCV | size | KVM_REG_RISCV_SBI_EXT |
+			  KVM_REG_RISCV_SBI_MULTI_DIS | i;
+
+		if (uindices) {
+			if (put_user(reg, uindices))
+				return -EFAULT;
+			uindices++;
+		}
+	}
+
+	return num_sbi_ext_regs();
+}
+
+/*
+ * kvm_riscv_vcpu_num_regs - how many registers do we present via KVM_GET/SET_ONE_REG
+ *
+ * This is for all registers.
+ */
+static unsigned long kvm_riscv_vcpu_num_regs(struct kvm_vcpu *vcpu)
+{
+	unsigned long res = 0;
+
+	res += num_config_regs(vcpu);
+	res += num_core_regs();
+	res += num_csr_regs(vcpu);
+	res += num_timer_regs();
+	res += num_fp_f_regs(vcpu);
+	res += num_fp_d_regs(vcpu);
+	res += num_isa_ext_regs(vcpu);
+	res += num_sbi_ext_regs();
+
+	return res;
+}
+
+/*
+ * kvm_riscv_vcpu_copy_reg_indices - get indices of all registers.
+ */
+static int kvm_riscv_vcpu_copy_reg_indices(struct kvm_vcpu *vcpu,
+				u64 __user *uindices)
+{
+	int ret;
+
+	ret = copy_config_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_core_reg_indices(uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_csr_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_timer_reg_indices(uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_fp_f_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_fp_d_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_isa_ext_reg_indices(vcpu, uindices);
+	if (ret < 0)
+		return ret;
+	uindices += ret;
+
+	ret = copy_sbi_ext_reg_indices(uindices);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
 				  const struct kvm_one_reg *reg)
 {
@@ -758,6 +1115,24 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = kvm_riscv_vcpu_get_reg(vcpu, &reg);
 		break;
 	}
+	case KVM_GET_REG_LIST: {
+		struct kvm_reg_list __user *user_list = argp;
+		struct kvm_reg_list reg_list;
+		unsigned int n;
+
+		r = -EFAULT;
+		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
+			break;
+		n = reg_list.n;
+		reg_list.n = kvm_riscv_vcpu_num_regs(vcpu);
+		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
+			break;
+		r = -E2BIG;
+		if (n < reg_list.n)
+			break;
+		r = kvm_riscv_vcpu_copy_reg_indices(vcpu, user_list->reg);
+		break;
+	}
 	default:
 		break;
 	}
-- 
2.34.1

