Return-Path: <linux-kselftest+bounces-16940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C765496851D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE47E1C2245D
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370FE1D1F6E;
	Mon,  2 Sep 2024 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AerRWR5P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07028181B88;
	Mon,  2 Sep 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273979; cv=none; b=WksNR7ZihhMDw4HY9zwjZphENGbUxWl2kALA1297fjrk4y+kDcefctu2TK7K/XK3WK+AuoA4zINx1h23MmmGSlGIPHpyiukrUWManaCSMVB0I/Y/gyjDkqTAdPXUW24ZAcZ304t/TNY9XdjFC0+YgaXWFOVfiThrBf+T+NXVMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273979; c=relaxed/simple;
	bh=ZGJ9pGvlXhT4hqhhgcYTpzLo5CjeyxTCGY7tbzG5uQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cd9U1kM4Tuet1YK61vBan701rlP0dwDZf2r7QgMtxVY8DZoY2T0QI2LolV18ya9PuxKmYtDhYA3krAwBoPobUoIGN/0QOoPDjUZt2r4j9gpn/APsP6g3P2TMA/WUgdvZ/pFFVHsRKSsf8aaD3S8tjtyCSNTq7FALDUj0bgz1ugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AerRWR5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CA8C4CEC2;
	Mon,  2 Sep 2024 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273978;
	bh=ZGJ9pGvlXhT4hqhhgcYTpzLo5CjeyxTCGY7tbzG5uQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AerRWR5P874u/mfp8DhkXMXj95lexOdCw8DOSF0wgDOy+KdC8KYfg0cc2XgCA07/7
	 CsWWQUhc45OuXvpM2vWzMnKbGRp94GWAMymu5+uP6B/Ov+Wy2sNia7PJd37u19KzvW
	 lVIwPaQZcZ118z65ETf0J4A4HrjMLmcntiCMpFqZ45RS1h3i6D1vKIXrSIlpa+OIDG
	 E17yEHNaVVTgyOU8drb707gj0MkGQxVIvRMYdQSFM/oMeHGB09uvuXM84acRmq6Mva
	 8OVVWxQ0jrlMM/HdpDD+OSuBkbl5I/yFRToL1sXAZvv8M+C2NHGkJqwI2JbXxfF0LH
	 Taa8KYIZpdDfA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:54 +0200
Subject: [PATCH net-next 03/11] mptcp: MIB counters for sent MP_JOIN
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-3-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4595; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZGJ9pGvlXhT4hqhhgcYTpzLo5CjeyxTCGY7tbzG5uQI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1ZdtbCpcdvektVd0ZNGvpnfxu4dRb/o1HyjZU
 A51nTWFgwWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 cwoND/0T9U9QElXTl+e/Ch/Kye4MfnNxrULw8IGL195+MNKiUiHlrPKVIWCxVkpTaoj4VJQIvnw
 oi5NLOR+Nswz/E73lBqDbIQJDD7S3oDJg/de2YpTGLv3eVB9KX7aKo7/uaxkVsosXJeQksauNqX
 HmIc+3sZB+ZOiLkOSMqdTN0bP+5eta2Dwtzt97rInE7Xm3h+jCaYnqLTgAE852MxD2sXbUH3CAz
 tXTZjJQDoGzIS7nSN9r/ccEQl0UO7JCnBGJ9irBmmdm4EzVSKwJmrT46ZwEaN6pcW3XVdIp8LqV
 3aYTxrvDUU67N77MdGQOJH+qrdmJ7WC03cb3vg7JXPOnVwT/8UANDy3SCzF8uW2qG/l/RRfMn5N
 8R9WNoWHsCmdxIZzU7z9f+P6XsCPE4K/mDkzxmiocsOueBtLP0JkdZMOUMcA71qY22fsvST4lYT
 VHlkc2e9HE053MP57zcpkDHwTwrCmOD7OJjnP8vdnaB3NKLhGZ+oYE6wechKC2CXZRSKb/d4fPu
 oH15YdtPb1FqwBWSG6L4btB8cUQsN+HCZXfcXBzd14qvxLzm0HOxxBKHz4TmzEp9uVLpslsh503
 pMTwP8elRa4q5UuqxiunTx46lyLoj2PzHJHM5GcA4ShuPJ1hmRhc0/KNJhCRA/RyRiz49ZOcpML
 sEjc+MsfOzbHO2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, a few issues have been discovered around the creation of
additional subflows. Without these counters, it was difficult to point
out the reason why some subflows were not created as expected.

These counters should have been added earlier, because there is no other
simple ways to extract such information from the kernel, and understand
why subflows have not been created.

While at it, some pr_debug() have been added, just in case the errno
needs to be printed.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/509
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     |  4 ++++
 net/mptcp/mib.h     |  4 ++++
 net/mptcp/subflow.c | 21 ++++++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7884217f33eb..ec0d461cb921 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -25,6 +25,10 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
+	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
+	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
+	SNMP_MIB_ITEM("MPJoinSynTxConnectErr", MPTCP_MIB_JOINSYNTXCONNECTERR),
 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
 	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 66aa67f49d03..d68136f93dac 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -20,6 +20,10 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect() when sending a SYN + MP_JOIN */
 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
 	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping */
 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0796122c9467..b9b14e75e8c2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1579,12 +1579,17 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	u32 remote_token;
 	int addrlen;
 
+	/* The userspace PM sent the request too early? */
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
 	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCREATSKERR);
+		pr_debug("msk=%p local=%d remote=%d create sock error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto err_out;
+	}
 
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
@@ -1619,8 +1624,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 #endif
 	ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
-	if (err)
+	if (err) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
+		pr_debug("msk=%p local=%d remote=%d bind error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed;
+	}
 
 	mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d\n", msk,
@@ -1635,8 +1644,14 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	sock_hold(ssk);
 	list_add_tail(&subflow->node, &msk->conn_list);
 	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen, O_NONBLOCK);
-	if (err && err != -EINPROGRESS)
+	if (err && err != -EINPROGRESS) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXCONNECTERR);
+		pr_debug("msk=%p local=%d remote=%d connect error: %d\n",
+			 msk, local_id, remote_id, err);
 		goto failed_unlink;
+	}
+
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
 
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);

-- 
2.45.2


