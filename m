Return-Path: <linux-kselftest+bounces-46822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE3C98505
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68A904E3BAD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FA336EEB;
	Mon,  1 Dec 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SlA8W8Vg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012004.outbound.protection.outlook.com [52.101.66.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86733509A;
	Mon,  1 Dec 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607122; cv=fail; b=NY1tnl/CQgFuJdqooP3V+163Z8EPbS91wRSH61s+t6blKCc71bB+254xwidczmRnlObnD+mb2nL1Fr+TWa40inmEQmVnps2DEFasXiBKJpGnCRPXxoXyltQSNscRGleGjlOUYhZjZ3+4HYIBQNMW+GsJNTXnV+LxK3NfSe6jiXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607122; c=relaxed/simple;
	bh=Yz3LVGKV7GdIcFJUkL4roqvIAGL3HUpZUX4u59ThZzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDdiBEnrIiY/4LrHunjB+ltBtVuliEHnRtv6rKyn9oe7RvicpcjCDTuJ542henTX/zre+DG1XChBmQ9sVpvw+my4ww64R9KbisAbYKNr6zzjl9nqdYVYrwCFQ14Awb5J0LklErTKUilQ2Ac8kIVTqpAyd+8gv0rZBF0rXky6H/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SlA8W8Vg; arc=fail smtp.client-ip=52.101.66.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8nKeagkLaGm8qe5VBkAuL5ircEkTZNIN/eU5+qQ3JUyA6NvX5Ovxh+K7c9NwGU4tvug/fThiEZsdjbIMlGwlisQh1K6F7NECCfDeR5WBmCxLffcky9y3pbzCdTJ1PjjAT72IomXadwvMAKkvoVWmyIB1TgdMxkDnlyD2Ky32h5kR5njEamD0rcCuHkgaGUe1Ph6wyIkiijD7wi3c3MAKPIhxtCmTuK+YoDgA+2HTF0AR1Hcg+/uiEKJAYJ1DUPYvH5dofssEHlsHYURZDz3bZBGSTJ9Nvs8VXNKpnj/Gu1VIe+SshbKtRyA15XRbOUOkynPJeQbHFIDry7fj5BF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=kEZb1IV/T1g+Rf32PdPGSibW+8J5JNDNeZmHpzPKNPkFE1m11gP8/lMIKXG5p0EaMIsk5HT0NRPrSEHfKI5W2g6B6Oj1vEUcmInLr/N5aE8/HGumA6gurIljjaiuPbrCOti8C2+zpFnquBYaDF+m+JPdaAqr+NljKoLCt5FJ2oe0UfrrhESX8Zuv2ExGFq8iev5UN+AuJq/IExivc8v8uMzVps1J7IAEbabtdG6Suwo0D3Ec+ld2IiAov2Z8m7R2CEKrdaZxOQ5D0vtGs4Mm0sBhF3Hbo6fO+iJSP5uqUXvYm+hBuJNG3Y1A2VaH/zML9mteouxPObunXNHT/tFbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDGFihql1RCEocLlYIjABFWzIvs7MY+rey6BXk4miuI=;
 b=SlA8W8VgpEABtfUySUdS8CJXrkUkHlcwCIRGeRWXuWO0L3wldo5EZxv0ZGJP9f9SCqj8t0bhVApn4W2z3gBZ4oZPJutnIqPGC2R0rYmpdlp0RS6pmTkbZMI05crnuza7iFrBhJNEh3JSK8cppWNlRJY5zuVbBKcLbhqhsT9bY60YwN6rfGxmo6y8zAUZEcxA+JvrZvI/mDyPHcRVOIAwUGh7zNzYzTI/8yAQolUDNMWR6bgYp5I2Y3PdirvBIWVhe9clEPhg7jc4OZg5hXxeFuQDngu0WaGZuB/oao0HlsRZQl8COtRNb5nVt8zQJYD0fBOt5xMCRAoA326EwyFWOQ==
Received: from AS9P250CA0015.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::20)
 by AM8PR07MB7650.eurprd07.prod.outlook.com (2603:10a6:20b:248::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:33 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:532:cafe::76) by AS9P250CA0015.outlook.office365.com
 (2603:10a6:20b:532::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:33 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 92C75680042;
	Mon,  1 Dec 2025 18:38:31 +0200 (EET)
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
Subject: [PATCH v7 net-next 09/13] tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN SYN/ACK
Date: Mon,  1 Dec 2025 17:37:56 +0100
Message-Id: <20251201163800.3965-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AM8PR07MB7650:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8472aecc-204b-4664-692e-08de30f81149
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?cjsvGi/lXI8A1LgyuNiwz7AdAOJf89hDW4u4y+egpW7xSR83iTd3ihHWuw+G?=
 =?us-ascii?Q?P+218X1ElLWvW6kfuYCoZySLMBPvb8rWCR7mWs4Mdz2Ao+tATpGUIeoPQtDY?=
 =?us-ascii?Q?ovkpoETENxFilJTBPNWRvGTcZMkyd2SDhSIBXr/9vnS3NrcUOSTpZSlzflhF?=
 =?us-ascii?Q?vCHDW6Xl6MoOm6x2opF/HheVsOssgVxngrN+VQmdCfYehRDZndyL+MYBoOUk?=
 =?us-ascii?Q?+hI7Jkv4FlViJJJvoqyRZ7HD7vUB4ljD63ip+e5nIv+yZXg71hb94ExhZ9ev?=
 =?us-ascii?Q?Y1VEtjxyeaV6kCkoS1oE2Hh9udWaxsGlsUmnkkOJFiiqIO9CbONQ7wvWWUAw?=
 =?us-ascii?Q?PQiTv1GPQ5qT8ZKFCPWXMCBwyM0MTsD7UXUQUgaWj9YK9AWi9qOy11bN6ZzH?=
 =?us-ascii?Q?CzxeH1fTMJv90FLOffCyimkiar0eEW7whWiyETzPuHVDWKpSqyPbPljOOUmQ?=
 =?us-ascii?Q?7DIDzFw9Ze1iE5aFnAG3C/JXXhW7XLtAJ2CLk0gR+nDg39duxcK5U3Gb9k7T?=
 =?us-ascii?Q?lSfeko9Gf0w6KOkjfm2OcyNdeKkBWs50Hmasjo0t+a/XhE5+jvNaz0Y9Im5u?=
 =?us-ascii?Q?tNPDCvgT/LcwUuXDlR9/Wx8wDEZ/awXwzOGc+DlKpnI9neOyfoQjmb7kEjA6?=
 =?us-ascii?Q?sNo/P1pe2ssudtMlc+g8Reuq6QN6byjQC+m+/43nqBReFgKV9V63+VP4uOEO?=
 =?us-ascii?Q?E2gMNEOhaJsSCROi7AQdhK2SGqdg4sxV+ijd+g6I8A50GqmtsMTqXCMzc93u?=
 =?us-ascii?Q?BYp5U/xedNpDPXVThwdSlsKpdnJg4myMFKTer7skT9ubs62avdyjI158Bnk7?=
 =?us-ascii?Q?yWwyGTuGMt4SeCASRaNEfLOW74RiZLFyqZlHwZghu3j5ZtdQVIf0T5IjVZD4?=
 =?us-ascii?Q?BpSo8fDGe+9s76SCnDaTtWNvykZ6QZIEp40sUtxG9Ze6B+zhU9oJuQv01kzF?=
 =?us-ascii?Q?jYJ9sGw8CivHF+mBIQt+oTHVxSxPiwEdPXy3J7Qc6+6YyltIZcZzO5SeiCRd?=
 =?us-ascii?Q?6eQ49pIGGFGS6khdLfC7FLwgn81YXFEfpkaAcEWa41VoFX+g4BCsUHS8xWqZ?=
 =?us-ascii?Q?oESa71bBfI0/wpbRYJmiAqOy5Y9AT/6lfrJ9HUGxllIm3qNIHbYnbB8IzFko?=
 =?us-ascii?Q?l+F0CRH5EShzpzVZFbR2AX9WI+tONuM4FdLqJ2B/U/5dMCZlUNp96lEDMuwp?=
 =?us-ascii?Q?GpOuf9s21crlYtX/6Z6G1qmbzFU2nYv4vwdiXKoKQcdAK0SttMAgC0j9utGM?=
 =?us-ascii?Q?1s0m5/NrvwJREcZUWBAfglhlP3EqnjDM7IsopVy3/9imh2Rt/7uAUFTLwqqJ?=
 =?us-ascii?Q?4EbefUiE3DTNmWLBX36CHxdrXIHdlEXNAQGfTXF5xBYCkduDiM1MZb+f+Pl5?=
 =?us-ascii?Q?OLAULHqmMzlXh+7JZL9tTiApv05lV0ZZjpwikRE9SAFAZcKdwioS8p5Er6AC?=
 =?us-ascii?Q?V6hocIW4dZLaIP5UowJj769ujJ+3OQGYoYVNhONAalZLtNR3xA6HwC1gRiqa?=
 =?us-ascii?Q?Z5RqF/0zbDJV/mAaPby+UZSeWg16K3c8SWCJ8tIJ0ojmcE0OziK/CErrYWei?=
 =?us-ascii?Q?sS/zCPRgNDcJ24iAK6P5YNVvnLb75LNMnrt37Erd?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:33.0885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8472aecc-204b-4664-692e-08de30f81149
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7650

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
capability negotiation. However, if the TCP server needs to retransmit such
a SYN/ACK (for example, because it did not receive an ACK acknowledging its
SYN/ACK, or received a second SYN requesting AccECN support), the TCP server
retransmits the SYN/ACK without the AccECN option. This is because the
SYN/ACK may be lost due to congestion, or a middlebox may block the AccECN
option. Furthermore, if this retransmission also times out, to expedite
connection establishment, the TCP server should retransmit the SYN/ACK with
(AE,CWR,ECE) = (0,0,0) and without the AccECN option, while maintaining
AccECN feedback mode.

This complies with Section 3.2.3.2.2 of the AccECN specification (RFC9768).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v7:
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout.

v6:
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans.
---
 include/net/tcp_ecn.h | 20 +++++++++++++++-----
 net/ipv4/tcp_output.c |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb..796c613b5ef3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -649,12 +649,22 @@ static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 }
 
 static inline void
-tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
+tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th,
+		    enum tcp_synack_type synack_type)
 {
-	if (tcp_rsk(req)->accecn_ok)
-		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
-	else if (inet_rsk(req)->ecn_ok)
-		th->ece = 1;
+	/* Accurate ECN shall retransmit SYN/ACK with ACE=0 if the
+	 * previously retransmitted SYN/ACK also times out.
+	 */
+	if (!req->num_timeout || synack_type != TCP_SYNACK_RETRANS) {
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
index 5fa14a73d03f..c6754854ad09 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1106,7 +1106,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
+	    synack_type != TCP_SYNACK_RETRANS && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -4004,7 +4004,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	memset(th, 0, sizeof(struct tcphdr));
 	th->syn = 1;
 	th->ack = 1;
-	tcp_ecn_make_synack(req, th);
+	tcp_ecn_make_synack(req, th, synack_type);
 	th->source = htons(ireq->ir_num);
 	th->dest = ireq->ir_rmt_port;
 	skb->mark = ireq->ir_mark;
-- 
2.34.1


