Return-Path: <linux-kselftest+bounces-40581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47233B3FE7B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAEA2C5E9F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA0307490;
	Tue,  2 Sep 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc3K9+Fy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89E2FC874;
	Tue,  2 Sep 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813555; cv=none; b=OgiKjz3dpou8YgctlRKe0CzJxJde9Pdh29rhncPhiZvnpZ4IoY3EnCqjtzJwwRwf3tjFpJkUrWSg9Yr7FUVhIbxXRLQ35THfEukB3GKCQAG3nEo4+sEUXuepRX0+OniG+dt45rnWfQswfN9sd8qXbf5/yHK0me7GGGhA5cFJLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813555; c=relaxed/simple;
	bh=00XRQFjc7Pzb86pKVTknY1kmQGmcMmO43+orrAnZ8z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hc3ivBCvp88WOVlB6ulvNV1oSsT22wKtOyQtCsnNIKMY8AZ2w8WgCMOpRfD6/HC/2eKsdDA62THRIhYuoNtpN7TmF0QWYN6cuU1fNaHJR/RmZUAkIQpl56T2VpxxipYU3+LR19Lrbf0sDSAayYnsMRx51kuiphvjBO6T1fbwP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc3K9+Fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FFDC4CEED;
	Tue,  2 Sep 2025 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813555;
	bh=00XRQFjc7Pzb86pKVTknY1kmQGmcMmO43+orrAnZ8z0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bc3K9+Fy8PnmzG/5c1f8roAtthQakNkGu0n7K46iCpBr8qi1fuL5ShIFxbtrFmkZb
	 DnQw4KkdcUIl+fKeGK/XT20uixb05sE8sySDll797XIGvU8pjgIW5kP+ZBde0DEnDb
	 EO5GN1gaf/h8/CA/5GKGZrqR6KXEIY4ByvxIXUasSLqr3DM74ngUaj6pmNdrYHm5nN
	 Y9Itpi/D6o1sw7esljE+Hs7LWdBjchmPnGY0BKhbulTe0ZCO7DpancSn4sIHLI/Yb1
	 tShYzo1VXUYoc0bNZXACksc7gn8wDeodpqH66iOizGgv9gWyqF9+LPYbLXXK18a0S0
	 Eg1H3pm/ZeNxw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:24 +0100
Subject: [PATCH v8 21/29] KVM: arm64: Support userspace access to streaming
 mode Z and P registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-21-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=broonie@kernel.org;
 h=from:subject:message-id; bh=00XRQFjc7Pzb86pKVTknY1kmQGmcMmO43+orrAnZ8z0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiKrgNjNlnrrVsEXG1Jj2vvs1ae3X06tYQ09
 nDAX7lLn6yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYigAKCRAk1otyXVSH
 0P3IB/oD2Yx6x2B28OALAcF4QgCyoYTG5z+lM940bUezYR1iqHzbfwEirXY3b9SQrlC9b4w72dQ
 +OGfu3iu6GCcggVpHW5tspk4frkaCHVSB+nddgxBQADfp7aOrvtG3IjfQCPj1WKgeOy24KBdRN+
 StzFm0mfmv5G5a4jVXZEZdAgL0SisARDbkQfdBejtTlCZY3CkMf7w7ECbBZF4HHJnuKSu27lkSA
 ZMh2eT3Lpb2Fz59RLMcYhL0aODJ6PFCcsWF5tqKAVptaM3MaCU++Xm/LPdSaNGpBaQqgYCpCfrM
 SUCDnMCMgwzOWUqvHpRySY+OwSpm/3DMamXFcM8FiM5pudIb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME introduces a mode called streaming mode where the Z, P and optionally
FFR registers can be accessed using the SVE instructions but with the SME
vector length. Reflect this in the ABI for accessing the guest registers by
making the vector length for the vcpu reflect the vector length that would
be seen by the guest were it running, using the SME vector length when the
guest is configured for streaming mode.

