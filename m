Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9507DA112
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 20:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjJ0Szx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 14:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjJ0Szw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 14:55:52 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 11:55:49 PDT
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FAAB0;
        Fri, 27 Oct 2023 11:55:49 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 75F77580897;
        Fri, 27 Oct 2023 14:46:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 14:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698432410; x=
        1698439610; bh=4Ah8oNGCj3UUd4tZonhdOFYd28AC8mVLruGLmu1uJPo=; b=I
        PAkS5dJshTzDmnYREnLGTIhjhlFecijpEqy/PDiLikg0oCGpEgJh5de3dOX7wkUa
        hyfUxIReX4ma5e5Oygouqo4Pi03/gfedrh2WAcuNkOPIW5JNchmJ/KCcQEKZIsBs
        igQ7c3r++jeCNMMUGMxIhn5kPo8sVL3nSMnxHB+mcAxIqfXBi1h7gfQk9eUONCiJ
        pKTlRbXXK2IA1F0uN4tRwho2zWlSmkkj4J8mTLZi7eSrAhv9ge+g4vtOvce47psP
        5TGwghjcrPtgGhcgXKs6OwRGFO2sr+u32evgEa0yLRTo86HcIJw3EK4LHicEMh/V
        n0FhUC9+QK9QWALZ46gfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698432410; x=
        1698439610; bh=4Ah8oNGCj3UUd4tZonhdOFYd28AC8mVLruGLmu1uJPo=; b=a
        +s0bHh37UBfTbKEIUYy2DpBSmxlSfdfS3Gc1uIsRC9gq23yXCvX3L7Zb/rKlnp8O
        ssQkISNFafXFz9cdQr0nW6paOdVKvDNZZn/155wGTqdbHPE7NWa95PgXEYTR/fd8
        he1o1CtxfK8svO7Z/fWM2O2EBRzeMwx0urPHBmttxK2fFSMuAxu6C0kB/H8w3TwS
        4Rf67a+yesMz7Yy9CeV/wuNXY0pHVtHQ8T8/V6mL8g2emMjYooQXNszA6FalJX5X
        zccDoTUhveN+4niVrZcYnTxVtSV7W57ITwtSSl6UAljs7ysnGK3Ezu93YaNMln21
        A2ZFOJRRk4w8TOgGqIgRg==
X-ME-Sender: <xms:mgU8ZWh-T_UB48zprN2VicCqDSuW13KZX9BGW0NUzBYDopTY549qzg>
    <xme:mgU8ZXBeQN7i-OXOzcf9fAqEtrxabv8G-yQQl9mOetLlwCxFs0I0UjXgXKJJu1DZM
    FVk4FaJsTtm_93Yvg>
X-ME-Received: <xmr:mgU8ZeEt4Zz1Q3-uw_9yqMa5GWXpMBEmVnZFLXcl2IrYf35OsflaEUsUSedVqKSCFeFpyAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:mgU8ZfQaaMlZOurJM5B2tfTHP2Lu0rHpBDLAKXQXlLZNYrw73Dht2g>
    <xmx:mgU8ZTx2vvZndN9UGOhdREa2Iq7hv43Q8DGcbvo0B1s2T-cPNN5kAA>
    <xmx:mgU8Zd7biLVIpHekm13ObRpvGz8wjteFPwDD7-IyKil_oNUKLmOh8w>
    <xmx:mgU8ZRq7VqWDZvY9zoT78pBLb3G2ESoDdlYXUz0KMbXmXbytZiuteg>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 14:46:49 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     hawk@kernel.org, ast@kernel.org, shuah@kernel.org,
        daniel@iogearbox.net, kuba@kernel.org, davem@davemloft.net,
        andrii@kernel.org, john.fastabend@gmail.com,
        steffen.klassert@secunet.com, antony.antony@secunet.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: [RFC bpf-next 6/6] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date:   Fri, 27 Oct 2023 12:46:22 -0600
