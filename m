Return-Path: <linux-kselftest+bounces-47899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA6CD7BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85079301D624
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA0F346E7A;
	Tue, 23 Dec 2025 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDI63LLK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D182346E73;
	Tue, 23 Dec 2025 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766453020; cv=none; b=fZYAuMRVbOhj2x/iQQHbYZBF4Mn3GtkdcsIb9RibPqQGiD2hcbLYfAvPI/ffQnhFHd+jE6gpgKFk8Efwe8/mu8pXCwJQ5FpGa4JGu1WwUswNI2woB9pQlAsKTLI5N0rEePcW2jZdG6V+wC8bhU3xDaNaIWUVwd+YBji0TpqxHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766453020; c=relaxed/simple;
	bh=I21JH58CR/AbSnYTHYyjog9l03x/hS5CLetpI7AAePU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nN3TsnBvyPBskYN9mgZwG2dzcwtyU//PDdCf9R+RwFDuDzGTa1bJNcJX/jJI4JbrzaJQzPCOgBp62uGZVDyaOMe3HHnSW5K/nRai2RJvovddO0HzhWJ6+2eqZdejx/Ud37rGFmiLSsh9ZMZ/TG0Yu2/C1ECWZAvcfKDUqZqLAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDI63LLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35919C116C6;
	Tue, 23 Dec 2025 01:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766453020;
	bh=I21JH58CR/AbSnYTHYyjog9l03x/hS5CLetpI7AAePU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TDI63LLK1Dd1BykFPpVc3P1jymgU0gE7V7Jfq79W8nXBVnryoXik9MiSeHISYJWso
	 iqEKTBpNSpTY8vUe1lMC7M3DqFprUaOCoghpDgRcaQ/apQHkwkEhtSSCKPwjYSPAjV
	 Q6oa3MzIbx34D1ijUlfgrZ3+pt6SaxE/svxtaVLffBOGZ9J/sEK1h1bVE5lH+SXT6Y
	 ItLdWd3XzoCmoyA8NA96k8dppgPXtTVypxXkHlWVhG3sbDZ8/5gUUB3x4OuUmsz8lF
	 RLUs/9RWms61xzLBp2sYKMs1nTdyT6CWO/IATP6khzWzRaAZf2RQzvBKjxgW73VJXc
	 oUJotCBGyqs3w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:21:23 +0000
Subject: [PATCH v9 29/30] KVM: arm64: selftests: Add SME system registers
 to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-29-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3018; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I21JH58CR/AbSnYTHYyjog9l03x/hS5CLetpI7AAePU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6ZT3WxDFPfEe4BoCZZTNsMTuw5J7xSE+tTa
 Kmv0qg+FySJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnumQAKCRAk1otyXVSH
 0MA/CACCkH772PTG/2cJD7n0eyuJAn8ayWPMc6UNVuPIbnw1VvkAHXSJua/tE7V2+I1eNywUt2e
 pA231uFEmuh9U2Y6d0sb5W9L9K+Oy8kjQefNK/pbaZF2e0R5oEWc+jHgWcPzNj5z9r6qaz5Ne+c
 6+UEzIJyvS6TIop3jGeSrcXeqptOr8td52Z2M0WWURsA03BIDpd1xNd+yVw4aHi6qTphgsODZ1s
 6OZeAxZhqrHu4y5N3ssTpQjiGFesV+2QhchBxbA+8aiumfc4ci18jbU9OXKN2qZWMEl9Vwk/+BK
 DhKMtrPx1XA/2ePHIWanby31qExFiyZ1phJO8hFZGjQr5Ylh
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

