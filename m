Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F54593002
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiHONdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiHONdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:33:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D515718
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7704CB80EBC
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63358C43141;
        Mon, 15 Aug 2022 13:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570388;
        bh=uQocCmCf8k/A6P+eCrG+zLjWeDLQEf5/ywHNv0Ynfis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3G3598s/baZt5rgiF3jEwTzM8CII+mZaW5LbZEvhZcH1KNE524sqPAEnjScQUTMC
         jkBVsbcqCgIlamzPugFSnAurQw7wa7+LxpvnZZ1hSVmjnGjkY9dpUA8pBCKoC7lXwk
         Kl99MNRNn+z9WrSLI5p59HHpXVl6dUvDmMhTcknFpoBvWYwlI59eOP7R44K0/2RhNG
         0ltrByo+G0G5DPAK3IDSwNLbeBjb3lWNp2kCJnN3ED4nNDw41YnXXde+5wUvwNvJCk
         hkHPZXfppCP86pwiyRgtq784wb8zRku2qbb8PcqsO8Bi5ChRPK1qJFaiLtbUmgtsWD
         k9NEoGWPxBArw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 10/10] kselftest/arm64: Include larger SVE and SME VLs in signal tests
Date:   Mon, 15 Aug 2022 14:32:36 +0100
Message-Id: <20220815133236.235464-11-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7369; i=broonie@kernel.org; h=from:subject; bh=uQocCmCf8k/A6P+eCrG+zLjWeDLQEf5/ywHNv0Ynfis=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+krzhmkNqeBcht3FxXt1jcBGuQuERWUJEr1epuio CRPgrGOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK8wAKCRAk1otyXVSH0AY/CA CDLgmbH3piu8jzJ2VKWtqdQGghV55g4H16MSqzYVbfpurgVU0OJ/GYsT0gxYuL4GtbKofAiU1HEJLB /S6bR84uCEzYmS2/1ZOwQuV/9UMEhWFJZB7KQL++T4uSDWRGSRnbuUFpdnTyvWUokS6HgCeobsIARO Uo2I+Ynkx5WK4EPGlC5GDLki73f/67Aq8RSqCHcVBT1E8PsL1THeWFu280oizii/XmE87yBvKSOWSR R+Bs+XlJhZ/AIF6PsBm5ujag8379gO7IvUji2Y+Rv7r8ttbWvbYKKQNgjWfLPZgkKTLZpkmKgLNdpj LBy9xy0NaPEd5sYqyYWnAL1nMrtTIg
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

Now that the core utilities for signal testing support handling data in
EXTRA_CONTEXT blocks we can test larger SVE and SME VLs which spill over
the limits in the base signal context. This is done by defining storage
for the context as a union with a ucontext_t and a buffer together with
some helpers for getting relevant sizes and offsets like we do for
fake_sigframe, this isn't the most lovely code ever but is fairly
straightforward to implement and much less invasive to the somewhat
unclear and indistinct layers of abstraction in the signal handling test
code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/ssve_regs.c        | 25 +++++++------------
 .../arm64/signal/testcases/sve_regs.c         | 23 +++++++----------
 .../arm64/signal/testcases/testcases.h        |  7 ++++++
 .../arm64/signal/testcases/za_regs.c          | 24 ++++++------------
 4 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
index 71f14632c524..d0a178945b1a 100644
--- a/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_regs.c
@@ -13,7 +13,10 @@
 #include "test_signals_utils.h"
 #include "testcases.h"
 
-struct fake_sigframe sf;
+static union {
+	ucontext_t uc;
+	char buf[1024 * 64];
+} context;
 static unsigned int vls[SVE_VQ_MAX];
 unsigned int nvls = 0;
 
