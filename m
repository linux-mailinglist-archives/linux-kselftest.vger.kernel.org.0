Return-Path: <linux-kselftest+bounces-985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA2801466
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 21:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71684281CA9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 20:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D715A0FD;
	Fri,  1 Dec 2023 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="kPnplShX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gmf0ih1R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B010FE;
	Fri,  1 Dec 2023 12:24:09 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.nyi.internal (Postfix) with ESMTP id B685158098F;
	Fri,  1 Dec 2023 15:24:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 01 Dec 2023 15:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701462248; x=
	1701469448; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=k
	PnplShXeoT/pLs3XBMWJwo4uneVlKesk6vw4jj8pei7V3UtxTbHmyS1f8zTH0qJ3
	sxtxRwHn6SXidwOX2VyjuJ91Pqf1oFSLC9eYuMSni1iVlQV6L5Kt52kVmF9yEh0A
	2p49AyghvFmF7Lo1aBmr8CCkzfkmmG0kj7vOwqRGA/5qUq4o+PtL5g5FB5PqtCxw
	200Ig0vKOOWd4jHEozsqfKUbdfeZlESZTVMiNQLKGxKKNlgTNJZueDHP4HcszN/b
	XcMv3JLc0/QpOEoA/A8iMlor9ed286mzXeCByhkA79B72bIE2D/tqOl/DB73Dbnl
	A251/+kKFZCBk6srZSLUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701462248; x=
	1701469448; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=G
	mf0ih1R80LIGpElB8YeIy29SrRg551bE3NZHwJpg08xOHhwjY0hRmPmuc7Ewk8yv
	TirWmxJc3MfwIgLVKWlKSbpJevk98lwBNEa3C6rFMbdrqT0KlSbh3Z4y3ImmHEbp
	Dr4jlH1MiptBIJBWdjetpzvvRm0YPIoHCIdlFr3H31ffYsUB4Pqp5iQfqVuAh3RC
	zSh8AWSK/uSjp8xlvuTM1Uu7sPT5ELhQVBQphytYPJzNswaVZSHQEhiTbNh1yiG7
	JXSo3ms7jGplM4P/7edBuKnS6+fgxmMyq1SIl13jVTtS94HkA1iWVI1LHJ85XnAg
	frysoQcuCkFyWT0kdFICg==
X-ME-Sender: <xms:6EBqZX9XHirbtF9BLWkBBsGihcY8bp0-mueWOaGgjbYDQZx183B72A>
    <xme:6EBqZTt3kURm3k9TnHWl55uIT9WQUNFK25eWajxZ1oDzUUe5B_2FOBoBHcFCiStQt
    D4MdQ7_-tIoYQL16w>
X-ME-Received: <xmr:6EBqZVAe0-52IwK1P_moZi2LB2HSwO3QcZLJ3BY_7BxrAC4zu8sWj1_rTEkJvGaxf6Rh2m1db1eBQ78arpV6rL2T9LHc7-9pKw9iT0wpmzloew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:6EBqZTc0w_MsVG5ivQ7AK92ii9QMpCpXvU23R3XYtrug0Wk87YjYjg>
    <xmx:6EBqZcNp_jvjdp1vzhsMQDQtXLcH9KJszrqnk6vmK5nZNdM-D_RV8g>
    <xmx:6EBqZVnWAjm8FFlGr67OvKvhRqtmGA8agybITikuXqFbEapnkGJf-Q>
    <xmx:6EBqZbOgAd_EPsf5HBEbSI6Y_4-yhGaEj2w9ZThNCf_swbMgHO_Arg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:24:06 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	daniel@iogearbox.net,
	shuah@kernel.org,
	kuba@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	andrii@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH ipsec-next v3 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Fri,  1 Dec 2023 13:23:20 -0700
