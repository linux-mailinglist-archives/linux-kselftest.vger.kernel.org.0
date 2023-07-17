Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A689756B85
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGQSN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjGQSN6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9ED7E6C;
        Mon, 17 Jul 2023 11:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REIjMCubaMqNFRTndz+Pq5B1b7ySw8TtE0BCpMg+75UdL1cXbEq6lM7PkXyQ/AH5fMmvICXRgp4Y6l6tUpBRSkf50Xy1Ox4c0MXC7F4YbSSXHcNhFJr1hsFqfYaQdqCiKRg1Z77w/1ydrCxUSUiXExw4nSC/ygyJpwKRsdZZJE8Rq63IVzjl2A0glVHN1kwvQ2xZFyOGQCodZIHavH7tNxTOHxDC11FmYg+kKPAjNL8yD6hPxvKy2g2w7sbdqSbbQZLYBPFHOYDH3X1ctpmPzjsuvJURjcu0Vo4WFvPckV2vWpJJ2ovDCwMmOsHQXKeDuo7hUwBil5BkqTPlk1PSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTJDjvDUYIGHXvH/QGyD271sAY0kcFpBGrR7tF4sLa4=;
 b=n5dDn2GMmW//pna4qAJstD0hqIKkb8muSj4Dfl5VWuMWONGq6mzjs+gd7ouL8nEZ7fdzBR1CY56LaFoT4stKA6Oc6JfLv/FKvaTAX/QcVwkmyKUjWDFJaRL2AV1Kh3vweGEB4PhFoI1iisXRsrYvZGl3glbfzeGZw5+t/lrZzOLfsNMaNcWz+x//2GdtW67jLGRaovbfYxNMQh0IbxxOLxFl56Z5e2tq1tR8OB7l/I+6MTgGFep3Bsa59mFsqTjTVdtaWol9wfD+NDHFxUqrLj0qL6uE4rf9MogRFSFYc7HW/fLiiG3WteJOyl5cZTAOEELORK2fiHGYaf5gWQqhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTJDjvDUYIGHXvH/QGyD271sAY0kcFpBGrR7tF4sLa4=;
 b=Qxea7km88+Q8kohqJgMDcsuhM9aoB9XBDsYdf20ILgEAbri0MmtKqKZcDbEoGG8injeMf7omuPvXs3D5I0y7N53mJ/ARWVndqWPbwzOm8owqcG/ezzmH87rGmeBr/gO0pc9lG/136zGEQO/RTBkogb0dmXsc/FqjCB6s7HLj+ZVRDNHk94mjRVt/RLdiFhdc7GXnzkzMo8G+fc+jzfzM0td5cGG8/ZbX6+/WHGwVcWYoJuw/6bxCB4b4mRdB0HT+aHqUhWGJVmSjvYAq+fyUU7uZnm4Eb9UA+jv276m68UN1v+wnesSfoHqgoa4FbxFoitKY5a/fX7HuEAHIaOd0MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 04/19] iommu: Export iommu_get_resv_regions()
