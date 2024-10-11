Return-Path: <linux-kselftest+bounces-19504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF09999B6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 06:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73672809B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 04:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39C20822E;
	Fri, 11 Oct 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcRiOn0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928CD207A36;
	Fri, 11 Oct 2024 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728619446; cv=none; b=XE3OIIOqjlpumHBzAJucg+GxD9ewfMK4qTiKcEeNnrKLO22ouCAHEoQiT2HglzMYrPItwQ4eFG1hB/Y4KNB3ehnGhDW9uj4oM/RjFchXF15jaYosoa/e/rUXTGtT6WSppkyXKeNGU4xd7n9LjI4X4Usuws+KOYcSVdjVuuMdVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728619446; c=relaxed/simple;
	bh=w4yZMdlHY5+OJ5aLF35s96kaseIEwBH2crDXrYu+b6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OorZ5AGvRW5oybigSBjfqCrE7vpv29tOdpRBjoqmn6nk4QZkQOLRWsiZODZ1MtwWJkZ/ioPlJBpg9t0IAFqgEcn/tm+JyekUiSE5H7dcyj66UXhy5ZRIqYvR/ZIRVpSlZ40aO5QO+hZpDoq9/6imM4aleFfVydSK5lAW06VZbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcRiOn0Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-207115e3056so13021815ad.2;
        Thu, 10 Oct 2024 21:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728619444; x=1729224244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kasmu9/ggl/0CmzSA7c+u+xGLon5zX8iCfWzEAuKatw=;
        b=RcRiOn0Q5zgtemSnCOySthbVIpeN6nRempTDvZNG43uzNLnfSH68Q7mFHuoWDHrPNq
         7ar5dNWaCNyUf28gTdhDM7eo2cSfGpyoGNz/dt407J1VcSvB2bkVOb3LuTetItbsI758
         yF4b1v+7B5sKpT07FlAjtuJtw8qwZtljkAbSs5KchFwqSPJaQvIzjTi2f0uwN9lPHQFx
         WDIgXuMtr3xbhotgqH7JL9eRy/3HsQkmOK9InE6qJvavrnf+KyDhiDYz1MH4HVWKm4yB
         ArD/jBBkw3cEnfI4nR9q3B6fdhC00LmwsFzhIps5ws0myuuOnfJMM35RzpFoGsBAN7xg
         tIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728619444; x=1729224244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kasmu9/ggl/0CmzSA7c+u+xGLon5zX8iCfWzEAuKatw=;
        b=eWv/q+zf4KXIUGUXt54gZXNhKCX2ihwGlFDje6Pip/fBcfz+CW56pUCEkoHAZ6g9Vx
         P1RuMIiBRAfeqeP3G5rc0bBtkXqj62zle6fm5bl++Dy78lTQ+HcdxKWJSUoO0EY1b2Ee
         S9+MD+mqBxWYytg38sjGKXl9VVLKBecvr/bCSQL2Airi7hrHLWDPmh4DTki7FdyD4Jrs
         KvLF8Cq2INjWL0NmdsWAyiY/Xgn5Bo5Ame5LiJVuTS2+Medh/kE9eP3SbtyGpnwYzKoX
         mFOEpdXQKXrY02xXyBzap+d4QzcM+2eNhZcLoYNBrVt8o36SP1UxzAIQOLJmhpaiH5xS
         boXw==
X-Forwarded-Encrypted: i=1; AJvYcCVAYQl/qhfvDicMhKhKfEcJXROW12DzavZP64wrRnG+Gq+T7GAnkPMTIdzspwBGsAabGFyaqNoP3sfRXQ77FbX2@vger.kernel.org, AJvYcCWY9Z6OV07JJohlieh2jSyXJGlsrKK9SkZ33AV5NlT2Qw/MJr6s1qYt19OZDRcchaosKC+F4wGkjAC3QUs=@vger.kernel.org, AJvYcCWdHAo11ota8Q2ec98crHaudjG9y/KVA87A0jPZeQaT5tOx+6bP2u3iMDqOySFj/jCfec3GbWvY@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6l+W5V6e1Zgq/clIwtfQcKTzh9UaoiUwe64H65mxD/Zy91MC
	UOoesTH81ETxwq7lbC/GqoZw2t2HsqdUYKDcY6LdX0UkHG9i8mY=
X-Google-Smtp-Source: AGHT+IHL5cAKVhWxu9zRewt2Jb02SJ1c/UBGHRtCl8A8RF1KNHp8WBOfKXzCI7R/eAlOTuGAzlOHFg==
X-Received: by 2002:a17:903:1247:b0:20b:7be8:8ecf with SMTP id d9443c01a7336-20ca16cc24cmr19818445ad.53.1728619443755;
        Thu, 10 Oct 2024 21:04:03 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0e7716sm16443865ad.122.2024.10.10.21.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 21:04:03 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH,bpf-next v2 2/4] selftests/bpf: migrate cgroup sock create tests for prohibitig sockets
