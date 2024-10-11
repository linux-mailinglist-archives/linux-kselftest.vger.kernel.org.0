Return-Path: <linux-kselftest+bounces-19501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A39999B54
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FEF1F25246
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AF1F7067;
	Fri, 11 Oct 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+v7pz/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2B1F12FB;
	Fri, 11 Oct 2024 03:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618666; cv=none; b=e84yi8iL0R8IMEk7+zxyd118giSwwcpxF6Nh1ksIb3Mhr6b06fuj4zht4ZXmaZkdJJuX60sCqDwdyVLbL8I6wsgiGqer9yBsCMOrU2C/0IynZVAlKne2W0Z04G2PpHoOJNfOUUycF3F7FLxXFUfSXb6L3XYWEe/cyvIkgyF1gyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618666; c=relaxed/simple;
	bh=iteL6mM7W2wCmg62ZEOzFSnuAD2y1jb3hsKNq7Exj+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXBbjoRrjPi82uPc2NiwquLEHBnpsJ9UgJ5Lc9kvqpwX1ps1b+OshL+heryQY0oLURpj2+gE6s9+6LVQW7hGxMHpgoLZSVBGKG4YQcjPTS9AXtR5c7Za0ymXjIU9C6K5ljmXlFFCionh4Dtvn2MnO9OU7s7mJ9hfx5BPwUCXmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+v7pz/z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df0dbee46so1256136b3a.0;
        Thu, 10 Oct 2024 20:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618664; x=1729223464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ib/V9nv2y/EnyCZ3p2wVDpRbPGsIUIc315orCHypSCg=;
        b=F+v7pz/zPzsCcguaeCdpRSb8qKLFqZdgQR3czOLY0n5JzBdlRdCrwvp88O6rL+lEbA
         Ev2hUN9RUxg8Vw404qNuMqECxggFBpx0sAVPtvQeF1F7fwL7p8wbnJWHfFgLK5lRDINR
         1+dqYpWZ7ROf4LBAxYdMet5GY/gl06N0GRbFvyk/hsDM5HqfMbzFrPirM00iXx2QgN6h
         t62Cv8SYJCrsuORzEaHpXFKZT5ejEiKaMhCj3+mbZtXm/DjChyBzPb6P0XaZikjpFpBr
         xKgdUuorWxDHo7UgN4rir2Q9tAn0biN0qBg+0mdkrMT3N8GrzjW5R9XtIoQfwACzYz+9
         V+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618664; x=1729223464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ib/V9nv2y/EnyCZ3p2wVDpRbPGsIUIc315orCHypSCg=;
        b=DkPmUg5MtzUgY6tNBCNaEGGibP+OtMmHn0ITEPVfFBi42lhLDgLd05YFzlrRy72YpY
         Te6Iy+AtTZ0nTSYlTFVoOYf3wZa40n7+INASBjKHm5Dh45Ay2TUvbaBD/6xj0m/MkE3T
         SF6vE6FalETOaFlffXN2P2fAqWzGdjYaqX9A1KIKchyA9Zn5XUGNyh5UMdEXQo/v8lPw
         c6SCnrM8KB0OuDfM1tTA17vTig+AU6wJLgKOxrCaDtIPwZyQakvD2KYu1r0ocW3S0GWl
         +FbwvA9pyewJnOqK2HsbBxM9S+f+ySYKXH5SO0uNQFQkq6a+6LgbJ8SJ4Nq5QYY2FwVK
         4/bA==
X-Forwarded-Encrypted: i=1; AJvYcCU7eOhOl6lkN0ZSFMpU6Sqsl7KYZn8F04HO89jqS3eRf6C6SxFnaGxQ1MFcyXRXA+PSqMNuwtKi@vger.kernel.org, AJvYcCVVtvsWQX1Gd99PSFrVYSZK5FNmoHai9veLWkM+IQrPITCoJCUvATADoGwcJ/B3QhtC2lHkDcodC8U6t7M0+n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfS4xvftjZZ3JvNAvW42UCqHqfKfHij86JdEgTH80dxa58Oo3
	Qbo5LJCHbTCzwpRuV3Q15EIfcxbR/MzLWXkO30+/a6rmJVsSZWM=
