Return-Path: <linux-kselftest+bounces-6651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB75788CA1D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D280B26FED
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D713D517;
	Tue, 26 Mar 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7zgNVpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679BF13D519;
	Tue, 26 Mar 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472528; cv=fail; b=fooV6T67rcHJPTGRcD22BQzZgEvcRfx0rA823kA30j12gkaZiEQztsFES+mEISHkygVGz0qg446Um6jOUafy0wmt4BnsVPB5a6eG+1L8ZVrteHcKYePERjLLvwYf7Lm9FSvYr1ivbbDsjpiJTayAcgXt/2FmVFVPjkb+yAVX4Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472528; c=relaxed/simple;
	bh=+e09gFd1Ey7yx9/ihKE4m8zZz7PlKXX2DE515T37eBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAR0+yaRdDk/xRGVOIXh0ePNrXk60WvA5XcvpRQRW6OMjRawx7p3P3bpCMdiBxfODLoNqoYFhGQzxSXLTbabHOSewX4TFk8dzBpYTEFpec9lJoGxKOJ++Y4GnkPabg8Yrrvw0lSZaAz2MKLfwhhBG0fqdMMEV79IDlsOYWwjZM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7zgNVpM; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUu2LjinVDFxej0twGpCL6LIrfz+pi375a9Xep7p1BzVzqSi6k/c4r2tjvv7NA+3CtQOXaOSaQHMCj5rCWy+6OcqylgxxfNMTxL6QH6P7mpcEVW5GNBV7UjBtwDWNJCiqj+psNQX12S4qy7o7EFHYuAiYRAN0SVYwFg1sTTpM0O2tK1z4yNFIw5RG4vlQ0ckb2xYZZMGlj9Gm2uxfJrj4FxBAMpgLFGBTRJE+kTiGylRC2o0IjUsQnLf1D90WJbE0WAJdPJJtszYrjXnO8JEAUpcf2T0r9qVmb2EzVPRD+fKqrq7qz/1nsqW55l6O48/dpRQo1zxKMkJewd09uxTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7sbgzMJiAtzTUrgb5Sbt851ursJ6UfzsRURrAyQZwU=;
 b=CPggptNxHA/Bme7HNkgRoZMBL/bxiWlLHIh8kKG4lhrF2y1mImdfRqYKfKbeZRw97nZFiNsHl9awCDTSiZkgHWcqOcaLpEgVDF/86t/yFbvQ2OC86b4MzmNVKz9w9vPAC1t2MOvg1HbDqXAYLMAf1on8/skchSwgtnhi1KLleFYtZfqOanPiKDGRghegEBX6bHnF5f6VQCrd6BAXqssL/1gYbagmObMVGJ8VwAx9l1lydu9/GoDFxQ4YQ4noekDaE69midAwqY243Vrp6q7mq7qf15SN2sIImBL02D7lCZAmoOwbtBaR8PVLKJuoaM8IzV/v6rz0Vxho0bjibN/mgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7sbgzMJiAtzTUrgb5Sbt851ursJ6UfzsRURrAyQZwU=;
 b=E7zgNVpM1CbxpN+yQk8DCM5A7DacnxpkHfpDoY1i8Iag2DtCfj7oBhNrLlf2gQLcuelEvSxQWvsUyuZWg7BBbGOhIyTp+U0dKAZ3HcF80nsIdVOgzqqWjaG+lrxhjOcsbmSrq3UEoRy6be8HaMqqqBkCzRlPSEDloC5Jy1icXOhIdzpuV7SGvAE9LmszuUQooNN9EOU40a4NbG10espyFQHM+TKRDL7hDiaCPwjYMTfMZn6514BZ68qoSreMlQmzERkj7eWbWjSAgUQWOR7da3KzxIvLdAAhy2ltcYJXQtwn7GSCZ5W46t4OYLvjZG+NkapZRfj33bUivpS80ogMGw==
Received: from BN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:e4::34)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 17:01:59 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::79) by BN0PR02CA0029.outlook.office365.com
 (2603:10b6:408:e4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:26 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:01:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 13/14] selftests: forwarding: router_mpath_nh_lib: Don't skip, xfail on veth
