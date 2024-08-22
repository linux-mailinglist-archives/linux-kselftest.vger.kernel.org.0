Return-Path: <linux-kselftest+bounces-16066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6C95B7B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E4E1F25BA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549871CE6F9;
	Thu, 22 Aug 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkqIRJHg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCED1CB15E;
	Thu, 22 Aug 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334768; cv=fail; b=SKFVBKXfgtt826CSxKZEbh//iT26XC372rSn0pF6SCu5dS43W6T63ks0rqIptLT978f6FafbUeoCPhbhxSI1x7rJdtXgwlGfHfLOfoSRYx49Z8eZNmjwRfjdgv/arktp21pE5TNC5Mu+OprH1miyEd1ed1hk/etyGiz196wm8dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334768; c=relaxed/simple;
	bh=N+OgTknEiGlJ7tsxZpigeDGHbnbnl+0kvj5NRxJFmx4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQ0B35GGTPb20/VOaysHXyZl5Hj/Roe2zDSb4fzo34URIE+w6FZAzbwrIwchCPCWAA2XtW3q4S7mCO0WyQCRr16cbFFeCo1IVMybqskQyGzbZ44W/XvLIG+Y1lsXt67pNCNmbz5s8sY5N/JFnr4Jc1KZtNQdDN5jKNI9Hi4oJFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkqIRJHg; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxC8UzbRxaKeCxUZLa6mIWale+j0PgprpN8CXUMEiDxG9GnUYe7hDZ5nmrNUlnqEDVp/tfvlXf5CwipX9pfeqqUJE8g+MCSfk7XLYL7YmgOJaT2p8eup5CvHaJs6lMdUsjDJOzfSk9KZwJlQAZPL95PdJxInrxwVrwrvi1OJlNH/z5eBNuL9Xe5TV6SjOHxq+OgkmdhhAl+zsxJOlhdV6ntrhpxIJwuKoBirCe5qJga28nmnAOG3a9XASLYO0337HOmuWxkF8LT1MgEbNkoQOGIRGlJOpTFBE41OxLmLvVANIK+XtBe+c7WOuOtJeciElGFBoRXqJBpqDnL6u1TAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmtDEl9fFfzue4lrx1mlELcjb4p8Jwr+JA7Aeb8SpNw=;
 b=hvJeCvBNJUOLHZIWwE1iAkAtlmUjV+9MO9buWoVrNDDmgJL0OyfmiLMHdEc2Aln9/EwwtLpk12H7NUxUxB+WgAX8C8TO4cXo6Okccmb4zEsQNpQI+vS7HBQ0xQKDW6mxgkt5d9zA5ExanzqlZsR6vdM456qYqYQbG/evwCsgmk9FUT2MXi7PV/RHtiCkJa6kYegI7ymwSojlgBMxMZipEsPI2XR1i9c5pTW3MrHgdpuPF72B0Ijf5vbd3OvhqvTzwH3Q5h7n+9uxXviHTlQ2gwbq5SDgAm1sZAWLUhsX5RQVMrGT339UH/KjghEpQcnu8R2RqRCYR8CbHPlawi1PYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmtDEl9fFfzue4lrx1mlELcjb4p8Jwr+JA7Aeb8SpNw=;
 b=SkqIRJHgrPJTY+K2MnL3VgzMROoNy41cP0HLRhjOdkxBwrWuZSyD2KRMu1Fm5AHoFTfBo2cT5oCOlnMXkUJGmgfP3bXrs/9xjtqs6Odj9Mz7tDowzTFhH1km/m0izmGvzg9D/770DvzMTbvVm9UAziYT8XUsjIUPlOcQp8aoCrsYzOjzBOATRvpezQgZty/HcZNdtTnqyHLYVjRzGDUDnjPlZMD5s3lanLClC43iF4DqRxsYLJZCgzkqGp/plw25SwULFooKgfy9RzYdEJSwsKpr4jVmeY1YNBeBf+jCFsV+J1ym5Zz+zb1NhdggbhwEHUrrH/1+/VfQO7aGe3ZtSA==
