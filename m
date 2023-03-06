Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49886ACF13
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCFUWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFUWg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 15:22:36 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335124B820;
        Mon,  6 Mar 2023 12:22:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfCBZbCAgGBLTFkkWSTEw8RWvEgvSrKgTi4C1IGNd/FEmGP0Bt/UBc/eoswj/V+0Pzic0b4hRAkyBRM12sNCngCzhZvEDq+se0mvv14KyL7ZII0LXgfxeM3IItlDiyjtZ8X6YKtpxUthdlykSSsbGlA7hLKLFDrBGC7Gyqs4Y0diJSwQ/R02ww5Bsd0RnJf8AHdi5QVXH0hLWV3h8Vpq9GKBxWDE6ka+iHvb23qAFx0o0scnS9aNI7PoReS3j0vf8evJ7J5xYl6Nft0u1vydHYo9ASkpTWwWd+FqImE+zDj7ZneDsgKAJYjP2JYOX9u/C8oewNRxxvqzydQDjt//kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLy+JqZKKE/2JuXi0ZR1I9vif2lMkrtbVi3tAeEcUkc=;
 b=EAbTiGql73b5TWSokCa+1poypoc03n4vAfI7sWflHrV+rBocroO66uhSYNBBPoyLlKIWLf576XIZldgeTI5PnUk/PXkEVVSEls6yRa/A4zAzWKg59la10Xzft3J3Et+mMiqvpmK2PAiwKYTXyyfWBNmQ11m0yl6eLrQIzCmmpzD6MXg9FzdE84si2/lyuiP5oxU52YSdu8+yG6MlvDkBbIA42sQNSKffEOCs8zwogk3ml3a16RW9AuPIWBFkB6ftV9czFJv/eAyZ5qoml7aqmdSrop1ZhyVN5lgSX7YhQOtT2zeJ95RbhmfmqRIP5Wrhz1msXOqZALWI45MsLCSErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLy+JqZKKE/2JuXi0ZR1I9vif2lMkrtbVi3tAeEcUkc=;
 b=R5SkrP7856PP9zhKJBOSew7/cyr+S7rhlsX403qkcq1WpODXmAuRpi4GUlM21vmYBnEh8hqO91JWe3r6Qbw01+mS0Nxi8T/97BB08oTTaCosE3eEuvVS3EWZj6M+Ni8VZwklgcJ/Ace0cK99QP1pCz2qt0FIKGXTVeimi6zRuTLkBPnDlTiO9/y6/ynqIXNHREv5/gV86jV7Kfw87ISzV+VT76v450Jwa5FP7Aqv2SKhVa/IRu0ePJdz3W+4Qw9ExMwbSb8Z3Oc0kAJ8NX+NsNGHZdskH0tjgBkWDBrY6MVqO2iFRYEggk/FTjcFuAuG1hvvDEElYgW54RvjE7gU7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 20:22:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6156.027; Mon, 6 Mar 2023
 20:22:27 +0000
