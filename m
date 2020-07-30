Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36244233875
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jul 2020 20:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgG3ShM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jul 2020 14:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbgG3ShH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86ED2072A;
        Thu, 30 Jul 2020 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596134226;
        bh=UT+Vo3HFrZsD3uYH4LrsM9/ehPOpm9/+3nfx46Us6CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tdb+LJUYepgJ398frVtT+uOikIQZwPxBbAoR57SyyPqdJKVaDhwDBGxO64JTpz9fl
         44QWL/c6hFzEOC7l2KLdw4xNDlE7oC0jlO6LGDnl3B20S7VtXm8ww1BzsZQXB/cAqA
         B5J1LQMCd8og7JeJnOI3cOllCQtipN1/TUavkre4=
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/6] selftests: arm64: Test case for enumeration of SVE vector lengths
Date:   Thu, 30 Jul 2020 19:09:15 +0100
Message-Id: <20200730180920.23527-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200730180920.23527-1-broonie@kernel.org>
References: <20200730180920.23527-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test case that verifies that we can enumerate the SVE vector lengths
on systems where we detect SVE, and that those SVE vector lengths are
valid. This program was written by Dave Martin and adapted to kselftest by
me.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../selftests/arm64/fp/sve-probe-vls.c        | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/sve-probe-vls.c

diff --git a/tools/testing/selftests/arm64/fp/sve-probe-vls.c b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
new file mode 100644
index 000000000000..b29cbc642c57
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/sve-probe-vls.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 ARM Limited.
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <asm/sigcontext.h>
+
+#include "../../kselftest.h"
+
+int main(int argc, char **argv)
+{
+	unsigned int vq;
+	int vl;
+	static unsigned int vqs[SVE_VQ_MAX];
+	unsigned int nvqs = 0;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
+		ksft_exit_skip("SVE not available");
+
+	/*
+	 * Enumerate up to SVE_VQ_MAX vector lengths
+	 */
+	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+		vl = prctl(PR_SVE_SET_VL, vq * 16);
+		if (vl == -1)
+			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
+					   strerror(errno), errno);
+
+		vl &= PR_SVE_VL_LEN_MASK;
+
+		if (!sve_vl_valid(vl))
+			ksft_exit_fail_msg("VL %d invalid\n", vl);
+		vq = sve_vq_from_vl(vl);
+
+		if (!(nvqs < SVE_VQ_MAX))
+			ksft_exit_fail_msg("Too many VLs %u >= SVE_VQ_MAX\n",
+					   nvqs);
+		vqs[nvqs++] = vq;
+	}
+	ksft_test_result_pass("Enumerated %d vector lengths\n", nvqs);
+	ksft_test_result_pass("All vector lengths valid\n");
+
+	/* Print out the vector lengths in ascending order: */
+	while (nvqs--)
+		ksft_print_msg("%u\n", 16 * vqs[nvqs]);
+
+	ksft_exit_pass();
+}
-- 
2.20.1

