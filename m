Return-Path: <linux-kselftest+bounces-15220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B747B950576
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C27286FF8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680B19D095;
	Tue, 13 Aug 2024 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gqEUwzhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729919ADB0;
	Tue, 13 Aug 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553125; cv=none; b=keJPdga2DmJmF+RtBQ7fFrEvPpWKQPYym+e3oL+JnW/H2qBIDCmSWTVvFfj5Q9NMiMXAcF4phZWXFfIidf4fvuChyoCM/cc8vyNb7DCWvB81q9jroFasb0B/7R2nyoK+6GoSJlAlgP5E5OQWd2N/mq3U3h0u2JB9cUH4idGdemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553125; c=relaxed/simple;
	bh=QxpY4DE4P+H8UUMKCaK7Xmiwi628RrBiASQNmf1fadI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUyn00DsVfzmJAg+XE34qrJ3ubW8zxLFeSnt9N2Az5mWkZGdAa4mLildxjlHvAJnVfEWRzifKzCMIrCWz1BSsQUEn7COMp3FrjoSCrgQW+zNNEJIgux+GFbsg6MDuIVa1z4JVBb2e3V66LKHNYCe/2NY3NVM0bJH8LOQC0xLk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gqEUwzhv; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12D48C000D;
	Tue, 13 Aug 2024 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723553115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/GXn9h3RHM5wwphHbpwclVPQWg74W6yJBxLK9qZd1Q=;
	b=gqEUwzhvY7/713EDY3yRrNgzp6M9fldYtLxYuOPFzmI/QA19g/sjTNyFxMVKUOccVcvoe4
	Xj820D0YiHXI3m/+4esUIA9jIs+Cz4A2MeTrm0l4eM7VLL4eOE9OF4IHIkS8B2F/CWtz64
	poQv7psQMwp97rY0rOKsTTdRVQxb+eCpenwLD7wRciaAVgWQU59JuQJSLBziSp+PRBQJaO
	QYUSGNEDjZPM+ZF57s1REWCRbcmNEp/eWnIgskAx7c+YamFHVC666XPMLLvL7OV+NRKPwQ
	vmhcL7Z150E9m1sCt3AIbtpLudAlUgKjwiJfiYhFiqP5NY8/gE9kPfY/wtZD0Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 13 Aug 2024 14:45:08 +0200
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240813-convert_cgroup_tests-v4-4-a33c03458cf6@bootlin.com>
References: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
In-Reply-To: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

test_skb_cgroup_id_user allows testing skb cgroup id retrieval at different
levels, but is not integrated in test_progs, so it is not run
automatically in CI. The test overlaps a bit with
cgroup_skb_sk_lookup_kern, which is integrated in test_progs and test
extensively skb cgroup helpers, but there is still one major difference
between the two tests which justifies the conversion:
cgroup_skb_sk_lookup_kern deals with a BPF_PROG_TYPE_CGROUP_SKB (attached
on a cgroup), while test_skb_cgroup_id_user deals with a
BPF_PROG_TYPE_SCHED_CLS (attached on a qdisc)

Convert test_skb_cgroup_id_user into test_progs framework in order to run
it automatically in CI. The main differences with the original test are the
following:
- rename the test to make it shorter and more straightforward regarding
  tested feature
- the wrapping shell script has been dropped since every setup step is now
  handled in the main C test file
- the test has been renamed for a shorter name and reflecting the tested
  API
- add dedicated assert log per level to ease test failure debugging
- use global variables instead of maps to access bpf prog data

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- close leaking socket
- close leaking cgroup file descriptor
- run test in dedicated network namespace

Changes in v2:
- use global variables instead of maps