Received: from CYZPR14CA0019.namprd14.prod.outlook.com (2603:10b6:930:8f::10)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:52:40 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::ca) by CYZPR14CA0019.outlook.office365.com
 (2603:10b6:930:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 13:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:52:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:23 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:52:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, <mlxsw@nvidia.com>
Subject: [RFC PATCH net-next 3/5] selftests: mlxsw: sch_red_core: Use defer for stopping traffic
Date: Thu, 22 Aug 2024 15:49:42 +0200
Message-ID: <6dc79e54a02623f0f2bb11533be1dc230ddcecec.1724324945.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724324945.git.petrm@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f74e378-3c41-4387-3742-08dcc2b1b063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KawfLEU4S9VRscXXH9p8zfXfJpYWb2wo+9PZnkW1CxeoXuntoFVjZU0mXBb?=
 =?us-ascii?Q?0IipFA+pcmuBuzVw+rUqroa3syBAa0D91Q180qjNXZlwlTbvx8I5rPuRaM4L?=
 =?us-ascii?Q?4Vta6VUDtrvzb0gkSKcZgyt6oscCQE8RVevUSOQN+PTBUWjJvOgLDBcM4tuF?=
 =?us-ascii?Q?lSVwrSuWmMm7FIgeLRNjokG6T3B5/xImleB2uOJpIkkc5s78lDCEgHeFfSev?=
 =?us-ascii?Q?I1kvMNDuPaaMq9pGfSGY+UiOAKv1AOO+sBkhaQeoz4N4yax7PRnc4L5evtpw?=
 =?us-ascii?Q?7ODskRmHFcFBQZFnXYQFSrYAA8+skZPf1Qaif+62vOLSC8YNoAnR/5QbuwSw?=
 =?us-ascii?Q?3FQDxtenhP8nKy7rohLkxrK7dzJ3dMSdw5TXeEwGrKa21bqI6gtsiqxvbKFl?=
 =?us-ascii?Q?C7Fx7T0qQzl/0kmfo8ff7u4Ro5finrEVrwvBbLhMq+55mTphFtUv2o39vyA7?=
 =?us-ascii?Q?m+iA9OS2ajFDmrMAe+LNT91bsZZq53ECdDNaOig2jfsdPauM7ZsO60wCfhQD?=
 =?us-ascii?Q?ryikqP/zTTnQD94y2Z3MK5Rc2CLG3GK3+oy99S+dZwVWwH1taRKbSUOEHf5K?=
 =?us-ascii?Q?Vnu/2Ju9JuRf1PKIgtjCWu6FPJXgUL0DVcFpDDESjnc6u1w2/zK28LDBl/9H?=
 =?us-ascii?Q?3YmfxeJ54vwXK/olqcOuoy4Udw4o/WdesauZmSZLgUCiNBGnfxVD/Piu2Qgr?=
 =?us-ascii?Q?4gvTLj0EZL4gZ8FdK1b3NyYuzV5mXQPthS+UsF/MNN4V1y3plZBri9BJzkQw?=
 =?us-ascii?Q?T22rmYR9/8GGAp2A0uvBJX8ccRAaLQ1iD5bUFbzFJEwEN/bO1sGaH8A1Paeo?=
 =?us-ascii?Q?oB0baeBapScHKT1AwW7crpWODZ55XoM7X2cNpQn9/fCIfwazKWBDpdIug6cQ?=
 =?us-ascii?Q?/No5rcButnu0/Sw0K50xGr+Pv4KeXLrdHxRapJ5GkQLGOAimUwa3BRarx4Ei?=
 =?us-ascii?Q?kiruD87cJ6uvio/g3ai+jIrfosVaIWibr3fq5+/ZCgB7KCUy8jiKezxvRDJO?=
 =?us-ascii?Q?O8LhmMz2cHGzo7Z2rB2VWnYhcGemrwSXNeO8k+eEwvsi5LRpT+5A7cPQZnq8?=
 =?us-ascii?Q?5hfG4I0av2+mxTfEBhIVlv8Syr+VLsHR6nekhfkgV5Bf0qgtlwJfrrk9LNi5?=
 =?us-ascii?Q?N4/2lEtToPounzH7Suf/+uXJa4t/4ldydtQs2L1hU/bEmX923K+88Iz+6vHC?=
 =?us-ascii?Q?uTt2xSeFEDPBDFZmp9vv4D79EIA6Pt/TXeZzIyHNtCugfJmOxsYKoiTNdt/D?=
 =?us-ascii?Q?+Ipj0UWgZ1HTlhLbe9W4h+hl6q0lAhSsj1EH0HaTx3fqFgPClKL8kqhTdQux?=
 =?us-ascii?Q?e6U6ZU8czDhQwhF87M8ci+tzylk+hxEoSJqaGBlHUW08wlqmffNVDmgor0YN?=
 =?us-ascii?Q?HKif1uaqiU54j9W3LTrxg7dOI4I94avltilCXZqJuonOLb6qbmPFCceYRDKF?=
 =?us-ascii?Q?hZdxePlEZdOnoqjcGUGDkwwLKH11CWBM?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:52:40.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f74e378-3c41-4387-3742-08dcc2b1b063
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

Tests interrupted part-way through leave behind a running mausezahn. Use
defer to schedule a traffic stop after traffic is started. Mark the
functions that run traffic as defer-scoped, such that the traffic is
stopped right after the function returns.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/sch_red_core.sh         | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index 117a99fdbba5..c917b88d300e 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -415,6 +415,7 @@ __do_ecn_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic
 	sleep 1
 
 	ecn_test_common "$name" "$get_nmarked" $vlan $limit
@@ -427,9 +428,9 @@ __do_ecn_test()
 	check_fail $? "UDP traffic went into backlog instead of being early-dropped"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP early-dropped"
 
-	stop_traffic
 	sleep 1
 }
