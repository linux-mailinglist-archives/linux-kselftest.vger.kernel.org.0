Return-Path: <linux-kselftest+bounces-2355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694DD81C56C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 08:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2178828855F
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325A8F6A;
	Fri, 22 Dec 2023 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qn2ulM/a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EAF9D2;
	Fri, 22 Dec 2023 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703229160; x=1734765160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Bcjxgof/w7k4RBsY6qba22HxLNjbDRCMEDFuY9omRM=;
  b=Qn2ulM/agl0KbJhbkgdx5+pMXCCfC4IhtNlV110G/+wHaAq+fjLdWJD1
   UwQ49fMvXkr4a+AAbXqW5W7jGGhOmlEim6ay7q+pTr/6FmUKM62DLgY++
   aIaiE3i7olWmEkFeQ1hcCSBK3wqJrrhE/a96hQ0cvECM58axOEtq7bMPG
   2xYKqW1jkoLpDPzOngfb1KvomGiAjmi3OW5ESTXOOkXO7d5L3ON+arrBo
   sAFxpF4GDDllm8Uy2Jnx8QCwlUNA0981hbYGVoXhRjYCa5/Ayy/ROXYnr
   QrzAC5XLSXsbQj49QNJLVZPM6AsoiHyuwjSkBklOcZuhni7590bGVEYN4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="386510382"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="386510382"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 23:12:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900343305"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="900343305"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 23:12:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 23:12:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 23:12:39 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 23:12:39 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 23:12:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvSg6QRECBQB6fK8dPRQ47++EHsQT040eY9NtqIzNYeM3w+XRrMY1XT15lyumEIkCCkaq1DWFNHlXeqMrsTsrtDYWZhvYI/S0Oby8SM1VJC93a2uP1ytgsyIVxafXxmLfcMIi6tYWuWKwlIuvl3lj750nuYewCaXbwz2TmdcN1XfO/hAsLRZPPCyHwo7a6RGvlFQMIJi3lTQxFi35GeQrnv1o9kjU8D72Go1mSjGvIjues0M8VrAXC5MXyusRiuG37uUI85XNuQQVxqFSg7atZbRq0dB20wAKdMDin8plLs7vzYEsxkG49xGsaCxtKNujGjdTjNPO1JrUIYSREp6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bcjxgof/w7k4RBsY6qba22HxLNjbDRCMEDFuY9omRM=;
 b=l7+mRMwY8xjY795EDK13VNs+oqxWJOGwBKF83Q0P8lNT2TBNXasXhOzkFCYXivF/DgvGzEQybpwTrnAH5+EzPPqC0L6x/DQ9dXJhkcJ4vo4JvLK8qNq4h0+Umj9Vrej55WQxi41aecRP1wVAyaDByDEM1PKmNjWeSeVXugDXdYZfbbefFhjJhJJFhu2QMD7LOWH0q3xuMsRZtqF6dUGtpmcJnP+SybKHPGwuOiwyNoWhX7KhI+eEzD9GIPvsjLjbWB4cjRAsAHBgF6ZN4l29azV1PIJPqFUjFHG4uLz1X2tnYK5K2K23AtwXtZf98DXheMYI66ReXNqsNUR9kL9RUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6855.namprd11.prod.outlook.com (2603:10b6:510:22c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Fri, 22 Dec
 2023 07:12:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 07:12:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
CC: "Yang, Weijiang" <weijiang.yang@intel.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>, "j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Topic: [PATCH v7 9/9] iommu/vt-d: Add iotlb flush for nested domain
Thread-Index: AQHaNCP4zqzfCm0YG0WB/drS+mURdLC0rU2AgAAu8lCAAATlAIAAAm9Q
Date: Fri, 22 Dec 2023 07:12:36 +0000
Message-ID: <BN9PR11MB527672402F30F701A5EA53028C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-10-yi.l.liu@intel.com>
 <f6302d8e-fd5f-45e1-8148-e5812c61f5c0@intel.com>
 <BN9PR11MB52766A289D2CA50F8BD802F18C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <D35102EE-F1E8-4888-8A5E-A1A723B3363D@intel.com>
In-Reply-To: <D35102EE-F1E8-4888-8A5E-A1A723B3363D@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6855:EE_
x-ms-office365-filtering-correlation-id: 6edbbae7-297d-4ded-6ad2-08dc02bd6075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o6OuTa4L9gVhFeAkgnhFAdRdWgYOVwYITWFBrvCXvXO6FtTNS+RJjfpWd9SGcZKbv+DwJSdmbJXEFAoMfH8jmHYKYIEckhGKon4EtdVA+Hrb9CU0WvpTjiXOXvh8nmiVqf0CAVf3MwKuAhLZ0aQKmC884YICSdOaMjNWK8LuK/hamt859pmHoYTe00UmJQYXQ5XDsTulVXMHd0UJjrjj4oQgL1i7R3U2aR3KnUmSSOVVhJMfWxMTPMW7HicFrOXumxEczvXNlVFIPIZDbJiDL0x+kdNm8oo0ieSsLmAtDisO32xjCwo1XTa/cROhDY6D74o4lL7wnZiuQHthzyqnhN4HCQu1zQ0Ypu0nUovTAY6CyHDhJhXU/rCdc8nAw9Uxaid/yF3ifQJaT/I/wr8AnMA3MUljJehHWW78wc0SJfxIoE7Ke3H4ulPNY99FdrK7kRkDg2Fcslkqru47MvU3DAalYZXShh5KtvAcpc7Jl1yrKpIfFBrkJwEC50626EwrQQtYPJ4oWRuLEvfEE09NXZSCx/o2pFPN5gK0hAOwE2NI9vbfZTUdy4hsjfVTjNi4f/KUQGyditkWhuMfUkMC7DokxclnQVT1ex/eUMkq7mhbWpRDPr5WgdTNubVqT07H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(55016003)(478600001)(5660300002)(38100700002)(7696005)(71200400001)(6506007)(53546011)(9686003)(66476007)(66556008)(76116006)(66946007)(6862004)(4326008)(66446008)(52536014)(122000001)(8936002)(8676002)(38070700009)(33656002)(41300700001)(2906002)(86362001)(64756008)(54906003)(4744005)(6636002)(316002)(7416002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHplZklSZXpHZy95cGdrV0xmZDVvNWFoNXp4R1hYandkZEQ4b1ovd2kzM0Vp?=
 =?utf-8?B?SndOWUpxOTg5cUhMVzBuY0psSjZaazkwaytNemlFZVQ2c1lSWS8vclZiRW1H?=
 =?utf-8?B?UVJuL3ZEMGRtejhLNHFnK0dEWTRic0FxL3VqU0w3dnZ5U3l4Y3pEMmhoVUlt?=
 =?utf-8?B?Zlc5Qkc2WTFQdGwyd05UWThkMEszbEZvS1EwZ01nMXAxWXlhdjVFZXI2WGE1?=
 =?utf-8?B?ZHlBcWZ6RCsxM09Xdk9nb3hLdlc0Ynl5K0U2WG5BaEZlTytDZkJLL3BSSitw?=
 =?utf-8?B?MmZzeXlxM2FkRHJ1c05iSkdhclpvRTN0TldBZWZZdEtsdjdpTUFldkplMkVU?=
 =?utf-8?B?a3Q1K1JmNWR2QVpyb0xaNkNQTWxlMHY5ak9IOVdWaGx5OVZ0Ni9NZVBES29y?=
 =?utf-8?B?WHFMTTFIbDhSZ1pBZzNtak0xV0RaOXAzb1o1NGpQRTdUMXlTZE44YlNRRlNF?=
 =?utf-8?B?aGdFamQxR1l6Tkp4MXMzVzRQSFpOaWE5LzMrSWY3RjZ4OEliZ3Nhc0ozaVNr?=
 =?utf-8?B?RXJyYk5qRVdnS0pvcDBKc3ZnK0RyaktLbndtZVN5N01WQy9NcUJmbldsK2ZT?=
 =?utf-8?B?WW1DeEp6cDdqNU43MkRXYTAxNmg0eVJZWmV4L2hsdjN0VldrWXNTY0VrTmxr?=
 =?utf-8?B?VzIzYWNGY0pmdjFid2VTRjd6OXZaVWFkV2w0OTAyeC9zZmpYN1pGR052Z1Jh?=
 =?utf-8?B?cFNzNXZYUElNUzR4c0lHVjlKNm9CWGVMMzMxbGp4WlVVdndzc1JHRU9ONXFC?=
 =?utf-8?B?RGZVS1pPZGw4ZnFYdVlWVS9QYVNzLzhZbytUN2hxbGhXdXh6N2FPRWIycXY0?=
 =?utf-8?B?WTczM0xOZVVnbE9kczJxQW96NnlpbFRDL2t3VFBCTWphcmVvcldIOHJZSk1n?=
 =?utf-8?B?UWRvYWU0SUV3aWlGSjJ6UEUvYjUyYzh5cURZMXQ1MHEyV01kUlo3OFFVNmN5?=
 =?utf-8?B?VndmbzlrZmFrRGxIbmV4T1J6WWlqQzRqeThxTHNaVXk5eVE3ZHVmYldBd1lh?=
 =?utf-8?B?YU1xdVprdWVQUGRhN0NRTXE5YWt5UWxNbnF4M3Qzc25NQ0MyMlZPSXZDNXZ6?=
 =?utf-8?B?YVhIdVVNRVQ1WEhvMjU0Q1F6Sno5NEIzTzZzRlJWTGMxd3dpQUw2c0NYdEhR?=
 =?utf-8?B?cUZVOE9YbEdldXFaWSsvdHZrWVJwZ0hLRHJFYXJpb0Zub2JtVFk3dnAwdTRH?=
 =?utf-8?B?MXY1eUJJN2YxR3o0M3lCeTJCY2dzcS8yeHhYZEY5cENydTRDVlh6Mi9hRmRh?=
 =?utf-8?B?YTRaZjhkZklubFMzb3RuRGJlbGc3TGUvaG9tNDFCZ1pGWXpkbTdxS3pDSnRY?=
 =?utf-8?B?bG1jQWp3eFdiT1doNThQbTZvWFU1Mkd6QThNKzhuWmxzZUd0SnBmMEV2Rjhh?=
 =?utf-8?B?a25uUk1uRWkySHVhY1VnT1lUYUtiVUhyYXlSOGZYYWVEKy9pcXlweS9QN3Fz?=
 =?utf-8?B?eGFlR1VnV1hqTW9PT0tkbER3V0VPRE1VK1lIT3IrSC9TK3NWTEZTUS96aVBV?=
 =?utf-8?B?bkpoZzJJdzRqSWNCOHZnemV6SENraUxEWFBQRWZPS3lmVUFscUNKekxLbzFx?=
 =?utf-8?B?L3RpV09SOTdLS2QzeUV2UFQ4VVdZVzQxME9zbVMxdFVtRVErY1JVdWY5ejNr?=
 =?utf-8?B?bHYzcjQwWlFlejBNbnZMeEpvc0ZUOXFONC8zbmJRV1JiZWFlNklGWkV1cWJv?=
 =?utf-8?B?Z0p2Z3BvWUlIbE93UkQzWmRXZmRVUU1uOVhEVGY1cmd2eEtDQmE0R1h6Zmht?=
 =?utf-8?B?eDVRZVcxVUF3WnlDY0w5djlIYTF5WG9qNVdody9uWDJRQ2x6QzdEbFgxbE1V?=
 =?utf-8?B?R0dHcjJ6OGg2QzZOMmFvMDJKVWxsY3NqRGdtWStOTUhsTWRiY0NOUXRZMzhI?=
 =?utf-8?B?RzV0bWZaV3hLWmpET2F4bXI0ZkdRTjBRVWlZTWNUUHhQQXV4eUJrdUQ2enJC?=
 =?utf-8?B?b1NlQ3JjajdTQ2Ezc0NQNjI2UDkwb3RHeWxqS2lhbGJVVmczek40OGJ4N1Z2?=
 =?utf-8?B?Y1UxMUJ6Zk9sT1I0M0xqY1JJdHNVS2dLQW9IUll1VytNN2twUzAvS0ErSTZl?=
 =?utf-8?B?R0ZCTGlvaVM0REhwVFhIQXZVSFQvZ2VhckFjaFJGNkp1MjdPOXpveW10RmxB?=
 =?utf-8?Q?+2Zi7dJzpobDsmi/cVPnXgsLB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edbbae7-297d-4ded-6ad2-08dc02bd6075
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 07:12:37.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qtqd+9bBr5ZsrER9raHwWrhR7ZMJTvKBwjK8hP4Tq18ajw6btJ26+PVttOje9Lg+2G31VhW/6s5Hx6f8hqWO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6855
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBE
ZWNlbWJlciAyMiwgMjAyMyAzOjAyIFBNDQo+IA0KPiANCj4gPiBPbiBEZWMgMjIsIDIwMjMsIGF0
IDE0OjQ3LCBUaWFuLCBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gDQo+ID4+DQo+ID4+IEZyb206IFlhbmcsIFdlaWppYW5nIDx3ZWlqaWFuZy55YW5nQGludGVs
LmNvbT4NCj4gPj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAyMiwgMjAyMyAxMTo1NiBBTQ0KPiA+
Pj4gKw0KPiA+Pj4gKyAgICB4YV9mb3JfZWFjaCgmZG9tYWluLT5pb21tdV9hcnJheSwgaSwgaW5m
bykgew0KPiA+Pj4gKyAgICAgICAgbmVzdGVkX2ZsdXNoX3Bhc2lkX2lvdGxiKGluZm8tPmlvbW11
LCBkb21haW4sIGFkZHIsDQo+ID4+IG5wYWdlcywgMCk7DQo+ID4+PiArDQo+ID4+PiArICAgICAg
ICBpZiAoZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlKQ0KPiA+Pj4gKyAgICAgICAgICAgIGNvbnRp
bnVlOw0KPiA+Pg0KPiA+PiBTaG91bGRuJ3QgdGhpcyBiZSBpZiAoIWRvbWFpbi0+aGFzX2lvdGxi
X2RldmljZSk/DQo+ID4NCj4gPiB5ZXMgdGhhdCBpcyB3cm9uZy4NCj4gPg0KPiA+IGFjdHVhbGx5
IGl0J3Mgd2VpcmQgdG8gcHV0IGRvbWFpbiBjaGVjayBpbiBhIGxvb3Agb2YgZG9tYWluLT5pb21t
dV9hcnJheS4NCj4gPg0KPiA+IHRoYXQgY2hlY2sgYWxvbmcgd2l0aCBkZXZ0bGIgZmx1c2ggc2hv
dWxkIGJlIGRvbmUgb3V0IG9mIHRoYXQgbG9vcC4NCj4gDQo+IE1heWJlIGFkZGluZyBhIGJvb2ws
IHNldCBpdCBvdXQgb2YgdGhlIGxvb3AsIGNoZWNrIHRoZSBib29sIGluIHRoZSBsb29wLg0KDQp0
aGUgcG9pbnQgaXMgdGhhdCBkZXYgaW90bGIgZG9lc24ndCByZWx5IG9uIGluZm8tPmlvbW11Og0K
DQoJbmVzdGVkX2ZsdXNoX2Rldl9pb3RsYihkb21haW4sIGFkZHIsIG1hc2ssICZmYXVsdCk7DQoN
CnRoZW4gd2h5IGRvIGl0IGluIHRoZSBsb29wIG9mIGluZm8tPmlvbW11Pw0KDQo=

