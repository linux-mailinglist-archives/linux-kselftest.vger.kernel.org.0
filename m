Return-Path: <linux-kselftest+bounces-20226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBAE9A5622
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436DE1F21031
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F039199FAC;
	Sun, 20 Oct 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i0w4tRHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071AE1990CE;
	Sun, 20 Oct 2024 19:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729452202; cv=none; b=E/f0GhmpNfHCmOYf+zEPAkI2Z0DQTq/Mq8mgD3excnW4XwYz44liNsyDlZejczYpvvWz1sBT7aaPb9KybA2I6gMCtQQjkcsHByxdhNyP/m6xzw1vU8KPCY4qVTyRm6Sq7+MljZYhFfRbx0FLqIuMIdqLUQ1O6R2318+aldfeDlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729452202; c=relaxed/simple;
	bh=izqafoqrPNg8Ij4DpciUfhMTyvM8nmM1n/FycDLCGZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h78/pondOJLlFv6lfTyysorBs6FPIBQDALm+FmTh2mBW2MOqJWhpfljGjhdF0+/DkrRrvp2H0AYJuWTas+Uav3ZF84WrabcD9tNx0zlhL7IIWL6uaGGY/gYzURROuNi/yCznXnlS6sY/xieW2obf/iMRdA/nehtTgIjggmKEENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i0w4tRHa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EE7424000A;
	Sun, 20 Oct 2024 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729452191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+U9ATaOnwKmB0JT3jLn0nhzfYO1ML5he3rqLWosEfg=;
	b=i0w4tRHaIiy/BCW6LUfehPn/yyCFYwfAiZglG/BKyrdfUqWwP6zwxcIH1jx281HV5tBY2U
	8tOFbfsYNDFJ3X8uFfuSuOOJwVLpWzDOUCeXBDoeaxj7CkdKsAE90yie6iwbbR9gdEoMvQ
	9LEA7jtWPVXNntny5TOM7VSWXiE7761flthuf9rr6FzXUoB3lpliwQtdbZXXqs2CxFa6RO
	kv2tKpOL0euT0V4vxyI2z3z3zQOaLv0IpsTXTN5Sw4G0nN6s37Yz7ZJvLyuaiCILUnE97M
	a21gVX50md6xAffszcP6V49I+OKmclFE17iih4MxV15tzBMHxXcQes7tPCWS4Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sun, 20 Oct 2024 21:22:56 +0200
Subject: [PATCH bpf-next v2 4/6] selftests/bpf: add ipv4 and dual ipv4/ipv6
 support in btf_skc_cls_ingress
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241020-syncookie-v2-4-2db240225fed@bootlin.com>
References: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
In-Reply-To: <20241020-syncookie-v2-0-2db240225fed@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenz Bauer <lorenz.bauer@isovalent.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: alexis.lothore@bootlin.com

btf_skc_cls_ingress test currently checks that syncookie and
bpf_sk_assign/release helpers behave correctly in multiple scenarios,
but only with ipv4 socket.

Increase those helpers coverage by adding testing support for IPv6-only
sockets and IPv4/IPv6 sockets. The rework is mostly based on features
brought earlier in test_tcp_check_syncookie.sh to cover some fixes
performed on those helpers, but test_tcp_check_syncookie.sh is not
integrated in test_progs. The most notable changes linked to this are:
- some rework in the corresponding eBPF program to support both types of
  traffic
- the switch from start_server to start_server_str to allow to check
  some socket options
- the introduction of new subtests for ipv4 and ipv4/ipv6

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fix odd indent on switch cases
- add missing return or goto in default cases in switches
- add a PRINT_FAIL on invalid subtest configuration
- remove unnecessary initializers
- remove unnecessary check in bpf program
- remove duplicate return in bpf program

The rework has been tested in a local Qemu environment and in CI:
  # ./test_progs -a btf_skc_cls_ingress
  #38/1    btf_skc_cls_ingress/conn_ipv4:OK
  #38/2    btf_skc_cls_ingress/conn_ipv6:OK
  #38/3    btf_skc_cls_ingress/conn_dual:OK
  #38/4    btf_skc_cls_ingress/syncookie_ipv4:OK
  #38/5    btf_skc_cls_ingress/syncookie_ipv6:OK
  #38/6    btf_skc_cls_ingress/syncookie_dual:OK
  #38      btf_skc_cls_ingress:OK
  Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
