Return-Path: <linux-kselftest+bounces-119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBD7EBB47
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9540B281410
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 02:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B597164F;
	Wed, 15 Nov 2023 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtdsp/Qp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3A395;
	Wed, 15 Nov 2023 02:41:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F67C8;
	Tue, 14 Nov 2023 18:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700016103; x=1731552103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PnibM2hk+ajxWaePmp4D+kzlssOe6ZILnAiQa/Z5rZ4=;
  b=gtdsp/QpGeK5uAC08909ipQ8bW335QfPvby3GmZoy4JdSyw631epRtLx
   Mnhp1SAKNwEf8uXyRTT77hins+PJSQIn1b9qFQwFR19897TH6OWf2RoMe
   amBA8ogPRYoYPrG9JqDw//UGVdEylc6gbw5y0ZGbF8Rs4NZlhCEIHlFHc
   n2qflWD3VBeXkKAEMkaOjlze75KkbK7FG0Z/+NH/47bAtQ4vZdbYfZ4/x
   FW6IR/xlnoRizqc5bv3KKfwfmWjGiYrmELaQrKAbZgIUTYCD2X2ep61Xi
   o0rr04kSMrsIOzG4cI2qSLSxJ7Ur49XPDd/Y60iNCLU8o+LATJ4vIbAyF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="457297048"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="457297048"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 18:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="794012263"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="794012263"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 18:41:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:41:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:41:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:41:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9tYWUmJAbNNYUb32RnXmWhlF5ZdPbwZYibon+xg84iqAvut+RZDsAcb3k1KYw/tcTf3RXx3oSf4d+7MqsQK0lENwZLsQsgqRwV13X2Mi0ClJUtJoEvKORfEiuR1YWyJPaTA0UhroRtR/27cHzSEq1fqKNcd/s+5Ng10HJiu2VItHNfP9yZ0KHci1AQSF2g0OD9eU2UJnp32U9NRFlI1dwkM/YBPoO+OHJyD9zPfBdt4XSzsJVD0VewcnupbYkTVSvO6CJiDr8bdGAsVVpJ1xBWz+88rx0MWTSuQIPBUQ4yE19wUtsEnJtx0BotCgX1FqIRi3RKRbVJaTYX+XTBNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnibM2hk+ajxWaePmp4D+kzlssOe6ZILnAiQa/Z5rZ4=;
 b=WEh255fhdhjvjYbwa6nGiKpDWUFeideR2Z2Xz3boGRntQjV2yA7Sox882QibnAFl7Qn28U/EXEyJ4ceFyNZPOXlv51AWUdoihk/csoxV54mvEh13srF0SvORYV7CyqHTAHBp3OTMyIourTovi6ZU8r/oV2thTCD35KCv/9bMqD4Ou54Y+CXKG5m9E77zrMYKEvWJN3qwseCDRSLUnbLWEcWfEujOjDKSveu86iEYqMF+CusbMDMg+p5tZ9oJweBgm4OKK35hayv4kKVEm5+YTbfO0+TUkKlOXISRiwlr4cqce0McaWeP1QK2r4SJL2nWK5bbM3cu7SWCGCqWXIJCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by BL1PR11MB5542.namprd11.prod.outlook.com (2603:10b6:208:31d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 02:41:25 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 02:41:24 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
CC: "seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "Cui, Dexuan"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "vkuznets@redhat.com"
	<vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v1 14/23] KVM: VMX: Dump FRED context in dump_vmcs()
Thread-Topic: [PATCH v1 14/23] KVM: VMX: Dump FRED context in dump_vmcs()
Thread-Index: AQHaEnYWryfD2EHE70+bGd055X0RNLB56x+AgADKLuA=
Date: Wed, 15 Nov 2023 02:41:24 +0000
Message-ID: <SA1PR11MB6734D65FA9006177485E7E2EA8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-15-xin3.li@intel.com>
 <71636309-3bf1-4e7a-b586-c61fea30f7c0@suse.com>
