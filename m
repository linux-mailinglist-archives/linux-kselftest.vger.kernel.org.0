Return-Path: <linux-kselftest+bounces-39076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF791B27B75
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EC61CC6347
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928192D3235;
	Fri, 15 Aug 2025 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qN11MHnP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B62D1905;
	Fri, 15 Aug 2025 08:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247200; cv=fail; b=VHH8aeKiJ3q02uoq3ej8/72tWQxWy+wa9BIthPplZpLjTiTFPt8b3U7u8kvop2+9KQPqhsDuRV0VdQdDPltnGabAy5NnU/yM4e17nb5rE3w5fMPyV43QkwNIc+3PSFRRVinI0UNRoNcojNrap8KvKHRM63uo5uzQPGEiZpn9Drc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247200; c=relaxed/simple;
	bh=U8YrC7zrOInPTGSJk4OBL4KgYu1dL3TRCG8YhTu6/DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8e/sbfuS+qrlxKbq0mKYSDIyYqgL2DETi/LxvnHVD1Ujw24KAMB6USZt1E3eA11SaTN4IsD3lEhZwkGrvBsYuZXJuYs1rF6nwQ4NUUkexcKrPKSmm0tpDjAYxMIBuo9ZCDvmS1/XZIMqi09TT1D4dXwK4zpbd8M+HDBpVJAQK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qN11MHnP; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ev0hF3TqzBBIBYMeIAws1l13Qx0FrPPPx1Z93osl83E3YdRyNDUllczXfqpu91WGFRah/p2CkWOFJp9YMsc/oTuvoEnBJM3NhwJlc4675c3iz7DU2wSUeUU4ZQvNrnD74TOtUAuZnzK53gXFLw0KhTpGW9qwCUHSlyGlURG3kJclZHhTLaWaEDy8sOICouSe8K3xMmuJ8CWuynoA7+6hsZ5rXJWlr9lPkz2Wc2LM12KrxSwqj3gSTSvVCPG7DuVYAhkQVH8BSWXLTej/37pt5gEoRbKEgxyVo4YLegoeUKUuXKEjGzQ8N5auPs5OosCU20r1dWNFteD4WxzvNGIaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBEQQ2pOhkWB+Ffu17nEVxFEvJsnrQDNSFuceGhKtSg=;
 b=hqAM2OozEByb9SqQ+wXvGgv/XvNm7GTxzx3K7XmXexKCKYJyqBhmKHm7kVsvAsfzmVF75zt3UaTtJkCk79rIgzkFSAfls5HLiCxErl+TVy/LKdCwthYWbS3crLv/vw+AxPmqRFdSu2Br4Nx6v4li4BoOIF+vKR5vf/r35b2/I/Kzc0T4OXIk/DG5r/4KzpqHQBr4cmRcegLZR1eCkEd1M6pfqmLz+Z90q0W743v85uoSUwGuX2BOmXg5u9G20YsNiPjermY+V5d03hUaMuxXrujehZDgfaYZSsp7+MpDyeLtP8vof/5nBZuc2T2+pUoKVcV7lchORkP8kUjNIxkt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBEQQ2pOhkWB+Ffu17nEVxFEvJsnrQDNSFuceGhKtSg=;
 b=qN11MHnPpKFSsPUQ5isgLy/BPdRr5TqcPIZyG621yIBWe2W0w5iaLcdPFmKG1+NlQ3jPlUhJlCqpHRLiqjCyIvOlYR7nyMCkftj8QN5Q3bf4RPeMUrPm79BqECBHdDJJ+kOC0BwPMSdj/WemGSKYtalN/Xy37zboqqwNQvMlPXwrM52cnZZfGXNpc/QObtlvbz4/mCy+QdBT7TJJermrMGD7vSnyHj1dWhtCzB2dnjaMtBekufQObAXCfxRxkN9vBljzbNJaH6C4/OjMBnPaxVt80fxs/mSGvJZo1xujwFoy59WKuS+lLBFcE/hcDKWHTUyg2m6Sknm9rsniTXEX2g==
