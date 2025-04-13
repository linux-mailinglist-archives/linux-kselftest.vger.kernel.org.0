Return-Path: <linux-kselftest+bounces-30648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D7A87156
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A134178EC3
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF81A83F2;
	Sun, 13 Apr 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfhncWAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29861A76DE;
	Sun, 13 Apr 2025 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536909; cv=none; b=LWv2YlANzmCZmgQFeo5F1PnaP6Ww38bfLJuIUH2xfOBsLuN2gJIU/LGOw9aJLF2JTm3NAqqoMa1QYbW2dUOieJHMsFy3SCyxVYtkc6K6PgSi7lMp2L9nCZQwWIt4Qs+M2VYQGZjMEGqX8sM2i+8+Foxs0L8ZZu71ZtZBDFxEk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536909; c=relaxed/simple;
	bh=V4xMpmIHQd/U4DP0Al+j0aAr5lDLyI3bohudZsS4Gu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=At5uRsCMjbOXVe7TXOBwr8PYHMxMsdcOkik27S6+BWYOTQujFBeVlrr/GbfGquw37cTM5PfM1a09JO9kP11e2m+YlxDS2D7w+bJ6UTvojnnPWPsdV0RBJjzJLQ92His1CmEd5rKYZakfo1mu0j87aIZfr+aqboGynzOBWWTkzsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfhncWAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D228BC4CEEE;
	Sun, 13 Apr 2025 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536909;
	bh=V4xMpmIHQd/U4DP0Al+j0aAr5lDLyI3bohudZsS4Gu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XfhncWAUTJv+2Gwda3/6KX1F+Dun1/4HGRFdgHMAlJsuWVapWXnQ/vaOX/iNhuxNc
	 bTUt47w4X9GQmSWHlJ02XdpL5qLkDu85QcKASLqXq3f92wWZouilaHc6iS/po/6zpb
	 Une6p5JnjZn71oQjxqsNEq2kqnOMRoweeMCgIbvZRlRMKB8nBB1/0z4JAbnu0xf9DS
	 PhLTT0/KU+aYln9uBpgJ+7UuhjfR+bJAQgPtJU+N75JCalBgF+54HsQT0Rneq2dWyG
	 FmfKUC54u0nwerRAxuQzWDQKGTYb4zHEMxhhGThYdAEocdgay4eQLsxdc0eyPHg9bL
	 b3GC1fGGl+ytw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:36 +0200
Subject: [PATCH net-next v2 5/8] mptcp: add MPJoinRejected MIB counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-5-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V4xMpmIHQd/U4DP0Al+j0aAr5lDLyI3bohudZsS4Gu8=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U3b6wQjv/G6U9dS3kxs6sW4fiEY6z3eGxdX
 ZySk1ySUw2JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFNwAKCRD2t4JPQmmg
 cx9kD/0Sxt7vcuRA2dB9KN/YbohVtNqAcQQNlDUt/sE2lSlYOmjs8DPcb2z8MBtSdt+1QErxBbx
 nv9/+SdF4td6M9qCCA4q16o0IE+ePRTyoJ4L3IRTFydsmszzTQoHDuLYLVuLc55n1RapdJp5TxU
 6Kw9xhmYjmiZtWHfrkFQy9vdaLU5Yhe/xAiEQezG7eR0znrx/QkO+dj0U+cQEVi5HvbQC9a6Rso
 24q7cfOJxf2J9kVzw+62djwrgG827jaMr2Y17zqIFH51jkrnnjhItr18tM8FLEQDwpgeduKnyS0
 zfmsFm4neJdUy9Qn80Yxb3B7q1GwV49DnxqBohCB7OsN5vBUXZzkkvvCBRGEvuSUQoWz+kWJhP3
 sGnlCr1zqPRqcMGnDzNGkqlO1MRDwK3elRbD+NNEFDJC/CTLlQMnSCeCPfADpXtDwn4OgZPYD6G
 4qTdxM+V/C11nUIcnQBxLkGNJipL/CDACX/iQ+/3DioXHDmBGkGqxu7ys6HaGQxwvghdSZRTnRT
 hMIdF3bNBUiPSAxLvLxz9T1pFYo1KBHka/3fJZdhsOCPtZfUeV/eu1U9FtqEhKXuG+02MLn5ry5
 TtBmi9WocWxxxFawLPIq7EabFhZZu70Mt9+cbZ5ThBEd9/7o33Srpn1nQi08ZImII6YgTQ79Wsg
 +nyjJ/Bv+lIthug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This counter is useful to understand why some paths are rejected, and
not created as expected.

It is incremented when receiving a connection request, if the PM didn't
allow the creation of new subflows.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 19eb9292bd6093a760b41f98c1774fd2490c48e3..0c24545f0e8df95b3475bfccc7a2f2ce440f7ad2 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -28,6 +28,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
 	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
 	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 128282982843a07614a46f9b2c2f7c708306c769..250c6b77977e8f846b5741304f7841a922f51967 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -23,6 +23,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINREJECTED,		/* The PM rejected the JOIN request */
 	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 44f7ab463d7550ad728651bad2b1aeb4cd4dea05..26ffa06c21e8d3429e2684f58523226d82a094ea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3527,8 +3527,10 @@ bool mptcp_finish_join(struct sock *ssk)
 		return true;
 	}
 
-	if (!mptcp_pm_allow_new_subflow(msk))
+	if (!mptcp_pm_allow_new_subflow(msk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_JOINREJECTED);
 		goto err_prohibited;
+	}
 
 	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e7951786a97c91190c7341d2c586a1f4acc05ed5..15613d691bfef6800268ae75b62508736865f44a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -247,6 +247,7 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (unlikely(req->syncookie)) {
 			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
 			}
@@ -902,6 +903,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			if (!mptcp_can_accept_new_subflow(owner)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}

-- 
2.48.1


