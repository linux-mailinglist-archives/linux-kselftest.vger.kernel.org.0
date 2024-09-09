Return-Path: <linux-kselftest+bounces-17550-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E6972319
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 22:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD94285525
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB5189916;
	Mon,  9 Sep 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PPrKG2jm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F31304BA;
	Mon,  9 Sep 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912172; cv=none; b=lOD3Q+CGrw9xcHNQBsI7q9gTF+tqmEW9/G9Q8mLAXWRIAqJNZiCfqGb3HVfXvjZw4qeggmPwq/MNDYYwzfXDVHna82pYPV9lRm2ETVxL7ld6fDeK6OuAXVT/9ZMOCULrkYk6fI3UMS+OFCaoqDyygAsF86uHSOfj4jtZC8zb6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912172; c=relaxed/simple;
	bh=YPZJX5GM8MTmmDaCJ7S2Z/DnqO0pQ9if8C8zL4Nyqi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uSaaFnd+5ReUMFoz2E/vE7/MgBKNpt3prO2wJ5ZegAkvAQxvPsgmnV6MjeBGoAwBkH6tbaAQhsgvBnUq45cfljP2HihGpUQdXuoprd2/ZTpmY69Xzv2sHcsYPP17CAJE3PnF2Sv0iSOBCHvZatiuvboX+r44NvE5qXij9kN2fU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PPrKG2jm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7668DFF802;
	Mon,  9 Sep 2024 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725912166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h34PgQghyoT0NS64qi9cn1l0tY3L7fKHCbMlwPejYxc=;
	b=PPrKG2jmJpeAuXSsYb/INRrabll7meFSeP2Zre+JWRYzqPVtBaDdu+sngsFMzCbY66WYV4
	JgN810L7jpibrYzNUh8Rw+onJCk6XaLCfDrmdGjuGc3W2DezuzuMUmvjtuMUx8fndcTA5z
	FUwhgaEklTGXS/++ancgstB33qG/Ky6lIKEVqm7EpTyICDymUJyAHNkfePB0FRWXv+LH/U
	1/xZGf8kyf8j4OoytcPmoOA5sasUq05gDYShxtSifvoO749mekxiBT+/JqKk8OHyz3lo8C
	Pyob7FTtrPlvSgNC2hxRGcI0tAaxZfKq73n3mSoKImAQCYHIJhN2jl5XxXX86g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 09 Sep 2024 22:02:07 +0200
Subject: [PATCH bpf-next] selftests/bpf: convert test_xdp_features.sh to
 test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-convert_xdp_tests-v1-1-925be5fbee3c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD5U32YC/x3MwQqEIBRG4VeJu06wHAp6lYhI/Z25GxOvhBC9e
 zLLb3HOTYLMEFq6mzIuFj5jw9B35H5H/EKxb6ZRjx89G63cGS/kslef9gIpopzz02QDjPGWWpc
 yAtf/cyWbgoqohbbneQGb5pbKbQAAAA==
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

test_xdp_features.sh is a shell script allowing to test that xdp features
advertised by an interface are indeed delivered. The test works by starting
two instance of the same program, both attaching specific xdp programs to
each side of a veth link, and then make those programs manage packets and
collect stats to check whether tested XDP feature is indeed delivered or
not. However this test is not integrated in test_progs framework and so can
not run automatically in CI.

Rewrite test_xdp_features to integrate it in test_progs so it can run
automatically in CI. The main changes brought by the rewrite are the
following:
- instead of running to separated processes (each one managing either the
  tester veth or the DUT vet), run a single process
- slightly change testing direction (v0 is the tester in local namespace,
  v1 is the Device Under Test in remote namespace)
- group all tests previously managed by test_xdp_features as subtests (one
  per tested XDP feature). As a consequence, run only once some steps
  instead of once per subtest (eg: starting/stopping the udp server). On
  the contrary, make sure that each subtest properly cleans up its state
  (ie detach xdp programs, reset test stats, etc)
- since there is now a single process, get rid of the "control" tcp channel
  used to configure DUT. Configuring the DUT now only consists in switching
  to DUT network namespace and run the relevant commands
- since there is no more control channel, get rid of TLVs, keep only the
  CMD_ECHO packet type, and set it as a magic
- simplify network setup: use only ipv6 instead of both ipv4 and ipv6,
  force static neighbours instead of waiting for autoconfiguration, do not
  force gro (fetch xdp features only once xdp programs are loaded instead)

The existing XDP programs are reused, with some minor changes:
- tester and dut stats maps are converted to global variables for easier
  usage
- programs do not use TLV struct anymore but the magic replacing the echo
  command
- avoid to accidentally make tests pass: drop packets instead of forwarding
  them to userspace when they do not match the expected payload

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
The xdp_features rewrite has been tested in a x86_64 qemu environment on my
machine and in CI. In my environment, the test takes a bit less than 2s to
execute.

  # ./test_progs -a xdp_features
  #561/1   xdp_features/XDP_PASS:OK
  #561/2   xdp_features/XDP_DROP:OK
  #561/3   xdp_features/XDP_ABORTED:OK
  #561/4   xdp_features/XDP_TX:OK
  #561/5   xdp_features/XDP_REDIRECT:OK
  #561/6   xdp_features/XDP_NDO_XMIT:OK
  #561     xdp_features:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
---
 tools/testing/selftests/bpf/.gitignore             |   1 -
 tools/testing/selftests/bpf/Makefile               |  10 +-
 .../selftests/bpf/prog_tests/xdp_features.c        | 446 +++++++++++++
 tools/testing/selftests/bpf/progs/xdp_features.c   |  49 +-
 tools/testing/selftests/bpf/test_xdp_features.sh   | 107 ---
 tools/testing/selftests/bpf/xdp_features.c         | 718 ---------------------
 tools/testing/selftests/bpf/xdp_features.h         |  17 +-
 7 files changed, 462 insertions(+), 886 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index e6533b3400de..93bf35213042 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -48,4 +48,3 @@ xskxceiver
 xdp_redirect_multi
 xdp_synproxy
 xdp_hw_metadata
-xdp_features
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 04716a5e43f1..db4a802c3e06 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -145,8 +145,7 @@ TEST_PROGS := test_kmod.sh \
 	test_bpftool.sh \
 	test_bpftool_metadata.sh \
 	test_doc_build.sh \
-	test_xsk.sh \
-	test_xdp_features.sh
+	test_xsk.sh
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh ima_setup.sh verify_sig_setup.sh \
@@ -157,7 +156,7 @@ TEST_GEN_PROGS_EXTENDED = \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	bpf_test_no_cfi.ko
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -519,7 +518,6 @@ test_subskeleton_lib.skel.h-deps := test_subskeleton_lib2.bpf.o test_subskeleton
 test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
