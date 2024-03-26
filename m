Return-Path: <linux-kselftest+bounces-6643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09988CA00
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA262B25D06
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7613D532;
	Tue, 26 Mar 2024 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FGUoHAQx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BC12BF04;
	Tue, 26 Mar 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472473; cv=fail; b=iXrwv8/cAI1yaM0PyUw7wWANdNIbnBeM3cw7v/jCaRPox81zs2rp0vHPKsrfIkC35ONR+XQWCrcU1spWqrB3jO/+Iy/viBOSz0yCUanCY+L/9eX0gpLGeSjjQjtxQzcPEyt8FqOEMjHgRctetvX52F4CdZEBhZtHw+AD21xa3Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472473; c=relaxed/simple;
	bh=eD6MQvEub5I3N8qgmWskGamI76El+pptE4/SO3GYmAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGw/ARqVQu6LpVSAKw9Ie6cyuUuk2ITimKGJIvGWaOtNRbP6Rb2LJIKdVQZLjfkADSppfnXpJRLzFdk09WKzwAuXogLaWQ6DMwiZKIdr4MS0ybVMpglBYgPoIl1eeYEjJ1oPnSEVofWO7XDE2kyHEnZLsXNSfEGFBDjG2kltmC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FGUoHAQx; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFNHG9gmMsTh+9x+RpnJP7esIgmq2KhuzJal0BXNrWmk1EJog9oHFnkC2KVqltU1NUqbpMGvSk7V4FAGbV/qfhYhO/keNoOE5B6gcMlCmMJtZXn0NMb3Eyp5V0qoDV2hkqHpAgF2c4OCJuYOp1z9llweIUfYN8pkzlRid4XxlgY63why1pXJYWyAO5yvS2NT6dju0n7gBSfL2cRgIMCbXGugG18FkipQiulA2pvcjcKYLLaZo3JLCVHeoDULk94mhDK6mCwyakkaLlpML+3t9ev9MddGHFFT0c4o3bETnbTw2s/BJivVUWrizF/JJBef+Iox5eGBt11Df0P6oeIepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vm4AEV0COAMI/J5B99PfrbdjczRcNJUhS3S7M0nKwEk=;
 b=QG/8DjoyZjYoJm86lG4n9NTUzdPe02sKBwpXo6eXUs5/SnM9WGI5lWjv9jzlzYPP5q9YKEsvRs1OxZrlfkLdy+gImMtWTPUpGzf9owiedKPEpQWGwtyygOm9T2UQsylHW+ridy/1U39RS6ef+QW25kFbfkIlkoUgFYbzq1BA57vmsRvZ+gPDGerG3JvTGmYB6vLl3GsQMSu7hTsQqyas2u0FEjAjNHqk5X++L7MpxmntmGgwXfZ+RTvtqV1/ayixwoZlfpA09gkhQx4GgEuzCzEmwDTmb3k77btok+8CQgxHfeFWhkJDRoWNb0cfRPP2EguGOb+Ug9UdOM9OI/nv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vm4AEV0COAMI/J5B99PfrbdjczRcNJUhS3S7M0nKwEk=;
 b=FGUoHAQxjl7s39sbaBOaiatgYuLpxix66Gfv0aSk3jOYVkCaddtDoeQr2ifrPG56qpemArVKUEcf4SF4dBC/18xoP4WqEuMqqkPKIbIpIplubMmDcddFkE90oh0RUY57nSmL3ZYPVVe4pPn24NWnfhreBRivzCbrt9SKvoQi2GDYdg1LX3gdPkQje0sKUtQpxFMSqA0iwwV7xvAWPSSn1XlH4VUs5XlME7J4jPkWGbGYqzE4rYOOXRcNu/gHx6Ine4asf1jFHnYPIQyvNaUxO7BSDIQBJrQUmwwETVqC7p5tIRXCqZ0tEZyzRnDJg4UBDiOCTeE3W8VQySQyGzGlYQ==
Received: from CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 17:01:02 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::cd) by CH2PR16CA0025.outlook.office365.com
 (2603:10b6:610:50::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:35 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Roger Quadros <rogerq@kernel.org>, Tobias Waldekranz
	<tobias@waldekranz.com>, Danielle Ratson <danieller@nvidia.com>, "Davide
 Caratti" <dcaratti@redhat.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>
Subject: [PATCH net-next 05/14] selftests: forwarding: Move several selftests
Date: Tue, 26 Mar 2024 17:54:32 +0100
Message-ID: <e11dae1f62703059e9fc2240004288ac7cc15756.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e7b03f-a773-40a5-5e11-08dc4db6512f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iGc3kWxOST7S5/pUve71G+5dWB3m5M+fcX7PyYyLoZdL7Aww//0rj/lZAIRWhzCfS6P/foenygAKnfyEXf7jYdh1ZZLH3ikRk0gBhcODbcJw3NvLrcDxyulOCX68yGQttquTPpjcVZDwWqnKbKzAh3L1MjbDy+o3mHyrlWQzq8qxT2mA/YRig2EcOiCQq4MjHVTFB118ndm7hWe7GsTKCFfmGw+rLLdwpUJ6MsbDVXBytmcte/QIWLlinjfGIh3upAIzeJFE5FQ5AWG4Al2/wOGEGBw9kKDRQDxpLLsul2/+bOZNWiLYgpmjIkmYxW78cfEMc828R+7f2277dhM2STp8CfpkwCt7cplh5mjXLev/sV6ZWzSiFyDbNrgIBj5OxhIa6t+1sgUSBClOyhGYyu1aYTx4Un/aOS4SAI4192UOM1RVSm3I/fyWGlq6dY5uDHca2eFhZUsOIgmLjb+/KhrPa/5cflNYVfBJFZGhBKXMqNfG/kp8aAB5X1/3bjo0tLnvxYE95urnKYaWHVYbdWktm/oByjWbiBGkywiJ2UrYr96SbVds+zMAqy5WoEimowjDUZT6PJSJvluMOqlg/SdZ727YL0itXh78lzGwrn3gcDrykhAUNbEX8KrFwTMn5deJbbU8m+jte09eqqbsin/rQ+IvyoHbxgAk6wfC5RaCtREGmEmG2b1Iiy5wwQdzT0E+/xsmfS2AvTIZrxPj471NS7vmj3bYHdpODgkXN1aXoBDX9oAgCyWMu67rm1ab
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:01.9650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e7b03f-a773-40a5-5e11-08dc4db6512f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

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


