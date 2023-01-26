Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFA67C1E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 01:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjAZAoQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 19:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjAZAoP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 19:44:15 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7CA5D922
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 16:44:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u15-20020a170902a60f00b00194d7d89168so270164plq.10
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jan 2023 16:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHzkkk87TbbUPKF1WRN1fk8BmgW62Y04okrrt/Ehyys=;
        b=emC+XrS/rbbxLVKb3nElTgqRL0U2333pKOddPUIaDaS8AKkJOBlIrfg8auaBBa/3st
         J/5YZOiB1La0L/hZBiHmpCierhZ+L7ezYx+d/rXu1IdWRHat0wE2fYQqB/nhm48wUcnU
         HZE1SzDQQFbsVgdj0Tr7yMYA6USlnuwensuu3AMdRr1Ycpzdu3rShbkzb8i/ozAQ4TUu
         l+E6kF5gfwG9wt9KJjPIs/cokGQyDO9kNXfS5eJukfg2iSAMNsMoSqCtQifWEm9mR9x4
         NcZa6ivyUuAyTQ6zAlV+GzFSrGTVSfRt3OyJ1HWf2sctAykTiJB7F21IC+Q75s/RHXXM
         PXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHzkkk87TbbUPKF1WRN1fk8BmgW62Y04okrrt/Ehyys=;
        b=0fTR1ArPkolsTLKleB/lShznJ/UFHMMpaX5Eg6PqWt+A6gTeKWmhpUhdgzUuTWBp24
         Z2/DCcQjc33ilIdf5fph3PK9yt/i5cEOpkf2zxg9h0m8jWkKi0QwruZy3YT8jsZX304G
         wbA8Zr65ekxlgBvQeleGxoV8NSJmcByLCENVvk0jQyxpcLqMFFmaWsp3YsLZiihgu27l
         xLTaFAvGDcnytjwe1BC2yedeAh+DKEMi2Ws2OVlapgrWtrHD1mObkw+GLZU4ufRjZAl1
         D10wG69P2lPBsyNRvISY5xT9+VxlY7kyFPlGGGlPIorsZJzxpNZR0JpZ4kTWf1JqLZok
         JEDg==
X-Gm-Message-State: AFqh2krMq+B1kR2Gf8SspHgMuqUVXwwQCiGWYK87t83r/SbYUz8XHLhy
        h5FYLgUnA0+x84T+5WHRyQDF/LEI7Knzbw==
X-Google-Smtp-Source: AMrXdXsNdlwlzH31iPHt5vOi0Zyr1UmunvVe1eGA4aG0sfjGjWytRv1n26O9saJuq4XM5fddJj2DDJO0a4RqDA==
X-Received: from chengkev.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:171])
 (user=chengkev job=sendgmr) by 2002:a17:902:8d83:b0:194:436e:817e with SMTP
 id v3-20020a1709028d8300b00194436e817emr3830825plo.0.1674693852189; Wed, 25
 Jan 2023 16:44:12 -0800 (PST)
Date:   Thu, 26 Jan 2023 00:43:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126004346.4101944-1-chengkev@google.com>
Subject: [PATCH] KVM: selftests: Added eBPF program and selftest to collect
 vmx exit stat
From:   Kevin Cheng <chengkev@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Cc:     Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a new selftest that loads an eBPF program that stores the
number of vmx exit counts per vcpu per vm. A process is created per
vm_create to load a separate eBPF program to collect its own stats
unique to the pid.

