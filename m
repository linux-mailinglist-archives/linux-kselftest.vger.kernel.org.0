Return-Path: <linux-kselftest+bounces-47204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D90CA8F68
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED86306222B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 18:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B1638E5F7;
	Fri,  5 Dec 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KACfQyHf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD838E5E7;
	Fri,  5 Dec 2025 18:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960942; cv=none; b=olNCERjfKGMAE6vljM3Jg92zPY28mUzH+wtazI0yjQKaSklBpP/3pBlHttheSwxXy8aFVdHAf5NHipA9YHDxScWLbxv9p3cOs2DKA2QIEvEuFmiUNXKg342AoqWN45DLBgIFOgk0q71zlA9k0gornwKFymWCgMzEV5C94P2vS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960942; c=relaxed/simple;
	bh=gi2Av8q3in3QzwEL8x3SFmn1RHNiRmW/7BBWqhhGYtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HyHHwjBDFvlKheQOgs9S/6UCAR2eRPiuZIbrff36dxLLuhbOo6VxBAQ5oRCW89JaHXJGTelWGRMTfd/CfOoWfu2I2wba5LRQExCbaFV0jDh/2H/sAXGaHR/YRsX1W4g8ss9v6Ph/UGfJZCXsMIB5c6qdmTbDxPVr9uzHEF1MALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KACfQyHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C91EC116B1;
	Fri,  5 Dec 2025 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764960942;
	bh=gi2Av8q3in3QzwEL8x3SFmn1RHNiRmW/7BBWqhhGYtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KACfQyHf7ghJMFg28DBHWF9/CKcMdubF5ZTiZT8DlfL2ws14WclLtta2K5ML0Ssxx
	 LWhTTtfnMEilow1w7b0OOFfxwVZ4TfidSPk9e+2clUbdKXgyLcyAGk8l+vkb+fxeFe
	 zLW+B3ng10Ywg/A7z6cjPlOZy/eTDf8FGKtdlzy6y4HLrYyn1sPowltXzdSKV3XEiu
	 U1kem8PIYihFIZvoxEuzEJ95/JSsFhpZhoBTI8neasB6hap6l/Pwm82wF2dU1BHxuk
	 DW0B0EfZ++gnZPYNHQiyoKDUfFIfIm9xhhuG7e+1c5Ye04Hb9q/6PSR7DKPZdTIgAU
	 qsfV5lf6HrMWg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Dec 2025 19:55:17 +0100
Subject: [PATCH net 4/4] mptcp: avoid deadlock on fallback while
 reinjecting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-4-9e4781a6c1b8@kernel.org>
References: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
In-Reply-To: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4072; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zSolF7dynwE7ZM3RMnnQOzle4tFTXVJK06AkU0eCkGY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKNteb9dtvzUmOWzqLpv8/O+6QhtiTx/tKr++Vktvn/l
 zosL5F0uKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAijTKMDC8yb5z+paBepMj0
 3/rAgoarU9dEuivsjZ+3uuf1n3dZexMY/mlxvHyav+L64cDUsAMLDmiV7sywOvb99fubjqvaz0y
 K1mcAAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Jakub reported an MPTCP deadlock at fallback time:

 WARNING: possible recursive locking detected
 6.18.0-rc7-virtme #1 Not tainted
 --------------------------------------------
 mptcp_connect/20858 is trying to acquire lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_try_fallback+0xd8/0x280

 but task is already holding lock:
 ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&msk->fallback_lock);
   lock(&msk->fallback_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 3 locks held by mptcp_connect/20858:
  #0: ff1100001da18290 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0x114/0x1bc0
  #1: ff1100001db40fd0 (k-sk_lock-AF_INET#2){+.+.}-{0:0}, at: __mptcp_retrans+0x2cb/0xaa0
  #2: ff1100001da18b60 (&msk->fallback_lock){+.-.}-{3:3}, at: __mptcp_retrans+0x352/0xaa0

 stack backtrace:
 CPU: 0 UID: 0 PID: 20858 Comm: mptcp_connect Not tainted 6.18.0-rc7-virtme #1 PREEMPT(full)
 Hardware name: Bochs, BIOS Bochs 01/01/2011
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6f/0xa0
  print_deadlock_bug.cold+0xc0/0xcd
  validate_chain+0x2ff/0x5f0
  __lock_acquire+0x34c/0x740
  lock_acquire.part.0+0xbc/0x260
  _raw_spin_lock_bh+0x38/0x50
  __mptcp_try_fallback+0xd8/0x280
  mptcp_sendmsg_frag+0x16c2/0x3050
  __mptcp_retrans+0x421/0xaa0
  mptcp_release_cb+0x5aa/0xa70
  release_sock+0xab/0x1d0
  mptcp_sendmsg+0xd5b/0x1bc0
  sock_write_iter+0x281/0x4d0
  new_sync_write+0x3c5/0x6f0
  vfs_write+0x65e/0xbb0
  ksys_write+0x17e/0x200
  do_syscall_64+0xbb/0xfd0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7fa5627cbc5e
 Code: 4d 89 d8 e8 14 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
 RSP: 002b:00007fff1fe14700 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa5627cbc5e
 RDX: 0000000000001f9c RSI: 00007fff1fe16984 RDI: 0000000000000005
 RBP: 00007fff1fe14710 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000202 R12: 00007fff1fe16920
 R13: 0000000000002000 R14: 0000000000001f9c R15: 0000000000001f9c

The packet scheduler could attempt a reinjection after receiving an
MP_FAIL and before the infinite map has been transmitted, causing a
deadlock since MPTCP needs to do the reinjection atomically from WRT
fallback.

Address the issue explicitly avoiding the reinjection in the critical
scenario. Note that this is the only fallback critical section that
could potentially send packets and hit the double-lock.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/mptcp-dbg/results/412720/1-mptcp-join-sh/stderr
Fixes: f8a1d9b18c5e ("mptcp: make fallback action and fallback decision atomic")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8a7f7029164..9b1fafd87cb9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2769,10 +2769,13 @@ static void __mptcp_retrans(struct sock *sk)
 
 			/*
 			 * make the whole retrans decision, xmit, disallow
-			 * fallback atomic
+			 * fallback atomic, note that we can't retrans even
+			 * when an infinite fallback is in progress, i.e. new
+			 * subflows are disallowed.
 			 */
 			spin_lock_bh(&msk->fallback_lock);
-			if (__mptcp_check_fallback(msk)) {
+			if (__mptcp_check_fallback(msk) ||
+			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
 				goto clear_scheduled;

-- 
2.51.0


