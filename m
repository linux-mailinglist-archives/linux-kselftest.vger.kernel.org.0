Return-Path: <linux-kselftest+bounces-6028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA238743B9
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B41C21A92
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4024B5CD;
	Wed,  6 Mar 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEFnM4yy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE045034;
	Wed,  6 Mar 2024 23:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766949; cv=none; b=PXd97kMEBM6DqXIkihAV/nbc2yo2vJLUQVaLNZEo0l1HaxatF0cKlFwAKzNS+4tTGKwM7amilmaTuP6wL5qMQrVuqDD5hn4xAbzpC1C30BPsUw+6D6DkSkVg+ITzUyGxPAUF4nMQNTwyJWtTObeg/rox39W3C1GmWStwscXieiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766949; c=relaxed/simple;
	bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=feZum4VUczszyyjUkzWxzmP1GrZq9cqCP1MFA93HI+mGvFEGrKEJjbQ3MA4C7x7hkWstwHz5fBGU58uJnFGJCmYih/UPKbyvVP+0Eeh0jwV0p369/JojUu9oCE7ORJytTBujYk9TYUZW57XOTSTvOyD148dNFFtNVjhm4loRgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEFnM4yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D024C43390;
	Wed,  6 Mar 2024 23:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766949;
	bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DEFnM4yyX403dUV9Xdb3LCMKSBZLSrxxAcYGALx30yBtvHACHFQAeF46UKiRQoPhb
	 huJuj9wVUx0XpF0O3k9R4YNjUS5hAiBoornqle/UlOkPeguzezwj1A11P7iBwKN1I9
	 PwHNVwhCLByRWCQSqvhKIsLmSZBkTVqGmYlYlB/FqoTbcBEr+1h2yrr33PfpdxeLE8
	 t0CHU61A8kIJUqCjN+amVOezG/Wrh1460xm9T4p2oiR9ULHsfrVYDTzbQZNbTthbzW
	 3dpfeM2Z9XiTqlpet4NElpHRC42TFaYuwv737TFtykziPBvkNf+X4K3oZXVrgohs6v
	 3GR3zqinWbMMw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 06 Mar 2024 23:14:53 +0000
Subject: [PATCH v5 8/9] kselftest/arm64: Add basic FPMR test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-arm64-2023-dpisa-v5-8-c568edc8ed7f@kernel.org>
References: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
In-Reply-To: <20240306-arm64-2023-dpisa-v5-0-c568edc8ed7f@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=broonie@kernel.org;
 h=from:subject:message-id; bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl6PkHmnnR5KC9C41tqWZ+5jXpOC6SjHeOnUO4GP3B
 fEOEXbCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZej5BwAKCRAk1otyXVSH0M/cB/
 9YLCqxCy3bnthKeQZN+pk+ZHS5AOSjOUCHN2FvWdjVk4v2a2T6I4DIMvb51ENOwVzShJJuwD0ngoRX
 C/tzgaTu4cFXx7r39nAGgvfgEY14DMDdXpL62gDcb8WzWv/oSTFQaG/CdtGKUj3G3i5sv99VboU9+Z
 qXvPC3HL8INXDyweAs3QO5iu+5Tf3tg0ZPr8GanS3mkaMmVb8FZdlR7q9OAdi5Vl/HG0XQ5u4NxF9K
 S6ypDms0buuD6I2nYXtbGUx9lTDhIzbvra+yqSJXtC+bkosU9EgdtIHEV5G0cffztMOJ+WcMYOysZE
 nd57F5U9/M3a2D9vFxGQk6l94HHX7T
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Verify that a FPMR frame is generated on systems that support FPMR and not
generated otherwise.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 839e3a252629..1ce5b5eac386 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mangle_*
 fake_sigreturn_*
+fpmr_*
 sme_*
 ssve_*
 sve_*
diff --git a/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
new file mode 100644
index 000000000000..e9d24685e741
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ *
+ * Verify that the FPMR register context in signal frames is set up as
+ * expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <asm/sigcontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+#define SYS_FPMR "S3_3_C4_C4_2"
+
+static uint64_t get_fpmr(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_FPMR "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
+int fpmr_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct fpmr_context *fpmr_ctx;
+	size_t offset;
+	bool in_sigframe;
+	bool have_fpmr;
+	__u64 orig_fpmr;
+
+	have_fpmr = getauxval(AT_HWCAP2) & HWCAP2_FPMR;
+	if (have_fpmr)
+		orig_fpmr = get_fpmr();
+
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	fpmr_ctx = (struct fpmr_context *)
+		get_header(head, FPMR_MAGIC, td->live_sz, &offset);
+
+	in_sigframe = fpmr_ctx != NULL;
+
+	fprintf(stderr, "FPMR sigframe %s on system %s FPMR\n",
+		in_sigframe ? "present" : "absent",
+		have_fpmr ? "with" : "without");
+
+	td->pass = (in_sigframe == have_fpmr);
+
+	if (have_fpmr && fpmr_ctx) {
+		if (fpmr_ctx->fpmr != orig_fpmr) {
+			fprintf(stderr, "FPMR in frame is %llx, was %llx\n",
+				fpmr_ctx->fpmr, orig_fpmr);
+			td->pass = false;
+		}
+	}
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "FPMR",
+	.descr = "Validate that FPMR is present as expected",
+	.timeout = 3,
+	.run = fpmr_present,
+};

-- 
2.30.2


