Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE868352D
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 19:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjAaS2x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjAaS2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 13:28:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A354AA61;
        Tue, 31 Jan 2023 10:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5AA6160B;
        Tue, 31 Jan 2023 18:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C06C433EF;
        Tue, 31 Jan 2023 18:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675189730;
        bh=AGlzssf36xL8VsGXJcqmepsel7PDFzSpp+uASAyVOVs=;
        h=From:Date:Subject:To:Cc:From;
        b=Yhy5OtyOi6AGdzbNiA2GBS9sXCLBOx2mCi5maNJq2OHe/cM0WpQynhqol1jvU1Tmc
         nPRpBXDCz/ZKV4/ThO9xsf5iFTtruEHhjdfIxc+0WGECA2psWZTBXltgyFPlqVwXIu
         Sb+Q4zHCZXk6BoRD+EQWZ3iNGcxCVYnfHJL4B8Wx1mJieuOOvAUVyb6vcrxaIVFJmE
         AztXNvtJzwfN2Jt5+MckIdlPuNkYVjUKjdSvh7ZERunoFcqeQ0zNyAY/nn38rCdVJm
         0f8tQrxq6r5l9bx7YhlmNsDN7lxS/ukO+JV/8gRaVF5G7LibNkregpXhlmZal+ezUf
         ejFGF6KSRBNIA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 18:28:05 +0000
Subject: [PATCH] kselftest/arm64: Don't require FA64 for streaming SVE
 tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-arm64-kselfetest-ssve-fa64-v1-1-f418efcc2b60@kernel.org>
X-B4-Tracking: v=1; b=H4sIALRd2WMC/x2NwQ6CMBAFf4Xs2U1aSjz4K8bDUl6lQYvZJWBC+
 HeLx5nDzE4GzTC6NTsp1mx5LhX8paE4SnmC81CZWtcG54Nn0fe148nwSlhgC5ut4CRVRsTWBT9
 IFxLVQC8G7lVKHM/ENut06o8i5e//eX8cxw8ycQ1bgwAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AGlzssf36xL8VsGXJcqmepsel7PDFzSpp+uASAyVOVs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2V3glQese4OPH5StSUZB8xEXxeXWdfrXKjvjxuI9
 THezIDmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9ld4AAKCRAk1otyXVSH0LfNB/
 0doo1N1doclNJ4OnQOs/J7cq1jWPNEQ6Jf/GYLlRq4px094SkWJ8IK+uKMFBiGVAVDNY4g2NSpWa9K
 v9+axCv1shR+DiQZbT94GMS1nAka9LB2K44bk9HGEQr5t0uFsaE5QPYxYs4/klKdPD+9FbwOfEHX93
 g53ZrNJW9xopn+Kx43Z2NeJWdQGRrPS9PGjiN2TgEf83w4fm4iETDwROR/yKbGVc26Vh5G8Hd7BPRQ
 mKmI7NOPR/w8PrOnIbWOujo77LNVBzvGyxz2TvCoGUPL49aRJ+VXEwkehpCFKjFGoA1sOSE67h1u+M
 2DAxSitFfEjThqxPnDhEfnasQPHEFH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

During early development a dependedncy was added on having FA64
available so we could use the full FPSIMD register set in the signal
handler.  Subsequently the ABI was finialised so the handler is run with
streaming mode disabled meaning this is redundant but the dependency was
never removed, do so now.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/ssve_regs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index d0a178945b1a..f0985da7936e 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -116,12 +116,7 @@ static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
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
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230131-arm64-kselfetest-ssve-fa64-cec2031da43f

Best regards,
-- 
Mark Brown <broonie@kernel.org>

