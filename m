Return-Path: <linux-kselftest+bounces-42531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E994BA5B70
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3D54A79EC
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AC2D9EC4;
	Sat, 27 Sep 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="sxRhtGHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013022.outbound.protection.outlook.com [52.101.72.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C4E2D949C;
	Sat, 27 Sep 2025 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962915; cv=fail; b=AFOTnocgw+0xfvVcL/UBjrfVZeQM+Tm9RBVN/7VKGB6+iad5CdlGHKH+m1eYexzoqphgvYxFbOlZOWy7H/N3FnewEo8wdZ1vW81m5byg2gS5Vfoo0kV/0996WaCFjoB2otWfpbcD3B8Qd/zKdM7VIXvy3I2olsTy6Oc6K/ps6cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962915; c=relaxed/simple;
	bh=KTBsrRS6D/43oWkxJJXk7PDL01xGj6ILj/9SxXVFdBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWxVosI2WrcBGtN1s/CrnmMEQGjmIQ3W24cbyeb0udC2q3vR1TDFPp/VTwJHvY5jNe6L3z/PVoFM+siMDp9PZANp8IbVs6prU3Q2GWijAFClebkx9qUykq+BHMF83kPAF9JoXLVQanjS401YmCxXge8sYVvEKW1I9GOVvWCymGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=sxRhtGHH; arc=fail smtp.client-ip=52.101.72.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwGna1EaVXF7yFAYlA3NtvKCrqgmTCSJTda6AcSqIZ4gx6I22MyFdQbolxygY3aEvs4ND46j99sD/2J4yn0TQoUFDZMlUTaHhHeXeZVhW8E/MTdky39XtD2WltGDw6eeyXEegEWjhuDeVn7GPb0B7ocdo73f8ipf1IrhqX395h/7MQrNHDES6aYyL4mRkvymYWhv2ihDz8wM8AMmdkU3KTIsHY7eUtZ04J36l2+xjeCftUahVQawIFz6G5wLd7wqbXvB9r3uxekn7+y4zdQTDL/RQwz5u2iln3Y9Ky2AkhWv2YInY2/puqs2fdK7s5gP8VTjW0S5qRMXQuwxAzuTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsoIhmFoB+0bvj05Al5hGf7EtssXfY7zXNkjoPQM4JM=;
 b=XyAVehZ6SgU9vtkqogncbLtN6tdTvevMnFS7uhbBsRnkVyQzJ+f2Mf2kq9VNmRBx2qwsWuCcdpJbBHkBVkf6pDpeH5ZjIQV8accNKU7tDwKUer87ram9TWBn556At9zFj+syeVCZZKO16MuuGuq6lg6Clj4mKbP9TQe6H2VWm99LkYn3uhETftkF6hJV7GRtwXWgY6tuZdICCWg+rYawRHBlgeAK4a9OnVbNZSzWyLRzkz+qrDbANEexoCNb52LIoZix4HUGff80VsX3Tvs80YPkU21f8py1vPdUk9NqZMRBCgSlSkeY6HLGUZljw0C5/fRJt+TiwxKT500hOLNrbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsoIhmFoB+0bvj05Al5hGf7EtssXfY7zXNkjoPQM4JM=;
 b=sxRhtGHHHIv7ekkHbOoFHB6UzYpua4lDasJBH4vA7qxT9vBvHlXipW1fC+vOpvdhKdEoOd6NGrUqLvw/8FEKUy7sHes81rtw1iQd+GUvpuPZJ+w4eJLQnNOjLoXOb0k6dg20fxAutdsYXuOzJoFQw+B2VwaRsLZ6RLQP0Nf7CGxQgQ5ilb6q8e72QwwBifYZMg6MUvn0gHfMWJNix6ns2W5bBr9xg6lsUkPSqlKRp3x8nDqX2ZI4kfwK+mWiUJu8wtkcb+Je32p7Ble8pywLi5uXGzC2z4nV1nhezjGzi1w3bvzvqsKsUtkfAAbwXdlaQltxayZH4rv652GnCFVLdw==
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by DU0PR07MB10681.eurprd07.prod.outlook.com (2603:10a6:10:59e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Sat, 27 Sep
 2025 08:48:29 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9:cafe::d) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Sat,
 27 Sep 2025 08:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:29 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id D6FF0200B2;
	Sat, 27 Sep 2025 11:48:27 +0300 (EEST)
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
Subject: [PATCH v3 net-next 12/12] tcp: accecn: enable AccECN
Date: Sat, 27 Sep 2025 10:48:03 +0200
Message-Id: <20250927084803.17784-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B99:EE_|DU0PR07MB10681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1832cad9-cd92-4604-5b91-08ddfda2a19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BCO1TFOc7Cxvg1X7RSsXtlRV2y2Kjs0eDer2+nZAnTQRcBf4TsS/v6EJ9J91?=
 =?us-ascii?Q?qNMziYnENIUF+hC96JkSNWye1OkPYGWTThJl/Xx6bR0IyxX61CUQX/ouINxW?=
 =?us-ascii?Q?dNcAOc/AFj+HU0GyasJBKtI5pKdGWSExY68lYSEQxsTXh60G/39Rwsw4083B?=
 =?us-ascii?Q?ixv209fg7yoAysQ1fcKArBCODEP/VYgXockASYVdQnO2I7HMowHqXQhpYg/t?=
 =?us-ascii?Q?vD3q5nyfnCw6+wtlHFwgw4rZpC7BaFUbJur/gqgF3hxjpsOr4irtqYp7TMYb?=
 =?us-ascii?Q?IaCAlWcyqdEcnPDKSQ6Q6w/RzRanz0J/724buKgcdDF80U00vXOAO+FI5CBg?=
 =?us-ascii?Q?ECUDsq/7mOVFb4nPH4ZnAIvfOzV5w1H/6KivGi3nFsHdu6mtOb89m/MvYwo7?=
 =?us-ascii?Q?IMLM7mwbDz11NTdZEYq4bBz82s0gd6AbD0l2ykjX5j3l/UnCpBkTynHULAes?=
 =?us-ascii?Q?MgUvdhHEsLJz9Z6rSy4FEwuwAzIC4jZ+YQLfv0NtJXdNO9RRA46P7Csu933J?=
 =?us-ascii?Q?OTiZv8zdcsUY7P3IaqSWlSOBY2dyqePgOd/6l5OvazGHpX5eFEs7T2eDOfI/?=
 =?us-ascii?Q?r6dmLdmc7Lis42SfSzu0SQGXmpCpxhDBIc98QGRz/E92mU+xYVt5Gh/wwkVR?=
 =?us-ascii?Q?6CvdzoGOTB1C3O+qtlFiFrj5XcGFmJ7h6aRm3NcQ+XMN0/G+wnqQEZ6JEr/3?=
 =?us-ascii?Q?mgJwI55r60y8A2SNQId7ykOl7uu8rmvmrO47CnqPDtpvP5UovdGFs8GR0Ash?=
 =?us-ascii?Q?oxoZN7kVzEJsiZW8gjdqo+RtLVPDC0l8dG7ORfM1MVLYjXHUlwrKszvIibds?=
 =?us-ascii?Q?Jxi+EBD8L6pgDsN5YFfXOU9qD+VslyONh+k6f/p439GBkLDq3VAAi+w0mtX7?=
 =?us-ascii?Q?UjkfeJ/za8FAf6q1vS968vGXPyz9G2RavY7AxAlpyfptU7QDt7gv9jGFIDOx?=
 =?us-ascii?Q?K70VPrSdBITP4lVb86eBkV+MBwfMkx/t9UqobeMl6QwOTKxYONerllYkggkW?=
 =?us-ascii?Q?03cuiA/GqHOY6SK1PrPE90dB/qcySPutJGN1yE1xDVQGNnVI12ONQTUseinY?=
 =?us-ascii?Q?5Erc96OEYBdl/vRiIPRJpnCo9n6uCePXLcf4B5iegyny6m7+Ih8VMj5hdpZ7?=
 =?us-ascii?Q?t96cAIL6esRuhYvIPyWqrRJnzXsA6y5xzrsnkPW49jb4q76lDvadHRwMlFoj?=
 =?us-ascii?Q?H6C8/CIOkyyO5oqnPXzrT0WiQEj281owXjiKCativPEyA44fkq/dnstslmv8?=
 =?us-ascii?Q?rrvD1VTyRvUPpT+IhDnHCkCCEW6A4ARpQPf1IxwjAseFkMLyKPYB+EKPqbuW?=
 =?us-ascii?Q?qHyoktePSxHy/9feSsutUXO7WdQZB7D+d53Zs2FVHlhBoLD/FE+O5p1jiF6h?=
 =?us-ascii?Q?mDlvK/PgdSprqJf0CWsauEbl+hcnHyccNl2iZBXR4v0lsTibi8a/73Wn548A?=
 =?us-ascii?Q?xcvSooR99G+u6oNzRq8zjOwsUU5v5RIqmF4H32wuyfwh6A0VUEgr9PtC2JDV?=
 =?us-ascii?Q?OUHG2dwdXjcb9RezLwNopDQncAoFHQbB1V9yKfHHQ7BRH5tQ2hxfP93GLWB2?=
 =?us-ascii?Q?Oyx5CSHybj6bJK1FPHZ2aMsFPgQnCMeObHBxe/0C?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:29.3788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1832cad9-cd92-4604-5b91-08ddfda2a19f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10681

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 24dbc603cc44..169a393374b3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
-- 
2.34.1


