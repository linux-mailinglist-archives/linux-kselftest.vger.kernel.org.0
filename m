Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DF36AFB36
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjCHAgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCHAgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8B9CBD8;
        Tue,  7 Mar 2023 16:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z71HYQAlDdpQvGEftDKFgg6zDoTAKjJmBa8OTSjaPRr5nDEUEe//V6dcB/NDdbM3yoGfYN/elB0uKSP8HQ/tDK7cdqoRfhrbLBa+psf+Rv7kvNTBPBVUaivtzXfxM6XFHzqGtsyk5dE1aeilVywP7vQPSs8pXzzJLZ9ijJZcmKE08AjdxnXh8FNBQVhjLkDXC0XjRkoY+aNnxL7vbD/547axG97q6Fv9tKYetOHwUre6s1UpaiHFK/5hqGpIwnKjDwPTHry0swDTez2Ausy+sdUjokKA+yxKQZehtOEDDLDhPuGA4SoMGF0+GPFwGBCuX8cqUmhsTRJkgec2XfZiBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e9gB5bvMQqjMzypSoEUjYdF+vGAcoSKwTmEQPZUlBQ=;
 b=gjhcQcEHfnzUL3BQ8isR86s3BR1gTX/2L89c65cZphyZM+I6GgS4C0pOw1lRdrAv9++nAJbUlmzUuFlcqDH8IxSnF8LJ84+NeSBEZYJ8h58tScVFvE0Lup6gWeaQziYNvkPQTyyVvh6Evj2yLwu5C0ySmO7DaSLLxDt25aLw2CHJELx8sT5UHc4DNP7o7eVqMeWLtBGSNxNmGvs85ZQQY2g/WAk01E3oKtbTO8Y+gsLI5n+4v8ooSktfLBJ0epgn320WGBEGYkl4KW36ByganiVZjFthx0pVEjLEIdFMtyRpOnP9TSL60+8/ULV/JlYquacfWuMkLT4dNYSYaz9Pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e9gB5bvMQqjMzypSoEUjYdF+vGAcoSKwTmEQPZUlBQ=;
 b=B5kWvFyD3bD1APGCGGZWfXPk45AdjU6F7BO/VkS7uZrjDtZgJeeFOKdkhw7gJZMt+nvaa+tkTOPo6ymHOKI3cefptez55KoEgHFYeU7UVI+RwLxap0EYaAMwCX5eGWa3/r4HREb6r55QlwLd9ZSzOzE4RnK4znWf2+gHN1oC/jLYVginX60c0WUFFXgeGn/R6P1n0TyJFcxePhQ8oQysNGUlUVedU1Mr7nkzZkEzT/21lqPwY6KvB21AuMt119ziTA9F7y6in82JwYWqsW/Vue0sqnAwyp23Z0vTc9JZHuzkr+wEBT2gkLk3VkjXBJhTq6ctpPSddD0OXaa74Eu3dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:35:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:35:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 01/17] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Tue,  7 Mar 2023 20:35:40 -0400