The new test has been tested in a qemu environment:

  ./test_progs -a cgroup_ancestor
  44      cgroup_ancestor:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |   3 +-
 .../selftests/bpf/prog_tests/cgroup_ancestor.c     | 169 +++++++++++++++++++
 .../testing/selftests/bpf/progs/cgroup_ancestor.c  |  12 +-
 tools/testing/selftests/bpf/test_skb_cgroup_id.sh  |  67 --------
 .../selftests/bpf/test_skb_cgroup_id_user.c        | 183 ---------------------
 6 files changed, 172 insertions(+), 263 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index fd7ae37024e2..99ffea1fa5c6 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -19,7 +19,6 @@ test_sock
 urandom_read
 test_sockmap
 test_lirc_mode2_user
-test_skb_cgroup_id_user
 test_flow_dissector
 flow_dissector_load
 test_tcpnotify_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 29d689610ba2..b1259922d0aa 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -137,7 +137,7 @@ TEST_PROGS_EXTENDED := with_addr.sh \
 	test_xdp_vlan.sh test_bpftool.py
 
 # Compile but not part of 'make run_tests'
-TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
+TEST_GEN_PROGS_EXTENDED = \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
@@ -290,7 +290,6 @@ JSON_WRITER		:= $(OUTPUT)/json_writer.o
 CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
 NETWORK_HELPERS := $(OUTPUT)/network_helpers.o
 
