Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90676AFB40
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHAgW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjCHAgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33985A0F0A;
        Tue,  7 Mar 2023 16:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+k4BkaQ/tFjBJnpxW8/lfkjA9yOPv519S2p2AkFQ0lyy3Pb0IjJki987J/9hbOu4Tk+btDtDMgdmkeImFm5wMfoT1cc+8I2geEarm72EdDeIOy4GfuwOrSL+2ZCSpcRvDeipa2XaPu0P0NfK3dUUPhlQP1g6PNJo1g+LUjBIHI6mGjnKmdN+LvCzqHnEuCgHzyxUDsJ+d75IHd1zb0/8SGKj3wcmtFxTFZNitiVNpy1pMZrtfMMyDZ7t44OcpasTlZnVz6hfZZbK1Rhnkd6Ar/QzwxmLa49xTk3Nt+u98i68Kw/rcJNxWYWwqyrCk8SHvopZAoieatabv+iyrLEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdVNZFAFb4WmTzu/R0rG9qtc19on6HWKswpFF7vtbo8=;
 b=fSvEwPNI6ZMnzfm56yj5ZNBm7hp/n5T6Z03WfS+J8a4j/55qdI+aaY/jM56wqbZBfKLzF4FF8dPI/IQYZnpPXPrz9qNfx08UeU9ebfE8wiajs/1EmEuuFq4FNLK2oL/jfHbbwH9IPw9+dhM0ChBh68FXWGVYxKcHd05bZqvNrlbgJo2MRE56+qjEPea8C8lUlnUfLevYP9gvSmBuPX+mQX/52FGk+7pt+zkddB1w3yXx1tYaW1hXb1vBeCBAEPVGUER0bYOCPuaH4vnaUFbrvoTchDvJ4NikZbWyWzcmeWhEkrD0MwO084fHMFm8VTb6NUjhW5wh5q4rcAIHU69t8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdVNZFAFb4WmTzu/R0rG9qtc19on6HWKswpFF7vtbo8=;
 b=Sy5uUC5ahXiwqacI52/C+Z1LUafgoWGa3EQsk5xYNmPTFUpPQLm8zjYWTVwYiHDarR0e/ePj3AQYzwqY0b4WIoXy02aQDOLo3v6QjZF/GXAhRu8r0VD8NmLnAT3t66Bq76jJej9TUFGLOSzRlRw63SbP7eYE/0hxX9I1BtZ3X4bW3h0XpMDDDSIxRq0yQd9o9Lu6j7R3sZRUFnKUY5OlVR92ezqOd5DaU2t3nqhhaOjvdbwd5gBk5mLx/qz3F2ub5n8wOsbW8wDqOfQ+G+CClr/sCXCNaosS6EE0LnV5NFsTGHE9zaqOYh1KEjoFra00Q/3dY2rDjhUGscnKV6U2PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 12/17] iommufd: Add iommufd_device_replace()
