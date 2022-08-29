Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BF5A5115
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiH2QIM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiH2QII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 12:08:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46018F94E
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 09:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207F5B8111B
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 16:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC02C433B5;
        Mon, 29 Aug 2022 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661789284;
        bh=6rK/9PZALGAoGA9wCW1CCtvSgsEbMadnadvWyxX6Jfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRn61gt5bPOB20vCX17QjBR8d8a/XVMl8NqmgsqclXu77O2tZ6ldmWrdVA4wOQbIw
         X6mejvW5t81Eyep9bF//cGStCsdTLddSQCaoZWSD5I13kY6I3zH8e6KLOixC1i2Vgo
         X0YYdC5ucIRdOZ7MQiQRfF0X4rqovHMRFViJGWU9LtUjg1SCiqE4spn1Noy1+etB8t
         dKvLuC5EOcQehh7scG1Q9gP/GEE+ciTkjfvUoxGQL4OEVJWpIIowTXwepd7Dzo0WGV
         y7D46kzHJvwx87+gl6CE9WO34WbBPcKEYWnfBOJ1AWLs3IJJRquIB+QSGsCTiVEs/0
         11u5cn3hG2FHg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 08/10] kselftest/arm64: Preserve any EXTRA_CONTEXT in handle_signal_copyctx()
Date:   Mon, 29 Aug 2022 17:07:01 +0100
Message-Id: <20220829160703.874492-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829160703.874492-1-broonie@kernel.org>
References: <20220829160703.874492-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=broonie@kernel.org; h=from:subject; bh=6rK/9PZALGAoGA9wCW1CCtvSgsEbMadnadvWyxX6Jfw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOQlODfg/LpIpbn9yartoDqNbxpiXcDV5WNM7X2h 3GTCDmSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzkJQAKCRAk1otyXVSH0ALcB/ 4q6mQL1rc2kwlCUnrbDpGS3WIutjDxNgGZ9pEZBkvQpZv5CeaClDIt3ngB5lw2KX43/pnBs1ObGY1Q mTIbKb4ut7IXu45tx6dbptkoHUXglfv0bdSQ9UpA0BIJIHLwRM+adw5Onkrzvie79x9BfRwYltjHo0 xfhTzj6S+TxzzXUZrzvMkmHXmzR0z5fr54iU6gnC5SG/xIqDpfxyF0VGe5DP3+Uins/fGiLsq0x+EA YWfWHgOo12shgZEtSX6ju+YOD5MMuYI3V8I1hPZoKmK7NRhpL6vHrswaquZr+gbmxdLoluhcEdeJwz R27u5r1KVP5IIdUuSC6qCyjFTprlx4
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

