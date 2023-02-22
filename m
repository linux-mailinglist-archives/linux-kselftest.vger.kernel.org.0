Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810BF69FD5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBVVCy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjBVVCx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:53 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B2E449E
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLyOanHSsvniBnc0Xk2VBB4KOdn4eROONJCQyJv4IVeGkyIDJMio8jIH2ctCAy7EMf0SRUemkfxHAIzFJseQ+GFAyLSfDivV6IBWYy+0xRwbvDJEL0pVsaGhX3kc5zUmK6m2DPX9TS4s60BYTX6U7811P6PLk8cKSN1DFUAFdvv/uDc+D94go5bYOwLXshy1oj5TBOM0KUSZaZPzlDbc1ErFc22mN/8Gdl3e/wt2RwoPc2O2VzZt1qjZWZvQR8P2DQ4PDUq1YerbUO2s6MOGhxfvcpno3VOVGiLl5gQtZy1GCXCnnq/8drQyPZi0c2kJ2fIhHz7PAoevwAzhYxCIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm7onPlIlwvUJiAOC+X/bjrbIfdQi/Bx/CsfkN+a6sg=;
 b=iw6Nycc5N87TZk1EdkAqt/vZD76YXNZX8sf8IiRveMsLpd7V/sMQwa9D6zyJ3s1Hfgd5WjQVb90zyjPz4k+QCwd/TYAS+xb8+Zq3Fswuue3L0/YEc50SGBDP4wNWcC+hg1YYpiTUi5LXelGsBBymy7jeAZu6WePqtrNpCbUr71EiC68PgsPGMvqy4iH3blLm2WowN0b59si+ygk+rhziaMopo0ePEPuBkG2KNvflhADOEGbw36JW52F0J+5JrW/lA8+jQUC3xQ/6W6xAp8g6qdq4lTUxiHILySazmFgbmWAc4nJPDXEkwnhg2Op6Kgbbzd6h2TWQjaacmF8rNBzoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm7onPlIlwvUJiAOC+X/bjrbIfdQi/Bx/CsfkN+a6sg=;
 b=pxSNrDNKzMhpFiO1g+Fjmw9QVEjmb5R13mH11q37xMqp7Rh/URSoxSJtbATVO8UiJt1VogrlTPRDJbDcVkBoQqOfFzAiKPF3Gc6gM0+xa8643UUSCKdpgFCYt5bquZHw2RkEuuG+v+fTkrcm9SxwwM/WTBkRoMeXyM2A6W6hykvtPcL97oH313e0ZtHfZuHk5Llh6pxQz2rVkPN2j6wxBtdMZ31u8OLA/sPonnshbMs8xRIwtnvitzPOptZJdhm47PF6tMaS1+ktDyd6OXhVIK2vSio1D0Pihc7/n0Z4bFn00HIQXlGYgyj+7yt7OujBeG5LtS57o8vJh7yRnn0gIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5395.namprd12.prod.outlook.com (2603:10b6:303:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 5/7] iommufd: Make iommufd_hw_pagetable_alloc() do iopt_table_add_domain()
