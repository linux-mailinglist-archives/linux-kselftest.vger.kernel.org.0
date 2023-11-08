Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D587E5234
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 09:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjKHIxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 03:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjKHIxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 03:53:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E741C1718;
        Wed,  8 Nov 2023 00:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699433587; x=1730969587;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9CXhgqOgRUrOA+5SgwmOYXdz7nDMgDDz2PjtLocZsE=;
  b=FbC45jkckwHVI0xUZkM1guzIz1Iyxijk8bmzfhgYNmgPnGCbNq2NnaOa
   R0uPR7kolgP4VBl64fNtJ7vBiiyxjQ01StsHy/mTRFO6cnYtyX/lH9FM2
   lqHB7OmLeKFIOqWEBS75VYC/80YyxLC/ryRXYRE4DyYrcfPwl0SuS5VE6
   F0U3CvYjXuk7y73zcjQJg4VPk0LSchf0RWiGzvy3cHyjXs7VKz7BhEBxd
   HJVWMI6lCg+peCgQuaMzFJ6PxVgJxtGpEz8KHXPyGDElayT3B88lnbmgG
   b40Ng1XGwVpqSTg63rREIdngnBw35KfJ6oMDp8C973+D7wgF2hCPyXuSi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374764621"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="374764621"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="886604933"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="886604933"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 00:53:03 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 00:53:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 00:53:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 00:53:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 00:53:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOCCB7DuEs0VFGbheQ8X7u6bnIkHSKXNq6TiR0G4dD2EocQFZ70kOW5lRboRK1GB22KKhTOBV9R0TWFkxfCrLkQLIEjppLT+SKU16HO3Rb/3NdraOamgUcztB7PuFl84s2vwhu0LKu7FopnYFa8XRVx7YjuSboGipwr2SJalzaBwqJl+6SOsi4CmmE4Yy/Ts7AZAq2uzowvdwpM/um8NOhz1T+bAFHsCdh2FdNE53qYPErRj0Y7KBtRxgqZVKNOPPSU9MdNPB9gKvL0GumNmHoCrUVR0mGcRfYOwZrufnkIMdLRK5trrKdnG1m3A6ZcX5kecW2RGWx1VpOvBdRorkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukc/nTwqS9ysmApuPFXJ2aCEUOoHUwn+DR7NdUOs1Sk=;
 b=lPDKioflgp6XaJoOe1dV0VG60JXWrwpDI7GXxqFx7BD6Q6TCYI1qJXe4EmzvSxn5eKocT0a8H9N0C7jI96IMPpgbCtYAyKKE/y9Fx2xcD3n0HmfqCLj3hXTAUykKUU7RsEHYGULKghBo4idvMFVoa3goKmiLWX41Si2drouHsO2Po4ufshqcE9yulV+mXqIMcCguzpB9PNIqB53+V6TPGlGGoUxWS1i/abZkHsfaBcaWdQkONmvQg3C480DWgHySPAoyBPcb05kXRpldckmJkYcM2M12sHEd2A+r6tKarL1/nrZAgOLh2fzllJpQBzgnTKM6ye2r3dHQ5TcWqcQGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 08:53:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.6954.029; Wed, 8 Nov 2023
 08:53:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Topic: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Thread-Index: AQHaB7ekIyYD98ruGE6A75OvyWpVCrBnBhoAgAeTvxCAAJ2DgIAA+Wyg
Date:   Wed, 8 Nov 2023 08:53:00 +0000
Message-ID: <BN9PR11MB52764A460BEDD56A56290BA48CA8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231102124742.GA4634@ziepe.ca>
 <BN9PR11MB5276B1582CED568795725C198CA9A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231107175405.GD4634@ziepe.ca>