+defer_scoped_fn __do_ecn_test
 
 do_ecn_test()
 {
@@ -456,6 +457,7 @@ do_ecn_nodrop_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic
 	sleep 1
 
 	ecn_test_common "$name" get_nmarked $vlan $limit
@@ -468,9 +470,9 @@ do_ecn_nodrop_test()
 	check_err $? "UDP traffic was early-dropped instead of getting into backlog"
 	log_test "TC $((vlan - 10)): $name backlog > limit: UDP not dropped"
 
-	stop_traffic
 	sleep 1
 }
+defer_scoped_fn do_ecn_nodrop_test
 
 do_red_test()
 {
@@ -483,6 +485,7 @@ do_red_test()
 	# is above limit.
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic
 
 	# Pushing below the queue limit should work.
 	RET=0
@@ -506,9 +509,9 @@ do_red_test()
 	check_err $? "backlog $backlog / $limit expected <= 10% distance"
 	log_test "TC $((vlan - 10)): RED backlog > limit"
 
-	stop_traffic
 	sleep 1
 }
+defer_scoped_fn do_red_test
 
 do_mc_backlog_test()
 {
@@ -520,7 +523,10 @@ do_mc_backlog_test()
 	RET=0
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic
+
 	start_tcp_traffic $h2.$vlan $(ipaddr 2 $vlan) $(ipaddr 3 $vlan) bc
+	defer stop_traffic
 
 	qbl=$(busywait 5000 until_counter_is ">= 500000" \
 		       get_qdisc_backlog $vlan)
@@ -533,11 +539,9 @@ do_mc_backlog_test()
 		       get_mc_transmit_queue $vlan)
 	check_err $? "MC backlog reported by qdisc not visible in ethtool"
 
-	stop_traffic
-	stop_traffic
-
 	log_test "TC $((vlan - 10)): Qdisc reports MC backlog"
 }
+defer_scoped_fn do_mc_backlog_test
 
 do_mark_test()
 {
@@ -554,6 +558,7 @@ do_mark_test()
 
 	start_tcp_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) \
 			  $h3_mac tos=0x01
+	defer stop_traffic
 
 	# Create a bit of a backlog and observe no mirroring due to marks.
 	qevent_rule_install_$subtest
@@ -584,9 +589,9 @@ do_mark_test()
 		log_test "TC $((vlan - 10)): marked packets $subtest'd"
 	fi
 
-	stop_traffic
 	sleep 1
 }
+defer_scoped_fn do_mark_test
 
 do_drop_test()
 {
@@ -603,6 +608,7 @@ do_drop_test()
 	RET=0
 
 	start_traffic $h1.$vlan $(ipaddr 1 $vlan) $(ipaddr 3 $vlan) $h3_mac
+	defer stop_traffic
 
 	# Create a bit of a backlog and observe no mirroring due to drops.
 	qevent_rule_install_$subtest
@@ -636,9 +642,9 @@ do_drop_test()
 
 	log_test "TC $((vlan - 10)): ${trigger}ped packets $subtest'd"
 
-	stop_traffic
 	sleep 1
 }
+defer_scoped_fn do_drop_test
 
 qevent_rule_install_mirror()
 {
-- 
2.45.0


