Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B038641E0E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353379AbhI3STI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 14:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353361AbhI3STH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 14:19:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B777561994;
        Thu, 30 Sep 2021 18:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025844;
        bh=YiArib9lDZUhVlxhO4SS50LGFXBxzcgVNmlAQWvVk0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKguPuNLzVRKmySrXqd8MRYfguHbVNiX+190SB1ycoLn79JzR3lyZ8i4IO7XqGNLX
         /zGIdssS8W4vYL5y8oU9n9SeBui2qmkjuxZ/X0sgYyarsAX+hHnYHvgxJV8b4XJPq7
         3iL9wtX9dczPJ7EbKqPwiUtCARQe+RRLXaimCs64V59cwDNlF5IU9S7ZvJhJMF1Xb1
         6njJwLsA1+6gp1it2Gh0nDD4eiG4YmBDZoweRlPpeuxZZoNAqfMIQSCXdK4fMJifRo
         ttd3SGoiBDRavSIkHQVQ4C/RGtfDUsVTdyxIZza7Cz8AJN6PT1OCu81xGAQTlty7Wy
         YIPSqSwLo8hnQ==
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
Subject: [PATCH v1 37/38] selftests: arm64: Add streaming SVE to SVE ptrace tests
Date:   Thu, 30 Sep 2021 19:11:43 +0100
Message-Id: <20210930181144.10029-38-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930181144.10029-1-broonie@kernel.org>
References: <20210930181144.10029-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=YiArib9lDZUhVlxhO4SS50LGFXBxzcgVNmlAQWvVk0s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVf3e3wF+XsypO8VqFraJMHCQiqB6TiEP4kPv0HtG Dvpm5UyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVX93gAKCRAk1otyXVSH0JsKB/ 9JPOm70H8alGKjZJ/R2CAQjzsMroapTt/I5Y3+9ah5vCyJabD0xvgvdrFuvblvdeDEBOvAA9Pg7QFo dKRPonlHz3mofoBysTc9kwUmnlUmAj/S2qfLm8ssZ6x7qD6bxdqc7iVGPuSveweq5XSYbF3swJ5pal kG5ndcEd1WbTkT878lFbIfyApBuIQThLRu/yaJDiBPg13cRWa1RFNvCFGzcXzfCkM3ROqfx1384mQ5 SlHy7uWT6vpk0ORSMV6tnkn9vKaAGlqOudLoeLzDwb7KqkTRgavdP5OQhhWOyPNgmehl64kykPbabT G5OgGTp17dR1ddmlaRakLmzqof4Rd+
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
index e200f7ed9572..654ac0f8f73f 100644
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
2.20.1

