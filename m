Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A5431A8AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Feb 2021 01:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhBMAQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Feb 2021 19:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhBMAQF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Feb 2021 19:16:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9530DC0613D6
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Feb 2021 16:15:11 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id n2so1048636plc.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Feb 2021 16:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LFYECqnkpVnS9ezPEnkkGsIKGemq65IEfeP4v4FCXC0=;
        b=MNJaPCb6kCwQDqWE0VHDBWLh/jpZooOs4BybtKx0hSsGmWH2dSznyNmvm+qKf3ZdsL
         BvMMcNNILVaCUuAysU3V9NkNcV5Vfk0XUYnuvkpqedOgOwQMSzUmaqfPG9CI8pzG4Yk+
         pcYbLHCV0CPfWXhXiURTZR2eoW+EFlReBpX8ob392Cr0s6wfzsq4+S16MBcEfPA2gM7q
         32C/aYhTo0QEE75SU4pjwqlyrMNmbuxe+DBeNmlkudmt+sB7cMOveagRIJ1+4LGL1Sdl
         NwCfB46R+51EH50MjffcfFu5WNbGWqkcHD1TLQ0LUVrLfVbU2J1DFq33Z2s8kz+B2C7N
         5qSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LFYECqnkpVnS9ezPEnkkGsIKGemq65IEfeP4v4FCXC0=;
        b=ZFliUc7KAscMzWSXZqJTr1kqPZRoQG/JDhxYsIpQ2y8mJGYmpFwQ1Z05Ji0cYWyC6p
         sGMOFyFoj+ew0wrQqbWMLxY41t+9T1qGf4Yigwm+8rOSo8qm8+erKsL/k+jd7hf4RFRB
         PPtsPxMVTg9h4XG8n6aQzHOF+BBSWAgE5xhDIp9Fh7/H8Me4fYHUF7gW4cmPqSGYDA9I
         +AnZtjBy9TmLGCAJ2LJ6WCbOpboxlRqCxdUIiF0Zbzej7SNJ/rG0nfOM1o8Yu9eYojmE
         DaKXECQvB3QxxgrIoncQZV2RwYGh4ivQj3qLJHXraxZxia6NbAgUsNz+g+YUT/LuOEnC
         20sQ==
X-Gm-Message-State: AOAM532Jl5IvgztSRCqMSvqUygyNhWFFo06c1XBec6x//i7mugVs8NxH
        CCXkiZ8DPnd+zbbANNCho82yIU1LGZWN
X-Google-Smtp-Source: ABdhPJwK7FIiWqa0ahuLvd8FzrmfmaE3R47CXzIOG11ep2x3akfjtG1jGl1a3i/2TYw6gn210AVTmbmdlvYN
Sender: "marcorr via sendgmr" <marcorr@marcorr-sp.c.googlers.com>
X-Received: from marcorr-sp.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:e50])
 (user=marcorr job=sendgmr) by 2002:aa7:86d8:0:b029:1b5:1121:729a with SMTP id
 h24-20020aa786d80000b02901b51121729amr5213353pfo.57.1613175310890; Fri, 12
 Feb 2021 16:15:10 -0800 (PST)
Date:   Sat, 13 Feb 2021 00:14:52 +0000
Message-Id: <20210213001452.1719001-1-marcorr@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] selftests: kvm: add hardware_disable test
From:   Marc Orr <marcorr@google.com>
To:     ikalvarado@google.com, pbonzini@redhat.com, huah@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, jmattson@google.com
Cc:     Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ignacio Alvarado <ikalvarado@google.com>

This test launches 512 VMs in serial and kills them after a random
amount of time.

The test was original written to exercise KVM user notifiers in
the context of1650b4ebc99d:
- KVM: Disable irq while unregistering user notifier
- https://lore.kernel.org/kvm/CACXrx53vkO=HKfwWwk+fVpvxcNjPrYmtDZ10qWxFvVX_PTGp3g@mail.gmail.com/

Recently, this test piqued my interest because it proved useful to
for AMD SNP in exercising the "in-use" pages, described in APM section
15.36.12, "Running SNP-Active Virtual Machines".

To run the test, first compile:
$ make "CPPFLAGS=-static -Wl,--whole-archive -lpthread -Wl,--no-whole-archive" \
    -C tools/testing/selftests/kvm/

Then, copy the test over to a machine with the kernel and run:
$ ./hardware_disable_test

Signed-off-by: Ignacio Alvarado <ikalvarado@google.com>
Signed-off-by: Marc Orr <marcorr@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/hardware_disable_test.c     | 165 ++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/hardware_disable_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index ce8f4ad39684..d631e111441a 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -28,6 +28,7 @@
 /demand_paging_test
 /dirty_log_test
 /dirty_log_perf_test
