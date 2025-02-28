Return-Path: <linux-kselftest+bounces-27828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5985DA4911C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 06:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08277A48B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202681C07E2;
	Fri, 28 Feb 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gXzfah0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152451ABED9
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 05:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721911; cv=none; b=fJzLF4oQlYqkaqahpqfDubX+txk72eDDl1YW6ovnGi9BjgEIoWJP0tehoghMDHbSXKzmAX/lpUp7a7B53FFpnahEHPPi6nOaz4gUvb+TnJKdMQOPQwlntgR+HDVu/WE2Diti1981NKkc6+8FxrYqVMXogi3/SMhUBQS32DZ/lCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721911; c=relaxed/simple;
	bh=L10x6fifQRPzqh01c+WLDf50zXMUee90l371pAK+vJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8GghnxA7u8MMeLKp2/wpVk23vf4vcgvaHzLiHDUgcxBC+bFK0jG4ETamSI/SBFPQy8dcf8iQjGpIIsgYw5sFXQq+r4igXJPBoAezX28vE0uiIaXQGNp7+ZyDVezUkeurzTcuenrCHnR7ypN2KVMPqE7uxNLVg9tfZF6bCnkukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gXzfah0U; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740721907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OB8Ld2/0VIhksMpYCBBAtKClk4LHI3Iskpkbpu30qYs=;
	b=gXzfah0UkiJfm8H2w08yr7HPQDsfzhBEjWlKhG/PxvC05/MnrqRu+YGe19SU6YSgBkeEXT
	7xJrcb2hfzzG4+zQ+NrLsC7cLzZ/QDLm0WA6HBOY+bzJugpZDjyONtPyakVPbHi+RhkNef
	U69lcvrvDM1ZHzmHlT3laV66Zj1FLv0=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	martin.lau@linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mrpre@163.com,
	cong.wang@bytedance.com,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket after free
Date: Fri, 28 Feb 2025 13:51:04 +0800
Message-ID: <20250228055106.58071-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250228055106.58071-1-jiayuan.chen@linux.dev>
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use RCU lock to protect sk_socket, preventing concurrent close and release
by another thread.

Because TCP/UDP are already within a relatively large critical section:
'''
ip_local_deliver_finish
  rcu_read_lock
  ip_protocol_deliver_rcu
      tcp_rcv/udp_rcv
  rcu_read_unlock
'''

Adding rcu_read_{un}lock() at the entrance and exit of sk_data_ready
will not increase performance overhead.

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..1b71ae1d1bf5 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1222,27 +1222,35 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
+	struct socket *sock;
 	const struct proto_ops *ops;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
+	/* We need RCU to prevent the sk_socket from being released.
+	 * Especially for Unix sockets, we are currently in the process
+	 * context and do not have RCU protection.
+	 */
+	rcu_read_lock();
+	sock = sk->sk_socket;
 	if (unlikely(!sock))
-		return;
+		goto unlock;
+
 	ops = READ_ONCE(sock->ops);
 	if (!ops || !ops->read_skb)
-		return;
+		goto unlock;
+
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
 
-		rcu_read_lock();
 		psock = sk_psock(sk);
 		if (psock)
 			sk_psock_data_ready(sk, psock);
-		rcu_read_unlock();
 	}
+unlock:
+	rcu_read_unlock();
 }
 
 void sk_psock_start_verdict(struct sock *sk, struct sk_psock *psock)
-- 
2.47.1


