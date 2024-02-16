Return-Path: <linux-kselftest+bounces-4875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6AB858548
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 19:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724051C20C35
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D211384A8;
	Fri, 16 Feb 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T1FQqQW9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372541339A2
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108317; cv=none; b=DL/BDTG945G/nyTJd40WKtnk3lw/kUvFYOb1jNcSCAw6cu49pNFmF2Q01bSKz2rdz4qEkaO10iHZZ83hhybcbc8rSRFM4r0jokAdEOnf+yHtruBaS8VupMTmZ7EpBjqpDxNKUKyNg5cdz7pUpOkFARurfI3yQmG2CbS8dT9iwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108317; c=relaxed/simple;
	bh=mZ2gOIXcUxYPUWs6+iWh+plbgTcX3Uoy+H9V33hkCIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWXZwt4+YJSjoBkGIfvKU/Vn5CpAOEcC3MKgEtMK7jEc2e4Mv1MwFD7zUbGhcx9zaTS84ExhmtJAE3fzL120+hskMwbAlpX7G0ZTp8msbLK+hE9zMjCzOrx5yBcHKZbFEb9cb/Y/y8rEMYa/fT2rkLQhbQiChYCjAM+fs8d4qT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=T1FQqQW9; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68f15feac3dso11560126d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 10:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708108314; x=1708713114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDhDd9Kfjsqh4jLKpVf7J36w/JnuAi2f5V71QMuGAEk=;
        b=T1FQqQW9TyHh7HgT+F67Khdj1PilhW3VPjsjqYihnfFaIn7pw8ggciDJAkQGDTSSBI
         iqoTmDz6YS4G1PF1+7y7A17Uu3oZhNRu0a1tRPTOqV+6v3KDzJ2nGLwkEIUejXwMqCkv
         bEyROjqgxfZs9uHnGSFc68A/67hVrl3WKckNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708108314; x=1708713114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDhDd9Kfjsqh4jLKpVf7J36w/JnuAi2f5V71QMuGAEk=;
        b=qor2lbP0bHm7Q6RujyMHgrzvIPhHyUnzgJaYl4tRN41Au21BCukoMOizEnA0T+p0Sf
         OZCI/h9Ye+GocaKWJGJMiNWOeolwUKXYsgeUfVGEhHI5VrNPJ6Zjm304Jmq1FAcuybC4
         kBoS89Xd2l0sSvFBcc11qlKoTEE9niIK7xFg7hiGLqJt8HLJeS6292s+Q4rSY0c8pjSi
         slGJzy9sCLaSWq3dLN99n3i0sKBQEtirvdvTLDR2hOcw32xBaEfe+TFfaJPmWaqRFH8j
         BpGgnFba5+gXN4JW6g4yO9quLgC4Db0gP1pYq+s1gyJjLJtcuYsyr4akDLShoNhUGeFv
         qdbA==
X-Forwarded-Encrypted: i=1; AJvYcCXNeq5bgQzTdjhGReJ5xfiHTwodp2r+5hrbz+J1KWk/VfUc4IgRxp/qSpbyVZG0xZHMqPowLQq80qc3gEIUQuWvr7wbreTPg44vVrSTO9Au
X-Gm-Message-State: AOJu0YyiZzLVkWatQ9kpfB3jRNRs0jnkRWNe7qSeMJODuITvP8eRGAf+
	43jOHaOsCz4Mt1UNprGZuZuwNGTQYJJFCCJDZk8GAVQg4BtCoEky4fDbdARcv/k=
X-Google-Smtp-Source: AGHT+IGhLeBZCvEV3RiqOD8Gk2JJl2wSyxA9sXMztIfDCRh/Q2EdnLcbUU8EEBlGLC3HNXEpawOwhw==
X-Received: by 2002:a05:6214:5904:b0:68c:668b:c610 with SMTP id qo4-20020a056214590400b0068c668bc610mr7398414qvb.2.1708108314017;
        Fri, 16 Feb 2024 10:31:54 -0800 (PST)
Received: from joelbox2.. (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id nd13-20020a056214420d00b0068cdadb5e7esm159722qvb.31.2024.02.16.10.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:31:53 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH 08/10] selftests/sched: Migrate cs_prctl_test to kselfttest
Date: Fri, 16 Feb 2024 13:31:06 -0500
Message-Id: <20240216183108.1564958-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216183108.1564958-1-joel@joelfernandes.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test begs to be a kselftest, is in the kselftest hierarchy and does
not even use a single kselftest API. Convert it.

