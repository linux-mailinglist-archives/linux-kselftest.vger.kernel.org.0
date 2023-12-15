Return-Path: <linux-kselftest+bounces-1978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25741813F70
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498C61C21F90
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C427E4;
	Fri, 15 Dec 2023 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6ONb73K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F157110EC;
	Fri, 15 Dec 2023 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702605015; x=1734141015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQ90CE9G6tfGt75w0yYXY6yQxKDoyD3RRDsAvq09C5A=;
  b=Z6ONb73KEUyoOcva6eh98585L/QO9uHCJLuZyiArFMvlDOsJYKLg1tVo
   XiEm04dyFeOL/mtoqafumC8wRsJa+9xcBFrPNZhBzJGd2LAgP6UfyIxHJ
   dqzf0cl94mbCb4kCCKNMd/+UDw+hYWQEyHjFogXY5vR4mc603pbdXvNCI
   hvgWiuYLZbOUj1A9eRrbmipUqLBPHmN1CKpDT/Gxc3IY+gmns8txp2UsL
   L4GyBNLxBbqPFhQ3Exq4X4vfUU9n3gxb9FvYAynIqaC5Du7df9Z9LvjeU
   7h49Bvh3wi9KziBmebMBD+bpeLRfwVXX9I/OXtdoMC2CQJTyxGMDogeDc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2375004"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2375004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:50:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803537982"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="803537982"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 17:50:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 17:50:13 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 17:50:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 17:50:12 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 17:50:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMduMJBE1nwvkjBBH4Ib9g/a4TkznM1aOnnTCuWHVWTgHWte0P6Q7CoOntJtovZ1cHbBEmpLgLmVGhfDOeHkffHAmKIM6PDY5dMwORK/lhuLUURaDwXyclXnD7cMKAUvnBI4LAXpExcwXrPqNPtYA+7wt+dqvj1X81GVA0u472NnFnd4N8UEmHyWtH/yoGexZWo3JHEGGcrOLON7WD3J64BnS/ODQHHJPgf9S0dLvUce/7HvID8orLTQyiGsKR9eSqSHDs/WrJ1ZadqKD6F1SkcNx+6QDM/MOY5whYktSuogrqyCa6nDoRvlmGH4s0g+0NWXSsIE8LxmQDplsQUzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ90CE9G6tfGt75w0yYXY6yQxKDoyD3RRDsAvq09C5A=;
 b=X7K6FEhYCEnxKFMblU/48eHBXJLWETnIf+VqE/kuCBtxGH6/fNdIcNG4ChJ/W9duNn0ZKNbEQw05iEzSA7NiEUUrKgchgOc7g+n0wXCUGlh421nxTYVRDDNaZ+0s3YPgOw7awS9UQKjjkKwjvyl7c9Xr+8KnmcpiAF61m6xzNLRW6njnOmETR0dJ0p13qqaTumj8OqLuWlcc7UuURArpF+rnfhZu/1pBdbsCqxvJzKeI1maOsiRyjmQo1jiyHBouNuHkvR/Jv2DO/paXYJYWY3UxvT5tlhkDA0RwkYw5gD+8Zf3RT6zkzuVkcURljCqlTtgYa1Tya5/qHyCMlt76nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 01:50:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 01:50:08 +0000
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
Subject: RE: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Thread-Topic: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Thread-Index: AQHaGViOWXGe59nutU2rEx/0zRDvrrCozh6AgADg1VA=
Date: Fri, 15 Dec 2023 01:50:07 +0000
Message-ID: <BN9PR11MB5276D14D2A7FF60B41A6A7B48C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
In-Reply-To: <c967e716-9112-4d1a-b6f7-9a005e28202d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 6561956f-9e45-47b4-9a68-08dbfd102a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 24/xKb8fswHowa/r3rs6WorenRW2+oUTHX3u69F2iz3x98e2BQk6xsokqg3wOv1/Pajag8z6SRIy1vyQtZTRBIoXGkhsqTuBkOrDGPMLbmXe8gJD4TA7n6UsZTpdUMAFTO+yqD+QsBPsSAaRKSE8YJb773uHEnUHiBdNH8/5o+xI7SI+YgkM57YTAA+/Bqk4bbIx7rcW/1Sydd125K1NBW5r7qDztzIhDU8wgc854Njcn3gdzpTLfknEh1zlc1emojRQhisQbGWh/hUt6rKsQbClGWP8G0fNgQupjhEkkSc7ZneyX0tZhIge0oobavH1AJMCo4tTGD7VoTyKz+2B4kxvBI9Gj3mUTR5IiV1kPRoz5W0enhlOv5HYss36vHTQX4WWdXt+SBtRIs99EA96R1fijpgj1/0zShRyK6WnWdWWgserLEH20LcjF3CSkH48haexNueRY+ylb/ULwD031OoB02HzgmX4T7gFJLv+PyqVd1igCeuWw6A+ixVNXVEwPjB71U+vKhnCv6aMSiFBjXx0mjrPh7TXU4HSiGqFtdmbKAp7mTzU1gy7K3gKgUJO8oXhqpumQPIyJq7KHbkqfIIJOfaVX+FIiuXAo0AESro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(122000001)(38100700002)(71200400001)(26005)(83380400001)(33656002)(86362001)(55016003)(38070700009)(82960400001)(7696005)(966005)(6506007)(478600001)(9686003)(66446008)(76116006)(64756008)(54906003)(66476007)(316002)(66556008)(110136005)(66946007)(8936002)(52536014)(4326008)(8676002)(2906002)(7416002)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djVMbXNkL2VjWDVaYTBYZWdOaXlPY0s5WkhIcTNnUHRJU2UySEUwOGxpQWdl?=
 =?utf-8?B?aFRvVUZYNUVrZ2cvVnhJWDJpenFURXA4TkM1a3NKU0lKcmQrSG9oUmI2Y0Mx?=
 =?utf-8?B?UFE2VEY0bDJDcGNNVUtkeUdIY1JWWmFHVW14WVh1cTNIdCsrNWgzaGt1UHdm?=
 =?utf-8?B?NlFaU1F3NUw5d3hzZTkzMjRrT3dDU2s0ZUZDMXkwSTlMREZLU0NDVW5uV1NW?=
 =?utf-8?B?akZjU2l6cWxmbW1rNjg0azYwMXdVdjJ5d1ZqSHlhZ28vcHlwUjlvT0JUTmZx?=
 =?utf-8?B?ZnU1VUdzLzUzOHpwU3hGdWNmWGxyUzN6M2M3UFpQK2hYMTI5Z1lhUmNDWkpw?=
 =?utf-8?B?TnI1TDVUdWpaRFJSQ0ZYNEY2am10V0pJSEl4MlBBZ09sb1pBT0Q4NXJHNGlV?=
 =?utf-8?B?UWlEazJkY2lKUzB0Q0NycWo3MFBScDlRMVBNcTlRTVNidzVQQjNJdzJUR0hO?=
 =?utf-8?B?OW5xKzRmK015Sk9uOEJJSlVpOUNQTzZRUDYrSFM0YStwbCtaUm5XT0JaeGVq?=
 =?utf-8?B?TXZoaVoyOW9XV3B0bWFLMzJ1TjNETmhHd21KRVc0YjkwN1V3OFJ3YkpyUUhJ?=
 =?utf-8?B?TktTSkdGMGswbmYwRXRPUWhuTDFWSFM4M0FNNE55WjhueXJOQUVYbHZMemFk?=
 =?utf-8?B?bitHQ0pqdWtINENORk94bittcnF5RHQvVWdDOFlNM1VycG5CTjhybFpTSmY0?=
 =?utf-8?B?WDM1b3BiZkpFa2g5NlRvYm9sZmlTVjhjWUJEWTRNU1lzang3QjVrTTVqdEpu?=
 =?utf-8?B?cy9OOFhkbGp2U2F2cVZUS3JiL3VHb25SU1RtZmMrVFdHYU14c1ZUTVJwTnBP?=
 =?utf-8?B?VGE2TFF2ZTh1MEp6N2F0QTVUQlBXWVZJMlR5NnVLcWFiQS9ZdWFibFc3OE1W?=
 =?utf-8?B?b3VGZkMvdFNyQVNQeVJiUDNPNmRVelZTVy9UN0Fna3haOTBFcVc0UStJb0ZL?=
 =?utf-8?B?d1NyblVMb0w1S0gyTU1BR1BWNEFKZFBpeGF0NWN5MGkzdDFRZFEydTVYR0ll?=
 =?utf-8?B?YkRrVWNwbnR3Y1YrTTVvbW42eENLVVFXcy9QVWtPNFpQOEgwQ3lHK2U1OW5D?=
 =?utf-8?B?YkhHTjZKVkZMUE5QZXBVeTNoK1VhTUowVzJqRHpNdlFCenpDWFVmaGhpV0ZG?=
 =?utf-8?B?Q1llT04yMW40YzRybTNvU1c2Nnp5ZjFhbTVSMTBGOTFaOWRvQk54ZWgxM0p1?=
 =?utf-8?B?aUJFUlpNV0hGUzNJV0dXOW5jRFY5TVQxVWVZb2Y2ekVCbjZ3b3ZWd1ZRMjY2?=
 =?utf-8?B?SkZFaEZMOE5tQkV6UU9Vb1l2SDZIMFRVUzhhZkc3TmdqNFZWT0pDb05JNmtk?=
 =?utf-8?B?OWFkRHBQYkF1R0FyVVBxSWxxQnJRZlhSNDB0anVFcTVLb2FhTFlYNitJUlFB?=
 =?utf-8?B?YU9EZDhQZ3d6Q09kc1RtV3R4cm9qWUlFNFBGQTc2SnJ0OEpjcktRUzJlVlR4?=
 =?utf-8?B?dDVESmtNQk94SHowRmkzL0JUbkFGTldkZzBJbjFaNUpCM2RlcHBiZkhvMHBv?=
 =?utf-8?B?YmNnQU1IcmVTSWltVjRQOGFCN3Q2Y0x3ME9pbEVMY2hoR3RuYjFZMkM2WVZ4?=
 =?utf-8?B?QzkxUG5lWkIvYjgrRW1xd3lqVFZCQW5kbWRYaXZ5RjlhU3hiTkV6cDk0a3lw?=
 =?utf-8?B?NUl5c1ZXaFlsZ21EWmhHcmRXVXF0THcwTzhVVEhSQTcwMWlBMWlaYkdWaXFy?=
 =?utf-8?B?U1ZLMHRtdUpIL0JvYmEyZHNJM2k2SXlGSEpPR3hhdnU4MzladWRJbnRON3lO?=
 =?utf-8?B?QVlIRlV4OTBRNGRxbE04NUs2Qk9DT3Q1Skh6M3pVRGJ1U0NaaHVZYXNWTmtp?=
 =?utf-8?B?NXR4YXRPTStaS0U2dlc1eHFWcHJkUjh5YVJFZzErTTRIRFJjdzRBd1h2MkE2?=
 =?utf-8?B?cGJJcHhXbUFEZExOZ3hBUVN3Z3VnRjZySzFPMEErZitQUzAyZ05paTVuQjUv?=
 =?utf-8?B?TUR2aVlPS2RwNnF1V2hxNzd5TER1aDVPSlhHeGdyWkdKMnBsN3lib0wxQ09D?=
 =?utf-8?B?T3RmQXBKdk1UZDRXWUNwU0dwVHdTeldZSmphSHJtUDA2MmExb2R5YW5CYTB2?=
 =?utf-8?B?cEFrTUVqRnZMcC9OemdqWGhmMlBwRWN0UFpYd0pYeDlBNjN6V0tUcWt6SVMv?=
 =?utf-8?Q?ALA8Tb8ItI16Y8zE6fcU7/69q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6561956f-9e45-47b4-9a68-08dbfd102a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 01:50:07.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2TsBRc7xrrebPkT3V3v3I/y3aTR5JTngeUfHJURbwGxwe0Lq9Bndnil8XFLd/N1mWFu6cSyOtqJzk9fOOdPoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IERlY2VtYmVyIDE0LCAyMDIzIDc6MjcgUE0NCj4gDQo+IE9uIDIwMjMvMTEvMTcgMjE6MTgsIFlp
