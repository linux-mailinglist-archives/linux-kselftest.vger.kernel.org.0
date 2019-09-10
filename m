Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B602FAEA65
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfIJMbn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:31:43 -0400
Received: from foss.arm.com ([217.140.110.172]:34384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfIJMbn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:31:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82FF815BE;
        Tue, 10 Sep 2019 05:31:42 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B3283F59C;
        Tue, 10 Sep 2019 05:31:41 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     andreyknvl@google.com, dave.martin@arm.com, amit.kachhap@arm.com
Subject: [PATCH v6 04/11] kselftest: arm64: mangle_pstate_invalid_mode_el[123][ht]
Date:   Tue, 10 Sep 2019 13:31:04 +0100
Message-Id: <20190910123111.33478-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910123111.33478-1-cristian.marussi@arm.com>
References: <20190910123111.33478-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add 6 simple mangle testcases that mess with the ucontext_t from within
the signal handler, trying to toggle PSTATE mode bits to trick the system
into switching to EL1/EL2/EL3 using both SP_EL0(t) and SP_ELx(h).
Expects SIGSEGV on test PASS.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v3 --> v4
- fixed commit message
- macroization
- splitted into 6 macro-ised testcases to address t/h SP selection modes
- added test description
---
 .../mangle_pstate_invalid_mode_el1h.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_el1t.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_el2h.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_el2t.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_el3h.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_el3t.c         | 15 ++++++++++
 .../mangle_pstate_invalid_mode_template.h     | 28 +++++++++++++++++++
 7 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h

diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
new file mode 100644
index 000000000000..95f821abdf46
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1h.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1h);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
new file mode 100644
index 000000000000..cc222d8a618a
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1t.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1t);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
new file mode 100644
index 000000000000..2188add7d28c
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2h.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(2h);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
new file mode 100644
index 000000000000..df32dd5a479c
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2t.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(2t);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
new file mode 100644
index 000000000000..9e6829b7e5db
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3h.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(3h);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
new file mode 100644
index 000000000000..5685a4f10d06
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3t.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Try to mangle the ucontext from inside a signal handler, toggling
+ * the mode bit to escalate exception level: this attempt must be spotted
+ * by Kernel and the test case is expected to be termninated via SEGV.
+ */
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+#include "mangle_pstate_invalid_mode_template.h"
+
+DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(3t);
diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h
new file mode 100644
index 000000000000..f5bf1804d858
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_template.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 ARM Limited
+ *
+ * Utility macro to ease definition of testcases toggling mode EL
+ */
+
+#define DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(_mode)		\
+									\
+static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,	\
+				     ucontext_t *uc)			\
+{									\
+	ASSERT_GOOD_CONTEXT(uc);					\
+									\
+	uc->uc_mcontext.pstate &= ~PSR_MODE_MASK;			\
+	uc->uc_mcontext.pstate |= PSR_MODE_EL ## _mode;			\
+									\
+	return 1;							\
+}									\
+									\
+struct tdescr tde = {							\
+		.sanity_disabled = true,				\
+		.name = "MANGLE_PSTATE_INVALID_MODE_EL"#_mode,		\
+		.descr = "Mangling uc_mcontext INVALID MODE EL"#_mode,	\
+		.sig_trig = SIGUSR1,					\
+		.sig_ok = SIGSEGV,					\
+		.run = mangle_invalid_pstate_run,			\
+}
-- 
2.17.1

