Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E386CAD4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjC0SkD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjC0SkC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:40:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993DF448E;
        Mon, 27 Mar 2023 11:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTmcAfhOmKcpfrL2A/fU/VbdBBuXsiMTiFK0T3j8H70YsRCxEf/Ix/IDP0rQrU2trTfY560LF72+6qEnDLwhcYmLp9jzAkWc8LUOPHQHjJkZ01ZpOL5noHN6KSBc1cMC0H4u/QVea5WxQTYmnwCzoj8eRKc9tJiZvbghBN5xZmTjVZNUIBSYBx+i1fSF0SY7BcCJPkcTc8lUL5NEk+nhe+iFdXHHUPzTmNTUtdAL9WdDRQ4A9fwDjQVrqacXdAs3El9c4yMjZDioHb5O++ZYANBidcH8nOY5y9D/l6je0iAizY1qGP0KSa8gvCKRgLHmlQd4i4f0AR5k5QLKfFS/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=ZPMG6c2CDZf7ZvANVOUPuZU0E97Aray4wMcGaOlNCPVEvrU+8lKZglvw3sN2WZO66zHaGNYR0FtUHRAeh6jas5nOWFqiJ1D7WgOeBEax18uMizhSvu5TRAkeN/m6+J4t72WUij9bVh6MyiWHVR0xoBFm3WF2fAT4AUkXDDKTVKQNlM9Qpbs6tqnqOlblkQA6hBxsYoWrurRjCyLk2+l0xeOA4yInTZnTU3cMQ6woJxpC7yFGLM4n8IH7fjEJmI9ESftMcogtOV72mVCfBkbKzmK/re53TZ2qbvktfNk2ox6EoD4sX8rRwg+kVz18otCCMWval6HsElmFfrYl8fXpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3blGAHefJ4aP70tNrJtt6rGHVG5EmtnNNBaQcgWD0rI=;
 b=TryaW87/qaUPKkyyRohuWBmUhAPSXeysCP9BUiSAxnBjEMSBxcPZo1ZECgV0Qi+kzA3fRgOs8h0dr5U/oIz2fnY9Pf4L0b0WxzRSQv3T+fDqbB3SlANBgzBtUMwFjTLdL+TlpTMn2nxBf6YMw2W7Q9ePmBdviwUPALvMZTQJQ9dh7vqMbQL8xdKiZRohOHfkjSquhThxJ9gGlmrJMsmtyw5pZV9ENpSBK5IVCVqbNoX6y6U93b4jri8qFuzxZJeOsm0zPK+GDpjz8XcS3rRSrkYyPSqNx07ZmXyi78uyfRdYqsPWm1KHYqfuIosH/kOrBefJwtkK+zGVI3U+KY7bRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:24 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 01/17] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Mon, 27 Mar 2023 15:37:55 -0300