In-Reply-To: <20231107175405.GD4634@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5801:EE_
x-ms-office365-filtering-correlation-id: 2325f3f7-6b93-4b21-ea97-08dbe0381caf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +CDgvxP+x8iagemNK7hPZ65Cm8G5wl5J+jSTOJkLsEXxWD8s8OfI/1XP41gfYS1S9K3Pchu3j/tstiaH70frvGcmvyNzak61VvtIktuJ4ipE/qV6NPb+IH/ilkmzcinXvZ8UE5jVtj2gLdJjuBj6jzvIw8Tr5irHzvu1+1EuVFFhv0IFD3LrdvDdSz0yvomlNQqwod93Ooy7GPHGXoKYK6oNtL2nBqqQfWXgwyIWRYn/ipvhnn2CJLJnb8Bp6DPhJOee+YJbazayw6LgNBOFn6geH+FOpPeBhwnT3/nKW43nmdwrneA+7f8c7biwZc5ndHFLCkFWOh7vhICIotdk3aaNjD5CsR7ParLKjKwJeti9QT133sEXswA+5s8sciC6iUIMrM3jeV5vi/EZx9OEKkMIXTCfA8jkx0AfpO+aaNRJMOkRoKZFWTb3qNKz1Qyv8HHA+TkN+R+1P8XdCqd9yjMql+14OpfstINA/CWnED5zHVL8RmCsnw6fS3q9gRJYS4nxQtWD1BFAqvD65xSnqwn+lOA/w005Iyc/XGTlJjOc3vYI83E3ZkI/43cDHuWRdBC+uFcjhrVqIhPAew7BjZRcJ+JrWIkOv/iX1yG8nzil6LvWri+H/zZrWJ0EZGJl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(5660300002)(7416002)(2906002)(478600001)(33656002)(52536014)(41300700001)(26005)(9686003)(82960400001)(316002)(6506007)(7696005)(6916009)(122000001)(55016003)(38100700002)(83380400001)(4326008)(8676002)(8936002)(86362001)(38070700009)(71200400001)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FuBKc106V0CCkFyxQf5YqTYD5vmTzCZYu3IbnkJyjqssWXrQyMjMbOJZiaif?=
 =?us-ascii?Q?3XIFp5QPdBiBhj/CFjRXdkQ5t/y/+RjbhdFQhztQJBE9/7ErLmxlZtpFyN2C?=
 =?us-ascii?Q?2P3cnm1xZQAWIEEC4FjzKLuxCD1oomBIZBYv5lQF7YSOWFcHQ04QcDJqWEYX?=
 =?us-ascii?Q?bROHgBLlzFvHrPycLRPiMfpaqVEdkxEENTtIbo7Z6ziaChsUApvpdWKhv210?=
 =?us-ascii?Q?ZqFgFo1b3L83WpiyX3HcsuoYugvQwPyKEdrbGKT/RYo7B0+BtLjigaFvu2Gv?=
 =?us-ascii?Q?m+E5w8DBjUQGR3VHV5B374ycX05aTP9VRwGp1woI9WCCc9m2vfa0a1RImWUH?=
 =?us-ascii?Q?Aek6QELFRjj7F7VVAGWrswuY+aPVTHIrAVkFdf2JDalLh3qBoPfbeGPcWsai?=
 =?us-ascii?Q?sG0u/MAhku7hj0GH5ZfuUg561oc5AI6aeyT+ZcnzxgxCZoTyrEPmtf/eq27F?=
 =?us-ascii?Q?1krc5T7mUfNLIcV1yt9xjMd3dTZ8N3fnBsjCRhkck6iKlhL0m4gR/p9Gbajl?=
 =?us-ascii?Q?pbEREBKIxPZJJP5jjjdP0XpiGSwRGYuB98wuzEF7IV6MkJZMIEqgGPKsxAdI?=
 =?us-ascii?Q?7zitVAQG1dcJtD7g0vk5j73rVRbKdd/iGHZaoBbX5iHzoQ4CrdcFyqwntVM+?=
 =?us-ascii?Q?12rqkOcMAUpEgGJnY6CW0DY8P6nTg4783udYAmIGt56ZwakAxSnwVjyLKEJx?=
 =?us-ascii?Q?CgdFGYVyzI0jtGJ3RT2l+uwBT2TXyJ4bQyfH4iKhbTutGqNK9C+PsjMB3GFJ?=
 =?us-ascii?Q?Jpwi4ACGwHPsuP6Oy4HwbGxNtucObahB6+W1gn7RhGbSn5GgrjIwiO78OEgC?=
 =?us-ascii?Q?iLeZyEh3YH5/6M/EM78rb/TPIWijzFBZtBQGXxUW0aPkr/vps7fBA+wUYHdq?=
 =?us-ascii?Q?A6948Ed9tFrqH7MVm83cHETtRfYByWxyMK/MfJBrmJhbsK+lZcfq6xn8/sFy?=
 =?us-ascii?Q?TrUayP0yh/60/CBKRHFu5KIZ9fieFUcvvs5GWfGahfmbD3vSPCg9d9KnO0uz?=
 =?us-ascii?Q?0g5pHHLGpQKUGo9mQUON/ETiW5nPHCl/1LSJtdgWgo5l2pTBKaxQMjdoFOxl?=
 =?us-ascii?Q?15MTEBkizDO6zqQ2rVRDS1tWa628hvd/Te8x2tOT+IQVaVerqdIKUVpvcFHY?=
 =?us-ascii?Q?F2ULFzwk8HjNZruq6aPmkNrEFf2ezv++hBZEXTaqP+tZkjzuZBfVHrnTlf0d?=
 =?us-ascii?Q?/GgzdxBa2yuEnYHNdP6iHQDMnnutKr+mi/AJvYELQY5eXSjrCbByHIJu1/Bv?=
 =?us-ascii?Q?E+30R/yKWP1wHDo66VKDQ4L5XJNA6F0GjQoSB/jvP0psZgQIiJvcrkgzMz+l?=
 =?us-ascii?Q?v7CcaPtNzRmISCWmeE+KsYIj+DM3qy10LVsTP+ZHKvbwuePu5zaNhtPZIuPZ?=
 =?us-ascii?Q?Wc0D7EKhJDp2gIWMPx7BK9MhThn4sRDTrnibWmkQtbEdzQ/UU65Gxtk9HRxE?=
 =?us-ascii?Q?nkW3Ex2GWfnEl+yKRpaPpBFXnO/lfQqGu3+QNtsgdERd6vbgY0Jk5ztxq6Zz?=
 =?us-ascii?Q?lzGnhq6ZfJTjrYSKyCAhDwC++J/VKQOjnKsB15cWcSqXjvuk2aVtoJrv5vMv?=
 =?us-ascii?Q?5NA8IknU1TLsNA4uelh+jS7w9DVyiBL86REcLeoz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2325f3f7-6b93-4b21-ea97-08dbe0381caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 08:53:00.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uCqPvr3sESR3wjxb1a2CU8u6/aB18X4Vc9mcOWIKercNwneqVDz/w1ijBtANw0n2TleraoDJitlyNVvO6lEIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, November 8, 2023 1:54 AM
