Return-Path: <linux-kselftest+bounces-46814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E69C9848A
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F2964E19EA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BB334C24;
	Mon,  1 Dec 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PPQyyGvA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6430FC12;
	Mon,  1 Dec 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607109; cv=fail; b=UWVbjmvny+h/mGOaDwV83mAXAYngI8O0HQNpruIDqmpCpwiCOHDXLPSYEv13ZlM0VsOB9GzDKPn7Lj3ojYIKVAbV/q3evAf3nO76Evuzf9+JZN8TuO+5sagJ5etJkWAM3P5L2YMzy3/wahTf4jKDAzKYIJ55FV+beK/SSutVpqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607109; c=relaxed/simple;
	bh=Q49lg1ygR5li/7gImh7zFQzfI3h2ISG+4HsdDeihcTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usYh3fKKBA1YmJ0zLuXsklJLDDEFT12gbbfYKszHszI2CcqtB88J7eGaUia7cjZ2bENQL7tsoFolJxpimc5XG5ngigTCcrX9t8ZwSVn416p66RRkhxgv56esH6Q/CC5Afr6f6dikaleLme3Huz9w5sbf/e6yxEyoW16UxrrEda0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PPQyyGvA; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3FqPqKlyBWeTekUc3XUhmP1Gitgnqyo67t6MQLSvPWlHel1ml7yRKYn/JbjqQgcHwjvFkvyJICP7ikzFroNJJRnVmzCChcNELOCP45B00xnaWLH+F+ybadSsTzLCSkgLCQdeEB0TpDPDToQhFYWsWXZCJFdFNUUVPd+neeSsuHnku34Zjc8MgpLhCS1UDKbTCtQCF4Q6+wuijOHML1V7/S5l0gpfqawLgsoOPxrxiKo6ka6qQSKF6L4+Kcc9raR/ha9mnjbs6fvzukoEZEtMSXGbdlNaLZESwoTCoojxOySSb4dI/ugn0UMzc/aDMEfT0VoKlGGIBe4jIhhy7FepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=WZRujJHUToy+T6S2j8BWlOoHd8UIK9K9tMb4zsPqzoM9h4PvvpDLAFbIAqwA/DbLxzcPuXP3FH9aPdQtoKJYS0YmLQeg5nZ3Zf0Iz5sa7cYM2crJzS240o6q5sdOfVCr0mGu8aYAvBsolS5n43b6In+TJc4cBsfi7ddnRbfDQWFgWNhW/UE05vrB5HS0zwv0B0kdZHSpZIzhLzRxDQeIw4R02qevFsN8MhzEdAq/9qHLNuQxfKDL2oYLDY0huQHfg8ut0cdGiWAqH9ZFR1mNLCVxTq7tu1AMv1mhOlewOYRE+7FCC4UF3R9M6wDqxFATCL1cR1lg6aAWH3qzRJ1pBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=PPQyyGvAL8IRkZffsvdNU5UjW2aB/tu932Cz7VjLu0E80yZRGag2wKpsJch1qbS9yoLPfRpnvmzFWmh/m/Zsmy5NvMAf+yN8SqOtoOIFXkzrC2U5agiTMshyk8K5XLHP2CBodIOytnPCTUjOydDHC6UNXdv5quMwCO2ExGVlwRzG+v6C5oe21KpptifRmTiusaRPIBfk5x6KRVHVnCYj3+bffFwo0YRP9/BLCDahl7PRAgElo6VmIxUcz0WlWnUr2jqHOEhrwuNLtQUJQewS8c8uFY/xx2uV2hbY5Dk2NbkyeGYwGyB9Je/BlIwUgtPMJsq36R3DkU6PGcKXs/YoOg==
Received: from AS4P192CA0006.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::7)
 by VI1PR07MB9828.eurprd07.prod.outlook.com (2603:10a6:800:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:21 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::b) by AS4P192CA0006.outlook.office365.com
 (2603:10a6:20b:5da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 1 Dec 2025 16:38:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id BDA18680033;
	Mon,  1 Dec 2025 18:38:19 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v7 net-next 02/13] gro: flushing when CWR is set negatively affects AccECN
