Return-Path: <linux-kselftest+bounces-36373-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51FAF6969
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2EC4A6143
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC5028DF01;
	Thu,  3 Jul 2025 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PmVbVfvO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF62AE99;
	Thu,  3 Jul 2025 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519915; cv=fail; b=Bl/AQr+TzCcw8Uq9VlGdWuG4IWlbSCnZWZBJkrsCQdz4QCtXCJhWHjgRKv9FMeb/I2df++xyMifCjJJzS/pLPoz4+tUb0UIpSGFESNyoSgXWPx3T9Dvt1R2YF2Wd9auEF27D7+J4wuPm9JvRuNwD+ENHm2BZB50ahM+3KPLeP4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519915; c=relaxed/simple;
	bh=QheIjnkZhAAj/gUXxo2UK5OQhY+fZUG8lLWtSanvv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4U9u+1KWegdHoQUfbpX1x8k07p3HRHbd2VfzC+89K07ojqv2cy78NUVyMP9/LhqjJ4t94GX6vESKQKvivN3fFZirUKJRBnqd1ZwVeXZqc9clyMpTAsXIBj74GV+NZz13oOO/jg4YGKimS1AumM1jU1H7jIDDVtHF0vjCMEuPW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PmVbVfvO; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRocuSOggi8jUkEpJ4iQtNOIlwZeRDf8/Hj9HGj3Cji4Cw4d5vUNhpnlkZLS4MU6SBtx8yvFaqcUwFBWF2nPpikk7Fuaq/07bwGH192T3nUJ2OdZ2Km8OY+ogIeyJCvCrBcZ+xNJxjtR6TyEAF3fR17+Zsq9VsGwG7HSAK/PGNaR9trm8j5ghQPlf0XXOFbwW5B26ZJ2fJhlpq99z/BEQmA4MBjup1kxDdrxYO0pRL6R+GNnq38CbOSyXOXjlABzQR0mJzzRKh3wrcy42/iG47ZfNhnLg1+QxJH+rnVbeMbC1cdIB6oeuAp+j4OWULDStPS6ii0JCnDASsMf74A1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=X66f2FUQKUgyVeZzJ1dGTU3Q7b286LtxZL+KI93whk1djAKYMzUkAYWrQ09uutCIXSid0Jvi2e5nB99oapKJOHsb8SmH4Ql1B7M1sWw2xvMylKD80ekoFevKForOhmci+3BdIjiK/ph8SArdWkA7j5/YXq4RM3g+nE0xzmV3tVXWdZ0Qmp+cs8toAE9clesjO9mpajDfd1IKZ6aAHvkygO0wBcwnVo+y1DVHiepMkHiNqvUmfoVoN9LEqw6LjLGWdAoMBae8P8vWhEIctsyrFvjIzoWwNVeY7x3cGhlnz4tXVBQKt/5IG0gT5SUu5Rris2/9RYStQJs6fBqusin+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=PmVbVfvOEEe1lZQjX7ry/qeht+E6emgkTRi7vfMS03V7TX+0NyxX9RpP9u5bAv6MxUP+uXabxreXG2WF09f/NEGimyEf2/W/AAZhRFYkhXakkYBcxugm9en2hz8oFWl89jzFYzVpwf7vZRoY83WfrbWu6KcHjr0OsPeXOBUQXc/Y1MTQWzuazu8ctBSG0azB3HwwFvcOHZamVl/hP27obnLQTeNy9aazRlFBS2CnoiQfo0+TLqDfNBsbBRbTtbVqTsNTXtCw2Jioocw+gklM+8a38kYZ/2OEI6xCBEpuzyDJDe/GZZFnZUAl+LWIkD276OXgtSEY9XtCq4T1VETszw==
