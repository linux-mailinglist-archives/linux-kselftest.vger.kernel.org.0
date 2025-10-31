Return-Path: <linux-kselftest+bounces-44512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED3C23FDA
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78934EAD13
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B01E330313;
	Fri, 31 Oct 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vQSTRGHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585032D7E6
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761901321; cv=none; b=V8kc7v2kO1w4u+FLKrsoUpbZys/rPeWFgATqQzb/66N+AWPa4kDGkcXoCgz+NwOE+K2OISsk4S0AddCgKaMRH6s/lo/7twgGXKuVbB/7y+P15jSAzQECuuAWqoboY1kgi1yf6i4Dw/vghwSm38MzkQSVPQ5sF0LQwARnHJ3paS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761901321; c=relaxed/simple;
	bh=xqZ4ks0zodwVdhdoU6aLILyMcPX95g56qW1FHGqGTRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py+pg3vPV1Ffjn7fuzp0w3SGU0lz0yISjwGuQPoqetdG5QJv5fFFb8vgPcpQ7WFkq5qV0ixcYQO3wv0K2bwHVDd2IX/FEd51Nyzm/c/4IjTV+WSFIPUCLlC32M23VQn4kq0sADPs7BSXRQPbhHZIOf8I3Tw05R8/1BlP8YqgNjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vQSTRGHZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A4F6D1A17A9;
	Fri, 31 Oct 2025 09:01:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7949160704;
	Fri, 31 Oct 2025 09:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B59E411810838;
	Fri, 31 Oct 2025 10:01:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761901315; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kef/BUw/7kskzjxgi11EVQHCfO8iul2HvO8swTDNzfU=;
	b=vQSTRGHZG/JHOsfT87atsoYUt+0Zdf0vxb5xD00YJoYSQ5OlznKJiLzo5FjfW2uGEMIsJT
	3hJIQ0agBbQG5L9+6HqvbDt5hDvlk9NC9ZYVwgH8O8R2gk6LOyFe2m4m3wTMpWE9qYnE0W
	5QwLh/QzomfBMtz1FRXycJhmAjJNyeG3b/zkUw43LTJr/kgX0zeEIRzNJQtISekfapwtpu
	BUd2EJedANGGSdrLJSL//5u3z24f4E3/M09q6BsunwyTd6jkAdSEg8cuQBpQ0xeeinD0p/
	MhkImuqyE4qp9GFM+EQOV1Fmb5c2+CtZWetjqOyOyR3AEgb2sK/EmwPVz5uqnA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 31 Oct 2025 10:01:42 +0100
Subject: [PATCH bpf-next 2/3] selftests/bpf: add checks in tc_tunnel when
 entering net namespaces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-tc_tunnel_improv-v1-2-0ffe44d27eda@bootlin.com>
References: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
In-Reply-To: <20251031-tc_tunnel_improv-v1-0-0ffe44d27eda@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

test_tc_tunnel is missing checks on any open_netns. Add those checks
anytime we try to enter a net namespace, and skip the related operations
if we fail. While at it, reduce the number of open_netns/close_netns for
cases involving operations in two distinct namespaces: the test
currently does the following:

  nstoken = open_netns("foo")
  do_operation();
  close(nstoken);
  nstoken = open_netns("bar")
  do_another_operation();
  close(nstoken);

