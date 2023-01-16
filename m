Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA4566C5B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjAPQJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjAPQIW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:08:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382822A0E;
        Mon, 16 Jan 2023 08:05:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3664FB81065;
        Mon, 16 Jan 2023 16:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FDFC433EF;
        Mon, 16 Jan 2023 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885156;
        bh=A2lMnNpwS6S66/IQOfPFdDu2/4XhxRCJbXbHkSaZYLQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ia3VNl7Q0DH7gaJ4mpSKEw+FvMPuvtkQ4nWizcmTV1ICD0u1dOEGzaq0U4WGcFCqV
         lCYH4m0kYzYwUqwTey2JJX9cZ1C/OiNri07/ve4nIa1ZyHX9vXAFlTfQo224sX6McQ
         ZnA4lqjc4uDfDQgUUF51KOVOQAQOqOgZAX20q8GuAP9hGHIFPJ30l8ysP9RspMPo9z
         3qDYou7iD/qJ9yqJq4QUKfns5qiTGmd2FQbZPw1fjoPBxuqSoNAAvQbMkd5D7+9p8W
         R0LHOcs1Jib2VoDdH9SH+V1q15gBV09nSub/FoeU/7GMAdaMKCM1Yy57ebE9AiIq57
         IVfhNSEsykZ8Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:42 +0000
Subject: [PATCH v4 07/21] arm64/sme: Enable host kernel to access ZT0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-7-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=broonie@kernel.org;
 h=from:subject:message-id; bh=A2lMnNpwS6S66/IQOfPFdDu2/4XhxRCJbXbHkSaZYLQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWnTp5ZGErr4lpzXbWz2naqNeSyfqHWUbeT68Dg
 1kDpfYiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1pwAKCRAk1otyXVSH0FmsB/
 9usXcD+QpmmUQlVUPN6H/k4eWHLR4r3VwhBTI8+6H4bvluQqNUziGccjwm1TiSGdgS+S1OT7H6pNck
 WgJZ14DIivBBaWX9AN9uSycMS08b1xTQqAwyiD0Smosu4eztdGdmHuFDiLUkvrerA9+6xGgs+YZrcg
 EO4onn9BPWowPQVnI29JHJtVbVcvJyx/p7L+xrPJnGIVdgS2r+ISh2aZGl+oskJ4R+MKTPUAvCwBWG
 5zVsubXATcOz4m5XTWwoAeZ+MqkwacbKJyLE5OxIgkL1mAe0N2+32qVp7dg9HTPc4OEnb6O0Dz+CgW
 kVyHsqJweSqqtZYU2lTXxxl5ZyDiNQ
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

The new register ZT0 introduced by SME2 comes with a new trap, disable it
for the host kernel so that we can implement support for it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/hyp-stub.S       | 6 ++++++
 arch/arm64/kernel/idreg-override.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 2ee18c860f2a..d31d1acb170d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -132,6 +132,12 @@ SYM_CODE_START_LOCAL(__finalise_el2)
 	orr	x0, x0, SMCR_ELx_FA64_MASK
 .Lskip_sme_fa64:
 
+	// ZT0 available?
+	__check_override id_aa64smfr0 ID_AA64SMFR0_EL1_SMEver_SHIFT 4 .Linit_sme_zt0 .Lskip_sme_zt0
+.Linit_sme_zt0:
+	orr	x0, x0, SMCR_ELx_EZT0_MASK
+.Lskip_sme_zt0:
+
 	orr	x0, x0, #SMCR_ELx_LEN_MASK	// Enable full SME vector
 	msr_s	SYS_SMCR_EL2, x0		// length for EL1.
 
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 95133765ed29..d833d78a7f31 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -131,6 +131,7 @@ static const struct ftr_set_desc smfr0 __initconst = {
 	.name		= "id_aa64smfr0",
 	.override	= &id_aa64smfr0_override,
 	.fields		= {
+		FIELD("smever", ID_AA64SMFR0_EL1_SMEver_SHIFT, NULL),
 		/* FA64 is a one bit field... :-/ */
 		{ "fa64", ID_AA64SMFR0_EL1_FA64_SHIFT, 1, },
 		{}

-- 
2.34.1

