Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10C06A258D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBYA2P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBYA2N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18591A94D;
        Fri, 24 Feb 2023 16:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCh/TjUh7EfmZSa83boPaIB3cLOE9vV8UV1fJYVQxGEl7jGu6kVQaayH1AfwY5mcKfQHWjXnjc91SERPvukOSXd8xummzZsRbAycV5nr49tagNhLKaDJkSkWQX+9mqUOebULUnqrjeyoMKEmOOFmlCYYJZzuBRpDVUTqn5rcPZs6jxU10N/o7esfntM/11SfnYyhPeFnqHZ69YyoGnLALpUqoKOny79bYawWR86aGEXSeQzsCKFIKNrBsWbzOrHYYszbVClta6cacs1BA5WAc7t9DdXtTveJTWVn83KvbhY+hZdjF7DZXlAa1oQaxXqUBbFM6JMb17SRyVxoHQYNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR4vk97ODvhdpLx7DKr3vsd678K1TcH8M0VYT4/Fyww=;
 b=O92ImgNPHChwlgyk9TLK5uISTXXjbkoVirHk3MszrMGr5iZJPcevavwKvZxW7/Whe4/43wc/Pr4srOeWkScoflaW17FHHy7npuIO5QsDNQsKscvrabOto9t5l/IlcR8Bv3ZeGC/J7IzoCZblF+9YX2an4j1EsIdc8Azrh5NJhJIsBUmoj8eJbKfmfEbRf07XOVf6vMmxeeZElfKxiFSjVZz48REfK6zxY8KiN0ClR3VwuX9+zacYyRhPYJb3pL43RwxFTxinULVoQ77QZufB1emW1bMreleX4OGYoxRVk5FSnKRxNVvUYY6kg2ygliLlT3X7vVT68I9SiesFILAPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR4vk97ODvhdpLx7DKr3vsd678K1TcH8M0VYT4/Fyww=;
 b=ba0O1O4oXrQQkpT/VNrn9iiMxFS0gANQOvcMdhUa6VdpUv2J7U01HSkA7Pr3vkrVMFgr3cywGQ+K05xhRsWL5pWVOwLG6D8IISJYsusM7FBwRI7m19iSjmnX/XU5JeI0sN6KUYLWFV2iOftFu4s0CsDThHYF8RYjESPwaPiNhrdCWhx30kIKeNe3vomv4A0VOPA+9+mfjaZ8pIi8sFe2QT9CJYwXyLbaSBoQ/BInwVe5ykzUzI8atu/foYO7a/QHHepZ0149OpvxobMBNF/228gyf3wVDbN4wTYzBivEzuxmiVrVyP/5o0wttIJRAwamEZD+SH3sAtktwo30I/kZHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:07 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 01/14] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Fri, 24 Feb 2023 20:27:46 -0400
