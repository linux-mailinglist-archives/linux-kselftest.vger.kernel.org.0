Return-Path: <linux-kselftest+bounces-1829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D20081134E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F31F21845
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F2C2D78B;
	Wed, 13 Dec 2023 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mdryW8HQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA49DC;
	Wed, 13 Dec 2023 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702475279; x=1734011279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XsfVvpnfSqIWA1Yju2mabl7p6bN2If+eKAefi3u9rjI=;
  b=mdryW8HQhC5srtnBzWVjR15AHNC/vjYr1bV9l675w5BFO8WhBBz8HNNg
   PwV2UqNjft6agT8UZZHiIBiE/0R838eX3VXE4i5EsrCPTJmDXWXm4akYN
   nQGKEwxsuRXkVXqrIA/NdjJ4UUJ4zjNhWo/eJxgsM/PBWbWPc2FoqrJwh
   ZNmpUCSIC3g3csXJLWgDf0EcqgcK8mg0benRldFJHnQ0/hnvZ5GogcBu3
   ++333w2gGh0KWKr6FKoowNSQdSaLhSIhEMHv8azXA2jDzQH/FvJUEkP2C
   ByEfW0jE8dmYEZ8pWjosDhGDjJ90zIL9HuNOiuo3cGYQJgwJpyTp3N3WT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8325457"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8325457"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:47:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="839875536"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="839875536"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 05:47:57 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:47:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 05:47:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 05:47:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 05:47:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4u3BURzqSQ73xOuv+hGlhHwQ1hjtlvzsjbdjsve8GwYDTRXwFTrVFYHY+txjC2tpGMzAL95PjbxMgTxct3IhpSLWjhHt+F7Q/GotV3aMcQvMs7cGn6ZCw01mxVaf+9sfDZUB9vvcBnnm2larPYco8O2CuDrKmBc5TBpnoletAT4HY8uXxFcNMMOohcS2fRUoNfbpXKP75n+crQzZGwtTJt4tMTVUZDE1g2UDgDp4JP8DqWVm1xghoJjzE29Vl2jka5paqtoQJ9nJbBOiySdc3Roksja3XCkPhVEPzGaMZEPcQyvs1OSLFxlu5fJ5DO9hRcyN5NoAxOZkiltY/XtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voYlh5dDnrInXWS+GzqvKirisjkJl8q+cSczN3QQmY0=;
 b=RejB2Ieew/L8cZaKuzuv9lkWd0KwMTmHyr0E/GlS/7qr2J6Hm1Pyc5ixSa8H0I2sXtetDbtrKwuJoYxuN/t6k7WQpzErd9rkuQTO/xY+O3865oReZqMZf+UboveY3XmtSqxrVT+CvetZavKG8bC0kS8n9ndY2YYpOMlbAN4K2+fWhIU04jup/VVSBLNJqky8OoE7NIpTtFzLyIsLL+g6vpdQ2pXuSJCEAJrLa21lI6ZKGVnOHAe+9lHFtBFjM0B5kEzQGosO7M00JKQNMZrrKjYUbot/Zi4a8JR3DNE6R1GjCn+gBamMyGG3IoFK/tvuTTbYY+9ik6LgDyqZ71I98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:47:54 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::4b41:979d:5c37:aab9%3]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 13:47:54 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJJtyCzgqkgkqBUoie7tgMvbCdgxuAgAAi2QCAAF55AIAF1zMAgABbn4CAAZh0MIAAD+eAgAGC0ZA=
Date: Wed, 13 Dec 2023 13:47:54 +0000
Message-ID: <SN7PR11MB7540259246D97147A224B486C38DA@SN7PR11MB7540.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
 <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231207144208.GJ2692119@nvidia.com>
 <8c05763d-1668-4b99-af35-b43a34e966c2@intel.com>
 <20231211132135.GF2944114@nvidia.com>
 <DS0PR11MB7529AA3F28F4418A80D869B0C38EA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <20231212144025.GG3014157@nvidia.com>
