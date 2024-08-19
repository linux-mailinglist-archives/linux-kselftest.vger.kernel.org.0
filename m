Return-Path: <linux-kselftest+bounces-15710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABFA9574D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7301C23A55
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7D51E674F;
	Mon, 19 Aug 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Lpib6e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EC81E6749;
	Mon, 19 Aug 2024 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096755; cv=none; b=fzTc1mvjxedabqaZFAmaExy7ss01evdMj7/yiDioxR9YKH5vXt1cAxxOCqMTBt1+pKXfimDgosH5wy8aIKgxkePV/kRWcdf/G+sfTPoZ1H8k0KaSax9c+RNP4ppV+KGF+47hJ7PnbpHgxqAd8puTKbIb2hL3DmqVZPQVPR3MMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096755; c=relaxed/simple;
	bh=qns9EsRn0eYFNDNl9ZViOIXU6X/zqUvUuU8EAStohW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jl1W9YlIE+n7Q/v7gbAg/nlTDaQybzKzev0W7ghhpiQnadwOfTosVCUsG0nxwuZClkWXPXAKwKGnbki8820+EvWDa+eM8RCo04RQIZweTqBmNhYEDkg4CwJg6v5hpEM8EUhcFfl9NT5f1qKtPZyvtL9Pjnj2Eb7GCCFpyFlPXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Lpib6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D206FC4AF0E;
	Mon, 19 Aug 2024 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096754;
	bh=qns9EsRn0eYFNDNl9ZViOIXU6X/zqUvUuU8EAStohW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R5Lpib6exheZvA/Szqxx+7YzFdm9H+vPYBMysQWvj0MNISyLG/55E/ZzOg9ZZTaML
	 fnvGGEH3a8b1D24XotVfvJkw/59KenvV+nTNvKxZMZsx4OdUNCE7U2WoOFGYqg7xeM
	 ShEomPMYUbrfAfZHOQAuOyu0rznaaajaRGgb/EsKoi2bGftanfA3RBNHeQjFhGI761
	 gtZKQk4qakPptB3WeXZLiVPkLjtdL5lqQVAU5LU1AwUR3rN4UqZ6aNqCxmZhZ+z9PT
	 mQYLvgSA+09Aknqa/VkXVBvGi4YHp3Iw9Q03ZSjLcKVWOabQO01UQzdF+mNFWbtUoH
	 wkrJ2ETzd6Emg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:27 +0200
Subject: [PATCH net 09/14] mptcp: pm: only decrement add_addr_accepted for
 MPJ req
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-9-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qns9EsRn0eYFNDNl9ZViOIXU6X/zqUvUuU8EAStohW0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DTQJwOL+kc5QuppdYEwBVbEF/O6w5cNCyOR
 GfAFuoo/deJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0wAKCRD2t4JPQmmg
 cwZpEAC8q27zWOJ9e6lzPmZZV75sH7q3anAxuVGQIudHI87P0FFTYgSvqaj3l/dzzmRNpL+/dsy
 4ZW8TtM2zjO4Lf8CXvE1ZNttrzwzj4ORBbV387vAOJYny8IdgbaouG4AoNezVq4m74lX38hL8Ap
 R0R99etVmptlGRTlDEWRW/L6W5MJAeC6VhCm/QPWeXsCuO28kV/LZAk3RoX9F4u4LHKyYt8WfHf
 stG9v6b8RX0D5ssrZzeJdDcveCT8k0d8sUg0Q8pUE46qKfHKE8fSuW+Yeh2lvxXbUtic2VGLk8A
 9O+k1PvHT3uuh5kKBkcSFkveYZubQc8U60Pd4lqTlIG7dH9cebxdtmWEBhoZx4kmP5oWZaviqeI
 Ke4HN3X4BIBTemIBNAuCtCnb5vOl5mOKXdhYfamJ3LpR2B26uD/+7PJYBUzgjkMCNOjB52wUY1i
 dt1dDo9D8gpekWtNNfvEaro5ryUJxAlduF2bUa80lc5ESEL6YgYJDDoFQlo10CwvOFLTsmQj/Ov
 xzonERGvZeWjO/jFZp+Wzpf/ls1HMc+UqMFwRfN6uMBzrDj1hgSqxxlq6jLgsPzhodH871BLHak
 ftTWZUF3iUEZYJmVSqcJ4e1yp9u8BUQAlPzF5RHw4mop8SEvwHxlpE/pe81wn++7tQPv1RfijJi
 FuXHp/hWk1vuUxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cf7cc851f80..882781571c7b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -829,7 +829,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -843,7 +843,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		}

-- 
2.45.2