Message-ID: <62f770a8956773a3c21dccb6037aee305dc7e4c6.1698431765.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698431765.git.dxu@dxuuu.xyz>
References: <cover.1698431765.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit extends test_tunnel selftest to test the new XDP xfrm state
lookup kfunc.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 46 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 12 +++--
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ec7e04e012ae..f5f6a18ac0f1 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -35,6 +35,9 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap) __ksym;
+struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
+		       u32 opts__sz) __ksym;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -948,4 +951,47 @@ int xfrm_get_state(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
+SEC("xdp")
+int xfrm_get_state_xdp(struct xdp_md *xdp)
+{
+	struct bpf_xfrm_state_opts opts = {};
+	struct ip_esp_hdr *esph;
+	struct bpf_dynptr ptr;
+	struct xfrm_state *x;
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
+	opts.netns_id = BPF_F_CURRENT_NETNS,
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
+	bpf_printk("replay-window %d\n", x->replay_esn->replay_window);
+out:
+	return XDP_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index dd3c79129e87..17d263681c71 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -528,7 +528,7 @@ setup_xfrm_tunnel()
 	# at_ns0 -> root
 	ip netns exec at_ns0 \
 		ip xfrm state add src 172.16.1.100 dst 172.16.1.200 proto esp \
-			spi $spi_in_to_out reqid 1 mode tunnel \
+			spi $spi_in_to_out reqid 1 mode tunnel replay-window 42 \
 			auth-trunc 'hmac(sha1)' $auth 96 enc 'cbc(aes)' $enc
 	ip netns exec at_ns0 \
 		ip xfrm policy add src 10.1.1.100/32 dst 10.1.1.200/32 dir out \
@@ -537,7 +537,7 @@ setup_xfrm_tunnel()
 	# root -> at_ns0
 	ip netns exec at_ns0 \
 		ip xfrm state add src 172.16.1.200 dst 172.16.1.100 proto esp \
-			spi $spi_out_to_in reqid 2 mode tunnel \
+			spi $spi_out_to_in reqid 2 mode tunnel replay-window 42 \
 			auth-trunc 'hmac(sha1)' $auth 96 enc 'cbc(aes)' $enc
 	ip netns exec at_ns0 \
 		ip xfrm policy add src 10.1.1.200/32 dst 10.1.1.100/32 dir in \
@@ -553,14 +553,14 @@ setup_xfrm_tunnel()
 	# root namespace
 	# at_ns0 -> root
 	ip xfrm state add src 172.16.1.100 dst 172.16.1.200 proto esp \
-		spi $spi_in_to_out reqid 1 mode tunnel \
+		spi $spi_in_to_out reqid 1 mode tunnel replay-window 42 \
 		auth-trunc 'hmac(sha1)' $auth 96  enc 'cbc(aes)' $enc
 	ip xfrm policy add src 10.1.1.100/32 dst 10.1.1.200/32 dir in \
 		tmpl src 172.16.1.100 dst 172.16.1.200 proto esp reqid 1 \
 		mode tunnel
 	# root -> at_ns0
 	ip xfrm state add src 172.16.1.200 dst 172.16.1.100 proto esp \
-		spi $spi_out_to_in reqid 2 mode tunnel \
+		spi $spi_out_to_in reqid 2 mode tunnel replay-window 42 \
 		auth-trunc 'hmac(sha1)' $auth 96  enc 'cbc(aes)' $enc
 	ip xfrm policy add src 10.1.1.200/32 dst 10.1.1.100/32 dir out \
 		tmpl src 172.16.1.200 dst 172.16.1.100 proto esp reqid 2 \
@@ -585,6 +585,8 @@ test_xfrm_tunnel()
 	tc qdisc add dev veth1 clsact
 	tc filter add dev veth1 proto ip ingress bpf da object-pinned \
 		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state
+	ip link set dev veth1 xdpdrv pinned \
+		${BPF_PIN_TUNNEL_DIR}/xfrm_get_state_xdp
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	sleep 1
 	grep "reqid 1" ${TRACE}
@@ -593,6 +595,8 @@ test_xfrm_tunnel()
 	check_err $?
 	grep "remote ip 0xac100164" ${TRACE}
 	check_err $?
+	grep "replay-window 42" ${TRACE}
+	check_err $?
 	cleanup
 
 	if [ $ret -ne 0 ]; then
-- 
2.42.0

