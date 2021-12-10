Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50E8470937
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245530AbhLJStD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:49:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:47988 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239133AbhLJStA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:49:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F0281CE2C91
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A641AC341C5;
        Fri, 10 Dec 2021 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639161921;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHaqtPTt0kVZVMlrqnGWwdeSloy9qX/YYLlsu/Z1bk+AkuqcF9abltdkgHlxIk9CY
         ShI29ZtOltFiAvHV79UEC0T7EZtWiXA80edYMrqmuf8Pnz7+uDcWRrEMyaZDwW8Gzm
         C1suTyOjSY2dHCRTWrMMbNi4Ud9yjpMZIyLmMIsUx17E/KkJNBzLeFJrqJZkE4Jsfg
         OpYaK0xj58Ek38XDCDOIkttMgrWwTjRkqrR0XGdtANK7YrTJf7s5RXg4q5CrASg44P
         B5EDFPRBiUFPP6TNTbyLBWkwkOw1suYghJ1KK1YIzirS5o0t0NEWvMGa7ua2kxLwF6
         BmfrKKKGcB2Og==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v7 35/37] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Fri, 10 Dec 2021 18:41:31 +0000
Message-Id: <20211210184133.320748-36-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210184133.320748-1-broonie@kernel.org>
References: <20211210184133.320748-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs59aMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOfWgAKCRAk1otyXVSH0Cq8B/ 0Swvnr/GmluzqK0oeiLEWUjtBEBL5tFtNU8hpCMDyxu8fTnveDCi9UauJykwBO05KTvxhcHfygA6+n 2O/lIQBVhb+lequkAgI1LGg5a4u4gT1vNS82wcs4QQz+fNH/qj4bmSAdirVeWZgKAcX5ahou4VviVG j37yPajyt+OnD25rLNtkeb9bxOj+qZPXqsRWkQriZjfOiudQHtTK5IOqZGsKUuUs4pQBuGiZ/GHdcJ CPefUWGNk/tVwBpYT3/8E6xno3CQQkLuOgMMI1UgXP21SXB/aSCF3t2D4MFYKssIbiRUWAP7+Op68J IrFEMCh/B4Fx/+WrJbemtwQ8e3pacJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to allow ptrace of streaming mode SVE registers we have added a
new regset for streaming mode which in isolation offers the same ABI as
regular SVE with a different vector type. Add this to the array of regsets
we handle, together with additional tests for the interoperation of the
two regsets.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index af798b9d232c..00c35b9db27f 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -28,6 +28,10 @@
 #define NT_ARM_SVE 0x405
 #endif
 
+#ifndef NT_ARM_SSVE
+#define NT_ARM_SSVE 0x40b
+#endif
+
 struct vec_type {
 	const char *name;
 	unsigned long hwcap_type;
@@ -44,6 +48,13 @@ static const struct vec_type vec_types[] = {
 		.regset = NT_ARM_SVE,
 		.prctl_set = PR_SVE_SET_VL,
 	},
+	{
+		.name = "Streaming SVE",
+		.hwcap_type = AT_HWCAP2,
+		.hwcap = HWCAP2_SME,
+		.regset = NT_ARM_SSVE,
+		.prctl_set = PR_SME_SET_VL,
+	},
 };
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
-- 
2.30.2

