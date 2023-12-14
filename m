Return-Path: <linux-kselftest+bounces-1971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69153813D92
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 23:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3DF1F227C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A37E566;
	Thu, 14 Dec 2023 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="qJcqpxiN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLtW2KZJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0C6F614;
	Thu, 14 Dec 2023 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 2E4A02B007A7;
	Thu, 14 Dec 2023 17:49:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 14 Dec 2023 17:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1702594179; x=
	1702601379; bh=Qq1ouEN+3ihu7U9MznAZUpbzC1IONhC/7bAWyzeIku8=; b=q
	JcqpxiNiyYr34sDS9EKQhYc9wxX9mzCZAiw2nNy8MGVlU9u/UrVfYDlxO7xCo/M/
	fcHAaBB8226PPFcKcqpzqC8kd+coRqvhwk1qR7Vb863V/h5cpm+8NkrKouhFCJhA
	LbMv5F3gwDhl47+nELFf+9Yl8W6fubXsAHcg9uXMwOdOg73aTvaaNxYpU+eEB1fk
	8PsKwVEPLZFg4MbRHC1S0G+9KhJ3q/3WhP9Xpt6SSmX8vY23ZEZzAbgXxgDGU+2c
	Y0B5f++E6Tz8CwvPUp+Bp1ysOZl88rLwuajd0x/QFtExiRARlMj5dJSCQ0gPdEaV
	z05wGSFLHSYYRdzcBSelw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702594179; x=
	1702601379; bh=Qq1ouEN+3ihu7U9MznAZUpbzC1IONhC/7bAWyzeIku8=; b=l
	LtW2KZJKAnxlWzW+V1TnKa5jsRIQbzY0dPE8TSPeJmqmXls62QxG2CKzTjrhCPfx
	vzngzOavGTmbcrUYSqLtji8wH7BE3UV8sbMEESH6r2OtPdiMZFTEwTI1a0JSJSRY
	BdR8YfE64HJyBhZUH+7HHXBDH2Cz6vJuXJeEu6/3hyqLYbtrNBgmXma7PHyTqpCx
	Y1EUXWHOQ/7TXiRXK78eB2j7VdPv8QXx1EQpFKZ1i0ChawyiTiaSlMLlIbTUNz5p
	ZnnS23EM/XrfryVXUNC8jDp26ai3Uzzjsrrz7augnUV9tf5xPH244F75uv2vYJln
	46swzWSB55SfqQEXCVAEw==
X-ME-Sender: <xms:g4Z7ZSVkKSmA8kC7EHMs2MXbMZCX-U7D1jQdOY7xevBloFz996MiNQ>
    <xme:g4Z7Zen9qmZjyRSiIlLouCuzjtiGn1fIVTprtn3BGxFRa4MpzaCKZ2DySnNsIDjGD
    tp75vWIMJFnjeIh0Q>
X-ME-Received: <xmr:g4Z7ZWbKGW_56mnOO5ab2ebHEvdEqRdH3LKIXIPodoiNc79rSzmAsI3wTrsUcOlCr131m41CzSXOSkm_yFNMnYdve225-oXBD_S8T8nxI19ArA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:g4Z7ZZU9vsi2hEZ0carLE8gXdaYloNd1fUqZcT6ob0yB79T9d3sPJg>
    <xmx:g4Z7Zcna85sYFkYAw6Rspoe_L5RpDxtgX8KPIStGl8LQb3jn_cb5rQ>
    <xmx:g4Z7ZedZl_3GCb52LOAwE8fOKXop5qoR9U4bTNzRTunLB88KTsfdbg>
    <xmx:g4Z7ZY3XIyR44KBmdrDbZG9WFFWyeARcCbAWMYoSKIpuoF1DDiZPcImAnfw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 17:49:37 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	hawk@kernel.org,
	shuah@kernel.org,
	kuba@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	ast@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	eyal.birger@gmail.com
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
Subject: [PATCH bpf-next v6 5/5] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Thu, 14 Dec 2023 15:49:06 -0700
Message-ID: <e704e9a4332e3eac7b458e4bfdec8fcc6984cdb6.1702593901.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1702593901.git.dxu@dxuuu.xyz>
References: <cover.1702593901.git.dxu@dxuuu.xyz>
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
 .../selftests/bpf/prog_tests/test_tunnel.c    | 16 +++++-
 .../selftests/bpf/progs/test_tunnel_kern.c    | 51 +++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
index 2d7f8fa82ebd..2b3c6dd66259 100644
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
@@ -313,7 +313,7 @@ static int add_xfrm_tunnel(void)
 	 */
 	SYS(fail,
 	    "ip xfrm state add src %s dst %s proto esp "
-		    "spi %d reqid 1 mode tunnel "
+		    "spi %d reqid 1 mode tunnel replay-window 42 "
 		    "auth-trunc 'hmac(sha1)' %s 96  enc 'cbc(aes)' %s",
 	    IP4_ADDR_VETH0, IP4_ADDR1_VETH1, XFRM_SPI_IN_TO_OUT, XFRM_AUTH, XFRM_ENC);
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
index 3a59eb9c34de..3e436e6f7312 100644
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
+	if (!x)
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


