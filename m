Return-Path: <linux-kselftest+bounces-2490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9F81F515
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 07:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE58283C5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AACB2909;
	Thu, 28 Dec 2023 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7obHq0V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD23C0E;
	Thu, 28 Dec 2023 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703745474; x=1735281474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fVVBXh5Y4+PQIoqRABZzz80qfY2hQR7MTa/rKJEmUV4=;
  b=e7obHq0VzunuIgQ6bb1dUUgzN7t/qxIVyHWM46Vu4pdkW8/FAI5Hk4I3
   +yGFhMfy0qzD1eGRthdSrVXkB4ibJtqUHRVkgMn1F8ZvRDA1fuA1nY4BQ
   Mr2Kpe3FjMZCdpUl5on0CcTk9MlHLVxcBfekFIqon/qM3SkGP+/rzAfhV
   hhh+GUINq3Tip+Bu1i2l+vsIs4VShlB7Fno6luhFF2vq3BSsGUzXKwDzp
   lri+dvv+aH8zknmYJ6w53qoHsVYhO2O8q+t7QD30wWPNl4eFF98U65PhN
   /aufrOp5mU0rPD1/eICCAh2kxqpM14a6v+roM2EzJKCG4jbodAeSK0z9d
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="427689449"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="427689449"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 22:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="771645038"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="771645038"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 22:37:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:37:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 22:37:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 22:37:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 22:37:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpLVlG0QyTawSJW50alZwnKG2yBXRIKDi/0AGIeCmtDdpfbMTSIdiAgFVpWMbyiYLYwWUWxp9Ic7Pc+cEJH+8vy/TWpS98ld1MQxVQFGTkRBeu8/voYfxcsPSY2x+ZF+mqVwvduPkfOwzITHsgA+aI++Xe4xsFltaK0kpLvrTFFmpXoyJxzxvwACxHVET7OzZMvztiIcA448SMQ8GwxjhOo4V+ITuo7P6cHtrewAJM2njLPBMrssSaPjxNQiU970NTWaUml2/tRMztECcrGA2HuSfAvUROFIPq4xWprHQaIROseShaylenCRe58KDd5qNmpXMJjxMI9rwASBMLNqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkcWq6msLWKKt3S+fTUmb0tdlSZWW8/HjKz7NWry+zA=;
 b=IiXhXJ23oj9MDtnTcFO5ZjC3JtE9/52mckZycps7H6Iumo5TMOgE3e0hTMbpVe6XvVno3KURhTM6hilM66988TlV0w63ZJ8TaPBLN1bVE36mi+hNVJLSYKw2sspoTX+os+g3BNZ1+/UqLhEYs897M00anCNowTwueyKe0idLTDtF0+5Cp7Mo1wm8ff851jBNcJGFpZk9835ixHcbqOKdBhyGYIvHMynxnZTf91QeRCdeu3RCsHgBeOQPfXGOM2r1lKcr7OFiBat+Cm/hsXx1UWsOinC8oeB1FacLnOR4pFbv+le7AGROS5VVVIdcy9yJDuk40M4PK0XwrAR/MTPNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6228.namprd11.prod.outlook.com (2603:10b6:a03:459::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.29; Thu, 28 Dec
 2023 06:37:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 06:37:45 +0000
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
Thread-Index: AQHaON/EULDpY/yduEi+JsXzzxonvrC+On9Q
Date: Thu, 28 Dec 2023 06:37:44 +0000
Message-ID: <BN9PR11MB5276AE2A3094D1CE2041BB128C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-10-yi.l.liu@intel.com>
In-Reply-To: <20231227161354.67701-10-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6228:EE_
x-ms-office365-filtering-correlation-id: 3ec920bf-7455-48e2-bb45-08dc076f7fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8t5IuYz+/zGhLkOQAPCvUXwFfEAKU8FkjHFiI4kWh3gva3OsnAN993XAQdjukCup4HIBYn9fK3jSChn+32AVe44zE8e1Dto+A9OF7y2fMH1iCe/lRMR32351JWRbSyzCBkjnlcy+M9agkVMQpzG5YHeNXj9751vbhW/vNuZYL+A++ybVjTXoLT1t0wD8ELHQlttVZcNek3TYtYrdHZy3pdd1hJDZLrMAUA+j1CkdDn4qFGeUeBcWoZ09z051aVti4oFQcvpr9MMc3ELNQATR3vU99diIX9zK8arXEMSfRS0y3JWJigha7DwIY1Nq9PmgLRDJM2ZkLySxKtg3lWzATAySAshAyrRTS4eEoTQ/IQD1SUDcPnnhYsRe5KZCUsicYJ8LeuyQ8ers7qNuEozmKNmIXqQbvXs+KVfNZ4i2CZ+1P1JE7yhTYTDEzKoClUIufWvFYjvXX+iXxZUkwPbxx2xBLVoMs3SPiqXhqOY3ZiFEl9BaHaBWpaJbdVEqlCl09pYWEa75s9EBhYsg8/aBQiaIxHX1MOoG2swI8UgU3jUhUk3sAwQLL97A6xFwqausIx2DaCdu73YWHOqemYyhjJQ+nsj7DHlzWzi4QfuAjY5pXXZs9ASScpFxIwPdTdMQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66476007)(66556008)(66446008)(76116006)(66946007)(5660300002)(2906002)(55016003)(4326008)(7416002)(52536014)(8676002)(8936002)(316002)(71200400001)(110136005)(54906003)(64756008)(41300700001)(38070700009)(9686003)(33656002)(7696005)(478600001)(26005)(6506007)(86362001)(122000001)(38100700002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Wttwdg6tiegnKdzNhLC3NROws1kklPAo0ETzW/Idsv1ij8mWw8Nlmq2kwvKk?=
 =?us-ascii?Q?TReoLa2KQcr9NB7gQiMX+y0v+cs9Y+FZsggSgn8Ccw8BpWyOIz+f1DouuN2P?=
 =?us-ascii?Q?VSz6rPgmSWDMv4aLjIJs0ZjcOwAzRbnorNt6AGz1NPFNMqchzWtJTXxY/Azm?=
 =?us-ascii?Q?ZFV7bWqDwDckFUJsiwpq3YIFM8ag4a+YQQB9oCLtgVtOaMNT8EBujlyoh7Eq?=
 =?us-ascii?Q?n7++ed6K6nttSoELdjg7UVWeUfOhoOm6Kv0HXFaHwmPQ+cNH6sleS+Qrx//S?=
 =?us-ascii?Q?TCh51DNmgPYdvTqGzVdOjmILP58uvRC2tFBQMerYEZQL86mnY0bs9LvXEuZb?=
 =?us-ascii?Q?lnqhNBPLpc2lnnGMkL08pLAz4Ays8PzNODiKgXIHnVmwHozSKbxSLNpqKOVv?=
 =?us-ascii?Q?9ZPoDpxMbzJHGUbbPp+nue+MpJMHk/s7KgIxfzDUteRzmyiEYoFuXBGrQkhD?=
 =?us-ascii?Q?UlEdhXbEWY3kTg31RwBivQqnB6pqnuM6huG2Q09XYx87/WavTkDYIG6Pxd/U?=
 =?us-ascii?Q?yYiopdaZGjaIPqVxhSf6Nsmu6Wr1K5T45ii9Er6WEhZrBdBhj39JwiccRcC4?=
 =?us-ascii?Q?x17q6H3gV91qJUIgmDpUd0yCb0KUlwomDPxAV42/2ppFFtUW6u83QaiaWZ4s?=
 =?us-ascii?Q?vw7q5C7dTfU/hhhpvvHuEqVdtM8ygGHuWTlj/iiYx+aOtP0kdgOag8KyZG8F?=
 =?us-ascii?Q?fvhRRUqJlC66xjc3RwNRLZb+HCVSVHau7p6k9KdPto3mLmEtUaQlv0WZMc0e?=
 =?us-ascii?Q?MvtqJ9z7q03hB/dQtd8V9Wd0qTWT0SN21MhHiU2ISLty6zjrAZrGt5Zycn8Y?=
 =?us-ascii?Q?hxqv0Wm+vSdRra4enhEstCo81XAI575wr50UJ/3PKSBmnbsRFl8FTnpEy9xz?=
 =?us-ascii?Q?ELLOBZNRqwJVxR41bS8hdP7wxfOYOGQJAM7Ne8hIpTSJTIJtkOGbQ56nB/Su?=
 =?us-ascii?Q?NInkSIDKsUW+L3likZG0wfvuShTDSsylCUMIYsaDxqpF5VMHsAjAAxpJCpzb?=
 =?us-ascii?Q?gjVs0OM69DJSWdIfefC5/UTt6Or2N1JJZT6PMcZu88WKUA6VybBU/RpZILCF?=
 =?us-ascii?Q?Q+pnYQ8VEC3pX82Ag/jK9RHvUyVVvlu7g/yuF1MeCzUITaL3fE8ZLFjc/ZSz?=
 =?us-ascii?Q?XoqgK+3S7JvD0IenAxQGIQk1P9oYsRajmtsWHbYfZ8XAWNuelCzoIo81if32?=
 =?us-ascii?Q?LaLJy5UmJzDQ+cLc2Q9+pE5FZisI9crB1vtiEAkiKqT4ovFJuoTmc6UOckP1?=
 =?us-ascii?Q?BG8tLy4nwChKqUek/vZP1C1+mGeRYOECWD2N6/GuCIRnUU2XlQToefzic8fh?=
 =?us-ascii?Q?RWt0sfCbhKSsaUWEf2jAnQbJJKgHQPehZoN01E9hxoDlZ3lyZnWwBt0ouvC5?=
 =?us-ascii?Q?Ga524uJtJJxebHPNHmH6EWHVDLNeunv2HWITC7ldheXh8wEazCfxht0bccdy?=
 =?us-ascii?Q?TBex9uL83yo3HO0y0JP0TDm9e+H1eViiW6i541kcEojGrjqLjWSTWTRAuqBl?=
 =?us-ascii?Q?HRMJbkIo1QPSpyzUO9YPy3PwMOUG2zhn2QNvd9PZ1//saJQhWEqQ7NG94y5c?=
 =?us-ascii?Q?us8CdGSybnZToMLUVvG8X7B4enDbPmA4ma9j3luL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec920bf-7455-48e2-bb45-08dc076f7fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:37:44.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dmv4BQnjJQXJIpZozjALvKVNyCUB4A07ZCvMnSV6iJbNQZ+Xkbk1/0VZ88U7nGzhIuNrW/p3gCmGgJpfzSe7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6228
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 28, 2023 12:14 AM
> +/**
> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
> + *                                       (IOMMU_HWPT_INVALIDATE_DATA_VTD=
_S1)
> + * @addr: The start address of the range to be invalidated. It needs to
> + *        be 4KB aligned.
> + * @npages: Number of contiguous 4K pages to be invalidated.
> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
> + * @hw_error: One of enum iommu_hwpt_vtd_s1_invalidate_error
> + *
> + * The Intel VT-d specific invalidation data for user-managed stage-1 ca=
che
> + * invalidation in nested translation. Userspace uses this structure to
> + * tell the impacted cache scope after modifying the stage-1 page table.
> + *
> + * Invalidating all the caches related to the page table by setting @add=
r
> + * to be 0 and @npages to be U64_MAX.
> + *
> + * The device TLB will be invalidated automatically if ATS is enabled.
> + *
> + * The @hw_error is meaningful when the entry is handled by the kernel.
> + * Check the entry_num output of IOMMU_HWPT_INVALIDATE ioctl to
> know the
> + * handled entries. @hw_error only covers the errors detected by hardwar=
e.
> + * The software detected errors would go through the normal ioctl errno.
> + */

* An entry is considered 'handled' after it passes the audit and submitted
* to the IOMMU by the underlying driver. Check the @entry_num output of
* struct iommu_hwpt_invalidate for the number of handled entries. A 'handle=
d'
* request may still fail in hardware for various reasons, e.g. due to timeo=
ut
* on waiting for device response upon a device TLB invalidation request. In
* such case the hardware error info is reported in the @hw_error field of t=
he
* handled entry.

