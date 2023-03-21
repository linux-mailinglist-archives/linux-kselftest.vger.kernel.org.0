Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454586C3A2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCUTQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCUTQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C3E244A1;
        Tue, 21 Mar 2023 12:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0qGyKjyLU4X2fEZ3m2kk6SWhWow3fHRY3XYVWumpufrpoCNg8+6+5J7GZEKmuBabl6/KMi9LtolOR29vm1ojGQ18OwvYFARgxkZcUCWvy8pcLHvTBp6U6nHC5mAJuA3dR4aUvkdDqH4Ax+mgOSwyI8YSMbBXNsic1GjlrsX7vDk8VaB4HeiMnNZ5fTcrI/ywI57IxlCgYcd9qiGit4V4qh+Fn4vBNrQ9Gq9Urj3Jeufc2k/geK8d0OheUOsZhDdxlRca7wX9PE1sBOQ3Vxv74fUwyB0+aDB7pE4t9iMLowi5Uo3rYq4KpnocO5K6eZnAPjBg7jcXOt/rvlXjAyVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=bG+oB6wuBCIUixFWLalF60p777mgzfC9fV/iA26OcxgVCPyDWt200KiqRJIID8r2YEg505iGCAd9avK1raIqW81xh1HmgCjZUkaCiYe9D/xHK/Y0DPNmckCyVY17OBeEIhPRZTp6Q5ewTH6cDMZd6HaDrDqPFwhRB/7TcckOdeGdCSRZdguT7jSsE6Hnr8o6/ljv3XsbZ3VYMIaSl0V4pt7ligs1bb08u8U1ZrYuMUOIPXDc1reCSyLefdRFcXuq9RlN9/fZ7IbMztkKqcOSWUSdG301C/HhExMc1KjyNHqyiFRuFb5d2Zkgl5fMNT2G7ljiIdi7XGB8+JSDdOsfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=mwcatSywbY1d6/ac4Xqn0mwdLdVJsTymdRts3rY3Hsw32aI4Q0r+hXayaOlaIGI/E2U/G6Mc7QZCfXZfhAxaBoNhobtsXdsd1veQA3e2l8MuqCUGBTLspmYbjl05LYY4NOMDoSlqcj5h8bbP0NcphV3J2yiNRWsRiJhbfjdjOGVMSi3Hk0mC6TZhuSWbzM1UpBviJ2UwZ7mIuPvILNz7aWtDFbwVp1HSECobB5K2Ra2dC1eqjFqXRg6tDaZC4q4N1wbgHCcJmOMQ377wSzuRIuzdZdoGxVMbSTCeHm4EFMBZhv07iMRz4gRgIFYSmmLrO6IU85P3Su2Cu7kUoIfJ/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 04/17] iommu: Export iommu_get_resv_regions()
