Return-Path: <linux-kselftest+bounces-10861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FF68D3DFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D981B241F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830521C9ECC;
	Wed, 29 May 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obYwEYoD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2501C6890
	for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005929; cv=none; b=Ha1HpJfx+Gzfs3wzEJksUrQhG2RMjPuLwPSI3ESBllDBfZzJV7/I+2gXNvT9jKMU3S8qcHoH1HX23PSD9SQcWhZn+i3TLTcbH9CUKLxJ8AONoQ0kpis255DY7M3xYbTZ2uFagGlVjFlekg3ie/5nIxmovu7WOs8KAGUlBHycu6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005929; c=relaxed/simple;
	bh=HxUpyE4cgKAUUbNhgJVD54jNZmrZ7gIbbpjjGwW6oOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mLsLUGH3qNjOMonfeDHPlbEKvkrwaEhAqyaOBzqo9fai2I0GvhpJzKRkKKtncWapRSGK5TMb5h1GmMEXIohSW38nJVo6EkT8LeXqE41CnM2G4pBUH+04FSH4NeV4sXbY6T6Q5UMgCu9XOquo+S1/kGE1W9xHPIfauY2s1tItWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obYwEYoD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4e7854de8so4131335276.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 May 2024 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717005924; x=1717610724; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KFOu6Kxojus6YReobAbXgdpXtL4lDaOJhpPuWR2SyLk=;
        b=obYwEYoD4CPLm9FpSZLzpWx/JktxtSndRBIRxdOgJ40RMklEBx1oEGSOQId7ShYM/o
         01k37Mrc7sTQOvC2mCM9KAyfFIfM6oIFg2FwCMizsivtMnPJt0PP1VKcnuIDDRnfc8SQ
         oi/9s2iRE1tRzyjIZzLR7RgcNeNbW2fML1I7z+S12Wm85+pmhMcjcU9r4jHIyxAZDiZP
         pRdyIxAPzTNQzNvIPSvCSkVh/Ig9fR66YN+w4FMiFTbuTXtDtnyWLwTAh6idO7mqnvYg
         iqTYRvxZQaISuEHn1QCsb6IKLe2mziydJwKa+G7hJXjlaRCiAvXTh/r1k+OtgU2YSx/C
         agtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005924; x=1717610724;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFOu6Kxojus6YReobAbXgdpXtL4lDaOJhpPuWR2SyLk=;
        b=qJDzxEWzaULYtXN6GgUig56HkGbf8rNrIe6catAhcES4Wzp17QXi5Jf9d7z7+H/ceO
         T6xjBKhaLwikvL/WQd+2VlrQfrBvXuJPwu8WvUsDA2Sl/MOJtNFfBe0YkSQr49vmsQEO
         PIwCdpXYonc0+19iufQq+AH6iRWLjzyikBDKIM0wuzTorpiir+f1742L8jNNt5gWYob5
         abtPql4DtTjP8lNOHoMMnbFf3dmy3IGCkLbjNxzFBfLRBSIjfsNnjau6bRbeK1raXOaf
         2jPSP1HWvlwSOBHC/E5bZ7YSlqUlXLER94vSyQODPY+UfRGdfRRx3hhNVA7oDQv/XEHu
         0f4g==
X-Forwarded-Encrypted: i=1; AJvYcCU03X6RVUtTPOQVanGOdlGS4Lao0A+yzAuFmRTJOXIJDBLGNKfbpHOGh7rSkcgQ66Fv6G+Ls8gIbwnBcqKCUmVzBfYDimdn53c4OHyZvPZG
X-Gm-Message-State: AOJu0YxVmrA9zYfBW2JUXIHiYa3hXg+uMIdwd3IwI9rsR80DwPrNgT0i
	2CQqfQgrAK7mj4ycWG+zFyRiv0nifb14qxDlHV0NXyQHup2/reBjiJt0xdKb3LZRNqLT+qDYWCW
	YChQViH4ttfh/E/2AGQ==
X-Google-Smtp-Source: AGHT+IHayFRCcCsOufeFd8eaD+LZvvSABNudK6ccp427lR+6//MCzL41ey0oGuHFJkkj5Se24qSRYhlBG5VXTugN
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:1248:b0:dcb:e982:4e40 with
 SMTP id 3f1490d57ef6-df7723fc9e6mr4213312276.12.1717005923815; Wed, 29 May
 2024 11:05:23 -0700 (PDT)
Date: Wed, 29 May 2024 18:05:10 +0000
In-Reply-To: <20240529180510.2295118-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240529180510.2295118-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240529180510.2295118-8-jthoughton@google.com>
Subject: [PATCH v4 7/7] KVM: selftests: Add multi-gen LRU aging to access_tracking_perf_test
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Ankit Agrawal <ankita@nvidia.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Huacai Chen <chenhuacai@kernel.org>, 
	James Houghton <jthoughton@google.com>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sean Christopherson <seanjc@google.com>, Shaoqin Huang <shahuang@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This test now has two modes of operation:
1. (default) To check how much vCPU performance was affected by access
             tracking (previously existed, now supports MGLRU aging).
2. (-p) To also benchmark how fast MGLRU can do aging while vCPUs are
        faulting in memory.

Mode (1) also serves as a way to verify that aging is working properly
for pages only accessed by KVM.  It will fail if one does not have the
0x8 lru_gen feature bit.

