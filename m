Return-Path: <linux-kselftest+bounces-2380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F881CCB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363A01C22685
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EB24207;
	Fri, 22 Dec 2023 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGuixk69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7328E20;
	Fri, 22 Dec 2023 16:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB73CC433CB;
	Fri, 22 Dec 2023 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262108;
	bh=ZtZ1LHxkQBwkru32zakiu6uJd1bE7cUbNK+DJb/+7SU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vGuixk69WOFDiu8VlGCBB1JtAUHME1Jj1lcf/E4cUufHEIXA9U6sCsq+gc03d/uUW
	 U7tkrnnfVzMk99eQA5FEeoLb+zkNUhYDUwQ8VZoA24yj9KUdEtrHSmxopeJjX+Eu7Q
	 cKP+K+zesfzLvw6UCd+qO5iS8DOLHWOQ4C42R7GR2S3mve9RQTD0RiqFY5Jf9fQg/s
	 njQ/dbCtzOmaVjuwxVOWK8k2sXNvZcRoQcQAl4h84jFwj1Lb6Ixw4++SeP25KH19t1
	 8SsuacoW7ny/VgsXCVD5BzvEzSVE49DAFZIKhKM1R+UjSvfVhuKUhfB7QfMX528z/Q
	 Ro4rlSQvuyBaw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:11 +0000
Subject: [PATCH RFC v2 03/22] KVM: arm64: Move SVE state access macros
 after feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-3-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2365; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZtZ1LHxkQBwkru32zakiu6uJd1bE7cUbNK+DJb/+7SU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlhbd+0Z57IVsvcnnybZmjgRmcCOdBAeP9vErIMUwN
 w/fR4NiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZYW3fgAKCRAk1otyXVSH0LYxB/
 wITHMtvBygmBm+cG+t50GLt/Xdd92S+eEl1AZk33Ts4xUewIyCL4W/dG5afgX8AEftqt1PbE80ZiVN
 82/TQRbHr52TKzhXBSAMKpKwTgodKaLZKhpXQkULoBafMAhVstxQImFlIxqOZJmY5oFTY8gZJVn7R8
 DRLzumd8nHaNaQgg49KSkujaHs2U3AOXrbMa61KXP4UWaqu5t+WvsmLZLvwLy7tz9D47MVHYo/p46f
 UcT5KmSLNHamgR/oEitXgQt4fiqFtFvMkoEqbMDzNgUicDktl2IxloWM68AgThs9hfbB5lqJ5bzjwP
 aQLZuhO7d4onojLqAImLkAgsqTi09g
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for SME support move the macros used to access SVE state
after the feature test macros, we will need to test for SME subfeatures to
determine the size of the SME state.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 824f29f04916..9180713a2f9b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -772,26 +772,6 @@ struct kvm_vcpu_arch {
 #define IN_WFI			__vcpu_single_flag(sflags, BIT(7))
 
 
-/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
-#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
-			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
-
-#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
-
-#define vcpu_sve_state_size(vcpu) ({					\
-	size_t __size_ret;						\
-	unsigned int __vcpu_vq;						\
-									\
-	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
-		__size_ret = 0;						\
-	} else {							\
-		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
-		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
-	}								\
-									\
-	__size_ret;							\
-})
-
 #define KVM_GUESTDBG_VALID_MASK (KVM_GUESTDBG_ENABLE | \
 				 KVM_GUESTDBG_USE_SW_BP | \
 				 KVM_GUESTDBG_USE_HW | \
@@ -820,6 +800,26 @@ struct kvm_vcpu_arch {
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.regs)
 
+/* Pointer to the vcpu's SVE FFR for sve_{save,load}_state() */
+#define vcpu_sve_pffr(vcpu) (kern_hyp_va((vcpu)->arch.sve_state) +	\
+			     sve_ffr_offset((vcpu)->arch.sve_max_vl))
+
+#define vcpu_sve_max_vq(vcpu)	sve_vq_from_vl((vcpu)->arch.sve_max_vl)
+
+#define vcpu_sve_state_size(vcpu) ({					\
+	size_t __size_ret;						\
+	unsigned int __vcpu_vq;						\
+									\
+	if (WARN_ON(!sve_vl_valid((vcpu)->arch.sve_max_vl))) {		\
+		__size_ret = 0;						\
+	} else {							\
+		__vcpu_vq = vcpu_sve_max_vq(vcpu);			\
+		__size_ret = SVE_SIG_REGS_SIZE(__vcpu_vq);		\
+	}								\
+									\
+	__size_ret;							\
+})
+
 /*
  * Only use __vcpu_sys_reg/ctxt_sys_reg if you know you want the
  * memory backed version of a register, and not the one most recently

-- 
2.30.2


