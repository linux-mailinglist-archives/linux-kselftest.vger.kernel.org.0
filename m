Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F5F506A3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 13:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbiDSL2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 07:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242223AbiDSL2h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 07:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD33B240BD
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 04:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45240612B9
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 11:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1392CC385A5;
        Tue, 19 Apr 2022 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650367554;
        bh=fXwWFB6jpNtZae17QXbW3zbq8KuNTW7OX2FF8Uha5Gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGdpVz0HW9soNTs6KH5vmk9pb8aaGwykmCzjFg0KnU1Mrjr9K9xqANpDLNhSkB3jT
         1YHcZ1K0AsmMHTFFbka/tP/HQwCKLevaH+tMZrJ8DnKdmKGifVu9Gi/I7mZst5fYvY
         M/D0gJ2GZtkcUT2U/ljHqDfFnDJW7JoLBcJoW+dkuRJJ8bK5U46n2CipVNJHT+LzkS
         cIWQJG3T3FuEEKxgfpiOSHFlrf3JI9obumj5wCBDsQQvmkaOCFown9h7ij52TH/Tei
         hkLQGuDdnu6+98alnWMoqbUdZa27j+kJVN+dIBQJZuwoNCR4m9vsVjCghOyogrXN/L
         /veExeHiXkFLA==
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
Subject: [PATCH v14 36/39] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Tue, 19 Apr 2022 12:22:44 +0100
Message-Id: <20220419112247.711548-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; h=from:subject; bh=fXwWFB6jpNtZae17QXbW3zbq8KuNTW7OX2FF8Uha5Gg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXpuEazFhET/VUe/nNfuFBfkZb5fRXDAX4kKR1kYv hE3ThlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6bhAAKCRAk1otyXVSH0CceB/ 9mJqF4FiCJ1aDXY1lXBa+avoX7xgzV52r17/43gGWLUsmTahx8EFy/phMLZGXBONkpuMmSNE893Y1O G1Ljmv1hr3woB3blVKRNnJmE8gq9EKeH6jLQQwbbMLKut2lw0N0L0zCkorDX99wR7XBKN7xm/0Z0en JhwNkjjaHtVoTGRsjKbeNjeqvclrALoatptJoly+VsIvJny6RuFei/RRTjeSPYRjndNnJv+2+8eipg 1ZFf+VKtYne/HKbk4Iay8ikg06vmiZn0SkQH1Fj7zHh3eXl/8XdL1SJVgq4QXpMbwNP+xSoQ7tVhOT af76OyGi9NI78Jgcic51XUGJzXdv9m
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