To support MGLRU, the test creates a memory cgroup, moves itself into
it, then uses the lru_gen debugfs output to track memory in that cgroup.
The logic to parse the lru_gen debugfs output has been put into
selftests/kvm/lib/lru_gen_util.c.

Co-developed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/access_tracking_perf_test.c | 365 ++++++++++++++--
 .../selftests/kvm/include/lru_gen_util.h      |  55 +++
 .../testing/selftests/kvm/lib/lru_gen_util.c  | 391 ++++++++++++++++++
 4 files changed, 782 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/lru_gen_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/lru_gen_util.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ce8ff8e8ce3a..86415f524c48 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -22,6 +22,7 @@ LIBKVM += lib/elf.c
 LIBKVM += lib/guest_modes.c
 LIBKVM += lib/io.c
 LIBKVM += lib/kvm_util.c
+LIBKVM += lib/lru_gen_util.c
 LIBKVM += lib/memstress.c
 LIBKVM += lib/guest_sprintf.c
 LIBKVM += lib/rbtree.c
diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
index 3c7defd34f56..15be99ff3bdc 100644
--- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
+++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
@@ -38,6 +38,7 @@
 #include <inttypes.h>
 #include <limits.h>
 #include <pthread.h>
+#include <stdio.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -47,6 +48,20 @@
 #include "memstress.h"
 #include "guest_modes.h"
 #include "processor.h"
+#include "lru_gen_util.h"
+
+static const char *TEST_MEMCG_NAME = "access_tracking_perf_test";
+static const int LRU_GEN_ENABLED = 0x1;
+static const int LRU_GEN_MM_WALK = 0x2;
+static const int LRU_GEN_SECONDARY_MMU_WALK = 0x8;
+static const char *CGROUP_PROCS = "cgroup.procs";
+/*
+ * If using MGLRU, this test assumes a cgroup v2 or cgroup v1 memory hierarchy
+ * is mounted at cgroup_root.
+ *
+ * Can be changed with -r.
+ */
+static const char *cgroup_root = "/sys/fs/cgroup";
 
 /* Global variable used to synchronize all of the vCPU threads. */
 static int iteration;
@@ -62,6 +77,9 @@ static enum {
 /* The iteration that was last completed by each vCPU. */
 static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
 
+/* The time at which the last iteration was completed */
+static struct timespec vcpu_last_completed_time[KVM_MAX_VCPUS];
+
 /* Whether to overlap the regions of memory vCPUs access. */
 static bool overlap_memory_access;
 
@@ -74,6 +92,12 @@ struct test_params {
 
 	/* The number of vCPUs to create in the VM. */
 	int nr_vcpus;
+
+	/* Whether to use lru_gen aging instead of idle page tracking. */
+	bool lru_gen;
+
+	/* Whether to test the performance of aging itself. */
+	bool benchmark_lru_gen;
 };
 
 static uint64_t pread_uint64(int fd, const char *filename, uint64_t index)
@@ -89,6 +113,50 @@ static uint64_t pread_uint64(int fd, const char *filename, uint64_t index)
 
 }
 
+static void write_file_long(const char *path, long v)
+{
+	FILE *f;
+
+	f = fopen(path, "w");
+	TEST_ASSERT(f, "fopen(%s) failed", path);
+	TEST_ASSERT(fprintf(f, "%ld\n", v) > 0,
+		    "fprintf to %s failed", path);
+	TEST_ASSERT(!fclose(f), "fclose(%s) failed", path);
+}
+
+static char *path_join(const char *parent, const char *child)
+{
+	char *out = NULL;
+
+	return asprintf(&out, "%s/%s", parent, child) >= 0 ? out : NULL;
+}
+
+static char *memcg_path(const char *memcg)
+{
+	return path_join(cgroup_root, memcg);
+}
+
+static char *memcg_file_path(const char *memcg, const char *file)
+{
+	char *mp = memcg_path(memcg);
+	char *fp;
+
+	if (!mp)
+		return NULL;
+	fp = path_join(mp, file);
+	free(mp);
+	return fp;
+}
+
+static void move_to_memcg(const char *memcg, pid_t pid)
+{
+	char *procs = memcg_file_path(memcg, CGROUP_PROCS);
+
+	TEST_ASSERT(procs, "Failed to construct cgroup.procs path");
+	write_file_long(procs, pid);
+	free(procs);
+}
+
 #define PAGEMAP_PRESENT (1ULL << 63)
 #define PAGEMAP_PFN_MASK ((1ULL << 55) - 1)
 
@@ -242,6 +310,8 @@ static void vcpu_thread_main(struct memstress_vcpu_args *vcpu_args)
 		};
 
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
+		clock_gettime(CLOCK_MONOTONIC,
+			      &vcpu_last_completed_time[vcpu_idx]);
 	}
 }
 
@@ -253,38 +323,68 @@ static void spin_wait_for_vcpu(int vcpu_idx, int target_iteration)
 	}
 }
 
+static bool all_vcpus_done(int target_iteration, int nr_vcpus)
+{
+	for (int i = 0; i < nr_vcpus; ++i)
+		if (READ_ONCE(vcpu_last_completed_iteration[i]) !=
+		    target_iteration)
+			return false;
+
+	return true;
+}
+
 /* The type of memory accesses to perform in the VM. */
 enum access_type {
 	ACCESS_READ,
 	ACCESS_WRITE,
 };
 