In-Reply-To: <20231212144025.GG3014157@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7540:EE_|SN7PR11MB6726:EE_
x-ms-office365-filtering-correlation-id: aea7d3ca-2202-4714-b477-08dbfbe21ba0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CH2o5VMQUuZPkE7GgBI3C50+TL14yWfEBp69qFaxSQat+KaWjFIUSZg8hHzG7aV2AlWPgf/upmmf6foB2THR5jM021gBCsXcDlUXW6JGxv5KZChvNScpUKi/X5rgVm+tU/3nlBVwDmYPFlMg76/h5B0uerazWxiwf3xw+GzVv9EME12+g5rF71XFT7/POV4eSKOLIceFLEhydkjL0fVRlkon0i5JmTriml/HEcLJW5zBpqEL5+G+F4Dz1jsD9jUUoPhbckwPNWDM6G6i1p1Ex+Dsc/KiY7S0shHM73njg1N3JAqWCbaOZ9Ff1f0CX7XUvyJKYHsK3Pm7yw6ocIzO/8iK3MgpfexcNf97jalwLB2k4qOXuc/yhMA/1zkL+ofB3MoBiv2D0OA+V7Kdtz8qEncb5MHuGp3nfR0joWUOQknHhy1wQ9up1DC47KSzTgzehrLqwPFvvYku2K7ZmKsU7DmFgexPDXkdHkzE8/JkCWH0RceeEcadrBewEss9iqq+YrXatm++j/xQZi/cBsF0Qgg6l+hO1R+aMlpcQ9f9i0nveAcETP4m0MIS5G5FSboSYCykPQ/iJ7zgK+GcB5emxDhBtVEUTF/O5niKBexm6EhhHsClRVpX8hOVoLCBVTro
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(38070700009)(76116006)(66946007)(66556008)(54906003)(66476007)(64756008)(6916009)(66446008)(82960400001)(33656002)(86362001)(122000001)(38100700002)(26005)(9686003)(6506007)(4326008)(2906002)(316002)(478600001)(71200400001)(5660300002)(7416002)(8936002)(7696005)(41300700001)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gx97De/CxEA9i8OZsOjHnERoXhA6CK/RhSk+2OELEFiWGGqVAN9ZCLO2S1zG?=
 =?us-ascii?Q?eh355VHpjMppPHMwlWEPNyMbNMt8m7e370s6dq5/iJOfMKRftM/fiqSvdHwL?=
 =?us-ascii?Q?T9Xn1qmOXBDH9j9uyNNnZikS8FJIUdME16qhTz15tEIXpKzq2V9+1pxnf9K5?=
 =?us-ascii?Q?VkWyp/vKTkNWa6GuL3bBOlaJLTRQx5nX38pdj9JrICvmTFH8Li5+i36BsWdv?=
 =?us-ascii?Q?hp1YfX0KuQ7FHO6i5szKTCEAIwE5/cUyLegaI2CuPiu31OWT5XyZeYj1oU82?=
 =?us-ascii?Q?a6TE4JcY3dxTwFC/BEPpaoPu5P9jsXGze1DTLId4ZLi42Z/KVD6illAJU/IZ?=
 =?us-ascii?Q?dxU3prVEv4E01UivNYm6UEcFdWm6EAQ1ftSdyo02Gez4nas1V2D9aQ2zWs9G?=
 =?us-ascii?Q?aL5BRNv47C1Oyn80M2A0VqW98ekvxq5iChVYmE4QtY3TRl4YuMiflLFvVOh6?=
 =?us-ascii?Q?/4yBSNlbr3LnvLPsL+PNpw4bqq0uKZv3uZ5jMAhL/o6i4kPshJ61juHoER1h?=
 =?us-ascii?Q?0B5YCcD9eTJi798J/brKvBG3lSGCbTo1fJ5zYf2bhM+IRE/6xZiBqHyCD3pL?=
 =?us-ascii?Q?RoLOXMP9UKC6hG16WmYE9NtniGocShAVal9u8xZ2xK8pL2obWbKrE6z6oEle?=
 =?us-ascii?Q?icTyTTF8JiXr1tuuHjnEumh+uwLyqAoWIz1i7AeHC53Wl/y6l2YY292cI7eY?=
 =?us-ascii?Q?rAbhtV/4dzpkpFojHkjPPpOgu+WFl2dyKiTp9/uSS/q1l/f2k4Jd5yi+qz8P?=
 =?us-ascii?Q?ou/HKe3z6DjmdqdmBU5Hs8UeV2gnU1zTVouc7ejGvvi2523VnRLm4OsAgnTJ?=
 =?us-ascii?Q?j6chUa3hihSK2TafvkfkldniO+Hyd586xi3mU7vo6MBbRnVciqxiXoJtgS1t?=
 =?us-ascii?Q?M8S6jiOLu5azTPKvvlS/5diVrndEjfEGFqjgv26XnDokDzR3Usb+QpZXIZ2x?=
 =?us-ascii?Q?RAYtyj0E5Te3PMcz1c5ObruQrCnKfX4n/uk/TqRWfnKQHYUYzrAVH/tWDBo8?=
 =?us-ascii?Q?ldMQfX9yRpFA9WIGBIqvSHga65Zzc/2c7i7VstUzGPukSl64STT/8rqijaod?=
 =?us-ascii?Q?XYqZgSOuBUhkiIot2e46sG+OKM+9eYqNA9O2bcCdBLa/ADYmB6niIaPiRLX9?=
 =?us-ascii?Q?9GMDWPmn2HLXeavRFzBVowEsrLzUL7OW/2iP9YMDuoUteyo4DHiHOjKnhEyp?=
 =?us-ascii?Q?xK6cwSKwuzGyFM/VcODPDm9NIa6/ID83OvjwnCkZsCdIbOGleUgNWA8flYSs?=
 =?us-ascii?Q?NPpYNLvzdjPm523szXEzAM3/UqltaJTaGeiAbmfmwR/h66G/0nWWiZLVkDCW?=
 =?us-ascii?Q?Z81XjCRUn1+GQBpQqRpsokIknGq3xQylK79C0ulfTneLFnCxgUViNInXHihZ?=
 =?us-ascii?Q?JmfUwsaXXyXj5zpAhsKcKEUjePE5zcZFYhKVYbFkPEyIxBoamFwQXVVFiPfB?=
 =?us-ascii?Q?985ILxHOGwkOSoEzNkjKOkd3VIQaCSv1NEVbgR3nfpX4Tri5AAD3o6h8rcKt?=
 =?us-ascii?Q?VQ2MN9uz0bqruUMuZFI+gD+WgvQjNdB2+NiFZ19O55tgT/nDFtb9FDiVfu+T?=
 =?us-ascii?Q?tL76kmqt2EgwQuBRgouOVdOS5UarE6QrSE9W1blq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea7d3ca-2202-4714-b477-08dbfbe21ba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 13:47:54.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqFbnMuSVS5X2VGrwKjxSDNYyRl8iDdkdSQZl4H0GNQKfA6kDsIbhXpWrP5hFLat4d+Uf6FIj25kbjvDYsaszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, December 12, 2023 10:40 PM
