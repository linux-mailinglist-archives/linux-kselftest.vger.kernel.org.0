Return-Path: <linux-kselftest+bounces-22877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3F9E5B92
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EE316688A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DE221443;
	Thu,  5 Dec 2024 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVDG+IhJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE181DD87C;
	Thu,  5 Dec 2024 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416738; cv=fail; b=g4scMcBwSDmuD/GpJtC+fcNQ6u3NzKm+xAM40CtDsyygyk0JwX93If5vFPJPaBHVR7CKNnRKvU3301//nharH0H+PCNfPkixUEk601hwASi0Z6SkN5qyC9+Rv1iubQhVXmKJZH2lyEcrW+wP9iSRpZL9eYljdf+SQacqNE2wlxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416738; c=relaxed/simple;
	bh=0lJR5X5WIrtbVkiHv5x8QZtOyhiXBk2fePlGXBidO2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOpVQklM/Pyx3irH/Aba61fIWwDl3/tB+nZ5Q3kQ7Txj2WEgmluklzVNJBd38/KG2jZ8sMTxcaUcYURUMgKt/oBECv4jU9nEKBiUd9w/5IkwUBoQhuo5hEcWsSSguM8E3/ElX4CX8UL2eftU3fYyhl5QqUpfDDwaqNQoLqlGKZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVDG+IhJ; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MAYkFvJoo5jZ1dshwsfaTh5hrOCm1XTo3xdbpwCfTBCRFiJXTIeVcmFvQoLbiwz4ykSXMF2KgHVFReXufBxqplHo6wkgyESV+GNjlVrlU5dZdcSxWiOnB1cW8o7nOgzQcsA3SwHgFOXHwcZW74r+8fifMu0Okn7GhjWg40j+LH/rnXKuWgVHjQ4XvmFawEtUqSQ9RFBz4knDk6I8X9qj4iiiONYSeUikRFSdyleBEiOeIrMWzJOlyNPk4kDLZDoMgSEcjfH3jJ+LgkrwcJPjg4rJAxTdHSgBdVJz5RVDzYI8xzrnNmQALGajnIq8KIme0A1aeZaBmexj/vk7sCZrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADhr7SFuIlGVIOWSNdHgwitRBqfybRFS/9+3Pfv95xQ=;
 b=lxHOpEah+6VQ7KxgEOSdC6JNbipjw7ewxge1QJ7hJkF7LRDDtY8Mm5+CLgYkucX+K9EQ+9zMoty/0vq6aOGq+EJSpXt6KnOGcL82wt67TeDdHb03mk9lr7QWZOjygEwfpHnvDYfu8AnJmEBbW8x4Bjwf6np7fJ+EPgU4S9G64oDy3OOOuRHYWmIdupOuXyRito8KgTgr8hcuFi8+HlUsSxQNFQZcrKmOdSAepYA2Gq77p5lFm46EEhczGWEWL9ODp2z7Y/zerOzb3ABLgRuuA9PMDWG44mVKb58L2pV0T7c7hb4G8RzT87QljiXBaWXxpH3GyL/yta1Vy+iJ5vcKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADhr7SFuIlGVIOWSNdHgwitRBqfybRFS/9+3Pfv95xQ=;
 b=PVDG+IhJv9n2lWAbZ96aDx4GW45p99Og7if1qlqu8Ov2F28tB3Uz1qlvjv6fkR0IL+KYvCtKhZ+UgJNt9ic+D4+tEPNnelHOAABmC7+x1k+1Ga6VGsuLsoBjKL54EpIcQjoD7aoJjU3OhXM4TB7msN6p4yAQVh6XH+nStjwl+mMkuxTWHqsfIHG+I63+CU39zIRb1G2Iclj72vLQUVA6qdHFoRDOmaT3+JASanUYvnrnUz2lo3OycoiEEFdKzs2HQBe7Wiwg+E+Du66IQRRz+prxSOZ5uPWrTYIUKBgjAKH2osx/YTXYguqOb7jn+u0+WEsfplrFi82MgPGkYPLkNw==
Received: from BL6PEPF0001640C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:13) by IA1PR12MB6578.namprd12.prod.outlook.com
 (2603:10b6:208:3a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.22; Thu, 5 Dec
 2024 16:38:50 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2a01:111:f403:c922::3) by BL6PEPF0001640C.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.15 via Frontend Transport; Thu,
 5 Dec 2024 16:38:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 16:38:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:35 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:30 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 1/3] selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
