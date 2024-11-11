Return-Path: <linux-kselftest+bounces-21792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169919C4344
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5541F21BC7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF01A4E98;
	Mon, 11 Nov 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeMuBNNd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8C1B95B;
	Mon, 11 Nov 2024 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345136; cv=fail; b=WMFrg+qmXtje9AXlZB2PuhEaMzHqTZyTztLRENGYBGUldOy/zFJ/MVPu5wPkwEt3pR9Lrkv8V3HhfayEznDM77NcF3zjkfKukIxB3ruF5RB59jnfmegyyaLA/hksNGwZE1NRs8BDiESaqZzYkZbz0jd2PPnnkwojeEBU6PnsjRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345136; c=relaxed/simple;
	bh=u034UZiNhiJu/r2dn8swqac1RxTUeAtyHs8A0b2YlLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1d7DOexfco21P2QuTfPTpnIg1T9GmUXedJDlCRCf5/zVNDDfKkzZk7X1AqtM0zc4NuDiBa4jIDCDwsxrudGX6VWPWRhqmGrTgjqDmUslc7CW3+MdNEg3V/PGCWR4L9fEu+YxVy1K5YS5rJvfTuk2qdmvW97I+dkBdYZk6bZb/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeMuBNNd; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc4Mo+pDTwnsCCGn/+T4//SOrL/uZHNn8MwfZf9PxQsEW0uSw3MNEuWc8PJGD7S60qH4UXk8NopcZ/E9ay8klfggLCG8QcF3FX1LP483YxRvz5FlsvQqHlyawOLy9YowX9eo4NjHtYJbWeWHDRm2jJ4JIlon0INqVN8F96443eCqNqv3vUCnSVygyIw8HqGObtu0rUTUKZeJTI8nqYeTk/bBDcWpoVa0D2GH8XHx0SVlnIdyLNr79TXJEyxjfoPIRxgH2YsGbZLd9BqvW5YWOvJcMNnWR2TXB/dRD0URd6yelcMWuZrUlJM17UikHQFsNwdIfOVCZURj6Z/iiaTfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0knMJxu5lwi7AglwJNczxaI1E/3P2LBzh1dlVNdMhyQ=;
 b=fgGLehLaGi5RFs10hjD3ZJuvVO7fQEwefPvZ0xe7L/an1UfvMW5XbvSjJs1ItKvdyoVpB3oFck6JrlhQ39WniR7qWAvY4kiwjWHG31wMU/L7VeE+hKHl323t3VHTf6jDzXJdIojRGCW2oP4ju+3Kr7kHblf15SUNdnCaf4bKIZzQUEJp3+NMGHaYtugVdZRr5lzIrQ5NJKQe83VX0d/mhB+PcQH16pFZYn8B79UcCKeYRKJ6FP+26mTGUR8FTvFaAXRXZbguWjNtxn4LzBXMIYDR0/zdRIIz7M/TqwY3lMHV2k7f1Lh3pJetRnwZpmgkX+KRZwwhrfQ+2Jr0BlLa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0knMJxu5lwi7AglwJNczxaI1E/3P2LBzh1dlVNdMhyQ=;
 b=BeMuBNNdLgzxgixI6+3Q60qKxKLTxIpALpFwMwfOFmQaBVR2l/H4vTJabVRlBDl6U2eEHT7n6axdneKyO3SgXpjoTR6HudaJo95GBXGzoG8lsOXvc8rADlhxyhT34IKjHMxqEgq9C3Phbi/PK/kmzqkrPkhTS5vAqcQDX3nBKQHmM9i0hTRndjE0FOyWbnPh6nWmzoRh08uSwNbzRNWdUyai1HtlUxaCeUtOqCP3h06asuR3sIR65yZoSRJMBHGCmGgUoE8uY0I2HTHxPPS5/Ou8fzkhQ+tZp4h2mlMz/80BwQGUxxu7CaUJqJX/BEqJ4o3RN/3LqIfePUHgqADvsA==
Received: from MW3PR06CA0024.namprd06.prod.outlook.com (2603:10b6:303:2a::29)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 17:12:08 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::9a) by MW3PR06CA0024.outlook.office365.com
 (2603:10b6:303:2a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26 via Frontend
 Transport; Mon, 11 Nov 2024 17:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:12:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:50 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:43 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH net-next v3 4/7] selftests: net: lib: Move tests_run from forwarding/lib.sh here