>=20
> On Tue, Nov 07, 2023 at 08:35:10AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > Sent: Thursday, November 2, 2023 8:48 PM
> > >
> > > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > > Hi folks,
> > > >
> > > > This series implements the functionality of delivering IO page faul=
ts to
> > > > user space through the IOMMUFD framework for nested translation.
> > > Nested
> > > > translation is a hardware feature that supports two-stage translati=
on
> > > > tables for IOMMU. The second-stage translation table is managed by
> the
> > > > host VMM, while the first-stage translation table is owned by user
> > > > space. This allows user space to control the IOMMU mappings for its
> > > > devices.
> > >
> > > Having now looked more closely at the ARM requirements it seems we
> > > will need generic events, not just page fault events to have a
> > > complete emulation.
> >
> > Can you elaborate?
>=20
> There are many events related to object in guest memory or controlled
> by the guest, eg C_BAD_CD and C_BAD_STE. These should be relayed or
> the emulation is not working well.

so that's the category of unrecoverable faults?

btw I can understand C_BAD_CD given it's walked by the physical SMMU
in nested configuration. But presumably STE is created by the smmu
driver itself then why would there be an error to be relayed for guest STE?

>=20
> > > > User space indicates its capability of handling IO page faults by
> > > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > > hardware page table (HWPT). IOMMUFD will then set up its
> infrastructure
> > > > for page fault delivery. On a successful return of HWPT allocation,=
 the
> > > > user can retrieve and respond to page faults by reading and writing=
 to
> > > > the file descriptor (FD) returned in out_fault_fd.
> > >
> > > This is the right way to approach it, and more broadly this shouldn't
> > > be an iommufd specific thing. Kernel drivers will also need to create
> > > fault capable PAGING iommu domains.
> >
> > Are you suggesting a common interface used by both iommufd and
> > kernel drivers?
>=20
> Yes
>=20
> > but I didn't get the last piece. If those domains are created by kernel
> > drivers why would they require a uAPI for userspace to specify fault
> > capable?
>=20
> Not to userspace, but a kapi to request a fault capable domain and to
> supply the fault handler. Eg:
>=20
>  iommu_domain_alloc_faultable(dev, handler);
>=20

Does it affect SVA too?
