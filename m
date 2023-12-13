Return-Path: <linux-kselftest+bounces-1786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367748107FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 03:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA891C20E37
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394DEEDF;
	Wed, 13 Dec 2023 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSq03mbN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006DAF;
	Tue, 12 Dec 2023 18:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433435; x=1733969435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d0kH+Tz99uINgsXrHxBJTXPMaQLjE1LjviTzuFKOppA=;
  b=GSq03mbNaEEth+0t40mfNEPliTcW7HX6/E2Y/mJEEfWwxhAD7Vdwb9ia
   BDujqESl1aepPOn6cz/HG6eVYsoCCIBMwZrhQxYqv0DBjqcxCcIqAZYzG
   Aot2uslzuLwlMliHGuRHhxlMUbHzIHF3m+uO94vUwoDGy0EizDDf1nSQp
   +ipQ6iMQ1Wxrl4nTq0zzHfyjL1BR/5ttEF3zOVrmv03vOEIfGx8amu605
   SAJ/0SysdMC20PlIEnJHAobaskr64FmAE1DPWbEywlwBC0g2tRmaa24j6
   m79HVG16w4X/XtzMm7M8o4uAgOwsity1xfOIRVmn+JF/Cjg9nhnkkkqPg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392078433"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392078433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:10:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="21756593"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:10:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:10:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:10:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE0DAKGbB7ibrLfs18gXtGR+uNh1U4wOBM7RVixOoDVwTKGV4UvfeAYdvM6KoE6v9LYfkzcg0bxntV+VWpkLLWAfITrt0eRpf7ghEyB7VXQa2wHl37tfUm5T0b/NDfIEEAtmZ6Yay4Pw5fuJlTHOpfWtWIzlxWommQ1tuUV7GER/5bIwd8fQquqChQdKAjL4OyjyaxLtcS1CvK2sXf4fsXKuJneBC1qM10XmdrIOa0XnSFj7KNZELNNay20llkAFEEUxAZRA0/zchld2kNXn9nOLDq6+Do9NXWHrQpJBoLRoeXSw0GfzWfTlGeOIGTXwxIcEKnIHWpwEEsYkqUPaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fabg5y7yedTU+63h97aEMGfnPszMhBfoMHvA3LOmQAU=;
 b=J90ZWtVrPq1KtKjXX8Xme4WvHY8eHqAc/fuc3iuD+Jb+ucCw8UhZ7I3zdVhMaqQOweO5wz7ZnlYLNn3uf3vcP8Yh5hOMcD28zOgrDHlJXFS45BMiqpUs4vnmwQHv7puiTGAoQl3q0M7ynJBPGnccHi8vOCoQ7VumDpo24XYGrXk9Yy8vr4NlV5mQWbosZ2gbzgpHpB0LOJpEafAlP+sz0ZQ0xdvpPnMNmLFwbBcDoWzB0I46mBoMFptslPhjA+/46NZCyqrtNB5XmaBAmXzJ8XT/t4DcbLZAYWbiCd/xTczYyeNE/5QiJgnqfjqHBjqeRHR1WGUJBXSUSPW6D403yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 02:10:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 02:10:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2EKyfzMrBBEWzcc+IDcJP4bCkdsqAgAAB4QCAAAr+gIABW+sAgACwu6A=
Date: Wed, 13 Dec 2023 02:10:27 +0000
Message-ID: <BN9PR11MB52765A61C1124F75E8CEFFBC8C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <20231211110345.1b4526c6.alex.williamson@redhat.com>
 <20231211181028.GL2944114@nvidia.com>
 <20231211114949.273b21c0.alex.williamson@redhat.com>
 <20231212153504.GL3014157@nvidia.com>
