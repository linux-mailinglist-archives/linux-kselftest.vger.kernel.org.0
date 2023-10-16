Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E47CA751
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjJPL7O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 07:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPL7N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 07:59:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273118E;
        Mon, 16 Oct 2023 04:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TL4LUJVeO+/G3rnBp5Q7BKQ4PZGRwPylu+5UutrtDHu0PpOY8XPQw9wsVze+OViwgXZ5ooLMbBovwCSaT7/g4ZEGCNZSBkeINCCuRqpg9LvMtq4rIInz161sKp/vcE/51VuUj+dAnzbFMCBputXpWxHc50FJpveVqigMKh4oEcU3H3mr+ubq9TbGPwsCwNKvw+5ootmQ6a4e6wcd+FKz/FAgC7j1SU6KF6b09kZ/AL5FRpxBnpImPZf6knSGB01LeCvyiX7LBkXCS6ISsrAR5qBnH8kZOqqGAzIBkcGitGLjMW3/XioPZ5GnaQE+32YWvFk6m4aS8sHSgC7O2cFxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ldG+2rXVBBsQb4g81PA1TzRK5uDF1kIUWuQ7sUKVcs=;
 b=lULe/ArYmnSo1mZ8kxJZQBYTKRlXXJKJUtGQlBaDTOZR3iW9w1n6FhEeFaiHXcW2+beoQ9kqLHKHDC01i6am4YEzjvgYDHuxiOCpTdUnMHe0vJWp4owiPONchWKrOh+bLa32J5AXmU37ofB5QpPp5TSHf8lRPbQx+92Sw/lBN+vMX8e7H81cLv+L0h15EkrRnaznh9ZxEtKZUM/ocqvndgLxK66foZXY1CSV8TK0aRCVzLztA4Cf+sVf0XVZDIz1g4pfiyYL6Iuxjjw/jYw/as//stHXiAl029sgBhBQLp9RonIazyKOmjo6Lx3wg2HIe14tiUv+Efjc9L1DCR0r8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ldG+2rXVBBsQb4g81PA1TzRK5uDF1kIUWuQ7sUKVcs=;
 b=P9Wdzot3VvOjMc+yAVE4exoU3eLQ7s/EDMIafxLXN8b4As1EX/3p5q7btX2jHknCgTnqrC1VreOVRVRgFL1Nldt32OIKv9paKaKD5ipFYP3JGttdHjziGhaf0LOyuzie7Iie+eH7YZC+VkIk/I9OZy3L9UQ+vP9DRbh8AWzMO0NQszXqN1TS27iDZ3XsdveX0KicEgDh0tpgbWz3Dowpzm/6sAqSWwU+GrKH3CV6bLEsP3B7JS37WTcykdzYu4HuF5NNiQk5wdyGa36P0CO/ZfuDOrFRsei2g1kicKJKLaed6T6amwmWvAlblhIcWestBfcuLSuGvWIIUrmmZeCCSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:59:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 11:59:09 +0000
