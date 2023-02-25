Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9146A2582
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjBYA2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjBYA2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:09 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B718B10;
        Fri, 24 Feb 2023 16:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIpowpHxyCisy6xJcFsEjnHeptRXTVlh3HZ7dPdb827SRaAOlE7bfvTKm4eln2fIqBZPX2lxGtbjLmGWVqlFEHFXkTQqOjp35d1Db72hgOhrneI5S8bNv3KQAM5C2b79P0Gb9K7yB66kVZNv5SZzmByuiNcv41EFunWDJcd6sXJhXoCasoJ0qLcd4lQLTNIlZLrb9iN57H6vQq1r/XjpDe3IBeDkJp2EpdgaFohDj+G6DfQR9XXm2eC7/KVKeAWK1bUmjr3rRha8rAhWzey54GwLiEyNvvN1jEBLeefZwIngwdALbA9XrbnFf0S1YHiLm8l70S52Ol2JYPvJ48j3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENaO+avjAO6EdUWzFxPaguNwx7WoZnk4YCjfrM60PIw=;
 b=bJ3l8gA3OyK1bec5ahmt/iJ/wH3wyR7quxp9jo+a4u//NHiRIhOXgex8FteR7UixsupesX8J3YHPlqP4xWkEFgJteJU5qv2nhVCUEMFX2kq4KKKpv/D47JXif1wJOYb7n9X9P5sUPtc79berjuogLD/VeLUK/RoZ+HN5jUVNBdOALcmpF37VpSRQc1iWkQD6yuPTINzg+mfuiisrQkNERTwc+d2t5kl2GRFTjwxq3MxdN1d3s2h41Y38mF+lfCcYVWXtBxPiTxV5lDRdYrouFOudTM296iK9X9T6ZGBahq89gWZfF3aDN9HkF2eVHV8bLuqrWTL+d8toPvxbUAoG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENaO+avjAO6EdUWzFxPaguNwx7WoZnk4YCjfrM60PIw=;
 b=TfajVytg9I8Z6vqbWr8BIsCAeeiZuvyusomrzNBpoq8SoqJxpL6K1LR4n9V56CToEJfsTL2lQTHSpFkmsiyWl1Y3VabgTjshq0+58IEMFa6V8gTTmGZamYowvBCrsKz5jQ6Uf0wKRyk6m1pYy/RKYrLfzmR0XKUwnEJvZ80mS5yus46qjwL7njzSEQZKF/Ad/GMKG5PMDSoLHMpp5om0xVx/HSTbMVitzMcyfN+No6qFA/XRCSrEq1091IcmBJBAu4/YZJ1m6K0/cH5vMnUKqKXHbUlsm4OjYHa8l93TNHj6Sw5SgV46VsO4OjyUs+EP+co8r5s5vl3UnKzilvfurA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:05 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Date:   Fri, 24 Feb 2023 20:27:57 -0400
