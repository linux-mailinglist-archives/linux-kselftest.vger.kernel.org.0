Return-Path: <linux-kselftest+bounces-6558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3388B1B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 21:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3A48B63447
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5B3131BDC;
	Mon, 25 Mar 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sp7P+Nbh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01C512FF71
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387968; cv=fail; b=COTGnSOi1YPnr2cvvSuziJ8FS3EZ3JvVZwyDkbLoULIAFv5sNE5DIZtWnouGbzf4HWCSlH/ZdfpPLSCAg+t8jkqjGSrQhrFcSxGnwzIdVFZAlHuPmcpFyKKyvfQibnzQv7kW+jfguzGbBRUYpaSJq0veGfbEj/nuxzTkn90sPic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387968; c=relaxed/simple;
	bh=eD6MQvEub5I3N8qgmWskGamI76El+pptE4/SO3GYmAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWkPtLPIH7Op1JiXuqLc3ENQNulYp+WXob0Sr46oy38XHK7s5Tw0LzRTTeVGFZdh6Da9CUdQvyuJrVH7G17t9/vrlzXrV5PRPDAAMcBGrTgP3ZQ0fc01BHNFK8ph7ERKUsni0V5h7+HtinJEN8Jl1P6Ge7AEK3pylaMgEaDwYg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sp7P+Nbh; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoJTPbJOf8GBcbqtxiOHlujpVuxY2VVzwL9qga9o2DPnB3+nXFlaAalmMdx8OcicXnCF+LZC9a5SZKHJ7Tr+BhKYv+rx4vCBoTKIDVVg1SiwP1TRh3BKgQy/yR76F0dtTq6cZintXTAqSiZVmujP1fIMLWgC3r0WhQ0kQpDsAj+CRiltYtTwJsLM0zNmQvTMOcJUF9CFFZRC6va8vAJfPRaKYH8K1SNQSyxaWbUn5nHgIhD3euUK+QcxFW6wxOMWO4adXXt8nJmqxBy8c/jGWvlZCaTFNoL+PxRpC99UGkgvACntdHqdZwn8aQLJjlq3nJPePxFWK1ZmR9WP4OCIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm4AEV0COAMI/J5B99PfrbdjczRcNJUhS3S7M0nKwEk=;
 b=V1uPyxpcfIUAZFUkfd/PJLKUFJPjRLL4SrbBa7Yffp+Oa1uyiWK4FwG8FC+yR3JR/uewQJDSbGWiZsOJ4tk2wwWImIRJRRrIizyN9btHpdOETmXW453QrmtFEmfkbEXe5UsTlG3trJ4Xrf4NEZsp7V0jpgPb4nJlv2PRdrbQn4fgkyLgXddSqx34TLJQ7UsDX2D9+FdXm34zVNa+N+2Pu5+w1xOx0ApC12acM5UvTSq8q9KVowHOxPo8dxSX6FIt+hV0nosNjfkk3HlI6TftRvaiBVIc3OygeTZLcGO0tEmcuJ2PHk/b6jC8P0ShnIjdZKgDDaJnDjEMFFok0zvEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm4AEV0COAMI/J5B99PfrbdjczRcNJUhS3S7M0nKwEk=;
 b=sp7P+NbhxgbIuS9GSHRH/n+1CDDuD+I0LxvRFrKPrseEYv4nCi51EQmBTr+UgW9wuivXP8SnSvLpkPUZZsmUkhJHjaii47EgsywifupUR2FvJNCmjMe4PXN+3FvGLD/WgdXyMBL6/YdrSqez4Qh13HELoZpWfmltrra/fI326LzGtbYPp08Jcfwe7VoxUMwsNTHtSDTHvvgSxNsC/uJWcgLB93n2xaNrY5TisFkbyf8UTcZGeboyuWS16jKzTXMdWFhH46wmAHDGgmru5RfKuq6cUBoIIhRyGrnnyb4OZwTrEZ98PE8HI0U1a35lG1Ni7OTSmFFJBEhlYvR33XJNQw==