Date:   Tue, 21 Mar 2023 16:14:38 -0300
Message-Id: <4-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 7187eaa3-29b5-435b-2300-08db2a408d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiHTXhl1GgRKMDGk3WtC1e00Nd/kwCdKAc9TuSsn4sf7UdJYmpx7Cj6GsXX7j89vzge5nXFla1VLsP6BHVnrYRPW9NSUgm0xgKR8dv+YmMPHLnciQo9B9pnmBss3sk2ylYCcitGRA5ejPmQ5YYu2fruezob4mZb2VKrZqTLkPwN14Kds3P1nlG9V3AUWGpbOUyshZd3dVMkVrnKL0aUGtdH9ATsmPV+uXUMMaWKY0Cqzb6t6stoT8lUyuQd+0AryCuFHKlKORB5Xj90zRrUZFtqinKkTgi2g6hA93nWHTv05HDrMjAMIVKfKgyZtReF4YcGUSde+Jon9E8sfsp6caz3GkoBYfm+miV56/LcDsHye4MgZRPSkYHLUtYe+pZkmTNCkhAbtbTHnIuYRzWCZ2usSGCVZMFliM4OhI5q1894eLRqdGQhbOXtHeEAkTULX+XHULe7pXVMljjO8yrBPa199HJHiL5dtzYw6+d/PxfZO+3qlefw8hVPagrpEHr+lf4v1zTml44/4eDACfqWyR6dMGVcto8lD/e2zt6HsFaKt4aqzebhTR8oA/xhqMoWqXFKkswyjhCZQenbDBdFUh7l6P6fqdJP7S2KWtCJkBSj4l2sDHq2QoWIR+tWRr9Ks772+8D3QuG5/xK64k6YdNavdOEQ2pDnWIFiC/tA8ZUwb4xSIqNeR6TgMd3RfY6AT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OU8NE3MiqplrkKD/JGYhv+c4yy739luxmAESgft+MZ2rj5Dm5Uvwu+KqyUww?=
 =?us-ascii?Q?54Cfpjgqkmpmv4OD6NW7dqdWIKcQI68u51EyREaWDQtP96EjYV6wGiPA8JyI?=
 =?us-ascii?Q?AWJ4/2v/G/rgrABGvQiWcwSPpNDBoDzQWXGJR9dOd+OIQIuCO61abh4Hy9cw?=
 =?us-ascii?Q?Ny3oRSwHNA/ATEsRT0DazXMrKpAiZiwUd5n0sroPX6m89SMdjsM+sh79tIOT?=
 =?us-ascii?Q?KcVRtl9Z5Qum27HhkzFUeLdYrsbF86wdIR5i4GkpULSI66+LhmlsSwEdHv/s?=
 =?us-ascii?Q?6C15oC7eJ506hw2UpMmmEv9vzPyQPx3UmrfadDVyzp0GzdBUZBtlHcbJStCP?=
 =?us-ascii?Q?giko7pxUvJvugbEHXhoWQSes6HlkWeW6wKcZQ0Fi1UcRKuWpHnqsxwkWYHi+?=
 =?us-ascii?Q?XgtRW8FU1Ek+kFTx2d8P4ZLGItLUHFf8MSwDI56M4AZI1oguo+FmFLABWD6m?=
 =?us-ascii?Q?dY/0EzclJ2eM6Ac8kQzLkLpa1Hf+sP23XExHryHJg3NLizFzXP3oIsYei5w1?=
 =?us-ascii?Q?KGoGwVjkQI8yjNtxRbCbzb1vt7DyBR3iNpuNeXlrYw9bkah7Xc9VDtkJCeRD?=
 =?us-ascii?Q?KWPr+YrVfsq0rQPlDXU67BC/UgY2xysRnPc2JeN2LtAJecmdR6nOuAkBwDlX?=
 =?us-ascii?Q?cG1I6C7f7mPnTKQuUqg25nQ0BuL9Q4AxF1xLMElnePg9/wPifL1DCU7052De?=
 =?us-ascii?Q?B0NPQ5W5ieGJfmi36FIuPQIFyT0BWGctjBuSw7+WqOK+9Es5OtNl3/VN6831?=
 =?us-ascii?Q?p0nhF04FOVLPzpLCiG9xlGFB2GNN69T3McWf1wr8f5Xezig5YCkXGBTV/rCm?=
 =?us-ascii?Q?vbZrYOIaCQt065RxD30sqXmPlyNb6m+IsaWN4qD/LVyGURiMFk7d+2UL4wqY?=
 =?us-ascii?Q?uaxjNXzpEzbpd9ZmWE5zgI+SGqjKwTxMcHeCsy7TFwpBkR29N5COMgkvvivh?=
 =?us-ascii?Q?aSXimL6546KIGabon24x+ikyiAXNrEFpgPxT3WMz3ewEVbvQNaP3zZtmUUiO?=
 =?us-ascii?Q?SmPNl7jPAC/fBbRKpcA6W2hlTAVxBUyESShWx54vxNmhHhGOQ7syJ6lkOPsS?=
 =?us-ascii?Q?NSIKeJD3h1O2iWfNc41QAgkMqN/eHvTqUExLJQ17oOFvIcDP64ElTxiKXo/z?=
 =?us-ascii?Q?BXJfmNoA0TAP7Fsmf48wxA8LPFf0Gm7lH0/w7iV/cc/lOQyaZu24fNNCJrCf?=
 =?us-ascii?Q?izVy1bUWVgfgXKHqkZ8rv0ejWeeGSIxovMrAh4lulCm0sS8lb7FVU0U9c5+6?=
 =?us-ascii?Q?V/B8/gvJ/2rUu60bmOpGzOxLapLQXA8IxHZEgTga37ssoDntndRST5CFtICa?=
 =?us-ascii?Q?mCGBkzB9J21RAgDYK5oBfvV5UyZ2Z/yAvbVO1mrBMAMjVj8El90igsI1BmP7?=
 =?us-ascii?Q?fQmqnmgJk6Rn9b3KM/FNpmjSV4zr+yOGOA26ZATuIwUjjKQQcV4o/mNwmAsL?=
 =?us-ascii?Q?huCWbfSC8OxA5JS47IzUVSDxEs4cF6T40OC4mD0yavoNH2CeVsTjNbEw2ST5?=
 =?us-ascii?Q?RKSBw2jgHACwnobHF9SaZm5iPCEi13zOBbgEHvCAqX2k5yi3AwGHMnpL7f00?=
 =?us-ascii?Q?iFP3bHP4kaxvJvLYNndibgfcfRR09/8eUl/0FUlp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7187eaa3-29b5-435b-2300-08db2a408d83
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.4918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzHsqy05cGYIOv0KgnTiySib43bJiCMDah8va0VmyWqwrF0nIZ5bllKQIVJtt+io
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

