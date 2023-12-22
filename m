Return-Path: <linux-kselftest+bounces-2342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DFB81C36E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 04:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700EEB2354E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 03:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7710E2;
	Fri, 22 Dec 2023 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hh8ga/Os"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E3184C;
	Fri, 22 Dec 2023 03:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703215559; x=1734751559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OBzAEkg3LxcUgLxgg4OGSlx43i8VRSv0/7BnehItZOQ=;
  b=Hh8ga/OswhT5ueUvUsKXySqlNTSm3mLjTUwjqCVhgfcjysO9dyQbebt2
   oi3TfAur7saPATEY3AMkrqOqiSuioxnJDxo7nmTVOfixGp4eGwY1qI7+k
   yiweBA9eq43k5AwdPS7T2XXI0ZvxhIXFFJOPiv93npJ4s90y7hHL1R1uo
   20cg5D72Gf5DCU6TEcjiIdrciXnx7rUUvf7+jLMpyGFnVNyBQH8l6XeBG
   TNdsrRmhZT19PJgWoJdqlbqGSH/kr2xV55ib/a7UI6swKLXvW/ABUybgB
   ULLf/TTGtKRXm7TPb74gxjDn3JRKg7QJcR8aX9+1uLZAx3NEHA9hulDex
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2906809"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="2906809"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 19:25:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1108334781"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1108334781"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 19:25:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 19:25:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 19:25:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 19:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5/09YHZIi10aaLFvY5uYqg+YeJ0a4+w+F1gU+6iDerqBQCoz1zkP//kHArA7RMfr4ZHgPPjvw78uRkhUXWFasjDxYNqk2nM9yOLo6wk7ieExkcsUblXgaKDJQMPDoID5PGmSLUbtZ+A0U6eDTjkhN19MJfgN0woVuKSQx3751O2j4AhrwVrp6ocFdUA0QgskXhj7xYhO54LMJOvgoiFJ8zvTzgaF0uWLVNtWzF0p23Tf/SyK6OmUQJ7ImSXdzuy40WjNcNj3lyB6vvyYn5QKckbwVwq6TUtNLKjtCqzcOzEUZAh/c68YtGoGfXcl4GAAUtuWskZ+FawaOhD6N8Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBzAEkg3LxcUgLxgg4OGSlx43i8VRSv0/7BnehItZOQ=;
 b=iNv4WuaIPsi691E9918c2b5nUgbMcMqXs9wn39qsdm6RkfF4+NZcVgBZtnzxmXNb9T4p3SxbSMNLcZmRuZk+yWiSF5BRLqGfMDa+0wqIf/JX/bMpvxsCtFvsHJdspZxmhiUXAgPe0mUj7XF0Unt8BHxGdLpKuHOz5b3EQH1wVlpKuUV/N99xw/Va5bAFvCkaVbKBAZ686qVdXWHzX6LKGv0CepobMGFaJtdPpBIIXRVoabVxuwbbc8UJfYoSZwQkPCgKvWS6MrhyA7fKr5GiwvL7zVgNcLUEyWPUoxtGbnJTSBMQGg2YtBv/WI+E8b6hi7saVwNkze8aPjNqFUNztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW6PR11MB8367.namprd11.prod.outlook.com (2603:10b6:303:249::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 03:25:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 03:25:49 +0000
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
Subject: RE: [PATCH v7 3/9] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Topic: [PATCH v7 3/9] iommu: Add iommu_copy_struct_from_user_array
 helper
Thread-Index: AQHaNCP1bnKnJ3W6HE653khWRkZV4bC0pL2g
Date: Fri, 22 Dec 2023 03:25:49 +0000
Message-ID: <BN9PR11MB527690A192E756A1544DB0C58C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-4-yi.l.liu@intel.com>
In-Reply-To: <20231221153948.119007-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW6PR11MB8367:EE_
x-ms-office365-filtering-correlation-id: 1d969145-70ef-48c8-6a27-08dc029db1b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGGQ/J/Z4+3P4iV7nHDZyWuxJMNBGgfPiXUNS8XQyDKe8fzKKx7DgHJlOoveT/Jsp/2IcdidtToQvE7UGCrWtg8zD8FyJNj6md8Yoo+gye9GIrE1vZmMRvOJ/zVbNQ/Tj4O+wqTUsbif3Guv0XFSoJa0igvAxmDIdJLhvBgeDplmjxL+qxllf7HUnqhsOgq7ofztEkdRjDnDLqJX3F4isBZLTSjBCVfHlfgdBubsW5qUCJHv3Xos2hBIjBYzGQQzTFA2XLHdK7b2fEgEYDBxfXmledgBMeYg+IRM+795vXk6N0Y8eOzUfxn4YA3OYcre3G+8TB2QpDhaxmYehXGW58q1YxYBE2hR3+itEWbtIIiF/sjtd7dCY0VzCAWYKsEBsm0D7EST3IqxxcvGZIM11YOR8C8JFPjfAwt0/SpA9HHjuLgvwQKpyM/Zuv5cf1HDgGi0lNGDti1Ek6gcSsOkobu/osPeoMSq2jW/RPxwPTqx3WY+Cp+kjiKe09bMuysym3Q5G6ug7Ai30jQOH6ASV5h4qkNKz2/zzuvh93efODheTrXhOLKOkeeZ/a2BOvN2qebV6+vGpBAgoKHvmovMnA+2o2gEQ4LnwjBeCPDKjXklGcQoWZIyPMggaCWBrMYe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(8936002)(8676002)(4326008)(122000001)(52536014)(64756008)(66446008)(66556008)(66946007)(66476007)(76116006)(54906003)(110136005)(316002)(82960400001)(4744005)(7416002)(33656002)(2906002)(41300700001)(86362001)(38070700009)(38100700002)(5660300002)(7696005)(71200400001)(478600001)(6506007)(9686003)(26005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KmHLIBxg1xasGuvKoO48XehhVhzXwWn4eDYGTobQtWEdPb3izix1M2e34gG1?=
 =?us-ascii?Q?rrYQjt02dvAevqGxXbhao4BHCTWsiONvBNYMpEXztaTQgG3g8BJ7t7c04Fhc?=
 =?us-ascii?Q?MrmjP9vDwSikKWdSEUj6TJC4TFaUZ+un6cbrDnzl9zw1pHMEsLgHeYMQ93xV?=
 =?us-ascii?Q?ar4p9asf4dq/7MDS2JuJReFxt/9ToR6/S2D5vtUJzH61JVAfuAk/aMV1F/RD?=
 =?us-ascii?Q?0fBq7XoP5S/royKY0/rKUVFONalSjgwelCMGnUE2tWO1KVjHqbIX55fWu14O?=
 =?us-ascii?Q?vo4yYK2f8/PdC2ADDpZ9MS6j5ZBJcgcslp8X6689mXSOksO/mio6BGV2QYul?=
 =?us-ascii?Q?ZiIhFaGqsjwPNvI40sXj9X6V7ecyPUb68GJ//ZNrF2F+7OKDsBf6+eaPxw7P?=
 =?us-ascii?Q?puRQTC+0n9/rZDkQD8wFp1T01wpM3txJSYWQMIJ5iqRpjCilmLypWDkBto3+?=
 =?us-ascii?Q?u82mqYNWecopK6rbV23U9Lcau4qI29IjL1cB//gDxwYWpc6XIrIWJYPcrOsy?=
 =?us-ascii?Q?0I4WVZY7DkbghFA/wqy83I9hSdyxObeDfsk1pWvh44zaXcUseWyLjE3o7F+B?=
 =?us-ascii?Q?WqXy/wQvC+XLBSIBaGjodvvGXL1Yk8cRykn9mdZiEuSlPm+3L17IGPoL6ctc?=
 =?us-ascii?Q?2fS6aje6QGOtSbUexiAjihSvRvlVCZQg4QtJRP6HxLYHeG9U1XyGj5V0AshF?=
 =?us-ascii?Q?C9HG4OkE4ezPBxuUxzLRcga1DHedy8cfrbvgrTAUpiqdRdzgBe7bJNiNgjcm?=
 =?us-ascii?Q?UxiwzIZkg74whGDlEbJeuvTw54qK5OdHRebqOH9BKMnLyrhNrZm+BLxrUUSP?=
 =?us-ascii?Q?mnYc7NxIsBqxOCpLAqgoh1mwpoIQl9P8GBsJaRCt7348nmmimm5LKii9ajpf?=
 =?us-ascii?Q?p4y+4rLY73JZDmrF6eKPKyGLPt1HRr+/ze6HezsrlZd/00vm26LqyQMASkwP?=
 =?us-ascii?Q?aNTCaVddcjqDFwbHXmsgu6kyBB8PA6A2EvxKXMqYYkL0XKQhWabwLeFnoTtz?=
 =?us-ascii?Q?rsPrpoWjhmKhQK7THa9e54Avwldn7pSitorOerLLJyC3hY4Cxuxi+kVioMMk?=
 =?us-ascii?Q?rq8m0Q4GKD+T+P90COsoBUu7m/4qngN7MGbJ0QRwldpEYrZdFa+/1K5JQ6hR?=
 =?us-ascii?Q?U6mV+hynR0bwT6xVjjIbrEXjXpKCqIdXnDSSkp4SU1xA8Mql2UDMy8IqhCtl?=
 =?us-ascii?Q?g8vq9GxPtqrTiLaNt0WlT5o6B8BAvzRJSKhkyirN2soVKtRtehbBXvWYv3mm?=
 =?us-ascii?Q?Nhzp+dlPBD1WYWUXNNrfGoCY+eZ9juMVklgUkg4VO+HzzOoSICCzAJB0Hmlo?=
 =?us-ascii?Q?UmGmqgXKNc/ab9YBE5nZ6ogZHQ5paHzD6TKSIj+caRlT/r0mi16VrTHYL/Xy?=
 =?us-ascii?Q?xbtkHuGYYT629/CjkLoYNhMmfCHj72/3NJtoXeiA7l9wRD90+V9+9zNqhCMh?=
 =?us-ascii?Q?uCON+bQsKfjpiQ2ZdeKLmjTVhDWdlnUFwRJzh/PlnFRxsiO4tiSlpsEj/p7H?=
 =?us-ascii?Q?15/v1VJYuK2AatSc7dbcTSG5NXTVUjFYUtrQy9MvFSJ9yNclAj01+BjhFa45?=
 =?us-ascii?Q?ZmCchFNyZ1eZrbkBz3oegWoDDwHm3dt5CGfRqG+Z?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d969145-70ef-48c8-6a27-08dc029db1b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 03:25:49.4164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtrS1OPfwJK4ONx6LikKH5df7I8H6b7U+SnNL6U/M4oIIyiF6EhHuJte5s6YRGkJDm6M9dm9ORIfKSZ3+tomRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8367
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 21, 2023 11:40 PM
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Wrap up the data pointer/num sanity and __iommu_copy_struct_from_user
> call for iommu drivers to copy driver specific data at a specific locatio=
n
> in the struct iommu_user_data_array, and
> iommu_respond_struct_to_user_array()
> to copy response to a specific location in the struct iommu_user_data_arr=
ay.
>=20
> And expect it to be used in cache_invalidate_user ops for example.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

