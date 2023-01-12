Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3247667FAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjALTyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbjALTxw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF63B91
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69FEB62169
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C0C433D2;
        Thu, 12 Jan 2023 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553144;
        bh=QTRTDX1aspFUjlsVcI/SSLmUL0J8HraBN87iqVH8u4A=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sIBKwM6q2YIoegjX0mohwbxLZDvtg1x7VE5rn/66w7ZeSqLQCpyi7Haj6GcbHL6EX
         d3wEqU1n01YsoXaCDqglbLpFO6O/2DfYm9v9AyoGeO5Gv29cmVsj/JN4laS4tA2G6Y
         fdJ8Q3oYijHq1pWEK/zVM7DmOUix8oitEt3if7gIRvddCCxeXXKwO/+MBGXKGm0xvS
         WEqQG+X2ubN42vYPdFbtyKrPCOKxrGgnG8VqnNrdHTFwjlVw6Boj7ZsfyLEfHdVpyd
         LzTI05jKJ7gT03Dniby8DwWuAq4vHVNgXIeNt4MNpFbqKe25ryKjUV91uMQp5o4uad
         hrDmHC87maTqQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 12 Jan 2023 19:51:50 +0000
Subject: [PATCH 4/6] kselftest/arm64: Initialise current at build time in signal tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-clang-v1-4-89c69d377727@kernel.org>
References: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
In-Reply-To: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1382; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QTRTDX1aspFUjlsVcI/SSLmUL0J8HraBN87iqVH8u4A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjwGTqYecAhNJ/68Hz+3JWPKmFN3mjZna3w4n07K/K
 h9NKUNqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8Bk6gAKCRAk1otyXVSH0DYxB/
 9YH/AZ4hQW8JJhM5Y7Ox2Deko1Gjgk+ShcDmSER+HI7olFW73U/z/vsd2yD0GFFGZcxD5rPG+4ODpA
 u11zn3hPs6rtbaeHK15IFpBI8Ce96gIVu2kinFt1mL6MOAuUGZ+thzKro4Hl31ffHz8YcsC08zn7/V
 0w9DjWZ7rCXnNhHi/1U/Qtifen6vSRHS+hXIjm8DCB4raN1qq+4mqixf9DpbZqB7pqjMOtjaR6Mkjl
 UDRHQJpV+skBGnz7fm7xU1i69GAWR+yqIpV6Duh8LGYbCbF9du6YwgBSfkQh+bb1y9jhqcr8K0qDAh
 hCrgsiiqLndHDckDbIHEAROl9fkv9Y
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

When building with clang the toolchain refuses to link the signals
testcases since the assembly code has a reference to current which has
no initialiser so is placed in the BSS:

  /tmp/signals-af2042.o: in function `fake_sigreturn':
  <unknown>:51:(.text+0x40): relocation truncated to fit: R_AARCH64_LD_PREL_LO19 against symbol `current' defined in .bss section in /tmp/test_signals-ec1160.o

Since the first statement in main() initialises current we may as well
fix this by moving the initialisation to build time so the variable
doesn't end up in the BSS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/test_signals.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
index 416b1ff43199..00051b40d71e 100644
--- a/tools/testing/selftests/arm64/signal/test_signals.c
+++ b/tools/testing/selftests/arm64/signal/test_signals.c
@@ -12,12 +12,10 @@
 #include "test_signals.h"
 #include "test_signals_utils.h"
 
-struct tdescr *current;
+struct tdescr *current = &tde;
 
 int main(int argc, char *argv[])
 {
-	current = &tde;
-
 	ksft_print_msg("%s :: %s\n", current->name, current->descr);
 	if (test_setup(current) && test_init(current)) {
 		test_run(current);

-- 
2.30.2
