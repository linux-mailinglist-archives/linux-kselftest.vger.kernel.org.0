Return-Path: <linux-kselftest+bounces-6644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5C88CA01
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A82303DF5
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1013D52F;
	Tue, 26 Mar 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PFBW3m2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73913D504;
	Tue, 26 Mar 2024 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472479; cv=fail; b=TgupLOcoLC++N6AjqnZgDJs01PejYzCeH6brb+Z+Q4neimXXvznaGVSwI+YS53wPlGN+TUMRZGDsp+J/ipnzk4Gxr1mIcQgjfJEV+9x+3K0na+WZN8vAQzAoDka+hS/vRy+bnm0Z7I8vuDmurc8kRhlEVqrC3u3izXJkAgL1fuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472479; c=relaxed/simple;
	bh=AZUSMPjiXcvxzVlj7PylF6NCcBvM5lAT79psV9iJqgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj0OWAv55KwYbxP1ob93+NdsNN+77k2c8LGHqaEYIzaN0Nji9zOptIXeH4cq9OxZX6ztSxeucY1cJ0/8tXQtejUdjO7VSx724pTFdqXiquduHWhSpTe20qg/l/wc+bEfom2LZucunnV6V/n18tSWPdORra8FMivZd8LB3+7hdfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PFBW3m2B; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih7f2dqtEjuMduv0zRkW+9PycnbVgJQatVyf/mxyUTiA77jtpbdP60a1eS7riIexK/l/78N3V0PCwr229YkttHtWYNr/jgbbkEFmKgHEewdtteAYU45p2fkkbKknzzynRmHFtFDMe4Tr/6Ah5TofzS/2JPThJxG5zypcFhT5K+NL+9cGqF1doOw5PFe5MfqJmSOTh0X2mEO4Cc0BRWoH1rrHqG0raA84bVUFz76LiH8mPH8ssun7M9k3C651tcha1djnsRrAZlzerY7XJe2SZF+oLRDOqVQw1SImVr/s/KuBzpJKRDOE2IHiajUVNKWa687ZeI2g3RBPlU+2gShJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mCdfpmuRZSleSTsXITlCnaK2+7xoOs+UANN5D6l938=;
 b=AGLNOJu6wgL2jQqHJRPE9tAtsim3aPlGP/1Awgw7VPjXnDeYBvaVXymyhcPkX7CpC28zBbDkXtFhezHxaV/x0nmlAFQ1ksfGnh8JaKK3rbiDXcVozgfOWb1Kzw7aDOX8QgA/6d/UBoyF+ZLh8lYDVh1r2BqudUbfWz2o0uiDb7smaxjlBZveuLd/IFZLtJmzIaDrIc8FrOg9ETiYE/tLAgA/IKT4LQBLMDhfOMOcqIdR/Ju1kNQ47cvh9MLWqC2eb1ozBTTy/1qjIjLgZ7/k6ijsv3vFW4dF0dTPcRYoOpVCl82Asn3zo3UmTVR9coSZJ+mIc5rimGLvBAzg0VtAsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mCdfpmuRZSleSTsXITlCnaK2+7xoOs+UANN5D6l938=;
 b=PFBW3m2BQ7kljUTOGOb1XoYRf/zcwog+Yrm4/jFThPs8uRiuCPkLlk2n9MXy2FKSNuAatYIxsc4xbxC2oAb5FzEGwNaO53AwKBRDm1cApoYPi2Rt7+YmjRzbAMAzGVKybcuXYh2TUs2JijDsMBNkD/CbGi4HaiyMz/Qk9aDRTPVksb3DPjJ1tz62Mi19DavgbiMQ9v9aFbMwOZanTNpo9nbBcwuQ8Uj0SQwo10up1xqdsgt6VYhCcsz5Gh72F40gIxzNmqaCabmriPQIGiTv6/saXP+LDBqK4iSbOTRspnYqq11rnZ5RWAJVcX5O/BUGKtkXNqlqhAHp0blcnzcGbQ==
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by SN7PR12MB7300.namprd12.prod.outlook.com (2603:10b6:806:298::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Tue, 26 Mar
 2024 17:01:12 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::9c) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:00:42 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 06/14] selftests: forwarding: Ditch skip_on_veth()
