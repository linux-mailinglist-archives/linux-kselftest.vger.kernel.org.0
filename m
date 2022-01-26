Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8549CE82
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242865AbiAZPcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:32:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50030 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbiAZPcs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:32:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 320A0B81EA8
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E4EC340E9;
        Wed, 26 Jan 2022 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211166;
        bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHwjbQRWRnrBgUU7VnH4HwgMC0wUnmRv1nutfz8fgs46/8Na/7zB5mcWQIY/U98HS
         fYSDE0k6eifKSAyr5OAmiBgLGfRtv6JrwYraea7fRewJhKg8RIbCut2IvYZZq33MQO
         mYGmb0BNpANqvczNYK/g6dXKaZ4SHoI/61hrPZXrIuJXoe+FhzJoIiyV/tLhm44Ddy
         g+N3Oa4OjS460oCakVL9MwJoy6CxXSYwbWFrWxa8htbjDwZ0LZshEDDs+xaGv7mv5X
         Rir5M6+NjWZK1gu4/b/hKBBv1V8UAVlOWetrsJqpbMgVMNy4u6gtjtbQn/UA7ZVjKn
         CWAA2VT40om7w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 37/39] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Wed, 26 Jan 2022 15:27:47 +0000
Message-Id: <20220126152749.233712-38-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhyKqGPNGZXH7z6iwfnPdNtlzhXYbjCCRcGKiz8 vwxyiyiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFocgAKCRAk1otyXVSH0MzTB/ 40+l9PdyJyNwSWKkAQTjBS2CPl2JqgTo/FBRvlXhV4ZoedXN9pRfwUrwif9DXJBPRyGxRgnEevRIw0 l3A1nYQyDZT69HQWfDkbzp3lGKpbSImc0XQo1j9xxQrZM+6br01f4YVGDFh5Qoy2kA659wU3lS/OsZ J/aVI67Eq/9ru7ocZU9WPSKv123ZU2VxBVHmHgP2HpPnvqtV0Ersgh5EVARrU9vl58FPu9O9bRjRh5 cP2QBc00gUf/p7f8S0diSaXvrB36mbxYrGw2FK1hYAYezlgBpFMQ8hKEftHkXheSiu4Jv3Jy7CpACy NPLTq7N1IwLOCDTMQ9Gt9mXSro15eR
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
index 90ba1d6a6781..fb74b11bab71 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -26,6 +26,10 @@
 #define NT_ARM_SVE 0x405
 #endif
 
+#ifndef NT_ARM_SSVE
+#define NT_ARM_SSVE 0x40b
+#endif
+
 struct vec_type {
 	const char *name;
 	unsigned long hwcap_type;
@@ -42,6 +46,13 @@ static const struct vec_type vec_types[] = {
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

