Return-Path: <linux-kselftest+bounces-87-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378077EB22B
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D67281272
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FC3D3BE;
	Tue, 14 Nov 2023 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2qsC+hY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5841229;
	Tue, 14 Nov 2023 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F851C433CA;
	Tue, 14 Nov 2023 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972542;
	bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F2qsC+hYRzp+zkl0cu+7wANu/Kg6DJ2+Osfeb6Y+ZhcNB6ONN5g2kBsYqSheH3/dZ
	 rBh1J3R7SgBi6FZqPVGP6hrdc7d+pp2ERrMxqAnYaTRxWJ+cqmIwTN3Ric5QDaRjWR
	 142cPWHrRfwVVbwl3bG6byEhgC0ZItoVBjQAdvzym/WfyieIcDENl4eGbbRq6GsY9j
	 SJwuNdrX0Irs9KAXol/8m6x+JN0mJQd5BzYxQcuit4DK6Vo7DWJX+IVE3rGA8U6Bvl
	 oVWGN3SJheOAfGXuvQjEDNS1dcWzsEAqI0CsbleL8PRFMUDQVi3NSPi3vkv3ZY3FUR
	 hijiL1ASziW5g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:51 +0000
Subject: [PATCH v2 06/21] arm64/sysreg: Update SCTLR_EL1 for DDI0601
 2023-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-6-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tnXYFwh5n0qNcsRXurtqbaVARrY3vmLHqYkv+SC46VU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WZQLjjlJnDG6sLMYbbDE8khFwcKUOr3r1xSwhg
 Tn3j2uGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmQAKCRAk1otyXVSH0HacB/
 4tdRseQb8KW8QSZ53F1aeLRN6HJJXEqHZvfffd8e9793kNW1hft7Gk05vbS3TkhjaVk3cqcb9F8PzB
 RpAb6DOkvap2BBdh2gkIHqEBbZe+Pcr9Xrzj5N9eEO5eoDBBPDuDSaNPAISwM13AaibLrXJv8wxaFP
 hPBMG6G7WWvnC1jOTJnnl5Ae3WSYfzkKIsRnaRjK4vOxgNNGQajMYUqWv7p52pH9q2HESPzgkaGKBC
 MFhC+vLmO/zZuDCRL6tEuwE3BqvYwgpRBxV4RN1dGwUTHNEhDf51tRnbFnVZV6DUJyC9rW/LITIxQx
 hjUJSZY1PbZiioeGwZ/+8yC8OPxMn8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines some new fields in SCTLR_EL1 controlling new MTE
and floating point features. Update our sysreg definition to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index aee9ab4087c1..eea69bb48fa7 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1791,7 +1791,8 @@ Field	63	TIDCP
 Field	62	SPINTMASK
 Field	61	NMI
 Field	60	EnTP2
-Res0	59:58
+Field	59	TCSO
+Field	58	TCSO0
 Field	57	EPAN
 Field	56	EnALS
 Field	55	EnAS0
@@ -1820,7 +1821,7 @@ EndEnum
 Field	37	ITFSB
 Field	36	BT1
 Field	35	BT0
-Res0	34
+Field	34	EnFPM
 Field	33	MSCEn
 Field	32	CMOW
 Field	31	EnIA

-- 
2.30.2


