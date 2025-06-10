Return-Path: <linux-kselftest+bounces-34573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34197AD3825
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6379E5B3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911E2E62B4;
	Tue, 10 Jun 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kTZpAwoZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012024.outbound.protection.outlook.com [52.101.71.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9682DFA43;
	Tue, 10 Jun 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560027; cv=fail; b=T/6+2E3avH770tA3L/fKXk7NA6IW+dlr8xhR+8XOF3dFLYewTMH/hW1S2gDM0ABr13PJ34FSQO5PW5u6mU5hGpJASyDnQO06n7sbNWOU6XJ7aq4/HB2jTTeBvVfrtY0rCkCx5DPaToBjfgMPS6MipPpRVjs/1qaoCO3gTveYGMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560027; c=relaxed/simple;
	bh=L5I/oAjR9YXdUp1JP80wAoEIFPTi14vJR3dwZ+pquZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHybJgHnqvmG+X5RfpAgTdhT1I+W15+QexHr7Oe6IyFiVpQ1CurDawBkAzys8Pqy6GZG17lT24huwFQ+/OxzDAxjvBejt6JEc3tPruYxqFAtuJj5G78LkuUZ+1HhY7z0D5qKQ5F0RvvG50F1Z3Anc1NXEudzydKrMf+jbf4WHns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kTZpAwoZ; arc=fail smtp.client-ip=52.101.71.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNXeu2P/Q91tzx8A9bqGaeVkYgD3VSWZT8Vat5boRm5OlBY6NmblnhhDvyTJAbG8VwMeEGsKtNgtp0LmFA6U9Y1yxJIott7OC3xFcptETZjEJNRwyGbIezhXwE82Y0t+LCTX3uNgm8IWKesxEgH+02jkCnrYYxHciwsZmur51bbEIm1ZdMdpXkygeQHJ0QUpy8Skjt0/NihsM/d7DYUxPua6NAI8e1VhVYj4iVRUdFa9NTsKKMbr+TQs0Bzbpsg8ueAPvarAdNIRAKBu6WDxuqbqZx20lpobObue8BEGQeeey3NVXSIlBP6YH3ghv7WvOeUIIkvTMGeGM+XUzoFFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRGvM6frFoXMLXTI+bn0VmIGaJAOxB1m6SishvS2ER8=;
 b=CYFrCYtRgQtXunzGGBL1DNT0+WKH05rrqCyIY5tb4erddmxTVLh8IPr3+VAv3HH72BQ3qsFEwz8t0IH85BezgUAML7aZZpX7doCw7pMIeb2amMUv3aO1F2cgb4aSwOBpP+S1O2zUDxBFB31miXEZI4zrvDEWqtC8Jzo43rk5Ja6btgkXJxw1EnAIQ4ZPZ4jJO/SM6OsiEB4x9v9zFb92DbQQEElfrYZVgk5B9y7ZdsoaToRsQW6irnU2T1dS2QXy7rksQWpWBIC1zLnerdwoRuNtzJl4h7PRFWYLeil9HlZQHfMjbBgYxTDz0oxaIoyJecr9gHmSZ45AJTZ0eBb43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRGvM6frFoXMLXTI+bn0VmIGaJAOxB1m6SishvS2ER8=;
 b=kTZpAwoZSLJJtLohcOrH/ysWi3MEwXTEqVESfuqm5gjmILocmgHfTgzYXe7cJz2j24bqM6kHbD6Y4OV5D028H1zPXWv9N7OSg/lKTPK/gVy8zAaLoYRy0qua0E5jX7uzw1Iiby3i0l9IbSgqu0s32ctrMUMMgswKgZsewfNMOmPXeiwhRFasUHCe5URGZmN8GpZEfbsDSngSJkl2q48XO7A4ZTrtvowRszVLsq2GKkgSQ1BFnQ3jv7oZsnVtalKqYtrM3HBNo9/lAA06R1eS7P3iULXnXXGZ5cDIOKJDWy8Zk+a+/GpnV060MBiYBe1mEPFD/0AKxa6Lg8feZbvreQ==
Received: from PAZP264CA0062.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::8)
 by AM0PR07MB6433.eurprd07.prod.outlook.com (2603:10a6:20b:144::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Tue, 10 Jun
 2025 12:53:41 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:102:1fd:cafe::49) by PAZP264CA0062.outlook.office365.com
 (2603:10a6:102:1fd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:40 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 816DB2004A;
	Tue, 10 Jun 2025 15:53:39 +0300 (EEST)
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
Subject: [PATCH v8 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Tue, 10 Jun 2025 14:53:11 +0200
Message-Id: <20250610125314.18557-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AM0PR07MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fec49f-3f42-41d5-f1f0-08dda81dd364
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aWYyU0owWmFsZ1RCT3hSOGJsc2lsKzVNbXU2OWo2aTNscVkrWk5WODErSXgr?=
 =?utf-8?B?U1hmNk9GM0ZsRnNIREZoUTRyejRSR2E2azBoL3ErMlBkdW1YM1NhMVZmcW43?=
 =?utf-8?B?MmYrdVhrWVJXcTYxQ1RnQUczNVF5N2xQNit6emVtR1NiVUttblVhKzkyeEkv?=
 =?utf-8?B?dnVOc1d1Y25uZFB0aDhneE41Nzl3ZnAxWEZDL0pFdjBrcWROalpRWSt6TTJG?=
 =?utf-8?B?VVlMZ2lDZXh1VXF0b1lsYWZ3OU4zY2ZmNWdXVC9aUElSTnNkcWNGdGhzYUdV?=
 =?utf-8?B?cUNUVjJ4MjNZV3orYmJweGZsaWcrSGJXZFlWN0ZxbUVJbWtCUDlhTE9QSzV4?=
 =?utf-8?B?M3lNZlFmaGRFV3Z0c2NRQlpzVHVYMnU2NzhNRnQydmJyTS9FMlpQVXRPUURF?=
 =?utf-8?B?bkttK3QycUorTVJ6dXJTS21BcmY2Vit1R0dhd1BDcVQ4VWMwNWd3Mlc2ZlNu?=
 =?utf-8?B?ZGt4WUFuQWkxcjBsZjd3NDUzdDB3ZS9TTXU2T0JmbHp3a1JXRlUzb1BidTU0?=
 =?utf-8?B?SGFCak9rcXp6bjZjcDJueHIvczU2TUQ4ZGFrQXhpWStNK1hyYTVDTHVrY0pz?=
 =?utf-8?B?eVdUMC9PcVVKbjUzR043aXhDUmZ1SUJtOG5EdUV1Ty9CVVBxOE5uV2U0c25J?=
 =?utf-8?B?MnZZQVJ0L1ZhQVpEeFcxbUxlcXBBb254UVBiUFpCQ0wwd2VZMEFleExMVXMx?=
 =?utf-8?B?QnlGNHpxY3d3YU1TZkcyRHp5WHhKNDdpK0NUbXc3TE41MTJkbXdRVUxnRmIw?=
 =?utf-8?B?S1EyaVZ5bmNMaFdKWWZ2RnhyUU52QmM3NGt6VkZ4bVpZZm9WTnNrNHBLRU1B?=
 =?utf-8?B?VERtYWUrUVQ5VVNmdFNXZGUxeWtTQlBDOWdzVkdyZ05OaTZaaGlDSGxxekc4?=
 =?utf-8?B?Y29MSUxzOHR1WnBvcmFtNWpEYlpwUTd0NXFTUXc0MjZaa1ZNRUVNQVNUcExF?=
 =?utf-8?B?eWllenp1VXNlek94RjkzYmppd0ltNEVpWjFmSjc5QUs4N2xxZHFhNGl3bFNX?=
 =?utf-8?B?TTlIUnBZM0xqRjVsazkvaDdGWHhOdVZ6K2JEUjh0NUtJd00yWitESlZoVTBS?=
 =?utf-8?B?Y3lmTVU1SVRaYmZZcmRlTGNyajkrd281MGFuaElBMEFWNU0wREJqa21OTURj?=
 =?utf-8?B?TjIzQUYrbnJJbjMyeTdzYzBKS1pMc2Y0MWdGcy9QTzdvYlJPdGVIWHZ3bm9E?=
 =?utf-8?B?L1dFT2F0c1RrdUI2d1V4U3VlWUY5RG85SjBSdmYvZ0g2SFBqRERIeTRKMytm?=
 =?utf-8?B?SUh6enlEV1l0T3pLdC9oOWMwY3E2WDVaLzlNZ3pNeHRZWGQyem96REU5OUVx?=
 =?utf-8?B?Y29waEdFSGlQamp3dWhsWC9xcHo0dDJwQWlXLy94V21vbmpnU1E4RnpBd0lN?=
 =?utf-8?B?aTU0Y2p5Mi85UGFnWWVrZUs2bFNpNG95K1YrM1JkTXdUTEp1ZTBnTmlOR05V?=
 =?utf-8?B?L2NzZ3VoWlh3b1Z6WUZQU0RsUWo4dDhHdWtDTnFSUTRMcHZWNFZvcHNtaGdj?=
 =?utf-8?B?YnpNR2lZVVQwYm9VK2NDZkwraC9GT0tBMFRYMkNEYlNhY2ZSTWRkeWFtS3hx?=
 =?utf-8?B?d3hXRkdpNXMxSHRjZ2xkVFVuZ2c5V05sNGtJb1dBTGJyWGprc3ZBYXNYWDNa?=
 =?utf-8?B?dDBUaFUrZTBoYVV6ZVRyc0sxMkZ3VFE4eFh4enBxYTVpZ1ZibEVIWmVWM0pV?=
 =?utf-8?B?SklnZlpmSVFCUFdKMjNrVEo0MURRcHBibFp2UlY4UmRMSGIreWVBaHp0Ti83?=
 =?utf-8?B?bUJzTlpUeGJnRXIyZ2ZwTVVoNE9rY3U2REJuOXM5NmZhQ3ducXM5UWdQQ1Vu?=
 =?utf-8?B?THB6VDE5VXhNbThBcWlJNS9rSnFuUC9RcmdYQzQvNTR4RS9MNnlBRjZkVWIr?=
 =?utf-8?B?bkEyQ3RMWm1jR3FsQTdKSXI1Z21RTmFVaUpibk5EM2VPNldyQ1k2ZFZFelZ3?=
 =?utf-8?B?OHc1enRMTktFb2Q4TUpzZW9pVWVhMjFDYytLaFA5d2xZbXpHOTNtd1FzbDRP?=
 =?utf-8?B?V1dPbUN0SGJBdkg3S2pDM00xbTNGWGpuRy9uL3NMcmtOTjBSVzJnaTltUVF3?=
 =?utf-8?B?QmNqdGhmclJ6R0VORU9aN2tSaGVoK1crOXVZUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:40.9804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fec49f-3f42-41d5-f1f0-08dda81dd364
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6433

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
index a2c330afa883..454b2254a64a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -247,6 +247,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ffd9f462370c..b0492f85c4a7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -709,16 +709,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -741,6 +744,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


