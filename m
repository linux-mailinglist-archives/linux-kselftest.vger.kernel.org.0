Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597168E2D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBGVUv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBGVUi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A2B3BDB2;
        Tue,  7 Feb 2023 13:20:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdXDUpW7XqJ2wEQOuvyX7PmYmAbWJUIGRajeeKLBSTqVULMdwjpyVHjZX/naqI2Krd6zxZxdTiZXIqsxLPpMmSQyU8gcimaBRpxX7eb2LaFmAcNJHEdqdR3aApWaM47gGVmqx8aPJFhm7Al9FozyFbGhEV/fmm0P2MTWiDg+LS1m76GMHwSuzKACuiR7ExyeVnxh5xGBn24Bemac7EL1U1YIk3LaMR0ZdcklBYvXcmsk6ie2Ak6+4Xc2SJ0u2eMFCBLCXMIRM0Uaboh4dPPVxUxj6HiJDDTW6nG3gFjvRQq/3a/MMMGsMa+cTb7n8zedpIugdmyfXo1287IiuRypRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0/lfuYt+MI4r7ejkxRRk7H1BD5w+BT9RL83evvsWvQ=;
 b=h1mwWEU0rvMvWQKqJF4yT6Unfj8VZz86Isp3ra2dMfY6dlvbgQKREj329qEBI5oocny+ijLTKvG48UnrNMXF71/4o0InwT4hdgZUgoMuPLhqk+cQdGmkRVksEgx5VLOBAYrJ0wEMz42p32a9G62HCjLgSLy4vypmQN6khhbirRjE2UhHMXqs1UG5feSrIvUcejWZKv8HjSVqAipeOMs9aRQebh+fQomUPtkjJHFURtOUsbFXvlvWJs77qVY/uk1GqQkBLL5dG+QI1wKWmrsapwCZWryKBPBwMCPRDvznKTzdFl294NAofYaI0uepIEA67NloQ/LbP7McSqGEC8S9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0/lfuYt+MI4r7ejkxRRk7H1BD5w+BT9RL83evvsWvQ=;
 b=nq9CjMt4mNXU7CrPEqqntICxgSTTHe8fHTG5Rm5JpTm4IJxu3k6IVEPc1qUzC5CR7fm03U0GLHW0qKwT+hYyWntYXU9xFhCcctAcMUodNMAJs+QO2hulCXD5VaqQVLH3qSVJssB/d+acmHO8GAQabQmvfeljMlTTj9XQDt0GR2eOmxxonobULi5JCj7iTAEnWrbRYt+YP+dJMDUnhgMCxBH+IzCt3mq5nN5T3ysApF4iLCD/2qNb6YDvOGBhURsepOsybo/C/T0H+/zKD++IAqQIr2dh1JQtsA8kxylPWPgCK0D8OZhzkmQk8+oT9rwfh8qIXPi17BE+IbP5eImmIg==
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:20:35 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::4f) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 21:20:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:27 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:26 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Date:   Tue, 7 Feb 2023 13:18:00 -0800
Message-ID: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675802050.git.nicolinc@nvidia.com>
References: <cover.1675802050.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b725c9-c710-49fb-9333-08db095126f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSTboGDsKodEu/bJgDkZ9nSRhHVCX5XkPHfKcDAZDt/QeITym+v8d+mMXCD6jUy17IG7ibEUsE9jrWKurr0siK7KHyGvUDaaU5dbFSUqrecHfMBQbTI9RUx/nxVUkBGPJlQdLnVmV9P+mALpllarGYy0C5C33BrsBUhVxwMUHRv7cq945/jUO194/Gx8rvW/mZmCbJwkRSrLJodHfKhAh8ydkzq4tg4V3TCsdhOvAJ2NX/kXz0dtyL0a308S4ShbJQnTJEJKemIdeBqKqEcF5iupY0BXDr0NA4yB6bqiOPmwLeVXMZwmCiZoyW855V55SQX5HyNj9dI19KWkm/+X7Z/js5UCJoGx4Sd6ciefDGE1xFsXq65bFLlgBwAcSz+pHECT0E1tSuYOjNv8+XzRe5qzP3hzwLp72YydZJJPI2qjDRCYClKsw/2upe4D04Ja84wUiHq2Ee42GFFWnaN/14mDWkeewWzslGd6P2oEU/a3kv4sKxdtXHRYDBLLz+NAb4pOYTamwWcIxfHJj7hyIFfgTjlmlFgfFEXnwNr6sfZPRHP8QTddXCL4/W7u7fbjCayng+bU3+vAgNR/C5L9uwZcCxTGNNP534rLUxN367alaul51CurkqQi+tVvqyyxdpQXL1sRN/IjxqTRueXDbxL8J1u2WmGHCBCGRIKJpSLznSbnt5nbAzgMgGCzrr2f5tDnFA1IagNbta/UhUzEMw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(4326008)(82740400003)(7636003)(316002)(356005)(41300700001)(8936002)(8676002)(70206006)(70586007)(36860700001)(5660300002)(7416002)(6666004)(2616005)(26005)(2906002)(478600001)(186003)(82310400005)(86362001)(110136005)(83380400001)(54906003)(47076005)(336012)(426003)(40480700001)(36756003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:35.1171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b725c9-c710-49fb-9333-08db095126f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
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
And add a __iommmufd_device_detach helper to allow the replace routine to
do a partial detach on the current hwpt that's being replaced. Though the
updated locking logic is overcomplicated, it will be eased, once those
iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
allocation/destroy() functions in the coming nesting series, as that'll
depend on a new ->domain_alloc_user op in the iommu core.

Also, block replace operations that are from/to auto_domains, i.e. only
user-allocated hw_pagetables can be replaced or replaced with.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 101 +++++++++++++++++-------
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 2 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b8c3e3baccb5..8a9834fc129a 100644
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
@@ -194,9 +196,61 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
+/**
+ * __iommmufd_device_detach - Detach a device from idev->hwpt to new_hwpt
+ * @idev: device to detach
+ * @new_hwpt: new hw_pagetable to attach (pass in NULL for a simple detach)
+ * @detach_group: flag to call iommu_detach_group
+ *
+ * This is a cleanup helper shared by the replace and detach routines. Comparing
+ * to a detach routine, a replace routine only needs a partial detach procedure:
+ * it does not need the iommu_detach_group(); it will attach the device to a new
+ * hw_pagetable after a partial detach from the currently attached hw_pagetable,
+ * so certain steps can be skipped if two hw_pagetables have the same IOAS.
+ */
+static void __iommmufd_device_detach(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *new_hwpt,
+				     bool detach_group)
+{
+	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
+	struct iommufd_ioas *new_ioas = NULL;
+
+	if (new_hwpt)
+		new_ioas = new_hwpt->ioas;
+
+	mutex_lock(&hwpt->devices_lock);
+	list_del(&idev->devices_item);
+	if (hwpt->ioas != new_ioas)
+		mutex_lock(&hwpt->ioas->mutex);
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
+		if (list_empty(&hwpt->devices)) {
+			iopt_table_remove_domain(&hwpt->ioas->iopt,
+						 hwpt->domain);
+			list_del(&hwpt->hwpt_item);
+		}
+		if (detach_group)
+			iommu_detach_group(hwpt->domain, idev->group);
+	}
+	if (hwpt->ioas != new_ioas) {
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+		mutex_unlock(&hwpt->ioas->mutex);
+	}
+	mutex_unlock(&hwpt->devices_lock);
+
+	if (hwpt->auto_domain)
+		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
+	else
+		refcount_dec(&hwpt->obj.users);
+
+	idev->hwpt = NULL;
+
+	refcount_dec(&idev->obj.users);
+}
+
 static int iommufd_device_do_attach(struct iommufd_device *idev,
 				    struct iommufd_hw_pagetable *hwpt)
 {
+	struct iommufd_hw_pagetable *cur_hwpt = idev->hwpt;
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
@@ -236,7 +290,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	 * the group once for the first device that is in the group.
 	 */
 	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		rc = iommu_attach_group(hwpt->domain, idev->group);
+		rc = iommu_group_replace_domain(idev->group, hwpt->domain);
 		if (rc)
 			goto out_iova;
 
@@ -249,6 +303,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 		}
 	}
 
