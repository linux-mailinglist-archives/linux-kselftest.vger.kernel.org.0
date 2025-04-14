Return-Path: <linux-kselftest+bounces-30690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8867A88160
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFED177F0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9013E2D1F7F;
	Mon, 14 Apr 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Tc+HJ8nK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F1A2D1F7E;
	Mon, 14 Apr 2025 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636448; cv=fail; b=BtvqTVyEJNvoAfwqjJacrA/YAF0TmNYsnhG87ADQCA8u6RhzPkp1b6Z8z0BjPJR3Z0cvKCTrI1Y45Q7Syd+AYANklr8JH56RA97ddOp6/t2/e0GvhJJcpTyABDC/iG84s1K3mq2Kqi4VGiVxmAbEH6CuuaqfvDoYzDkC+J2lAVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636448; c=relaxed/simple;
	bh=e7UrFITwpmygTjGLAEnZ3V7gb1JncYGCuLIqU5AKJKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIQoCIXeSHIDOx2599IyvL7wWeqtA/tWoDvm+IPGUVqOEch4/rKT0uzWr7oF915Zn1oRKwp+0DRAqIgey8STXm1Jj5FvdKoXWLyJbot8gVvfK12fp5BMckAG43KlQM8zGZ1NWkSie/F5bnd23b8ZUuDvyqRtJ+sdEG8I/Xf88ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Tc+HJ8nK; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ym+Yf4bbEtHd/oPmasm+v5dfEGSvceCbt3c+SuSN6ilM5yffTnHzSW/+AV7qkAU3M0zhHuwOBVrPOnTTG4p0bSFBOsbEhjj4I7fddr4RkPW6bb/+icev8oeG0znyOEmOjwoSXzs0k5gF58HMm94Kw4GGFDlCMr1RM+Oec3ntjg0pL5nbABGdFc+bnmTZiie4jbBRpRJul4AAxl2+fPKG1baGx7hjRBuJp0+AJ+bPay2DPXD2ZlwLtfoZHouU130kuNsOHd1yeIqylDAoYDCdaWzhNxZtBD4vUqlJvOkntf6Zt1DvZHDKf9z1z0QjMpMmPICwRs8j+WQAKqIKkricfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7r8uly+ZR1PUPikdYkXp376WrR5KVziPb7QO8/Apvo=;
 b=pZzPHO7A0i/gSUa01KjOj+hPxVbcmnycfwKgKtwgl5VyIjXK07fPrNQ0psB1+bviIwF8dNQWkvHYrDbNeibXQrPeVYUc1UxDr4Fxy3/987MgbbkkSU7QnELbH9CIzN1DYoYWqE56r17HPIaHDOstJf20t/nfq57GgV9N9v2RbTwvoqd7VocGjBqEa1S/E3dSN9BcEVbbHkG33Itkh6ZbLdqtn4bhAgrdLynex8s5iF2HoTNL0Uul8hTKomnbhRPiyboHMRe9ZjWoXoZhTaaSw2wPR4Qh2ntSXu2LndRZ0Mkwfx7x64k3FIFM3/E9cUHb7/P8fQdhd28XQvOJsWwfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7r8uly+ZR1PUPikdYkXp376WrR5KVziPb7QO8/Apvo=;
 b=Tc+HJ8nKXHmWVrSD8NvjoW+eEKGsXyeJOXBXwnG3L1Qbt9Qpkg13wP5NpHmrpywlHQTw0m/JyzYs2yEvwq98wtfLRp2VNBbmm4iKLnb3D4J/3ptFmRpuOMcEsr01eMagRZmOmloJJTvNzAoGd4C4kXInXVvP044vV9z0O6FOKMOiQ47i8bM7FO/Va+rXyGr0nY7U6uTMctC/3vh+yC+V0zU8KNmQrWI3w51jv1bSoJYWKXiLdnt46l1+Y7xdhK9hGAEDsU/ozSgausKE1TShayMbP+vrX09aA434TjEzFpbQxqCOqpHb00Bqag5tqNGWq0mpUS6RgfhiE2aSUlCLkA==
