Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9A6DE148
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDKQoH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDKQoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C178B55BF;
        Tue, 11 Apr 2023 09:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncNWvSaWTUR/WuvjCE9+4qyv8aT8YzcZ/RSc0Ik0GC3haS3FBifrwUp+u2SeFwrYdT56wqVWAuEgtnIQaR90tTgaPmRfInVVkU3dNmBzdBP1SBC0jjH/AGzuvSsXJ2r81drXKkGMUbVOaUYdXMwl6Jsb5eLencpGm9BQbomiEQusabvfHbJa465AgCxrEFC0YHnR75+A3kyHbRE5ACbaPuX3iASWtMsThCF+dezaNSV7FVV6frKVt8GUtxTVKoVgGyi95XCbkFjVS4SmRryLkOGKIoMjMVdv4em/A+uqqaf10nQoLizFomAu3ZmWEGjf9givw1dHdBGKMWPOzFV0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZHoMrZPiMXn1kBU9u3/K01xH6uPz7RYUd3HcdEQ7fY=;
 b=FLij/8GIX67+6gv+Wj6bmbRMVeQMU4YTZPpwvUp8IGP4Jgdw95pXs5dtXjduje0szKmVxduosdrJQ3z1NBjIwudCZR5QVt8PWO6h4v4SIb6O5klgT+u/eCFcGeSXAcQNncmEkz19RKEYx075oU7EZ4aPLSCYKKOFxgUYOeA6/fl5jUJPnNd+eOvF6dTStgNw77q6+0OBfe0BMmGwxl6oRioCB42IAQlgrFmS6Q3yNqdszNIMOXxNJKRDGzUBLvy4xkQA0ntJmdX3I4Vio0zefuW/OY8nVQdBgxTslmva4icAwlD+entgjUhV50JmeNwDCHxOveQ/3HFrz5YetUosyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZHoMrZPiMXn1kBU9u3/K01xH6uPz7RYUd3HcdEQ7fY=;
 b=HB5ANYvZZ87j4e6Ibzd0RQ01c1V9pG7d+1gdBrnGDGy7/NqFF/TDnQu9cY0btlzxPgIITIIh0pTwzj3ds2uz0L4J2Bght4JZKurU6MXsgLMTBS+zMDE/1+4Zo2yo+f/WgdH7ngsC0us9RXwo/dvs2gpuq8KpLirXmgEFA6o6pifFU7mtXNvIUVUmaqzUoV9KbiWjJHOonttd2AikvTFyMZlTqyyXqaz+FnFnM5PspPFfta6OYYYUgRaeuN4ESTYzwg3K185b1uguM1Lhztbjm//qEUImudhgyQilWNFucGZd9d04CUG8vLLEgUTus2HNlGd7srBZ5qtiKmIeeQetMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 12/17] iommufd: Add iommufd_device_replace()
