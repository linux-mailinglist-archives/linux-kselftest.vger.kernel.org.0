Return-Path: <linux-kselftest+bounces-22879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4B9E5B97
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E496188629D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520121D5B4;
	Thu,  5 Dec 2024 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wxx3g6gV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE98F54;
	Thu,  5 Dec 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416750; cv=fail; b=ZSVhAZEDnSZLSN3Dj2dAnwBG+JsC6Oexl5wMWcHUQS/BC2prj6tyYSgPYkkgfiom+ZzrebQc6qDW77eGSmizV5VjcHcxEZZFC4jboNyhCZ0n6B6vVy1V5G3GWv7vyyPcDCxsv40gZQBmIKolEjWLEnBCYhjdnX+CD/Ni8cOnERc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416750; c=relaxed/simple;
	bh=gn3Qx77bag29bpsqdRmMEJhMfnZkFuWR/AVScEgtj2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Scw9RklmQUniCD9QXAQ4PS7Oec4ROkrCk7UTAfOVBGQzZsRFVsRYl+HDXQf2hMOM7czfnyymN62+9EuTAUNQOFzWAt65jghFiiUJI06NQuxTYtUx/32e4iFQpbi2brW8XwNKJLn596Nt7qJfBu9awzwvyutRVLAnK6GKJLH+F7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wxx3g6gV; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD5WM7bYRplXRDH5rG6+9xyCFTmYpO8L/jUYQDejK2+OsT3AAz6KY6MwEQbR35lo7PjdfVlk/HoviNphVW0+MuUo8MYnWfZEVUOnndeTqnT1NwNERquYmIe3epw/U2Q8i9mEmZGp0NKL23uojOR7WeKi6zHZMmM1ps5tzKTa06PZN7FOceRYLTe2gwqt6akJc3c2l/1rgPVXJDgKc5/PV65nVMNXBHeO2DBkJRb10aGkSK2GpZtqx7ZtPouYy9hRecyRqufIUcH8ii+ILw8XITRpBo+r4gzmLnAZPSsnN/7+Qf064AlQJMR1fTxPFwoZl7aJvuZoBcpRFGeZNEsprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gvj5mjwuZH37HoV6Vcicj+p3zWGHCTIJeChPB4uTtA=;
 b=VMFR7dfu5IVkBmPuLvM4ce75KK3tCFJq6UuTjw+X5wqtpHbiciDIN3rP3diN8vEW2obS6YiI6oWav0RkvJHKZZXHUtucGzkBHBLuYRHimqIEH8KOHO2atxKmhP53Isrja7+oz2KKt8WJO2SfyJpxjQWRGRFmtXf5wfD8YyiuglqU/nIZTtMavbENsSC+3WNkMCq5cxXveHGHW0s5rky4Kbtjt4xgAd9XcOt6JgtSi/q5FIHASTChWsfk76YTspe11kG/n10XEiFEFg2GchuhqMHpWMwbCIl2JhTrwTSUQjj5szc4n9hznVqjQN4PI8vpaxFvhc3u5aEs5JMu1KLG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gvj5mjwuZH37HoV6Vcicj+p3zWGHCTIJeChPB4uTtA=;
 b=Wxx3g6gVY32G4lj7ytoqPzwGk9ZOBhU5CUU6YEPj3X2N74MPd7jpT/1QgdYXM6NKAQEbFUQMSGEkg/fXePIW7/PGpRV7hF3q8JelwCeB2Dhr2UrmXdcS8VT9m1bVdNMiHvTP39WiF7hVwPqymNb1+35yoybpxnnd724pOHOKaq1itEW1x3PdU7pKbgBXYHhr7UCBsMjqxCsGt+M0u+df8obYxWsxBSuNVePwMXwTVNW0or+pnntP5CXFdT6b5NpOMCnY/yx7SWebC2pITbYwc66ErfExllnbd9Jf7VtcRkD3MPah4GvnfPUokcmGb9+I1iuytAgju210wKykXCKCOQ==
Received: from SJ0PR13CA0165.namprd13.prod.outlook.com (2603:10b6:a03:2c7::20)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 16:39:03 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::26) by SJ0PR13CA0165.outlook.office365.com
 (2603:10b6:a03:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 16:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 16:39:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:47 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 3/3] selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted
