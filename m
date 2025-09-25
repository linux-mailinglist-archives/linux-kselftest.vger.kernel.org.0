Return-Path: <linux-kselftest+bounces-42392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB69BA0E75
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260097B9E92
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12431282D;
	Thu, 25 Sep 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JS6nSILm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013050.outbound.protection.outlook.com [40.107.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538933128BC;
	Thu, 25 Sep 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821645; cv=fail; b=IFYljwjkC1cklK1eFpqUxmn1pB2APaJDPDrVvHlbmI6NxQd6vw2l+JUMqH5qVulmJ2s9zkP5O5SulXO6Cloel+Uzl87w7zupMEKub8mpHMk5I/ActPic9ZRP1sMzSwaoj1r6A2hNaKC74l6TnnC6wl7RWiGB1Mnx3S9UKSdabZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821645; c=relaxed/simple;
	bh=wUyvNb3RM9PZUZtFxdmZ/E6Faxfbzq5GLciwg4v2KF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqP4J0uDXWFymFVA44SIAKxbDiH35T1clyAtRqYTqzotLdX7WNtSkJLwVxst4oiXA533fd2mL8tVYu5fIKHY9ZMYTkV+dpL1g+7z6zwcjNY5FUaSU5mpWfyBXSa23NMEBCcsnY/JhHU2wPoC7Y4k7TNyTUhpZltQPb7JhvJlsVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JS6nSILm; arc=fail smtp.client-ip=40.107.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejEWO7XkqRZSfysOLRWezpJLOCpEYEUmu528D7QzR81xIkgP8+GVBrZnxy39YfhR4yXXYOu0BU64vYeuHtSlYwhFxJDVBPeYjizrYNGAPB/RxlGfg9MbmRMLqnikC0WV4E5auxQQVGUEplXaaJqolM98c98bK3iGjPh49CRwoJqRHPa7umIFUPsb+q7tpLZGxvn7bSPieNFw3Y5KvaSEN1hobFb2njyurDuFjEStBo2LO5a7XCSmbjxXKBfYjG7+pfSGSjmeeXrm4t/Dim4HDbaIxgl7lhGQZdxkWan7SnKcdrVfUPmCYPCzSp4dgeVas789Ll4qmALQpuBBOT3wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUyLkZg3ityXBbHkPo69Z6P9XLSMprAEup4t/r0O7Oc=;
 b=TWfjAFV/Yzq3OP4WaJqA2ijB9V5TfXSFBHpNnKrew+yGR8n2Z2O1e+KDZ6GyrazP50kqfx/ZUw2uiJ1WHL86ShqXPPu5Y4OAIbS6tbzPwWmztQvAtQ1kHjQN4g6Q9RR6BPXBGB+gGwSpbK2u3nrWlTiOsWWrzfdq/EJdkkewKgfeQyFlHpnoyO8YaUEXO6cPLZSOu7j2pervAr84ySJS9eTAigO3lgtfa2hzjeioA8j7P/7WFeDT/3INc93AQ1UjZ5Rn97Yf3b25CzLkgyxAUnZvXBpK6T4iQfOXpjmgElhyi0lp84Jg0dWdE1wl/z5cAWi0I2XLiDanlJjtp2D4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUyLkZg3ityXBbHkPo69Z6P9XLSMprAEup4t/r0O7Oc=;
 b=JS6nSILmF69zSA3DO0w6rkVrQRRVbXxMrU6bML9RdZlQgH3eNUXVWrMRhYgcZyEAku3EH8Lzi09AIf9UYdlAJQa7lIGjC2N5vpmDE16fp1iIQwk0WnuQIMUgIBxZLDcmsViGXzzfymtYV5aXEjHBn3eDOo9CCJxQhAmpg5QxHzBbCEqIekEX0WUEmb7jQyZLYqVD0fvdVqis6Yxy3VbpdHhjfQG072y5BkWDjCrPNUb3nAazq1ftOM8CvA3Azhfw4NbOK+PndQXoaHbkK1LHFPWJpyljfu97PdtjITtHRb4Ab8kbneGkP1PMjEwZUAbggBcpUqZZTRcYH6sAPYwRdA==
Received: from BN0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:e7::11)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.10; Thu, 25 Sep 2025 17:33:58 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::cb) by BN0PR03CA0036.outlook.office365.com
 (2603:10b6:408:e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:33:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:33:41 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/13] selftests: net: lib: Rename ip_link_set_addr() to adf_*
