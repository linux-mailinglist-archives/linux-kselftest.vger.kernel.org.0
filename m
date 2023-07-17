Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61624756B77
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjGQSNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGQSNQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1F31BC7;
        Mon, 17 Jul 2023 11:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uds2I/8nF+bSfG/22eptJV9HZEYYFxlhU+1jxXKx0KxuMUsh/dpOK0arsdqX/VFWObDMssD+gjgFPhiR+XfG3+MOdEazFHvZEeLZwFkyLch8AYVx57QOZ54tVWQRf2HNViwHdmKfPjDpzJIPl/Qktiaor5zy7zb+LN15NfcZPJLWBxmVOTkMGSeiU0sdUStNqA9ixCErCBd+vdgF4UJmc03aVeSvLl0XDMQvWKxr4GTWMYujd6r7hk7FsGpZLGXeSpf/qW1/5se2qLtD4hjO+JtZjXBFAtOePbA2m4QM84LD4NeLV8SsU2o056fjwqAqRHGQgDt9Lu0Wv4463URxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Yerv63V1z3x8getRyfYKfQJVbdDuRELWrnhqE1QQyI=;
 b=gzA34cAN9MFZtIquqtvi+nWp0lwG4beKgeUDECiXq+TFhAQw2lz9C0xLMO+4QC1TTjfhcuo/eKdfb0vEW8T5NU74n9+n1ffHWC7duYunnpoPQW3pysG87rfxEKhNjV9oBmYIAbOwfw7WjFok/u0vzdSygen7O+yEUzgt6vP9qLH+qauyzDp9gdtYndUs+hw3KmWdzHOcK9S06aSEKjiFp5ymIxAylDl9zqP5A3JAPJlsXrPXTDRqMLYF0FhKcIe9nS7xe1Zv4ktbwbz0XLn3TAlrdqyFMPrl8lm/CtQVLLVC25/CADUHCDXxOMf23CupDNS5lTUbEVgZWulVrR8wcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Yerv63V1z3x8getRyfYKfQJVbdDuRELWrnhqE1QQyI=;
 b=Aaqyba5KZqw1kwYMoNoqQtXrJPdiq5z8e4dy1VteTsel0mTLP5GFx264HDu4kQ9VZ7+cJD0/ot483SetQwrnM8/SA3Ii/nfBy5QOh/M7VaWAj9EYeJd78Gz3FfnuKnfzPQPEs7wiEDY3T3SLjfL51JfDh5h+H03YqI3dRGPlXKciffcunE4U3pTnEC5FfTPgW5e8IOkskdpFwxZ+tRFBp9lYUADLcWX6h+eyw8mEdzXZ08DybID0cUi+mCkZTzCHzvs+b5eW2dpMVgv6Jw6HQiJqL6dIAT+gf+Byvm5U8RRkoSAOS4xror/RGhSSr0pC2rXd0620QkezhTTiF9r21w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:20 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 01/19] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Mon, 17 Jul 2023 15:11:57 -0300
