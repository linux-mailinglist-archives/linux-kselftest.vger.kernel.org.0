Return-Path: <linux-kselftest+bounces-35750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D063AE8102
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110733AD21E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357B2D9EE1;
	Wed, 25 Jun 2025 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO1hEUGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621992D9EDF;
	Wed, 25 Jun 2025 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850713; cv=none; b=G3+y566EczV5qWnC3znPMUsh19a1tKjY30cOAl49bF7Ih+xK75W2IlETDrWuSpOtm2Jy7xP0A5qgZZLfYYQQ82gj6JR+SXm0k500ES/N1Bw0UfczbZGSz3o2zbyp8/qy1ifPgGD6JtKEqyUpOYQ/CD/f/jT38aLH9uVvvCnpUAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850713; c=relaxed/simple;
	bh=5KQ/uA0hy051leNLiXTP5XwOLFD/icV/voTuvRYqa4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F8jy3SGO3Hz2ZiD9/chNpdX2A6gWk7G9PdRYAdI+tAv5jpJRm7nP9cGKgUhoZoW9imi+T0yKIWzlP3h4WCzNiwyRX5qisyintjsZOpjc0Cns6sDUh4EurtCW7h83Vb/X/pqdm7U3RKP3vdSqUoDbhF1JbHvHHHhzbVl4qzhhxqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO1hEUGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE8C4CEF0;
	Wed, 25 Jun 2025 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850712;
	bh=5KQ/uA0hy051leNLiXTP5XwOLFD/icV/voTuvRYqa4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PO1hEUGi0nlAwKAsRCYafdzk1/NGodptkEJCJaqNlSTtjsivkuXozroklYTQNuu+/
	 J4wH6r0AxMBq27rSbuUHz8kZlY/qONSRZ0WQWEt64TE2hgGruHICgvs5nQD/UGzr1B
	 v7GErkbJF1qekvWXI4GEB5kiMrG8snGsCVPiImUofoO0jDi6NRva4+SQEAWIXi9w2b
	 pOKFPcmBT7iXhUNvPXIzx46rJ4OwZEthqu/d08WRODEX/M6zMaVN5trEP5JIp6Gaww
	 ZMILndZuOJycqLX3lO1pjDJCbJ4pZ3SoWnGiTQz1S7cD+p1ohJGrWgPMVEoNFAbi7B
	 q0BsYgK51W/6g==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:47:58 +0100
Subject: [PATCH v6 07/28] KVM: arm64: Pull ctxt_has_ helpers to start of
 sysreg-sr.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-7-114cff4ffe04@kernel.org>
References: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
In-Reply-To: <20250625-kvm-arm64-sme-v6-0-114cff4ffe04@kernel.org>
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
X-Mailer: b4 0.15-dev-08c49
X-Developer-Signature: v=1; a=openpgp-sha256; l=3287; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5KQ/uA0hy051leNLiXTP5XwOLFD/icV/voTuvRYqa4Y=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9xq77abeYmWzYh1ixIGSLYhTa3EsGyGplz4b
 Y3EOIigCCqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcagAKCRAk1otyXVSH
 0K6uB/4jocGqwscsrFl0qZ1apw4XJeekVIwNuamhYQbwZqQOdOv9r0jUj+dd+kAVMx6sEKHWqZC
 LyBjhO6fCqhybuVg6DVXV/wUkf8tPyUR8bOXDJGjoGfxvxDYnPDgXXwfWBV2XN3uHMMVyALjYbI
 LSMh/HqebTJYqaEHm95lgOG558YT7BXdcMTFHi4mPD1Da6XhrzCVg2+NNJzy56vM7eiLBrn1Nil
 e//mIWPclFEdeQxlatub0npZW5q+SQsBwsL8Odzj8OD9AtT2IGozafFtxFWXiXuCZ13giBE7EVR
 uCIseD+HW1fznJrDZTeOZVMCjwLq1Urh9mLGDfksQNp6l05m
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Rather than add earlier prototypes of specific ctxt_has_ helpers let's just
pull all their definitions to the top of sysreg-sr.h so they're all
available to all the individual save/restore functions.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 82 +++++++++++++++---------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index 4d0dbea4c56f..223819e95405 100644
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
@@ -28,6 +26,46 @@ static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
 	return vcpu;
 }
 
+static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
+
+	return kvm_has_mte(kern_hyp_va(vcpu->kvm));
+}
+
+static inline bool ctxt_has_s1pie(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!cpus_have_final_cap(ARM64_HAS_S1PIE))
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_s1pie(kern_hyp_va(vcpu->kvm));
+}
+
+static inline bool ctxt_has_tcrx(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!cpus_have_final_cap(ARM64_HAS_TCR2))
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_tcr2(kern_hyp_va(vcpu->kvm));
+}
+
+static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu;
+
+	if (!system_supports_poe())
+		return false;
+
+	vcpu = ctxt_to_vcpu(ctxt);
+	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
+}
+
 static inline bool ctxt_is_guest(struct kvm_cpu_context *ctxt)
 {
 	return host_data_ptr(host_ctxt) != ctxt;
@@ -69,46 +107,6 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
 }
 
-static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
-{
-	struct kvm_vcpu *vcpu = ctxt_to_vcpu(ctxt);
-
-	return kvm_has_mte(kern_hyp_va(vcpu->kvm));
-}
-
-static inline bool ctxt_has_s1pie(struct kvm_cpu_context *ctxt)
-{
-	struct kvm_vcpu *vcpu;
-
-	if (!cpus_have_final_cap(ARM64_HAS_S1PIE))
-		return false;
-
-	vcpu = ctxt_to_vcpu(ctxt);
-	return kvm_has_s1pie(kern_hyp_va(vcpu->kvm));
-}
-
-static inline bool ctxt_has_tcrx(struct kvm_cpu_context *ctxt)
-{
-	struct kvm_vcpu *vcpu;
-
-	if (!cpus_have_final_cap(ARM64_HAS_TCR2))
-		return false;
-
-	vcpu = ctxt_to_vcpu(ctxt);
-	return kvm_has_tcr2(kern_hyp_va(vcpu->kvm));
-}
-
-static inline bool ctxt_has_s1poe(struct kvm_cpu_context *ctxt)
-{
-	struct kvm_vcpu *vcpu;
-
-	if (!system_supports_poe())
-		return false;
-
-	vcpu = ctxt_to_vcpu(ctxt);
-	return kvm_has_s1poe(kern_hyp_va(vcpu->kvm));
-}
-
 static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, SCTLR_EL1)	= read_sysreg_el1(SYS_SCTLR);

-- 
2.39.5


