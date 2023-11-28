Return-Path: <linux-kselftest+bounces-735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C87FC0C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 18:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76D01C20C0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF541C75;
	Tue, 28 Nov 2023 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fYxIriBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ESXHxqeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7E21BEE;
	Tue, 28 Nov 2023 09:55:01 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 4D4DA5808A6;
	Tue, 28 Nov 2023 12:55:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 Nov 2023 12:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701194101; x=
	1701201301; bh=pRzLMeVRPt+MUHCng+m1tZ8fgrKzg19ebGP/3BAFCkA=; b=f
	YxIriBqXmmHg8j6KtUAs/3OPkhsMO0klMHNjwrU/YJyLjr00tiMG9XQmCnDsf/zB
	3EC1PlMzxU50eN8WfT8AobHniog8ctqc3x3GyPBzkwJx/kfXKEITLaBCdT+S2DHS
	GbUf0lAilvzSd3fq8bO+GQi6jVBFkeweD3A5xYdgVtT4ELoxWrfwR59lkQ+T/XIW
	W4DzQlpiTxN1diMkRGCDwvknGKHpI0aQ5lEogRKPm+jtAkLJE8CHCasSvF7HYe8W
	H3wuoAdU2fhdyl0pkVnqmQfgsLzvBGSoA86BDKq8ORwIYi+UB8d1WUy2uV3e2a30
	ucsHILT89/jVCEGsLNj4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701194101; x=
	1701201301; bh=pRzLMeVRPt+MUHCng+m1tZ8fgrKzg19ebGP/3BAFCkA=; b=E
	SXHxqeRf/J/HiMLdJB5LjmNYaN5GEguqEdhdlUMuSlu6zsAXw4+zHC1vjTWsPiOn
	pr06G6jucT4jVQ9ywbfgJDFcDDjOoD5+NNQnqnvPJUrGzYpaWt9vj8aHfG3NRtR+
	J5bs9bzj0mr4sz7VCvihnX+tngfsQo0eC1vC9C9Qjw8xFrNAbX7tX+Tue1Y7Wv4Z
	mjR0PIWdeYyRwfjO93cTPWC+jMc11kTHdsl/eQ4TW8bG6Udz4+LXah/b0tUXVXfm
	9OREeT5jyEROAIEo2xbaua96MRSTLE0iTvlgam87Pri9yZTvWK7wnkhWA8y/7Eg/
	QBCxRqOsWkcHVpT8+gHnA==
X-ME-Sender: <xms:dSlmZWowACGY5zciQXmiOYkwKC3Q6N_kkHlO9_6RX8mpH55SI4t4OA>
    <xme:dSlmZUr1QQ4N6MOUS_U3p15ap0a_Lp8O0XujUAROeG6byi07grDDSnZYk71CyZlji
    Ubk6If2aUIS4ssyXg>
X-ME-Received: <xmr:dSlmZbNEDpjdQlx2-0D-_KYQbBQUmJzNAQjnlP3IVu7SoIw3jR5l1gJt2825YGJPNNn1UAZjs8W43eQNux1lp09rNV_pC9WAShhcTYsz23ZNlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:dSlmZV5-s2N4K6uXL_1iopFu6ouxabwtnLbfEDRVMm9Q7yhbSnAzdQ>
    <xmx:dSlmZV4G4fVvBcy_aITFyy2jh9II6jU7P_d05xWYaJtG9956ar0B7A>
    <xmx:dSlmZVjGFsD-k_sRvyy8xYAi5HSQXZDBbdoo9GkkqgAHDmfRkG5v-A>
    <xmx:dSlmZUJSrdTrjh4WJ2cOh1swIaNpO_apQTXeOAov5ihqXza0DCoB_w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 12:54:59 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: kuba@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	shuah@kernel.org,
	hawk@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
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
Subject: [PATCH ipsec-next v2 6/6] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Tue, 28 Nov 2023 10:54:26 -0700
Message-ID: <85d3bf6440c6fd3b7b007d044da9b78ccc1dbda4.1701193577.git.dxu@dxuuu.xyz>
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
index 3bcb6f96b9b5..54308afb3cdc 100644
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


