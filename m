Return-Path: <linux-kselftest+bounces-6645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1183888CA06
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCF7B231B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCDE13D611;
	Tue, 26 Mar 2024 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dqQ2LYF+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9713D508;
	Tue, 26 Mar 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472490; cv=fail; b=I4gRmfO1Vq1nw4KVTIJUtIsRi5fQYfcK8kxIpHrGPKa0SG44FVLm2rP61w9+t9pov0I+fqcwGy1pVLAAeVMsXZ7S6fegrykR+zoA4HGI/umN4m75wznuD7q4PSmbfGEvYlQsr2n6GqySz6dmN6eJDvXO0pgilw+xDhND5GrfXjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472490; c=relaxed/simple;
	bh=MxJe5u4kKh1gF0M8vK+ZVWbNyh5kNSewZOLFJ5VB0m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptcH1T1q4gWgLt3zKXKjpiknHDZB4E4jEirhUXfcG89YiCAmTCOq0mEfCMDFznI/Ib1Z2lx3sO76t5Y3weip+Ac/WP1j1YzTGCkItgX774p30q+KS8m5q0GUmC8tD55ufRcxvr9eA8at5VXsb3YE4F5msN7WcM3qDCA9iBl80DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dqQ2LYF+; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpAPQW2Z/YYnJHq8ZoNCbO5VKJ1Hkv7XuUYNEvT/Mxwd/L9Kdb2QqOWXVJbtXmdCmaH+UmFFEepH53CSmZRb19WyfBEiEET1HcvYascQzbXP9qyaaX6OPI0vYsnGzmxB6SovBLfzlLa3pslTMmktk6brrBrnZ/ryaEQwF/srWAh6tWDlw2etf7iwhMnpwT4UH+pldSS+Wz+u9FtRjQts5Kfjjl+ckfVnHlOOhb7okuRZGl+6AE9Hhz8mZhJSQ5EnNFZb1V6cG06YfejHPJ6KjzivLRns3BqhuWuVQSG7krViWbOBtk3FS2ZUnHeFVbhNsCWXNs3WVGxRSaatlHTf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmLUvKFraZqK99YQ3BehQvq+UYAaDsAUcKG2ZujckoI=;
 b=PziCKnSoxr15hNXsdQZdjvodQmS8IApeaszUHECksaWN8KYtNIP/ZPexXjjI55om0AG/fWOeaL2q+EuNy9RxiYsowmDM7KfYRNNWixhityD+4a/K8BdYUHBT79NNZiJTR7qimuBit7MPWh51mNnaZsHYgIIOAOiUmJSK5l89Vla/d+NCESUurRT0ScIuVI9zBNxQjupBQQbFptcgJ+yCZldpidg7BxTfocsMD4kZPLpYNhAxVhYHpTzv3orNYzSljTosFvzUqSHWemfhuWpJeCWRQqwfRHw869lwgOlV14aOrKMd2PNdJ/lAAay3/Sk90/sQAdVaC6Umi441CpbcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmLUvKFraZqK99YQ3BehQvq+UYAaDsAUcKG2ZujckoI=;
 b=dqQ2LYF+nqUNIPtcGfF20vfT1Lh7tSkPOWPwyIUPaHIOtfhgZQbP5JYo/R3jWtAgTX01SYxzO2WpyVfXnAnq4BtzDiqIAjxB3UxQUriPiH/CYDQ+RW25olqz6D5v44WY9WgzO+79kHH1/pSY8mn6kGtDG0WGC3aV3ApQvY89zR49BHZpZtYtxc5xGFr2MYKg0JJlpiea4koM1pxE8pvVFIA2hwdr9CC85ksSu9MvZPViv/5Mp00sFm3c+Ry0UhpvDzpVFMuUolsI7ph0k4c/MWdLkF+S1w92SREhiC5nz44amE/G5AwovL16oY6x+mwn6w8bo7hGBNZGSGJxygo64w==
Received: from BN9PR03CA0112.namprd03.prod.outlook.com (2603:10b6:408:fd::27)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 17:01:21 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::c0) by BN9PR03CA0112.outlook.office365.com
 (2603:10b6:408:fd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:48 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:43 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH net-next 07/14] selftests: forwarding: Change inappropriate log_test_skip() calls