X-Google-Smtp-Source: AGHT+IEJPpWDP387OUKaE5mHAnqb3y5oCY369qYkRMmCujdbMa9v7OCfoYCTHP7vhNboi7iS6LtMEw==
X-Received: by 2002:aa7:88c6:0:b0:71e:21:d2d8 with SMTP id d2e1a72fcca58-71e37e50c51mr2237014b3a.7.1728618663434;
        Thu, 10 Oct 2024 20:51:03 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0a645sm1858642b3a.94.2024.10.10.20.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:51:02 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [bpf-next 4/4] samples/bpf: remove obsolete tracing related tests
Date: Fri, 11 Oct 2024 03:50:38 +0000
Message-ID: <20241011035038.97568-5-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011035038.97568-1-danieltimlee@gmail.com>
References: <20241011035038.97568-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The samples/bpf has become outdated and often does not follow up with
the latest. This commit removes obsolete tracing-related tests.

Specifically, 'test_overhead' is duplicate with selftests (and bench),
and 'test_override_return', 'test_probe_write_user' tests are obsolete
since they have been replaced by kprobe_multi_override and probe_user
from selftests respectively.

The following files are removed:
- test_overhead: tests the overhead of BPF programs with task_rename,
  now covered by selftests and benchmark tests (rename-*). [1]

- test_override_return: tests the return override functionality, now
  handled by kprobe_multi_override in selftests.

- test_probe_write_user: tests the probe_write_user functionality,
  now replaced by the probe_user test in selftests.

This cleanup will help to streamline the testing framework by removing
redundant tests.

[1]: https://patchwork.kernel.org/cover/13759916

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile                     |  11 --
 samples/bpf/test_overhead_kprobe.bpf.c   |  41 -----
 samples/bpf/test_overhead_raw_tp.bpf.c   |  17 --
 samples/bpf/test_overhead_tp.bpf.c       |  23 ---
 samples/bpf/test_overhead_user.c         | 225 -----------------------
 samples/bpf/test_override_return.sh      |  16 --
 samples/bpf/test_probe_write_user.bpf.c  |  52 ------
 samples/bpf/test_probe_write_user_user.c | 108 -----------
 samples/bpf/tracex7.bpf.c                |  15 --
 samples/bpf/tracex7_user.c               |  56 ------
 10 files changed, 564 deletions(-)
 delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
 delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
 delete mode 100644 samples/bpf/test_overhead_user.c
 delete mode 100755 samples/bpf/test_override_return.sh
 delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
 delete mode 100644 samples/bpf/test_probe_write_user_user.c
 delete mode 100644 samples/bpf/tracex7.bpf.c
 delete mode 100644 samples/bpf/tracex7_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 66827dbb93b3..31bf0c665963 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -17,14 +17,11 @@ tprogs-y += tracex3
 tprogs-y += tracex4
 tprogs-y += tracex5
 tprogs-y += tracex6
-tprogs-y += tracex7
-tprogs-y += test_probe_write_user
 tprogs-y += trace_output
 tprogs-y += lathist
 tprogs-y += offwaketime
 tprogs-y += spintest
 tprogs-y += map_perf_test
-tprogs-y += test_overhead
 tprogs-y += test_cgrp2_attach
 tprogs-y += xdp_router_ipv4
 tprogs-y += trace_event
@@ -62,8 +59,6 @@ tracex3-objs := tracex3_user.o
 tracex4-objs := tracex4_user.o
 tracex5-objs := tracex5_user.o $(TRACE_HELPERS)
 tracex6-objs := tracex6_user.o
-tracex7-objs := tracex7_user.o
-test_probe_write_user-objs := test_probe_write_user_user.o
 trace_output-objs := trace_output_user.o
 lathist-objs := lathist_user.o
 offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
@@ -96,9 +91,7 @@ always-y += tracex3.bpf.o
 always-y += tracex4.bpf.o
 always-y += tracex5.bpf.o
 always-y += tracex6.bpf.o
-always-y += tracex7.bpf.o
 always-y += sock_flags.bpf.o
-always-y += test_probe_write_user.bpf.o
 always-y += trace_output.bpf.o
 always-y += tcbpf1_kern.o
 always-y += tc_l2_redirect_kern.o
