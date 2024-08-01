Return-Path: <linux-kselftest+bounces-14664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9B945083
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 18:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE4F281DCF
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1721B4C3E;
	Thu,  1 Aug 2024 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HwNwv7ep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956D1B4C3D;
	Thu,  1 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529537; cv=fail; b=KFuOEYDeYbaXJcM3QupGW+UerE8JvKP7CMQcVCBXZxCS6tPPOcsQY2UJmLItTBt3wzvJH3NZ2gp2e7XsDQOVbplKEYAosqVvtmNiiqUfE0yxAaPaVbYhMG1l1Vhe+CC3Bl8cFD1DCH4pGh9qkTsqg/r/7qIIhDOg5j9nAgnGUkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529537; c=relaxed/simple;
	bh=tv0iSH64v0IG4HbRIZsUC8d4ITJSf5yPJ329LRGahlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/jyuxCc6FuPD7+wHEavQbFp3Nt6S7gCP3VsnKHsypIfs+UV0P8saHOwyJPm46aeQ1BbcrCqKtGtbK7YzOcViiHBXa7IrXjdPvy/MzVjzAfzxNDnVWAGWhUwbBBFNpGJAlc7ZoHixDJz4lcuBQHeJ98uvKxJmDxCEVOlfUoqTn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HwNwv7ep; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlZIK92SvUrgmoq8twEMUWpfU5n7Pw+73mnPmvVxfbqSYJ3dM6nQDutC737K9enFYHRVgxM8EC6GNayRHcEvGWB12J930vHvG6/yWq1omeR9kQifT04UARjBuS459uV8JJLAvy8Pk6ZBvTmC5bB4OXn9A9w/61ZdX3rVleZw5AKOiq/d+g+Ensi/wiD+XNVB8Lap+Xnr8cg2EjZ4ioJRTMQ8BytcbfhZNuI06JQlPLVXtQE+SRJ7am7SUoXjsp/wf0MI8oRxONFg+y5/AHrC9PH2Il05a4jxAK1J+4m2alRBWQt8GPcWHJSvoC7Ek9N5LGYApAG4Y4jjWTruQZHp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih8k17yJic6UTGeIlRDUMLxv6L8/nT3If/9igyh7TlU=;
 b=w5NhtZiu488my7sgddhWbo0IMdH3G4q0Ay774TvZtFCiR9RPbuao8AkzEl/zgyrnP9aJ2OlvEOmDjxfwoqjhRIZEqq8CydH1wtUM6FdFbyib06P793Ho4MYZnJqpmJGyTyK14OhnpwUU2yFptPhmpLNRK5X488LYqrIN/a/O5YVfc8t3vclZP176XaPCy2NXaDeZ7i410ZltGblftetANwdKU51o7j5icjf0rbWiw3dwRkln3L2KUaeD/55hIz0eMDfULXVyVQ3oJH9js+iavllgJ5SQDrK1g2kUagxU1Z2hGZvI67Uxnf5x6iXq2k3wDRs9oh/YlP/tSrCKQSUnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih8k17yJic6UTGeIlRDUMLxv6L8/nT3If/9igyh7TlU=;
 b=HwNwv7ep/y7U5c4MsTP1OuiuVsBp7ybrNAuyDwbm3rjRAX/v4UX+JhvyYChZ46x0sNH0uT3Wrt700OZNrn5UeicXfa8Qz2qKKpVOdtj6gxvqe986KEzoJxFI2zRABPW5/eptYYcJY4TT/JT5Uree3CLg400wqyIdCFuisskhqXScv5B5+V/7kAmRGt57oQcFIyVRLGPO7SKEL5Cfp9+ZitbqPiVT3G81um/PdYMjQe5wxiGyk9RAy4lZTrBMAI5WCnE+h//VA9mTPl7O2JNwLQVCm8iw+KXsheOTYso7wNCoEUCnG4JWhVJca2roD5GuXAezhJXjTznjWi9wd+auSA==
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Thu, 1 Aug
 2024 16:25:29 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:94:cafe::97) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 16:25:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:25:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:25:08 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:25:03 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 6/6] selftests: fib_nexthops: Test 16-bit next hop weights