In-Reply-To: <71636309-3bf1-4e7a-b586-c61fea30f7c0@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|BL1PR11MB5542:EE_
x-ms-office365-filtering-correlation-id: 4abcb1ce-7948-4c8c-ec08-08dbe5845c30
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NcDjWrfkzMInxZCsSRwvx1NrE0tRoPlbX5hcQTr4+QvEHpXQhDUJvwwHMxRVoiwrvf6igsBzO2fz5Fv2BZ8Ij4uVkXHQzwRl1M4IXZfnrm0n8BvuyFYw/G9wuXppeCz8o5zYsp+hNmAAKpLbau0moFLOoReHHgkyS0vZtpRyd1cvtBbyrnF8KvgB133xXnjH6uw6F9cKrZfcZn7kQnVVlcIAcqh1eEsj92Ibqu32Ewk+xrrcnjE3wgxm+fKl2veBF+sPdC2qjlJHM0+gO/wxgIy4G8cvIEy/yrNQWNyObFX9OrEKQ0G0moOjA7BvAFY+mFfTl980+gNJrHE9hlYRIORlwHGvRoBzmusPlv0y8FH8N4ipryTPfaPTGkD+QX3URFSv1nh7amDa6lN9TMBn7CBGcz4Vy4p4NiSrOSX8P0CKRk0exwiHGblOTUL9kko5mLEGNYYylrF1mGorYmB4YtYmYSdWjxlebRDcjT20vtOcIPf9H6JRK2n/UCbKoUiaog9U0mzLCWsRIoNi1/hOXlHVkrIC8ZHh9/Miy1/kh5YoII6DR0g+SPOSnUH+NoVc8j+Bmt2NMWCZXnz84p3DU4VjunyotyfjN0oOg7f+fpoAJTwL0B6Juaabs3LD5Nr8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(55016003)(38100700002)(71200400001)(7696005)(6506007)(83380400001)(122000001)(9686003)(33656002)(2906002)(7416002)(41300700001)(82960400001)(4744005)(5660300002)(4326008)(86362001)(8676002)(8936002)(52536014)(38070700009)(76116006)(66946007)(66556008)(66446008)(66476007)(64756008)(54906003)(110136005)(316002)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTl1RldMMWZlRkhyQXJJTDFYS1JmbDBoUkRjeXVobDlONTNJNDdjU3h1WnlL?=
 =?utf-8?B?TEp1OEVXbkRWZGVFTTVoVm5tWTBVbERYRFhjVDZIU0JNem5IVTJrSHNVSEpH?=
 =?utf-8?B?YnFVcWhhZmZHVm5QYkI4SXNHUXJETno2TitWblVyQW50MWl1Zk9zOE9uYkZp?=
 =?utf-8?B?dzFkaTZTZVBMRDBVQ1RoNFNpRVBSaUx6SXlvMTh2UjI1eXRpdHF4YlR3R3h6?=
 =?utf-8?B?V2hlNXBGZWdCYzhmMkdVb2wvNU9hU3R3VVFuaXlUQlNBa2NWYTVBbmtYNVZk?=
 =?utf-8?B?cUMrOHZyeGd5N1NGaTRiZnpyWmRNT3Y5OUxxTERzQlBGcG5KTTRXUWZsUGZw?=
 =?utf-8?B?ZHQ2am5lc2J1dXNjcHNaNWhQVHdkMjV1eHJJWkJCMGIzQmhyL1hKNVVxb3FK?=
 =?utf-8?B?dTlSZW1WcVZvUUFORnJob3o3QTdaYTM3Z013ekRWMWt6WGl3V1NOMGd6Rno0?=
 =?utf-8?B?YVpSdjByYnB6RDhjQ1RwWkRKbnlTbTRpVmlsdWlNYlFlOEs1ZXNmeUhyWFhR?=
 =?utf-8?B?MTI3alhaVlduNEhmRFFEWXp0WjNrK1FrbkZ3RU9WamdjWnVDK3RKSnpqUU1n?=
 =?utf-8?B?MjhWWjMrS21jcTFZc3lFNzNmRUZNUFhPR3h2MkxnOGtnNWlGQ2dqQ0JJQkky?=
 =?utf-8?B?Z3pCRUpwWDdpTzVXb3ZTYXNIUnpmd3lxallReVptRyttMXlocFRsaWVBOWJp?=
 =?utf-8?B?OXZFaWhOSkJUNjRDakd6R1BxRDI1TFFQNXFzZWpxVnYzNHBLT3Exa0Iyenkx?=
 =?utf-8?B?bEpzcmphczJyQmhhcGRiQTVUOUJobVRjTmROelpRcXNLbmlFeW9WQ2diZ0Ur?=
 =?utf-8?B?TGcxT1ZrSndKMVlRR3FncFh6dmlkUWlpZG0rRStuQWRsREpxUFlpVkRWZXRM?=
 =?utf-8?B?REgrSC8yb2QrM05oNTlzcUtrd3QxTCs5MHVUbWF4d0hIMDdDYm9Pd1d3eWM5?=
 =?utf-8?B?VFBJNTNjekxQZGQ5UVY1MkgzSDA0T3pRcmdQTGd3UnpHMGdtRzBSbjdGejhL?=
 =?utf-8?B?cnlOczByWEdGNCtvTUk1TmNYa21HaithcUpoRlh1dkJ5U0NVSm83djI0Uzgx?=
 =?utf-8?B?MXJpYVBNdHpBSUYzZVYwYVlJUHBiTFliZmgvVkRjMUtDMFp6YUQyNmpla2Qr?=
 =?utf-8?B?Uk9EUE96bnIrTElFcmlxendhTmk0SE41U2ZXV3JtUWN6THJDU29zQzdkSllV?=
 =?utf-8?B?aTErYmdXd1BEVXRTeTNWY1hDV1o1a2pELzJkZldXSERFV1o0QUhoN1dhd1dT?=
 =?utf-8?B?UW5FdHNuRHJjQnBXYSt3MjNIUkUyVVB1aEg0dHE4ZU1WUDM4ckxOdG1ZakI3?=
 =?utf-8?B?LzlWSTZNNmlIYVlDMDEwT0NEOC9GNWNYbkJvSmxyV2FQNlJIWGo5VmM0cWxS?=
 =?utf-8?B?L3pzTnlVZVZxd0UxSjkySFQxWFR4TzVia2N0ZWpLMUNqcFc5ZW81VkVweXJh?=
 =?utf-8?B?L2FZeFl2UzZjUjNVbGR6SVFmTU93NThXQVh0aXliSUVPa2x0MGVYM0p1bGtG?=
 =?utf-8?B?U3RvZnpHRFJBTTd4N0ZnWnBZejdDVEl0eGdqLytDaFJtQnZ0cUdJandhSVZn?=
 =?utf-8?B?TmdVbWRvY2o2UFVvWWJUSWwzQjlWUGw4RUpSbnlKNEd6RlNmcjVhMkMybUs3?=
 =?utf-8?B?U2pkVkRQdEhyMW8vcEpINkVRUEpERTR4M1lsU3dFb0x1MDE5T24vQWUvcW8w?=
 =?utf-8?B?dysyTitpMk12bjVsem5tcm9LM2RGb2N3ZVVxN09EZ2VMT3M2dXUyZFJBd0lh?=
 =?utf-8?B?eHJvRW5UOGdXS0laRlY4bVpqUVY1bVVUelBFMk1YcGtIRkRhUS9OZVpNcC9X?=
 =?utf-8?B?MzV3dldQTHcrRTFEazJQTThxUWtpZTdLeXJxKzZuVjRvUlRFWGNScXBGSjky?=
 =?utf-8?B?dzNQcUF4VVZ3MmgxN3JPOHYzY1Ezb2U0dWFuYm1EWkpsNVRXMlF1cmk5bVhl?=
 =?utf-8?B?Q3p2a3pJTWJ6TFI3R1Zsd0xnZjhEQVRFQVlpVjR1NWh1VUlrNFJlZm4rSk5K?=
 =?utf-8?B?aXBESGZidkowbjdYdmNaMkhzWWF0WFN2Z0k0alNRUEk2d0NWVHZ0OUZQeHFk?=
 =?utf-8?B?aHdXQlppQWFraHlpdDdaZnM1VVkyVCt3cTBsM003b0cwTm1WOEwvcVJEZ2pW?=
 =?utf-8?Q?VbNjc/Dp9V15GGCfTADwNz/8t?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abcb1ce-7948-4c8c-ec08-08dbe5845c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:41:24.7672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcLy2Jo4cZx/zBRNXYxBCFus4/9Azef6HR5SANkto2Icat/m5RnLOa18HmfQ2KYQfc7ZcPwRm5q4oLfcRUbyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5542
