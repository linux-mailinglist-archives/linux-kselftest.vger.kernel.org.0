Return-Path: <linux-kselftest+bounces-14306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F3D93DE92
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C251C2143B
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D4757F8;
	Sat, 27 Jul 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK6UPu2J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC2770FE;
	Sat, 27 Jul 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074616; cv=none; b=SPnksevUG660sqp/7TNwUZKjAoViSiNeCx2MUsWCM/gFBq0eagsHjGCoZjbE+3uS/aXxT89wdQxZPD5okr7uipHgaAs4WnmoG5EmyRpQOckd9sJC7sNZe9WiY2YVteQSvBQiH82JrdvSdvx6xDMnE9oooaZ9osMim3UOvbS7/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074616; c=relaxed/simple;
	bh=S3BOardd1gbxkdBklEMqtmAn9Qoa/XdOrTRw+hlcIHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pq1zfqUE3OVT8sFOE0pbCheZYf1ECuzrJ4KbgVGntb6VL10K8bFQN0VX37SR8Vgm5L6mTPZrzovXr9tBwozEsaVviydtJkrisV5nhShpX03cjOsurplWefV6xlg+lGtg730piM+SQWOCLF8fMZFPXDC80CkWHBpW4sCY6oc1E8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK6UPu2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6157CC4AF0A;
	Sat, 27 Jul 2024 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074616;
	bh=S3BOardd1gbxkdBklEMqtmAn9Qoa/XdOrTRw+hlcIHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TK6UPu2JUih/8euTpl2LUBO6XMx/7G3lJ2YOZmvptl8HE+rAlLbEBFYaYeFRlVFsU
	 JdyQsepnaXclc+uiuAQDqp6GWKVwShRA8dcpnRFlu44kGQXGX+mq+UJVMuCs9PJ0y1
	 isxTR9gXPI7cOhXpHR5aakagz8+7rJfkYwrVZYhiyoqR1qB4cCPgBZ5gVCM50AP4PX
	 Rmh0ylbPIS5cvqZKggPnx6qz0RXsnVu6Jfu/qhG8iqkfnK6v9UUQhuD46iLwrM0AnC
	 A2/tJI9oF32K0e5nB+gzolj6KRHQzURBh6U0T19pC8fs5jwtQnYjzh0QRfwYseN5Qn
	 JTv1oZ+dhrQGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:26 +0200
Subject: [PATCH net 4/7] mptcp: mib: count MPJ with backup flag
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-4-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3377; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S3BOardd1gbxkdBklEMqtmAn9Qoa/XdOrTRw+hlcIHU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXlqp+4odKrubnIo3kMhdI8liJLkAEojtOIq
 WuXkvQ8hSuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5QAKCRD2t4JPQmmg
 cx9dD/4qqnD6pDRLRzYH7YQayFjTirFLo3CNZkv5AV9p4txmEml88k0IboYDcwE1mDc4AVhuQxr
 dh9uoKUvmEXEElBO32hbCCjOBxyHrMnS0spSTMB9fTWujs8NthAtf2ebsEmZwCu0bBSAe00ah8U
 VFlpmVhTRUXT4ULY6gvcy4xf/PJZ6DarJpdEfB1jbC683WF6UkwV54ZcSEuefn74okrvEvmqM7h
 QolNJ2MYa4EtpuXQktrj5TW7n0uvaLQY0qkvXGYZ6Pt7693W8YpMYaW/z+45oUpENrTJoYv7hcs
 VdLVb0PpgF9r/TRlmQdkUMYAhbQr4oWWwQtGW/eMu1yfgDjfUDVMr8yAjnVcF/vW/aFs+sxBkbG
 4vT9foOKFynenhxf8SznuK/RYt03YySfpeeWBGEX+PbKMgK5T2mB4nC79CE1nQjS8qvPmRXl8Lo
 33Dq7pY7Pd9Va1psNdLSxgohpT1Qz79kF7VgLPyOcVukBeQfLfJl/cC7Yx5AUX19vR4BZ9O20yn
 x8DV7hmBOy6ZpvNJIirYoVxUJ7k7/wJv2YcQEK33DOvlb3t1ccCdo5tZfi7UwxwIeCAT8JKaALq
 W0N/N8fotgL14ZNsWR9JVUbhBbny0rNaDu0ZeAJOM/Jpw2aZdbaGB+IM/lLJuu0S5fCu+3goLmb
 y0vnflNGQq68AEg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without such counters, it is difficult to easily debug issues with MPJ
not having the backup flags on production servers.

This is not strictly a fix, but it eases to validate the following
patches without requiring to take packet traces, to query ongoing
connections with Netlink with admin permissions, or to guess by looking
at the behaviour of the packet scheduler. Also, the modification is self
contained, isolated, well controlled, and the increments are done just
after others, there from the beginning. It looks then safe, and helpful
to backport this.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/subflow.c | 6 ++++++
 3 files changed, 10 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index c30405e76833..7884217f33eb 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -19,7 +19,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2704afd0dfe4..66aa67f49d03 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -14,7 +14,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a3778aee4e77..be406197b1c4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -168,6 +168,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -577,6 +580,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
+
 		if (subflow_use_different_dport(msk, sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),

-- 
2.45.2


