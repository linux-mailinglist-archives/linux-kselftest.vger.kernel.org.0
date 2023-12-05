Return-Path: <linux-kselftest+bounces-1170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616FC805A69
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930C31C20E94
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272E5E0A6;
	Tue,  5 Dec 2023 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTX3dENK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B394174B;
	Tue,  5 Dec 2023 16:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4C9C433CA;
	Tue,  5 Dec 2023 16:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795117;
	bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sTX3dENKdeRtF1TDCs8y57CuUdUdUV5Yqpq5pLii19eel6UrnhjYhv5UnGJS2tBay
	 5/lTorQnHuv8is7/WteqnSigSIq77qN3CkNimW/tbcXtMj8JGqgsNpfCOBzP3XQvRo
	 3CPUg3WaB60kqDu9Cpg49eVRpYf1PHj8ZqWkDiYH1jajKI4Ahi4+H8+Lcrwgwi5azs
	 eSm4AqphZvLmUWUm2Cph7COO57fAjNDLW1GI2baCzas0jTdoPT3C7ST/kYCoFuDup6
	 qVkr8j+SvqCaqn5nf6pR76ZO7WA0f9nluGszCs55PTqC3kW1AduuhIT3cuKuXWlI1j
	 nanSykD90FmCQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:12 +0000
Subject: [PATCH v3 14/21] KVM: arm64: Add newly allocated ID registers to
 register descriptions
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-14-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p49U0rB8BLfyvHeTkXNyujHDJxY2xWglioVFZrQRPgM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TzUP2tOulmt+GKIoNK7BO5wHeBgmWKBL4O1ycG
 4rmKAeaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U8wAKCRAk1otyXVSH0AieB/
 4rwciN5ooMI0noRDiHmL9dDZOgV1MCc98TuDr0afwIp8KUrLGPP6enL09fvLvOWjemPVd5t4G4qwZ+
 LWTYIsa25r3+FLOdSBtYdXOLgTBaNejQ2+EG/Pz0XPIxPFfqipKSyIRpfpmFPHrQVec7tUB84IGYyF
 aGBwC/mp1F0jInr0dyRaz5cqf8dqe2TikDK6F1vWdQFo7iB8UorTzs+DWZinCzpmFJmpMYjg5r40h9
 q0Cd4Ime3WScOJ5VpnDi99dPEm97JmAFYrAPzbjPl8ZIIEPWOpc47q7LcaIDToeIgAJ/04vzti/ax8
 Qn/TAdhRc3H5vSE23w+F1tMia1tG6K
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The 2023 architecture extensions have allocated some new ID registers, add
them to the KVM system register descriptions so that they are visible to
guests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..b843da5e4bb9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2139,12 +2139,12 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		   ID_AA64PFR0_EL1_AdvSIMD |
 		   ID_AA64PFR0_EL1_FP), },
 	ID_SANITISED(ID_AA64PFR1_EL1),
-	ID_UNALLOCATED(4,2),
+	ID_SANITISED(ID_AA64PFR2_EL1),
 	ID_UNALLOCATED(4,3),
 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
 	ID_HIDDEN(ID_AA64SMFR0_EL1),
 	ID_UNALLOCATED(4,6),
-	ID_UNALLOCATED(4,7),
+	ID_SANITISED(ID_AA64FPFR0_EL1),
 
 	/* CRm=5 */
 	{ SYS_DESC(SYS_ID_AA64DFR0_EL1),
@@ -2171,7 +2171,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_WRITABLE(ID_AA64ISAR2_EL1, ~(ID_AA64ISAR2_EL1_RES0 |
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
-	ID_UNALLOCATED(6,3),
+	ID_WRITABLE(ID_AA64ISAR3_EL1, ~ID_AA64ISAR3_EL1_RES0),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),
 	ID_UNALLOCATED(6,6),

-- 
2.30.2


