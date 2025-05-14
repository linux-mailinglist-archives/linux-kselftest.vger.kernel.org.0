Return-Path: <linux-kselftest+bounces-32945-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5506AAB6D9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F9D7A46A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA3327C866;
	Wed, 14 May 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="OdG64JhN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37FB204F9B;
	Wed, 14 May 2025 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231039; cv=fail; b=FHuOoLzuK4Lx/VVybdXAVI4YXJCg/LdAKHHgam00uyFBivOCdCfXkqCorG7SHRaiUjA12oyzBdri+gs56YoCiUIUoQbCKPln35PBnc5Hq2WehuEOOKzeAGIuFCVlFxPXZHBTAPk/Mh+ZwZyKbO6EC4sZwTsGkpIBcDCWj2ys8Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231039; c=relaxed/simple;
	bh=1pCiRVrGhv4R0XrPgS61RGmSnDL2HVJVzufoYbtWiTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lc3lchbHWAUcn2k1GlABELorj/H6h6y4cA6OietC2YjMcy/rVYF5rikOxd05doMGSom7Pidc0f9OA/1d+GP4bWC6T8JuIPd9i5J0OaNAEtapBShpL/9P9JRCsAqtHf5Mq+3oGxKL9PcuftTrBrpQ2GP0/yG6YLTsqxJ45aIRxwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=OdG64JhN; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcx4nYqGTTdz1CS63k8tuWgJAID5/VVSG0WVu2uAtPnH9RcPYoYiN/kkVUkqnEGeEyRgYd+6Wmuk9GVCAwatgKVuQarC79YEnYzeoNzseyYfcktkEPUixK1KrlF6i5d8G7HngRBr3zEJHfE02Jr+p8+qIn9gFlKCs2qD9CDY0ZIyQrqyg4afXdKpLhfPfMn0ksUcqr+/LVFqTLJ4xaTjpeLgu2BtjyoT4pyDxU3QoEWNIg7v9m4g5ZO5GqnIxgYfpp0cBlzQjkyhq9ZhWNWrmw/++a9ms6SU4XheH7Mlq6za/767HMK1TM2F5prrrg9xsg+LoGbC8X0sKWZeUe+eJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoGNrcdrYXgWHVsxSZNFPxnoXNEmlUXIofckmi/u/Yk=;
 b=MPpA527dHKiTFhGnFKXKUv1ZQMMnaSTdkYxTyruU4h1NDmWc84kfB964CUEM4dj+B8a8yAYOOEp20wdsXCxtxVtd8gM8aytI1yxQkZqIfPSuLPHIrX6QPv9xCcYWZhBfdhdyVI+WB0evV9HPQ4/9kR/4Jw1gJ4GsOyQiqRxxfCQzjmH+YS/+OM0fwvWmalmCmdO4scLSpfgcHJjcxU+TCfcKbaIbs73Veo6mVfagEp2wgX9hc/31XRTVo9VhVP41udX70dfQhi7YnVQNzImbVvVercVyxoxQrluaktt7umXg79CkaDX4MZ0qcFOhrMAcGs5svIQUos1k2qX+0oxzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoGNrcdrYXgWHVsxSZNFPxnoXNEmlUXIofckmi/u/Yk=;
 b=OdG64JhN2c15HYaQ6sm5tdb0iRORz/0S8oerK9bMxKqM8aiy4+ih9mDoU3a4tLZFPecaJm0dwFXbiE1vvNiQXrGM/RfAWsx02R1/TopVTZdHuYaLd5YhdfbfRrWOzGvm3ding//dzjNhxzIOEmoerxCT0tJS1ZzF94eutGDAdNNRdMPovOHqQJbEPNGvSqksF3qcQN2AHWv042RotP+D4pPCzrIs7U+0rcEUoqzBYwufU74mZigBnMIfcNztNbX5NcQYcWKsbPPOGN3KshHmdaM5N+E3jvh3iDBxfSU/4MwWLn4LsG6ZxoeUn8P+s2rXlQg6SvJPLeMwOebuQa4gjQ==
