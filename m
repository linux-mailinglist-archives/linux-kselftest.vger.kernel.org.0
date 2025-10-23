Return-Path: <linux-kselftest+bounces-43862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 011A2C013AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FD814F61BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 12:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934C314A7B;
	Thu, 23 Oct 2025 12:55:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBE314B6B;
	Thu, 23 Oct 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224109; cv=none; b=HheaBcaN6sBWy5IwN2jp9HGIleRrB/YWWFlsPl4eZ6xRO3ZqB7zMWLBWWMZdxkbLUWb/W0YLQPOYA+2drbyac0tc3L4itxy5E4pNKF1O/EXh3AAiuT6RlejV16pS6tGEcvCxoY2Y8maHDzAAoJZWe4nfyeHwGnZAiyYmq4SBzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224109; c=relaxed/simple;
	bh=W/LmQZFaC0hZ9FJnFTGtsVB8aix+jqzlSqyvRbr2McM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVOx7MSBYoyDN0fFcnYSaDzPZY/5fKtPnEA7f0nniqcXaHekwa7GkbZD7oqF3uCE9FqOE3Ti3Q1xo7PJWN7UqguWtrJ73jNe9mYgAThiAnbQHxIGboEj+DkKF1rn2D+beqC+8jr1KwamQ2s/SqKLOLIVOYoDX45n7CFQavrPMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 8C4249291FF; Thu, 23 Oct 2025 20:55:00 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
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
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from sockmap
Date: Thu, 23 Oct 2025 20:54:33 +0800
Message-ID: <20251023125450.105859-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023125450.105859-1-jiayuan.chen@linux.dev>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPTCP creates subflows for data transmission, and these sockets should not
be added to sockmap because MPTCP sets specialized data_ready handlers
that would be overridden by sockmap.

Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
MPTCP sk requires specific protocol handling that conflicts with sockmap's
operation(mptcp_prot).

This patch adds proper checks to reject MPTCP subflows and their parent
sockets from being added to sockmap, while preserving compatibility with
reuseport functionality for listening MPTCP sockets.

We cannot add this logic to sock_map_sk_state_allowed() because the sockops
path doesn't execute this function, and the socket state coming from
sockops might be in states like SYN_RECV. So moving
sock_map_sk_state_allowed() to sock_{map,hash}_update_common() is not
appropriate. Instead, we introduce a new function to handle MPTCP checks.

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 5947b38e4f8b..5be38cdfb5cc 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -467,6 +467,27 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
+/* Disallow MPTCP subflows and their parent sockets. However, a TCP_LISTEN
+ * MPTCP socket is permitted because sockmap can also serve for reuseport
+ * socket selection.
+ */
+static inline bool sock_map_sk_type_allowed(const struct sock *sk)
+{
+	/* MPTCP subflows are not intended for data I/O by user */
+	if (sk_is_tcp(sk) && sk_is_mptcp(sk))
+		goto disallow;
+
+	/* MPTCP parents use mptcp_prot - not supported with sockmap yet */
+	if (sk->sk_protocol == IPPROTO_MPTCP && sk->sk_state != TCP_LISTEN)
+		goto disallow;
+
+	return true;
+
+disallow:
+	pr_err_once("sockmap/sockhash: MPTCP sockets are not supported\n");
+	return false;
+}
+
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
 {
@@ -482,6 +503,9 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	if (unlikely(idx >= map->max_entries))
 		return -E2BIG;
 
+	if (!sock_map_sk_type_allowed(sk))
+		return -EOPNOTSUPP;
+
 	link = sk_psock_init_link();
 	if (!link)
 		return -ENOMEM;
@@ -1003,6 +1027,9 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	if (unlikely(flags > BPF_EXIST))
 		return -EINVAL;
 
+	if (!sock_map_sk_type_allowed(sk))
+		return -EOPNOTSUPP;
+
 	link = sk_psock_init_link();
 	if (!link)
 		return -ENOMEM;
-- 
2.43.0


