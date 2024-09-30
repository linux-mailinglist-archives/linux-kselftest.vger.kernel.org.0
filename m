Return-Path: <linux-kselftest+bounces-18654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8377098A84A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72E71C222DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E70818E758;
	Mon, 30 Sep 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NMSqhbyq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3A3EDE;
	Mon, 30 Sep 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709374; cv=fail; b=P+FfB7liHx3ZE5Vq3IQ/XRsM8gVfyypX8/zK8eyi5iJ+34RtKHicYlRWJsaaHapT1hGRkMROQIMLN7KvlBOB/x6EUeug+I7znayLQE/peA7WfJzXZSWYW3MW1V4TA8DuLcA2pgziQozmYA3UgoSVP8jO7g9HXGRmucGzlQe23/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709374; c=relaxed/simple;
	bh=N6NZIag3UlamTydbjpe5lPE1MzvGF+xKKnYUBVmeTwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kgCLmUy3g4cnXaCgfYZO25IYXzk+jdJh1tH/byLF9wgAV40+dR9SwZ7EviJeFdTxywIu46QOEUxKnqy6RVjEQ37AMevAiAaKJ6Ecqso4aL6cQZRQinNPNGsiOze3JtPW6FutvbYSYrKaF07KvNo04nley0OyQXUL4HYhAdPetxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NMSqhbyq; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfE2GEbM9n+7RtH4RyM+UMReWdCpDUtiXsVKaB6aKsJ0laPH6RTE7AMI67T+5Ga2WstAdD+7S+Q9xZcmgFBlGxRQk0F7S/vTQbKx2oM8t8n0QDRvC2hB7Qd3/fp+fAyDPJPFGVMot67Bb3DpOCs68dU70G5j8kEPeA0qGKh+3BBIMt9ISHUlk2PldPjy5vKWHNjcNFuSgYxkcjVWCaa0dmRufHD00GIGeSQ+l6nzgVn19ZxBSp7U2NeMMtMsZ0llbon7SGWqcV2IOirFMipr7nalr5QMDtX0jTkU4/s3oSgPtJj499INhI/OsNVE/A0rHrXrO+v6MTzFwfKNvuC5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGcCZq6JcevAw4lKMEeY+0xBg8HO539P2IGv+n3s+mA=;
 b=M7Zd+VG7gr7rqf4z2P1yXUwzqCNt6aTuX1dYNZVyBCq9mvdFi9ZfFrgNMxqiz6flFQSKL4dDdvpE7wV82gY0JY7ySifvM60UUVGpOSQtvVL8Mt6zkEQ8TBAQOyfnvQTLuFZebI4Hiet9n5Ysk8GGAlegAwHsrb+cQ2S9+5KULUYsu2/kqUQb4Yb6sO2UVMGDsENm0t7KHJ2HfJmayoR5QZsUptUzV7IEIZGHXrQ6kfkfP++QLsryrX9p4tLBSnNYdRPHiUyz0qqhwbaL8f8Lxr7aIpOGw8+qf6/7v4oWjJLl53HtDBtQyne9V6Xpi1Kwt/uzQe4Sst+k3ax9z9qpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGcCZq6JcevAw4lKMEeY+0xBg8HO539P2IGv+n3s+mA=;
 b=NMSqhbyqeOW+fmg6y0bZGXzYRrqsInTdIZ+GFEgRZ/rF/VyQR5FVtBSX8J1kCWG52T66Hn9brhKunou2CYBe2LOrdr2CVSgq/ZA26AYijobZCC/Wq//nOcyEqF9lBV8Lz2xTluW3XZerQ7ecaMygdyHXzwWoYuFygZDzHEmr5jMrHbHf5GnBf4D4zL/7dqXvajbxj1o8uZGNGcLdL5tJFsbrab8oUf32LgvuiZmJM1orS0nK1W6/IwXt/ubDrcOk2DrP7IG6JYpnwch62QjV6cjNtafGZvetNb76sDHFx6dlpDlgvBrPQ84uoGGbp6uZwPRTCogdmD+R7aPIYF8I+Q==
Received: from BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::9)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:16:03 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::49) by BN9P223CA0004.outlook.office365.com
 (2603:10b6:408:10b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Mon, 30 Sep 2024 15:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 15:16:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 08:15:39 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 30 Sep
 2024 08:15:34 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next] selftests: mlxsw: rtnetlink: Use devlink_reload() API
