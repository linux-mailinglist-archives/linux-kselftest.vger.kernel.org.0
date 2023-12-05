Return-Path: <linux-kselftest+bounces-1157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40B805A50
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED324B207B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE0F5C8F1;
	Tue,  5 Dec 2023 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADI9sPog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249564174B;
	Tue,  5 Dec 2023 16:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F8BC433CA;
	Tue,  5 Dec 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701795074;
	bh=7RNGzDmYQmscIH9JLPqJXNwGek+pQVepVhKqfj7iORk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ADI9sPog+fjm9K3T+A9ZApXzEebNj3iy0cn9GF4b1skSpglBT9KEzLjlW5LpOuQnF
	 gla0szlkjmrr6SGLwgk8JkczMUBy/Fmmp7vhp0JvX9MPIGiQ6qW8ybMx/bNb5CyeDm
	 /IP2hoM9dQ8KYr3mg/ZboPBVrTH8viiMWhubBzmJMmXKByk20lI1qVzEykw9TdD/YL
	 ofAeJpFPCIQoPn6MFbOM9LDto7J8Y+WMtIbgObXp+wbkavK4HKG0qM3vE8+550u2at
	 f/czwxuvzEQFO8iRSl9nPG+WNIDml3Z6Aqswf0JOwlME2DhAyT8FtoE/ZL/X9M1GEF
	 4bsVPDYsaOyOA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 05 Dec 2023 16:47:59 +0000
Subject: [PATCH v3 01/21] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-1-dbcbcd867a7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7RNGzDmYQmscIH9JLPqJXNwGek+pQVepVhKqfj7iORk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TpX108CHonTAhZqb98RgydAoTiu67u4fx1tQ5P
 vBeCHyKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U6QAKCRAk1otyXVSH0B/dB/
 0RaLXek3gvFEvOZl1SWe1zdDv/e4Q0eaM5oM/hhkXiZKwWXB4R8bg9xdESjxJyhtekmqtIbTZS9Nx0
 b7lCGDvJTiS/59bSAcdIKb9KGfvicEnoh6lJoVy2lMfJMmcufgK0cWw9XuazhKy0499kxA9U+1tXZc
 hmrgZQZJPfftJWRURroCGHUIALMdimzVhvYwLb05f62E+9SJUb4lxQ16Oy00EOgCxVrS1twwLbD08b
 58RDQ9DI4x2BjFwkKQqqJTjccC+oV/5KNGemgZ1IfcsoJYByntBBaq6f8Mg6YUEl3t1A5SXnPyTyJN
 hv4FbexGnUDga5QONSsZwVFdBC4Ohg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines a new system register ID_AA64PFR2_EL1 which
enumerates FPMR and some new MTE features. Add a definition of this
register.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 96cbeeab4eec..f22ade8f1fa7 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1002,6 +1002,27 @@ UnsignedEnum	3:0	BT
 EndEnum
 EndSysreg
 
+Sysreg	ID_AA64PFR2_EL1	3	0	0	4	2
+Res0	63:36
+UnsignedEnum	35:32	FPMR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	31:12
+UnsignedEnum	11:8	MTEFAR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	7:4	MTESTOREONLY
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	3:0	MTEPERM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 UnsignedEnum	59:56	F64MM

-- 
2.30.2


