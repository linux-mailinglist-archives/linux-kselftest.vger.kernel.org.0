Return-Path: <linux-kselftest+bounces-48686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4CD0F811
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1728302F925
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39C934CFCC;
	Sun, 11 Jan 2026 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+2AE9tc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396238635D;
	Sun, 11 Jan 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151844; cv=fail; b=Q5ic1v/8QZHWtPxd0A5fh9WMC1eV3/TIcAxg4k/8h75WAsbQ74cUbEaRUImhkJPAPp2mI0Y+dPRdMEwTjSTaQSN0EQAy2VpPp+mU7U/Gb9vAths5zYSQSt2tW9RMN/fif1YUVPUE+yYEuANRXtQ6k8vocr/3/R1dVWe9zHy1qcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151844; c=relaxed/simple;
	bh=22zQReNrRHEsiuaSEOLjzCH4y8skJV7LJFh8cXOUEdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOATgvL3xGTpBZNVd7M6aj3vjUhgQcQVQ44l+LtoBbDMShQ77QTJy+RaGVIytsFwB33KcNlNuJJGrTzz5ISw2e/MB4Co/5vQi9esIUYS5eNWjjRspnnZGdxmp/euDN29jhzUTFA+RyGUThr1DQ+a1+l4XwryRgJ8fRe+38Hz2yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K+2AE9tc; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nutYpK2ZL4IdL4/MkwFisJ4jGsEz/L2mWwRWJnprq/8GaOyZ3w5pAVqqo/zm6uspSDCP0s6oVFpcQtZmUBVw+dgDz+uQafhCr+5euyuITPMdERgLDziGA1Dq4sjGzWw0FQ/Sa6PqwdXTbgWZnDpryEcnkBLI8oCvlVXFYsLr+RvQ2L5NqepWCee5OleXOB0og8iRa5tkxj6X9486M/KRJyVyYo/b4tvK2WVsZJFhxzVYTLFAUyRzD/jbIjQife2h4NxNirNZoqznaGEGsC72GQN3GT1hIiWlbaLsVJpzEnKPK6msO0QNu0hm65Rr6pky8Hxir//U9dhazpNMIVGWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h8b+mPlW4D5AbVXw+gXO08KAElu+ENAV+L3ng3LB1U=;
 b=Ywj5uco6BmiCqwbzMPEulNlRrZAIiCCbm3sg+TEZG1xIgK8CI4Xf0/mDA9w31RSksmsnaoV4q5uZ9aWGvcNmWVVmfdeZMXWwVDyUAK+qSNlwBM3osShPvegwXjCAWhZsyb+oIezK032Ex94hQsJPyYnraXPqhOaUzHsSlzB4p/1BlxFOKh2mmpjw289ZrpGoIOFUXBcO2C8FyIj8dK3JQRmH7QnhWCkU2XiylDD2EJ2RqV8S1bleBF6Q2CU7xUoqZH+8c5VJ69EE5vEuye9QgwURobC+MABpcDeT3JjVov92DPP5U2Dz8smMBdO+Xe0tBe60MHaxyjFzwwYm4Hk8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h8b+mPlW4D5AbVXw+gXO08KAElu+ENAV+L3ng3LB1U=;
 b=K+2AE9tcWWQR0UkM+fJXnHzYyFuGAg67NKhoZ9nV1Ku8JJRQ9TVYILR547AHukKXHXmwbpT8SaFONCRJ4qKQfRcUeQgi9HRRQxJ7ovkoSHO8VuavedVWFs12vtZYGS8Qke0DYFjkb9q/4nb93LUit0Qvfjs45qnNAYPRxyPNhl0ciGlxhR7pn2ItSljrJknlPnAOeyHMVc/4to2nKFgouwoTwYoZRQQw7k5pF4w8Z8HnO+Zj1jm4XQ9PpR/Obdf1E3jEvTsr/a6i+d6xB/BbWweJ8hCtNuZaJlbwEM493dzSX0deEDsM3EV6+PLsIoZlcUvPXdMY3nkaUa1BRGyVgQ==
Received: from DM6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:40::29) by
 SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 17:17:19 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::2f) by DM6PR03CA0016.outlook.office365.com
 (2603:10b6:5:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Sun,
 11 Jan 2026 17:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sun, 11 Jan 2026 17:17:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 11 Jan
 2026 09:17:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 11 Jan 2026 09:17:07 -0800
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 11 Jan 2026 09:17:03 -0800
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
	"Petr Machata" <petrm@nvidia.com>, Coco Li <lixiaoyan@google.com>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next 1/2] selftests: drv-net: fix RPS mask handling in toeplitz test