Date:   Tue,  7 Mar 2023 20:35:51 -0400
Message-Id: <12-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0082.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 468e701b-b461-455b-1cb1-08db1f6d168f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6N0AmhazAySZsEo8CKuXZgfceG8q/KhD1X3ywb4kFMTtdntOaiY+K0qe09H4zJ2KNbfaz26WkgxXVpszVH+IEEWP3cjcjsvUXVw6JJCTQmjj/RuSvUcuaTNCzqLyR2FcAqZnCDXcnsN+14PVuHM2O4LaG+dPUknevsib4r5FvcteYqVLwQshM0+ZuQiRdUZFJdMCiJKxGLX8cSxRw8LnxEtVkZUVxEAbyt5ioLFL/HGPyM0LelvMe26Vn7XZk8gX3BiFxmNeI6ccVjUOyCfBSGNAcs4U8zSU2dpJ24gTebaTe6KLldVftegNvfcR2QsZn9nb3m6WOIrO/FwdQZ02kn6w0TrLsQAXAvLTkywCHeEkAynOhIVHmELZN8wALZBURsf9b4gnKlSJ4Rnu2Ae35tPnLiMnXzp1I2FRkGyXPCzncGCvaunysZi5dvmQLFyTKaQQwvsxVdSkUcKMARxt+GLkihJSq6vBUxhL1aSaJaBBpdeegWuQudjELqAU4tzp8VWFiG4KKmkia4Ya1v0rwXz2Eq9QBWshOsDlPtomohf8VgO+dGvqgbsIPldKmwk/Mq26TZ40s5WQ9Vw8kJNLERJMypei18JWwrbZw814zG+fHNPSYH9f1pVH7OsVzcQENrcnc67Zd8HD22tYBRSkcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SrzMdrZFiZa0Kvq5mLECxRKuCzVsrdxBksMXsl8bmTT/GGl8b1YLYWzg9ytd?=
 =?us-ascii?Q?M1Iis2qE4NM8pHRZz7rfDYSZtnpWLHW2qB800busKYFDPK/YlWdQo6Ghrji4?=
 =?us-ascii?Q?jD2T62x0X07n1+6+9EKkzMVsQYnnQ73r8gbzE/PSi8yzjcz+q80A3KVVTgXG?=
 =?us-ascii?Q?2ZD+AzY5TjQjxtYH9vIthUQbIgijPmZxW/xYrVTp4Q8CUCp79qvzsvdPqyOg?=
 =?us-ascii?Q?WyuRYG+P9LBPejKynVoQYrhJWB6bTUVQ+nbeW1cYi/JVWAkf6EknRByOUHCB?=
 =?us-ascii?Q?8UOGyu7VNZ+Ibe/XWAyxErHa+wuPbeOCZ7SxaEf0wBExYi1GqmjCVak22Cdf?=
 =?us-ascii?Q?HR5xMyr+YamQXWIDST9pokITv0RGey0Gu6o9b+DbuBBI5pDDF02F+LB/l/X3?=
 =?us-ascii?Q?qbn88x+tS/GcED5/fOMikMXJGKOsM8qAKPyLGlJxf5D4VjBQdPOrcfp4eEgW?=
 =?us-ascii?Q?nyW218sdf5gOimMeoYlqBCGWnjlf6G904poewRJbc2RaquWWb55z/p50+TH1?=
 =?us-ascii?Q?KBTCK1bcHlGETGINgUELYVoJCIKK/EyzUPMgAWaB6+8ruTxZLg/PP7bLm2bk?=
 =?us-ascii?Q?wpMP7ZazEBKZrJGyUfr+imRIcRZm/Ed8gX50VIRaX1NWPjlffmhi0j6uPn9Y?=
 =?us-ascii?Q?KUIUnqUIzRaL69cB8129qY6EMjPMaDq0u+qnTNufB4yJgKQzZ4xZ+EpLIwBp?=
 =?us-ascii?Q?vkZ0FS3+R3JRWL5TWiBKc2uwqWj05FHK+JCLTlppfy4TLYqsrCwsVgwceb+E?=
 =?us-ascii?Q?7bsewF12AwlGREU7CjiEWlPAV2GKQOLsG/dH1eIAgJlNeBQRL8GFWN0Yq9Px?=
 =?us-ascii?Q?HgLcPOBdvx65TCoHmoSAroNzl2XwcK9K7a0I2Jt5ZUymzFrGts25H9wuYZZx?=
 =?us-ascii?Q?L/jxL3qY/L7bXNYGOxfImHA0b/rZ6vXPfWd9kPMrfqVj5cJd0SPS4yhoijRt?=
 =?us-ascii?Q?3Ql3cuT3rvS6hYjyi0QbE5OxZRYL4bGA3Od96yieGB8fSJDaqq+T64SsBDWc?=
 =?us-ascii?Q?8K1m58LFxBGPF6to4CcHZTHKC2zGywsmm2FZ2FlyKEXyJ/S7COLd+m5ds2vx?=
 =?us-ascii?Q?hZAB1/cCM2EhJwX5Jf+d+v5x0ujMTgGEgoSCCuDyl2m9LDUiQu2jT2Tm8vdr?=
 =?us-ascii?Q?ALG37Z1iU6HNfpEzDCECBpcocEDNK4T0o4GSff3zDJfEW3tdkr7M4m0r2qvp?=
 =?us-ascii?Q?G1gvDBd57dTbnJ22XE2uOygEYiK7H6llVzkcTntBdAUU3f04e/Zq4PCBZnFZ?=
 =?us-ascii?Q?Bt+A/tB3l4ebt0bkp3Oo6WsotlIMDp3JQCs6LfoPAfyxWoxd8jxZEvKikZNk?=
 =?us-ascii?Q?PS0AcICjSyEYHyK6/fEbmbKewRsuzwfNu6KBF8so4RMImwqrPE7AZKpnQqWk?=
 =?us-ascii?Q?pD5+3R0nPfrZynZWIuZqlrt0Ozmv8KWxjGsiLWNooqv3zuq+GHnYa0u1Ix+v?=
 =?us-ascii?Q?zXmLTd6cPBTXqyV/451mfuBJWBh2j/qlc86YXUP+FS6ZkVn0p09wKQTEV3UI?=
 =?us-ascii?Q?M8EL2WnNQRsB961BdW5q+XmkvYVzVxf6XT1Cs+CvSNe78I3Yzf6nD24Qemo1?=
 =?us-ascii?Q?Rhetn1wiNlPlvWs501bjXV+h66SsKXTNRUmj6fi4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 468e701b-b461-455b-1cb1-08db1f6d168f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqO9+ZWLPRyX1FqLsJLHx5K9JkAmjE6aeyGC8pxDpPgRTLSEAgmI7gXLj31h9eD1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace allows all the devices in a group to move in one step to a new
