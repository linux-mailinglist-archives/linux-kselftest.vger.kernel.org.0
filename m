Return-Path: <linux-kselftest+bounces-6559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0117888B3F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32726B251A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B80131BDF;
	Mon, 25 Mar 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZxPNFdv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70944131BD8
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387969; cv=fail; b=mNYdIRvB2kSx2q8cwLQOdHc4YSsLK2Idz46/JVuW/aF/CNfxzfJDxhN8CtC9MVaETVnljVxVI1Olxa8NXaawHcC2ar59PBMfoPKmPu9XA7dpuY/ZpIuLt/+AVliBdBF24k96xzNCY9Akg3gatIzBm0Gc0cI0+07EXl5aGYVjf2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387969; c=relaxed/simple;
	bh=AZUSMPjiXcvxzVlj7PylF6NCcBvM5lAT79psV9iJqgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vE+6T3wdp6udUpL6iR5UQsnIjHR1cUbUxgu3FIPYKcxvcGEgycqEzx/888pYjkfBAf4NcxoI54pVFT5+JuzYZP+MvMUPdPpzMq+XbhJwlamT/6atlZhcWlAdjLAB5H4gSllMZLFPc1ckJtd5fE/ymouvL0jLRQEsK5n/KzTj7sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZxPNFdv; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHhtdx7wJWhswCP5nWpJdpeNNKe8UQIeuu0Yd/L7PZrY/lWQrQslM7qp0zKxPEwXYGzVpeie+W6UG5SOJdVuyYRtj5thbGhjPMrMBEaUocQKDg2qMo1bJiNDoSfg4z0nHI//XRWHOI3bvvwqHjS0DHkBfXx0Fds0vuv5UxK2mNlimtOA/K8oHESEJzJ/dzqB40KeOXItIc+fLpO20M8wTXv9erRcl6E8gFNyxjFAGWsGBpkJMKBcS7BHO/i3i0y384tRL9DNBw+HUnQLTKaw42STlNf8RMRhnraGPs2lgPN9onstEoWmIsEAyAFlIrNp3aeDAEQr7JR7XAz8kieqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mCdfpmuRZSleSTsXITlCnaK2+7xoOs+UANN5D6l938=;
 b=fGNsnof0koRUaSnONvC94iYeNdIcCpBcTF23TaPKavFHeiU0Sfqx6z85gWpekuATFYbqcdtHEcnd1YY9WMfXFkisbu3LIJ49QjMXn6Nb69Np/MnmNk7R3HoQgzueyBT45KC6ZVSecHCd1qObt967kjuICXDs/4Coo8i6dhBtgdK1trZih9q9Qpol5rBCtCpk+XL0GkktkynRItSBvk+WIgWGujPB8NA0wW8PKIQop0B3XhrgoOg+yO4KtGlSByE1k3hVipuN1JuzZOUk2rkXfDvtF41CLIaW6dvb9dNAn2et372gztJ7A/6qBRW/DS3SdGU9Flf77wgN5uDPKw2qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mCdfpmuRZSleSTsXITlCnaK2+7xoOs+UANN5D6l938=;
 b=JZxPNFdvOKkBVCqEE5houq+wif/LYxwUMJ/Aeg7wF2GYSnh/Jz3kaf5y5mJODFvYcPspPz1KkUuVIamP5GkMssVWby+1TT9jRBe3tAiTMj49GXEot4t+eA71JmfMCCcybeOjtfyq0TU+62bm+bbgxz7kn42ILLhgKDYFasdj1JyfxqYMh03e4W9sqXozCXkoAfQhJNmBNUpGttLJWt/6AnMqpgfL8C2zLHOrdFcKvLB52ivmMEmaAbXtaBAcVpGh8ISS/+KQ3MvWlqMt/6ErlKiebbV3N8PyR6fHX3KMx5kwXuyb0d3ECXvYVOpIoo/Ektx0qljL8Uk3+Y5Bc5uWcA==
Received: from BYAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:c0::49)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 25 Mar
 2024 17:32:43 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::7f) by BYAPR05CA0036.outlook.office365.com
 (2603:10b6:a03:c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 17:32:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:32:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:31 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:24 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 06/14] selftests: forwarding: Ditch skip_on_veth()
Date: Mon, 25 Mar 2024 18:29:13 +0100
Message-ID: <63b470e10d65270571ee7de709b31672ce314872.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 257da132-da58-4607-7fec-08dc4cf193ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WRhJgxAwqT4dq5fAAlg5QPko9RHKOPRm4IUZbZIqW0M+3FRTG+kLRSbp51rPn8HhqkXDbW4d4LMHnNwXvC7AA9Tri1B8PMJ+amxDwQWwUpDHw5aNMgXEmFAB4fqawMXDwf7K9tZFAUluk6ygziE1Af15JOooEDQZTyXTprqZUDWKKzdwf/Yd/AOPaioLhMNNRIH4jFx50Ku85gEnTZc/z5nzT+ZY3f4/L/Z7018Cks7DtUpN1T2aILm6Vb/wb+ol9BiaWwxv08Cxvx3x57QOLZIRJPG9lWa8oJGFPoTdiXpY/o9HyI6auuYkuMgruP0J0x0Tj1tAOakf0ohjvMrhIPQ6Dt+dRvxlimTp4qOmBozLdjahpfLXoxTps/VXUOk0JlIiAWiZma1X2WO6O8tMtray0+oQfR4qldNMIK1QF1/w6q/uBzw7kVc0GDRpqWg8R2JHfbA+sYNxFP9j5LBG8l8j/+7cxy+z9PwbVsJkwEceKqHln6yRzrcltXAxsKUcAI5KvUx/Hy5n/HoniCbLmxDyr1Rw7RHtLpFsZM2WAusm1zUUBawo7vD0jWKzelwAFihyKxCndd+nztAtlMkKKbf2uBJWiY9IzajEiftBspJVtM+Srx7zmntkDm40UcM1rwwFkiB/TaRgzn7ZUMXl+AZIBhBsK7h7wqWm1qqMleGiVQT1vHSA1tKmvAMy+3PLLUf0spf2DueRTG/TLXWLsdc1BHTko3gdzB+atZErsnLTC/vciK/uIvCNZB0omfF7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:32:43.1878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 257da132-da58-4607-7fec-08dc4cf193ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

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