Message-Id: <1-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b16c03-64fc-4090-1540-08db1f6d15aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgTx6Lfq5sgYPv7MGgGg0Ph5ow+F2GsjDU8wEFJf1FKKP6+vNsb1JS+3peH250h9/aSrZ/HdjFA89dcA+IeCD90ioR+c1As+Ib9bqK8HxoPmWz9GSE20jja4TD2Yct/ClJwdj5WiIMCStQLit9UfkCjoUwPuGwLMxLIYPMMwz19//mBq3gkW1DPnY1IzwVu48I435fWffBNoSdSuBWEnuq4J9mR+8FUzpNqF+JbURJNWhhT2zfYCrWKGqBgDl0ZDWlXa/Q+JdkvzXqG5kSKtyI6m4AaVjnCt45eZdZFqGXT+9YTpwA4EWUyHqfxJ7a1fEg83E3FfsprMZZtrK3Hx/j9Lo+tdaxQDD1/xEgzqNuaVyHMyx4231+JB7mENvWDTG/MrJ3os5rb2NSHC/ATcMivW1bKsa2XFy8inNG0697kumGxxaqm4LHI4kcxIVSXInti0m0M+NPdNlSsEMdWALbcrp8FYx68rBjraKVpV9NWT9OS9uwHTdTLIfR+xeiSmn9z9XrZIVkhElJL8XHCkQIo2l9h9uYDjLgYPQ0aVHBUxe5iyXn0sS5vpqTMBIfPTVTeoSP+Mc1e9VeE2EpEpkEBIn2lJoau+ZNCh5EspgwAGK5uDHoESw3uyzchcdl/HxBT8ns1L7NpUva5YH4XKVgAEqE4LVw7ZzxcDAxlYl+JyRtxbML5f7uNx9RK+5oVu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Im/x485B7+3Dv55AQihb9/P2jKmo4zZmgh45zBdjrAxvcv2TCGZcltHeFynW?=
 =?us-ascii?Q?EYjaAJMBDejHVsOKyONrPQ7SNzL5CaXH8uG+f7vy1Al86wh1HhlbAPhW+HkC?=
 =?us-ascii?Q?QeG6VwYEUJs30244MjiC7nqQ41koiySymtGcqNMNpdC6q/lTsWpaw1AJfIcg?=
 =?us-ascii?Q?aab7S+DU7ncl4XKnNzdCm7JBBVMH+CnF44InmVEl2pmpx1tRGTtupt2HUbz+?=
 =?us-ascii?Q?TwR1tZowRTEzCgEuSP57TsLryXgx8izU1uQXZjA7cyF3lFmt/uKKJf3l5FgO?=
 =?us-ascii?Q?GFR2VBTYd7ue8fckzq6mC+kxodbtxyUqMtAlwLYkgQydNIbpB1BREpgkRpe7?=
 =?us-ascii?Q?uL3ONuF7W8Ucx5rvQkddvlxlcS7nI0Im2qnFkpUNBz+1lEwY4fDqw/gP8M8P?=
 =?us-ascii?Q?+MNX1BxjSzTMIMWmiuifIW2P4xyF1NbrIB+kl7U82tHVAHmC5Rkc+YyGkApX?=
 =?us-ascii?Q?7x3uTh8OKpRuGJCQcXdEWnN+QAgYpVxKEESvwWDsV4QApLRl1JNQ9dVifeqM?=
 =?us-ascii?Q?zGca3O3MCWa2flSruBzEDbud/nPTUbZRgR+sIuHVaSg6RdojBZVrFDSNTIiU?=
 =?us-ascii?Q?JKloLarJ/EenlO0rry4PbMzeLeRILPyIauO4HTQET9r+1Fg6nrf/zaAH3BLR?=
 =?us-ascii?Q?eT7McJLgsJhKl6f7x2xP1izQkWWU/hCs4ai8MbxS4xuSc6FQxRbwEFVVCGa1?=
 =?us-ascii?Q?WzE7VkR4+wKQHqhvpA1IwEIYxXpJVl8cGanHhkLvzcuUl09dHPrEBd1Yf1Zk?=
 =?us-ascii?Q?aNFf8hfzYYVxvEjJysUrZ3Kf/an79k4Fdtvc6I3WdEgaDDTfboo9UzzfvDbP?=
 =?us-ascii?Q?9UGKYMXAmdC4h7oKRquSRwzziT2Il20LVcN/DKgplyq/yecM27uM9cCXzTe+?=
 =?us-ascii?Q?mM23sNUKDPqY2NC0Izf1KNmZe7cKj1+lvjcyLLYAYkkBEqyZgQCSoeiBMtB0?=
 =?us-ascii?Q?8S70To6C4LlM0gU/eeaPQr3IUvU8fUzg72fPwcAsjULjmP8kb1dFuM7PFan4?=
 =?us-ascii?Q?8Di8JtiFWAtrJQsSDEKqFVGcP6Tr/2vj1q7vkLmS8fcpQPKwXn/aMOUDZuRu?=
 =?us-ascii?Q?elAQ3uGJyPwhECJ/q9swlQo2QYiBFobcZ+bFt7Jce7bauhkejrhvVp8FYbFI?=
 =?us-ascii?Q?zbZOSrKLF42dJOgfg6uzvd+Z4XyTcrBfkVbEqtsdSLdyGMZcvY0zd1WaxZcI?=
 =?us-ascii?Q?fEN9LyRSTgT4x2z4GkMSeLNe3/EeY3zyKA3tiGoKUw//lU8jhWiEioOZoxNg?=
 =?us-ascii?Q?4Gj/KwFXOGjiU4mKM0RVnzRH5KARMdnSbLcgJ3HRU2ROq33liBTCHVIkJXS7?=
 =?us-ascii?Q?DHMbqflCJUp6E85/kY83RSgMiOYLtOwGaz+nh6uT0Oh3QdERPgIvVqIUbbXN?=
 =?us-ascii?Q?mfTe67/6gHRoNJh4joVqxzD2p8g8sjarWKBymWvH/dHAtVMjhWSEaELYg7TP?=
 =?us-ascii?Q?ED7CBHjrdzOlVYQ0XH6VRRFzL3J1VJ4YpanwTEsu0aWpkRQgWB1EFzSagQO/?=
 =?us-ascii?Q?+65JxImuB8hEL8apNsCmLxSEvKk8Ny/unL8URBCF6VZVA+OcrgOpQJeEau4t?=
 =?us-ascii?Q?ya6so1QHjjulPH3l08ham9vHM1tkRZ2ShChmuD4j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b16c03-64fc-4090-1540-08db1f6d15aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:57.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi+b/QAOlaVe+9VZflE3nOfuDWxftObu8fmq5fKlZTt18/1pGLr+btqRF/KxJgSY
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
2.39.2