Message-ID: <1-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 887133ad-f737-4cd7-11ad-08db86f15b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJ61xD5Rwygmc1TRiGP2VQ0naLXyLOx2i67/wCJ8RK/Sotq4Sld3tkgCp9nQ9JsyRmOQgarugq3gJ0W/8e3pDx+ajOSDmW1q3BsNkOHet0kpE4WI4cOPYAHnOIPMB9sIqNCgEX1byahKnNtEIT2XQomd9h/BJLwjeZIBOikfCd68OFRs7ewj2sTvsyt2noeiNRYnxhzbRiRr25tuhkx8pfA7icYr5JC9iVgb5twZ/SFanVlReitehaU5dAHOuZ6QQwdeXDMQ91/dSKbkltENu6OlXZWP4bV7hYtzrSzcj9/h4StYVKSGM+espNzprWpI9Ev3d9pWdaZ/1p9aP/OLfvQn2EoO8YLsR3UzTg51hEJD/o0spT9Zn3mcKf2XGW75kWOtw4v49uTgSa5BNG/EuiyRQu7RtMkLei/UC7wqLde+tzw0xDFHjwhZg89GSVfW0TbjC5NuDIg5GKtfyk06m2CnlK6vCQP04foYa+ESqyA6ww4QoUif2vjKT72IHDz/lKuRmZPPxpqjYSsTwYyh8feRDF9DUF7kTxo5c7PWYSsMSeQZs2IcjREN6Yv9lSEn0jymEMc37WDx3YHW/6RoE0AB25xjEWr3lAP2s4Bwc5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6666004)(478600001)(83380400001)(186003)(2616005)(26005)(6506007)(6512007)(8936002)(41300700001)(8676002)(4326008)(2906002)(5660300002)(316002)(86362001)(6486002)(66556008)(66946007)(36756003)(54906003)(38100700002)(66476007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jl7AJwnMlrCyIg5n610POZmd+tRXi9psVsn0+mf5NgM3WLW0rGEx/RKYBAMC?=
 =?us-ascii?Q?/qH0dEzWPmk4T3RJ+ZSdYrpFHi9XoET2ufeE1gfQSLTUqndL6tksIC2imvIC?=
 =?us-ascii?Q?e4f0EIlj6pHZEf0EPSzuugXzXw9I/SL8LvoC8jifuxvLD6XLsnBNFRrrlp+p?=
 =?us-ascii?Q?OZ/piwubqT6Rn+TFVpcwF2U7Jtn9tccnmsGVNuQ2pUHJoiySljWu3qnaeb5b?=
 =?us-ascii?Q?RZLLCv/4Lx5rm9VofiIWKo0MV4oVCBZyzOfei2ojv1jLKE+xFLjewsgfR6hB?=
 =?us-ascii?Q?naP97Jvgw2Hf0TbmgmtCr0is4l3FG50/RKFvPTvQi42UFVxSBL7pVjlz8xHt?=
 =?us-ascii?Q?jHxtLFWSHU4R4V3ZpoNfGDmi53/GKWkwNUNzB246TLGqH7/T4oEZX8aVDPOs?=
 =?us-ascii?Q?D4KXsD2IoI+kEiq5+66OnLn/pq5RNLMf5Z5FuYrMulvK+L6IoQE7NDaCJn11?=
 =?us-ascii?Q?ecsN2AdAIGfP4mykW38niP105iFA330sqxwUUrpOoyje7P79pxArdWnDWaGh?=
 =?us-ascii?Q?sB/yMqUoOPuQ6+J0IwpByb6DcUFXYLJdhepeqJJimV1Iw+EZo9mA5Mgor96Z?=
 =?us-ascii?Q?lcALC//DRoW3Hv2VTSUGohYvpYJ3/UXn++bZmO0/8kZSc8sHpMBCm5+B1vgq?=
 =?us-ascii?Q?HaKpPu8gXgymSvuXm0pmcEFDH5mvr2oK8Jte3DIeUYlf9MdTZisIjoLPb3rC?=
 =?us-ascii?Q?126hRFa4IRXPJgc6ITF3BuBUc5VYhRxoWR9J0gKQK2/Gn5YAuJajM+TgVYDU?=
 =?us-ascii?Q?pKl3Gku/1yObklde4jV6qNXPO09gQ98VtU2OjQVGMKlyABBeL5cE1eYfS5t9?=
 =?us-ascii?Q?bT/zmZuoSc3WDjV/OdNpiSj9heqL/6K5+E8i90f6mcAdjOXztFK/Ga/xE2VZ?=
 =?us-ascii?Q?d0jpekJHhUPBm6VwjDYlEWcV1BE3GfewbRJ9ahZif2v1Zlq0kBunIK5s80uS?=
 =?us-ascii?Q?oKeH10smV5TYiSh8pjangN2doVGVyNR7BYB5fZI09V/4MGoJXWBGc09E6iBD?=
 =?us-ascii?Q?bLubjJk53gUMIBy5zqkIrX3dmAezSN2cJFS7he+hQpYMCHl2grA8qN4Pu7kv?=
 =?us-ascii?Q?Kg9ib0IQ7aCVdJww1+149QnYgzbgBXRDCKJOr22/f1baCo6HUzJ11U0TkYK9?=
 =?us-ascii?Q?LUuK8qOwKJDPwcDtF7ajVEWXIDkuWQp78qZbHxKGU5T7ZqZrcUxUgJ7s5YWn?=
 =?us-ascii?Q?Nmq13WcTGvsUKCpdGjT3cRC1R4Uvic4gWA6K1qa5oK8PAhlDmbgwNGuaqWky?=
 =?us-ascii?Q?lVTGjWL+Ml2w6aq6Ss9IAmKCFlgl4NB8JNfAQMxROE+pkkmQz++mobi6SRpj?=
 =?us-ascii?Q?W7naYrd6H1irGNAVewjc23H8OD98V5UPjfICm7rvAwfUJiEnZupP8xD3It2R?=
 =?us-ascii?Q?w71Gvja4R2FzIltN8zX5+2YquskkmTFKy84WgB2OSNnUx60OXU87RZ8nOcWJ?=
 =?us-ascii?Q?yy5GrqNYXpy0hM0ezTs8BrFcjORV/FJ/ZGPoKjCsgR+JMbxOFXho3pGX0Ua5?=
 =?us-ascii?Q?rY3Hx3eq+MkT4POZn9GPia0bAE8Z1HL3xi8e2rknpjtVI7sj8YOa2lPh92UP?=
 =?us-ascii?Q?UHTxojvUmukhI2CgetDdtZt+LxCnLOgcu+QWkms5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887133ad-f737-4cd7-11ad-08db86f15b78
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA1UmtCVkmvoTQH/AhVAQND82obxqlyOGZq0fpC3ly1vhYtxSn3486gJzC1flsDx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 29d05663d4d17a..39dcbb5cda7e23 100644
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
2.41.0

