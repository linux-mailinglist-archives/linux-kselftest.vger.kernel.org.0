Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4712F7DE7E8
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Nov 2023 23:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjKAWFz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Nov 2023 18:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKAWFz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Nov 2023 18:05:55 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Nov 2023 15:05:48 PDT
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B899B110;
        Wed,  1 Nov 2023 15:05:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 045D92B0024C;
        Wed,  1 Nov 2023 17:59:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 17:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1698875943; x=
        1698883143; bh=JDI0BTQjsxNjFfs3ZXUNBrkfEpISd91lLxe7rf7aIlc=; b=r
        vTYON17JSY0S452ml5IiBSCl0tjiF9U/2kCRCRNEBnmImPQ1fPablp9yJWGc1XjC
        XhuqLtfwa3EBMQgYpdpkSszRti0XUjz5u2TXHCqyvc7H9+wwGvOu9nbr3nUjFe+P
        P6Ck1bU+nKPPIB/OaRTrAq07aCjOnxVyOetjtYavVzGapluuW2a47KJnBD0bLJeI
        zknD0qg3KN5HDGjo1pLQWzVyArxyFxrc/VOupMK2FwkHdx91HxKUaEQ9he0TMy2l
        DFdCktW0xZGEiXhRH4F+G1kSVa1dyEZNXUNdgehOFSKbdc14WrXpkKKN+dX4ntLQ
        Lr7LPo7nfNicGOr9xfLuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698875943; x=
        1698883143; bh=JDI0BTQjsxNjFfs3ZXUNBrkfEpISd91lLxe7rf7aIlc=; b=j
        qyJXlVWSQlkH5fL2R5I/hiblO0azHwx7SyII3c/xdkWqooNa5IwI4Ou1fRii+Jn9
        IgUpRy7/w3PVmFG2NFdJ27LPh20xJskt+NH572lyp5X1484mlJf2rmFhlmwMNWDW
        FNNS+xZ4XDgy/1HLZiv2HX+VE1Bs1KuHhz4rVk8SWdYFdDz79dV0l6mnKrQ3Iuuh
        WKb+41wU5Dw8tBIsNjcH96MDC6lq/QyLdtj/yk5XZlSZmx7XY6D8othAviZW4TRS
        0rQtjUvMsG3UBv/hZ9Q1tW9yeoo1kmbnP3aJsoISNPPaVnN5rxHW4bMAIY3k2z42
        tIbsi+3dgSXYbOxMu5xkQ==
X-ME-Sender: <xms:J8pCZZo-mR5tQ3-BnKZ6vTCARCQl0XG8US8QvqmvaAoSpa_efxZ7mg>
    <xme:J8pCZbofbD-qvHOSEOdOmz9YxLoe_KJp_6wjCtO3gddfZASJikvDP5nDVhyoOHOqn
    ivTy4fv-TQe4oeJCg>
X-ME-Received: <xmr:J8pCZWP2Yqg0WY7BBS-71gtO9w9h_T4DhEXU59FiVWfetQZdAc_SRAw_9SE_IWJuc06eXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:J8pCZU5Gp9066IKZQxlHsVyKbI3TKWYU_31CurfrYwXofq5AXvzAOw>
    <xmx:J8pCZY7Hjlnd2IbLtPr6bG51w6V3Il8QLMJmeqy3b3XnuAiYesHeZw>
    <xmx:J8pCZcgn4wSzGwabhoojyGVmuHXzlYSMRuaNGVoOmDKODzhDq5A1MA>
    <xmx:J8pCZdSpko-PJ_aSebSMUbykDCE12AGISwu7kOgfK4Ov0XRJVW3afpmpzn4>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 17:59:00 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     shuah@kernel.org, kuba@kernel.org, hawk@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
        john.fastabend@gmail.com, davem@davemloft.net,
        steffen.klassert@secunet.com, antony.antony@secunet.com
Cc:     martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, devel@linux-ipsec.org
Subject: [RFCv2 bpf-next 7/7] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date:   Wed,  1 Nov 2023 14:57:51 -0700
Message-ID: <707a94d00b622e73c4b28bc059d4dabe7635b678.1698875025.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1698875025.git.dxu@dxuuu.xyz>
References: <cover.1698875025.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This commit extends test_tunnel selftest to test the new XDP xfrm state
lookup kfunc.

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/progs/test_tunnel_kern.c    | 49 +++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    | 12 +++--
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index ec7e04e012ae..17bf9ce28460 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -35,6 +35,10 @@ int bpf_skb_set_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap, int type) __ksym;
 int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
 			  struct bpf_fou_encap *encap) __ksym;
+struct xfrm_state *
+bpf_xdp_get_xfrm_state(struct xdp_md *ctx, struct bpf_xfrm_state_opts *opts,
+		       u32 opts__sz) __ksym;
+void bpf_xdp_xfrm_state_release(struct xfrm_state *x) __ksym;
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -948,4 +952,49 @@ int xfrm_get_state(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
 
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
+	if (x)
+		bpf_xdp_xfrm_state_release(x);
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

