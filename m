Return-Path: <linux-kselftest+bounces-2346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F081C3BF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 05:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EB01F25688
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A30B1C06;
	Fri, 22 Dec 2023 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkn6wGts"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E120FB;
	Fri, 22 Dec 2023 04:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703218198; x=1734754198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BiLc+dD6mKdL4S2KGj3g6nY9O1xZO4GeKzW82UHMVGE=;
  b=kkn6wGts4K4OlTXZunPNL06RacBdNnJnjZTZqS1akMXUFp1TXzJg8TT6
   kQyBo8Aak88jbHs4HSGekf9rP1rysA52wKOUJ7QD9OPKhhyN5PNpbNDrf
   tTCS1dp2RPvjXphbU1C1QpvNc1tR46B/uje+eBQWdckMjHsAPEUW2xl+D
   FkYrVMFA9amkfbo0egIq6FYr370z+0QcmDGtGRRxqEnyyBFhH4igR/PYn
   pQJSluirswO5sHSzlHMIDKUSCGG7vIY2+afoOGL1G6aSWtaHCbr1G2cB0
   rctz2oU+iy4WJ3k3HUT7p2zN06hX4CfUNSuCbTco6c+cmM4AG4r72DSDB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3160799"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3160799"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 20:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108342525"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108342525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 20:09:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 20:09:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 20:09:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 20:09:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 20:09:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuCSjydGE1uTpdPV+qPnF3pyxPVDzLlxVFLy7dMep7uxScS18He5AaBB/GT2sMEptQ379pUSvz5ukqHC60FG2qL+37/SMEoR5SUAft9cXz55EBjA4AEqvhkkGx5QuPBYX8nt256OZNfpgll0wKjkPQMgR45/4QCuhatOEjYhIw7r45IHLaUyPJe0Zq2auUksECCTC1iiho59JLijbt55xXMmbuYY6dOR5KSXxcVpmXCUlaqaLdgpcnKIAa0oksfLt4bFW7HxCTAMKoZDWS++ZSa3jayOXAnkDCcatjsSkgEXe/Zvkgdrk0Qx+ubnY9kEjQotmB408KWEAkEgRzTGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDx/VIiGkBt3wxpqCbCYfOO3DPJpqhCtEhkVeMU1YJA=;
 b=UkSqaFZbyWSyT+MERV10oRkitH07ZLsxjY26jLZXANGUpq7b6id6nAKQ8sK/xQ/bXSK6a7Cz7zUsVP0P1K+my2Ap0vT4zyptDJXEqv8ifb3tMC8RhD4x/s8IEHMv3kRS6/ZNWzxHOVuBPBVjrt9qb4UpR/RCeTIGCH37lnXz68UuuRoMU8Ie0fSXsFuZYDLSnoWrOc+G5T9Qd49onftVVqwhBKe9xgqj+mLoIaGbnV9bbJzve/F66eZdjgg0CZrrrmntb3MTE+dRME6c4ZfjdzfWEB53QDuNajxNW6d8TcLk/bWrI076+9pjc2oqHigXlyhN3sv/7h/MDa4MI531nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB7033.namprd11.prod.outlook.com (2603:10b6:930:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 04:09:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 04:09:52 +0000
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
Subject: RE: [PATCH v7 6/9] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Topic: [PATCH v7 6/9] iommufd/selftest: Add coverage for
 IOMMU_HWPT_INVALIDATE ioctl
Thread-Index: AQHaNCP3ZbsWeJyCDUuVr4rVXc6HCbC0sC/w
Date: Fri, 22 Dec 2023 04:09:52 +0000
Message-ID: <BN9PR11MB52766EC5BBA4888218914CCB8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-7-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-7-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB7033:EE_
x-ms-office365-filtering-correlation-id: 287a55e3-fac7-444b-9993-08dc02a3d8da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BGL1sgfUCp6PtFG6EvzPZ3gt9DNKhz9WFK+fIt0v4o/bysC4QzxkEOiT/J1c1fUX1I1n6DLbpWcxEZ2JBggMlB/w/ebVzta/Iki1jIPye67ueW6nT+CZMHgexfwvHXJoeVFsJxRP6aUqApid164L7CQGvqX18gCeSB5WkpeeOYsUSy2TAmoM3PH+IJqqF0qA26OZAv/32BXznRyRbtjUipsYu3yKu0Lr3V71H/0cAOEhgHO93Fp+cwQMYy+x6QY8fNU+eOX70gAQCm8GkcsvP656lXbhqBHtvP3DllNjln7NIs9Yd9iJ0wadwwE6+tyWNE6SJGPVhqBlNIAnZLLpXxeduOlsFWRMjApPAaS/JdajZifmArLSD0b7sqIMuz9LfdfrrA2ZVU2Nrpd1A9lAkhn0qglNKUWdUGqREvwklnUUTz+P3bnoK/2p++vi2bV2Ne3ZXCQrWjukCeAdMt518+G3kV8wkjP6456CURsVVnOubG6eIv9gd0pGAVRHFUMQAhg8yv2Nd8H+fsBc4OJ5UZPMxNwMJnd2wWMI7N4UWt8mxy+5TiOWHUT0XKN/j5izK2JkRGq8f3qtCzYZUcjnCigwwvQk7zZGLLejoSZSng4O9yZ4I/+GpKUgnrV4y9hH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(82960400001)(33656002)(86362001)(41300700001)(122000001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(110136005)(52536014)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(9686003)(26005)(478600001)(7416002)(6506007)(7696005)(4744005)(71200400001)(2906002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1OmqQZTm33VFtqwywLW/rRrSSx2Xa0SklKdkOsbKnMXbum4IHY4/POslN9uk?=
 =?us-ascii?Q?D0ZpkdrzYgddiTby2GNCMxJ8cK1PFGLey3TPRR9yQ4CjAHEy/H60XlRFSah0?=
 =?us-ascii?Q?BPEn4X5zMv457WrPGhBoB0zfX/hNJmXw1aAUBqkhrzHLta5fW3rCQK6Juwl0?=
 =?us-ascii?Q?98mU5QxqMNFM7qstAfu2v3ThlgKczcfG8tBj6PXTeiAf+g68US5S9t/4fAdg?=
 =?us-ascii?Q?udqckFMMowcP/PEohkc7+XVIUmbR/b0c/U6DuWRIz2DayHcXoD4M9lac5MUP?=
 =?us-ascii?Q?k/NMNRSnDRyqsETN/YmFzZkW0QEawj3Uh2xOrc9EGkIHkiEbAX1PNv/7+oKa?=
 =?us-ascii?Q?wMz0I5fu13pwLOW29SgoUoc3Se+DRaREorW/r+X7T16u+Fu9OXnKbPL7uqNQ?=
 =?us-ascii?Q?4H2sWjmyFkFyvj/WTC4tG6BQ51lz0NK2MaS91M10XNPbuNXzymkVkz0k/jP8?=
 =?us-ascii?Q?tie3mJCMrlDdqv6Em+J3EGMankYY5lBc76BSZTfCb/h2CZOvUdq4clUzLH3k?=
 =?us-ascii?Q?7GPKhA5yCQ1uuNz6kkybEHPYLmeHT0P6sPhlw4Z/Bvizd9cd8iu7xgOHsW+8?=
 =?us-ascii?Q?f2sTN/1GySzJH+5g4fg8pT4XdEWMsAOIceuuO24yqOHndq+//V41Uw07/9Mt?=
 =?us-ascii?Q?gLCT+16iXRyRL838Dc71ZfFGDWl0eUck2L+y3LtT+L75DlAjHFsVqOs8mdVJ?=
 =?us-ascii?Q?ARj5/+CqeqNQAGUoyCPme8WD8yCdyQCzy42FLvp8X0lp/Edr1gRMQDG4RlVc?=
 =?us-ascii?Q?YC5NtvqUO2vG8DVkAe8BAuGXl/4uqo1JSEdJfJzlnUogceTO2rqb+5s2HumG?=
 =?us-ascii?Q?x2zLGLebtGSIFt91s9PvURGhp/Opd2bRt1/0cO9s43aiezexl9yk9VCKZYox?=
 =?us-ascii?Q?ZGtwcutowRO9odHIxJPhw/IiSd3EKQD8DqhfLgTXyasOFzBDxDja2S1AdJTH?=
 =?us-ascii?Q?Yeks+bH4fcR6xo4bM1FVgAHMQRvCpr+FGQqSpc+n9R+0ytKlwbieBVrnTfMT?=
 =?us-ascii?Q?1kIZcToMhU9aUgAGlam8OmEqeYGymrCLJG2gBUqiQnLOnW+l5sPlL+XEs8eI?=
 =?us-ascii?Q?1N29s4Ec1s8ea74EmODiAC4p3F+45Qskn0UB9owsr97snlJi/83iod3zJvV3?=
 =?us-ascii?Q?ROUrTNbqNaWG7RPeCEC8hF+DqI7HqXL6w5FW0GnQo9eoF41mmVyRX/JrlQrj?=
 =?us-ascii?Q?l7tHI9g2x/BAY1axIXZRYR1m1R3wvTaK9kIzLG8vwDgei0joS3LkkAp8a565?=
 =?us-ascii?Q?XwHxn523j229bRTBlNPkXom5VP69Ms76ROZUv0UKIvoALi02HEWtN3ncjTcN?=
 =?us-ascii?Q?u93OgKzH0pxvrVZGISklQSCHOqhRo5SWoGXWVB126qBLJgpxeYnP1xdJwqL9?=
 =?us-ascii?Q?8whyxrrPZgchGsf9Kc+3eOQ3t3+fl32WYoaUzqGLfTNXTOKWlJJ9DYi9XE5J?=
 =?us-ascii?Q?NmNyg8J123joxXb3pu0S0XA5Vd7mzKbwDOFINF4XfuIB2FueL7ddhEE/GcMe?=
 =?us-ascii?Q?rOEXAQgpoNMw8dkndBITFIjVbfoTmY9qwecU0P9oKV+s447Rayel0fsSCLqT?=
 =?us-ascii?Q?vmnx5QofDxP4B1WaEOUnAGiqJoy9+dGRiiBJoJhg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 287a55e3-fac7-444b-9993-08dc02a3d8da
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 04:09:52.0609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZpkbsoXA2M1yKKCBZLTrFa262HvNP/unwG1q4lL+bCjztOrwOwUY2iCwAlpQ48qoaLk+my8kQNsKdXUmTn7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7033
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Add test cases for the IOMMU_HWPT_INVALIDATE ioctl and verify it by using
> the new IOMMU_TEST_OP_MD_CHECK_IOTLB.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

overall this look good:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

with two  nits:

> +
> +		num_inv =3D 1;
> +		inv_reqs[0].flags =3D IOMMU_TEST_INVALIDATE_FLAG_ALL |
> +
> IOMMU_TEST_INVALIDATE_FLAG_TRIGGER_ERROR;
> +		test_err_hwpt_invalidate(EINVAL, nested_hwpt_id[0],
> inv_reqs,
> +
> IOMMU_HWPT_INVALIDATE_DATA_SELFTEST,
> +					 sizeof(*inv_reqs), &num_inv);
> +		assert(!num_inv);

this may need adjustment upon whether we want to allow two flags together.

and let's add a test for below code for completeness:

+	if (cmd->req_num && (!cmd->reqs_uptr || !cmd->req_len)) {
+		rc =3D -EINVAL;
+		goto out;
+	}

