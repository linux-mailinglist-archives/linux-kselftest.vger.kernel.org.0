Return-Path: <linux-kselftest+bounces-2438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457EA81E646
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAC4282D11
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Dec 2023 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432BA4D102;
	Tue, 26 Dec 2023 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gniguDC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FCB4CE10;
	Tue, 26 Dec 2023 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703582532; x=1735118532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8T3h+BirvFFzauJQ04PAnYWlDwdiLeh9PbKhpsoFQVk=;
  b=gniguDC+SCnh8Z2yXMISJW2ZD4aRsUHB9rL/cLmx1Ei3xsliEl6uvJqV
   c2bGbwluXaiZT7tC0b5ngkn50P0r3LIuufykw1pi1fe7Vfuyj12jMN2dp
   ukoFJOjvulDU5VoyRNm8KOKDizBH/OHvaVHtsKKPnvAiPriet2s1Hr1Rh
   fJtB3Yrd+LCuQ1ryVkZpCZLWY5oVvYjuHR7Wjs2EobgJbNHi8gSkMO2iE
   PhnAdBZ9Lv7kJ6bng0Khs1BPkLSvIiJjrBgZZSazbFy7qkQ7Md9Hmdgn0
   uhJNb1qUEE5z3S+r0Oa0q020rUQpNdMxnS1EcUIVNOIn8tn8in4Rv3ptc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="460664947"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="460664947"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 01:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="848388538"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="848388538"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Dec 2023 01:21:59 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 01:21:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 01:21:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Dec 2023 01:21:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPJ93mMWDHq0gNSHKJcPf1EZF0HlPUIS/J6Dd8lUI24NVMNZcFtUW71OZokWWg/+zseURcgbrQS4Em+QKlU/P+a0A+tjH98bQgP0o0YODVYFExLPZQrUq+Mgxb08N0hH2Gfazqhx4vIY1gNq6cFYXbr4J49Qkfdkf2eBxdVAbwm9vKA70+Cudxwk2BFeaTV3MR6FYfRhJk9q7Z1h2wbmHgEuISMoMChRl+Vxgci2xoRmugn5yE8eNWPAIZTE1zjezJWUnnBPSGynRqNSR/7czy7yggSehvIzppE5WYKWxO6hkzq16xk5SSKerwV2YhflTg7CcOPnHix0A9hKyAKSHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T3h+BirvFFzauJQ04PAnYWlDwdiLeh9PbKhpsoFQVk=;
 b=Er8GFOpdBuq+EODPwH5AF9QErJlvaknECWHiYVNylNJLVKZzZc9tZLxvBfETpcYU9h8qMPB0KF5WBEPoFrc26JWMDaPZke5+Y7rBcvdaPVzQliL1N7tyDYC8qBmB4iQzM2u6LMXCfiCeTZNgkutzqIXZZaQEhAWEikagNFu25iENJlXLpOLKNdF6kTsQTs5+hXJ6Er4peAlVrjI4opAI+S4J/DXznYaqCcnvDxebN1Ree6zp/ZIalcm3hN5maMZ3mAsRnyX6vTw/QSYI+mbdXHjm5tNKeUe0qw/PzwxQIfwXPWVZYS2z/HTMm7gv5DEnB8mWro3dpyK//PLxqtTjbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 09:21:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 09:21:50 +0000
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
Subject: RE: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Topic: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
Thread-Index: AQHaNCP7GmW4equSLUGDinfwDm7MnLC0tG4AgAZEKYCAAAJa8IAAIrCAgAApcoCAAAposA==
Date: Tue, 26 Dec 2023 09:21:49 +0000
Message-ID: <BN9PR11MB52760792870B09E97694B2928C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
 <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
