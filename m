Return-Path: <linux-kselftest+bounces-46746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF9C94CEE
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 10:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4613D4E17CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4C27FB0E;
	Sun, 30 Nov 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SlhSQG35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116127E1A1;
	Sun, 30 Nov 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494489; cv=fail; b=p/iSG0/+QPVENAxbmZK2PdwM/uPHk7fgULAnQSwFdT321N9Xjl0Hqhgs9KYnwK8bi24BbvqwNdcRnyCDBL8ZloXBSxxt6D4Ls8S3rgDuUzo3P57R27vQXwLVN8evVE23iqRn0RoeBgdlsgyifg3CQ73fgBxYQTem5yDvB6IZXlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494489; c=relaxed/simple;
	bh=sAa+ge9ku5HAJWp87AI2671Isqrhhf89raCiPccET40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8hnDI2tr83FBtt/3dtdfz3B4Yqg8nTPSxyyydqpcbb3ILoY2D1DFpmBuXsOUlOe9LIvR843WtpgazCl6dHxsvh6rXl+cqi9jfnkd0CPArWlkqnJPQJ5oo+myxPAh1lbwkgOUuS0HO9h/74bnZVlc7Y9ck2xnFZSNLN2QlV58LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SlhSQG35; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9K4eFBLPOtXT+YpJeTLOXkCk+R5+jcKon61ZWM8L0ekZU0QcCyGRah4x1VXIspM6UbVsgxs/EZhIOJbQSXWLOJvMuTgzScIvtbSg3j1uZzlw/GdTZaVbdXPuRzOolXlmq1AcjPtibrg9SjlFCFrp0QZ6vOyceKFqLG2/Y2H17+q3iotRvcihO0LurCTi40mqnTVIy/cX66tjULL1MHv8g3IDK+EueaP//LlHm27Cgv5dGyQQupQQB5mJfvvw9OQp23RqqcQtw9QtnzdcRx8Favfmd8S2Y4z0A9logaljkZYwupZtJb2C+rgQYEIESXbMXbdrHdHvQa1EdVs1VIVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=u64vwqZyXDjOLXMIRjuk58BVNQe85CPWB40yKnbAU/rR4qPhhjdYjmqCZEa8ORTPvROTixiWshf82nMalJCAPUU7IcISNF85akXSZN7vqcAOu8WNL+7nEZ3jVpIvOt6/KZlK01FsfQyU8pUw6LcWEJNq8vlJ6Tu9seA4Ye4H0wSyNHU4qDLoZAMt0A95vAETeyNdR1j92Yju6PCgUXCWehQhHsfFiGPdN0qVtSqS0KzWioT3KwEdEf6ehcpeDO7hNE3hH7u5ItmrWD9Pmw2VYPyWznJweH/rDxRD3NaY41Ny5dtiYSApH5Oio8kHcK4rv1BtgGbI9ohDwunP57M4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=SlhSQG35emx9fWJtyU07SdKYXAaHYQj6LIWK27h8qCSB5F5sRY1SYggc8WmTn/KLoSprd1HWHoZl17FWDEUvNYznZLzNzLEYDrR/O690mXTAg0d2pbZQzkmVJJrzDVZn+TK24JAUml5vewNuATZK1nRp6jALZlYmXk0FyPkUOnNIsTosMhVd5xcO6tFrssvNUcbZRdZBXOKlOPQ8raJGtPheXHU7zuHSS4Ub0uKoXOam8vuqsxbChzPCnJByazLQP/Gtq4HpzFWoM/mkF4mSLxa/b1c0vjQwO36lBTzXnpFrYDiOLLL9Emit0/F8JczjqmtTHSSysOZjqgjzoYAmow==
Received: from BYAPR11CA0072.namprd11.prod.outlook.com (2603:10b6:a03:80::49)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:21:23 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::20) by BYAPR11CA0072.outlook.office365.com
 (2603:10b6:a03:80::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sun,
 30 Nov 2025 09:21:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sun, 30 Nov 2025 09:21:23 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 01:21:18 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 30 Nov 2025 01:21:18 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 30 Nov 2025 01:21:14 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next V3 4/6] selftests: drv-net: Set shell=True for sysfs writes in devlink_rate_tc_bw.py
