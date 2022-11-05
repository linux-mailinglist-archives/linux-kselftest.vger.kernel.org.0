Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0168261A709
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 03:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiKECwc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 22:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiKECwa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 22:52:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E15B3F06C
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 19:52:29 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e15so4378050qts.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 19:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl8oQUpe8yXqSeuRtfUsJkpIGEQ98nwCnE5YcZtf2Pk=;
        b=D3Efmuf4WRWk4XBr8PaHosbwLBamqCB1Qq1UsUIMQ1cYAddKnpMt9REEdYbmcxPJfv
         mvu8px+Pp135sgK1Qrx/XyhjPfeEKOZQ2bWTNKLeAtKePRk312c/yRWK//4J1WuP3Rx7
         Flmzd2PuZ3ZkysxXlU87KxkQz3vaE0Ldi5tRP4jUNvfPSf/tipTYPsGVQ+r+llHYbL78
         sQvnXCg8kpohgS26Uk8QPY7Xcnt3mIcczIEnjl42LVuhQM8RYGLOer04tSFCrfeT5qPK
         dMTz5O5LicnnSdKZxl/36cwUf6fpIzRTo69ZPQl+xsz9nxmWyNyAW0NWAztu2irqpF52
         OCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wl8oQUpe8yXqSeuRtfUsJkpIGEQ98nwCnE5YcZtf2Pk=;
        b=zSjO/HPf5oGzzLCS/FnEkPeTJS5uSQ9mvY1/ER4E1X41tArROgTlWvxKdGX+P5piaz
         98WiNs2VJ7wI6aK3OskeWTx3tmPGwbmsFs9ypUWd8jxixg0atiuekpRK9y3deamYg47s
         NVtCYIgASPq3tzFakinnZhLA+uZmsJclYMr2IoeRVEF8sOg6DTnl5AX3IbDNQfYOvcTt
         aYSAswwQY0RchzzsLb+DaaAej18BU2AlPBUr+S4ctgKXYz/YYEfuRQigEYlfXfCj5ul/
         MBj/Q259XTQpKNjAKM+9o0NoXHtQ3KT2HMQe23ui+O3g0ytVpxyPZHt8ZCotA7Nb1uv6
         elVg==
X-Gm-Message-State: ACrzQf1N2ZTM21LH3LBR1vBhbTV9/nwwXVFuN51IyDx+6mpU9a5GR1II
        P/1GC69FgaCxLeNsq68HmU9RXw==
X-Google-Smtp-Source: AMsMyM5BzqY21BEcuHkVF4tSoDHZTYxblDnn8FA6zvN9Z3p8MctvtJZVXGyaQmL+lFTU/eXQarCXPw==
X-Received: by 2002:ac8:6e86:0:b0:3a5:27f8:f3db with SMTP id c6-20020ac86e86000000b003a527f8f3dbmr23498116qtv.97.1667616748585;
        Fri, 04 Nov 2022 19:52:28 -0700 (PDT)
Received: from 192-168-53-12.byted.org ([130.44.212.119])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05620a178e00b006bb366779a4sm805905qkb.6.2022.11.04.19.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 19:52:28 -0700 (PDT)
From:   "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Hao Xiang <hao.xiang@bytedance.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf@vger.kernel.org
Cc:     Ho-Ren Chuang <horenc@vt.edu>,
        Ho-Ren Chuang <horenchuang@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH bpf-next v1 3/4] samples/bpf: Add concurrency testing for BPF htab map's used size
Date:   Sat,  5 Nov 2022 02:51:45 +0000
Message-Id: <20221105025146.238209-4-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221105025146.238209-1-horenchuang@bytedance.com>
References: <20221105025146.238209-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add htab map's used_size test cases for concurrency testing.

Support hash table type (BPF_MAP_TYPE_HASH).

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
---
 samples/bpf/Makefile             |   4 +
 samples/bpf/test_map_used_kern.c |  65 ++++++++++
 samples/bpf/test_map_used_user.c | 204 +++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 samples/bpf/test_map_used_kern.c
 create mode 100644 samples/bpf/test_map_used_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 727da3c5879b..8725d0d64a21 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -40,6 +40,7 @@ tprogs-y += tc_l2_redirect
 tprogs-y += lwt_len_hist
 tprogs-y += xdp_tx_iptunnel
 tprogs-y += test_map_in_map
+tprogs-y += test_map_used
 tprogs-y += per_socket_stats_example
 tprogs-y += xdp_rxq_info
 tprogs-y += syscall_tp
