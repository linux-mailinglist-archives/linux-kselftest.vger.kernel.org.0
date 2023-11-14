Return-Path: <linux-kselftest+bounces-99-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2107EB24C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6861E281290
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC341236;
	Tue, 14 Nov 2023 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhClDHVg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40CF4121A;
	Tue, 14 Nov 2023 14:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67B4C433BB;
	Tue, 14 Nov 2023 14:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972583;
	bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FhClDHVgXQ/fUVGGo+9j2VibBnmAldzFuTcCJZ886zPUWd4NIHoFe72o+MSYU+RZ7
	 FDL8CV47LqKn7c/E8psg7spZeGkAka28Fj/P02/BH6zziAk4ILXBgYlJUHAxEtZRwG
	 jM2IwfPrLcUbv4nDb4E7pgw+Rcuf5HttsEYoK7TzdogX5Uldm0w0+0Ht1Kx06b8/43
	 OzbfENcf3G/f+CPGIXZ6ZPCGK+8lN85z3vc9kGZy0XKjeO+NgM2TlK12/HR6jol7Rx
	 KZf6ob+3YQBUFbxruPlEp5n58jfq8dAlLlXpvwMHnxMw2kzQVhrS6XCt1QS5s4D9tu
	 XvT0gUR14Zobg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:35:03 +0000
Subject: [PATCH v2 18/21] kselftest/arm64: Add basic FPMR test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-18-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=broonie@kernel.org;
 h=from:subject:message-id; bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WiPCcK6g4XDzQH51CyEevmUoVhDX+62HmCkTct
 0KWEm/uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFogAKCRAk1otyXVSH0F2FB/
 0cINuYxh6O1Ud5ocIKz/tH4Kx1xJwIDq45elc+inBWQXF3MQXvo9AuL8Y8wSllDzU034b0PRWp6Q9K
 160Wk+yFlP+0QdY07e+iljh0M5eOqMMnlzxK9bIJdtpBGM/Cp3i0ElxXvTOP62YIGL32zhlXeemoWB
 4LbITXGpVsQ6KFwFwIpr9+bwoL01Sckmko65LpsNZQHrlnCmsVwt1YHNDKd2jBDi8tgHUtmdRbpAL7
 fOesE2IzJT6CwdwPVkeaq37hX3YI3U0EMZG85C+RY15p1hmt1fLdI5kXQfbWhHI7YM3cd8b92gnwQe
 Q0w/J8+lHLsUuO8KFUbqz7Em9dBuZ2
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


