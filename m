Return-Path: <linux-kselftest+bounces-44267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F6C18F5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 458A04EE87F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64732F748;
	Wed, 29 Oct 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Scrw/GI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C532E686;
	Wed, 29 Oct 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725205; cv=fail; b=d1t0il17Rr4crNirDrulAH+FjagzF9yYqTvtiUGTX6bd06UDyxqTfVMpwgoCXES9kicWucjZd+3zuw06NFRdz4vGAevrWjjKYBNGxmRGLoty2Sw8GwpLPUMncENOgztj4e9ZKcnDjODZhAFgm7qCt80gcGdJKQsCDu8Aq1KOITA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725205; c=relaxed/simple;
	bh=q9RZpqVrffaV3J+sagRjq+CHlYViTFY4M440rBIvC3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4UJzq543wnLu0JC4gjTa1s4BtkkZ0rvItTa6KlxQmShynSs7a6t1T6xz1/2/MZ1OxrtsQ+dC8e7ipxafWJY0VubID07yIzuA74iK/aGbAuDn1SJkoxl/UhHEcoPSFvRUo8Ct3Wfa0o14z51CjX89L1B8aFhztbZuLXKelFlDeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Scrw/GI+; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfrMUilFtmoYT00hmFGdplKDON+CsXSdDeFiFsePoV4lRjW51lARZ35LUE3uZZMlfrI4tZzdQZJkeXG1rPbkbrRxr8j28JjJ0o+TCIGPK9gO0NtNA8Ur4dBBRJRV6kDWAyM1bEVFNgzlyaYeBdtdy2P3wwfHB19QwJFbxN18L3VxqL1EvPHX5lBvo/8TtVuOgmAPicjEcNY/KlugDzflycKv+VxtjCDP880AN6MbKC5734G4uh8a4GF1CDFREg8FluBCcoWBTC4dh3CVzZwdFrNDRJhiZ0gv7k2uF4NsUWij5eTkVf2F98pMOor4Vf5rByur201qno0k/dFeU2J55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf2aQmvVsDpMNMoczWwROPUgccz2e/xvLLgSVBce2G8=;
 b=LZ0/VLL4JllLISWTr2ZeeQpeA9XuVHixAW+sZEHhkNeNaYJSjEdK6oyJxOvWwRuFz/002N6aeSwPvRXV0sj6PAqUUnedO+bMQTp+6AfuGLn0fGLdjoMlyJKoOyWR9AN2l5EBEBxKg2l3wiDV5ZfoFPy8GFgHGp0nDjP5LgVWRGoDzMameovwTk9b74/trtAk8Pa5TKB7uVBEOOHgIEw7Lj57uxoooZR84IsUVPMZWCnOrx417gYqvf6raaBHShr1QSWRroqYwB7GtwyopwoNEWXnoP4/tYvA0NVUaB8rKzI+GA44qsoeMqgtOUfm/KYziXZ+7GzxvLPhp8Mq9NAUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf2aQmvVsDpMNMoczWwROPUgccz2e/xvLLgSVBce2G8=;
 b=Scrw/GI+XX2eYP+tnMondVgodlgGiaRFut0UkZtyQlledugJ8bYxymivFNj8c3o8/0RLiBLkiQX5QsI4zjPZyAVfuiRbXsodR7ECT91fV4Ve0S72Z4jA92eBb45l9eYKRhd8bsF/Ifcy6UtVYEI95GAEpgVqbDjVp07yDgwOLw4cPOUS2ED5ZpRWUm4/QFwGKsnWwVDRptmhk0NIN0zD8FEKMbOZfyMQxz8Eil1arm8/8QiJrVOEBp7alReWEmoNvR9DE+fm+TmP576pRoKXzHFUHvoknMhLY5YcI509ew4CBAMpcIyFjYNwuMrEKdesAu+m98qNtoF7JqjV+aCiXw==
