Return-Path: <linux-kselftest+bounces-19498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F5999B4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 05:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECD11F252A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 03:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7FB1F4FCC;
	Fri, 11 Oct 2024 03:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNGOOdX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DC1C9B60;
	Fri, 11 Oct 2024 03:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618653; cv=none; b=BFBdYuqv0JEjG2Q6ST4+fDaeArMPrWVbDZLz9VUOQRnNS7KQt/GaH2mOZjApB4SQy9kxkj+sfbJ60INT4uzTXiUeezmng4Wbj/y63GpBN5h9a9FRmMKjasvwPMdbRyUNRX54zo45jT0YHeY6TEpStETXJE/8JISgiJv6ygo8qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618653; c=relaxed/simple;
	bh=AQATHK/PV8Tfdyb7cN93ExUjgpXhpm0zBzQn24ocW14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUb53/vqwpGC+tQHH2r2mo5OYMJZV7rmeS2oc/DQ3E0oQJQyA6R/npF39GeYEPQeIDDejlXmKS1WFsXcZ6VENT68TBcsbjsYMW/J9x5w74VhhJfsjjGfxg3olNF6ArkFJvKjKEO5Xfovq7EBFQpVn5cdGUFwylCX1iM2pIM22Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNGOOdX4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db908c9c83so987751a12.2;
        Thu, 10 Oct 2024 20:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728618650; x=1729223450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yWZPLkwxKJjT9XbDV5CM9kU8hB23DKMJ7kKlzBt4Tw=;
        b=YNGOOdX4NYUX2wDI+4p2MbsLDKoBxkC8+v+bgpxO7GxmJuqlk1oP+QMpjfm3ZtkxrD
         tJ0MHXaCtfiXVBNyFNngRxL31NVo0Kwss/1z+q5R0VvQqZOJkvI/39vhCpL6QC77W9jP
         EEFYpeeEjM+s2/y1SDn48lSUtzVvIjh99yhCyaGXF7eCOHgxf0rE8ZExFgwxHoJTUiDt
         4PPCINsU3xDwSxCc4Q7mZXAuqwE250YpBwTAVwdruIq3nw6aSUIqkoeCOj8q5npxYNhw
         uwvFldIs9DeuN0nA0L9Ye4EL1DLA+Dl5JJTddA06DpBC/7uKcFVdpLtEQyOAnw+PASvg
         TcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728618650; x=1729223450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yWZPLkwxKJjT9XbDV5CM9kU8hB23DKMJ7kKlzBt4Tw=;
        b=jqrtMIG7NqUHFcrN3p0QbyoRZZU5xliOAKJ+kDY65jN+fDSiqup/0D6Wj+hf5EJ+UN
         WiD29K0ZbhvtwMzspz7pKaod0PlRjLvR8wjxGVL1UcBpT2k4JfClHFwOv5kQNC8zug/c
         ifNGK1gl6YTmk+qUnCA96Azk56B+knStekJ6NY+S5F8jRO7YXQk3dH2xBJLV51TNXtys
         pdUvRwXCSdnndELVKCDRGr7XjoD4eusEYyyuKWK6XV+P3rxJ8NEWKOfWs4C6Oqba4sc5
         RNbxBE6icEcHzgtSRxzVwMXC8WYE4HsmIjVhxr9EMqkbCIwc5KH6eXPtCVa0E8bU2MBE
         g8mA==
X-Forwarded-Encrypted: i=1; AJvYcCUuVHQPFLUQNV3mDN9CAmZTfG3UDrSZdcskW2wQ69T8IuqvRijc6HoQ/dM/dTIZTPLyprd4LAz0S9D6194m58Q=@vger.kernel.org, AJvYcCXFtNfSUcsjebM/C6CZ/y9tYWunRaCyxF0iEZ7enTHLO0eWJeXF9RN7L2AQCZ2iXzUTKY09sygB@vger.kernel.org
X-Gm-Message-State: AOJu0YxVEoZqH0j7v6PzIiW7BiQ6WsZtn19l0XvPJvfehgWW9OeB2BaW
	LrEdeT//YgOI0Q57pBsRR1oTABBZewKbAZZzCmjQdmEdpNYdN0E=
