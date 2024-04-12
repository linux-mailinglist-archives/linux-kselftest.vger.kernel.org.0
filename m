Return-Path: <linux-kselftest+bounces-7842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA338A346E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857D0B22294
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6414D716;
	Fri, 12 Apr 2024 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UC9hd3g1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE414BF8B;
	Fri, 12 Apr 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941604; cv=fail; b=Q2Xt8sguyfOJpJyiCETYdD6mnAuKMHPvcKdshbjg9xjvNr+tCr8VXoJgnnVUQyQE1fGCLZU1YN/e5NIzMHN+56UlnkpmK9iQuRoh4v5lArxUA4F58aL9sRlzRVZ9ZzyQr0VkG7ibI2Y9IhAj6dtSaFzB+Ha8PT5mZ8y300d1yjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941604; c=relaxed/simple;
	bh=OfGDR4ehzLZyp577/m79HxCNLznCCPERJ00wlB6CHcY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJAElQifRBuQrvey63cInX64K5Cwvs1kcP+a0Vj6QQNkEiqmrk75YRI0aPNghRzxAKxOj9T+uBOlJ9MyxSH9ZOyX06FRoZefFXFJKuw+muqDTt5HynhsSeZfz4/Anje68oAP/BL1EIa+5L2rmDSzdgqXSj/LPVqQb4AzPHaI+mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UC9hd3g1; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwwZIPzuxJMXFyKOb4tS4SaFyxSmUV4grTDyEi2E2XyEQ49PmqKIAkhLTit0kUV2caM3A7uVyw6A5oURw17reAV09Wmee+i21l7I2x0405uHln+tCmAAE+g8kD+HuXMmqvfzF9zgHIWEXNz3KPCPmJvPc2nHUhaEIlsG8vvDdOAKFR8eQ/jqdsgvs0xyhRyBjK5rBB0f9MNMi7zzd/Tk0jQo2tZcXleDw/l7RaVZixqkSWjnBunzLBWGzIPpBfCWVRmIX22Xs1PEKIML7BMf8fWVqJRqwRhcn7U6AhG9/sEhm7sZ/wolDOXJwi+qd4mkuHlfEd/xok+08Fmo9zknsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD3jUmq4wNmXiCMDZxbFK7JFGYDyQDI0us7zIr83hJY=;
 b=jmjl//6eifs3nS3+dcZ4hXX2gBW/dSNfFzV4dR89cowTkR4SNZytjbBz2WwgIJ+50kd/LESFQ53unTJA7FrKCeKzH8GJJSkiTclpHLEAtpZANV6nktOsw/kD92Bsojf7o6M2ch5xMBsHavlhKzj8lNpQulw/OeaV2m5DcBO5as8TQXwgIEIYIMV6+QDhzzvQ5bix1TmzmTVSyAnazjiY3GOIvQ+zEyA5gjvhHaYYzdhXbkSdseV1e+9U6ISU80+MyUGRth/P56PgFqYT91PvtC4PFkwI8UudFBxTKMmt9ot5MJ8up3AYH2YQ9OKg1o1MnuxSOlKzqcF3qARJvxMdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD3jUmq4wNmXiCMDZxbFK7JFGYDyQDI0us7zIr83hJY=;
 b=UC9hd3g1fslqyAQuM29TILAhwy3VZQ5PEp3NJ0IfWeA56LgSd4WZa0zWRTJ97E3b54pIw6VQ7KtIf8EL6kuILyh3OvYq0k0wkOzWGdfu60S5sC/W3kHikEKPL+lGlhK1PD0RErVQ6ysKAQXuE0n3d+8gTY0En+OuoQIpKW5pZ0KpGNrooONrTUEmyYCvWWOXIGv6T3wktK/yflAb4Y/BVB/OGlQnRC9Q5wSX+x2vIou0G7Nu9CTsftzSNUVJ6LuqlMpY7fSQY1uocO68t4+iLFUkF+OpYJcOVTbd27+ck5GPmc1UiscVsJ0xSP33iYxBev1JozOQecHMwgP4snTPVA==
