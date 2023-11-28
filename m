Return-Path: <linux-kselftest+bounces-734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C77FC0BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1BB281C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BC5E0C1;
	Tue, 28 Nov 2023 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="OiPNctlF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G2xJKR8d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100219BF;
	Tue, 28 Nov 2023 09:54:59 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 47ABD580888;
	Tue, 28 Nov 2023 12:54:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701194099; x=
	1701201299; bh=p3Zw5us8kLbs917T8ED3SksOTsKj9Ybct50Y5ylH7VI=; b=O
	iPNctlFLoFjjFN47WMhDTgDSxNOt47DUc3qBaCODKGjcRbJcrSobsLvnMXi6RIg6
	31SUwWaLMqVC8FbAlO8kJ2T6rp9Jgkyh+mEqlqxcWhUDOq2ZmcpV6nEEUNGreQ2k
	5tbrOsNAL6yks9q+jE1+SMqeMrv9Usi/HGP33GM9LuMaiFOsgLGLVRcWwjtuxRSF
	RAUwqrhGJVwIWiCLB5P67PxlNomE96QKTqu30hwqVUAHCivpAlPxdVJE3XWRWiVa
	6z0VfEaV4BmzId1MCBXSxlP2Ih93w2KYrMRD/XFvtGTrv4e1XVAjgQQIBuP844yL
	M3LbA3xOrt2oXk2Ha6u+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701194099; x=
	1701201299; bh=p3Zw5us8kLbs917T8ED3SksOTsKj9Ybct50Y5ylH7VI=; b=G
	2xJKR8d9XdE+kVX2kAvm7Q9QEECRIiZpdGpUnDxeo9XxKq5wE4TF4fFa9mXOu6nI
	7wAistolLkjwxez9rC5FCbC8SIXKbl518P68UoW2jC7F67WS0dE7wL57sJYKAB9J
	/wub5UfyjIQ2JIQLq94DevW8EqFPpYdFZhQHgDTytTh0pbP0O8hFl0iaj7Wuk6gn
	FOyEo2btTAKz0AAj0VWhgeLbW3Ij/X6r2QyDOYIat+teOgixJwrbA6ljbE0fZeK2
	0fsUNBsXQdZRDkc7BLIq5XgkDC7TwQIUoYHWD8khKQYRlvcqomTtFRomEm9S5jJh
	hTwoUvMiojrlQQu9EUtyQ==
X-ME-Sender: <xms:cylmZQCRmXjB0j_-5WVUidgiRJeqCFgH-IwGM_wJffC9RCj8Y0w2IQ>
    <xme:cylmZSjZnkXChfKsQmK8J_UFI7tqEVvvDRRjqQPgtQk4eLT_JeCImoke1R3E1vdCs
    0klRlgB3RwC73dX4g>
X-ME-Received: <xmr:cylmZTm-_DNju_dtawmfowxC2hcTdZ_osEZdZZlG8UKHpriQemesNvQITRg5b04XaW7oD2JZ3T0RdyAadMsKdpuui-RA9BC3CGabYirQxMEk7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:cylmZWyg80RSNbJ_6nwvhCwVF3hb5zGW5QKNU4fCkEp_DfmBio9PYA>
    <xmx:cylmZVQasAWCbrEflN87KNhYmEriMTd2qIcHsDbjCptB34I1UIj1ww>
    <xmx:cylmZRZK-UHKyGPU88lkYRyujArUsSCxnqSYWfA-xZLVuOQUAkFZxw>
    <xmx:cylmZWS7FczryJ16jTP8TJpOtNe8c3BXGMVAjWjUiFjr1Qdy2QzNYA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:57 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH ipsec-next v2 5/6] bpf: selftests: Move xfrm tunnel test to test_progs
Date: Tue, 28 Nov 2023 10:54:25 -0700
Message-ID: <6b06fc7b453a7296c5177d3002b974166b80b043.1701193577.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701193577.git.dxu@dxuuu.xyz>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_progs is better than a shell script b/c C is a bit easier to
maintain than shell. Also it's easier to use new infra like memory
mapped global variables from C via bpf skeleton.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 143 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    |  11 +-
 tools/testing/selftests/bpf/test_tunnel.sh    |  92 -----------
 3 files changed, 151 insertions(+), 95 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index d149ab98798d..3bcb6f96b9b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -50,6 +50,7 @@
  */
 
 #include <arpa/inet.h>
+#include <linux/if_link.h>
 #include <linux/if_tun.h>
 #include <linux/limits.h>
 #include <linux/sysctl.h>