Date: Fri, 11 Oct 2024 04:03:46 +0000
Message-ID: <20241011040348.98042-3-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011040348.98042-1-danieltimlee@gmail.com>
References: <20241011040348.98042-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch continues the migration and removal process for cgroup
sock_create tests to selftests.

The test being migrated verifies the ability of cgroup BPF to block the
creation of specific types of sockets using a verdict. Specifically, the
test denies socket creation when the socket is of type AF_INET{6},
SOCK_DGRAM, and IPPROTO_ICMP{V6}. If the requested socket type matches
these attributes, the cgroup BPF verdict blocks the socket creation.

As with the previous commit, this test currently lacks coverage in
selftests, so this patch migrates the functionality into the sock_create
tests under selftests. This migration ensures that the socket creation
blocking behavior with cgroup bpf program is properly tested within the
selftest framework.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
Chagnes in V2:
- commit message fix

---
 samples/bpf/Makefile                          |   2 -
 samples/bpf/sock_flags.bpf.c                  |  47 --------
 samples/bpf/test_cgrp2_sock2.c                |  95 ----------------
 samples/bpf/test_cgrp2_sock2.sh               | 103 ------------------
 .../selftests/bpf/prog_tests/sock_create.c    |  83 +++++++++++++-
 5 files changed, 80 insertions(+), 250 deletions(-)
 delete mode 100644 samples/bpf/sock_flags.bpf.c
 delete mode 100644 samples/bpf/test_cgrp2_sock2.c
 delete mode 100755 samples/bpf/test_cgrp2_sock2.sh

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f514c6fb1ae2..cdfda15e859c 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -27,7 +27,6 @@ tprogs-y += map_perf_test
 tprogs-y += test_overhead
 tprogs-y += test_cgrp2_array_pin
 tprogs-y += test_cgrp2_attach
-tprogs-y += test_cgrp2_sock2
 tprogs-y += xdp_router_ipv4
 tprogs-y += test_current_task_under_cgroup
 tprogs-y += trace_event
@@ -75,7 +74,6 @@ map_perf_test-objs := map_perf_test_user.o
 test_overhead-objs := test_overhead_user.o
 test_cgrp2_array_pin-objs := test_cgrp2_array_pin.o
 test_cgrp2_attach-objs := test_cgrp2_attach.o
-test_cgrp2_sock2-objs := test_cgrp2_sock2.o
 test_current_task_under_cgroup-objs := $(CGROUP_HELPERS) \
 				       test_current_task_under_cgroup_user.o
 trace_event-objs := trace_event_user.o $(TRACE_HELPERS)
