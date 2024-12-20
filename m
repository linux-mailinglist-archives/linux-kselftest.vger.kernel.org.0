Return-Path: <linux-kselftest+bounces-23687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE29F974D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E0B18999E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F75522914C;
	Fri, 20 Dec 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssi8EUnV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F4229124;
	Fri, 20 Dec 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713533; cv=none; b=i+IXQp+PrIzf5+LGaRNb0i6ifRY1B7XivmT3cOorjZ+8cphh9a8Md6hy89A8oGGp98jEp5ocWVgv9fI4+wJarPH07DipAO1WeHasYxiaSAxoKbfQaTHgpWxCJ3TB3AqEveoQPWSwFEXEQ8EYXI7Gg9JLKvrRwy/uSaqof36poTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713533; c=relaxed/simple;
	bh=ENOuC1TJcLemryiEjkWj2obhMQPzOqxnrV0P2mql+Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kc3oX1L4VRcdJjTnwc7p+yxcmzpejXGkhcziA8kXk8ocilo5ey0tJV8KyJFOEH0sVy85cZLqi/8UKSdLUu/W2rAtgpQ673mlIXdi6c69nfhRqA3YbKMOA5Zad7J39pkSKf2UHZ2c75JHW2JdjKJJcTu37OmCucyTSKIs9d9pVL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssi8EUnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D48C4CED7;
	Fri, 20 Dec 2024 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734713533;
	bh=ENOuC1TJcLemryiEjkWj2obhMQPzOqxnrV0P2mql+Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ssi8EUnVVNwfhRrHMmu+SM0Q4NnT9gMhK3MqiAI8pA6M0bBsb959zketSgp2K4CN5
	 JlpNGd3mV8s19GLNEdJ0aEOxoR/MILHM6yw4kfFVMnCkgoIbKEgdUlkM4Ifwp6IdEm
	 D3DW05Lwv9eapii3FYvUq84+RhtvBtmubKLBZoH1hYLZjI14TVC9BoNcfMYY2ng8Ae
	 B6zIJL1JjJ1in59kolXbEgkojFnZZhH4Eih9/LGrLfA3CdV5pciy0hR0RX/7FBMASt
	 YvWyq5ejgR4+RXyjYBys+gtLXfY8uW+wrm3etNfKMUzak/AT4qVMfvL7jaqXSxGGKD
	 eA2epJRg+O6Hg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 20 Dec 2024 16:46:45 +0000
Subject: [PATCH RFC v3 20/27] KVM: arm64: Provide assembly for SME state
 restore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-kvm-arm64-sme-v3-20-05b018c1ffeb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ENOuC1TJcLemryiEjkWj2obhMQPzOqxnrV0P2mql+Ks=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnZaBk3E6dm3e3qW64VbwkZ8BsgUXtHAv6JoenG6H9
 ivnP0ZWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ2WgZAAKCRAk1otyXVSH0BkOB/
 9pZK/XWcKBxIAbq8Kxz8iIvhPYuh/k36bbRLFCMarZ1Z5rPMkf8dntgyNKiUgIzPm6Uw+3qRbKIe5E
 Bm2brl/HNycaJBXjRtj5afSTrMoQDsvGkVtIs0I8duEJFnqCf43+XJ0apduhKJ6oaPiDBTJDnOcZTe
 ULQT9t7Hwlzm4FsjQuXTcdNoOnXcjEnlG8ng440HTikYzJLhmd6F5lBW/Ivx99Ke5XlM+MRrm3k9VZ
 ot6KxSdKkSj8wIFQr80TkHle48IdnsMkMSd2EBdOrTcrop+pK8XvZWc6CR5iq8aZcEi165we8JzTAp
 5tBTTH/jNzQnZA5FYD5EIyS0Nhtz5x
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a __sme_restore_state() for the hypervisor to allow it to restore
ZA and ZT for guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h |  2 ++
 arch/arm64/kvm/hyp/fpsimd.S      | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 21943cb98542750a1b626a8de6bbc095d7770ccf..5a1f8e4be18624efa6b887f09c36f0e8ad318c40 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -113,6 +113,8 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+int __sve_get_vl(void);
+void __sme_restore_state(void const *state, bool restore_zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index e950875e31cee4df58d041519b7584356463c91b..9e4bce86ef2e632a6071480c06a0b7d69bf48f3d 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -31,3 +31,19 @@ SYM_FUNC_START(__sve_save_state)
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
+
+SYM_FUNC_START(__sve_get_vl)
+	_sve_rdvl	0, 1
+	ret
+SYM_FUNC_END(__sve_get_vl)
+
+SYM_FUNC_START(__sme_restore_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_load_za	0, x2, 12	// Leaves x0 pointing to end of ZA
+
+	cbz	x1, 1f
+	_ldr_zt 0
+
+1:
+	ret
+SYM_FUNC_END(__sme_restore_state)

-- 
2.39.5


