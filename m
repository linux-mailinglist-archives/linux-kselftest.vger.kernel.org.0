Return-Path: <linux-kselftest+bounces-30818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7CA8925E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 05:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF05189C024
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 03:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DFF4594A;
	Tue, 15 Apr 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IuFtvAAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D564F2DFA32;
	Tue, 15 Apr 2025 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686490; cv=fail; b=YBIjet2LDgPhzWCGYiTzAO5/2NhxVWgOt1WAA+zZDZY6j5v8DMUDtAgNpPq2rjApsxtuICkKvc9R7UXuHulelYpFGEhNN4zYmiC/Y/mT90RLF+xgHk7mOYNkvO343lVnEJy3d55I3gXkwdJNW2GMG61cZ0Erkdhx7Vxc3Sfm7vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686490; c=relaxed/simple;
	bh=e7UrFITwpmygTjGLAEnZ3V7gb1JncYGCuLIqU5AKJKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTL2rpfQZVYNO8KMzM4GfZra2m/7NW+Y9YxpA2qFrXCzv00MO7YujF6CVZZbOFp0GDNnzX6TdHxB0NL3yPbU99PONqQPagYrbeMisIXcVM6no2YUczIG59YVlxwKr9Ha9ne48Bz4YjGvFPUiBpSs9+ImgjgMLSJ8+QXvfdXlegk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IuFtvAAT; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbZLFDzyzKNAEZ1TJXrWcgg5ubpnlK+/rbemCCi1v81f5Z3BSz+eLRJTWlSGZ+FhABpmigSZIX70Oz/hhLLc6/by1XWDduUeD7d3g6XyyrDfQfXmLIiD67bScInTQitXRvijWYXs5LbOwn+2EpjC7spSC6AUjyUcCxTzEC1kqxTDnbvC9FzlAGegflK92qGN8GrviYLDFMqbrun/sKBEsaEK/d6LxG4VaL4yX+tgTiQIRVgOM6PUKkG8Xdqe2ppy1rQTIwFTXFktjJW1xOoHzI6Q5/vYSDnaoujw7P7mjHLaXGj5OozBgReW9UMwnVeVyZc7FUaBKVUjaWm6u1GT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7r8uly+ZR1PUPikdYkXp376WrR5KVziPb7QO8/Apvo=;
 b=aZg0k0cxF7jVicQbU0P2l1QTQpHKWS01apc1luFhJpLWa5UpImEnwdyoHBdq0dBuXoKkiipISy+m91xzoDPUbMNj6Xu7HSbKde5ms7lGKV7cbVUkKNhKMsSiKTOiEcGVQeQt9FGbXT5BXZGlaJOS2QjF0a6cQXLrwI0lbqQy0kwS/LBImYhOtbAs8RauvVi0Q9BtM9Qhv2U1kzJt06F4QZsuOabIYDr7vW0Klo1LUv9qCixKV5SGtTN3ZQQDouHQscUWGM5Ls8KpPMkqphuHDH4InpLLLqNt/76NV/HhB+HV/RRBmH8a4kua5obAsFqFadsmX6EXYV/evnJGmpO++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7r8uly+ZR1PUPikdYkXp376WrR5KVziPb7QO8/Apvo=;
 b=IuFtvAATrn1pVXrGmFggKJRdV4jtiBMbwyr+YgUbwbAeZJzYZRhBG9IuLE95ehTwin7OxAiDPtM/pLhQjEfRGCOsLIoUtKMXKe8ZEQy69jJyjHuDcp9vnVNGbS3C41ikuSmeSTgf0AS85OKOdPQ3mIt5Jy8CJUVhl3WUjsPf5ba3EpoVy7STrratvdoqZRSuIeX+7O/Wz10hLpgt709Tdo/F3wsY7KeEme2z6K7EsDazuE68O2UUPg9fVEEZhcKRkLd7B68nnpN/vp2N8BPYRvVQyijHtAJFwh//8WsdGAwdXIXjLEYTq/bvFFummyqSv/DjzY02wUoIO+Zypr3+Uw==
