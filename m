Return-Path: <linux-kselftest+bounces-10889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269398D42D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74423B21BFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ADE12E71;
	Thu, 30 May 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YlJ9IHPK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77E86AB8;
	Thu, 30 May 2024 01:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032465; cv=fail; b=CU1GDbn58DOIF2ozS7siPymUp6oFHDvokwqmRcI+MlyeCkB6+2Gt6xvhuZSaxIN9envN8pgl6YbcmuyURSsglL6ggAzXwZodh7rg0cUK7miij0ZgqTQ8spzlUsqudi1Uy+wbaws7veLkB1KBeueLVVeQgnAoN249KOp5EeNXJX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032465; c=relaxed/simple;
	bh=/i64T992ZR04z3OtccoV9yOhEAM7e1lPQTN2OXW0tZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/nuNP6YyptT5sK9xcwpmFnNVB/SjwS2aHeIozaZrlcn6IKNvp1JS1tbhvOia+2Fm/8z2ypuQI1CDfJA1xgpQRYJ3iZukNt9vkQP5uFDPiWWIENQWQBEESzU+wSlp65gqctZafP0mwxtBi2/H9yaDiEGmX+pnyQOaoiTXkYk2b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YlJ9IHPK; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkLnDTZnipYMXkJz9yvnhDwMrnTgnw41wdgKf2m6l5s6QJbYT6PJcp46FUIfIkLkSR3kd3hHv4Ff9f5VBZw41xeZOElKrovs4hIgaXkbtqv6Qs331AHa8yU4HMk9lrXaS95Mdi8KSuMgkIguAqMIxqbAqEsHOLlr3NPVjLphItAcb9r6/wkWIjJ1L9zR5bx6NWTjib81y0vX1INyNhd/Y+Uy6w20CfBnuckp3OlCfUE+xlFuSkg6TmU7MXjfpuJ5YMSQAu8QbdpYLPV4Dp25GpJix0+Mli+s8vS1gzQsNlvr1VDiHEXykpgADglQM5GvZO5SPTrM0HvlrwqMB8PX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8bOPWUiUeGDBizbphPuxJVHe1xNYJceTxOi+XbUZ8s=;
 b=BFLU0yMNypbHrxBjWGLZFN/NoUJDN+QDbTZzILZk8RAL0aOX9H08M4Iv0AHze0BtbgrITi3QyG2qiEhWdeCdUtOmkuCeFj4+2PTqyWNtPeA0N8VmuVU1jsho5pBOVeGKAwZCljCBieAUWGFxRg/omrqXydzEJZhXnguAwh85bEXd0jg7Y+sf/0OyC04LH9WnzCri8/avuWTPlLoFDcwlpsGAiWJmX5bDdO2mdVMSan+49t1St3jTBL3uGhajZobu4Ogz0SHIUBh94LqAcVPYUJ+m7zqGvSUwfpblP0vkxlrRVhi4FOrijjapuCf1cIM8zU6AH5/mR7iseAKEZDWNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8bOPWUiUeGDBizbphPuxJVHe1xNYJceTxOi+XbUZ8s=;
 b=YlJ9IHPKLORZgZ2P/IEV/hiKSZAzoMeT8BZ+oRx+RJIz2cYj2TQ4GEUseDao6Lyxp8JI5q++XWPbXX/ZXfCx9zTAn9LS7rE6Rzcwu1PGO98tFXJ9Q2siH5VBcT6rnKC8Ya0PzDf5PVFfV69fKo+B1Seh0Ny2g9+eehK0tL+L+VwJbAcFmnxVwcPqfVO2IM+Azut1JFrTl9BMwR7Rg8HQidW4+2n65JwjSp/yskhU9Pc8LXjaLPKhmMrYCt6YBCSlSOhds7s7YtkWezDGYV9slYX4Vgg8jhNy7IxzHZTkwZw5D9+N6eNFzBLo0AaL+nNbB4IVqQO1TNF8RbBFczCaYw==
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by LV8PR12MB9359.namprd12.prod.outlook.com (2603:10b6:408:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.34; Thu, 30 May
 2024 01:27:41 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 01:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 01:27:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 18:27:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 May
 2024 18:27:29 -0700
Received: from jjang.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 18:27:29 -0700
From: Joseph Jang <jjang@nvidia.com>
To: <shuah@kernel.org>, <jjang@nvidia.com>, <mochs@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>
Subject: [PATCH 1/1] selftest: drivers: Add support its msi hwirq checking
Date: Wed, 29 May 2024 18:27:27 -0700
Message-ID: <20240530012727.324611-2-jjang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530012727.324611-1-jjang@nvidia.com>
References: <20240530012727.324611-1-jjang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|LV8PR12MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa95f74-7313-4cfd-1e44-08dc8047b275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fq5S/FpKBlLiFriaQr2XdbKsFZfFJ8g0V78DgKyiSOuZNweHLc4zGdVjX+dH?=
 =?us-ascii?Q?zl/oHCTRGk8i56+g9uzCViTbDrUKiJeVQv6kxM77c3pQAQr88cBLW3+uIzr6?=
 =?us-ascii?Q?MWfM3X+XkYw5bu7Qf1J+nKiB+VUFgwaBkLZvzp5KSS15q5LzF8udCfbh9BZP?=
 =?us-ascii?Q?fuDFZK8q+4QeQlS4n1SB4gSd8od/AXyjxnINHwc5DdQVReqvV8ZrtjsbG4lU?=
 =?us-ascii?Q?etNFoK69xPJK/SvMgf1iEfdJWeriKiEFMXX+i0GgQCcBpTCosp56Nz4CDzf+?=
 =?us-ascii?Q?Vjz6YnT4042R5DD12iCVnDrI1qNFhTFzPSbd+srK2HlmC2CWbBa9+aZB3W1j?=
 =?us-ascii?Q?2sADjWueEuTzPWW6mN0tt0COG/0kRAAag66RUYXnA7TlhIye4Bt0bp0FSl5A?=
 =?us-ascii?Q?zVwIzlgIQkUG9aDZJzlmQx8a8aHeh4AqfQ01oFp/q+xF5zV93C/Q5iunZGmi?=
 =?us-ascii?Q?lZa3xmqYCXn2TfDUV/LZP5vXdeOvbuI8lcj9WRB6fNvRLUBGokr4F5IZONT4?=
 =?us-ascii?Q?GOPQu/yZ2DFFNcNHfOin4ueVG+mqQ+x0RZq3xumUOlGjhVbDcerAJt0vf2+a?=
 =?us-ascii?Q?T4errKJjKD/tddKMbk0j3BBeNc4Htkxb2Vv2HdHczy4DYHLqOeR9Ufi8HP5/?=
 =?us-ascii?Q?1Lq85t99JKfDz9hu5A9sToVd/WiuHEZBwthCqrzC+BEwe2yv2XqyW+L9ofw8?=
 =?us-ascii?Q?unqy5b53mDQsIxzkPGRcz/Epk75WoGmz58OoE8uAC079Qckoyl9LrK9CDr/F?=
 =?us-ascii?Q?BR7tGghOoi9w7lPwW1AXRAnZme5LCFdldm8rsa6Ye0wG6Io2RNhV01EiK1eD?=
 =?us-ascii?Q?cfrnyTwD9027CzlSIabUtI7Eax4Pz+/oVuCztmdh66dQhlb4+16KE8hcmVAb?=
 =?us-ascii?Q?Oy2/WjstKzxFBbRgLQ8cBJ495NgEjTXt30nvVtp5Y6XOGRE3Vv0DqPmMQ1FQ?=
 =?us-ascii?Q?X9Ek81OocVXb0I4/rENKt8CRcnjG6ujHY7mMMZDjehCCEjBh+dKXwVWgzE4S?=
 =?us-ascii?Q?m0FdmAuRGKPmAm8EezFt2PbTwclP4QoXixjhCMW1TWJCJgXh7g6wsbOpYhAC?=
 =?us-ascii?Q?5OSFDsf4VkoVoWgJUNwouuaniCtF2cUDHS5CMKH+MWmXA+xNdr/aSYZFrpl1?=
 =?us-ascii?Q?YJFl47ADxB2obQVSktWu3M6viUsn6knbM/F7Ri7InZmxwCJC31hOj/1Nfh6c?=
 =?us-ascii?Q?YJTNtAZYRAmveW6YrtddFu7rH7spaIyIDa9Y+/Edpe6Lgi3TOx+uBTt7wjKr?=
 =?us-ascii?Q?v+G+eveQEP2sqK1x2Yw23YPd9sMNt3ga/ooV7nRzE2hPjpaXYnuWcpHc6nTP?=
 =?us-ascii?Q?XIkeG0LRFd9ommZbssrZi6xaXkNHMVvXafQAOAPsJ5NJo9Fv72KQgCrqkH+4?=
 =?us-ascii?Q?iGNkbjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 01:27:40.4664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa95f74-7313-4cfd-1e44-08dc8047b275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9359

Validate there are no duplicate ITS-MSI hwirqs from the
/sys/kernel/irq/*/hwirq.

One example log show 2 duplicated MSI entries in the /proc/interrupts.

150: 0 ... ITS-MSI 3355443200 Edge      pciehp
152: 0 ... ITS-MSI 3355443200 Edge      pciehp

Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
[1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/

Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Signed-off-by: Joseph Jang <jjang@nvidia.com>
---
 tools/testing/selftests/drivers/irq/Makefile  |  5 +++++
 .../selftests/drivers/irq/its-msi-irq-test.sh | 20 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/irq/Makefile
 create mode 100755 tools/testing/selftests/drivers/irq/its-msi-irq-test.sh

diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
new file mode 100644
index 000000000000..569df5de22ee
--- /dev/null
+++ b/tools/testing/selftests/drivers/irq/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := its-msi-irq-test.sh
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh b/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
new file mode 100755
index 000000000000..87c88674903f
--- /dev/null
+++ b/tools/testing/selftests/drivers/irq/its-msi-irq-test.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+if [ -z "$(grep "ITS-MSI" /proc/interrupts)" ]; then
+	echo "SKIP: no ITS-MSI irq."
+	exit 4
+fi
+
+# Get ITS-MSI hwirq list from /sys/kernel/irq/*/hwirq.
+its_msi_irq_list=$(grep "ITS-MSI" /sys/kernel/irq/*/chip_name |
+				   awk -F ':' '{print $1}' |
+				   xargs -I {} sh -c 'cat $(dirname {})/hwirq' | sort -V)
+
+# Check whether could find duplicated its-msi hwirq or not.
+if [ -n "$(echo "$its_msi_irq_list" | uniq -cd)" ]; then
+	echo "ERROR: find duplicated its-msi hwirq."
+	exit 1
+fi
+
+exit 0
-- 
2.34.1


