Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BD7096C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjESLti (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjESLth (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 07:49:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519711F;
        Fri, 19 May 2023 04:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgu6uW5sorwMvCMlnrjJudEUup3oDOWBkJzTvW4eLtk91SYJXZcJUvCYytfRf/f5xw8chW9RZ5Du+w9YulJtsS0BzVgcUkEzIr1VyQRNE6igrcUHJK+XkWApuo0MtA/lkxr6a/VLcKJC5UKtVbuFXrWA+NQGpwfn7erpZhnBP4d+t8cAD2C5f8S0CMjfqvpVrlb7WlsKjnBGc6IUnubds+F52C2EVvfBYskVkOife0NftDg88qHPzakXAQ0dNpB9Pzku65/SSramUHbPH3d2Hz16h9kJCy2z37u+6x/yr9P53hZTaUOW1kh6ZQPBGKPVSdN1KeXsGM1CmMZnTWGNrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYCEccyjVVHHEL8YiKRgZixiCuNwRpwe1/9oN7WVvgw=;
 b=hvheQoO7HeLvrUkuDfU5ZoeGQj6+9ki8IwGCbgG3wXrF2qkXX7zKtuWLMvq/tnzTaHCV8+QQG7yfokMC9aJIOmNKCrwiBtjm3BHY7cRbCCDsPFOGXeTQb8K4HOwzdjYv7E/l6vBsF45YkOlMKBHwxmhmVC8QvH7ZawBlejWw3JgLujDuRD6TSYId5P0Ny8DJB7ELdCfSQIXlMPn+Vbk7rj+oiayNBAcTVYR85hD1CE28NCCHxpWSxlhucH0K46jJMTmcVqN3XhwdqcqjYfI8TI7RKAPl6pVctYDHQTudZRcVVyG35Ulhkc2UcAeid9N/Of+Bde9iqxe2pZnIMF49Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYCEccyjVVHHEL8YiKRgZixiCuNwRpwe1/9oN7WVvgw=;
 b=Ts9ibQr5QlhzHieH0elPdCMiAnM5aZGVT7G9F8SeidYcZes8YIeODLu9I3G7ISevx+QH+q9LHd3lkABEC+FESoSrx8WLQ++HXKAsDn0vjp+YPkVH/SLX09g3oUDcjVnaYWaCP3QX/p/Vy/hVPmOKpD95F3rXGjqqKXzS75IfFyhZd/fLwErhBYUzREZnOFkDwkSZs5yV70PD15Y1TVtPND/ABMtU+3BmbHK7F95wRBcGcVxEsRGAUIIq9JVIruteS79jWI7AS8bxRqk4Z/mRYXjMLmpnFtU8Nvji+vbfIH04d3135WyLP1Kj41g9N+LpltGBdO7lgkIXnaVQ1VpMKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6465.namprd12.prod.outlook.com (2603:10b6:510:1f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Fri, 19 May
 2023 11:49:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 11:49:32 +0000
Date:   Fri, 19 May 2023 08:49:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZGdiS2m8jcd5OOt5@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9427c1a7-23ad-4d83-0535-08db585f1c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNyN1ad6DIOO+5OO0pmtWQ0apLCGI6g6ghfUAt6HU7FcGwUmExKf182XfDjXPpMa0+BepzAoZB+cbkK60Uek5kxtkgbJe6Ck5KQdCJ52ToWeaM9LV8oMlqsgq3MX2OS9cualuzUJiiKno+iaIa+0XV6TtvvQz7POY0lhQWhDKe+ojSA5d6gL7vVpmDmjntpDMZK8WpPLsoc79Er8AKIatDlwVMWQ6b9KJuvFXoElMoTGIuEAhD64sihgaCr+aZ2CA9rGzzzD1hEKxy5uQE5PNSxxrEVfASrTbpRw37tFPhAGpP0t3TK2aUmVLO5e8dPW13LfRj9c6Xs8oeF2MeyDnj4Kfe5k4RVVBPItSCeK5ltbDVwugPe3WwNPjYoVSgHur+z2UVoFVDS9i6EO2DX74p8aS0LUxeW4MvmS/cweVcUn4cG58Fi3v7GhcF5zAh7d3E8rKrXgNX34iLzA/7DW5vD3Lt3VIwuiQbygjJku8ZEAS9ZLtV2QZbXgiQH4NKZGZs7eZljqkPaoN/N7EcaN9SiHF2IABFVXSYLx9rhGJndUg7PwE39kSbLdLXFF1FkW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(4326008)(478600001)(316002)(7416002)(2906002)(8936002)(6916009)(41300700001)(66476007)(66556008)(66946007)(8676002)(54906003)(5660300002)(6486002)(6506007)(6512007)(26005)(186003)(83380400001)(36756003)(2616005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBzpjkqnMigWDhrTUVzgahCJsegj5A22WKLhKQegI+P3T+DSLmDzHfLETjl+?=
 =?us-ascii?Q?mVM7if36P2rjT+SpGryBEGc9PP5PIIuEqWpl8JuavfnwDXXSuDf08ZU/iIgX?=
 =?us-ascii?Q?PH8seeH0pxEJVt23CavE3ZX8GSdag2PoDEqkEBnrssGJjOwiCxq/X3KpVkFv?=
 =?us-ascii?Q?zbzlNevbD5bFMCrae+xRohotsTopS2mcnD6YqpJjkg3UL+teDiq5p9bDcWQy?=
 =?us-ascii?Q?I76+ZgBvL+E21nufE+wj/i48rTS+VbYeteUwcWxd/YdCkn24UVVHtoVqAyQ4?=
 =?us-ascii?Q?RjolyThU/RUdd1Osfi77MPurPHAkn/AOptXZot2lStBN4KqYmqZ0XrwR90Hb?=
 =?us-ascii?Q?esyudKByPVoHBT1YZVGhZR+r/snGkDYFNjsJDBlEyUdFwQU1Knf2rDraM592?=
 =?us-ascii?Q?4PBJCNLxdrFVGYzl10yxXidl7QhW82nhOCV4/jMXgwD2daQ5EvLdRj134Kp5?=
 =?us-ascii?Q?3I5b2e5qRV3ITThn8ItGsBfEKm6fvIemI2xN4bkA0IHrA+yNCd1Y+22TtBhu?=
 =?us-ascii?Q?DiwhCCbt1wY2lUjvc6Dn1hSDzZd5nUNjchbBHQrGWh4j9k/IoNUlatB1G4P3?=
 =?us-ascii?Q?tJziBcy9SbSBkRaRKNXWQjecTTX8WSW7hU1bVFwoYVMLJJuKJ36X5BaSkv4p?=
 =?us-ascii?Q?nQAvRz5kZ5+jOkUDeDc0Sfu3a4h+6ZdL0DQcs1RiHvbeHlNgojoCOpJ+9Cvv?=
 =?us-ascii?Q?6StjWiMj3qln7OqYy8ppm9crAhu78DlLH4bshEC4sFLHkhukNrbZhEZBcF5b?=
 =?us-ascii?Q?WOMZ9j+G75hsUFvR2OHY9ilba6kdJo5NF2F9xv+HknUjNWsL4MX21Zp1s5FN?=
 =?us-ascii?Q?bu1ZhgsH6cDdNG/z+G+OfY7lIE0XKzbim2JiVcBKM3+izzhhikntKYapKX/w?=
 =?us-ascii?Q?0FAsXfAvU7ZdmSS+ldYohs7nvpKshwI8r8X5lwW+KfaXGXAjYD5FQbIIqj0D?=
 =?us-ascii?Q?TrB+bcICPred8OSPuA7vp29ar8D/uzlF7TOyn88byqkRbLxD7fa3TEybpK/X?=
 =?us-ascii?Q?gBO8FcBi+BuxGErAKSszYSAFAKbkfhMTXvKlmFktLlPTEqEs66ZuugKZjw6i?=
 =?us-ascii?Q?ybI1nIwjpODH95+SnJdiVvvgaUFutLNvgowoME/mni7d6DAXOo74tbR21Lrk?=
 =?us-ascii?Q?jRhr0+bQmHhMb8kvw/qQyr5AGpIwsuDHhrVRBpDUfN9CHgPKKIBIqvet+8BZ?=
 =?us-ascii?Q?9ac3H3xvQmSecl2r8ArSaRyBawlZEpuOG7OyhqH+qAEsVXgT4rZLWvU1bqgM?=
 =?us-ascii?Q?fGPZQI5va1sNZCNTUSsdwCJECRaM9SQEipSm2QUo4vI5HPtBnhecbgtkeRGc?=
 =?us-ascii?Q?BC9WsPc9ZNCx8EQaIX+cvxqDJzkLWuhOskg7CdoGI3dkftl4z0SvxzYDsUqV?=
 =?us-ascii?Q?+kKdAUUCB82mZrzYGJ0Nu9aHd0/bypSaavcl0Z4ADHbIo52UblWkLB0L/xf2?=
 =?us-ascii?Q?a/+D29emTxYTpgGBRYDw1K24w1/78kgeTb16ZGq2p7WkzabVMxAwMznLB98F?=
 =?us-ascii?Q?f6vQzr5KrX4sx3HHKtkga2F1/Ac4hRd5amXsQ5NQPZN6A72a/zCQd4cbfN04?=
 =?us-ascii?Q?pOg1uS4hU1il0NLxLhsHe5uabspydudV0vEZx+g2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9427c1a7-23ad-4d83-0535-08db585f1c5f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 11:49:32.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8nGwLuFVBGV/F9LYAbEfUN7BuhnBedEUSfdpiS3HGHaDTR3m7N1mf3GEOPzMOW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 09:56:04AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:39 PM
> > 
> > Lu Baolu (2):
> >   iommu: Add new iommu op to create domains owned by userspace
> >   iommu: Add nested domain support
> > 
> > Nicolin Chen (5):
> >   iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
> >   iommufd/selftest: Add domain_alloc_user() support in iommu mock
> >   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user data
> >   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
> >   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> > 
> > Yi Liu (4):
> >   iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
> >   iommufd: Pass parent hwpt and user_data to
> >     iommufd_hw_pagetable_alloc()
> >   iommufd: IOMMU_HWPT_ALLOC allocation with user data
> >   iommufd: Add IOMMU_HWPT_INVALIDATE
> > 
> 
> I didn't see any change in iommufd_hw_pagetable_attach() to handle
> stage-1 hwpt differently.
> 
> In concept whatever reserved regions existing on a device should be
> directly reflected on the hwpt which the device is attached to.
> 
> So with nesting presumably the reserved regions of the device have
> been reported to the userspace and it's user's responsibility to avoid
> allocating IOVA from those reserved regions in stage-1 hwpt.

Presumably
 
> It's not necessarily to add reserved regions to the IOAS of the parent
> hwpt since the device doesn't access that address space after it's
> attached to stage-1. The parent is used only for address translation
> in the iommu side.

But if we don't put them in the IOAS of the parent there is no way for
userspace to learn what they are to forward to the VM ?

Since we expect the parent IOAS to be usable in an identity mode I
think they should be added, at least I can't see a reason not to add
them.

Which is definately complicating some parts of this..

Jason
