Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A666CACB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjC0SF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjC0SFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:05:39 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887B3A90;
        Mon, 27 Mar 2023 11:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClmIj8Y7i1MasEzu0Zf56GXQPPic8+WWoVqDTggMF0I/iUf0uPoPmq32J0c9avtaofuHKekFrk6CpNaDbaFPOQm0Q92v4+Iexiyb9gl0Xbe/I+jKQ5zI8piAQz8ucO29L5FkDyPzn+09EslDQaUYcKx3XuSgiB7gdEGDvVruL2eji3d6hFp3KGDmH7agIoLxG7ATG4rwvZrZ0CdGslwij6cLDNMUb7bx3tFWLTv2Q2FLvRWT4fnNC1sYGotgPE0wUrrHEpl0+baMhGe2B7d2oSGcKTXSHIAsQuRgLqZsITyILirp1stNEMpsCtAwjP72o8gQDlUTiecU/8F6NjcwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N26e0KwqjdFmKEVlqzoOUIgCYtGoSWRGIBJKDYKI73k=;
 b=H3RVym2mP98Stbp/TvLOughxBpf0ltZMI1lpegSvkJUpoWnaqjPzluFfIe8hK4aBwLY8kCOY0Ufhq3iLpWJKbVNuMT7URmEII6Z1E9dZJdpQy2DXEJOe8kCiXbY+lms/AsGyTGsUHtAhBX8T23VjWcNkpsnto/cUcnPzS7pmna+BarRCkmlOgxpt+6Ad4QssO4GJlvKmG8Ly/jvGhI8j0Qg/qYZrUdDdcOvW5r4yRq3zKwHlB2jy2dk8exG/KIF6iqqztqreWAv+sFsSrG0GvJiN7QIHqYTX63xawgTyFUWnYSKoE6cOIauGqdZHLuLKKzsuk0mP6KkJl/nvgq3ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N26e0KwqjdFmKEVlqzoOUIgCYtGoSWRGIBJKDYKI73k=;
 b=lM3RE6YG7izXWMswAZYT26k5t4A+3l8ScHMKsZZiODlgkaRnfRuQ7RDOkgYvaIFT/ItNVb8cu2a8J+u7yGza3nQ9eW0DSu4lJweCtSRHVjtQZ6YbFSkML6Qgy1dtx6pVJR5e/dvalnfT66ToZGNCatPeOQwxsJQgKCrZFOXt7nBZRHv4CtTrRU+6W74iTKobrze6kWgNsZHL2kKVK1xynHsd8OgbTF3X2GaPTyBPEyTAdbpeEo3xjdK5N0oH79c/Z1joUT0n3D5gEM3P3P6YfZNlN5Ncy50saTOQVIJGKBQUkM6+N1xfsf/XcByeq7ZCDvPhJFWLtGXYqNgTIAmd0g==
Received: from DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 18:05:30 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::52) by DM6PR02CA0121.outlook.office365.com
 (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 18:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.9 via Frontend Transport; Mon, 27 Mar 2023 18:05:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 11:05:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 27 Mar 2023 11:05:16 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 27 Mar 2023 11:05:16 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v6 4/4] vfio: Support IO page table replacement
Date:   Mon, 27 Mar 2023 11:05:05 -0700
Message-ID: <b39f25a39e7a950b567ac337c600c2db564c4a22.1679939952.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1679939952.git.nicolinc@nvidia.com>
References: <cover.1679939952.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e8628b-7769-4509-6c0d-08db2eedd9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqlVwcrf8yBk2XVgXLIQIPeWZtFQoSsqb1Uermq1FECQarP6QOHpOeVY4D6NOUtQ8wr4e8fq96F6YnlFOyjfcxP5/NQLlnhvPelnSVHRJFNVzwjdJHSY7866XHzVK8SaO0OQpei/OmB3L4Heq1/wValXyJLKWmlyo0xGBDGsRCjriOMAWZIJSdAq1/m16mNptY71iiPEH71k057PjnC010jE66pfGT1Gp2YyvJKeDqnX/ETpawqize+CqflpD+L7kbLMuPSwMrmlO7MtB6+kHwglZjYUPlvO6nP5MCd2nhfLA/Vto1pqKZpcFe/ptL+RqO6FNC4rCrzcMsW/TzprMBDYUTGB667x81ZEp9AkvRnWJwgNw8xOdB1NbiDqOaDD+qhczEbGE3uq+0N+BeuqZjAHh/+aKruubEMYtart/R8P0LhrrzaIY2WHQ3JYrXMEcOn0Acz8ytMB8GbXIqM8bKXpL/sX0+WXMKxj2iwIt/IIK8rBgwybeIPPRQDqmPXflgBE3YBwXIdTCFr6u6O6/3yYisU6CG9VyxUKOvDunhGLSFDfJG7Ny1RHBopjWMNKUAcqu32sXd0MvkphyrX0gDSiYZvKUs+/W0MEKxXEHpIGWuh1VU4oTQykWWIEtI1ui6XN4iwtiXh7hEBQ+uEGbo6l3yOvsk+mLUJFOb3sGFzLp+Cmx3Ua7HiWSwkZt40LPc4A1aXCmzBepmwRt9Ry3eEn2355aavPey1zXAtY+fTuDcE6m92XNDWmEvQm1I+gWEsETKJmN306/co4R3SEJ+c7O/qozopyLYc2IW5kg2A=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(40470700004)(36840700001)(46966006)(26005)(40460700003)(8676002)(70206006)(110136005)(316002)(4326008)(70586007)(34020700004)(36860700001)(8936002)(7416002)(82740400003)(5660300002)(54906003)(186003)(7636003)(41300700001)(47076005)(7696005)(2616005)(426003)(336012)(83380400001)(6666004)(478600001)(40480700001)(86362001)(356005)(2906002)(82310400005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:05:29.9837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e8628b-7769-4509-6c0d-08db2eedd9ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/vfio/iommufd.c    | 11 ++++++-----
 include/uapi/linux/vfio.h |  6 ++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index df4d6e0739b5..2d97424be582 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -121,9 +121,9 @@ int vfio_iommufd_physical_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
@@ -198,8 +198,9 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
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
index bf6c97e759c7..e067cc5ab0e5 100644
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

