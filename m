Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00368692BC7
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjBKAKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 19:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBKAKq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 19:10:46 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07534F54;
        Fri, 10 Feb 2023 16:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ulp6iye6ka0T4CTCKEyih1zWV2KD5fAjJKk9uKkklwn8NYaTXlUywCgSPA8j0zMrXCL4k+wo9VNtpFCyCJlGFRC6ss/oXcSywse+TNe8VzfQnVuLHZrKgPyXIkQcepr82M9gpzoWa67tViQKH/B+UJ4GWcXv7RXxqUZmmCDgjuK3MXf63R052pP66X2X2qL/z+p/zJm5XX4OWvZNt73Q8IgA81GCLHgSEhh5KVdVoWXb385Hdpv94ALIkbkEaN/eGxNHWKtgCVNOCvldYTmHjTENs3qkxIx3jLfcwuTQ4V3CqA6jo8R4p2yO4I6ZbXG7iY+L5OVG3gSWg2ReZ6YzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYffZefFR5UofCVWKPzGnDU++3z8lBP61pLximJd3as=;
 b=dcFOSIbvQnaO6N8X33947FKr3rVEyXdMtlaF9++FGWMZ3NCjkj6bgwPIZXCLmjGdwQrFitJ9akd2Yxc3XWWNtQE0zZzAxL0lqCje33MFWjFLDwE2dOBeTbJiDJM6TR0cin/e3tE3RdGeT5+vhjgdMplh13z0Esnu15m9uA8B/yUVB9Q6NxQPxZzjLZjXNYoqUV5WVRzRSO3/aNMcQY642oJXMbetNz1YffyAr7SKHOZwJHnk3iruf3LSyyzyv4Pws+1vffLA8Q+S4LANUjURkih8AOfuXpqChkA2iOAQSu7wZJrqwF90GKn/XJ1o4bi1ce1MIhPpTkS5g7nBa2JuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYffZefFR5UofCVWKPzGnDU++3z8lBP61pLximJd3as=;
 b=frEcAvcTrVIKQioJlTGXa3l8LCnyBf1m7xjz6UIJP0yeeSDN1tW4M4KSAE8/4RDt4ajOMDpCWuWGu1YamPfFCE49BQmXIzr8QNA4Su6FnFy9q7IbI16NKczde2PaTrLbfG7eRqN9OYHx38RBmejGzLqF4pWYlYJnLC6oAugL3B9sWsR9zBfaTOaTqdiumaGGW7D5jBNZQtJW2YYoGfAd3XpIiK2/u5bQBWdXpOx3kFvaki7/kcMu9zSiMNWwePXJkByVYRRni6PDbOWhtRranaDTURUhYv0GEa8ypZkO4Wc3RQhGeHrJ51gHA8XhkdjCc2XfQs8dT8vSy0V7SuVSbQ==
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Sat, 11 Feb
 2023 00:10:41 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::da) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Sat, 11 Feb 2023 00:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Sat, 11 Feb 2023 00:10:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 16:10:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 16:10:26 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 10 Feb 2023 16:10:25 -0800
