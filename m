Return-Path: <linux-kselftest+bounces-42397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D0BA0EB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E616C21F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8EA314B73;
	Thu, 25 Sep 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EInfT52d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD6314B68;
	Thu, 25 Sep 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821672; cv=fail; b=abYPbj5Dwdk/sSlbEJE8J3mb8jMxbib4dMadR+r3yZvcWtd6ImYA1ZJS7nd0L95Qhplq263gGxEbqHgDncJuCf/f838WFBBPD6nDEAbaMAw9EBm0zVsaiyfWV8TUm+I4+53kC54W+cflzdpgtEekkhNzFJD/tR9OiABW+L4CzgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821672; c=relaxed/simple;
	bh=JvohsGnNCzCT/8kY+ukHPMdntI/XkbWeveBVJG8PMP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAa6o4gUq9lALW5hbs8hEUHQF64iz7CJoXEAJ2rsYNdt6TpHlK/GJxcc2FBYt5YGWbIDejYfQWg1RGUblr4eUF0ayv1pJQqScb7VgPHIKTP0Yl/5Hgn7mLU0fOJ6IQoHFlKZRbdtggGdeFXZip6Om6On739lnM11ya0bIjkAyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EInfT52d; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVGatE7eHiVE/Ql2kVnjfn8jngY9JiCN8O2U76MxbKeoVgxYn+R0ewqfZ+Q9JzlcVYi4W/4IhOMdERrA2/7EQ8aKhmaPqjycRkYNAt9bN8T+sag1Zzp1JciXGYD2YY6oPjiYIdRfAxXTtXg4jcxs+pWQmuYWvRIYFFREY7vwgomRXpK6xyoODxc0OMqqbn7xQEADCy9nxVgAsR6YV57lb/YmHB5vabqOpgSBsxEmktmeQnYn9qRRtoQckxT+LfGi17KUuOVT3kchBLquStGkGbUBRTpz+6ceDH1DhzNlS9G5fJUNLM+gCFU2mOElbUeJzrO5i68bWbEM8LvKOkEbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ml3St5k7OXtZqHkq3RjrmfyY1JdMEe/nUgMWm0o8rw=;
 b=iCNHti0pHAjyYMfSZ2R7YyMLguMCkXnlxETel+Ev62nkyOgGjpOfeR2VO3B677j/CsUBkGVdLqL3u0t2ULKFmWDtmxuhVOrs10YQJ6j1dhyNWtYQQZA3k7aP087Pq4AU0USJOd+/AYU/dW+saAgdJoNws6UW/yWfVhlqi09p9yyB6DbltzUo84yujKy2R25rFFcrmIGYJqrOuxvl7Wlnph/gkUrUw1EeNKU8ZtfjxdwwCQ1id7x10w1jf3c/It2xxpJ286WcZ25iNIK1L+OBheH1jhI04cpYNGfPQT6JRNSWc3TnXeJnghC3kNidLYCEM0c4qpU640Nxnc41B1FsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ml3St5k7OXtZqHkq3RjrmfyY1JdMEe/nUgMWm0o8rw=;
 b=EInfT52dTdElBQWqk3rYZjlvNJZ/h6oa57UOlZEeG0cy5q47+WiX84pDkCWwi0Cg+JSUoIieNXKuVxZiCMwk6NXOTTf97q7pySriHulLtbuU22RUHIbv33ejaiwblGclZlXk9R2bx0Ob28/xDm+jnIYYmJ6Et+GHvDFWdFwEHnXqJQ98eMNfFjBxnKz08WWsDY5ij5qoIg7vOjXeVWYzTg8HDV3K13MBfpx3ggE/1zLoOdiXdfffUYaGDR465hPMoS7ZTKdqtobTWuPvwmxErWx6BDG1ESJOT0Ee90yGYfXXBQpKQbjziUjtwzkTqnwxSW4XNkU9mld3tCgHqZYB3w==
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 17:34:27 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::e9) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:34:08 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:34:02 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 08/13] selftests: net: lib: Rename bridge_vlan_add() to adf_*
Date: Thu, 25 Sep 2025 19:31:51 +0200
Message-ID: <93526ce79e635a3ec34753c796edf0c96711547d.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d173654-9e77-41da-5050-08ddfc59c6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2WEbKqYLXO7t84lkA8wWbibG9Ob+ESSIrVsTW3afQyyGvZQOhfcfS8hLHow?=
 =?us-ascii?Q?ns6ggwiCH1FWjL5UZM/ncsaSraY02hvcka9ULUnW1/9bwZbhW4DhrYnv2OOa?=
 =?us-ascii?Q?cBirIbrTL8lm45nfxhYGFbNQCA/0LxZp9XfTKBbKUkkEq88nF/YR7EpPntCL?=
 =?us-ascii?Q?5ozCU9nM9ILdidP+u1Xl9aZJW4H7izcnV/E3ZRgh4VMbSJPFjpDo4lCvFWL5?=
 =?us-ascii?Q?nh1Bf1l9vTnRSC81Klvgi1kBE6zK32Zb9inR2wgpN3/yvxMbJzPdrZ4TAfMT?=
 =?us-ascii?Q?8F+IKX+1wykYd+VfzKFg+hOXCxDWdo92hO8bH7WnqZoFuRCBeFq2UhrbDMEk?=
 =?us-ascii?Q?g0mHDjtctepYE123/7GE/DNoc8vFMbOJp1+OEkjunreaeRXeNTyG1q53D4iR?=
 =?us-ascii?Q?fR0bEDkCnQ6z9MksIOaWSaQwKmC4fB8JEKtkBb+DxOBaxq83wfmqh71gwkHM?=
 =?us-ascii?Q?+90g0XLxiuoZzj9m0p1LWPop7Tp8pDBWHUOTAi1I2odarcZ3U2c0diaCaIwi?=
 =?us-ascii?Q?jP7wGswMKqoOrp81zFgiitJ0CEE81G8yJUcSzo2k1vhi+IzSSlWZ8eYJDdOv?=
 =?us-ascii?Q?vjh/7h0NopYgtFS8b5oeUB/QgFeZaq4VyI/MPF0xJB1CChGSy+xq7zi1TWnu?=
 =?us-ascii?Q?r4fCnHyixPg8xovi+QxGFTGFySg18NIztcprgzeYDssT0mDpmQPsKW1OEwFk?=
 =?us-ascii?Q?q5QFP3isuE1cx//Z3nMLfSY/+/0NuR4owMua/Vm42L5XfldUa0qLuN28oApq?=
 =?us-ascii?Q?DbbGjytfqv1JQKfaG9fIBhWHpecltNG1zDqojJgCkqdpljFPg388yRnhBXaq?=
 =?us-ascii?Q?VoVM+NNTzFonMj7+gQgVKmM9JeXwOnX1uOCCVaeJ+e/tEmBsKs4QYUEL6JQN?=
 =?us-ascii?Q?+6KpxtMIBl11KYJQDTK+1fqGE0tQHpP7KRXI7rxb3R15DV7nkfRAxAxDY/iT?=
 =?us-ascii?Q?6hiQQKRot/ROEfI+hi253uaDdJHKT9c1kCPFiXVpdxQ39yOtYAv9xuj5U7yX?=
 =?us-ascii?Q?N5uXM/pR0K0gm7BnePY8cWHenUt8Q3udt85P8fOgqNMa3dzifSdHL75153T7?=
 =?us-ascii?Q?b+dnB68ELJyWoeldOf9BtwXk4hT9KLW8IpX4v2/voTQ1jeHcoOQwiNq7EoZO?=
 =?us-ascii?Q?eYvr639fVfx8WpYUuqHTTmDjK6rcWtD9lYCCdCITlTHzylHeSJTB4/9dO3+h?=
 =?us-ascii?Q?76A3asyZG+WRcmVql/OoyCyPPlCfgELNuxquf+jVQd4DwUM3HHRKcQyl5+GS?=
 =?us-ascii?Q?EjTz76uauLLRdE09nx73nyQ2TZ/wv/sImxtISitrO9SEDW48PTocGg/5yJ/Z?=
 =?us-ascii?Q?v5xxCsvF5CJHHAis5ON844KnwFwzMn7Be4B5y/wOjnN0jtcoIDRI12RUXBJR?=
 =?us-ascii?Q?jadZ0k9C1WfTWuPYFa3O2L0NE7KnlLuKjZpN25/L648T26CaqdZpe1T1GBoM?=
 =?us-ascii?Q?5okRWcw+zci4+KWaHtPFKN/yRPHfm0NDyem+fpQD1aK1m2AniVHfs03lCpgN?=
 =?us-ascii?Q?7cPacrnrp+7h/ZoR9B8zAbM5/Z6PTlS5HIPvlCIBoDtH6I1Tb7rIAw90PY2F?=
 =?us-ascii?Q?tnw8hkoA+NAr1E3B1eU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:27.2302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d173654-9e77-41da-5050-08ddfc59c6cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/bridge_fdb_local_vlan_0.sh | 12 +++++-----
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 10 ++++-----
 tools/testing/selftests/net/lib.sh            |  2 +-
 .../selftests/net/vlan_bridge_binding.sh      | 22 +++++++++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
