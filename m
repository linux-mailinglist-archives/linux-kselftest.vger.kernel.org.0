Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C827640BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGZUuw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGZUuv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 16:50:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B64212F;
        Wed, 26 Jul 2023 13:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P83GIIhuzg51XUUPV+xzndzoqiQOHI7bcBMUVkQz7Wykzf4TWm72KpnySpntGsgGHtKuYUTR2Tx0HTBbj7ZeyfzQkHSDYae1Rs/IJx+hRMeF4cjoGl+az/E5o/BDmnBbA7iVd1uk/IUWOmI9zsc47bpM2dBtthAlU/LnSxstGKm0MxC5dUO/0zCeu6PdqLfZ8Lhfqz1Pqdes4tQKJqC6gUyjNO+YBZA7NQyI39k4cjuc2U7RNrz9V8oc0W6IHCwpB8ecHzdPOmCL/hPUp36Nm4rxjNdElQPGrQTpBb9sC1LvHq5VvrMfGi7w6GageY0wa2l7OYdRvF0bP1/dXKjJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIk6N0/m5R2fmYaSTgQ8GzKzYSaT7DTo6FxWQ4Dsh7c=;
 b=EHhn59j85/pfRiRgipgpHN0yLaQoWt/dMTJmGCxKBpGXK4hckpTIppTFK8X06RR275+LSntvkmkU5uKattkERrsgOhnZ5ft/DH4DBfJLUOaYta0PHIvnf/327x4GaX/vD9Bvz4cxyqMs7h32S8RNmykc/waGjL+wTRxwoptc5R+bp7uIaHlS3wbCJTnYcadecdTmJzKR87ZUm5IPcyjbh15VanbgkinN2wuTLK7qlyuaNGled60CIhNBpajyAcPaFCOC3kAslLjSU3biRusENUwO4HoEEyxA+4KP2fnKxe93l32Yb/rwOlMJbf/hc31Dhwu+voa2hr83NEK6ln0DJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIk6N0/m5R2fmYaSTgQ8GzKzYSaT7DTo6FxWQ4Dsh7c=;
 b=K6xFLySMGuzefko0CFuiHGw+/2Se33MQkBn0hvReNszzE/sJ6Qi1Ntm08tGcQTnr5pXuhNRL9GDzwD3N7Tv0LF6mxB0AbtIQLamX/b9gFv4RY26Ua0b1YeLlEXhu1+nELkMNWL4xF1CegA74R9K8R4NOuDXHeEFgnKsk4hpcYt60s78jDgEsB7x32XtDmbK3y+DE4nyMJ9VFuoOHCzQVu3YwPRZ3N4tM+aQ+IBboGDiGKL+kd4J1uCGx18evdR4NmdSCqleFGrMjcTbvDSto1KaflvqFtNsE5SurRW3+gyGLZXHJvDc6SGv2aDghC64tilxgf+/QBG3PFI04DzHDVQ==
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 20:50:45 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::ae) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Wed, 26 Jul 2023 20:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 20:50:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Jul 2023
 13:50:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Jul
 2023 13:50:30 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 26 Jul 2023 13:50:29 -0700
Date:   Wed, 26 Jul 2023 13:50:28 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <alex.williamson@redhat.com>,
        <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMEt+SMFBMKT3AoT@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d7ed64-a479-4a57-8b1c-08db8e19fbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+8Qa4j1Jdv+vGydIxZimhGKXSFgnM5me3XjMD78qNXdgsSRKG1mIZn3EghL+PuoFFbBu2ncwHAccFMYFI8TRQOTG8KCMbirIDBVh0fanZbQK+7j2v+plfBuoYafK52nRkDVJqkTdw2aS8hVY4lNwZkzK5qluUV2mm05Na6HDWNM//67ete8oWkDB9v5QvREkx0WaC2lFRam84m/Ou5ZIzzgvI1E/jo2MDWS5GunM1r5Z0tBfrOltEQQY41cgfP7BZoGRdSKJLB/Q90DsocdUYNW2+Wsa532zadiykEhuqI9rTgg7f5Tq4u8klSF1V48c4tg9rjwcBITtSULKMRS+VrkbFgkOR4pLK5Z0KLnoQYcyyOtfJbaWV1m6BmE+PxQ7/mpZN5x9sZYOtZWG3kVhKvcwCcxIsClB1jHZm2iNk6MKi1bGzYxQzubofSsfZjdN5Yal3MDjo5CfQvlRrrbjGpKJAvSxE4H7HLwDHsanyfsM7PItkPyEbyw1lAC50Us2bgdnQpCkPdVs/k4xcCg3/56iO5/irniMwI70xSUHaaNgno8qNCevt2WfSVD7onwDhVQ3iBVhE5MQUY6wSpYC3t+7Rrz50w53t5LpZ1zk3zmvWyHzLM9IlyWa6h4MCD1Bcz8pY09TcPgxIV9LQpK1v9q9vQqw+idS5lKrA+7JteZawrpdJGDPyqsZG+dGlshWsHc8pcLPjq3oCjATylhY68dX/9bRFAR+4XDFoiVSHzSXny/QKRXC7/PlvYyS7fYXl2crQ4tFHTREl0YneiqcA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(426003)(47076005)(86362001)(55016003)(356005)(7636003)(36860700001)(5660300002)(82740400003)(8676002)(8936002)(6862004)(7416002)(316002)(40460700003)(4326008)(41300700001)(6636002)(9686003)(336012)(70206006)(186003)(966005)(26005)(70586007)(54906003)(478600001)(33656002)(33716001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 20:50:45.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d7ed64-a479-4a57-8b1c-08db8e19fbcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
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