Date: Thu, 25 Sep 2025 19:31:46 +0200
Message-ID: <5318e90f7f491f9f397ac221a8b47fdbedd0d3b2.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 602ca643-3b66-4db3-fe2d-08ddfc59b4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOfbTAjXwmFeS5sFaasfs7qZbmnIX4YYFfrTyExXnFsje8xc4cEIDqvt9hl/?=
 =?us-ascii?Q?HdI3vBfvXa41TgyCH676Xdsu8A/Td1VPV5ekfIKASsye4VqcR/la0PoafN36?=
 =?us-ascii?Q?fuMVjACtC2on5kvYBEpJYy9NVg/kXOZq6aFGhWzPwdoWTTDF1hHsq/xZEDFu?=
 =?us-ascii?Q?59w8NmV4A0FdVegll0Hd4TvnFvUoGOsKeOZOID4Cr+f58cLhIxO4R+X5jfhT?=
 =?us-ascii?Q?U2GEPxlF9EDYoZB7sCqC2GGUC/rBUKrfo1aJ67g0nyeJYJhsWunad161jkpC?=
 =?us-ascii?Q?/vrUZt1n2850VvJERV8ww+KPHeL/S7c0j73bqWp/o5yghXc6fN03Y8OX6VAm?=
 =?us-ascii?Q?gHDGH+c/osDBphx31HEQbl0L1TwG+WOFUM+jLO/nxKfB6zYAKNtq8/4d/oLe?=
 =?us-ascii?Q?qmnQiroec0riehdLW2Xbzveekj+UmDB4+WcuYCEwdWeeZ0+EFWMLummrAE6Q?=
 =?us-ascii?Q?J8sQWFOmKhCmSLUafWVRMVW0BRLIEU/Lo6DmsvxwDu6oZu0fv8RCueClf3UJ?=
 =?us-ascii?Q?cAfI4ihJBb+CEATYi+kqE1GbyjLOnAVQ5D8s1vgnGFrKw9Qdq0LfJxRrbc7f?=
 =?us-ascii?Q?67GG/wP/tMiBDh8WrjOl2lefMDJJGTwHqetITDvFpDo3Ifxw5CF5bt5xOSr3?=
 =?us-ascii?Q?A2edP855hRKoq3OKajbSCXN/46lKcGEMtLVr0Rdy/H56qmPlY7+hC9oTRVRK?=
 =?us-ascii?Q?7FjIChdV/+sVh2HGDYA6rYCDybbp3CmHu02UP54g9Mfw+r1GhYnqBoDDRdbn?=
 =?us-ascii?Q?gTL21s1rfksKKdgNAwr8I1yRWKEMZ78svSp/Aqpm071XX6RbBffyeQX4YDTJ?=
 =?us-ascii?Q?5QMoy1XnzE/PicRvxzDW9e4oVnbrMkZSCFFAfhbGnGFi4WZnUaPMVFPAavac?=
 =?us-ascii?Q?7AA2U7TZyaIjBpRdEqh31djTLDjDY/jieAaC9dAXIu84MEzMJFx/a16sje8y?=
 =?us-ascii?Q?e2cAUqNvT8abVroxFyiLTdzhH+wNQANad1kSkYglb3hOajXVZw6063PTtm2V?=
 =?us-ascii?Q?uhlOOp6gCh0R9K7fa4T1Rqw/QDTzvOtHXhxhJlMSGc+6xtwoJPf4RcvtYxX5?=
 =?us-ascii?Q?1pX0GeCcKuEi/BcjAJqilPPkmSjvBTmR8LSKDqHoHuW8gEgyhwD25j66G2Ro?=
 =?us-ascii?Q?mgpZ8IQQevMFDPjWBIhGN1ySj+hIOjtewxYwLi0dYo2bF4auyvYUSnJ/bbwV?=
 =?us-ascii?Q?QzzKrHqevTjvmcE3k/OJY+Kr1/ZV+5DQg1YX5nB+pDXkhuJKiMreBqmJuqAn?=
 =?us-ascii?Q?ttrqcqzw+/Y8Sl/VFzTG6WXrHPpyPOKF4+0iC+SSPQ0VQVoxLlAC8JgnCsLI?=
 =?us-ascii?Q?8xILxFIA2R9zo0JfiJBWymUf400DM2QQIB4HocRaSzUyM5eaFko+Bx/LyCdN?=
 =?us-ascii?Q?iW8nA8QFR6K9iTAW8QHFJdPijywkYDUeSIOirxZAcFnrtBD/3wrAEgkDXkSO?=
 =?us-ascii?Q?Ty9vLCHjMbDxyq7R3Ui38xU1LybhYPHXCOCNsIP7Hs8jmUKWilpIaNNqyc+C?=
 =?us-ascii?Q?BsGvmywWorq9C9cMRoGlpAf+M8/k2DujdPt0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:33:57.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602ca643-3b66-4db3-fe2d-08ddfc59b4e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/bridge_fdb_local_vlan_0.sh     | 6 +++---
 .../selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh       | 2 +-
 tools/testing/selftests/net/forwarding/vxlan_reserved.sh    | 2 +-
 tools/testing/selftests/net/lib.sh                          | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 561cb9f253b6..07e07a266c80 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -137,7 +137,7 @@ adf_bridge_create()
 	adf_ip_link_add br up type bridge vlan_default_pvid 0 "$@"
 	mac=$(mac_get br)
 	adf_bridge_configure