Received: from AM0PR05CA0081.eurprd05.prod.outlook.com (2603:10a6:208:136::21)
 by VI2PR07MB10153.eurprd07.prod.outlook.com (2603:10a6:800:271::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Fri, 15 Aug
 2025 08:39:55 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:208:136:cafe::54) by AM0PR05CA0081.outlook.office365.com
 (2603:10a6:208:136::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Fri,
 15 Aug 2025 08:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id DF6F11C004C;
	Fri, 15 Aug 2025 11:39:53 +0300 (EEST)
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
Subject: [PATCH v15 net-next 09/14] tcp: sack option handling improvements
Date: Fri, 15 Aug 2025 10:39:25 +0200
Message-Id: <20250815083930.10547-10-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|VI2PR07MB10153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c776a5d-73ec-4da4-411f-08dddbd74f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFJQZ3VPUGxCM1k2Um4rN0Z2VjNDa3hJeW5KY2NqWG1EL1MrUXBlTmtEL2JF?=
 =?utf-8?B?Sm5sWGZxd1FOa3UweTJlV3RsbGlkOHVSL3QwN1ZaT3VFY1lCLzdJTXNFTU5H?=
 =?utf-8?B?YTBHTGF3UHJpUTA0UmFaZjVORjhZQmZVUy9BbDZzQi91cUJHOUIxL2xZZ1V6?=
 =?utf-8?B?b2ozRDJrK0NDVVljOWlDMEQyTnZIVWkxeXhhYkhrVDg1NTN4RjAyVWRqWXJR?=
 =?utf-8?B?Z3hXMHhBSHVpSko5Y0daV1BEYW95c1hYR1dqTWh0eGplWUNkQnJaZDFYTmVY?=
 =?utf-8?B?NEovUlJLTk1nUDdSYk1sSmtvdENNQi9Yc2ZBSHRwZTNvemdrVlZjWkx0WFlC?=
 =?utf-8?B?cVhhU3RKMmJ5NlpmeFhBbGM1OHZHMjZNWHFldlc5UFRlRDVzOWFGSzdlb0JE?=
 =?utf-8?B?Y0lwWHArd3paYUN3bmE3cWZnMStDRXBLNWtjeERqWVYzcHdaVzkyci8zWFFH?=
 =?utf-8?B?emJXaDRvOUxabmVocTVuTU4xWkZOc3pIWlhWR1BxVjhtTHdWeG5DS1czQ3VU?=
 =?utf-8?B?UHVsTjRQWEFUUnNUZE5VTUhVOUtrL3VhM2NiWVgyL1hDbzBkc2dCWm9Zblhj?=
 =?utf-8?B?MytPL0U0ZTRGZ090WlFJRCt2b3pPVC9SUjlzSTExc2RncWJlZVU4REVaZGJJ?=
 =?utf-8?B?TjBJenM1SVY4a2swZVdqRkNJREdGOXlPbXoxM2ZBMEhMcUxrcmxpdFJiOWlF?=
 =?utf-8?B?bUs1aC9CSWFodWkxQm9kSitVMVZWOUNmSFZwQ0ZnalpJQnFKS1JKY3lvaGZ0?=
 =?utf-8?B?SWk5b1o4WEFtcDFIYTIvRlBOdUhWSU5vdTZyK2FRbmVtUVhGS2tDTW5HM2tK?=
 =?utf-8?B?cmtHM1NmUnQ1WXpLU3g0cWF6S2Mzbkw1U2lZRzlSYm95S284L1pjdEtEVlFC?=
 =?utf-8?B?WjRwbHIycVNUNng2ak1WcnZGRW4yRHdtbEpYemhoVHlMOTczTmRuUlo5Tkh4?=
 =?utf-8?B?OGhmbGl5QUQxVnkwUXFLYm03d3pBeWQyUHQ3SWd1RTE5RXE2dVJqSHN1T1RB?=
 =?utf-8?B?dE1vYmN0bEFQblBGTDlSMlpHeDhvR0t1Ykd4Y3Z0Njl6eU5iMWF4dlRtNFp3?=
 =?utf-8?B?RVl0c2NoZ1VobVRFUUVUT2xFRVJjdXRENjl2a2IybUJCMkdXeVRWa1dFcXZu?=
 =?utf-8?B?NENQdlhYa3V5MjY2WERZR2lIMEVibnhreFlyc24wKzR3UnNxVEN5aXMwaE5R?=
 =?utf-8?B?QllGM0JtREViWFNsKys2cDFvSklTSnROdmRna1F4VkZaSnM0WTRTRmQ2UmR4?=
 =?utf-8?B?THR6NEFoN3JDZlhiMjdPRGQ0ejRkT29LZUxaV0xibHZva0kyamwvTjNPQ256?=
 =?utf-8?B?WWR4S3ZPdkFqYWw5eWZ2ZXBFT2oyWUduTlBhNHpnV0hDNldacHRsTncyVzRU?=
 =?utf-8?B?SzhPajUxaERFRWRCZzd6SDRLSWNXWTZjRTFoUUxNVW54bGtkeWIrYjZSWDIw?=
 =?utf-8?B?M2hubjVTVG9qdlRXQjZFdkNHbUdjdVpJd3BTZmEzMS90a0VsdHFkRTFQTjEz?=
 =?utf-8?B?eUVPeE1PMEN2TjNOWGJKajJYb2pWOHUxNXErdEhsWi8wQzREYjQ5WGJVZHBC?=
 =?utf-8?B?L0F1QXVIUFFLZmgzYklqVDJtQzJJOEZJQkYzc2tNRmJWSlowQngrUE1sMEtm?=
 =?utf-8?B?R3FFMEhIOGlJK0tPalJsVXJ1bDMvZnJGZmZyUWlteUJiY0tnd09tVzBUQUpm?=
 =?utf-8?B?NksreTN1QWJMUitmbGNEMWpzZXI2S0svNitmcUtpNnJYYVVRNldtVUZPaXJa?=
 =?utf-8?B?QVZUU2l1ZU1hOXpHS2NvNjczWVlISlhMcTFRazZRMFlHQklEaTVhM1k1M2Np?=
 =?utf-8?B?RzZ1WWNZMjI2NjE2VE85TUtXNVhiQ2lMS0RwbmFJUUJ3ZGFGV2prdngwUHAy?=
 =?utf-8?B?NGVGQ25XWTZhZHkxZU03MUFGbWxESk9GYXlkVlpEcExhdVRoTGNNWS9keS94?=
 =?utf-8?B?aFVua09XMG5STCtucTQ1MGtRRGZtSVVBQjBHVHN4ZVdISytXeUl0VUR6Yjd6?=
 =?utf-8?B?LzcwZExTMlZOeU5YNk1ncFZxTXVsSTFQZ1ZIYVVpSnQrK09IQ0p3d3ZXb0sz?=
 =?utf-8?B?R3FiMVJ1bmNiYlRrYmpya2RqSENFQkRacHAvQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:55.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c776a5d-73ec-4da4-411f-08dddbd74f92
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB10153

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v8:
- Set opts->num_sack_blocks=0 to avoid potential undefined value
---
 net/ipv4/tcp_output.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 44b46569f74e..c093248ce36c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,17 +985,20 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		} else {
+			opts->num_sack_blocks = 0;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