Date:   Mon, 6 Mar 2023 16:22:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 03/14] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZAZLgSxd4AuWJSI3@nvidia.com>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <3-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761557D23695475CCCF3B18CB29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 48487798-4fa8-43d0-12f8-08db1e8080f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wFzoFcTXVvDreQU68nBmWXKgC+dhK1VLJlXbSLFjLgujVefZUrnxjrzQ49Xv2bVNz3ZuhTBFwtn1NdKHUrzPVbusbEozeSrw+lASBWg5XHINvqkWNy9mxA9aq3T0RJJG+ilOBg1yDY50+vwVNdoVa0PjrBz9hgOpehcp8AYBnYHer9LYTI4QjT/IcoWFs6ID6fNQYhRZNUxLhJqKHH7ljEQG8gArnbR1rAwD4sCOyOi7ST6uI3/q7nntBqV9QF0rHKSueCTN08SIS4x+lLCNKdfscuwy4RICINs5vaysnbckbTN40gQqk7sACQ/nyawZ/RZmWyRoXf7oB9fWDoXKO1BU/ajozn8+hNttrmdb36QyzvJKQ36MRsA4OUMorxeqwd0LYq5kbpMnqpiGAiJP+VqwPM9pEmK32Jtzboyg8cK69BaAJ7ZjSe6e8+qIUyhJWvj6OXfhPCTjGa+TRMsBWoMgBhb8wcjhM7D6bsuTM+/kNJvt4rl64MuRGrMwaEr+1N5TkqngufduUZtyh1ELxCGdXIpPr3o+XTvdP1hDwVpVG14RjJaIixQuWqd9cIpbNPP/ElZtvRiFu22XucNVsKaJlv5rYf21vheYXYtMHHHyC7wzDitZBQOV0yhh8Bhj+u2aoKLo93ff45vZwqKebAaAkrWSsWzD8N+Mxi2mrnPh17J/Gvx/7Q7Wr2N8MDY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(6506007)(6512007)(26005)(6486002)(36756003)(83380400001)(86362001)(186003)(38100700002)(2616005)(66476007)(66556008)(41300700001)(66946007)(8676002)(4326008)(6916009)(2906002)(5660300002)(8936002)(478600001)(316002)(54906003)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3Dxch+EyqhLwlCyhmu7Qbm+ZiAWxygpsw08qw6dksgwOGaMbRnPFLGScFfL?=
 =?us-ascii?Q?CvEgXdHdmlFgWw+7pBzO4+WM/HPfFtDObm82VDHJV+1KUqjXeus5NzDkfqkn?=
 =?us-ascii?Q?BG1a+jDXJPtaOAR98qTEdz3xDX+81n8ko4XMQ3KqbpTjjsjKSaYT49fEZq1G?=
 =?us-ascii?Q?G6UjG7yuoM61Hh1w+TJzYcI540CvhCTsNE16bliT1wEsbk0Ce+nAtqA4KVUU?=
 =?us-ascii?Q?WaWa5H0nP7CJsxPrEVAGE0p4l1IxAibLk5nthpsuLTydkEIcFz843wTRMd4o?=
 =?us-ascii?Q?bXpZiI0qMWxu5F3RCe7zwbxg17B8zj9FA+G7s2OooWhCswoVcHxH2rVjaN1u?=
 =?us-ascii?Q?4SjeVwqVrz3H1aeTnnZ17NY7i1J44tFBK/q1V9fwRLLoGKNJDsYwf6IPI18j?=
 =?us-ascii?Q?cmB3nvC9uNx5rWsf06TRA4qcUmuleHU0mMCf4kyMHp9PF+wXY/J9nOor/rOq?=
 =?us-ascii?Q?iPrSU42xhMPprIp+ObmmP9+qxYN0yz7BISBJs/krx/jMuNcgvFC2/HZZK9mV?=
 =?us-ascii?Q?lwL6VAuTRYO6BDqZhDRV0Jf7Rx1MxURzXPdi4VTT7EB6egtFItw86Sy/09Zw?=
 =?us-ascii?Q?QtuR8wqnDT4hq0uJW6DaAzTpePoLUPHbLtuFzzWV1QxnUIfvNMkueBnAn7zM?=
 =?us-ascii?Q?H17cweB8ehJVHyylbkWxQGbu9xRk3dp8WafXjLY7ZT02oVQNfdgQ+KumtOB6?=
 =?us-ascii?Q?eu24X4EcpqJm2ReX/QSlenrsOiCjZDgE1ic/xze6Z3sWOJ5/TBnDRz3h0YMV?=
 =?us-ascii?Q?cZvP1TaKQQTaEetoBK2oqINebyD/rmz1byBA2lW53EZxo4ccd8GBAY+wYh2V?=
 =?us-ascii?Q?rqc8K04JwuQ9c5KkHpMHfqYNbyMVA8zhmYDb73haZhYLK3+A/VbQF6rOxwde?=
 =?us-ascii?Q?Rhrxtsix5o7whnbHfcyLp1RhZWy41SDT0fKzef1MtnCgOgCjWd3j1764Wmxt?=
 =?us-ascii?Q?wbXJ45m1k6ZPZEkyC9ljaVAXZGR+sGJ/alKu0gcoD2PshHbGJpxUPzPtRwp1?=
 =?us-ascii?Q?q56p1Z9x0TbYQ+2Ix5ZPyXUUpLDkHCTYAOBne2hDGnqY2WRWlW6VPPHUf033?=
 =?us-ascii?Q?U8DyzgkLxSVth7CadjTxkmUa0lpyh4HOWfKb8i0rHIGgMKArEVOIz619jy8u?=
 =?us-ascii?Q?8sGooKulI5eYPwk/5qmlW7dnaidLs6L+EPk5LBgd00ch+kjMy3ltbr7h1+jK?=
 =?us-ascii?Q?RRFZIu0cIwgei+vsZ1qraIIF7HhgB+loBD32RB4PLP+InaB5ol79KcHHHNnf?=
 =?us-ascii?Q?1gfhKCXKZHIAfKSHLTLUkwCod6EP5vv3llfDD94LXsFdZnjp+N+DOUaKISV7?=
 =?us-ascii?Q?3oVldPJK9bbS+tNu/+KZuqM7QunM6CiJupFdpvNi/QoQYputdPsskp1Lm9R1?=
 =?us-ascii?Q?P8YuAno9li6HVFkgAEWcyoRYuduS2Kjtl8gyGH7SFNoHqO0RfWixnueBEJZ1?=
 =?us-ascii?Q?pNFT+f7SD+sUqVQ0NAVQNnxgomm1bIv7fEgH3keM500I8JcYboseXkH/krFr?=
 =?us-ascii?Q?w+Ez3/YlKpkz3o6luHmPz4hSLC3gKxmCMPF+VOAR2egblHuPltxSKDPPK2IL?=
 =?us-ascii?Q?ML1sy5zUfRpbkaRnC9oy3bHDbAh3sbyMJQgOxaVk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48487798-4fa8-43d0-12f8-08db1e8080f6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 20:22:27.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbSvskmp25hVu2OHROCHvWGQg8xlHhVvZlblIU6l2HoLVsLZKKBvcVqvFZTdP6nD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 02, 2023 at 08:01:00AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, February 25, 2023 8:28 AM
