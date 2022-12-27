Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A19656BAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 15:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL0OVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 09:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiL0OVL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 09:21:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C805FEA
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 06:21:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC85360F92
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 14:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FACC43392;
        Tue, 27 Dec 2022 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150869;
        bh=cQNYdXE3voO/GYR3y9OONhbJjwblJQ6tPy2W2oS/6Pk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Hnn+Am+kI7MJKvLauKh1gGMFWsywvj1qQuLCsVtVm43ezfu7UgNEr+D8BiQccuhX2
         O0J9/dOiLgejCYVAPRHNFpya5FUJXwWs/aMAMGmAux7sCmbIUCuRvlSrRKLLjTobQk
         hFByfb0icgiqbXsPj8B1yIGAsNmE3BkZ4rlRXGHW+wGkJIT8wzgS8MMjFuFtoJWRo6
         hYDqvpRqQx/HaY2v7kQ76f8yzr9reSZKuXuFW2Wc4IDkf76hDg9Ba1/qAWIFfpo0vw
         kHqMR9v1mvpFJd3LCRO408bCBtGbe3i0/VNym1q38xqsgPHIQTnLH9CiFXhPdingzy
         sPQS1hhNbs3VQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 14:20:42 +0000
Subject: [PATCH v3 3/4] kselftest/arm64: Add TPIDR2 to the set of known signal
 context records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-tpidr2-sig-v3-3-c77c6c8775f4@kernel.org>
References: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
In-Reply-To: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cQNYdXE3voO/GYR3y9OONhbJjwblJQ6tPy2W2oS/6Pk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqv9Kx611QOMZwh6oA7aNCmvy8+z3wPhyGxmgnDj4
 F7+pMtaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6r/SgAKCRAk1otyXVSH0Oj3B/
 9Ih+YqKUoa+8bP+00XPN+fHZCN0rLi1veG0tmI9Di2RQtowXCAwArsufS0dzaOt/xtz54QHToiSgEx
 Cb5UVE24SOKIcnwCJBYY3Jtm99meDhLAkPaoQgL32JztglJnerD3zdq3dIaInhBEiSP+zzpgZAmm12
 Kp0Tca3mazGjug3wu7TPY1JhID6Sq18DvQ2RWp/g0yRGa1DV3A8dMno+BNZNPuetmQ5f7yAO0ShL3J
 cJ1GjluywgpD4Df/ckqWkw7yBnzJumZstibOenPQY+eaK8ap2OGtIF5Q1mk9lZAMKPCqwOumJuRUBT
 NeYLeeS3SlsY6cHaILQO2ofEHu3eFS
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

When validating the set of signal context records check that any TPIDR2
record has the correct size, also suppressing warnings due to seeing an
unknown record type.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index d2eda7b5de26..23487c458240 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -163,6 +163,10 @@ bool validate_reserved(ucontext_t *uc, size_t resv_sz, char **err)
 			if (head->size != sizeof(struct esr_context))
 				*err = "Bad size for esr_context";
 			break;
+		case TPIDR2_MAGIC:
+			if (head->size != sizeof(struct tpidr2_context))
+				*err = "Bad size for tpidr2_context";
+			break;
 		case SVE_MAGIC:
 			if (flags & SVE_CTX)
 				*err = "Multiple SVE_MAGIC";

-- 
2.30.2
