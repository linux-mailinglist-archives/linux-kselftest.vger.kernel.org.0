Return-Path: <linux-kselftest+bounces-32940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C8AB6D8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E38162496
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831327F4D5;
	Wed, 14 May 2025 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="am55d3b1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26E145B25;
	Wed, 14 May 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231028; cv=fail; b=IV1BiaZMpjU09gARWpQgHuSPvUuFIrUA0qhaIfPH6maGCQfN+DmguwrVED4P5W2MbvhiAKZNYgjDlVTeRa/R4KvecnyKPgL1SWhMjoeS4lqst4xCgEIJ8sTvENiftR59XdhfDbdhh7BG6jXUuDegAbevnZ8Vi5T7+A5/AjPTlYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231028; c=relaxed/simple;
	bh=CZY/0reepkm4HaLsD9NvcxG4ZDT+ZoGF8jeSEf+8GeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrqC5nNb1U9R5oSXI4w2EH+uqeepMA0DdeF1IJDkiXfbvq1sattVxDUFOlVqbcQaiCa4kAubE8oiJIx4+t2aksdgcnKwBbEnUkrAd3JgPV4k73MK5Y5QhCm0IgMOKGErbr+84X19ex1gUXnw4jJiwxTIAWaZfstw902Q0frb29E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=am55d3b1; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g55R002q8rYefAPzmWKG1hssBTUk7B2/D5JBUacaoKKNBpZk2xa94rrrx8Yg7BnaPhrHJwFsRCTZaag5tRXqSyjKrFAy11UF/6QlnX+K/AFaGKYIpDw5ZM2w5GUuS2Tb0ELZYZujn54iGSXBjtVImg9Vl5fqxMwTN4OCWvNhZC43Bd9fsvcVQuwmjM3VqPegFYNOeXhzOsZSrw7IHjgk9Qrz/ClEvpOdTjzUjnanLGPmTL82H4EpKWWuCbm9xarMHeq88AdlEbSjOvi12pWqdAapvdoxMemAzMVGvaZulKm4YyCyMPbK7cyNLVCQr8JaWNVflj57rKPEw7ZljwKu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFHMjzcanuNcCtmScpnJuy0JONegzutUxgTXyp4JaTQ=;
 b=Hxn9LNKtqwiG3DDnQUPxkVbr9fEn/jbA/izNS5BJ4sZ7BGvDOpN92WZy61Fx93pgJdpmEVOgqkHkI+YjqrZszOj8ICmx3VB9gRR5J8iCqm5inC4QIcf20DimDiNPedOXS2iwbtZ+4CC6wGFVYdKY//xsNniyXR14O0Nh5NFlXcZVEcaoSSYtBIpHlQFW1csgZTyPqXJ19+Uqm4CRZSn8gXtL+8YUAxZC461weZD1sonA9WcA0SLhb1uAIh3TAllS22o9jwLAkU9gGfC/434VRmJ2aAoSzGY5iGGN4/juEmVfr55EouuicM4ePSiR6dMKU1YW3xtlrU9E7VfL4lBcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFHMjzcanuNcCtmScpnJuy0JONegzutUxgTXyp4JaTQ=;
 b=am55d3b16PRP0rqel6TtRmfjpZd8lsvA4ToHuyp8nCRpZDH21djnVksOtoQh01IguTH06YDF0722C/3LeIx+GTZvcHINBQgX0U7dPn0EMg9wxIVSIs3HPNBFa3/g+EloeUTUeEUR0lr80qwfczcEAL1PHN/pMTR4ddm8aqFB9uNNETDLPXgx2tOLYPfHdrlS09FJoiMNClk7MuQgCJI0oUQ7lsuKNnAHKVdaZw8InD9HFA6Pg0n3zgWIUT339ggt7h0DwG3UbDHixlR/FN0k94M+I51d01tyjzv6uu0j+FOx8L6fg8/brUwuAYTEBLUFDHDINNQWvncZh4aOJ2u6rQ==
