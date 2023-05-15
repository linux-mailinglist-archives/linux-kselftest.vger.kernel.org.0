Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2D702F1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjEOOBC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbjEOOA4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE51FCE;
        Mon, 15 May 2023 07:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQOE52RRmDGOeWWabbGRuGpCl3DZ72845cc48W9BtIAhoo1qdQpnziEmRTJxvEqAhfEW8hQMeZE5E1ZtoERDQ6OML3LH1c2dn0W3fw60fjzXaiCTl2xh08xnB+qY8LfltYwH4AT3I7Tqk8bRxEtDWyzELJIj53gFRvMRyv3amuXlGF1uqCeXi9XD2dJ8WspFezAgTKVcL4r03Pb5EENjry1dOHQKtLaPGaM+JSPWvG/zCzWDl+330hWpBNN+sCgArPPSra8ECBFWRknFdf6zYd0hNJycTT1YUfccoriwfVli7GXPN3qDmpUFZpCBEse2dTvGA8i7ada9o3QsruwYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcO1MzYBQU/rxZuStBotfoNI7hHGJTX7AQgq6T7b96Q=;
 b=B9TmyMNK11gEMXaHlP5CULFHNSLA3xMe9aMKJBdbOhnoM+O4C3r35LVkwZy0eQliWQ7x29maLnTJwIQGSBv6rcBYEQowSEw3yEixHCzvoYTW8iNj8YSjI46P8n2jBLIlTL2dfQMlEuGMtkR/OqReXlObeSucoD4WeqCebSKr1EVdEUW+anbamfwDuaNab+b/E6asJH/vtycfvmoyXq+RjOteK/t9Y6PPEvKVIKRQcXkkgY5gHyjeHLuw5+f6aPjA+sN1+gc8rwulk2ZpvW0ZfmT5b0DuxPaootR8ZTqin2eaDt7ejXi4F2o6b3Sib2Au1WeOgKsEjWCBQhCVKQ37oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcO1MzYBQU/rxZuStBotfoNI7hHGJTX7AQgq6T7b96Q=;
 b=ZcDG6qIHBpXYlVWuRIJw+Lu8lnS2MCESiJo/lPmP4uKk/sM1jlKbyB0EJFnxIRnAdEN5UOZSYDCjwCyM5MYmGr1z30+5nIiDtdT4C39wnK/NGWg7DimrJZ/LjkIchBLRkKbtLSR285Ry6olQeK43ar4tBs6u2BVkucw/athMoxcVVOU55UjacqfI9rOTUpWVeOY0y5QGY8dczbVnH3hU0wfnZgdKOo3jukV2Y7McxYsqcNvHvLoB9JJnfSen0gA4MsPHaWMTCZnU1Px9yMpoHkAp5r8JRbIBHvyCPf8zzdcLazjTYoWN+fV09jkKASLe/4Nb7VfepfSewE0HwMR0jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 04/19] iommu: Export iommu_get_resv_regions()
