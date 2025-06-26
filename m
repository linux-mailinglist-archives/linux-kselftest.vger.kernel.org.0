Return-Path: <linux-kselftest+bounces-35867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16226AEA304
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7A71C443F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9BA2ED14C;
	Thu, 26 Jun 2025 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mT8pD8kz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA42ECD18;
	Thu, 26 Jun 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953206; cv=none; b=Bn2mMW+yVKIxvKTZbBJuauimvrtgvNadCDkGh3ojeKx9T0j7Kvuyoo7/mvD2xHM5yTM0zBMEUwag8S0J+yuP15LKRNaKNatUFK94E4OOCcFtOFuzJBxHuUUKxhqQpJzDObgCM6xX2yjAGNROFROgJngcBvjRoIYUhtPTxIgA7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953206; c=relaxed/simple;
	bh=t7j2zfKYQtnOwWS12vNjvBooNT+a9X6VXD0LhZ5ESmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh02As5huQdYTKovnSSr7M2pP46GzN1wA5JnpdwLCnlS9Sz0ASHUVf1FTPgQlJzfZLoC89996NLQIQMhEGeLAXACmeLC5/uBkwYRc1meBIrE+uCLvzjt17W5ymHscO7LdxQyBY1ahqj17HTJCIOlGFBXTIQDNEPG5Zgmsa4yUd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mT8pD8kz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d7b50815so9186705e9.2;
        Thu, 26 Jun 2025 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750953202; x=1751558002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avFe0uCPAlGUsBDkTrAMoArX5v2saGyLPFhmXQ2cVg0=;
        b=mT8pD8kzB68yHc7yNVGEVFvPc/GAOFAgvM9MS7i9FktGCXKm48zeJd8t4DiP79og3z
         sB0WIYwNDpkZRBLsqEcJzdUSYfAhUXywAhdJh3DArFucXEeJgN3383TPcSAXExjJgloH
         eKe4DvyN+xURNRt8VGBLkUGUsnuaem+NeXRkBREN+CruEQbV/M+vAiDqWlixJb4sSBEe
         ngoBeXwwu7fE8i2QdmThvJsQ2iJfmXiyG1v0NQSazx7DKrJ9tGjU8GUnGJk54QwWsfsP
         Npc6bGuwtlWdhpIpHss3ClOKNy1yb0rySLdMoEMsHVeOMgh/3HNSR60y/JR8ozaAAFfr
         Geug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750953202; x=1751558002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avFe0uCPAlGUsBDkTrAMoArX5v2saGyLPFhmXQ2cVg0=;
        b=wpBdN+rIYxVbCjz28EFP4zS+MVmr28O88H+oJDCWknCfoOdojfzaQomeq+UUEz2f9D
         yYf8iVV0pQwyzldaJe4lTvk8pLu0kGBGiiZt04VeQaG8OCNgS9JpHv871ZJu6OYdgSiQ
         eiOdHkpA3abJCbUZihNyNI5iMniAr0pTAg526qYnrUF6+E8JwkC6Wtec8NCMySNuhvAk
         z7ct/j12OtuoQwM0ild+KUG/8ocKESP+MvwdBADOLrYj0OlWsRLpCtMjUYkzPMThPn/0
         7v50fRDMsE957p2JuAdHh+gm1rwwC2eV8YobgAQ+B/D1NAsXWR3DDGFtMwTkkEXNu7D0
         c4Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUitKuo/20inNgolbeCivH4cXazCSNpmv8Er2NxpZ7QCc6IbiCYXULvjMKtvI9akvOi7KUDbsuXI+asYtw=@vger.kernel.org, AJvYcCVq+/CWjWA0lp21IYPh9YqMmZgEG0Vgif4yOijMR4VKyTHXNW/HY2V7qiloDHdamzLOFU4s6DvTz7Dt0uXTKy/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WIkolFnWRMSGJpANPMZ9gYKCIL+wX+sIrNqbyyfjcrUYnsPg
	KO86xOzPu0VjN5Zw6Wyt3quXVHNKFPCL8tXjf1WwqUGKrq5LohD229km