X-Google-Smtp-Source: AGHT+IFpdl8odIgIosaOYUnp76mTfkZ06MYSjNplMHdQuOz4jSZ7fypmSjeYFuYjApFMHWCWPhMrZg==
X-Received: by 2002:a05:6a20:c888:b0:1cf:2853:bc6c with SMTP id adf61e73a8af0-1d8bcfa9fc0mr1954402637.33.1728618649804;
        Thu, 10 Oct 2024 20:50:49 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa0a645sm1858642b3a.94.2024.10.10.20.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:50:49 -0700 (PDT)
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
Subject: [bpf-next 1/4] selftests/bpf: migrate cgroup sock create test for setting iface/mark/prio
Date: Fri, 11 Oct 2024 03:50:35 +0000
Message-ID: <20241011035038.97568-2-danieltimlee@gmail.com>
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

This patch migrates the old test for cgroup BPF that sets
sk_bound_dev_if, mark, and priority when AF_INET{6} sockets are created.
The most closely related tests under selftests are 'test_sock' and
'sockopt'. However, these existing tests serve different purposes.
'test_sock' focuses mainly on verifying the socket binding process,
while 'sockopt' concentrates on testing the behavior of getsockopt and
setsockopt operations for various socket options.

Neither of these existing tests directly covers the ability of cgroup
BPF to set socket attributes such as sk_bound_dev_if, mark, and priority
during socket creation. To address this gap, this patch introduces a
migration of the old cgroup socket attribute test, now included as the
'sock_create' test in selftests/bpf. This ensures that the ability to
configure these attributes during socket creation is properly tested.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/Makefile                          |   2 -
 samples/bpf/test_cgrp2_sock.c                 | 296 ------------------
 samples/bpf/test_cgrp2_sock.sh                | 137 --------
 .../selftests/bpf/prog_tests/sock_create.c    | 256 +++++++++++++++
 4 files changed, 256 insertions(+), 435 deletions(-)
 delete mode 100644 samples/bpf/test_cgrp2_sock.c
 delete mode 100755 samples/bpf/test_cgrp2_sock.sh
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_create.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 7afe040cf43b..f514c6fb1ae2 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -27,7 +27,6 @@ tprogs-y += map_perf_test
 tprogs-y += test_overhead
 tprogs-y += test_cgrp2_array_pin
 tprogs-y += test_cgrp2_attach
-tprogs-y += test_cgrp2_sock
 tprogs-y += test_cgrp2_sock2
 tprogs-y += xdp_router_ipv4
 tprogs-y += test_current_task_under_cgroup
@@ -76,7 +75,6 @@ map_perf_test-objs := map_perf_test_user.o
 test_overhead-objs := test_overhead_user.o
 test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
 test_cgrp2_attach-objs := test_cgrp2_attach.o
-test_cgrp2_sock-objs := test_cgrp2_sock.o
 test_cgrp2_sock2-objs := test_cgrp2_sock2.o
 test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
 				       test_current_task_under_cgroup_user.o
