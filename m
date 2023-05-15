Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D00702EFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjEOOAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEOOAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265A171F;
        Mon, 15 May 2023 07:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiR78TyNqGMvw2etrJN8jlXmU+oNMh/AVMIcUznrpaqcPOQ5WAL9/1JiaDNAFKOqE/6xf0D2fE1TeJ1Y4Zb58pDLjT7FMBhXI0NRJxrWfLyOmrFaSpLtc5M7GTPKv0rpcoAySRijJKHCPUHtC0fy9w4t1KYR4x1Z1RpoDUXUT+EGhO9bHigmZ6FfdHxf8UcOy0KspwZLh+uZtXyv/PGSocgz4SRt9Q1Kul9RpzbBxtOiwDjxuqeCP4sFaZcDcp83cFUsKGyNTnwkSUbPkVOH4FhO8ANX/Hs38b962zao9J8aCI56UrNVT0BDKUfimfzJK8RgTSH69d0fZCag1t3Kuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yggSDA3JxQBZJNyaECzZdl1G3+QioO4Kstiz70N0DpE=;
 b=kHr4dHQ7h9iddIutf1t1uEnotWcDrh151ZeOvy0I7rBNOPwYR8OQUpatrPgOf8bgaOjqZNYT5asjdkI2NDrQK0Atnqk1SzYRT7YPI1PF2Sd1J/JDbHE7PWlSnlzJ4ZFGLn6VezVK45crNR80Lp9+mu9WdsABTx06rz7h1NXya71JqMsZrRvTWw1npYv9HHroZ7swRbrCqbAN1gfHyFq6J7z5mFAqua9Deta0ekHrow8ib4mUqwNw/Ikdsl9f/z9DkCR2GqkZ5KUOGxKSmo4VCqef5lCoEydgwAWuFXZZ+gXO5u/NQqmBPmXEBrka9SdCLOr/IyRb8My07CfHgWETvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yggSDA3JxQBZJNyaECzZdl1G3+QioO4Kstiz70N0DpE=;
 b=T/jGcHzTS+zkhKiCsjL1+Q1JB7NG3UltzIHDwPHkQSpdgC9xlvWtnh6X9XFCNerWrcDbto3J3B82DFduaeew86TBaDw3K3HddqjpcJXSBLPix8JJZF5S30pHHkd0DvLCkk4PlvIUNriknkJ5zeFi9Ie62Cq0J4NDuJgexGbaldj87DSGMiuNapa24bYNfN/Muhy6qJInt5rZvPZxJLWjp82Vs4IL1FZFxQG7zDF1xAf/EMDEj+I6P8Mis719nHJnG6uvVfZK7DgGhxodXaKit2z3IEB/8rdfO3K5WbVfIa1mhummLumN/xaAUmYsZRHyf1OMiYm3BRtaY+0dMtmYfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5389.namprd12.prod.outlook.com (2603:10b6:5:39e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:35 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 01/19] iommufd: Move isolated msi enforcement to iommufd_device_bind()
