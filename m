Return-Path: <linux-kselftest+bounces-2512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDA81FC9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F72A2856D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E028A17D1;
	Fri, 29 Dec 2023 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNl1mCa0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47656128;
	Fri, 29 Dec 2023 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703818598; x=1735354598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6AqHz+yitpGovPm7sh373gKBm/5MucdrL+HCaveBYSE=;
  b=NNl1mCa03kyb0Wzv2MsGSHzMfv1M6cJvRIp35aTfaAneMxuB4yjoaALS
   2ECyAKGZPbaVfMDa8QyXCjU00vPlA9sNj8hXOISlNZxAq6Z/J/XDxnodM
   4JZRdvc9YzEtknz7yrgWNR9suvUArRY5PF7TbAPWErolkdPXKgxpQjXRS
   j4A7bjw3uFnKHqQu3h4LGZ6wwrjXY4F0+mp54cSWeD4DQYI49zGdSxAHU
   83pZ9SVAWcgxFIzd0P7N4OIZvpFYiBaVlbFpoCELZ2um8Us18LP05x5Sj
   +C80dv93zg2WmNu4XU2N3mQOr5FFqJfXbfidsim4QzIQFPx9hyOCCeCBu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="3910373"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="3910373"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 18:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="782200454"
X-IronPort-AV: E=Sophos;i="6.04,313,1695711600"; 
   d="scan'208";a="782200454"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Dec 2023 18:56:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 18:56:36 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 18:56:36 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Dec 2023 18:56:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHS2V0s69/Xv7B8V3vQxETPT7GQZGxhVT/xmLotMuhJEYkF98Y3CZmLFtSGRguJRkDEBhyhwqMTxqPGzl05EH+p/xojOQ6gfmlzvpZ7x2RsMF3DwHef3PrYKP01Ddv4fc8/tgcBH+NeBIxfO5jRCYXX2xl9/oX0n3cj+fBWUNruGo/DmTlsC5cHDHKA4S+hmaYemeJjI3qXrlj/R3PoYnJ/mc9DV5kyv+EG+exRhcmZ8I8/TUnG5JIEIIDlsYc6Wfk+0nnRb8bsJEIhVQBQVqinzeCR/+mp+OnaLgoCAwPW3rl9siZrprlgzDOIYE2k67+ySK+PIVTnXH2yWXAXZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AqHz+yitpGovPm7sh373gKBm/5MucdrL+HCaveBYSE=;
 b=CKnP+b9OZVTq7mrgg7JnSWlKlRbIv7qsbKiRApdi4ythodFxVmzMq2M5UGbwMygWwAUJPM0jAMONtXQPS4Ga06+FVL8FCRuQrvBV2QdyP2A3YrvMh3+OXF24oo57Z656WymfFXZlSFmh/F7ICEdYOIEzR3OZwe/XOfqwCAu6l8wqgZBfaW45uCSvWh1cE0pf60OsmKEuQAxBBP3GhV5KN5AyjelMEyuYxrCalX9dmjtouotOmGdCS/I5BXBepFYU0Yf1I5jSb/6F/ltYytyxMQ4GpciRR47IHrcCalhGZPLnbyX3djHQJXsW6M4vE0hnDAeJUafzOKW8i/BJbsc/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Fri, 29 Dec
 2023 02:56:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 02:56:33 +0000
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
Subject: RE: [PATCH v9 10/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v9 10/10] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaOZ+DOekIqXFdJU++QchNJryoTrC/keiw
Date: Fri, 29 Dec 2023 02:56:33 +0000
Message-ID: <BN9PR11MB52764756BB8164C25D6127B68C9DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231228150629.13149-1-yi.l.liu@intel.com>
 <20231228150629.13149-11-yi.l.liu@intel.com>
