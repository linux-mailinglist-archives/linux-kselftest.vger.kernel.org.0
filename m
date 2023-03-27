Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E96CAD46
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjC0Sjx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjC0Sju (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B693ABD;
        Mon, 27 Mar 2023 11:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WcCuuumU0jcU9pmklAEXk5QreeWGO8GwocFKruWA9rNhcI5y+fpJrsZt7cpnr8Xw1wyr7kdzBoomIiL/LDdfV1xvHNfki1N9JBZwYYUPGbGnn02aDZlAXQvXgqi5nTmoYjQDCSBAlXQRo6N/xHiy+J6fwe5nHzHc9x7nNmz8rK9fPFnBMMJWnqFQjE+z9sR1Fjo6r7bE2dnFBbicjG/oZsfOBvBV9iz3wcSwzq5MWkZyUZpOoZLlhQvPzZLVvBt71pjQDtiiHhLrYkQiFwrbl1t1w/5heJ0qQ1pRbEg3FhhwVkM0dY+B9agdoD+hwqMX//HyHN+o0UF63whlJD8v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZPq7jwToTroSMRf2OwvyP0SHuAPEXc32RxnsRiw/sE=;
 b=Y0Yzg2ry35QOfou8yEIu9aRIXLunqF2uDkpUXrv26ZzPsaYeZGqQFP8cLWhZH6yBX6d+ftQGF+wv8KsjXLLGXaM9d7af/5bVJjB7s2cu74Fg32KOrLSo0nz5V5JHEQV+wrqrArg2aI+0ZZLnom79ZZ7EbvS8H5ImNfoGXE3Vc64/6t0Lz1tfY9Dlegtgo1TJ3javlDiFEkFuYIYYYKplEL0ODsKvLfxiluxZJ/ubmcZCW7b3Z/ZrX69UA1LjhGXAwk05TZuqqIEwTuY7ZpvsBktGwdFbolMyG/2id8xHfPkDC4Toz0oVQLh/Zc2smD77FoBoD/aKO8AeIUYQgzii5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZPq7jwToTroSMRf2OwvyP0SHuAPEXc32RxnsRiw/sE=;
 b=X0M0q3G/1d+ZA5kwHeUtvTm1FM2ASXDDnGJFDbAQeVcjYxpqg8+4w0HpF31ZuBiEBJ9GNI2jSoW8ng/IKDLPtA0FPy05ZuOIWM9gMiupg1K4yvGX8durVXjm4N+6mH4cBeveUr1uCUxG2eHZB7HYxLxPJzKSHT4j42H9LD9Jxzsh4olWrqtMPT8WovYUrfIvgpIWxXNpOiiPLvnArWf5dliaTwv8UbPlCGzdOPcGuS6k3NUkn5USdX7lrV2CtIXuRSVwNCffZ0gXmijf6bN4zfmT7+WmeblcwnZlNI21WhDBc+2fcCm2HIVrkwy930yIOELQXAeQ15m3buzm8zZMqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 12/17] iommufd: Add iommufd_device_replace()
