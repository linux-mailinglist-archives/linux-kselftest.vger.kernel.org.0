Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176ED764414
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 04:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjG0C73 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 22:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjG0C72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 22:59:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD0C2127;
        Wed, 26 Jul 2023 19:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGfiOYOqwQ9bs0MpWu/9XvhNxLtbktDauNpef8gfAELFinsqjdeTb9GvoUTjaR4oZ4nTdhoJJBme8/+nc+CH/KXeOsZh6acwrWOMnQ3xFuXrBV/fcY9nJjZQU0SjcVgGyHe2MhtpmhxFI3tiYiftWVfv4+K+0RlCW7J550L2NRXSV4vXQIq/Awwvnx2xAdqffGmtG46lQx6MR7y1/PQ/Q7D2cnpb5jP4P1XKK4jCQwMVb9PKdbQQ6FBsXpjJqP4BMhKxgnPOvtRMCERVituSI7v6p2BmUG1iK9RrxZkHTryU7Q0OmuTHtRvNRYSM13MUjtpyMUeAhLENiVVzYCSyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoLMyFtkLC5U1zH2nu0OWVSSVAaORxB0z5ulkdYs5pk=;
 b=SHrYpO3hvsZQwbWyTihmp6lor7qk+j30FfDoRolCa3QB2Xa1DPpc4Eu8m8aVuz83wjjYWQysGFu/3WN/qGJ+FrRbp6iC+N1ye7vXRl3/gb6VnOamdW78Y2U1YC25pBvCO1FAWhwTwJZb2DzeAf9Y64MyXEuLNP1nxi8wqbsaCRQz+nlihhl+xCEpYCTel0QVPlr2IFCAh8QkdM08O8OhNgAXzfKqyBO998O3t7qwXY1peUsusE+r1l4NxLWbf+iRdotH1Z/c6M4fytv1+20QzJr2xtWd4XdD0P/Q6Dp0ICMFOyOGjm3nUeRlZk8hAH2DCboP/c3NzKhk//1SU+ZrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoLMyFtkLC5U1zH2nu0OWVSSVAaORxB0z5ulkdYs5pk=;
 b=e7QAGquul29LADdg0NSpafRgsK4MGnVfslYKS4TRqTY51A5qGStVD72ieXVQK9AqT3grEAXJqakrGcgQOqfuobj6I3UO4y1ErUOX5cnXMeymKVWfGRakghKr7GzAIndWf88dW8KOLKQ8yORlLZ+U3f79TnKMgq8+oRUoRctUmD2W0eTjbUM0c7SKVfWcGJFjDnVtcF9JSXE2vfqyG+DuSErjx5KkzXFsUkymaAXzOWxdyIX4zHt+QSdD16aQtcWJ8W4nMFueKuCXRAk6Q76FaFBGYEpMtjkq5cMlG057iL78DBY4cuCSkfNMFNFs07FYRnvnb0oV6CM2RpbDdrPQEw==
