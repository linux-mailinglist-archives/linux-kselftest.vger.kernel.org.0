Return-Path: <linux-kselftest+bounces-43533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD8BEF660
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 08:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BC13B0C9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D6A2D2388;
	Mon, 20 Oct 2025 06:05:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4931F2BE639;
	Mon, 20 Oct 2025 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940336; cv=none; b=BUMvIgn5LkE5C/IrYIGFkfnaCwLOgNk4ueYodlw2godPJrVtfrfxM9S+tkkpdxykTkJf92bWyqXVcBjuKf8ipqTAuf1veOQcncJ7cZaPCVU4Cn2foyopGFxqpWKvQDHz0gBi+YOlHaDqruyI6kbVjZMnPSliET3QN3kJUyCdUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940336; c=relaxed/simple;
	bh=1/HqfASDzN/dipcY4CxVwURrIOHCfdF++Wl28FlaoWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSgO1dDgy9N+nZUY8Q+gOS8Sq0a+jIgZ1k9mT7lQ9j4PDvpbsvcQMowWlmBGOh0AQJvf5IIZPwk1k877kp7f8NR2I7UCpPuQr0ThKYDUQIQ09loShzTxxOC+hhG30sdV+9BYXUR414PE+qqhGPjkM5MlHs3hfXzTTrA9wzftZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 962B78B2A5B; Mon, 20 Oct 2025 14:05:33 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
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
Subject: [PATCH net v2 2/3] bpf,sockmap: disallow MPTCP sockets from sockmap updates
Date: Mon, 20 Oct 2025 14:04:47 +0800
Message-ID: <20251020060503.325369-3-jiayuan.chen@linux.dev>
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

MPTCP creates subflows for data transmission, and these sockets should not
be added to sockmap because MPTCP sets specialized data_ready handlers
that would be overridden by sockmap.

Additionally, for the parent socket of MPTCP subflows (plain TCP socket),
MPTCP sk requires specific protocol handling that conflicts with sockmap's
operation(mptcp_prot).

This patch adds proper checks to reject MPTCP subflows and their parent
sockets from being added to sockmap, while preserving compatibility with
reuseport functionality for listening MPTCP sockets.

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/sock_map.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 5947b38e4f8b..da21deb970b3 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -535,6 +535,15 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
+	if ((sk_is_tcp(sk) && sk_is_mptcp(sk)) /* subflow */ ||
+	    (sk->sk_protocol == IPPROTO_MPTCP && sk->sk_state != TCP_LISTEN)) {
+		/* Disallow MPTCP subflows and their parent socket.
+		 * However, a TCP_LISTEN MPTCP socket is permitted because
+		 * sockmap can also serve for reuseport socket selection.
+		 */
+		pr_err_once("sockmap: MPTCP sockets are not supported\n");
+		return false;
+	}
 	return !!sk->sk_prot->psock_update_sk_prot;
 }
 
-- 
2.43.0


