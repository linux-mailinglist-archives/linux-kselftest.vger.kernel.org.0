Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD22436A35
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 20:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhJUSMD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 14:12:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229968AbhJUSMD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 14:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B331E61B00;
        Thu, 21 Oct 2021 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634839787;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQNTG2yE60uaKGM46bNs7GbvO1Y2ngZyVeWM2URJ3UrEcwzDp5947MF8fw44PLyea
         x2Qr8Ov77/0qer7+86UEdb6u1700QBDzgP4m4qrlHQ2pWAxYDfIrqB0rVoi7ixb8nY
         JNBH2lgDQd2qvryMHRot8U+5pyLlq7z67vPIrWCq+DJW3RmiTTnk20U7tvLR78AQ/h
         JimeI1aGW1S1CZ2Yd3XrGzxIwE51B+AU8n3JEYUfk8VijL2veAgTKRMYqAT4KXIYhq
         9NCa6o+7G45JDkzbGFFspKObwafGYocMDSizFofGH8fm2/2LCCsfBfy2edKhF3ODgv
         95H6uFlGQuhLg==
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
Subject: [PATCH v4 32/33] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Thu, 21 Oct 2021 19:07:21 +0100
Message-Id: <20211021180722.3699248-33-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021180722.3699248-1-broonie@kernel.org>
References: <20211021180722.3699248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhcaxXMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXGsVwAKCRAk1otyXVSH0PHuB/ 9fpMPv2Itk5TYFrsj8uFCP4bS92nP+U3mEGuQby2opVnEkgcHXrjYxyE5ITnIVJQt+Fnfu/MOH4+TV B7ymp5qkWHhyrnTjjEKKoL9O0G01wn/4fNbq+Uak235xS4Lq7KxXAmAmQRGWZNSVymR07mEnZt5I6n umODhtnVIfOoJKuTxk24h1Cf/vWhajCIoOASUNK2xUulf7b4nq6B+Lq5X0mx5wgabyZsDYcNkdMAMc 43fyvaWph+CMMdiE9oZp1v3Yh1yEtIG2wX4y7EOD63+4RitQC7m4D9LemDAyXv4uvRDVkvZawHnetW kFLpzsqJpgvMmmQ8lRfE1/rC5AGCAe
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

