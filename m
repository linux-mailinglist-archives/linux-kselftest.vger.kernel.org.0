Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5876975D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjGaNTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjGaNTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:19:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6AA10E3;
        Mon, 31 Jul 2023 06:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkIHSAA2Dvl4nWu/mwHkdeC2SArctjTdsXVEqH2uyHJ2uzARrWXaEx+HlO+JeeLefDIS2cn05uMgHpgT0+NR1PWEArur+dz1LbWMSs60HIalwDGHG55M3qouMjwQ/a5AlNO8mgKDm98j2R0KjLoVStqLXtIgTmZY2DGAnsGTkTLCyAD23RP11lIahEXrESkMeeNh1EBD/wXvAGXKsy+UnJGTDVGMNnl3ttPvelJEnNVf1EFo1mfjxddMOSrOK7Q5ptamW5fqWviXNXdmITcv7fAGy/1jkQVxt+26ZBtAos+/Wyzu7rw16jYonI3DitM+SKXeoRh4o9e/hAompYOI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3DKIGfSENy/1vf3oZhKN784bC41P+r+YLMQEyimEQ0=;
 b=lc+WqhEFSv1v/jVWD3bt3umu7UMBKYh+SlI4Uu10IPT2E9fAV9picUKy4Ed1rht8y5e2wh4Fm8z9l0xxVXoZJ1FpOrkYY6N3SAaKL4H6KQ8LMhmv860cHzYbSU0driyYblCHYT5gNIB9vWW8fZHz5mlPr8c3O5QMpyGOdq9yS7hKm+qH6OOp9yK7xXtTevBnc4PMNIESrGpK1dB78cj5KAwuV48jZOZ/f1T4EdnHae5ymNHJ7qTAjikjy9Ga3fCkkYAaNr2xz8QBge3I0LKDQmMTnxGgdaM0Q+jxBfE3SLoW9gI7hxhWWxeYkgeC0tN2E+nPepbWQa5Quqay/nyN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3DKIGfSENy/1vf3oZhKN784bC41P+r+YLMQEyimEQ0=;
 b=OgwFkB2U5hOaXOjfow/F/whwZjqrRXUdLgJZ4ILrrj6D1DS3H57QuWVIrV/FxNOnARAp047OJhYo4YldQwDdHVIkf8OvgYOY4p1D1+rfDte5wPNHy9yLpaLXKpzugCacMi6hc6THWyBH3i8L0O5yxKu2KNn/JsJU0jcd9MzmI206x8+bOd+mDv6mhobcIhUm8/3Ncc7Tts6qxm8sDe/8KNnRK3bRg1xURKLwadhL1zgI7ymdAtG79w8NMFJDkBRiSMqyMubYa9G6pkmpp3CNp2U7d3zMR3PxUrmretQZT1v5pdO2917ZIjtrqa5VRINeV34BjFVGiEWtMjfaJSyMuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 13:19:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:19:42 +0000