X-Gm-Gg: ASbGncv6inqgQnIzvdk/3hbglceyA+gmujFBFfUlK/LWTmZdLD/GE0WP1chRl78UKdE
	HRpqZbxAdpSribDhW1JnWVehe2zuExU6wO+jO6OerVwtQPlqqfBC70h46hMoIKbWSzkOsw8nqXC
	nrDuf9PEm1x3ZhpVqXUeV2rFKmYhl8TMYcJRqvnstvqOted1iChB7tQ7GKZ+3/1MmdIN0kIsh8o
	icJnCUsQ418l1jBNVMeBTR8sf/KjliI6s6pEAgBCwNBe7DEZEcYSX1fc+QeKIyOGqQkBuECrDPQ
	D+yEtDeR2BdLxw6n/PpdCpt+bQN4mARTW1RVEIAha6/+qvIs0nBlu4Ph7IPGWxcrEBUU3JXSFff
	1wjsAqaV4VxO+nv35CWBQVGIMC3MKdj0E84apv4x3iA==
X-Google-Smtp-Source: AGHT+IGRKscdnd27cxZAcZV/moc6/jQHPLiIak2xe+ZqUvI8F9Nbn7YdJ7PBCPT+k/TB5QFUb7LEnQ==
X-Received: by 2002:a05:600c:c4a3:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45381aeba44mr67564275e9.22.1750953202265;
        Thu, 26 Jun 2025 08:53:22 -0700 (PDT)
