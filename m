Return-Path: <linux-kselftest+bounces-47889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 626A6CD7A84
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2851C30391A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C33161A4;
	Tue, 23 Dec 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZraqkfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2C314D2C;
	Tue, 23 Dec 2025 01:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452977; cv=none; b=GQw6f86fNSSntVSzwiITA3gLTRjF8A1fmTFWt4BDpVgH1v1sRg4UudqhGHA8h316JzB0nPhsYWN8m/pXAr+GzaRGDy8rZtXc6wPnkhe+DIM8k6cE4DlG0Y7Qlsz6H8I/Nvz48kB4l71B2nfyb2U2i++DVU/mmXlc1LyW7fsDj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452977; c=relaxed/simple;
	bh=QalGDOMHjOiQjvBbbedaaYeF4HQ2DEwgjsr/uOC9S0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H5qaiRi7PBIplg6otOZvpUYn02uKyNaCvnhbBH6yknDcSF5rsMIx4PJHTRiOntfSVusIYB1ZAPmggKcPD0kn7nlokHmBZ1XlvRBej0pQwEp5FM5YzhgN5ttfZ3qvHLVhpvgXWpv9GPwNTvGtjaDYea8cGZ7RB8xnl5bxdmtHplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZraqkfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F451C19422;
	Tue, 23 Dec 2025 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452977;
	bh=QalGDOMHjOiQjvBbbedaaYeF4HQ2DEwgjsr/uOC9S0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DZraqkfX93bL3Xevfi+qsnXNb9OcIWXRZQqAiD/HWbASFR2KJ7RdKD1rEv7n7MbM1
	 VQaiOHb+FuPb2T/w8k0YpWl1k0JSjS+jIv7aPB0q0msMJ3/uEwTG1fCHrKViOkXZ3w
	 PwgG97CyAeYu9nxQjl6JuX6xjRH4n4qLAVvp+duMIaUe/3QQ0nW4ICDp7iBtJocvFF
	 lhQxOM96DR/WzMJ49v1HYaqDuuZFE8hLF+NuEyxowNv1tG8D6zppzXmyZsUMKL2ysz
	 MCkgjGZuzUMIvqVx0ikJ1gUxPFcGAPu9JhKsl/8mKULjtNs8dpS1wXUvsIZpBanlwK
	 Vt/tO9EKzucgg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:13 +0000
Subject: [PATCH v9 19/30] KVM: arm64: Provide assembly for SME register
 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-19-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QalGDOMHjOiQjvBbbedaaYeF4HQ2DEwgjsr/uOC9S0E=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6Rm6UAk60DHDfEFq1PtHTHsczXqVLJt7lIW
 mXsBgcMvg2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnukQAKCRAk1otyXVSH
 0IcHB/42RHGmQOW7bcb0Ca/kXpI+DpixoJ3o82LwO+zziSgSoIRMBGxX2S3DE8strN3QI33ylPX
 HvYQ0PrSI7IyZa9DMk2bIQzKIOKyg2tDb9maQm6iPGySwTUIKxmMM4Io3f8cY7+mz/KAL+5NnfL
 o+XpSaXuu9W1cqk10ObSgPh+ohdHbOkP2Sl10iVeEITpcgUEDtmeW9aBkeUSAccNqbyrBRSHSGk
 MjvN4/GST/Ef9J/mFebLrus44Zo6fFqTIgURWE8DwoMiogYmpMjGAOlaMLEYI/E3PUTjXxl1XC0
 jZphq6h63+BpNT4S0/vSe2f4sYCVmZimpIx8Q709gUoNRcWs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide versions of the SME state save and restore functions for the
hypervisor to allow it to restore ZA and ZT for guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h |  3 +++
 arch/arm64/kvm/hyp/fpsimd.S      | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 0317790dd3b7..1cef9991d238 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -116,6 +116,9 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+int __sve_get_vl(void);
+void __sme_save_state(void const *state, bool restore_zt);
+void __sme_restore_state(void const *state, bool restore_zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 6e16cbfc5df2..44a1b0a483da 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -29,3 +29,29 @@ SYM_FUNC_START(__sve_save_state)
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
+
+SYM_FUNC_START(__sve_get_vl)
+	_sve_rdvl	0, 1
+	ret
+SYM_FUNC_END(__sve_get_vl)
+
+SYM_FUNC_START(__sme_save_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_str_zt 0
+1:
+	ret
+SYM_FUNC_END(__sme_save_state)
+
+SYM_FUNC_START(__sme_restore_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za	0, x2, 12	// Leaves x0 pointing to end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+
+1:
+	ret
+SYM_FUNC_END(__sme_restore_state)

-- 
2.47.3