-static void run_iteration(struct kvm_vm *vm, int nr_vcpus, const char *description)
+static void run_iteration(struct kvm_vm *vm, int nr_vcpus, const char *description,
+			  bool wait)
 {
-	struct timespec ts_start;
-	struct timespec ts_elapsed;
 	int next_iteration, i;
 
 	/* Kick off the vCPUs by incrementing iteration. */
 	next_iteration = ++iteration;
 
-	clock_gettime(CLOCK_MONOTONIC, &ts_start);
-
 	/* Wait for all vCPUs to finish the iteration. */
-	for (i = 0; i < nr_vcpus; i++)
-		spin_wait_for_vcpu(i, next_iteration);
+	if (wait) {
+		struct timespec ts_start;
+		struct timespec ts_elapsed;
+
+		clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
-	ts_elapsed = timespec_elapsed(ts_start);
-	pr_info("%-30s: %ld.%09lds\n",
-		description, ts_elapsed.tv_sec, ts_elapsed.tv_nsec);
+		for (i = 0; i < nr_vcpus; i++)
+			spin_wait_for_vcpu(i, next_iteration);
+
+		ts_elapsed = timespec_elapsed(ts_start);
+
+		pr_info("%-30s: %ld.%09lds\n",
+			description, ts_elapsed.tv_sec, ts_elapsed.tv_nsec);
+	} else
+		pr_info("%-30s\n", description);
 }
 
-static void access_memory(struct kvm_vm *vm, int nr_vcpus,
-			  enum access_type access, const char *description)
+static void _access_memory(struct kvm_vm *vm, int nr_vcpus,
+			   enum access_type access, const char *description,
+			   bool wait)
 {
 	memstress_set_write_percent(vm, (access == ACCESS_READ) ? 0 : 100);
 	iteration_work = ITERATION_ACCESS_MEMORY;
-	run_iteration(vm, nr_vcpus, description);
+	run_iteration(vm, nr_vcpus, description, wait);
+}
+
+static void access_memory(struct kvm_vm *vm, int nr_vcpus,
+			  enum access_type access, const char *description)
+{
+	return _access_memory(vm, nr_vcpus, access, description, true);
+}
+
+static void access_memory_async(struct kvm_vm *vm, int nr_vcpus,
+				enum access_type access,
+				const char *description)
+{
+	return _access_memory(vm, nr_vcpus, access, description, false);
 }
 
 static void mark_memory_idle(struct kvm_vm *vm, int nr_vcpus)
@@ -297,19 +397,111 @@ static void mark_memory_idle(struct kvm_vm *vm, int nr_vcpus)
 	 */
 	pr_debug("Marking VM memory idle (slow)...\n");
 	iteration_work = ITERATION_MARK_IDLE;
-	run_iteration(vm, nr_vcpus, "Mark memory idle");
+	run_iteration(vm, nr_vcpus, "Mark memory idle", true);
 }
 
