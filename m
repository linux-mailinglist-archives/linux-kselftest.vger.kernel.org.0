Return-Path: <linux-kselftest+bounces-1613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797480DB80
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1BD1C214E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 20:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BD53E32;
	Mon, 11 Dec 2023 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="M5PeZ20L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igPTxt/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CD10E;
	Mon, 11 Dec 2023 12:20:48 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 17D4E580960;
	Mon, 11 Dec 2023 15:20:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 15:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1702326047; x=
	1702333247; bh=iEPiwxbzI+8Wn+djijAMA+bYTHUszD/cas2J+llupPk=; b=M
	5PeZ20LG3SleFhRdWNAeoSzyMDkyrCMBB/0g6gPitrSydb264IRw2SdV2leWZDet
	1RQGPdxAq2jgmfoIT5L720OzA4gBhl2idXWArZrCrFF2yRfK1+QYEBf+wei1Ayhl
	f+k6gs/N84Kmldtxdn6Woh7b+mGm4caG1HSzIpU+LMHQ/iSUHBYfJ9RfWg9hBdiz
	i1l8Laa0Z3fIDnkQvv+8RkBWzoi/BTBFQSDb97zSsFzORgnW222RCb8GM/H95nrJ
	FxMqrkKwd147eQaOQ6is48CMSUlTaQDO7voW2j6KFuvj1u6GRrsjtBBJDkbXE+1t
	ecM18slHmS7MI7hQlQDrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702326047; x=
	1702333247; bh=iEPiwxbzI+8Wn+djijAMA+bYTHUszD/cas2J+llupPk=; b=i
	gPTxt/AoamQeAL2hFQuzh1WIWhq9mZQGd4qC0j7VTH6gscSRO+OK1V4b/R6dpgxW
	JmUM9eDGbLSjZUHPTR0ApMEp7Fxqa2hhY/WwjJk54SlTYomA82NSywcBOXBqTU2Z
	KNHXdXd3n/C2lUFlgTGyrghSEKRm8FdBUSf71ZWYv81f0Wz3Xer/uVd6ElPBT4Dk
	PfF5ZA2S/W4wVXnyev22qfKrLu1jkWS1XB1lTBr268MjZn1WPkWN6NTJxx+QgRUO
	jaffocRzornpoOhb/8cts7WxzlpF8heCWW+agPs5e97AMvcgTSrOpZQg1efl2W/J
	ezVZ3/jl8itVxQf7JOKfQ==
X-ME-Sender: <xms:Hm93ZXu32ilY-fsl36JnJ_BaxaU1_WpgDdHg0wIjgHSjYEvScyOLdA>
    <xme:Hm93ZYe9UmokBGz1hHDf7kCaM_k2JQfqqf3TTnIles8bpJnnrq9ShGoKfoqWa5e0h
    yMpom_3ZpzD_AS2BA>
X-ME-Received: <xmr:Hm93ZaxUVl08VDGrPkv9IAUf1EkW9SFt-8A02QRMjNbqBaiDwpOO_slllKZeSsnk6EI91wb0ANpSbXAPqB9_t-vJALTHEA8Bp8OArt8cxRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Hm93ZWMBSMl_4mNNni1hqocgaQHIs3AiAS5RBFyP00L4oyQdFu0vZg>
    <xmx:Hm93ZX9Nb8I5gKb-UKPfacqkBQ7Ur0p64LdpsDcPZZNHg4ydvAb9Rg>
    <xmx:Hm93ZWW1_tz_aK0beRfC5m-izK9k_lyb1ctoJxCjKALinnqjyGLcSw>
    <xmx:H293ZRlUKQXQzJozTgi46RkYBd15MhkWiHxl5_wAptHyT_SpZfaxlQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 15:20:45 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devel@linux-ipsec.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v5 8/9] bpf: selftests: Move xfrm tunnel test to test_progs
Date: Mon, 11 Dec 2023 13:20:12 -0700
Message-ID: <95f0ccc4fb644071cf8cf101e3d2bf554dbb26b4.1702325874.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702325874.git.dxu@dxuuu.xyz>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
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
index b57d48219d0b..2d7f8fa82ebd 100644
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
@@ -548,6 +690,7 @@ static void *test_tunnel_run_tests(void *arg)
 	RUN_TEST(ipip_tunnel, NONE);
 	RUN_TEST(ipip_tunnel, FOU);
 	RUN_TEST(ipip_tunnel, GUE);
+	RUN_TEST(xfrm_tunnel);
 
 	return NULL;
 }
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