IExpdSB3cm90ZTo+IFRoaXMgYWRkcyB0aGUgZGF0YSBzdHJ1Y3R1cmUgZm9yDQo+IGZsdXNoaW5n
IGlvdGxiIGZvciB0aGUgbmVzdGVkIGRvbWFpbg0KPiANCj4gK3N0cnVjdCBpb21tdV9od3B0X3Z0
ZF9zMV9pbnZhbGlkYXRlIHsNCj4gKwlfX2FsaWduZWRfdTY0IGFkZHI7DQo+ICsJX19hbGlnbmVk
X3U2NCBucGFnZXM7DQo+ICsJX191MzIgZmxhZ3M7DQo+ICsJX191MzIgX19yZXNlcnZlZDsNCj4g
KwlfX3UzMiBlcnJvcjsNCj4gKwlfX3UzMiBkZXZfaWQ7DQo+ICt9Ow0KPiANCj4gZGV2X2lkIGlz
IHVzZWQgdG8gcmVwb3J0IHRoZSBmYWlsZWQgZGV2aWNlLCB1c2Vyc3BhY2Ugc2hvdWxkIGJlIGFi
bGUgdG8gbWFwDQo+IGl0IHRvIGEgdlJJRCwgYW5kIGluamVjdCBpdCB0byBWTSBhcyBwYXJ0IG9m
IElURS9JQ0UgZXJyb3IuDQo+IA0KPiBIb3dldmVyLCBJIGdvdCBhIHByb2JsZW0gd2hlbiB0cnlp
bmcgdG8gZ2V0IGRldl9pZCBpbiBjYWNoZSBpbnZhbGlkYXRpb24NCj4gcGF0aCwgc2luY2UgdGhp
cyBpcyBmaWxsZWQgaW4gaW50ZWwgaW9tbXUgZHJpdmVyLiBTZWVtcyBsaWtlIHRoZXJlIGlzIG5v
DQo+IGdvb2Qgd2F5IGZvciBpdC4gSSd2ZSBiZWxvdyBhbHRlcm5hdGl2ZXMgdG8gbW92ZSBmb3J3
YXJkLCB3aXNoIHlvdSBoYXZlDQo+IGEgbG9vay4NCj4gDQo+IC0gUmVwb3J0aW5nIHBTSUQgaW5z
dGVhZCBvZiBkZXZfaWQuIFRoaXMgbWF5IG5vdCB3b3JrIGlmIHVzZXJzcGFjZSBmb3INCj4gZXhh
bXBsZSBRZW11IGNlbiBnZXQgYSB2ZmlvIGRldmljZSBjZGV2IGZkIGZyb20gbWFuYWdlbWVudCBz
dGFjay4gTWF5YmUNCj4geW91DQo+IGhhdmUgZGlmZmVyZW50IG9waW5pb24sIGRvIGxldCBtZSBr
bm93Lg0KDQp5ZXMsIHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGF0IHBSSUQgaXMgYWx3YXlzIHZp
c2libGUgdG8gdGhlIHVzZXIuDQoNCj4gDQo+IC0gTGV0IGlvbW11ZmQgdG8gY29udmVydCBhIFNJ
RCBpbmZvIG9yIGRldmljZSBwb2ludGVyIHRvIGEgZGV2X2lkLCBhbmQgdGhlbg0KPiByZXBvcnQg
aXQgYmFjayB0byB1c2Vyc3BhY2UuIFRoaXMgc2VlbXMgZWFzaWVzdCwgYnV0IGJyZWFrcyBsYXll
ciBhbmQgYWxzbw0KPiByZXF1aXJlcyB2dC1kIHNwZWNpZmljIGxvZ2ljLiA6KA0KDQp5ZXMsIHRo
ZSBjdXJyZW50IHBoaWxvc29waHkgb2YgaW9tbXVmZCBpcyB0byBwdXQgZGl2ZXIgc3BlY2lmaWMg
a25vd2xlZGdlDQpvdXQgb2YgaW9tbXVmZC4NCg0KPiANCj4gLSBSZXVzZSBOaWNvbGluJ3MgdlJJ
RC0+cFJJRCBtYXBwaW5nLiBJZiB0aGV2UklELT5wUklEIG1hcHBpbmcgaXMNCj4gbWFpbnRhaW5l
ZCwgdGhlbiBpbnRlbCBpb21tdSBjYW4gcmVwb3J0IGEgdlJJRCBiYWNrIHRvIHVzZXIuIEJ1dCBp
bnRlbA0KPiBpb21tdSBkcml2ZXIgZG9lcyBub3QgaGF2ZSB2aW9tbXUgY29udGV4dCwgbm8gcGxh
Y2UgdG8gaG9sZCB0aGUgdlJJRC0NCj4gPnBSSUQNCj4gbWFwcGluZy4gVEJILiBJdCBtYXkgcmVx
dWlyZSBvdGhlciByZWFzb25zIHRvIGludHJvZHVjZSBpdCBvdGhlciB0aGFuIHRoZQ0KPiBlcnJv
ciByZXBvcnRpbmcgbmVlZC4gQW55aG93LCB0aGlzIHJlcXVpcmVzIG1vcmUgdGhpbmtpbmcgYW5k
IGFsc28gaGFzDQo+IGRlcGVuZGVuY3kgZXZlbiBpZiBpdCBpcyBkb2FibGUgaW4gaW50ZWwgc2lk
ZS4NCg0KdGhpcyBzb3VuZHMgbGlrZSBhIGNsZWFuZXIgd2F5IHRvIGluamVjdCBrbm93bGVkZ2Ug
d2hpY2ggaW9tbXUgZHJpdmVyDQpyZXF1aXJlcyB0byBmaW5kIG91dCB0aGUgdXNlciB0YWcuIGJ1
dCB5ZXMgaXQncyBhIGJpdCB3ZWlyZCB0byBpbnRyb2R1Y2UNCnZpb21tdSBhd2FyZW5lc3MgaW4g
aW50ZWwgaW9tbXUgZHJpdmVyIHdoZW4gdGhlcmUgaXMgbm8gc3VjaCB0aGluZw0KaW4gcmVhbCBo
YXJkd2FyZS4NCg0KYW5kIGZvciB0aGlzIGVycm9yIHJlcG9ydGluZyBjYXNlIHdoYXQgd2UgYWN0
dWFsbHkgcmVxdWlyZSBpcyB0aGUNCnJldmVyc2UgbWFwIGkuZS4gcFJJRC0+dlJJRC4gTm90IHN1
cmUgd2hldGhlciB3ZSBjYW4gbGV2ZXJhZ2UgdGhlDQpzYW1lIFJJRCBtYXBwaW5nIHVBUEkgYXMg
Zm9yIEFSTS9BTUQgYnV0IGlnbm9yZSB2aW9tbXVfaWQNCmFuZCB0aGVuIHN0b3JlIHZSSUQgdW5k
ZXIgZGV2aWNlX2RvbWFpbl9pbmZvLiBhIGJpdCB0cmlja3kgb24NCmxpZmUgY3ljbGUgbWFuYWdl
bWVudCBhbmQgYWxzbyBpbmNvbXBhdGlibGUgd2l0aCBTSU9WLi4uDQoNCmxldCdzIHNlZSB3aGV0
aGVyIEphc29uIGhhcyBhIGJldHRlciBpZGVhIGhlcmUuDQoNCj4gDQo+IC0gT25seSByZXBvcnQg
ZXJyb3IgY29kZSwgYnV0IG5vIGRldmljZSBpbmZvIGF0IGZpcnN0LiBNYXkgYWRkaW5nIHRoZQ0K
PiBkZXZpY2UgaW5mbyAoZGV2X2lkIG9yIHZSSUQpIGluIGZ1dHVyZSBzZXJpZXMuIEluIHJlYWxp
dHksIHRoZSBleGlzdGluZw0KPiBRZW11IHZJT01NVSBkb2VzIG5vdCByZXBvcnQgSUNFLCBJVEUs
IG5laXRoZXIgdGhlIFNJRCB0byBWTS4gQWxzbywgVlQtZA0KDQphbmQgSU9BU19VTk1BUCBkb2Vz
bid0IHByb3ZpZGUgc3VjaCBBVFMgZXJyb3IgZWl0aGVyLg0KDQo+IHNwZWMgZGVmaW5lZCB0aGUg
SUNFL0lURSBlcnJvcnMgZmlyc3QgaW4gMjAwNyBzcGVjIDEuMSwgYW5kIGFkZGVkIFNJRCBpbmZv
DQo+IGxhdGVyIGluIDIwMTkgc3BlYyAzLjEuIFdlIG1heSBkbyBpdCBpbiBzdGFnZSBhcyB3ZWxs
Lg0KDQphbmQgaXQncyBub3QgdGllZCB0byBhIHNwZWNpZmljIGlvbW11IHZlcnNpb24uIHRoZSBz
cGVjIGlzIHN0YXRlZCBpbiANCmEgd2F5IHRoYXQgc29mdHdhcmUgdHJlYXRzIHplcm8gdmFsdWUg
aW4gU0lEIGFzIG5vIGh3IHN1cHBvcnQgc28NCnRoZW9yZXRpY2FsbHkgZXZlbiBhIG1vZGVybiBo
dyBtYXkgbm90IHJlcG9ydCBTSUQgZm9yIGNlcnRhaW4NCnJlYXNvbi4NCg0KPiANCj4gV2hhdCBh
Ym91dCB5b3VyIG9waW5pb24/DQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtaW9tbXUvYTk2OTlmNzEtODA1YS00YTVhLTkyODItDQo+IDNlYzUyZTViYzgxYUBpbnRl
bC5jb20vDQoNCkknbSBmaW5lIHdpdGggdGhpcyBzdGFnZWQgYXBwcm9hY2ggZ2l2ZW4gdGhlIHNw
ZWMgYWxsb3dzIHRoaXMNCmJlaGF2aW9yIGFuZCBubyB2SU9NTVUgcHJvcGVybHkgZW11bGF0ZXMg
SVRFL0lDRSB0b2RheS4gDQoNCmxldCdzIHdvcmsgb3V0IGEgbmV3IHZlcnNpb24gdy9vIGRldiBp
bmZvIGFuZCBtYWtlIHN1cmUgaXQncw0KaW4gYSBnb29kIHN0YXRlIGZpcnN0LiBUaGVuIGxldCBK
YXNvbiBkZWNpZGUgbmV4dCB3ZWVrIHdoZXRoZXINCmhlIHdhbnRzIHRvIHRha2UgaXQgZm9yIHRo
aXMgY3ljbGUgb3Igbm90Lg0KDQo=

