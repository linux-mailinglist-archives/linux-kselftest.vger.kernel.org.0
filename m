Return-Path: <linux-kselftest+bounces-118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDF67EBB41
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 03:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C39281417
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 02:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47298658;
	Wed, 15 Nov 2023 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpglWHD1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE6B644;
	Wed, 15 Nov 2023 02:39:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C529DC4;
	Tue, 14 Nov 2023 18:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700015997; x=1731551997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HuiQbswVLftVQT9NLZLk1PHTPXGXM3TfqCieK/uxDYM=;
  b=UpglWHD1FdoApuoalGlesG47xssdW5Y9H7vgVDhKLtgWxZbKTAm9YHdJ
   c6WUGVK7QaAvDrpzd0iDlVfQ0mrvOd1j0c0n1DHfF6BLlgthN6jsm3fr1
   DDPingURpXXm7/Ls5GnLN3f6yEt06hyOejWjQFiJ+KISgBukFeDeEP+Ap
   wDYAG9aDySsag7aom+HektJerBuOrMnzbHlnDHpnc71/IKvVVH063gP3p
   IHTYqM3AiQUuHfJZI9CbvQ4rG9qhFs96mnKVn5dr6JcTukYvysFAzkz25
   o1koHZNkrqhn+X1ItLKbSgrsBp/XNzwc0GqVKTUgsf8/NjCMo/StkePjD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="370988357"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="370988357"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 18:39:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012122056"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="1012122056"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 18:39:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:39:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:39:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:39:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb38Je/8LxXxs2ymSmrEeQtz4ZRiXiQM4hWepIy00eatt6apvWmRXFcxwQA3oBY3P/tFnnbtoZCtkjVa7VLx4SB2S3cNz0yW/x5j7ptN/9HbNlNEpFehWWdEvVV3/7WdGK4mlKs5NziGneOMQcmSqckvGMEZFrohOPwGSROztcrZj+SVT+2jIn20WEY0oVZ7DhfT7dlisvQ5KO3lMZ5ZfbomXYFmoYw7ga74ZiK+tAGVNLMfP+fadWz5B4l56fa9YJnBv4tNSDB3UIalYTebcMss5ukRXpo57T5JAF6Rz6MIxS5IzDR0Qj6OIwZUSs7GrB0IRIC4+Htng+dqGqhUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuiQbswVLftVQT9NLZLk1PHTPXGXM3TfqCieK/uxDYM=;
 b=eie86EJNPXo8mv3byZhflxeJ5Qvm5z3d4dUtYbLIyyF8uppVhfKoy9s7oIsniKlaW/0yCNpY1RuLBforVcYLtKJm2kurTOCFYcsgIFAEvsi5vAdYyBb7CXW9gY6cV2nnbUDbQR0930PFZaLkiSyNyT4vSZeuR9mqG2l32TRlZyouT2SkW96ac+O0raMIqa73GMmbCis+dEgnnP8xbCar/JMGJ5bCKT3sO5YfxZ8CnCf9g9D9F6tljs3qleev4Cdiq5hiaM4OmNQl9z4goBeWaN8wxc7bByhunkndqHtlar4rncN2gvNi/5O9IJS/5znm3mGEvKTWozV7JSMKUXDVYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 02:39:53 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::3d98:6afd:a4b2:49e3%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 02:39:53 +0000
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
Subject: RE: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit controls
 in vmcs_config
Thread-Topic: [PATCH v1 05/23] KVM: VMX: Initialize FRED VM entry/exit
 controls in vmcs_config
Thread-Index: AQHaEnXtUpNORx09eEG1bKB7uAQ1LrB4hgCAgAIuZJA=
Date: Wed, 15 Nov 2023 02:39:53 +0000
Message-ID: <SA1PR11MB67345334BC2384D0785C8416A8B1A@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20231108183003.5981-1-xin3.li@intel.com>
 <20231108183003.5981-6-xin3.li@intel.com>
 <9a4b7340-8ff8-426c-b25b-4ec340f96fd5@suse.com>