Message-Id: <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a723dec-b4a2-4659-729f-08db16c72756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWuHvRHpRtd1wCpvn25ov7hpAXyd/vJBNhnirLQY4E/BzW1iYza7ch9n/CUe3WhEOd7tSnVNzWnRRuYkpu7Zm4g3T28NyHpVhBftX+ymU/1Q6IfA0vtIXZyXtHANT8ULiEXFjy1yYhd0k2j3+X43INzExM66ehLMRxcky+vaNq/Qdz7IwO/p0pA2HI1rDEoSyRxm/8gri0Y68/Ck2Z228l1UdiClSZ4NPu+7yFqs8vLvK/kV5WhxRwkycRnNeYwFB3dl4ZrhVNUcfqaf/eOKNAfYydQ8TCvRBPUGzYuIR7GopNbukmSbB57UtskXHlnDxXsxAWyewUvrB0jHkhNeHxIHlKfNsCEx5GZ/O9OL8Rgqme//r1fD/mT2ocNnac8FB6GDAB9CXwQL4uCOdQu/TlcRmAYdoIqczWKq4u/mT2JGJ9BFaa4MkF9cgZ8kvBxfajPtz1MeHNFj2brHO2lNbofSnh5yJTwykBlJJTWFngHwWW2qjHxdvG+HmPl8KDG6zgVcPU7lkqniQ4UNBFPNipaR14pd9i29+lx4pcHx+sRh/tTy5eBL1B+BRtpBILU4iiKr3lBV4eBoGMg/zayaS1QPu0FTW2CN/6bHC+IcZ8y94kT0gQ4XrHuVjxQ0DIsX0WGRPoSdXhPfChCO1CbVlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(54906003)(86362001)(6486002)(6666004)(26005)(186003)(66946007)(2906002)(8676002)(41300700001)(66476007)(6506007)(478600001)(6512007)(5660300002)(66556008)(4326008)(8936002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o0FDY+5TrJ0I9LUwtm9wbXP7f82HorKMv66F6za6dN9gf/WD0J+QnQO1PA4z?=
 =?us-ascii?Q?1PW5+xzmPH9TThMGFBkSMuVUw8jxuJLm3UpFM4Ft5/S0+I6XflFcljbIKHcI?=
 =?us-ascii?Q?RfV9EQpCwSQyTOuFR1DvpWeNXRNmk+dM8UNKuwkPs4Q4vsIEy76FrIGq2TGP?=
 =?us-ascii?Q?Je6jpuMH0VDWvF8MxZKuQQZlNfwktlmt+BOqpz+N7iKhz50MJhhgWs9MraVR?=
 =?us-ascii?Q?F4f8toQicUjlJ3Ak+bxxwsWd7Qv4PTylJzVCRPSpprqSXsoqMv35YMwNPk4/?=
 =?us-ascii?Q?MVDKXlyKAcq2L/GpUrw6NMsBXpojmJDM8FmLfPy6s4avWVM60nqq4NasGTqI?=
 =?us-ascii?Q?rifh2EgZAFfz+7u/T9rWM+YE2jl7T73d7Pg/gngK5VPkktWPcPhnXaMM4s63?=
 =?us-ascii?Q?fG14TAqB1rwSe2jUM5hORpsNV0LlWT7lAs8sT5uADcMoLWYns0T3AymFZhrI?=
 =?us-ascii?Q?apDY6NF2Giysy527Tr47kuC40jixRi24tGk3bpqXZuJJRoZpWfUM8F2JCF7A?=
 =?us-ascii?Q?AtX4Ygd5n/hY72IoH13/G0eUcFp46WUn5kNcExnb+r4+CuPswDHBmvDei7L1?=
 =?us-ascii?Q?z9lr2IzvAKggnLucVAbSueBMSSe4He+YaUP06kzbh6xFluFEgjX4S0rBQAHC?=
 =?us-ascii?Q?4n3c7USTVcKtVul9MGFXvMmz122qvxs8sMB2PskSdBO/jT0zUmMyVF6uTSGU?=
 =?us-ascii?Q?0oNvA+tNqFt7K0s4saWspxLnrQKg4lDcYCDt1zK0ee5j5tnIYOOlO6UDssJc?=
 =?us-ascii?Q?Fm2R+tureAThH78aYjy8llufzp1uSYi/SJeJNmy+j5wrtBaLp/zLVQISXmUj?=
 =?us-ascii?Q?57OgPWmGZew079CimcT2/pd1HD1piQ9cthIA2P2Wx7REWxN9qmC5N0cjNqRk?=
 =?us-ascii?Q?K0FCP3qwzmhLi5vJmeWf1cwsWdyBOk3bAQXB9Sjewz+Ziu3DGwjz0NdEQ3Pc?=
 =?us-ascii?Q?e2It/mxt3YRwKFZDp1K+lnh/O0hJBgGv3rESivlmnGSSeqfmIcS+28K+fIb8?=
 =?us-ascii?Q?BhrKrrhj40mIBG7ITZI0dpxRdybrZA+uKdPpzcFXDQFoDOrZe8pG+ss2SLic?=
 =?us-ascii?Q?HkFjLUvQZuJaOqYwOrX1H8fcuwpd23wi34dyXIYy9IKbW1qkiFDk1inW4lRZ?=
 =?us-ascii?Q?WMn4xjvm2nDVto18diXTGqYeLg5DFyKGxAFQbhctBDUKtwIbM6Ads1Oifak5?=
 =?us-ascii?Q?xkLVP4fxjyYmZphhj0JeMpkGeNVuN+Rz0CJarNc/3i7KTBWP2nNII9Dp9LcU?=
 =?us-ascii?Q?TrAGlMvHcPrze4aMMdrWVpi/sp8FAyyT24H4wPpIuLlsrwp8nDcEla4ePO7J?=
 =?us-ascii?Q?c74koxyJ6gcZ2eTo9BQRqXx4hoAp6EalmARa4DlWHlKFE66nBd5D4Q2mTQOF?=
 =?us-ascii?Q?Jx4sRKm88V+1W5x35H5Ui2BqG+kXlTM++ZP+wBYl/PLrImex4u5gr5R0UFTr?=
 =?us-ascii?Q?8//H5TlKqzHD52L2FWbOwliX8TnyMNq/Vl4ZRWpRtZIIm3XBl9Odfr+p5DMg?=
 =?us-ascii?Q?ZSwxz3yGSDTixuoB5DCtQ5AIamn2lJ0rlhWfJqp+y0/CK2Kw5lmtH5PvkjtY?=
 =?us-ascii?Q?lkuxJcm/Z7AneokQBYP+3Tojk7Lb1DkT3MZJ4Y+j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a723dec-b4a2-4659-729f-08db16c72756
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbv1ssqKrrAG8iocbbKTWgBS358fQ6AdJkpnICGWZ7K16MU+IMUBcjR3C5j7h4zR
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

This allows userspace to manually create HWPTs on IOAS's and then use
those HWPTs as inputs to iommufd_device_attach/replace().

Following series will extend this to allow creating iommu_domains with
driver specific parameters.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/hw_pagetable.c    | 46 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 26 ++++++++++++++
 4 files changed, 84 insertions(+)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 2584f9038b29a2..a1f87193057385 100644
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
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	idev = iommufd_get_device(ucmd, cmd->dev_id);
+	if (IS_ERR(idev))
+		return PTR_ERR(idev);
+
+	ioas = iommufd_get_ioas(ucmd, cmd->pt_id);
+	if (IS_ERR(ioas)) {
+		rc = PTR_ERR(idev);
+		goto out_put_idev;
+	}
+
+	mutex_lock(&ioas->mutex);
+	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev, false);
+	mutex_unlock(&ioas->mutex);
+	if (IS_ERR(hwpt)) {
+		rc = PTR_ERR(idev);
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
index cfcda73942b533..c9acc70d84f794 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_detach(struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
+int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd);
 
 static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
 					    struct iommufd_hw_pagetable *hwpt)
@@ -296,6 +297,14 @@ struct iommufd_device {
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
index 98ebba80cfa1fc..ccd36acad36a3f 100644
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
+ * A normal HWPT will be created with the mappings from the given IOAS.
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
2.39.1

