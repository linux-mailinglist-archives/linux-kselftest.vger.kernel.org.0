Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9E6C61D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCWIeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjCWIdx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351733A8D;
        Thu, 23 Mar 2023 01:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPwjOaLVv8BNnkkF0Azvi7WjGDoqyWGxZv3CCa68SRh1uWhl4Yd9hAestbfdMK9+Kd+of8DGEe3oUCPi1lf8toWzo9LxXfaNS8cSFu1Twu+iylTOdVxVwwgHN1XIp/ekwnQqtnfqcRnA7PQzCNUWxZsjkCB2hHPeTJgu6swS6mxFex2XV76Q74ELZb1QK1SSWLEwstPku619vfaf0YJaNzlxU/otc9gsq1DMSz1Y4cwMxWPUy3xix1PoVTdEB2IjZWkJ5VnRSdlYqQEjO/WUiG+ceeSbsbdXlMQreXw28R84mVBQS6Sju6z9TAz5qfZY1YLNRdZixsVKlp8LmjxMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZrI4Zh2ZNVvzhQaED0G2DfuNqC97VHB92s1qyb1cmE=;
 b=Kgn2+vaCLnHWtKfWDB7JWbOIKGcSjb6SDHbopE3xZjsLm4zND75BQeDtMkD6ZKUTAN9qU3BUHPEpLrDvgPji5JG3y4+4YeE86cqZpnABMhp7IxAZ2reqc5tuGYhvIwpsJbU42c985VGYkG52ff7oIPSZmU8tUBa1QZ6fc18N8AsB+DkhNkZmALEjnR+KBARtGDK/w2/N1jgA1XvqxXYFcmUnIHjl0KdRY8wLxvHOIKDzlUbnYxK7EuwtdFQ5clmyGEfaVoZnRETrWd4YJ5UUKf/lrPMmV1+xipZ6MKDNrEIsiSZ4dW0ILuVXeNXuH4LfVLLFs8yovLM79MTfw+PqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZrI4Zh2ZNVvzhQaED0G2DfuNqC97VHB92s1qyb1cmE=;
 b=ASHXemwr65/kXE9hWOjA3Sz6U+d+GdOdJmkNtwembnOnquZTpn4lXJUxoYieflqKnc0yi4XJlh/E6zLL51i2Rxt1wNye4DQIV5MS4o7NYuS6ma2NLDkJX9PXKlgBD6ed0KU+WHw1v/GH3BdlZM3GLZLNaQx5D40LnZ0NyBvwRvpimtsLS72QORy1bpOsjqFRJZvh9JwgtoWk1j/yfI+BbE/z0x7hxdMBxdZ/06aGrpR+d6Euai/3R9qpYs/8qO30Argo+Jf2v+9y/3UCL336RixxW8guNXYWLXN0BfTujjPnXmy+E7CINGhDXIVu01pzdHN85xzxJno22ajdE+YbVw==
Received: from BN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:ee::33)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:33:41 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::1d) by BN0PR04CA0028.outlook.office365.com
 (2603:10b6:408:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:33:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:33:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 01:33:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:33:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v5 4/4] vfio: Support IO page table replacement
Date:   Thu, 23 Mar 2023 01:33:05 -0700
Message-ID: <29023644817002345ab94d8916a8447debb45a95.1679559476.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679559476.git.nicolinc@nvidia.com>
References: <cover.1679559476.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa4bf11-7ea6-4dcb-799f-08db2b794ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkBx7RCN6HgYF0AdmMF3/tTF9ZS07KI75VNH8i1+OajQbBmH2YabTYrLZX4zh9EdRuZnOK/9t4bZF3ou7C5SYAR/ior03jldGQcjBwRMMdsUMnVLzIjfUv1IabUiDRd8Jr/RW6zOeGKvYNAZlMU8lB/3OEM1TxfvaFd1yvkI0uh6775c37OceOLoEeDD7FEtZ4CesWexrw/Pa37al5wlcdVpSB/pxHX6a/fKt3Och1ezwbWVJ66oxUYcBYZWpXNDlOb2fCkL+h6CGZcNWh97duqAT+mQ57DW6p0Yi++kuGJF+TTapjnwzRROnfWNXTmwzPviryw4DD2MtPqy+E0N0Y8+yMv9HuPyZOQ38sN3R/OCPPihtTaDrnFe/1Hgx7Nl/jzr02i3kRxBAYcvawrZsuuc1fu/HxHBbGj71dWIeXGAjCDJaJaNha4ArSNzHvH6ZOLuBsEKsG4fECTBgGYgujN/oHANArmelE64Jb8Gljiv5vQiwRsZlMqKBrvm8mjuLIrPdVqqATjDdKZUHfHl+gSjEQjotIgADO+57j1ipJ2im6HVpoT7+aKPS582hvGjOjzzwrMmyvhspQvA6e+TpIv2Q0m16xkgQFanZU3DSW44L1cVV6egO8ercnT3IA2B0iSwUT4jFstsXVhfYUZuut+M74quTcD8v6NZFeQfCtLbo9GAWKZxwngTz9RNXavv+z8I4vBorvU2hWnXtX4QOQ+sqd7iIJkxaL7YqqP+DAlG3E0FYxyTweDIYtxIGbme
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8676002)(7696005)(70586007)(86362001)(2906002)(5660300002)(70206006)(8936002)(36756003)(7416002)(36860700001)(82740400003)(7636003)(4326008)(356005)(478600001)(316002)(6666004)(110136005)(54906003)(40480700001)(336012)(83380400001)(26005)(41300700001)(40460700003)(2616005)(47076005)(82310400005)(426003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:33:41.6077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa4bf11-7ea6-4dcb-799f-08db2b794ee8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now both the physical path and the emulated path should support an IO page
table replacement. Call iommufd_device_replace/iommufd_access_replace(),
when vdev->iommufd_attached is true.

Also update the VFIO_DEVICE_ATTACH_IOMMUFD_PT kdoc in the uAPI header.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 11 ++++++-----
 include/uapi/linux/vfio.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index f3fa03495a41..861e10a6b198 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -113,9 +113,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
@@ -192,8 +192,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 	if (WARN_ON(!vdev->iommufd_access))
 		return -ENOENT;
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
index 53c72e26ecd3..3f2548a5e847 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -243,6 +243,12 @@ struct vfio_device_bind_iommufd {
  *
  * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.
  *
+ * If a vfio device is currently attached to a valid hw_pagetable, without doing
+ * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl
+ * passing in another hw_pagetable (hwpt) id is allowed. This action, also known
+ * as a hw_pagetable replacement, will replace the device's currently attached
+ * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
+ *
  * @argsz:	user filled size of this data.
  * @flags:	must be 0.
  * @pt_id:	Input the target id which can represent an ioas or a hwpt
-- 
2.40.0

