Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651557648BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjG0Heq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjG0HeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:08 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88CA240;
        Thu, 27 Jul 2023 00:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7EhGGAJXZnkWNpuDsIbOm2xMBC2gp5hKcGNQUA2ym+xs/2JAK/TAY9HUuSyOt6JONec7+2TU7s/rMTY9toP+1TxUM1wf1nD9swQH2EW/mz2emVGKtUxcCISxI8kt40292JJecMZwsRjGOKGu/K90+or7bMjkfXNjQBrllQidsl7GIPxXmMi5wIB4wSs+2aNxN3vhr/1FhvMTZaAnlrHFR8GZMc/xNOQDnRMCRbxIjWPfW6mxNverDxgx6tSPch2qXxHWlBN0kFOeSZ1bsQKLg/Vi22JFuJT0CT/rwiJeZGdqm2DwFCImTDIDlettGezf88Ir0YUqxLEgV4SFEkLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=NiMhsSCXVHZgRx/kimOxK2bPdu4RxTSh0/cUA28gFlc83cKM4E9JzNfyUpt0XDdXMJj6UxLZn+NcDdzLr4HqnPskp4ZrtBxhDOyLmP5wB8w/cnOtpRxa8oE+wczAK+0QhR8T1e21tco/ct57jgFCWpyFH3bzbw3Wp7+SrUtk76vLejPgI2iP6acT0AGlpx25j+7bUWon1GoUkQH0jB0CIjmzWwcCBmMpeva9EeVpt86qEPokZUatFw52qKCvEM3IF74k4Bqus9u3e9NaC/nhpuA3/mkqNaWwgLB1fyxHPfh785ybS0u39ouAmt5aWw7x9paLdADUtX+wDBeALqP+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6aD3dt1PckeOKkxIclyv3iBH0qTiumx46+55bGQRk0=;
 b=b2FrvPN8/ZFAYdqdo49fkVXqEQqgh+BfzqHFHqvBOZVktbCtpKgFf8u8VecDN7SO9fwqXewEoaeRDewC2BvgLnMEUZEmqPLTItsl4qeYIwLqjEq3WiP5J//PE0gXeiWDQ3nqyZz0cDLbmGh7kE2cH3NtDb3SDra/nb3nOan+7TokyMUECkD6or/dgrxSfpWp5vvB110hpf8GifbwP+Fpqhwir0o9EY6X8c+lb3Cu7X4NOpsUjvQQdydKe/H6bqWvHx+uv2HcjehVaZ8gw0pVfP1p27CHTYyidqvm4ApKbmNoA3pKaSXQxiehhwCashYIeKwwpuKjDpaXEBIGjs3u6A==
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 07:23:50 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::d3) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:33 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:33 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 6/6] vfio: Support IO page table replacement
Date:   Thu, 27 Jul 2023 00:23:11 -0700
Message-ID: <864d21e57894ba6fc6248d9380f52d0b424485fb.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|PH7PR12MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: a799da40-f644-40a6-0313-08db8e726c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QJ25TrUL7cYHm43q0srIClLXWcETlKd9hGrbezB2xjhczj8nYaRJ+BGsvJBWgnaQxSlU9puLZ1aEHWIXJ3VUQ53JV3eGcy5oTql8aW5bVjJLBtFHB2ONlGmATHcp+pa3HHOKiBz4hu24l3gUZXHSyDPrl9hWUEov9HrCZh/pubBZmLsC48YeykIX5yKrqTXo10KHCfy4vLDKpGKIsJKvqCl7uf3EBCzzQBeVAeqX7j+P19pmD/Y1NU8NZv3+VUMB9LdJ7myg+YJ35O57jk8fSUWsZnR2iCZfMzLiCpmtFwEHCbb/cIaGzBKHnh9hT7Pl0KZLNm3u9NMgZ7eSnTKBctBWQFRHGs/NhLWt0KYp/Qc/Ae2KFltGf0+o60J4n+eBmcCXuKU+MVlLB6B7VGo/IaKSzsJ4pnreMqySoOtXDkAzD00+mZtM1+xXBD4xLJ6Z+qoB2LR92WF3c8ZEXlWUDAZGi3XXsy9Gu5ePoE23Q2YffRK6Xogygcw8StqeQ9HxWHb3vklCs5EMa7XmpHDvgobIcPe23HSS3qjPcdb17kwmmOAg1EHqOtEWnsdr5ONrF+QsKPGOKCS31yLoxYmT1v9nhVnD/1w5QJbZyh7Es+jPMhcLsJIRcuOA7UTzYf7exicrfEeEVTkHfwQfq0LiJuF3GcZTxkzCiZ6ZYNvqN1MFhAZWyPYrhJg6Zr7JS/KSnccJc2rkMZWtid0Myqo1LWu3rdvadmE5h3POooUt8yx7vZHd9NNwZb7WnIdmQLYB
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(7416002)(8936002)(8676002)(5660300002)(41300700001)(4326008)(316002)(2906002)(54906003)(70206006)(70586007)(26005)(6666004)(110136005)(336012)(186003)(40460700003)(478600001)(86362001)(40480700001)(36756003)(426003)(2616005)(47076005)(36860700001)(7696005)(83380400001)(356005)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:49.7898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a799da40-f644-40a6-0313-08db8e726c62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6538
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