Date: Tue, 26 Mar 2024 17:54:34 +0100
Message-ID: <3d668d8fb6fa0d9eeb47ce6d9e54114348c7c179.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: d660fcdb-7b9f-4931-703b-08dc4db65c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/NBVky3AkCSdQPTy3WCXEjFy5zcG6tTjCmJi8R2NUJz4xR5x0V+P9e2dZHaaEz0S0gkuGp0XfTuEjSZEEa7Io37KHr7vYfMyNC2gzq4IZjtFFcsMNSXZlz6A+CN7niJz0oov9YV/n1B7taJK8o67yEkRn1YntyVDhymhP2eDQS7f0JinG80LeMGgCqA2ldCZBfYsWwDfYE56+hzG7gOgCYGOKrAZSxcxAdBBhmnt+qPIUC+Ynip+V4yzsQXkR5TaK+s7l+mUA/IdivdUqmtiq4dZQi0GlQZ4zHIiMEIy4kGY26wA4xcBMbocc3NqmDuIG8SV6w6EXi28B3iW0sZETuseR2CHWloPalf1P3hnRMy2/GnKVybe6PwEkcxzOqpftJcMqGHpJfaGaEbQ6a64GsoZ1An7ObPNttajSK78WY8epByZ+2wI0RPCFNNWgpFr+pdL1NStJb8n1DjN7Y03CkomVXU34MZBZJ03xgqHR6pk+JFKEqTMbPMYgNR8mbkD2q9DG0zaAGIHisbUHEjBwWTV+8ctKahdnLpb9p4Pafq2xDrnM3bXRI69VqUIuW3AZA/OvOH2dD9aKVN/CHL7b9Iid708aF+4J0f31dpk7dqLUng4mhu4yvbUS4bdDZ66hdUsMCe6xbj8nRnC2allxRrkceV5Y/6924FSIH4ptrFb+587bAKciMwt+I/JOXBr0c7bPiLa3Yppuh5GST58m+eEMXdPHNYL9t0AKDI0bH86Fn1zq3KBCoh3KhI6ZnLY
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:20.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d660fcdb-7b9f-4931-703b-08dc4db65c5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424

The SKIP return should be used for cases where tooling of the machine under
test is lacking. For cases where HW is lacking, the appropriate outcome is
XFAIL.

This is the case with ethtool_rmon and mlxsw_lib. For these, introduce a
new helper, log_test_xfail().

Do the same for router_mpath_nh_lib. Note that it will be fixed using a
more reusable way in a following patch.

For the two resource_scale selftests, the log should simply not be written,
because there is no problem.

Cc: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh   | 4 ++--
 tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh   | 2 +-
 .../drivers/net/mlxsw/spectrum-2/resource_scale.sh       | 1 -
 .../drivers/net/mlxsw/spectrum/resource_scale.sh         | 1 -
 tools/testing/selftests/net/forwarding/lib.sh            | 9 +++++++++
 .../selftests/net/forwarding/router_mpath_nh_lib.sh      | 2 +-
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
index 709433a4c886..e2a1c10d3503 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
@@ -79,7 +79,7 @@ rmon_histogram()
 
 		for if in $iface $neigh; do
 			if ! ensure_mtu $if ${bucket[0]}; then
-				log_test_skip "$if does not support the required MTU for $step"
+				log_test_xfail "$if does not support the required MTU for $step"
 				return
 			fi
 		done
@@ -94,7 +94,7 @@ rmon_histogram()
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ $nbuckets -eq 0 ]; then
-		log_test_skip "$iface does not support $set histogram counters"
+		log_test_xfail "$iface does not support $set histogram counters"
 		return
 	fi
 }
diff --git a/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh b/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
index 6369927e9c37..48395cfd4f95 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
@@ -42,7 +42,7 @@ __mlxsw_only_on_spectrum()
 	local src=$1; shift
 
 	if ! mlxsw_on_spectrum "$rev"; then
-		log_test_skip $src:$caller "(Spectrum-$rev only)"
+		log_test_xfail $src:$caller "(Spectrum-$rev only)"
 		return 1
 	fi
 }
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
index a88d8a8c85f2..899b6892603f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
@@ -47,7 +47,6 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 		RET=0
 		target=$(${current_test}_get_target "$should_fail")
 		if ((target == 0)); then
-			log_test_skip "'$current_test' should_fail=$should_fail test"
 			continue
 		fi
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
index f981c957f097..482ebb744eba 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
@@ -52,7 +52,6 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 			RET=0
 			target=$(${current_test}_get_target "$should_fail")
 			if ((target == 0)); then
-				log_test_skip "'$current_test' [$profile] should_fail=$should_fail test"
 				continue
 			fi
 			${current_test}_setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ca433ba3612e..5415b8d29862 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -467,6 +467,15 @@ log_test_skip()
 	return 0
 }
 
+log_test_xfail()
+{
+	local test_name=$1
+	local opt_str=$2
+
+	printf "TEST: %-60s  [XFAIL]\n" "$test_name $opt_str"
+	return 0
+}
+
 log_info()
 {
 	local msg=$1
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index 7e7d62161c34..b2d2c6cecc01 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -69,7 +69,7 @@ nh_stats_test_dispatch_swhw()
 		nh_stats_do_test "HW $what" "$nh1_id" "$nh2_id" "$group_id" \
 				 nh_stats_get_hw "${mz[@]}"
 	elif [[ $kind == veth ]]; then
-		log_test_skip "HW stats not offloaded on veth topology"
+		log_test_xfail "HW stats not offloaded on veth topology"
 	fi
 }
 
-- 
2.43.0


