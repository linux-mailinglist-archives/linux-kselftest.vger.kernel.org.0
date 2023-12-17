Return-Path: <linux-kselftest+bounces-2110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339E881635B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 00:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E304F28286B
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 23:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FCD4A98F;
	Sun, 17 Dec 2023 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrWtMDtN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52C4B12C;
	Sun, 17 Dec 2023 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702855709; x=1734391709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=01ODKfjkQnC4yLwmCTsPgQXL/ZQjTesen1nBBiMiNf4=;
  b=OrWtMDtNISoilH72vVOaALlmuUsfcvUy9neODQkU/Zm4Lv8I6h6CyieB
   a9SGE6kuqCFTi55c9/1WylQhbqkOFdosCk0GHsM4hJwNGhgqKaXZUaLZC
   WRzkRCLKXKtYj7mkPV1WrogIk+ldNCAH8eNvKkQH3g8+FOkkqpk+PnDp4
   K/hepr/RQr3YyvK1R+OD4ApzuvfG6KCnnJEpRsYuQWI4rEaTRZzJvcuS4
   Nbk5zqXQ/GuZPACgax8u+TUN96M9YiG956CR4sL3GkuVZZ8FrgU+mtL9f
   2KlQVUlONkRM1lLHtHJeACQFzd5pmdUZY4kYdxHg6xIpATxj+xUs7e2ho
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="459760632"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="459760632"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 15:28:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="768639979"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="768639979"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 15:28:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 15:28:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 15:28:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 15:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TohpGBTzre7o4A7L1Pcin67CLrd3dXwkrPNpw/AR2UBhSJ8+QHY+Gx5JsZM8klh9B5CsmB98ZLdKdm8hk9xPHdEi7MPLAUFyzk0+Qea9t22/sNY3lHnXvl62u5zh7xeQGSYhMUcfV3Se5D1PSMHRbMnGO3mOs3iZMr4AGlnzoWDYr4PnoEnwWP6AnpWHIa4xht3NZcCmojeJv/Z4ZISxPHKTxmyI25bwNnxbNNoLV8jpcYMMoc1wKnKguUfQaWZJlX5CrLbNBTtgmQOBTX8XyY1da1KD05DSjwK0g8SFaCEljOjlSBN2vwp+GwzF3efxZ7CNd8FBGxGVwR/49QMHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01ODKfjkQnC4yLwmCTsPgQXL/ZQjTesen1nBBiMiNf4=;
 b=kQTQdS7GjAB/UV0g18bSEJmZ4tqfGAn1WQdcwq3xD3wkE+6NoZ7ydjcPuD7e+bQ1DB0xsIPmMkcczfz1zIBZxLVhYsJ23mPn1AoMSgFc3G8rWI6BswfcNMUuv2zl+oxCEVrsHkeP66T3dS2uFMlplAxJo4bBQ87TFBPjI7gYZgDqt9qVf4dNLXT/qrXYnonv4HB4hn0bcq42mJc63JaIdGpmGSTf0k0MPwkj7PkUonG6snygffjPwJ7HXCFI7hH2B/y79HdEC5sRvWRfOL77NvrBYcAwF4O5DsYQQtfOwN5+a76z3HMp2q3b4/CyO6rn2yavmABguNPJwhwxsL2YWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 23:28:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 23:28:25 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgADg1VCAABsWAIAACKYAgAAJVgCAAAgBgIACimIAgAHgBaA=
Date: Sun, 17 Dec 2023 23:28:24 +0000
Message-ID: <BN9PR11MB5276EF5F7C77C110E412514D8C91A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
 <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXu5whlIGfiq16wF@Asurada-Nvidia>
 <BN9PR11MB52766D7F774510E0181CC89B8C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZXvI2IiXwwuHRE8V@Asurada-Nvidia>
 <7c398efc-8a2f-479d-bcff-ded8cc1ef3d0@intel.com>
 <ZX3xJH8LPr8noBvt@Asurada-Nvidia>
