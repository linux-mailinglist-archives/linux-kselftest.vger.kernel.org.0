Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602716E9C16
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDTSw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjDTSwi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5FF4487;
        Thu, 20 Apr 2023 11:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJAfP6ySVb71QmvMvknnXHQWkM2ygqRiEbm9FaUE/n8if9RTxuxChydr2LmIeX8nLjChKmlTG6tqikDZKlFQJ2LDjKt0n3DgvJ/4YjpcotuYWNiWwX9U5eZ0/xBo9xt8TzXI/E9oLaYrPpFuTm8SBo/4nnzRP0q/9/Dw4pn/tSVzrT1y6aDxvay5JcS/0to8wVSewQLQCiSLA/9vBD47oMB4RishySWfJVCmoZn2aVGBDQ7jqgV1EtAnm73A6ySo1V5Dbrc/ns32vdwDQ8FlRF7Y1UnUZfPSPTcDxOXOpCBAPoeodrcPMi7F7KLU3zAnNRRCOa8SgAjBK48+82wXZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYSLPWKndciQVJbztWQI4cCGJufjw8djgHM44HQUGmo=;
 b=DUmOLtyuY96E9fy49/lBI3O1J+O+Rm5131olYZZAb2W8rayhl+rwtjrP/zKSwM72OtKznHgeIjnea7PcwZm9QFjPJgsr3pOSRK6sR0DihH8wMb+h+/Gb7uDdBeIe4vZv8zOFD0CHgfeiEMMaQ64ctkDTaJ0/IJrHSVSibCM4i58qLaQnvdAlyUtHJxEd3CkFfmXXPcfBo91yHsxyOkwf5L4jf24Bvs6wS4uWIiLy4JhYG/e9AIrq1nlyoQEblc8skOml0JLBSSehHLlJImpPCnBDXJUMQOziDYGv2EHJymKhgiDNPUVPXjy0B3Nb1pxIMkxJYBOrnMkKO+P6Jh0Ngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYSLPWKndciQVJbztWQI4cCGJufjw8djgHM44HQUGmo=;
 b=ozLQO2fC+eg+pMzBUJe4pq+QZ072u3X9FB9GzTSG4EP+rNbmUmiPmzoSG6G/VH+Ssb7mj09nkkYzl1iqYA4AR5jWicCPCsoncy1OINNvFVRDapoqlG5ZGGX7Vz3dXAUXd9urrlYom13C/fkr/N9RN3hqawAMVBcWmucCWD+o5Sm/B54pZoRlfbYgfNJRl3WHegLehm64ouY2OVJxHi55HV+RXajW1LMTMgToqbX48+HcQ3OzJrAhUD8yz37ndXG4xag0mBovy/BMXk5Z/vGlozIiWGbXBbQN45ZlXir5gHaH7MFko5LiMWNha0gc7mausba3gzdULujpFfqNBMswOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:49 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 11/19] iommufd: Fix locking around hwpt allocation
