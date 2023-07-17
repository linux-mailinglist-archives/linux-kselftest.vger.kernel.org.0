Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEA756B83
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjGQSNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGQSNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C2B1;
        Mon, 17 Jul 2023 11:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgnEyvBi7Og4yGBRM89rFMKDs5sFBQ5b6g6A2m4R4YIFItTsLRPGAO8qhzclZcvIoBKPeW0Dl6+QOkGM2S+uOs4DRwkL2hGoH/CdHs8z2c0bxYnToFLlptxknNcfj4bTOjvZlATkzJCkEoiqGSlwBFNAjh8BhpOndRO2XoHNw2wphmlNfEZ2PKtihBqqK8N6yh/9B70nvPEm2r/X/RTjTZnK/xtiDFV9vWXd+xf8/UHXYulM3rasniAiCgFFeJE4z/bpGprQhN6/ZTOjPGzxHji1s2CHG/PskTNot1WMPCnQOZkebN4VdxLkzGSbjnd3ZhF4JG9obi6K555vuCAQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn4K5paiLIjHz+WPBXBKqUFIWDP32uFlhOQmxv8Z2mY=;
 b=OMc90dxdQsoemVwcCqVQF0MTX/0ZNBzubhqDuF1tjM7koXl+3eP8lv4QEjt73o6j2g1RHaxKZvSL1WzKTikrBHMNEtm+dKTco7Jl6IcgDL0O3OqIrtgBlq+kxsfAaV7p+6cG4np64cBz7kW/O7xvxPt4HXTPDeypD8nnYzsP3KlB/S5Gdfpnu1iH+zIOVQsws4PRHPbtmNCd/dLhMZFpqj32fyex6xNM45kAkVjqwok9mJK7YPXZaKADODaIbiwDuW4o34yIFCQMc1USg5z71FYtmuoPjMjaUmRbyjRDCXuNTLCte19whzTOFppjd/iC+zn0S0c2kuvX4NvKbzLlVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn4K5paiLIjHz+WPBXBKqUFIWDP32uFlhOQmxv8Z2mY=;
 b=f1WwhRhK3G52LgdQIwTiQaccMV0RRM0ckya8wGSXa/o5iR6NTFaevenm8JJUMSdef/Q5TmQRThF4yqVbc721iGhXI6k2e7JBtSvr/CXqSyeiMnpoFCafF4qVDDIdh4Ib5UyIRwjYNKZm3G8zCKO6PmnBtJmXA1SwashP4pAZCq5AU4NrRvmZjPzou0FXAB0jtl1e0UbuqtjwfQ+ukUp/QayqU21GAx0evfHbOqHMDcoRL9lcdvqt9y+K46LsTynTEGlA2j4I7UayVwFbFL4aq69pgpraQ8gaBV6EKoZlhk620EzM63ig065+rT0HP/QTscDgoAlRNs6mUwjsngbzEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 18:12:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:28 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 14/19] iommufd: Add iommufd_device_replace()
