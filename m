Return-Path: <linux-kselftest+bounces-40580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC776B3FE76
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3652C41F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B83054FA;
	Tue,  2 Sep 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBRYj6VW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B6C2F7452;
	Tue,  2 Sep 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813551; cv=none; b=iB+wGk8QhfLRsCDjpy28esabWSRhH1xldqT3K6I09r8eOe2rkSguSdXyPBqlk/wcR1fdRRuNfv2oeXhEdOAMtH7in3+0n/LdtvW/QT00eisopftmC4vKjW3dBZ3mEcZnz+j3fU6Hb5wBvLTOdM3CUReKOiMeenu1w8A8c1s57KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813551; c=relaxed/simple;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b9TPRHx0As8PZNuo80Z7panmAYuTUYq1nhQIblWcvdGYoXHAee2ngMqmXWNYoBUXGo5NuhsD48nLh7naPAJKcnvfIV2i2ZdbwCCpLyxwSojLo6KmVpihfbhNxA4cgmDgjtG+vIAQI6c6z0ojOnjAyfeVygqSiN+SF8Gr9E5Nlyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBRYj6VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7BAC4CEED;
	Tue,  2 Sep 2025 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813551;
	bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cBRYj6VWD8fF6HBWd1yUzFlLKMsLQBI5Io8P84mfdeJZCc6lGqJy4fg4mmzr5Pan4
	 BtS4ldqYhZvfjHjkAuGrne2k1pxExaAjn5mnOuVgZ/Rd3vhVQ57NXveRi3pbYo90kk
	 FjtivsPIiKte5eSkbBoopdcEaxwSnnZVbPoMOrEog+FcQw849qJgjhr2RNvV1IQmKP
	 0dOopDnUXOY9x4v2zUklI0Hs9T6IUlLYs6FlFfZHtt5IfcaNwCGW6JjaLQ7rkWrQYA
	 9BolGYAjSoEmWnWg1dK6GX1GQCkFh9v7mLvyH4wHtYu1UUVf4Gzoy8qyqMyiWKx306
	 zi8BIGXb2rY6w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:23 +0100
Subject: [PATCH v8 20/29] KVM: arm64: Provide assembly for SME register
 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-20-2cb2199c656c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eko0M/1IoNzmkVmBa1f5aR4hGKuIltnrGwhCOTIwAnI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBottiJvkHNyZ0bEhIAFv5mvwACf4J2Z1oPmYc3H
 v/gCxw87IuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYiQAKCRAk1otyXVSH
 0DI9CACGbb8IBp+/xZtmi1XfvQdy54WecZTRmvQ3x6QMt88KfTaWZ1z5+VpWKlnZEiN3ymhO6ps
 HF5b2q7mKKOAVLp3SZBIRjVhqRi3Vw//FHiecwMVQcOxKeA50zfbIc5lZPxS14YS1FpcP29wLuz
 dPjWkc5HogT99QehSooI1ZqQ3OEPVqjXvj/+ouKkv5PZrWUZKDSvW7q5wtgn7R9fSSSxF8V6hJ9
 hO54p5nnoNhprkkLYK/kW/NaApddkZyppXqth3c07VhSo+gamKqJ0AyNVtbEYk1SNWjC9JM3sh0
 AaFqC478LysO6ApnOhJGkfp/L1matQt757ssB73WwmWu3JoF
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


