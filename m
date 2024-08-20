Return-Path: <linux-kselftest+bounces-15792-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE8B958FCB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 23:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794E51C21CAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 21:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559081C6892;
	Tue, 20 Aug 2024 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtvGIW2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749F1C579C;
	Tue, 20 Aug 2024 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189821; cv=fail; b=i0Krid7/wTcv0aD+hJZkQ19PWMqyzXt/qtKUw0vb0/QldKezGI7MHMrf6IXU6aumz9LLgLDMSSJjThGk9zIVDmQQL0uhdbGMcsOJiVjP4Bj45djmx1KtoQsoY7toz+eNWFSjYkrZBJ8s4qQ2g/mlvss8dgmWzkpOFnqvzuOkj0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189821; c=relaxed/simple;
	bh=yENoR/+X38GoeRQ9eSxIyus/uQqRK4Q6hBRnaLN+sJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUsVU8lwRqBH3W3G5Cwsy3pypDqHtKz7p+SjRr4eMGOMJmgd4XU0GlG1EUaNmiRC88F9WAqUhxajIieIn4bbF6UlaM71Gcesg42Jnj6gkv2AX5yDWXYhoH281RW6w3gSjSbUYZSmHGwcd2bUI5Ukh1qZ+XWHAMLHAo6lvOAjqqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtvGIW2Z; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724189820; x=1755725820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yENoR/+X38GoeRQ9eSxIyus/uQqRK4Q6hBRnaLN+sJk=;
  b=WtvGIW2ZNcMFUW4VBPgnFFi2fnsgYPz6eSIAA34fMBMzUwez0JN1/deY
   c8Y06SbOCgMsgmAgnaym0nQGxI1uIPW4jYi+t+QiRug50KUR4FoP+OIXe
   aAXb3T9jLYR1/L88ctG7IN4idJ94jnBy90zEshb7EE3AixLE3f99AMKH2
   vHI4tRVw8pbA4Ba84GgS7/ddFDwD3Mx/XgH7Kh/8zE6j93y293Pt+semL
   bxwUu8QrdlWWds2oHBLEHJ6za/tOz8neo4KivP3RAQfQlRIHuBWwUagMY
   mHUG8kL/4SKqRyt0gssHoYrqQkiijOv/L7m3Q0rEDqco3jdRHkE3AFtn2
   Q==;
X-CSE-ConnectionGUID: yekPf4ghQ/+72JjAsptcMg==
X-CSE-MsgGUID: lJzdsxUqTRyiyeK/9qJYUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22051509"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22051509"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:36:58 -0700
X-CSE-ConnectionGUID: zfKCqQdeSLOUQQMHfBbusA==
X-CSE-MsgGUID: FLCI16ksSoqENJM4+KQb8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="84058631"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 14:36:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:36:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 14:36:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 14:36:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 14:36:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs3XDWyWYBAUMClbZKzd+Ume0p+YyXRHFPOzxxNfyRlwjs2zWvBd22MsicBcxtxp1UgL3UgqZAauY+Dv1lVbXyjgyTs3laM8wXmPW0yUCrhP6CwXTX+fpvNYaXbfaRumLAmeqdbbAbcA4kN3wdu5pc344kUtQR0m0H2KxjKDfeyN/XwC4kTQLsUoh7MvSX7utvhLnbcxCptHT5yXkoM40kPZeP92PYMoNw6pdPOCnNUkxNrCFuUfod7V9KVeqEoxvQqpawWtqwjC1hjNJ39h6Wn8OS0j6qUq2wFaY50SYlTF3UVTbuDdrYyynBfd95IvP3QocISclDs79Qe4ZGjrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yENoR/+X38GoeRQ9eSxIyus/uQqRK4Q6hBRnaLN+sJk=;
 b=NgxOdnCIhSoK9BcvgLK3trfQPXAw0TbUYw5EhmHxSoXzle2TjF6f17OlF3l5M2eJKbsM5ht8zD2+9IK1OE7piNILQ+4QPM4mPucns6wlho+K37OzC1Zn2V0zcGv2oaajbRiJTI8uo1Eu+g6gs1awEu8bLC+/AuGdIkUEnZFSbh9ZrAk/hHd3JscjokKtc/Jz/WgG4qdQL3GtpTg78gJohxAyMSlFyB5lImh4kcgBrocXAtvavlFF3NUKg//mPn28SHY0DEJE8rieiNqAGqndFhfUXBqzTm4RX9+jLhBLrvr7+QLXNrNjXdD6d6lcNda8SpIeEJixU+1BFbx6aKGVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 21:36:55 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 21:36:55 +0000
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
	"shuah@kernel.org" <shuah@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "jannh@google.com"
	<jannh@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "kees@kernel.org"
	<kees@kernel.org>
Subject: Re: [PATCH RFT v9 2/8] selftests: Provide helper header for shadow
 stack testing