Message-Id: <1-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:208:32e::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f88df7f-92ef-40e7-bf48-08db16c727f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQB0qUteDV+li0Zg9zOpnOQca27fNE8loyal8l5mxGSavghtcXpm/SV0LarHbBxEAxKuTIyFeAOx/3X3BOh5cJvophEgtoW6QVqEFUpdNRuCDDX/18KKjlbyNTHhyLPRMRjNNOpxaX0UG0OJS5+rgtCkkgjzYFJ87OJHiZWrnSSIPgik69YMxLAkMw7pd67G7OL+ubixI6cNNNp+4WjuKaEIQMayWlceN8HlckfHJjhSncxgqANsIxO2wucZWQuEDUUK99zRGiyDFiztdHXLFQLzBV5wuSJmBW9zLB34L+AQHWY1KkLbHthD7MA3nxoIb/8sViRBpPa8aABPPmdtalasMR0o3hTs5KspPSHaW4Mw4zRXiKi05N1XWglWOU1ozxKbML37tQrM+MqP3SCJI1BshjqCQ82jlIinjz84Fvj7MenISgnSJpaOUEPwDVvaxVHiG6TeeXNgtq2XOBMUWepNuQy/rPI+XYoKJbzA3OiebLhWDQ9qTOXxO8Fwc8wLooQh5ZRhFCi10or7/yQMxJZLZ10Xvy/BiaUBtHwbzDo0ZfruggcHZ1ZWA/2f0ADABSWbVoASdpy/maTF+c94I2JGVStTh4tWdasavhktbvTrw5Dys02WFd0S89tEAUBNbqkdrc0tfnKnAsOCH51QFr0huiFQzqvTqmhQyJBDVz0LCL8DJ6Xe2U2HzY0Yrrt1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(54906003)(86362001)(6486002)(6666004)(26005)(186003)(66946007)(2906002)(8676002)(41300700001)(66476007)(6506007)(478600001)(6512007)(5660300002)(66556008)(4326008)(8936002)(83380400001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2cAe2tJddDrmTS813qmWI+6UG/5+WQ9bR+j5zjGu89mYAINNAFiYWbcFXl/e?=
 =?us-ascii?Q?V4wjF4fksW2RvGoE593Et8Ns/of+m7o54B+jbP4REE0GW4iwNbYXhcfkihYP?=
 =?us-ascii?Q?KVLe7G+Ts8WTcLaOxNj7W5HV2qIwF7agng1+aRcpJQLL44mnuilMkmFry59n?=
 =?us-ascii?Q?LKu+hjycunMFcmwi6G7uCIFu+iA0664VsG/clhtKeX8FyelemjK0bsSQneSD?=
 =?us-ascii?Q?+UftzC4ZInCWRetWCidL+HArQc26L0mETrDuRMcoomIY9U3cV1BTJCguGZs3?=
 =?us-ascii?Q?V/h82BywPg9IoYkqIG2YAMfT9z+vTAMnQygh5dpbNF3scTJjMXI8pkvw4q0j?=
 =?us-ascii?Q?3aFDPVBh8ucI490iKHuINuxkCC9oRrrB+yivCuZwL3Z2D1pqScEGl+8cpNN0?=
 =?us-ascii?Q?qKRYHGZrstK7SC/aonYCeZp4RTxOUEKstfLHA5TT7KNk6oqTCNH3KrhUsaio?=
 =?us-ascii?Q?NUvV7Rk1OonrfJSKjyl4SKiCiz0IAwLpCG/G1eD/UoLViYG6Tni2l+lJ5NFu?=
 =?us-ascii?Q?TCFTdVUGoqOdifOla63560duggGIfbArk7/hqr+gx4egojjDdAmiFUNXiWEP?=
 =?us-ascii?Q?Qbn9cUyTcHxCVOBr6gSx272yorEsrEbKkqFYmf3/OJiX3iqjHplroBlm6QCe?=
 =?us-ascii?Q?GXGxtA/Z/m6KQNms5XxBXPSk7M0MKY2FX/8dyIZjvM7xcesx41jDOq2NiOva?=
 =?us-ascii?Q?ueiBqXELc4QIUHT1CxB2uE9KavIi/SLN2RtkuaXgMmq0E4w7u9y4v/a0ugGh?=
 =?us-ascii?Q?b2SbTrVo4b9WS0/aC6InJap1QWEXp04bCp+tf4OUdSapX+Iydwcto2TUt7py?=
 =?us-ascii?Q?E7CztMQLzrX55y5tOTfYco19qnQ+jIP065zs+ccmPSTri1R8dmPtrg6HNAkh?=
 =?us-ascii?Q?n6nykX3Sc59XOCjIBkVqLyldg/+uD5MhwWrfZtIWjQVGIIaN57ddTwvVtNd/?=
 =?us-ascii?Q?4fwDnvcY8juzMi4oK8RfOdaGx52IS5d/sL0vos3yXQHwGWHZJnTgmkGh8136?=
 =?us-ascii?Q?+4P6M1bB51Sm3qTD3Al4nAUEOaug/OsJh3r8GkoOBsUZOlGcc0NP396hma+1?=
 =?us-ascii?Q?biaswttAOBqAPhtHbYLQ8AQq6t4RpP5V3nL6xxdsx5MxOliogCXsgL3Kq0Xy?=
 =?us-ascii?Q?Yd7JMNHxxk7QCPuCEj53Uj0Y6PMWZNmWl/oTnidiUqdE4Ul8Qr1Gk2Tqzp+p?=
 =?us-ascii?Q?b87p23W3imPfmtmIePSrAp6SjOdZMsz+6IdrziGB5Gkgfp4sYbdDqyLh8bj1?=
 =?us-ascii?Q?2O+c8BBiUrCq3xaaDrxN76ClNO4pUsCDFx/PRw9IYR4QZSxpqmq1QpxA6x3Q?=
 =?us-ascii?Q?4PyMgV8ITuyRxoULCbyQtzA6SA9yO3kvaEkE6ZcW0M4kSzAPyyViWhkbvZpj?=
 =?us-ascii?Q?S3UZUbyBTS+Glcyb41/eVfgueqJxGikiFsc+Ssley2po7bvlD1oG9MlnxOpd?=
 =?us-ascii?Q?QlTBYCCCFGOSclGoQRQYvodC32JqIlbHZzZvTBU/pnFiXSd8gI0mClzeaqgZ?=
 =?us-ascii?Q?28zPpsSJv5JTvXO1GSX+ChsMJJ1mOymPbIUE62So+OpcB23LhO7fUr27MXJm?=
 =?us-ascii?Q?eHJLgp9BlrvdeGFQfKlD4QCq4/rV2UkJ/8bgHTuZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f88df7f-92ef-40e7-bf48-08db16c727f8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:02.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEh+6UD2+meeda1kN9ESgeo51l1uvukQqDSaaqD5Ip75BFkPnHVHYuU2yr05jwkZ
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

With the recent rework this no longer needs to be done at domain
attachment time, we know if the device is usable by iommufd when we bind
it.

The value of msi_device_has_isolated_msi() is not allowed to change while
a driver is bound.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c6f4852a8a0c08..63b65cdfe97f29 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * For historical compat with VFIO the insecure interrupt path is
+	 * allowed if the module parameter is set. Insecure means that a MemWr
+	 * operation from the device (eg a simple DMA) cannot trigger an
+	 * interrupt outside this iommufd context.
+	 */
+	if (!iommufd_selftest_is_mock_dev(dev) &&
+	    !iommu_group_has_isolated_msi(group)) {
+		if (!allow_unsafe_interrupts) {
+			rc = -EPERM;
+			goto out_group_put;
+		}
+
+		dev_warn(
+			dev,
+			"MSI interrupts are not secure, they cannot be isolated by the platform. "
+			"Check that platform features like interrupt remapping are enabled. "
+			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
+	}
+
 	rc = iommu_device_claim_dma_owner(dev, ictx);
 	if (rc)
 		goto out_group_put;
@@ -146,24 +166,6 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
 		 */
 		hwpt->msi_cookie = true;
 	}
-
-	/*
-	 * For historical compat with VFIO the insecure interrupt path is
-	 * allowed if the module parameter is set. Insecure means that a MemWr
-	 * operation from the device (eg a simple DMA) cannot trigger an
-	 * interrupt outside this iommufd context.
-	 */
-	if (!iommufd_selftest_is_mock_dev(idev->dev) &&
-	    !iommu_group_has_isolated_msi(idev->group)) {
-		if (!allow_unsafe_interrupts)
-			return -EPERM;
-
-		dev_warn(
-			idev->dev,
-			"MSI interrupts are not secure, they cannot be isolated by the platform. "
-			"Check that platform features like interrupt remapping are enabled. "
-			"Use the \"allow_unsafe_interrupts\" module parameter to override\n");
-	}
 	return 0;
 }
 
-- 
2.39.1

