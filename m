Return-Path: <linux-kselftest+bounces-43961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D597FC03831
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 49362357F5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C4F246781;
	Thu, 23 Oct 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyfkBUm1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D89635B138;
	Thu, 23 Oct 2025 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761254431; cv=none; b=B4NZHXKOea9cp3f+yZt+2zMKK/1sB0PrsEYwBQO/Wzi0Wrb22CcyfnjIBikkXu2NuwBzU1faHxhEctq6tu4O32SIzBQBEVr5X3RoKrDvEqib9IGF31v0ScbFFBOyWE/MJWOWMF7AQV47/llRwckY4U1YqV0OlnGHvCLd+oKgLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761254431; c=relaxed/simple;
	bh=CnOMQMjrqhKtD/EhlScExXFn3jDF3wbOMnBmzOuuz8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sKbqg+4YxW1wz1vufHDvm/L1vlyYkjwV0093SvMTTSW+pkZtdXHhfno/g3Uqo2PfrrciA5ruLUqMRdjhjT1BM35nksMn+a74DhTQ4lvP1j3G6d2tSq2rdANCimca0gor2VFcQOL/IdwN6DiU/ot8i2wYs6OGiQTK+OvHuRzHSMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyfkBUm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE34FC4CEFB;
	Thu, 23 Oct 2025 21:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761254431;
	bh=CnOMQMjrqhKtD/EhlScExXFn3jDF3wbOMnBmzOuuz8s=;
	h=From:Date:Subject:To:Cc:From;
	b=PyfkBUm1aFy2wRFZV4lD8D0CNFOxRgPgft1bZRCvlbGHjiTDOEDRSHPeaxJ4hs8mL
	 Q0jiKSY7lNBab/qIAnfhp5rZzKA3f/XjXM+lKbDCV2QcQZ0uzMRt+fSLULsluNrdvK
	 agcvDqY7q5cJVJYUSF4Wh2HIyZS5qjcZFTr9r52jHnmnQ1IUKhkoNA6X8gExYpe82b
	 7HrKWlXLgLsgYDSdZhu4tSjag0qtLicxp3osJDmoAZQhJl0qxWInHWojzf4CsZ7mdJ
	 BVSszA1Ve/HeM+IWLqL8P4gUyQumpvN6PSIrfDlICimkA0AuhZIN17BmGV8vgSunAq
	 Cm5E2RJPk7d1A==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 23 Oct 2025 22:19:29 +0100
Subject: [PATCH] KVM: arm64: selftests: Add SCTLR2_EL2 to get-reg-list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-v1-1-088f88ff992a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOGb+mgC/x3NQQrCQAxG4auUrP2hTcciXkVcjDUdg9MqyVAKp
 Xd3cPlt3tvJxVScrs1OJqu6fpaK7tTQ+IpLEuizmrjlc9dyj0fAe50RbR4CkhSYJGT1Ah9LNkh
 mMLOEoZdLjBPV0tdk0u1/ud2P4weLEUR6dQAAAA==
X-Change-ID: 20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-222e463e8aaf
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-88d78
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CnOMQMjrqhKtD/EhlScExXFn3jDF3wbOMnBmzOuuz8s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo+pwbFbGYn/J+XnOrZGFvXgcvTyRkw0UD8ItGS
 HcdNtUNIyuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaPqcGwAKCRAk1otyXVSH
 0KyIB/9Hifq35A9damYTTSqJ1l1r/u0aFiu0nLatsjdRqqy5ohdrChk54+ZgkggtTGEhEgfUmpR
 c1KDMeSzsd0gkcrIH2V6OxPvd6q0uBkzZhdy/rfOakWyasCWU1jT1ecCVopPQvnSBMqAROgqOcK
 /DADf3whJVgNl2m1Vbt9NWO5VDsygGuZKyXxm2dc+HoeWCB5HTh9tLNszdX1gUgDKn4YYFD+ty7
 HMkuYLOKJiP6zCoAbwbW7/ZTZ4R3qqPxgvmIhkm01Stka/J+btGZ6SwvIPF9Crs+1N3O66Jyjig
 IVjVSM2/9MCzdxXyL+rfw61UAeqmauigvno1wNf/XARiKQhb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We recently added support for SCTLR2_EL2 to the kernel but did not add it
to get-reg-list, resulting in it reporting the missing register when it
is available. Add it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/arm64/get-reg-list.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/get-reg-list.c b/tools/testing/selftests/kvm/arm64/get-reg-list.c
index c9b84eeaab6b..2abef0a86d46 100644
--- a/tools/testing/selftests/kvm/arm64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/arm64/get-reg-list.c
@@ -63,6 +63,7 @@ static struct feature_id_reg feat_id_regs[] = {
 	REG_FEAT(HDFGWTR2_EL2,	ID_AA64MMFR0_EL1, FGT, FGT2),
 	REG_FEAT(ZCR_EL2,	ID_AA64PFR0_EL1, SVE, IMP),
 	REG_FEAT(SCTLR2_EL1,	ID_AA64MMFR3_EL1, SCTLRX, IMP),
+	REG_FEAT(SCTLR2_EL2,	ID_AA64MMFR3_EL1, SCTLRX, IMP),
 	REG_FEAT(VDISR_EL2,	ID_AA64PFR0_EL1, RAS, IMP),
 	REG_FEAT(VSESR_EL2,	ID_AA64PFR0_EL1, RAS, IMP),
 	REG_FEAT(VNCR_EL2,	ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY),
@@ -718,6 +719,7 @@ static __u64 el2_regs[] = {
 	SYS_REG(VMPIDR_EL2),
 	SYS_REG(SCTLR_EL2),
 	SYS_REG(ACTLR_EL2),
+	SYS_REG(SCTLR2_EL2),
 	SYS_REG(HCR_EL2),
 	SYS_REG(MDCR_EL2),
 	SYS_REG(CPTR_EL2),

---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251023-b4-kvm-arm64-get-reg-list-sctlr-el2-222e463e8aaf

Best regards,
--  
Mark Brown <broonie@kernel.org>


