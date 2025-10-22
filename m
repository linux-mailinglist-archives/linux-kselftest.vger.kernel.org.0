Return-Path: <linux-kselftest+bounces-43740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF946BFAA03
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DE2504338
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 07:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDF42FBE19;
	Wed, 22 Oct 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AN/BRf1m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF62FB63E
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118825; cv=none; b=Pw65nwIHwA+/QvKTbz+IOcBX19+I5EbzGX8guAaTWLRFI85ZIv5BJaZHwT4EnFUZEZHQyI/TeE7Bz3E3uSvh1q6qVRR3VAeUXQ84bDf9dn81AgGeGCkyNXucLz4I+56515gjckLXe8cJc/dBnv10NUxYx2f/S7wF6JUvZxZl7zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118825; c=relaxed/simple;
	bh=rVKQOSpNXEzI6wGszsrM1qMvHuv7XN9D2gQugG+pQtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJVy1VMN7APElil6GEHv0+KdxMeOlp3vAjRP5KXYpLMup8KVBZGmMVjolHSiIxivZxWV5SI290OrILRTDUgLNZ+y8Wa8cCi+B1emtvDpVBJvjiGPwmCaRt2lP003yImhQ5MsBNA8dEF9r1gGGb738SW2UW3fkwfSKlHL1t5qtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AN/BRf1m; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4B1021A15D3;
	Wed, 22 Oct 2025 07:40:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20680606DC;
	Wed, 22 Oct 2025 07:40:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C82D4102F2429;
	Wed, 22 Oct 2025 09:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9elYQCBvjDoWqk97ClXQKLrv+rKMW91Qg0RC83oLLzQ=;
	b=AN/BRf1mBUnNsUj0e72hmsjVysTAF6CZCTPx5ApBwRzkAqVV2Wd1r/zoM0IS7Ecmr/uMSF
	trmBFm63+uM9hlrmu7m//vfYWnqM0KirdEzZw+QkXCtPt84ZuduRf3Bw2pQKeF0dTrHRKX
	560eUPdHMcJCH8vBjvSrsJYJDHYksHLBE3O2bNHpxKiYwa0ex+1EfFwONY0hZqO26jyRwV
	XNuShl0I7ulZ3Qu/IhgFLMEuNG0ok3C0KIGlivb5zIydDDueFFVtCvWHePruku/oH70Vpf
	tguwH+VAK6KuEo+zYFMQHBWi+Q8CzVkA/ykyoYtCE3hlLc4nkKkbp7P5YZOx/g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 22 Oct 2025 09:39:50 +0200
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: add tc helpers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-tc_tunnel-v2-1-a44a0bd52902@bootlin.com>
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
In-Reply-To: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
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
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The test_tunnel.c file defines small fonctions to easily attach eBPF
programs to tc hooks, either on egress, ingress or both.

Create a shared helper in network_helpers.c so that other tests can
benefit from it.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- declare new TC API in network_helpers instead of a dedicated file
- only declare tc_prog_attach, not the intermediate
  "generic_attachigr_fd/egr_fd
- pass an interface name rather than an interface id
- update accordingly test_tunnel.c
---
 tools/testing/selftests/bpf/network_helpers.c      |  45 +++++++++
 tools/testing/selftests/bpf/network_helpers.h      |  16 +++
 .../testing/selftests/bpf/prog_tests/test_tunnel.c | 107 +++------------------
 3 files changed, 75 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index cdf7b6641444..0998d71fe57a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -766,6 +766,51 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 	return err;
 }
 
