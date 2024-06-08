Return-Path: <linux-kselftest+bounces-11500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E81901394
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24925B22133
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 21:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAE4D9E7;
	Sat,  8 Jun 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="aJ52fQNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bd29stLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E54D8C9;
	Sat,  8 Jun 2024 21:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717881410; cv=none; b=PIM3fyYnoWnBsr2MEfqJRMd9ng74XMgujcdsU+Dub57Y4EIlPaUdfl66NhouW8J4RQDzif+URUAgWsioVzoaBVrSf4UqrizVPhyQiJ9E9Tj9ndWsz/+HITev6QveEemJo646n618bEQVvd439j3SGYacCwKYWMmfzQIwue0l2OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717881410; c=relaxed/simple;
	bh=JHgDG6CBaC2pw4rqBfIHAd5mxxaAeSr8uX2G8OkCw0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLhw5zht60x1FI22dORkb2fqHrmj2xRFqdMMG4n1PgPLB9yMbRapOqB7VsTka/Ir3V+Rpx4BpwQJCXYvRP8IeVIjt3XvYUMjmGRumvxpOVJMSOcnnolsnW+okNVgbAz9JCHjm2e86jVMHIgA15Qpqds0EHl19I0ABlUH8fPy7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=aJ52fQNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bd29stLd; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id BFF4C2CC00FC;
	Sat,  8 Jun 2024 17:16:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 08 Jun 2024 17:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1717881406; x=
	1717888606; bh=NA95GwCBOqNSuwFYcP1D5HkbWJ2YgltwMTaT5DqWOaM=; b=a
	J52fQNo1944xvEgsFDGghQ3igTe2n0d5Aqyydn+ITN4gVjD29auJip3uLIVsJkNe
	0KPG2lXVab2gYDj9XdD5cktvOvNOspjXAJwQtaFwDZyUCH3bUJ8LJCTD0ddCFU30
	L2aD8QtsG6it+WxGrFYrEf2TAH+BuFkSWG3kLJYA2y+FEgbyKwvqK/vvyIRMk3Ie
	Fjet9fcCmdAZCVgu0jlNx7aX6eb/7448giBzHa21C7EfTpSzGtaPKDTXF1qxwZQN
	QAlr3hZlJFYmlpIjMCUUigrhwuDtHnoJR/GUnYzGCq9w5gRhKDZGPqYYbdVW/yr2
	72mGksZuxz3u2gp2EiArw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717881406; x=
	1717888606; bh=NA95GwCBOqNSuwFYcP1D5HkbWJ2YgltwMTaT5DqWOaM=; b=B
	d29stLdbIBjUOgA7EVTXDYhJRCvyC+YI5JFultizIOwEB9rNv5QXBxNaxxMMmuOA
	etk7UXcsfdtO7Is0+yM5aJ+qyFKA2wX+/nSLChcodylJNpOjrql3qTMlRjTvvn6M
	WWJlFxsjl26i3F18Rh9g+zQ4yPWs1H9Ey9uIS7RSLLvbXyM7CxpN11cQ9hFgeruz
	hWtCI4UdV9iA/HWBFk7ukS9hpV6uCPCJCWjbbGb6t5OONtRIl+HeAAodE6O7DcrH
	FHmjHRdrBdmyRwmXse+aJ1u8Jxl2Ll0XZyBpaYM5Kc09GcWU+M3mDChbk9dnfd6U
	VcMTebTxLGROB9tt8zhaQ==
X-ME-Sender: <xms:PspkZpx5ZOo_jocpNglFTuK6nL2Uw6OGlhAPYgQi1tWONUMRWgiZTw>
    <xme:PspkZpQL0L3thTNzGOXFXJBor4y5G-LqeUzub0EuNZCBKn3bhdpfayGeXx4vV4tL2
    fmMc880RaytrAVPAQ>
X-ME-Received: <xmr:PspkZjU-zLfJAhr2pUKgjUDEqyzmqcmML6koo1Q1hEb0iS5K3olhl_R5ALHOXxRWMMtG2-1VVVcxR-8vZGFk-RJyXt2_Ap2FTaBRRxJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtgedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgfefgfegjefhudeike
    dvueetffelieefuedvhfehjeeljeejkefgffeghfdttdetnecuvehluhhsthgvrhfuihii
    vgepudenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:PspkZriGmVVujy4HN9TWGWtTcm3c76_IUQmIyaS9y_FSp4-pXa2CPQ>
    <xmx:PspkZrBwS1_IlrZ8MjV0MklmKXrm0pTM4dxQqhpVurSXlpj1SExCtQ>
    <xmx:PspkZkK3g115NX78vYMv-ut14dMg0PHFItCKKATd8wSfxq-o08hEOQ>
    <xmx:PspkZqDkL8d42PlFg9Qv22a66YDwy8FcpQdb9_Khe4uqoO7iRnvYwQ>
    <xmx:PspkZiV-N0WgQJb_BRHJh6WZanz2sOat9UauKZIi4prtljjCwprOPC7x>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Jun 2024 17:16:44 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: shuah@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org
Cc: mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 07/12] bpf: selftests: Namespace struct_opt callbacks in bpf_dctcp
Date: Sat,  8 Jun 2024 15:16:03 -0600
Message-ID: <14eb6dd8a7bb3f47fb44c433d1f10aae5d78f83f.1717881178.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717881178.git.dxu@dxuuu.xyz>
References: <cover.1717881178.git.dxu@dxuuu.xyz>
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


