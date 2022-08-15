Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B41593001
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiHONdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243008AbiHONdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:33:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BC15718
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA72B80EC0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3F7C433D7;
        Mon, 15 Aug 2022 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570383;
        bh=6rK/9PZALGAoGA9wCW1CCtvSgsEbMadnadvWyxX6Jfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNSFYZHn14/n2pUZUyWgxyEkLiMDJSW+EXMKXQlUvXLvRx5jtva1eX2YNPCE1bwtt
         GjxS6TSr4eDdjOgl32eGd2H1rYgAFBeP5+rJaLASvZMn6Ac7aNCTcn9wvNMAQed+Ss
         ILcaDz1Dj3YJKqSXMrCQTwbqwuDcXh7GKFCSpZqJg/WqsWt32kIqWasqHYoY9ec9Ug
         GBTYwAp2lCsVR6MzU3e8vbZBwSRWpa9OivQnxeiQ2gnmSek4/aOE04TMnhn/DL+8tr
         A5D2Rr0UNbnF7wUvrD7UW3r5O7qfqjR4MKF9cXvlgFqTYT5zNDAGnD6y9zIfC9JzBi
         7i3rOyf9QYY6w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 08/10] kselftest/arm64: Preserve any EXTRA_CONTEXT in handle_signal_copyctx()
Date:   Mon, 15 Aug 2022 14:32:34 +0100
Message-Id: <20220815133236.235464-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=broonie@kernel.org; h=from:subject; bh=6rK/9PZALGAoGA9wCW1CCtvSgsEbMadnadvWyxX6Jfw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kryODfg/LpIpbn9yartoDqNbxpiXcDV5WNM7X2h 3GTCDmSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK8gAKCRAk1otyXVSH0FoBB/ 9KLCPXutzCqwR69nUAzD9nI23dyi0S9x5MXZpaqrRmnAwZfnfu0ckrGZUiLArQt6Ocr9sJUXItCfhC CSaudvgkoeSYR83i9dMKH4l631l0AS+VqoZitDtnfB8Pb3Xs6aNMXHFdglZdObE7UJq5WvFk6+/anF lqms00PLPMw4fh1oEhwEvFcnbJoopEon1qUnhR5tWjK0m0MCuvOycRVAu7cSnonZvI6OaFLoPRCl8O V73MVF0zX7bCGMlfa8Gi272G1IE9WURgPRqFLAt7mGTcyqS6AxpByEAenI05p2B3mNPqVMQX9Z056A AkNSkZ5vaUsmnF0mOExjefN3FQQ2nl
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When preserving the signal context for later verification by testcases
check for and include any EXTRA_CONTEXT block if enough space has been
provided.

Since the EXTRA_CONTEXT block includes a pointer to the start of the
additional data block we need to do at least some fixup on the copied
data. For simplicity in users we do this by extending the length of
the EXTRA_CONTEXT to include the following termination record, this
will cause users to see the extra data as part of the linked list of
contexts without needing any special handling. Care will be needed if
any specific tests for EXTRA_CONTEXT are added beyond the validation
done in ASSERT_GOOD_CONTEXT.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/test_signals_utils.c         | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/test_signals_utils.c b/tools/testing/selftests/arm64/signal/test_signals_utils.c
index a54dc1b6f35c..308e229e58ab 100644
--- a/tools/testing/selftests/arm64/signal/test_signals_utils.c
+++ b/tools/testing/selftests/arm64/signal/test_signals_utils.c
@@ -168,15 +168,61 @@ static bool handle_signal_copyctx(struct tdescr *td,
 				  siginfo_t *si, void *uc_in)
 {
 	ucontext_t *uc = uc_in;
+	struct _aarch64_ctx *head;
+	struct extra_context *extra, *copied_extra;
+	size_t offset = 0;
+	size_t to_copy;
 
 	ASSERT_GOOD_CONTEXT(uc);
 
 	/* Mangling PC to avoid loops on original BRK instr */
 	uc->uc_mcontext.pc += 4;
-	memcpy(td->live_uc, uc, td->live_sz);
+
+	/*
+	 * Check for an preserve any extra data too with fixups.
+	 */
+	head = (struct _aarch64_ctx *)uc->uc_mcontext.__reserved;
+	head = get_header(head, EXTRA_MAGIC, td->live_sz, &offset);
+	if (head) {
+		extra = (struct extra_context *)head;
+
+		/*
+		 * The extra buffer must be immediately after the
+		 * extra_context and a 16 byte terminator. Include it
+		 * in the copy, this was previously validated in
+		 * ASSERT_GOOD_CONTEXT().
+		 */
+		to_copy = offset + sizeof(struct extra_context) + 16 +
+			extra->size;
+		copied_extra = (struct extra_context *)&(td->live_uc->uc_mcontext.__reserved[offset]);
+	} else {
+		copied_extra = NULL;
+		to_copy = sizeof(ucontext_t);
+	}
+
+	if (to_copy > td->live_sz) {
+		fprintf(stderr,
+			"Not enough space to grab context, %lu/%lu bytes\n",
+			td->live_sz, to_copy);
+		return false;
+	}
+
+	memcpy(td->live_uc, uc, to_copy);
+
+	/*
+	 * If there was any EXTRA_CONTEXT fix up the size to be the
+	 * struct extra_context and the following terminator record,
+	 * this means that the rest of the code does not need to have
+	 * special handling for the record and we don't need to fix up
+	 * datap for the new location.
+	 */
+	if (copied_extra)
+		copied_extra->head.size = sizeof(*copied_extra) + 16;
+
 	td->live_uc_valid = 1;
 	fprintf(stderr,
-		"GOOD CONTEXT grabbed from sig_copyctx handler\n");
+		"%lu byte GOOD CONTEXT grabbed from sig_copyctx handler\n",
+		to_copy);
 
 	return true;
 }
-- 
2.30.2

