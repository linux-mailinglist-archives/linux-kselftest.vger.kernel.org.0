Return-Path: <linux-kselftest+bounces-1217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D86EC8061BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 23:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159231C20FB1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC46E2C3;
	Tue,  5 Dec 2023 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S3+FJojX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE41181;
	Tue,  5 Dec 2023 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701815473; x=1733351473;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=de/eg9jkqXgxR0O6Vdvz2KUTqIOXpzw7exlAS5qelmE=;
  b=S3+FJojXTnJQgEu0+wRDvFVZjLiM6Ia752YnQFvMxMV0DGajVI+mbf9o
   /5OvKHxRyprKpIRScffQyf3aDter22M1Mi1f1A0azgQVhBZgRVA8XsQ9c
   Je5HynxmItIb9vIXbAJd+QqW/P/jcERVST/t9o0KpgnLkm00+3U7/b9iS
   sMGZSQz+r3UR9Nr2BEEPreoAHB8fUuUVknNqaZhiOsWl8fcDiGLaSMGcO
   xxOF+MUn1I7zFe31wr/nVloQvj8OkMQzgtJRFGygPWHNXM7wDomCBv7vU
   vfto/ogiADXQ88Jt0ttPtmawx9vAi3hTPkcdvccfqe6BUPe/FhU6RNWd9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="480168259"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="480168259"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:31:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="12480543"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 14:31:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 14:31:12 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 14:31:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 14:31:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 14:31:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYDnx6lQOjVNZa5Od7cfKQRiZ1AGWJewVCNz4ZkaXOVehCkctXipAUF+itWnExvX6+exNucyA21KYjUyuLgSYCwiNR0YfWuJeQETbkBdOTcFoewftAP8CcUOSoKjkSzB/EKz55x5MJeCMjjQPZJvjpkljlZ7E8QmO/yreHgPQTjZ3LlX4HpgZ/uV0oPD8Acc8l5XSxgBb+BmQYjQGLxs+eeIyf5ISIVmWm+CQpy5j4YY8rSbF/mLwHazbHzgJlPY2WVXHIAodoxweme1jsptNYbnRy8WHU8bE4gOpqPcom8mHsE22pyuGyVLTAIpkvhFHlJnVhQnx8iJPzJOB0biIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de/eg9jkqXgxR0O6Vdvz2KUTqIOXpzw7exlAS5qelmE=;
 b=oYK1S6/8Bb5DHaOY2Ia0qCikVYLBSCUZT+NABCyvQPrh+woR5Bf4XR6dOgE8nVpJmgkOEsckinTLyj5EQOcLbeVxe4EdfHFKmwfyWqaYNIuGkankP3wB2h93AV4w94un1vY1WYl8uUs1mR//TzkJ4yTkwyyKlq/MRFkUuBsgCFm7tSGr74k6WXe/c52HKE7kbLHtUmoW4/VvU6yiG1DK9xzk3ufFjpCYHaPEDjM2xqaVuaqmIfLr+/YYJglTw5uBPzmnIKHAf2XdhEPMvqg5JW+HI7WUwLvdZETva15EmaTEzTAGHxujNjyNIl/vFv3tlZard1RWw+x9cJXeCkxLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN2PR11MB4680.namprd11.prod.outlook.com (2603:10b6:208:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 22:31:10 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 22:31:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Topic: [PATCH RFT v4 5/5] kselftest/clone3: Test shadow stack support
Thread-Index: AQHaIim3AA2TizYED0GkvO+BE9w2Y7CZ2omAgAD6IwCAAA+1gIAAC7OAgABhFYA=
Date: Tue, 5 Dec 2023 22:31:09 +0000
Message-ID: <127bba3063b19dd87ae3014f6d3bba342f7a16fb.camel@intel.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
	 <20231128-clone3-shadow-stack-v4-5-8b28ffe4f676@kernel.org>
	 <4898975452179af46f38daa6979b32ba94001419.camel@intel.com>
	 <345cf31a-3663-4974-9b2a-54d2433e64a7@sirena.org.uk>
	 <a6bf192a1568620826dd79124511ea61472873c8.camel@intel.com>
	 <098f5d43-e093-4316-9b86-80833c2b94ec@sirena.org.uk>
