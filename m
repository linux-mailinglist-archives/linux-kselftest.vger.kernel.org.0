Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE821691277
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 22:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBIVNc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 16:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBIVNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 16:13:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD89F5A938;
        Thu,  9 Feb 2023 13:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yne6rBf3HjNzUJ+jGf+PUwWmHD1xFIYeEWAumOhMzjo6pCVpsYAOHt7xNoJANjctcVyL2cTv38WEPMst+oWjMJJQxIYh/ZW/PVEvaOzLMfoqV6gCm+e1qOYrLET0jFk+TOjg0jw5Ks5OUii+UVegD0ZerwpO9sIOQMjUALB+6gTzS+ZWsSTwLiIPe7HLo8e7A3+jqf7dYEHI8PvWuzBrVPutMY0i8ma7xjRuInR/uAPff8CMdK0fuvDdxW/qLB4EqvRFg+Rl+PCG1RphmJheoxhH/tkpcSY2Taw1y7jMxZhw3Df7k+umQpPDLKNWKNeV7q21up/vuNRp1oGPAebI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNycMroQNnZOKOs0he3it1PGl4KT1uZh44RjEsoHY3Q=;
 b=GmqBycw65Ybvi0Fxr6eMUpJcuW+MBsW0Ad875Pe7id+m9SOAcxclrO3uFqhRccQWBEw4IJ2tS5H9/mN55eqtdUF5gDITEFFT4jvboeUvyzeVuth5ofRYLugS8SrCCDaWcoQ9nkfj50LxHi2ZNJaf5MY+9M2JvMwM2WhilFnPvGSc4SPYen0HPJe9OtuGmI8GUEoxnNohZR0edlA02rRk/DsPFmTlrVnTnYRVciDlnRqWYl10wJJ3rarQ9TWn494E7rAdWDODeuLp+94OOK6fDA++WcyGZ6UlYHq+SB/d+ki9B397s+3I5xVskcj+3gOA1ikeNRuvI+lRrFojysBNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNycMroQNnZOKOs0he3it1PGl4KT1uZh44RjEsoHY3Q=;
 b=N+gLJn8OH44MaGu9Igls3Cyg0b7SDnJ6ayigLKqgBAeZ5kVgJXzvAp6qQGbaLSB/da8/kQ7ahEg/B9Gu0UsMjgua0mKcyqaqGwI60LNJQXDzXrLYVZyRblvtwEkhf03zwdmlaZXkzRo5+8RO8uPsdioSKCUxckTxUBDdk47WFZGd0wD8JgrJPCCxbtWHnYareTKirFMzqUtYzUDspAwZ0Vqrw75ug9urwzH1avE6hPSoeVEpeB6Ym/je3ldiWRwohHb05ITO2jiVzNm46K+XpYe2wMPDioNUP/kIsLUHaMbUSt/4dFwPVI7M8EXSyyz35NrOzWPrNUgdg1hMQNiDxg==