In-Reply-To: <20231212153504.GL3014157@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: fd6d0178-ec71-48de-ed09-08dbfb80acf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ib3+pqqNUeaGSjrvKH16VpwrjHT8gUwq9Qe+KPDLeJlbME9mLSMQXX1jta6Nu3XKE4EHKprEhFLP61xJtPGndyNbV2Ul1pD+5O2IQDN2+ErMTLsLQomnVo1CoIvMVNpZLs256NKtK3Rtys9G5QzRCdoC1Xax/lmuVSTWUKQXbDyPqwDnYvk2i/FfIlttvF6ENl3gFsu3CGeJ7EJF6MGjJmKUiR4G1m0KL7xIL3rtZquXtGBobjKtVpVrX91LJkbymTDTxRFUnxbIH75x4wIBRV+FbUFpehFReJ6fBUyejkiSyVpfKqiuVsc1CnvPrU2Fsf/bqxzKx34D6iiqUxu1Hcuj5bhG2nEOPLLu9Phyg1MVR8amkmLNNFBoezehOrXdC317BWdBnJZwTg5yuqHTbj3Lmg0j8npBWMh6re7p85QgbBe1Tu10f31nuHfbvWqdaI9ZHNc99LfckShm7+VEPFH5Pud/IDBS7XHOTcSZYMj5GgpdSzAIfHUT7HENPrMK3W1W9HKNIh0vj6oXYmQLIY5ApLgR4+Jws4YHWVEEdLDUIfwG/d3UN5Xdj9+kX6t94AMjAFAkKoPYyxOWlPtCHZi/94dty4UVlmkYdvgeqvggabxQpQt2lVXrCDz76c2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(478600001)(26005)(71200400001)(7696005)(6506007)(9686003)(82960400001)(122000001)(41300700001)(38100700002)(38070700009)(33656002)(86362001)(5660300002)(76116006)(54906003)(66476007)(66556008)(64756008)(66446008)(2906002)(83380400001)(7416002)(66946007)(110136005)(4326008)(316002)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2xOMnMhOUGiFm/YNMjRJsvUVj/aCgxlKt7b2a7wKqD/+ldslI6bRFTh+VwE/?=
 =?us-ascii?Q?l5OwZJpNISZVxkwdxndXQQ8ToQbGgoE9LkppkFqcJpdZfG4phDsQw9Jn+7im?=
 =?us-ascii?Q?hJxhkiI+YnCn1d9MzEyTrdT2lPfTvRxYNDi9shigDlV08egGFnVRp52NBK5s?=
 =?us-ascii?Q?u7m3gvfpZrPQsfwrHLcpwExHWGHhDT/6vwmzmOoAbQRlaFekZEwL2ihaep2H?=
 =?us-ascii?Q?mRIT3qXccUubqlL/KGVFClFTcj1/xw+5iy14QYiX+7u6hUvK+oooY2iF0+5s?=
 =?us-ascii?Q?5dd/8CXPhs2ednHcCzt+PPWL7+T/7LI8vrXfqDmwxUPJDR2Wjti4YOEVBA/e?=
 =?us-ascii?Q?2rZRVR/4bcDtGMrC6OUQv1L7j8w8+9P974L9x+MEjMszRfTq1vTPmthYesef?=
 =?us-ascii?Q?sKphrBc/OkyA/oa5y942z6PHjCfom3ThUp2UgkdzWcaK7bZULNdIKX8eS3Rs?=
 =?us-ascii?Q?pfu7tHlu2vVvFKPp7hMwPpBLuAJmKo4ZrROy85b3HX4pdPZ1GcCHoFlgjzS9?=
 =?us-ascii?Q?KzPsbQe9Vk8TrE4VLxt9VibI3D5U8L5/NWRLSQjms46j4evtZeIhKyE9nEMU?=
 =?us-ascii?Q?bAkpoM3/AiQ/drfx3ixwo8Uf3yL8SB8brTMP1pYh4iIdr3tdMXt+eUtWYWLM?=
 =?us-ascii?Q?lY3ynY1rAkHP0BL/i63cvitY8MA6om7VT3H62rVO0ECan8NnLMAOvhvRzDr9?=
 =?us-ascii?Q?A5C57FqTEQuprwcNBX18BCa6pOp8fVe3Vs8j2L77zn99Mz99q6QoTU2Oj3LG?=
 =?us-ascii?Q?Oi6KOzDxisQmrMZiGGsmUqgIgUgsq3bcH0MVLCjWf22ns1BdCFlatn1hHv5G?=
 =?us-ascii?Q?UCEn/OIuQGMl4jVPPip2LS/bqxAx+LU2GEvHSvaBaTS8nL7zvAHwc0A626zM?=
 =?us-ascii?Q?pNHt9jyC6DIrv+ydvjcjIxKFlyA60EPQeQwVNQ/KPWcu56wLuqY0Nr9mJCk1?=
 =?us-ascii?Q?bSp1J5iYngjoNXuARe8v+VGhV3+f5q2WgaRdqAvywJHlN+NxKjHAcR7jHN07?=
 =?us-ascii?Q?CxbbMcDrj1+T8wmNYkYaU930LvgD3W84K30rbqXtOW6VU8l5uH9Udq+bAbrh?=
 =?us-ascii?Q?OInJaxtqUCqjGKpFiguS6wJREeIGc5PvYcXThjveZBQT1nt6RKFoHfG54pB6?=
 =?us-ascii?Q?iDEGyaPg8fh4BO8S77jRR3qq8CS6+nQeEsGSBvY5fvXjLxeMUABQfjl87wvX?=
 =?us-ascii?Q?6sRhB5kTG3aXHTbjwLniL8OrMA+W9Ub/QGC+qJVDZz1Qu+QQ7ytwiEEkS3QM?=
 =?us-ascii?Q?zMnMjlE7a8V3EHWOINQdIBnslJwqOu3QZi8G+vY5le3oU4mOlzuNtsrYEeua?=
 =?us-ascii?Q?Ts7vpS/JERgnUA9SJVilnMjqOQ8DRKSEoF6x3iogG0/+fsccZxR48nIiPt2K?=
 =?us-ascii?Q?xF/QSHwyByKphZYLX1mESuEtdq5a4So3i2ekJfzR3suPCromfFR5oXJSZot5?=
 =?us-ascii?Q?+BMKUKL5BxiMtaV4TpHkpJ4cwbon+qU8WtuVkFO9jVhcyyRhi+nVSQe/nN38?=
 =?us-ascii?Q?mVqcEsLOyugrHsdCPToWQOn4dgc1SmTaD8KDoXDJh3YylRPxNqgmWL+o5jdn?=
 =?us-ascii?Q?S1a71RzuwzQx2v42iQyfpUycvq1OhMu6iv+cSDqu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6d0178-ec71-48de-ed09-08dbfb80acf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:10:27.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkZVY54qaZqBfxiKJHYhCOTIgOFtWSiVCZ15y8kKxi4bK1XIS3jZSrWPwpUWoUsShj9hnjBlVlsk+Qto2m8gUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, December 12, 2023 11:35 PM
