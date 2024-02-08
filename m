Return-Path: <linux-kselftest+bounces-4346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452D084E0AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 13:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AD11C2228D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 12:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A506A6E2DE;
	Thu,  8 Feb 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uU2AyjAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF41B945;
	Thu,  8 Feb 2024 12:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395537; cv=fail; b=DTvCtIReTmFh/f1UQ9klyGC0q3MONR7cYugB4EXHRFEBApzGTxUiEbb5D+0Z0Cw87tNaqTRceJwlMH0t2GK6/ypoAuN6PtFsJJC8bLpzsiYarbB5UwqXH5p2XWk+G9Y+xjGy9HClYYU882FfrwVFwFicUrADpk5JTNVM0Y3rQ/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395537; c=relaxed/simple;
	bh=KyR1J3QmVx5enCTDKPQsRut/TkcHzx65tX+ZwE377LM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d62zndS172fRZFXdvictfFO/K6a3cI1ggO4Tlcj0JxbseVPGBYy9LIUZgZDOJQ5YZLs2WZ05AfSnsTdVnQJTL9l/LakneI51mzhRRSa2NofZI7/KG8P21g0EI+Eda1oYJK09Mz9EwEMggJBJXGGYKBrVoR3clf+VawFYgddt650=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uU2AyjAt; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKpDwwgC1AqCL08fZmaOOT7uxZGsJFXfjEUmkbN69A3DUOFYPVmPsL1urtcW5mhOHdBA37JTO4M5GKmSB7sDjIIV4xY6W6EmbvvkM88JH2vqO3x8TdZFSKQmZ/TO14S6bqik4LXKslfxS83heLoqAzi+/p8Yd0i4ZxllX4Ku4SSOIaG2L19RhLwZ3yjJQeVmIKDmuWMliWM6k5UkxitzJj8CEuyxQiCSpLkCYGgwx9yU71Fc+FRVl/cPXG1to0sMzECaba2xDDqq6aYYvGR1CBJeSwJBcw/5dQKBqXr5T6hqwZfvVYoznVGlWFW8LVtnCpGYBurpVrLNAMRxsY9Eww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j7b4+rUix8cDN83QUdJEmWxqZ8hzBVws3KcCZENryA=;
 b=YOnKlrvuUo6Ut8VojQzpYruS45bWen+QOxle+CQCUupqo3e/wnGZkqZfZsDWWHo9sdtJWPKXymhmxzStSBTzZyCcB3Un0wsE+F/oPAUthf8nAfV7A7YFeeXEfreNF+OpLxKyLEXgn49Ca2cclltRC1XJp53pj395Jk6sCoQTLDtldM9vnv95YxqURP0qzPeWJJG78jERUp5qKk2rFbtk8Wr1A12Q5iCWfXUL92+F4yyOgOJR2lcpJwfhOK9Ss98qK8ohER+GlTurRp/00M2XOSzwA9nsodAqS20cIk6ER7kgP2/lkHRQt6FHDxP2Yk6PoiEdtfGajc11IiwcC251+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j7b4+rUix8cDN83QUdJEmWxqZ8hzBVws3KcCZENryA=;
 b=uU2AyjAtJ+8UK/zgDQ1S9BHmjLLaDmkgHSy7DmkbZzX6NdHBMCdeXF46hpaAwyx05QKMWxSPg81LUY4dwA0SxajB0OAPYOCTD8k4biURRQr/B5Ah0EXop3LKlmOewCU6w7QStK0kFL09dIOXab5fBK0ahXAO4NCfjiONV+VXAy20ofqJjv03LQ/PTgZtaMxLc+c6RZoqBUszQjYL+x4fCZK7tgvwXvbfNufXdxF7RqMMEP+me7TqZvIy0yOu/N/NmsXZkjbvnU2YN6KsTcPImrGYgnXtS8yeW9jU21x2yMKrjHKG7vVx3jm/poqoZFZDS3otbATYs1N638qUjU/KxQ==