Date:   Mon, 15 May 2023 11:00:19 -0300
Message-Id: <4-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:208:120::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 319b1e6f-4ed9-4cb7-65e5-08db554cc32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OpCNwYDzc52h4lyLrNdOOBXypFLrzzVQJPQVrb8/PVJJBsXeEZaOi37brqj6qftuRJUcFFj7TXn2A2MtnpIVg5JYQg6Rc8K00FeBS0X50nNPA6jiT90J/t0WCYElK4IPCRqUPr6RCm3qJscgXxYiJmqLozLFmmQk1+7CPA5gTzcKasSgNkvl9rzvUo8lPloL9zB5dxwCgvFrjzPJRWQrtGqYH17QjVIGk9Ar3Tdn//SAOV21jIZdoetkxcEaCX2wq+SryWtYP7WuysV9t5MpskZU4kb5IqL6bxLkrcsiU4t3HGZlVm8tdni0gv5031HS1P6norOeo9xlL+XHJqAW2WUaLSZgy3d6Uw64ocdyY9XoDNakWDmne2TkDvqOoUogcYHYF3VKfN/NiQeaUp4AMoTXpnWJFvOsMMci+NZzy+t+V/5vEIZ6CKDAiEoRYXFOUuIud74kl3ApBvNOsvZdF6Vd3ZBFUpFC0kc0xJ6fZclB3Qao6jaYI/lAXdslC490j+3fHY8BLqEl35RHFRdqMWT99wXGZg6Wn7RKtx9pZWkB/ls3/k217Bbaccgb+zec6z1MJjgDaj/VDN8872oU40AiFxAYIHVBmX8VqebpQwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/13qwFvNZnblT8tsutF2YP93xujHGGFrGBPNz1Oygdzznr3A/WPHZpu9kKeE?=
 =?us-ascii?Q?nlN5QJtPp+9Z91UiBd/oJmdk9MAvioHcajZmRHf4IkhUAmzpuihyg06cu5DZ?=
 =?us-ascii?Q?B4w5raWEE2VDtezh/DUqSU73ix0MlQYZQzxhKInyMvsf4dd4RWoq14DUI9Fq?=
 =?us-ascii?Q?vR4qMuTRvvITjXbagXEVPsjTuRAfYwuYylptJ4TJMT6yD+aar1BlYnuXrdYl?=
 =?us-ascii?Q?osXWNXEG7QAYHUjyIb3UvxV18Y/OoTfGrwMdcMG5fYDR8Y7ct/IhflBT69pc?=
 =?us-ascii?Q?6eObB5S4gi529jIspTcHsOwoaT9q2AmOQL7KTYvQKMV3KTRB05+gmDO7hT8K?=
 =?us-ascii?Q?fd+IQbRxToT3FQFyZauoW9EIkblgJEU19+793WTPH8mJG3RRcD7+8MmPLk8j?=
 =?us-ascii?Q?LjKGOeO4ZVG8AcHf6wxkh+JbIZGHCisAg1o63N71GOtHqjfr+xGAes5Hb2Do?=
 =?us-ascii?Q?MOHJitMtfnj4kBC5St12RPKNv2UXueGHUyWtAysLx8rCzHxzxnnBRou0edBi?=
 =?us-ascii?Q?xrjtcP1nRLhVtSpVcpHqicDF1tnou+eIDG6yodmOz6SpthtxSus+ji5zkCEh?=
 =?us-ascii?Q?K2T8NBC58guMmiIkjcf0TOE1Pf8naH6jRT8xIp9R3PKBZILwWEwqJUUhuXhW?=
 =?us-ascii?Q?fVD/mLD4sS/pY60D8Nu7dzu3obolEnp4IwciFfNU5YPGFXWInGwnqWp9IMas?=
 =?us-ascii?Q?r7lflkKOJMzStOl0ob+MbEIS7tMqPXGL2gJ6aiNjIVo2+8l25dkRRqjPJYX5?=
 =?us-ascii?Q?2N5TOLk6Vg6w3t5v/xNLfRXkYjqW8FUoRcmE84V3IIqE/J5RHG22S+34Dg/7?=
 =?us-ascii?Q?nyKUhG6JXOf3rQC3+om9qZI8+SkZ/Q869xKHLv+4uhGA63MtpacbkkF8mddl?=
 =?us-ascii?Q?b9Px1iR86vAV2ABUnEqIRtAhni3/FM+j4X+21WgjsAo9ZwRgyw8hf6qbjw+s?=
 =?us-ascii?Q?nq355QDpKkhEerBU5HaZ2oDSDpgM74XwAZiN3bt5hfJfda1hneLGV+DBq1Gy?=
 =?us-ascii?Q?3ZJ6IYwvq62Fps6k4EGTRGSUWUQHRXP4fan6wcPvp7Hj99RYaL/J/xSL4tyg?=
 =?us-ascii?Q?2Ku6VWAwJs7pNd4qWh7yK0AijEjgZ/taZm8GU4I7If+G/AEj6dpTeLi753PY?=
 =?us-ascii?Q?tiTkCtO0+9T+54UH8F+F2N5rtjWjI1OxlBFheXjlj7SXhySUw7nbjg0wJ3tZ?=
 =?us-ascii?Q?InXKt/AH5J2OxZ0bqRyBIDdMW7F3zosyGHmu2ztWa3UVFbGCE+FfYGlWYy+C?=
 =?us-ascii?Q?OEFEvhXpgeFUeSRjIJdfb/ziUvaJiuBUGAlQqseGhFcd4zx3Dl7P9DVxlb1L?=
 =?us-ascii?Q?MCdSNefw4TTJxEEOUr3giSRQ7p5EWM3AG32C5V3h9Vs6CgkensQmLFFyxogF?=
 =?us-ascii?Q?oZXDZIgEYEwqeUvFeRtU+jXVf2gqGl5g4xb03Cu1Jsc8jYTMcThUevCsH6DD?=
 =?us-ascii?Q?Zqy9d6gtYq9pSJSNf1t1xDKk6Sd5i81hdCK0+D9FuVBnpv25b9GQ+jmEUIgl?=
 =?us-ascii?Q?k7aKSvGHbIFneZi679oP7x/7Y6YigbW6e/6vQoHtljKXVZZWSZ2i2hJL9trt?=
 =?us-ascii?Q?Wpv71l3u4r8d+Qwjg8f9oDjWW5eyvy8Qho0q05o4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319b1e6f-4ed9-4cb7-65e5-08db554cc32c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:38.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7Q4tutwpH7cGaUgicR9zgz7s6iDcioXcFEAKhHWp9N2pB+LxXXv6T9hWU3EMG5p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iommufd wants to use this in the next patch. For some reason the
iommu_put_resv_regions() was already exported.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f1dcfa3f1a1b48..280585965bfec5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2669,6 +2669,14 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_pgtable_quirks);
 
+/**
+ * iommu_get_resv_regions - get reserved regions
+ * @dev: device for which to get reserved regions
+ * @list: reserved region list for device
+ *
+ * This returns a list of reserved IOVA regions specific to this device.
+ * A domain user should not map IOVA in these ranges.
+ */
 void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -2676,9 +2684,10 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
 	if (ops->get_resv_regions)
 		ops->get_resv_regions(dev, list);
 }
+EXPORT_SYMBOL_GPL(iommu_get_resv_regions);
 
 /**
- * iommu_put_resv_regions - release resered regions
+ * iommu_put_resv_regions - release reserved regions
  * @dev: device for which to free reserved regions
  * @list: reserved region list for device
  *
-- 
2.40.1

