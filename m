Return-Path: <linux-kselftest+bounces-31315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4FFA97150
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F101899869
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F29290BC4;
	Tue, 22 Apr 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pVf58BhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48190290BA4;
	Tue, 22 Apr 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745336318; cv=fail; b=klERxJ9w+v6ifeSyuTy+1Fj3wF6zcjX+ICR/aoWGV6shJkf1tqkFMYkUhDu2WKn50OO2PcazkO8V8awKiw9VH08IAn61oPi1BxCm961JTWVs9DaWIVTuGu6vSBeSDITloajuim2MQYcE5spfKAW8nstC1wjlJv2i+lu4bIdTb2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745336318; c=relaxed/simple;
	bh=g1x1wSE8mDsEEGPuXD/eGJRl+sR0RK7CBjRuw48/ZGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBMQbVS8F9xDrwvYuMcfouJmxio0NoHNvCxqbsZfstEKEDjjwWOnjd6pV7HKrQEKBRfPaEeTWgy/SoACSy4t98Nel3ZfkWtUjg1CEYeQA7rh7cEw8uQtAYYqw7DY/9+xaETBu8KeTBoVqV880uDLTTrlXeKG1yIErOakgeNGaoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pVf58BhG; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrMvZKg44rc09WEY1hG59oramWAAIidenQMgTb/FT7mOVN5D0Igvk7uqjNH20fajC8txGxrXLCLnfS2wZmM1bdNtAnRDAjcztEBP95sSvQLpiHYGQXSnt4LS2TAiH7goXjtSC5f2Dt3upgN/g6t7YHCIrJx4FsRMnfh7yOCY1JPHVg3z7XWZ31K+a/Ef8tq4RNReFoHtfW0Ry2LyCd7IaE9YceBS5A8XcgTnmy8oRnegH51FA5ApbiMqSDFfMDrFpQnsJgl6t6iTdg7PopnaYLWmtRkNZvrfMa3fHDEWwERHODpSiNLgPnYDBbSztIyv8pPfSu/ZebxHeo0O8rv5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhuGs1hGnXUmt37E9qd1tbYti4EboLpVQ2TRoAXN87U=;
 b=baS7EforP69UGD6yp9OLNHossVkneqqS6wNWN9i6BIbnBd0p575/USJb6aJiB5d4qL7NPfYGuVLMZN6EmYiutiyCWeJAb95fTvjMv3blS9jsAqvvCTYS1ojT8l4H2bVwN5n1diPB3gUEJj/UT8dDpT1zRfU43EYZbxDFHnZwPyQGr8OjwlPzmZ0OoXSet5NBX84ChJzRKAG/kSjRUXgtmMvEt5tXeXbrU5PZc6/NeWWcBjqGTqDTQD6bGy7hs/Uncfs2mQnPFq2jnhsH2aOzrwLjrdp4mC//KS7ROmwkuuo3K2JP6gSB6piztWEiTVL1la3ghC6kgWuR5Yl/9IwwpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.29) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhuGs1hGnXUmt37E9qd1tbYti4EboLpVQ2TRoAXN87U=;
 b=pVf58BhGWVt0vnEu+8+hQvx1BWk5U9m+HhVM3m5gQ0+SKiSo9XyWwIFGr9mNwzn7fmoPPcnrtPWrrWz2s3M2gBOx9XtZLbBm99N7W0+ok1D/cLrkS8LV7HnNWu9EkO0fZSbjsb8fBDDSBb239so8jADEuhz/ynsB70AWRrNxc99BsKU62/bwdtoFyTcYUDMPeFGK61sidazbx+g9LKRQ3uNfyMNKMmb3rCXO4ObcDOdAdk0xOkph9yBDbd8+DvXDHNouwyYsWs3ShJ3Btf2ewXydW3Ae6vdkr19qUN0kMc+UGNALRS6QGDymRkK1VHvcwyPMAJGtuuMynfjpCCo8DA==
