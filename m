Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D457C0217
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjJJQ6u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjJJQ6t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:58:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E787797;
        Tue, 10 Oct 2023 09:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0RqTt93KMDgM5afofNRLmhRuSPA/bwlFYESam66iUB1Jj5QYXQbeU+k5dRgdP57XxW9Inpw4RzfTQcW72tRxAH99pzXzPngPikIANtmt+MfMbHNOda+9fs0ycXXc79HXaFclhlVIWoX1UbZlriN6oXqjC+s6kFm2IlS0wEemOuAdze4yvvYwRSuw5M3Puhqdmv9Z3byz9HGLvIkp5LLnAF3lKl0nzEhmiTDLgHBL4xO4BKGLM9xidTbToMGnF/mKaE8RZDdz7X4rwvHgLPxW9kke4GMKGxgM8jyagpUFQ+M+qGvQPjInvr+N4YAADSxDppj4FCX+Um/6Th9f32YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnMOg4+4nnDBbVWOUOCD8dD1tIrbCfW6ORtABwWKxY0=;
 b=mqT8o8fnSYijh2k81u9DgT/ownXYUKvtF58MWKemfhRfgDprdP/ZGJgUTyc5/92ivkyhCqFozKzV10dFc/OczjP1fMKb/wXd8exGnxSULVMae7f4Vij+YBdKk2IwaHNrwFF4CFpXx8pC3fHYd1LimYKc1pNOZoFAZbMgIPL0y9+ZxUby2i33ksBeYspuoLlwykt6DzSzHhahN//4T59nnOpZu1SkyVZW/FJoAACXq1TKb6fzEFc5UsQ99RyYWTc21/mFYILiXRUhP8A+nubaMZDwkZCxq3nkDkcuAXumS+6PGTHWaWB0d8QvKFFPSCAEsPp8bvc3xL2S3Zq+poVWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnMOg4+4nnDBbVWOUOCD8dD1tIrbCfW6ORtABwWKxY0=;
 b=Ew5BjMZNf9b2G62Hfaz7rIqc+YIvKT/UH+bkb3+b+GoWqsrKYnZ42GSgM9pHTA5w+qMc1KGY+Uuj99g2YBqxrGmuDsz0Hl2/AideC1wkflzDLSaLuTxsVQfu7Xx5cX7cMNQH0ONA9CRn9M2Uvsa387lUlFC/AR8X/JGlOG/nzM+Vaw0v32N9IUvGUhTsx0uOmCXysBg8ZUZemtqpQGuZSImyQFitHC2HAczk7Tdzlhm4a6jGGY0shaintYfN8MWBhlJJhFXZWpna5Vc/BF0CDJCWvj8RGiXcaznUfSVatemGDew9DIi9X6JLPpnhZXTf9EojnsJ/u3Y4Z8r5p435/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 16:58:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:58:46 +0000
