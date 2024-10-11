Return-Path: <linux-kselftest+bounces-19500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C078999B51
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE414286388
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF61F4FC4;
	Fri, 11 Oct 2024 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcdkzmeS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5E1F12FB;
	Fri, 11 Oct 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618662; cv=none; b=hgJmR8wrcmL5xvAJea++ZLp8H7PrH2X95lxcMlJ2M/OEQ2WDHozieIRhNTjWK+lXbgVJHN7fA9kj8jmgCNGSDdv00nZAS/rSyfLXhXplWWObXP3zRSnZplXd1v73PgFEsXwPj844YcgrAcxp8nq1N59n2rsXNt7JLic6GhMz0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618662; c=relaxed/simple;
	bh=3S5srcW1eC0fjouJG/RPYd+q1AlQDqqyfW2eN5dHkJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXuNl6BlW9xP8IRfhXyYFqj6ffI1LHj3MLYhONiXR2OSc81qHARzG3ZU7uj1iC0EPpzCcBEmrMU4IU6xXWg0zC6Xmn+BaZtCIbADVH4SFvQY03ziF5pYkF28ZLtZ20KGT3A9+SwUe1e21eArlBOQTIlZw9+6OYe668FPZ+JYvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcdkzmeS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e10ae746aso1286971b3a.2;
        Thu, 10 Oct 2024 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618659; x=1729223459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEoivBBYPnTFxdv18pbri1Kddzc7soFdTxyTNsvGgJU=;
        b=TcdkzmeSDXZaXJ+RPJTSFYfeijpvRIYKRQcoz4SqY3BHx0Bn9wELApYsh4FV8Gs0Zl
         PdwUQ/qM7P6iFeaH6RXkQrtq168Z7rbVh/62COCetq37hlQc4RgV6pkow32HO5Id4xK1
         hOR1dxp/+vEH1xUakcleNdgd+eykgX1uyRL5xFTo/uFJz0WHr479S1/gjOHRAJ+R3oAv
         S56nIN53OlmTZQR6kVaMcMjGtMd9HQhUE2hd+tco82rcWcjCmfPczhaz4/pAwqGjYb9F
         14daxyYCgPc3pq117EZfiz0RVWakr8FTg7NuJw0JWAhA72S3YFnCvWomlN5+cSIALl7e
         DpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618659; x=1729223459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoivBBYPnTFxdv18pbri1Kddzc7soFdTxyTNsvGgJU=;
        b=J1Q9sPB/F49ON/z/8to4SEl43/9gcqVfckZGqsIxmHT2xEhWWGheJc0ScXh9q6j7Wk
         JuHgKuqy+dz0+ZGOHhiXs9KDLsPdQ7w7d5KkFYhQiyfEbd+6vuUkOp72u337/ASGTcvw
         werL6kAH3EYzrCzNg82Yj5LUbiPz3YaH0gUgVoQnKfxm6V8cRPKzmE/jN4SCwYf0N9/M
         5DbVMv6/JGWhLIdcu0Hf5+P1gJKa6bX10r7SDV/LvNa3pRa+GWTqMQkclT0S5tfS0O0S
         lH5QyY89XTGXqwyofrkFd/tVkWXi7pjS49EG9QmJq68AI8xaFL+UbP2zVSeOFNZNqraA
         RCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfQ586CW5JFhZwAlRd659IRyeDDtmP75t3twCHVGTVsoNsHrnMWA+ncBV25IHWk0yNQU6H2JTLIUCZIpdc9gU=@vger.kernel.org, AJvYcCXGup3pqK9fzw1fdS+iNV3a5KmuNLgcGV0q0u29UruO2OmHdE+YMWx1nk2F5xkOGO1VEg8XpneE@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEmCbkgfrFVOS1s2Cn0BjaABFtyacdib1SgyR7BVwZEH/rybz
	QiBkX6QkMc3M14q1k3Zfk1Ub0u435hgWz18z9Mjifzi+9u00qHk=
