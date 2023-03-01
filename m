Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFE6A744B
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCATak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCATai (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9152D59F6
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ov/AihjVM09Cx7On/WLjXLzWcYPC7QYpViDbq8MNxpZCP2APJiMvez3T4FnuLGqXUnalSB8u4bRAFbDrqkw2q9BfzHj4NR0ZJH+LaEttHkBngOjWjJ2Y3mNg5pPWyp8skKTalg4cf1ZvoNTcHTz/CZ5nCyMU8e2g/QT5DrsbJxqf7ElPEZ42GFdLNwCkRkWkSpK6X9kVChY9XUFz9PdjxlgXboGQEC6fLdxoD0Ef9DeBrkoEtU4QZD3bwuaj+Ssqas4Rqbr3D0lrPnv6b4Vwni4OHFYhQXpaC3diUWvzLGGUbnZNOKGaxnmZJPBsPQyHgC53f5AO3ntseCqU1gFjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AP2vJ4pE+0nTVKgw9T6qdY1AufHcmJp///XQ6wrz9cg=;
 b=IdshJMJczjghPqbgbI2Rux1aPZLQk+Q1rhu7gpoMqs3OjLikifpwq8RFiQgqNgxvfzSxW7GThvOhROHrJb1ZGSyOveL6b9HRd9/KQlDS8dXv2oj5k9ZipdxuaI0d7megFmLPpTa24y5TNFH9X31tJXYL8v0Ay3cswuRE29iCjAYCxUalvfdbBGoDKiAUGIT14k7RFgzh4RomWkwDnwoTh3oRXf9yTj0ZBpouziow7uiXXLfa3nLytLtdmJeaZeUbr1afFNWRdVfrGboS1/6/s6Rc8qUYcFoYP5FxpGuzR9HRbRbbUNGkZaD+kLtHcpZKXQ9MZzT9fLsx/186/RHiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AP2vJ4pE+0nTVKgw9T6qdY1AufHcmJp///XQ6wrz9cg=;
 b=QjOCLMpmvE1yHlv1K1uKjYLGCAlf2hQZNn4Vxdst3F7I2T9cyva2JoFVHTEP3hK8kFPAYTDH0NoZg9PgRXQ498vzhGRhAWGco3qxavQDr/uWTbRw3JvrYeY5TFU+k5WM6ZnHSfpOkLwso2M1hkc4AzDYp3jwvRTqj5sSgplYOq2zb1MxiDx+morRWxjfjSHYGcSHfUTyAQnrv82RtU9t6+ZyU9Xf6K9ERM7SZnKC3n/PbVEMscE6TKUNZf6mcCYGFG/OSxBhL8epS4HX1M8mJ1Gi/mT9k6vDA+tqpi0xj1YTaT6ycRYaVGuqMLyFm7s7yuefxpEKSP8XjW9rs0UXKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:34 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 06/12] iommufd: Make iommufd_hw_pagetable_alloc() do iopt_table_add_domain()
