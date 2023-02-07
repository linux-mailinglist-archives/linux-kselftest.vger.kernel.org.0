Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207268E2C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBGVUf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBGVUd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:33 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBD212B3;
        Tue,  7 Feb 2023 13:20:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV9ABVCHgcLvmiXeLNoVzOhil2IfTfkg3lng30352BJla/Ez/jnL7bZv/BIlLdD+YQbIvwKRgzNhJ6KH39goltNpI/scC3lkMAUcSnc+v/I2AKECFg7bf560b9s+FEKKcI6klMVviNlPw6mGjsiM134mseCiY/hnFJNpROUKFt98R0Vj0VXux/x2Q4Wh1lhAmqPyEavGgiBO9nBFwcZeSFsqYiHrdUpvSliZ5sduXAa4BJdxXqGIGgjDcLYHOvm2/EuthaPbxOLKl7nOB3uBY7PTk4xppkkaXSXFHM9Q5F4qvRBKdxkKBur3kCx+fnu7u3Nvv0MoWbtm+DUuLCc8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3OmSdtlI9yKY2r3I7FpPQKJ62ROtlnkPC3bvXFSPwI=;
 b=SChkGxNvr8qPgDJqzpCQOXxG8Of5lncDt2xqrIe+6WPRWnzlLKJuyIM8tB/ct7FX9aym+kfOcHfW6ZD9EADgSNV8QaSxEqkmFpdpfKBSDxcoLVz8sN/q1PHTU7TeQGYVCpokmrENGciS35lnwWkqF6F8KWKHs/Fl6GvOZZ0JA4oBsrk2pqvptAf/y9Agz5o/6NkDjo9sVE3+IAJvMxEoE3hVM4leaxy1v7ahV9bVNCj/MflFHzHO6kGxdbkDYCsJ5MehQAlUoU2X6UWvspC7tRE1R7BwDM/8j8YQ2vh2V09Br0/uZPRcHKQSvLeTJcQT+5d0OZfFSUSPOcLl9TxzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3OmSdtlI9yKY2r3I7FpPQKJ62ROtlnkPC3bvXFSPwI=;
 b=hORxxfFuE11JgabH8CrT0y2JlhI7srTkecqFunzPGlrF8QPPzOsEEHmQYLkaMEFaPy9l4qxUrGnwNQNIg0S/zUlPLsUMg+PI+tb3JfSv6gROoDUroGKCfr0Ezvs6I43RthXaH0R6fEDCq8JLN+XCjwR7tP+qkhbQyiw8DFcfsTChyYaafiREudFX1hV1tvg5HRjcbRS6jdPK9iZBX4/Ar7zJplXJBUuyhI5OOik/5tNf5TnAaFZKJd87DVavtmjbRbT6uqN8UBBEgbqDQX8TExgAo90mCfX09P0Pr6PsflQSVmqNIh5V87cKjhecnIsa4HSZzF+sO5K+dDahop9pug==
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:20:30 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::b3) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:20 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:19 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:19 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 01/10] iommu: Move dev_iommu_ops() to private header
Date:   Tue, 7 Feb 2023 13:17:53 -0800
Message-ID: <f4df58c6ab16fe6b38dd4925dabbd071eb8d3158.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c40cd5f-20e0-479b-26c1-08db095123bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZnM2CBadZGBk4tlWUi9DJNxMO/w3SgshGeQpDK4+MLuZzuHeWMKuUFNpSSErdm6kuBuCeWwNyZHwhIgdbI+dSkwEEYTMvLdLhcdDy86In3Z1gfadt04/R04ybO/7kXu6pf/DH6qbOwOu64BYDfYJoVt5jDdIzgotB2PAN2Dqky1FGWq/+fkAObU+PW/THNHkUL/6Ls/O9AvZRaN7Prs+aOjE7aPFQrTvs93MnBx1M3yN02cm1uVOOhzxuVvBsJCMMD6rriBL5+qsqWf6uaC/PFUKKf2LUckXQuorD4sqsmSYOoK1+R6DrVP3KWraZEUddHK+NWjKKXcV+Q5jivgoDIteRX4qMgQtGnWozaHUkmYB+10AsVYqyH4Qh3zKW483Yd6WPFjae4HyoFCsA02JugeAeIrkUXg2/9P0Il93Y7pSM+FZXOIUo2d6XMLXLpv25FFluZf1lvIn8B7H08kVtaTCtbciGt6OKXdlLm/hHlsvcENRF5rLWvGAsIzs+qtlNxKVvDf8UylM7TEXHzu7G8JF4FaSijn/JM/v1YXRecMjshgf/t2Hh9DqfelZ22WgFjWAP7yo/kcjIwksIAS6mBHNO7tZZzxckqigkPgh54Wo4r7XvmX2u/8Qo0lW1tTCmZiVBpd6oHv/fcd9aki6gPhLSH0gIEQ1wbL3BBJRFTq1ecQONG7aaYXVbYw+Tb9Owcs6WmpuxjVNYTKL34HSw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(36756003)(47076005)(426003)(82310400005)(7696005)(83380400001)(336012)(6666004)(26005)(40460700003)(4326008)(186003)(2616005)(478600001)(70586007)(70206006)(40480700001)(5660300002)(8676002)(86362001)(41300700001)(7416002)(316002)(8936002)(36860700001)(54906003)(110136005)(7636003)(82740400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:29.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c40cd5f-20e0-479b-26c1-08db095123bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839
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

