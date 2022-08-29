Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B595A50D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH2P6F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiH2P6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:58:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4115597B1E
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:58:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2CEFB81103
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52517C433D7;
        Mon, 29 Aug 2022 15:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788680;
        bh=iho2djtRhDbfxqjfHfG89LpdrLeoz0UBV3Z/8njN3p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbSvpfD9dhwyc4Zv2M0U5Hy0+0I79y1CbZe6UkPQUOQsaHDN+eD3Qn9+OuzhK7g1f
         jMgoERTGDopSjfOIvv+GJxsyvbK3fvEHaR8/pJcQ+moQxD0kBN2EkazDEr250KmWJI
         uy4d+BloibUkOoYT0bOKVCLvtyiGzN7aJmw/uBPusJKf9qf9TL04BIXQjj5HtHP4ci
         fscbvEpEo+s0LX0U+ZYGjAUQMO9lxHbolLS+/KkHgAzQi0c71rxbYQun5/fodL4uKX
         SpUs5UlyuS9WWAf9inp5gidIBresvHtcu7nLUIRETCVareLTbX7/ilc2/kcL67zp+9
         9Jm5FMTLVjSew==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/2] kselftest/arm64: Add a test for signal frames with ZA disabled
Date:   Mon, 29 Aug 2022 16:57:28 +0100
Message-Id: <20220829155728.854947-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829155728.854947-1-broonie@kernel.org>
References: <20220829155728.854947-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; i=broonie@kernel.org; h=from:subject; bh=iho2djtRhDbfxqjfHfG89LpdrLeoz0UBV3Z/8njN3p0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDOHn3OrybsFfa//wTPFMuFZjpQMJkhLh0Qj9ttPh DI05uumJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzh5wAKCRAk1otyXVSH0L8UB/ 4gxod6F3fb3AyRaqG4K2lxvW92mQxHYR7OkzQvuSw9nE6NxiEmn41MqHlF7fMKtAXaXvwJPqUxcdBG 1b+5NHoTF+t6TwM4nEMxM+vXsdTcMX6WmX/xBauRS7DJ84Yc8ch0NZg2MC7Qs4MHJVmEJpffXWS8cv BdKxqeKvzvJMfGmfQxXkSPREgjIksveDnX2ngLop8l/ESaWwrz3Ex8n+RX/cGgG3GHlmWkffsMguqg yupkWeDT45Ql+ZN6jA3DzJs01RRgMmWnChPdRZL1HdMv5fd49kowmFXm8T58dkyKkg82rMhNDN1gYv K6T/DSrmdMbiSiKqsf9pnmAJCCRckc
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

When ZA is disabled there should be no register data in the ZA signal
frame, add a test case which confirms that this is the case.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/za_no_regs.c       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
new file mode 100644
index 000000000000..4d6f94b6178f
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that the ZA register context in signal frames is set up as
+ * expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+static unsigned int vls[SVE_VQ_MAX];
+unsigned int nvls = 0;
+
+static bool sme_get_vls(struct tdescr *td)
+{
+	int vq, vl;
+
+	/*
+	 * Enumerate up to SME_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SME_SET_VL, vq * 16);
+		if (vl == -1)
+			return false;
+
+		vl &= PR_SME_VL_LEN_MASK;
+
+		/* Skip missing VLs */
+		vq = sve_vq_from_vl(vl);
+
+		vls[nvls++] = vl;
+	}
+
+	/* We need at least one VL */
+	if (nvls < 1) {
+		fprintf(stderr, "Only %d VL supported\n", nvls);
+		return false;
+	}
+
+	return true;
+}
+
+static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
+			 unsigned int vl)
+{
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct za_context *za;
+
+	fprintf(stderr, "Testing VL %d\n", vl);
+
+	if (prctl(PR_SME_SET_VL, vl) != vl) {
+		fprintf(stderr, "Failed to set VL\n");
+		return 1;
+	}
+
+	/*
+	 * Get a signal context which should have a SVE frame and registers
+	 * in it.
+	 */
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	head = get_header(head, ZA_MAGIC, GET_BUF_RESV_SIZE(context), &offset);
+	if (!head) {
+		fprintf(stderr, "No ZA context\n");
+		return 1;
+	}
+
+	za = (struct za_context *)head;
+	if (za->vl != vl) {
+		fprintf(stderr, "Got VL %d, expected %d\n", za->vl, vl);
+		return 1;
+	}
+
+	if (head->size != ZA_SIG_REGS_OFFSET) {
+		fprintf(stderr, "Context size %u, expected %lu\n",
+			head->size, ZA_SIG_REGS_OFFSET);
+		return 1;
+	}
+
+	/* The actual size validation is done in get_current_context() */
+	fprintf(stderr, "Got expected size %u and VL %d\n",
+		head->size, za->vl);
+
+	return 0;
+}
+
+static int sme_regs(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	int i;
+
+	for (i = 0; i < nvls; i++) {
+		if (do_one_sme_vl(td, si, uc, vls[i]))
+			return 1;
+	}
+
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "ZA registers - ZA disabled",
+	.descr = "Check ZA context with ZA disabled",
+	.feats_required = FEAT_SME,
+	.timeout = 3,
+	.init = sme_get_vls,
+	.run = sme_regs,
+};
-- 
2.30.2

