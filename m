Return-Path: <linux-kselftest+bounces-2388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A381CCDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE351C22797
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE722556C;
	Fri, 22 Dec 2023 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3erWCgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E222EAEE;
	Fri, 22 Dec 2023 16:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4715C433C9;
	Fri, 22 Dec 2023 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262136;
	bh=pkxcInMdoFVAPVE96bPSNNBTSXFTOzHNu/P21a097UY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i3erWCgm8DBgeFvmh/G5cWUZmsLf3QCoQ6GquS14KuTTMtB9CKu135UqDoz7cpGmb
	 nT+Pd8IY5Ie+3Z+hxKL62VFnamR+GpA3s5WyYpoOyVm9tXjUlMsq7q9kGNcts18iHe
	 mpiY7TzmAVskc0tTMV4xMKtazEOGR5SREiQrQvKuqV7JuspbbxQxE6z0eWaSAt8v8g
	 /3xlfpKgnzIBHER692y4Op9ZGAVWsucbsOOqbM8iH7XlgiD5eKl4kOMIvCKHzYehhn
	 lZYySXQRGGX0RA7JCdhPHXPS2g0QJDoJdJlkdT3dAlbPu75GcxHFSIiyYW5UgjuLfh
	 6KRhxfI0GLrOA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:19 +0000
Subject: [PATCH RFC v2 11/22] KVM: arm64: Make SMPRI_EL1 RES0 for SME
 guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-11-da226cb180bb@kernel.org>
References: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
In-Reply-To: <20231222-kvm-arm64-sme-v2-0-da226cb180bb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=3438; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pkxcInMdoFVAPVE96bPSNNBTSXFTOzHNu/P21a097UY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeELzYjAWd8ZLdriyhQYJHXd+TtQev2BldiRzTu
 kmFT4YKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3hAAKCRAk1otyXVSH0BylB/
 47ouGdM/lOwAbHlglb+XTRz5oert1uhDeHR9pirvo6rdzp71RulP7ywNsdt7nDNLuZG8ozMni4ITM+
 l5VMKuj2q5fdHCuuWyox+x2BWXlRBvJ78G7MowYHXDIaXB3r0vn/QcH73dkuN3qNgtXckfqjAgtLK1
 xu0CPPkHeWII0K4ExzguZtVd7tyP9pOGj0aNwRGUaEEsqM+EGRjUHbIvBlZG0Fs/79GQZ5Vduvth1F
 71qwdxRTpV+kfiMHVEcHj2g69gFP0oRfwogOFwaeExpM881QBrrW4FTSXqBdASo27xtqaYwyCHvxLT
 B6J0TbiFq+Qh4MSgc1cyinR4JA4zZi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME priorities are entirely implementation defined and Linux currently has
no support for SME priorities so we do not expose them to SME capable
guests, reporting SMIDR_EL1.SMPS as 0. This means that on a host which
supports SME priorities we need to trap writes to SMPRI_EL1 and make the
whole register RES0. For a guest that does not support SME at all the
register should instead be undefined.

If the host does not support SME priorities we could disable the trap but
since there is no reason to access SMPRI_EL1 on a system that does not
support priorities it seems more trouble than it is worth to detect and
handle this eventuality, especially given the lack of SME priority support
in the host and potential user confusion that may result if we report that
the feature is detected but do not provide any interface for it.

With the current specification and host implementation we could disable
read traps for all guests since we initialise SMPRI_EL1.Priority to 0
but for robustness when we do start implementing host support for
priorities or if more fields are added just leave the traps enabled.

Once we have physical implementations that implement SME priorities and an
understanding of how their use impacts the system we can consider exposing
the feature to guests in some form but this will require substantial study.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h |  5 +++++
 arch/arm64/kvm/sys_regs.c               | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 72982e752972..0cf4770b9d70 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -93,6 +93,11 @@ static inline void __activate_traps_hfgxtr(struct kvm_vcpu *vcpu)
 	ctxt_sys_reg(hctxt, HFGWTR_EL2) = read_sysreg_s(SYS_HFGWTR_EL2);
 
 	if (cpus_have_final_cap(ARM64_SME)) {
+		/*
+		 * We hide priorities from guests so need to trap
+		 * access to SMPRI_EL1 in order to map it to RES0
+		 * even if the guest has SME.
+		 */
 		tmp = HFGxTR_EL2_nSMPRI_EL1_MASK;
 
 		if (!vcpu_has_sme(vcpu))
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a33ad12dc3ab..b618bcab526e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -351,6 +351,18 @@ static bool access_gic_sre(struct kvm_vcpu *vcpu,
 	return true;
 }
 
+static bool access_res0(struct kvm_vcpu *vcpu,
+			struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+
+	p->regval = 0;
+
+	return true;
+}
+
 static bool trap_raz_wi(struct kvm_vcpu *vcpu,
 			struct sys_reg_params *p,
 			const struct sys_reg_desc *r)
@@ -2224,7 +2236,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 
 	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
 	{ SYS_DESC(SYS_TRFCR_EL1), undef_access },
-	{ SYS_DESC(SYS_SMPRI_EL1), undef_access },
+	{ SYS_DESC(SYS_SMPRI_EL1), .access = access_res0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_SMCR_EL1), NULL, reset_val, SMCR_EL1, 0, .visibility = sme_visibility },
 	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
 	{ SYS_DESC(SYS_TTBR1_EL1), access_vm_reg, reset_unknown, TTBR1_EL1 },

-- 
2.30.2


