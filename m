Return-Path: <linux-kselftest+bounces-20422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984129AB7D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 22:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE6728335E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E71CC8A2;
	Tue, 22 Oct 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kh5yZpeD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556C1CC89F
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629750; cv=none; b=SsPZwrFhJRauYV1eh7xb9jefKCdJVmXtlRHy1+I/3KLcO0PTS7fWlia2PQWYzf3ZaEH/IqEZ+2+JqpRL0GXj1d+WRFZqZEQYfTFb36DzDV7EdRci2mJDvZ41IdHQeJM+JGqlPO9DBnz2Q3sFzkU0UzTmAw0fMs/nyoNp52NQqik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629750; c=relaxed/simple;
	bh=XG+MOKJHUYH+bsE5n8S27LiwynoJVlRM1VUvie2RcmM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gFf3YoNRLbuoMtgMskQQE6NMWue/DZhXmKtP/tLew7XO71V3ISExUs+VnZhVfSIjhVhA4wZdmZ/d7jpAgnNqxWYuOWrHom8e7GAwVx11iDtnmtJZ3ANXBd1YdCS7KdOtbllOuiQqGNDtCRUaA8N6JDsYxmsCGpiktTS+hvRiUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kh5yZpeD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso169980a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729629747; x=1730234547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxxVC+qqad32Pd8Hr1QURxn9FsJHJFpHB47az8M6UiQ=;
        b=kh5yZpeDVpjqspj2rcT+eyZNonp3cW9eVsp3r624Z0KrrMVtrhLXHrkjgIb5k2Bep6
         5TXv9nQH9U2U2gZUYlfoZQ+BoDoXiLK+hvDjVlWkNjRB0bb+P59Nz/YHsc/9aCjejyU8
         4f1TPgoJsfKmrQBZZnW6HD+wfrbTE232B/SnFW/EoUv1Lft5woP/OcTP4l/ryEsdLhc1
         hQCr/7P/sojO6dyUQofiA0VnT0QcuoaufNJeZRChrC03/gsXtqxX3yECB3P068J/opsC
         Eq3l/ki1AEcrQf8gDEuIph9lO5XVs+99CVq6dPLTbZ+VszMJkENEr8yeVfogOoW22T8V
         WR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729629747; x=1730234547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxxVC+qqad32Pd8Hr1QURxn9FsJHJFpHB47az8M6UiQ=;
        b=IOtbwdGyVUjZxQa9MC4zlQTtLir8uwT9ar6sG4E1Vb+8VwpkR/s+/vQSO+KzpSx8l0
         6CLJkiJ2CZdntxHuPZRj659RHMRMjSEmZv7hyMxKy0UxT6if9LER9TYSW5BBPG2v0/p+
         2DdU01b7VUoVudQwHyz5iKSueMBEYHv1Y8AfJchkqaZL0dijwgygCAvN0oGkWifJSOzu
         Cw63b/pQyNWhOlMkHpLfgJ5vHaE3DpmIC4Zw0r5PwkYRQ+/i28McBoF8gWdgfZUfVSLr
         jEzCh2UVPWC4d8jjp8WUL7u2jjUyNq3tW1v7knTeRjRKMIzb8rJJbl3gcL+nL7msjf7D
         ZvQg==
X-Gm-Message-State: AOJu0YzuCuCdV3s4zD308u52pZooHiewiF1LSP83PRCb3jyynve5o0SW
	skIp3AWlR+KHV1VOf8WfRJcvGL1sWCUYejiDRkdaO4fvUe7t6s9d
X-Google-Smtp-Source: AGHT+IH3c2F7OB6/fppLHwPbhM86nd5frK7LPgX/igSHav6Gt0Kt775qm8bcwdSSHAf/gwPdNAFR/w==
X-Received: by 2002:a05:6a20:c79a:b0:1d3:418a:e42 with SMTP id adf61e73a8af0-1d97858e778mr510732637.10.1729629747428;
        Tue, 22 Oct 2024 13:42:27 -0700 (PDT)