In-Reply-To: <9a4b7340-8ff8-426c-b25b-4ec340f96fd5@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB6422:EE_
x-ms-office365-filtering-correlation-id: 26667d66-385e-4574-0d86-08dbe58425b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uy8FDGik8V9uKQza7CoVIaRfgwYFC5Qb28nUV6b1LRhbEbQq1DkjrLsxFbgCYl2CcJlHxO1ZtEqJPfrim/J/qBoY9wXGYuPvhoAdVqztySvSmtR2ZFdpscuiwdDjw6URKM7B3yiCofFSjKnZ4VEYpTX0gndXj2Hhxn9eB1dTLxhHQUc7rXIRYWytuU8sZ8NNJomdsicXFiDSLRxL7WuHSceRUO31QOjbNnmTp8jHijdCgKo56UXX4fAcvsGYWT/jKJSKO+kOo1vSbzqWKYEFfk4/vsiVWQKcfsXdJy2NEalf+9uAEnTksA2q0KmoubiSTLpNXFyWWudMoVoVXaFc3muNTKOts1GbZMKOkoQBIm60rntgIHj+wz/2xFC8uVKISC0T8JlmrT+TvengM1uqz1+U1ctd/Ex4rVAtyE5gfj+sEWXju0KVO1Ie+bpO8+rHSBR5KJInAsJ79304Y1/mdyBrk1Xi9ou0Wm+GQCZMXdveMhB1e1NXP24KRgB3YVKbSIbWfrPEikUtnYDFVGp9esU6Zd+zwv7brjuHNyDpcdhtHvmXRwAQ3iRSYyI08BjxjE3+ni7GCgneowbOSniGTIZ3OSGAQJmAuQyXLeSbGTsiHCrsZZa9II4P4fCZHfBF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(9686003)(7696005)(6506007)(8936002)(26005)(82960400001)(478600001)(52536014)(4326008)(8676002)(33656002)(86362001)(7416002)(2906002)(4744005)(41300700001)(5660300002)(76116006)(38070700009)(66946007)(66446008)(66556008)(54906003)(66476007)(64756008)(110136005)(316002)(71200400001)(55016003)(38100700002)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk1tWkRrYnhrZzZTSVZINXdWTmFrV2twcjF5NnJTa0FHdlJhd3JsM3MrNFB0?=
 =?utf-8?B?UWZZOGdqajgyNExMbmJ2OG1xQ0hCQTFwWk5WNWJVRlQ0UTNGaS8rVnZiWHhl?=
 =?utf-8?B?blh4MFowM3l5WHh1eStDY2xCdFI2YmNwUW12WW10YU9TdnBUbDkyd0Y0R1lJ?=
 =?utf-8?B?UGlWUkFtdktYc2IwamVuQUZkWnExZkJtN3o5YW81ajhIRzdKL29UR0pRZk9r?=
 =?utf-8?B?Mi9zN3dnRUp3UWlXbjVJeGZ0TTNTY0dnQ1hIbmQ1ZGJZR010UnlBczBWYlVq?=
 =?utf-8?B?WG9ORjIwNGJSMWpOL3QwSzNOdXV0cW1oU3drQ1hUR1VZT1lUK1dKWld6OVJ5?=
 =?utf-8?B?d3ZSd1dpOTFPNjFobHFDTGk5eXBQTTdnaFVIZlhhcGk4OVdUL2dnaFFnVW9i?=
 =?utf-8?B?Z1J2dUFMWG55cHBLMXhZdlc1UzU2NEg2cjFBb0V1Ym04bnFjNTBUNHhDbDBr?=
 =?utf-8?B?SFRRWksyUHJyaUx6NklSRHNWQjBQL1EwVE52enRGcDFQbml2b0JBU1ZkMnpS?=
 =?utf-8?B?d0JweXJPK096VmFrYzlEaVpwNkFrUDZIakJxWEIzQ29BK3VFMlhUa216UFRY?=
 =?utf-8?B?QWlJZkd4RWVubGZ6V3I3VHdFSEs5aFhLejd4ZS91a3J5MTZGa0V6cHViblgr?=
 =?utf-8?B?NFJ1ckR3QjZhSmpGTFpDSG5TeTFMYlBhdGZORWoyVUc2eWZBVDVzdVpTSi9s?=
 =?utf-8?B?a29pcE1JMFNWL2p5bmhBUWtWb2lva2N2SEJmQTAybTArWUEvUktvOVhQeU9n?=
 =?utf-8?B?cGhVN2RXUnhqZjJpZEMzTGVML0U2NldkVm5LajVBRERPc3g0eGpoS2hZeGxj?=
 =?utf-8?B?Qmt3TWkzMExHZUluWDJuSjh2MWpjbVN4M2NGdDF1d1l5bTYxL1VQOGhXOEIy?=
 =?utf-8?B?VEFiQ3R2bjlackZTSGFFajY5N2R4L25ta1d3bU5mcElpa0JRV2ZaRzJlbTA4?=
 =?utf-8?B?ZWxzVjVFUERLSExwc1RvdU9uOWV6UjZpTXVyQzZCeCtDaEhxVmEvM3NzS3dQ?=
 =?utf-8?B?YUswUkVDQUwrNndVTlp3Uml1SVdxUC90RTVOSlh3QkoxQTJXZG5VN0V6cll4?=
 =?utf-8?B?N3gyMkdQOGhyY3lyalpvSis5bUpNdjQzODhuSFltRjNZTndiQkpGMUNJZ09C?=
 =?utf-8?B?SXkvWmRTMUp1N0ZxVU52cklzTjJrRDVNb1hPNG8zbWZZbEdnbGxhUFg2Tk9h?=
 =?utf-8?B?QzFGZ2RBSSsrR2lhUWU2dzNXSU4yNmVqZklUMTFIbHZ6cnA4YS9hVExxL1ha?=
 =?utf-8?B?cTNKUDQzNXl0WTAzdThWVzcxYnhoV2RRYyt1ZFNTY05DRFp1aEZJRVFhc0NW?=
 =?utf-8?B?S0VIOG0xU3V0MzJ1a1gvMUFFU2dTNVd1WGVVdkozNS9ocnV5ajJiTnRFT2Q2?=
 =?utf-8?B?cE1rYzUxQjBVTVNETGY5VkhRc1Y1dktvYmFEc2o3TVU2Q1FpalFMeERlY0JR?=
 =?utf-8?B?a01OU3JsWXRzTWJYNldSNnJCZDg1dWFiTzgzbFRxRDIvU1ZiM2M0Q3ZYRnZ0?=
 =?utf-8?B?UlBkZUtBN2NyL0JtRVoxNkhMS3lKcWJ1dFQ2dy8zWUl2NGtmTWcrNWxJV01r?=
 =?utf-8?B?blFQVXFxUDdYcURrUjVhbXg0UCtYaG9tellYd2o3L3hxbHJFN1RzL3JqT2Nn?=
 =?utf-8?B?V0NaM2dPQnltWDBJeHplWFowWEIxN3hGaVlOTFZ5c0lmUDZRWVZ1SXY0bzlr?=
 =?utf-8?B?ZmpDMlg2dmRPQWlTcnZvWi9zckNxWHZSbVhNZC9nTTFmUW9LdGRXNlZsajNJ?=
 =?utf-8?B?WElhU3JIYW05UGlwbmlLWnRqQThXVExCNGtWaWwxV1Y1eEZzUFEzdGI1TVdz?=
 =?utf-8?B?YkpkSDV6ZEVEMm5LZDlmUzdMYW1HTElSQ0dLeUhyNGZSM2xtRGk0VEFjTHlm?=
 =?utf-8?B?bElrYmVLSStNSGNJbVNUVnBLcFZ6SEtnR3Fkd29LNlZ6UjArcnAxaDFSZ29K?=
 =?utf-8?B?TGNmMElLemkyUkMvamtLaTFVeCt3UE5DVzBXZitKeEN5THhDdWlURFlMcW5x?=
 =?utf-8?B?eHhLS2lhRmpmRzZsN3hvUUFGNHNha0ZXYVpyUFNMSkJXYk9ScHlzN3JJM3Zp?=
 =?utf-8?B?MlFmK3plTE5MLytEK0dXV0J2OWV3UVljZWpsQ2RLcjdpdXIvWTUvNldKMGVi?=
 =?utf-8?Q?ISn7nyL3J7StM247R6c1/QR5d?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26667d66-385e-4574-0d86-08dbe58425b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:39:53.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8zssfQrRDSRzqNgOvs4MYsKJKzy5LNXwzj3/Mq0S/iFm8RPF/jdRxKrjZwd/zuPRyCCqQAbE0yeXUAjQS6ErjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

