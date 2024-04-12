Return-Path: <linux-kselftest+bounces-7841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3DB8A346B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED381C23347
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145A714D6FD;
	Fri, 12 Apr 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQkYEX4a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD614BF8B;
	Fri, 12 Apr 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941597; cv=fail; b=oOhnjopEhYA6cBOTJtTAHNa4wm9Zz99Te0LDrEB7F6PmEWPbuz+CYbeztbop5Y8Nrrr2Gv/w7yK6/u3sHasdX58djl51fHNNSK8SuYG+5/DIirv8rLEq/BY3ie4Et4A11f+pEzgx4eBx1hBvsSsXpy5n/fXmkVzXzfglccc+YCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941597; c=relaxed/simple;
	bh=uVGypwbb8hmhOJEtmBob2/abQMsih5uxvVTdKpdQaKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WqJ+3b67SKsgnoYwjY9MW7lShPNISli20Lkjol5ibEwuNQJvhl+c+EU9oqWojnxG8BkIj9dcy+C3ecI2G4ZJWuzsLHha3RtjL/keqLJW9lYJTPxQ6Mkz7fa2WsJHnyR6ZFEL5Vkg8mD+0u9VxcBLH/FuJahI3JTMTdmpXl0QGy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQkYEX4a; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLAcq9zRPd7Q+erYTCuLBlApmsPP3V1jPBG7sPGvOIpUaC2Nly8PFHz7PIUWbv314tUhabOnjPzLV+hHx4gOwib0PHnaUdKODv3Y8ntiScMEufFOMjpfQc0Qwfi5OCMJ8CFVlycWIbeCa4trngi99U4+Dn00xcaY/ZsgqNQh925i+DeUhy/JIKWSrEXYxHIq0B+ZwFz8nZslayYPyNq5S88SZtiLVmLXbv9+ovzEeTKFfo+nfVFn075Y03wmE7agHPreYtcPYS29sKX7cpcOYC1BuYU49oQ8MwaNtjVrkb0R/hrL7g7wKmSW7JiKJ/QgAJ48AMlr62jaDYD0ssSUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxKFHqpHALHjJTLaus8lMS+E5wEnDG6gcRAaDpR5tVc=;
 b=T/7rG2kaCdgaU9rfEc79JcQ3IYLrL0X625ZPqna1boxdAwi6FGP/aE/k8YelSXpB5xZ5fU1wEsITCLOVheCTvpXnhj9Dsjoudt/hYLqIoOEr/nccbv6rAicAwzePkbvCFDEzVqcqvZpfFsI2X0trILppuBIEmmrivvky22tAeyvnDtCnqpxXLyoAK0+U9D/noow7Ey8wFdodHZJlyhWRDY2cZpwzh0XXE9r4wjWOvDYTGP7hSHZ4Ll4/AY2XXO3VgRqTlFvlU1+4Iu/+ttnNGErxxz9iaHvWKZiKQr0huJDO5EABbA7lUEc4JyBk4UoMqIrdRsjecdulToYig79uhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxKFHqpHALHjJTLaus8lMS+E5wEnDG6gcRAaDpR5tVc=;
 b=VQkYEX4aQc+RjOhPJjftzBHujs13zmqrPCZ1ftzP7dJzZ12UN5zBuJc9tLB1oDs546h/vGZK54NhUG2SUunKpbAQ3qtQTAqt5w8sZToEWX71EzKF1OKTZOhwXFHFOuex7yiZL9tLOaQSLI549XKhrUqvCBnZ2kJN2tt1HPr15Dv3pggc5sq1kN3wT/3Nv7BcPVzV5itGyDYAOYwOCmwGzXHBswax3IyOji7tuKc2lZprl99smh+QGrJ5bEbmGojNoeoisxIrCh4N2E6jhUU2aZZIfd5Qvcr/mh8YtYfwuiCsrfb9bKtWB3+25sFYtE3G9nMJC0y4r8gQOXdLuG2MSg==
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:06:32 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::7b) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Fri, 12 Apr 2024 17:06:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:06:06 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:06:01 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next 07/10] selftests: mlxsw: ethtool_lanes: Wait for lanes parameter dump explicitly
Date: Fri, 12 Apr 2024 19:03:10 +0200
Message-ID: <fd51f6a437b5c4c1510ca697c5404fe9ef68b64f.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 5333ecef-7362-4ced-d2db-08dc5b12e6ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ffrYXz/9hcewUEiEikm11MWMZnE5va8Up28N0aTkUq9niD/gi3x9ChsyFJqDJjyYAsGa6dYvxuXmf3iHC0/MQrVZEjBGkoqatPfUJJWsL0nW9NQRgYAZBIkmg2AQUKeG7ibsd5LwqInVvCYwWxfJJWdTrAtw8RqJQ5fdLjJ94pU+ef/+Oa5egOGi0IQq8LweKxdoU7P5XvCrZldPO/3WedkwQTMk/nH9slPrPtxSpqUD4IQEWu89wcnCHVdL6h6GbSD+4q6kSs35hrbXYq1fzk3AALAMKC7RUvcMrTdym/Z4/hdUj4OrSDznWm1CTbktg0TQhdKDsiR75QzyLVOfXmwNVvOfo4CZSgJ5gPh8m9HtCLCh1y1RULLXoKlY1vbt4YUPc681869CMat5aUG13cIGsWqJnHZUPg+jpDC48Gw62CsfdKbXW1ugZOaA+01Sb/7KGwtwouDhb5/y8Rz/eD/s6Q/RhqenEGDiU+IxtwYKPcB/CbfvP6WLoquv0S8U/yvG1Seg5Xdex2jh1GuZpwWrtlxIWJxdvub0wu9U/JnK3upct7qTF57kNz0ZL8CivIxkDnzqLjqnVG8RaQW7/VVM5gDP+hPVCOH61qe0A9TOd0/SrjcHo/dUVLL0UbHbRCeQ/2c5cKxWtBnHU4xmgzfPmG9pTZ1dCPGkc/Em/HZ8zt0tYMlqk43CylR+LxgbBHP/EAsLvpzhJRUZpnH2CkFyo2rqgKEYU1J9SiMq9XlzeiHTGarfemaOMpqs6ADE
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:31.6747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5333ecef-7362-4ced-d2db-08dc5b12e6ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

