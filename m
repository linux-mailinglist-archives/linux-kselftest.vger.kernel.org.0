Return-Path: <linux-kselftest+bounces-1788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A941810808
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 03:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EA21C2090E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BAFECE;
	Wed, 13 Dec 2023 02:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOM3PaK3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D0A6;
	Tue, 12 Dec 2023 18:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433731; x=1733969731;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nvMuItoNws6a86tC51k0yLFWaUMqAhS2dTYBmGi/f2M=;
  b=hOM3PaK3AjJxzT9v7Jdz/earnWYJy8ZzDUoPYUo06A05A78roEOj9TU9
   dsLII9OYtLnt6iAC2FPrZyrmY70JLZ3U6gR8dzcUljoK3Xm/tnGt7KCeD
   9TthKUC3Ns0PMI9eQThxHtpg/0VIFxvGud6Mne1eb/Z4DBxbRsL6U2kvR
   Prv2lTcGKm+wGOFWEYLGLkD0HPsKLLLJkDCiJuThJNCB8ROe+Pi9VYp/Z
   7HXKTuS0eWQNCI7ViAjKorU7IwCvW7gPBkvxqs0yCoTAubS1DxHI21Mc3
   yynaVrZimdyf0GG/UJQ2sYn2bX+QRjItmalzTwaB1+j0oKzsvhOQidVYB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461376569"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461376569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:15:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="723465925"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="723465925"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:15:30 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:15:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:15:30 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:15:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj7LNW1FcsUGNx5FNAT080SDh4JaNycNRcIWuQBa64JFDZ0UitdWT/aAZ+dRDr0IxoUsN98TJljds+kqmDitEEgI5jKBarXqdayBqluHjxGgQRWHxSgKh8/Dv9jjcG82cmRkkFwnwfEmLsyC9KMmMR4/L+vyskkJ7YJ0CMnVqD5OUEU2aheWQxJz60VjGnlFWN1rfnRmNhJoLvbfO5Y2Wq3L3BK0E+CBxe/X67+L6B13wx/U1wCv5dsssaeQWxb6eFWDHdq03Y1KheradyrwbpqNfUW0b+YunuXNWdsZG5hVDbVcPYTfh1FPBKBhq0OkhIwT03SQQC1j1geN7TmiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvMuItoNws6a86tC51k0yLFWaUMqAhS2dTYBmGi/f2M=;
 b=FjhtS4UlvCtCnyjx9AKKLjwqH8CrMZZKQ7PIjIetZ5wCHpvz6m6v86JLM7uqVVG01ilcvCxSpOwjGR5L/UORffP5AgLQSivzkfvb/gmTp+/OMyIuRRBtKE+8lfpKHcO3pPwtTS15NsLEfRl536GC9r2tVHTDL49g2/JUv8OCZKshLTAIWMqDzprvvr8n0CggT3zXMGODcp2OUdx0UbOsmt+O2JNnWF1Rvz8BY2IFjK/60gAUbly4UtOkc2F3b2CZiSm9PjGMR1dz7rndXIGS1DBtaVPv8W+nHOae+wmc/he85JbBhg102ZtSM2PHdFq0CTpgwTYOeufHNAdZzJJlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8742.namprd11.prod.outlook.com (2603:10b6:408:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 02:15:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e7a4:a757:2f2e:f96a%3]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 02:15:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Joel
 Granados" <j.granados@samsung.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Thread-Topic: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Thread-Index: AQHaB7eoBnsb/TFsKEmSuvUKAqg6cLCl6Z8AgAARUwCAAMcfgIAAAhug
Date: Wed, 13 Dec 2023 02:15:28 +0000
Message-ID: <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
 <20231212141208.GA3013885@ziepe.ca>
 <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
