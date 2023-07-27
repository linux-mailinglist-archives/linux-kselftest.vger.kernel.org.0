Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C7766035
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjG0X1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjG0X1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6E30C5
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D573561F7C
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DD7C433CC;
        Thu, 27 Jul 2023 23:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500418;
        bh=17quVgwOUPp97Iqg3owW8+YLOqublPdMuTjqZWkARPo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=nkjp21yMDGAvaeHDkJINc7Yk4jYHJd6TVWwyVsWQ34LHn+p66SHnj9bdZLBqXAsbM
         oqCSS8+IEOyZaUy+EikWmvjemOoC3hXfqqwqhN0PM31fMD12PDPaaD0ksIbsizHF2h
         Sh+5pwlwqqCrYs3c8/dSnZf1JG+UKI8UETFh9mNi9qxMIysiu9RUcT0N1wghmtaJme
         xQ/QAKgsDFivbvnypgxgHtHlZQLf6Kvhj3u5PisjaLaC3HdIpHSUYBy/xJatZnOkS1
         57ybyZnMwdF8b4UKHgSCNGiPeZ+DXXS53B0MhZelrrvrJMVXbA4KyrNmb7aYypDKBu
         Y9BNwnyhg4Wxg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:12 +0100
Subject: [PATCH v4 1/6] kselftest/arm64: Exit streaming mode after
 collecting signal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-1-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3033; i=broonie@kernel.org;
 h=from:subject:message-id; bh=17quVgwOUPp97Iqg3owW8+YLOqublPdMuTjqZWkARPo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv05VrGqW153ETqB2RJgnxvIF7+LzYv/IlYjhZ6Z
 s8dnsWSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9OQAKCRAk1otyXVSH0MWiB/
 0WLVRgq5i6hfMb4hl9vOiSFuzNvjGpyAaNmITZMvRqoaXQqNMCrVQXbcmW8BJhnEbdXq9f689krKZJ
 dWBcisXyxaUCfUh4TwQdOByvBjuIPRX88f9M3hgscq420v63Zdr3RTkmaFoXOFqRFI5dr0BDnveseH
 YSUtg6kEvpBEtEZR2rCbA3vqBGOtZLnQrf93RrUSrNA384N8IKOxSpnRauUiYRZekWZgUNOREZU/ej
 TlOl2k1QVVsXVM7+oRFrsP1rkJd1fUzqgRE2UfCGsk8KkDJbKp2VOribAg3KwJCEfkNZRdr5rYixX0
 liQAB9Bj+61qzyJAfNPJlOj0hSZhXm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we collect a signal context with one of the SME modes enabled we will
have enabled that mode behind the compiler and libc's back so they may
issue some instructions not valid in streaming mode, causing spurious
failures.

For the code prior to issuing the BRK to trigger signal handling we need to
stay in streaming mode if we were already there since that's a part of the
signal context the caller is trying to collect. Unfortunately this code
includes a memset() which is likely to be heavily optimised and is likely
to use FP instructions incompatible with streaming mode. We can avoid this
happening by open coding the memset(), inserting a volatile assembly
statement to avoid the compiler recognising what's being done and doing
something in optimisation. This code is not performance critical so the
inefficiency should not be an issue.

After collecting the context we can simply exit streaming mode, avoiding
these issues. Use a full SMSTOP for safety to prevent any issues appearing
with ZA.

Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/signal/test_signals_utils.h    | 25 +++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 222093f51b67..c7f5627171dd 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -60,13 +60,25 @@ static __always_inline bool get_current_context(struct tdescr *td,
 						size_t dest_sz)
 {
 	static volatile bool seen_already;
+	int i;
+	char *uc = (char *)dest_uc;
 
 	assert(td && dest_uc);
 	/* it's a genuine invocation..reinit */
 	seen_already = 0;
 	td->live_uc_valid = 0;
 	td->live_sz = dest_sz;
-	memset(dest_uc, 0x00, td->live_sz);
+
+	/*
+	 * This is a memset() but we don't want the compiler to
+	 * optimise it into either instructions or a library call
+	 * which might be incompatible with streaming mode.
+	 */
+	for (i = 0; i < td->live_sz; i++) {
+		uc[i] = 0;
+		__asm__ ("" : "=r" (uc[i]) : "0" (uc[i]));
+	}
+
 	td->live_uc = dest_uc;
 	/*
 	 * Grab ucontext_t triggering a SIGTRAP.
@@ -103,6 +115,17 @@ static __always_inline bool get_current_context(struct tdescr *td,
 		      :
 		      : "memory");
 
+	/*
+	 * If we were grabbing a streaming mode context then we may
+	 * have entered streaming mode behind the system's back and
+	 * libc or compiler generated code might decide to do
+	 * something invalid in streaming mode, or potentially even
+	 * the state of ZA.  Issue a SMSTOP to exit both now we have
+	 * grabbed the state.
+	 */
+	if (td->feats_supported & FEAT_SME)
+		asm volatile("msr S0_3_C4_C6_3, xzr");
+
 	/*
 	 * If we get here with seen_already==1 it implies the td->live_uc
 	 * context has been used to get back here....this probably means

-- 
2.30.2

