Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832972458F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbjFFOSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjFFOSG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 10:18:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49F1A0;
        Tue,  6 Jun 2023 07:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVjUN83HnXNGAghq4KJk+yfWNuiPG1QleSRYEBGZSskElmu8+ExXEUSzj/c8X48a4lO3CrOrTL5yL4v3KMADGv7Z/PbIUUTn6WKtoBgQMxRMyAPENeHo8rGey+0wbflYTCWhT/by1ndH89Ya2Zsw4I/RULMLgz7qmwzZj5HM4JKqR2AfyreuxTgOKp6HiPKvOYIZT/mZL3Q+brR7HzEwTAOgnZ4zm3yXy8kRI1Cw+f/0SA90hrlWjHBJGeu/XXysdCJRZMBKzMLQlOOOLL/My+QDUJzci3UUaBsGeQZHR/kxvSKdGfOKiQQ2JFYfgdecNzwa6Gai1xEix6OmWo46/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UWZ0/ZVvLpR8zqzc8rIyZ4rL4rkLyQl+4a5BBsc0NY=;
 b=Gn9nZJvgOcMv5YD5nQGBwh6Rb1v8bLyWCFjim12lUHWwxXMBgF81bpbXMVqV6D77QHwU7sXssBOH1AuTLDBZqKs8GcJfsp40jld3q1ClnyhPFkKnKbXw+vkLnIxaYT22LaTtcTwJcw7D/WNe73NtzuGs112aWQsyc3N7njskgoZi1A/PRdiGaNZQcZhWsGwqjPf3sMvju81lyZtpksIhuAYOrG8v8Ucoxg+ofoptB/oELcKl+O/kPoFX7KbRtrw6Joc7H+kXZCSc/Bsu8E6aWRhJGSBaVLuKKcXszwcF5XgbK15aFy0h9kE0CZimT+CHMeOZFyq6/RgDHeTise1bvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UWZ0/ZVvLpR8zqzc8rIyZ4rL4rkLyQl+4a5BBsc0NY=;
 b=K1QDycmVa+NHIar6jEKUIGUMEy4cEp30TPYtUcOLm06bEr0mzGhedfkVHfectK28kZWdQLItRf0y/5NGHseQuIKHICGkyZcLJXO1TzwsVcLbC/5cvWHWVtHgCEKcerABm5q6qT5UXaDMeU2Pt8HTPcnWz8ILpn2NdWCY3uFNhhDRNRYuYQhnkQXcZ4368cvwEkj6a+XabzC/qBg52LEigVzSvINjuZZBTx+rtpPu/AuxrXsKMsyewMq3ePjCRYJ88vMLoBXy75Uwb/9pw3TwBtmZfhdD1UpLxMhYINo88z5E6RUbjs7pHFQYET4pnDeRU4q5tOVXALjGCMaKeSp9Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 14:18:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 14:18:02 +0000
