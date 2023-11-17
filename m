Return-Path: <linux-kselftest+bounces-259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AFF7EF761
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 19:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43314B20A13
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Nov 2023 18:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A4637161;
	Fri, 17 Nov 2023 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZUw5Do5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BDD5B;
	Fri, 17 Nov 2023 10:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700245016; x=1731781016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LE+TmHCS7anUs67Me4oQY8ga4UTFIGdvTdSLZ+lOpDE=;
  b=HZUw5Do54hvWH8MJTtT+VmdTxX7TSJ9pdadCN6YXCH5ImYydpv8jPKDR
   V5VkarVPNrBb33uSU3a3fEoSlnFRN00nS5HRN14kPrHLmtHMpelYJuhBj
   PL/R7PTWGJCMFu+7m1Dreiwi2/HpLPZ9yeHEhIfd83hK6XaqiUcx+DQha
   jbT1AEH7YY43yUmB+d+t8y3Yxx/k18Jhi8XnUVa8WVsQdX33UnnB440w6
   178oRR3mYwDufzBYlJQ/MmXvHnzDuyTMKWTBD5uG9RR2Dj53AyxTgK5Dr
   +0ZfRi4XnoBtlpkEsk9jmgKD/baCNt02a2EnTO3dtFNlTiptN6CY7xkcd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12896797"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12896797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 10:16:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097168902"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097168902"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 10:16:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 10:16:54 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 10:16:54 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 10:16:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1HnsuAMkrII6IGG26i51LHRWet3q7hsB/DFFa5o3I3McbUwWAG3jt9J56AdY24pJ1vskvO6oNxMEWl39E5kiLw3EdNA2/98CxdGLslWzsTzPqgpeY+9wu67vBURLSDhavKdqMyVURU9rBu5c5dy0EAaRwjAgyrljZ9qoJOmMJqEVZ1ZvQHRnqOs/RgTzOsumZuVQsSuEVQhrkl1NyS3noQwaIlbrHsGfNmWjB5MAA/yQqDn9gr1d+aFyJ1PPaGGbRLqjvnca/3OVeVBR8c+eSTLDHifbjqhMiG6dP8xGInnGfAm4gSGXbdL7Bn2jp8VRAMPVYH/AhEKuwl3YdvTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE+TmHCS7anUs67Me4oQY8ga4UTFIGdvTdSLZ+lOpDE=;
 b=W7+VowvCWA1e1wQWyTEAStey0R9hv8l54Dnx2spvlc3XGO638wGoJ0yHWiJ0KnSpnpt30Lx+Qd7NnKI3PfLGsPqPxbJE+RSKIVWU/SOOzSy2NRCv75yeCDMSRN1ya3MZc96a/ksGkfEv/iwUFw2Yt6H68A3njklnKg1DqObu17Mj8UXVeuEk+T2PfrEif38yITlOShe9U83aKCj554FmCxgbK6Z87Ch3BMrzpp66ntWgeBg35dy6nBUxVChX5qJYTRIgIljgQqOXmUKyuNEHqXwF9oBAPvLYBIkPdKPAgp7COLML/VuUFHOQo9PyMo47jRLeEkYNvopvDn0rp4Hrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Fri, 17 Nov
 2023 18:16:52 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 18:16:52 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "bristot@redhat.com"
	<bristot@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "Pandey,
 Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Thread-Topic: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Thread-Index: AQHaFzYe+3PXY720NkO0CxBi0N1IArB6cYGAgARki4A=
Date: Fri, 17 Nov 2023 18:16:52 +0000
Message-ID: <7dfd1d488517cfc74bb52a52d52bca7345fc2528.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
	 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
