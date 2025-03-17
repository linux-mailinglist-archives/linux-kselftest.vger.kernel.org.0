Return-Path: <linux-kselftest+bounces-29188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065AAA6471F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9247B171F78
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A7224245;
	Mon, 17 Mar 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Th86mNXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463D21D3DF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203405; cv=none; b=XQIG1PhMqkX1HbVkC07b35Ae7gXKHUu6+l+IRniZJq5ZEHm5wYtLs2JMYiRJY9fr9LJgjBZU9Pgg1AMCcojo8YAnAEWUhYmDyrQGKbhetSXk9jP+Gbjw6ZAKxAL9XIlaTm7QPRAy/w2XZhDWm8/wr39Ou/EHtztHWeC7ydDSE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203405; c=relaxed/simple;
	bh=6JgBiaX+YiNAyHBFl6QZJTOXgWtV+CT73L6RHoPZKaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0lMNIWVGiV/UFerWbcchIw8B4vPW/Uwqf2dFtvJsTGgDMvZ9SYyoYMHyqaB/LKj8M3jK3Mh9FIIk/sGCRF+E4ClEFyOj0BDc7gOOiPpKn8X5Z9K+aannR4aOdrfIOFmS47VLEMEQpvW50Eux6iz8NpY+oNvfkLeNaIaC87x+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Th86mNXH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742203399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jY9iTq55Bd81F/t9jTpUlZx7Lhi6BVyEt5CYE9tdNEM=;
	b=Th86mNXHVl3dV9nxq4XXPI0UxKZYLME9Wy3byKkHN3Gn+asUAJbY7IJFHJdoHcVIbioj3S
	bf6Bqc4hbqEkakxKTjoMM2u3pnwDknpxEy8awjdRYv7YJOtIMwvrwyDw2V5hl/w1aJg0uV
	n2bQDW2G8vl8FQ+f3O9quMxgGDYJpWg=
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket after free when sending
Date: Mon, 17 Mar 2025 17:22:54 +0800
Message-ID: <20250317092257.68760-2-jiayuan.chen@linux.dev>
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

The sk->sk_socket is not locked or referenced, and during the call to
skb_send_sock(), there is a race condition with the release of sk_socket.
All types of sockets(tcp/udp/unix/vsock) will be affected.

Race conditions:
'''
CPU0                               CPU1
skb_send_sock
  sendmsg_unlocked
    sock_sendmsg
      sock_sendmsg_nosec
                                   close(fd):
                                     ...
                                   ops->release()
                                     sock_map_close()
                                   sk_socket->ops = NULL
                                   free(socket)
      sock->ops->sendmsg
            ^
            panic here
'''

Based on the fact that we already wait for the workqueue to finish in
sock_map_close() if psock is held, we simply increase the psock
reference count to avoid race conditions.
'''
void sock_map_close()
{
    ...
    if (likely(psock)) {
    ...
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        goto no_psock; <=== Control usually jumps here via goto
        ...
        cancel_delayed_work_sync(&psock->work); <=== not executed
        sk_psock_put(sk, psock);
        ...
}
'''

The panic I catched:
'''
Workqueue: events sk_psock_backlog
RIP: 0010:sock_sendmsg+0x21d/0x440
RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
...
Call Trace:
 <TASK>
 ? die_addr+0x40/0xa0
 ? exc_general_protection+0x14c/0x230
 ? asm_exc_general_protection+0x26/0x30
 ? sock_sendmsg+0x21d/0x440
 ? sock_sendmsg+0x3e0/0x440
 ? __pfx_sock_sendmsg+0x10/0x10
 __skb_send_sock+0x543/0xb70
 sk_psock_backlog+0x247/0xb80
...
'''

Reported-by: Michal Luczaj <mhal@rbox.co>
Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog()")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

---
Some approach I tried
1. add rcu:
   - RCU conflicts with mutex_lock in Unix socket send path.
   - Race conditions still exist when reading sk->sk_socket->ops for in
     current sock_sendmsg implementation.

2. Increased the reference of sk_socket->file:
   - If the user calls close(fd), we will do nothing because the reference
     count is not set to 0. It's unexpected.

3. Use sock_lock when calling skb_send_sock:
   - skb_send_sock itself already do the locking.
   - If we call skb_send_sock_locked instead, we have to implement
     sendmsg_locked for each protocol, which is not easy for UDP or Unix,
     as the sending process involves frequent locking and unlocking, which
     makes it challenging to isolate the locking logic.
---
 net/core/skmsg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0ddc4c718833..6101c1bb279a 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -655,6 +655,14 @@ static void sk_psock_backlog(struct work_struct *work)
 	bool ingress;
 	int ret;
 
+	/* Increment the psock refcnt to synchronize with close(fd) path in
+	 * sock_map_close(), ensuring we wait for backlog thread completion
+	 * before sk_socket freed. If refcnt increment fails, it indicates
+	 * sock_map_close() completed with sk_socket potentially already freed.
+	 */
+	if (!sk_psock_get(psock->sk))
+		return;
+
 	mutex_lock(&psock->work_mutex);
 	if (unlikely(state->len)) {
 		len = state->len;
@@ -702,6 +710,7 @@ static void sk_psock_backlog(struct work_struct *work)
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
+	sk_psock_put(psock->sk, psock);
 }
 
 struct sk_psock *sk_psock_init(struct sock *sk, int node)
-- 
2.47.1