Date:   Mon, 16 Oct 2023 08:59:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
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
Message-ID: <20231016115907.GQ3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com>
 <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
 <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 374c7e56-4cb5-4a52-de3f-08dbce3f4e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sky8ZAyuJq2tNuqgePOSd+UrPxHskqtUpWlrwsL6lB2EGKrko55eNVnTfv1Ncks36zOoeZn0r0v8h7sMSMaiU4F2i1oFBc0d825h52UzptkB3wUlR/Pa+vIl728uE30ySon5ZPr9OoNXxXNJrmz+1y4VoafDA30ZmKc3LXLDOEVEyeUr6OcOnL5li7iIMM1nTzHSnItE80mGkqCB0zzUPOsDG8mM4ZVnwRdrq2BPP2Q6fuXgrYsNFYmz54pUnCxcPeZqpB5DCQrmhGHdtnk+NsVuFvyMrMaZAPeh0sFyBB1scnxXzqkx6y5EmG6z6TT9aolO6iAbUT3ESxqyjFhyCdiYtt5eiyeg9/85a6nNIOWLFl88Ga/LDyIuqyhIeS0BxTFhV+dfSNUGKachWBscBOV1tzR0M9YWw1Pk9HtrzyYWmbgWAxx2S47823I3S3cyG3f6lsWoHdxmqsjskTKAhPkP676ARBHkdjTWY8gWlXCFPL6HwYvG5hivoDHnL6jLNnZ6CfS6H8h0Wg0+NhWYatq01fvPQtzmGoeSGrlZZwmKJMPdVu1wIM6CE6hpRg2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(6486002)(66946007)(66476007)(6916009)(66556008)(83380400001)(86362001)(38100700002)(6512007)(316002)(2616005)(26005)(1076003)(53546011)(6506007)(41300700001)(33656002)(5660300002)(36756003)(4326008)(8936002)(8676002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIC7jmPH52ufRHp50VQ5ig/uq5o7u6y1JRcC6M7ulAB3ThILk4fzNdvJMVX9?=
 =?us-ascii?Q?pAwIKNGLWeicA0dmAPKeUtr9qYmU3eQ7+rjf4ze7FyAMSvqCQaN9kkc/SPOc?=
 =?us-ascii?Q?5bm5XVJfJTMiqI21KSvigSOJNXMpW74NjnNzakr12eAaKVTyOUDIf03w3f/o?=
 =?us-ascii?Q?dC4FYxyY9lU65wJs6Vju97j3+QsTQbXRvWq7xAj/LLNZeO+yVrIjRVx+FgJZ?=
 =?us-ascii?Q?JZF9wSM8lV8AkIZBAYmsHRmKbvU7wZ+S9la/8D1fizEa3hSS2TLsTBIWYeaq?=
 =?us-ascii?Q?sCGlOeBuLesK3WjoTtuXV7pKlLCOXmS19exPHaIiEM/WITWbRbYFpWJcyXR1?=
 =?us-ascii?Q?nonIXKZtq57Tx7ZSAe8PUvah+OoVW5giQx6QMXz7JhJIaptnZm/KS1v9Pp83?=
 =?us-ascii?Q?kdFHGashRe0e3VayFk1wCnyR3+G7wWm4zo4dOYadHJSltSpJWjiOCu70/Ffl?=
 =?us-ascii?Q?DoQCuqZAFUW19I06kBFUGLoKO74IbPC/POeZfZknDq/KzaTS4aN1qOrJ7Mtv?=
 =?us-ascii?Q?ECkbFMCJpMp0fy0q8H3NMiXjjQll71DQfmQNrcOe6kUPMvznCrLStRqB7I76?=
 =?us-ascii?Q?kwiPJLn9UMSlS4rtsB9D2shcMTLp6FKIXHiFxQmesJQlYfcqLd+uG/VQkKB4?=
 =?us-ascii?Q?WCJvgGuxbhr4IMyyKRJnrIc+6BxYji+feGmQcRXOGh4EyUUZSTfhreDKycS2?=
 =?us-ascii?Q?NtfQikY0LbbOdzhsKT0H0XaSuKCQ1NFyz3FXuoxxe760y2AdEPDXiMxe2Eeu?=
 =?us-ascii?Q?HoTBWdC+1eMAWuS8FE2ZoHkuNrEZbLYE3cmQkta7PovQUUR1/RKWnb3lsN1i?=
 =?us-ascii?Q?H+FmjAeBcGcPOfyc+0sssCqEnHxzVzU0RrOdI87i7skFxx/orpLzZojhK8qG?=
 =?us-ascii?Q?cyQ22z3tNToEmLlxvDHfXZbQxj+ldKDjERKb+c1ikqbhDIBq6lyvFl+PZcc3?=
 =?us-ascii?Q?eX674wtVGYU+XG2svZkVadGP9/k9WyyMFrbmpFpVobWI2JckoJgxoL21ouPi?=
 =?us-ascii?Q?TvbBKDLg4KVViB+DaYrF+qTwy3s1lhC3Wd7U590k53DtKFIGcpjJCDBmDx7t?=
 =?us-ascii?Q?+L6jMd6CbJLh+0YMahZiKUCiAVc+HuXj8cD7LV8RPXqQwOVQns9eXV0oXg4R?=
 =?us-ascii?Q?FxAEwrt7vucUtELrmFLPPzywLMox0UPPavpDil0BKOvXuYQO9b0sRWgEwbbC?=
 =?us-ascii?Q?JhLWTMWWJtAHb+ZFNGUbX3XBLg4zpcPZI4qWNL6v7g76ijxRlJcxbtwhOFOO?=
 =?us-ascii?Q?oOyl/vRwfeEzD8hN94yTUqXCC0QvhZWsF7ObhmyconkGBxTaL+2SN0SiS3pR?=
 =?us-ascii?Q?acy7uyR5iqX363k/HSbEkcN2iq6X8MkzGrrNnV1Hz3beCCsZc+Daerypwse3?=
 =?us-ascii?Q?XNGJWOxu+vgogvX5zAjl5d1dRrMuKEOMEr0yHz5pljebKa/HX/onqizRW3qZ?=
 =?us-ascii?Q?jOiD45bUHs8ruVLpUdvBNQ01iJesrNG31Of9mzA6u98jnMqENqNGpri8tAZ6?=
 =?us-ascii?Q?Srp7+UyoTqXuDoa3ij4rWs9j4QJE/3JiD6+pbjGeUItflEGTyP4xSDgOHNLu?=
 =?us-ascii?Q?hT4JscgIRol6TF7av9U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 374c7e56-4cb5-4a52-de3f-08dbce3f4e16
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:59:09.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V8GihCgLsx5Cf/L8wXLL8yaVmMPk4hTKxL3KpRMW/w4N1+l2AOZSKWk811yUv1Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 03:03:04PM +0800, Yi Liu wrote:
> On 2023/10/14 08:51, Nicolin Chen wrote:
> > On Fri, Oct 13, 2023 at 09:07:09PM -0300, Jason Gunthorpe wrote:
> > > On Fri, Oct 13, 2023 at 01:58:59PM -0700, Nicolin Chen wrote:
> > > > On Fri, Oct 13, 2023 at 12:19:23PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 21, 2023 at 12:51:31AM -0700, Yi Liu wrote:
> > > > > > IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> > > > > > But it can only allocate a hw_pagetable that associates to a given IOAS,
> > > > > > i.e. only a kernel-managed hw_pagetable of IOMMU_HWPT_TYPE_DEFAULT type.
> > > > > > 
> > > > > > IOMMU drivers can now support user-managed hw_pagetables, for two-stage
> > > > > > translation use cases, that require user data input from the user space.
> > > > > > 
> > > > > > Extend the IOMMU_HWPT_ALLOC ioctl to accept non-default hwpt_type with a
> > > > > > type specified user data. Also, update the @pt_id to accept hwpt_id too
> > > > > > besides an ioas_id. Then, pass them to the downstream alloc_fn().
> > > > > > 
> > > > > > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > > > ---
> > > > > >   drivers/iommu/iommufd/hw_pagetable.c | 19 ++++++++++++++++++-
> > > > > >   include/uapi/linux/iommufd.h         | 23 +++++++++++++++++++++--
> > > > > >   2 files changed, 39 insertions(+), 3 deletions(-)
> > > > > 
> > > > > Can we also come with a small vt-d patch that does implement an op for
> > > > > this? Or is it too big?
> > > > > 
> > > > > It would be nice if we could wrap IOMMU_HWPT_ALLOC into one
> > > > > self-contained series and another series for invalidate.
> > > > 
> > > > We now only use IOMMU_HWPT_ALLOC for nested domain allocations,
> > > > which won't be supported until the cache_invalidate_user ops is
> > > > preset?
> > > > 
> > > > /* e.g. the following piece is in iommufd_user_managed_hwpt_alloc */
> > > > 
> > > > +       /* Driver is buggy by missing cache_invalidate_user in domain_ops */
> > > > +       if (WARN_ON_ONCE(!hwpt->domain->ops->cache_invalidate_user)) {
> > > > +               rc = -EINVAL;
> > > > +               goto out_abort;
> > > > +       }
> > > > 
> > > 
> > > Hm. That hunk could migrate to the invalidate series.
> > > 
> > > I'm just leeary of doing the invalidation too considering how
> > > complicated it is
> > 
> > OK. Let's see how Yi/Kevin/Baolu reply about the feasibility
> > with the VT-d driver. Then Yi and I can accordingly separate
> > the allocation part into a smaller series.
> 
> Current nesting series actually extends HWPT_ALLOC ioctl to accept user
> data for allocating domain with vendor specific data. Nested translation
> happens to be the usage of it. But nesting requires invalidation. If we
> want to do further split, then this new series would be just "extending
> HWPT_ALLOC to accept vendor specific data from userspace". But it will
> lack of a user if nesting is separated. Is this acceptable? @Jason

I'd still like to include the nesting allocation and attach parts
though, even if they are not usable without invalidation ..

> BTW. Do we still have unsolved issue on the invalidation path?

I'm not sure, there were so many different versions of it we need to
go back over it and check the dirver implementations again

Jason