+	/* Replace the cur_hwpt without iommu_detach_group() */
+	if (cur_hwpt)
+		__iommmufd_device_detach(idev, hwpt, false);
+
 	idev->hwpt = hwpt;
 	refcount_inc(&hwpt->obj.users);
 	list_add(&idev->devices_item, &hwpt->devices);
@@ -256,7 +314,10 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
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
@@ -345,6 +406,13 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_hw_pagetable *hwpt =
 			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 
+		if (idev->hwpt == hwpt)
+			goto out_done;
+		if (idev->hwpt && idev->hwpt->auto_domain) {
+			rc = -EBUSY;
+			goto out_put_pt_obj;
+		}
+
 		mutex_lock(&hwpt->ioas->mutex);
 		rc = iommufd_device_do_attach(idev, hwpt);
 		mutex_unlock(&hwpt->ioas->mutex);
@@ -356,6 +424,8 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 		struct iommufd_ioas *ioas =
 			container_of(pt_obj, struct iommufd_ioas, obj);
 
+		if (idev->hwpt)
+			return -EBUSY;
 		rc = iommufd_device_auto_get_domain(idev, ioas);
 		if (rc)
 			goto out_put_pt_obj;
@@ -367,6 +437,7 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 	}
 
 	refcount_inc(&idev->obj.users);
+out_done:
 	*pt_id = idev->hwpt->obj.id;
 	rc = 0;
 
@@ -385,31 +456,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
  */
 void iommufd_device_detach(struct iommufd_device *idev)
 {
-	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
-
-	mutex_lock(&hwpt->ioas->mutex);
-	mutex_lock(&hwpt->devices_lock);
-	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
-		if (list_empty(&hwpt->devices)) {
-			iopt_table_remove_domain(&hwpt->ioas->iopt,
-						 hwpt->domain);
-			list_del(&hwpt->hwpt_item);
-		}
-		iommu_detach_group(hwpt->domain, idev->group);
-	}
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
-	mutex_unlock(&hwpt->devices_lock);
-	mutex_unlock(&hwpt->ioas->mutex);
-
-	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
-	else
-		refcount_dec(&hwpt->obj.users);
-
-	idev->hwpt = NULL;
-
-	refcount_dec(&idev->obj.users);
+	__iommmufd_device_detach(idev, NULL, true);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
 
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

