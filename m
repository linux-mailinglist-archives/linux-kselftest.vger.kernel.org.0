Return-Path: <linux-kselftest+bounces-46743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08662C94CD9
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3B345A09
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F482737E0;
	Sun, 30 Nov 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lbRXZhUU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085AF14F125;
	Sun, 30 Nov 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494480; cv=fail; b=GZZyu6RI/eh0KyAs2j/mDCxgKfjowLuObv3dn+OsbBPYghmJAGrXoNkEvS3OvYbFin1fq0haj/aHXPJP6UrWBT00yTRTIkaRPRwF3+4obVyuw8aJNPWCdgmlt5NB3sPUVkB9K87nm6PWLSNTTLYiczRyi0c9ZJqZnKwBkW+CXXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494480; c=relaxed/simple;
	bh=wYVrQBRnPixKwqNTb7NSZOC6N9hZ1PbdFcv3tv7R3sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/XfmEqWhTmWfwB9OrDvyWyBr8wsJ/mBq1vjRCliJTB0D0udbhljXNpy2iaW98ogv2IDv0a2Dg0oham4RnXZgB+HmvDI+d5cYbcxOB1Gl+NHPjCRuUjuG/UImUzZKNAZuzVzOaJzW8YRUnAus/C1LCPtJtFHuoWz5JwDZoFI88o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lbRXZhUU; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9AcR0tTA2MxgmpFbYS8qf23ekz1RxWnPiMvC1amfxRZpcIWiWTGped7SiSLgsd2RBU9nPEgnIBFyYY1grPfi3XDan6wB/6v1LaodOsWgPytyEB7OmrwB+8XmZKm8zWAf4VRgRQUieP7mrCQoyCPS4F0rcRech+PnqYO3lxAklIRNzWIk6FBl+u92vUwG+ExCmAFTGHpdN/hHhEwEXqtf/DuecX8SgAN+0te2jA5d9TmbKFHzscLGy1sMdstKWfr59FX9daXC+p6M5rV+paw2xb+Pwmzdz5Lq5JwwCwv3qRhbKTesrotsZXVA9ksXWRSc3GiqK/Oy00xZC5YHl5+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L//Zt8VVRQBeKMmfozwYyRj/Cql+0z8sq+4Ro6NbEDk=;
 b=BrdHugmVIXxu4z3Ir2WqYUIy24xGZRQXoeQBNOXjfUnetZF/Rg8wRzY5dqz0KNVHQO9hSxRizvIg6S9L1l4XjBcpB0EZvZHzk0vgh78X2F29HV2dXPuJS6jVkypZULFijCls2WUHrLU0yh9a25QkcQiHiur2WpUe8dzqfKwsFr2MtP3etWaUrY0r5qEl2ycMqpApie3464LDNo80jK1y0E2YLuNVAOS63/iWtD6CikBMENTQ0l5pWciS+6dUZ8lGLcrJzmBIHYU5H0wIlFnkFIF50KC+WJcu7k6Kz0tiQBjuA3O9Ht2s9a2H32B2ON+7KkfittcvrknQ5Xl/8en/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L//Zt8VVRQBeKMmfozwYyRj/Cql+0z8sq+4Ro6NbEDk=;
 b=lbRXZhUUAtMLJB4TDQ8bz4FmndoFUSHN2EqKJ1thUMfzTsEAJRc4KsExdKyr/Lnck3oQQeX844ygl5QxvVJFxGE7SPx0hcpGU9H1o2rkl0eUmkcuE0g7jq74rNPVvNb/wUEIsO8Hx9TVjeb2r6viXgIIyTIs0CY5qSOyUeKHDcXFXO0sNQJGJZYZ60TtKgpaVAzb+CmsGtEim0RiEJzIYatw8Y1H5qtiA53UGEQPq/UvZFgYxatI/AJ7Gdg4ZkLMs+cpcJNatDNn5GufcLe0NRXcrl5cRbpkBkNCYm6aD11i5rd4+LOVemX+UYczv3/jjD2pwgWZqn8iTEzN2vCFsg==
Received: from BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:13 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::84) by BYAPR11CA0055.outlook.office365.com
 (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:04 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:00 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 1/6] selftests: drv-net: Add devlink_rate_tc_bw.py to TEST_PROGS