@@ -106,9 +99,6 @@ always-y += lathist_kern.o
 always-y += offwaketime.bpf.o
 always-y += spintest.bpf.o
 always-y += map_perf_test.bpf.o
-always-y += test_overhead_tp.bpf.o
-always-y += test_overhead_raw_tp.bpf.o
-always-y += test_overhead_kprobe.bpf.o
 always-y += parse_varlen.o parse_simple.o parse_ldabs.o
 always-y += trace_event_kern.o
 always-y += sampleip_kern.o
@@ -182,7 +172,6 @@ TPROGLDLIBS_xdp_router_ipv4	+= -lm -pthread
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
-TPROGLDLIBS_test_overhead	+= -lrt
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 # make M=samples/bpf LLC=~/git/llvm-project/llvm/build/bin/llc CLANG=~/git/llvm-project/llvm/build/bin/clang
diff --git a/samples/bpf/test_overhead_kprobe.bpf.c b/samples/bpf/test_overhead_kprobe.bpf.c
deleted file mode 100644
index 668cf5259c60..000000000000
--- a/samples/bpf/test_overhead_kprobe.bpf.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/* Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-SEC("kprobe/__set_task_comm")
-int prog(struct pt_regs *ctx)
-{
-	struct signal_struct *signal;
-	struct task_struct *tsk;
-	char oldcomm[TASK_COMM_LEN] = {};
-	char newcomm[TASK_COMM_LEN] = {};
-	u16 oom_score_adj;
-	u32 pid;
-
-	tsk = (void *)PT_REGS_PARM1_CORE(ctx);
-
-	pid = BPF_CORE_READ(tsk, pid);
-	bpf_core_read_str(oldcomm, sizeof(oldcomm), &tsk->comm);
-	bpf_core_read_str(newcomm, sizeof(newcomm),
-				  (void *)PT_REGS_PARM2(ctx));
-	signal = BPF_CORE_READ(tsk, signal);
-	oom_score_adj = BPF_CORE_READ(signal, oom_score_adj);
-	return 0;
-}
-
-SEC("kprobe/fib_table_lookup")
-int prog2(struct pt_regs *ctx)
-{
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_overhead_raw_tp.bpf.c b/samples/bpf/test_overhead_raw_tp.bpf.c
deleted file mode 100644
index 6af39fe3f8dd..000000000000
--- a/samples/bpf/test_overhead_raw_tp.bpf.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (c) 2018 Facebook */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-SEC("raw_tracepoint/task_rename")
-int prog(struct bpf_raw_tracepoint_args *ctx)
-{
-	return 0;
-}
-
-SEC("raw_tracepoint/fib_table_lookup")
-int prog2(struct bpf_raw_tracepoint_args *ctx)
-{
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_overhead_tp.bpf.c b/samples/bpf/test_overhead_tp.bpf.c
deleted file mode 100644
index 5dc08b587978..000000000000
--- a/samples/bpf/test_overhead_tp.bpf.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <bpf/bpf_helpers.h>
-
-/* from /sys/kernel/tracing/events/task/task_rename/format */
-SEC("tracepoint/task/task_rename")
-int prog(struct trace_event_raw_task_rename *ctx)
-{
-	return 0;
-}
-
-/* from /sys/kernel/tracing/events/fib/fib_table_lookup/format */
-SEC("tracepoint/fib/fib_table_lookup")
-int prog2(struct trace_event_raw_fib_table_lookup *ctx)
-{
-	return 0;
-}
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
deleted file mode 100644
index dbd86f7b1473..000000000000
--- a/samples/bpf/test_overhead_user.c
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 Facebook
- */
-#define _GNU_SOURCE
-#include <sched.h>
-#include <errno.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <asm/unistd.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <assert.h>
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <arpa/inet.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <linux/bpf.h>
-#include <string.h>
-#include <time.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#define MAX_CNT 1000000
-#define DUMMY_IP "127.0.0.1"
-#define DUMMY_PORT 80
-
-static struct bpf_link *links[2];
-static struct bpf_object *obj;
-static int cnt;
-
-static __u64 time_get_ns(void)
-{
-	struct timespec ts;
-
-	clock_gettime(CLOCK_MONOTONIC, &ts);
-	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
-}
-
-static void test_task_rename(int cpu)
-{
-	char buf[] = "test\n";
-	__u64 start_time;
-	int i, fd;
-
-	fd = open("/proc/self/comm", O_WRONLY|O_TRUNC);
-	if (fd < 0) {
-		printf("couldn't open /proc\n");
-		exit(1);
-	}
-	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++) {
-		if (write(fd, buf, sizeof(buf)) < 0) {
-			printf("task rename failed: %s\n", strerror(errno));
-			close(fd);
-			return;
-		}
-	}
-	printf("task_rename:%d: %lld events per sec\n",
-	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
-	close(fd);
-}
-
-static void test_fib_table_lookup(int cpu)
-{
-	struct sockaddr_in addr;
-	char buf[] = "test\n";
-	__u64 start_time;
-	int i, fd;
-
-	fd = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
-	if (fd < 0) {
-		printf("couldn't open socket\n");
-		exit(1);
-	}
-	memset((char *)&addr, 0, sizeof(addr));
-	addr.sin_addr.s_addr = inet_addr(DUMMY_IP);
-	addr.sin_port = htons(DUMMY_PORT);
-	addr.sin_family = AF_INET;
-	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++) {
-		if (sendto(fd, buf, strlen(buf), 0,
-			   (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-			printf("failed to start ping: %s\n", strerror(errno));
-			close(fd);
-			return;
-		}
-	}
-	printf("fib_table_lookup:%d: %lld events per sec\n",
-	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
-	close(fd);
-}
-
-static void loop(int cpu, int flags)
-{
-	cpu_set_t cpuset;
-
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpu, &cpuset);
-	sched_setaffinity(0, sizeof(cpuset), &cpuset);
-
-	if (flags & 1)
-		test_task_rename(cpu);
-	if (flags & 2)
-		test_fib_table_lookup(cpu);
-}
-
-static void run_perf_test(int tasks, int flags)
-{
-	pid_t pid[tasks];
-	int i;
-
-	for (i = 0; i < tasks; i++) {
-		pid[i] = fork();
-		if (pid[i] == 0) {
-			loop(i, flags);
-			exit(0);
-		} else if (pid[i] == -1) {
-			printf("couldn't spawn #%d process\n", i);
-			exit(1);
-		}
-	}
-	for (i = 0; i < tasks; i++) {
-		int status;
-
-		assert(waitpid(pid[i], &status, 0) == pid[i]);
-		assert(status == 0);
-	}
-}
-
-static int load_progs(char *filename)
-{
-	struct bpf_program *prog;
-	int err = 0;
-
-	obj = bpf_object__open_file(filename, NULL);
-	err = libbpf_get_error(obj);
-	if (err < 0) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return err;
-	}
-
-	/* load BPF program */
-	err = bpf_object__load(obj);
-	if (err < 0) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		return err;
-	}
-
-	bpf_object__for_each_program(prog, obj) {
-		links[cnt] = bpf_program__attach(prog);
-		err = libbpf_get_error(links[cnt]);
-		if (err < 0) {
-			fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-			links[cnt] = NULL;
-			return err;
-		}
-		cnt++;
-	}
-
-	return err;
-}
-
-static void unload_progs(void)
-{
-	while (cnt)
-		bpf_link__destroy(links[--cnt]);
-
-	bpf_object__close(obj);
-}
-
-int main(int argc, char **argv)
-{
-	int num_cpu = sysconf(_SC_NPROCESSORS_ONLN);
-	int test_flags = ~0;
-	char filename[256];
-	int err = 0;
-
-
-	if (argc > 1)
-		test_flags = atoi(argv[1]) ? : test_flags;
-	if (argc > 2)
-		num_cpu = atoi(argv[2]) ? : num_cpu;
-
-	if (test_flags & 0x3) {
-		printf("BASE\n");
-		run_perf_test(num_cpu, test_flags);
-	}
-
-	if (test_flags & 0xC) {
-		snprintf(filename, sizeof(filename),
-			 "%s_kprobe.bpf.o", argv[0]);
-
-		printf("w/KPROBE\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 2);
-
-		unload_progs();
-	}
-
-	if (test_flags & 0x30) {
-		snprintf(filename, sizeof(filename),
-			 "%s_tp.bpf.o", argv[0]);
-		printf("w/TRACEPOINT\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 4);
-
-		unload_progs();
-	}
-
-	if (test_flags & 0xC0) {
-		snprintf(filename, sizeof(filename),
-			 "%s_raw_tp.bpf.o", argv[0]);
-		printf("w/RAW_TRACEPOINT\n");
-		err = load_progs(filename);
-		if (!err)
-			run_perf_test(num_cpu, test_flags >> 6);
-
-		unload_progs();
-	}
-
-	return err;
-}
diff --git a/samples/bpf/test_override_return.sh b/samples/bpf/test_override_return.sh
deleted file mode 100755
index 35db26f736b9..000000000000
--- a/samples/bpf/test_override_return.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-
-rm -r tmpmnt
-rm -f testfile.img
-dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
-DEVICE=$(losetup --show -f testfile.img)
-mkfs.btrfs -f $DEVICE
-mkdir tmpmnt
-./tracex7 $DEVICE
-if [ $? -eq 0 ]
-then
-	echo "SUCCESS!"
-else
-	echo "FAILED!"
-fi
-losetup -d $DEVICE
diff --git a/samples/bpf/test_probe_write_user.bpf.c b/samples/bpf/test_probe_write_user.bpf.c
deleted file mode 100644
index a4f3798b7fb0..000000000000
--- a/samples/bpf/test_probe_write_user.bpf.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/* Copyright (c) 2016 Sargun Dhillon <sargun@sargun.me>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#include "vmlinux.h"
-#include <string.h>
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__type(key, struct sockaddr_in);
-	__type(value, struct sockaddr_in);
-	__uint(max_entries, 256);
-} dnat_map SEC(".maps");
-
-/* kprobe is NOT a stable ABI
- * kernel functions can be removed, renamed or completely change semantics.
- * Number of arguments and their positions can change, etc.
- * In such case this bpf+kprobe example will no longer be meaningful
- *
- * This example sits on a syscall, and the syscall ABI is relatively stable
- * of course, across platforms, and over time, the ABI may change.
- */
-SEC("ksyscall/connect")
-int BPF_KSYSCALL(bpf_prog1, int fd, struct sockaddr_in *uservaddr,
-		 int addrlen)
-{
-	struct sockaddr_in new_addr, orig_addr = {};
-	struct sockaddr_in *mapped_addr;
-
-	if (addrlen > sizeof(orig_addr))
-		return 0;
-
-	if (bpf_probe_read_user(&orig_addr, sizeof(orig_addr), uservaddr) != 0)
-		return 0;
-
-	mapped_addr = bpf_map_lookup_elem(&dnat_map, &orig_addr);
-	if (mapped_addr != NULL) {
-		memcpy(&new_addr, mapped_addr, sizeof(new_addr));
-		bpf_probe_write_user(uservaddr, &new_addr,
-				     sizeof(new_addr));
-	}
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_probe_write_user_user.c b/samples/bpf/test_probe_write_user_user.c
deleted file mode 100644
index 2a539aec4116..000000000000
--- a/samples/bpf/test_probe_write_user_user.c
+++ /dev/null
@@ -1,108 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <assert.h>
-#include <unistd.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-
-int main(int ac, char **argv)
-{
-	struct sockaddr_in *serv_addr_in, *mapped_addr_in, *tmp_addr_in;
-	struct sockaddr serv_addr, mapped_addr, tmp_addr;
-	int serverfd, serverconnfd, clientfd, map_fd;
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	socklen_t sockaddr_len;
-	char filename[256];
-	char *ip;
-
-	serv_addr_in = (struct sockaddr_in *)&serv_addr;
-	mapped_addr_in = (struct sockaddr_in *)&mapped_addr;
-	tmp_addr_in = (struct sockaddr_in *)&tmp_addr;
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, "bpf_prog1");
-	if (libbpf_get_error(prog)) {
-		fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd = bpf_object__find_map_fd_by_name(obj, "dnat_map");
-	if (map_fd < 0) {
-		fprintf(stderr, "ERROR: finding a map in obj file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach(prog);
-	if (libbpf_get_error(link)) {
-		fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	assert((serverfd = socket(AF_INET, SOCK_STREAM, 0)) > 0);
-	assert((clientfd = socket(AF_INET, SOCK_STREAM, 0)) > 0);
-
-	/* Bind server to ephemeral port on lo */
-	memset(&serv_addr, 0, sizeof(serv_addr));
-	serv_addr_in->sin_family = AF_INET;
-	serv_addr_in->sin_port = 0;
-	serv_addr_in->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-
-	assert(bind(serverfd, &serv_addr, sizeof(serv_addr)) == 0);
-
-	sockaddr_len = sizeof(serv_addr);
-	assert(getsockname(serverfd, &serv_addr, &sockaddr_len) == 0);
-	ip = inet_ntoa(serv_addr_in->sin_addr);
-	printf("Server bound to: %s:%d\n", ip, ntohs(serv_addr_in->sin_port));
-
-	memset(&mapped_addr, 0, sizeof(mapped_addr));
-	mapped_addr_in->sin_family = AF_INET;
-	mapped_addr_in->sin_port = htons(5555);
-	mapped_addr_in->sin_addr.s_addr = inet_addr("255.255.255.255");
-
-	assert(!bpf_map_update_elem(map_fd, &mapped_addr, &serv_addr, BPF_ANY));
-
-	assert(listen(serverfd, 5) == 0);
-
-	ip = inet_ntoa(mapped_addr_in->sin_addr);
-	printf("Client connecting to: %s:%d\n",
-	       ip, ntohs(mapped_addr_in->sin_port));
-	assert(connect(clientfd, &mapped_addr, sizeof(mapped_addr)) == 0);
-
-	sockaddr_len = sizeof(tmp_addr);
-	ip = inet_ntoa(tmp_addr_in->sin_addr);
-	assert((serverconnfd = accept(serverfd, &tmp_addr, &sockaddr_len)) > 0);
-	printf("Server received connection from: %s:%d\n",
-	       ip, ntohs(tmp_addr_in->sin_port));
-
-	sockaddr_len = sizeof(tmp_addr);
-	assert(getpeername(clientfd, &tmp_addr, &sockaddr_len) == 0);
-	ip = inet_ntoa(tmp_addr_in->sin_addr);
-	printf("Client's peer address: %s:%d\n",
-	       ip, ntohs(tmp_addr_in->sin_port));
-
-	/* Is the server's getsockname = the socket getpeername */
-	assert(memcmp(&serv_addr, &tmp_addr, sizeof(struct sockaddr_in)) == 0);
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return 0;
-}
diff --git a/samples/bpf/tracex7.bpf.c b/samples/bpf/tracex7.bpf.c
deleted file mode 100644
index ab8d6704a5a4..000000000000
--- a/samples/bpf/tracex7.bpf.c
+++ /dev/null
@@ -1,15 +0,0 @@
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-
-SEC("kprobe/open_ctree")
-int bpf_prog1(struct pt_regs *ctx)
-{
-	unsigned long rc = -12;
-
-	bpf_override_return(ctx, rc);
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/tracex7_user.c b/samples/bpf/tracex7_user.c
deleted file mode 100644
index b10b5e03a226..000000000000
--- a/samples/bpf/tracex7_user.c
+++ /dev/null
@@ -1,56 +0,0 @@
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <unistd.h>
-#include <bpf/libbpf.h>
-
-int main(int argc, char **argv)
-{
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-	char command[256];
-	int ret = 0;
-	FILE *f;
-
-	if (!argv[1]) {
-		fprintf(stderr, "ERROR: Run with the btrfs device argument!\n");
-		return 0;
-	}
-
-	snprintf(filename, sizeof(filename), "%s.bpf.o", argv[0]);
-	obj = bpf_object__open_file(filename, NULL);
-	if (libbpf_get_error(obj)) {
-		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-		return 0;
-	}
-
-	prog = bpf_object__find_program_by_name(obj, "bpf_prog1");
-	if (!prog) {
-		fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach(prog);
-	if (libbpf_get_error(link)) {
-		fprintf(stderr, "ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	snprintf(command, 256, "mount %s tmpmnt/", argv[1]);
-	f = popen(command, "r");
-	ret = pclose(f);
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return ret ? 0 : 1;
-}
-- 
2.43.0


