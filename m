Return-Path: <linux-kselftest+bounces-283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3FE7F0D33
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 09:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1ADAB2106E
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B468D533;
	Mon, 20 Nov 2023 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMYqEjUt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D48CBF;
	Mon, 20 Nov 2023 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700467780; x=1732003780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ai/lK4AcozqNiz8S6lCiP0i8KualNn0g+8Oiu7kxCxQ=;
  b=PMYqEjUt1Gm3EJ7BPE4KttV1KZLH347SHi8CPVBftZXmmlMpCNwe38qX
   SUw1y6qsleSXV4t2DyD4kccrNF7kwKgtowjRYEgL98HBvWe44WEv5z5Wm
   PVrmeVhPy9vnbyACa98XMsnbqcL95tl2VhpuzDlI/MRD6eduyLO5ATtxH
   vYsKlQ/SJe0j30vLBqrsy0RJLLQ0+kmipYd4HOFfyz4NeYj4c7LyGuoyU
   fcZ7nb5/4t6z+mgbdk1TR2Gp+kq33DTpp0h+Z2PBHP73G1XoATCd7STxT
   tVylHTyXLdCKaih/ppS4PHE1UPegG7fmNY/fxSi82iGkmm0lUg4xCPYXM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="391357863"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="391357863"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:09:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7491166"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 00:09:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 00:09:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 00:09:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 00:09:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1nFWcGwzQzEpuL/Rei18A8ipzDG7NcLdhxhMoS0j02lJ6VQhn7oeBDgjKwPnLMR+RZk9hqXF1gvxrHtJSAXYSTrMjruLx/92g/5BalEJJjtBl95nAXglE6T3gZXYEUun9XjsNFU2NArQi5WQQ+65YoL5ugmGrKeMIsFqlvCUx86SNxl/fv+PdmVS91sQy4PmiAvh4iBUmw5bWkCPFoOX8DNS9/mxHmVU8phJOtf7GlMsnPaBOaqVfISgz7Ov1ct3zn1ieipgMrsmQ0uxTE/ppuKZ+FOtfMWiAYQRWDBrdYOj/jaxnTtNqq/ZLsT62RCYR7hjnGaIPTziJX/oKrWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irsZALTSGAcS9SJ/Q4OkV7/EXw8HCQuqINPxaaJl9bw=;
 b=m7tfN9lmJczPhYYSt/2eg5vYvJn9+pQwj7W5/OgIGXyHQPdj5/DBA1RKpc4+E4ibXZrdEux3JsWLjl0l6gTQfwqcmcnSSZ62LLeCtuFoZELnaXxAJLzqEDdBQ3qWeeGxHQn8QFMoJNsrVF0sFaIKORJccn2JdOo383E1eshG0XewWPVlF+4MfG67+kvwipGWH6CfgnZIAWHzIU3JDVqrDPTR0GRZCqIG8pheOfmI4ahvhPzqP7SE4DZzqPTyqLh12MpTMwuHPIww3WFHpO/PFz/AP3TufZP+DnBk/d96oLZsgEF4IF3Y8sip+I7gDqPM5gNZE21XIIjgugzZqjfh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB8254.namprd11.prod.outlook.com (2603:10b6:806:251::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 08:09:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 08:09:36 +0000
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
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQ
Date: Mon, 20 Nov 2023 08:09:35 +0000
Message-ID: <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
In-Reply-To: <20231117130717.19875-3-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB8254:EE_
x-ms-office365-filtering-correlation-id: 96a05c70-4da4-4ab9-136f-08dbe9a00901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJEdNgUPsj/bHQ520okKKbX1zIpNZpJUq3drLwLBKGXW1hXoWVaf4uTSv7LWHu1haKDhkunvkL4ykbRsLwf9J0/x5WUXKw6fNelF4eDCiEpY2JY59HX6/swH4FghRTdeE2PrlhDM4w/bc4nQNJr3EwBWSf2b8zoG2ZIfX/4QT99PX3kgMOxFPU1ojEhoDxidnfAzoTYBDVrwAhk+L8PGlozVZLNRUbVvwa7V4AEzq96Qgu1irLUAHV2+ScKhnInVCm4HlfYh1rXwSbVzmluZt0c3aGuzb1fckKRxxaVyaIT+lZ7ryz0+7X99Y2rAZnu1EmzJNkiY7fHhqOQugfOTCZ0X8Wos46PC1vn9IyI8rgD8Dusy1vrKGSxQlNxr6kXr9LZdgHG8fELE3bp3f4L6fnE1kEskMkwfGlxtLcWd6Si/9VkbuDqXAqaZr1qoNm2rRBRIUVCHsd27tmcN4K2lH3IVDXCduYA6Qw03/pKGozysxYws1QpT4/6NcMB4dVrpAuR79p3kEamJHiZIq1a8+7tb2hEe1J6Mou05nwXpwR0Ow9R80w1Se69YBgFX9rcBHUec9qrtpdGcSyKdAr/hvTw3qLgZ76BTgVqXYZzsW7zrTspmOG001/GHaOmJBB5h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66476007)(66446008)(66556008)(110136005)(66946007)(76116006)(64756008)(54906003)(316002)(71200400001)(7696005)(9686003)(6506007)(26005)(38070700009)(478600001)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(55016003)(2906002)(5660300002)(7416002)(4326008)(8676002)(8936002)(52536014)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JMohBZkjcyHJ6bcoWGZs2+S2VSj42bs9xXAuLAxauWIQb6IglKBKvZQRtxo/?=
 =?us-ascii?Q?CRvOkjsKSNSxlIwVimZKe7CLU53lmr51a9+Q8DoX6AV2LETbKLNvLgQh1giq?=
 =?us-ascii?Q?Bw85rMkAfHzps4e9KocFwsKXgDKGVsbA0VZVIIMHmvMQnpMQkZ1UC6U7tmv4?=
 =?us-ascii?Q?82UAKJ6MDI5zpwREphDgoreOMTd3+1pNsDXbHkyWkBr3Biva619WBPaQkiPJ?=
 =?us-ascii?Q?p/96hqN6fZDNTzyCh8F0kPbQT8Wrwf0cz7Xnnjs0IJBsuLNrR5YEuYUiiRqq?=
 =?us-ascii?Q?VMpeQLcgl0yMgQNSD758etiJ3cJjyqzPpIEaVxKEQZYA8PTS9pXy688+wEdr?=
 =?us-ascii?Q?SuxxhG5j1pouw+LoMKk77mHoWIUsL74MYgkKoP0yfG7VG0WVykkII3oxQYqH?=
 =?us-ascii?Q?n9eH9dmsUAoB3jLiOTia1jowa0vgGa6EYkBw5BNsd+wy5c1sz2fvi7fQ+EeP?=
 =?us-ascii?Q?9pKh4Sndr1+KhAYRBZki8bOFQP4tEUZgESD0OJN6D/a9tHdzTjkDdtrte3lw?=
 =?us-ascii?Q?RtcOoBONSppOea/yToadc0hj8h6OsCXec1W3fQI9bBpO5bBNWrjZpY16CRia?=
 =?us-ascii?Q?acvHm0s4x6cBLaKyE0uEyBLx18Pb+Lzj4ZJfu6FVOkvpRp+8eK2pJkoCR6hr?=
 =?us-ascii?Q?CanllFw4W/7JGAH2rst6C34AjsD/3vA12GuZCkNB7sEB6qVWsOs1QbqfApHz?=
 =?us-ascii?Q?DR+NfOoWo+amNfDeA3ozuD9SdvtDvQvzhtw3BguSs9SBPMhrwyH2e72yrmSM?=
 =?us-ascii?Q?CXA3OmiszSlT09vCmHUQ71h8f7rQxxY2lJBCz/u5pMeXAGcbRFpiFDQZw3a3?=
 =?us-ascii?Q?tkUdVpKUX6kN41uyYYu58gnuwPQ9UL7jQwQpvuG4ip87Ll2d1N/vc8Sigjx2?=
 =?us-ascii?Q?i7bgB6Nk8SvInS+X8ItWNlQQa/KM65Hd4wb2nPH82tjAakucvS8mhJr6qU9R?=
 =?us-ascii?Q?hxEBcsbmb0TW+XeL8QVl1yEOdy2cadNeVXMFhsvyH+WUirclWe1aV+6kem9B?=
 =?us-ascii?Q?F2l+4VkG6vvywkc5kPp9Hqn9JsryxijmZ6j4403gaqihlZDsJgdIkg+oQdWC?=
 =?us-ascii?Q?5KRIYus14UoPcHDJEUCI8L6LQobhLqc7L/ezszA0cJ7eiCy2xvBtIa4OGy1I?=
 =?us-ascii?Q?SqdktUBuw6YNN8HoE1Q5znyNZg3eamFXpT68qGJmDAdHbOUXqrrbW8cfGdDG?=
 =?us-ascii?Q?TSFJnncQRTROTh+T0BJbtW8BDi+yeS/uum1x1ZVlXGlvg7RH+ZxUIxCFthRB?=
 =?us-ascii?Q?QvqcCnUkTFM4DrXm0k9PCY59hdytBs6Hs2WbQ+KQCTdqogK2G57K9haNWusM?=
 =?us-ascii?Q?6KzgceC1IvsDPLz95XD9t2CHFWZ8FoQmaHH3q3Dz9GP3U4DZkLDvKT0QdRSJ?=
 =?us-ascii?Q?QUpbO42UipGshNwz9Wp9Ru34d1BKQMG2kjogzNSeja/Ox069eJAtw/mWIRLw?=
 =?us-ascii?Q?bTn607JTX1Jf6ah6Cc/UUWKHXmWJUZHWGbx6fKYOMfmPXqIuttLTnyX5aucb?=
 =?us-ascii?Q?Bdu2/28yrAv1IkxgXsdLbHim1ITpmjtb9OAjnOw62rm2VJ5zRf2okLFJrQdT?=
 =?us-ascii?Q?9yDtRlBS7bNjRyElWZqq0+btlCTSkhw8Q1UIfUyz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a05c70-4da4-4ab9-136f-08dbe9a00901
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 08:09:35.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyFt94AlB6Jlbtu5YaLNfRs0l7Lp1sm+rwT4xHqRZ1f+Gk5EZx7XEz8bH5V6G7fYBEmN97V2IKaaokPLbYv2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8254
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, November 17, 2023 9:07 PM
> +
> +	hwpt =3D iommufd_hw_pagetable_get_nested(ucmd, cmd->hwpt_id);
> +	if (IS_ERR(hwpt))
> +		return PTR_ERR(hwpt);
> +
> +	rc =3D hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
> &data_array,
> +						      &cmd-
> >out_driver_error_code);
> +	cmd->req_num =3D data_array.entry_num;
> +	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
> +		return -EFAULT;
> +	iommufd_put_object(&hwpt->obj);

