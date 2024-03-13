Return-Path: <linux-kselftest+bounces-6288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC287A0AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 02:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6829528510F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Mar 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E28F61;
	Wed, 13 Mar 2024 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="xggoGQ3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDB171AC
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Mar 2024 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293121; cv=none; b=rzxVS5yToELTw7VCzK04lPzFHW8B7c0GmRcybpOTkEj2KzorWrjIWd7uTWkfF6lLdW+bY+nm3gUjxpGGGu/X9jyiA2jNhdxlm+HSV8Fi8dPhYbqGr/GwfgbvOOVFrJE2cO4fBvJ+51XGGYuU7/IBAhViK4nEGTySk+Yx/D4+KyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293121; c=relaxed/simple;
	bh=OSrAg2NG3ZYsMO+/bzATjsRdKuLLDdxyzjpAKJt8kcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajEPOoC57/2BtZcpIeVfqYxlPI8gYr9l1r81JwhzIvUZPpybXTauuWuT45pHj85BzM/r23MMJKwVCL8nmwGXvQ04qAB4tNzpJ4z3cJ7Rixd+D2qs08h1G3JINp1gy2YSAsFW7O6GXCO4sAEQzbbdK35hnlJXaSQfnqBDpbxoT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=xggoGQ3M; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d41547dc1dso165073e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Mar 2024 18:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710293118; x=1710897918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGM3mRROwFt6krNu3XhZIaE8fo5xphzgJ2jbr0QsLYo=;
        b=xggoGQ3MTZkpILwwcMCVN6uKH5tJd64VfD1xbGeVMh6QOeB/hLapWMRehjfv/aR9+b
         2kWRI1PShBPbyeapgG/FTRUSMo8WEFL2XEBlLypNoA3ZntIYwoa3+KgU9ypGMbDBQUWU
         KhqVdi+jH3F1JF9reNSQGyUfVIpWV+CoP2f4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710293118; x=1710897918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGM3mRROwFt6krNu3XhZIaE8fo5xphzgJ2jbr0QsLYo=;
        b=qpIGSWEWp1o6IHU+g98WF4lKt6i5c3n6hq6EHmlG/gXRWvOQ568R2baeQ5/X92EqJn
         nFV99358FEfxi4Zsz+GMMScr91XlAZIuuXTvQd2QXY/D8mB/S1RHjuUShODjw5Vquxa/
         AMiG6br12FR9U9EzKj909MbuXxCSP+B9/qiJRDcgwZMf3/XNREkUTC4FEIkjWtx0Z1xv
         v8y8IohG4x3IjGV8Z3ZIJRfzVXGN2xmRZw2VVECuOE8poo095BkkeZ6Zrbb69htK0vgn
         Gyk0Xcq3tgKpUngk4APHfTwvUoivgt8xqXVqwHZUtlsffnv/43+JgXjCmgV6BsJDeBql
         LjUA==
X-Forwarded-Encrypted: i=1; AJvYcCUBt0ZYS0vsGBjKMxcq24ry19z8KOGom84sXRXkHXkxencDtGF9S+QFBe3tJGq713JyrEIbun38uaEvBTOmm157kH7LjZ1GISe81LZxt7JT
X-Gm-Message-State: AOJu0Yzs7c1B48q7/aA3trL9ixf6lVh92QlaNrzuQFVg+pILRvrG6kgB
	pkyFayMOdNmEKhkSMUVOm/yT1WsDPgRhp+EBrVrEgB+grZRhW/moLrC+1TsdAP4=
X-Google-Smtp-Source: AGHT+IH2n7iY4beQVKg78epng1qg9X6GYztiNS5gYmb2epJqipro1s1s7yzW1VnAX10RJPFI7WmrUw==
X-Received: by 2002:a05:6122:4e8f:b0:4d3:3a8c:13ad with SMTP id gf15-20020a0561224e8f00b004d33a8c13admr7939547vkb.8.1710293118309;
        Tue, 12 Mar 2024 18:25:18 -0700 (PDT)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id u9-20020a05621411a900b00690314356a4sm4162132qvv.80.2024.03.12.18.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 18:25:17 -0700 (PDT)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Vernet <void@manifault.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	joseph.salisbury@canonical.com,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Phil Auld <pauld@redhat.com>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 07/15] selftests/sched: Add a test to verify that DL server works with core scheduling
Date: Tue, 12 Mar 2024 21:24:43 -0400
Message-Id: <20240313012451.1693807-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313012451.1693807-1-joel@joelfernandes.org>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test verifies that DL server infrastructure gives CFS tasks a fixed
bandwidth even when RT tasks are being "core scheduled" on a core.
Verify that they are getting the expected bandwidth (and thus not being
starved).

