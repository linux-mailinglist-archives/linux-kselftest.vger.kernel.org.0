Return-Path: <linux-kselftest+bounces-23672-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D8E9F96FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA30B188A04B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED2B21B182;
	Fri, 20 Dec 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y579vi1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89921A931;
	Fri, 20 Dec 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713475; cv=none; b=gZvCaNqGNRnY4bCln2q7ym5MmYLmVBcrDXj7YO1ReXsebw+LTNG9+rXR1KpoDuoCosoV+Cwn2dSCvEXc1Wk6a7mb+qvwToE+2e9OSZR//k4+EUwlJS7j3tdNz39MNPSRkb5GI8gvxoJuu+mV+0PwaTFHwypqEVypJpH0GF3KO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713475; c=relaxed/simple;
	bh=phaIeng1WiDU914WINDJrAI0+xgwAcLxe8d8S1huhjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EGKiG8xYEh8FsxYjKf3i0mGCUGMPki6p1ENKVTII04Lehs1yICht6bTUfpM9brZe5+66RUn+5S8cPpvv3L5o+Gy/JDZ/BsEGuMsWIP8PuqGlK8cLWmOobR8kXHS0HjvZaKhdge9YRCkz9jMm0Jyajn9JIEZrApd7WMkBThAGdqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y579vi1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29C9C4CECD;
	Fri, 20 Dec 2024 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713474;
	bh=phaIeng1WiDU914WINDJrAI0+xgwAcLxe8d8S1huhjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y579vi1Siyxesfo001+xeaEan2VSDLQZ9byAjEVwNhCPhi4w7RBfGWzT/7ITaLy0e
	 rTP8ObslcZNaKQu1/iMRhRLBGCpbDrMkOwF0y1Hq/0QSIWjeIlGq376oxgH9ByHfGU
	 nnyHmSQ5IcpzB/P7d3nyvVytEjnuqn4zap5/ILeIAlP2h6rSVIldsvW4QfADqJFEab
	 mOXC4BBpmbCCepnGBv8ImV59Wh1q3vlvWfeWlfa3XxrSBB1JfsN70Mh+r7w/AmVgLT
	 kqgHf43tUXcvD4nB3CWpAoF7+HkvYVGzMsvPCZ/PFacDNCum3yHMf4XUnGkNsIitWi
	 LxH1Bc/xtXi9g==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:30 +0000
Subject: [PATCH RFC v3 05/27] KVM: arm64: Introduce non-UNDEF FGT control
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-5-05b018c1ffeb@kernel.org>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
In-Reply-To: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2905; i=broonie@kernel.org;
 h=from:subject:message-id; bh=phaIeng1WiDU914WINDJrAI0+xgwAcLxe8d8S1huhjs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBYrQCW+zfkM01sqaOmib9a+ea/2zSO7p87v75U
 yigA7fOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgWAAKCRAk1otyXVSH0LtUB/
 9mLPR4Y7kByGjFjEVoh3AjCUjU6X4Sugn+ucmuPfz/9zXw1Ws2WqNmt9lVj4D3OAQAjNHAE2tFHxKK
 SDPcK7rQjxyKA7OgE64Um0DRYlGSFoFW0/Os0jgToloBTUMXiK3tzA5LU+raz9MfA+dLiA4PjcfXjn
 x3wcUxnX0aBklwYBtK0TGvrqKrWuzAG6w1mbFiLFbIQbQuDMWXWknV9uswR7ySE+pSawQdiNB0r4zT
 03ubmpq7Bi/gc1NGs7KcBiIiCNljl2Am+IP6HW/IQcv+IAbUvNOrBTDqHx+Dq34IwOZ0j8V0aD5qqc
 x6RGwPTwPObRuJx6Z4pA2lxBzJ+5zG
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
index 7ba742b9067e0216a156eebb3e5ea6bb69239a44..fca81ede6140c0ee7d03cb6ca8f5eead45b87033 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -288,6 +288,12 @@ struct kvm_arch {
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
index 34f53707892dfe7bba41620e7adb65f1f8376018..247dfadcdb22e1ef96f92a9d86e66c9eefb44600 100644
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


