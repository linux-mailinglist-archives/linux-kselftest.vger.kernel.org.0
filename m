Return-Path: <linux-kselftest+bounces-7284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A3899DEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0E1C229F7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668B16D4F4;
	Fri,  5 Apr 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Hoj24J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698E16D4F1;
	Fri,  5 Apr 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322399; cv=none; b=R47BxTbMggZEnUOsoezXNDdxKdpxuEDW4lIOKVe4fl6MZdz7ShsE6BtdACwGk3FmpvvVQhVwtFjNHXbAYEWqV5fPg0mdWyQrZVUVAHuMm7THp5Ix06xaUeLD8MvIFMkY03pDrNk4/+8+m3rzT9vvT+h8qH/fvp/OQgB+EhR5lM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322399; c=relaxed/simple;
	bh=1j3hW9YAEW484MOqJDnQae4PhbxqhnhN/Z1nRM6/His=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=taqSSemFaTK2YsWIgiLBgmhrtJvpfNRjrCI4zC0XgBwlio/Qw5AwIrSUoFbYUTZJyqy9fQdHU4U1Nq+GYK8kcWu+7y0vdbH9fE7xw44g0SpjAOnMKlvVXAmf32ZOzT6252EA03nBtXr4PrJ/DqH45MVsABaRACbzrwqkwme4jWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Hoj24J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E10FC433C7;
	Fri,  5 Apr 2024 13:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322399;
	bh=1j3hW9YAEW484MOqJDnQae4PhbxqhnhN/Z1nRM6/His=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e1Hoj24JvzvkJutMHOhlkTnSDViBOqWCtSoacbzNispGSZvXymRht49DMk2HSz5wt
	 Kh73QTOuBfy36l1xtaALQ7mfYnJT65KJ9aWB0eBrGWTT93qInE96IBgkt0P56gG2tm
	 9OWKuVVbEAk8RGCbitxOglnuGA/lp7YKSu0FpQl4I+K+plDNVcVwGqYBXXmd+mXOUY
	 7hLi5Ycas98l0Mxwd/T7+7yXFKvDgMN1Ybp0wQRQD9D0t2vUw4N2y1uDtjPvURVFtW
	 3yG6RHO3/Zgu3lLFyqaStYazCDUNRcy++kiKzxudjls4FeYSI4rdcizmaaGJ+S6X2D
	 efdXDCbJ/UEJQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 15:06:21 +0200
Subject: [PATCH net-next 1/2] mptcp: add last time fields in mptcp_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-1-52dc49453649@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4848; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=648syyUDg04+UEijLZ/0zq6tkZDYCTtkOW9fCgS5UZI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD/dYvb88pQACCDDSa2iZSLWuhLOGJnuYjBQqP
 ZOVB4woMIyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/3WAAKCRD2t4JPQmmg
 c0XsD/9PY5SESZduyV3fPr/FNouKfQv+pzP8Y99J8UrQiXin17r6re0rykZFsIkAW/iAmzY7HPd
 OPGk75Zn8TcrhsyJK/gmbaZyh9m5aOUSZehUDoWkIG4geRodjdlLr2uuj3XyqKvtd8VsYCnFSo1
 MgqcameFq+sc4qb1evsmMwvTrLJIzQxh4G6YaIoCygu3e3TVJLi0p3+0/yBUaWohniGx4fIHDWq
 Oxsn257UBMC2jpeMfHdNOP+/M+uiI57FPz82RnTkddjV4mz3o5/k+sQnz99CQfdMVcI+SRYBy1Q
 2ytXBRiMhaRnux/yJz9mCYmCcbRJF9UhWkuu5OjHUV7DBmKboeJxOJu6Qc/+9hCFUPd7A3Ibgfn
 7bDWuXG5F45S9lSRFvbMo3l1JGpN/I52I0n4bBxGCh3Yv+L6MKoPpEAX/G8aQp+xbohJKDkUfyI
 G4hMrXTJdkxtR6k9lAGSSf9FF0Wv6QtXw9gnCgTKneCjvwpBIST1h6UJ+QO93ije/FkotiwMmC+
 uwxud8ATuM9qM38ZGME5Ml4zwsbPNrtLfx4hLcwjTCG0bmcUoqHmwTc61R//fEH521a2OCwQgqT
 F3ex7Nln3yzlPI6lrNGWlL04FaU0lDy/dlvf9Z8MW2qYBNd6gtA819hX5wNl602PeNqRTq0T7RK
 9KwaJEn9RHaxdlw==
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

Also add three reserved bytes in struct mptcp_info not to have holes in
this structure exposed to userspace.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h | 4 ++++
 net/mptcp/options.c        | 1 +
 net/mptcp/protocol.c       | 7 +++++++
 net/mptcp/protocol.h       | 3 +++
 net/mptcp/sockopt.c        | 4 ++++
 5 files changed, 19 insertions(+)

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
index 7e74b812e366..6c1af0155bb0 100644
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
index 73fdf423de44..2ec2fdf9f4af 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -896,6 +896,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
+	u32 now = tcp_jiffies32;
 	u32 flags = 0;
 	bool slow;
 
@@ -930,6 +931,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_snd_una = msk->snd_una;
 	info->mptcpi_rcv_nxt = msk->ack_seq;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
+	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
@@ -942,6 +944,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
 	info->mptcpi_subflows_total = info->mptcpi_subflows +
 		__mptcp_has_initial_subflow(msk);
+	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
+	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);

-- 
2.43.0


