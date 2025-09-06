Return-Path: <linux-kselftest+bounces-40887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A991FB47461
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D813BBC66
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4005C2F6591;
	Sat,  6 Sep 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WlXL4Cd8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822C2F28E0;
	Sat,  6 Sep 2025 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176161; cv=fail; b=YSJ8s2edj3ijap8GxaeZ3KuO6oZd8w1Ppy//ZybYDTMdZOhUebNpdrDhd2VAd2to7DBLwtu8zYaoFvFzcQUR+ns6olwCF80zW2kPybp8fJpOxcgqUdUV52vKhrCxXxoTp/geScV63+L6wjzBD/DrKv9P054Nj7I2KMR5WGqIRds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176161; c=relaxed/simple;
	bh=C/dhWSWt+O3PZtD/17zVGFH5w/aYQMeOKKd7dgXZz4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LC4r7n+ehovl8/NmbmW6w7GyEEd2cbLp64WN2s8fWIIimc6aX40HdgHyEaPqWLS+0i/kT6OkygBGoiP9P6+RzW0PoMW7RR61I+oKMdBX6xr2T247XvMTOZZR4EXK+pjEQkv2RzYX7lgxkulg7t/h+yBdYtT7Y19NvZDxoK3TU3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WlXL4Cd8; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2L9rwasL5HXr3QGYm6aAaafpEKhdBsLReSSZNgWfvNCm6Lq/5zhS39Hu+qhrgp/xhuAjeexW/nycMaSmm4FvuB7bO37eYXzS8olWyv5kZnRZKAE6qp0l7KzNftek75AnxhzB71hnC1MR6ffXBNAtgQfhYIDizeKWXKfll0hN7hXkqYgWZ8GbNdUlftAl+mgiDS0TJkjwZvH0TdxEPFliTtxfvM3OVxkXpu1QrxGyd9HQggc12QKel3LR48dDqK/uiO0kxa+hjYUAzXehvq+8Ez8f1CZhzsmWrdxr853NLCsGq4NlwyVlaOyjnKuYO4NebqduE555xDN5Fxwz6IvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=tD8IYgGXhxA8pfxtiOr3ODkgJekyk8PmhvM0Zcj40ej4h5QOD8kn7PguCidYBxVEQ4m9DL8r59oR2LVvEXW6RWwi38RWqm0G3tox5Qogpl+++iGSxCibUzTKMXkr2+GWy2eonkXVEEj748SJ1qjlYfoIbHK/cGrpGpkNyu+E4/NQj4tuVe61teAWnglS6Cj6pfX+/1cmLYzDP5EykBGzVUvKtee08Q+fVyqrN5Bf0JFA9GJ7kf1DdM20BXyq2kBJjccsO/WfyphmdJxvXXmcG83vt8Qb1kLG7Ai43ukmp8xmN/sQEISTVH+IkC+iZ3lLzUvYmVcXdkalTYY8pDvHTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta9CTQXzfsJln+e8CsRqChrLbcfgUPSfklUNiwzkFSU=;
 b=WlXL4Cd87ojqqfrBHUU5s3lG48ctX6V3Xx0JVrdzuRLRnsR1aCExC/yxCh6ShnEeOUbyg7KYo/4udpKjjRov6AOmmWNztIG4murCrXoaZE83iX+5g4VPMkfIE5Ek6yysPicbfL5ZFQjeoEUkR3KshiU9jRGMmzZV7sV/v61klyqlaq2sNpEfmdAA+9/mMrKxIldDA6m6Z2wAnFe4u6gVR4ymSSDCYzKOKOWY9k7yoTlNLIqfWoxG6pF5j/THHtWXk7Dvw3E1Y7EvwH2/EEuUZt+Dz2SymEPpR8Ly3MdlOJcrRC8Ypa1Jmc4SEhRIZC8oPVOPHXgIGqCbQxRonhui0g==
