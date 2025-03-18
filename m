Return-Path: <linux-kselftest+bounces-29299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA65CA663CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EA217FD0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC8D1684A4;
	Tue, 18 Mar 2025 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ABQhpUeY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BC1552FD;
	Tue, 18 Mar 2025 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257687; cv=fail; b=NR2fIwyRvR2wiOA/419hi6WK9YMLwSgIMBdSc8aZV2cWhArREibIHLudvAWAR1LhYLytSQ0jY7794m1iQ+0KGF9HCD1vCgiapweYrOQci2G66/Q3oRAIUr+RQR/Dstmw8Oay9vYZ0ojSdiI1ZozM53kRF9mMRKM76Y2jvnwaS9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257687; c=relaxed/simple;
	bh=P+y5pe+LjBEM3YJfO5X11HdJpVJ/6TKxbk0/u/q0G70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sC2nHFEeBYCCpOmkajAggM3Fi5VpNXw9/oWcnbhIh0fJJUIHPYAOs83LYHtAjE+jkmohkFO15bgraxW8uiW9sNDdplumVjQYTc8H5yb0jFumebrqgVs+MQbt9sYyc5tn0r/AtZeoUu3xcD5HY3I1BFsw8LfG6MkK0iBqwmKFYzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ABQhpUeY; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUi5TAz7QFWwKV+r6nKFGV1ZSSqsz0raQ+8jzvihzfPsQ1bPin92SM+9ZENfX4Iixbpf5wLNy+BpjC7Usn+v59OTR1S7rr46Y7gQ1LTQ/h1hsYqZo8YOnjWqDnxTUR/ex2pND/Ibb9NIXLpw78E6YcwHtN8RtLF97NkCm5DJehfh9fyo7ts/DxWPuqKUBgd+MwZn2iEIziidc4qASDPN2Un8A6UgROP+B0ToJkupDk22HH77lIfLW7O+nm26RZeJM6xd427LdbDz0lnMJp5GfyQKXsT0z7P6OUonhthXgFfkp7t5ubJ3/tR40aEIKYAIGL9bzCIwiMtIqxNckfBG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ5VMo6AccBQ2E1Aco5pSiTxmnzfuaVGs7CuYQiAUMI=;
 b=DJOCVhSd6VHzO1cyqq/XXOPTZOkXaPIMcjhxiufXPW8VfbekA7Y3j+OOZoMUMtXUCGCIb49h0bsJ0HdRIfSR6pOidgi9JE3hrY5lGXBiWpX6PSKuEfspKMJSz9ibG2IEv9AIPHIj1ATl868zKbURr44cC3WxYfRZDDBDH79svHwcGsQZ8Dqwy9Jlltgx8s31uaG1dDLqU3hVvFLO0aiqGEPJR664wyh1Uj1/6c65BuJriqWkQAbS146e8T6WctyugpmHGOg6JRx77rmXx5xb6Od3lJO+cCPQrz/Yu0ZPUwN7qy3bI3WQBFO9zzsDRvhnUKx18UbBZGSvIiEXY3pAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ5VMo6AccBQ2E1Aco5pSiTxmnzfuaVGs7CuYQiAUMI=;
 b=ABQhpUeYVODVo5dVRjGSyYQHXYq2PeoHh0ZKYTwTnAjrvasFg7ZJXNUBiHmU3KudX6b3t47ChOhv/ID88OTtMP9W7W8Yw89qSoQ1+pwgc8Nwi31V1a3uIDdxA1TXyCFjQ5fmBq4CV97LiAuokjo2VTuqTXg5GXx1Lb4KvYxtys9ohNJkIO4/LS3I7gMHbnyzz5j42C5IsPnICFtQSCr9lPwcZYRFhzbsSeCmmkXQ98VaF93kD4MjW7T+DdI57jtitlTRMKBylZ5EK7WN0Mc4217zC156Ow2Kg25frL9DaSWlqwqslWaKorS6ElqeVlAtHpZzf+xbMfFHRVBtx6vHYg==