Received: from PR0P264CA0070.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::34)
 by DU0PR07MB8713.eurprd07.prod.outlook.com (2603:10a6:10:31b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 15:38:30 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:100:1d:cafe::17) by PR0P264CA0070.outlook.office365.com
 (2603:10a6:100:1d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Tue,
 22 Apr 2025 15:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.29) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 22 Apr 2025 15:38:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 848CE20A29;
	Tue, 22 Apr 2025 18:38:27 +0300 (EEST)
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
Subject: [PATCH v5 net-next 05/15] tcp: accecn: add AccECN rx byte counters
Date: Tue, 22 Apr 2025 17:35:52 +0200
Message-Id: <20250422153602.54787-6-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DU0PR07MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: c83329eb-b1c9-431a-3189-08dd81b3bacc
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?OEhvMVZJWU4ySmRGWjlGRkhLdEVOZE5tNmd6K05qWDlueXR1aWlLenZ6bWFn?=
 =?utf-8?B?aWFKWi9vV0wwVVovZmREdm1qcW1QTGNoV0ZQTFIzYjIvSmYwZVd6cWhicitV?=
 =?utf-8?B?d1NRZ2U3enJGeXBYSldXcUk5SVU2T1FRSWxkNjJYOVNwN3VldStjNHNBTG9Y?=
 =?utf-8?B?Rk1pclJ5anhKcEZJcHliNnJ0a3FTV0xVTXkvbkpuZXVlVitEaWFVak9Qajdi?=
 =?utf-8?B?WDdwamNmOU9OWHVOYzU4dUJkMGRCVnRaN09IbG9OTGRiUVBXOUtCalo2R1kv?=
 =?utf-8?B?ak5rL29OSjZhSWY2N2tkbDhiMWFoWDFhKzhOdmpyZUF5RU1FcitjVkF2eDhF?=
 =?utf-8?B?T2xkWjRZQXI4Q0lGUk9HWE5uMUJYencyRW81MEhkZlRVeTZKbmVsMm50NlM1?=
 =?utf-8?B?TTNHRlRUT0lwK1ZKckdmRC9uK3hjbmdTcnZYTmVmMWkwZFhoSFNVcVRGcFdr?=
 =?utf-8?B?QWtMZGRhS0VMZ3hIMkZOV1NqUDRTckJVeW0rcVAzcERwYjJOaFQrd2tWU0FZ?=
 =?utf-8?B?d0FxbUdLaFlueHVLWjZRM0QrWmhEdEJDSlovTmt1dEFrbkNPSHNSaGxnRzVl?=
 =?utf-8?B?ZHNMZDJ0TDNLZDZNVXpOS1Y0RHoyVlQzMjR0SThHdXFQRm8yNmFSZUI4TTNm?=
 =?utf-8?B?UWhnaEpobGQ0aGl1alprZFJUZjh5WjdNaFFOcjBtS3oxM3VMSU9KSTAzTWMr?=
 =?utf-8?B?M2krVW1Qa2psaGM1eVJ6bjc0eVNKQjdWZmtqT1NuL3ZjaTFuS1NtTzdTZWo4?=
 =?utf-8?B?M2NUd0NuSCtKbTkvblVqQ2ptcjIzMDNBZ0ZxdWttSzEySldydmhxd2dZamUz?=
 =?utf-8?B?UndUd2I5ZTc2eHcvek9HY0QwM3ZjSm5PSTg0RkJnY0trcUM2cWR3bFVkUVVZ?=
 =?utf-8?B?emFHSVIvUnY3cUs0cHJCaEZmYTRNNXZnTFRTTzRQajN4TEpCWWE2ZGlhbVhU?=
 =?utf-8?B?Ty9Pd0NHTXhMcWZ3Q1hGRzcwQjVHZ2MxTnN4SHpId3Rzem40TUhCR1hsTytG?=
 =?utf-8?B?MjJrQlpUdmVvQ0xIZCtpMmRRdWI4aEVuWCtWd3BsZXA0MWd4VDh5MGtLUHFo?=
 =?utf-8?B?aHIwOHNXbTB1THQ0cTJyTStCWFJyMUdJRzU5VlJBZmpJL1BEdk83ZTBTemZM?=
 =?utf-8?B?QUdYYVNsOWVLTU1EVlpXMEF4SUxYSXRDVVY0WE8yWjdTYXVrREpEd0hXOU9O?=
 =?utf-8?B?dHBVVlFUNUVWTWZMallQQlQ2U0Mvc1dYRVRDazNoNlowZ0Nzbmw4WVNFUFBB?=
 =?utf-8?B?a0Q5ZjVLb1lwVlphMitaT2RpLzNwV2d4bDdZcmRWV3R6VnJ1SnF2N2xvdkVn?=
 =?utf-8?B?NGEwSUlHTGFialR6aXlERWRBQlNJYTR6MFY4Z20ramo1Z041alNPWVNZdFVQ?=
 =?utf-8?B?VE8xRXp1UDVYcjNyTk1TVEducm1SZFFlamxoQUNNYzh5RTV0TDBsdTlKR3Rq?=
 =?utf-8?B?MWdSWWZKODZPMjVvZU1zbjM3bVBSc2dHY0NOODVlZFNMNG5XaHBkL0VqeHhs?=
 =?utf-8?B?OUc1UFBnTkJtUXcxcHhtTFRiL09NN3BHRmRrbzdIbW1yVHpOMmpqd2U5bDdQ?=
 =?utf-8?B?VElYTWVIeTVZc3VQdVQvQ2ZJNjdUY0xaeDRBbmVKcURvbUgyT1VhODVXaStI?=
 =?utf-8?B?UVJJbE9xWXArNTEzeCtvclpyZ1ZsbVg4elBZZHZzU0NwWHVPNlZuRDMzbmJL?=
 =?utf-8?B?WDJLWlB4VmZRYm9ZL21ta000ZWhWWmRwQS8wQTErVTBCTlJaV2t3OXNKK2ZJ?=
 =?utf-8?B?MTZHQjJSazkzd3FoYjdzWXQ5VDFUTDc4M1ZRd1lxM1Q1ZXdBWWQreUlOQzZV?=
 =?utf-8?B?dkt1MmZEbWt1REs2UUtUamlORlpPL2dMWVFoVzAxUlllbzhLY0s4Slo3Zm1C?=
 =?utf-8?B?ckxCV3V4dlhBZitPWGNYUjN6UlFnS2hhNjh6WTR1bE8rVnQzbEw0czJlSjcv?=
 =?utf-8?B?TXBvUW40ekIrVFJaYlBHeFRmdlpNdUxJQjUzUUozOGJuQ3E4UEp2Z3Mvb00z?=
 =?utf-8?B?RHhnYnVVc1dYUEpicVphTHNVWWVtMEJWZDJTdWVhSkZ3ZGVGODdXbW5GT2Jw?=
 =?utf-8?B?WXh1dlBHNG9EMnh1REltSktETXZLdUxOeWE5UT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:38:28.8926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c83329eb-b1c9-431a-3189-08dd81b3bacc
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8713