Received: from Kuchus.. ([27.7.141.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eab06sm5147171b3a.154.2024.10.22.13.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:42:27 -0700 (PDT)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: selftests@ellerman.id.au
Cc: linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] Add Selftest to test fork() syscall
Date: Wed, 23 Oct 2024 02:12:15 +0530
Message-Id: <20241022204215.61256-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test verifies the correct behavior of the fork() system call,
which creates a child process by duplicating the parent process.

The test checks the following:
- The child PID returned by fork() is present in /proc.
- The child PID is different from the parent PID.
- The memory allocated to a variable in the child process is independent
  of the parent process.

Test logs :

- Run without root
 TAP version 13
 1..1
 ok 1 # SKIP This test needs root to run!

- Run with root
TAP version 13
1..1
 # Inside the parent process.
 # Child PID got from fork() return : 56038
 # Parent PID from getpid(): 56037
 # Inside the child process.
 1..2
 ok 1 Child Pid from /proc and fork() matching
 ok 2 Child Pid != Parent pid
 1..3
 ok 3 After modification in child No effect on the value of 'var' in parent
 # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---

Here is my proposal for a new directory, /syscalls, to add syscall selftests,
as there is currently no dedicated space for these tests. I encountered this
issue while writing the test case for the delete_module syscall and was unsure
where to place it. As a heads-up, the delete_module test is currently under
review, and I would like to add it to this directory.

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/syscalls/.gitignore   |   1 +
 .../syscalls/fork_syscall/.gitignore          |   1 +
 .../selftests/syscalls/fork_syscall/Makefile  |   5 +
 .../syscalls/fork_syscall/fork_syscall.c      | 151 ++++++++++++++++++
 5 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/syscalls/.gitignore
 create mode 100644 tools/testing/selftests/syscalls/fork_syscall/.gitignore
 create mode 100644 tools/testing/selftests/syscalls/fork_syscall/Makefile
 create mode 100644 tools/testing/selftests/syscalls/fork_syscall/fork_syscall.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..9265c17c5de3 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -97,6 +97,7 @@ TARGETS += sparc64
 TARGETS += splice
 TARGETS += static_keys
 TARGETS += sync
+TARGETS += syscalls/fork_syscall
 TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
diff --git a/tools/testing/selftests/syscalls/.gitignore b/tools/testing/selftests/syscalls/.gitignore
new file mode 100644
index 000000000000..c7ae138d3f0c
--- /dev/null
+++ b/tools/testing/selftests/syscalls/.gitignore
@@ -0,0 +1 @@
+// SPDX-License-Identifier: GPL-2.0
\ No newline at end of file
diff --git a/tools/testing/selftests/syscalls/fork_syscall/.gitignore b/tools/testing/selftests/syscalls/fork_syscall/.gitignore
new file mode 100644
index 000000000000..788cc1ff70bd
--- /dev/null
+++ b/tools/testing/selftests/syscalls/fork_syscall/.gitignore
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
\ No newline at end of file
diff --git a/tools/testing/selftests/syscalls/fork_syscall/Makefile b/tools/testing/selftests/syscalls/fork_syscall/Makefile
new file mode 100644
index 000000000000..56033a3d5a87
--- /dev/null
+++ b/tools/testing/selftests/syscalls/fork_syscall/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := fork_syscall
+CFLAGS += -Wall
+
+include ../lib.mk
\ No newline at end of file
diff --git a/tools/testing/selftests/syscalls/fork_syscall/fork_syscall.c b/tools/testing/selftests/syscalls/fork_syscall/fork_syscall.c
new file mode 100644
index 000000000000..eab22831f7e1
--- /dev/null
+++ b/tools/testing/selftests/syscalls/fork_syscall/fork_syscall.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* kselftest for fork() system call
+ *
+ * Summery : fork() system call is used to create a new process
+ * by duplicating an existing one. The new process, known as the
+ * child process, is a copy of the parent process.
+ * 
+ * Child process is dublicate process but has different PID and 
+ * memory allocation.
+ * 
+ * About the test : With this test we are testing the following:
+ * - Child PID which fork() returns to Parent is present in /proc
+ * - Child PID is not same as Parent PID.
+ * - Memory allocation to a variable in child and parent process
+ *   is different.
+*/
+
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <dirent.h>
+#include <ctype.h>
+
+#include "../../kselftest.h"
+
+// Function to check if a string is numeric (PID check)
+int is_numeric(const char *str) {
+    while (*str) {
+        if (!isdigit(*str)) return 0;
+        str++;
+    }
+    return 1;
+}
+
+// Function to find the child PID in /proc
+pid_t find_child_pid(pid_t parent_pid) {
+    DIR *proc_dir = opendir("/proc");
+    struct dirent *entry;
+
+    if (proc_dir == NULL) {
+        perror("Failed to open /proc directory");
+        ksft_exit_fail();
+        return 1;
+    }
+
+    // Iterate through the /proc directory to find PIDs
+    while ((entry = readdir(proc_dir)) != NULL) {
+        // Check if the entry is a PID
+        if (is_numeric(entry->d_name)) {  
+            pid_t pid = atoi(entry->d_name);
+
+            // Construct the path to /proc/<pid>/
+            //stat to check the parent PID
+
+            char path[40], buffer[100];
+            snprintf(path, 40, "/proc/%d/stat", pid);
+
+            FILE *stat_file = fopen(path, "r");
+            if (stat_file != NULL) {
+                fgets(buffer, 100, stat_file);
+                fclose(stat_file);
+
+                // The fourth field in /proc/<pid>/stat is the parent PID
+                pid_t ppid;
+                sscanf(buffer, "%*d %*s %*c %d", &ppid);
+
+                if (ppid == parent_pid) {
+                    closedir(proc_dir);
+                    // Return the child PID if the parent PID matches
+                    return pid;  
+                }
+            }
+        }
+    }
+
+    closedir(proc_dir);
+
+    // Return -1 if no child PID was found
+    return -1;  
+}
+
+int main(void) {
+
+    // Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+    // Check if test is run a root
+	if (geteuid()) {
+		ksft_test_result_skip("This test needs root to run!\n");
+		return 1;
+	}
+
+    // forking
+    pid_t pid = fork();
+
+    // Declare a variable in both parent and child processes
+    int var = 17;  
+
+    if (pid == -1) {
+		ksft_test_result_error("%s.\n", strerror(errno));
+		ksft_finished();
+		return 1;
+
+    } else if (pid == 0) {
+        // This is the child process
+        ksft_print_msg("Inside the child process.\n");
+        var = 1998;
+
+    } else {
+        // This is the parent process
+        pid_t ppid=getpid();
+        ksft_print_msg("Inside the parent process.\n");
+        ksft_print_msg("Child PID got from fork() return : %d\n", pid);
+        ksft_print_msg("Parent PID from getpid(): %d\n",ppid);
+
+        // Find the child PID in /proc
+        pid_t child_pid = find_child_pid(getpid());
+        if (child_pid != -1) {
+            ksft_set_plan(2);
+            if(child_pid == pid && pid != ppid && var != 1998) {
+                ksft_test_result_pass("Child Pid from /proc and fork() matching\n");
+                ksft_test_result_pass("Child Pid != Parent pid\n");
+                ksft_set_plan(3);
+                ksft_test_result_pass(
+                    "After modification in child No effect on the value of 'var' in parent\n");
+                ksft_exit_pass();
+		        return 0;
+            }
+            else {
+                ksft_exit_fail();
+			    return 1;
+            }
+        }
+        else {
+            ksft_test_result_fail("Child Pid from /proc and fork() does not match");
+            ksft_exit_fail();
+			return 1;
+        }
+
+        // Wait for the child process to finish
+        wait(NULL);
+    }
+
+    return 0;
+}
+
-- 
2.34.1


