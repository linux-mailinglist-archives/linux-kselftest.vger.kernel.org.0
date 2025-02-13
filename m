Return-Path: <linux-kselftest+bounces-26539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B9A33E9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 13:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8001A3A5527
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61584221730;
	Thu, 13 Feb 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Oeo1ZBAc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A9021D3F8
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447992; cv=none; b=O1+gaOCmQjWcgKpw9qjX+t/TEkXZdwsRqECKKw58CYS79YryrJYCg7RwAgONPULPJb2qtVG9fGWCYoYbMmAptjsXa1vSN0Bkvcd0MFOfJZP5C4PcdsoSxxrNBVJt7a9lSS5hAc92PuqBuvW7K4HRF2mJUBOZ+7JLXI5qemFAdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447992; c=relaxed/simple;
	bh=AgqMjjNbwR/rGUp16uYuuHiq7uxRpbA1lSBA5QQ6jG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYrxllqtL4nUxYy2Ixcy5bgg9WhjZP4caj3BkUuD9pxoLFMWDHxOqBSb2f810n3/ZZ9WBwdvji6KlEFhSxE1B25QSfWmL4mzI+p7/34SsJYBGkg9TmYwCDFc7LrMG6Pqs5QSjL5Ag1I9ovVbiaLlkAX0+Xb2Hkpm9vKoe9uAyjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Oeo1ZBAc; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsX-002IJG-NI; Thu, 13 Feb 2025 12:59:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=DGliLGKzq9wpcv6AZT/6cTkNf9EzA7dLex82sUHi5Xs=; b=Oeo1ZBAc7Vue4PNHWNVsdCtmAv
	7PyA7ZlTHnpirr/3vnvpakxVGdRIuJcZ6B8ctv00GR+iojzwDRivu6GPSsCrjSj6oDrRLy+ZXJUBd
	zuHveLfUBDi2MYKRat1OFknAJB5bmUGXYmVvSO0ZmxNGdgODbazthMIdY8vrSg1zSQs6nNW/6vtUa
	+pJaoye1J/wxqWMBjiDOlkUHZeICMPAMq+rqIhWfiFemVc7cXyAgpykJwXop3aAo2mUxLD3xoy9mP
	k+jV5b3XmH5rrgDcRB6eA0Y/b82lc8ksXsJ40JQ4Rd7hBgOgQZ/xazHlsapXutLdZjlT4HlwCW9WA
	zT/x/6UQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tiXsX-0004r4-7Y; Thu, 13 Feb 2025 12:59:37 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tiXsA-008u87-89; Thu, 13 Feb 2025 12:59:14 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 13 Feb 2025 12:58:49 +0100
Subject: [PATCH net 1/4] sockmap, vsock: For connectible sockets allow only
 connected
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-vsock-listen-sockmap-nullptr-v1-1-994b7cd2f16b@rbox.co>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

sockmap expects all vsocks to have a transport assigned, which is expressed
in vsock_proto::psock_update_sk_prot(). However, there is an edge case
where an unconnected (connectible) socket may lose its previously assigned
transport. This is handled with a NULL check in the vsock/BPF recv path.

Another design detail is that listening vsocks are not supposed to have any
transport assigned at all. Which implies they are not supported by the
sockmap. But this is complicated by the fact that a socket, before
switching to TCP_LISTEN, may have had some transport assigned during a
failed connect() attempt. Hence, we may end up with a listening vsock in a
sockmap, which blows up quickly:

KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
Workqueue: vsock-loopback vsock_loopback_work
RIP: 0010:vsock_read_skb+0x4b/0x90
Call Trace:
 sk_psock_verdict_data_ready+0xa4/0x2e0
 virtio_transport_recv_pkt+0x1ca8/0x2acc
 vsock_loopback_work+0x27d/0x3f0
 process_one_work+0x846/0x1420
 worker_thread+0x5b3/0xf80
 kthread+0x35a/0x700
 ret_from_fork+0x2d/0x70
 ret_from_fork_asm+0x1a/0x30

For connectible sockets, instead of relying solely on the state of
vsk->transport, tell sockmap to only allow those representing established
connections. This aligns with the behaviour for AF_INET and AF_UNIX.

Fixes: 634f1a7110b4 ("vsock: support sockmap")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index f1b9b3958792cd599efcb591742874e9b3f4a76b..2f1be9baad0578e2202b5cf79616b6e814c1ed54 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -541,6 +541,9 @@ static bool sock_map_sk_state_allowed(const struct sock *sk)
 		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);
 	if (sk_is_stream_unix(sk))
 		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
+	if (sk_is_vsock(sk) &&
+	    (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET))
+		return (1 << sk->sk_state) & TCPF_ESTABLISHED;
 	return true;
 }
 

-- 
2.48.1


