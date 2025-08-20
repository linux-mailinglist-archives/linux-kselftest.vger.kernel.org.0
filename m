Return-Path: <linux-kselftest+bounces-39379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23478B2DF02
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB917BCBB
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 14:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EAA2E7620;
	Wed, 20 Aug 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip7Z3xpd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677022749E4;
	Wed, 20 Aug 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699338; cv=none; b=ZPkbS0DvYxOmqW0LbmIZFumxyPNccCVLAgYHUXAxGlbvy/rdMMvltl+koA6yCSZvVmaKNcq3xeKI9epYAvYJrMhzmqZ74iCeYV/KBm3IFTRYCGxpOqy0i+w9r3JCG2fakByo5D+mntZFY9j14fbyusbV3uhFhtFdQ0bjLf+5fUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699338; c=relaxed/simple;
	bh=giAvZ3PXu+lP80aoBjb8+UDhRd3O2Wn5C1lPnTF310M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgXSDkEDdQ3jmt5WmvSZjb8ds3HPAFJC9Kn1jkhba8HCVQbRRkNeNYEI4cuopClMinWqD0R+c2214das+2N/RaBHdbQM0lAGDbwd8qEXF/Fn6RSXTNVkoYRF3HTscuoqyF6TgVMf+0FVdfaNi2oRiTpkAmfXEwpnpawSGO2o+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip7Z3xpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3746AC4CEE7;
	Wed, 20 Aug 2025 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699337;
	bh=giAvZ3PXu+lP80aoBjb8+UDhRd3O2Wn5C1lPnTF310M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ip7Z3xpdlFPHciRTuRtQr5IwnCqHeEVZBsfuT33VPsVwORgPcE5VL6xry2ycBwpnd
	 wfBPtNKzobitDyFkEXyvXYap5Kra9svY1TfddY4I4irNGLvzmRcxlMUBh99Ael7sU8
	 SK+XA+yakGm+PIHDRFCFMZyrhPF8nySXfrgOgIkZDBsw201vk0XO5AICUYWx7VptbN
	 hByEQ21LL0p6tg46AYAWXjAlMcG3aBED1qTOc+/kK3Ek/LC9fK2Z+tLxA+C+4375mo
	 7xKRYz/OlI0qfEhw4k40+IqULuiHrWMtVLhK6GS1x5sXNcFLXyDGzM5HGCS8kHO+s7
	 ERSO2efDs5Oyg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 20 Aug 2025 15:14:45 +0100
Subject: [PATCH v15 5/6] KVM: arm64: Allow GCS to be enabled for guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-arm64-gcs-v15-5-5e334da18b84@kernel.org>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
In-Reply-To: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=broonie@kernel.org;
 h=from:subject:message-id; bh=giAvZ3PXu+lP80aoBjb8+UDhRd3O2Wn5C1lPnTF310M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopdhxlIgAp7F1QJGg1SOe2olWOjR5Wq6td61O9
 Z/r5ZBJiICJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKXYcQAKCRAk1otyXVSH
 0NFaB/sF6rAfJ/JA1Bq6Q2rjkPRJZTG7XGBeVzum/UOih8m/VQc5dqu0fxeJ/fLgNHKhqoVXi6Z
 OgYtSBmD0PQ5dHOixeZv6jLVpecMm+JccC3XfHFYJ7B1FOvWomyHCxCX3Wjf9yq+/pMXuUrXUzT
 4Rnxzh24AOsgIY6Oylf2Pcq4/IVf15AZypVVWVnauFa7aamAL7FksYJemt0HGaRUANCsj8OnaDm
 LQN3slY54dDZpGVMxE6tK/FArCwalKvvRKvG2F0eNCMNrfm4cySAFsgKfYLlNW6kmbFmp1w56OZ
 GQnZYsoILY2BPity3gkWlDxgBnNpzw/IOxtuh84UNXEz492q
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Now that required functionality for GCS is in place expose
ID_AA64PFR1_EL1.GCS, allowing guests to be given the feature.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 592cb5d6497a..60e234422064 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1616,7 +1616,6 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_SME);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_RNDR_trap);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_NMI);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_GCS);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_THE);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_MTEX);
 		val &= ~ARM64_FEATURE_MASK(ID_AA64PFR1_EL1_PFAR);

-- 
2.39.5


