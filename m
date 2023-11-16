Return-Path: <linux-kselftest+bounces-230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C07EE6C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 19:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6010CB20A3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762EECA;
	Thu, 16 Nov 2023 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlJc4CB2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B401A8;
	Thu, 16 Nov 2023 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700159637; x=1731695637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cWUQ7IyVpeHuvBoz4/2Z8JbFOcNMJ4jTK+AHC9LaIlc=;
  b=dlJc4CB2ujLGMYmmKuIQjiWpDV4ecUd/PZUFKoeeKDaFspmDcz09eWnC
   wGFWK9VGtie1J3/RQmZkIqJ6RJPBtLKXRbD88fsc28c1ntEUnL0YIWXDD
   K1zQmQ+g1KekFBQXrn732rhPI2L+ETi/3yzV6yahDdqaNfqX2y7qL67Hm
   ju0q2XCs493jmfskQ/GePi37eLQzCuys+BI8mnUiO9wyylg6WVF/PahMB
   N1NA4Nv9LDiUGcmGc4Lh6l2yMewobQxywg6m6U85pUNqeOfGqOsQ/ZEiG
   n/wyP/0Yj+iO1aDoGW9qt1oBoB2JLGdYIoJBqKCvYAPxKhfatyn2q3MNM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4229334"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="4229334"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 10:33:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="758919968"
X-IronPort-AV: E=Sophos;i="6.04,204,1695711600"; 
   d="scan'208";a="758919968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 10:33:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 10:33:50 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 10:33:50 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 10:33:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bERQ6kBIQ7LHZ1vD8oh0xWL+kCjEBlk1/0s5gKbUqbCcHErmyK4Mba9hKrFgRgPQLMZC8QdwystXUrn3xVD65SjXPdjn5Uf+QgldNozRnbq0imifdgqmlez+o8UfPlmyVKpmw324LB/nV9K5GcyVQzVDK5/XxDR3DvJfzBay18gkwgVprB6jxygKJs9EbkJwBGymBOdkZIgTiNLc3WAb/ZNqVuv/eE9vTCSS7oanFxXqnwrrOS6jfc5WhCOlkol2evEywxyFaackxKmHl0DmIpeuOwmXsJE/CWWzYhInFsUjrTJRkDxV/k1i0nyasLQFNt2j7RoBYrckZ0vuuyobrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWUQ7IyVpeHuvBoz4/2Z8JbFOcNMJ4jTK+AHC9LaIlc=;
 b=cmMtEogXe8pNBtkH9sKDOFreBmvzTa8NUsyMbl0TZGo0jhNe0g4YFqVXOwVLRqH/3vnwzPQuWTtmQHUov0RlWlwv4wrCkwLjsIVyaHNUkS0ccpNp5KAN+fMWZbtAD8PeFvX+/UFdmCjNTsI7BU5scqbr3HM6jQW5JqlI/DuB2Vw0zoY3Z2V0XgyUASS5DKzrnDNYFnbHrGeOS7Lu7hCjjcWaAQdAJBR/RaAYUu+yQtZuXKwkHYvM8KJsQtsMP6LTFozg3AU/sDB9G+R4jSybtNNdDPGLuHR4dQec/5DXn8eO9Ufgi6LccurIsOP4b+9AfFnxUrv6ri65gQEC5ItnCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Thu, 16 Nov
 2023 18:33:47 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 18:33:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Pandey, Sunil K"
	<sunil.k.pandey@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to
 clone3()
Thread-Index: AQHaFzYai+mxslqXM0i150aoxWGrvrB6i7UAgADGr4CAAD5nAIAAKB6AgABm6gCAASMjgIAABXqA
Date: Thu, 16 Nov 2023 18:33:47 +0000
Message-ID: <282e637f136b80b352e261514c4102266e92c112.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
	 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
	 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
	 <ZVTvvJTOV777UGsP@arm.com>
	 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
	 <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
	 <2b4b935e-aea1-4283-a459-5d6004b24b28@sirena.org.uk>
