Return-Path: <linux-kselftest+bounces-15770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DFD958543
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C30428A944
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7249518DF6F;
	Tue, 20 Aug 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZbFFhNO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB018DF6B;
	Tue, 20 Aug 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151275; cv=fail; b=ilpcHfSL4Fw3nOo8SR54rDE9t8sMnzJym+wZ87UpK4az93a/LGlF2tsrMwWN87KFbyIX+lAYSwvAjOc72lbwyujzy5kKE42jf1a3xY7+OmQsSOs3u6nTuASPuApnuTCR/BtO4ivQAV6n5uYPnnJuzG1AIfDmt4nBPwnksQnkzn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151275; c=relaxed/simple;
	bh=tVsBbx47IsJIxMlnohvmjsBFyRVcprqx6o8/b7hq9hQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fc61xaqMHYWI8r9/h0ofCOv0G8elyvSVNm+bzPzNLQa/e5G2+oX9AZ9H6xakvrI3GybUFZtfMALpWgI9GF3591LJPdDWO8/w5t8lpguao8N/OXQ1NfqjkYCIHov7iJ1OjvfcYu+QHEn2IJ1SbASZgnc2JKbIKluDGjgVew22zy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZbFFhNO; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svYZwpaQiHp1yef/bogvUicv52tWYhxBLcBqv3Mjb8hm/W7duqsJLY83AtZp5jZw4O6l9zoEUiMZnOrb7MbaxyN1abwlwIsUiV3hqgH1EHIoPIEfVCMVW40fLyg4CFNxKOtOj/j21x0PTXXVy5paJ726hE7XO9IgX3Kbic35h1iWt2iisTifu6ntCuky2VEA5oSR9FMLgU6OepGAnk5fMKT50Szl9SLkQmxNie346i8Zfy/B998mSZ+LuXUQhSB4LPsMaBXWYhbXAFKkIjbJe1uDqbmyxRwPoLqx0+MSxqbCou6o1NKOgL/aln/eElvv6Y/+H4uPLxFoxxogUTK8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJQENSO+GZEfiI18vz5SdUPMOkV/TWlJX7cpkfwyaWs=;
 b=o/8IPGqBlcjYN6EYDAgv1a1loQOtDptAm4qDFqrSzGlTwF448DwSBkPMP4d1H9yDDAQI51cCccasL/+7zWmd8BppHwX1Pq/MBGAOsKowVA/oBmwk7owzfd/B+yoWDM4rhGMvusNhRXTBYsneh27caaoRXBlFR7yqofEgxnl3N25z8xFi9aAq+DumgGI5wWbhdNaCyRM4s+NViTMXmQ1765RuCFpC7X7wqDLBREFOeqBxDWJWHiNr8lqDVCXMBzaJK8rJk/RpE1kRnKQwBhoobgZHEsG8Zlbdp5cRYaRREVfhdgA5yQwWuJ7fkQx269ePEqqIuETeVYi8+jzFLPslpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJQENSO+GZEfiI18vz5SdUPMOkV/TWlJX7cpkfwyaWs=;
 b=dZbFFhNOBz2cBhHOn68zOvyA47NIbvzlBohhxv0pE1Dy2CqX9xnyp5zBQwsogK/0a1BTGv73zWYC9gbSFcTGKKQMWFjr2lokuSKqxHsFebgi2oUPXPMwOSlqYWdTfYxC2sK9P1FtOCleoI3to0uLXcP3blyUwRLtINL2yIYWkJZWgNCO8/Sbb+4qf3ztiBwyi5kHQKMWLSLbTyGRHlirigJHnOrvZ1CfknvRl++GScotnuyKgIZOI2lhq7ZmYEERqtpGkPKZiNoZ7v1812+VblzshKkfrB9FcvrAEUsRRNd5a87bkynXBVf4ZyXm2/ijGsqt1SqKjicxWRWo0gf0pw==
Received: from CH2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:610:4c::13)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 10:54:30 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::20) by CH2PR10CA0003.outlook.office365.com
 (2603:10b6:610:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Tue, 20 Aug 2024 10:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Tue, 20 Aug 2024 10:54:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 03:54:18 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 03:54:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, <mlxsw@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net] selftests: mlxsw: ethtool_lanes: Source ethtool lib from correct path
