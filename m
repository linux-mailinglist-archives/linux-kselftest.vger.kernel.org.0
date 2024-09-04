Return-Path: <linux-kselftest+bounces-17090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4888196AE07
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 03:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1811C245AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9EBBA50;
	Wed,  4 Sep 2024 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cc0cvjXa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0044A28;
	Wed,  4 Sep 2024 01:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414280; cv=fail; b=ESudDmUEkxc+CxO71iv34q0r1VEL4W2XqItaCP90OcxkUQZxDulCxtA5a9BSDyUnczmXc3f3xVbCFJmiKMrZuOC3mTPXSc/FMQoBI3uxjvlVZlAchUbRATs9O0u5QYGPVg2Mb7C9pCG8etSpGd+GmFpwaxubk5pU5dtoyVBSfmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414280; c=relaxed/simple;
	bh=mNAbH+w3LMgOOsJWLV+P/AKR3mIfM7SW0HiELHlp7+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=be52+bLYVT5PEzvxMyMb3W1gtgnQ/X3AkUHpr6eG4N470UWTRT5Ybb5cRUtqqijoq4SDJV/ny6TSW35rjZ0XeA62PABlaMgr61MxCQPccUamT92NpOgW01hmT/tKGkb76uE311wUMPKAbyTJkVOkbinMyyDQ0kMskdgYX0OU0KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cc0cvjXa; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmIzbfNM1WBiI5JwBFLqXGCggoz646z+cIRz42ofHxzRaATRWif8gcLnmkUPzsBLVoFDI7/12NgrqoGGIoY551OVfPTKEXGQ0Rx8SNPIb13azstgxD6rE2sH6iZa3UFyf5WguuQG8eh7+GxJBKIt6R1Ok1PqaswJNmCYzTqSMhHZwlgOH+2AK+ahaPFl9+45hfc6Jkzc6fJsZ6jnjScoJI/TeisW8Fh1axJf4LWGCExcPaw28iLhM6fkKktbBR2GpFchJHN1ZpNkhuZqurWnTTM9798pgvalHucAEZC3DmIjnFb3Re0/+Nr8iY8PLTFiFt4LGNfasW5NOlZnyWZGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNlWL0vjnXakQaoAHv5GHzyoVxqD9ZKXUlQ9ZBf/0Fc=;
 b=MILFg7CBxxJLh3BJvjCijWMz2BLj6ZFtx4/59Oyjt6YEJWJCWGgVvfsUq3xgg4pyOV56z6iOxtyySF7Uq++7aQUEIRIbZam9+2tY4OftrePD2hjWKghq6lW8t4fVPiur7fku172WOGZUa1b3byfHLh40tv3XuW/RjJx2KwjB4WpmEtlFqjf6X7mwrMBunT59pypLC5tv/FvD0LOuKkgB5+Oy4F5TqiDTmmeP++u/qdMiHGAgdsmL/UB1OhN5Cpv81uNAFnQ+zCRQ73So+AMU6jHgTV4q+UkYM6Mwhgrx0eaYPUcxXP3hPmEuPnSiH0jYcgjLR3DYRfnqQQeEhURjpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNlWL0vjnXakQaoAHv5GHzyoVxqD9ZKXUlQ9ZBf/0Fc=;
 b=cc0cvjXaT9mdt1ii6HCIdvu8w/j86FP+zhgFuj58oItdyBzfmxYi2EUVU0ash7h10020Tgp5HBRiAvAnTTrV1CGTwU7xWRvuXjjYyyCDbZRcs8Hc3FFoqFX55XcBltVGH3tIBQzza24meRli/hCca+gn33q2wioZ5wz9ErNex9gpNfQ66ZxiGV/Y+3fpbXygEBWrMN9x+tusS3c7d2omSuCeD5BgUQx9siX57FwLrp/PcVXRsqVF89xz2Rc0XJmaN+H5J5qt3MyZX94P5AFAqTYu7oqNJvdCKov+1L5Vhf21f0Znetj89Y5Xk90jltzquXT/RO3keDz/f1qzzoI56g==
Received: from SJ0PR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:332::33)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 01:44:34 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::f3) by SJ0PR05CA0088.outlook.office365.com
 (2603:10b6:a03:332::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12 via Frontend
 Transport; Wed, 4 Sep 2024 01:44:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 01:44:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Sep 2024
 18:44:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Sep 2024 18:44:29 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Sep 2024 18:44:29 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <tglx@linutronix.de>, <helgaas@kernel.org>,
	<jjang@nvidia.com>, <mochs@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH] selftest: drivers: Add support to check duplicate hwirq
