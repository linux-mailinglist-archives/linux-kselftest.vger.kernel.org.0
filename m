Return-Path: <linux-kselftest+bounces-42395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB80BA0E81
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698E41C25026
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB73148AA;
	Thu, 25 Sep 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UsHi31nf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1083128C8;
	Thu, 25 Sep 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821663; cv=fail; b=kaldUDYWrd158pnZKzaa+ZNWV12kh/sc9QmB8NhfFP/OA+5I6cIUQumXz+fnJBf3F+6N2UvjK+e/qE02AYdsmLL4CBIwNBmQ5lPlJEaemqd380V/6pBf4D/cms+9QrJ9ZIzMvS5sEq1eSvvBaaWM3v/mayV9Wp+GrvRygLGJGfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821663; c=relaxed/simple;
	bh=oPxnMnYPOm3fPnVb1aU5xmyBpd0TV9/jJ5wEbPZceKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6EZo2aq47TkT8X3D8zSnHa3zWp/e4q06qpLlgmzWK7lOWLBESA8KQEYmd9/N0Y2NLRj3xXo2tzmpPMgmsVtHFlBJNNvZIjiNd/aGja4z4hcezi9r41THLCBi9cOnSHNQbLjneFA4IkoN4ZYj5iXtZuqDZquO5BEnlGxV/czfhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UsHi31nf; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl4LGhnj/yvUNqS6ye2outmUbewjLrQSu5YjuwwL5TcG9N+yndd/afaYhPdns6Rn46cWEdTKVHPBsBhBZRiU2BGafT0dyrBIBJAh+79CnoRUqSRg4AudK86nbqoQNeFCAfqyowOQp2PVo8alGc2F86fdq3rdsNEhKY/+FyfhBsjnqAMu8V1TiZBL0oj1n+yHwIHoPviybuJTRHwxHVB3lJ1BVssluisB8dYE9XhphqHhEiBtVLcXrAyFG56u33LsDHZyC2PVlCn8ZEt6WrtuQwu1jyok+rlN9O2nTnoPqF+Aptm/PhsXN44h5FommdlNt/K/aoHv+c1mJEKw/17TDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S+a+w0kA1D25ldL2AIPu+TMlHuvF8H2qRdJbovX1bw=;
 b=rcL1KtFJKrjBeB6cvyUJlfdrbXNItK22p6booWilD7xIJuspQmVewobeQ1taskKC65k+561THCMu9HFWQu4Ve2qk8nAXU5gezx3AgYfpkFRrzJQJjVW4nQTyrLDv/oWNqIR9FRcxuolkhVSGoLFZzbExlqoEzT+Xhcpjbf3e5a0kaR42cxpKjxm9L8M/zXHYX+xHf6Mfcv7h2aw7IAO4FiJUsMh9Ogyy6p7SOPFFFC56SvnbjakZB7nsCwGJLym6viTk7q6Z/uPRhPjfBwOGIQjny9AhapP+DjLJUNUvdMbZfg4l+JazawyV5Uta3VvJwskHd/bho6VX04sGp0yaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S+a+w0kA1D25ldL2AIPu+TMlHuvF8H2qRdJbovX1bw=;
 b=UsHi31nfH14Nlp+dOD2XHWa3AvAG7db4kEx8ye+o8rGme5KaonL6LNwsvBwpGoBiWtGsNUr7TyN0rkPwchmz/KjscTTZPsZSauZbtdpS5PCo0Wr0ZOniRLgR75boGgj6MnA8ICGvrhvOGI+xPquJbTMOgvD0Now931fCjh+kVsRlE46q0O6/3Syq85xbUo7yuH/PmEPPlLoVxNgEsD5h5hcB5jcmTo3Fsc+p/SszW6TMQJRZQSQZH2XSbp971nzkY/YSeVtvLHnLvecqX1UuwEIncwsAmIidLQ+4QbnDeOVF0cL9qsoOKdMqslSAiZepF1tEQzXnTn8BdAS2vfGFFA==
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 17:34:18 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::5) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 17:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 25 Sep
 2025 10:34:03 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/13] selftests: net: lib: Rename ip_route_add() to adf_*