SME adds a number of new system registers, update get-reg-list to check for
them based on the visibility of SME.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index 0a3a94c4cca1..876c4719e2e2 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -61,7 +61,13 @@ static struct feature_id_reg feat_id_regs[] = {
 	REG_FEAT(HFGITR2_EL2,	ID_AA64MMFR0_EL1, FGT, FGT2),
 	REG_FEAT(HDFGRTR2_EL2,	ID_AA64MMFR0_EL1, FGT, FGT2),
 	REG_FEAT(HDFGWTR2_EL2,	ID_AA64MMFR0_EL1, FGT, FGT2),
-	REG_FEAT(ZCR_EL2,	ID_AA64PFR0_EL1, SVE, IMP),
+	REG_FEAT(SMCR_EL1,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(SMCR_EL2,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(SMIDR_EL1,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(SMPRI_EL1,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(SMPRIMAP_EL2,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(TPIDR2_EL0,	ID_AA64PFR1_EL1, SME, IMP),
+	REG_FEAT(SVCR,		ID_AA64PFR1_EL1, SME, IMP),
 	REG_FEAT(SCTLR2_EL1,	ID_AA64MMFR3_EL1, SCTLRX, IMP),
 	REG_FEAT(SCTLR2_EL2,	ID_AA64MMFR3_EL1, SCTLRX, IMP),
 	REG_FEAT(VDISR_EL2,	ID_AA64PFR0_EL1, RAS, IMP),
@@ -367,6 +373,7 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 0, 0, 0),	/* MIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 0, 6),	/* REVIDR_EL1 */
 	ARM64_SYS_REG(3, 1, 0, 0, 1),	/* CLIDR_EL1 */
+	ARM64_SYS_REG(3, 1, 0, 0, 6),	/* SMIDR_EL1 */
 	ARM64_SYS_REG(3, 1, 0, 0, 7),	/* AIDR_EL1 */
 	ARM64_SYS_REG(3, 3, 0, 0, 1),	/* CTR_EL0 */
 	ARM64_SYS_REG(2, 0, 0, 0, 4),
@@ -498,6 +505,8 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 1, 0, 1),	/* ACTLR_EL1 */
 	ARM64_SYS_REG(3, 0, 1, 0, 2),	/* CPACR_EL1 */
 	KVM_ARM64_SYS_REG(SYS_SCTLR2_EL1),
+	ARM64_SYS_REG(3, 0, 1, 2, 4),	/* SMPRI_EL1 */
+	ARM64_SYS_REG(3, 0, 1, 2, 6),	/* SMCR_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 0),	/* TTBR0_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 1),	/* TTBR1_EL1 */
 	ARM64_SYS_REG(3, 0, 2, 0, 2),	/* TCR_EL1 */
@@ -518,9 +527,11 @@ static __u64 base_regs[] = {
 	ARM64_SYS_REG(3, 0, 13, 0, 4),	/* TPIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 14, 1, 0),	/* CNTKCTL_EL1 */
 	ARM64_SYS_REG(3, 2, 0, 0, 0),	/* CSSELR_EL1 */
+	ARM64_SYS_REG(3, 3, 4, 2, 2),	/* SVCR */
 	ARM64_SYS_REG(3, 3, 10, 2, 4),	/* POR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 2),	/* TPIDR_EL0 */
 	ARM64_SYS_REG(3, 3, 13, 0, 3),	/* TPIDRRO_EL0 */
+	ARM64_SYS_REG(3, 3, 13, 0, 5),	/* TPIDR2_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 0, 1),	/* CNTPCT_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 2, 1),	/* CNTP_CTL_EL0 */
 	ARM64_SYS_REG(3, 3, 14, 2, 2),	/* CNTP_CVAL_EL0 */
@@ -730,6 +741,8 @@ static __u64 el2_regs[] = {
 	SYS_REG(HFGITR_EL2),
 	SYS_REG(HACR_EL2),
 	SYS_REG(ZCR_EL2),
+	SYS_REG(SMPRIMAP_EL2),
+	SYS_REG(SMCR_EL2),
 	SYS_REG(HCRX_EL2),
 	SYS_REG(TTBR0_EL2),
 	SYS_REG(TTBR1_EL2),

-- 
2.47.3


