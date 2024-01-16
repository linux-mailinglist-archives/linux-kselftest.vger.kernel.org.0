Return-Path: <linux-kselftest+bounces-3056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8304882E80E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 04:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A1C284C3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 03:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E466FB6;
	Tue, 16 Jan 2024 03:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqIj2wUZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E86FA7;
	Tue, 16 Jan 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705374228; x=1736910228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T1domyuQeZYRo0ZDjD1YZFy/wLNWNd1IgYEY768adCg=;
  b=aqIj2wUZ8LRf7DUgDbeiEm9N4ZlN9AHfNiT9bTBMR8q3S2AJh8cA7GjY
   ZpWqaA3pRFuAHODmmnVGqChfh5e0J0P+HFWF7SBUhOdvMqNlXEWymj4Wq
   iuPPwcX//mz4J8xQqWyz/IkYripAs2OZ2Kuwa/jvfbHRyaZNsLtQxeX3L
   8/vRKkkk1RqM/LSSVzfmS0/N2svNRouev3jiwwxqEUqoaAb6i8tAkmqcm
   e+13JU52SrLrUYg7BHutruUVH55/NkkgyU2nJSGzQGieE1t0JAe7qbinD
   /1AXvpR2TohoIvTMfPsT6Z3iUYoKJTDI/5B2eGv8x9rjzeOnzj19m4X68
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="6835967"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="6835967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 19:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="783978496"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="783978496"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jan 2024 19:03:46 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jan 2024 19:03:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Jan 2024 19:03:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Jan 2024 19:03:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh1MMsLkgpVk3L9A9z5EYtoOReVVjkKVDnd/0ScThNYkx81+bW4WEOI4jv2Hpm98vef7+vdLHDt5ORJS4obCdPvfB729TGJtqhoeDAfd2PN8P/Fk/avZtn4RYoqCeiw/K7ZHZ3yjK2RRFLX86gUXy/xSH464LaXoZVsRvG4oIK1Z14heQpyO0RaRFQf46Nw0xqZJDj5h7FXvpzp9wclgz3EbdqNbWw7O5cgM0kYGM7BKv3lNm/CumY7kf3CwCoj+NY1vxwgZwlfey+zqtlCkIB+T7R8UD/XI2IyhYF5tt7Slh374btM10j4MTBd/0ubK3bRLrwWneW7DNswLcO4DRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5aXa/S/EFBqFEeA9n4cjZogRzNLWS5pK1MuxD4V/fk=;
 b=MD3q2yQXjoBRs2Jiaa3cTF2CwUq5B3wPB96F+pUaKG75RMyXAx7H56Udwx0u+L2eLGF3EHpRld7oWEMXJquWJsonarpyPbJb8IIVeg/Sl9TkuBF34QcIEr2FFxP32OFPM9h+0HlU7lAghT2CNyHekTrtEbN/AzYRYCandHmxSqyX082f3aROPWVfYUTUoYaX4mWAd6fy4ofTPtkS40qbxig/GevtOoPDKeTyjamoWTS1QkWe+pHTu10gf65GsDl6ILsnpUqeOa8xj93kFM4JeZfYx7MWQ5RLDll83BDKjo3GE5BUEQ6jVeK6KWsothNdzV65MTOqcNzI8mVH5xWmaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6708.namprd11.prod.outlook.com (2603:10b6:510:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 03:03:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 03:03:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
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
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Zeng, Xin"
	<xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
	"j.granados@samsung.com" <j.granados@samsung.com>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Subject: RE: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
Thread-Topic: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
Thread-Index: AQHaREQgjuYqviKNs0qU7NFykhF/jLDbxwug
Date: Tue, 16 Jan 2024 03:03:42 +0000
Message-ID: <SJ0PR11MB6744D35289BAA619D9A1584892732@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
In-Reply-To: <20240111041015.47920-1-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6708:EE_
x-ms-office365-filtering-correlation-id: 3390522c-ad84-4086-ee36-08dc163fbee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YDrIXgnYCLd11rVFBNUzD/U2T9q+SVYZE6JQNtNuPIzZgoSU2MitTGYK6N3fIF42m/J0+UrS1jNU/r1wrVGNe7e3NSDmxBeSHFgRY9TFDH37wff2AooymkVAbamv4VCbLITmsmlZYlklFC+SMCF9lkWuM2QY44Igi1qxKCfpV/i/dnRMV3DkoVd7+ljB+WEhFBKysdhfzRQhiT/QGNK8Sur5yrKYhxkus/ElLmYx4inyEMbEPvV9zaLs3g0NBOM6aWxUdPdraiNhPR3o+SF5C2qPzdOBGi1l/sPZFNYi0w+3uS4Q6KrQv1PQck0NL1YPXRyTB3yI6ZazvA74QKrfk6HwAIjIohZM1pz/skExeRZoZ8EVcM94YkS8jTmYDHxDcVbpNm1i5Zh1rETA79Y/pNjxf/kv51uXSM1dZ/ntgvFeDxz/wMhGBbc9DGraJW68/U5vE1bwHlWvkV3jt8Q9VtT4hXlrJ7ZLJTsVlsso/v0zHXQZlzhwq8a1blPqwlbyUlC8hVCysrWbiKyyXud+qdNY5DWSRA/Lo425wQ/St3k8JVn0DAhhMwkfpcIz2lAjoDcXK+mwFnoGMkRtNrRXueTIqdP65/eeb1arxvhMBiWo9MzbDKhnliQI3XCQW8ThBnyvcDuojCUwMkhi7RbV76Sk12UTS6lvI5PQxQaoMM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(26005)(6506007)(71200400001)(7696005)(9686003)(83380400001)(5660300002)(7416002)(2906002)(52536014)(41300700001)(110136005)(966005)(478600001)(64756008)(8936002)(66556008)(66446008)(54906003)(8676002)(4326008)(76116006)(66946007)(316002)(66476007)(82960400001)(86362001)(122000001)(33656002)(38070700009)(55016003)(13296009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M47nbl8sv7VZDYN3A6EZRH4QVqwV9lZenxh7wCGV0BCFL6P23zAfHo9ppcIB?=
 =?us-ascii?Q?atbG6xWq6KjWSfK7vMUQBLWW3BtPfkSxVKSsoeWQhYWJG980w4OJuaS5khe6?=
 =?us-ascii?Q?2VDOAroOdvKWH3jvgXihWUpeKsAJVf9NhzKnTHM9Lc0eHsYqKpIu77pBB2T3?=
 =?us-ascii?Q?mtu1klpiHVCB5qdOEcUc+4ludP53QXE9QRbP1ih4rD7RK40uLi5rFjeF2dPj?=
 =?us-ascii?Q?/OrohxnkFb559op0G5fjR5kuxB+2nmG3XT9fbNu1j0lhguowcLc+RItaT2ey?=
 =?us-ascii?Q?TR8YMoSsbVxcI84wyX+9+mFVW+6yhd+TJvmlpoonFmUAlWoGR/xx9d8/16i5?=
 =?us-ascii?Q?MixZQ6XZ7B+cr2hTdaULng52YuCbaSifMiCT2DxTtH3y1ORKswoMp/z0rDB5?=
 =?us-ascii?Q?Ew624aLySLPV8Pq97JZPVD4Jb6nBHRllzFt4Fe3vZdELaGvKFmKBRI5gHcSU?=
 =?us-ascii?Q?Wkle4XATWGqzN4pg2UBOR7LgHZHtkgdkzJ7VvUn/bZMps3DiSZBXhdwsRY7W?=
 =?us-ascii?Q?WWNadIo35QdwpnfddO+bUoN/6IOEM8qYhXJuAHaYWC8KOQJCRD5SwjRGpXKg?=
 =?us-ascii?Q?e1f11ojTipqyENaYcz1AIoqVm+LlvRPYnZTjRfU5faErZJyvMy4Yn5wJnEp6?=
 =?us-ascii?Q?JsK/932wMC0X1rHdjFUJq2K9pJoBmblM0h7g7mNrXXopzH9zgeU6TkcehHDL?=
 =?us-ascii?Q?Ob8/GAOzXs6ZCFWhCe5mQJY0gkrZOOiCJyY33yEufnZI36gY6voOw4xaMj0W?=
 =?us-ascii?Q?OswzEGwge8riqbbum5YFaz/Ddtlnp705ZuvG37+98+hhrCdbWYnejRV7yA2m?=
 =?us-ascii?Q?8R6wr4GL99P1sxhtSDFNTxXeTdrCZUmMeWwjgtO4aEfKxhsAjbkN7J3AQB0b?=
 =?us-ascii?Q?9eTJYUmZJ1Kx11ibR56Gtmtxl1UnnLKNZ4UR6fmqNMAMxHZFjdO8TF1mTA5n?=
 =?us-ascii?Q?1Tq9xF+mbkEDbcqFXNttvYe/Q2/beGjLBNQP2g2tjb8J0xFrs6o26mvgw/Id?=
 =?us-ascii?Q?X12jpVLnYTk80YfqT6hPGgQVCpg3W50VOwIZOnMQgOtAsWdYU/wbueFAnlNn?=
 =?us-ascii?Q?4Gdc709uIJoTCdc+db9HBd6g8aiHE8Nc1CzzmgYgHdeoOlQ/ByA4CWGnYCDz?=
 =?us-ascii?Q?hjtMOteBkad1xse/vhJKD+U/C0bvQBqi7BA/t3QlYl+0E97pZ18R6fWMMWSy?=
 =?us-ascii?Q?j5gaIltaSyjPfM8a17jFJsvimWRCsqEAGNBh48VSdJHnrgfvpV+rlffRQ3eG?=
 =?us-ascii?Q?LfgsVpAm+AOZbQmJyVR3dWzGv1uIUnYY2fOIL9XBXdDFpBVKykHGkWXX+z7b?=
 =?us-ascii?Q?9yychxAX3J2L247YInkN5RnOLe1zroNaarRCmkugBh2yjx04F0/V6dSVizFp?=
 =?us-ascii?Q?6/c2Qx2VPH0+ZxVLy/XvTeqylNbLsT5lzObXjYcplZF2WbxP5MSLXHB21SDw?=
 =?us-ascii?Q?yCnY8eGhCd1xha9ZLSCmKxZ6ue2zEHgQj3gD3X6JtF7LAdmFfkvInkjKkqqM?=
 =?us-ascii?Q?JOLiFJ+wgyURsPwwZFt0cembwkQ4SqALZuCMb4Y5bL40ZKlDOkQx0u5GVeXG?=
 =?us-ascii?Q?MDJ2zubkqJO1lrq0d9OMCCz8pd1By069C8q3z2+8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3390522c-ad84-4086-ee36-08dc163fbee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 03:03:42.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXNR9RfR9w8Pb9waF6x7eiFfa9wknQMTGmCDV7TeLuTwVuA5c6BV9V6vQGcLxI/wji+XoEjzruI/hqyvKEl0Orj+boboJ1p5rX4t3y3UEKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6708
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: [PATCH v11 0/8] Add iommufd nesting (part 2/2)
>
>Nested translation is a hardware feature that is supported by many modern
>IOMMU hardwares. It has two stages (stage-1, stage-2) address translation
>to get access to the physical address. stage-1 translation table is owned
>by userspace (e.g. by a guest OS), while stage-2 is owned by kernel. Chang=
es
>to stage-1 translation table should be followed by an IOTLB invalidation.
>
>Take Intel VT-d as an example, the stage-1 translation table is I/O page
>table. As the below diagram shows, guest I/O page table pointer in GPA
>(guest physical address) is passed to host and be used to perform the stag=
e-
>1
>address translation. Along with it, modifications to present mappings in t=
he
>guest I/O page table should be followed with an IOTLB invalidation.
>
>    .-------------.  .---------------------------.
>    |   vIOMMU    |  | Guest I/O page table      |
>    |             |  '---------------------------'
>    .----------------/
>    | PASID Entry |--- PASID cache flush --+
>    '-------------'                        |
>    |             |                        V
>    |             |           I/O page table pointer in GPA
>    '-------------'
>Guest
>------| Shadow |---------------------------|--------
>      v        v                           v
>Host
>    .-------------.  .------------------------.
>    |   pIOMMU    |  |  FS for GIOVA->GPA     |
>    |             |  '------------------------'
>    .----------------/  |
>    | PASID Entry |     V (Nested xlate)
>    '----------------\.----------------------------------.
>    |             |   | SS for GPA->HPA, unmanaged domain|
>    |             |   '----------------------------------'
>    '-------------'
>Where:
> - FS =3D First stage page tables
> - SS =3D Second stage page tables
><Intel VT-d Nested translation>
>
>This series is based on the first part which was merged [1], this series i=
s to
>add the cache invalidation interface or the userspace to invalidate cache
>after
>modifying the stage-1 page table. This includes both the iommufd changes
>and the
>VT-d driver changes.
>
>Complete code can be found in [2], QEMU could can be found in [3].
>
>At last, this is a team work together with Nicolin Chen, Lu Baolu. Thanks
>them for the help. ^_^. Look forward to your feedbacks.
>
>[1] https://lore.kernel.org/linux-iommu/20231026044216.64964-1-
>yi.l.liu@intel.com/ - merged
>[2] https://github.com/yiliu1765/iommufd/tree/iommufd_nesting
>[3]
>https://github.com/yiliu1765/qemu/tree/zhenzhong/wip/iommufd_nesting
>_rfcv1

This series is tested with a real implementation of QEMU at
https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html

May be late, but still

Tested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

