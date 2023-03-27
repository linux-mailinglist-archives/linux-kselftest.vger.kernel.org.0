Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481886CAD2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjC0Si3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjC0SiX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:38:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E114223;
        Mon, 27 Mar 2023 11:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muuzVwUDZ/lX/DzMOvszKxCl3DCG+5tqIp3qJ3/igCx0eOhNb62MOzfvw/iDTSzDOCAcD58/geOkDOCKMNOeFv1OZLZ7E7xN8i+abnS3j1T0h//9h5bmLCPpdAaxei5+tH1MKraD72+wH1WLXObjxr2n97ajXr9poEm/yNaHFw9sFZNin6ltgyhEBUQwwWGuaawrqjUzphyQ20cyaPoXN1eJf6S5LwEIjbBXLp19vZoY4TOtGV3hRATBeQ8VFincFvs0IFX9LHE7pZcE3wkj8nTV2lWVjEaGxoV89lnacKUrt88XwBUNdJTagTlb5F8x/iY2JWxtRPStNy4j8zp1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=Z3t6ErLzj4KGAXHFvU8Ubko3tyGzHq88a/osH99O/JqZjVYmlYJHgZN8R1y0TlbGGSzkKJ+J+SIZaowf3FqGNtCNl8Fc0HhH2cw4xKA01A5ZfbktSrHT6dfzq8nNeMBORTnG9sJtV3ZapRhXwaX8SMV45PBIZK0UEk4i46K0vdqtLsplHf8okVzgHa7rzIAXpsgvtUbT8s+lDax3x44BGuoXmtOQdPF/+IdFEYf2RLY1xGhWsA+jH5FY0GicCVHCsbCSEys/MMsFbCnFtVQQ7GZFmjg2/pM5WjcRbPzp5qfUVdMBNj72VU54VCSqtQP4fmdeQ2GUnQGo1We8IgRbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=QAnlR359c/pLULQS5yTsjLEo/LKTTplvDUIolQFAt+9sv+/qPSC4XCB/ogBxcY5RcQL3qVjodww+Qj2Nre9RWt1Qqr0wGAR/9kHjLSrD2SUiChJayF5Jem00Lnc/Y7bbF3LxmGcQYAMjAMeD6a/o/hOfyHz4YsJCZE2OgOZTv6eoBOsQBmBTEGJBZ6hEZdXe+bS/YtrVDWZlFlO/ECip+6VPCqyqQ41jOEFYRs8ufEycL2kaQBForpvGgTXuEVCkGpy3/i/HIuTGt7aT8h13MS2YVJjjZsytGIgJjVZSZl2SZhzq7OEOyM0WchXDfyDj5zTGUQ/Kac8fX7NSXw9pEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:12 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 04/17] iommu: Export iommu_get_resv_regions()