Date: Mon,  1 Dec 2025 17:37:49 +0100
Message-Id: <20251201163800.3965-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VI1PR07MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2548178b-c24b-4d24-367b-08de30f80a2b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K0dydENBemdxU0pFbGZiOGVQVlBWMGJ3YWUwRWJCWGxZODRQMy8xVmx3KzU1?=
 =?utf-8?B?SWVTWlZzeTFNWWZNMTNiN3Frbk1sTHRNSUxhWWx4UDJDdWczYnptY1A2ZGZN?=
 =?utf-8?B?S2dKVjZnMHVtN1A2MUpiZS9seGJPSlpOWDBXb1UyMGNCZ0MxaXdBY0xoTlhN?=
 =?utf-8?B?WFFHa0s4cC9qajBoR3FOWnNrYmEwelYyZDd5Q2FnMG5CVmhWbUFlZGJjb1BR?=
 =?utf-8?B?eE9zY1o0MUN1RCt2cTJaRWNSTkswNnZNd0svT3Q4N082ZW5KQVNWcy8rY09V?=
 =?utf-8?B?TkF1ajRFMTdMR1cxSDFITzZMYytyaVNxOGVuSjk4UE44aFBCODAyVFU2S003?=
 =?utf-8?B?TE9GQkRUMXBxR1dyUVlyL0M3dHBKRnVCckFxa29ROTVNdGVJcFJEM1BpaEhQ?=
 =?utf-8?B?VVluWlBFRk5ic0NZanZLK2ZaOEM1dlNJbzI3a2lTM1ZEVGdyaVBONEs1bHlk?=
 =?utf-8?B?bVJxTExtM1RoR3R4amlVWms5L1ZQNnEzN3B2RGZ5azFkUHBGbEdxRjI4a2xz?=
 =?utf-8?B?VnN2UHNsWWw5VWtLSnEwN1B1UGlac0dVZTRpcUNPeUwycWdNN0Y4UkplSy9Q?=
 =?utf-8?B?eVkyTmQ0cDllOWZQcEFZbS9zakd1ZWR2UVZYZ0VUb2JSQmlYZHkxTWdodWlE?=
 =?utf-8?B?OUsrc1ZGdmhRUHNrcnIyNjJMckNNZmtIRzBBRzhQc3ROVzUyNVhDcGpPWjYz?=
 =?utf-8?B?enFXUjdnazRBVC9SK1ROYTFBZUwraGprVUt1RGVVaGFwemo1UkI0MGgwekJx?=
 =?utf-8?B?elNDcEJDTlh4S3BaRXcxaERRK3FqZUtYS2hpOVBWRUJmNU5kMHpHVGUyTDlW?=
 =?utf-8?B?V3dDRXdCY0V5M3RWQjVMdnAzdjRLQUR6NzV6WGlSUCtTNy9GdG1idFhYWW9v?=
 =?utf-8?B?ekU2TnExejJMODJJa2g2NXNySmgzUFV4RVdpVGtFdVVPY01yRXZOaXBpdlQ3?=
 =?utf-8?B?R2Y5aWNuTlZGcTVTVTFpMzVjbk5BZVUyblVnQklqT2NncTVUSFBKVFQ2ZXpy?=
 =?utf-8?B?eFV0b3hLNGM1K2I3M2xxRDJhTXFMNUFXRUVNRlpWOXdZZ1RGZ09CSzZJUTgy?=
 =?utf-8?B?aDA5MjBLQ3k0QldFY0tnQ1RxaktTVDIvQ2NYdS82MWFTdTUreC8rYStiYTNp?=
 =?utf-8?B?YU5PbTJFUkdYMHNjR2lmU0ErRDZQSTJqRWVBR3ZaeWJWT0pmWG1Za2ovSTJl?=
 =?utf-8?B?cUtDL1FDZVk0UlpwUWZwLzd3M1RLY1o0R0gxMGRsRFhQQ3Z4NkRRV2hiS3pj?=
 =?utf-8?B?YVZlc21jeXdwMmd0TTl5cXBZSEx2bzMwZ29hV0tIeDR5MlUxRHgxZ1VRQTB4?=
 =?utf-8?B?YUVobTh3akZ2UjVHSnJYUVJmMXNTSVMwd2pBMVVXSTBBMXNkYVRjRm95cXRD?=
 =?utf-8?B?UWpvQUNSYU0xMmVEazJrakxmblliOXh5aWVwa0x4T0duMTVFUWtISmxrOVBj?=
 =?utf-8?B?S0ZERnpNRWQzVDNVcGJSUUpoUmlaMzVNNDdHSmFSTW03YUsraVlNbnJWU1U0?=
 =?utf-8?B?QzNnZ2V6c3Q4bElpL0V6L2o0Z1dWREwwMmhvVThzdUlEWDFWbno3VnZhT25s?=
 =?utf-8?B?NGx2TUFZSFpiY3VGSnFNVjdNbEVJb1prUGZsd3VUKzlXSVR0Vy9xWUo0Z0hM?=
 =?utf-8?B?cjJZUHRNSGp5clJpMHhWUGR3L2RRdnN0MXZheHY1N3ZlQ1dncmRDUktSOUI3?=
 =?utf-8?B?aVdzREVZUmRZbXNNdGE3MVZQTFN5aTMrRnZxNkF4dklEdzgrNzlaMDV0SWVX?=
 =?utf-8?B?a2ROTU1ycStQakUyc0Q0MHJEMkpLZi9nOXRWVTEzL1Y5RU4yWmxDZmdma0xa?=
 =?utf-8?B?RnFSbVgzVEppZkgvNzg4dnQwRTUrZ3Z5ODV1QUhWbUkyV2JMUnVqZitidHlk?=
 =?utf-8?B?VlYvNm1nemo2cU9zNEdNS2tTdW1OWDh3enpmZ3hSZ1JIcCt3b2cxeG1pYlRs?=
 =?utf-8?B?Unhwekk3aHM5amJMMFI5ZFR5Uk8rWHVVb0VCVUNKMEFraVRsRG9hbTVpSnB6?=
 =?utf-8?B?dUpFb1VxT0xXVENpU2tUU3hUSGJiTlltMG5sRExRamlvUU1zek00UDlycWtt?=
 =?utf-8?B?RnBoWEwvQ1ZYdTFtczhKc0dHYUsrdGxheTg0S1ptWFFCUUYwRlNFL3NLWnky?=
 =?utf-8?Q?x3jOc0+pvbaHe6hRmEZHqaWqL?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:21.3089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2548178b-c24b-4d24-367b-08de30f80a2b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9828

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