Date:   Mon, 17 Jul 2023 15:12:00 -0300
Message-ID: <4-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: ff816fbf-a888-4d4e-9bcc-08db86f15eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywsukzYUBiPkYktxP7PFt6waBe/uWh3I4OT0O87p48zSlrGMYlxYOO2zn8GXuStYs0rEac0A+/R2CTi2yQpyIeyIsW6+kfjNrRHkgZeiSACspfaMYcR4QeTZj3aolLIWaEpFDEJ2JI97TEbN0CJqLYblPRSA8GAd0rOf/bGIoitd+PvY1aKe/FHZr+4QUlzozWu/u7TIs/Tprq52+ZFlBpmJHkUBHGTdNSWtZqqsw84DWDbVdOM6O3BD5IjTMBTj6fcSoDPmYfQhQebtfK7CW+SOxL3ozqheQyf9HyYcF0oh/DPbSn2ulkozqlST5vEIFvMl08WqZkCHU2i/UU7KtRQpOP6idI8R2l/mGb1kF5cfu0/cISaepQH5agE2aIXtZVBztsRo/2nOfm8rBlNjh65f3c612vjEoahDL0JrkFD8gEL1z5jqDOOua01J7tzoe+rDC2FhK+iQqXnqgsgTD/O2xeQ3lX3ODW5EMpbze5VqbfKr0bL/5zVg0pq5l1CPamBK14BcqmQ3ckMuuK8PmpaN/f1Kl8ZlzQmTFIqaEPnrn9Mzmtiq/ZsRIMWJkZrDCuq469DR2T3KjtIXfYPDuRQ/Q5/GdmDUyzYIFa55Jhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(2906002)(54906003)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(66556008)(41300700001)(66476007)(316002)(4326008)(66946007)(83380400001)(38100700002)(86362001)(6512007)(5660300002)(26005)(2616005)(186003)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ktNw7UhzYo+zA/HI/CZfSvbBwAbIF4cAQ0uF42Ymwsi3p6M1z1uuFgLCydH0?=
 =?us-ascii?Q?B94uJjJY5ckNv2KQjSq2qLl0AO1vth9PwKdZBVPJKeP1JKSQVoJSCvI95KNV?=
 =?us-ascii?Q?LIpXgyp5wh/9qohmLtKtu668QXkX0X+a0hYEXCm3j9gPruWiyGsnj5LsJLt9?=
 =?us-ascii?Q?fiEG/x6jzr1+KaEbtW/I+daeWTOH+KB+ce7yjqIO+QBSiFfm4Q8N2mmcu21W?=
 =?us-ascii?Q?x8eDQZJwYEQfhkn4DHULNJy970wpG25lXtMBH0RxzfGjc+/q8gIvwKingqjr?=
 =?us-ascii?Q?usVxNc0vHXePk9/yhWR7wE4WPgkEPfj8tLKheOS3JELxB5P3tWz/js1EBxYV?=
 =?us-ascii?Q?pUVotzS9E0ZkQTSZAmBaxaA/V0+o5njY59WiMwGK+zQkaz9vuUCs8w8K0IKQ?=
 =?us-ascii?Q?f269uU5kr4Sg+vNZHZn+PZzENiIOenA0mVYC4s9fsZdNaoIWZlHY0nrqtAr8?=
 =?us-ascii?Q?f4HuQVYBsd5xmIfIc4IswZ4YBxNYsz3rqtcW/aDtbAATTfC1shSr/98uxbXn?=
 =?us-ascii?Q?5xFLgE5beZB9cZJLu1tJ5iiBi8KYZU1Aysrtq77nBFZt4h34WOjKv4vb/2Px?=
 =?us-ascii?Q?sSxWfeXmBCWWBI0YL0/Fu2KGreXVywAUnIGiAqr2UglSR9Z+sQ8y3O+DEg6c?=
 =?us-ascii?Q?tOehNZaYMFlISa+HIhoAEgSq6Z0Qb9X63NDT3RFvM2mrwaNegTZN6hXpXXJn?=
 =?us-ascii?Q?TB2YeQwpFt7XblNv64iX2mBfhFi2Jo089fJqfROAO99gsdYr3dMwG+oR2EP8?=
 =?us-ascii?Q?PvTsdm/E8ftDlRHO+V++/kT70wE8aTB9RBMVNglWK/s2s3YQUPzzH4BN6Qx6?=
 =?us-ascii?Q?aHRJReoVjwuC6v54RzK9G+ayzv48jrjCCoApGWvXf9L0dQ5UIVVfUKBTfVk6?=
 =?us-ascii?Q?k9VJnFSEPinO27RHYtpl3e5b60gRMfG3g/y1sCt7O/Vh6lQWfYjRRK17vnwh?=
 =?us-ascii?Q?OrqXbNcxLAjIIwAF17NYpXWvcL1fRGW1650Zt4wyui2h6ekk4lP46tMHd65J?=
 =?us-ascii?Q?po1hNt1Fsk5MNr97dNDgUJM7wUgTJhkqZjhlb6iJxSnKHT1uwtV6KyO/rvZp?=
 =?us-ascii?Q?uPxRdEn1tT6IFQ6GHXlaVmwaF0MEeVuJp/6dakDOERjoutr5K23A+4uQ2xgR?=
 =?us-ascii?Q?0Frks4RtEgvS+CJs14uyr+iPjasDWFz/qJvXUM/36G/d0DP4X9cRpoChb8mW?=
 =?us-ascii?Q?naGaPe8WzNRNKzvLEZjofu8uNMToLFQ1Hz0aoOBKFhyF8ppee8unu+U7ECDu?=
 =?us-ascii?Q?NlEFge/XNljX+RiwniYltiWckn2/yJVInEWVCoEHX5pMXtuZvT2gzmdj/Um4?=
 =?us-ascii?Q?5ze2aSQ1aKBRTGaxlmYpp4hin4irUVnbx2+7snHYUgtI2xod8G8ojYwpSPvJ?=
 =?us-ascii?Q?yuUTxPhmSe3K6+kWSQT5b+dJPRCJ1jpyffIWlYvGHigwRrGMReVF0w9W9SwX?=
 =?us-ascii?Q?BSLW4zxnEKuveDSoqI7WiUn2GL1QMm0ZjJV930w/FGlzrRu5yJG2kECZpqjy?=
 =?us-ascii?Q?9uARSE2FSsDfTEkxgSlgqtl+CGyOrZM2oFWijFDSbx421ySBGIvSb27pOi5W?=
 =?us-ascii?Q?631T6BWdbBnIcnozdamhLqd3RHdiKHVKB2qO+uQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff816fbf-a888-4d4e-9bcc-08db86f15eb5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:23.8041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfyqc+we7Hxw3SIjHqzQPPjIE+X4l/EvvYt1sKW/FmOTEAKcn1Pkpb6Kk+wx+XNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index caaf563d38ae09..b0804fbad6f9da 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2642,6 +2642,14 @@ int iommu_set_pgtable_quirks(struct iommu_domain *domain,
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
@@ -2649,9 +2657,10 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
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
2.41.0