On Wed, Jul 26, 2023 at 11:30:17AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 12:47:05PM -0700, Nicolin Chen wrote:
> > -int iommufd_access_attach(struct iommufd_access *access, u32 ioas_id)
> > +static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
> >  {
> > +	struct iommufd_ioas *cur_ioas = access->ioas;
> >  	struct iommufd_ioas *new_ioas;
> > -	int rc = 0;
> > +	int rc;
> >  
> > -	mutex_lock(&access->ioas_lock);
> > -	if (WARN_ON(access->ioas || access->ioas_unpin)) {
> > -		mutex_unlock(&access->ioas_lock);
> > -		return -EINVAL;
> > -	}
> > +	lockdep_assert_held(&access->ioas_lock);
> >  
> >  	new_ioas = iommufd_get_ioas(access->ictx, ioas_id);
> > -	if (IS_ERR(new_ioas)) {
> > -		mutex_unlock(&access->ioas_lock);
> > +	if (IS_ERR(new_ioas))
> >  		return PTR_ERR(new_ioas);
> > -	}
> > +
> > +	if (cur_ioas)
> > +		__iommufd_access_detach(access);
> 
> The drop of the mutex while this function runs is racey with the rest
> of this, we can mitigate it by blocking concurrent change while
> detaching which is if access->ioas_unpin is set

Oh. You mean that unmap part dropping the mutex right? I see.

> >  	rc = iopt_add_access(&new_ioas->iopt, access);
> >  	if (rc) {
> > -		mutex_unlock(&access->ioas_lock);
> >  		iommufd_put_object(&new_ioas->obj);
> > +		if (cur_ioas)
> > +			WARN_ON(iommufd_access_change_pt(access,
> > +							 cur_ioas->obj.id));
> 
> We've already dropped our ref to cur_ioas, so this is also racy with
> destroy.

Would it be better by calling iommufd_access_detach() that holds
the same mutex in the iommufd_access_destroy_object()? We could
also unwrap the detach and delay the refcount_dec, as you did in
your attaching patch.

> This is what I came up with:
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 57c0e81f5073b2..e55d6e902edb98 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -758,64 +758,101 @@ void iommufd_access_destroy(struct iommufd_access *access)
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
>  
> -void iommufd_access_detach(struct iommufd_access *access)
> +static int iommufd_access_change_ioas(struct iommufd_access *access,
> +				      struct iommufd_ioas *new_ioas)
>  {
>  	struct iommufd_ioas *cur_ioas = access->ioas;
> +	int rc;
> +
> +	lockdep_assert_held(&access->ioas_lock);
> +
> +	/* We are racing with a concurrent detach, bail */
> +	if (access->ioas_unpin)
> +		return -EBUSY;

I think this should check access->ioas too? I mean:

+	/* We are racing with a concurrent detach, bail */
+	if (!access->ioas && access->ioas_unpin)
+		return -EBUSY;

Otherwise, a normal detach() would fail, since an access has both
a valid ioas and a valid ioas_unpin.

> +
> +	if (IS_ERR(new_ioas))
> +		return PTR_ERR(new_ioas);
> +
> +	if (cur_ioas == new_ioas)
> +		return 0;
>  
> -	mutex_lock(&access->ioas_lock);
> -	if (WARN_ON(!access->ioas))
> -		goto out;
>  	/*
>  	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
>  	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
>  	 */
>  	access->ioas = NULL;
> -
> -	if (access->ops->unmap) {
> +	if (cur_ioas && access->ops->unmap) {
>  		mutex_unlock(&access->ioas_lock);
>  		access->ops->unmap(access->data, 0, ULONG_MAX);
>  		mutex_lock(&access->ioas_lock);
>  	}
> +
> +	if (new_ioas) {
> +		rc = iopt_add_access(&new_ioas->iopt, access);
> +		if (rc) {
> +			iommufd_put_object(&new_ioas->obj);
> +			access->ioas = cur_ioas;
> +			return rc;
> +		}
> +		iommufd_ref_to_users(&new_ioas->obj);
> +	}
> +
> +	access->ioas = new_ioas;
> +	access->ioas_unpin = new_ioas;
>  	iopt_remove_access(&cur_ioas->iopt, access);

There was a bug in my earlier version, having the same flow by
calling iopt_add_access() prior to iopt_remove_access(). But,
doing that would override the access->iopt_access_list_id and
it would then get unset by the following iopt_remove_access().

Please refer to :
https://lore.kernel.org/linux-iommu/ZJYYWz2wy%2F86FapK@Asurada-Nvidia/

If we want a cleaner detach-then-attach flow, we would need an
atomic function in the io_pagetable.c file handling the id, yet
I couldn't figure a good naming for the atomic function since
it's about acccess shifting between two iopts other than simply
"iopt_repalce_access".

So, I came up with this version calling an iopt_remove_access()
prior to iopt_add_access(), which requires an add-back the old
ioas upon an failure at iopt_add_access(new_ioas).

I will try making some change accordingly on top of this patch.

Thanks
Nicolin
