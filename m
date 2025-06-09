Return-Path: <linux-kselftest+bounces-34518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73283AD281E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395777A85EF
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CCF2222C8;
	Mon,  9 Jun 2025 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZFeh7L2+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10422221700;
	Mon,  9 Jun 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502361; cv=fail; b=tuxCpt+U616274Aj4tjJ+hzX7uTEmTXwFk5bqugj9Pwzd47BDEcV6KqTPU3x1+QsLrg71ci1FCI1X1XjWEQwVLPeA94p7CqZDZ9LppAeva3OfZk/UOsgD/rseQ8b7RfN4BvHGIgEWeoTB9ivU3+JvZNIdmbsJtVlhwyRCl81KJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502361; c=relaxed/simple;
	bh=9udMvBa4ac18oQHg4OnUIXPmlr3sXaKl07+uAL+DXN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fc0VGu7z489dBSXQ5PNuHy2JTVnUbTrscPnRN5PQGVjHV4VpiIQzq3DCHCqiTGhHG/oo9pflS3rlgHN6Mpf50O66jAPR2a/t0p7iDfYswC3Y13nprZWWHNAM5TzuosCzSCaJTnd4N/ZuHqkBa7QFlpO0sreoSKSt6kFZ6Nrzjdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZFeh7L2+; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txbw+k/KGKoxzASyBNGl4nWAdesXmwa/jlOdaPjWPEhWAOS6DERLvmhYvYd+S7IHDYqkw4kttFM9x4kERjx4B7dSQ5NWtSCGlKJgPjvQZwMCGiKI/GOU/WKqhKq7y0KYR2NHHplxRa++u3xHcfMV9e1J/kt3RXWzUqET9yfNdLNUe4U/jOGkNL3ayQ6sysUvulXPTCepJ6vB6eX+IoxE91B6PO2zvz6NJY9dr2F7DUS52EluJG7zjQIzIFZqujRlabOngNX5PYjS5n2uAgEw9a+gsTb7jigA9kMrPrT7FOeVpL7/SMNsAhKp/WHWy3pLpsU9ShKiKEy3nB6IsMmz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgfu7+Xc1AAn+kf2xvoV9VWWqV26gvrQAhIfdH8h7uI=;
 b=uE1RDo24tKuOTJieU8ZFuMa53/Gp/qXbDN6t5PUZKlk9n9jV/v50yzy5MSX/ZqIlmOpTe0BLCw/+MRt6u6Pc+JoOQ7YKz19bZRHn1bae4/3spOKlkrBSimDpBCpjbRy6ol9JfQgoa1ZnZA/E43jqhXNTXB9oJewpbXXV148WDrG2s5ogCg7EhwMbVZIbDv1IggV6kcyPKYL5UupCcR2rw4IXrkMAnpfjD6L66UlIBBzFuTfgE22rg9AGw96tnI14PcYXDcVHDK5SzP3DlKoAYSMTp71wOwRMszsSY6P3aw2yxyKDUEir5rIKCj0RNUXULVBO5vAEnwPXUvH68ZpTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgfu7+Xc1AAn+kf2xvoV9VWWqV26gvrQAhIfdH8h7uI=;
 b=ZFeh7L2+FpTqJxzpY223kMe2bZoSYeJ+6LvYUMEOuq/TRHcWOySKUbUHIWnWY+dDkUxisAj9vQMBoWevZ3q3utMduTwCL3AW56g+ovCA6JjJ7NJxF1FicdmCexXm2IrngJTX5OZ2J1lMDf2pqqUmdRsBi1rwrAamoRiX4Qywc8/q3x3XyWm1vyZktbmiiwt6Vd5fo3G/GqsNKASCFN5NjXFOITljCK7V+TqJCkhcbvkMy7sWbRTd8XGENPu3dnekt7t8NHzNIcDbAGstNtBhjXHBfvYB0m5y1WZEdbd8BOmmgDysiJPARl2Asn7QECrNLNNECSB99oD0suEVu87XlA==
Received: from DM6PR13CA0001.namprd13.prod.outlook.com (2603:10b6:5:bc::14) by
 DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Mon, 9 Jun 2025 20:52:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::86) by DM6PR13CA0001.outlook.office365.com
 (2603:10b6:5:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Mon,
 9 Jun 2025 20:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:19 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:52:13 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 12/14] selftests: net: lib: Add ip_link_has_flag()
