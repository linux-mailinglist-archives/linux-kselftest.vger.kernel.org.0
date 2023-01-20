Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B7D675415
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 13:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjATMEt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 07:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjATMEr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 07:04:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CE47C875;
        Fri, 20 Jan 2023 04:04:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C59EB824B2;
        Fri, 20 Jan 2023 12:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A344C433EF;
        Fri, 20 Jan 2023 12:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674216283;
        bh=AxlzWP6bKYbN0GnwW4HFD2FOqyA4ObEOwSpC6C3TMVo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WvNBXs7kDf+LDPS5KvNo7Mk+i3I+U6Yku8IXJ7x6yR6ikIapfigmFzzRwEw2g5HKh
         rGX+57t3TBRxDSrU1C3jXxvJaw7nprEyYLk2cGq/Q2yvjHed8uAvwavqsU9FEwRgYL
         bBmwufbFyfhJaJGAg1mPNDlnF05u3qArqYKmlxSKla4ICOSBau44QapuZ+A9dj8Oap
         /VfAKbapfnOfjvGSfFgbLq/a4HGjFMF+YISZUnqaUEwlSqxIjgz2BW/ffUIW358vi5
         SIAzlqomhOtRMK+3PvK/+Qhq8FXAwEsMLSoSfJlSlsLPunB9PpFrbIxJSpUAkFL4ed
         Vg/Qppyp+YnkA==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 20 Jan 2023 12:04:09 +0000
Subject: [PATCH 2/2] kselftest/arm64: Verify simultaneous SSVE and ZA
 context generation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230117-arm64-test-ssve-za-v1-2-203c00150154@kernel.org>
References: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
In-Reply-To: <20230117-arm64-test-ssve-za-v1-0-203c00150154@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AxlzWP6bKYbN0GnwW4HFD2FOqyA4ObEOwSpC6C3TMVo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjyoNVHWUkN1v2qrFjL52jNiXt6aMJTyoa1/+Eu2S4
 y+piR3SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8qDVQAKCRAk1otyXVSH0LDbB/
 9vFflIr4202fmnXNpnBP8sn0cctd7RrGBVmkY4P9O8AuKV7NjLLIQvrvTfS/TZhZMy/UMfhj9a/WZu
 Ox6jU+xliFc9N1KqC9gs1uJMdU/1H9zd2fBZn5T+CszetXIw/WhwWO0g7kfhL2MF3MIIhu9jW97Bhl
 mXqj94h3IYqwUxH6WGfSSnKLeAzC90Zz56OpXQYWTjjdfCFb68dnEDLGZARU3yhkuHsSyt+ueKLitM
 au80gapcMRTStHqqu0Z5Qm1PV2YP3elQOb51O86De7t/YzAKWG6pU30C4s5gAMP2wdh6I6JhluezXA
 60KouzTF4gelARoelTUV4baDte6fi1
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

Add a test that generates SSVE and ZA context in a single signal frame to
ensure that nothing is going wrong in that case for any reason.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../arm64/signal/testcases/ssve_za_regs.c          | 162 +++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
new file mode 100644
index 000000000000..954a21f6121a
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that both the streaming SVE and ZA register context in
+ * signal frames is set up as expected when enabled simultaneously.
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
+	 * Enumerate up to SVE_VQ_MAX vector lengths
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
+static void setup_regs(void)
+{
+	/* smstart sm; real data is TODO */
+	asm volatile(".inst 0xd503437f" : : : );
+
+	/* smstart za; real data is TODO */
+	asm volatile(".inst 0xd503457f" : : : );
+}
+
+static char zeros[ZA_SIG_REGS_SIZE(SVE_VQ_MAX)];
+
+static int do_one_sme_vl(struct tdescr *td, siginfo_t *si, ucontext_t *uc,
+			 unsigned int vl)
+{
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct _aarch64_ctx *regs;
+	struct sve_context *ssve;
+	struct za_context *za;
+	int ret;
+
+	fprintf(stderr, "Testing VL %d\n", vl);
+
+	ret = prctl(PR_SME_SET_VL, vl);
+	if (ret != vl) {
+		fprintf(stderr, "Failed to set VL, got %d\n", ret);
+		return 1;
+	}
+
+	/*
+	 * Get a signal context which should have the SVE and ZA
+	 * frames in it.
+	 */
+	setup_regs();
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	regs = get_header(head, SVE_MAGIC, GET_BUF_RESV_SIZE(context),
+			  &offset);
+	if (!regs) {
+		fprintf(stderr, "No SVE context\n");
+		return 1;
+	}
+
+	ssve = (struct sve_context *)regs;
+	if (ssve->vl != vl) {
+		fprintf(stderr, "Got SSVE VL %d, expected %d\n", ssve->vl, vl);
+		return 1;
+	}
+
+	if (!(ssve->flags & SVE_SIG_FLAG_SM)) {
+		fprintf(stderr, "SVE_SIG_FLAG_SM not set in SVE record\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Got expected SSVE size %u and VL %d\n",
+		regs->size, ssve->vl);
+
+	regs = get_header(head, ZA_MAGIC, GET_BUF_RESV_SIZE(context),
+			  &offset);
+	if (!regs) {
+		fprintf(stderr, "No ZA context\n");
+		return 1;
+	}
+
+	za = (struct za_context *)regs;
+	if (za->vl != vl) {
+		fprintf(stderr, "Got ZA VL %d, expected %d\n", za->vl, vl);
+		return 1;
+	}
+
+	fprintf(stderr, "Got expected ZA size %u and VL %d\n",
+		regs->size, za->vl);
+
+	/* We didn't load any data into ZA so it should be all zeros */
+	if (memcmp(zeros, (char *)za + ZA_SIG_REGS_OFFSET,
+		   ZA_SIG_REGS_SIZE(sve_vq_from_vl(za->vl))) != 0) {
+		fprintf(stderr, "ZA data invalid\n");
+		return 1;
+	}
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
+	.name = "Streaming SVE registers",
+	.descr = "Check that we get the right Streaming SVE registers reported",
+	/*
+	 * We shouldn't require FA64 but things like memset() used in the
+	 * helpers might use unsupported instructions so for now disable
+	 * the test unless we've got the full instruction set.
+	 */
+	.feats_required = FEAT_SME | FEAT_SME_FA64,
+	.timeout = 3,
+	.init = sme_get_vls,
+	.run = sme_regs,
+};

-- 
2.34.1

