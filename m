Return-Path: <linux-kselftest+bounces-41587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A6B59083
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E98B1BC0B08
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E182ED167;
	Tue, 16 Sep 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YLaZ+RgZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F4B2C11C9;
	Tue, 16 Sep 2025 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011135; cv=fail; b=Qz8nSGS9ugCl2HM9c4vv4lHRELBAZ9zkArmFRt5bK6kQrmbhB0YwvIVSn506fvNZnLu/Iqva003p3YHjswqogF2ll21JUiWI/iwVLft2PjSbYM7NoVc3kLmWbRfK3LnUxqX1uyaiDx6hU+SmDzfE4q4Y+Fthp4UMvxYWVtlrClM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011135; c=relaxed/simple;
	bh=byUc8BxfEuPfOPd3LzN1SR90nh5RY+k2nwwPdHhajd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4IuLqPpwKWkHXs301Il0WSw7VMTXNRfGa5cKMwfaUpbmtn6jn/5uTPpY7gbLjhjVDKctWKLLp7iBHvdG5WXQKPevzBHfvzvpC56fBg9AtwwmrHT9dFIyiwyrrVYh9TnUZKt9cqzvJ5Cb+1vmF89F7El+SbNGpYhBOT7iQVvqzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YLaZ+RgZ; arc=fail smtp.client-ip=52.101.84.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRvf3eQ43yTj4YBqfUqHzlmM2ZHcoufkco2UwePNSQUuqw9fdsE1QIkJYSOqUYyUqvNkhqvjjJjDwJ2WC8kWiPoFa0FuMoW8yvcrch7PLCW4gx/tylAXa1X7BJDMAeIm/GaVUCaPGUoEAyl8Xe9vdgtzBuZBz91AaapxFWtHHj2D+lj3KVTKoBGsDiwGzvRoyU5eTLdJHnpF8sNeKBOkWk4HrOGqNoAP64hiwXnXy+LdWd+eozZ9U06lGxB5BXxiNypx+t79zH4lMHjFAbDW9IbcS7/nVyiVqUY0ZIt4CF3+RPev4STIgq6/K7a6tc1Y6/Ym9IV3MaR8zvZFHK0h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMPLeHgEcE3/b8ZxpvrDFj72fGeBOvWzBd1MirJQO10=;
 b=NcNRjfJvmlgZ2HIBCXh4g4oKggVwDG5dGZMdsSWnaRTUzaT7hsuBtukmTNARb9rsdkV8vCa7G5/9+S7jJ5pqrnKUAuU3EJANnShMGtX3ngRofNT8zPBKSJuA8Ko3Abl5BmfhoFoqqZbHHrD4dcVSW2XZsnGNX8MYPzwzQ9Vl3OeDVxHvaViusDSbSLvXnx3um846llYEPafmfjWVr6FLF/HivooGyVZgsFVpI1ORJjcZO1qDGQD1FpmOdJfgWZISg5wNHJcD+PsyIRmNFCL7MumXWOYsiWt9Vx4eyGv9C/4sJd3gxkglzIb6zLEEomcl8PDmaMO87Qnu/IUhV1vhWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMPLeHgEcE3/b8ZxpvrDFj72fGeBOvWzBd1MirJQO10=;
 b=YLaZ+RgZCvK5yAHPOJKpVn+sGFhkSElLzn+ieXQyUw5fNpQehTJrkbs3858i+SJOzwDGnJj0FPMHqxQTV6fQL6h8oj4MnYE0/rqcBtoasGISYJLEvU9ZYpEFVjfNcEKNt70+yCzO1ausgQtY36NT2y9vCwREx/0zZvGnap3cBBcOkFzuJ2EMwNKbyst4r3yjOtQNF2pQJJdDr1R3/V0cowEa7+I1sTyV1LVB+clENv6wwXY+WGq13Acy/3WBbS+VoNzF6A68t+1urjtbNLFQvU+GafGFJbT4HVye8CQWqO2DfP9yuKSFbyLZ0oyVAGDKJgb/arVN22yZzh2Xxd7+ug==