From: Ilpo Järvinen <ij@kernel.org>

These counters track IP ECN field payload byte sums for all
arriving (acceptable) packets. The AccECN option (added by
a later patch in the series) echoes these counters back to
sender side.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  1 +
 include/net/tcp.h        | 18 +++++++++++++++++-
 net/ipv4/tcp.c           |  3 ++-
 net/ipv4/tcp_input.c     | 13 +++++++++----
 net/ipv4/tcp_minisocks.c |  3 ++-
 5 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index af38fff24aa4..9cbfefd693e3 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -303,6 +303,7 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3];
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index f36a1a3d538f..6ffa4ae085db 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -467,7 +467,8 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len);
 
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
@@ -1035,11 +1036,26 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
+
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
 
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* State flags for sacked in struct tcp_skb_cb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 73f8cc715bff..1e21bdf43f23 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5092,6 +5092,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5099,7 +5100,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 7);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc34664805f8..c017e342f092 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6106,7 +6106,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
+			       u32 payload_len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6121,6 +6122,9 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (payload_len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 	}
 }
 
@@ -6398,7 +6402,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6444,7 +6448,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6491,7 +6496,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 	}
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters(sk, skb, len - th->doff * 4);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 779a206a5ca6..3f8225bae49f 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -497,10 +497,11 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	if (treq->accecn_ok) {
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


