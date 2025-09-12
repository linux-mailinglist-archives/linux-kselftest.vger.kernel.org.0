Return-Path: <linux-kselftest+bounces-41366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2428EB54DD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11657A02BB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072E30AAC1;
	Fri, 12 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzsX1qZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF53309DCB;
	Fri, 12 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679972; cv=none; b=qaqldYwLHHbeEBPWzykm1UITHtqAzU1vx+CosPyXDu+AgUkqnCz5SZDfea8C/We+BygmK6erS31q5OKdKaAq+GqrSdXZwOp9rAd54soJHP8MBD9NSiVQ36D33UnyYlRPgn0gNM7GVgbyZjxoY8Rb87drDY7XWQtZnnZY6VJMoxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679972; c=relaxed/simple;
	bh=121npnLQqMrG8NMgJdgNv2/ZCGNMwuF+edD/La2crTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0YPlNX3ix2NGNn2EOv1JBoJBgG+s5VNeCXQ134xW/YSbafKYicvyl4EOIl3xYRfOPHRqQr8UHVi35MTLf7VMY5x2AL6xAtXvtZaL2b4cdvgVw947riNIAAydNIPG/YLI4ZmtzzV4nEX2jFNzoDiYaE+1axRUFSZM9co4CZCV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzsX1qZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E6AC4CEF4;
	Fri, 12 Sep 2025 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679972;
	bh=121npnLQqMrG8NMgJdgNv2/ZCGNMwuF+edD/La2crTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qzsX1qZM6Sd3eaSamdfxr/h2H/MVHrIodZfcV1iR54wgQoeFtshVhQhhB22bWK0wR
	 WO/h9HzEhOtIwMEgf1pVNbgrDYMsEqAwadZoykbHK9b0ym+Ni6MualSJNJer90Fwsk
	 vSJIbtjD/B1eu+Rkvq9814rhr+3QgyUnKAPuRsoHvNuc7pb92jrMoDu+rS+j+7uL1k
	 7aQwtFcRz27vmXSeLdPMDfqOqd7fE1pmpw7geBXME+RzCKFe/GhjnhGSDi4R+ar3RB
	 7cWuMjApp6lJHVbkrfoE7dZ8qwJv5iW1tH72AlH2Dz0GRAJwYN7Fjsv5cigYYBlYtv
	 Y5+R/ZkrQQa9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 12 Sep 2025 14:25:50 +0200
Subject: [PATCH net 1/5] mptcp: propagate shutdown to subflows when
 possible
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-net-mptcp-fix-sft-connect-v1-1-d40e77cbbf02@kernel.org>
References: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
In-Reply-To: <20250912-net-mptcp-fix-sft-connect-v1-0-d40e77cbbf02@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=121npnLQqMrG8NMgJdgNv2/ZCGNMwuF+edD/La2crTA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKOCEbI+l9hyDCwcC5QNJIWPsKnKHXx3twPnslKTS9f5
 +7cfPxlRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwEQm32X4nxBue1P6jN82lgVM
 nc80nyw55yUTmBhd//zv5DzDzUfYVjIyzHqy79TFf1t8zzi/MVjqd+rTb4UZ/z70L1jneKQ2uSZ
 +CQ8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the MPTCP DATA FIN have been ACKed, there is no more MPTCP related
metadata to exchange, and all subflows can be safely shutdown.

Before this patch, the subflows were actually terminated at 'close()'
time. That's certainly fine most of the time, but not when the userspace
'shutdown()' a connection, without close()ing it. When doing so, the
subflows were staying in LAST_ACK state on one side -- and consequently
in FIN_WAIT2 on the other side -- until the 'close()' of the MPTCP
socket.

Now, when the DATA FIN have been ACKed, all subflows are shutdown. A
consequence of this is that the TCP 'FIN' flag can be set earlier now,
but the end result is the same. This affects the packetdrill tests
looking at the end of the MPTCP connections, but for a good reason.

Note that tcp_shutdown() will check the subflow state, so no need to do
that again before calling it.

Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence number and add related helpers")
Cc: stable@vger.kernel.org
Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of DATA_FIN")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e6fd97b21e9eeae816dc355834ba54c21bd2cc94..5e497a83e9675b5217052299463c1dfc58de947c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -371,6 +371,20 @@ static void mptcp_close_wake_up(struct sock *sk)
 		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
 }
 
+static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		bool slow;
+
+		slow = lock_sock_fast(ssk);
+		tcp_shutdown(ssk, SEND_SHUTDOWN);
+		unlock_sock_fast(ssk, slow);
+	}
+}
+
 /* called under the msk socket lock */
 static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
@@ -395,6 +409,7 @@ static void mptcp_check_data_fin_ack(struct sock *sk)
 			break;
 		case TCP_CLOSING:
 		case TCP_LAST_ACK:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		}
@@ -563,6 +578,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 			mptcp_set_state(sk, TCP_CLOSING);
 			break;
 		case TCP_FIN_WAIT2:
+			mptcp_shutdown_subflows(msk);
 			mptcp_set_state(sk, TCP_CLOSE);
 			break;
 		default:

-- 
2.51.0


