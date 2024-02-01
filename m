Return-Path: <linux-kselftest+bounces-3923-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFD845256
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 09:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D34D1C28085
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFA9158D8C;
	Thu,  1 Feb 2024 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tgz4Ea3Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F1158D74;
	Thu,  1 Feb 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774777; cv=fail; b=BhBs/zsVgNomiOXMQ7UfI5LIDGXPotBzCgWSGcRBrQoMev2zUbfhTps266ujZkghp4b5ck8ZJkH6nzUypxkS5mqYxwKRGd+2AfBoDIQaOPGwtOlpGawATRfGPqL3Mk4wZh9E1qrUTgxo4b58JqKrPt7pxqdgr5HS0GFf7hMHrvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774777; c=relaxed/simple;
	bh=VN0+4Zgf7jyoWqgMA9jM/xjheZzHQOVyXv4LJt8+1W8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxaD/x09642D98Up8j8HKPdKzUXotfEaouY+dxJydv1xWe8Ma0oJy31/X3MBg+l/4x5VweW/06QJOaaxBAl9ju9c6JHhFfPVkn1q1jvjdde0LdHrwP0sb4JHNOP9J82s56XQmOW1Kd7RjdKrbWUDZe4Fipj6g7V4YytRsYpXumo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tgz4Ea3Z; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb27yrz4Ti/oWgALlMc2A4murT73QFyx06GP6Y6LdogslpZXpK0Iqcvz9JbRwKWwdOoXfUY0kfths82VjNO7hlJrZswIWf2pwBdcrjOfFEQN42+6fvhNdur+F9p3H4QJRqDc5OeXdY7eQTqhalP9d/i2P3+ZVnvjWoU1yAv+8gQHIgudKvJtCRqMxwtdP2MsUWOdLdbXPsCG/Litp0GXAQpUG+eIq/xCxqLZGcH7ok2s+v0DaLV4aX+XzGf7kbkeJ8DdrFaD44qWGgdktS8GxdDKAZMoZXZ7Nj7IObEV6an1FSBGcbPuVNZwmWfKZgCIZFNFwd1tWr2kJNLMFVARww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTNnGGeR7u10jrzxZge+9+6sDDntXVkb5X30h5D0rHo=;
 b=IrCW/icsV7c/MdrJmvvWcq7P3WAi0T4Invet4H81LcWqT67nxVrnIhn8aIo3c3XIV7GlR0+fbfa1O8YaP9C67U3O/gDNJcHjrceDT+orgVjg4pxckeaM5rD9W/aoaeWj92nNZ0ZuLrQt2/WPM+Mcj5xFkgS2vvVeZydJKeXMDhycRr2iN8jLfbvlA8Gx6gMcPelZj22Lwx1zx1rugH6sieXMK/iq+Rzxh8PT2IcYZsRMtZXeUuFeuTE8vlWL1K0l5ukPgE+Jjx/u34avHsYHBZWq/IRRhFTF8luRkLFKQxQY7d1HlL0Maf+AJ+OyTyuroDEA8hewSV1WVcTh2xRkPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTNnGGeR7u10jrzxZge+9+6sDDntXVkb5X30h5D0rHo=;
 b=tgz4Ea3ZAOfoEfyntaJTbNC8DHdb9fFYodSoQ/5Ohkhg17sIAYSeyJOdD1gUvtVhWjDfmZ4IEAa+Hqshcg03HzgyAROP6TW3rn2QRrX5N2j628KzXae5WfwFJHHYT/a9Ba1s4Uj0ILtSvR9FelD+rRAgEFh4flAbiGSgUdbrXS1Y0kGrfDqZt3aTskiwwFHVyqaqRkfWPk+hXKNmy1PzPoJDFjpZwCyXAMZGYVew0V6tLmAmJ1aOqhz6Cl8VR5g4sl47WrlfimjXjhbFOfeqOj/s5ekSFfnnIpQVgsiwCVkhwA6CZGHxS9gUQOP6y8m1AvF9cnSh++GijhkWQ7sptg==
