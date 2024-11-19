Return-Path: <linux-kselftest+bounces-22298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C99D2AE1
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6917EB2A9D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 16:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E671D0DE2;
	Tue, 19 Nov 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gm0HhRTJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYtpCLDm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EF146A9F;
	Tue, 19 Nov 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033104; cv=none; b=AWHN7Qq00mjZzzmSOARiwu4pnIBlXxdW8RYELGvel8XeHTIsMpCD+qaVFhsJGr8NN/4vtwePq0E9CRqlZ1BqTTr2SVkeBrJahyBqELBjkNnBZbgMUNh7e3y/Ts8dfRFLn6e3VX3CLgHd20/MXNVE3V4J9Ob1kHC3ZgO7F9zGsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033104; c=relaxed/simple;
	bh=RlqfthpzERhgPS1WG4wKwvmmB3qMfE5F7MyIpfxXgnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IGtq2PrwceFgWCkeHX3styAovTrJiMse8uMnKo0oJK/lfl7XZK+KXSDEyFl+cECWdVeMrEbWZDAON9TYcPNjPrNVLu1FlNBIJCwsD01F9LMd9bg/zHUtjuB8aHMlWmM0sxFaguh8Bn/j7B5tuSgJJeNw93IWbkp2js1GniyvWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gm0HhRTJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYtpCLDm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 17:18:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732033101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ipgz3VH5tPCd7/JyBoEHZcyXqUDtyFVudCf3Ihe4Tyg=;
	b=gm0HhRTJ02OKuR/D6dE+ED71+pGiSWyNWDgmPJppQLYr6QScJ9PE+DuYDBfZL9JMZRbKFr
	whackjm888NYDSTnRNXZwdTkFXPR+6QfKGwEktJm8nsxpgl0WaLWGiPwHBmlR4VGtfRTpl
	LIORmSufmFlH8d1wiQJQ376yT0dhhKPEKA8njwFlFiqTcgDSxn70Pt0AgXJRbJSw+RPZjV
	bwPAOPyxLky4CmgcCk3TwuLn0cFgZY7K+E1Bsq+vIbJsoXr2BXO6gLMqmaManHxa3Wx6V8
	KpRzt21q13jzD6FtnQ0wuDn3rXLMuZtlkpxesJGMRuZmssMh0lmpWImm9i+lLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732033101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ipgz3VH5tPCd7/JyBoEHZcyXqUDtyFVudCf3Ihe4Tyg=;
	b=YYtpCLDmhZPdz4rrCToZvx3g6faSmizKjeUeAyYSdybZTn6iB2iUOkojxTJdOuikwkkNQc
	apK4nLfdlc7yssCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH bpf] selftests/bpf: Check for PREEMPTION instead of PREEMPT
Message-ID: <20241119161819.qvEcs-n_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

CONFIG_PREEMPT is a preemtion model the so called "Low-Latency Desktop".
A different preemption model is PREEMPT_RT the so called "Real-Time".
Both implement preemption in kernel and set CONFIG_PREEMPTION.
There is also the so called "LAZY PREEMPT" which the "Scheduler
controlled preemption model". Here we have also preemption in the kernel
the rules are slightly different.

Therefore the testsuite should not check for CONFIG_PREEMPT (as one
model) but for CONFIG_PREEMPTION to figure out if preemption in the
kernel is possible.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/bpf/map_tests/task_storage_map.c      | 4 ++--
 tools/testing/selftests/bpf/prog_tests/task_local_storage.c   | 2 +-
 .../testing/selftests/bpf/progs/read_bpf_task_storage_busy.c  | 4 ++--
 tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/task_storage_map.c b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
index 7d050364efca1..5fd7c923544c3 100644
--- a/tools/testing/selftests/bpf/map_tests/task_storage_map.c
+++ b/tools/testing/selftests/bpf/map_tests/task_storage_map.c
@@ -77,8 +77,8 @@ void test_task_storage_map_stress_lookup(void)
 	CHECK(err, "open_and_load", "error %d\n", err);
 
 	/* Only for a fully preemptible kernel */
-	if (!skel->kconfig->CONFIG_PREEMPT) {
-		printf("%s SKIP (no CONFIG_PREEMPT)\n", __func__);
+	if (!skel->kconfig->CONFIG_PREEMPTION) {
+		printf("%s SKIP (no CONFIG_PREEMPTION)\n", __func__);
 		read_bpf_task_storage_busy__destroy(skel);
 		skips++;
 		return;
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index c33c05161a9ea..acaeebf83f3ee 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -189,7 +189,7 @@ static void test_nodeadlock(void)
 	/* Unnecessary recursion and deadlock detection are reproducible
 	 * in the preemptible kernel.
 	 */
-	if (!skel->kconfig->CONFIG_PREEMPT) {
+	if (!skel->kconfig->CONFIG_PREEMPTION) {
 		test__skip();
 		goto done;
 	}
diff --git a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
index 76556e0b42b24..69da05bb6c63e 100644
--- a/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
+++ b/tools/testing/selftests/bpf/progs/read_bpf_task_storage_busy.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-extern bool CONFIG_PREEMPT __kconfig __weak;
+extern bool CONFIG_PREEMPTION __kconfig __weak;
 extern const int bpf_task_storage_busy __ksym;
 
 char _license[] SEC("license") = "GPL";
@@ -24,7 +24,7 @@ int BPF_PROG(read_bpf_task_storage_busy)
 {
 	int *value;
 
-	if (!CONFIG_PREEMPT)
+	if (!CONFIG_PREEMPTION)
 		return 0;
 
 	if (bpf_get_current_pid_tgid() >> 32 != pid)
diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index ea2dbb80f7b3e..986829aaf73a6 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -10,7 +10,7 @@ char _license[] SEC("license") = "GPL";
 #define EBUSY 16
 #endif
 
-extern bool CONFIG_PREEMPT __kconfig __weak;
+extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
 
@@ -29,7 +29,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 	int ret, zero = 0;
 	int *value;
 
-	if (!CONFIG_PREEMPT)
+	if (!CONFIG_PREEMPTION)
 		return 0;
 
 	task = bpf_get_current_task_btf();
-- 
2.45.2


