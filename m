Return-Path: <linux-kselftest+bounces-32787-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0A5AB1EDF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B723EA01EA8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5326159A;
	Fri,  9 May 2025 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gdfEowxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678EA2609E6;
	Fri,  9 May 2025 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825536; cv=fail; b=Dpu50xj0oK269gWyYtCep1IS+dc9U8UUwLlu+LrL3e9P0wnTVhSsFwefVoRwtj5yvw5FVopo/KJbZkuaGzyenv9FN5OTcQ1ZvNytq2CC5IYbIJxIcKQ3sgg8dB7+4AVdtZghvBhPnpSvPWF3gy5WJHi99nAjUiUobKyGiVy1AeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825536; c=relaxed/simple;
	bh=CZY/0reepkm4HaLsD9NvcxG4ZDT+ZoGF8jeSEf+8GeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z21pWwx3rUKfaQEVsbx9t1oouNpyoNr1MdaT2Sqa55GzKicFdMnXn9O5zwcAkjbQ7NCYbsyTR2ktaRCP70e7dP16s+nxh5dWCa0pWuczCFiojztQ6dmmcQThfbjKMurRES8Tx87FjFacUzrGaZ9IaxOxIj9xWt1ksNGuuRqMU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gdfEowxB; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLl6rUKqZucSxjVL8W5Oq6xoq9IrFO6uZSZMDcJwUv++lbeT04sAW2MWSk8phEEPvRoKAVSGE+rYHrDN4qDWWV0fZqFeX6aWbrl/WGQiiC33zJRMUL9eq4rdS4G4bKgdtd23R1fDml0wTuGwpedmWncpmlEPLL2Oek5ivxhVugSNrKAzmT/0R9aiFwdfMaOlC7yqnld8Z5c64rSkMiTysHu0SY5eJmFApSTS62ohj7vqbt+H6zoxoiI6cLB2yhuaHd5DKvTntWIpzIQksKJOy5X84E3pFLzBZI7274CkHfHVkefp7UA7YeGPZzrwri5XmcyI8GQ7f27vGBZVlhLRYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFHMjzcanuNcCtmScpnJuy0JONegzutUxgTXyp4JaTQ=;
 b=HgOGI6SC1K+2m286FEdrXnEmLKVSNbzV9OFGNCzC2n8EJohmtvDs0ySr7DElsBrihF28Wm7RBnn8U8lNWkulxUCh/o9q92LTl/a6aL0SqhaljSjScnvuRI1ClNVEkPIodyS7YnGaWWrRb87yAg4ORYlQjnunAm4GDrrN9xEPdcarrYolFvPWT6NhrdBLeH9ur5B77kGmqLQH2SybjUuvkLNP1nkobR63gSFbNen7lynF4cZC5AXg9h2slzhDLBs9UJuxMmUO8hVx7TxI61Mqlf56db7QZx0JzozWdYwRkf3ku4iL/WYdB8g444GNquC2S5ztjtddag/QmWMCDb/+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFHMjzcanuNcCtmScpnJuy0JONegzutUxgTXyp4JaTQ=;
 b=gdfEowxBAvudr7wP1rEf7YuuUXr6vs0llLrq215zlE4TurcMNlrWevMWPJRC42UQndDKAdkhYxVabUSuc2UENatnXJTHLkRhhnjXrQqr2EfA5Gktc1LOjNCDb9N5LdAQeu5Lz1GONjR7K+3Qqjj1U2w9gHP+xwNvcDsRG7ydOKXb6Evt9ZY0gDEB14FwOVKhj0a+4ZrL/ylj3JanTlzWI3om99PhmUmSAI08VAaw1Rk2/GhhOiyu5zHehJOkGjradr0qhYPKqkHxgd9JD9XMEIVLIC9raydHvc/dO/XU5NSXDmtDYJ3/N0WGusRvSQcd2spa1jOulJGtuPOsKNXQqg==
