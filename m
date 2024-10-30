Return-Path: <linux-kselftest+bounces-21134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D69B680B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0B51C2180D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8792141B7;
	Wed, 30 Oct 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCA0U0dl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6D2141AF;
	Wed, 30 Oct 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302835; cv=none; b=UvFDmqAsqDIMMpgEx7ZoRdaRTEZe2xfL9H/QMsNpAKkTIdVn39QLAupmChO6/OwQPxAhR7W6tHbtlGdLjsNiTt83GxiEi8onN3knYEuoAtJKob/xZSIibJg2S6Lqk893+HQPsJJ+V2WiwfjN8cXQnw8h0Gs0kc0yUM4uWd6LtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302835; c=relaxed/simple;
	bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B61y/MDZmD0cdwIqvZqXCL4fwDWM0L7qGWmOooyOTquDs/wO7dCdempVG19mZeAFcDyyvb/YJ67SuN5Q+/xMDcJ1fXPRY43oPHRPO+zR+5fUKG2ecY5sv9KsUe2ripDt53ZescYrVCtejjhjnx03Cgku2hMhO7ooXpAuKkdb6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCA0U0dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19226C4CECE;
	Wed, 30 Oct 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302834;
	bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eCA0U0dl+z+VY4f3uqsvPVruJ5VnElkVGAOb4qDC/ye4ApaNBf3QM2Tp1Zw3mhIcp
	 W2ZiA2IjtQ9gqWNAknMzTkBqBKMVDWvS28cpGGoH8v7quxfar+NHLJRUU4HStHE24t
	 d7HfnqW0aBjmj3E8yEklVChwNj9zYRmuxhk4aSxlrHNgnjTaEpJTr72QqS+FVF+Wzr
	 IvCRxOmqXA2adzAd21FlVsVCeIB41QoIy3CxtoTjJD+VAVuPjijvZDSy1rsQeTdVR2
	 HOQPoyXELEvZU/1yc67jGQADI2AKVIkl3tSih5hT4E3k/gwysMt8HNz4CdwW+Cg4hD
	 y0KZKBxxEKLXQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:47 +0000
Subject: [PATCH v2 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-2-b6601a15d2a5@kernel.org>
References: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
In-Reply-To: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNjyuuW10mWnMe12YpYtpBbILw/oa1vcfWlAIgo
 dNMLcxiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTYwAKCRAk1otyXVSH0IFuB/
 9CwnqlHJzdVflgz0pHLn9L0kQFT2xOe1Gt312uazTWgyewYu7iK3X9PFcJQmMHnN6O3pjqxt9wEPlh
 LF6c9OabYyqx7POjS2VCXvctjF2uW7wTVG+cakl/pgOQPapDK227bFrTH2TKPCHPSa371QaZmJmka7
 DRRKmaN0iMrjSLcJ7tHuArMIQBsiplDn1zGjPnpHgbHq8gQyutvsMQrct1Dzt/OjD1uC3kU0LymlZr
 P5dE7IaMV0yED6omn7LrMOea1CfZM702AkSbbKnfCu4EzC6/oV5IrTHzuht0DrGtd/VKcCtmkUZ7Fa
 Q70ICvdhsRLN1MahlaDSaRrpqeG8it
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines several new feature flags in ID_AA64ISAR3_EL1,
update our description in sysreg to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 72d6ff1a9c7588dc4894ec6d673791fde108a857..c77343ff0901bbaee98eb76615dc7b81a563c4b0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1531,7 +1531,23 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
-Res0	63:16
+Res0	63:32
+UnsignedEnum	31:28	FPRCVT
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	27:24	LSUI
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	23:20	OCCMO
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	19:16	LSFE
+	0b0000	NI
+	0b0010	IMP
+EndEnum
 UnsignedEnum	15:12	PACM
 	0b0000	NI
 	0b0001	TRIVIAL_IMP

-- 
2.39.2