Date:   Tue, 11 Apr 2023 13:43:13 -0300
Message-Id: <12-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc21bfd-d654-4f78-904c-08db3aabde25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2o12X6DRX+ddtF4pI52LDz654JiDFxsCtqTFyGZbcC9leKGHYtT+GuDmgQWL8z1rV2l9sY1gJjJkH9s4vqCQ1hSXbWxfPDL7Z6t1+OhKABDw3n7e/u4K7orx+AP2Z18sTDY+OmNKMNOcKwTgvELyQhA9BhDgDJtPmqipw8cotnMvTpvYHj0WCjc7WPDK/aN6+n1XZjVcpqPrM7ZPd82Yvw0Lqo/1Nl82fkn4heYv7YkqtnOGIETvB2Em75b8I0UgJiy+KnY7pRMO9lt8yo951/hQow4aNFaO9hKRZ00juWBJLrXANuLLBKOz0jutP+R9jDNSS/PkjeWIkK3sS7d3lnKbFcp0XtLZFKPw3ZuML6MlZ3ppbmFw4dHMtUijJqeyPtXWVFYWaCdKg+ar7yvVMrkWjsD8+uGq55BG2gfVn4gP8mII6n9YBC31BIlPVEDIn5+atTaVHOGCL1SP1q18CgbT7NOIseZYYoLTJ9jxuEXbei7CLI++btk9bd5A1q1j8w5CVSVN7f4obzS3jzEcVX0KO/IrzR3S5fF8syydWq5jWhH6ZVow39Ho0kaysb1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TADFkJZ8iXaZZf8LnX/UGFFYl8nEwEBXltI4GZy/LVjk3FGe9v5QodPlnt7P?=
 =?us-ascii?Q?602Lke5c6r7VHuJ+saDlsnM4DDd99p3VmjeOvEmAOQIR1z7zE3tslTVoRNXZ?=
 =?us-ascii?Q?Rcb6FyHd+IX+5FTnk80R9vuStDCAuu0l537DblZzsHv2acBZtReKMtWGBccW?=
 =?us-ascii?Q?+yijYvUZ6T6TOaTeaVE0H3/O0MvQO1/ugD/1beFbODn3yi6i0c/8aD0HGmKN?=
 =?us-ascii?Q?b3+GHqUTbgGOwf0CLswl5QCW5esY5yeLqG7LMb3MfETeCBsWdOJbu6mFg5Lc?=
 =?us-ascii?Q?FSiiJyQpQ8rVgQLiFMVOF4VWHJcMLSHg04kcn1VqgONtL6/8a04Q+9k+TEJt?=
 =?us-ascii?Q?SUnF1ievXGc+m4rQjF5vRIWtMtg1xRkrcR97qkTjA+rYaLQwEpXM6F/HhOqT?=
 =?us-ascii?Q?H0nlR8EMG0jtcS/CBLP6eP3OGsl1yYIkqcN9/OeKi0CuYx5Iw5mK0QrwV1S2?=
 =?us-ascii?Q?2MFB4IkCuD8WA0PKyAiQdAPCwlJSSpy40pe9rk1qqOHCrTBDs8ASe1aBk3Mb?=
 =?us-ascii?Q?k6ACsHYHosnXbBpWhEi4mgysa7kAjtFWK3+YBq1NO/pIYcwrDsKVTCZBd7Ox?=
 =?us-ascii?Q?UGyBvxkxCXrseIi7RKZ2QyW3MgGw5bvg6PXOTHecymgtAtCpP+vgZSuja2Ij?=
 =?us-ascii?Q?KIdVpkJ/o+MGIB4ziFx20fiueoeSk6e8yRI6jX1XE2aD7yz8AfgOTg9uqYx9?=
 =?us-ascii?Q?3hsAY5WGy6YJQzK5Or4CwHzUOqkE0TLTJEctJevzK8ryE/40OWYXLfAmTK8z?=
 =?us-ascii?Q?H08sxz7rsb9qVKfjuPCuV5rM33ZPmLz294lINifSBFQEkcMJhfdr3+zW8+PC?=
 =?us-ascii?Q?wRaHiEDiKbj+3fMX9tzVaVPJeYdTgeQ2hOrKuFdlaToNIGieOHu48wgytTf0?=
 =?us-ascii?Q?TSXXdZ5d2trHv0vsFGZ00KpSSjtOvCjlp4WfFqPYNwnBcihM5xAHb8Tgw0HX?=
 =?us-ascii?Q?wRZzMK15aBHVsBdkwmJ5ZdyQaqDmElirYFqLtvMv5P8BlhCxTRhhvGqs8KdS?=
 =?us-ascii?Q?7Rgj745iWzH04SdwXrZfnSfjgRjZ3tzSmTxqTBXRUCqHxgizHTLYhhMhA56R?=
 =?us-ascii?Q?AJ2JT6zLvwUy5VrIHocrlwfp39vTuqw5F+Q833w5iU+6YWLJThylIroN4X2l?=
 =?us-ascii?Q?pigJmnDZOdeY/3/kAo3vAeticr1UoYc+4nvZvhNLuKqLHYPw+D9JCKbaxH5c?=
 =?us-ascii?Q?VpV663vPEJ2FZfQh2YF0bVUeAuwN/FgU1TDZb956asju/895xI16F7SdswzL?=
 =?us-ascii?Q?5w7JUSDf3c+3iKG9PhhOyX6NKn0BBEMYkX/8LZgCf5X43+wI7iyvvwSkWz1x?=
 =?us-ascii?Q?d1rnzXLBkp9oUjctjmx38VvN64VZzdc7UqFTGmATsCU+feaZofxWwZu8R3pd?=
 =?us-ascii?Q?gOsicNannXktyMU0icxTrPFlkwt9+QJMTjiQuu6qehxWQYV2eqW4v+0JnLzw?=
 =?us-ascii?Q?QtOxbLnqK8dKxvnwtdBPidDfguA78kB/1OGghnOE8v3ThAVgE4CL15gbel7P?=
 =?us-ascii?Q?aUGwElpGedM3vNQDKE2jD/qUIqyRlHdD+pT3NVWyo0ZanfjmulGyffO3gMkG?=
 =?us-ascii?Q?3p5uJAfUqmgMG9NmkEq441rvwmQucHqSPAgSGOWi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc21bfd-d654-4f78-904c-08db3aabde25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:24.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gik8RPi5+XJs5d0/xZBkRVw0H7e+3Tlqn7mX8N6ml+CPz4D+pQjZPFhRxQpcuI/d
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 99 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c   |  1 +
 2 files changed, 100 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index e9979ca2494c48..c4edf2fc740793 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -361,6 +362,84 @@ iommufd_device_do_attach(struct iommufd_device *idev,
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
 
@@ -519,6 +598,26 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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
2.40.0

