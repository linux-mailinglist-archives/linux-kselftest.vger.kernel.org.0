Return-Path: <linux-kselftest+bounces-22878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 669849E5B94
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43383166376
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F320522144F;
	Thu,  5 Dec 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pIQvGXda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B53B3A268;
	Thu,  5 Dec 2024 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733416744; cv=fail; b=DjpdRiaknv/hkHmbmlcid2ncbQcIlurN+SwonLh5MWULGfKRMHU+8peByHhPbJ/PCn+V2KFi8gKx6Eyex+ewRiQmyX2PtR4wVDPVe/0B5/xpCaUSEBfzm9eBBT81C+m9fmg+tXVSNsvlvr5fIBj+r5Sysi3748oqdUu5GNHCrzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733416744; c=relaxed/simple;
	bh=j+rMkxl0OGEAvT5xhwAscA8NAeqkMIoTaUxMASNQysk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlHyXUwXgm5QQGV+mSTGrz2llAaXEmIjelRcM34XXR9ztT4sXNBWvcEkl5wrHgnu759Z1p9fdWljG2brcUofQPF+sIU0TwmmENLuP7uBbdIT9tLOLFvbMvlZ9rVVww4HFSq0A6DaMNMqNIyv/hUZhWWwvVqTQCgg/iLCQn/Oeh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pIQvGXda; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/ZkR8vKK+exHSCG0cYtQOD37G2Qhz8S7BtiSFEVtXc2wlF9RNkI+mFmZVmUwYc+4RBfdDKdMxjNqt/oouUzS/Yl8n6ToAh1xIQZS3WvTT7VSbSxgB2xdhF/whk26ov2riVt3lS/KSb+ApoIdlWeCH1L/x4N5q0BNwFe5qT0etreUN6YxCiP3AHXTYOnwz9LTxm/qWRC8diPCFHeNTlijCOe85bO+I1ifViWvwkbyufnugrwztdO2Y+Ol6p2I/SDqyghFKOs7u3rZQk1Ajf/OLxPVzWkYwyMHbmnpUJLyEWDO5OQ4C55KESum1InrnIysrk7t2Iac3+SWpBttXcsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1iOFfYFOxojhetbUXgyn70w7elYGWXBIvHPT7wDvrQ=;
 b=NblCDobByK3DVqHHdD31NDnaPmtGpBumd8q6gpADPAWfSf9aNKMuzp7+vY5d8qZkHB5E7btxrqHGGCSX/V4OzdVyZZAy8Ww0ElI2JY6ETVYbcd6UFOrq1p3H0vVFVcDibf3eawbxz+XfaxeYFp0fEVV/8E34r1975VIjeQ8i8L1XTCywoYtf7tpqjK5XczTtiOHAekB42vFU36w4fJcNVZ5rcTGueOK9hoSedCOYXP5jM/+R9VCJ0GNssRp3szB719Z60J84Qt9u+OQtLIlqWI0ditAZ6mS5ABMdZkq3Aetl5yVdubV2lKQ8OS3wk9YdQW4DR0NGzBmHHThToKTYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1iOFfYFOxojhetbUXgyn70w7elYGWXBIvHPT7wDvrQ=;
 b=pIQvGXdawihBE8hVDFEqIAWFtPNKlCgiH7qsoQ2fzLoclVP8MHBloEOg7O+3uBPlLkECC1J0cDS5eSD0UePm0bsagJz5pRhW8RWqc+2415HvD+DbqQhIWrs/3Gp6iMpgMK/Vax6TuwvvJaQlVT4A50jBsPMdaKi8YcS30tN9gZGwGErmozkyUxv8IUxQze4aDXOzOxZUKY8hoLYQCnHsUq7qN2XYo4/NtDxEXYAPaQh//amihmfPr1r6kFokVEPT3AcGJI/K7N5hVmfTwPxCakZ4MvmlvspA70UMoJNKh4DWLprtltQyNECrkxOdWA6esH9uWo7q0FPmJY63Q457OA==
Received: from BYAPR21CA0010.namprd21.prod.outlook.com (2603:10b6:a03:114::20)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Thu, 5 Dec
 2024 16:38:58 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::a8) by BYAPR21CA0010.outlook.office365.com
 (2603:10b6:a03:114::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.6 via Frontend Transport; Thu, 5
 Dec 2024 16:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 16:38:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:41 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 08:38:35 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Shuah
 Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 2/3] selftests: mlxsw: sharedbuffer: Remove duplicate test cases