Received: from PAZP264CA0136.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f8::6)
 by GVXPR07MB9793.eurprd07.prod.outlook.com (2603:10a6:150:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:28:01 +0000
Received: from AMS0EPF00000196.eurprd05.prod.outlook.com
 (2603:10a6:102:1f8:cafe::92) by PAZP264CA0136.outlook.office365.com
 (2603:10a6:102:1f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF00000196.mail.protection.outlook.com (10.167.16.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:28:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBs024935;
	Tue, 18 Mar 2025 00:28:08 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 12/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Tue, 18 Mar 2025 01:27:07 +0100
Message-Id: <20250318002710.29483-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000196:EE_|GVXPR07MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e90bc2-eafd-414d-50bb-08dd65b3bd9b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SytjM00xL1dYOTB0QnRnMU1kRysvalo1YU1RbnhXVjJpZWN5NTNuQzNLZVVj?=
 =?utf-8?B?TlVBSGVTSG1vRnhWcHAvV1ZvNUdabmNKV1A0bDluV0svUnVJS3p4VTAwc2FM?=
 =?utf-8?B?TXQ0Z254R2lueHV2cFNUeVpmY3M4UlN1T0YxUjkwd3l3ZVU0Vi9WUDFueDJO?=
 =?utf-8?B?TnpRVWVrVU5wWUpRcU13bjhraUhKbHBkemEwQ2oxRXE5bkhKVWNseHZFMzds?=
 =?utf-8?B?UnJpTkluM1dUNzBLMDFrd2ZhRkgrY20wVndaNkI0bHFicGtQbGJBMG5KNi9o?=
 =?utf-8?B?ck1oSHBzM3J5ZUNFT2Q2VFRwRW5uOVlNRC9IV3BoVzlHcUpLUm5IYzMyR2Ez?=
 =?utf-8?B?NGtPUDdva3JRT1c4SkFJV3FkZ2RTQlpGMURjbXVwSUhvRm8ramhaTmI1dVVL?=
 =?utf-8?B?TXZqa2FsYzBFZUFCTU5Qam1kbW9NWGF3eVI4Y1Y3WkNuemhCNHBSL21zU084?=
 =?utf-8?B?aFRoK0NIWkx5eElnWlVVbU44M1lpeVc2UHRmdG5ZbG9POFBTd0laSjBlQmxl?=
 =?utf-8?B?SWFWcE5xbE8vS3ZaSmVSSi96eTgwZUlmeHUyYVNBeDJ1SlVvQ3JIaDdCTGZ0?=
 =?utf-8?B?dDBhQ3RGL3YvS2FoUzJrWEJpNGFNZW1QQ09uRjJocloramcyZzUrdVB4WWJO?=
 =?utf-8?B?NmM2MUFhL1VoV3FJZVFuWEo4MWtIU2FyWUxVL2hMU3VVTHhWQ0k0Y3kxMzJk?=
 =?utf-8?B?NWJnc0FvM2JyQ01DNkU5Z1lwSzFRV21xUWdocXhqMGJIRHpPSFoybWdaeFZF?=
 =?utf-8?B?Y3dzQkFiN2NDTnFpRTgwNktLVjliamhiWmhNdWtBMUhqd2JvTE1LNk9rVWtW?=
 =?utf-8?B?RU9velFRdXVRM2RaK2MydTBlTWZtZElPdFhYTGNVZzFtbU9HSlZuQWlUQkQ4?=
 =?utf-8?B?aTM4YVpKdkVqM2JZcUQ4ZDhCeGNFWHlvQzBFa1JyeDdnWUJ4ci9jcXZpWG5u?=
 =?utf-8?B?UU9BRERVR1dhYkV0eHpMSUsySXJXZERVMlUxY0ZUeTAxT3FqZGdEaitGSU1S?=
 =?utf-8?B?UENCcDFjNVd4bEVvZkVONldCdkdIQlhGb2lWRUQra0ZJdnEweExwc05lTTZM?=
 =?utf-8?B?SUY2SWdBK1h6aW1iNGVNTmNlTEVlRTIyV2RSNWR6MjR5bXFUcVYrS2ZBNmN2?=
 =?utf-8?B?bGgvazE3N0RBVlV2UW9mdTFCS2RCcDFueVVPRGdBQTBkdUl5WDhXR2U3Q0dq?=
 =?utf-8?B?OStra3RkNkQxd2t0VE5GcTVkdDlYRFBMT0s4WGo3NUVrTkxZZmFZQ3BYTWUy?=
 =?utf-8?B?b09ad0hPREpWelh0VmhjSC95N3V3QU05RE1GVGYxK2NBVzh0c3hwdGdZV1cr?=
 =?utf-8?B?dDhBQ2ZJNjl1UlBNenNJRURxUS9sU0tKY2pEV2xnMWlodHRxS1VVTlBMZFVh?=
 =?utf-8?B?djN0bjdXdFo5MGlKbDljdmxEV3Q2cDlxeXB3NHQyYWY3WGVjZks1TVgzSXJk?=
 =?utf-8?B?Z0dlQ3pzVEdob0dudjZ3cFk1elZkQ3Rvdkx5eU9xbzlReXhseUIzaXJ5eFho?=
 =?utf-8?B?UVVMQWhid2xuODZoN1JCZlp0cXU3V2dHSU15RWlMR1VJcTJNZTVLcS85ejNn?=
 =?utf-8?B?Nm0weFhFRWNPMjhPVWhIM3FXZnJ4aFpWeHlKaXF3KzJuWG1pUm9XREQ1NkNa?=
 =?utf-8?B?c0ptOUJONUpRY1FHV0VKS1VRM0tOUFU5K1hsNExjN2oybXE0K2FMTklVL0xP?=
 =?utf-8?B?Ym9QOWxFMytzVlJ3a3lzaml1L3NqRFVISVJlUklaM09oVFUvS2hMVlpPaWF1?=
 =?utf-8?B?LytrVGMxRlMvQUk1V0ZxUVJSSW9Vb2xCTmExREFNdDVJRE9NWDN5WTgrd0ls?=
 =?utf-8?B?R1NWQzMwRnErVnZWYWw3NUdQaytSRlhGNEN2emx0UUU0T3JLS3VJUU16cTJI?=
 =?utf-8?B?Q3R6NGFDK29pZFE5OCt6QkZ5eldQOUIzd2JicE1hMnp2bVJONllUQ3dWcEFY?=
 =?utf-8?B?ZzNGbnNrekZ3SmtpMlNTbnZONit6WVAxN3JWd29ROXFuMGRXa2FVK3V0OUpF?=
 =?utf-8?B?RlVYUitmbkpYUFdicE00UTBPVVZaaEFuVC91d3RlRmp0QXFFZWxDZ0pHb0NQ?=
 =?utf-8?Q?uHztxI?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:28:01.0321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e90bc2-eafd-414d-50bb-08dd65b3bd9b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000196.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9793

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
index f62bbf6f4eb3..5c71135b43f7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -734,6 +734,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