Date:   Mon, 27 Mar 2023 15:38:06 -0300
Message-Id: <12-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa828a1-9fb5-4b58-f147-08db2ef26c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzLgszrd5vVGtbl8n9tC2LaIs1lTXD3fb5uiLsH6QweqAARNZqCz0ztTDF1AkOkC++RrUtr8U+UfwAPHu3piscMuZDCo8imP2qqQIvnLYYSVTonfSvegDD81741zb1Eed4xQNhgPK5q6X/wzZLnsaW22/j9EPTLjyKQGVe2XIpPA7nHXlZFfsS4m/pzyjhkygFFk3bgRlymdua6UidYF8PFlGhvjdmTgeEKgdTCCbgQF+EQPkplEh2dA8+YZqWrUgSBF9FIRB5MvhQ9/aXQ4O1DqBAOuBG4Rq/nevZrQ/cB6Hahq34mDg0fM6XoKlJB/qHwzNBg9RmW5S+TtFLTxRfmErmQVypGftbGNICmaqwTcMlJBRWQm7hLPIMXFKmG5tQkPUvTVEMdSt8wI/lAJg1KM4d7Zjvy+KM7/R90pQUjUPlxvCZAhmGleAI9BUudrxtEoxwpLC6wCZ8dlmwlMPZz98/rh7ocJN3Vy3c/UhzgB0Qo+nLmdsSn7JXoIxlZ3rW8zQ+CkYgzRH8ziXa6EMa2nbMJU7+shsUxlEm6ZK5/aNAprIO57jzyjbjkhHT7z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EvSEYZvV3RjcB5SFMPFu/ws9fnYS2R0kOdgjD2k06hE1lSBgfkaDX7ThdaG?=
 =?us-ascii?Q?Da33GYfdkHQfIIIgj3rws5sqIXMkXJ5+O4+DefxlXuTfyoKHWPbgj1/f0YK/?=
 =?us-ascii?Q?yNBfjvJreuAw1TIvjgj/nB+4vHeGXLG1z4iVgd0ckIE8zdGAxCkQvt42dfZL?=
 =?us-ascii?Q?5jqlCJ5FeiAUb1mh6tIT5l6xd+mw0XRT7n74MelTF+PArKUeB4QOEjRSsgY0?=
 =?us-ascii?Q?+BgnJ2j5ZoewYQfIpHH7UN9mhJiwDX3luEvqTaIVwnSYPIVq6FXZLVDeGosC?=
 =?us-ascii?Q?sSLkxfQkZx15dbYui9i6hA/yl+zSgDu9omdgZ70CbohF3jxBrjYDJ3nrbCZ2?=
 =?us-ascii?Q?sHzmAU9liidqoUswqCEk84HzygP6bE4wPLqjNgT4G3DRMyETtinVG68fpI0h?=
 =?us-ascii?Q?/GgDIHHK+0DsZ0BcgOocff+pz9U2FO1adsKTTeCADc3bPk2qUzgcH/nrUAlb?=
 =?us-ascii?Q?2F5VklcIJpblhs7Dt9wb65tqNdwAKhTjXjVCb2IEX1DlTS1r7XEd84YhWwl2?=
 =?us-ascii?Q?bUOVzUZryfSpIGHDBGHpFZIhwB8bkyZweej578q5TLD1fUsMOi2bDKEtz6ZP?=
 =?us-ascii?Q?Ri/EWmjNz+YeKFeDJ5yalJUAuXVYXLyMNe6RgDOWJBUbetdDS1fN0NGKrzX6?=
 =?us-ascii?Q?9TRoeH2mmHgmI6HCku+LKL8p6sBnukQwxt2oWCZjVePlgq9oFS4sOW6DSKtE?=
 =?us-ascii?Q?aHW32zRF+PQzvhLVSTaA/ogYwD9r6qWKtgq6TO/UyLv6k1OGoB4cEbOoJoDj?=
 =?us-ascii?Q?G95m9+4us9/juRjfjkxKpQwVhQq7Zyy9410vxIW36qGSlZj2sQl/yKwsZBCb?=
 =?us-ascii?Q?01J8lZka/9TsK0MsYE6LbzXLVBZEf5DRPDbFTA0/VvNCfda+juIPR+BSKStI?=
 =?us-ascii?Q?acmhAafoluJdeHLiVSP3EHXXTrPwzP86T60VvHJdp2ydZ8XrTJesM9GS/OLN?=
 =?us-ascii?Q?ETb9CEFfO1TL9P3MX3G22rOy7QgocXhzYbj4FjFg/XgBjiPyAQiH8g2HaXSo?=
 =?us-ascii?Q?aGVpYp4Z12wH6xFzyHd7ImI/Z7NOxp/w9gwM2UDPvWSWNHSaPBjzZloKcxU+?=
 =?us-ascii?Q?Diswmb64rZOrNpnTO7pvRPuCuM8FLog9B+3vDhBTRYebDz02vgZKHpSjbmub?=
 =?us-ascii?Q?RIEk4nPMt9N3XNARAPmp3gx7bqK58FQDd7O0tkNP8BVX3r44lh83xIcFhrfF?=
 =?us-ascii?Q?UhYfDeOeKc91s32+sR4inSrZNsB3AgTg4BRvEvDs0xv2cYVfVPr8BRHlZQvE?=
 =?us-ascii?Q?xEwPAYK4Ysy5ED0XTKOMOPkcG7waHqPPStv4k2ai8woBv0exBXBISfiilX4a?=
 =?us-ascii?Q?8VWjAsM+/kTCfOmr4iI3q0lhq6jaHQu9WmAOMQ1ibM0mbxsm1OOKGb4W9d78?=
 =?us-ascii?Q?K827j78Clb+jfcNHgM/+uVD4FJp47uhfbBRU2Y4jhajGtB56Z7OtW7O7WiSF?=
 =?us-ascii?Q?L7AUf9jwZdimetgv0mKcDLbRhAwtx9j5QN+1tJpIQnhjCU3Rhu5v/TPRvOqX?=
 =?us-ascii?Q?hqB2fRbjdVKAnWnWP+1t7crGZhuYEpScHICmWEZiEQU3QUm+FkoysxPGtqkO?=
 =?us-ascii?Q?8ohozGZDbAmdPV0jIKeRkSMNc3JaLQPvICUee9NJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa828a1-9fb5-4b58-f147-08db2ef26c7d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.2556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJuwzeKCirB0dfJ8tiQxhhZ7yWpX7C872GPT9VN9IcCbS1gsfGg+8Ld14aK2WeRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index f931d3b95d6d0d..397947554bae49 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -4,6 +4,7 @@
 #include <linux/iommufd.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include "../iommu-priv.h"
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -364,6 +365,84 @@ iommufd_device_do_attach(struct iommufd_device *idev,
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
 
@@ -522,6 +601,26 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id)
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

