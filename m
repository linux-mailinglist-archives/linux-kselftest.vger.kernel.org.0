Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAE6A2594
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjBYA2T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBYA2R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:17 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35828199E9;
        Fri, 24 Feb 2023 16:28:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/JuupbgTLOv2Pp4laCwDBNATPGNvC6Zu86FGr7fg0P49qf9bZYfR28gU/KrY+AOECsd13z641gn5smsp4fqoAP6CHBTsEJhLpIWa+iT2hQo5rYfr3nRM/hFgJf0i+9y3udpr2TgApU4ANTlUWBVoqOPAhAgHTejZJAQWFr4eHqUvIWFsGFn5a1w5sIxhQgTsasPVPKZ4ETvQAQtFcg4fzJsTrlrxqnfe28wyJEkViEN58942v+CMFQ1Iw1ezh4cZdzh8mDx0/zZir+HxHnisGgbUNSHqlMvIGcpFmLiw/ioZ9cULEIAmrLGhgzPBlsUEDStpHg57usa7IDca/suCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ge2EP0pX5I1JE7JGXadDOSSuk5DSq7t2oayUgQEu8w=;
 b=hvuIsoqLzYGSVtodIxKp1Pyp34weDr45PAqgCu4j5VvV/0e160TFkTgO0p8IMeLwfhGiOT5kl4PWnQ2N15LFhNEOjEubNJmhO11F4ruIvNMUEPIIGlq/+8T+eH2OKKofTF8vG/bsjV7j8fLunIFW/Bgj0HSo8FLBL7g3WuIpnDy9ZDynVtPGb6Z0u2ZirxftuQ6G5bXs2eOAEp0pLFvpEh2PpjIkr/VTvn4XwDtQ1WOk1+JZMaanaRt6V8zENYpIGoXlfbDJ77R8fBzB5iGu3ZePkKq2fPN4AVLmWr29zD1eizfaO1nIch4UpTy3cUwcIblUB4U8VgZlOPNinxVKKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ge2EP0pX5I1JE7JGXadDOSSuk5DSq7t2oayUgQEu8w=;
 b=oXhsRKgbesrNi1cyc8ypfzH8qBzyrDiYU8P7L5brpe0wVfAYNPD0XKfUojyUE9e+SKARC0HWtprMCOhrw56XOSLfk6QAZYPX8eh2J19bG+VePe3IdE4qoIpdIZvlbQwkRPnZaKfwa289/kyzY8cWDGfrMqojpvaXL8JbIy57RL/ODWmTj3G90t18mmWW0UmZ4lSNjdTHjC/7xWcgJ2Cit9lfAxr9A4QAinknsqZaxHxkfvBGdfdL76miGmxxLgGkoqS1oOJzo4vsMKBcfWaTw82JJ2smmg6UnjzBGLqnn7u80RCo/KpCYQ2PoxDfRPrjSeIvaGDYH5Jua8ugo93gQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:08 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 07/14] iommufd: Add enforced_cache_coherency to iommufd_hw_pagetable_alloc()