This test aims to serve as a proof-of-concept and example for using eBPF
to collect stats that are not provided by the other stats interfaces
such as kvm_binary_stats. Since there will be no further stats being
added to kvm_binary_stats, developers can use this selftest as a
reference for writing their own eBPF program + selftest to collect
whatever stat they may need for debugging/monitoring.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 tools/testing/selftests/kvm/Makefile          |   4 +-
 tools/testing/selftests/kvm/build_ebpf.sh     |   5 +
 .../testing/selftests/kvm/kvm_vmx_exit_ebpf.c | 128 ++++++++++++++++++
 .../selftests/kvm/kvm_vmx_exit_ebpf_kern.c    |  74 ++++++++++
 4 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/build_ebpf.sh
 create mode 100644 tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
 create mode 100644 tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1750f91dd936..d9f56ccbc7bb 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 TEST_GEN_PROGS_x86_64 += system_counter_offset_test
+TEST_GEN_PROGS_x86_64 += kvm_vmx_exit_ebpf
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86_64 += x86_64/nx_huge_pages_test
@@ -176,6 +177,7 @@ TEST_GEN_PROGS_riscv += set_memory_region_test
 TEST_GEN_PROGS_riscv += kvm_binary_stats_test
 
 TEST_PROGS += $(TEST_PROGS_$(ARCH_DIR))
+TEST_PROGS := build_ebpf.sh
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH_DIR))
 TEST_GEN_PROGS_EXTENDED += $(TEST_GEN_PROGS_EXTENDED_$(ARCH_DIR))
 LIBKVM += $(LIBKVM_$(ARCH_DIR))
@@ -208,7 +210,7 @@ no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
 pgste-option = $(call try-run, echo 'int main(void) { return 0; }' | \
 	$(CC) -Werror -Wl$(comma)--s390-pgste -x c - -o "$$TMP",-Wl$(comma)--s390-pgste)
 
-LDLIBS += -ldl
+LDLIBS += -ldl -L$(top_srcdir)/tools/lib/bpf -lbpf -lelf -lz
 LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
 
 LIBKVM_C := $(filter %.c,$(LIBKVM))