Received: from AS4P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::19)
 by VI1PR0701MB6878.eurprd07.prod.outlook.com (2603:10a6:800:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 13:14:03 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::73) by AS4P189CA0018.outlook.office365.com
 (2603:10a6:20b:5db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 13:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBG009623;
	Mon, 14 Apr 2025 13:14:01 GMT
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
Subject: [PATCH v3 net-next 05/15] tcp: accecn: add AccECN rx byte counters
Date: Mon, 14 Apr 2025 15:13:05 +0200
Message-Id: <20250414131315.97456-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|VI1PR0701MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b0a76a-8c19-41ac-9a6e-08dd7b563a5a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QWQ3MUVMNndWZ2labGhLZGQ3OUdTQ29LbTk0aVRhZ2d1a0lMOEhmNUVPbk5K?=
 =?utf-8?B?SDhkbUlCVW9yM2hwRzRKR2d2Q09SVzlicnd6eVRsUkl0TmlWTk9lSGkxaWto?=
 =?utf-8?B?SVhWREZ0bXA5T05pOVk4ak1TWTgrUFdrbkJ4ZzNQbVVtQW4rNGNQellxUVMy?=
 =?utf-8?B?U3hZMFhrRWlJcy9xbGY3VzhZZDhwcllIOXJDNk5CMGF6WGNQZ1RHSnRPSlJU?=
 =?utf-8?B?ZEhXcmRvVmVTb2MzMnE2STQ1a2RhclVNNVc3SDVDVUwxZlpHSW1vT3VBNUVv?=
 =?utf-8?B?VXVoZTNMbnBNVjF4LzB3cTlSMGJOSUdvd0JVS1FTTEdIbjdzaXU3N2dsaHFO?=
 =?utf-8?B?R25ZSThETlE1S3RqSUZNT2M2cFE4dG1ySVVPYjRiSG9qd2hkWGNqcWxDMGlT?=
 =?utf-8?B?OVhSaXBJN0hsQTYxMklmTGpxcklsT0lvLzRQTi9nTzVWakxRUWFVdjMzc0dv?=
 =?utf-8?B?VzhpcXdreGdMTWE4QUtHRUtTMVVpT1UzNy9BdWVNNXlFZ09GS2J6cDVJU0l0?=
 =?utf-8?B?UU5HVFpOcUMwRk1MbWVHdm0rZ21BeXI5bkNmNythUnF2aG1JY3B5ZDluSGR4?=
 =?utf-8?B?aWwrUlhQUE16ekoyaHlWWkdnY0dYUktEcXpTU0p2M2psVXlWNTl6MzZGcFAx?=
 =?utf-8?B?NHZXYi9JVWxSOHVjVjBlWW5TUEtqRXVWQTYwTGZENDQ4Ry90K1JCcW9OS2Js?=
 =?utf-8?B?UWpGZ0NkbldWaXorMTh3VjFwNGNRMUVjZ2FEM3BtY0JpVjZPSG5GT0hxRFRX?=
 =?utf-8?B?YWQ4QzZncEtIM0p6NEpkV3ozMUpCS0txY25BUEZqOStGV3VXeS96STNBRGMz?=
 =?utf-8?B?c0xYWHkwcUcrQ3N3STlxalVRd2M3ZjV5VjFiMmgrZDFtSFc2aUdsL0w2K205?=
 =?utf-8?B?UUtZeG1LOVNzZXdkOUExUS9GOGRpVEhmZTc5Zm9MbGtPYWlBenkxeXdIWVRQ?=
 =?utf-8?B?WENoQzlKYjBtR2Izdm1QbzlwbG9aRmhkRWREejBCVEZtTWhQU2VCemJaMVRi?=
 =?utf-8?B?YU16a2FRTmZHbFNkQ1M5NndPK2dRQzdRZ0pTUlQ0dmMzWDlySytYVjJ5UzNy?=
 =?utf-8?B?Lytnc0Y2NVI1RjNrQ3Bhb01zM2dBZUFtdlJxMSt6UmNySldmWkdjVEs5UUg0?=
 =?utf-8?B?OFI5ZTdMSWhkMnh4dzE0ZmJiOUJoOExycGRKZWhldnFHcERkZm1GWUxNNnNK?=
 =?utf-8?B?ZGJ0MVovbUZWNk5LL3htLythVUVFTDNhUEdlREVCQXdzTmpSRFYvVGZ6dW96?=
 =?utf-8?B?TU9pVUttYi9vYk5PcVBQTFR6VUwvTjB1c2tpM25sU2dmTzVaREtwNmdhSWtz?=
 =?utf-8?B?NjF3WGVOaVVGdEUvWjBiRXM4TVFHZHp2ZEYxcVV1aUl6bCtEbTJxT2N3YjJk?=
 =?utf-8?B?azRxeEFhRTZhazRmcG1lT0lHZWMyWmRvK25taDhWeW1RYy9BZjMrWDdIcCt0?=
 =?utf-8?B?R2I5NXBBbU43SlowaWZwSVRNOXFFbEFrNjBMWnh2b21BNE5xUnV5bW42VVFT?=
 =?utf-8?B?dWFXM3NrR2tPWWVjRjJPeWMyL1JSaVRUM2tmaGxzemU0TUdKYncwd0dOTkp2?=
 =?utf-8?B?WDJMRHdjRUVEMzVQQnNFaGRaMjRYU1huYlpRWkRlb2xiVExhakVpblhsdGV5?=
 =?utf-8?B?Z09JRTExaisyZWFHTUFJVW1CTTBDaTJoQmxiaXNWZlpiR1VDYUo3akx5Qm8y?=
 =?utf-8?B?VXVNUVVlcXNzQTErSTNmeUd4a0ZJRWVxdEl1bjFWQ29tNTVncmhUaHc0NjVn?=
 =?utf-8?B?dVRyQ2FtUlUwMG9yNDF0OXpvMUpzZnZ0WHIxTW5MZVZBZE9VTm9RYXZTWVM5?=
 =?utf-8?B?U2dQNVlOUG9OMnpRanR5WURMMXI4d3RGYlltNStWRUd3YlVTczV2M3M2NkJW?=
 =?utf-8?B?N1d6R0pwb2FDekg1cjJQdi9kTDJwYk1qWmI0WThKamFXQjExRzBRdHlBMTBm?=
 =?utf-8?B?V0s1ZkpsWkFJZ3VSbC94WVNOcTJGMkhHZmdXdFhQWFZRNVR6MGNxMnRqTndp?=
 =?utf-8?B?eTV5SzlRL05sYlFlUzhWQnRuV1Nna3EwZ1hlNkIzdG0vSUdpN0MzMmFwcUpH?=
 =?utf-8?B?dHBZVjRDSEJqem1xZjFwS08rRDNjL3l4QkFrZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:03.1336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b0a76a-8c19-41ac-9a6e-08dd7b563a5a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6878

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
index 73f8cc715bff..278990dba721 100644
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
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 109 + 3);
 
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