In-Reply-To: <2b4b935e-aea1-4283-a459-5d6004b24b28@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ1PR11MB6251:EE_
x-ms-office365-filtering-correlation-id: 3c7a969c-77f9-4cf9-2ed6-08dbe6d2924b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3jjFQAGvw5l/5slosmsA9rHfVOLUwqZqwLrU2oXRFD2ON12WBfBMJgsD261nP6XDFWdrbMKyVlooi2Nf2muw3Mfu844XCohIfRUUgKaOYuIh+yN405LgKxB6LGkELnKxo/6sqA+NIIagd6f7sr5x8lLzTOD68nvW5DDZl1IJq6NiIuaxvSOEi1EMpa59a3p6J1CBOYnERVySmLLzb4EHS0fV+O+w2QiKcsH9jDiEusX0kEBwi5KfGN4t2hePL4Gat83yBa9QUPhd6fS+5rYlQ84tptd6rSZAJMrHl+3b6KNVdDGOb3RmmubFKo0G31g6IY8w4Twa1laxr5Drin+ujClUvSWO2yeEJjoDvrviK1O1LhTwEaI3zRa/I31s/nxaVxSD7O1JIfyrMSx1CnQoR80sG8oY79G+wOsy5UgO8uesHMN/mi+6AbOXoesI7cNkF8w69Ulhrs5sYXzWTrUMoYYUG+vTTA0DISLAOA2rnEqY51ROEz/vb6PdRBz/duc+gIRF+nQJbyz2feiqneKZ0rrHDOQU203sjjMu0J4CvE5j0E+Uptaz/WN4Fb8FrQ8claoxtij+vjPAsm38MVeHw+91ROzoZD5IOPZYiWYSFsdd666kLoeHPJAuUTYUXDb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(6506007)(2616005)(36756003)(4326008)(8676002)(2906002)(8936002)(82960400001)(26005)(41300700001)(38100700002)(6512007)(478600001)(71200400001)(66556008)(316002)(4001150100001)(91956017)(66946007)(54906003)(66476007)(64756008)(6916009)(66446008)(76116006)(6486002)(86362001)(7416002)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnpESXdyeXJKbE1UQW1Va2VtaWQ3dm9hbEp1amJOTm0xaVdPVXZuZWUrK1Nx?=
 =?utf-8?B?WFMzaUVVRWlPbU1qS3VvS2swb0Y1MUdlWVE4d1dMRWFmeGNQYlVEWlpBWmdj?=
 =?utf-8?B?NkcvMitlTnc4ZGdCbTA3L1Q2T3RvYzJHMEJ3ajh2cGJENzRsRzJUdzduOU5m?=
 =?utf-8?B?R0JZQlpOOEVjTk82elcvZ3g5bklCbUhnSXpyRkNpS3dDR3R4M0wvYXpsbDlJ?=
 =?utf-8?B?aDkxODhnbWtvTHpybFpSZHZUaUh3amEvUGZhNTZBY0lDQWtCUkJtNElxaTU2?=
 =?utf-8?B?ekFicVlFMkk5empzWkZ0Uk5QUzZpcjN1VzJTSUcwTitMYmRleWVjMlBXeW5R?=
 =?utf-8?B?NHZBKzdPUzJWem51cWxoUDlxOEY1MXJRTkhxbytJbTA1SCtVWWJ0T2w5YWZ2?=
 =?utf-8?B?Z2tVQ3VrTUJCZHJobDNnWUs2YlZyZkdNL081SlNWKzJ3YTZBK0dhSEVtaVZI?=
 =?utf-8?B?R3VhVi8xZnROWDBJUVRMYVlIVmFEVnVvTmtDZlY5bXM5NG9uZUEvMFM0THR0?=
 =?utf-8?B?aVlkMlhOV2NoSE1JQ3RScHJnVENvVG83b1FEalhEYkVzMm9tZTJkbXZpeXJh?=
 =?utf-8?B?eHFDTk9hRXlHYzhNamt1RVpVL1NOZWFiSklxK3FNaWQ0NlVQanNiTVlnaFVj?=
 =?utf-8?B?dm9ubDJnd21LTHA3dlp0OGtLWHc1cGswK2tYMEkzL29TT3NWS1RIWVlqUGs0?=
 =?utf-8?B?cDlQbHV0d3E4U1VEVXpySDVhc0xydWVIWlBVdUMzbXEyNFgvRlRONGR6ZjFa?=
 =?utf-8?B?QVNza1BaS1l1TS9XTmc4OUJYRG9VTU5lbnZRODRMSER1KzhDcXFKMHNvK08z?=
 =?utf-8?B?dGRlM2JOOVlZUUxlTkloYU9vREU2cHNhRjNRK0xQTVZlSUp2ejBVSk5aSkVR?=
 =?utf-8?B?aFlRWDh4T1c1TitsRGxzK1J1czhOMGxRcGRtWjdzWTd5dHVUNjRYYjR6MzBK?=
 =?utf-8?B?RmlSSXExSnRyZ09zLzEzL0w5eFV6NzIyNzFZRUVsbENqOWJNZ3JWUVJsMDl4?=
 =?utf-8?B?eGpjcE5Zd3dlOUg0ellWYmx4TnZKWUJKZU5mOTRHSzVCNWF6TkxxRjB5cGFq?=
 =?utf-8?B?cUp6YnhyYlRGckJkZ1N0Vy9NQklERHp5RzF6ZXZrbHZ5bkpRTmVUYnE2b0p0?=
 =?utf-8?B?RC9oZiszUk5qaXJIVE9KT25mVVdBcHpTcXdvUWFRS2pNZmV4aWl3Q2R3TlA5?=
 =?utf-8?B?VEQzeUxtYmJYRlF0NmwxTzdPYW5uQ2RIY0NmNVZpZVJJODBQN1IxcVJsM1Nw?=
 =?utf-8?B?TDZWVU5OdzVvT1FPNWJ1b0V4U2lVRlk3R1lNc3FLSkZOaWRMem5SaDB4N0hF?=
 =?utf-8?B?aFJHQ2tzb25vandvL2dpeE9RczNaNEFjMWpGYk8wcCtRM2lMTlZ3cHJYT0o0?=
 =?utf-8?B?TXluUFd6em9mTWZFOUg2NUl0NDlaVG51WVM3dGwvUDhNZjlUc1A2aEtZY3E4?=
 =?utf-8?B?WkplZm4vank5RUFhZG1jTGVDbVQwanh1R0szWjFjVlpaRTRWZ3JseVF1dXRL?=
 =?utf-8?B?T1FQdW53Q1VINlVLZFF2WDVuQnh1UmFoZndUbENKc1hDQkZPSCtlMWFTTkJG?=
 =?utf-8?B?QWNDSTZYb2hPN29GN1l4WjYydllpckUvNXU1c3A4WEpVek9pZ0tqQyswMi9M?=
 =?utf-8?B?WEo5WUp1U1d4Rk1rSUY2RHYveHV0KzNtWHpVNUhvQ2VsSkYxU1VndDlBSXRM?=
 =?utf-8?B?OTE0bUZLclk1RjlqOVBMQk5qdnJTRVR5UXoxWG5yV3ZMcGNYT3JMSUpMUFNv?=
 =?utf-8?B?NDJuKzgrSFJHcUNPRFIvNlBNSUg4MjVoYWxoM2E5YmdUSjVuT09iK0gxL2xp?=
 =?utf-8?B?c3A0UUhzS003SkVhbFlUd1lCWFYrc2xhUjR6VU5aUCtuWWx2Q1NDZmo2ZlpM?=
 =?utf-8?B?ZVhSbzQyckI5aUtTeVJpemRER2xIa2FJWFplUGZ2OWkzRlE5Y2xDaWdqZEFE?=
 =?utf-8?B?UUY4OFRqcTNKejlVb1NDajFobitwRFhEL3Q4YUNvMWtrbDRlYlp5SGVPV1da?=
 =?utf-8?B?ZEdUQ0lhVVNSQ08zWWUxRlhIV2dxcFQwN0VZOFl0Rlh5YWhZU2FEQVdVYm53?=
 =?utf-8?B?WENzMmxWQUI2UnBPMzhSUVFTUVdITmJqY212c2s3WEo0Z2hiMkE2RHBxbmVt?=
 =?utf-8?B?QjFscXVtWlV1Zk1NV2VQTEZpYm9pY1gzdHl2OHhKdUg3OUt5WWRHUmppNTVI?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9338E32740CCE4A8CEFF5AFB0AD066F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a969c-77f9-4cf9-2ed6-08dbe6d2924b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 18:33:47.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LoVWqT2HYxaC4M3jNnzSk52MeOzmifvQGPOD2M8xMiD8URNsyGaPHVuPNLE5mL+NHRdH8NHoeQzTNiXGObSKDyuz/CVY74PiNl+sS5YTp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDIzLTExLTE2IGF0IDE4OjE0ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBUaHUsIE5vdiAxNiwgMjAyMyBhdCAxMjo1MjowOUFNICswMDAwLCBFZGdlY29tYmUsIFJpY2sg
