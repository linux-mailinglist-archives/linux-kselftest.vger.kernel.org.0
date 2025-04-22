Return-Path: <linux-kselftest+bounces-31319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E32A97151
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FFD3BF302
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBC293449;
	Tue, 22 Apr 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZPRvD3iU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B9429008A;
	Tue, 22 Apr 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336328; cv=fail; b=svD+xOEJxSgdiPd0W1krDimuVjqU9jizH4Z/PYCgHna0hut1sxnvfcjrf3Hc95+nOMS0FEbpQBmAC7v4ZXdEjhkjZGj7S4/bFVHBzxBvGXjbiFxRlhcD9GxVCWPSeZ5F/3VnsLcCQxR5/k5DTobndbWTrSZb/Xt7WoruCjUhydg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336328; c=relaxed/simple;
	bh=O+Ij6PnJNya24eNiQTfN4/gm9ym90RRZa7lNIALkuHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbQ8PtXxREk0rV0S8eYN3xPSbeSzd6jppzrtU2/zq3EOHwFQkgFpfhLS5vqHR2uub286SAzeclaPI0ewuEigFBog0gNAFZFlOOGFLDTP8B/ojQfMIKDYAJYVylfjQeyy9yQMHxFlZ3IzXzsThHoCpubz5z53UGps0/1kDMmk9WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZPRvD3iU; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDkc+TlBRmD3rNGi6bONXPJUKwXEDmx5j5nyIrLiJ8K+pG1GnWql8ZVRUD2uCBfWEvW+NEcIZTx8kz0DrMTRqqvj06yzpyyRJS4QTyfdn5ZUvzXRZS9cj8oml8UG09Hd9Z2TTPhmyMC9aNEk9pLyDk+0yBLqwgAI2W3L3+zpDqYEk2qOYz0Lhz6qEMSoqRowIb1tyW/wDd0KiQKUorp1a0zwwUXHQt3ljgv2i0uDXGp9aDfJoMdQMjgcwldt1Sj6XYg/yZXc7DqM+a0tf8Xb5lJ6TLx0yvAXBVRGbPO6hPgMJ0F2Nxm8IZccwYcgj3YcBQcuSLNZWZnQ5cMUTIXS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=UU96zzBiI/DbsBSXJnfwC3uYUa/uZuYv+RcYeAlow1Qxl0y4YQvWuIGJfE4bfrArEour8XSYCxZ/dRB2qFHiuxOEkHhhlEnzrTpu0sl+aiOYR+HTxbJzYPX3UF3InpuIMCGh8yldyTNfsrU3oA+7JZHb8JMUCLzvcco7oWv2WElRPreKvZ0xycJ3UfffuNqYKMJAv7iC7S+CFHDCnszaUMCL2V3LNCzX4nEXXqZM8LfUDiYyH90te5TlreE4n1o3qjFeqOIJp+e9ozNU8BulShzgroh270vZq0JYfi6FHoplT8Q+F40fTPs4EE2niAj+lvOJHScbVhwkKN8VtOPxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=ZPRvD3iUEHR7LyCTw8pOStYUAmrk2ulIYjoHFG2iYbhayvJDD5vL9g3VpJ6u5XJ9sr7CxuxarDhBAnV0B6jNxkkuqsqcory0FlL9OsDCDJt+N+j7gkEaEOp6Yx+KQN1bYWNw34QwlYuFtETKwYXUX9MZASKT4WdQEKjN+yFX8IEPOteUC7zIitp+T++ERD7GalPKryfk8GrRyeZrv6nIqK8wIAvjoE2FTl5Z2352GwXaAjyINiU4SxYJegExjbF6/FbCot67ij8IEvRd5TMAWH/ZBxsf2+sdXAHpnCQNdwxtYIAB/bbHo0tJM9oCZL4p1iMRlDizRNGOIRAriVOz4Q==
