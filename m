Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58156E9BFE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjDTSvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjDTSvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:51:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27B02D58;
        Thu, 20 Apr 2023 11:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuzOW0F2V1RhtEdgnTqg9aMaPfXhm3GVlwaSdsKM36UwD8LXH1C/dRupYy7uu8b8sdgbH9Vq4PN7zQ/Y5lP5ppjiVJfUX3TjX7LEp6KkBFxRu4lcHsZ3n+mUG3yw3y84kGv+Y6HN0IHYdxmInsAivS7nkLs4I1kuRdPGKkWuhU9Af9zVK54CaxOAhXVp68s14WJb4InMUJCdGhZN73iT73L9SejrdpxzI5H6K+TmymG1p0UkZ2rseNli+6MDMz9BiK2xPqOF88RK3j3LRy4lxQ2qVN2f+D7LozpZ+cN53WYsV5iNMnytouyhAHvMMSwvJcKwMA4za1aGySioEfyeog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=nLPwqAteYt3CJnbiWUX6yFV7PYi1x1TBJs3qWfUVigx3fSqlApkkug0RQkPsryxGARbJqii9EXyohKhq/0KiU4qx0EOhNKC8btDVW/R26yN59+vXigvajXWas48jPZ7/U99t06B88mCGAh1VUK8m6EA7jOKAhYAFnd37SpVZaE/6kgOgt659Tvpsc/5w5n1iDr1ildzleLcUGpY3r344SAOFbVYaNSXoat99IteB8h9Yf//Ji4RI/2rWvFmiJB7rKXadmHLp2N2c0s955lBPbMZ/XH4KJdSqXS7ZKpCyxxf3JXwE9IbazYk59pCn4BfStqpDjQYGTYMyva2zTpqb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhnQUk2S8XQINgCIGa8jmbCAbr0NSnVgaNKgYsPyH9U=;
 b=Oy8Er7GmHmob1OhYMQj5wSu3pKr6dhAGLqAUxtJ3fepljNzsYE+gFDnecCM85APbkDpctq4km3ToluWb2aUDYzVl6+Gt+BlH+D9ru25th1UCpM0Z018VSqj+unrbTI1Hiv/kKHghq6S0m2Ma7vvqJf5rAFI0fLiT6kKVIE7TphzsqzXUP2f2+W/DT5G6JnaMFEPZRU5mxlnXVvjq48Gc4+vrG/loP0G+k5KVclLDcLmGcP3caRqpCyU9e6R+u2e50eIZM7EQoew5FNcFwCuvSVpQYc11G8kyYyFrqaGjo1hFPOtQk+7ooCyLzzWJbm8x7n4nZ29tGrz8C3VtR2ynkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 04/19] iommu: Export iommu_get_resv_regions()