@@ -101,6 +102,7 @@ tc_l2_redirect-objs := tc_l2_redirect_user.o
 lwt_len_hist-objs := lwt_len_hist_user.o
 xdp_tx_iptunnel-objs := xdp_tx_iptunnel_user.o
 test_map_in_map-objs := test_map_in_map_user.o
+test_map_used-objs := test_map_used_user.o
 per_socket_stats_example-objs := cookie_uid_helper_example.o
 xdp_rxq_info-objs := xdp_rxq_info_user.o
 syscall_tp-objs := syscall_tp_user.o
@@ -153,6 +155,7 @@ always-y += sampleip_kern.o
 always-y += lwt_len_hist_kern.o
 always-y += xdp_tx_iptunnel_kern.o
 always-y += test_map_in_map_kern.o
+always-y += test_map_used_kern.o
 always-y += tcp_synrto_kern.o
 always-y += tcp_rwnd_kern.o
 always-y += tcp_bufs_kern.o
@@ -216,6 +219,7 @@ TPROGLDLIBS_xdp_router_ipv4	+= -lm -pthread
 TPROGLDLIBS_tracex4		+= -lrt
 TPROGLDLIBS_trace_output	+= -lrt
 TPROGLDLIBS_map_perf_test	+= -lrt
+TPROGLDLIBS_test_map_used	+= -lrt
 TPROGLDLIBS_test_overhead	+= -lrt
 
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
diff --git a/samples/bpf/test_map_used_kern.c b/samples/bpf/test_map_used_kern.c
new file mode 100644
index 000000000000..e908593c1f09
--- /dev/null
+++ b/samples/bpf/test_map_used_kern.c
@@ -0,0 +1,65 @@
+/* Copyright (c) 2022 ByteDance
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ */
+#include <linux/netdevice.h>
+#include <linux/version.h>
+#include <uapi/linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "trace_common.h"
+
+#define MAX_ENTRIES 1000
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u32);
+	__type(value, long);
+	__uint(max_entries, MAX_ENTRIES);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+} touch_hash_no_prealloc SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, u32);
+	__type(value, long);
+	__uint(max_entries, MAX_ENTRIES);
+} touch_hash_prealloc SEC(".maps");
+
+SEC("kprobe/" SYSCALL(sys_mount))
+int stress_hmap_alloc(struct pt_regs *ctx)
+{
+	u32 key, i;
+	long init_val = bpf_get_current_pid_tgid();
+
+#pragma clang loop unroll(full)
+	for (i = 0; i < MAX_ENTRIES; ++i) {
+		key = i;
+		bpf_map_update_elem(&touch_hash_no_prealloc,
+							&key, &init_val, BPF_ANY);
+	}
+
+	return 0;
+}
+
+SEC("kprobe/" SYSCALL(sys_umount))
+int stress_hmap_prealloc(struct pt_regs *ctx)
+{
+	u32 key, i;
+	long init_val = bpf_get_current_pid_tgid();
+
+#pragma clang loop unroll(full)
+	for (i = 0; i < MAX_ENTRIES; ++i) {
+		key = i;
+		bpf_map_update_elem(&touch_hash_prealloc,
+							&key, &init_val, BPF_ANY);
+	}
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
+u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_map_used_user.c b/samples/bpf/test_map_used_user.c
new file mode 100644
index 000000000000..797f6ca7434d
--- /dev/null
+++ b/samples/bpf/test_map_used_user.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022 ByteDance
+ */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <asm/unistd.h>
+#include <unistd.h>
+#include <assert.h>
+#include <sys/wait.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <linux/bpf.h>
+#include <string.h>
+#include <time.h>
+#include <sys/resource.h>
+#include <arpa/inet.h>
+#include <errno.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#define TEST_BIT(t) (1U << (t))
+#define MAX_NR_CPUS 1024
+
+static __u64 time_get_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000000ull + ts.tv_nsec;
+}
+
+enum test_type {
+	HASH_TOUCH_PREALLOC,
+	HASH_TOUCH,
+	NR_TESTS,
+};
+
+const char *test_map_names[NR_TESTS] = {
+	[HASH_TOUCH_PREALLOC] = "hash_map",
+	[HASH_TOUCH] = "hash_map",
+};
+
+static int test_flags = ~0;
+static __u32 num_map_entries;
+static __u32 inner_lru_hash_size;
+static __u32 max_cnt = 1000;
+
+static int check_test_flags(enum test_type t)
+{
+	return test_flags & TEST_BIT(t);
+}
+
+static void test_hash_touch_prealloc(int cpu)
+{
+	__u64 start_time;
+	int i;
+
+	start_time = time_get_ns();
+	for (i = 0; i < max_cnt; i++)
+		syscall(__NR_umount2, NULL, 0);
+	printf("%d:hash_touch pre-alloc %lld touches per sec\n",
+		   cpu, max_cnt * 1000000000ll / (time_get_ns() - start_time));
+}
+
+static void test_hash_touch(int cpu)
+{
+	__u64 start_time;
+	int i;
+
+	start_time = time_get_ns();
+	for (i = 0; i < max_cnt; i++)
+		syscall(__NR_mount, NULL, NULL, NULL, 0, NULL);
+	printf("%d:hash_touch %lld touchess per sec\n",
+		   cpu, max_cnt * 1000000000ll * 64 / (time_get_ns() - start_time));
+}
+
+typedef void (*test_func)(int cpu);
+const test_func test_funcs[] = {
+	[HASH_TOUCH_PREALLOC] = test_hash_touch_prealloc,
+	[HASH_TOUCH] = test_hash_touch,
+};
+
+static void loop(int cpu)
+{
+	cpu_set_t cpuset;
+	int i;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+	sched_setaffinity(0, sizeof(cpuset), &cpuset);
+
+	for (i = 0; i < NR_TESTS; i++) {
+		if (check_test_flags(i))
+			test_funcs[i](cpu);
+	}
+}
+
+static void run_perf_test(int tasks)
+{
+	pid_t pid[tasks];
+	int i;
+
+	for (i = 0; i < tasks; i++) {
+		pid[i] = fork();
+		if (pid[i])
+			printf("Spawn process #%d [%u]\n", i, pid[i]);
+
+		if (pid[i] == 0) {
+			loop(i);
+			exit(0);
+		} else if (pid[i] == -1) {
+			printf("couldn't spawn #%d process\n", i);
+			exit(1);
+		}
+	}
+	for (i = 0; i < tasks; i++) {
+		int status;
+
+		assert(waitpid(pid[i], &status, 0) == pid[i]);
+		assert(status == 0);
+	}
+}
+
+static void fixup_map(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+	int i;
+
+	bpf_object__for_each_map(map, obj) {
+		const char *name = bpf_map__name(map);
+
+		/* Only change the max_entries for the enabled test(s) */
+		for (i = 0; i < NR_TESTS; i++) {
+			if (!strcmp(test_map_names[i], name) &&
+				(check_test_flags(i))) {
+				bpf_map__set_max_entries(map, num_map_entries);
+				continue;
+			}
+		}
+	}
+
+	inner_lru_hash_size = num_map_entries;
+}
+
+int main(int argc, char **argv)
+{
+	int nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	struct bpf_link *links[8];
+	struct bpf_program *prog;
+	struct bpf_object *obj;
+	char filename[256];
+	int i = 0;
+
+	if (argc > 1)
+		test_flags = atoi(argv[1]) ? : test_flags;
+
+	if (argc > 2)
+		nr_cpus = atoi(argv[2]) ? : nr_cpus;
+
+	if (argc > 3)
+		num_map_entries = atoi(argv[3]);
+
+	if (argc > 4)
+		max_cnt = atoi(argv[4]);
+
+	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
+	obj = bpf_object__open_file(filename, NULL);
+	if (libbpf_get_error(obj)) {
+		fprintf(stderr, "ERROR: opening BPF object file failed\n");
+		return 0;
+	}
+
+	/* resize BPF map prior to loading */
+	if (num_map_entries > 0)
+		fixup_map(obj);
+
+	/* load BPF program */
+	if (bpf_object__load(obj)) {
+		fprintf(stderr, "ERROR: loading BPF object file failed\n");
+		goto cleanup;
+	}
+
+	bpf_object__for_each_program(prog, obj) {
+		links[i] = bpf_program__attach(prog);
+		if (libbpf_get_error(links[i])) {
+			fprintf(stderr, "ERROR: bpf_program__attach failed\n");
+			links[i] = NULL;
+			goto cleanup;
+		}
+		i++;
+	}
+
+	run_perf_test(nr_cpus);
+
+cleanup:
+	for (i--; i >= 0; i--)
+		bpf_link__destroy(links[i]);
+
+	bpf_object__close(obj);
+	return 0;
+}
-- 
Ho-Ren (Jack) Chuang