Date:   Tue, 10 Oct 2023 13:58:44 -0300
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
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <20231010165844.GQ3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-2-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:208:120::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 992a9407-2c61-4ee4-5757-08dbc9b22a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QuXDnzXys2vhHRg3Qey3h31AzqXFpFIMju85AIHZNyO9+6BH73AI9ACE4INq41D0XLhnZuIvWu3mA8ZzUflNw5hypyIJ3KGY87e8VROdi3xUqOmgkQO/5bgaBgVjraQLb3BB7PJUHo4qe5MXwMzRtSaUSiEhisulzA5WkSj6spcxTB3D1yqMgFg25ykzudSSgdRUolhKYBnPnPg2jzhqGCqyHdud0ohN19Nb+Dj5WHnofNvZcL8WJ5WimXV2NIj3oIZHYnWGuKkOOUEkt0RmwNhB/HcNdE7ryTH4GvJZ+1NS8bIbI0a3Ublp8ruWKxIDgAHH9GAwaGUzaGBbyHm6gTsvmlIp42KV6fmaEHPYcPpFMLC1udsCuTdJN9LRRoJJxtyBaEEzcTmhzQTKqBpkJfkhmk/vfOOoAItqdO0BwNlXChvt/2SNNitq2s5QpizgXjhd0+DXaUABxEhoJsq7q+8+WGFKgYouWcRPThvvMXrdSuNzbIr9rmuzv5HgzM+gw2h4K3F2UQ9iN2bLGQNBC3CmaDjD9EjqXdce2FH2nKO0VSJeUtMVYbPdVUtL9n6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(1076003)(26005)(2616005)(6512007)(8676002)(6862004)(8936002)(2906002)(478600001)(4326008)(6506007)(66946007)(66556008)(66476007)(5660300002)(6486002)(41300700001)(316002)(38100700002)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kDT+GYpDBgjxAjqAl/ZrMLdyHAjgM3mtQ0NSY3bqV8Bgzy22P9Jq+9Z0P9F?=
 =?us-ascii?Q?PPT3D6acwNhXW+KhLscJdLoikfUPCKWwYGTw14CHewvtSre6a3k+TLHuYlg+?=
 =?us-ascii?Q?P2Z0UCn67aKU+xAhC/2dxwrjzUb1OakmPhXKUhEaoB64pz5VD5FcQhHxShIC?=
 =?us-ascii?Q?GGWkbo593hsg9OjgXrCPsJH6rsMc1sueVcmGD5stW2Oc6PW28xOVH5J1MIhV?=
 =?us-ascii?Q?lFH//yKTjNBANcESuslIrObuZ9iT1xjNqwGFxeXIMwljccD2R7UFUFvUB18s?=
 =?us-ascii?Q?KiaqUEMMRU6HuizrdJruEGEVpA+VUwD7ovWcsRwx3t20vhx95QkYjEo41YOR?=
 =?us-ascii?Q?PvZ2mAcKVvM7c77kfWn/mgkj+jQmFTujwDXaYXHNA5v7YnKVSmqJA1pyW2h+?=
 =?us-ascii?Q?+9t16RwHZjlkrOrGXPROIOJqwmIS6T/eODDtQLyUeYPAHXzA5mpBCLfC/eFc?=
 =?us-ascii?Q?SAfbyQDqvN3hempGBILNsRK2TuUICadYeLLB4aB726q3HZC5C3PYaPc2Tr4J?=
 =?us-ascii?Q?K6w5AXzhy2H0HIIV1TuooEdgo+E/i4oG1jmd6tpqnxKUqV1HFQrwqSoFcGvn?=
 =?us-ascii?Q?cRrfZNPNJgA+MsIaQQ3Nwvm2iBnCjZd39W/9XtIBdLLwgTLRQoCOf9qNoGLL?=
 =?us-ascii?Q?7RJ267u2uBPfrOuF00DamkPs/GF6bErY+RMm7xJUCG52GghAZSBDOsRWc0aP?=
 =?us-ascii?Q?tfGsyRbYQyCfCGZx5YJcpT2hYtygZFEsbos6lJgluM1BhN2kyvnYnzlzyRR3?=
 =?us-ascii?Q?b9c70jVkoakydcwFy7mrsnapIg2D9vifEEio19kAfVVkn5SELon4+ri/QSMw?=
 =?us-ascii?Q?nr7Dda1++kngao8GrMD8sUjB+NQ/8TtqETwvfgErQAt99h9T8tRy0Fj8zVjs?=
 =?us-ascii?Q?CbkbFYl7RShZhpaC+065fEPfDev5JEkbOSVrTYT1UaIuiQ7ZNr+9HihddJm1?=
 =?us-ascii?Q?HXbyMNah1SYa5uwvpalFEFwhcwYngJNdpqXqg/H+pRdNmL/wh1pZIve67Xix?=
 =?us-ascii?Q?IayCJoSZCkQ2yiSvNYVtdKLT/RbshxnxY20OncknxUIdShpHZWjkucoqEiTO?=
 =?us-ascii?Q?wBH/QO+4On3+uAfCGZ811u5c+4g97GQ9lANfRRtAuYpwUhUaXXj1I0jV0MCq?=
 =?us-ascii?Q?yQsgg1XOlG2jstDNk4pRvrWOI2HjeHhznljpGJkA0lYUtt0kYoMwTS7K1mvz?=
 =?us-ascii?Q?6l15JRog6gHdVswroQ8lvbT0aey9mM6lRPiY+x94HRb0gEMtlRbnxL/ygnXy?=
 =?us-ascii?Q?LJ/NiILi/N8/2WBBcQjGXYTcjLklWVFq05ljvpCAz7aD5ix9tDhlmR4nioT4?=
 =?us-ascii?Q?zQgNlIng7gBBHcCWsXWDQyxgpn1muyP17UJZ4JlSzHwpySwP87QUP/nkVfoG?=
 =?us-ascii?Q?3yMrLdnwh29lmKbx9w/BHEy3dcdZYT+MoiNX4z1+ai1OVriZOljeIsog2yfc?=
 =?us-ascii?Q?v0RdL+Y2mW/YKRvtCT7toNuaHGRVWgAU0nLnQU41ExRzGfoHQ5LFUYKGJKKu?=
 =?us-ascii?Q?s1aqbj5fNduW39XXGQ/U+41wKoLObfJd0QwC8Mq59oHMeUITE656Pmsri88/?=
 =?us-ascii?Q?Wl4+BjBY/w8hxPz0uAnXwKgIZOw9EM+aymruZAz3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992a9407-2c61-4ee4-5757-08dbc9b22a84
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:58:45.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+ripi4TUimpiu01ycSBW39AOUBMQCtuHG63Jw6nkkA69OVY7MgiTJpvP90gvmJu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:22AM -0700, Yi Liu wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 660dc1931dc9..12e12e5563e6 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <uapi/linux/iommu.h>
> +#include <uapi/linux/iommufd.h>

Oh we should definately avoid doing that!
  
Maybe this is a good moment to start a new header file exclusively for
iommu drivers and core subsystem to include?

 include/linux/iommu-driver.h

?

Put iommu_copy_user_data() and  struct iommu_user_data in there

Avoid this include in this file.

>  #define IOMMU_READ	(1 << 0)
>  #define IOMMU_WRITE	(1 << 1)
> @@ -227,6 +228,41 @@ struct iommu_iotlb_gather {
>  	bool			queued;
>  };
>  
> +/**
> + * struct iommu_user_data - iommu driver specific user space data info
> + * @uptr: Pointer to the user buffer for copy_from_user()
> + * @len: The length of the user buffer in bytes
> + *
> + * A user space data is an uAPI that is defined in include/uapi/linux/iommufd.h
> + * Both @uptr and @len should be just copied from an iommufd core uAPI structure
> + */
> +struct iommu_user_data {
> +	void __user *uptr;
> +	size_t len;
> +};

Put the "hwpt_type" in here and just call it type

Jason
