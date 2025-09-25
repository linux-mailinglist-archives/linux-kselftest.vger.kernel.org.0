Return-Path: <linux-kselftest+bounces-42393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8B2BA0E9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48AC165DB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917D313278;
	Thu, 25 Sep 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W8ihn/nM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70523128C8;
	Thu, 25 Sep 2025 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821650; cv=fail; b=TePHG2NIqjqmDp1jZZD6oDmw8EWUqjs3+JctFvqkHivsLSyeANG6JVZVqMVkzQUqHH9CZSscXY1LhMCCe0xHvQO5ZLv2O4W9BPlMQ41yWvmotlK5NBvZpS/1MJXRcoydcBf8ygiwPe1JfStWIb4ecTsI1XpixGDkclUSU6kR//g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821650; c=relaxed/simple;
	bh=ZE3s6MjhFk7YhLF6fOMu6/LVvRKPJyLEC0qi4c8YpmE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2VSTzH9P3Q4XgPm7ggiLQ7Y+SJ4DbqHwvHZU8gEoz/Kkkm/gerqsyD3mW4qHC+DsRS0JhYXorOY58q6wqPFnbV+DMigjb3sz4LlEQ9HgHDYxcMPjozmwA/RkjXLOb4hhHDM2TIAUFXZ6+T2CcCFx9yKNfRk8JkyYjUUi8+jEQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W8ihn/nM; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUGdUr4KcBCCuTNyhTYji3U9J26BcSsxz3Zm1W+5zooZYnZg4/DSGGtk/9e1f61xZheZCvy0XFDbDF2fNSX+AgaiwEfcA7stWqRREIL7w9cql60LNCvryMwCwJ3WJxPWjCvtWhwOwvi/Vnpy52aWbiyRTpAlTr2ACH3RijC5+YmHws3DhesOO/G7lX2/m3zPjHG7pDgFVTKhvmlgWR/p6r/CbgGUy3eagux3FLmVf3rsZJSPI60j2NgqpVWuI1E5qOnFdHjeSLfirllQ3bQppxntWJNjrorQX+ngqE682qA/V02ibXk01jwMzQFnAKfD9V7m0Lm8qU7kni2cCRLuiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYNwIMwLJ8VlrL3gn0iKlhXbck9JVbEKAlR62ZEsp6Y=;
 b=aCuJzxaoKuvQrMAUkDJKp7j4KDkglBQtBmfZ6MuThiBechlXHtCdKGZFIPVZRDfjzaZx+mItFST3yibEmf2Jyir7s5kZ48pQoQtA7v3niidXGOCs0DWbPc6ir9teohJAD5J4973R+tbTZhMjVDcxGTyBzlANb/r2/bqcOM8CRwHRdL2q80uCcCH5fC5pKsX04IoquNJTjYMxsk0pckPfsqsSJMt8iUUjyWrQavRWISeItTy9/BY4ijgnDdqSblK8nKE+MxzqcUffTjaer9CFAg/XQe0yYGnGL2nUpyF10GicpBBFnvkLWKUvoNBgtn90CFIRpfgNzDbeBiDYYVY6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYNwIMwLJ8VlrL3gn0iKlhXbck9JVbEKAlR62ZEsp6Y=;
 b=W8ihn/nMKLzOyUoe8TZYIGNR6/4XFEoko2+NXNinhsRtoJYcfA0XoVEqPVuaHlrRl/gZAVDRfjnxQAu/++XTtIlsU3rQ5CbZ26yfdowkzWABcp/ZaLRITEShEEN/ApPe7YBphuIz7wE0mnJp0PHCmE8Nh2GsK6r6EG9dym0wy6zuUPGvbfFq8m/Bzm9enRqyi1VfuL9yeGOMfN0uzVkS6Y+zQjCIbTwbCDdwg9zsy8WlpbkxoX6TP63G+mE3WM0BH4CcrV2hWeUtyXtOAfGxpxQpkR8sIESpTcdY0u5jA7U0MFS29VtfrIcVH+u+OI8sE0hVG69b2t4On0wPTU6m+A==
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 17:34:05 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::57) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Thu,
 25 Sep 2025 17:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:33:46 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 04/13] selftests: net: lib: Rename ip_link_set_up() to adf_*
