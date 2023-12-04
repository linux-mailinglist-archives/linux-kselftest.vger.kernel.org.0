Return-Path: <linux-kselftest+bounces-1091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80680409E
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 21:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36066B20BB7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 20:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B83A8F6;
	Mon,  4 Dec 2023 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fQoXufqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0G1dJFA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E456173B;
	Mon,  4 Dec 2023 12:57:12 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 90418580A6A;
	Mon,  4 Dec 2023 15:57:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 04 Dec 2023 15:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1701723431; x=
	1701730631; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=f
	QoXufqYcQIqHDb6el7DTUJd0fBEdJBUVU5fChFUUxqhhNptIPWA2GRfZjS5By+kM
	TSZmQy0jNI4S4C3Xzcf3SQxzfJaIp/4rzSJwhtM3BLXoAcPtTYwhRdUtsc7Cq+YQ
	/vNbJhiEN+Ih45VmOsGphKUYIfa4A4q/ZPylcUTjClRfYMa/DICvhVYDcC4HIZ8H
	K8hgEexMFRkSPklKC373I8YYyKagom68fe9bWDqJZIEI3n92ydmOfPDPNJKSS9tb
	e4gjLLKfV8FYwNwiYqCqvEtH5YJKa3aMV4e1WyPkqejMUzTinX5ew+VlBFTNVdSv
	7Em7dEUtrLlCGLAo/lEkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701723431; x=
	1701730631; bh=Xy5DWhMcuaQWz9hFzj8IU9Hd0UISUG5+/EyW9nquCao=; b=a
	0G1dJFA48CvQe6gUE0On96JanSsLf7wueO3F1B4613z0EoYzIg2yB63UoGRCsIsQ
	NHF3yMLdOovVFVpDNXfv1ncdAlBYvn2Zns/c/XcqOYOc9+Z7y3YQYE9pvp6pVlhf
	FYyPUI/egIzvJMLHKr/1/CPKLENAfHBOLsbJH5XcwoxrE+8u6du607mPmAE+3HLv
	BzrhJinolZmi0agqWryGkTo/eGouP5Hzkhr6GJIjXTE4+HXreHRA6NVoIFWqMctv
	gPaZFilQ9twbCtVNEIFHXehy43p3fzOp/Ryynnqo1IOhwaVTd0/X70xKevH4cZKD
	mkJXAU7wBQtbF5mIEKDVw==
X-ME-Sender: <xms:Jz1uZbbPJAWqw1hbkmdCf0OIc5cXLyn_tIjNkGvN7IdMolIJ0nQHKQ>
    <xme:Jz1uZaYQCNvJrlAuauPZ8-Gl2lyEQM4sFCIiNi-SBtGpT8IrUT4d9Kgs_0kG480R1
    a9pn8eCLfkLt3i3Iw>
X-ME-Received: <xmr:Jz1uZd-SzMW3Gag7dTS2UNdDBlimaWKPgkpl-aeaIOCSICynrGW6bqvQXCsYv9PSrl7NOA_GG3laktaAgl3tPSnMMU8FPCuC3tiH6H6a4O8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Jz1uZRpPhhDVYqaEh3YnUGp3rYsAfraByBKMTWkzoCK6HD41pqIbow>
    <xmx:Jz1uZWrOfGi_yx1eBdyltH_ddZPfrJRG8CMf-ebmYxHw1yD4YYeoQg>
    <xmx:Jz1uZXS7NVV8FytT-dssTKaa9AlvgQaSEIx8k0D_KPPqIAQ5UhMphA>
    <xmx:Jz1uZZ5L0Gpt67rr6UlJRtzZaa7l8ZKhmdZumwqyfXC4A2OaOy6g7A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Dec 2023 15:57:09 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: daniel@iogearbox.net,
	ast@kernel.org,
	davem@davemloft.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	kuba@kernel.org,
	shuah@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: [PATCH bpf-next v4 10/10] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Mon,  4 Dec 2023 13:56:30 -0700
Message-ID: <ee451cb630f53ef9f71fed9af6fd516bc547468b.1701722991.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1701722991.git.dxu@dxuuu.xyz>
References: <cover.1701722991.git.dxu@dxuuu.xyz>
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


