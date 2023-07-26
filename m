Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558467642A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 01:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGZXgi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 19:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGZXgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 19:36:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28A2704;
        Wed, 26 Jul 2023 16:36:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MseCSPCwLdR4x5RGvqsg5bpceB1SaY45aHNRy0d6MCQbZReNLuW/wOjkbzBC3TqtXMTXYOOLBr9my2iX0FqQzd9LDenlncXH0qJEy8wYRE953G8cuM0dliBrsArv8C9nrbMnDafXmTTJ1jsBXGCo3D0llbTTnQJil7y2kDHsvd8E8Cc9kaGksT9QWvg1WB/Fz0wW2bFuQwRMs7CGvOmHGTxy0OPenxf7d3i0rg6BhYNMlkOgphRPSd8YvkyKzFDVgHVTgnX2gP7t5Giy512IEWGIgtHA3iYZQJzwSW7Osv4JvIqHBg4dmrCpICyLPi9j+L4RyqNasDfbVH14egh9jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q123L5DRk9AV6doEXSYTbJiKI8xth446L65K48JaDjU=;
 b=i2R2S3BdlXCses4b6bN9myJJt+h7toATokRlow8qD9NEh/VvE7wonHk1msbX4AcaAVCZcGA7WyikhFjyx8c00DMLZKzDREVPeKFVIH50yilLbebo9aszjt6/2Xquiq7X6BRDczFGlUUi5ZTa0lsYtmOMeRUAkLK5Z2utyTKlwAdBemX15yrcn1R8LiFedNJ0uvrmRZmz/gltbU5Od0hxMsjku2ayg6KL8Jj4Rzvz1lZlVqaRd6FWcB12RxvN5+l+NTLzSO8ycXB1dtMbWw5uMtd6nQ++MV87gCwjrqSZ+H1RUuXuvsZ7vcIjKCUmgKeNMStJUKb2qjD1Sn6Stlsh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q123L5DRk9AV6doEXSYTbJiKI8xth446L65K48JaDjU=;
 b=VDt85/3hQ3KMj6eg/vOnQEOhnGp8j1+vt7i96Y29TAFaZK1CGQo3uRWpdcKZ6C8eV6Ns+A14ZDCozbipZ1Fh6EI0PlpgfTmHQ8vH2zrhbhZObahFV6bQ/G/55RcWq4+e9ZYy1bTfzGSUrsJGrfBuD/blVNciQAZ01eEzK+9imvPnUWrJS5bHJ3aq72g46aSRy7NG6jxes6EgYPR3X6GZ8SQMO9L6zokVDlheTKD6+gptcw+iy5dihCpO2DyWpulHBNbcrHxllkCxGW01+QArMTGQinknsTGegnYXoz+G1jPRxIUXTYx8/Ea8sK+LYuprHmp3tVt/7HgZ77IeZwGxxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 23:36:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 23:36:33 +0000