Received: from AS8PR04CA0165.eurprd04.prod.outlook.com (2603:10a6:20b:331::20)
 by DBAPR07MB6888.eurprd07.prod.outlook.com (2603:10a6:10:194::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:57:13 +0000
Received: from AM3PEPF0000A78E.eurprd04.prod.outlook.com
 (2603:10a6:20b:331:cafe::f8) by AS8PR04CA0165.outlook.office365.com
 (2603:10a6:20b:331::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A78E.mail.protection.outlook.com (10.167.16.117) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3613520094;
	Wed, 14 May 2025 16:57:11 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v7 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Wed, 14 May 2025 15:56:39 +0200
Message-Id: <20250514135642.11203-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78E:EE_|DBAPR07MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 7297405a-a82c-419b-2bb5-08dd92ef3a2b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UjM4WG95K3oyRVRreXlPTEhhTWZ4RmtmV0dwWExHaW5ES3ZlTlNLbWJxU21L?=
 =?utf-8?B?QW8yYmdQNmZoWmhvMXlycWpaRVl0WEs1M0JNZTVrampPQmhtYTJPOEF5bWln?=
 =?utf-8?B?d2dEbSt0a0tjeU5qRUV5dHNNZkUrSG1ubmxrdFRIV2Y3NHlZazRNQytXQUQv?=
 =?utf-8?B?bkJCMTJHY0JvdEFPMTNEc0JxaUlLRTNWNm9DSUhaZkRISVJ6Qnk4YXpiYW5v?=
 =?utf-8?B?cXdYd3E5SmoxV2pkNHFranQzUjEyRWE0Zmd0MytRZEt1dWMvSkNTaHcxMHZR?=
 =?utf-8?B?TUZSK0dTWisrNUM2TGowbjE1SHRnTm5nZlBaQ3hmNWxxUUdtQkhqVFIyWTRo?=
 =?utf-8?B?RjlWU2p1ZGNZaSt0NGZsZExiQnJ4bnJlOWExYmY0eE1mS2QxOHBuajlyeFlR?=
 =?utf-8?B?UkRBM28xMGo1NUtKUktTdVlsNENsVnBCNnBpRXgzWUFoOW1OemJWV1J2dEVo?=
 =?utf-8?B?eGhyRkFBb2QxZ1dLSUNoT3NnbWVkeXdiWVMxQTRGbTZ5TXhZMFRzU1p5eTc5?=
 =?utf-8?B?MkFCajNWWXpoek5qek9NWFROSk9oS3NBTFRuUndzMll1R3F2VGpqRkNCTWZ5?=
 =?utf-8?B?ZldoeVR4eFA5UmFpYzlqRzJvanUxYW0xYjdwMXpjOVJpYUhDN2xaUzgwWUFC?=
 =?utf-8?B?ZE5aand5bmxFV3dvdmluL3FVWlkwZlREcFYxV1RyQ2xYNm1LWWF4c1ZHYlBW?=
 =?utf-8?B?TnFMUXo4S0tPSTJCa091bUl3Z2tmNnZYOUhnekNnK20yVDlPbkpueXZ2Rm1t?=
 =?utf-8?B?NTBFNFEzUktEdmdHYVlRd1dIT1Z0REpWU1JrdUlBS0xxRjZDcUhnQmd3K2F6?=
 =?utf-8?B?NC9aejJmZ2t4N2NOSzJkcG5oSEN2aHZFR0xla1ZncjdGVzgwVkozYklVMGwz?=
 =?utf-8?B?M3JFeVJXelJOV1lEZzQ1eWhlODFYcnp0eWR2L1diOXNvSldybVdEVEh3Znp6?=
 =?utf-8?B?SjRsaGNmOURRWFdxZlIxWjJtMjZ2WUFhMklCNE04eDByc09qNGlpNzduT2xY?=
 =?utf-8?B?bVZXdUpGeEMyQlRYdThDdWZGUDJQVDBXb3BIRXRybGVFK1hZaFFFcE5ucHpn?=
 =?utf-8?B?NmQwTzNWYUYzR0FCd3dXU01YRzk5ZDV3ckpEcFpjdU5NK0xZeXJZTm1OMXFM?=
 =?utf-8?B?Z3RnUUo3Tk5JcHA1WnVIYnZDWnlXV3B0WEluWFdCQjhHVnBFYVlVNkRaTlBw?=
 =?utf-8?B?SnlxMFUydnE4c0YvTThtLzZyQ1JVMjM2WHdTQnQ0dHBKQzZKUEVOV1I3cW1p?=
 =?utf-8?B?SVNCZEpWZk9Mc1hQOXZTTUlmcDAwRHNFOTd2Y3E5QTV6WWJtcGhVZFNWblRY?=
 =?utf-8?B?bjYvMFN0ZUhoNGtGQnVNZHVZZFpISzVlSzQwNDJhUWQ1a0laQkM0QVVYY3Vh?=
 =?utf-8?B?aUxCUFJhK244d01Na1VrQzJFWC9HOXJQWU9KZTMzREpzaVRRWXkwazl3aXJR?=
 =?utf-8?B?QzlrUEplcTNER3ovV3MraTlReGhKWEY5dXQ0WVo4L3ZFbXA5VFBWdWFIRWhK?=
 =?utf-8?B?emU3b0NCSzR2dnhvWUMyRlpuMkRoWG9haWwwVjJMN0pjSFVCWFMxR3lMV25J?=
 =?utf-8?B?eDIrZjJwb090VGg0VHAwcCtxUGNBeTBpTWdvaXJMSG9iYmZCcStXMEhzS2Ix?=
 =?utf-8?B?ejNPdlZpcGNaTFFQbzJWMXlaRzFodVQ4TmJJMGJIUk8xQjR1M1BqTkw0UDhj?=
 =?utf-8?B?ME93Q1RveUhMcmowTFE3SnVmMDM0WlZUeUI1WU80UjBWcjRMT2pNNDMwZTJw?=
 =?utf-8?B?YStJTXpFMlhXelpXV080WGVlS0lIaklhc1A1YnZjdEhuUDlva2dFNkZvbWxz?=
 =?utf-8?B?aFhsc0Q3VjRxSEQ5MDNxbXI5dEJNa2RRaU9RcUVLK1FrRmNPQnNOK2I4U1J5?=
 =?utf-8?B?RzFCUFpNSmJGb0xRWHVqQXNISEhKbVFJdU56WjNMMmlZL2NDY2xGK1R0aGJM?=
 =?utf-8?B?bnc4b2phazl6QVZMTmFpSXFocHlKWGUzdkF6U09ZbFZPd3gzRXRaL3oxbkoy?=
 =?utf-8?B?NENXTUVzem41aTBpbm9PQUpuU1VZakhKSzY1T0lhNWozL1FUMktiTHJLM3RI?=
 =?utf-8?B?WXJOaVNsTXc1RGNmbEsvMXdQVno1TDl0Qmg3dz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:12.6514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7297405a-a82c-419b-2bb5-08dd92ef3a2b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A78E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6888

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5e4593e39de4..201326b10396 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -247,6 +247,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c93e4bffb23e..f206c1a93a56 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -709,16 +709,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -741,6 +744,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