-static void run_test(enum vm_guest_mode mode, void *arg)
+static void create_memcg(const char *memcg)
+{
+	const char *full_memcg_path = memcg_path(memcg);
+	int ret;
+
+	TEST_ASSERT(full_memcg_path, "Failed to construct full memcg path");
+retry:
+	ret = mkdir(full_memcg_path, 0755);
+	if (ret && errno == EEXIST) {
+		TEST_ASSERT(!rmdir(full_memcg_path),
+			    "Found existing memcg at %s, but rmdir failed",
+			    full_memcg_path);
+		goto retry;
+	}
+	TEST_ASSERT(!ret, "Creating the memcg failed: mkdir(%s) failed",
+		    full_memcg_path);
+
+	pr_info("Created memcg at %s\n", full_memcg_path);
+}
+
+/*
+ * Test lru_gen aging speed while vCPUs are faulting memory in.
+ *
+ * This test will run lru_gen aging until the vCPUs have finished all of
+ * the faulting work, reporting:
+ *  - vcpu wall time (wall time for slowest vCPU)
+ *  - average aging pass duration
+ *  - total number of aging passes
+ *  - total time spent aging
+ *
+ * This test produces the most useful results when the vcpu wall time and the
+ * total time spent aging are similar (i.e., we want to avoid timing aging
+ * while the vCPUs aren't doing any work).
+ */
+static void run_benchmark(enum vm_guest_mode mode, struct kvm_vm *vm,
+			  struct test_params *params)
 {
-	struct test_params *params = arg;
-	struct kvm_vm *vm;
 	int nr_vcpus = params->nr_vcpus;
+	struct memcg_stats stats;
+	struct timespec ts_start, ts_max, ts_vcpus_elapsed,
+			ts_aging_elapsed, ts_aging_elapsed_avg;
+	int num_passes = 0;
 
-	vm = memstress_create_vm(mode, nr_vcpus, params->vcpu_memory_bytes, 1,
-				 params->backing_src, !overlap_memory_access);
+	printf("Running lru_gen benchmark...\n");
 
-	memstress_start_vcpu_threads(nr_vcpus, vcpu_thread_main);
+	clock_gettime(CLOCK_MONOTONIC, &ts_start);
+	access_memory_async(vm, nr_vcpus, ACCESS_WRITE,
+			    "Populating memory (async)");
+	while (!all_vcpus_done(iteration, nr_vcpus)) {
+		lru_gen_do_aging_quiet(&stats, TEST_MEMCG_NAME);
+		++num_passes;
+	}
+
+	ts_aging_elapsed = timespec_elapsed(ts_start);
+	ts_aging_elapsed_avg = timespec_div(ts_aging_elapsed, num_passes);
+
+	/* Find out when the slowest vCPU finished. */
+	ts_max = ts_start;
+	for (int i = 0; i < nr_vcpus; ++i) {
+		struct timespec *vcpu_ts = &vcpu_last_completed_time[i];
+
+		if (ts_max.tv_sec < vcpu_ts->tv_sec ||
+		    (ts_max.tv_sec == vcpu_ts->tv_sec  &&
+		     ts_max.tv_nsec < vcpu_ts->tv_nsec))
+			ts_max = *vcpu_ts;
+	}
+
+	ts_vcpus_elapsed = timespec_sub(ts_max, ts_start);
+
+	pr_info("%-30s: %ld.%09lds\n", "vcpu wall time",
+		ts_vcpus_elapsed.tv_sec, ts_vcpus_elapsed.tv_nsec);
+
+	pr_info("%-30s: %ld.%09lds, (passes:%d, total:%ld.%09lds)\n",
+		"lru_gen avg pass duration",
+		ts_aging_elapsed_avg.tv_sec,
+		ts_aging_elapsed_avg.tv_nsec,
+		num_passes,
+		ts_aging_elapsed.tv_sec,
+		ts_aging_elapsed.tv_nsec);
+}
+
+/*
+ * Test how much access tracking affects vCPU performance.
+ *
+ * Supports two modes of access tracking:
+ * - idle page tracking
+ * - lru_gen aging
+ *
+ * When using lru_gen, this test additionally verifies that the pages are in
+ * fact getting younger and older, otherwise the performance data would be
+ * invalid.
+ *
+ * The forced lru_gen aging can race with aging that occurs naturally.
+ */
+static void run_test(enum vm_guest_mode mode, struct kvm_vm *vm,
+		     struct test_params *params)
+{
+	int nr_vcpus = params->nr_vcpus;
+	bool lru_gen = params->lru_gen;
+	struct memcg_stats stats;
+	long total_pages = nr_vcpus * params->vcpu_memory_bytes / getpagesize();
+	int found_gens[5];
 
 	pr_info("\n");
 	access_memory(vm, nr_vcpus, ACCESS_WRITE, "Populating memory");
@@ -319,11 +511,83 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	access_memory(vm, nr_vcpus, ACCESS_READ, "Reading from populated memory");
 
 	/* Repeat on memory that has been marked as idle. */
-	mark_memory_idle(vm, nr_vcpus);
+	if (lru_gen) {
+		/* Do an initial page table scan */
+		lru_gen_do_aging(&stats, TEST_MEMCG_NAME);
+		TEST_ASSERT(sum_memcg_stats(&stats) >= total_pages,
+		  "Not all pages tracked in lru_gen stats.\n"
+		  "Is lru_gen enabled? Did the memcg get created properly?");
+
+		/* Find the generation we're currently in (probably youngest) */
+		found_gens[0] = lru_gen_find_generation(&stats, total_pages);
+
+		/* Do an aging pass now */
+		lru_gen_do_aging(&stats, TEST_MEMCG_NAME);
+
+		/* Same generation, but a newer generation has been made */
+		found_gens[1] = lru_gen_find_generation(&stats, total_pages);
+		TEST_ASSERT(found_gens[1] == found_gens[0],
+			    "unexpected gen change: %d vs. %d",
+			    found_gens[1], found_gens[0]);
+	} else
+		mark_memory_idle(vm, nr_vcpus);
+
 	access_memory(vm, nr_vcpus, ACCESS_WRITE, "Writing to idle memory");
-	mark_memory_idle(vm, nr_vcpus);
+
+	if (lru_gen) {
+		/* Scan the page tables again */
+		lru_gen_do_aging(&stats, TEST_MEMCG_NAME);
+
+		/* The pages should now be young again, so in a newer generation */
+		found_gens[2] = lru_gen_find_generation(&stats, total_pages);
+		TEST_ASSERT(found_gens[2] > found_gens[1],
+			    "pages did not get younger");
+
+		/* Do another aging pass */
+		lru_gen_do_aging(&stats, TEST_MEMCG_NAME);
+
+		/* Same generation; new generation has been made */
+		found_gens[3] = lru_gen_find_generation(&stats, total_pages);
+		TEST_ASSERT(found_gens[3] == found_gens[2],
+			    "unexpected gen change: %d vs. %d",
+			    found_gens[3], found_gens[2]);
+	} else
+		mark_memory_idle(vm, nr_vcpus);
+
 	access_memory(vm, nr_vcpus, ACCESS_READ, "Reading from idle memory");
 
+	if (lru_gen) {
+		/* Scan the pages tables again */
+		lru_gen_do_aging(&stats, TEST_MEMCG_NAME);
+
+		/* The pages should now be young again, so in a newer generation */
+		found_gens[4] = lru_gen_find_generation(&stats, total_pages);
+		TEST_ASSERT(found_gens[4] > found_gens[3],
+			    "pages did not get younger");
+	}
+}
+
+static void setup_vm_and_run(enum vm_guest_mode mode, void *arg)
+{
+	struct test_params *params = arg;
+	int nr_vcpus = params->nr_vcpus;
+	struct kvm_vm *vm;
+
+	if (params->lru_gen) {
+		create_memcg(TEST_MEMCG_NAME);
+		move_to_memcg(TEST_MEMCG_NAME, getpid());
+	}
+
+	vm = memstress_create_vm(mode, nr_vcpus, params->vcpu_memory_bytes, 1,
+				 params->backing_src, !overlap_memory_access);
+
+	memstress_start_vcpu_threads(nr_vcpus, vcpu_thread_main);
+
+	if (params->benchmark_lru_gen)
+		run_benchmark(mode, vm, params);
+	else
+		run_test(mode, vm, params);
+
 	memstress_join_vcpu_threads(nr_vcpus);
 	memstress_destroy_vm(vm);
 }