Received: from DU2P251CA0015.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::19)
 by OSKPR07MB10472.eurprd07.prod.outlook.com (2603:10a6:e10:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 08:06:41 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::c3) by DU2P251CA0015.outlook.office365.com
 (2603:10a6:10:230::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10 via
 Frontend Transport; Wed, 29 Oct 2025 08:06:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3E22520202;
	Wed, 29 Oct 2025 10:06:39 +0200 (EET)
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
Subject: [PATCH v5 net-next 12/14] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Wed, 29 Oct 2025 09:06:06 +0100
Message-Id: <20251029080608.92428-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|OSKPR07MB10472:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28d157d4-6955-451b-de78-08de16c217a1
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?3aIFe47zvE9URvDQegbbsmG/4rHs+b5NweNV4twnn+aNjEDvx8iFfCbAg3L4?=
 =?us-ascii?Q?/QfSeMtfvXLJukjgcIlvXBm4oYZcvsd1gSLKZ567fbPWlL3djBs9vH4TGb+a?=
 =?us-ascii?Q?wVHL2dWzrTzVg7G7OWHxqAPXfadOt122BS/PDsHZIeAeJkrWdXEyoBbSsZZX?=
 =?us-ascii?Q?vPD7jN04JOIjd4WJxRlaAB3QkVIDzBGcr4zW6Q7WrnCHRrdTDxKe71Cfzeuj?=
 =?us-ascii?Q?Iv0zFRT4xd2fYqdrn6eFBd+OriFEZzPwQPj7hzOjFZjhl3IIARbCrQbzJv0R?=
 =?us-ascii?Q?qZGFynRbeKm2ty7YYhXh64fq7bwhj7v/mK8A9JOlojI7GQ0TtbBswhXNvSUs?=
 =?us-ascii?Q?2xj9FX1sMg6J7guq32u0LF+whKbvegkQj1rqwyIqiEjoV2+BBmufdvTuprb0?=
 =?us-ascii?Q?V2lCZCNX32xEBv2ekwioyDIELcki1WudM0MJdRbjZxQqPbCHU6ZmmeNLpUHC?=
 =?us-ascii?Q?ohMa9HovGDIhINKV72DfEjQsefHJCTjXAqbSMH9u7m0TuaX8C3gQk2ouQSTg?=
 =?us-ascii?Q?KsBP53wdlGrH0LjqwKqH3HRUw2H0z80Pgi7kTV4Ear+xFezGQp/qJO3YAVMT?=
 =?us-ascii?Q?F6zhGWrsxa5SYYbxsVcYn4rXs8kK1gBsXo277oxdEftRsnJAejvoSXQDElUP?=
 =?us-ascii?Q?3LHHwN7H7D5A1JtqYqzmO1SYYCRKzYrvRcQV0kpoEZTd94i4jlqnRKgVyLMp?=
 =?us-ascii?Q?EGkVrUzDl7+uIFfOUBTiofynxt5QiDsqb1oaIQIocvjbpsMtgFR8soKwGAoy?=
 =?us-ascii?Q?6vaNCFPXPHpgnpi3Cnk3nXcddF/kl7BbGT4CAuRbV9J1h4S+HsTzk5VfX5tc?=
 =?us-ascii?Q?N8rhYTsunvIQu+mmwYm+I/EMdDn0EGudxWs+FdjNLcZRN2Jhg3STff+A53Ge?=
 =?us-ascii?Q?PdcW35yc+OPuZW5zukSiX+cWnNt/UClvVBHpLMlzA86nHcJ6Zm2ehHIa6NQX?=
 =?us-ascii?Q?4v40YUjoc0QZFW3vRmLZsq/ki8k4T4ffQG5L4yl4FgT+Z2qKoyzfO0jcUSTg?=
 =?us-ascii?Q?pT5qrbCdBuziJzJEpQ4p2ScQQ44tVRhtqp2cg4kfivIZjcm4CKZ2g82HYnZz?=
 =?us-ascii?Q?hLzdGVNnVFMyMdSjZ4ob83nezULYRsukRiwRa3DD32UwJbdjUJ4SSOD8yLON?=
 =?us-ascii?Q?5m8uimqS1nV/nDe2Rxh1ZpufAmC4W0N+wmcXqKCbWgywSazrLQtlj54ZP6il?=
 =?us-ascii?Q?ljpYut6eQ0w07u7+AkqK+B6Z/eMGj+KKYudtkLFyr0ObTL/hxhZO3Y6wQAzr?=
 =?us-ascii?Q?BvKSliSRjhg5yNLbmYkS0MfDyEXk5REnhcSNc6c1wybw1or2Oizn/J99plDq?=
 =?us-ascii?Q?8E4i6EiIoq4j5GEs2kNNECUI9huzM5k5OOjCxQql2q8ysctgdy3PfK6XdZLN?=
 =?us-ascii?Q?Y4aiDGo3bbU6vTmRaWhUvuiz1VYIfzgFZbMCWC1QU4X6lhm4dBZTDODH36Ry?=
 =?us-ascii?Q?/7HPOUb1wOiOTrls6Wk/y3CaM0PUxpwznniZstZ+rwjKTg8ZiOvd/xOE8VXE?=
 =?us-ascii?Q?ElJlSQb8m5P4rALgszKat0o3qUF5+beAKOoKdD8c6TOKQxZhBc3rf88wOWC2?=
 =?us-ascii?Q?amZXe45pmNRtHHTeWyx4AlobaSXv4v1mOXUuF/Xj?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:40.8312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d157d4-6955-451b-de78-08de16c217a1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10472

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 88a328e7bcde..c82b5a35db28 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -175,7 +175,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


