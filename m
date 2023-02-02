Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC3687638
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBBHGJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjBBHGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:06:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31EF5142D;
        Wed,  1 Feb 2023 23:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km9wG9EEpiV7FB8rM3Ufy6PjJj1lBvlGIJ4+0FURAnKFmtMnBe2yC8kgl5LiLTtCUhgi+tZv7K/4U7rqsZm+8WeB2pacSUw1LZIR5xMtFQbfVZpdOyy1Ezg/m571iZap/VzgLfruFaI/YgPx0SDbddLw2MlAr6+GM1J8eJ5Z3m2JsrZPW9Fv3h5gW7hq/hjk9kmV56tgOv/ZEeycRyWRuJevYuQf0OTaTjESZ1gnjqhgkJL7QtDRxgUTCfXzQxcolk/J02gxYRTkDyYedUXuFKK/vZjdt6eXcA5TKVqFUH1wQ9picKal2uW1iYGpH81NzFy0drU+EQs8DdAYBsQQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/me+yHMo3eWn3IrYZz4uus72G5TkqZVL2HsN97heJ4=;
 b=dsz6ygXOzSPkXUTMxJdCPfXQ4gFMV9E/SDZqGe1E+jpbtTBm1LBQocQ2llkhmyBJmoQZS6600YVD3d7RdTNh+X3KOYd65mD7JJSB5vz5XDhYHctlleWXmS+42/hreo9hLk7fK11s7ws3+I8qUSWo8EHR4xtuUcxTrkZEzuj+zO83luOko9CB3gwn0KFoE23Esi2RSdEkKtmNDYoIEL66FMNnJBmHJByYEN0W47s5WiICWrt06wsBSAV1vj9rwt6oVuSxkMgKwQM/Y4Z5DNJGFzB+tanrzRFv0gmPb/EED+rhwYHIsDbnWDnMXOV3FsHduiff0W7vZhglk0wzV0mKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/me+yHMo3eWn3IrYZz4uus72G5TkqZVL2HsN97heJ4=;
 b=PgFT1KY4i6rJSrR+zMCGvM8zwXiKDeg5Z9/fj6ZvUbsmnnT1yDhsNBHlAZ75jnk3emP/9vllkoWLNhT4MD0bfHOM7Fh0b5hFZvDIBqoNUq/Bg9XYrPzb08GLVyF0n5EfjiTIfUD2ErWtHm3aDbtMTGeX8jFXdyS4ZNmgNfr9QnngKDtxZEq4ggEzF7BeBi2rIhE4vHG7FAXQ567D58Mwq8qMNfs5+z3bCRvLfvUU4/GrErs2xFcW0gSCwUvnUG/r6GFEd2FkO0w97D8NhgdD5Yctx1x2ZS/mRRbL6VbqC1CCbo0Nao6A6izksGbL8hJH4hcqiUfRFYMXsCdy3XOTdA==
