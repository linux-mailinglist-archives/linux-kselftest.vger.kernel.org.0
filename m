Return-Path: <linux-kselftest+bounces-29199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CBA64834
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1922F168C2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9EF231CAE;
	Mon, 17 Mar 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HhbaFGun"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564A230272;
	Mon, 17 Mar 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205183; cv=none; b=Z1s+7lJwsRXZInGYQ2Kp4R+SFrtBmaz+B5OVTIz7nJllEW/J4TOnvO1+nQjxtZc2EwPK+u0+mDM+mcXdflTsD1rrGESe1DjJLG7ryja02lOrV5XpODBCCqcJebGOjD46d+A533sqpx8UFYcr4lRKpIdzJ1DrDFHim/bvGpJiubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205183; c=relaxed/simple;
	bh=3tj+sd1hBSK0PpyiKGpyyTMF/4GJvPBwbGnV9vwWXd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orr2OZ9L8PWvJxhAddnmSkiADZ3W/W1rZyxQc5eDSrwn33TGsWbeU+hhtqoN97UO0UcuiL/CW5tuwSg7HEEJtwsb1PDQWSdGfvd1o6cNIu7/47BkcT69poEFFD6TheOrs9RuVcJ4+j6a7YxZSWYi+oaoaYXG5lXWZ+UDmx0x9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HhbaFGun; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tu79W-00Dmy8-8L; Mon, 17 Mar 2025 10:52:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bxiMFSV63H5IMVOHX04yoU+77ubhpH+TthNc1KSiRUY=; b=HhbaFGun6t3z7GgB0kuVz5pl4F
	222dyubEa2BnbPJCZ6HOTiIf2rmBp7eTUz8X3Yc96PXpUshypqtNg+gO6qGDy8kZkg8eKzlqBKokp
	IaWOGZCNMKBnXKGd+MMqZ5AutUXXXf/BexI6Iiuz29YxajHJw7dNtJl+Q2sI1iuiKaS9ynzWVJFRH
	FNEnktz5u1Qn0l1VmS+cwNoZH0jVTl44B0Nr1XU8aITiQdw3xmp3vtGwE7l4uglDQz/l1885DU6jA
	iKu1XagdqCDIPf/44MER5G/G/pUK/K/AkvwCQHsBGmsBpANZX9iGyTdCAyQU8qin+vX9MWDeukYvz
	gu2BYcnQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tu79Q-0007ox-7D; Mon, 17 Mar 2025 10:52:52 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tu796-00DI8D-4b; Mon, 17 Mar 2025 10:52:32 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 17 Mar 2025 10:52:23 +0100
Subject: [PATCH net v4 1/3] vsock/bpf: Fix EINTR connect() racing sockmap
 update
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vsock-trans-signal-race-v4-1-fc8837f3f1d4@rbox.co>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
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

Signal delivery during connect() may result in a disconnect of an already
TCP_ESTABLISHED socket. Problem is that such established socket might have
been placed in a sockmap before the connection was closed. We end up with a
SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
reassign (unconnected) vsock's transport to NULL, breaks the sockmap
contract. As manifested by WARN_ON_ONCE.

connect
  / state = SS_CONNECTED /
                                sock_map_update_elem
  if signal_pending
    state = SS_UNCONNECTED

connect
  transport = NULL
                                vsock_bpf_recvmsg
                                  WARN_ON_ONCE(!vsk->transport)

Ensure the socket does not stay in sockmap.

WARNING: CPU: 8 PID: 1228 at net/vmw_vsock/vsock_bpf.c:97 vsock_bpf_recvmsg+0xb43/0xe00
CPU: 8 UID: 0 PID: 1228 Comm: a.out Not tainted 6.14.0-rc5+
RIP: 0010:vsock_bpf_recvmsg+0xb43/0xe00
 sock_recvmsg+0x1b2/0x220
 __sys_recvfrom+0x190/0x270
 __x64_sys_recvfrom+0xdc/0x1b0
 do_syscall_64+0x93/0x1b0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c  | 10 +++++++++-
 net/vmw_vsock/vsock_bpf.c |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 7e3db87ae4333cf63327ec105ca99253569bb9fe..81b1b8e9c946a646778367ab78ca180cef75ef72 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1579,7 +1579,15 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				/* Might have raced with a sockmap update. */
+				if (sk->sk_prot->unhash)
+					sk->sk_prot->unhash(sk);
+
+				sk->sk_state = TCP_CLOSING;
+			} else {
+				sk->sk_state = TCP_CLOSE;
+			}
 			sock->state = SS_UNCONNECTED;
 			vsock_transport_cancel_pkt(vsk);
 			vsock_remove_connected(vsk);
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 07b96d56f3a577af71021b1b8132743554996c4f..c68fdaf09046b68254dac3ea70ffbe73dfa45cef 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -127,6 +127,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
 {
 	*prot        = *base;
 	prot->close  = sock_map_close;
+	prot->unhash = sock_map_unhash;
 	prot->recvmsg = vsock_bpf_recvmsg;
 	prot->sock_is_readable = sk_msg_is_readable;
 }

-- 
2.48.1


