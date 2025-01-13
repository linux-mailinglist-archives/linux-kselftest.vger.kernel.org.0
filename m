Return-Path: <linux-kselftest+bounces-24380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3611A0BC66
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F97B3A4B05
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3BC20F081;
	Mon, 13 Jan 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqPvjrN9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624F20F078;
	Mon, 13 Jan 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783132; cv=none; b=pQFngjnt9d32CBDPAQgq7XZ5C2SGajWzjaYuU1JIXV7laRnTdUjXHfX9WwNsqc+5VoBqBegT8Z1yeail8JUCXRd/Y//HMwJfbPh+rbtVf/hp/3LJ1IO6ALqfKlF6UqP3BHkEdCRZhiL+xJAaL2E1pLHz0hPRSbqNzaPpVhW9p3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783132; c=relaxed/simple;
	bh=a4IVk6Wkvbym/FS6vrTUr8M9EE1WPv534v+LrcnmBHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRGJx/TR7/OEL/vQY5dYR1NrYE0T5l8FMeeClkpS7+iiHIGgg9q1gf68m9MzIQOvYswbWqqRg2Ui8h9JsTUqUqv2CNWNoj00OOQ4RQknzWIH87KHju8lPBxR/PHhUhHzmhWw1AApRQZ1kZQ+mUFC514pgXEFQ+dsOAhtLC2Cn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqPvjrN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C02C4CEE4;
	Mon, 13 Jan 2025 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783131;
	bh=a4IVk6Wkvbym/FS6vrTUr8M9EE1WPv534v+LrcnmBHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZqPvjrN90kkCPoKXtII1QJFD9W4udrM9DGpjt7etY3+KQflYWvGVe0gbBZ4EzxJU9
	 lGNsoVWZtEXQSYVOPV0GDBSwGdrZXA5fkb5PGLuud2/uPXTDAQDsKKSBb75yS7J6k9
	 9WUsgF/Vf4aMVoBROodIS/BVSXYynk0wZDhcZ/lOzklGTtppVqDe3LBLEF2dNj3DZG
	 Hz2AoHZG4Dpx+yM5ignElfdrbsAcTSPm3AxtvDb1saLtwHb0i9SbEXucZfRkIa6J+s
	 bOLJf9p4K3TfNV9Q1Lbt5JjKk/NuuXbigLJOzRXhUWMHXa2rMn9RHP+tG1kRN01z3d
	 rU7c6DOJAjnOA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Jan 2025 16:44:57 +0100
Subject: [PATCH net 2/3] mptcp: fix spurious wake-up on under memory
 pressure
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-net-mptcp-connect-st-flakes-v1-2-0d986ee7b1b6@kernel.org>
References: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
In-Reply-To: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=lyfNEDgNKcHqMuRGoTCOWatpy9m17ST8LWrIBkAirm4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhTUROG/XNAvrj0vkCzgAg7U9N3QgBKXggsPwy
 shsrAkmucSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4U1EQAKCRD2t4JPQmmg
 c+3TD/0ak62R+yh1/6PHMhcU4Udz4Xq0TzhebVickRTnS3Dx56we5bdIPueTt3sYS1/7J+k6pDh
 BwdBNLRouXiay9btW68q3Jxyh6HGvLJeIhaybjbfmOyUYVqg5Zc+xmPKGF4GVmwJVV26yKOYHWk
 XF4HApdpqRej9qLtpaak1hCfQ7B1cyyuqLISq9KyaYPQ+INVN8DJ8TyH1mEGA7KhNJAntqJJCh7
 yNCxgVJCMk5iIuzA9CCGqEZffR7JkV6nxXaNSPBTlWYjSXhcOVK8MkAywYPO22SnM35KVh6Z2rG
 cKBNWb97P8qZq3WKLoU8vyRLj6kKRUHfhVXSIwqzOV0IJg6hVcooztJ8RCXQ7pjzECo28DVYBsh
 JKEmlnotM3r2kF0s7YjDxtVVhP5E3H6OSWEN3hVgYRN/SylKnghhYGzGvzZu3eyDy8NFlNaxFWl
 zOczWlfzjfp+/orIvlH7PpTrNKTnsMTsRUa2Ic3Tikor5ImU8h2qww0kVG9yzvKjbejB4WsEnYi
 fFJbK4G6W+bNQ0oNb0eODIhMWKQyv990TlmRV44LuquXeuWIgL3b94ZqjLSB+JIhbn1Tk4Uer7v
 GbAPVqkMeGkPX4Va/3TYHvdkJnX9Jnw0bmDiVMeotfJ9PzVfIeZcf2sWR0j9GUMFYjJ7qD/w9Zu
 i5NaNI34U984VDg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The wake-up condition currently implemented by mptcp_epollin_ready()
is wrong, as it could mark the MPTCP socket as readable even when
no data are present and the system is under memory pressure.

Explicitly check for some data being available in the receive queue.

Fixes: 5684ab1a0eff ("mptcp: give rcvlowat some love")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c435155066ce9cc109092661f0711c..73526f1d768fcb6ba5bcf1a43eb09ed5ff9d67bf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -760,10 +760,15 @@ static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 
 static inline bool mptcp_epollin_ready(const struct sock *sk)
 {
+	u64 data_avail = mptcp_data_avail(mptcp_sk(sk));
+
+	if (!data_avail)
+		return false;
+
 	/* mptcp doesn't have to deal with small skbs in the receive queue,
-	 * at it can always coalesce them
+	 * as it can always coalesce them
 	 */
-	return (mptcp_data_avail(mptcp_sk(sk)) >= sk->sk_rcvlowat) ||
+	return (data_avail >= sk->sk_rcvlowat) ||
 	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
 		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
 	       READ_ONCE(tcp_memory_pressure);

-- 
2.47.1


