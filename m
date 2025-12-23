Return-Path: <linux-kselftest+bounces-47890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E4CD7C04
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477B7301E201
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889673168F5;
	Tue, 23 Dec 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCTZmnx9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA7226861;
	Tue, 23 Dec 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452983; cv=none; b=UiBByHCoEgDtMtgUPUUFFJhiqko24fkbH5RaEc6weaF9mypRED6FGNwDaRMtoNOoUXvbBj4h7iJOowoV9UNw1QCBQSXn7ZSm6UYmfy0MOemt51i8f11mxc4s0fwfpop/8djw0ajfP/yhZhuZLCuMtMond8jW7B6HGJXHf3AIweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452983; c=relaxed/simple;
	bh=5CD2kezQ6SpAVTOAH8KYe/eAD1gblCRSlCxfRkHq8xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUTgAYLGa1m6XOkFr6uiE5xqAMkrs5S4oWYB9EA1/SxufD3rjZYcK7MQLBaCYkGvv8wWP0CWmL08Ahw4DaXpOvyWvAxTOX+avuCAWJes95tp4BOAZCqP0nR0O4giQuwavzqw+PidsdUqm7scp0txSWZgreegnJ5TL7m+W2qqO/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCTZmnx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCA5C4CEF1;
	Tue, 23 Dec 2025 01:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452981;
	bh=5CD2kezQ6SpAVTOAH8KYe/eAD1gblCRSlCxfRkHq8xI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uCTZmnx9aCTmqL8Rwj9CihWkcibN1XaEzHxveOeofpumWXUBdidWG2uwUAJ5dz9P6
	 UDlo0vNBWNeqAonw2mfGncBMQrQ/T0QLCqaVRcnT8/j8ncZTH6IAZDopniZg0Ev5QB
	 YTU4E3tDXpXLh5g/8hu3qek+Fcb3/eNZ6UkQGfPRxbzhrnHTDEdnHoqvV/kvzNrj68
	 ieivFe713XCS7hCd1zVY7vgdsWSwelreQORnoi+MNjaW5KP1TisLG8E5YAEtgK7s5z
	 gm6OSaMQWmJb5zwr1MhdPWwW4f2g3LWGRAQBJuv8K7Rgf9iNwLo8kj27NpctW8ZDD8
	 5WS2gjvn1Y53Q==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:14 +0000
Subject: [PATCH v9 20/30] KVM: arm64: Support userspace access to streaming
 mode Z and P registers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-20-8be3867cb883@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5CD2kezQ6SpAVTOAH8KYe/eAD1gblCRSlCxfRkHq8xI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6SUpQflFwr9SQLhBCXc+4i5w7JdURtxBUT9
 pJtomD9iceJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnukgAKCRAk1otyXVSH
 0AnOB/4gTVoWXX9f4wpyus3+8f8KTtQoifdjwFi7nartT7KoGuA4iVlcOAyPjugPqsa5jcxDLod
 6KHj2dXVHOI7FDMa8R7z+Y2+5ny0+cJytVlx22mdnqbpqcWK1Z7uHw4f80cgPY4YcNvCRyAoi2Z
 5ctl8JRBWb6if2POD+oGmzOHNxH3KCEK4qftlJfK9/pyjV8+5xs7d/VAQTXL+B5bmPQKYpzXz+4
 5dQe6xlb0etp7B4VYLIwKBbeEDPuQBDY52BgSqJrEkKa0EYoKM5X8WT7XkqowrVqhfrf70odYVj
 /MWkSwt8dXYH5h6wEFbA2GDAtQFbW+t9UKyJwIrze6uqKL8L
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
index 2a1fdcb0ec49..90dcacb35f01 100644
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
2.47.3