Date: Thu, 1 Aug 2024 18:24:02 +0200
Message-ID: <25a1268c23bea0c95bed2521a6d709111730eccc.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bd8f60-8fbe-41a7-70d9-08dcb2468e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zDa1gnaG2Zv1oJ8uwVXTrenm2ajOFBIfqd3ErPA+8qXJpsOfKX36YifQgEvb?=
 =?us-ascii?Q?UlYxS9kEYToCLhzxHK6tN30igLe1eq8BUiHCrMD2tsxgoPab15ggsHb5hG3s?=
 =?us-ascii?Q?c1/Ap4t3N+lFvDugr7R6bFSYPO9oYgtInpGszTUeK7OOt2k6OyIHFhg3tnvk?=
 =?us-ascii?Q?1XcDwXyKfFW1TXCGT86Z2f+EkbDFuy9BChrvUYpvHvuA43BVJutHadOEv87X?=
 =?us-ascii?Q?MdB78sH2VBAf4nMz1f9AQ+TXJ7AoV3H9RroPZaazTscK2IwKPT8FQnKlZ0vo?=
 =?us-ascii?Q?EvmYihwJhqf9mB22pT44t03QE/22bBhHtWOpm6Prm/Jgu0MpVWeY6eQyXXSp?=
 =?us-ascii?Q?1NCtc3lZ811L95OsUs2vIVRKLlY/CVe/GHsCtUCI3w3hBGCsDSoOa+UvAmq2?=
 =?us-ascii?Q?quz1UIQsTvH2LRz8IiYtk/g29JxJuKZSQkoxlYRAS6GA+6woxl9OdvnwUPIE?=
 =?us-ascii?Q?gk2Xuk9TBRA40eRvi6j/XiGU12f6ft1c5kbtJ7J4YbYBQpLTxZaBzVjlj2Mf?=
 =?us-ascii?Q?SY/d3EIqy+UhtXu7y35xUQqDCK2JHZ/ah1/hINz+ObknCfEp7NYcVYjnZ2GU?=
 =?us-ascii?Q?cRwFGYdrGeK9BD/x2Dghj75O4riJ0uCX9ApvLGU51ZvIBa/Wvchp2QjZ9/VU?=
 =?us-ascii?Q?+xWFZmuBeKhlLk3Xk84bMIUbKegr0hJpVBsiuo+zyU5tomN6fvc8YmNVadMW?=
 =?us-ascii?Q?4/DpwWRNRxuq7nZ+xB/9oExbaw00j8g8bjoMcY/lB682GKhrRv+KQeqZRqdl?=
 =?us-ascii?Q?QvnGoPa2MTsa2m6eq/h+bVRSf6RN0Fw7QPDPncki/mey4Q1Pg+6NtCmD1er0?=
 =?us-ascii?Q?KYspwznFAOH3R1RofEhkV6MrZ3XyZ5/3NGU1GQGzvNftuhTJAomU0EvNt59V?=
 =?us-ascii?Q?5174kHnrzQ9X0SbbUbrZaaYN6dTLqwsJkUIRVCHFBJzJNVa3Dejur9GWSA5r?=
 =?us-ascii?Q?1byW3tgwNF6abBxQ6V+y3K3GoJsRh4dZwURYrl6KKBasJsDMNO9yzFfWkJHV?=
 =?us-ascii?Q?0nANMvQLULBcQUNYHg2P+7+Qw1Nt9+TkD3QMImav86L5ow9wYGCqUvu/uoB9?=
 =?us-ascii?Q?3SwLwVGZMdsLhnxBbTWETgMzmPOnaz2MXMWsGQ7IRro/l51SfVqTa0T2J/+T?=
 =?us-ascii?Q?T10ysZ3RcVr58McsN+ObWhJOO1ZjV9smYJj0qbIZ3M7jA9Sr9yST6WZ8KidX?=
 =?us-ascii?Q?Lqn+Sc8Z6yZ+JXmPk59kEStAy/8QYNx3JL1udvuA+oeHlYyaSSEBHdsfFzYk?=
 =?us-ascii?Q?9YEhCOS3yxlj3ptY/XYP2IIifiu+cQA5vE6qp3P4OIKBClgZNDjec2j+TWKo?=
 =?us-ascii?Q?Kpnjy3T5ipDQtf8G4E2/waL0V4+Sij+TvHWIGk7YkLrDlB8gkdVOmqnQr2K5?=
 =?us-ascii?Q?ok2UStTFR6GOlry97TJ1OrEHlB0dAiJyMCiBHX4xtenO4/V5lGYyL6N37+61?=
 =?us-ascii?Q?2hyvyo+LErg+jyBkobkpf1jPsH1DgjAp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:25:28.5081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bd8f60-8fbe-41a7-70d9-08dcb2468e70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196