Date:   Fri, 10 Feb 2023 16:10:24 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: ce64b38f-a4d0-4d3f-8186-08db0bc46900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nr8VaJnMUbWEvw+Lc0dAKlT88iH5hvPhZpHmUoV5Teaf9jAsml9IdJdHAtBy3bo2brY2lKHVSzkon6rbavbALoYM7JPpj9JFaSkdqaKXWchZ7ZFdQedItb8WQsIVxRmvkTAmYZnx++FO+Eofllffioyq3Hz7PYNBY4H0PRmGItzTeYEMyM82QZLkHnFuPUO6zS9pvAyywyg13ibSN8VozSesuJxQFN82n0v8MG5rxz4UovLLxtAFCrZemj2FrMVKan/+4b0/o/WnhIusv8OVllBgu+Zv8q/Fx2qjbW7Fms6zau5MZS98YBkMDlFWdPD3dUIg/kih8d8mgLjc/0MctUs8mz8eS9UFxRSoH8HwGxA+VtTSPUFW/6MdeUrAe+vZQP57FdugM7Kcj5VNvAzfx+liV0X6r0rNeZC7SuTC+1JH76Th2T2n2Hq8Et4fo007I80AsiJMRsFsWEEFHtgmEGTn+ZKdQQwthEmHqC7fghafL+p3nl3Itu3LyucqIC0jZhkVu1Pjx4I6s75TySI1+v2+Cz4eiRnu0hIHtTfh97iI1USubQIUsmcZhpSGfYOmuUOEjsARQDzezV5fjS98CJFrYwD8b+U/4LsvwVdINDlClEQzs95wSaNMGs0VkKpgreQ0/GtwqyUuk3nm2bDiGId/YN5ofg9FM6H8/jRzy+vxpBrvvfTkBZntJuYvAnveLFPtb/uiJfu4YB2C8luHBG95nC9Tjm6E3NFxTQf5p+I=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(8676002)(186003)(8936002)(7416002)(70586007)(70206006)(86362001)(82740400003)(33716001)(356005)(7636003)(9686003)(4326008)(426003)(47076005)(2906002)(40460700003)(336012)(54906003)(55016003)(41300700001)(5660300002)(40480700001)(478600001)(36860700001)(316002)(26005)(83380400001)(110136005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:10:40.4005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce64b38f-a4d0-4d3f-8186-08db0bc46900
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 02:11:23AM +0000, Tian, Kevin wrote:

> > > > +     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > > > +             if (list_empty(&hwpt->devices)) {
> > > > +                     iopt_table_remove_domain(&hwpt->ioas->iopt,
> > > > +                                              hwpt->domain);
> > > > +                     list_del(&hwpt->hwpt_item);
> > > > +             }
> > >
> > > I'm not sure how this can be fully shared between detach and replace.
> > > Here some work e.g. above needs to be done before calling
> > > iommu_group_replace_domain() while others can be done afterwards.
> >
> > This iopt_table_remove_domain/list_del is supposed to be done in
> > the hwpt's destroy() actually. We couldn't move it because it'd
> > need the new domain_alloc_user op and its implementation in ARM
> > driver. Overall, I think it should be safe to put it behind the
> > iommu_group_replace_domain().
> >
> 
> My confusion is that we have different flows between detach/attach
> and replace.
> 
> today with separate detach+attach we have following flow:
> 
>         Remove device from current hwpt;
>         if (last_device in hwpt) {
>                 Remove hwpt domain from current iopt;
>                 if (last_device in group)
>                         detach group from hwpt domain;
>         }
> 
>         if (first device in group) {
>                 attach group to new hwpt domain;
>                 if (first_device in hwpt)
>                         Add hwpt domain to new iopt;
>         Add device to new hwpt;
> 
> but replace flow is different on the detach part:
> 
>         if (first device in group) {
>                 replace group's domain from current hwpt to new hwpt;
>                 if (first_device in hwpt)
>                         Add hwpt domain to new iopt;
>         }
> 
>         Remove device from old hwpt;
>         if (last_device in old hwpt)
>                 Remove hwpt domain from old iopt;
> 
>         Add device to new hwpt;

Oh... thinking it carefully, I see the flow does look a bit off.
Perhaps it's better to have a similar flow for replace.

However, I think something would be still different due to its
tricky nature, especially for a multi-device iommu_group.

An iommu_group_detach happens only when a device is the last one
in its group to go through the routine via a DETACH ioctl, while
an iommu_group_replace_domain() happens only when the device is
the first one in its group to go through the routine via another
ATTACH ioctl. However, when the first device does a replace, the
cleanup routine of the old hwpt is a NOP, since there are still
other devices (same group) in the old hwpt. And two implications
here:
1) Any other device in the same group has to forcibly switch to
   the new domain, when the first device does a replace.
2) The actual hwpt cleanup can only happen at the last device's
   replace call.

This also means that kernel has to rely on the integrity of the
user space that it must replace all active devices in the group:

For a three-device iommu_group,
[scenario 1]
	a. ATTACH dev1 to hwpt1;
	b. ATTACH dev2 to hwpt1;
	c. ATTACH dev3 to hwpt1;
	d. ATTACH (REPLACE) dev1 to hwpt2;
	   (no hwpt1 cleanup; replace dev2&3 too; do hwpt2 init)
	e. ATTACH (REPLACE) dev2 to hwpt2; // user space must do
	   (no hwpt1 cleanup; no dev2 replace; no hwpt2 init)
	f. ATTACH (REPLACE) dev3 to hwpt2; // user space must do
	   (do hwpt1 cleanup; no dev3 replace; no hwpt2 init)

[scenario 2]
	a. ATTACH dev1 to hwpt1;
	b. ATTACH dev2 to hwpt1;
	c. ATTACH dev3 to hwpt1;
	d. DETACH dev3 from hwpt1;
	   (detach dev3; no hwpt1 cleanup)
	f. ATTACH (REPLACE) dev1 to hwpt2;
	   (no hwpt1 cleanup; replace dev2&3 too; do hwpt2 init)
	g. ATTACH (REPLACE) dev2 to hwpt2;	// user space must do
	   (do hwpt1 cleanup; no dev2 replace; no hwpt2 init)
	h. (optional) ATTACH dev3 to hwpt2;	// clean ATTACH, not a REPLACE
	   (no hwpt1 cleanup; no dev3 replace; no hwpt2 init)

[scenario 3]
	a. ATTACH dev1 to hwpt1;
	b. ATTACH dev2 to hwpt1;
	c. ATTACH dev3 to hwpt1;
	d. DETACH dev3 from hwpt1;
	   (detach dev3; no hwpt1 cleanup)
	e. DETACH dev2 from hwpt1;
	   (detach dev2; no hwpt1 cleanup)
	f. ATTACH (REPLACE) dev1 to hwpt2;
	   (do hwpt1 cleanup; replace dev2&3 too; do hwpt2 init)
	g. (optional) ATTACH dev2 to hwpt2;	// clean ATTACH, not a REPLACE
	   (no hwpt1 cleanup; no dev2 replace; no hwpt2 init)
	h. (optional) ATTACH dev3 to hwpt2;	// clean ATTACH, not a REPLACE
	   (no hwpt1 cleanup; no dev3 replace; no hwpt2 init)