Date: Thu, 25 Sep 2025 19:31:47 +0200
Message-ID: <475716ef792f5bd42e5c8ef1c3e287b1294f1630.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 54eaaa12-3615-46d0-181d-08ddfc59b92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sP5qih2HFa9J5Hs7UWQ3pHGSbwiCVe7WAU+g1yfBhLV1WYsQC735TsHoArqy?=
 =?us-ascii?Q?6hG5tkWSzIPRkB2JJcL7JAyWjTHAOjRH/XBirzjXu2KQ/u8KbYclh2hN5e5c?=
 =?us-ascii?Q?Lz2hbW6+IUsqSVCPb64y8dU9V2RxoZuenooXE16WhtPzonBfkq/06pj5ztYO?=
 =?us-ascii?Q?OtfAHwNUxokTU5k2MQfQnPEb/xyJlVWjkw1ZvxojwRzhzp5heCxAGNHuMguS?=
 =?us-ascii?Q?zKDjPfEnjU67jWzR1VUsXv0ZC7ooW4PRkw1gNpMj998BbtFlnLZlXh83ELn1?=
 =?us-ascii?Q?rctu2C/q3IiT+ey8Seewz39cGspgmdmUMA4f3vntTKTQn3dBqtTpEiOwFiOG?=
 =?us-ascii?Q?aW4jDR2eBZBVHWufK3/HdrIE6OxKo8TOm8lmVYQt1bTkqx62cwyr9MBpGisZ?=
 =?us-ascii?Q?uA1wRkKfAATmSSHSVksLGoicRMw3VT+BxetJvlAe9ta9QXoRAyb0Ce6qNdLE?=
 =?us-ascii?Q?hxHKmTM3vXToffyZ6PkKwQclAZbjJC5gPecw7wbTMdQl9Tu8uf6ykwr7H/nX?=
 =?us-ascii?Q?934Q1gUuBWH+K0HTtSNceQco755rH8Ed1fhAj4VEoSvEx8QbzeKjn4Va+/OM?=
 =?us-ascii?Q?PAlkVWlYMvbU5eINcgn1MzxaLSqJ1X+0GSEVL/MKtDXTXddk8Ynme41cfFXL?=
 =?us-ascii?Q?kTseuB/l5qy2LYz3b/DHbc0gCmnwfa302MHy9EIfQ95lZdyH0M6jB+owTixT?=
 =?us-ascii?Q?UAsZo50DQdzbBlw2oOF6jfa70VAt+wgNf+mipCRwTYVchD4uShKp1wBINSPJ?=
 =?us-ascii?Q?QepqPN/Lb3rrWJBx8PF4JoN7dlH4C/rDtAO6FIq9E2FZny6/Fu3vY+8L1+Ul?=
 =?us-ascii?Q?kDl0aFfAJlLEdda1htnpx2J4kXky1WpaIZROTXR3hSQwu64WxoHs+X4aSY/r?=
 =?us-ascii?Q?B5aAYgUmGolLGoYglnFH4tzChMEq98NlXrbqRFWRCYeKCQsuhTJaRbKuPDH1?=
 =?us-ascii?Q?zX7qa1aeBpZkLRLZhGlRhJhqZUGq09gkG3zoC2+qcOtS7FBmC6SXuqDZMKdC?=
 =?us-ascii?Q?cumzo9HspNN69ExKQYOPCpqdEm0003M8jHWhUbx7+TWf8KynFQEdDI36NqlP?=
 =?us-ascii?Q?pIQf8nlfVtLFrEsPEisUzBHCIrPSvNIGdH/td+69akTmM+NFZcgpG0ilu/k1?=
 =?us-ascii?Q?CqgCc5YNXBfisokmBW2pRJpThbjhB9ajlH6W/FGE2aCfqPEcYPiAgMlbiUwz?=
 =?us-ascii?Q?OPPIo/gzYRj7Cs9+OIyYu7uc6Or5ufsOdkFbiFGURBm+aE/otp+HcSQfAz5V?=
 =?us-ascii?Q?9MeSgUjLfXUVjBdl9NFMaN4oSOJowKU6dPqLlIgPYX8tQBSmB/ePUk3o5FIy?=
 =?us-ascii?Q?IiemDKTyYFeDYyHCdxP8T7K++OcG/rzYknarzLZA/Fozw3HkYviPzjXFReFY?=
 =?us-ascii?Q?4LVHjOxFLpLFfhJaj5T0UhoYPLSGLJdIvIDTQr8/ZCV5KVqNFyhFR49xqkGH?=
 =?us-ascii?Q?QzHnYSxUYcHb0nBA+fOiarfop/dtIDpzXAI0tk3u9qzLYYqNxzP3NPwDdzWg?=
 =?us-ascii?Q?Ddbz8rNhGcx2ZN5tuOBgAOcPcdEVch80KCsjRSME7kAwozJF4Vb6jUIYqXAr?=
 =?us-ascii?Q?9z4uBmGADNXMVTP6sVk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:04.3716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54eaaa12-3615-46d0-181d-08ddfc59b92f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/bridge_activity_notify.sh  |  6 +--
 .../net/forwarding/bridge_fdb_local_vlan_0.sh |  6 +--
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 38 +++++++++----------
 .../net/forwarding/vxlan_reserved.sh          |  6 +--
 tools/testing/selftests/net/lib.sh            |  2 +-
 .../net/test_vxlan_fdb_changelink.sh          |  2 +-
 .../selftests/net/vlan_bridge_binding.sh      |  4 +-
 7 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
