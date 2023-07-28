Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E255767428
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbjG1SDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjG1SCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:02:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC84810EC;
        Fri, 28 Jul 2023 11:02:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6bHUSJYcNEc2FLpWNIEBBCxZb4CxnUClDdtOLlLCsIVTtlDVJF2hgk0oGyVSESxZCdn7VjeV3FWOjnxLb+I/ddUlKE2E39Y7NbQ7tcTo2+kLVPsPeohCG0l40Ks4zLuq+cav+poDxo2iDAUKO8fVSjU7wWrshCnS9IVM8u2c6qS5ZY3hAuXFGsB3++TCOj/UkVKWxAaBwbZu+MY6TF0tbx30zbP/D5U9AgFk/bhWk7OPDKPnkMxR7ofIpTfpDxWTwORvr8lSr6b4ebzVQUmvp0CmKRShoH2HWUBsstb0DZ71qPvDBUEFlhHAOqQNkl97N0ClCudo3NV1OHpeUqe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLPW2BgyCTk8zDbbp/I5C457aGli6qxS8mWlY9Mji0M=;
 b=TSY2OIE+DweEORXTGAvC8w5dQI2ovD78ULGywBwPWQR1Gty56wKIRDfGx7LNbm3e/wng9/snGbP61NkyKCLBrrP+9XB48yiEPFoBKjgszjHQ8ISyQ9uJDlLHjNj0IsbivAaOCPZp+1m0gRzLXYRa+X1ITLcUABQsbQCU75XfwdimRRzk/Ahd6tioDD+2Yl5QyBHDKXzlOzecNBIwJl3Jwuk4aCLnHyPHqd8xBukSRGr32WElpJfcp5TTGfViG2Afo3RlJAVRn+hMbWIO/NKh/0vep6FxF6ijNU8vyCx7wUMvErpoE4SDW0tBFV4hKllM5m7i2890hvG3lmv8ybOrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLPW2BgyCTk8zDbbp/I5C457aGli6qxS8mWlY9Mji0M=;
 b=gG5nbPC+RSS9waKZHChBhfztH6MIhVamSN9a9si91qIify4s7KKN3O3rWWRGcFdvuRdcnx0jyvNbxG06kQFPX+/RtP0YqfHl2l2YiDI+ykAStMqJnGf3U+PVZoZcZPh86tQMZp8vUvmi38R03h6mhfO0Dla/Siw7im2TG5vNLcbIsxGo7xGfAhosu42DAGQwuK20Gf+q+cI1mJ9x9dZEhnaGc6+TCZwi7RJep8vLwbxhPSCqoTI7aaeI7M7/JbB3bxzNZh04MKSTSu1mgmAuWrLSbT/eiaG0aopPiS+jXkw2/lH4ojOymsjVwrZ3Eq1gWfNmxCwciSzLB0t6uaknYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:02:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 18:02:46 +0000
