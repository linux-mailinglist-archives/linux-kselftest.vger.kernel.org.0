Return-Path: <linux-kselftest+bounces-23139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392929EC152
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C9916912A
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DB1D4326;
	Wed, 11 Dec 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="est+jKTl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA71D31A9;
	Wed, 11 Dec 2024 01:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879089; cv=none; b=ifUco1L5+FNrGjjraOp5XHEcdGS9dCEN9Ouv3j5rwENXLms/nLJkVAYYK50KAeWObfCgQfg/JaUG/fmBZGmmUO84PZqOEAbS1mYYOiFGpLLsO5HmgsOEeb2PduKfcSI1MhyUjBv2q2+B+M/qvkc6kO37oqFvAILiHIbedP0KBSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879089; c=relaxed/simple;
	bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfdVtWoJ6FZBBiolr1g1JLixHWf0HBkSzqe5abNDoY8mxNsdTFaEENwiK/QVwUM/+GqAIatTC1RtAdlQzJwdThUMWdsyjgAFgsIEvuhu0xCuUxww7HIm7kCO4wWA/JmDmbHNzC9TLcpuPwRREUKkkx0VhnlmCXUy2i2uRja58gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=est+jKTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7478FC4CEDE;
	Wed, 11 Dec 2024 01:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879089;
	bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=est+jKTlMjjT0LteUy3l0s/bqzIPRBoO3iJZw0xbbgJUgc39gJnLG2FeGJUB7D5lJ
	 BMp18/ena+cJH9IGZ6xCSER8+HFKMakvpRy1zkAfSK8TAhe+8Z2TtlnOV4zcjh8VQm
	 DhJVCaOC0E3U55m93B/JaKUINPcYMsFYLOz7tP7FXkM4ysiRegyYJ76pOybkDUj0U5
	 IqrqHhEzJy0fFR4aB+cfD12Dvb5uOEshQz7m4qq+w0JL1f1t8nIvarVRGZdbG37Jnf
	 3jToVCG7N0Hd/RrhSc6E6HS8CYazhQFS7uvRb8jba0MZ0CEOWKCd7EJDqYtPEUdCH5
	 va5Byh4MWjXLw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:53 +0000
Subject: [PATCH v4 8/9] KVM: arm64: Allow control of dpISA extensions in
 ID_AA64ISAR3_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-8-0fd403876df2@kernel.org>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
In-Reply-To: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1369; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cKym5jL1wVVG9G/7MeEDQVRM4fdPvM6wIXw2UfuLn2s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUUhmVbDtN4zgUDprg+DePqkfqBwUsINMtFA3QJ
 1gHnRzSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlFAAKCRAk1otyXVSH0KZNB/
 9kB6zoenu8X62lAzSiX4YYO7L6QYm3FGYNXOKN+jxzU5x+tdlQmsJmsZlWwG5i5WMlttwWiCn6nVqe
 Ym449g++ZZ5W1OiLpJOAxZhSMg26IvKox88qwXM+qdcROa0e5qgUiNMzlfHUTB8+/RT7tkDm4+s4kK
 POUeMmmA3u3gVm5wS4SWIF5I0FI0iCiTc2XU54nHfD8u+UifrayrbiTqJewtV9iHiSNH1sM+HrKtY1
 xvKpLgAElxMdEypMJvH5462BQKDj4PQISCJIGMCSBM+LROwiIZ2pwViVSYmL/52Hm9MaLrG0jcc2iB
 C3FUwcAO2DOUvyaQzphj7Bap5OvCu7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

ID_AA64ISAR3_EL1 is currently marked as unallocated in KVM but does have a
number of bitfields defined in it. Expose FPRCVT and FAMINMAX, two simple
instruction only extensions to guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 83c6b4a07ef56cf0ed9c8751ec80686f45dca6b2..6efbe3f4a579afd1874c4cf844c1c1249ae8b942 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1604,6 +1604,9 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		if (!cpus_have_final_cap(ARM64_HAS_WFXT))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
+	case SYS_ID_AA64ISAR3_EL1:
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
 		break;
@@ -2608,7 +2611,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.39.5


