Return-Path: <linux-kselftest+bounces-14612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF238944865
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523FC1F26C22
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1478F170A28;
	Thu,  1 Aug 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SScFg9g8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52232170A19;
	Thu,  1 Aug 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504648; cv=none; b=VGFjiGv8QB2trblsvbr4CXipypqMzm8I12T5/3IR/Gu65WZ2tave4tNbR8lm6R8WkvXIsjsb9uvHxmMsgd9YBIAeIfer/Vm7+37AcYF+JkFnApEOrjwk8P8+dCw5hbkCvG/LjYsdXalknPDaty1YWaklv66khKjiQV5K3ibg8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504648; c=relaxed/simple;
	bh=PX65zImO8CLqNSApoaeZjS06rnXUzZD1nETT3UKtGPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XgwReXmSFtiTfKRm3YQ+3ZMwefRCTHwDjjjWEXT/UFpD6d7o0MsIx8U4o1BycmY63RwV0Lb22JFPAQzS8i5WI552ye5W9L6UtWpecjtEGzZPkT9sHVd7aD9n6/H0J6MgTvga3MOPKpuWqDOdB1MbCl0V3plc59ujpIiKpaFsDdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SScFg9g8; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1dd2004e1so422139985a.3;
        Thu, 01 Aug 2024 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722504645; x=1723109445; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCc7UbyUb1V+brVeE0JjFcUR4GaQ3xLrgZXR+G5rkko=;
        b=SScFg9g8yWk6idYE/MNeaHVBwuTrn9aMo7+2P/0L1VZrBifUgn78qNQl7M5+TktZdf
         BpBl72elJwXchZ/BTNPGNqIQXudlc/8A63RusS+HZNI746xmrCjnK3GIeeG+a/YAEC5z
         kI+ei5tucJzVZLbzHiDfCMw96+5qmM7mp+hLgKpED8P8nqf28nEOOe9micVJQ1H08CvR
         aVqJr+R0fLIG0e5hTZEd1d4adhx7sOOCLlw8NXrgxrKdmdHaYsktLI0AnU+8Wy5QCq93
         5pGxJyAfZ0MSKR9QJZg0KGgPJqW3+AbrBXe2SZgPW6KrtfSSd1lFvyPqrx4IUnTZc9zm
         gtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504645; x=1723109445;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCc7UbyUb1V+brVeE0JjFcUR4GaQ3xLrgZXR+G5rkko=;
        b=KhoUMwfI8h9gcBJCeCDQKTO8oGjrIEZJPOO7EYsWqPugyHj8Mq3sOR/mPkE8fyYLxl
         haODYjdZNLGjkZFNNxNuONxqg4qK5XpE3909/+EsC0QK3u1HBz4ubMaXUUMnnweqx5SO
         v6Md0CihaTLdXWbgg/m8omosC+N8fVQlEJcE2uSVxf/c6Gmsl6zGRlDfLPhPSRwd99WL
         3tFPKnyxjirsTX32Y9e89Rk95R2xr74uXJ52LL8lcNopitR8qLaPZ5dv9zmOKEZI8Pbc
         ZaoKBNs5RbJE3FI5hMUWhmvpJuRGqHx6ernrb/TciemJSnzK7XrVNquNqhMVqQhH0hFb
         bcxw==
X-Forwarded-Encrypted: i=1; AJvYcCXh72jUpgTIXRdiI7LE4NT4B16BA2QEOqJwUXeGIFI7PSIp/GkvLVOrlEUvUtyp9SzW22q1utpexPepW+XGuVZgbbfF6K++7MFhYdQg0s9Vf7foBsQ0ml6RKKarXvjMeXTufn1SVz1kMcQqep9U
X-Gm-Message-State: AOJu0YyC5t2FshQFE2J8DyDKrr6IOdy6DrbibGLpyCgUTWocKNpgI4lX
	hIy+jYT0IKJ3zcIRTh4jz8FfLJ57EvtOUhQ7Ixq1wS7+7X54qAiL
X-Google-Smtp-Source: AGHT+IEH3meYUgNnRxhmPnTAl4v3zUyK5B2f2N2co6m9kDAaIiOz7o9ck6UpGcCRvNcxd1fhTA4mFw==
X-Received: by 2002:a05:620a:1a8f:b0:79e:f78e:c554 with SMTP id af79cd13be357-7a30c637452mr224793885a.3.1722504645116;
        Thu, 01 Aug 2024 02:30:45 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:599f:c23b:9cb3:8075])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73efffdsm833285985a.69.2024.08.01.02.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 02:30:44 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Thu, 01 Aug 2024 05:29:52 -0400