Date:   Wed, 22 Feb 2023 17:02:38 -0400
Message-Id: <5-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:208:e8::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb14810-9f72-4967-55f2-08db1518245e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqP3Ep3Yp/+dBkDxaEpnR+AHcse5lcjYvBMpG/y9OXTRjMtSZsP2Nn0VSYf7G3AG+NPs7Etax/Ja1uAMlXMYAWL3+0reP+3SyIZFLW57QS/26k9AUHwVERaWXYf9TzHR4ujpAL3S1HXSNPrGgO+HiS7TDyqyIuRQ5ut2KjF7VGfflFsAwy2s/uMaTiHKloB7d9nPeoWsFuZi6iSYBPkc/v5lY7q5fTBJpqgdAeKIxlyyFybIj31GFzOMM5Np94Ys5YrsRGlEfmBEfiqzV6EEGPEmuadaJWBiDXmeW1gMXOFrFzuaU9NzjQ4fViLYIZ6ka+0hRQyB3JrOq+qRiz+knvjZGMmWPVczsPUzXjT2T1lLElexOQRqtKHxUjEZF15I+c/d3mCQ+trjNm16oXTfgSD5RwCeBpawHZ4KaPHw6CAO8Dgk5q1lL3GG5pZFxLegKd4Emk+n8QHzVs50CmvIybRCRzd2iByGxhIJDOPFctf75N9JbqbBhjCaNSD7plvvHR9eCwm6kBWoccbgz/XGaE9SFNlstlF8E8WwMiH7ARTSM2M5Dr7BPcjvGsDKfFf2TPBucYiYHFGspD8a09NaLKfe60VitZP+y2+nw1lPUmycY/wmZk3rjb9upLk2cjMcUAQyVvGvWUQzOuSXal/zkXum95xb6emNpb6djemd4vw4l53vCn1It9MASoo72uqn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199018)(478600001)(38100700002)(5660300002)(6486002)(2906002)(8936002)(41300700001)(2616005)(110136005)(54906003)(186003)(6666004)(8676002)(66556008)(66476007)(26005)(66946007)(6506007)(6512007)(316002)(86362001)(4326008)(36756003)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJ2jLeSTZlLGJJAP+TlhsdL+auzyr1WZGGtGHZp2YIwZV2pWUDHySpKm6ixQ?=
 =?us-ascii?Q?23ji8/qusUGrslvU5ImVNO8rf+cSDklHjnSQMsIiJ8HdM/rNAzfVy2WrlTN6?=
 =?us-ascii?Q?E76LWZ8Kxz/etdqh8T+bCSvRbMXxz9UKKGQq0och71KnSKvxcAywbDRBSwwL?=
 =?us-ascii?Q?wGmIoV2g/fzbCBfiF+HTz1Vocw40ijPpzDB4zlvLo/mNbRj7ZhpIDDFRw+je?=
 =?us-ascii?Q?FWFNRnm+YZwpkniDKKwLlnFOJK4WrhS0Y505GFhvVcdc7tqZ4bmJl8CeSdrQ?=
 =?us-ascii?Q?8K0Jlg0zfUkDc3GcogVFLY2N8YReiDK5blX31PzsEEFZrv6dmvVFUzvC8lNd?=
 =?us-ascii?Q?l7MxuO93SILGGEpGkGF1/9ViDxJ74BSEyk8eepMbj5tOu4MLTyL7PeM5siX3?=
 =?us-ascii?Q?FjoYv9F+kbE0HS7rcDYCSo3yVI0qFC6RSI3wN06F6MqBuRWmUHAeibcPHR3U?=
 =?us-ascii?Q?JXQEnsqNH/i917+lBYbHKWhJenDi9WwB4RbwmDj0glIVk9LoVltYb5cargym?=
 =?us-ascii?Q?F3K3MIQvJZmPAIe2HVWofzCol3SoLmZIQUKPpinBuVNzmmCEpoO/BEsF0IZi?=
 =?us-ascii?Q?nreVTCAV+rd4i2ghD9kWVFisH0oS8Oi24/lpxOlVLEaQ6bEmBb6T89+RviAE?=
 =?us-ascii?Q?ofsCw3DqrsZNGel16pSCeXSsMEmVzYg2DBm2yKM7Y8w5lTHQb6x4VsTo0vMi?=
 =?us-ascii?Q?ubtgUCdALG1x7RtDx32z6qZp0nRE2aK0TaU4f937lAIQuyxyGUgHX0j3xW0D?=
 =?us-ascii?Q?CGd+Tj+5NX46kdcnz3rXuAmUYkCnRp3/y0tO5auCi3F+qw/q7ULMkesRrzzX?=
 =?us-ascii?Q?l6WAdVOQpj//5HHBJSr3JA7cJrmZ/skIDOdGH85i1a7DZmax9K4wGrKHuV1k?=
 =?us-ascii?Q?/qb1o6KzfIhUFRldwJtooDqyxcRLBYATnEPu7kbADeyTuO9EZrLmXHKnBSAA?=
 =?us-ascii?Q?FoLaDcEExBlDRyRD+NP7iAykzjp4dH5cWZ/l1LynSTCFPuKeCe1gs0q9v2Jc?=
 =?us-ascii?Q?svJ3F2yjtn7f+n8KQgE2YpmIo3XDW8w/MhFzFnRbUllMd5UxPUX1bt6ljMdQ?=
 =?us-ascii?Q?LAKonnA22acsDByMl/xWnRnCD1u+T6H/NtBjd6sN0Wbp0rL/UmcetgfJ3HG1?=
 =?us-ascii?Q?yfIT/ojyJRd0tOskTFWFwiJklAEeS5I8TEWo3WxSQBa2/9ycgBB2fxJQTj1l?=
 =?us-ascii?Q?pr9GtXbJPktLKPPgdEq+tr8GFWtYUhlddJGUCmBBLiOGQoiMYDfEZRVtPpHy?=
 =?us-ascii?Q?iM7qt5qN6Fz8Pw0pToVLm94CirEWhzFWyJWzx+/D64zo1df3OUz6e567f1ae?=
 =?us-ascii?Q?msDvmG1/mWzIGpqxJe9soZp2VB4rowFgZL+CR/Dk4NVq5TAyih8Xgq+m9h+1?=
 =?us-ascii?Q?gQKoNe4eXSmbuWZTPOAimbGM8ZfQUtAM4lsfDgTyWP74jZZqlTX3nSk1HoX8?=
 =?us-ascii?Q?5PEZsXvMh5OcFV7GzqrmSJ2q4J7UeSgWN1eDGF8xipneaVH0jbOVIik+7OuD?=
 =?us-ascii?Q?jzZXAxbrjzg6udmXQqA28EdmTaxwDefHFFOXJ7eS3njoI6BOhxJ+UDdctiW5?=
 =?us-ascii?Q?oLorDRX9O31gG5lNYb+3KagK3tupyTVkOIle7Hzy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb14810-9f72-4967-55f2-08db1518245e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:43.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Xex2oSsUUdzxS/c1aUXw79AVGpQH4Yg0Dv4I5fK3uPshUf/z0mcwYg73a4qMa4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5395
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 88 +++++++++++--------------
 drivers/iommu/iommufd/hw_pagetable.c    | 47 +++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  6 +-
 3 files changed, 88 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4483c06e0ec38b..cf2517a6472ff8 100644
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
@@ -219,27 +221,36 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
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
+	/* hwpt->devices is all domains that have been attached */
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
@@ -281,23 +292,16 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
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
@@ -371,10 +375,8 @@ void iommufd_device_detach(struct iommufd_device *idev)
 
 	mutex_lock(&hwpt->devices_lock);
 	list_del(&idev->devices_item);
-	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group))
-		iommu_detach_group(hwpt->domain, idev->group);
-	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
 	idev->hwpt = NULL;
+	iommufd_hw_pagetable_detach(hwpt, idev);
 	mutex_unlock(&hwpt->devices_lock);
 
 	if (hwpt->auto_domain)
@@ -716,28 +718,18 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
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
index 10db1359c067c1..da1df54877f43e 100644
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
@@ -54,14 +59,48 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
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
+
+	/* ioas->hwpt_list is hwpts after iopt_table_add_domain() */
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
2.39.1

