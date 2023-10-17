Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E427CCC54
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJQTcz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJQTcs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:32:48 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C459D47;
        Tue, 17 Oct 2023 12:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV6OCqHG3IdT6OYUD6a9kphL+T2BQ0rp9Wo6uPHNIZ0aNzaYZUgaI2a8hviAQ9P7Fl7P9EyVsr0OnfEgJ/40xJXpDUgFzrbjUP8uvdllgh7h+memK9Jcy3y/AJQhx0ppH/Do7sUIBA3rfJprRsNNCo0rdtTkhGdABHfbrHQRhieQtofoCv6QC7ZuToJJSNAmcIGp3+2e7UgnTzO/4mGlnoaCVqFi7mMoVF+ihxtPa67540Nylt/nVyv1yzRdXrRn18ei5XIbEOyY4ka7y4OIEiXHn2MqkcmS7VMsW9wnsVB3Hx0VZqdD47Aesr/JYP519E5hudFBUzDBHx3eMz9Tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLjtO4tNUBPKdkKIUQ0xseAPQOm+USwxVaHVT1CFQd8=;
 b=Xcl7B41WNdIvQp6hzICvu6HZmUAeGBY6QQB6y4LTScz51jPCuWHyZ+ohOACEEe2eCZ/JMBKMj/a6FWr1I6uGfm/1MLPVMXUydODJhi1d9IfdHSS0rhbSyF9c+yXbWMP589AwodMHOu0XyR3JOxTy+BcWtHvSKRl99Y8wV3BM0GD/v9K6n5qmCzzE3fo62pcLSYQvmTkmqir5Y6qDdu7EDC/VEk1ln1aMypx0O0PJV7mpF6nXeWk4u4iAb0aapiEQziVdXWh9yTkphMNamYU41KmuJ8qzVfA+QavR1xASpUe4UwhoAyc6rxKSmM68Vxh5QXrb5L23WAr5WvClGs+PIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLjtO4tNUBPKdkKIUQ0xseAPQOm+USwxVaHVT1CFQd8=;
 b=C0vykurxgWUxOV4gtWLqzNmUffDDArrppH6zuiDLpK2mRwFqya3d0CO/rjRfJolukJYmGmUwZE+P2mAAGIXDO6P/n87Cq9Lydiso37m3Qo5MmweHfjwbgn/ytbJ1t5CpiclJSzOJvO1HKjFF9DHlKaZCnpeAcaRhWOc2JMw0yhnRNZSjydE8OeBAfWVsOu2X61t21GwbsR9aDVPiJSWCNqThMmb+dOLtmPmq6j0jE/GtYdjD3OcWZ3JRlfRE3NOo80c6Ga4ELQR4yPtI1+c3tGyERUxgvwCOU2YOEYeEdaDsfKgvjXiShed48eYHgNH6hm5ajkrOYe6FKGC++0Ke+Q==
Received: from CY5PR15CA0234.namprd15.prod.outlook.com (2603:10b6:930:88::24)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 19:32:39 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::2b) by CY5PR15CA0234.outlook.office365.com
 (2603:10b6:930:88::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 19:32:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 12:32:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 12:32:33 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 12:32:32 -0700
Date:   Tue, 17 Oct 2023 12:32:31 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 10/17] iommufd: Support IOMMU_HWPT_ALLOC allocation
 with user data