Date: Sun, 11 Jan 2026 19:16:57 +0200
Message-ID: <20260111171658.179286-2-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20260111171658.179286-1-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4e4728-03c5-4a09-f1a7-08de513545f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2nRaMgeruRyrV//i2Et0H5OIVjuMm/RytGBpQSdwGO8buTC3a3kKioI7XiBO?=
 =?us-ascii?Q?4DTMmejdnXLq53SWjUehvp3D9qj03K785iCpzvUwpes3puaqrerKgE763aVi?=
 =?us-ascii?Q?QroOHs8TRfifZvGenL83rz7nqEbwPg9gge4gkWc92kzj53OJ9+rp9iJ25Gbf?=
 =?us-ascii?Q?dJxVhUk0IVxljff2VtHhil8pE4L0Dmc1Cz+EsL1kEA15eS4kVSUy3eNEHXTo?=
 =?us-ascii?Q?ov/xgEWlqYK9iJgmeHpCuMz3ZgXBYhovsPNr4uVff3jCEhykvNdbrCxaB1H2?=
 =?us-ascii?Q?ICmtFWMnf0WmMZY+MV561ej7KXX9qjksxUOsSnFBul7OeMo7GvNJR9P+jNhq?=
 =?us-ascii?Q?X3Pgq1P4oOjDtGpBCD8MRsOQtpHtgx1NbOSeZksMh6RM3d6SD45tHPHJAeV2?=
 =?us-ascii?Q?W3M6x0NtAIVCZ4oj/zbBRyU1BiV82npjNNxkPaPMfprjSXGkd7W5m8Ora/2R?=
 =?us-ascii?Q?ppzo/jUMxzBiRRKYIQ+565Q8bUfRTaZuvOEwU7tHTQ3gGVgBBCR+L8C4Ywhd?=
 =?us-ascii?Q?f1VIn0qweDWvVreqklo7T4N27nznRoDkBhWXBfYDxVGem8vfPi1R3XW3zbry?=
 =?us-ascii?Q?KhvrD5KdrEWpsB+hGLMBmQNhBdzxTklEszCyncUNMPqUfL99k7rcQK1un2wZ?=
 =?us-ascii?Q?E5RNE9XWSdeR68eNpc1yGGLSh6uW+43fRS8IbcGL9Y0UgEOfF8pMr49JqCJG?=
 =?us-ascii?Q?TY9c3cN1FASUBmOp9f7o/TCyRz7VEFTCTMU2IgSCK3/G1Z8RRS/XllPmq4kC?=
 =?us-ascii?Q?iWW5LxGDlPYbNqfq4wnn79fPxlFsM30y0SkIvcrrMFR9ZkGGHVeI+3ut096A?=
 =?us-ascii?Q?IO+5iOPWSypgVUa+djZHhr6Z89kdThbbEAsAxAhHUhIJ0UpCIxpmlPTaC748?=
 =?us-ascii?Q?+EFLodmATHHV/EsuUJlmUKp1ESE6yL05fEmvg3/kYflRjUtKOc6MyIK8WI/l?=
 =?us-ascii?Q?zU0pn4keBYFSQF71Rkp5Bd8BbV2/+W952Ef/HjNyX358xFeVxlDUIh2TArly?=
 =?us-ascii?Q?lOyf/bY67whtW6d5WElufPIPZOwUb1C1P+CmrSmg3xkndHi1DAGbGl12UQLq?=
 =?us-ascii?Q?UvmyD7NZXczobffT9ghe5s9ywu5J4eG43cnZLFPwCOxmUST3oyuyvQ3C8CuB?=
 =?us-ascii?Q?/KMSswB0ijrDqUo3KZ9QtHC8oUJ1e4GhM9ND6VviB7JllJZrwbxGwRJVugzx?=
 =?us-ascii?Q?vO8A17ft1IdIRqagyiG0ucjI0yvYDRLkOBZZpv7yjcpkkFttWHXCDUjLeoLV?=
 =?us-ascii?Q?rzR7rfXLKrOkBjJW6gczjAfyVMePStFvxCtEq16x3VE09PCyhg3snqXJwLeW?=
 =?us-ascii?Q?UnafhGGNnYuV3/4gD+OY6qP7wa0nWTsZOjjT+W6XtQ00MH3f8k/6qPN3c232?=
 =?us-ascii?Q?SRSkBO1aWjI+FBLI6aeGv5C8lceJGluVvDohYaLANu3kWhEIBRlrbHfPnafL?=
 =?us-ascii?Q?DNVrgmM7K+HJ+SgMu2s3sLgZ1uLFy50ttqTAAs7AANVEdWa1LNlcu/5Zku2w?=
 =?us-ascii?Q?QHOqslXroMLaU2QS+EIh/9yvwSwGZQ3ApWyJVEWERu5Qz42sUGaVauOYqy5T?=
 =?us-ascii?Q?+MpIUMh9iYAx2nqHuPc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 17:17:18.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4e4728-03c5-4a09-f1a7-08de513545f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737

The toeplitz.py test passed the hex mask without "0x" prefix (e.g.,
"300" for CPUs 8,9). The toeplitz.c strtoul() call wrongly parsed this
as decimal 300 (0x12c) instead of hex 0x300.

Use separate format strings for sysfs (plain hex via format()) and
command line (prefixed hex via hex()).

Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/toeplitz.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index d2db5ee9e358..7a9af4af1838 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -94,14 +94,17 @@ def _configure_rps(cfg, rps_cpus):
     mask = 0
     for cpu in rps_cpus:
         mask |= (1 << cpu)
-    mask = hex(mask)[2:]
+
+    # sysfs expect hex without '0x' prefix, toeplitz.c needs the prefix
+    mask_sysfs = format(mask, 'x')
+    mask_cmdline = hex(mask)
 
     # Set RPS bitmap for all rx queues
     for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
         with open(rps_file, "w", encoding="utf-8") as fp:
-            fp.write(mask)
+            fp.write(mask_sysfs)
 
-    return mask
+    return mask_cmdline
 
 
 def _send_traffic(cfg, proto_flag, ipver, port):
-- 
2.40.1