-$(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sock: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_sockmap: $(CGROUP_HELPERS) $(TESTING_HELPERS)
 $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(TESTING_HELPERS) $(TRACE_HELPERS)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
new file mode 100644
index 000000000000..2965595cb166
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_ancestor.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "cgroup_helpers.h"
+#include "cgroup_ancestor.skel.h"
+
+#define VETH_PREFIX "test_cgid_"
+#define VETH_1 VETH_PREFIX "1"
+#define VETH_2 VETH_PREFIX "2"
+#define CGROUP_PATH "/skb_cgroup_test"
+#define TEST_NS "cgroup_ancestor_ns"
+#define NUM_CGROUP_LEVELS 4
+#define WAIT_AUTO_IP_MAX_ATTEMPT 10
+#define DST_ADDR "ff02::1"
+#define DST_PORT 1234
+#define MAX_ASSERT_NAME 32
+
+struct test_data {
+	struct cgroup_ancestor *skel;
+	struct bpf_tc_hook qdisc;
+	struct bpf_tc_opts tc_attach;
+	struct nstoken *ns;
+};
+
+static int send_datagram(void)
+{
+	unsigned char buf[] = "some random test data";
+	struct sockaddr_in6 addr = { .sin6_family = AF_INET6,
+				     .sin6_port = htons(DST_PORT),
+				     .sin6_scope_id = if_nametoindex(VETH_1) };
+	int sock, n;
+
+	if (!ASSERT_EQ(inet_pton(AF_INET6, DST_ADDR, &addr.sin6_addr), 1,
+		       "inet_pton"))
+		return -1;
+
+	sock = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_OK_FD(sock, "create socket"))
+		return sock;
+
+	n = sendto(sock, buf, sizeof(buf), 0, (const struct sockaddr *)&addr,
+		   sizeof(addr));
+	ASSERT_EQ(n, sizeof(buf), "send data");
+	close(sock);
+
+	return n  == sizeof(buf) ? 0 : n;
+}
+
+static int wait_local_ip(void)
+{
+	char *ping_cmd = ping_command(AF_INET6);
+	int i, err;
+
+	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
+		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
+				 VETH_1);
+		if (!err)
+			break;
+	}
+
+	return err;
+}
+
+static int setup_network(struct test_data *t)
+{
+	int ret;
+
+	SYS(fail, "ip netns add %s", TEST_NS);
+	t->ns = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(t->ns, "open netns"))
+		goto cleanup_ns;
+
+	SYS(close_ns, "ip link add dev %s type veth peer name %s",
+	    VETH_1, VETH_2);
+	SYS(close_ns, "ip link set %s up", VETH_1);
+	SYS(close_ns, "ip link set %s up", VETH_2);
+
+	ret = wait_local_ip();
+	if (!ASSERT_EQ(ret, 0, "wait local ip"))
+		goto cleanup_interfaces;
+
+	memset(&t->qdisc, 0, sizeof(t->qdisc));
+	t->qdisc.sz = sizeof(t->qdisc);
+	t->qdisc.attach_point = BPF_TC_EGRESS;
+	t->qdisc.ifindex = if_nametoindex(VETH_1);
+	if (!ASSERT_NEQ(t->qdisc.ifindex, 0, "if_nametoindex"))
+		goto cleanup_interfaces;
+	if (!ASSERT_OK(bpf_tc_hook_create(&t->qdisc), "qdisc add"))
+		goto cleanup_interfaces;
+
+	memset(&t->tc_attach, 0, sizeof(t->tc_attach));
+	t->tc_attach.sz = sizeof(t->tc_attach);
+	t->tc_attach.prog_fd = bpf_program__fd(t->skel->progs.log_cgroup_id);
+	if (!ASSERT_OK(bpf_tc_attach(&t->qdisc, &t->tc_attach), "filter add"))
+		goto cleanup_qdisc;
+
+	return 0;
+
+cleanup_qdisc:
+	bpf_tc_hook_destroy(&t->qdisc);
+cleanup_interfaces:
+	SYS_NOFAIL("ip link del %s", VETH_1);
+close_ns:
+	close_netns(t->ns);
+cleanup_ns:
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
+fail:
+	return 1;
+}
+
+static void cleanup_network(struct test_data *t)
+{
+	bpf_tc_detach(&t->qdisc, &t->tc_attach);
+	bpf_tc_hook_destroy(&t->qdisc);
+	/* Deleting first interface will also delete peer interface */
+	SYS_NOFAIL("ip link del %s", VETH_1);
+	close_netns(t->ns);
+	SYS_NOFAIL("ip netns del %s", TEST_NS);
+}
+
+static void check_ancestors_ids(struct test_data *t)
+{
+	__u64 expected_ids[NUM_CGROUP_LEVELS];
+	char assert_name[MAX_ASSERT_NAME];
+	__u32 level;
+
+	expected_ids[0] = get_cgroup_id("/.."); /* root cgroup */
+	expected_ids[1] = get_cgroup_id("");
+	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
+	expected_ids[3] = 0; /* non-existent cgroup */
+
+	for (level = 0; level < NUM_CGROUP_LEVELS; level++) {
+		snprintf(assert_name, MAX_ASSERT_NAME,
+			 "ancestor id at level %d", level);
+		ASSERT_EQ(t->skel->bss->cgroup_ids[level], expected_ids[level],
+			  assert_name);
+	}
+}
+
+void test_cgroup_ancestor(void)
+{
+	struct test_data t;
+	int cgroup_fd;
+
+	t.skel = cgroup_ancestor__open_and_load();
+	if (!ASSERT_OK_PTR(t.skel, "open and load"))
+		return;
+
+	cgroup_fd = cgroup_setup_and_join(CGROUP_PATH);
+	if (cgroup_fd < 0)
+		goto cleanup_progs;
+
+	if (setup_network(&t))
+		goto cleanup_cgroups;
+
+	if (send_datagram())
+		goto cleanup_network;
+
+	check_ancestors_ids(&t);
+
+cleanup_network:
+	cleanup_network(&t);
+cleanup_cgroups:
+	close(cgroup_fd);
+	cleanup_cgroup_environment();
+cleanup_progs:
+	cgroup_ancestor__destroy(t.skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_ancestor.c b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
index 4879645f5827..23c2e63e77a2 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_ancestor.c
@@ -10,22 +10,14 @@
 
 #define NUM_CGROUP_LEVELS	4
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, __u32);
-	__type(value, __u64);
-	__uint(max_entries, NUM_CGROUP_LEVELS);
-} cgroup_ids SEC(".maps");
+__u64 cgroup_ids[NUM_CGROUP_LEVELS];
 
 static __always_inline void log_nth_level(struct __sk_buff *skb, __u32 level)
 {
-	__u64 id;
-
 	/* [1] &level passed to external function that may change it, it's
 	 *     incompatible with loop unroll.
 	 */
-	id = bpf_skb_ancestor_cgroup_id(skb, level);
-	bpf_map_update_elem(&cgroup_ids, &level, &id, 0);
+	cgroup_ids[level] = bpf_skb_ancestor_cgroup_id(skb, level);
 }
 
 SEC("tc")
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh b/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
deleted file mode 100755
index d7dad49175c2..000000000000
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id.sh
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2018 Facebook
-
-set -eu
-
-wait_for_ip()
-{
-	local _i
-	echo -n "Wait for testing link-local IP to become available "
-	for _i in $(seq ${MAX_PING_TRIES}); do
-		echo -n "."
-		if $PING6 -c 1 -W 1 ff02::1%${TEST_IF} >/dev/null 2>&1; then
-			echo " OK"
-			return
-		fi
-		sleep 1
-	done
-	echo 1>&2 "ERROR: Timeout waiting for test IP to become available."
-	exit 1
-}
-
-setup()
-{
-	# Create testing interfaces not to interfere with current environment.
-	ip link add dev ${TEST_IF} type veth peer name ${TEST_IF_PEER}
-	ip link set ${TEST_IF} up
-	ip link set ${TEST_IF_PEER} up
-
-	wait_for_ip
-
-	tc qdisc add dev ${TEST_IF} clsact
-	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
-	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
-	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
-		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
-
-	BPF_PROG_ID=$(tc filter show dev ${TEST_IF} egress | \
-			awk '/ id / {sub(/.* id /, "", $0); print($1)}')
-}
-
-cleanup()
-{
-	ip link del ${TEST_IF} 2>/dev/null || :
-	ip link del ${TEST_IF_PEER} 2>/dev/null || :
-	rm -rf /sys/fs/bpf/${BPF_PROG_PIN}
-}
-
-main()
-{
-	trap cleanup EXIT 2 3 6 15
-	setup
-	${PROG} ${TEST_IF} ${BPF_PROG_ID}
-}
-
-DIR=$(dirname $0)
-TEST_IF="test_cgid_1"
-TEST_IF_PEER="test_cgid_2"
-MAX_PING_TRIES=5
-BPF_PROG_PIN="cgroup_ancestor"
-BPF_PROG_OBJ="${DIR}/${BPF_PROG_PIN}.bpf.o"
-BPF_PROG_NAME="log_cgroup_id"
-BPF_PROG_ID=0
-PROG="${DIR}/test_skb_cgroup_id_user"
-type ping6 >/dev/null 2>&1 && PING6="ping6" || PING6="ping -6"
-
-main
diff --git a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c b/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
deleted file mode 100644
index ed518d075d1d..000000000000
--- a/tools/testing/selftests/bpf/test_skb_cgroup_id_user.c
+++ /dev/null
@@ -1,183 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2018 Facebook
-
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include <arpa/inet.h>
-#include <net/if.h>
-#include <netinet/in.h>
-#include <sys/socket.h>
-#include <sys/types.h>
-
-
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-
-#include "cgroup_helpers.h"
-
-#define CGROUP_PATH		"/skb_cgroup_test"
-#define NUM_CGROUP_LEVELS	4
-
-/* RFC 4291, Section 2.7.1 */
-#define LINKLOCAL_MULTICAST	"ff02::1"
-
-static int mk_dst_addr(const char *ip, const char *iface,
-		       struct sockaddr_in6 *dst)
-{
-	memset(dst, 0, sizeof(*dst));
-
-	dst->sin6_family = AF_INET6;
-	dst->sin6_port = htons(1025);
-
-	if (inet_pton(AF_INET6, ip, &dst->sin6_addr) != 1) {
-		log_err("Invalid IPv6: %s", ip);
-		return -1;
-	}
-
-	dst->sin6_scope_id = if_nametoindex(iface);
-	if (!dst->sin6_scope_id) {
-		log_err("Failed to get index of iface: %s", iface);
-		return -1;
-	}
-
-	return 0;
-}
-
-static int send_packet(const char *iface)
-{
-	struct sockaddr_in6 dst;
-	char msg[] = "msg";
-	int err = 0;
-	int fd = -1;
-
-	if (mk_dst_addr(LINKLOCAL_MULTICAST, iface, &dst))
-		goto err;
-
-	fd = socket(AF_INET6, SOCK_DGRAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create UDP socket");
-		goto err;
-	}
-
-	if (sendto(fd, &msg, sizeof(msg), 0, (const struct sockaddr *)&dst,
-		   sizeof(dst)) == -1) {
-		log_err("Failed to send datagram");
-		goto err;
-	}
-
-	goto out;
-err:
-	err = -1;
-out:
-	if (fd >= 0)
-		close(fd);
-	return err;
-}
-
-int get_map_fd_by_prog_id(int prog_id)
-{
-	struct bpf_prog_info info = {};
-	__u32 info_len = sizeof(info);
-	__u32 map_ids[1];
-	int prog_fd = -1;
-	int map_fd = -1;
-
-	prog_fd = bpf_prog_get_fd_by_id(prog_id);
-	if (prog_fd < 0) {
-		log_err("Failed to get fd by prog id %d", prog_id);
-		goto err;
-	}
-
-	info.nr_map_ids = 1;
-	info.map_ids = (__u64) (unsigned long) map_ids;
-
-	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
-		log_err("Failed to get info by prog fd %d", prog_fd);
-		goto err;
-	}
-
-	if (!info.nr_map_ids) {
-		log_err("No maps found for prog fd %d", prog_fd);
-		goto err;
-	}
-
-	map_fd = bpf_map_get_fd_by_id(map_ids[0]);
-	if (map_fd < 0)
-		log_err("Failed to get fd by map id %d", map_ids[0]);
-err:
-	if (prog_fd >= 0)
-		close(prog_fd);
-	return map_fd;
-}
-
-int check_ancestor_cgroup_ids(int prog_id)
-{
-	__u64 actual_ids[NUM_CGROUP_LEVELS], expected_ids[NUM_CGROUP_LEVELS];
-	__u32 level;
-	int err = 0;
-	int map_fd;
-
-	expected_ids[0] = get_cgroup_id("/..");	/* root cgroup */
-	expected_ids[1] = get_cgroup_id("");
-	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
-	expected_ids[3] = 0; /* non-existent cgroup */
-
-	map_fd = get_map_fd_by_prog_id(prog_id);
-	if (map_fd < 0)
-		goto err;
-
-	for (level = 0; level < NUM_CGROUP_LEVELS; ++level) {
-		if (bpf_map_lookup_elem(map_fd, &level, &actual_ids[level])) {
-			log_err("Failed to lookup key %d", level);
-			goto err;
-		}
-		if (actual_ids[level] != expected_ids[level]) {
-			log_err("%llx (actual) != %llx (expected), level: %u\n",
-				actual_ids[level], expected_ids[level], level);
-			goto err;
-		}
-	}
-
-	goto out;
-err:
-	err = -1;
-out:
-	if (map_fd >= 0)
-		close(map_fd);
-	return err;
-}
-
-int main(int argc, char **argv)
-{
-	int cgfd = -1;
-	int err = 0;
-
-	if (argc < 3) {
-		fprintf(stderr, "Usage: %s iface prog_id\n", argv[0]);
-		exit(EXIT_FAILURE);
-	}
-
-	/* Use libbpf 1.0 API mode */
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-
-	cgfd = cgroup_setup_and_join(CGROUP_PATH);
-	if (cgfd < 0)
-		goto err;
-
-	if (send_packet(argv[1]))
-		goto err;
-
-	if (check_ancestor_cgroup_ids(atoi(argv[2])))
-		goto err;
-
-	goto out;
-err:
-	err = -1;
-out:
-	close(cgfd);
-	cleanup_cgroup_environment();
-	printf("[%s]\n", err ? "FAIL" : "PASS");
-	return err;
-}

-- 
2.46.0


