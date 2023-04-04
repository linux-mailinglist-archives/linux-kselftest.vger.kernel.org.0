Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303B46D5C17
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjDDJl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Apr 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjDDJl4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Apr 2023 05:41:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497819BC
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Apr 2023 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680601315; x=1712137315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UGYqSUsAGw239ZziuvrpQAgbKbDQIo9P8Qh8IS5ZGPQ=;
  b=BzCkPe3JB7mvsOm2fDuoaCoWIivR9NmUHVK2w83nmb3edKmY7E2v33Qy
   0F0Y5kPoko3uZTsdqCCa8Jq7XF8wvRJgYnCMRSxWpyNeirJOPpXtu6foY
   G8enaXlkcGtXd9FZzyxEYWnqUx91T48neHv22HQ+kpznZWeaLS2OjffAz
   wsBP29VYeWZHRZSG/4rI6bXvJMBobfKc7NDScf5t0ZgViaDWU4MUvB+Wj
   in8ySxT5UvIErX++nNO5V6aJsvebx45AxDg3i4KoopxVOqTyVgj7CrIju
   Vq4jBnOWhGNDPLqi1XgzFU8cKdUJiCW7Q8jFSgQSzkgPVFZngWTsCVu2l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404899731"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="404899731"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 02:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="663520155"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="663520155"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2023 02:41:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 02:41:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 02:41:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 4 Apr 2023 02:41:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGS5DCZlQoI3MZCYKdQmfsQVk7p4AGqdJFtmsOh4TZ+aAwzA4VayTXAJ5l/uq+JV8XmuKiaZuf0ie3ZZ6eEMZaCHBnYDxn1iMcOp1e2WBW1wNXypyUFNldMuRecoBPbFShSTUGR32KOZQGyMWUh91mOZx+p902T+lz61Py/aJJaQO77e8zd0+9kCetTmsdHVK9ij4PolsilnFj2cY3uOVvWYFziQ0pnyl360mX2Q311FzT4PueTbKkJgqs4IKiJ33EZlIthcUyPENtTIRnOYu1v1126+cF8r5niwU0W0bBL0lR+5Q72jHCdcrEWHslhRw0IUuhb8bWoN3bRY5jgHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVpWaQrBAU6Tc75xQ6IA8Mf0JGBLRQYScDgigDxkptw=;
 b=L8IpsSCZJonF3ZZY7Psf1+BgXXmzdwFLUMKwLb4J7jRGNAzm4txm6eAdDys3N6309Ld9gwqKnTJ9YhugpzwfrNxRR+UCmCD1cCHkwTVOT0617sPcjsKmH30L1ODCLUwzsK022hRXp8gFShHb18LeoX4cec/2fe17/RqA97/Lq63rb4nctLi0HfuS0dzTuaNKWjff8szANKnmUBGMRc/D/vjiGwvGgpVZvyyYSQb5L2Q3V9EoqRz6a19xNsJHOEJ1UhHLhTtTnM1RiyQilYGjzrLNw1Hjm+h/iQrdfJacrsFgcCRtOi8ICyRRQysFVFMyf8ekpCm/wh0PuMh7pEhl0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 09:41:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%8]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 09:41:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/4] iommufd: Check for uptr overflow
Thread-Topic: [PATCH 1/4] iommufd: Check for uptr overflow
Thread-Index: AQHZY+YLmsE8VdvUr0CE7yE45wWBb68a62Vw
Date:   Tue, 4 Apr 2023 09:41:51 +0000
Message-ID: <BN9PR11MB5276ECCBC22D396D142AC7968C939@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
 <1-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
