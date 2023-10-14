Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA87C91A8
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 02:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJNAHQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNAHP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 20:07:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA9AD;
        Fri, 13 Oct 2023 17:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XH0Vw2AspqsDm4Z0ZVY3luqTCC3pGgVFoJF3WDI9Rui6MLp1Lex41tSj+WGaqyYV9Ga5EByACc4PJYqOPPpp85X9ESMxphD259pMojvQX9CdTaBu1bGmcOhmENflYI9P3G5UONCMDEFnpFp0ld2Ig9gb8+YND8Bkvdjiutz+s848pzpyEp4BZAZaluqvbmextyFDbLnnddrzX7RvuuoJB+rXk3v5cWld3nZflFYtEJM9ohSzM31vbhMiovcXhcR6HWiA/h62Ocf2GLII6fFQRc/9CBCAPhymEf84/DdPliYwUEW6IGV4xBtKdUH+SS092I1EhLkT2PnzWbtLDeLqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu/mYKw+sKY8JAX0bFcEEBT1BIZRy9tv15rnkkjHKWg=;
 b=j/0FJEsvD4pR0kg4Tq8jX3wHz3goGB+eKx+1I79VT0vDITnweQ2HRcsTJ6d4rv1A746sibP0YHwc4Uh24HZaA/e77clKLjHSyHIVi7K32R2PsmkaOg74dFsti0pFmwvWOsafPb4Rm6XmfQygOEsfz5ouBQP0vZsPhK9LUYv1se8ijTO1asJuNv8c2vLhCp44KQ06R2x6KHzxBNBHLZY5JTz8b6wKTZO428b9X3oew9xFR2ll0sogiqMJr3pXbuRval+sea8jZatTSRZnpunjzowoi9AO9qlnZxkClhsiRvRj8mBJPsFly4zlitUZWxmQHkjeFqUvHSAnHUdwatEIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu/mYKw+sKY8JAX0bFcEEBT1BIZRy9tv15rnkkjHKWg=;
 b=P0HifBIY0ENugtdlozF0ywX1xuKak1EHxuS5PCLznkeOhJs3xG6tJYvlVZtiqJ1rxUdnRP9ObUCURG9hN3xvJhkpuoAmHtBzD0esPRE/tdwDMnIZztPqixJJzn/5+BnX/o1agSihyTjelRy3WT61FhpETPhOmTNWcNjTx5ywnDdgJLfVySPR7a0KhZN8maHpoVZak7i4wO63GmcSXEGujSe39PJMfvpd5YO4GrZ30G5xnoLp/nCtce55+HNgaDnNAhdKeRuIG9+EfxeQS1/LN2PhnvK60GGiEDw4W3Hn+xsJAgos5GYAtPJTtK9pU3WWhg1mDtGLmCFSEx8/0YaF0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5339.namprd12.prod.outlook.com (2603:10b6:408:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Sat, 14 Oct
 2023 00:07:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Sat, 14 Oct 2023
 00:07:11 +0000
Date:   Fri, 13 Oct 2023 21:07:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Message-ID: <20231014000709.GL3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR1501CA0036.namprd15.prod.outlook.com
 (2603:10b6:207:17::49) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 20081fcb-d169-489b-9ff3-08dbcc498359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: glb7SJ2+P68TSZgw9acq3qs/ciOBA65l65zJrOCG6x1wKBNlDcKQjBGpxKj9HM8QwVoZk+OEMU0Pfp5Uo5FLbH/dRGTS+ILi+U30y1vTnDs9UF7IddF2sj+DNN7Bx76dhnCWlEt2/6Ef2t4JdEyOOI6Q+yHxzZWhk33gYjqS97PVBOPi9osr3FVziqsLJeJ0N0NKDE9EA4eVpp9L02rxI9tGisAcdYRZFCb4VSfwtjPyFlrCpI+Rz4q5+f4vjpjtx4SkmwefdPd8mu/17BvE5mF5d34+T3/C811ICRy6JCU5AE9tXNuhzjfqeI1xgT6LW4JOnUXLz1dBAJeEo1amyPsaQN1xhtzeppGQDPjgu3NcrubjA3uXInZeCDA2pbRXpQ78rgeemroemnQPhcp2EV+hvZqxHfr/KmNFbStaa5N9UTl+j0oJMPpd1SlIeDVLAUxbVNc+3nWsu8rVGIdZxSl3anxFyK/TtbzvNVvhh/zrNnBMZRqvjCG1c5RIv+AbZrJeSY6HHuzwc4nnaTJVTrdeNmQfve+ThrjnZm2QXur293wYgBwslDT3gJEdwA4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(478600001)(6486002)(37006003)(66946007)(66476007)(6636002)(66556008)(83380400001)(86362001)(6512007)(36756003)(26005)(316002)(1076003)(6506007)(2616005)(38100700002)(2906002)(33656002)(6862004)(4326008)(7416002)(5660300002)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VmUI8S17GkfeK5pDXMFlpjsJQqROAjd2jMQHxt9mhlKLOmtSWUZv5U+Mc/aS?=
 =?us-ascii?Q?195r579bT9oOPRcx3YArtzdUhwIJ2io43e++egAfCIBNAhBMm5+teNw10idA?=
 =?us-ascii?Q?uwQScuBfxQnCXKrN/hqR8evAmROz83kQ6pYq3/qN7HtW/TT1lIxy26+B0IuU?=
 =?us-ascii?Q?tJQsUR05DVuGJGHn1SNGevVHBbiUBl3GVddqZV4ztY+OA9Hdyn288KapksRj?=
 =?us-ascii?Q?XMZs1b2zvKQEUz25A4iKhm5rW9PnmrNv6vfKXxQAdyWNzZNwHRrW+Zt9lfC8?=
 =?us-ascii?Q?JtFEGQ734Nam7zLZlhE1+KYPCvnYmUQJICS9UaxU4wZgV5r04oGHilQ0CH1m?=
 =?us-ascii?Q?yknqjaqoQkbMN1w4EK+x3FDzG/n/Pb7J8RjJE9TmHuUIBQjD/jwOUeVUruc0?=
 =?us-ascii?Q?JL5uCe+POeEWjeN801Awe6Z5u+Gcb9KmBkdqr/70+42xZGNIUgcfyuhFSInC?=
 =?us-ascii?Q?J+dv4sRTYDYv3QXUW0eIwrRoAcZVGnltQxjj4LCs4XSM2cStsTfB3Mfhh4Kz?=
 =?us-ascii?Q?TEnxd+1wMukB9ackbNdETrpGS9EMmCZr8uGpwiQDYx8gkLLhhSG91zny+Vr5?=
 =?us-ascii?Q?MtRZVup2xC4qwLK3p5AtfOWlIF+EqpsbrmUXYfTR2pgTEGqpnAGWotDEy+CG?=
 =?us-ascii?Q?ue+KDyFek6o1D6nzqZtReJk1jDNXsHhzRqzIvQrVKrOLcwtnk6cixq3YP9Wo?=
 =?us-ascii?Q?JTCk38TGg9m8NupjNJYmkaU+CZMdFBQJAU4mF2pSe9lxLbkJXLbIPYtIbhoy?=
 =?us-ascii?Q?MMZ10z28uSAwITZ8YJ19GH4fWbapvc8jCCU9aZ4lpBMSB0SlFRhu4OE6jvTP?=
 =?us-ascii?Q?6YB1zFbXM32yb8Dbe5Kb6+NV0vskfYx6rbCQ+Q7JDaCZkQJwvhevatRIMEvC?=
 =?us-ascii?Q?+eVTzXfeTGs6XOHqu8pjbrArhuPQnW6vZHi3tHCwtQM4Rr04rnf0ickrAcPC?=
 =?us-ascii?Q?fdxJrTM9HgtA+OVXZt0qHybyFy0csDdXWMN3k5Xsa0tAMXTH4ujOg4U4oiUJ?=
 =?us-ascii?Q?e/rDfVNkU3fTUHzfbMMvg70xlWfvKRGAsFeMwn4AQU2xlc9ESyAUHAqF1o+a?=
 =?us-ascii?Q?h1NWXKrjTSLF64Hvbp2mvLtmo3fd5UUzFSvIkcnKK7Pg3wE9bxKS9XwcZQjw?=
 =?us-ascii?Q?NC5I4uiAXjiTQC+Ae0bcb2Dzgm6u5MWzVZW6lwfYikr5mW+NfjpNZ2VhqOYK?=
 =?us-ascii?Q?LLh64NlHbcaqYEVHkj4dkfdpKd7DMXNU7gBSocPC1mJFB2e5YkvT8uqf4g6o?=
 =?us-ascii?Q?dEQmUZYpRdDKJEvfMSa24cJRpqlasPV3o0oTC0yiAtzOM7FNN7OCEKvfZwqc?=
 =?us-ascii?Q?0y75FfbiZRsUgLPWJ2CtlkjtMM3Xipr/IolFqWgK98RPlLqfpisUPrn5PQkg?=
 =?us-ascii?Q?xBxabKkZErNLiGsGnoXNFLLRn0svtVIPZTgDh1mZxV7Qyiox8qdY8B7PCFFH?=
 =?us-ascii?Q?Kkx/SfOp7ld/Zx81pWkiTqtRyfAPZpOfZhMHi7X70goPjWBDxz5U+LFPmzZ4?=
 =?us-ascii?Q?JAgCpx589FTzeagj/eFboayo42o7GfdIAbKvCLgr71A8/QamQvTrGl9nTw6P?=
 =?us-ascii?Q?hEKvJQ3RT6kPVTYNEa+dVLeUjLeOW3bAuklITTog?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20081fcb-d169-489b-9ff3-08dbcc498359
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 00:07:11.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NA7huLKPnWWIcZX3MpBBqMjF3NZvWrpObxJxBU/0h6n4lbKWqY2HIWxmLyAnUGUa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5339
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 01:58:59PM -0700, Nicolin Chen wrote:
> On Fri, Oct 13, 2023 at 12:19:23PM -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
> > > IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> > > But it can only allocate a hw_pagetable that associates to a given IOAS,
> > > i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
> > > 
> > > IOMMU drivers can now support user-managed hw_pagetables, for two-stage
> > > translation use cases, that require user data input from the user space.
> > > 
> > > Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
> > > type specified user data. Also, update the @pt_id to accept hwpt_id too
> > > besides an ioas_id. Then, pass them to the downstream alloc_fn().
> > > 
> > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
> > >  include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
> > >  2 files changed, 39 insertions(+), 3 deletions(-)
> > 
> > Can we also come with a small vt-d patch that does implement an op for
> > this? Or is it too big?
> > 
> > It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
> > self-contained series and another series for invalidate.
> 
> We now only use IOMMU_HWPT_ALLOC for nested domain allocations,
> which won't be supported until the cache_invalidate_user ops is
> preset?
> 
> /* e.g. the following piece is in iommufd_user_managed_hwpt_alloc */
> 
> +       /* Driver is buggy by missing cache_invalidate_user in domain_ops */
> +       if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> +               rc = -EINVAL;
> +               goto out_abort;
> +       }
>

Hm. That hunk could migrate to the invalidate series. 

I'm just leeary of doing the invalidation too considering how
complicated it is

Jason
