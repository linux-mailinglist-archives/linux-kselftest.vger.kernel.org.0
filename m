Return-Path: <linux-kselftest+bounces-21329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F19B9AEF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAEC1C21093
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E21A2643;
	Fri,  1 Nov 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CI/nyLk3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF071547DC;
	Fri,  1 Nov 2024 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730501177; cv=fail; b=EI/fh+7/Jfh3VbZgw73Qvg3vGkAehlGmod+WHRN9TSQgcejUpbwnAN/gI8akEa04TApQVi5szsKjzWvO8846ZFH8ZoxzxXSWiqn2EWBfIB/TTzUkegckjfEJG0AOHQ1V9+5dk8rBxBaqZFP6YGI/9U4DaxO/NKzYBE+owslU0mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730501177; c=relaxed/simple;
	bh=rU9xl8YNtNDhkyAMrWXWgR+7khILnLcfyJy4VWxg41Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBxDuFxamWDt2uFRgU0w+gmG1MLixvm8sU4+1Jrog5imXgPwT+OjaLJx6Op/lb+QcZEWCawgpNqUmYQeQ2WCNSoGmRY9H0b9HQd5C9qW4lIjGFgaZ899qSs9kQeB9rbZMWserm7hjsXxCQsOsyENiz4kVFENXrzjaeHYmYedHPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CI/nyLk3; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730501176; x=1762037176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rU9xl8YNtNDhkyAMrWXWgR+7khILnLcfyJy4VWxg41Y=;
  b=CI/nyLk3iBLhLNIVbpeCb/hssSoiYKj/WxDA1NqKqX3F8kYcoA+mHvT1
   8Js6HlZnO9Cj58rk0fltyP4NisW8+AjaPWSCpwB5tET92Uxg/CmhUg5iU
   vrnUvo66HxBFTM9qmlh8S5uwvIBZYdxohXfG1/T126eiZ5qN1AT+pga3K
   lg3nknlXpDDkoM0yMg8kPl5EEyApOiRzMrKrtVbKgS2Yc+B9goLAgQHRC
   talmP1jkXbKDXqeWKGdkvU4O2UNK0/b+cD/1vFmY3JANkfP1/QlewRXm5
   ZPbzAsrOY2K1Hna9RpzSyEE23fPM/WF1JGNpW5L+EefI7Erqra1mgOAWS
   w==;
X-CSE-ConnectionGUID: kb6stHHZQKyF3+3Ah+tBWg==
X-CSE-MsgGUID: xRJWtGHUSViUGcT6Ge2tow==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="17903213"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="17903213"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 15:46:07 -0700
X-CSE-ConnectionGUID: FWnCa6gcRoiJ/3AkopEa5A==
X-CSE-MsgGUID: JY1FwipzQuioxORaR+J5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83917092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 15:46:06 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 15:46:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 15:46:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 15:46:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G65MybGFzAkwB4J8qpTA3KXRhIPuhHJ/erY9owdgHvXJaj+kF0K7czxmLXWRiDslofQ3mdP/r5sgkEQf5KlYBifLVGIsPM05e1FeR4at/G+5lH9hh6RfFiHCEpFR8DQIku6Uco2ayogFRq2qjYWGEBUDxR85au3ZaKcAQ+X47jYdEe0AOj6qr4yL5IG65CiJmCvEAdmZH6w8jG+iqSCDe+j6BBRWO9XRPfI/9Fwy2BDsF8sWjONEODgJ0FTTvJ99KWvXFKEvu1Gs33uGJYHYsc6CrcHkkHSiJNnM4wqJ0A0eiEE6o1J25DHh085vxNM+CnwSQMm6aChMASDOEWiRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU9xl8YNtNDhkyAMrWXWgR+7khILnLcfyJy4VWxg41Y=;
 b=zTw5G8OBsPWBGkJz/ZGox46wvAqF47ewSpgwjFulZnS40fmy6M1abmKf6bbzGm2nsmcH65k0JclxHRwBfaBJgo6tDKH/kjGi/R/tTJJkRIYsSSsqCdEW8Q/dHZLYtyWFbympw1kQXXaw3UNtqB89DW23eWDqtIjWSzq7ZuyceDYYy3ciy1vRqI5MSwGmljciHRc9P/KxsQaHzLPOZWTvgeaJZ5UWNyirX5FaVLFxxXYGn61alKjX1BqF8hbcrKWuI/g0Gnzf6xeruRTXDVTjpmC7ST+MGScrPpq1U+oiilPbocfEaNlhUxIf9YX6jtUIcTXRAxpsg1y5nVvHdiHzUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB5959.namprd11.prod.outlook.com (2603:10b6:510:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.26; Fri, 1 Nov
 2024 22:45:57 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 22:45:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "shuah@kernel.org"
	<shuah@kernel.org>, "brauner@kernel.org" <brauner@kernel.org>,
	"jannh@google.com" <jannh@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "will@kernel.org"
	<will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>, "wilco.dijkstra@arm.com"
	<wilco.dijkstra@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v12 0/8] fork: Support shadow stacks in clone3()
