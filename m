Return-Path: <linux-kselftest+bounces-42522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20C8BA5B04
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B51B4A777F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332C62D6E5A;
	Sat, 27 Sep 2025 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Z7XrPT18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3612D663E;
	Sat, 27 Sep 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962901; cv=fail; b=CGA6h6E6NrQ87cfyE6X6I8fLLAKHOvNW99ws/Pn2tU93XPwfwR1W4ZDFNTO8kjhaVkx1y4s6jhuw73A2OVmg4TTZt34ey7TD/HkEXbhjA/UuYM0pOQil/XLrrV7g4fJGx2uZtP94zPcvLmzmgsvcMMHQQrRFUxd4rfUUxr619dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962901; c=relaxed/simple;
	bh=5jdhJbhmNfgeo478lNHkl42cVnOjwA7ZeQe966/H8rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDxx0UT5b0SIeTpMUIuVsHzQmou434RLj7tl5cWJxoZVcbMD6cYkSQSZjgsefr8XMri417RcDnTJUmPcZ3olS5DC5LfSYUMQDnWnTPcT4pjZGSZTdFLpUPtYowXCwVzd4Rk+1kojfCGvgfe71Zki1m9OWDAmsIrvRO93FNzR8lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Z7XrPT18; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vi9ssRHpGdBg2RlAhg61F1MK7tmf9SicChNGEQRnrMX++KkJ+488dXds43O4ytLvEqWDal9onpld18nQADNd1fQf1um+Iwh5wdrpHPGh2n1bjDNQNIb4aSpMlKQlQ7M4fPaEb80r+4nO4J/RaBg0QH5cRJJXhQ2GdTnOWhYOSk4zL6Bqui2Sr6JmYVPn23xMAnsn4FcjAH8Th7V5ZPOS9FYr8O5WT6kb6a7yDFonZZwwXxCJLCXjpoV7TZ2QMHVmbY2okZLpcP5RXrdj28lOholpuGnXdxfYW/pT9JCxwJ1/kD/GL5ZX8FyknnLxCIVnN2AtJ5j1QyeYAY1NGGkjyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoT8jk9w2FFES//kc5ik4jqL5dwCsJed4FSxN9WEfv0=;
 b=d75K0Jf4Uylsry2Uxkz4ADZmhiDkEWHXFmoyQ2VJRUGjraQY76BAOT6HojZfNe5PKNu4oqAVOIPNKjCr1HzPGaG/bwf+10i7ciAN9fLrQ141FiezfYWKPMFpevMBfu7bt8MoOAgM5RHvgbjQs+qohfjUfvswNTC/EDZe5B3xF5s/5iTWUTNAyUKL0mTr5GpV/qDGm5/fWo9xBC5UfFCF7lzIitWcXkWVdaywkR60m5YgFGwPLISfSMJgnLUjw7v/2croAACnOopkwLSMMaPDzEBiQfUXGvgo/WbaI3sruu1aV6bDpAv00N6pTjzzjaQCd6K7x9zNoXv3IGaALU3U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoT8jk9w2FFES//kc5ik4jqL5dwCsJed4FSxN9WEfv0=;
 b=Z7XrPT18mRGDYO8iKWF9WaHF+QzQy0zM7EAIxHXiNvtWjWwZfBGHgQaZR/B4uTId5rGz4dk4ukt3Sh2Q53IcLpFHdfmpNJ4BOUGOYrDOmaM/mzA7fXvjjOOpu1qCBorr8TZ4HcEfqOyWq7CIQqZGjaS0upepzGDsCnSxyLciBupfJr4ZFqn8YyI2K14jDQLMRTAd/z6jEinnI0Mf9HI4FIfzTvlzFDJ59IX/bChaSHbXMoqfHFsty5pffRjD62TT9YtWY6ruF8IgMZ3NiCu9GUEERg26EBTNcN8rPWZ8blnqyNYu0hawJwGSkK6oI2cxz/6amJR/CMfHuBmF6ETPew==