Received: from DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33) by
 DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Thu, 9 Feb 2023 21:13:21 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e2) by DS7P222CA0018.outlook.office365.com
 (2603:10b6:8:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.18 via Frontend
 Transport; Thu, 9 Feb 2023 21:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 21:13:21 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 13:13:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 13:13:10 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 13:13:09 -0800
Date:   Thu, 9 Feb 2023 13:13:07 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
Message-ID: <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 1454a543-9da0-46e8-5e7b-08db0ae27936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xTdb5ajWVJLHfijLT+FQzhiNCdE2ZvzAhelQ8JEGfbjv2j1BTWBqYPonxDuUB3hvzPzlF+CGXqiVUEcqV/TKuBDrYR6o5tBaUdoSSQHFwT1vBPrIqJGaOF0C9LKjw2D6vCdt/hO9dodcZXDOSw1bO/QjEHowJS0wa8ddeKVzpz/85yEXxWSqLEyX3rTGJCbkxxXom19IJaoGAuaK6FrE6GuZzJeZqXZSRqsxVNQYQW3IBPBY2LE+/3GVzl7dfZxJif99HtT9xQ22828a/gB2w1CWsx5QCnNGWrpnqsR/qBg3ZTJNsgos4Gnxm8hW3yYkY50m9Mi/I2/GeOgVZ55dbvnHN92DCN1BUIxHznmFFiD/dNVhXaCPmVWmD47izpKc5MxHdzNWxP9OSIADRopoHlyNeKwJC/p69LLU9ZHrsNzeKcAOLhwq+tuCLBdgRPSav3uSZx7cXktqoQu5u6VDvNGtleK4ZMTEt6Wg+uChZ+4V9waIZ5QPaH8GdCk/yuuqfWI2uaMBHOQVLL9zYhmtaDD6bwv7jwaStQaAstZKQuPdKfDDCFqJc5mg8V3n3cKAuN/PkPp75ESg7HopHqw+UxHgFpTghhxJNTynFsroXHYPGyAhsF+kB6P9M5z5GLcWF04ahtzAQwIVfp2ffnGgw/k0MJZ3umE9EVJiSZEoGsK61nIVAp4a9o6Dzfgs2Cxn3pUxFakVVgGlkWjU5t2Drg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(86362001)(33716001)(478600001)(83380400001)(4326008)(70206006)(6916009)(9686003)(70586007)(82310400005)(186003)(336012)(26005)(47076005)(426003)(54906003)(316002)(356005)(7416002)(55016003)(41300700001)(8676002)(36860700001)(2906002)(40480700001)(5660300002)(7636003)(82740400003)(8936002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 21:13:21.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1454a543-9da0-46e8-5e7b-08db0ae27936
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 04:00:52AM +0000, Tian, Kevin wrote:
 
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
> > So, call iommu_group_replace_domain() in the iommufd_device_do_attach().
> > And add a __iommmufd_device_detach helper to allow the replace routine
> > to
> > do a partial detach on the current hwpt that's being replaced. Though the
> > updated locking logic is overcomplicated, it will be eased, once those
> > iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> > allocation/destroy() functions in the coming nesting series, as that'll
> > depend on a new ->domain_alloc_user op in the iommu core.
> 
> then why not moving those changes into this series to make it simple?

The simplification depends on the new ->domain_alloc_user op and
its implementation in SMMU driver, which would be introduced by
the nesting series of VT-d and SMMU respectively.

At this point, it's hard to decide the best sequence of our three
series. Putting this replace series first simply because it seems
to be closer to get merged than the other two bigger series.

> > Also, block replace operations that are from/to auto_domains, i.e. only
> > user-allocated hw_pagetables can be replaced or replaced with.
> 
> where does this restriction come from? iommu_group_replace_domain()
> can switch between any two UNMANAGED domains. What is the extra
> problem in iommufd to support from/to auto domains?

It was my misunderstanding. We should have supported that.
Will fix in v3 and add the corresponding support.

> > +/**
> > + * __iommmufd_device_detach - Detach a device from idev->hwpt to
> > new_hwpt
> 
> 'from ... to ...' means a replace semantics. then this should be called
> iommufd_device_replace_hwpt().

Had a hard time to think about the naming, it's indeed a detach-
only routine, but it takes a parameter named new_hwpt...

Perhaps I should just follow Yi's suggestion by rephrasing the
narrative of this function.

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
> I think new_ioas->mutext was meant here.

new_hwpt is an input from an replace routine, where it holds the
new_ioas->mutex already. Yi's right that the code here is a bit
confusing. I will try to change it a bit for readability.
 
> > +     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > +             if (list_empty(&hwpt->devices)) {
> > +                     iopt_table_remove_domain(&hwpt->ioas->iopt,
> > +                                              hwpt->domain);
> > +                     list_del(&hwpt->hwpt_item);
> > +             }
> 
> I'm not sure how this can be fully shared between detach and replace.
> Here some work e.g. above needs to be done before calling
> iommu_group_replace_domain() while others can be done afterwards.

This iopt_table_remove_domain/list_del is supposed to be done in
the hwpt's destroy() actually. We couldn't move it because it'd
need the new domain_alloc_user op and its implementation in ARM
driver. Overall, I think it should be safe to put it behind the
iommu_group_replace_domain().

Thanks
Nic
