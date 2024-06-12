Return-Path: <linux-kselftest+bounces-11775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE19057E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF261C242D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E38184123;
	Wed, 12 Jun 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="FC8RbH98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbB37sC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505C184113;
	Wed, 12 Jun 2024 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207961; cv=none; b=AJYBkXu6iGWfCvpLgCU+qfbI2IfbpdSXdTrZs0xHQ7ZUMwfEShp2qZe2L49Jt2s+L+iWythAo34th5x3zzKUpd1DW9JPyklUSQVvCwcNdmpFIOaVQzXNTM2MEAilf11QXc43HXyVq/5GzsXy/aXutoOvjewCAfOA5dWR0bi8Waw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207961; c=relaxed/simple;
	bh=JHgDG6CBaC2pw4rqBfIHAd5mxxaAeSr8uX2G8OkCw0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j653IQ8iX128TMWAskr9tpIPxe7z2B+2BhWbHw7VxSPXgqop5lRaPTMkm3Vt/ITh09a29CSGxBho0vJjJKil5uJ/7TxTGB4caTB/OxJDaZ5ZGbMGQr+umC4Hx7X1LZlZqZ7iDOJJ7n0MTlhDA+5zQjanKhT6OiH0Lu8rV0GTu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=FC8RbH98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbB37sC5; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 3CE022CC0174;
	Wed, 12 Jun 2024 11:59:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 12 Jun 2024 11:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1718207957; x=
	1718215157; bh=NA95GwCBOqNSuwFYcP1D5HkbWJ2YgltwMTaT5DqWOaM=; b=F
	C8RbH98KPtwBRc1ULnGTxH8JDBUfAFAkwicEzBGcga6Kx748LlbrwsgMfS5TDdN0
	SJJoEUBRLqtKiOsWmG4fFzn16B7c8vUIjPxwn7yS9y3lGsJ7fZh7Oc1XF/8JuaeD
	9GatHzctRK77/ZWD8pqCkk9hY3YMUmu+pZLBC6zi0nXBwwh2tcBn1eSW0DyXKpCN
	llUsVVqvwE2kKBtGoQ6gXC3EdVpyAee1xPxyUDiWRFIUPrBI01n3G19LNR3b8t86
	cIRwB61wxr415PJJQGP6b6iwQpLYIPz3XX9wKQ+f0Wuag4McwxLKMuRVHG87dwbu
	nmn3ls+tT2AavjUT9efmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718207957; x=
	1718215157; bh=NA95GwCBOqNSuwFYcP1D5HkbWJ2YgltwMTaT5DqWOaM=; b=I
	bB37sC500xFFv0r72bPcuSW2wDVpNjSSHeRZt2rJq+2+nD3E7rmtTJX6HRIPz8sZ
	JvbS2S2iN+BZ7Zt0lhCSnZSOR7ai3IKzH3EwCZvwpMQ8tN8ykJ8lKhtdy2UiXJ6i
	pyJ7aFiMJGcRSApV6ocba3k3+D8Scvx/PVOLqzN7L7I3dUrYD2ubVQXP68QWq3aD
	tsYpRdciRxylEcD2K0q3IX1eYgtKmoeU3zCBcYWqyCE0FRnScLR6ITY2ptTlRBHH
	YKdu4v4az2DbMOuLHvH7DG+8Thsefwz+XJvSdLZOqWiP/eoUwIZpYnDza4JNeDEb
	/nwu2wO97q1JllmnyepqA==
X-ME-Sender: <xms:1cVpZlwBgjFOg3qi5hoXzhUm-5c-k0vmgL3WliclvWT9U6sArXT8rw>
    <xme:1cVpZlRYWTJ8zi8T_n59_JvE9v1N9tneA6CVIqNVbMTL2JdmoRmrqQClooZN1fWG8
    ONnTSVy6lfqIha4ZA>
X-ME-Received: <xmr:1cVpZvVrNvK2Jmpjvw8RNlGcdSwqf2_QF3sFLy642fFww_HecUXxSlEfJ5wZ8gkHN3zU0q7ZQN4HJIJGFL2rW1eXSuWeKUJy1Q8CCBhf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:1cVpZniB6UYZ3BPePffV8HVoKA4-QiDbuMVUHf5HHyvwLaqz5xImOQ>
    <xmx:1cVpZnC0oaKhuWcItfkAWl7xZlhstTLpwPubR0mio0qtk4LQAsKjUw>
    <xmx:1cVpZgIQHX-gQM1xIY6aziq7ietXGlpW3da3ozF2Wa-wWV125AbCxQ>
    <xmx:1cVpZmAuNyxuAOIV9FHrBSdHSNv49ETN-zsbZXn7e48p7sp5P36hjg>
    <xmx:1cVpZuXeKPMGflFVm4PJ-ypzOpDA-EslVVLuGqiwhinDrHl_6VaWHx27>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 11:59:16 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	shuah@kernel.org,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 07/12] bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
Date: Wed, 12 Jun 2024 09:58:31 -0600
Message-ID: <efe7aadad8a054e5aeeba94b1d2e4502eee09d7a.1718207789.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718207789.git.dxu@dxuuu.xyz>
References: <cover.1718207789.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With generated kfunc prototypes, the existing callback names will
conflict. Fix by namespacing with a bpf_ prefix.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/progs/bpf_dctcp.c | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_dctcp.c b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
index 3c9ffe340312..02f552e7fd4d 100644
--- a/tools/testing/selftests/bpf/progs/bpf_dctcp.c
+++ b/tools/testing/selftests/bpf/progs/bpf_dctcp.c
@@ -65,7 +65,7 @@ static void dctcp_reset(const struct tcp_sock *tp, struct bpf_dctcp *ca)
 }
 
 SEC("struct_ops")