In-Reply-To: <ZX3xJH8LPr8noBvt@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV8PR11MB8748:EE_
x-ms-office365-filtering-correlation-id: d349c662-cdd0-4aa0-f43b-08dbff57dd60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VSrltWucWUNXX6ICHiVsvUZ0JHH6k72K2mI4h9OQg1JN4ozPO0N015ETx43RzFQ3QRRati4v5MW8i48VCYXoeEq/Ms49Br+PTS1G7NVdx0yxxDjUtsL10yW8cv/Aa05V/8WicBWNZbpbgeQ9rf99mqkl+8RRlj8oEao4XV5Mk84Ksk/mKKVvw1nuSN7fq0x+aUWpNvP3HrVMEoj2YCbwE/EOuuKVUU0rQpiIgy5uhjdVn8YrV47EeHdLEXvG24sCTxH0HO5kpI++WdEVWHju4AYOGx9rzSLvHXK+27S+Tal8sNTzvrNAEa6JlZVAoB+AEgl9KxXYjXJUCHSaDSY3bCz2aDng6fcxuMC+LFazDUJpFG2Hr/FotumVwU4r2JaesfVd2m4918GXiqCx8s5ZQQErZ71tCQRhsm8Pby6bJmZpqy1uOUj7AuhiEUmzslYpomW9y+rsfsEpBWVDOMsEQ+ccLNNeNe0oQkqZH17leHbBiQ3hCLOeM+s9ymH4nE3t3kxIMNNEnRyeUmmvaKB4IX4Xvz5USN624zgubHODQwZePQOnm9DUC1kpQBpMxBydvkr256cMT3qPI+eXeRaCDo3QUu2mGiSwY9xgmYbQxvRBg60+tuZbBJ0Ov0eDUu47
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(82960400001)(2906002)(38100700002)(122000001)(41300700001)(33656002)(38070700009)(86362001)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(6636002)(110136005)(9686003)(478600001)(71200400001)(55016003)(26005)(6506007)(52536014)(5660300002)(53546011)(4326008)(8676002)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pcYX0bog157Y8kppKMZSKp+GUXpRlT2bzOilNXn5Q8Ud1dewGyYUN46Us0f8?=
 =?us-ascii?Q?4bIJbiaic3+SSFIO/2OFN0S8bjF3rqhe2CI2KExbRR9X6wXj3oE2PnD4/0Ga?=
 =?us-ascii?Q?73CfGsBgV9RM8K0pPZnt5Sj4A3fwUWpzKIkQzstfVmt16Yfslv+18Jh7CXHG?=
 =?us-ascii?Q?Te8kIBcJ26MUoZV+u3n2IOzkMj8Y4jFTxo4L6m8wU1Ai08PjHI1SuyH82J7Y?=
 =?us-ascii?Q?OPnXPufVmuDXc/7X4gz/OW3CtvEmvmxVolJmzoHp21g/99OzZGUMIEUunTH8?=
 =?us-ascii?Q?LH6NEzfNoK35Osf5sC5CVKT5bE3FEyxUTgZx50ysjkiRPbskxb2iOLy/bT5Y?=
 =?us-ascii?Q?ebobFDORYcaWnBOKHhyH8F5WWJxQ1F8tZw/qYIYKSvUoBtaDH25fDTK6AG0z?=
 =?us-ascii?Q?mEhiFitmKJBFmlsHWDmRkea0mKX9jrEJBhZ71XxNjeNRagYni7p01di8Yp8w?=
 =?us-ascii?Q?MYSkD030WR1FDEofc0tvwe1jxn17DJKRCpNNTyC1emx5apS17fuXHodpmrF+?=
 =?us-ascii?Q?4Fm8GqgcmyLEQs54u5JruAowNb75L7ljN9PRNK8qS2ZY/BkyRHKwJP1o/XlD?=
 =?us-ascii?Q?wtEF21RpVJTdtuDh3LYHR4qYTtrFtM1oE0+z1TvHPiIybhIyf5IYuVyXqVUo?=
 =?us-ascii?Q?aPbYfuOyDNCog1dExdBXC3MP12iDbhmZTxxVuxmOsJ2Y0PcSnglNcLrLaP8y?=
 =?us-ascii?Q?lTiEhR3YiFky3i1HOfaWw8l13OWVfX1EldcMh52SveaFBBLoMYcfI8BAbng1?=
 =?us-ascii?Q?7u3l1kXmMmSbhWF/S4UqfGd35dpJmm+nKZVAe3G9/AW0mTXn7uBDXqWmlP2d?=
 =?us-ascii?Q?wyI52/Rp7UW4jsXcfJZWA1FGfbiS1QQJ9uInbB3AfHOn6zjo+OA8NJWI61By?=
 =?us-ascii?Q?yUIfRx2zfw5OAMMs3D6142xqhN2UhT1XpOUtbwiuWN2a9kXBPlkX7Jj35qtU?=
 =?us-ascii?Q?WExyYvEOUbSYfwf7L3Bl2AlIS4WWGiOD7CCeCoDMQxfRy23t69qwjfGiHgq5?=
 =?us-ascii?Q?y6iahtDyWZ0zxzc/pL0CKaJpkl7oBRRhtHJsIQLjl3PnzYLjvQMOF5xIlDer?=
 =?us-ascii?Q?nvpQrnIfAwDxK36oPpuBUcDudAr61tSw1iShwoIEpSQcYqhoeApeRIuDcCs1?=
 =?us-ascii?Q?pYC6nG6RUDof97wNKsvmz7mca6MYeOJVcp3h+IgFCmkeGPjcgD4lLAZoRZ6e?=
 =?us-ascii?Q?iyNg4isytyMB5ITlx1SnIVWDwBAN7vZjmaAjJBxK7D4AZ8DD8D6vepnydOd7?=
 =?us-ascii?Q?i3RIBWn2oLTAZK7fsi/lb2ifNfM4BMa6KZocXm0xA/N4ApJSk7M8qanxOZ4m?=
 =?us-ascii?Q?TFqp+6MAwjg+9XTWokX1nMrV+EJ/wjVO5p08pTpxGKiawTXHYWX7Im0i/IUU?=
 =?us-ascii?Q?hFPraUZBSuV8XzYKqw9ukBX39IYft+gcc5959ld8gtHGBLI9ryeU2mKXq0AO?=
 =?us-ascii?Q?EkAYuh/p/40RQTbryt9/0eHplydmNKtJ/eIUT1mBHeO2Ai3ddDA6BgykkPYA?=
 =?us-ascii?Q?Uaa/VUqiukR7x3O2lDZ7XygjWxKc8GUYBbl78dS6Ha8iPJRSxVJylABjoxPU?=
 =?us-ascii?Q?Il4jnSoNcQgCGlPq2N8F4hRiEd/zaMn11ADrXAAT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d349c662-cdd0-4aa0-f43b-08dbff57dd60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2023 23:28:24.4259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/VPMrlgfUClftcgPrDKOUJN2GWhaIgTvvtCa9yXmHTsyyTJ/rT3Ni3sO4c0Z9D753vOQTkut+y7RxeO/nrtDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Sunday, December 17, 2023 2:49 AM
