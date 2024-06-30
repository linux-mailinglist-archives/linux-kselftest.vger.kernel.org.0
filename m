Return-Path: <linux-kselftest+bounces-12973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE16491D366
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 21:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737CE280F6F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jun 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B69140378;
	Sun, 30 Jun 2024 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxVxAQWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E122094;
	Sun, 30 Jun 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719775393; cv=none; b=qpvZXWl8A5Dq0EWA86sgpZ+5CKSK6vCpieEM7AQkvebR9IQlaXFwgF7ryr40Vu3ViSJ1bHe9rc341f22YZYOi6QRC0gHHf9MGjQnibmZwkIZNuXCH2450ym+56D1yi7++ZlEQjglk66vI1MtvAap5m3CVG5LMlYFcFbX0olauNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719775393; c=relaxed/simple;
	bh=y2ItLlNZ0XcESy7AmAvwA2YN1RcdeP7Qg19scDw7VjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MQmFvi4eRxj/Sjn7T+xgqmhrEwsNzlrK6NF50LUb6vo2Iha8ctqIJzqLAY4E158of/QftQfqMcJsNe3w2H14eMOqyM/7xkLSI9lx7p7tzmiSMdOh9hd9lEv1lPiQNm9h/+Z9zBvUJL9vIy4eDfwWxg0s7pkeP7g7HvhOYDOuCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxVxAQWW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79d5d1a54fcso210765985a.1;
        Sun, 30 Jun 2024 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719775390; x=1720380190; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JoKTcGoL8QUQQFT/fSGl00mqRLXmkP7pkW9VMQKO/d8=;
        b=OxVxAQWWaWxktrt3GfENPVAbv9y98LwcHpQoWscnRmAbj9eDeiSKzJHDKZOtlGdQxu
         fgozmDRGPveVREQwI3Io9FV9W2XZ6xUCOAvuU/6deX4+Ex8eFu8/S6rVz8q4FcG996Dg
         WZh4l0XdsQvOFZIHuK/xDlsJMoOK5et3PukOF4EJVz9kz0q0vJQneImEnGwpeXqUcA3B
         jYSgb42OSSV3hC5O1LZH3Zs8UcH8xmzbSX9QtPzpQEeEJtDFhDzF12G3xd/VDYVkjw5w
         fl9ZBs2KGSeuqWhah8G9yLszYiSvdt6vL2BGGVnfN7MXK4RmYrafNfRgfkUoDd2wxIZh
         cvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719775390; x=1720380190;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoKTcGoL8QUQQFT/fSGl00mqRLXmkP7pkW9VMQKO/d8=;
        b=lRx458QTDDC/+VhjZG3+eECKfwt2WOzGa3MuceyiTErGx6abnID0s/MrPmo4Augtje
         IfBCqCRkmIfnEbAm1/ZZzF1RD/sxGe8GuMz0pq2Lz0/c//3iWRVO5ajPovD5/Aoeh7Bq
         sL1yf8Prqgv7Wkp1b+ypwrOG/TrrGlEglTvJ1bXbrfLvJgMcYg2K5Sr8sxoi5AzSaA6L
         M/rs5Bxe9kUdSvf4/bTcV4gjqpcOxoV/rwytxYTIOm1sRdpMo2jeuXZ9P2sVEHzMawxJ
         4dIixiTrwQmWvA8fjdJDHGTzq1xb/WSBk4Q05Mz6Y2vwramsu4xIwyQDv81k/jxvtZxY
         UWmA==
X-Forwarded-Encrypted: i=1; AJvYcCUztrojn0NVwmveROKmEdJxxLAvurTfYY+YR30G3bzv9opJIvtLhtcswmxYFeq98vDPUds28kQKzsq6xjEspFJBH3hs4K8HbQZQOLVyRyzrzCXqA9UucPfSPZryRzvU/03WmJlnHVLgJAWfA9ak
X-Gm-Message-State: AOJu0Yye4qopSr6swLN03EsdNqerhD3bJWjx0ZwD/NUpDEYkLWAKDBOc
	I5cusKD9zJcCQL2DJmPV9pTaA1YSL6c7YHrB5YL7vUK3TDahz/4OJftGGg==
X-Google-Smtp-Source: AGHT+IFX/fyTwBgcfWmh9v9S3vFkXPMB2+qkXFPsD4ebezd1LT3aY8Rg4LcOnWJwgI6F866DvlUJqA==
X-Received: by 2002:a05:620a:44d4:b0:79c:c3d:9c22 with SMTP id af79cd13be357-79d7b720e0amr725166585a.8.1719775390121;
        Sun, 30 Jun 2024 12:23:10 -0700 (PDT)
