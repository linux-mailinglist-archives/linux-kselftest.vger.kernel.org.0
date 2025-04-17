Return-Path: <linux-kselftest+bounces-31015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437AA91092
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 02:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D2F7A84F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F639223322;
	Thu, 17 Apr 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX0Mw45v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29421B8E1;
	Thu, 17 Apr 2025 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849615; cv=none; b=TtId0Ytin0P40NZCPeNt4AeQ1WTYU6HVXbMGYg8uWc4pTDcHcs97gkXBf5q8j/ib+lHqLh9262NN7zW94RaozLDcQ8NAPpTTFS4OVXVbOZBe5uIxdjoie8+6w7i4tPpRDV7Yj3iZJJb3Irm5vd0CPdfbJ4qHPDPsXV3Q7vb+pYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849615; c=relaxed/simple;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WABB6cl/IVOAX3vA7LgJ4paRgNItbfB21JH+u9XzzrzF/FMdd3I4NS1xiRZJwb4v0A9WSd0dAlCHEBGi6jg/1Dosj4EgE6XLG1iB/Q9kjhwo5/t4+tTzdM/7mgZl1qIu8cmh114Gu91jKcI5dC4kNklqT6gD9ZBikKJF+tHlIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX0Mw45v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82884C4CEEA;
	Thu, 17 Apr 2025 00:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744849614;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BX0Mw45vSTx342fI8cvZFKX1P7nSBn+kZ8V5lb526uVn1eu9Th/J3GvbKm3+Jkt85
	 pX9ts+Ej/303cnQG7OUm+LqJCvDgc+au9ATQQkK2K2IjCwgiZcPELtktCyZBGqsrsz
	 Hgqf+fWgPoP7gKOE0jCMI3hTBi8UBxWOW/rATZMx3EkmLxyl9WMDROSd1LWOJhXFMs
	 BZpDZXmpxb9Illk0EM0hdgEVppuX8Pfm1BiAWGDeHo6lYoWPEms6dve79EJ8uJX2rC
	 d/jUa3Xt6cwsqP4x1RT/7kFRZpfb/+4fvXjsK4IURp++D807XUwi59UkPI150at/er
	 DETHI6Z09zFpg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Apr 2025 01:25:23 +0100
Subject: [PATCH v5 19/28] KVM: arm64: Provide assembly for SME register
 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-kvm-arm64-sme-v5-19-f469a2d5f574@kernel.org>
References: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
In-Reply-To: <20250417-kvm-arm64-sme-v5-0-f469a2d5f574@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoAEp9Drn0eyy5meekv9Nerff2giIQZ4JCURh9L+K+
 3E1uyEOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaABKfQAKCRAk1otyXVSH0K9TB/
 9WaiHu5mQZtI6uD/X6tcGxe7I+BWnfa+auZ3VgiXZdzBAssAtuZ7ADLJl/0ddCvf1iPW5C6uP0n7Sk
 T7Ki6zBA1VQQOxlkANbuyRM3mu9T9NkHQqA6xrZJTyjN3pzBd9gze/ysepVx2dkuO9jFOU06gID4MV
 prq3xFABE4wAFYqYzEAURgZGKzVkgFVlT1IyrlHF6gB8im8BMEneZtq1TWM8OnaVDFmfVJiG2KJFry
 OOHQablltXo8j1I0BUCM2B03tblLOTZHoEk5ra42+WwTorWdfKtdqMGp7iqqKWc5EL2RFqEDUklfiT
 Fdx5Ydse/LX/kJbXZOX+JcTdG26lMb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide versions of the SME state save and restore functions for the
hypervisor to allow it to restore ZA and ZT for guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_hyp.h |  3 +++
 arch/arm64/kvm/hyp/fpsimd.S      | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 0ad5a66e0d25..1c31d8b26aa9 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -115,6 +115,9 @@ void __fpsimd_save_state(struct user_fpsimd_state *fp_regs);
 void __fpsimd_restore_state(struct user_fpsimd_state *fp_regs);
 void __sve_save_state(void *sve_pffr, u32 *fpsr, int save_ffr);
 void __sve_restore_state(void *sve_pffr, u32 *fpsr, int restore_ffr);
+int __sve_get_vl(void);
+void __sme_save_state(void const *state, bool restore_zt);
+void __sme_restore_state(void const *state, bool restore_zt);
 
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/hyp/fpsimd.S b/arch/arm64/kvm/hyp/fpsimd.S
index 6e16cbfc5df2..44a1b0a483da 100644
--- a/arch/arm64/kvm/hyp/fpsimd.S
+++ b/arch/arm64/kvm/hyp/fpsimd.S
@@ -29,3 +29,29 @@ SYM_FUNC_START(__sve_save_state)
 	sve_save 0, x1, x2, 3
 	ret
 SYM_FUNC_END(__sve_save_state)
+
+SYM_FUNC_START(__sve_get_vl)
+	_sve_rdvl	0, 1
+	ret
+SYM_FUNC_END(__sve_get_vl)
+
+SYM_FUNC_START(__sme_save_state)
+	_sme_rdsvl	2, 1		// x2 = VL/8
+	sme_save_za 0, x2, 12		// Leaves x0 pointing to the end of ZA
+
+	cbz	x1, 1f
+	_str_zt 0
+1:
+	ret
+SYM_FUNC_END(__sme_save_state)
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


