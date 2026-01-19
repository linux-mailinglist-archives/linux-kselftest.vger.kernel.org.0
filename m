Return-Path: <linux-kselftest+bounces-49400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB62FD3B680
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A73B330B5542
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A452A38E5DB;
	Mon, 19 Jan 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QDFvMWTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616238F233;
	Mon, 19 Jan 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849155; cv=fail; b=Cq1840LTPB7pvRgOiWf06f3/zouPyVMcxSYjmYpqIjpnv7objfeOiRRQQosaosu4ouMB069rIL8UspiMQ55JIuI/MkmOo1TBE4FkVtNAI19ifygaXYWMsog6lanx1dFJfhEZ4G42vc89Xu8qNZTLID9RO3Bt4IAZVVjodhTWzG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849155; c=relaxed/simple;
	bh=+7pgxc1XdnZeYmv4vWQpP1RY4R/u6GTV1Fp0R44FKcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyeKsKzV0mtfPsqfeAXyZNQbqivUPdtft66vA5l1s1HEMwRLBp0JTpD1ZJgeC53ECOkafehn4cjqQAY6zXg8qxCvlvvK4lMtHJxVpl8MlSr9uYvvw5js2zb4uYdMXXM1ohiritX43qDF4SAjkvrp7UNwBlj+yfTW46i7OGx4yuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QDFvMWTS; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsJU14HRAixbis+5Mkhzmk6WV8RxkeA/JHcS/Wd45uryPcV7Q76UmiSOxiNyMZmFN96CtuEXMM8+fHGRnO9hfF5LL09Jzf+2pFUtUJkGZImnOsgNjePFsZen1W/MMMEQ2Gxb5asMEx+gHE2p3W/6+zpX1P3BHTI5ufqNsf+r+9q03qTZz9vhN6cEzE+CW/Lf8NSZZ9m67yTWtjQWB5BJ/GOauWd4qulYXH4+tfVs2HK5CM+nMmupIUW8uDw0KpH6KV3V/H1Axby1itlIjrmsdlj9hYcF2oT5SVNvZDz9BaxsCyQ5+OJ2arE5iEMoqKfc23s+9z3OLWAvbsft43TpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFAKg1nRI3YNweBf6zY7AAiZaKVTmkYCbRZS8vBqg+M=;
 b=ZRid/maQcS/wv1m7kdGE/AhQumtYBuiKnnOzPEjpAJfXUxY1eShLBtF9RyS0bf0eY8kWjK8zolu6WC6ZuIqEJTRP2WDCNMW+gj+qUv3YFkn9io/MtOGbRuZHOFuANheCqCR5zXaC9tki4K7YVDuv33buNPZ92fV7zIz6obBFtoLQddX0CbT7pV3+Aj5gV0khDAjPQX7yzCUIb4DCIvZ2LRIm/9VmpY3Zuhy55o6QsdfmzQwlHX9DKd4jxK7nJZjPTXXz3njehEt4pfkFcF2wSW/jTbvDJ63MdPOE0Q57hf9Dmmq8j1ZreM1vQ1pkgUh05An5arjcJTMl9/o/ODSnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFAKg1nRI3YNweBf6zY7AAiZaKVTmkYCbRZS8vBqg+M=;
 b=QDFvMWTSzmUhDlIqlk6dpCsbPBwd6VACWateJjvNI761q/QyngkM2lNRK1QO9MdryEzAguNPDP30mRPtlwXiWfjiLMVZv9m3/rgfCwbgZHEvbZqCtLgbEzB4D21/EFMNNkgInSvn8kOx/Y8t1BzWkeJz5J82zIdeuAMCVh7x5gYQMQzVVKQzOfTkBOuuqhrQPp1wfuOwdL8UJpHp3GtbWZzBv/Z2mE4ky9XhJYDdCiiXYI+/WH1c9MAnAOYumzC3Wr3VgQO7e3bKhNXT0LqXgLut6s+fYacBPCEjYYdsdh4llSiKZeodMaDABU4JBK5UqiNPy2l776gKCxfCauPQmg==
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by DBAPR07MB6504.eurprd07.prod.outlook.com (2603:10a6:10:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:06 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::ee) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 82AFA200C1;
	Mon, 19 Jan 2026 20:59:04 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v9 net-next 05/15] tcp: disable RFC3168 fallback identifier for CC modules