diff --git a/samples/bpf/sock_flags.bpf.c b/samples/bpf/sock_flags.bpf.c
deleted file mode 100644
index 0da749f6a9e1..000000000000
--- a/samples/bpf/sock_flags.bpf.c
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "vmlinux.h"
-#include "net_shared.h"
-#include <bpf/bpf_helpers.h>
-
-SEC("cgroup/sock")
-int bpf_prog1(struct bpf_sock *sk)
-{
-	char fmt[] = "socket: family %d type %d protocol %d\n";
-	char fmt2[] = "socket: uid %u gid %u\n";
-	__u64 gid_uid = bpf_get_current_uid_gid();
-	__u32 uid = gid_uid & 0xffffffff;
-	__u32 gid = gid_uid >> 32;
-
-	bpf_trace_printk(fmt, sizeof(fmt), sk->family, sk->type, sk->protocol);
-	bpf_trace_printk(fmt2, sizeof(fmt2), uid, gid);
-
-	/* block AF_INET6, SOCK_DGRAM, IPPROTO_ICMPV6 sockets
-	 * ie., make ping6 fail
-	 */
-	if (sk->family == AF_INET6 &&
-	    sk->type == SOCK_DGRAM   &&
-	    sk->protocol == IPPROTO_ICMPV6)
-		return 0;
-
-	return 1;
-}
-
-SEC("cgroup/sock")
-int bpf_prog2(struct bpf_sock *sk)
-{
-	char fmt[] = "socket: family %d type %d protocol %d\n";
-
-	bpf_trace_printk(fmt, sizeof(fmt), sk->family, sk->type, sk->protocol);
-
-	/* block AF_INET, SOCK_DGRAM, IPPROTO_ICMP sockets
-	 * ie., make ping fail
-	 */
-	if (sk->family == AF_INET &&
-	    sk->type == SOCK_DGRAM  &&
-	    sk->protocol == IPPROTO_ICMP)
-		return 0;
-
-	return 1;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_cgrp2_sock2.c b/samples/bpf/test_cgrp2_sock2.c
deleted file mode 100644
index e7060aaa2f5a..000000000000
--- a/samples/bpf/test_cgrp2_sock2.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* eBPF example program:
- *
- * - Loads eBPF program
- *
- *   The eBPF program loads a filter from file and attaches the
- *   program to a cgroup using BPF_PROG_ATTACH
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
-#include <linux/bpf.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "bpf_insn.h"
-
-static int usage(const char *argv0)
-{
-	printf("Usage: %s cg-path filter-path [filter-id]\n", argv0);
-	return EXIT_FAILURE;
-}
-
-int main(int argc, char **argv)
-{
-	int cg_fd, err, ret = EXIT_FAILURE, filter_id = 0, prog_cnt = 0;
-	const char *link_pin_path = "/sys/fs/bpf/test_cgrp2_sock2";
-	struct bpf_link *link = NULL;
-	struct bpf_program *progs[2];
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-
-	if (argc < 3)
-		return usage(argv[0]);
-
-	if (argc > 3)
-		filter_id = atoi(argv[3]);
-
-	cg_fd = open(argv[1], O_DIRECTORY | O_RDONLY);
-	if (cg_fd < 0) {
-		printf("Failed to open cgroup path: '%s'\n", strerror(errno));
-		return ret;
-	}
-
-	obj = bpf_object__open_file(argv[2], NULL);
-	if (libbpf_get_error(obj)) {
-		printf("ERROR: opening BPF object file failed\n");
-		return ret;
-	}
-
-	bpf_object__for_each_program(prog, obj) {
-		progs[prog_cnt] = prog;
-		prog_cnt++;
-	}
-
-	if (filter_id >= prog_cnt) {
-		printf("Invalid program id; program not found in file\n");
-		goto cleanup;
-	}
-
-	/* load BPF program */
-	if (bpf_object__load(obj)) {
-		printf("ERROR: loading BPF object file failed\n");
-		goto cleanup;
-	}
-
-	link = bpf_program__attach_cgroup(progs[filter_id], cg_fd);
-	if (libbpf_get_error(link)) {
-		printf("ERROR: bpf_program__attach failed\n");
-		link = NULL;
-		goto cleanup;
-	}
-
-	err = bpf_link__pin(link, link_pin_path);
-	if (err < 0) {
-		printf("ERROR: bpf_link__pin failed: %d\n", err);
-		goto cleanup;
-	}
-
-	ret = EXIT_SUCCESS;
-
-cleanup:
-	bpf_link__destroy(link);
-	bpf_object__close(obj);
-	return ret;
-}
diff --git a/samples/bpf/test_cgrp2_sock2.sh b/samples/bpf/test_cgrp2_sock2.sh
deleted file mode 100755
index 82acff93d739..000000000000
--- a/samples/bpf/test_cgrp2_sock2.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-BPFFS=/sys/fs/bpf
-MY_DIR=$(dirname $0)
-TEST=$MY_DIR/test_cgrp2_sock2
-LINK_PIN=$BPFFS/test_cgrp2_sock2
-BPF_PROG=$MY_DIR/sock_flags.bpf.o
-
-function config_device {
-	ip netns add at_ns0
-	ip link add veth0 type veth peer name veth0b
-	ip link set veth0 netns at_ns0
-	ip netns exec at_ns0 sysctl -q net.ipv6.conf.veth0.disable_ipv6=0
-	ip netns exec at_ns0 ip addr add 172.16.1.100/24 dev veth0
-	ip netns exec at_ns0 ip addr add 2401:db00::1/64 dev veth0 nodad
-	ip netns exec at_ns0 ip link set dev veth0 up
-	sysctl -q net.ipv6.conf.veth0b.disable_ipv6=0
-	ip addr add 172.16.1.101/24 dev veth0b
-	ip addr add 2401:db00::2/64 dev veth0b nodad
-	ip link set veth0b up
-}
-
-function config_cgroup {
-	rm -rf /tmp/cgroupv2
-	mkdir -p /tmp/cgroupv2
-	mount -t cgroup2 none /tmp/cgroupv2
-	mkdir -p /tmp/cgroupv2/foo
-	echo $$ >> /tmp/cgroupv2/foo/cgroup.procs
-}
-
-function config_bpffs {
-	if mount | grep $BPFFS > /dev/null; then
-		echo "bpffs already mounted"
-	else
-		echo "bpffs not mounted. Mounting..."
-		mount -t bpf none $BPFFS
-	fi
-}
-
-function attach_bpf {
-	$TEST /tmp/cgroupv2/foo $BPF_PROG $1
-	[ $? -ne 0 ] && exit 1
-}
-
-function cleanup {
-	rm -rf $LINK_PIN
-	ip link del veth0b
-	ip netns delete at_ns0
-	umount /tmp/cgroupv2
-	rm -rf /tmp/cgroupv2
-}
-
-cleanup 2>/dev/null
-
-set -e
-config_device
-config_cgroup
-config_bpffs
-set +e
-
-#
-# Test 1 - fail ping6
-#
-attach_bpf 0
-ping -c1 -w1 172.16.1.100
-if [ $? -ne 0 ]; then
-	echo "ping failed when it should succeed"
-	cleanup
-	exit 1
-fi
-
-ping6 -c1 -w1 2401:db00::1
-if [ $? -eq 0 ]; then
-	echo "ping6 succeeded when it should not"
-	cleanup
-	exit 1
-fi
-
-rm -rf $LINK_PIN
-sleep 1                 # Wait for link detach
-
-#
-# Test 2 - fail ping
-#
-attach_bpf 1
-ping6 -c1 -w1 2401:db00::1
-if [ $? -ne 0 ]; then
-	echo "ping6 failed when it should succeed"
-	cleanup
-	exit 1
-fi
-
-ping -c1 -w1 172.16.1.100
-if [ $? -eq 0 ]; then
-	echo "ping succeeded when it should not"
-	cleanup
-	exit 1
-fi
-
-cleanup
-echo
-echo "*** PASS ***"
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_create.c b/tools/testing/selftests/bpf/prog_tests/sock_create.c
index 072910c05c99..17a3713621dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_create.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_create.c
@@ -6,6 +6,11 @@
 static char bpf_log_buf[4096];
 static bool verbose;

+enum sock_create_test_error {
+	OK = 0,
+	DENY_CREATE,
+};
+
 static struct sock_create_test {
 	const char			*descr;
 	const struct bpf_insn		insns[64];
@@ -14,9 +19,11 @@ static struct sock_create_test {

 	int				domain;
 	int				type;
+	int				protocol;

 	int				optname;
 	int				optval;
+	enum sock_create_test_error	error;
 } tests[] = {
 	{
 		.descr = "AF_INET set priority",
@@ -164,6 +171,72 @@ static struct sock_create_test {
 		.optname = SO_BINDTOIFINDEX,
 		.optval = 1,
 	},
+	{
+		.descr = "block AF_INET, SOCK_DGRAM, IPPROTO_ICMP socket",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),	/* r0 = verdict */
+
+			/* sock->family == AF_INET */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, family)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, AF_INET, 5),
+
+			/* sock->type == SOCK_DGRAM */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, type)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, SOCK_DGRAM, 3),
+
+			/* sock->protocol == IPPROTO_ICMP */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, protocol)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, IPPROTO_ICMP, 1),
+
+			/* return 0 (block) */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_ICMP,
+
+		.error = DENY_CREATE,
+	},
+	{
+		.descr = "block AF_INET6, SOCK_DGRAM, IPPROTO_ICMPV6 socket",
+		.insns = {
+			BPF_MOV64_IMM(BPF_REG_0, 1),	/* r0 = verdict */
+
+			/* sock->family == AF_INET6 */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, family)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, AF_INET6, 5),
+
+			/* sock->type == SOCK_DGRAM */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, type)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, SOCK_DGRAM, 3),
+
+			/* sock->protocol == IPPROTO_ICMPV6 */
+			BPF_LDX_MEM(BPF_H, BPF_REG_2, BPF_REG_1,
+				    offsetof(struct bpf_sock, protocol)),
+			BPF_JMP_IMM(BPF_JNE, BPF_REG_2, IPPROTO_ICMPV6, 1),
+
+			/* return 0 (block) */
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.expected_attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+		.attach_type = BPF_CGROUP_INET_SOCK_CREATE,
+
+		.domain = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_ICMPV6,
+
+		.error = DENY_CREATE,
+	},
 };

 static int load_prog(const struct bpf_insn *insns,
@@ -208,9 +281,13 @@ static int run_test(int cgroup_fd, struct sock_create_test *test)
 		goto close_prog_fd;
 	}

-	sock_fd = socket(test->domain, test->type, 0);
+	sock_fd = socket(test->domain, test->type, test->protocol);
 	if (sock_fd < 0) {
-		log_err("Failed to create socket");
+		if (test->error == DENY_CREATE)
+			ret = 0;
+		else
+			log_err("Failed to create socket");
+
 		goto detach_prog;
 	}

@@ -226,7 +303,7 @@ static int run_test(int cgroup_fd, struct sock_create_test *test)
 		goto cleanup;
 	}

-	ret = 0;
+	ret = test->error != OK;

 cleanup:
 	close(sock_fd);
--
2.43.0

