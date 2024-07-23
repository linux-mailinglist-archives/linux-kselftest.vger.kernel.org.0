Return-Path: <linux-kselftest+bounces-14078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565B939EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D95A1C21874
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907314E2C0;
	Tue, 23 Jul 2024 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiT79zMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348B14C5A4;
	Tue, 23 Jul 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730538; cv=none; b=a0jgGFsWJTExklou4vEqwiwaCsTMgysDXPYqvWfHAgIdt9BLcRO5BGjzzKdXi0ZMtHk8lsbGDtY8Qd7oILgR0+H5f8RGlujjJ9aqgHKBKpCP8HzyFkAcn+bH3fbG54+unZ+mZ4TZ7fhzrf7d62GEQiQkmPSMzC0CJyrt18BImds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730538; c=relaxed/simple;
	bh=NMKTzAxYtED7lsK+4pQXB99GoVnYcbnAPWwlvySACH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iX+/i0HCyre7yR2TPQ0X/msUUKUYaQuztH3y4cd+mXOn+GZ6t5UROs7wOB1R/wi5SvJ6A9bwL5f/SXAy8lzX7zjjA0r1Fg/1j/2Bd//IRDTv8BrDMSJTcikytlMTFXdKCgN/ocKbUfopDScTgUzCOsoZG3eW/ZPGJPDepP1wHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiT79zMI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66108213e88so53080687b3.1;
        Tue, 23 Jul 2024 03:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721730536; x=1722335336; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1A9IFWbYCk8Y3UmFUkrvkC/KXCME07HqnuVMqN+IZFQ=;
        b=BiT79zMIJdfmUfQ2zbxNGgX8tk2enpYvvDIS6ZHj/GcedN4Y5Q2EpNDBCLeZdk8vOt
         zFOySNlzOlBQWpgmZ+cuedKMl6y+6oGIzl7MWOjjfdznG/siyDfzOdupm+p1efbgG75t
         IV2hJH6clR1soUPd1de/XJvi2LErLnMdJlghBHYFf5yF5D3E0eKfYkgy/Px7Zgbky0dF
         3kJMsQoJZHrGLdm0SBplsLRIpDxoz2sOZL0jJYUGPcV5GDoiLu+DZnkDOjFCGirGhGAH
         sQbYfRNpnNIyzMxwT9bv/85+QS367612P+GGUgS/vpweMddzdoE3NpS+1UlRmfAlUV/v
         knXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721730536; x=1722335336;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A9IFWbYCk8Y3UmFUkrvkC/KXCME07HqnuVMqN+IZFQ=;
        b=EsgIaqjnKs1UURtkAx9DLGBSDOF8SHLLZJRqsBgMQgDNnTFvNiD8oxiGZr9A9bSV0H
         UDODtb248/l6I04xjXom3MUDKF7GSs9o/c3sjET3i6ugrTlf0xHCGtz/40tUz33ohR3O
         frCpuNMynggI1IAEC4BjvZw9UdD0NRTGDhOcmwywQ+FQr/MomNS493jQn61EMw3bMb/p
         yjE86w9CHTd9Grcv7sSYEtUH/OARktmlHFOeZco9VMHnajzOtSgfnB8zBjj6F39zmgkS
         ymAzfBMyKpdjdghK9hAFTSWrm/go3RiVXkeWrI3jH4fagMVdb+BewKh1G6F72XLg2RUR
         bU6A==
X-Forwarded-Encrypted: i=1; AJvYcCVJDwrLF/zb6BTnIWzvUKPfc8HXJwIYhaNogomrNvLKqlIzHSIiS7qS/mmjARdLfge5QNZFlDIhk9gfgZedCU2PNvh4M67SEtbN1ELQjaABclsqe1RBCH0r945JV8IvVABDyfzlcMogKc3C3i6H
X-Gm-Message-State: AOJu0YxmDi13Ga0+V7qBZJXQXG4LKLdmA7zeez6LZ4Guy0G2v1k+Dxu1
	DudaTQM78U53vCjo/T5ukxlNXNOspH3Og6EggzGt6wPdSvYjAWFm8Yul8YPv
X-Google-Smtp-Source: AGHT+IGEOsaXBKy9PASLfOHFdNFWCjaIIDmZYq1VkEvZMDWvqI1THwT6GaIWbH/anRHo2wVGB27baQ==
X-Received: by 2002:a05:690c:3301:b0:64b:2a73:f050 with SMTP id 00721157ae682-66ad8ec4979mr99195527b3.23.1721730535902;
        Tue, 23 Jul 2024 03:28:55 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:b8b3:54ee:8692:b1f9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b968f85975sm28039526d6.16.2024.07.23.03.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 03:28:55 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Tue, 23 Jul 2024 06:28:43 -0400
Subject: [PATCH v3] selftest: acct: Add selftest for the acct() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-kselftest-acct-syscall-v3-1-16f332498a9e@gmail.com>
X-B4-Tracking: v=1; b=H4sIANqFn2YC/4XNTQ7CIBCG4as0rMXAoFRdeQ/jgp9pS6StAUJsm
 t5d2lU3xuX7JfPMTCIGh5HcqpkEzC66cSghDhUxnRpapM6WJsDgxCQAfUX0TcKYqDIm0ThFo7y
 nYK+sqaWUmiMpx++Ajfts8ONZunMxjWHa/mS+rn/JzCmnFmqmzxovVtT3tlfOH83Yk5XMsGME+
 8lAYbRgWiMoeTV2zyzL8gWM4CG3AwEAAA==
To: Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721730534; l=4199;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=NMKTzAxYtED7lsK+4pQXB99GoVnYcbnAPWwlvySACH8=;
 b=LDbIC61Q5DV3J1RHCyS+FbVpW5yvC5tza0NByoRSt0U3R5nD50mxGklEY5C9A6cD/gsNjBXbU
 c4VYrPWZP/iAfsWSIHVUJvapAJjnYxx5o86DqvYGtegR7GAjuD4UWdF
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

The acct() system call enables or disables process accounting.
If accounting is turned on, records for each terminating process
are appended to a specified filename as it terminates. An argument of NULL
causes accounting to be turned off.

This patch will add a test for the acct() syscall.

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
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
 tools/testing/selftests/acct/Makefile       |  4 ++
 tools/testing/selftests/acct/acct_syscall.c | 78 +++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

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
index 000000000000..ff3e238c5634
--- /dev/null
+++ b/tools/testing/selftests/acct/Makefile
@@ -0,0 +1,4 @@
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


