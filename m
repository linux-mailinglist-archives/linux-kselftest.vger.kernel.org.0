Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED01E43BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfFMPaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:30:35 -0400
Received: from foss.arm.com ([217.140.110.172]:38104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbfFMLO1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 07:14:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B35367;
        Thu, 13 Jun 2019 04:14:27 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68083F694;
        Thu, 13 Jun 2019 04:16:09 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com, andreyknvl@google.com
Subject: [PATCH 04/13] kselftest: arm64: mangle_pc_invalid
Date:   Thu, 13 Jun 2019 12:13:26 +0100
Message-Id: <20190613111335.7645-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190613111335.7645-1-cristian.marussi@arm.com>
References: <20190613111335.7645-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Added a simple mangle testcase which messes with the ucontext_t
from within the sig_handler, trying to badly modify the PC to point
toward Kernel land.
Expects SIGSEGV on test PASS.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 .../arm64/signal/testcases/.gitignore         |  1 +
 .../signal/testcases/mangle_pc_invalid.c      | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c

diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
index 7f7414d241f2..a87fb0f0d2cf 100644
--- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
+++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
@@ -1 +1,2 @@
 mangle_sp_misaligned
+mangle_pc_invalid
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
new file mode 100644
index 000000000000..0024032528bc
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pc_invalid.c
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 ARM Limited */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static int mangle_invalid_pc_run(struct tdescr *td, siginfo_t *si,
+				 ucontext_t *uc)
+{
+	ASSERT_GOOD_CONTEXT(uc);
+
+	uc->uc_mcontext.pc = 0xffffffffcccccccc;
+
+	return 1;
+}
+
+struct tdescr tde = {
+		.sanity_disabled = true,
+		.name = "MANGLE_PC_INVALID",
+		.descr = "Mangling uc_mcontext with INVALID PC",
+		.sig_trig = SIGUSR1,
+		.sig_ok = SIGSEGV,
+		.run = mangle_invalid_pc_run,
+};
-- 
2.17.1

