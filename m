Return-Path: <linux-kselftest+bounces-20251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828C79A62C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 12:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44678282378
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664B1E3784;
	Mon, 21 Oct 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAL4xlw3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407D1E6DFF;
	Mon, 21 Oct 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506338; cv=none; b=T5almVC2OQeqseUqvKT+Lt5pBC3Vi2jF7d8ypA861h0FVeSogXQ1TsTPHvhWys9QbsZF/vgYQ5GPbrbMzM7GRMx/M0Jb+yGwHDmiYt3rj1R3qoAyhRNYgFK2lNa0FEJ/EeHj2cjDHh5NZacpj7SllnxgLHTldzVVzZ5yFBTbv9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506338; c=relaxed/simple;
	bh=aujMW00Tz/LXk1VmK4UgofAwp55ujLJBpC+8bH2uZLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRdnlnPYYdyeF9Y9bUncP6ZjGxbh8V3bEf855fZ5MwmHlk/fxsACLjYESHvJn8sEfG2QMWN1+2kxoQL9N/DaDZih4670hGT9cgKEC6sVpnQ8AU+XjwcIrwIpRd+v5SEx213t7ZePIH0eMREk9GlSlOk9LD+olX5gKXLHYn0M0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAL4xlw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64107C4CEE7;
	Mon, 21 Oct 2024 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506338;
	bh=aujMW00Tz/LXk1VmK4UgofAwp55ujLJBpC+8bH2uZLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sAL4xlw3EOcFhq8Ze+1tCiMBVi7sLPPgRP/1iS/Do6PGcOZ/MEyVXW2WFShECbW2I
	 z6/w+VYIhKYX5jqbU8t2uulTQSTfNvBrTYQWjwKzdlh7DA39YHGb8iP273vBj35we4
	 29kQCw39gn2g3NkOhmwU0CJ+9Bst8Niyc0SIzsVPhgnaNWfNS8T+UPatrsriAjdlhb
	 4rDlZX1X4gYtJXsTVlC6b82JQPHr5TwZlA8W6JWzdqJfpWAIPhdFf/QDU7XNgolHT0
	 zTqAibKqyftfQYCnbITJa+BRQOGmMl0w7WdfqZBG3wpNjrX2uEniA6vIKdzesqo17X
	 zio92G+mvzBmg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 21 Oct 2024 12:25:26 +0200
Subject: [PATCH net 1/3] mptcp: init: protect sched with rcu_read_lock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-net-mptcp-sched-lock-v1-1-637759cf061c@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
In-Reply-To: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2526; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aujMW00Tz/LXk1VmK4UgofAwp55ujLJBpC+8bH2uZLw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnFiwbLMt6vd2YjKYN5i9P4fBucg+w4SoWv1ZRC
 Vms5SrTVjqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxYsGwAKCRD2t4JPQmmg
 c2WqD/0SGcwgiZbF29BgW4VQjOdnUO+2B6BXgVvAezXQTm/aMfnlAIID1UBuZUtVAQiMD2O3gP9
 Y3UO6Sf6JRJWTWczYk/sjBgt1kOHc2BPlitD1wVM82cymhXDy0jq+qZwSmS7wT0TLT49P8+AqET
 hMwJj5FNBqw9sJ3lZnnerblAy3bZVYh+n56beud5g7d2Fb4p0GiYV6IDJx/Y5FuG8fu97YOtMJ2
 H1qp61sKb8FUwDKJhOY0n0WSPNZYLoM/KNMOdOQXjesG4GgpJO3TVs80hUt4rsKFg7h6Uv3GliY
 t+m523/gaWRH8VsLlvBavTxyRez3VyfwEJjGeZBP2LMBzKRjTgj6k0I+/rlvEap8KVfWxrFhp3S
 MWiWUVn13Gpi8qJtDHn5cEI0RVrU4u6r/498Ls1e1uKNTq0vKZCnZ4Yfny0bwhuF23Yu2iVtvjE
 goT4VEKYhMTcYo8E96fKVGCjdGuwu5NnOz02JrjnKu+0Wb7LIeLgSadzkV++d7olM/BgDq8GN2Z
 pGnj8goilzglyRUfFnW0PRF3+YkW4RjcsNk7iijdCKHKh3OFyR07cbT80DIskH9vGZ0kUSXS2kN
 udSXp8pfh/v7r04EOviFPcu3lez+Nd04Nj5Dxa4kDRE4qQi4/2/E49pUoBTtyh9HgCu8xF67Dwn
 LDwE8aXPv/thfKg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Enabling CONFIG_PROVE_RCU_LIST with its dependence CONFIG_RCU_EXPERT
creates this splat when an MPTCP socket is created:

  =============================
  WARNING: suspicious RCU usage
  6.12.0-rc2+ #11 Not tainted
  -----------------------------
  net/mptcp/sched.c:44 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  no locks held by mptcp_connect/176.

  stack backtrace:
  CPU: 0 UID: 0 PID: 176 Comm: mptcp_connect Not tainted 6.12.0-rc2+ #11
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  Call Trace:
   <TASK>
   dump_stack_lvl (lib/dump_stack.c:123)
   lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
   mptcp_sched_find (net/mptcp/sched.c:44 (discriminator 7))
   mptcp_init_sock (net/mptcp/protocol.c:2867 (discriminator 1))
   ? sock_init_data_uid (arch/x86/include/asm/atomic.h:28)
   inet_create.part.0.constprop.0 (net/ipv4/af_inet.c:386)
   ? __sock_create (include/linux/rcupdate.h:347 (discriminator 1))
   __sock_create (net/socket.c:1576)
   __sys_socket (net/socket.c:1671)
   ? __pfx___sys_socket (net/socket.c:1712)
   ? do_user_addr_fault (arch/x86/mm/fault.c:1419 (discriminator 1))
   __x64_sys_socket (net/socket.c:1728)
   do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

That's because when the socket is initialised, rcu_read_lock() is not
used despite the explicit comment written above the declaration of
mptcp_sched_find() in sched.c. Adding the missing lock/unlock avoids the
warning.

Fixes: 1730b2b2c5a5 ("mptcp: add sched in mptcp_sock")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/523
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d0e201c3eb26aa6ca0ff27e5a65cb6f911012f2..d263091659e076587bc3406dfdcb4409adb3247e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2864,8 +2864,10 @@ static int mptcp_init_sock(struct sock *sk)
 	if (unlikely(!net->mib.mptcp_statistics) && !mptcp_mib_alloc(net))
 		return -ENOMEM;
 
+	rcu_read_lock();
 	ret = mptcp_init_sched(mptcp_sk(sk),
 			       mptcp_sched_find(mptcp_get_scheduler(net)));
+	rcu_read_unlock();
 	if (ret)
 		return ret;
 

-- 
2.45.2


