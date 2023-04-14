Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCEA6E244D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 15:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDNNbo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 09:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNNbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 09:31:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664486AF;
        Fri, 14 Apr 2023 06:31:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDDLAszfJ/cB5L9SlIoT418A9/2SICpjt8FD+2T21rM0YKpJz/nRk7V/rZA725c8XAUeqhY3TmfnchbVch0PH1XcyHd82nVYRUm45FZOHHpPA4Aw3oKrSaBgwdbFiC1pGaoQxceawJbu51NWcrvSR+gnxzEAyqMsLKDjgGz+auT2gWWyoHqlvDHAyGk6Mx1xEWk2QaPZiuMApKzkxoqRs4/c81Gv18J7L6JAF0QXL7+SlYCqUoUTUMCy9okADiZCb3FBSBObqgV/eIwbRYBmkcbDmwUOW8RgTd8psVKhPCMD1a2KWTV42WXAljbqAHbYxsiWuRQ/aKab8CdApEahYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx6WdcHyKAC435IxagxzbsVgCmaW2Skl7tv9+q3hvY0=;
 b=cegDyyS6w9fXhBlm6IIvy8+/DahgMVdgBtfN80Gfs+OMXa8+fBhN5MxuA7siIyB9XNji8bh9klQsaggOZzma/YH1TtSFg0ltzMyR/fMod24RqyVTRyuAzdFwIzpcFnS82u8HCwlo+wyyvC6w5lxjmK9ZtlYZAmEYIuHDoDYuOzJfX9ziUj8+NQXNGNg4rlJctjcvr+jy74loUskEEClJYORMtFaTZUl1/uziSa9qW+FAGA//n/R44PBpdLZvesq9JAWV81C9FR94i0mKLlUx1Bt4PaAPfCPPKikRnE8LIVEpOppisf9IQ9/e4KduyA8I12T+u7YuyCpeldHp6NGg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx6WdcHyKAC435IxagxzbsVgCmaW2Skl7tv9+q3hvY0=;
 b=N8RTPHJHXC0kxSEUkKJADV6MDRtk5LUDRmh0fWIRjsqV1CV9dB73/L0jT4nyibowqHQIAg2MboQ+uZAyH41r87jboLlCeIlG4jDYIDymgOR4f3tsp6xy7wI9nDoEUFlUjTpDu25dbBCOHuDxT9NvW+0X5riHIibFriSvH2yCUon2xWzFY86H5qOu6UH821M+h5rdXoxX7FMtuweNmTwZmdH/pxn8gUVL6UkMUGdPkDHI/OJ78KfH0iYOdX7EvPxkockK2kkXgmIErag1apH960K99WXZS9DEvcrOS6cFgCL8Fgvpt6knshD2R9HSzH8iJ1ModGMQUQQwo7tm6rDylQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6248.namprd12.prod.outlook.com (2603:10b6:208:3c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 13:31:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 13:31:37 +0000
Date:   Fri, 14 Apr 2023 10:31:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZDlVtcwhV2G8ZKao@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
 <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDaTY6OX8oR5w0uV@nvidia.com>
 <BN9PR11MB52762841AAA04A24F76A743C8C989@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52762841AAA04A24F76A743C8C989@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: f81d13ba-2890-4997-8d01-08db3cec92c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHBohgjtVJUoFQcBHJgKzFGualNr2lH68XazZKQjVbWn+D0L1ubMitpYWauLGfbLOZoykhLm/t0da+hmoXAMRmOkYwFYMpB6FS2fduEVmX1/66/3vOzgD3MTDrJTHSlo5t5Tlisi8E1t1hclgKFsiVoNig05kzSJXBJPexJf17YGb97X2uD1OS/tZZLnolu98aOzyShXnVwmU3nkFEKPos6QkfwRIbI7y46vAXdoZaiOjywrG4ZSUrqn02jJzXE41KKspGRFSEgK6eQ5RYp2V0XyTl+juymwLp2mkcjZkdF/fPDwvnU0BnaJ6gmI4Zf2yxdDT5/nZBHJoon+syyVrnMfyVde9YWLnJVJ4jiJSmysmgM5/x1UvTAK4/7aSdS98vnAkEOY+/bWCd1Zdxm9VWZKn1lD6USNsJXqE1H5WRrOqW/W6Ut3OjcxJ34ZsaVvuBhQMAIqd/egcQkj3LAFbh7UCDfgarht8aMOLD89p5SYNBI5Cf7O1g+ky25sazEa1Q4YsHzCYioYP3NOyM08aFomGUNPx9Wg2oagpYWPsu0oWdUmAmDSA6msRUuV9fTIMqskdi6yZTVT9/h0IbtGG0msu9dXbvs4zKv3GbAPJ9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(26005)(66476007)(66556008)(36756003)(6506007)(6512007)(2906002)(6666004)(83380400001)(966005)(6486002)(2616005)(186003)(66946007)(6916009)(4326008)(54906003)(86362001)(5660300002)(8676002)(38100700002)(8936002)(316002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tr9JQQVD/D12Q6toTxPyAwq9WbUVyeHODx6KIqSHIJ5zl5YQiizYtmeVuq1n?=
 =?us-ascii?Q?tU1P2GuTTpNLzy0cJF12eUdp3IXdzPXdCPNnWi8fW8rrVbrLvkjHEZQTDdKe?=
 =?us-ascii?Q?i63wqM4ba9jnVel8akTLziUvLaeWJeiFWlK/0UK21TiCwp2ZevJVFN6RETcG?=
 =?us-ascii?Q?FPbTgJjV/6SdOfgX1NNP97ouwqEZu3kzhgT9gsOoy70a3KGQu+7D/AdIlsaB?=
 =?us-ascii?Q?3nhtMXLi9+F+/6HL5TLjrjT1ZxJnyF6ppI1HabSDshPnHQ1qaKPPvH7hTirW?=
 =?us-ascii?Q?b9bs3QRoYQsPEPWkKtgopyquArqo+bfmVq8S+m+g4zkvzkZc7050i5027D5g?=
 =?us-ascii?Q?5bzVmOykKblhQRyWIAPOXOU9i+5YHpYnaDsG2kdoKbkFao5f1GWUsgqRwHuy?=
 =?us-ascii?Q?7VxO+lvio5vlVdcqEEkKTvRnlKvClbRgKB7OA/RJjlx1pLh7l7aWl7zRsSci?=
 =?us-ascii?Q?WzpKIFSc7Vo+mNnkuwoUbmv0nD0JLvTB7MvV7p7kFanWt4kbv02c98OIUbRz?=
 =?us-ascii?Q?xV4JPh761w+B45iq30xtCLFc9ohPfj7cpV+hsAaO2zap0kFvimVXCaeTU+06?=
 =?us-ascii?Q?uO4IjW51o7Fj65lB1kV0lp/ZcYDBGcVwJ9U2uxZB9D1Y7TYlru9EoN9Vzjcu?=
 =?us-ascii?Q?zkL06tMmL2sbUl/y7Jvn/MS4P+83g2Z6JVMw2t18gpImQpj52vH4yp1qe6BT?=
 =?us-ascii?Q?0CuofI5sFx/Tp/N2xHbRywRkoY1+a4bgytgUNFVpFuYyqM11ijbAhgd9Dx1n?=
 =?us-ascii?Q?VKvAF8rGaV7Ou+z9FqsX5RmK8loqKxXPF1+M79dqoDB9/w+nGtb8WZAZ1DEf?=
 =?us-ascii?Q?OGKCvSPPqAqQ7i6/CtcZzl+9XFNYFrEsQXuvXkNJdjW4Bf5GDdxyCXZTt6/q?=
 =?us-ascii?Q?/kkWShWJySHX2fFx6eI/kB54SvW5XL2kirDATAbTxnJvOWr7yB3txH6awVuX?=
 =?us-ascii?Q?IyT2Qt6SnUJwDKWwujb+88nvglgPnAuv7MOvvVx/kjey5zpRGcUAxkJX/yBe?=
 =?us-ascii?Q?gtWdqaQuI6IC+q5BEj9FXdRkqvU8rtmmO8MpjnAXPtZpsJItUbJvPqq9Njd0?=
 =?us-ascii?Q?oKerSJUuNfg40oLDJ9sIYb8vfpIOhoQ11+10UY5TD7ILso5KttizTU3NiIAm?=
 =?us-ascii?Q?ZYmJljCMs4xRv+TTfWY76FBHoX9pI2Dl0Q0K/dz/nKMAWVy6Hngq4U5LCGCC?=
 =?us-ascii?Q?UMF0YN6uv/1WYmI407Zst/1ktPoT/Ph6YjBO6Q1dNfeA0KP21sJCStOdYzyA?=
 =?us-ascii?Q?/jDpCruHeuGBGN2jwU5Al6rRGBYVCKLUi6IXylRGrjI7BuMEviF4hFuYBUt6?=
 =?us-ascii?Q?aLaeh6JCkDq9pehIqvqsCTmPixfE5ESu2Zffn9mEf4FdVAA2Jw4e1TMj7IUf?=
 =?us-ascii?Q?QH9oULC+x22ttW5I3Ehlrp7jFnCU+VnSG71XQQNDb9d1GDjyAVWx0qldCaOJ?=
 =?us-ascii?Q?rw4XykorEn+tfG7wDH0urEE+8U9ZAizii/kkCkJ03cte+e6ja8e5sqaIqwda?=
 =?us-ascii?Q?O8sm8JAXxaaRyGkikg9TMwYWPyPVTTO5FcoKSGJJJv4Z1LDQZTrABG/EPtRc?=
 =?us-ascii?Q?ZzS58zoMsMXZHKeaX7/X8WWNDcboTK4VykMopHpF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81d13ba-2890-4997-8d01-08db3cec92c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 13:31:37.6931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pjojLzTEivc6J3RdlWrgqcV8xkmbTjKEZr6eMmy5yvmeE35KHhCx13X/IcpIGJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 13, 2023 at 02:52:54AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 12, 2023 7:18 PM
> > 
> > On Wed, Apr 12, 2023 at 08:27:36AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Tuesday, April 11, 2023 10:31 PM
> > > >
> > > > On Thu, Mar 23, 2023 at 07:21:42AM +0000, Tian, Kevin wrote:
> > > >
> > > > > If no oversight then we can directly put the lock in
> > > > > iommufd_hw_pagetable_attach/detach() which can also simplify a bit
> > on
> > > > > its callers in device.c.
> > > >
> > > > So, I did this, and syzkaller explains why this can't be done:
> > > >
> > > > https://lore.kernel.org/r/0000000000006e66d605f83e09bc@google.com
> > > >
> > > > We can't allow the hwpt to be discovered by a parallel
> > > > iommufd_hw_pagetable_attach() until it is done being setup, otherwise
> > > > if we fail to set it up we can't destroy the hwpt.
> > > >
> > > > 	if (immediate_attach) {
> > > > 		rc = iommufd_hw_pagetable_attach(hwpt, idev);
> > > > 		if (rc)
> > > > 			goto out_abort;
> > > > 	}
> > > >
> > > > 	rc = iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain);
> > > > 	if (rc)
> > > > 		goto out_detach;
> > > > 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> > > > 	return hwpt;
> > > >
> > > > out_detach:
> > > > 	if (immediate_attach)
> > > > 		iommufd_hw_pagetable_detach(idev);
> > > > out_abort:
> > > > 	iommufd_object_abort_and_destroy(ictx, &hwpt->obj);
> > > >
> > > > As some other idev could be pointing at it too now.
> > >
> > > How could this happen before this object is finalized? iirc you pointed to
> > > me this fact in previous discussion.
> > 
> > It only is unavailable through the xarray, but we've added it to at
> > least one internal list on the group already, it is kind of sketchy to
> > work like this, it should all be atomic..
> > 
> 
> which internal list? group has a list for attached devices but regarding
> to hwpt it's stored in a single field igroup->hwpt.

It is added to 

	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);

Which can be observed from

	mutex_lock(&ioas->mutex);
	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
		if (!hwpt->auto_domain)
			continue;

		if (!iommufd_lock_obj(&hwpt->obj))
			continue;

If iommufd_lock_obj() has happened then
iommufd_object_abort_and_destroy() is in trouble.

Thus we need to hold the ioas->mutex right up until we know we can't
call iommufd_object_abort_and_destroy(), or lift out the hwpt list_add

This could maybe also be fixed by holding the destroy_rw_sem right up
until finalize. Though, I think I looked at this once and decided
against it for some reason..

> btw removing this lock in this file also makes it easier to support siov
> device which doesn't have group. We can have internal group attach
> and pasid attach wrappers within device.c and leave igroup->lock held
> in the group attach path.

Yeah, I expect this will need more work when we get to PASID support

Most likely the resolution will be something like PASID domains can't
be used as PF/VF domains because they don't have the right reserved
regions, so they shouldn't be in the hwpt_list at all, so we can use a
more relaxed locking.

Jason
