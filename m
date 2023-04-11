Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E906DE155
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDKQo4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDKQoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:44:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8C359E7;
        Tue, 11 Apr 2023 09:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fV/Pt3JYrLOsbbp4Qdd2BtGVTWSVTEpja0N7LyXz55qhRpeREOVgj0TmCyVJ3U0iRMM+/XqrSZjbR12r9qjoEzzkDEKFwEYLQMnOwNxHYks9sDefG0Ba+VIHVVYdGyse3Bs4CyM3xvtZJY41CuhXW96Wvc/NigzNqOnyCzD/9uG2hoRjh9qQscduEvOv4vYZIIfKPao3WJx0VDWCWxqGKYPNUSSelL6W/L6JkkKo/YPkfU7c8EOT2NcBW/B9nHDdbVqLLWTrYPWjWZ7hcKAqmsh28e8vJFX52HPrmoWbl+/Dl59UlCPJ1iuseMmTNEgisvis1Q9KxmzxLxqLKotVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=YnJ9Z068D+cbe/uRfZDN9uMjsh1qVINxf7w5a+mF0SR/xFikgJy7Cxxqph3Eu1G43D/2pCnrWSSGrE4L3IfV0AcT0a+PVEAXnr3yw/xL6H9fEQLTGXC/mUi50VYOLvBP3i/QwBjbRNDV9veJrNNXVJu/ECUu0NBgFixJw0556wJ+3sWeypyY5gs8tY7HYjtp1pLqLh8rKlwESvZeEdaRSA8+W1WUAa4izFGxzoPzLGlefn97raaDXCm9hKMM6bmoYsHNSF8zxjORP0j+WEmOS+0/Qq/dTmvW8IvCBC5XPK0Od4AT9CPBJXhiHYz+WBORZ5LkYpLaCZArZkJEJnhScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=iZd2D2OVGvRcoK/F9ySiLp8YKY5igVYgstJsj7r16iRIWlPdvCcSQNtXmA6x5TsIw0XWUWV04W3/k3nRDVCJZ4UsROgJSKfGqxTrkTSjmGVmn52Dy+/QTucTp3QHeweb+U6ZQMcCcskVE0V/8voH6vfKw8qc9ESWnfM6H0zjbnf99a/zSzPDC7xhiZd/hazadFS6QxGR2EKUeWDPFAnDCCpn52Ncc3GNsMlHXkauKbYNoAtX/OZ3+5Wtyve0VH+1mW0WN/nA9uIyq3sgtmgTcb4iZhKG4G58rPF47W4a4t/dmQSA1Elz3a7+lGv4mvWJ9uA8qE2b3SxPeq9rvAWWgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:26 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 04/17] iommu: Export iommu_get_resv_regions()
