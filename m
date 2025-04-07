Return-Path: <linux-kselftest+bounces-30257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25BEA7E167
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1587A1FC4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4FB1EEA2C;
	Mon,  7 Apr 2025 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FIR+CEEV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407C1E8334
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Apr 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035866; cv=none; b=DVYnCGBoX5fSzjDtv7iU5Gb6uo4DMJ6NlOt4OIggp8sohduMqfzLh9wnNLNM/SxSHnw8P+KuqWbF27c/IDdpivTnQHxbXInO+9MEyxeksa+QSNEvkHn2yp+quCkUj9VbTOa14Fr4KmwgOOeznPtFwfyauonG3pnNqowhhJ058IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035866; c=relaxed/simple;
	bh=CYydr1lnhZpTw6zfhhlnXyQ75xM40zXrRZyqQdrReaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/vzRiHz7CGcHRyWAfRtTT4X1oSn5QSNJk5I4NnLdJo8jyg1sApjRt0DahuMCt6jvKLDcFRZ/+9QUi4gKWCaaJt1ka9nWOBN9PVe6C+h+yKZeXGdMqFs/amz1rSok/8xdnsBYzkfEB6nafWRT2bP9myWqRWSqAV+luQf96NN8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FIR+CEEV; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744035861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kzON6JbiW/9Bf96HZECRlAjLMnxZfxHXOjdop7YDGLg=;
	b=FIR+CEEVkWgAunIWPdtOValKsy6DoRQduo318c8j6d2IiU0iTBjSvRGmaXiKScU2lfg2In
	puh6i1A5SIYLWkgOEjDra4X9RtD4R4xTvwku/6HoC/Ywp5TrJZBnmaD4VggcSmBmYmNTtd
	8sQ8qI2qJ0borqpXs4IUECyW3Hj76DE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 3/4] bpf, sockmap: Fix panic when calling skb_linearize
Date: Mon,  7 Apr 2025 22:21:22 +0800
Message-ID: <20250407142234.47591-4-jiayuan.chen@linux.dev>
In-Reply-To: <20250407142234.47591-1-jiayuan.chen@linux.dev>
References: <20250407142234.47591-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The panic can be reproduced by executing the command:
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --rx-strp 100000

Then a kernel panic was captured:
'''
[  657.460555] kernel BUG at net/core/skbuff.c:2178!
[  657.462680] Tainted: [W]=WARN
[  657.463287] Workqueue: events sk_psock_backlog
...
[  657.469610]  <TASK>
[  657.469738]  ? die+0x36/0x90
[  657.469916]  ? do_trap+0x1d0/0x270
[  657.470118]  ? pskb_expand_head+0x612/0xf40
[  657.470376]  ? pskb_expand_head+0x612/0xf40
[  657.470620]  ? do_error_trap+0xa3/0x170
[  657.470846]  ? pskb_expand_head+0x612/0xf40
[  657.471092]  ? handle_invalid_op+0x2c/0x40
[  657.471335]  ? pskb_expand_head+0x612/0xf40
[  657.471579]  ? exc_invalid_op+0x2d/0x40
[  657.471805]  ? asm_exc_invalid_op+0x1a/0x20
[  657.472052]  ? pskb_expand_head+0xd1/0xf40
[  657.472292]  ? pskb_expand_head+0x612/0xf40
[  657.472540]  ? lock_acquire+0x18f/0x4e0
[  657.472766]  ? find_held_lock+0x2d/0x110
[  657.472999]  ? __pfx_pskb_expand_head+0x10/0x10
[  657.473263]  ? __kmalloc_cache_noprof+0x5b/0x470
[  657.473537]  ? __pfx___lock_release.isra.0+0x10/0x10
[  657.473826]  __pskb_pull_tail+0xfd/0x1d20
[  657.474062]  ? __kasan_slab_alloc+0x4e/0x90
[  657.474707]  sk_psock_skb_ingress_enqueue+0x3bf/0x510
[  657.475392]  ? __kasan_kmalloc+0xaa/0xb0
[  657.476010]  sk_psock_backlog+0x5cf/0xd70
[  657.476637]  process_one_work+0x858/0x1a20
'''

