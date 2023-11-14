Return-Path: <linux-kselftest+bounces-83-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E27EB224
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657D8B20AFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CBF39843;
	Tue, 14 Nov 2023 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nyo4/1Oj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9741232;
	Tue, 14 Nov 2023 14:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBDC433CA;
	Tue, 14 Nov 2023 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972529;
	bh=yGEIdovBwYeKe84KQvqQuF6UfRvXTIIewONLZW3lJjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nyo4/1Oj6myZfkVLxGcOgXOPbAoI7MtHCdrprtGGcg9eSTOSEdWEkOqZolN8GkkPz
	 DqqjYZdrDCLWf+OpGqqmBVIisSxFS5ZrGhQf3iY1oEVHhEyMhShf3MilpnRvvu8cxC
	 viytEumqXX0oIa66PqMQ6NKZk8q1LrRQFtP3YEmUAOZfzAFeONpWwqqvvWnECB5tSU
	 zloa04j0bloxne7oXpfvuwoeeUYyY5UAVclSKOyy6V9tpJMET2G3csP0dgB8dnV9Q1
	 498GyuOXpgEcwxonzDzW2MtRWIobYGRy5DasU12BCBkqrjXbSWRF++TgVhUN2vwKNn
	 qJkYuJ6y1ZxzA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:47 +0000
Subject: [PATCH v2 02/21] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion
 for DDI0601 2023-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-2-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yGEIdovBwYeKe84KQvqQuF6UfRvXTIIewONLZW3lJjY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WWJyAT1EajJpXBXpEaS53OUF2hv6b0h7gWKmIO
 8kBVEz+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFlgAKCRAk1otyXVSH0KsLB/
 wNkHc/y+KAanpOQXfWvRli4Zn0MC/CzlXWZAvxItFPIaXxZJ5ryll61hoVQuZG94LJuKMgUY1cG4Lb
 vpafHI7zqmVuiW5okwEzEVpZVIyFHqqQBYLqJqjpYBkd1/PW1c3nGdpFqqLaoLdSBLiQmLIV+f+le4
 NyuV3biiM6OC8cNxteh8skwVQdHBURItpQiAW7jmvctFJVuUPXXGYQai+Bdizx/kbCcfpJ4z0Qkzd3
 r6qGtPmfGc0KhCWSsUEpEZ82Y6d3B3iBKVXiG47WepTEYqkY/6yuYaGK9JcufvnBVN87ToMQn5yqCV
 hkL4oxC5cJmVIeru1AzdyXhC5EAKeR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines some new fields in previously RES0 space in
ID_AA64ISAR2_EL1, together with one new enum value. Update the system
register definition to reflect this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index f22ade8f1fa7..27d79644e1a0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1365,7 +1365,14 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR2_EL1	3	0	0	6	2
-Res0	63:56
+UnsignedEnum	63:60	ATS1A
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	59:56	LUT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
@@ -1374,7 +1381,19 @@ UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:32
+Res0	47:44
+UnsignedEnum	43:40	PRFMSLC
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	39:36	SYSINSTR_128
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	35:32	SYSREG_128
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	31:28	CLRBHB
 	0b0000	NI
 	0b0001	IMP
@@ -1398,6 +1417,7 @@ UnsignedEnum	15:12	APA3
 	0b0011	PAuth2
 	0b0100	FPAC
 	0b0101	FPACCOMBINE
+	0b0110	PAUTH_LR
 EndEnum
 UnsignedEnum	11:8	GPA3
 	0b0000	NI

-- 
2.30.2