> > 
> > +struct iommufd_hw_pagetable *
> > +iommufd_hw_pagetable_detach(struct iommufd_device *idev)
> >  {
> > -	if (!iommufd_hw_pagetable_has_group(hwpt, idev->igroup))
> > +	struct iommufd_hw_pagetable *hwpt = idev->igroup->hwpt;
> > +
> > +	lockdep_assert_held(&idev->igroup->lock);
> > +
> > +	idev->igroup->devices--;
> > +	if (!idev->igroup->devices) {
> >  		iommu_detach_group(hwpt->domain, idev->igroup->group);
> > +		idev->igroup->hwpt = NULL;
> 
> hwpt->obj.users should be decremented here instead of leaving it
> in iommufd_device_detach().

It is like this because eventually we can't call
iommufd_object_destroy_user() while holding the locks.

So the lowest function returns the hwpt up the call chain and once
everything is unlocked then it calls iommufd_hw_pagetable_put()

> >  void iommufd_device_detach(struct iommufd_device *idev)
> >  {
> > -	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> > +	struct iommufd_hw_pagetable *hwpt;
> > 
> > -	mutex_lock(&hwpt->devices_lock);
> > -	list_del(&idev->devices_item);
> > -	idev->hwpt = NULL;
> > -	iommufd_hw_pagetable_detach(hwpt, idev);
> > -	mutex_unlock(&hwpt->devices_lock);
> > +	mutex_lock(&idev->igroup->lock);
> > +	hwpt = iommufd_hw_pagetable_detach(idev);
> 
> the only parameter is idev while the name is called hw_pagetable_xxx.
>
> is it cleaner to get hwpt here and then pass into the detach function?

Not really, the function needs three members of the idev to work.

The pair'd attach function is:

int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
				struct iommufd_device *idev)

So I think it would be very unclear to change the name, and this is
more a hw_pagetable operation than a device operation.

Jason
