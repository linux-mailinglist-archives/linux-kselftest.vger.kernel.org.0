Return-Path: <linux-kselftest+bounces-29190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EBA6472F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559ED188DE9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500232222B2;
	Mon, 17 Mar 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjeZM4wm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF6221F17
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203412; cv=none; b=EnR89Vc4ClnacGGo80bqcSHFtderje7QxnFM/kYc5G7n2VeihzvQViX2XeL6ccVDP/Jm15H9GOczKQca53L2cwl2n89LNJw7J0DoIRttYV+GhWUCQZEgyqWvEeyfA+xKeBDa0OIX2ca4CahcuYAflPj8JCS/nud5hod6Qoy9FiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203412; c=relaxed/simple;
	bh=ZIX3geUdBSeJYpNGzQADiA9T7cBZmrvzoLXT/2FyWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYpMw8EDaD0q2FlfdxlS8YoWYn7cz1YHHq3JY6yXwwG1z3FAg70JjX9d5I6B1cKNDmw3cOpI46pXlDpnqY0aJyDvQ3VC2nSL/eyeCTjmjy11GnNVYfgyE9/a2VNS1X408txwrVo1rp1/4jZv0ssOZpntuZZ56DPst8mtA3tHEaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjeZM4wm; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742203408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdwQIuLJzVvoXmm2B8tL+Siu69JpG95Yy4OLKWooBQA=;
	b=kjeZM4wmaAXTcUfazsjza9u4rHM+R+vbSP+IntEAgmWUMWpxLnLT1Gb9BFg9iGW1tCV4AC
	dMChDBqgXiaCabRuKNzN6muJoubLdZYMtSM1c4ezMPVXBFMYdVpppJqYQ4oq1URlQJUP0S
	fkKQR2eOiJLoPwDXWoSgwwZ0bR3s0Dk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
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
	martin.lau@linux.dev,
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
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v3 2/3] bpf, sockmap: avoid using sk_socket after free when reading
Date: Mon, 17 Mar 2025 17:22:55 +0800
Message-ID: <20250317092257.68760-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250317092257.68760-1-jiayuan.chen@linux.dev>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are potential concurrency issues, as shown below.
'''
CPU0                               CPU1
sk_psock_verdict_data_ready:
  socket *sock = sk->sk_socket
  if (!sock) return
                                   close(fd):
                                     ...
                                     ops->release()
  if (!sock->ops) return
                                     sock->ops = NULL
                                     rcu_call(sock)
                                     free(sock)
  READ_ONCE(sock->ops)
  ^
  use 'sock' after free
'''

RCU is not applicable to Unix sockets read path, because the Unix socket
implementation itself assumes it's always in process context and heavily
uses mutex_lock, so, we can't call read_skb within rcu lock.

Incrementing the psock reference count would not help either, since
sock_map_close() does not wait for data_ready() to complete its execution.

While we don't utilize sk_socket here, implementing read_skb at the sock
layer instead of socket layer might be architecturally preferable ?
However, deferring this optimization as current fix adequately addresses
the immediate issue.

Fixes: c63829182c37 ("af_unix: Implement ->psock_update_sk_prot()")
Reported-by: syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/6734c033.050a0220.2a2fcc.0015.GAE@google.com/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/skmsg.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6101c1bb279a..5e913b62929e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1231,17 +1231,24 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
-	struct socket *sock = sk->sk_socket;
+	struct socket *sock;
 	const struct proto_ops *ops;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
-	if (unlikely(!sock))
+	rcu_read_lock();
+	sock = sk->sk_socket;
+	if (unlikely(!sock)) {
+		rcu_read_unlock();
 		return;
+	}
 	ops = READ_ONCE(sock->ops);
-	if (!ops || !ops->read_skb)
+	if (!ops || !ops->read_skb) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
 		struct sk_psock *psock;
-- 
2.47.1


