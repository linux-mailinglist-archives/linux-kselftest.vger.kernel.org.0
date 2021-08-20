Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDE3F36C5
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Aug 2021 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhHTWvQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 18:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbhHTWvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 18:51:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AE2C061760
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m66-20020a257145000000b00598282d96ceso4549910ybc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Hob1dmJMrw94HSjTjJyO7V/z3K389Z6kceuVVvWteEg=;
        b=ZBPi0uJzte5sV+sLJPV9xwjqxEWGEetp8xrdF8k54k/wc3cJN67VgOhUhjKmKQ4Xhd
         YqdQSUKFPYacTLIBn+m+Gpa7jzLVqyIiKc5ijD3DiDu8v4DLcG3UldH9EAJ+m5ExOzrL
         O9ISw4lQ5FhzsoHmconTDOnb4joYqyvZ/niIJc3XkIo2bAKvQrwzQnUpMTk9YgBiDKRd
         dq/pHixNezQy4KZymANBRBoW1GxOCTFLow8hIjYvjzXPqasXApGiLjIE1l6UWAluDTZn
         kKovOEM7RvHsvBfgpkcVrSEeKDhfS15FlFRJF+Kn+3xtB+5p+YZ+b3m0NahrfffdwBHk
         Myuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Hob1dmJMrw94HSjTjJyO7V/z3K389Z6kceuVVvWteEg=;
        b=OsUnX1k1VW4dyU2RnFcyM6Mb241sEtuiDuemQQuI56Bc0QvPB7CsmOxD1Tjh8CoOv2
         B7YgbQi6pWPeJQjx+xJadjagJVZWdHvAq8LYvo9a6tpe5boqls5ri6Y6LcDUnO0FvT9+
         qV8ZtloGM+gtwimxOjebORgAV2gkuAuPoov6fhzBUo6IVvuQOV793qYMkO+jpw2+ozaQ
         gFc+OuedoXlZRPtiLhGgirXqczCkhgzCgoZdpfNi/zYOjfceAy79WNgIHBUw8OEPNe6d
         FEESpfF3ZdEniUBf/YWBQ3BkSl+HXjBFTwzdQjjgUnd7Y+xKEAaVSMfCREJziFumh9wa
         nENQ==
X-Gm-Message-State: AOAM533d23Dj7waN+avivEc0EHxUMMQvGCWChqxDUb2cJub0cBXUVcxk
        AIEXhv+6C4KDsxxhn9H1KRbLdWIJl58=
X-Google-Smtp-Source: ABdhPJxecYCoriXfTjXSBq3bkWOC7Zv8YgYOW9njfOH3mosyAnU4b5iytiV5UE6gH7mGyPMEYVj2u6gPToc=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f11d:a281:af9b:5de6])
 (user=seanjc job=sendgmr) by 2002:a25:3bcb:: with SMTP id i194mr27272983yba.442.1629499833270;
 Fri, 20 Aug 2021 15:50:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 20 Aug 2021 15:50:01 -0700