Thread-Topic: [PATCH RFT v9 2/8] selftests: Provide helper header for shadow
 stack testing
Thread-Index: AQHa8m21k59tvFawoUqGcdkZfWp/6LIwrUoA
Date: Tue, 20 Aug 2024 21:36:55 +0000
Message-ID: <a2172ad8a9126cbfaddeebff92758000fa7e8bd4.camel@intel.com>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
	 <20240819-clone3-shadow-stack-v9-2-962d74f99464@kernel.org>
In-Reply-To: <20240819-clone3-shadow-stack-v9-2-962d74f99464@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW3PR11MB4521:EE_
x-ms-office365-filtering-correlation-id: bc72aa49-6c20-4ef3-ad01-08dcc1603653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N1RodlFMTHJQSFBmcmN4QlVkZ1BtcnpuRmJaN1JBWXFjdjYvYnZYa3FHUTRW?=
 =?utf-8?B?REZqRHYybExQbmRVak5QTDdQK3ZHc2RBSjBwNy9OUUt6SS9iQ2xJaDZtVW8z?=
 =?utf-8?B?V1FSRU5vNnNSRk1WRm1TSGtReS9IZTg1bFJPU0dZMWIvV0Q2OHJLV01wOW5s?=
 =?utf-8?B?WnZjYVF5SHpBK2tkWGp2TDVTNWhXeUVkVDhOMUVxcXZHWG9yYTF3UUgrOWZB?=
 =?utf-8?B?ZlN6bnpURnM3QVhyQzlnajRiRncydllwbytmemZvQnBXUG1SUDFUeWhkYTNC?=
 =?utf-8?B?MkxsOVh5LzZVMlBCQ1dNOGhra0lrZXUxeHQrNUZSZVBjbW1uUTlmZnV0WXZG?=
 =?utf-8?B?cEE0Y3pzS3B1SitDU1pmY1lUV3dWR1Y2OHc4cStseGlRT0RwN1JZU2lPM2lK?=
 =?utf-8?B?bnBGNTJJYzFaSW0zdjZ2Y0ZmYlZjdUxjWlNDY1ZPSythTHBZM1BFaGNqVEZu?=
 =?utf-8?B?OHh6NFJLMGtVbUt5RXkzL2RadkFYVFk0VTBXaDFqYjd1eThDajhqQm9kcDJ3?=
 =?utf-8?B?dlFkL28vUFlpRHpQMGlDOGhwTEVIK1V6aFhmOGdud1RiSmwwTlY3VUNvVnV1?=
 =?utf-8?B?R1NyWEdwUTdsRlBMR1RDQTE3QmJZWDloMjRrRDZ2djc4RWFVQzllTXNDRUVQ?=
 =?utf-8?B?cXBJSVpHVWNKQ096SU1OWE9IUXhxYU1oUEE4MC9XY3F6ZnJmbU8xbUM4U0tS?=
 =?utf-8?B?dFZLb0RtWW1JZlk1c20wWHpBaVZKa0I2YUNOaVVZaWZYekp6Ri9HSEM0UVlN?=
 =?utf-8?B?a3ZlcWM5Z3Avd2ZIblJ6R1FHL0ovM0s3VUw2eWpnRmJUanF4V3pmV3BlSmFP?=
 =?utf-8?B?dWs5WUVBUkZnM1RNcFp0TG5BcE9NWEdyVWNLc3BGbVJkdStQSjFyd3NSL0RL?=
 =?utf-8?B?UWQ3RnpjVjZQZVg0Si9oWmRYaCtYc25iU0Jya3I3S01ianRJU05PQWxYTDN1?=
 =?utf-8?B?RU90Q3QwNGlodTM5R0pIRXVKWkNiWktmTHR0Y0Nla2NmSkw2L1VqcE4ydkhr?=
 =?utf-8?B?bHhFbTJqSUpacE1ibXVoWkJiRDFMS3k1ajVhajUzVEtQM0NtZzkzTnorejV0?=
 =?utf-8?B?SVZUVURmc2h1SlZNZVlQK0dBTGxORXk1MlQ5U0ZuYWN4aUNHOFNUUzI3blJj?=
 =?utf-8?B?c2I3VzE0R3lpNGUvVUkzRmhaZi9XeCtQcU1ldVU0bXl1dHdrYysvVDRPdGta?=
 =?utf-8?B?eHRYeEtwVkNkMi91WC8wMWJzUTdGY05KK2J2aXVlL1hoL3dsbit3OG9aNi84?=
 =?utf-8?B?aEZmbUFuc0d6TTIvVGR6aUE0YnJVVER5RFZIVmRrSWFSNkIvTnZMNjlwL1BO?=
 =?utf-8?B?N21wM05TQi9aZE50SDA4OCtZRDdTYXpVUjJOSytScCtBN2ZMVXZOYXd0SnJE?=
 =?utf-8?B?OUFubnp0Q1dFVHVva0IyYmFNZVQ4RlZZWlI3elhMVkNiZ2pjTEVpVmtyc1hR?=
 =?utf-8?B?b3RBdjBrQnprVGpFQ1lPVVpZeTM5cG9XWEY5Ykgxakt6TTNXcGhDVEpDWmp2?=
 =?utf-8?B?OXNyTHZnQmVTZnZidnNDWmJiMzNhR1Y2NTNiL3FXbWtSVThVQ1VaQmw3Qlkv?=
 =?utf-8?B?VlJ6RG5RaXdseWFrditYOGw2d21mSWVxN1BpZE1iQUdDL2Nhb3B1bTNmSHRF?=
 =?utf-8?B?Q25lNTA5ZXRITTdubnNETkc2eElBOCtGSjR5TUViSTBodlJSZnpTNXlKYVlr?=
 =?utf-8?B?M2FOUGhVcWRKcGVRTDlsYWRxNlFIQlJaMU8zNUtvU1pCVUVTYWI2b3JBMFRU?=
 =?utf-8?B?WTVWMDlJVXpjZGNCMUhqeHFIVEFOYjhRRDdtRThTNjU1Wi9VZzN3emJ6VVR3?=
 =?utf-8?B?cWlqRnhFNks1ZlUwbXNHMDhvdi9KNU9IWm9wY2hVd3BhSGpWeWVnbVorbnNH?=
 =?utf-8?B?L3NQZllveVpQejZqdnFHeld0eDQxWmFFZ0hVQzNmYWw5L1YrNkhRLzVzc1ZT?=
 =?utf-8?Q?1tT2GWAyHUg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJnRHRsVDVtK0FTSkt1Wkd3UDU3bFFjVUZDbFpBRjJhMTk1SFd1MWJpeVZS?=
 =?utf-8?B?dk16N3RYOUg1akdSbi8vRTAvVHN6d3BoNG4raDE0cXBUSHU5eERVVkpLcWE3?=
 =?utf-8?B?ZDdxYjBDYXV0YWpmUDVScTl6R1FLTlQwck4vY3VuaDRzcTNkcFh3Ylh5RUVS?=
 =?utf-8?B?Ty82UER0Z1dkYnI5NnYzWnBRZ216Mk81dWJ6M1hQVzNidU5OY0JQbGhNYzhB?=
 =?utf-8?B?TWFSd2swZkxBb1FvVXJDMUxoNmZsdXZsUmIxN0U3bDZ1ODZPL1hQaXA1VGQy?=
 =?utf-8?B?amJUdjFQZkZYUWpCelUwS3FuYVlkUnREVUw0QlRMY1E3MlBJSDFGVG0xUXB3?=
 =?utf-8?B?bnhjUGQ2RHQwVUt3Nlh0a1l2Z3N0cS9Pa3hXTE80RGN4T0sxWlVud1Jnekdr?=
 =?utf-8?B?dmNYbWNWRVJhNzUvOTJLM2YvY3hDb1llNVVmMlZVc2orMTllVUpXcUlEVkxY?=
 =?utf-8?B?QXZXYTBYZHNYSHRNK3paNWhua3BVR0lOZjU0MkVvYUdJWXVDeHF4WG9qZUVl?=
 =?utf-8?B?SGNFWTRmNjZpS09YaFJEeVJSaVJOSDYwRm1LZSsyUjZSWm4zNERuTjV4aTVp?=
 =?utf-8?B?MUtNam1nMGxFN2crZ0w2WEx4eUFGNGdTZTdlSHh0dXU0OTJHOXBVM0tvY3RL?=
 =?utf-8?B?U0h5T09Rb0FHRjlFQ3lmaklJN2tzYU9DRzVIZ1BlbWJObFh6NVVVVE1ISlE0?=
 =?utf-8?B?bVRtRUlYRGhuSFFuVTczTEVTN09zWjF5cHpWd09sNHZNc3ZMalpHUlU4WlhJ?=
 =?utf-8?B?djhySW9QTHpGTElaL0lsbHM3ckZIa2ZIQm1GZzVRMEhrb1ZXZFdYbzFxVmhN?=
 =?utf-8?B?RlZVeDBLK0pBSWQxNW1td0ZhbHFDaXdIUzAzb2NkbmZ0ZnpSV01XVVBZOW9X?=
 =?utf-8?B?WG1kbFkvVVJCMGhZYURrNnE1amNYdlVkYU9DdzJZQmVXK0RndnRIUGhvd1Mr?=
 =?utf-8?B?VmY1THdRaG9reTQ2OEJCV0xVSHV2TlFSNFBTb0RKaG9QRk9LRVpwbUlML1Vs?=
 =?utf-8?B?UHcwdXpsbzJqcTg5eGp3UEtMeWNDTG1USVdpYnljeGtnOGthcnRTWWRWaUty?=
 =?utf-8?B?a0UvZFkvZTBsOXYzZ3ZnSWdoTWNvVlhXSUZmMURudXBocGFQQXI0a0ZNSGlt?=
 =?utf-8?B?QTJuUzE4Q2RLKzEwellYUTRKK0RhaHFWTDNHWk1obit6SFByaXpremdidG03?=
 =?utf-8?B?WldZdWFEVE1VLzBoME91UnRYQ2VnekFaS3A1Ry80MStqR1lrNXZoQUo3M0Qy?=
 =?utf-8?B?TWpqYUxpQU5qeWJ3OTlic0RmVkZ6VVF2SXlnODBQenQrRnpFRGg4Q2tvRFo1?=
 =?utf-8?B?VGNXZWxEVm9jc2JVbmNEejY5YzZFK1o3TVZ5UnRZbnJEM3hhMllLWmRhSW0y?=
 =?utf-8?B?MFBtdWlEUk92dy92WkR6bzRFVm5sT3c0MXArYjhYVWhJbys5NHkvTXlXbU1N?=
 =?utf-8?B?OUdzSzhoZUI1dkp3Q0RQQ0VpVXJUTXRwY2dOY2NkNWlRNmI3NklDQWlSMjFC?=
 =?utf-8?B?aFVZUFJMb292RWR1aXZVbll2SWxZVFpDV1VwcmFHYlNtMnpVemxZcjlucWdv?=
 =?utf-8?B?d0ZPVlcyU2xtZnZmaWVyRjBRaWdGVkpXN3MvelhUM1h4eFBOSzJRalpobzFE?=
 =?utf-8?B?L0xmUU83cmN3bUx5R1NraENDMXl4QnY0M2RhOWhaaTZKaHh4WDAzMm9RVVBY?=
 =?utf-8?B?d1RaY2xTNG5OZTh4R3M2bzZDMnIxR2VTS2k0WWl2S2taQ2tHSkdjZ2hxSkM3?=
 =?utf-8?B?aW54WnNUcTIwWkR2ZmdabGJjcTlxNVMyQ1JmSk1weGVFMU5VbFNXazRUSC96?=
 =?utf-8?B?WUcyRzdwYmV3cE4ySEVrUHZhbzdKa0FsYTg2bi9UZ2owdHdNcGZZSEZIaGlo?=
 =?utf-8?B?ZWc3eXA4WWhXUklOc3JKb2NHeEtMVGhEZEZIdzZocmkvdktIbXl4MVRWR2RL?=
 =?utf-8?B?QlMvU2QrOVI2Tkk5amdWQmJxOVQ0aEFwU205NjN4TVpyeDJXMEFvd3BVNEx6?=
 =?utf-8?B?MGVBeFZDSEZ3MThQMU93VHZ2a1A2YjVVcjNQanBoK2tPbWoweWs4TUJzc1B3?=
 =?utf-8?B?U0F3ejl6REhtRzBuQ2N4SHA3TW5VOVZKMHozWEVsOC9lUVRqNWZ0M1NpeFRQ?=
 =?utf-8?B?dnpSakVyeTNhaXAxcjhWL1MzMERXNWJ0eU5BSUpUK1didlY4bGI4cGpQcWZ6?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DA51CA6C907F24E8C30BAAA412FA05B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc72aa49-6c20-4ef3-ad01-08dcc1603653
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 21:36:55.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6brCZHcqzNUaUpn9J9t/OTjY79wNoeQKGFBZzYeAz910o9VYfU/IkCz/tZDw6pgDXWwCh08XgORjsau2dicCq5jsOgxJxVZhca3WtmIBWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTA4LTE5IGF0IDIwOjI0ICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiAr
DQo+ICsjaWZuZGVmIEVOQUJMRV9TSEFET1dfU1RBQ0sNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBl
bmFibGVfc2hhZG93X3N0YWNrKHZvaWQpIHsgfQ0KPiArI2VuZGlmDQo+ICsNCj4gKyNlbmRpZg0K
PiArDQo+ICsNCg0KVHJpdmlhbCwgSSBnZXQ6DQoNCkFwcGx5aW5nOiBzZWxmdGVzdHM6IFByb3Zp
ZGUgaGVscGVyIGhlYWRlciBmb3Igc2hhZG93IHN0YWNrIHRlc3RpbmcNCi5naXQvcmViYXNlLWFw
cGx5L3BhdGNoOjcyOiBuZXcgYmxhbmsgbGluZSBhdCBFT0YuDQorDQp3YXJuaW5nOiAxIGxpbmUg
YWRkcyB3aGl0ZXNwYWNlIGVycm9ycy4NCg0K