Date:   Mon, 31 Jul 2023 10:19:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZMe068UGnltoeBOK@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-2-yi.l.liu@intel.com>
 <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMPzJd6iIFk/51Om@nvidia.com>
 <DS0PR11MB752907DDEBA69BFD823F09EBC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB752907DDEBA69BFD823F09EBC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf2208c-204a-4b23-c458-08db91c8ccbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwb0JmlgPE88dU7huYvo55qy8ZirvMCrpfOuW5dWhFmH50iEGF5SCi5Yqh4PnnGFdplXK0q2PgoiT16k/0jToYlMLROhSCtbuq6XrMiilaMSKk1f4KJyZBOEvsQ+S6GiOjgz8qvU7zB8BxEFDjfy6zyE/crHrHowF+dn+UOjrZ2PbIZyl9rX4Ztw2ZPZF0vMrWqdawZEGsi1C84AwQwCoh0Rlm/r/SVrF+yzOe2K2R30dmBN0fKDPHZLhjrrtHOWXneAtb70+xe8YlDClNkf4+paQD+cU4OykwyNYp45n+CA2ZA2eqylYmjHD3BuButO3hAKBlCTr3NOs64jCYKE0S03AO79GMlfLIvHueXLmC0SeRx8FA4juRWiKj/pDAflCrjP8I8sX5a+T+ruZRlt2UxbtOKj9x0tXeC61rKfH6i3cPPzju4AZavKkcgvQZUgM/xx+1swdKl3Ox7emF4R69BbZdd5J2ZZI6pfwDH0r6FHzs0q67PzER6o7B/l2AEiN6kAcGxPmt0E4Kv8usQBYPZVyA2W5lccgFul6KxJSVGwrlRKRsrnkVeTLJHo7Jie
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(6486002)(6666004)(6512007)(86362001)(36756003)(186003)(2616005)(83380400001)(26005)(6506007)(38100700002)(6916009)(4326008)(66556008)(66476007)(2906002)(66946007)(316002)(5660300002)(7416002)(41300700001)(8936002)(8676002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jICyIRznu25iaAYvtpY727KB2JzKL5aV9Cn7c+r5TldbdYP7FPM1Rp5H9GFA?=
 =?us-ascii?Q?5MnWSIwt0C/CU0EwvEzC6aUgvb7xFGLfHm/nNpHbwq/p493Xo1sEjZ0SUh8V?=
 =?us-ascii?Q?45bQozCa+Iz1mRo7zbSZMzGl83ZnSEd6E1B5Ol5eb+3WZBVajf9DpjdWHtRF?=
 =?us-ascii?Q?2Mp9pNU1QOdH13fyGTKOhtzMa5rh9ZsL8UangVJNyC6O9N3mbVlF5/sZJ1zp?=
 =?us-ascii?Q?RYvnbFj+JmShIgKjQEcZJet1euIwmndxWD7Tyv66HoMnA9jPk9z6OCSJilgA?=
 =?us-ascii?Q?nT34Bxr3fRgZeCugf56+y9xnNDq833FllBfxsEUjY89vQxHYAaRwqOkAsCoE?=
 =?us-ascii?Q?sEYiTELylSjg6QEfiaRZIMxW2cMJI4TF7HIRORhonJLz48QW3S2ofDdMiBF6?=
 =?us-ascii?Q?hsVKfVLU4CI7oCK33q0fDbeHwVYiTUCqIO8jlMAstkJGz13ixBJv7b7TNO0n?=
 =?us-ascii?Q?fAYLDDd0kSKN8rn1cxB7qQ/a0LluH0HKlN9ufhqz/0503wHpzu1mF+ASYfow?=
 =?us-ascii?Q?SrCPuANaj1XabMY9OzkChQpa0VETAdrrg2O+UEZnpZUUEwPIq/OORbyVU/C9?=
 =?us-ascii?Q?xnaCi27Te9EfwznWCGV6bHhsUd6MpC7Rf9pUO3MdQxga+3wsXuGsnVFAzGd1?=
 =?us-ascii?Q?rRsu7CqPBghhYRyCN1MkOjc0aUpbksA1CEZENCrvcJpFvDXM2fn2JQ3Ux+f7?=
 =?us-ascii?Q?PeTjZQfsIYxoG2/+Qw9sq/Ni1eVC8r/DKjM3mjc0t8PYeiEkYkpq9zVuYA1l?=
 =?us-ascii?Q?keraRsF/8jg9Bl5l8TXYEvRbHpTXLqt54sF2OFm1RgIdjqCOeqTRj9R/mF6H?=
 =?us-ascii?Q?hkHD//K9benP+n4mBS46q1jb3Qd/Qvz2X3ayDxVDblqxcb7QSc9ph+/XuNog?=
 =?us-ascii?Q?C4MwNd0r1dntkDxchDdIC6mZsp0SydngN/zdtH0QnpTra6av7o3/7mPSZNm7?=
 =?us-ascii?Q?H7YC76sfnfqsC1w5EkOvnLcVdpO4cUr2O6ahkplIGrQlTkl75YPSbBHTdqUY?=
 =?us-ascii?Q?uRusyFMwz6SBOlwE8lR1YGOzCpcqEhUBIWkwxQJPO6PVAVSRtR+D6l75JIAr?=
 =?us-ascii?Q?WMkOQ6ZgNYnqvNbnR/zYX+3wamVLDJ9/fOA0tJoWl+WsKlLGHKxU7VL1q8ei?=
 =?us-ascii?Q?lbVHRwS7gYP/XEjRwmu65RD6P0+5hg3bUMof6bUZ+Ndv3YPPiy40GoJkPxtc?=
 =?us-ascii?Q?Le7sckf4uDx2Vah++SDcB9SPNXBEZ5YoaMzvxn0pcrrnwiKtrttpY8qKVhSP?=
 =?us-ascii?Q?UAauD6qg15gePPxZSsR21jtNT3DadWlTdnTeF+tTjBjNvPofu63wStgS5CNl?=
 =?us-ascii?Q?fGdP3QfoUT6xds6idFwkWFganuxuYFb3hMBsK61bIqoWvoSP+G344FBoy7QY?=
 =?us-ascii?Q?w4Ocpx8bk2AtSFBGqDj/Dz67qig4peIh74Ki8Rbv+mozlBgnL4WWDXq2Hazy?=
 =?us-ascii?Q?0mlmP67nih8sab1UZxfBCvae4QQnvRhD6a99ExQYyk8+2PqWJZKX6ICBRb77?=
 =?us-ascii?Q?Yz3MoAOvsHMyy0AoHyZj9K3yCkF4qqfK23jwjLYTNn7QtP7Ms0EcL8ZcsDjF?=
 =?us-ascii?Q?lI5wfcDeFWoceYLX7PR6JcTzjt5iEQkStkzEOu+c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf2208c-204a-4b23-c458-08db91c8ccbe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:19:41.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsQ4VXMHManqgDf2mJ79euMJlhly+cnqv59bJ1vL5gg+w3yYDYkYDd+RwA4hXJHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 12:44:25PM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, July 29, 2023 12:56 AM
> > 
> > On Fri, Jul 28, 2023 at 09:37:21AM +0000, Tian, Kevin wrote:
> > > > From: Yi Liu <yi.l.liu@intel.com>
> > > > Sent: Monday, July 24, 2023 7:04 PM
> > > >
> > > > + * @domain_alloc_user: allocate a user iommu domain corresponding to
> > > > the input
> > > > + *                     @hwpt_type that is defined as enum iommu_hwpt_type in the
> > > > + *                     include/uapi/linux/iommufd.h. A returning domain will be
> > > > + *                     set to an IOMMU_DOMAIN_NESTED type, upon valid
> > > > @user_data
> > > > + *                     and @parent that is a kernel-managed domain. Otherwise,
> > > > + *                     it will be set to an IOMMU_DOMAIN_UNMANAGED type.
> > > > Return
> > > > + *                     ERR_PTR on allocation failure.
> > >
> > > "If @user_data is valid and @parent points to a kernel-managed domain,
> > > the returning domain is set to IOMMU_DOMAIN_NESTED type. Otherwise
> > > it is set to IOMMU_DOMAIN_UNMANAGED type."
> > 
> >  "If @user_data is valid and @parent points to a kernel-managed domain,
> >  then the returned domain must be the IOMMU_DOMAIN_NESTED type. Otherwise
> >  the returned domain is IOMMU_DOMAIN_UNMANAGED."
> > 
> > Notice the detail that this API expects the driver to set the type and
> > fully initialize the domain, including the generic iommu_domain
> > struct, which is different than alloc_domain.
> > 
> > When we implement this in drivers we should tidy this so all the alloc
> > flows fully initialize the domain internally.
> 
> Yes. this should be documented in the kdoc. Is it?

Yeah, maybe it should be mentioned

Jason
