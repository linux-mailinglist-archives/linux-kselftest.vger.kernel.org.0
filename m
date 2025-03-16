Return-Path: <linux-kselftest+bounces-29165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA7A637CC
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 23:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932643AD316
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 22:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B41F866A;
	Sun, 16 Mar 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="R2VSz5G1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77B1A0BDB;
	Sun, 16 Mar 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742165176; cv=none; b=TGrgRM2gJK5GtdY2ms4OnlTq09zIUdHRCySD0iSgCXKg24KlcWu8owcl62PJDJ0FltxZeCjoDT8kE1OURO5NqAbuMp8RP0Bx6OUzVTKZZlg11cVitJ8wlvhMTP22tHdxUcu8t6Q45k4vLlxrpEwrAgbBLpLvuarFdaRYnKsYrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742165176; c=relaxed/simple;
	bh=WKSI5tQo2ZCmquUaEjyal9KCtNxILWDmnnMtd21oT78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pORzolT+N4USd4RKWv+3gUIXc05BA6L/8VXKdkpilY+43M19srsOISfcxPWHmYIWc+B8/GP8iCI2W+wL8qBhTmDc92f7ECsEWH4G3kgKzcFTX9UiYG9Jq4PreVv5inkwHor0JzCdTzeRQHPEJ+nfhtRAnMJLtqLC5KMXrm7PGZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=R2VSz5G1; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1ttwkB-00Csg5-P0; Sun, 16 Mar 2025 23:46:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=Qx6Q42lUm6Tq+A/H1tasLuFXsBAYaSnDK2lri+KURPw=; b=R2VSz5G1geS1IlY9yhGry/JtS+
	jcIBvCOu0tq8IgLofQRHs/DLjNAneUf/Q/K9l0lBEpKvniVT8OPxLbZZb8xQieGrQvVohG+4J1jnU
	5qkvnKZ80va+ERUtZjt8tdCtnhsrsC4kMQWPC8NIjnzjhZpYZe96gRUbSViEbjrD0gqZrI+1ydSsm
	SgyuS711t1C0s7vL0qifdIzNAE1ihEQi0s111p3j0oiartg7K/VLMbWYsBpco+bFArKFyEwGM0R7f
	C9kPv8eYHXfVLKnHcEfU8ehbKO3X61bShgw9CWx+zOg0P7dlVYQtTyWzWoTpNlZCK1w0w/MrFT+lh
	HkI6NlFA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1ttwkB-0007hM-Ap; Sun, 16 Mar 2025 23:46:07 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1ttwjr-00AYw2-L6; Sun, 16 Mar 2025 23:45:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sun, 16 Mar 2025 23:45:08 +0100
Subject: [PATCH net v3 3/3] vsock/bpf: Fix bpf recvmsg() racing transport
 reassignment
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-vsock-trans-signal-race-v3-3-17a6862277c9@rbox.co>
References: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
In-Reply-To: <20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Signal delivery during connect() may lead to a disconnect of an already
established socket. That involves removing socket from any sockmap and
resetting state to SS_UNCONNECTED. While it correctly restores socket's
proto, a call to vsock_bpf_recvmsg() might have been already under way in
another thread. If the connect()ing thread reassigns the vsock transport to
NULL, the recvmsg()ing thread may trigger a WARN_ON_ONCE.

connect
  / state = SS_CONNECTED /
                                sock_map_update_elem
                                vsock_bpf_recvmsg
                                  psock = sk_psock_get()
  lock sk
  if signal_pending
    unhash
      sock_map_remove_links
    state = SS_UNCONNECTED
  release sk

connect
  transport = NULL
                                  lock sk
                                  WARN_ON_ONCE(!vsk->transport)

Protect recvmsg() from racing against transport reassignment. Enforce the
sockmap invariant that psock implies transport: lock socket before getting
psock.

WARNING: CPU: 9 PID: 1222 at net/vmw_vsock/vsock_bpf.c:92 vsock_bpf_recvmsg+0xb55/0xe00
CPU: 9 UID: 0 PID: 1222 Comm: a.out Not tainted 6.14.0-rc5+
RIP: 0010:vsock_bpf_recvmsg+0xb55/0xe00
 sock_recvmsg+0x1b2/0x220
 __sys_recvfrom+0x190/0x270
 __x64_sys_recvfrom+0xdc/0x1b0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/vsock_bpf.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index c68fdaf09046b68254dac3ea70ffbe73dfa45cef..5138195d91fb258d4bc09b48e80e13651d62863a 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -73,28 +73,35 @@ static int __vsock_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int
 	return err;
 }
 
-static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
-			     size_t len, int flags, int *addr_len)
+static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+			     int flags, int *addr_len)
 {
 	struct sk_psock *psock;
 	struct vsock_sock *vsk;
 	int copied;
 
+	/* Since signal delivery during connect() may reset the state of socket
+	 * that's already in a sockmap, take the lock before checking on psock.
+	 * This serializes a possible transport reassignment, protecting this
+	 * function from running with NULL transport.
+	 */
+	lock_sock(sk);
+
 	psock = sk_psock_get(sk);
-	if (unlikely(!psock))
+	if (unlikely(!psock)) {
+		release_sock(sk);
 		return __vsock_recvmsg(sk, msg, len, flags);
+	}
 
-	lock_sock(sk);
 	vsk = vsock_sk(sk);
-
 	if (WARN_ON_ONCE(!vsk->transport)) {
 		copied = -ENODEV;
 		goto out;
 	}
 
 	if (vsock_has_data(sk, psock) && sk_psock_queue_empty(psock)) {
-		release_sock(sk);
 		sk_psock_put(sk, psock);
+		release_sock(sk);
 		return __vsock_recvmsg(sk, msg, len, flags);
 	}
 
@@ -108,8 +115,8 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 		}
 
 		if (sk_psock_queue_empty(psock)) {
-			release_sock(sk);
 			sk_psock_put(sk, psock);
+			release_sock(sk);
 			return __vsock_recvmsg(sk, msg, len, flags);
 		}
 
@@ -117,8 +124,8 @@ static int vsock_bpf_recvmsg(struct sock *sk, struct msghdr *msg,
 	}
 
 out:
-	release_sock(sk);
 	sk_psock_put(sk, psock);
+	release_sock(sk);
 
 	return copied;
 }

-- 
2.48.1


