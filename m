Return-Path: <linux-kselftest+bounces-29049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA4A614A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B7B175D68
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE0201261;
	Fri, 14 Mar 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="VXFF4YHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8591EEA5D;
	Fri, 14 Mar 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965642; cv=none; b=Ta8Qwn0E6rtT3CAdW1XQMoGO/VQmZyxRaw1z8VptKtW4S0xez0u00nkadIj/STKjJ0cveY/JzMCLJpIuRqDdfooiV7GZvA+Y6WChmwi0w0mO+pw0K5CZ1P+9Wft2r3DJMATh6IwprNWpAue6bvk6hYjK0HQGla4Du7696xl1ohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965642; c=relaxed/simple;
	bh=3tj+sd1hBSK0PpyiKGpyyTMF/4GJvPBwbGnV9vwWXd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZtRToDUAPzjDlzPuQe2aB6v1xgkRqFY964T54Dg0xR7ZB+zzSIFRVJPWjegvyeQF7BB1EjO1noKISMsOKD3rjVASCb8xfWAzFiwfsVTSIzCKEy2sR6HSeae3LrW8DZXBeVR7T4+uPWZXL5hID8R/NQ/TigCLMsjmxX7BfW1A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=VXFF4YHs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pn-006FJJ-Vi; Fri, 14 Mar 2025 16:20:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=bxiMFSV63H5IMVOHX04yoU+77ubhpH+TthNc1KSiRUY=; b=VXFF4YHsPf/F2L9RPz6BsmOqCg
	ZBXqGNMUIZ10SC7ZxmBvwuF6rw8T2lenLcPua1cLGXs4HefKkJYE7hgMJNVQd4ueL8QIx6yOOLHgp
	1YlhI4/j7SV9dsEZCNJxCXFWImRT/ZA7AqSHLvEkfj4eqetrf4eDiFK5zX8FUalnmAl9HAx+MPpZV
	4wfsMxZJ2xkx9PBsgatTBya0qaF5jusgOxwtlzPEVq6FjzkXmMYSvV4ZEiTD1BeNCbdS7TvL3WCmq
	vRgrsqog+eKzf+ehnoHLTwCaylyQs0yDv7kuKbVC3mEhKFse9JiPQ2TQIBkqvqZEbwbd5Y0VXIHXz
	zUvswQSQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tt6pl-0004NT-6i; Fri, 14 Mar 2025 16:20:25 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tt6pa-00H06E-U6; Fri, 14 Mar 2025 16:20:15 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 14 Mar 2025 16:19:34 +0100
Subject: [PATCH net v2 1/3] vsock/bpf: Fix EINTR connect() racing sockmap
 update
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-vsock-trans-signal-race-v2-1-421a41f60f42@rbox.co>
References: <20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co>
In-Reply-To: <20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co>
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


