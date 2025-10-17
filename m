Return-Path: <linux-kselftest+bounces-43383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D450BE9323
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DACD1AA3222
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21633032C;
	Fri, 17 Oct 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZvZmGdH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B969C32E13C;
	Fri, 17 Oct 2025 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711377; cv=none; b=pxtH0Zu9pb/XGN9E93SciX0qaH+aijoYsCpzs2cElzI+hS1YdPqXTkdUDvFBOu5PirthwUsg+fOuPQCzvgmaMip1+9reAP+vs1Mi4pZwoEDcAvIhiO95e9rhefQKqalkukt2P24JRxliEkItg2yvkwQq4y1zILXD0XRaGFwD2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711377; c=relaxed/simple;
	bh=g3hU7jkPkFoAZcJWeXPV6pbe4mTGrOkYgGKg/aYnxd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amGaZDI6bP85tnig2/D6EtDaH7JhOzUiNCr5RZQ5GlkoeHG122S686bEsSP9g44Et+aWiP3WtaGAc9Gq+BbSuucR9blO1tAkYwnUObG6SB5Nwzwf5fFF83yBZ8jI0tOunj5rjPCd8yfAs5zaKPBJR2bot1yGoGguIN/COD2H7pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZvZmGdH/; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6F7A34E41145;
	Fri, 17 Oct 2025 14:29:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44795606DB;
	Fri, 17 Oct 2025 14:29:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADC2C102F235E;
	Fri, 17 Oct 2025 16:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760711372; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SFEbIPZCoupupDWXhCcQtcHa7APpi6WwZq/uNtFxq6A=;
	b=ZvZmGdH/LGvFULY27P6v4/ZfLPKiNbv1REfHvwxK2Luugk17yGPN47EqdT+sEJQHWCj1m4
	aAdCm2+S6yz/0xwwY5cyDRYTvsVPKb4CwDS8D2XV+zmdKFQW45kPjH0YL6/IKkJh0XqnVB
	4PryZ0UWwgwevThWfW2EFWvXIqiPnyJN+j2B6MLF07wjeJ7B0RQQnWeNsuv7Dd0rpouKTV
	ECgcq27Moi1EVWphNVh6YLENzXyW7Fbxa5vMJojhp4r3v5kp5JTB6vh/jGCa8B2p9jMHn1
	im0A53Aa/U+nzPXWRDcFEDFe6ATslJE2Vv+SJ6W16MKcT5DkQ0aNQfeLiyqFVw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 17 Oct 2025 16:29:04 +0200
Subject: [PATCH bpf-next 4/5] selftests/bpf: integrate test_tc_tunnel.sh
 tests into test_progs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-tc_tunnel-v1-4-2d86808d86b2@bootlin.com>
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
In-Reply-To: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The test_tc_tunnel.sh script checks that a large variety of tunneling
mechanisms handled by the kernel can be handled as well by eBPF
programs. While this test shares similarities with test_tunnel.c (which
is already integrated in test_progs), those are testing slightly
different things:
- test_tunnel.c creates a tunnel interface, and then get and set tunnel
  keys in packet metadata, from BPF programs.
- test_tc_tunnels.sh manually parses/crafts packets content

Bring the tests covered by test_tc_tunnel.sh into the test_progs
framework, by creating a dedicated test_tc_tunnel.sh. This new test
defines a "generic" runner which, for each test configuration:
- will bring the relevant veth pair, each of those isolated in a
  dedicated namespace
- will check that traffic will fail if there is only an encapsulating
  program attached to one veth egress
- will check that traffic succeed if we enable some decapsulation module
  on kernel side
- will check that traffic still succeeds if we replace the kernel
  decapsulation with some eBPF ingress decapsulation.