Date:   Thu, 20 Apr 2023 15:51:26 -0300
Message-Id: <11-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:2d::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd85004-aec0-4196-4046-08db41d0467c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItZhLMS6V2y/BF88VFq9JVDkibw6JnbSnRSx22qLe3sWoysF0leeUmZlez/rubwB7eFeJuBplZckws8FOzgQ6/66LpT2MyeNcbFVEophIlnHq64SyY4cdggC3UxGRvCPq5v5RSyhNZQOJpgcAp8A2xmNAkw9pA+98x8gkk6MC+bEiB3WnUcsUnYNmmhjpxNnC3IqI9u0FowwdQpIpRlYcekswY7N0wVJyPsQ3Kf04JfIA4ppyMYGh6+6ITgcVQDIKSTKG5tgTsT+ylorwsl4OCtMR0/OwKvTvFXSWh0NM+NKVn8PlXqY5jtIDV4f0idt1/EbK9WNWW1ZrHyALFNPzpIKHSkTLeOQwQsy3ejdhKqcVqqOnh5dbEzjexJ3oFPnXInIgJDnI+WSoJ66eh6xnxLG3gQ5Q6GEbKpUFxLwCDDbhTO6K6ZB5usVUIlDzLqgBgtnpjXkfTtW83G4xT1RMrR18SWGVPw6owtha+AOfL/UDCQR1AKCCWkLK2fyAYqg/gypi432D/2VxAl/ZMHZNPiDnAS4oU+Pmr/M6ep+Qy/6hYUKpaBkYHFX+KJw3q4A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzEjn4zkxlSFABR4LiYoWUy1fsL7JWlYXBsT+qVL0yhFFqhi7gFvnw09xC26?=
 =?us-ascii?Q?PA+jy/0jJ3ShVQNP+vdSz2Ba/iFd52hFvQ4lrS+/jJFz2SY86o7dLVsVgonK?=
 =?us-ascii?Q?5/I3fE5StcNQIujZNcduI1Zsg0HI8dV0HZoT1uevBPGY28KTpWpfjzNj3YmS?=
 =?us-ascii?Q?8AarMDIFPmLRgpBj9qO0cetRQuWJlpyH/Wt5rhip89Vy7W8BN9aLy3f9GT37?=
 =?us-ascii?Q?/6RD7w+ahC9CclWPfjBtSIaXx55Afx2/dradNk+y2j9vdxkXkao9UGC9M4UC?=
 =?us-ascii?Q?8JjAKfXuyv2aXbHdvMuW+sQDrf/2qsCTTnQ5bp0qI8CLcn2xRvcETBdE2sZq?=
 =?us-ascii?Q?KEi18IRlPUdeqhZix0Rm524v6XKgBHla5wwRXzL/5qsd7WpwerO5sUKweMv5?=
 =?us-ascii?Q?tv2Nm7Yn6Rff6zebiSIu6/vms5nYt1qZ1Bcvje5tKIyN7aw0fpQFVt4TRKWU?=
 =?us-ascii?Q?AQP6rumBMqBbFLNgMhYS1QDUc6nw6JjN4gMxVA2lpy9g1cAl1MU+UaFQ3umz?=
 =?us-ascii?Q?bxPwd/sStnDi8y4lMUtP1Lpgu9eI/sTe9EEJMg2LeKy/LldOPnfq/YwJn3un?=
 =?us-ascii?Q?4A6FVpIyPAvnNFwatrpzqX7VmKQCDC+RrTPE7aEOVxBIJeJdyhu4Rse9XRTE?=
 =?us-ascii?Q?Zo5LkahHl9KPVz50/fRqfOW3Wbo6V5QZmgAj0YY4s1oExoBWK200i6+JOLrG?=
 =?us-ascii?Q?RRUjzVh/N4c2twz+etNP7NBPC5CYK8SMvZN3sSCBAMKpyqjNlGZXtMJEmxGX?=
 =?us-ascii?Q?YGY18MvYJ/PVYCNvxzhGyWDsf2mD755BYFemnsjZmCa2hKu1Rp9hd6qtPFaf?=
 =?us-ascii?Q?X/shhXLp3Z+klgpG4kIL3GvKCoIzY5Fhx/4etiNWuMI0lmI+gcHwgWlPi6bk?=
 =?us-ascii?Q?UHtpd1a0YP/wEzqzu0AriSpjcDZXvrF1dPAmXN4YeTboYohly4fob6OrN62B?=
 =?us-ascii?Q?KQM9R0TzD8WWkKZnXv+5tZXU67o0/kliANPxLT7oXoGEfBMbqtuDverUUWfN?=
 =?us-ascii?Q?sDVDm2wEV+GTvxrCuwvOs8KHnTMjmYMQqB6HbKL4PFtdHIgdqNubKGeIZpum?=
 =?us-ascii?Q?lFM/l0Uy0YRdTgPNKuB7dac6YRRoAAkQzdy4BiBuhySyF/HvpG57ivR0y2UE?=
 =?us-ascii?Q?uJaDH1hN8i2drBvx+8o9Wx4zeNF+N7h3TGM2nW23Mm6A32RmH1CqtpQsp/CK?=
 =?us-ascii?Q?aVFAJUOmTqzOzO7PJPHqIXTeH4iYHblY5n6ELQssdrbN4HPWye7jsrXQz/uX?=
 =?us-ascii?Q?nNmLgMbmWsMA6+dmZmDWfbjbLjmBAVxvOx9yd+vLprXlYpIC8hKfFuJrNsfs?=
 =?us-ascii?Q?LG6yo2+RkusozWliut24K4qVNTRzaG3NTbN1hsRCAh9HoUB5fjgW8LP2QGWa?=
 =?us-ascii?Q?RU5JzLoQHGncdURDfDOtuRSTt9ZT+wvqjCIdV/mSwn1j3fU6kWgjBYFZP6Sb?=
 =?us-ascii?Q?3p/U51052nPeibhX8SM+WH84of3t7LqUVp8iVyY+pKfixTDneUJjk5Ibu0N9?=
 =?us-ascii?Q?D65wOzqRhRAYP4/VJgS4KjLIs/dHdO7UaB9isARWQpSGY0yiioPof9gE6XtQ?=
 =?us-ascii?Q?XH+yKCXRqboex/kz52Ntz/2Hl8xsJY4AfsQENKPS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd85004-aec0-4196-4046-08db41d0467c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:39.5951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s61Up/wx+fzEgEDQY6Zp1T/TOt6q4Dlnsax42qn54dUS7mZWo0vTV2FkbVfmBScW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to the auto_domains mechanism the ioas->mutex must be held until
the hwpt is completely setup by iommufd_object_abort_and_destroy() or
iommufd_object_finalize().

This prevents a concurrent iommufd_device_auto_get_domain() from seeing
an incompletely initialized object through the ioas->hwpt_list.

To make this more consistent move the unlock until after finalize.

Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for physical devices")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 782b4fd76f31eb..2155fafda27a5f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -398,8 +398,8 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	hwpt->auto_domain = true;
 	*pt_id = hwpt->obj.id;
 
-	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
+	mutex_unlock(&ioas->mutex);
 	return 0;
 out_unlock:
 	mutex_unlock(&ioas->mutex);
-- 
2.40.0

