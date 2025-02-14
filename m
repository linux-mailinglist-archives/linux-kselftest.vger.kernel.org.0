Return-Path: <linux-kselftest+bounces-26623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91FA35447
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FA8169338
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96681DF759;
	Fri, 14 Feb 2025 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePLg2gQu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1DF1DE89E;
	Fri, 14 Feb 2025 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498532; cv=none; b=tpu3zJqeefFT1R8A/JDC2vrzMIjcPek+4osaJjmxIu3zBMBNKeHSV7P1wo5a3SiVZoPAkOm9BvyBafjvYrx7rP2ZYv4aee/37269MXtF/ce+TO01Mccitj9DwEPHai3iNW35f1yft2hzKL132aRtVXeuaUOD02d46SsyvmoiQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498532; c=relaxed/simple;
	bh=hTVDnp0p6nmD43kAvlLpMQz5gcUT21vSNtNfafanNjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQQ2/ePH/PDqNl+yAncPhvJBs7MZ6jPSKlmbC2LjjmuBM8tb8wXSPGlajHwvoYE05XjZgNOVclVayKD0DIpP/2dRoRbqdutkhDhW0U9Y5+FZoF4a25vx2Gih36Tr9BoUucJKFLE7MC5QfWL53x+SCd9abRLa2Xs/8/zuR6almLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePLg2gQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9701CC4CEE8;
	Fri, 14 Feb 2025 02:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498531;
	bh=hTVDnp0p6nmD43kAvlLpMQz5gcUT21vSNtNfafanNjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ePLg2gQu1d/23ahI4SHCbAFiOWOxSSpo2p9SvZHxjTr11X9256HuK4tkbcp9JNg7W
	 mceo5hZqD2rwHroxUagmvA1KZKf/dMkS4nkDbmej80RcgygY79V8BBSvJ06ESsWjlH
	 J45nJGqL2f+3AqdKkvXh6Xsdicbuw/aU9lga+X7A0S/Ctm4WBcOojqxWiE5H6B+kUd
	 q08272WxckRA/6z98dbYdA2+t8lprgILaEGu+pI/5or6qIMUsDHSI3kmcCQ8un+yze
	 9l1g54vsIVnrPjqQNTl/h8mbpeFOM/JZqg3+BC3laVc/3EmoKqMIw11ZowU9ImEyQ7
	 /86j441616Zlw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:58:02 +0000
Subject: [PATCH v4 19/27] KVM: arm64: Provide assembly for SME state
 restore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-19-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hTVDnp0p6nmD43kAvlLpMQz5gcUT21vSNtNfafanNjA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPPqEmHRwyJlV+4taSwkW14T+B7Fla3GYl2iXUU
 d/Vh+z+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jzwAKCRAk1otyXVSH0BVyB/
 94PGxLphmD7LasFr7JLf4xmHrwfbkexncRmrlZKWhA+U8fKTy+dHyqOhsJAeU1uT6rL09lrOozq6vb
 b3pUGAZ3VCoO705G404h4QBPBi7Dlzu3aO9NdfyiJSTz+ATFeC/d1iSutGSgH0TFDYY+kVnHR4tFqF
 cTH6A8MdHa4o4H6iNGJChQsWc1ctwb2MUhaRUp6iu1dYF/lkhklXERxhqRj4LLGcxVGI2zgPL/BS/6
 TE7nKBN9b4DGJtsV/2HeHzVXwUxLb9EAymsIl60BBi/V+qLbuLa5A0TrqEISq/DQ0Brk1/N+BKXt8x
 CteX9zKpoXnpiqlyz5R7Z8mIkFCKom
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a __sme_restore_state() for the hypervisor to allow it to restore
ZA and ZT for guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h |  2 ++
 arch/arm64/kvm/hyp/fpsimd.S      | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 21943cb98542750a1b626a8de6bbc095d7770ccf..5a1f8e4be18624efa6b887f09c36f0e8ad318c40 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -113,6 +113,8 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+int __sve_get_vl(void);
+void __sme_restore_state(void const *state, bool restore_zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 6e16cbfc5df27e63732655dffea60d7039c37332..b21809adfba78522410da053fd4eccbb66484532 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -29,3 +29,19 @@ SYM_FUNC_START(__sve_save_state)
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
+
+SYM_FUNC_START(__sve_get_vl)
+	_sve_rdvl	0, 1
+	ret
+SYM_FUNC_END(__sve_get_vl)
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