index 3d5f868b261a..8ceb205fdca0 100755
--- a/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_activity_notify.sh
@@ -40,13 +40,13 @@ switch_create()
 {
 	adf_ip_link_add br1 type bridge vlan_filtering 0 mcast_snooping 0 \
 		ageing_time "$LOW_AGEING_TIME"
-	ip_link_set_up br1
+	adf_ip_link_set_up br1
 
 	adf_ip_link_set_master "$swp1" br1
-	ip_link_set_up "$swp1"
+	adf_ip_link_set_up "$swp1"
 
 	adf_ip_link_set_master "$swp2" br1
-	ip_link_set_up "$swp2"
+	adf_ip_link_set_up "$swp2"
 }
 
 setup_prepare()
diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index 07e07a266c80..202eee16ac19 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -78,13 +78,13 @@ h3_create()
 
 switch_create()
 {
-	ip_link_set_up "$swp1"
+	adf_ip_link_set_up "$swp1"
 
-	ip_link_set_up "$swp2"
+	adf_ip_link_set_up "$swp2"
 
 	ip_addr_add "$swp3" 192.0.2.17/28
 	ip_addr_add "$swp3" 2001:db8:2::1/64
-	ip_link_set_up "$swp3"
+	adf_ip_link_set_up "$swp3"
 }
 
 setup_prepare()
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index e344cb2a5f04..20366c61944e 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -123,11 +123,11 @@ h1_create()
 	defer simple_if_fini "$h1"
 
 	adf_ip_link_add "$h1.10" master "v$h1" link "$h1" type vlan id 10
-	ip_link_set_up "$h1.10"
+	adf_ip_link_set_up "$h1.10"
 	ip_addr_add "$h1.10" 192.0.2.1/28
 
 	adf_ip_link_add "$h1.20" master "v$h1" link "$h1" type vlan id 20
-	ip_link_set_up "$h1.20"
+	adf_ip_link_set_up "$h1.20"
 	ip_addr_add "$h1.20" 2001:db8:1::1/64
 }
 
@@ -152,50 +152,50 @@ install_capture()
 h2_create()
 {
 	# $h2
-	ip_link_set_up "$h2"
+	adf_ip_link_set_up "$h2"
 
 	# H2
 	vrf_create "v$h2"
 	defer vrf_destroy "v$h2"
 
-	ip_link_set_up "v$h2"
+	adf_ip_link_set_up "v$h2"
 
 	# br2
 	adf_ip_link_add br2 type bridge vlan_filtering 0 mcast_snooping 0
 	adf_ip_link_set_master br2 "v$h2"
-	ip_link_set_up br2
+	adf_ip_link_set_up br2
 
 	# $h2
 	adf_ip_link_set_master "$h2" br2
 	install_capture "$h2"
 
 	# v1$h2
-	ip_link_set_up "v1$h2"
+	adf_ip_link_set_up "v1$h2"
 	adf_ip_link_set_master "v1$h2" br2
 }
 
 h3_create()
 {
 	# $h3
-	ip_link_set_up "$h3"
+	adf_ip_link_set_up "$h3"
 
 	# H3
 	vrf_create "v$h3"
 	defer vrf_destroy "v$h3"
 
-	ip_link_set_up "v$h3"
+	adf_ip_link_set_up "v$h3"
 
 	# br3
 	adf_ip_link_add br3 type bridge vlan_filtering 0 mcast_snooping 0
 	adf_ip_link_set_master br3 "v$h3"
-	ip_link_set_up br3
+	adf_ip_link_set_up br3
 
 	# $h3
 	adf_ip_link_set_master "$h3" br3
 	install_capture "$h3"
 
 	# v1$h3
-	ip_link_set_up "v1$h3"
+	adf_ip_link_set_up "v1$h3"
 	adf_ip_link_set_master "v1$h3" br3
 }
 
@@ -208,7 +208,7 @@ switch_create()
 	adf_ip_link_add br1 type bridge vlan_filtering 1 \
 			    vlan_default_pvid 0 mcast_snooping 0
 	adf_ip_link_set_addr br1 "$swp1_mac"