Received: from DB9PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:10:1db::30)
 by DBAPR07MB6872.eurprd07.prod.outlook.com (2603:10a6:10:17c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 05:18:30 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::f4) by DB9PR06CA0025.outlook.office365.com
 (2603:10a6:10:1db::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Thu,
 3 Jul 2025 05:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Thu, 3 Jul 2025 05:18:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 033A6200DF;
	Thu,  3 Jul 2025 08:18:28 +0300 (EEST)
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
Subject: [PATCH v11 net-next 01/15] tcp: reorganize SYN ECN code
Date: Thu,  3 Jul 2025 07:17:14 +0200
Message-Id: <20250703051728.37431-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|DBAPR07MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 935cbd3d-4af8-4c84-0d76-08ddb9f10c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdEa2ZHL3J4N1d3bXZLbFJIdU9oTnVUVjNHU1ZqZ2pDR3p4dGhieENlVlQy?=
 =?utf-8?B?YSs0Z0JXbWJpTG9pQmJNTTI1a1FOcWRvRVFWOU96ZUZRTFc3TEF4YnN5dG1h?=
 =?utf-8?B?Y3FnTDV0TVdJdnVxWjRzZklRN3dFM3RET3hVczhJaDZuVjVzZHBDcnArNVRi?=
 =?utf-8?B?clVhb0IxRzJvUXFMdnoxUVpabzdQVDdqVU5SeVdWMHh5dWxtMEU3cTcwRmdF?=
 =?utf-8?B?Wll0WFloQldmM2JEdlBjMUdsWTRreklyam5mMzR6VFdYS1k4d3RVNk1zbVhl?=
 =?utf-8?B?WTY3OFZsUlE5elF4dThGVWZyWUJXWGRDL3l1K2hDcGFMa2t2c2Vhbm4wa25r?=
 =?utf-8?B?N25LMWVCZGpmd0plaWpMN1FER2liczc3eFhKdUNxVExsNmYzMUkyU0M4d2Zy?=
 =?utf-8?B?eXltMUROMnBBLzFnN1VwRWVVTFZqak15M0hIVUZteVVrTVZSRmR0NGJHeGlF?=
 =?utf-8?B?R1c2ZzNqUmpWdHJ4YW91SUVCbFQ5VndaSEh1Q1BmL3BtQjNYT2tLbS9KUTB6?=
 =?utf-8?B?blFEOThVQjlhT1lpdGZjQ21BMTZxS2w3T0ZWQ1NPYUc4aDR6cGpVZDFGSFdL?=
 =?utf-8?B?Y0xWVytiTlhDc2JlU3VqbFdzbVRYS05mS1NJd3pzTnZmU3lEQVZuY0lSYjFZ?=
 =?utf-8?B?eS9jL29RUmxPZklNZGZMYS9iQm1hOUFhTnYxVG13bjRYZFkxMm5CSDVDbUhH?=
 =?utf-8?B?U2VRNEtVb25XNkFKZWx5QmRlMDM3U21ERlRPTkQ3Wm9zZ2lGQXEvTzNIcTdz?=
 =?utf-8?B?ZHNzN2ZlekMrbWdYR2pmRDAzN2ZlZ1FBc3JMRjlGTDQ0aS9GU3BMWitBWlZX?=
 =?utf-8?B?TkZtMnhVQmVuc2FMWnM3TUI3QnZZUkN4aEtVUlgzOVZIRldGQVN1OEJyWjBR?=
 =?utf-8?B?bXdmbFpTUHVRYzZUbnJPVGo4YTFRSkl3NitYVFFsNzdPaFlKKytGeVFFdGg2?=
 =?utf-8?B?UGxOcVpOY3FFaVlTb2t6dmJmc2Q4c2cvd1ovN1FmOUc5VWpsTmpQMnU4K0s5?=
 =?utf-8?B?c00rcTV4cnJqaEs2QjNLb0pyVDlQOXRvenBvdjEzSHRZcUdWZkNSQ2ZGUE1h?=
 =?utf-8?B?V3JTU3ArWkdPUVhpT0hjTUNxNTYxQXZ3aUI2aU52NTJpbWlxemkvcUEwK3lu?=
 =?utf-8?B?OVVMbmlUbmRWMytqT0lOWTB1R08rU28xSTN3aml3Si9iSW0va1p5ZzlDS1Ji?=
 =?utf-8?B?L0ovNXY2YUxOOTJOQWJzMWErdG9YZUExVi9OaFgyVFpGZDBPVDZ5Rmp0MGpV?=
 =?utf-8?B?VWlMamVwamM0VFFwYmRCRFFxSlUxWGV5ZzRLOW9tOEpXdkJXUDRFTW13MkFZ?=
 =?utf-8?B?d3F5ZWQ1Rkh2OEcwZnNVY0ptWEdtRFZDQWY3K1BiamUxTmdXTGZ1c2xXbUxi?=
 =?utf-8?B?MVRlVGs1MjgvVWpaV1lFWGFLNkJ0TkNQUDhQc1M5Zmd6TVhiVXFuMk0yUlp6?=
 =?utf-8?B?S0FaNlM3R0FCYW95ZGFPblJab0E0R0ZrekduYlpBV0ZsWDNQUHJvSGRKbmNz?=
 =?utf-8?B?Q0FOVW0vMjdSNDYzRXRsTllha2hrTTVyTk55cFhRR0lRUjZDblI3bXVQL2h0?=
 =?utf-8?B?Wm1KVGcvZjZsSCtlVGVtZWRJU3hyb3NFaXZWNUVhb2Z0TjJVME4xTjVURFls?=
 =?utf-8?B?NEdaZ1JnRHFQeFVWY1FJYWhwQktYdVV0S1dSREg4ZXhES0g3dTlad09Qak9C?=
 =?utf-8?B?Sks4akR1VVN2RTQ3RWEwK0FvYm9aREFEWkhFbHhTTUVvNzZ6QlNVS2FmRlBG?=
 =?utf-8?B?TzVPQTMrY3BSZUxZZG90RFMzZHFtS1pPT2RtbUlrUGh0eDhkY213OFdnS0Fl?=
 =?utf-8?B?S1NJVjlCeDdDK2lwaFFmbGR0Qm9hVXY4UXd4RUJjbHNYY2hVcFFqMEd3a2J3?=
 =?utf-8?B?YmxsM3BrM1J3anBvUWhCMTY0M1NQOUM0eEc5LytiUEIvOFYzbGkzYWRQT2l3?=
 =?utf-8?B?QlhmU3Z6U0ZHZlZOYURWaFJEUDQwamhGQ2JaNkx1WWl2TGNhb3ZRSXVSYU5p?=
 =?utf-8?B?TTlKV1ltSkxLNitwRTJzZHZ5alV6SkpmelRKUzhnSE5uVHVHU3JDMDZCVEdt?=
 =?utf-8?B?ZVN5eWpwanVsZWczTnUzaFZnMHFhSU1NZUZSdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:30.4950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935cbd3d-4af8-4c84-0d76-08ddb9f10c94
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6872

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b616776e3354..caa980c3f25a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


