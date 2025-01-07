Return-Path: <linux-kselftest+bounces-24035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E19A04CEC
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Jan 2025 00:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55740161A66
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 23:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17971F3D4C;
	Tue,  7 Jan 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZDC2cPs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EBD1F37C1;
	Tue,  7 Jan 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736290879; cv=none; b=uuNgGHe9TVxi+N/q1eE6DMjXup1oLRmcJHE0BxBSlxLvAf7Ld27pDU2b/uaqdNEmB2nLhboJ07C68IMy3mvdI4jrnTCpWj5IpaP9UZEVEo4uRXlR0Jbhj5wChRlCMh8o4ecUoFf+9poktkqB+P1q2VZR8Y/4JeR25WHEqIy90Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736290879; c=relaxed/simple;
	bh=Tdj0gsQusE+OTNKaaxYQHJeLR3638cCJdDZCEhI+hKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kd9vv4rVm0sjitt000kEuiicszVsAdJC0xoqtAt1SW3E4WpB78MitWxtKBniXXA5vrll8XcVqKuaxEYinCV4+3ts+ow69VpThHaiK0YRrOmzfgM6xFy/N82J+/Qpsk4nCOfuTPlJl8GujPhlhb3TDS186e6aBOHujE+MV47T4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZDC2cPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D01C4CEE0;
	Tue,  7 Jan 2025 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736290879;
	bh=Tdj0gsQusE+OTNKaaxYQHJeLR3638cCJdDZCEhI+hKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VZDC2cPsURmmI0WKlaTZfael4OflXSNL6zsjL6pGHTSAdjvcCqZSN03jo8fBFY9nl
	 YTjMdEqIkH+5gJKFF9MoleWuxlurlneP+i8CpmR17WE2Qis2kzR+TeoQjLXucGTaii
	 W+LOlkau/vrklBxQF/ONTSMG9+kv1LXgBRKjks+IPMXusaD5QFYcsa+Ye2K55OCqVC
	 FH7mdF2qEjQhA2I0yEzA5j6QRpn0m6qPOyC2uG0nb5easgWmQx3AONMOofefDwlEig
	 Ao7mMtIEnyhhk6MMiPE0GXphAM6eETwbrtzh85tMiELfHEnBymGUZNyJnn2XnRvlo8
	 gj28QfAfxvncQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Jan 2025 22:59:42 +0000
Subject: [PATCH v5 2/5] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-12
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-arm64-2024-dpisa-v5-2-7578da51fc3d@kernel.org>
References: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
In-Reply-To: <20250107-arm64-2024-dpisa-v5-0-7578da51fc3d@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Tdj0gsQusE+OTNKaaxYQHJeLR3638cCJdDZCEhI+hKA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnfbIyGLWxt+KD7zEe3ZkNYsyIxEbNBf+rpjPYk5T8
 qV5MPOKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ32yMgAKCRAk1otyXVSH0PvPB/
 9cO0dEz2VOmNK+2Wb0VSKbYqBEbmaBg1yBtY9V0pWZPGRmqcseLTnhSHAMtM80dj04aROvUXe31pZJ
 eKME0dQZco5A/L4EyoJnZ1uQhm6FYfuNiruI2udbw7BoJ/qSpq6uI2Mn9GD5mUg404vRAv4QlrwyMs
 fwKFDwwUbtdAcUT2HSZn3r80jQYcF2HI7xfOpTsCLJks7113bypfzIiehnOlFl29N2gAXQu9PrcLU1
 5PEMN0LyQTJ0LMs9wkypBY9/Qs4lthHfRHzGJ4kCqNp+3hTvjmtBXIrwRIXN0a9vu00ZhxGFI9Uq8H
 /OJyGo3p3aQzfI3895IWAE4hGCbpfu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-12 introduces SME 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64SMFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8c2db201665fd5d44eb937549d25421924569498..94ca9cdb0b167f88d79e23ea4cef1abaeea5c13c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1113,7 +1113,7 @@ UnsignedEnum	59:56	SMEver
 	0b0000	SME
 	0b0001	SME2
 	0b0010	SME2p1
-	0b0000	IMP
+	0b0011	SME2p2
 EndEnum
 UnsignedEnum	55:52	I16I64
 	0b0000	NI
@@ -1177,7 +1177,29 @@ UnsignedEnum	28	SF8DP2
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	27:0
+Res0	27:26
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


