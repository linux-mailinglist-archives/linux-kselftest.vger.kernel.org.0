Return-Path: <linux-kselftest+bounces-30330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4DA7F645
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F097A841A
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 07:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD092192F4;
	Tue,  8 Apr 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bTqX62Yx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BD52638A2
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097486; cv=none; b=Q0kNMTswdk3cjZii8lyyyQ00OSKm6Lu/KuLV1QPQzubio2d8Huyo85l7VHnwnem6YPMlPOKFVtc0snjHnHmYxdYGjg7qxc8zJek7cid3Vuu40uQjgNhVmFkg+XMO2814cKXGIarVwFqxLA7PjNd8cY64WU3IPgY1x22B7/YA16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097486; c=relaxed/simple;
	bh=ijOx4M5TmyRB1moGMwzS48Der8uYaupF40vI8HiMIZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9vAhIABM8XWZTUrOCK878LPZeORn0PQvpl4Xc2Lj3TxvK1r4uAmvwKrI8m5Fow2slB1Mksgh1RCXaX0wKasegK+WAX9nA2ulsnKiFj0yyGPYcrZH2l6uC2dMxfEFZrMaflUo0vBk7M4d8joTjNGHlHHCbKUFnCCa8R2W54VNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bTqX62Yx; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744097482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRfu4euMTOXxd7QFCTCSmTUaNtflTP+Y23DjhJpsX6c=;
	b=bTqX62YxdxwAt6H4QmRrP5USg335ZC6ynbKbiM9fkOJgFymIYhrNvt+r3wE7XBj8RnEOi8
	17NfSqg3NlEaOrqcFKbUcaB0+jqVK2js+Ojm+fj6eu/66jfJgaWkKCUwnnOger6tOCHkR7
	vsDU0lX+Wf4aFtV67DYqKV0PclTC848=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
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
	Cong Wang <cong.wang@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 1/3] bpf, sockmap: avoid using sk_socket after free when sending
Date: Tue,  8 Apr 2025 15:29:52 +0800
Message-ID: <20250408073033.60377-2-jiayuan.chen@linux.dev>
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

The ref of psock become 0 after sock_map_close() executed.
'''
void sock_map_close()
{
    ...
    if (likely(psock)) {
    ...
    // !!here we remove psock and the ref of psock become 0
    sock_map_remove_links(sk, psock)
    psock = sk_psock_get(sk);
    if (unlikely(!psock))
        goto no_psock; <=== Control jumps here via goto
        ...
        cancel_delayed_work_sync(&psock->work); <=== not executed
        sk_psock_put(sk, psock);
        ...
}
'''

Based on the fact that we already wait for the workqueue to finish in
sock_map_close() if psock is held, we simply increase the psock
reference count to avoid race conditions.

With this patch, if the backlog thread is running, sock_map_close() will
wait for the backlog thread to complete and cancel all pending work.
Any pending work that hasn't started by then will fail when invoked by
sk_psock_get(), as the psock reference count have been zeroed, and
sk_psock_drop() will cancel all jobs via cancel_delayed_work_sync.

In summary, we require synchronization to coordinate the backlog thread
and close() thread.

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
   - prev discussion:
     https://lore.kernel.org/all/f2bd7e45b327d7b190edef4916d5b9e6dc83e87a@linux.dev/

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


