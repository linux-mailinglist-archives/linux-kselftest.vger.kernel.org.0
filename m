Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA7949AA54
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1325293AbiAYDgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3421264AbiAYC0g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:26:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF8C0BF850
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01F3B815FB
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B6AC340EC;
        Tue, 25 Jan 2022 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069862;
        bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwj1jbbqBIBrVFn2Trsk1oswuH1frWSBE1DOgnNFSzVgA6YOHFcZu0lT/05euqeGh
         L859W2KqeW0ScQuHQU8tpJjAaUVW6XZhVPaLuMPdp5B3Uj7QcAazl/MtwMGdlTVoZx
         oeEzDUxViJw8uFHE/UdGqnZGhs+bF4rdAf6XsQWZF6VIJyjwvWoS9aV7XpTAv+WbWR
         F4BOXqQTdnEYii8H+RdJpNWPfZSGHCg7/5y7CJ+iku5ugvn7K2zXg7CTKSCqraVlhO
         VUwRMPeAlvGYjNnAp8hrYqrimGoW6DzCajYMwvIC6d8teEqM9IBeRjghs0YQY9seJQ
         0MLTD5w7EvRxw==
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
Subject: [PATCH v8 36/38] kselftest/arm64: Add streaming SVE to SVE ptrace tests
Date:   Tue, 25 Jan 2022 00:11:12 +0000
Message-Id: <20220125001114.193425-37-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273; h=from:subject; bh=Oja1/wO9gzdoi99/QIiaS7CVLDJss5+ewa1C/MDEXls=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AdKqGPNGZXH7z6iwfnPdNtlzhXYbjCCRcGKiz8 vwxyiyiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AHQAKCRAk1otyXVSH0CW8B/ sHzyzP6JW85YBfcAVx+5OnHZ6gaQy9T3EKX4ohWCAVmxGpib4yXSL8uITJ3WfKwK8ZfsYImhRTsqFD U+smjVa2WFzscZuZhfeqDlu7uCgvONqrAeGmJXiDIyF2m9rVUVh4iRl2obatBZ9Px+wQt+0BuAYdRc pA152WCZl08afynO7U5wBoKg1TPD7xqZSvdCjF8I+8K+S3Ot8M05VOCMoMuSRtnmmfTaPuHeZrmqAp q1nx6jmgvRwcqGbVkGrTJVfepApDgm+dG112kuBtXtz52wd3bdqp5y/4s2uh1kbTP7VPTdvFenWjIK 4xRt6waPcF91AXUdjOUfjrnhmct9iU
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

