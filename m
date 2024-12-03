Return-Path: <linux-kselftest+bounces-22739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6139C9E1DA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 619C9B39D94
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252891F7576;
	Tue,  3 Dec 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr/eNEEZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0131F755F;
	Tue,  3 Dec 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229832; cv=none; b=iECki8HW/4g/OaZ3+UWcm3cGrmwrkdsZ5xyTJHtBXKlC6G12uvC+fvwFdDRITq28HMH2Mdfu52GX4nGjEGC+i4cabzFq/F50WgyytaURzKMOMNupf0hSmZwJM2Ku7JihOOH1X2YVsaec4FT27vye7khZEwCsO0jJqnxa2QQAfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229832; c=relaxed/simple;
	bh=uWX3RIr6IQi+pDKEUyAenvXadJW9Jtk5jhp6Bdht4QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kXHaBPgCaBLRI6GflXmHu9dKYLPNRNquXwNYRVSwHS82BXmVt6OMMOi0Nfa2rHgGVfgx3kT+HqJPzaU7Mwk3VjbMxF9aKnu+/jwll+lmn/Vk8lj9tzwCI8qm9hTmahmj01fLHqCEnyaTYImLw2Rx0JbYny5fEEKx6gvoJX8Yxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr/eNEEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3859C4CEDA;
	Tue,  3 Dec 2024 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229831;
	bh=uWX3RIr6IQi+pDKEUyAenvXadJW9Jtk5jhp6Bdht4QU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Lr/eNEEZ8RzvLuBBcRpNMfL1WVYXY/Z5TeDzLd811eyo8/2gMn23GvnwHSy8h/SG1
	 X6wz6zCspnpQYZfMJ4/PP4WUnOTrwQrugYdR9zzyAj+m32RipEgCdLQ8zkDsJFwm8i
	 mM2txXoarNGvIHF6VUokt73M90WeBACepd0Thx7MaPuORDD+0dc/06/ccFNEHCto3n
	 racFfVOfMBq2qHM8ilshzxP/aJmp6Woa//hmXmOkOvEuhsMHQ9puXxsjpWFJNZERn8
	 2zVYgZvflkx3x9wVS7hiIy1gm672N3eAJAriSVBrBaoX2DEobodegjDrbFKHZWNFgE
	 3zlEqJ5VlStPA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:22 +0000
Subject: [PATCH v3 3/9] arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-3-a6c78b1aa297@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uWX3RIr6IQi+pDKEUyAenvXadJW9Jtk5jhp6Bdht4QU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz2gRLCtzF4XIZSmmeQcCIHiNRFexIqDKpZifux
 pB7AeEuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0789gAKCRAk1otyXVSH0M3fB/
 sH6cvO82k2eOFyg506a/t8gX3BSf8pOcklH7n1ZvG7rieJW1oohWr+Fw77uB2RClnrFO06Dc6cTkpL
 QqEc2w/eYk/5XbSnOcXoowEX47j23DQR8N3RsrgLOuNkyvtc8nlJ2kjhYkhlKv1jpTy0Zrpc3EA93w
 66kHWJgPDS+oSyqgFiz9FAynRjiKmLarT5c+g3P7SgbLiEibNx1cZtu672tU7fa+ZgX0aPMl+gOlQK
 UeZXgonlixyZFNn7AWjhkJ+xjFscYcxpF5JDLR9k0IWjqxhLJiV+seKuKf8JeX4liEV1qOmCFYsAWo
 A5CkclbsMnxLAsmEL1kaIrY2GwfT4v
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines two new feature flags in ID_AA64FPFR0_EL1
describing new FP8 operations, describe them in sysreg.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c5af604eda6a721cedf5c9c68d6f7038156de651..b44ab511cf5d9d33efd7dca304d0e2f53ce47810 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1180,7 +1180,15 @@ UnsignedEnum	28	F8DP2
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	27:2
+UnsignedEnum	27	F8MM8
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	26	F8MM4
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	25:2
 UnsignedEnum	1	F8E4M3
 	0b0	NI
 	0b1	IMP

-- 
2.39.5