It simplifies some of the code and the output also looks much nicer now:

 Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/sched/Makefile        |  6 +-
 tools/testing/selftests/sched/cs_prctl_test.c | 74 ++++++++++---------
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
index f491d741cb45..90c53bc1337e 100644
--- a/tools/testing/selftests/sched/Makefile
+++ b/tools/testing/selftests/sched/Makefile
@@ -1,9 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 TEST_GEN_PROGS := cs_dlserver_test
-
-cs_dlserver_test: cs_dlserver_test.c common.c
+TEST_GEN_PROGS += cs_prctl_test
 
 CFLAGS += $(KHDR_INCLUDES)
 CFLAGS += -Wall
 
 include ../lib.mk
+
+$(OUTPUT)/cs_dlserver_test: cs_dlserver_test.c common.c
+$(OUTPUT)/cs_prctl_test: cs_prctl_test.c common.c
diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 7ba057154343..bb7aee703cdf 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -28,10 +28,11 @@
 #include <unistd.h>
 #include <time.h>
 #include <errno.h>
-#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
+#include "common.h"
+
 #if __GLIBC_PREREQ(2, 30) == 0
 #include <sys/syscall.h>
 static pid_t gettid(void)
@@ -80,7 +81,7 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
 	int res;
 
 	res = prctl(option, arg2, arg3, arg4, arg5);
-	printf("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
+	ksft_print_msg("%d = prctl(%d, %ld, %ld, %ld, %lx)\n", res, option, (long)arg2, (long)arg3,
 	       (long)arg4, arg5);
 	return res;
 }
@@ -91,21 +92,20 @@ static int _prctl(int option, unsigned long arg2, unsigned long arg3, unsigned l
 static void __handle_error(char *fn, int ln, char *msg)
 {
 	int pidx;
-	printf("(%s:%d) - ", fn, ln);
+	ksft_print_msg("(%s:%d) - ", fn, ln);
 	perror(msg);
 	if (need_cleanup) {
 		for (pidx = 0; pidx < num_processes; ++pidx)
 			kill(procs[pidx].cpid, 15);
 		need_cleanup = 0;
 	}
-	exit(EXIT_FAILURE);
+	ksft_exit_fail();
 }
 
 static void handle_usage(int rc, char *msg)
 {
-	puts(USAGE);
-	puts(msg);
-	putchar('\n');
+	ksft_print_msg("%s\n", USAGE);
+	ksft_print_msg("%s\n\n", msg);
 	exit(rc);
 }
 
@@ -117,7 +117,7 @@ static unsigned long get_cs_cookie(int pid)
 	ret = prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, pid, PIDTYPE_PID,
 		    (unsigned long)&cookie);
 	if (ret) {
-		printf("Not a core sched system\n");
+		ksft_print_msg("Not a core sched system\n");
 		return -1UL;
 	}
 
@@ -160,7 +160,7 @@ static int child_func_process(void *arg)
 
 	ret = write(ca->pfd[1], &ca->thr_tids, sizeof(int) * ca->num_threads);
 	if (ret == -1)
