Return-Path: <linux-kselftest+bounces-20396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2959AB174
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8C7BB22D51
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A42A1A254F;
	Tue, 22 Oct 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdF9GQ65"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06B1A073F;
	Tue, 22 Oct 2024 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608715; cv=fail; b=HD2pTdUiuReaRHUwDR5+kVNkNDpwMvWtDq2OCI2uvd0nX+lIEmN1MVpWQWw01zXnbhoDmTU+uLaojD+VeotBOBUEU256acnCRs5aejZucJ/YapkQv4A/HRu6wHmTaImI1eyNzRsQZC+koMJb+Yx8AOneCdiDdRhl0UxIFjISY0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608715; c=relaxed/simple;
	bh=J6pK3Sb0SVXqEZLC42T2wglyQJehaTywZH1sRUV3PZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAhvm+VRI8nTA/FxM/XgyZE+pndNX9RR9RAL3nOFa5QIhO/9ICnBqjhx8K9m0gMgCATnEOQDPmZzcnrsu9r3yIyuad+NoEgv2fY+rJ9VWSBwj5s/VNd/gTXL+s3wEeOMn6iuapuZVb4Tlf/SriWTAwK+NoQA6Y8Ej+G34I/MDHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdF9GQ65; arc=fail smtp.client-ip=40.107.93.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvuyuCYSbkNa3OEJzATJZ57raemCeQ/XfRvSWcc5vP50yFtQ9ireJts139tiv+jBCZHWLUylxY1RhvztIr6Nl45tPxj6LuupiF3nhATowxF6Lwo3x5vmSFXmvNI4XBwaIyMdDJbDU37AUOHrr4ND3If6G25rSq3b04ja5CX+BAtwoEAnScyc3vix7/lxsmlzW+zyzbSO5ksnT2n6UMzg3zPoMbvD6pzgteLVe9WOepOODJfT5yzrX5k82K8XqqxYUuexHWChwDxwCiThx7Dj6nZ7meud0YAuhH5WVBr1Pg9/lT67tyB7DjHif4dHciYUmqpAzyo33yVvPO6eVu2wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNEu9x7CzHjUNmeuDiF9oLnqg8UZqvMjFIJzIzwDFlM=;
 b=UyZhJpUKKiZMEFSdHRPK9Fv+kJV2gXn7yMas/VVeBphgGksuzPIJbX6Gfb0ORP3fql0leGBwRrJ9gjjsGB67+F/n1VQufxN2rZtBZ1u/7wL5VqMM/0TqZaYU0bpQoIFzXSXo+xfCbK76OxofP8y/YzLMPCvVMKO4HdUKBBjrjj4rcFyD/FHv9SZyVynJ2m5kXOGJJbbrOZ1PULgupLtx3zjrvhC9FUekAEJYYuMmVByKuohZFd9EGwHvzeEgsz8QVYAfNELu6QAd9+l89lROcGZJ4+gz51TNdm7hRSU7HNhXZTSZ5pyWK6Rl2MEtkXB/KVWHcAfEIhF8pVn/Joag8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNEu9x7CzHjUNmeuDiF9oLnqg8UZqvMjFIJzIzwDFlM=;
 b=FdF9GQ65cLpOvcm/WjOImkztdZxTWjVR2RSgfVbA2y5zPXj4PBSAFxHvlYoBgCJhNY6treb3TOTtH7ySbfB1j1/RKV85p6R4ADX1EVdnJTTD/Q/FSEiMCVEMOTNx8UpfuuKdcS/CVHKQRRX5yqz9bl4GalCa2jBv09VymL5j/+/xho6S9FyZy4VXLNJJ38QzjvrEWRnAn5mKCu1H0Omsbd1yOItx05nLTFLx4BHMEieEJ0+wRxijnQ0knly2QgEoyYRibOTB5WFmJuFeOHSHEwk+LiZ0BgIK0knFOffg9Cy+pmyZ7aPNGR5pJbv1qV/KpuJt7JUixIMWZxhXZyW0Og==
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Tue, 22 Oct
 2024 14:51:47 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::ca) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Tue, 22 Oct 2024 14:51:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 14:51:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:32 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:26 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 5/8] selftests: net: lib: Move tests_run from forwarding/lib.sh here