Following the narratives above,

[current detach+attach flow]
	// DETACH dev1 from hwpt1;
	Log dev1 out of the hwpt1's device list;
	NOP; // hwpt1 has its group;
	iopt_remove_reserved_iova(hwpt1->iopt, dev1);
	idev1->hwpt = NULL;
	refcount_dec();
	// DETACH dev2 from hwpt1;
	Log dev2 out of the hwpt1's device list;
	if (hwpt1 does not have its group) { // last device to detach
		if (hwpt1's device list is empty)
			iopt_table_remove_domain/list_del(hwpt1);
		iommu_detach_group();
	}
	iopt_remove_reserved_iova(hwpt1->iopt, dev2);
	idev2->hwpt = NULL;
	refcount_dec();
	...
	// ATTACH dev1 to hwpt2;
	iopt_table_enforce_group_resv_regions(hwpt2->iopt, dev1);
	if (hwpt2 does not have its group) { // first device to attach
		iommu_attach_group();
		if (hwpt2's device list is empty)
			iopt_table_add_domain/list_add(hwpt2);
	}
	idev1->hwpt = hwpt2;
	refcount_inc();
	Log dev1 in the hwpt2's device list;
	// ATTACH dev2 to hwpt2;
	iopt_table_enforce_group_resv_regions(hwpt2->iopt, dev2);
	NOP; // hwpt2 has its group;
	idev2->hwpt = hwpt2;
	refcount_inc();
	Log dev2 in to the hwpt2's device list;


[correct (?) replace flow - scenario 1 above]

	// 1.d Switch (REPLACE) dev1 from hwpt1 to hwpt2;
	partial detach (dev1) {
		Log dev1 out of the hwpt1's device list;
		NOP // hwpt1 has its group, and hwpt1's device list isn't empty
		iopt_remove_reserved_iova(hwpt1->iopt, dev1);
		refcount_dec();
	}
	iopt_table_enforce_group_resv_regions(hwpt2->iopt, dev1);
	if (hwpt2 does not have its group) { // first device to replace
		iommu_group_replace_domain();
		if (hwpt2's device list is empty)
			iopt_table_add_domain/list_add(hwpt2);
	}
	idev1->hwpt = hwpt2;
	refcount_int();
	Log dev1 in the hwpt2's device list;

	// 1.e Switch (REPLACE) dev2 from hwpt1 to hwpt2;
	partial detach (dev2) {
		Log dev2 out of the hwpt1's device list;
		NOP // hwpt1 has its group, and hwpt1's device list isn't empty
		iopt_remove_reserved_iova(hwpt1->iopt, dev2);
		refcount_dec();
	}
	iopt_table_enforce_group_resv_regions(hwpt2->iopt, dev2);
	NOP; // hwpt2 has its group, and hwpt2's device list isn't empty
	idev2->hwpt = hwpt2;
	refcount_int();
	Log dev2 in the hwpt2's device list;

	// 1.f Switch (REPLACE) dev3 from hwpt1 to hwpt2;
	partial detach (dev3) {
		Log dev3 out of the hwpt1's device list;
		if (hwpt1 does not have its group) { // last device to detach
			if (hwpt1's device list is empty)
				iopt_table_remove_domain/list_del(hwpt1);
		}
		iopt_remove_reserved_iova(hwpt1->iopt, dev3);
		refcount_dec();
	}
	iopt_table_enforce_group_resv_regions(hwpt2->iopt, dev3);
	NOP; // hwpt2 has its group, and hwpt2's device list isn't empty
	idev3->hwpt = hwpt2;
	refcount_int();
	Log dev3 in the hwpt2's device list;

And, this would also complicate the error-out routines too...

> I'm yet to figure out whether we have sufficient lock protection to
> prevent other paths from using old iopt/hwpt to find the device
> which is already attached to a different domain.

With the correct (?) flow, I think it'd be safer for one-device
group. But it's gets tricker for the multi-device case above:
the dev2 and dev3 are already in the new domain, but all their
iommufd objects (idev->hwpt and iopt) are lagging. Do we need a
lock across the three IOCTLs?

One way to avoid it is to force-update idev2 and idev3 too when
idev1 does a replace -- by iterating all same-group devices out
of the old hwpt. This, however, feels a violation against being
device-centric...

i.e. scenario 1:
	a. ATTACH dev1 to hwpt1;
	b. ATTACH dev2 to hwpt1;
	c. ATTACH dev3 to hwpt1;
	d. ATTACH (REPLACE) dev1 to hwpt2;
	   (do hwpt1 cleanup; replace dev2&3 and update idev2&3 too; do hwpt2 init)
	e. ATTACH (REPLACE) dev2 to hwpt2; // user space must do, or be aware of 1.d
	   (kernel does dummy)
	f. ATTACH (REPLACE) dev3 to hwpt2; // user space must do, or be aware of 1.d
	   (kernel does dummy)

Thanks
Nic
