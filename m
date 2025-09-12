Return-Path: <linux-kselftest+bounces-41325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57BB54AF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354291C87B48
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 11:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E1302CC1;
	Fri, 12 Sep 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L34ZYKvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEE302CB2;
	Fri, 12 Sep 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676140; cv=none; b=lry69C63xSsVlKj2PtEI5um6IygdVqoa9bda8rZgRuRWQcv3UGdNEXfZPBdYS9xwljhQBqQzdS7bQr/3/seDAmBlDMsnBrX5cLMbdtI3GWIkeRnNfmS7n15HVKk1HwPmK5s9HrMYBi9x1Sj6pJF9PvKmKCtr0NQqm65/BnBpTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676140; c=relaxed/simple;
	bh=2Z09lyzr3mlySMGqqjLAI9Q8pohqjxnIJ8nt0XVxnnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJQ7IvSzHoVd26Cmb6rO6EPEfbPtUR+rhATZmvVRa97yvN4wouy8tCatj7mxTPDRtT5h0G71oDAxbZ+sCjPSc4VUhGieOv/LJVJU2b9v24Lfk+okk0LH5W8jxSEjnu5tluGRLg7Y4qDK/qglIg9bK3NvJ0N+nI3aoACdQKj/ClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L34ZYKvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC14C4CEF7;
	Fri, 12 Sep 2025 11:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757676140;
	bh=2Z09lyzr3mlySMGqqjLAI9Q8pohqjxnIJ8nt0XVxnnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L34ZYKvkzUB5+9nv8Ow5OWUHNFysI8goeM6YczMJs91QTuZ9ENhdQBw/sQZxbcqIA
	 GGj0FoaBJlU+Apn+Ir0QqMi0GIx3V2TWDtYMsJruNdyPq6fOqEbAjx7rcQKsBL4eB1
	 ZfAJbaAPcf3GMZbfEsEvUk5Jj0DDZ6JTNOecVh3+BDkQLJjcF773MbmzCwCxMjxqhC
	 TG5dd72VwSu7XRSYD0qKQzSZ+du6M4Hsfpq/uXQ/VcdSndSUevVNIBaR6ryzK3pNld
	 NUkps7GD7ZPpazktK1Lm6xQVSu4UeJVJtUF2+0u/5o0BsfelP33i5UfMQcHxmHzpJO
	 uEEFna+EHHPWQ==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 12 Sep 2025 10:25:32 +0100
Subject: [PATCH v16 6/6] KVM: selftests: arm64: Add GCS registers to
 get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm64-gcs-v16-6-6435e5ec37db@kernel.org>
References: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
In-Reply-To: <20250912-arm64-gcs-v16-0-6435e5ec37db@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Z09lyzr3mlySMGqqjLAI9Q8pohqjxnIJ8nt0XVxnnw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoxAJY4+SLnStXXvVFpBNYWlP1+VGHPxHvlmN6M
 z611HojkTCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMQCWAAKCRAk1otyXVSH
 0CORB/97WmwBUUlxAL6LjWlqWHp9V44CpCGTC8Lhk6gOOTvNi+TUCs5aGaKAmuFUa6SKHkaOBSF
 EKWdDn7SfL8jcvcmmZu0fRFASR0rW40r76P/++ZuDCMg1UJhJAtQ8PENu/BIsrwqpjsyVoCsmyJ
 kTsrJZQkxq5KFPxlIVNtb85ZEaLZEV5IN+y5tLS0jVoN7drGvdySNw56qL+pfuwJTmpzfYRahF+
 nkLZR9oDmz6oCZoMui8A5bj0hErIFgI/AHAgYXUULilLRnwZ32rMPmmfSuKzXnt3Gp3A/dWTmHa
 BJHd3LjzUSlDY50YlZs6fq3uO0Jy5Vi7H7qbcCd9ny+3TQuK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

GCS adds new registers GCSCR_EL1, GCSCRE0_EL1, GCSPR_EL1 and GCSPR_EL0. Add
these to those validated by get-reg-list.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index 011fad95dd02..9bf33064377b 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -42,6 +42,12 @@ struct feature_id_reg {
 static struct feature_id_reg feat_id_regs[] = {
 	REG_FEAT(TCR2_EL1,	ID_AA64MMFR3_EL1, TCRX, IMP),
 	REG_FEAT(TCR2_EL2,	ID_AA64MMFR3_EL1, TCRX, IMP),
+	REG_FEAT(GCSPR_EL0,	ID_AA64PFR1_EL1, GCS, IMP),
+	REG_FEAT(GCSPR_EL1,	ID_AA64PFR1_EL1, GCS, IMP),
+	REG_FEAT(GCSPR_EL2,	ID_AA64PFR1_EL1, GCS, IMP),
+	REG_FEAT(GCSCRE0_EL1,	ID_AA64PFR1_EL1, GCS, IMP),
+	REG_FEAT(GCSCR_EL1,	ID_AA64PFR1_EL1, GCS, IMP),
+	REG_FEAT(GCSCR_EL2,	ID_AA64PFR1_EL1, GCS, IMP),
 	REG_FEAT(PIRE0_EL1,	ID_AA64MMFR3_EL1, S1PIE, IMP),
 	REG_FEAT(PIRE0_EL2,	ID_AA64MMFR3_EL1, S1PIE, IMP),
 	REG_FEAT(PIR_EL1,	ID_AA64MMFR3_EL1, S1PIE, IMP),
@@ -486,6 +492,9 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 2, 0, 1),	/* TTBR1_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 2),	/* TCR_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 3),	/* TCR2_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 0),	/* GCSCR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 1),	/* GCSPR_EL1 */
+	ARM64_SYS_REG(3, 0, 2, 5, 2),	/* GCSCRE0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 0),	/* AFSR0_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 1, 1),	/* AFSR1_EL1 */
 	ARM64_SYS_REG(3, 0, 5, 2, 0),	/* ESR_EL1 */
@@ -502,6 +511,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 2, 5, 1),	/* GCSPR_EL0 */
 	ARM64_SYS_REG(3, 3, 10, 2, 4),	/* POR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
@@ -740,6 +750,8 @@ static __u64 el2_regs[] = {
 	SYS_REG(PIRE0_EL2),
 	SYS_REG(PIR_EL2),
 	SYS_REG(POR_EL2),
+	SYS_REG(GCSPR_EL2),
+	SYS_REG(GCSCR_EL2),
 	SYS_REG(AMAIR_EL2),
 	SYS_REG(VBAR_EL2),
 	SYS_REG(CONTEXTIDR_EL2),

-- 
2.47.2