Date:   Wed,  1 Mar 2023 15:30:23 -0400
Message-Id: <6-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 98872ac8-7b3b-4cb2-4b00-08db1a8b6bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0Ty30eQqC8Xyib1hzCb2E6HFSGZQDG0YcS+VwAv7DSrdXM6MlP4GGNUCxyitrj7T8wW5wlPAABQo4nUuAGBf+kfGa7c/nNZmmX81QwGl+N9vMG2jXFUS3aP0xEKb5wO26eya6TK926cQXfnV2ujshsKF1fjZfkNCrM+XTcdXzocw2ryj841DF8B+f6fUG+omgQCWyZRohl7vKq6O9lqvDNH7OsW5781/KpEHzHBQyAXFEKqcce4hj1dEoHzLrSkkowEBxud5YNsQvlCQIGeQzmg1aYjZO9imHcIaHVkmTgralSKyK4UnZC7R+wZSnlc5pVFsVqpYpBhhY9mbO1pOS4gDO6GsCJwMLaX5U7f+PcOEiZuZZujnAy+girDL1WsWQpFi+oB3matbrJNhhv/75ehMJJDcRBLzLtN+wiJpfwhQEvVI3OM+kHL8HZgM7aDpnQujjM7o8SZCXqtIve+1/aFT28P8WUG2untTzUsE/0ku+/EjsPgXiWpRCrZu/EttXGeGfVlFWbPyYHRQBgWZUb3P7m//1Y0L6h1C4DGj2C+IvqQ7fJqWyJDK0LOX8GwKtTQK+0wZ1IjqSrpARuagZceZFqDWK54FlE1kjPVGck7UsLq7Jh7sYb7gVQtUBL+t9dQestvGunbuZ9Q1zno8fozzEh4R0uYoZbsppR3dg63YqTCzHZExdg+kXAFIiSz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XCmS8W1fxBmaoLpDSe7bo0CLiNkUsHTMpmURlpd4OuJEMPqvPlwok0reGfxX?=
 =?us-ascii?Q?rXKFJSLRWtdEalP1qC0SWox/YpQNPJwHeyojdQ6Yju1gfLisW9eTfgZcQMan?=
 =?us-ascii?Q?9QR65+odGfjny77FxcVgx9iH+zpu2lMZ0jySprw3p3HcIqRxK+xVJmnU841f?=
 =?us-ascii?Q?KFklsH1XvfP/ZLzsoPalMdUsrB8puLk/py20UIV/TC1D7eHJUGLQJ8oCOK1v?=
 =?us-ascii?Q?f9xnLw4lIuu1ovJSgA4jzTEsx/JDodaihq9LnIZlz4UPha2w2BDB+SLo1FA0?=
 =?us-ascii?Q?u9Kn5YAvfxNLJ3ws5TD1zaT9c8EMp8o/OjzhtzWLhufczIqQchXRZrPf9mpL?=
 =?us-ascii?Q?zOD5dygU2u2LCFJRgq9neUpZdV93NuZ3CWsn2L1p0lmDV4IgbfJnPANKH7KJ?=
 =?us-ascii?Q?hhAua3HKtc5vRVnBr/zLC9u0W27GSN+mdykI3o5IZTekzDSHG0gs5kIkiS5P?=
 =?us-ascii?Q?oUq9Xyc9EaEKAEcEbWSWcFLy104emHkVC5YQaj6C822YPDsKRoEYjcVRlvvd?=
 =?us-ascii?Q?yFrNmx3rmKiRZy7iWT3Fy4Z5U0eiUAPU12ZD0g/OocjiRIrUPJ10x1fbAf6e?=
 =?us-ascii?Q?al1QP1zVpb3/2ea2tuuvdi/QygeyAXrBroiyXeSTwTeP3pK2YL9cZjL7N3oO?=
 =?us-ascii?Q?jq+JL2eyK80RBUhMd6tlNldyq6RfwOdqc9cjL6w/XQIO+/MmZxEZBBXzOm0s?=
 =?us-ascii?Q?QJC57GpO8CKLfDbl8dAKgdWOq/t29sp1fsbftae+6UDuN2C7WZjUFwLs2+vy?=
 =?us-ascii?Q?RwRtYgZkzf1U6Hp48b04b1gXWbqsy6Lg4BFU08XWyTigHRvFcLDwM18Svw5m?=
 =?us-ascii?Q?hVZN2okb3T6YKXAfEo7ar2fHKBpW24c8cqzEtaTl7mHHz8wuINw7MHcI4A63?=
 =?us-ascii?Q?LdAzZ5/rzHYiVXJrxNarzzX1Je09qHQK21/gKwmraJ7c3U8EWCNpEqYQRW3Q?=
 =?us-ascii?Q?8lNUjxabUpJAHHJjD4UJAHp/2+SbH7Bgwdm8lhXKLQHNRTieiH8Nyt2EmIOQ?=
 =?us-ascii?Q?6r5Le7htr5qL5xoTO7ZXb4U14zxKL2XIzsg9hzV0eETN6kArO7tFTp6t0YzV?=
 =?us-ascii?Q?G8OYYNpgcpKIIsME3Bd6l3O23hYRf5xroIRKfwrRZGx3Q8CqAn6j/bZyqKhN?=
 =?us-ascii?Q?tFtE6xSAcQ9hzzIDh+fbmTEPNFb/CstFPrRY5xi4IOOFHeueb61fkKZdf9lO?=
 =?us-ascii?Q?7N0H93pib88ZfvlOhYNSyuAnLL8E+FChNJ5a5hQX8tHv2HUllXLhGfIwMRhp?=
 =?us-ascii?Q?gWEYdrKZv2tI8TcrS8XYko/dJ8MAFCzGz/obTsp4DCctXL0F+8ZHkWaNvf1Z?=
 =?us-ascii?Q?qNGjA/y4VEa9f0P+XC/rRCnzntCf+I836K/uJJ4c3AYjJjFNFX/g9x8lAkKr?=
 =?us-ascii?Q?nAdIV/vC63p849wz9kqsDFDRxd7UUGW9nQR+bq8C4tOJJMxvlIXaZ4TVmrAd?=
 =?us-ascii?Q?aN3Nv61ywLnQc3Rud2o0/Cq94MpUbPWvv1QHcHOGrSgGATv4R2NFhKZrAZC/?=
 =?us-ascii?Q?zQ1KZt4MbWxyDNqkbgL0be8AXYKObyNYBmX/eWkgQwieDymBpHiUYX9RaZVw?=
 =?us-ascii?Q?v7F5ZBWqg+b2NLjFsTN0/6zl02xgPLO1MJKzgypB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98872ac8-7b3b-4cb2-4b00-08db1a8b6bad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:31.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5Lhybnbi63/Lb9FFMckxusPTRtdMGb4XV55+DfhkzA1rTfTQMBudvkPo+ShGyuK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The HWPT is always linked to an IOAS and once a HWPT exists its domain
