Return-Path: <linux-kselftest+bounces-1996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B7581405B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 04:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701EB2841A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3970110F;
	Fri, 15 Dec 2023 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJwxAG+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C553110C;
	Fri, 15 Dec 2023 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702609488; x=1734145488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JjOt8DNRxDj0oNm5VHzW+8CuvimBAss3KRgZqgLxpUQ=;
  b=bJwxAG+cR/IVHqRbv+I4DEnok1C/H5HDcKpdIygbCJjqW/RgoCLbxe7H
   0tPtPxg6eRpGqSeHNBvltRZfpCejSCoCH13PZLzDqbtZoR9UBYDcrFT9G
   9hSRdKcCCljXOTRnjoarw67Czb5tK67go9JM2l4heXoo2YFrYzM/16w8J
   vS7dBxKGJ7ENgv5zldVPb7WtzzBHxrrx5u1nRj2FKK9S4m/+400UBj2Q+
   yod39+ai/XexW9nhw5Krm2odGrJGXhSkBNSamoVNkwCVlsm9Fn+QiZQ9H
   A/YFRTsYuSBEF480/YmdhyFZkqZKW/uBZh4DwFlrsmg6faeMKdSQ6+30a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385641213"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="385641213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 19:04:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="865241012"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="865241012"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 19:04:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 19:04:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 19:04:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 19:04:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ+tN5yCHTJVe20gXInjSNLtRApEt27/ekahlqJjbE3lij9/DMFaH3AP/IRaygqiV3Y1HS2fYRe5MrZRGsQubSws0B/NvKxQ12h38SpGvHkUtnuzrb7QixjM6BHvpQQFEPuEBV7e0lQX/ABsxjb/Z9N55jE9t9y07H6WyV1Sl941Gg0oVn+jCHvdcZmHn14RvvFdICaeuwZY5dLVlK/A2bliMO6vwDp5ENhSop76msglbU6qVj2x8oFl9gevmGa08eoUNpnwtWMdK0Kt7hseQt5bsV/YgCZuW7LLqbH0gwMizSTxTeUOEOasAhZ1krnPQemWNi0iMakP3NxfstTO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdrDBMUATCX4wID50JYrlMZ72czbf3IQ884kkcKaG+Y=;
 b=MViP97qAsrTRxxu0treli3a+qMsGg3mn1zswmo4ku+tij2BGloLgmwzRhOQENcXlHMk5DG4fWNisyXSstP3c8UDw39wR+fz7qhK3XCk13g7Sx/1vbSCfjgVGgu48DrZaGrJzIXIsac0tGOgSXB/+8Hi6qn+rsBu3EgRiOmqk+2KJJRUKJlxnxsaw7SSE+yyj+hpTRZlYMBhfHhDSmfmrYtqrX3FEx7pRESs4RM15DkwoiyguecbvHMtXqF55fVUkv4WS+ISWenflQ6m3FPRSWB6+ZKuk0I+g5ZNw18U+R5AbxLbczRFBuxmyI7AlbEdRNolJMDu5tDMpG+26vuYA6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CYXPR11MB8753.namprd11.prod.outlook.com (2603:10b6:930:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 03:04:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 03:04:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgADg1VCAABsWAIAACKYA
Date: Fri, 15 Dec 2023 03:04:44 +0000
Message-ID: <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
In-Reply-To: <ZXu5whlIGfiq16wF@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CYXPR11MB8753:EE_
x-ms-office365-filtering-correlation-id: 203547f1-4042-4605-f086-08dbfd1a970e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jk39y/El3pCCZXfWg+jOFzacZ7vklLQWZWyzb3T0bJoGaNfMgdy6uBOJTZPErlV0eEPkJypEI6Gwf7GSCD35X0rrowrxrrqSc7b1qHWkj7QtKaZwuYjd5GPL0wWePPkvkU2g7hup9xIzO/SKxRTXfAVZgQP5qhhNCR13WEsWmuDsUAioqJWW7GdhdQuwYzDlCATpkmYb5o4teAH9InZFXaSsY04s77CyfH6VSH7a9kb+/32l4d+5TUuZtr+VB4wL8DRfgSUVFadd6Er0ti0hHLF0kWWR0il02NfEgcfX1lBl8KegfislT++7XGIHnu0pZXrgpOtaT+cbG+zcwiR/MyXALLvTrKlPt3aIea3dCAzCEw8GMK3IjGtGRkHnyXWSVt5OgyCRxkTIK80JGVK7L7GSyZXLSNnalk6ap0Lc5GlsAjFJmiD4ogr3wZEOFtAR6iT/A/lHgF5M6AT6Eo3KxGIxjDF8Ao6IY638uvkOkLUxlYPL4l0EzzKMDqt7hbitU+aq4qzWjhVIiTRFZQXu/w7YnV8oJu6xhXnPbJtQKffd03B4/nnyiCogAmRZI7jsDOOz6+K8x+NL/gZbXz3HpqK0E4kTVkkzr0+OfWKPn15BfH9jDYvR6SgqXQsT5mlC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(316002)(4326008)(8676002)(8936002)(9686003)(6506007)(7696005)(66446008)(76116006)(6916009)(66946007)(64756008)(52536014)(478600001)(66556008)(86362001)(5660300002)(7416002)(55016003)(66476007)(54906003)(71200400001)(41300700001)(33656002)(2906002)(38100700002)(26005)(82960400001)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Wzd/B6rYhR5gWhFpbAj0BMTU3dG/URSzczeO5RTsuOYgew9JANfMQOSke2B?=
 =?us-ascii?Q?+zStQpGtW2UIopkRsPwj6788j/PMvxzD5Jnne8prWwcHLXgOOG8B+MLq8ZfK?=
 =?us-ascii?Q?ab00VILO79xJ56fLYyTE2GH0OQCNkw09JBJ4XTgtWCmMe4BzG5PNXlsoX18q?=
 =?us-ascii?Q?GCa4+fqSkKpDUKu0OFPm1WVtIwEQDse4kwrv2/vnzh8X7RskU22OL/A8N1UY?=
 =?us-ascii?Q?PUPPp9lsGbr00rpF18XiGM8F7geK6gGGttcUNJDRD2iLPDu6qpTtuH41p7lx?=
 =?us-ascii?Q?3xEs2Vh6GmIk2GXJJdkBcrEce5liy2w/VCGkABgJHZEmfXUvaCTJgSNVwCEI?=
 =?us-ascii?Q?M6rsD1KE47p5LVBDGZpdnJ9lKyaswnu6+FM4P0LTtVCqp2eeBEsEs7myh+1N?=
 =?us-ascii?Q?XM/V2bN5GQ9oTZ9I7MyCqL7LZvbLDtVaHdqL0znf9RHdvmwgn2l5sJpT8HxH?=
 =?us-ascii?Q?5FZmsu7MhFZiwvM3fZODAxneEG5/cyuoQNtvDXYoypxlr49P4P1/W8Xf1WYE?=
 =?us-ascii?Q?QSE9K6Q+/BvieHbrTuX1vjadkU3AgKM2Tj2yn1xZPJshRZ5cX/3LPW3HHgHV?=
 =?us-ascii?Q?wU7OomTXFcCxkFFZsluIB0pxo7VXi1uSI2a0XZow4AbAtfLHKuIIdE7P7/NV?=
 =?us-ascii?Q?oPzMAfXBW+G258M6bWc1HEmV3gUdBnydsLHJRZ6E/4yPw3Ak4eFAimLTdhMh?=
 =?us-ascii?Q?3g1GpoOn/O+vd9/XfLynIYsjxRK7od3fXIGgeAUItII8a55k7YTj8dFsiZ0c?=
 =?us-ascii?Q?RT7rehAK8xKh/75O+GTVfxyUSKriSpOhyvnuJnXZDM+8HDBXUQGlq4rjI1Ym?=
 =?us-ascii?Q?Qrv8yMU+m96WcvjddHmk8vN5tAd9PNx4Ww9PFmwyJV/NiDMdmzwudtajm+cg?=
 =?us-ascii?Q?f0dTfAzOASejy0yEAOwlF0bZ5O8A7FhiQmDuN8G4FiUFfhkyzNczZrLNZWUI?=
 =?us-ascii?Q?ownre3vrf5ZNgsX4EW8INJo8s0Qyv1MszGPMPdy+xjyDeteOHfBzBta+ALAS?=
 =?us-ascii?Q?pchSk7tQCiUgpQstd/Goo18xT15l5GYIrxcOUy07ib33pD844ipJ3rN8mIkD?=
 =?us-ascii?Q?Es8cqDhIGAWZU71utL5LjFIBPXIz5l3dsMkANS0w/YEl3KsfscZr5VebeRCH?=
 =?us-ascii?Q?subdokBwMuuQt7dOEQA302sn60vycqLtXi6J70NXNu0QbpXOmLBMrwBX+Z+c?=
 =?us-ascii?Q?BIbwNrVEEvUkR26vEoWs58PMH1NjQidUKoqBPd1Dl6NIdo5Pn4DP/wBMqWUh?=
 =?us-ascii?Q?DSHS4QdV48sK5+DKcXjhRcv5VmHm+o1pLBEMlTulQCnQr+CxP0tkt00KlrXm?=
 =?us-ascii?Q?o9/t5xehv7bAWf2PoOq4jcIAxHsERUS9gVOYxqsXWWsS94B8SKmBH1s/WN0n?=
 =?us-ascii?Q?DHFDcJ7/do/fq5vjbYZ6Anc9z3f7p/b6W/BdaCQAyDlROmBuj0mhR4ejnD7q?=
 =?us-ascii?Q?PKBjHdZJ47zUGjSRC0D26GHmEeIwDxFuzG+NxMuh3zYEUxi4fgxHT97owbbz?=
 =?us-ascii?Q?d0mWDGD/k0HBnz3Ms7ZPqAax9zBGesboStr91yLNRwfysrCdNKH5wgJ0bHFc?=
 =?us-ascii?Q?jw2yTixACqOZy0GmvxxfFrscqR8Fop7wWsiU7P55?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 203547f1-4042-4605-f086-08dbfd1a970e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 03:04:44.8175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8ZSgUJV7fu0SV87ho/yZHROlNixuPnrFvAJegnvvVzO3TPbxsrwKOCG52h9TtELrcu4Q3wN6sLFcaGDtxRwZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8753
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, December 15, 2023 10:28 AM
>=20
> On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Thursday, December 14, 2023 7:27 PM
> > >
> > > On 2023/11/17 21:18, Yi Liu wrote:> This adds the data structure for
> > > flushing iotlb for the nested domain
> > >
> > > +struct iommu_hwpt_vtd_s1_invalidate {
> > > +     __aligned_u64 addr;
> > > +     __aligned_u64 npages;
> > > +     __u32 flags;
> > > +     __u32 __reserved;
> > > +     __u32 error;
> > > +     __u32 dev_id;
> > > +};
> > >
> > > dev_id is used to report the failed device, userspace should be able =
to
> map
> > > it to a vRID, and inject it to VM as part of ITE/ICE error.
> > >
> > > However, I got a problem when trying to get dev_id in cache invalidat=
ion
> > > path, since this is filled in intel iommu driver. Seems like there is=
 no
> > > good way for it. I've below alternatives to move forward, wish you ha=
ve
> > > a look.
>=20
> > >
> > > - Reuse Nicolin's vRID->pRID mapping. If thevRID->pRID mapping is
> > > maintained, then intel iommu can report a vRID back to user. But inte=
l
> > > iommu driver does not have viommu context, no place to hold the vRID-
> > > >pRID
> > > mapping. TBH. It may require other reasons to introduce it other than=
 the
> > > error reporting need. Anyhow, this requires more thinking and also ha=
s
> > > dependency even if it is doable in intel side.
> >
> > this sounds like a cleaner way to inject knowledge which iommu driver
> > requires to find out the user tag. but yes it's a bit weird to introduc=
e
> > viommu awareness in intel iommu driver when there is no such thing
> > in real hardware.
>=20
> I think a viommu is defined more like a software object representing
> the virtual IOMMU in a VM. Since VT-d has a vIOMMU in a nesting case,
> there could be an object for it too?

for VT-d it's not necessary to maintain such vIOMMU awareness in
the kernel (before this error reporting case) given its interfaces are
simply around hwpt's. there is no vIOMMU-scope operation provided
by intel-iommu driver so far.

>=20
> > and for this error reporting case what we actually require is the
> > reverse map i.e. pRID->vRID. Not sure whether we can leverage the
> > same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> > and then store vRID under device_domain_info. a bit tricky on
> > life cycle management and also incompatible with SIOV...
>=20
> One thing that I am not very clear here: since both vRID and dev_id
> are given by the VMM, shouldn't it already know the mapping if the
> point is to translate (pRID->)dev_id->vRID?
>=20

it's true for current Qemu.

but there is plan to support Qemu accepting a fd passed by Libvirt.
In that case Qemu even doesn't see the sysfs path hence is not
aware of pRID. otherwise yes we could leave the translation to
VMM instead.

