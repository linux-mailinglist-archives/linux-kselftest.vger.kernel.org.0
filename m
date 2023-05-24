Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654DC70EC0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 05:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbjEXDsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 May 2023 23:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjEXDsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 May 2023 23:48:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC7E8;
        Tue, 23 May 2023 20:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684900129; x=1716436129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Oc/uVkXqcPp2rT0/k745GbjrSLVyeWwVlp1MqKEEpw=;
  b=JJtV8iby9z4VykZ2MwByv96YZ0CMk9mMKs7+CU0UFsJmeBsuZEk7aau/
   uETb4BOYzcnOZluRv8glTWwUTkldI8NTI/rACpyXtmsRqHa7SbyMcDtFb
   h9vRfWZRTnnJTLTFrPVneOdze2LYR5Z4X28PMnqUlI25TNNn9FV8lHWjy
   0TXDUVWaY+JMOOzEq0YeLQIVT1EOlIOFgMmpl5dhKz+OH08WTmLAZXOAv
   zjZprhtx71d0ku9GLtTbQXDmalQVIoQ0M3h5C4CLubCQ37QAKp5xC/4Gk
   cQIHoDouSEORwlOulwW1ZdD9os/hqxW7D+4V80S01tI81n6C+alfKj8uK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355798973"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="355798973"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 20:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704179654"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="704179654"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2023 20:48:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 20:48:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 20:48:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 20:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLXDicMnbErXskrbKRcfFbmFLRCcSBdgR7ReLQYZDh0Lk09i8DnW6I8h1hanRowVeAvPP9bhub09UyRpJ2cSPEzFbObGIvqCSbUFlv732iRt04yJqYK9a6eemelZHbiM3AAm/IpS2fRqYtcLO5dSUhNSGbUzVRgElLxm4dupGmZw+8yeTAIPfH6WSsiODFxATqkmL8gtPhpvhyQvkSO5v4GiLlZ+PeBVaPvSYtteiqCr04ZXXc3Bg5AXpK3A9/cPzXzk1Y7PPWZBZ72MjdJa3aqjnC6N4X4z1KPS9J60qXI6JzVfYaxn2wGs5iT9/ahPh7B85+Ta0BeruBBKbPrMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsxezL451brbLjo+Z/iK0VUa/RvPkKHtwhUdynK7E5w=;
 b=fwC2Xdak/Nnv6xtCdh2LcyozSsJ3vTvtIBRJkyBnyr503LBdXfMxkUMegl/LRGO9wjGsQX/QFybwqx1FoyYbppTmf74AeWsHjGpLkkraqkefHWsSXprrvgzDpA8sJyMiYwn7LNASAvW6adJQ/pesowB1DEv+i5l6m0wnBnM2MLP3mmwIiRclX0mHnc+0bxxlo6K6rrS979x9do7Gx11yko6UwV0xsZnFkwJ6+SI7i6TLF60JYQNjKelb+DHDfAaMZyth9mPllGT5J1mS8go/8d8wqFqhwif8L02oaj9R2PVMz7hnRC+WAr4NE77sqlnAQtXRIRC72wJbS0FaRSt3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8488.namprd11.prod.outlook.com (2603:10b6:408:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 03:48:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dd3:4277:e348:9e00%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 03:48:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Subject: RE: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Topic: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Thread-Index: AQHZhBZTNX7dDuLMFEel2CdlG13MGq9hZYMwgAAiQoCAB0Y6EA==
Date:   Wed, 24 May 2023 03:48:43 +0000
Message-ID: <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
In-Reply-To: <ZGdiS2m8jcd5OOt5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8488:EE_
x-ms-office365-filtering-correlation-id: 540ada17-a46a-40ab-d077-08db5c09c54d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XRe5hh1B9k+aZWdaVxjhPWbuYsZfa+rZyevEPlUc7nFn8QKqM9Qf8xal5XzEYPmnpbErejVz2gLuS4Neh3AxOsZ9RgwzIslflAXo3bErGTKD1055CuAhlkRpfBGi5+DJ9GSEkbdnJPOzAGN/nIwdCr7u4uq+F80JtT01gfAfTjRGkCC6u5T5L60XX7g5SMmXjWWwbb3F0pA9I9fxkvX7gB1pA1NhHJj4Paom0PKeBO+NHhNJc/f4mXoD8c+krquoyFbCouspvXaKygrVU5u0dVCvvI88RdtDxswG9W6e+D/OXdJrvwgVwrnyikAndXfkNlqiAYGyjeThJbbD2dJumUS/38XL0y+Ub4fk9Jul7kPj3Lm77orNDsl7vILqFeCuaIFPjCxF+3bTGNB//w5ILmTloho9qdh560L3OehD4ZP8juAbYL1MnUED+02KmD4DQJ6sxrHY5e2gzsCmVLJiDnlxDOEl8PTSCvUQ0H5Ts43F2uWQyJWuKBjUTXkDZCZC3NRIygx1xpGjcKI8OCWXEBFzHwTe7IiVevIFXYePTRebPuCrDEEST/Z3qhFqB3q79e62ZZzTBs8V4BvDkZqz2R1Qz3jLfCuhWgexqNXaJ/lcTiO2CquSUXJxxOzCgFYk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(2906002)(54906003)(7416002)(52536014)(5660300002)(8936002)(8676002)(41300700001)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(478600001)(316002)(4326008)(7696005)(71200400001)(33656002)(76116006)(55016003)(9686003)(6506007)(26005)(122000001)(38100700002)(86362001)(83380400001)(186003)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IFsHWdXuuGR/f0zinyV2U8c62mwk8UrnEZXHWxkQS20KI5hEdg9vTqhos0kH?=
 =?us-ascii?Q?R65ESAs7y8Retg//6gE881ORPc+st9xl4JO6C/1wRoWm2RuWojhcnHpoi3nq?=
 =?us-ascii?Q?SWupqn6fFcedh2D6GAH2IixSIXmY+6E+DnOIQcV7eZwtsGj5o057VJdjxZn6?=
 =?us-ascii?Q?2YM2N1aFpYQvD8bY8rLB8eYkb+tOv9GkGd0TZOVV4BIaEH2fWEGYMfZcHkEA?=
 =?us-ascii?Q?Vu5fLk0oCSpt9vKQ2hTBvuRox5ZLa1yXse7ONbf+HyA69gzTko0Wqyko0Wlm?=
 =?us-ascii?Q?fe5fZ3YOVYVlbh9jN+nO3LA7kKfapyyhDi+gwGJ882U8qHkMYnH/NXz9fQor?=
 =?us-ascii?Q?O3BGnjdIhaHSvN8XqeKeOXVu/eycm75VMRQg65iM3yHK/cCfMRuuLRNpFD9o?=
 =?us-ascii?Q?qnaJqejKHgulDKXH52/UINTs8BiAWB+BTQHalN/Trf/yhEFmJN3SOA1nGgxn?=
 =?us-ascii?Q?5w35lMv1rpHn036QzMgB0Z/Z63kxdVTidEfK3RmKACzSokn9mIjcqNC9bUYh?=
 =?us-ascii?Q?oBzuDr3dC9KcVeiw8gw7AbT14+O3ENF03KzZPGnzz4tvxea89E9FnptNb5So?=
 =?us-ascii?Q?ybO9hsnwL/FsrjyUFCaJQ8puyT/WR+L37Tv0HtRWOMRgdpuJe469Ye8R9dei?=
 =?us-ascii?Q?PpWt7VjPAyNgUGuaacu89qbJ6fLIogXSnkLKuXi7Fl8OMcdzHElaMYJugLyP?=
 =?us-ascii?Q?5YDyWHyRcCAtmzs8B6ROSzIRdBUwvzlBaCKgFY6HTddUHeZbLUQZ7/2GMudY?=
 =?us-ascii?Q?g3a1d2x3u4pbbdltsxwASpY4i16b4z2Uhj3H+Lp/Vjpa1OSsn2R0pi6h7wGh?=
 =?us-ascii?Q?1AC8F4pAWpf10Y2mPcNkVcQTdqk10EHDC1Q6ZCYh/l6jAauBcE3RX16pLGQR?=
 =?us-ascii?Q?Wo8sawlMm/J9w6ZUWxOo4OGfo8uB+p0ynPDZG3z2rzg7q/oMT9o6wDTH+Kdi?=
 =?us-ascii?Q?z+ELf0QwA2moaZoE0CfEHmAGOMU/mivqBNHnlf8Pvc1YJUWsjvBo6UrYFAhE?=
 =?us-ascii?Q?sFVs17o1hWtioR9IxRU20xJYrxtcrscoG4n3NMMVcfN9mFjyiOL+DcP3uaWG?=
 =?us-ascii?Q?qbaSoYrDhpkOLQWbj+oLgd221NUsQJx9WJfdoyepnPRyVFKarhYEtm/jPdVC?=
 =?us-ascii?Q?KpOA5mXwC+azauxwIvEUih7qOHfInm0APDCXI3GIzaug++ccNf7Q1FV8BhJ9?=
 =?us-ascii?Q?J4rEqDxFQGqTEWaYP57dVpOtsSK5RQKO0Unmk6MXxoPTvX0SLvr5Z3UVQtEF?=
 =?us-ascii?Q?08UYTbpF6Mx7RXnf19k69kl8Ziicr+l1oLmlCuAy1gTMr71m0TKH+8To1+Ms?=
 =?us-ascii?Q?h7y/T2ktNhD6azeTSiTbQ36BYbRx/pOC8Y+D3URqsr4AeCZ9T75cq+AqHaqI?=
 =?us-ascii?Q?2VuH0yzH47ujkx1mr3mgQ1QFrJTZg6GDAhZinXTkCf55F+ir6GQxTEeCWNiG?=
 =?us-ascii?Q?ZZjaN8DhTYy0TyU9gi2kUWsLrkryLRXW+n8UPUpGz90IzICi2a+Ipk1C1InK?=
 =?us-ascii?Q?D8Hk2lBONAL0apSi6llscX/6Q747gmYwGvAe0D6q4Nzzwy2Dit75clpXjGlV?=
 =?us-ascii?Q?quPMIbAiGgnj3RIMJNaUjqrmWboRTPI9b7qB12rg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ada17-a46a-40ab-d077-08db5c09c54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 03:48:43.7184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpeHv13YwXIxkIO26Qno7IjzvXDPR0j1C+uqb7BnRFBq+LQUGtjxHwAddyGe63MPWK1eKBnYmMcc+J8jRThT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 19, 2023 7:50 PM
>=20
> On Fri, May 19, 2023 at 09:56:04AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, May 11, 2023 10:39 PM
> > >
> > > Lu Baolu (2):
> > >   iommu: Add new iommu op to create domains owned by userspace
> > >   iommu: Add nested domain support
> > >
> > > Nicolin Chen (5):
> > >   iommufd/hw_pagetable: Do not populate user-managed hw_pagetables
> > >   iommufd/selftest: Add domain_alloc_user() support in iommu mock
> > >   iommufd/selftest: Add coverage for IOMMU_HWPT_ALLOC with user
> data
> > >   iommufd/selftest: Add IOMMU_TEST_OP_MD_CHECK_IOTLB test op
> > >   iommufd/selftest: Add coverage for IOMMU_HWPT_INVALIDATE ioctl
> > >
> > > Yi Liu (4):
> > >   iommufd/hw_pagetable: Use domain_alloc_user op for domain
> allocation
> > >   iommufd: Pass parent hwpt and user_data to
> > >     iommufd_hw_pagetable_alloc()
> > >   iommufd: IOMMU_HWPT_ALLOC allocation with user data
> > >   iommufd: Add IOMMU_HWPT_INVALIDATE
> > >
> >
> > I didn't see any change in iommufd_hw_pagetable_attach() to handle
> > stage-1 hwpt differently.
> >
> > In concept whatever reserved regions existing on a device should be
> > directly reflected on the hwpt which the device is attached to.
> >
> > So with nesting presumably the reserved regions of the device have
> > been reported to the userspace and it's user's responsibility to avoid
> > allocating IOVA from those reserved regions in stage-1 hwpt.
>=20
> Presumably
>=20
> > It's not necessarily to add reserved regions to the IOAS of the parent
> > hwpt since the device doesn't access that address space after it's
> > attached to stage-1. The parent is used only for address translation
> > in the iommu side.
>=20
> But if we don't put them in the IOAS of the parent there is no way for
> userspace to learn what they are to forward to the VM ?

emmm I wonder whether that is the right interface to report
per-device reserved regions.

e.g. does it imply that all devices will be reported to the guest with
the exact same set of reserved regions merged in the parent IOAS?

it works but looks unclear in concept. By definition the list of
reserved regions on a device should be static/fixed instead of
being dynamic upon which IOAS this device is attached to and
how many other devices are sharing the same IOAS...

IOAS_IOVA_RANGES kind of follows what vfio type1 provides today

IMHO probably we should have DEVICE_IOVA_RANGES in the first
place instead of doing it via IOAS_IOVA_RANGES which is then
described as being dynamic upon the list of currently attached devices.

>=20
> Since we expect the parent IOAS to be usable in an identity mode I
> think they should be added, at least I can't see a reason not to add
> them.

this is a good point.

for SMMU this sounds a must-have as identity mode is configured
in CD with nested translation always enabled. It is out of the host
awareness hence reserved regions must be added to the parent IOAS.

for VT-d identity must be configured explicitly and the hardware
doesn't support stage-1 identity in nested mode. It essentially means
not using nested translation and the user just explicitly attaches
the associated RID or {RID, PASID} to the parent IOAS then get
reserved regions covered already.

With that it makes more sense to make it a vendor specific choice.=20
Probably can have a flag bit when creating nested hwpt to mark
that identity mode might be used in this nested configuration
then iommufd should add device reserved regions to the parent
IOAS?

>=20
> Which is definately complicating some parts of this..
>=20
> Jason
