Return-Path: <linux-kselftest+bounces-922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD377FFF8A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 00:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2391C20CD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 23:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3B59548;
	Thu, 30 Nov 2023 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2dYBing"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D6BC;
	Thu, 30 Nov 2023 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701387475; x=1732923475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b1V9c2y0IIS/mk+amC9K6Q+50D/+pr2uMw6rvfAr1Y8=;
  b=A2dYBingaTsD5Hf4/TphW10CIT6fhy+rG5m3iPQEU9dHsR2CUwi94n8f
   DJQPA4JVosWwfFV+wWisNixiMv9CUXCRzIU80lvYN4ps6YfuR0zaUUpkn
   AwHoVLEFOu+eBm4UEfP1ANuibZAVz/xj6DjA24fKg2zZ37Ebk19/OT9FP
   hTSvR09EzsP4rXSXvAwpItzbWAbUmfyJICuRsEGcMFjXg+x340pBAX5DY
   G/I43KCcXKWqrdkzSdJbTrPHNWMA66BYRe5Av/eN5GJ5XM5yxcAVlmKpU
   mjssED3jAMAw3o6d9VIe3Mjug7rvW48Vn7f/dmPzzinTK9Yynwc62uK21
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="378436909"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="378436909"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 15:37:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798491323"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="798491323"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 15:37:51 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 15:37:50 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 15:37:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 15:37:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 15:37:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHd9HIFuBHun3WysVAIjuNe+R+Sdi7ZkRoXlfdedApoyqblunqqIzy7csDjYPbLN8+BtTCzulyAHuLEzMzMckkyh4A1BgU4xMbngnYALlW2CIPqHSObkrqZFe/UZLQ+3GyMvS+f5omf61TCaR3UMSOgB0rM4G/oMH8SwzXoGLwwyt468nfmKozz1EQkmMl/Cuci5A/Ao0ZRJErMH/aG7lnMIEH/k6EZ5Tcbss7lHEj2SjpwXXSkwUGWdKYt5e6v+be3Acl7mwaaKUeRsOrcKSg4h/sZ+5zpFXcg2I1/CJSLv03+Z3o78raxk9JHw2SCfA8wPiQf6PBfOjro2VS7S2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1V9c2y0IIS/mk+amC9K6Q+50D/+pr2uMw6rvfAr1Y8=;
 b=iCCSLF0d1xQ4/NocZIiATYiHY/G4l3mbZbXNDOQflqR3ebY6MjPRqFEuMhW/1T3dUw7uGzLXrPsZ36sgi7K2pLsVTkhaxe7jFYJEN3Di6WRT3NTsBg93/3BYKF6JANDzl35/vZdb8ZkYTo0oOet2S3xy4UF1+33XY4rTEAkYLQgom+Moc4SeaaSQf4VjRt86MCyN9Unw07MfmcA6DiFjCwU+9PvkJVHl/Nnagu4uB4XPn8astaeVbDr53BvsR+zjpilt0l/1cMiOg9kh7B1V//VZJxxhkCDIxXijD8kG3vihqM2+nGO7Bquw+dmMkORdJdBmL+A2/Cki1+5jMlGyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7490.namprd11.prod.outlook.com (2603:10b6:806:346::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 23:37:43 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 23:37:43 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "david@redhat.com" <david@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "juri.lelli@redhat.com"
	<juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Thread-Index: AQHaIimeXZat4pMFckubArvD9fInWbCTOscAgAAvhwCAAB3KgA==
Date: Thu, 30 Nov 2023 23:37:42 +0000
Message-ID: <881e1b6d89d61cef4e71c6be688635fc47bb2b8e.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <ZWjb6r0RWPo199pC@arm.com>
	 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
