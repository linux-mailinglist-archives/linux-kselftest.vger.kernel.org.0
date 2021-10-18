Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE72432754
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 21:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhJRTOJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 15:14:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRTOJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 15:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 120B860ED3;
        Mon, 18 Oct 2021 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634584317;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F6kWoVA0JEgyUipGBbD0lg1aQ/HzpV2FfmeGosUOj6lk8KnffMXYxVsYDzbyTY1ZZ
         +8MulOuovmbfa1IbLsvhG+ks5EHf7yrxbu3IreTcJkRPas+PAp2nzqJ9B3Iqxb41Hq
         TMd02hqo6HSAqCAmjCW8dDV1FeQMimKN9ydEkjScHjWl7b2VRIZHtzRTuomzLd0U7S
         9AUuGoMN7AkBTJUxKjACc6/WhNM7AzFDK/t03x2V35bUIeRyoB7uPT/LRpUnCsokai
         lMb6KxPu/aEbJ/pbboCeCLYjup/viyjoEgnPTdYueJZYQluTM5CzvsEBGMKkaX8jFT
         CgVFm2cGwd4zQ==
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
Subject: [PATCH v2 41/42] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Mon, 18 Oct 2021 20:08:57 +0100
Message-Id: <20211018190858.2119209-42-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018190858.2119209-1-broonie@kernel.org>
References: <20211018190858.2119209-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbcZHMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW3GRwAKCRAk1otyXVSH0JAwB/ sGycm1dPNnv1seP6sfaFbCWya4x/CyWgg8oD4WsOgdWZt0ST1EtaV6cywrhGNGxKBAIduhqhW7aT4c CVc5J4/5PZGoBIGC/WJjHVgVvm+3OtnnPZBZVwB9LN2D7i6nbup5QwHUoEyIj0Elxll4WRpxpjcQrS YfZw+oXcuk95WFMBDnSHbyL15kOd7BxLqlB0iuA9E4uajlftE0fcAm2AAqLHLQQMSQ4y89/kLJ1jNr h2/s9qc+uRG63RoVyJCFzT+JN/yzHQQw2oLeWNwATkoLiwF2oMxrGEQfQEB7z6za/EhnV/6HHaA4cM uZk+aRZbLXdoX/vw8QyqhIX8F6xOce
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