Received: from AM0PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:208::32) by
 DU0PR07MB9038.eurprd07.prod.outlook.com (2603:10a6:10:40a::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.18; Sat, 6 Sep 2025 16:29:11 +0000
Received: from AMS1EPF00000042.eurprd04.prod.outlook.com
 (2603:10a6:208:0:cafe::7d) by AM0PR03CA0055.outlook.office365.com
 (2603:10a6:208::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000042.mail.protection.outlook.com (10.167.16.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:29:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9176E1C0031;
	Sat,  6 Sep 2025 19:29:09 +0300 (EEST)
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
Subject: [PATCH v16 net-next 09/14] tcp: sack option handling improvements
Date: Sat,  6 Sep 2025 18:28:45 +0200
Message-Id: <20250906162850.73598-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000042:EE_|DU0PR07MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd4b8b0-98c1-445d-500a-08dded6282ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE1mY2VZaytrSlp0U0NSeU9RUnNIMnVxQXVqaEtLZTk3N205L1B6WHc2aEpT?=
 =?utf-8?B?TlBXdXIzY2t2Qmp2WUsyekhvQkw0U2hoU1ArQVdQanBadEl0RXVKTEhLdW9H?=
 =?utf-8?B?SGNkS3ZjMXRJWStUOUhRME5JUmNwS1NrdjlWcm1ORGQxZGQ1YjUvSWtCbytr?=
 =?utf-8?B?dStMQ1U1OERxUm1Eem9xRmx2eDdnTStXMFQ3Y0U2T25BV2c3SHBIMjdtbnh0?=
 =?utf-8?B?Y3ZhTndQQWxIbXVHaVAzL21DQUNHeTQ2bGtCZHh1N0V4NFd0dmtBelBCZ1Yw?=
 =?utf-8?B?TkdoZEkyNXlJL01jL1NlYW1aSGVOc3AzdzJaaFV5YllHT1ZjdVBOQm1wM09x?=
 =?utf-8?B?MnlPU1Q4NWpYZjZmUWxRK3NncTU5MTEvaG9yTEl4TmxURENuNndsN3U4ODNs?=
 =?utf-8?B?K2xZTzNJODY4WjlEVnpId3dlWXgxMnI1emdPcjFGQm9ZSkZUZlJnNVdnNVJX?=
 =?utf-8?B?Zk1mcVpXd1dqWWYxek50cWtDNkNwcUdaYW1aaE5URnBlanRjUW41Y0xScHlW?=
 =?utf-8?B?bUJLWXpVU0hlc1gvMlo0cVp1NmQ3emZQZ1M3UW1UMWxnRldJRW9wTStQbGVT?=
 =?utf-8?B?WWR1TlZ6VHJGQXNaM0F0dFpYQ3BUK1d3WHZXNzNmVHdzWEZ1ZllHeUtsNmJQ?=
 =?utf-8?B?NFFhanRWeUt6NCs4bUltNFgwVXZKSFQrSzdRcFAvT1loK0hlU1RNOHAwNThh?=
 =?utf-8?B?MDNnblFlMGNPZ3NEVkRUdndaM0llYW0wNmRYN1lRT1RBaS9FMGo5RDQzTGdk?=
 =?utf-8?B?SHk1RlhxNFcva0E3dFdmS0tjS0V4UWpBdmNWN1dHN1RNTU8wQzZEWi9tVU1N?=
 =?utf-8?B?cCt1MStLc0V2SmZ5eHQySGs1YXo2bUdhOGVJVStBbFhjWDlvNEJ2N1FlU2xv?=
 =?utf-8?B?eTZIc2VIK0FCK0w5VENKd2x5NHhFZHNnY0ZZSU9oTUw1SGlXME01SVZ5VC9R?=
 =?utf-8?B?SzBmVHVtZHk1MnFzNDdmVTB3Wm9HT0RzT285U1gzUC9FZTFaekNOdndVSUNy?=
 =?utf-8?B?MWc3Q0tVNit4YkJTbGM1QjFicFI3VXpkNlc5MUhseVVKNHVYUFAwTzZFWkJO?=
 =?utf-8?B?bXE5Y1dLd2gveUJNNCtQdStodDV6YWEzcjRDa05Bam1KbHEvdnBaMHBmVmVM?=
 =?utf-8?B?bE1DVUpHTGkvZWMydk1aa0VJckd2amdIY1BwSlJWMHVlVXY3dmpjYUVYblNh?=
 =?utf-8?B?aDNibXVtc2kxb01EZThHcHFOMVNsbzF3WDFUcjhta0syV1hjZE9WSTFnYlJO?=
 =?utf-8?B?SG1lTFlmVG1nZ1hMUldSL0UycXpXZmc5dm8xQUhkQVlqR3lEN2FYR1IrNVpG?=
 =?utf-8?B?Wmp1M3ZQNEorSEJZeEMyZWJFWVR1dzl3OVp4OUc5REE4OThtd01uRGVOVXRy?=
 =?utf-8?B?VkFJZGNtYjVnNlZ0NG1VR05aL2VwNWRiblI3NkhpMXFueE9QaWNzMlZBdjJP?=
 =?utf-8?B?U1kwdGFaeisvbU55SEc5RWdKVU0rRDFxQXZrUzF3MXBTQ0swMHN2cnNWc1h5?=
 =?utf-8?B?M0wwb21Ec2VDWVA1QXl2N0FKYU11bTVKSnlDRDVtVU41SjNWYTQwYWg5SVly?=
 =?utf-8?B?dzBFVGhjM0g5cmNGdC85QTZTUis3UUFVSFpwYWY2RVRTdWFqRGdvQmtIYVBB?=
 =?utf-8?B?QzRrcGlXcDI5ak5XUHVMWnZVWkdBUnpoc2trdzNHbWZFYlZMeDhWY3VNYTZz?=
 =?utf-8?B?UitDem1HU3hyamxNdWw1NkpubG1CUzZraVVEZHNKSlNlem4xTzVBTFdaUjYv?=
 =?utf-8?B?UzR2c0FrVXpBOWhNSEt6TStkM2xDa01nRjdmUERJRW03ajFWVlhJOW4wRnhW?=
 =?utf-8?B?VFQ2cUZiSi9kUFFtRS9nY3FRc1JIalJJTlo0cFQvK1Q0YmhRN1g0emZkRGdX?=
 =?utf-8?B?M0wyK3kxck1qTmF0RXdZL0JldHErL3ByUDU3dTN0T21XMlpHNlo5MTFJU2RW?=
 =?utf-8?B?SEhkbVBvZmNOa1FKY2EybHVnWVVTTTlxc1hobjhpNmw1dGNRWEZzQnRsTTg5?=
 =?utf-8?B?RUw2cXY1b0JLc2Q1NzZzRUZabXlNUEg1ckxlcVQrbGVYVEJuNkhLVW85eFBV?=
 =?utf-8?B?YjJwenVsTUNqVXVjVkI4RWdhK1hNSSsrNkZ4dz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:11.0856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd4b8b0-98c1-445d-500a-08dded6282ae
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000042.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9038

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
index deb9b085a8a2..5be2b3eb73d3 100644
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