Received: from DU2PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:10:234::32)
 by AS5PR07MB9772.eurprd07.prod.outlook.com (2603:10a6:20b:677::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Sat, 27 Sep
 2025 08:48:14 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::5e) by DU2PR04CA0057.outlook.office365.com
 (2603:10a6:10:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Sat,
 27 Sep 2025 08:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id E2F9A200B2;
	Sat, 27 Sep 2025 11:48:12 +0300 (EEST)
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
Subject: [PATCH v3 net-next 04/12] tcp: disable RFC3168 fallback identifier for CC modules
Date: Sat, 27 Sep 2025 10:47:55 +0200
Message-Id: <20250927084803.17784-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|AS5PR07MB9772:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 275b254a-2c99-4dd0-b3bd-08ddfda298bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n750DxlbLpDdcj+MC+oN9XUpNX3JH8upOEHj/dsq8VNy/tqgtN/TNpCvbx10?=
 =?us-ascii?Q?eJ7/2mVw9rl+rFvRGJOktfBk+qmtzSEOnQIoxHRdBzaN5oAAHCJq5I9eaYO+?=
 =?us-ascii?Q?dRB9pG2oZhnPowyeoVzwKw5x7m35MpcUQAUdWvu4i4te1tyWJX6DcwJbZDwU?=
 =?us-ascii?Q?9o5NQMPxd6T6y2wK/vPihX6i0cSleMrjFr7lBLd+3d4IY2I7wZOLtpA4Q2zM?=
 =?us-ascii?Q?S3lq7IYUUtsMG1KwZvIvOF81QxSPjO07qDz3FVdg/SsS9W0xtdndNMCsJZUV?=
 =?us-ascii?Q?h0oqxtBWZ9Wub2MEYCgi4jU5VhnDDQNyePeL1U/ZxBg25OkRIdnj5e7vm9hf?=
 =?us-ascii?Q?vAC0Ygbg1dXNQYfduTT23USgQ7yT3TcS+CKeiGqD7YIwAC2P7+qCz0RRVJur?=
 =?us-ascii?Q?j9Xve8SMo3YR1QkpWdHvkd+CUEQLP+MGFGwRHpkoRXwMFLjWkAUBNQkpPgnZ?=
 =?us-ascii?Q?w8hmzpA0zKKSMthOlw+l/sLuY70yEAGUF+UeaJaLcBovs6udF8fVRpdTFp3D?=
 =?us-ascii?Q?iNItT5BkhAwYcI6XwWuVOeJoPkiTx1Qrd7CF01C6RsG2Twl+KVp5fQuHGQ89?=
 =?us-ascii?Q?jQ2qOe07FXE+Feg3dxWkGvHsrJc25g/+X2lsd+4wnDs0oln0KQlt9R05wyBt?=
 =?us-ascii?Q?LcDTJ76l0R5TFb5ylvuf249AAndSlQhhek2I1sVcHlud/bwDzQpmWgnUd0C5?=
 =?us-ascii?Q?6wVJSN6hi6eEkPuWWGlTbcxjs2hyacTxaGsuhnBMtmoT+tU2OWlcT64c/Mtl?=
 =?us-ascii?Q?EF3tlWr0byz9h0Izph9MdKNIe5gYTT259WO8kIvv+ENyS7Y8nEf3dJJbI6D2?=
 =?us-ascii?Q?nAMBHNK+3PYj0MEBFMxJdfgj3ykErq/Y2sKMGGo7X55ZTn38oKElkvb6OUkY?=
 =?us-ascii?Q?xIp9b6PW3nSzB1FUV1l6YwVVDk9N3dIruIMwmBmho8x5mD/5GKaxVWfG3e91?=
 =?us-ascii?Q?70jFpCPVhuvQKn8aFG9kLhqCQVjWdszZ+ilSxP23Rvw7gcrTGE5zOLoYfh7R?=
 =?us-ascii?Q?2QN4BfcO86zyHDIBC9r+a7kh6YLijNM8q9ZRjPz42g3QJJ6OJz14YUhcBoK0?=
 =?us-ascii?Q?rEwp9ACjS5CXsSrhJR/HjlFUOoATNHZ5VAbmGJd+SXkVS0Qyj27Gi1BImdsK?=
 =?us-ascii?Q?49HkajxXq5cE4Uea/le3FtOIhkDJxz3WceC1m/uECkFLturz3OA9NK27AKyu?=
 =?us-ascii?Q?v74UJeR7qRjd7N9c1M5pSfFp/r3MlZrqfZYWxxjivZ6CxZq7Uy/O2NbCzbOx?=
 =?us-ascii?Q?GzxUl89uSoiqizee/XcXTaW8FRVKpm2J7y0tSFQijJdhFwY47SFck1Jih4Y2?=
 =?us-ascii?Q?8PlQGNqoQdR6xh3TSwJjYy5VZj4zgiVQXypT6Up1OQ7VkSRp/suO7w7F4RsC?=
 =?us-ascii?Q?sr7M+Kl7Eyt2PDQgB/IAe7HDBUCu5o59nfZlU0HV/fSqPbwUL6F6sOS9PsRW?=
 =?us-ascii?Q?0o3btEkU8yXIojtQSB3oe+Ys9Md/BI1PHzrRT1k+3tZjcp0FE6/9iFPaThKk?=
 =?us-ascii?Q?wXEjc6o5WX1Z5k4JtXoNlqBKp3PaZXrrhUUtyZZjLCOj9cLpNSNGJKTiXz0a?=
 =?us-ascii?Q?+ZB0WlKGDtiGpUlqrAo=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:14.4562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 275b254a-2c99-4dd0-b3bd-08ddfda298bb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9772

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

When AccECN is not successfully negociated for a TCP flow, it defaults
fallback to classic ECN (RFC3168). However, L4S service will fallback
to non-ECN.

This patch enables congestion control module to control whether it
should not fallback to classic ECN after unsuccessful AccECN negotiation.
A new CA module flag (TCP_CONG_NO_FALLBACK_RFC3168) identifies this
behavior expected by the CA.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

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
index cb8901e02ccc..b7f52175e367 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1194,8 +1194,11 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NEEDS_ACCECN		BIT(2)
 /* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
 #define TCP_CONG_WANTS_ECT_1		BIT(3)
+/* Cannot fallback to RFC3168 during AccECN negotiation */
+#define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
 #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
-			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1 | \
+			TCP_CONG_NO_FALLBACK_RFC3168)
 
 union tcp_cc_info;
 
@@ -1334,6 +1337,13 @@ static inline bool tcp_ca_needs_accecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
 }
 
+static inline bool tcp_ca_no_fallback_rfc3168(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NO_FALLBACK_RFC3168;
+}
+
 static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 0cc698a8438c..a7ba21d298ff 100644
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
index 2d58fc96677b..5317d471a6fb 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6817,7 +6817,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th, skb);
+		tcp_ecn_rcv_syn(sk, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2ec8c6f1cdcc..1fade94813c6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -488,9 +488,10 @@ static void tcp_ecn_openreq_child(struct sock *sk,
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


