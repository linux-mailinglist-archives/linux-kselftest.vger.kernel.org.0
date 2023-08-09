Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF577550A
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 10:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjHIIWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 04:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIIWu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 04:22:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF9C10FF;
        Wed,  9 Aug 2023 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691569369; x=1723105369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ApdUsSla55pq0y97aOtRNU4SJoaJnnXu8aIoWoT1t8o=;
  b=i4TvXLc7msVl8ErvlO3H8hfYZ5RmPMnooZ1KO5xpIIicdN/BquMZnOxh
   gt9hBM6fJ/Bu60QcLSXTn8yUZbofK2ufkRQGnDuIf/H8S1GITXHoVKjH2
   V/6HBEyDjjYuFVkcUhEwxYry2FtWftvjvDTLLL1cmXh90wVfSwiRWRUOI
   gbUImUjRgaiTTaAQDKYePxNjdKbH4XxZaxi+yamybfBhYdNoqZl7F3CcY
   5+ymd1JU5RYDUHXsZCtK6eo54p3EZcA2mABLZ34zSQ3fxO1GTWVaO9cWF
   pjS7wsu4WeOF0dlqnoea7CFLdv6O5Kx4rzv+T01CBxna8wmKkx28iX7fE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373843948"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="373843948"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 01:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821755201"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="821755201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Aug 2023 01:22:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:22:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 01:22:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 01:22:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 01:22:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXsA98vVD0UXfUgCNvIQrkVyfe+PoGmPy928qrNDQpMUEpmFXifLbL9idJIqHLErgHH0uFdG942PyeCox0zjwaVvjRBHVkr+PemghLAE7CJliZuZekrTWemA09mqIsbu7WfjspVjDSXyZL6gLAb7DsTKs76tpYa9udy3nimLwzE2jmIHzDClHH3iE4q4lAb+t01LOAauTOZ9E3Llb/DzrGzXk9+VM7+UKG3zJXXfFhgy4nUEg1mSSislpKyj2nA1MeYbZqcD5KdsGn90mMyZM57ziw4cvDiNKUO1+E1+2Nsz1Zu30K/PLPuRd03bl8122/jthXboFIC3tADqgyR6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGcti2n0tiflZ4bi23PbqL2Yfwq/1CZkebsDzZ5L78o=;
 b=Kwla6MMLf6s/HDla/98etFGGr4NfA/fGUTRMkNU+f6BysPkepzso6IJ5V+Y7+nNQTnh07ZRRX00yGvuZ/upAo+nlVGoYhTL7AWFgINrZPhbJrs0r/5lv+Pd+BADiCXLM6oo+1Foadf+NbOJQjribQzmPoVOj4YbHw+r9mx5xSjlRugWTO1Ng21UK6q9xSNwGuIZuVX7pBAaXZ5TGTLVqxWASMdkcpufE7QIj2YHf4e0yCf4bzMmGIF60yNZWSl8prB5LpaouOLuAGPjU759B+B6d9EcJjnqGKW2occhaGqksQ9imC5ISwBb6fVoaWfzCR1n8ViQDY3IIA9pJS9chPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 08:22:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 08:22:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHZvh/uFyWMLiVXhUCSOYKFk2h4da/WraUQgAhYJoCAAMpSgIAAnN2AgABV8ACAAPMnQA==
