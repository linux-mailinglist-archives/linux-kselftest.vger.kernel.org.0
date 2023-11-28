Return-Path: <linux-kselftest+bounces-699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA367FB37F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED357B20DB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876814F9A;
	Tue, 28 Nov 2023 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOcZrpdu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A098;
	Tue, 28 Nov 2023 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701158618; x=1732694618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jC3p++TrnW9vc+Ur0c1N5mXzc8ozOatbcl7d+yvku5o=;
  b=gOcZrpduDRJG5uk048jGA9KTHmXBkKBuCP1ZtYP2rT29LT8PFrZf4u3k
   O9/qCfTaytARV018chkFs+zmrKkC2gxr7oVWfY9yyqzCoYLsvOOCLymtV
   yzQjEkOZhTkLoXLBC4SHzomWLflD/h5qZ0OuNmd9ROZ7b7yBXqejivZj9
   aPk668umCl18ph74f2xpNe/Fkf40eUlAjdW0qWJNlLqxlXbrdgCRApQG0
   u1oLELg2/ekmAfH9t81fSZQC6jPDbzlffsICNOiaT+sLoPiVuxKbQLLnB
   4E1hF3iF3h/rWvjlyZk7+2S9v8DW0iGU0/3W+nxSBHB5sDipkXUnYwWSe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="383258441"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="383258441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 00:03:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="10044584"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 00:03:38 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 00:03:37 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 00:03:37 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 00:03:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOiaa8ODt1bx2/wtnIZTftsArGtW+Vn86lsUvSvCpeI/RPJ76rlHryZgeLxyjFI1eyUUf9RI1hVCCvcB1jkFLz2Ix7x8NJDKxhQF8WgkYYgCH2Bg5ZjPryM1huBPlOtHs3K0B2TrDAltW8CoHK5+gn6ss0n9BjQuETBFachMaRK0fLidZ0RRO9qiI3FloEWYMDHWGBJvKPU7ato2bGH3N8vxM5f0AyoYqAXlBvLE3193zAgVyvApOLjMPPoV2rY2zjAayVPEn+vXWid+Z/nBg7bEoZ4YQ9OgegS7UAwnhFzdz1oGCeDROsJ+Ck1EpyGHCvsSH8ODMHXtEoLK5vu57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWHXhBIV34zW9j29txqr7anrKSI/Fre1KIFRR/gyDcg=;
 b=GrousvwFuGXOmQslDCsN2QAjVUfjS9Hw90HtI5S+lBx+zudSNnk+/s5qTqyxIS0fSy64RIICG99aL/b1pw8B9F219DqxOguWFM4hrEkNWGXgacxF52tvvJOUYrXZZhEWWmbqWVzu2dKrGNGRkP6bRl2l0hciTcAxBtD/Sh/gXTYIHQmnzh/8a6KWDbkdRyGdEndni5u1vC659wcr9gIFQ+YNXIc7QsioksVwF1dg+7tHMl/vhYgFKdrB4E2/ziDZah/I2uVv7F81Ktm5xLVtyRzIkcfoxPkMruD/LclFqYkpEFhE95lQ6MraeKhQay5mxVNStjrJZf/1y0Io3mPLWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8122.namprd11.prod.outlook.com (2603:10b6:510:235::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 08:03:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 08:03:35 +0000
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
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wIAAl++AgACaJQCAACuAgIAEgqsQgAXeCQCAAMsJ8A==
Date: Tue, 28 Nov 2023 08:03:35 +0000
Message-ID: <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
In-Reply-To: <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8122:EE_
x-ms-office365-filtering-correlation-id: 7271ea6d-d91e-4fc6-b099-08dbefe8856c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+0TvLBVaAWrTrpeYnn2CKF90eghYC9C9WBcNb2oBYICFb76jP6Rj1XLiCGNRM9KRnogMAQ7LbcUmcVYU+GeNLw4IZ4cmqQciNFvaB8C7Pto2tC7Kb30iEvtvABxNHADrN0g17ObR6mDSRsWGjiF/enhn4ILIYozZ35CfZNTH87fEnaw7/OPZd5e1O7oiSsXHU9LgmGzlZhs8d52tBsT0zI6uuC4yVB5gDyS70Qmpk9cRmI7NEQSqI3VxVS2En2Wl64s1xv76TLJ8PUF3pyi5vRzebylOb82ET+nKpOgJHjZ1Swd/OF6mF/+EBDv0/pSnzJHkL5xJQWW6/nxvuWxmk+j2bGk/9GTxZ+XA/k/3focA1vKJnGdJRKcRYX4ou/3iCYL36FBkYVDg72AuNAMEGKJu0m32vBQUswOEPUFkp3b+wObDvLTw9Dsr+h5Fjnd/1nqEyKRsTp4LI52qmODhpXDkY14c9c9Oqy4VqVg10fx0SSc5mA9+MU07PK9QGzypYQgfGQ4SH6h0BWp5POvSomOHCiU0BouhwTvVOHXtK6toSlfssf+ipfhN05qjZKTCIAaQs2L2LjTlcAFPKkFoL6aduNcRZLvd+9m1QBBv5WDqQdGO3evbATHNtCncr2r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(38070700009)(82960400001)(83380400001)(33656002)(2906002)(52536014)(122000001)(55016003)(9686003)(26005)(7416002)(5660300002)(41300700001)(6506007)(7696005)(71200400001)(478600001)(38100700002)(8676002)(86362001)(8936002)(4326008)(54906003)(316002)(66556008)(66476007)(64756008)(6916009)(66946007)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g7SYht9up602tRrj4T7g5ypdf+MYTni76CKg4BeQxeSI/80asE9mKcIxQp0M?=
 =?us-ascii?Q?kFb+JUnRs7iiIaLg/GTEG2KH0uDJe7jDDfqEeCngiUGQWucxSLCYySzKea3t?=
 =?us-ascii?Q?88JpucLvY6LoiaTGDdVxTzU0sT1s3kpbSDqwXaZ+/nwWFRVD5x8WsFfsRJL/?=
 =?us-ascii?Q?rYSga16W3JGv5KaVHTRGvyoqIRNCcndVeGbPoBCjYR/eBi1Qm1Bk/pJ5rXzE?=
 =?us-ascii?Q?9tofPZeZmTpYk2WL5gteTmM+iJtHDwfc4l85D0P44vhDie8G3QZgaxWKTCE8?=
 =?us-ascii?Q?nrMRRyJoTfgCqHw7jTKjXn9rROmCYmcIcLJXyu04gAUj5sxq50ZW/+hLjrgD?=
 =?us-ascii?Q?Kko9X43+8K2PtTWZl9aHzEHxKB/fmvRE7fHdYYzzPBAVDLhl2NMjIH+ZrA6w?=
 =?us-ascii?Q?A+ix3GwrKYFPQhm/CnowSUue+qv3PnJ9+T+xkRod486qpXa3kRoLAf/9fhwB?=
 =?us-ascii?Q?Dp/HOj0bZXpD7D9ZhMXqJMHN3E3LpxXK+GMJuEud13UDE+1sYHaBmM/oi8VB?=
 =?us-ascii?Q?sTQTS9BLgR4J2AuCbhFfFgSPdK0/SJ5ybRmgba6/PBo1pl4Nsj1DjEAXdYuS?=
 =?us-ascii?Q?OtTWVgvF/UNZDPtzcfL1hU3UbxTs1MLxSA905njXFXzybUjh87aw4ITp1IhF?=
 =?us-ascii?Q?MyX+s4kbbHFhICiY2+YDTLh3glcXy4aYYo4cQg6640Rnf019FQaE4R+YMRhy?=
 =?us-ascii?Q?o0udDqM+KWxwFP0sPIeWeYFmdRQ+pKaXnOfaeK4SXX3eIpLLuNbzxJhgSFiA?=
 =?us-ascii?Q?UmyTxEz5m28EMConPAgG7x56s/rvA2WrVNbSurmQyiLtCWOSgVpbvmOhlFAj?=
 =?us-ascii?Q?j3SCSkrv1Sv/X7asNc1640bbiWI+acz/D1mKpw7GxfW+6D+krXjcV4fsrDMo?=
 =?us-ascii?Q?0T++Ezho0XoOT9Trfj0B8D4xDr/MecxqSuK+1lzlNBcSISP9x4gqZzZ7kDo+?=
 =?us-ascii?Q?Se2mO4R4xxOnNsFtlVUf6qkqZxu2YGAv6CvvqTj66Q0bQ1I7IPn3SQ0V792s?=
 =?us-ascii?Q?+avLUPcLNzeO9B9cxYDh2ULkVHSK1CO65x8prk76rsHePB4V1nu2DbVyN7k8?=
 =?us-ascii?Q?CqSTpGv9Z6Ar9kkOOsASmXZ8ymuzeedT8BvK+maah5XG3j/SBKjY5SY9zRpo?=
 =?us-ascii?Q?wWQcVy7J7+vXx2GKdUdxM3mGLLzhOB5/Gcj2/0bdbHfBzzKoMbZzx2AEfKNC?=
 =?us-ascii?Q?SnCAuqB8rueOSWs1U1H9HbTkucub717G56204dEREnE/ml+SQ5tcdv342Zvb?=
 =?us-ascii?Q?it61jLhwmjmnn+fpec/L1zfp4gJkdq7arUlKamkj6DkQSHQnxbXmM/YZgmSa?=
 =?us-ascii?Q?hXPBnN9y8TIEVhl9lDBHqoV25LPr6xKALanTr2+JS+WbEPyrWAd2+gwBV/yN?=
 =?us-ascii?Q?M1aJnpvaw5Ab/lLwUgeL0VvE2tCXgAXvYBv7T6BTD97dTmhmGrXVyjgdlrpz?=
 =?us-ascii?Q?nSg64YrzYWMbCK29BvXChz+ZDUohMiLf7WzdEqFiLkNKLNC5wlF+t1VdMJs9?=
 =?us-ascii?Q?Yy3oOGEHcXUgfg2EP8r3V7o4I6Sn3wTxpxkVbF+8IaVe5OqZfib1Zj0Ur+AV?=
 =?us-ascii?Q?gnTnJxmWyzx/yGsfVqGPQ19dPgp0EJKV0sMrQFFv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7271ea6d-d91e-4fc6-b099-08dbefe8856c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 08:03:35.2885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMOAj7rDhIGLGOwGFnxTeJy4ZvWvQWLw/WWQEhaJyDxstbVUace2yeOOKR15n+ya1R2lUkdEKngzGkQ84uU12w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8122
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, November 28, 2023 3:53 AM
>=20
> On Fri, Nov 24, 2023 at 02:36:29AM +0000, Tian, Kevin wrote:
>=20
> > > > > > > >> + * @out_driver_error_code: Report a driver speicifc error=
 code
> > > upon
> > > > > > > failure.
> > > > > > > >> + *                         It's optional, driver has a ch=
oice to fill it or
> > > > > > > >> + *                         not.
> > > > > > > >
> > > > > > > > Being optional how does the user tell whether the code is f=
illed
> or
> > > not?
> > > > >
> > > > > Well, naming it "error_code" indicates zero means no error while
> > > > > non-zero means something? An error return from this ioctl could
> > > > > also tell the user space to look up for this driver error code,
> > > > > if it ever cares.
> > > >
> > > > probably over-thinking but I'm not sure whether zero is guaranteed =
to
> > > > mean no error in all implementations...
> > >
> > > Well, you are right. Usually HW conveniently raises a flag in a
> > > register to indicate something wrong, yet it is probably unsafe
> > > to say it definitely.
> > >
> >
> > this reminds me one open. What about an implementation having
> > a hierarchical error code layout e.g. one main error register with
> > each bit representing an error category then multiple error code
> > registers each for one error category? In this case probably
> > a single out_driver_error_code cannot carry that raw information.
>=20
> Hmm, good point.
>=20
> > Instead the iommu driver may need to define a customized error
> > code convention in uapi header which is converted from the
> > raw error information.
> >
> > From this angle should we simply say that the error code definition
> > must be included in the uapi header? If raw error information can
> > be carried by this field then this hw can simply say that the error
> > code format is same as the hw spec defines.
> >
> > With that explicit information then the viommu can easily tell
> > whether error code is filled or not based on its own convention.
>=20
> That'd be to put this error_code field into the driver uAPI
> structure right?
>=20
> I also thought about making this out_driver_error_code per HW.
> Yet, an error can be either per array or per entry/quest. The
> array-related error should be reported in the array structure
> that is a core uAPI, v.s. the per-HW entry structure. Though
> we could still report an array error in the entry structure
> at the first entry (or indexed by "array->entry_num")?
>=20

why would there be an array error? array is just a software
entity containing actual HW invalidation cmds. If there is
any error with the array itself it should be reported via
ioctl errno.

Jason, how about your opinion? I didn't spot big issues
except this one. Hope it can make into 6.8.