Received: from DU7P189CA0019.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::19)
 by VI1PR07MB9459.eurprd07.prod.outlook.com (2603:10a6:800:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 08:25:28 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:552:cafe::d2) by DU7P189CA0019.outlook.office365.com
 (2603:10a6:10:552::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Tue,
 16 Sep 2025 08:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via
 Frontend Transport; Tue, 16 Sep 2025 08:25:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 94D6020109;
	Tue, 16 Sep 2025 11:25:26 +0300 (EEST)
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
Subject: [PATCH v19 net-next 09/10] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Tue, 16 Sep 2025 10:24:33 +0200
Message-Id: <20250916082434.100722-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|VI1PR07MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: be011238-e5df-4a20-4e7f-08ddf4fa97c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFVeU82TnJReWdnWGluQlRKQmpoWExkVXRPSkN3UnlwYlpOUmNURmhkRE5j?=
 =?utf-8?B?a3o5U2ZBYS9OSkpMeS90ZWVieDNUTmpqQWdYa0lnVWpDZmZaZ3puS1k1OUl3?=
 =?utf-8?B?STNYcGk2ZVVrY0dSRStkdlR0Z2lGcjNjMENjUmxMUC9IdytsM1JVMjN3YUl3?=
 =?utf-8?B?dmFpQWV3b1BmdFlKa1lXRnVoVzVvYUg1dTFaSlN0TXpVVkdBa1hxenF2S1Js?=
 =?utf-8?B?NERIRDUzZW1tS1JUaFY2QTFwYldYN3B5ekcwcnZwRmJsNyt6ejV4WUdwSDdl?=
 =?utf-8?B?ODVmY0ZZVTBnYnFuY2hJeTBvMUFPK3ZkanE5eFpjMFBEdUFEbmo1QW5RUEV2?=
 =?utf-8?B?MFgzVDZaUVp0K0N5TDVwQkpuTkhiVjlsM29XekhLaS9VdUN2WktNc2djMmNr?=
 =?utf-8?B?MmFXdW12eU5EaVhGZnMyc3RvNm1sbDEyZFV0b21jRjUvRnFxMktzK251cEY1?=
 =?utf-8?B?MFRsb1dCZ0NISEliamZzNTdZZ1VDUGtyYWZRa1hjeXJzYmgvYkVOdE5PSjRX?=
 =?utf-8?B?N3BETHoydXYvNC85ejZHbCswRXZKamVMV2pPQS9jclBvUXAvVFRrVk45cTJo?=
 =?utf-8?B?RFJWQ0kwM283V2RGZldPWXQ4NGNQaVhXcERCU2JsUTYzQ1lLV0lDY2NlMTVk?=
 =?utf-8?B?cGt1cWV4bHY5MjNqYmx3a3ppRGtkSk9BNjVVQ2ZPOU45MWpFSWYrYlZtM3Mv?=
 =?utf-8?B?TjZyNzhpZWxaV0k2RmZGdHlVZEdjNVc0TUQrTFA3R0lUQXljZXkxbGFZRFQx?=
 =?utf-8?B?SWRXVzBsNmt2a2ZiL1dIRDhORGpRSVA5WEV6NVJhTFFQOEhLWWltVnVSeGl1?=
 =?utf-8?B?VTZIV1ZBam9JNG5FQjBkUW9sOW1mTjRBUzBCNkhkNlBzb20rSkdBa1hiaDE4?=
 =?utf-8?B?U0IrWXdiRnZLMytnRzhYcHBZQVcxdlJYVi9SWFJKVllEYzFEM09LTElLQ09t?=
 =?utf-8?B?WDZ6NEtFbmFIa3liZU83UFYzbThCR0dRVGZiVDE5amlrTHpUMThJZjhaNGtV?=
 =?utf-8?B?anEzNUV2b1c3bmVsQ1VEanpaZW9PbE5kZS9yL2hOMlB3bVc2ZnRucitmclBE?=
 =?utf-8?B?OFV5Yk1kUWtBcHN6Q3MxUnBycW5UaG5Va1dXZ3g1aFN5SkY3UHZ4bXVPVFFw?=
 =?utf-8?B?b3VRYU40cmhXZUhia1VrQy90ZzZWMzdLRUN4dnVhaGUxMEtidG5NT1pBVTkw?=
 =?utf-8?B?M3JFeTk1c3YxY0N0WVRtL2E1RnZMME1qYjF0bHBoOEFUWVE4a1Y0a0pMeUln?=
 =?utf-8?B?UkZIcElwTkZuNWVNb2E1MWhNMnRzMU5iQ1V5Nng5RmtFTTNkajlUTkRHQll0?=
 =?utf-8?B?TVhlaE1CNFk1T3ViakxMSFExeDViRnUxODRSR29ORlM2WVgrMi9oVy8wVTBV?=
 =?utf-8?B?cytwUzR3dmlJTXJQeEtEME5xV0lxKzNBVFFwUDV0RitLbXNaL3dhVXc3amVy?=
 =?utf-8?B?NjlORXQ0dC95V3oycEF1TzAycGpHdGlJNWVncWlWQnAxRUordWk2ZUNkVC9E?=
 =?utf-8?B?UkpvTUY3UzljcUtoSE9leThUSUxFYVRqWDJtK3JobzhjTXZLNUw1Y0h4clJx?=
 =?utf-8?B?TVFHdjNqOFJ5eWhjSG0wVG1uTDRBUlppNFUzZXVhTzNuaHBnVXYzcDM0QkRU?=
 =?utf-8?B?QlMrSnQ0M1RYYytHV0lXV0pUVGwyYklVeWY0STJyWkxHYWxzK29aWDFucTQz?=
 =?utf-8?B?bWhrWmFPcmZ3aHpRYWFkM0pIekhIMDZNVVRsUHpYOXJBR3dteVFDNFBXSTVP?=
 =?utf-8?B?UGI4K3gxL3Fja1J1Sm9MZkdxeUV5Vi9HUGhleUI4Z2pGTE5TK0FoemY0SkdF?=
 =?utf-8?B?MjkxSUNTTS9EZ0hPbVdGSTc4YU82OFBzQU9xZHFCNGtnUXY2L0dNRkVOOUxI?=
 =?utf-8?B?S08rNmZOZlRxSWI5S3B1M1UrajBvNWpMeVpTN2pJdWxZZEVVYzhmY25kdnd0?=
 =?utf-8?B?SWtYMmhjOHJkaGpnYlhiTWVVZVNJQlNDeEliZVBVMWhUWVkxMHI3NGU0YUdU?=
 =?utf-8?B?d21DSGRpUW96aG5OckVwSWwwN0N3cW1INnl4QmJ4RldrMUx0V2RtUll2M204?=
 =?utf-8?B?VW1ycEZCVzBXYUdJdmhsR1Uvd0V0T0M3aWxsZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:28.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be011238-e5df-4a20-4e7f-08ddf4fa97c1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9459

From: Ilpo Järvinen <ij@kernel.org>

The AccECN option ceb/cep heuristic algorithm is from AccECN spec
Appendix A.2.2 to mitigate against false ACE field overflows. Armed
with ceb delta from option, delivered bytes, and delivered packets it
is possible to estimate how many times ACE field wrapped.

This calculation is necessary only if more than one wrap is possible.
Without SACK, delivered bytes and packets are not always trustworthy in
which case TCP falls back to the simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 78dd7b8a4145..7c51a0a5ace8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -256,6 +256,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5732f2d4329c..9fdc6ce25eb1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -493,16 +493,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -525,6 +528,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
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