Date:   Wed, 9 Aug 2023 08:22:44 +0000
Message-ID: <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia> <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
In-Reply-To: <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: 05943f91-62d9-40b1-3ef3-08db98b1ce90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mEfDljgXyBdDX4tWtQpNkZHShYXzgt2Nx65UAVdiM6k/yqhlNYfECtQDyJ8n74n93Rn2IbALrXXLAHV877ztJxzkY/Fgw8CiueLiE0SxC2YCzY+4VCbUvsabXTZdxxdhIq6zo6LGGkV0JLoMAkOS+lUT2C3vzXgg09n4Z/yfG95pM9Xb6gWTgN9c6YnizK0CVQCmy/92k0vgcrA0sfAUPoLKwK78rNNFV8iITzNU6dKuTgoQXjj0nsX9pGKaxUjZcvOl2LGwn/1oLS2C/iHK84LboExbz1Pdvixs3KmAe3JzjBorYWQAzXPWRJENOVEc7PMVJXTFKv6/z0RB2PhzY1n6NSVxB3hbhlzLdOMAoj0tgiPHBcCf65xAjmDJbR3mn/mDnIuKRRFUv3Zc9t8oPF+fwhVqmGTcMREGvouwa9KD/coobTWLUq2T+rQNXKTVRjd3/vFCdA3xtKzX5ykA7jcvEZqoD4+zF5p2DupD2A9nKWf6vfvIyC+FtZfstvXrbdQLfQAHJhhaZifZgIggBwAMD8umKYlRcW4IKtx46a0IiJXG9rQa1YnsM4czG/Y+VMgpa59jK98p96VFTzWxRyW4DZVaAQ4ny60HoHR/sGDkGGJYbce/Fv3Ev1G5+2R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(1800799006)(186006)(38070700005)(66476007)(4326008)(83380400001)(316002)(55016003)(64756008)(66946007)(76116006)(66556008)(66446008)(41300700001)(5660300002)(33656002)(8676002)(26005)(52536014)(7696005)(7416002)(38100700002)(71200400001)(9686003)(110136005)(54906003)(478600001)(86362001)(6506007)(8936002)(122000001)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a0jVKhQIjm3bYA0qIs1WAp6MfgdN58mubzoBWMaFpZO6McjQ37vurg99w597?=
 =?us-ascii?Q?NQHF7c0vK0twP8dftRVXBfJBC/tvHGVcW3wi+wvQX+Hcgr5k5PrKw+q1b5Gr?=
 =?us-ascii?Q?kxIc8jsWrJNzzXfGaE3uSp98LCAgOGtpxfsHB6j6gCjxOZ8YkKOWr6/+OzOV?=
 =?us-ascii?Q?plfOyCjqumD9Xh8WuCtE6SVQAy9TrdU2kfQ43NuWSD+ZtXbfcbklYSsm43JV?=
 =?us-ascii?Q?ETkgW/sNMWz9uND9uvkJKAKb6tQLLW75uNNDvqBd9FNZ9QRCLqwkTv+h/CrN?=
 =?us-ascii?Q?xa/i6rWNHuTYhutk2U0Q/NyW4uh2Lmm6tmk8ljt8KlrwJ9Es4SIU5sAcdJJf?=
 =?us-ascii?Q?QWjZCQOSu39ECUHPzIdDRT2nPPMnx/aJru/q79TX4zbiCOvzbwHob9t1l2fv?=
 =?us-ascii?Q?EJlBmoPQCHDFJU6iaD7gvaaxtfjU2+2p944HiZRHBwyEgZEVRtUdB8/+VY80?=
 =?us-ascii?Q?1ksV24LYYvZYY+7sd7adQWgUe8AJ27HAfa6A4dDE/R+W19jeks5Hjq2rFESE?=
 =?us-ascii?Q?JSH9PeXjeYVJ+Z7jPu93Ee4Lj6YUTn9BEqpZxlOZQssfSbmI7UoPQLYo6MLk?=
 =?us-ascii?Q?Q8NqHydomViuqwWpwT4pwxKCbgSSRO9TYiazz9nzdYrkltVZ4nNguMu+tjlS?=
 =?us-ascii?Q?trC55fDdaozQutAcqVp5j3Kt89pedgBrcJ6WKOzk2cSaKxacEtnB/foOm6hJ?=
 =?us-ascii?Q?R8Ced06CHrpEwxDrX355F000t/+LToADYVf2QNY509Ma3WmNm8ickJqJOKHF?=
 =?us-ascii?Q?dmiHO+Zg2WERawzowjPUVrgoidwmLqQX+0fWJaaR/tLWLZHmdAtOhlZyu4V1?=
 =?us-ascii?Q?tkkLzLs1YII7p3VnRRMXu4+wccCMei4oOp4rgHt8/FBK+fXBLgpO+Z8xq366?=
 =?us-ascii?Q?VqSszDkzRZfbuAuypz5x0sqF1rw6uR0iCSRpbwxMy9LXtdH91AFRHQfRHjYO?=
 =?us-ascii?Q?QjLJT3pO+8ugPf76UHlSiPf/UE8ukj2gHdng7eHePxLWmAGAr54gLiOTJFu1?=
 =?us-ascii?Q?EGEPmqkyOCjkkB5WmejD0ZOtQVrbnmD0O4HcAzVFNLcsF6zHf0Zvytn1cbOc?=
 =?us-ascii?Q?52x40SKK23zMqdXIEeaQ4/wQAHPb+Uw7XJcM1TY87R9zUuBOANciZPc9fdSz?=
 =?us-ascii?Q?LOn33nrYS5sGBLJHZdrlpImf31DhwT5AGK48fxuE2/r+ewZL6q/JDqnQNhtC?=
 =?us-ascii?Q?+CoiIEQYpgi2KmwC4mKnmN3PcrLWKdgfMS9zYEV7DxIOoZojtxhYqZoOXrF/?=
 =?us-ascii?Q?5p3DaBCoRqqKRdCsuE6Od5T1zKavkkHi3keypBLZaCAs6ONI8Yg+sW+WGV+C?=
 =?us-ascii?Q?gSkJP2LBtTMmXSG9iIgCEHTQPvmL5ay91DQt6Cy5fuYvIGep1mUpwW533dDm?=
 =?us-ascii?Q?ISfI29fspUgkbWRHBnkjOK1DfEYeYXz7BVY/N8GB16Ve0AdXzC2lVuS2uLQD?=
 =?us-ascii?Q?MrdCW9llOgBAXCMI3JyjYDya2ZzfRT4ZZ84xQaEFVG8SWPF7txh5i785ykRl?=
 =?us-ascii?Q?1uKMvR00/U8ilQVvurXgXWRuqS2P+4FJXj35Y8mSdKF/rbBLaXpzXb9HqxLl?=
 =?us-ascii?Q?oLZYfcn8u1TFs64HE98ZcOr/ANu6eIiiqoZY6Bbr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05943f91-62d9-40b1-3ef3-08db98b1ce90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 08:22:44.5075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rd8niP6gpNeXR6hQ+zfxb1/wVl5U0aGaIH886O4imaxQE/q1KqyD6/kvc7SPZSiygtAyBRpiMSFfS2D7UewYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, August 9, 2023 1:42 AM