@@ -92,6 +93,11 @@
 #define IPIP_TUNL_DEV0 "ipip00"
 #define IPIP_TUNL_DEV1 "ipip11"
 
+#define XFRM_AUTH "0x1111111111111111111111111111111111111111"
+#define XFRM_ENC "0x22222222222222222222222222222222"
+#define XFRM_SPI_IN_TO_OUT 0x1
+#define XFRM_SPI_OUT_TO_IN 0x2
+
 #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
 
 static int config_device(void)
@@ -264,6 +270,92 @@ static void delete_ipip_tunnel(void)
 	SYS_NOFAIL("ip fou del port 5555 2> /dev/null");
 }
 
+static int add_xfrm_tunnel(void)
+{
+	/* at_ns0 namespace
+	 * at_ns0 -> root
+	 */
+	SYS(fail,
+	    "ip netns exec at_ns0 "
+		"ip xfrm state add src %s dst %s proto esp "
+			"spi %d reqid 1 mode tunnel "
+			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
+	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
+	SYS(fail,
+	    "ip netns exec at_ns0 "
+		"ip xfrm policy add src %s/32 dst %s/32 dir out "
+			"tmpl src %s dst %s proto esp reqid 1 "
+			"mode tunnel",
+	    IP4_ADDR_TUNL_DEV0, IP4_ADDR_TUNL_DEV1, IP4_ADDR_VETH0, IP4_ADDR1_VETH1);
+
+	/* root -> at_ns0 */
+	SYS(fail,
+	    "ip netns exec at_ns0 "
+		"ip xfrm state add src %s dst %s proto esp "
+			"spi %d reqid 2 mode tunnel "
+			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
+	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
+	SYS(fail,
+	    "ip netns exec at_ns0 "
+		"ip xfrm policy add src %s/32 dst %s/32 dir in "
+			"tmpl src %s dst %s proto esp reqid 2 "
+			"mode tunnel",
+	    IP4_ADDR_TUNL_DEV1, IP4_ADDR_TUNL_DEV0, IP4_ADDR1_VETH1, IP4_ADDR_VETH0);
+
+	/* address & route */
+	SYS(fail, "ip netns exec at_ns0 ip addr add dev veth0 %s/32",
+	    IP4_ADDR_TUNL_DEV0);
+	SYS(fail, "ip netns exec at_ns0 ip route add %s dev veth0 via %s src %s",
+	    IP4_ADDR_TUNL_DEV1, IP4_ADDR1_VETH1, IP4_ADDR_TUNL_DEV0);
+
+	/* root namespace
+	 * at_ns0 -> root
+	 */
+	SYS(fail,
+	    "ip xfrm state add src %s dst %s proto esp "
+		    "spi %d reqid 1 mode tunnel "
+		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
+	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
+	SYS(fail,
+	    "ip xfrm policy add src %s/32 dst %s/32 dir in "
+		    "tmpl src %s dst %s proto esp reqid 1 "
+		    "mode tunnel",
+	    IP4_ADDR_TUNL_DEV0, IP4_ADDR_TUNL_DEV1, IP4_ADDR_VETH0, IP4_ADDR1_VETH1);
+
+	/* root -> at_ns0 */
+	SYS(fail,
+	    "ip xfrm state add src %s dst %s proto esp "
+		    "spi %d reqid 2 mode tunnel "
+		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
+	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
+	SYS(fail,
+	    "ip xfrm policy add src %s/32 dst %s/32 dir out "
+		    "tmpl src %s dst %s proto esp reqid 2 "
+		    "mode tunnel",
+	    IP4_ADDR_TUNL_DEV1, IP4_ADDR_TUNL_DEV0, IP4_ADDR1_VETH1, IP4_ADDR_VETH0);
+
+	/* address & route */
+	SYS(fail, "ip addr add dev veth1 %s/32", IP4_ADDR_TUNL_DEV1);
+	SYS(fail, "ip route add %s dev veth1 via %s src %s",
+	    IP4_ADDR_TUNL_DEV0, IP4_ADDR_VETH0, IP4_ADDR_TUNL_DEV1);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static void delete_xfrm_tunnel(void)
+{
+	SYS_NOFAIL("ip xfrm policy delete dir out src %s/32 dst %s/32 2> /dev/null",
+		   IP4_ADDR_TUNL_DEV1, IP4_ADDR_TUNL_DEV0);
+	SYS_NOFAIL("ip xfrm policy delete dir in src %s/32 dst %s/32 2> /dev/null",
+		   IP4_ADDR_TUNL_DEV0, IP4_ADDR_TUNL_DEV1);
+	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d 2> /dev/null",
+		   IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT);
+	SYS_NOFAIL("ip xfrm state delete src %s dst %s proto esp spi %d 2> /dev/null",
+		   IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN);
+}
+
 static int test_ping(int family, const char *addr)
 {
 	SYS(fail, "%s %s %s > /dev/null", ping_command(family), PING_ARGS, addr);
@@ -532,6 +624,56 @@ static void test_ipip_tunnel(enum ipip_encap encap)
 		test_tunnel_kern__destroy(skel);
 }
 
+static void test_xfrm_tunnel(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
+			    .attach_point = BPF_TC_INGRESS);
+	struct test_tunnel_kern *skel = NULL;
+	struct nstoken *nstoken;
+	int tc_prog_fd;
+	int ifindex;
+	int err;
+
+	err = add_xfrm_tunnel();
+	if (!ASSERT_OK(err, "add_xfrm_tunnel"))
+		return;
+
+	skel = test_tunnel_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_tunnel_kern__open_and_load"))
+		goto done;
+
+	ifindex = if_nametoindex("veth1");
+	if (!ASSERT_NEQ(ifindex, 0, "veth1 ifindex"))
+		goto done;
+
+	/* attach tc prog to tunnel dev */
+	tc_hook.ifindex = ifindex;
+	tc_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state);
+	if (!ASSERT_GE(tc_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
+		goto done;
+
+	/* ping from at_ns0 namespace test */
+	nstoken = open_netns("at_ns0");
+	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
+	close_netns(nstoken);
+	if (!ASSERT_OK(err, "test_ping"))
+		goto done;
+
+	if (!ASSERT_EQ(skel->bss->xfrm_reqid, 1, "req_id"))
+		goto done;
+	if (!ASSERT_EQ(skel->bss->xfrm_spi, XFRM_SPI_IN_TO_OUT, "spi"))
+		goto done;
+	if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
+		goto done;
+
+done:
+	delete_xfrm_tunnel();
+	if (skel)
+		test_tunnel_kern__destroy(skel);
+}
+
 #define RUN_TEST(name, ...)						\
 	({								\
 		if (test__start_subtest(#name)) {			\
@@ -549,6 +691,7 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ipip_tunnel, NONE);
 	RUN_TEST(ipip_tunnel, FOU);
 	RUN_TEST(ipip_tunnel, GUE);
+	RUN_TEST(xfrm_tunnel);
 
 	cleanup();
 
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index b320fb7bb080..3a59eb9c34de 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -929,6 +929,10 @@ int ip6ip6_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+volatile int xfrm_reqid = 0;
+volatile int xfrm_spi = 0;
+volatile int xfrm_remote_ip = 0;
+
 SEC("tc")
 int xfrm_get_state(struct __sk_buff *skb)
 {
@@ -939,9 +943,10 @@ int xfrm_get_state(struct __sk_buff *skb)
 	if (ret < 0)
 		return TC_ACT_OK;
 
-	bpf_printk("reqid %d spi 0x%x remote ip 0x%x\n",
-		   x.reqid, bpf_ntohl(x.spi),
-		   bpf_ntohl(x.remote_ipv4));
+	xfrm_reqid = x.reqid;
+	xfrm_spi = bpf_ntohl(x.spi);
+	xfrm_remote_ip = bpf_ntohl(x.remote_ipv4);
+
 	return TC_ACT_OK;
 }
 
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2dec7dbf29a2..d9661b9988ba 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -517,90 +517,6 @@ test_ip6ip6()
         echo -e ${GREEN}"PASS: ip6$TYPE"${NC}
 }
 
-setup_xfrm_tunnel()
-{
-	auth=0x$(printf '1%.0s' {1..40})
-	enc=0x$(printf '2%.0s' {1..32})
-	spi_in_to_out=0x1
-	spi_out_to_in=0x2
-	# at_ns0 namespace
-	# at_ns0 -> root
-	ip netns exec at_ns0 \
-		ip xfrm state add src 172.16.1.100 dst 172.16.1.200 proto esp \
-			spi $spi_in_to_out reqid 1 mode tunnel \
-			auth-trunc 'hmac(sha1)' $auth 96 enc 'cbc(aes)' $enc
-	ip netns exec at_ns0 \
-		ip xfrm policy add src 10.1.1.100/32 dst 10.1.1.200/32 dir out \
-		tmpl src 172.16.1.100 dst 172.16.1.200 proto esp reqid 1 \
-		mode tunnel
-	# root -> at_ns0
-	ip netns exec at_ns0 \
-		ip xfrm state add src 172.16.1.200 dst 172.16.1.100 proto esp \
-			spi $spi_out_to_in reqid 2 mode tunnel \
-			auth-trunc 'hmac(sha1)' $auth 96 enc 'cbc(aes)' $enc
-	ip netns exec at_ns0 \
-		ip xfrm policy add src 10.1.1.200/32 dst 10.1.1.100/32 dir in \
-		tmpl src 172.16.1.200 dst 172.16.1.100 proto esp reqid 2 \
-		mode tunnel
-	# address & route
-	ip netns exec at_ns0 \
-		ip addr add dev veth0 10.1.1.100/32
-	ip netns exec at_ns0 \
-		ip route add 10.1.1.200 dev veth0 via 172.16.1.200 \
-			src 10.1.1.100
-
-	# root namespace
-	# at_ns0 -> root
-	ip xfrm state add src 172.16.1.100 dst 172.16.1.200 proto esp \
-		spi $spi_in_to_out reqid 1 mode tunnel \
-		auth-trunc 'hmac(sha1)' $auth 96  enc 'cbc(aes)' $enc
-	ip xfrm policy add src 10.1.1.100/32 dst 10.1.1.200/32 dir in \
-		tmpl src 172.16.1.100 dst 172.16.1.200 proto esp reqid 1 \
-		mode tunnel
-	# root -> at_ns0
-	ip xfrm state add src 172.16.1.200 dst 172.16.1.100 proto esp \
-		spi $spi_out_to_in reqid 2 mode tunnel \
-		auth-trunc 'hmac(sha1)' $auth 96  enc 'cbc(aes)' $enc
-	ip xfrm policy add src 10.1.1.200/32 dst 10.1.1.100/32 dir out \
-		tmpl src 172.16.1.200 dst 172.16.1.100 proto esp reqid 2 \
-		mode tunnel
-	# address & route
-	ip addr add dev veth1 10.1.1.200/32
-	ip route add 10.1.1.100 dev veth1 via 172.16.1.100 src 10.1.1.200
-}
-
-test_xfrm_tunnel()
-{
-	if [[ -e /sys/kernel/tracing/trace ]]; then
-		TRACE=/sys/kernel/tracing/trace
-	else
-		TRACE=/sys/kernel/debug/tracing/trace
-	fi
-	config_device
-	> ${TRACE}
-	setup_xfrm_tunnel
-	mkdir -p ${BPF_PIN_TUNNEL_DIR}
-	bpftool prog loadall ${BPF_FILE} ${BPF_PIN_TUNNEL_DIR}
-	tc qdisc add dev veth1 clsact
-	tc filter add dev veth1 proto ip ingress bpf da object-pinned \
-		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
-	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
-	sleep 1
-	grep "reqid 1" ${TRACE}
-	check_err $?
-	grep "spi 0x1" ${TRACE}
-	check_err $?
-	grep "remote ip 0xac100164" ${TRACE}
-	check_err $?
-	cleanup
-
-	if [ $ret -ne 0 ]; then
-		echo -e ${RED}"FAIL: xfrm tunnel"${NC}
-		return 1
-	fi
-	echo -e ${GREEN}"PASS: xfrm tunnel"${NC}
-}
-
 attach_bpf()
 {
 	DEV=$1
@@ -630,10 +546,6 @@ cleanup()
 	ip link del ip6geneve11 2> /dev/null
 	ip link del erspan11 2> /dev/null
 	ip link del ip6erspan11 2> /dev/null
-	ip xfrm policy delete dir out src 10.1.1.200/32 dst 10.1.1.100/32 2> /dev/null
-	ip xfrm policy delete dir in src 10.1.1.100/32 dst 10.1.1.200/32 2> /dev/null
-	ip xfrm state delete src 172.16.1.100 dst 172.16.1.200 proto esp spi 0x1 2> /dev/null
-	ip xfrm state delete src 172.16.1.200 dst 172.16.1.100 proto esp spi 0x2 2> /dev/null
 }
 
 cleanup_exit()
@@ -716,10 +628,6 @@ bpf_tunnel_test()
 	test_ip6ip6
 	errors=$(( $errors + $? ))
 
-	echo "Testing IPSec tunnel..."
-	test_xfrm_tunnel
-	errors=$(( $errors + $? ))
-
 	return $errors
 }
 
-- 
2.42.1


