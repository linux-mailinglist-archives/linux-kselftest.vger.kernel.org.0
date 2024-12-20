Return-Path: <linux-kselftest+bounces-23676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3ED9F9704
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA43E16D409
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F0221D86;
	Fri, 20 Dec 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1dx1hu+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509D221468;
	Fri, 20 Dec 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713492; cv=none; b=eRMDj+LLg9gOcl0kSluhg/TilK0dXsdGd1jDmv4TpqM1CMSQsWiUx8Ez5KqBDvQmvJq5PwHkFiT1ESTfC/l2Hrx1xXeTEPfX2zPl51lkv+4xAficRngbMKsmHKu5uBW9V1pGsMAHMA57w03kg9vhIN8ZQPCRHCZl/SkqI8pMnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713492; c=relaxed/simple;
	bh=2lAEiIWK9uzi24UbNru8zKCgLUdInhjJdDB12WbDPZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWMuzw3OTRVnV3fyS/H/j575tpaInN+KgMcKOTHRrQQF6YVXqy4hOgagyKg9HJLgM+B72VNyNB2m0U199OzLVbrvqW86xZjDEzIrSrLO7Xjg9hzR3YMz7UafHlf/Qjgos7qd2Vm7v18T9RFlBEfRTcIT3VbkXiyEceSfEi/S4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1dx1hu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCE2C4CECD;
	Fri, 20 Dec 2024 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713491;
	bh=2lAEiIWK9uzi24UbNru8zKCgLUdInhjJdDB12WbDPZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q1dx1hu+4QMc1mfXYgXW5GgGjr1mUzSxYFJgffUwtQmrpsnMXNfGgX8nb11rLLwX4
	 XrwGngKrIFIqsSMFXDHY+DeRYIkvUBxaj7lXGhbESDULbxOFuJP0m2annSQVOaftr6
	 /hnel/AIzS9qfRWSdb0e4LywnwIeogj15u6skZCozHsnbFB5upp0FdfsQid551iBVv
	 ky5aO+ca1oyoNRVkh/T5eu+O8F05tYl87lh8vFqxq6K0e7UrRwyXM2ZgMSmsnPk+vo
	 pmvCYRSDeBpeitZMZfu1C9xvwuRxmh4cksqhwFjs/SPBxZsVfkHIGZM4QyMOJKKLWx
	 V7AuoSMAXwjfg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:34 +0000
Subject: [PATCH RFC v3 09/27] KVM: arm64: Factor SVE guest exit handling
 out into a function
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-9-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3607; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2lAEiIWK9uzi24UbNru8zKCgLUdInhjJdDB12WbDPZ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBb/PNHOdXC2QqIWTml92xipzWpK0C3H1dFAHdq
 34bDHjSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgWwAKCRAk1otyXVSH0H5LB/
 47krYQyM/wfFiJzoZcaTezF83TBLhU5DbVnNlFyU3Egm70Ppq11143hsfCVTZd8BQ1p+1iWtkpMWVq
 1BVFdSxpQEeZ8bEmA/oTGLpm+MY3fKmHWviByjr1N6GedW9hPQcxyxVvtZhzu2slXSjRD3RMMYM3PT
 p61lT89WeRN/AIS3wtwEgYzqigpqu8Hlrv3dUDKYf5HnxmOmqdMd/rfu4Scw1D2z9ZnnO7SFSYzXKU
 sBXgBW2jIfIRcfTw5ro3Xe4PuKHVUV5bdAl/5/QzwuPwFRSanXJRr4Wo+zAZtyt324t5mz8Sc8N1E/
 9/cg7CYQeavXMq0CfnAD5jwEHozx9w
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The SVE portion of kvm_vcpu_put() is quite large, especially given the
comments required.  When we add similar handling for SME the function
will get even larger, in order to keep things managable factor the SVE
portion out of the main kvm_vcpu_put().

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/fpsimd.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 09b65abaf9db60cc57dbc554ad2108a80c2dc46b..3c2e0b96877ac5b4f3b9d8dfa38975f11b74b60d 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -151,6 +151,41 @@ void kvm_arch_vcpu_ctxsync_fp(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void kvm_vcpu_put_sve(struct kvm_vcpu *vcpu)
+{
+	u64 zcr;
+
+	if (!vcpu_has_sve(vcpu))
+		return;
+
+	zcr = read_sysreg_el1(SYS_ZCR);
+
+	/*
+	 * If the vCPU is in the hyp context then ZCR_EL1 is loaded
+	 * with its vEL2 counterpart.
+	 */
+	__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
+
+	/*
+	 * Restore the VL that was saved when bound to the CPU, which
+	 * is the maximum VL for the guest. Because the layout of the
+	 * data when saving the sve state depends on the VL, we need
+	 * to use a consistent (i.e., the maximum) VL.  Note that this
+	 * means that at guest exit ZCR_EL1 is not necessarily the
+	 * same as on guest entry.
+	 *
+	 * ZCR_EL2 holds the guest hypervisor's VL when running a
+	 * nested guest, which could be smaller than the max for the
+	 * vCPU. Similar to above, we first need to switch to a VL
+	 * consistent with the layout of the vCPU's SVE state. KVM
+	 * support for NV implies VHE, so using the ZCR_EL1 alias is
+	 * safe.
+	 */
+	if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
+		sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
+				       SYS_ZCR_EL1);
+}
+
 /*
  * Write back the vcpu FPSIMD regs if they are dirty, and invalidate the
  * cpu FPSIMD regs so that they can't be spuriously reused if this vcpu
@@ -179,38 +214,10 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 	}
 
 	if (guest_owns_fp_regs()) {
-		if (vcpu_has_sve(vcpu)) {
-			u64 zcr = read_sysreg_el1(SYS_ZCR);
-
-			/*
-			 * If the vCPU is in the hyp context then ZCR_EL1 is
-			 * loaded with its vEL2 counterpart.
-			 */
-			__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
-
-			/*
-			 * Restore the VL that was saved when bound to the CPU,
-			 * which is the maximum VL for the guest. Because the
-			 * layout of the data when saving the sve state depends
-			 * on the VL, we need to use a consistent (i.e., the
-			 * maximum) VL.
-			 * Note that this means that at guest exit ZCR_EL1 is
-			 * not necessarily the same as on guest entry.
-			 *
-			 * ZCR_EL2 holds the guest hypervisor's VL when running
-			 * a nested guest, which could be smaller than the
-			 * max for the vCPU. Similar to above, we first need to
-			 * switch to a VL consistent with the layout of the
-			 * vCPU's SVE state. KVM support for NV implies VHE, so
-			 * using the ZCR_EL1 alias is safe.
-			 */
-			if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
+		kvm_vcpu_put_sve(vcpu);
 
 		/*
-		 * Flush (save and invalidate) the fpsimd/sve state so that if
+		 * Flush (save and invalidate) the FP state so that if
 		 * the host tries to use fpsimd/sve, it's not using stale data
 		 * from the guest.
 		 *

-- 
2.39.5


