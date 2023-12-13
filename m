Return-Path: <linux-kselftest+bounces-1784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5D88107EC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E24C1F21AC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323C810E2;
	Wed, 13 Dec 2023 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUd1vd7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057C4BE;
	Tue, 12 Dec 2023 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702432774; x=1733968774;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qDeXpI92OgpZ2MRTC+7+7SsEFipFOOVErgTiRX2yS28=;
  b=HUd1vd7Dly5U+C8OV/8pIXQTebW7uQoA8jPovDsYRNOT6F5tTjSkpLYd
   VTIv5wNvDjuHRn0OABnLli3pZb/+eLh+MI4OB7iqRRzZNv7kB95c6cdwF
   cy4s9uO5wi5tw422y2TyiPp6CblyKYrC72chC9kRPqKC/p/dUy1el1O7f
   V0xS/liiIMZv9+PELa0Mm8DPAUM8y/gpQYDNS860qPEf9lJOJizwa0KEA
   uHFrDQyYP3UdckH178c4A6++KkfMZeTDLRtqAJMe4WxnnfJxrUa5y1ny4
   RsSYQhr98rca5Hu/o1SCQGsVEGAhyzEo2aOfNsP44AbqreAGhsOhPhORe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="393775224"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="393775224"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 17:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105137104"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105137104"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 17:59:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 17:59:29 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 17:59:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 17:59:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 17:59:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9uNzhMp+/rgwdUexiYJt5a1sN6jPL6oPrnRh5nJjQImRX3sOyXImzogvNJeKA5VfirjfB0OO60IVqAsfI/lr2xKxnO8Oi9S+Q5C0tlWJ1Yrh7QWthpdL9C66Rzd0oVasHaJGCbxALcbueCgDPc1iFUgEmJDhBAO9gFIyFbJpoLf6LtmbGZ0WBfnQmxRZpAhOyEEuCX3Jj5W2SCVm994ja+sKO+15ZtfGmb58wYgfEUfz3C2xEstwB+b8S4GI2TWgqzqAPTwq2HLaEShaQqRt4vSiZRUZWxpNcC541eOx+WIjXUjELtHMlpVmqbJuuxwdjPCMU0yuWjjJT4Okqzgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt7kTG8dQ2tSx/dEwTC+I0SZb1tbzJmm6S3NpE6L1AY=;
 b=U3NcQcoY6gR8yZapaACJC4N66mTsHadRcW+XeyGC7bhA6CDubnE0Mx6FutD/Ty7YE9CUaihaI0Gwr+MxeapdjS73fNbHTbxACrgAZ3iGwvKrXh6UXlfk0QbhuwzHkYKpGDc7jeAA+xwiBt0zdKwTKbwJRN7g64Rc/ZwU6nRa5ccMI/6Ay8asmry24bvv53Mg5ZkDbA6V4K1grPGfChsji2Qypt3gvo3so9jih7nyYJcJC06aLw85JyhqFocQqrpm1OKtUgLnEc8KLZOtfFfVyOFscbDd3QqxWxRiIxJoEi9XRqCV8ZvMohPSZLOv4LE1KzUDSMHYwiJtdtl6ScC0Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 01:59:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 01:59:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: RE: [PATCH 3/3] vfio: Report PASID capability via VFIO_DEVICE_FEATURE
 ioctl
Thread-Topic: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Thread-Index: AQHaIPx2EKyfzMrBBEWzcc+IDcJP4bCdkKlggAY/u4CAATAaUIAA3hcAgACraDA=
Date: Wed, 13 Dec 2023 01:59:26 +0000
Message-ID: <BN9PR11MB5276E0744C625273624333E08C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
 <20231127063909.129153-4-yi.l.liu@intel.com>
 <BN9PR11MB527639DBE4C433542F351F6D8C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <0bdae2ca-a200-4db1-a016-059730d1545e@intel.com>
 <BN9PR11MB52763C75E3D638B722CE63A78C8EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231212153130.GK3014157@nvidia.com>
