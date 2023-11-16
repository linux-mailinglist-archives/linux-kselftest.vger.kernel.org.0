Return-Path: <linux-kselftest+bounces-187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DF7ED8B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 01:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A87D1C208E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7161392;
	Thu, 16 Nov 2023 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGUrPUNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AB1B5;
	Wed, 15 Nov 2023 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700095935; x=1731631935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9f9/u2C1Wb1Qd11tMIB7i7HiJJPlOZGxbzT4kb1kHkI=;
  b=AGUrPUNWYZ11XvXy9vCgQwxA1gcP2pW4zjZ+yuNE0nLChYUYmcZdX64F
   Babkq+WgVtUqKv47Ea2vmLW0ra4WvE1okZbnethDL4GKprgTN6kPvUHlB
   2787PXSJf1P7x8laDfkgAu1SOdWy+5p4tUH6WUtSloN6hWPsPUk0mu28J
   UEQ5qloiuAiAOJevtvAN+306RaaLKl5AnQ2vds+636kxBMLOJCqhyXDfB
   0CzV0dUgzcy8F8UGf4W72q+guvzYtivRfERaWZ2RV9ne7zdrY1zHbsJsn
   ufZlhC2AM8PM8h3HBQTsSicx86qMOkY+CGyBNB/f56dDx/RWvj04A711d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4062120"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="4062120"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 16:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="6341804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 16:52:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 16:52:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 16:52:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 16:52:13 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 16:52:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWW0Hub97LY5imQJLVYQor04A0Imx0vxmYV0W0BwTEl0Uk1sRAvbH+78fiNnA4LY+dEL7ol2JXUe7upkuAbiazprv2/SIDAvxSrzevDhWFX0HNV/gGjrEJNxRaVvjnV243zl1xOyE4ncmcF97ZWYQCBRgGf+fF46ACEUfQdvBndYWu2oDHH5SVFK0piaRJNUYJ812Z5e16H+/qRYZb6Lwf+7GbJqlKSBpIYcV10JW0E3yME1V6ZQAzCyfvdMZqShtjeF8Lt49uB7gRF1CNuPRumTtclp6EY6H70qSbmj704A8fMqzcsxY/uo0+eZYwzRleTWYtRFesVLDnp2kHf63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f9/u2C1Wb1Qd11tMIB7i7HiJJPlOZGxbzT4kb1kHkI=;
 b=IZVrFoDn6FCS407QWNzy9trrUey/2rH3z9F39kT4Eti1pcwnmayBBXfZ/2meY3we5IvkPSo1OEnr9a/YG7wbkbaqRJG3130KQg0FQPZDAcgzG65Y+zBkIX3rzir8mckISPmxPWfTPcyGzVXzRaVkuLj5akdnMqnAl5U6noaaP+EbKi9FWCmBRH9xkdi3LjkBhocdQioSPssRVV8+uV9gnIle7TwCU9XcCbl1c/uJBaNNBOrp1ZQwElOTAc1uBoVVHNEwACREcH4WDxMZes9NNCz6FltlDkrT+XHvzD6TSz+F50+2MZ+IQz2rL6gYcJVdH2sstioiOCj+7lIq+qHGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN6PR11MB8219.namprd11.prod.outlook.com (2603:10b6:208:471::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 00:52:09 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 00:52:09 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de"
	<mgorman@suse.de>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "bristot@redhat.com" <bristot@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "jannh@google.com"
	<jannh@google.com>, "bp@alien8.de" <bp@alien8.de>, "bsegall@google.com"
	<bsegall@google.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "Pandey, Sunil K"
	<sunil.k.pandey@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFC RFT v2 2/5] fork: Add shadow stack support to
 clone3()
Thread-Index: AQHaFzYai+mxslqXM0i150aoxWGrvrB6i7UAgADGr4CAAD5nAIAAKB6AgABm6gA=
Date: Thu, 16 Nov 2023 00:52:09 +0000
Message-ID: <d05d23d56bd2c7de30e7732e6bd3d313d8385c47.camel@intel.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
	 <20231114-clone3-shadow-stack-v2-2-b613f8681155@kernel.org>
	 <c9434fa9d864612ed9082197a601c5002ed86a38.camel@intel.com>
	 <d873072c-e1f4-4e1f-9efc-dfbd53054766@sirena.org.uk>
	 <ZVTvvJTOV777UGsP@arm.com>
	 <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
