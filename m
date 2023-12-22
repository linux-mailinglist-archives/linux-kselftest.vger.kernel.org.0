Return-Path: <linux-kselftest+bounces-2339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888581C317
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434A4B23C7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51778A5E;
	Fri, 22 Dec 2023 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2Udiv4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFF179B2;
	Fri, 22 Dec 2023 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703212243; x=1734748243;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aQwc/6AH+8eXLpxU1k0LRU2Xq3unMg7R4BPmr6bOZ9c=;
  b=f2Udiv4TQRxrhhPac+hhYlQWdhoyOjxdAkI6VjoNlsQmfseAmD0ULfLn
   PjBYR6/58AZDozcTku/8lW+/UEPPIIF44FzD9YHeO0/rA//ka2RtakVfn
   ZeCLOMlqZRGd94n3N8FtexsS18WsqNy1V7r/3IyEUfscKQRKv4BMRlwGt
   9gDSieNtwy4ojC4g2baun3lC3VBkxg4ayUPKfnvSlpnSxR2DQz/8/H2iX
   nKLZM45HrrSlEp2YnvfG4cjQ6FOHT8KQ49zAWRI3cLA7vBJNGqESjAev2
   5grXYP7t5umb2bLEOQe2B3LtQoyyNc13udx7GDKjpeefrrUSgajTVcQTA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="394961087"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="394961087"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:30:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="847316554"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="847316554"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 18:30:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 18:30:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 18:30:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 18:30:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 18:30:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOSDjlQfpPu+5zzapl6E2xMPCmCvsXC2AvHBfVLQFXNAgXTFEzCnZkEAD0hI6suaGDNdQGPBdIetwb8c1A4xNgXoJtIJrdBRUkFb1Y6Lr5k2dLMbeS1UQH0tif5vUdHm5nsVO08dbPWLITXrSLhF/jkK0HVFyiMEkhKu1lYRrxcc+K22+FaMHURvd6sbGUkUUdRHExm4jKezdQKT1sKZorayYBPeIQx5Xnmed1WL/f54LfESJ+Q14N9/tX8s9K85loDO8swlNKy/uxnC+wYl9XxcN3G74hHYheFUjf15AWaEs/LNJALCvoKeVuIHjwzBuL4+1fvkLTcXvgxT8ncUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIyoyU5pzH6LP7E7QZznJrSZPXhzddKe2OgcxHm6GdM=;
 b=U8vddERIBY+NhdPARTmfkPP/YqSakg7zkDN+SBb5MIYY59OoA0OiPIZ41TW5IhaztjFyfayrLz/iRM/ElLzUoWumGMJ66PDWaJQX5rResHWN2oL2MRj3BWk4d4sxceOM/figCz0KVtW2SWq1uUjA2XY9zyUKQj28/txzxUYQYp2rCZrcwC9g+wveRWBff5G0lJcVmngqYDLxTqUf+rsMtOIaSpgl5HYg3SM5nTWhUNoO8MXRRhJFwZA0fzjUYLIsM0X8KmoKn5AXI9XAf/HvB0xmobWl7USmfbdVEgiWBEDbRnFm1r4gilrxNDlakgg+F/cKcrqsuLm1lk5XycbdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 02:30:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 02:30:38 +0000
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
Subject: RE: [PATCH v7 1/9] iommu: Add cache_invalidate_user op
Thread-Topic: [PATCH v7 1/9] iommu: Add cache_invalidate_user op
Thread-Index: AQHaNCP0IeMzW8Cr3UyiyyXlg+qo4rC0kdQA
Date: Fri, 22 Dec 2023 02:30:38 +0000
Message-ID: <BN9PR11MB5276CE7AE7E2FDA1D8A045298C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-2-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB7350:EE_
x-ms-office365-filtering-correlation-id: d2602e25-d1e8-4fd7-2e7c-08dc0295fc7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSDtkjHX3t5oFv3Yr98pGxSImm8mKw2JOZtVKPXV4OkL1QMPx/KfllMGsm2r9a+5j8wkFqfmnLoZM5t8b5KTIDGWp838kwnpbAciK1r2FCuql1C4hmVHrARLGBIIPHWFh01O0GSQrxwnGjOrSAXTpNaGF/T+kuFI6us46yGlk4+hxE+82FR0sKBrx/16gA1X8S21b1jEc2rZMO5QvNWYJ0CVXC3IyitQRvzFB5j+wxzoXp2csJYfXeqFRTGduacg2SVVcdxMSp4lYSIwuzMuTCKoshUKLoeXIUZoCmupS+MK+MjfTJaueMwe2W8PuklItmOVflapAzpPsisi9p2XblO8qkbQLeGGZ62JobVHvqiFELNCUxBeusjcy0yuhbSbGFILfNRcm6ItoFVgmATTIk1xAPmdN2s5iNlxEdwXDgg/kumQnKK+Se+Nm6ruoiay5jbUyM4vkPK+amiigCwyfcwDOLR9owgwXK9zcpXYbm1wU+jyDs33fKX6+fSzK+GSoK63E/xJ5suju1yw7CZCTsctnDakHrLQ0FOW4wpLR+/VD/L6jzQJ2PiRV+mFHArZSqpR3Qt/8FklnDVhLTvTQllOqYfiClYBhy7Lcbud8OoxVRxUTFAO8kt9C1Eq+Zmz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(82960400001)(33656002)(86362001)(41300700001)(122000001)(38100700002)(5660300002)(8676002)(4326008)(8936002)(110136005)(52536014)(316002)(54906003)(64756008)(66556008)(66946007)(76116006)(66446008)(66476007)(9686003)(26005)(478600001)(7416002)(6506007)(7696005)(71200400001)(2906002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zQVFt/ngODD9OLvd6UDBgeKyoy2vw2t2+wqJfzJXkK6L/3kaAA8w2uuJ53t9?=
 =?us-ascii?Q?MXHhF+MJPcdFNvlAt5jwDe3QMvkKEL5wTieDYXFsOk1vi8uSLXpdF5o5yBb/?=
 =?us-ascii?Q?SNnzL7sungahGVDfVM3cyGqTBj8MoGfHGtshpgapLsXBoN9YvocqmnxeptyS?=
 =?us-ascii?Q?HdK3dRRkYBJZD0RHPppg1g+EITc/ZVmOG399rmZ1KJqswCqwvt9llmbynIl3?=
 =?us-ascii?Q?kUmXMW2JPmxJbW1IW/RJlH/iT3kJK6VQrAmp/5TSTG7uVhau/nVgLX2TtAMp?=
 =?us-ascii?Q?kVAlYoKX08BtWpIaQV/QxlcCbD6c1sKrjzCice5/4L+w+2F9sa3YTvhtDvSw?=
 =?us-ascii?Q?URBsr+GVC1tkqH1jBfSXYMdciW3FjOz+QT/NrcdlML815Hxsjjlasd3Hr1tg?=
 =?us-ascii?Q?p/GAoPJcL/g41Gtmhv+NLpR4I3P1QN3Hq8TlavEeXaYIF296qWJ80dVTyk07?=
 =?us-ascii?Q?gqCIYHLHx7DARJpt37qD8DXA++L7U8q4kV4t2yNURrxS4aK8PySuZHCgKdA3?=
 =?us-ascii?Q?laYxZjY3DBsxhte5O0OQ4jAdATf0I2yTDqP4exdG3c3IhH+oXEHcB1W964on?=
 =?us-ascii?Q?moYJyn5JaGAMVx7o52NWrRqGh+omrBk0xPY4GbCixcntT/Bl1YQU3HsCAClj?=
 =?us-ascii?Q?sCQVp9t7kW4gpSGyClAma9HklFQRjaEeBprPxVHUO1C/NzvfLu98Tu188X//?=
 =?us-ascii?Q?MiB92GHtj4b6kcGtwkVdUB3Jw9dbhlVD/jV83R+lVjJIkUSRX9SXLKBjbEDI?=
 =?us-ascii?Q?YBT/lXmst64iKiSrKFMZSpEDIquWG90nJihKtgaXCy89xpIlxOkZiEjUbVTZ?=
 =?us-ascii?Q?eAKW1Lt0TbT/dsFijJUGhFfaaWMDWjWlN3uM17TJJ7TIy1CU2E410Ypl5SWr?=
 =?us-ascii?Q?Jx1AweKSej7gNKBEqthpwnEGFAiGxtxklIgV5S/VRGjdrgmZg8h4TdXMd5cr?=
 =?us-ascii?Q?JkRB4xH0KRXJfu7fq0tobWTl0uRkiF40wYeMB0zTsdIqpPrTq2gMDe3R//b6?=
 =?us-ascii?Q?Uzd6QEut8fl0sbhHNj9ArqOwtPdHim+DUtF1W1q5ICx6h0CmHAyUH5aAFOKC?=
 =?us-ascii?Q?35Fdflu6QCaZiKcWprclQRX3M8FkmwJr6U6/YsuyLIK8QMjvysxrAVh7HB1J?=
 =?us-ascii?Q?A9bIMGC873rGe5zK7hzHSMv0qDhCQ3k3BUShP90/9batIjVjTDHWyPVk2hjQ?=
 =?us-ascii?Q?naXgyaDwnE7xqC9CcLT9lpLMb/FXGBzzdw8vfB8vEFVDFWjyym/ELkxUbp65?=
 =?us-ascii?Q?Q55wElufMoj2IaXP/JXtTiIqdiwHrq5Gehg3PC75SC7npgm6XOjU634MV52r?=
 =?us-ascii?Q?2XEYyDgYhXp1uAbv98mAB7gEpQKCgLZLpKBOWAuzSZS1RBChP6uN/Uyw2KUL?=
 =?us-ascii?Q?em/lY0EQgnBUGrLXVI7xe1BuhiDJgnWcINt+VmJxhBwoQaQh0BmzkkcfrgOX?=
 =?us-ascii?Q?UOyHxHQWa7e+nzvOh3u1l83IZULZf5pf/qlBTGLJP7Ap84n2JONxAjYhnkr6?=
 =?us-ascii?Q?hfV6ZSzBWPrZ6JBbDyk1qhlrfbpcS/Cuj1v8BaiNI2HPz6v+4JihozTqD71A?=
 =?us-ascii?Q?EHDVzVmvgPKWvHpdlhX6gsWmhdrFW0HslToUpElU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2602e25-d1e8-4fd7-2e7c-08dc0295fc7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 02:30:38.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77olGAPO1bS/xdDuxGP/9ZexDUIvxujioWM7Ge12G2Sgb2ZC2aaBXmos/7g/k35S47o31H4YC/cTbURTxUFS9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> From: Lu Baolu <baolu.lu@linux.intel.com>
>=20
> The updates of the PTEs in the nested page table will be propagated to th=
e
> hardware caches on both IOMMU (IOTLB) and devices (DevTLB/ATC).

this is incorrect. the scope of this cmd is driver specific.

>=20
> Add a new domain op cache_invalidate_user for the userspace to flush the
> hardware caches for a nested domain through iommufd. No wrapper for it,
> as it's only supposed to be used by iommufd. Then, pass in invalidation
> requests in form of a user data array conatining a number of invalidation
> data entries.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  include/linux/iommu.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 6291aa7b079b..5c4a17f13761 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -284,6 +284,24 @@ struct iommu_user_data {
>  	size_t len;
>  };
>=20
> +/**
> + * struct iommu_user_data_array - iommu driver specific user space data
> array
> + * @type: The data type of all the entries in the user buffer array
> + * @uptr: Pointer to the user buffer array for copy_from_user()

remove 'for copy_from_user();

> + * @entry_len: The fixed-width length of a entry in the array, in bytes

s/a/an/

> + * @entry_num: The number of total entries in the array
> + *
> + * A array having a @entry_num number of @entry_len sized entries, each

the first sentence is redundant.

> entry is
> + * user space data, an uAPI defined in include/uapi/linux/iommufd.h wher=
e
> @type
> + * is also defined as enum iommu_xyz_data_type.

I'd just say:

"The user buffer includes an array of requests with format defined=20
in include/uapi/linux/iommufd.h"