Date: Thu, 5 Dec 2024 17:36:01 +0100
Message-ID: <64c28bc9b1cc1d78c4a73feda7cedbe9526ccf8b.1733414773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733414773.git.petrm@nvidia.com>
References: <cover.1733414773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: e8de4849-2849-4945-1cc7-08dd154b5396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3I2WixEqbhlu+xv+TkQ07DGrU2x5e8ZNa279pFrWwC4c4SQyCrfwrOyWXuVg?=
 =?us-ascii?Q?pJ4YUjvTRFdcKavcCr4XgbEMjWhSuVa/tEHbYTn4qfoLuvoI0g5tfMopwJXE?=
 =?us-ascii?Q?uwgrRz1j40rUg2QzQqUi0I6R5BE/r9+8ZFz2KHa+h74ZpnuBCf0A5Cmurr4N?=
 =?us-ascii?Q?IjW52wEfE5DdeTHz5Tsn4+B271NlmPrF+EN9kXG3/cInRgT/yBlPOXQC6gDj?=
 =?us-ascii?Q?0nPOK+8OCHdUq46IAQeSMese0NGeS+kg6Ds7dSJAHJrBZCXttPeO81i+Ebuc?=
 =?us-ascii?Q?hPlz8ve0fKcHFCrqZBrfINnn4/1Cqp3MH5lILqB77arO0ryY7a7FdnbKExpb?=
 =?us-ascii?Q?Z2t7R3BOFUvSBf3h9DD9nZGRs5cPdYj2QHbcFXff1GcDUm25wdd88WQOcBBS?=
 =?us-ascii?Q?8JQgvTnsOcNuFt5euKfn3ENiuv7DEO8HbCjcdf4IUb+5QG6MzApg99fquP5M?=
 =?us-ascii?Q?rilLNcKWgs3o4ZJ8Tq98hPJUh+cwMqXnAR9A27SlIz+FvCA8uSw1g/XNTlDL?=
 =?us-ascii?Q?5+0WFmqNKV5fO77OcNMluUy5NuP20BPTxTwOynOEv79o5etHmI25JLvXbCJg?=
 =?us-ascii?Q?DCMBzelCgTOdiQbNJGc6bCdeBbXyVS/8AP/2TFNPETmhvgQzTd6IfrAidA9w?=
 =?us-ascii?Q?OWz1BtfbnqB8pigTopJB7RyidL4vA/KSnY6vKnGztTylDupDuXP8S4he7lyn?=
 =?us-ascii?Q?T33xC790YnPyVJJr52tJ8m0GY585AxCNrEjt0jERisGLXbI3C1VuGPuLzUUE?=
 =?us-ascii?Q?56QbxhgRIfsVPVjygqEkx2M67FXHsGlAKCP/P9+wszHXzWehd3KhYBorvMNz?=
 =?us-ascii?Q?WRyryT8fU4qY62fOV7K5hPeCmBguGrFPgrNSsQu93B6mEyHtFcc1rpR/9z6W?=
 =?us-ascii?Q?zkD8RNdKiYYzfqmS3Zzog1akTdg/atpmDV5I1jG9no9gZyq2mUGqiwKOZg1B?=
 =?us-ascii?Q?5ZdRsqK/k/NK2lrMZZ2xH3Y1xoWkjD1kEwWl72KVSkmQYxMYusB4u17z+O/p?=
 =?us-ascii?Q?dxkCpoWzFl96f7oQVlNpE0Au0d4PIgTvSCd2QGA5OTyIkRODvUv8ciWfOwtS?=
 =?us-ascii?Q?HlSkY03eKe8SzV9QrVE0Wi1KME/n/ZP+NfokiyY1mLKLRb4m7tvcJ5r6CYqH?=
 =?us-ascii?Q?eXYx5BOehw2KifhHRwCQwIY26W1dAAyZjMhfekPhhyDNuvCvvXABeHg+xcYc?=
 =?us-ascii?Q?6d0YRG3FMfEZB2sbqn8IHhIJy3lSg43wudG+zHiXK25SubQ5uVNQcemZtLp+?=
 =?us-ascii?Q?mFnL6eoBqHzcGSVGESPoTVvwMc78VzB7m/gmXcehGhoZNWDaIWgAtvYbuwVa?=
 =?us-ascii?Q?OBSG1auY7yYdTcWCRcyjo0AHAb+T6bJA+u70DumQz6ZMxJBOj6L3zyEgbH+r?=
 =?us-ascii?Q?81VA0G7H9ceKI9fVSDkKy5kDL436P/iaMhlB/ZyppVyM8nNlDNBnm+2hr5dR?=
 =?us-ascii?Q?A62Zilb4pdrGFMPvWrv5/SGrgAcpHF/8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:39:02.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8de4849-2849-4945-1cc7-08dd154b5396
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912

