Return-Path: <linux-kselftest+bounces-46089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E1C735A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A87B22A313
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614E331A810;
	Thu, 20 Nov 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlVlxl75"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010023.outbound.protection.outlook.com [52.101.61.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A596331985C;
	Thu, 20 Nov 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632870; cv=fail; b=qMYbIS5euFDSTEE02dOvxVYyz/oCYcmoJxV99SfI9duaV0Dh1wez5eZ9n3ATZuLQLk2SRcxz2ogeA1PPmcelqhTeVtXbShkUUsWbExInjzLMFyzaSPMWYII4cMk/4vmPthdXaXZ2U+WUeiZ73r1OGq2aAguAQm9M5PcrrT9OF4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632870; c=relaxed/simple;
	bh=sAa+ge9ku5HAJWp87AI2671Isqrhhf89raCiPccET40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2gs97wEwXMdbx7jnrgXlmoIXUhroz9AwFEcKfaKRlvVJgskylFFOJp+c3f8z6JP7sS6dAtr/Oy518E3VuQXMlpBoOrukWF6QzE3AzcASRwfGTKLhTegsHOXMO5Iyij+LFADy2dcbW9PjDGCSgy42hFklw9ZoqtNq0O55/m/n1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WlVlxl75; arc=fail smtp.client-ip=52.101.61.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8DpkFZUYajpK+MuHWz9xtN879n+LdkMu2R+muYCNK6OcKU1gn6zvSJkoWwUgTZXllu6eYioodEKCTMW1sHKoZwN5AzTQLDiSH0ra1U4McjbObuJNxSwJcYbq1ThVWMoaTOIMdgStA5DqJ4MjGcsfiHAaL9D4/XFqgzB4X1lj8Co5eNoXfEdFQT8D5djPZkoOPGf7q95UG6vzZkn2Z6CqFDBwS3JXdN0t61RBZKNCOnUXNS0ai2shtbIKiB30rKxg9KR1fuRYQLcNxHTJDLrSMcfqqBANHAdHq9Bpp0rtdHda7TcGwYkKIduhLciZnuzx5LukuvweCYfUrE2XKM/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=Zm34RhMWdzYc5Xq/fnXib7rQHUMAILHrtlOokv8h+fP3m570Xe4ON5DFMhd/8TX6k6hJkQdbgTdvL568HiIAa+F/wJvkxCpWIRNrYO33h67UNiscrYvTThI0mHR4OirwZ8wehe0qVyPd+IyGt3Ikx3olDyiRXjhWaQwVpnDLnMA7r2LP80l1cR7DY2K8+cpfvpz2zNB7C6g96cGu2s772IgyGG6tzFo7EStJRLzR3xdtMMmQvSGDtTcofEjLP8rdpkqQV39QpiyQE8ZBNPgzIoNhbDVvlQanbg1pdCyziiLkVhXaWMWu2cSrx9kFO74smHYIIIj3bKhFfveUpEn8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP0q6TIgJ9EjCNcc6wziUi9NikAkWlvNVdFxksGqn9Q=;
 b=WlVlxl75eltl0viPGPy41xJ3OLYGcQ7BrW3iyd2mfNgM0oIXMNh6XFmMRdp8wO2e67qY1ENw7Y2Mm0aYN513Ghssw4gUM9WLDx4VmsLCp95/4Bj/8oHGoPKDr2JIBl55b8XUxgggbfmTriMBESppGDJdlyYjYIzRfV2NXvc8CJODaIaZ32gVmefhnjp5OjbYKBSG2d/eh3Et2i9rX0JmVcJovQzfc9US5ggABX0s8gT63wd/DcSwnQK65PEUOmevnc8M3xFIyqUweXPkJR+hjqOdEqSboRu8VWZEM47CioeVQu2MML8ag+v9zyxUyPyZsKUDgPliwnb1OGZS+H/wpQ==
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 10:01:01 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::f1) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 10:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 10:01:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 02:00:38 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 02:00:34 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 4/6] selftests: drv-net: Set shell=True for sysfs writes in devlink_rate_tc_bw.py
Date: Thu, 20 Nov 2025 11:58:57 +0200
Message-ID: <20251120095859.2951339-5-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251120095859.2951339-1-cjubran@nvidia.com>
References: <20251120095859.2951339-1-cjubran@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5e6baf-5437-4c6b-b468-08de281bb621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nWiNjZLbgfsgdWeBf+DNrJt5mxsyDSsmgb/ITAj/N1d1dMc2Q1YtvxbFHxmL?=
 =?us-ascii?Q?xyZirULMHdRxoPILellbMW2pK5N1Gb9SGpsPLGIyEXOtqtMDHdZtLA0BOllt?=
 =?us-ascii?Q?6gSvqb7Vtp9Ym+IETM5rg2Jtakcj+vd16f+PdoXdxtQRfndJdiR+9Lrt2xRu?=
 =?us-ascii?Q?4gXCuP8q7qJF9F1AJEyRmtLyuakPbNIwpGQPjZQnf3UhSKXzDWcm71tc4fFQ?=
 =?us-ascii?Q?dDWPMiFj6Kp9alVG4L5P+g3AlLPnoCcA05PmjdVXVUuTkHHP2wJepJibJs+L?=
 =?us-ascii?Q?GQVGoYb2Aj8pXhLFXqV3r3ZxLRNORHLIA+01cnmtjH/KPtZEl3ihj0LDCMAX?=
 =?us-ascii?Q?AgZFReUIZ8tjUpFRB/2iBxXNV1fTBWQuQi3NQE6b+TS4SpRfZW4ppfo4O1yt?=
 =?us-ascii?Q?7/mffq+GdC/ZzQ3iQPD0PFQT2jPw2GhUELpNu0kKrGhcYi7tw5Zxii/j31DC?=
 =?us-ascii?Q?K1ummv+fuBuXoiUPBV8OwhoIfH+9/U6dLuJskykHZWHMvhosEjXc7mQE/bKC?=
 =?us-ascii?Q?e7V5T549MuCg4q+M1UcH/umuDMShLIpiuKa7ZLteURCzYMkBZxJwEY9ytlHv?=
 =?us-ascii?Q?ayEVL2mgGoEVv9OxOw3c8VF1mf4bh3jW+vuoToWlVcL5Rf8DO+y26qkCS9oA?=
 =?us-ascii?Q?7XI/UG6/EU7kn8TpExSu/vb0ZjuQ66LCI01leC9mla7PwQOmuvyVrMohDmh8?=
 =?us-ascii?Q?WDE1LMefTbmqE4sCYvixamtFf63Ff5mk66RZQs1SiVPe9uE2evy9hsY+exyg?=
 =?us-ascii?Q?MEx+aA0bfM9wgi146m/CnhHQTyjmovtcr8oPVITlMXqSsvPw81H9n0DcpN2a?=
 =?us-ascii?Q?SZRhiU/gY+6yo/5fCyyTeecWCwaDDYUo788oRVTPPxuDpWN8YI9SBGCK+Um1?=
 =?us-ascii?Q?rkSprDAtXOHmohdXweJ5Xj8+a+sla3yHprjdPp30se9sGWiaeIuCWmaaje5H?=
 =?us-ascii?Q?5/CiETzLrTcjkd1AI3W/n/fpIjM10J7KpIXTAwDZmXlZ8JzI1z1TpF7nUbaZ?=
 =?us-ascii?Q?VPKAiMyAwY0HGxxTYAy0UdgF3+VvX9ZPdKXxRWdkJKZbYqPsD5q3ZVY+FukR?=
 =?us-ascii?Q?FaP24LF+qqI+w7oQ7VW96Np5GfZDj+Nk1SbZY5pIyWXcBYMN0MfXNaPXQok7?=
 =?us-ascii?Q?dr3aNWv/t6SBQGQRSlBefnxIBMSRSIpd2cEfYVcmP+pnzo8CRBKR02r3/puu?=
 =?us-ascii?Q?6Z8/t/0B0ZWvheSWFm6JoNogIZEI/dUryc2Pltkphk8otRe4kjVqO25FZi4T?=
 =?us-ascii?Q?gYD7ID+S8GFao8Qf7gS0hqShfMjQApt44Nk5rXRWhMPDzRA9grJjA73fkU1b?=
 =?us-ascii?Q?eVOL4iSAeMx0tcBmzg3JvvhOKYicTAMHsk49TFWfEEKFywa526UB3qQiNV7P?=
 =?us-ascii?Q?UdAx5xMxQyjvmGVBUIlKE3Jm4dYuMgl0JkZwDfJF/2g1iTidl4bXjN9DCtn3?=
 =?us-ascii?Q?0/24j5UNIhtMwgzkSbNqVKxSMoLoxxNF0sTekl3MBtxmafpI+j2CXGX0yo8k?=
 =?us-ascii?Q?y1Kyk5UR8W4xeGzjgXzKipQeHmPpX2jVE10xUW7bUYADAe3ceYgDRRL7qzdK?=
 =?us-ascii?Q?xAbo7gwkg3cXYo1LyRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:01:01.6674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5e6baf-5437-4c6b-b468-08de281bb621
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

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