>=20
> On Tue, Aug 08, 2023 at 09:34:03AM -0300, Jason Gunthorpe wrote:
> > On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> > > On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > Sent: Monday, July 24, 2023 7:14 PM
> > > > > >
> > > > > > +static int intel_nested_cache_invalidate_user(struct
> iommu_domain
> > > > > > *domain,
> > > > > > +                                         void *user_data)
> > > > > > +{
> > > > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req =3D user_data=
;
> > > > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info =3D user_data=
;
> > > > > > +   struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> > > > > > +   unsigned int entry_size =3D inv_info->entry_size;
> > > > > > +   u64 uptr =3D inv_info->inv_data_uptr;
> > > > > > +   u64 nr_uptr =3D inv_info->entry_nr_uptr;
> > > > > > +   struct device_domain_info *info;
> > > > > > +   u32 entry_nr, index;
> > > > > > +   unsigned long flags;
> > > > > > +   int ret =3D 0;
> > > > > > +
> > > > > > +   if (get_user(entry_nr, (uint32_t __user
> *)u64_to_user_ptr(nr_uptr)))
> > > > > > +           return -EFAULT;
> > > > > > +
> > > > > > +   for (index =3D 0; index < entry_nr; index++) {
> > > > > > +           ret =3D copy_struct_from_user(req, sizeof(*req),
> > > > > > +                                       u64_to_user_ptr(uptr + =
index *
> > > > > > entry_size),
> > > > > > +                                       entry_size);
> > > > >
> > > > > If continuing this direction then the driver should also check mi=
nsz etc.
> > > > > for struct iommu_hwpt_vtd_s1_invalidate and
> iommu_hwpt_vtd_s1_invalidate_desc
> > > > > since they are uAPI and subject to change.
> > > >
> > > > Then needs to define size in the uapi data structure, and copy size=
 first
> and
> > > > check minsz before going forward. How about the structures for hwpt
> alloc
> > > > like struct iommu_hwpt_vtd_s1? Should check minsz for them as well?
> > >
> > > Assuming that every uAPI data structure needs a min_size, we can
> > > either add a structure holding all min_sizes like iommufd main.c
> > > or have another xx_min_len in iommu_/domain_ops.
> >
> > If driver is doing the copy it is OK that driver does the min_size
> > check too
>=20
> Ah, just realized my reply above was missing a context..
>=20
> Yi and I are having a concern that the core iommu_hpwt_alloc()
> and iommu_hwpt_cache_invalidate(), in the nesting series, copy
> data without checking the min_sizes. So, we are trying to add
> the missing piece into the next version but not sure which way
> could be optimal.
>=20
> It probably makes sense to add cache_invalidate_user_min_len
> next to the existing cache_invalidate_user_data_len. For the
> iommu_hwpt_alloc, we are missing a data_len, as the core just
> uses sizeof(union iommu_domain_user_data) when calling the
> copy_struct_from_user().
>=20
> Perhaps we could add two pairs of data_len/min_len in the ops
> structs:
> 	// iommu_ops
> 	const size_t domain_alloc_user_data_len; // for sanity&copy
> 	const size_t domain_alloc_user_min_len; // for sanity only
> 	// iommu_domain_ops
> 	const size_t cache_invalidate_user_data_len; // for sanity&copy
> 	const size_t cache_invalidate_user_min_len; // for sanity only
>=20

What about creating a simple array to track type specific len in
iommufd instead of adding more fields to iommu/domain_ops?
anyway it's iommufd doing the copy and all the type specific
structures are already defined in the uapi header.

and a similar example already exists in union ucmd_buffer which
includes type specific structures to avoid memory copy...

