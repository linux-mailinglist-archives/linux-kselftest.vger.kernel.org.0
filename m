Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DA58740A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 00:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbiHAWlu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Aug 2022 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiHAWls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Aug 2022 18:41:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2345074
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 15:41:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3439B81890
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Aug 2022 22:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A8DC43140;
        Mon,  1 Aug 2022 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659393700;
        bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=;
        h=From:To:Cc:Subject:Date:From;
        b=jVS1uPZtjmLpJ8adX2vvOwkUimZrRru0TUgkUL+5hl+hDFiRUzG2leAxoyYBQ45hk
         gaHq7ZExgsT6zmiwGuUOuxar1EgFR1/vNAwuaU2Mq6ZDGchBUp5iALKVDeVUNRy68s
         WrzHljKFUfi8qoAALwGDD3elQ9Dsx3BQOgMQWFdnQUODnJlr3b9NVAwyQ9/TzXg7kG
         q87GvC2CLKp5O5dv3luwYKvGaUrcLFf2tEhEuLFpQ0qi50g90LAs/JgihG6jToEQ6O
         m1vpmVMZC7BRBMW1/v5g5+UmYqYWezn7LippttyJ6JjbHIdbB9yMJDxW9t77K7ygxM
         sQJRJHwc5AAIQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Validate signal ucontext in place
Date:   Mon,  1 Aug 2022 23:41:35 +0100
Message-Id: <20220801224135.3691346-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=broonie@kernel.org; h=from:subject; bh=Dxt22W8Em96QEF9sjlP0/VfqCLzptWgJwiuX8Wed7dw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi6Fafrr6pXSdNsaCjPzZcsv9NuPUamlQgH8zMcvpo Nhmt7KiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYuhWnwAKCRAk1otyXVSH0G7vB/ 9OaZRbYt06IKDfukLSZhciBme2xMg+FTFRDUAHLz12R9Bi/4+BP8+OttfAKmVLG+f75zz3vPUgMQb/ FKN4qxO7pustwl1LfELQ12kWvbU5ozl/9YFMGbdoWfSGmdA24uf0SrblWWdard7m4vKDT6CQ/jwjrp skGoqhyr47ked2gj/+UlF+QaeQXJL9a/mXY4YmLT/yi6LYcDSnZ0MeD0iY4jbOwWBr5etoxS24kjut /CbCsEGCejZ7agmMMpGQ1+/6FAxeo5O4ORqGBq3OLgHBZsCF1R9tBQbr9xHgjuFaRxLcs4OdfkOiCN S+d2cv/mCfr+zKvFXR63rUmiAMGzD0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In handle_input_signal_copyctx() we use ASSERT_GOOD_CONTEXT() to validate
that the context we are saving meets expectations however we do this on
the saved copy rather than on the actual signal context passed in. This
breaks validation of EXTRA_CONTEXT since we attempt to validate the ABI
requirement that the additional space supplied is immediately after the
termination record in the standard context which will not be the case
after it has been copied to another location.

Fix this by doing the validation before we copy. Note that nothing actually
looks inside the EXTRA_CONTEXT at present.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/test_signals_utils.c  | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index b588d10afd5b..a54dc1b6f35c 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -165,12 +165,15 @@ static bool handle_signal_ok(struct tdescr *td,
 }
 
 static bool handle_signal_copyctx(struct tdescr *td,
-				  siginfo_t *si, void *uc)
+				  siginfo_t *si, void *uc_in)
 {
+	ucontext_t *uc = uc_in;
+
+	ASSERT_GOOD_CONTEXT(uc);
+
 	/* Mangling PC to avoid loops on original BRK instr */
-	((ucontext_t *)uc)->uc_mcontext.pc += 4;
+	uc->uc_mcontext.pc += 4;
 	memcpy(td->live_uc, uc, td->live_sz);
-	ASSERT_GOOD_CONTEXT(td->live_uc);
 	td->live_uc_valid = 1;
 	fprintf(stderr,
 		"GOOD CONTEXT grabbed from sig_copyctx handler\n");
-- 
2.30.2

