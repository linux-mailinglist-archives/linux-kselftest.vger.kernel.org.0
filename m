Return-Path: <linux-kselftest+bounces-44416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD133C20AD0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B5194ED243
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C902BE05E;
	Thu, 30 Oct 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="h+4AKr4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F11274FF5;
	Thu, 30 Oct 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834908; cv=fail; b=dsKSlwbmEmpgWlPUNOSIGLIFyMoXtqoOQDRMObL4XnGOHgOr2asP4lPqhg5dqlVIh1XLMAK6GJwoHlzQZc27/xTVDQG0PuwrwUEFJZbPXP3nQM4Exts7gobMOsfLfBVMvYZipd8z5/6R95p0N7qF82P8cMhar60jdWAmsiF6TpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834908; c=relaxed/simple;
	bh=QmJXIhNcRZodT/SYCTJLz8cCDxH1bJkqvPdEA6ECA6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ+jXc5GlxuSx9Fr3RoQdA+DJF85QMw8c33vvI3vPI4IxbOGJ4b05HoWcj1agvronskf1vAWK/CcaOmU2xg85QWZu3G4vFDQDB3cTA0AIEgo1LATHZvQhPd4+n6xuobWBP+jMU0YLab1/Pi+ScDOkzZ3RPe+Fijdb9uHneC2niw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=h+4AKr4s; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9FvNK+O0cL7jF/Cg9Fla1NyAQ+My+j+iEtFym+pmHI1XjBFuQXJg0EtGExQ9sR6arZzb0PqkHI7vdRdTCtnnqik1uBHcUpUnx3NROiypOk7zuy7t5yjJMoK7LvCN+MLW3BvLt7rbmP5W4AdTH7VryWOl6XAenF8oTB6pBzMOvOyHc08CxqFbqZ0DTkiA7GSg64CiUwdOMKySh6Y9wjLcq3WvOhTTyXpc/rt/Khn21JdygANoj8VqjgzQSL5FAQsSR6VE2zMPA+DBMGp//VrANeTrUgcJKiJC9VJQv2GUpGQXkSovwM4IsbbVfHb0uhd82b84rd9apWa/8pT0XCuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icRboDRj2tx0EaYz/S6i9ohLv9droqiuEroIz3TfvM4=;
 b=cCz/8RV8LxPKc7Uy1MEYTn00dznKb0COY3DfHOUU4KnzMUhdYFqDkPBzWp5b+aCAYv0nTGiMfaPG6INPxpKgx21FAGC7Dl8CFIuaMi8UnPucXx+AlwQGHLABXICciTqSZqKqbuaURTi6xk8eUHXansPikwdxAHS6/lQDT97tc9A0DuIVFqHku9DJ7EPonzVQH8xLJqZ0NF3oB2AfaeKAcEY/126fK6YJWa/g5eludPOfLbN83n+H/Xs6JITwScuhG4Z9Lq6Exk0vhW66mzQTpKB2+/SPPgiokMATxZ5jDGjb3OrdkPa5TPe3UhppNGl1xehOV5F+ry2AJ+57GhNIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icRboDRj2tx0EaYz/S6i9ohLv9droqiuEroIz3TfvM4=;
 b=h+4AKr4sR1chDz39fEVp1APSSkLimFSgfhLZ1tUd2LCUbEmIULmQ0jUKDViriD6yXW8D7HpkUNs9me02CFrRIioTJpDAGoyWe77GHMCPpTrJe8wYuotIwg/DCsopgYRZVsaqW7/SLnnZRgUnTpKcnRq0vIhxnef6jC19/GS5oQoYtTj7xm4Dz8K0hSnCyOikzQGhznpNJ11vPtUmDTPqXrWyXsab6c9NQmLEygrQfbZNGkX9fhnLNc4YTNuQHoIih8TnYTyts3tMlCUtRL63pN7JT7iiuja10MQThXpz1REdyB2v2RFx2OJaTbYvztQix2TstAT2L1KpmnFv40JtBg==