>=20
> On Fri, Dec 15, 2023 at 12:01:19PM +0800, Yi Liu wrote:
> > On 2023/12/15 11:32, Nicolin Chen wrote:
> > > On Fri, Dec 15, 2023 at 03:04:44AM +0000, Tian, Kevin wrote:
> > > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > > Sent: Friday, December 15, 2023 10:28 AM
> > > > > On Fri, Dec 15, 2023 at 01:50:07AM +0000, Tian, Kevin wrote:
> > > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > > Sent: Thursday, December 14, 2023 7:27 PM
> > > > > > >
> > > > > > > On 2023/11/17 21:18, Yi Liu wrote:
> > > > > > and for this error reporting case what we actually require is t=
he
> > > > > > reverse map i.e. pRID->vRID. Not sure whether we can leverage t=
he
> > > > > > same RID mapping uAPI as for ARM/AMD but ignore viommu_id
> > > > > > and then store vRID under device_domain_info. a bit tricky on
> > > > > > life cycle management and also incompatible with SIOV...
> > > > >
> > > > > One thing that I am not very clear here: since both vRID and dev_=
id
> > > > > are given by the VMM, shouldn't it already know the mapping if th=
e
> > > > > point is to translate (pRID->)dev_id->vRID?
> > > > >
> > > >
> > > > it's true for current Qemu.
> > > >
> > > > but there is plan to support Qemu accepting a fd passed by Libvirt.
> > > > In that case Qemu even doesn't see the sysfs path hence is not
> > > > aware of pRID. otherwise yes we could leave the translation to
> > > > VMM instead.
> > >
> > > I think I misread Yi's narrative: dev_id is a working approach
> > > for VMM to convert to a vRID, while he is asking for a better
> > > alternative :)
> >
> > In concept, dev_id works, but in reality we have problem to get a dev_i=
d
> > for a given device in intel iommu driver, hence I'm asking for help her=
e. :)
>=20
> Yea, I got that.
>=20
> Would it be possible for us to postpone this error report in the
> vtd driver?
>=20

that is the plan. We'll still report error code but no dev_id error
data. this is allowed by vtd spec.