@@ -331,8 +595,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-b vcpu_bytes] [-v vcpus] [-o]  [-s mem_type]\n",
-	       name);
+	printf("usage: %s [-h] [-m mode] [-b vcpu_bytes] [-v vcpus] [-o]"
+	       " [-s mem_type] [-l] [-r memcg_root]\n", name);
 	puts("");
 	printf(" -h: Display this help message.");
 	guest_modes_help();
@@ -342,6 +606,9 @@ static void help(char *name)
 	printf(" -v: specify the number of vCPUs to run.\n");
 	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
 	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -l: Use MGLRU aging instead of idle page tracking\n");
+	printf(" -p: Benchmark MGLRU aging while faulting memory in\n");
+	printf(" -r: The memory cgroup hierarchy root to use (when -l is given)\n");
 	backing_src_help("-s");
 	puts("");
 	exit(0);
@@ -353,13 +620,15 @@ int main(int argc, char *argv[])
 		.backing_src = DEFAULT_VM_MEM_SRC,
 		.vcpu_memory_bytes = DEFAULT_PER_VCPU_MEM_SIZE,
 		.nr_vcpus = 1,
+		.lru_gen = false,
+		.benchmark_lru_gen = false,
 	};
 	int page_idle_fd;
 	int opt;
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:b:v:os:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:b:v:os:lr:p")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -376,6 +645,15 @@ int main(int argc, char *argv[])
 		case 's':
 			params.backing_src = parse_backing_src_type(optarg);
 			break;