As already stated in reviews for the initial test, we don't need to go
back to the root net namespace to enter a second namespace, so just do:

  ntoken_client = open_netns("foo")
  do_operation();
  nstoken_server = open_netns("bar")
  do_another_operation();
  close(nstoken_server);
  close(nstoken_client);

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 .../selftests/bpf/prog_tests/test_tc_tunnel.c      | 134 ++++++++++++++-------
 1 file changed, 88 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index 1d8d38e67f8b..deea90aaefad 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -133,8 +133,12 @@ static void set_subtest_addresses(struct subtest_cfg *cfg)
 
 static int run_server(struct subtest_cfg *cfg)
 {
-	struct nstoken *nstoken = open_netns(SERVER_NS);
 	int family = cfg->ipproto == 6 ? AF_INET6 : AF_INET;
+	struct nstoken *nstoken;
+
+	nstoken = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		return -1;
 
 	cfg->server_fd = start_reuseport_server(family, SOCK_STREAM,
 						cfg->server_addr, TEST_PORT,
@@ -319,6 +323,10 @@ static int configure_encapsulation(struct subtest_cfg *cfg)
 static int configure_kernel_decapsulation(struct subtest_cfg *cfg)
 {
 	struct nstoken *nstoken = open_netns(SERVER_NS);
+	int ret = -1;
+
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		return ret;
 
 	if (cfg->configure_fou_rx_port &&
 	    !ASSERT_OK(add_fou_rx_port(cfg), "configure FOU RX port"))
@@ -337,11 +345,11 @@ static int configure_kernel_decapsulation(struct subtest_cfg *cfg)
 	SYS(fail, "sysctl -qw net.ipv4.conf.all.rp_filter=0");
 	SYS(fail, "sysctl -qw net.ipv4.conf.testtun0.rp_filter=0");
 	SYS(fail, "ip link set dev testtun0 up");
-	close_netns(nstoken);
-	return 0;
+
+	ret = 0;
 fail:
 	close_netns(nstoken);
-	return -1;
+	return ret;
 }
 
 static void remove_kernel_decapsulation(struct subtest_cfg *cfg)
@@ -356,6 +364,10 @@ static void remove_kernel_decapsulation(struct subtest_cfg *cfg)
 static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
 {
 	struct nstoken *nstoken = open_netns(SERVER_NS);
+	int ret = -1;
+
+	if (!ASSERT_OK_PTR(nstoken, "open server ns"))
+		return ret;
 
 	if (!cfg->expect_kern_decap_failure)
 		SYS(fail, "ip link del testtun0");
@@ -363,17 +375,20 @@ static int configure_ebpf_decapsulation(struct subtest_cfg *cfg)
 	if (!ASSERT_OK(tc_prog_attach("veth2", cfg->server_ingress_prog_fd, -1),
 		       "attach_program"))
 		goto fail;
-	close_netns(nstoken);
-	return 0;
+
+	ret = 0;
 fail:
 	close_netns(nstoken);
-	return -1;
+	return ret;
 }
 
 static void run_test(struct subtest_cfg *cfg)
 {
 	struct nstoken *nstoken = open_netns(CLIENT_NS);
 
+	if (!ASSERT_OK_PTR(nstoken, "open client ns"))
+		return;
+
 	if (!ASSERT_OK(run_server(cfg), "run server"))
 		goto fail;
 
@@ -407,7 +422,7 @@ static void run_test(struct subtest_cfg *cfg)
 
 static int setup(void)
 {
-	struct nstoken *nstoken = NULL;
+	struct nstoken *nstoken_client, *nstoken_server;
 	int fd, err;
 
 	fd = open("/dev/urandom", O_RDONLY);
@@ -424,52 +439,75 @@ static int setup(void)
 	    !ASSERT_OK(make_netns(SERVER_NS), "create server ns"))
 		goto fail;
 
-	nstoken = open_netns(CLIENT_NS);
-	SYS(fail, "ip link add %s type veth peer name %s",
+	nstoken_client = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken_client, "open client ns"))
+		goto fail_delete_ns;
+	SYS(fail_close_ns_client, "ip link add %s type veth peer name %s",
 	    "veth1 mtu 1500 netns " CLIENT_NS " address " MAC_ADDR_VETH1,
 	    "veth2 mtu 1500 netns " SERVER_NS " address " MAC_ADDR_VETH2);
-	SYS(fail, "ethtool -K veth1 tso off");
-	SYS(fail, "ip link set veth1 up");
-	close_netns(nstoken);
-	nstoken = open_netns(SERVER_NS);
-	SYS(fail, "ip link set veth2 up");
-	close_netns(nstoken);
-
+	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
+	SYS(fail_close_ns_client, "ip link set veth1 up");
+	nstoken_server = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
+		goto fail_close_ns_client;
+	SYS(fail_close_ns_server, "ip link set veth2 up");
+
+	close_netns(nstoken_server);
+	close_netns(nstoken_client);
 	return 0;
+
+fail_close_ns_server:
+	close_netns(nstoken_server);
+fail_close_ns_client:
+	close_netns(nstoken_client);
+fail_delete_ns:
+	SYS_NOFAIL("ip netns del " CLIENT_NS);
+	SYS_NOFAIL("ip netns del " SERVER_NS);
 fail:
-	close_netns(nstoken);
-	return 1;
+	return -1;
 }
 
 static int subtest_setup(struct test_tc_tunnel *skel, struct subtest_cfg *cfg)
 {
-	struct nstoken *nstoken;
+	struct nstoken *nstoken_client, *nstoken_server;
+	int ret = -1;
 
 	set_subtest_addresses(cfg);
 	if (!ASSERT_OK(set_subtest_progs(cfg, skel),
 		       "find subtest progs"))
-		return -1;
+		goto fail;
 	if (cfg->extra_decap_mod_args_cb)
 		cfg->extra_decap_mod_args_cb(cfg, cfg->extra_decap_mod_args);
 
-	nstoken = open_netns(CLIENT_NS);
-	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
-	SYS(fail, "ip -4 route flush table main");
-	SYS(fail, "ip -4 route add " IP4_ADDR_VETH2 " mtu 1450 dev veth1");
-	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH1 "/64 dev veth1 nodad");
-	SYS(fail, "ip -6 route flush table main");
-	SYS(fail, "ip -6 route add " IP6_ADDR_VETH2 " mtu 1430 dev veth1");
-	close_netns(nstoken);
-
-	nstoken = open_netns(SERVER_NS);
-	SYS(fail, "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
-	SYS(fail, "ip -6 addr add " IP6_ADDR_VETH2 "/64 dev veth2 nodad");
-	close_netns(nstoken);
-
-	return 0;
+	nstoken_client = open_netns(CLIENT_NS);
+	if (!ASSERT_OK_PTR(nstoken_client, "open client ns"))
+		goto fail;
+	SYS(fail_close_client_ns,
+	    "ip -4 addr add " IP4_ADDR_VETH1 "/24 dev veth1");
+	SYS(fail_close_client_ns, "ip -4 route flush table main");
+	SYS(fail_close_client_ns,
+	    "ip -4 route add " IP4_ADDR_VETH2 " mtu 1450 dev veth1");
+	SYS(fail_close_client_ns,
+	    "ip -6 addr add " IP6_ADDR_VETH1 "/64 dev veth1 nodad");
+	SYS(fail_close_client_ns, "ip -6 route flush table main");
+	SYS(fail_close_client_ns,
+	    "ip -6 route add " IP6_ADDR_VETH2 " mtu 1430 dev veth1");
+	nstoken_server = open_netns(SERVER_NS);
+	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
+		goto fail_close_client_ns;
+	SYS(fail_close_server_ns,
+	    "ip -4 addr add " IP4_ADDR_VETH2 "/24 dev veth2");
+	SYS(fail_close_server_ns,
+	    "ip -6 addr add " IP6_ADDR_VETH2 "/64 dev veth2 nodad");
+
+	ret = 0;
+
+fail_close_server_ns:
+	close_netns(nstoken_server);
+fail_close_client_ns:
+	close_netns(nstoken_client);
 fail:
-	close_netns(nstoken);
-	return -1;
+	return ret;
 }
 
 
@@ -478,15 +516,19 @@ static void subtest_cleanup(struct subtest_cfg *cfg)
 	struct nstoken *nstoken;
 
 	nstoken = open_netns(CLIENT_NS);
-	SYS_NOFAIL("tc qdisc delete dev veth1 parent ffff:fff1");
-	SYS_NOFAIL("ip a flush veth1");
-	close_netns(nstoken);
+	if (ASSERT_OK_PTR(nstoken, "open clien ns")) {
+		SYS_NOFAIL("tc qdisc delete dev veth1 parent ffff:fff1");
+		SYS_NOFAIL("ip a flush veth1");
+		close_netns(nstoken);
+	}
 	nstoken = open_netns(SERVER_NS);
-	SYS_NOFAIL("tc qdisc delete dev veth2 parent ffff:fff1");
-	SYS_NOFAIL("ip a flush veth2");
-	if (!cfg->expect_kern_decap_failure)
-		remove_kernel_decapsulation(cfg);
-	close_netns(nstoken);
+	if (ASSERT_OK_PTR(nstoken, "open clien ns")) {
+		SYS_NOFAIL("tc qdisc delete dev veth2 parent ffff:fff1");
+		SYS_NOFAIL("ip a flush veth2");
+		if (!cfg->expect_kern_decap_failure)
+			remove_kernel_decapsulation(cfg);
+		close_netns(nstoken);
+	}
 }
 
 static void cleanup(void)

-- 
2.51.1.dirty


