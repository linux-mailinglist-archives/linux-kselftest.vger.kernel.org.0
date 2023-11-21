Return-Path: <linux-kselftest+bounces-356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113E07F242F
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 03:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5BAB21854
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4343C07;
	Tue, 21 Nov 2023 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niYbVI4U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE940CB;
	Mon, 20 Nov 2023 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700534928; x=1732070928;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OiAuBvNvNBUWilHTsa+mIPF1Zbrt8eA/nmfUJvgp1JI=;
  b=niYbVI4Uj6qrQBnlJvoINMpkjJ1mSoSe3LSBnBY9oXE+zg+yxzT7NZea
   XoOidIdw+yvXlmqL44lgNb/hot+lYkfsoPZUYIuSaRuGt2gPO+x68LQw+
   Zh84lH8ZpGVdOgP5pgMx+FcpM5wIPMQe6el50PFvpbC1paU26nTjC3ca1
   uJpLyA7m4mLo2PrqRC2iTAHAZPspKvX4ZVaGqts6UYzUWbU61cOD3ezYM
   DgHSN1q2GLM92RtKddyc3Jme8ocXxSe0GuFFB/3UXqIyApXEy+KPAmZ/Q
   WfBRgyrKuv9QTq0bpwvQMQ6embjisIkhrSRagw/r25fbe4oqcsud8iRrj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456088386"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456088386"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 18:48:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742896571"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="742896571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 18:48:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 18:48:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 18:48:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 18:48:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2Ddtq6HYio05LjhWKPWz1cQ8VxInojVSuQh5p26TBePQfMt43AyIPAGh3ezvlT9TkDoyu+Wgy8wMZIlVci+X9IGnGHSqZ6jqtf/ZO28XIHYzfEZpmPKAR3tiEQ6MiJWoly/xSR/iG6iyrB3YOr+B4YYhgRc6yb6vJho+r104qlZMeyOzAII5MewYkUZQOq9VpMseB/Ivk1sHOWsGmv9DmbiGgc/v8Vo+S8wVNKyu+xFq4P1KXaV3z7AiwCpc/K0jDXIbGmxyueVLDICG8I0raGJGrzGyWg7YQfkQ7CPFxg+5Qc/dlWNX6VZ1HcUT37hDUbSHFAVLI6kXLBDccpvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiAuBvNvNBUWilHTsa+mIPF1Zbrt8eA/nmfUJvgp1JI=;
 b=VXriQ5rlr20iA9LtzXsrr2zUSDHQkoFEVI4iIKtIjp8RmmjHorv6uiVYVuCl5rjr0osb8QO/TweaofEaf9WxDi5NwFfVOLDGLwZaHeXEXVJTJBM7wKgB5NQ3mEatPArtjuW1aqViCenLADmONhr8UZaFuCD5D6UKsS8O4Lda9nQ/Yi1ekeSuvSID4BlxQ/kuxRiPTc6QkYxO2MS8McCT2QvDso3bTIyAi9jrOFrF6NihxvqEZ2ok+6pfI+kGXtMtq5RV0iU1fja+WTy+1K2Ry7gCiYFdhTulebS/fWvuozmQxyPVVYeu830a22af+PqqbjQY6K+jQNjwDkOPEso5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:48:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 02:48:40 +0000
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
Subject: RE: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Topic: [PATCH v6 3/6] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Index: AQHaGVcISf8BaZEQJUSSGRR/7aBQN7CC4RvAgACZOwCAAJ1hAA==
Date: Tue, 21 Nov 2023 02:48:40 +0000
Message-ID: <BN9PR11MB5276B273F59D66A757B178AB8CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-4-yi.l.liu@intel.com>
 <BN9PR11MB52763299F886D4A534D6E0BA8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuWdEwYw+9uAaUz@Asurada-Nvidia>
