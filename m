Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0395462D9AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiKQLly (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 06:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiKQLlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 06:41:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2424E58BFE
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 03:41:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C91AFB81FFE
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Nov 2022 11:41:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C41C433D6;
        Thu, 17 Nov 2022 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685302;
        bh=CumGgYdfm6kFPjk0CvYkXsehkmA9pVF0C9/Mp2ysaRk=;
        h=From:To:Cc:Subject:Date:From;
        b=aPBeF/4/yvWbVoSBFgEdiptYBjOVKeof3SfZRU0YZ9C74vwdCmrLLaqYUMZ9wKXbA
         WzI8aCB1uh4rj0JCXs2xUU5GtG6Z8QWBCJJWfHX7C6mwlYupjk97LXJfJgrI9K+B5a
         NAeRYPLF2l4QWdzbX9hd/LuKL8/cNns9rx0awHUxwxWU1MvZwmjDRnMTb+gJrXN9kd
         8kwarQT5vsEw0XmSvCu1Am6BOAzGJrKdB8mro2iSm5m4KJii01WK3PBScwhiG0OEfC
         qZjep8cfqms9Wmf+ZHVxAMEVyew4z49gEHp+KW3rLvSTf0+8ZwgxcZY9/bsJWpwa4F
         5SBUyiUycLtvA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] kselftest/arm64: Use preferred form for predicate load/stores
Date:   Thu, 17 Nov 2022 11:41:30 +0000
Message-Id: <20221117114130.687261-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org; h=from:subject; bh=CumGgYdfm6kFPjk0CvYkXsehkmA9pVF0C9/Mp2ysaRk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjdh3pgiaeFbMSNNCguTWUAMMm18O1tepoINUzmRcY G5pA4emJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY3Yd6QAKCRAk1otyXVSH0As1CA CBg/IegvtqSIEerlDzMd+2aYwHEonuqHxk0mzdXj4wvCjG5z1gw0Khar9fxJbZJKRIbpgzzcCM4BHF 5eI4XOJTP+rOfyFetWeuJDqmHZXAz8iStKPgoslDdD7p6N8o1g6NK1USHAAbZKJmnrlE9K2sC58XUD LTNy++feWEGbkHdFSw5jLVpgVGTL2Eucwk1yQxgGbTb32raQVYeXRbDz6+eIPGfLmNWn8kQm50R9pT eaSjnNnOwdYWiiQk7L28w71spDTLncOGGzAMSp9glzE7eMEpEiVMun3p2grARlFEvAxYEE96lLM+xo tAr+eC/JTbP5e/LC3wT/wi5f9WV4sw
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The preferred form of the str/ldr for predicate registers with an immediate
of zero is to omit the zero, and the clang built in assembler rejects the
zero immediate. Drop the immediate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi-asm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
index b523c21c2278..acd5e9f3bc0b 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
+++ b/tools/testing/selftests/arm64/abi/syscall-abi-asm.S
@@ -153,7 +153,7 @@ do_syscall:
 	// Only set a non-zero FFR, test patterns must be zero since the
 	// syscall should clear it - this lets us handle FA64.
 	ldr	x2, =ffr_in
-	ldr	p0, [x2, #0]
+	ldr	p0, [x2]
 	ldr	x2, [x2, #0]
 	cbz	x2, 2f
 	wrffr	p0.b
@@ -298,7 +298,7 @@ do_syscall:
 	cbz	x2, 1f
 	ldr	x2, =ffr_out
 	rdffr	p0.b
-	str	p0, [x2, #0]
+	str	p0, [x2]
 1:
 
 	// Restore callee saved registers x19-x30

base-commit: 30a0b95b1335e12efef89dd78518ed3e4a71a763
-- 
2.30.2

