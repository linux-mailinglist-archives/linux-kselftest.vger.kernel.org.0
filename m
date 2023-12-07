Return-Path: <linux-kselftest+bounces-1344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA48083C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 10:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD45E1C21F5C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC17328AD;
	Thu,  7 Dec 2023 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InYzJ8zc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6728A19A;
	Thu,  7 Dec 2023 01:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701939845; x=1733475845;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uIT1DviaN8d8RpfXv4VKyeWMAnvEKuE8oc0KabGnCsU=;
  b=InYzJ8zcssOozuArjfshjuzNpoKk5t2uF121XnwXFhIO0XN7UYyYZgM+
   sXGLFP9vFooJ2e2GXNq/4aIG9uGa8bDdgZgTjOd7Ko6eYTqjN1OyNn4EB
   T/GxzTkDHg+7tIbgvFpsSkbgdk1Fk155OPMRVikc62Rx7IZ2gjoqlMy/J
   YW5H+7WMHrwpiUOIhy5fXjzTeWLWW3Im52t+SZdK6GMZ7JQImIhXr+l3a
   nOaXJljyyODeRAZOz+VSdiggktmSBl3J+qv99DIkEgI25cJTg0Z0Li4vU
   XmC+8SfoQsBSJb/fJJeJsvPb2faLBl+3UrwEANauA4zfGcRIp0/F1Pvw9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="373689279"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="373689279"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 01:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1103136359"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103136359"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 01:04:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 01:04:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 01:04:03 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 01:04:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnODt+I4hsvHgcslize7voGc39axZr3WLIGDcZoQ1Wgvz9rEytoDRheVmnPgOZ4i+MVksLgf49HKeF0/dKL66QdUK7hKmzzTwZ+n8WMWYNf0x3Tw8y08bAh0OKOk2JmyUOA4yQLtB+ioDucdfgkldZELEMbmF0OAtAtHl+3dbcx7Ve91TUcMzN14hrlyhtpDZgHr/NIT5dQdQCiSZLW4ExSmdabiT1O7NcQsQ5d5BP6dbmlJLT9yRScpahMPdkmtWua4NCdgIxELHZsXWCae1shMrUWx8UAvzfOIgXV1XaO33GtJ2jvFYP55p3b7vXX5+mTmBU6HbcdSQPMyHUZwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIT1DviaN8d8RpfXv4VKyeWMAnvEKuE8oc0KabGnCsU=;
 b=HMF7y1bn9Da9okRGGdzq2L8r9Ch7BkvUeKv9hs3rfumrMKBEiM5XJJw7gDn4JfZuixTkyarunFf61oFrknsTo0MHKrzqY0bul1Il7FkfO0Y/bokL7+gr8a+pg1ObSh2FzxuLP5u+BZafO8mwLIWykrDao1/UYvavl/6KzqLHADCD/tg6p1u0eoZvelrj/Q1xkLLaV4uLLtYkzaZb4+Xz9NYDn0I63o9bfpBepL+Tl5g0I3kJaMaR0EgHKBIi3n5ppvcafq3bdZvi2R0SFeqBlOLvcq4JGbI145nmKJw74MWAnDfk3t7mJMMEF0ErjFpBkGfIOHdWy96kkjSMVrACyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4900.namprd11.prod.outlook.com (2603:10b6:303:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 09:04:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 09:04:01 +0000
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
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCdgxuAgAAhbmA=
Date: Thu, 7 Dec 2023 09:04:00 +0000
Message-ID: <BN9PR11MB5276283CAEAB7A24871B4B188C8BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
In-Reply-To: <112383df-3ea3-475f-963f-5c53232a1bf4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4900:EE_
x-ms-office365-filtering-correlation-id: 9573ba17-c9e3-446d-6f5e-08dbf7037412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uFQY30qpPlinAGhThQikIprBpHQMc0KGpyMNu6fzS7H0AwzfIt0jS760Hpj2Bxwouu6J5esrzCEuvjf9/7jSGr3VtrZVtHErAS9JTsM/GZ+Vf/tUJ9r2ZATGLriwLjx4i4jTlIZzv7XX9ZI7uKbV10fOERqaZDOFJM6Bm3XmE7fAksB21ODIU578zF1DukS6K7VOe69cT/tlH03O/LbRk9EbPFkg6w5EZcPScGdSqJni8ZCyoedGkvmEOeNXZoRfoiFVpGOnPPEohX+rQgKnpgK4E7PL6b/bFGbdixRoDJzDmspthFFq0tp/mi4HoJRtc4MSLpXxnw4AHeS7jz3BYBDP+ZN6EAXIOf3JnCQe/1v0KiGO9nYifYB0ozha1QCIHaJlvvOb8q+Sw3wPgjmQyuoHp2/g9kcVRYbHNekS6wiECLr8Hlsh/a6PYm1gaDUm+qjTYt8g6mUWExteg+iqqQF5hAQtMaPuHxIC9ku+efp7WaASDeoHp+gewf5hvLoQpsWR7G9I01FU5V/4HEx38sWw9HupJZCkNNKl9pS/0e0rWscxMEdV6gMQXOeDhJFNghl9kYznVxTnznv16zrwCeVvXEa4E0+eS98hE3LM3uE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(71200400001)(26005)(86362001)(38100700002)(82960400001)(33656002)(122000001)(38070700009)(83380400001)(4326008)(316002)(8676002)(52536014)(66946007)(76116006)(64756008)(66446008)(54906003)(66556008)(66476007)(7416002)(2906002)(5660300002)(8936002)(55016003)(110136005)(7696005)(6506007)(53546011)(41300700001)(9686003)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2tseGpJMVZIUXZMazNLYVNqak5CVkVZd29EVFhlWURXRHU3bCs5T2tYam5r?=
 =?utf-8?B?Sm1PL3owVjYzbmRSS0lQYU5sL2tXRFNqNWNaR0V3dnpQQksyVDJFZS9Wdnhp?=
 =?utf-8?B?a1NldUw1MGFGQS80MU5zRUZ5SlhSVm9UUG1JUmZIUHpLVHBRZHp6SzJLdzZk?=
 =?utf-8?B?TnJ6cFkyaEdpa1dZVWhEb1hRRFQzcGFxU3hCL05wcWlZNXpvWlMrNGFQYng2?=
 =?utf-8?B?TkhuM0hmdkJtRGZjZ29MUDVlZkNQcTdyRmhtTCtzYU9uMUR5V2VWWkowWHhn?=
 =?utf-8?B?VmZiR3JaOU45bWZQRDBjMUxwMFNJZkRrKzBiZk8zbnc0QVZwR2Zjbi9jQXdz?=
 =?utf-8?B?UkhBVXk0ZWRLMFNLQkdaV09yRlhGZVZoRGhIMndod0ZBeUZ2THM5UFV0WFVk?=
 =?utf-8?B?S25XbnNUZDBVVDFZZWp5MEZnU1UzMEhUbzZqN0tvODJnSWx0UDRkMEdGQ1VT?=
 =?utf-8?B?Y2NNeE9weHVOQ25NREhFaHNyZ0dKcU5rMVdDaXZMK2UvYmorZGd4MW5rVVg5?=
 =?utf-8?B?T3o3ZVF2MFg3cXpZUFh1T0U0RHRFajliTGxvWmtEZWdkM1FYS283NG5UTEY4?=
 =?utf-8?B?VTg3ZHhqRmFUaldaS2VIeUFrUHZPajVuanF2VEJJYTVoTzExWXpOeTRQbUFz?=
 =?utf-8?B?Vmp2Y1REd05jMmFZWjc1elE1ZmZpRWdEbmNHMVdRaHdKMWxtUTRJT1FaV3c2?=
 =?utf-8?B?VENBcVJpRkpqZE5KSVk2RzN1ZzdSNzhacXU2MCtqVGRGRjczTCtVTEhqMXY1?=
 =?utf-8?B?ZUIvYXVNd2w3ZjRGd0h1Nk10YlA1NlRiQ1RaUnBZWjVTTzdTM3h3WDErNkRH?=
 =?utf-8?B?UlpEQTdGNUNtU09QN3NJeWwxQUpUSGlkRDRaK2IyVDJCK2xRM25DWXplaVM2?=
 =?utf-8?B?QUVjb3NqUFd1YkNIUzRVWkduQStyL3JpVE02LzZmM1BYWUw0K1h6R0k5OVVI?=
 =?utf-8?B?K0Z1WlRIK1l1U25ZQzIvT1J5RDNMZ0RWa0hSMnRWRTAvLzUzQ0JSc3hEZG5M?=
 =?utf-8?B?bEFVT3NyYkZORG5qNzFFYlRFUndnelJkOFM5ZVZmTStJcGhNQTZXK1I1S2Jv?=
 =?utf-8?B?QzVtMTFla3BGYXY2MzZQZURGSXRsNlJNL0JhMkIxaVY3SHo5ejlvVFNpUEdT?=
 =?utf-8?B?U3F6bnZCT0k0TEtFMURtVkdiT0NtaXlqaFJEVjVMenhCL01lc2RZMDJwSHBi?=
 =?utf-8?B?bll0SVJxc3N1RGlzUVE5V2IzRzVpS203djJPbFdaZll0bWFYcTdvSkZjNjg2?=
 =?utf-8?B?dVlQQjZjWkdEYTRkZ2hrUk9NdERrZ3NoZTA0aHpzSk9oS2s1TE50MGQ5K1JM?=
 =?utf-8?B?N1d2eXllNDNmRmNlQi96SkZ1bURUZS82SGFYb3lNcXBUeGZNV2xPY1pkeVJs?=
 =?utf-8?B?eTBIQlV0NXBjcDQ1cVhaTWtXblB0dVFaMEJONDFtLzFiMm1qVUpvR0JlSmph?=
 =?utf-8?B?M2JLam1ua055UmNqc2IxZnYzcys2ak81c2RBellzNVpobnczakFuVThhTlND?=
 =?utf-8?B?aXE1Y2VhOG9hY0YrUHhRSmlpT0ZwckhBRlRhQkVLMjNrRWlpUk44NDI1ajg5?=
 =?utf-8?B?Si9GelhhNDArMU5SSjQ5NWF3dVYrcTczazJjUkFSWktSc0VKcE4zV3EyRnRG?=
 =?utf-8?B?VTR4U0g3SXVHbVFlaldxVDFlNlpodnR3MTBkaEFCUkNxVHVubHRCSGlhRUdz?=
 =?utf-8?B?SlRXMkFHLzZzanI4UkpZRXZGbS9qZ3dKUTVZQUdTNkoxR1FWL2dFYktXdFVT?=
 =?utf-8?B?d2xnSlRSUDUrZGFKMVdnMWg1OFZERElXQkVzYnVYSDlROXdnbEVucDA5TXNj?=
 =?utf-8?B?NmVndktVeFFYLy9Mb0I0clladWxDNlN2aW5ZbUJidUZMRHVISDJQVTNjR3dW?=
 =?utf-8?B?S3dEMUlnQVBlV293RGxwOGlFUlpjZHdyOEtzSG5yWDFia2k0WnBubWNZN3Bp?=
 =?utf-8?B?ckFzRE9WbE5xZThGdk9PZk5LY0xwV3RnaGFDbWxaNTVWQmlZM0NWSmZJWEMz?=
 =?utf-8?B?N0NvREVuMHFkWklSSTVQSUtBS0lDczVpLzh1d1ZyYXE1WFBMbU93emcrRkZt?=
 =?utf-8?B?MzJndXJsa0IyZHlISzdXTFFXaTFKTkVOZ1huc2FscmRPdUZpeXM1NmdrWVVH?=
 =?utf-8?Q?oIrwFYttxFHrTD5u0tmcVBMw0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9573ba17-c9e3-446d-6f5e-08dbf7037412
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 09:04:00.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haN1HiG507wl6ADeeblmZ8rflc+uaQ9ZbIFfvG07tAW3fMLykNyOvFQdrG38d1LTX2k5OGahquvsgJoVb4mfgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4900
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IERlY2VtYmVyIDcsIDIwMjMgMjo1OSBQTQ0KPiANCj4gT24gMjAyMy8xMS8xNyAyMTowNywgWWkg
TGl1IHdyb3RlOg0KPiA+IEBAIC02MTMsNCArNjE0LDM4IEBAIHN0cnVjdCBpb21tdV9od3B0X2dl
dF9kaXJ0eV9iaXRtYXAgew0KPiA+ICAgI2RlZmluZSBJT01NVV9IV1BUX0dFVF9ESVJUWV9CSVRN
QVAgX0lPKElPTU1VRkRfVFlQRSwgXA0KPiA+DQo+IAlJT01NVUZEX0NNRF9IV1BUX0dFVF9ESVJU
WV9CSVRNQVApDQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIHN0cnVjdCBpb21tdV9od3B0X2ludmFs
aWRhdGUgLSBpb2N0bChJT01NVV9IV1BUX0lOVkFMSURBVEUpDQo+ID4gKyAqIEBzaXplOiBzaXpl
b2Yoc3RydWN0IGlvbW11X2h3cHRfaW52YWxpZGF0ZSkNCj4gPiArICogQGh3cHRfaWQ6IEhXUFQg
SUQgb2YgYSBuZXN0ZWQgSFdQVCBmb3IgY2FjaGUgaW52YWxpZGF0aW9uDQo+ID4gKyAqIEByZXFz
X3VwdHI6IFVzZXIgcG9pbnRlciB0byBhbiBhcnJheSBoYXZpbmcgQHJlcV9udW0gb2YgY2FjaGUN
Cj4gaW52YWxpZGF0aW9uDQo+ID4gKyAqICAgICAgICAgICAgIHJlcXVlc3RzLiBUaGUgcmVxdWVz
dCBlbnRyaWVzIGluIHRoZSBhcnJheSBhcmUgb2YgZml4ZWQgd2lkdGgNCj4gPiArICogICAgICAg
ICAgICAgQHJlcV9sZW4sIGFuZCBjb250YWluIGEgdXNlciBkYXRhIHN0cnVjdHVyZSBmb3IgaW52
YWxpZGF0aW9uDQo+ID4gKyAqICAgICAgICAgICAgIHJlcXVlc3Qgc3BlY2lmaWMgdG8gdGhlIGdp
dmVuIGhhcmR3YXJlIHBhZ2UgdGFibGUuDQo+ID4gKyAqIEByZXFfdHlwZTogT25lIG9mIGVudW0g
aW9tbXVfaHdwdF9kYXRhX3R5cGUsIGRlZmluaW5nIHRoZSBkYXRhDQo+IHR5cGUgb2YgYWxsDQo+
ID4gKyAqICAgICAgICAgICAgdGhlIGVudHJpZXMgaW4gdGhlIGludmFsaWRhdGlvbiByZXF1ZXN0
IGFycmF5LiBJdCBzaG91bGQgc3VpdA0KPiA+ICsgKiAgICAgICAgICAgIHdpdGggdGhlIGRhdGFf
dHlwZSBwYXNzZWQgcGVyIHRoZSBhbGxvY2F0aW9uIG9mIHRoZSBod3B0IHBvaW50ZWQNCj4gPiAr
ICogICAgICAgICAgICBieSBAaHdwdF9pZC4NCj4gDQo+IEBKYXNvbiBhbmQgS2V2aW4sDQo+IA0K
PiBIZXJlIGEgY2hlY2sgd2l0aCB5b3UgdHdvLiBJIGhhZCBhIGNvbnZlcnNhdGlvbiB3aXRoIE5p
YyBvbiB0aGUgZGVmaW5pdGlvbg0KPiBvZiByZXFfdHlwZSBoZXJlLiBJdCB3YXMgYWRkZWQgdG8g
c3VwcG9ydCBwb3RlbnRpYWwgbXVsdGlwbGUga2luZHMgb2YgY2FjaGUNCj4gaW52YWxpZGF0aW9u
IGRhdGEgdHlwZXMgZm9yIGEgaW52YWxpZGF0aW5nIGNhY2hlIGZvciBhIHNpbmdsZSBod3B0IHR5
cGVbMV0uDQo+IEJ1dCB3ZSBkZWZpbmVkIGl0IGFzIHJldXNpbmcgdGhlIGh3cHRfZGF0YV90eXBl
LiBJbiB0aGlzIHdheSwgaXQgaXMgbm90DQo+IGFibGUgdG8gc3VwcG9ydCB0aGUgcG90ZW50aWFs
IGNhc2UgaW5bMV0uIGlzIGl0PyBTaGFsbCB3ZSBkZWZpbmUgYSBzZXBhcmF0ZQ0KPiBlbnVtIGZv
ciBpbnZhbGlkYXRpb24gZGF0YSB0eXBlcz8gQW5kIGhvdyBjYW4gd2UgbGV0IHVzZXIga25vdyB0
aGUNCj4gYXZhaWxhYmxlIGludmFsaWRhdGlvbiBkYXRhIHR5cGVzIGZvciBhIGh3cHQgdHlwZT8g
QW55IGlkZWE/DQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtDQo+IGlv
bW11LzIwMjMxMDE4MTYzNzIwLkdBMzk1MkBudmlkaWEuY29tLw0KPiANCg0KRnJvbSB0aGF0IHRo
cmVhZCBKYXNvbiBtZW50aW9uZWQgdG8gbWFrZSB0aGUgaW52YWxpZGF0aW9uIGZvcm1hdA0KcGFy
dCBvZiBkb21haW4gYWxsb2NhdGlvbi4gSWYgdGhhdCBpcyB0aGUgZGlyZWN0aW9uIHRvIGdvIHRo
ZW4gdGhlcmUNCndvbid0IGJlIG11bHRpcGxlIGludmFsaWRhdGlvbiBmb3JtYXRzIHBlciBod3B0
LiBUaGUgdXNlciBzaG91bGQNCmNyZWF0ZSBtdWx0aXBsZSBod3B0J3MgcGVyIGludmFsaWRhdGlv
biBmb3JtYXQgKHRob3VnaCBtaXhpbmcNCmZvcm1hdHMgaW4gb25lIHZpcnR1YWwgcGxhdGZvcm0g
aXMgdmVyeSB1bmxpa2VseSk/DQo=

