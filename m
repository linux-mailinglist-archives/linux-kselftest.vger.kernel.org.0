Return-Path: <linux-kselftest+bounces-2383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0CA81CCC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C24286D1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A924A1F;
	Fri, 22 Dec 2023 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpVAfOqe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59242CCB0;
	Fri, 22 Dec 2023 16:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67721C433C7;
	Fri, 22 Dec 2023 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262118;
	bh=1bBIjD+wbUNzAB0NuFPa7A3b8Nc97HnjasnAGnyWwgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpVAfOqeCbl/7P1gKRxRmJWiq9FzwyM3bilb9NaFxVrATv8J/regoObnBodgskudo
	 1SNoQpiluYX0qEjjcT0LZGbzeCta4pIDlzK44lapOmTjC5/2IppYYlvQafQ2hSQ4Rq
	 ZGPSnLM7HeYVnZ3Ve87sia0wmhfVn1C+dGNbAtVE2d6eNPcLhgp5k7a7bTq0je9mhp
	 USp4fzODzcCDid9bavgPLw1jSPx93qHkSkE1kURRp8mzXbsyKN4habm4qGeLQRH6Uc
	 Y234zw227b++mm+2uctQuqGu/S4KFO6FNysz902jjeAOy6DOjbSUEwOwFjErAtRgEB
	 SZYjxWc1AQ6KA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:14 +0000
Subject: [PATCH RFC v2 06/22] KVM: arm64: Make FFR restore optional in
 __sve_restore_state()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-6-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1bBIjD+wbUNzAB0NuFPa7A3b8Nc97HnjasnAGnyWwgU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbeA2Qd4QdN/9YGa9o3oh8iKknZQNHuq27PENN5I
 OBd7RrSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3gAAKCRAk1otyXVSH0IUGB/
 9WnCOTceTaBmPiLNLYCbumqKhOCbz2CbgwbNa2qIB+3lP01J12KdnBYUcCfzNmnEzGKlJyObrlPDq+
 cbp8gbESIOL0VOV1w6QalUnE+fOyI1DEcoRryCLgg/3ZOpeG2dThqKIFWTDBeSQ8eBEETCkRYRb8Ix
 SxrZqK48DmBD6Q4Eguo9u+PeG1rmPfDFSgTh2Lim4vhq2AhxVy4BV0OkwSHG56kwhpeYsyHqTTznFW
 twrHuljYQSv1D3DEBP4KTyIvyM7M+G09PGC/9D6uG9v8WjbfwrAnsXRDg7J0801MUp7lrhQlZpik/8
 39v6iHmt9FYUeGhfWogp6j3XV0x4xP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Since FFR is an optional feature of SME's streaming SVE mode in order to
support load of guest register state when SME is implemented we need to
provide callers of __sve_restore_state() access to the flag that the
sve_load macro has indicating if FFR should be loaded. Do so, simply a
matter of removing the hard coding in the asm.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h        | 2 +-
 arch/arm64/kvm/hyp/fpsimd.S             | 1 -
 arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 145ce73fc16c..7ac38ed90062 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -111,7 +111,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu);
 
 void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
-void __sve_restore_state(void *sve_pffr, u32 *fpsr);
+void __sve_restore_state(void *sve_pffr, u32 *fpsr, bool restore_ffr);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 61e6f3ba7b7d..8940954b5420 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -21,7 +21,6 @@ SYM_FUNC_START(__fpsimd_restore_state)
 SYM_FUNC_END(__fpsimd_restore_state)
 
 SYM_FUNC_START(__sve_restore_state)
-	mov	x2, #1
 	sve_load 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_restore_state)
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index f99d8af0b9af..9601212bd3ce 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -286,7 +286,7 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
 	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
 	__sve_restore_state(vcpu_sve_pffr(vcpu),
-			    &vcpu->arch.ctxt.fp_regs.fpsr);
+			    &vcpu->arch.ctxt.fp_regs.fpsr, true);
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, ZCR_EL1), SYS_ZCR);
 }
 

-- 
2.30.2


