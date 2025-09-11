Return-Path: <linux-kselftest+bounces-41232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3AB52F62
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B1A1C8724A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014AF314A60;
	Thu, 11 Sep 2025 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IU7EwggV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74355313E3E;
	Thu, 11 Sep 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588821; cv=fail; b=UEit7HEbvZF+VLL+c5MkgPaeNrbALZSu0wbtq/73b3vnwpplg7TDYBNGRgNMzHVrSW4k8rB9NF3kZ7yyNa1d4kHy1ov5gKmBGHCzmqC7zj2zJMhLVqfr/P0hHmh5fDdmRMzIqUS9yo5phJ4lzFy+iObQs7oRl7vldSSZ5tA32hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588821; c=relaxed/simple;
	bh=azlbo0PhwafGWTiPCHQ9Dm1jdZR0kwlfdvCJY7T27lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS0P9ci/foeX2HztEqikj8FB00+s4Gh0p3hT4+NR+qqOAuiyjiWPEtLWaV2If6eUJXA0JnQnq5jH3gPB+GB4+5qE8CbP3OMwMmLB9tWxWKpN/T7TSSCX9GD2+lmACgN8wcM2MyJCDBDOLtpbUF2sR+/KYIkyh3T5jPk38PjKvcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IU7EwggV; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG2Sea8BQCzv1ildk/OMx2PdAimHd+xgcRPRMAutFNS2HaiUto6skCXvXdTxfFqYxamspsmCFNSCyj5ozvTU/aQUtHSCCG5jEQ5hPzxU/tdF/wDrfkcvXelJOOlb07mMLopVEujw5WlpHHp0EHN3Boakc+hfNKbQdwEnDNgWGZu+DMIwds73Ftr8piE3iQugBwOgY4ThmI9zbiONBwaYz5776fn/XJqA7hlEW3Z23/eT8mhs+KyQ3/xBV0x2xZQEdr5c21Gqpe5zFMiSmGwXXM3Wk03CCQKHzzDCEbzZU8XhwEW78CHMiycsUSuzfvmvYHdhdleyrlPWTnAzjdxqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=Zeb6pLu8xquuXHdySUMhdZF7CrhD9lekJNw1kRo9YZoz+Ln0SeIGvhKCTMUq0SfaEliQTD0qEcJkSNJuGwEiITg253n/5RqsXUIBzJSQ4iI0Af0b3tssTYLpbpoXdgaCufuNA5xYCOYJtxYRxjUzbppq5dBdQTNA56XsKB0l23jxzHCp03aGIUMVmppaFFE3QArFil+6RjDZ4Ng19b6VFUydbuVgF+SDdmP4BZrsCBdgMoAsYYLMF0GchTHkKgQ1AwFVGD5pxAhlOdihYmjUFEPrAEq/YIHD50vbyVo5cYNW/EfLzMmBt8+psqiyRYJ0EaBMq1PTrjq1GRhvgveB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IopfSuglR6MCcxDikYp4Evzs/AWq6tf8101xj3JPpq4=;
 b=IU7EwggV5axH1NqL9YCzI4MiCNuop7C+2RBtDOXyO7yj6WFRVIRYqDcWUBe9L7bu8kOTsjd783oGlBd5uMXwGHlJasQWH0PdnOYz2yBTyjZdV226socLHVoP0KnUpRDSSW46jdYzca3Tf+mBaUsKEkCIDBwItVgVpoqTYoD5GoVEMc7U2U2MTmMgnGgMWr1L+hXnOgWYExheH38FdulV2fJ/+NBmmrfaIXHDP+Xz3VZhOQXAYN43xHKhmeaay20fyoKPDH/tm6X6/Gn4W062B3LUbFZfWhZLeuxzs8J1PSz785ORnN0wREvdw1q8CIz2QSKY+R3Uz0BSj3/hrdgozA==
