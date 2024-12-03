Return-Path: <linux-kselftest+bounces-22742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD699E1CAC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659BE1676D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4BA1F76A9;
	Tue,  3 Dec 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpFHHavn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C91F75B0;
	Tue,  3 Dec 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229840; cv=none; b=WigMy2TvbmtEKe8RIliHjta0rAddwB3Selzf2MAjW3jIdcy8G3+ZtXhguU5oCW7kT7QS6cgfdua5M8IUfA/wzrYnz71o/5meUg8bgTii+q0hKUgRUFS8SFrDOkBB1mKwCKwFbpdbxPHtUy6lxWNJcPtIxKNBECrRyuQ83rA4BmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229840; c=relaxed/simple;
	bh=EJS6cgRpKX8lhOM9Z2U2OyNni/XrqcdIMqgpN3jOt9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxIAPh84bZGobfF6cXlYMJxAifRL+qe5T34NBhzT+3CIQaL+YzW85IXM1wZo94WkVPiKJor/uZoJjspfGWlyFZMBVuiWJu3brslhnI0bIhldfia+aHG3HPxL0mBGv1lXIdfFqlv2r+dHsGI8aJGncSB9K7vmslNcvzkTuuuynlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpFHHavn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FF5C4CEDD;
	Tue,  3 Dec 2024 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229840;
	bh=EJS6cgRpKX8lhOM9Z2U2OyNni/XrqcdIMqgpN3jOt9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GpFHHavnqh/65aoJp2UGMoEbiC2+a4ajKJxsQoWAUo8ocdkYupQ/zvrrqVtK/87GT
	 rH5iE5BB8RWMmsFzw42kBWbTRCcQ2I7e7xU/6+0HbfA15IZlJfXHz3RQwbTCiaiPhZ
	 9LiSBWGlCc6ev8z5L7afxE2DJoLsJkOSs8y6fEAAYUOjomZLaUgMiuI78EcTxjvfiV
	 Fa/c1xeuPDZYLwZAPe+Zrfy2IduS/zabXq477Pvm5Y3HViRr1KjTQJ/hEPvsnRmNt3
	 JrucnNpGV2YrJ0w/ekJiEt6mO/CC+O/wZiRXLLrx5e+vBKcldLKDq+WscEH+dh9gvV
	 WRwF+5Ss7lRbQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:25 +0000
Subject: [PATCH v3 6/9] arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-6-a6c78b1aa297@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EJS6cgRpKX8lhOM9Z2U2OyNni/XrqcdIMqgpN3jOt9Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz4GZPk6EOBZUaoV4zRxu7Rli0wsiye0feNwuA9
 7WLttSKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ078+AAKCRAk1otyXVSH0JwSB/
 wNUoK5Q2y/2oZkMqGqP4YcOOfJMOTRiEkdFEKe+7gJk7dpGQDlI3/GFZ/0tU7rpgltEDucIwS8fG+Z
 HxengsD/m5dqC7734pajuHEvwgo+HEOc7xSYMP7WsqfLyTXYBr0lR+JpsfrsyULFkCfdNq9f2sOOjT
 otyDCS0IzRMCXBMyIhp4P/3Ld9UYc4tsCI8wsHVTSdMYqod1+d6pjLw6FZiteF2/qOylLZgxsaEcY9
 cBLGmr5BHilHZrP+LNSKUiEJ3DyW5RRe79Dl9M9HIRSOdPtEy1pLtjr5U/2c/GUgWx5ZVCP8xaDuez
 gNT2lqpUWYGunwmUpN58nQeSqSpXsY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces new features which are enumerated via
ID_AA64ISAR2_EL1, update the sysreg file to reflect these updates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 0253d3847aeb2294da04b2b0b3f33f81f32c849f..fe55c04624de74a6c1a5e0be45363b9c46ff1340 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1556,12 +1556,16 @@ EndEnum
 UnsignedEnum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
+	0b0010	CMPBR
 EndEnum
 UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:44
+UnsignedEnum	47:44	PCDPHINT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	43:40	PRFMSLC
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.5


