Return-Path: <linux-kselftest+bounces-357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA57F2441
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96570B21D11
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 02:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E979EE;
	Tue, 21 Nov 2023 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLWS9woG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D048BBC;
	Mon, 20 Nov 2023 18:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700535008; x=1732071008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FR2vkg1QY9WjDqocDaVUQkwxcI1Tg8E/y+fACltUZzI=;
  b=JLWS9woGsz4P/vO3/6lpynrGrhO6LrXyCga1O+c4sCjDuz2BE4MC23hq
   PsyFjTS3BhoJHY6zVevkPaOPh8141M0hDGd3SYga3ADKnnue0F5HbfbtN
   qcWa9vK/NfwmVOoRQ1hNfJ66AUVatMGAwZTko429N6KAC0pBYzg+/o75q
   FCUcJnrUUGCu1PGEHuZ3OFGExtOgVvXKmOVE/ho/PCTZMidSIYF3f07gF
   q7DW20R13zHSDGVSIwtjZ2Y4p10X0gaFMUB7Hf2q3M/8djg/gnkbWyK2B
   zop9EKmsmIpaWGbo+GSN5sLRLgzOP15JWt8e2ycFNVSEOhldgoi+KF/UO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371923149"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371923149"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="759959155"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="759959155"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:50:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:50:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:50:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:50:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:50:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZh4AYfl97uRfNXR+Ug2eNHZnQxycTJM58SbWes2ppKGI9Q4MpjIMSU0usaTWWNkyU/Rwv8V0e+mjTRn8vw5rfgOQdAwWCjUOcfEYfvjeOOwdzv2H4mBZ37n74EPCvqAnDoJJKP8nss4t9moRY/VlDf5xQtQ2rcvp/VbusxnaPcxniPeGtsdLiefZCoRBVUs1XOoa6uLfjjujVussAWrZhTBx1ybfsbR71SA0wE2hZHaftmNhh2Mr7+sRMnGBtSUugQGujBReFNEvUfahJxoY0HnlqUp5cG4uAxBGOgLxPjjSVvGo9hAoL/2ijqEKusjcYUTIQRBU5yoU6pnxikXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ2qPnETgB8TFgjhK3q6z1vu7ZxD4Y8tXGDVxTven2U=;
 b=RstmRFB6TR+NzCZAmXfiNc01MkYl1kZGAP6lr5IUfOajaE9aBzoN7MqFTEJ3Lfv2J0w97dYbTy8x3tDmHhZdnaazjWukWg0UG9K4bDY08VOWAR6AzkfBB2jYacyCiSKlgLi4UI7Ob/Ow+e0vufcMrpERSbdLsMucITpBFp8mWltFlxTeuCrOye2wiAA6quZRv8xkC0i2KFyPRwsO20CGxa0Xn0PCoMMLv4J35kob4asrWEUoIKBIYudDv7qj9k5wQXej+6juN6eNZf2xs0eUrvL6MRDzlYnXKl33A4wVzTRdSaTSnavYeXgCqCXTIJ4vhyGKQE8/Jjoj+lrPw+wVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:50:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:50:05 +0000
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
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wIAAl++AgACaJQA=
Date: Tue, 21 Nov 2023 02:50:05 +0000
Message-ID: <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
In-Reply-To: <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4612:EE_
x-ms-office365-filtering-correlation-id: 63304275-2a02-4ff1-17b9-08dbea3c910d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GYorFl34GUl2PbzC2k/0QD+MbJ7c6zJ8/k7ZrT+LaQKrsg0ZgkHjEogI8XKPN641f9pr9eOw2U4VuwhJFuObxt/F8zj9FfZxvxhmfgy23kxOolvKmegxj3vhYAurKqh6Q2wFx0oqD20OLIC45bmEY6pVcGR4cTAyq23tQCjbl6z/gvwFtGgLbSsXFyMRVSJNow6pijCLZ0wns3OorQz+g1a7cBO8dPVlpd2vJ8VhyP3MjJoTkp2NXbfFCWl3/KZ3UoIKK+7Lak1PRRvc22k8betyVPALvhck56kM4wuhrCk3OdW/BwTGU8H+5dOL6VUfN60LPTxLFGxvCmP03S9hBW5oJwkD2hlAtyTMoUHCoRemQIA5RVnVYeXsQ59LJ02tRWkK6ZWkxLGZI11x9JhqFTjVX08ruzSdW22Jko9uLeoG+NsvWZfZf/YJRJktk2HBP5TeRCWkclLzmgYOSef30vfs62xRSipZPLE7IA+5ObRGNQch78EsAIiKgMKIXJu2iW++7b4GEn57HA4UF/ISQSvXU3K+YUPTfH0qiEPku/l/vc+Sup9zjuxu0yMtDBw/jgclTAZZVyx6pSIPa/FbuU0anGwLdyo89Xr6ftwZk2r/dNJ75YDf1mbEkvefD+r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66946007)(66476007)(66556008)(76116006)(6916009)(64756008)(54906003)(316002)(53546011)(7696005)(9686003)(71200400001)(6506007)(26005)(478600001)(38070700009)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(55016003)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uhWBwzbZN/685n1RnYSzS3gM3ZU8rA3SbTcPT2Xol0U+rrhaXzK45oPCWOP9?=
 =?us-ascii?Q?rmB8nvapzC0GSv0/7SlrpJ1xwiOI4v80vGsOrCMBhrEW/KFi7fxnOzaWdcIj?=
 =?us-ascii?Q?75i3jRurDEy+vH+xvQl7N3q8Fh3rzdoKnaBcEjjdMBYq3cfvMFEH+lRxV7Uo?=
 =?us-ascii?Q?GJ4BFwNYFK+wPsxln9BJOcfzESCyOUIB2fWcJvjXdwQKNAHqNoTh+KwDhJVQ?=
 =?us-ascii?Q?YWd2w4A3GGZ4yYWBcMIGSK9W+rcMHP2DyFQBV/TAOJWNgIltT+diyMJImPz4?=
 =?us-ascii?Q?lnAAlLHXP6bNeQ8luSv7bM37gZ3KU8RDVaUkts3CjV876lEZlpPsNkP4tDoR?=
 =?us-ascii?Q?v1YU3QfFZZRnS2cd7F/Kfs3pzB+mIknCQQ88WyQ7qsn3YXsNSPfe+TwIsEhl?=
 =?us-ascii?Q?wwevjuJPnDbCvQf6wnj5Om6DamVzDUy6b5RvA/ThXzuu4fnvPjK0HmRtAZ3T?=
 =?us-ascii?Q?IiqsPssyBDwyCP2k5ZvLIdsLh3Hx7Cr0DAAKi3Oo13X8PqygclrmpHrgV3Kh?=
 =?us-ascii?Q?TftnlbduAjW20/N2mRW7oleNjC9svlwqGO8gFGezA+C36H/BiJDMsxDQiv7k?=
 =?us-ascii?Q?KkQE0/xjFy7LBvfeQ7AQZuhNSoXkkk/hdpbbIydQ4ZDPvApRdw7hKXiQqAc6?=
 =?us-ascii?Q?ZURblvMqAM9/Dp2yCusl/YA99nH5oY9kvNGuNEYd7jdWF0AM4ZTzHlMq/lDT?=
 =?us-ascii?Q?UpwhW8edWMALEDJ3xK4GoBsSsGKgE7B96AJegqVwFED2LOM6tm/ooO2hVXzX?=
 =?us-ascii?Q?pIRRKGSL2NqZPHAw7UNVOf/dlbWKqnUnZYK3xHpyYdwbHl9BL/K9xrLrJCg3?=
 =?us-ascii?Q?cso3BpPyGeHpdHZfZGWlfm9jQ4m7zqIsnalWBvjhwVvJ2Ip+k5VxL5a++dFR?=
 =?us-ascii?Q?Jt0pxX3mWK0YgSdR++KZpTXNKDZiykIpgbfFTrdYZkWs0bBDX9d4RvIMltTR?=
 =?us-ascii?Q?cbLxPXDtDItpyjCMOrQIb0KMIBn0Xy228bgyXUvTtIQC8kjEzaUQtkV0YkOU?=
 =?us-ascii?Q?CIMElNA8Xy7CBVuS/STLWs3GrN6kLi2+DET0yB04X/Twik0FOOiDmmZ482vJ?=
 =?us-ascii?Q?wVWw0Tl+5LkiNxShMN3N4Mr8ny0NvZXKuz2KLAOjSSpWfRGXmF8pybYlN/J+?=
 =?us-ascii?Q?G6uEgl2gEaiL62i0F/CbPII9dcr3E4dVsqLmpHy/FFvxsP8m+IOsmp96lcLB?=
 =?us-ascii?Q?L372mt943DZBxxd7Kp9XeCz/6cCB/R99pgdaAYxEPnAdl/0aMGtgJNesilvp?=
 =?us-ascii?Q?btUo12ncbsVoLv5KwZaLK7jV+kNIJESBcSeOtwxLFToCfmezHDcyWvCxpGu+?=
 =?us-ascii?Q?7UwsMadBICuImphzSIIFSh+kRxBMWOnqdCl5BQ+R6kNksFSkjutfHh2+X9/A?=
 =?us-ascii?Q?g8XfEjkmPn5yPrRg35h3D5/BnU74PEW2lcxJG2+Ba1HOA1p54YPszbmhyUPZ?=
 =?us-ascii?Q?jkThiOEzX+bXQn1i4MOE9Vj89jTZrqrTdhj3xxtKHlsyGX8j9u8VWIq14n7j?=
 =?us-ascii?Q?3fk70nUrUQhPy2+6Qx14g/WkKZgRfuhmIEfKSFvEnriP1a6IstCeDvDd+86H?=
 =?us-ascii?Q?VwF6RYRlpN4LkM5wqvZZ+4NfCKrZvOE78rXsiQ0R?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63304275-2a02-4ff1-17b9-08dbea3c910d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:50:05.4938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9nn1y3ceY1z2Z9aSO7VQVfTK6bUjMGP/urJ3pam5SMNoqZXXtKhcVQ/VwS4wSILbj1KqDh9uPYDapp1bi0NIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, November 21, 2023 1:37 AM