UCB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjMtMTEtMTUgYXQgMTg6NDMgKzAwMDAsIE1hcmsgQnJv
d24gd3JvdGU6DQo+ID4gPiA+IGVuZCBtYXJrZXIgdG9rZW4gKDApIG5lZWRzIGl0IGkgZ3Vlc3Mu
DQo+IA0KPiA+ID4geDg2IGRvZXNuJ3QgY3VycmVudGx5IGhhdmUgZW5kIG1hcmtlcnMuwqAgQWN0
dWFsbHksIHRoYXQncyBhIHBvaW50DQo+ID4gPiAtDQo+ID4gPiBzaG91bGQgd2UgYWRkIGEgZmxh
ZyBmb3Igc3BlY2lmeWluZyB0aGUgdXNlIG9mIGVuZCBtYXJrZXJzIGhlcmU/DQo+ID4gPiBUaGVy
ZSdzIGNvZGUgaW4gbXkgbWFwX3NoYWRvd19zdGFjaygpIGltcGxlbWVudGF0aW9uIGZvciBhcm02
NA0KPiA+ID4gd2hpY2gNCj4gPiA+IGRvZXMgdGhhdC4NCj4gDQo+ID4gSG1tLCBJIGd1ZXNzIHRo
ZXJlIGlzbid0IGEgd2F5IHRvIHBhc3MgYSBmbGFnIGZvciB0aGUgaW5pdGlhbCBleGVjDQo+ID4g
c3RhY2s/IFNvIHByb2JhYmx5IGl0IHNob3VsZCBqdXN0IG1pcnJvciB0aGF0IGJlaGF2aW9yLiBV
bmxlc3MgeW91DQo+ID4gdGhpbmsgYSBsb3Qgb2YgcGVvcGxlIHdvdWxkIGxpa2UgdG8gc2tpcCB0
aGUgZGVmYXVsdCBiZWhhdmlvci4NCj4gDQo+IEkgZG9uJ3QgcmVhbGx5IGtub3cgdGhhdCBhbnlv
bmUgd291bGQgcGFydGljdWxhcmx5IHdhbnQgdG8gdXNlIGEgZmxhZw0KPiBvbg0KPiBhcm02NCwg
SSB3YXMgbW9yZSB0aGlua2luZyBmb3IgdGhlIGJlbmVmaXQgb2YgeDg2IHdoZXJlIGFueQ0KPiB0
ZXJtaW5hdGlvbg0KPiByZWNvcmQgd291bGQgYmUgYSBjaGFuZ2UuwqAgSXQncyBjZXJ0YWlubHkg
ZWFzaWVyIHRvIG5vdCBoYXZlIGZsYWdzIHNvDQo+IEknbSBtb3JlIHRoYW4gaGFwcHkgdG8gbGVh
dmUgdGhpbmdzIGFzIHRoZXkgYXJlLCB0aGVyZSdzIG5vdGhpbmcNCj4gc3RvcHBpbmcgZnVydGhl
ciBleHRlbnNpb25zIG9mIHRoZSBBQkkgaWYgd2UgZGVjaWRlIHdlIHdhbnQgdGhlbQ0KPiBsYXRl
ci4NCg0KSSdtIGhvcGluZyB0aGF0IHNoaWZ0aW5nIHRoZSBzaGFkb3cgc3RhY2sgc3RhcnQgYnkg
b25lIGZyYW1lIGZvciB0aHJlYWQNCnN0YWNrcyAod2hlcmUgdGhlcmUgaXMgbm8gdG9rZW4gdG8g
ZmluZCkgd2lsbCBub3QgZGlzdHVyYiBhbnl0aGluZy4gQnV0DQpmb3IgeDg2LCB3ZSB3aWxsIG5l
ZWQgYSBuZXcgZWxmIGJpdCB0byBiZSBmdWxseSBzYWZlIGluIGltcGxlbWVudGluZw0KYWx0IHNo
YWRvdyBzdGFjay4gV2hlbiB3ZSBkbyB0aGF0IHdlIHdpbGwgaGF2ZSBhIGNoYW5jZSB0byBhZGQg
YW4gZW5kDQpvZiBzdGFjayBtYXJrZXIgd2l0aG91dCBjb21wYXRpYmlsaXR5IGlzc3VlcyBvbiB4
ODYuIFNvIGp1c3QgZG9pbmcNCmRlZmF1bHQgYmVoYXZpb3Igc2VlbXMgZmluZS4NCg0KRm9yIG1h
cF9zaGFkb3dfc3RhY2ssIHRoZSBlbmQgb2Ygc3RhY2sgbWFya2VyIHdpbGwgc2hpZnQgdGhlIHRv
a2VuLA0Kd2hpY2ggdXNlcnNwYWNlIG5lZWRzIHRvIGZpbmQsIHNvIHRoYXQgaXMgd2h5IEkgd2Fu
dGVkIGEgZmxhZyBmb3IgdGhhdC4NCkFwcHJlY2lhdGUgdGhlIGNvbnNpZGVyYXRpb24uDQo=

