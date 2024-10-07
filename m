Return-Path: <linux-kselftest+bounces-19165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C2993343
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F7028378D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D23B1DB95D;
	Mon,  7 Oct 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QXZaMDpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F21DB34C;
	Mon,  7 Oct 2024 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318540; cv=fail; b=PNhiksvcwa9CfCTVROjYydpn+JOWDuamVL9YXbysF5w+b+znsh5rAirR1fEHVhb3px7bOcl5S0CG1yC+VE9G/NhC5zICQ49b4xCTg7PjiPy6yzr8CO6NkHT/Jymq6ngKM7yoTN83hZ6c+nXJuFUJGJjJRHigbPZKmXrWvRajHJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318540; c=relaxed/simple;
	bh=RG0Xczc3aZR/AIuRT/rYeaEyZ7vOx44rKeE8VdBJi1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+n8bAOS9+7LDxGJjRxhpNUs+w+QkcklxMdN/8SBFGp09OVx5O9W57hYdAGSsbuXugwtYcuXr5R4uj5PzXqKeg++XfUlv12nSH2ftmpzJ6ggU//aasHqqN4mimVdx2dOBPBLnT83w/1ZUv1orVfSshQ3zLomW4XuH7Z0WCvstWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QXZaMDpV; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvC1WWIZiB4aV98LeRFItSu7IBco+2PQwd8aTdyUDgPkx2XhKOPCR9k3i9UbEfkGhqUgCb+OeDpazEDd2X+noUuFuozbogpyNHToxew7knzQc8iXU1n6ZN1lvheSo8f7hw7aM0qicMc3Jxq8sZ8/1lQl3nKrV5CkI7do/TPmjnL9Bw/S8xFuv9mDreoNRxqiF5CV5WgD+nTinWsCSHNNPUdVr7DswhS53c7AtQ+QOlmPQ5TV8ZQN5NXjPkG0dUcyzcnIOSIlRiaZTLf+uLr/WEWls3ZdxIlp3jCXOKJ2ZRAUQ/blaQ3edKuOVMzLmSO29JBQ30/udZwLR/Zbx0wn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f34zSwvAG8F/brlnYCiCEduD36qeySoi3v6wbhbga4=;
 b=X51rTzqGrfsE0OfKXt1lrex8iaqnyyIjhJ8+VqRMOn6/nRR43idoKF8AzZZ1mdOdA5u/ys+KSoBc9d+iZiBBtLcq+Qqdi15uXYT24C/D9m8m1PwOHuIsgRD7GEFr+UPwW777esERCGIFh2mMhDtO2E/0VNUFmsXkUcpmwCu7u+cjNp7jCWN2hpmJXR+2VfXLhFcmeq0/RC1Zk+nwvXsyigMat2Ki2MQMYTfSNjnd5yhlDesUldVLsjBLzKkfQwfgPKQiltPoKVlocIH9gdJU03nSG7Okvrg8fmD058b8ZsKjqGevgNN+WvYbx0TGrayXXO2AI8VCuUvkbLtR+8iSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f34zSwvAG8F/brlnYCiCEduD36qeySoi3v6wbhbga4=;
 b=QXZaMDpVdO7CZuN9JQk2kYqvPJH/Gp+D98/9hBWHqMdbfkQPiSwSUp3BtHBKz4XgNxL3dN3LlBybcdICchcxOnnjmd07T/8kvv+QPbweUeg/H7Aasr5dvifPUxA0IZiZqg+JxzOyiULgSF/Ab5b+2PpKhMRDk50JTkm1NQAkEErlJvjv4Yr14iihnEWZZ7fYo62DHJKFrUBmCcKdxtoZFQm23QJF6tsvizxel12+ZDjNcdJn9BPO6oNTHrqetf/NRC/Sp8IvxNNZrJo1lZSO6CFMdEx4Pw6E1d8vYrpz27l7ABPobfFx8ud17EuHZ54ScAmWDnWTqBV1y5U9nhpRZA==
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:28:54 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::3b) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 16:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:28:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/5] selftests: mlxsw: sch_red_core: Increase backlog size tolerance
Date: Mon, 7 Oct 2024 18:26:06 +0200
Message-ID: <f54950df2a8fcba46c3ddc1053376352fa2e592b.1728316370.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728316370.git.petrm@nvidia.com>
References: <cover.1728316370.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: bd14f8a3-9e14-457d-7f59-08dce6ed22a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LBX6uAv6ZVsrD/DyR1cn8jduZte7vHDWxFziZLNlMvnsUwp1diss/7v9AYdb?=
 =?us-ascii?Q?aI8bzogU4XQKgkhs/R7iM7gxiR0CJvDPYlOojI1zgaIszMqrX+I6IOSImgL3?=
 =?us-ascii?Q?MZrMn2OKCJLfDC4xkS2usSHLnCGIEJm2CPlAwfLghQVAqxNQNYX1ImUrnHLK?=
 =?us-ascii?Q?zuCxAVoULzv7TLB6noS2rVLvcvOYkTQIwu69PdJLGhGfdh/sSCBGbhXkBaI0?=
 =?us-ascii?Q?mov//YFFUYye4MAW49NOE1ylShRMnnHgPp5ZXkwRXGQYMpeWKIqOw5JbEBVn?=
 =?us-ascii?Q?iEqqDFZC2pHmsLxP/DQuiEytSOfTJGUsTZ/epdb1mF/5PcmXn9lFaH0BlU/0?=
 =?us-ascii?Q?74qyiAHMHQAq+zW5Bz7BV0TnH2yKINLQi2mMucJ+6EAaGGAreNSfUIIs55nm?=
 =?us-ascii?Q?RXO9l0a1T4tDx6PRrPVIM24wBeS54QVXiqAJ4g79Ek4fb8u+7s72mVynLzKp?=
 =?us-ascii?Q?grhDIDdPgHlH8thEAhtYIxmXVjT9jwGu1nZiSJf/73cz2usS+S5WQSvLKP0v?=
 =?us-ascii?Q?dx+lWP9i//sT9mVs+f/tlJimyBQJRj1oyUEldOSJRDZDFgrQy0vlUNxbaIO+?=
 =?us-ascii?Q?4xNLLrM6qE2zudZHrnS3Axh4xMIm5dwFtSU3nArwGuImMrqE+L47Apey+Xay?=
 =?us-ascii?Q?nT1iXJCWdnvD2Ba2qYuOAGOMPrPn2isubFmOhSWu+dD7CnYbREwGcoB3P+CP?=
 =?us-ascii?Q?l/vXzz9uMlSHRlMel3P/eM8rKnS/AaphA0fNhnYFdW+WhYJ9qaEvb/qVfH7j?=
 =?us-ascii?Q?kpa3Eq80dxpX3UDyp+6++6LgYgDonYC9oK/hmLYKyO3OrG1B0r3K3f2BOgo5?=
 =?us-ascii?Q?sFCvB4mueSQEsme1sWc+rj1mHh+t0gnrBdNYwiBYqc/eug9jLL7TDXnbbedW?=
 =?us-ascii?Q?tijlYCyudLlBeugG+88cMi/5F2ypFrc5UvgsqHE+0MT8EV6wPpvxi9UThSPF?=
 =?us-ascii?Q?F3vQcwoQrkHpgmaOzYtQrE1oAjSzD4mJfYdlfMKNp37UPZH2xFhreG/06WYG?=
 =?us-ascii?Q?fYhvvnAlECnf1cN3zc3/ULNtrL28Pae0Qtp+f7giIz33roJHgrzfGhSBCjkh?=
 =?us-ascii?Q?3edEsdVn1a5nsOJDwA9poVl6GHNvnEAwo2T2X1cSi/Kz+Lzw4X+j9/XN1GCi?=
 =?us-ascii?Q?Uv3iWzUCW36F7mFXR6pDqDMg6noXhILobT5Eg3hh30weYigU9Z4DKOX4OQgQ?=
 =?us-ascii?Q?XO1x6neXO04Ja7pkxVaonr36O4Bfz4LBLGaQKS/xcxGEFtYLxWJqq5iYqbBF?=
 =?us-ascii?Q?QuJtIsmUQVigYdRoMvWUIUTSUnPH3IW01vGtCK9VR1N2JzqtOu217Xatr5fY?=
 =?us-ascii?Q?XuQzFpws5Kt8VZ/iF2gy/DCty0uGqYrjyd/IIb3gZJHROld2ajGUgAsJDbl5?=
 =?us-ascii?Q?7zng+CpDMRw/9VjWbe0Q7Ik3scNX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:28:53.9758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd14f8a3-9e14-457d-7f59-08dce6ed22a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823