Date:   Mon, 15 May 2023 11:00:16 -0300
Message-Id: <1-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF7.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5389:EE_
X-MS-Office365-Filtering-Correlation-Id: c63aae37-3dd9-43b2-71a9-08db554cc116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ocx8Qlc4MsR8IMwjtGCm+OIDiWAkyJGhWwY1TSzLPVUZRR1d1d2Iktjao2K35AzrQvPvwhNjkfhRFUDvIHWttoefLwfyliUkrex/W1vGTe1qLG3UF+PioKNujwx+uol9cLU/pNpdR9qcL8CIgxqTkOJpOAiVbVICJAUocT5aoBd/uDezzk37/MDmwUrhJmWyZLjUwo+gOxIjwL13y4Q6t4AsH/ju6gk47FHfzShAFECpmRt9/Gh7dEwC6v9F+MO8AEnaTqAojr+YhDHvLEX3JU/N8Cv4pdWxwBf7OJpX3HiRNJ8cph4juD1JVH7youUHxxn108VTqkWNj/lxNNYf0TRh3DG3zDyPL4lQXfYxEjnDGu4m/WZd07ucyAsVDNWWkS7KO4dvM+PKR7xXf1f38R/p6xC9j8SM+9GXmtyjZSxwO6NJy/Vw6c5JRTlJjZni+0FmH6t7tlv9tGK6lSN7GxV+J0ZT5QwqQ35KCgH3tYKt3RMLA9+FmWn8A0/KEJ2Jhos5veNi0IliJVuJgpDlqp39vjVTBE+MIgQ/s3qTNZNhfG9yLdcpkdxLBtlYTS6OkzbO8dxeSVNQwN7kbORShW7Q2RhLa67AXYqc19b4vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(36756003)(86362001)(54906003)(316002)(66946007)(66476007)(4326008)(66556008)(478600001)(6486002)(5660300002)(8676002)(8936002)(6666004)(2906002)(38100700002)(41300700001)(6512007)(2616005)(186003)(26005)(6506007)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMmINWTZQmZHFm68rNVT8DsA/qah63CcjB5I3Novkx1doS381fXeVjIrf4Md?=
 =?us-ascii?Q?bp/RP5hzKlEb/4zKbvFvTgtAZi/ebUIJHlc4aEIB7Nu49vVr4qd/XFBh6mWP?=
 =?us-ascii?Q?1ukcgvOoGUSuJAvxRlNk7nLPff0Tn62vBtasoRULidFMhOjLSBrYUBXIuheX?=
 =?us-ascii?Q?HjVxwK4GYJ6n+9z34K+ytbU4SCyrBF5av2cHUgJu4P9kirRH1YMP6emMKXPc?=
 =?us-ascii?Q?vV3CoQ7bucvUzeSXRWWwDDmu8h0tRZe9ibiNBzvwdvdpq6LC0ugBqSPt6sOt?=
 =?us-ascii?Q?GCCIf1hcWzm7HEWm37fl8srIW3H2aDQYTazzuWiWp5Lhw/nL92aZU4cmiK5H?=
 =?us-ascii?Q?cb0D5dU43Y2wbkAaZx1b8FDo91Xcc3DjKWEzbGqAd2CVHta/MosZDHHKJnYv?=
 =?us-ascii?Q?raIrlfGh1f3b8NVY80lmxeQbKezGiH8MBft8rRZxHXaK0jN82XE2FFekaaoS?=
 =?us-ascii?Q?1yF4VgtrcfnvQcK5cKSbIJyq+ApJLsZ/WCLacsLMEXQLOAfI01BkevCoXz8O?=
 =?us-ascii?Q?vYi5Z2JMsBlMQtgP2gZ+vK1KE85MbgtR4PjoBnwq5RuJ5uSl7uCCKJ/ok9qV?=
 =?us-ascii?Q?FYACNaKoM4i4JSl49x73n8nCrr3WQaRH3nYZWwV53Sn5bPPjDQqAn5KnUEW+?=
 =?us-ascii?Q?fv98V2X6v/uD+d+jalVrNRO5Yb+YITPRu1jmDiCucg9j76HPNDPv3cDvO2SU?=
 =?us-ascii?Q?x4xF1u2cqW5+yO1Qh9X/T6FrfyJFDuEoxKlifOt2pRsj4kSUvJvKLIJB8Ogl?=
 =?us-ascii?Q?FBxnAqbhiEwuaT/A+Mirl5cpIThxZuegJN99NVoeCuvT0spxkisoSEqq4xzy?=
 =?us-ascii?Q?W73o+Uz+Wnd7lAciUauy7y8pTdZXFTTiJEFmGxnJAv/1dq8CSY0rUWdTHYaZ?=
 =?us-ascii?Q?yYurM7RHeGVhnZOzqAyXMy4xo/JCoW0Fv2cjIM7uqW/h5K46Fc37npQBUiLO?=
 =?us-ascii?Q?mzCi4+ZievBfATQ4MlCWbUUVcu2OuZ2riy3YSfe4NFvmx7iye9FQINrs543m?=
 =?us-ascii?Q?d0OXV4Tv/T+SLuEPHxmDhU+3sWA3t5miCWkge9xGQQi1QeJarnLmsUF8Hhdh?=
 =?us-ascii?Q?UE/ZmCD81vsMabzYnSVf5UxrNTO5iUINRq0MlLkG+7ZDGvtEDFqTtyFEZrsz?=
 =?us-ascii?Q?L/4iPO3uraFyULar15V8L3Vm9uQm4RPOCtAyBODZV8w1p2seVSIoyqxxWnbU?=
 =?us-ascii?Q?GZHLnCtpY63Io/43o073Vm5y+f3hVKW9W79w+RBXxN8NOIJf8kFr6rN1tFO9?=
 =?us-ascii?Q?/4VRpf+KEk97R/z9ir+csWKjD4zacb+uIHycCe2mNwy1lxGphZEbmznCFZte?=
 =?us-ascii?Q?4AauC7JjhSyx27H3nxvBzaeJRoSBFgVTqv8Qw7LvLcNEeHa+1N76bpzZSRyU?=
 =?us-ascii?Q?Q0jPh64lRXy+l9gSrq+dCX3lqU9IfqZkPHxa16KAEA/bv1DDyXqOmV8eH08V?=
 =?us-ascii?Q?60J1zGTY/vd/iycGb+Pl/F7LjdarzW/Ljw6dDB0Geeih66u7sr5CGIQEqb2s?=
 =?us-ascii?Q?zJ8D6N4XlNFRCSykkpUsxA1G7FJBpjh7D6brazF2Y5cwM1cbqk9VAHIUdFg/?=
 =?us-ascii?Q?Fz0ZiOJdUXBAUj+PpxuieX63fwcdIHUyWYS+E6MM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63aae37-3dd9-43b2-71a9-08db554cc116
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:35.0492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQgD7gs79DL3SRWvDLdN+ON0DCTz/C2oIHSHhgpRQzR4JN4Dksy+k4EYLYD09U6C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5389
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4f9b2142274ceb..927f2051715f64 100644
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
2.40.1