diff --git a/samples/bpf/test_cgrp2_sock.c b/samples/bpf/test_cgrp2_sock.c
deleted file mode 100644
index 8ca2a445ffa1..000000000000
--- a/samples/bpf/test_cgrp2_sock.c
+++ /dev/null
@@ -1,296 +0,0 @@
-/* eBPF example program:
- *
- * - Loads eBPF program
- *
- *   The eBPF program sets the sk_bound_dev_if index in new AF_INET{6}
- *   sockets opened by processes in the cgroup.
- *
- * - Attaches the new program to a cgroup using BPF_PROG_ATTACH
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
-#include <net/if.h>
-#include <inttypes.h>
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-
-#include "bpf_insn.h"
-
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
-
-static int prog_load(__u32 idx, __u32 mark, __u32 prio)
-{
-	/* save pointer to context */
-	struct bpf_insn prog_start[] = {
-		BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
-	};
-	struct bpf_insn prog_end[] = {
-		BPF_MOV64_IMM(BPF_REG_0, 1), /* r0 = verdict */
-		BPF_EXIT_INSN(),
-	};
-
-	/* set sk_bound_dev_if on socket */
-	struct bpf_insn prog_dev[] = {
-		BPF_MOV64_IMM(BPF_REG_3, idx),
-		BPF_MOV64_IMM(BPF_REG_2, offsetof(struct bpf_sock, bound_dev_if)),
-		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, offsetof(struct bpf_sock, bound_dev_if)),
-	};
-
-	/* set mark on socket */
-	struct bpf_insn prog_mark[] = {
-		/* get uid of process */
-		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
-			     BPF_FUNC_get_current_uid_gid),
-		BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffffffff),
-
-		/* if uid is 0, use given mark, else use the uid as the mark */
-		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
-		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
-		BPF_MOV64_IMM(BPF_REG_3, mark),
-
-		/* set the mark on the new socket */
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-		BPF_MOV64_IMM(BPF_REG_2, offsetof(struct bpf_sock, mark)),
-		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, offsetof(struct bpf_sock, mark)),
-	};
-
-	/* set priority on socket */
-	struct bpf_insn prog_prio[] = {
-		BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
-		BPF_MOV64_IMM(BPF_REG_3, prio),
-		BPF_MOV64_IMM(BPF_REG_2, offsetof(struct bpf_sock, priority)),
-		BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3, offsetof(struct bpf_sock, priority)),
-	};
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.log_buf = bpf_log_buf,
-		.log_size = BPF_LOG_BUF_SIZE,
-	);
-
-	struct bpf_insn *prog;
-	size_t insns_cnt;
-	void *p;
-	int ret;
-
-	insns_cnt = sizeof(prog_start) + sizeof(prog_end);
-	if (idx)
-		insns_cnt += sizeof(prog_dev);
-
-	if (mark)
-		insns_cnt += sizeof(prog_mark);
-
-	if (prio)
-		insns_cnt += sizeof(prog_prio);
-
-	p = prog = malloc(insns_cnt);
-	if (!prog) {
-		fprintf(stderr, "Failed to allocate memory for instructions\n");
-		return EXIT_FAILURE;
-	}
-
-	memcpy(p, prog_start, sizeof(prog_start));
-	p += sizeof(prog_start);
-
-	if (idx) {
-		memcpy(p, prog_dev, sizeof(prog_dev));
-		p += sizeof(prog_dev);
-	}
-
-	if (mark) {
-		memcpy(p, prog_mark, sizeof(prog_mark));
-		p += sizeof(prog_mark);
-	}
-
-	if (prio) {
-		memcpy(p, prog_prio, sizeof(prog_prio));
-		p += sizeof(prog_prio);
-	}
-
-	memcpy(p, prog_end, sizeof(prog_end));
-	p += sizeof(prog_end);
-
-	insns_cnt /= sizeof(struct bpf_insn);
-
-	ret = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL",
-			    prog, insns_cnt, &opts);
-
-	free(prog);
-
-	return ret;
-}
-
-static int get_bind_to_device(int sd, char *name, size_t len)
-{
-	socklen_t optlen = len;
-	int rc;
-
-	name[0] = '\0';
-	rc = getsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, name, &optlen);
-	if (rc < 0)
-		perror("setsockopt(SO_BINDTODEVICE)");
-
-	return rc;
-}
-
-static unsigned int get_somark(int sd)
-{
-	unsigned int mark = 0;
-	socklen_t optlen = sizeof(mark);
-	int rc;
-
-	rc = getsockopt(sd, SOL_SOCKET, SO_MARK, &mark, &optlen);
-	if (rc < 0)
-		perror("getsockopt(SO_MARK)");
-
-	return mark;
-}
-
-static unsigned int get_priority(int sd)
-{
-	unsigned int prio = 0;
-	socklen_t optlen = sizeof(prio);
-	int rc;
-
-	rc = getsockopt(sd, SOL_SOCKET, SO_PRIORITY, &prio, &optlen);
-	if (rc < 0)
-		perror("getsockopt(SO_PRIORITY)");
-
-	return prio;
-}
-
-static int show_sockopts(int family)
-{
-	unsigned int mark, prio;
-	char name[16];
-	int sd;
-
-	sd = socket(family, SOCK_DGRAM, 17);
-	if (sd < 0) {
-		perror("socket");
-		return 1;
-	}
-
-	if (get_bind_to_device(sd, name, sizeof(name)) < 0) {
-		close(sd);
-		return 1;
-	}
-
-	mark = get_somark(sd);
-	prio = get_priority(sd);
-
-	close(sd);
-
-	printf("sd %d: dev %s, mark %u, priority %u\n", sd, name, mark, prio);
-
-	return 0;
-}
-
-static int usage(const char *argv0)
-{
-	printf("Usage:\n");
-	printf("  Attach a program\n");
-	printf("  %s -b bind-to-dev -m mark -p prio cg-path\n", argv0);
-	printf("\n");
-	printf("  Detach a program\n");
-	printf("  %s -d cg-path\n", argv0);
-	printf("\n");
-	printf("  Show inherited socket settings (mark, priority, and device)\n");
-	printf("  %s [-6]\n", argv0);
-	return EXIT_FAILURE;
-}
-
-int main(int argc, char **argv)
-{
-	__u32 idx = 0, mark = 0, prio = 0;
-	const char *cgrp_path = NULL;
-	int cg_fd, prog_fd, ret;
-	int family = PF_INET;
-	int do_attach = 1;
-	int rc;
-
-	while ((rc = getopt(argc, argv, "db:m:p:6")) != -1) {
-		switch (rc) {
-		case 'd':
-			do_attach = 0;
-			break;
-		case 'b':
-			idx = if_nametoindex(optarg);
-			if (!idx) {
-				idx = strtoumax(optarg, NULL, 0);
-				if (!idx) {
-					printf("Invalid device name\n");
-					return EXIT_FAILURE;
-				}
-			}
-			break;
-		case 'm':
-			mark = strtoumax(optarg, NULL, 0);
-			break;
-		case 'p':
-			prio = strtoumax(optarg, NULL, 0);
-			break;
-		case '6':
-			family = PF_INET6;
-			break;
-		default:
-			return usage(argv[0]);
-		}
-	}
-
-	if (optind == argc)
-		return show_sockopts(family);
-
-	cgrp_path = argv[optind];
-	if (!cgrp_path) {
-		fprintf(stderr, "cgroup path not given\n");
-		return EXIT_FAILURE;
-	}
-
-	if (do_attach && !idx && !mark && !prio) {
-		fprintf(stderr,
-			"One of device, mark or priority must be given\n");
-		return EXIT_FAILURE;
-	}
-
-	cg_fd = open(cgrp_path, O_DIRECTORY | O_RDONLY);
-	if (cg_fd < 0) {
-		printf("Failed to open cgroup path: '%s'\n", strerror(errno));
-		return EXIT_FAILURE;
-	}
-
-	if (do_attach) {
-		prog_fd = prog_load(idx, mark, prio);
-		if (prog_fd < 0) {
-			printf("Failed to load prog: '%s'\n", strerror(errno));
-			printf("Output from kernel verifier:\n%s\n-------\n",
-			       bpf_log_buf);
-			return EXIT_FAILURE;
-		}
-
-		ret = bpf_prog_attach(prog_fd, cg_fd,
-				      BPF_CGROUP_INET_SOCK_CREATE, 0);
-		if (ret < 0) {
-			printf("Failed to attach prog to cgroup: '%s'\n",
-			       strerror(errno));
-			return EXIT_FAILURE;
-		}
-	} else {
-		ret = bpf_prog_detach(cg_fd, BPF_CGROUP_INET_SOCK_CREATE);
-		if (ret < 0) {
-			printf("Failed to detach prog from cgroup: '%s'\n",
-			       strerror(errno));
-			return EXIT_FAILURE;
-		}
-	}
-
-	close(cg_fd);
-	return EXIT_SUCCESS;
-}
diff --git a/samples/bpf/test_cgrp2_sock.sh b/samples/bpf/test_cgrp2_sock.sh
deleted file mode 100755
index 36bd7cb46f06..000000000000
--- a/samples/bpf/test_cgrp2_sock.sh
+++ /dev/null
@@ -1,137 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# Test various socket options that can be set by attaching programs to cgroups.
-
-MY_DIR=$(dirname $0)
-TEST=$MY_DIR/test_cgrp2_sock
-CGRP_MNT="/tmp/cgroupv2-test_cgrp2_sock"
-
-################################################################################
-#
-print_result()
-{
-	local rc=$1
-	local status=" OK "
-
-	[ $rc -ne 0 ] && status="FAIL"
-
-	printf "%-50s    [%4s]\n" "$2" "$status"
-}
-
-check_sock()
-{
-	out=$($TEST)
-	echo $out | grep -q "$1"
-	if [ $? -ne 0 ]; then
-		print_result 1 "IPv4: $2"
-		echo "    expected: $1"
-		echo "        have: $out"
-		rc=1
-	else
-		print_result 0 "IPv4: $2"
-	fi
-}
-
-check_sock6()
-{
-	out=$($TEST -6)
-	echo $out | grep -q "$1"
-	if [ $? -ne 0 ]; then
-		print_result 1 "IPv6: $2"
-		echo "    expected: $1"
-		echo "        have: $out"
-		rc=1
-	else
-		print_result 0 "IPv6: $2"
-	fi
-}
-
-################################################################################
-#
-
-cleanup()
-{
-	echo $$ >> ${CGRP_MNT}/cgroup.procs
-	rmdir ${CGRP_MNT}/sockopts
-}
-
-cleanup_and_exit()
-{
-	local rc=$1
-	local msg="$2"
-
-	[ -n "$msg" ] && echo "ERROR: $msg"
-
-	$TEST -d ${CGRP_MNT}/sockopts
-	ip li del cgrp2_sock
-	umount ${CGRP_MNT}
-
-	exit $rc
-}
-
-
-################################################################################
-# main
-
-rc=0
-
-ip li add cgrp2_sock type dummy 2>/dev/null
-
-set -e
-mkdir -p ${CGRP_MNT}
-mount -t cgroup2 none ${CGRP_MNT}
-set +e
-
-
-# make sure we have a known start point
-cleanup 2>/dev/null
-
-mkdir -p ${CGRP_MNT}/sockopts
-[ $? -ne 0 ] && cleanup_and_exit 1 "Failed to create cgroup hierarchy"
-
-
-# set pid into cgroup
-echo $$ > ${CGRP_MNT}/sockopts/cgroup.procs
-
-# no bpf program attached, so socket should show no settings
-check_sock "dev , mark 0, priority 0" "No programs attached"
-check_sock6 "dev , mark 0, priority 0" "No programs attached"
-
-# verify device is set
-#
-$TEST -b cgrp2_sock ${CGRP_MNT}/sockopts
-if [ $? -ne 0 ]; then
-	cleanup_and_exit 1 "Failed to install program to set device"
-fi
-check_sock "dev cgrp2_sock, mark 0, priority 0" "Device set"
-check_sock6 "dev cgrp2_sock, mark 0, priority 0" "Device set"
-
-# verify mark is set
-#
-$TEST -m 666 ${CGRP_MNT}/sockopts
-if [ $? -ne 0 ]; then
-	cleanup_and_exit 1 "Failed to install program to set mark"
-fi
-check_sock "dev , mark 666, priority 0" "Mark set"
-check_sock6 "dev , mark 666, priority 0" "Mark set"
-
-# verify priority is set
-#
-$TEST -p 123 ${CGRP_MNT}/sockopts
-if [ $? -ne 0 ]; then
-	cleanup_and_exit 1 "Failed to install program to set priority"
-fi
-check_sock "dev , mark 0, priority 123" "Priority set"
-check_sock6 "dev , mark 0, priority 123" "Priority set"
-
-# all 3 at once
-#
-$TEST -b cgrp2_sock -m 666 -p 123 ${CGRP_MNT}/sockopts
-if [ $? -ne 0 ]; then
-	cleanup_and_exit 1 "Failed to install program to set device, mark and priority"
-fi
-check_sock "dev cgrp2_sock, mark 666, priority 123" "Priority set"
-check_sock6 "dev cgrp2_sock, mark 666, priority 123" "Priority set"
-
-cleanup_and_exit $rc
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_create.c b/tools/testing/selftests/bpf/prog_tests/sock_create.c
new file mode 100644
index 000000000000..072910c05c99
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_create.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <test_progs.h>
+#include "cgroup_helpers.h"
+
+static char bpf_log_buf[4096];
+static bool verbose;
+
+static struct sock_create_test {
+	const char			*descr;
+	const struct bpf_insn		insns[64];
+	enum bpf_attach_type		attach_type;
+	enum bpf_attach_type		expected_attach_type;
+
+	int				domain;
+	int				type;
+
+	int				optname;
+	int				optval;
+} tests[] = {
+	{
+		.descr = "AF_INET set priority",
+		.insns = {
+			/* r3 = 123 (priority) */
+			BPF_MOV64_IMM(BPF_REG_3, 123),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, priority)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_PRIORITY,
+		.optval = 123,
+	},
+	{
+		.descr = "AF_INET6 set priority",
+		.insns = {
+			/* r3 = 123 (priority) */
+			BPF_MOV64_IMM(BPF_REG_3, 123),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, priority)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_PRIORITY,
+		.optval = 123,
+	},
+	{
+		.descr = "AF_INET set mark",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* get uid of process */
+			BPF_EMIT_CALL(BPF_FUNC_get_current_uid_gid),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffffffff),
+
+			/* if uid is 0, use given mark(666), else use uid as the mark */
+			BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+			BPF_MOV64_IMM(BPF_REG_3, 666),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, mark)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_MARK,
+		.optval = 666,
+	},
+	{
+		.descr = "AF_INET6 set mark",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+
+			/* get uid of process */
+			BPF_EMIT_CALL(BPF_FUNC_get_current_uid_gid),
+			BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffffffff),
+
+			/* if uid is 0, use given mark(666), else use uid as the mark */
+			BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+			BPF_MOV64_IMM(BPF_REG_3, 666),
+
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, mark)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_MARK,
+		.optval = 666,
+	},
+	{
+		.descr = "AF_INET bound to iface",
+		.insns = {
+			/* r3 = 1 (lo interface) */
+			BPF_MOV64_IMM(BPF_REG_3, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, bound_dev_if)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_BINDTOIFINDEX,
+		.optval = 1,
+	},
+	{
+		.descr = "AF_INET6 bound to iface",
+		.insns = {
+			/* r3 = 1 (lo interface) */
+			BPF_MOV64_IMM(BPF_REG_3, 1),
+			BPF_STX_MEM(BPF_W, BPF_REG_1, BPF_REG_3,
+				    offsetof(struct bpf_sock, bound_dev_if)),
+
+			/* return 1 */
+			BPF_MOV64_IMM(BPF_REG_0, 1),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET6,
+		.type = SOCK_DGRAM,
+
+		.optname = SO_BINDTOIFINDEX,
+		.optval = 1,
+	},
+};
+
+static int load_prog(const struct bpf_insn *insns,
+		     enum bpf_attach_type expected_attach_type)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .expected_attach_type = expected_attach_type,
+		    .log_level = 2,
+		    .log_buf = bpf_log_buf,
+		    .log_size = sizeof(bpf_log_buf),
+	);
+	int fd, insns_cnt = 0;
+
+	for (;
+	     insns[insns_cnt].code != (BPF_JMP | BPF_EXIT);
+	     insns_cnt++) {
+	}
+	insns_cnt++;
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_CGROUP_SOCK, NULL, "GPL", insns,
+			   insns_cnt, &opts);
+	if (verbose && fd < 0)
+		fprintf(stderr, "%s\n", bpf_log_buf);
+
+	return fd;
+}
+
+static int run_test(int cgroup_fd, struct sock_create_test *test)
+{
+	int sock_fd, err, prog_fd, optval, ret = -1;
+	socklen_t optlen = sizeof(optval);
+
+	prog_fd = load_prog(test->insns, test->expected_attach_type);
+	if (prog_fd < 0) {
+		log_err("Failed to load BPF program");
+		return -1;
+	}
+
+	err = bpf_prog_attach(prog_fd, cgroup_fd, test->attach_type, 0);
+	if (err < 0) {
+		log_err("Failed to attach BPF program");
+		goto close_prog_fd;
+	}
+
+	sock_fd = socket(test->domain, test->type, 0);
+	if (sock_fd < 0) {
+		log_err("Failed to create socket");
+		goto detach_prog;
+	}
+
+	err = getsockopt(sock_fd, SOL_SOCKET, test->optname, &optval, &optlen);
+	if (err) {
+		log_err("Failed to call getsockopt");
+		goto cleanup;
+	}
+
+	if (optval != test->optval) {
+		errno = 0;
+		log_err("getsockopt returned unexpected optval");
+		goto cleanup;
+	}
+
+	ret = 0;
+
+cleanup:
+	close(sock_fd);
+detach_prog:
+	bpf_prog_detach2(prog_fd, cgroup_fd, test->attach_type);
+close_prog_fd:
+	close(prog_fd);
+	return ret;
+}
+
+void test_sock_create(void)
+{
+	int cgroup_fd, i;
+
+	cgroup_fd = test__join_cgroup("/sock_create");
+	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].descr))
+			continue;
+
+		ASSERT_OK(run_test(cgroup_fd, &tests[i]), tests[i].descr);
+	}
+
+	close(cgroup_fd);
+}
-- 
2.43.0


