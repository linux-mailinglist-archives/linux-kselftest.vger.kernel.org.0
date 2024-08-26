Return-Path: <linux-kselftest+bounces-16299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBD95F5CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1F21C221D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49945198A28;
	Mon, 26 Aug 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEE/efo4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AA194131;
	Mon, 26 Aug 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687981; cv=none; b=dbieSODQpPBsIxH5rKYej2uSZrV1dJP6u2kaO1affVxSzm/O9lWes+oKDqry3kqNXZgH37RN306XTqbL5mAFhM4x5pAmRz3eSJnJZP9HmXcfVqrZ8KdWk5SCFfiRdAkJW6dATj/y5tZnybKcZoBdgsjKNc4t4E8rRCUNL2yhM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687981; c=relaxed/simple;
	bh=vEBrXWE8EKUMVAFWC8MYLR3HoWGf3JejB4BAD7km5GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RR4CBR4BM7hPZ3Fx3Gadc+AsCa3Ak7nuNkNR2cULTsbSaWVM5FYi2EYKFa0iJ0FxfqTuyAlTEOQheb3GpxMDOKFemUKO+Ivmgtt3N6i7uqMTssYn7iTn6g6cPKukLkKmLoH/MyvuzFplFuJzlPFe7e6hJpXDcA7/hBnLoPoem6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEE/efo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C29C4DDF5;
	Mon, 26 Aug 2024 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687980;
	bh=vEBrXWE8EKUMVAFWC8MYLR3HoWGf3JejB4BAD7km5GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rEE/efo4rY8vccZrPNXKtxd9bWFBxMbGTdzw/NIuCaUK+J0xDMz+nVkP+gSnFJzXL
	 U1uDvP27IQ32G4A573rwbQxaaGhyuIwKE7BP1t4dfFnORGFTLUyFsNhNwzTp36oSUw
	 K0vJt27nO4dpXy1t0hiD0WGhV9If12qiFDc3xaNO8m9nfAeFjp2CB59S36m5kmy6KT
	 Jh+6x13KUJmTJm5ceKBc+ukqoG5ExQ6Tw1KDG6BHBLpsXzaRnBGeexcDusgPo0ow7K
	 R5duSb+hs0IVG7ooCEaWcDfB5NQhH4gYP/OK8fEh1oXXydkg8hUlZ3+MEerNL18hDo
	 yrjYOulZvfC8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:04 +0200
Subject: [PATCH net 05/15] mptcp: pm: skip connecting to already
 established sf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-5-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vEBrXWE8EKUMVAFWC8MYLR3HoWGf3JejB4BAD7km5GM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZWnYZ9Qx4kGIZpWYM2bgh5lSKBBU3bXhpVN
 SdAItDEIQOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c7kgD/4ojGfdWC2HTrt4TM4MofdNGWyG5KbJ/Y/Kg6jI5dEt2nFGX44Vb1HHrfhRcmZZjQ74f2a
 bjT7jYPRR4I09X5yoY4NB9gCfOgA7J3MiOKLt6BKOq2I2mTuMT5AeCLpQIGETh4C3X6nbupK1SA
 kLZLVE1ApXOQ0gq2LUZciI/xE0xjNGK1GKxFap/tPETMtQPXfsXyAdp/UETV6OuB275VY5rZld5
 Tflvn/OAztDSKOOsdQ8o3UM+C1YK7C6K3zNRyhPn1c4lZFqWUr1jvnFyB7+kJa/2ZF2OA1ZFKd5
 +ktsX217dN1hn0bWRH1CCCcsH1VqG/b9D49VW63Lhqw+g6vZUySglTa1O4WTJGQED2BIMpx+gmO
 UqjesTvBtaP4qDiu3IHs/pnOcrb9DQMg/pR3uDtRY0lma2wShRH07KvzzTmFulOpNqb9/uXAwuT
 Ax8/jBotQpzfHQTKDO4ifaQaBElpA7eeiHQ5s7wPv+eU4GV/hBuQYUpC0KD6hfK9nXY14T67zvQ
 7IEMJWbJTNhObAq9aEg4LhWK4rm5Cl7YFobGbdKv8PtJV1ER/c/HWklsRvbS5rhBU9t5HvIS98D
 oeD8y7VmCGaOog97KEfNu1e6DqgoOnxdAeHs087Ubn3yIOzrmYqVekKeg6AyHTXe6jCwO/G4fpf
 LNq+J7ld1Nm21vQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 380647f7bc33..0c91d961f51f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -130,12 +130,15 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}

-- 
2.45.2


