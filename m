Return-Path: <linux-kselftest+bounces-26609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB57A3540D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 03:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B1B1890841
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A11547F2;
	Fri, 14 Feb 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzBV85hb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2B12B17C;
	Fri, 14 Feb 2025 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498479; cv=none; b=nz6oPITe7g0DFJfUg8uDWxB8a3dx69J2bXsNm+Rvn8CtQy08yvJedphxJL1R7nBGEMdaYKpJ54dUvh1UsahxrZW2Fd0Pyzd+rUDUvZXlVdCARhSXs60JXbTUVFL6bM3kplj5ak3ux0kmJCWBRzHvnOSlCbj0PoMD2nlnw8Yat8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498479; c=relaxed/simple;
	bh=3PQifWZa0PYzxsXTtYT3uqYK+qICLHgWCa2IqwMJGYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/zKjl9TSkhHUbWeyuMCZEZbs+3xbFyL20z6uBySyicHUWSS+QuYaRkqtCJ4QMIYLo8tBaMsLSt2K3tEMgo3/58pkS2elCKcwR+GRlNQvO/HO3c+2oEAzmubYX7/x7kYFv5xPXBEnNYQXf+i51lkpLzCslmLH6ymA7wU2UsHYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzBV85hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6129EC4CED1;
	Fri, 14 Feb 2025 02:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739498479;
	bh=3PQifWZa0PYzxsXTtYT3uqYK+qICLHgWCa2IqwMJGYI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jzBV85hbxeD88bGgqVz/W8uuHG/uvPe4kuWarE+38Oq82dsMUNSwtlEj6A0taOsG8
	 k4YZebjgAB98FHJU8CnRKLBe9MFgtkCa11zm5/BtEQKxMjH9FQZaGkFh03Y+EnRKp0
	 WAdtdDQ3Gt31mfyqB6jhPgwuBfUsTK9DBKEThDSmTZH3pYpNAZmLsRv3enC3HtW9EO
	 lOl0MVhWSgmZvJaR95/dpDF1JjJf5d8NoxVD6iOkOk+0n5n10Sn8Wcxngmv8a678In
	 u2t6tTS8n0Hj9XVPV4ivDUAZxvjRbwsHsKqmVuoO7DRoOryJcpwXqWbWojfkhJ8sL+
	 vKqpNlBFElZkg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Feb 2025 01:57:48 +0000
Subject: [PATCH v4 05/27] KVM: arm64: Introduce non-UNDEF FGT control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-kvm-arm64-sme-v4-5-d64a681adcc2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3PQifWZa0PYzxsXTtYT3uqYK+qICLHgWCa2IqwMJGYI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnrqPEnFldtuIWxcKKrLml22ik1aL0J2nPamYq3D8M
 bIdk56qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ66jxAAKCRAk1otyXVSH0K1aB/
 4t3+9jnwdck95RN7cJPA29m7VB8XNVNBH7EtfLO6PAzqjz7YMptZ6PJ2ceu5gO8JaXh2oQy7xe/clC
 G05wYyaIwOzkWIzP01yKpIs+BHtkTP2taZBfzFaGmI90aTBC9EgOUMy9vD/9UDliG6NZFYU9Qv8gUC
 o3mq+fciqKvLtYvDls8jrQQCh9i/Z8KBmcKyjlBV4pe/vLoNOzTyf7cz6ZFAUsu8eU2U3XMV0qk6Nt
 RAGPr3OaTzIl8Eu9d7bxgMzmgOeSoPiesFrDx89cepZ9zPpqNTA0RarQTia9eem07otBf/ieM8DtaW
 ZCiGLzwtJeqS10OXuju9M55meoz6Nj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We have support for determining a set of fine grained traps to enable for
the guest which is tied to the support for injecting UNDEFs for undefined
features. This means that we can't use the mechanism for system registers
which should be present but need emulation, such as SMPRI_EL1 which should
be accessible when SME is present but if SME priority support is absent
SMPRI_EL1.Priority should be RAZ.

Add an additional set of fine grained traps fgt, mirroring the existing fgu
array. We use the same format where we always set the bit for the trap in
the array as for FGU. This makes it clear what is being explicitly managed
and keeps the code consistent.

We do not convert the handling of ARM_WORKAROUND_AMPERE_ACO3_CPU_38 to this
mechanism since this only enables a write trap and when implementing the
existing UNDEF that we would share the read and write trap enablement (this
being the overwhelmingly common case).

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h       | 6 ++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h | 7 ++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index c77acc99045764cf5230f84ef5c9f8432c7d983e..64f2885cd4a87e9807fbbbbe6de937ed304ab917 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -289,6 +289,12 @@ struct kvm_arch {
 	 */
 	u64 fgu[__NR_FGT_GROUP_IDS__];
 
+	/*
+	 * Additional FGTs to enable for the guests, eg. for emulated
+	 * registers,
+	 */
+	u64 fgt[__NR_FGT_GROUP_IDS__];
+
 	/*
 	 * Stage 2 paging state for VMs with nested S2 using a virtual
 	 * VMID.
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index f5e882a358e2d6e6805d112ed646a112455012e8..c24e418cec101433f7484eb4f7af788c474eda3a 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -98,9 +98,9 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		id;							\
 	})
 
-#define compute_undef_clr_set(vcpu, kvm, reg, clr, set)			\
+#define compute_trap_clr_set(vcpu, kvm, trap, reg, clr, set)		\
 	do {								\
-		u64 hfg = kvm->arch.fgu[reg_to_fgt_group_id(reg)];	\
+		u64 hfg = kvm->arch.trap[reg_to_fgt_group_id(reg)];	\
 		set |= hfg & __ ## reg ## _MASK;			\
 		clr |= hfg & __ ## reg ## _nMASK; 			\
 	} while(0)
@@ -113,7 +113,8 @@ static inline void __activate_traps_fpsimd32(struct kvm_vcpu *vcpu)
 		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))		\
 			compute_clr_set(vcpu, reg, c, s);		\
 									\
-		compute_undef_clr_set(vcpu, kvm, reg, c, s);		\
+		compute_trap_clr_set(vcpu, kvm, fgu, reg, c, s);	\
+		compute_trap_clr_set(vcpu, kvm, fgt, reg, c, s);	\
 									\
 		s |= set;						\
 		c |= clr;						\

-- 
2.39.5


