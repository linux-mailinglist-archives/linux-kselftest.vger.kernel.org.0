Return-Path: <linux-kselftest+bounces-2491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E781F518
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B81C2830E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186029AB;
	Thu, 28 Dec 2023 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PyFThM7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ABD5687;
	Thu, 28 Dec 2023 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703745492; x=1735281492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nOFscTCaP4g1hzS3AuKebAUApJGN72Ep2Nu8l5BonNA=;
  b=PyFThM7D0H18Dd8pEh9s4BNECoBEJy1aGHCCmMcqAV3VEeHs22CLe6qe
   7/7BTwsMinkm3vufMvzozgMDZ/iVs5GVQaNIm5d2QV03ZIt7os48Cu1xU
   4cQUZtyrC5UnnrqxjsSSi5KiocVJ1YJqnuYaYKr82LKZ4spAPSheFq3rB
   FwMRFhPEKxuzu6X/cs/obvMk0nDPNwtj8dczANT+DXcgCitiWciGQ1LWH
   2q6wySj6d2nBFg3ZLflGfysxulnh/UOJ1deEv/MJhr+8QPGKkqOgsyjZD
   nZQufB3r6WCDQJWiUUlUMaUIXNRmfnosvp6pkPLDztYzSiV6NeusJo/HC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="396243030"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="396243030"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:38:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="901894836"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="901894836"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:38:10 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:38:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:38:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:38:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDbNqUUlvqG2M6r37SpFLFgFI0gSzru0/fRALVfvQao/62IziP+PnHUHL3nnam6gulUiNyUxb7WpXdNYEcZISFmD/gIQmWB7NYdJjZdQ8D/a0DFER19KQpEgR/GG7KXi1lEaI5wa0HdUOLtBvIO4z7C2EFQDSy257hVlzkaItrmwYkej2878pz91HPuG5zo0QjLOuN00vpjb2AiszAucdF5Fxn+TVMY3w0C5qKTRhcXgmw+k7rCDNDzIeFjk6BfO4uC6jqn6rcHSxZfcPYG/3XRJ9w0rTZwIMIzE4h0k7ZQnhnEfOa7/HQe8GIEJHKF6wtOe1bRDSy2OzJUDRM9YNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzAPi7mKdTnOwJZ51S7YAYR2FrBlGhWgaiThaNakDtE=;
 b=U2NHCqoMZE/SZrdH469M6vyxLRw8k126otUY7AznBynSxNfLnS8LHEMUmDUuqGjO5zigs1tr02ZUGrfQuLIF/+dbphJyTVYRNUdKyYpGVr2mDDttfx5xaZYPgDgIc0p7T5W7wT6qlGKIzw4Uzzpz41Q8ILiJyozVr/+FClOEVS975tF8ShFwtal9kQzCdCxTyM4dr7gFi3L9CAyq6Y/sxKRhD1koqTSU7fQQp+lq6oIjBoKHaF5lTGObWj8e5Re3/IKD4J8DUsqJMxEJQsCJvw1Yr2FpVsCrF3uKxSYJRidAYqT20cuOf8+94D8h9DZF8QIa1I9t+X0cegut+vSH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Thu, 28 Dec
 2023 06:38:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:38:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "cohuck@redhat.com" <cohuck@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v8 09/10] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Topic: [PATCH v8 09/10] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaON/EULDpY/yduEi+JsXzzxonvrC+On9QgAAEfZA=
