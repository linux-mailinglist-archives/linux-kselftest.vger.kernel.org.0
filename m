Return-Path: <linux-kselftest+bounces-39629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2A6B30B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 04:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FE93A2069
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19308244678;
	Fri, 22 Aug 2025 01:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNMmW3u6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A0243968;
	Fri, 22 Aug 2025 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827702; cv=none; b=EVli4qKhiWcAzfhBenNrGBesch8KuF0PoRcQhW4yP8nzDtrruZZUCRUGXevuPd0tfKBQGJJ59uDHOJgkCP1FyOHpLqh3rULO8QCPEZZOJZ2sIFVnxn9s5PcCzIMXLHzWU4qrw2jlmCyTbuVnTwIL15YnNLDCuB6dHfv0hQH1/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827702; c=relaxed/simple;
	bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlDI+umel7xdYkF5XuK0RFxczIp9nAGEwbXtIxvMs4Lieuj700Hjk9lxldDSq+il/ope8euGXodCuf34GDGkhbvYvcq0a9/kUVgw/Xy5ELDa9kzLj+nDjOkP73RlenCEYIttjYvupPxxAvr5jHLIBE0mZmzDwuKhFy7XCGo7rU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNMmW3u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6CDC4CEED;
	Fri, 22 Aug 2025 01:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827701;
	bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vNMmW3u68moScB4YLlHhhuTjSmZjS4ocgb7RysoWRgCf1f3gwRsm/hs3XgAuVh1e2
	 dFfrN+voWD87cQaiH5iFd9NPKNKEadAa2FlyTvv/7fxENKXA0PdeAp8vhS45fdsfAk
	 7SCc7g3fTA3cJmGxzxgJGS1P21ggtFdKlc+RUlQwGUxazcU5h8LxYLKxxQa9jH1K1P
	 9aUMACzZWzQoOcoClWme0LrSA6NgJvNGRBKdgCXR4MEWTramcSGy0hef9n+mslK0vO
	 1Y9c6G42e5BCTLhD3/Hq9BBMs0LIqV7QQqnbFyGPF0P7hUb9EYUZUAcJDAgPGzwDSh
	 qZfVFXd3/4xgw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:38 +0100
Subject: [PATCH v7 09/29] KVM: arm64: Move SVE state access macros after
 feature test macros
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-9-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
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
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZG4fxyvl+fJjEtNXLvLt23cYfT+WmIeEoPP0DgaTqa0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop82/fOTWED/bf1kLN5UWctuDyjzq8csRed7k5
 +r4evadPJ6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNvwAKCRAk1otyXVSH
 0AfOB/9DdJ/PeLOWQm7WyyBFCHgGWBEblTef76PTQMYaiCkSW+D5SFJT2zM0i06lCkitUT1Un59
 xbikMemKg2qqGvMhFX/ye0e3fe1Srdo/j9yw6e5Csivx9paiJjLoqz5/tQYMH2jt2/u5IswsufR
 gam7pRQmfWvpFQ0sCbQ+gpV8HuVdufOKu6j5HHHMOUtp/awFg5CWPTkF4zpYudFPfcy96v2bqVu
 QvlefIb+337j+qeZw1hY/ar0o89ldTU3aXwhUsCXEFnyyqJFcUm8e8+HfLsAXAjzrCkkHt7Rcu3
 skFv8UtNnMnr1DusSM4CcHSHJjOKvbVCj/sZ+Gg5Whrxtciq
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