>=20
> On Tue, Dec 12, 2023 at 01:45:16PM +0000, Liu, Yi L wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Monday, December 11, 2023 9:22 PM
> > >
> > > On Mon, Dec 11, 2023 at 03:53:40PM +0800, Yi Liu wrote:
> > >
> > > > > >  From that thread Jason mentioned to make the invalidation form=
at
> > > > > > part of domain allocation. If that is the direction to go then =
there
> > > > > > won't be multiple invalidation formats per hwpt. The user shoul=
d
> > > > > > create multiple hwpt's per invalidation format (though mixing
> > > > > > formats in one virtual platform is very unlikely)?
> > > > >
> > > > > I think we could do either, but I have a vauge cleanness preferen=
ce
> > > > > that the enums are just different? That would follow a pretty typ=
ical
> > > > > pattern for a structure tag to reflect the content of the structu=
re.
> > > >
> > > > Is this still following the direction to make the invalidation form=
at
> > > > part of domain allocation?
> > >
> > > I think you should make it seperate
> >
> > Sure. I'll add a separate enum for cache invalidation format. Just to
> > see if it is good to pass down the invalidation format in the hwpt
> > alloc path? So iommu driver can check if the invalidation format
> > can be used for the hwpt to be allocated.
>=20
> I would skip it in the invalidation. If necessary drivers can push a 0
> length invalidation to do 'try and fail' discovery of supported types.

I think you mean keep passing the req_type in cache invalidation path
instead of the way I proposed. For the 'try and fail' discovery, we should
allow a zero-length array, is it? If the req_type is supported by the iommu
driver, then return successful, otherwise fail the ioctl. Is it?

Regards,
Yi Liu

