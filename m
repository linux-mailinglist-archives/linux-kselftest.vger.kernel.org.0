Return-Path: <linux-kselftest+bounces-16323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D062E95F780
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6661C21B6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD9E1990A7;
	Mon, 26 Aug 2024 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjKnMw9s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD0198E9B;
	Mon, 26 Aug 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692292; cv=none; b=oEbFUVyszBHaa2UHHlH4ER/+HLZoVINCCuRpyWLjiBDmK5mRUgx2f+lDC+kf4Y5yXVX8PAuAc5FhdOEuINHAWue2nLrG64BsU3mYB6TN5B80mYv8izazSwF7AbgSXyfkjk075uR7la2d78zr7D75I9lMlTn9wfy0kaJUxJr6HQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692292; c=relaxed/simple;
	bh=uPaLfJPaEp4yYYl1GfXkjcisrWrVxL/OYXKY3CfhqIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fldmj6rxtSkP7vTXtFN6kU2kjKdIScOMurpbX0nfVgm4c/2I1lKGtw+8Vdo9MzYk4MOnppBrrwFpitDe0dL0Dxn9Fdexco8CSiDSftHrceUNDZRUVLvGViFP+7UZEmPmgHxA8DGkzBnvFZUJD7QJ9maTQmIgcwYSRzKtlR4ReqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjKnMw9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A16C58303;
	Mon, 26 Aug 2024 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692291;
	bh=uPaLfJPaEp4yYYl1GfXkjcisrWrVxL/OYXKY3CfhqIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rjKnMw9sv7+SLLX7ne2jy446QK1GyqaDL4fFoeFb636G8HBve/BQdBzTh1THrpPS3
	 JttqVqZZmmfsbjfnmQUfyboNi8N61/qNO7JSo/5f5+utpkrPHfagMUuKEvENf8NwYh
	 rAJo1qSjGzeyjJj8ynJQDCTWuRI1d8SFDkgx64ZisQDB9l/1IziWXjo2SELTUfRRjD
	 jkkJgzAAeBSqmtVMSgBgSOyRybl2Fs743bOUtw2xr7ykRpRTv1yZygl3tNRzd0XM9L
	 1O7SZNAuno8M85Txk2dQuvsSIR67SnmiaD7GA7lRGF0EZOl8kIp0J6GN+t+7nwN+J2
	 2ZfKT8VFHThzA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 19:11:18 +0200
Subject: [PATCH net 1/4] mptcp: close subflow when receiving TCP+FIN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-close-extra-sf-fin-v1-1-905199fe1172@kernel.org>
References: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
In-Reply-To: <20240826-net-mptcp-close-extra-sf-fin-v1-0-905199fe1172@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3238; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uPaLfJPaEp4yYYl1GfXkjcisrWrVxL/OYXKY3CfhqIA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzLc9BjejeVADHn/nVZgfUVq+csnwsBdmSgjOf
 G4lsPZ9s3mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsy3PQAKCRD2t4JPQmmg
 c71oD/41Mkc2JWFNwd5xlqySH9gLJKYonnRBPFmfWxJFbSv1rSYBo4BvIweGJxduW2AOJmBqSMC
 EraQufQ3w0GZVQgxxUX/UL8akrEfB21alzp46Jv1r47W5CjjoLW3Slp8/RNzZiiFiWIW7D0NsTh
 HLulQMIObT9IrTV2ZO4nQfCkuag5wkE54o5RW0Sl5dESQqL7kvqpLwMoD8qJjbwtJyuUDlSG86k
 3rDoJFiLohDF+CrvDa8nii/ZwvCT6ba4cDm39eUvWUw4lZe9j4iVzORf+gCd+f71DmEE7VEjHqs
 Vj9x8r4Bqqmf1pHMcNgQoz13zyUWemVjMhRRZ1DqGJjw4aSYsbB4dBwT0T8SClRQc3YHFx3J+hd
 W69a6bHXlPxyzXm7Us6OnK0dcrKB4s16F6EQQk2h0D/Qykq9Bl4Fh27sVA6p0yf+VdIfriYIBTI
 NYPpwTG5nt3ND8KIGsvRKpACgysQcOJi/5wxUlfEzYuINMglGrluF8im7jtOGiIaKj5dzfhmRIT
 mKkdakLkVHywyKxAgB9qOyA1tPT9lJUJ4Y5MUpU4wowrnpfpqm8vDom66P5XeSkpxc56wDPfQ1e
 n4GEmmQo3++raOPqra4qKfzAcl2tdE71SH5s6ujs5yydXxNXGRTtd6/OY9e/XjDyiB2o9p0FRxZ
 7YcqyfSQ/MGFsJw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a peer decides to close one subflow in the middle of a connection
having multiple subflows, the receiver of the first FIN should accept
that, and close the subflow on its side as well. If not, the subflow
will stay half closed, and would even continue to be used until the end
of the MPTCP connection or a reset from the network.

The issue has not been seen before, probably because the in-kernel
path-manager always sends a RM_ADDR before closing the subflow. Upon the
reception of this RM_ADDR, the other peer will initiate the closure on
its side as well. On the other hand, if the RM_ADDR is lost, or if the
path-manager of the other peer only closes the subflow without sending a
RM_ADDR, the subflow would switch to TCP_CLOSE_WAIT, but that's it,
leaving the subflow half-closed.

So now, when the subflow switches to the TCP_CLOSE_WAIT state, and if
the MPTCP connection has not been closed before with a DATA_FIN, the
kernel owning the subflow schedules its worker to initiate the closure
on its side as well.

This issue can be easily reproduced with packetdrill, as visible in [1],
by creating an additional subflow, injecting a FIN+ACK before sending
the DATA_FIN, and expecting a FIN+ACK in return.

Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
Cc: stable@vger.kernel.org
Link: https://github.com/multipath-tcp/packetdrill/pull/154 [1]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 5 ++++-
 net/mptcp/subflow.c  | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0d536b183a6c..151e82e2ff2e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2533,8 +2533,11 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ssk_state = inet_sk_state_load(ssk);
 
-		if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		if (ssk_state != TCP_CLOSE &&
+		    (ssk_state != TCP_CLOSE_WAIT ||
+		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a21c712350c3..4834e7fc2fb6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1255,12 +1255,16 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 /* sched mptcp worker to remove the subflow if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (likely(ssk->sk_state != TCP_CLOSE))
+	struct sock *sk = (struct sock *)msk;
+
+	if (likely(ssk->sk_state != TCP_CLOSE &&
+		   (ssk->sk_state != TCP_CLOSE_WAIT ||
+		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
 	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+		mptcp_schedule_work(sk);
 }
 
 static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)

-- 
2.45.2