Date: Thu, 5 Dec 2024 17:36:00 +0100
Message-ID: <d9eb26f6fc16a06a30b5c2c16ad80caf502bc561.1733414773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 360674b8-1a34-43b0-515f-08dd154b50cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sN60pSM3Q+sG+ZHJNRSLwZGEMpndQS+no8BxNZ2fiOAq7/pocGjFiS2++IPf?=
 =?us-ascii?Q?MrCNhQGDS6x6rmp+G64G+RizwEH3l7CYiZkTOO0t4+ns2S7ufAwv1PTwLMmP?=
 =?us-ascii?Q?YmwtzHXpjJJ49+U1kX5ukUo/ROy83myesPqlW7Rg3F/5l29qgaG10TvgYSsB?=
 =?us-ascii?Q?iOM4vj0r/+WQhy00hmV279Cy5mkP8ZDIVScj6e2k94P0EE0dDkuJMpQgwrEm?=
 =?us-ascii?Q?+Du8KG3/5VYeKlrrvsdwpxPQ6gL/YWIElnaPYOhXzmCugnrWk568jW7yHZmD?=
 =?us-ascii?Q?SKRppmoOMXtl9AUPU7d1fLhniQRwgdlFDy8Hy0tHGf3J7QvsOwqgANS73Q+A?=
 =?us-ascii?Q?bJGULqQp3MTuBxV3+7zfAgwFMgiaBY/BP7M7um4w5GFOtEAGk3FqNpb9rX0G?=
 =?us-ascii?Q?chWILkT5u3AA1wg2uTK78py9irVHOpwsU8KbX09BWZnpGWPRiywO/Z9MqNat?=
 =?us-ascii?Q?8Uot4G2R91wPHZPgslh0NH6nBW48SEb2LaieAva+NAGT3VXOeIOGngxOB5fk?=
 =?us-ascii?Q?9/xF1EISA4XZgpu7P7FAzsfhRdM51INrqpOUE49vaj3ESJMKWswA8rINQPiR?=
 =?us-ascii?Q?rVIhpGXMQiz8JjA4phaTmYovpOfM91qmV0kXoyhj+agSs2cp1kwUnLocnHk3?=
 =?us-ascii?Q?N5DrSlQ8aUGcv/TQl/NKEGBzCkw6JW7HDq27Bi9J1KrWIh1jJ0SUfAhUJe7l?=
 =?us-ascii?Q?T/jAmYcvUK2IgLnjWd1njzrp0B7uyHu2ChSoKIaQ7EmZ9DYOZZdU4m2rl7LD?=
 =?us-ascii?Q?LQfYfKxCa7xfgFLf6Y1ArtclLA7BqPyeuW9UkPoF7naUo5q/kL+7qqY/YJlH?=
 =?us-ascii?Q?OvC0q9R4G/6poSFct9iHjS8GhEOjBu56b21YelqtsgRsX13VvwUpS2rFSKG0?=
 =?us-ascii?Q?7KXbvemq/EcKko7cKAfUbO1ZUij50HPRO4KxhQ4NSkoI3ur/PX/eNoAlZLtE?=
 =?us-ascii?Q?U702J4xYKjkaf3AoBwvM7o0LHK45OGi1nR11M8kmu2hyzq0NNiVKwp3bt9cj?=
 =?us-ascii?Q?6lOXjuS2N05Jk3SjFO5cnAJnPhl+3aH17/CtUV5oN+8eiXFsu4ArA6Bpd6+z?=
 =?us-ascii?Q?6p25XJ1vUXUV9RLGHtIy/G/vNl48YRBHzPh9y2lECjFAscS4ng+dpj9wXE46?=
 =?us-ascii?Q?Am5w06kT2vci3tVbAYZ6JKFjkx28ov3Kcl8AkP7HF+slPRRdTp+s+ENTxedK?=
 =?us-ascii?Q?cD3M/mHEEfMvmLkDeKOu8Fh8YA/aKhfxt/G32XOQIlbbBq6es4c4v1HVwUBa?=
 =?us-ascii?Q?Vqv9wztNb6tvqYpXAZ17LR9sdmKcrSjNDOK8Axdt1SV2EXB3puJSXU1tQJJu?=
 =?us-ascii?Q?N4a4maF62pG59zarixSewCmUngydGj/ox99C2oS0HIZaFHQfLtjzYfv5PL02?=
 =?us-ascii?Q?VyQfcTiUqZdjQjmo8Z/pUCZpfoLifZpbBC5w4KeiIKPZNE0ggoYk0pde4PLi?=
 =?us-ascii?Q?vmM2pefF1Fia60kE0CLOya4Qk7lGyzm7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 16:38:57.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360674b8-1a34-43b0-515f-08dd154b50cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

From: Danielle Ratson <danieller@nvidia.com>

On both port_tc_ip_test() and port_tc_arp_test(), the max occupancy is
checked on $h2 twice, when only the error message is different and does not
match the check itself.

Remove the two duplicated test cases from the test.

Fixes: a865ad999603 ("selftests: mlxsw: Add shared buffer traffic test")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/sharedbuffer.sh        | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
index a7b3d6cf3185..21bebc5726f6 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sharedbuffer.sh
@@ -131,11 +131,6 @@ port_tc_ip_test()
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
-	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress TC - IP packet"
-
 	RET=0
 	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
 	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
@@ -158,11 +153,6 @@ port_tc_arp_test()
 
 	devlink sb occupancy snapshot $DEVLINK_DEV
 
-	RET=0
-	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
-	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
-	log_test "physical port's($h1) ingress TC - ARP packet"
-
 	RET=0
 	max_occ=$(sb_occ_itc_check $dl_port2 $SB_ITC $exp_max_occ)
 	check_err $? "Expected ingress TC($SB_ITC) max occupancy to be $exp_max_occ, but got $max_occ"
-- 
2.47.0