Date:   Mon, 27 Mar 2023 15:37:58 -0300
Message-Id: <4-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: e8791fdf-27d1-47a4-3aa4-08db2ef26b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgCe7Z1PA7OkuYXUlB4F5GBo5k1iKVUlplE2F74TRWVaZvU0eb/9kyJCYC/y+gY3Ez4V5xdadShU87hqUiMHzVw9Vl4eff2rts6wsShl6cq93L3zShTZWRLE7aBCEzO7UGhlraZ/vECZ1iYpU3kq5tOoF++gbrZM6svtDcq87ZBf2IolKOMgcVkGvhX5+xmltn7wJbHd4qc8MRU5Szdp+JHYAvySTF59NIa1XU7vxmR4EueJv63kxQ879e7eyuGLL8+GA9x79KEatFNaMQQfchuHgcTQ8BsB8D7z2Iq2FMAoyh1R/5OTxFSJxQq9p5xvvPCa4TTPwEbNjfPxUPX6gZ4lGqShLAQnuvCbUYV+cX8VkYc9VL3GMfcK9klTU0GFmD+HW/M/QHtI7Xg7w2ZRDpcbycwL1C7QGshTTxBAkT592Q4XzLBguz38i3UDS54gnt7JenbhCo+8I397uiTs3wlaiwHxnG/IcBhyTwDxbDWkdsI0uyVuBSLeOEjC6pjClZ07jCta8JeO//cdQCx28cy/6giokt27oQfFsak03W77tyUjchMJ4TbWosBR3HGePjbhfbcO05zLoH0udla8++/9ZVV8RRnSEwwdFgvqUM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AvBP06QpBl8Xp882sjng+Q+4TnZM/v4R3EDRYD8S1cg+XSx2hiYAwxrwRRHN?=
 =?us-ascii?Q?f/HaxBqU3xu2H16BGQ9y1XQFH/LTv/mH9Rtk2KOl2ULwboelZa3Qa0EcEF04?=
 =?us-ascii?Q?OzIKSxB46wyXXXfffyVCBI/k8UgLD0ye+mj5m5gs3U8VCBdofw2qw7EnPbB4?=
 =?us-ascii?Q?7oo0yBjaNLQJ8gZfpAxrEMVvtrusS3hYD/YemTAeujpIEHdA0CWPHFcQU1ci?=
 =?us-ascii?Q?n/mYqbxCgQ8pAk6u6DCk4TAeaJhgdQ96cH/x3vo7B4exnnnlMQADPCjhy9cN?=
 =?us-ascii?Q?p57cDEEmuTe7N4JDAL8BsN9Hvw64q5yTPXNmSYpqT+cY01aBeHka5Umz4LTQ?=
 =?us-ascii?Q?/pWlh9guU0u4a99/2dCtDiklwuZVYjMS8nc5ZUVTpnhJgf5VMZghHSdwqhwU?=
 =?us-ascii?Q?VnV6oUrZzrimQNc1+xuflCmNKMUZkTCaPs9zgB+LPlS5WvFelf3q8o/cv1Yv?=
 =?us-ascii?Q?T+Vqj4KL/gUm3S3Vl1GECFIeHA/+6fmvs+nSL4WCytDNPvtKJ0HZx3k3n6Sn?=
 =?us-ascii?Q?0HUK7zcX3QY+Tt0V3q4oweTTMFvpWsUl9SOgFUV7347RMypHRRj3B9ll9ECK?=
 =?us-ascii?Q?wsBwFYavBt6hwTJvS6S6rQMCTnEfgJjaKUSHQeI+KiKRsV9P2DBFan3p0bLu?=
 =?us-ascii?Q?g1NWwOx7GCcNMW6yZ1KSorN3xsDtXab0WyUU2r6iguN4SeMUqL9ETblX3LRU?=
 =?us-ascii?Q?AyCPKGHvO0teh4qtj3daWBYB4EJ2XwP7w0+FS4LGCWS/gPespq/6Qr5A6IbI?=
 =?us-ascii?Q?O59VgWCIHQ8sBF79lmsgN/SZyRdfWNC/Lcm/+AismIxmvbcxMQTHJOPUrgYQ?=
 =?us-ascii?Q?NkvYUkxZlAwpDYEUoJ4puWYKb3qbLNITPr7PBGSaf1Je6Y2UOCW+++AqIGmR?=
 =?us-ascii?Q?ddJc9Q0j/Kq8GLycnUqDSbPs0lX/GMLlTAYAoM+whulGFe4RO97qWkIhmV2Z?=
 =?us-ascii?Q?67i6dCyn/xsq1ON2a20fXg/xW/+4RwpFLtWdkxZMS857b9GfPn1FtbQnOS/o?=
 =?us-ascii?Q?YBs7/Z1jI5NstC6obg9RQ0H+POpyhF3pOrkK5+xKf82iue/7SneN0RbKo4CL?=
 =?us-ascii?Q?iJcxNoOJNXj1ivTewxTyCjbJ8DXGu7EOomzdw/SNm+Zxs1zBwkbc6WnVMvPO?=
 =?us-ascii?Q?WSohvmRWen4CZLMZt9dkCcaveu6xxYoV+EbBrrXaiugHtcey98JWrHeGCC51?=
 =?us-ascii?Q?dzN2gHpEiPo0ZYDDSvHgxUvpEXM/qOUjt2zOPuWjfrasxLDY1DjXaT6Bw5vw?=
 =?us-ascii?Q?SSpcqsOzp5mfeLTFxqUCrNMCAMIjq46eMc4UCS9/8PVeuwbr23IO3PbT4pBF?=
 =?us-ascii?Q?sYmNh3Sqx/Or+hebdGV7Fh10VQGvJa95SP4/Plj0y8SHcDxXb4sfTtQZr9HE?=
 =?us-ascii?Q?NHXxUavCrJCSUPIH9C93ZfBItpxfaOqbXuCZ1gIN8iL/dBwqNvPjtelwtyDa?=
 =?us-ascii?Q?RHKO4n/YixwTBWLUPkMQsdqYTox8eY7H3UOPQqAQVWU7IUKMDZBgLRb2Z+PF?=
 =?us-ascii?Q?zTjd39w96Iu7Ze4ZISZOb2N1ABUo7o9BJ1eW2+lx2yopmnWBDrLTHz91joG5?=
 =?us-ascii?Q?LTU/ioM4OxDzfad/2P5aPA1Ho+5nJGKATcYC2LLB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8791fdf-27d1-47a4-3aa4-08db2ef26b70
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.3943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fuJiAi4hxw+km1xLhyhuCWasENtsIrHVo7lhBPy/nq1KBK2Z/BdPL6u+UcqVYOt
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

