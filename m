Return-Path: <linux-kselftest+bounces-5348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D979861760
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A8B25764
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9E91272C4;
	Fri, 23 Feb 2024 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpKeJBT6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF18526D;
	Fri, 23 Feb 2024 16:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704883; cv=none; b=SoWQ12fW1JvW/KWYLtfN1xXVTFFJ8QUXs3gLUEQHfbsjrQXgj/AUhavcIOj0dOlR+Gz7A9vAehvBjHT+56P1EIeycKAbkyJ4gPiu/VDdx6nio7FXy0ALJ5A/057wqxfoHmSEv9yZyZiCw/VnalTyg9luNhGg/Qb3zRLbx954h+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704883; c=relaxed/simple;
	bh=qISUZKplFPWYmLkdmI1gLlKsQvehUGqkZjUJuQ2PWWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmuZECMDvROUniagG/prmT6jdeqlFsGDVgWLLo6XLGsBhtCTJKQsr7T0GlyvzSGnVlgZUQeAjcLzA1i4CNVaDdCJ+6LD5uxm8eMJzrFuW4pgFjBBS1DiQoG8NlrujJ65g45md+5GXPtsaFXm6YpNLtBpDZYLnPeKdFOf9WE4vl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpKeJBT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BC4C43390;
	Fri, 23 Feb 2024 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704882;
	bh=qISUZKplFPWYmLkdmI1gLlKsQvehUGqkZjUJuQ2PWWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lpKeJBT6k+vV5p9rMNOt9vObKqfXrazOQ431ipCowoLrfa7CVukqhilijvPWQG2xi
	 jsg829/alLeqOm+3DN512ZTZKc5Krw8z3M6oZi2FooZrsYI96xOcqMaVwP9bAz3q0E
	 XK/7MD5maKStTI6NYdA3QNuYWubUzrq8M0ghuLs7ah10bncZ2jSPEjdvwjVj5kAV5S
	 PjMOEDj3ZfJXvcEnGEqV7da4mCF/wCQfICi1jgqNZcCDhclANSZ69HIqUzRWWnShTt
	 AUHm2elH5ys0JycPnWbjxBQSIciq9qGtT/wpP1JjwH7noLfsCZUe0/btayU+H2Dgae
	 EYMS2xyrJ74CQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:11 +0100
Subject: [PATCH net 01/10] mptcp: map v4 address to v6 when destroying
 subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-1-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=R+BQBUEWiM2ym//t1ZB6xXS8N8caCdeWbnoDwiPCfe4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqwKTdW3PskIYPe7YlyeUTOtATAmZlVGcwi
 6E30zx0XAmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c+uED/9eaB4gK4ZdGVN/ncv+ZTHQGFKZc8N5XfdpyCBQ7NySR9oJDseOFt0HeXKHsP209jWimRf
 awMCdYlcq/LHrQEWj7VtM7FoTxN5ddBcncCUoocl8y2xdnlx4I8wnw4Qyj7dcEZAZaov4CIZPwh
 ufGDCMQ2Oxelnq6Q/04157J4I+pNLLw7Pcs29qG5LLvRgy9HoE/eMS1EiFT4tMxOYkIeaValWwx
 L05c4WmSzqvbv5djX0YS3oSjCzSyV2bKvE0AglN74c+2SwOWh8TDvpkRmdOfEhTcjYvTjA87UR1
 hmfHBVdNxNq9gEXzO+lSPu2H6ZWSzHSOGyhzJOZVkRvzyt2nTXOrA2VLY5bSIj8fp3euwLHieV2
 1QEumN/7GjmjfxoT3L7rCCAWK9TTD10H+e1Tc8fo+ilAU2igODZ2oJ+P2ypi5sX+Du/JqgcJLeC
 rA6LeKFMDDS1vKm540vUESZ5R17q+3+TPDG5FufdSiBcMVhgBctFpTaM+iLhNpyOjfqQuZlrCOy
 dy21Hsc/8kRzgUlbANDYv181i+GAMR+8a5SuP5dFrcFi4OoSCeXA2rRiPBmyxIqcW1G6WtRxYmb
 0Zk5skwre+t3qr0Bb3wD/okVf06rybE1Vxc0JmnA9WBUWlstnUZLMGzZBmaZhOCZ+dkhQzNOFdP
 KMvH74pTCriQOjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Address family of server side mismatches with that of client side, like
in "userspace pm add & remove address" test:

    userspace_pm_add_addr $ns1 10.0.2.1 10
    userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED

That's because on the server side, the family is set to AF_INET6 and the
v4 address is mapped in a v6 one.

This patch fixes this issue. In mptcp_pm_nl_subflow_destroy_doit(), before
checking local address family with remote address family, map an IPv4
address to an IPv6 address if the pair is a v4-mapped address.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d396a5973429..bc97cc30f013 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -495,6 +495,16 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	if (addr_l.family == AF_INET && ipv6_addr_v4mapped(&addr_r.addr6)) {
+		ipv6_addr_set_v4mapped(addr_l.addr.s_addr, &addr_l.addr6);
+		addr_l.family = AF_INET6;
+	}
+	if (addr_r.family == AF_INET && ipv6_addr_v4mapped(&addr_l.addr6)) {
+		ipv6_addr_set_v4mapped(addr_r.addr.s_addr, &addr_r.addr6);
+		addr_r.family = AF_INET6;
+	}
+#endif
 	if (addr_l.family != addr_r.family) {
 		GENL_SET_ERR_MSG(info, "address families do not match");
 		err = -EINVAL;

-- 
2.43.0