---
 .../selftests/bpf/prog_tests/btf_skc_cls_ingress.c | 117 ++++++++++++++++++---
 .../selftests/bpf/progs/test_btf_skc_cls_ingress.c |  80 +++++++++-----
 2 files changed, 158 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
index 426c9d5402fa8fd57f233feb1f43ffe66e386b7a..29b946d84816e41e87f11d2400f5c9a68f91a126 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_skc_cls_ingress.c
@@ -19,6 +19,15 @@
 
 #define TEST_NS "skc_cls_ingress"
 
+#define BIT(n)		(1 << (n))
+#define TEST_MODE_IPV4	BIT(0)
+#define TEST_MODE_IPV6	BIT(1)
+#define TEST_MODE_DUAL	(TEST_MODE_IPV4 | TEST_MODE_IPV6)
+
+#define SERVER_ADDR_IPV4	"127.0.0.1"
+#define SERVER_ADDR_IPV6	"::1"
+#define SERVER_ADDR_DUAL	"::0"
+
 static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
 {
 	LIBBPF_OPTS(bpf_tc_hook, qdisc_lo, .attach_point = BPF_TC_INGRESS);
@@ -55,6 +64,7 @@ static struct netns_obj *prepare_netns(struct test_btf_skc_cls_ingress *skel)
 
 static void reset_test(struct test_btf_skc_cls_ingress *skel)
 {
+	memset(&skel->bss->srv_sa4, 0, sizeof(skel->bss->srv_sa4));
 	memset(&skel->bss->srv_sa6, 0, sizeof(skel->bss->srv_sa6));
 	skel->bss->listen_tp_sport = 0;
 	skel->bss->req_sk_sport = 0;
@@ -69,26 +79,85 @@ static void print_err_line(struct test_btf_skc_cls_ingress *skel)
 		printf("bpf prog error at line %u\n", skel->bss->linum);
 }
 
-static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies)
+static int v6only_true(int fd, void *opts)
+{
+	int mode = true;
+
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
+}
+
+static int v6only_false(int fd, void *opts)
+{
+	int mode = false;
+
+	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, &mode, sizeof(mode));
+}
+
+static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies,
+		     int ip_mode)
 {
 	const char *tcp_syncookies = gen_cookies ? "2" : "1";
 	int listen_fd = -1, cli_fd = -1, srv_fd = -1, err;
+	struct network_helper_opts opts = { 0 };
+	struct sockaddr_storage *addr;
 	struct sockaddr_in6 srv_sa6;
-	socklen_t addrlen = sizeof(srv_sa6);
+	struct sockaddr_in srv_sa4;
+	socklen_t addr_len;
+	int sock_family;
+	char *srv_addr;
 	int srv_port;
 
+	switch (ip_mode) {
+	case TEST_MODE_IPV4:
+		sock_family = AF_INET;
+		srv_addr = SERVER_ADDR_IPV4;
+		addr = (struct sockaddr_storage *)&srv_sa4;
+		addr_len = sizeof(srv_sa4);
+		break;
+	case TEST_MODE_IPV6:
+		opts.post_socket_cb = v6only_true;
+		sock_family = AF_INET6;
+		srv_addr = SERVER_ADDR_IPV6;
+		addr = (struct sockaddr_storage *)&srv_sa6;
+		addr_len = sizeof(srv_sa6);
+		break;
+	case TEST_MODE_DUAL:
+		opts.post_socket_cb = v6only_false;
+		sock_family = AF_INET6;
+		srv_addr = SERVER_ADDR_DUAL;
+		addr = (struct sockaddr_storage *)&srv_sa6;
+		addr_len = sizeof(srv_sa6);
+		break;
+	default:
+		PRINT_FAIL("Unknown IP mode %d", ip_mode);
+		return;
+	}
+
 	if (write_sysctl("/proc/sys/net/ipv4/tcp_syncookies", tcp_syncookies))
 		return;
 
-	listen_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
+	listen_fd = start_server_str(sock_family, SOCK_STREAM, srv_addr,  0,
+				     &opts);
 	if (!ASSERT_OK_FD(listen_fd, "start server"))
 		return;
 
-	err = getsockname(listen_fd, (struct sockaddr *)&srv_sa6, &addrlen);
+	err = getsockname(listen_fd, (struct sockaddr *)addr, &addr_len);
 	if (!ASSERT_OK(err, "getsockname(listen_fd)"))
 		goto done;
-	memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
-	srv_port = ntohs(srv_sa6.sin6_port);
+
+	switch (ip_mode) {
+	case TEST_MODE_IPV4:
+		memcpy(&skel->bss->srv_sa4, &srv_sa4, sizeof(srv_sa4));
+		srv_port = ntohs(srv_sa4.sin_port);
+		break;
+	case TEST_MODE_IPV6:
+	case TEST_MODE_DUAL:
+		memcpy(&skel->bss->srv_sa6, &srv_sa6, sizeof(srv_sa6));
+		srv_port = ntohs(srv_sa6.sin6_port);
+		break;
+	default:
+		goto done;
+	}
 
 	cli_fd = connect_to_fd(listen_fd, 0);
 	if (!ASSERT_OK_FD(cli_fd, "connect client"))
@@ -125,14 +194,34 @@ static void run_test(struct test_btf_skc_cls_ingress *skel, bool gen_cookies)
 		close(srv_fd);
 }
 
