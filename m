Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B355A0436
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 00:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiHXWlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiHXWlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 18:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490B58B41
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 15:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3066D6198C
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 22:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E02C4347C;
        Wed, 24 Aug 2022 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661380875;
        bh=mvOc/8cUdGxzIqrwz0EePKC3ZU/yxeDw11W9Ibm+0ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQSjnF9rITLb2IuE3Cj6MlxbSAnxBzXfgyGRGers+9oWD/Ichp7u7xzkf6+q9AUbp
         RBxzXBy/7p+aAH1fsSr8n8O6jrCTR52qkb6SJZ8gy/5iEu1YKcZiepYjHf2nmns8UJ
         aAtKxd7C1Up1dmjHwqFuhiKMTHlBPZx4md5Twn1bd+U4lE8KLfQOynndCtTn3k99oU
         JKxsZOp8WDqXmut+J4lbbxXiAhNImbY4nyYYk6/RQrlM+DPiK7O4XqH4khtnACHSe3
         H3gIMVXxBbyJQmbTy3X/rxL3jYf6Avo+gy2qXNhEjHB1znKAS1TWyRL70XoxEuX3eq
         2jO72pxFdcKxA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] kselftest/arm64: Tighten up validation of ZA signal context
Date:   Wed, 24 Aug 2022 23:40:25 +0100
Message-Id: <20220824224026.848932-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220824224026.848932-1-broonie@kernel.org>
References: <20220824224026.848932-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=broonie@kernel.org; h=from:subject; bh=mvOc/8cUdGxzIqrwz0EePKC3ZU/yxeDw11W9Ibm+0ns=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjBqjYq554edjZ4LhfZqZf9K7H9cXh++0PwGRZBP38 y9uOMC+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwao2AAKCRAk1otyXVSH0FGBB/ 4upwzalcnX23mIAnLF7QF+HpoTLt8GncMPb2f8p4v56plI7sb5x9sIXugNrW+Ces5AX6SQTmIBX12L 6zyKKg9+ukqkReTNbZC11gwBumfAM4dgbeN3iUVEh51QBqDPfKt1NdWcvcdHTqGsF8+ZOaGFm3Gmzu evA/hqR6YhJTcnJ7tkYw7n7kDIaqkAv+61t03F+5foXw3nNNR/BroKj5YbyFaQxM3Wwm+6KF82q3eI eQ0wqdYGDqzCJbdo1xHmmnygwfFCsG67a5O99WF01EjnF4gWLtdeWElVJxT/BJ64/4HZW8kZPrVtBU VqK3TJi+n+HDs2yo7uw/S0WnD0dTtY
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

Currently we accept any size for the ZA signal context that the shared
code will accept which means we don't verify that any data is present.
Since we have enabled ZA we know that there must be data so strengthen
the check to only accept a signal frame with data, and while we're at it
since we enabled ZA but did not set any data we know that ZA must contain
zeros, confirm that.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/signal/testcases/za_regs.c   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b94e4f99fcac..2514cb7de525 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -52,6 +52,8 @@ static void setup_za_regs(void)
 	asm volatile(".inst 0xd503457f" : : : );
 }
 
+static char zeros[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
+
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 			 unsigned int vl)
 {
@@ -87,10 +89,22 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 		return 1;
 	}
 
-	/* The actual size validation is done in get_current_context() */
+	if (head->size != ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(vl))) {
+		fprintf(stderr, "ZA context size %u, expected %lu\n",
+			head->size, ZA_SIG_CONTEXT_SIZE(sve_vq_from_vl(vl)));
+		return 1;
+	}
+
 	fprintf(stderr, "Got expected size %u and VL %d\n",
 		head->size, za->vl);
 
+	/* We didn't load any data into ZA so it should be all zeros */
+	if (memcmp(zeros, (char *)za + ZA_SIG_REGS_OFFSET,
+		   ZA_SIG_REGS_SIZE(sve_vq_from_vl(za->vl))) != 0) {
+		fprintf(stderr, "ZA data invalid\n");
+		return 1;
+	}
+
 	return 0;
 }
 
-- 
2.30.2