Example of the new test execution:

  # ./test_progs -a tc_tunnel
  #447/1   tc_tunnel/ipip_none:OK
  #447/2   tc_tunnel/ipip6_none:OK
  #447/3   tc_tunnel/ip6tnl_none:OK
  #447/4   tc_tunnel/sit_none:OK
  #447/5   tc_tunnel/vxlan_eth:OK
  #447/6   tc_tunnel/ip6vxlan_eth:OK
  #447/7   tc_tunnel/gre_none:OK
  #447/8   tc_tunnel/gre_eth:OK
  #447/9   tc_tunnel/gre_mpls:OK
  #447/10  tc_tunnel/ip6gre_none:OK
  #447/11  tc_tunnel/ip6gre_eth:OK
  #447/12  tc_tunnel/ip6gre_mpls:OK
  #447/13  tc_tunnel/udp_none:OK
  #447/14  tc_tunnel/udp_eth:OK
  #447/15  tc_tunnel/udp_mpls:OK
  #447/16  tc_tunnel/ip6udp_none:OK
  #447/17  tc_tunnel/ip6udp_eth:OK
  #447/18  tc_tunnel/ip6udp_mpls:OK
  #447     tc_tunnel:OK
  Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 684 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c |  38 +-
 2 files changed, 703 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
new file mode 100644
index 0000000000000000000000000000000000000000..294cf4fb1545e71a6ee8da8544fed4489fd8ff12
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+/*
+ * End-to-end eBPF tunnel test suite
+ *   The file tests BPF network tunnels implementation. For each tunnel
+ *   type, the test validates that:
+ *   - basic communication can first be established between the two veths
+ *   - when adding a BPF-based encapsulation on client egress, it now fails
+ *   to communicate with the server
+ *   - when adding a kernel-based decapsulation on server ingress, client
+ *   can now connect
+ *   - when replacing the kernel-based decapsulation with a BPF-based one,
+ *   the client can still connect
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <sys/socket.h>
+#include <bpf/libbpf.h>
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "tc_helpers.h"
+#include "test_tc_tunnel.skel.h"
+
+#define SERVER_NS	"tc-tunnel-server-ns"
+#define CLIENT_NS	"tc-tunnel-client-ns"
+#define MAC_ADDR_VETH1	"00:11:22:33:44:55"
+#define IP4_ADDR_VETH1	"192.168.1.1"
+#define IP6_ADDR_VETH1	"fd::1"
+#define MAC_ADDR_VETH2	"66:77:88:99:AA:BB"
+#define IP4_ADDR_VETH2	"192.168.1.2"
+#define IP6_ADDR_VETH2	"fd::2"
+
+#define TEST_NAME_MAX_LEN	64
+#define PROG_NAME_MAX_LEN	64
+#define TUNNEL_ARGS_MAX_LEN	128
+#define BUFFER_LEN		2000
+#define DEFAULT_TEST_DATA_SIZE	100
+#define GSO_TEST_DATA_SIZE	BUFFER_LEN
+
+#define TIMEOUT_MS			1000
+#define TEST_PORT			8000
+#define UDP_PORT			5555
+#define MPLS_UDP_PORT			6635
+#define FOU_MPLS_PROTO			137
+#define VXLAN_ID			1
+#define VXLAN_PORT			8472
+#define MPLS_TABLE_ENTRIES_COUNT	65536
+
+static char tx_buffer[BUFFER_LEN], rx_buffer[BUFFER_LEN];
+
+struct subtest_cfg {
+	char *ebpf_tun_type;
+	char *iproute_tun_type;
+	char *mac_tun_type;
+	int ipproto;
+	void (*extra_decap_mod_args_cb)(struct subtest_cfg *cfg, char *dst);
+	bool tunnel_need_veth_mac;
+	bool configure_fou_rx_port;
+	char *tmode;
+	bool expect_kern_decap_failure;
+	bool configure_mpls;
+	bool test_gso;
+	char *tunnel_client_addr;
+	char *tunnel_server_addr;
+	char name[TEST_NAME_MAX_LEN];
+	char *server_addr;
+	int client_egress_prog_fd;
+	int server_ingress_prog_fd;
+	char extra_decap_mod_args[TUNNEL_ARGS_MAX_LEN];
+	int *server_fd;
+};
+
+struct connection {
+	int client_fd;
+	int server_fd;
+};
+
+static int build_subtest_name(struct subtest_cfg *cfg, char *dst, size_t size)
+{
+	int ret;
+
+	ret = snprintf(dst, size, "%s_%s", cfg->ebpf_tun_type,
+		       cfg->mac_tun_type);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int set_subtest_progs(struct subtest_cfg *cfg, struct test_tc_tunnel *skel)
+{
+	char prog_name[PROG_NAME_MAX_LEN];
+	struct bpf_program *prog;
+	int ret;
+
+
+	ret = snprintf(prog_name, PROG_NAME_MAX_LEN, "__encap_");
+	if (ret < 0)
+		return ret;
+	ret = build_subtest_name(cfg, prog_name + ret, PROG_NAME_MAX_LEN - ret);
+	if (ret < 0)
+		return ret;
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!prog)
+		return -1;
+
+	cfg->client_egress_prog_fd = bpf_program__fd(prog);
+	cfg->server_ingress_prog_fd = bpf_program__fd(skel->progs.decap_f);
+	return 0;
+}
+
+static void set_subtest_addresses(struct subtest_cfg *cfg)
+{
+	if (cfg->ipproto == 6)
+		cfg->server_addr = IP6_ADDR_VETH2;
+	else
+		cfg->server_addr = IP4_ADDR_VETH2;
+
+	/* Some specific tunnel types need specific addressing, it then
+	 * has been already set in the configuration table. Otherwise,
+	 * deduce the relevant addressing from the ipproto
+	 */
+	if (cfg->tunnel_client_addr && cfg->tunnel_server_addr)
+		return;
+
+	if (cfg->ipproto == 6) {
+		cfg->tunnel_client_addr = IP6_ADDR_VETH1;
+		cfg->tunnel_server_addr = IP6_ADDR_VETH2;
+	} else {
+		cfg->tunnel_client_addr = IP4_ADDR_VETH1;
+		cfg->tunnel_server_addr = IP4_ADDR_VETH2;
+	}
+}
+
+static int run_server(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
+
+	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
+						cfg->server_addr, TEST_PORT,
+						TIMEOUT_MS, 1);
+	close_netns(nstoken);
+	if (!ASSERT_NEQ(cfg->server_fd, NULL, "start server"))
+		return -1;
+
+	return 0;
+}
+
+static void stop_server(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+
+	close(*cfg->server_fd);
+	cfg->server_fd = NULL;
+	close_netns(nstoken);
+}
+
+static int check_server_rx_data(struct subtest_cfg *cfg,
+				struct connection *conn, int len)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+	int err;
+
+	memset(rx_buffer, 0, BUFFER_LEN);
+	err = recv(conn->server_fd, rx_buffer, len, 0);
+	close_netns(nstoken);
+	if (!ASSERT_EQ(err, len, "check rx data len"))
+		return 1;
+	if (!ASSERT_MEMEQ(tx_buffer, rx_buffer, len, "check received data"))
+		return 1;
+	return 0;
+}
+
+static struct connection *connect_client_to_server(struct subtest_cfg *cfg)
+{
+	struct network_helper_opts opts = {.timeout_ms = 500};
+	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
+	struct nstoken *nstoken = open_netns(CLIENT_NS);
+	struct connection *conn = NULL;
+	int client_fd, server_fd;
+
+	client_fd = connect_to_addr_str(family, SOCK_STREAM, cfg->server_addr,
+					TEST_PORT, &opts);
+	close_netns(nstoken);
+
+	if (client_fd < 0)
+		return NULL;
+
+	nstoken = open_netns(SERVER_NS);
+	server_fd = accept(*cfg->server_fd, NULL, NULL);
+	close_netns(nstoken);
+	if (server_fd < 0)
+		return NULL;
+
+	conn = malloc(sizeof(struct connection));
+	if (conn) {
+		conn->server_fd = server_fd;
+		conn->client_fd = client_fd;
+	}
+
+	return conn;
+}
+
+static void disconnect_client_from_server(struct subtest_cfg *cfg,
+					  struct connection *conn)
+{
+	struct nstoken *nstoken;
+
+	nstoken = open_netns(SERVER_NS);
+	close(conn->server_fd);
+	close_netns(nstoken);
+	nstoken = open_netns(CLIENT_NS);
+	close(conn->client_fd);
+	close_netns(nstoken);
+	free(conn);
+}
+
+static int send_and_test_data(struct subtest_cfg *cfg, bool must_succeed)
+{
+	struct nstoken *nstoken = NULL;
+	struct connection *conn;
+	int err, res = -1;
+
+	conn = connect_client_to_server(cfg);
+	if (!must_succeed && !ASSERT_EQ(conn, NULL, "connection that must fail"))
+		goto end;
+	else if (!must_succeed)
+		return 0;
+
+	if (!ASSERT_NEQ(conn, NULL, "connection that must succeed"))
+		return 1;
+
+	nstoken = open_netns(CLIENT_NS);
+	err = send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, 0);
+	close_netns(nstoken);
+	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from client"))
+		goto end;
+	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
+		goto end;
+
+	if (!cfg->test_gso) {
+		res = 0;
+		goto end;
+	}
+
+	nstoken = open_netns(CLIENT_NS);
+	err = send(conn->client_fd, tx_buffer, GSO_TEST_DATA_SIZE, 0);
+	close_netns(nstoken);
+	if (!ASSERT_EQ(err, GSO_TEST_DATA_SIZE, "send (large) data from client"))
+		goto end;
+	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
+		goto end;
+
+	res = 0;
+end:
+	disconnect_client_from_server(cfg, conn);
+	return res;
+}
+static void vxlan_decap_mod_args_cb(struct subtest_cfg *cfg, char *dst)
+{
+	snprintf(dst, TUNNEL_ARGS_MAX_LEN, "id %d dstport %d udp6zerocsumrx",
+		 VXLAN_ID, VXLAN_PORT);
+}
+
+static void udp_decap_mod_args_cb(struct subtest_cfg *cfg, char *dst)
+{
+	bool is_mpls = !strcmp(cfg->mac_tun_type, "mpls");
+
+	snprintf(dst, TUNNEL_ARGS_MAX_LEN,
+		 "encap fou encap-sport auto encap-dport %d",
+		 is_mpls ? MPLS_UDP_PORT : UDP_PORT);
+}
+
+static int configure_fou_rx_port(struct subtest_cfg *cfg, bool add)
+{
+	bool is_mpls = strcmp(cfg->mac_tun_type, "mpls") == 0;
+	int fou_proto;
+
+	if (is_mpls)
+		fou_proto = FOU_MPLS_PROTO;
+	else
+		fou_proto = cfg->ipproto == 6 ? 41 : 4;
+
+	SYS(fail, "ip fou %s port %d ipproto %d%s", add ? "add" : "del",
+	    is_mpls ? MPLS_UDP_PORT : UDP_PORT, fou_proto,
+	    cfg->ipproto == 6 ? " -6" : "");
+
+	return 0;
+fail:
+	return 1;
+}
+
+static int add_fou_rx_port(struct subtest_cfg *cfg)
+{
+	return configure_fou_rx_port(cfg, true);
+}
+
+static int del_fou_rx_port(struct subtest_cfg *cfg)
+{
+	return configure_fou_rx_port(cfg, false);
+}
+
+static int update_tunnel_intf_addr(struct subtest_cfg *cfg)
+{
+	SYS(fail, "ip link set dev testtun0 address " MAC_ADDR_VETH2);
+	return 0;
+fail:
+	return -1;
+}
+
+static int configure_kernel_for_mpls(struct subtest_cfg *cfg)
+{
+	SYS(fail, "sysctl -qw net.mpls.platform_labels=%d",
+	    MPLS_TABLE_ENTRIES_COUNT);
+	SYS(fail, "ip -f mpls route add 1000 dev lo");
+	SYS(fail, "ip link set lo up");
+	SYS(fail, "sysctl -qw net.mpls.conf.testtun0.input=1");
+	SYS(fail, "sysctl -qw net.ipv4.conf.lo.rp_filter=0");
+	return 0;
+fail:
+	return -1;
+}
+
+static int configure_encapsulation(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken = open_netns(CLIENT_NS);
+	int ret;
+
+	ret = generic_attach_egr("veth1", cfg->client_egress_prog_fd);
+	close_netns(nstoken);
+
+	return ret;
+}
+
+static int configure_kernel_decapsulation(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+
+	if (cfg->configure_fou_rx_port && !ASSERT_OK(
+		    add_fou_rx_port(cfg), "configure FOU RX port"))
+		goto fail;
+	SYS(fail, "ip link add name testtun0 type %s %s remote %s local %s %s",
+	    cfg->iproute_tun_type, cfg->tmode ? cfg->tmode : "",
+	    cfg->tunnel_client_addr, cfg->tunnel_server_addr,
+	    cfg->extra_decap_mod_args);
+	if (cfg->tunnel_need_veth_mac &&
+	    !ASSERT_OK(update_tunnel_intf_addr(cfg), "update testtun0 mac"))
+		goto fail;
+	if (cfg->configure_mpls &&
+	    (!ASSERT_OK(configure_kernel_for_mpls(cfg),
+			"configure MPLS decap")))
+		goto fail;
+	SYS(fail, "sysctl -qw net.ipv4.conf.all.rp_filter=0");
+	SYS(fail, "sysctl -qw net.ipv4.conf.testtun0.rp_filter=0");
+	SYS(fail, "ip link set dev testtun0 up");
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
+static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken = open_netns(SERVER_NS);
+
+	SYS(fail, "ip link del testtun0");
+	if (!ASSERT_OK(generic_attach_igr("veth2", cfg->server_ingress_prog_fd),
+		       "attach_program"))
+		goto fail;
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+
+}
+
+static void run_test(struct subtest_cfg *cfg)
+{
+	if (!ASSERT_OK(run_server(cfg), "run server"))
+		goto fail;
+
+	// Basic communication must work
+	if (!ASSERT_OK(send_and_test_data(cfg, true), "connect without any encap"))
+		goto fail;
+
+	// Attach encapsulation program to client, communication must fail
+	if (!ASSERT_OK(configure_encapsulation(cfg), "configure encapsulation"))
+		return;
+	if (!ASSERT_OK(send_and_test_data(cfg, false), "connect with encap prog only"))
+		goto fail;
+
+	/* Insert kernel decap module, connection must succeed */
+	if (!ASSERT_OK(configure_kernel_decapsulation(cfg), "configure kernel decapsulation"))
+		goto fail;
+	if (!ASSERT_OK(send_and_test_data(cfg, !cfg->expect_kern_decap_failure),
+		       "connect with encap prog and kern decap"))
+		goto fail;
+
+	// Replace kernel module with BPF decap, test must pass
+	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure ebpf decapsulation"))
+		goto fail;
+	ASSERT_OK(send_and_test_data(cfg, true), "connect with encap and decap progs");
+
+fail:
+	stop_server(cfg);
+}
+
+static int setup(void)
+{
+	struct nstoken *nstoken = NULL;
+	int fd, err;
+
+	fd = open("/dev/urandom", O_RDONLY);
+	if (!ASSERT_OK_FD(fd, "open urandom"))
+		goto fail;
+	err = read(fd, tx_buffer, BUFFER_LEN);
+	close(fd);
+
+	if (!ASSERT_EQ(err, BUFFER_LEN, "read random bytes"))
+		goto fail;
+
+	/* Configure the testing network */
+	if (!ASSERT_OK(make_netns(CLIENT_NS), "create client ns") ||
+	    !ASSERT_OK(make_netns(SERVER_NS), "create server ns"))
+		goto fail;
+
+	nstoken = open_netns(CLIENT_NS);
+	SYS(fail, "ip link add %s type veth peer name %s",
+		"veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
+		"veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
+	SYS(fail, "ethtool -K veth1 tso off");
+	SYS(fail, "ip link set veth1 up");
+	close_netns(nstoken);
+	nstoken = open_netns(SERVER_NS);
+	SYS(fail, "ip link set veth2 up");
+	close_netns(nstoken);
+
+	return 0;
+fail:
+	close_netns(nstoken);
+	return 1;
+}
+static int subtest_setup(struct test_tc_tunnel *skel, struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken;
+
+	set_subtest_addresses(cfg);
+	if (!ASSERT_OK(set_subtest_progs(cfg, skel),
+		       "find subtest progs"))
+		return -1;
+	if (cfg->extra_decap_mod_args_cb)
+		cfg->extra_decap_mod_args_cb(cfg, cfg->extra_decap_mod_args);
+
+	nstoken = open_netns(CLIENT_NS);
+	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
+	SYS(fail, "ip -4 route flush table main");
+	SYS(fail, "ip -4 route add " IP4_ADDR_VETH2 " mtu 1450 dev veth1");
+	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH1 "/64 dev veth1 nodad");
+	SYS(fail, "ip -6 route flush table main");
+	SYS(fail, "ip -6 route add " IP6_ADDR_VETH2 " mtu 1430 dev veth1");
+	close_netns(nstoken);
+
+
+	nstoken = open_netns(SERVER_NS);
+	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
+	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH2 "/64 dev veth2 nodad");
+	close_netns(nstoken);
+
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
+static void subtest_cleanup(struct subtest_cfg *cfg)
+{
+	struct nstoken *nstoken;
+
+	nstoken = open_netns(CLIENT_NS);
+	SYS_NOFAIL("tc qdisc delete dev veth1 parent ffff:fff1");
+	SYS_NOFAIL("ip a flush veth1");
+	close_netns(nstoken);
+	nstoken = open_netns(SERVER_NS);
+	SYS_NOFAIL("ip link del testtun0");
+	SYS_NOFAIL("tc qdisc delete dev veth2 parent ffff:fff1");
+	SYS_NOFAIL("ip a flush veth2");
+	if (cfg->configure_mpls)
+		SYS_NOFAIL("ip -f mpls route del 1000 dev lo");
+	if (cfg->configure_fou_rx_port)
+		del_fou_rx_port(cfg);
+
+	close_netns(nstoken);
+}
+
+static void cleanup(void)
+{
+	remove_netns(CLIENT_NS);
+	remove_netns(SERVER_NS);
+}
+
+struct subtest_cfg subtests_cfg[] = {
+	{
+		.ebpf_tun_type = "ipip",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "ipip",
+		.ipproto = 4,
+	},
+	{
+		.ebpf_tun_type = "ipip6",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "ip6tnl",
+		.ipproto = 4,
+		.tunnel_client_addr = IP6_ADDR_VETH1,
+		.tunnel_server_addr = IP6_ADDR_VETH2,
+	},
+	{
+		.ebpf_tun_type = "ip6tnl",
+		.iproute_tun_type = "ip6tnl",
+		.mac_tun_type = "none",
+		.ipproto = 6,
+	},
+	{
+		.mac_tun_type = "none",
+		.ebpf_tun_type = "sit",
+		.iproute_tun_type = "sit",
+		.ipproto = 6,
+		.tunnel_client_addr = IP4_ADDR_VETH1,
+		.tunnel_server_addr = IP4_ADDR_VETH2,
+	},
+	{
+		.ebpf_tun_type = "vxlan",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "vxlan",
+		.ipproto = 4,
+		.extra_decap_mod_args_cb = vxlan_decap_mod_args_cb,
+		.tunnel_need_veth_mac = true
+	},
+	{
+		.ebpf_tun_type = "ip6vxlan",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "vxlan",
+		.ipproto = 6,
+		.extra_decap_mod_args_cb = vxlan_decap_mod_args_cb,
+		.tunnel_need_veth_mac = true
+	},
+	{
+		.ebpf_tun_type = "gre",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "gre",
+		.ipproto = 4,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "gre",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "gretap",
+		.ipproto = 4,
+		.tunnel_need_veth_mac = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "gre",
+		.mac_tun_type = "mpls",
+		.iproute_tun_type = "gre",
+		.ipproto = 4,
+		.configure_mpls = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "ip6gre",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "ip6gre",
+		.ipproto = 6,
+		.test_gso = true,
+	},
+	{
+		.ebpf_tun_type = "ip6gre",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "ip6gretap",
+		.ipproto = 6,
+		.tunnel_need_veth_mac = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "ip6gre",
+		.mac_tun_type = "mpls",
+		.iproute_tun_type = "ip6gre",
+		.ipproto = 6,
+		.configure_mpls = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "udp",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "ipip",
+		.ipproto = 4,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "udp",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "ipip",
+		.ipproto = 4,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.expect_kern_decap_failure = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "udp",
+		.mac_tun_type = "mpls",
+		.iproute_tun_type = "ipip",
+		.ipproto = 4,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.tmode = "mode any ttl 255",
+		.configure_mpls = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "ip6udp",
+		.mac_tun_type = "none",
+		.iproute_tun_type = "ip6tnl",
+		.ipproto = 6,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "ip6udp",
+		.mac_tun_type = "eth",
+		.iproute_tun_type = "ip6tnl",
+		.ipproto = 6,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.expect_kern_decap_failure = true,
+		.test_gso = true
+	},
+	{
+		.ebpf_tun_type = "ip6udp",
+		.mac_tun_type = "mpls",
+		.iproute_tun_type = "ip6tnl",
+		.ipproto = 6,
+		.extra_decap_mod_args_cb = udp_decap_mod_args_cb,
+		.configure_fou_rx_port = true,
+		.tmode = "mode any ttl 255",
+		.expect_kern_decap_failure = true,
+		.test_gso = true
+	},
+};
+
+int subtests_count = sizeof(subtests_cfg)/sizeof(struct subtest_cfg);
+
+
+void test_tc_tunnel(void)
+{
+	struct test_tc_tunnel *skel;
+	struct subtest_cfg *cfg;
+	int i, ret;
+
+	skel = test_tc_tunnel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel open and load"))
+		return;
+
+	if (!ASSERT_OK(setup(), "global setup"))
+		return;
+
+	for (i = 0; i < subtests_count; i++) {
+		cfg = &subtests_cfg[i];
+		ret = build_subtest_name(cfg, cfg->name, TEST_NAME_MAX_LEN);
+		if (ret < 0 || !test__start_subtest(cfg->name))
+			continue;
+		subtest_setup(skel, cfg);
+		run_test(cfg);
+		subtest_cleanup(cfg);
+	}
+	cleanup();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
index c5a26f7e8ecfd0404960e75f07388fe609522bde..6f4736b90ee49b01968f50713dce4d3cace83a57 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
@@ -422,7 +422,7 @@ static __always_inline int encap_ipv6(struct __sk_buff *skb, __u8 encap_proto,
 	return __encap_ipv6(skb, encap_proto, l2_proto, 0);
 }
 
-SEC("encap_ipip_none")
+SEC("tc")
 int __encap_ipip_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -431,7 +431,7 @@ int __encap_ipip_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_gre_none")
+SEC("tc")
 int __encap_gre_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -440,7 +440,7 @@ int __encap_gre_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_gre_mpls")
+SEC("tc")
 int __encap_gre_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -449,7 +449,7 @@ int __encap_gre_mpls(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_gre_eth")
+SEC("tc")
 int __encap_gre_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -458,7 +458,7 @@ int __encap_gre_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_udp_none")
+SEC("tc")
 int __encap_udp_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -467,7 +467,7 @@ int __encap_udp_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_udp_mpls")
+SEC("tc")
 int __encap_udp_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -476,7 +476,7 @@ int __encap_udp_mpls(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_udp_eth")
+SEC("tc")
 int __encap_udp_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -485,7 +485,7 @@ int __encap_udp_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_vxlan_eth")
+SEC("tc")
 int __encap_vxlan_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -496,7 +496,7 @@ int __encap_vxlan_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_sit_none")
+SEC("tc")
 int __encap_sit_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -505,7 +505,7 @@ int __encap_sit_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6tnl_none")
+SEC("tc")
 int __encap_ip6tnl_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -514,7 +514,7 @@ int __encap_ip6tnl_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ipip6_none")
+SEC("tc")
 int __encap_ipip6_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IP))
@@ -523,7 +523,7 @@ int __encap_ipip6_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6gre_none")
+SEC("tc")
 int __encap_ip6gre_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -532,7 +532,7 @@ int __encap_ip6gre_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6gre_mpls")
+SEC("tc")
 int __encap_ip6gre_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -541,7 +541,7 @@ int __encap_ip6gre_mpls(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6gre_eth")
+SEC("tc")
 int __encap_ip6gre_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -550,7 +550,7 @@ int __encap_ip6gre_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6udp_none")
+SEC("tc")
 int __encap_ip6udp_none(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -559,7 +559,7 @@ int __encap_ip6udp_none(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6udp_mpls")
+SEC("tc")
 int __encap_ip6udp_mpls(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -568,7 +568,7 @@ int __encap_ip6udp_mpls(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6udp_eth")
+SEC("tc")
 int __encap_ip6udp_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -577,7 +577,7 @@ int __encap_ip6udp_eth(struct __sk_buff *skb)
 		return TC_ACT_OK;
 }
 
-SEC("encap_ip6vxlan_eth")
+SEC("tc")
 int __encap_ip6vxlan_eth(struct __sk_buff *skb)
 {
 	if (skb->protocol == __bpf_constant_htons(ETH_P_IPV6))
@@ -684,7 +684,7 @@ static int decap_ipv6(struct __sk_buff *skb)
 			      iph_outer.nexthdr);
 }
 
-SEC("decap")
+SEC("tc")
 int decap_f(struct __sk_buff *skb)
 {
 	switch (skb->protocol) {

-- 
2.51.0