In-Reply-To: <ZVuWdEwYw+9uAaUz@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM6PR11MB4612:EE_
x-ms-office365-filtering-correlation-id: e7bb829c-de4a-4356-a99e-08dbea3c5e13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fpt/lkk6o8eRfMe4hoU+km2539iG9XhSIZ1fEDXfquk4tNt+2piQ0RXYPtHFVM+JN/lkcP3Z55AE1xLX2dsGiUkr00vnzQxDh/2E4EqdrqFmGIKosqdczOdtnxrWFz/MqkCyy+rNQkI6wtd4XaaZG96lcP8KWOo8VwgO9Kr2+HiP5MBI7RdnSLk4yHlS7fuCcN9x6JMICaE9C0ehnlj1sBfBCrXyHnpfTZOU4ScdxGGM3zyR8P7Dej+7SUn0ybS+XuF22p+SxQ3GCwbchpDHDmSELku1mF6Kl4AF5fTt61I8DzAQ3q1AEqxnaeh/Si/wW5nBf9rfizNXj6kTGwM/+JEA+YTWLGyzwmEsw4vFgj+0k2CiVxBViL8rm+7P0BX5rWNIml2qfUUT3k1pU6sGh8FgdphMYjx4kkrMKYc+wk+FFPEi6sFKlaPptvBKvU0/l6RSFHLhFzl3IjAvOJ+EOKSVln/NhxczKEU22SrUMLF00iPEL5Aei/04b0s2PZFmcFDK4/viMJAhgJcV+bt56mx081SqiayH51qtK1L0wo5qacvo2Hyu6vUJHtG8D+6AnCxQcEHP0nj/P9f67l7NQL/oAsr2GSBkB3hgLhspRk2rid93Dlztkb9UqqsISkHC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66446008)(66946007)(66476007)(66556008)(76116006)(6916009)(64756008)(54906003)(316002)(7696005)(9686003)(71200400001)(6506007)(26005)(478600001)(38070700009)(38100700002)(82960400001)(122000001)(33656002)(86362001)(55016003)(2906002)(5660300002)(7416002)(4744005)(4326008)(8676002)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n0rVZN2KLNh3JsPz/wc5sRXGuQxYFcOAClSffj/WUkVULYJ4oinIFLba/lJs?=
 =?us-ascii?Q?8xh/F+YiUfHj5aD1FiLUwG6yscMgUggASinpypZYRvL3zWmOe5EQchfIEq8q?=
 =?us-ascii?Q?fR9i3SZBmmOvdM5HvpO8RmZXBwL38Iw7YQiFUMkOuRohIoH2ntlvsQl6SWVJ?=
 =?us-ascii?Q?F+WuVXo84VjQHMfMfG5WLtS7kUwH0hLmSn6F5fjIO4bthTZ8nMnh24rRknj8?=
 =?us-ascii?Q?Uf3cDiFxHX3XOgXSXWYc89aXK7QNil3KSfNNXb87EyGQY5fFd0IblCCY61eD?=
 =?us-ascii?Q?iYgY5VQc67qjh5bzzO7cfTQ4edkq22tSFhM2WPRtt0xFBOs4RSqtU6x6W8b7?=
 =?us-ascii?Q?+6GjL4YaV0pj2f0OyFzm4qBBuWFnSeROA9kaU1DSCGGrOszNEzIG+NYBq2yL?=
 =?us-ascii?Q?naCAROracVN3ijw7ce/urVNTzmmhPKxl1T0/2DG6SxvIbMYvt883y8CSpJpw?=
 =?us-ascii?Q?GYKTVrKe4vB+2ZaGbt0vqnQQIsm5gcrPz/foljCFqprcbrccqxxk2FJQHZhJ?=
 =?us-ascii?Q?rgyP4zT0ba0No/AjYPV1UAGs74vwzadyFBRtaCex8dSy3k1qGXiHeShE2lKx?=
 =?us-ascii?Q?+BecbqyzF2yq4vP2sVu1foBdybxAvxY4BeVpNXbofDCYHwsgMU0SpPsJMJll?=
 =?us-ascii?Q?Ty080S6+pSP5Se/HlcdjZP9bRxvBJHhHYPrMZ7iqnQ+j4gyeCNznUT2v2aiP?=
 =?us-ascii?Q?lKXq2MXRxKGbNqNuUu74Xhq6PzIfS02IGIAQ4et+30eQsMrKzHQ2CDVoujEK?=
 =?us-ascii?Q?3E+W6bQqCyo/XvVRTxkJfrVZ3jRvVRveZFH1BTnBSoqqPb16NZpV1AM4bcXt?=
 =?us-ascii?Q?C5yj0cpiFDrXOOcEA3v6ZBGeoGhD8N7CPavvse95m6RCdh4dD2VXEGVZn1ni?=
 =?us-ascii?Q?oxLNFiOdWnX0YS6UqZBre96iVjW8V3FZKoMD4O2nT3d0hzB/5/YMavPC9x49?=
 =?us-ascii?Q?P9gjVykmNl7wwf5GbBgWcVhOtmI1EipwL6BWCb69ipkqtrRCOaUuAa5lTHai?=
 =?us-ascii?Q?jBjbDPmi+cE9fOXsXxWto+TstTErTXzvQdejgB3A5p2YZZm6IiVg8wjDsLyJ?=
 =?us-ascii?Q?eCwkvkb/QVpGJQJ+Uqss4T3MebjPHtxXGRTiNPA73ESK2k11/C8SxNWQE9Qy?=
 =?us-ascii?Q?s80XNVYSwPpft+8L6GWP5qLuaim60kyBzR8qDQbGN0+qMiSNHdyW3Ni4jG6R?=
 =?us-ascii?Q?tDT2vgVSklmvQS6p5Juq2GGMkTWH+by+Sqov1ldkpyqBfHD4pOKEEBcgjwJv?=
 =?us-ascii?Q?fJSMcgjIWbJxBlNuDgjClTRmwEfwcjBsGkODRIw1oYwqjD4z3dcJk7DoUy1e?=
 =?us-ascii?Q?HvWdkDiTwynUNiO/Kj6+SH+3gATP7VKPXBEIn4AgF0LXC3VgTkd85/sSgmsn?=
 =?us-ascii?Q?vAqXH4OWqoEtJT2pg7210bUN+uddvNrh1hPqX1YoOCb3Nc1CU14l104MV9Jp?=
 =?us-ascii?Q?xhFhYk0UiISxWzcXzW0SP+d5nebCaqaN0SA/0ItHLpaCE6HDiykPSZQgyqEt?=
 =?us-ascii?Q?/7Miazgz2RGOSCe9MVEshXwqtmfgjfAbvnsqMR0fRFpWQMXrM9pnQ32XzDpn?=
 =?us-ascii?Q?5Jekj/WnsgJzGI1Inv7caf/OoEIqhGkXJo8Ff/mE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7bb829c-de4a-4356-a99e-08dbea3c5e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:48:40.0338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOnw/pYQaA590/zFldq2xoRkRb0kTv3RzJCNdPcgIKKJHsqUzaO5p5+38k7h6T1iVzYImaUATNFSIytaOgBm9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, November 21, 2023 1:25 AM
>=20
> On Mon, Nov 20, 2023 at 08:17:47AM +0000, Tian, Kevin wrote:
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Friday, November 17, 2023 9:07 PM
> > >
> > > +/**
> > > + * __iommu_copy_struct_from_user_array - Copy iommu driver specific
> >
> > __iommu_copy_entry_from_user_array?
>=20
> I think "struct" and "entry" are interchangeable. Yet, aligning
> with the {__}iommu_copy_struct_from_user seems to be nicer?

ok

