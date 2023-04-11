Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31916DE14D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjDKQoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDKQoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8A55BD;
        Tue, 11 Apr 2023 09:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPcrn9BI+JYsXBr3EEXjxSeB9bSuiIYHr4U3AxUr7jZAPJf+WGE9MUCdYro5buN5EPnpf6z8pNz5BfB0a6FYUzVuluZvN615yzI3R/S+cFBaqZWKSD4bbLefWW01c8ZkhJhkA6UNf0PJW2Xzi82RWjPxNw/qgUFqKE8vKLIuB5JNcGbsfkW+18q98rMupFukTU9DJa2tlrl415wc1Xc08H8zh1kbmXoYBKsj2MDhx0BLogll/AWzjlF4gZnnNt7bSH6DaEVupy6DoO52NrBzAys6ZXNtsGm94+Ctyn3eeWIsGeZ3HYqZFxt9dZKD2jN0oyog9OjZ7qvuI7LZEPPhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvrnnwDom4Oqm2knrQDf9JuYE1zB1fnRpGK8g7w9uMs=;
 b=fPhINz1dX4e6XV5eLhKob8lB72AWZFcZgXnX9uEx44T8iAc+uWNu4Ts35xPSKD4fEF8wePef18P4+E14MGwFieQPvssXFXKR1Zc1T1ut1pngiFve/yTnelIS8ro4EnKt0Kx+aOTvCO0OnvRvS2C8rf+uN6bZ1tpR/AZbfluZ+rvx6rKdysjmBtCyJoysj3k/hdzfYqhayqlA+7kmRxkY3DDkKiF/vBns3L0vuBau5z0DlBKnz6WCb5y1HzgX4jVEMTaY9lZL4Dwr5L4Qzq5kUvgDK+CWJFTrwV5bpXkzAH8iEq+hS2oRtspXHN2a7U2YlEqIjHKsbnRu8W2DhJd1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvrnnwDom4Oqm2knrQDf9JuYE1zB1fnRpGK8g7w9uMs=;
 b=bdU0ED+BSuxHsNsTfp5HqZf99HwNwIhOC3yN4nHIl//zTHgHGVVoGAmtBd4NLWD3EfjT+X5Bt4AJyYBIOyGP4MI6HpHCy7FzSxo+RFOO5JvR3c3k9YmbYQBhybPVeV5gI3LKjLVxLCVE2m9BWymdvg+wI4McuL6Y7xva7juRCNw9RnoekPsqhbaKXhd2AxhCnem4GY0HxBVxEqRnCrAjQsBB3jkm5TVhhsdK+VXqOMETS+7O3SncTE9o3DT6ffpqjTwMYXSDcbHYATAeWHrbRy28fqevd4MFFjOefVTsL41tRJuBNKWwoQpWDDblQEdtmrILqSnjnw0yAmKgd3Maqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:25 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 15/17] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Tue, 11 Apr 2023 13:43:16 -0300
