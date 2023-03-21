Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F10A6C3A21
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCUTP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCUTP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E0E6E92;
        Tue, 21 Mar 2023 12:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS5baFj8afzxTViWgXRAiYiVmUcjE/UQcEbCfwM192Ka173FcuzmNnqb88LA65rMzEs5wJOKqyycSJVwlDGau+FYrzF9Zm2dLg+CpfcZY+cRk8TPWArsQrG5Hjkfb7Ukd4ydbq/xMu55k1v7Gkedql2XYqZ6ms7o3RXhyLowv5QgbhkLnNLvNvAUgEbQUAgqIYO6QRBIPGKEGvOc19O2StBnnMlVg55awrfMOjbOYVuSvgOkFXkiFrad2FatCSS5iAfm/J/Dt+18gmqKQUGvYlT0P5k1wV4pyJcR4TEjt4kD5BAAH2DonLBMIvAdJP1U+AVNa0xedVwW0C42HJ6wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=kIeBR0IwfeOH8L0qA5D9DsFC3kuh/FySP8JJjUkiYBVYGraiJx96zX/74WrfgQXNaThDUUqxnR8XNusZKLUbRqkJjR8wiWM2NIDp2pMQKCsRXYp2nGm1p5eXYwJZ45BMZKnIfUoGmRVHCpd48Ej14lqjMr0RZgnyZ7bjzOZ8abJUk0moZJoRphUG6vJi0dskGSEd/AkyEs5ixmqZYGmO8CXBCuQABa5sf7uFXn/J1npqkQcRBYOqqob/fV/ql9cZSnF5mrdUqhTn5yopoyIQImUEWkzUkpPTL3ICFIj75cog8UCWhnsRT9xbBnoqA11YwrNvAldXZAj0sNLTLm31XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=CievOD91tYlo9X/edqbCUs+0YUukG2L0WbDRVqeNm8yRczui/1xXEO7Rn/+3Piz4odn0lAkwIP6Nu+53kY9ejpCXRUUT/8dYHJWUDg4pxZQE0qDSwMgCx3RaR5wcpP9Bd9bJNOaYecYbd4OIefvxthKModOYp44c+gvp+1B+FWcwJBnpBcu5sAqMaraWjcLuYIXQyrpq8Lc4PE8WT+2KfCrrqqFYSjpW9a1EMVqL0bFLLo20QA1FagD44d7rcFm2BhvBnPhro82p8cBLEEkV4vSuyLlna1hDv72TXhp2qvmStlzXbEEYegdm1Y7/uSRPBDmmamQ7RVNcRz/5QKovvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:54 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 01/17] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Tue, 21 Mar 2023 16:14:35 -0300
