Return-Path: <linux-kselftest+bounces-30331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCA5A7F652
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895691709C3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD6825F965;
	Tue,  8 Apr 2025 07:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BChAh6Kl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1722214A68
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097504; cv=none; b=ncnyPNQ/vz024UWrGiHfFWumLO27zU+IeRp6Q4Rw41eqgg396DhpQVI1gk0FBjxRR0/xZkDHgpA2WrOlGzQVzeZrxCUU9gPZwbGRUnLm0xTPJY4j6x3PtMyKrccj+ExgVI3rqFIl8YRa56DVem8nCH39iSQo/wA0cCtM6cUsyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097504; c=relaxed/simple;
	bh=ZIX3geUdBSeJYpNGzQADiA9T7cBZmrvzoLXT/2FyWtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMaxr6zyXYosdATn54R+9VuasyiAv6MEXwl1+q9rT3BO9F0g/++50WIytpxJQo0zMpDlXtPACWKIr5W9OWtcB3ToyXE4QzSTQQAnynGGLrcZ3Oudo7FuFdCoJRXlRKuP6sF9rvgMP1hkYlZEUzF3hWbEan1DWpu5GTWu/rKyVNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BChAh6Kl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744097500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdwQIuLJzVvoXmm2B8tL+Siu69JpG95Yy4OLKWooBQA=;
	b=BChAh6Kl34/4AXehpPA3AmNsjaB/FBFmGKaplmmnvWwlFN2jsl3j/rkVb0h5QlHKaJ+8ty
	h+sAZv8gNmVb6OBln/ejuLA4lsfobOvGobz3TN6ISaF5Xyi161gxjF8OzWxXL/x8wdJ+XE
	yUKgFm71SthKI1CWAaDPvhOduIgmOTw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/3] bpf, sockmap: avoid using sk_socket after free when reading
Date: Tue,  8 Apr 2025 15:29:53 +0800
Message-ID: <20250408073033.60377-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250408073033.60377-1-jiayuan.chen@linux.dev>
References: <20250408073033.60377-1-jiayuan.chen@linux.dev>
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


