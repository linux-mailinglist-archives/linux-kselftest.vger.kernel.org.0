Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF0667FA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjALTyP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbjALTxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DF1D6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4905C62178
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48FEC433F0;
        Thu, 12 Jan 2023 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553137;
        bh=u6+yBWXwlJoJ5QKUR3rLnp8LjmUI7kWiCb26aeGf9b4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=tT8CBbYfUxpiwY9BAs2kt6xrfDvINXVkVvh83wXJtq+XmlQOF9EImoIuQdT7SC1Wi
         SQenIEG8ZUCe4+d26aSHCwJppBwG1/go4aNUHY+5T7agT3+rRmku15E4DoEd1/C4/1
         kBLaZG7G7MDy7s5n6+V4N2RIpHNaM0IltUI6HWuqrTvin76eoZJlYJU9FXgGxlYrue
         yvcUSnwRMv3cJwnVwnmlnAETRTCbgMUsEMKC+IL7G6hjo+N2s++iRtoe8iLE+C5UNr
         +lAuOB0UNqGEwgv+6sdGBofodAplGV1+tMu/d6bTo/MKe9jBvTUyjCvRxoePWyxOno
         B3cMqdIqnoSVw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 12 Jan 2023 19:51:47 +0000
Subject: [PATCH 1/6] kselftest/arm64: Fix .pushsection for strings in FP tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-clang-v1-1-89c69d377727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u6+yBWXwlJoJ5QKUR3rLnp8LjmUI7kWiCb26aeGf9b4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjwGToDfmBRw3aMYCrY+koTvPBIZmSV1XzYVl+0CFR
 j9N+3q+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8Bk6AAKCRAk1otyXVSH0L7rB/
 0WfOLlpAWfJg8CT1tANCZiXVIrxqeLnOvTnMpKvcDkEdVARFwSrK+B2w/jKO4gHiQT4kZJQSLRK9cR
 jrK86NA9Yad0czjbl1hKaEswMtIpIohAFllEWly9HP3MliHdF2tb/Zgxh5T9hp+KFKsoMgzUEt9KKm
 tmMbKG9tGeqcz2EMNkw8dYh2Pv7caXfr3Jj8BWxA9bEWKGs4BIR4AdK7XzFtNdH9kMjVDxRmKuCy1r
 SMgbUHjUx5XaRtyGohRSSiJ14PFPgCrwfGSFeXXDTZfLRONZtT7ypalxyPTorHWgsZKm2jKznraQl6
 6qrLakds5hclklpgQ+uL4HcRmdZ/BJ
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

The .pushsection directive used to store the strings used with the .puts
macro in the floating point helpers does not provide a section type but
according to the gas documentation this should be mandatory and with the
clang built in as it actually is. Provide one so that we can build these
tests with LLVM=1.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/assembler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/assembler.h b/tools/testing/selftests/arm64/fp/assembler.h
index 90bd433d2665..9b38a0da407d 100644
--- a/tools/testing/selftests/arm64/fp/assembler.h
+++ b/tools/testing/selftests/arm64/fp/assembler.h
@@ -57,7 +57,7 @@ endfunction
 // Utility macro to print a literal string
 // Clobbers x0-x4,x8
 .macro puts string
-	.pushsection .rodata.str1.1, "aMS", 1
+	.pushsection .rodata.str1.1, "aMS", @progbits, 1
 .L__puts_literal\@: .string "\string"
 	.popsection
 

-- 
2.30.2
