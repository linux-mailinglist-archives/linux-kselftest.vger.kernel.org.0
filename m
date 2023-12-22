Return-Path: <linux-kselftest+bounces-2384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96781CCCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7981F23AE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D0A24B49;
	Fri, 22 Dec 2023 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA+5Nxg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9652D610;
	Fri, 22 Dec 2023 16:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22E3C433C9;
	Fri, 22 Dec 2023 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703262122;
	bh=PySm9eUuq81uqznwETRDeb/dBioLefSS+yd1vb3ztqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BA+5Nxg4BoxYIDuLZD58KPSzrIgf6p70ovrBhk3XkPcQGK59BIojMzlUKtTvTHNqB
	 VkvTsnXXdOL8LlstYVlHr0eSHF5yw0jKkS63UHW5ktgEyfmeMMXnWrsZsvSASLuAkr
	 sUEfm9Ec9Kh9Lffp23dOS1IelktvUFHjBGPtj0Rs9vVHmHuM9ZrwCJKwxOZrQkrL5f
	 xgvidkyI8QNPcQNLJ9yhmPWHxYQ2YWfTMINV/9sNqdXCGXPrPiz1NuPdqGerTUmBL2
	 38VjzjFb9y/LIYwb02wmBfSursR8wHHY8Bv3xesIMCXnX86IYSrVFGAG4s1GZyd02j
	 EMtDhVHWGoCYg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Dec 2023 16:21:15 +0000
Subject: [PATCH RFC v2 07/22] KVM: arm64: Define guest flags for SME
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-kvm-arm64-sme-v2-7-da226cb180bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2850; i=broonie@kernel.org;
 h=from:subject:message-id; bh=PySm9eUuq81uqznwETRDeb/dBioLefSS+yd1vb3ztqE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTW7Y2zHSb27DRwZEyRFM90N3+3dH9ZTnzz0Z9Z0cd+eOs5
 6Gt1MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATqdvJ/s+Ye75K4tqi3aGxHLu/pc
 yV0XTx4OOdID/7qdn/wv8Tk92OMmfxT0yT06/TWi9fG81w975fxv45Hs4HgoVYVVzlmX7OOXvVqZi9
 wPdiAB8T87kCPR9FwUqP+ZdXcc4Qv117/Nhx2/fbDh1+oncqRZCRi3mGmPN9eeulhntaz21sYu4ufX
 /ipjjj+7L2MuunDy7PCnNY/FBp9Q9D8UPhEu8ehq3/IJD5U1Ova2NLso9LZtjteWzMyV1VvK9cbTJS
 imTj/xqJ2zx1kkg9zvCvdfop7bC4gO2S5x+Xq9nI8xhuuGIi9aqrjkNFKLnHUUjSi/Wn23v5G2nelX
 /jkyU+afziPl19y3vlpFpz3icA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Introduce flags for the individually selectable features in SME which
add architectural state:

 - Base SME which adds the system registers and ZA matrix.
 - SME 2 which adds ZT0.
 - FA64 which enables access to the full floating point feature set in
   streaming mode, including adding FFR in streaming mode.

along with helper functions for checking them.

These will be used by further patches actually implementing support for
SME in guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          | 13 +++++++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3b557ffb8e7b..461068c99b61 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -710,6 +710,12 @@ struct kvm_vcpu_arch {
 #define GUEST_HAS_PTRAUTH	__vcpu_single_flag(cflags, BIT(2))
 /* KVM_ARM_VCPU_INIT completed */
 #define VCPU_INITIALIZED	__vcpu_single_flag(cflags, BIT(3))
+/* SME1 exposed to guest */
+#define GUEST_HAS_SME		__vcpu_single_flag(cflags, BIT(4))
+/* SME2 exposed to guest */
+#define GUEST_HAS_SME2		__vcpu_single_flag(cflags, BIT(5))
+/* FA64 exposed to guest */
+#define GUEST_HAS_FA64		__vcpu_single_flag(cflags, BIT(6))
 
 /* Exception pending */
 #define PENDING_EXCEPTION	__vcpu_single_flag(iflags, BIT(0))
@@ -780,6 +786,13 @@ struct kvm_vcpu_arch {
 #define vcpu_has_sve(vcpu) (system_supports_sve() &&			\
 			    vcpu_get_flag(vcpu, GUEST_HAS_SVE))
 
+#define vcpu_has_sme(vcpu) (system_supports_sme() &&			\
+			    vcpu_get_flag(vcpu, GUEST_HAS_SME))
+#define vcpu_has_sme2(vcpu) (system_supports_sme2() &&			\
+			     vcpu_get_flag(vcpu, GUEST_HAS_SME2))
+#define vcpu_has_fa64(vcpu) (system_supports_fa64() &&			\
+			     vcpu_get_flag(vcpu, GUEST_HAS_FA64))
+
 #ifdef CONFIG_ARM64_PTR_AUTH
 #define vcpu_has_ptrauth(vcpu)						\
 	((cpus_have_final_cap(ARM64_HAS_ADDRESS_AUTH) ||		\
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index bb6b571ec627..fb84834cd2a0 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -21,6 +21,16 @@ static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
 }
 
+static inline bool ctxt_has_sme(struct kvm_cpu_context *ctxt)
+{
+	struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
+
+	if (!vcpu)
+		vcpu = container_of(ctxt, struct kvm_vcpu, arch.ctxt);
+
+	return vcpu_has_sme(vcpu);
+}
+
 static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);

-- 
2.30.2