Message-Id: <1-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ccb694-c313-4145-c1b6-08db2ef26cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jOsbJ058fndHmAMZA/JMhAtOjTezwsODTr+L+6TJFTX9l2LitLiSDlFbvcRfNZXvgNjfMPtbcL2rg7n4Keyu5j735SNk90TlpPcP58XgDA3+I66IxQ0f6SCGKpMOd8Yj/ixAporRGzzTZzXHLlmv84TA2eUzSR0xVQvoe+6PVqM5LRUZeSwt+jLO8M/OwGnSYkSV8Ocyo6ndP3B0EG343v0yL1aQNyJLMmFuNEAVttDq7jabuG+V27MxnZ5nTgxoYL5EDEoCSfHY37B5GWhB8O8+hqGrv+Hlua1N+OPYkN2af9AWJl/ci5iGJ437+iPDrokr1klUNh27zSLw3nprx0jFGAKbbY+RWgw64LB10KPG0WNMQ4Uzs/gVMSNB+FaWnDn+8/S1pc1ga3CgN8fygxp+cr6FQtyQLU8N4kujDMcRqOQUKom1tMYSUbi0XiZQiMqguuX0pLSrdhz6+8ljUCyQdMJkncsF4a/WwYd8Qkc641ZxWPvrq1QuqixvEuZTYiG9zfBISXLnQm+9u7l0ROQ3pvyrT61ADUolI8ZkuoJm/pHzAWBfat7TroCJfEM4NsBCQRT+E6/3tzSdxObOHgR+ZkWkUEY2t40ArJMEemo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7z7fDKH8DJdrZt7CoW5mvQd7NhdnVt6LCQL+ktvkBQNqIHFF4gWQwfe0BqYr?=
 =?us-ascii?Q?pGP62MoTxXze1rFdghE8at8zKCm8Bl0ZRbfMYeio8wNQoCGtj7GxPFwS83vj?=
 =?us-ascii?Q?4k/kVYhaGvpnsNVyjOB/+G4WFvzJWu2TEvnKpRJBzHxEeucg2MH8wx7L8c09?=
 =?us-ascii?Q?hDIjDjPMeqNKJ4FyGVqZQfna77swG7lAfovogiIuaiISoYrn5baOYn4rSOFH?=
 =?us-ascii?Q?KijFt7hhE9aLVoPQhXsl1CyHkHJpIE68IpVp4VmLtPAl/13LFG52jqic+NDt?=
 =?us-ascii?Q?nBr8a+cx//LhhsJmoX87cyCIthmfGyvbFdZ2V1OBfWScyqCNlPWDY3Nvsgib?=
 =?us-ascii?Q?NaYfA4N+m9XnRL/tjnZdqy5WZMO3CjFHlf/aOZNNEUs2upw4VY+fl5eVvAPF?=
 =?us-ascii?Q?JH9RgYo54mQbol5sCuklV3SegdZldgetQprb6scldGzudg/Y7UrkO7DDL9v7?=
 =?us-ascii?Q?bbGBbvKq17mf0T40K3KkwDlPe70szKZMfcVP8gT97rfPYw8wsKSn52lnC+wY?=
 =?us-ascii?Q?sW7ERdhYPv0kztl2lp/yaoVykeMP6Aci60Yx5NrWGPWd352psnfXTaat6wPi?=
 =?us-ascii?Q?MLPlE9oQcAVaHGcu+UyVzM+TqpXSq9EHnKmDe3MxLlnGH4IDE3+IJbtm1Lgs?=
 =?us-ascii?Q?kf4kxOTC+MUi7BeGBBMMD7af5KOZMEdRXtJsikQLGlDJaaU6xL8Mm35Ijwmv?=
 =?us-ascii?Q?XCZ9nv9+K0FygcS4TKRfzstoJ+NYjgiE9RzrfllacmRZfE6AZyHYfnVCnTsO?=
 =?us-ascii?Q?Q25/0rWU6g8tGlpc0aVVi/xyfkBksYtADTQq5thYNS+Bj4Dt/WWi/A54nnu8?=
 =?us-ascii?Q?HjtrGw8fSW6UYhrYsOc08TUvbXPITKFNEUimTnvZ/l+X/SXmI82chZXMhAjI?=
 =?us-ascii?Q?yRGzx96bg9QoG9kuJMnuxH88JitC5zbuUbvwtnItRbued/2n4UXGpQcHsJS9?=
 =?us-ascii?Q?Qo68okGZ5gQGnHxDeg1rsfk2PGR7ciPJ4deSrEzKwtz2/K23WU8kGf8PJ7ot?=
 =?us-ascii?Q?sErvJrCj8OQzipjuvxC3JCRBjPgt0eNDvH0vmOl4Bpv98J8bu1nagYS4jps2?=
 =?us-ascii?Q?wMIPS4TK99oHXN2WLbgM8ASLaFJGwAqdHYz5f02GQh34Cy6Yb5cFueAbOX70?=
 =?us-ascii?Q?byD+rtjhOuvjl3LwWazLVxfileOA8fsyd1WrHbnAOwcRU8/Y3Kmv3K2QyFgI?=
 =?us-ascii?Q?UrdiB7uUzsfRDlgkdi9Pwlk+SKFb9+/noFfPQZperPYVeAVYHwScXP8YugP1?=
 =?us-ascii?Q?yu1p661NwwY8xqkwkFcGIrPmkK5IMd7LsnuJrpJUlbiOWCQ55WDUEW+IRmPj?=
 =?us-ascii?Q?jbakUjTKyvXeW+iiHvJWhjjla8hQOYxyGwu4aNfyQZ4KiOkByJTP08WWsVHP?=
 =?us-ascii?Q?62VyE18FTSt/zxnvOZh+FlBNy6Zs2i/4CRkURKW4/Hu5Lr6Rsfi6ntp4kQ6K?=
 =?us-ascii?Q?wwUZ7hheNWWHy+sAqWMEKJ18ucJCKkeW31JQSjByvR6B3QSwYSBQhIjtZhUB?=
 =?us-ascii?Q?KFCnjV4/fpP6iiInzswjn9pjg/9c0BG5uDZBeesf0Dwh5+8Lrt8nLxGFiA2G?=
 =?us-ascii?Q?Lqsc0uUMILSfRTJfdB3umHoOgx3c6JiJ0gh6yw1t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ccb694-c313-4145-c1b6-08db2ef26cd3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:14.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysptkFioZZ7/EaQOVmiVCtn9pIWJW2gnYInlscvt+iePLaZaBHTkgJEax+4ur3Ho
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

