Return-Path: <linux-kselftest+bounces-494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ADD7F6AB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 03:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CEB1F20F20
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEE0A34;
	Fri, 24 Nov 2023 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CehiKhVZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317CE9A;
	Thu, 23 Nov 2023 18:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700793394; x=1732329394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8VqL5K+eJs8+kOKs1WO9BO1rif7hDPd/gDUYFW0vAKQ=;
  b=CehiKhVZJTbCsmEcZlNj/3dDJUqse3AJItBwLrXN2pJlNZ//KTv872Ze
   q92p4IGiveX0ApoXRWWbKlNLbcKQ6UrgZucfeJWMOolhWskObyNSofDAZ
   Cl+XvSYduCDMVcnSh90gGe8cd6v8va56KzrpX1IfDQaIZGZr7RWmTeGIA
   dynyeYNOIu/qENmIdJ9hi2Q/fDJETmxNmBXz3v+iiDCuKaRCblyN57cjA
   0Z6PY+Mi2Tu6SC5KH18K62j2U6Jd78D21gpHhEgHhCeyCk+nXPODvYSxO
   xCW7YkvVIb/c+8aLcqzSRanOzJGSZYwJiv0WAR/MY9wfyEXr+Sivqlg2x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5569640"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="5569640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 18:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="833567912"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="833567912"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 18:36:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 18:36:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 18:36:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 18:36:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 18:36:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V45bVBGPRNdP9YePS8VdgumSxJoKZze4wZNY6TJn1bTH3lOuCJR5LWhGv882FT/8B5OOQ8wGos54vrQq3bFNDJmjgLIlDK72VkICCuNxd6hraGj/sHjsU609myb2YSbYiUWX5tK+HkLgqBhajutDdJBDzAZX2nROO1rcz0UK2Gs1nVW3vr/FaqG25jRDYAkDio0FkREsB7BV30M7c1m/A3CCmZyQjXiDJowxu37fka3aGm2jvv9wt5yBxkkzDCyv2dE4FXUoJVfJr6WtyN9LpJZsSkQ3jVGtgM46Txl8h/nAcOLYXngo+/J/KEPPv7n3dP2RN63G+JpmUuuOntvNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfriv3HDFZI6bEe9vg5AvfwGav+yAidN22B/Yli1mLM=;
 b=E24mDE7LrmkU7D6ZWtWe/9fl0IKERSuSbJUnNdjlOmBL71yegwLJdpQc8zLYMkOXAiY/65aE6R2vByX8iWjnwYDtjQDPavxSF6/PrDWmUz3hAlAjdo6VGlsX7VBzGUBvD713iT4MxDpX5xigKqC9EDaaSTdIFcyQK3RipZtjNCZtva9Ezj7wXW+Ks3209b97UTWOa6bYdz0L4vR5YcoQgh6W0eYk0RKPW/N1cWJLJwpTG3HKs5XbyRKGpwUuSgaWFLNuzNeXwVcW4A06YeJiYOSqUazluKrguMr/ZZ7IUmfs6TX+A2Vm7/vbwXDcdCjAje3XX5P/Qoft+eD/xnJuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8561.namprd11.prod.outlook.com (2603:10b6:610:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Fri, 24 Nov
 2023 02:36:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 02:36:30 +0000
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
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wIAAl++AgACaJQCAACuAgIAEgqsQ
Date: Fri, 24 Nov 2023 02:36:29 +0000
Message-ID: <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
In-Reply-To: <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8561:EE_
x-ms-office365-filtering-correlation-id: 052858c0-f83c-411a-6caa-08dbec9629e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AaIUBLJy8kkkyp4HBxlvNSBSfv1TkEq9jiiGBQW44FdDnJQ0gLhcvD7x9MgMHIAUOjSopdrapAgk3QxJSrS3UMyoYzfJFG2Rl7UbPidTcNBAQy3qwvtfyWAoje8EYrEbA1N/4pR7t+5QOB9fbcikg+5U537ll+UOIlmRKKEppZH3XiPv3IkqV/VlCn9HCibNUVSaqGLiUlyrkAzcEJBtMDAHCyTss+2ScPyZSNjn64a88Cr1Zdn9O/HaGHzPPakwaeqo+EzRNzLBnXLGtaVdTkvHFaxJhr8GEYIbqBNwnxPcUIB0kjkZpbJseuk3V9KtcITghFMq7IbyYQHlTWUOnULCG2SOlkDV8zPXA3ERnO7Pz3RQZnMtrH/Xtn2BiNSoUz+5lJDWvZYXzO2lm+7An/0pxamW8CRmzkfBUIZvVXcfSk1IhQ+jDmbOKs3TaV8+gCKjdarJxJYxRzZPOju4y+g79trJwbewuUo3L8AQ6oi/iYJJpd+Jzffmyq660iwpSticX1HeoJ2KJGxv+br24nOwEX+ypxaBFAaqlb3tLaR/RuhPMlA2MIkBBpaK/n0Elq5v/6zfVywe8zAzv6UPuURYCbi1kuABUtIaqrQJ1TB1l0zSyRIEAIekFHFDywI5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(52536014)(33656002)(4326008)(478600001)(122000001)(53546011)(7696005)(6506007)(82960400001)(71200400001)(8676002)(316002)(66946007)(38100700002)(54906003)(6916009)(66446008)(66476007)(66556008)(64756008)(38070700009)(76116006)(8936002)(26005)(2906002)(55016003)(5660300002)(41300700001)(83380400001)(9686003)(7416002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mRP1DMK2Fq/Vstp1gXs5B0w9cND/RzbPb+JNpnhWjXMFrmIGxSXwPyHRz2dE?=
 =?us-ascii?Q?e4vTGmmRe92qQoQISU3v6K2qCJKTeH2gH/eJuvUSGhnuzf5sFhgW081HiW81?=
 =?us-ascii?Q?964vEJns1XiN+DDpQ+gTMNzmIYoIiZ4PEo/0mTBRKJsRlrQ2lVwI/mXmoLLn?=
 =?us-ascii?Q?E0WzTBCiVBOxWUhMwioDb8mmUW5yenFiGdoRB/SFXNiR45dtdmp920CN+x3j?=
 =?us-ascii?Q?DJhXfSBAtF/UZIIlQ9GrseQhp7CKOn5JUZlsTjXSpEp7RmkQm2N+4lt5LsHw?=
 =?us-ascii?Q?dhCvMMnesnNLB580izUkHFgJ4dXVMuz5N4tZZhVCEbs5SfmQyNRkHjAe9UjD?=
 =?us-ascii?Q?I9JQXFL4FeO2L6d+Z5uoMSA5eTmHNjGAGJlgXZo2gk6gTZxiZH1gaP2KZcYl?=
 =?us-ascii?Q?xAWfZtkv6tfjd0f9F/wWP+edom9PvDmeBqVDI5KsANhoAfOENHlkF2EBuKNl?=
 =?us-ascii?Q?qT8kJMhzBEgq617HfLLMlvrXYOdgzGjepHR/Xg+N4WCk4d5E8jeVJFJwnnOu?=
 =?us-ascii?Q?yvtw+8z6/hQJhqhQV8dQN31nxzS9hi571o2M7ANFCP8vdh3Myyx1FGVv8VAT?=
 =?us-ascii?Q?8UyWzazo57sNpPHo3Bm8yyMJ1cCyQOOeRreAjnKOTMgCNNZcMqGKyDOQuROa?=
 =?us-ascii?Q?j7HK3Pp545OkABFGlcI9iVx2BnYszGyBmCju4CSTlHBZCOBgC8cpeC+d8imH?=
 =?us-ascii?Q?GdEoeAGYorj+K/r3VKnb7UShidPQuQBab7kGIGItmScBy1vrN8tcxZoy0dY3?=
 =?us-ascii?Q?4AO5YsgN8M17Z3oiP+J+8AREtcaqWa9alicw3bGrkNMICnABK3ZWCYdzC46H?=
 =?us-ascii?Q?ZWLN8WQa/yxkRGnEf0lo01rYM6dxOlIGcZET347Z5UhiFmSaZLMt+chJeCIS?=
 =?us-ascii?Q?QXhfTCc4+qS8gEXgg8h7Pem9QQ6CiEV4GoROTEylBTdX/QYFkcoZEBiQ7v+8?=
 =?us-ascii?Q?CPZJCaHapUHYRFQhrYLBhhbEO5ITDdzC5NF72Ca/Cz6zNbVYxU591JCTasux?=
 =?us-ascii?Q?UbULn6GNf2g3k9/L2JiSC70Sd+WK+FLCQsdONXB9GvckQtjeOhiDXflu0nfr?=
 =?us-ascii?Q?YjsSQOmdt1yWlTss8kkxUgoG2SGZ2FLcSrr7OHuI9tgT62VickSKjvSjCsNi?=
 =?us-ascii?Q?V3bzPgsV2r6Zvz/m9seWSDyldQu6SI86cb8pZ8yVEU6DjTvxl9l2hBcTLgaL?=
 =?us-ascii?Q?Y7vYMHb5bOW9qOrAE2/AE/HGrvX2g9oBW3B4MUqbz3+EyrYuLxA3lt1sXGTB?=
 =?us-ascii?Q?KwxqpjM33BOpbCrfyHsURrSMpoqlgE/CBbYTw1Vzwy0QZrrxx5OyLKO6KBN2?=
 =?us-ascii?Q?HKHgSFTEbXOly5nmMeocQAt13zJZC5FPxz+uPF3CnlSlxV5QqtjCAnj0UumO?=
 =?us-ascii?Q?SCGCMLe/tux2BkpyqD3QtxKEJ+vkPGQosyUsji0Is5Vn581jr7uBT+Wu0Stn?=
 =?us-ascii?Q?Ws8crL8KAtBGopkPCWorVTcrrP143ktDGi7nbCQJMitpXAu9qtfpDx7+CFDn?=
 =?us-ascii?Q?st3c+RiYc5azUnYb01BpwJuv2tnGIS+lm+1RFlG7ts4iM0Yb1B74HacuqTqt?=
 =?us-ascii?Q?+dvnBPBawb4nQKkBzmYgj7TSj6/5qUHdIFbJ5nrD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 052858c0-f83c-411a-6caa-08dbec9629e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 02:36:29.5068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzbjljGNKFlbJphIg/n7jrcw3eCvlnc8Hzg89KSHZTJUPwv9WUfxm9gJQEvJMpPFoVKChF9+TPor/Wj8zkfwLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8561
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Tuesday, November 21, 2023 1:24 PM
>=20
> On Tue, Nov 21, 2023 at 02:50:05AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Tuesday, November 21, 2023 1:37 AM
> > >
> > > On Mon, Nov 20, 2023 at 08:34:58AM +0000, Tian, Kevin wrote:
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Monday, November 20, 2023 4:30 PM
> > > > >
> > > > > On 2023/11/20 16:09, Tian, Kevin wrote:
> > > > > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > >> Sent: Friday, November 17, 2023 9:07 PM
> > > > > >> + * @req_len: Length (in bytes) of a request entry in the requ=
est
> array
> > > > > >> + * @req_num: Input the number of cache invalidation requests =
in
> the
> > > > > array.
> > > > > >> + *           Output the number of requests successfully handl=
ed by
> > > kernel.
> > > > > >> + * @out_driver_error_code: Report a driver speicifc error cod=
e
> upon
> > > > > failure.
> > > > > >> + *                         It's optional, driver has a choice=
 to fill it or
> > > > > >> + *                         not.
> > > > > >
> > > > > > Being optional how does the user tell whether the code is fille=
d or
> not?
> > >
> > > Well, naming it "error_code" indicates zero means no error while
> > > non-zero means something? An error return from this ioctl could
> > > also tell the user space to look up for this driver error code,
> > > if it ever cares.
> >
> > probably over-thinking but I'm not sure whether zero is guaranteed to
> > mean no error in all implementations...
>=20
> Well, you are right. Usually HW conveniently raises a flag in a
> register to indicate something wrong, yet it is probably unsafe
> to say it definitely.
>=20

this reminds me one open. What about an implementation having
a hierarchical error code layout e.g. one main error register with
each bit representing an error category then multiple error code
registers each for one error category? In this case probably
a single out_driver_error_code cannot carry that raw information.

Instead the iommu driver may need to define a customized error
code convention in uapi header which is converted from the
raw error information.

From this angle should we simply say that the error code definition
must be included in the uapi header? If raw error information can
be carried by this field then this hw can simply say that the error
code format is same as the hw spec defines.

With that explicit information then the viommu can easily tell
whether error code is filled or not based on its own convention.