Date: Tue, 26 Mar 2024 17:54:33 +0100
Message-ID: <63b470e10d65270571ee7de709b31672ce314872.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SN7PR12MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 314f0862-be5c-448a-a224-08dc4db656ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qlh0sQBSdFCn0NcWg0EDlR7TrClsyFwFZdir4PFZ7P4/8RuLPTlh+lyCrmJ9Ce62llsMblVtFayLE7eJjlVMkCKqlrICWJgu8zaGjAJVJTEVjhYW8yr8du9QFuoGma9Owgciebu2LI8Q9uwm2rTBKn8xLB+QxuTqS7Aoi1B6M7arD8yr2HqKrUWsTlFlK2mPs38oo7jZH8t4XLy77yihNq+ta2MZzoTBNiueZufShKGt36id1VTUJndDEyekUkZFEeE4MBdLQ2c69z9DN/5cSG8tHhXrwyULX40DfoIQLztmYpVASpIhVGs6SjJwcPK3CMA3LCNBNuybeg2g2iT1f1GJSXajuB85h/FUmZqiEXYTfsr4eQe5fmXtUX5hFCnxjvX9J3ddNlmn5cw14pHpbJPYtGh0RHj8cpvdNA9bN3rwzVW64E8R+z2mDhsw0sd5CBurzaRVC2uM79Lq3G9y/b1ttWXEuI6NTI+jC01IAjITOapT2o2PrwZCtsHrEiIZnfJCq88MFTsea36G+tAWj/MFigQVbMeIrzsDIDoUVDRYzn6Bj6DXkQOQeuhV3uqxIcjEO+E1htT/9RqiGvBzB+teZmbp2MGSLPPWx/S85fo3iITQreLwvB9YCIYPVsoDEp/k3DE75NeamVteUEVyrp5nAB8uyBD2tv9pVDxb7lzXTCy8IXQRSrFy3+sS93R8uu+SXGkw7jeEIapu0I6VhqEj8ezt8Uypy8XDe4aEGeHpmJFcklLr/63CZ0UzbHp+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:11.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 314f0862-be5c-448a-a224-08dc4db656ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7300

Since the selftests that are not supposed to run on veth pairs are now in
their own dedicated directory, the skip_on_veth logic can go away. Drop it
from the selftests, and from lib.sh.

Cc: Danielle Ratson <danieller@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/ethtool.sh  |  2 --
 .../drivers/net/hw/ethtool_extended_state.sh     |  2 --
 .../selftests/drivers/net/hw/hw_stats_l3.sh      | 16 ++++------------
 .../selftests/drivers/net/hw/hw_stats_l3_gre.sh  |  2 --
 tools/testing/selftests/net/forwarding/lib.sh    | 11 -----------
 5 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool.sh b/tools/testing/selftests/drivers/net/hw/ethtool.sh
index 187429670ee7..bb12d5d70949 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool.sh
@@ -287,8 +287,6 @@ different_speeds_autoneg_on()
 	ethtool -s $h1 autoneg on
 }
 
-skip_on_veth
-
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh b/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
index b0f931260a27..a7584448416e 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool_extended_state.sh
@@ -109,8 +109,6 @@ no_cable()
 	ip link set dev $swp3 down
 }
 
-skip_on_veth
-
 setup_prepare
 
 tests_run
diff --git a/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
index 744760117005..7dfc50366c99 100755
--- a/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3.sh
@@ -325,17 +325,9 @@ setup_wait
 
 used=$(ip -j stats show dev $rp1.200 group offload subgroup hw_stats_info |
 	   jq '.[].info.l3_stats.used')
-kind=$(ip -j -d link show dev $rp1 |
-	   jq -r '.[].linkinfo.info_kind')
-if [[ $used != true ]]; then
-	if [[ $kind == veth ]]; then
-		log_test_skip "l3_stats not offloaded on veth interface"
-		EXIT_STATUS=$ksft_skip
-	else
-		RET=1 log_test "l3_stats not offloaded"
-	fi
-else
-	tests_run
-fi
+[[ $used = true ]]
+check_err $? "hw_stats_info.used=$used"
+log_test "l3_stats offloaded"
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
index 354be353455f..ab8d04855af5 100755
--- a/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
+++ b/tools/testing/selftests/drivers/net/hw/hw_stats_l3_gre.sh
@@ -100,8 +100,6 @@ test_stats_rx()
 	test_stats g2a rx
 }
 
-skip_on_veth
-
 trap cleanup EXIT
 
 setup_prepare
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index dbd4348f85b8..ca433ba3612e 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -254,17 +254,6 @@ check_port_mab_support()
 	fi
 }
 
-skip_on_veth()
-{
-	local kind=$(ip -j -d link show dev ${NETIFS[p1]} |
-		jq -r '.[].linkinfo.info_kind')
-
-	if [[ $kind == veth ]]; then
-		echo "SKIP: Test cannot be run with veth pairs"
-		exit $ksft_skip
-	fi
-}
-
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
 	exit $ksft_skip
-- 
2.43.0


