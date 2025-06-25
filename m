Return-Path: <linux-kselftest+bounces-35763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E482AE8137
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DBA17C659
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A742EBB8A;
	Wed, 25 Jun 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu+U/Gnb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F882D540A;
	Wed, 25 Jun 2025 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850760; cv=none; b=FaOiK7kYDiN945jGp1GJq46fatlOiLRY6b2mXWxi56iJNClpyNvoEFIxnv0oYhZMYcwyVJNN7VGNTFiU+4LNA/CbJJZJDn7c9GqdJfH/gQ0+AJjA9/Ybc2/GWZCHN6gKjV5KJyrg/QJBT055DJ64UYoq5zDm0U+CqixpVqxgtlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850760; c=relaxed/simple;
	bh=4WGcB0ofjwJdg4f88xsT0zg0K56yny7JB2qYbeq6hCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVys5yHkPc/N+xVlRLHkwE63XlT5oaFHLPtcj35thNd9NkmqNSGVL2zFCtmkRV/q41azljAIrhf5KStuo/0Iuj9a+GAIDi8uasmEXQ1WbF2lCvzFBKjWRVW7+kSX0KmQT35ZPp5iJL0hg5QlklT+RiGKTlVC1auw7vkV0egmM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu+U/Gnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C54C4CEEA;
	Wed, 25 Jun 2025 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850760;
	bh=4WGcB0ofjwJdg4f88xsT0zg0K56yny7JB2qYbeq6hCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uu+U/GnbMXsN1V9LPBvDiYIE5EmMiG8nijroxMl5zYBN12WuSOdhqqfyh2uQwqm6o
	 AZluv6TVp4ePFvRL3H3v/YQly6XBTCLEjU40kfDzb21+k6VguLfWLzmX/5B26g9qIX
	 9tV640VSTYaUkaL6OT5/zoPdoGwnqLUCJyhkli2CeUPjHMAB5hwRQYDQKWEmscTwMr
	 jUt6m/lirXABP78A6eKmrWQ4noCHlO4g2shyJQsLvbtsAqiZpbtJC7lMqhJqLfyXnD
	 OCyU9L4t7NeMwMIys9efyacWWZa8w/nGD+M7LHGiFbaX3AYO0QiPoy1kb8rxaAhmfn
	 gCU1orQN2vwNA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Jun 2025 11:48:11 +0100
Subject: [PATCH v6 20/28] KVM: arm64: Support userspace access to streaming
 mode Z and P registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-kvm-arm64-sme-v6-20-114cff4ffe04@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4WGcB0ofjwJdg4f88xsT0zg0K56yny7JB2qYbeq6hCY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoW9x0MiTXwe54JvG5B8qlMR10QU/S6diD1iZRe
 4FvyHlJeBeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaFvcdAAKCRAk1otyXVSH
 0OXhB/9HTj6QsvNypfEiABLURbcXrqh9HT0n1XcA7skbo1G8L399SuFiw/eiEiDLQC6X//rcMq+
 s+Jm2rq3XYeaaW/XiNPVIQU39FmvCRsZx1x6qL+K2VB6sTbdr1pWNQLeBMtPXuM+hRjYGdDO5Fb
 W3HIWbv6tYgKP2+EKFY1UXjjMCidMrkaqgbuKHRPOHNaLIYeFDDj9tLYB8I5l999DYcfFB5/6xz
 WqC6GGOMgAL3fss6lHnE3j9SrjK+0hcX7NGDDhb8jxJB+4e7KX/sl4xhuTud4z0Un5jXne+mr9r
 d/etVlvNCBd9mGVfFzP+l0CvI10NgBHg+rAbGNqQiyUxYpX7
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
index 6460bb21e01d..4ba0afa369d5 100644
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