Subject: [PATCH v4] selftest: acct: Add selftest for the acct() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-kselftest-acct-syscall-v4-1-3e072d9b3691@gmail.com>
X-B4-Tracking: v=1; b=H4sIAI9Vq2YC/4XNywqDMBCF4VeRrJuSTGzUrvoepYtcRg31UhKRi
 vjujW4qBenyPzDfzCSgdxjINZmJx9EF13cx0lNCTK26CqmzsQkwSJkEoM+ATTlgGKgyZqBhCkY
 1DQVbsDKTUmqOJB6/PJbuvcH3R+zahaH30/Zn5Ov6lxw55dRCxvRFY25Fdqta5Zqz6VuykiPsG
 MEOGYiMFkxrBCULY38Z8WUyEIeMiAyXpRCQFrkqcM8sy/IBmG5qUkoBAAA=
To: Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722504643; l=4403;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=PX65zImO8CLqNSApoaeZjS06rnXUzZD1nETT3UKtGPk=;
 b=gxomvQY6BicD7nz/7cXdjKY1yo1Qp5I2511iFqLAnFHCGoXeR+/ORq2YZwLHJUn3XGa/tjmzU
 12UwiijcJtMAlcVb+ySdReZzPDM9WAF9QrV3kxRS+mmN7vtPPHMZ3Ra
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

The acct() system call enables or disables process accounting.
If accounting is turned on, records for each terminating process
are appended to a specified filename as it terminates. An argument of NULL
causes accounting to be turned off.

This patch will add a test for the acct() syscall.

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Changes in v4:
- Add SPDX License identifier to test Makefile
- Link to v3: https://lore.kernel.org/r/20240723-kselftest-acct-syscall-v3-1-16f332498a9e@gmail.com

Changes in v3:
- Add geteuid to check if test is ran as root.
- Simplify error conditions for acct function.
- Remove unecessary messages.
- Add more informative messages. 
- Update commit message.
- Add error test case for file creation failure.
- Link to v2: https://lore.kernel.org/r/20240630-kselftest-acct-syscall-v2-1-b30bbe2a69cd@gmail.com

Changes in v2:
Add testcases to test error conditions.
Add kselftest function for reporting results.

- Link to v1: https://lore.kernel.org/r/20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com
---
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/acct/.gitignore     |  3 ++
 tools/testing/selftests/acct/Makefile       |  5 ++
 tools/testing/selftests/acct/acct_syscall.c | 78 +++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..45a58ef5ad92 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+TARGETS += acct
 TARGETS += alsa
 TARGETS += amd-pstate
 TARGETS += arm64
diff --git a/tools/testing/selftests/acct/.gitignore b/tools/testing/selftests/acct/.gitignore
new file mode 100644
index 000000000000..7e78aac19038
--- /dev/null
+++ b/tools/testing/selftests/acct/.gitignore
@@ -0,0 +1,3 @@
+acct_syscall
+config
+process_log
\ No newline at end of file
diff --git a/tools/testing/selftests/acct/Makefile b/tools/testing/selftests/acct/Makefile
new file mode 100644
index 000000000000..7e025099cf65
--- /dev/null
+++ b/tools/testing/selftests/acct/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := acct_syscall
+CFLAGS += -Wall
+
+include ../lib.mk
\ No newline at end of file
diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
new file mode 100644
index 000000000000..e44e8fe1f4a3
--- /dev/null
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* kselftest for acct() system call
+ *  The acct() system call enables or disables process accounting.
+ */
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+int main(void)
+{
+	char filename[] = "process_log";
+	FILE *fp;
+	pid_t child_pid;
+	int sz;
+
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Check if test is run a root
+	if (geteuid()) {
+		ksft_test_result_skip("This test needs root to run!\n");
+		return 1;
+	}
+
+	// Create file to log closed processes
+	fp = fopen(filename, "w");
+
+	if (!fp) {
+		ksft_test_result_error("%s.\n", strerror(errno));
+		ksft_finished();
+		return 1;
+	}
+
+	acct(filename);
+
+	// Handle error conditions
+	if (errno) {
+		ksft_test_result_error("%s.\n", strerror(errno));
+		fclose(fp);
+		ksft_finished();
+		return 1;
+	}
+
+	// Create child process and wait for it to terminate.
+
+	child_pid = fork();
+
+	if (child_pid < 0) {
+		ksft_test_result_error("Creating a child process to log failed\n");
+		acct(NULL);
+		return 1;
+	} else if (child_pid > 0) {
+		wait(NULL);
+		fseek(fp, 0L, SEEK_END);
+		sz = ftell(fp);
+
+		acct(NULL);
+
+		if (sz <= 0) {
+			ksft_test_result_fail("Terminated child process not logged\n");
+			ksft_exit_fail();
+			return 1;
+		}
+
+		ksft_test_result_pass("Successfully logged terminated process.\n");
+		fclose(fp);
+		ksft_exit_pass();
+		return 0;
+	}
+
+	return 1;
+}

---
base-commit: 50736169ecc8387247fe6a00932852ce7b057083
change-id: 20240622-kselftest-acct-syscall-2d90f7666b1e

Best regards,
-- 
Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>


