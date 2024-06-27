Return-Path: <linux-kselftest+bounces-12866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698A91A9D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0751E28307D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52009198E7D;
	Thu, 27 Jun 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ctVMS7ic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8A198E79;
	Thu, 27 Jun 2024 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499851; cv=fail; b=nEax1coVggUGgzwpHRc31EqcYjWQh15BuyXKiOrfvFH8mHw1jhbdPj4I3yfUI25LTxrjqHFAymO8AlTMuxCpGMZuQGTQeTeFPxQWP2/9L7DH7IIi+PXCet+r4yJaNop5W1mub7REA6Bn8jy//oE+uTCvfrEUVi4+fW+ZKLxBonA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499851; c=relaxed/simple;
	bh=2L3xI1/Gu8A6m4KIPrTfZVISpxMkYWfbihh60wwVf78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsWSplu5l7qYxaREnbWGncWro1hMHKr05G9TTutxVuvJYmA0hZtTOSuG+hC1clU1rK3yKGjf6dgigY63pdw+W0rgsssPtO7pimY9kUC4+lhvApUoQA/SRZ/4wdaVMIw4GaAb8BuuN6+rDVIsWoWvtpurGzzvmrI+bRl7FuGp2aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ctVMS7ic; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6/i+weRDRYm+wB5jNkH3PIqo6S/+8EsUMqNmeautV59EWYIPDRDYTcOWWq8j4JVL8CrfxmqdZqzxNZ4dXxLqG49uqqHYbC60TPpQC1gpI+cCc9K0wIDMPiZfzZe1NBtYuvk/ID+BW1AQJNxVPWBernZhKYMQ73ZxfOjzbqnXLbVKkWphpciyLmssDnYXXNjiV3Ck6dC0Ukr+V+dbWQYMRbNn7LHAzxwgsfxxJ30GIGsjFi34razZyLRoNr0vQYVeAom6lWYQZT4hWNibFUnUg/zsa4iT7eRFLhErWnyNjl75MGgISy2vGD6JBU8+/PG2w2QnptbHhy6ceHw9Vl6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYl1+mCsJjcZehIbzlkMWmZmxE958q7n/tYNYtPRSL8=;
 b=aJ/cBInraZAfJa1xToyKoXdQQTr9cUe1H1faAVe0o8Tw5viZW1zNxTAqXAPmQwjzIVFFELYCgPHsO2oj3ZtmB7zmRp5g6XIqQKmXn8+oVG2Jm9bbTayw71piXNcA5e/R+VzSWiUdQdX9jN7ft1tQR6iEfa6cZKJssZ0s/pXpLDJZvG4L8QFTwfGz3Vy6FiTPzixpZDdMIyQAaUx37gcj00X4Kg6Avt2eiKIM4XFzLP3kEqbk4V2tminDJsNjlbQg4IQztyTDtoiWVBaipETtruvTX2NFscbKD95mjN+e5UZ2OXbR2R6bIk8RB5+iCGKkcTzBvExL/TUtBkXchxesug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYl1+mCsJjcZehIbzlkMWmZmxE958q7n/tYNYtPRSL8=;
 b=ctVMS7icMMvW4jUWiK2hzYwut0zeSCk/Np4yTeqfY8Ga1c6ZeZ0KxKhUAeSEKOTE39MvGK2OdPuw2yJTVf5K/mTwmSJL7MCC3qSJkkp8bUqqQ4t/YNxPHk2rtfqbua6pgJlylNdGFM5mToONBsX+lq7z3v7E22DV4qgk8u8nn4aajqAYgappkJPgJIX1ooiTsuQNokDOZyc21YmdUaMmibyoaxCpUGTS4sZ5J6TPVyDwU6R2BDaFxFotDZGjor9NePcnlDEePyn7PDtcTbNWxVL2tSXqPZ6xq2rcgu26o8Qz2OW3EQjtWsNlbUI9C3ElxgRptwQVuayMhh6gglPGqQ==
Received: from BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27)
 by CH2PR12MB4119.namprd12.prod.outlook.com (2603:10b6:610:aa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:50:46 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::26) by BYAPR02CA0050.outlook.office365.com
 (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:29 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:23 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 11/12] selftests: libs: Drop unused functions
