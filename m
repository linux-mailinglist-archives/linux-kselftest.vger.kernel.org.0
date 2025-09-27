Return-Path: <linux-kselftest+bounces-42527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCECBBA5B40
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAF17A6A1D
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0902D8375;
	Sat, 27 Sep 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KWL0H1eV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011007.outbound.protection.outlook.com [40.107.130.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7072D7DC1;
	Sat, 27 Sep 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962909; cv=fail; b=JiG6kcQN1Eb0+GarA+CgORu3HbHjLODRIRLU9djRm08ISuXQBtGkOx0VE+/SUozsOOqDtczCIfV0wGcC6baE9UAoQyiyv6JTcrLZnsFT9x7rpcyLNP+eEyy6ni5U8dOeFnnjBNoNJ5SOMZ7bHPOiGR//AhM1cGcspuLJp0ot9H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962909; c=relaxed/simple;
	bh=qLRf6tsFlfJhvv33FUSUHtZq9F41RybD3Cseg6xfygQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JM8heVUZrOqh7WAIktkahP9d3RgGUMG9caUHGHm+6H230UJAj1adN4lm1EMmx/Ygyu0Iv58urxllSBP2b7JsmCQM9FC76ah8/fUpjLufqKVxP4ZpYdcN8LIjzYi8Tt8hR7Sv8b/k4iDTCtWsO4ClWkptUColrah2+LiUwrxfQhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KWL0H1eV; arc=fail smtp.client-ip=40.107.130.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKEOyL5oqustHI9oOSY/AgGTPoAWX8UNeH+C2/B3oor2tZvQ4nqKFRrm8ZC2Dx7NKr/O5GChFVbmjdhewTDazgOMT9qL9clB7GaJ4omcyO0O1aGFXHVSLioR5iJuD3MPsd+H9ERJp90Yt/i5gLgp/FGqyBp3sCCyIk1gCTn1UAC39HTk5v+9Z22ZdY2WFS5ZeaTiYrMYl4IK4hC9Ne1wQ9FHolivzbBIAJc6NhCnUiQ7LYZsBz2XO4qFUDYUtn3ZBxEahB3pzGwgLusXy12CtJmrgiMmVr+y/+BriRzsvj+uBG5njxrw7HLAoYbZRyUO8iRKp3Edj7WbwFn3GOOrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=qOKGxh7GpdrJxeH5Sahq7Yegppwu85DRtuA4PsHWSBsao1zRnRmMSJ9gbTfC+A+8msEzAwYpooQtHmkSKK0ZgvF4o640ohi+CQWONxucINYIEuVJOLnjvfq6hE5NTgXpYDOBOeCvzsTmp6v3HflCfG2PIASbB/1ugf+zv6LgDeiXJdA1gCvkAtJTOVQcxCz6wZsRZ5wJ4ZO8XrqLCOmwkACwFd2yz8pzV/G7fXKklmCCZPRX9RpdAwr4t0nSwnDWMtvr7NlNHJc7W/8d6qcc/6nZ3XrYJ6qib4CfkBkBVi8Aj9Wl0luByHqnmnEcctRx7IJ65JuuzmHCZXW6I6OSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIXoxxEVJeU0J+r+cLHt5HUmRp6UqevqHePtnM/lsoU=;
 b=KWL0H1eVXcnYL/IbVSkGPU1trf9oE/GODo8jtrUNh6dTAlmuXHy3RzpiyvVVvcmMo/nNCkKifWijHWtltQMNdrOoZH/WELdZnl6rMesMuS1yabBuTGATO42WkCT6LstLguMobMTQODEOc3umZlov57sqFrm4eRDDKbGa4Fs2hfcTH2BsIDG2yhRih44Gz6Buw01ib9I8DdhksGEpem3r8VqBV5RoVGcP67aaaazkeR+6D5TQeqfN8oB5NKhA/Yi7QQcSxvj/0hivG5IQrKSK4ClOY51RJ0YkXTICImURhT6DsY6Ay5ZxHTbYQtPrBf3sCrTbhJChAq6GkDbf2NnA9A==
Received: from DB6PR0301CA0093.eurprd03.prod.outlook.com (2603:10a6:6:30::40)
 by VI1PR0701MB7023.eurprd07.prod.outlook.com (2603:10a6:800:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sat, 27 Sep
 2025 08:48:22 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com (2603:10a6:6:30::4)
 by DB6PR0301CA0093.outlook.office365.com (2603:10a6:6:30::40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10
 via Frontend Transport; Sat, 27 Sep 2025 08:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 74584200B2;
	Sat, 27 Sep 2025 11:48:20 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
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
Subject: [PATCH v3 net-next 08/12] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Sat, 27 Sep 2025 10:47:59 +0200
Message-Id: <20250927084803.17784-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|VI1PR0701MB7023:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5015edb2-4fdb-4257-6725-08ddfda29d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AFxE76Drya0pVu3n7OBjNOYuiiRaMWk70cd0FmxvgTaXqeV1rBOI7RT+NCoi?=
 =?us-ascii?Q?cU7bNcPQ/FkVEJahVVLisDhLUcl91SjuSO5PNzhhSf7ewcukoeyp6X6Zzucr?=
 =?us-ascii?Q?kv5IUmdEH0XOVJfPAL+SZ5tJHuR3ynnxr2FM7FWDjByRK9HEq+cTt445BG9b?=
 =?us-ascii?Q?RslCET6SrDj8UVxpxs3AXbn3lmzh49X4MwO13U/xX1/B0Ujz4NVZqG7ByRQs?=
 =?us-ascii?Q?E6LQi2aWx/IicBjeBEXeMslw4snQupcpJp5AleK4QKr0gUtBtWl7kMGJOVhK?=
 =?us-ascii?Q?PaFvcJw32jK4oVFAwUa9VIZ2T0N1Z38wiIp576/6ILjMxShir4570BO/y0og?=
 =?us-ascii?Q?/SmpZUlgDMUprnvd/XpysWV6LEua2c4RMgss4hfZ0iO3Jv43FMD91qIjlHwl?=
 =?us-ascii?Q?pNDefOTz/1R5QL7dRTC03nsFuwhCZme1S+CFCdBpGqe/vz0xLL9u4zuPgVVy?=
 =?us-ascii?Q?PRFAgQcWYeLN8/RgcBnqUBEcUZwq9/2g9Hm87QN6tOHcbnLcBvZpUPzWwtJJ?=
 =?us-ascii?Q?daoh0DCEiSGXDe5J141rIYwv/7afX8mS8xWKtmy9lsQlI2HBlxbhLxZZlkRM?=
 =?us-ascii?Q?tdc3UhkoXVYn432jN0ypgoTTDT3njVRXOPGdAvrH8qLpbZamwdxpj/K7z2Ie?=
 =?us-ascii?Q?GLQju1D3XtdJjHCPWtZSxlSmousUpTbCY3PLagFpPY/FLgCW1sysdvuGwyZL?=
 =?us-ascii?Q?mHT9ihK+dhbMB+dSiSy9e+3evJhuoPoohDPl94BElp4DTm86MURzN+pdAUXM?=
 =?us-ascii?Q?8X56XgiboZHUUuBnbiH0lpgBG9UbUlZvYnC9AbgQYyU7hQJtGkt6zRTFsiKE?=
 =?us-ascii?Q?5esIAhdCeJguqL3a5gRII9R+QOdurpURH2BXOffxGdoSn2N2sMNUMkAb6fMM?=
 =?us-ascii?Q?44ESXscPiupJoP1vcgWkh0LFSJl8hZhDJLClYrhaP8J8nSYf2IrEesiOOuOO?=
 =?us-ascii?Q?4+B1Mnxvmck66Ac76g78IIjVB+8qKtswi0/DYjAS0uCRKyBenJrg/pFACfpq?=
 =?us-ascii?Q?/6YXfZViVz2hfh+cgLF++cGvaMEG+s/ToP2fW6h+DqrSqD/JYq2Rn0c8Oaiw?=
 =?us-ascii?Q?Wu9AiRZybAgXulX1U/P7Y2kTyfDYCB9BaZeA0sacYPAzzaG43lw7Lh3vZVGf?=
 =?us-ascii?Q?vM5Sai55vFhN4bXaaINEy3xIUkwudgrxTgSUsonoQyRf8KZGkjSS9A3Co8nv?=
 =?us-ascii?Q?B2VUrdTq1ko/JkFuEGUR5tAg//vdffsD37Cu5Gpatm7SaRLvRSr3KcgD9kg4?=
 =?us-ascii?Q?JCn0ZKj+cjP9woHfLBOyhZ8VHkOs0C7aYHc1TWWpMNPuQEhafiVMj0jLv8ER?=
 =?us-ascii?Q?FRO2S+BD5m4FyKpAiVa+8XhPDj/4Lzx0cKRfq+Ni5bgLl9CG0Z3G+thFCGJr?=
 =?us-ascii?Q?c/wuiOp8Z9tmB6m6syR8JrvVa1Iif5FKN8FnNOXSo8VMJq4yOB5DmJwYDL71?=
 =?us-ascii?Q?kU7TePOWnkt+CXHYqZ2skYj6DlxVlfhbOtdu2A0Eb5lY/OJc9usvDr8t/gQs?=
 =?us-ascii?Q?WBdqVuwvUi8/z/6g3E1umFFcm17aFRawrb6mV0p8kz+dtJyf5aJhNW8yneUM?=
 =?us-ascii?Q?WEpPMYOfoWL/6wTPiC0aBuF75JNmr89g5Yg+rk0+?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:21.9434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5015edb2-4fdb-4257-6725-08ddfda29d31
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB7023

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

If the TCP Server has not received an ACK to acknowledge its SYN/ACK
after the normal TCP timeout or it receives a second SYN with a
request for AccECN support, then either the SYN/ACK might just have
been lost, e.g. due to congestion, or a middlebox might be blocking
AccECN Options. To expedite connection setup in deployment scenarios
where AccECN path traversal might be problematic, the TCP Server SHOULD
retransmit the SYN/ACK, but with no AccECN Option.

If this retransmission times out, to expedite connection setup, the TCP
Server SHOULD retransmit the SYN/ACK with (AE,CWR,ECE) = (0,0,0)
and no AccECN Option, but it remains in AccECN feedback mode.

This follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp_ecn.h | 14 ++++++++++----
 net/ipv4/tcp_output.c |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index c66f0d944e1c..97a3a7f36aff 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -651,10 +651,16 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 static inline void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	if (req->num_retrans < 1 || req->num_timeout < 1) {
+		if (tcp_rsk(req)->accecn_ok)
+			tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+		else if (inet_rsk(req)->ecn_ok)
+			th->ece = 1;
+	} else if (tcp_rsk(req)->accecn_ok) {
+		th->ae  = 0;
+		th->cwr = 0;
+		th->ece = 0;
+	}
 }
 
 static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef008736e3a9..f2e8a068f1d3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1109,7 +1109,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_retrans < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
-- 
2.34.1