In-Reply-To: <1-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5830:EE_
x-ms-office365-filtering-correlation-id: e50c459b-2921-467b-1bbc-08db34f0d1d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GaR0uPnwB2DHblvZrz+FkQbPm+sxGQGZ1y69nPDT0HuqBOgCfk894x22j/ElvdAtk3ziJOR2hWTGTCwRGFoNB+1RO56Cy0FMEfsJOrWBKqCo1bGClWwmMt9880VoDnPfcncUxrbbNIrVOHO0WIIwm425J7XIH/y7EP0CEss6hiv1LYdR2zes1MI7e5EhnjMxq3XJuY/FeEGyo9M4op/U/euXfxlWze00wJWfCay3dXgQ17J1+8y5vulfBpdr6covOtipnRxvGVPE1aaez1ls2oEy2tRWMY19kEp3HaT7Q71nyODJs+0o13erLtmyRCTmhzgtboerjq+7BRhgW30CrWRfSg9DoibBGg+nkoz1X4OXY07KUIemHsISrpSa1UtdouqfpBZmsgjfY5mYl9i0fgL/8s5UDd9Xr8j6WYEsTr9hxWC48v/YlyOA5c74wfYZ7XHJPv7Nfn2CuRLE8nKYBGHuBkUf+LWcXoX1oIGq+jqAPA7XYjsxWnGntl8PvqHU8Fwr2dxWKCP4ZiZuViqJ+0qb+Bo1xwH97AqT29LAa1uOS09WYoaC2npZ7f0Wvir/m8lzWMY3yq49/eGdcoa2v4ub3/TU+h9nIFEsuMFy5xk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(83380400001)(33656002)(38070700005)(26005)(107886003)(6506007)(55016003)(38100700002)(186003)(76116006)(66946007)(122000001)(9686003)(82960400001)(86362001)(41300700001)(52536014)(5660300002)(71200400001)(8676002)(7696005)(478600001)(45080400002)(966005)(66476007)(66446008)(64756008)(66556008)(8936002)(4326008)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5iTpYhpsaVHfiTllQiqwTMES+NcTMPQobMaVbeqEB0zvafozqsTmq3E1vEsg?=
 =?us-ascii?Q?i50oAuRwcfI/ysdPvMmJup+++FXW0n/ESlAFtirsfOzi+KpcyN/J6NBIwoZB?=
 =?us-ascii?Q?2iJqGD/sn1UzdrRubtu6Ae4+Ea3dsHKTH1FED3auJDMqvo511czLCQBmFD3P?=
 =?us-ascii?Q?mxVM4qJLrBZ2v5PS7yvjS9TF08eG+AsYIjXA9GsPuLfvvmpRsEAOFCvVcEHM?=
 =?us-ascii?Q?PHhOZ3MWKdYF41DnqviWxlnoZG6Dq2/oeXQ4S55NT//6diJr/H18tUBXlAHQ?=
 =?us-ascii?Q?92aku4FE8vq01SJgcheagnMvPuoNLGQFn+HzocxB1i2nJENveP2KN0fj/hc0?=
 =?us-ascii?Q?4sJKNe8e7qIhEUucgkfaTB+zTD+RjhV0+hD1bJFJFZiHM3RzNUVy/U8JRyGN?=
 =?us-ascii?Q?MWCUf7mmwI5zOZ6Vje7cWedCfBrN3rnte8mDYl0QoN3mIdssAzclk18pgu3/?=
 =?us-ascii?Q?XM9hpbGu/nBkPnDPy6xqcWuTvKO8v9sDoRLQfYnxY2VJuwbIGOYtihngcUzw?=
 =?us-ascii?Q?Eri2H1vjGmpxZr+ze9ov3dP0rCe59V/9jrZv0yK9ZnA76u7wnhR6nEGWGJk1?=
 =?us-ascii?Q?wK7IIT27p2GcxJ3U1quZIl9YXBEgHqNHPV88q3AXmYQnLgpp5JWqoMlJW5yi?=
 =?us-ascii?Q?AKsd3lJyAQTMOHTpJJY3MvQ+YrZeMJNd7TpFgQtmD9avVpcBzFkMeNWbJUKY?=
 =?us-ascii?Q?9tSJ4QdheNB6iDzP/3b0sCuQjfrpW9G8/GF92IGtvz+38wJGQLK34q5D9/Fl?=
 =?us-ascii?Q?Nmg5s7z6kHZk9i81yQS+cA7gqhsheGYea684249K9BXQQrW3yVWvFaSkpv97?=
 =?us-ascii?Q?MVD6PK/VfrDVnkAJp/nISpXfiHrEP+84W4J+7EOtM6SPT1M2NiEAWAFWBs1A?=
 =?us-ascii?Q?uw3MoUSNy9ZT8b5FQBNFej80cH3rAnyDSxT5Orrln08WFnFlVXXyAdrkmHps?=
 =?us-ascii?Q?jser7tt6NdbsChXqBGkeop3ZijuLIYNFZiOr8uIx1w0BosilJLogXMrbH2Ie?=
 =?us-ascii?Q?jVlTJIYGxKzMY+418k0KIBGuINbI2KbFP1jBnfHFbcdeYxVusPM7KZZ5j/2+?=
 =?us-ascii?Q?TF9bpIHWkveirATg4AwdCIgC3b1PBIijXk2cb1UAs4mFmxD248Dy/DbMHLRU?=
 =?us-ascii?Q?DWcocUFwdDRlO1RdG1UFM1hdZXtD2kvhUjohHx5E39+tvUmE1qzOYYdKGXTG?=
 =?us-ascii?Q?kdJzNCbHBXziXjil9uBOx5ExJlOARzDRcQ7dz0HRLl0o0LvvijFBb3s8xNZ/?=
 =?us-ascii?Q?HyYverqNBFzCyjmCy3B8AoiUfKyKWTWrRyAtpYzbivNKJslxB6eSq0/jfUnx?=
 =?us-ascii?Q?1MSM4LUiRr1H4FgXvOrSsg1dTuqluhm6LGoKPz15Io1QzZecnuoYoVIpz4+G?=
 =?us-ascii?Q?a0OOCEwiqK1FGahYmK2Jq5U9Njj7L++NnRafIxfvwLVGXsbpacYIgnJvFzH0?=
 =?us-ascii?Q?Sktnx/uUWKh4lPnJI+kB9n4SJIF7/LIlEiDl9JDVKdO5uIY9FDk2WmvePZBG?=
 =?us-ascii?Q?0WuFNPXeQch4Z21zUVyXjCV6dxPBiHHru1+xJ9CzGtnE0NscYOOvh75I8zrE?=
 =?us-ascii?Q?8aDUKcxqXi3Jr7cSI8b1k/TalKV46+uOQM4WRgKf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c459b-2921-467b-1bbc-08db34f0d1d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 09:41:51.9657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KulCFaC7fMOGR0L5ZqBwRD9VGJJCD/u/QlTckYdhpapdn8zY+Qsc4OZETNjIdqVFvh2fZ2CdlSelKwYSKrjDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5830
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, March 31, 2023 11:32 PM
>=20
> syzkaller found that setting up a map with a user VA that wraps past zero
> can trigger WARN_ONs, particularly from pin_user_pages weirdly returning =
0
> due to invalid arguments.
>=20
> Prevent creating a pages with a uptr and size that would math overflow.
>=20
>   WARNING: CPU: 0 PID: 518 at drivers/iommu/iommufd/pages.c:793
> pfn_reader_user_pin+0x2e6/0x390
>   Modules linked in:
>   CPU: 0 PID: 518 Comm: repro Not tainted 6.3.0-rc2-eeac8ede1755+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-=
0-
> gd239552ce722-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:pfn_reader_user_pin+0x2e6/0x390
>   Code: b1 11 e9 25 fe ff ff e8 28 e4 0f ff 31 ff 48 89 de e8 2e e6 0f ff=
 48 85 db
