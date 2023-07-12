Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8316075055C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjGLLCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGLLCg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 07:02:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3811D
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 04:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 715F861752
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 11:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D78C433C8;
        Wed, 12 Jul 2023 11:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689159754;
        bh=2mWDjQp5+GpNq/GRcRtBqmoZff+bAr6SlaGae/vx718=;
        h=From:Date:Subject:To:Cc:From;
        b=eC7AuxQZ+FZiLUeJ8ov8NpLNY3wyQsz8bHCo6v21jNLAdinpdfNQL1IhNvHucZHad
         UrhezwfEUdRMpXOBg210EeEmQdKiXacqexfF21vOBt4sNfZw8N9T+5r/NAIsGRXPCN
         O/uO6wpz+IO51dRPdldwtRSDnr5BGTyXatDXOjEMgWguFCYnYKbQ7lqeGUxEE4iQTG
         Yn5j19WUe0D64TjHjh8+jhLR+oZWuHzMi5Avgqvg380B0chlNYcFdqnVWfGEUa757A
         5Izs6W9iuWkxTa5CFNKIE6Cvt7fPApwWxCYO35M7l3dxmY9iY1UwB77eoId6UB8jW+
         QHN9QqC1gWZyA==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 12 Jul 2023 12:02:30 +0100
Subject: [PATCH v2] kselftest/arm64: Exit streaming mode after collecting
 signal context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEWIrmQC/4WNTQ6CMBBGr2K6dkx/DKIr72FYtGWACdCSqUEJ4
 e4WLuDyffle3ioSMmESj9MqGGdKFEMGfT4J39nQIlCdWWipjSx0CZbH4gqJ2mAHGHH00wINfeF
 Wo3HGl41VUmTb2YTg2Abf7f4ncr/PE2N+H8FXlbmj9I68HP1Z7ev/1KxAQe0MSiNlqe/47JEDD
 pfIrai2bfsBUTPQeNYAAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=3381; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2mWDjQp5+GpNq/GRcRtBqmoZff+bAr6SlaGae/vx718=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrohIgsmMAErTvLQG9UmY26NmbLbD9xRbnhsiZGRT
 wQUP18WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK6ISAAKCRAk1otyXVSH0LoEB/
 9iq+T3OPB2b4CE45agp0b+C1LyMkD8qxtBF1I0IirVfSX7x4HmBeGKSiJo3BJZTNMEzitLo40KSb2q
 HRQ9UNb+M8GrFm4YYfOWRVAdI4Xk9bOk9W1rhWWhGTWpr+fWt0dgP01CQvmFShkDSqkIlzAMBEtsHp
 mZjRu5aXLOvBEYGidUJn/iwl1N4dnUHXDFXv8zwOa1BZ3nmfABTXEaEkT/TkOubSs8g2Dp9lWhGSiv
 eIWAwUB1FC1VDGYpyd5az5W2O5tXgStO28c6iZcxeUeF2UzGB/Zht7wsBdFvf3oINyD8IW1gElEd2I
 ZqrUTGCuYwoXRwsuzqxDlCuK/klrXX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Changes in v2:
- Rebase onto v6.5-rc1.
- Link to v1: https://lore.kernel.org/r/20230628-arm64-signal-memcpy-fix-v1-1-db3e0300829e@kernel.org
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
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230628-arm64-signal-memcpy-fix-7de3b3c8fa10

Best regards,
-- 
Mark Brown <broonie@kernel.org>