Date: Mon, 19 Jan 2026 19:58:42 +0100
Message-Id: <20260119185852.11168-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|DBAPR07MB6504:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 16dd6239-a663-47f9-9b2f-08de578cd1e4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UuR3Hw8j6OfFm2y8L7euJqKth4776saMCDh7aygUGN5n3KsOxw63I4pURGDc?=
 =?us-ascii?Q?SPvmVSmi7TA5RxCV7PAmYO6EUt3CSUVIeiSKqO0S/sJJv3D/oELquXNSwnuB?=
 =?us-ascii?Q?CufGScbhCgnCG/QX1W2u1eHYhcDmheczDZ9zvpI8cebfBiyMAzQIFmEKwej4?=
 =?us-ascii?Q?Plk9VRC9sTcsDbB22B4HQNEtzGMWRqe1snzwGRdcDwRZqVyeL7BuIOKhdtTs?=
 =?us-ascii?Q?FYJZYwOcDZQc2dN1xACOXgGzCMSd/45Cvhg8yMpw/b9ubOlkcC9JjtQOdNd6?=
 =?us-ascii?Q?MjKk5ObSmfZWTvsNnJEp26mWfFEFJY5hYFtnFtCZrh/D9RWTA/lz5t+FCEnv?=
 =?us-ascii?Q?0IywHfga5rGCgLbkzbLlVZgmTPI/5y/5UmWb9svOBU+AANb8vdwQmWjiOfii?=
 =?us-ascii?Q?nomNF4p1QJ3ui7bnV6i7TUpz28vv1cD7cqZmxl0DiNH62gHTBqyApEF7lpoO?=
 =?us-ascii?Q?5gbNKSi6mlESuc9qz9GsEWePmHG++DZbjeHQ5Z8NJz7EvoLDveOIPvnAVFzE?=
 =?us-ascii?Q?Ef3BQj+uXNo1Zc5EfEa/+QPAhklhG0SE5INxhMGwCEJ5biCe2ecUAqamuZEH?=
 =?us-ascii?Q?ugObUU9YlQkHWLLNZVAPY7ef/BLDUmb4shFhlmxnOiaAq7cRnxdBFsMd3IpV?=
 =?us-ascii?Q?52QtrAfMVm+iVgvWVKF54QqLRB8Wyx5DRerDe3/dnnA+x/RAWxjabcN0TAdb?=
 =?us-ascii?Q?1ScfBYKfeBraBqtveq58Bcj1fJX+f0IJudr5alM5qtaOOKP4aPwOScXsUMmN?=
 =?us-ascii?Q?HbTxf4bGqi5akhdopf+X8dasTGejTFxkiKhDi2dwOfrGbyCUXBDMCZ1QWGff?=
 =?us-ascii?Q?8Y5m+D0lFCpaFXlvSEXB85fTsTiW2QXiTago8CT5Q9tF08B20KiwhTYhnLbp?=
 =?us-ascii?Q?dYQPC0MbgA5LQR5so/gXcPUIT0eaTwMHCFlU8TyDfYLoceqhavfM5TWqqFD3?=
 =?us-ascii?Q?3jMw74On+xIbBAEFfHSdY/k7o1ZTzGD4XfH25woz1nt56S82qM6VaT6Xum1/?=
 =?us-ascii?Q?O0mjp88XiQZxs0NGWFl6rtoK72DQqDVXySaEM1cNRl/NqwNqj81Ezef7KmBS?=
 =?us-ascii?Q?vuU87fLp+8DgQMfM4APNU2ZPOcUQf2W6fbNlUrB7PUwP0dbQ7ynVe3OuWD1j?=
 =?us-ascii?Q?PHU5bUFedxY7DIRhzj7/KWi/2RFlRC1LOFsgrvpbnul2TRD75WUzPHBGbQqM?=
 =?us-ascii?Q?YHzCmj2Fb9hwN6D2mPSezWUo+2G2dlELKNmH1plBNdm//ibcimVPM0q5pa1i?=
 =?us-ascii?Q?zxQ65yyc/vOkA+Zx68xKdsXzpvI7gfwAfNsl7GwSBVjlvNDKsagkAuHLqdA4?=
 =?us-ascii?Q?3uQ8a6cie0R4FU+Hm/WKffZNROvBxOmvcgpE63wlchTTDQ4ba3qmmqGEoZtZ?=
 =?us-ascii?Q?4J5bPR5C54qUaDJdBk7CRzbsJq5Q09DSxIP4I5LDKsC2eEz6Uw1zxKIHfr+z?=
 =?us-ascii?Q?Y3n/o53YDCOtsr+oc1KMNxK/PTZezQg/ZJVVR0I6dBe/zgDs2vDgufsBnQBz?=
 =?us-ascii?Q?eodhHeLevlTR6KCQcFnjSCnQl4Pg2GARSgmM0OInpY32nl+qfWNcqMjQDvhi?=
 =?us-ascii?Q?IiB7G836olYo4wcCdcXRWDqaK656NnU4mZ7O74NKYnDbQKX/tSXyC1qYeVLm?=
 =?us-ascii?Q?Qu04rzUoPKIGSEDzE1mdqfAZfMgQTbm/1etbCYTC+P9CrTSN5dkfSzS8Hf/5?=
 =?us-ascii?Q?k7B7nw=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:06.0675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dd6239-a663-47f9-9b2f-08de578cd1e4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6504

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add empty line between variable declarations and code.
---
 include/net/tcp.h        | 12 +++++++++++-
 include/net/tcp_ecn.h    | 11 ++++++++---
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  7 ++++---
 4 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 41c781b6fff7..426571272688 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1207,8 +1207,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1363,6 +1366,13 @@ static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fdde1c342b35..2e1637edf1d3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -507,7 +507,9 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
 		 * +========+========+============+=============+
 		 */
-		if (tcp_ecn_mode_pending(tp))
+		if (tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		else if (tcp_ecn_mode_pending(tp))
 			/* Downgrade from AccECN, or requested initially */
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		break;
@@ -531,9 +533,11 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb
 	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+static inline void tcp_ecn_rcv_syn(struct sock *sk, const struct tcphdr *th,
 				   const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	if (tcp_ecn_mode_pending(tp)) {
 		if (!tcp_accecn_syn_requested(th)) {
 			/* Downgrade to classic ECN feedback */
@@ -545,7 +549,8 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
+	if (tcp_ecn_mode_rfc3168(tp) &&
+	    (!th->ece || !th->cwr || tcp_ca_no_fallback_rfc3168(sk)))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ccbab5569680..e5c9cf586437 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6861,7 +6861,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index bd5462154f97..9776c921d1bb 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -485,9 +485,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
-		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-				     TCP_ECN_MODE_RFC3168 :
-				     TCP_ECN_DISABLED);
+		if (inet_rsk(req)->ecn_ok && !tcp_ca_no_fallback_rfc3168(sk))
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		else
+			tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 	}
 }
 
-- 
2.34.1