Date: Thu, 5 Dec 2024 17:35:59 +0100
Message-ID: <5b7344608d5e06f38209e48d8af8c92fa11b6742.1733414773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d85b0c-fbac-4cdb-1428-08dd154b4c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vA6to5p9rZISOdtl9iX/EApP27Z0rQPwlpMA65u5H0Od6v0eUDp2AeDSlmZ+?=
 =?us-ascii?Q?a3PboH/8+qiD2jLa9FJza99L0B5LFP/MeA+pXd8CK/sYrpaOZCMZVKFOB18h?=
 =?us-ascii?Q?j0FWj8gSZ4mmGTw5VEQ6nIK6oe3k8qmhF8rfiJvfzdeGjKUnS/5Ior0jgctX?=
 =?us-ascii?Q?Ymf46KaxL6QNVG5gTLmN+RVxclEr2yWRiNGQMYZXD5ADST48zFF72pyfA11i?=
 =?us-ascii?Q?c7F5oFDKkM3UPSZCv010MZR7jcmWsiLz55ECkXqYxc+TVwFijXF10qDEhCDE?=
 =?us-ascii?Q?El/DXdPXhv3Aoz9PNtENIbSvv2RWDzuP9eIT5knjTmkLcuNVjY4IMehl/gTM?=
 =?us-ascii?Q?qvgnJuu9moideNrRBY1kS0jRoqH1YRu4a/H4SkXsxeug2yvb+yQZ3umP95V+?=
 =?us-ascii?Q?CoG4DKQXTh3BoB6gLCmS9J21dYMiO3kK4ypTinxgYcJddHPEbCleSi/0/0vd?=
 =?us-ascii?Q?24cYsQlVU29k1hsbEQMAE7U46Jag9EcS0SI/hI3N/xaitXO8vs2QYs9Jvyxx?=
 =?us-ascii?Q?jwTyNLNXauMEdii0kTVR4llhB/6G/MK5jPC3cHetvNBRuhtsShyR/99REXzm?=
 =?us-ascii?Q?TgUHIoe14EkQrr+XC0R+y8hVen4pb7xt8IxSnOLYGKLstEz8AvjgRJrKQW+W?=
 =?us-ascii?Q?yjGYA78dmo/x/NbyyScqgJzys2l666FhKOHeum02jU62DfAE9yNtA5nf+dcl?=
 =?us-ascii?Q?dMA1YSnXM0Tz4l4lQSIPW/5aIdNVDlEfNAQSISKz99VobZjon5y6JbAuyQm0?=
 =?us-ascii?Q?A7mdZkP/9sgn3yLdeQmZXffNYyqYd37rsdkZQQR2r+iXVHCJpKvdUMcNva8O?=
 =?us-ascii?Q?ENjyNwDrjwgk48dWuJ5zCryBrE0veJKruDM/1aHWKxUxMcXC6c+qfYCi7bt8?=
 =?us-ascii?Q?FMzfTbXfJqt7VXWG1khBi/8U0przwEYjutdVvijTc4Gd7K3qDNLm5AQJIXFQ?=
 =?us-ascii?Q?GtFUn80yhK5MXBYzz6w2CRr9Xui0YKQ/55z3DqbexPV9p88BKLIjVvFtF46h?=
 =?us-ascii?Q?+/yBat0c2pz2vQ6N3YrbZjk12R7/Ozs8L4vMmHrZNjITGnTM/H5+9BDKQdYn?=
 =?us-ascii?Q?4WlVbGb2ltwWAi3IZOMCLEAIk15IlGAbCfo5lg+7KZmuFmuAgXHTq8gbuZdo?=
 =?us-ascii?Q?FR8nD6cpGObMGSW0p7IDcl6CAWrI2sXaA8kVf2Mv8Ak3ZdNzZRpbNq1RpS3a?=
 =?us-ascii?Q?KbdogitTwTNQFdrg/yGkORanm87aE99PpfnzwRaLdHQTwCU9zMJtbmDDC8aD?=
 =?us-ascii?Q?B2foRTTWsSLQYRbzGMo4x8+0dqbCAF6g74Typajz1ToCYHf9NMzAFku7PJnn?=
 =?us-ascii?Q?0Kx0CwolSCPWv4xvXl3P1iQEkNSQSpamtT31KwrxK9QqddD8TJjbkXhYYJng?=
 =?us-ascii?Q?b9re6k6xFE5ssrbbOYAbNBnc3W7SOO2qa8IATUCqUOVUGuSLoBJ/mVlsjAXa?=
 =?us-ascii?Q?BZGdYjtvUhqmQtp29forj2ey+9FLjvgr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:38:50.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d85b0c-fbac-4cdb-1428-08dd154b4c5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578

From: Danielle Ratson <danieller@nvidia.com>

The test is sending only one packet generated with mausezahn from $h1 to
$h2. However, for some reason, it is testing for non-zero maximum occupancy
in both the ingress pool of $h1 and $h2. The former only passes when $h2
happens to send a packet.

Avoid intermittent failures by removing unintentional test case
regarding the ingress pool of $h1.

Fixes: a865ad999603 ("selftests: mlxsw: Add shared buffer traffic test")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index 0c47faff9274..a7b3d6cf3185 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -108,11 +108,6 @@ port_pool_test()
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_pool_check $dl_port1 $SB_POOL_ING $exp_max_occ)
-	check_err $? "Expected iPool($SB_POOL_ING) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress pool"
-
 	RET=0
 	max_occ=$(sb_occ_pool_check $dl_port2 $SB_POOL_ING $exp_max_occ)
 	check_err $? "Expected iPool($SB_POOL_ING) max occupancy to be $exp_max_occ, but got $max_occ"
-- 
2.47.0


