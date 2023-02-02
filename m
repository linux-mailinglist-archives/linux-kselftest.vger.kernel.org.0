Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A074688569
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjBBRbe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 12:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjBBRbd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 12:31:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D8F74A5E
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 09:31:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D5961BF2
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Feb 2023 17:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECEBC433D2;
        Thu,  2 Feb 2023 17:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675359091;
        bh=AiRNPh1CyMvosPA/G+mLeIImdY47HAZEGjAg9u+gqjo=;
        h=From:Date:Subject:To:Cc:From;
        b=M56DPBI5e87U9NIG9Q744wyu7+3mshOFZK/it/0rVSLGWd3OwsOLSxlpSRVukgapX
         VY/2M6JlTlQivk9o9cXxBdNTRIhw9n4au5B1FAQaMwaVpd95MopwxLuXpXDjPaPJ+U
         R8XxEpYrBzD0NoKgsQtIJocKtdbNgyw3E5mt3a8F2t9MxHbqNsHkDXywYAeRb358VL
         zFFE2QCP2fl/7GQrVNkxo48fZiULml7jCu0T0UsITWPq8eZl6HmSrIXBA4zLwQLAbg
         JWbLb0fiCANF1hgpWUFI0yFG4xFaP8WK7DfmIOkdzTQknTtLV9H/aVwIadRjvlVYZK
         /jqajU4bclgdA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 02 Feb 2023 17:31:25 +0000
Subject: [PATCH] kselftest/arm64: Don't require FA64 for streaming SVE+ZA
 tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-arm64-kselftest-sve-za-fa64-v1-1-5c5f3dabe441@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGzz22MC/x2NQQrCQAxFr1KyNhDHUahXERfpmLFDdSpJqWLp3
 U3dfHhv8f4CJlrE4NwsoDIXK2N12O8aSD3Xu2C5OUOgcCAfZH2eIg4mjzyJTWiz4Jcxs9uWKWZ
 KsaVjAC90bIKdck391niPOmz6pZLL5396ua7rD6AVegGEAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AiRNPh1CyMvosPA/G+mLeIImdY47HAZEGjAg9u+gqjo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2/Nx+bgT0QRq1i1UVZsoP4vlvygzx4/ofOIFprLE
 Nd8+Y+CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9vzcQAKCRAk1otyXVSH0FvQCA
 CAO/mZwxTyn9yW8Zdm68Qh0NqRX5V0xeb2L90VP8lv6q8wtDjGqU8gZEGDoJckOc6hTLTBgyS+9tqE
 MUHQUd4fFgyBLhUVMDdyYHho4zXVvsVmuRn0Pv4kSIDhUCF1F+F9I0gynOC87AK1f9vl9DrPhqbscc
 P9qEjgcsoquvQRvcp93Vqf5zSMr1UQzCzJQ5P8OazbJUaX7LPRsnN/fCmrl/rzYX7RKgKp0pKCoaHZ
 mnnGCtxqy6/m6ZcI91hUzAcL6j7BKhg74v0vSCqYZLAnXXSMUdMppQ16hoj2zD5J+vakxG0VrPnOLn
 9uow0ILbVyvWVUv4BcKRGHII4rPpIB
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

During early development a dependedncy was added on having FA64
available so we could use the full FPSIMD register set in the signal
handler which got copied over into the SSVE+ZA registers test case.
Subsequently the ABI was finialised so the handler is run with streaming
mode disabled meaning this is redundant but the dependency was never
removed, do so now.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
index 1f62621794d5..9dc5f128bbc0 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -154,12 +154,7 @@ static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 struct tdescr tde = {
 	.name = "Streaming SVE registers",
 	.descr = "Check that we get the right Streaming SVE registers reported",
-	/*
-	 * We shouldn't require FA64 but things like memset() used in the
-	 * helpers might use unsupported instructions so for now disable
-	 * the test unless we've got the full instruction set.
-	 */
-	.feats_required = FEAT_SME | FEAT_SME_FA64,
+	.feats_required = FEAT_SME,
 	.timeout = 3,
 	.init = sme_get_vls,
 	.run = sme_regs,

---
base-commit: 7294f24db4fa5ebb5a6bde104f08d3345ecee053
change-id: 20230202-arm64-kselftest-sve-za-fa64-9a04f0c49052

Best regards,
-- 
Mark Brown <broonie@kernel.org>