Date: Mon, 30 Sep 2024 17:12:50 +0200
Message-ID: <844509e3057b65277a7181a23c95b71ec95e8a56.1727706741.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e8860f-89dc-4ecf-f8e8-08dce162cc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/gmvO0FDkufTl8vPg8u5P/4B9SOGvdrccl8GCK8ReWmoVLxawLZdeG7KOE6?=
 =?us-ascii?Q?7bFtwRODInEXSttKXlk6JivfD28NJHCSwBwQ0ouuK6JuC6TZBHrzyrkOO5zJ?=
 =?us-ascii?Q?/k4Di77FKhvP8rl5Cro4T4sdGRrdGf+3EVPbprYKG2c/iXx63vw7ECQ1DvRK?=
 =?us-ascii?Q?JLJ9CiRgpQo6gvKiyqKhWCBkiNHX+UV7VahA1GOI3LXsjxQEvQwgK8fOHrmm?=
 =?us-ascii?Q?laON9muWkgVodRPKUcWThobHIWxWA59JA5LhbbqkUSue1gUAl372jFa5bevK?=
 =?us-ascii?Q?QCF3S4YkcyHUb+KWedZJkWFDHeWEdUrSjgNruwp5RaMhL3dv3g6oOVePHPJw?=
 =?us-ascii?Q?axW+ePERuVSaqvmUiLfn93ZDeb2OWb9PHIpr8OEZvm17VKSLd+Sp0Ow5iF5L?=
 =?us-ascii?Q?EfDUtcbvq1Oqp2K1BIKePnYFrM6SgjXMFmB4Co0zDxTbOYFDsLrw6pyPBPe2?=
 =?us-ascii?Q?lRAt+lEvDFpbB8sZPM3V8NbEM39NpoKMNiqFsbLvUZTa5+VoDAY2sE/AMj6u?=
 =?us-ascii?Q?sUDWAXRmr8TVG9X02ZLMs3HS/WgRmph9FGg1419tXaGrc6Qw4NcRyMqoLXWr?=
 =?us-ascii?Q?RsONNz5ciddB0umEQbTeargjtXBztUYg4rYhha7//u2Tnzmqf9prd08jCl3N?=
 =?us-ascii?Q?Mahg4jcS0Oxe+La5Nej2B/sf0goZd8jzfUq+Oh1ykL9xYY4PM/1zeTefXsbp?=
 =?us-ascii?Q?/+Ml5fMD5Gr1WPQzodqXlzQuVTJWm/9XXIh+bcKpBpglT2G5RPxn/lMRgz/I?=
 =?us-ascii?Q?Jd8IEg8j1Brk5imwI7Z4mxCyZD0XTEmwSvSx7pLX4K8J6mEJoFD9GkpGxOAd?=
 =?us-ascii?Q?tt2eZux43di7hSoDmNbGWflqfPqoVu1u7Q7arhujWTtb/9rJlvsP9kzbL4FH?=
 =?us-ascii?Q?lFscRwjYO3RoDovtkY0yZSh77yEjDjZGw4gCfzvF55jWWDme/c0yQTKg0U45?=
 =?us-ascii?Q?btpzwIuODSlDYYqpnKNhB9/+ICS+YL6VF/ABDDYhpQ5YniqkWK8WoDnZ4E66?=
 =?us-ascii?Q?rkn4Oh/aQuR8dVtpKVKPw+K+2ODJejgB3loivHpL5W/v6F/YVHzSWBfzA/zR?=
 =?us-ascii?Q?Hhoqnkr/IHIh1m9fZRglDBrG9G6rwhsXfz1WNIkCrcDF6VumAXbsJ+OC65NT?=
 =?us-ascii?Q?QpPpvdlxoIW+WpTtMdg75XKh46+J9gBHZQ1eI/YVHWuBUh0dFhTGR6GsJz0W?=
 =?us-ascii?Q?06ZpQsOBpVwcZQ5kNXyMOVr/mVxQToA9rtMpfTiEioKwuMqGkk//NyUW4HFa?=
 =?us-ascii?Q?JUeWn5KrnOwLOOHXrSoyw4D1CZyElrsRcTRrG5MndtgxU7KUujdvuJ8YDvZ+?=
 =?us-ascii?Q?+sCEzqOi9crV3ZGDet+vAWRaaw1ko/b6ixeq/TwZZD/ML2R38RIm+H4ZDo0x?=
 =?us-ascii?Q?cKG07Bo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:16:02.6673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e8860f-89dc-4ecf-f8e8-08dce162cc32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

From: Amit Cohen <amcohen@nvidia.com>

The test runs "devlink reload" explicitly. Instead, it is better to use
devlink_reload() which waits for udev events to be processed. Do not sleep
after reload, as devlink_reload() blocks until all the netdevs are renamed.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
index 893a693ad805..45a569618424 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/rtnetlink.sh
@@ -186,10 +186,7 @@ bridge_vlan_flags_test()
 
 	# If we did not handle references correctly, then this should produce a
 	# trace
-	devlink dev reload "$DEVLINK_DEV"
-
-	# Allow netdevices to be re-created following the reload
-	sleep 20
+	devlink_reload
 
 	log_test "bridge vlan flags"
 }
@@ -923,12 +920,9 @@ devlink_reload_test()
 	# devlink reload can be performed without errors
 	RET=0
 
-	devlink dev reload "$DEVLINK_DEV"
-	check_err $? "devlink reload failed"
+	devlink_reload
 
 	log_test "devlink reload - last test"
-
-	sleep 20
 }
 
 trap cleanup EXIT
-- 
2.45.0