Date:   Mon, 17 Jul 2023 15:12:10 -0300
Message-ID: <14-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 5113d103-9fff-40a0-38e9-08db86f15d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaHTmqtgIXodP4IYPD2EfmsUbosCxs9kjR91tikSUzCqosa0neiHFdeopl3OZ/LFSyogvPExbnYPp6CsYYUQUPOp0ii8ymoLfHMBg86olPDeV29YZPznE7byMqLNu9KNA+nJm/yOXkDO5vn7aW55vRckp4I1nHPPqbaeQDy/l5GpSFRF01Cpdcv+nHqc6sKlpOSl4IdRjup0syh4S1363QaIjmRJfjyWJJBZVNNzvuNYrzGEoy4XVoI38K3vnaCo+kAAn1Xhc15jmJ41nYYm3mf8IDRoM+TKoeBBfKqluiytjEZG+LrJyj3aDXCpCLGO4g5vw8qOjbp+KmOmGPxo4HlL4KW5YPqg+758LIvXwkAHmrxOmysmw08uHP5nGWJkACchlK/RkZyqvLFUVb4Fc92o+KEjjI0R0A4criJZ+I156F+uL3oUm7o2s7tAV+Bh4p20rU2tdcjgf+/2S7f80bmsbpI9bE5LEoUiu2k4Otb7O00s818SJOt6nOU7iSuAlH7FUao4M+Gwz1q4eeb+JIdvWn83yQetc/zJuWPURL7gXGU01r1fOfIZYsXE53pe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(316002)(41300700001)(83380400001)(6512007)(186003)(2616005)(26005)(6506007)(6486002)(478600001)(54906003)(6666004)(4326008)(66946007)(66476007)(66556008)(38100700002)(86362001)(5660300002)(8676002)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7brhKSxrRoEeUmELzsiOo65NErlakmmTjwekVG3l0ftQaZl3tsuh76A5LxPe?=
 =?us-ascii?Q?zcX0E/bvsELnMSfdGwd5B26Gigm5kaVOiBsCs0DgnZGbUcbhaf2IF2wS+7qS?=
 =?us-ascii?Q?d6ZeY/FBjIxgaI2MbPdcw3DlDnoMuPzudmyk44DFg4nbtMSCMKFjdD98uw/6?=
 =?us-ascii?Q?rtkdxmxP5+P+GOO4OyEnUtez+XXYIVumD0iiwKlE/vtdyAmrqXLcEO1aCKLJ?=
 =?us-ascii?Q?eWCWD0q5+TIvrwhvKW5Z8O6F96PtEOrrOW2XC1ewc0g808JATcJb833lOmqs?=
 =?us-ascii?Q?WEpxhe5kY5bzHaxXJivXuHQj58xUW7B92g/j0um7gu+w2gf3EirahHjzLOj8?=
 =?us-ascii?Q?TfZk5ZORErcOpK8E8dRV6CtYAuRFAnT4AEj6rmpKnqzI3nN9+Cc8w25KncNp?=
 =?us-ascii?Q?qaYCcblluqnJSVLaPWhsKt5lohMVWvvA7/dLy2/QZhpjLrlb5qnxqC10bKeA?=
 =?us-ascii?Q?zG05kBYQSofWgYdd9sa27DB3c1uKVakT3vZwQKCtW7jvK7iIAvTfLptvb1Xr?=
 =?us-ascii?Q?q+X5zsUqLIQ/S491Wi8ZPdECodDRIIfl3wMsOIXB82eqgVJ4xNPJVYSDXrjY?=
 =?us-ascii?Q?TjqETsalLEwscxQTkE41tXdZnLkGYUaprWHuiYt6tkmnPY9RCoSY67YAuhSD?=
 =?us-ascii?Q?93ei7o5ESoCbOp7xRcYoSh5Lp98QpQfqXdiXXFf3F3Xf6Y/L+LMJm97DVY8F?=
 =?us-ascii?Q?fqEerAk4iFJWP+q5ASAuHo61WiwzwB6qcroIjWNONVLgEGjHvHNmnS5KSfnO?=
 =?us-ascii?Q?y62ArixcqYlFHLTF+9zGRAH58cURTA+A31aflKJY3OSKxBzMrE+3Gd6H0bC7?=
 =?us-ascii?Q?v7SnBFQRunCiH4CyuRn1/gslpDwG1gaimU/CrElIXQn4VLeHYsfgwE5xW/LD?=
 =?us-ascii?Q?YtKu37comXNOpwItUny5SyEhDY7kwlIbENsXzAlB7v1Vp01QC+savMrzCynV?=
 =?us-ascii?Q?SmyhAbrwvtTXTKbD6xAQ4dHqAhrsGc9j/BiYShZiV9X4RKSZfxiwrZXoxoH1?=
 =?us-ascii?Q?pQQVMw+9Z/ISaThKHLajoyd/HLBOMM+AnayM1o+gAF5cPMlh2T4CuPa4Qt1d?=
 =?us-ascii?Q?rgd+J4aZq5JJg7U/0r6a/gB9nkFHACGUoJwOy1kT0AI16DoPhi7mT88mkfpi?=
 =?us-ascii?Q?MSukib7KGMuXazIvk9czYpWf0vDNEC5bP+aIcMhi/6zl8jA0uOUhOA/cB7TH?=
 =?us-ascii?Q?pIxKIjIYPKWld2BdPD6vXNf55TTMl5Fk1foXTtMLvTK/G07msBJq/dXKztlU?=
 =?us-ascii?Q?TD9xhI5e3cXINS6Tikf1OqrNU9NBHJgtHcqmIIEm4qEzXAMUYXyj4u0SdE6m?=
 =?us-ascii?Q?Rsu37x/LcoXvUFi4A52oV8VuSvpEoLNovgOaS6JkLyo9GBFOarO2LYhn8/+s?=
 =?us-ascii?Q?x2lbkK1ZrtH1ORT31K9vlvjwiYDrHye8fv9FDjvv+RGp/szi+Wftj/RWg69i?=
 =?us-ascii?Q?ccNL3JQh+ehZ1K9bw/MYweebMorIww516slE1ou57bAYmxuTpZDYVimB8qWb?=
 =?us-ascii?Q?0glN9r/EN9BSKUWAA0Mt7QCtzuW2gfb2sP65CKarP19x2Q/g73/gS/w0Heka?=
 =?us-ascii?Q?b3F5t6DnqUrzbAaRLoXt0txQAqcjFqsTKjVZcMUx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5113d103-9fff-40a0-38e9-08db86f15d19
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:21.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAtnapEkiGKsVLc3X2UsuU2ABq+l6S3Fdu9dtOBlzGJrDfchZxf+dY5kT+nWF121
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 101 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c   |   1 +
 2 files changed, 102 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 87962d19ccd363..0044c2df500ef9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -365,6 +366,84 @@ iommufd_device_do_attach(struct iommufd_device *idev,
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
+	if (igroup->hwpt == NULL) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
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
+	/*
+	 * Move the refcounts held by the device_list to the new hwpt. Retain a
+	 * refcount for this thread as the caller will free it.
+	 */
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
 
@@ -523,6 +602,28 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
 
+/**
+ * iommufd_device_replace - Change the device's iommu_domain
+ * @idev: device to change
+ * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
+ *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
+ *
+ * This is the same as::
+ *
+ *   iommufd_device_detach();
+ *   iommufd_device_attach();
+ *
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
index 24f30f384df6f9..5b7f70543adb24 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -466,5 +466,6 @@ module_exit(iommufd_exit);
 MODULE_ALIAS_MISCDEV(VFIO_MINOR);
 MODULE_ALIAS("devname:vfio/vfio");
 #endif
+MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
-- 
2.41.0

