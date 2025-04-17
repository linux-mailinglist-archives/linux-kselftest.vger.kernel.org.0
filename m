Return-Path: <linux-kselftest+bounces-31098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2C2A92D9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BA63B5B0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AB2236F3;
	Thu, 17 Apr 2025 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pu5YF+dT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE282222DF;
	Thu, 17 Apr 2025 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930887; cv=fail; b=Ba/bop6mrmCeMBeyuiUT6N3MxUpD32IM7PLgXGXNRW8VUYDdgP7vrLPS5KkPmwnUAf6LOKu+4BG0efHB305tDGUwOJjIXevDtOb+KPjcyaiZHmg8TNj8oeAIDfzCO/y99/s3xreAFeLI2Mr3AlA5peSIKXmXLS2CWJZi9bAkaZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930887; c=relaxed/simple;
	bh=I4ubTWT3RFl5BeQzn9ugdonkuIPtlIVxMelUvF756Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnFiznZjjXAaFUwhpJPdfbCbIob+Xa9knxV31D+rB/9iVq2BZfCQFRV0WL9U/+ADlGnjnFeoN4Bffsmk3fyUPuP24bvQc5V0f1j88wonNQo3Pf02U83PFXc5ykhLOrFBzzbNOSEzNUhwAtSxrz2XwjObnDN1CVV21PnWHxAq2v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pu5YF+dT; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=au3t5CM/lGK5mi5p0eKGTEm8wSlTISLujLr9btjZHfRQaM1WMFue2VOiK1Wqfu7T3uqyfA0C42shVxQvLANlhj4w5wbDYd6HnNQ2cfLAgfFDDm9Td8ginGnW1jEpk7L8YGaFSF7FiDH0ZONd/nOWMJ7S7TB1Vht5pVHUd5wLYMjCv2ZEbc3q1KQuQY8Jl01HATKTyMJqhU/RiXbeTL2ImTW3c5fnGdlMqXJTH/tLsRWyFkolfrWyNE5WkWWNfi9PdOvl73ePNKb+d07h5CJQQS3O3tLU0y33TuhDjOrUqFRhmc6y/wy/H7ZaouTORVIhk3jCR+yjF9cv5ZeJAV+lCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=mbljlDRBc9d9t7rPJMnKkHfWbAUUebSmInK5IiWuXEYGl6Fu7i0Dk1Q7OfzxLaXFgu+MjaYkTbYRB6yyUAHJstm7EZL7NJovnwiXEUhVzeOuxmgKW1BFPoi/7z7smP0kYbu1y3PoWw7eau0drLrIzICRPuBTHV6OHqfwbRtjBQPKREN/ssqwTwYdXiOLM5XMZku1pw3P3gjYAoNw2UYsPpWZyt45M+fYcSWj0ZCW16EL+7O98IsqXyVpp4Z+aN0LvkaB5rCgDBgYOID6/x4rA4fEckxn8MEJvQSAUS592iXztNaPdraMkChPCwLQi0g4boSGJtIwMLmCzEHwwnYY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=pu5YF+dTy4fh3jBWb1R56pKpPfyRcKcTfWKPy8hXYIWAkCumrP6yBElaxCUuFp6mq33L3EeYMtZM7wZ3Vt9TO10OZu1Urdvjn6OdBX21XzZkMhEOu+FFt0Df1fLQUthDavsmVrS9TIzcuR89gw0J5PbGpKy4hYKjMlfHBCgXkgb1xIybnfvqTw0C/4UVuob2RAewKkKNCRga3MSOCwqxPklwJfwv8TOtLoNSX3JFzIEDIe7abdI3t/0tId1AfgOi6hxUrZr+rFHIlUUYdV3ka7M/pT7RO0z2kCWLBW8gy52u8P0QJxDH8qlONuuybA/5Z7eQJ0dhMPccFfQv/MI1cw==