From: Danielle Ratson <danieller@nvidia.com>

The ethtool dump includes the lanes parameter only when the port is up.
Therefore, the ethtool_lanes.sh test waits for ports to come before testing
the lanes parameter.

In some cases, the test considers the port as up, but the lanes parameter
is not yet dumped although assumed to be, resulting in ethtool_lanes.sh
test failure.

To avoid that, ensure that the lanes parameter is indeed dumped by waiting
for it explicitly, before preforming the test cases.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/ethtool_lanes.sh   | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh b/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
index 91891b9418d7..877cd6df94a1 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
@@ -24,8 +24,8 @@ setup_prepare()
 	busywait "$TIMEOUT" wait_for_port_up ethtool $swp2
 	check_err $? "ports did not come up"
 
-	local lanes_exist=$(ethtool $swp1 | grep 'Lanes:')
-	if [[ -z $lanes_exist ]]; then
+	busywait $TIMEOUT sh -c "ethtool $swp1 | grep -q Lanes:"
+	if [[ $? -ne 0 ]]; then
 		log_test "SKIP: driver does not support lanes setting"
 		exit 1
 	fi
@@ -122,8 +122,9 @@ autoneg()
 			ethtool_set $swp1 speed $max_speed lanes $lanes
 			ip link set dev $swp1 up
 			ip link set dev $swp2 up
-			busywait "$TIMEOUT" wait_for_port_up ethtool $swp2
-			check_err $? "ports did not come up"
+
+			busywait $TIMEOUT sh -c "ethtool $swp1 | grep -q Lanes:"
+			check_err $? "Lanes parameter is not presented on time"
 
 			check_lanes $swp1 $lanes $max_speed
 			log_test "$lanes lanes is autonegotiated"
@@ -160,8 +161,9 @@ autoneg_force_mode()
 			ethtool_set $swp2 speed $max_speed lanes $lanes autoneg off
 			ip link set dev $swp1 up
 			ip link set dev $swp2 up
-			busywait "$TIMEOUT" wait_for_port_up ethtool $swp2
-			check_err $? "ports did not come up"
+
+			busywait $TIMEOUT sh -c "ethtool $swp1 | grep -q Lanes:"
+			check_err $? "Lanes parameter is not presented on time"
 
 			check_lanes $swp1 $lanes $max_speed
 			log_test "Autoneg off, $lanes lanes detected during force mode"
-- 
2.43.0


