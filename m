Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F465666645
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jan 2023 23:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjAKWdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Jan 2023 17:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjAKWdV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Jan 2023 17:33:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888BD11C;
        Wed, 11 Jan 2023 14:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1972E61EF3;
        Wed, 11 Jan 2023 22:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7F8C433F0;
        Wed, 11 Jan 2023 22:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673476398;
        bh=cMYIhMA2zxGO43WUfgqHShXv2Okf3Of2day+Uq7+BXQ=;
        h=From:Date:Subject:To:Cc:From;
        b=oPJgwhz0gnFrLkaL+ouai4816Uv2s37ejSL9ayymTpNong9fKYKV1w4BgHGIbr7gC
         w/h5mX7w8OtjHPehqxv01mOyv0Thw44POSwidpBVgg3UQw1hSqQHWZcpHj+mbG0Bz2
         btXj3eBC6O6dUV5ItceUxIVT9jymKobLzWSOPJlJ9xt87HqS42qOohfJocoPfbOV4M
         n9+sr+eyYZUUgSO81AIvqS0G5D1xnioRsno/z7aUvtBX8ZIS5dAcE3hxowaSKRZAuD
         dMo86L1lpg+kHtUaaEInVX9If+sgCiPmCmJedT+FyG7WjrXX6tUqBgPBaV+Pngl5WW
         yrTuXvaTyNGZw==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 11 Jan 2023 22:33:07 +0000
Subject: [PATCH] kselftest: Fix error message for unconfigured LLVM builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-kselftest-lib-clang-fix-v1-1-58ebadd0e090@kernel.org>
X-B4-Tracking: v=1; b=H4sIACQ5v2MC/x2NywqDQAxFf0WybsBxwD5+pXSRmcYaHMaSiC2I/
 97Y5bmcw93AWIUNbs0GyquYzNUhnBrII9UXozydoWu72IYQcDIuw8K2YJGEubiDg3zxco19onju
 mQJ4ncgYk1LN49F/Zp2O+a3s9v/w/tj3Hw5gP7SAAAAA
To:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cMYIhMA2zxGO43WUfgqHShXv2Okf3Of2day+Uq7+BXQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvzkrotrBVIkaVDxOa6bB0s5cjfgAogfLz04suxwz
 4m+iipCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY785KwAKCRAk1otyXVSH0N/rB/
 9aDmiSZjVeSL2hj2TiROL1YAtz8J2C7iaKljVL4Eloy5lw0Ih1Mza5FG2OdxduCfgK8A992Lm4gE1o
 QWkD5wPR7+pxYROF5WAGYlfJ8HOZSZ82SHDwaUhs1GLq6qXXnkA37PPkfFOFDQuXwMCNuwiMKP3jW4
 8Barfkc1cLrWJX7xDNSi6rWjnedVCZFFycJWn8S4GDyKvcpMnaMbJgulPtm1KWKirHi9QjIg3ytsls
 rZpEhcnY7d+3dc8Qf5TG1Y9PMLw4ynxZneNVbVrlDLz2rE01KDQVHzp5/6FiQy/WDTFs5u8HXurpG7
 HsPpJbNfLDl89B1lI9dqbOEMa6CKRx
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

We are missing a ) when we attempt to complain about not having enough
configuration for clang, resulting in the rather inscrutable error:

../lib.mk:23: *** unterminated call to function 'error': missing ')'.  Stop.

Add the required ) so we print the message we were trying to print.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/lib.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 291144c284fb..f7900e75d230 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -20,7 +20,7 @@ CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
 
 ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
-$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk)
 else
 CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
 endif # CLANG_TARGET_FLAGS

---
base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
change-id: 20230111-kselftest-lib-clang-fix-8936ba376ea1

Best regards,
-- 
Mark Brown <broonie@kernel.org>
