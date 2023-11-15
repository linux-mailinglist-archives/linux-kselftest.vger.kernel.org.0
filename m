Return-Path: <linux-kselftest+bounces-116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697067EBAAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E69BB20AC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 00:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F79394;
	Wed, 15 Nov 2023 00:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2peQG40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106ED181;
	Wed, 15 Nov 2023 00:45:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5DDA;
	Tue, 14 Nov 2023 16:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700009149; x=1731545149;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q9zLkUAfCJMvHjPES6m6R1KPkevWRRjIRNNOyGaL/DE=;
  b=Y2peQG40GS1HkqUFENjSH4ouPTe9oolTjsaOPM5mDBl3mTiE8nJPtKeo
   RqJOpnKWfxiw0+IFh0huXu/jsK4SbR/dItNkTVnxp4mcVzb+z3LMUpRbA
   CfVlnWnjYcop3CHRC3VH8fGP6icKLt/UNbN4cIsb11qVyA84NQShHmh74
   AdHSoNaSB8KEDV4lTAAzHgZeORuYUerrf0CFau+XkQbzr3oesqXnnjqVB
   K9IUWcoXW/zrsp/yBPOscLcSpXW7MMtAMNraHhFRrx8BYCV4XsZL+Z+io
   /Q40zIUOi/XhPcKqNkykzbq2TpeiU58dYlAD/V+i2UMlJ5a1/heHViWrs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="455071149"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="455071149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 16:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="764826560"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="764826560"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 16:45:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 16:45:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 16:45:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 16:45:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZLNppCJxXTXyqHKyLYbdlElBhLAKxqdNILbpWDI5MomAn/TRrhu343m+sEo5M36ecDNQTqrA6Q97SawtqzQS0BW4WVAHuYLFTzQrq6ONpAf7cggg/0/PZoHiB1KcKPRUh1JP53PGKmaifaz5vTe1Fj0R+j0r6vZXhPIt1FTxOorZgxJmIcaisaa89Run0elFvOkHD4nwVC3LTcTNfC20X9ICFcGYQmsh98cyfaO13GRhaiSOju83DNEZuyy+XibtlDUC+Po8KRWQKQ57QQPq5zGMuY7YNQLy07OuubgQg3QIfLdwvdANK9/cPODRagyZChIQRykMNlYWsAJlg3rIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9zLkUAfCJMvHjPES6m6R1KPkevWRRjIRNNOyGaL/DE=;
 b=ltnyD+vZywlD5DMkCQGuBwd7FOFLdtVDqCURBDUL3cSHJkLZdaRIfiN2A9iNH+0jM9zZEu2kx/Iy4O/ZtzagVkLpuxQq2UY/ZeMO78ai1fvjeBHk5Sk1mTmsX9Vs+HBYf+QnWUr3CDJxMqBxq9RCU5sjXUx4wbEJ1gBbJT2tQa4BNHhyjxM+DwxQ3USVacADv5epdW1VHXQxumlNOqqxDdYhxc8SZZz/t/KTsjBqSJp1zdIZxyAloG9q71ibFg2iwyd4oIxUtpQbdVlbvSBH4nn+cdhkjrbD73Dimq7hXD+OIeZaKCSFbOAJZxR0wYtC52cWXEAUNFX4atiusRsLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB4882.namprd11.prod.outlook.com (2603:10b6:303:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 00:45:45 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 00:45:45 +0000
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
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to
 clone3()
Thread-Index: AQHaFzYai+mxslqXM0i150aoxWGrvrB6i7UA
Date: Wed, 15 Nov 2023 00:45:45 +0000
Message-ID: <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB4882:EE_
x-ms-office365-filtering-correlation-id: 0db16025-f05a-4e7b-e015-08dbe57433de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tp58UfQL+Yhi6XZtFrQuwyRrzKQm8YsSu7xHlEBATjkF9M0ckA0qRaUGjYGCKR5D6t/oIHnvTyjApstEp4ajzE7a8UHpP3RmvaJQ4I4uGBxuqrUIheMak2eFG1HeaeAiGCRAEj482Lx/n186VCitAFpn9j71iP7VEoox5EOYAi8KUU+WwOEAccMXcuOM3OfjC3UysspDLLjIDXpawq8xNl7CRQlo+gheplCsD60lK+a/nX2w2s/jaSPzTs9pZMJQmy0fCDypkBnhRf1dDp1IYVDscJ7yisN8bwvhMJlcMuxskTrCAjuvRFVmKQaXl2Im7lz05fn6W6JtrKpyz+4OvrsW54tj7xvS0KrM4fm9zk6NaobFomvDJ4b0Nk3iB963b14WZE7WE5OX7tru6PijsXvmzGqkyraPhW+iqPNkimxGdURgQ0e9pgpIDfJtXVk1K5Bya2lFr2+k94l0hwGXdTrkfaHVs/5W7oRORT+nEXc26QIKMl0Iiv8lV0xe17v/CvOHzHklv9j8pjbzUzB/1I3WFP5Kq7i0hnopgUmLGlNrp0PmYyRTvXgHawqUhc7cVBHWz6RlIH+bqWnQr7mqRUbXyhttLD3qtgtYpkWjXFMi/rzI6Zh2AgTLYkJe8uSLWH6t4lQQGhGo8Suv6WST4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(122000001)(82960400001)(38100700002)(83380400001)(86362001)(7416002)(5660300002)(38070700009)(2616005)(6512007)(6506007)(921008)(478600001)(71200400001)(6486002)(36756003)(66946007)(76116006)(316002)(54906003)(8676002)(110136005)(66556008)(66446008)(91956017)(4326008)(64756008)(66476007)(2906002)(8936002)(4001150100001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NLblAxMjY5Q01oSVhKN2FDc2hsVk1oUTRsVmtRVTVadGdUaWNNNTlFMmxH?=
 =?utf-8?B?eGNEaG8vaEt2WjhvdnNjdHRlOGJKeE9PS0twNTJLWGsrUTdoZFZ1clI3WmxP?=
 =?utf-8?B?eVJ3T3dMRE1Va2o0SzRGbEkvQVIzalhraFNxTklhMllCaTVVUzRsVkRyUTBM?=
 =?utf-8?B?TzBYckpFUGFVMUZYbGhLY2lTRXhVRnJqYklybEdBM1FmdENCRGJMUHNabHFL?=
 =?utf-8?B?dkZWZFlXblhCZjh3dzlBR3JEdVpHak0wb3dHQjUwU0JHWmlTVTNkUnVGb1R5?=
 =?utf-8?B?dG4rcmtoY0E5bWMyc0F3a3VUMTRRbXJuNmlOYVZXRnFmT2NoVS90NEZhLzdn?=
 =?utf-8?B?S2xzZVJITityWW41NURpWkxQQkdNZHBKMk5OY0lZNGJIdEFXYlhHbzk3TFhE?=
 =?utf-8?B?TWNodmlTbGYxM1hBYnNpVHhBK0VDL3pvTnhFcFpNaEZBbzZmZ3F6dzM5bG92?=
 =?utf-8?B?MHc2UjZ6QllKZ1RVTzgySFE2YXJvekpaeEJtSzVQeDByQW5QSHl3YU5ZUFZC?=
 =?utf-8?B?ZGRiWmxyY3pHcWxDSzRZM1Q1NHRIMFJjb3owV0hteWVjSUZiUVBQSU1pVXND?=
 =?utf-8?B?RHFJLzBZR1pNdGFUQ1RxWDBvWSsvMS9EYjcrS0Z2SUpJZTc4SmJyUG1LUXhH?=
 =?utf-8?B?cWoveStYcmhOTisrWkFwSGUwRDlnSGNrN1oxSjRTam52NTBRUHNLL3VCN3pm?=
 =?utf-8?B?bVMwTGJudUhVb3dwNnBsR0hhNlM0TUsxWlhIYndhc1NkQlUvN09TWXdaS2wv?=
 =?utf-8?B?aUpZZU0wUC9BVHVteFZ2WVZnb0FZQmVhd1JXSWVCWUpKQUVSc3J6TmREWDFL?=
 =?utf-8?B?cDROMXQ0czk1NFFFYTZEMmF4emZxRmlCeVg2aUdOSnMyRXpHNTZQSFRyaFJx?=
 =?utf-8?B?dUxrK0RpVlNCYmlPRm9rRzB5SkNSVkdLNFhwKzJXY1NJRDNSaVE0ZmZnQmxZ?=
 =?utf-8?B?ZGNuUnh5dVpDQ2ZOZ1JLb1FGKzk3cW5Vb0dVc2lSTWVhdEc5MWYyeHUvT0NW?=
 =?utf-8?B?RVhVemN0TVArU3Z0NVVxSnRUMnZOaUJ0NFhiMm5Daml5RjRuWGplM0l1dmFM?=
 =?utf-8?B?Z0dTUFgzejhKY254OWtoRDUxcUF4am5iUHh4UzZ1WkppdGdUTVRLZkxDdGFN?=
 =?utf-8?B?OWI1U2VVZURsZU4yaHpXZFRqUHR2NUZkbm5UR1l2am5EU2tuTWpieFJiVHpE?=
 =?utf-8?B?NWRvU1Zwbm1aai9iQXB5T20xY0FkRmxuR29sYnZiQUo0dTIyVTNKRTI1cFdR?=
 =?utf-8?B?cWJIVEgxZlhRKzJTRTF6UFdEbE9qVlZOTUdkcUpkcUwvZlNPcVB3OGVZY204?=
 =?utf-8?B?aEpKTjRLbEkxTmlibThuVmZpTjQ2VEtwTnVDc0l5ZEx3dnBBU3AzMldtQ0pq?=
 =?utf-8?B?bjRHcStHbTNRclAxYTdCNVA5b1h5dFlOSUtMRUk0RnlDUkYwMlFyd3VOVEpI?=
 =?utf-8?B?MjdtTXdiYzhwWnIzK0YzVVBndk15WGxoNU9LYW0rbC9LSWhyenRXR2RrdGIr?=
 =?utf-8?B?Z2dHS00zckx6WVNxamJ6OXFZRGFJNmpoZjl0aDB0TVBQQ2ZTL09aRU8xWmpL?=
 =?utf-8?B?a0J2MG5FUVhCQ1hTdVdZd29lTmw4Mldab21uL1ZESFc5dFYvaVcwSWJhY1Zv?=
 =?utf-8?B?RGpEcW10aS94cVhyQnhmcTEwMVdsbzc4SlVCaXdOZjR2Z1B2NkFTalQ2UDcw?=
 =?utf-8?B?NFZCOXZDMzVUZ2hxQklLWGpVayt1OWREc1VXKytRenRDUEhKaU0yVHE4UExS?=
 =?utf-8?B?TTRDWGZMTE5wcm0zRkhRZEsxcnhWMGlwbjRoNi8vN3VUSHM3MUt5UzZUMCtO?=
 =?utf-8?B?MTM2UVVadWxUc3FBREVkZG04UzdSTk1jNnVqa3p2Z0k0T2xGeElrWVlnOVpE?=
 =?utf-8?B?b0VEZk9IYzN1T3R2L1VsbllJVEJQNWwyNVdtYnNvM1ZEenBsNC9MbGlUSHBZ?=
 =?utf-8?B?dnNMOWs3djV5SzR2b3lHTUM1L3ljZ1VJWkZjbEpSbHB1L0hPUEU1Zi9sRlRj?=
 =?utf-8?B?N3RqVzRmNnRlTVhoM1BxVFRIYjJleUR5Y1RYSURxWmEzUWpBaFc2U0IvcWth?=
 =?utf-8?B?YWZUSmdtcGRJNGI3emdGQjdpRHNkZmVycFZpcjVTYUIxT0tWUTNjaVhKTVE4?=
 =?utf-8?B?UFRWVDM5RHVYY3U0QkhrY3p5bDE1MXBPMjVGcHVXcEF2UGFZeEtDaVIzYjF0?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD116E8ECB588842B518F29BD2D7B227@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db16025-f05a-4e7b-e015-08dbe57433de
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 00:45:45.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pol/O7brR+TL8iMxPDZ80xe9sgnU2zD0joXMp/uayRcoHGy87mC8C6RJh99ONqsY+nUNs37+Aka3it/oVqi2mN/bmgmV74dSaGiQYmGNros=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4882
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTE0IGF0IDIwOjA1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOgo+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYyBiL2FyY2gveDg2L2tlcm5lbC9zaHN0
ay5jCj4gaW5kZXggNTllMTVkZDhkMGY4Li43ZmZlOTAwMTA1ODcgMTAwNjQ0Cj4gLS0tIGEvYXJj
aC94ODYva2VybmVsL3Noc3RrLmMKPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvc2hzdGsuYwo+IEBA
IC0xOTEsMTggKzE5MSwzOCBAQCB2b2lkIHJlc2V0X3RocmVhZF9mZWF0dXJlcyh2b2lkKQo+IMKg
wqDCoMKgwqDCoMKgwqBjdXJyZW50LT50aHJlYWQuZmVhdHVyZXNfbG9ja2VkID0gMDsKPiDCoH0K
PiDCoAo+IC11bnNpZ25lZCBsb25nIHNoc3RrX2FsbG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRzaywKPiB1bnNpZ25lZCBsb25nIGNsb25lX2ZsYWdzLAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB1bnNpZ25lZCBsb25nIHN0YWNrX3NpemUpCj4gK3Vuc2lnbmVkIGxvbmcgc2hzdGtf
YWxsb2NfdGhyZWFkX3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLAo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBjb25zdCBzdHJ1Y3Qga2VybmVsX2Nsb25lX2FyZ3MKPiAqYXJncykKPiDCoHsKPiDC
oMKgwqDCoMKgwqDCoMKgc3RydWN0IHRocmVhZF9zaHN0ayAqc2hzdGsgPSAmdHNrLT50aHJlYWQu
c2hzdGs7Cj4gK8KgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBjbG9uZV9mbGFncyA9IGFyZ3Mt
PmZsYWdzOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGFkZHIsIHNpemU7Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgLyoKPiDCoMKgwqDCoMKgwqDCoMKgICogSWYgc2hhZG93IHN0YWNr
IGlzIG5vdCBlbmFibGVkIG9uIHRoZSBuZXcgdGhyZWFkLCBza2lwIGFueQo+IC3CoMKgwqDCoMKg
wqDCoCAqIHN3aXRjaCB0byBhIG5ldyBzaGFkb3cgc3RhY2suCj4gK8KgwqDCoMKgwqDCoMKgICog
aW1wbGljaXQgc3dpdGNoIHRvIGEgbmV3IHNoYWRvdyBzdGFjayBhbmQgcmVqZWN0IGF0dGVtcHRz
Cj4gdG8KPiArwqDCoMKgwqDCoMKgwqAgKiBleHBsY2lpdGx5IHNwZWNpZnkgb25lLgo+IMKgwqDC
oMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWZlYXR1cmVzX2VuYWJsZWQoQVJD
SF9TSFNUS19TSFNUSykpCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFmZWF0dXJlc19lbmFibGVkKEFS
Q0hfU0hTVEtfU0hTVEspKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChh
cmdzLT5zaGFkb3dfc3RhY2spCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXR1cm4gKHVuc2lnbmVkIGxvbmcpRVJSX1BUUigtRUlOVkFMKTsKPiArCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArwqDCoMKgwqDCoMKg
wqB9Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKgICogSWYgdGhlIHVz
ZXIgc3BlY2lmaWVkIGEgc2hhZG93IHN0YWNrIHRoZW4gZG8gc29tZSBiYXNpYwo+ICvCoMKgwqDC
oMKgwqDCoCAqIHZhbGlkYXRpb24gYW5kIHVzZSBpdC7CoCBUaGUgY2FsbGVyIGlzIHJlc3BvbnNp
YmxlIGZvcgo+ICvCoMKgwqDCoMKgwqDCoCAqIGZyZWVpbmcgdGhlIHNoYWRvdyBzdGFjay4KPiAr
wqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAoYXJncy0+c2hhZG93X3N0YWNr
X3NpemUpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9IGFyZ3MtPnNo
YWRvd19zdGFja19zaXplOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYg
KHNpemUgPCA4KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuICh1bnNpZ25lZCBsb25nKUVSUl9QVFIoLUVJTlZBTCk7CgpXaGF0IGlzIHRoZSBp
bnRlbnRpb24gaGVyZT8gVGhlIGNoZWNrIGluIG1hcF9zaGFkb3dfc3RhY2sgaXMgdG8gbGVhdmUK
c3BhY2UgZm9yIHRoZSB0b2tlbiwgYnV0IGhlcmUgdGhlcmUgaXMgbm8gdG9rZW4uCgpJIHRoaW5r
IGZvciBDTE9ORV9WTSB3ZSBzaG91bGQgbm90IHJlcXVpcmUgYSBub24temVybyBzaXplLiBTcGVh
a2luZyBvZgpDTE9ORV9WTSB3ZSBzaG91bGQgcHJvYmFibHkgYmUgY2xlYXIgb24gd2hhdCB0aGUg
ZXhwZWN0ZWQgYmVoYXZpb3IgaXMKZm9yIHNpdHVhdGlvbnMgd2hlbiBhIG5ldyBzaGFkb3cgc3Rh
Y2sgaXMgbm90IHVzdWFsbHkgYWxsb2NhdGVkLgohQ0xPTkVfVk0gfHwgQ0xPTkVfVkZPUksgd2ls
bCB1c2UgdGhlIGV4aXN0aW5nIHNoYWRvdyBzdGFjay4gU2hvdWxkIHdlCnJlcXVpcmUgc2hhZG93
X3N0YWNrX3NpemUgYmUgemVybyBpbiB0aGlzIGNhc2UsIG9yIGp1c3QgaWdub3JlIGl0PyBJJ2QK
bGVhbiB0b3dhcmRzIHJlcXVpcmluZyBpdCB0byBiZSB6ZXJvIHNvIHVzZXJzcGFjZSBkb2Vzbid0
IHBhc3MgZ2FyYmFnZQppbiB0aGF0IHdlIGhhdmUgdG8gYWNjb21tb2RhdGUgbGF0ZXIuIFdoYXQg
d2UgY291bGQgcG9zc2libHkgbmVlZCB0byBkbwphcm91bmQgdGhhdCB0aG91Z2gsIEknbSBub3Qg
c3VyZS4gV2hhdCBkbyB5b3UgdGhpbms/Cgo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSBhcmdzLT5zdGFja19zaXplOwo+ICvC
oMKgwqDCoMKgwqDCoH0KPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqAvKgo+IMKgwqDCoMKgwqDCoMKg
wqAgKiBGb3IgQ0xPTkVfVkZPUksgdGhlIGNoaWxkIHdpbGwgc2hhcmUgdGhlIHBhcmVudHMgc2hh
ZG93Cj4gc3RhY2suCj4gQEAgLTIyMiw3ICsyNDIsNyBAQCB1bnNpZ25lZCBsb25nIHNoc3RrX2Fs
bG9jX3RocmVhZF9zdGFjayhzdHJ1Y3QKPiB0YXNrX3N0cnVjdCAqdHNrLCB1bnNpZ25lZCBsb25n
IGNsCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghKGNsb25lX2ZsYWdzICYgQ0xPTkVfVk0pKQo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqAKPiAtwqDCoMKgwqDC
oMKgwqBzaXplID0gYWRqdXN0X3Noc3RrX3NpemUoc3RhY2tfc2l6ZSk7Cj4gK8KgwqDCoMKgwqDC
oMKgc2l6ZSA9IGFkanVzdF9zaHN0a19zaXplKHNpemUpOwo+IMKgwqDCoMKgwqDCoMKgwqBhZGRy
ID0gYWxsb2Nfc2hzdGsoMCwgc2l6ZSwgMCwgZmFsc2UpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
SVNfRVJSX1ZBTFVFKGFkZHIpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIGFkZHI7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2NoZWQvdGFzay5oIGIvaW5j
bHVkZS9saW51eC9zY2hlZC90YXNrLmgKPiBpbmRleCBhMjNhZjIyNWM4OTguLjk0ZTdjZjYyYmU1
MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NjaGVkL3Rhc2suaAo+ICsrKyBiL2luY2x1
ZGUvbGludXgvc2NoZWQvdGFzay5oCj4gQEAgLTQxLDYgKzQxLDggQEAgc3RydWN0IGtlcm5lbF9j
bG9uZV9hcmdzIHsKPiDCoMKgwqDCoMKgwqDCoMKgdm9pZCAqZm5fYXJnOwo+IMKgwqDCoMKgwqDC
oMKgwqBzdHJ1Y3QgY2dyb3VwICpjZ3JwOwo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3NzX3Nl
dCAqY3NldDsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHNoYWRvd19zdGFjazsKCldh
cyB0aGlzIF4gbGVmdCBpbiBhY2NpZGVudGFsbHk/IEVsc2V3aGVyZSBpbiB0aGlzIHBhdGNoIGl0
IGlzIGdldHRpbmcKY2hlY2tlZCB0b28uCgo+ICvCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcg
c2hhZG93X3N0YWNrX3NpemU7Cj4gwqB9Owo+IMKgCj4gwqAvKgo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvc2NoZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9zY2hlZC5oCj4gaW5k
ZXggM2JhYzBhOGNlYWIyLi5hOTk4YjZkMGM4OTcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBp
L2xpbnV4L3NjaGVkLmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvc2NoZWQuaAo+IEBAIC04
NCw2ICs4NCw4IEBACj4gwqAgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZXJuZWwn
cyBsaW1pdCBvZiBuZXN0ZWQgUElEIG5hbWVzcGFjZXMuCj4gwqAgKiBAY2dyb3VwOsKgwqDCoMKg
wqDCoCBJZiBDTE9ORV9JTlRPX0NHUk9VUCBpcyBzcGVjaWZpZWQgc2V0IHRoaXMgdG8KPiDCoCAq
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGEgZmlsZSBkZXNjcmlwdG9yIGZvciB0aGUg
Y2dyb3VwLgo+ICsgKiBAc2hhZG93X3N0YWNrX3NpemU6IFNwZWNpZnkgdGhlIHNpemUgb2YgdGhl
IHNoYWRvdyBzdGFjayB0bwo+IGFsbG9jYXRlCj4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb3IgdGhlIGNoaWxkIHByb2Nlc3MuCj4gwqAgKgo+IMKgICogVGhl
IHN0cnVjdHVyZSBpcyB2ZXJzaW9uZWQgYnkgc2l6ZSBhbmQgdGh1cyBleHRlbnNpYmxlLgo+IMKg
ICogTmV3IHN0cnVjdCBtZW1iZXJzIG11c3QgZ28gYXQgdGhlIGVuZCBvZiB0aGUgc3RydWN0IGFu
ZAo+IEBAIC0xMDEsMTIgKzEwMywxNCBAQCBzdHJ1Y3QgY2xvbmVfYXJncyB7Cj4gwqDCoMKgwqDC
oMKgwqDCoF9fYWxpZ25lZF91NjQgc2V0X3RpZDsKPiDCoMKgwqDCoMKgwqDCoMKgX19hbGlnbmVk
X3U2NCBzZXRfdGlkX3NpemU7Cj4gwqDCoMKgwqDCoMKgwqDCoF9fYWxpZ25lZF91NjQgY2dyb3Vw
Owo+ICvCoMKgwqDCoMKgwqDCoF9fYWxpZ25lZF91NjQgc2hhZG93X3N0YWNrX3NpemU7Cj4gwqB9
Owo+IMKgI2VuZGlmCj4gwqAKPiDCoCNkZWZpbmUgQ0xPTkVfQVJHU19TSVpFX1ZFUjAgNjQgLyog
c2l6ZW9mIGZpcnN0IHB1Ymxpc2hlZCBzdHJ1Y3QgKi8KPiDCoCNkZWZpbmUgQ0xPTkVfQVJHU19T
SVpFX1ZFUjEgODAgLyogc2l6ZW9mIHNlY29uZCBwdWJsaXNoZWQgc3RydWN0ICovCj4gwqAjZGVm
aW5lIENMT05FX0FSR1NfU0laRV9WRVIyIDg4IC8qIHNpemVvZiB0aGlyZCBwdWJsaXNoZWQgc3Ry
dWN0ICovCj4gKyNkZWZpbmUgQ0xPTkVfQVJHU19TSVpFX1ZFUjMgOTYgLyogc2l6ZW9mIGZvdXJ0
aCBwdWJsaXNoZWQgc3RydWN0ICovCj4gwqAKPiDCoC8qCj4gwqAgKiBTY2hlZHVsaW5nIHBvbGlj
aWVzCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCj4gaW5kZXgg
MTA5MTdjM2UxZjAzLi5iMGRmNjljODE4NWUgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2ZvcmsuYwo+
ICsrKyBiL2tlcm5lbC9mb3JrLmMKPiBAQCAtMzA2Nyw3ICszMDY3LDkgQEAgbm9pbmxpbmUgc3Rh
dGljIGludAo+IGNvcHlfY2xvbmVfYXJnc19mcm9tX3VzZXIoc3RydWN0IGtlcm5lbF9jbG9uZV9h
cmdzICprYXJncywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIENM
T05FX0FSR1NfU0laRV9WRVIxKTsKPiDCoMKgwqDCoMKgwqDCoMKgQlVJTERfQlVHX09OKG9mZnNl
dG9mZW5kKHN0cnVjdCBjbG9uZV9hcmdzLCBjZ3JvdXApICE9Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDTE9ORV9BUkdTX1NJWkVfVkVSMik7Cj4gLcKgwqDCoMKg
wqDCoMKgQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgY2xvbmVfYXJncykgIT0KPiBDTE9ORV9B
UkdTX1NJWkVfVkVSMik7Cj4gK8KgwqDCoMKgwqDCoMKgQlVJTERfQlVHX09OKG9mZnNldG9mZW5k
KHN0cnVjdCBjbG9uZV9hcmdzLAo+IHNoYWRvd19zdGFja19zaXplKSAhPQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBDTE9ORV9BUkdTX1NJWkVfVkVSMyk7Cj4gK8Kg
wqDCoMKgwqDCoMKgQlVJTERfQlVHX09OKHNpemVvZihzdHJ1Y3QgY2xvbmVfYXJncykgIT0KPiBD
TE9ORV9BUkdTX1NJWkVfVkVSMyk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHVubGlrZWx5
KHVzaXplID4gUEFHRV9TSVpFKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAtRTJCSUc7Cj4gQEAgLTMxMTAsNiArMzExMiw3IEBAIG5vaW5saW5lIHN0YXRpYyBpbnQK
PiBjb3B5X2Nsb25lX2FyZ3NfZnJvbV91c2VyKHN0cnVjdCBrZXJuZWxfY2xvbmVfYXJncyAqa2Fy
Z3MsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAudGxzwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgPSBhcmdzLnRscywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5z
ZXRfdGlkX3NpemXCoMKgwqA9IGFyZ3Muc2V0X3RpZF9zaXplLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLmNncm91cMKgwqDCoMKgwqDCoMKgwqDCoD0gYXJncy5jZ3JvdXAsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5zaGFkb3dfc3RhY2tfc2l6ZcKgwqDCoMKg
wqDCoD0gYXJncy5zaGFkb3dfc3RhY2tfc2l6ZSwKPiDCoMKgwqDCoMKgwqDCoMKgfTsKPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoYXJncy5zZXRfdGlkICYmCj4gQEAgLTMxNTAsNiArMzE1Mywy
MyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgY2xvbmUzX3N0YWNrX3ZhbGlkKHN0cnVjdAo+IGtlcm5l
bF9jbG9uZV9hcmdzICprYXJncykKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7Cj4gwqB9
Cj4gwqAKPiArLyoqCj4gKyAqIGNsb25lM19zaGFkb3dfc3RhY2tfdmFsaWQgLSBjaGVjayBhbmQg
cHJlcGFyZSBzaGFkb3cgc3RhY2sKPiArICogQGthcmdzOiBrZXJuZWwgY2xvbmUgYXJncwo+ICsg
Kgo+ICsgKiBWZXJpZnkgdGhhdCBzaGFkb3cgc3RhY2tzIGFyZSBvbmx5IGVuYWJsZWQgaWYgc3Vw
cG9ydGVkLgo+ICsgKi8KPiArc3RhdGljIGlubGluZSBib29sIGNsb25lM19zaGFkb3dfc3RhY2tf
dmFsaWQoc3RydWN0Cj4ga2VybmVsX2Nsb25lX2FyZ3MgKmthcmdzKQo+ICt7Cj4gKyNpZmRlZiBD
T05GSUdfQVJDSF9IQVNfVVNFUl9TSEFET1dfU1RBQ0sKPiArwqDCoMKgwqDCoMKgwqAvKiBUaGUg
YXJjaGl0ZWN0dXJlIG11c3QgY2hlY2sgc3VwcG9ydCBvbiB0aGUgc3BlY2lmaWMKPiBtYWNoaW5l
ICovCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7Cj4gKyNlbHNlCj4gK8KgwqDCoMKgwqDC
oMKgLyogVGhlIGFyY2hpdGVjdHVyZSBkb2VzIG5vdCBzdXBwb3J0IHNoYWRvdyBzdGFja3MgKi8K
PiArwqDCoMKgwqDCoMKgwqByZXR1cm4gIWthcmdzLT5zaGFkb3dfc3RhY2tfc2l6ZTsKPiArI2Vu
ZGlmCgpUaGlzIG1pZ2h0IGJlIHNpbXBsZXI6CglyZXR1cm4gSVNfRU5BQkxFRChDT05GSUdfQVJD
SF9IQVNfVVNFUl9TSEFET1dfU1RBQ0spIHx8CgkgICAgICAgIWthcmdzLT5zaGFkb3dfc3RhY2tf
c2l6ZTsKCj4gK30KPiArCj4gwqBzdGF0aWMgYm9vbCBjbG9uZTNfYXJnc192YWxpZChzdHJ1Y3Qg
a2VybmVsX2Nsb25lX2FyZ3MgKmthcmdzKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqAvKiBWZXJp
ZnkgdGhhdCBubyB1bmtub3duIGZsYWdzIGFyZSBwYXNzZWQgYWxvbmcuICovCj4gQEAgLTMxNzIs
NyArMzE5Miw3IEBAIHN0YXRpYyBib29sIGNsb25lM19hcmdzX3ZhbGlkKHN0cnVjdAo+IGtlcm5l
bF9jbG9uZV9hcmdzICprYXJncykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGthcmdzLT5leGl0
X3NpZ25hbCkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBmYWxzZTsK
PiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmICghY2xvbmUzX3N0YWNrX3ZhbGlkKGthcmdzKSkKPiAr
wqDCoMKgwqDCoMKgwqBpZiAoIWNsb25lM19zdGFja192YWxpZChrYXJncykgfHwKPiAhY2xvbmUz
X3NoYWRvd19zdGFja192YWxpZChrYXJncykpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gZmFsc2U7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHRydWU7Cj4g
Cgo=

