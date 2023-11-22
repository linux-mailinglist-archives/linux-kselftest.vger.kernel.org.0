Return-Path: <linux-kselftest+bounces-459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F5F7F4F4F
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA12811E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D465D49C;
	Wed, 22 Nov 2023 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="rC5vATeK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Om7uyCE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BD51AB;
	Wed, 22 Nov 2023 10:21:12 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 7333258071E;
	Wed, 22 Nov 2023 13:21:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 13:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm3; t=1700677271; x=
	1700684471; bh=MkiWZ7hndeUKcl/hIWbjV8IQ3kJNfZ+yq9JosgeOxnU=; b=r
	C5vATeKuhOW93dtcUKH8UClKCfjzF9Xl4bA1RFgGxj4x2Z/V0laY/04WwqJPq6Ad
	r28Y4QVdadBBSD5RVGoYZ13ZFEDERoDtoJyZpZfd3IYyqMy8lOwzToqb2la/SDfx
	3fvZo3l3hsKpmbbLk0+LhBOO/lr2AEG5yrTLaPM5qOmrKpwQGbkiwyFQsbCy0EXl
	+fjuncUUzp318ZSwX1n0gML9TXAzYvF/P4IahnPdtPg5fD+w/vF1MUPmolNuh0xQ
	GPYsmMoGG0yvy6JQLvvDEw/KxMJYlyme/dCEPWxRXcE36hZhx1Pv4VPDc3vCBT0d
	31MDYZbgkCky8BRxwIdhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677271; x=
	1700684471; bh=MkiWZ7hndeUKcl/hIWbjV8IQ3kJNfZ+yq9JosgeOxnU=; b=O
	m7uyCE+97C8ZSq/6OKBwWyKEv9gWkvbTgMlQEwaFo6d0wXG7ky4shzpSKmmYkVmr
	ZVnEDlNVXE6M/quKpBnxMl4F7OgTrq84wLH6JP7DfhbYnn12BSnbZkTaRu1SivfF
	VUJao4vmqHLyHgPZQiTtNaovT+QAWLLTxzJ31oAAF/u/+9DBat2JMnB6bDFMvpkT
	MPK1pI2Fi8Dr5qikEv/dNTvVDQjeoBfVZdCNUXjGEVyrEHAvUFAMoxT+ff6ixRRR
	5WqRAnardiLg5vDzdeDb8gBw+MdvC0JiuPkuy5MOJDxgAV2K3GaLJDVAyVecYIWO
	dxfMLb4pdJRs7Zq4VlN9g==
X-ME-Sender: <xms:l0ZeZTE8tlyliDsDO6nJF6yB4-9n1Hxeh3VBHkcV7uZcoWLrWBW2xA>
    <xme:l0ZeZQXDzXbdPZwlmmxQOXl6HNtmmVoipOT3Xr5yeknlSaVnrtiyGLwaQmZLww036
    5CGpfnSoFeYt0kPkw>
X-ME-Received: <xmr:l0ZeZVLfzoiy6e6IUYzeBOZM64YzOhQFxjo-CeBjswqYCk8tZQElRF1LlO6oi_qN9ltrSay_sLnodvomndf8nNofzImIG0WpOLpODYOhc5lJkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduie
    ekvdeuteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:l0ZeZREuNF294xuSzhD6lAHt_Nm1M5EJKy08xIrIP8iX-kTuggJLQQ>
    <xmx:l0ZeZZWnigLssRFcHmdKjL0nUzrlf4VaT5WJaCDtszIa7joOx3XbPQ>
    <xmx:l0ZeZcPU29sNi1LwktVFAbRNMyIx-O4zaLnYe7TVLXZq43sh8SdyWA>
    <xmx:l0ZeZfFC2uN9Ytr1PmSOGkCKdEOnEp793N9kct-9NZYUluUxrEijkA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:09 -0500 (EST)
From: Daniel Xu <dxu@dxuuu.xyz>
To: john.fastabend@gmail.com,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	kuba@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	alexei.starovoitov@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
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
Subject: [PATCH ipsec-next v1 7/7] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
Date: Wed, 22 Nov 2023 11:20:28 -0700
Message-ID: <84111ba0ea652a7013df520c151d40d400401e9c.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
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
2.42.1