Received: from SN6PR16CA0046.namprd16.prod.outlook.com (2603:10b6:805:ca::23)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 08:06:09 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:805:ca:cafe::d) by SN6PR16CA0046.outlook.office365.com
 (2603:10b6:805:ca::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 08:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 08:06:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 1 Feb 2024
 00:05:50 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 1 Feb 2024 00:05:47 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <razor@blackwall.org>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: net: Fix bridge backup port test flakiness
Date: Thu, 1 Feb 2024 10:05:16 +0200
Message-ID: <20240201080516.3585867-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: b0de4fe8-b433-4248-4cf3-08dc22fca64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YWhoMYRNDc61+YHDnLiqH8SqB4mI+L23M4/NfKyQd5g9Ma9Ra9n4uvg35GftaKoJmmgm0cJYfeWy55SDdsbcbXOWwThyn8Ki1m04HPlY2HB6zoXHsmU8KAaIYzBgvK4agPDLxa+hcs+2bBCOsWlySu96gil+wU1r1pF1NginRD7U8NKQx+PK9dMnym2vWlbh+tMBm+N1iRSs4pBss2RDO86W5e33g+ZY1yw5EOKq1iXcjJmcp/7LheDg6QvA0LLPhcbIO1D32b3V1P7mAE78G9Eenfg0UlKNVgDv0JPRIq5cFTMEa+PtYeupMsNVZltVQHpfln/EoTzHrqmF8jaSC0n5JWHlvBDJU6+CQmRCuW7rgD9pFIZe1OyqPUys9IBq2uQYxUlYFfLc9tqUURDqTMS437Q1woG+4jrmlscz9elNKrIe3LYLm8nfzuGkgkVrJ9QDuWEpzAPf8q1y5VXw2BIF7PjOlFbTMwKDCWwpl6JgK1L/J/AHFMKPooh19wAeJM2Ny05tuPNa0d1xN13gkMOnMIjswpfUaHVpG2hJb0SS4ejZViHvTet6V0k9WjO8C/yLye0tFww9xeuHDcKUjQAQVWPT7cIKx44rMYayax3fCNLIrC4RqVL+URRyccyuTsCMKTt9jmzN2xirWJD/0Q+egZm2SpWlPKlOEJrT7YYLfsK8GRW8y2qhlk2hKd7xwKoq538YK8E8QsEI7GVmLupLjeojBJSgtJPeL8iNPZs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(41300700001)(83380400001)(107886003)(36756003)(82740400003)(70206006)(86362001)(7636003)(36860700001)(1076003)(356005)(2616005)(26005)(47076005)(16526019)(336012)(426003)(54906003)(2906002)(70586007)(6666004)(316002)(110136005)(4326008)(5660300002)(8676002)(478600001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 08:06:09.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0de4fe8-b433-4248-4cf3-08dc22fca64b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

The test toggles the carrier of a bridge port in order to test the
bridge backup port feature.

Due to the linkwatch delayed work the carrier change is not always
reflected fast enough to the bridge driver and packets are not forwarded
as the test expects, resulting in failures [1].

Fix by adding a one second delay after a carrier change in places where
a packet is sent immediately after the carrier change.

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
---
Jakub, targeting at net-next to see if it helps the CI, but can be
applied to net. I'm unable to reproduce the failure locally.
---
 tools/testing/selftests/net/test_bridge_backup_port.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/test_bridge_backup_port.sh b/tools/testing/selftests/net/test_bridge_backup_port.sh
index 70a7d87ba2d2..92078b56ae0a 100755
--- a/tools/testing/selftests/net/test_bridge_backup_port.sh
+++ b/tools/testing/selftests/net/test_bridge_backup_port.sh
@@ -260,6 +260,7 @@ backup_port()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 1
@@ -285,6 +286,7 @@ backup_port()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 2
@@ -294,6 +296,7 @@ backup_port()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 3
@@ -315,6 +318,7 @@ backup_port()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 4
@@ -370,6 +374,7 @@ backup_nhid()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 1
@@ -399,6 +404,7 @@ backup_nhid()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 2
@@ -412,6 +418,7 @@ backup_nhid()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier on"
 	log_test $? 0 "swp1 carrier on"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 3
@@ -442,6 +449,7 @@ backup_nhid()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 4
@@ -498,6 +506,7 @@ backup_nhid_invalid()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	log_test $? 0 "swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 mausezahn br0.10 -a $smac -b $dmac -A 198.51.100.1 -B 198.51.100.2 -t ip -p 100 -q -c 1"
 	tc_check_packets $sw1 "dev swp1 egress" 101 0
@@ -605,6 +614,7 @@ backup_nhid_ping()
 
 	run_cmd "ip -n $sw1 link set dev swp1 carrier off"
 	run_cmd "ip -n $sw2 link set dev swp1 carrier off"
+	sleep 1
 
 	run_cmd "ip netns exec $sw1 ping -i 0.1 -c 10 -w $PING_TIMEOUT 192.0.2.66"
 	log_test $? 0 "Ping with backup nexthop ID"
-- 
2.43.0


