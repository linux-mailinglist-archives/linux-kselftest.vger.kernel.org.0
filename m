Return-Path: <linux-kselftest+bounces-7561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B446A89EF18
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1831C20E77
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CF158205;
	Wed, 10 Apr 2024 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+NwEiuU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75141581E9;
	Wed, 10 Apr 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742514; cv=none; b=KsMSNpo+Efx38e1Mz1LOdusDOlOmI5264DY4T7duBwJ9WwvUlvbbwxYT47Fb0et+ueMtHi4jXc6+Tye7e9SvO9bx2hl3bsvBotfeT9ek/KFYEXXAxBm9dwAAGGntsZkUe2PdTGnGNp359hTui3eI8dNXEKcM9Sy6bcmw67s7Blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742514; c=relaxed/simple;
	bh=DZWjKNrFDQBA/id5zOwExWShtZE5tzZCzTNUcx50z08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DXPjgbZ7lFABF9P388XZ7HaUCvDUmwI0gq/TV31oud6KaoICInpMMBzXgRni7o3EgkdthtsEOJOP2hrl1YsT3mSUHNy0EhAkLwRTUNwtVCFWROb+GmiW39/EnjvA3n5/SO/ShrDreKWuFJTnaAaLocs/6nJbMkmTBplmhZDoz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+NwEiuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC433C433B2;
	Wed, 10 Apr 2024 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742514;
	bh=DZWjKNrFDQBA/id5zOwExWShtZE5tzZCzTNUcx50z08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d+NwEiuUDEnZECKOzyrhW/9hj0/yOIlH6CxZ1AjC7A0MTvIOpsEIgLKPhPPNH+Yyg
	 P8D55eLhHfC0zQzkRO+Z00c+b9KMKhoV3ujyZTtKtofteH7AGxeSRhJdlJNCDWiFAY
	 zr2VFfbRp86cqwvjN7QZuxejcR2n8/x2R9Hy4Bhknf4LtjyeyROfTTufXVrxJOy9g8
	 7Py0zn604WEpxBuA4eT2nAjthLoZkQ0h8mS36Go+Co+uzVNG6JxXVzDOHIyTzoWzJA
	 eH5FCsbQZON8zecZ/phsWCLE1dsGfK5m8qXAgCA5fKZBCppeY0Vd9AYUM1KaflLx8A
	 WI+4N3CcddkDg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Apr 2024 11:48:24 +0200
Subject: [PATCH net-next v2 1/2] mptcp: add last time fields in mptcp_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-1-f95bd6b33e51@kernel.org>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
In-Reply-To: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5940; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eeDESYhXS19PyniztX03I/aPltQffW/Pd8Y7CAHZ87U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmFmBs7BWbzDku/dbn0izXMLzype/RlxCHEbwCQ
 jSEYCfEFOyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhZgbAAKCRD2t4JPQmmg
 c5ECEACXlynYhYqgsmZUsgS0l9XnNVZfVcGd8guiQ8pmqlgL3Iq8ZRyzJ/DNJmz+ilPwVQo5pcz
 7Jcv0PdBjOBY0V29bRRWi4I9/Mv+NG8U6ou8nRNQmctxz9QydajRMueVrqpwk6PKojieQ8VI8C+
 sWo83taHE0PbxxEWtwxTdwsHKuru0DEBjJFnmHC82+CDV3ZxyCgbTidlLVSPoM2eyiaD6/Ezm+e
 DeENAXkaGaVvjUCYhNSBif5EUT+i0rCekMleevPEkrh+CVerdhalTlrI9okqdnsxsrDLvesJtdd
 q19KC+MLxLemTB7uXdKMnJz7KZzbF+eByPKkej0E5dl5OvVeTZPxc0gGNl28HTrAX2Sse18lkr3
 qT/Hc7OpHNBpz+PqjNPbP8zb62Z1ZyhN+4Z/NTowpqprhx330UA2FoekbQQgeXYFmjKscl3T5eH
 4MKhet5+u04lJEGcgwMHEnkecatySZp26Axe/J5oYHm3o61rj4I1sxHIxhcbu4/Jq15Gtms4yQY
 yRiLuBqDUfQ55xSmal/rShPEUoZaCw8cIig8LjBrMAlvWmVAIg+ZbgNSNhT4VtKQMXmvmaqtCvc
 3/fNGbN5C7B3PzRLEgWJovLWu3hSw+zcVDKwZ3Rr5LhD25w1mRgVPtHMNbbjcvA5s4nN4a9oRGQ
 A5GuVj/sJOMmndQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds "last time" fields last_data_sent, last_data_recv and
