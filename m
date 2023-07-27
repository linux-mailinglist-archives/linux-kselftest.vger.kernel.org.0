Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CE6765D42
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjG0UZT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjG0UZO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7C26BB;
        Thu, 27 Jul 2023 13:25:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhzIbkZsGZoIW/HokhIuJPfxwZbCDrGdQhbb1f8I+WSvNNdEhiVss5JIyfpD/7yM7nPC0oBfyHvKewbf6FF3bNpoGLTXsFXiA0G5ntU14O/B78s1d/K2M9uj5RBwh6knNfDCI94xa/ghZgopqkzsaVMU4QRtkI2msURZe9mMGSZ3qYLRrUvYbUyDCRi8T+XPnmI0EcDuVOcCyEAyVtn7KJg/zyAYW+KgB6L410XCH05ns52G3YJFitAomVwIRsv0kR/ttAOaE2pfItXwrUVD6kNX8qvE1fxUoZLzYz9qaW4tulDGaOwe7Hae3YNvD6P3rjkdxhVsQaCK/mPpBQzxRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=h/E3itdYFcD3vUqpGw84irZScQeZjOBEwa+l0JAaCtZsKfQrMtpBRrR6VMGhUkAPC7bKavGP9YoQK+EqSW1PO0wPxutenSOzo2GHUCJEEeBbIYuNwqHkz1TTpkukXoTJUQe6d1d3futMHBO/pOnQ+qNHZLaE6MsRzEiF/l+Xk7moyAEN03xwJ5/KVy1An2pu/JP8RJ2G0HEGRHcVs4yWDLTogwaemVm3cIMqq8UQe6HY3hb5L+xR3ys5m9rc1c5MqpfOuLwGNFF3908rULmb0XF1WgCnlkTXYFSFyVgMCeFnz4nQ5q11bbrwdWGpWIQHRajLRTCYeBanUFZ4UPnDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=YrCdY1Dz6Y45knIkuambopEJMgwHZ6ThTzEZxfMbBmht5pT5AnoeM/7Gv+w6M4yf73gbEUkl/s/OH/QVr4uCh6XbRHMhnKFFVSGKcHQWxmnklV4mMuspcWMuVqVTepSpIfqil26z2IttXaSf7GZUAxDT5E3i/v5AlbUwWh11tANJOOeoWD12AxzWLBWKG2vQknwN9yfhV+So3bKubVY4l3d9aO4S72YD4+LyLxQyf/Zg1T5Hcz1dHuXWVt3+CQd06UKonyf1okzGnbdmnk131QjApd9UDF1pi8Bxh+HsE+D+darW/cbdaGmPICCW67sFZj9eA52AUmBxwN68Wvya2w==
Received: from DM6PR02CA0057.namprd02.prod.outlook.com (2603:10b6:5:177::34)
 by BY5PR12MB4950.namprd12.prod.outlook.com (2603:10b6:a03:1d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 20:25:11 +0000
Received: from DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::e3) by DM6PR02CA0057.outlook.office365.com
 (2603:10b6:5:177::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 20:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT099.mail.protection.outlook.com (10.13.172.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 20:25:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 13:24:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 27 Jul
 2023 13:24:54 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 13:24:53 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v10 6/6] vfio: Support IO page table replacement
Date:   Thu, 27 Jul 2023 13:24:37 -0700
Message-ID: <12b9718d0225701b37aad75395187ef667464bc0.1690488745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690488745.git.nicolinc@nvidia.com>
References: <cover.1690488745.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT099:EE_|BY5PR12MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c6c4ce-7dc4-4122-afb9-08db8edf93ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCoW6MUelZAu67e2fzAxOHM5s5vHs/cIpQy8E3iNMlWvqRB+zHO8bZy3mK/6B//lU1GQg/f5ha0uuZhgDDriVqglT6lHARSCSWKAIoF/bS+YVGp0EprrGDCF/qTl18t51opcXglJ7gKHEOpz4dWU6u6gOSa8ubWjPPTWpfO1pkVUZmuDB3vrJrzumx1EjbKKpsPdyrfwg9IAfoAgCSnjz55J0wSJZHKwCMQa591In3rkzihyIwVOXwKtkRpidXNrZliYo4CZZuk93itopU+DPNMAsUWWhLh6F3qdTrLlgSxnK5uAfWad5SJj8NnxHTcKDLjUakc+ybG21hx3jQmQVmRIMv7J/x8OyroHeVbC5XOUc2nhTpbykYvGvRK6a5ffUi91MseCH9hoi+q9QudoJOZAJswU91Aq+uC7oXGPYHx5g1o4rEuhif4gco910HEeB+3VAo7Szwkz+ZKiiCEIGaPCV9BtgQn2z+El0JNheQ1JmQmo5MzbqoAljVOYn3yMRvBzCvGlQWp1bth+MYBNnx5S7AubLdi9uPRyZAwIdOpgj6xVxhyJrU8Lr3vh/A7MW5UPrI5Yy/b4FdglV1MMRYEBIjsS+gVWRC6qbaz7u7jRGzipkIh66qseCJFgfwXoalnHSZrn/7nDZqOm2T0p/nEURcmBwoBdSiP/HdIw4o3Wc8tgu1yJDqOhUgSlI5QSAh08hyAPkZEg3yimrf3qjoKS5Wbhl8PSezLNmP13QA0yUoDeIZA5EKFZotOSWUKd
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(47076005)(478600001)(110136005)(54906003)(86362001)(70586007)(4326008)(316002)(70206006)(356005)(7636003)(40480700001)(186003)(6666004)(82740400003)(8676002)(26005)(336012)(40460700003)(7696005)(8936002)(7416002)(2906002)(426003)(41300700001)(5660300002)(2616005)(36756003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 20:25:10.8135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6c4ce-7dc4-4122-afb9-08db8edf93ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4950
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now both the physical path and the emulated path should support an IO page
table replacement. Call iommufd_device_replace/iommufd_access_replace(),
when vdev->iommufd_attached is true.

Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 11 ++++++-----
 include/uapi/linux/vfio.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 4d84904fd927..82eba6966fa5 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -146,9 +146,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 		return -EINVAL;
 
 	if (vdev->iommufd_attached)
-		return -EBUSY;
-
-	rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
+		rc = iommufd_device_replace(vdev->iommufd_device, pt_id);
+	else
+		rc = iommufd_device_attach(vdev->iommufd_device, pt_id);
 	if (rc)
 		return rc;
 	vdev->iommufd_attached = true;
@@ -223,8 +223,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	if (vdev->iommufd_attached)
-		return -EBUSY;
-	rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
+		rc = iommufd_access_replace(vdev->iommufd_access, *pt_id);
+	else
+		rc = iommufd_access_attach(vdev->iommufd_access, *pt_id);
 	if (rc)
 		return rc;
 	vdev->iommufd_attached = true;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fa06e3eb4955..537157ff8670 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -939,6 +939,12 @@ struct vfio_device_bind_iommufd {
  * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
  * allowed on cdev fds.
  *
+ * If a vfio device is currently attached to a valid hw_pagetable, without doing
+ * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
+ * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
+ * as a hw_pagetable replacement, will replace the device's currently attached
+ * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ *
  * Return: 0 on success, -errno on failure.
  */
 struct vfio_device_attach_iommufd_pt {
-- 
2.41.0