In-Reply-To: <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7490:EE_
x-ms-office365-filtering-correlation-id: eeac848d-1461-41bc-94b8-08dbf1fd5950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fAxSBGdyXIL3t/1/Y7nc2FtEN0BlV1fDA+ocMAm+GuIqEP7L6a2lPAlQ5hqU6yTj6i1tyk2s0Eb2XRnydYQx77St/aYB79wKjsX1Yi2JHhg+74YT0Wqo3HXTchqt44BFEUDZOoSTM03CYWBe3bxS7nLUjLwO+5XOCCSq5dbphxhezwHURu5I6Omlvp/K9MXI/pcHz46JT8YRY4dW9FXrPkWXMwEMITj4Tz5e8GuZEE79fx4K+rrG7r3daAcMLooXxEaj2MKSOaIS5dWKEFx0y6SlRjyzSC+1hJgQYevGQcYig6rof5hVZ648tGoed+GNbp2yH9q6VFX8Msn2hVhxZSchZAiDziFkdN1d5nEUUNfAZ4+1uLphpGhFs8sHFP549NVljfmnyKUnBhdkMVi8NZZxPNijdAjE9hPK0HjdSC0eHTHuc+ROT8Avqa8xrn51HK+TPcZwQ4F/NLGEsjrSxFJe88yrEpGgLXJt8p3Hf74VNo+UgXPuGe62VjARXjt7vhuwPpkf1iqaaaMQe1c+QY0b8s1gL08i0iVfGBv7vrPSRXifY9uj3L7kHKSobSP/GFSCYT7SBRCedKMTh60o335o/upoESJEdp4zLov6RzyZQdd8oAZ8lvLax5x8acz3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(122000001)(38100700002)(7406005)(7416002)(66899024)(5660300002)(4001150100001)(2906002)(36756003)(38070700009)(41300700001)(86362001)(71200400001)(54906003)(26005)(110136005)(76116006)(66556008)(91956017)(66946007)(66446008)(66476007)(64756008)(316002)(2616005)(83380400001)(6506007)(6512007)(6486002)(478600001)(8676002)(8936002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFo1dEQ3WEl2OHNpbTl5TzhuR05QWmN5bmJwQ1NPYnFSZzNmcFdtTDhuak9T?=
 =?utf-8?B?NmYwQ1BYeWF6T0JYZjhUR3dMRVhFcVA3a0VTUEs0bi8rQmJ2MzkvcHNSbTYr?=
 =?utf-8?B?ZnJwYkV5Nk95LzIyTElXUG5vRW9YK25FeE5kcE9tak9Nd2NsL0wxTU9iSER2?=
 =?utf-8?B?dk1zbExHMjBvbU12MFpsM1hHMTAzTGhwV25FSnl3OTdYYkxYU2FTRGhVN2Fk?=
 =?utf-8?B?ckV6SmlnbnVid3htM3h2ditkV3BvanJ4Uy9Bcnc5bmZVTmRUVWxTY3ZXUWVO?=
 =?utf-8?B?TU0yU1ZmSUszbTVZYXRFYjNwTXVQTHFNdkpkWUhoWVpHOCsxR3dLTFdRZTFM?=
 =?utf-8?B?YytmTGFBbG92T0d2RlJpUVdpT3M0SUJoUWIvcFlWUzRQQ2hPNVB1QVdMbE0x?=
 =?utf-8?B?ZWpFb1o0emhzVG9JZU5JSGpnaGpRWTFkQVhGRjlhWEZEWEhocmpib3ZOeDg4?=
 =?utf-8?B?cENVMkdnaUpoVklpYWs5bWRrYlpUSkVkZVk0eDhINFN6SlZTdmhJcGRYOUlo?=
 =?utf-8?B?VTViQ3pvWWFwMW15QUttNDZtelhEbkhmNFZDdnJGZS9RRHBTcGVvTWlVbGFx?=
 =?utf-8?B?UW10WmU2UnRxQVVxNHhMdFp1VUtNSmFNTjlOZ1dKOXRGZURvaWdjYWUzelNZ?=
 =?utf-8?B?bzF6S0tzOXUybjYwUldiMzV4VnRrUy9heE1halFQVDBQWmlqTFo3b3RkQkdh?=
 =?utf-8?B?dFFkeW9iVkU1UEpRYXA2ZDI1S1U0SmVvRFJSbFpUaTJwTk1xY1JPdGZwTjJE?=
 =?utf-8?B?eWJNVkJRRXpEeFA3WFZoR0tLR0lUYmk4aEtaN0JkQ2g0ejRsRjBJenhGcWYx?=
 =?utf-8?B?blhQd2NmenQ3Vm1LeERVL0Fxc2I5cmt0K1pvZUhMYzlzQlMrdHhta1gybkpT?=
 =?utf-8?B?VnRJTmhBOXU5WGlmWkp4aEZIQVFTc0pmRXNlUXpQTUhEa3UraEJZT0ZyeVcv?=
 =?utf-8?B?NGhIazZ4Z244RS9PeG50enpNNS9tYXVGYmEreklrVWZWbGpQekxEZU1RcDNM?=
 =?utf-8?B?TEd5Uzc3YWcwd0lYaG9jODRid01lZUdGdnlyV3MxZ0tOYXNuZTB5TnBOWWlH?=
 =?utf-8?B?RG5aakEvV2NOR290dklpN3RVaWFkZFBIWitIdHA1SEMxSEt1L3UrUlZieWh4?=
 =?utf-8?B?MnAvSmZIWnVMV28vM0txRElWNVRYSExaTEtSc2xQNU8wWUgvb1FaeUk1Ulc1?=
 =?utf-8?B?V0JCb1FvdnFBLzQvanFuaEZaSWVOeXJnYWovWG5ybVVWMElqODVYTHRCRVBq?=
 =?utf-8?B?di9aREVWUkdOYVZmVHdYUE9HUXd0M0RkbzBmYkFoM3FKOUpoa3FLWFo3ZXUx?=
 =?utf-8?B?RlZrR2NBVjlvVnlTYnJWLzU0VnFOLys5QlRyUEtoa1p6QVJ4SjV5VFUxaUVF?=
 =?utf-8?B?dndLR0VnNzJJZ2VjR2NPOVhFKzdpMzB6TnNXbWFlVDM3TEJxRk4xQzN2bXR5?=
 =?utf-8?B?ckxCSi9LMWVyWS9mQmd0aVFHb21EUXhxTGVTSlVrTmJBTUo3K0YzdTdkcDFN?=
 =?utf-8?B?MWNBa2MxTVNZTW83VWNCellnNkl5MU1qcGluY1ZWQ0c5QkFjK0FKQkJnR0NW?=
 =?utf-8?B?OVZwd0NyNitDK3pJOWd1SmlKUG9XUUJKTTNBamNLVmhNcXU5WFN0RnNKSDVD?=
 =?utf-8?B?VHNEYkk1eWhLNC8rQjlZcHlNY090bFZZaFJZR3VMUDc0b0tqeVNJWXpPS3Y2?=
 =?utf-8?B?M3pvbm40SmFtODc1M2l1RWlvWDlZRUtTTlpUWEtCTGtmTnJsRTNqOWdNRUFi?=
 =?utf-8?B?OG9EaFBHdjJoNkZrbitVdWdQbmhSUWpHU0orc2hkREFNR2phb044K0hFSDhz?=
 =?utf-8?B?V293c1VCRjV6b3E1dk82UjI5N0tucno2b0FPVGNtOVFCOHo0eHVTRVM5MDlp?=
 =?utf-8?B?ZUNpRmZ4RmRjSFBOcnNkTXZpOE95THZCQkVlSWh0L2pjZkowbWRFUlhUTEw4?=
 =?utf-8?B?UVpIRlRqZ3YzYmxMVTZyclpHVy9GTWxiSlI2YXpmNHc4bnhZNExZV2JSN3pO?=
 =?utf-8?B?c25YSWxHbXZaSDJiY1dXK1gxMm1rYVBNKzBXN2dGSjcyVU5tK08yN0xaaXph?=
 =?utf-8?B?L3dWd25ZcmpXYjVDc09kR2NYemhIY1oyd0FTZXZQRDNKb2pXL1FCSkppRHUz?=
 =?utf-8?B?Q3RDL0lzUjZZYytETFdSM1BEZksybWdEK0FzelFtbXFGUWRDM2RVVUhqNmRq?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <918696016D4A4D4BBD4C03F883A1DF0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeac848d-1461-41bc-94b8-08dbf1fd5950
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 23:37:43.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feBqDwnNikqAZuiru31hMVuZdVuM3AGNt9pmTf2Rh5D4IViFI99FVeJArvpan7TGqo6PrhtNhk5Vo3hJbxxc5K1rgDszyMAlxkF67RtdhPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7490
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTMwIGF0IDIxOjUxICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIE5vdiAzMCwgMjAyMyBhdCAwNzowMDo1OFBNICswMDAwLCBDYXRhbGluIE1hcmluYXMg
d3JvdGU6DQo+IA0KPiA+IE15IGhvcGUgd2hlbiBsb29raW5nIGF0IHRoZSBhcm02NCBwYXRjaGVz
IHdhcyB0aGF0IHdlIGNhbg0KPiA+IGNvbXBsZXRlbHkNCj4gPiBhdm9pZCB0aGUga2VybmVsIGFs
bG9jYXRpb24vZGVhbGxvY2F0aW9uIG9mIHRoZSBzaGFkb3cgc3RhY2sgc2luY2UNCj4gPiBpdA0K
PiA+IGRvZXNuJ3QgbmVlZCB0byBkbyB0aGlzIGZvciB0aGUgbm9ybWFsIHN0YWNrIGVpdGhlci4g
Q291bGQgc29tZW9uZQ0KPiA+IHBsZWFzZSBzdW1tYXJpc2Ugd2h5IHdlIGRyb3BwZWQgdGhlIHNo
YWRvdyBzdGFjayBwb2ludGVyIGFmdGVyIHYxPw0KPiA+IElJVUMNCj4gPiB0aGVyZSB3YXMgYSBw
b3RlbnRpYWwgc2VjdXJpdHkgYXJndW1lbnQgYnV0IEkgZG9uJ3QgdGhpbmsgaXQgd2FzIGENCj4g
PiB2ZXJ5DQo+ID4gc3Ryb25nIG9uZS4gQWxzbyB3aGF0J3MgdGhlIHRocmVhdCBtb2RlbCBmb3Ig
dGhpcyBmZWF0dXJlPyBJDQo+ID4gdGhvdWdodA0KPiA+IGl0J3MgbWFpbmx5IG1pdGlnYXRpbmcg
c3RhY2sgY29ycnVwdGlvbi4gSWYgc29tZSByb2d1ZSBjb2RlIGNhbiBkbw0KPiA+IHN5c2NhbGxz
LCB3ZSBoYXZlIGJpZ2dlciBwcm9ibGVtcyB0aGFuIGNsb25lMygpIHRha2luZyBhIHNoYWRvdw0K
PiA+IHN0YWNrDQo+ID4gcG9pbnRlci4NCj4gDQo+IEFzIHdlbGwgYXMgcHJldmVudGluZy9kZXRl
Y3RpbmcgY29ycnVwdGlvbiBvZiB0aGUgaW4gbWVtb3J5IHN0YWNrDQo+IHNoYWRvdw0KPiBzdGFj
a3MgYXJlIGFsc28gZW5zdXJpbmcgdGhhdCBhbnkgcmV0dXJuIGluc3RydWN0aW9ucyBhcmUgdW53
aW5kaW5nIGENCj4gcHJpb3IgY2FsbCBpbnN0cnVjdGlvbiwgYW5kIHRoYXQgdGhlIHJldHVybnMg
YXJlIGRvbmUgaW4gb3Bwb3NpdGUNCj4gb3JkZXINCj4gdG8gdGhlIGNhbGxzLsKgIFRoaXMgZm9y
Y2VzIHVzYWdlIG9mIHRoZSBzdGFjayAtIGFueSB2YWx1ZSB3ZSBhdHRlbXB0DQo+IHRvDQo+IFJF
VCB0byBpcyBnb2luZyB0byBiZSBjaGVja2VkIGFnYWluc3QgdGhlIHRvcCBvZiB0aGUgc2hhZG93
IHN0YWNrDQo+IHdoaWNoDQo+IG1ha2VzIGNoYWluaW5nIHJldHVybnMgdG9nZXRoZXIgYXMgYSBz
dWJzdGl0dXRlIGZvciBicmFuY2hlcyBoYXJkZXIuDQo+IA0KPiBUaGUgY29uY2VybiBSaWNrIHJh
aXNlZCB3YXMgdGhhdCBhbGxvd2luZyB1c2VyIHRvIHBpY2sgdGhlIGV4YWN0DQo+IHNoYWRvdw0K
PiBzdGFjayBwb2ludGVyIHdvdWxkIGFsbG93IHVzZXJzcGFjZSB0byBjb3JydXB0IG9yIHJldXNl
IHRoZSBzdGFjayBvZg0KPiBhbg0KPiBleGlzdGluZyB0aHJlYWQgYnkgc3RhcnRpbmcgYSBuZXcg
dGhyZWFkIHdpdGggdGhlIHNoYWRvdyBzdGFjaw0KPiBwb2ludGluZw0KPiBpbnRvIHRoZSBleGlz
dGluZyBzaGFkb3cgc3RhY2sgb2YgdGhhdCB0aHJlYWQuwqAgV2hpbGUgaW4gaXNvbGF0aW9uDQo+
IHRoYXQncyBub3QgdG9vIG11Y2ggbW9yZSB0aGFuIHdoYXQgdXNlcnNwYWNlIGNvdWxkIGp1c3Qg
ZG8gZGlyZWN0bHkNCj4gYW55d2F5IGl0IG1pZ2h0IGNvbXBvc2Ugd2l0aCBvdGhlciBpc3N1ZXMg
dG8gc29tZXRoaW5nIG1vcmUNCj4gImludGVyZXN0aW5nIg0KPiAoZWcsIEknZCBiZSBhIGJpdCBj
b25jZXJuZWQgYWJvdXQgb3ZlcmxhcCB3aXRoIHBrZXlzL1BPRSB0aG91Z2ggSSd2ZQ0KPiBub3QN
Cj4gdGhvdWdodCB0aHJvdWdoIHBvdGVudGlhbCB1c2VzIGluIGRldGFpbCkuDQoNCkkgdGhpbmsg
aXQgaXMgb3BlbiBmb3IgdXNlcnNwYWNlIGN1c3RvbWl6YXRpb24uIFRoZSBrZXJuZWwgdHJpZXMg
dG8NCmxlYXZlIHRoZSBvcHRpb24gdG8gbG9jayB0aGluZ3MgZG93biBhcyBtdWNoIGFzIGl0IGNh
biAocGFydGx5IGJlY2F1c2UNCml0J3Mgbm90IGNsZWFyIGhvdyBhbGwgdGhlIHVzZXJzcGFjZSB0
cmFkZW9mZnMgd2lsbCBzaGFrZSBvdXQpLg0KDQpJbiB0aGUgcGFzdCwgd2UgaGFkIHRhbGtlZCBh
Ym91dCBhbGxvd2luZyBhIHNldCBTU1AgKEdDU1BSKSBwcmN0bCgpIHRvDQpoZWxwIHdpdGggc29t
ZSBvZiB0aGUgY29tcGF0aWJpbGl0eSBnYXBzIChsb25nam1wKCkgYmV0d2VlbiBzdGFja3MsDQpl
dGMpLiBJZiB3ZSBsb29zZW5lZCB0aGluZ3MgdXAgYSBiaXQgdGhpcyBjb3VsZCBoZWxwIHRoZXJl
LCBidXQgaXQga2luZA0Kb2YgZGVmZWF0cyB0aGUgcHVycG9zZSBhIGxpdHRsZSwgb2YgdGhlIHRv
a2VuIGNoZWNraW5nIHN0dWZmIGJ1aWx0IGludG8NCnRoZXNlIGZlYXR1cmVzIGF0IHRoZSBIVyBs
ZXZlbC4gQSBzdXBlci1zdGFjay1jYW5hcnkgbW9kZSBtaWdodCBiZSBuaWNlDQpmb3IgcGVvcGxl
IHdobyBqdXN0IHdhbnQgdG8gZmxpcCBhIHN3aXRjaCBvbiBleGlzdGluZyBhcHBzIHdpdGhvdXQN
CmNoZWNraW5nIHRoZW0sIG9yIHBlb3BsZSB3aG8gd2FudCB0byBkbyB0cmFjaW5nIGFuZCBkb24n
dCBjYXJlIGFib3V0DQpzZWN1cml0eS4gQnV0LCBJIGFsc28gd291bGRuJ3QgYmUgc3VycHJpc2Vk
IGlmIHNvbWUgaGlnaCBzZWN1cml0eQ0KYXBwbGljYXRpb25zIGRlY2lkZSB0byBibG9jayBtYXBf
c2hhZG93X3N0YWNrIGFsbCB0b2dldGhlciB0byBsb2NrDQp0aHJlYWRzIHRvIHRoZWlyIG93biBz
aGFkb3cgc3RhY2tzLg0KDQpTbyBJIGtpbmQgb2YgbGlrZSBsZWFuaW5nIHRvd2FyZHMgbGVhdmlu
ZyB0aGUgb3B0aW9uIHRvIGxvY2sgdGhpbmdzDQpkb3duIG1vcmUgd2hlbiB3ZSBjYW4uIExpa2Ug
TWFyayB3YXMgZ2V0dGluZyBhdCwgd2UgZG9uJ3Qga25vdyBhbGwgdGhlDQp3YXlzIHNoYWRvdyBz
dGFja3Mgd2lsbCBnZXQgYXR0YWNrZWQgeWV0LiBTbyB0dXJuaW5nIGl0IGFyb3VuZCwgd2h5IG5v
dA0KbGV0IHRoZSBzaGFkb3cgc3RhY2sgZ2V0IGFsbG9jYXRlZCBieSB0aGUga2VybmVsPyBJdCBt
YWtlcyB0aGUga2VybmVsDQpjb2RlL2NvbXBsZXhpdHkgc21hbGxlciwgYXJlIHRoZXJlIGFueSBv
dGhlciBiZW5lZml0cz8NCg0KPiANCj4gPiBJJ20gbm90IGFnYWluc3QgY2xvbmUzKCkgZ2V0dGlu
ZyBhIHNoYWRvd19zdGFja19zaXplIGFyZ3VtZW50IGJ1dA0KPiA+IGFza2luZw0KPiA+IHNvbWUg
bW9yZSBxdWVzdGlvbnMuIElmIHdlIHdvbid0IHBhc3MgYSBwb2ludGVyIGFzIHdlbGwsIGlzIHRo
ZXJlDQo+ID4gYW55DQo+ID4gYWR2YW50YWdlIGluIGV4cGFuZGluZyB0aGlzIHN5c2NhbGwgdnMg
YSBzcGVjaWZpYyBwcmN0bCgpIG9wdGlvbj8NCj4gPiBEbyB3ZQ0KPiA+IG5lZWQgYSBkaWZmZXJl
bnQgc2l6ZSBwZXIgdGhyZWFkIG9yIGRvIGFsbCB0aHJlYWRzIGhhdmUgdGhlIHNhbWUNCj4gPiBz
aGFkb3cNCj4gPiBzdGFjayBzaXplPyBBIG5ldyBSTElNSVQgZG9lc24ndCBzZWVtIHRvIG1hcCB3
ZWxsIHRob3VnaCwgaXQgaXMNCj4gPiBtb3JlDQo+ID4gbGlrZSBhbiB1cHBlciBsaW1pdCByYXRo
ZXIgdGhhbiBhIGZpeGVkL2RlZmF1bHQgc2l6ZSAoZ2xpYmMgSSB0aGluaw0KPiA+IHVzZXMNCj4g
PiBpdCBmb3IgdGhyZWFkIHN0YWNrcyBidXQgYmlvbmljIG9yIG11c2wgZG9uJ3QgQUZBSUspLg0K
PiANCj4gSSBkb24ndCBrbm93IHdoYXQgdGhlIHVzZXJzcGFjZSBwYXR0ZXJucyBhcmUgbGlrZWx5
IHRvIGJlIGhlcmUsIGl0J3MNCj4gcG9zc2libGUgYSBzaW5nbGUgdmFsdWUgZm9yIGVhY2ggcHJv
Y2VzcyBtaWdodCBiZSBmaW5lIGJ1dCBJIGNvdWxkbid0DQo+IHNheSB0aGF0IGNvbmZpZGVudGx5
LsKgIEkgYWdyZWUgdGhhdCBhIFJMSU1JVCBkb2VzIHNlZW0gbGlrZSBhIHBvb3INCj4gZml0Lg0K
PiANCj4gQXMgd2VsbCBhcyB0aGUgYWN0dWFsIGNvbmZpZ3VyYXRpb24gb2YgdGhlIHNpemUgdGhl
IG90aGVyIHRoaW5nIHRoYXQNCj4gd2UNCj4gZ2FpbiBpcyB0aGF0IGFzIHdlbGwgYXMgcmVseWlu
ZyBvbiBoZXVyaXN0aWNzIHRvIGRldGVybWluZSBpZiB3ZSBuZWVkDQo+IHRvDQo+IGFsbG9jYXRl
IGEgbmV3IHNoYWRvdyBzdGFjayBmb3IgdGhlIG5ldyB0aHJlYWQgd2UgYWxsb3cgdXNlcnNwYWNl
IHRvDQo+IGV4cGxpY2l0bHkgcmVxdWVzdCBhIG5ldyBzaGFkb3cgc3RhY2suwqAgVGhlcmUgd2Fz
IHNvbWUgY29ybmVyIGNhc2UNCj4gd2l0aA0KPiBJSVJDIHBvc2l4X25zcGF3bigpIG1lbnRpb25l
ZCB3aGVyZSB0aGUgaGV1cmlzdGljcyBhcmVuJ3Qgd2hhdCB3ZQ0KPiB3YW50DQo+IGZvciBleGFt
cGxlLg0KDQpDYW4ndCBwb3NpeF9zcGF3bigpIHBhc3MgaW4gYSBzaGFkb3cgc3RhY2sgc2l6ZSBp
bnRvIGNsb25lMyB0byBnZXQgYQ0KbmV3IHNoYWRvdyBzdGFjayBhZnRlciB0aGlzIHNlcmllcz8N
Cg0KPiANCj4gPiBBbm90aGVyIGR1bWIgcXVlc3Rpb24gb24gYXJtNjQgLSBpcyBHQ1NQUl9FTDAg
d3JpdGVhYmxlIGJ5IHRoZQ0KPiA+IHVzZXI/IElmDQo+ID4geWVzLCBjYW4gdGhlIGxpYmMgd3Jh
cHBlciBmb3IgdGhyZWFkcyBhbGxvY2F0ZSBhIHNoYWRvdyBzdGFjayB2aWENCj4gPiBtYXBfc2hh
ZG93X3N0YWNrKCkgYW5kIHNldCBpdCB1cCBpbiB0aGUgdGhyZWFkIGluaXRpYWxpc2F0aW9uDQo+
ID4gaGFuZGxlcg0KPiA+IGJlZm9yZSBpbnZva2luZyB0aGUgdGhyZWFkIGZ1bmN0aW9uPw0KPiAN
Cj4gTm8sIEdDU1BSX0VMMCBjYW4gb25seSBiZSBjaGFuZ2VkIGJ5IEVMMCB0aHJvdWdoIEJMLCBS
RVQgYW5kIHRoZQ0KPiBuZXcgR0NTIGluc3RydWN0aW9ucyAocHVzaC9wb3AgYW5kIHN0YWNrIHN3
aXRjaCkuwqAgUHVzaCBpcyBvcHRpb25hbCAtDQo+IHVzZXJzcGFjZSBoYXMgdG8gZXhwbGljaXRs
eSByZXF1ZXN0IHRoYXQgaXQgYmUgZW5hYmxlZCBhbmQgdGhpcyBjb3VsZA0KPiBiZQ0KPiBwcmV2
ZW50ZWQgdGhyb3VnaCBzZWNjb21wIG9yIHNvbWUgb3RoZXIgTFNNLsKgIFRoZSBzdGFjayBzd2l0
Y2gNCj4gaW5zdHJ1Y3Rpb25zIHJlcXVpcmUgYSB0b2tlbiBhdCB0aGUgZGVzdGluYXRpb24gYWRk
cmVzcyB3aGljaCBtdXN0DQo+IGVpdGhlciBiZSB3cml0dGVuIGJ5IGEgaGlnaGVyIEVMIG9yIHdp
bGwgYmUgd3JpdHRlbiBpbiB0aGUgcHJvY2VzcyBvZg0KPiBzd2l0Y2hpbmcgYXdheSBmcm9tIGEg
c3RhY2sgc28geW91IGNhbiBzd2l0Y2ggYmFjay7CoCBVbmxlc3MgSSd2ZQ0KPiBtaXNzZWQNCj4g
b25lIGV2ZXJ5IG1lY2hhbmlzbSBmb3IgdXNlcnNwYWNlIHRvIHVwZGF0ZSBHQ1NQUl9FTDAgd2ls
bCBkbyBhIEdDUw0KPiBtZW1vcnkgYWNjZXNzIHNvIHByb3ZpZGluZyBndWFyZCBwYWdlcyBoYXZl
IGJlZW4gYWxsb2NhdGVkIHdyYXBwaW5nDQo+IHRvIGENCj4gZGlmZmVyZW50IHN0YWNrIHdpbGwg
YmUgcHJldmVudGVkLg0KPiANCj4gV2Ugd291bGQgbmVlZCBhIHN5c2NhbGwgdG8gYWxsb3cgR0NT
UFJfRUwwIHRvIGJlIHdyaXR0ZW4uDQoNCkkgdGhpbmsgdGhlIHByb2JsZW0gd2l0aCBkb2luZyB0
aGlzIGlzIHNpZ25hbHMuIElmIGEgc2lnbmFsIGlzDQpkZWxpdmVyZWQgdG8gdGhlIG5ldyB0aHJl
YWQsIHRoZW4gaXQgY291bGQgcHVzaCB0byB0aGUgb2xkIHNoYWRvdyBzdGFjaw0KYmVmb3JlIHVz
ZXJzcGFjZSBnZXRzIGEgY2hhbmNlIHRvIHN3aXRjaC4gU28gdGhlIHRocmVhZCBuZWVkcyB0byBz
dGFydA0Kb24gYSBuZXcgc2hhZG93L3N0YWNrLg0KDQo=