Thread-Topic: [PATCH RFT v12 0/8] fork: Support shadow stacks in clone3()
Thread-Index: AQHbK8qwrNRMzTtafEWNeVWV00PA77KhWdMAgAECPICAAKv7AA==
Date: Fri, 1 Nov 2024 22:45:57 +0000
Message-ID: <7721b3ba957d2c052038c719fefc4af36a6d6c08.camel@intel.com>
References: <20241031-clone3-shadow-stack-v12-0-7183eb8bee17@kernel.org>
	 <fe6cc8010b2b35aaa2629c4c5e972dc1c90c43c3.camel@intel.com>
	 <eca3edc3-1a2d-475c-a866-ea25d6bd9756@sirena.org.uk>
In-Reply-To: <eca3edc3-1a2d-475c-a866-ea25d6bd9756@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB5959:EE_
x-ms-office365-filtering-correlation-id: a533d55f-e4e4-4af0-11b3-08dcfac6f37a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UFY2bXJ6TjAzaXprSmdMKzVVczdTRFpYRWluelBrY0pRbU9GRUVzM2c1UU80?=
 =?utf-8?B?TGpNSjArbFRDdWNDUVJHUDhWbXFhMEpuWGgvSFB6dmwyWEs0WENEVUx4cTZS?=
 =?utf-8?B?YkJDc2NCVEdhd0NiaVFOWE91dkNXVG5wbUFPcVNqSlVtM2NmeUhsUHdiUk9E?=
 =?utf-8?B?bGxBVUVFSGhnWDFnM1J0MkJFNDdNeDVOcHJ6cTZDYXpJaHp3VEZiQ1BPbVZl?=
 =?utf-8?B?V09WTVA0cUtxL3pJaTVkNWd3OXROY05IRnl2N3RjQ1RTeHVuUXYwM2V1enFa?=
 =?utf-8?B?aUJablJWY2FkaWZqbzVOKzNBaC9mdGdVaWtWcTZhblBGbTVpZmZwT0UwbUs0?=
 =?utf-8?B?QzVJZnNPL2ZGRGlVV2dISnpBMldBdCtuR0YxZHU4TXdDWHFmRG92RjIwQWxT?=
 =?utf-8?B?MXNwMUJsZUJFRXRwRTdPeWFicngzQWRZWklNZ3RDcDhyRGNmZlJ2bjJXUWpo?=
 =?utf-8?B?WSttRHdTZnpUTDdmK0ZsQzlYSHhUc1g1M0Z5TmRzeitFYTUza2FFaGFSK083?=
 =?utf-8?B?N2RtSVova0c1OHE1NU12MzJpZE41eTZWWGZiQUYyVktJTGdLTUVyeTZjdVhX?=
 =?utf-8?B?OVRadThybXVMczV2VmhoajN3NGQ4NmdyVGhUcmx0RGVOTHdhNVdwYWozeEx0?=
 =?utf-8?B?UEladEdPY2NNWHRYbzBFYThCaVBTUUo5QWdJMW9PMjYxVDdyNmQvZDJuc1g4?=
 =?utf-8?B?SHdFWUNndFIwb2RNbzFqd1J3VXZoV3hKQkQ4TnE1TnhtRjdoSmRTV2ptL0xw?=
 =?utf-8?B?WE9xRE1XU085T3ZnYy9HMnd1MEJLZUlyckttNEVIcTRvbHdBeHE3VHVzQ1V2?=
 =?utf-8?B?Y1cvc2dXSm5sNWtUSk43NmVPWFRoM05wa3RucllScFVuYzlDc211bUpaMnpv?=
 =?utf-8?B?a1NXRjIwWkkrU1hpKzV1dnN3Mnd1M0hUNC82RDNRSEJBZGtWRFZJYUkvZ3pp?=
 =?utf-8?B?ejE2UWIxMWx2SExmVXl6eU54VTIxcFI2MDJNb0g4UlJ4bTREQ1NIK0RxUXk0?=
 =?utf-8?B?RFJ6QzZNdXZCN0NySk1waU5NTCtnT2ovbWd6QWJyRjdmK0FMWktSdWF4RmQ3?=
 =?utf-8?B?cVlBQ0FLVFdjOU81Zk5mdlBMbzlNaWxwd0hieDM0UFl5ZmJsbnl6Rk5OREp3?=
 =?utf-8?B?L3BFaDJkbEl4blo4RG9Gd0JyU0xGWjRrVVR6NGRHS1hQUmdIKzQreXNDMjB1?=
 =?utf-8?B?SVpaMHdFM1ZkN1V5Y0dlYk1qUkhQWXk1KzNVditPck9GVUhPS09wancvcDJ0?=
 =?utf-8?B?UHZVbWZzdWc0NjhMaXlEN0hCdGRKRllzNzJzNW9SVTU3KzN4ZDdKa0M1ZVNh?=
 =?utf-8?B?WUU4K0N4T1k4ckY1NVZEMmxUb2dQUzdWYWNYZzJ5bkFCeTZZNmpSZk5oWVZ0?=
 =?utf-8?B?YTZOcmp0VFFGazVlVVdnOVNYNGUwQUdXRCs3NEU4MnRPblRyc2RFT0R6NTh6?=
 =?utf-8?B?U0ZodFZlZmVWZHppaHlzN0laQnFUbkxaekYzMGdsRnFSVmtpU0lLL3BIQ2dD?=
 =?utf-8?B?N2R6NkVBUThGNHkvdStiZHB1bDY0cFRleFEvT2FGSXFLcjVLYjhNVHdva1Q5?=
 =?utf-8?B?NVZwazZTUFRUcVpaTEJiVTIvTCtmMy9rR1dNeVZnMlZhVHFtZG1PUjJrWllH?=
 =?utf-8?B?cXdtaUtOWHBCKzcvdjlUYkJvY0g0aGtyb0hVZGZGSWxWa0l6dDZxYVhqYUdl?=
 =?utf-8?B?cWYyYTJhVHZJbUhOcHZqazhoNk4zYUpjMEo1SzFUN0VLMEVtMXpEcGl5UHp3?=
 =?utf-8?B?MXlvNWNMVlpHWm94amhqWkxzQ052L1NDRG9MZ2dtVUpSVkxzaTZQN0JIU044?=
 =?utf-8?B?T0ZGYVZlYS9CLzY4K1U1SXlUdk0xalZVRC9HcHh3NXQ5RUtlV3dqRmZUTTlK?=
 =?utf-8?Q?ahqzM0JQeE2ng?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2Y5NE5FNHJmV1ZxWEtnU1lrc1BkTm9ubVAvSytHRVB2ZmJYemdQd0xLYThS?=
 =?utf-8?B?RXowcWEvU2JZSmJwcTNkYTFndVd3N2hTMGJjbGJsRXRBSTkzT3IyMDNnL2lt?=
 =?utf-8?B?eFcyUHJFZXlIKzFqbDBDVE1BTTNaQkNPY1dYWE9UZU5qU0RJbUxQclZvazRx?=
 =?utf-8?B?dk04UVNSWGQxZ0NDN1YxSWF0VHU1WGhtTlNoSy8ycmdTQVlTQy9DWWM4dWps?=
 =?utf-8?B?Z0x1bjVEbUZKS2M2RzhDM3N4Q291SUFQV2c0Z05FNWNuVFBGd0RZR2Zweklx?=
 =?utf-8?B?eXFPN3pDWUhLZFBNcHY2UXZONFc2cy8yN1JVYkFjREtjRE5vK3pZM1M3aW1G?=
 =?utf-8?B?b3VyS0tVRjgwaVAwMWc1L1NRUVhtQ2Z2K1ViY3BwR0wyT2VPdU9Zak16TkYy?=
 =?utf-8?B?eEgyd3FIMkQ5dTJDUmRreUE1YU1wbTh5Wi9TNmF0WU9sSVlPd1BWUis0QVZW?=
 =?utf-8?B?ZDhkRVdQbGFWa09FTkpBQ1BJVHp2dGVVR3FmVmp3cGN4V1BsUDNBajJHWlNE?=
 =?utf-8?B?UVJhcXc1V0F5VWhINDJycEttcGU0emo3bGtLalF0a1RGd05TZXJBcjhXTTAz?=
 =?utf-8?B?TGJRbWZrQTFYMjFpMGxGL1ppYVMxVWNwQzZZemZza1FLTUM5RU9tcnJhV0JM?=
 =?utf-8?B?aFQ4SmdWYlJPd0xqQjZtVUo0SzB5T0RjUnFINWllUjI0MHgzTDZGVFpqd2ZZ?=
 =?utf-8?B?czlxK0piNEozeXFEMGpDTG1tak1tY0I1S0hoOVVvT2I3MDZCc3dXQkw3T2tl?=
 =?utf-8?B?dDRLSEpVS2hZRW5qUVZaLzByeFIrNGNDQ2dLTUpXdHNkUllBOEFyc2JSUHFy?=
 =?utf-8?B?a0xRMStMY1JLQlhIVVdYeE1Jek8ybGhjN2FkeWplajRSMEEyUnVPd2ZTeC9t?=
 =?utf-8?B?QW4xTGlkNEtYL281VnpSeExMTWJuMlZudTlGdVFLUUlNcW4vdjRvZ1Z2Q05N?=
 =?utf-8?B?dU9GQ2RwRE9lSFF1VzlhUFhIcGw0bS9BV3B1SXhUTGVEUkFQQVpZb0pCc1NN?=
 =?utf-8?B?bytwbHRZb3FQMC90cENjem5xUGF1OFRnVWlXVm55ODZ6NTVvWTR2SnlIS0s1?=
 =?utf-8?B?ZEhsT0ZIdmR1RGFRL2FyK01lWVNwNThuY1FxemwwVU9rMG9KeDlmaHBGVzJy?=
 =?utf-8?B?THlsWW9FOFhWdnpndnFkcmk0YllQcldjd28vTDU4MmxaUVJQMFpycmFHREcy?=
 =?utf-8?B?bTdVZXduTXVXNlBpeWlwTkdDWDV0RUhEWUlmclVzUVFQQjBNYmNRSDh6bkFH?=
 =?utf-8?B?S0NnVDdDd3p1RFZMNCt3WmR2RXZsTU5Kd2R6aTdLRFUyRXpaYTBMZGpHdkNv?=
 =?utf-8?B?aFBCeWV5SE03MjF5NGlEL3BPY0RNK1RVbDE3M2l5bExUTGZyRGxtWlJoemp6?=
 =?utf-8?B?U3ZxYUNtRmlac3FLZ3BiWWtsd04zSkdmWlh0SnpDNE95M2Y4RXlERGk1OGcz?=
 =?utf-8?B?R0lZSWdEWWRjSDVlRGhWRWlMV2hyaExqejQ1TmhCaFY1R3NFbFE0NW9mbkxZ?=
 =?utf-8?B?MythT09rTm9XSFBRbHBPLzVhRlRLK1F2RUlOK2ZnYkVsYXo4dzNaa2FGbUJm?=
 =?utf-8?B?U0p5Mis2Z2NJdHF4S3VHdGpFbzkwNWQ3OUlrempEU1JKWURoc2trcXk5VDBa?=
 =?utf-8?B?MXVSVEExNmtKNE5NRmVZNmxtSVljR3V2MC81S3dOaTlsS3NDdW1xQkdMbzNY?=
 =?utf-8?B?b0dLMUtYQ2VOVW81ZXZrdnVvZWNHY0VtRnFTYVFaQUJnNG12bGxWbFFFaE5l?=
 =?utf-8?B?amk1aWxHVUVXYVlzazYzWkVzNlcwU3lqRzJJY016bW1FYU91bitHNER2cndH?=
 =?utf-8?B?N1BoMEJVRE1iSURhWHlIK0ZtWkYzNDZoeHJYTXBZRXdQQXdhcDVORGJpU09M?=
 =?utf-8?B?Q1RjajFsM3Q3ME9HTjdBUWlyZWdwa1A1aVh0U25GaW1aVFVnbi9GcEVIeXRS?=
 =?utf-8?B?cExYaFJJQ2VzaGZMNTVTQ2JoWmlvZjNueUltVUJyTm8zRGY2bUtDMGVHSTNW?=
 =?utf-8?B?N3o5N21LR3h1Lzc3UkVvZGZGVjl5a3R6OFdVcUlkV3NITDVEWXFoSlNROVRQ?=
 =?utf-8?B?dFE1Y2dvNW9zSFFXUk1xaXp0MzY5MjVMQzBXa2xhckhEOXBZS1UvVnJIZndK?=
 =?utf-8?B?UngrNWJVZDFrVElad00vSlZOaXRWWW1sdm94T0J4MTZUOG90S0ozQzkwTkVo?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FC5EC79FEFC5943B8E14EA2D940BBF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a533d55f-e4e4-4af0-11b3-08dcfac6f37a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 22:45:57.5018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yW5YiMWZoshOkFZm0OrP2FYQnsSgDfslFuqyzXLZCN2cKN3m/j5NbWKzUI9kzAvEtRutorGI7OVB3aT8Gk1oYS6Z1x6kgsy9f/vhwuWB/Oc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5959
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTExLTAxIGF0IDEyOjMwICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiA+
IFdoZXJlIGNhbiBJIGZpbmQgdGhpcyBiYXNlIGNvbW1pdD8NCj4gDQo+IEFoLCB0aGF0J3Mgc3Rp
bGwgbXkgYnJhbmNoIGZyb20gd2hlbiBJIHBvc3RlZCB3aGF0J3Mgbm93IGFwcGxpZWQgaW4gdGhl
DQo+IGFybTY0IHRyZWUsIHRoaXMgaXMgdGhlIHNhbWUgY29kZToNCj4gDQo+IMKgwqAgaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXJtNjQvbGludXguZ2l0
wqBmb3ItDQo+IG5leHQvZ2NzDQo+IA0KPiBTb3JyeSwgSSBkaWRuJ3QgcmViYXNlIGFmdGVyIHRo
ZSBHQ1MgY29kZSBsYW5kZWQuwqAgQXBwbGllZCBicmFuY2ggaGVyZToNCj4gDQo+IMKgwqAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnJvb25pZS9taXNj
LmdpdMKgY2xvbmUzLQ0KPiBzaGFkb3ctc3RhY2sNCg0KVGhhbmtzLiBJJ20gaGF2aW5nIGlzc3Vl
cyB3aXRoIG15IHRlc3QgaGFyZHdhcmUgdG9kYXkuIEkgZGlkIHNlZSBhIHNoYWRvdyBzdGFjaw0K
Y2xvbmUzIHNlbGZ0ZXN0IGZhaWx1cmUgYmVmb3JlIEkgbG9zdCBpdCwgYnV0IGRpZG4ndCBnZXQg
YSBjaGFuY2UgdG8gZGVidWcgaXQuDQo=