Date:   Thu, 20 Apr 2023 15:51:19 -0300
Message-Id: <4-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:2d::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eddc18d-0226-4276-9931-08db41d04541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50DOHuJKn7u0daSzRo5LAn7uPJV/pUUoUxRawZzjyQ9nW1DjgEg64f1l/Ok2+fdvS9iJ4SVK6kXJsU3Gb1vEMA81aK/fEVsYcEa+DuaDjejcCv+NmiSDGohhVNlUtep2fUm8xzjdLZLiGtGGYQJ0wM6JxvuE9D8Xf6V7mg9xw43oGPJfzHeD3tDDKFoxupluJ2xSooKWdkhPw8LejIP7gL8lykbk+rE0q2E2njbWySczm8Si+QKS8dLw733dbcjMqFXzqT7+IJpAoZpBbg/ABZsJU7XKPtrEFfoiKMSmzeCUvN95e10c0kiOxuRCOvnxCcmtIe9r+5a/NEv10NaPaF1cbI8oAMJjn8I7QYBDi/GMb0r4gtiNLJ4OmvqHv9dcqLUrQtL6jqzD9nH075e71bGld6YPyrv4N4kMlh6ujwMXufKmChVcPIUfzr26dtJtdH+pYY03F2WWRi/j+zv8/Rt0zw7qFi6m8/Xxn5L0OmYmw/s6L+3TDEcEG7VCi3JSq7Be14VQGclPl/yZhRch+FW8uTvdb5NWZAlTmBDvSV//Nz57NsMYSIRK6VKCOutLw3c3ACuV2o/F2vDzhjapRL/3muuooraLVOMta/HXF6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGMVgb2cITV6bsvlavDZlpQJdEM0ryiTk7zlz+VgXJ17AcMK/M+dGESnkLE9?=
 =?us-ascii?Q?hTa/idXVHfs/GFyvLHjSimGjjja8ZKdeyIQd8+NtCS1kyg8h4kkr5ZDlciio?=
 =?us-ascii?Q?sUo3Xe1TMMVTaRCRR/T2hqxLK+I9fVtvnyZkw8p7EfVJMCPljREJe12PBbd3?=
 =?us-ascii?Q?Y8evaczvQXI1Xn6R8lakQTDppEYVzaPzQu592yheYa33xnbeJWdY+OQAZR7m?=
 =?us-ascii?Q?kG96M54qVU11oQEC9Lpdfqjy7FbQsMbJa8FvQ/Ctv0wqCRF5kgFmRYnWMWBw?=
 =?us-ascii?Q?CiIVqxiVh90KQXvHoHkfzm+vqNfdN2igBo0XdymbWOpwP1TsIIXbOeV2aBRd?=
 =?us-ascii?Q?4ZiwDiSfR2njJqSGrh6eyN+wqSR1Bpnjx2/V0Mzc/5BPCNp5xRzlk5hEJi5I?=
 =?us-ascii?Q?8up9hF5EKs2pNSjDC0AUXFhHYYHg+eta4PnIhGYQbBAi4hvFKPxxsGaxvPYR?=
 =?us-ascii?Q?HoAQz3srblAbdnWYpKCTLml+ZM1TPRQjJiIjz0YUKeBf9+3YeS2u/I3wTTXJ?=
 =?us-ascii?Q?Ha8xM69QGYcpX3h/ZxrxZv7kKYFiFoRV882wqhI7731R5t6jCnyXWfiaEJEp?=
 =?us-ascii?Q?AI2dF5w3KhXRqTBQq1VgdixfAPa21+mx6n7z8P7323nTZakLQWO/vFg990Tx?=
 =?us-ascii?Q?rOt1YGV4HP/ntY2ORPrIqC9ZkOQb5+pOCh8L1nakFjZaPkLCqlp7Mj5BOhO3?=
 =?us-ascii?Q?vp9xDLEwUT3cbQAms4lAKjkKAw/WHyXNs7sI0TxT831PiROFtZQ7Xi/YPzWe?=
 =?us-ascii?Q?hFhZ7hlviB5XRPsbJJ+8LI5geciem4bZ1hkl/ePWXaP59HESKsnY+6JtouUY?=
 =?us-ascii?Q?3xCMjlmZjAk8pWOeeiN/Ip5tFA8CUfmLyydB8d9+GuOyl+AlxcWC5J/joYMq?=
 =?us-ascii?Q?1NlnhtsaL+zaiY5hxqGHHfkfIkeF47uOpUhIGE4u9bCWA+71SA9V10OPvrRq?=
 =?us-ascii?Q?mfKZ/QhwusFMqoEuyce0KNSxdhHstJHQZ1/UbbcwTs0aN9yfojRw2YIX+6EM?=
 =?us-ascii?Q?wlL39vZxN3mXR1a5S7I+kPL/uEH38s7bdWRNlztEJ+PIBeozizZriZ6Zjod/?=
 =?us-ascii?Q?U6gt+YArMWAcw/buQXYTsiLrrCLq+a16wFzlcmo80701VGhxXFX4V1Ns8jk7?=
 =?us-ascii?Q?XDgNigFk9NeAlYYhqQnoqlc54boZsyrQhnt3XaldgLPc+BCQuv2PBx5MxnU3?=
 =?us-ascii?Q?2cDVsETuuKBhCnW86LV7bq7yA97pal7vSUbeNlxN0w/KKOcX9DCPUfRGdXHL?=
 =?us-ascii?Q?HVAhxb5L2aLJiNSbHppiIRnbLs/j23T11cGkm9odP8zL/pTovOhrZRtWY4J7?=
 =?us-ascii?Q?Z/lccG8SoWptD8IrnUSjca5mBifueEcNK7XG+WX1e/IxFwRQj2ef3+btqWuQ?=
 =?us-ascii?Q?xciJeionsVcF2MV8ESrN3lk5sCSPPQtE9snCZuXtaqt36vHgHZY6ffGvT151?=
 =?us-ascii?Q?oujVtECWFPDoUSysPFwSTp+/NC0+/aZSqhBBXHwGioFp4RVWT0Nlch5VciMn?=
 =?us-ascii?Q?IAmjPcC0iLljV1gFi8v/FWXA3ibunfFEZAtKJDTx9GtSRisBCxeXGATFlgoG?=
 =?us-ascii?Q?NgwwkcpSnSTi5EVRg2H1vciL/Ohp+2W4fpxHunli?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eddc18d-0226-4276-9931-08db41d04541
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:37.5648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7PhzMSYPLNDnadCadkYrIU+3+K8DblAFOBc1Cg9V+3GaPjtHI6g1Iqvc0dRvwBQ
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