Date: Tue, 22 Oct 2024 16:50:16 +0200
Message-ID: <ec10f3d682faea98a88b5475172829bfe8a89295.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc9e793-5bf9-4455-e5c4-08dcf2a90dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9w7QsbTsD3UxeksQl7ZlhbPfICbeIX6jazGLkLyTCT8kQBKhFvr5rIOEoim8?=
 =?us-ascii?Q?mmbWmGOI1glaVTqdsFTHUpXIynPcsihpADIoM8zz6a258frKeMR/llKJ6LuR?=
 =?us-ascii?Q?5Q85WVhslQuuSUy9SPhkinFEqBmlywX9Clos/2tPwIlamzhClru8LGZWUQuh?=
 =?us-ascii?Q?c+fJTZTxB5ZH1SqwJD19J9o/+Nmngt7J+sYbbJRKuwi7i9PWahlm2IszayBA?=
 =?us-ascii?Q?l1+0M8b7OLCwL6vNPltXFHdCTOpX8CMg5AiKhHyw/lrN48xWgHiAGihhWohm?=
 =?us-ascii?Q?Uf9z1kUzD28OeSytMET96bI3t5DNJWQMwaoumuShB1RWLUvgRiJci/nsPItW?=
 =?us-ascii?Q?ny/Old8pevY53DtPjXVQ8lLYGJ56ldJzLe7Plr+CoebgTW0ikbmEMxZ2Gx+B?=
 =?us-ascii?Q?6Hpn7nqngdFTS4TUXCqgguuxQGp17YfTuI/UHfH77NVQO4RyWMpQv8rECd5K?=
 =?us-ascii?Q?R2iQCeKytybQEAuy9mZDvWqLfTfry7F9xm51H+u/9FmvuI2STbZ3ZuHLzDlY?=
 =?us-ascii?Q?w4+6WaCuEBqTt6rqoJm2zz0XTJbXQEKc5y0nXWRHH72UMWTdUochj1pSQx6H?=
 =?us-ascii?Q?oCIWM/BimdyJ42ROQwlTmkYvyyzQOk9Kl6XQ6uZpEnsDd3PCCzvJCfNDWawg?=
 =?us-ascii?Q?rpzEoHvvcoxijQCl3/9sK4MyBd46KEvZ7Z/Re6JR+XRt/6ITUn7uo2st0z6m?=
 =?us-ascii?Q?pE3ytVHL44VAMfPtD0sWb8b0LHRtw1A1NoxlpfLED8VAXxWhmlJi+1KAk9Fs?=
 =?us-ascii?Q?cDcOJ742KVYcUxRec9gV3DjjY0rlSOV63rWPDcsfOAnqJcPMUgfdoZk4HGdK?=
 =?us-ascii?Q?pFMDY466o+++/xoe+c6KtZEf91TlRSJlo3k5yOG3I94d1gSvBeSbGdI4oDti?=
 =?us-ascii?Q?kkAxrgKbr2XLX29HWpS4Zra3zbYYftDIkzQcgueXnG/k5ietD9WL+kcrDr3X?=
 =?us-ascii?Q?IfRJud1fBWah9XQylqord902ubsAF+iXbeCDnUvA97xo/nBR0C65D291w0S5?=
 =?us-ascii?Q?EiKSOrfcphABTagwqz/lCIlObX29pato72N3C1BEmhLmWhhWzqzNS7/xZwYu?=
 =?us-ascii?Q?GXnpF7pltl3JBYqxE+6qBhxIp52r8umt3IdRPkgvfQACnKTB8PYjE8hwE3Va?=
 =?us-ascii?Q?AGhys02qbfM3ATN4OD2E553u/Jt9pSqxqvmgxNC+H+xATL3lplRQ/Vy1TDnK?=
 =?us-ascii?Q?abLwtshghkRcu/jInPFoMiGFXdgXBIuiuJhEUDntAb1XlY5/bqA+laS9d1/a?=
 =?us-ascii?Q?bNpEkkZmvS0xI6vBMOy+7fLFDZl4sW5t4kWlFpM3mMsfr4Ocju6axlT0Aa1r?=
 =?us-ascii?Q?6Jn6oQJEUtHOCkk2+dCnIZCvtrOlwvE5q7MpiVckqJpmLlfchMMaKbarccaM?=
 =?us-ascii?Q?RI+x0jo6znK/LUy6aU2oR4qJTcqbEvtu7deYV9LT5mOSmta98g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:47.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc9e793-5bf9-4455-e5c4-08dcf2a90dac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973

It would be good to use the same mechanism for scheduling and dispatching
general net tests as the many forwarding tests already use. To that end,
move the logging helpers to net/lib.sh so that every net test can use them.

Existing lib.sh users might be using the name themselves. However lib.sh is
always sourced near the top of the file (checked), and whatever new
definition will simply override the one provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>
---
 tools/testing/selftests/net/forwarding/lib.sh | 10 ----------
 tools/testing/selftests/net/lib.sh            | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 41dd14c42c48..d28dbf27c1f0 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1285,16 +1285,6 @@ matchall_sink_create()
 	   action drop
 }
 
-tests_run()
-{
-	local current_test
-
-	for current_test in ${TESTS:-$ALL_TESTS}; do
-		in_defer_scope \
-			$current_test
-	done
-}
-
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 691318b1ec55..4f52b8e48a3a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -351,3 +351,13 @@ log_info()
 
 	echo "INFO: $msg"
 }
+
+tests_run()
+{
+	local current_test
+
+	for current_test in ${TESTS:-$ALL_TESTS}; do
+		in_defer_scope \
+			$current_test
+	done
+}
-- 
2.45.0


