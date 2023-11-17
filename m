Return-Path: <linux-kselftest+bounces-258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECC57EF733
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0BC1C2099E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0885143155;
	Fri, 17 Nov 2023 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuOJi16q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18210E5;
	Fri, 17 Nov 2023 09:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700243013; x=1731779013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=c0RG5aBVb9umOVAMUTLvOCTH5u0DEXI3/8R7NKepgPE=;
  b=FuOJi16qPcfqJzLBqlUuMCQFDAEzAQXs3/teifHl1Ks73h9e3Zi3psaD
   ibWHaj+eP+gjUq/gqqyVSM6A9JJdhtA8+4kxl2keNVh2kRScIAem4D90J
   EuM6uEacKoh8T3nbaX4j0IdAR/pDmFfnoI5QXST9Wpu/w0dj43wXDoBlT
   DEPHnzk/lOvwK5H+XmLIykS53w4rYdekAWDZK/m3SlhjYIaphY02ZiAmB
   KXRtAAFroSSqHTnZfi4DnHtnCMKs4dfiJVBIGS4u3NJBB0BLR+S3dOlqz
   Z4xw4/paIRNA6W8TASF1rTBtjcztndSzj7Xw9KCGAr6HUk4GcalbOFC6x
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="10000567"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="10000567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 09:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="13553621"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 09:43:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:43:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 09:43:29 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 09:43:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS0GA8/++JWm/uwWj7c23J8vvTqmfTwc3pb5kzS+S1F8uvkz8YqnWcqtmaF6qoX7hJPagYmTohyMFpdbfxUz7s4rrO67lYNMOePwPFUsFSZr7nkNjj3b4C3YkBKdsgf0DsBU5b9z8LuSmyBJMvwt6L7xy1WrofCOe8gUPMu3kEqk76fGJV7MvAwDc5NhE8tJJTD86ooaTOdN9sgrTiQkUQX4Seyef3XTLWsA9XSNQWnBcdWJZz9YEu3bxJvha8rKKk8py9hC90O70l3/yrI2VHgG123LpU6bZUTr1BLg27PssLGcEZt7nLAMWA9v2t3dEEDWEF/xNUv5O17byeeANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0RG5aBVb9umOVAMUTLvOCTH5u0DEXI3/8R7NKepgPE=;
 b=Ko0pXZ/RnEOG5XJripG2FKEbHWqxs7Dh4+HV9aCWH0X3K8Ufg+uAihVffSR7In0ufkEuCnSOmRm/ouF5ryREnzQrBm6i7SFUZaQ7oqawRdoEEYGUtp+btCn+l5DJEp9vQzIHcAnFfrV+TQRlaMWaEmIYUnbvgW2oLlFTGpXd60gKAJ9Y73JLW5mKeuOdyu/nV8sWObruNAlo5QGMxHnu0zEZG3x1RkRjTVSncpg8eXiD3a07b9ER0qSH+32Rv0Df4VVi/1bTqn/eOrd24nQYWo9Wp8bnrkPe3xCfCZIPFqLVGA+OAIdrYBrKP2ef7fdxVAkhurCEQncKREL7SzBMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB8068.namprd11.prod.outlook.com (2603:10b6:806:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 17:43:26 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 17:43:26 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "mgorman@suse.de" <mgorman@suse.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>, "bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Pandey,
 Sunil K" <sunil.k.pandey@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to
 clone3()
Thread-Index: AQHaFzYai+mxslqXM0i150aoxWGrvrB6i7UAgADGr4CAAD5nAIAAKB6AgABm6gCAAKILAIAAIfGAgAAWyICAABwsgIAAK2UAgAAIWACAAYI1gA==
Date: Fri, 17 Nov 2023 17:43:26 +0000
Message-ID: <2f92f798a1807679d193fa19b217486f57398163.camel@intel.com>
References: <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
	 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
	 <ZVTvvJTOV777UGsP@arm.com>
	 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
	 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
	 <ZVXvptSmmJ6MQ0dY@arm.com>
	 <1bd189e0-a7dd-422c-9766-ef1c9b0d3df8@sirena.org.uk>
	 <ZVYfO/yqRtuRYaJA@arm.com>
	 <54d3bc9c-9890-49f0-9e9d-78ea4d0d7199@sirena.org.uk>
	 <9ce63f824b768f9635e55150815ee614fdee1d73.camel@intel.com>
	 <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
In-Reply-To: <eebf054b-7e0e-4732-8d8c-718073ec32ed@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB8068:EE_
x-ms-office365-filtering-correlation-id: 8055e5c1-e808-41b9-d858-08dbe794b3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5s8Ycz5HYj5TQ0kqxgpgHpvV9O1IJLsRnaYr6ZG2AZH2r5JuseWccfdtPg6gPlt78OFNTy0yvX5CWldKTzVxlP6gpF4pvTUCzuHSd8TvqAw8uzzWPSnabAxBhVMVnqL8DGh3UV/oxP2Yt09Qj9slEo7yd788Cq59pcWFdT6ykL74TE2cClmfuz+ClUmaSV1stIBDOkQ58YtZm4q9izrh+r2gv8OzTLqnkEsawPvOD4+mo9FVH1FvdqHHwmNOhGhAiWzwV9EyF0g9MtfsU3vuld+vTfieeZMhy1gAQoPj3w/dO9sJTgFIhCxAGyUmbofsMnkW2dwb5USVQPZ8ATbrX6N1eAX/Y/4PwSJBlRP1gvQoRkwPHh9tzoZ4pYeLx0dp6VEk8PGeVUDJRZSTQPQMjVTg6yjWCWR2ZEIxZqA0Ls0VQvEszv+dKOCbRBufIXVJa97qFEXeGDGqOIzbLOPF9i6XyIBjrD0sn5ROu39iRJRIvVjo5/e+eeOzDZnzZHK+m3oZ84AymfrjtmqGh6bS4r3WBkhuwB5G9SK2ocKrx4aG0M2qup5IyKrafTzfjv2H5wWdCqB1vWcUwLjv6yRqOYAYjwS/1PPXuXDJqTWz0p9jtnGAvqfLc6TRjSemIkb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38070700009)(6506007)(4001150100001)(2906002)(122000001)(38100700002)(86362001)(5660300002)(6512007)(83380400001)(82960400001)(7416002)(26005)(2616005)(6486002)(71200400001)(41300700001)(4326008)(36756003)(478600001)(66446008)(91956017)(64756008)(8676002)(316002)(66476007)(66556008)(66946007)(54906003)(8936002)(6916009)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHlkQjJnWDFyYkRxTmhlUzVJaUFveVNaL3ZQR1RFMWR4Zi9XM0RWYWlzT0o2?=
 =?utf-8?B?OU0vZkJMbjJwMTRrSGI4aS9jaFpwcVpPank2QWxpVzc2VmJacWlLbDZRWmdj?=
 =?utf-8?B?MVk5N0cyb0M3R1pIRU1RVnN0TGZrck4rVWV1UTVBVHkvMGdXTzlidm9uN1VJ?=
 =?utf-8?B?Z0hpWFVDQlRYVmIzTnBYMFRENUdkQzVIRUVRZkt1UUF6OUN6T3M2a3diTjJI?=
 =?utf-8?B?bVZUREpkT2N0Zkw0bTYwN2dSenRnanNYbzJBZFRSVUpQc2VIU29kT2tyMDh0?=
 =?utf-8?B?VmlEMXZUVFFLWm5hOHdYWEpWWTZ0dElnaUdtVmhtcmRvMVZyMnMrWW05ZGpG?=
 =?utf-8?B?RERMcVlraDh0aFVUL3hFM1VZbUVMWFA0UVZRdTNWUFJxTnRzcFBFQmFWTXJ6?=
 =?utf-8?B?anYwcUsyYmdvUzB4RWwwcDlydElyR3oxOE83Q0MvWlVXSWl0SSt3ZmljeVFQ?=
 =?utf-8?B?RStTcTdhT1Bxb05PVkphaDRjc1JLU3lpZkJ6U1UyUk5QMDY3MDNZWkxLOCtl?=
 =?utf-8?B?Uy9uYXdZZ0VUbld6d3dHWDRra0dzL0t5dlE2T0NIT1A3YlFwZTF2S1NoNUh1?=
 =?utf-8?B?UkJhampIb3F4WlJjUVlnUWtBZFQ0SHFYbjdzc1BQVHNRcmw1czFuTjNzRjg4?=
 =?utf-8?B?cWRpTzlBLzFnbWVYcURIaWFvaVlMQkpldUsrNkN2NTIwZm8wTE5FcGUvcUYw?=
 =?utf-8?B?dWZlR0tyZWhobEpnakZYTC9JYUJRQVNCUlA5ZEFQcWRBNkNCdkF5bFc0MmRQ?=
 =?utf-8?B?dk5KRlY5dC9pRzhmUzBUZjlrNnE0NUlJeWl1TGNrd2Jvd0p5TFdJcXpRd1Fw?=
 =?utf-8?B?WTRGUmI4dzJxbnQ1eGdWcTE0dGlITWJNbU5TcGlLaXRUTEUwaUVUTmVjYmk2?=
 =?utf-8?B?TXhvNE8zU0J1U09QOVdaT09ZOENQYllhVSs0dTVMUC9WdlV4YzVuSHFuZHhE?=
 =?utf-8?B?NHpkN2hiV0RwNlRKSzNWanMwUjNhYWloRk8vUFJkUVNlRDUxcjI1bHNDZ3JR?=
 =?utf-8?B?QnJPTGVrckFwZkorVk9qQmtWRHI2RTNxMUFEQWgrK2ZqTlVlU2RLbllrSnho?=
 =?utf-8?B?cXpVRTdpT2dhd3pxUk83dXE5a3IxTEJ3UVJOckVoRHBBYi90cXNrdjkxVEI5?=
 =?utf-8?B?QmYzU2hxNnRQY2pQR1piZmJiSEZLbDFNajkvRE5BUmFwZkxwWko5SnlLTEZm?=
 =?utf-8?B?WEJWV1VXWjROUmttS3c1R3gyN1VKRUdhbSt1ckZMSTdjQysyb3YwYmNRZ2NC?=
 =?utf-8?B?b1ZjMTY4QUNjVHpLNWFBQm9VRkpBYTlWR3l2L0JQRmRSNHRuTkJTWUZCZlNa?=
 =?utf-8?B?M1gxeXVaMmtTbGNyUWxVdzRTWVFUYjd1ZmZuU0NPeDhnK1ZmOU9SZW9VQzNq?=
 =?utf-8?B?NVMvdDkwdkt5VnhuSC95eDlxTktPbmlxOWNZdnNrS2dFVVJsRmR4QjM2VFZB?=
 =?utf-8?B?eGtHZmFGNFhscUxhTFM2TTh4QXQ3VkFLclVBU2FzWDFEU1A4eCtpYnFsdkZW?=
 =?utf-8?B?c29WTXpwQ3lwSjZsc2gxR2JGQTNNSzAyYUV3UFFXbWprczJvdmhleXZwYllJ?=
 =?utf-8?B?VHlOSlFIT0NBRzhNd29wazlvcDFIam9BU3VvdTZrVzFobmJ2d01KQS80Y2FO?=
 =?utf-8?B?ZXI3eE1uQmRLVU82Q2l4VGxuY2l5b002ZGdSbmZJZFpheWI3YTBHZm93Wjhl?=
 =?utf-8?B?Umh2YlU1MWFCdGNlNEN2RlVha3RaczI1T2EzOURIcVRFWWRvRm5CaG9KU25j?=
 =?utf-8?B?aUl3d3V6THl6M3NhNlBob2E0ZFJLSXhzNm1LWjFoRGtoRXlvWmdSaU1GR0pY?=
 =?utf-8?B?VWV6TFI4dTFNVGtZZWt2TGdJTTFPRGRNeVV6M2dZdlpoejlvZTNKcml4M1Iy?=
 =?utf-8?B?OGpvMExSZTVHUnBjNjc5MUJ4MGJNZWRnVzV4TjRRNDFpWmxUR2JNLytWdnYy?=
 =?utf-8?B?ejdjYTU3VkpwcVM3VHl3ZWtrWFpvNzk4bmp2YlRVSjhGckl2S0JKZFJqT29j?=
 =?utf-8?B?SENsWU9TM3ZOcTZDc1NyN2xHMVFOWHRHWTlyYi9LVGlFYXpZL1FYcFVldEdo?=
 =?utf-8?B?VzVCRlRiYVdkYzNvbEV0bUxqMXlEUXI0b1dVaXBnUCt5c0FFNlJ4MDJYcENO?=
 =?utf-8?B?SlR3N29MUXhNWTdjK0VvVHhFOFhQcDJUSlBTOTNxOUVhVVRqSE84MERMc29v?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B407F8F23AF6C4C935F30A4C32DBD16@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8055e5c1-e808-41b9-d858-08dbe794b3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 17:43:26.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JfbDUrWmXU/NLF82wKRqJ4NEb02GCPBb/+rh262M+q2/on/tuPKqRfiqCI4UlCzXpXnZxQ1SkV5YoB1eb2ukezdjOpCI0dc8XoWxJA+YLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8068
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTE2IGF0IDE4OjQxICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFdoYXQgYWJvdXQgYSBDTE9ORV9ORVdfU0hTVEsgZm9yIGNsb25lMyB0aGF0IGZvcmNlcyBhIG5l
dyBzaGFkb3cNCj4gPiBzdGFjaz8NCj4gPiBTbyBrZWVwIHRoZSBleGlzdGluZyBsb2dpYywgYnV0
IHRoZSBuZXcgZmxhZyBjYW4gb3ZlcnJpZGUgdGhlIGxvZ2ljDQo+ID4gZm9yDQo+ID4gIUNMT05F
X1ZNIGFuZCBDTE9ORV9WRk9SSyBpZiB0aGUgY2FsbGVyIHdhbnRzLiBUaGUgYmVoYXZpb3Igb2YN
Cj4gPiBzaGFkb3dfc3RhY2tfc2l6ZSBpcyB0aGVuIHNpbXBsZS4gMCBtZWFucyB1c2UgZGVmYXVs
dCBzaXplLCAhMA0KPiA+IG1lYW5zDQo+ID4gdXNlIHRoZSBwYXNzZWQgc2l6ZS4gTm8gbmVlZCB0
byBvdmVybG9hZCBhbmQgdGllIHVwIGFyZ3MtPnN0YWNrLg0KPiANCj4gVGhhdCBkb2VzIHNlZW0g
bGlrZSBpdCBjdXRzIHRocm91Z2ggdGhlIGFtYmlndW91cyBjYXNlcy7CoCBJZiB3ZSBnbw0KPiBm
b3INCj4gdGhhdCBpdCBmZWVscyBsaWtlIHdlIHNob3VsZCByZXF1aXJlIHRoZSBmbGFnIHdoZW4g
c3BlY2lmeWluZyBhIHNpemUsDQo+IGp1c3QgdG8gYmUgc3VyZSB0aGF0IGV2ZXJ5dGhpbmcgaXMg
Y2xlYXIuwqAgVGhvdWdoIGhhdmluZyBzYWlkIHRoYXQgd2UNCj4gY291bGQganVzdCBhbHdheXMg
YWxsb2NhdGUgYSBzaGFkb3cgc3RhY2sgaWYgYSBzaXplIGlzIHNwZWNpZmllZA0KPiByZWdhcmRs
ZXNzIG9mIHRoZSBmbGFncywgcmVxdWlyaW5nIHBlb3BsZSB3aG8gd2FudCBub24tZGVmYXVsdA0K
PiBiZWhhdmlvdXINCj4gdG8gaGF2ZSBzb21lIGlkZWEgd2hhdCBzdGFjayBzaXplIHRoZXkgd2Fu
dC7CoCBJIGRvbid0IHRoaW5rIEkgaGF2ZQ0KPiBzdHJvbmcgb3Bpbm9ucyBiZXR3ZWVuIGhhdmlu
ZyB0aGUgbmV3IGZsYWcgb3IgYWx3YXlzIGFsbG9jYXRpbmcgYQ0KPiBzdGFjaw0KPiBpZiBhIHNp
emUgaXMgc3BlY2lmaWVkLg0KDQpFaXRoZXIgb2YgdGhvc2Ugc2VlbSBmaW5lIHRvIG1lLCBidXQg
aXQgd291bGQgYmUgbmljZSB0byBnZXQgaXQgdmV0dGVkDQpieSB0aGUgbGliYyBmb2xrcyBiZWZv
cmUgY29tbWl0dGluZy4gSSdkIG1heWJlIGxlYW4gdG93YXJkcyB0aGUgb25lIHlvdQ0Kc3VnZ2Vz
dGVkIHdpdGhvdXQgdGhlIG5ldyBmbGFnLg0K