last_ack_recv in struct mptcp_sock to record the last time data_sent,
data_recv and ack_recv happened. They all are initialized as
tcp_jiffies32 in __mptcp_init_sock(), and updated as tcp_jiffies32 too
when data is sent in __subflow_push_pending(), data is received in
__mptcp_move_skbs_from_subflow(), and ack is received in ack_update_msk().

Similar to tcpi_last_data_sent, tcpi_last_data_recv and tcpi_last_ack_recv
exposed with TCP, this patch exposes the last time "an action happened" for
MPTCP in mptcp_info, named mptcpi_last_data_sent, mptcpi_last_data_recv and
mptcpi_last_ack_recv, calculated in mptcp_diag_fill_info() as the time
deltas between now and the newly added last time fields in mptcp_sock.

Since msk->last_ack_recv needs to be protected by mptcp_data_lock/unlock,
and lock_sock_fast can sleep and be quite slow, move the entire
mptcp_data_lock/unlock block after the lock/unlock_sock_fast block.
Then mptcpi_last_data_sent and mptcpi_last_data_recv are set in
lock/unlock_sock_fast block, while mptcpi_last_ack_recv is set in
mptcp_data_lock/unlock block, which is protected by a spinlock and
should not block for too long.

Also add three reserved bytes in struct mptcp_info not to have holes in
this structure exposed to userspace.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Set 'now = jiffies32' inside '(un)lock_sock_fast' block (Eric).
 - Move 'mptcp_data_(un)lock' block after '(un)lock_sock_fast', not to
   reload 'now', and have all counters synced (Matthieu / Mat).
---
 include/uapi/linux/mptcp.h |  4 ++++
 net/mptcp/options.c        |  1 +
 net/mptcp/protocol.c       |  7 +++++++
 net/mptcp/protocol.h       |  3 +++
 net/mptcp/sockopt.c        | 16 +++++++++++-----
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 74cfe496891e..67d015df8893 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -58,6 +58,10 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
+	__u8	reserved[3];
+	__u32	mptcpi_last_data_sent;
+	__u32	mptcpi_last_data_recv;
+	__u32	mptcpi_last_ack_recv;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 27ca42c77b02..8e8dcfbc2993 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1068,6 +1068,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
+	msk->last_ack_recv = tcp_jiffies32;
 	mptcp_data_unlock(sk);
 
 	trace_ack_update_msk(mp_opt->data_ack,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 995b53cd021c..f8bc34f0d973 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -706,6 +706,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 		}
 	} while (more_data_avail);
 
+	if (moved > 0)
+		msk->last_data_recv = tcp_jiffies32;
 	*bytes += moved;
 	return done;
 }
@@ -1556,6 +1558,8 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 	err = copied;
 
 out:
+	if (err > 0)
+		msk->last_data_sent = tcp_jiffies32;
 	return err;
 }
 
@@ -2793,6 +2797,9 @@ static void __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
 	msk->subflow_id = 1;
+	msk->last_data_sent = tcp_jiffies32;
+	msk->last_data_recv = tcp_jiffies32;
+	msk->last_ack_recv = tcp_jiffies32;
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 46f4655b7123..fdfa843e2d88 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -282,6 +282,9 @@ struct mptcp_sock {
 	u64		bytes_acked;
 	u64		snd_una;
 	u64		wnd_end;
+	u32		last_data_sent;
+	u32		last_data_recv;
+	u32		last_ack_recv;
 	unsigned long	timer_ival;
 	u32		token;
 	int		rmem_released;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 9d5d42a77bcc..1fea43f5b6f3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -898,6 +898,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	struct sock *sk = (struct sock *)msk;
 	u32 flags = 0;
 	bool slow;
+	u32 now;
 
 	memset(info, 0, sizeof(*info));
 
@@ -926,11 +927,6 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (READ_ONCE(msk->can_ack))
 		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
 	info->mptcpi_flags = flags;
-	mptcp_data_lock(sk);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
-	info->mptcpi_bytes_acked = msk->bytes_acked;
-	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
@@ -942,7 +938,17 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	now = tcp_jiffies32;
+	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
+	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
 	unlock_sock_fast(sk, slow);
+
+	mptcp_data_lock(sk);
+	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
+	info->mptcpi_snd_una = msk->snd_una;
+	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_bytes_acked = msk->bytes_acked;
+	mptcp_data_unlock(sk);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 

-- 
2.43.0