Date: Thu, 27 Jun 2024 16:48:48 +0200
Message-ID: <ce8c777b6a40d7708ffb9cc92d8c7be42f56fef3.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH2PR12MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a8e1ee-9faf-4270-ecb7-08dc96b88729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xLtqLsSsFEwtzddWBJ+DVov4yro9dj20rSY67UhbMW7c76hoqtpYE5oMFnqO?=
 =?us-ascii?Q?B/CtufRZNu+iFhnDMczGnRcU9a9tUbmAIs4CkmoiAbUQ+ygkMX6MznyS1toH?=
 =?us-ascii?Q?Oz8X1fH5hX9T8W0VgMTBp3q5NQ7ZMBYL80eIqU1pac71RddRN4EOSE5Qi1QA?=
 =?us-ascii?Q?YDdEAl4BU/NOkMRZNkZ0GlYxutva7Qcg0z0Vn95h0DcLw2/Oc9TjsxOXaX9V?=
 =?us-ascii?Q?PQdCZrotKdWDYkQe5gd3BwqHNXTKNSMcsR45O6ewo8Fi36NFuss2Chj0OM6I?=
 =?us-ascii?Q?WbzMb2+rGoL0b71ScLH21ncGu4oagF7i6MRCGALaBhJfkRkd6eJt6yc0Aflf?=
 =?us-ascii?Q?5g7i3JvQbDi9BxKfUeHBftRGkikuTZDBDw7IqAG2+65hFQF+Ho2eT1242xb5?=
 =?us-ascii?Q?wxk6dSIY16qn9176QPjB8IOIf7arFkO+a+kr2f7gE+0ZZ0bVzhlImLnQ/z4V?=
 =?us-ascii?Q?UOZwbk0M/7an4CnCXaBQmS2QgV0UlRXa9Xt30KgwBkK3srNZiG0dQq1y+C0y?=
 =?us-ascii?Q?8cF2/peMju8zrFPXEYjZCKskOLm3PCEN17cDVKcuxm9wVPO2az/s5YVy1EFu?=
 =?us-ascii?Q?O0vU87yf2+ylqiNQz3JS1ZUeOfD1sUiMO14lPOHSlWToCDn7qkL5Kp2tNZSv?=
 =?us-ascii?Q?guc+SJslFLOqIoRykQRc7ncUFdnKcAfsAIR19I8cyEAclf6jSeMdi10yy3vb?=
 =?us-ascii?Q?Wrf2MRXX6vVLFqsWd5mhRsZqviYvWa0GylsWA6fPc9fUcazkVl1/uisDTyee?=
 =?us-ascii?Q?0m/UenY0x8BFO4Bk3L6llP6y6i+XNLLUevryO5XoyJPcTrhYBgfKZSClYJw9?=
 =?us-ascii?Q?AAKRtxwEl7RUtBGRRf29ZsxpBOr1wFkRsMXysJ9MR2RZpukHDoOr2z+wk3uf?=
 =?us-ascii?Q?BW+WassgFp/bgbTsMf8fm9A7RT/GYHp1b4g9sPvSyMNoPvGmZOc4fKyBjowX?=
 =?us-ascii?Q?D+QmyO/hknBb9VmFfgl24WR9z0GGoV+qPVomqSx+jjLCsnzw1idpl75EQYJh?=
 =?us-ascii?Q?/rvIMAO/GP4pxzv9p/SsEgHizqRUgmGM9rOetYKjXKj9EcVgBCZ1ufnLQkTH?=
 =?us-ascii?Q?txyGs7gQEJid7qRO1ILRqfzUjKYB7EAYDedbz97yCZGktdoCOI1hjgD8bL16?=
 =?us-ascii?Q?MZ1ptNOWGKWDIC0apevWf2rd6PdnJYsiXxdJx/s6oO83cMXf55VRUvVJwQRY?=
 =?us-ascii?Q?ehJFi00Cz9DReyq7gAQQEEqyUJMwTLvkAtPA0mDEhiK7JJ5zbtlBjv4kHp8I?=
 =?us-ascii?Q?jUDlaR+RpkYamdMi+ZA91mCyK36bwGcyTplvaXfFOg/KtbUsXIwIG6LU7GY/?=
 =?us-ascii?Q?GWQ3BnYiBOyaux4nXlfTsSrZlISImqafeOe3KsX32IaQBDv3pYtaYkIczULS?=
 =?us-ascii?Q?pveTECsoqmxyz/wZojvsIMCMlggZNzULyqVUrL/PpwR5BxqNk9mVC0/36b3f?=
 =?us-ascii?Q?F44l2j5ZZI9BbuCGsRbssXH3gP21DA4h?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:46.5432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a8e1ee-9faf-4270-ecb7-08dc96b88729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4119

Nothing calls these.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/net/forwarding/mirror_gre_lib.sh | 11 -----------
 .../selftests/net/forwarding/mirror_lib.sh     | 18 ------------------
 2 files changed, 29 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index aa96644e3866..20078cc55f24 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -101,17 +101,6 @@ fail_test_span_gre_dir()
 	fail_test_span_gre_dir_ips "$tundev" 192.0.2.1 192.0.2.2
 }
 
-test_span_gre_dir()
-{
-	local tundev=$1; shift
-	local direction=$1; shift
-	local forward_type=$1; shift
-	local backward_type=$1; shift
-
-	test_span_gre_dir_ips "$tundev" "$direction" "$forward_type" \
-			      "$backward_type" 192.0.2.1 192.0.2.2
-}
-
 full_test_span_gre_dir()
 {
 	local tundev=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index 1fc8545da6e0..6bf9d5ae933c 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -88,16 +88,6 @@ quick_test_span_dir_ips()
 			     "$forward_type" "$backward_type"
 }
 
-fail_test_span_dir_ips()
-{
-	local dev=$1; shift
-	local direction=$1; shift
-	local ip1=$1; shift
-	local ip2=$1; shift
-
-	do_test_span_dir_ips 0 "$dev" "$direction" "$ip1" "$ip2"
-}
-
 test_span_dir_ips()
 {
 	local dev=$1; shift
@@ -118,14 +108,6 @@ test_span_dir_ips()
 	icmp_capture_uninstall $dev
 }
 
-fail_test_span_dir()
-{
-	local dev=$1; shift
-	local direction=$1; shift
-
-	fail_test_span_dir_ips "$dev" "$direction" 192.0.2.1 192.0.2.2
-}
-
 test_span_dir()
 {
 	local dev=$1; shift
-- 
2.45.0