X-Google-Smtp-Source: AGHT+IGUbSWpnN8jAw93b0hB2yjOMrWYjTbtZRuUoi+k06TL4He60bh4iZInln5uok0cSJ9grdmenQ==
X-Received: by 2002:a05:6a00:1941:b0:71e:cf8:d6fa with SMTP id d2e1a72fcca58-71e37ef9d3amr1687878b3a.15.1728618659069;
        Thu, 10 Oct 2024 20:50:59 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0a645sm1858642b3a.94.2024.10.10.20.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:50:58 -0700 (PDT)
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
Subject: [bpf-next 3/4] samples/bpf: remove obsolete cgroup related tests
Date: Fri, 11 Oct 2024 03:50:37 +0000
Message-ID: <20241011035038.97568-4-danieltimlee@gmail.com>
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

This patch removes the obsolete cgroup related tests. These tests are
now redundant because their functionality is already covered by more
modern and comprehensive tests under selftests/bpf.

The following files are removed:
- test_current_task_under_cgroup: tests bpf_current_task_under_cgroup()
  to check if a task belongs to a cgroup. Already covered by
  task_under_cgroup at selftest and other cgroup ID tests.

- test_cgrp2_tc: tests bpf_skb_under_cgroup() to filter packets based
  on cgroup. This behavior is now validated by cgroup_skb_sk_lookup,
  which uses bpf_skb_cgroup_id, making this test redundant.

By removing these outdated tests, this patch helps streamline and
modernize the test suite, avoiding duplication of test coverage.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile                          |   9 -
 samples/bpf/test_cgrp2_array_pin.c            | 106 ----------
 samples/bpf/test_cgrp2_attach.c               | 177 -----------------
 samples/bpf/test_cgrp2_tc.bpf.c               |  56 ------
 samples/bpf/test_cgrp2_tc.sh                  | 187 ------------------
 .../bpf/test_current_task_under_cgroup.bpf.c  |  43 ----
 .../bpf/test_current_task_under_cgroup_user.c | 115 -----------
 7 files changed, 693 deletions(-)
 delete mode 100644 samples/bpf/test_cgrp2_array_pin.c
 delete mode 100644 samples/bpf/test_cgrp2_attach.c
 delete mode 100644 samples/bpf/test_cgrp2_tc.bpf.c
 delete mode 100755 samples/bpf/test_cgrp2_tc.sh
 delete mode 100644 samples/bpf/test_current_task_under_cgroup.bpf.c
 delete mode 100644 samples/bpf/test_current_task_under_cgroup_user.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cdfda15e859c..66827dbb93b3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -25,10 +25,8 @@ tprogs-y += offwaketime
 tprogs-y += spintest
 tprogs-y += map_perf_test
 tprogs-y += test_overhead
-tprogs-y += test_cgrp2_array_pin
 tprogs-y += test_cgrp2_attach
 tprogs-y += xdp_router_ipv4
-tprogs-y += test_current_task_under_cgroup
 tprogs-y += trace_event
 tprogs-y += sampleip
 tprogs-y += tc_l2_redirect
@@ -71,11 +69,6 @@ lathist-objs := lathist_user.o
 offwaketime-objs := offwaketime_user.o $(TRACE_HELPERS)
 spintest-objs := spintest_user.o $(TRACE_HELPERS)
 map_perf_test-objs := map_perf_test_user.o
-test_overhead-objs := test_overhead_user.o
-test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
-test_cgrp2_attach-objs := test_cgrp2_attach.o
-test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
-				       test_current_task_under_cgroup_user.o
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
 sampleip-objs := sampleip_user.o $(TRACE_HELPERS)
 tc_l2_redirect-objs := tc_l2_redirect_user.o