Message-ID: <ZS7hT+DVNbvP1TgS@Asurada-Nvidia>
References: <20230921075138.124099-11-yi.l.liu@intel.com>
 <20231013151923.GV3952@nvidia.com>
 <ZSmvkxuEq7M13KYE@Asurada-Nvidia>
 <20231014000709.GL3952@nvidia.com>
 <ZSnmId5g2m/UnxKY@Asurada-Nvidia>
 <bd6c6a0f-3b7e-ca7c-468f-d8fe7fb382fb@intel.com>
 <20231016115907.GQ3952@nvidia.com>
 <ZS2Eisb94o3inW7V@Asurada-Nvidia>
 <36725a11-b74c-da8e-b621-1a4f8055d779@intel.com>
 <20231017155011.GG3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017155011.GG3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 319533bd-777b-4f5e-e94f-08dbcf47d362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYwYhkTBqx7MW85LaiuIcBe3pbrdA9nUpEYBjXzzD6UmWjfBV5lGhTpRwPuCsOFbb7bFh2h+mpsLIb0hd2GHmD8rha0IQ3MMWj4SRgcPawC1pfnol62TB+2wEVLiE9Dy1Lsbds5YfLo/+D8+axzfLnZRccjdkpn1Y7kLUI6IHqozVZS1oHssub1eRp/EKMIFEPwXdxZmpfStEA1gbSFrJ7Gqryz/IQauj0XJDkJG8IhZlIBgKjEtzgA/MX2aoJqhpwT0FB6aMONk1dbB2dFPFFSA1xRDh6G6/WOuSjJR41e2EObCOWj/vZ1hc0zeH/QKsY4gTKEckfIjcjFGJtcZzWAfzV0fbB/WgV6T+gYY7T4e1rldx6ddOM3qKYZ09bJms2/YRXCLu6jjk0E2I9k8D4Lpvye4yZ52npffWHuw5d2eChGj3OV5npI01t4WFKfSSvBSij73ZKQPZ9LXTsDxfU1BDZHN5Jzu4ceh71Fc2yqMt6EUHTx8hxoVgeYbFX2Z/6iwDCc3UaWch9Mu5lwLtZmw2E2l81cEA78vgcJk9vnCUs4tn7NuItAq0PsYrcWiiftIOqZKaS3HIWBKlYbUMHv/SxCZOgy2jZ1PKo+hCRU46qKigeFm8pPuG5s1o3USTyOaLV8NYdQTVnfmz49jXa4dAu/mbEAO6vit4lVvoGxPtqxdorJ0AtkXRV4170NrOrAaVi1N+jLtxJrrSgirnwX+nO2xHrQMUrmbkPKsQ0IQVcRZ8dEX0AcNQxrLqLx0wDMIE1DYH2+S3Sp33yMtxitRdqCFt0HJcKH08F9c6UiitPhRVvEH+8i18Q4cFMk5
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(46966006)(40470700004)(6636002)(316002)(54906003)(41300700001)(70206006)(55016003)(40480700001)(36860700001)(2906002)(70586007)(7416002)(33716001)(86362001)(356005)(7636003)(82740400003)(40460700003)(8936002)(4326008)(6862004)(5660300002)(8676002)(9686003)(53546011)(26005)(336012)(83380400001)(426003)(478600001)(47076005)(966005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:32:39.8065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 319533bd-777b-4f5e-e94f-08dbcf47d362
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 12:50:11PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 04:55:12PM +0800, Yi Liu wrote:
> > On 2023/10/17 02:44, Nicolin Chen wrote:
> > > On Mon, Oct 16, 2023 at 08:59:07AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Oct 16, 2023 at 03:03:04PM +0800, Yi Liu wrote:
> > > > > Current nesting series actually extends HWPT_ALLOC ioctl to accept user
> > > > > data for allocating domain with vendor specific data. Nested translation
> > > > > happens to be the usage of it. But nesting requires invalidation. If we
> > > > > want to do further split, then this new series would be just "extending
> > > > > HWPT_ALLOC to accept vendor specific data from userspace". But it will
> > > > > lack of a user if nesting is separated. Is this acceptable? @Jason
> > > > 
> > > > I'd still like to include the nesting allocation and attach parts
> > > > though, even if they are not usable without invalidation ..
> > > 
> > > This is the latest series that I reworked (in bottom-up order):
> > >   iommu: Add a pair of helper to copy struct iommu_user_data{_array}
> > >   iommufd: Add IOMMU_HWPT_INVALIDATE
> > >   iommufd: Add a nested HW pagetable object
> > >   iommufd: Share iommufd_hwpt_alloc with IOMMUFD_OBJ_HWPT_NESTED
> > >   iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable
> > >   iommufd: Rename IOMMUFD_OBJ_HW_PAGETABLE to IOMMUFD_OBJ_HWPT_PAGING
> > >   iommufd/device: Add helpers to enforce/remove device reserved regions
> > >   iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op
> > >   iommu: Pass in parent domain with user_data to domain_alloc_user op
> > 
> > following Jason's comment, it looks like we can just split the cache
> > invalidation path out. Then the above looks good after removing
> > "iommufd: Add IOMMU_HWPT_INVALIDATE" and also the cache_invalidate_user
> > callback in "iommu: Add IOMMU_DOMAIN_NESTED and cache_invalidate_user op".
> > Is it? @Jason
> 
> If it can make sense, sure. It would be nice to be finished with the
> alloc path

I can do the split today. Shall we have a domain_alloc_user op
in VT-d driver? Can we accept a core series only? I understood
it's better to have though...

> > > Only this v4 has the latest array-based invalidation design. And
> > > it should be straightforward for drivers to define entry/request
> > > structures. It might be a bit rush to review/finalize it at the
> > > stage of rc6 though.
> > 
> > yes, before v4, the cache invalidation path is simple and vendor
> > drivers have their own handling.
> 
> Have driver implementations of v4 been done to look at?

I think so:
https://lore.kernel.org/linux-iommu/20230921075431.125239-10-yi.l.liu@intel.com/

Thanks
Nicolin
