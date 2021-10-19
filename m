Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAB433D6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Oct 2021 19:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhJSR1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Oct 2021 13:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhJSR1l (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Oct 2021 13:27:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44093610E5;
        Tue, 19 Oct 2021 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634664328;
        bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BdLYbNwjvcMxuvCBdyc6og508dRMsW3AWJjRXkzXsnxX4F1KalZvdk3fOi7w1bVjG
         c4XJLZNDpQEwdsQ6v0GMKZQEiwo3EB/PsbKa4CiBVt43Zy9NZJJcHz+GZnZ1/PtAm8
         4PKJi5AqMLClIaYJkGx8JXbjVlUaU8LeyCaynt4GSqZtKMAy93BEsJ9iykz4F+4qmi
         pwcPeXBtZdPRCcP9pH/HaQpp0eEojWJn6Kv0uCgm8Z+krvNdjIl3YwWs2RXZi52+g1
         lriGLLNW2iQ7u2MgBzQE+zKIcao0HhXuXy60v8QIv4yyujn06NiF63YAUt6xooCltl
         X8+frVo2MVaUQ==
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
Subject: [PATCH v3 41/42] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Tue, 19 Oct 2021 18:22:46 +0100
Message-Id: <20211019172247.3045838-42-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019172247.3045838-1-broonie@kernel.org>
References: <20211019172247.3045838-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=ZN5JIZMYAQ+hgzYrUF3T4Xtxh1popb3QWVWnFUDvm0M=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhbv7jMw1aSMaLYOpSHmlAJ01VdHXdXklZl9UT/zmb q+DxHDiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYW7+4wAKCRAk1otyXVSH0AXlB/ 47iBjZq6BHVtOOhe6hLVMdth9nb67ZoxmMsGgIdQWXree5OCbmAf/nuVhkVGtrq0YPt+to0r++tw0H UeuFRTBz+P9BWL1WUNKSl0DnYiFK6GMboZczQo45Pzlw6JLis7LHk/acomzI18VtW4opp+7aWjIHHi McmYe40g9vV+Xi3HRNp8Nh6uMmD+ZABhQYsfs6JQzdCSxpvqSlnFZBXr09eGD9Kh5j04uJwQ9tw7ON VJ76cdLmmspeoWURenG5OOF4T5fdsa/p//+tktbiXdnaiyzLC8gPwWXo7zvIEcKmMEctEcHhZJLOk+ Ywd3gzP6huYtVgjkX7BtydJJWNdryJ
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