+/hardware_disable_test
 /kvm_create_max_vcpus
 /set_memory_region_test
 /steal_time
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index fe41c6a0fa67..c1c403d878f6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -62,6 +62,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
+TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
new file mode 100644
index 000000000000..2f2eeb8a1d86
--- /dev/null
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This test is intended to reproduce a crash that happens when
+ * kvm_arch_hardware_disable is called and it attempts to unregister the user
+ * return notifiers.
+ */
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <pthread.h>
+#include <semaphore.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include <test_util.h>
+
+#include "kvm_util.h"
+
+#define VCPU_NUM 4
+#define SLEEPING_THREAD_NUM (1 << 4)
+#define FORK_NUM (1ULL << 9)
+#define DELAY_US_MAX 2000
+#define GUEST_CODE_PIO_PORT 4
+
+sem_t *sem;
+
+/* Arguments for the pthreads */
+struct payload {
+	struct kvm_vm *vm;
+	uint32_t index;
+};
+
+static void guest_code(void)
+{
+	for (;;)
+		;  /* Some busy work */
+	printf("Should not be reached.\n");
+}
+
+static void *run_vcpu(void *arg)
+{
+	struct payload *payload = (struct payload *)arg;
+	struct kvm_run *state = vcpu_state(payload->vm, payload->index);
+
+	vcpu_run(payload->vm, payload->index);
+
+	TEST_ASSERT(false, "%s: exited with reason %d: %s\n",
+		    __func__, state->exit_reason,
+		    exit_reason_str(state->exit_reason));
+	pthread_exit(NULL);
+}
+
+static void *sleeping_thread(void *arg)
+{
+	int fd;
+
+	while (true) {
+		fd = open("/dev/null", O_RDWR);
+		close(fd);
+	}
+	TEST_ASSERT(false, "%s: exited\n", __func__);
+	pthread_exit(NULL);
+}
+
+static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
+				       void *(*f)(void *), void *arg)
+{
+	int r;
+
+	r = pthread_create(thread, attr, f, arg);
+	TEST_ASSERT(r == 0, "%s: failed to create thread", __func__);
+}
+
+static inline void check_set_affinity(pthread_t thread, cpu_set_t *cpu_set)
+{
+	int r;
+
+	r = pthread_setaffinity_np(thread, sizeof(cpu_set_t), cpu_set);
+	TEST_ASSERT(r == 0, "%s: failed set affinity", __func__);
+}
+
+static inline void check_join(pthread_t thread, void **retval)
+{
+	int r;
+
+	r = pthread_join(thread, retval);
+	TEST_ASSERT(r == 0, "%s: failed to join thread", __func__);
+}
+
+static void run_test(uint32_t run)
+{
+	struct kvm_vm *vm;
+	cpu_set_t cpu_set;
+	pthread_t threads[VCPU_NUM];
+	pthread_t throw_away;
+	struct payload payloads[VCPU_NUM];
+	void *b;
+	uint32_t i, j;
+
+	CPU_ZERO(&cpu_set);
+	for (i = 0; i < VCPU_NUM; i++)
+		CPU_SET(i, &cpu_set);
+
+	vm = vm_create(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+	vm_create_irqchip(vm);
+
+	fprintf(stderr, "%s: [%d] start vcpus\n", __func__, run);
+	for (i = 0; i < VCPU_NUM; ++i) {
+		vm_vcpu_add_default(vm, i, guest_code);
+		payloads[i].vm = vm;
+		payloads[i].index = i;
+
+		check_create_thread(&threads[i], NULL, run_vcpu,
+				    (void *)&payloads[i]);
+		check_set_affinity(threads[i], &cpu_set);
+
+		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
+			check_create_thread(&throw_away, NULL, sleeping_thread,
+					    (void *)NULL);
+			check_set_affinity(throw_away, &cpu_set);
+		}
+	}
+	fprintf(stderr, "%s: [%d] all threads launched\n", __func__, run);
+	sem_post(sem);
+	for (i = 0; i < VCPU_NUM; ++i)
+		check_join(threads[i], &b);
+	/* Should not be reached */
+	TEST_ASSERT(false, "%s: [%d] child escaped the ninja\n", __func__, run);
+}
+
+int main(int argc, char **argv)
+{
+	uint32_t i;
+	int s, r;
+	pid_t pid;
+
+	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
+	sem_unlink("vm_sem");
+
+	for (i = 0; i < FORK_NUM; ++i) {
+		pid = fork();
+		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
+		if (pid == 0)
+			run_test(i); /* This function always exits */
+
+		fprintf(stderr, "%s: [%d] waiting semaphore\n", __func__, i);
+		sem_wait(sem);
+		r = (rand() % DELAY_US_MAX) + 1;
+		fprintf(stderr, "%s: [%d] waiting %dus\n", __func__, i, r);
+		usleep(r);
+		r = waitpid(pid, &s, WNOHANG);
+		TEST_ASSERT(r != pid,
+			    "%s: [%d] child exited unexpectedly status: [%d]",
+			    __func__, i, s);
+		fprintf(stderr, "%s: [%d] killing child\n", __func__, i);
+		kill(pid, SIGKILL);
+	}
+
+	sem_destroy(sem);
+	exit(0);
+}
-- 
2.30.0.478.g8a0d178c01-goog