-	ip_link_set_addr br "$mac"
+	adf_ip_link_set_addr br "$mac"
 }
 
 check_fdb_local_vlan_0_support()
@@ -296,7 +296,7 @@ change_mac()
 	cur_mac=$(mac_get "$dev")
 
 	log_info "Change $dev MAC $cur_mac -> $mac"
-	ip_link_set_addr "$dev" "$mac"
+	adf_ip_link_set_addr "$dev" "$mac"
 	defer log_info "Change $dev MAC back"
 }
 
@@ -376,7 +376,7 @@ test_q_sharing()
 adf_addr_set_bridge_create()
 {
 	adf_ip_link_add br up type bridge vlan_filtering 0
-	ip_link_set_addr br "$(mac_get br)"
+	adf_ip_link_set_addr br "$(mac_get br)"
 	adf_bridge_configure
 }
 
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 9fc956caf961..e344cb2a5f04 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -207,7 +207,7 @@ switch_create()
 	swp1_mac=$(mac_get "$swp1")
 	adf_ip_link_add br1 type bridge vlan_filtering 1 \
 			    vlan_default_pvid 0 mcast_snooping 0
-	ip_link_set_addr br1 "$swp1_mac"
+	adf_ip_link_set_addr br1 "$swp1_mac"
 	ip_link_set_up br1
 
 	# A dummy to force the IPv6 OIF=0 test to install a suitable MC route on
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index 839def391b6e..c0c96fdb16e6 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -63,7 +63,7 @@ switch_create()
 	adf_ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0
 	# Make sure the bridge uses the MAC address of the local port and not
 	# that of the VxLAN's device.
-	ip_link_set_addr br1 $(mac_get $swp1)
+	adf_ip_link_set_addr br1 $(mac_get $swp1)
 	ip_link_set_up br1
 
 	ip_link_set_up $rp1
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c9a15fe5448a..21b998b7330f 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -560,7 +560,7 @@ adf_ip_link_set_master()
 		defer ip link set dev "$member" nomaster
 }
 
-ip_link_set_addr()
+adf_ip_link_set_addr()
 {
 	local name=$1; shift
 	local addr=$1; shift
-- 
2.49.0