Since SME may be present without SVE we also update the existing checks for
access to the Z, P and V registers to check for either SVE or streaming
mode. When not in streaming mode the guest floating point state may be
accessed via the V registers.

Any VMM that supports SME must be aware of the need to configure streaming
mode prior to writing the floating point registers that this creates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/guest.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index bcb0d565f1a4..013d66febf10 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -73,6 +73,11 @@ static u64 core_reg_offset_from_id(u64 id)
 	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
 }
 
+static bool vcpu_has_sve_regs(const struct kvm_vcpu *vcpu)
+{
+	return vcpu_has_sve(vcpu) || vcpu_in_streaming_mode(vcpu);
+}
+
 static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
 {
 	int size;
@@ -110,9 +115,10 @@ static int core_reg_size_from_offset(const struct kvm_vcpu *vcpu, u64 off)
 	/*
 	 * The KVM_REG_ARM64_SVE regs must be used instead of
 	 * KVM_REG_ARM_CORE for accessing the FPSIMD V-registers on
-	 * SVE-enabled vcpus:
+	 * SVE-enabled vcpus or when a SME enabled vcpu is in
+	 * streaming mode:
 	 */
-	if (vcpu_has_sve(vcpu) && core_reg_offset_is_vreg(off))
+	if (vcpu_has_sve_regs(vcpu) && core_reg_offset_is_vreg(off))
 		return -EINVAL;
 
 	return size;
@@ -426,6 +432,24 @@ struct vec_state_reg_region {
 	unsigned int upad;	/* extra trailing padding in user memory */
 };
 
+/*
+ * We represent the Z and P registers to userspace using either the
+ * SVE or SME vector length, depending on which features the guest has
+ * and if the guest is in streaming mode.
+ */
+static unsigned int vcpu_sve_cur_vq(struct kvm_vcpu *vcpu)
+{
+	unsigned int vq = 0;
+
+	if (vcpu_has_sve(vcpu))
+		vq = vcpu_sve_max_vq(vcpu);
+
+	if (vcpu_in_streaming_mode(vcpu))
+		vq = vcpu_sme_max_vq(vcpu);
+
+	return vq;
+}
+
 /*
  * Validate SVE register ID and get sanitised bounds for user/kernel SVE
  * register copy
@@ -466,7 +490,7 @@ static int sve_reg_to_region(struct vec_state_reg_region *region,
 		if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
 			return -ENOENT;
 
-		vq = vcpu_sve_max_vq(vcpu);
+		vq = vcpu_sve_cur_vq(vcpu);
 
 		reqoffset = SVE_SIG_ZREG_OFFSET(vq, reg_num) -
 				SVE_SIG_REGS_OFFSET;
@@ -476,7 +500,7 @@ static int sve_reg_to_region(struct vec_state_reg_region *region,
 		if (!vcpu_has_sve(vcpu) || (reg->id & SVE_REG_SLICE_MASK) > 0)
 			return -ENOENT;
 
-		vq = vcpu_sve_max_vq(vcpu);
+		vq = vcpu_sve_cur_vq(vcpu);
 
 		reqoffset = SVE_SIG_PREG_OFFSET(vq, reg_num) -
 				SVE_SIG_REGS_OFFSET;
@@ -515,6 +539,9 @@ static int get_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu))
 		return -EPERM;
 
+	if (!vcpu_has_sve_regs(vcpu))
+		return -EBUSY;
+
 	if (copy_to_user(uptr, vcpu->arch.sve_state + region.koffset,
 			 region.klen) ||
 	    clear_user(uptr + region.klen, region.upad))
@@ -541,6 +568,9 @@ static int set_sve_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (!kvm_arm_vcpu_vec_finalized(vcpu))
 		return -EPERM;
 
+	if (!vcpu_has_sve_regs(vcpu))
+		return -EBUSY;
+
 	if (copy_from_user(vcpu->arch.sve_state + region.koffset, uptr,
 			   region.klen))
 		return -EFAULT;

-- 
2.39.5