>=20
> On Mon, Nov 20, 2023 at 08:34:58AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Monday, November 20, 2023 4:30 PM
> > >
> > > On 2023/11/20 16:09, Tian, Kevin wrote:
> > > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > > >> Sent: Friday, November 17, 2023 9:07 PM
> > > >> + * @req_len: Length (in bytes) of a request entry in the request =
array
> > > >> + * @req_num: Input the number of cache invalidation requests in t=
he
> > > array.
> > > >> + *           Output the number of requests successfully handled b=
y
> kernel.
> > > >> + * @out_driver_error_code: Report a driver speicifc error code up=
on
> > > failure.
> > > >> + *                         It's optional, driver has a choice to =
fill it or
> > > >> + *                         not.
> > > >
> > > > Being optional how does the user tell whether the code is filled or=
 not?
>=20
> Well, naming it "error_code" indicates zero means no error while
> non-zero means something? An error return from this ioctl could
> also tell the user space to look up for this driver error code,
> if it ever cares.

probably over-thinking but I'm not sure whether zero is guaranteed to
mean no error in all implementations...

>=20
> > > seems like we need a flag for it. otherwise, a reserved special value=
 is
> > > required. or is it enough to just document it that this field is avai=
lable
> > > or not per the iommu_hw_info_type?
> > >
> >
> > No guarantee that a reserved special value applies to all vendors.
> >
> > I'll just remove the optional part. the viommu driver knows what a vali=
d
> > code is, if the driver fills it.
>=20
> Hmm, remove out_driver_error_code? Do you mean by reusing ioctl
> error code to tell the user space what driver error code it gets?
>=20

No. I just meant to remove the last sentence "It's optional ..."

