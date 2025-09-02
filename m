Return-Path: <linux-kselftest+bounces-40569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897DDB3FE2D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5A12C5821
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187B2FF14A;
	Tue,  2 Sep 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eia4wU0m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEA2FE56B;
	Tue,  2 Sep 2025 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813499; cv=none; b=VQqK6jxPju1dN6h1sWNb/SQRoBYsq7MIcq3qHad04cIbtxmgFQWOOq2jKfcwXQtqTIM8tw/MZ2GR+6AMuHikq8LFDCtBSkCzSL3iUGfeeJY8SqNZ98Z3FNMPiIeYKrZPkmLpc+ZjhPlLunBscY7wgGCGAqpiPSqIT6OxejM4J28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813499; c=relaxed/simple;
	bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgqAwFMcMW6Fh1p/8JBnHUu747XqIE1Xjg857QqSro06wi3GVUxxgPrANbM0QqAYF5A0rfPQ4SD2Pepk8Ea2Y+5ehlQYCjv5ZyzQm92ZmIg7GzLIxVnCZRS3qRlVCMXUb2hPTYfbsRZ3ETq0u/CpIJ92zXh2QOSmPzxEL03irEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eia4wU0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B7AC4CEF7;
	Tue,  2 Sep 2025 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813498;
	bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eia4wU0m9xg4EvTo7aFBbY8yYebfjj5jR1h5o1hy2Jf3tRdg3i/5cnqqTe2kELgFo
	 c40Eb2ufXtdwL3Hiw/WCvLQiwu7PX2DN6ZDN2kH+q8iCCxSXSRKDr07ktwhJUCbqUa
	 vpmYEwQt4L16gcge0vbi4jaAlwXgDMNFAIrdr6m+tCJoXGK4TTmZ3eZXweJbI3g8Il
	 sDciLua1yjnYcZ2ZJzVhuFaktklIgVEgYbwKC7eijDGMKyyk3BKpsCbIM7CrnhP7yo
	 kazC8NoH53xSqsYWsW6dtzn2KfAsXPLRZTgI29kPSZwcT5Ksq6I231OCHy2Sa3y8Yy
	 twp8dc72tO55A==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:12 +0100
Subject: [PATCH v8 09/29] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-9-2cb2199c656c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiAa5JvxgG0URYLkAdE3e1wR5kq07dyBcx8i
 ynF7f4rKKyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYgAAKCRAk1otyXVSH
 0JesB/0UtIZpn6yk/kUasJvMR/f+f+jq1DUI8iOVHrDqUNrfo8I/IQ/aZIQUOacwLyD8O0lohpg
 ib5n7N2Q9AGT1GJ8IxFSPrAslVi2kaYqbPQn+qiy0E14o/TvuztarwxeGc64RMV2t0a16kwQmR6
 KLZUVyt70irxOHilX1lyc2doFOkpovMfvtAITwTZb/jfwgytDugfEG8Im9NFkr1fPCpcdj+GG1q
 YxdQzbzLtckzk57D/1FSfgQWspap4MLk/6xMNI5DFHZ2hlSt75ysY6Y6fAQYRAnoiBw+jjaUJTZ
 MwBsM5AjhilE+PdjnWauLn/H8qJs2ooJwKZo4wN5mvkDZAVC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for SME support move the macros used to access SVE state
after the feature test macros, we will need to test for SME subfeatures to
determine the size of the SME state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 50 +++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b501c2880ba2..8f48c2a488f7 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1045,31 +1045,6 @@ struct kvm_vcpu_arch {
 #define NESTED_SERROR_PENDING	__vcpu_single_flag(sflags, BIT(8))
 
 
-/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
-
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
-
-#define vcpu_sve_zcr_elx(vcpu)						\
-	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
-
-#define sve_state_size_from_vl(sve_max_vl) ({				\
-	size_t __size_ret;						\
-	unsigned int __vq;						\
-									\
-	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
-		__size_ret = 0;						\
-	} else {							\
-		__vq = sve_vq_from_vl(sve_max_vl);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
-	}								\
-									\
-	__size_ret;							\
-})
-
-#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
-
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
@@ -1105,6 +1080,31 @@ struct kvm_vcpu_arch {
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
 
+/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
+#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
+			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+
+#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
+
+#define vcpu_sve_zcr_elx(vcpu)						\
+	(unlikely(is_hyp_ctxt(vcpu)) ? ZCR_EL2 : ZCR_EL1)
+
+#define sve_state_size_from_vl(sve_max_vl) ({				\
+	size_t __size_ret;						\
+	unsigned int __vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid(sve_max_vl))) {			\
+		__size_ret = 0;						\
+	} else {							\
+		__vq = sve_vq_from_vl(sve_max_vl);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vq);			\
+	}								\
+									\
+	__size_ret;							\
+})
+
+#define vcpu_sve_state_size(vcpu) sve_state_size_from_vl((vcpu)->arch.sve_max_vl)
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently

-- 
2.39.5