Received: from AS4P195CA0013.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::16)
 by DU0PR07MB8548.eurprd07.prod.outlook.com (2603:10a6:10:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:06:51 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::d3) by AS4P195CA0013.outlook.office365.com
 (2603:10a6:20b:5e2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:06:49 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 31256201A4;
	Thu, 11 Sep 2025 14:06:48 +0300 (EEST)
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
Subject: [PATCH v18 net-next 02/14] tcp: fast path functions later
Date: Thu, 11 Sep 2025 13:06:30 +0200
Message-Id: <20250911110642.87529-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B2:EE_|DU0PR07MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: e52d1028-ad66-47da-311d-08ddf1234e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3VsdVlaaFVOWFExUGk3WmxpSDFDZmZpTEhnTDEraFBxUHFyOEtoRzV3L0Zi?=
 =?utf-8?B?Z2JLOEErVFRLSU9lenZKcGJCeTlJME9zZE02NXU3N1dKZ2ZuRjhvR21IMUdS?=
 =?utf-8?B?QWY1OGc5VVBOUmdqNkM5QkFudVlHZm1RM3U1Y2dkdktxaEZpYjNLRm9RTGVH?=
 =?utf-8?B?dnJsL1p6WG9ZSEFPY1d6K3YycHErb0V5TitkcHpDWUhUYmRIUlE4VytTNjNm?=
 =?utf-8?B?aUxvZC9WcjZkampOYzVJaUdaQjRuTk83UGhGT2hMMUk5S2JpMUJvL3YxZGln?=
 =?utf-8?B?c1hrbUZWSzE1dkF6KzJPNE1CNEptN2N4Y1NaaXkwMlF0b1FYSVJHNjV4ck5y?=
 =?utf-8?B?RFZ6dTdWZlBPZTRYcnRjeXdjNmEyR1Y2eVltSHpwOEF2VmlTRStzY0FRQTQ1?=
 =?utf-8?B?YjBQWFZzdHdZMlVTN0xBbEQ4ejlTYk81S0NEcnNuSUY4QWVrcUROWjVVYXov?=
 =?utf-8?B?SDdLVGxWMkdsUU9hUFo0KytsT0tFOTdHbzB0Ky9OeEk3SHduczJKQmpEdnB6?=
 =?utf-8?B?NkRNWFBEWW1HUUFoUlBybUhHa0wzNGxlQjZxWVFOMW05MWxqTUxJVnJ2ODRG?=
 =?utf-8?B?cFdXQjlNV1REczBLb3p1TEt3dnpVbDNSVnp0cktNT0s1aEFYVjd5d0VWNGVZ?=
 =?utf-8?B?RFE5ZVJjWit3NDBRVHUyNDdCUkFoaGVpQlQ1SG9MYlUrOUdRUDl1NFhMSTEw?=
 =?utf-8?B?SzlLckxBdWJiQ0lXcW9vcjhHVFpYUDVWanRCOVB3ODRPSmp3L09BaFV3WXZB?=
 =?utf-8?B?VFI1WEFLUjhwY3F3OEV4bHlkdFIzZjQ0Z2ZNVDRXeFZkeHEyVzNaTnQ3VXk0?=
 =?utf-8?B?c0lXdFhQVnFXOUNrZC9melZOY0FWaTVqRUdsVEdxODdMRXVsVTV0ZVJEZGJa?=
 =?utf-8?B?YnFDY1kwUS8xNVBNb0U4V3ZrTEpVc2k3b21ES2dVOWE1VmpRSDFkZW9yVXl3?=
 =?utf-8?B?R0tXbnBhVTVoYVUrWTFweWxHRW84WkNJRWRHdnJpYnh5YVUxVzZURTV2RGtY?=
 =?utf-8?B?TDlUeVdtT3VaRWY2QzVHOXVIZWlsSjJKcEtENmE4VDBEYXlVKzY4R2krM3Zk?=
 =?utf-8?B?VXNqUWVyU1JiRGdWOFlQaDRtK0dvcWQ1RnNQa2RDa0F4UzFiMEx5Sjl2Q0t3?=
 =?utf-8?B?NTRObitBd1pqNkRudjdwdWxENEtjWlZjK0FpSEVHN2g3Zy9MYlB1VktaSzVU?=
 =?utf-8?B?dGlpOFowUUY2M2dqanFPSE5hVk56S2hqUm81Uk5mT2M2bVZRZW5iTEhBK0tQ?=
 =?utf-8?B?R2ZTWU45UVFzNnlUVUtIV0JjbkdLOGlJRTNIMnd4UnRYdy9NajRYS0RMVlRS?=
 =?utf-8?B?NkxhY2hOYUV4NFhTZFcxWWdlNU9WQlB4Y0ZmTmV0SHUreHR1bUxCeTZYSVhL?=
 =?utf-8?B?ZlZBSlY2bG1KNWZRQ0Rmd3dtMGhTQUo2NEJqWGp6VmozWWdNNkMwNjVNdlAw?=
 =?utf-8?B?NHN3RFFpRWhQUVhEWUdJb2dSTElkaUtxUFloa2lQZ1pnT2VqZS9ncG9CMUNn?=
 =?utf-8?B?RzdqTE5aMjZ1K21uK2Rub0NhVzdUdXI4TFRwZlJQRS9OUTJRNFd6NER2NXJq?=
 =?utf-8?B?NEJrcExaWE5NVzNMRjU1bWhIT1BOeTlkM0RhSXlweXJVVVdETkdoZ2ZUcDNX?=
 =?utf-8?B?cUk3eHMzY2ZZY25HZmpocmNGa3BvUFlXT21vUFcvTTg3Zlg2Z0NQN1luaXBt?=
 =?utf-8?B?MHVPN2h5L1QyT0pscklzWTMrcjlXajFnTkpvajZCNFpaRzZLYTIydDBneFRh?=
 =?utf-8?B?aDdJU2hJV2RQeDcvcnhhQkwwVHowci9aNEFIblJ5cGdOWm5EaCs4aVFvM0xu?=
 =?utf-8?B?SU1xaVQrL2tIak1xRHpBZ3J1c0J4L2hydlhGaUJQanlWRCtUTWtMWUY2TlI2?=
 =?utf-8?B?bVVQQWFzeXc1RFppbExVamdNc3hRdXdiVUV6TUQrNHEvbHorajFCeExkZ20v?=
 =?utf-8?B?VjdRRjVKZExHRUVZV3NIcXFyK1hxZno0UDV0Zm5jVXBFclRzS1VlQ0RaWjUr?=
 =?utf-8?B?L3VIalMvQ3loZWtlcnlXdVZrMVBiQlZGdnlUMFdhTGdkcDVPSWNYN2RJUGpP?=
 =?utf-8?B?ZGEyU01GNHdRUXRLMnphSmdJR1FaSFJWTmE0UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:49.5971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52d1028-ad66-47da-311d-08ddf1234e52
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8548

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0fb7923b8367..905fd63be74d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -821,33 +821,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1807,6 +1780,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