index b8fd85a20b78..c1a506370c4a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_fdb_local_vlan_0.sh
@@ -118,15 +118,15 @@ adf_bridge_configure()
 	adf_ip_addr_add br 192.0.2.3/28
 	adf_ip_addr_add br 2001:db8:1::3/64
 
-	bridge_vlan_add dev br vid 1 pvid untagged self
-	bridge_vlan_add dev br vid 2 self
-	bridge_vlan_add dev br vid 3 self
+	adf_bridge_vlan_add dev br vid 1 pvid untagged self
+	adf_bridge_vlan_add dev br vid 2 self
+	adf_bridge_vlan_add dev br vid 3 self
 
 	for dev in "$swp1" "$swp2"; do
 		adf_ip_link_set_master "$dev" br
-		bridge_vlan_add dev "$dev" vid 1 pvid untagged
-		bridge_vlan_add dev "$dev" vid 2
-		bridge_vlan_add dev "$dev" vid 3
+		adf_bridge_vlan_add dev "$dev" vid 1 pvid untagged
+		adf_bridge_vlan_add dev "$dev" vid 2
+		adf_bridge_vlan_add dev "$dev" vid 3
 	done
 }
 
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 091833541b06..a968a3ecbcbf 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -222,8 +222,8 @@ switch_create()
 	# $swp1
 	adf_ip_link_set_up "$swp1"
 	adf_ip_link_set_master "$swp1" br1
