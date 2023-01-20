Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69A675416
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 13:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjATMEv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 07:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjATMEp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 07:04:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88F7C875;
        Fri, 20 Jan 2023 04:04:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7843B82608;
        Fri, 20 Jan 2023 12:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D84C4339E;
        Fri, 20 Jan 2023 12:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674216281;
        bh=G1YecYTzPBTdDuE6klviThW76hBwjUFMCoL2VKolvfc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QjNKClthHXEOXVQLZHhKAzOdrE86/SOcQVP45uoDTduYm49GUx+4h6FdG0Ut9TqyB
         j7JL5wFs/SepjowSYNVC/f8BsoldCm6/jMjgExcuZmaaUBcWEJiG1r4hdndKguyCcv
         AKfCT1+YSR/IhfkVF28hCr9YtOjJsfTnokN8DIFxgzHpDWessRRew7gghwZ5ad1eRV
         Tr9Xg/snGPxad9ZpT6KtvpBEldydXu1LPtiJpKbEbhGVSQUxGjCnE91+ueMMXrNfeB
         K4viLMHChcje+OhZbddY3T9gAdUuYJNrUlN7Rm2H+ANcpSELbw55hA2XYkm1gxYIpE
         lawyiPJHeryqQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 20 Jan 2023 12:04:08 +0000
Subject: [PATCH 1/2] kselftest/arm64: Verify that SSVE signal context has
 SVE_SIG_FLAG_SM set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230117-arm64-test-ssve-za-v1-1-203c00150154@kernel.org>
References: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
In-Reply-To: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G1YecYTzPBTdDuE6klviThW76hBwjUFMCoL2VKolvfc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjyoNVo+QLAPPwGLEzBdEbbyGyDsfwYBzXmnZmVluV
 m3Ltq0aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8qDVQAKCRAk1otyXVSH0EFfB/
 wJu0C3TsF2Zll0K29OrWZelIKBteIhzaeqnwNwye9JoDG800vJ5T4ZShRYAlonXTUGYv+L5JMV/fqW
 dPhsTnRiIEtYcnE0Z5IReKac2kbkEQXppPz3NngSXTqr/EYzUM+/S0bOISfU3Y4eSkmRC2EmF65PIp
 f/DRn0/5eEk+yUPR2r2pWDAbIQ/x1YeacGBMAa4+qxfkEWVLq4fctt/O3A2wZ3RF8KNbR4xmh6seb+
 03LO7KFaixUMGc4V/FvaR48Q5DQ5VHZEmg4dGKPzHBX6B1/g0zjYdC+e+f5yarAal4xXfVQ7qGOQlE
 leGyg1RXCVLuPFCnHlmKRsDaf3sJhd
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Streaming mode SVE signal context should have SVE_SIG_FLAG_SM set but we
were not actually validating this. Add a check.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index d0a178945b1a..cd738265cdcd 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -92,6 +92,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 		return 1;
 	}
 
+	if (!(ssve->flags & SVE_SIG_FLAG_SM)) {
+		fprintf(stderr, "SVE_SIG_FLAG_SM not set in SVE record\n");
+		return 1;
+	}
+
 	/* The actual size validation is done in get_current_context() */
 	fprintf(stderr, "Got expected size %u and VL %d\n",
 		head->size, ssve->vl);

-- 
2.34.1