Also verified that not having core scheduling fixes makes the test fail
as the CFS task gets no bandwidth.

Sample output:

 # Runtime of PID 97 is 4.440000 seconds
 # Runtime of PID 98 is 4.560000 seconds
 # Runtime of PID 99 is 4.550000 seconds
 ok 1 PASS

Notes about test that generated the sample output:

The test runs for 12 seconds. We check the runtimes at 9 seconds. We
expect the CFS task (PID 7) to get ~50% of the 9 seconds. The DL server
is configured for 50% bandwidth.

The RT tasks (PID 98, 99) each get 50% as well, because they run
concurrently on 2 hyperthreads of a core.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/sched/Makefile        |  13 +-
 tools/testing/selftests/sched/common.c        |  24 ++
 tools/testing/selftests/sched/common.h        |   8 +
 .../selftests/sched/cs_dlserver_test.c        | 254 ++++++++++++++++++
 4 files changed, 290 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/sched/common.c
 create mode 100644 tools/testing/selftests/sched/common.h
 create mode 100644 tools/testing/selftests/sched/cs_dlserver_test.c

diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index 099ee9213557..f491d741cb45 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0+
+TEST_GEN_PROGS := cs_dlserver_test
 
-ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
-CLANG_FLAGS += -no-integrated-as
-endif
+cs_dlserver_test: cs_dlserver_test.c common.c
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -Wl,-rpath=./ \
-	  $(CLANG_FLAGS)
-LDLIBS += -lpthread
-
-TEST_GEN_FILES := cs_prctl_test
-TEST_PROGS := cs_prctl_test
+CFLAGS += $(KHDR_INCLUDES)
+CFLAGS += -Wall
 
 include ../lib.mk
