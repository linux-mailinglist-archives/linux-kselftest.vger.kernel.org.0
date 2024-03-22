Return-Path: <linux-kselftest+bounces-6504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE518870F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 17:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7794E1F21CBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Mar 2024 16:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6EC43AAC;
	Fri, 22 Mar 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oF6gPW+O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAC2208F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Mar 2024 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125236; cv=none; b=LzokMC259fSrixf+dxgAupyGxGmnHNKzgyB1d+aMPs4AfJ+gO1LZOcRL4KrprnyIdSUwa5C711fgSGPqoCnwonaB+X+FiEIKLIfwO8SAu2Feqjuo2Fy+EWKRcX0rDgjkUl2ZOhSmeTsPAXaBj3+tcMaa8q5ApZKR+gcvrnbxmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125236; c=relaxed/simple;
	bh=jFgzHuf+C6eWq8tkQGtyBbiJvXgYi6XxZOXS+E5Xf2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bUA3RHg+9Zgo8a8OqvKqQeeRCgA2kb5wEA2SFhaiozc7yh+PalKoGOq0a2Qjojs6ll7zhUGXKl+rNT7cPXKhlLbs1f37dOlCmiiz3tdyA+Gmx14oKu8BLOl5nQaw0lhH7WM1O5KS5Bw4rTClT0y59bgBVbJ6EL49ykx0zSwp4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oF6gPW+O; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711125234; x=1742661234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jFgzHuf+C6eWq8tkQGtyBbiJvXgYi6XxZOXS+E5Xf2A=;
  b=oF6gPW+O0FTlyxJC2G7hVcPMtNINxwa3EUqhWscJN3Pw7UOOJl43nD8Z
   yxkNd4kwZJo5yROJw9XTcr5nL84qnsQeX/x571SSwlaox3WWKzZXsBPY7
   8Xhqn6QESdxxS+y2YjuoKOIbEpmjpT6S+AnWv5VYpWxgWhGBna5fH2tYE
   mvu076/VnfDAECCwL2Pdr+nwfmxtJa0/48d9rw/WN8NMgTIAdDsRh2jaF
   MJIZokc5rhGajk87JF2Q5fcZQyp/oU/BoNkYo2pN5GM4eCkmeARk7QTq2
   npi6KD/mrDAznBA6xRvoZjwxd4Gcm0+XHoNhnYxKZ3UZPFr3WI6mnYTiX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="23637523"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="23637523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15019269"
Received: from 984fee00c67b.jf.intel.com ([10.23.0.114])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 09:33:52 -0700
From: Zide Chen <zide.chen@intel.com>
To: linux-kselftest@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	Zide Chen <zide.chen@intel.com>
Subject: [PATCH] selftests/rseq: take large C-state exit latency into consideration
Date: Fri, 22 Mar 2024 09:33:51 -0700
Message-Id: <20240322163351.150673-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the migration worker delays 1-10 us, assuming that one
KVM_RUN iteration only takes a few microseconds.  But if C-state exit
latencies are large enough, for example, hundreds or even thousands
of microseconds on server CPUs, it may happen that it's not able to
bring the target CPU out of C-state before the migration worker starts
to migrate it to the next CPU.

If the system workload is light, most CPUs could be at a certain level
of C-state, and the vCPU thread may waste milliseconds before it can
actually migrate to a new CPU.

Thus, the tests may be inefficient in such systems, and in some cases
it may fail the migration/KVM_RUN ratio sanity check.

Since we are not able to turn off the cpuidle sub-system in run time,
this patch creates an idle thread on every CPU to prevent them from
entering C-states.

Additionally, seems it's reasonable to randomize the length of usleep(),
other than delay in a fixed pattern.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 tools/testing/selftests/kvm/rseq_test.c | 76 ++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 28f97fb52044..d6e8b851d29e 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -11,6 +11,7 @@
 #include <syscall.h>
 #include <sys/ioctl.h>
 #include <sys/sysinfo.h>
+#include <sys/resource.h>
 #include <asm/barrier.h>
 #include <linux/atomic.h>
 #include <linux/rseq.h>