PiA+IC0JaWYgKF92bWV4aXRfY29udHJvbCAmIFZNX0VYSVRfQUNUSVZBVEVfU0VDT05EQVJZX0NP
TlRST0xTKQ0KPiA+ICsJaWYgKF92bWV4aXRfY29udHJvbCAmIFZNX0VYSVRfQUNUSVZBVEVfU0VD
T05EQVJZX0NPTlRST0xTKSB7DQo+ID4gICAJCV9zZWNvbmRhcnlfdm1leGl0X2NvbnRyb2wgPQ0K
PiA+DQo+IAlhZGp1c3Rfdm14X2NvbnRyb2xzNjQoS1ZNX09QVElPTkFMX1ZNWF9TRUNPTkRBUllf
Vk1fRVhJVF9DTw0KPiBOVFJPTFMsDQo+ID4gICAJCQkJCSAgICAgIE1TUl9JQTMyX1ZNWF9FWElU
X0NUTFMyKTsNCj4gPiArCQlpZiAoY3B1X2ZlYXR1cmVfZW5hYmxlZChYODZfRkVBVFVSRV9GUkVE
KSAmJg0KPiA+ICsJCSAgICAhKF9zZWNvbmRhcnlfdm1leGl0X2NvbnRyb2wgJg0KPiBTRUNPTkRB
UllfVk1fRVhJVF9TQVZFX0lBMzJfRlJFRCAmJg0KPiA+ICsJCSAgICAgIF9zZWNvbmRhcnlfdm1l
eGl0X2NvbnRyb2wgJg0KPiBTRUNPTkRBUllfVk1fRVhJVF9MT0FEX0lBMzJfRlJFRCkpIHsNCj4g
DQo+IENhbiB0aG9zZSBjaGVja3MgYWN0dWFsbHkgdHJpZ2dlcj8gSS5lIGlmIEZFQVRVUkVfRlJF
RCBpcyBzZXQgaXQgbWVhbnMNCj4gdGhlIENQVSBpbXBsZW1lbnRzIHRoZSBGUkVEIHNwZWMuIEFj
Y29yZGluZyB0byB0aGUgc3BlYyBpdCdzIGd1YXJhbnRlZWQNCj4gdGhhdCBWTVhfRVhJVF9DVExT
MiB3aWxsIGNvbnRhaW4gdGhvc2UgYml0cyBzZXQgdG8gMS4gU28gYXJlbid0IHRob3NlDQo+IGNo
ZWNrcyBzdXBlcmZsdW91cz8NCg0KU3VjaCBjaGVja3MgYXJlIGZvciBuVk1YIEZSRUQuDQoNCj4g
PiArCWlmIChjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJFX0ZSRUQpICYmDQo+ID4gKwkg
ICAgIShfdm1lbnRyeV9jb250cm9sICYgVk1fRU5UUllfTE9BRF9JQTMyX0ZSRUQpKSB7DQo+IERJ
VFRPDQo+IA0KPiA8c25pcD4NCg==