Received: from DU7P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::32)
 by AM7PR07MB6899.eurprd07.prod.outlook.com (2603:10a6:20b:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 21:18:50 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::18) by DU7P191CA0007.outlook.office365.com
 (2603:10a6:10:54e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Fri,
 9 May 2025 21:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 83EF3200B9;
	Sat, 10 May 2025 00:18:47 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v6 net-next 07/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Fri,  9 May 2025 23:18:12 +0200
Message-Id: <20250509211820.36880-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AM7PR07MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cdc788-32a9-46c0-f508-08dd8f3f171d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bVZTWXhhQmlpQWlrRkpxQ2phaFpZM1Rra1o4dWc3a3lxWWRwaS9oRk9OUktV?=
 =?utf-8?B?U3MrcHlkc0RUVXNNdjNqYkNqeGxzeWJwRW5NK0FmNzBnbkYxQkxicExxOEZx?=
 =?utf-8?B?Z3NkWGVzam15aXo4ZktDYmxVRTVTbWhNSzVycGdzbnVqS3NmSUpBcjdlVys4?=
 =?utf-8?B?WFN0QTI0OWgwdU4rZWkwSy9YajFPZ0ZWdlMwTk5sakc4ZjFNYWpDTTQ1dGM2?=
 =?utf-8?B?bkpXemRubGZwSHVOU3UyMHNUYlpnbi92cjZBSlppVmYxRmZ2VHZSRDRRbCtW?=
 =?utf-8?B?anZrSWk2dzNYb0g0Si9DYnVQTjVrRTVTeHB4WldaeE8zZUhreHpqd241YldI?=
 =?utf-8?B?Q0tZbFNJR2YwdnlZZWV3cmdvL0RzcGkwanBYTU5hUitmeXNJR2NPWkNyaGM1?=
 =?utf-8?B?OU1TNWhMN2xtUmQ2c0U5NXhHUkMrem4yYytDaHNNWWY5bHk2WE1FcW4vNTcv?=
 =?utf-8?B?eHQvRlJaYlFUdVRzR1liMWo4bGFTc3Q0cm91d2t3VkFIUmpNa2dteE5oQkV0?=
 =?utf-8?B?RTMzR2VaZUhPb1ErVE8yVDNZazF4cW41aExUaDZDSlFEak93czlqK3l0Nklm?=
 =?utf-8?B?WnY0RDVadS92OFpENE16eWNYUmxTSUNQb28xNW15QWdEcVJ4cUdEc1c4MlNL?=
 =?utf-8?B?czlMTXRvNzlPTzJKaU5sSjVnd2N2eDg1Q2dPWDg1NUFSNHF2VUlnY1MvTDQ4?=
 =?utf-8?B?L3VQdHdmMGdVcTFXTGh0K3pGTWt5U0RJbGlvcUh1cnVyRWZZYU9hVmphc2hl?=
 =?utf-8?B?Vm5uc2RrSFhOT0lDK2hobHlyNjVobGNlK2VVRys5a1JXUFc3SGcyRUZzZTRK?=
 =?utf-8?B?eUJQbVUxZjFlcThUckZJUDZ3enk4VmdoSnVjMlNHNUVGajZrWmdla1NsNUFq?=
 =?utf-8?B?Sy83YUtZNlNIWUkxbEVDUXhlUTdYbTRNSjJDWGNQL1RacStrSFNBVEduTldu?=
 =?utf-8?B?cWYwdHdmRm1WaUhLVFFvNFJsSVc0c2REQmY4dUJFcWdya2FOOHhvYy9WcFpp?=
 =?utf-8?B?TnZnb005UmtRR3lXQTc2Q0RIcGVocUMyKysvVUdBUHQ0KzZPekFZbmR3cXQy?=
 =?utf-8?B?ZzNMRWV3OEFOL2xoVkJhdWlheUQweTgzRmJiNytqVUIrcnd5K3B5R2E0WXV2?=
 =?utf-8?B?Nk9SWFFtRzlUVC9uSXJSbmRKaDBha0dlL0dxQ2FjQS9JZzdwOHdLdFJxdnZi?=
 =?utf-8?B?YW1sYjQ5NE12dFhVMVJzWkxWSU5mVEFVeWpQaEEvKzZrcDdKU2EyekNLdmFw?=
 =?utf-8?B?MHAzR1RNb3QyczBpUXBkdk5MZEgzYkVBUmRITWs1c1MyUUlSbFNZdmM3NVpK?=
 =?utf-8?B?dmxBYU1GNXNjWCtNRGJGQ3ZDSDRETHBSZ0JMSExUZXByQ1R6T3pSRUdzTml2?=
 =?utf-8?B?OXU1Q0hrWVh1MGtjSGdOZ3R2NmNyWm5YK3RpemFuS3BXRkFnUnFabnM2UkF3?=
 =?utf-8?B?RXhOZ1h3ZkpXeStsbDdsU2VLZm1QaHh5MUxod2wyL0pjdHM5WE5aVnFxeTc2?=
 =?utf-8?B?UmI4d3Z6VnVRSnRNNWVFOEgzdCtGamNRYWt0QkhKc1lxdVVCMVhMNCs2TEFx?=
 =?utf-8?B?aWFaakFjUmc0SWE2TzBUVnVtWFphcmdYQmVIRVEvMW52UXJLMnk4ZVRSY0M2?=
 =?utf-8?B?N2x5RzlUb1FTd1pML2lGN3JwRkdaZC8rdHBDZkU2UnhKZnRIbFBNQWNKSExx?=
 =?utf-8?B?VjNZc0RCK0xOYVdZT1QwR25xMGMwQ1ppbnFJZWFlOUFyaVBlc3QzNng4cUhs?=
 =?utf-8?B?aXNScW0yMHd0a2NXRGJacGZWUndHckZEUmpza2w0bkhTK0pHMFFMTTFiZWZo?=
 =?utf-8?B?bFlhSC9DZlEyTytTb2Z0UUc3ZE5hdW14dWlZZjFMdHBPTGx3MW5Pd0dDU1VY?=
 =?utf-8?B?VmtSQ1F6NXBxa0NNYkZQT1paVUlRRllDeEViUzc2RG5JR29pVEM0MGVXVWJJ?=
 =?utf-8?B?S05wcHBWOWdiOHhnSW1NTkVwMmhuWjdiOENPeGZlV3dsNUo2TVN0azloZmdk?=
 =?utf-8?B?NCtVN09iNWR3UWR2U1JFZ2c2VWJ1VzZ4QlZFU3o4WHdqYXBxNUM4ZHZiVUtv?=
 =?utf-8?B?T1pTMFJNVlpoS25NWmpxVHZtZkh2MHR0dzlKUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:48.9569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cdc788-32a9-46c0-f508-08dd8f3f171d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6899

From: Ilpo Järvinen <ij@kernel.org>

AccECN byte counter estimation requires delivered bytes
which can be calculated while processing SACK blocks and
cumulative ACK. The delivered bytes will be used to estimate
the byte counters between AccECN option (on ACKs w/o the
option).

Non-SACK calculation is quite annoying, inaccurate, and
likely bogus.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 76fda2a63add..e710ccf22dc8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1191,6 +1191,7 @@ struct tcp_sacktag_state {
 	u64	last_sackt;
 	u32	reord;
 	u32	sack_delivered;
+	u32	delivered_bytes;
 	int	flag;
 	unsigned int mss_now;
 	struct rate_sample *rate;
@@ -1552,7 +1553,7 @@ static int tcp_match_skb_to_sack(struct sock *sk, struct sk_buff *skb,
 static u8 tcp_sacktag_one(struct sock *sk,
 			  struct tcp_sacktag_state *state, u8 sacked,
 			  u32 start_seq, u32 end_seq,
-			  int dup_sack, int pcount,
+			  int dup_sack, int pcount, u32 plen,
 			  u64 xmit_time)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -1612,6 +1613,7 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
+		state->delivered_bytes += plen;
 
 		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
 		if (tp->lost_skb_hint &&
@@ -1653,7 +1655,7 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 	 * tcp_highest_sack_seq() when skb is highest_sack.
 	 */
 	tcp_sacktag_one(sk, state, TCP_SKB_CB(skb)->sacked,
-			start_seq, end_seq, dup_sack, pcount,
+			start_seq, end_seq, dup_sack, pcount, skb->len,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
@@ -1945,6 +1947,7 @@ static struct sk_buff *tcp_sacktag_walk(struct sk_buff *skb, struct sock *sk,
 						TCP_SKB_CB(skb)->end_seq,
 						dup_sack,
 						tcp_skb_pcount(skb),
+						skb->len,
 						tcp_skb_timestamp_us(skb));
 			tcp_rate_skb_delivered(sk, skb, state->rate);
 			if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
@@ -3561,6 +3564,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 
 		if (sacked & TCPCB_SACKED_ACKED) {
 			tp->sacked_out -= acked_pcount;
+			/* snd_una delta covers these skbs */
+			sack->delivered_bytes -= skb->len;
 		} else if (tcp_is_sack(tp)) {
 			tcp_count_delivered(tp, acked_pcount, ece_ack);
 			if (!tcp_skb_spurious_retrans(tp, skb))
@@ -3664,6 +3669,10 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			delta = prior_sacked - tp->sacked_out;
 			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
+
+		sack->delivered_bytes = (skb ?
+					 TCP_SKB_CB(skb)->seq : tp->snd_una) -
+					 prior_snd_una;
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
 						    tcp_skb_timestamp_us(skb))) {
@@ -4126,6 +4135,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	sack_state.first_sackt = 0;
 	sack_state.rate = &rs;
 	sack_state.sack_delivered = 0;
+	sack_state.delivered_bytes = 0;
 
 	/* We very likely will need to access rtx queue. */
 	prefetch(sk->tcp_rtx_queue.rb_node);
-- 
2.34.1