Received: from BN8PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:60::34)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 27 Jul
 2023 02:59:23 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::e1) by BN8PR12CA0021.outlook.office365.com
 (2603:10b6:408:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 02:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 02:59:23 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 19:59:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 26 Jul 2023 19:59:13 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 26 Jul 2023 19:59:12 -0700
Date:   Wed, 26 Jul 2023 19:59:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <alex.williamson@redhat.com>,
        <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMGt/4CCCmUB85HX@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f8e27a-028c-4455-b551-08db8e4d7b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8m42/hGdMDJeoKJLn0Fq5yKa8bi4C5umK9sKCQq8asRLWY2FAYPDqTj52XSBWziPyAXmOB2ZKdqz12XOKbu3uP9croc4fHxL0eofFAlH69oW77Qesvyx9appQMHBA+UtmWbUtlxeyYuIBPOhic2DMRJ9UA73tnRaxqqeVVoqwxTvluKPSdb3Lut8mE+Ezgxsbak24a48TO3SzzwX2q1fRaKf/04rV+pxoOammpEX3Ujixsn6NoUncMacgYreuZ43zfibraTV1sA3vcThLJJd8dm1sRYhY/FWYdN6SPc50qvOftfVghoCrYk4CiBXOVZNcC5u6wa7Rv/jOwB9Imr22y8KHpQX/iEwlX/XBvbSQE4L4pSTmTIWl0aUgEHKWYpscqZz59v0zfBGZjgLHHBO0OdMqHjbiC0FO9ecvQroj+n9pTeZAuc3cV6AcP23cbWGzPGQ65eKDSJgYMHDSPnj8G5Fd/cXU1ecq8Qh4crIF45jGx92S4dHrIxJzAV45WF/HTSawostuxK3JtbYrZAzw3Rz2OEO6aI8M153DoU8HozTtUvZgTzAQDmv6N5NcrIfDx174ZK2g0gqPgqaUawD660iPzZLFgqPNZrbbViPPe+pGosZR9XPWP2svc2PWizUMtMmPR9UaEnNrPu9DIyOZ7LVdekW7FDM7f6MSfxVCBy4+Anrm/ewvySDlxHIlc98vCJAXhasXM/QVwoIbP9c0WnORcMpocS6yaK08y/klf1uc3QWbsFPKGlt0ZiZw9/o
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(33716001)(82740400003)(7636003)(356005)(86362001)(36860700001)(54906003)(478600001)(2906002)(4326008)(6636002)(426003)(70206006)(83380400001)(70586007)(47076005)(9686003)(316002)(41300700001)(40480700001)(55016003)(8936002)(6862004)(40460700003)(5660300002)(8676002)(336012)(26005)(7416002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:59:23.0090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f8e27a-028c-4455-b551-08db8e4d7b19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 26, 2023 at 08:36:31PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 26, 2023 at 01:50:28PM -0700, Nicolin Chen wrote:
> > 
> > > >  	rc = iopt_add_access(&new_ioas->iopt, access);
> > > >  	if (rc) {
> > > > -		mutex_unlock(&access->ioas_lock);
> > > >  		iommufd_put_object(&new_ioas->obj);
> > > > +		if (cur_ioas)
> > > > +			WARN_ON(iommufd_access_change_pt(access,
> > > > +							 cur_ioas->obj.id));
> > > 
> > > We've already dropped our ref to cur_ioas, so this is also racy with
> > > destroy.
> > 
> > Would it be better by calling iommufd_access_detach() that holds
> > the same mutex in the iommufd_access_destroy_object()? We could
> > also unwrap the detach and delay the refcount_dec, as you did in
> > your attaching patch.
> 
> It is better just to integrate it with this algorithm so we don't have
> the refcounting issues, like I did

OK. I will have a patch adding the iommufd_access_change_ioas
first, and it can update iommufd_access_destroy_object() too.

> > > This is what I came up with:
> > > 
> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > index 57c0e81f5073b2..e55d6e902edb98 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -758,64 +758,101 @@ void iommufd_access_destroy(struct iommufd_access *access)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
> > >  
> > > -void iommufd_access_detach(struct iommufd_access *access)
> > > +static int iommufd_access_change_ioas(struct iommufd_access *access,
> > > +				      struct iommufd_ioas *new_ioas)
> > >  {
> > >  	struct iommufd_ioas *cur_ioas = access->ioas;
> > > +	int rc;
> > > +
> > > +	lockdep_assert_held(&access->ioas_lock);
> > > +
> > > +	/* We are racing with a concurrent detach, bail */
> > > +	if (access->ioas_unpin)
> > > +		return -EBUSY;
> > 
> > I think this should check access->ioas too? I mean:
> 
> > 
> > +	/* We are racing with a concurrent detach, bail */
> > +	if (!access->ioas && access->ioas_unpin)
> > +		return -EBUSY;
> 
> Oh, yes, that should basically be 'cur_ioas != access->ioas_unpin' -
> ie any difference means we are racing with the unmap call.

Yea, will update to 'cur_ioas != access->ioas_unpin'.

> > > +	if (new_ioas) {
> > > +		rc = iopt_add_access(&new_ioas->iopt, access);
> > > +		if (rc) {
> > > +			iommufd_put_object(&new_ioas->obj);
> > > +			access->ioas = cur_ioas;
> > > +			return rc;
> > > +		}
> > > +		iommufd_ref_to_users(&new_ioas->obj);
> > > +	}
> > > +
> > > +	access->ioas = new_ioas;
> > > +	access->ioas_unpin = new_ioas;
> > >  	iopt_remove_access(&cur_ioas->iopt, access);
> > 
> > There was a bug in my earlier version, having the same flow by
> > calling iopt_add_access() prior to iopt_remove_access(). But,
> > doing that would override the access->iopt_access_list_id and
> > it would then get unset by the following iopt_remove_access().
> 
> Ah, I was wondering about that order but didn't check it.
> 
> Maybe we just need to pass the ID into iopt_remove_access and keep the
> right version on the stack.
> 
> > So, I came up with this version calling an iopt_remove_access()
> > prior to iopt_add_access(), which requires an add-back the old
> > ioas upon an failure at iopt_add_access(new_ioas).
> 
> That is also sort of reasonable if the refcounting is organized like
> this does.

I just realized that either my v8 or your version calls unmap()
first at the entire cur_ioas. So, there seems to be no point in
doing that fallback re-add routine since the cur_ioas isn't the
same, which I don't feel quite right...

Perhaps we should pass the ID into iopt_add/remove_access like
you said above. And then we attach the new_ioas, piror to the
detach the cur_ioas?

Thanks
Nicolin