In-Reply-To: <098f5d43-e093-4316-9b86-80833c2b94ec@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN2PR11MB4680:EE_
x-ms-office365-filtering-correlation-id: 75e730c2-fd9a-4870-bfad-08dbf5e1e149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4h0zTCaoKzAMjSii7loEk0Ydf8/09gvvk/MEACTfXTxafti57DaKszko+SODPEB+kLvkIuAU2knTsUQ8pREG+mML7/1tGsegtYyMVgL+sBmRcUuK3Co9idGJtIboqnchwCTwmIG2Ut5C9sJCIk5EGg0TyDw31zfv+WlCms2Dc1BH5cZsw0aZ1lnBjwwfTKvA4uBONpJ3lR4BM00emBgI7nC3WNlRnrBUaAlkqLd7E1HfeQAdHidDmtK+763r7asqbI5+fplF1/MeHVfS7nF45w7ZEGkZQLAd14auX2kEqunxcb8ANSBgkSKxEdl01FH90w5+mQdUYETpT5FdJHXVivf0ensDKmUhG8I0XlNBkuCNHB7isUYom2HGXQI+zKB0Umlx+gAyLwY3fIj2m1jqRpZaZaB+I+3i1Y12LISAAoMqUtAhg1ppSDQ9eYOd1YrNq1GUEdu378xGZzd3A20C5wd+a89arA+bfUH1wtJmO0ev1pFswBN0nTbMXoqQ/WjN4tp+CnMulOn4qWoYecjPrb+jSZ8NOT+A3tVLZUIo/ZWNdMXX0Z4U+SDPHiPul7ZrugIW8dNTd4d2ixSTbvI42khaSN37dJ3g+n4rwcX+RRJ0klTv4XjexyVLPI2KXCt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38070700009)(6506007)(478600001)(8676002)(6486002)(2616005)(122000001)(71200400001)(26005)(66446008)(64756008)(4326008)(54906003)(91956017)(66476007)(66556008)(66946007)(76116006)(6916009)(8936002)(316002)(38100700002)(7416002)(6512007)(41300700001)(82960400001)(36756003)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZThReWx6ZUpVUXl5UktubmZTRStFdlBMYnhURlBHT1l0YUNoZnlJZFc4SW5v?=
 =?utf-8?B?R2c1d3VBcnVQeklUdTZlNW1oUnl5cStFRkZKYzBkVGduZUxHTDFGcU5FZnJ5?=
 =?utf-8?B?dU5NdTRzNFBEZ0RnMVpOL0t1Sk9iWE1vTnZuM0tRS2xLeGpDQUc3Vzc1bkg3?=
 =?utf-8?B?WnZEa2xwMk02TUpseGcwY1MrN3ZDdkhFcFBWdU9JbFkrcy9JSFJnTnFwSDZu?=
 =?utf-8?B?ZHloY3VwOFN4VXByY0x4WHo3UWVKcDRJeHVIS2pZdTk5eFczbmlrUWxNK2Zi?=
 =?utf-8?B?RSsrY3VpYno5VWJBWHhQdnBEcWltSDFwWUR2YkNhcGdLWWU5ZFNkMWFnUzJl?=
 =?utf-8?B?RWQ0MVM2a21ycGdhM21ZaXJ0bG80Q2lUakhJdjMrNE5IdkNnRmtVRHloUW9r?=
 =?utf-8?B?eUhwYllwMmVMVytsMVhVQlFSczdwQURIbjIzWGN4dnhmM29mNzJmS0xGRlEx?=
 =?utf-8?B?VVNxaTNFaURpMnRSelc4WEZsaDBWT3B5Y3BERW81a0YxTnkvMm5rZHVzTU1p?=
 =?utf-8?B?WDlWcjFET0gzbWI2eUNybURCdVIxeWhqamJiZTV4c05reTlWZjhhZDJsQy8y?=
 =?utf-8?B?d3FJbWtPN0pieG51V05IN0R0MTk1U0x3WE1LSlpvZytYRFY5VVVQcDNGU3Vm?=
 =?utf-8?B?OFN1cm5GOGNncUZoRkEwZ2kzM1FYWkl5dFF6cTZIVC9BU2loV05NQS9uRnYv?=
 =?utf-8?B?UTNsMmVZYW92SFlNYjYva1VIaUlYekdUSUlzajdaeG9lcU5hWGZlYTcyTCtS?=
 =?utf-8?B?a0RBdllCNy8yZ0RUNmdvN0IyYmx1YlJQaVhMSlBTZjNSTmdlbHJjNGxmNFdt?=
 =?utf-8?B?RkhwSU9BRlRaSVpzN09SNlVCaE5FNDNuVUw5bHY0bXNpYTcxVlJZMjlKRm8r?=
 =?utf-8?B?OXlqYnJ1T1lGS0tQQSt1QlZscjNKMzNmdlVUYlJMSjVvbHZISjh5NW4xYS90?=
 =?utf-8?B?T3dhUDYrMUx2TE1PZkx3Nnd2OEpyMXFndloxRk9lQ2QvUnNSNHgweXR5czhs?=
 =?utf-8?B?eHUweXIxRHNuNmdTSHY1WDNHK0oxNVcrajcweEV0b3RNOTlxeS9mbWNWd1pa?=
 =?utf-8?B?WXZZTWNNd2cwajZpaFd3d2wrd0ZOWXM1NHI3MWJBTXIzSXpxRWlTeVhjbWUx?=
 =?utf-8?B?YXk5eEMxWVZlWFM4QTNadlIyM2pxUVlINlRCT01YZG1hRVpNWDY1eFJiMUNT?=
 =?utf-8?B?VTRaUnExaTZodTlQL290RlhvQ0pkTGJ6b3dnam5VYWpYK21JTnNLUjJzRm5W?=
 =?utf-8?B?QUNVYnk4UW4weWhmV1pobEtWRit3S051dE5Uc3NUcTVjang5YUFMc1lBdklP?=
 =?utf-8?B?ZzdCbTJlWi9qdEt1bXY2em9yWGtCTVRxc3VoOEEzUE1YNGdQM1VLbHZTcWN3?=
 =?utf-8?B?eFdXTlZiLzhFbE9Ia3NVZGlaM0tub1BQTE9QTytJOVpnQ282S2ZDT1RrbzBN?=
 =?utf-8?B?a3cydlMvdTNvbFFidWJFVGNTbUhGZEgyYXB3WUp1dWRtNTNoSU1xOFlZWHcy?=
 =?utf-8?B?WDFFWHBCOUUwSlRIdDN4amFwdVhuRU8xVUk0R3JKZDdseXNJSjZaWmRPQnJR?=
 =?utf-8?B?TTE2R2tEMkIzTlZTWFRqcE5KTStOYUp3VGROeC9vRzRJY0J0OStUMmVzR01X?=
 =?utf-8?B?SmI2aVgyY2g2QVc0MkMyamYzbysxMlZKVXIvUkVQMGpzWlRhZnEvWTMyTVkw?=
 =?utf-8?B?RzY1bzdZTXY5cXJ3ZEJrTWpPeU82NUZ1OUFVQnVVbDZIaGpaWUh3OW1TQkJy?=
 =?utf-8?B?ZG5zSVBkNWdoa2RqYkc4K0k2ZU1sS2pwRm40TjZhN0g5YkdFb0FsRC9LdW9n?=
 =?utf-8?B?NTdrRHJuanNoUFNQOXRicWQrVDladnNiMmVvTnJKQVd0anNqSzI1QlJteDZs?=
 =?utf-8?B?N05ROTRaM0VyaG1JaWJWT2xlWVFkN0xGNzJMNkFGYWZuSlhLUXdZTXd5OExV?=
 =?utf-8?B?M1Z3V1NCWFFhSlppZllyQ0pSRDN6aW9GSXZ3NjZLbDVYYkdoSjAxWDVaTVZt?=
 =?utf-8?B?LzlFUElxQXBRTTA0QzVmOEcwcm96UjMrTEtHdTdXRXVIMDdNT09SdTN4Z2hn?=
 =?utf-8?B?NXI0RisyYTFZZFlVOG42VWphaUluYm1KV2IreUJtOXJhWXlkUXc4NENSN0xt?=
 =?utf-8?B?TGo0RGtRZHJEcVVtMmVqVTQ3QmpuSTV2QzlDSS9LZk5uMm9qdWYrUk1CSnVl?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFA168FDE4BF9642909831A5179D969D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e730c2-fd9a-4870-bfad-08dbf5e1e149
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 22:31:09.8667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8W/xCtx0mHB7YNsTU13rVFH8QFCpw3K3fJRpqP/Oaev/h/9ypNRQMQKIpRKBL45s/rAqP5ZOyY7kj2qT0HcUjUslObSTSL152eDXkIUAQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4680
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTEyLTA1IGF0IDE2OjQzICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBS
aWdodCwgaXQncyBhIHNtYWxsIGFuZCBmYWlybHkgZWFzaWx5IGF1ZGl0YWJsZSBsaXN0IC0gaXQn
cyBtb3JlDQo+IGFib3V0DQo+IHRoZSBhcHAgdGhhbiB0aGUgZG91YmxlIGVuYWJsZSB3aGljaCB3
YXMgd2hhdCBJIHRob3VnaHQgeW91ciBjb25jZXJuDQo+IHdhcy7CoCBJdCdzIGEgYml0IGFubm95
aW5nIGRlZmluaXRlbHkgYW5kIG5vdCBzb21ldGhpbmcgd2Ugd2FudCB0byBkbw0KPiBpbg0KPiBn
ZW5lcmFsIGJ1dCBmb3Igc29tZXRoaW5nIGxpa2UgdGhpcyB3aGVyZSB3ZSdyZSBhZGRpbmcgc3Bl
Y2lmaWMNCj4gY292ZXJhZ2UNCj4gZm9yIEFQSSBleHRlbnNpb25zIGZvciB0aGUgZmVhdHVyZSBp
dCBzZWVtcyBsaWtlIGEgcmVhc29uYWJsZQ0KPiB0cmFkZW9mZi4NCj4gDQo+IElmIHRoZSB4ODYg
dG9vbGNoYWluL2xpYmMgc3VwcG9ydCBpcyB3aWRlbHkgZW5vdWdoIGRlcGxveWVkIChvciB5b3UN
Cj4ganVzdA0KPiBkb24ndCBtaW5kIGFueSBtaXNzaW5nIGNvdmVyYWdlKSB3ZSBjb3VsZCB1c2Ug
dGhlIHRvb2xjaGFpbiBzdXBwb3J0DQo+IHRoZXJlIGFuZCBvbmx5IGhhdmUgdGhlIG1hbnVhbCBl
bmFibGUgZm9yIGFybTY0LCBpdCdkIGJlIGluY29uc2lzdGVudA0KPiBidXQgbm90IHdpbGRseSBz
by4NCj4gDQo+IA0KPiANCkknbSBob3BpbmcgdGhlcmUgaXMgbm90IHRvbyBtdWNoIG9mIGEgZ2Fw
IGJlZm9yZSB0aGUgZ2xpYmMgc3VwcG9ydA0Kc3RhcnRzIGZpbHRlcmluZyBvdXQuIExvbmcgdGVy
bSwgZWxmIGJpdCBlbmFibGluZyBpcyBwcm9iYWJseSB0aGUgcmlnaHQNCnRoaW5nIGZvciB0aGUg
Z2VuZXJpYyB0ZXN0cy4gU2hvcnQgdGVybSwgbWFudWFsIGVuYWJsaW5nIGlzIG9rIHdpdGggbWUN
CmlmIG5vIG9uZSBlbHNlIG1pbmRzLiBNYXliZSB3ZSBjb3VsZCBhZGQgbXkgImRvbid0IGRvIiBs
aXN0IGFzIGENCmNvbW1lbnQgaWYgd2UgZG8gbWFudWFsIGVuYWJsaW5nPw0KDQpJJ2xsIGhhdmUg
dG8gY2hlY2sgeW91ciBuZXcgc2VyaWVzLCBidXQgSSBhbHNvIHdvbmRlciBpZiB3ZSBjb3VsZCBj
cmFtDQp0aGUgbWFudWFsIGVuYWJsaW5nIGFuZCBzdGF0dXMgY2hlY2tpbmcgcGllY2VzIGludG8g
c29tZSBoZWFkZXJzIGFuZA0Kbm90IGhhdmUgdG8gaGF2ZSAiaWYgeDg2IiAiaWYgYXJtIiBsb2dp
YyBpbiB0aGUgdGVzdCB0aGVtc2VsdmVzLg0KDQo=