Message-Id: <1-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0311.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b6600b-84c2-4d5e-c2bb-08db2a408c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8+pmTeqAjJ6qaAfZ2SMV1oCEC/dvKNavtEpqegg9FeQSQNY9gQ8nNUiDyJDlxS4UUkvqxGWnFUFgabsrIG9/obqqjljgcKZ/F97FTPJ/pReB2dmTor2pVMdnP6ljG7dcjaf2Z1VG77RZkieJDVlr9rQZ+dmBXUB3un4j/xfwnOU6KBXPdGFHASThXLhwCArKQOV7poILZYI6GfG+YnyCZQtM7BLNwyGC/BeiSR1CUhakgewDsJwWTgkKuKMH8lNcIdS2Ar0ZeVNNfxTNYOWg6Wt9tSAG1YXgrPXUOsqmzTgupMFtiN9UiTbmIybD5Twv0BAcVBYwpKip0eJgSz8RUSdrqKMazP1ILwembwrMBnDQLyAb31TRXV/JRRBD+97eiKjCQ/laHSUSBKyMz9//vDKiz1Jb1pONtJO/hDyrRMuCpluD58VBh5KIfqHgNaG+5eFFbUtTEb7RuMVra4Ri20B718WZHvc+SpjdDVZCQtoGUwVhlthEoxAdRQ5bIcaYflszv+a+TykoRWjp3lTPQiVmX4VcnMbSMqhjo3PiI9RJOIqMideMjWokUPyIrqYAj0+Us7+Ca3dBqrvbkalHcr0ThgL2YxmSSc8Gf7wadUrtRzvCRAxBU3VLUgiG2KFN0lgZRB0eF1hkcbi+zR0MrGELppW2RQ1rDCNOAkelgsxs18LWFHhZfDrpdua9PFS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5uYEVsvzsqevv5YUp+1UQJz+vVBhYwrU8o9lL/Bj25Udu2yUCcLU07KHu1Uc?=
 =?us-ascii?Q?gHqE9G+APONizpUyPPVBb4hasqVS/ZC106s+9vwCyIvC81bwU3qzuhC2AbWL?=
 =?us-ascii?Q?qEevJHTs6QyK2ifGob4/TNmgBFJ7Nkb156OC7ekPGmpRf6QtFwH4Jg0FoLLD?=
 =?us-ascii?Q?bAYQ7TOxs+cMRJYfHQj4xlXmM5oei//1AfuqSOsVfsKKjwHBg/Vn3kS9vkGq?=
 =?us-ascii?Q?GmA1vOnVIosIBCdOVEndvOzUMbsXaNix4khR9V5sx8pym0E//VaYTHZz8vAQ?=
 =?us-ascii?Q?8R4BYDmpYdW4iyo2zwazLahw8R14C265mGTh6B21vXZRCBWwVFbzEoQgSxYU?=
 =?us-ascii?Q?ndZZdvhYE9L/MqBUIyUVnIfQGpDxWcvI99e7sQRD1Ftun1FYEI2qlvCikeQ0?=
 =?us-ascii?Q?Skl8gDox34CFscwhWlcMrzbMW6xndAuIIwP/b8E7W1CsPD0goUOq6xSuCdj3?=
 =?us-ascii?Q?BYw3FVTZtEr1QvxjcDKLePFIpfGXqQ/o1VABj4Ll7h0ViyX1quI0g6cTtDTb?=
 =?us-ascii?Q?fbuqIIrD+rFtc63PtQccmYS/xgh4UPpgmGw45rWY89v1wXF9rNjJC2Avnpzr?=
 =?us-ascii?Q?TZlMu0G21u5w/UvugSjV1cVB/8Zww2Yri6s6JeUNU+TpRbkYedpZCn37iUD7?=
 =?us-ascii?Q?lOS7y6l4CNdSZWbXZiMZOIftj8aoH6f+xqQ50mmTb4ECmv8ah+TgO0BM2woj?=
 =?us-ascii?Q?1SecPaONTy9mxyp5Lw77DQX/8lJtD7FuapDfnoiIm6G25jDjk5SGurzH4wPu?=
 =?us-ascii?Q?P0uk2mFzO1vI1mbCahps7vYEZqPKSuUGzE98Fm+CvEqBzRGOtNZbPRIS6Xct?=
 =?us-ascii?Q?9VKm92zJAzbPJay338dXdRMdxYjsUF0E/T2nM2sghMErXwJSHUDYEwYdtWjq?=
 =?us-ascii?Q?6OaXT6r09SuxXUrJ2DOZ+rOzRN60/4UsuaXbkfYLhniVMicOBV+8eUWRKuNb?=
 =?us-ascii?Q?phmOBaxSvgzxmf9JA97JjBjdvSsfkF+wbB4KHRD4EjZi9+jYuLowGr3DbVwB?=
 =?us-ascii?Q?4xlx98tiX6OhukmpbO9s7qzK5BQS7kg2Nk+jSNas0OIFuL6vf8RIvDzRmepf?=
 =?us-ascii?Q?WaXDd5GXjpdoCfb3scXgA+5aY8rcJP+qUUbL7NZrJE8KHIzXplrYw10j6Kqq?=
 =?us-ascii?Q?+7baDuuFRK96MUPc0DzDvAjbdMgBzhYflSs/uI5GEEUPpZvdwfKAvgL9kTj/?=
 =?us-ascii?Q?Ho+wOVO83/ImEIZppx5MMcMvHtPy3u4cozzq3F595qjQ2rY8bq0qOMDBLZQ3?=
 =?us-ascii?Q?Vqyooeg2KR9w5DyUw4csiWnuCs7EgF59MQf5UB2O8CG+HVPA5G+ghjubLyY3?=
 =?us-ascii?Q?40CwpWBMJgluoX86S+cK17nM76nmrzhrWMImVph4WMt+OmS8oyjAaSjSHJ++?=
 =?us-ascii?Q?oC5QnDs7VQSK91BEgVhFPIwO/S1TPD6VBjnR1AW1kEDJK3HBr/UXMFLjbiYW?=
 =?us-ascii?Q?sx/1Xgtz8YMeWe5CDtL7YxjG6WkS0kgiSYNqK4CwU8dS+LjJD9YoTqxnVSmk?=
 =?us-ascii?Q?pOuQXSYwQiqbg9Eend38N2SjJnaGt6V9jbiQ6ChtcU4g5LTirRjR1ZyvxnV8?=
 =?us-ascii?Q?ZrHziEY8zBEu6V1LyWfI/FlUs6SL4G5Kg/vQj0dK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b6600b-84c2-4d5e-c2bb-08db2a408c9b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:53.0858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5o8QT4bDGcx3VnohrYzcS3eQnuapeCe9nG1kbCjk3Jne6lJvD/cEpmiRhl7xy1x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index c6f4852a8a0c08..e66303c17c894c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -60,6 +60,26 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!group)
 		return ERR_PTR(-ENODEV);
 
+	/*
+	 * For historical compat with VFIO the insecure interrupt path is
+	 * allowed if the module parameter is set. Secure/Isolated means that a
+	 * MemWr operation from the device (eg a simple DMA) cannot trigger an
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
2.40.0