Received: from DB3PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:8:1::30) by
 DU2PR07MB9586.eurprd07.prod.outlook.com (2603:10a6:10:46c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Wed, 14 May 2025 13:57:01 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::86) by DB3PR06CA0017.outlook.office365.com
 (2603:10a6:8:1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Wed,
 14 May 2025 13:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2674720094;
	Wed, 14 May 2025 16:57:00 +0300 (EEST)
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
Subject: [PATCH v7 net-next 07/15] tcp: accecn: AccECN needs to know delivered bytes
Date: Wed, 14 May 2025 15:56:34 +0200
Message-Id: <20250514135642.11203-8-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|DU2PR07MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ea43d3-cc62-4f19-7d39-08dd92ef33a0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MVhaL2R3VzFHd0wrRUV5UlhiZzNJSDFyRXVUQWNKZnR4QXcwbklSdTVpZ3ha?=
 =?utf-8?B?UnRBZGNaSFJzc0xUSlBJdWxON0UveDFBalFNYVBJdnRaUkRpdmI0b0FBOTNw?=
 =?utf-8?B?VVNYVmV4b29qYnM0RWZCbmE1RlZoZGhMNlZDSGpDZFdxSXljZWthRHJONWtP?=
 =?utf-8?B?WlNhbmNiUmJwQTQ3YVBlcFB4SnNrT2I2bDdkamtBalV5M0d2QmxqRkNpN0RR?=
 =?utf-8?B?QXJSTWRERmYvdzRZbjViSGNhY1JHU1hCWXlnTzdGUHl4eFVpTHV2eGpwZlpF?=
 =?utf-8?B?ZXZuZ2UyQ1FWU1Nwd3N2LzRWSHc3MklCR0FIVW1mWmxoNE9zc1dIZXZ4a0Yy?=
 =?utf-8?B?d2ZqR2d1R0lHaXNCbElIYVBFTDN6UmV2V1hrWStjSlA3Z1FGSlNPNFluYk1y?=
 =?utf-8?B?cTBsa2craU5IR0Y4bEhVRnRIVXRGcWViNlFvVys4YWdtOHpHY2lpM3JZeXpY?=
 =?utf-8?B?bHpQbHBmdjZJS1dUa3lsbmpYUWFPdzNuR09aUmVJemZLTG9XQnlhMWdWOHdQ?=
 =?utf-8?B?L3g1TXJNajRPUmdsb2tKK1R1cDBoc1ppNHdiSVdKR0laQXNNY3ZyeW1pQXZG?=
 =?utf-8?B?ekVJN0M1dDNhLzZLZGZrWUt2eWtIMzQ2cjB0Vkh1NkgxL2FhQ0I1dGYxMWV6?=
 =?utf-8?B?TmNIZDRGL3lTN1U2LzA3UGFFcm5EelVSU1NkNWR5ZDdpRCtPLzdtSjdQQUds?=
 =?utf-8?B?Ylh2T3dGUTJoWnVWTllZSUhwMmNMSVYyOERNNU5naUEwQUd0R1ltajd4dU5K?=
 =?utf-8?B?dXdzVTRHVjgvS0J6RFVWdlZmSkNFUzRMbzRxMHpvVitubGpnZTQwVkM1Vlhx?=
 =?utf-8?B?MEk4NzB0UTYxbG42Y2xlNjlYN2ZKQ09vN2JpQmd5aDcxcHBYOGlsNjdRbTFk?=
 =?utf-8?B?U1BNSzFuaDkxZFZYV0I3YnVKdkd3eC8raU5kYlZna2h2ODRRM2JvRUpzanhN?=
 =?utf-8?B?Z0NBSUV4RVV6Q3BycE9SRlBCNDYzeTBMWlJrL0RMK21WajJXVWtYOTNDNUlF?=
 =?utf-8?B?VTBuSm5USVFLUDBoQ2VRL014RkhnSjhja3BIZWM2QzA2ekswME1RV0NDYnJr?=
 =?utf-8?B?QVBWSFZGSk5NNzRYc2JSbUJxUlU4QkQxRG45aDN4VC9FS0N5YXduT1UyNG95?=
 =?utf-8?B?Q0hjVDdVRUtSckZndTVZZklaOXdCdFJhSGlTank5alRZY0JEd1V4MWlkNzRw?=
 =?utf-8?B?NTZnYldtWkNHNUZIbnRseTV2U2lLd2gzQ0ZTMXhqbFhBYmtOcHF6b1VZVU9Q?=
 =?utf-8?B?S1JwekI2SjlXbFFONzRxS2RFY29kYlhBd2twcFZFRkkxQUZ3eXJFTC95ZWgr?=
 =?utf-8?B?RjgyNXc2bjVWQ3F1R3hpbXlWc0tOL3Z5bXRia0hyZ2tqUXdtOWNKY1p5NEt6?=
 =?utf-8?B?WVF6enhFTkFLR200YmU3RTFDSzEzSGVydTlwbThvV1NsRDZFODlGbWFOL3pv?=
 =?utf-8?B?SGZGTUgyMEZrL1RnRlJJUGV5U0EzNVY2MGZRbUJXZm1lQ2ZHK2pGM1oyRWZ0?=
 =?utf-8?B?ZGQ1VGdBM2QwdUZlR0t4TTRlR0sxTmJseGl4V0hBaWthN0dZQjd0Z0tUQmVj?=
 =?utf-8?B?ZDZybWE3YTlDOUpZdjZUNXhJUmpTanNqU2Z5Nkcrb1o2Wm0zSXF5bklvbjJ1?=
 =?utf-8?B?dG1qTmphUVZVenFhcENJcFRTTnhYdFk5NHlQazdZZ2Z3TUJMMzA2ZzlWOFk4?=
 =?utf-8?B?OXc4aG9TekdaZ01IZHpuRGx1YXJueU1wVWQxSHFTQ1hsVHVoNHp1U21rNkhx?=
 =?utf-8?B?V0hSdm5zbXI5RmpJbVBscXdrdHhUUUk4NU9RYWF6cldHaDFnd3IyS1NSZ3Uv?=
 =?utf-8?B?Vjg3K0dkMVF1UG4rQ0tNRjFVUTk4eXhVZzRERDFjempIQk95WjNRK1dDbVZ5?=
 =?utf-8?B?OThGc01LRUN4Kysvb3J1TFRJSVJ1ZThJVEd5emVPSUNmN2NiSG95TGxtU21M?=
 =?utf-8?B?VkJyTnlnRXE0OVU3VW96b2xOai9RNjJja0w1V2VBYVlmZXcycnJaL2ZDeXZs?=
 =?utf-8?B?bVAwMFZtLzAreStjMHc1enFXMEFPOWpNUEx5eFQ4aWcwaEdMT1lvTEFXK2sv?=
 =?utf-8?B?ZjdOaUkrSzBRcjg4RjZNNzRWaHI0Y25jSTdmZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:01.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ea43d3-cc62-4f19-7d39-08dd92ef33a0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9586

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