Date: Tue, 3 Sep 2024 18:44:26 -0700
Message-ID: <20240904014426.3404397-1-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1868f2-6513-4345-42c5-08dccc8320f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qKCIClE9k82w035aqf7O5NBavMcpQx1ToZHTu1PIaGY6dX5mJFxEBdamnusy?=
 =?us-ascii?Q?X7WNBhexWorD3VnfrTzj5ma6CDBLNy/uHXWalV8bamcdmouseiYzap4a/XHA?=
 =?us-ascii?Q?RUwjCadH214q2fN2scCQuJ3ExPvx4hQiK8XO/9Q5TaP4knPgYuqwwkNpC7vi?=
 =?us-ascii?Q?WMMtWXtfmhTD5uuR1fHuP9D+p+/83OXBramMcb70Gl/lAgYJSPMdFojvpkJz?=
 =?us-ascii?Q?OMEvL+1ZvutLKOwlb5+QfseXJkEV79g+ZFPvFWcNWSoxDUwQ4ZDwJr1qYPVv?=
 =?us-ascii?Q?p4za+aNMVZ0Oi6sin8n6mt4vCPPz8gg4KfE5PTrp6BCmivYahLOIRROXlZxE?=
 =?us-ascii?Q?dwF5XIEY8MGKcRWVqgdQzZdiKWFaMc4tOLnnuLUfbx9P2XLcSKUlDmZZt14D?=
 =?us-ascii?Q?7ihof/hus3olbCY0d/B/nusgyh2VwdalTUl6sx1MTupNV4Gd+Q2baSfb5dDk?=
 =?us-ascii?Q?m92OADyQfG0mX2dq4nkh5stRVpjSBwm8SdSgxTRcFEvmCIHErrggrVJPUrZp?=
 =?us-ascii?Q?ButPsr0lZvF1YwDYBMgXLTmYtKS8AYo5e51exe+SMN0SBOUKm7YPfJjETCVY?=
 =?us-ascii?Q?1SuCCBB4UGZyCEijPAU15+WPHxBHnH3hGH8Gf9SSahEw9yfHOZ8FRVLrIrgp?=
 =?us-ascii?Q?olPzBSqO8KJZUKBONbDyD149PQQkItuARtKq+nY6PlqrtXiG45CYilHI47Po?=
 =?us-ascii?Q?YCFrRX2ZWw9HkDq30EA8y9uUvl7cqR5vLJgATDRXyLVUuGUpZi5ZIv0bVgsz?=
 =?us-ascii?Q?uFm6/INS8JMuOOYB8Ll+S9i9brqO0JCRUEJsogxT31nPaSInOYet90CejMYp?=
 =?us-ascii?Q?ULvCAvm6QzUTCgDOIrPUhJTj3kDHMD46twGhRKA/Vydp6GSq9Jb1tI4TCUIM?=
 =?us-ascii?Q?62xOBobjJfw83iU66NtFjqt6sJgTR4cO34I85vcLOZF7CoAu0kDN/i/Efq3Z?=
 =?us-ascii?Q?YfkLQGDVLZ2vHbx1IWlpMtP9vsu9yQ2ZJjf/Y8AjnB3ZSdn7JH/lRyEROPOe?=
 =?us-ascii?Q?uxcaZ+pIyor8gGInjez2zgwFmstXOgCB+jGm3sS9FQD+U3cTO96XXtwkSd9x?=
 =?us-ascii?Q?UynD2UiDl+Aij27LsBqQcSYbiEDzJWz7FTN2PuDdTFhDy38INuHbM35aq6mr?=
 =?us-ascii?Q?q11+1tvhLTstg9AmFCH/lpnyysW1ioPPNKSY2/eSvKOsXyuLtxdFwoZdpp9y?=
 =?us-ascii?Q?4WNAY1SUld+kHsAXwkDgyfIju0KahDEMN2pNmodGEAMnyYJTp1dA9dJtr9uv?=
 =?us-ascii?Q?jf6/yCsrtITMa4NXIu60m7WMMvswALdqSSjS4c0m7e72XxbkHJfXRzH7K1ak?=
 =?us-ascii?Q?3Twa39+0IgDIrdK9wUgnVpxxFBV4de7NZJ1zEBRkJY7vEXHOuPFjGqdORjUc?=
 =?us-ascii?Q?Pbv1h81eAv1p7sBWK4EDzNQmEvGRPlG+Hfo6OjnLibtcJPkZt6X9EuSwaoEh?=
 =?us-ascii?Q?qYBtwIW4euKD8YsVnG48+rtuz103Hth+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 01:44:34.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1868f2-6513-4345-42c5-08dccc8320f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

