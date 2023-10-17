Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD17CC7F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjJQPuU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 11:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjJQPuS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 11:50:18 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1EFF0;
        Tue, 17 Oct 2023 08:50:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSBncjOWvknpOCzKurdQWffE4Rxmr2lGN/Jm/bWzVhJga2ftQHXnRteUdNyS2H6nT/my6kb4SxieKoCejOnUUpuytDztY7gZBzF+t3lMMk+j6kOgRxROmCWIq82608OARjmeLUub/UAT8hWM1Z4dttjvTiwZ0uASPfa0lGXnsNIs/XXDk0hcaNcqfcKF0zMW+e8GEJroY0YekWqxdZAexOS90SKZPTUwvgL66GHWt/fNRbWd03zmKJLbkvh7BagDJ/gUbjQJSUnO3M2zQ24tF9T6r7m+qxR1DtIF/pm0zts+DOojBp9K1CeqPOuYX7woUP6EY52ncsAHc5Gik2pxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0S8+QyLcDVyrOEhGtSlQi2JzTnV9WpQuHCDONHhGmB8=;
 b=Q/CrZXLnZSMm5PTupo3MwL0yB01MsGG0p+lBwVr3ifkWeJec1XoktabEqvkrrX23cRWHtSjixv6euZ0mP+VhNcWgntmxUVUWCr2y/PFUXmN9LqIyiHyHoYHnU/O15JTBdjX91+nntDc0el11lsV2GAKj3rNUWmO0R4UmT2iqZMR2t90cdRoFqY62tv9XJu/WPPOPiWPP/zdRCqMtFD8jRmqduZcGqL6m3ooUOG10Ff0o8ldnXTJxt5gI51gsDANcEOGtVAeK0FcZPjKCCvnr+WcDeCYZ5mib+Iomls6BwGyTL3h4C4Au33CXkQ9wBvdaweDFgTxWMGAStzu5uM2hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0S8+QyLcDVyrOEhGtSlQi2JzTnV9WpQuHCDONHhGmB8=;
 b=FsnJwBGSRORuAF1q+FKhdBZm74Xq96Lzus9PmRIupm2anYZQ4VKr+JUZaHub6AaofnF6DQkF78ad7JIpogLQ1KenrljAZ2qbGVRi6lUeWyc7K+TORaIkRGS3P9vH/w274XtI7MH6ngrwkPBVqfY0Pk2TDTCSyasHHEjeThiwiWLtsd4RmfbqjDdHtoAmjJ4jdI1Tau86e3x7I7HAvhBL6BgWV+z2XrzPYfbbvtxneRAAC/1A3Fyq5X4Lww+WpVLdXmAe3GlwBOf6Q2yX31KZTb6cfezIVG2GGK4/GGY0eDxY7ohS8IIkQzLjugN58ndN4tQX1YDPFJOKcxuFahjgww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9256.namprd12.prod.outlook.com (2603:10b6:510:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Tue, 17 Oct
 2023 15:50:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:50:12 +0000
Date:   Tue, 17 Oct 2023 12:50:11 -0300
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
Message-ID: <20231017155011.GG3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com>
 <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
 <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
 <20231016115907.GQ3952@nvidia.com>
 <ZS2Eisb94o3inW7V@Asurada-Nvidia>
 <36725a11-b74c-da8e-b621-1a4f8055d779@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36725a11-b74c-da8e-b621-1a4f8055d779@intel.com>
X-ClientProxiedBy: BL1P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f41aef9-ff12-4daf-2c30-08dbcf28bfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qVlESCOTypAKUS+5BqL2tq8+jexhhMfzExN4N2HYZEZRmlQFZj40v+pEXFgudtuH/1WxWQYAZoDUb5Qfydj9eNcj6nzMiO4JeVeaQBRwpTM5x0GjTcya/TXUaQhigVwkMSnQywoWT27v7uzy+CEj5h6mwdVE/rBIC4o9Gak7oEGilsX+wFVS+MXtHPjgGA2xozLY0j224dSAxwUZFsLwKrO8FpX2WB+MlxkT9hJihdl/Y6XBGMTQiHiV9RW8XxASl0fxoeXpA7IwCILN47Bnsq6DkbUlq+vAj/9V8kN+6MvP7SyxU+BJdnrANV0DhG8hGXUVN5PFHRxVNSH4pVBCdk1jggohHsRCAZuo3OLS85bxhluRusxzKwELHBsysSw++UbOTJnJ9n+YSCUm4KY3zgLJsI1v83qjap5X1E0RErEMEKCneVPPxijdEVv/IybQ3Hndj31k8HvfOsJlu+w66fEfEE9c+Y1CR/E94H82qSYfDBM6cVhEdjGR4Ajkp+VTxFtGt/jaZpXUTXj7iNoopfC7NzZ8Q/XBlRRBs877vecPzibakgfH68o85juAUsCC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(33656002)(86362001)(1076003)(2616005)(478600001)(36756003)(38100700002)(6506007)(53546011)(83380400001)(26005)(6486002)(6916009)(316002)(5660300002)(4326008)(66476007)(8676002)(66946007)(66556008)(8936002)(6512007)(7416002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTNYe6NKEzE5KfKuTBsN5kXFvRD5Qh2sCgTGC1m/TgSbSN7Es1jlZGc3b3no?=
 =?us-ascii?Q?kPl+BSr1nLEa/di3SLdvFjgX6pIWbELKGwHsqdlMgfnsD3EvIrY1Og+euKab?=
 =?us-ascii?Q?/JaZ06+lz+2sbNZkUR8CjvE33u6ODVRQtKVc75KjP6UAFkstt6yu8OSimMYh?=
 =?us-ascii?Q?Q7P9iHP/JYroLoSWny78vqK0hdLqtu0d6c7nRGNbYnpAmr6EaLbnPA6VkFmu?=
 =?us-ascii?Q?VCpHcyroIzg2Y1ny2aF6buKWjHJWwmtWLsVnUyryaqOS781hJfNbVcEaxhtm?=
 =?us-ascii?Q?Olcij0OsOVcat8FHdG8a43tojejXdeLOXfV8YUO0x++kM+ZwRLsIka8LXOlS?=
 =?us-ascii?Q?OVR8Q+sAD2Ifkcu8ScafnSUmddGsKg8yTHp5TjbBVHxflN1rJyPY0Q0g1koC?=
 =?us-ascii?Q?Is2m7OVdgLYB5orXr/MPbYrYfgG11n6o6R603Ca5QLiSWsnES7QlhHsqniTp?=
 =?us-ascii?Q?3ZC9cbVAevwwk+51pLc7mOOeL4DwV5HxWnOvkcIorU31KZVRzkyrwDEkUO1a?=
 =?us-ascii?Q?/4O8CPf+at8socQheUxjdxkbcwqsm5avLZKVEP7bpML1Hjm8/ypM3O33H09f?=
 =?us-ascii?Q?JzFLKVlPr3FGHphr60pLkL/tZj0wMizvDPeryWrkBiKRLEYhm7KGZxnm+/5Q?=
 =?us-ascii?Q?P/XIKpYHQdESDJN81rxJtZHVqpWQl7n3fPyVXXzrFJlaTaNfsUEgNu8jHq+H?=
 =?us-ascii?Q?cxdyyiWgC95aQhZBYurtVwPaT03LmxFNDt8FDRqmUMNc/HRaHPaqUjmbmudc?=
 =?us-ascii?Q?tkicePDaz6I/3TeAPL+ThaoXzXMfEEgi4wRGUtWRfgnXKJOpHqOK0IbtgX7R?=
 =?us-ascii?Q?bC+d5OjzXOKf6FTtaW5zJ7JYWIpmHio7XvuaK/Cr478yXLTmUIz7O1Q1xDPD?=
 =?us-ascii?Q?rwNVBTLuGv0gTAHAojQES6leZJ5Yp9mxG3c8FIicWUIMxA7pUttxGlcCavke?=
 =?us-ascii?Q?XNLCfvbKdrvfuV/tHvoUHrtz1mn3HABSfffTANDR3Rkimz+YHuVOAb1gLk57?=
 =?us-ascii?Q?CR8Jo58z8gOqPFHa73AgIiAXEJEgPBTxrqW2PAZMvYdbrVHZcWAif+Qz5ABn?=
 =?us-ascii?Q?fwQ3mOHWsMNO0XMPECWX/qP1EieyOD1mbctkkwBVwyug4yWw32ZQDymmho2+?=
 =?us-ascii?Q?DCAYCkfxfifZZYYAW8PscBEK6nx3pugW+GC2wpdmdCg+IYUHBRgtSCsREme6?=
 =?us-ascii?Q?qo3b30NUJ6AuASGtxZ9OD6kW6jLgVFhtKz2X8x+Nyzy0rW628WYtwC7gv6p6?=
 =?us-ascii?Q?f03EZef51D+GOX47Ry8UXXtl9ni+uUhCqDc8PzTwdSTRvM0dj5etqkDpiD/1?=
 =?us-ascii?Q?XxACHM14Hs8WyZMUfsRvXx3EptRckzm/7cxYBtl/ZiJmzmekrz3AGr5Bmgo6?=
 =?us-ascii?Q?N4JqZLQlYGspxUmrr3GTIceSnESCMMaaePycVHtFQm3KxFOky0oASkdXyed1?=
 =?us-ascii?Q?SLFMyBdtR4RszgHWtFf76C6rbPhh6r4FLY7cwDK68wqPyXiSiPlCeiNb7Ij7?=
 =?us-ascii?Q?tD7QjSCG9F6HFxp8otByNfnsN9+PVielEfL03Ey1yfCmwx7daJL5O/a0fqyG?=
 =?us-ascii?Q?FQ+je8eUlf8fuzs9t0PmyvVy6DNUNjQi9PswjJiJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f41aef9-ff12-4daf-2c30-08dbcf28bfb0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:50:12.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQoSZe/wHYCkUshNoaY00VnTT0c+rBrvWXbdJevrq4Q4EqTG/jnfqjPr2El5iDkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9256
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 04:55:12PM +0800, Yi Liu wrote:
> On 2023/10/17 02:44, Nicolin Chen wrote:
> > On Mon, Oct 16, 2023 at 08:59:07AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Oct 16, 2023 at 03:03:04PM +0800, Yi Liu wrote:
> > > > Current nesting series actually extends HWPT_ALLOC ioctl to accept user
> > > > data for allocating domain with vendor specific data. Nested translation
> > > > happens to be the usage of it. But nesting requires invalidation. If we
> > > > want to do further split, then this new series would be just "extending
> > > > HWPT_ALLOC to accept vendor specific data from userspace". But it will
> > > > lack of a user if nesting is separated. Is this acceptable? @Jason
> > > 
> > > I'd still like to include the nesting allocation and attach parts
> > > though, even if they are not usable without invalidation ..
> > 
> > This is the latest series that I reworked (in bottom-up order):
> >   iommu: Add a pair of helper to copy struct iommu_user_data{_array}
> >   iommufd: Add IOMMU_HWPT_INVALIDATE
> >   iommufd: Add a nested HW pagetable object
> >   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
> >   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
> >   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
> >   iommufd/device: Add helpers to enforce/remove device reserved regions
> >   iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
> >   iommu: Pass in parent domain with user_data to domain_alloc_user op
> 
> following Jason's comment, it looks like we can just split the cache
> invalidation path out. Then the above looks good after removing
> "iommufd: Add IOMMU_HWPT_INVALIDATE" and also the cache_invalidate_user
> callback in "iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op".
> Is it? @Jason

If it can make sense, sure. It would be nice to be finished with the
alloc path

> > Only this v4 has the latest array-based invalidation design. And
> > it should be straightforward for drivers to define entry/request
> > structures. It might be a bit rush to review/finalize it at the
> > stage of rc6 though.
> 
> yes, before v4, the cache invalidation path is simple and vendor
> drivers have their own handling.

Have driver implementations of v4 been done to look at?

Jason 