HWPT. Further, the HWPT move is done without going through a blocking
domain so that the IOMMU driver can implement some level of
non-distruption to ongoing DMA if that has meaning for it (eg for future
special driver domains)

Replace uses a lot of the same logic as normal attach, except the actual
domain change over has different restrictions, and we are careful to
sequence things so that failure is going to leave everything the way it
was, and not get trapped in a blocking domain or something if there is
ENOMEM.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 91 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c   |  1 +
 2 files changed, 92 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0256e65476f045..68d1bee1cdb68c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -359,6 +360,76 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
+static struct iommufd_hw_pagetable *
+iommufd_device_do_replace(struct iommufd_device *idev,
+			  struct iommufd_hw_pagetable *hwpt)
+{
+	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_hw_pagetable *old_hwpt;
+	unsigned int num_devices = 0;
+	struct iommufd_device *cur;
+	int rc;
+
+	mutex_lock(&idev->igroup->lock);
+
+	if (hwpt == igroup->hwpt) {
+		mutex_unlock(&idev->igroup->lock);
+		return NULL;
+	}
+
+	/* Try to upgrade the domain we have */
+	list_for_each_entry(cur, &igroup->device_list, group_item) {
+		num_devices++;
+		if (cur->enforce_cache_coherency) {
+			rc = iommufd_hw_pagetable_enforce_cc(hwpt);
+			if (rc)
+				goto err_unlock;
+		}
+	}
+
+	old_hwpt = igroup->hwpt;
+	if (hwpt->ioas != old_hwpt->ioas) {
+		list_for_each_entry(cur, &igroup->device_list, group_item) {
+			rc = iopt_table_enforce_dev_resv_regions(
+				&hwpt->ioas->iopt, cur->dev, NULL);
+			if (rc)
+				goto err_unresv;
+		}
+	}
+
+	rc = iommufd_group_setup_msi(idev->igroup, hwpt);
+	if (rc)
+		goto err_unresv;
+
+	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (rc)
+		goto err_unresv;
+
+	if (hwpt->ioas != old_hwpt->ioas) {
+		list_for_each_entry(cur, &igroup->device_list, group_item)
+			iopt_remove_reserved_iova(&old_hwpt->ioas->iopt,
+						  cur->dev);
+	}
+
+	igroup->hwpt = hwpt;
+
+	/* Move the refcounts held by the device_list to the new hwpt */
+	refcount_add(num_devices, &hwpt->obj.users);
+	if (num_devices > 1)
+		WARN_ON(refcount_sub_and_test(num_devices - 1,
+					      &old_hwpt->obj.users));
+	mutex_unlock(&idev->igroup->lock);
+
+	/* Caller must destroy old_hwpt */
+	return old_hwpt;
+err_unresv:
+	list_for_each_entry(cur, &igroup->device_list, group_item)
+		iopt_remove_reserved_iova(&hwpt->ioas->iopt, cur->dev);
+err_unlock:
+	mutex_unlock(&idev->igroup->lock);
+	return ERR_PTR(rc);
+}
+
 typedef struct iommufd_hw_pagetable *(*attach_fn)(
 	struct iommufd_device *idev, struct iommufd_hw_pagetable *hwpt);
 
@@ -509,6 +580,26 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
+/**
+ * iommufd_device_replace - Change the device's iommu_domain
+ * @idev: device to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as
+ *   iommufd_device_detach();
+ *   iommufd_device_attach();
+ * If it fails then no change is made to the attachment. The iommu driver may
+ * implement this so there is no disruption in translation. This can only be
+ * called if iommufd_device_attach() has already succeeded.
+ */
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id)
+{
+	return iommufd_device_change_pt(idev, pt_id,
+					&iommufd_device_do_replace);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_replace, IOMMUFD);
+
 /**
  * iommufd_device_detach - Disconnect a device to an iommu_domain
  * @idev: device to detach
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index e5ed5dfa91a0b5..8597f2fb88da3a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -461,5 +461,6 @@ module_exit(iommufd_exit);
 MODULE_ALIAS_MISCDEV(VFIO_MINOR);
 MODULE_ALIAS("devname:vfio/vfio");
 #endif
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
-- 
2.39.2