Received: from SJ0PR13CA0097.namprd13.prod.outlook.com (2603:10b6:a03:2c5::12)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 17:32:36 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e0) by SJ0PR13CA0097.outlook.office365.com
 (2603:10b6:a03:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:24 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:17 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>, "Roger
 Quadros" <rogerq@kernel.org>, Tobias Waldekranz <tobias@waldekranz.com>,
	Danielle Ratson <danieller@nvidia.com>, Davide Caratti <dcaratti@redhat.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>
Subject: [RFC PATCH net-next mlxsw 05/14] selftests: forwarding: Move several selftests
Date: Mon, 25 Mar 2024 18:29:12 +0100
Message-ID: <e11dae1f62703059e9fc2240004288ac7cc15756.1711385795.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: aa134955-9e9a-4172-fc73-08dc4cf18f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+2dpjnNIrLr8eEKqC+Rhs3efPfFy6/70XcYvq6oLGM4LSPAtwBZTpWZoKVmtWDoJ4WOAjqqJzXW4rRpmAgqaHhIvXywd6dIM+Py6fJ5eE+YlnR17fvTRwu8eQDgTx1HJW9OOsTasKn8LnhedICK1F4LkZOWWdijXokoHc4rfTWiPoiXVWVebf6qAg5OKgrUVQUejzcQgMDpHSBsSEivNv9SU81YHJ6UDxp788hBbUfCUF69UTJ4aAosRNuHAPs/h8/xFOauK7n9vNbUiO765lWOTMtiE/UsVMdoo75lSirJjHka9eJbj5abpKIkdYmQDOO/bVyV4oAqnx+N10BD3igoX4WOwd5I0FmWFODi2ADgmSlDBdn3N7n6r5r47vZZ5V8sBXeoksOdSKbzJCky/tyQf12eK7eeVBh+7g9zbg6U8RNIXc0rWdmu5iRg6ZwiLoU9qFaBTYZGvilkjuGz5bre/O1gxvrnzIIsAfkblf5QSgBDgQ8LRYPNIN8q8kYHLJuzcORGVA4g2Mff+kleT/loeO9ZgRxPU++mz+3odBuAzRZifct4mlYFRZlJAndQqeQPG5Nhtbn2IoaWGP3NIkt9dt+l8pEdsHWkFqKRTf682ma7p0QCIr60PtlULHtX+CogmetOycTxE1ovu0ezdSFnEb3yqAHtxOsYorbIWquQUTaUNriBq5F5atOY+Fybwjwp4Kl70YgYethB+pqOfuBydCDib8xHsuWKU4nrJlYdcLHRlJJIXEl6CwI0v8ibx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:35.9649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa134955-9e9a-4172-fc73-08dc4cf18f9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

The tests in net/forwarding are generally expected to be HW-independent.
There are however several tests that, while not depending on any HW in
particular, nevertheless depend on being used on HW interfaces. Placing
these selftests to net/forwarding is confusing, because the selftest will
just report it can't be run on veth pairs. At the same time, placing them
to a particular driver's selftests subdirectory would be wrong.

Instead, add a new directory, drivers/net/hw, where these generic but HW
independent selftests should be placed. Move over several such tests
including one helper library.

Since typically these tests will not be expected to run, omit the directory
drivers/net/hw from the TARGETS list in selftests/Makefile. Retain a
Makefile in the new directory itself, so that a user can make -C into that
directory and act on those tests explicitly.

Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Danielle Ratson <danieller@nvidia.com>
Cc: Davide Caratti <dcaratti@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile | 25 +++++++++++++++++++
 .../net/hw}/devlink_port_split.py             |  0
 .../forwarding => drivers/net/hw}/ethtool.sh  |  3 ++-
 .../net/hw}/ethtool_extended_state.sh         |  3 ++-
 .../net/hw}/ethtool_lib.sh                    |  0
 .../net/hw}/ethtool_mm.sh                     |  3 ++-
 .../net/hw}/ethtool_rmon.sh                   |  3 ++-
 .../net/hw}/hw_stats_l3.sh                    |  3 ++-
 .../net/hw}/hw_stats_l3_gre.sh                |  5 ++--
 .../forwarding => drivers/net/hw}/loopback.sh |  5 ++--
 .../testing/selftests/drivers/net/hw/settings |  1 +
 tools/testing/selftests/net/Makefile          |  1 -
 .../testing/selftests/net/forwarding/Makefile |  8 ------
 13 files changed, 42 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/Makefile
 rename tools/testing/selftests/{net => drivers/net/hw}/devlink_port_split.py (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool.sh (98%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_extended_state.sh (96%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_lib.sh (100%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_mm.sh (99%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/ethtool_rmon.sh (97%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3.sh (99%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/hw_stats_l3_gre.sh (93%)
 rename tools/testing/selftests/{net/forwarding => drivers/net/hw}/loopback.sh (92%)
 create mode 100644 tools/testing/selftests/drivers/net/hw/settings

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
new file mode 100644
index 000000000000..2259a39a70ed
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = \
+	devlink_port_split.py \
+	ethtool.sh \
+	ethtool_extended_state.sh \
+	ethtool_mm.sh \
+	ethtool_rmon.sh \
+	hw_stats_l3.sh \
+	hw_stats_l3_gre.sh \
+	loopback.sh \
+	#
+
+TEST_FILES := \
+	ethtool_lib.sh \
+	#
+
+TEST_INCLUDES := \
+	../../../net/lib.sh \
+	../../../net/forwarding/lib.sh \
+	../../../net/forwarding/ipip_lib.sh \
+	../../../net/forwarding/tc_common.sh \
+	#
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/net/devlink_port_split.py b/tools/testing/selftests/drivers/net/hw/devlink_port_split.py
similarity index 100%
rename from tools/testing/selftests/net/devlink_port_split.py
rename to tools/testing/selftests/drivers/net/hw/devlink_port_split.py
diff --git a/tools/testing/selftests/net/forwarding/ethtool.sh b/tools/testing/selftests/drivers/net/hw/ethtool.sh
similarity index 98%
rename from tools/testing/selftests/net/forwarding/ethtool.sh
rename to tools/testing/selftests/drivers/net/hw/ethtool.sh
index aa2eafb7b243..187429670ee7 100755
--- a/tools/testing/selftests/net/forwarding/ethtool.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool.sh
@@ -10,7 +10,8 @@ ALL_TESTS="
 	different_speeds_autoneg_on
 "
 NUM_NETIFS=2
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source ethtool_lib.sh
 
 h1_create()
diff --git a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh b/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
similarity index 96%
rename from tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
rename to tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
index 17f89c3b7c02..b0f931260a27 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_extended_state.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
@@ -8,7 +8,8 @@ ALL_TESTS="
 "
 
 NUM_NETIFS=2
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 source ethtool_lib.sh
 
 TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
diff --git a/tools/testing/selftests/net/forwarding/ethtool_lib.sh b/tools/testing/selftests/drivers/net/hw/ethtool_lib.sh
similarity index 100%
rename from tools/testing/selftests/net/forwarding/ethtool_lib.sh
rename to tools/testing/selftests/drivers/net/hw/ethtool_lib.sh
diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
similarity index 99%
rename from tools/testing/selftests/net/forwarding/ethtool_mm.sh
rename to tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
index 50d5bfb17ef1..c301e735c8ab 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_mm.sh
@@ -14,7 +14,8 @@ ALL_TESTS="
 NUM_NETIFS=2
 REQUIRE_MZ=no
 PREEMPTIBLE_PRIO=0
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 traffic_test()
 {
diff --git a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
similarity index 97%
rename from tools/testing/selftests/net/forwarding/ethtool_rmon.sh
rename to tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 41a34a61f763..709433a4c886 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -7,7 +7,8 @@ ALL_TESTS="
 "
 
 NUM_NETIFS=2
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 ETH_FCS_LEN=4
 ETH_HLEN=$((6+6+2))
diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
similarity index 99%
rename from tools/testing/selftests/net/forwarding/hw_stats_l3.sh
rename to tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
index 48584a51388f..744760117005 100755
--- a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
@@ -48,7 +48,8 @@ ALL_TESTS="
 	test_double_enable
 "
 NUM_NETIFS=4
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 h1_create()
 {
diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
similarity index 93%
rename from tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
rename to tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
index 7594bbb49029..354be353455f 100755
--- a/tools/testing/selftests/net/forwarding/hw_stats_l3_gre.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
@@ -12,8 +12,9 @@ ALL_TESTS="
 	test_stats_tx
 "
 NUM_NETIFS=6
-source lib.sh
-source ipip_lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+source "$lib_dir"/../../../net/forwarding/ipip_lib.sh
 
 setup_prepare()
 {
diff --git a/tools/testing/selftests/net/forwarding/loopback.sh b/tools/testing/selftests/drivers/net/hw/loopback.sh
similarity index 92%
rename from tools/testing/selftests/net/forwarding/loopback.sh
rename to tools/testing/selftests/drivers/net/hw/loopback.sh
index 8f4057310b5b..5acc3ff820aa 100755
--- a/tools/testing/selftests/net/forwarding/loopback.sh
+++ b/tools/testing/selftests/drivers/net/hw/loopback.sh
@@ -6,8 +6,9 @@ ksft_skip=4
 
 ALL_TESTS="loopback_test"
 NUM_NETIFS=2
-source tc_common.sh
-source lib.sh
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/tc_common.sh
+source "$lib_dir"/../../../net/forwarding/lib.sh
 
 h1_create()
 {
diff --git a/tools/testing/selftests/drivers/net/hw/settings b/tools/testing/selftests/drivers/net/hw/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7b6918d5f4af..cb418a2346bc 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -20,7 +20,6 @@ TEST_PROGS += reuseaddr_ports_exhausted.sh
 TEST_PROGS += txtimestamp.sh
 TEST_PROGS += vrf-xfrm-tests.sh
 TEST_PROGS += rxtimestamp.sh
-TEST_PROGS += devlink_port_split.py
 TEST_PROGS += drop_monitor_tests.sh
 TEST_PROGS += vrf_route_leaking.sh
 TEST_PROGS += bareudp.sh
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 535865b3d1d6..56e3557ba8a6 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -15,18 +15,12 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	bridge_vlan_unaware.sh \
 	custom_multipath_hash.sh \
 	dual_vxlan_bridge.sh \
-	ethtool_extended_state.sh \
-	ethtool_mm.sh \
-	ethtool_rmon.sh \
-	ethtool.sh \
 	gre_custom_multipath_hash.sh \
 	gre_inner_v4_multipath.sh \
 	gre_inner_v6_multipath.sh \
 	gre_multipath_nh_res.sh \
 	gre_multipath_nh.sh \
 	gre_multipath.sh \
-	hw_stats_l3.sh \
-	hw_stats_l3_gre.sh \
 	ip6_forward_instats_vrf.sh \
 	ip6gre_custom_multipath_hash.sh \
 	ip6gre_flat_key.sh \
@@ -44,7 +38,6 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	ipip_hier_gre_keys.sh \
 	ipip_hier_gre.sh \
 	local_termination.sh \
-	loopback.sh \
 	mirror_gre_bound.sh \
 	mirror_gre_bridge_1d.sh \
 	mirror_gre_bridge_1d_vlan.sh \
@@ -113,7 +106,6 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	vxlan_symmetric.sh
 
 TEST_FILES := devlink_lib.sh \
-	ethtool_lib.sh \
 	fib_offload_lib.sh \
 	forwarding.config.sample \
 	ip6gre_lib.sh \
-- 
2.43.0