Date: Mon, 11 Nov 2024 18:08:58 +0100
Message-ID: <669983e424e61cf7ddebc8a391ddf0dcbe53d80e.1731342342.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: aec62466-e0dc-4a3b-05ee-08dd0273f93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yg2PFlcWK2nx+acKxmzULM+ivUjoBtEZtRvKgSDu1jwTWJr3KTuK0pfD5gb1?=
 =?us-ascii?Q?++3IY0cZR8CtCmA1/nBLznsYspmldijIjuUl5VDuKmPm9vq/Kl5sYgQ9j8vD?=
 =?us-ascii?Q?nUQb16QFtp7/rG2yAtVurTz+D/Jas4rvPFWuVP1wDVmYbCvIpxFzogVlK2+a?=
 =?us-ascii?Q?kbSfAQR/hWgb5BM6ckWIab8HQcKNWpEq8yEwxRxW0b+J+1qI+g+fs5Wq+WUC?=
 =?us-ascii?Q?vxxw/+JflCxkknHCbI7nN17lKHQoAbUs90LjXeDr724mMumqhqfkFdABEZjF?=
 =?us-ascii?Q?zqWG0uN9UXyfu0WyrkQIyzH2hs2Oh0SGSImFHZ9aNUS5lA1o531jOdn7Yi4N?=
 =?us-ascii?Q?S30lRVGrsssBZAIoeIjjhJ74onfTPT2VImVUAnSwac1612PMDc20YMDZwc04?=
 =?us-ascii?Q?wmLDYGrjQETZ50k84Pt4ytTiehqeqG/w2BwCgVyKA7xIVabuNiS7KpCj82cg?=
 =?us-ascii?Q?0VSnOraKdHz1R+ef0R2d0klhff+Xj0tpH/XycFQlwS9UE31Yu+I2++ter+St?=
 =?us-ascii?Q?o2fnFWfXRoV2eMxn9V3eqd+/O90bQV8wkfYQu/QQCwYANpGxRtkg5cySQAqJ?=
 =?us-ascii?Q?ZZwOzFsZJldhz1bJP4hs3Xo7vCSHdj46bQQkUX4Z6JI8k5Pdqd07J1VtVkNR?=
 =?us-ascii?Q?iWY24bW36dDunyPd9QNLWQ3IYINA5W+IYySZeIMJc6OldIErCSZo8lp4lK81?=
 =?us-ascii?Q?pu5B5zdNhQj/4QYtMyyPp2K5Mg1SHyUh4IPf/s+Uhr6R4R4wzcBF/fFjFQPG?=
 =?us-ascii?Q?VgEtEgYW03D0uo5CkWgBMSfkWnvgAXmzQzsFrpadahzCFeeAh3vQ+A7kGwln?=
 =?us-ascii?Q?WIvYZyPyHCbeAAD1iaFVtdFRfI8YKwWbw/3XVMsYeNRTinDJFBitx81aZIJ3?=
 =?us-ascii?Q?ijWhlDSi9Ts99Cbq5X9PQRc8sjvzzreranaKlkBqrW0AdlvgouGo4/6Jj9NY?=
 =?us-ascii?Q?lVF43VjnakdIzUnqbTbEOZND6TuYFAklR7QANAdc5TZ27cr2ETf0yoaet5RW?=
 =?us-ascii?Q?JUVlX+gnukXzmwnlzpRaF/AhIMhc8y/xLDz87PuzXW46Z0uWl8T1eaESxGT0?=
 =?us-ascii?Q?cIqhkBoUJ/O6AaUh4BQDa9raP16HhqlG1CbThSwDBfwdNZn3r9fQZxMWxvwr?=
 =?us-ascii?Q?7Md4dO/IbchO08RcyD+Q3iD1YTULFsSjnw/TEbuOXQXbybGiEJqvx35q2cNk?=
 =?us-ascii?Q?1zWd/AcwfkewPeZKL05MA0bEVpbljBLRl7X9/v4epUZ9sVavzEQsTYLf1+Ex?=
 =?us-ascii?Q?qIc1R1g5INcHmmv86m9nnK3gXGSZ4HS5RkP3iEpHI44Lu6yL3Wu72d/PPl1Q?=
 =?us-ascii?Q?CSkn07SSZXxMAqllLx5y3C6SiCM3+s+hBktMdVnJlGRcsPLXTd2KPI08pKGS?=
 =?us-ascii?Q?dP9A6fe4zDZv7BOoCuGsP/H7nCc/+Kulj5N3KCVIjbSKDaeEDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:12:08.0467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec62466-e0dc-4a3b-05ee-08dd0273f93d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

It would be good to use the same mechanism for scheduling and dispatching
general net tests as the many forwarding tests already use. To that end,
move the logging helpers to net/lib.sh so that every net test can use them.

Existing lib.sh users might be using the name themselves. However lib.sh is
always sourced near the top of the file (checked), and whatever new
definition will simply override the one provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>

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