Received: from DUZPR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::17) by VI1PR07MB10043.eurprd07.prod.outlook.com
 (2603:10a6:800:1e2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:35:02 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::5e) by DUZPR01CA0104.outlook.office365.com
 (2603:10a6:10:4bb::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10 via
 Frontend Transport; Thu, 30 Oct 2025 14:35:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 12CAE201E6;
	Thu, 30 Oct 2025 16:34:59 +0200 (EET)
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
Subject: [PATCH v5 net-next 13/14] tcp: accecn: detect loss ACK w/ AccECN option and add TCP_ACCECN_OPTION_PERSIST
Date: Thu, 30 Oct 2025 15:34:34 +0100
Message-Id: <20251030143435.13003-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|VI1PR07MB10043:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d6ac3aa-6df6-45ea-9e43-08de17c181c9
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?d9hH00PXt8+7Kd9Tlv1f6t9BKb6xDREe6Ck3cpKZIebViSgj7CEbLyhXr118?=
 =?us-ascii?Q?r1cxo9pDqK/JlHHPYoHMQAzs8e2/OZBaBjRp8zCk5KAJrs7WcCeAMz3wIA8s?=
 =?us-ascii?Q?hTq3EV7MwmC+5KI0xcIeRRhTTgvqSAwhv1T1MeKiIMZdt90+UWZAK6lpLgFq?=
 =?us-ascii?Q?Ole2GiALcO97csXSLbXcSj5eNEjNrWsosrS4wsWUsZ+tJxiQfFFapq1hi6y+?=
 =?us-ascii?Q?dFno1Zhv5uCiKZk5pJJj684VfkX8XnZhIrtTm3hCK69nUhzq9VibJvxRLLwu?=
 =?us-ascii?Q?MZab5fJVhA8qRy2HXtd9IL4cyAKAsJ6eEzE/n8gobnNmlOsG1TFv+voowisA?=
 =?us-ascii?Q?dEVIXHPW4p/IzIVavXhtjW0q/daYI0xgesxcl0Kfzq4ZUtpyHQHnYhtX/Xfo?=
 =?us-ascii?Q?BRRpm4e5Fd2+HzDnohc2ymkrBfzCK2OlLICxzRUWKbwGDomEKmT4FQCgzPjn?=
 =?us-ascii?Q?RpZxyc1JRSS2hRFumJU+wI6vqZAqSFkftWxZJ+Gfl9KX6VEejMlzQkCQBw4e?=
 =?us-ascii?Q?RDApFWDGVa0yoEV+mTnItigNSfgcCE+FSsTEqBS47qgONMN8Vr+ueUmQEBuB?=
 =?us-ascii?Q?GPTJ2wucwh3DmmG72RF1lW30+e9KA+gN7+nC/7NS+QNMuMyUqhaUF5yGVBCd?=
 =?us-ascii?Q?MRmEf+4utl/9gdQb2hBbhtpjX68LnyLHiAMoB3V7O4JjfADN0zrL4VNoQjrQ?=
 =?us-ascii?Q?XLsMovgnxKWpSd4U49ZbNNGG9lcV3HO5Y3GyS+lKDWpttgbZNyK5ateH9NT2?=
 =?us-ascii?Q?RsZXvB9Lf+LgPfzqzq3Yxau5qJksSw7r/rsJE/80JZe64hjxnf7G03XcTk+I?=
 =?us-ascii?Q?D17m4Y4BFiegGC8Eyatl2k1q1anOk8I3xgTE07MN30EOLrS2iInnG81f/oQ1?=
 =?us-ascii?Q?pPrGk9hkyjOHieOcAmKynMK9kMoxVN39lXUNNbbOiptegTglkZicgvY30DE4?=
 =?us-ascii?Q?b/1+V7OyaIN+/S/u8QiCp2WIDnV/zMy/NJe7pZcJM5awhpFTJX53dE606Z6m?=
 =?us-ascii?Q?eM0ZhAtNHJNX/RBdPfJDOOMiHEo4hhiBHiVk24LIzjaqyqryh4HmQ8KM1n6I?=
 =?us-ascii?Q?BX6swoISAUfcCD0ZVEGkEl/iXV8yagMbgTpwe4JfBMcpiTMmP1l0CZIng/eO?=
 =?us-ascii?Q?KxcqYmdPINRTvR36uNDDGWmxACGfGkK6SxE7NqL/pBOtc96kI3J9+70nVovQ?=
 =?us-ascii?Q?6+am2RPAh8frg0vIDOr1eQHY1QEIh1YbQJfRA/IYtDf/QBDZidwinwXVVtLz?=
 =?us-ascii?Q?uVIAby2TKZQb63LZbZdmCGyubWh/BYChxoOsxNr/MalJYOATE+10+l0Y1zLl?=
 =?us-ascii?Q?LYPqvB7y55fjLVCc5bsFPBChIY8zenHNxjAPNWOdm0Ze/wul7NWfeBskZRzF?=
 =?us-ascii?Q?h5SdIXGh/HFwDILcEiI7tNH5le71pL2SAuOJbWUGkvcQvuQtwjYPbp5ux8IM?=
 =?us-ascii?Q?UOR7o3bKCLYIo6/B1vwg+DPImo9D7/qqspqW9uZgU0FWX5bmGh3pS2zwTn8/?=
 =?us-ascii?Q?gu89jf+CRjvEd7e4SrbTJutisYrOB82tlX+WMkgTZA86gpFQrsFfmXBNY6kT?=
 =?us-ascii?Q?F9ZVlc3oSMn8/peSqO4G0OJbX1BW/moqxFvNJGCN?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:35:00.5972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6ac3aa-6df6-45ea-9e43-08de17c181c9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10043

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Detect spurious retransmission of a previously sent ACK carrying the
AccECN option after the second retransmission. Since this might be caused
by the middlebox dropping ACK with options it does not recognize, disable
the sending of the AccECN option in all subsequent ACKs. This patch
follows Section 3.2.3.2.2 of AccECN spec (RFC9768).

Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
(TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
persistently sends AccECN option once it fits into TCP option space.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v5:
- Add empty line between variable declarations and code
---
 Documentation/networking/ip-sysctl.rst |  4 +++-
 include/linux/tcp.h                    |  3 ++-
 include/net/tcp_ecn.h                  |  2 ++
 net/ipv4/sysctl_net_ipv4.c             |  2 +-
 net/ipv4/tcp_input.c                   | 10 ++++++++++
 net/ipv4/tcp_output.c                  |  7 ++++++-
 6 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 7cd35bfd39e6..f5d9e596ee61 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
 	1 Send AccECN option sparingly according to the minimum option
 	  rules outlined in draft-ietf-tcpm-accurate-ecn.
 	2 Send AccECN option on every packet whenever it fits into TCP
-	  option space.
+	  option space except when AccECN fallback is triggered.
+	3 Send AccECN option on every packet whenever it fits into TCP
+	  option space even when AccECN fallback is triggered.
 	= ============================================================
 
 	Default: 2
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 683f38362977..32b031d09294 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -294,7 +294,8 @@ struct tcp_sock {
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
-		unused2:4;
+		accecn_opt_sent:1,/* Sent AccECN option in previous ACK */
+		unused2:3;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
 		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index c82b5a35db28..d6ffa8492365 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -29,6 +29,7 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_DISABLED = 0,
 	TCP_ACCECN_OPTION_MINIMUM = 1,
 	TCP_ACCECN_OPTION_FULL = 2,
+	TCP_ACCECN_OPTION_PERSIST = 3,
 };
 
 /* Apply either ECT(0) or ECT(1) based on TCP_CONG_WANTS_ECT_1 flag */
@@ -406,6 +407,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_opt_sent = 0;
 	tp->accecn_minlen = 0;
 	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 0c7c8f9041cb..6695a6022539 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= SYSCTL_THREE,
 	},
 	{
 		.procname	= "tcp_ecn_option_beacon",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc39056d446f..ebedcf0ea0d0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4802,6 +4802,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 seq, u32 end_seq)
 
 static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 {
+	struct tcp_sock *tp = tcp_sk(sk);
+
 	/* When the ACK path fails or drops most ACKs, the sender would
 	 * timeout and spuriously retransmit the same segment repeatedly.
 	 * If it seems our ACKs are not reaching the other side,
@@ -4821,6 +4823,14 @@ static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_buff *skb)
 	/* Save last flowlabel after a spurious retrans. */
 	tcp_save_lrcv_flowlabel(sk, skb);
 #endif
+	/* Check DSACK info to detect that the previous ACK carrying the
+	 * AccECN option was lost after the second retransmision, and then
+	 * stop sending AccECN option in all subsequent ACKs.
+	 */
+	if (tcp_ecn_mode_accecn(tp) &&
+	    TCP_SKB_CB(skb)->seq == tp->duplicate_sack[0].start_seq &&
+	    tp->accecn_opt_sent)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
 }
 
 static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d52229d32b4d..41e9a7a50538 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -719,9 +719,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		if (tp) {
 			tp->accecn_minlen = 0;
 			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			tp->accecn_opt_sent = 1;
 			if (tp->accecn_opt_demand)
 				tp->accecn_opt_demand--;
 		}
+	} else if (tp) {
+		tp->accecn_opt_sent = 0;
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1191,7 +1194,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
+		if (ecn_opt && tp->saw_accecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
+		     !tcp_accecn_opt_fail_send(tp)) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