Message-ID: <b315b0ffa7cc8f96e30b0c2b0b1feae99e2fbc4a.1701462010.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit extends test_tunnel selftest to test the new XDP xfrm state
lookup kfunc.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 20 ++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 2d7f8fa82ebd..fc804095d578 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
@@ -278,7 +278,7 @@ static int add_xfrm_tunnel(void)
 	SYS(fail,
 	    "ip netns exec at_ns0 "
 		"ip xfrm state add src %s dst %s proto esp "
-			"spi %d reqid 1 mode tunnel "
+			"spi %d reqid 1 mode tunnel replay-window 42 "
 			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
 	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -292,7 +292,7 @@ static int add_xfrm_tunnel(void)
 	SYS(fail,
 	    "ip netns exec at_ns0 "
 		"ip xfrm state add src %s dst %s proto esp "
-			"spi %d reqid 2 mode tunnel "
+			"spi %d reqid 2 mode tunnel replay-window 42 "
 			"auth-trunc 'hmac(sha1)' %s 96 enc 'cbc(aes)' %s",
 	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
 	 */
 	SYS(fail,
 	    "ip xfrm state add src %s dst %s proto esp "
-		    "spi %d reqid 1 mode tunnel "
+		    "spi %d reqid 1 mode tunnel replay-window 42 "
 		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
 	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -325,7 +325,7 @@ static int add_xfrm_tunnel(void)
 	/* root -> at_ns0 */
 	SYS(fail,
 	    "ip xfrm state add src %s dst %s proto esp "
-		    "spi %d reqid 2 mode tunnel "
+		    "spi %d reqid 2 mode tunnel replay-window 42 "
 		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
 	    IP4_ADDR1_VETH1, IP4_ADDR_VETH0, XFRM_SPI_OUT_TO_IN, XFRM_AUTH, XFRM_ENC);
 	SYS(fail,
@@ -628,8 +628,10 @@ static void test_xfrm_tunnel(void)
 {
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
 			    .attach_point = BPF_TC_INGRESS);
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
 	struct test_tunnel_kern *skel = NULL;
 	struct nstoken *nstoken;
+	int xdp_prog_fd;
 	int tc_prog_fd;
 	int ifindex;
 	int err;
@@ -654,6 +656,14 @@ static void test_xfrm_tunnel(void)
 	if (attach_tc_prog(&tc_hook, tc_prog_fd, -1))
 		goto done;
 
+	/* attach xdp prog to tunnel dev */
+	xdp_prog_fd = bpf_program__fd(skel->progs.xfrm_get_state_xdp);
+	if (!ASSERT_GE(xdp_prog_fd, 0, "bpf_program__fd"))
+		goto done;
+	err = bpf_xdp_attach(ifindex, xdp_prog_fd, XDP_FLAGS_REPLACE, &opts);
+	if (!ASSERT_OK(err, "bpf_xdp_attach"))
+		goto done;
+
 	/* ping from at_ns0 namespace test */
 	nstoken = open_netns("at_ns0");
 	err = test_ping(AF_INET, IP4_ADDR_TUNL_DEV1);
@@ -667,6 +677,8 @@ static void test_xfrm_tunnel(void)
 		goto done;
 	if (!ASSERT_EQ(skel->bss->xfrm_remote_ip, 0xac100164, "remote_ip"))
 		goto done;
+	if (!ASSERT_EQ(skel->bss->xfrm_replay_window, 42, "replay_window"))
+		goto done;
 
 done:
 	delete_xfrm_tunnel();
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3a59eb9c34de..c0dd38616562 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -30,6 +30,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap) __ksym;
+struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
+		       u32 opts__sz) __ksym;
+void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -950,4 +954,51 @@ int xfrm_get_state(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+volatile int xfrm_replay_window = 0;
+
+SEC("xdp")
+int xfrm_get_state_xdp(struct xdp_md *xdp)
+{
+	struct bpf_xfrm_state_opts opts = {};
+	struct xfrm_state *x = NULL;
+	struct ip_esp_hdr *esph;
+	struct bpf_dynptr ptr;
+	u8 esph_buf[8] = {};
+	u8 iph_buf[20] = {};
+	struct iphdr *iph;
+	u32 off;
+
+	if (bpf_dynptr_from_xdp(xdp, 0, &ptr))
+		goto out;
+
+	off = sizeof(struct ethhdr);
+	iph = bpf_dynptr_slice(&ptr, off, iph_buf, sizeof(iph_buf));
+	if (!iph || iph->protocol != IPPROTO_ESP)
+		goto out;
+
+	off += sizeof(struct iphdr);
+	esph = bpf_dynptr_slice(&ptr, off, esph_buf, sizeof(esph_buf));
+	if (!esph)
+		goto out;
+
+	opts.netns_id = BPF_F_CURRENT_NETNS;
+	opts.daddr.a4 = iph->daddr;
+	opts.spi = esph->spi;
+	opts.proto = IPPROTO_ESP;
+	opts.family = AF_INET;
+
+	x = bpf_xdp_get_xfrm_state(xdp, &opts, sizeof(opts));
+	if (!x || opts.error)
+		goto out;
+
+	if (!x->replay_esn)
+		goto out;
+
+	xfrm_replay_window = x->replay_esn->replay_window;
+out:
+	if (x)
+		bpf_xdp_xfrm_state_release(x);
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.1