Received: from DB9PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:10:1da::33)
 by VI1PR07MB9732.eurprd07.prod.outlook.com (2603:10a6:800:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Tue, 15 Apr
 2025 03:08:00 +0000
Received: from DU6PEPF0000B621.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::6f) by DB9PR05CA0028.outlook.office365.com
 (2603:10a6:10:1da::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 03:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU6PEPF0000B621.mail.protection.outlook.com (10.167.8.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Tue, 15 Apr 2025 03:07:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 990704EEA1;
	Mon, 14 Apr 2025 16:00:10 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
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
Subject: [PATCH v3 net-next 05/15] tcp: accecn: add AccECN rx byte counters
Date: Mon, 14 Apr 2025 14:59:34 +0200
Message-Id: <20250414125944.97350-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B621:EE_|VI1PR07MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2f230b-4b46-475c-40ff-08dd7bcaba81
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?N3FtWVJWQjNSNkYzeE5UOCtxRFo3WmYrT25EYmdGd1lrS1NNU25pQkFhQm9Z?=
 =?utf-8?B?MEhpcWR1eUc2WDBzWjNrTzRZK2dEL1NqV1JER1R5M3FEZUdiUWd2THFhbTFk?=
 =?utf-8?B?RWhhdjFKUzY1eURvNmtsM2JKRkxJNy9ieExXZVgxQ3pTeG83RGRUMUxKc05q?=
 =?utf-8?B?d2FMRXh2MldVZFo2ZzloNnVPazJGcWIybGphUlAzdy9YbmsxR0VwQmJUbHRB?=
 =?utf-8?B?cFVDOWxJbGlBRTQ1cXlBWHdnMGVRemdTVjF0ZzQxTXFCN1pKZEp1ZVZOUEJs?=
 =?utf-8?B?d3FacmVJUno0eE9VZk9aSXVzeFZnVTNiTEV2MUhTdXBGL2ROUkprOEZwTGJz?=
 =?utf-8?B?R1RiLzB2QWt1QWtMRkZzYzdVNXM2eU1MUjdIY3R0T0R1aFprL05aZ21wWVpE?=
 =?utf-8?B?K1g4Tk5Gb1lOOTBjVzVJQmo1d2FPTVpBQ3FqblZYRWJIRmsvLytxVUJ2dFVp?=
 =?utf-8?B?SXMxS24xUThYNWs4a1NQTmJ3U3NTWjh0eldVZ3ZzQVdzcWhGQ1F6RHZXa1hG?=
 =?utf-8?B?a1gwMmFLYW1LR2hTbThGV2REMm9rU1FIMTQyMjQ1SVVmTEJMZVA3aE5tbm1H?=
 =?utf-8?B?U09BclFFVFEvTUR3dXNrdjd0OHkxOFpxcGIydUJxUVc5MkRwV01MSjRSdDNY?=
 =?utf-8?B?UXhYMGdEWG9qcWgxY0h1TzdjT0dLT1ZrU2ptbUcwT0NWWHNlTmxlQ005Y1JT?=
 =?utf-8?B?N1dDUFRJeEp3UVIwZjhxK1h1UEhiQTVLcWVRYzJvRXlId3ZIN0VHYzg1WUpo?=
 =?utf-8?B?Y29sdmY3Y3B6U09WOHBESjZiNldwMGtlL2UrTXhCWUpvK2dURkQvcS84clM5?=
 =?utf-8?B?NDJKNW5EMENMV0J5d25veWFGdHlyNmRKaWFvR01KQktjV25TY2FWMDNPS2ps?=
 =?utf-8?B?NHU0a1ZDbUNpTjZXWlFKUzkxR3Q1cjk1VDN1eGRCdStQcnI1dlYyYytJQU9N?=
 =?utf-8?B?QzVGS0hWb2xtZnFyQ0ExajIrL0RHQ1lUcnRqbVJDVkJWSm5PZkFJVVI1YnNR?=
 =?utf-8?B?NVRQM2hXcC8wV3diV1lNWlVPYTAwNndlNW5IN2pKWWgrbEgzd0Fuc1NtSGZz?=
 =?utf-8?B?Q1VCck9kVlE0NUJRMmNrMC9TVUUzVlNrN2tGTWFLa2JOVk4zKzRVQXYvS3J4?=
 =?utf-8?B?aWRyd2s1NVBlTk9rNmp3TmtuendmTmhwblFMeGZiSDZ6dUxKWExZWkZ5VTlQ?=
 =?utf-8?B?TE00YytVQk42TGRrSC9oc3JMalRsa1l2UHlZWHRHenhEMkxxSXpYU3dlZFAy?=
 =?utf-8?B?OXNzWGt4c3V6U1REQ1g2SGQwNTZXLzI1ZjJpQlAyL1dCZGFaQk95aEpBNlRl?=
 =?utf-8?B?Z1dFZVBhWHRBNDFkcnVVSk8xTHB5S0hFVlFBNWltam04L0xqZjN5dGttcmV0?=
 =?utf-8?B?dktMUFNxUWdpTjQ3MHFKUlRLZm11M2dTOGVlWTVkWHh0a24wQXhkN0tmblJq?=
 =?utf-8?B?ZjdqQjRFTmhjOFRPc0xrek5rb1F1TzNHQ000VFczWklCT1VOa05zVVJKY3Nm?=
 =?utf-8?B?VFhjUVB0QTBUdjhWcEVDZ0paNWt1Y0pxR2ZJWjBVTUlxbFVKWWlOc0ZtSHF2?=
 =?utf-8?B?K00wNEdUMUd4bEE3WGdzSFM2NERqeEIvTTVETDUxYjN2ak92OWhGcFFUNDJ5?=
 =?utf-8?B?cWJjYTBrWlBSdldleFdZRzdPVFA4K2xSTEhtS05ZVXlDN3I1RStsaTA1Sm5y?=
 =?utf-8?B?M1NhWkY0TnF5YlEzQjljWUpyMFd5QUhVZmZtdUd2RXBBMHFCbHJETEpQRnFp?=
 =?utf-8?B?MC81R0xILzR4U3VOeFZ6T1hlUkdROVJkUTE1aDN1R0E3NVdsbnc3QUQwelVW?=
 =?utf-8?B?NXo0UnZwZVIzZEhZd1BvL1NRTEdZOVZaVVBWMVZVMzkvb1Z1THM0Zzd5cGw0?=
 =?utf-8?B?aXNjZHhJMFdxOU9OMjgwYnpMdUNiR3BtOWpLK2xDa2xTZ291NSs2RHJwV0hv?=
 =?utf-8?B?MkNaTU5NYUFXWCtMaTl4ZU5yc0NydHVETlRLem9vbWhKVzA2SG9YY04zVVkz?=
 =?utf-8?B?djM1bExnWVErcEV1Y2hmaTh6d21iN0craVJ4cUh5Z3p5YVM4Tk15bERZN0VZ?=
 =?utf-8?B?Q2JUYlg5N1dJWUUzeW1mSXVKZmtwM0M3MTJ2dz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 03:07:59.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2f230b-4b46-475c-40ff-08dd7bcaba81
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B621.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9732

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