Received: from [127.0.1.1] ([2607:fea8:bad7:5400:fba0:e92d:3751:1f60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5bfcce25esm6054086d6.78.2024.06.30.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 12:23:09 -0700 (PDT)
From: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
Date: Sun, 30 Jun 2024 15:22:58 -0400
Subject: [PATCH v2] selftest: acct: Add selftest for the acct() syscall
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-kselftest-acct-syscall-v2-1-b30bbe2a69cd@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJGwgWYC/4WNQQ6CMBBFr0K6dkxbtagr72FYlHaAiYWaTkMkh
 LtbuYDL95L//ioYEyGLe7WKhDMxxamAPlTCDXbqEcgXFlrqszRaw4sxdBk5g3UuAy/sbAig/U1
 2tTGmVSjK+J2wo88efjaFB+Ic07L/zOpn/yZnBQq8rmV7afHqT/WjHy2Fo4ujaLZt+wJ88PLxv
 AAAAA==
To: Shuah Khan <shuah@kernel.org>
Cc: javiercarrascocruz@gmail.com, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
X-Mailer: b4 0.14-dev-0bd45
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719775389; l=4321;
 i=abdulrasaqolawani@gmail.com; s=20240613; h=from:subject:message-id;
 bh=y2ItLlNZ0XcESy7AmAvwA2YN1RcdeP7Qg19scDw7VjI=;
 b=OSDhMmTzgNFa/mfsXtTo+ocpkTgfWnwk0HgKbjLUnuVzjjuQvpHd33dS6CKTlUlrw4oUfz2Bs
 B/Av/2FGkKaAS/GujrqQgP0GYUT7OOdggzZKc7+y9s57wlzyWs1zMk7
X-Developer-Key: i=abdulrasaqolawani@gmail.com; a=ed25519;
 pk=cUqfinPW5pkopFB8ShBc0ZTNgYvSW5ZTa8aLIFPGp/w=

Noticed that there was no selftest for the acct() syscall
which enables the kernel to record terminated processes
into a specified file.

The acct() system call enables or disables process accounting.
If accounting is turned on, records for each terminating process
are appended to a specified filename as it terminates. An argument of NULL
causes accounting to be turned off.

This patch provides a test for the acct() syscall.

References:
https://man7.org/linux/man-pages/man2/acct.2.html

Signed-off-by: Abdulrasaq Lawani <abdulrasaqolawani@gmail.com>
---
Changes in v2:
Add testcases to test error conditions.
Add kselftest function for reporting results.

- Link to v1: https://lore.kernel.org/r/20240622-kselftest-acct-syscall-v1-1-d270b5be8d37@gmail.com
---
 tools/testing/selftests/Makefile            |  1 +
 tools/testing/selftests/acct/.gitignore     |  2 +
 tools/testing/selftests/acct/Makefile       |  4 ++
 tools/testing/selftests/acct/acct_syscall.c | 89 +++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

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
index 000000000000..8ab358d81bd2
--- /dev/null
+++ b/tools/testing/selftests/acct/.gitignore
@@ -0,0 +1,2 @@
+acct_syscall
+config
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
index 000000000000..4fa00a88a1bd
--- /dev/null
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -0,0 +1,89 @@
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
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Create file to log closed processes
+	char filename[] = "process_log";
+	FILE *fp;
+
+	fp = fopen(filename, "w");
+
+	int i = acct(filename);
+
+	// Handle error conditions
+	if (i) {
+		switch (errno) {
+		case EPERM:
+			ksft_test_result_error("%s. Please run the test as root.\n",
+				strerror(errno));
+			break;
+
+		case EACCES:
+			ksft_test_result_error("Insufficient privilege.\n");
+			break;
+
+		case EIO:
+			ksft_test_result_error("Error writing to the file: %s.\n", filename);
+			break;
+
+		default:
+			ksft_test_result_error("%s.\n", strerror(errno));
+			break;
+		}
+
+		remove(filename);
+		fclose(fp);
+		ksft_finished();
+		return 1;
+	}
+
+	// Create child process and wait for it to terminate.
+	pid_t child_pid;
+
+	child_pid = fork();
+
+	if (child_pid < 0) {
+		ksft_test_result_error("Process failed\n");
+		ksft_finished();
+		return 1;
+	} else if (child_pid == 0) {
+		ksft_print_msg("Child process successfully created!\n");
+	} else {
+		wait(NULL);
+		fseek(fp, 0L, SEEK_END);
+		int sz = ftell(fp);
+
+		ksft_print_msg("Parent process successfully created!\n");
+
+		i = acct(NULL);
+
+		if (sz <= 0) {
+			ksft_test_result_fail("Terminated child process not logged");
+			ksft_exit_fail();
+			return 1;
+		}
+
+		ksft_test_result_pass("Successfully logged terminated process.\n");
+		remove(filename);
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