the object is not put when ucmd response fails. It can be put right
after calling @cache_invalidate_user()

> @@ -309,6 +309,7 @@ union ucmd_buffer {
>  	struct iommu_hwpt_alloc hwpt;
>  	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>  	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
> +	struct iommu_hwpt_invalidate cache;

In alphabetic order this should be put before "hwpt_set_dirty"

>  	struct iommu_ioas_alloc alloc;
>  	struct iommu_ioas_allow_iovas allow_iovas;
>  	struct iommu_ioas_copy ioas_copy;
> @@ -348,6 +349,8 @@ static const struct iommufd_ioctl_op
> iommufd_ioctl_ops[] =3D {
>  		 struct iommu_hwpt_get_dirty_bitmap, data),
>  	IOCTL_OP(IOMMU_HWPT_SET_DIRTY_TRACKING,
> iommufd_hwpt_set_dirty_tracking,
>  		 struct iommu_hwpt_set_dirty_tracking, __reserved),
> +	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
> +		 struct iommu_hwpt_invalidate, out_driver_error_code),

ditto

> +/**
> + * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
> + * @size: sizeof(struct iommu_hwpt_invalidate)
> + * @hwpt_id: HWPT ID of a nested HWPT for cache invalidation

remove the first 'HWPT'

> + * @reqs_uptr: User pointer to an array having @req_num of cache
> invalidation
> + *             requests. The request entries in the array are of fixed w=
idth
> + *             @req_len, and contain a user data structure for invalidat=
ion
> + *             request specific to the given hardware page table.
> + * @req_type: One of enum iommu_hwpt_data_type, defining the data
> type of all
> + *            the entries in the invalidation request array. It should s=
uit
> + *            with the data_type passed per the allocation of the hwpt p=
ointed
> + *            by @hwpt_id.

"It should match the data_type given to the specified hwpt"

> + * @req_len: Length (in bytes) of a request entry in the request array
> + * @req_num: Input the number of cache invalidation requests in the arra=
y.
> + *           Output the number of requests successfully handled by kerne=
l.
> + * @out_driver_error_code: Report a driver speicifc error code upon fail=
ure.
> + *                         It's optional, driver has a choice to fill it=
 or
> + *                         not.

Being optional how does the user tell whether the code is filled or not?

> + *
> + * Invalidate the iommu cache for user-managed page table. Modifications
> on a
> + * user-managed page table should be followed by this operation to sync
> cache.
> + * Each ioctl can support one or more cache invalidation requests in the
> array
> + * that has a total size of @req_len * @req_num.
> + */
> +struct iommu_hwpt_invalidate {
> +	__u32 size;
> +	__u32 hwpt_id;
> +	__aligned_u64 reqs_uptr;
> +	__u32 req_type;
> +	__u32 req_len;
> +	__u32 req_num;
> +	__u32 out_driver_error_code;
> +};

Probably 'data_uptr', 'data_type', "entry_len' and 'entry_num" read slightl=
y
better.