In-Reply-To: <20231212153130.GK3014157@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: 1fcb0f70-8d69-475f-d585-08dbfb7f2308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZyidHd01wxYiGq85E6IHEwON2BMDv3SrQerM/ShpF8PBatiEAlZgWXo3b7LOQPuxHPiYW1P7p5UFP6lBE7ByhqB85cGmJ0SS5fvADVqHmYR48oVAjJs0ho8/X6pd3W/YQTD0vDgcZaNSblhpMg2LZy5mU1pURQEDuJItExtX/bzMPwiA9vryBgdftA+cZytjOellcw8MB8JY+VBEEVmV7y4PJ7jdmtiSmIpFbTPYtYJ8wzJAnVtWiaf01Y/Qou2dUAeETUGZl/wqBUNobKiJO7iNdYUaO8rvrAwrdElUT/Ig7xMCErCCMpwc+/abYDqao6FWhBN5gaM/dPPVEK3wl6LGaieunmeETcS0AZm00GL5i8I4Z9GF3206Zf8FVHmTaZAOBixwS4kLSsOPo74Z1j5/zuEZkwCM/rejq2o/LWKnXcKo2wcHbspCKQMSteu84hLLTXrALNji8TwuYuXc9xGx2RX4jym6qICuCrR+ptDsYsiku0l+NNTqrA+3+6omUalCqfqnRok5kFULe51IrFgC7e+/yvIEZv/I57UGcr0z+iD+1L4xR2ebohfkI3z1NsKr3hfhmx3+AIeywp31B3Bh5aq8hCGB2dpNZMrS6QwhIsRkaJRT+OJ6LEwAnaQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(7696005)(6506007)(9686003)(122000001)(5660300002)(8676002)(8936002)(52536014)(7416002)(41300700001)(2906002)(4326008)(316002)(478600001)(26005)(71200400001)(38100700002)(66476007)(66446008)(6916009)(64756008)(54906003)(76116006)(66556008)(66946007)(86362001)(33656002)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8ZnzLuYMI3AmEObcUXalim5yyQWf9JZ0NqJnaJrTQZFi+H9AMd9lK/Y/0P+b?=
 =?us-ascii?Q?G3+DGr0J5s6+3KqCnFuh/VQit6jdnM9HkXsPKvF3tsUrGtG88fZ/Z1FeRKfD?=
 =?us-ascii?Q?6a5lKV+BuePB3NDN3TcyOgmRCEJ+paFszBCBa19hnkXfeCY1xyQuPCldLOlJ?=
 =?us-ascii?Q?v7x03/bHVSAaAJ9f+85F6VNh0Mn0NpGN0scqXCn4WbwWDE4whhYJm1vWjnvO?=
 =?us-ascii?Q?q4n0VsYAvVbp2NwV2dQ4nYR51kFdIhmFqwgryyRheODvzu0oEGexKxIC9oCN?=
 =?us-ascii?Q?vgLh6S4mnKaLo/psonSWlsV4Cp/zWI7qf7LeoeBxwW4/7PM89sTWOQbn7Wlb?=
 =?us-ascii?Q?yK7ABMcgZSTbC+E61ruHYk0/CMTDbA8Ox3KLXuc22l2G83wwLgljC0r9yhcF?=
 =?us-ascii?Q?stBA2uWpp6sxztP++stAVLmq5dNIn88+0Deog5Gm5CwFJS9KDL+n5a9giA5e?=
 =?us-ascii?Q?qkjixHO6N/sKFy57KAlz7PSF6qWvXghmG6Yq6QZKCu8OArbCyYz1AUM1q5ej?=
 =?us-ascii?Q?SOzFn8ra5M0H2HtLif7mT3Pl8clidY8mx30yO8fZZN9XSYEgoE0bVrpkwDGl?=
 =?us-ascii?Q?psmWQvLilBv8KiMx+AWAvoTCWO7rFIFiZ21G3VP8nKimeI86+muYLWev1x+A?=
 =?us-ascii?Q?FMOr5x0RhcX/h204GBaz3GOeZuVYhP2u0dmUj2AMncDyU84fbN54A8AxKgyZ?=
 =?us-ascii?Q?11O2XTqCfYSFtencQfgF0TxjhB1JeGy+DFXb7H2Cf854uFQLIoCT3Qaiyvi2?=
 =?us-ascii?Q?R55artrg9oenHbaP+PR/7czincrWbYy7trjWBZmNqXO6xFtUUU4A7jUPzqKD?=
 =?us-ascii?Q?vtoNqgtK7pbdrKHBhp2bapn4w0+dFP5ZXhyePRtsclGwovw4Sew3p8spqhdJ?=
 =?us-ascii?Q?8HeOZOMmCI9w571dQ6WPyUL108aJPs7cAvMPahQ7eFf7Ra9sbWnXc+MPZezj?=
 =?us-ascii?Q?KaR81l4giME7V7ohpOILeYYp2IIvmz9o6On5HDe3xjl8YR85yZf2vb86Hxge?=
 =?us-ascii?Q?5YUaQXkKjCwKKqHex1OvqOonmv4gWj0NaB38TjEACQJPlibWZxxbj3y97AVr?=
 =?us-ascii?Q?RoOHN7FQElIELSjdPfqh6qz+wmUbH/oYeYNBm9lpDjTCSA+tYwT75SUcnqjp?=
 =?us-ascii?Q?JXk4a1Y9b0NQIz44vxfieGyswX60x/Gvb26tXbOd7FPcifRbA4FxVUn5pEyo?=
 =?us-ascii?Q?jPB2Iexua+vev8rT4MvHGYjOazlhJNSUXNKdrwIeFweo7lKQMJzP5OpAcwSv?=
 =?us-ascii?Q?iREBkEZ6462AU4Lvhq//7Z5JRa4IYAl2ri4+y58DjW9ltLlb+TCNcBDCOm/b?=
 =?us-ascii?Q?S7wSFYhOr4POFZj9NPQEdyJflQsaPigB9sbczboKfJZenoBvSG/L2paai4if?=
 =?us-ascii?Q?UG9ylqL8R/teNskrT8JDTLfpSisaZVHtEbhjDKFc1VDzC1cMQEmR1hZUZCjB?=
 =?us-ascii?Q?jVvzQk/LPayO3rQ3u5VXKoWY1HBzyn1DzjPV7+6HrE4aMEdCW7XORvi+CMlp?=
 =?us-ascii?Q?GJhYmWq1opntlACJKPNcTig2yhzkl2pHfZ+zOq5bQc8N1RaWC82LuQmbb5RB?=
 =?us-ascii?Q?he1PYjdVrt3MPROoUSJbNuEwFjn6jwwYsrNMsEyz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcb0f70-8d69-475f-d585-08dbfb7f2308
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 01:59:26.9638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fbdFqBR5+aS6Vo80s90oZSEkgqS0bJfy3Wl38aXlHzsOC3YF5oxD6wZ7r/sqw+9LpF8/ZQ8EmkgGqCSsgM/WZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, December 12, 2023 11:32 PM
>=20
> On Tue, Dec 12, 2023 at 02:20:01AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, December 11, 2023 4:08 PM
> > >
> > > On 2023/12/7 16:47, Tian, Kevin wrote:
> > > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > > >> Sent: Monday, November 27, 2023 2:39 PM
> > > >>
> > > >> +static int vfio_pci_core_feature_pasid(struct vfio_device *device=
, u32
> > > flags,
> > > >> +				       struct vfio_device_feature_pasid __user
> > > >> *arg,
> > > >> +				       size_t argsz)
> > > >> +{
> > > >> +	struct vfio_pci_core_device *vdev =3D
> > > >> +		container_of(device, struct vfio_pci_core_device, vdev);
> > > >> +	struct vfio_device_feature_pasid pasid =3D { 0 };
> > > >> +	struct pci_dev *pdev =3D vdev->pdev;
> > > >> +	u32 capabilities =3D 0;
> > > >> +	int ret;
> > > >> +
> > > >> +	/* We do not support SET of the PASID capability */
> > > >
> > > > this line alone is meaningless. Please explain the reason e.g. due =
to
> > > > no PASID capability per VF...
> > >
> > > sure. I think the major reason is we don't allow userspace to change =
the
> > > PASID configuration. is it?
> >
> > if only PF it's still possible to develop a model allowing userspace to
> > change.
>=20
> More importantly the primary purpose of setting the PASID width is
> because of the physical properties of the IOMMU HW.
>=20
> IOMMU HW that supports virtualization should do so in a way that the
> PASID with can be globally set to some value the hypervisor is aware
> the HW can decode in all cases.
>=20
> The VM should have no way to make the HW ignore (vs check for zero)
> upper bits of the PASID that would require the physical PASID bits to
> be reduced.
>=20
> So we should never allow programming of this, VMM just fakes it and
> ignores sets.

PASID width is read-only so certainly sets should be ignored

>=20
> Similar argument for enable, IOMMU HW supporting virtualization should
> always be able to decode PASID and reject PASID TLPs if the VM hasn't
> configured the vIOMMU to decode them. The purpose of the disable bit
> is to accommodate IOMMU HW that cannot decode the PASID TLP at all and
> would become confused.
>=20

Yes, this explains why disallowing userspace to change doesn't cause
problem in this series. My earlier point was just that allowing userspace
to change could be implemented for PF (though unnecessary with your
explanation) to mimic the hardware behavior.