Date: Mon, 9 Jun 2025 22:50:28 +0200
Message-ID: <e2fc1734cd9437349e22e16c05fd0f4d06397fb1.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc29654-8e89-4df4-d209-08dda797906a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYt/70D5coW/p1FjsCmFM/ksJLF2tiVbJb/cUZo6umRRTJy/+mmJuWop2Ntw?=
 =?us-ascii?Q?lVLV7p8ddCtwFBOWNhz0DX/qxPU8RG5z8Y9K2D6RrSZFKhR4OIddGIMNLZgA?=
 =?us-ascii?Q?p14RdmjuIzV4pWqcQp2u2U65llYiww4uY9ja0S0au5+DhXox2tI2XE39s+qn?=
 =?us-ascii?Q?B4eH8SHQkckXlzjor9da1scX3/SUNs5oOQAb6OR7ajy9kH/rtR+TcDZ59tnd?=
 =?us-ascii?Q?MHvDFI1oAZcUyb5rYRKOlmOLvuoN/Fr+XXzNE+kcgo19uYsdILkuhxRC8mda?=
 =?us-ascii?Q?uowZoSoQKzqpmoMqb5tXU71VHHYWw8jg4aMLnj3yeTsFdNSD7VfFIRGb9nXv?=
 =?us-ascii?Q?ZVTWNA2jYC9osdzmCmlsfC0Y/eIEEPHJOc8UoVUFaEQz+w+7OoN4ph+S7A1I?=
 =?us-ascii?Q?xTCvFRXfuIp/BT74V/J/BbvusolH4XXbgqdPgOU/7t1e7MExp10YrbJF15MD?=
 =?us-ascii?Q?bAbBcENcn1RIoj4fKvN44J62MDB66/h64V/4EtK1EQ56q6nebxkcWoTJaNBF?=
 =?us-ascii?Q?8zd5T2nuXq49+xJulEWYFhTI+kiR+vpqyCKYf7WlcFOWBSEpNrxEYw8q7eoI?=
 =?us-ascii?Q?vc1Es2b/sDV87nWPENt8Y+YrJ0FxFAITXbowpsdqzNhPo4EPh6Il8eMkY/i8?=
 =?us-ascii?Q?uqhsYfUGfhc5CA3Ee1I8Uf/tsxKTHTNCtVDO4b2TUhynV08CF4c4tZAoZJ7J?=
 =?us-ascii?Q?hW1Dnj/iajFVrgRhq3dGsW3Biy5SOtta3WWPTjLVFIZtCzyu7K9znBpziRZU?=
 =?us-ascii?Q?uRnM4ADZGklRCFm4lKae9Ne84vFWLz/h3/DcXK+Dh4Prx41h89cLIst1yzrY?=
 =?us-ascii?Q?wxxyaOFuJ/fYCuFn5OkVbUoL5XmlbfjAwmjODk5e74XB2iGPFauXsUH+0zue?=
 =?us-ascii?Q?LKMjYdrCLuDYlKqbNd/dsa5ir3B4FdorN9C+R+yRz7Nc2aUHwc3gWIX81CFd?=
 =?us-ascii?Q?IufXY+/fi2YV0HqOCGQzC57zT9le3iI0RI/cmc3kW9HfLeaTEAunzLKifdpP?=
 =?us-ascii?Q?z+K2EqhVMAtNAQAxUCmwpwQiP4Z+V+ujNNibXe824YwFnWC7faox3h4+pUzy?=
 =?us-ascii?Q?yPJpRsGIF5p1ZJZ3tuCOZzl0mOj5RyqEBI9J6T/VQqnnctQ+QoNDxgI5t12a?=
 =?us-ascii?Q?+FT3e571YCSOHRtj0bAz4F7rphihdt26AtoOgaAgAgtAbindtcMeyv/44s2O?=
 =?us-ascii?Q?rWWpCnGNzvd7NdQKVL9Q2M7Ejh8Yo3BBubkGESHg0xlz+iTWyKt9NyjtaZx3?=
 =?us-ascii?Q?0lkB9tHS7oQf+4d8z0CkStqOHLuEBaTi8L42cvD9st/rN11HMNLDo+GQlZNI?=
 =?us-ascii?Q?phxDn5Rocs1+tTYUweVetNH/vJ8jeEnw4H5g0iE4g1n7AbkiXtvmBBhtZEq0?=
 =?us-ascii?Q?iP9o5GjOvA9ezus14/MUGMA1s6OE4w+ZaR9vJjwrkd2ye3pklJFCO4wnbWZU?=
 =?us-ascii?Q?p6Jk/ZOL8thywv6JRp+jRbgK9BMOq+raQZ1conH0AVqpoC/r+q6xythkkJ2E?=
 =?us-ascii?Q?OQ5YM/c3KKiBMrgiwOLNHKSc6FuqZLuHNtFD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:35.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc29654-8e89-4df4-d209-08dda797906a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Add a helper to determine whether a given netdevice has a given flag.

Rewrite ip_link_is_up() in terms of the new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 006fdadcc4b9..ff0dbe23e8e0 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -547,13 +547,19 @@ ip_link_set_addr()
 	defer ip link set dev "$name" address "$old_addr"
 }
 
-ip_link_is_up()
+ip_link_has_flag()
 {
 	local name=$1; shift
+	local flag=$1; shift
 
 	local state=$(ip -j link show "$name" |
-		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
-	[[ $state == "UP" ]]
+		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
+	[[ $state == true ]]
+}
+
+ip_link_is_up()
+{
+	ip_link_has_flag "$1" UP
 }
 
 ip_link_set_up()
-- 
2.49.0