Date:   Tue, 6 Jun 2023 11:18:01 -0300
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
Message-ID: <ZH9AGWf1yRDu/86q@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH0PR03CA0350.namprd03.prod.outlook.com
 (2603:10b6:610:11a::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 745bd347-d31e-442d-c45b-08db6698d69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSxd8W/x+tsMxeUFHRSKM1Mxe74WcDqrRsBGm2oQZmxonp8OqYhUbhggLeTYDN/scxnG+Dapz3lV+RMTLJQBzOgnGUQJGV+WKp7gUbMM4W0cXlOOueuJ7LL/1peiZ78TZsi0rJOICMcQNBlPtzd084STucB5vGfY3z/3+L+HmsLedahUDOURckSlrH4Xu2WlHXc/ATmvvOEzV9QIDOhynczOTgGNVxpjXpIvh0zk9P/9j4s/0eKs8nUzAVtrZhhtM6gWUjzfV3t9md73NAHEmUsyx4/sQYqxvN1cKFrRSKc9mshxKZSlmXn60/b7Aoh/9KIKTvV+UWY1XtiLcJhluLmHrbv1mrlkaLOzL3rNm9kDLXBAjgO/MNqsodPsz8NajTquGBWO3LYHuJshSv15/Q6uOyNaWHzjwVAkHg6c6nRjqUUHmhGWPDaZpnXeMQ3gdffi3TJtMUrw3xuscSok+DujTz0mJUK7CTBYyvD0wBVmQ3OmgnRFJY7UL/mdRpVmryZFoUEAMxPAFOQ6BmNEys/PvuaMB7ctDGSSlWCkfjCtfg5w2z/KZqlUBwsrqoj3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(6486002)(26005)(6506007)(83380400001)(6512007)(186003)(2616005)(36756003)(86362001)(38100700002)(54906003)(7416002)(5660300002)(316002)(41300700001)(8936002)(8676002)(66556008)(4326008)(6916009)(66476007)(478600001)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+slWf+MhBLuEQWZP2enae4XI6kFSCmqwukYVhl+cQeZ+OyF8LLcyhopmqvR?=
 =?us-ascii?Q?blYO0LeUC8Sr/ez/rgd1yH4EhilVOtAUqQvZKthWf00PUaeSVysYD0mejio2?=
 =?us-ascii?Q?ktsWOoVyul7FwK3AZHb4leAfBMoP0z5mtJQqHY0Cou1zwCzMlTfkuAZFlejw?=
 =?us-ascii?Q?vjXGf9ipsrFJqSPFxZ1Tki315NRftdkdozYf3JcD1QeDJf0U7DGZzFdoyYwy?=
 =?us-ascii?Q?YvX97HXFyNGHjXzUo6VIe7LE5bCenNVDGaSfqu5KlWQnfulHhacaQGAloo9t?=
 =?us-ascii?Q?sWZAwD7o28w1iP3DygtlM4J03FZZnbh++75aG1+xJnFHDVu9nErB0wWrovwo?=
 =?us-ascii?Q?u5t0S/dn79SVaeNnZLxOH7XWAhKsa7L+zePY7Mnl0IY2j3v2dlXWiNgulyQ2?=
 =?us-ascii?Q?tEiw89i9uqTKeUS1z+MPTLaBMs+YWXL4TvhKtjf5wPpMXNuLIlYzDhzIVYqN?=
 =?us-ascii?Q?WmC6IIIuq8Jy9QrgLqs8hJASkR/qU9uSVS1GEMLCvP5B2vAXEPXaOmL5U+mA?=
 =?us-ascii?Q?uCv1xjsdGIirN3HmIZBKnaBly3PkzqPnM0X4jkcgru4H1b+59SyiIGYvBEJL?=
 =?us-ascii?Q?0fp/Ap/hGLzAWddU0GoMipX5nw221HwbaRxazk+wAgb57gJX9W/QnKJfqDjW?=
 =?us-ascii?Q?wbfXQBZIBeD3yOGUwep1frxREwqLDKz4IVdpEqhn4ZSHPxeVklXprPg0EfXN?=
 =?us-ascii?Q?xgo9lvTYJWTby+9I+rTBSzJTcbtbLJjGnUPUQc0fFSoU8ObmohPkk1yEhMf1?=
 =?us-ascii?Q?o51TE2hnWvM21GGP0b1TFwKFN/ImdRuAiYAY4v0LO4eg0qKKP9xks6LBERG8?=
 =?us-ascii?Q?zuGrMl4iMJvEOvJpCsdeYP860XFpa7pVkSFp6VcMey4+DGjjNSYsp2wt1g21?=
 =?us-ascii?Q?8WZMNUSgnjM4nDEy6smqT706Sekr/iC9tbaCZrPdbDsESxZ/HDxmRX+qGvGN?=
 =?us-ascii?Q?wcF6qb3dms2cQJhKxCUYe5Wba81PWRNlyXiTlJP7xXeq7Hwh+m7KC162ilFU?=
 =?us-ascii?Q?rUROWyDZ2covFvw8RTX5IXiJDrYGFsHUwxhj6yO84+t20pXlSJ3aIbtFruu1?=
 =?us-ascii?Q?78xfHLtPgQwoRdmKZmKTDUtUUX/z5NlPeDiC/tQaj94OV6uFVssQd9DPCm76?=
 =?us-ascii?Q?vesywcwOIQNYhO5Go1LSYUCJtrDmXtX3CiluXCI0HH3OnfFyEbxD6Ud0R/b6?=
 =?us-ascii?Q?fk2APQF6U9UKQThSR+FDFlsQlU8DnATmgSBRFop011GQMoQ4exRL7fkhngl/?=
 =?us-ascii?Q?ulELCuwoWXZ30Ik4qM4PaOWtX6nUrtKrHeDUsVWvI3Bt3rSUCnlKV30G8XqT?=
 =?us-ascii?Q?vRgXZPJ0oc138QgH/HptU/p8ZTBpwdSEagG9ZuvAP5oy8/Wx5Mlw2//ZcUhY?=
 =?us-ascii?Q?GOq7hygy/Ju912XphP9VNUcnkMKMFg12/8nUcOWDQYt7jcNO2KFrMyxbnC3h?=
 =?us-ascii?Q?c5rK9gG7kiTPAYob70vrWb1Nt1OugKA9CyuQbdX/vd7Md3IrgpQKfUsrM3KY?=
 =?us-ascii?Q?LNuGEYU/xUwbuTaEAWqukko+4Bw1H7/F6WWrwElGkTl/TO/+dBABJ3+RwZbb?=
 =?us-ascii?Q?IuW8YC+muf+kmdfrwSlXeWXj1MImCVeoZUPWF5q0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745bd347-d31e-442d-c45b-08db6698d69c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:18:02.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKoVnrAZFsrZEBNrgBuVXl5LlbDDIXozVtp1phsvCy4P5Oq9+o5XAKCFBeqZvcoM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161
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

On Wed, May 24, 2023 at 03:48:43AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, May 19, 2023 7:50 PM
> > 
> > On Fri, May 19, 2023 at 09:56:04AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Thursday, May 11, 2023 10:39 PM
> > > >
> > > > Lu Baolu (2):
> > > >   iommu: Add new iommu op to create domains owned by userspace
> > > >   iommu: Add nested domain support
> > > >
> > > > Nicolin Chen (5):
> > > >   iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
> > > >   iommufd/selftest: Add domain_alloc_user() support in iommu mock
> > > >   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user
> > data
> > > >   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
> > > >   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> > > >
> > > > Yi Liu (4):
> > > >   iommufd/hw_pagetable: Use domain_alloc_user op for domain
> > allocation
> > > >   iommufd: Pass parent hwpt and user_data to
> > > >     iommufd_hw_pagetable_alloc()
> > > >   iommufd: IOMMU_HWPT_ALLOC allocation with user data
> > > >   iommufd: Add IOMMU_HWPT_INVALIDATE
> > > >
> > >
> > > I didn't see any change in iommufd_hw_pagetable_attach() to handle
> > > stage-1 hwpt differently.
> > >
> > > In concept whatever reserved regions existing on a device should be
> > > directly reflected on the hwpt which the device is attached to.
> > >
> > > So with nesting presumably the reserved regions of the device have
> > > been reported to the userspace and it's user's responsibility to avoid
> > > allocating IOVA from those reserved regions in stage-1 hwpt.
> > 
> > Presumably
> > 
> > > It's not necessarily to add reserved regions to the IOAS of the parent
> > > hwpt since the device doesn't access that address space after it's
> > > attached to stage-1. The parent is used only for address translation
> > > in the iommu side.
> > 
> > But if we don't put them in the IOAS of the parent there is no way for
> > userspace to learn what they are to forward to the VM ?
> 
> emmm I wonder whether that is the right interface to report
> per-device reserved regions.

The iommu driver needs to report different reserved regions for the S1
and S2 iommu_domains, and the IOAS should only get the reserved
regions for the S2.

Currently the API has no way to report per-domain reserved regions and
that is possibly OK for now. The S2 really doesn't have reserved
regions beyond the domain aperture.

So an ioctl to directly query the reserved regions for a dev_id makes
sense.

> > Since we expect the parent IOAS to be usable in an identity mode I
> > think they should be added, at least I can't see a reason not to add
> > them.
> 
> this is a good point.

But it mixes things

The S2 doesn't have reserved ranges restrictions, we always have some
model of a S1, even for identity mode, that would carry the reserved
ranges.

> With that it makes more sense to make it a vendor specific choice.

It isn't vendor specific, the ranges come from the domain that is
attached to the IOAS, and we simply don't import ranges for a S2
domain.

Jason