In-Reply-To: <d90884a0-c4d3-41e9-8f23-68aa87bbe269@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN6PR11MB8219:EE_
x-ms-office365-filtering-correlation-id: 9ab9a6c2-d86b-4fd7-59c8-08dbe63e4320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5y7nyfp1H9lnPB7OY3tyjSFm3PQ4PD2GAIgKWuPiXqMteBupXTQpMPbqpWllcg90d3M9ye43fwf1Th+EbKu1oUbjw9qiNJrDEpEVwyhtdC5Xp4PQuPO+BkrS1eMXosNDcUYFYbTUudP97k6QnGeYbeHY6Mnb3unlCF6lvxXk9l88Zv/PgV0c1N1ETZamiANrjmWQbgOGG53Rq4ke78tOTIFhDhAaqk4/FuRtzAv+0GMurOU4d6apfeqCStIYXELNrEfYPljQhSVOjwImlvRIEMeILQowwVZ7QAbR4QYGmzG7mq6GNy5QAGuTU5tg+Xvxcdg8lNkSptE9FAEpv0nuegOCNXv5ERqsM/VfKDI7HIk19InllVA3Jm2z2gcB70IHExwu5xcIUsYqGaJZf7nIHcZbFQgd6FXC91i3xmwKKsk3MIPgffSl0YDXZRdb4AjNopsd5KMa3eJhVx6ouE9cIfSkHPZSPq0rPcOAdONMDVtryfGonR621iIjCMjrkmbYuRYe5rW6EdO2G4c0JStpvVGBOeVoUQ0C/Vefi5D7xuJx7UBitf1GtTRs7QCQzRKUUsmU2fC1E8glZHVB5HtEKQPYU4DsIkO1ZRr0JJaYaBzmH1sBu245etRrdGpRi8Fn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38070700009)(71200400001)(8676002)(26005)(8936002)(4001150100001)(2906002)(6512007)(4326008)(6506007)(83380400001)(38100700002)(41300700001)(91956017)(82960400001)(7416002)(122000001)(2616005)(5660300002)(110136005)(66446008)(6486002)(76116006)(54906003)(86362001)(36756003)(64756008)(316002)(66556008)(66476007)(66946007)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajhQRFdwZExsYTMwTlZwRVV2QWJvLzl4d085RTJLUnJZdnorNDYxTzFaamd1?=
 =?utf-8?B?QW9TSjZkQkdlYmNjWWVUK2MxczdDU3hCTXNzbW01ckY5RTlsckltTTlLL21B?=
 =?utf-8?B?c1VONlVPYno0bUJ2a1J3Yy80OXcwN05QdnNFQXVxOFJWbnNJVTAzL04zTjZM?=
 =?utf-8?B?cDdySDJOTDF2OGRzenhLZWR4cWtXcWlxKzVUUHZ6T0tGSzBPZ241MXJkaVZY?=
 =?utf-8?B?YWtPQ25kd3JjT280Z0tLaU1YM09xalZkNTJ0UVczVDBGOGpkbXJmL1N5V25O?=
 =?utf-8?B?YnVOc1ZwTThKRTg3M3VaNzRobUsrOElRVzZLaVRHdHpBSlV1Y0NTQ04xaS9h?=
 =?utf-8?B?S0phUDRDV3BGZnFRTkQrV0pSYmlYYU9JeFZQUDBoOWNlMW94Qk1Ta0JhTUUv?=
 =?utf-8?B?KytaTDJNSkZzQlZZa0NaeGxudHV4ejFKdnM2ZFF2aFlyOVJqUUFxcGNWeUN5?=
 =?utf-8?B?UHVkbFNTZkdjR053bFhaZmJjRlN4Y3UwTkNWeENYSG54c1hxS2FweWRDUENp?=
 =?utf-8?B?VTkxL2laUklzUlN0dXpoTmtKTEJnWTVXUDRIcDUySXJRdGtUSmNJdHY4VmxS?=
 =?utf-8?B?V0pJYVMwSG5wVUJUK1BQanJJKzRIMFozS1FoZzAvRkZEQzBrQU4zOGprcXph?=
 =?utf-8?B?aE5rN2Y5VTJWeWpsSG8wT0VJZnBveTY4WUMxbk4xRk9obCs0Q2lZTmFYMmdL?=
 =?utf-8?B?SnZtclpXK1dhSGkwV0VyRzVXWnBQbUExZW9pRXZ2QTQvSUc0V3RqNjBDUCtW?=
 =?utf-8?B?T2R3ZFdIRDE5ZjdoRDZmWE1wNWlHV1VmWUR3ZGVLblVRSld1cU1iVHdhTjk3?=
 =?utf-8?B?VGdQVGRWZTd1eGJCTDlYREVOSTEyU05SMDdmR04xU09IQlppVHBzYkFNMmdT?=
 =?utf-8?B?OUx0dTNuemgzRHFpWnJQamxJbHlBR00wK2VZclFuVzFWckFhajBUTC9MU3Z3?=
 =?utf-8?B?OG9BdC9RdzAreDBnY3RxTk5ja0E3SVZjV1FnZVVzYkIrbGtwMURYUFdDWHA5?=
 =?utf-8?B?dlZZeFJ0VTBXaCt2dWwycFpGWlhvTlhXVkl0ejFod293UzR5dGRMYjFOeDlH?=
 =?utf-8?B?aGh0aytTWS9qMVROeHRnMmtSd3F5aFdTVzZyWVNjQUg4OUVYVHpOWTROcHJj?=
 =?utf-8?B?MFJBQWswMVEyVzhpcWdTTVZEZGl4R3RsZW9DajhoTThBcENReU16dGhKNGNv?=
 =?utf-8?B?SERWcnRiYTNEVW1hR05iVTVJWVNIdG13SkFFREx6K1d1dEJ2bnVOYUZwY2Fw?=
 =?utf-8?B?RStXaWJtUEw3WXlQM1ZTeEJoendGL0RXTUZHclVtajFLTWp0T25RaW5iTnI1?=
 =?utf-8?B?Ym1hVzRWemdUeGovOW1wMWtBWkZ4V0grQzdGVUZQdW9GQVdmaDRBNk5xaEMw?=
 =?utf-8?B?aWt3NDhuRnZPVjRVZmw3N0pIQ3FQTlNoUjBscFVwMGt5QW9RWDIvaHlyaWdi?=
 =?utf-8?B?VjVNRjFndzZqWHRRNklCRWg0ME9GV2NETjRUTXZwM1liTU1ZWHZocTQzTTQr?=
 =?utf-8?B?T1k4UXNXV3RtNFJmVkpnS2VIM3Y4UnQvcGxYbXFTM2ZXOXlJZW1nMFByYkc5?=
 =?utf-8?B?Q0piOWxXYVlVbmJYZnNJbjNpNjBkYXQwbFh3SW1WbmVtRVZycWtNbGdvMXdQ?=
 =?utf-8?B?UEdBWTdWcDlBK0xRNG5mTDE4b3UvN2FKTCs2YW5SUDdmbm11T0VPb0huUXgv?=
 =?utf-8?B?dXVOb2FIUXBQRlN5N0syaW1IeEpUYUpLOWhpMWlGNW1WNmV3S1I2VG9uZEVE?=
 =?utf-8?B?RXNMZDYxRkJwdFZzSHh1S0xUekNONmZEcGhuUnFvcmxQTkxVR1FFYmhXSmV4?=
 =?utf-8?B?Mk5sQVY5TnBQZkhHa3kwZmdmT2FkdTdwa3FYcFFwU2JYdTVRUUNkNHMvcjE5?=
 =?utf-8?B?R0M5YWhMRm1xQ0NXNDdla0Q2Sjk1dXUybStXVnRHaXNEYklTajExcXlicW84?=
 =?utf-8?B?TU9yRjhTM2E2dWdvaXA3VTV2bE5lWnkzSFAxNGRRcnJCZkgvV1Z6UXByeWpw?=
 =?utf-8?B?eDBKbDNSSG4xTEJ2dlFUMEEvSUVwc1c2SU1hdFRkaUcyYmlMY2pMQzFPMC9I?=
 =?utf-8?B?MzhrV0VhQ1NqK2swUGtSdkJkVngrSnJPN0dwbTN1U21HbDNMYXNXQUt5eGZ5?=
 =?utf-8?B?SVA5Z21KNnN5R1UrRTVTNHZXOXBpZzkwYzZyOVZ4VFlNVytZRU45U29oVU5n?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <763B42F92FA6BB4F9FA4F65C2C6874D5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab9a6c2-d86b-4fd7-59c8-08dbe63e4320
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 00:52:09.1042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioYaXna7G3gs0adBpAzOiGrTQYwjQOGlQkXehBaU8s21K2z2wQcPgKMnDDt5LdkB0h15r3oJAqYTFY3j9EhGeDUEKjumiA2Qapq4R0gBYbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8219
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDIzLTExLTE1IGF0IDE4OjQzICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IGVuZCBtYXJrZXIgdG9rZW4gKDApIG5lZWRzIGl0IGkgZ3Vlc3MuDQo+IA0KPiB4ODYgZG9lc24n
dCBjdXJyZW50bHkgaGF2ZSBlbmQgbWFya2Vycy7CoCBBY3R1YWxseSwgdGhhdCdzIGEgcG9pbnQg
LQ0KPiBzaG91bGQgd2UgYWRkIGEgZmxhZyBmb3Igc3BlY2lmeWluZyB0aGUgdXNlIG9mIGVuZCBt
YXJrZXJzIGhlcmU/DQo+IFRoZXJlJ3MgY29kZSBpbiBteSBtYXBfc2hhZG93X3N0YWNrKCkgaW1w
bGVtZW50YXRpb24gZm9yIGFybTY0IHdoaWNoDQo+IGRvZXMgdGhhdC4NCg0KSG1tLCBJIGd1ZXNz
IHRoZXJlIGlzbid0IGEgd2F5IHRvIHBhc3MgYSBmbGFnIGZvciB0aGUgaW5pdGlhbCBleGVjDQpz
dGFjaz8gU28gcHJvYmFibHkgaXQgc2hvdWxkIGp1c3QgbWlycm9yIHRoYXQgYmVoYXZpb3IuIFVu
bGVzcyB5b3UNCnRoaW5rIGEgbG90IG9mIHBlb3BsZSB3b3VsZCBsaWtlIHRvIHNraXAgdGhlIGRl
ZmF1bHQgYmVoYXZpb3IuDQoNCkFuZCBvZiBjb3Vyc2Ugd2UgZG9uJ3QgaGF2ZSBhIG1hcmtlciBv
biB4ODYgKFRPRE8gd2l0aCBhbHQgc2hhZG93DQpzdGFja3MpLiBXZSBjb3VsZCBzdGlsbCBjaGVj
ayBmb3Igc2l6ZSA8IDggaWYgd2Ugd2FudCBpdCB0byBiZSBhDQp1bml2ZXJzYWwgdGhpbmcuDQoN
Cj4gDQo+ID4gb3RoZXJ3aXNlIDAgc2l6ZSB3b3VsZCBiZSBmaW5lOiB0aGUgY2hpbGQgbWF5IG5v
dCBleGVjdXRlDQo+ID4gYSBjYWxsIGluc3RydWN0aW9uIGF0IGFsbC4NCg0KSXQgc2VlbXMgbGlr
ZSBhIHNwZWNpYWwgY2FzZS4gV2hlcmUgc2hvdWxkIHRoZSBTU1AgYmUgZm9yIHRoZSBuZXcNCnRo
cmVhZD8NCg0KPiANCj4gV2VsbCwgYSBzaXplIG9mIHNwZWNpZmljYWxseSB6ZXJvIHdpbGwgcmVz
dWx0IGluIGEgZmFsbGJhY2sgdG8NCj4gaW1wbGljaXQNCj4gYWxsb2NhdGlvbi9zaXppbmcgb2Yg
dGhlIHN0YWNrIGFzIHRoaW5ncyBzdGFuZCBzbyB0aGlzIGlzDQo+IHNwZWNpZmljYWxseQ0KPiB0
aGUgY2FzZSB3aGVyZSBhIHNpemUgaGFzIGJlZW4gc3BlY2lmaWVkIGJ1dCBpcyBzbWFsbGVyIHRo
YW4gYSBzaW5nbGUNCj4gZW50cnkuDQo+IA0KPiA+ID4gPiBJIHRoaW5rIGZvciBDTE9ORV9WTSB3
ZSBzaG91bGQgbm90IHJlcXVpcmUgYSBub24temVybyBzaXplLg0KPiA+ID4gPiBTcGVha2luZyBv
Zg0KPiA+ID4gPiBDTE9ORV9WTSB3ZSBzaG91bGQgcHJvYmFibHkgYmUgY2xlYXIgb24gd2hhdCB0
aGUgZXhwZWN0ZWQNCj4gPiA+ID4gYmVoYXZpb3IgaXMNCj4gPiA+ID4gZm9yIHNpdHVhdGlvbnMg
d2hlbiBhIG5ldyBzaGFkb3cgc3RhY2sgaXMgbm90IHVzdWFsbHkNCj4gPiA+ID4gYWxsb2NhdGVk
Lg0KPiA+ID4gPiAhQ0xPTkVfVk0gfHwgQ0xPTkVfVkZPUksgd2lsbCB1c2UgdGhlIGV4aXN0aW5n
IHNoYWRvdyBzdGFjay4NCj4gPiA+ID4gU2hvdWxkIHdlDQo+ID4gPiA+IHJlcXVpcmUgc2hhZG93
X3N0YWNrX3NpemUgYmUgemVybyBpbiB0aGlzIGNhc2UsIG9yIGp1c3QgaWdub3JlDQo+ID4gPiA+
IGl0PyBJJ2QNCj4gPiA+ID4gbGVhbiB0b3dhcmRzIHJlcXVpcmluZyBpdCB0byBiZSB6ZXJvIHNv
IHVzZXJzcGFjZSBkb2Vzbid0IHBhc3MNCj4gPiA+ID4gZ2FyYmFnZQ0KPiA+ID4gPiBpbiB0aGF0
IHdlIGhhdmUgdG8gYWNjb21tb2RhdGUgbGF0ZXIuIFdoYXQgd2UgY291bGQgcG9zc2libHkNCj4g
PiA+ID4gbmVlZCB0byBkbw0KPiA+ID4gPiBhcm91bmQgdGhhdCB0aG91Z2gsIEknbSBub3Qgc3Vy
ZS4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiA+ID4gWWVzLCByZXF1aXJpbmcgaXQgdG8gYmUg
emVybyBpbiB0aGF0IGNhc2UgbWFrZXMgc2Vuc2UgSSB0aGluay4NCj4gDQo+ID4gaSB0aGluayB0
aGUgY29uZGl0aW9uIGlzICJubyBzcGVjaWZpZWQgc2VwYXJhdGUgc3RhY2sgZm9yDQo+ID4gdGhl
IGNoaWxkIChzdGFjaz09MCB8fCBzdGFjaz09c3ApIi4NCj4gDQo+ID4gQ0xPTkVfVkZPUksgZG9l
cyBub3QgaW1wbHkgdGhhdCB0aGUgZXhpc3Rpbmcgc3RhY2sgd2lsbCBiZQ0KPiA+IHVzZWQgKGEg
c3RhY2sgZm9yIHRoZSBjaGlsZCBjYW4gYmUgc3BlY2lmaWVkLCBpIHRoaW5rIGJvdGgNCj4gPiBn
bGliYyBhbmQgbXVzbCBkbyB0aGlzIGluIHBvc2l4X3NwYXduKS4NCj4gDQo+IFRoYXQgYWxzbyB3
b3JrcyBhcyBhIGNoZWNrIEkgdGhpbmssIHRob3VnaCBpdCByZXF1aXJlcyB0aGUgYXJjaCB0bw0K
PiBjaGVjaw0KPiBmb3IgdGhlIHN0YWNrPT1zcCBjYXNlIC0gSSBoYWRuJ3QgYmVlbiBhd2FyZSBv
ZiB0aGUgcG9zaXhfc3Bhd24oKQ0KPiB1c2FnZSwNCj4gdGhlIGFib3ZlIGNoZWNrcyBSaWNrIHN1
Z2dlc3RlZCBqdXN0IGZvbGxvdyB0aGUgaGFuZGxpbmcgZm9yIGltcGxpY2l0DQo+IGFsbG9jYXRp
b24gd2UgaGF2ZSBjdXJyZW50bHkuDQoNCkkgZGlkbid0IHJlYWxpemUgaXQgd2FzIHBhc3Npbmcg
aXRzIG93biBzdGFjayBlaXRoZXIuIEkgZ3Vlc3MgdGhlDQpyZWFzb24gaXMgdG8gYXZvaWQgc3Rh
Y2sgb3ZlcmZsb3dzLiBCdXQgbm9uZSBvZiB0aGUgc3BlY2lmaWMgcmVhc29ucw0KbGlzdGVkIGlu
IHRoZSBjb21tZW50cyBzZWVtIHRvIGFwcGxpY2FibGUgdG8gc2hhZG93IHN0YWNrcy4NCg0KV2hh
dCBpcyB0aGUgY2FzZSBmb3Igc3RhY2s9c3AgYml0IG9mIHRoZSBsb2dpYz8NCg0KDQpJIG5lZWQg
dG8gbG9vayBpbnRvIHRoaXMgbW9yZS4gTXkgZmlyc3QgdGhvdWdodCBpcywgcGFzc2luZyBpbiBh
IHN0YWNrDQpkb2Vzbid0IGFic29sdXRlbHkgbWVhbiB0aGV5IHdhbnQgYSBuZXcgc2hhZG93IHN0
YWNrIGFsbG9jYXRlZCBlaXRoZXIuDQpXZSBhcmUgY2hhbmdpbmcgb25lIGhldXJpc3RpYywgZm9y
IGFub3RoZXIuDQoNClRoZSBvdGhlciB0aG91Z2h0IGlzLCB0aGUgbmV3IGJlaGF2aW9yIGluIHRo
ZSAhQ0xPTkVfVk0gY2FzZSBkb2Vzbid0DQpzZWVtIG9wdGltYWwuIGZvcmsgaGFzIC0+c3RhY2s9
PTAuIFRoZW4gd2Ugd291bGQgYmUgYWxsb2NhdGluZyBhIHN0YWNrDQppbiBvbmx5IHRoZSBjaGls
ZCdzIE1NIGFuZCBjaGFuZ2luZyB0aGUgU1NQIHRoZXJlLCBhbmQgZm9yIHdoYXQgcmVhc29uPw0K
U28gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgZnVsbHkgbW92ZSBhd2F5IGZyb20gdGFraW5nIGhp
bnRzIGZyb20gdGhlDQpDTE9ORSBmbGFncy4NCg0KTWF5YmUgYW4gYWx0ZXJuYXRlIGNvdWxkIGp1
c3QgYmUgdG8gbG9zZSB0aGUgQ0xPTkVfVkZPUksgc3BlY2lmaWMgc3RhY2sNCnNoYXJpbmcgbG9n
aWMuIENMT05FX1ZNIGFsd2F5cyBnZXRzIGEgbmV3IHNoYWRvdyBzdGFjay4gSSBkb24ndCB0aGlu
aw0KaXQgd291bGQgZGlzdHVyYiB1c2Vyc3BhY2UgZnVuY3Rpb25hbGx5LCBidXQganVzdCBpbnZv
bHZlcyBtb3JlDQptYXBwaW5nL3VubWFwcGluZy4NCg==