Message-Id: <15-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f68ee23-ff1c-415a-4263-08db3aabde44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1CZ1PNt/WRYzvloUHzp0xuyOXwoUqWCHjOPUTiG63IXH6D5Gpa1rvBzzF3uXmhy8KyUKVAOpWjoFtkPzmfWTWima65VdJjlgJ9Dfm8IgihimOglaj48wzEPEIYea/lfVbd+OXfSUrNki2hNC7hTQI4+5c+3olhNBaJWvbuY/0tJAwP7dm42svY9pyQR3lSsQrQvNW9qrelMEr+4luhu0S82R7Ey55nRo8Izi/qmubTyxSdT0n99NwezUSnQQRJYmqfZbs463k6PqhQBfZiZJLeqx5KM2NkiYV1NAjeDY4cUzHtjofsh7/DxNDCKO2gAVgjy+3flO534fSYcixo9jWVePwKuIWnZhw9chbYDqWYbZvWTcn8v/zQF9V72ECTO/ekz8tJLm9C7Ye85+uQstRgi672lGA2KcqNoWnDzkfuUqGwNNDhGvqpuY/SlwduDSz61NbsddlHJSouP2G9Ykskv1WXye6R0/mStoMxF027fYBXfkNVXc+9kVHuZ+OtCYCOlWPM8pKeYJOEiP+wqsyjmTHLQBwCk+VBeiAlVTiYJ+fQ7NydjiON9ycGV6MqD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qabLqYJM+Rtf9dYgNHk2a6Ajc0HwJy9vCxF04hPr+AmcH3RwffHKIK+2sSFJ?=
 =?us-ascii?Q?GdSSP/Sd9jsvrJ7EVPNZC5HJrsoBAsMvqKU3C1wgOyAcsIzI7zevqeVvf+mI?=
 =?us-ascii?Q?Kt1uIEgLEeI+TROESSVRIy5eBQEXfad1j9XiET72CqdnH5EdGwhcykkwguMg?=
 =?us-ascii?Q?Fo131iewUtEpuEu0nByBOuHPmJuAtq6Rkb9On+mMPU4IocDp7LaxWPTZGIne?=
 =?us-ascii?Q?xdhMqMFx0j7bZasbwoLH048+1AbsGPQfH1ZxDjZ4Dom4HjP0hqSjDueXHYZC?=
 =?us-ascii?Q?baGBNxPiCuav4OFLV8AmcZ/W9thhydR6+tRTp/NOXHztKd+xePKsXMwxTu7B?=
 =?us-ascii?Q?B4uut+kPe1/CYuonOme0bEjTloRy2r01nLSCT9ofXu42Uvr/S5YLAoQl8NWP?=
 =?us-ascii?Q?B1IbFFYEW3IuMkGy3XzYO5Ra7RkSCV1nzfDscKGmyt95+LDOQkraMVsfI4So?=
 =?us-ascii?Q?EQjkhYpUUKaSnheR+FWRBVBxlhp3c71Bd5YrJRvNmG0lgyC2s1WHaZJFhGGC?=
 =?us-ascii?Q?AFl3TvT+RKGwq4jJZjauj1rt2mMoXnasIqSpN4/ZoB4j8E4wiRSZjCOx0iWH?=
 =?us-ascii?Q?TNvrJ7OhTLB07xBD3Nec0BYse94iLr9g+65qPWj5NUyTzyvJMTPrGNWTkBQC?=
 =?us-ascii?Q?qAYuM+0LOjlnl3R1HbPQmO5txy5b0BWSci5PzDl475O8LA6PkCzxp6m16Uh5?=
 =?us-ascii?Q?guV0omiIWY+fwLTvRCuzohpAOeCbZPuV0LG9wflef6fMKwOiBi9d+1T/ekzp?=
 =?us-ascii?Q?wjiIK1oLk0sbnUlQO/7JYzH3gmfqQwVozHNq3Mbh1e836TlVd9VUOrRfjKy6?=
 =?us-ascii?Q?APy1rkulk0K9/rRhU9e+FYG7yREi+OSFSSRxcIqphsEiypFaLuKhf31G4Jcy?=
 =?us-ascii?Q?FI4Lhjt+JeuUTAUY/0eusDrOKY9f4og5H2KIhaGgVFo+XezxiwuGI30hBVd0?=
 =?us-ascii?Q?0Oh1fhg/l+UbMakp3K80XgRzIwC0zjse1asjWpF0/ykjZErLSKDFzAxzy/UB?=
 =?us-ascii?Q?Knpqn9T3X7ua1jiVRyqVfgqfAPoQm7MSw2WVupLIsw46/oERQwBvA8VLrFQm?=
 =?us-ascii?Q?0l3BVrcbFqr9qg6duzFzgsApKEdvPRSVXd3LGBkji7dN3puHN00ySW5HTZ0a?=
 =?us-ascii?Q?10aUcidZQlWT1ZZlKWn5el6GHfismJY6sOdqrFL2u4MKe0Jhchq998ckyBIu?=
 =?us-ascii?Q?1++mB5O9gm1qM85SmssuVzp570NlHOj8uiH+q9MDHGYklU4OYjVnBMapcc17?=
 =?us-ascii?Q?WXpFFfwMCWIOtaydaj6+OPmT2aWT4hq5DtJDe2cKJ2412Sf9YiueZW0aruNn?=
 =?us-ascii?Q?rbNuDIvjlZnQdI3jxeKs4pGkVkcwj26yO24FW8AvQQPdZCpCrOcFW32arkvP?=
 =?us-ascii?Q?T2ZzkCipCFR/Xe0VUQJ8aIx0/l2/GE7vwelQhtqS9iHNqySS61bibW5v2BNS?=
 =?us-ascii?Q?zGSjE8QxU74iDfbHuCHPCEw5V72Er95YBC//dp1lfT5IZfa40Ykb5PM+B7Py?=
 =?us-ascii?Q?PXCqs0BtlbCYpqy/Lk1+YvxouJ2hHV1M8EzK8fV6afhq5iaCJ0Xgc8i05t8w?=
 =?us-ascii?Q?aW25hw7P+vMGhkGJOd8q6sjG1mNBOU4z6QePN1FQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f68ee23-ff1c-415a-4263-08db3aabde44
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:24.7487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO4N6DwjScEPAP70NLRhvhsiMazpTCbtLRGf2CIDyGQk8KdStXKFUau05L+C/OZe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows userspace to manually create HWPTs on IOAS's and then use
those HWPTs as inputs to iommufd_device_attach/replace().

