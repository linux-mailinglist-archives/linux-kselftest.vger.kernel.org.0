Return-Path: <linux-kselftest+bounces-2485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D181F4BD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 06:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C5F282D2A
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E2F1FDE;
	Thu, 28 Dec 2023 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8fg0JvH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB31FDC;
	Thu, 28 Dec 2023 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703741948; x=1735277948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5hnbpOrj455xwzbKl5sw2RZ8DMEFbXcjvV6a4OKycsc=;
  b=n8fg0JvHXi+6IhWL2yl/Tm3gU6L7y+NbvTs80qI1HTOat/e9byNkGn41
   1mofKuZhHVTMSd0SD6AVIsbcHiz6xsOUbQ+ewuZNTYFEwMuXndqm5x+zR
   5CT8zKGkauNyQE+huOuhu2y8U1IDU1ZUIbjSyy6CHnkR0V8xWywmNOkMV
   S86DnrxXjhR3kCUA3RLzqMZ/XYsjpsbaddiUYvuQSbojLC9qzo1kqWQTe
   jYDBbZmvOq/1zusAYbX39Jj6MufFFCVqiirdHtFeeR1r185L1fR/2coen
   4pMMc6P6RYpx0xWGhQSEi+pOg7sSW6dxAEZW7yKOLpqrfiiuwu8NLsVb5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3352344"
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="3352344"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 21:39:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,311,1695711600"; 
   d="scan'208";a="26769514"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Dec 2023 21:39:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Dec 2023 21:39:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Dec 2023 21:39:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Dec 2023 21:39:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f758VwdX/+Fzh6xITjRnjm+KARDE3UU0klhwMRmbiROVgUjH2IzXo7JtySBE8+fL+E14W3zF7Kel1T4JEtJ07+swNrbvrFkIHQh1JErZ+3DsHdqIklQodhSapXlDzQs7Ch9bhPUNaQgtvGcYdBkgn80ufaWZl3Ji3gM7LADkDr6v2bsgkrfzavSxIj1KJNbf+CpaGsvMB4xkoSFZE//+YFa5gcqbBEnM8n4x1gK8vByiJa2hEkrPnTGw5bTWOgKlgPvJt8OSEgvq71bjhgfrNcdDNve+lQtbgUsd3GPrgimk/JWXLXIT+puQKhLjFMyp/XWOSMaO7EgTPak6BXK4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hnbpOrj455xwzbKl5sw2RZ8DMEFbXcjvV6a4OKycsc=;
 b=HCJiPRZr+9oi+AQTXAU0f+qJEy6usWnY079Kloz1UaDIeEpVpUOv3FVS8xN5z2WW1oHhsq2QBo+aQQX3hhfr6g4uqiPUvWyMbgfAKVOLeSDD72pZk0DHi/oGTE27yT8UMN+GyQpA3nAgpYroCYRbxODsMROk/e/wCXF+X8JU3HVojTX0wXOfEwJ9h9KqUjz6or1DjrSy/HhkD4jRZUoMSlSseVtcZR7+xNsq6ilWMQ+TZMHorUCmwSAKwjAXhQeuPO4wFPNpjqza2JW9fcqOHnG8jOVTqeCHWerrIdalKwd3o+A23K/XPLg9ONvcCRFhlK7+lWQQWTmI4x8HweXUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN0PR11MB5693.namprd11.prod.outlook.com (2603:10b6:408:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 05:39:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a8e9:c80f:9484:f7cb%3]) with mapi id 15.20.7113.028; Thu, 28 Dec 2023
 05:39:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
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
	"j.granados@samsung.com" <j.granados@samsung.com>
Subject: RE: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Index: AQHaNCP7GmW4equSLUGDinfwDm7MnLC0tG4AgAZEKYCAAAJa8IAAIrCAgAApcoCAAZiNgIAAB4KAgABOFYCAAQAmIA==
Date: Thu, 28 Dec 2023 05:39:02 +0000
Message-ID: <BN9PR11MB527662143F57E0367D5618908C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
 <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
 <SJ0PR11MB67444BD4606F7A4014801B16929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ccdace4d-73a2-41c4-aa15-2d7b54e1d30e@linux.intel.com>
 <98226e62-90b8-44a6-9804-0356235ec34d@intel.com>