In-Reply-To: <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6135:EE_
x-ms-office365-filtering-correlation-id: 0468dc63-cbb8-4d8b-c574-08dc05f416d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHxzzES/spJjW+xHu45c3qP1ezzw/OszrTOawHIm7nixihaG72OjkU/auWtiAQk3n5x56/ei+HgrGPnPNBMF1tFe+LLh6FED2FPqNQUPbHs0nno5Tyl9hC+7BWUl5DlDsCszr1TqIP9+/RwdxRA8sXJSPtm8MNs2Wqbr2SyinVyPGduMQQXmpybJ1JuOr2pTOtO7iVuWyeHIQkdyPFGTLTwKBbpwCtbyBf3DCVu9U4swcszCLACM0LW+EzhRlG3HyzylyDQMCiLEWb143tcF9aUofqBgl3P/aQ57RSaO72eLyBuqSo5F/ofP0H24Rx5n0GMoKuXqOIGzLtCJTaonaWhpXe55HfTHkwSh4xGr6EOK4h3E2rv+JX/DWKU8DdNICCEk78iD/f/CEiu1lnmx2vufpJkoEWrMyehAdxI2jXU38H8SJlelaeGUZIiwfMFEYx6kN4oblzP2v3W2aMIgg7ooSYjOCHuA4olcPWWyD9VEDGukAL4hy0wbL1XBc9OXW76rIDu8sQLoEzjGSQZpGG8UrJIBY4sd02IN7CF05alOwNdZJkDKeEvDOSyjKeS2gbnDrF41RBiEtuWtDfQlg9ZTlbpU2plZgJuS1UnlHzt75suX5LzyE7oDgBfA+k8U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(38100700002)(26005)(122000001)(82960400001)(316002)(2906002)(8676002)(4326008)(110136005)(52536014)(54906003)(7416002)(5660300002)(478600001)(8936002)(71200400001)(53546011)(6506007)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(9686003)(86362001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzBodlA2U0t3U2ZlOHcyQVV6dXhMeFFrWWJsQ255OHRkd25NYmpINEVMZlRm?=
 =?utf-8?B?M2dGTVJCdi9vRDd6ZzhCSVF6Zmlzb0tXKzVNQjNXZXRyVkRSeUlMQmF2dkpj?=
 =?utf-8?B?NGIxb25SUTMxR1ppTnJmeVpNRUg5S2J2REROMlZIU1hXeWladDYweXdxRDJr?=
 =?utf-8?B?L1F3VHgvQW96WHhWUHlsMElpT2ZoNk1TQUZOOUVFVEh5clV0UnMvUmN4Y2gz?=
 =?utf-8?B?c3o3Z3IyRmR4akxUbTNFck9KNGdMR0JwNGYySVFZeDFpc2RVRmlsU1hyM0VB?=
 =?utf-8?B?SXJpcWd3Y0doSHhjUUtFSWYwZHViWkRpb2wrbkltb3hlakVNVnFLY0tXY3pa?=
 =?utf-8?B?STk4dGJOQS9tRVFld2c2VWJPRjRwRnRSWUpBWDJmTC9rNGhiQVJmME8ybktX?=
 =?utf-8?B?eWFYMWVObHBubXlBeGRMYnhtYTlSOGxEV3l6VFdJSW54aGlTNCsyM2tVekt2?=
 =?utf-8?B?c1V2L2xVckcrNUYxeklEU1ZJL2ZZdnM2WGVnQmJIeVlhV1M0ZHFEWjVTV09y?=
 =?utf-8?B?ci9WSEJnWlg5VHVUVFZYbGV2TW5WOEdFcHBYbGE5L3RiZ0VtTzlVNGJMaUpD?=
 =?utf-8?B?b0tiU1BiZjF2aS9URVZ1SWt1YjIzOTA1YzU2eFJKY1BiQmtHRktyeWJhNzhZ?=
 =?utf-8?B?dkZwSE5KeHlPbmpndUw3VzFHd3JWVFJXQkNtZ3M0U1JwV1VvUlRkVWFINVhW?=
 =?utf-8?B?OGdZMm5yNE9QeTViejllWUp4SENCMjlTUWEvalFNeFJHQ3N4bVNBNzVnTUZt?=
 =?utf-8?B?SDFTd2thZmNjTEJlaHZEQnNFTUYrRjh6NWk2OE5PSERwZ2ZLc3AxWEo0RjV0?=
 =?utf-8?B?TlhvZHFNZjN4ZXJZRnZ2dkxTUnh2d2FxZ3pNOGY1R2kvMThsNUpCa01CVGVI?=
 =?utf-8?B?MFRGS29KSDRPL05XMkN3c0NsZ1pyK2JtN0ZFY3ZQTm1ZSWM3RXFoeEw5VXQ5?=
 =?utf-8?B?UGs0NmVxd3dQd3AzbHpnT21FanpWaHhVUytRQS9WSmNNVW54YVpPTEJHNHJB?=
 =?utf-8?B?ZVV4OC9sUWZHczRkK3lMbmYrYVlXTHN4c1pRSUxxRTVPam52VThXY0ZjaDNu?=
 =?utf-8?B?TTBaRSs3WTZLMFJnZ2EyV0U0Mndyd1FLSkVrNExlU0M1dWlMeWg5WFF4SFdL?=
 =?utf-8?B?enZ2QlVTdy9sQ2hPeHJZNE9FOWNxN0k5VnlpNkhBSlBJV25HTHBlNDJyQlk4?=
 =?utf-8?B?Kzk3SUFlekpTK1R4cktaSEh0M094SHpLWlpjYkZIQnQrL1BxNHc3MWRRWFBt?=
 =?utf-8?B?aWlRdzRLNUZvWWVxdlh2bEUwMjRSMEVqV0x4NldUc0FnR0VBQytjaHMzR3o0?=
 =?utf-8?B?RFJrUDlRakVLTExNMHpkVTJZbnpiQnlnQ3hNTkRSbU5qOXBvbWhIc216S1Zt?=
 =?utf-8?B?TlpwQVFDM1RnQjkxTHFzVnZTYVhFNEtRcmxCVkZ0QUg1TGh2UE9aWmNKOVBE?=
 =?utf-8?B?NHBkZFBEU3A2cGVwdlNUWVRvbzFwWUozMU9vZjNJbUhHUkxYOTByVE9MYUd1?=
 =?utf-8?B?SzZRQWFoL2l3R1dmdnNwTnVQbDRmUXgrY1MzTzluSDcrc0ZDTkpYUmwrSmJO?=
 =?utf-8?B?OEwxWWdRTHp5RDJBOExQY0NjeEVXQ1hmSGxTbFkxNHMyNFRmT1BpTXo0c3N6?=
 =?utf-8?B?R3dxa1lGUURVcVpab2FIcUwzYzZDc1h3dmVYdHRublFaZUdDMWlzZmxYZWJR?=
 =?utf-8?B?NGhUcFFTZDhFVS9ucFcvS0oxdi9oV2xucGphMnROb0xRME42TDNHVnFWbTFk?=
 =?utf-8?B?K2NqaGZkdmVqRitrQTV0UXR4QnJvNkZIajQ5VDRCa2VrSzkwNHNMbFY1SnUv?=
 =?utf-8?B?amlJVm1PNm9rVzBWdHNaZE5HUy94VG0xcU13ZVNhQjY1c0hDU0lMRVp2UXhN?=
 =?utf-8?B?dWE3Kzgya1ZsWTlUL0Q4dEROV1RkZ1JzcGdVV3AzRGsydlY2M2VEaDRBWXhz?=
 =?utf-8?B?MVR6WVAyaWFqaWNQaWVXTEFMWFJ3U3J4RHJKS2dzYzZOUEM1VENGa1NBYlJi?=
 =?utf-8?B?SWhQb3RNaTBPZEdvY2hNQWd2TlVKdjR5cEZkbDVWR1JKNWN5RU5sa25qUjhB?=
 =?utf-8?B?dGR3eVVOdktiMy95d0lFbUpDdU5obE1qZUIxM21jSUNoMUo3MmJIRW9nQ0lF?=
 =?utf-8?Q?UdTzQgfpUwDQ4PNoGtaEPbSv9?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0468dc63-cbb8-4d8b-c574-08dc05f416d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 09:21:49.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0mP6tMzCw6RtoAXndl0PkIEQYZ/NOZH5lIilNXWonGvFI0IYj1kelOuyOlfErFyFod1usaKa9goINSTSb+7e0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RGVjZW1iZXIgMjYsIDIwMjMgNDo0NCBQTQ0KPiANCj4gT24gMjAyMy8xMi8yNiAxNDoxNSwgWWkg
TGl1IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiAyMDIzLzEyLzI2IDEyOjEzLCBUaWFuLCBLZXZp
biB3cm90ZToNCj4gPj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+
Pj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjYsIDIwMjMgMTI6MDMgUE0NCj4gPj4+DQo+ID4+
PiBPbiAyMDIzLzEyLzIyIDEyOjIzLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4+Pj4gRnJvbTog
TGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4+Pj4+IFNlbnQ6IFRodXJzZGF5LCBE
ZWNlbWJlciAyMSwgMjAyMyAxMTo0MCBQTQ0KPiA+Pj4+Pg0KPiA+Pj4+PiArwqDCoMKgIGZhdWx0
ICY9IERNQV9GU1RTX0lRRSB8IERNQV9GU1RTX0lURSB8IERNQV9GU1RTX0lDRTsNCj4gPj4+Pj4g
K8KgwqDCoCBpZiAoZmF1bHQpIHsNCj4gPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChmc3RzKQ0K
PiA+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqZnN0cyB8PSBmYXVsdDsNCj4gPj4+Pg0K
PiA+Pj4+IGRvIHdlIGV4cGVjdCB0aGUgZmF1bHQgdG8gYmUgYWNjdW11bGF0ZWQ/IG90aGVyd2lz
ZSBpdCdzIGNsZWFyZXIgdG8NCj4gPj4+PiBqdXN0IGRvIGRpcmVjdCBhc3NpZ25tZW50IGluc3Rl
YWQgb2YgYXNraW5nIGZvciB0aGUgY2FsbGVyIHRvIGNsZWFyDQo+ID4+Pj4gdGhlIHZhcmlhYmxl
IGJlZm9yZSBpbnZvY2F0aW9uLg0KPiA+Pj4NCj4gPj4+IG5vdCBxdWl0ZSBnZXQuIGRvIHlvdSBt
ZWFuIHRoZSBmYXVsdCBzaG91bGQgbm90IGJlIGNsZWFyZWQgaW4gdGhlIGNhbGxlcg0KPiA+Pj4g
c2lkZT8NCj4gPj4+DQo+ID4+DQo+ID4+IEkgbWVhbnQ6DQo+ID4+DQo+ID4+IMKgwqDCoMKgaWYg
KGZzdHMpDQo+ID4+IMKgwqDCoMKgwqDCoMKgICpmc3RzID0gZmF1bHQ7DQo+ID4+DQo+ID4+IHVu
bGVzcyB0aGVyZSBpcyBhIHJlYXNvbiB0byAqT1IqIHRoZSBvcmlnaW5hbCB2YWx1ZS4NCj4gPg0K
PiA+IEkgZ3Vlc3Mgbm8gc3VjaCBhIHJlYXNvbi4gOikgbGV0IG1lIG1vZGlmeSBpdC4NCj4gDQo+
IGhtbW0sIHJlcGxpZWQgdG9vIHNvb24uIFRoZSBxaV9jaGVja19mYXVsdCgpIHdvdWxkIGJlIGNh
bGxlZCBtdWx0aXBsZQ0KPiB0aW1lcyBpbiBvbmUgaW52YWxpZGF0aW9uIGNpcmNsZSBhcyBxaV9z
dWJtaXRfc3luYygpIG5lZWRzIHRvIHNlZSBpZiBhbnkNCj4gZmF1bHQgaGFwcGVuZWQgYmVmb3Jl
IHRoZSBodyB3cml0ZXMgYmFjayBRSV9ET05FIHRvIHRoZSB3YWl0IGRlc2NyaXB0b3IuDQo+IFRo
ZXJlIGNhbiBiZSBJQ0Ugd2hpY2ggbWF5IGV2ZW50dWFsbHkgcmVzdWx0IGluIElURS4gU28gY2Fs
bGVyIG9mDQo+IHFpX2NoZWNrX2ZhdWx0KCkNCj4gd291bGQgY29udGludWUgdG8gd2FpdCBmb3Ig
UUlfRE9ORS4gU28gcWlfY2hlY2tfZmF1bHQoKSByZXR1cm5zIDAgdG8gbGV0DQo+IHFpX3N1Ym1p
dF9zeW5jKCkgZ28gb24gdGhvdWdoIElDRSBkZXRlY3RlZC4gSWYgd2UgdXNlICcqZnN0cyA9IGZh
dWx0OycsDQo+IHRoZW4gSUNFIHdvdWxkIGJlIG1pc3NlZCBzaW5jZSB0aGUgaW5wdXQgZnN0cyBw
b2ludGVyIGlzIHRoZSBzYW1lIGluDQo+IG9uZSBxaV9zdWJtaXRfc3luYygpIGNhbGwuDQo+IA0K
DQpvaywgdGhhdCBtYWtlcyBzZW5zZSB0aGVuLg0K