-	bridge_vlan_add vid 10 dev "$swp1"
-	bridge_vlan_add vid 20 dev "$swp1"
+	adf_bridge_vlan_add vid 10 dev "$swp1"
+	adf_bridge_vlan_add vid 20 dev "$swp1"
 
 	# $swp2
 	adf_ip_link_set_up "$swp2"
@@ -245,7 +245,7 @@ vx_create()
 		nolearning noudpcsum tos inherit ttl 16 \
 		"$@"
 	adf_ip_link_set_master "$name" br1
-	bridge_vlan_add vid "$vid" dev "$name" pvid untagged
+	adf_bridge_vlan_add vid "$vid" dev "$name" pvid untagged
 }
 export -f vx_create
 
@@ -307,8 +307,8 @@ ns_init_common()
 	adf_ip_link_add w1 type veth peer name w2
 	adf_ip_link_set_master w1 br1
 	adf_ip_link_set_up w1
-	bridge_vlan_add vid 10 dev w1
-	bridge_vlan_add vid 20 dev w1
+	adf_bridge_vlan_add vid 10 dev w1
+	adf_bridge_vlan_add vid 20 dev w1
 
 	# w2
 	simple_if_init w2
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 208919a44703..feba4ef69a54 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -619,7 +619,7 @@ adf_ip_route_add()
 		defer ip route del "$@"
 }
 
-bridge_vlan_add()
+adf_bridge_vlan_add()
 {
 	bridge vlan add "$@" && \
 		defer bridge vlan del "$@"
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index 09081bcbfcc7..794ba71c45cb 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -27,20 +27,20 @@ setup_prepare()
 		adf_ip_link_set_master $port br
 	done
 
-	bridge_vlan_add vid 11 dev br self
-	bridge_vlan_add vid 11 dev d1 master
+	adf_bridge_vlan_add vid 11 dev br self
+	adf_bridge_vlan_add vid 11 dev d1 master
 
-	bridge_vlan_add vid 12 dev br self
-	bridge_vlan_add vid 12 dev d2 master
+	adf_bridge_vlan_add vid 12 dev br self
+	adf_bridge_vlan_add vid 12 dev d2 master
 
-	bridge_vlan_add vid 13 dev br self
-	bridge_vlan_add vid 13 dev d1 master
-	bridge_vlan_add vid 13 dev d2 master
+	adf_bridge_vlan_add vid 13 dev br self
+	adf_bridge_vlan_add vid 13 dev d1 master
+	adf_bridge_vlan_add vid 13 dev d2 master
 
-	bridge_vlan_add vid 14 dev br self
-	bridge_vlan_add vid 14 dev d1 master
-	bridge_vlan_add vid 14 dev d2 master
-	bridge_vlan_add vid 14 dev d3 master
+	adf_bridge_vlan_add vid 14 dev br self
+	adf_bridge_vlan_add vid 14 dev d1 master
+	adf_bridge_vlan_add vid 14 dev d2 master
+	adf_bridge_vlan_add vid 14 dev d3 master
 }
 
 operstate_is()
-- 
2.49.0