In-Reply-To: <20231228150629.13149-11-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7024:EE_
x-ms-office365-filtering-correlation-id: 01886be4-3195-4fad-1ee4-08dc0819c440
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9E04rb9Aqs2ZSNT6lIIp8ag6EGdfdPpHEjGNwXl33pZLT6Zz7ceBHI1JcPeyvpUWcrOWzGf6G2pqOEO2lKH0hrRIFisa8QRr3rJab525DArusp5RBsyfGhNWUBxgznK/zavz0sAN5UVOhRWJD9tVpE6mG6yrCY6Uz56CUAnZz+7kU6EQWAGVb8ybbyqalaiREpNuLBw5EByGA3zMNqXeR6mIdG6mmzMj0vvu9foa62gZFWP0QX7uqktgdrZykclwr/hvXVV1wOHl2N3rZapmc1eN3I3wwgrACFBLflRjwbhTME87q9NhJvrdaUjiQk9GkUnhpNdWoLzQMVHHwZYGVj/OyyH8jmolMw1Ec/3KR5K93u72CAbUH9lb+3UhOMLNDMSF8wHrytIYIvxpb3mDZ7E/0aG7ugJ6wFFb/1DkXli2bmZlsmy7wONPpwKoUF5DzspofuDdzfpzzxj+PINhrbm131cNnKJ2FvHmWZq4jIo+yBroT8w9bGHwVMYT+1DjJdZrssvI7c25E5W9Y4Qdi/lZ+vqcaY3a0j4Fs3do50VEZjqtpkZ22mP4j0A5sRv3XjBHdjZLkq05vNnuG1VVtIbJm7rq6/RcfJI1mpT2clL8maW7U4UFyWUDeUFZdt0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(71200400001)(558084003)(33656002)(82960400001)(478600001)(6506007)(9686003)(66556008)(110136005)(86362001)(41300700001)(64756008)(66476007)(66446008)(7696005)(54906003)(76116006)(316002)(66946007)(55016003)(38100700002)(8936002)(8676002)(83380400001)(2906002)(52536014)(122000001)(4326008)(38070700009)(5660300002)(26005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5O+lVdjVulf8zIYw9we4Vw0MXhX4CeP7ycSABAGa9yAE3crZFX3kCzoI9a3A?=
 =?us-ascii?Q?uAWymdJHJFmpUC4+IEQoNZsdVtwjZ/rBqNDGhBWf9DjG0jJyKZnKk4R121z8?=
 =?us-ascii?Q?CaqlkJT4w5G0ScDQZ7wQZnOhWeLrrOKbJOHUZK8ImFvEV+bwiVK2MIkVQenS?=
 =?us-ascii?Q?O2cfQwFNkiLifcTPT5d2wzeRviE9a/1R/Xg+lat0njLIvWODMbEv6GLiGZFa?=
 =?us-ascii?Q?TpO2IJzeNflmLp5/9ay9wYYzmCIxNkofNbWQL4LZ/uWHCSfDKDC0UK/9vxuR?=
 =?us-ascii?Q?Gaer6kjucEw0Z581uZQu10tzYYA9zaw3JB0gH8Xkc+gkjgVaheMXFqI+wBCF?=
 =?us-ascii?Q?dslO9w5ZATZF9kksiycmexdRa6BksVhxMH4y+Yq4rE7zpGn9iKjF2SZ6oTBD?=
 =?us-ascii?Q?RJvB1SDRlUrOJ7LUqG70e8v0UF03kj1INjduhqPiaBMEIttmXMUsvQBW6aNU?=
 =?us-ascii?Q?2Ehgw7+E6Pw0euR40RGAUHfSNQGDO3ljy6GWaN5DapxkMacmPQyhgkN7qm7u?=
 =?us-ascii?Q?cDw0uYIuF3SdrNDl1UF36bkN4YY12qvl0QD3cAIAb5P0jPV5XlJSLGLNqKHy?=
 =?us-ascii?Q?J2DlLU9Gaw9J9j3S90QcrUa9CiEckEdLgCsci+QQehDrDVkUmJwydSR/Yhp2?=
 =?us-ascii?Q?HpR8rkgJf+jitS4x7mKFhWSwbBKjzu7jPYdlSSaJ/VXHgd5gllE37Jh96BWq?=
 =?us-ascii?Q?tXfYIhs+u2OML24Y0fE35uMDT8Lhek+QyNMUM85ndF5KstRtQAdJzv9eD254?=
 =?us-ascii?Q?OBjFPUXhItE45sCC83MtVQIMWYSNGf+xcxeOdT0ymjMqU+dQZvab27mOTHgg?=
 =?us-ascii?Q?WprxOej1ick6Ly71PpZ4Hk2Kr73P38rh4B49FCJY6suP+gw01LEuJL8l9P/q?=
 =?us-ascii?Q?rJ1pKJJJaVYn38P3UW2kLW95fgj9RSGSF+sskR3j2otQDxbGpPv7SghsBIq9?=
 =?us-ascii?Q?sZvf+/PxjIxptBWV0Sg+qK51mUqvlThGPviCDWXdQlX7O/RF4mz8jl34r/7w?=
 =?us-ascii?Q?2bJSDenqRNK7q5XVVLbtNXCUFs/KAR73k57luBlArryZRYi70r9966l6Wn2T?=
 =?us-ascii?Q?d+EBUsQkfNuc386l8f6WD7Lo7bkTIQroTGEE2tAZJ3WxaYroMsBu18xsY4LD?=
 =?us-ascii?Q?kTuV2IjvMsbR66n3W5RFvd7QSquHF3lBPIBIq/A3ktkWrtjR/UQ4cTLn/V1h?=
 =?us-ascii?Q?L5Q0bMb8JEbki5qYWfhYwmlPjuX1RkkpYd8gmY+n+AR5Ft/cy9+SgWSvLFvh?=
 =?us-ascii?Q?5VgzTc6jfpWRlR6s9gvb/3b7tv695JKpONyo0or2S5gdjzUCrE50VN/H1yWi?=
 =?us-ascii?Q?+OfZ7r/sABpxN+I6wd8yGvPctgw+lipiabFSw3EoSXyXaORn5kyjBucTYo6r?=
 =?us-ascii?Q?R8xQzPyyckjcuTStiPwa6EkNpykrxifodT7IIektQKHmHG94exDWcp40z2DJ?=
 =?us-ascii?Q?ZQcBIorKycikVa5F4XzY0LijcYXNUiltTD7IGdC+4eudf1rK+DJz2FTOOUvd?=
 =?us-ascii?Q?w+m6j3gXoEW9hXw/KtF7mCZLnEIbjktjczh4FzK/qqix6pU9XTatgTbCYbAy?=
 =?us-ascii?Q?wVPiLakurj/VUYOpNcpINqhLsaluvz9azgI1ky9e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01886be4-3195-4fad-1ee4-08dc0819c440
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 02:56:33.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +d/1jz3lzynKozV9CgsQKDfHTVKO87QqHtqma+uOEOvAZu9RZZ745HGEkReTw0WaL0uhRCb4a7G3uJR/fD+GSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 11:06 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> This implements the .cache_invalidate_user() callback to support iotlb
> flush for nested domain.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

