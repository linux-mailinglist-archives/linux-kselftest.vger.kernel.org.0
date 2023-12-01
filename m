Return-Path: <linux-kselftest+bounces-946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3928800471
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 08:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA7B20FAF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 07:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18664125A8;
	Fri,  1 Dec 2023 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/CGUUg2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD8D1720;
	Thu, 30 Nov 2023 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701414627; x=1732950627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I4LL89jBflgEFhG7aLLkhzqQP3ALN94TNshFNHCxCMY=;
  b=F/CGUUg2i4lDpKrDJ5pRNBT3qO/mw3fkRJ2JdfvShD4rWuvRFh3ixWhU
   cnimOV+OCWFzNoT0cPBF2+GklABNGPRhbvpkiIdU9u0f8KbHEkcVf8AjQ
   YA1kCYWXQWOEO5w5CeI75QFZh7buGBERef26d5BqWWNrQ/NJ70lNvsuXH
   Se2bFDeXKVChFSNdvp8m7usi2L3OSMM2a3NL6n4bgdUlycDjT+jmUL/BN
   CVYih2EoMsOlN11injOk1W/4g5bmuezp4iMCBEnabNp4N9nAfD8ULvo9L
   ZzxF49IuAiCkqlQYeGSycBJTijIee8/oesH8JgOFpALCXQEiLJ2fiXPgV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392318668"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="392318668"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 23:10:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="893109126"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="893109126"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 23:10:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 23:10:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 23:10:24 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 23:10:24 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 23:10:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/QZReKUyuJ4jvNxHJjKGb8KAUpk9oQy/kJ6sRpkxfkg2CR5p48wATvUNl+yzv996rzemoroW2eBbtqNhhCeP07W9pOX6hBm0BZqKBB2Smu9eSBTS2FK8iJ0RjMGpvEOSna1e5x3QplUBrpX5tlX/q1l1OwXGAo10bI9QO7qyi128GG53f/35bneT8I7dHrk2BiGDAkDDBcIj/JG5aC8DV0kM9+HbWMhEYmtG1SkB80Pn5Ef66bdjWk4eePoRLK5F1z+djgLv4MI5E18lpRMInRnR7PjMsuClcpRrwWL7G6durZhKq5xSzA5SV2R2qTJ4i66ABNDGwXdgFZeSvl4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4LL89jBflgEFhG7aLLkhzqQP3ALN94TNshFNHCxCMY=;
 b=j78REv1FO/KR6RF+bSDQ/pcr0cvDAS5tauzteVayluySSv2zjN8+P874ctohI62obQIwXnjqUy4v27eidgf02ithEnlfOqViokvxZGApS0pZLTdzO7lfF793uWXY73n5Y11s83+CM+CKSsIIn2P5p9KZwJroOl+uc/kZgENysuBS7gz+2Jit4VVrHVvX/tDZ4xG9N5U4TxbjB4kK3248HFKWzgwHOfD6Sock/gA/gbCVf79ij2m0MCAPzlzY1mcAeDI3VVqW9qxzkMMdslHQSdE01rS3oT2TPDAxl6D9ov+wdHnHYdVPAkAGBV0i3FuQRPwK/Yw6unom3mImv+lSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7670.namprd11.prod.outlook.com (2603:10b6:a03:4c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 07:10:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 07:10:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
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
	<yan.y.zhao@intel.com>
Subject: RE: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Topic: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Thread-Index: AQHaGVcJ4nFLu64FV02Qq9BjVpwSvbCC3axQgAAHEwCAAAD1wIAAl++AgACaJQCAACuAgIAEgqsQgAXeCQCAAMsJ8IABGqOAgAABpoCAA1VUAIAAEHmAgAADm8CAACIbAP///36Q
Date: Fri, 1 Dec 2023 07:10:21 +0000
Message-ID: <BN9PR11MB5276CF2C6BD4163634F42D478C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
 <BN9PR11MB5276C8EACE2C300A646EA8A18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZVw/BXxgGCuCZCA6@Asurada-Nvidia>
 <BN9PR11MB52761A9B48A25E89BEECE6308CB8A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWTzoBTDDEWAKMs9@Asurada-Nvidia>
 <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia> <20231129005715.GS436702@nvidia.com>
 <b5f86fde-eaec-47fc-8b4f-36adb0e9e1a1@intel.com>
 <ZWlmD1KDUyR3qzdy@Asurada-Nvidia>
 <BN9PR11MB52761168800700D7131D601D8C81A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <1a19c55b-763e-4d6b-9462-4d0ea86110e1@intel.com>
In-Reply-To: <1a19c55b-763e-4d6b-9462-4d0ea86110e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7670:EE_
x-ms-office365-filtering-correlation-id: 1d8f2132-1f9d-45fb-ba87-08dbf23c953d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WW0RBBiG6JYacfFsoURbzixm0cmQWIa8vQpdohlbVCGdWsTpYAvKkLTuJBsWnmvNoh6+nThBxtAZMdo6z7FMpH0BaIb7UTlab8+14+zxjoDye6MAjdsonLusCYbBL2VIOYRTOcl2TxMhjwByhZPvSZelvO7Q7BnPQJ3pd+KjORG2ULZvdgjQ4If+8cMMNqEMlWVbbr7ib8JkRrnXOsGr1u+ba31+fsg4xCHV28y1KRHAHh6UmADAGeWRpqhgp1FrGOIdiDwFhdgfrW2gzj1hZVP8i10oaX3ESYQwAUpgvwv38DJfzy9LMcE4K/ZDu7bEgAnVsLkcQWK6+rRhMVK0aalrvBJiQTiBFbtcewXaCFnsxWuMbx18vn6WQ4LKCqaL53w9A1jvXXOxw6LhKo/nWfADYXDfd/Ms2749mIG+OOvel/F+sp6V9gaZT46qoGbSCqie7Akzd3QAsLzCByyTfY2Pd6mMz/b9oKK1Nr9dCteOUZJ6zOTCLcDJk0M3fWa7mHDKBP8N16sbngsA+2+MwrQrckmrdoivkmMvh500fNqVkNU5aSZZtdvF0zIwRV7joM0vIeoVHsBiBmyhCbrbJvRa7KyPY2FVksq833PXbWfV2QT2FNM4UcDFLIoMpi2K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(38070700009)(2906002)(83380400001)(122000001)(7416002)(33656002)(41300700001)(5660300002)(53546011)(71200400001)(82960400001)(9686003)(38100700002)(6506007)(7696005)(26005)(86362001)(76116006)(478600001)(110136005)(316002)(52536014)(54906003)(4326008)(64756008)(66476007)(66556008)(66446008)(66946007)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm0xL1BxdzFGYTlmdVZWSlIxRUlhMDBKZkgvWEtpa05RSW9UMk1UdEhMM0FO?=
 =?utf-8?B?UzJoWWRMQ0ZWWVpBdFVoRXdXMEt4VTNIOU00a3cyZjR1ek5DZ3pzdDlxbyto?=
 =?utf-8?B?NS9iNDduLzI3Rk1kRUh4aUphblducEVRK2F6M0RCWlExcTFNeHNtRnBLUktM?=
 =?utf-8?B?cEFHUi9BY1hqMkphOWovOUk4UVl5R3VzYzRWakM3b1IwUVYyQ3VZem1xWmJt?=
 =?utf-8?B?QzFab1dVTExKNG9TNWRXYloxSjZ3T2JNejJIbWlobDQzeTc0anlXM0VTenFm?=
 =?utf-8?B?N2JEQXVJczQ5NzNyWUpHa1F5bWs0OVJzUHpuNkdpcE81c1BPeS9vdTZmc21h?=
 =?utf-8?B?M0JwUmFzeUh5MVY5MC91cmwvWWtpajhTeDVQWjlDdUJvVVA4ZFByUEppM3M5?=
 =?utf-8?B?MVZrZ1NpUGV0K2VmYTQyQ3o0Rmpsd2hqd0hlZ0Z0WTB6cC84RGJMSjdIUERM?=
 =?utf-8?B?Tm85d0l1bWU1cW5SNS9QZGZ2VWpTN2dNQjJMd1A3OVd5U3dUQlNIRE9zaFJT?=
 =?utf-8?B?K0VXcWJpRDAydjE1TGJHZ2JRdXJ0aThkZE94Z1ZsQkltWE9pZ0piQmxFYVAx?=
 =?utf-8?B?OUhPVU1mNjU1WGhsNkZCYmRLT2tYUmMydUhacHhYTnN4ZUFmL3FSeUY1cFVh?=
 =?utf-8?B?WktsQ3Q3TU1CWWMxUXEwaVJDR0NoWEpSbTNGU3QwUTVxaFB1Y3B2L2ZxYXox?=
 =?utf-8?B?K1U1LzgzbEFPSE8ySTd6WW1UblAzQ292b3dYdmFMOVFOeXFuSklORGtYbkpj?=
 =?utf-8?B?QUlXbHUwbWF2TEN0R3dTOWp2ZlJYWUlxb3BlR242bjlzOVlSUTM1cGgvT0Yr?=
 =?utf-8?B?WjZWaTVaNlBCbEQ0c2dJTXgrSVVZRGMvU1lqWDFZK01GWUZPNmxqQks5amRa?=
 =?utf-8?B?Y2wydTM2K2Z0Qkt0MVUzUTNBbkI4dDdza3p1cTQzSThCSkZzUUY1aGdKMGV2?=
 =?utf-8?B?SEhjSktNUGg2ZVhmMmxjMUIvM1U2OVgwZFFmWWpDb1ZKa3l2KzRXZHNaNlNi?=
 =?utf-8?B?dGhNNEVHSCtDSmpVdFNaTklWT1VXSDkrV0Z3ZHl1T1RPdzZualVFUlNPMDBx?=
 =?utf-8?B?cnJuSFdkSFVXTmEzZWdsWkx0UVo0eE5lK2xRVkROUm5adVNSeXYwUFNYSEx1?=
 =?utf-8?B?TDRpOHpSa1Y5U0FYQzV6eTVHaUw1Zk91RXFocHJLRFhqNmZXaUxvZnJqd0Fv?=
 =?utf-8?B?N2MxTVpwazdRU1NsVUF6UzdKWDBJMnhod0xnbWNCRVNSdlJHTzB2WnRJRjZF?=
 =?utf-8?B?WGNiVzVyZXdFaHpxRzlpMHVCbXpmTEtESzY5N1FOQm1VUFhhTUpyUXdrWExn?=
 =?utf-8?B?WFFZQW5TcnAxUjNhcHNXL2JhblhYMERDK0k1Sk85N2EzUi8xWStIcm5vTXo3?=
 =?utf-8?B?SDBSUHhsTEdFNkNtcWZLNXhzQTdMVjhPaUJtOUgzcGpJamxnS01iTUdjbUVM?=
 =?utf-8?B?Mnp2M2hNUzhIM0d4UjZBTEZQam9QRUQ3R3ZOM2gyWHdpNkp3ZGpJc1VzN0Fh?=
 =?utf-8?B?Mi85TDllVjFYMkZtR28wRS9GdUNETFNMRTNwMWViL3Y1MUJxRVFiV0o2NHd3?=
 =?utf-8?B?TDd0b3dsY3ZCYlZhL0U0czB0MnZvbFhjU1ZCbWdZR3hzKzRIWkwvWFBTbWxl?=
 =?utf-8?B?UzQrRDB3RDB6K0dvZUZJejdNV0lQZnlsUCsrRVpxbk5sZFNydS8wRDM5Q0tJ?=
 =?utf-8?B?N3JPb3k3Q244ei81eXE2OS9VQWdwY0p0ZzdoRnlIb2lrUm9uKzNsdWNablJD?=
 =?utf-8?B?UmQxMGZmcnMxem5obnQ4WUZqbGxHcFVJYlhBbmJxejFJMXowRjVPQ0tFWVZ2?=
 =?utf-8?B?WVJHL29Ud1Jkdy9nTEtwV1NwV1VjSXcwZW5ma1FCaFI4TVVYbExDYzNoSlNE?=
 =?utf-8?B?WVVNTUlieFhmTTRqdUFKU1ZZNUtsWXJQcXRMNlpnWENGTVBZYmY3MTRXTzhL?=
 =?utf-8?B?RnRydExmYjhCbkFXVGlUWm40QnJqMjl3bnk4V2hIYUxtQUlsZXNMOGFrSUMx?=
 =?utf-8?B?UkF6MkdramxzQ1FVRnJ4VFZVQm8xa1E5NGJ2ZjBvR3U1NWJJUk1MS3orUWw4?=
 =?utf-8?B?NFZwYUk3UVR6eiszbTFVUXlLalRaNk5ORTBTRjhEUnRZTElvZ3ZKM3pudUhQ?=
 =?utf-8?Q?WTM9iZwkVvdBi26Bv+iOGkuGv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8f2132-1f9d-45fb-ba87-08dbf23c953d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 07:10:21.8678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f5rnf1ekb3aS4Wy7G8Ngb8i/aIeywbmKgP7nsJ9J/w1F2hd91U7/ZsCg1nGx8o2QL7n23IPKAgzi+uCNeQkP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7670
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBE
ZWNlbWJlciAxLCAyMDIzIDM6MDUgUE0NCj4gDQo+IE9uIDIwMjMvMTIvMSAxMzoxOSwgVGlhbiwg
S2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT4NCj4gPj4gU2VudDogRnJpZGF5LCBEZWNlbWJlciAxLCAyMDIzIDEyOjUwIFBNDQo+ID4+DQo+
ID4+IE9uIEZyaSwgRGVjIDAxLCAyMDIzIGF0IDExOjUxOjI2QU0gKzA4MDAsIFlpIExpdSB3cm90
ZToNCj4gPj4+IE9uIDIwMjMvMTEvMjkgMDg6NTcsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4g
Pj4+PiBPbiBUdWUsIE5vdiAyOCwgMjAyMyBhdCAwNDo1MToyMVBNIC0wODAwLCBOaWNvbGluIENo
ZW4gd3JvdGU6DQo+ID4+Pj4+Pj4gSSBhbHNvIHRob3VnaHQgYWJvdXQgbWFraW5nIHRoaXMgb3V0
X2RyaXZlcl9lcnJvcl9jb2RlIHBlciBIVy4NCj4gPj4+Pj4+PiBZZXQsIGFuIGVycm9yIGNhbiBi
ZSBlaXRoZXIgcGVyIGFycmF5IG9yIHBlciBlbnRyeS9xdWVzdC4gVGhlDQo+ID4+Pj4+Pj4gYXJy
YXktcmVsYXRlZCBlcnJvciBzaG91bGQgYmUgcmVwb3J0ZWQgaW4gdGhlIGFycmF5IHN0cnVjdHVy
ZQ0KPiA+Pj4+Pj4+IHRoYXQgaXMgYSBjb3JlIHVBUEksIHYucy4gdGhlIHBlci1IVyBlbnRyeSBz
dHJ1Y3R1cmUuIFRob3VnaA0KPiA+Pj4+Pj4+IHdlIGNvdWxkIHN0aWxsIHJlcG9ydCBhbiBhcnJh
eSBlcnJvciBpbiB0aGUgZW50cnkgc3RydWN0dXJlDQo+ID4+Pj4+Pj4gYXQgdGhlIGZpcnN0IGVu
dHJ5IChvciBpbmRleGVkIGJ5ICJhcnJheS0+ZW50cnlfbnVtIik/DQo+ID4+Pj4+Pj4NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiB3aHkgd291bGQgdGhlcmUgYmUgYW4gYXJyYXkgZXJyb3I/IGFycmF5IGlz
IGp1c3QgYSBzb2Z0d2FyZQ0KPiA+Pj4+Pj4gZW50aXR5IGNvbnRhaW5pbmcgYWN0dWFsIEhXIGlu
dmFsaWRhdGlvbiBjbWRzLiBJZiB0aGVyZSBpcw0KPiA+Pj4+Pj4gYW55IGVycm9yIHdpdGggdGhl
IGFycmF5IGl0c2VsZiBpdCBzaG91bGQgYmUgcmVwb3J0ZWQgdmlhDQo+ID4+Pj4+PiBpb2N0bCBl
cnJuby4NCj4gPj4+Pj4NCj4gPj4+Pj4gVXNlciBhcnJheSByZWFkaW5nIGlzIGEgc29mdHdhcmUg
b3BlcmF0aW9uLCBidXQga2VybmVsIGFycmF5DQo+ID4+Pj4+IHJlYWRpbmcgaXMgYSBoYXJkd2Fy
ZSBvcGVyYXRpb24gdGhhdCBjYW4gcmFpc2UgYW4gZXJyb3Igd2hlbg0KPiA+Pj4+PiB0aGUgbWVt
b3J5IGxvY2F0aW9uIHRvIHRoZSBhcnJheSBpcyBpbmNvcnJlY3Qgb3Igc28uDQo+ID4+Pj4NCj4g
Pj4+PiBXZWxsLCB3ZSBzaG91bGRuJ3QgZ2V0IGludG8gYSBzaXR1YXRpb24gbGlrZSB0aGF0Li4g
QnkgdGhlIHRpbWUgdGhlIEhXDQo+ID4+Pj4gZ290IHRoZSBhZGRyZXNzIGl0IHNob3VsZCBiZSB2
YWxpZC4NCj4gPj4+Pg0KPiA+Pj4+PiBXaXRoIHRoYXQgYmVpbmcgc2FpZCwgSSB0aGluayBlcnJu
byAoLUVJTykgY291bGQgZG8gdGhlIGpvYiwNCj4gPj4+Pj4gYXMgeW91IHN1Z2dlc3RlZCB0b28u
DQo+ID4+Pj4NCj4gPj4+PiBEbyB3ZSBoYXZlIGFueSBpZGVhIHdoYXQgSFcgZmFpbHVyZXMgY2Fu
IGJlIGdlbmVyYXRlZCBieSB0aGUNCj4gPj4gY29tbWFuZHMNCj4gPj4+PiB0aGlzIHdpbGwgZXhl
Y3R1cmU/IElJUkMgSSBkb24ndCByZW1lbWJlciBzZWVpbmcgYW55IHNtbXUgc3BlY2lmaWMNCj4g
Pj4+PiBjb2RlcyByZWxhdGVkIHRvIGludmFsaWQgaW52YWxpZGF0aW9uPyBFdmVyeXRoaW5nIGlz
IGEgdmFsaWQgaW5wdXQ/DQo+ID4+Pj4NCj4gPj4+PiBDYW4gdnQtZCBmYWlsIHNpbmdsZSBjb21t
YW5kcz8gV2hhdCBhYm91dCBBTUQ/DQo+ID4+Pg0KPiA+Pj4gSW50ZWwgVlQtZCBzaWRlLCBhZnRl
ciBlYWNoIGludmFsaWRhdGlvbiByZXF1ZXN0LCB0aGVyZSBpcyBhIHdhaXQNCj4gPj4+IGRlc2Ny
aXB0b3Igd2hpY2ggZWl0aGVyIHByb3ZpZGUgYW4gaW50ZXJydXB0IG9yIGFuIGFkZHJlc3MgZm9y
IHRoZQ0KPiA+Pj4gaHcgdG8gbm90aWZ5IHNvZnR3YXJlIHRoZSByZXF1ZXN0IGJlZm9yZSB0aGUg
d2FpdCBkZXNjcmlwdG9yIGhhcyBiZWVuDQo+ID4+PiBjb21wbGV0ZWQuIFdoaWxlLCBpZiB0aGVy
ZSBpcyBlcnJvciBoYXBwZW5lZCBvbiB0aGUgaW52YWxpZGF0aW9uIHJlcXVlc3QsDQo+ID4+PiBh
IGZsYWcgKElRRSwgSUNFLCBJVEUpIHdvdWxkIGJlIHNldCBpbiB0aGUgRmF1bHQgU3RhdHVzIFJl
Z2lzdGVyLCBhbmQgc29tZQ0KPiA+Pj4gZGV0YWlsZWQgaW5mb3JtYXRpb24gd291bGQgYmUgcmVj
b3JkZWQgaW4gdGhlIEludmFsaWRhdGlvbiBRdWV1ZSBFcnJvcg0KPiA+Pj4gUmVjb3JkIFJlZ2lz
dGVyLiBTbyBhbiBpbnZhbGlkYXRpb24gcmVxdWVzdCBtYXkgYmUgZmFpbGVkIHdpdGggc29tZQ0K
PiBlcnJvcg0KPiA+Pj4gcmVwb3J0ZWQuIElmIG5vIGVycm9yLCB3aWxsIHJldHVybiBjb21wbGV0
aW9uIHZpYSB0aGUgd2FpdCBkZXNjcmlwdG9yLiBJcw0KPiA+Pj4gdGhpcyB3aGF0IHlvdSBtZWFu
IGJ5ICJmYWlsIGEgc2luZ2xlIGNvbW1hbmQiPw0KPiA+Pg0KPiA+PiBJIHNlZSB0aGUgY3VycmVu
dCBWVC1kIHNlcmllcyBtYXJraW5nIHRob3NlIGFzICJSRVZJU0lUIi4gSG93DQo+ID4+IHdpbGwg
aXQgcmVwb3J0IGFuIGVycm9yIHRvIHRoZSB1c2VyIHNwYWNlIGZyb20gdGhvc2UgcmVnaXN0ZXI/
DQo+ID4+DQo+ID4+IEFyZSB0aGV5IGdsb2JhbCBzdGF0dXMgcmVnaXN0ZXJzIHNvIHRoYXQgaXQg
bWlnaHQgYmUgZGlmZmljdWx0DQo+ID4+IHRvIGRpcmVjdCB0aGUgZXJyb3IgdG8gdGhlIG5lc3Rl
ZCBkb21haW4gZm9yIGFuIGV2ZW50IGZkPw0KPiA+Pg0KPiA+DQo+ID4gVGhleSBhcmUgZ2xvYmFs
IHJlZ2lzdGVycyBidXQgaW52YWxpZGF0aW9uIHF1ZXVlIGlzIGFsc28gdGhlIGdsb2JhbA0KPiA+
IHJlc291cmNlLiBpbnRlbC1pb21tdSBkcml2ZXIgcG9sbHMgdGhlIHN0YXR1cyByZWdpc3RlciBh
ZnRlciBxdWV1ZWluZw0KPiA+IG5ldyBpbnZhbGlkYXRpb24gZGVzY3JpcHRvcnMuIFRoZSBzdWJt
aXNzaW9uIGlzIHNlcmlhbGl6ZWQuDQo+ID4NCj4gPiBJZiB0aGUgZXJyb3IgaXMgcmVsYXRlZCB0
byBhIGRlc2NyaXB0b3IgaXRzZWxmIChlLmcuIGZvcm1hdCBpc3N1ZSkgdGhlbg0KPiA+IHRoZSBo
ZWFkIHJlZ2lzdGVyIHBvaW50cyB0byB0aGUgcHJvYmxlbWF0aWMgZGVzY3JpcHRvciBzbyBzb2Z0
d2FyZQ0KPiA+IGNhbiBkaXJlY3QgaXQgdG8gdGhlIHJlbGF0ZWQgZG9tYWluLg0KPiA+DQo+ID4g
SWYgdGhlIGVycm9yIGlzIHJlbGF0ZWQgdG8gZGV2aWNlIHRsYiBpbnZhbGlkYXRpb24gKGUuZy4g
dGltZW91dCkgdGhlcmUNCj4gPiBpcyBubyB3YXkgdG8gYXNzb2NpYXRlIHRoZSBlcnJvciB3aXRo
IGEgc3BlY2lmaWMgZGVzY3JpcHRvciBieSBjdXJyZW50DQo+ID4gc3BlYy4gQnV0IGludGVsLWlv
bW11IGRyaXZlciBiYXRjaGVzIGRlc2NyaXB0b3JzIHBlciBkb21haW4gc28NCj4gPiB3ZSBjYW4g
c3RpbGwgZGlyZWN0IHRoZSBlcnJvciB0byB0aGUgbmVzdGVkIGRvbWFpbi4NCj4gPg0KPiA+IEJ1
dCBJIGRvbid0IHNlZSB0aGUgbmVlZCBvZiBkb2luZyBpdCB2aWEgZXZlbnRmZC4NCj4gPg0KPiA+
IFRoZSBwb2xsIHNlbWFudGljcyBpbiBpbnRlbC1pb21tdSBkcml2ZXIgaXMgZXNzZW50aWFsbHkg
YSBzeW5jIG1vZGVsLg0KPiA+IHZ0LWQgc3BlYyBkb2VzIGFsbG93IHNvZnR3YXJlIHRvIG9wdGlv
bmFsbHkgZW5hYmxlIG5vdGlmaWNhdGlvbiB1cG9uDQo+ID4gdGhvc2UgZXJyb3JzIGJ1dCBpdCdz
IG5vdCB1c2VkIHNvIGZhci4NCj4gPg0KPiA+IFdpdGggdGhhdCBJIHN0aWxsIHByZWZlciB0byBo
YXZpbmcgZHJpdmVyLXNwZWNpZmljIGVycm9yIGNvZGUgZGVmaW5lZA0KPiA+IGluIHRoZSBlbnRy
eS4gSWYgQVJNIGlzIGFuIGV2ZW50LWRyaXZlbiBtb2RlbCB0aGVuIHdlIGNhbiBkZWZpbmUNCj4g
PiB0aGF0IGZpZWxkIGF0IGxlYXN0IGluIHZ0ZCBzcGVjaWZpYyBkYXRhIHN0cnVjdHVyZS4NCj4g
Pg0KPiA+IGJ0dyBnaXZlbiB2dGQgZG9lc24ndCB1c2UgbmF0aXZlIGZvcm1hdCBpbiB1QVBJIGl0
IGRvZXNuJ3QgbWFrZQ0KPiA+IHNlbnNlIHRvIGZvcndhcmQgZGVzY3JpcHRvciBmb3JtYXR0aW5n
IGVycm9ycyBiYWNrIHRvIHVzZXJzcGFjZS4NCj4gPiBUaG9zZSwgaWYgaGFwcGVuLCBhcmUgZHJp
dmVyJ3Mgb3duIHByb2JsZW0uIGludGVsLWlvbW11IGRyaXZlcg0KPiA+IHNob3VsZCB2ZXJpZnkg
dGhlIHVBUEkgc3RydWN0dXJlIGFuZCByZXR1cm4gLUVJTlZBTCBvciBwcm9wZXINCj4gPiBlcnJu
byB0byB1c2Vyc3BhY2UgcHVyZWx5IGluIHNvZnR3YXJlLg0KPiA+DQo+ID4gV2l0aCB0aGF0IFlp
IHBsZWFzZSBqdXN0IGRlZmluZSBlcnJvciBjb2RlcyBmb3IgZGV2aWNlIHRsYiByZWxhdGVkDQo+
ID4gZXJyb3JzIGZvciB2dGQuDQo+IA0KPiBobW1tLCB0aGlzIHNvdW5kcyBsaWtlIGN1c3RvbWl6
ZWQgZXJyb3IgY29kZS4gaXMgaXQ/IFNvIGZhciwgVlQtZA0KDQp5ZXMuIHRoZXJlIGlzIG5vIG5l
ZWQgdG8gcmVwbGljYXRlIGhhcmR3YXJlIHJlZ2lzdGVycy9iaXRzIGlmIG1vc3QNCm9mIHRoZW0g
YXJlIGlycmVsZXZhbnQgdG8gdXNlcnNwYWNlLg0KDQo+IHNwZWMgaGFzIHR3byBlcnJvcnMgKElD
RSBhbmQgSVRFKS4gSVRFIGlzIHZhbHVhYmxlIHRvIGxldCB1c2Vyc3BhY2UNCj4ga25vdy4gRm9y
IElDRSwgbG9va3MgbGlrZSBubyBtdWNoIHZhbHVlLiBJbnRlbCBpb21tdSBkcml2ZXIgc2hvdWxk
DQo+IGJlIHJlc3BvbnNpYmxlIHRvIHN1Ym1pdCBhIHZhbGlkIGRldmljZS10bGIgaW52YWxpZGF0
aW9uIHRvIGRldmljZS4NCg0KaXQncyBhbiBpbnZhbGlkIGNvbXBsZXRpb24gbWVzc2FnZSBmcm9t
IHRoZSBkZXZpY2Ugd2hpY2ggY291bGQgYmUNCmNhdXNlZCBieSB2YXJpb3VzIHJlYXNvbnMgKG5v
dCBleGFjdGx5IGR1ZSB0byB0aGUgaW52YWxpZGF0aW9uIA0KcmVxdWVzdCBieSBpb21tdSBkcml2
ZXIpLiBzbyBpdCBzdGlsbCBtYWtlcyBzZW5zZSB0byBmb3J3YXJkLg0KDQo+IGlzIGl0Pw0KPiAN
Cj4gLS0NCj4gUmVnYXJkcywNCj4gWWkgTGl1IA0K

