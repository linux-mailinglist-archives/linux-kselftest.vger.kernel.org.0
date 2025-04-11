Return-Path: <linux-kselftest+bounces-30578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EFEA85B21
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325861B82C25
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53629B23A;
	Fri, 11 Apr 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imGNDAvq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1683238C05;
	Fri, 11 Apr 2025 11:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369526; cv=none; b=JCuYZA7KRcNtGgTCG/2QnocGKWbotn09zteBiEeRyOxHjgL3qlsg1g2iCxh2INrrKcUf+5TRKEM/jdNpFke/G/OR39VpWoj4W/EAwbiOv0ppHChicpD1YWJkCx4CZWXl+ra4h+jY5xpLxq5hhgAu7P7n6QrT0HNs70un16/LOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369526; c=relaxed/simple;
	bh=V4xMpmIHQd/U4DP0Al+j0aAr5lDLyI3bohudZsS4Gu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cn3lPRU1Cp3Ar7+Uo+VuFvCx8rr8XBVLvL/q6SZETF3guZLhhWpArTmNdGYO3QzHaQhTjWz+0tfqssMaU2/voMlfi8s7rLlwDOIGwo8ohVMwwnL2OfuoDb51Aw8oYGKziXt706+lKCxzfw5N47cp1xBp1u8gv7cX0c2MymBj/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imGNDAvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC254C4AF09;
	Fri, 11 Apr 2025 11:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369526;
	bh=V4xMpmIHQd/U4DP0Al+j0aAr5lDLyI3bohudZsS4Gu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=imGNDAvqPMu41t0oPMjhAbs9dmaCBIxAiU425Obv208jwwMI7vP1teaIA7ivekVZ4
	 LWYyp5eAIKbOZ+v9G8Bau2Xcox4ruVwjbC0IcJmqJffBZc/ZTWZzcylRMrgcAoq3Fy
	 z9hJzb6YL63IbBURlaEyfMwv6qTkHJ3C7kTt6o/Js4L5cbHjZMY/irgV3rh5QmATzV
	 UeILNe6RIGGbCuO6m9GDaN52g1Ri7sdDyCoP+66s7Iubowwdnt1TegAJuQXBDT0JYp
	 0OjAFsk6ASs6QeWwszb36kB+QvEcoQgrzxkeUk+ei/8qzDS8K7nO1DA8tWuYcBD8l6
	 loX62QUiM0nLg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:51 +0200
Subject: [PATCH net-next 5/8] mptcp: add MPJoinRejected MIB counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-5-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
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
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+PdhKxnCFRG1rWtoT4KtYqYoVyzmK9j+dCcjT
 Twe5/UI0R2JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3YQAKCRD2t4JPQmmg
 c5FBD/0UaX9BepuNSxLtf+ngrDi8eAbBkK/rR2nd5WXitW2tLYqjTACmLdAdNouxvzpHxZQNW7d
 qiuGVJlHh/Xr3coy6PZLCtweoM+mVMvgtdmLOEOP8RZdoT5xNf/BPrmieW6CLbwBmPKQx7vTTqG
 mXzVWgnFO7yfVJhT3dK+BH35eTbg9ZCDAk01ZBqKrIZEOqfKEzDxeMoCCKbdy+Spt++Tw+S+Inb
 7MA1oMIkez6bEtPFe1kwkoVKSznz7ZfxBY2WCKOKJZZJhnBNyD27n3tYcCpmwxm2cNjq6jSlPLV
 LlJH7wagbLG3FAPZCSqKRINF/aD5MoVTzTRszb/4SvHnPaD2ol+Lx/qNfbwhzlic7QqovKRQAEF
 qZMpFODZXAQDEjX3iTuHKYt1BHSVe9ZRxuXqoqztYrRxGLpSp4mAhE5a+KJtJZSwpiLUWZHH6lF
 ncoZp5B50oQM/3ODxkWdwXYwKWCgQlplck2/hkPAOeE8i3u5MiH/CX5HXqrvH6/WuzPTp7almZr
 muFi5TDH8DIFgD1s2WCB0kXOG1d1WMzb5oPCpsGGpy4TomN5dS36HlepIQsKdi0juxxjt9XPhyx
 F54Idv469mWCZOFIxFmbtJoZOcBtTxposIpeKwgH2MXCAHBt+34cdR8oMn+gOXoztBaBNkDB9Bj
 TzlzDgj/fGG8jww==
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


