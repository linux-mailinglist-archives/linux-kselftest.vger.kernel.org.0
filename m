Return-Path: <linux-kselftest+bounces-22741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF19E1E98
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 15:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA25AB275CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BE11F75AC;
	Tue,  3 Dec 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnbkMRck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D91F75AA;
	Tue,  3 Dec 2024 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229837; cv=none; b=YGcsqLS1K7mFui5RgWLHAM4oI3EUNSWC8TKOJtFGflO4w2zQaRmUYt2zmmoyeZhaA0/EMTAC9ggipqN5NvFXpMiV7pnST/aYYk1txESLVoevuq6uWMle9ng4I1v1w69gvthcF/c5e1q/YgLdwb8oA+zxEmcaqg+f/6NBxFtIxhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229837; c=relaxed/simple;
	bh=nGzXFLHUtSGAowAwdsTt+9naVqkMumDIsYiDbB9NiH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KS5lAsAHU1MWdDitQk1RkM4dfa4K23okxzuKSbnr/sQgZU/teMcQf0l096bzAwfQRBc7siETzqI9gADXuyfAfgbK9UnY3o/E2m5PC7wnMPm9GhCKknuFvoYA+Ku8fQF9F4XhKaq6eRrGuoMi+o5yVtZKouBJf1E0urjotTDInyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnbkMRck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1565DC4CED8;
	Tue,  3 Dec 2024 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229837;
	bh=nGzXFLHUtSGAowAwdsTt+9naVqkMumDIsYiDbB9NiH0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qnbkMRck+kyQ9PtPjTyp3TVn4T1IVMzrmuTb/oURMkMNdG6T8cyH9NvjyfxqHYGZN
	 FnRSsrKiET0Zs+tSO6Q3Msf0AbssJyOW7BL1vYIaM31Jm3pyEPt+NXVroDRps19Q9+
	 FV+lFcNab2NeUxN2lO4+zZNlVPggkK/gbRDzP+J0L2krJCDzn2KfKjDVrOPGo2QO9T
	 qdu2JePbWzjdDO2KILRFOKo8QbLevi3HlX5i5AGgWIjAVvIKAqrvfVAm1bNehImT8i
	 rokGUrnlhAqV6yVBzukErV8g/lejFXoVQJrZ0n1dlbJ63mXtuaBTwy1YRdYi9GKF3K
	 1/TDC/Gor4N9g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:24 +0000
Subject: [PATCH v3 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-5-a6c78b1aa297@kernel.org>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
In-Reply-To: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=broonie@kernel.org;
 h=from:subject:message-id; bh=nGzXFLHUtSGAowAwdsTt+9naVqkMumDIsYiDbB9NiH0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz3ZPOwLYB9ZKu+MSGvTZ/MxA7HOiPtWwGV7TE0
 v2MMmSuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0789wAKCRAk1otyXVSH0GxyB/
 9EBth00BZv1Jvd5qY+tk6M+ginHQh1VcC6op4eFE/bWLA7wjN+oRIGFB27JnyxJXFcTYFvp63KAvwP
 l1mxHQXBYlMdIhVz+zJaNDOn6WeIvsBvukDCnbdJ/9NeCq1P+w42JVYQ2hOx9lEmx/nv7WCwg80cJR
 uukxXB/8vHWVSZa/OVkjGm4xpJg2iK8KcwOBAK/bQZMgyn/tl+EEAYOWQ2I4JptfMZKhjQDbj7v3pV
 0dE2JtJMRAzkJFRKqLQbPbPJfVqdOOvglbbE0+BnYAAWuQJxLkfd98seAsdexuOSDq/uWK7F9ltAZ7
 Ecs3y79C8JXS6tmwSJYzkD7kpjvY/h
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SME 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64SMFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 7e6b204e83270daabd0036c8109b2fdb0e9b700a..0253d3847aeb2294da04b2b0b3f33f81f32c849f 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1105,6 +1105,7 @@ UnsignedEnum	59:56	SMEver
 	0b0000	SME
 	0b0001	SME2
 	0b0010	SME2p1
+	0b0011	SME2p2
 	0b0000	IMP
 EndEnum
 UnsignedEnum	55:52	I16I64
@@ -1169,7 +1170,36 @@ UnsignedEnum	28	SF8DP2
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	27:0
+UnsignedEnum	27	SF8MM8
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	26	SF8MM4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	25	SBitPerm
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	24	AES
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	23	SFEXPA
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	22:17
+UnsignedEnum	16	STMOP
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	15:1
+UnsignedEnum	0	SMOP4
+	0b0	NI
+	0b1	IMP
+EndEnum
 EndSysreg
 
 Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7

-- 
2.39.5