-void BPF_PROG(dctcp_init, struct sock *sk)
+void BPF_PROG(bpf_dctcp_init, struct sock *sk)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bpf_dctcp *ca = inet_csk_ca(sk);
@@ -77,7 +77,7 @@ void BPF_PROG(dctcp_init, struct sock *sk)
 				   (void *)fallback, sizeof(fallback)) == -EBUSY)
 			ebusy_cnt++;
 
-		/* Switch back to myself and the recurred dctcp_init()
+		/* Switch back to myself and the recurred bpf_dctcp_init()
 		 * will get -EBUSY for all bpf_setsockopt(TCP_CONGESTION),
 		 * except the last "cdg" one.
 		 */
@@ -112,7 +112,7 @@ void BPF_PROG(dctcp_init, struct sock *sk)
 }
 
 SEC("struct_ops")
-__u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
+__u32 BPF_PROG(bpf_dctcp_ssthresh, struct sock *sk)
 {
 	struct bpf_dctcp *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -122,7 +122,7 @@ __u32 BPF_PROG(dctcp_ssthresh, struct sock *sk)
 }
 
 SEC("struct_ops")
-void BPF_PROG(dctcp_update_alpha, struct sock *sk, __u32 flags)
+void BPF_PROG(bpf_dctcp_update_alpha, struct sock *sk, __u32 flags)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	struct bpf_dctcp *ca = inet_csk_ca(sk);
@@ -161,12 +161,12 @@ static void dctcp_react_to_loss(struct sock *sk)
 }
 
 SEC("struct_ops")
-void BPF_PROG(dctcp_state, struct sock *sk, __u8 new_state)
+void BPF_PROG(bpf_dctcp_state, struct sock *sk, __u8 new_state)
 {
 	if (new_state == TCP_CA_Recovery &&
 	    new_state != BPF_CORE_READ_BITFIELD(inet_csk(sk), icsk_ca_state))
 		dctcp_react_to_loss(sk);
-	/* We handle RTO in dctcp_cwnd_event to ensure that we perform only
+	/* We handle RTO in bpf_dctcp_cwnd_event to ensure that we perform only
 	 * one loss-adjustment per RTT.
 	 */
 }
@@ -208,7 +208,7 @@ static void dctcp_ece_ack_update(struct sock *sk, enum tcp_ca_event evt,
 }
 
 SEC("struct_ops")
-void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
+void BPF_PROG(bpf_dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 {
 	struct bpf_dctcp *ca = inet_csk_ca(sk);
 
@@ -227,7 +227,7 @@ void BPF_PROG(dctcp_cwnd_event, struct sock *sk, enum tcp_ca_event ev)
 }
 
 SEC("struct_ops")
-__u32 BPF_PROG(dctcp_cwnd_undo, struct sock *sk)
+__u32 BPF_PROG(bpf_dctcp_cwnd_undo, struct sock *sk)
 {
 	const struct bpf_dctcp *ca = inet_csk_ca(sk);
 
@@ -237,28 +237,28 @@ __u32 BPF_PROG(dctcp_cwnd_undo, struct sock *sk)
 extern void tcp_reno_cong_avoid(struct sock *sk, __u32 ack, __u32 acked) __ksym;
 
 SEC("struct_ops")
-void BPF_PROG(dctcp_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
+void BPF_PROG(bpf_dctcp_cong_avoid, struct sock *sk, __u32 ack, __u32 acked)
 {
 	tcp_reno_cong_avoid(sk, ack, acked);
 }
 
 SEC(".struct_ops")
 struct tcp_congestion_ops dctcp_nouse = {
-	.init		= (void *)dctcp_init,
-	.set_state	= (void *)dctcp_state,
+	.init		= (void *)bpf_dctcp_init,
+	.set_state	= (void *)bpf_dctcp_state,
 	.flags		= TCP_CONG_NEEDS_ECN,
 	.name		= "bpf_dctcp_nouse",
 };
 
 SEC(".struct_ops")
 struct tcp_congestion_ops dctcp = {
-	.init		= (void *)dctcp_init,
-	.in_ack_event   = (void *)dctcp_update_alpha,
-	.cwnd_event	= (void *)dctcp_cwnd_event,
-	.ssthresh	= (void *)dctcp_ssthresh,
-	.cong_avoid	= (void *)dctcp_cong_avoid,
-	.undo_cwnd	= (void *)dctcp_cwnd_undo,
-	.set_state	= (void *)dctcp_state,
+	.init		= (void *)bpf_dctcp_init,
+	.in_ack_event   = (void *)bpf_dctcp_update_alpha,
+	.cwnd_event	= (void *)bpf_dctcp_cwnd_event,
+	.ssthresh	= (void *)bpf_dctcp_ssthresh,
+	.cong_avoid	= (void *)bpf_dctcp_cong_avoid,
+	.undo_cwnd	= (void *)bpf_dctcp_cwnd_undo,
+	.set_state	= (void *)bpf_dctcp_state,
 	.flags		= TCP_CONG_NEEDS_ECN,
 	.name		= "bpf_dctcp",
 };
-- 
2.44.0