@@ -29,9 +30,10 @@
 #define NR_TASK_MIGRATIONS 100000
 
 static pthread_t migration_thread;
+static pthread_t *idle_threads;
 static cpu_set_t possible_mask;
-static int min_cpu, max_cpu;
-static bool done;
+static int min_cpu, max_cpu, nproc;
+static volatile bool done;
 
 static atomic_t seq_cnt;
 
@@ -150,7 +152,7 @@ static void *migration_worker(void *__rseq_tid)
 		 * Use usleep() for simplicity and to avoid unnecessary kernel
 		 * dependencies.
 		 */
-		usleep((i % 10) + 1);
+		usleep((rand() % 10) + 1);
 	}
 	done = true;
 	return NULL;
@@ -158,7 +160,7 @@ static void *migration_worker(void *__rseq_tid)
 
 static void calc_min_max_cpu(void)
 {
-	int i, cnt, nproc;
+	int i, cnt;
 
 	TEST_REQUIRE(CPU_COUNT(&possible_mask) >= 2);
 
@@ -186,6 +188,61 @@ static void calc_min_max_cpu(void)
 		       "Only one usable CPU, task migration not possible");
 }
 
+static void *idle_thread_fn(void *__idle_cpu)
+{
+	int r, cpu = (int)(unsigned long)__idle_cpu;
+	cpu_set_t allowed_mask;
+
+	CPU_ZERO(&allowed_mask);
+	CPU_SET(cpu, &allowed_mask);
+
+	r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
+	TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
+		errno, strerror(errno));
+
+	/* lowest priority, trying to prevent it from entering C-states */
+	r = setpriority(PRIO_PROCESS, 0, 19);
+	TEST_ASSERT(!r, "setpriority failed, errno = %d (%s)",
+		errno, strerror(errno));
+
+	while(!done);
+
+	return NULL;
+}
+
+static void spawn_threads(void)
+{
+	int cpu;
+
+	/* Run a dummy thread on every CPU */
+	for (cpu = min_cpu; cpu <= max_cpu; cpu++) {
+		if (!CPU_ISSET(cpu, &possible_mask))
+			continue;
+
+		pthread_create(&idle_threads[cpu], NULL, idle_thread_fn,
+			       (void *)(unsigned long)cpu);
+	}
+
+	pthread_create(&migration_thread, NULL, migration_worker,
+		       (void *)(unsigned long)syscall(SYS_gettid));
+}
+
+static void join_threads(void)
+{
+	int cpu;
+
+	pthread_join(migration_thread, NULL);
+
+	for (cpu = min_cpu; cpu <= max_cpu; cpu++) {
+		if (!CPU_ISSET(cpu, &possible_mask))
+			continue;
+
+		pthread_join(idle_threads[cpu], NULL);
+	}
+
+	free(idle_threads);
+}
+
 int main(int argc, char *argv[])
 {
 	int r, i, snapshot;
@@ -199,6 +256,12 @@ int main(int argc, char *argv[])
 
 	calc_min_max_cpu();
 
+	srand(time(NULL));
+
+	idle_threads = malloc(sizeof(pthread_t) * nproc);
+	TEST_ASSERT(idle_threads, "malloc failed, errno = %d (%s)", errno,
+		    strerror(errno));
+
 	r = rseq_register_current_thread();
 	TEST_ASSERT(!r, "rseq_register_current_thread failed, errno = %d (%s)",
 		    errno, strerror(errno));
@@ -210,8 +273,7 @@ int main(int argc, char *argv[])
 	 */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
-	pthread_create(&migration_thread, NULL, migration_worker,
-		       (void *)(unsigned long)syscall(SYS_gettid));
+	spawn_threads();
 
 	for (i = 0; !done; i++) {
 		vcpu_run(vcpu);
@@ -258,7 +320,7 @@ int main(int argc, char *argv[])
 	TEST_ASSERT(i > (NR_TASK_MIGRATIONS / 2),
 		    "Only performed %d KVM_RUNs, task stalled too much?", i);
 
-	pthread_join(migration_thread, NULL);
+	join_threads();
 
 	kvm_vm_free(vm);
 
-- 
2.34.1