Backlog fluctuates on Spectrum-4 much more than on <4. In practice we can
sample queue depth values going from about -12% to about +7% of the
configured RED limit. The test which checks the queue size has a limit of
+-10%, and as a result often fails. We attempted to fix the issue by
busywaiting for several seconds hoping to get within the bounds, but that
still proved to be too noisy (or the wait time would be impractically
long). Unfortunately we have to bump the value tolerance from 10% to 15%,
which in this patch do.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index 299e06a5808c..a25a15eb6d31 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -532,10 +532,11 @@ do_red_test()
 	check_fail $? "Traffic went into backlog instead of being early-dropped"
 	pct=$(check_marking get_nmarked $vlan "== 0")
 	check_err $? "backlog $backlog / $limit Got $pct% marked packets, expected == 0."
+	backlog=$(get_qdisc_backlog $vlan)
 	local diff=$((limit - backlog))
 	pct=$((100 * diff / limit))
-	((-10 <= pct && pct <= 10))
-	check_err $? "backlog $backlog / $limit expected <= 10% distance"
+	((-15 <= pct && pct <= 15))
+	check_err $? "backlog $backlog / $limit expected <= 15% distance"
 	log_test "TC $((vlan - 10)): RED backlog > limit"
 
 	stop_traffic
-- 
2.45.0