Date:   Fri, 24 Feb 2023 20:27:52 -0400
Message-Id: <7-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:208:32e::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: ebff4dbd-5ce9-463d-66ad-08db16c72874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy7g3a3O+vsPF2lnkBmzUqRNMNtMwu5yw1WkoK6R5UWo0WpcZwud4U6XHpiWFBSfJ/ZL/kXVsk88pp5kWydwT/7ykKo25TvpuWZhrYQIOW6BiNDzRFRR4Ek0CjxF5ut0AieqlLgXiz3WXxpCD3p+YAVUzp3UUvsjGbfgyae5RkcKZiwRZM3BNtAIDMWvmWWs0IVQsPN1cKxTTBbBrJedeHytAOHcBcJ6doSp7cIFDSKLeCXYJBHlrexkfEkaSzY5g4nmhrEKbAnfyQMEdsKDbTaD+NZMoqXN9Izzw6dZX2etVa5uNAZ+ZFTameKMm5HNGo4gNHsD2HrtC/d3AQjI88UgmsSJGpmGt9bO3AcZloPR/tsGNQ4WY/C9kFdYRfrO2w330n3ZirF5Rz1FQ9Sil1MEsN9wBVJN9DPclbWlYKehpCDsNpFkWBZ+B+8D4+w36Svho932x2oBOR6k/HmaWNbAQXX2cR8e3ikXyuGWSbDTYReXF7ZBuemudlSSRgNWeT3BCooyMpS3Dolk/bb72V0Pszvdz05rjR8wnBoTvSeDF00KAGfiy5vLZGZvgHdtEp9OEfAfSTpY/ZDAIqv6PnTUd/lT5mhw6Wl6cDUumvBVR54tcExXNuDf+LEqYHgVlONeyeTYabVKANphKed0pSb+tHxUBBs4y/mQmL9BiCf+ctW77xVFUvca9uxpfVOI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(54906003)(86362001)(6486002)(6666004)(26005)(186003)(66946007)(2906002)(8676002)(41300700001)(66476007)(6506007)(478600001)(6512007)(5660300002)(66556008)(4326008)(8936002)(83380400001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fudsjkJyutkn7hWm1ptykExqDHLFAfsxbrD9Q0W/CuCDhfWz3CZATPGKmfUO?=
 =?us-ascii?Q?MC9ZXiYgabjTJqIafiuUz+DeEAlcZ96GIAOrkEELzEudxkTvQKcCAhKFTNUf?=
 =?us-ascii?Q?6UwbvEVqAt5/FnidYjFeJetBGdm0AXcE0W86dU8m3cwKRNIlnwDjvbgzDp8f?=
 =?us-ascii?Q?oyRlm0dDQNe6D0gR0kD5CdPtfjMxJ26a9Hh5ae58+ak5VcFi7Vp6VlIP/EEI?=
 =?us-ascii?Q?FtAC67f4TVkZtTSPX+/uOUZwnI7L/TDsdjU3R5AVGPuqZGDgiSsbpZ+paJrP?=
 =?us-ascii?Q?RtqvkMmPJ30UW2UncXjKNkIVaiUrBmcPjXZDxSG0bwn2bEg6yCoU0RXNNty4?=
 =?us-ascii?Q?bc1bA8RLcm2prUJ/YHRJVsDJPdmGvDfvdv0btsavjPwX84lSrB1tvw+kSxhS?=
 =?us-ascii?Q?dBkHhwQ8SUeyLjn4kC198hDRLPJk57j/+YJONh/rHgV+F13vl2mgLDKpVhQZ?=
 =?us-ascii?Q?OHtV5RRAcsqQ8CPFVEhAG8u9hEEtwnqikqfG/Y/gpCItDgT3cAmtwtZKI1Yc?=
 =?us-ascii?Q?MtjiDTjQ1QTl8eB6hM4A3Y88TUUkSK4YDzXzUfc2qbm4WgwuUnRKlRXB3Qyi?=
 =?us-ascii?Q?XPKuRSbk/UCNRADPugJXs2QLDZh3UCmvjcqYtKgkjz6PoxeUwr7ZIrpamE/e?=
 =?us-ascii?Q?SM3R4vdmHhI+f67yvKTDQDSXkNOfqKkxkuSDvPsR6nTNB4TQxY+anhhdH/tF?=
 =?us-ascii?Q?/9sAp2wIcY5TJo9nEJbNqEVRR/aK/2/BKxPA82qVf0wEB7S/e0uf4E87ZSq8?=
 =?us-ascii?Q?ql7qlbaQtE55ivnpg/RaFbD5ahxVhULMsNqnloSVh8Dvnd8eHpmJsKpqpEL9?=
 =?us-ascii?Q?/EuHhKjbnkInl82BbL2uPAzLCVgN0kZEY6VrX7TeguBgN/fpd2QcNtsuGDdn?=
 =?us-ascii?Q?qLj91G+PNjyxRR3jZ1K3n+G0+U8maOu7QneH7vHkZYw5QDp+XUVWymhd9YFN?=
 =?us-ascii?Q?DV0uJ8YGz4oWceKw7BWP6Ck1LBS135VY1a9I2yCr6dReeAHG3TdJ4gPjDcza?=
 =?us-ascii?Q?GxuSfa75n6A2mrKbMTRyXWo9ig5BwU0uybVMlOr9aWd8W0GpRZebqDMFn91T?=
 =?us-ascii?Q?xxT517IaELbuX8c1Kq43JACbN012n1kfJWzfrBIRnwTLSS1kf57O0IkexFLI?=
 =?us-ascii?Q?DDXDnTW6NBeZMavd9qok+onj6scJ9j55zOZHsFFXb4W8Ck7yzfTYGiR5Gdjy?=
 =?us-ascii?Q?vqg2gOb3ia7uNpn2jyafXa89X5RFcP7wAF/+ooIYrXLKYXMlfpV8DFtdY94b?=
 =?us-ascii?Q?1c++XtboPx/fjh0zp4R65g4gffU2GOUyn2Y0g1lb+t6T1SZ3dAeF3mZ/D0Wp?=
 =?us-ascii?Q?68TKBS8i8rPR5MFU2O+YXwbFsQFd6lwvVLV7N41LVuqQ2dM1cKBXAsgkS8Qv?=
 =?us-ascii?Q?gDwSQBZsDHhdG2b8P6fbMdeHm5y7tHddlz7kjv7NP3lqZNL30rgFEKvFE4Ks?=
 =?us-ascii?Q?dZ8Ztgl2kWV4qkRKcqjNRbCBarhPQYqjc6vODpqn856teBZOg+AjwSatXUjK?=
 =?us-ascii?Q?YO9pF8ALn+pNTA0r9d/jvi7Nbn8nr6e5QLGY7MTmTMv8A5Xnzz+GyU1CLtjG?=
 =?us-ascii?Q?twR12VQxmk3tSmONf1Qx2vyoZNYo9dyIShAoIgCm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebff4dbd-5ce9-463d-66ad-08db16c72874
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:03.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwTek3/kg66TVCtcNOsBhbkmlW+GE77TflyKjWm+XxDKVsCPB09XFOcikkFj2mm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Logically the HWPT should have the coherency set properly for the device
that it is being created for when it is created.

This was happening implicitly if the immediate_attach was set because
iommufd_hw_pagetable_attach() does it as the first thing.

Do it unconditionally so !immediate_attach works properly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 20 +++++-------------
 drivers/iommu/iommufd/hw_pagetable.c    | 27 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 590f84afa06503..7f95876d142d7f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -281,21 +281,11 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	if (idev->igroup->hwpt != NULL && idev->igroup->hwpt != hwpt)
 		return -EINVAL;
 
-	/*
-	 * Try to upgrade the domain we have, it is an iommu driver bug to
-	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-	 * enforce_cache_coherency when there are no devices attached to the
-	 * domain.
-	 */
-	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-		if (hwpt->domain->ops->enforce_cache_coherency)
-			hwpt->enforce_cache_coherency =
-				hwpt->domain->ops->enforce_cache_coherency(
-					hwpt->domain);
-		if (!hwpt->enforce_cache_coherency) {
-			WARN_ON(!idev->igroup->devices);
-			return -EINVAL;
-		}
+	/* Try to upgrade the domain we have */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (rc)
+			return rc;
 	}
 
 	/*
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 566eba0cd9b917..2584f9038b29a2 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -25,6 +25,20 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
 	refcount_dec(&hwpt->ioas->obj.users);
 }
 
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->enforce_cache_coherency)
+		return 0;
+
+	if (hwpt->domain->ops->enforce_cache_coherency)
+		hwpt->enforce_cache_coherency =
+			hwpt->domain->ops->enforce_cache_coherency(
+				hwpt->domain);
+	if (!hwpt->enforce_cache_coherency)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
@@ -60,6 +74,19 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		goto out_abort;
 	}
 
+	/*
+	 * Set the coherency mode before we do iopt_table_add_domain() as some
+	 * iommus have a per-PTE bit that controls it and need to decide before
+	 * doing any maps. It is an iommu driver bug to report
+	 * IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail enforce_cache_coherency on
+	 * a new domain.
+	 */
+	if (idev->enforce_cache_coherency) {
+		rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+		if (WARN_ON(rc))
+			goto out_abort;
+	}
+
 	mutex_lock(&idev->igroup->lock);
 
 	/*
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c0c80181d05ed1..8921761ff98980 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -254,6 +254,7 @@ struct iommufd_hw_pagetable {
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt);
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev);
 struct iommufd_hw_pagetable *
-- 
2.39.1