X-OriginatorOrg: intel.com

PiA+IEBAIC02NDQwLDYgKzY0NDAsOCBAQCB2b2lkIGR1bXBfdm1jcyhzdHJ1Y3Qga3ZtX3ZjcHUg
KnZjcHUpDQo+ID4NCj4gPiAgIAl2bWVudHJ5X2N0bCA9IHZtY3NfcmVhZDMyKFZNX0VOVFJZX0NP
TlRST0xTKTsNCj4gPiAgIAl2bWV4aXRfY3RsID0gdm1jc19yZWFkMzIoVk1fRVhJVF9DT05UUk9M
Uyk7DQo+ID4gKwlzZWNvbmRhcnlfdm1leGl0X2N0bCA9IGNwdV9oYXNfc2Vjb25kYXJ5X3ZtZXhp
dF9jdHJscygpID8NCj4gPiArCQkJICAgICAgIHZtY3NfcmVhZDY0KFNFQ09OREFSWV9WTV9FWElU
X0NPTlRST0xTKSA6IDA7DQo+ID4gICAJY3B1X2Jhc2VkX2V4ZWNfY3RybCA9IHZtY3NfcmVhZDMy
KENQVV9CQVNFRF9WTV9FWEVDX0NPTlRST0wpOw0KPiA+ICAgCXBpbl9iYXNlZF9leGVjX2N0cmwg
PSB2bWNzX3JlYWQzMihQSU5fQkFTRURfVk1fRVhFQ19DT05UUk9MKTsNCj4gPiAgIAljcjQgPSB2
bWNzX3JlYWRsKEdVRVNUX0NSNCk7DQo+ID4gQEAgLTY0ODYsNiArNjQ4OCwxOSBAQCB2b2lkIGR1
bXBfdm1jcyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ID4gICAJdm14X2R1bXBfc2VsKCJMRFRS
OiIsIEdVRVNUX0xEVFJfU0VMRUNUT1IpOw0KPiA+ICAgCXZteF9kdW1wX2R0c2VsKCJJRFRSOiIs
IEdVRVNUX0lEVFJfTElNSVQpOw0KPiA+ICAgCXZteF9kdW1wX3NlbCgiVFI6ICAiLCBHVUVTVF9U
Ul9TRUxFQ1RPUik7DQo+ID4gKyNpZmRlZiBDT05GSUdfWDg2XzY0DQo+ID4gKwlpZiAoY3B1X2Zl
YXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUkVEKSkgew0KPiANCj4gU2hvdWxkbid0IHRoaXMg
YmUgZ2F0ZWQgb24gd2hldGhlciBGUkVEIGlzIGVuYWJsZWQgaW4ga3ZtIGFrYSB0aGUgQ1BVSUQg
Yml0IGlzDQo+IGVudW1lcmF0ZWQgPw0KDQpZZWFoLCB0aGF0IGlzIG1vcmUgYWNjdXJhdGUuDQo=