Date:   Wed, 26 Jul 2023 20:36:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMGt/4CCCmUB85HX@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0364.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 169aab3d-d585-4343-96a8-08db8e312518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zm/yBTzvB12YiPtjwvOZTS4Nmzauvwzr42+0GB19C1dGHQOinzjsW4HPCGtHA7qThRohG4NKqdP+6FIaKglfTR4NtzeJdYp6yt0MXidoaTnLukJA70YYDTc/m4OFhR2Lg/NrOQfEVgdoF1RdmmuTtLbb4jGUeSixCEV54XE8LuT90ChtF+jl5jjW6fQ55OZyAGAVqqW0irT5KNhEKqLH6yFYELuvauxIttcQNYyPxvU7PCawXi80gWdqVktcMocLk8HeHBZfNF9K9Ccijjh7j/NKXIaZtM1CCs2FNIrYZ1Ww68LysbuIdA5t4tDX7aonV8IUbMDgkvP07oKCWXoJ8qbcjGgFGDC3rb/HgFUcfRm20gOL2ALnBE4lxsSysnbsCYAMeYAfGHB262/t/zCOiZfF3VfG3hn1e2U6LEvYGOYhmKW5SUFnNPzgecsuF2b/GtIe+FfNVoq2XkQ8khjzytfX5NhBK42BTFgemqg/Uu/RaJJOGPdQXbWbGJxcfi6vbfkyCfA8KtnJFo2NTa3wuZT4X1z0+3oUQ8kPzee4eXX640GUNNHqg97E7OFAmk+V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(26005)(6862004)(6506007)(2906002)(186003)(6636002)(38100700002)(316002)(83380400001)(41300700001)(66556008)(5660300002)(2616005)(66946007)(66476007)(8676002)(7416002)(36756003)(8936002)(86362001)(37006003)(6486002)(6512007)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BysifGco2RxAHbSpoCMQ7s1xODQhAc4TDgiigqwIR6PvwJfB/NmuOZJ6tmOP?=
 =?us-ascii?Q?y6h3G4M/+MAgDD7SICf5Pxz5wfISy6HZQ4xgi26ZIZi8ErVvzZ0CjzT7dFJ8?=
 =?us-ascii?Q?a1bEKTKhTyMRNnqMdMLcyF2GicX64cn+wuzbquYNw46x9WCpOOUeO46Ut50W?=
 =?us-ascii?Q?rcHgPUI0vrVIylDdm/Tb7vA3REUbGypVAKixhGRlNKjLt4Ek5cEPrbKKuFJW?=
 =?us-ascii?Q?rtjF5pKUVg05sn0eH/jsBxxEbbJU9IkBthmrhbWbWMa/pbGNOSXAhesEBtC1?=
 =?us-ascii?Q?bzIXe5/o4lZ78iGXv/O/Ky6wj25THAh+cSQhtwicCuzpya3B0QVvunGNrmK4?=
 =?us-ascii?Q?/eQPTvXH90DvOKCT2f9Xabi2srTWt+XXrFfmDjlT5SYkzorqsoaa3CKJdq2o?=
 =?us-ascii?Q?yQD/1TnopvY3xwMbf/4nXV4jC6NnxVizZOyXyb/KzP0neKf/hCs07PLil/0l?=
 =?us-ascii?Q?grTzHYfaL1JjX7oTjSY/Og8YObrU/UFmh7kpjLtKa7RFrDkwEuJ5gjiV1Z6t?=
 =?us-ascii?Q?mrHPKMwkoGEZ2hMUfpOLVj93SNSWrxZbje2nWuUlKO/G1IIVjg1Rkd2IynxP?=
 =?us-ascii?Q?Ra3LmfxcsO3okrcLyoTueFxi6Pb932nYzluvILyx8H/sGz6VUXUIaFNWZ+yE?=
 =?us-ascii?Q?Naw+TSgBMAFax0ffFCZ+pSQDmJ9hzRKwx0LJOe3Q/WpQNH7BP83HhGYp5GPY?=
 =?us-ascii?Q?Oc1SyFkQC1J+U9Wav61l3wP75e4KDzo6wLFDC1p/1Hqliyb7SvSQE1/acxIU?=
 =?us-ascii?Q?eN895JlbBrwjqjm+F4EW6uUdKcyibmj0HoZuINBoi1tHeRTa6UZ5Y1Hg+9x8?=
 =?us-ascii?Q?cQJbd9QmkPuM+EQImHMLFwn95IbO9I/VaFMHgnHY2qeoJxf71FNuUlm0lZ4U?=
 =?us-ascii?Q?qDPAN3z4dpl0EisHStcPwQIxw8Z9Gia2Sim/9DTD8Yu6WlZzi5p88isp7lyb?=
 =?us-ascii?Q?LGUvb5Fftyenuh7B1nyNkn41LDu6QcvewANRqR8A8aT8vbWmLZPx4DEPFO4N?=
 =?us-ascii?Q?p71z4/G0QKB8VStxT0FrIcRVaQj3JILGqMRVCnI93jmu3tIv/xNVo5xpsWWu?=
 =?us-ascii?Q?5mCy4vDphQLf1BkYcSyBXxqBpDkJP0NqGRFJkAOIy7fh29UtQbB+wCvdnFwz?=
 =?us-ascii?Q?V3k2iVd49ElsWgNcJFhnvLXUSY9Kg18XMccd5luyjDhb9RTB0Y2enAJHzHk+?=
 =?us-ascii?Q?L7pmv/47p1J0AwDXCqZQXjVQmC4Txz1QWiGXY2Y5u7lkA+jtw+1S7dz0SHn5?=
 =?us-ascii?Q?8jCFSBleYR6epImoGVzpQAgPrzLr4xWoFpijVwbYd7lxUsUWvXBPttf7CrsF?=
 =?us-ascii?Q?8f0PDkmz+RBAwD381fSKst9JnkK6JJCXvK3wuaLpcT4fhtZewmp+mZawCaBh?=
 =?us-ascii?Q?2ifQyRrX/nsUJcHIJRCRbfjwTgwYQf0S5dkD2LIRkhPsk4NQmfewqSJZiNp/?=
 =?us-ascii?Q?WYp0/I1r1gud7ASlEOG/cHEPmE81M+O9YU4kW0MmmDe6VTkg8M8BziN2n7o8?=
 =?us-ascii?Q?ratCKKyL3gECDXzppLzbKRTAg2Zn4H75hh8MsgOMcW6Xm9UiM3P5fLwRiQ50?=
 =?us-ascii?Q?eR8XkmWCjQqCaJ3iQ+gJVjiPksZmiIAyUgjzA3Ct?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169aab3d-d585-4343-96a8-08db8e312518
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 23:36:33.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOWdYIb6SWsHhBmI09/pQbhirp/RNOhtdpRJL+nJNxBK16mNusBuTIPYO4Ipi1El
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