From: Danielle Ratson <danieller@nvidia.com>

The test assumes that the packet it is sending is the only packet being
passed to the device.

However, it is not the case and so other packets are filling the buffers
as well. Therefore, the test sometimes fails because it is reading a
maximum occupancy that is larger than expected.

Add egress filters on $h1 and $h2 that will guarantee the above.

Fixes: a865ad999603 ("selftests: mlxsw: Add shared buffer traffic test")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/sharedbuffer.sh         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 21bebc5726f6..c068e6c2a580 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -22,20 +22,34 @@ SB_ITC=0
 h1_create()
 {
 	simple_if_init $h1 192.0.1.1/24
+	tc qdisc add dev $h1 clsact
+
+	# Add egress filter on $h1 that will guarantee that the packet sent,
+	# will be the only packet being passed to the device.
+	tc filter add dev $h1 egress pref 2 handle 102 matchall action drop
 }
 
 h1_destroy()
 {
+	tc filter del dev $h1 egress pref 2 handle 102 matchall action drop
+	tc qdisc del dev $h1 clsact
 	simple_if_fini $h1 192.0.1.1/24
 }
 
 h2_create()
 {
 	simple_if_init $h2 192.0.1.2/24
+	tc qdisc add dev $h2 clsact
+
+	# Add egress filter on $h2 that will guarantee that the packet sent,
+	# will be the only packet being passed to the device.
+	tc filter add dev $h2 egress pref 1 handle 101 matchall action drop
 }
 
 h2_destroy()
 {
+	tc filter del dev $h2 egress pref 1 handle 101 matchall action drop
+	tc qdisc del dev $h2 clsact
 	simple_if_fini $h2 192.0.1.2/24
 }
 
@@ -101,6 +115,11 @@ port_pool_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
@@ -117,6 +136,11 @@ port_pool_test()
 	max_occ=$(sb_occ_pool_check $cpu_dl_port $SB_POOL_EGR_CPU $exp_max_occ)
 	check_err $? "Expected ePool($SB_POOL_EGR_CPU) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress pool"
+
+	tc filter del dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
 }
 
 port_tc_ip_test()
@@ -124,6 +148,11 @@ port_tc_ip_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -b $h2mac -A 192.0.1.1 -B 192.0.1.2 \
@@ -140,6 +169,11 @@ port_tc_ip_test()
 	max_occ=$(sb_occ_etc_check $cpu_dl_port $SB_ITC_CPU_IP $exp_max_occ)
 	check_err $? "Expected egress TC($SB_ITC_CPU_IP) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress TC - IP packet"
+
+	tc filter del dev $h1 egress protocol ip pref 1 handle 101 flower \
+		src_mac $h1mac dst_mac $h2mac \
+		src_ip 192.0.1.1 dst_ip 192.0.1.2 \
+		action pass
 }
 
 port_tc_arp_test()
@@ -147,6 +181,9 @@ port_tc_arp_test()
 	local exp_max_occ=$(devlink_cell_size_get)
 	local max_occ
 
+	tc filter add dev $h1 egress protocol arp pref 1 handle 101 flower \
+		src_mac $h1mac action pass
+
 	devlink sb occupancy clearmax $DEVLINK_DEV
 
 	$MZ $h1 -c 1 -p 10 -a $h1mac -A 192.0.1.1 -t arp -q
@@ -162,6 +199,9 @@ port_tc_arp_test()
 	max_occ=$(sb_occ_etc_check $cpu_dl_port $SB_ITC_CPU_ARP $exp_max_occ)
 	check_err $? "Expected egress TC($SB_ITC_IP2ME) max occupancy to be $exp_max_occ, but got $max_occ"
 	log_test "CPU port's egress TC - ARP packet"
+
+	tc filter del dev $h1 egress protocol arp pref 1 handle 101 flower \
+		src_mac $h1mac action pass
 }
 
 setup_prepare()
-- 
2.47.0


