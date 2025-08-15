Return-Path: <linux-kselftest+bounces-39082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D4B27B88
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D47AC1B06
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43852E36ED;
	Fri, 15 Aug 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i7WWuDbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011018.outbound.protection.outlook.com [52.101.70.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A082D781E;
	Fri, 15 Aug 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247214; cv=fail; b=PpJ+N25ODbvqnelZ8BR+E5J8OgGF8Q/uZQqDD6fWyY8R2KWnWLlNW5v+SRIItMAycgixkuKtNrgOlUZsE8DAChWIPGrPntaD9VYoObaYJZGDyAJvbEfDkV2ndMrKQaZzyfDKLZfgX9NFiQd1DLY1qOPY8OQjGYabckdBrFyEx4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247214; c=relaxed/simple;
	bh=aNCHkTlKPmIxLQ5DgcE5uKMx2LRo6sgmhJydJn7I/Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ty3RKtZUtT4vIptnK16nzQZNl0QatKrr+NH3Lh5XFlDJUxzSj+5Umq76VVZEimnrLnH3CjQ87a2+lunY0h0H0naSCpcUpRcIZwgF2R0hUeqAF9OcVFHRpHVDifA54oqLMAuez1N7XuLRvf+hrv8l1kQ/G9fGDKYeNOmVCFWax7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i7WWuDbr; arc=fail smtp.client-ip=52.101.70.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShOl7v9IFgKpZJUArtKowvEAGrmVCYLWb8Y7QPGlRp4u6MrXJmdOETMP7EtSPGCkUd56Ku6mA8vUthSy0mAX1iCE+OAGqmOtvvuiiRAh4aF0qeaP34oC1+bQ5MZ1Zh+Nd6DTxTTy4LFPuceor+qCsqRPt/FLlpvRjuLHHhkO+Rfj1DlXU1D49+Gr1cUmRjiI9EtzczyjIC4g3pXlJ+HR/wKTGl0n19Cop7vTJR1B+kQf0vSCUFRpW+eCzt78uBb3JFy1lhet8houJgjLwIjj93qRqOddjeXgPsG+FvsMQTAJMIR9nQR2DHo8txIbvBeti2CgftVn0Yxd1vjyWPkYZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6px5zaYnHJucRXVcsX4zLJ1oDEUdALFM2tp7bcwGJg=;
 b=jIgtYPv59YtWntRuWxa66XEJpewxF++tVFSaoqbMP5FdcYpgNUScu3SwuigjQiJdnGFD2qHPLoKMN3RCvhA8847AuiTA8niP1r+Rzrvrj28sU4Oux3/AW2ukL7oJKYuechFcPA2ANEZgozYanIzBI+eUPrbjX6qJsVZaWfCKGVS8jRc5z8ktWuzTMH3MJnIUBF21UdMnzRwKR8AiiqttYSw9lZA+RwxrpDMkZzS4CZuYL7N1PgO2pK5JOA3o0OBGS8eTlWOSWwz10yBrZG3qV0+nWswg5c/jX9b8Ftpc5Zue1+GOKqZslzGmowdDqqQ9dTZIiL4/NZglkd1tzlGSbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6px5zaYnHJucRXVcsX4zLJ1oDEUdALFM2tp7bcwGJg=;
 b=i7WWuDbrOCHhjJW5qBYmJ6X7pGk2RFC3RYkyrdTjkV9zOcecPou2Ch15akpAvvKemBXFEDi0E8otepz9iHtTHD9r9SIi9508NWL/+y5GDICFlpZjxC1o1wzowWGkXC0vnvF57jw8QljL6DJZt5APeUrbLI+LGbP5BUUwuCDp0jIBUgAZdlDNTI0319CTkq2QLvFRd4SyMmnxth79l2Emw00tBn5errbBKMyUs5RI9SxDYX7gvABjD9mGtu2nH028xlKDkDUX9xuh91bhArXbUsSR+XAO9d0tX+rRc9764MBcp11pAQo9CNQHHPCadAF42yjKbOeHglJAfQc2oBm4bw==
Received: from DB8PR03CA0017.eurprd03.prod.outlook.com (2603:10a6:10:be::30)
 by AM8PR07MB8213.eurprd07.prod.outlook.com (2603:10a6:20b:320::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:40:07 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::73) by DB8PR03CA0017.outlook.office365.com
 (2603:10a6:10:be::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:40:06 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 2BD511C0047;
	Fri, 15 Aug 2025 11:40:05 +0300 (EEST)
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
Subject: [PATCH v15 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Fri, 15 Aug 2025 10:39:29 +0200
Message-Id: <20250815083930.10547-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|AM8PR07MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c16ee9-d7f6-4b98-ceff-08dddbd7563f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUZKRnJQQVl1NWRtZEgrSjBIdVNvU1JSNk5hVjREZVRqMHg2ZUlZWHBIUEp5?=
 =?utf-8?B?TXByYlBVck9XZ1BFVHhlM0Z2RVk5WCsvLzFFZU8xcXJCdVpwZXdUQzR4c1Vl?=
 =?utf-8?B?YjRsajNxQ01LaUo4SmptQ0pKUnFUTUdBUEw4R2tqMVdsUFViVy9kQlN6dHds?=
 =?utf-8?B?bXhsQ0swaEFLeWt0RG43R0xwWkZMWGU3aWdmZ2xKQmRMM1ZTNGpNMEZmVHlX?=
 =?utf-8?B?TFh1bVMwK2JHQ1YwWk51eFVxVzFaanlmeXR0d2hpdThSb0p0V3o5SjRsMDBI?=
 =?utf-8?B?Y2VJVnk4MERBNEZqbzR5bm1kRGVLQ081MUpLcFU4eUFXT0h0cTlaZlZXZUVl?=
 =?utf-8?B?d0JrNTZMVXRwNCtRVXhTRXg5bXZHU3BDMDFxUS8wMkhvMXBzbXhlSlJ6UWh0?=
 =?utf-8?B?UVQ0TDBZWDZpcGkxSEhjMy9ZMHY1LzFqT0pEMFNtR1ZhaEpNZkV0U0kxanlH?=
 =?utf-8?B?Y05Ic2JOanNTMk4wTTdub2pMZHhDdVFLZDNkY2c1OGJvdGhsWDhkODR4TTF3?=
 =?utf-8?B?UzVsZElMRlRraWpJeTNHdEVXVmozc3JZQ3FPRHVVYVFjRjdiakJaVVFEVlpp?=
 =?utf-8?B?bHV5MVZIYUpEWi9HRU43WFRYZVdyWjFURS9UeDJrSkVBRUJJM21HR1B0alpQ?=
 =?utf-8?B?eTM0OUNUVkErK1Avdk1oV1Q2eEZ2TUhnRTluV0Vqb2hWbTlBZW9VUkxIYTVo?=
 =?utf-8?B?dmlrVlU5N1pGLzNaUFFidkNxWlZyUUxrVUdqVmhzaFZDWkE4cnpDRjJvYU5S?=
 =?utf-8?B?OHA0Mms0RnZiMUxaZHppUUhrVU9aMWxEQ0s4RVNRMW9WTGYvMG03enZNeHhp?=
 =?utf-8?B?KzgyY1RjRzdsZkhZbWxMbDBnMnRFd2oxWkVYV3BvMUZKeGw5a3Ric0pTbElk?=
 =?utf-8?B?TDBPdGtYZFJHMFMvRmlJcmdHVUprZEticGFpVjJKcXdhYXRHbkpPQ2NlVHJr?=
 =?utf-8?B?RWhVRjZURFV4WkFBYUJENGhyUWo2ZHlLdFE1MDh4Z3dCSFA3VURiUDRZRVFL?=
 =?utf-8?B?SkxFanlYME5EbTRuZy9CTXA1UmhzNUhUaUFacnQxemptQUJRV3MvZnlZOU5h?=
 =?utf-8?B?dXEyT2VPRlFQajR5RkpCbm5YRFo5M1N2RkdCRHdkWXZtWWR3cUN1cVRFRHRl?=
 =?utf-8?B?VjNBOXlhMGpGMThCUkpEb29ubHZlbW81Vmc4a2lkZ2xEQWZKUlZmelVzMFh0?=
 =?utf-8?B?ZHczZy9xRGZ5L0pEd0JwYXYyRXJoeW1aUm95Sk9HY0pTQm1ycXpDME1pblBs?=
 =?utf-8?B?ZURFTGN3V3YxV3JBSjRMM04waGlVL3dOcVpiK09KSFFJTnJEb05GQWF6bFd5?=
 =?utf-8?B?Rk1iaVIrVTg0K0E4YzREZWlZYkFSTGFWSnI5Sk9LTmlmVjNwWXVVV3BsMVJi?=
 =?utf-8?B?d3hIWXFUWGdNekkwTUFQY09Hb20zRmpoMjJKOWtldzVCTFIrQ1RSM3hLdmV6?=
 =?utf-8?B?UHRoK0hxL3FwWjh5ejlzNE1yalRzSmFSMEYxN29yZXFBTnBoandpdTJhbWM3?=
 =?utf-8?B?N1M0VFljM3BON0RWODVIRnUySS9KditZOUd0UFNSaUdlenQ4amJlYks4TThK?=
 =?utf-8?B?aHlTMWxaWnA3aWZCNFVLM0Z4UEludGJTVk5ISDFnUWRoTEtrb1JDdTNRcVEx?=
 =?utf-8?B?cEE3VjU1N2JKQlBoZ3ZkWFF0T3pUaWZ2M3pPSVJCNHR0c3E2L1ZoWXZNWnJz?=
 =?utf-8?B?aUp1RlJYOGE0MXpPcXBLSk9kSVU5dXIyekNJeFQzY3BqMVVJUmlYYVFTZXdV?=
 =?utf-8?B?ZFMzY0p5L0VrSHYyRjFZQngyTG1TTGcrUmp5L0tGQ0FqZDlPZ2tTa3Blczcr?=
 =?utf-8?B?eU5MSWYwTGdmSE55RDJrSnRVZ3gydlVEbGQxelVCc3pkai83WmNEOTdTRHlt?=
 =?utf-8?B?c29PWDRpbXR4cVU0a0FKU3dWYUROWHR1cFdEWHNWd1BiVU9EVEU1VHhjeWY4?=
 =?utf-8?B?aWZGZmRqTHVTb3NTbFU2RS9FL3gyaG5SbXU0N0c1MG41WVpPblNNUFJJZDVo?=
 =?utf-8?B?bkl3SDgxaUIxQ2luN1BqZHl4U0Frc1h2VW1PMm9HVWRDd29xUW5QTVNqdSsv?=
 =?utf-8?B?RkladjNIcVA4RlBOWFMyVi9pdWtMaThIeTE5UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:40:06.7150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c16ee9-d7f6-4b98-ceff-08dddbd7563f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8213

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
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 81589dd0baf0..b01c05040c3f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -246,6 +246,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8676b7a512c3..f7358338d4bb 100644
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