-		printf("write failed on pfd[%d] - error (%s)\n",
+		ksft_print_msg("write failed on pfd[%d] - error (%s)\n",
 			ca->pfd[1], strerror(errno));
 
 	close(ca->pfd[1]);
@@ -192,7 +192,7 @@ void create_processes(int num_processes, int num_threads, struct child_args proc
 	for (i = 0; i < num_processes; ++i) {
 		ret = read(proc[i].pfd[0], &proc[i].thr_tids, sizeof(int) * proc[i].num_threads);
 		if (ret == -1)
-			printf("read failed on proc[%d].pfd[0] error (%s)\n",
+			ksft_print_msg("read failed on proc[%d].pfd[0] error (%s)\n",
 				i, strerror(errno));
 		close(proc[i].pfd[0]);
 	}
@@ -202,30 +202,29 @@ void disp_processes(int num_processes, struct child_args proc[])
 {
 	int i, j;
 
-	printf("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
+	ksft_print_msg("tid=%d, / tgid=%d / pgid=%d: %lx\n", gettid(), getpid(), getpgid(0),
 	       get_cs_cookie(getpid()));
 
 	for (i = 0; i < num_processes; ++i) {
-		printf("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
+		ksft_print_msg("    tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].cpid, proc[i].cpid,
 		       getpgid(proc[i].cpid), get_cs_cookie(proc[i].cpid));
 		for (j = 0; j < proc[i].num_threads; ++j) {
-			printf("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
+			ksft_print_msg("        tid=%d, / tgid=%d / pgid=%d: %lx\n", proc[i].thr_tids[j],
 			       proc[i].cpid, getpgid(0), get_cs_cookie(proc[i].thr_tids[j]));
 		}
 	}
 	puts("\n");
 }
 
-static int errors;
-
 #define validate(v) _validate(__LINE__, v, #v)
 void _validate(int line, int val, char *msg)
 {
 	if (!val) {
-		++errors;
-		printf("(%d) FAILED: %s\n", line, msg);
+		ksft_print_msg("(%d) FAILED: %s\n", line, msg);
+		ksft_inc_fail_cnt();
 	} else {
-		printf("(%d) PASSED: %s\n", line, msg);
+		ksft_print_msg("(%d) PASSED: %s\n", line, msg);
+		ksft_inc_pass_cnt();
 	}
 }
 
@@ -254,13 +253,17 @@ int main(int argc, char *argv[])
 			keypress = 1;
 			break;
 		case 'h':
-			printf(USAGE);
+			ksft_print_msg(USAGE);
 			exit(EXIT_SUCCESS);
 		default:
 			handle_usage(20, "unknown option");
 		}
 	}
 
+	if (!hyperthreading_enabled()) {
+		ksft_exit_skip("This test requires hyperthreading to be enabled\n");
+	}
+
 	if (num_processes < 1 || num_processes > MAX_PROCESSES)
 		handle_usage(1, "Bad processes value");
 
@@ -272,17 +275,22 @@ int main(int argc, char *argv[])
 
 	srand(time(NULL));
 
-	/* put into separate process group */
+	/* Put into separate process group */
 	if (setpgid(0, 0) != 0)
 		handle_error("process group");
 
-	printf("\n## Create a thread/process/process group hiearchy\n");
+	ksft_print_header();
+
+	/* Increase the count if adding more validate() statements. */
+	ksft_set_plan(17);
+
+	ksft_print_msg("\n## Create a thread/process/process group hiearchy\n");
 	create_processes(num_processes, num_threads, procs);
 	need_cleanup = 1;
 	disp_processes(num_processes, procs);
 	validate(get_cs_cookie(0) == 0);
 
-	printf("\n## Set a cookie on entire process group\n");
+	ksft_print_msg("\n## Set a cookie on entire process group\n");
 	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, 0, PIDTYPE_PGID, 0) < 0)
 		handle_error("core_sched create failed -- PGID");
 	disp_processes(num_processes, procs);
@@ -296,7 +304,7 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(0) == get_cs_cookie(pid));
 	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
 
-	printf("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
+	ksft_print_msg("\n## Set a new cookie on entire process/TGID [%d]\n", pid);
 	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, pid, PIDTYPE_TGID, 0) < 0)
 		handle_error("core_sched create failed -- TGID");
 	disp_processes(num_processes, procs);
@@ -305,7 +313,7 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(pid) != 0);
 	validate(get_cs_cookie(pid) == get_cs_cookie(procs[pidx].thr_tids[0]));
 
-	printf("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
+	ksft_print_msg("\n## Copy the cookie of current/PGID[%d], to pid [%d] as PIDTYPE_PID\n",
 	       getpid(), pid);
 	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, pid, PIDTYPE_PID, 0) < 0)
 		handle_error("core_sched share to itself failed -- PID");
@@ -315,7 +323,7 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(pid) != 0);
 	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
 
-	printf("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
+	ksft_print_msg("\n## Copy cookie from a thread [%d] to current/PGID [%d] as PIDTYPE_PID\n",
 	       procs[pidx].thr_tids[0], getpid());
 	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, procs[pidx].thr_tids[0],
 		   PIDTYPE_PID, 0) < 0)
@@ -325,7 +333,7 @@ int main(int argc, char *argv[])
 	validate(get_cs_cookie(0) == get_cs_cookie(procs[pidx].thr_tids[0]));
 	validate(get_cs_cookie(pid) != get_cs_cookie(procs[pidx].thr_tids[0]));
 
-	printf("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
+	ksft_print_msg("\n## Copy cookie from current [%d] to current as pidtype PGID\n", getpid());
 	if (_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 0) < 0)
 		handle_error("core_sched share to self failed -- PGID");
 	disp_processes(num_processes, procs);
@@ -340,20 +348,16 @@ int main(int argc, char *argv[])
 	validate(_prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, 0, PIDTYPE_PGID, 1) < 0
 		&& errno == EINVAL);
 
-	if (errors) {
-		printf("TESTS FAILED. errors: %d\n", errors);
-		res = 10;
-	} else {
-		printf("SUCCESS !!!\n");
-	}
-
-	if (keypress)
+	if (keypress) {
+		ksft_print_msg("Waiting for keypress to exit\n");
 		getchar();
-	else
+	} else {
 		sleep(delay);
+	}
 
 	for (pidx = 0; pidx < num_processes; ++pidx)
 		kill(procs[pidx].cpid, 15);
 
+	ksft_finished();
 	return res;
 }
-- 
2.34.1