Date: Sun, 30 Nov 2025 11:19:33 +0200
Message-ID: <20251130091938.4109055-2-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251130091938.4109055-1-cjubran@nvidia.com>
References: <20251130091938.4109055-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: be65003c-7773-4fb1-2864-08de2ff1ce6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7G4PheqTRrYYNFJmGRSjFOiEs8iJVp+UeUWAn7HuWwohrEWn586gKETuxEo?=
 =?us-ascii?Q?jAMOO5rVK68u4ZI4SZpyuYH03+cSE14izcr/JXDpmcgFMgRNR3pOtIa6eZDa?=
 =?us-ascii?Q?droQs9kIhQR/ElXYmmTsexcan3wx0Ovj8SXJCxIizqyxNsX3zXbZ0luLIvwA?=
 =?us-ascii?Q?SvZ8DTmGKBQripYVB/1tCgm8kL1dWCvtUk4v1qdsyPCtgAlwVgbNySmMKfgg?=
 =?us-ascii?Q?l67co9fHK61qSW4xbDq+2JWGGGBhvOREp6tmFooNNIdd4qZkf0pLCulHrZCC?=
 =?us-ascii?Q?7LDsufUQ6KypJOap/mj8QWPuqwTeHDdzFUW0EJ5ICIYPZjJeXVojsZOA31qS?=
 =?us-ascii?Q?BPI4x0RUD0qzjeln1HBRpTBkDG16FiCU4WI+YAUobHzpwgoWgy2I9EtkFSWy?=
 =?us-ascii?Q?WqNTKOhA6fGSFEnMuWH3/O/nWaKAmeYGqqj5GStztnuW4pG+imquIFtka0VQ?=
 =?us-ascii?Q?kbtA5sn1Kh0T3QW9WhnWze/5qNisYTDhRYGUGaB9YLXxMC4YILxnLnIqF473?=
 =?us-ascii?Q?do3BcQ9fK3PQUFmMOmJ5ZKRnA8iPho3NCMl1eL6uWQQ7qOtV8f0nkH3LU+T/?=
 =?us-ascii?Q?ZwXU+6LbGhpn5T5X5cWuPCnOoxdiiDopIf5C9id7kvt/m1pqnKdxJXcOKktx?=
 =?us-ascii?Q?TuvLDoyf+TztRQJRpkpq6AG1Ml5FXqQr/FpFZzvf7r0PWNN6tk1iNtBJb/uT?=
 =?us-ascii?Q?5gmtw5ZH1fC+qOMmJdko7VuRJZcTP347w9CG2HpyNutt9ob9RQMNN21NpBqi?=
 =?us-ascii?Q?t9MwKE9bV3oXJ66kxEpjRwqX1DXDkyInA/uN42i8p8/JYIJJfkRlgHDFEKHo?=
 =?us-ascii?Q?2C5f+XWbrWuahSfZvt/ugPdPZ5uTGBYg8QS+RaYsdFRzSx8EUOr092n6YUyT?=
 =?us-ascii?Q?A700lzgJUPtpRJ+kAj2GoPAoBhSxesreOp5w0zV6jLILAj6tTIInJQfOV16p?=
 =?us-ascii?Q?jF19jys95/+t7+HZX2XpfbnB7fINZYCsSYysXEmmeG97QdVI8SyX37l3Wm1P?=
 =?us-ascii?Q?tkRE+fH27uH3r7WX3uYb++csKzw73RB4tULRMtjWzCpqTKG8iwdX0JA1sy4l?=
 =?us-ascii?Q?vjNSxj/59JcVUzcsIIgoF/80JZKTrZRWQLYUurAP7wpilCTP8Pe8olmJ6+cs?=
 =?us-ascii?Q?zkJuJDjK4bOlYiKLWkLL5Xxj0axQQgHdkv+QzzxdMWJ741WpN9FkAYhCq4qT?=
 =?us-ascii?Q?vKb1/E2u26XJs9fHUT/+cEjnyX60Ne1LzatHkGoEXX1Q3wyDALFCJ2jgtRf4?=
 =?us-ascii?Q?za7tHX+hH5B5F79ih/kyZqmT9DMq6VVXg9OPV5uhNMWmRuhnKFqpbA1S2nkT?=
 =?us-ascii?Q?gaZEPwSk0Lune3ymudYuDtkEl2qnz3X5jczXYlZyjGXrfprznAFaVT0qnwSE?=
 =?us-ascii?Q?/ihtdKVgXLPAJGh6w4gR4yBt9UallvDJuLWOrQWBCW1CS1Y8qWZ3fplnSykW?=
 =?us-ascii?Q?BbeAYVDoYA9aF/YpkMA8jz/Hs9tjTCjqwAR7D7e9Tyy4LGxjLHcaQ/B8bMQW?=
 =?us-ascii?Q?wRkWDoUldLZbsDjwwoSdqSFUNpVIJ3fKbDCe7YTb/+AQQc3dNun5Jf0fBv5J?=
 =?us-ascii?Q?aI7lOHpHevctrNm4VaU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:12.9996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be65003c-7773-4fb1-2864-08de2ff1ce6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62

This makes devlink_rate_tc_bw.py present in the Makefile under the same
directory.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 1760238e9d4f..9cfb61eb0b98 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -8,6 +8,7 @@ TEST_GEN_FILES := \
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devlink_rate_tc_bw.py \
 	devmem.py \
 	ethtool.sh \
 	ethtool_extended_state.sh \
-- 
2.38.1