Received: from SJ0PR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:332::11)
 by DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:06:38 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::b8) by SJ0PR05CA0066.outlook.office365.com
 (2603:10b6:a03:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.8 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:06:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:06:11 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:06:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, David Ahern <dsahern@gmail.com>
Subject: [PATCH net-next 08/10] selftests: forwarding: router_mpath_nh: Add a diagram
Date: Fri, 12 Apr 2024 19:03:11 +0200
Message-ID: <2f82d982bf2a7c23dbd8ae63e94c3655ce9f92c8.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: dfe502b8-ef64-40ec-dc8f-08dc5b12e9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PGr5f4mSFPl8SoY3HKQePyORm1y8bfv979KcXfXTYR+AmaRR8PyWYc+w5EoRXcCIX6U0TKw9LrQ57rKY8qhuiAsWJTU5wsPQzYV/+9XlzGKE5Y83/eqKQjv8GURPvq/tkzwAPDqslwJGRL38HIhpieIJgN0mFcxaJWB7Yb7lBvkyKKFPAIUx/ShA1s9PHiVMPNG8dqcAjJMPRGH+Gs2yIf1w5Pl+uxJkH1Zt0KrHhJA7qb6okt/F7DG2wqdK278+2cWnpUaO07xq1KGXBw+ZjhuLLDOkS+9QJvNti4j3ARW0GwnTPN7MFTiJtedYi+Dy19D03njV9iJkA4sRGLePGVlT249usxzW+Der/azhDqVyrsZZ3/smFe6J4asdyb42JM1BqPcwBhPauLBATpoGFYZvixSIv6EL9Ykbmdbx4AFNRQqHKIJhJNBU33Q4ADlXyUuV5ka/hbbGdq8Zetx7GVFdIJ8aibBpYsfjVpv4dOSb5TnUsRWLfxUGda25wc3+uLbg/j0iG5FdiAyoEKFuhTjPxmBWRs07UAD+azgtnijY6Ik5IihCxdjG9XaiU6Sxu66eiukBVNT35TwzmttkJfw7JWGO7v9FhsY3W+TNDG2d3ppmnARPVAKsHiu+z2xQFuZHWqIQj+JvVh//DM4s6sT55lsbdKTIVM2pldpEuFtnsJ8nZ2ZuUMiVHgufU99IdxJLPm1QJaXuVg2zjQz0ef14sEVv1N8QWClRBSL1N8tECJE8pbnZ86XyMDkDA5Oh
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:37.0131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe502b8-ef64-40ec-dc8f-08dc5b12e9df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392

This test lacks a topology diagram, making the setup not obvious.
Add one.

Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/forwarding/router_mpath_nh.sh         | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
index 3f0f5dc95542..2ba44247c60a 100755
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
@@ -1,6 +1,41 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# +-------------------------+
+# |  H1                     |
+# |               $h1 +     |
+# |      192.0.2.2/24 |     |
+# |  2001:db8:1::2/64 |     |
+# +-------------------|-----+
+#                     |
+# +-------------------|----------------------+
+# |                   |                   R1 |
+# |             $rp11 +                      |
+# |      192.0.2.1/24                        |
+# |  2001:db8:1::1/64                        |
+# |                                          |
+# |  + $rp12              + $rp13            |
+# |  | 169.254.2.12/24    | 169.254.3.13/24  |
+# |  | fe80:2::12/64      | fe80:3::13/64    |
+# +--|--------------------|------------------+
+#    |                    |
+# +--|--------------------|------------------+
+# |  + $rp22              + $rp23            |
+# |    169.254.2.22/24      169.254.3.23/24  |
+# |    fe80:2::22/64        fe80:3::23/64    |
+# |                                          |
+# |             $rp21 +                      |
+# |   198.51.100.1/24 |                      |
+# |  2001:db8:2::1/64 |                   R2 |
+# +-------------------|----------------------+
+#                     |
+# +-------------------|-----+
+# |                   |     |
+# |               $h2 +     |
+# |   198.51.100.2/24       |
+# |  2001:db8:2::2/64    H2 |
+# +-------------------------+
+
 ALL_TESTS="
 	ping_ipv4
 	ping_ipv6
-- 
2.43.0