Date: Thu, 28 Dec 2023 06:38:07 +0000
Message-ID: <BN9PR11MB5276A53786CD3AF7F170E8B98C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-10-yi.l.liu@intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6228:EE_
x-ms-office365-filtering-correlation-id: 6afdc893-90a0-4c46-7196-08dc076f8dbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z46FehdD0dpKrfVxkWh2+rq1V9V2xtfNql+omlGDDjB1kMtfpJ/76U6xFf7WRJVd6DRvlmElrb/RfKc2tsujWms1J5Vp89ut0WQJmjgnkoUFbP5/I2BfGfcYTQ3S+Ke0yn5Pgmbvib80Piomo2P37bcPE0sofiJWGvDgM4qav+wd7u3I9eHpR8cguBJhWLhmvUWOrixY3k8IakkfAZEGDTgsQhr+hvrd/NuGvF1+TtoXqMlCJujYaym5IfE1/VfIc0W5xklWarvTxDWVrv1YhnKlfjHALPbfuI1wVwgQsmvfMFtZa2Evp73pNJ/mgGS9NHnSOoEzvWkhukuaFvj6pL0emQie6P4E2Ij0dEsz5XwVPuyJgLFjwrs5pPEcgAVjUPmqR8TRFJHDtlBkIJJN094TFuobEJwmKdB/V6m2f2TRwn7LuY2197xA8CVobWKvA1qcT1aHNnUFxiU1EjvRodBSjtzhZDUo5A3/Chu1i6t88KAGqlwQnJSojn1vVNjApM6s2YZ3IT0jV6h/PzIwqgZcQyvFO6Sum7Nw2GkWk1U3+WwIDEej3V1ig3i0t3uoaO5y4SdEt3XD6B3MBqyrqWEG5h+i2SQ0c5MVY6rJtbvr98xtDUDjTOyRKe+27YJl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66476007)(66556008)(66446008)(76116006)(66946007)(5660300002)(2906002)(55016003)(4326008)(7416002)(52536014)(8676002)(8936002)(316002)(71200400001)(110136005)(54906003)(64756008)(41300700001)(38070700009)(9686003)(33656002)(7696005)(478600001)(26005)(6506007)(86362001)(122000001)(38100700002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HEcltbIGJvDR3LnijW8dLVIueRY8GZNb3EC2FvSOxcHc+MIogf6ZGBlF/yRk?=
 =?us-ascii?Q?xiOkbw9iYEhe3v0wRIXSO9ecW5z0x7l8HtU23cRYMTl3ILmKps0H979F1p00?=
 =?us-ascii?Q?FVRw0Sted6yTrt/mHIp8wyX2jSKpKSMkRl8FK5Qu0bdDYjgxuI/KpvNX2YTo?=
 =?us-ascii?Q?HPPglcroh8jWtw5p11+mXEfmMUxkOydo1gwsX7OKJhwnrMKlFCJRGu0j4bn9?=
 =?us-ascii?Q?FOZymGPhAQHxOA/OfKRyc1z9vwi8cDFaBSnwYvSmGvf4TVTCY9YKKdmqfO/G?=
 =?us-ascii?Q?gM+vQnbWVch+st36tD0niZhryYYqzhdB3v9ZR7BvSYLanSgYmUSPlD6YFPGO?=
 =?us-ascii?Q?Q8lLW8T1VWKO24+e1SelbAnJcwP56EBXipnbbbMADafGXbEU+E+cGh7FsrPx?=
 =?us-ascii?Q?xs9SxYZHA9goLEkiXlZGPqdIuY7St4QUPcrGWCr45Cpn2U4kln5Y1b2L9fYE?=
 =?us-ascii?Q?cu2pZII9m5hHb/PNeudLo5F/Dc8RnvVvtuE1DzSWkaZIa40TrZfwoFSrhZqo?=
 =?us-ascii?Q?uI+VmHKz69bUHNSmXf0koIl1d3z0M9LN5MN/C+V/zIPtMgPN8p33qMFqtApy?=
 =?us-ascii?Q?9OqgoyGYpBdmFPn/EBpIz75lTSxdRvkQ8Wk0Aat6S8Pu96tqV9CvASz4+YrF?=
 =?us-ascii?Q?INEhVj8I/RN1jFcfZu1dPNQ5GXdhU3ELs4PDi2OwSwx5QGvfzIDYayuuT7Ml?=
 =?us-ascii?Q?NfA5WVgdAEpdFwcQFI38H5nUyzpQNjnMdSCCVTmcl4FAL0tYi+Y46/iqzhVh?=
 =?us-ascii?Q?8eUSvCamjthPIJH/ITMl6jH/tXJ/bQU4Txbf0MKccgvrCH3mQZCZDi7SIZ9Z?=
 =?us-ascii?Q?DoMOcMi4zhfxQJXm3g/aGsUrGwGTtUkPXbb5+LQMhvi2lC14JUF2qPYMaz+V?=
 =?us-ascii?Q?4bKpNASGF1PrJ+aBayBtkioVaDbjDa6ouVdC2JmQ3d2SpVvpRAneVGhqGeNv?=
 =?us-ascii?Q?JMOfnW9eVQyhxEqLG6ZRZhl834k0vYUwImPaOfbWrzjZGZzkvCMcHjGjJAL9?=
 =?us-ascii?Q?XeQ8/WB4hDHkDDehlUYDbqSoRKVMoWNUK6bkfwYdz/tAw55jQTe7zaaZk+Ac?=
 =?us-ascii?Q?1TSwSTSYURcFT63o9famqVu6bdTbwdXBQsua+WZaQOnTdjJIHNbT9L5E1Ub0?=
 =?us-ascii?Q?F6Jci0NGw11j9qdtStLZ4d8IHkb4pOXCDn3pMYS8Fa4u4F0qdeSlHXnduEJ6?=
 =?us-ascii?Q?hLRG5Ntb3PL4YX1b4aMaTGYiEndvgrrZUJxXLedruGh31tRjKBnY+tG8z/3B?=
 =?us-ascii?Q?EToxxXgxhn0H4OlDX2ER/eO797Nzg2W0hPnRBZhj8gI51fKwN6cIFdgXEoqA?=
 =?us-ascii?Q?ho6i+HQl2fQJbvaJu1g5TF/YuvF0jGA9KZHm4jolEEhPzj0sto0HvDgbpzb/?=
 =?us-ascii?Q?aM0CREP6gkBrLu0ojj3n6JPCTOvmjkclPk2S9QZgPzwEDjDrXMQbpD4gPXMY?=
 =?us-ascii?Q?3Ap8ly3bb/zu/tI86ArPEKXdbc8tzkThM3c5z7ygwqpS7pQyWY7uMBcQjraR?=
 =?us-ascii?Q?1ysfzf7eKtJgEn/tl1+p/nmJM3i+L9vNpN9sTpKWO/4SieyEb5GBLI8Nnzk9?=
 =?us-ascii?Q?7QV2u5TUbH92V9W7t5GSFgtXPMI6qHzoC0vrMYQt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afdc893-90a0-4c46-7196-08dc076f8dbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:38:08.0174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eMOVhCFW5PYPWtctSfINdkIVfbFSuEe9H9vWAJ4X9LpnueYvwEjI+PIzBzqxzRdmoSYV95XwEssR3W9u/SGKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com

> From: Tian, Kevin
> Sent: Thursday, December 28, 2023 2:38 PM
>=20
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, December 28, 2023 12:14 AM
> > +/**
> > + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> > + *                                       (IOMMU_HWPT_INVALIDATE_DATA_V=
TD_S1)
> > + * @addr: The start address of the range to be invalidated. It needs t=
o
> > + *        be 4KB aligned.
> > + * @npages: Number of contiguous 4K pages to be invalidated.
> > + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> > + * @hw_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
> > + *
> > + * The Intel VT-d specific invalidation data for user-managed stage-1 =
cache
> > + * invalidation in nested translation. Userspace uses this structure t=
o
> > + * tell the impacted cache scope after modifying the stage-1 page tabl=
e.
> > + *
> > + * Invalidating all the caches related to the page table by setting @a=
ddr
> > + * to be 0 and @npages to be U64_MAX.
> > + *
> > + * The device TLB will be invalidated automatically if ATS is enabled.
> > + *
> > + * The @hw_error is meaningful when the entry is handled by the kernel=
.
> > + * Check the entry_num output of IOMMU_HWPT_INVALIDATE ioctl to
> > know the
> > + * handled entries. @hw_error only covers the errors detected by
> hardware.
> > + * The software detected errors would go through the normal ioctl errn=
o.
> > + */
>=20
> * An entry is considered 'handled' after it passes the audit and submitte=
d
> * to the IOMMU by the underlying driver. Check the @entry_num output of
> * struct iommu_hwpt_invalidate for the number of handled entries. A
> 'handled'
> * request may still fail in hardware for various reasons, e.g. due to tim=
eout
> * on waiting for device response upon a device TLB invalidation request. =
In
> * such case the hardware error info is reported in the @hw_error field of=
 the
> * handled entry.

with that:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