diff --git a/tools/testing/selftests/sched/common.c b/tools/testing/selftests/sched/common.c
new file mode 100644
index 000000000000..5cf0022acc8d
--- /dev/null
+++ b/tools/testing/selftests/sched/common.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "common.h"
+
+bool hyperthreading_enabled(void)
+{
+	FILE *file = fopen("/sys/devices/system/cpu/smt/active", "r");
+	char smt_active[2];
+
+	if (file == NULL) {
+		ksft_print_msg("Could not determine if hyperthreading is enabled\n");
+		return false;
+	}
+
+	if (fgets(smt_active, sizeof(smt_active), file)	== NULL) {
+		perror("Failed to read smt_active");
+		return false;
+	}
+	fclose(file);
+
+	if (smt_active[0] != '1')
+		return false;
+	return true;
+}
diff --git a/tools/testing/selftests/sched/common.h b/tools/testing/selftests/sched/common.h
new file mode 100644
index 000000000000..7bcedbd0ed99
--- /dev/null
+++ b/tools/testing/selftests/sched/common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <dirent.h>
+#include "../kselftest.h"
+
+bool hyperthreading_enabled(void);
diff --git a/tools/testing/selftests/sched/cs_dlserver_test.c b/tools/testing/selftests/sched/cs_dlserver_test.c
new file mode 100644
index 000000000000..9f2a74a25686
--- /dev/null
+++ b/tools/testing/selftests/sched/cs_dlserver_test.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Use the DL server infrastructure to give CFS tasks a fixed bandwidth
+ * even when RT tasks are being "core scheduled" on a core. Verify that
+ * they are getting the expected bandwidth (and thus not being starved).
+ *
+ * Copyright (c) 2024 Google.
+ * Author: Joel Fernandes <joel@joelfernandes.org>
+ *
+ * This library is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This library is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this library; if not, see <http://www.gnu.org/licenses>.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <time.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/prctl.h>
+#include <fcntl.h>
+#include <string.h>
+
+#include "common.h"
+
+enum pid_type {PIDTYPE_PID = 0, PIDTYPE_TGID, PIDTYPE_PGID};
+
+#define RUN_TIME 12 // Running time of the test in seconds
+#define CORE_ID 0 // Assuming we're pinning processes to the first core
+#define DL_SERVER_DEBUGFS "/sys/kernel/debug/sched/fair_server"
+
+void write_server_debugfs(char *file, char *type, unsigned long value)
+{
+	char path[1024], buf[1024];
+	int fd, n;
+
+	snprintf(path, sizeof(path), "%s/%s/%s", DL_SERVER_DEBUGFS, file, type);
+	fd = open(path,	O_WRONLY);
+	if (fd == -1) {
+		perror("Failed to open file for writing");
+		return;
+	}
+	n = snprintf(buf, sizeof(buf), "%lu\n", value);
+	n = write(fd, buf, n);
+	if (n == -1)
+		perror("Failed to write file");
+
+	close(fd);
+}
+
+void write_dl_server_params(void)
+{
+	DIR *dir;
+	struct dirent *entry;
+
+	if (access(DL_SERVER_DEBUGFS, F_OK) == -1) {
+		perror("DL server debugfs not found, cannot set DL parameters.");
+		exit(EXIT_FAILURE);
+	}
+
+	dir = opendir(DL_SERVER_DEBUGFS);
+	if (dir	== NULL) {
+		perror("Failed to open directory");
+		exit(EXIT_FAILURE);
+	}
+
+	while ((entry = readdir(dir)) != NULL) {
+		if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
+			continue;
+
+		write_server_debugfs(entry->d_name, "period", 100000000);
+		write_server_debugfs(entry->d_name, "runtime", 50000000);
+	}
+	closedir(dir);
+}
+
+void process_func(void)
+{
+	unsigned long long count = 0;
+	time_t end;
+
+	// Busy loop for RUN_TIME seconds
+	end = time(NULL) + RUN_TIME;
+	while (time(NULL) < end) {
+		count++; // Just a dummy operation
+	}
+}
+
+void set_affinity(int cpu_id)
+{
+	cpu_set_t cpuset;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu_id, &cpuset);
+	CPU_SET(cpu_id + 1, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpu_set_t), &cpuset) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1; // Indicate failure
+	}
+
+	// Skip the first 13 fields and read the 14th and 15th
+	fields = fscanf(file,
+					"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+					&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1; // Indicate failure
+	}
+
+	// Calculate the total time spent in the process
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+int main(void)
+{
+	float runtime1, runtime2, runtime3;
+	int pid1, pid2, pid3;
+
+	if (!hyperthreading_enabled())
+		ksft_test_result_skip("This test requires hyperthreading to be enabled\n");
+
+	write_dl_server_params();
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Create and set up a CFS task
+	pid1 = fork();
+	if (pid1 == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (pid1 < 0) {
+		perror("fork for p1");
+		ksft_exit_fail();
+	}
+
+	// Create a new unique cookie for the CFS task
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid1, PIDTYPE_TGID, 0) < 0) {
+		perror("prctl for pid1");
+		ksft_exit_fail();
+	}
+
+	// Create a new unique cookie for the current process. Future
+	// forks will inherit this cookie.
+	if (prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_TGID, 0) < 0) {
+		perror("prctl for current process");
+		ksft_exit_fail();
+	}
+
+	// Create an RT task which inherits the parent's cookie
+	pid2 = fork();
+	if (pid2 == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (pid2 < 0) {
+		perror("fork for p2");
+		ksft_exit_fail();
+	}
+
+	// Create another RT task which inherits the parent's cookie
+	pid3 = fork();
+	if (pid3 == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (pid3 < 0) {
+		perror("fork for p3");
+		ksft_exit_fail();
+	}
+
+	sleep(RUN_TIME * 3 / 4);
+	runtime1 = get_process_runtime(pid1);
+	if (runtime1 != -1)
+		ksft_print_msg("Runtime of PID %d is %f seconds\n", pid1, runtime1);
+	else
+		ksft_exit_fail_msg("Error getting runtime for PID %d\n", pid1);
+
+	runtime2 = get_process_runtime(pid2);
+	if (runtime2 != -1)
+		ksft_print_msg("Runtime of PID %d is %f seconds\n", pid2, runtime2);
+	else
+		ksft_exit_fail_msg("Error getting runtime for PID %d\n", pid2);
+
+	runtime3 = get_process_runtime(pid3);
+	if (runtime3 != -1)
+		ksft_print_msg("Runtime of PID %d is %f seconds\n", pid3, runtime3);
+	else
+		ksft_exit_fail_msg("Error getting runtime for PID %d\n", pid3);
+
+	// Make sure runtime1 is within 30% of runtime2
+	if (runtime1 < 0.7 * runtime2 || runtime1 > 1.3	* runtime2)
+		ksft_exit_fail_msg("Runtime of PID %d is not within 30%% of runtime of PID %d\n",
+						   pid1, pid2);
+
+	// Make	sure runtime1 is within 30% of runtime3
+	if (runtime1 < 0.7 * runtime3 || runtime1 > 1.3 * runtime3)
+		ksft_exit_fail_msg("Runtime of PID %d is not within 30%% of runtime of PID %d\n",
+						   pid1, pid3);
+
+	waitpid(pid1, NULL, 0);
+	waitpid(pid2, NULL, 0);
+	waitpid(pid3, NULL, 0);
+
+	ksft_test_result_pass("PASS\n");
+	return 0;
+}
-- 
2.34.1


