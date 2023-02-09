Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77778691244
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBIU4I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIU4H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:56:07 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15532658ED;
        Thu,  9 Feb 2023 12:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSt2hoLSMXNwOIq+g7tffssnfh6jrBtnQ//HUWAi+gf5JLeEQcxzAWE2nSVduvPq9HdwfUNrXHAE7M3nabHleb01dKKKErgpa0cIYVDM7y4nlT+8GKfURybV3NSQlYxhMbQjqf4XMNMs1WEaWAN8RDWzougzJVOfFgUn5Eak72I5S26VFcyQ3lDh12QInhqv8eoulXwEIxuqqrgdAPiY54G4N+eTojR/lfBqe5bFY4+smWQkYtRTmprQbbIKEEEOd3qr5UOo7fEMp7EXB+PMKlKclspTAU8OUNgE5Sy254xaZFvV3dQgui7trmrbB6HmhMqQ8dgoH49HIrq0avyjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYOW5JLFn0qyiFnZxG6WMlNiqh5mNMin9+3Fu5aJrDM=;
 b=nQ+yUqeGxK8SO52XFJTJN7JNu0fYZLU4cOyNURcZkq5TggrqlyyGI1WcA0saGTA6LTTInADQshtG3m0+vPMHx3QZKdtcubugr5UTc8+6JcXzJkRf+Paer44gix375Qd5jEU2Y9uY+tWCLaAbPz/3tS77EbqekDis3cl1Fpvq9wYsvdC4nBnmoPY4m3O8Ac5XTGSiESNo4XFnNWBnMuHtDswoNovWx1KC3fzCqB0rwKX6WfMctrWZc5u1HsEdSNobCSv2inVFQApxG2PTuHabvpzvH9gX9eORRmeh3aYYmdByGvdXpTuvfIykF+lWqoXtk54L4mYCl55/gLbu92xKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYOW5JLFn0qyiFnZxG6WMlNiqh5mNMin9+3Fu5aJrDM=;
 b=Le3Axmf3h9kuyrB/3uUVaLqPbkIDHR54qi97EbowFcmuqngsNXMrt1Ew/YPTBjwRUdBZtZL5EmdLIhEqBFLWn1KEBBjfj34GZbup4K5GcP4juCVhNrHFGF3AzuTUN149frSQ2+zH9EcusK0hj36My/JxeiTRBXUsuPdm8Ef2aEyKgIwUfbkCQ/PYsklijDY/9UXtWpCJ7lwUnAXBTCpU1BkliVqQQeKUnaraVzhzkHdzat8V5M9+VIYzQ1QvafqQ9isvRu0uYXq9x/la3LowPUj/rewAGoTrxzMT59Bd6Zx/lzQu1U2II6CaipMXoqwAuTHROOklQeDhZaQrHx3hdQ==
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 20:56:01 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::84) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 20:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 20:56:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 12:55:54 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 12:55:54 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 12:55:53 -0800
Date:   Thu, 9 Feb 2023 12:55:51 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+Vd17huIxYPJMrI@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <DS0PR11MB75293887741EEB8953BCB0A9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB75293887741EEB8953BCB0A9C3D89@DS0PR11MB7529.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|IA0PR12MB8205:EE_
X-MS-Office365-Filtering-Correlation-Id: 807d4290-53e5-4e2a-92d4-08db0ae00d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKCFAyYQdBTZExyUcNgAE5z5lun5DPHk5+MGrS11v7A36G555tRpsOf0yXIgWRRXUm/nsT5ggo0fP4jKdRSdwO/ydNzRHPqjq0Lq2+UNyB2TbkwmTkAiFK4X5s2btjs0wWm0Yqq3UcRX+gLMB/ugGj5hH2Q/VOrw3AFJNfPeo27gSAu+5OlTtg4W8Nd+9RrvFQg7raITDCWoUiRuMONNncLaIuwJsheF0k/keNfZ7QwU+KAJR7RyciYk4zRBzl7PH3A7LBnm2ZrKjQTV/Y9/7BGJw09NCion3eZe/PG+HLIy74cCxT2ZGab1jYZrQoG0aTBck9Wjp7mhWS0So3lr4IzGCPkO1/qT/XmIYA/QWAz6SYL959Q5SiJAHGSZBLnBzoT0l0rPjrI+OIrWv00z8MsG975O4+4g5Md3aNgVlVLRsswg/Ph7aJAt5yxXpl3h3gZURc4HAL+qMoO//BzkKn/c9+jVpOsSgppS+94CqB4of76rgekWeFduQqtI91P9gxlPEs36KKdYNcBP1Osl7PucbMo7h33lRx/S1ZbIGmletTplfTGnmjQNWKWgTU3u1sO8DEOcmtdELGSTpETVq9bLS2Ryl/6bTaeFpE+MkeeZjVazdc8KDaX9dzdqWzUXQ+0XyEuwOwmXqnilV3Q0Eb0Df8LYyo9f+qI5M7F6LPD7Y3TKQT2lWhcnQA8pYhgao7lqPxxvEWIMBparD/lEfRrHvqjwUFJuugzPCzSZRtA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(33716001)(26005)(186003)(82740400003)(9686003)(86362001)(82310400005)(36860700001)(356005)(7416002)(70586007)(316002)(70206006)(8676002)(54906003)(55016003)(426003)(336012)(47076005)(478600001)(40480700001)(40460700003)(6916009)(4326008)(41300700001)(7636003)(83380400001)(5660300002)(8936002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:56:00.9243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807d4290-53e5-4e2a-92d4-08db0ae00d0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:08:42AM +0000, Liu, Yi L wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> >
> > iommu_group_replace_domain() is introduced to support use cases where
> > an
> > iommu_group can be attached to a new domain without getting detached
> > from
> > the old one. This replacement feature will be useful, for cases such as:
> > 1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
> >    table with a larger table (PASID=N)
> > 2) Nesting mode, when switching the attaching device from an S2 domain
> >    to an S1 domain, or when switching between relevant S1 domains.
> > as it allows these cases to switch seamlessly without a DMA disruption.
> >
> > So, call iommu_group_replace_domain() in the
> > iommufd_device_do_attach().
> > And add a __iommmufd_device_detach helper to allow the replace routine
> > to
> > do a partial detach on the current hwpt that's being replaced. Though the
> > updated locking logic is overcomplicated, it will be eased, once those
> > iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> > allocation/destroy() functions in the coming nesting series, as that'll
> > depend on a new ->domain_alloc_user op in the iommu core.
> >
> > Also, block replace operations that are from/to auto_domains, i.e. only
> > user-allocated hw_pagetables can be replaced or replaced with.
> >
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/device.c          | 101 +++++++++++++++++-------
> >  drivers/iommu/iommufd/iommufd_private.h |   2 +
> >  2 files changed, 76 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/iommu/iommufd/device.c
> > b/drivers/iommu/iommufd/device.c
> > index b8c3e3baccb5..8a9834fc129a 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -9,6 +9,8 @@
> >  #include "io_pagetable.h"
> >  #include "iommufd_private.h"
> >
> > +MODULE_IMPORT_NS(IOMMUFD_INTERNAL);
> > +
> >  static bool allow_unsafe_interrupts;
> >  module_param(allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
> >  MODULE_PARM_DESC(
> > @@ -194,9 +196,61 @@ static bool
> > iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
> >       return false;
> >  }
> >
> > +/**
> > + * __iommmufd_device_detach - Detach a device from idev->hwpt to
> > new_hwpt
> 
> This function doesn't do anything to make this device attached to new_hwpt.
> It is done in the iommufd_device_attach_ioas(). New_hwpt here indicates if
> this detach requires to do some extra thing. E.g. remove reserved iova from
> the idev->hwpt->ioas. So may just say " Detach a device from idev->hwpt",
> and explain the usage of new_hwpt in the below.

Yea. You are right.

> > + * @idev: device to detach
> > + * @new_hwpt: new hw_pagetable to attach (pass in NULL for a simple
> > detach)
> 
> The new hw_pagetable to be attached.

OK.

> > + * @detach_group: flag to call iommu_detach_group
> > + *
> > + * This is a cleanup helper shared by the replace and detach routines.
> > Comparing
> > + * to a detach routine, a replace routine only needs a partial detach
> > procedure:
> > + * it does not need the iommu_detach_group(); it will attach the device to
> > a new
> > + * hw_pagetable after a partial detach from the currently attached
> > hw_pagetable,
> > + * so certain steps can be skipped if two hw_pagetables have the same
> > IOAS.
> > + */
> > +static void __iommmufd_device_detach(struct iommufd_device *idev,
> > +                                  struct iommufd_hw_pagetable
> > *new_hwpt,
> > +                                  bool detach_group)
> > +{
> > +     struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> > +     struct iommufd_ioas *new_ioas = NULL;
> > +
> > +     if (new_hwpt)
> > +             new_ioas = new_hwpt->ioas;
> > +
> > +     mutex_lock(&hwpt->devices_lock);
> > +     list_del(&idev->devices_item);
> > +     if (hwpt->ioas != new_ioas)
> > +             mutex_lock(&hwpt->ioas->mutex);
> 
> The lock order is mostly hwpt->ioas->mutex and then hwpt->devices_lock.
> See the iommufd_device_auto_get_domain(). If possible, may switch the
> order sequence here.

Yea, I know it's a bit strange. Yet...

Our nesting series simplifies this part to:
	if (cur_ioas != new_ioas) {
		mutex_lock(&hwpt->ioas->mutex);
		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
		mutex_unlock(&hwpt->ioas->mutex);
	}

So, here is trying to avoid something like:
	if (cur_ioas != new_ioas)
		mutex_lock(&hwpt->ioas->mutex);
	// doing something
	if (cur_ioas != new_ioas)
		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
	// doing something
	if (cur_ioas != new_ioas)
		mutex_unlock(&hwpt->ioas->mutex);

> Also, rename hwpt to be cur_hwpt, this may help
> reviewers to distinguish it from the hwpt in the caller of this function. It
> looks to be a deadlock at first look, but not after closer reading.

Sure.

> > @@ -345,6 +406,13 @@ int iommufd_device_attach(struct iommufd_device
> > *idev, u32 *pt_id)
> >               struct iommufd_hw_pagetable *hwpt =
> >                       container_of(pt_obj, struct
> > iommufd_hw_pagetable, obj);
> >
> > +             if (idev->hwpt == hwpt)
> > +                     goto out_done;
> > +             if (idev->hwpt && idev->hwpt->auto_domain) {
> > +                     rc = -EBUSY;
> 
> This means if device was attached to an auto_created hwpt, then we
> cannot replace it with a user allocated hwpt? If yes, this means the
> replace is not available until user hwpt support, which is part of nesting.

After aligning with Jason, this limit here might be wrong, as we
should be able to support replacing an IOAS. I'd need to take a
closer look and fix it in v3.

> > +             if (idev->hwpt)
> > +                     return -EBUSY;
> 
> So we don't allow ioas replacement for physical devices. Is it?
> Looks like emulated devices allows it.

This was to avoid an replace with an auto_domain. Similarly, it's
likely wrong, as I replied above.

Thanks
Nic
