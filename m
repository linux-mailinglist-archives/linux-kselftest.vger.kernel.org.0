Return-Path: <linux-kselftest+bounces-89-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB047EB234
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6990B20ADB
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5033FB2B;
	Tue, 14 Nov 2023 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8EGpCwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DFB4121F;
	Tue, 14 Nov 2023 14:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FD6C433A9;
	Tue, 14 Nov 2023 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972549;
	bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u8EGpCwP2YDwTsdhnCuWNRR3ET4cBwlGPOMNDjDi7MyBerlIwMvfr9/Re4WP+Tu2W
	 E3r0tuz9FDWCe5vZRDtnbDwxgtWbVlHa7lriiZOEKRO2bouvvisBzdJ9/1FSIYgS8A
	 nKlvuw1wMHtsutJX74iVJNWv59Angpc0RmjXhL0g9Uem9qclL190adwrdcTzIsLNbS
	 Wf2ANZgx3bCFFKHdKUiga7bbgvbxwa9ZZ7ajEfw2wMTnvxVBtmp20IiwYoo21YJNzO
	 wAKSSEqc09xkvffhauB6TRhdv+aPi/m81q2iBRwZ4iedMGidiu423066hgGRzHapRO
	 71e5nUyBmf1Gw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:53 +0000
Subject: [PATCH v2 08/21] arm64/sysreg: Add definition for FPMR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-8-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=broonie@kernel.org;
 h=from:subject:message-id; bh=TRfwOBP1ct8dRqN5onbbksp9izfKksijyA3SFS57tL8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WbxAeU82L4RUHrAd9Oxy2f0PMZPzQhBtz2zavq
 mLdMhCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmwAKCRAk1otyXVSH0H1GB/
 wPSxydoLDmEph6vxq4HTgSiwCFR5ow+x1m0GsC/hw4ixQz4T6U8KuOY/T5Rl6r9rBYyBegyWmsezp9
 qb/bGB2w2sNU0Ixiiq9tUd9X/MaJLWzJ52D4WjQPLEIyRCU9+Mmvvd7CJm/ZKhwtTQ15ZWiyDHfmwu
 o9RLCcAiwDzmoFwuYD7vJjLGJOtcfJ/dY3G4quJkRPHIbgt3IubEYivPU+5q6pL3SIwUYIaNbRU0KY
 KFLXbNmJNNJKEx1dEDkGQwnm1osxKtzuhwg9jMtSC+UPqBSAGkLkyHrr7NhcGh/KrFqCGqNiA+F4ZX
 NbONDrwLeCffjD/8nRdaIrn19O5O3h
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines a new sysrem register FPMR (Floating Point Mode
Register) which configures the new FP8 features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0b1a33a77074..67173576115a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2138,6 +2138,29 @@ Field	1	ZA
 Field	0	SM
 EndSysreg
 
+Sysreg	FPMR	3	3	4	4	2
+Res0	63:38
+Field	37:32	LSCALE2
+Field	31:24	NSCALE
+Res0	23
+Field	22:16	LSCALE
+Field	15	OSC
+Field	14	OSM
+Res0	13:9
+UnsignedEnum	8:6	F8D
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	5:3	F8S2
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+UnsignedEnum	2:0	F8S1
+	0b000	E5M2
+	0b001	E4M3
+EndEnum
+EndSysreg
+
 SysregFields	HFGxTR_EL2
 Field	63	nAMAIR2_EL1
 Field	62	nMAIR2_EL1

-- 
2.30.2