Add tests that attempt to create NH groups that use full 16 bits of NH
weight.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 tools/testing/selftests/net/fib_nexthops.sh | 55 ++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index ac0b2c6a5761..77c83d9508d3 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -78,7 +78,12 @@ log_test()
 	else
 		ret=1
 		nfail=$((nfail+1))
-		printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		if [[ $rc -eq $ksft_skip ]]; then
+			printf "TEST: %-60s  [SKIP]\n" "${msg}"
+		else
+			printf "TEST: %-60s  [FAIL]\n" "${msg}"
+		fi
+
 		if [ "$VERBOSE" = "1" ]; then
 			echo "    rc=$rc, expected $expected"
 		fi
@@ -923,6 +928,29 @@ ipv6_grp_fcnal()
 
 	ipv6_grp_refs
 	log_test $? 0 "Nexthop group replace refcounts"
+
+	#
+	# 16-bit weights.
+	#
+	run_cmd "$IP nexthop add id 62 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::3 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 65 via 2001:db8:91::5 dev veth1"
+	run_cmd "$IP nexthop add id 66 dev veth1"
+
+	run_cmd "$IP nexthop add id 103 group 62,1000"
+	if [[ $? == 0 ]]; then
+		local GRP="id 103 group 62,254/63,255/64,256/65,257/66,65535"
+		run_cmd "$IP nexthop replace $GRP"
+		check_nexthop "id 103" "$GRP"
+		rc=$?
+	else
+		rc=$ksft_skip
+	fi
+
+	$IP nexthop flush >/dev/null 2>&1
+
+	log_test $rc 0 "16-bit weights"
 }
 
 ipv6_res_grp_fcnal()
@@ -987,6 +1015,31 @@ ipv6_res_grp_fcnal()
 	check_nexthop_bucket "list id 102" \
 		"id 102 index 0 nhid 63 id 102 index 1 nhid 62 id 102 index 2 nhid 62 id 102 index 3 nhid 62"
 	log_test $? 0 "Nexthop buckets updated after replace - nECMP"
+
+	#
+	# 16-bit weights.
+	#
+	run_cmd "$IP nexthop add id 62 via 2001:db8:91::2 dev veth1"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::3 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 65 via 2001:db8:91::5 dev veth1"
+	run_cmd "$IP nexthop add id 66 dev veth1"
+
+	run_cmd "$IP nexthop add id 103 group 62,1000 type resilient buckets 32"
+	if [[ $? == 0 ]]; then
+		local GRP="id 103 group 62,254/63,255/64,256/65,257/66,65535 $(:
+			  )type resilient buckets 32 idle_timer 0 $(:
+			  )unbalanced_timer 0"
+		run_cmd "$IP nexthop replace $GRP"
+		check_nexthop "id 103" "$GRP unbalanced_time 0"
+		rc=$?
+	else
+		rc=$ksft_skip
+	fi
+
+	$IP nexthop flush >/dev/null 2>&1
+
+	log_test $rc 0 "16-bit weights"
 }
 
 ipv6_fcnal_runtime()
-- 
2.45.0