should be fully mapped. This ended up being split up into device.c during
a two phase creation that was a bit confusing.

Move the iopt_table_add_domain() into iommufd_hw_pagetable_alloc() by
having it call back to device.c to complete the domain attach in the
required order.

Calling iommufd_hw_pagetable_alloc() with immediate_attach = false will
work on most drivers, but notably the SMMU drivers will fail because they
can't decide what kind of domain to create until they are attached. This
will be fixed when the domain_alloc function can take in a struct device.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 87 +++++++++++--------------
 drivers/iommu/iommufd/hw_pagetable.c    | 45 +++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  6 +-
 3 files changed, 85 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4483c06e0ec38b..8dc7ed678e3fbb 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -177,13 +177,16 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 	return false;
 }
 
-static int iommufd_device_do_attach(struct iommufd_device *idev,
-				    struct iommufd_hw_pagetable *hwpt)
+int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_device *idev)
 {
 	phys_addr_t sw_msi_start = PHYS_ADDR_MAX;
 	int rc;
 
-	mutex_lock(&hwpt->devices_lock);
+	lockdep_assert_held(&hwpt->devices_lock);
+
+	if (WARN_ON(idev->hwpt))
+		return -EINVAL;
 
 	/*
 	 * Try to upgrade the domain we have, it is an iommu driver bug to
@@ -198,19 +201,18 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 					hwpt->domain);
 		if (!hwpt->enforce_cache_coherency) {
 			WARN_ON(list_empty(&hwpt->devices));
-			rc = -EINVAL;
-			goto out_unlock;
+			return -EINVAL;
 		}
 	}
 
 	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
 						   idev->group, &sw_msi_start);
 	if (rc)
-		goto out_unlock;
+		return rc;
 
 	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start);
 	if (rc)
-		goto out_iova;
+		goto err_unresv;
 
 	/*
 	 * FIXME: Hack around missing a device-centric iommu api, only attach to
@@ -219,27 +221,35 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
 		rc = iommu_attach_group(hwpt->domain, idev->group);
 		if (rc)
-			goto out_iova;
-
-		if (list_empty(&hwpt->devices)) {
-			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
-						   hwpt->domain);
-			if (rc)
-				goto out_detach;
-			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
-		}
+			goto err_unresv;
 	}
+	return 0;
+err_unresv:
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+	return rc;
+}
+
+void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
+				 struct iommufd_device *idev)
+{
+	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
+		iommu_detach_group(hwpt->domain, idev->group);
+	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
+}
+
+static int iommufd_device_do_attach(struct iommufd_device *idev,
+				    struct iommufd_hw_pagetable *hwpt)
+{
+	int rc;
+
+	mutex_lock(&hwpt->devices_lock);
+	rc = iommufd_hw_pagetable_attach(hwpt, idev);
+	if (rc)
+		goto out_unlock;
 
 	idev->hwpt = hwpt;
 	refcount_inc(&hwpt->obj.users);
 	list_add(&idev->devices_item, &hwpt->devices);
-	mutex_unlock(&hwpt->devices_lock);
-	return 0;
-
-out_detach:
-	iommu_detach_group(hwpt->domain, idev->group);
-out_iova:
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 out_unlock:
 	mutex_unlock(&hwpt->devices_lock);
 	return rc;
@@ -281,23 +291,16 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 		goto out_unlock;
 	}
 
-	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
+	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev, true);
 	if (IS_ERR(hwpt)) {
 		rc = PTR_ERR(hwpt);
 		goto out_unlock;
 	}
 	hwpt->auto_domain = true;
 
-	rc = iommufd_device_do_attach(idev, hwpt);
-	if (rc)
-		goto out_abort;
-
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
 	return 0;
-
-out_abort:
-	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
 out_unlock:
 	mutex_unlock(&ioas->mutex);
 	return rc;
@@ -371,10 +374,8 @@ void iommufd_device_detach(struct iommufd_device *idev)
 
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
-		iommu_detach_group(hwpt->domain, idev->group);
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	idev->hwpt = NULL;
+	iommufd_hw_pagetable_detach(hwpt, idev);
 	mutex_unlock(&hwpt->devices_lock);
 
 	if (hwpt->auto_domain)
@@ -716,28 +717,18 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 			       struct iommufd_ioas *ioas,
 			       struct device *mock_dev)
 {
+	struct iommufd_device tmp_idev = { .dev = mock_dev };
 	struct iommufd_hw_pagetable *hwpt;
-	int rc;
-
-	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, mock_dev);
-	if (IS_ERR(hwpt))
-		return hwpt;
-
-	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
-	if (rc)
-		goto out_hwpt;
 
 	mutex_lock(&ioas->mutex);
-	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	hwpt = iommufd_hw_pagetable_alloc(ictx, ioas, &tmp_idev, false);
 	mutex_unlock(&ioas->mutex);
+	if (IS_ERR(hwpt))
+		return hwpt;
 
 	refcount_inc(&hwpt->obj.users);
 	iommufd_object_finalize(ictx, &hwpt->obj);
 	return hwpt;
-
-out_hwpt:
-	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
-	return ERR_PTR(rc);
 }
 
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 10db1359c067c1..6cdb6749d359f3 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -32,17 +32,22 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
  * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
  * @ictx: iommufd context
  * @ioas: IOAS to associate the domain with
- * @dev: Device to get an iommu_domain for
+ * @idev: Device to get an iommu_domain for
+ * @immediate_attach: True if idev should be attached to the hwpt
  *
- * Allocate a new iommu_domain and return it as a hw_pagetable.
+ * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
+ * will be linked to the given ioas and upon return the underlying iommu_domain
+ * is fully popoulated.
  */
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct device *dev)
+			   struct iommufd_device *idev, bool immediate_attach)
 {
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
+	lockdep_assert_held(&ioas->mutex);
+
 	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
 	if (IS_ERR(hwpt))
 		return hwpt;
@@ -54,14 +59,46 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	refcount_inc(&ioas->obj.users);
 	hwpt->ioas = ioas;
 
-	hwpt->domain = iommu_domain_alloc(dev->bus);
+	hwpt->domain = iommu_domain_alloc(idev->dev->bus);
 	if (!hwpt->domain) {
 		rc = -ENOMEM;
 		goto out_abort;
 	}
 
+	mutex_lock(&hwpt->devices_lock);
+
+	/*
+	 * immediate_attach exists only to accommodate iommu drivers that cannot
+	 * directly allocate a domain. These drivers do not finish creating the
+	 * domain until attach is completed. Thus we must have this call
+	 * sequence. Once those drivers are fixed this should be removed.
+	 */
+	if (immediate_attach) {
+		rc = iommufd_hw_pagetable_attach(hwpt, idev);
+		if (rc)
+			goto out_unlock;
+	}
+
+	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
+	if (rc)
+		goto out_detach;
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+
+	if (immediate_attach) {
+		/* See iommufd_device_do_attach() */
+		refcount_inc(&hwpt->obj.users);
+		idev->hwpt = hwpt;
+		list_add(&idev->devices_item, &hwpt->devices);
+	}
+
+	mutex_unlock(&hwpt->devices_lock);
 	return hwpt;
 
+out_detach:
+	if (immediate_attach)
+		iommufd_hw_pagetable_detach(hwpt, idev);
+out_unlock:
+	mutex_unlock(&hwpt->devices_lock);
 out_abort:
 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
 	return ERR_PTR(rc);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 84fe19a195466b..331664e917b771 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -255,7 +255,11 @@ struct iommufd_hw_pagetable {
 
 struct iommufd_hw_pagetable *
 iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
-			   struct device *dev);
+			   struct iommufd_device *idev, bool immediate_attach);
+int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
+				struct iommufd_device *idev);
+void iommufd_hw_pagetable_detach(struct iommufd_hw_pagetable *hwpt,
+				 struct iommufd_device *idev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 /*
-- 
2.39.2