Date: Thu, 25 Sep 2025 19:31:50 +0200
Message-ID: <403143183373419e4a31df4665d6bfaa273eb761.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a6cf51-c4d2-4cc2-4739-08ddfc59c138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NSNywPaN0iTXLMvp1gaXd2yARQ3y+ECaDG51qh+spAj1vTk7GEseXpdoj5R0?=
 =?us-ascii?Q?F+rQXLGj74dJ0rLd1EV005EYa5i2vSPseLtBc8ZDIa80qyegBy6POTM1bMi2?=
 =?us-ascii?Q?vc8x/eWiiewnoD5Qhmvy5Bxllx0EKZlUIGTFvJK4mJNex+u2VOdIUXkekAsH?=
 =?us-ascii?Q?pBoCmbH8w106CAAM94dzcmj3IzVr+4wnMJDzYUTdkCvytmHM/G72OWsphEEc?=
 =?us-ascii?Q?qKnK6wi+nytPCBaftjdfzRCHlMc3kYpJSLk/IBOGuQV3Ena2ojY3g/+m1sxG?=
 =?us-ascii?Q?C0trApP+Knugw4rVvwDENGcvqoDgGQ0xU+D1IlSqAeOiP0bfCJfaQenyyKto?=
 =?us-ascii?Q?w6A/w4J7Wj28BlZWZbnRfRJ5Ray6HGUbba1aDiAR0wWhwUaPhhCLtV+AlJlP?=
 =?us-ascii?Q?HS3FR8RKy7EBJOuvnpZ3IVhUMMkyhzDHdjOzdsiAyP/I7c+1vXQCxNiYerrV?=
 =?us-ascii?Q?OBviXYuGNOlgAWdeRi6+MoKcCzjq3gykcLK1lSClmFpQ8/BbhBo4pDft+J3C?=
 =?us-ascii?Q?tU2ZPOQ3FsQFh4jz4QPhXnlUIQtYj4id8wbue0zPza9EoINbOOAlGh37UHQf?=
 =?us-ascii?Q?kFsDsuRYBeY1AIfXijN6/Bxk0dq9+QMeJFwlXuYh13mL24gq+y6wyuY1VPLs?=
 =?us-ascii?Q?J6/dlgooZqtyc/9ePpKhvZGBWosVD8Z60re7O1qjwZsVgONNRktro2R1g45F?=
 =?us-ascii?Q?TDG8AtikLkRjH5sLYyicqpB+Ihrjjx0aT2LVNiczx71zJQ/xTuHoFzT/QtEb?=
 =?us-ascii?Q?pVKi+hf7pBzuzAORuOgTu1YrtgB1HpLd/sEG+jgJ2KbqRaK6S4P+nFQvUkyB?=
 =?us-ascii?Q?osbQPy3We4tPcIKZlaHhZUSEE7y0mk6uMGvOs+YWp/s5Li/6XJbclTG+mPPw?=
 =?us-ascii?Q?qt13mvvwy9rsLMgiIPj/wmH33qR7rjPIGQc9OYmEQ3Fnx2T/S1Hq3W9ETU11?=
 =?us-ascii?Q?+hqVD+rFQxV5Vp9XrDgqVM/IM3wHr3ajXWGklGveZSLmyG9/+Ju/PX0/WE4G?=
 =?us-ascii?Q?NMSdqBCkyI/v1uF9ZnXZbYSfRqRwbzBD+YyOZ6K91iwVmvMidaF+wcK/xZ0m?=
 =?us-ascii?Q?UhJiy8ANXfUC89+XFdcsQSUkvlWa5EvlRr1dQ3gUysqA4almuFHvoYI5rDDR?=
 =?us-ascii?Q?G/jVf49KuHNuarkBM9cgw45+n9dbnoNbswYDuacH+3mr/6ISOizNURCBhP+j?=
 =?us-ascii?Q?564+2Qp1NT4PcBj5m45bYWGb5sEJY+8BYSaDfqLMBegQPpJKC19UA/S9ZzRU?=
 =?us-ascii?Q?mNcBVENo0iOCfBM5Fv7AYeJDFtiBEBQW6E2GemxbeRE35utzPm90LC2m20G+?=
 =?us-ascii?Q?doxYKlQABXAlXfCt0H2JupUymEa9wVqKGw8YkzrPr4b7ET9Pvnt52+sGA+gw?=
 =?us-ascii?Q?gBLl0Ey4DumoYj+FBEHycdKskxsXc1QUgYiDEpmUMTMf/kISXJEShd7fuuvs?=
 =?us-ascii?Q?KmT00Jsf044G54ZlhIzvhCK0uhLGWoNwsEMXRvx2vei/k1ogHWZClmCfpQXu?=
 =?us-ascii?Q?ffcNrVRPDQRPC3c8hoUpkOsrxeUXdlGiAOl8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:17.8844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a6cf51-c4d2-4cc2-4739-08ddfc59c138
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/bridge_fdb_local_vlan_0.sh   | 8 ++++----
 tools/testing/selftests/net/forwarding/vxlan_reserved.sh  | 2 +-
 tools/testing/selftests/net/lib.sh                        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 868f2fa5f9d2..b8fd85a20b78 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -47,8 +47,8 @@ host_create()
 	simple_if_init "$h" "$ipv4" "$ipv6"
 	defer simple_if_fini "$h" "$ipv4" "$ipv6"
 
-	ip_route_add vrf "v$h" 192.0.2.16/28 nexthop via 192.0.2.3
-	ip_route_add vrf "v$h" 2001:db8:2::/64 nexthop via 2001:db8:1::3
+	adf_ip_route_add vrf "v$h" 192.0.2.16/28 nexthop via 192.0.2.3
+	adf_ip_route_add vrf "v$h" 2001:db8:2::/64 nexthop via 2001:db8:1::3
 }
 
 h3_create()
@@ -56,8 +56,8 @@ h3_create()
 	simple_if_init "$h3" 192.0.2.18/28 2001:db8:2::2/64
 	defer simple_if_fini "$h3" 192.0.2.18/28 2001:db8:2::2/64
 
-	ip_route_add vrf "v$h3" 192.0.2.0/28 nexthop via 192.0.2.17
-	ip_route_add vrf "v$h3" 2001:db8:1::/64 nexthop via 2001:db8:2::1
+	adf_ip_route_add vrf "v$h3" 192.0.2.0/28 nexthop via 192.0.2.17
+	adf_ip_route_add vrf "v$h3" 2001:db8:1::/64 nexthop via 2001:db8:2::1
 
 	tc qdisc add dev "$h3" clsact
 	defer tc qdisc del dev "$h3" clsact
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index a726a9a9eb65..6fa1668986cc 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -68,7 +68,7 @@ switch_create()
 
 	adf_ip_link_set_up $rp1
 	adf_ip_addr_add $rp1 192.0.2.17/28
-	ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
+	adf_ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
 
 	adf_ip_link_set_master $swp1 br1
 	adf_ip_link_set_up $swp1
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 70331c3baa47..208919a44703 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -613,7 +613,7 @@ adf_ip_addr_add()
 		defer ip addr del dev "$name" "$@"
 }
 
-ip_route_add()
+adf_ip_route_add()
 {
 	ip route add "$@" && \
 		defer ip route del "$@"
-- 
2.49.0


