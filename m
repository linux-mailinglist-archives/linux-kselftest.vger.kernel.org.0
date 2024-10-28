Return-Path: <linux-kselftest+bounces-20845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594679B3BC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047C81F22DC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6963204947;
	Mon, 28 Oct 2024 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEh+k01m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917D204940;
	Mon, 28 Oct 2024 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147202; cv=none; b=SoFdIg4INcfEMvzyw3mSu/tdsY4K6yUfsFUxZs7AFiu6wwpd24ImV6zfQabipTY4OM7PJASjRsJpzcKxC5yqwL2budgverv8nP5tbNPkGzFVeQu/I2yZFA+o8d/gF52+bHW1RbigoZ0iOkgstEYsF1H8lVWmnRk5qoAnRrUe8p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147202; c=relaxed/simple;
	bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEdJa+8fXl4+2ZXKLNoeVmLEz1HhPgbE/uyzk2mKh4kmLJihfk5Y91wdHTsh6gqlnubrNh44KgJqs0gfP4AQdAaAbGRuMtSykGGJLnMIS9OXc/VdtJYisjMMcCxlEgBlRd+IiM43XFUZAlS6uiYsmCFy0gj04mkY+ZzVDWnLkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEh+k01m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A217DC4CEE8;
	Mon, 28 Oct 2024 20:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147202;
	bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NEh+k01mKNAjZgDUCPOTdCquL2nTEfy+ZnLWxFDAsaCwzT+uceoQMdemFHfflgUfd
	 GwJrX3IvpRTWcdXJS0rAmxVWgcjFBSTDjJWsBYLKruTDveZhROgOvRQAnBlqhuufZX
	 IOtbp7LHObELb1OhoCOflwbNDXd5F/yWFJ6CZqA+er57UH92+7a4cLlEUo9W4bN3cS
	 wBYJoTQcGt1t0LYNPHixT1d1h7h1xsKOo/t18Wxrv7HtpJc1n3wnf6zRK5j8l+tnbb
	 n+I5y9AH3Og2Eyohj6nDm8zOnTSSlguVLlb29LnSbd9rEFG6q2O4wCMVQjdUS+Otte
	 10OylvTyc8eJQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:15 +0000
Subject: [PATCH 6/9] arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-6-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
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
 h=from:subject:message-id; bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/Nq5LJBcitKLDEOlNZDCWc/2DHd32O0aS1++eFY
 SxSju/2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zagAKCRAk1otyXVSH0GBsB/
 oD272FS08Rd91ruHA5rXXew1m9uEA/IO7IIc1f+0kZxT1TSgFZ4W5bZuTvHf9SUO+0bN/hKAtOH/HT
 1Kd/q5uus5t9et0SXPzQ8NE1SBpQtDjKVfICT78BR6O9m0RnsDGVZKq1JrBIZfEiXgp28xK+vFEqVH
 MGs1s64zzM2bVKGSGAaQuct8DgBJKs1vLW6T7Nva4kAxB1uofJ8AqpmWaeXT1HqK2f2mBTCC76NZ1u
 vy6qflr5j+k1GTyA9jgqkbIZle6nq3wwX/gPOlx0ns++b88Ue4INdFevmegh4/zEv4q2S7z3JQgiwP
 8j7unaCUhq5XOi+xI7vpDk+/VsO98+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces new features which are enumerated via
ID_AA64ISAR2_EL1, update the sysreg file to reflect these updates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 808bbd6d3a40a4cd652ac25d686f11ccafc5acf3..c8cc092fc0f63f91c7e87d679266a1f8a38176b0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1521,12 +1521,16 @@ EndEnum
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
2.39.2