Received: from BN9PR03CA0682.namprd03.prod.outlook.com (2603:10b6:408:10e::27)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 12:32:09 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::74) by BN9PR03CA0682.outlook.office365.com
 (2603:10b6:408:10e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 12:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 12:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 04:31:53 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Thu, 8 Feb 2024 04:31:50 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <razor@blackwall.org>, <shuah@kernel.org>,
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2] selftests: net: Fix bridge backup port test flakiness
Date: Thu, 8 Feb 2024 14:31:10 +0200
Message-ID: <20240208123110.1063930-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfcbc91-c482-479d-d8ed-08dc28a1f7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+Luvzjw8uRGcLQBBKVfNm+VwkqpFhJBoWyNd80rb+ABy+4WCjvjz+N1Qm7W5iMqzD1fFyn2a+9d2tfSBVbuB2bBapeWREVxqiiOKARJmCHuvgnqZq6o5eYqwnnkylsh87r2wrpzdfVDxumkWuCL0JvRmsSTfYZ0Vp+sZ2s+F6H71CRlyTEAiI5BNZilxNKoTW0WB2J/+UIrSk4zScsg393dl3Y1JNc3ZtuvzxUoc8DAVsHILBBJJtfFOjuH+qv8lrqtxqzQTtyiZAOM6qmjn2zS4f3qsvq9bjxWJex20eadfIiVAoYuy3hY+LUqXdS0V30Run2BVEKaW95YU+rq3COcIxDicr7Zgafl6DhOmKQRBzLV/DJGusCHq5ZVE4t6AJtpN6FGNSN+l0H27LJ5DiNMhYzpFSppMzAwlbsfhAnGWgkUpEhYBX2zs6G5YdC+qpnvGw/0Bl/qlBRdulftBuC0pbQWMUeLy7496aWSIubM6+lVjtfPa4Nw5kZInAcurFlyrM8SVzQ1IWX+0RDgA2x85IoKelQmcdk3bBzJYbXBHXWLpFfnjwkNkNMKUiGSURNxt03QsH016qMjBh8xYnHKKMuFxzrylSRy2llgQeU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(86362001)(107886003)(5660300002)(426003)(478600001)(336012)(2616005)(26005)(41300700001)(356005)(8676002)(54906003)(2906002)(82740400003)(8936002)(4326008)(70206006)(70586007)(316002)(6666004)(7636003)(1076003)(110136005)(16526019)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 12:32:09.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfcbc91-c482-479d-d8ed-08dc28a1f7fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788

The test toggles the carrier of a bridge port in order to test the
bridge backup port feature.

Due to the linkwatch delayed work the carrier change is not always
reflected fast enough to the bridge driver and packets are not forwarded
as the test expects, resulting in failures [1].

Fix by busy waiting on the bridge port state until it changes to the
desired state following the carrier change.

[1]
 # Backup port
 # -----------
 [...]
 # TEST: swp1 carrier off                                              [ OK ]
 # TEST: No forwarding out of swp1                                     [FAIL]
 [  641.995910] br0: port 1(swp1) entered disabled state
 # TEST: No forwarding out of vx0                                      [ OK ]

Fixes: b408453053fb ("selftests: net: Add bridge backup port and backup nexthop ID test")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    * Use busy waiting instead of 1 second sleep.

 .../selftests/net/test_bridge_backup_port.sh  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/tools/testing/selftests/net/test_bridge_backup_port.sh
index 70a7d87ba2d2..1b3f89e2b86e 100755
--- a/tools/testing/selftests/net/test_bridge_backup_port.sh
+++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
@@ -124,6 +124,16 @@ tc_check_packets()
 	[[ $pkts == $count ]]
 }
 
+bridge_link_check()
+{
+	local ns=$1; shift
+	local dev=$1; shift
+	local state=$1; shift
+
+	bridge -n $ns -d -j link show dev $dev | \
+		jq -e ".[][\"state\"] == \"$state\"" &> /dev/null
+}
+
 ################################################################################
 # Setup
 
@@ -259,6 +269,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -268,6 +279,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure vx0 as the backup port of swp1 and check that packets are
@@ -284,6 +296,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -293,6 +306,7 @@ backup_port()
 	log_test $? 0 "Forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -314,6 +328,7 @@ backup_port()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -369,6 +384,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -382,6 +398,7 @@ backup_nhid()
 	log_test $? 0 "Forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	# Configure nexthop ID 10 as the backup nexthop ID of swp1 and check
@@ -398,6 +415,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding out of vx0"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -411,6 +429,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 forwarding
 	log_test $? 0 "swp1 carrier on"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -441,6 +460,7 @@ backup_nhid()
 	log_test $? 0 "No forwarding using VXLAN FDB entry"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -497,6 +517,7 @@ backup_nhid_invalid()
 	log_test $? 0 "Valid nexthop as backup nexthop"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	log_test $? 0 "swp1 carrier off"
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
@@ -604,7 +625,9 @@ backup_nhid_ping()
 	run_cmd "bridge -n $sw2 link set dev swp1 backup_nhid 10"
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw1 swp1 disabled
 	run_cmd "ip -n $sw2 link set dev swp1 carrier off"
+	busywait $BUSYWAIT_TIMEOUT bridge_link_check $sw2 swp1 disabled
 
 	run_cmd "ip netns exec $sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
 	log_test $? 0 "Ping with backup nexthop ID"
-- 
2.43.0