Received: from MW3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:303:2b::18)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 07:05:44 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::fa) by MW3PR05CA0013.outlook.office365.com
 (2603:10b6:303:2b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 07:05:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:28 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Date:   Wed, 1 Feb 2023 23:05:11 -0800
Message-ID: <de1cec7698e9b4e2ad03b7d9414b25d655fe5a6e.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|CH3PR12MB7546:EE_
X-MS-Office365-Filtering-Correlation-Id: 380c7cd0-6320-4a85-b7d2-08db04ebe718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dB0Kp3bifoXauPvLoCmv4t46UCcwZizw1N7kr0awPf9mxXbDYgs9nbQ0AzOx6RqAySTndfF+IR8WpEVzx6IGA9hDz/6EQz1PdqeUogJm2xYBwWsY9OXeMJth/jOViI7wquN+MtEi4YWhBoG2JfoinQWPIcDBrUyjCTgc/1lF6zCTFpqTAfBc8VrKhcGNui/K1yvzE9hlWNx3ZORFZwpwNcybI6Y/kfLSOIxe391gFf2fidLhXrZRhLXCPXzXs//U6y+k93VoUB70PcGaJKuLuKnYXxCMWSqpOzD248GCH8pbxR2LrM1Rdu/bjMVXE0/b6iU05lvmmgQRC+INFo9djI11blanoTE0oHUrYAzhbeRGSpi/d/yyPsZPypBNlLUZu/Li5dSHqa0mFJH634xbEIjbpF8Vaa87ZOLpOIzQF61U2SWz6shmEPf60c8eebdcigoOS7HIqfkEOpRSLx9Z8m/5AO9lXuZrtuqI0ua84H6mVftJSuuMRiA1jHoGS+NnwhtPXN1YL6apB7ZW8bVw1Y1tcFbspXwIj7pp/9Wl+KxCxLdWoMH8C/GSmf7irM/2cZXQaDeT7OI/nhrfjgQlkg7Tizz1MtasNiiLSjfVeJvyk0WB4bSYSASlMmDxGf68d54+aIQnQzxeXVfZ/oSxClyMGPikJ+jTydXVLcxVFrQDWTUOmZhLldO2Phfnkl2ro66o+O/bEbyNwpAVhRiTGg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(7416002)(36860700001)(40480700001)(7636003)(82740400003)(426003)(36756003)(40460700003)(336012)(2616005)(82310400005)(186003)(26005)(478600001)(86362001)(356005)(316002)(7696005)(47076005)(54906003)(110136005)(83380400001)(70586007)(70206006)(8936002)(8676002)(41300700001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:44.2945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380c7cd0-6320-4a85-b7d2-08db04ebe718
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iommu_group_replace_domain() is introduced to support use cases where an
iommu_group can be attached to a new domain without getting detached from
the old one. This replacement feature will be useful, for cases such as:
1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
   table with a larger table (PASID=N)
2) Nesting mode, when switching the attaching device from an S2 domain
   to an S1 domain, or when switching between relevant S1 domains.
as it allows these cases to switch seamlessly without a DMA disruption.

So, call iommu_group_replace_domain() in the iommufd_device_do_attach().
And then decrease the refcount of the hwpt being replaced.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 26 +++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  2 ++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8118d5262800..c7701e449f3d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -9,6 +9,8 @@
 #include "io_pagetable.h"
 #include "iommufd_private.h"
 
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
+
 static bool allow_unsafe_interrupts;
 module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(
@@ -197,6 +199,7 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hw_pagetable *cur_hwpt = idev->hwpt;
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
@@ -234,7 +237,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	 * the group once for the first device that is in the group.
 	 */
 	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+		rc = iommu_group_replace_domain(idev->group, hwpt->domain);
 		if (rc)
 			goto out_iova;
 
@@ -246,6 +249,18 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		}
 	}
 
+	if (cur_hwpt) {
+		/* Replace the cur_hwpt */
+		mutex_lock(&cur_hwpt->devices_lock);
+		if (cur_hwpt->ioas != hwpt->ioas)
+			iopt_remove_reserved_iova(&cur_hwpt->ioas->iopt,
+						  idev->dev);
+		list_del(&cur_hwpt->hwpt_item);
+		list_del(&idev->devices_item);
+		refcount_dec(&cur_hwpt->obj.users);
+		refcount_dec(&idev->obj.users);
+		mutex_unlock(&cur_hwpt->devices_lock);
+	}
 	idev->hwpt = hwpt;
 	refcount_inc(&hwpt->obj.users);
 	list_add(&idev->devices_item, &hwpt->devices);
@@ -253,7 +268,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	return 0;
 
 out_detach:
-	iommu_detach_group(hwpt->domain, idev->group);
+	if (cur_hwpt)
+		iommu_group_replace_domain(idev->group, cur_hwpt->domain);
+	else
+		iommu_detach_group(hwpt->domain, idev->group);
 out_iova:
 	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 out_unlock:
@@ -343,6 +361,9 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
+		if (idev->hwpt == hwpt)
+			goto out_done;
+
 		rc = iommufd_device_do_attach(idev, hwpt);
 		if (rc)
 			goto out_put_pt_obj;
@@ -367,6 +388,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
+out_done:
 	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 593138bb37b8..200c783800ad 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -9,6 +9,8 @@
 #include <linux/refcount.h>
 #include <linux/uaccess.h>
 
+#include "../iommu-priv.h"
+
 struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
-- 
2.39.1