Received: from puck.. (watf-12-b2-v4wan-169542-cust1006.vm45.cable.virginm.net. [81.98.219.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45380705351sm51727455e9.0.2025.06.26.08.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:53:21 -0700 (PDT)
From: Dylan Yudaken <dyudaken@gmail.com>
To: mathieu.desnoyers@efficios.com,
	paulmck@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dylan Yudaken <dyudaken@gmail.com>
Subject: [PATCH 2/2] membarrier: self test for cpu specific calls
Date: Thu, 26 Jun 2025 16:52:57 +0100
Message-ID: <20250626155257.81256-3-dyudaken@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626155257.81256-1-dyudaken@gmail.com>
References: <20250626155257.81256-1-dyudaken@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a self test for the cpu specific calls to membarrier.

This works by figuring out the number of interrupts on a given core
before/after calling membarrier(2) to assert that at least some
interrupts have happened.
This feels like it might be a bit flaky if for example the worker
thread was switched out. To mitigate this there are some checks such
as making sure it stays on one core, and also it asserts only 1
interrupt for every 2 calls to membarrier(2)

Signed-off-by: Dylan Yudaken <dyudaken@gmail.com>
---
 tools/testing/selftests/membarrier/.gitignore |   1 +
 tools/testing/selftests/membarrier/Makefile   |   3 +-
 .../membarrier/membarrier_test_expedited.c    | 135 ++++++++++++++++++
 .../membarrier/membarrier_test_impl.h         |   5 +
 4 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/membarrier/membarrier_test_expedited.c

diff --git a/tools/testing/selftests/membarrier/.gitignore b/tools/testing/selftests/membarrier/.gitignore
index f2fbba178601..39cdadb11c01 100644
--- a/tools/testing/selftests/membarrier/.gitignore
+++ b/tools/testing/selftests/membarrier/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 membarrier_test_multi_thread
 membarrier_test_single_thread
+membarrier_test_expedited
diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
index fc840e06ff56..f3e7920a900c 100644
--- a/tools/testing/selftests/membarrier/Makefile
+++ b/tools/testing/selftests/membarrier/Makefile
@@ -3,6 +3,7 @@ CFLAGS += -g $(KHDR_INCLUDES)
 LDLIBS += -lpthread
 
 TEST_GEN_PROGS := membarrier_test_single_thread \
-		membarrier_test_multi_thread
+		membarrier_test_multi_thread \
+		membarrier_test_expedited
 
 include ../lib.mk
diff --git a/tools/testing/selftests/membarrier/membarrier_test_expedited.c b/tools/testing/selftests/membarrier/membarrier_test_expedited.c
new file mode 100644
index 000000000000..aaea36381282
--- /dev/null
+++ b/tools/testing/selftests/membarrier/membarrier_test_expedited.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <linux/membarrier.h>
+#include <syscall.h>
+#include <stdio.h>
+#include <string.h>
+#include <pthread.h>
+#include <stdatomic.h>
+
+#include "membarrier_test_impl.h"
+
+struct thread_state {
+	atomic_int thread_cpu;
+	atomic_bool end_thread;
+	pthread_mutex_t mutex;
+};
+
+void *test_membarrier_thread(void *arg)
+{
+	struct thread_state *ts = (struct thread_state *)arg;
+
+	ts->thread_cpu = sched_getcpu();
+	pthread_mutex_unlock(&ts->mutex);
+	if (ts->thread_cpu < 0)
+		return 0;
+	while (!ts->end_thread)
+		ts->thread_cpu = sched_getcpu();
+	return NULL;
+}
+
+static long read_interrupts(int cpu)
+{
+	char line[4096];
+	FILE *fp = fopen("/proc/interrupts", "r");
+	long res = 0;
+
+	if (!fp)
+		ksft_exit_fail_msg("unable to open /proc/interrupts\n");
+
+	fgets(line, sizeof(line), fp); /* skip first line */
+	while (fgets(line, sizeof(line), fp) != NULL) {
+		char *save;
+		int next_cpu = 0;
+
+		for (char *token = strtok_r(line, " ", &save); token;
+		     token = strtok_r(NULL, " ", &save)) {
+			if (*token < '0' || *token > '9')
+				continue;
+			if (next_cpu++ == cpu)
+				res += atol(token);
+		}
+	}
+	fclose(fp);
+	return res;
+}
+
+static int test_membarrier(const char *name, int cmd, int register_cmd)
+{
+	int runs = 0;
+	long irq = 0;
+	pthread_t test_thread;
+	int ret = 0;
+
+	struct thread_state ts = { .thread_cpu = -1,
+				   .end_thread = 0,
+				   .mutex = PTHREAD_MUTEX_INITIALIZER };
+	if (sys_membarrier_cpu(cmd, 0) == 0)
+		ksft_exit_fail_msg("%s: expected failure before register\n",
+				   name);
+	if (sys_membarrier(register_cmd, 0) != 0)
+		ksft_exit_fail_msg("%s: unable to register\n", name);
+
+	/* nothing interesting in single processor machines */
+	if (sysconf(_SC_NPROCESSORS_ONLN) == 1)
+		goto success;
+
+	pthread_mutex_lock(&ts.mutex);
+	pthread_create(&test_thread, NULL, test_membarrier_thread, &ts);
+
+	/* wait for thread to start */
+	pthread_mutex_lock(&ts.mutex);
+	pthread_mutex_unlock(&ts.mutex);
+
+	for (int i = 0; i < 1000; i++) {
+		int cpu_start, cpu_end, cpu_this;
+		long irq_start, irq_end;
+
+		cpu_start = ts.thread_cpu;
+		if (cpu_start < 0)
+			ksft_exit_fail_msg("sched_getcpu() failed\n");
+
+		irq_start = read_interrupts(cpu_start);
+		if (sys_membarrier_cpu(cmd, cpu_start))
+			ksft_exit_fail_msg("%s: sys_membarrier failed\n", name);
+		cpu_end = ts.thread_cpu;
+		cpu_this = sched_getcpu();
+
+		/* maybe it was moved to a different cpu, so we cannot trust the irq count */
+		/* If we are on the same cpu we wouldnt expect an interrupt */
+		if (cpu_end != cpu_start || cpu_this == cpu_end)
+			continue;
+		irq_end = read_interrupts(cpu_end);
+		irq += (irq_end - irq_start);
+		runs++;
+	}
+	ts.end_thread = 1;
+	pthread_join(test_thread, NULL);
+
+	if (!runs)
+		ksft_exit_fail_msg("%s: no successful runs\n", name);
+
+	/* Every run should probably have had an interrupt, but use at least half
+	 * to be safe.
+	 */
+	if (irq < runs / 2)
+		ksft_exit_fail_msg("%s: only had %d / %d irqs\n", name, irq,
+				   runs);
+success:
+	ksft_test_result_pass("expedited %s\n", name);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(3);
+
+	test_membarrier("EXPEDITED", MEMBARRIER_CMD_PRIVATE_EXPEDITED,
+			MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED);
+	test_membarrier("RSEQ", MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+			MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ);
+	test_membarrier("SYNC_CORE", MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE,
+			MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE);
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..c10a8af4612e 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -16,6 +16,11 @@ static int sys_membarrier(int cmd, int flags)
 	return syscall(__NR_membarrier, cmd, flags);
 }
 
+static int sys_membarrier_cpu(int cmd, int cpu)
+{
+	return syscall(__NR_membarrier, cmd, MEMBARRIER_CMD_FLAG_CPU, cpu);
+}
+
 static int test_membarrier_get_registrations(int cmd)
 {
 	int ret, flags = 0;
-- 
2.49.0


