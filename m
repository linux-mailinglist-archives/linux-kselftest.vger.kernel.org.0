Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBA4F94EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 13:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiDHL7q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiDHL7p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 07:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF237E0AD
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 04:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B806206B
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F70C385A3;
        Fri,  8 Apr 2022 11:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649419061;
        bh=fXwWFB6jpNtZae17QXbW3zbq8KuNTW7OX2FF8Uha5Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X92WI7z4RGG0VunIHRyEp1idvjJC5w39+Qvo2uDLOIOHl22mECCvQg5DiBV8uY9yB
         60rEC/Z5OYMLL8yZvWmZDH76HpuEC6eHZsLoEQeSsOk8I6JP7u1qZO2S7wxkhj/046
         /yOIFhEoqiDzmggUfh+fbXCwZxJklPIvmF9gcHHDOaUKUfw2exXsyITggjWJ1gZVpz
         7z1ziny8rb3nrdK+NSesol+KCLLEKy3r+cFK5Y8WjjB8V5x5qaAW+nvnBOtCN32qe0
         eFOj9ijyxu93f/L+dhUkZ5O2s2LORzOpx/42gvmYSl106bPFaZdOPZSoJLrohJH6At
         r3Da5gtOxsrwA==
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
        Luca Salabrino <luca.scalabrino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v13 36/39] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Fri,  8 Apr 2022 12:43:25 +0100
Message-Id: <20220408114328.1401034-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408114328.1401034-1-broonie@kernel.org>
References: <20220408114328.1401034-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; h=from:subject; bh=fXwWFB6jpNtZae17QXbW3zbq8KuNTW7OX2FF8Uha5Gg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiUB/bazFhET/VUe/nNfuFBfkZb5fRXDAX4kKR1kYv hE3ThlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYlAf2wAKCRAk1otyXVSH0GkMB/ 9mF487zFtWpdx5GykcBjgpGduiVWvApMYQf6xeNVOrUOEqdFa5uMl0KiERfCRnnXZ4UQg90hiam7Q+ iZFbeW5ftjHWfnZ05yc1MXP9lF0O3uhSM5M1BVMprh2JzE0PnL8psYbvXPR7wT3PT+XAWWZQix7P/v ApxQJecxhdRS7z6kD1OhwUCWfHjaXD6LS0HpvWW/WST5Dm9aec1y9clFRJJMIyUwXjy1J/W0X++alD 8bgow2WQ0UgKc3VrF9VJTIbLCiAUrjBlp4ZXDcA4bnOX/GguNsHCmPfL3JZ5tJuKzza8Nv4BCBOqTH TrZI8YyI1qkR1uNojmulngJF2xn4qC
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to allow ptrace of streaming mode SVE registers we have added a
new regset for streaming mode which in isolation offers the same ABI as
regular SVE with a different vector type. Add this to the array of regsets
we handle, together with additional tests for the interoperation of the
two regsets.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index c2564480b750..df45e4f9465c 100644
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
 
 #define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 4)
-- 
2.30.2

