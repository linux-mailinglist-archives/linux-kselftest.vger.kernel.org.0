Return-Path: <linux-kselftest+bounces-35762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB1AE8136
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899333AF54A
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9792EA47F;
	Wed, 25 Jun 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY22VDLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB02D4B44;
	Wed, 25 Jun 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850757; cv=none; b=VRpp/uB/Cv5topLW8MCBa3SlWUQE9SUgfp1B8BSN6efDnY936xkaTF4Qm1WXcxjgxJ/OGUupVp/gIkltSMVv5tr3MWksHO8lM1h1IUILzAR5WiGRjtyy3WOYw++2xL8Df7xGrYTeGkdSvpxQ8OmaNoGd6/JxLZnU+vet3fX6m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850757; c=relaxed/simple;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzqthnyuKrgFKOMqWs4Byr+DN+2YC24rRwv3QMXgrzQ46dUS26eQaWHFiFRLKZJK3N1mOSBRmoXLz2pxCWXJN8RJHLhFvLN+I3PkR3zPw9pvbHsCJKncM3HeaM6Ule8na5qBc1m4coAdaR052qSIV0/f9ysFIZfAZauzpngWH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY22VDLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7912FC4CEEF;
	Wed, 25 Jun 2025 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850756;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PY22VDLX16vXlWoJqg82FzidSbxZSZQ/zWMc/Y2PnaEu+I/x8MI43lpepEGeoPbFn
	 Gpt4pJ0Ywr+4ZNgEgHckHlyBWlF39n5GqpTrRkL7+udFiBy3vzPCL1EgkGFgbUUdun
	 viqMK56oDaLxyplu64GUCp6xbw4Jw+xAtnAcp74Nj6OxGysVBxpiz+aWgEZOT1d4pR
	 0skM2Y9ksdqvO4adB/+sXnZyVA6pashTlRkMn2Xjx8t2hvq34CShKRSy3Hm3NGXFC+
	 Ig6NFLWxQgp0ixRmPcdZAleU+xXfJGVcjRThdtJpxEm1UdzqfOcjNosEaNLRbe91Ij
	 RJ+zh5ycZodqw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:10 +0100
Subject: [PATCH v6 19/28] KVM: arm64: Provide assembly for SME register
 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-19-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBoW9xzb2EdCE6yifAx/gPqICvj5yste5bd/lFou
 7j4md37uOGJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvccwAKCRAk1otyXVSH
 0PPDB/iUC2Yh9mfw7LpaOYoz1WFoFbpddeaTif98sHHYHnWVlCtA86ezxkkYgaxYh25Xs6uGA6S
 dzHsX93IBBjPF3jlddlPn9YtgYkJ8Px6x4NY5Enc5IOwD7kSb41VcbruZTWZf1ojVyz5HdOSP3k
 XIqIL+UG555qGukNXVgM8Q32Pw/o6zUpyRb+xaMJXQmiqxhM3kwLx+50Zvf/pWA7j/F3J9el1Br
 V5J4WBpm+t7Ukzmj7uo7fHZrp8zY3uYzFgIy5rS715TKYbB0oaHar/tAB9hFL7e7lgdWXQZzV9M
 dmViubMmc1ALyKWNjjuoyu9M0Q9OKhIlmhDQpau6IpyJX0c=
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
index 0ad5a66e0d25..1c31d8b26aa9 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -115,6 +115,9 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
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
2.39.5