In-Reply-To: <98226e62-90b8-44a6-9804-0356235ec34d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN0PR11MB5693:EE_
x-ms-office365-filtering-correlation-id: aa0ea2f2-76ac-4fe1-dd26-08dc07674cc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZLuRokN/QS2wdg01CBhzVQN3oD8QfexYfMuF9kV1srHrE6jFaj0nTLOVpL5y/TlA+d8hy6ZqAEbYTVI2xuYATcS99fT60tFlOqlWqqg52DGxzVX3ZOVl25QwBTBy96TWghCo2RnAyHz3NFARsNhg78/pIOAJD8m6vnamzaSqrGdCEVZlU1Mr1kpmvs3QW084x1laEMazmJmbU60AeseBh+T46abC7WEXYUxs6HIrvQIchbyYjYW8IhNi+5S6nxyO+13RE4GDGo4uqxA8w79YIkmL8pPv9Ne0yiQ5tNMfjgoT9kTPe3IfsKEm1Az9h1YWOXLiFjjq0tvBwfg7hvLSep8KU/3oDAq6cQbIysQ32pH8hUIyA7Uf5WeciI07QauRihyQXLeX7uNqmPP+qI0jiHejc/RCsWO2Olz6tJfKDSUb84ViXTDO1B6n0UohY9xTefgXbZRK5I+RQVm855mIfS9VyNea1ySxJgU01L29j3Zb8F/EuZizLBc3AhOCB7OwnMUJO5K664oZomiUWA6Y8U+U1Dp1Q6IBSmyc0zq0sAJRx4dgzcvOHM6iKpvztYm4C8lqXkVj8J2czUtZal6a5RCRMNSwScM0gagP3UT6IwNvLieemZUkDBrd2NbXCeOtzOVQ3w4MMscP6JudQKzrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(52536014)(2906002)(4326008)(122000001)(8936002)(921011)(8676002)(38100700002)(83380400001)(26005)(5660300002)(7416002)(38070700009)(82960400001)(478600001)(71200400001)(33656002)(6506007)(55016003)(86362001)(110136005)(9686003)(53546011)(54906003)(316002)(41300700001)(76116006)(66946007)(7696005)(66446008)(64756008)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmhMck1XTmVRVGhvYUJrZTZSNml2SitaUVZlZ2s0MmdvT2lXSzJIRlRvM3l1?=
 =?utf-8?B?T3gzNVpram5STnE5TS9NSkU0ekIvVmI3TytoK0lTR2hDamZIS1ZjNjJTQmdZ?=
 =?utf-8?B?bG82VGQ4SmllcFVMTWovam1DR29wYm5VcHYvZjB1SVhqMkVwQkQxa3JYQ3Zz?=
 =?utf-8?B?Wm1WaWlOYk5ZRG1KNzhVcEt5ODR2M2dlZ2t6MXRGcG1wYzdZalRJTTc5STBk?=
 =?utf-8?B?TUZTLzdwWnhXckxkc2VZc3Q5amFJQnk2eXo4WDhubU5YN1dkSC9meWNRNllr?=
 =?utf-8?B?WXloVDRZMkVOYzJpM1lhNzlZZ1BQbk56S0F4VHVodk9ZMWxGL3ZZY0FEbHh5?=
 =?utf-8?B?M2F0a1JlMVNNWkw5djJZOUdrck15dHRKN29iT3Z5Z3BRbWlBaDZUQi8zNS9B?=
 =?utf-8?B?ekRqN29QR0pLRWE4VHRwZUVwaEJTQ2d1Y2o4UWtucUlQU2xQT1BHcEEvamNi?=
 =?utf-8?B?b1Z4STBNODZYS3ZIamJ3S05tRU5aRVpWMm15SFRyWnVkSWdSWmFiZkdFT1pQ?=
 =?utf-8?B?dFh5b3BZME8rN1pHRi84MHQ2bEpoc0Z6c1V2L2FKMnVDYXVVdDRVVW5TeDAx?=
 =?utf-8?B?ZTJDK0xlUmRlVEpad1hRVXpOSG54cHdvSFVoamJCN3YyendoaEYrdlp3UmUx?=
 =?utf-8?B?ZHVjaGhiSFVsNGxsWW1GOEcwWnFQUEY1RUJCYUFMK3luQnBydVdEOEp6S2pC?=
 =?utf-8?B?bm1RRnNQNXRrOVVNZU5Xa2Rjc0ZmUWttNUs1QVBGMXpVNEUvRmJjTW5GeU9x?=
 =?utf-8?B?bGZnUVlVV2w4S0M5TkV6V0tUeUhaMW4vaWFlNUFNMGpqKzUwOEc1Z0lEOFVh?=
 =?utf-8?B?UGFMZ254TytURU5jVEJyUUtFKzRLa1FpQVVCelBja25hWVNVYW0rQWU4Q250?=
 =?utf-8?B?bzNYcTA3bXkxNDdBWitJR1JLY2d5dHBBYTRuWnRIWitRNFhtYW1NM1NPMStQ?=
 =?utf-8?B?bVkycnlPdXhld1RwSjZzWW5nNFIwaWYySFVXZUViQXBnUXBYU2EzSWhUOWY5?=
 =?utf-8?B?b3N2WDZDa0xQVVc4VlI0TTM0T2ZpcUM3Z1FNcnFjZWlVdHV2Zzh6d0szeUMx?=
 =?utf-8?B?M0o2YTFReGl0RCsyRXFrdnBoVnUvaXNBcWxWZ2VyMFBNblpvOFJaQ1JFakN1?=
 =?utf-8?B?cWdMaWZyUHJxeXBsamVFMnVNQ004L0UzZHM5V3J1bHpVajFFS2lwcURZT0dH?=
 =?utf-8?B?Q3loQitCaHl2WUcvSVlVTzFTT2FscGErYkV2Si9qOTcyaVN5YXpoQmhBQWhX?=
 =?utf-8?B?VEdyb0dSYytadGh5VkFjWWwrTGl2alBzRktGak14aVhVZlpDb1RjYmE5aEZa?=
 =?utf-8?B?V2kyRzVYY2ptbzVVNzVLNVlVMTY3Q1FEdXdNRmNvY0ZOUVcxY1JuaEZueGZM?=
 =?utf-8?B?NHRpZFpqdW1Fdkc3S0ZDM2xkaUNwSndSNCtxTTZXdUJpa3hHTzRmRFVpVUhp?=
 =?utf-8?B?SEdVQzZYc3F6eUtmMjYrMzYyNlJ0UWRGd25YbDRqOXpGM2tTTG1HZXRQQ3Bz?=
 =?utf-8?B?MDU4THF4NFYvRk9xL1dvem04OUw5THYrSDBFb3Q4UWZqZjdkQjgyeVgvQVVX?=
 =?utf-8?B?Q2xnQ0tmNnhNZ1dMZk1NRHpWQ2ErTnh6T0xlNXppOTZmTlI0WjBWZHZIOWZ4?=
 =?utf-8?B?OGhYd2pISW1VU1RTQjlpeS9UUjRQOGJhM1dWcFpGWm5Mckw4MjNOKzBHNWMz?=
 =?utf-8?B?RUY3OHJwT0RFRlQyMEFYZzh4WU82b0p1QThCbUVnK3FWVDhuYUYvZDVZdVdU?=
 =?utf-8?B?YVlISnp3N3pIMWNHSTRTVk5reTVDblZIWTJya3lDMkFQd094dzFDQUsyd0p0?=
 =?utf-8?B?L0Nwa25PbWRwWDAxaHgzMit2QWJDZmVIK29SbTUzR3F0bjQxcnJ2QXNwL0xi?=
 =?utf-8?B?U2JQeGJCT0tHSWJWQkJJZzAvR2tzSm9jdEl3eHBVendUQnBQNll4NC9aVmg3?=
 =?utf-8?B?S0pTQW5VK0gzc2Uvd1l0ODVnNE40UmhZZnRtblFNVncvUDY3LzNlVUF2R3Rn?=
 =?utf-8?B?Vy9MZk12Ym5IQSsyTHUrQ25mODNmd0wydCs0bjFNSlhEY0doNHZVV2hKeERp?=
 =?utf-8?B?dGthQ1UrUEJWNUVCazVsT1p0L0cyUGs0dy9xVEFWUTJ4dHlzOUNPVGxXQTRW?=
 =?utf-8?Q?7O4Ind30suovRcclb7H6diZC5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0ea2f2-76ac-4fe1-dd26-08dc07674cc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 05:39:03.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwCcVtIIAvO+k0QkXoorWFB3kPGFULeVh3mn8ujDeTCpOcqz0FdC5GDH1tVPhGuu/zewRqs8uD3OOFcjG3m6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5693
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBEZWNlbWJlciAyNywgMjAyMyAxMDoxMyBQTQ0KPiANCj4gT24gMjAyMy8xMi8yNyAxNzozMywg
RXRoYW4gWmhhbyB3cm90ZToNCj4gPg0KPiA+IE9uIDEyLzI3LzIwMjMgNTowNiBQTSwgRHVhbiwg
Wmhlbnpob25nIHdyb3RlOg0KPiA+Pg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+Pj4gU2VudDog
VHVlc2RheSwgRGVjZW1iZXIgMjYsIDIwMjMgNDo0NCBQTQ0KPiA+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NyA3LzldIGlvbW11L3Z0LWQ6IEFsbG93IHFpX3N1Ym1pdF9zeW5jKCkgdG8NCj4gcmV0
dXJuDQo+ID4+PiB0aGUgUUkgZmF1bHRzDQo+ID4+Pg0KPiA+Pj4gT24gMjAyMy8xMi8yNiAxNDox
NSwgWWkgTGl1IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gT24gMjAyMy8xMi8yNiAxMjoxMywgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+Pj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4gPj4+Pj4+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDI2LCAyMDIzIDEyOjAzIFBN
DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gMjAyMy8xMi8yMiAxMjoyMywgVGlhbiwgS2V2aW4gd3Jv
dGU6DQo+ID4+Pj4+Pj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+
Pj4+Pj4+PiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjEsIDIwMjMgMTE6NDAgUE0NCj4gPj4+
Pj4+Pj4NCj4gPj4+Pj4+Pj4gK8KgwqDCoCBmYXVsdCAmPSBETUFfRlNUU19JUUUgfCBETUFfRlNU
U19JVEUgfCBETUFfRlNUU19JQ0U7DQo+ID4+Pj4+Pj4+ICvCoMKgwqAgaWYgKGZhdWx0KSB7DQo+
ID4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZnN0cykNCj4gPj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgKmZzdHMgfD0gZmF1bHQ7DQo+ID4+Pj4+Pj4gZG8gd2UgZXhwZWN0IHRo
ZSBmYXVsdCB0byBiZSBhY2N1bXVsYXRlZD8gb3RoZXJ3aXNlIGl0J3MgY2xlYXJlciB0bw0KPiA+
Pj4+Pj4+IGp1c3QgZG8gZGlyZWN0IGFzc2lnbm1lbnQgaW5zdGVhZCBvZiBhc2tpbmcgZm9yIHRo
ZSBjYWxsZXIgdG8gY2xlYXINCj4gPj4+Pj4+PiB0aGUgdmFyaWFibGUgYmVmb3JlIGludm9jYXRp
b24uDQo+ID4+Pj4+PiBub3QgcXVpdGUgZ2V0LiBkbyB5b3UgbWVhbiB0aGUgZmF1bHQgc2hvdWxk
IG5vdCBiZSBjbGVhcmVkIGluIHRoZQ0KPiBjYWxsZXINCj4gPj4+Pj4+IHNpZGU/DQo+ID4+Pj4+
Pg0KPiA+Pj4+PiBJIG1lYW50Og0KPiA+Pj4+Pg0KPiA+Pj4+PiDCoMKgwqDCoMKgaWYgKGZzdHMp
DQo+ID4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgKmZzdHMgPSBmYXVsdDsNCj4gPj4+Pj4NCj4gPj4+
Pj4gdW5sZXNzIHRoZXJlIGlzIGEgcmVhc29uIHRvICpPUiogdGhlIG9yaWdpbmFsIHZhbHVlLg0K
PiA+Pj4+IEkgZ3Vlc3Mgbm8gc3VjaCBhIHJlYXNvbi4gOikgbGV0IG1lIG1vZGlmeSBpdC4NCj4g
Pj4+IGhtbW0sIHJlcGxpZWQgdG9vIHNvb24uIFRoZSBxaV9jaGVja19mYXVsdCgpIHdvdWxkIGJl
IGNhbGxlZCBtdWx0aXBsZQ0KPiA+Pj4gdGltZXMgaW4gb25lIGludmFsaWRhdGlvbiBjaXJjbGUg
YXMgcWlfc3VibWl0X3N5bmMoKSBuZWVkcyB0byBzZWUgaWYgYW55DQo+ID4+PiBmYXVsdCBoYXBw
ZW5lZCBiZWZvcmUgdGhlIGh3IHdyaXRlcyBiYWNrIFFJX0RPTkUgdG8gdGhlIHdhaXQNCj4gZGVz
Y3JpcHRvci4NCj4gPj4+IFRoZXJlIGNhbiBiZSBJQ0Ugd2hpY2ggbWF5IGV2ZW50dWFsbHkgcmVz
dWx0IGluIElURS4gU28gY2FsbGVyIG9mDQo+ID4+PiBxaV9jaGVja19mYXVsdCgpDQo+ID4+PiB3
b3VsZCBjb250aW51ZSB0byB3YWl0IGZvciBRSV9ET05FLiBTbyBxaV9jaGVja19mYXVsdCgpIHJl
dHVybnMgMCB0byBsZXQNCj4gPj4+IHFpX3N1Ym1pdF9zeW5jKCkgZ28gb24gdGhvdWdoIElDRSBk
ZXRlY3RlZC4gSWYgd2UgdXNlICcqZnN0cyA9IGZhdWx0OycsDQo+ID4+PiB0aGVuIElDRSB3b3Vs
ZCBiZSBtaXNzZWQgc2luY2UgdGhlIGlucHV0IGZzdHMgcG9pbnRlciBpcyB0aGUgc2FtZSBpbg0K
PiA+Pj4gb25lIHFpX3N1Ym1pdF9zeW5jKCkgY2FsbC4NCj4gPj4gSXMgaXQgbmVjZXNzYXJ5IHRv
IHJldHVybiBmYXVsdCB0byB1c2VyIGlmIHFpX2NoZWNrX2ZhdWx0KCkgcmV0dXJuDQo+ID4+IC1F
QUdBSU4gYW5kDQo+ID4+IGEgcmVzdGFydCBydW4gc3VjY2VlZHM/DQo+IA0KPiBubyBuZWVkIGlm
IGEgcmVzdGFydCBzdWNjZWVkcy4gSSB3b3VsZCBhZGQgYSAqZmF1bHQgPSAwIHBlciB0aGUgcmVz
dGFydC4NCj4gDQo+ID4NCj4gPiBJc3N1ZSBhIGRldmljZS1UTEIgaW52YWxpZGF0aW9uIHRvIG5v
IHJlc3BvbnNlIGRldmljZSB0aGVyZSBpcyBwb3NzaWJpbGl0eQ0KPiA+DQo+ID4gd2lsbCBiZSB0
cmFwcGVkIHRoZXJlIGxvb3AgZm9yIElURSAsIG5ldmVyIGdldCByZXR1cm4uDQo+IA0KPiB5ZXMu
IFRoaXMgdGhlIGltcGxlbWVudGF0aW9uIHRvZGF5LCBpbiBmdXR1cmUgSSB0aGluayB3ZSBtYXkg
bmVlZCBhIGtpbmQNCj4gb2YgdGltZW91dCBtZWNoYW5pc20sIHNvIHRoYXQgaXQgY2FuIHJldHVy
biBhbmQgcmVwb3J0IHRoZSBlcnJvciB0byB1c2VyLg0KPiBJbiBjb25jZXB0LCBpbiBuZXN0ZWQg
dHJhbnNsYXRpb24sIHRoZSBwYWdlIHRhYmxlIGlzIG93bmVkIGJ5IHVzZXJzcGFjZSwgc28NCj4g
aXQgbWFrZXMgbW9yZSBzZW5zZSB0byBsZXQgdXNlcnNwYWNlIGtub3cgaXQgYW5kIHRha2UgcHJv
cGVyIGFjdGlvbi4NCj4gDQoNCml0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byByZXRyeSB1cG9uIGFu
IGludmFsaWRhdGlvbiByZXF1ZXN0IGZyb20gdXNlcnNwYWNlLg0KaWYgcmV0cnkgaXMgcmVxdWly
ZWQgdGhhdCBpcyB0aGUgcG9saWN5IG9mIGd1ZXN0IGlvbW11IGRyaXZlci4gQWxzbyBpdCdzIG5v
dA0KIGdvb2QgdG8gaW50cm9kdWNlIGEgdWFwaSBmbGFnIHdoaWNoIHdvbid0IGJlIHNldCBieSBj
dXJyZW50IGRyaXZlci4NCg0KdGhpcyBjYW4gYmUgc29sdmVkIGJ5IGEgc2ltcGxlIGNoYW5nZSBp
biBxaV9jaGVja19mYXVsdCgpOg0KDQoJaWYgKHFpLT5kZXNjX3N0YXR1c1t3YWl0X2luZGV4XSA9
PSBRSV9BQk9SVCkNCi0gCQlyZXR1cm4gLUVBR0FJTjsNCisJCXJldHVybiBmc3RzID8gLUVUSU1F
RE9VVCA6IC1FQUdBSU47DQoNCmJlY2F1c2UgaWYgdGhlIGNhbGxlciB3YW50cyB0byBrbm93IHRo
ZSBmYXVsdCByZWFzb24gdGhlIGltcGxpY2F0aW9uDQppcyB0aGF0IHRoZSBjYWxsZXIgd2lsbCBk
ZWNpZGUgaG93IHRvIGNvcGUgd2l0aCB0aGUgZmF1bHQuIEl0IGlzIGluY29ycmVjdA0KZm9yIHFp
X2NoZWNrX2ZhdWx0KCkgdG8gZGVjaWRlLg0K

