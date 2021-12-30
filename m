Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42A0481A1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Dec 2021 08:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbhL3HFF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Dec 2021 02:05:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:22176 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhL3HFE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Dec 2021 02:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640847904; x=1672383904;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=55a3B4x4bm1FcdM+wJvd+y8MrKuk+OspBNLDJ3GiRRM=;
  b=nGSEPJliSZL7CIXG1+vXCQ0QUlDo9LJMOjb1NaSOfepRPyeKjQDnyUVe
   zq5K3Aazxd/8Nbf0HLaTL78DsHNfJTJCWaX3LokVR38zWfRqAWgkb6Ztf
   z5Lx46Si52f8yltN3f+d7JGJAwJ+vpJC7ZYq4NlwZx3xaDgv5BfxDpUts
   pK+f2ixDnk3aw6IrNxNhfkHWct5lTCG9Aq5E0koTXDrYF36RSZDnXpBC0
   l8tPFawY00EKmRnmNP6QDxdkFeWlc8GvIX630VDA8aG3jwoLfhp4EFHvx
   MmLUZtiR6UZErWtv+Ydmz3X+xsQzIR9t30ZO8dqCM38+qUcdbnl/wIWKt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="239171126"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="239171126"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 23:05:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="524290514"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2021 23:05:02 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 23:05:02 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 23:05:02 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 29 Dec 2021 23:05:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 29 Dec 2021 23:05:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB5jqtuzojiNOegWvMDFcDH1/3pldqtNO8CYlWHVOLMDy+XMplG0GyeQcUg+jtqZq2i0oCBTVp0ImUgdmPUlaEnHqLGw8ssrSAp4U1pdz7B9ks9O8/RB94BcKU/t3OK3LIYP7KrF1HLhLJmcLFJ0h0AXwsdEf7j8QHZ1kJrpR7SIOFH5J8CtqQyCV8oN2NoycF2lC6fz/jilggfcGPA9hylCPQyu5LndNburItSdHU7KfsQ6x9gi+o4KK0/MJzcu04VFxNSADuD0AEjJ86Wg6B/39TZzzO/N2AWhxe3n4SaV5vjsi23I79x6ZTa7uhQ9iXPRmzCaUx/3uSWssMyU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55a3B4x4bm1FcdM+wJvd+y8MrKuk+OspBNLDJ3GiRRM=;
 b=mRiOR6Vc/6FGkvuu6vZl7xGWNKK05tUvO61aV3TGCfy32EDwbbDwC5NHz9W6kyam2p1jAwTSWvI3YSskxuKrWd6JiJEX0McEMEYdFe/Z/IsTUn+W6XwkfX+RHUchG4czPlzFbt5CMypA/HUS7VvJEzgV4MPU5j8+jo9KsB5POZSrF9f72VlOeiq0v7LC6rZlMUgoZSQd+5/dsCQtxmouq9LsJwze0Twjz7mG/aHd3I8/CHxqB027VYQDZh27Yq2X9TkBcr0ysAr4OnDHHtb1UxHn0cSjogpkqnv1a6QrI+3g66D/8bQ1ORgFNMzoQmAUXj8BEMwdX/eSVlPVnbU2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN7PR11MB2642.namprd11.prod.outlook.com (2603:10b6:406:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 30 Dec
 2021 07:04:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4844.014; Thu, 30 Dec 2021
 07:04:51 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Christopherson,, Sean" <seanjc@google.com>
CC:     "Liu, Jing2" <jing2.liu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>,
        "Zeng, Guang" <guang.zeng@intel.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>,
        "Zhong, Yang" <yang.zhong@intel.com>
Subject: RE: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Topic: [PATCH v3 22/22] kvm: x86: Disable interception for IA32_XFD on
 demand
Thread-Index: AQHX9zE4gQJMQm2XFEKlfvGX4m1Fn6xIsbuAgAAjG3CAAD2qsIAAsXqAgAB7lVCAAFxUMA==
Date:   Thu, 30 Dec 2021 07:04:51 +0000
Message-ID: <BN9PR11MB52769CDA8F6FA1FB4E766B308C459@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211222124052.644626-1-jing2.liu@intel.com>
 <20211222124052.644626-23-jing2.liu@intel.com> <Ycu0KVq9PfuygKKx@google.com>
 <BN9PR11MB5276CE5635898CE13BFC57FC8C449@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YcyaN7V4wwGI7wDV@google.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ef48843-a63f-4a58-6344-08d9cb62acde
x-ms-traffictypediagnostic: BN7PR11MB2642:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR11MB26427045BF8360E6D770D4758C459@BN7PR11MB2642.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P3X+yX7u66XXAGjUwR4HwIsVYoPCvi0yblsq2PiIqLJvaBLbSYcl7HJOFZshZjldyZihLe2REgIhZxGIozj72TH/AxEwrYXHiSg8H7nRe8bLiRAWg4y4cMJby+trt+Ibzzw2OGGuolt0JhMqL/yKglZSBiX76EQeWH3ayyJWR2DV/7k7LSTMhxfb2EnzRROOcDKrK83Ka61wckIrTUaxha3/7dKADUPo5PAMOI1NEiXnG46izzZSp38DGTMJao9cONBM7L5e+Q1DSyljwoLu5qbAaI0e0pmNXAwv1cYgFs1Jn4zOPvGwKQk6kONwAsqgIhZ54AZPYv3AyEUIc/9aPeqIb3SnNpaMmsi5GcYRr1UqV9VguvIWKxZKQraL0LVq7ywk9Vr6xRsOjVJ+0LLTJJIrqDCqwDZwHtXjAsUF415tRoyzQgFrekWyWjH/Mv/vTCK5tA3VMASSr6MHQ3nOkXpSLEfyVlAF3F69ZUPylSMAnSwMg1gT7aIHos/ra/WrQXqa8BICGrs0HAwkb8MM1xmZjt2PEyMsV12FF12dtOmMYpViI6mfDzzp1Szmh1waG2zqIbpvpNlgLdpEQWDst0eW3fsYFfwP/KWREOnjLBROPCeB00WbRQ+fQqpt5vyLDgbHpR+5v75V7yV84Qc3es8/qmqer0xoLMHX5M9xOssglmi62ZiFSmH1161C4ixiUjLd+IZ5e29Es96LvdM5WA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(71200400001)(7416002)(2906002)(66556008)(64756008)(66446008)(9686003)(6506007)(66946007)(66476007)(26005)(316002)(82960400001)(76116006)(186003)(52536014)(54906003)(7696005)(6916009)(38070700005)(38100700002)(4326008)(122000001)(5660300002)(8936002)(86362001)(508600001)(55016003)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW0wWWdmZm9vcW10ZXppZDRxZTgzRkcyTHRGRkh2aTJ2RnNjUXlMN3EwRzlC?=
 =?utf-8?B?UVc3eWxFK0tkd2ZkN3E2L3BxdFF1OUN1TktuNVFZRVNOdFV4eWorTmw0N2c5?=
 =?utf-8?B?eUFMcHV2Z2t3WXJJTmZ2Z1h1aDlOYktGd3hCUDdCQzJnYWEwb3daRXJlcGlB?=
 =?utf-8?B?UHlhSi9EY2JtdDUwOGwrOE5kWEU1MDVkMHNkVmdQMkJIUEdDTVlRV3h5TGNK?=
 =?utf-8?B?WVlFZlBCaGVNcXdvY00zUThUTXZuRjF6Q3VSOWlTQm5hRWhvZDZyRTlIOUFB?=
 =?utf-8?B?amoyZDMreFZGSnRZZGM5a05sRjRjR25uVjZUMitKNTU0b1JwRDZVUjhxNU5y?=
 =?utf-8?B?RUo4dGQ5UW9Ec253blYwRlZxeHJZWUtLZldrMEVMd3RuYkpWU3FwLzFQS2hP?=
 =?utf-8?B?SGFEbHBtT243dFpuWUlrc2wzUUtuaVFEYlNVZ2VSdVN6ZmJVWDlmRmw3ZVNG?=
 =?utf-8?B?ZHFjRGhrOEpKY3JtODlFZ09rNFM2a0E2bVhjSEhENncwcWRidmYrSUdXZjB5?=
 =?utf-8?B?cG1LdVRvaFpBKzVVWThjM1NqZ3ZxTUhaQ3ZVQXZHTy9RVGh6VG1MRWxaWW1Q?=
 =?utf-8?B?SFRGZmVhTG1NMW9PV2JMR0tDeHMwa0s1TjNiY0F2VkJ0Q0U1SENyVTRxaitJ?=
 =?utf-8?B?dlUrUmxzelJYMmRoSnF2cmYzSXFiM2p6b2RFMzhVVGVBWjduek43WkVhMGpS?=
 =?utf-8?B?dWlkYkVjTS9aQmp5ZkkwRTlNU09IWldOME0zcUZYeitJRVJtcUErTU8xMHN3?=
 =?utf-8?B?dnRNRXFPekRQb0NuWG16MlRWcVRkS1hPRVU2WVdGK3VMK2J1MERKOVBDSGIy?=
 =?utf-8?B?QksvWkhrVGRuSVhrclYyUWZNM0FkWFNGT2lONWgxdit1OXlkeVZITk43QnZS?=
 =?utf-8?B?anRWNXA4VisvNGJLR2ZDeXFsNFJsWEU5UjZ2a0l5VmJxWXpTNEc4VXB3WHFJ?=
 =?utf-8?B?dHpzd2tyZEROS2RldEVXR1hwWnFQREE0dm9hR3h4blJCTkdreTc0dkNEVDQ2?=
 =?utf-8?B?VzZOUG10RUoxSzR0dlhlRVczUXhmSUlPNlpaZ0xsSDlJWFFkcGl0QkI5N1ll?=
 =?utf-8?B?RjduTlFXQUdJdFFuUmFtVXVmWHJ1aU5CWi9RMDRBdzZFbW5hVC9kQTZWK1Vk?=
 =?utf-8?B?S2U4MWdOQitBY2RHb1BVeFBPbktudko0Y25scnJhNEVvTFVUMDBIcDVvU0ZS?=
 =?utf-8?B?SHFZQU1xN01sZ0dBVys2QXRYWkVuWGJmZGVyc1RNOXJJcjVsaXkwWjRwZS9a?=
 =?utf-8?B?Y002dDNiZ3d1am9FOXN6bUlURklSQUUzQ0R2L1JZMStBTngvdCt5L3YwOHh0?=
 =?utf-8?B?dll3Y2g0UmRhNjB1Mm1pRU9kTHlTTVNrZ2p3SWFLTU5zUWl0cmZzN0FXUWtK?=
 =?utf-8?B?YXJ3OG5zYmdyZXhhcWpiMFZqTGI3ek80dCsrQmpJZ3RMNURVRjRYOWorUzBW?=
 =?utf-8?B?SUh0RUJtVHh3MHZtLyt5TWRaODRHQkxGSjFxc2JIZHlvSkNoK1hwZlBhdHdN?=
 =?utf-8?B?b0FPS1BPSUxubFFnL2NoZ3dvUjZmYWVacWdaUE9nVEpONjlLVnRKR1BYV0sz?=
 =?utf-8?B?S3hmWnhvWUpzUWppREZKay8wU0YwQk1TcGd4eStEOGxmMG5scHkvM1Nwb1d5?=
 =?utf-8?B?Y0pTTUVCVklkT1JXVisvTG9HRUF6enlpMyt5N0xxWFllQ0VMZ2E4Qm8wVkpP?=
 =?utf-8?B?aDFCVE1YRTVQUVlYVUxsTVJFZGZ3ZkF3Qi9BSTBwUWtudG93eXFKRnRibXRw?=
 =?utf-8?B?UVJwRVpSTXd4YzIybzRDM0w1b013VjVSQ3BOMHk0NWFUcHZMaXpVcGNtNTZE?=
 =?utf-8?B?SHlMd2ZFcVBwOEREakdxcVdLZFI3MkJNQUxIL0hyV01HSnA0Z29aL1U3dmpn?=
 =?utf-8?B?T24zak9LVzdnWW5FM1N2VUgyRURId1VRcFV4dFN2K29ZYllxVHNkbjdSYnhx?=
 =?utf-8?B?enBQOE90UWw2dzZ4UjMvTnA4WWN5ZjBZQllRcGRURTlvN1MwSkJnSVR1aGxC?=
 =?utf-8?B?SnhPUWV5b2VJQ2dVcitKS09ra0hkRVE0K3VGcmFjV0J4dWhMaVZPay80SGZF?=
 =?utf-8?B?Z0NkdVFMQ2dzV3hwdmZqY3NGeUY1QzFNd0pWekh4T0dCbFZmV2pCWG9leXJw?=
 =?utf-8?B?eTdLbDNsZWowRFZxVWxsb1p4VnpCdE1FNCt5OEdvVE40R29GZ2V0eFEwQUla?=
 =?utf-8?Q?i5OetfE2p0HNeKRauFNTo4k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef48843-a63f-4a58-6344-08d9cb62acde
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2021 07:04:51.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69nyS8rT/chQ1WQ1yS3WWTtPkGvbp28YTmmNiWKLE0aIShx2VYGelhfi+MOhU1VSOnvlNlN1D3N0Eqfu9QaW1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2642
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMzAsIDIwMjEg
OToyOCBBTQ0KPiANCj4gPiBBcyBwb3N0ZWQsIHRoZXJlIGlzIHplcm8gY2hhbmNlIHRoYXQgdGhl
IHBhdGNoZXMgY29ycmVjdGx5IGhhbmRsaW5nICNOTSBpbg0KPiBMMg0KPiA+IGJlY2F1c2UgbmVz
dGVkX3ZteF9sMF93YW50c19leGl0KCkgZG9lc24ndCBwcmV2ZW50IGFuICNOTSBmcm9tIGJlaW5n
DQo+ID4gZm9yd2FyZGVkDQo+ID4gdG8gTDEuICBFLmcuIGlmIEwwIChLVk0pIGFuZCBMMSBib3Ro
IGludGVyY2VwdCAjTk0sIGhhbmRsZV9leGNlcHRpb25fbm0oKQ0KPiA+IHdpbGwNCj4gPiBxdWV1
ZSBhICNOTSBmb3IgaW5qZWN0aW9uIGFuZCB0aGVuIHN5bnRlaHNpemVhIG5lc3RlZCBWTS1FeGl0
LCBpLmUuIHRoZQ0KPiAjTk0NCj4gPiBmcm9tDQo+ID4gTDIgd2lsbCBnZXQgaW5qZWN0ZWQgaW50
byBMMSBhZnRlciB0aGUgbmVzdGVkIGV4aXQuDQo+IA0KPiBZZXMsIGl0J3MgaW5jb3JyZWN0IGJl
aGF2aW9yLg0KPiANCj4gPg0KPiA+IFRoYXQgYWxzbyBtZWFucyBoYW5kbGVfZXhjZXB0aW9uX25t
aV9pcnFvZmYoKSA9PiBoYW5kbGVfZXhjZXB0aW9uX25tKCkNCj4gPiBpcyBmYXRhbGx5DQo+ID4g
YnJva2VuIG9uIG5vbi1YRkQgaGFyZHdhcmUsIGFzIGl0IHdpbGwgYXR0ZW1wdA0KPiBSRE1TUihN
U1JfSUEzMl9YRkRfRVJSKQ0KPiA+IGlmIEwxDQo+ID4gaW50ZXJjZXB0cyAjTk0gc2luY2UgaGFu
ZGxlX2V4Y2VwdGlvbl9ubWlfaXJxb2ZmKCkgd2lsbCBydW4gYmVmb3JlDQo+ID4gX192bXhfaGFu
ZGxlX2V4aXQoKSA9PiBuZXN0ZWRfdm14X3JlZmxlY3Rfdm1leGl0KCkgY2hlY2tzIHdoZXRoZXIg
TDAgb3INCj4gPiBMMSBzaG91bGQNCj4gPiBoYW5kbGUgdGhlIGV4aXQuDQo+IA0KPiBEaXR0by4g
VGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhvc2UgZmFjdHMgdGhhdCB3ZSBvYnZpb3VzbHkgb3Zl
cmxvb2tlZC4NCj4gDQo+IFNvIGhhbmRsZV9leGNlcHRpb25fbm0oKSBzaG91bGQgbmVpdGhlciBi
bGluZGx5IHJlYWQgeGZkX2VyciAoI05NIG1pZ2h0DQo+IGJlDQo+IGNhdXNlZCBieSBMMSBpbnRl
cmNlcHRpb24gb24gYSBub24teGZkIHBsYXRmb3JtKSBub3IgYmxpbmRseSBxdWV1ZSBhICNOTQ0K
PiBleGNlcHRpb24gKHRyaWdnZXJlZCBpbiBMMikgdG8gTDEgd2hpY2ggaW50ZXJjZXB0cyAjTk0g
KHRoZW4gZXhwZWN0cyB2bS1leGl0KQ0KPiANCj4gVGhlIGZvcm1lciBzdWdnZXN0cyB0aGF0IHJl
YWRpbmcgeGZkX2VyciBzaG91bGQgYmUgbWFkZSBjb25kaXRpb25hbGx5DQo+IHNpbWlsYXIgdG8g
d2hhdCB3ZSBkaWQgaW4gdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKCkuIFRoZSBsYXR0ZXIN
Cj4gc3VnZ2VzdHMgdGhlIGFjdHVhbCBleGNlcHRpb24gaXMgYmV0dGVyIHBvc3Rwb25lZCB1bnRp
bCBfX3ZteF9oYW5kbGVfZXhpdCgpLg0KPiANCj4gV2UgYXJlIGxvb2tpbmcgYXQgdGhpcyBjaGFu
Z2Ugbm93Lg0KPiANCj4gQW5kIG9uY2UgI05NIGhhbmRsZXIgd29ya3MgY29ycmVjdGx5IHRvIGhh
bmRsZSBpbnRlcmNlcHRpb24gYnkgZWl0aGVyIEwwDQo+IG9yIEwxLCBJJ20gbm90IHN1cmUgd2hl
dGhlciB3ZSBzdGlsbCB3YW50IHRvIHNwZWNpYWwgY2FzZSBMMSB2cy4gTDIgaW4NCj4gdm14X3Vw
ZGF0ZV9leGNlcHRpb25fYml0bWFwKCksIHNpbmNlIGluIHRoZSBlbmQgTDAgd2FudHMgdG8gaW50
ZXJjZXB0DQo+ICNOTSB0byBzYXZlIHhmZF9lcnIgZm9yIGJvdGggTDEgYW5kIEwyIChpZiBleHBv
c2VkIHdpdGggeGZkIGNhcGFiaWxpdHkgYnkgTDEpLg0KPiANCg0KdGhlIG5ldyBjaGFuZ2UgaXMg
bGlrZSBiZWxvdy4NCg0Kc3RhdGljIHZvaWQgaGFuZGxlX25tX2ZhdWx0X2lycW9mZihzdHJ1Y3Qg
a3ZtX3ZjcHUgKnZjcHUpDQogew0KCS8qDQoJICogU2F2ZSB4ZmRfZXJyIHRvIGd1ZXN0X2ZwdSBi
ZWZvcmUgaW50ZXJydXB0IGlzIGVuYWJsZWQsIHNvIHRoZQ0KCSAqIGd1ZXN0IHZhbHVlIGlzIG5v
dCBjbG9iYmVyZWQgYnkgdGhlIGhvc3QgYWN0aXZpdHkgYmVmb3JlIHRoZSBndWVzdA0KCSAqIGhh
cyBjaGFuY2UgdG8gY29uc3VtZSBpdC4NCgkgKg0KCSAqIFNpbmNlIHRyYXBwaW5nICNOTSBpcyBz
dGFydGVkIHdoZW4geGZkIHdyaXRlIGludGVyY2VwdGlvbiBpcw0KCSAqIGRpc2FibGVkLCB1c2lu
ZyB0aGlzIGZsYWcgdG8gZ3VhcmQgdGhlIHNhdmluZyBvcGVyYXRpb24uIFRoaXMNCgkgKiBpbXBs
aWVzIG5vLW9wIGZvciBhIG5vbi14ZmQgI05NIGR1ZSB0byBMMSBpbnRlcmNlcHRpb24uDQoJICoN
CgkgKiBRdWV1aW5nIGV4Y2VwdGlvbiBpcyBkb25lIGluIHZteF9oYW5kbGVfZXhpdC4NCgkgKi8N
CglpZiAodmNwdS0+YXJjaC54ZmRfbm9fd3JpdGVfaW50ZXJjZXB0KQ0KCQlyZG1zcmwoTVNSX0lB
MzJfWEZEX0VSUiwgdmNwdS0+YXJjaC5ndWVzdF9mcHUueGZkX2Vycik7DQp9DQoNCmluIHRoZSBm
aW5hbCBzZXJpZXMgaXQgd2lsbCBmaXJzdCBjaGVjayB2Y3B1LT5hcmNoLmd1ZXN0X2ZwdS5mcHN0
YXRlLT54ZmQNCmJlZm9yZSB0aGUgZGlzYWJsZSBpbnRlcmNlcHRpb24gcGF0Y2ggaXMgYXBwbGll
ZCBhbmQgdGhlbiBiZWNvbWVzDQp0aGUgYWJvdmUgZm9ybSwgc2ltaWxhciB0byB5b3VyIHN1Z2dl
c3Rpb24gb24gdm14X3VwZGF0ZV9leGNlcHRpb25fYml0bWFwKCkuDQoNCndoZXRoZXIgdG8gY2hl
Y2sgbXNyX2JpdG1hcCB2cy4gYW4gZXh0cmEgZmxhZyBpcyBhbiBvcnRob2dvbmFsIG9wZW4uDQoN
ClRoZW46DQoNCmhhbmRsZV9leGNlcHRpb25fbm1pKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCnsN
CgkuLi4NCglpZiAoaXNfbWFjaGluZV9jaGVjayhpbnRyX2luZm8pIHx8IGlzX25taShpbnRyX2lu
Zm8pKQ0KCQlyZXR1cm4gMTsgLyogaGFuZGxlZCBieSBoYW5kbGVfZXhjZXB0aW9uX25taV9pcnFv
ZmYoKSAqLw0KDQoJLyoNCgkgKiBRdWV1ZSB0aGUgZXhjZXB0aW9uIGhlcmUgaW5zdGVhZCBvZiBp
biBoYW5kbGVfbm1fZmF1bHRfaXJxb2ZmKCkuDQoJICogVGhpcyBlbnN1cmVzIHRoZSBuZXN0ZWRf
dm14IGNoZWNrIGlzIG5vdCBza2lwcGVkIHNvIHZtZXhpdCBjYW4NCgkgKiBiZSByZWZsZWN0ZWQg
dG8gTDEgKHdoZW4gaXQgaW50ZXJjZXB0cyAjTk0pIGJlZm9yZSByZWFjaGluZyB0aGlzDQoJICog
cG9pbnQuDQoJICovDQoJaWYgKGlzX25tX2ZhdWx0KGludHJfaW5mbykpIHsNCgkJa3ZtX3F1ZXVl
X2V4Y2VwdGlvbih2Y3B1LCBOTV9WRUNUT1IpOw0KCQlyZXR1cm4gMTsNCgl9DQoNCgkuLi4NCn0N
Cg0KVGhlbiByZWdhcmRpbmcgdG8gdGVzdCBub24tQU1YIG5lc3RlZCAjTk0gdXNhZ2UsIGl0IG1p
Z2h0IGJlIGRpZmZpY3VsdA0KdG8gdHJpZ2dlciBpdCBmcm9tIG1vZGVybiBPUy4gQXMgY29tbWVu
dGVkIGJ5IExpbnV4ICNOTSBoYW5kbGVyLCBpdCdzDQpleHBlY3RlZCBvbmx5IGZvciBYRkQgb3Ig
bWF0aCBlbXVsYXRpb24gd2hlbiBmcHUgaXMgbWlzc2luZy4gU28gd2UgcGxhbg0KdG8gcnVuIGEg
c2VsZnRlc3QgaW4gTDEgd2hpY2ggc2V0cyBDUjAuVFMgYW5kIHRoZW4gdG91Y2ggZnB1IHJlZ2lz
dGVycy4gYW5kDQpmb3IgTDEga2VybmVsIHdlIHdpbGwgcnVuIHR3byBiaW5hcmllcyB3aXRoIG9u
ZSB0cmFwcGluZyAjTk0gYW5kIHRoZSBvdGhlcg0Kbm90Lg0KDQpQbGVhc2UgbGV0IHVzIGtub3cg
aWYgeW91IGhhdmUgYSBiZXR0ZXIgc3VnZ2VzdGlvbiBmb3IgdGhlIHRlc3RpbmcgaGVyZS4NCg0K
VGhhbmtzDQpLZXZpbg0K