-xdp_features.skel.h-deps := xdp_features.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
@@ -787,10 +785,6 @@ $(OUTPUT)/xdp_hw_metadata: xdp_hw_metadata.c $(OUTPUT)/network_helpers.o $(OUTPU
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
 
-$(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp_features.skel.h | $(OUTPUT)
-	$(call msg,BINARY,,$@)
-	$(Q)$(CC) $(CFLAGS) $(filter %.a %.o %.c,$^) $(LDLIBS) -o $@
-
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_features.c b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
new file mode 100644
index 000000000000..0daf868dd478
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_features.c
@@ -0,0 +1,446 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/**
+ * Test XDP features
+ *
+ * Sets up a veth pair, and for each xdp feature under test:
+ * - asks the tested interface its xdp capabilities through bpf_xdp_query
+ * - attach and run some specific programs on both interfaces to check if
+ *   announced capability is respected
+ */
+#include <pthread.h>
+#include <linux/if_link.h>
+#include <linux/netdev.h>
+#include <linux/if_link.h>
+#include <sys/socket.h>
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "xdp_features.skel.h"
+#include "xdp_features.h"
+
+#define TESTER_VETH	"v0"
+#define TESTER_MAC	"00:11:22:33:44:55"
+#define TESTER_VETH_IPV6	"2001:db8::1"
+#define DUT_NS	"xdp_features_ns"
+#define DUT_VETH	"v1"
+#define DUT_MAC	"aa:bb:cc:dd:ee:ff"
+#define DUT_VETH_IPV6	"2001:db8::11"
+#define IP6_MASK	64
+#define LOOP_DELAY_US	10000
+#define TEST_NAME_MAX_LEN	32
+#define TEST_PACKET_COUNT	10
+
+struct test_data {
+	struct xdp_features *skel;
+	pthread_t dut_echo_thread;
+	int echo_server_sock;
+	int tester_ifindex;
+	int dut_ifindex;
+	struct sockaddr_storage tester_addr;
+	struct sockaddr_storage dut_addr;
+	bool quit_dut_echo_thread;
+};
+
+static void *run_dut_echo_thread(void *arg)
+{
+	struct test_data *t = (struct test_data *)arg;
+	__u32 magic;
+
+	while (!t->quit_dut_echo_thread) {
+		struct sockaddr_storage addr;
+		socklen_t addrlen;
+		size_t n;
+
+		n = recvfrom(t->echo_server_sock, &magic, sizeof(magic),
+			     MSG_WAITALL, (struct sockaddr *)&addr, &addrlen);
+		if (n != sizeof(magic)) {
+			usleep(LOOP_DELAY_US);
+			continue;
+		}
+
+		if (htonl(magic) != CMD_ECHO)
+			continue;
+
+		/* Answer echo command with the very same message */
+		sendto(t->echo_server_sock, &magic, sizeof(magic),
+		       MSG_NOSIGNAL | MSG_CONFIRM, (struct sockaddr *)&addr,
+		       addrlen);
+	}
+	pthread_exit(NULL);
+}
+
+static int dut_start_echo_server(struct test_data *t)
+{
+	struct nstoken *token;
+	int err = 0, flags;
+
+	token = open_netns(DUT_NS);
+	if (!ASSERT_OK_PTR(token, "open dut ns"))
+		return -EINVAL;
+
+	t->echo_server_sock =
+		start_server(AF_INET6, SOCK_DGRAM, NULL, DUT_ECHO_PORT, 0);
+	if (!ASSERT_OK_FD(t->echo_server_sock, "start dut echo server")) {
+		err = t->echo_server_sock;
+		goto restore_ns;
+	}
+
+	flags = fcntl(t->echo_server_sock, F_GETFL, 0);
+	err = fcntl(t->echo_server_sock, F_SETFL, flags | O_NONBLOCK);
+	if (!ASSERT_OK(err, "set non-blocking socket"))
+		goto close_server;
+
+	err = pthread_create(&t->dut_echo_thread, NULL, run_dut_echo_thread, t);
+	if (!ASSERT_OK(err, "start dut echo thread"))
+		goto close_server;
+
+	close_netns(token);
+	return 0;
+
+close_server:
+	close(t->echo_server_sock);
+restore_ns:
+	close_netns(token);
+	return err;
+}
+
+static void dut_stop_echo_server(struct test_data *t)
+{
+	struct nstoken *token;
+
+	token = open_netns(DUT_NS);
+	if (!ASSERT_OK_PTR(token, "open dut ns"))
+		return;
+
+	t->quit_dut_echo_thread = true;
+	pthread_join(t->dut_echo_thread, NULL);
+
+	close(t->echo_server_sock);
+	close_netns(token);
+}
+
+static int dut_attach_xdp_prog(struct test_data *t, int flags,
+			       enum netdev_xdp_act drv_feature,
+			       enum xdp_action action)
+{
+	struct bpf_program *prog;
+	unsigned int key = 0;
+	int err, fd = 0;
+
+	if (drv_feature == NETDEV_XDP_ACT_NDO_XMIT) {
+		struct bpf_devmap_val entry = { .ifindex = t->dut_ifindex };
+
+		err = bpf_map__update_elem(t->skel->maps.dev_map, &key,
+					   sizeof(key), &entry, sizeof(entry),
+					   0);
+		if (!ASSERT_OK(err, "update dev map"))
+			return err;
+
+		fd = bpf_program__fd(t->skel->progs.xdp_do_redirect_cpumap);
+		action = XDP_REDIRECT;
+	}
+
+	switch (action) {
+	case XDP_TX:
+		prog = t->skel->progs.xdp_do_tx;
+		break;
+	case XDP_DROP:
+		prog = t->skel->progs.xdp_do_drop;
+		break;
+	case XDP_ABORTED:
+		prog = t->skel->progs.xdp_do_aborted;
+		break;
+	case XDP_PASS:
+		prog = t->skel->progs.xdp_do_pass;
+		break;
+	case XDP_REDIRECT: {
+		struct bpf_cpumap_val entry = {
+			.qsize = 4096,
+			.bpf_prog.fd = fd,
+		};
+
+		err = bpf_map__update_elem(t->skel->maps.cpu_map, &key,
+					   sizeof(key), &entry, sizeof(entry),
+					   0);
+		if (!ASSERT_OK(err, "update cpu map"))
+			return err;
+
+		prog = t->skel->progs.xdp_do_redirect;
+		break;
+	}
+	default:
+		return -ENOTSUP;
+	}
+
+	err = bpf_xdp_attach(t->dut_ifindex, bpf_program__fd(prog), flags,
+			     NULL);
+	ASSERT_OK(err, "attach xdp prog to dut");
+	return err;
+}
+
+static int dut_start_test(struct test_data *t, enum netdev_xdp_act drv_feature,
+			  enum xdp_action action)
+{
+	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
+	struct nstoken *token = open_netns(DUT_NS);
+	int err;
+
+	if (!ASSERT_OK_PTR(token, "open dut ns"))
+		return -EINVAL;
+
+	err = dut_attach_xdp_prog(t, flags, drv_feature, action);
+	ASSERT_OK(err, "attach xdp program to dut");
+	close_netns(token);
+
+	return err;
+}
+
+static void dut_stop_test(struct test_data *t)
+{
+	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
+	struct nstoken *token = open_netns(DUT_NS);
+
+	if (!ASSERT_OK_PTR(token, "open dut ns"))
+		return;
+
+	bpf_xdp_detach(t->dut_ifindex, flags, NULL);
+	close_netns(token);
+}
+
+static int dut_get_xdp_features(struct test_data *t, __u64 *xdp_features)
+{
+	struct nstoken *token = open_netns(DUT_NS);
+	int err;
+
+	if (!ASSERT_OK_PTR(token, "open dut ns"))
+		return -EINVAL;
+
+	LIBBPF_OPTS(bpf_xdp_query_opts, opts);
+	err = bpf_xdp_query(t->dut_ifindex, XDP_FLAGS_DRV_MODE, &opts);
+	close_netns(token);
+
+	if (ASSERT_OK(err, "get dut interface xdp features"))
+		*xdp_features = opts.feature_flags;
+
+	return err;
+}
+
+static int send_echo_msg(struct test_data *t)
+{
+	__u32 magic = htonl(CMD_ECHO);
+	int sockfd, n;
+
+	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (!ASSERT_OK_FD(sockfd, "open tester socket"))
+		return sockfd;
+
+	n = sendto(sockfd, &magic, sizeof(magic), MSG_NOSIGNAL | MSG_CONFIRM,
+		   (struct sockaddr *)&t->dut_addr,
+		   sizeof(struct sockaddr_storage));
+	close(sockfd);
+
+	return n == sizeof(magic) ? 0 : -EINVAL;
+}
+
+static bool tester_collect_detected_cap(struct test_data *t,
+					enum netdev_xdp_act drv_feature,
+					enum xdp_action action)
+{
+	if (!t->skel->bss->dut_stats)
+		return false;
+
+	if (drv_feature == NETDEV_XDP_ACT_NDO_XMIT)
+		return t->skel->bss->tester_stats > 0;
+
+	switch (action) {
+	case XDP_PASS:
+	case XDP_TX:
+	case XDP_REDIRECT:
+		return t->skel->bss->tester_stats > 0;
+	case XDP_DROP:
+	case XDP_ABORTED:
+		return t->skel->bss->tester_stats == 0;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static void reset_test_stats(struct test_data *t,
+			     struct sockaddr_storage *tester_addr,
+			     struct sockaddr_storage *dut_addr)
+{
+	t->skel->bss->tester_stats = 0;
+	t->skel->bss->dut_stats = 0;
+}
+
+static int setup_network(struct test_data *t)
+{
+	struct nstoken *token;
+	int err;
+
+	err = make_sockaddr(AF_INET6, DUT_VETH_IPV6, DUT_ECHO_PORT,
+			    &t->dut_addr, NULL);
+	if (!ASSERT_OK(err, "dut data addr"))
+		return -1;
+
+	err = make_sockaddr(AF_INET6, TESTER_VETH_IPV6, 0, &t->tester_addr,
+			    NULL);
+	if (!ASSERT_OK(err, "tester addr"))
+		return -1;
+
+	/* Create interfaces and testing namespace */
+	SYS(fail, "ip netns add %s", DUT_NS);
+	SYS(cleanup_ns,
+	    "ip link add %s address %s type veth peer name %s netns %s address %s",
+	    TESTER_VETH, TESTER_MAC, DUT_VETH, DUT_NS, DUT_MAC);
+
+	/* Configure tester side in local namespace */
+	SYS(cleanup_interfaces, "ip a add %s/%d nodad dev %s", TESTER_VETH_IPV6,
+	    IP6_MASK, TESTER_VETH);
+	SYS(cleanup_interfaces, "ip link set %s up", TESTER_VETH);
+	SYS(cleanup_interfaces,
+	    "ethtool -K %s tx-checksumming off > /dev/null 2>&1", TESTER_VETH);
+	SYS(cleanup_interfaces, "ip neigh add %s dev %s lladdr %s",
+	    DUT_VETH_IPV6, TESTER_VETH, DUT_MAC);
+	t->tester_ifindex = if_nametoindex(TESTER_VETH);
+	if (!ASSERT_NEQ(t->tester_ifindex, 0,
+			"get tester veth interface index"))
+		goto cleanup_interfaces;
+
+	/* Configure dut side in remote namespace */
+	token = open_netns(DUT_NS);
+	if (!ASSERT_OK_PTR(token, "switch to dut ns"))
+		goto cleanup_interfaces;
+	SYS(restore_ns, "ip link set %s up", DUT_VETH);
+	SYS(restore_ns, "ip a add %s/%d nodad dev %s", DUT_VETH_IPV6, IP6_MASK,
+	    DUT_VETH);
+	SYS(restore_ns, "ethtool -K %s tx-checksumming off > /dev/null 2>&1",
+	    DUT_VETH);
+	SYS(restore_ns, "ip neigh add %s dev %s lladdr %s", TESTER_VETH_IPV6,
+	    DUT_VETH, TESTER_MAC);
+	t->dut_ifindex = if_nametoindex(DUT_VETH);
+	if (!ASSERT_NEQ(t->dut_ifindex, 0, "get dut veth interface index"))
+		goto restore_ns;
+	close_netns(token);
+
+	return 0;
+
+restore_ns:
+	close_netns(token);
+cleanup_interfaces:
+	SYS_NOFAIL("ip link del %s", TESTER_VETH);
+cleanup_ns:
+	SYS_NOFAIL("ip netns del %s", DUT_NS);
+fail:
+	return 1;
+}
+
+static void cleanup_network(void)
+{
+	SYS_NOFAIL("ip netns del %s", DUT_NS);
+	SYS_NOFAIL("ip link del %s", TESTER_VETH);
+}
+
+static int tester_run(char *name, struct test_data *t,
+		      enum netdev_xdp_act drv_feature, enum xdp_action action)
+{
+	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
+	unsigned long long advertised_feature;
+
+	char test_name[TEST_NAME_MAX_LEN];
+	struct bpf_program *prog;
+	int i, err = -EINVAL;
+	bool detected_cap;
+
+	if (drv_feature == NETDEV_XDP_ACT_NDO_XMIT || action == XDP_TX)
+		prog = t->skel->progs.xdp_tester_check_tx;
+	else
+		prog = t->skel->progs.xdp_tester_check_rx;
+
+	err = bpf_xdp_attach(t->tester_ifindex, bpf_program__fd(prog), flags,
+			     NULL);
+	if (!ASSERT_OK(err, "attach xdp program to tester"))
+		goto out;
+
+	err = dut_start_test(t, drv_feature, action);
+	if (!ASSERT_OK(err, "send CMD_START to DUT"))
+		goto out;
+
+	err = dut_get_xdp_features(t, &advertised_feature);
+	if (!ASSERT_OK(err, "get tester XDP capabilities"))
+		goto out;
+
+	for (i = 0; i < TEST_PACKET_COUNT; i++) {
+		err = send_echo_msg(t);
+		if (!ASSERT_OK(err, "send echo message"))
+			goto out;
+
+		usleep(LOOP_DELAY_US);
+	}
+	dut_stop_test(t);
+
+	detected_cap = tester_collect_detected_cap(t, drv_feature, action);
+
+	snprintf(test_name, TEST_NAME_MAX_LEN, "%s advertised capabilities",
+		 name);
+	ASSERT_EQ(advertised_feature & drv_feature, drv_feature, test_name);
+	snprintf(test_name, TEST_NAME_MAX_LEN, "%s detected capabilities",
+		 name);
+	ASSERT_TRUE(detected_cap, test_name);
+out:
+	reset_test_stats(t, &t->tester_addr, &t->dut_addr);
+	bpf_xdp_detach(t->tester_ifindex, flags, NULL);
+	return err < 0 ? err : 0;
+}
+
+void serial_test_xdp_features(void)
+{
+	struct test_data t = { 0 };
+
+	if (!ASSERT_OK(setup_network(&t), "setup network"))
+		return;
+
+	t.skel = xdp_features__open();
+	if (!ASSERT_OK_PTR(t.skel, "open skel"))
+		goto cleanup_network;
+	t.skel->rodata->tester_addr =
+		((struct sockaddr_in6 *)&t.tester_addr)->sin6_addr;
+	t.skel->rodata->dut_addr =
+		((struct sockaddr_in6 *)&t.dut_addr)->sin6_addr;
+	if (!ASSERT_OK(xdp_features__load(t.skel), "load progs"))
+		goto cleanup_progs;
+	if (!ASSERT_OK(xdp_features__attach(t.skel), "attach progs"))
+		goto cleanup_progs;
+
+	if (!ASSERT_OK(dut_start_echo_server(&t), "start DUT main thread"))
+		goto cleanup_progs;
+
+	if (test__start_subtest("XDP_PASS"))
+		tester_run("XDP_PASS", &t, NETDEV_XDP_ACT_BASIC, XDP_PASS);
+
+	if (test__start_subtest("XDP_DROP"))
+		tester_run("XDP_DROP", &t, NETDEV_XDP_ACT_BASIC, XDP_DROP);
+
+	if (test__start_subtest("XDP_ABORTED"))
+		tester_run("XDP_ABORTED", &t, NETDEV_XDP_ACT_BASIC,
+			   XDP_ABORTED);
+
+	if (test__start_subtest("XDP_TX"))
+		tester_run("XDP_TX", &t, NETDEV_XDP_ACT_BASIC, XDP_TX);
+
+	if (test__start_subtest("XDP_REDIRECT"))
+		tester_run("XDP_REDIRECT", &t, NETDEV_XDP_ACT_REDIRECT,
+			   XDP_REDIRECT);
+
+	if (test__start_subtest("XDP_NDO_XMIT"))
+		tester_run("XDP_NDO_XMIT", &t, NETDEV_XDP_ACT_NDO_XMIT, 0);
+
+	dut_stop_echo_server(&t);
+
+cleanup_progs:
+	xdp_features__destroy(t.skel);
+cleanup_network:
+	cleanup_network();
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_features.c b/tools/testing/selftests/bpf/progs/xdp_features.c
index 67424084a38a..451e8fc79534 100644
--- a/tools/testing/selftests/bpf/progs/xdp_features.c
+++ b/tools/testing/selftests/bpf/progs/xdp_features.c
@@ -30,19 +30,9 @@ struct xdp_cpumap_stats {
 	unsigned int drop;
 };
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, __u32);
-	__type(value, __u32);
-	__uint(max_entries, 1);
-} stats SEC(".maps");
+__u32 tester_stats;
+__u32 dut_stats;
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__type(key, __u32);
-	__type(value, __u32);
-	__uint(max_entries, 1);
-} dut_stats SEC(".maps");
 
 struct {
 	__uint(type, BPF_MAP_TYPE_CPUMAP);
@@ -67,7 +57,7 @@ xdp_process_echo_packet(struct xdp_md *xdp, bool dut)
 	void *data_end = (void *)(long)xdp->data_end;
 	void *data = (void *)(long)xdp->data;
 	struct ethhdr *eh = data;
-	struct tlv_hdr *tlv;
+	__u32 *magic;
 	struct udphdr *uh;
 	__be16 port;
 
@@ -124,28 +114,23 @@ xdp_process_echo_packet(struct xdp_md *xdp, bool dut)
 	if (port != bpf_htons(DUT_ECHO_PORT))
 		return -EINVAL;
 
-	tlv = (struct tlv_hdr *)(uh + 1);
-	if (tlv + 1 > data_end)
+	magic = (__u32 *)(uh + 1);
+	if (magic + 1 > data_end)
 		return -EINVAL;
 
-	return bpf_htons(tlv->type) == CMD_ECHO ? 0 : -EINVAL;
+	return bpf_htonl(*magic) == CMD_ECHO ? 0 : -EINVAL;
 }
 
 static __always_inline int
 xdp_update_stats(struct xdp_md *xdp, bool tx, bool dut)
 {
-	__u32 *val, key = 0;
-
 	if (xdp_process_echo_packet(xdp, tx))
 		return -EINVAL;
 
 	if (dut)
-		val = bpf_map_lookup_elem(&dut_stats, &key);
+		__sync_add_and_fetch(&dut_stats, 1);
 	else
-		val = bpf_map_lookup_elem(&stats, &key);
-
-	if (val)
-		__sync_add_and_fetch(val, 1);
+		__sync_add_and_fetch(&tester_stats, 1);
 
 	return 0;
 }
@@ -204,7 +189,7 @@ int xdp_do_tx(struct xdp_md *xdp)
 	__u8 tmp_mac[ETH_ALEN];
 
 	if (xdp_update_stats(xdp, true, true))
-		return XDP_PASS;
+		return XDP_DROP;
 
 	__builtin_memcpy(tmp_mac, eh->h_source, ETH_ALEN);
 	__builtin_memcpy(eh->h_source, eh->h_dest, ETH_ALEN);
@@ -217,7 +202,7 @@ SEC("xdp")
 int xdp_do_redirect(struct xdp_md *xdp)
 {
 	if (xdp_process_echo_packet(xdp, true))
-		return XDP_PASS;
+		return XDP_DROP;
 
 	return bpf_redirect_map(&cpu_map, 0, 0);
 }
@@ -226,11 +211,7 @@ SEC("tp_btf/xdp_exception")
 int BPF_PROG(xdp_exception, const struct net_device *dev,
 	     const struct bpf_prog *xdp, __u32 act)
 {
-	__u32 *val, key = 0;
-
-	val = bpf_map_lookup_elem(&dut_stats, &key);
-	if (val)
-		__sync_add_and_fetch(val, 1);
+	__sync_add_and_fetch(&dut_stats, 1);
 
 	return 0;
 }
@@ -239,11 +220,7 @@ SEC("tp_btf/xdp_cpumap_kthread")
 int BPF_PROG(tp_xdp_cpumap_kthread, int map_id, unsigned int processed,
 	     unsigned int drops, int sched, struct xdp_cpumap_stats *xdp_stats)
 {
-	__u32 *val, key = 0;
-
-	val = bpf_map_lookup_elem(&dut_stats, &key);
-	if (val)
-		__sync_add_and_fetch(val, 1);
+	__sync_add_and_fetch(&dut_stats, 1);
 
 	return 0;
 }
@@ -256,7 +233,7 @@ int xdp_do_redirect_cpumap(struct xdp_md *xdp)
 	__u8 tmp_mac[ETH_ALEN];
 
 	if (xdp_process_echo_packet(xdp, true))
-		return XDP_PASS;
+		return XDP_DROP;
 
 	__builtin_memcpy(tmp_mac, eh->h_source, ETH_ALEN);
 	__builtin_memcpy(eh->h_source, eh->h_dest, ETH_ALEN);
diff --git a/tools/testing/selftests/bpf/test_xdp_features.sh b/tools/testing/selftests/bpf/test_xdp_features.sh
deleted file mode 100755
index 0aa71c4455c0..000000000000
--- a/tools/testing/selftests/bpf/test_xdp_features.sh
+++ /dev/null
@@ -1,107 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-readonly NS="ns1-$(mktemp -u XXXXXX)"
-readonly V0_IP4=10.10.0.11
-readonly V1_IP4=10.10.0.1
-readonly V0_IP6=2001:db8::11
-readonly V1_IP6=2001:db8::1
-
-ret=1
-
-setup() {
-	{
-		ip netns add ${NS}
-
-		ip link add v1 type veth peer name v0 netns ${NS}
-
-		ip link set v1 up
-		ip addr add $V1_IP4/24 dev v1
-		ip addr add $V1_IP6/64 nodad dev v1
-		ip -n ${NS} link set dev v0 up
-		ip -n ${NS} addr add $V0_IP4/24 dev v0
-		ip -n ${NS} addr add $V0_IP6/64 nodad dev v0
-
-		# Enable XDP mode and disable checksum offload
-		ethtool -K v1 gro on
-		ethtool -K v1 tx-checksumming off
-		ip netns exec ${NS} ethtool -K v0 gro on
-		ip netns exec ${NS} ethtool -K v0 tx-checksumming off
-	} > /dev/null 2>&1
-}
-
-cleanup() {
-	ip link del v1 2> /dev/null
-	ip netns del ${NS} 2> /dev/null
-	[ "$(pidof xdp_features)" = "" ] || kill $(pidof xdp_features) 2> /dev/null
-}
-
-wait_for_dut_server() {
-	while sleep 1; do
-		ss -tlp | grep -q xdp_features
-		[ $? -eq 0 ] && break
-	done
-}
-
-test_xdp_features() {
-	setup
-
-	## XDP_PASS
-	./xdp_features -f XDP_PASS -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_PASS \
-					   -D $V1_IP6 -C $V1_IP6 \
-					   -T $V0_IP6 v0
-	[ $? -ne 0 ] && exit
-
-	## XDP_DROP
-	./xdp_features -f XDP_DROP -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_DROP \
-					   -D ::ffff:$V1_IP4 \
-					   -C ::ffff:$V1_IP4 \
-					   -T ::ffff:$V0_IP4 v0
-	[ $? -ne 0 ] && exit
-
-	## XDP_ABORTED
-	./xdp_features -f XDP_ABORTED -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_ABORTED \
-					   -D $V1_IP6 -C $V1_IP6 \
-					   -T $V0_IP6 v0
-	[ $? -ne 0 ] && exit
-
-	## XDP_TX
-	./xdp_features -f XDP_TX -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_TX \
-					   -D ::ffff:$V1_IP4 \
-					   -C ::ffff:$V1_IP4 \
-					   -T ::ffff:$V0_IP4 v0
-	[ $? -ne 0 ] && exit
-
-	## XDP_REDIRECT
-	./xdp_features -f XDP_REDIRECT -D $V1_IP6 -T $V0_IP6 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_REDIRECT \
-					   -D $V1_IP6 -C $V1_IP6 \
-					   -T $V0_IP6 v0
-	[ $? -ne 0 ] && exit
-
-	## XDP_NDO_XMIT
-	./xdp_features -f XDP_NDO_XMIT -D ::ffff:$V1_IP4 -T ::ffff:$V0_IP4 v1 &
-	wait_for_dut_server
-	ip netns exec ${NS} ./xdp_features -t -f XDP_NDO_XMIT \
-					   -D ::ffff:$V1_IP4 \
-					   -C ::ffff:$V1_IP4 \
-					   -T ::ffff:$V0_IP4 v0
-	ret=$?
-	cleanup
-}
-
-set -e
-trap cleanup 2 3 6 9
-
-test_xdp_features
-
-exit $ret
diff --git a/tools/testing/selftests/bpf/xdp_features.c b/tools/testing/selftests/bpf/xdp_features.c
deleted file mode 100644
index 595c79141cf3..000000000000
--- a/tools/testing/selftests/bpf/xdp_features.c
+++ /dev/null
@@ -1,718 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/netdev.h>
-#include <linux/if_link.h>
-#include <signal.h>
-#include <argp.h>
-#include <net/if.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <netinet/tcp.h>
-#include <unistd.h>
-#include <arpa/inet.h>
-#include <bpf/bpf.h>
-#include <bpf/libbpf.h>
-#include <pthread.h>
-
-#include <network_helpers.h>
-
-#include "xdp_features.skel.h"
-#include "xdp_features.h"
-
-#define RED(str)	"\033[0;31m" str "\033[0m"
-#define GREEN(str)	"\033[0;32m" str "\033[0m"
-#define YELLOW(str)	"\033[0;33m" str "\033[0m"
-
-static struct env {
-	bool verbosity;
-	char ifname[IF_NAMESIZE];
-	int ifindex;
-	bool is_tester;
-	struct {
-		enum netdev_xdp_act drv_feature;
-		enum xdp_action action;
-	} feature;
-	struct sockaddr_storage dut_ctrl_addr;
-	struct sockaddr_storage dut_addr;
-	struct sockaddr_storage tester_addr;
-} env;
-
-#define BUFSIZE		128
-
-void test__fail(void) { /* for network_helpers.c */ }
-
-static int libbpf_print_fn(enum libbpf_print_level level,
-			   const char *format, va_list args)
-{
-	if (level == LIBBPF_DEBUG && !env.verbosity)
-		return 0;
-	return vfprintf(stderr, format, args);
-}
-
-static volatile bool exiting;
-
-static void sig_handler(int sig)
-{
-	exiting = true;
-}
-
-const char *argp_program_version = "xdp-features 0.0";
-const char argp_program_doc[] =
-"XDP features detection application.\n"
-"\n"
-"XDP features application checks the XDP advertised features match detected ones.\n"
-"\n"
-"USAGE: ./xdp-features [-vt] [-f <xdp-feature>] [-D <dut-data-ip>] [-T <tester-data-ip>] [-C <dut-ctrl-ip>] <iface-name>\n"
-"\n"
-"dut-data-ip, tester-data-ip, dut-ctrl-ip: IPv6 or IPv4-mapped-IPv6 addresses;\n"
-"\n"
-"XDP features\n:"
-"- XDP_PASS\n"
-"- XDP_DROP\n"
-"- XDP_ABORTED\n"
-"- XDP_REDIRECT\n"
-"- XDP_NDO_XMIT\n"
-"- XDP_TX\n";
-
-static const struct argp_option opts[] = {
-	{ "verbose", 'v', NULL, 0, "Verbose debug output" },
-	{ "tester", 't', NULL, 0, "Tester mode" },
-	{ "feature", 'f', "XDP-FEATURE", 0, "XDP feature to test" },
-	{ "dut_data_ip", 'D', "DUT-DATA-IP", 0, "DUT IP data channel" },
-	{ "dut_ctrl_ip", 'C', "DUT-CTRL-IP", 0, "DUT IP control channel" },
-	{ "tester_data_ip", 'T', "TESTER-DATA-IP", 0, "Tester IP data channel" },
-	{},
-};
-
-static int get_xdp_feature(const char *arg)
-{
-	if (!strcmp(arg, "XDP_PASS")) {
-		env.feature.action = XDP_PASS;
-		env.feature.drv_feature = NETDEV_XDP_ACT_BASIC;
-	} else if (!strcmp(arg, "XDP_DROP")) {
-		env.feature.drv_feature = NETDEV_XDP_ACT_BASIC;
-		env.feature.action = XDP_DROP;
-	} else if (!strcmp(arg, "XDP_ABORTED")) {
-		env.feature.drv_feature = NETDEV_XDP_ACT_BASIC;
-		env.feature.action = XDP_ABORTED;
-	} else if (!strcmp(arg, "XDP_TX")) {
-		env.feature.drv_feature = NETDEV_XDP_ACT_BASIC;
-		env.feature.action = XDP_TX;
-	} else if (!strcmp(arg, "XDP_REDIRECT")) {
-		env.feature.drv_feature = NETDEV_XDP_ACT_REDIRECT;
-		env.feature.action = XDP_REDIRECT;
-	} else if (!strcmp(arg, "XDP_NDO_XMIT")) {
-		env.feature.drv_feature = NETDEV_XDP_ACT_NDO_XMIT;
-	} else {
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static char *get_xdp_feature_str(void)
-{
-	switch (env.feature.action) {
-	case XDP_PASS:
-		return YELLOW("XDP_PASS");
-	case XDP_DROP:
-		return YELLOW("XDP_DROP");
-	case XDP_ABORTED:
-		return YELLOW("XDP_ABORTED");
-	case XDP_TX:
-		return YELLOW("XDP_TX");
-	case XDP_REDIRECT:
-		return YELLOW("XDP_REDIRECT");
-	default:
-		break;
-	}
-
-	if (env.feature.drv_feature == NETDEV_XDP_ACT_NDO_XMIT)
-		return YELLOW("XDP_NDO_XMIT");
-
-	return "";
-}
-
-static error_t parse_arg(int key, char *arg, struct argp_state *state)
-{
-	switch (key) {
-	case 'v':
-		env.verbosity = true;
-		break;
-	case 't':
-		env.is_tester = true;
-		break;
-	case 'f':
-		if (get_xdp_feature(arg) < 0) {
-			fprintf(stderr, "Invalid xdp feature: %s\n", arg);
-			argp_usage(state);
-			return ARGP_ERR_UNKNOWN;
-		}
-		break;
-	case 'D':
-		if (make_sockaddr(AF_INET6, arg, DUT_ECHO_PORT,
-				  &env.dut_addr, NULL)) {
-			fprintf(stderr,
-				"Invalid address assigned to the Device Under Test: %s\n",
-				arg);
-			return ARGP_ERR_UNKNOWN;
-		}
-		break;
-	case 'C':
-		if (make_sockaddr(AF_INET6, arg, DUT_CTRL_PORT,
-				  &env.dut_ctrl_addr, NULL)) {
-			fprintf(stderr,
-				"Invalid address assigned to the Device Under Test: %s\n",
-				arg);
-			return ARGP_ERR_UNKNOWN;
-		}
-		break;
-	case 'T':
-		if (make_sockaddr(AF_INET6, arg, 0, &env.tester_addr, NULL)) {
-			fprintf(stderr,
-				"Invalid address assigned to the Tester device: %s\n",
-				arg);
-			return ARGP_ERR_UNKNOWN;
-		}
-		break;
-	case ARGP_KEY_ARG:
-		errno = 0;
-		if (strlen(arg) >= IF_NAMESIZE) {
-			fprintf(stderr, "Invalid device name: %s\n", arg);
-			argp_usage(state);
-			return ARGP_ERR_UNKNOWN;
-		}
-
-		env.ifindex = if_nametoindex(arg);
-		if (!env.ifindex)
-			env.ifindex = strtoul(arg, NULL, 0);
-		if (!env.ifindex || !if_indextoname(env.ifindex, env.ifname)) {
-			fprintf(stderr,
-				"Bad interface index or name (%d): %s\n",
-				errno, strerror(errno));
-			argp_usage(state);
-			return ARGP_ERR_UNKNOWN;
-		}
-		break;
-	default:
-		return ARGP_ERR_UNKNOWN;
-	}
-
-	return 0;
-}
-
-static const struct argp argp = {
-	.options = opts,
-	.parser = parse_arg,
-	.doc = argp_program_doc,
-};
-
-static void set_env_default(void)
-{
-	env.feature.drv_feature = NETDEV_XDP_ACT_NDO_XMIT;
-	env.feature.action = -EINVAL;
-	env.ifindex = -ENODEV;
-	strcpy(env.ifname, "unknown");
-	make_sockaddr(AF_INET6, "::ffff:127.0.0.1", DUT_CTRL_PORT,
-		      &env.dut_ctrl_addr, NULL);
-	make_sockaddr(AF_INET6, "::ffff:127.0.0.1", DUT_ECHO_PORT,
-		      &env.dut_addr, NULL);
-	make_sockaddr(AF_INET6, "::ffff:127.0.0.1", 0, &env.tester_addr, NULL);
-}
-
-static void *dut_echo_thread(void *arg)
-{
-	unsigned char buf[sizeof(struct tlv_hdr)];
-	int sockfd = *(int *)arg;
-
-	while (!exiting) {
-		struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
-		struct sockaddr_storage addr;
-		socklen_t addrlen;
-		size_t n;
-
-		n = recvfrom(sockfd, buf, sizeof(buf), MSG_WAITALL,
-			     (struct sockaddr *)&addr, &addrlen);
-		if (n != ntohs(tlv->len))
-			continue;
-
-		if (ntohs(tlv->type) != CMD_ECHO)
-			continue;
-
-		sendto(sockfd, buf, sizeof(buf), MSG_NOSIGNAL | MSG_CONFIRM,
-		       (struct sockaddr *)&addr, addrlen);
-	}
-
-	pthread_exit((void *)0);
-	close(sockfd);
-
-	return NULL;
-}
-
-static int dut_run_echo_thread(pthread_t *t, int *sockfd)
-{
-	int err;
-
-	sockfd = start_reuseport_server(AF_INET6, SOCK_DGRAM, NULL,
-					DUT_ECHO_PORT, 0, 1);
-	if (!sockfd) {
-		fprintf(stderr,
-			"Failed creating data UDP socket on device %s\n",
-			env.ifname);
-		return -errno;
-	}
-
-	/* start echo channel */
-	err = pthread_create(t, NULL, dut_echo_thread, sockfd);
-	if (err) {
-		fprintf(stderr,
-			"Failed creating data UDP thread on device %s: %s\n",
-			env.ifname, strerror(-err));
-		free_fds(sockfd, 1);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int dut_attach_xdp_prog(struct xdp_features *skel, int flags)
-{
-	enum xdp_action action = env.feature.action;
-	struct bpf_program *prog;
-	unsigned int key = 0;
-	int err, fd = 0;
-
-	if (env.feature.drv_feature == NETDEV_XDP_ACT_NDO_XMIT) {
-		struct bpf_devmap_val entry = {
-			.ifindex = env.ifindex,
-		};
-
-		err = bpf_map__update_elem(skel->maps.dev_map,
-					   &key, sizeof(key),
-					   &entry, sizeof(entry), 0);
-		if (err < 0)
-			return err;
-
-		fd = bpf_program__fd(skel->progs.xdp_do_redirect_cpumap);
-		action = XDP_REDIRECT;
-	}
-
-	switch (action) {
-	case XDP_TX:
-		prog = skel->progs.xdp_do_tx;
-		break;
-	case XDP_DROP:
-		prog = skel->progs.xdp_do_drop;
-		break;
-	case XDP_ABORTED:
-		prog = skel->progs.xdp_do_aborted;
-		break;
-	case XDP_PASS:
-		prog = skel->progs.xdp_do_pass;
-		break;
-	case XDP_REDIRECT: {
-		struct bpf_cpumap_val entry = {
-			.qsize = 2048,
-			.bpf_prog.fd = fd,
-		};
-
-		err = bpf_map__update_elem(skel->maps.cpu_map,
-					   &key, sizeof(key),
-					   &entry, sizeof(entry), 0);
-		if (err < 0)
-			return err;
-
-		prog = skel->progs.xdp_do_redirect;
-		break;
-	}
-	default:
-		return -EINVAL;
-	}
-
-	err = bpf_xdp_attach(env.ifindex, bpf_program__fd(prog), flags, NULL);
-	if (err)
-		fprintf(stderr, "Failed attaching XDP program to device %s\n",
-			env.ifname);
-	return err;
-}
-
-static int recv_msg(int sockfd, void *buf, size_t bufsize, void *val,
-		    size_t val_size)
-{
-	struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
-	size_t len;
-
-	len = recv(sockfd, buf, bufsize, 0);
-	if (len != ntohs(tlv->len) || len < sizeof(*tlv))
-		return -EINVAL;
-
-	if (val) {
-		len -= sizeof(*tlv);
-		if (len > val_size)
-			return -ENOMEM;
-
-		memcpy(val, tlv->data, len);
-	}
-
-	return 0;
-}
-
-static int dut_run(struct xdp_features *skel)
-{
-	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
-	int state, err = 0, *sockfd, ctrl_sockfd, echo_sockfd;
-	struct sockaddr_storage ctrl_addr;
-	pthread_t dut_thread = 0;
-	socklen_t addrlen;
-
-	sockfd = start_reuseport_server(AF_INET6, SOCK_STREAM, NULL,
-					DUT_CTRL_PORT, 0, 1);
-	if (!sockfd) {
-		fprintf(stderr,
-			"Failed creating control socket on device %s\n", env.ifname);
-		return -errno;
-	}
-
-	ctrl_sockfd = accept(*sockfd, (struct sockaddr *)&ctrl_addr, &addrlen);
-	if (ctrl_sockfd < 0) {
-		fprintf(stderr,
-			"Failed accepting connections on device %s control socket\n",
-			env.ifname);
-		free_fds(sockfd, 1);
-		return -errno;
-	}
-
-	/* CTRL loop */
-	while (!exiting) {
-		unsigned char buf[BUFSIZE] = {};
-		struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
-
-		err = recv_msg(ctrl_sockfd, buf, BUFSIZE, NULL, 0);
-		if (err)
-			continue;
-
-		switch (ntohs(tlv->type)) {
-		case CMD_START: {
-			if (state == CMD_START)
-				continue;
-
-			state = CMD_START;
-			/* Load the XDP program on the DUT */
-			err = dut_attach_xdp_prog(skel, flags);
-			if (err)
-				goto out;
-
-			err = dut_run_echo_thread(&dut_thread, &echo_sockfd);
-			if (err < 0)
-				goto out;
-
-			tlv->type = htons(CMD_ACK);
-			tlv->len = htons(sizeof(*tlv));
-			err = send(ctrl_sockfd, buf, sizeof(*tlv), 0);
-			if (err < 0)
-				goto end_thread;
-			break;
-		}
-		case CMD_STOP:
-			if (state != CMD_START)
-				break;
-
-			state = CMD_STOP;
-
-			exiting = true;
-			bpf_xdp_detach(env.ifindex, flags, NULL);
-
-			tlv->type = htons(CMD_ACK);
-			tlv->len = htons(sizeof(*tlv));
-			err = send(ctrl_sockfd, buf, sizeof(*tlv), 0);
-			goto end_thread;
-		case CMD_GET_XDP_CAP: {
-			LIBBPF_OPTS(bpf_xdp_query_opts, opts);
-			unsigned long long val;
-			size_t n;
-
-			err = bpf_xdp_query(env.ifindex, XDP_FLAGS_DRV_MODE,
-					    &opts);
-			if (err) {
-				fprintf(stderr,
-					"Failed querying XDP cap for device %s\n",
-					env.ifname);
-				goto end_thread;
-			}
-
-			tlv->type = htons(CMD_ACK);
-			n = sizeof(*tlv) + sizeof(opts.feature_flags);
-			tlv->len = htons(n);
-
-			val = htobe64(opts.feature_flags);
-			memcpy(tlv->data, &val, sizeof(val));
-
-			err = send(ctrl_sockfd, buf, n, 0);
-			if (err < 0)
-				goto end_thread;
-			break;
-		}
-		case CMD_GET_STATS: {
-			unsigned int key = 0, val;
-			size_t n;
-
-			err = bpf_map__lookup_elem(skel->maps.dut_stats,
-						   &key, sizeof(key),
-						   &val, sizeof(val), 0);
-			if (err) {
-				fprintf(stderr,
-					"bpf_map_lookup_elem failed (%d)\n", err);
-				goto end_thread;
-			}
-
-			tlv->type = htons(CMD_ACK);
-			n = sizeof(*tlv) + sizeof(val);
-			tlv->len = htons(n);
-
-			val = htonl(val);
-			memcpy(tlv->data, &val, sizeof(val));
-
-			err = send(ctrl_sockfd, buf, n, 0);
-			if (err < 0)
-				goto end_thread;
-			break;
-		}
-		default:
-			break;
-		}
-	}
-
-end_thread:
-	pthread_join(dut_thread, NULL);
-out:
-	bpf_xdp_detach(env.ifindex, flags, NULL);
-	close(ctrl_sockfd);
-	free_fds(sockfd, 1);
-
-	return err;
-}
-
-static bool tester_collect_detected_cap(struct xdp_features *skel,
-					unsigned int dut_stats)
-{
-	unsigned int err, key = 0, val;
-
-	if (!dut_stats)
-		return false;
-
-	err = bpf_map__lookup_elem(skel->maps.stats, &key, sizeof(key),
-				   &val, sizeof(val), 0);
-	if (err) {
-		fprintf(stderr, "bpf_map_lookup_elem failed (%d)\n", err);
-		return false;
-	}
-
-	switch (env.feature.action) {
-	case XDP_PASS:
-	case XDP_TX:
-	case XDP_REDIRECT:
-		return val > 0;
-	case XDP_DROP:
-	case XDP_ABORTED:
-		return val == 0;
-	default:
-		break;
-	}
-
-	if (env.feature.drv_feature == NETDEV_XDP_ACT_NDO_XMIT)
-		return val > 0;
-
-	return false;
-}
-
-static int send_and_recv_msg(int sockfd, enum test_commands cmd, void *val,
-			     size_t val_size)
-{
-	unsigned char buf[BUFSIZE] = {};
-	struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
-	int err;
-
-	tlv->type = htons(cmd);
-	tlv->len = htons(sizeof(*tlv));
-
-	err = send(sockfd, buf, sizeof(*tlv), 0);
-	if (err < 0)
-		return err;
-
-	err = recv_msg(sockfd, buf, BUFSIZE, val, val_size);
-	if (err < 0)
-		return err;
-
-	return ntohs(tlv->type) == CMD_ACK ? 0 : -EINVAL;
-}
-
-static int send_echo_msg(void)
-{
-	unsigned char buf[sizeof(struct tlv_hdr)];
-	struct tlv_hdr *tlv = (struct tlv_hdr *)buf;
-	int sockfd, n;
-
-	sockfd = socket(AF_INET6, SOCK_DGRAM, 0);
-	if (sockfd < 0) {
-		fprintf(stderr,
-			"Failed creating data UDP socket on device %s\n",
-			env.ifname);
-		return -errno;
-	}
-
-	tlv->type = htons(CMD_ECHO);
-	tlv->len = htons(sizeof(*tlv));
-
-	n = sendto(sockfd, buf, sizeof(*tlv), MSG_NOSIGNAL | MSG_CONFIRM,
-		   (struct sockaddr *)&env.dut_addr, sizeof(env.dut_addr));
-	close(sockfd);
-
-	return n == ntohs(tlv->len) ? 0 : -EINVAL;
-}
-
-static int tester_run(struct xdp_features *skel)
-{
-	int flags = XDP_FLAGS_UPDATE_IF_NOEXIST | XDP_FLAGS_DRV_MODE;
-	unsigned long long advertised_feature;
-	struct bpf_program *prog;
-	unsigned int stats;
-	int i, err, sockfd;
-	bool detected_cap;
-
-	sockfd = socket(AF_INET6, SOCK_STREAM, 0);
-	if (sockfd < 0) {
-		fprintf(stderr,
-			"Failed creating tester service control socket\n");
-		return -errno;
-	}
-
-	if (settimeo(sockfd, 1000) < 0)
-		return -EINVAL;
-
-	err = connect(sockfd, (struct sockaddr *)&env.dut_ctrl_addr,
-		      sizeof(env.dut_ctrl_addr));
-	if (err) {
-		fprintf(stderr,
-			"Failed connecting to the Device Under Test control socket\n");
-		return -errno;
-	}
-
-	err = send_and_recv_msg(sockfd, CMD_GET_XDP_CAP, &advertised_feature,
-				sizeof(advertised_feature));
-	if (err < 0) {
-		close(sockfd);
-		return err;
-	}
-
-	advertised_feature = be64toh(advertised_feature);
-
-	if (env.feature.drv_feature == NETDEV_XDP_ACT_NDO_XMIT ||
-	    env.feature.action == XDP_TX)
-		prog = skel->progs.xdp_tester_check_tx;
-	else
-		prog = skel->progs.xdp_tester_check_rx;
-
-	err = bpf_xdp_attach(env.ifindex, bpf_program__fd(prog), flags, NULL);
-	if (err) {
-		fprintf(stderr, "Failed attaching XDP program to device %s\n",
-			env.ifname);
-		goto out;
-	}
-
-	err = send_and_recv_msg(sockfd, CMD_START, NULL, 0);
-	if (err)
-		goto out;
-
-	for (i = 0; i < 10 && !exiting; i++) {
-		err = send_echo_msg();
-		if (err < 0)
-			goto out;
-
-		sleep(1);
-	}
-
-	err = send_and_recv_msg(sockfd, CMD_GET_STATS, &stats, sizeof(stats));
-	if (err)
-		goto out;
-
-	/* stop the test */
-	err = send_and_recv_msg(sockfd, CMD_STOP, NULL, 0);
-	/* send a new echo message to wake echo thread of the dut */
-	send_echo_msg();
-
-	detected_cap = tester_collect_detected_cap(skel, ntohl(stats));
-
-	fprintf(stdout, "Feature %s: [%s][%s]\n", get_xdp_feature_str(),
-		detected_cap ? GREEN("DETECTED") : RED("NOT DETECTED"),
-		env.feature.drv_feature & advertised_feature ? GREEN("ADVERTISED")
-							     : RED("NOT ADVERTISED"));
-out:
-	bpf_xdp_detach(env.ifindex, flags, NULL);
-	close(sockfd);
-	return err < 0 ? err : 0;
-}
-
-int main(int argc, char **argv)
-{
-	struct xdp_features *skel;
-	int err;
-
-	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
-	libbpf_set_print(libbpf_print_fn);
-
-	signal(SIGINT, sig_handler);
-	signal(SIGTERM, sig_handler);
-
-	set_env_default();
-
-	/* Parse command line arguments */
-	err = argp_parse(&argp, argc, argv, 0, NULL, NULL);
-	if (err)
-		return err;
-
-	if (env.ifindex < 0) {
-		fprintf(stderr, "Invalid device name %s\n", env.ifname);
-		return -ENODEV;
-	}
-
-	/* Load and verify BPF application */
-	skel = xdp_features__open();
-	if (!skel) {
-		fprintf(stderr, "Failed to open and load BPF skeleton\n");
-		return -EINVAL;
-	}
-
-	skel->rodata->tester_addr =
-		((struct sockaddr_in6 *)&env.tester_addr)->sin6_addr;
-	skel->rodata->dut_addr =
-		((struct sockaddr_in6 *)&env.dut_addr)->sin6_addr;
-
-	/* Load & verify BPF programs */
-	err = xdp_features__load(skel);
-	if (err) {
-		fprintf(stderr, "Failed to load and verify BPF skeleton\n");
-		goto cleanup;
-	}
-
-	err = xdp_features__attach(skel);
-	if (err) {
-		fprintf(stderr, "Failed to attach BPF skeleton\n");
-		goto cleanup;
-	}
-
-	if (env.is_tester) {
-		/* Tester */
-		fprintf(stdout, "Starting tester service on device %s\n",
-			env.ifname);
-		err = tester_run(skel);
-	} else {
-		/* DUT */
-		fprintf(stdout, "Starting test on device %s\n", env.ifname);
-		err = dut_run(skel);
-	}
-
-cleanup:
-	xdp_features__destroy(skel);
-
-	return err < 0 ? -err : 0;
-}
diff --git a/tools/testing/selftests/bpf/xdp_features.h b/tools/testing/selftests/bpf/xdp_features.h
index 2670c541713b..2fa7a2e156c7 100644
--- a/tools/testing/selftests/bpf/xdp_features.h
+++ b/tools/testing/selftests/bpf/xdp_features.h
@@ -1,20 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/* test commands */
-enum test_commands {
-	CMD_STOP,		/* CMD */
-	CMD_START,		/* CMD */
-	CMD_ECHO,		/* CMD */
-	CMD_ACK,		/* CMD + data */
-	CMD_GET_XDP_CAP,	/* CMD */
-	CMD_GET_STATS,		/* CMD */
-};
+#define CMD_ECHO	0x4543484F /* 4 bytes magic */
 
-#define DUT_CTRL_PORT	12345
 #define DUT_ECHO_PORT	12346
-
-struct tlv_hdr {
-	__be16 type;
-	__be16 len;
-	__u8 data[];
-};

---
base-commit: 33a4c81d04d3011e79f70fbc2d68a4d6cb12b9a5
change-id: 20240730-convert_xdp_tests-ccd66bfe33db

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


