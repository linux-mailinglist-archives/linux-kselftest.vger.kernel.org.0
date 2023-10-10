Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C987C03AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 20:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJJStj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 14:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjJJSti (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 14:49:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF07A94;
        Tue, 10 Oct 2023 11:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR7mElfEj2F2fbYqb+WqJzHUi51ilDhxkxVbkXO/nOp0xfULBfHYlIvuWXd4fVpEQGqvv9SjP2FCyH7EqkC1UoU2MqrTTZJesrf6Yt8bujU45EOg9TEBEFfgPvKawAtxmu7KjRjE3XF9lsQv78jCGRVXel4yTMi7K7IErgWdBPFhEMKf9eFEk15FnCoaX2zf6ai7/I076zADDlBq73HbY2b9IlzdRx+cFIZ6o3Gk6nP+JlwcVL5enudqoJVBcIgFRBKgPnlbejvgCJOeJCB77DO3A23kyztie12UucOjLngFt1Bgnkk7RPk6F3KPjgkiTyyiWk2zu73tJ3WM4Ik62A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtmsBxkVkAg7nRtnO2/tQduP1l9TWdc5gW7qHbKkgyo=;
 b=U0nac67bqmEWKfZAv1O4x9Z5AcJf7veJusSeJXW/Qk2SSH8fjIBnpiSs6JOCf0Ny1yPFRQMPH8fN1dVBbWsAuT1M9s78PtluIxh+PIom7BqcUOLryFITxKnqqs8jTKPYP3y30vxrIHQoC8fLU+zpQHqYHQuu/PtbKJBFScOK9Z67eP4dkrbIKY+GdSZkdnprQksZSPPwjzmvWjypO14wHMuotdtYenL2X+VtDh8p/sMpOBqpmNVfTNdv4ANQ+y3U+IdrHQqTYs5S9SF5Zmavs/8u3xSpw2M5ZfRgPG61FxWXP86iBTo1e8QQnjBf3QCS7HIW0kix35KL5/UUXl9ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtmsBxkVkAg7nRtnO2/tQduP1l9TWdc5gW7qHbKkgyo=;
 b=nYJbM6kPItBYd5Ymz9TNL3M+mmv05r6ar439VfAoZZ7KH8Lobuxd78pmRLMvvuG44O7+DIARRFZDk7lQsBOq4rQ/bNtw+SaB3HFxNQHk65LNAZ6SWI8YO96pdxc0hhnL9Rl1i/4R0b2LfieN5TiFejS+/uoGjjeZfGce/t0V8EGM0cFGuu4+1VvZz2MqnQL6UJDJkDQeIrw093hoNMNp9s4ByA6nLbOfAk8rM/vfvVqRZj0CziX0SZpYaSX6i8XCAKxwuDPc3lYB2hzu3MEd9AXt5OGUaU5IAzTdi7AA0M/Pn9idvYvkP9myu9tIi8YJKr+jUOTXht2ogs1y7ad87Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 18:49:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 18:49:33 +0000
Date:   Tue, 10 Oct 2023 15:49:32 -0300
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Message-ID: <20231010184932.GT3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-6-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:208:32e::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d914d76-57d9-4e3d-9141-08dbc9c1a4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFCJghWwa6aDzy5sRoRsTnOqK1+Q7qkFSsnz7R6bT2H4IaziSR6/K2YJ39NbF1iUJf8RXmTfsbwn2gy6Kk2QsBPQ/6+CDYZqj4xu9iUV9ho6+8NBIszAbGJI8KHjtPr4iksl914P/nU+pLt/mLirk+ML2Os+hwBq4QtSXlGjq75QaRDml9ynMXjsmk9PjIS2Ls9Igz6TDlytYvqI4u7wrYcmxYETzMFTefLUZTNoFEgVxszD7URQyn4YiIcwKbbAjs+es2uXU5NcUpStpo7N8hbgZZP7/4DSnMlBPEPxBzzKKvXgvB/x7K5wMuKC+uO+dQzomaQmQnbvCoPZaUOHsdKlchuKhDhHQ9nG4Y9N6fcjIcdYzq+ixzO3lnl2sy4ZLkhxkaMqilCF/M7gKwYmGgwt6ADZDAw2xgLuwA0MG88klfh4QOxks61uMzYN4TC7eYCIocp8Phn4sUMHQx01wtb4fprcAd+vwlffJ+f8MKtrzSQXbZ/EG2LaxMPoMg85htgwQgQFr+fEx3AwfOewYH9H2eeHQWhn/oYhy8d9aVco8UFREFidxvQcbQMxTB2N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(36756003)(38100700002)(33656002)(478600001)(6512007)(6486002)(8936002)(4326008)(5660300002)(2906002)(8676002)(41300700001)(83380400001)(1076003)(66556008)(2616005)(6506007)(66476007)(66946007)(26005)(7416002)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zZCi+x7VpwH8zHntlvZVweUPEVtqlVReA895wTkAJ37pZf9a/3gi1H97Opw?=
 =?us-ascii?Q?u9wHj8+SBMLIxlYB8PdxznLADHmni1vJ1S0rjEid8Sij6zhhC2b1F9c3CzN7?=
 =?us-ascii?Q?weOe6X6VdjSZrf7sPsWMN6cvFwT3d+WpB3zokZjbIbp7UKDIBwnzlPAdhUSV?=
 =?us-ascii?Q?DseCUuiTnBOdyy+8WrNDB3mNQyytraPNkKqFLs1yXBgXX/wVhdFbjK6VI7yT?=
 =?us-ascii?Q?6PgCIyvxNi95+pj7eUuO+RUf9IWF/nEAGZOlb1DhhHF6I7WBVJB8zH7yD04+?=
 =?us-ascii?Q?El97FQlmgMGrZJF0kvrYHdz0Jge/UcWg/M6NeVPP3HgEUrINiM+Q8LAwSqJa?=
 =?us-ascii?Q?no5+Pk6Q8c3TGJBhcnJzXnbHGfObQULQus5Z3GvNd9hgqrN9G/EQavWIB+yl?=
 =?us-ascii?Q?nElAp9+RRSHzImTV5Ti/iM67geh4pROw8pm3ltBb8hDE1KdaXiTMAD5uNLp9?=
 =?us-ascii?Q?k8GH6OQOA0iAY4XNX04Jqpp8qjM3RnSy+QeLxM7E/aQmjzrPH9BA9ydJMlnF?=
 =?us-ascii?Q?4UYSv14IrxSY/RIXqLfRVOhC/sLtvco6hI9u6cXjhtG5TFzECOeJejwpEDll?=
 =?us-ascii?Q?e1xAO69dgyEPptYqPsxtKgLYEIcVz2M2DJVwjFHLPwzS6bwVK0WvJlEiVGL3?=
 =?us-ascii?Q?XXr3G0t7e1U5osPWbPi+9XA+0yx8DzZlzimh7n6CcQT0ui/Za8ztklXgQvZQ?=
 =?us-ascii?Q?IxQOQM+mydzbcGABn3BBcTsbwRylP75OxYBMH5hnGoQ396ULPBn5N85M0iVF?=
 =?us-ascii?Q?7rtP/4aU3XH5zBrd6ziC9JOxK3eKIet5VxZnwSClTXmVCWaZGJzxkAmgcoaP?=
 =?us-ascii?Q?Oqu9IX+Gf1NAxmOY6uUvgg529rzawXGbBTRiqftdr9IhoFWbJo0ZZE2MkVHi?=
 =?us-ascii?Q?epFElIGDrpGADwNyuFysYmBeLlhcdxuRwHv6ceFXUeifQTkijoVnD5uqI/Tk?=
 =?us-ascii?Q?Sd4wYyuRr3hzBc5UHXmIcA+b4PUrO/uqtsF6oBEbBB55OOs/UjzvifBQd0M7?=
 =?us-ascii?Q?48GpMSdSPh6jXKWuKAijLyg8hhdQMox1MPgKIm6flCiEn7cnvjL2mHlZ1Rmo?=
 =?us-ascii?Q?oeMHrLHqIolpAF1QKp4XALA9/kA04sG7gIT77KnVLf1NkZcx8onrSs14C2i9?=
 =?us-ascii?Q?9cbyaBM/J5w8rhlqpQWdHikgOJCW3dLIWWghM+tYW55abCvS2uwFSVHDRn21?=
 =?us-ascii?Q?/pqpnhmbdZX6vQbu9xm0QrAJgS72LAeZQNE7Wt1//ADL8slG8c1z2/i+qnr2?=
 =?us-ascii?Q?CDuBIs0V0jKnljxR7gWsiGxRaDFNi0zq1mGhx5YWtIgSYdKMVv0FCsNvsvny?=
 =?us-ascii?Q?GUMy3gCvHmWjlTss+HXjv0N5T3EdV6ZrCniYm2AuUdtC/5RTFHq91h4AYZi4?=
 =?us-ascii?Q?3fGOVSpwhTmdW3D3y8C35oJCkCudqSMQ6+phAW09ihD17AmvWDUePFpIcmwI?=
 =?us-ascii?Q?q7sC1qUuQANIrjzHawk8RQNL9sCJFGxbTwzIrAR8zfjDffAzLMlpUa445Si5?=
 =?us-ascii?Q?SQebtyF+4P8gvY/bddZeHeVk7u4/EiqMUnUmhuDrpsm4ru3fG6Pd0W8Jtku2?=
 =?us-ascii?Q?UFDFmgBhuCke8OjCFdsro+p/Ov3U7svhBbzMx8cI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d914d76-57d9-4e3d-9141-08dbc9c1a4cd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 18:49:33.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2bR2og2XlC34rrq+6tb+gODmrqaMEP7zsCjzlAcCI7pM2JU4y1FAGAguFmR/uZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:26AM -0700, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> As one of the previous commits mentioned, a user-managed HWPT will have
> some different attributes/members. It'd be more clear by having separate
> allocators. Since the existing iommufd_hw_pagetable_alloc() serves well
> kernel-managed HWPTs, apply some minimal updates to mark it as a kernel-
> managed HWPT allocator.
> 
> Also, add a pair of function pointers (abort and destroy) in the struct,
> to separate different cleanup routines. Then rename the existing cleanup
> functions to iommufd_kernel_managed_hwpt_destroy/abort() linked to the
> HWPT in the allocator.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 34 ++++++++++++++++++++-----
>  drivers/iommu/iommufd/iommufd_private.h |  3 +++
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 554a9c3d740f..1cc7178121d1 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,7 +8,7 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>  
> -void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
> +static void iommufd_kernel_managed_hwpt_destroy(struct iommufd_object *obj)
>  {
>  	struct iommufd_hw_pagetable *hwpt =
>  		container_of(obj, struct iommufd_hw_pagetable, obj);
> @@ -27,7 +27,12 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
>  	refcount_dec(&hwpt->ioas->obj.users);
>  }
>  
> -void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
> +void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
> +{
> +	container_of(obj, struct iommufd_hw_pagetable, obj)->destroy(obj);
> +}
> +
> +static void iommufd_kernel_managed_hwpt_abort(struct iommufd_object *obj)
>  {
>  	struct iommufd_hw_pagetable *hwpt =
>  		container_of(obj, struct iommufd_hw_pagetable, obj);
> @@ -42,6 +47,11 @@ void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
>  	iommufd_hw_pagetable_destroy(obj);
>  }
>  
> +void iommufd_hw_pagetable_abort(struct iommufd_object *obj)
> +{
> +	container_of(obj, struct iommufd_hw_pagetable, obj)->abort(obj);
> +}
> +
>  int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>  {
>  	if (hwpt->enforce_cache_coherency)
> @@ -57,7 +67,7 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>  }
>  
>  /**
> - * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
> + * iommufd_hw_pagetable_alloc() - Get a kernel-managed iommu_domain for a device
>   * @ictx: iommufd context
>   * @ioas: IOAS to associate the domain with
>   * @idev: Device to get an iommu_domain for
> @@ -66,9 +76,9 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
>   * @user_data: Optional user_data pointer
>   * @immediate_attach: True if idev should be attached to the hwpt
>   *
> - * Allocate a new iommu_domain and return it as a hw_pagetable. The HWPT
> - * will be linked to the given ioas and upon return the underlying iommu_domain
> - * is fully popoulated.
> + * Allocate a new iommu_domain (must be IOMMU_DOMAIN_UNMANAGED) and return it as
> + * a kernel-managed hw_pagetable. The HWPT will be linked to the given ioas and
> + * upon return the underlying iommu_domain is fully popoulated.
>   *
>   * The caller must hold the ioas->mutex until after
>   * iommufd_object_abort_and_destroy() or iommufd_object_finalize() is called on
> @@ -103,6 +113,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	/* Pairs with iommufd_hw_pagetable_destroy() */
>  	refcount_inc(&ioas->obj.users);
>  	hwpt->ioas = ioas;
> +	hwpt->abort = iommufd_kernel_managed_hwpt_abort;
> +	hwpt->destroy = iommufd_kernel_managed_hwpt_destroy;
>  
>  	if (ops->domain_alloc_user) {
>  		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
> @@ -121,6 +133,16 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  		}
>  	}
>  
> +	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_UNMANAGED)) {
> +		rc = -EINVAL;
> +		goto out_abort;
> +	}
> +	/* Driver is buggy by mixing user-managed op in kernel-managed ops */
> +	if (WARN_ON_ONCE(hwpt->domain->ops->cache_invalidate_user)) {
> +		rc = -EINVAL;
> +		goto out_abort;
> +	}
> +
>  	/*
>  	 * Set the coherency mode before we do iopt_table_add_domain() as some
>  	 * iommus have a per-PTE bit that controls it and need to decide before
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 1d3b1a74e854..3e89c3d530f3 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -234,6 +234,9 @@ struct iommufd_hw_pagetable {
>  	struct iommufd_object obj;
>  	struct iommu_domain *domain;
>  
> +	void (*abort)(struct iommufd_object *obj);
> +	void (*destroy)(struct iommufd_object *obj);
> +
>  	union {
>  		struct { /* kernel-managed */
>  			struct iommufd_ioas *ioas;

I think if you are doing this you are trying too hard to share the
struct.. Defaintely want to avoid function pointers in general, and
function pointers in a writable struct in particular.

An if of some sort in the two functions would be clearer

Jason