Date:   Fri, 28 Jul 2023 15:02:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v3 09/17] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZMQCw2iiIqa4CXNG@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110406.107212-10-yi.l.liu@intel.com>
X-ClientProxiedBy: CH0PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:610:b3::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: ffae6e7d-228d-4d7b-384d-08db8f94d87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHwNk8eryV9rxswY2Jff01oyIaTh4BbKF4Y6M/vPxnBGOQQ3IIUQCDM7qyAeSSGSm0cjNTvOPcnkFXl5a6WeIDGJTt/BHKr92pXjA8Ek8bK9Iid9jwV7PL2pdMlvkY9V4u42kmzMOAv54BffBAtJj7JbvJyozHjhSjNesUsTlq1DGMbaiwb3T6Hykp7CiqqvOQlxImTzZIe+tJtSSTzganylTTSJj3Sm+4dmuD4BRwmqM5VONv9+SXNHAF5wmQT2JWvWNTpw94GSWzK+F1C1HCM5mAdsTzL+9fOKvkUAbFhD7bM/K2jnbu+/ofMNQZTAnhr0Px9QRNeQIsvQ8SCoCcHYgk5ULtx4COAlY4/pbLgNFPcWqafrwbASXevP3HA93QtFNpbOEQlwL2gSJfnpToUzxG/G27ZDvxflxXF+gb+nsN8qGkPNbDvdrngquHT7ieq8VmD6gNZoVSxpj32W05xvLyBU5d/x+0m2VzQ9/uH/0iPL2lMU2m8qZ5oscewQANMOgb60gtAtinuW8siQ9k7JDebqF0Kzloj6ZecGAzHSQFx9S1UdFME+BbG2s+qf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(478600001)(6666004)(6486002)(6512007)(6506007)(66476007)(2616005)(6916009)(26005)(2906002)(66556008)(316002)(8936002)(7416002)(5660300002)(8676002)(41300700001)(66946007)(38100700002)(86362001)(36756003)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NgqB7DhwiCPpuhlm3iGMVjvfTIS6osTANAYaS0T+nXPig2adrGJdRLQw01+G?=
 =?us-ascii?Q?IaPTvJCzjyiFYlMz7Mq542X7CS3Ml056/5b1ycP7kfpAAOMBmZPiUvsPio8X?=
 =?us-ascii?Q?qE1lJtCCeYfKvLdU1CDYPWv3TBa7/e/DPx6n9ECajX2E6GVyB6+h2udO7lQT?=
 =?us-ascii?Q?hFkMO/wQc5kx7u8lOwlfwzrl508674/KhY8bZ/uolRpgddla6n9BVBXC2w3+?=
 =?us-ascii?Q?miXjiAigZiL92Lgs7rnjj8GUgogPpcQNHPOQl8wuuZXBsIpuxBR+pCJPYfTu?=
 =?us-ascii?Q?acdtJ96eFo7RD+IN8ZHalFY/F4mxaXZD38n9SxHXMJ+gxhzvgsSnZCbjq/Rl?=
 =?us-ascii?Q?2jsPjmH0Mn6OTynKGbIWvC3VUjkbJFZYbGkxFN0bjLeIG2ubGsfR/91Nar9a?=
 =?us-ascii?Q?7NJi4T5RMpX7P5aTnjaq8/RRd/9+ttCVcgY11XpEQwO979a+QiFPfycumv1Y?=
 =?us-ascii?Q?9HBARxiZROQU90W9UxrcvbNvx+Fhd4f4DVyIaSmiL0wAeaX0cotO39ctpv0F?=
 =?us-ascii?Q?7HgCbyiFC1W2zw1U38L6W2DpjqtxlMe+t29jz5XA/ozw1bmWv7dwblIfo5xa?=
 =?us-ascii?Q?llUolKD7S0ikwZiI+UOjWT8hiLpeSsQnTJ5l+1X6yN87IQE5sSr4nHDDvrlG?=
 =?us-ascii?Q?EoIl/Bfa1iRoT1dWADXMW0Gks66yZPOCHPn342NwWbr9eJdb6+loSuA98aF9?=
 =?us-ascii?Q?dArWISUh/7Vs18l2MK3aQDPOJEfd/p9VwPRWVGizo+NMDk77CNEelsyDXClK?=
 =?us-ascii?Q?TkTdLQT8IrTNafmgCUCWAnaIP+VXITfm8P+ZYbdWtgyn+XltbDK3VMYFRdtd?=
 =?us-ascii?Q?Nhaf6W7xbzYe1fIxD1Di+ap/VhvocwnGslILF0bI632brJqDA+yH92Tt4VqJ?=
 =?us-ascii?Q?TMGNZ4qW8taoar2bxifhlsaWe+zPbhU8IKCYMYS1np6y8KrkbM6JLtprhWg+?=
 =?us-ascii?Q?KRa0qL+Q6GdQ4M5Y/VGEFAXADIp7K22NnYb1A6aj+5b9v7flsG9JjO/PgT4N?=
 =?us-ascii?Q?XaNnz85zZeFCjjgUKDl/Die/pXs3Ou/EaJak8YAm1UbPY1F3dqMrhVNqXYzl?=
 =?us-ascii?Q?bpPj2xyuzShBpRHfufz3HG24Z9RlPz0NkcssYhb7oZeCQmj9N0R1Z0GHUh1W?=
 =?us-ascii?Q?rm96v+BpIPe/QiESJTBF2f4NgTLfaNxbtMCK6Ts/LDhrxVoAQDD94U4Ss4FP?=
 =?us-ascii?Q?n9vPWoF47I97uNl20cnz9888/PcW1sC1XOdzygF/tBdZH4aXfl6rEQBUjYcF?=
 =?us-ascii?Q?fZiZ9Nh2BFV+trqKIXAVqGVFuIHwCsk7JQ0o8tbSbVKHSMcIw/p25DttPt8J?=
 =?us-ascii?Q?N/B9StvMjIsIU1olIp9oTEINCiLyhlSpRmOR1p6ad2VYpGdpWpQI0lOoZ7yw?=
 =?us-ascii?Q?WMhZ5Am3B+FAVU1QTmM+4XLY0d+s2/YMssgRo4phiIQzQYwd7cRND6RQWybs?=
 =?us-ascii?Q?TOboy+HEt7sMBSavrwpS5j+ipX1k8wrnjbq4FnUAy6baJ16wd6NfDyGRY9a5?=
 =?us-ascii?Q?2ru+AQkIvjC6Vv9G/A63q5zJefuXa2AykTQ3ZVx4v/cQWVhPThi3miHfGf15?=
 =?us-ascii?Q?kqGXwz7CTa6sPl9G2kBLA/QqlqKJv2gHoqDObRMR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffae6e7d-228d-4d7b-384d-08db8f94d87f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:02:46.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5uHyIbdDV25Lc+5hfjwotP5lGQsHtDo1VI4HBloUtuZ4X5EK+ROmRtCuRnEBb7P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 04:03:58AM -0700, Yi Liu wrote:
> In nested translation, the stage-1 page table is user-managed and used by
> IOMMU hardware, so update of any present page table entry in the stage-1
> page table should be followed with an IOTLB invalidation.
> 
> This adds IOMMU_HWPT_INVALIDATE for stage-1 IOTLB invalidation.
> 
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 45 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  9 +++++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  include/uapi/linux/iommufd.h            | 22 ++++++++++++
>  4 files changed, 79 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 97e4114226de..9064e6d181b4 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -286,3 +286,48 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  	iommufd_put_object(&idev->obj);
>  	return rc;
>  }
> +
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> +	struct iommufd_hw_pagetable *hwpt;
> +	u32 user_data_len, klen;
> +	u64 user_ptr;
> +	int rc = 0;
> +
> +	if (!cmd->data_len || cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	hwpt = iommufd_get_hwpt(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt))
> +		return PTR_ERR(hwpt);
> +
> +	/* Do not allow any kernel-managed hw_pagetable */
> +	if (!hwpt->parent) {

I don't think this is needed because:

> +		rc = -EINVAL;
> +		goto out_put_hwpt;
> +	}
> +
> +	klen = hwpt->domain->ops->cache_invalidate_user_data_len;
> +	if (!hwpt->domain->ops->cache_invalidate_user || !klen) {
> +		rc = -EOPNOTSUPP;

We need to get to a place where the drivers are providing proper ops
for the domains, so this op should never exist for a paging domain.

And return EINVAL here instead.

> +		goto out_put_hwpt;
> +	}
> +
> +	/*
> +	 * Copy the needed fields before reusing the ucmd buffer, this
> +	 * avoids memory allocation in this path.
> +	 */
> +	user_ptr = cmd->data_uptr;
> +	user_data_len = cmd->data_len;

Uhh, who checks that klen < the temporary stack struct?

Jason