> 74 0a e8 14 e4 0f ff e9 4d ff ff ff e8 0a e4 0f ff <0f> 0b bb f2 ff ff ff=
 e9 3c ff ff ff
> e8 f9 e3 0f ff ba 01 00 00 00
>   RSP: 0018:ffffc90000f9fa30 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff821e2b72
>   RDX: 0000000000000000 RSI: ffff888014184680 RDI: 0000000000000002
>   RBP: ffffc90000f9fa78 R08: 00000000000000ff R09: 0000000079de6f4e
>   R10: ffffc90000f9f790 R11: ffff888014185418 R12: ffffc90000f9fc60
>   R13: 0000000000000002 R14: ffff888007879800 R15: 0000000000000000
>   FS:  00007f4227555740(0000) GS:ffff88807dc00000(0000)
> knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000020000043 CR3: 000000000e748005 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    pfn_reader_next+0x14a/0x7b0
>    ? interval_tree_double_span_iter_update+0x11a/0x140
>    pfn_reader_first+0x140/0x1b0
>    iopt_pages_rw_slow+0x71/0x280
>    ? __this_cpu_preempt_check+0x20/0x30
>    iopt_pages_rw_access+0x2b2/0x5b0
>    iommufd_access_rw+0x19f/0x2f0
>    iommufd_test+0xd11/0x16f0
>    ? write_comp_data+0x2f/0x90
>    iommufd_fops_ioctl+0x206/0x330
>    __x64_sys_ioctl+0x10e/0x160
>    ? __pfx_iommufd_fops_ioctl+0x10/0x10
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x72/0xdc
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZA/O6vGUfni158oK@xpf.sh.intel.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
