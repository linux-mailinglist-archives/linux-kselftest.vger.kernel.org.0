Return-Path: <linux-kselftest+bounces-39628-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF1B30B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720CD1739EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823223B63F;
	Fri, 22 Aug 2025 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfYf91E2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C561DE8AD;
	Fri, 22 Aug 2025 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827699; cv=none; b=kAwjjvUG6VGOoiBAK7WCeV/+WMbiYRWhx3Qi74uIf+KGJXfy9O3PYduhPw3Ed8ljwztIRdlwjFcrlpsYphNzTMWCz94KvNu9EvSHfUAg1S26wGuG2qI2Ydm8948C2z6J8nlnSVXlbxPjsWsdy4hZHqmVTZOL8lup1g+jos55/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827699; c=relaxed/simple;
	bh=Sp+TAelZmX24aLyaDocHISqg813AdGCzZMNr5P6CYI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odprla4mUMuObn4cGYvANoIaiJ2BDn1jiqF4rHPhmWov7dYJlJICfb7KxFCweKNEDGhRKQhatDO9nmM2ghPMPbsGnxz+cM29XLlO63VnopYjWlI0ZIjvbcT+fiyXKRryt2aT3/dD3z6Kx+c5EzV14Dq9jDn1coiVUoRgMnv2bZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfYf91E2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F32C4CEEB;
	Fri, 22 Aug 2025 01:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827697;
	bh=Sp+TAelZmX24aLyaDocHISqg813AdGCzZMNr5P6CYI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HfYf91E2maGA3GZ8dIacAgPOtLnD5vsLR0VAXS7RANNRgZyUI4K32k7JgrGDzG4aG
	 +gIH/aHm5qG+fmz/mUrULpM1rocjGLAbixmApGDjkejv6AWIe5dbaU5wOrPbplUTog
	 t062FY05TU+E7fjwKxJoSSkAnV+izGSzBF+WVYOYiX/3haQStAp5sD3BP6L8tQTvKC
	 We+Mknfof6x/P1NAD9u+dvzNcY6h4qHx7mcT8QNkXVpUgenVTEaV4cLMT2qMlPRWsG
	 2higbfMFDqA8pftTeePNuAhpPYlHoGKbm7y2IHhBQ8GeH8VZMg9smD4miIYE0UHaIH
	 TTYRZBtqBZD0A==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:37 +0100
Subject: [PATCH v7 08/29] KVM: arm64: Pull ctxt_has_ helpers to start of
 sysreg-sr.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-8-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3907; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Sp+TAelZmX24aLyaDocHISqg813AdGCzZMNr5P6CYI4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop82+8E+qQ2biWvK54LmYXwac54UiR74PjxM5c
 wdjpRzgNQ2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNvgAKCRAk1otyXVSH
 0OD7B/4mpUxOxRZaFS6g5BXtGs46mMGQgGp7fPIF5ZZ4/z1eMQW8mNdsTffRGiEGK7X9A4Y2gOl
 Htt4punjrKq5/54ovofB9Vfs4Bcv/IxX3EtBImJmI/SGnKtg/iECBTpisV8B7jfFQw644aw9Rlo
 k1Qctanl6Ck0zDZsFBzeOY3/3moQo6OcZEuTfJfLTdyhXQ+Jv5Ci8dpZphF8eXJ0CuutC/tNmBS
 xGiZsYIaMlIDLQG027Gw9lRJ4noRA5JI4DEbiZ6wX+bRNEKKCHOpqUoIKlbZQG1Zf+iPVATd5fK
 LDSA23Je2Ravfi5Bs6iZMES4+My1IkwN9oSFP5GGNnWZ3w+c
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Rather than add earlier prototypes of specific ctxt_has_ helpers let's just
pull all their definitions to the top of sysreg-sr.h so they're all
available to all the individual save/restore functions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 84 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index a17cbe7582de..5624fd705ae3 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -16,8 +16,6 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
-static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt);
-
 static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 {
 	struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
@@ -28,47 +26,6 @@ static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 	return vcpu;
 }
 
-static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
-{
-	return host_data_ptr(host_ctxt) != ctxt;
-}
-
-static inline u64 *ctxt_mdscr_el1(struct kvm_cpu_context *ctxt)
-{
-	struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
-
-	if (ctxt_is_guest(ctxt) && kvm_host_owns_debug_regs(vcpu))
-		return &vcpu->arch.external_mdscr_el1;
-
-	return &ctxt_sys_reg(ctxt, MDSCR_EL1);
-}
-
-static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
-{
-	struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
-
-	if (!(ctxt_is_guest(ctxt) &&
-	      test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
-		return read_cpuid_id();
-
-	return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
-}
-
-static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
-{
-	*ctxt_mdscr_el1(ctxt)	= read_sysreg(mdscr_el1);
-
-	// POR_EL0 can affect uaccess, so must be saved/restored early.
-	if (ctxt_has_s1poe(ctxt))
-		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
-}
-
-static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
-{
-	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
-	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
-}
-
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
 {
 	struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
@@ -131,6 +88,47 @@ static inline bool ctxt_has_sctlr2(struct kvm_cpu_context *ctxt)
 	return kvm_has_sctlr2(kern_hyp_va(vcpu->kvm));
 }
 
+static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
+{
+	return host_data_ptr(host_ctxt) != ctxt;
+}
+
+static inline u64 *ctxt_mdscr_el1(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
+
+	if (ctxt_is_guest(ctxt) && kvm_host_owns_debug_regs(vcpu))
+		return &vcpu->arch.external_mdscr_el1;
+
+	return &ctxt_sys_reg(ctxt, MDSCR_EL1);
+}
+
+static inline u64 ctxt_midr_el1(struct kvm_cpu_context *ctxt)
+{
+	struct kvm *kvm = kern_hyp_va(ctxt_to_vcpu(ctxt)->kvm);
+
+	if (!(ctxt_is_guest(ctxt) &&
+	      test_bit(KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS, &kvm->arch.flags)))
+		return read_cpuid_id();
+
+	return kvm_read_vm_id_reg(kvm, SYS_MIDR_EL1);
+}
+
+static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
+{
+	*ctxt_mdscr_el1(ctxt)	= read_sysreg(mdscr_el1);
+
+	// POR_EL0 can affect uaccess, so must be saved/restored early.
+	if (ctxt_has_s1poe(ctxt))
+		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
+}
+
+static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
+{
+	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
+	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+}
+
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);

-- 
2.39.5