Validate there are no duplicate hwirq from the irq debug
file system /sys/kernel/debug/irq/irqs/* per chip name.

One example log show 2 duplicated hwirq in the irq debug
file system.

$ sudo cat /sys/kernel/debug/irq/irqs/163
handler:  handle_fasteoi_irq
device:   0019:00:00.0
     <SNIP>
node:     1
affinity: 72-143
effectiv: 76
domain:  irqchip@0x0000100022040000-3
 hwirq:   0xc8000000
 chip:    ITS-MSI
  flags:   0x20

$ sudo cat /sys/kernel/debug/irq/irqs/174
handler:  handle_fasteoi_irq
device:   0039:00:00.0
    <SNIP>
node:     3
affinity: 216-287
effectiv: 221
domain:  irqchip@0x0000300022040000-3
 hwirq:   0xc8000000
 chip:    ITS-MSI
  flags:   0x20

The irq-check.sh can help to collect hwirq and chip name from
/sys/kernel/debug/irq/irqs/* and print error log when find duplicate
hwirq per chip name.

Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
[1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/

Signed-off-by: Joseph Jang <jjang@nvidia.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
---
 tools/testing/selftests/drivers/irq/Makefile  |  5 +++
 tools/testing/selftests/drivers/irq/config    |  2 +
 .../selftests/drivers/irq/irq-check.sh        | 39 +++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/irq/Makefile
 create mode 100644 tools/testing/selftests/drivers/irq/config
 create mode 100755 tools/testing/selftests/drivers/irq/irq-check.sh

diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
new file mode 100644
index 000000000000..d6998017c861
--- /dev/null
+++ b/tools/testing/selftests/drivers/irq/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := irq-check.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/irq/config b/tools/testing/selftests/drivers/irq/config
new file mode 100644
index 000000000000..a53d3b713728
--- /dev/null
+++ b/tools/testing/selftests/drivers/irq/config
@@ -0,0 +1,2 @@
+CONFIG_GENERIC_IRQ_DEBUGFS=y
+CONFIG_GENERIC_IRQ_INJECTION=y
diff --git a/tools/testing/selftests/drivers/irq/irq-check.sh b/tools/testing/selftests/drivers/irq/irq-check.sh
new file mode 100755
index 000000000000..e784777043a1
--- /dev/null
+++ b/tools/testing/selftests/drivers/irq/irq-check.sh
@@ -0,0 +1,39 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# This script need root permission
+uid=$(id -u)
+if [ $uid -ne 0 ]; then
+	echo "SKIP: Must be run as root"
+	exit 4
+fi
+
+# Ensure debugfs is mounted
+mount -t debugfs nodev /sys/kernel/debug 2>/dev/null
+if [ ! -d "/sys/kernel/debug/irq/irqs" ]; then
+	echo "SKIP: irq debugfs not found"
+	exit 4
+fi
+
+# Traverse the irq debug file system directory to collect chip_name and hwirq
+hwirq_list=$(for irq_file in /sys/kernel/debug/irq/irqs/*; do
+	# Read chip name and hwirq from the irq_file
+	chip_name=$(cat "$irq_file" | grep -m 1 'chip:' | awk '{print $2}')
+	hwirq=$(cat "$irq_file" | grep -m 1 'hwirq:' | awk '{print $2}' )
+
+	if [ -z "$chip_name" ] || [ -z "$hwirq" ]; then
+		continue
+	fi
+
+	echo "$chip_name $hwirq"
+done)
+
+dup_hwirq_list=$(echo "$hwirq_list" | sort | uniq -cd)
+
+if [ -n "$dup_hwirq_list" ]; then
+	echo "ERROR: Found duplicate hwirq"
+	echo "$dup_hwirq_list"
+	exit 1
+fi
+
+exit 0
-- 
2.34.1