Date: Tue, 20 Aug 2024 12:53:47 +0200
Message-ID: <2112faff02e536e1ac14beb4c2be09c9574b90ae.1724150067.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa1d8c3-70c7-47c1-5a54-08dcc10677a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KbBxRlGr/pPLi2+a4617vkzPwhnmZOnAR9uuSnfqPXL4HkLRjrqGIEiRrdOd?=
 =?us-ascii?Q?owUUKfzbe4XXuD33b9WER/70O9c0oP8qRkM97QEQ9z3shqvwopdYaoMSATU5?=
 =?us-ascii?Q?LKzedetkAqLQTei8yqorSQ+/O8q0sAjh432WdjIjpv8W7t2MVNCAI8uEulVa?=
 =?us-ascii?Q?xIi6/mX8J+ByZ9wqpH21yJTEWR33SOrN0F8dLsHTavRHCyhtfErrPhZ7fdnP?=
 =?us-ascii?Q?ViT67B9Qynjf/ea2WVTiXQCyXxFkx0QrcouWrr0cT88zIpbeN9sI8kY3Y7y5?=
 =?us-ascii?Q?L7x2nJGxnkyfswzDMdjk5WS6yGPOOFqQlRAMokkG3lNayMhVgclGs+2GEOCh?=
 =?us-ascii?Q?Oib5FKS62EflVDrX7HKu4sNLUkvu5Q2XYQWnPm+/BLlAOa59qLoL4GrSBZFF?=
 =?us-ascii?Q?PRXcx1kVSy6hEizvikJqxAmlae3/GR1l2pGhbKhS/aje5VlD3JV55L8UjxZc?=
 =?us-ascii?Q?Lxt++ue0/GOmocDO+m+KAQLYif0T1R4UNi0dOlvEhkZpDryoM2EGQbVKCu7t?=
 =?us-ascii?Q?YyzbTMVkmyeD8/FAc1EOfZKvrzq4zuUhOw28DXIlFxnx781DEMFUJE3OPtyY?=
 =?us-ascii?Q?4GuRQx5Fm/jKpm/rfmRMtpaRRXwy3CMZIcIRw4LWOZZmHoLwhKdrDeuvKuvL?=
 =?us-ascii?Q?OO1EUtB1OrrXt0ywgCp5vrFhxzKDtZ8ivdluJyL5seDQRAueHQAw5BWxTHdq?=
 =?us-ascii?Q?GX5NFs48qAZFF2WTVckub0SQM8ylFD4dCTy1gI7LtFJS4ZYPX25VwY0SMnZl?=
 =?us-ascii?Q?WxxiYLPV90ZE598/PPp0iUVPxueGKI4ytWYW6sfOEjYBoYURmq/XRQi7uIXK?=
 =?us-ascii?Q?0xEIWqTzeqESBiBlEgF5qzI/Kie5ejqLOTGnRPzlyoT49dFYGsmxWso1Pw78?=
 =?us-ascii?Q?Xqy0GvhS0kzNdDWjW9jPv4kvP4KF7pmQGu41Ir8yyQjK5A37BxdrrcajhMwc?=
 =?us-ascii?Q?RiyxuDzjME+rwLqfZKM8L0SMolgpPn06MT8Pzr2J+tj/puFwRYmy2hVXk8cD?=
 =?us-ascii?Q?8tcrHkKFHPv3LQUgq9oqFwe/h37aeefz5L7/V8TtqdQ+xYrWZZkyxfeJXppe?=
 =?us-ascii?Q?xkMFi3I/U32LMzFuJ+sgYHl+KM8TbJrBxr9PcI6A5jxLm7m2ftVUL/ss8eku?=
 =?us-ascii?Q?mnlHVg6x7kMxdWPcB/sXw4cQRZgxmLRvJ3Ln+MzLEWEmkE2PbrGJyxWOjWNS?=
 =?us-ascii?Q?8zGIrl8vxUdLRxVYtXqWvnItSevIVbWaQcbNGy76LIbXpGg8usQG6o1mLrxf?=
 =?us-ascii?Q?mEbdAQFoPs8r7+S075i32fnIjy4Ug7w71zv8X4qCBUA3lfZD4y8sKw5VRFif?=
 =?us-ascii?Q?PYBE78wbphj8IbGTUjaVnrEGVgv0EOjx8YOoxZtk3CSYHi5Oc/jqOsGjTQhe?=
 =?us-ascii?Q?IkVOTcb3KeoVXYn5Gcegwh3wGOZFyeNs5VOkLqQ0m7Ph9zIaFUGKgPNo1t7f?=
 =?us-ascii?Q?PxBNcfygzH5KQ0uZ9bxMCYXImF4n0IMg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:54:29.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa1d8c3-70c7-47c1-5a54-08dcc10677a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

From: Ido Schimmel <idosch@nvidia.com>

Source the ethtool library from the correct path and avoid the following
error:

./ethtool_lanes.sh: line 14: ./../../../net/forwarding/ethtool_lib.sh: No such file or directory

Fixes: 40d269c000bd ("selftests: forwarding: Move several selftests")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh b/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
index 877cd6df94a1..fe905a7f34b3 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/ethtool_lanes.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 lib_dir=$(dirname $0)/../../../net/forwarding
+ethtool_lib_dir=$(dirname $0)/../hw
 
 ALL_TESTS="
 	autoneg
@@ -11,7 +12,7 @@ ALL_TESTS="
 NUM_NETIFS=2
 : ${TIMEOUT:=30000} # ms
 source $lib_dir/lib.sh
-source $lib_dir/ethtool_lib.sh
+source $ethtool_lib_dir/ethtool_lib.sh
 
 setup_prepare()
 {
-- 
2.45.0


