Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE04D58A079
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiHDS0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 14:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDS0d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 14:26:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363911D0C4
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 11:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4C4EB826D6
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 18:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18207C433B5;
        Thu,  4 Aug 2022 18:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659637589;
        bh=GuAAHfONdccZWxEJoDj9m4WkAJryBaOvkNE/1x3pIBk=;
        h=From:To:Cc:Subject:Date:From;
        b=eQ9egZBpnUEY7IRXoQRskSESD+UrFpbjXsG4X0xLJWQQOX7AUaUkGPMDdPPugu5oD
         piEI49ktv5Q8dmhogrYLfO1oEMdJ9ZsLQ3WEv6fRMyV5y0VSQmQjt14eLTpBbB0QId
         W5Y1VWKAXMiGS8UiqZ2tCh750N364aflxdAjQnFeTJrd26B7bVLN0DHkU0G8yoDapx
         hw8CQa34B+W7qy2ZadkRhBHnCajie4OyGju24xnlVweW3lrstp7grS+q6vbvj8R8b7
         YCuh8Uu0rZ04F2p4nHgmtQ22d0URdEhGoZSnVhY1es4rGbh8kzgh3q5sLtfFoxeL6q
         opjnW34+TRo2A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Enumerate SME rather than SVE vector lengths for za_regs
Date:   Thu,  4 Aug 2022 19:26:06 +0100
Message-Id: <20220804182606.255728-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=broonie@kernel.org; h=from:subject; bh=GuAAHfONdccZWxEJoDj9m4WkAJryBaOvkNE/1x3pIBk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi7A89eZk9tgyDdEyS+SL9X66hnKKHYRsUvilvwWvM WsLtu9uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYuwPPQAKCRAk1otyXVSH0EJMCA CAuX06PVTPz9uYjLzU52Dd03AgIgA1n85jsEjj8UzKio7GZBHjsZ41qavYfkCljP1C/1TgaLiBVIiG HDQQUYejJI69spqtv5RLR0GSBsngB8nrHz48mtQnvoL2FY5lkPzvYkUbBcq3SW3Xt2aQxqViuhva7z Kg8zevMZupGg5LWNWIJ1aBOOeV8tQOfRTHpuDNX8dKe+SAV/WKrkWyWq2H6oEBeQq4exeSmMt0tmAy GgTzurABaXDAnhw8g4HhHz1BmeZFDPZ+ch4UujzbrsCIUa5+goM3g+8lPkYcpIZ/vYeSG+IHWDb3EB TyRgYxFreMLytzxB7enF6Fa64rty9w
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

The za_regs signal test was enumerating the SVE vector lengths rather than
the SVE vector lengths through cut'n'paste error when determining what to
test. Enumerate the SME vector lengths instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/za_regs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index b94e4f99fcac..9f1dd70289be 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -22,10 +22,10 @@ static bool sme_get_vls(struct tdescr *td)
 	int vq, vl;
 
 	/*
-	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 * Enumerate up to SME_VQ_MAX vector lengths
 	 */
 	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
-		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		vl = prctl(PR_SME_SET_VL, vq * 16);
 		if (vl == -1)
 			return false;
 
-- 
2.30.2

