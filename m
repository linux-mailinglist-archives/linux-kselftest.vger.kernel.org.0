Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614157BD2DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjJIFmA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 01:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIFl6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 01:41:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B8AB;
        Sun,  8 Oct 2023 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696830117; x=1728366117;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Q+TyAN66LCx4gKSW7ekw3CUVAjChAkwhOD4yQBAUdfk=;
  b=INWH/FX6ylUkl2eTBrhreo2VT1sxGAPz879d2Lrc61TMNNSKj5G/xtBd
   6I6sdu9/yKrdtoG+615dCIeefci1y1UVpHm56/go1z1BcMYES5taQZGxD
   JxcmYNpjVcelhXXlg/BnHaIkWZqDKmReIsMX0dAanAO6SsXSLv9EM11jP
   IN7NIvt9iOVwkve72tGUb2HFB9yIP8HLqWlSaB2ISlqise4GWK+MJZ4xP
   9Pp3I5Z0Yx5bg43KuNjhJlwliBD2eULCEiu3xPEmUZVfDX+Ny/BtAj8OY
   sbM3+LTmeXIEZGHVKNaaFIfCdDt4Y1qe7WemTn4WY1bfit8M1hNC3TMwj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387937595"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="387937595"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:41:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="782371988"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="782371988"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 22:41:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:41:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:41:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 22:41:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 22:41:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMIAqhfte4h/0cI8lNzmZJeFbZMsB7/HiicBVePD0ZMiwtc/A2KFqKN9n+yZuEdVECwHjkYhq0l/PYupq2LyVaGqpnzBiznR/oRScEbDvcM7TNvxDkuHK+O9juYQjtumxjcBkD97cnwDmW1i7NZsLyYHs0O77jleCW1rJ826eMS3YtpNG80qodw4fOcm+z7GfpzQXFWNd1m6Wpv3fx3EZ4Xh5JCVV/GlckhTmzmPi37J1nSAAHoi1gGQ6lqH79D6xBq8umJILtj8t1Jltz/g0wPViSPuoMZC10zB1bnvC+kZ4PV7eJVg1MUVNv3Uuo5Sihf7JFXr+HpHKKfjAjFlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvZCdChQtEN2Ha8i0tcKmYmPNRDHTxPiKaYu0WIxN4w=;
 b=mkMlSP66MrBvllGbRFjjJaLrqMYl9QfkioPNrunSfZBwNg8j1DhNucclY8WiajKZNSt+2DIBLiw84UbfQ9fnJfxz2SpKskxGbcromgL0GSJZJ0l0DC2SteIOFaFKig9cj0wVfjaG0JyjLhmb/kWw2TAPlyJJk3hds3DYI/emEnvsJSQ2XJun5mCe9U1WT2DZRRyBgypaB2pWoDc2bBUdiiwIbG47YS8AesbJYGIKCWiKDubSjY3osHKtray7+TN1q5cc0Uhxom3BzYBwS/Ox1zsjOfB1hN/s+ENdx3qdyI39TQym2cw58JIhdIuva1/1vtzGpCGoYJTouO0pApw2cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SA1PR11MB8475.namprd11.prod.outlook.com (2603:10b6:806:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 05:41:53 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 05:41:53 +0000
Date:   Mon, 9 Oct 2023 13:13:45 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into
 a struct
Message-ID: <ZSOMCXBzUMRujp89@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-4-yi.l.liu@intel.com>
 <ZSEuBcLaSq4NjoC8@yzhao56-desk.sh.intel.com>
 <c299567a-5be8-f65f-d8ec-ffd3fa183b03@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c299567a-5be8-f65f-d8ec-ffd3fa183b03@intel.com>
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SA1PR11MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f2b7d1-6f21-4915-c2fc-08dbc88a70bb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9L/y12a9t5vZ3yd8UGU9DeyZf9qhgxENBA1yms4vbO9tmUgC661GowSh8klUGqe7wO9RckPGToFzwfBkTbCrctVucBs74Nu7t1smctkOw3ywvdTIUgWbXMBV383wKAh5hJHmehJcRHwDQmHw2vMvOHMRFATshhL/qXFPCGdEgk0ZrZTzVRDG8fZQRruq20GX/LPwXW8cBccwSlsyDGADT+srma8783GdZ8YmoNKhb/dpA8d7SjrmWprhsFhwq+3rEtYm/7Fr5knQQDWTunTB9OQ+jzvzXkSjSriifwlVqxUvDWibK+VNaTRtr4vBmpLsx1Yg/iZitiWXuxy/m/SxghbbrxXby9H2XLoH/x+Fho/vAByMVF3T8plrKWDBF5YiQAeU4rM/vsVITV3zWrYCz7rFpWuPPNLeKAJAJMEIRxc88Ov7CG0+TDwWGi3WsELD3QLVJX6f6/vKdqV5RjQVd7xFMVeiqTyB8BM9z0AhGdnObmqqy8OlIVnL5Fm0ll7igxd+gcW3jC4qrgWU0H6im7kWHSFl/8MFsi+BcGMXQrQB3iPmqMG2ODbc+GaZdN/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(26005)(478600001)(6506007)(6666004)(6512007)(8676002)(83380400001)(8936002)(3450700001)(7416002)(2906002)(4326008)(6862004)(66556008)(66476007)(66946007)(6486002)(41300700001)(316002)(6636002)(5660300002)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qUXEu6KTvXAzdHn/D2aROar30BFvyh6ZOQRsaBnZpJlx3LleEHm4KOLN/Ds3?=
 =?us-ascii?Q?6rTnCuHHkpKMVCeOzZuvoX4pVtDIvdHfm3vSULUramC5wegp7PhyLrepF9CC?=
 =?us-ascii?Q?MJJ0ZiquDhaasUf7IWp9C/UW2AozfuR2tCHPjT2Ib2Wgm40PFbIL/YtR28s8?=
 =?us-ascii?Q?u4d+BLL31TBBG7xKKdqYwMwI73M1sPpyyR1YT5vUoS4Ln6t9Gxp8yVGJ5YYY?=
 =?us-ascii?Q?a1xhSX83bRcZejbgcwvBjdZgfge/QxZFp7KlKXwiXzNZx/E+f7hPSdKLCpmM?=
 =?us-ascii?Q?4XNnleXRt+rSk5dI+khzsf1bQ0Oga7ICyEB8G6kUYmJYnvgB4hoDMKxjFog6?=
 =?us-ascii?Q?61Uer5fyn2sNOYE0LUHSJmBzPREGIUBOp8AuVSpMKYQvIR3KOkEHYONTKJEu?=
 =?us-ascii?Q?pqeazz4mKN/0a0Vq0XZ1h4rt20RyGmYJIVV2pun3NpV4XnkogpPYXbKkIwgV?=
 =?us-ascii?Q?1hUx5KK4fJfKcQxxPr2nxzEpgQlREPC460ceTYL6frE2Q1aQFp3jt42NV21Q?=
 =?us-ascii?Q?5zv9qd1FG2rYL8k54UC9WAbGt3m3h8F3TYvv0zdtqnfQlSwTbH10lz+zs7iE?=
 =?us-ascii?Q?vIEkaE4ntWYkALuNfL2eMG0lY3Xijgc+yiXnK4qKY+AcjJcEIHoP+uoTjjzD?=
 =?us-ascii?Q?j6hQGpwacgabnBSx3SeZOCAESKGX++ZEjfVUm0c+FX6TS5GP6r4Y7tLRGgFk?=
 =?us-ascii?Q?wJwItGnM480VLNcwDzZUcm/A42lI/0fbUp1JmhdVO6Hluw/suv46vR/kFZEG?=
 =?us-ascii?Q?pBduqw5iHN2Gv5hX9u2WQfvc+mwM4/8+RtIQ7I9cxFy+Q38BBbvbDck9tpVy?=
 =?us-ascii?Q?R6HIY95PZtg+LwYDM0rq+0pjSeqe5UHNTcb/xsP0vMwbV265cxSF7PvXnasb?=
 =?us-ascii?Q?o3VPmHCI2Z4kGjjadqDmzv2RF/XyOpX+aJOeVE08zHg+XLWoGtjP/UAQ7RwR?=
 =?us-ascii?Q?d+gEBxQo2/dJkOHlHCROURttXG3YKSF3CLjbRHi7fSyJR7uyS4whL2pomY59?=
 =?us-ascii?Q?DhNfztguDySxMrFJKoJoArSwWRi2ZK0RdjA/5oqpxjXf2q1t1hlpuXrXET7r?=
 =?us-ascii?Q?7D/c+xec7+72bJLW9QRBj522hlOUG7H/q4mlJnLEhRvp00+DRunULLsaRnla?=
 =?us-ascii?Q?fkZS/PJ1vKoTdVtuaYFO6e2ehBuE5n3Yb/7xMfl9pdvnVPwKSODP3gq3VwtS?=
 =?us-ascii?Q?AqByp+o4OIvYgdK9I3caR8nQP0yTbLeLZtxZRCzzF4HqaZW224HLXopD+49K?=
 =?us-ascii?Q?vKM5j0v+kjvvOvirj8ppZd7ldZRagR5eqfz6JmKvbnzLoMldMho4VdRUe8Ir?=
 =?us-ascii?Q?L/w0LIxrPTjckhN8R24wcajnU3KyKr3xo0GnAgGIZcq0szkNEtXo/fxFpJQY?=
 =?us-ascii?Q?Lc7S8VWWtbiKfdmwH4Xv6IqnEu1aW4QthlnjkI236dM9L5HYSNAWF/Xx1bQX?=
 =?us-ascii?Q?QdXjct1QpjrNb1BvMaCG1huu0s71Gu3nFVEKRpGUmmW9DahfXn/PT+hD3lBU?=
 =?us-ascii?Q?25r5AaoaFg5y8aeVIiLOq2x0XurPloWfS0vPMMVfMzESm6e6aE3CUXIuJek9?=
 =?us-ascii?Q?UHCJ8gfozXZBpQniQiTSP8pJvyRUfLZ2m/rMAH3W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f2b7d1-6f21-4915-c2fc-08dbc88a70bb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 05:41:53.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3Xa/1BjJVcVDw7ooh2HgP3Zni/Qzy+ubRaasMOvU8B0VYRZHe/Z29++yIb8E+65pXb5Tr+WNjK1PKu1drL4qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8475
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 09, 2023 at 12:13:52PM +0800, Yi Liu wrote:
> On 2023/10/7 18:08, Yan Zhao wrote:
> > On Thu, Sep 21, 2023 at 12:51:24AM -0700, Yi Liu wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > 
> > > The struct iommufd_hw_pagetable has been representing a kernel-managed
> > > HWPT, yet soon will be reused to represent a user-managed HWPT. These
> > > two types of HWPTs has the same IOMMUFD object type and an iommu_domain
> > > object, but have quite different attributes/members.
> > > 
> > > Add a union in struct iommufd_hw_pagetable and group all the existing
> > > kernel-managed members. One of the following patches will add another
> > > struct for user-managed members.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >   drivers/iommu/iommufd/iommufd_private.h | 17 +++++++++++------
> > >   1 file changed, 11 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > > index 3064997a0181..947a797536e3 100644
> > > --- a/drivers/iommu/iommufd/iommufd_private.h
> > > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > > @@ -231,13 +231,18 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
> > >    */
> > >   struct iommufd_hw_pagetable {
> > >   	struct iommufd_object obj;
> > > -	struct iommufd_ioas *ioas;
> > >   	struct iommu_domain *domain;
> > > -	bool auto_domain : 1;
> > > -	bool enforce_cache_coherency : 1;
> > > -	bool msi_cookie : 1;
> > > -	/* Head at iommufd_ioas::hwpt_list */
> > > -	struct list_head hwpt_item;
> > > +
> > > +	union {
> > > +		struct { /* kernel-managed */
> > > +			struct iommufd_ioas *ioas;
> > > +			bool auto_domain : 1;
> > Will iommufd_hw_pagetable_put() also be called on non-kernel-managed domain?
> 
> yes.
> 
> > If yes, hwpt->user_managed needs to be checked in iommufd_hw_pagetable_put(),
> > (e.g. as below).
> > Otherwise, this union will lead to hwpt->ioas and hwpt->auto_domain still being
> > accessible though invalid.
> 
> not quite get this sentence.
I mean with this union, hwpt->auto_domain or hwpt->ioas should only be accessed if and
only if hwpt type is kernel-managed.
So, any unconditional access, as in iommufd_hw_pagetable_put() pasted below, is buggy.

Therefore, do you think it's better to add a filed like "bool kernel_managed : 1",
and access the union fields under  /* kernel-managed */ only when hwpt->kernel_managed
is true.


> 
> > 
> >   static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
> >                                              struct iommufd_hw_pagetable *hwpt)
> >   {
> > -       lockdep_assert_not_held(&hwpt->ioas->mutex);
> > -       if (hwpt->auto_domain)
> > +       if (!hwpt->user_managed)
> > +               lockdep_assert_not_held(&hwpt->ioas->mutex);
> 
> this is true. this assert is not needed when hwpt is not kernel managed domain.
> 
> > +
> > +       if (!hwpt->user_managed && hwpt->auto_domain)
> 
> actually, checking auto_domain is more precise. There is hwpt which is
> neither user managed nor auto.

auto_domain is under union fields marked with kernel-managed only.
Access it without type checking is invalid.

struct iommufd_hw_pagetable {
        struct iommufd_object obj;
        struct iommu_domain *domain;

        void (*abort)(struct iommufd_object *obj);
        void (*destroy)(struct iommufd_object *obj);

        bool user_managed : 1;
        union {
                struct { /* user-managed */
                        struct iommufd_hw_pagetable *parent;
                };
                struct { /* kernel-managed */
                        struct iommufd_ioas *ioas;
                        struct mutex mutex;
                        bool auto_domain : 1;
                        bool enforce_cache_coherency : 1;
                        bool msi_cookie : 1;
                        bool nest_parent : 1;
                        /* Head at iommufd_ioas::hwpt_list */
                        struct list_head hwpt_item;
                };
        };
};

> 
> >                  iommufd_object_deref_user(ictx, &hwpt->obj);
> >          else
> >                  refcount_dec(&hwpt->obj.users);
> > }
> > 
> > > +			bool enforce_cache_coherency : 1;
> > > +			bool msi_cookie : 1;
> > > +			/* Head at iommufd_ioas::hwpt_list */
> > > +			struct list_head hwpt_item;
> > > +		};
> > > +	};
> > >   };
> > >   struct iommufd_hw_pagetable *
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> Regards,
> Yi Liu