+		case 'l':
+			params.lru_gen = true;
+			break;
+		case 'p':
+			params.benchmark_lru_gen = true;
+			break;
+		case 'r':
+			cgroup_root = strdup(optarg);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -383,12 +661,39 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	page_idle_fd = open("/sys/kernel/mm/page_idle/bitmap", O_RDWR);
-	__TEST_REQUIRE(page_idle_fd >= 0,
-		       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
-	close(page_idle_fd);
+	if (!params.lru_gen) {
+		page_idle_fd = open("/sys/kernel/mm/page_idle/bitmap", O_RDWR);
+		__TEST_REQUIRE(page_idle_fd >= 0,
+			       "CONFIG_IDLE_PAGE_TRACKING is not enabled");
+		close(page_idle_fd);
+	} else {
+		int lru_gen_fd, lru_gen_debug_fd;
+		long mglru_features;
+		char mglru_feature_str[8] = {};
+
+		lru_gen_fd = open("/sys/kernel/mm/lru_gen/enabled", O_RDONLY);
+		__TEST_REQUIRE(lru_gen_fd >= 0,
+			       "CONFIG_LRU_GEN is not enabled");
+		TEST_ASSERT(read(lru_gen_fd, &mglru_feature_str, 7) > 0,
+				 "couldn't read lru_gen features");
+		mglru_features = strtol(mglru_feature_str, NULL, 16);
+		__TEST_REQUIRE(mglru_features & LRU_GEN_ENABLED,
+			       "lru_gen is not enabled");
+		__TEST_REQUIRE(mglru_features & LRU_GEN_MM_WALK,
+			       "lru_gen does not support MM_WALK");
+		__TEST_REQUIRE(mglru_features & LRU_GEN_SECONDARY_MMU_WALK,
+			       "lru_gen does not support SECONDARY_MMU_WALK");
+
+		lru_gen_debug_fd = open(DEBUGFS_LRU_GEN, O_RDWR);
+		__TEST_REQUIRE(lru_gen_debug_fd >= 0,
+				"Cannot access %s", DEBUGFS_LRU_GEN);
+		close(lru_gen_debug_fd);
+	}
+
+	TEST_ASSERT(!params.benchmark_lru_gen || params.lru_gen,
+		    "-p specified without -l");
 
-	for_each_guest_mode(run_test, &params);
+	for_each_guest_mode(setup_vm_and_run, &params);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/include/lru_gen_util.h b/tools/testing/selftests/kvm/include/lru_gen_util.h
new file mode 100644
index 000000000000..4eef8085a3cb
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/lru_gen_util.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Tools for integrating with lru_gen, like parsing the lru_gen debugfs output.
+ *
+ * Copyright (C) 2024, Google LLC.
+ */
+#ifndef SELFTEST_KVM_LRU_GEN_UTIL_H
+#define SELFTEST_KVM_LRU_GEN_UTIL_H
+
+#include <inttypes.h>
+#include <limits.h>
+#include <stdlib.h>
+
+#include "test_util.h"
+
+#define MAX_NR_GENS 16 /* MAX_NR_GENS in include/linux/mmzone.h */
+#define MAX_NR_NODES 4 /* Maximum number of nodes we support */
+
+static const char *DEBUGFS_LRU_GEN = "/sys/kernel/debug/lru_gen";
+
+struct generation_stats {
+	int gen;
+	long age_ms;
+	long nr_anon;
+	long nr_file;
+};
+
+struct node_stats {
+	int node;
+	int nr_gens; /* Number of populated gens entries. */
+	struct generation_stats gens[MAX_NR_GENS];
+};
+
+struct memcg_stats {
+	unsigned long memcg_id;
+	int nr_nodes; /* Number of populated nodes entries. */
+	struct node_stats nodes[MAX_NR_NODES];
+};
+
+void print_memcg_stats(const struct memcg_stats *stats, const char *name);
+
+void read_memcg_stats(struct memcg_stats *stats, const char *memcg);
+
+void read_print_memcg_stats(struct memcg_stats *stats, const char *memcg);
+
+long sum_memcg_stats(const struct memcg_stats *stats);
+
+void lru_gen_do_aging(struct memcg_stats *stats, const char *memcg);
+
+void lru_gen_do_aging_quiet(struct memcg_stats *stats, const char *memcg);
+
+int lru_gen_find_generation(const struct memcg_stats *stats,
+			    unsigned long total_pages);
+
+#endif /* SELFTEST_KVM_LRU_GEN_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/lru_gen_util.c b/tools/testing/selftests/kvm/lib/lru_gen_util.c
new file mode 100644
index 000000000000..3c02a635a9f7
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/lru_gen_util.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024, Google LLC.
+ */
+
+#include <time.h>
+
+#include "lru_gen_util.h"
+
+/*
+ * Tracks state while we parse memcg lru_gen stats. The file we're parsing is
+ * structured like this (some extra whitespace elided):
+ *
+ * memcg (id) (path)
+ * node (id)
+ * (gen_nr) (age_in_ms) (nr_anon_pages) (nr_file_pages)
+ */
+struct memcg_stats_parse_context {
+	bool consumed; /* Whether or not this line was consumed */
+	/* Next parse handler to invoke */
+	void (*next_handler)(struct memcg_stats *,
+			     struct memcg_stats_parse_context *, char *);
+	int current_node_idx; /* Current index in nodes array */
+	const char *name; /* The name of the memcg we're looking for */
+};
+
+static void memcg_stats_handle_searching(struct memcg_stats *stats,
+					 struct memcg_stats_parse_context *ctx,
+					 char *line);
+static void memcg_stats_handle_in_memcg(struct memcg_stats *stats,
+					struct memcg_stats_parse_context *ctx,
+					char *line);
+static void memcg_stats_handle_in_node(struct memcg_stats *stats,
+				       struct memcg_stats_parse_context *ctx,
+				       char *line);
+
+struct split_iterator {
+	char *str;
+	char *save;
+};
+
+static char *split_next(struct split_iterator *it)
+{
+	char *ret = strtok_r(it->str, " \t\n\r", &it->save);
+
+	it->str = NULL;
+	return ret;
+}
+
+static void memcg_stats_handle_searching(struct memcg_stats *stats,
+					 struct memcg_stats_parse_context *ctx,
+					 char *line)
+{
+	struct split_iterator it = { .str = line };
+	char *prefix = split_next(&it);
+	char *memcg_id = split_next(&it);
+	char *memcg_name = split_next(&it);
+	char *end;
+
+	ctx->consumed = true;
+
+	if (!prefix || strcmp("memcg", prefix))
+		return; /* Not a memcg line (maybe empty), skip */
+
+	TEST_ASSERT(memcg_id && memcg_name,
+		    "malformed memcg line; no memcg id or memcg_name");
+
+	if (strcmp(memcg_name + 1, ctx->name))
+		return; /* Wrong memcg, skip */
+
+	/* Found it! */
+
+	stats->memcg_id = strtoul(memcg_id, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed memcg id '%s'", memcg_id);
+	if (!stats->memcg_id)
+		return; /* Removed memcg? */
+
+	ctx->next_handler = memcg_stats_handle_in_memcg;
+}
+
+static void memcg_stats_handle_in_memcg(struct memcg_stats *stats,
+					struct memcg_stats_parse_context *ctx,
+					char *line)
+{
+	struct split_iterator it = { .str = line };
+	char *prefix = split_next(&it);
+	char *id = split_next(&it);
+	long found_node_id;
+	char *end;
+
+	ctx->consumed = true;
+	ctx->current_node_idx = -1;
+
+	if (!prefix)
+		return; /* Skip empty lines */
+
+	if (!strcmp("memcg", prefix)) {
+		/* Memcg done, found next one; stop. */
+		ctx->next_handler = NULL;
+		return;
+	} else if (strcmp("node", prefix))
+		TEST_ASSERT(false, "found malformed line after 'memcg ...',"
+				   "token: '%s'", prefix);
+
+	/* At this point we know we have a node line. Parse the ID. */
+
+	TEST_ASSERT(id, "malformed node line; no node id");
+
+	found_node_id = strtol(id, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed node id '%s'", id);
+
+	ctx->current_node_idx = stats->nr_nodes++;
+	TEST_ASSERT(ctx->current_node_idx < MAX_NR_NODES,
+		    "memcg has stats for too many nodes, max is %d",
+		    MAX_NR_NODES);
+	stats->nodes[ctx->current_node_idx].node = found_node_id;
+
+	ctx->next_handler = memcg_stats_handle_in_node;
+}
+
+static void memcg_stats_handle_in_node(struct memcg_stats *stats,
+				       struct memcg_stats_parse_context *ctx,
+				       char *line)
+{
+	/* Have to copy since we might not consume */
+	char *my_line = strdup(line);
+	struct split_iterator it = { .str = my_line };
+	char *gen, *age, *nr_anon, *nr_file;
+	struct node_stats *node_stats;
+	struct generation_stats *gen_stats;
+	char *end;
+
+	TEST_ASSERT(it.str, "failed to copy input line");
+
+	gen = split_next(&it);
+
+	/* Skip empty lines */
+	if (!gen)
+		goto out_consume; /* Skip empty lines */
+
+	if (!strcmp("memcg", gen) || !strcmp("node", gen)) {
+		/*
+		 * Reached next memcg or node section. Don't consume, let the
+		 * other handler deal with this.
+		 */
+		ctx->next_handler = memcg_stats_handle_in_memcg;
+		goto out;
+	}
+
+	node_stats = &stats->nodes[ctx->current_node_idx];
+	TEST_ASSERT(node_stats->nr_gens < MAX_NR_GENS,
+		    "found too many generation lines; max is %d",
+		    MAX_NR_GENS);
+	gen_stats = &node_stats->gens[node_stats->nr_gens++];
+
+	age = split_next(&it);
+	nr_anon = split_next(&it);
+	nr_file = split_next(&it);
+
+	TEST_ASSERT(age && nr_anon && nr_file,
+		    "malformed generation line; not enough tokens");
+
+	gen_stats->gen = (int)strtol(gen, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed generation number '%s'", gen);
+
+	gen_stats->age_ms = strtol(age, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed generation age '%s'", age);
+
+	gen_stats->nr_anon = strtol(nr_anon, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed anonymous page count '%s'",
+		    nr_anon);
+
+	gen_stats->nr_file = strtol(nr_file, &end, 10);
+	TEST_ASSERT(*end == '\0', "malformed file page count '%s'", nr_file);
+
+out_consume:
+	ctx->consumed = true;
+out:
+	free(my_line);
+}
+
+/* Pretty-print lru_gen @stats. */
+void print_memcg_stats(const struct memcg_stats *stats, const char *name)
+{
+	int node, gen;
+
+	fprintf(stderr, "stats for memcg %s (id %lu):\n",
+			name, stats->memcg_id);
+	for (node = 0; node < stats->nr_nodes; ++node) {
+		fprintf(stderr, "\tnode %d\n", stats->nodes[node].node);
+		for (gen = 0; gen < stats->nodes[node].nr_gens; ++gen) {
+			const struct generation_stats *gstats =
+				&stats->nodes[node].gens[gen];
+
+			fprintf(stderr,
+				"\t\tgen %d\tage_ms %ld"
+				"\tnr_anon %ld\tnr_file %ld\n",
+				gstats->gen, gstats->age_ms, gstats->nr_anon,
+				gstats->nr_file);
+		}
+	}
+}
+
+/* Re-read lru_gen debugfs information for @memcg into @stats. */
+void read_memcg_stats(struct memcg_stats *stats, const char *memcg)
+{
+	FILE *f;
+	ssize_t read = 0;
+	char *line = NULL;
+	size_t bufsz;
+	struct memcg_stats_parse_context ctx = {
+		.next_handler = memcg_stats_handle_searching,
+		.name = memcg,
+	};
+
+	memset(stats, 0, sizeof(struct memcg_stats));
+
+	f = fopen(DEBUGFS_LRU_GEN, "r");
+	TEST_ASSERT(f, "fopen(%s) failed", DEBUGFS_LRU_GEN);
+
+	while (ctx.next_handler && (read = getline(&line, &bufsz, f)) > 0) {
+		ctx.consumed = false;
+
+		do {
+			ctx.next_handler(stats, &ctx, line);
+			if (!ctx.next_handler)
+				break;
+		} while (!ctx.consumed);
+	}
+
+	if (read < 0 && !feof(f))
+		TEST_ASSERT(false, "getline(%s) failed", DEBUGFS_LRU_GEN);
+
+	TEST_ASSERT(stats->memcg_id > 0, "Couldn't find memcg: %s\n"
+		    "Did the memcg get created in the proper mount?",
+		    memcg);
+	if (line)
+		free(line);
+	TEST_ASSERT(!fclose(f), "fclose(%s) failed", DEBUGFS_LRU_GEN);
+}
+
+/*
+ * Find all pages tracked by lru_gen for this memcg in generation @target_gen.
+ *
+ * If @target_gen is negative, look for all generations.
+ */
+static long sum_memcg_stats_for_gen(int target_gen,
+				    const struct memcg_stats *stats)
+{
+	int node, gen;
+	long total_nr = 0;
+
+	for (node = 0; node < stats->nr_nodes; ++node) {
+		const struct node_stats *node_stats = &stats->nodes[node];
+
+		for (gen = 0; gen < node_stats->nr_gens; ++gen) {
+			const struct generation_stats *gen_stats =
+				&node_stats->gens[gen];
+
+			if (target_gen >= 0 && gen_stats->gen != target_gen)
+				continue;
+
+			total_nr += gen_stats->nr_anon + gen_stats->nr_file;
+		}
+	}
+
+	return total_nr;
+}
+
+/* Find all pages tracked by lru_gen for this memcg. */
+long sum_memcg_stats(const struct memcg_stats *stats)
+{
+	return sum_memcg_stats_for_gen(-1, stats);
+}
+
+/* Read the memcg stats and optionally print if this is a debug build. */
+void read_print_memcg_stats(struct memcg_stats *stats, const char *memcg)
+{
+	read_memcg_stats(stats, memcg);
+#ifdef DEBUG
+	print_memcg_stats(stats, memcg);
+#endif
+}
+
+/*
+ * If lru_gen aging should force page table scanning.
+ *
+ * If you want to set this to false, you will need to do eviction
+ * before doing extra aging passes.
+ */
+static const bool force_scan = true;
+
+static void run_aging_impl(unsigned long memcg_id, int node_id, int max_gen)
+{
+	FILE *f = fopen(DEBUGFS_LRU_GEN, "w");
+	char *command;
+	size_t sz;
+
+	TEST_ASSERT(f, "fopen(%s) failed", DEBUGFS_LRU_GEN);
+	sz = asprintf(&command, "+ %lu %d %d 1 %d\n",
+		      memcg_id, node_id, max_gen, force_scan);
+	TEST_ASSERT(sz > 0, "creating aging command failed");
+
+	pr_debug("Running aging command: %s", command);
+	if (fwrite(command, sizeof(char), sz, f) < sz) {
+		TEST_ASSERT(false, "writing aging command %s to %s failed",
+			    command, DEBUGFS_LRU_GEN);
+	}
+
+	TEST_ASSERT(!fclose(f), "fclose(%s) failed", DEBUGFS_LRU_GEN);
+}
+
+static void _lru_gen_do_aging(struct memcg_stats *stats, const char *memcg,
+			      bool verbose)
+{
+	int node, gen;
+	struct timespec ts_start;
+	struct timespec ts_elapsed;
+
+	pr_debug("lru_gen: invoking aging...\n");
+
+	/* Must read memcg stats to construct the proper aging command. */
+	read_print_memcg_stats(stats, memcg);
+
+	if (verbose)
+		clock_gettime(CLOCK_MONOTONIC, &ts_start);
+
+	for (node = 0; node < stats->nr_nodes; ++node) {
+		int max_gen = 0;
+
+		for (gen = 0; gen < stats->nodes[node].nr_gens; ++gen) {
+			int this_gen = stats->nodes[node].gens[gen].gen;
+
+			max_gen = max_gen > this_gen ? max_gen : this_gen;
+		}
+
+		run_aging_impl(stats->memcg_id, stats->nodes[node].node,
+			       max_gen);
+	}
+
+	if (verbose) {
+		ts_elapsed = timespec_elapsed(ts_start);
+		pr_info("%-30s: %ld.%09lds\n", "lru_gen: Aging",
+			ts_elapsed.tv_sec, ts_elapsed.tv_nsec);
+	}
+
+	/* Re-read so callers get updated information */
+	read_print_memcg_stats(stats, memcg);
+}
+
+/* Do aging, and print how long it took. */
+void lru_gen_do_aging(struct memcg_stats *stats, const char *memcg)
+{
+	return _lru_gen_do_aging(stats, memcg, true);
+}
+
+/* Do aging, don't print anything. */
+void lru_gen_do_aging_quiet(struct memcg_stats *stats, const char *memcg)
+{
+	return _lru_gen_do_aging(stats, memcg, false);
+}
+
+/*
+ * Find which generation contains more than half of @total_pages, assuming that
+ * such a generation exists.
+ */
+int lru_gen_find_generation(const struct memcg_stats *stats,
+			    unsigned long total_pages)
+{
+	int node, gen, gen_idx, min_gen = INT_MAX, max_gen = -1;
+
+	for (node = 0; node < stats->nr_nodes; ++node)
+		for (gen_idx = 0; gen_idx < stats->nodes[node].nr_gens;
+		     ++gen_idx) {
+			gen = stats->nodes[node].gens[gen_idx].gen;
+			max_gen = gen > max_gen ? gen : max_gen;
+			min_gen = gen < min_gen ? gen : min_gen;
+		}
+
+	for (gen = min_gen; gen < max_gen; ++gen)
+		/* See if the most pages are in this generation. */
+		if (sum_memcg_stats_for_gen(gen, stats) >
+				total_pages / 2)
+			return gen;
+
+	TEST_ASSERT(false, "No generation includes majority of %lu pages.",
+		    total_pages);
+
+	/* unreachable, but make the compiler happy */
+	return -1;
+}
-- 
2.45.1.288.g0e0cd299f1-goog