-static void test_conn(struct test_btf_skc_cls_ingress *skel)
+static void test_conn_ipv4(struct test_btf_skc_cls_ingress *skel)
+{
+	run_test(skel, false, TEST_MODE_IPV4);
+}
+
+static void test_conn_ipv6(struct test_btf_skc_cls_ingress *skel)
+{
+	run_test(skel, false, TEST_MODE_IPV6);
+}
+
+static void test_conn_dual(struct test_btf_skc_cls_ingress *skel)
+{
+	run_test(skel, false, TEST_MODE_DUAL);
+}
+
+static void test_syncookie_ipv4(struct test_btf_skc_cls_ingress *skel)
+{
+	run_test(skel, true, TEST_MODE_IPV4);
+}
+
+static void test_syncookie_ipv6(struct test_btf_skc_cls_ingress *skel)
 {
-	run_test(skel, false);
+	run_test(skel, true, TEST_MODE_IPV6);
 }
 
-static void test_syncookie(struct test_btf_skc_cls_ingress *skel)
+static void test_syncookie_dual(struct test_btf_skc_cls_ingress *skel)
 {
-	run_test(skel, true);
+	run_test(skel, true, TEST_MODE_DUAL);
 }
 
 struct test {
@@ -142,8 +231,12 @@ struct test {
 
 #define DEF_TEST(name) { #name, test_##name }
 static struct test tests[] = {
-	DEF_TEST(conn),
-	DEF_TEST(syncookie),
+	DEF_TEST(conn_ipv4),
+	DEF_TEST(conn_ipv6),
+	DEF_TEST(conn_dual),
+	DEF_TEST(syncookie_ipv4),
+	DEF_TEST(syncookie_ipv6),
+	DEF_TEST(syncookie_dual),
 };
 
 void test_btf_skc_cls_ingress(void)
diff --git a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
index f0759efff6ef15d2663927400dd064c53b020f78..b38ca3c35994ba8e36d5108fa5f2f4053384368a 100644
--- a/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
+++ b/tools/testing/selftests/bpf/progs/test_btf_skc_cls_ingress.c
@@ -10,6 +10,7 @@
 #endif
 
 struct sockaddr_in6 srv_sa6 = {};
+struct sockaddr_in srv_sa4 = {};
 __u16 listen_tp_sport = 0;
 __u16 req_sk_sport = 0;
 __u32 recv_cookie = 0;
@@ -18,8 +19,8 @@ __u32 linum = 0;
 
 #define LOG() ({ if (!linum) linum = __LINE__; })
 
-static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
-				  struct tcp_sock *tp,
+static void test_syncookie_helper(void *iphdr, int iphdr_size,
+				  struct tcphdr *th, struct tcp_sock *tp,
 				  struct __sk_buff *skb)
 {
 	if (th->syn) {
@@ -38,7 +39,7 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
 			return;
 		}
 
-		mss_cookie = bpf_tcp_gen_syncookie(tp, ip6h, sizeof(*ip6h),
+		mss_cookie = bpf_tcp_gen_syncookie(tp, iphdr, iphdr_size,
 						   th, 40);
 		if (mss_cookie < 0) {
 			if (mss_cookie != -ENOENT)
@@ -48,7 +49,7 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
 		}
 	} else if (gen_cookie) {
 		/* It was in cookie mode */
-		int ret = bpf_tcp_check_syncookie(tp, ip6h, sizeof(*ip6h),
+		int ret = bpf_tcp_check_syncookie(tp, iphdr, iphdr_size,
 						  th, sizeof(*th));
 
 		if (ret < 0) {
@@ -60,26 +61,58 @@ static void test_syncookie_helper(struct ipv6hdr *ip6h, struct tcphdr *th,
 	}
 }
 
-static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
+static int handle_ip_tcp(struct ethhdr *eth, struct __sk_buff *skb)
 {
-	struct bpf_sock_tuple *tuple;
+	struct bpf_sock_tuple *tuple = NULL;
+	unsigned int tuple_len = 0;
 	struct bpf_sock *bpf_skc;
-	unsigned int tuple_len;
+	void *data_end, *iphdr;
+	struct ipv6hdr *ip6h;
+	struct iphdr *ip4h;
 	struct tcphdr *th;
-	void *data_end;
+	int iphdr_size;
 
 	data_end = (void *)(long)(skb->data_end);
 
-	th = (struct tcphdr *)(ip6h + 1);
-	if (th + 1 > data_end)
-		return TC_ACT_OK;
-
-	/* Is it the testing traffic? */
-	if (th->dest != srv_sa6.sin6_port)
+	switch (eth->h_proto) {
+	case bpf_htons(ETH_P_IP):
+		ip4h = (struct iphdr *)(eth + 1);
+		if (ip4h + 1 > data_end)
+			return TC_ACT_OK;
+		if (ip4h->protocol != IPPROTO_TCP)
+			return TC_ACT_OK;
+		th = (struct tcphdr *)(ip4h + 1);
+		if (th + 1 > data_end)
+			return TC_ACT_OK;
+		/* Is it the testing traffic? */
+		if (th->dest != srv_sa4.sin_port)
+			return TC_ACT_OK;
+		tuple_len = sizeof(tuple->ipv4);
+		tuple = (struct bpf_sock_tuple *)&ip4h->saddr;
+		iphdr = ip4h;
+		iphdr_size = sizeof(*ip4h);
+		break;
+	case bpf_htons(ETH_P_IPV6):
+		ip6h = (struct ipv6hdr *)(eth + 1);
+		if (ip6h + 1 > data_end)
+			return TC_ACT_OK;
+		if (ip6h->nexthdr != IPPROTO_TCP)
+			return TC_ACT_OK;
+		th = (struct tcphdr *)(ip6h + 1);
+		if (th + 1 > data_end)
+			return TC_ACT_OK;
+		/* Is it the testing traffic? */
+		if (th->dest != srv_sa6.sin6_port)
+			return TC_ACT_OK;
+		tuple_len = sizeof(tuple->ipv6);
+		tuple = (struct bpf_sock_tuple *)&ip6h->saddr;
+		iphdr = ip6h;
+		iphdr_size = sizeof(*ip6h);
+		break;
+	default:
 		return TC_ACT_OK;
+	}
 
-	tuple_len = sizeof(tuple->ipv6);
-	tuple = (struct bpf_sock_tuple *)&ip6h->saddr;
 	if ((void *)tuple + tuple_len > data_end) {
 		LOG();
 		return TC_ACT_OK;
@@ -126,7 +159,7 @@ static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
 
 		listen_tp_sport = tp->inet_conn.icsk_inet.sk.__sk_common.skc_num;
 
-		test_syncookie_helper(ip6h, th, tp, skb);
+		test_syncookie_helper(iphdr, iphdr_size, th, tp, skb);
 		bpf_sk_release(tp);
 		return TC_ACT_OK;
 	}
@@ -142,7 +175,6 @@ static int handle_ip6_tcp(struct ipv6hdr *ip6h, struct __sk_buff *skb)
 SEC("tc")
 int cls_ingress(struct __sk_buff *skb)
 {
-	struct ipv6hdr *ip6h;
 	struct ethhdr *eth;
 	void *data_end;
 
@@ -152,17 +184,11 @@ int cls_ingress(struct __sk_buff *skb)
 	if (eth + 1 > data_end)
 		return TC_ACT_OK;
 
-	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
-		return TC_ACT_OK;
-
-	ip6h = (struct ipv6hdr *)(eth + 1);
-	if (ip6h + 1 > data_end)
+	if (eth->h_proto != bpf_htons(ETH_P_IP) &&
+	    eth->h_proto != bpf_htons(ETH_P_IPV6))
 		return TC_ACT_OK;
 
-	if (ip6h->nexthdr == IPPROTO_TCP)
-		return handle_ip6_tcp(ip6h, skb);
-
-	return TC_ACT_OK;
+	return handle_ip_tcp(eth, skb);
 }
 
 char _license[] SEC("license") = "GPL";

-- 
2.47.0