On Wed, Jul 26, 2023 at 01:50:28PM -0700, Nicolin Chen wrote:
> 
> > >  	rc = iopt_add_access(&new_ioas->iopt, access);
> > >  	if (rc) {
> > > -		mutex_unlock(&access->ioas_lock);
> > >  		iommufd_put_object(&new_ioas->obj);
> > > +		if (cur_ioas)
> > > +			WARN_ON(iommufd_access_change_pt(access,
> > > +							 cur_ioas->obj.id));
> > 
> > We've already dropped our ref to cur_ioas, so this is also racy with
> > destroy.
> 
> Would it be better by calling iommufd_access_detach() that holds
> the same mutex in the iommufd_access_destroy_object()? We could
> also unwrap the detach and delay the refcount_dec, as you did in
> your attaching patch.

It is better just to integrate it with this algorithm so we don't have
the refcounting issues, like I did


> 
> > This is what I came up with:
> > 
> > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > index 57c0e81f5073b2..e55d6e902edb98 100644
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -758,64 +758,101 @@ void iommufd_access_destroy(struct iommufd_access *access)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
> >  
> > -void iommufd_access_detach(struct iommufd_access *access)
> > +static int iommufd_access_change_ioas(struct iommufd_access *access,
> > +				      struct iommufd_ioas *new_ioas)
> >  {
> >  	struct iommufd_ioas *cur_ioas = access->ioas;
> > +	int rc;
> > +
> > +	lockdep_assert_held(&access->ioas_lock);
> > +
> > +	/* We are racing with a concurrent detach, bail */
> > +	if (access->ioas_unpin)
> > +		return -EBUSY;
> 
> I think this should check access->ioas too? I mean:

> 
> +	/* We are racing with a concurrent detach, bail */
> +	if (!access->ioas && access->ioas_unpin)
> +		return -EBUSY;

Oh, yes, that should basically be 'cur_ioas != access->ioas_unpin' -
ie any difference means we are racing with the unmap call.

> > +	if (new_ioas) {
> > +		rc = iopt_add_access(&new_ioas->iopt, access);
> > +		if (rc) {
> > +			iommufd_put_object(&new_ioas->obj);
> > +			access->ioas = cur_ioas;
> > +			return rc;
> > +		}
> > +		iommufd_ref_to_users(&new_ioas->obj);
> > +	}
> > +
> > +	access->ioas = new_ioas;
> > +	access->ioas_unpin = new_ioas;
> >  	iopt_remove_access(&cur_ioas->iopt, access);
> 
> There was a bug in my earlier version, having the same flow by
> calling iopt_add_access() prior to iopt_remove_access(). But,
> doing that would override the access->iopt_access_list_id and
> it would then get unset by the following iopt_remove_access().

Ah, I was wondering about that order but didn't check it.

Maybe we just need to pass the ID into iopt_remove_access and keep the
right version on the stack.

> So, I came up with this version calling an iopt_remove_access()
> prior to iopt_add_access(), which requires an add-back the old
> ioas upon an failure at iopt_add_access(new_ioas).

That is also sort of reasonable if the refcounting is organized like
this does.

Jason