Date: Sun, 30 Nov 2025 11:19:36 +0200
Message-ID: <20251130091938.4109055-5-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: fdad17b4-dd92-4a6b-3b26-08de2ff1d47e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5Wfn5XPz7YwG8L9dr0JxUqvrcUqkAlPn0Dlg7UmGR+rUHZu3Cfss0cTY3Eq?=
 =?us-ascii?Q?tUCxumwXnxOhseSbqgX6gmCtm+rnnX/yDW4BWYBBx9DvF/YIGKH7mN4XR1Vv?=
 =?us-ascii?Q?Ix4mA+Fgwr0aDSJ+73P+YTV+6lF7aw863Ls11S+AzbDlKKP3XFksMa5taaZG?=
 =?us-ascii?Q?DGAJcijyNrbUCYYcunEf5uiBR6/3Z1vgK6vbvjrBPnOs/LAl5QkqcR0u+UlF?=
 =?us-ascii?Q?jIPrpOMkOvy4xEcHsK4R+jpt73eES5pT8mNWM8kPlo22a6ew0/0FYJYjSzyo?=
 =?us-ascii?Q?tLRPzH0r56vKWaSBzfzSYKeq0+BgU58yS6cjI6YMBzdPOBzWlcTvw+zLqCxj?=
 =?us-ascii?Q?1apQH2m8NekYii7uFaV1bPcMW5GyptLvCjwuL5DRrS06HqoCICMcUnSECCEq?=
 =?us-ascii?Q?+B3rqtjPQSjiigBoWKA7RaUDOUFSoMnxlU50vQWEZyRcOA6RfrY5pRZdZmET?=
 =?us-ascii?Q?6mo0rEI6Hzj6OzfejTvNQnH+0WkYDZ6IlPj1k/+nHvQ9axFfamBXEmN7f1SJ?=
 =?us-ascii?Q?nJa7PWhBDpKf41M7uJ9CZjH+JII/G33RkrCh11Bi8rL6fXPtPhtb0xMxfAzz?=
 =?us-ascii?Q?hSGBi98IdIzbWJFo12eDUXSiKFwejHSO5N5+tIdJujUnEAUKUCfFq0VJcYkw?=
 =?us-ascii?Q?NlNQdl+rdUk1Umv8/IGlo3k2rLghuN5B1BejDagCyxWy8h9Xru18my0bmx8g?=
 =?us-ascii?Q?yVQaQxalztQw76AmHPcTJFu5m9N6pvxuU/Q++BA1C0a3JhoUq23A6oegszzy?=
 =?us-ascii?Q?fHUbN1qpm5o353ML5l1LhuhBzL+OhcF2m1MY7OIbqtOVzY7Q7SfFpyLDq8Fa?=
 =?us-ascii?Q?6k2blfLUHxTqQkGja9lm3Gon7IDKHZfyB0P2C0rK/kacoHTXL5lamen97jiC?=
 =?us-ascii?Q?Cb3dsKU1YSLr/uZpWg793kEfM6m77/3klbfcM4760/qrjq02ttq7+z3KVmPr?=
 =?us-ascii?Q?ccv9SrBYbJ97hiZwOFZaVRK5pbUS74vyMelVpr7q/CiGuTbuKzVbDdYkP/ld?=
 =?us-ascii?Q?ieiWm3DfWP+nRdLECOPTmAKRUx2hjqqLtRDdWtnqRYny7z+rcpp2eszIFb4G?=
 =?us-ascii?Q?AhDG7UDG26AVDnWeUiAj3vPkWtUEdNpjeJJGaxaG4b7Aiob7FcSCQrAH7o35?=
 =?us-ascii?Q?ZL/V2RKRy+xO35fA2dEc9cG9ZETyYJYyvgcV+Z7jl4XeDP8xWeIzzqZhqXOd?=
 =?us-ascii?Q?ghhFaJApgULQ4fTEzKy2xiuinIIYYV602/DGU/pdSgDeN8tyhzsTxbWfHa6I?=
 =?us-ascii?Q?FJj5T4AfujaPY29wP5MPCCLmC/lBueG/35/qdm+uuR42mpx5KMV13txiRKcI?=
 =?us-ascii?Q?HMuNID3mDyiRgVkwu6uXbBa3CwCefqO6yTRvPoDwK8/4+v8ZCfSrFcVQkBs7?=
 =?us-ascii?Q?oihx2EVg0uliV/ahW13eJlg3cypTnMdpofa2kkXWCl6LJeKoau/8HwFqqHB7?=
 =?us-ascii?Q?DaDmLiRYS4LEh2bUuUWVZulw+o0SBWbPtYh94qNxBhOfYs37GMQ2SB8RuJz3?=
 =?us-ascii?Q?QEoA+aY/8F/xmw1nAYN2QW45wRAml7JypsOB9PTWxbbmiKiD8QkEnQu/tUBf?=
 =?us-ascii?Q?XEPlIzseku6BChpdkh0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 09:21:23.1713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdad17b4-dd92-4a6b-3b26-08de2ff1d47e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445

Commit 7c32f7a2d3db ("selftests: net: py: don't default to shell=True")
changed the cmd() helper to avoid spawning a shell unless explicitly
requested.

The devlink_rate_tc_bw test enables SR-IOV by writing to the
sriov_numvfs sysfs attribute using redirection. Without shell=True the
redirection is not interpreted and the VF device never appears,
causing the test to fail.

Fix by explicitly passing shell=True in the two places that update
sriov_numvfs.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
index 16e5dda5bee1..df71936531cf 100755
--- a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -117,8 +117,8 @@ def setup_vf(cfg, set_tc_mapping=True):
     except Exception as exc:
         raise KsftSkipEx(f"Failed to enable switchdev mode on {cfg.pci}") from exc
     try:
-        cmd(f"echo 1 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
-        defer(cmd, f"echo 0 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
+        cmd(f"echo 1 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs", shell=True)
+        defer(cmd, f"echo 0 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs", shell=True)
     except Exception as exc:
         raise KsftSkipEx(f"Failed to enable SR-IOV on {cfg.ifname}") from exc
 
-- 
2.38.1


