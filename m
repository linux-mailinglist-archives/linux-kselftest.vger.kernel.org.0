Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C23741BFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jun 2023 00:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjF1WxW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 18:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjF1WxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 18:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115231FDC
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 15:53:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35DE6147F
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jun 2023 22:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8840C433C0;
        Wed, 28 Jun 2023 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687992787;
        bh=68dGS9oL40E7cxdas87mbb7uykwmjXBlTk6CNaE/6js=;
        h=From:Date:Subject:To:Cc:From;
        b=Of9FpDUs+wLlMVvLx52h778prjGxFklP/8n68rg7D+R1QeV4iklucVkkZQCBHZ+zN
         XsCESndZOsBMEFLSoOvaVx+X1OdJi2sjGrBHRdUXVlVo+Bf76CAiOhNr4mlcBRzlsW
         qKg5N8lz44lz5m0Tg9pqUx4Wz9273hNggF2iR8UIuvo1s3nG8/FOJy9MCBUZTIGL8h
         B3XUcjVVcp8gC6QdRVTFr8qCGU4Rap9fVkpau0O845frZLbn+rPFvv0SPSDqiycU6p
         mQqVasj0FE/frbToHS+oNU/jEQdtJDakv/m5qJxpLkjmxoQ53qaBxcFIUptK522pS1
         2OQmFbVOq2IuA==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 28 Jun 2023 23:52:58 +0100
Subject: [PATCH] kselftest/arm64: Exit streaming mode after collecting
 signal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-arm64-signal-memcpy-fix-v1-1-db3e0300829e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMm5nGQC/x2N3QqDMAxGX0VyvUBth5O9ythFWqOGrVUS2A/iu
 6/u8hy+w7eBsQobXJsNlF9ispQK7amBNFOZGGWoDN754DrfI2nuzmgyFXpi5pzWL47ywcvAIYb
 Uj9Q6qHUkY4xKJc1H/170cehVua7/h7f7vv8A1FwFhoAAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=broonie@kernel.org;
 h=from:subject:message-id; bh=68dGS9oL40E7cxdas87mbb7uykwmjXBlTk6CNaE/6js=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBknLnQSHo0ow++6DWpt9+O4FILzu3JfJuC9rm1CN0o
 5wrrYemJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJy50AAKCRAk1otyXVSH0H2DB/
 4/bkq3fpGQY5GtAM+B7ksIgMK9vV9/3HHOlJ2tYT9YRs3O3L+Pqz4H2C6yjFeRnhnzjG4H9v58f546
 rGwA0zwRO61DHwRZVaHfouvKT+gMU+LUTpmJCdb2GJyR+/Ot5fhMWbQYprJdOUy/fc/ZMxEM4gGVn0
 WUbSj2iBeLSf6+escBUZ47BX+YNHvqztsxknLT4vVJcY7naNKkOE6UokJFEXK117nU0+cHbHk8cshm
 WwvvpnVAmRFu1xaauWhqUt+ce/5j6XIxP7/jHN0Mw9sFkFHPegoue9MdE/vbtGxtNccE5X5VdJD7mJ
 ljDeFpliQ7KOfi+1BKZUbPoAJn7oOx
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
 .../selftests/arm64/signal/test_signals_utils.h    | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.h b/tools/testing/selftests/arm64/signal/test_signals_utils.h
index 222093f51b67..db28409fd44b 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.h
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.h
@@ -60,13 +60,28 @@ static __always_inline bool get_current_context(struct tdescr *td,
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
+		asm volatile("nop"
+			     : "+m" (*dest_uc)
+			     :
+			     : "memory");
+		uc[i] = 0;
+	}
+
 	td->live_uc = dest_uc;
 	/*
 	 * Grab ucontext_t triggering a SIGTRAP.
@@ -103,6 +118,17 @@ static __always_inline bool get_current_context(struct tdescr *td,
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
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230628-arm64-signal-memcpy-fix-7de3b3c8fa10

Best regards,
-- 
Mark Brown <broonie@kernel.org>