diff --git a/tools/testing/selftests/kvm/build_ebpf.sh b/tools/testing/selftests/kvm/build_ebpf.sh
new file mode 100644
index 000000000000..b8038b0a0da5
--- /dev/null
+++ b/tools/testing/selftests/kvm/build_ebpf.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c kvm_vmx_exit_ebpf_kern.c
+        -o kvm_vmx_exit_ebpf_kern.o
+make -C ../../../lib/bpf || exit
diff --git a/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
new file mode 100644
index 000000000000..a4bd2c549207
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <bpf/bpf.h>
+#include <../bpf/libbpf.h>
+#include <linux/btf.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "linux/kvm.h"
+
+#define VCPU_ID         0
+
+struct stats_map_key {
+	__u32 pid;
+	__u32 vcpu_id;
+	__u32 exit_reason;
+};
+
+static void guest_code(void)
+{
+	__asm__ __volatile__("cpuid");
+}
+
+int main(int argc, char **argv)
+{
+	if (argc < 2) {
+		fprintf(stderr, "Expected arguments: <number_of_vms>\n");
+		return EXIT_FAILURE;
+	}
+	int n = atoi(argv[1]);
+
+	for (int i = 0; i < n; i++) {
+		if (fork() == 0) {
+			struct kvm_vm *vm;
+			struct kvm_vcpu *vcpu;
+
+			vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+			// BPF userspace code
+			struct bpf_object *obj;
+			struct bpf_program *prog;
+			struct bpf_map *map_obj;
+			struct bpf_link *link = NULL;
+
+			obj = bpf_object__open_file("kvm_vmx_exit_ebpf_kern.o", NULL);
+			if (libbpf_get_error(obj)) {
+				fprintf(stderr, "ERROR: opening BPF object file failed\n");
+				return 0;
+			}
+
+			map_obj = bpf_object__find_map_by_name(obj, "vmx_exit_map");
+			if (!map_obj) {
+				fprintf(stderr, "ERROR: loading of vmx BPF map failed\n");
+				goto cleanup;
+			}
+
+			struct bpf_map *pid_map = bpf_object__find_map_by_name(obj, "pid_map");
+
+			if (!pid_map) {
+				fprintf(stderr, "ERROR: loading of pid BPF map failed\n");
+				goto cleanup;
+			}
+
+			/* load BPF program */
+			if (bpf_object__load(obj)) {
+				fprintf(stderr, "ERROR: loading BPF object file failed\n");
+				goto cleanup;
+			}
+
+			__u32 userspace_pid = (__u32)getpid();
+			__u32 val = (__u32)getpid();
+
+			bpf_map_update_elem(bpf_map__fd(pid_map), &userspace_pid, &val, 0);
+
+			prog = bpf_object__find_program_by_name(obj, "bpf_exit_prog");
+			if (libbpf_get_error(prog)) {
+				fprintf(stderr, "ERROR: finding a prog in obj file failed\n");
+				goto cleanup;
+			}
+
+			link = bpf_program__attach(prog);
+			if (libbpf_get_error(link)) {
+				fprintf(stderr, "ERROR: bpf_program__attach failed\n");
+				link = NULL;
+				goto cleanup;
+			}
+
+			for (int j = 0; j < 10000; j++)
+				vcpu_run(vcpu);
+
+			struct stats_map_key key = {
+				.pid = 0,
+				.vcpu_id = 0,
+				.exit_reason = 18,
+			};
+
+
+			struct stats_map_key next_key, lookup_key;
+
+			lookup_key = key;
+			while (bpf_map_get_next_key(bpf_map__fd(map_obj), &lookup_key, &next_key)
+				 == 0) {
+				int count;
+
+				bpf_map_lookup_elem(bpf_map__fd(map_obj), &next_key, &count);
+				fprintf(stdout, "exit reason: '%d'\ncount: %d\npid: %d\n",
+						next_key.exit_reason, count, next_key.pid);
+				lookup_key = next_key;
+			}
+
+cleanup:
+			bpf_link__destroy(link);
+			bpf_object__close(obj);
+			kvm_vm_free(vm);
+		}
+	}
+
+	for (int i = 0; i < n; i++)
+		wait(NULL);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
new file mode 100644
index 000000000000..b9c076f93171
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_vmx_exit_ebpf_kern.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/bpf.h>
+#include <stdint.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+struct kvm_vcpu {
+	int vcpu_id;
+};
+
+struct vmx_args {
+	__u64 pad;
+	unsigned int exit_reason;
+	__u32 isa;
+	struct kvm_vcpu *vcpu;
+};
+
+struct stats_map_key {
+	__u32 pid;
+	__u32 vcpu_id;
+	__u32 exit_reason;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1024);
+	__type(key, struct stats_map_key);
+	__type(value, int);
+} vmx_exit_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} pid_map SEC(".maps");
+
+
+SEC("tracepoint/kvm/kvm_exit")
+int bpf_exit_prog(struct vmx_args *ctx)
+{
+	__u32 curr_pid = (bpf_get_current_pid_tgid() >> 32);
+
+	__u32 *userspace_pid = bpf_map_lookup_elem(&pid_map, &curr_pid);
+
+	if (!userspace_pid || *userspace_pid != curr_pid)
+		return 0;
+
+	struct kvm_vcpu *vcpu = ctx->vcpu;
+	int _vcpu_id = BPF_CORE_READ(vcpu, vcpu_id);
+
+	struct stats_map_key key = {
+		.pid = (bpf_get_current_pid_tgid() >> 32),
+		.vcpu_id = _vcpu_id,
+		.exit_reason = ctx->exit_reason,
+	};
+
+	int *value = bpf_map_lookup_elem(&vmx_exit_map, &key);
+
+	if (value) {
+		*value = *value + 1;
+		bpf_map_update_elem(&vmx_exit_map, &key, value, BPF_ANY);
+	} else {
+		int temp = 1;
+
+		bpf_map_update_elem(&vmx_exit_map, &key, &temp, BPF_ANY);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.39.1.456.gfc5497dd1b-goog

