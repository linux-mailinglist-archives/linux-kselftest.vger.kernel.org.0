Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CC6532D2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiEXPTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 11:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiEXPTF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 11:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB8192B1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 08:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E76B56170E
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 15:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3697C34115;
        Tue, 24 May 2022 15:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653405543;
        bh=6JPuc86/1Y6FFGxX9DQaB+nGrEdbJT4GxrPqfqaFn4s=;
        h=From:To:Cc:Subject:Date:From;
        b=d5zojrgWJ+KggUvBNKa1KoEHU5AXThvksMptsMA9pQb3T3AFRwoX8+dwyss+Z6Kz+
         ms7mG/gdTCVBB+ymGBjdTwBi/y+w+9AqPNYEbhfdPKWROf1+jMUVs3c7DyaljyzUMI
         ba+wIZuYc2YqBXlFZURsoZ2OzW/cKU01ViQmFBNRpVEqvuzw7OuCupHNa7dKKC8ZLc
         gaIzqm2tRUqhyV5xE7GJG1JbrT/EBVhM6cBLIpnNDQWebyY2G7lMz1tQA3tD7nSLhO
         U4jSOT+UcE2LXapXnlMZBjae4o53IwQcmF938vpG/azxBwpSDWJwjWZE/jZloM1+tk
         HqmwY0gEe/ChA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests/arm64: Fix mismerge of Makefile for fp tests
Date:   Tue, 24 May 2022 16:14:54 +0100
Message-Id: <20220524151454.1487390-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=934; h=from:subject; bh=6JPuc86/1Y6FFGxX9DQaB+nGrEdbJT4GxrPqfqaFn4s=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBijPWTCm52WdKpio63xjB5GB6dO6hOSCDl/qPl+lSP QeqWcFOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYoz1kwAKCRAk1otyXVSH0PXtB/ 0bBrcySW10pscKfSdRT9nDScSCo6BiprTOmQXFW6gQjPG6JyN3zaTI2LMuH15cAJ9ZbmJl/0tT6ilG rlh3rHMbgXqapkIr5p+XnypqMCRVwNthNWReWpCEKRsD8DrZA9AojGSdipN7Of5dH54Owwr3m2TukV EzFdaMcckyVJOCNJqnacQ/o1RPiDz8CQXlA676waQFcvZH7CD6dn/6RKFsBAIFcOLo0dhd7CQnJQDr fjhqP/qLtFwST4bUzTkkMett39VKKuNlkqLJCwIaioPP3f7i1Ie456E7oxhRPE/nGT0PWAZreX74Lz gJKfCCvT1AaMsB4gGEeWkPNhGrTO1I
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The FP Makefile defines two TEST_PROGS_EXTENDED instead of one of them and one
one TEST_GEN_PROGS_EXTENDED for the programs that need compilation. Fix
that.

Fixes: a59f7a7f76407da78 ("selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a41fef2c9669..36db61358ed5 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -9,7 +9,7 @@ TEST_GEN_PROGS := fp-stress \
 	sve-ptrace sve-probe-vls \
 	vec-syscfg \
 	za-fork za-ptrace
-TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test \
+TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sme rdvl-sve \
 	sve-test \
 	ssve-test \
-- 
2.30.2