@@ -55,8 +58,8 @@ static void setup_ssve_regs(void)
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 			 unsigned int vl)
 {
-	size_t resv_sz, offset;
-	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
 	struct sve_context *ssve;
 	int ret;
 
@@ -73,11 +76,11 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 	 * in it.
 	 */
 	setup_ssve_regs();
-	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
+	if (!get_current_context(td, &context.uc, sizeof(context)))
 		return 1;
 
-	resv_sz = GET_SF_RESV_SIZE(sf);
-	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	head = get_header(head, SVE_MAGIC, GET_BUF_RESV_SIZE(context),
+			  &offset);
 	if (!head) {
 		fprintf(stderr, "No SVE context\n");
 		return 1;
@@ -101,16 +104,6 @@ static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	int i;
 
 	for (i = 0; i < nvls; i++) {
-		/*
-		 * TODO: the signal test helpers can't currently cope
-		 * with signal frames bigger than struct sigcontext,
-		 * skip VLs that will trigger that.
-		 */
-		if (vls[i] > 64) {
-			printf("Skipping VL %u due to stack size\n", vls[i]);
-			continue;
-		}
-
 		if (do_one_sme_vl(td, si, uc, vls[i]))
 			return 1;
 	}
diff --git a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
index 4cdedb706786..8b16eabbb769 100644
--- a/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/sve_regs.c
@@ -13,7 +13,10 @@
 #include "test_signals_utils.h"
 #include "testcases.h"
 
-struct fake_sigframe sf;
+static union {
+	ucontext_t uc;
+	char buf[1024 * 64];
+} context;
 static unsigned int vls[SVE_VQ_MAX];
 unsigned int nvls = 0;
 
@@ -55,8 +58,8 @@ static void setup_sve_regs(void)
 static int do_one_sve_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 			 unsigned int vl)
 {
-	size_t resv_sz, offset;
-	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
 	struct sve_context *sve;
 
 	fprintf(stderr, "Testing VL %d\n", vl);
@@ -71,11 +74,11 @@ static int do_one_sve_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 	 * in it.
 	 */
 	setup_sve_regs();
-	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
+	if (!get_current_context(td, &context.uc, sizeof(context)))
 		return 1;
 
-	resv_sz = GET_SF_RESV_SIZE(sf);
-	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
+	head = get_header(head, SVE_MAGIC, GET_BUF_RESV_SIZE(context),
+			  &offset);
 	if (!head) {
 		fprintf(stderr, "No SVE context\n");
 		return 1;
@@ -99,14 +102,6 @@ static int sve_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	int i;
 
 	for (i = 0; i < nvls; i++) {
-		/*
-		 * TODO: the signal test helpers can't currently cope
-		 * with signal frames bigger than struct sigcontext,
-		 * skip VLs that will trigger that.
-		 */
-		if (vls[i] > 64)
-			continue;
-
 		if (do_one_sve_vl(td, si, uc, vls[i]))
 			return 1;
 	}
diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.h b/tools/testing/selftests/arm64/signal/testcases/testcases.h
index b39f538c7be1..040afded0b76 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.h
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.h
@@ -30,6 +30,13 @@
 #define GET_SF_RESV_SIZE(sf) \
 	sizeof((sf).uc.uc_mcontext.__reserved)
 
+#define GET_BUF_RESV_HEAD(buf) \
+	(struct _aarch64_ctx *)(&(buf).uc.uc_mcontext.__reserved)
+
+#define GET_BUF_RESV_SIZE(buf) \
+	(sizeof(buf) - sizeof(buf.uc) +	\
+	 sizeof((buf).uc.uc_mcontext.__reserved))
+
 #define GET_UCP_RESV_SIZE(ucp) \
 	sizeof((ucp)->uc_mcontext.__reserved)
 
diff --git a/tools/testing/selftests/arm64/signal/testcases/za_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
index 1c008bca73a1..d334fe210595 100644
--- a/tools/testing/selftests/arm64/signal/testcases/za_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/za_regs.c
@@ -13,7 +13,10 @@
 #include "test_signals_utils.h"
 #include "testcases.h"
 
-struct fake_sigframe sf;
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
 static unsigned int vls[SVE_VQ_MAX];
 unsigned int nvls = 0;
 
@@ -55,8 +58,8 @@ static void setup_za_regs(void)
 static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 			 unsigned int vl)
 {
-	size_t resv_sz, offset;
-	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
 	struct za_context *za;
 
 	fprintf(stderr, "Testing VL %d\n", vl);
@@ -71,11 +74,10 @@ static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
 	 * in it.
 	 */
 	setup_za_regs();
-	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
+	if (!get_current_context(td, &context.uc, sizeof(context)))
 		return 1;
 
-	resv_sz = GET_SF_RESV_SIZE(sf);
-	head = get_header(head, ZA_MAGIC, resv_sz, &offset);
+	head = get_header(head, ZA_MAGIC, GET_BUF_RESV_SIZE(context), &offset);
 	if (!head) {
 		fprintf(stderr, "No ZA context\n");
 		return 1;
@@ -99,16 +101,6 @@ static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	int i;
 
 	for (i = 0; i < nvls; i++) {
-		/*
-		 * TODO: the signal test helpers can't currently cope
-		 * with signal frames bigger than struct sigcontext,
-		 * skip VLs that will trigger that.
-		 */
-		if (vls[i] > 32) {
-			printf("Skipping VL %u due to stack size\n", vls[i]);
-			continue;
-		}
-
 		if (do_one_sme_vl(td, si, uc, vls[i]))
 			return 1;
 	}
-- 
2.30.2

