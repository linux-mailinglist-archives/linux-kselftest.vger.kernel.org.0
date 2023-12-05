Return-Path: <linux-kselftest+bounces-1158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19624805A51
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C709D281CA5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271515B1E6;
	Tue,  5 Dec 2023 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrmJaaJz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E4C4174B;
	Tue,  5 Dec 2023 16:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA0C433CD;
	Tue,  5 Dec 2023 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795078;
	bh=yGEIdovBwYeKe84KQvqQuF6UfRvXTIIewONLZW3lJjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lrmJaaJz7csx4cTSAn/g53zpNTXaWkn2ParAcP/v1+H+9KiJiv/gCs2+j4XkShfA0
	 E2IdUfMUy4GJA7dhSkqa+lq5uSIUOiCTW/6zxmfsjZ5yYM15HnQzdt/ueaIPP6jS4g
	 K5e9zshdmnNJ57AJgw0IL9ZnDdI0r9M0d32pV6m2zF7KbH533lI+dq1PUkGbCuMvAo
	 FuAODu2KGXFjlOd9kPSZOCF4EV02X+evnoTwal6qHAgFFjEi6DOLgOvNPdbBfgG08C
	 O/WVyVO4XrNKhiRMmvu5Cp7kEW+U1GeDrMx+0WKibXoanJueSk322gMW2+vp4da20P
	 dWBwwx7zvV8ug==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:48:00 +0000
Subject: [PATCH v3 02/21] arm64/sysreg: Update ID_AA64ISAR2_EL1 defintion
 for DDI0601 2023-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-2-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yGEIdovBwYeKe84KQvqQuF6UfRvXTIIewONLZW3lJjY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TqJj/PHrAXfTngRmg+JNAI8LnfyAIgs6I/oO1p
 KaqvxmiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U6gAKCRAk1otyXVSH0FPnB/
 91d9hA/HISKqxPHud6SP9aifwHjcb93GHR5j8Sqs777GxGDtJ0TjRkPjbDf8Ou1apPzIe6racVfzcU
 Cdh24FpAF8bFmoJkXqxMTQUvRvv1oJgC29S7dMzXAQcspAN/C1gyrQ9vdnocgbaLvTi0iEFk/AA8o7
 597tlSqx2qFUNsclQqnhRTKz76R9NfExXaYWC2wDaL9TPt7oeBXuCJ7ui2Rf3Qd1UDUQFgMH/obRvz
 D3ZxSknS5EaX5NDMA3Me/dCynSWUwSOm/rqy4MOqqSISsYI4Q5PmcGIBYAmkJe4BAL+l6rKIGk0BEY
 ZaUwoKzUfmhVkCUZRIV9PCdWQz/teV
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