Received: from AM9P193CA0027.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::32)
 by PA4PR07MB8648.eurprd07.prod.outlook.com (2603:10a6:102:261::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.29; Thu, 17 Apr
 2025 23:01:22 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::6) by AM9P193CA0027.outlook.office365.com
 (2603:10a6:20b:21e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 23:01:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id B2FCE2084C;
	Fri, 18 Apr 2025 02:01:20 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Fri, 18 Apr 2025 01:00:27 +0200
Message-Id: <20250417230029.21905-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|PA4PR07MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: dfac9e3c-748d-4f05-0865-08dd7e03c598
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SEllL3FBYk9WMHB1Nkh2bVR1aVdHTWpyQ1l2Q0puU0Q5UUYyVkZZdUpsWmVx?=
 =?utf-8?B?MEZJTEZkVlNFQ005b0NoSW9xbHI3Y1FrTnNuWkRXMUtZYVR6YnF0alMyOFNW?=
 =?utf-8?B?emhWY0h2ZitGN3ZjQjFCRklMRlY2NUJ0SUZJMWk0R2I5NnV6VXVKRDBJTktt?=
 =?utf-8?B?TVJhYUJpTnNCVU9md3JDS0pMTUpLZk1vdUh1VUM3RnExQy9aMkRXQkFJOTNk?=
 =?utf-8?B?VXNROEI5RUpOQ2tRNmwvaDRDWU4vb3d6RHdDeTdic1pmSzV5Z0dXL0lFYkpl?=
 =?utf-8?B?NHJXc1dBanprcTd3eW1WSlFIb0FKT3hqM05hQ1dyTi90aUMweXBPZDRuRXFB?=
 =?utf-8?B?ckJpaThTT1ZYZ243R3c2UFVhT3R1enA5SkFvYWM5Q253UGxjQ3ZYY0JMZ1c4?=
 =?utf-8?B?TDh4RnV2cE5wWmFGQ1hHWXlnd00wT0dvVnlvUFhGbjY2Y2dJREp6T3diRjhG?=
 =?utf-8?B?a2hTdjZoS2p0RVJkRGcwd2ZPdkR2OWZkYWlGclN4WmJlTnBWZlBvY3Q1cGhh?=
 =?utf-8?B?SkF3R0syQmtSKzNnZ3lsdW1ZTm44d3FUMjRYdGNWWjBYSDZvZnBLL1U4M1pD?=
 =?utf-8?B?TUs3cGRtdzRXMGpiTnJMbklxcGkrZWRiTzZtNUlFWmtXbnFNUkdQRVIya3Bk?=
 =?utf-8?B?amVWSXptV0FPbmNqYkFLNlVFaUFXbTlwM3NOZG9tbEl2Q1JnajJSZ1NnMjJ2?=
 =?utf-8?B?UzBOZnJoZ1VpL0UzNFJZNVJjYmFLd0txdEdwYSs3QzJGM1pNNjRwTTVBM2NX?=
 =?utf-8?B?QlFGUWlINXhqR2IvaGRFSFFCUXJkZlJVNmxKVWpydExBbUtSTk84OHZpNTVU?=
 =?utf-8?B?d25uSjJhZGx6UVhOWWVNTnJoUTFTQjF6cXIweDJCZk9XZy9DcnJXbTE4ejlY?=
 =?utf-8?B?eFRaSWhUTUV2TVU3N0ZEVnhOV21STDZXWWlsUDV5MFphUmNiUWx3SCtNWms4?=
 =?utf-8?B?cXgvNmF4RkY2L3BDeUUvYVVLT1FQSmdLMmpFSytSQS8vRlUvV2xERHM5d1J4?=
 =?utf-8?B?TlJBVTNQU1luOGhMN1J0eHhUMEV1cGsrNG1KdjlqQm1OTjlXMTkwVi92RzlF?=
 =?utf-8?B?cHBiWXRySmI2RCt6MXhab3kwcTZwWi9YREtaQjNOT205dTRkdHFmQWNMN1J3?=
 =?utf-8?B?YzZSeGhtbTg1VHVKSU42Q0FKTVh2b3lncGt4QjhDYm5Uc0ZvVEZiZ003dzBI?=
 =?utf-8?B?RjcrVElTTWlIL1pHdFhXZWZtR1hmQS9DQlg0TE4zVmk4SXdKeTdlYzJweVli?=
 =?utf-8?B?Y0RzT093ZUZHOUJING9EZmlSUzBpRnhhaC9QWFBuR0RtOFQvQzNiRnBnS0l2?=
 =?utf-8?B?ZU1abHlldXpONGc0cmlaWHJSbm1CYUNtRUtLTmQwTHdJZ1l3aUZScDlMMjRN?=
 =?utf-8?B?akRCWXJ4cEF2QjVIdE9PZ2dRU29MdlAyMFlxTTk3TXlrTm02ZkxDaStpazMv?=
 =?utf-8?B?VThLZkNXRE52MlJwcW5WSy81R0FqWXcwb2h3OFo1dmRxMVZsMURXZUtBVmVO?=
 =?utf-8?B?MU5lNHFiV0R6ZzFCVTcwb00vZThjeDFWRTNQUFRKTEFMOE94QjhXRzZsVERr?=
 =?utf-8?B?eFVzMEhSU1EyMk5HSlRiU1M5cXd4bUpHWHVZQmo1YWNBZzFaTmQ5eSt4WDFB?=
 =?utf-8?B?UjIwTW94R1ZmVCt6YkxUeTQvS2QzblN0eXI5NGxrVTVtNWJXamUzS1ZXZWpB?=
 =?utf-8?B?TzBTZGRBbDQwMWtubHhaeE1sRDBHcTRFOEdtSkF5UjdXMVVyenlIcHNQejBw?=
 =?utf-8?B?TzdZV2pkQUdCc090YXFremg4cnh5YkhUczVTSmZ6b1RyNHdZakV6Q0FzbkNH?=
 =?utf-8?B?cnlLNjdKT1drcTZzdVlMYTZiZWJaTmtJRGtySXFRWkRJQmlCeWxicWY2UHg4?=
 =?utf-8?B?dmFCcGdsbzdubXhwVGd0S2pLSUlVbXc4UWxyT1gxWVdlVzgxTjN6NW5TNmJH?=
 =?utf-8?B?VWtiVVVtUHprdElGeE41b3FMMC9XRW5KVStvZnNxQlU2eFZKK3R4NVlOc0gw?=
 =?utf-8?B?emlHNWlKajBLVW5NdjFDWHl3Q0ozeVlzQmkzZXJLcDBsSG44TTBQMS9VaGJN?=
 =?utf-8?B?Z2M0bmtyc0QyNHAyUDVrcjA1UWtsTy9aSmFHQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:22.1086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac9e3c-748d-4f05-0865-08dd7e03c598
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8648

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