Date: Tue, 26 Mar 2024 17:54:40 +0100
Message-ID: <15f0ab9637aa0497f164ec30e83c1c8f53d53719.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a55ff65-c566-4ebf-de51-08dc4db67306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qHUY+KNp2G3x7VwAz8hhrN7nJdUSOscyrWLCcs4uawTG50LV6ucVyyoiIdTDagHCqUMX17m2FOdFveRHBI/r4wsUC9cxrHXCoyLxsatpzTXRIyuJgQDX45xe4MWLA7uP8Re+NkiwRajOa+bbVuVUoF+/4vVXNL8gG7cPCHoFAbQLJc0Q4vAMJkWDpZ7OY2s5n+4FmgqF0NrVmOmbmsmh9h2SIdHwVBT+pMFSr2JxRL16OG0gP7xA80p3/s8A/3Dtg4MW/F2e7QWx82jmfy/4eaehOagePanmZ7oA1ljpnGcHHSp+SY08fC5OOKyxW1xWtl9RtXL4fyhIzPaaC7cLFrrKZp8HkgKTevkxO6fJbggnZjPROYMni0q4O4RMveMHVCs20Hfl74kWr/QmkuAY5X0PIGM4gJih5iP0mgya9LfxfuYlj6QbOUtBcaxqT2Y9A0Dt/Vzr4b2y/RKWvV0QQ0PS59HqcqYtNV3vWaPaNSGE7yVHbe28JjE0rorfvU9UMmKw5nPpcmHXol/xChRZirqAGvdML3SxUUvICuFIzyTpvwJ8IdlHfQsY4bWSBBtDETOJa6BUokItH/sbmybV/S8fJgDWIlfl6oAhd1Jz3HelRgfVSoSJATSAekA7LX1p97/mdPFuXNfFAB+NxXaR6Q60yaSBbcrsywGNcCaqNnDdmBtvcGNpHV00IHY4s27uGSDMTFfoX41+btmICUhRawxH7Fv8M5lBSt4h1g0dCIRz48JAF6h3g/nub+e+YENd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:58.6953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a55ff65-c566-4ebf-de51-08dc4db67306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

When the NH group stats tests are currently run on a veth topology, the
HW-stats leg of each test is SKIP'ped. But kernel networking CI interprets
skips as a sign that tooling is missing, and prompts maintainer
investigation. Lack of capability to pass a test should be expressed as
XFAIL.

Selftests that require HW should normally be put in drivers/net/hw, but
doing so for the NH counter selftests would just lead to a lot of
duplicity.

So instead, introduce a helper, xfail_on_veth(), which can be used to mark
selftests that should XFAIL instead of FAILing when run on a veth topology.
On non-veth topology, they don't do anything.

Use the helper in the HW-stats part of router_mpath_nh_lib selftest.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh      | 14 ++++++++++++++
 .../net/forwarding/router_mpath_nh_lib.sh          | 12 +-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 58df57855bff..4103ed7afcde 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -459,6 +459,20 @@ xfail_on_slow()
 	fi
 }
 
+xfail_on_veth()
+{
+	local dev=$1; shift
+	local kind
+
+	kind=$(ip -j -d link show dev $dev |
+			jq -r '.[].linkinfo.info_kind')
+	if [[ $kind = veth ]]; then
+		FAIL_TO_XFAIL=yes "$@"
+	else
+		"$@"
+	fi
+}
+
 log_test_result()
 {
 	local test_name=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index b2d2c6cecc01..2903294d8bca 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -56,21 +56,12 @@ nh_stats_test_dispatch_swhw()
 	local group_id=$1; shift
 	local mz="$@"
 
-	local used
-
 	nh_stats_do_test "$what" "$nh1_id" "$nh2_id" "$group_id" \
 			 nh_stats_get "${mz[@]}"
 
-	used=$(ip -s -j -d nexthop show id $group_id |
-		   jq '.[].hw_stats.used')
-	kind=$(ip -j -d link show dev $rp11 |
-		   jq -r '.[].linkinfo.info_kind')
-	if [[ $used == true ]]; then
+	xfail_on_veth $rp11 \
 		nh_stats_do_test "HW $what" "$nh1_id" "$nh2_id" "$group_id" \
 				 nh_stats_get_hw "${mz[@]}"
-	elif [[ $kind == veth ]]; then
-		log_test_xfail "HW stats not offloaded on veth topology"
-	fi
 }
 
 nh_stats_test_dispatch()
@@ -83,7 +74,6 @@ nh_stats_test_dispatch()
 	local mz="$@"
 
 	local enabled
-	local kind
 
 	if ! ip nexthop help 2>&1 | grep -q hw_stats; then
 		log_test_skip "NH stats test: ip doesn't support HW stats"
-- 
2.43.0


