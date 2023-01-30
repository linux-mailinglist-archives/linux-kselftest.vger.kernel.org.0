Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA7681FE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 00:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjA3XrV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 18:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjA3XrU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 18:47:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0CD2BF01
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 15:47:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0BC3CE1AD0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 23:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53308C433D2;
        Mon, 30 Jan 2023 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675122423;
        bh=NFcCQqMaQK7JCYrOjfKaS2ObsN2ap71CGfdIOBpl9AQ=;
        h=From:Date:Subject:To:Cc:From;
        b=rLkhY6uCOoPwPLYtXR8po3hLWO7GL75MtOXbfz2Sm6eQNKgi6bkfI9WnmjJJV4Zwl
         VdcDu1i7S5zBDKXU31JbhdkyTolEU3khtxGjLdxEIpsBJakZrJAtfWx7mbhdi5nzGQ
         tDtAbo14WGmyrrDA/Ht5j/4+GREaA1SrqYJuG91QxEnqDspsEf2oSNe+Sreo2qoloK
         w+ZN2eNGsa7l4RPFzwh7uL8BnxlDlk7EmTAr6gf6S7Q9P9tnLvIRe3EhvRd93nsZvV
         vs/QgHfbkQhuCIIOjMNaUJtkX7vN3Rk/nuWKyTBQVyGOrlKKpndunk9MEB34PfHpNZ
         J0LPdMCJsHh6Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 30 Jan 2023 23:45:57 +0000
Subject: [PATCH] kselftest/arm64: Remove redundant _start labels from
 zt-test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-arm64-fix-sme2-clang-v1-1-3ce81d99ea8f@kernel.org>
X-B4-Tracking: v=1; b=H4sIALRW2GMC/x2NywrCQAxFf6VkbWA6KVb8FXExj2iDdioJqFD67
 6Yuz+Ee7grGKmxw7lZQfovJ0hz6QwdlSu3OKNUZYogUegqYdD4OeJMv2swRy9NHSJmYR6rjqQ7
 gaU7GmDW1Mu3xZ9HHrl/KHv7fLtdt+wGW3fLJfQAAAA==
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NFcCQqMaQK7JCYrOjfKaS2ObsN2ap71CGfdIOBpl9AQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2Fb0wDa9KgtPRmh+mY5nB2KAk8sy9+pDILqY8k0a
 a9wJI2CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9hW9AAKCRAk1otyXVSH0Iv3CA
 CGvQI0CfphWZzEiFs6kGrwl73f5ZazlQlFVkutB1pMMkc0JQLoOPrGdZBR/L9MUE1mE35MMBOWxWPH
 nKWo+FCCOVBVFrqFCFQgahZU5w0Wa98YyqWY9k3Bn41KibXc0yPHrQZDVWXiEEHvBSN/BNTbl6h09h
 ycRREOIEz+hDjGYxObFc99wdWYYK3uQtTxLQ5eI9sMV6jeqsuOTnd2f2LaGxqEKw0bel2VvBwWi9Bc
 BYTy6mD46vCpY6GvATneqdpALLPwQ6UPTZyjlDyp0wAX2+lyAXRcB4yNg/zpVekDIrssXQs3Nzk9Gz
 vjO7/Jw6hqGkou+9sZd1t73j1k9nY/
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

The newly added zt-test program copied the pattern from the other FP
stress test programs of having a redundant _start label which is
rejected by clang, as we did in a parallel series for the other tests
remove the label so we can build with clang.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/zt-test.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/zt-test.S b/tools/testing/selftests/arm64/fp/zt-test.S
index 7ec90976cf5e..d63286397638 100644
--- a/tools/testing/selftests/arm64/fp/zt-test.S
+++ b/tools/testing/selftests/arm64/fp/zt-test.S
@@ -200,7 +200,6 @@ endfunction
 // Main program entry point
 .globl _start
 function _start
-_start:
 	mov	x23, #0		// signal count
 
 	mov	w0, #SIGINT

---
base-commit: 3eb1b41fba97a1586e3ecca8c10547071f541567
change-id: 20230130-arm64-fix-sme2-clang-3b3ee73d78d4

Best regards,
-- 
Mark Brown <broonie@kernel.org>