Received: from AS4P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::12)
 by PA4PR07MB7520.eurprd07.prod.outlook.com (2603:10a6:102:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 15:38:42 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::b0) by AS4P195CA0026.outlook.office365.com
 (2603:10a6:20b:5d6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 64ECF20A0C;
	Tue, 22 Apr 2025 18:38:40 +0300 (EEST)
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
Subject: [PATCH v5 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Tue, 22 Apr 2025 17:35:59 +0200
Message-Id: <20250422153602.54787-13-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AE:EE_|PA4PR07MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: df4e7e4f-45a3-4492-32e5-08dd81b3c28f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SXRzSTFva2tZNTVpbzdBK0I5bmVEOUs4LzRjYVRlMkVNNGpteWtKeHNUWGw5?=
 =?utf-8?B?S3h3M3puUGtsclJPYWh2QkY1WjFCWlVFK1ZCbG4xd3JYc0RFVEIwK3JLeUNt?=
 =?utf-8?B?UnN6V0lGcHBXVE13ckUyVkY2SXRlVytlVkdwZFZ4alJ6MkpoVnpzZmMvcVBh?=
 =?utf-8?B?L1o4cWF4WnZoRDFrYlUxdUtrajZmc01yUERsNmZDbVVDdHlnUEVOc01aelB2?=
 =?utf-8?B?cmZrN09Dell5NGVFTkdIOXZOVnZZVFM3eCtQdHNadDliNlVNcDNqV2VZdXkx?=
 =?utf-8?B?NmdDNEFnSUpZRmxySTFwbjdUYXQ2OHVCU2c3L0l5VTZlZXU0S2FESWhra1h0?=
 =?utf-8?B?SkxWeUVxSTdNRHQ0RkhmUXFxd2xvZmFoa1dnQ0NFQ3JadGpuYUxKdHk4R1lW?=
 =?utf-8?B?UGI2enE2dEZsaDhzejNWZWZyaGZpYzVWdVI0UVFoM2RYQXIxUUFkdEtPYThI?=
 =?utf-8?B?TDFadkhmQlZRNzVSK0NjajU4SFFyT3N4d2I0bi9IckRFVUg4UmN2dkdtN1BW?=
 =?utf-8?B?aFQrSTJmYThXL3I5NzJESit0RjhvckNwS0VRVXltd3MzZnZYdEV4RS9BTHcy?=
 =?utf-8?B?VWdnczUvV3pRck9hZlMxakZ2ellBWUVwYkx3d3NyaFVwYVZiS1N6WnBNRVY3?=
 =?utf-8?B?bXFZdzhGdmRjRzRaWEtxYW1UVFcyS0RtdmxMdGZoclEyZ3ZOejBCNXc2ZlhT?=
 =?utf-8?B?TnlUREZsd2JsU0V5cWprWnNYeXVNVXhXeTA5ZnZXYlNJM0w0SnRUaUliMm9q?=
 =?utf-8?B?MjlXUlIxakM5K0NTR3FRY0xyRTNjdS9YRWFrRWNkWkxaczhhZHVQTWxObWM0?=
 =?utf-8?B?K0VOVlV3cERFbVpGcFI2K0VucDJaK3A1WDRqek5iY2RGS3lvdHdtVzF2VHl2?=
 =?utf-8?B?MTgrd3NPZDNuMEd5ZnMzL3dTaE9wV3VSOHhDNEpJZFpUTE5nSlExQ1VKeFBD?=
 =?utf-8?B?LzQvMUdkV1EyMEwzVXh6OHF4b3JCVTN0VU40aStIR0RTUzV6NEM1QlhQK28r?=
 =?utf-8?B?TXZKSHJWZ29zclRtQnF0NUVWeG5pbG5BdTZpNmZJaTh6eW5WWTZGVjNtM3Vo?=
 =?utf-8?B?aGdORCtXa2VBZmJNdk1OT2RIdmVkQnZzV3lCRHBydXA4RjNOMEJpR0x3c2Fo?=
 =?utf-8?B?dEZoKzNQVU5DVVRaOHA2U0JQVjdyUmZ4NHBnYU5sWXZQdjZRUmNFMHhzMmZE?=
 =?utf-8?B?VWc0K2MzUUR0d2Z6OUZiZnhYZGE1NVZqc1BSRWVPdzgxOWJ0cnZncCtWZzZk?=
 =?utf-8?B?bWU3eXNHSXVLOHFEZW1NTkJYMUUxYm9Ea2gyUkdJc1V1VUdtcGJUU1kvdnR0?=
 =?utf-8?B?eFZXeTRycTJNT3VNanR1NDd3K3lrWXp4QjJVVXl5TzNDQ0I2WGhQUXJ6OUNs?=
 =?utf-8?B?TnpKd2V2WGdDS000UjBoekM1Y0lKRFBqbmYwM0FUbnQzOXdjdVN3bElKaCto?=
 =?utf-8?B?SFdPa1l3dzNZY2hzakNsZ0FseXpyZE1hMm9WNmVSV0J3VXR5eGxqaTZXR3kv?=
 =?utf-8?B?VnU2SUhmUzNJQ2Q5MWdwVWlKekV3Y2c1R05YTEJhL1A5NEN4OFdBcnN3YkRw?=
 =?utf-8?B?Q3dZeEpPeUMrK0lPeERvcm5STXNnekZvOTZLK1gxVG9yVDNoMlYwUis5Mzd0?=
 =?utf-8?B?Vk5iQmw1YlNmSnpXLzZvZTZ5WHdnTlZrWFJWeW1raUpucDk1WDV6TGE5aGtW?=
 =?utf-8?B?c0lRRGx5YmJJeEg4SHlURHpFV2RJU0xiRjdTSHhZQ29xa01PK3hUNXVJa2gz?=
 =?utf-8?B?RER1cmtXTm1wL3c3NGc3YUpKRHMrY2hSeEl5NGl3NThIdnEyLysxdnc0WnBE?=
 =?utf-8?B?VlRMZE5MNkRrSnJyY3k4bE9YcGF0NCtrejJLY1Nib0szSkxXMENQc0g0UzhE?=
 =?utf-8?B?ZnNBUG14OElCVUl0WFozQTJjeGZsTHZEN25VMmd0RTZENVBxQm9JOCt5a2RI?=
 =?utf-8?B?QVhjd2ZlWnBoSzJGc005Y0QzL1VWQ05HOEYvNDl2TlpHWk1taHE5UkJtVG00?=
 =?utf-8?B?ZFh4SnpkZkNOenRFbHE4Zk1DaTZodHFFamd1TXdqUU40MVJtNjRNSldzTWZK?=
 =?utf-8?B?a1RiQXczSy92QVkzV25rdVY3RXpJTWRiRXJZZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:41.7897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4e7e4f-45a3-4492-32e5-08dd81b3c28f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7520

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
index 0ade2873b84e..3ceed4792d13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -244,6 +244,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8f1e10530880..54f798161d14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -694,16 +694,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -726,6 +729,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