In-Reply-To: <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8742:EE_
x-ms-office365-filtering-correlation-id: f3b01d32-0ebc-4f07-2ee9-08dbfb815ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+e8RrwHTtGyFlJ+unwzFoaGfmdtDvMl0qgs5iGq5haXmWB6PW2O+ON9lLubqK0BzVfghiH2FqA5TEUySyovV7TB2hwcyRyb2vRD00Mv3lQyqjaXUaJhlhHqRlb0/pMrmS7gCLnZATj/w27FwqRXS3hrwrzQYpcWzvgLjq6Y67pB/GVLwJnM4L+uuaqqUW6+oH0WocHKnI05j1M99/f9hY1wfBjRxXchVnZtPal1JpFzYpUypmd2FFB2QrAxacLvVV5guhR4dqYq4o+HHvqGb5Fkk+2EzmWXE6ayxvLEehrkUxgdS3RYST9bUw0Y46+mb90hHkFzCRZ8nocjaOU693VdFDN0rO/KmWO3DEogO+iI38SJ3MB2nc/lkX+Ljky8gMEnEYR5qKl2e+PKm60VjSgQgQi9Wmu3SeV+cNXmgvXBRIzEULn72Ts5smprRpwdGgb92tv+eE7fq3pHJyOkC/1UmTN69fRDBOPY3qWhDJHNnFnLv+0LeWq9suPfZpHtBKgsuCDP0JZVxu9PehOHnmWiIBUsCpofYT3/i+R5U0tpmVICgPzNFD7y1eTpLuwGjTCbkrSPXHWy+Db7WX3uAYEL+hzD2eyAj8rgFkg7n4EE5pujdSntwYqln8SbzUV3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(55016003)(478600001)(26005)(71200400001)(7696005)(6506007)(9686003)(82960400001)(122000001)(41300700001)(38100700002)(38070700009)(33656002)(86362001)(5660300002)(76116006)(54906003)(66476007)(66556008)(64756008)(66446008)(2906002)(4744005)(7416002)(66946007)(110136005)(4326008)(316002)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDBJUnZTUkJ2d2wwbFA2ek96TkFMeUhQNGtMOUVGVys2WDJ2emw1Mzg4ekxI?=
 =?utf-8?B?RHIrN1MrQjJGeUh6UmdDSDM0aDNqMEFWc3RWTlZpclZVRlBHTmNWLzVaaVA1?=
 =?utf-8?B?MGFMcHhNcUIrUXdadDU4SDNCeUxCT0VISkp6N2t5d293dDRzQTRaZVkzU3Jt?=
 =?utf-8?B?ZWFIK3REK2VtYWxmYVhrSFJaOXhJOEhGQzlCQmxxTFgvTEFPNW9KWmhyZ0Vi?=
 =?utf-8?B?elVDQ2dxS1FLQlVuVVdQdkRtNnNIWmxldlZCQ2xIQTA0ODk4cDRSMjlaTGI2?=
 =?utf-8?B?VkJacDNYS0owMll4MGZCT0xlUFVJeU9rSGdneGJtZ3ZMSzVYQ2g1eGVMMFph?=
 =?utf-8?B?ODl0bVJOZDh5THdlTDlWRFUxRWx6bGVzOWJHR3JaaTFQZ09XeW8vcHZORXM2?=
 =?utf-8?B?L0FCZE5xTWhGV1FJaU9BR3lwMTZVdE56NWsvbmdObHVDUFJuaTc3bzJvaWVI?=
 =?utf-8?B?M3NiY2NrUEp6d0dNSnVLbUtRSGZ4OEp2VHAzeEpjbkovQ1J3Z3VwMHJBQ2ZN?=
 =?utf-8?B?K1lVM2RzUHcvT01BMytOYkhETmM4N1JpbG4vVTNSdysvc04yU2hvRzArckpB?=
 =?utf-8?B?QUU4ajVFV2JuS1FJWUNLYXF0SlpRZW5tbUx5RHZrNE9FZEdXRW5UQVJ1SDNj?=
 =?utf-8?B?ZkhDclpJWDVhTk4rQnVhRXRZMFdIemgrNHQ2THlCdEFkeENkbU0zUUZ5S25V?=
 =?utf-8?B?RWhiSjJiZ0w3SzNkTGlPdzE3YlJuS0xqcklwblFFU3BWQkNPR29ZVE8vT2RM?=
 =?utf-8?B?NUNRZWYydHhkWXJvN0xPbldtMEF5U3RwSXJiazNxeWFJWlVISE1xMWJ6RGty?=
 =?utf-8?B?a0lwMUt0YlQ5dExjYXpla05Xb0pnMk9LT2E2SGlDSEJEL21pZ2ppZUROY2F6?=
 =?utf-8?B?d3k4dGI1aVA2S2xNcUhmUHhxUUNScW5Oak1wcGJJRmNmWjE4Z29jWlowTWxv?=
 =?utf-8?B?NFR1ekxIaWE5Z1YxMDV1Z09nVnRPVXBrcmM2M0drTXNEY3JpR3FGZFdJQU1S?=
 =?utf-8?B?ZmlFU3JFVE5nUkFkQmN4R0hEZTVadDBDU3RSYWh1dW81VXUvNnVwU3ZmZWZV?=
 =?utf-8?B?S0E3dWtldUptUnh1OU5COVFZRGdJcDE3SFRWVGo2SHgwc2xNQmUzV20yUUU4?=
 =?utf-8?B?cjVzblVPL3ZxUWU2d0twSGNmUlJrZS93VkhncmhGcGgyaUUvTENoSzNWNU1J?=
 =?utf-8?B?TnJLb3hZVC9FTG5ZWEN1UlJpd09uT3NvdTg0cU9QVGEvbTJ5TzlOU2xKVWZn?=
 =?utf-8?B?MnBXTXZRV2xnL0dvVTVPOXUxTWk4UG1DWWlXK1pSNWRoRlgvMktxRFAxMi9w?=
 =?utf-8?B?SWlDRW1MZzlab2hRSzI3cWhmRU9DUXNzcVdPM2dsSS9wNHFFNURuRU1nYzFl?=
 =?utf-8?B?Y1BqYlZaN1lCdy9HRnlsejBBTU14eW1JMUEvK3E1a1hqTnhERzRsOStqdEhv?=
 =?utf-8?B?dENmakFSS3h0UGY5YTF4RURobEN5K3hlMHl2a3dmVDZ2Nm96enF5VlNoZlJY?=
 =?utf-8?B?Zm0xMURxdjNOOXRoMjBuK3lRSGFFUVoxT2dVeFE1eis0UG8vZWtqVzR2M3Yx?=
 =?utf-8?B?bHJxWGNmTHdud2ZyaDFLNHJvUHR6b3J1TVpuN2JPMTA5L2c3TnpPMGh1NXdL?=
 =?utf-8?B?RXNTcU5FUlBweThOcU5IQmFzSzdQUEU3UXF6N0VnVGZURnAwTmxIUTIyRlVq?=
 =?utf-8?B?K2lNU0VnZHZBSUdVMnVMdXFXNHhGakpyYTE1SExuUHY1emw4bXVnUFVXOHht?=
 =?utf-8?B?b1FDbHdvL3hXRDhMR2JGcUo5RWI2UkJHV1NHTWFPb0FESWJQMDdpR2RTTXZu?=
 =?utf-8?B?OVFhSVZrdjlZQXFjZUR5eUt4NkV0WmZyWHhBMTJPVHMrZE9USEUycUVKQkJv?=
 =?utf-8?B?emRmeFBXRzRjcC9CZ1k4Tnc0emdsSHRIVGVaRTVPS3o4a25EL3FWeFlaN0U3?=
 =?utf-8?B?UnNCdEMvL00reEg0dTlVWk1FeWc2UURjOFVDbE1kem0yQ1BXbjRpNU1TNTN4?=
 =?utf-8?B?TUhua3poWE0wLy8wYlhsRVd6Rk50b21rYlNDOU41YS9BcGRmbm02Skl5N1VJ?=
 =?utf-8?B?SFk4MEErcUJQZnVad3VTM2FCdm0rbUxxNzlIV245TkxZYnUzaHFjUEF2VVN0?=
 =?utf-8?Q?dRE5eiYKE1rkYHEwA7CbsDpxA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b01d32-0ebc-4f07-2ee9-08dbfb815ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:15:28.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7KFaxMNcYBiOZV/hAol75xyRa/3d1Yc9lybvZXc+IYMn5pBCIDMfXhC7RjhAwCCnfuM9mNw7vg51i9Shhy7ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8742
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIERlY2VtYmVyIDEzLCAyMDIzIDEwOjA1IEFNDQo+ID4NCj4gPj4gMi4gVGhpcyBpcyBu
b3QgaW50ZW5kZWQgdG8gd29yayBvbmx5IHdpdGggaWR4ZCBhbmQgdWFjY2UuIHJpZ2h0Pw0KPiA+
IEl0IHNob3VsZCB3b3JrIGV2ZXJ5d2hlcmUsIEkgc3VzcGVjdCBJbnRlbCBUZWFtIGRpZG4ndCBo
aXQgdGhpcw0KPiA+IGJlY2F1c2UgdGhleSBhcmUgdGVzdGluZyBJRFhEIFNJT1Y/DQo+IA0KPiBZ
ZXMuDQo+IA0KPiA+IENhbiB5b3UgZ3V5cyBhbHNvIHRlc3QgaXQgYXMgYSBQRg0KPiA+IGFzc2ln
bm1lbnQ/DQo+IA0KPiBGb3IgUEYgYXNzaWdubWVudCwgcHJvYmFibHkgdGhlIGRyaXZlciAodmZp
by1wY2kpIG5lZWRzIHRvIGVuYWJsZSBpb3BmLg0KPiANCg0KV2UgaGF2ZW4ndCBtZXJnZWQgYW55
dGhpbmcgZm9yIFNJT1YgeWV0Lg0KDQpzbyB0aGUgYmFzZSBvZiB0aGlzIHNlcmllcyBzaG91bGQg
YmUgUENJIGZ1bmN0aW9ucyAoUEYgb3IgVkYpIGFuZCB2ZmlvLXBjaQ0KaGFzIHRvIGJlIGV4dGVu
ZGVkIHdpdGggd2hhdGV2ZXIgcmVxdWlyZWQgdG8gc3VwcG9ydCBpb3BmLg0K