-	ip_link_set_up br1
+	adf_ip_link_set_up br1
 
 	# A dummy to force the IPv6 OIF=0 test to install a suitable MC route on
 	# $IPMR to be deterministic. Also used for the IPv6 RX!=TX ping test.
@@ -220,18 +220,18 @@ switch_create()
 	ip_addr_add "$IPMR" 2001:db8:4::1/64
 
 	# $swp1
-	ip_link_set_up "$swp1"
+	adf_ip_link_set_up "$swp1"
 	adf_ip_link_set_master "$swp1" br1
 	bridge_vlan_add vid 10 dev "$swp1"
 	bridge_vlan_add vid 20 dev "$swp1"
 
 	# $swp2
-	ip_link_set_up "$swp2"
+	adf_ip_link_set_up "$swp2"
 	ip_addr_add "$swp2" 192.0.2.33/28
 	ip_addr_add "$swp2" 2001:db8:2::1/64
 
 	# $swp3
-	ip_link_set_up "$swp3"
+	adf_ip_link_set_up "$swp3"
 	ip_addr_add "$swp3" 192.0.2.65/28
 	ip_addr_add "$swp3" 2001:db8:3::1/64
 }
@@ -290,14 +290,14 @@ ns_init_common()
 	local ipv6_host=$1; shift
 
 	# v2$h2 / v2$h3
-	ip_link_set_up "$if_in"
+	adf_ip_link_set_up "$if_in"
 	ip_addr_add "$if_in" "$ipv4_in"
 	ip_addr_add "$if_in" "$ipv6_in"
 
 	# br1
 	adf_ip_link_add br1 type bridge vlan_filtering 1 \
 		    vlan_default_pvid 0 mcast_snooping 0
-	ip_link_set_up br1
+	adf_ip_link_set_up br1
 
 	# vx10, vx20
 	vx10_create local "${ipv4_in%/*}" group "$GROUP4" dev "$if_in"
@@ -306,7 +306,7 @@ ns_init_common()
 	# w1
 	adf_ip_link_add w1 type veth peer name w2
 	adf_ip_link_set_master w1 br1
-	ip_link_set_up w1
+	adf_ip_link_set_up w1
 	bridge_vlan_add vid 10 dev w1
 	bridge_vlan_add vid 20 dev w1
 
@@ -316,12 +316,12 @@ ns_init_common()
 
 	# w2.10
 	adf_ip_link_add w2.10 master vw2 link w2 type vlan id 10
-	ip_link_set_up w2.10
+	adf_ip_link_set_up w2.10
 	ip_addr_add w2.10 "$ipv4_host"
 
 	# w2.20
 	adf_ip_link_add w2.20 master vw2 link w2 type vlan id 20
-	ip_link_set_up w2.20
+	adf_ip_link_set_up w2.20
 	ip_addr_add w2.20 "$ipv6_host"
 }
 export -f ns_init_common
diff --git a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
index c0c96fdb16e6..c7d17fff9575 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_reserved.sh
@@ -64,14 +64,14 @@ switch_create()
 	# Make sure the bridge uses the MAC address of the local port and not
 	# that of the VxLAN's device.
 	adf_ip_link_set_addr br1 $(mac_get $swp1)
-	ip_link_set_up br1
+	adf_ip_link_set_up br1
 
-	ip_link_set_up $rp1
+	adf_ip_link_set_up $rp1
 	ip_addr_add $rp1 192.0.2.17/28
 	ip_route_add 192.0.2.32/28 nexthop via 192.0.2.18
 
 	adf_ip_link_set_master $swp1 br1
-	ip_link_set_up $swp1
+	adf_ip_link_set_up $swp1
 }
 
 vrp2_create()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 21b998b7330f..691f58fad0e3 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -585,7 +585,7 @@ ip_link_is_up()
 	ip_link_has_flag "$1" UP
 }
 
-ip_link_set_up()
+adf_ip_link_set_up()
 {
 	local name=$1; shift
 
diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 1443b57a6501..8b414d0edada 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -75,7 +75,7 @@ test_change_mc_remote()
 	check_command netstat || return
 
 	adf_ip_link_add v1 up type veth peer name v2
-	ip_link_set_up v2
+	adf_ip_link_set_up v2
 
 	RET=0
 
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index ad02d406039c..c6f5d63384f3 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -22,8 +22,8 @@ setup_prepare()
 
 	for port in d1 d2 d3; do
 		adf_ip_link_add $port type veth peer name r$port
-		ip_link_set_up $port
-		ip_link_set_up r$port
+		adf_ip_link_set_up $port
+		adf_ip_link_set_up r$port
 		adf_ip_link_set_master $port br
 	done
 
-- 
2.49.0