Following series will extend this to allow creating iommu_domains with
driver specific parameters.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2584f9038b29a2..30c4c44a99b7a9 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
 #include <linux/iommu.h>
+#include <uapi/linux/iommufd.h>
 
 #include "iommufd_private.h"
 
@@ -121,3 +122,48 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
 }
+
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_device *idev;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
+	if (IS_ERR(ioas)) {
+		rc = PTR_ERR(ioas);
+		goto out_put_idev;
+	}
+
+	mutex_lock(&ioas->mutex);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	mutex_unlock(&ioas->mutex);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(hwpt);
+		goto out_put_ioas;
+	}
+
+	cmd->out_hwpt_id = hwpt->obj.id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_hwpt;
+	iommufd_object_finalize(ucmd->ictx, &hwpt->obj);
+	goto out_put_ioas;
+
+out_hwpt:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
+out_put_ioas:
+	iommufd_put_object(&ioas->obj);
+out_put_idev:
+	iommufd_put_object(&idev->obj);
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f80b012e1bc200..cb693190bf51c5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -297,6 +298,14 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 };
 
+static inline struct iommufd_device *
+iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_DEVICE),
+			    struct iommufd_device, obj);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj);
 
 struct iommufd_access {
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 9cba592d0482e7..694da191e4b155 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -261,6 +261,7 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
 
 union ucmd_buffer {
 	struct iommu_destroy destroy;
+	struct iommu_hwpt_alloc hwpt;
 	struct iommu_ioas_alloc alloc;
 	struct iommu_ioas_allow_iovas allow_iovas;
 	struct iommu_ioas_copy ioas_copy;
@@ -292,6 +293,8 @@ struct iommufd_ioctl_op {
 	}
 static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
+	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
+		 __reserved),
 	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 98ebba80cfa1fc..8245c01adca673 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -45,6 +45,7 @@ enum {
 	IOMMUFD_CMD_IOAS_UNMAP,
 	IOMMUFD_CMD_OPTION,
 	IOMMUFD_CMD_VFIO_IOAS,
+	IOMMUFD_CMD_HWPT_ALLOC,
 };
 
 /**
@@ -344,4 +345,29 @@ struct iommu_vfio_ioas {
 	__u16 __reserved;
 };
 #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
+
+/**
+ * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
+ * @size: sizeof(struct iommu_hwpt_alloc)
+ * @flags: Must be 0
+ * @dev_id: The device to allocate this HWPT for
+ * @pt_id: The IOAS to connect this HWPT to
+ * @out_hwpt_id: The ID of the new HWPT
+ * @__reserved: Must be 0
+ *
+ * Explicitly allocate a hardware page table object. This is the same object
+ * type that is returned by iommufd_device_attach() and represents the
+ * underlying iommu driver's iommu_domain kernel object.
+ *
+ * A HWPT will be created with the IOVA mappings from the given IOAS.
+ */
+struct iommu_hwpt_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 dev_id;
+	__u32 pt_id;
+	__u32 out_hwpt_id;
+	__u32 __reserved;
+};
+#define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 #endif
-- 
2.40.0