@@ -117,8 +110,6 @@ always-y += test_overhead_tp.bpf.o
 always-y += test_overhead_raw_tp.bpf.o
 always-y += test_overhead_kprobe.bpf.o
 always-y += parse_varlen.o parse_simple.o parse_ldabs.o
-always-y += test_cgrp2_tc.bpf.o
-always-y += test_current_task_under_cgroup.bpf.o
 always-y += trace_event_kern.o
 always-y += sampleip_kern.o
 always-y += lwt_len_hist.bpf.o
diff --git a/samples/bpf/test_cgrp2_array_pin.c b/samples/bpf/test_cgrp2_array_pin.c
deleted file mode 100644
index 05e88aa63009..000000000000
--- a/samples/bpf/test_cgrp2_array_pin.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 Facebook
- */
-#include <linux/unistd.h>
-#include <linux/bpf.h>
-
-#include <stdio.h>
-#include <stdint.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-
-#include <bpf/bpf.h>
-
-static void usage(void)
-{
-	printf("Usage: test_cgrp2_array_pin [...]\n");
-	printf("       -F <file>   File to pin an BPF cgroup array\n");
-	printf("       -U <file>   Update an already pinned BPF cgroup array\n");
-	printf("       -v <value>  Full path of the cgroup2\n");
-	printf("       -h          Display this help\n");
-}
-
-int main(int argc, char **argv)
-{
-	const char *pinned_file = NULL, *cg2 = NULL;
-	int create_array = 1;
-	int array_key = 0;
-	int array_fd = -1;
-	int cg2_fd = -1;
-	int ret = -1;
-	int opt;
-
-	while ((opt = getopt(argc, argv, "F:U:v:")) != -1) {
-		switch (opt) {
-		/* General args */
-		case 'F':
-			pinned_file = optarg;
-			break;
-		case 'U':
-			pinned_file = optarg;
-			create_array = 0;
-			break;
-		case 'v':
-			cg2 = optarg;
-			break;
-		default:
-			usage();
-			goto out;
-		}
-	}
-
-	if (!cg2 || !pinned_file) {
-		usage();
-		goto out;
-	}
-
-	cg2_fd = open(cg2, O_RDONLY);
-	if (cg2_fd < 0) {
-		fprintf(stderr, "open(%s,...): %s(%d)\n",
-			cg2, strerror(errno), errno);
-		goto out;
-	}
-
-	if (create_array) {
-		array_fd = bpf_map_create(BPF_MAP_TYPE_CGROUP_ARRAY, NULL,
-					  sizeof(uint32_t), sizeof(uint32_t),
-					  1, NULL);
-		if (array_fd < 0) {
-			fprintf(stderr,
-				"bpf_create_map(BPF_MAP_TYPE_CGROUP_ARRAY,...): %s(%d)\n",
-				strerror(errno), errno);
-			goto out;
-		}
-	} else {
-		array_fd = bpf_obj_get(pinned_file);
-		if (array_fd < 0) {
-			fprintf(stderr, "bpf_obj_get(%s): %s(%d)\n",
-				pinned_file, strerror(errno), errno);
-			goto out;
-		}
-	}
-
-	ret = bpf_map_update_elem(array_fd, &array_key, &cg2_fd, 0);
-	if (ret) {
-		perror("bpf_map_update_elem");
-		goto out;
-	}
-
-	if (create_array) {
-		ret = bpf_obj_pin(array_fd, pinned_file);
-		if (ret) {
-			fprintf(stderr, "bpf_obj_pin(..., %s): %s(%d)\n",
-				pinned_file, strerror(errno), errno);
-			goto out;
-		}
-	}
-
-out:
-	if (array_fd != -1)
-		close(array_fd);
-	if (cg2_fd != -1)
-		close(cg2_fd);
-	return ret;
-}
diff --git a/samples/bpf/test_cgrp2_attach.c b/samples/bpf/test_cgrp2_attach.c
deleted file mode 100644
index 68ce69457afe..000000000000
--- a/samples/bpf/test_cgrp2_attach.c
+++ /dev/null
@@ -1,177 +0,0 @@
-/* eBPF example program:
- *
- * - Creates arraymap in kernel with 4 bytes keys and 8 byte values
- *
- * - Loads eBPF program
- *
- *   The eBPF program accesses the map passed in to store two pieces of
- *   information. The number of invocations of the program, which maps
- *   to the number of packets received, is stored to key 0. Key 1 is
- *   incremented on each iteration by the number of bytes stored in
- *   the skb.
- *
- * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
- *
- * - Every second, reads map[0] and map[1] to see how many bytes and
- *   packets were seen on any socket of tasks in the given cgroup.
- */
-
-#define _GNU_SOURCE
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stddef.h>
-#include <string.h>
-#include <unistd.h>
-#include <assert.h>
-#include <errno.h>
-#include <fcntl.h>
-
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-
-#include "bpf_insn.h"
-#include "bpf_util.h"
-
-enum {
-	MAP_KEY_PACKETS,
-	MAP_KEY_BYTES,
-};
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
-static int prog_load(int map_fd, int verdict)
-{
-	struct bpf_insn prog[] = {
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1), /* save r6 so it's not clobbered by BPF_CALL */
-
-		/* Count packets */
-		BPF_MOV64_IMM(BPF_REG_0, MAP_KEY_PACKETS), /* r0 = 0 */
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
-		BPF_LD_MAP_FD(BPF_REG_1, map_fd), /* load map fd to r1 */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-		BPF_MOV64_IMM(BPF_REG_1, 1), /* r1 = 1 */
-		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
-
-		/* Count bytes */
-		BPF_MOV64_IMM(BPF_REG_0, MAP_KEY_BYTES), /* r0 = 1 */
-		BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4), /* *(u32 *)(fp - 4) = r0 */
-		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -4), /* r2 = fp - 4 */
-		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
-		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
-		BPF_LDX_MEM(BPF_W, BPF_REG_1, BPF_REG_6, offsetof(struct __sk_buff, len)), /* r1 = skb->len */
-
-		BPF_ATOMIC_OP(BPF_DW, BPF_ADD, BPF_REG_0, BPF_REG_1, 0),
-
-		BPF_MOV64_IMM(BPF_REG_0, verdict), /* r0 = verdict */
-		BPF_EXIT_INSN(),
-	};
-	size_t insns_cnt = ARRAY_SIZE(prog);
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.log_buf = bpf_log_buf,
-		.log_size = BPF_LOG_BUF_SIZE,
-	);
-
-	return bpf_prog_load(BPF_PROG_TYPE_CGROUP_SKB, NULL, "GPL",
-			     prog, insns_cnt, &opts);
-}
-
-static int usage(const char *argv0)
-{
-	printf("Usage: %s [-d] [-D] <cg-path> <egress|ingress>\n", argv0);
-	printf("	-d	Drop Traffic\n");
-	printf("	-D	Detach filter, and exit\n");
-	return EXIT_FAILURE;
-}
-
-static int attach_filter(int cg_fd, int type, int verdict)
-{
-	int prog_fd, map_fd, ret, key;
-	long long pkt_cnt, byte_cnt;
-
-	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL,
-				sizeof(key), sizeof(byte_cnt),
-				256, NULL);
-	if (map_fd < 0) {
-		printf("Failed to create map: '%s'\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
-
-	prog_fd = prog_load(map_fd, verdict);
-	printf("Output from kernel verifier:\n%s\n-------\n", bpf_log_buf);
-
-	if (prog_fd < 0) {
-		printf("Failed to load prog: '%s'\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
-
-	ret = bpf_prog_attach(prog_fd, cg_fd, type, 0);
-	if (ret < 0) {
-		printf("Failed to attach prog to cgroup: '%s'\n",
-		       strerror(errno));
-		return EXIT_FAILURE;
-	}
-	while (1) {
-		key = MAP_KEY_PACKETS;
-		assert(bpf_map_lookup_elem(map_fd, &key, &pkt_cnt) == 0);
-
-		key = MAP_KEY_BYTES;
-		assert(bpf_map_lookup_elem(map_fd, &key, &byte_cnt) == 0);
-
-		printf("cgroup received %lld packets, %lld bytes\n",
-		       pkt_cnt, byte_cnt);
-		sleep(1);
-	}
-
-	return EXIT_SUCCESS;
-}
-
-int main(int argc, char **argv)
-{
-	int detach_only = 0, verdict = 1;
-	enum bpf_attach_type type;
-	int opt, cg_fd, ret;
-
-	while ((opt = getopt(argc, argv, "Dd")) != -1) {
-		switch (opt) {
-		case 'd':
-			verdict = 0;
-			break;
-		case 'D':
-			detach_only = 1;
-			break;
-		default:
-			return usage(argv[0]);
-		}
-	}
-
-	if (argc - optind < 2)
-		return usage(argv[0]);
-
-	if (strcmp(argv[optind + 1], "ingress") == 0)
-		type = BPF_CGROUP_INET_INGRESS;
-	else if (strcmp(argv[optind + 1], "egress") == 0)
-		type = BPF_CGROUP_INET_EGRESS;
-	else
-		return usage(argv[0]);
-
-	cg_fd = open(argv[optind], O_DIRECTORY | O_RDONLY);
-	if (cg_fd < 0) {
-		printf("Failed to open cgroup path: '%s'\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
-
-	if (detach_only) {
-		ret = bpf_prog_detach(cg_fd, type);
-		printf("bpf_prog_detach() returned '%s' (%d)\n",
-		       strerror(errno), errno);
-	} else
-		ret = attach_filter(cg_fd, type, verdict);
-
-	return ret;
-}
diff --git a/samples/bpf/test_cgrp2_tc.bpf.c b/samples/bpf/test_cgrp2_tc.bpf.c
deleted file mode 100644
index c7d2291d676f..000000000000
--- a/samples/bpf/test_cgrp2_tc.bpf.c
+++ /dev/null
@@ -1,56 +0,0 @@
-/* Copyright (c) 2016 Facebook
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-#define KBUILD_MODNAME "foo"
-#include "vmlinux.h"
-#include "net_shared.h"
-#include <bpf/bpf_helpers.h>
-
-/* copy of 'struct ethhdr' without __packed */
-struct eth_hdr {
-	unsigned char   h_dest[ETH_ALEN];
-	unsigned char   h_source[ETH_ALEN];
-	unsigned short  h_proto;
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_CGROUP_ARRAY);
-	__type(key, u32);
-	__type(value, u32);
-	__uint(pinning, LIBBPF_PIN_BY_NAME);
-	__uint(max_entries, 1);
-} test_cgrp2_array_pin SEC(".maps");
-
-SEC("filter")
-int handle_egress(struct __sk_buff *skb)
-{
-	void *data = (void *)(long)skb->data;
-	struct eth_hdr *eth = data;
-	struct ipv6hdr *ip6h = data + sizeof(*eth);
-	void *data_end = (void *)(long)skb->data_end;
-	char dont_care_msg[] = "dont care %04x %d\n";
-	char pass_msg[] = "pass\n";
-	char reject_msg[] = "reject\n";
-
-	/* single length check */
-	if (data + sizeof(*eth) + sizeof(*ip6h) > data_end)
-		return TC_ACT_OK;
-
-	if (eth->h_proto != bpf_htons(ETH_P_IPV6) ||
-	    ip6h->nexthdr != IPPROTO_ICMPV6) {
-		bpf_trace_printk(dont_care_msg, sizeof(dont_care_msg),
-				 eth->h_proto, ip6h->nexthdr);
-		return TC_ACT_OK;
-	} else if (bpf_skb_under_cgroup(skb, &test_cgrp2_array_pin, 0) != 1) {
-		bpf_trace_printk(pass_msg, sizeof(pass_msg));
-		return TC_ACT_OK;
-	} else {
-		bpf_trace_printk(reject_msg, sizeof(reject_msg));
-		return TC_ACT_SHOT;
-	}
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_cgrp2_tc.sh b/samples/bpf/test_cgrp2_tc.sh
deleted file mode 100755
index 38e8dbc9d16e..000000000000
--- a/samples/bpf/test_cgrp2_tc.sh
+++ /dev/null
@@ -1,187 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-MY_DIR=$(dirname $0)
-# Details on the bpf prog
-BPF_CGRP2_ARRAY_NAME='test_cgrp2_array_pin'
-BPF_PROG="$MY_DIR/test_cgrp2_tc.bpf.o"
-BPF_SECTION='filter'
-
-[ -z "$TC" ] && TC='tc'
-[ -z "$IP" ] && IP='ip'
-
-# Names of the veth interface, net namespace...etc.
-HOST_IFC='ve'
-NS_IFC='vens'
-NS='ns'
-
-find_mnt() {
-    cat /proc/mounts | \
-	awk '{ if ($3 == "'$1'" && mnt == "") { mnt = $2 }} END { print mnt }'
-}
-
-# Init cgroup2 vars
-init_cgrp2_vars() {
-    CGRP2_ROOT=$(find_mnt cgroup2)
-    if [ -z "$CGRP2_ROOT" ]
-    then
-	CGRP2_ROOT='/mnt/cgroup2'
-	MOUNT_CGRP2="yes"
-    fi
-    CGRP2_TC="$CGRP2_ROOT/tc"
-    CGRP2_TC_LEAF="$CGRP2_TC/leaf"
-}
-
-# Init bpf fs vars
-init_bpf_fs_vars() {
-    local bpf_fs_root=$(find_mnt bpf)
-    [ -n "$bpf_fs_root" ] || return -1
-    BPF_FS_TC_SHARE="$bpf_fs_root/tc/globals"
-}
-
-setup_cgrp2() {
-    case $1 in
-	start)
-	    if [ "$MOUNT_CGRP2" == 'yes' ]
-	    then
-		[ -d $CGRP2_ROOT ] || mkdir -p $CGRP2_ROOT
-		mount -t cgroup2 none $CGRP2_ROOT || return $?
-	    fi
-	    mkdir -p $CGRP2_TC_LEAF
-	    ;;
-	*)
-	    rmdir $CGRP2_TC_LEAF && rmdir $CGRP2_TC
-	    [ "$MOUNT_CGRP2" == 'yes' ] && umount $CGRP2_ROOT
-	    ;;
-    esac
-}
-
-setup_bpf_cgrp2_array() {
-    local bpf_cgrp2_array="$BPF_FS_TC_SHARE/$BPF_CGRP2_ARRAY_NAME"
-    case $1 in
-	start)
-	    $MY_DIR/test_cgrp2_array_pin -U $bpf_cgrp2_array -v $CGRP2_TC
-	    ;;
-	*)
-	    [ -d "$BPF_FS_TC_SHARE" ] && rm -f $bpf_cgrp2_array
-	    ;;
-    esac
-}
-
-setup_net() {
-    case $1 in
-	start)
-	    $IP link add $HOST_IFC type veth peer name $NS_IFC || return $?
-	    $IP link set dev $HOST_IFC up || return $?
-	    sysctl -q net.ipv6.conf.$HOST_IFC.disable_ipv6=0
-	    sysctl -q net.ipv6.conf.$HOST_IFC.accept_dad=0
-
-	    $IP netns add $NS || return $?
-	    $IP link set dev $NS_IFC netns $NS || return $?
-	    $IP -n $NS link set dev $NS_IFC up || return $?
-	    $IP netns exec $NS sysctl -q net.ipv6.conf.$NS_IFC.disable_ipv6=0
-	    $IP netns exec $NS sysctl -q net.ipv6.conf.$NS_IFC.accept_dad=0
-	    $TC qdisc add dev $HOST_IFC clsact || return $?
-	    $TC filter add dev $HOST_IFC egress bpf da obj $BPF_PROG sec $BPF_SECTION || return $?
-	    ;;
-	*)
-	    $IP netns del $NS
-	    $IP link del $HOST_IFC
-	    ;;
-    esac
-}
-
-run_in_cgrp() {
-    # Fork another bash and move it under the specified cgroup.
-    # It makes the cgroup cleanup easier at the end of the test.
-    cmd='echo $$ > '
-    cmd="$cmd $1/cgroup.procs; exec $2"
-    bash -c "$cmd"
-}
-
-do_test() {
-    run_in_cgrp $CGRP2_TC_LEAF "ping -6 -c3 ff02::1%$HOST_IFC >& /dev/null"
-    local dropped=$($TC -s qdisc show dev $HOST_IFC | tail -3 | \
-			   awk '/drop/{print substr($7, 0, index($7, ",")-1)}')
-    if [[ $dropped -eq 0 ]]
-    then
-	echo "FAIL"
-	return 1
-    else
-	echo "Successfully filtered $dropped packets"
-	return 0
-    fi
-}
-
-do_exit() {
-    if [ "$DEBUG" == "yes" ] && [ "$MODE" != 'cleanuponly' ]
-    then
-	echo "------ DEBUG ------"
-	echo "mount: "; mount | grep -E '(cgroup2|bpf)'; echo
-	echo "$CGRP2_TC_LEAF: "; ls -l $CGRP2_TC_LEAF; echo
-	if [ -d "$BPF_FS_TC_SHARE" ]
-	then
-	    echo "$BPF_FS_TC_SHARE: "; ls -l $BPF_FS_TC_SHARE; echo
-	fi
-	echo "Host net:"
-	$IP netns
-	$IP link show dev $HOST_IFC
-	$IP -6 a show dev $HOST_IFC
-	$TC -s qdisc show dev $HOST_IFC
-	echo
-	echo "$NS net:"
-	$IP -n $NS link show dev $NS_IFC
-	$IP -n $NS -6 link show dev $NS_IFC
-	echo "------ DEBUG ------"
-	echo
-    fi
-
-    if [ "$MODE" != 'nocleanup' ]
-    then
-	setup_net stop
-	setup_bpf_cgrp2_array stop
-	setup_cgrp2 stop
-    fi
-}
-
-init_cgrp2_vars
-init_bpf_fs_vars
-
-while [[ $# -ge 1 ]]
-do
-    a="$1"
-    case $a in
-	debug)
-	    DEBUG='yes'
-	    shift 1
-	    ;;
-	cleanup-only)
-	    MODE='cleanuponly'
-	    shift 1
-	    ;;
-	no-cleanup)
-	    MODE='nocleanup'
-	    shift 1
-	    ;;
-	*)
-	    echo "test_cgrp2_tc [debug] [cleanup-only | no-cleanup]"
-	    echo "  debug: Print cgrp and network setup details at the end of the test"
-	    echo "  cleanup-only: Try to cleanup things from last test.  No test will be run"
-	    echo "  no-cleanup: Run the test but don't do cleanup at the end"
-	    echo "[Note: If no arg is given, it will run the test and do cleanup at the end]"
-	    echo
-	    exit -1
-	    ;;
-    esac
-done
-
-trap do_exit 0
-
-[ "$MODE" == 'cleanuponly' ] && exit
-
-setup_cgrp2 start || exit $?
-setup_net start || exit $?
-init_bpf_fs_vars || exit $?
-setup_bpf_cgrp2_array start || exit $?
-do_test
-echo
diff --git a/samples/bpf/test_current_task_under_cgroup.bpf.c b/samples/bpf/test_current_task_under_cgroup.bpf.c
deleted file mode 100644
index 58b9cf7ed659..000000000000
--- a/samples/bpf/test_current_task_under_cgroup.bpf.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/* Copyright (c) 2016 Sargun Dhillon <sargun@sargun.me>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- */
-
-#include "vmlinux.h"
-#include <linux/version.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include <bpf/bpf_core_read.h>
-
-struct {
-	__uint(type, BPF_MAP_TYPE_CGROUP_ARRAY);
-	__uint(key_size, sizeof(u32));
-	__uint(value_size, sizeof(u32));
-	__uint(max_entries, 1);
-} cgroup_map SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, u32);
-	__type(value, u64);
-	__uint(max_entries, 1);
-} perf_map SEC(".maps");
-
-/* Writes the last PID that called sync to a map at index 0 */
-SEC("ksyscall/sync")
-int BPF_KSYSCALL(bpf_prog1)
-{
-	u64 pid = bpf_get_current_pid_tgid();
-	int idx = 0;
-
-	if (!bpf_current_task_under_cgroup(&cgroup_map, 0))
-		return 0;
-
-	bpf_map_update_elem(&perf_map, &idx, &pid, BPF_ANY);
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
-u32 _version SEC("version") = LINUX_VERSION_CODE;
diff --git a/samples/bpf/test_current_task_under_cgroup_user.c b/samples/bpf/test_current_task_under_cgroup_user.c
deleted file mode 100644
index 9726ed2a8a8b..000000000000
--- a/samples/bpf/test_current_task_under_cgroup_user.c
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2016 Sargun Dhillon <sargun@sargun.me>
- */
-
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <unistd.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include "cgroup_helpers.h"
-
-#define CGROUP_PATH		"/my-cgroup"
-
-int main(int argc, char **argv)
-{
-	pid_t remote_pid, local_pid = getpid();
-	int cg2 = -1, idx = 0, rc = 1;
-	struct bpf_link *link = NULL;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	char filename[256];
-	int map_fd[2];
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
-		printf("finding a prog in obj file failed\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		fprintf(stderr, "ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	map_fd[0] = bpf_object__find_map_fd_by_name(obj, "cgroup_map");
-	map_fd[1] = bpf_object__find_map_fd_by_name(obj, "perf_map");
-	if (map_fd[0] < 0 || map_fd[1] < 0) {
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
-	if (setup_cgroup_environment())
-		goto err;
-
-	cg2 = create_and_get_cgroup(CGROUP_PATH);
-
-	if (cg2 < 0)
-		goto err;
-
-	if (bpf_map_update_elem(map_fd[0], &idx, &cg2, BPF_ANY)) {
-		log_err("Adding target cgroup to map");
-		goto err;
-	}
-
-	if (join_cgroup(CGROUP_PATH))
-		goto err;
-
-	/*
-	 * The installed helper program catched the sync call, and should
-	 * write it to the map.
-	 */
-
-	sync();
-	bpf_map_lookup_elem(map_fd[1], &idx, &remote_pid);
-
-	if (local_pid != remote_pid) {
-		fprintf(stderr,
-			"BPF Helper didn't write correct PID to map, but: %d\n",
-			remote_pid);
-		goto err;
-	}
-
-	/* Verify the negative scenario; leave the cgroup */
-	if (join_cgroup("/"))
-		goto err;
-
-	remote_pid = 0;
-	bpf_map_update_elem(map_fd[1], &idx, &remote_pid, BPF_ANY);
-
-	sync();
-	bpf_map_lookup_elem(map_fd[1], &idx, &remote_pid);
-
-	if (local_pid == remote_pid) {
-		fprintf(stderr, "BPF cgroup negative test did not work\n");
-		goto err;
-	}
-
-	rc = 0;
-
-err:
-	if (cg2 != -1)
-		close(cg2);
-
-	cleanup_cgroup_environment();
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return rc;
-}
-- 
2.43.0