In-Reply-To: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CY8PR11MB6988:EE_
x-ms-office365-filtering-correlation-id: 91008e94-81f8-4ef6-d2bf-08dbe7995f9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e35G3Nxn3PRTyWoDmxcxvxLGhkQM9HnaxMzmr76MuNJwP9s3XVMQabrr3Aqcau/l6LDwgwGGpp2tkcYGey25A8YiuJKZzO2VPeqjD1IrEXyYDQERXGBQvxePbJR7bTvsfXQhyGFxGpcguQUaKt3opaqnWxhDszY1BKbPqPOozf0FQPqcrssY2XD3ZhoOESAUorK5iCaj0PyGaAQJMRVkNy6Dr3Oq9hw7Dk7lTWgd05JXcRAo7vrNOaaUEgLoBrMCveK+XjJr3X41oI4KRqXQ4e2V5gZIxLYaB4xArjdoUeFdUWLdQa15YOS8HQm0AVmAZ7Y6ResnlA294ViLb8CraGmReGQs4R/1ABL1pZmCcPd/Tw2/64Cmod/jcDzTDB0arOh4U1Yz55Jor/EbyD+0+RlgdE7UKbdZfVLZGmxTblBwapIk99jy7sCaD9gUZ5qLuj8ynqwtD0jsU+6jTINFLL3gyOZDIvrPLGqrwSeY7CR444B8jKawcf5HRoFfdMMKlLM43xSt7WkPsZuvGB8JCP5X2zfrIZARjqUOKgMso23ojlH5AomROgN2ob7dqba1lgh886k6JCIA/M8LAgURMRBC8AtFfxfc+try0+9icgXeDphGZ2iXibzMo0kEREOt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(82960400001)(8936002)(8676002)(4744005)(2616005)(5660300002)(6512007)(86362001)(7416002)(41300700001)(921008)(2906002)(36756003)(4001150100001)(122000001)(4326008)(26005)(6486002)(478600001)(76116006)(83380400001)(71200400001)(316002)(64756008)(54906003)(66556008)(38100700002)(91956017)(110136005)(66446008)(6506007)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3RXbExzcWJBZXRwdmx6SWVRenZNTWpBbktiZXA5MER0Y21aazVBZHFubTdD?=
 =?utf-8?B?VzNCTzltYi9BamIrWS9icHZCNy9Gc3l5MktYRTVTbUJXVXFoM3ErVzZRWTFz?=
 =?utf-8?B?bHBUajJwQXI5NXo1eXpuSkZIVmNIbXpBaVVqNWdjSzNtMG9XK1Zjb0s1UTlJ?=
 =?utf-8?B?WHhWTVk3SllGN0dQdlkxNmNTM0RJQUszOVArcGEzUmFtelhuTFRCdUgvZHN6?=
 =?utf-8?B?b0hsVkNEaks0ZG0velRWRm94TlVyRDJOTHhlWUhGOWJselFtNnhvbHVwWjRy?=
 =?utf-8?B?cDREZ1ltMXB4d1JUZnYzNGdJUU5aWGNYMUtaV3h6NGZnQWRIOGpZckpXN3hS?=
 =?utf-8?B?d0YrVExsQ0Q5MHN3UGVoL1ZkR04vbFJ0NmVYQVNDSC9zanAvbXVOYk5KUUpV?=
 =?utf-8?B?K2dxOWNlRmZsS3RkYnppSjBWUzVzNVlrME5uUUFkMDlKRnNFVmdGN3E5MFZ1?=
 =?utf-8?B?NnV3RDNORnhCZ3F3RkgxSFFva2FvbWlwMXdvRndGSFVwdFd2cGJrTXFvWUFS?=
 =?utf-8?B?TG9JWXBFb2VkRnRzTDZqa3IzNW5wbk1teVRxekJJQ3dMNTVvdTJVNTZCQVR3?=
 =?utf-8?B?YnBZTVRPS0RlM2wyN25lMGhaSHdCeW5idjBUdGZvcjJmbUQwSEQyUTlZZHA0?=
 =?utf-8?B?czVGVkRTY3l0aDlYdXNJK2h1c3JOUGc4RWxYYVZKODBHaHp3YXVmVFJ0SUFJ?=
 =?utf-8?B?Skg5VmQzQmp0c2hoWG9YTjR0MGdFYWZ1bGkvczllTVMwUHlWVGpCMjlyNzJV?=
 =?utf-8?B?WEZWN05ZS3hRZEJ5ZzZPZnhhNkZFQU9pamU1eGhBWnNEUmJWTmliYUxhQXpB?=
 =?utf-8?B?aFdRaXVjL1VIcm5jWk56Z0JzVGlOekFPVW5ValQ0S2x0bVBtdGpscm04bnZL?=
 =?utf-8?B?MUwxUW1DaUtDdUVSQjRSdnlSS3ZLc1ZaaU5zTkNFclVZZzRWOExFUHE4Sm1T?=
 =?utf-8?B?UW5kWExhZERqeE82UnY3UE9aSWd5TXVab3dtY0hmdEhUVjFPZVRZVm54QXVn?=
 =?utf-8?B?SUZENzVNNUMwbG5HSWx2VCtZdnVTWHllNTk3L01iRXRuN3haU3AxQWhiUWpw?=
 =?utf-8?B?clQzcWpUMlh2SmtIQXJmREhnbksxem9ESk0rN3FSNG1ENWJIN3lWbzE1R2xj?=
 =?utf-8?B?bjdzR1BRWUFvYVplT0VheHp4VHlLanNCa1JjaS96NXh4cThCUmx6WmxBdng5?=
 =?utf-8?B?TkdrUE9wRGpEMHVaUHFZbFpBcnhUc1NXeEdnYXdRbmtZYTNQMVRUdE1qQ3Fq?=
 =?utf-8?B?UWRYeUQ1UU5sU0pMQ1BmUFk1NGhSMmhmUVZaS1BKQmRvT3owZ2tOYWVvRjdT?=
 =?utf-8?B?cHozcmZCc0JkcXFBTW1Qc1NCV2JVVDVmblFzWWJnWVEycjk5WFEzMWQ0aWpK?=
 =?utf-8?B?NzhuWTJrUm9QdGpTQVc5VnNrRGhmd05mSmZ3ejJXemEwVGdPWkdnd0RBalp2?=
 =?utf-8?B?RDhRblFGQnA4YUphZW01R1hkZnNjbkl0MGxGMEoyUFVTdkYvRGVEZXJtNzJ6?=
 =?utf-8?B?TVh5V3FmVDVDd0xrZ3k2OEFpWXBMc1VZMHVPZDdBOXRBcENJUUQyTkRkTGRP?=
 =?utf-8?B?YkVNLzlydklIUThkaGhaL3pEZ2J4KzMxUFhIMGQ1YXJQMWZyd3dGdFpMN3p6?=
 =?utf-8?B?OHZ5L1Znem5ZRnIyM2trK1BqbGtBbTVrTHhHUE5HS3ZCWGdLb0xUSlpxTXdo?=
 =?utf-8?B?YmFQeDJaV0RqUTRvaXBGQ2xXeEFPd3MrdHlwYzlQQWlvV1B4dDdReGRMd1lR?=
 =?utf-8?B?WkVYK0NzUkJPUFhnUzI0Mkl2SXdOTHREeVRnTzQ3YkdIT0lGVFVtYWpMQXZ2?=
 =?utf-8?B?aE5CM25zMGxKdHBSbWM2aThYMUVGVklNOEJFeVltZXRVZEQ4Y2hUSEFjM2xQ?=
 =?utf-8?B?RlFCeXhEdC83YjdBMC9ka3RWU1VrM2daeVdJNXd5OU1PNlNBTVlwM1VaVmtH?=
 =?utf-8?B?a1RrT3IxT1RTdEcyT25VdFpyTWlJendMWWhTM3NUR21VSERzd0ljRjU1dTlI?=
 =?utf-8?B?cFIvUytnRHRQbWR4S0QyeTNyNWNWS2lqK01hNzMwellXSGN0WjlUZlVEaEIw?=
 =?utf-8?B?ZVE2aUdjc3BtTjdaUGdISzk3ejBVY09xVXo0UzJ2ZXplNFNQQXJybGdjN1R3?=
 =?utf-8?B?TXN0NFppOWdydHI3OURXUCtvcjkwcmJjUy81RUxkUS9seXFIYzhvTTBKVFJN?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D05E5A39D948D4E90FC680EFF47599D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91008e94-81f8-4ef6-d2bf-08dbe7995f9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 18:16:52.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chY9+s3cHdFCuLiP/Rhhzr9P0Zy/IBe0U/3If7wCIuprJ3r5HHraHj5Qn1rtvtJAHiHhJY2JTBk3MMfYerA33MN0u/FdMVzabqKdihcgTRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTE0IGF0IDE1OjExIC0wODAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhlIG90aGVyIHRlc3RzIHBhc3NlZCBpbiBib3RoIGNhc2VzLiBJJ20gZ29pbmcgdG8gZGln
IGludG8gdGhlIG90aGVyDQo+IHBhcnRzIG5vdyBidXQgY2FuIGNpcmNsZSBiYWNrIGlmIGl0J3Mg
bm90IG9idmlvdXMgd2hhdCdzIGdvaW5nIG9uDQo+IHRoZXJlLg0KDQpGaW5hbGx5IGdvdCBiYWNr
IHRvIHRoaXMuIEkgdGhpbmsgaXQncyBqdXN0IGEgcHJvYmxlbSB3aXRoIHRoZSBzaGFkb3cNCnN0
YWNrIGRldGVjdGlvbiBsb2dpYyBpbiB0aGUgdGVzdC4NCg==