The panic originates from the assertion BUG_ON(skb_shared(skb)) in
skb_linearize(). A previous commit(see Fixes tag) introduced skb_get()
to avoid race conditions between skb operations in the backlog and skb
release in the recvmsg path. However, this caused the panic to always
occur when skb_linearize is executed.

The "--rx-strp 100000" parameter forces the RX path to use the strparser
module which aggregates data until it reaches 100KB before calling sockmap
logic. The 100KB payload exceeds MAX_MSG_FRAGS, triggering skb_linearize.

To fix this issue, just move skb_get into sk_psock_skb_ingress_enqueue.

'''
sk_psock_backlog:
    sk_psock_handle_skb
       skb_get(skb) <== we move it into 'sk_psock_skb_ingress_enqueue'
       sk_psock_skb_ingress____________
                                       ↓
                                       |
                                       | → sk_psock_skb_ingress_self
                                       |      sk_psock_skb_ingress_enqueue
sk_psock_verdict_apply_________________↑          skb_linearize
'''

Note that for verdict_apply path, the skb_get operation is unnecessary so
we add 'take_ref' param to control it's behavior.

Fixes: a454d84ee20b ("bpf, sockmap: Fix skb refcnt race after locking changes")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 9533b3e40ad7..276934673066 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -530,16 +530,22 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 					u32 off, u32 len,
 					struct sk_psock *psock,
 					struct sock *sk,
-					struct sk_msg *msg)
+					struct sk_msg *msg,
+					bool take_ref)
 {
 	int num_sge, copied;
 
+	/* skb_to_sgvec will fail when the total number of fragments in
+	 * frag_list and frags exceeds MAX_MSG_FRAGS. For example, the
+	 * caller may aggregate multiple skbs.
+	 */
 	num_sge = skb_to_sgvec(skb, msg->sg.data, off, len);
 	if (num_sge < 0) {
 		/* skb linearize may fail with ENOMEM, but lets simply try again
 		 * later if this happens. Under memory pressure we don't want to
 		 * drop the skb. We need to linearize the skb so that the mapping
 		 * in skb_to_sgvec can not error.
+		 * Note that skb_linearize requires the skb not to be shared.
 		 */
 		if (skb_linearize(skb))
 			return -EAGAIN;
@@ -556,7 +562,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	msg->sg.start = 0;
 	msg->sg.size = copied;
 	msg->sg.end = num_sge;
-	msg->skb = skb;
+	msg->skb = take_ref ? skb_get(skb) : skb;
 
 	sk_psock_queue_msg(psock, msg);
 	sk_psock_data_ready(sk, psock);
@@ -564,7 +570,7 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 }
 
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len);
+				     u32 off, u32 len, bool take_ref);
 
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 				u32 off, u32 len)
@@ -578,7 +584,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * correctly.
 	 */
 	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len);
+		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
 	msg = sk_psock_create_ingress_msg(sk, skb);
 	if (!msg)
 		return -EAGAIN;
@@ -590,7 +596,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -601,7 +607,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
  * because the skb is already accounted for here.
  */
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len)
+				     u32 off, u32 len, bool take_ref)
 {
 	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
@@ -610,7 +616,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	if (unlikely(!msg))
 		return -EAGAIN;
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg);
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		kfree(msg);
 	return err;
@@ -619,18 +625,13 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
-	int err = 0;
-
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	skb_get(skb);
-	err = sk_psock_skb_ingress(psock, skb, off, len);
-	if (err < 0)
-		kfree_skb(skb);
-	return err;
+
+	return sk_psock_skb_ingress(psock, skb, off, len);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1019,7 +1020,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len);
+			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.47.1


