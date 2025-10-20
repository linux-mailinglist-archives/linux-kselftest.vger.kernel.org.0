Return-Path: <linux-kselftest+bounces-43534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC9BEF65B
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 607824E3F09
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AF12D47F4;
	Mon, 20 Oct 2025 06:05:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44582D3EDC;
	Mon, 20 Oct 2025 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940339; cv=none; b=DcnOWWdPgzq2K5maORabxmMRup153Ry8DnnSz8mnjsTdBVpniRQvFsCxbaDk7NZ2jKhPJ5hhoMq4HvkcJhuuKDlPcQH/L77xp3vHHqdeZvGO4w38Q3lj3qDWt8rZ3+uzhPDu8G2sBO6xJJcfDJZE//IDfOkxsxtjrjGBfpca/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940339; c=relaxed/simple;
	bh=wOT6h+q2tGnXhzAHQDRiFl1tUNRdxcZKG9i9n5PwGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsrXxnk5vriHLxrJ0gEuDZbuFjJ4KRZALEpdLH8ME2QoAaelRs4j9QDCblM5hJlSl92DOXtKgAYSdUN77LaQQm2YzpVGNpBKvSZfT0RZNaoS3dgcedsP5HDfURhxlmvBxBdiIdcAnW0fj78uKhRbxVHm4yb9F8yg3wpPZhdZwE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 077568B2A58; Mon, 20 Oct 2025 14:05:30 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
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
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2 1/3] net,mptcp: fix incorrect IPv4/IPv6 fallback detection with BPF Sockmap
Date: Mon, 20 Oct 2025 14:04:46 +0800
Message-ID: <20251020060503.325369-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020060503.325369-1-jiayuan.chen@linux.dev>
References: <20251020060503.325369-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the server has MPTCP enabled but receives a non-MP-capable request
from a client, it calls mptcp_fallback_tcp_ops().

Since non-MPTCP connections are allowed to use sockmap, which replaces
sk->sk_prot, using sk->sk_prot to determine the IP version in
mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
incorrect ops to sk->sk_socket->ops.

Additionally, when BPF Sockmap modifies the protocol handlers, the
original WARN_ON_ONCE(sk->sk_prot != &tcp_prot) check would falsely
trigger warnings.

Fix this by using the more stable sk_family to distinguish between IPv4
and IPv6 connections, ensuring correct fallback protocol operations are
selected even when BPF Sockmap has modified the socket protocol handlers.

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..c2d1513615ae 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -61,11 +61,14 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
+	/* When BPF Sockmap is used, it replaces sk->sk_prot.
+	 * Using sk_family is a reliable way to determine the IP version.
+	 */
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_prot == &tcpv6_prot)
+	if (sk->sk_family == AF_INET6)
 		return &inet6_stream_ops;
 #endif
-	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	WARN_ON_ONCE(sk->sk_family != AF_INET);
 	return &inet_stream_ops;
 }
 
-- 
2.43.0


