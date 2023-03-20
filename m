Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B96C140A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCTNy1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjCTNyX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 09:54:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9950B59D0;
        Mon, 20 Mar 2023 06:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juSXxUS5qzHIB9KdT2XXmLCSgWeI+PBHm7Q9oegdmCtSzZVXD5+AiYHADG/w917/xNGYXaYXpVH8IiBAaN6eirtsRSSMOGh+bEWRReakGTXbc8qpN8Z6z+SZMbtN/n73XXBCRPVzMsw11CtAKLRS4/flL4oShpunmWvhapd4/bVJngr5JuOGJem0qVeytuuwSH3EgbbJgPp2EKNqL43yNqso2fkSduflisq+oxWeqmbqia3xjnNxeNWO4RO/G/LOeP8Fr+6J+f/sxVFYCjskX3FSQ4zAZ663GK41Zi5P7eV4ib7VbH6H71kH5c1p8LMfucmjTQ6pvyKFzVWK8TeuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLiuWgCapn1oGXN3CuCdD7SwzlkXws8/4vyW6MsSPiw=;
 b=EB/8e54UODJF45gFnIu5Vc0Cxh/9JScnFZOOVtdQReYMZofqo+HwoXND/8f70QQ6aXOB/6RHa/hoeZczksK8TwTRDKM24wjF85Od6Cdjqx0keXmZiV+DEKSLy+nwI3yqUjAviK5HTIqKb8/WdJfnL/FMY+R2LJxlPLAJ++rzBCr/rF1gdzyvzxsH4NxPLARDPxip7GxMb5FDH31hHSOHMddrKLYoLJk6mnfPq7+rqWIXmzwAwJyHHSTAgNmWyCn00PAJTg/qmqOfcFtodJqW33UYXMQV+XfTCfW4Ws8OTHFnHgwS9NaSLOjqTB1d31ghi8iwV2OUinMVGsO95wQA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLiuWgCapn1oGXN3CuCdD7SwzlkXws8/4vyW6MsSPiw=;
 b=MDOk60rUNnGODqN3V2RaxaE286WF9g8Le40rno7GZefEn49fJ/YBRHiVnrz0scJ/jP3tqm2DYj1gaHYTriBq5iUoB6LrnrJv1AtZffrJuob7i2aFJa9oY/l6kFRQHlODfQX0+QASu+gqC3hZBiMyPTZ4oE3jsou52bf7AClHOhtSCp4VTy6WLxG2EBkrVMyud7UFU+a/uz9UIdVMWBeh7iIVIPHA9OY4ekcffVDiMAYsHgFInvzX6fjXRbj/QwGNui4bzURmJk/KHq4ACnfMOcDE7V04G87Rdub6xPZF0eruyfPXhXkIa451cQ0/ccmBck7SOsCoafQLWAhj/k3uEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 13:54:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 13:54:18 +0000
Date:   Mon, 20 Mar 2023 10:54:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] iommu/vt-d: Extend dmar_domain to support nested
 domain