In-Reply-To: <20210820225002.310652-1-seanjc@google.com>
Message-Id: <20210820225002.310652-5-seanjc@google.com>
Mime-Version: 1.0
References: <20210820225002.310652-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to detect
 task migration bugs
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test to verify an rseq's CPU ID is updated correctly if the task is
migrated while the kernel is handling KVM_RUN.  This is a regression test
for a bug introduced by commit 72c3c0fe54a3 ("x86/kvm: Use generic xfer
to guest work function"), where TIF_NOTIFY_RESUME would be cleared by KVM
without updating rseq, leading to a stale CPU ID and other badness.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/.gitignore  |   1 +
 tools/testing/selftests/kvm/Makefile    |   3 +
 tools/testing/selftests/kvm/rseq_test.c | 154 ++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/rseq_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 0709af0144c8..6d031ff6b68e 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -47,6 +47,7 @@
 /kvm_page_table_test
 /memslot_modification_stress_test
 /memslot_perf_test
+/rseq_test
 /set_memory_region_test
 /steal_time
 /kvm_binary_stats_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 5832f510a16c..0756e79cb513 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -80,6 +80,7 @@ TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += kvm_page_table_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
+TEST_GEN_PROGS_x86_64 += rseq_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
@@ -92,6 +93,7 @@ TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
+TEST_GEN_PROGS_aarch64 += rseq_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
 TEST_GEN_PROGS_aarch64 += kvm_binary_stats_test
@@ -103,6 +105,7 @@ TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += kvm_page_table_test
+TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
new file mode 100644
index 000000000000..d28d7ba1a64a
--- /dev/null
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <syscall.h>
+#include <sys/ioctl.h>
+#include <asm/atomic.h>
+#include <asm/barrier.h>
+#include <linux/rseq.h>
+#include <linux/unistd.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define VCPU_ID 0
+
+static __thread volatile struct rseq __rseq = {
+	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+};
+
+#define RSEQ_SIG 0xdeadbeef
+
+static pthread_t migration_thread;
+static cpu_set_t possible_mask;
+static bool done;
+
+static atomic_t seq_cnt;
+
+static void guest_code(void)
+{
+	for (;;)
+		GUEST_SYNC(0);
+}
+
+static void sys_rseq(int flags)
+{
+	int r;
+
+	r = syscall(__NR_rseq, &__rseq, sizeof(__rseq), flags, RSEQ_SIG);
+	TEST_ASSERT(!r, "rseq failed, errno = %d (%s)", errno, strerror(errno));
+}
+
+static void *migration_worker(void *ign)
+{
+	cpu_set_t allowed_mask;
+	int r, i, nr_cpus, cpu;
+
+	CPU_ZERO(&allowed_mask);
+
+	nr_cpus = CPU_COUNT(&possible_mask);
+
+	for (i = 0; i < 20000; i++) {
+		cpu = i % nr_cpus;
+		if (!CPU_ISSET(cpu, &possible_mask))
+			continue;
+
+		CPU_SET(cpu, &allowed_mask);
+
+		/*
+		 * Bump the sequence count twice to allow the reader to detect
+		 * that a migration may have occurred in between rseq and sched
+		 * CPU ID reads.  An odd sequence count indicates a migration
+		 * is in-progress, while a completely different count indicates
+		 * a migration occurred since the count was last read.
+		 */
+		atomic_inc(&seq_cnt);
+		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
+		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
+			    errno, strerror(errno));
+		atomic_inc(&seq_cnt);
+
+		CPU_CLR(cpu, &allowed_mask);
+
+		/*
+		 * Let the read-side get back into KVM_RUN to improve the odds
+		 * of task migration coinciding with KVM's run loop.
+		 */
+		usleep(1);
+	}
+	done = true;
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	u32 cpu, rseq_cpu;
+	int r, snapshot;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
+	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
+		    strerror(errno));
+
+	if (CPU_COUNT(&possible_mask) < 2) {
+		print_skip("Only one CPU, task migration not possible\n");
+		exit(KSFT_SKIP);
+	}
+
+	sys_rseq(0);
+
+	/*
+	 * Create and run a dummy VM that immediately exits to userspace via
+	 * GUEST_SYNC, while concurrently migrating the process by setting its
+	 * CPU affinity.
+	 */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+	pthread_create(&migration_thread, NULL, migration_worker, 0);
+
+	while (!done) {
+		vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
+			    "Guest failed?");
+
+		/*
+		 * Verify rseq's CPU matches sched's CPU.  Ensure migration
+		 * doesn't occur between sched_getcpu() and reading the rseq
+		 * cpu_id by rereading both if the sequence count changes, or
+		 * if the count is odd (migration in-progress).
+		 */
+		do {
+			/*
+			 * Drop bit 0 to force a mismatch if the count is odd,
+			 * i.e. if a migration is in-progress.
+			 */
+			snapshot = atomic_read(&seq_cnt) & ~1;
+			smp_rmb();
+			cpu = sched_getcpu();
+			rseq_cpu = READ_ONCE(__rseq.cpu_id);
+			smp_rmb();
+		} while (snapshot != atomic_read(&seq_cnt));
+
+		TEST_ASSERT(rseq_cpu == cpu,
+			    "rseq CPU = %d, sched CPU = %d\n", rseq_cpu, cpu);
+	}
+
+	pthread_join(migration_thread, NULL);
+
+	kvm_vm_free(vm);
+
+	sys_rseq(RSEQ_FLAG_UNREGISTER);
+
+	return 0;
+}
-- 
2.33.0.rc2.250.ged5fa647cd-goog

