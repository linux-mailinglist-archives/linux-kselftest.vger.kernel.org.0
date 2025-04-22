Return-Path: <linux-kselftest+bounces-31324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDE5A97165
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F316C235
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFB28FFDF;
	Tue, 22 Apr 2025 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DYuWldzV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2528F957;
	Tue, 22 Apr 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336425; cv=fail; b=FP2xfCHUCLAHGVHDhlDVxp1vkNCgvzgkfzLrJfs0f9RagdbBrGkiiFvWL2877mMPiBYw2svPrnN/+CrVXFHt0vl3hIB82FFTuZFrbB7wdeP0A5jzKgxmNkiU2i1UkZHgMAI5CnEKTeWYDNMvQcQzIl7V1wEpdXDo+8cDZm0LcTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336425; c=relaxed/simple;
	bh=I4ubTWT3RFl5BeQzn9ugdonkuIPtlIVxMelUvF756Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOy9s0YyZqc+MIxvA/3/hB1Cf19LBkziJ3hS0kZdAF4puyoSugljG+/5YN+crKTnUXbZOs97um2vHyf5PBNcXTEp9dx9ADKLi1wcEfppDZhQ9+bvDN10DPzTK7L4zURvaQa8QLHMJWGXrkbFOAzlz/n4Xd0YmDwQCFtQ0bMLpwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DYuWldzV; arc=fail smtp.client-ip=40.107.104.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsTyIeP3qXCWFlNIi8ceCoVLg+bcirQmRdlMM5IIRWc+MVhLYZXPfngjatNBop77alPI6TFF1K2pTzM6t/ENfqtidYOrFJzMKB4PLpW6yJNhPK3DLcjSojpmvQHs+4YI56StwAu/0PxXS/0aBoQRRC/1x+jDkQbHEzpC2eEqsepRppCGCBmK7xEZXOKxcV7G+jmK9DGTV/6EoVa81gqODMTiAgA5xEC/A5qI9bE2gF0FtnUAzVs5c5WIwM3KNtQ3tnNcGFMarUcz/BdV9ilhDOCBhfr38ro5r7+TZE3DkSDqGv05lRjvHKXKpAhTbyneqr6O2tqozClgu2ZCrs6OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=veXejDUxBK8Fi6cJ7U+38wVd2gGK9+LsITsQOLCTwpJMimdYdFIesc2laTAtXcJDqzxcCOlknIQo7S8QSscfLU2spbMyd5aTNNjyO+4fq9q7YmgCz/LB/Tbv+UtfIez0EwTbSJYf9ja/nfULPT4/beRNziY2bMHCorignyYP51bCuolWCOzfJYXXjVRpUSL+os7pXK7u/n+IpuCSXtSXtf99Qs+XYrfqzugv73PYMepaqogxoh25SyFQaV6SUxWB/NNh/AkeBbnAc6lAd1tasorxvkU7MEolY2frtb5m4rhj110q4z+P+VMZ4cPtOXmpxvLhTgfEkngc2OYtDpnm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=DYuWldzVZeL5VPwWA/Ho0d91xgx17y9NCsSWP+C3NqftOO0k7MhJ2vGnLfWFgnmXpN5KzSEpXxgLHaA/uuHk8TbUVfmbIZgpqogRUVxfg14KCaWtxdcA+lhgDRDQ05WblYw5ICWjf35peFYu4aBakHSyA+EX43IJdRo40PXeo82iTxA4LkvJtFiv4xVK08gkinZZsFprh0ovLB9ljY1e/P8AMtr/xwXj8FjXJDh3Db65MSCGhfsxOdmutyZxitEDur6wztf8yi+YR1Q6F9MX2BRpfn5z3kqrFVLqRSiqmVLu0nvX+tK0R2t4GRuPjYH22vQv9LFC9defyMFus6JsRQ==