>=20
> On Mon, Dec 11, 2023 at 11:49:49AM -0700, Alex Williamson wrote:
> > On Mon, 11 Dec 2023 14:10:28 -0400
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > > On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
> > > > On Sun, 26 Nov 2023 22:39:09 -0800
> > > > Yi Liu <yi.l.liu@intel.com> wrote:
> >
> > > > >    the PF). Creating a virtual PASID capability in vfio-pci confi=
g space
> needs
> > > > >    to find a hole to place it, but doing so may require device sp=
ecific
> > > > >    knowledge to avoid potential conflict with device specific reg=
isters
> like
> > > > >    hiden bits in VF config space. It's simpler by moving this bur=
den to
> the
> > > > >    VMM instead of maintaining a quirk system in the kernel.
> > > >
> > > > This feels a bit like an incomplete solution though and we might
> > > > already posses device specific knowledge in the form of a variant
> > > > driver.  Should this feature structure include a flag + field that
> > > > could serve to generically indicate to the VMM a location for
> > > > implementing the PASID capability?  The default core implementation
> > > > might fill this only for PFs where clearly an emualted PASID capabi=
lity
> > > > can overlap the physical capability.  Thanks,
> > >
> > > In many ways I would perfer to solve this for good by having a way to
> > > learn a range of available config space - I liked the suggestion to
> > > use a DVSEC to mark empty space.
> >
> > Yes, DVSEC is the most plausible option for the device itself to convey
> > unused config space, but that requires hardware adoption so presumably
> > we're going to need to fill the gaps with device specific code.  That
> > code might live in a variant driver or in the VMM.  If we have faith
> > that DVSEC is the way, it'd make sense for a variant driver to
> > implement a virtual DVSEC to work out the QEMU implementation and set
> a
> > precedent.
>=20
> How hard do you think it would be for the kernel to synthesize the
> dvsec if the varient driver can provide a range for it?
>=20
> On the other hand I'm not so keen on having variant drivers that are
> only doing this just to avoid a table in qemu :\ It seems like a

me too. If we really want something like this I'd prefer to tracking a
table of device specific ranges instead of requesting full-fledged
variant drivers.

