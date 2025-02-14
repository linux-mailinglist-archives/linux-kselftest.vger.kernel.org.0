Return-Path: <linux-kselftest+bounces-26611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028CA35418
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9930916CFF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBA9186E54;
	Fri, 14 Feb 2025 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFTcAcZZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F213C67E;
	Fri, 14 Feb 2025 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498486; cv=none; b=qJSRvt+vdjkPSf2IIFEZCqF8gWaEH1SrnuV4wIzhVblTLO7THLjJrRulM+REYyNxBCJUawvPrs5bJ3pkqx4hkE7SnAY9Oma5J8bIpMyYYuHzZiEd/7zKiHHnDRZjtuSv76ABD/dARYHGyPCPUgMEqb676eQbkWm4Svs97z9c3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498486; c=relaxed/simple;
	bh=ST8cvmEJlmmZZoglNVpZrkW7z4enEIPEfasznNtVTCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+lv4km+mjRkHLNt3uBvnXCCOnrm6RwwhBuM5oACPoEg8qOzFK7ytMR9s+gCo6eFPEF7DEzKXgZXRxo1Grjac+UmOYoIHHQpELdDDV39GsxSl9ls7tljU03ykGIptZI77UNfdYysQKktu05CDtIpsNAtAm4sq8TRBRwVLWEwtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFTcAcZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4EDC4CED1;
	Fri, 14 Feb 2025 02:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498486;
	bh=ST8cvmEJlmmZZoglNVpZrkW7z4enEIPEfasznNtVTCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OFTcAcZZd1OnkLlymvGvZ7PaeLBLX/x8RW3R9r40OtIad5SSN3FqHOnxl2DBojztY
	 4w9+unQOVdxfRhkOE9oX6KkGR5IUtY5Oxy5pQxMFX4RS4/fdkPMOU5AfE3tG3AnrSX
	 ofolpzzj2ODEt6sjZXiVKZLnLHK7RqKkh1e0tgFtewRSinkd37JNdborIhKG9wVAA3
	 ZvKlT/PoJujmrDA0m6CeuTc3tvQ/WJWNWaVIxzVTl65aww6lrH4itmdbyl42NPzcDI
	 SALjBGVmWcFxV0WlLUtYaw/13YM41S8bA/8vfDU2gysvKYXACEzEIsv91aX9RPr3yM
	 cOCxn6PV7wLrQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:50 +0000
Subject: [PATCH v4 07/27] KVM: arm64: Pull ctxt_has_ helpers to start of
 sysreg-sr.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-7-d64a681adcc2@kernel.org>
References: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
In-Reply-To: <20250214-kvm-arm64-sme-v4-0-d64a681adcc2@kernel.org>
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
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=3314; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ST8cvmEJlmmZZoglNVpZrkW7z4enEIPEfasznNtVTCQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPFTI+XTXydWt3dsh69De8TwYqweuNewVUYsHNV
 073HGsSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jxQAKCRAk1otyXVSH0IvCB/
 95sal3p7n1BoGOj5DL94/59IWLjclRI+C8m4TkdMzSBzs2ARYfbmAtiElcpw1gKP5q321j10CNUZK0
 EJp0hVcVx8dSzSMXD3WINQWtAmSR+X/S2ugEWcus1OwDxr4SOjWVvm8uCU4YNJFtGNEIaw+ZfZ3/Q7
 p6n9V+Nqw3OSHBL7V8YE0CnO+egiIdjiro9m5SmSkI18AjCnHQn3r7Ighh51eHvLE++n6bjcQ2IVbn
 6cHItw4+TgOKqpmzhmhxlDNvqAYSkSUIIUBF4vOBTo0ALd2WRpXm9WcU1NEgkCH/CkI+MW9YWKgRr4
 6pmu3BF2wAdkbESkzTd1RzN1fgBNFy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Rather than add earlier prototypes of specific ctxt_has_ helpers let's just
pull all their definitions to the top of sysreg-sr.h so they're all
available to all the individual save/restore functions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 62 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 76ff095c6b6ebf336aab3018ec1f384a5f19949e..7a4ad8a4c3727e4628b375cbefc5e0d3533687de 100644
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
@@ -28,36 +26,6 @@ static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
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
@@ -98,6 +66,36 @@ static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
 	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
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


