Return-Path: <linux-kselftest+bounces-6560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8FA88AD1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB7D1C3B0BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C422131BD7;
	Mon, 25 Mar 2024 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrJN6UiS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A62D762FF
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387981; cv=fail; b=QqUUSovUAlaZaha+XG8byjkusg0xQS3X0FSbb9JMywvgcWPeeOFhFiVprpWVxU0QF6zntBlXlZntt+iQ3Ar6bLYh8NKSY1SpxPrC9KI3RGNtIhYL4uWPFQaz1ZPDYDxPIGtY0OVobTxeg1iZD/dMaIS+MaIOwEs3NDU6lIzPiXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387981; c=relaxed/simple;
	bh=MxJe5u4kKh1gF0M8vK+ZVWbNyh5kNSewZOLFJ5VB0m0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uV6nfw3Z7GTGNHsQ4BwP+QkG97pFlm96ozwsnlU3KLcvfIumtZ5eQKNhpbEMqObSwvcwJKxUKNNjfAW2Z+DNw6SY1iiYf95STAKdYWmBVlVBlVepEfpRExcHu5JlcdnH6NoglyLvCJbexpy77rEp/RHFMZTEGKqQOAQ8paljy9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrJN6UiS; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN77hI8bF8UutKUlrGtsfaXADfmT4V83M9l6aGdHfNauK/r2toyn0J2sKepHCtswrpvJ0zyVizZwjv0FxvkhIxGYvIjkw+Vb+0ZY80iB4dEcWvJMOfq7TPh+Hb9/YDcFimbV9BWXC3j3AJTlUvlfNyOuEn0NFKu6gJN7MA2wEu6APqyb12k3lRCwtZ2OfvjwGQpys2WQn8bp/Xv0kvPW7gEMbNm/mXMT/0jlrGwg8LT4XGAk7cVJaAi3lALgLoRJ94VJR4AHys+BbL19QhylFwfjzHzbvnnovWzY/SihBuq8ib5mu+gZugFCTl4c2/yvWkpchWbHPSTBT8AnJmgbhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmLUvKFraZqK99YQ3BehQvq+UYAaDsAUcKG2ZujckoI=;
 b=KKrfcfKRyIX1LbwjlM4hFvvJ6U+/oaseQhl90xOvQAKi3KLOQlOptnKw9hm+HJZFcjGPg8goZdg0ILTWl6zQiVhXebVoKya3jj+Nf5eScohRv/wAiFWn/vs8gM/a+5sAlSxVS3H+sF9KFl6u1nrWie+Jq0vl3d3Q4PvKeM4+a/HdPOMpWDap7bsS7SJdDlXOMRCnusKSxqYZIMnbUjZtvrA3WUUORa8cBiScJ/Fb21xlK5+JSvWWBnHszJkkCzJmvKR9sBVuHXaAdUsu/jthBHcjr3eaAhNRrvzHbBYJRAWbnqli9aHWctL8edlcj09QWqc+pBmqg5r4ZcbWBPzLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmLUvKFraZqK99YQ3BehQvq+UYAaDsAUcKG2ZujckoI=;
 b=lrJN6UiSHEcPqtz9LGetakYQ1RfbxK8Ex3vzK3SVSTyEGr0xSyU0cntfleI0Limex62xLukyh23rB0SOAUSeCgl4dr/YwtHKpCXtDQ4udD0lKHNHn0MF1LKcrduFl7kaBG8OPgtGYqJuHooXS/oJdpMlw+HheCMyLkNKlF7Ek0ertEM2PqZMzrULIpDuRshT9VUl8bq+lC+Zmp1cBvHueSkEiBQ233XwCjbOgMAeMBjYnHouzaSNBazFU4TEwkN2C7kFsAq8mY8Bz0dDp4kujd5NebwPGLNIiTjpjZlP99rYIwZWwJ+u2AoKTWcd0XiUVubhDep9aBeMZ3KcDBI3Vg==
Received: from SA9PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:21::25)
 by DS7PR12MB5862.namprd12.prod.outlook.com (2603:10b6:8:79::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.32; Mon, 25 Mar 2024 17:32:55 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:21:cafe::c4) by SA9PR13CA0020.outlook.office365.com
 (2603:10b6:806:21::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:36 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:30 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>, "Tobias
 Waldekranz" <tobias@waldekranz.com>
Subject: [RFC PATCH net-next mlxsw 07/14] selftests: forwarding: Change inappropriate log_test_skip() calls
Date: Mon, 25 Mar 2024 18:29:14 +0100
Message-ID: <3d668d8fb6fa0d9eeb47ce6d9e54114348c7c179.1711385796.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|DS7PR12MB5862:EE_
X-MS-Office365-Filtering-Correlation-Id: 867eaab2-f05f-4bb6-9023-08dc4cf19b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dGJXKSG1j5fKm/p+C8W5IXbhCnVIH68PFXVDm2vr1h09Qyn1DQ7lwGwdRrXVbKkIuysEl+wCQ74wklJn5WSNE6+Nub+kLNfwM+TmgMcH6HIQI6D7jf0Vrcyo0yHlQ1huw1jG7zAznhzpRnA3vabUYxj5fJ0Hr4mfTpukcNaaz4JtqA1zjLd/i2QaeSMBK3CR68EtMGVVCECMszBWxbzcY9c6D+LfdgsA2OV8ucSWJdDGuCX53Gk0JhSuCpGov7wHV45CFvye2AcAg3aGnMqrFUdhgk3apnLgzhuKUQf+hbq7gS+iGRYGWBIvVEZR9WHe/LrkSlPZoxfAKhl4djynlniH7AKZbl7RDZZeBWJLg/D9zhnWnBVEK9dq4CSM3/RyXZng+C3ohf0ME+WYcyPZcQd+s0LeiCz2kkwR8MQG33oPirkYF1E6PS+pvJ5/ugThinKjrB0njJfc7HTHJStJg3hkSeI5BAlgufiwnBwpDrOhkCJFi9VlN7DnbJWKlWdCK86cYnuiR5OLC06ANuH4dI+7kNCO29lOzg2PJ3RVLO4u17eCflGPCr1gRdTAg1uS4gwFLZIQpyl0PoNJtEHpcp20ZAXaa0I6jyVTY6748Bo1ttdKn87N7YMCX/QqoH6Yl9ZIVpSIb2G3FOGPc8g+IXh8BUnchExYgmyrxQ/njWR5RdVo4Y8heapdpZ+2CRpd8WvdcNIg3CdnAf555dj+u793oyrVNhHeGIhOVHfMoy97xMB0uVkjQH9FQiA2R30p
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:55.3562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867eaab2-f05f-4bb6-9023-08dc4cf19b3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5862

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


