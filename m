Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6175B703
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGTSmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTSmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 14:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8276E4C
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 11:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D72A61BF7
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 18:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5581CC433CA;
        Thu, 20 Jul 2023 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878536;
        bh=ogNPBpjaoU1rrWFVWy2ttmdFeJc6AkA6cnBWnNS+UY0=;
        h=From:Date:Subject:To:Cc:From;
        b=EWzbZFvRtuuM3aBB/khLmBjCS4zhZMaE0zFBUJByTsqQd+vII+OnsKc5qHKaWKcTq
         xDfEbAb0PDBKFa5wj+osYKHMLcbX9OB7XyEHWNxRd/qI5Jwqxfm5Bs43S0tMpbgU9z
         TOEVDr1VzGvcV04ZR6o5JraLxNlRZRFHLd5D6fLzC4o49BnmqYiCc3rYc+evF4Ks1y
         WhaLDflLslfkQAP9WRFzps9I7Lihx0z13CW2iMqdIk20RfOxmECYCvf3qkIr3fqMKU
         YjBIF5vpqRDs4/47BjxGJWH6/OLZCEp+TtHSaCk6HMqZUKYkhe8iDS0GqtTiKIf6nU
         GDsO5qEuhwNUw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 20 Jul 2023 19:42:09 +0100
Subject: [PATCH v3] kselftest/arm64: Exit streaming mode after collecting
 signal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org>
X-B4-Tracking: v=1; b=H4sIAACAuWQC/4WNyw6CMBREf4V07TV9IKAr/8O4KOUCDdCSW4MSw
 r9b2BgXxuVMZs5ZWECyGNglWRjhZIP1LgZ1SJhptWsQbBUzk1wqnskCNA1ZCsE2Tvcw4GDGGWr
 7grxCVSpT1FpwFt+lDgglaWfa7f/01G31SBjXu/B2j7m14eFp3v2T2Nr/qkmAgKpUyBXnhTzjt
 UNy2B89NWyDTvIDyoX8DZIRlJ7TOufyZHSdfYHWdX0D9OeJJR8BAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ogNPBpjaoU1rrWFVWy2ttmdFeJc6AkA6cnBWnNS+UY0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkuYAGbw+yZlSmWB2RH/rY1JXMmmmy2hwvbUVnz+EY
 dsuGBXKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLmABgAKCRAk1otyXVSH0Es/B/
 4zPAcTuZyYSJAegdL91LF9I8SlW7TiIMLbdmPHvqGzFpl1HVtbpoZ+I0KswX6mq1ybI+5HwaGr7Thc
 gZnEYh0bKGw4OTD5upKan/ECBCqlkMF+O81XmVGuW/eAg2Ruey5HkzpCNzbhKw31Li985q81ic7TA3
 XdmTqgJ8X9geaxe4bFsP+7hsHF/t1VOpeR9ADHYN7bM1LeH3HfM9vUefRK1cZRSw9bok1wuL6chBz+
 lFB4HjscU0qzW7s9Md3UKk9DTL52bLETmjqVo7WpQozU8DUTKNnMRtuSO5PrXxj/azIpbtgG6iJnQY
 r33RZJFrWSg0pXmlgwkthvamumh6Ci
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- Open code OPTIMISER_HIDE_VAR() instead of the memory clobber.
- Link to v2: https://lore.kernel.org/r/20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org

Changes in v2:
- Rebase onto v6.5-rc1.
- Link to v1: https://lore.kernel.org/r/20230628-arm64-signal-memcpy-fix-v1-1-db3e0300829e@kernel.org
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

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230628-arm64-signal-memcpy-fix-7de3b3c8fa10

Best regards,
-- 
Mark Brown <broonie@kernel.org>