+int tc_prog_attach(const char *dev, int ingress_fd, int egress_fd)
+{
+	int ifindex;
+
+	if (!ASSERT_TRUE(ingress_fd >= 0 || egress_fd >= 0,
+			 "at least one program fd is valid"))
+		return -1;
+
+	ifindex = if_nametoindex(dev);
+	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
+		return -1;
+
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
+			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
+			    .priority = 1, .prog_fd = ingress_fd);
+	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
+			    .priority = 1, .prog_fd = egress_fd);
+	int ret;
+
+	ret = bpf_tc_hook_create(&hook);
+	if (!ASSERT_OK(ret, "create tc hook"))
+		return ret;
+
+	if (ingress_fd >= 0) {
+		hook.attach_point = BPF_TC_INGRESS;
+		ret = bpf_tc_attach(&hook, &opts1);
+		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
+			bpf_tc_hook_destroy(&hook);
+			return ret;
+		}
+	}
+
+	if (egress_fd >= 0) {
+		hook.attach_point = BPF_TC_EGRESS;
+		ret = bpf_tc_attach(&hook, &opts2);
+		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
+			bpf_tc_hook_destroy(&hook);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 #ifdef TRAFFIC_MONITOR
 struct tmonitor_ctx {
 	pcap_t *pcap;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index ef208eefd571..79a010c88e11 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -255,6 +255,22 @@ struct tmonitor_ctx;
 
 typedef int (*tm_print_fn_t)(const char *format, va_list args);
 
+/**
+ * tc_prog_attach - attach BPF program(s) to an interface
+ *
+ * Takes file descriptors pointing to at least one, at most two BPF
+ * programs, and attach those programs to an interface ingress, egress or
+ * both.
+ *
+ * @dev: string containing the interface name
+ * @ingress_fd: file descriptor of the program to attach to interface ingress
+ * @egress_fd: file descriptor of the program to attach to interface egress
+ *
+ * Returns 0 on success, -1 if no valid file descriptor has been found, if
+ * the interface name is invalid or if an error ocurred during attach.
+ */
+int tc_prog_attach(const char *dev, int ingress_fd, int egress_fd);
+
 #ifdef TRAFFIC_MONITOR
 struct tmonitor_ctx *traffic_monitor_start(const char *netns, const char *test_name,
 					   const char *subtest_name);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index bae0e9de277d..eb9309931272 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -534,85 +534,6 @@ static void ping6_dev1(void)
 	close_netns(nstoken);
 }
 
-static int attach_tc_prog(int ifindex, int igr_fd, int egr_fd)
-{
-	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = ifindex,
-			    .attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS);
-	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts1, .handle = 1,
-			    .priority = 1, .prog_fd = igr_fd);
-	DECLARE_LIBBPF_OPTS(bpf_tc_opts, opts2, .handle = 1,
-			    .priority = 1, .prog_fd = egr_fd);
-	int ret;
-
-	ret = bpf_tc_hook_create(&hook);
-	if (!ASSERT_OK(ret, "create tc hook"))
-		return ret;
-
-	if (igr_fd >= 0) {
-		hook.attach_point = BPF_TC_INGRESS;
-		ret = bpf_tc_attach(&hook, &opts1);
-		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(&hook);
-			return ret;
-		}
-	}
-
-	if (egr_fd >= 0) {
-		hook.attach_point = BPF_TC_EGRESS;
-		ret = bpf_tc_attach(&hook, &opts2);
-		if (!ASSERT_OK(ret, "bpf_tc_attach")) {
-			bpf_tc_hook_destroy(&hook);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int generic_attach(const char *dev, int igr_fd, int egr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
-		return -1;
-	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, igr_fd, egr_fd);
-}
-
-static int generic_attach_igr(const char *dev, int igr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(igr_fd, "check ingress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, igr_fd, -1);
-}
-
-static int generic_attach_egr(const char *dev, int egr_fd)
-{
-	int ifindex;
-
-	if (!ASSERT_OK_FD(egr_fd, "check egress fd"))
-		return -1;
-
-	ifindex = if_nametoindex(dev);
-	if (!ASSERT_NEQ(ifindex, 0, "get ifindex"))
-		return -1;
-
-	return attach_tc_prog(ifindex, -1, egr_fd);
-}
-
 static void test_vxlan_tunnel(void)
 {
 	struct test_tunnel_kern *skel = NULL;
@@ -635,12 +556,12 @@ static void test_vxlan_tunnel(void)
 		goto done;
 	get_src_prog_fd = bpf_program__fd(skel->progs.vxlan_get_tunnel_src);
 	set_src_prog_fd = bpf_program__fd(skel->progs.vxlan_set_tunnel_src);
-	if (generic_attach(VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
+	if (tc_prog_attach(VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	/* load and attach bpf prog to veth dev tc hook point */
 	set_dst_prog_fd = bpf_program__fd(skel->progs.veth_set_outer_dst);
-	if (generic_attach_igr("veth1", set_dst_prog_fd))
+	if (tc_prog_attach("veth1", set_dst_prog_fd, -1))
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
@@ -648,7 +569,7 @@ static void test_vxlan_tunnel(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.vxlan_set_tunnel_dst);
-	if (generic_attach_egr(VXLAN_TUNL_DEV0, set_dst_prog_fd))
+	if (tc_prog_attach(VXLAN_TUNL_DEV0, -1, set_dst_prog_fd))
 		goto done;
 	close_netns(nstoken);
 
@@ -695,7 +616,7 @@ static void test_ip6vxlan_tunnel(void)
 		goto done;
 	get_src_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_get_tunnel_src);
 	set_src_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_set_tunnel_src);
-	if (generic_attach(IP6VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
+	if (tc_prog_attach(IP6VXLAN_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	/* load and attach prog set_md to tunnel dev tc hook point at_ns0 */
@@ -703,7 +624,7 @@ static void test_ip6vxlan_tunnel(void)
 	if (!ASSERT_OK_PTR(nstoken, "setns src"))
 		goto done;
 	set_dst_prog_fd = bpf_program__fd(skel->progs.ip6vxlan_set_tunnel_dst);
-	if (generic_attach_egr(IP6VXLAN_TUNL_DEV0, set_dst_prog_fd))
+	if (tc_prog_attach(IP6VXLAN_TUNL_DEV0, -1, set_dst_prog_fd))
 		goto done;
 	close_netns(nstoken);
 
@@ -764,7 +685,7 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 			skel->progs.ipip_set_tunnel);
 	}
 
-	if (generic_attach(IPIP_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
+	if (tc_prog_attach(IPIP_TUNL_DEV1, get_src_prog_fd, set_src_prog_fd))
 		goto done;
 
 	ping_dev0();
@@ -797,7 +718,7 @@ static void test_xfrm_tunnel(void)
 
 	/* attach tc prog to tunnel dev */
 	tc_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state);
-	if (generic_attach_igr("veth1", tc_prog_fd))
+	if (tc_prog_attach("veth1", tc_prog_fd, -1))
 		goto done;
 
 	/* attach xdp prog to tunnel dev */
@@ -870,7 +791,7 @@ static void test_gre_tunnel(enum gre_test test)
 	if (!ASSERT_OK(err, "add tunnel"))
 		goto done;
 
-	if (generic_attach(GRE_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(GRE_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping_dev0();
@@ -911,7 +832,7 @@ static void test_ip6gre_tunnel(enum ip6gre_test test)
 
 	set_fd = bpf_program__fd(skel->progs.ip6gretap_set_tunnel);
 	get_fd = bpf_program__fd(skel->progs.ip6gretap_get_tunnel);
-	if (generic_attach(IP6GRE_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(IP6GRE_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping6_veth0();
@@ -954,7 +875,7 @@ static void test_erspan_tunnel(enum erspan_test test)
 
 	set_fd = bpf_program__fd(skel->progs.erspan_set_tunnel);
 	get_fd = bpf_program__fd(skel->progs.erspan_get_tunnel);
-	if (generic_attach(ERSPAN_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(ERSPAN_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping_dev0();
@@ -990,7 +911,7 @@ static void test_ip6erspan_tunnel(enum erspan_test test)
 
 	set_fd = bpf_program__fd(skel->progs.ip4ip6erspan_set_tunnel);
 	get_fd = bpf_program__fd(skel->progs.ip4ip6erspan_get_tunnel);
-	if (generic_attach(IP6ERSPAN_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(IP6ERSPAN_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping6_veth0();
@@ -1017,7 +938,7 @@ static void test_geneve_tunnel(void)
 
 	set_fd = bpf_program__fd(skel->progs.geneve_set_tunnel);
 	get_fd = bpf_program__fd(skel->progs.geneve_get_tunnel);
-	if (generic_attach(GENEVE_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(GENEVE_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping_dev0();
@@ -1044,7 +965,7 @@ static void test_ip6geneve_tunnel(void)
 
 	set_fd = bpf_program__fd(skel->progs.ip6geneve_set_tunnel);
 	get_fd = bpf_program__fd(skel->progs.ip6geneve_get_tunnel);
-	if (generic_attach(IP6GENEVE_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(IP6GENEVE_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping_dev0();
@@ -1083,7 +1004,7 @@ static void test_ip6tnl_tunnel(enum ip6tnl_test test)
 		get_fd = bpf_program__fd(skel->progs.ip6ip6_get_tunnel);
 		break;
 	}
-	if (generic_attach(IP6TNL_TUNL_DEV1, get_fd, set_fd))
+	if (tc_prog_attach(IP6TNL_TUNL_DEV1, get_fd, set_fd))
 		goto done;
 
 	ping6_veth0();

-- 
2.51.1.dirty