Message-ID: <ZBhliHzXcbUxuyX1@nvidia.com>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082207.612346-4-yi.l.liu@intel.com>
X-ClientProxiedBy: MN2PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:208:15e::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: e08e61a1-0054-4044-e429-08db294a9960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq8UE5MLRNwlV6IWSwl4rHdwhAYbv0ryM+6foHIGQ66Jm1qitsg2bYsHnzUMUVrbjor7DqcGTB3iyJQU1JgSWH6A4xzUfNfiSdkqrMem0hI6KR95Drq3M8/sdb7X72ntVXSUC+0lmYKEIBvMvIaNdkTVqDyN2OhKeuO+7aIPcbpPfl6aUXpCiajZTFiLpN9XIGjPK/d9RzwZRo/vGV2YyQ5TgA7iy0ZX8E1BEwRnsh9+fnApbHqTnWJ3lgZZFb7Jb4ErLjStKUMLFQqERlGDyZBGpWQZg1mFzV2Vz8s1aVH6CcDhElwPHzNG7MXptjfj9recbScJjCIOpuUrfDDhT77FF/Jh24fpVSiANAxDgHz9BgczXm+jsJ4WnkjTruOfmjS1da5drvLOXQJEvr2J0BjUK6qLrlUsY7q2uJXcvmhGAf3jiGKsUu3C5m8IuCLWdgoSfG8nTu5/cRfm+UvtIJObH7rGObAuIkjVGOrnjxreXl4njGz/3lJCtCAbzdxARbNc1TdEbT3N5EbzMjePHt9ROmsMJEpHvJl+9+Nd9fcPHb6atuHtRiKB1wLWKvgH7WT+slBf6Li20uNYnuWAHoOexz2cIproPv6TGq7N19mhFIiVQtvEihHUgU1Ci64PI35dFJRkHXEqVqZfge78Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(451199018)(2616005)(186003)(6486002)(4326008)(478600001)(83380400001)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(26005)(6506007)(6512007)(41300700001)(5660300002)(8936002)(7416002)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkDUyd6hBcmDbDKH1SVd5DL9HiaLxeFmoblhixf6BCCEcRrQY+ftKn9Bf9+l?=
 =?us-ascii?Q?wwucIRymZ2C4IgjQe7jZp6Yx62IXjE/HfBsIxbllBPiufdfigwaf4U30OYJr?=
 =?us-ascii?Q?jdnbjwxqXoRkyZYz3sYq7ZOIyEn8DHui98Y15ZeJtcPEa8WDdhLdbqm7rh6d?=
 =?us-ascii?Q?c3aFSTZSLQfRy1cniTqlWJtUFM44AOelDyh1+oXH/4lSDxlBcr9amZl0M3ve?=
 =?us-ascii?Q?c5k3Pj82lzFxzAEmrKEP+nnkiq23XbA9nOgvDYDcyMJXJaUDghtVvrGT+LIx?=
 =?us-ascii?Q?7jk5OHLQiyP3kF9iy05yrDwdFlo5UbsiRg4JbV+vUW2HNMKVKJIXzxHkmJPZ?=
 =?us-ascii?Q?1HJddEjVg//Le3AzPxBNX5VMo1ximwxRbSzIFMNzGfJf3JMCELzA21X0TlLd?=
 =?us-ascii?Q?BNsod6mjdZ3oOG4arFwZEUKOH/RbIF2LFIvdlIxjOc9O8w8e9biJaLTuJ8MO?=
 =?us-ascii?Q?pHlQdY1EQ5q8gelgSJJLbrcgu+uTgi9dh8cl22zVJW+ncNweW7xYU0U03F/w?=
 =?us-ascii?Q?AVcP7zXhCVFWgmsnJbk1caKCK+7W7nshBIHV6ZB4zEeNO77ku0ode+g5f41z?=
 =?us-ascii?Q?TiZAuMwsKq50XoDSmU0RAjbGlCW6+5tPBhTeJJ7lOj0n2JT5gdKD+GIq1b8p?=
 =?us-ascii?Q?zF47TbgWrI/+xtUUTDlnQ8lFfLQqSZsxV0Te8DhyhuxGTvyuV1aCO6U76oVC?=
 =?us-ascii?Q?5zbtRLqc36lKEYIQSvyLQ/xVsMBVWRN3nYGZJ8M6GGxw+X8IYYZXI65RyeLk?=
 =?us-ascii?Q?9T9f558k6dXOTqUI6FsWveJjLuiQ8b1C54/THVZbqQeak0DJLJxPrP6R8GQ/?=
 =?us-ascii?Q?gcGA+l11evUksbyMzFJSoYVTmG65EzQqvoYpEZCgiT0KVWEekTCvdWKD2dkA?=
 =?us-ascii?Q?AciBDwE6hwa9CHWSMrJcQlxPTyL6yHsCmPj0+Wa8qskZHdASLtLVuPrKG2mM?=
 =?us-ascii?Q?UOtWmLMPsSksBz/DDwxFJKGzahABjYjM7OeED9yL6AvCnr6ekNpzuyHogHkf?=
 =?us-ascii?Q?aqPtPibKt6lUkMzqUSngXOlHlIUpq+IHDZ6y9ycf1IPz+0rCuH7mSRiZ6aHw?=
 =?us-ascii?Q?pzCQJrMeEqI3d99h+5BmgAGElZ1KOfxKxTPLDXN7CtfjoscYftE6b0hfDWbl?=
 =?us-ascii?Q?lGp2O+8bI5TEGGBLzAAt/0AAYgbnQZWGbfdzXO60WaBd/w+c7/1R/f1DpfP8?=
 =?us-ascii?Q?uZD/fLDiOLp6jdfFQW5aAUtQhzwVkd1B5ztxLOeZ8mhNCoGwOszt1eO3aPkY?=
 =?us-ascii?Q?S1fYh0/MflOlTLSb1Mt28KT2p2RzaVJxPkwE80yiqOtVkpGnpCo4BNkDK4CX?=
 =?us-ascii?Q?hfrKKmZTGZRURqcVqYtPslQniiiIXgSdFlDuWUwZUXlg7/FpL23iMvvXbJB7?=
 =?us-ascii?Q?qwpdMDzEqvb2JIPMc846MEh7K3Df04TyWUaa5ZcBhUQhiusBoSzYuirurtfK?=
 =?us-ascii?Q?bya08OuKDRHxH1OHTwIYTVcUClAO5ioflL+MZDKMhbiKYXgZyIMUeq5/GWpX?=
 =?us-ascii?Q?O3UBcTJuKNp8PZz3AkJiBm/gSa07hyZaxbMGPhm/0PUeVWakI5TrqrdId0lE?=
 =?us-ascii?Q?TqnSohm27z6F/dI1MmN6a8pRz/qxK/k2RUT9AcXH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e08e61a1-0054-4044-e429-08db294a9960
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 13:54:18.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVkwl4i8ixTf1hbags9w3Ee3ai2fmqCW+gKe7Isr841kyne/UP6nB6/miUL6Pree
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 12:22:05AM -0800, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> The nested domain fields are exclusive to those that used for a DMA
> remapping domain. Use union to avoid memory waste.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 6 deletions(-)

Using unions like this often devolves into a mess.

You'd be better to have more structures

struct intel_iommu_domain {
   struct iommu_domain domain;
   [general fields about attachment]
};

struct intel_iopte_domain {
    struct intel_iommu_domain domain;
    [stuff describing the io page table data, pgd, format, etc]
};

strut intel_s1_domain {
     struct intel_iommu_domain domain;
     struct dmar_domain *s2_domain;
     /* user page table pointer (in GPA) */
     unsigned long s1_pgtbl;
     /* page table attributes */
     struct iommu_hwpt_intel_vtd s1_cfg;
};
static_assert(offset_of(struct intel_s1_domain, domain.domain) ==
              offset_of(struct intel_iommu_domain, domain));

The per-domain ops allow to make this work sensibly

Jason
