Return-Path: <linux-kselftest+bounces-82-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5E77EB21F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107D81F24C4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF562D63A;
	Tue, 14 Nov 2023 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkbwHHbz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733A41238;
	Tue, 14 Nov 2023 14:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8470EC433C9;
	Tue, 14 Nov 2023 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972525;
	bh=7RNGzDmYQmscIH9JLPqJXNwGek+pQVepVhKqfj7iORk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VkbwHHbz7fjQzXsJP3lTckh1hJCu42SQn+TuyZElCfRdbuIP7gY4OkdM4xXk7XvYh
	 WRE66yFWyBjs3wMwvbD7xK+M7zHB7FnoxOGLBYe2CubLrR68t2RoRr+6cLUhniHIp5
	 FYEZ0vatiJMXitWnGL6GZ9CWnkJZaNMZbFCDlJmKuj9DIGO50ip6kScIpFlxHIFKG1
	 VODa7B83QIHM9uLignEw6UmpXTXh0NC1v97EMpqaVt7JD1c+/TBe/QjkHrmDtE8GdC
	 z3pg2I6lUWVtpGaB+AYVnojqobu2BOuie6mE3DYhfa+j3q+aewiJcKes75l0MTkAL5
	 49Iqlsoce6UoA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:46 +0000
Subject: [PATCH v2 01/21] arm64/sysreg: Add definition for ID_AA64PFR2_EL1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-1-47251894f6a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7RNGzDmYQmscIH9JLPqJXNwGek+pQVepVhKqfj7iORk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WVg2Ikw3iWITXOqCE07VmNrK4zNx+v3EVj0mup
 tNa37EyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFlQAKCRAk1otyXVSH0JT9B/
 4o5Zmux0ogG+GcaDp1D5toS82oPts87/6QehL4Q1kQsA5Y9ZLV49ZupmUYCsNcdxzLf578qMJqxTuS
 UVjC+ZLKBZzWxfw7CpLfwDY4GXrnROS4ViJZgD+4pN9AaJqo9VkCMZ/WjeaAKDMsu0b07jlsQi3e4q
 f6+qgc/zf9gcNfyRrHnWZOEplu3KiKPGIqEBadPkFqYiB4pDMm2QCWK+fwO4ezIwiPMQMXbXYsyb/N
 vBo5ro1KZw64ZWUflrcNLeBo+iCcQDtQoqjEP/Xo9dnZVr1D2j2KSCnE7G4NSS0KEDUcW70zYrQKg9
 x5vPoFQJ9sPyi42NL66fEryehoPWx/
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