Date:   Tue, 11 Apr 2023 13:43:05 -0300
Message-Id: <4-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc4b219-5aab-4fd4-3c4a-08db3aabde82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hk1N4R71Tz4L8gCrXZloZhz9RDXouFDrUMe/Dsau5thfMkFS/rdEbYhta7ks2y0esgFkNczDVaE4Sz766zdueyF7ym2srXh0Pshf3p391+3e8WaF0HWJRIpze9Ic/NnOk/OsZIGDK37hRXM1FaDhgxxUIYpywxCfLltf0jK+mjcnFd3lCjgfe4sHbOX+LiLNGR7m+MUwsPys9QHljO/e3z5RW3TqKlswvRGqkaLR02gY++qO9OYQAiiBR7Vdgzj7NVaxspYWPsEm3BGw+5bUp7p8CI5Zr7BXSV2zm43tNCFt7bU3tHa8g6SFv+fFaZCoa+tw17bfjkAgu6o/M+81JEvuFQqDpwGSfPqex84nMfszZfsWeuavD9lzXNhDiX7kVcJwH/A9P2jFyUizADkA++kg6lOr+XVBJ5RfX5LoBc0jjzVX3LQiOgLBBS10byxHuDnf5fyD4/w4sW0xo6K/iRsvSKrRquJFxusdcICZNA5ODdKFV6PAXkhq2pq7Wfhu5DLEJA5un3xOgAAvv460kh7WGk/6B23FZ5mTrbzioOpBXW3tHtbpeiQtc8TyjCpZg8HNPtnTFwObCXO00UM6P/lIH3HCtjcw3oGEtPSU5ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C9OCN/vM3zNptu0Hn+bDWa+kl3ynZo9K51CUUraKrzia6CNX1Ta7FtRdI5ZJ?=
 =?us-ascii?Q?N6G6twrq5OsCAfducMnydUJKUfpTdgE3AdzToer+aadJBUmkYymCvhEKuq+s?=
 =?us-ascii?Q?O1vCmSnjdjDOjoee7qZ++XQvfl2XZ0qyM8Gty3i/WQX0dkWyB7NMtoksiGwI?=
 =?us-ascii?Q?uWf1qU7rT3sr60zY6zl5pC4w5mRd0rpaBGtFAFUmMSuTNACZhc4cTAEBzL7G?=
 =?us-ascii?Q?FATbiTKIwwvGl+0Jf3FsO6GmND1CrWpjMYP+7ynZSPusXXUwLWESLkbox1Om?=
 =?us-ascii?Q?n7tmmFr60tSbNIzvSs3Y3YsBcIWoibvei3FBlmwCg6PUqRJrp9gC1Qp+8F0a?=
 =?us-ascii?Q?mSlnU4NndzkL+pz473fEEWwDyzh3EkZhkRDcLwggkCmiBg0FPn3aQDaCNkbr?=
 =?us-ascii?Q?o3/L9jtoi1FTYASTGFUEvbMp+55i99nJ45ggNMC/JY4GaDFQxIHPChRBVNqV?=
 =?us-ascii?Q?o2NuL0iMfUVHr7YYLradBo0HhfWsBxVnNXaUwmrTtGaIkNeBYUlWScP3NGh0?=
 =?us-ascii?Q?qUr9X6l4+uAudMnBUYHhq3HbPq+bJPitDX2LiCxMbseT7RUn85t+MaDymiA/?=
 =?us-ascii?Q?lJm8ONFO2AhTp6W8tC2wU52wVu+RZ+HH6hN1h4iPt0w4s79D6SYKVOxtPCwX?=
 =?us-ascii?Q?hrsXSkY01hSC91kDygFMcYmw6MOo/dBCflttrNXLCgbbItc0x1cMcKQsQX8c?=
 =?us-ascii?Q?vG6hbvB/aLe6V/tE1naNslLVySnukXaUFQ15p/RW8S6yh1RQtL3YC7uuHxan?=
 =?us-ascii?Q?ynJ6wlNkdcBA7Gj0UnYJEiVeItxJYNTXrcizNnDrDjV7omw7WICSKF0gk8FV?=
 =?us-ascii?Q?PMxdpH+hBpUgfrrqAQmXCfOEXqUCu/d5WpP4CuA+KdsWucvhlFJyytRU+l5Y?=
 =?us-ascii?Q?Fjszv8FeH3c3x3G2BdgB8D2ECFle1gAg0bNl+m8XgayAQhS+e448XiqpYI8s?=
 =?us-ascii?Q?9nrQQEoLx2Jbwl91au5rOf20NAd+q3Q94VA2eXyYDNetPzviYpIKVxyO0i+E?=
 =?us-ascii?Q?s+qK9/q6TTreAMEiuGkjrYvHTofVI7smkB/sxwUywiqP/PIzYJhLYZZjB2ve?=
 =?us-ascii?Q?K8g5FEQUYuBnMuCJdttuB4GNH55OkXfiDe+LicVvhQ7MMzH3wCGnbjw0fQcQ?=
 =?us-ascii?Q?nwTV6ATWn0jw5peo1Tq6fmL80z6g++KK/Yyc3SNahmCi5ZNI8zTmeHRsOG1k?=
 =?us-ascii?Q?FdLx26UlRW3MCX09Z93jDPQnRrdOBpff3a9VZ2+Fgi3SZ0bnH4NiXLZhmuUv?=
 =?us-ascii?Q?n9T28b5/wCwx78TIlBq43GyR///jmnrO+x4XazIt5V6/fS3aALj7S2rgrsmr?=
 =?us-ascii?Q?CYfm5jJ96AukjN079ZEouXXId7cb3yHKO5PJLgotb0lTRe67QZUijoLRAIwR?=
 =?us-ascii?Q?D9bGpTDIN/y9+gy8aaqiuTWn/JEy/17lZFmDWpxLDqpzev1dE5jLbpZ/SfpB?=
 =?us-ascii?Q?kG3l8cG56XzNxHDAilc1HyfPx+zjGdGpee34kZr2mEorhzsfALd7j1fGVh1y?=
 =?us-ascii?Q?eDDt5109wDI+mOIExMaoe7+RFgeAUVxSGvMwaVGA+KMa+AOi03gHNMwvSryo?=
 =?us-ascii?Q?TBYUoT3fc5vo7O+UJdKhXENIEkyQYLA8t/QG2jbI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc4b219-5aab-4fd4-3c4a-08db3aabde82
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:25.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZTanoVXJx82isBOvruIyTDLEwpGTjPhX7HaTXHu5ep78d1zD6ZUZcv+RkvAH5NQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
index 10db680acaed5a..76969904b93af4 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2639,6 +2639,14 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
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
@@ -2646,9 +2654,10 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
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
2.40.0

