Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269E168762C
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBBHFw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjBBHFs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:48 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72783480;
        Wed,  1 Feb 2023 23:05:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ+ULhJCnF3+Qlf0XQBE7Mf4y/Iy4qpy6dN5LKIT+I1K2vTmB3LbKPgUuq2cmBYa5QyZc6amo2aZti5bjituxGnOXEjzi02aX8e3Q2120YLOLEpGewkCX58p08Z5IOxL7y/1wkkn93x/Qau1c0kDLpydosdPvNz2IA3MK9mL9QEVwuSwjWbBSrD4sUvegyxXRb1ntWzc9xeLLAMrDwNLSrrrmzUz63t4+OaqBJk+d1jS1yA0JK/HCqX5l/MFUvsrz4uDLH1MNViNVGH7AZzrilQQCm1yylJnFK9BIYTanVQMI53NnxD2AO/kyum5AL2+gGm+/6DxYTtig3AkR8KRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3OmSdtlI9yKY2r3I7FpPQKJ62ROtlnkPC3bvXFSPwI=;
 b=CxnlFMD+X/fBeUfdu/M5aX7wVWvxzwRqjbWPTgzkbxYj6wIrRVHExZfYSAgL3RuLKVWSFl9xA2TXGs0ecmKRqf9s+wDUJju+ROOwH7NlB9aszDSE0MVSGaVIn4NeRV+OeAieLPTzpKPijuzetlpuugtisQWf4BLBIp2WGeqQGxlvy0xQohQXzwy9kmb+ztXVXpMptS4+dyjITvIz8ynq5HP8cxSaLfkBV2pO+Dk8M65lLtlK3AYGgqTt3jfarvXe/qwxqgCkO4xLG7ASdhOaq2ZxRgLJaIuWWerDabrO4hCUP23MCZi9gwgCH83X0w9ICvW83JStSRlW2rWytmTGuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3OmSdtlI9yKY2r3I7FpPQKJ62ROtlnkPC3bvXFSPwI=;
 b=SEQnEnuoiPETabCI9dsDlId82KDrUQsG967R/Ag7IZTXITSnHMjuBoH9n6yuWcrwsODMZQCM3PuaM1SBVaiAhrkjIaA6Kg+A8CCXjXlJd8aReSHY+QOfMRkuAUt4PmKhLLV/6/Fa3rlvRHI9FMh8kxswEOub/hP75UYsObgLa2Dh9tdwxi6qbsZuTpz/RdSQG+UyloYjLYYGWGq8Z9VezYmDhDD4TLMKGMMegyKz4+pMgkFbWegJntEKfZsYNqaoNjFLUeuoWCZFCoirRyNFc9btN9xZ/I6zlisVfrVUGrjVKBW7huFR3sRZXvdlSj7zNnY29ghwi8i4wfiUaoIfIQ==
Received: from DS7PR03CA0251.namprd03.prod.outlook.com (2603:10b6:5:3b3::16)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Thu, 2 Feb
 2023 07:05:36 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::4e) by DS7PR03CA0251.outlook.office365.com
 (2603:10b6:5:3b3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 07:05:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:22 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:21 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 1/8] iommu: Move dev_iommu_ops() to private header
Date:   Wed, 1 Feb 2023 23:05:05 -0800
Message-ID: <e2b2fb4b2c8d871c5e3d47d04d861b45fb764363.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|DM6PR12MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: 527cb181-9bb6-480c-8bb8-08db04ebe204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YR7PKrcyFktOH3LKL/snifsEJOz2lpYPG9ZH5EY8eDDikf4RnV25daGauywy9M7HmuIQX5GYzX6NR34Co/dim271ryGv4O9yMcHxN1aqFn6WFBcwfpi5I2z6Y1fkjyGvidvVA4ooUqdxTzVVVrnMIeLMNtj642kK6blEulbxGL6Xq+csWoqkMEIlmEho6nwi9qAtBgHoXhE2vmEfDSnV3QgMhc6P4EjJKaPLMGxg4KE9wIneiO6m3WcFIcYg9QCoqP5JEn7f5EJhsIMIFKop7fY8A93dnkbEpaCaXqmFfvbC5JIMCOrt1JDJR9jCsmqcrMfoazDlWILY2ZYdyiwjBHAggY0/ymaM4MjkiFO1Bn1sIRCrRiKZ8NnNPO1haANtP6GLSGD1rp5mvuTzsmvlre682N3wXJollzS3NXPX7IHASdbtemAyCykQ+n/XMKH3Ut5XbdYbh/vMg6LVyaufeHGaC1yVumaMMD3riF+52cQsbQR5hSE+IzVoz6kS7ZQo4LpJsf800t36+b2LuhuiUUWiDUOoTBQKGIfArhIc8Y06M4V1ih7MKQ++U2Fkt64n4I+AIN3BfSeIhc1h+Wp94Vv7C4x8wgFLLIxG0KNgA7/Pd2ZKvfajda6uYlBVUyr7yxHUliqKh0f11TJoqSoBT1W/Cu+QKQIuH+7I69l3ewmn3HGJ2SpxpQXBXfH80cs+mhtAXXth6C2whleSsggHOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(47076005)(70586007)(4326008)(83380400001)(426003)(336012)(70206006)(41300700001)(7636003)(8676002)(2616005)(8936002)(82740400003)(82310400005)(186003)(356005)(26005)(36756003)(478600001)(40460700003)(110136005)(316002)(86362001)(36860700001)(7696005)(7416002)(40480700001)(2906002)(6666004)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:35.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527cb181-9bb6-480c-8bb8-08db04ebe204
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yi Liu <yi.l.liu@intel.com>

dev_iommu_ops() is essentially only used in iommu subsystem, so
move to a private header to avoid being abused by other drivers.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu-priv.h | 18 ++++++++++++++++++
 drivers/iommu/iommu.c      |  2 ++
 include/linux/iommu.h      | 11 -----------
 3 files changed, 20 insertions(+), 11 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
new file mode 100644
index 000000000000..9e1497027cff
--- /dev/null
+++ b/drivers/iommu/iommu-priv.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __LINUX_IOMMU_PRIV_H
+#define __LINUX_IOMMU_PRIV_H
+
+#include <linux/iommu.h>
+
+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	return dev->iommu->iommu_dev->ops;
+}
+#endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4b5a21ac5e88..a18b7f1a4e6e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -35,6 +35,8 @@
 
 #include "iommu-sva.h"
 
+#include "iommu-priv.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a8063f26ff69..cb586d054c57 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -445,17 +445,6 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 	};
 }
 
-static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
-{
-	/*
-	 * Assume that valid ops must be installed if iommu_probe_device()
-	 * has succeeded. The device ops are essentially for internal use
-	 * within the IOMMU subsystem itself, so we should be able to trust
-	 * ourselves not to misuse the helper.
-	 */
-	return dev->iommu->iommu_dev->ops;
-}
-
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.39.1

