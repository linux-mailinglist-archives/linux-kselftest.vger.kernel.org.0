Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318607648B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjG0Hef (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 03:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjG0HeH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 03:34:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3935C9EF8;
        Thu, 27 Jul 2023 00:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgIVtyZXcf98QuEK0ZKlFYXT01MN2zhUA05yygOKlo/Ydx16x4AuEBioVeRSKgnoIxVkie6cVRwPwmWGVyMba1I9upF25q86lKqnfMov4RNizDmNWAlOQHBjPzd963K7T7EgJXeHVRKT240mKVH9NmPygGuFe7VuUgv9u8CH3ZMrTzlBsmFgeVYZI96p+lCf2Udnmbr+OXbH97r+aN4GBZAtrFi/mtKN9WNwVspFbCCWiftar8Fs3KeqVbbMNVn+BOw5rRHleQfVqyKyZjHD7g6n7jO/FYEeeB//mNyQn630bZshhyHF44kl6EDlBIL6KdeQRGnyXFNqFXJFjXLnfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrJpkLglUiQF8sYk/kmmxNYlDRc+efpv0dZ1dQ9DIz8=;
 b=IXgfP1gUcnV4rjCDH63oYek7n857lpbL7Wtq1l/2xyB6BkNOd4ZqFo3FPb9yQpemvkS2kUbokQ+ypEJ60/VvI4aUqknetT8lVDwaeaGR0Q4A8lAQ1Z8JrZl6QGuKLZQ1/olNB+doW3v102Y7EMrOFrA5nY6bUjX/xYkwI1HzZNe3MHyGgr+O07NYNpxy0XY8iRVX2n3WXHnzPQdEvczafDQlO5+MvefI2DefIonDbDvOq7oWJYQq0xZC6495whn2GFSwT61fHDjh3KpqGYVBK5NYZqJ4E5Tesucr/CQpPEyZ69LzdzMua13BbJbXJnFWlO1P4lH3L1y+SbqiPAesXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrJpkLglUiQF8sYk/kmmxNYlDRc+efpv0dZ1dQ9DIz8=;
 b=UVHIfmCRj2Lnp+uUEIikMAOY7YLCfFxS5Lm7PScgdYKPePuPX4p070atWyNFLFshNGzdjYdm8mlQ7cKrr5muxQpP/PEePmD6hMcowHFmKVSn44sABCyV4+2865uKv52BmNhuXnrGkKPJ/tVsyLWzI2V5IlA0+zLlOYkvZ5IzucDi8d5TpmhJRhhzXS2Uv84929jRP7E+7FbOIBnVaJQCeXOAfWqRdfkxC2WYjmcbJ5MlqIl5vxWLwooLnX0cd/JDFvKfZaaO9m3JuDrz9XFDxMEtHk5yn+g/wEFVVKhBfL3pBa6nXR7Ei9emK+hKoY9ukUsCp40FngYZ3J7/6LqWAg==
Received: from MW4PR03CA0040.namprd03.prod.outlook.com (2603:10b6:303:8e::15)
 by MN2PR12MB4407.namprd12.prod.outlook.com (2603:10b6:208:260::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 07:23:46 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::45) by MW4PR03CA0040.outlook.office365.com
 (2603:10b6:303:8e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 07:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 07:23:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 00:23:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 00:23:30 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 00:23:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v9 2/6] iommufd: Allow passing in iopt_access_list_id to iopt_remove_access()
Date:   Thu, 27 Jul 2023 00:23:07 -0700
Message-ID: <bb3c6845bc64209ae4dca5ee0dc87464fbc4961e.1690440730.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690440730.git.nicolinc@nvidia.com>
References: <cover.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|MN2PR12MB4407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5005ba-7018-451f-452e-08db8e726a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8BAnVbGWFaYsCpczfK9qHzXchn/ZZlpSP0MVGPNrmWH4QERIwpT9lXh906/CJ+ylO5o0WmaS0+KmLriW3feHzyheYnidtepg02y/a5ttMOIVVb8HpBDteAhhYPfRVzNVQeB4gVkLAfhHi8ZOs52pn6BPzfeGjk/DTiAzycx0h3hOdeEC7QuYtSZhOgduquRdjeLHOVvlnOdqSipXqpjzRJV4Pr+UXRd5tJWIKHEiVfRY5x+Y0gxVbh2KCiJ0yFQL4NjEhzFga5YAWP+/m2ECSDbSjGA/mfbxj7+s/iheRlkzuAAuOa82qJaF2Wte0MkuLfFRGXr4T7ov1/5sL+MC+H0g6Wn9hDGZfF8HHe4X3owg+4Az4vPXV9Yo/bQ+uhSpWsRqPCaQZD7lRXDvPA1Ol5qdxdmPQZUU2Gk0EGL5v4J36b5ESsGgL2VAEiFuywE+PXAeuTBtv6mdB1PYSruHbvPuvG8b24FjP1ZWfXFpAd0PdQ23Yh41QsOcz9xFPIntGBotWcZfHqeS5I1CYXQui7mCBMp4QYeqsnt4ye2AQg+V7bnzsDY5I/Go5a7ObWi40HGSM84T2ykv5L2+blqQ7aY6mzQtVR0NTy3nmXS1KbOBMEWBP4vtaz/LxcnTanlOFg60yfEsqsoEx000NUYVgAJ1hsKcOdczS2J75Dhh4C4Gucr3tnHmRqremfe/QvFK9gMTIdmLtWZZcmDBvzC6eNGtOumzly2hm5/egbkgX2b2RTkyzlayZwf0XNPLNC27
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(336012)(186003)(2906002)(86362001)(4326008)(82740400003)(8676002)(36756003)(7416002)(8936002)(54906003)(7696005)(110136005)(6666004)(478600001)(36860700001)(356005)(316002)(7636003)(41300700001)(5660300002)(47076005)(70586007)(70206006)(40460700003)(83380400001)(2616005)(426003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 07:23:45.8462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5005ba-7018-451f-452e-08db8e726a08
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a preparatory change for ioas replacement support for access.
The replacement routine does an iopt_add_access() at a new IOAS first
and then iopt_remove_access() at the old IOAS upon the success of the
first call. However, the first call overrides the iopt_access_list_id
in the access struct, resulting in that id un-erased in the xarray.

Add an iopt_access_list_id in iopt_remove_access, so the replacement
routine can save the id before it gets overwritten, and pass the id
in iopt_remove_access() for a proper cleanup.

The existing callers should just pass in access->iopt_access_list_id.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 6 ++++--
 drivers/iommu/iommufd/io_pagetable.c    | 6 +++---
 drivers/iommu/iommufd/iommufd_private.h | 3 ++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 57c0e81f5073..7a3e8660b902 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -690,7 +690,8 @@ void iommufd_access_destroy_object(struct iommufd_object *obj)
 		container_of(obj, struct iommufd_access, obj);
 
 	if (access->ioas) {
-		iopt_remove_access(&access->ioas->iopt, access);
+		iopt_remove_access(&access->ioas->iopt, access,
+				   access->iopt_access_list_id);
 		refcount_dec(&access->ioas->obj.users);
 		access->ioas = NULL;
 	}
@@ -776,7 +777,8 @@ void iommufd_access_detach(struct iommufd_access *access)
 		access->ops->unmap(access->data, 0, ULONG_MAX);
 		mutex_lock(&access->ioas_lock);
 	}
-	iopt_remove_access(&cur_ioas->iopt, access);
+	iopt_remove_access(&cur_ioas->iopt, access,
+			   access->iopt_access_list_id);
 	refcount_dec(&cur_ioas->obj.users);
 out:
 	access->ioas_unpin = NULL;
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 4d095115c2d0..3a598182b761 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1158,12 +1158,12 @@ int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access)
 }
 
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access)
+			struct iommufd_access *access,
+			u32 iopt_access_list_id)
 {
 	down_write(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
-	WARN_ON(xa_erase(&iopt->access_list, access->iopt_access_list_id) !=
-		access);
+	WARN_ON(xa_erase(&iopt->access_list, iopt_access_list_id) != access);
 	WARN_ON(iopt_calculate_iova_alignment(iopt));
 	up_write(&iopt->iova_rwsem);
 	up_write(&iopt->domains_rwsem);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index dba730129b8c..8ba786bc95ff 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -323,7 +323,8 @@ struct iommufd_access {
 
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
 void iopt_remove_access(struct io_pagetable *iopt,
-			struct iommufd_access *access);
+			struct iommufd_access *access,
+			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
 #ifdef CONFIG_IOMMUFD_TEST
-- 
2.41.0