Received: from AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::33)
 by AM9PR07MB7217.eurprd07.prod.outlook.com (2603:10a6:20b:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 15:40:18 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::8e) by AM0PR10CA0080.outlook.office365.com
 (2603:10a6:208:15::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:39:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 327B520A1C;
	Tue, 22 Apr 2025 18:38:42 +0300 (EEST)
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
Subject: [PATCH v5 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Tue, 22 Apr 2025 17:36:00 +0200
Message-Id: <20250422153602.54787-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM9PR07MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ea4f78-a397-4a79-f6de-08dd81b3f070
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OFVNQkRvMmU4dUYyRGFaOGZ2T0svVm1aQVlyTlAyQjRTbGtsQWVaMGllZVEx?=
 =?utf-8?B?TDh3WHpoeHBWYlpvM0xKRURhSVVJN0pHajU0MWNqRjlrNjFCRzhSS2c5UjRX?=
 =?utf-8?B?ZzBpeStRM3RoaFllVm9UZlJ3WTQwbTI0THNmNU9ZcVhJcUh2K0MrTE5DTzdO?=
 =?utf-8?B?aExVR1V0MUF6M3ZZajBYUENiYVBHclVDdmhVRjdZWU5OeGU4Sm5GU1dpVzlu?=
 =?utf-8?B?V0ZxdURlUy95UEQ1cWhiaXBVeTRIOUFwR3gyS3NqTDhCVWc5ajRCeFFoaVYx?=
 =?utf-8?B?VmI1bE0yYWNSeHkrVWxzOWoxSFdRUXQvMnNHUElGZXFralBLWCtuMmhmKzV1?=
 =?utf-8?B?OWJaMTJXSWxNMEFwRWZ2VnpmREZ3aldGejZUM2VRaDQzdERCbHFBa3pNcTR3?=
 =?utf-8?B?QStidGsyQmdGRDczb1B0RFdTMXBvcW9yUjY0QWtpYkxxNnFCWFU2amVBOVJC?=
 =?utf-8?B?L0lpS0oxRGZ3M1pVQUZXdEQwdzN0MjIvTTE1dlZYMjR2U2ZHTGZCS0psWFlM?=
 =?utf-8?B?NjA1RWd6UFQwNHBFMHRKN1U0YXdMZlZpQzRKeWp1N0puVUtuSWs4K3hOMVpo?=
 =?utf-8?B?TnlDUld3YTNkMm4zWXBWMitRSC85SGJsM0tGempSVE13K1haa3Y5NStGa040?=
 =?utf-8?B?OFZ1WFovVFFQZVVsa0U3VFpvNEh6SXhMaDU1OGVGa3lRcnAwK3Jjb1Bnb3hC?=
 =?utf-8?B?WmQ4NzQwK0xxU1FVUG9NNzVteXVkWkVpSnFJbXZmQms0TWZMQ1QzczF1bmRu?=
 =?utf-8?B?N0ZVdDNWZ2t6TU01SFBoVDg4Yy9wUko3aWlqWXo0dFFSNlcwNk5RazZiR2w0?=
 =?utf-8?B?ck9zSUl4WVFFaDVMbGMxVEprSHBxc1AvSU1XT2tzaWswWkxUeU9STXdDbFEv?=
 =?utf-8?B?TVhpTzNlNExKbyszVmlPREJ2bk1NNVJVZGVHTFlDU0xCNTdqNjBNd2ErRnJx?=
 =?utf-8?B?SlVuUno5bWtxTFEwT1VFeHg4TkV1OXFEZ2U1dy9SQWdJNmNNUk9STmlVYm5B?=
 =?utf-8?B?MVdSSWpqb2I1SWhHYXQ3elNVUys5U2ZGVkZRV1hOcjVYWHJ2UmplbElzSFNR?=
 =?utf-8?B?R0lDRzB2Nmk5YzJVRjRYZlpudVRpRmxCcmRDZWRzSXdwa2huQ3REYUw4bWsw?=
 =?utf-8?B?VlNVZXJ0aVY4L3c0Qnl4QUc4cVRsQWp2eEdjdnp4U0IrWndvV1VCYk9pZS9v?=
 =?utf-8?B?WlpxYWNVdDFSTTFTSGhvd0sxMVVDa3RNRlo3R2RWUU1vV0VYcWVVTUhiamVU?=
 =?utf-8?B?Tk8vbWlZM3pmeUo2Q2ErSnFNOGVvNVJzREhJdjd6RFZYNDMrL05ObW84WG1V?=
 =?utf-8?B?RFRSY3VySHBkREI3RHFLWUpPMG1vMmFrTkVlbDlmd1pYdWFWQnpNRFBKenUx?=
 =?utf-8?B?SXdZbm1QY3pCK0hGeU1yRzllVHZ6ZGRBWjRaeERkQjA4MFB2eVU1Qkl4TUo3?=
 =?utf-8?B?R1lWd2Q1ZHVJc0s1cktNV2xaYktYVzNnRUVFQjFkeFh0VHQyTFVaVTBQOXRo?=
 =?utf-8?B?SE1CdHR6MDhoYW1LZzl5Z0hYYW45UHplM2d1bmNxcUk1N0I1NVhLeEQ2bTE2?=
 =?utf-8?B?OG8weW9ZZ3dQYlpyNTN0QWNTOElLNG15OHFyNit3ZVJkb1R4VWRrR0swVjNU?=
 =?utf-8?B?MjV1RThiU25NNUF2eUtWSC9ZMjJoR3dPMWMxaG9abnBhSzBOMmJ4R1ZCZlFK?=
 =?utf-8?B?Qi9jSSt5dzF3WlB4U20yQm1kUmt6US83eUdUTjk4Ump6Q3RaS3cwVkZ5dFV1?=
 =?utf-8?B?T2tiRG5iL2loYlJ6UWk5TUpDbUc1eWhWOXN1MVJPMTVBK1RqSDBtNlVWbHZI?=
 =?utf-8?B?Q0dYTnJBQkwwSk9tSDRjRlN6ZWx2czlvN1g3bHRzdEZSS3M4RlMxb0dLUTI2?=
 =?utf-8?B?Z1JBWGdxdVkvN0RRd1B5enZpNlcvajdoMHJHOUh5T05OZkU3YnBwL05MZFNJ?=
 =?utf-8?B?YWZEdU5kTUw2MGo4VnNiMy9yOXZrYndSNlhkMjVQSGRuU0QvLzNXYkcvS2FV?=
 =?utf-8?B?ZXlZTkEycktwUjJSSHpNZTNGcGttUWFQNVpaVUQ0T1U5SzM5Q0FoaHRZWFl4?=
 =?utf-8?B?b3RGTUxkZ2hxZU8zcjNlL2FtV0JQK1RUZ1VxUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:39:57.6729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ea4f78-a397-4a79-f6de-08dd81b3f070
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7217

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 54f798161d14..c6dac3c2d47a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -733,6 +733,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
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
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


