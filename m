Return-Path: <linux-kselftest+bounces-15516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBD0954D39
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9065B1C21A44
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226861C3F16;
	Fri, 16 Aug 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/IgC50+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820141BE25D;
	Fri, 16 Aug 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819955; cv=fail; b=J0JSVmldqmGp6kRtd6njYg44wf9YwQac4/CulIjnMuLxAFcVfSdqtil7k4I0ocSDOvMlrzDuR1JWHa4YAtKryIEufCJgV/2ldgR/ToCWiR4JvYpxNAj9mkdlAg/L25RFxwJy1rMeD5YWeThebzp6YXbHUQ2Ou+Q0uC95oo1drfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819955; c=relaxed/simple;
	bh=ntiaql238B8hc0Atayja+850vIaXDHH9xXDK5KE1JPY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZopdX63CkaH9wYf7hRTB7vaWX490BPwaUe66WIvsZgL4xDxnOt2pYKOlWig+IQpJ1gGNTlrBZEhLPJN5hIq4vPIJWMz7bmWBKYLsmOb2aZ5vnsf/5WBjaYzc/zKQhPitK2GN0R7e7o9uVSXSM2nBiShPyEQA+fb8t6YoW/S15+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/IgC50+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723819953; x=1755355953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ntiaql238B8hc0Atayja+850vIaXDHH9xXDK5KE1JPY=;
  b=J/IgC50+qfaveZcDs1xQq2cQlfrnYvULpUYvDRM9jDnSjHAhHQ0V6XFy
   9bmbErKYaWCLiYeGeL6snGBipG4ThnsitoV4dqwpx+SMSLu98rIggPRj+
   VL1oGTaVej8HKB5cts733bFWIrzCEewlvNbNwt7BhTaMNAhBvCfMfgP1c
   G4qGXBCI9Zr6KEg6bqOFntHHVTJNeUvQuStuFib3sxXoJUWZyKB0+OWZ9
   aDlXUKIzVgQ//5upXOsER8xZkkkvuem+8fQzBpAh2bvBz6+3HYR1EWC4W
   4j06BjidH2bUZOGpazHNAR40ITI1VyLxXEZ1fIz8NkWdZ3MzpDhaandB/
   w==;
X-CSE-ConnectionGUID: lYpRPeOpQXuFXfDBZZX9Lg==
X-CSE-MsgGUID: zyK8bmGxSH+N40QfDm0C1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="39571687"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="39571687"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:52:33 -0700
X-CSE-ConnectionGUID: N+RN/35/Sf+RJLsYPSSAKQ==
X-CSE-MsgGUID: I5KXGKi6RPqrxmzdnbPrqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="82897517"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 07:52:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 07:52:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 07:52:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 07:52:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 07:52:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDQgJWNp5g1ayljOjpweyzLyZCXUStLVt+fR8kPdR70EN2uTZpk/p6KuHDSBEdGyB6GCDVSqhFNOSOwH5GtSDmi95aKoP5jAcX8hsoDovSNG3dP6SSiO/NYA7/sgCtXOXK5+Oi2cX3D3GHOMpvlyHxHQGttiV4cTNYkbAlr8cEXDFWMBZb+agG6jUJxjFdDPqwTOrsrEgThTIf2q5fTVCoRlC0EGf2l7zGdMQsKuoIyHOhRaNBn9HAIxUHtxz6M529tbgmD/84Cgok+Lo+vXTxYiIv+3ME4SqYkyMSweg6Hli4S/5aZVZa9rMvMpnfmIVOAhagcTqLFpBmfUlS/i2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntiaql238B8hc0Atayja+850vIaXDHH9xXDK5KE1JPY=;
 b=KRZptSur111sp7ZKWFwupqiNmIz9vJLYinfaDpuDKLKHpGpkKjJfdxr6QQqQJtLSzPMX8m8+nO6tLBHHUPlTaOS81rLBohSF+sxctPoYKqIUxJv65zLMbjRyDLgKj9nPEPLqfzO7eRLBhVsamWnP1OuAUmsl1d4WEX72HuI3DTs6CTTTzh4JC5EMnbDKYlpLO//oLfZsiyVwKcXgzA0I4lGhQCRymWaB9DnulJm4KDuSfuuWPJA4vJAqORXBh5nEVeWb6bgqV+HqcpFPEYdwMnjUoDxVN+nBkiIrCc1onRJGSGz2+c/36fVfG1dt/N90wreCuqYvUIjn5pVCr63N3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 14:52:28 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 14:52:28 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "Szabolcs.Nagy@arm.com"
	<Szabolcs.Nagy@arm.com>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "kees@kernel.org" <kees@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "jannh@google.com" <jannh@google.com>, "bp@alien8.de"
	<bp@alien8.de>, "bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Thread-Index: AQHa6Wtm9dJ/AN2M70yRn9JU+5jud7Infm8AgAIf0QCAAGa7gA==
Date: Fri, 16 Aug 2024 14:52:28 +0000
Message-ID: <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
	 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
	 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
	 <Zr8RfoHZYRWem1K9@arm.com>
In-Reply-To: <Zr8RfoHZYRWem1K9@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB7468:EE_
x-ms-office365-filtering-correlation-id: 1bfacef3-5faa-4266-1fd6-08dcbe030c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YzNaSGtBa2k5SXlYVTNRZ2NWOWIwYjY1SkZNKytzM25ZRUxXUEgyQXJWMjNv?=
 =?utf-8?B?R1c4WnE1aGNsNnV4OEE5ZFF3VEpndU1KRHdTdzNGNU8vdjZSN2FQRnBnTXV2?=
 =?utf-8?B?RmtlVTVYcndEMEpKU2VpSERlTHlDa2pMNWJaa3dSZ3BDM3V2SGdsZ25KSE52?=
 =?utf-8?B?ckJOdm0vc3JPYkM1VVB5MXllUThNOGJ3YjQ4T0RKZUE0RTZhM2phdGtTYnZv?=
 =?utf-8?B?OEVpL2w3WWRKb2VsSFY2bDJHeHB6QzdPTURxMndDYTNEZ2N5c21HWHg5ZkFH?=
 =?utf-8?B?U09MRlZZL2hTNVk2MlVvUS9TU2JBbVR2UlZXcEt1OUpidXRiSkc2R2xnK0dy?=
 =?utf-8?B?M3BrZnlaNzFrZ3czdWdiSTlZYm1rZ2J6dHNZcnlzWFhoeWpLenJXRDdWNW1W?=
 =?utf-8?B?KzR0aUU1NWZRNVkzRlBTVkl1NW9kajRXNy8yaDJ0ZzMzNUZ0bmRpNXJaOWpC?=
 =?utf-8?B?RnRvZHYvdWFoRjVHcVNBb3Bid2V6V3VzZTZ1dkRBT3prTmtoV2YwM24zU3o1?=
 =?utf-8?B?QVNLL0JyeGp2RUI2M0VLdG1YSFdrc25RRm8vYkk1ZThRTld6R2MwTG9CTmJn?=
 =?utf-8?B?eWJHZ0ViT002THNMNjdabUZpMkpBbmZEYWx2WkZJS2NZNnNmbFVseUFLdFpN?=
 =?utf-8?B?MExtb2tTQUJwM28vT3pYeVJVVXNBZWNXNWhjT29lV2FMcjRWVVNhTWM3RG5F?=
 =?utf-8?B?SUxSSWhzZ0N4UjlybHFkc3ZwWU11cTlyNks4ZVFuQzlhVktmUUk2UzJjanNm?=
 =?utf-8?B?WFFVQUFiSTFxejl3RlVhMS91OFVMdGtyL2o0Qkpwek9iQnRBYlJVQjBoejg1?=
 =?utf-8?B?Z3RWQmRIS293QnFnbW1lRGxyTlllb1FOY1BPSFUzZnBWUG5IajB2bi9QTGN1?=
 =?utf-8?B?YTBIbHRTM2loZUpCbENqU0phcG8vYXhxV1ZpYVl2SkJGUG55U2licGNUcWFD?=
 =?utf-8?B?TmRYWjMxenkxS1VadlIxTUttaitIcGo2UDc4RTJjaGFzdk5JaFMrYU0xNnlV?=
 =?utf-8?B?REE5L0E2K0sxWHJQcWl6Z1FseWJiTDFYZE0xWFAzMlRsZ2R5QUkyOVVmN0xL?=
 =?utf-8?B?L2Y4UDJCSm16ZitjaFpmaWg4SkhnSVZaWStTYVJ6VDVmRW0wUDFZR0ZzSUx4?=
 =?utf-8?B?QkFreS8rcVpCMkRqRVB2Y2dJejAzd3VPa1FYNGd3T0dpNzhwVFdQR2Z6YmRE?=
 =?utf-8?B?MDNNQ2NXNERnbHRTeDAvQTlLTjM0T2NvSVl6Wm1JOFZpMllPOGZoem44Ukww?=
 =?utf-8?B?N2xLa2JlcEh6dWZvbVBEUHFkd0lsa2NwbG1mK212TVcvb1dJcDl6MUNtWWN5?=
 =?utf-8?B?T041bFRUNlJRUExZdHRZLzFZMzQ1eG03U3lDNnI5b0RpaUJmMlpaTnNBdGVs?=
 =?utf-8?B?ZTNQSXB0aXY2TGRDUlkxVVk0dXVkVTNhMUI1ZE9CU0pqdjkwV3FwS25oQ1Zo?=
 =?utf-8?B?OHlneWxHWitjK0JjWjRlRlN5c2E2aHVMTkI1d1Q2Wm5GT0pvRXl6Nkc4Z1gx?=
 =?utf-8?B?T1BzNnE2UTZrYTVZQUQySGRkRlVCaFpMWG5RODB0VnBqQVRNL3dqZjhWY3Nk?=
 =?utf-8?B?cjdvT2g5WXdQSnE5SmhYcjg0Y0wxQU1NQ3ZyVXpCQ3RiU2thT0FTd2NPVW9H?=
 =?utf-8?B?NE5XNFBwUW9XZnRHb0FaL1V3RStIbDFhZk9oK2lGRXFGK2VGcjBDMlA0V2cx?=
 =?utf-8?B?ZjVBaVF4bVd2cEJBZWd2WEtOem9Gcjd5RkQ2QlQyTVFFTHE0VnVKenNZemdR?=
 =?utf-8?B?WldXbDYySUJ1amo0VEltMWp3Um5YUGZvUnlpSVFNeVQ5Tm1WRkRaL3ZYT0Zm?=
 =?utf-8?B?S29XMmRSZC82Q29uZ0NSMy9JYjNZVUxYOGN0dGZFTFFnNXUrMitNZWhkU28v?=
 =?utf-8?B?L3dCRlp6cEZuUFdVV2VnaEVQbzZiTHFGYm1vTis2eEo0SVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVdXYVhvbG9wOXhnYzJpZy92VFhvNFpKVm16c3JvU01NbnNrMmlCajNEMXll?=
 =?utf-8?B?dHhjcjY4STFPcFMrTkRMWTZKOWgvYkF4QmJjNWYwYmJjQTB5bnd1cFJPUnpk?=
 =?utf-8?B?TXhvRU80MmI0R2pQa3NRem11TzNCN09lMXcwVjJhdnozNHhhQTlQQXgyaHRT?=
 =?utf-8?B?dXBCaVZ4MjZoM3dpMXlmOFY5RUNEREhPNm5EREg4U1RhOHZibkJhbTZCQ0Rq?=
 =?utf-8?B?MEZ5R3BhSEJsNEVoM1c5b1A3aDhHYnY3UTVFKzhGeHhta3pDTnR0d01rSjdq?=
 =?utf-8?B?eHJHaVhaRVp4WWRKSzBTNE9nVFo4dHRnRnJyZG9Xd0NjdVlvM0VrUlJpVUJy?=
 =?utf-8?B?RFJ0U3ZydUFTYlVkVEl3bWEvaGdaV2lFK0hwUHdyZE9pRVNEa0JFWTg1Z21O?=
 =?utf-8?B?WXIvM0tkNmlERkl6a1RpYmlEVDBHUmdKc3JHT0JNRWNzWk12Q0gzU015c1Bo?=
 =?utf-8?B?RkVGU2VHNnA4U2ZMMHpSczR3YUl6Y3gvQXRkWEsrbDc4ekJvbVBuaThkM3hQ?=
 =?utf-8?B?Q3Q2RjJGa080SGx6eVc0OEdjemlzVWhMVjMvM09qaDNGaDhiMVViaThrL1BC?=
 =?utf-8?B?ZVhsQ0lyUmpteFlVdzB2R3B5Z25TU3dqRFhERVhGMXVZNVhKeWVHeGFsQ1po?=
 =?utf-8?B?dFlNcHFHUnM4L3pqVVJMbUc2TTA5cjRkaGtFNTdpZ3R1NFJSRHAzQVlxd3hF?=
 =?utf-8?B?WkJwVGtuMVVURDlXQnczZ3hpdEdHUTZqeGxFb2hndFFLbmVrUVpGb1R0SUJw?=
 =?utf-8?B?WndvRzJwREt2dVg2NG5ZZ01YV2NHSVphRUdydG90YlU4WEUrakFEZGordjlt?=
 =?utf-8?B?cVZ3UDB4ZGFmMGJyRmVTTngycFlQYTEyZ2pNN0ZzMHFEbjU3ZGN0OGxpaTZR?=
 =?utf-8?B?VTVmRER2UUdTcVJTUkdHZStxc3BRZEV5NkMrclJSK0IrSUEzdmZwR09NenJ0?=
 =?utf-8?B?VG9aRU00d0xDaHZrVkQxNmFuQ2xRQUJ4anVRc092MjJRVFNqWStQZlhVMW12?=
 =?utf-8?B?d0lFOFM5RkU3ODRJcFMyNEFzNXRlR0hOOU1rMGdTdlFybFhhemhiYnRWVGZn?=
 =?utf-8?B?aTZOdTZiWUNkSE94VzBwZFBTaGM0Z3RBSS8zSUd5SHdRQi9WQ0tDd05qcWdT?=
 =?utf-8?B?cUpMc25kV2w5cEFzZFdaWXZyUGQvK0w1SyszZlZFeXIvSDdkQmpnblU5WUpQ?=
 =?utf-8?B?MW9hZ0RSVG16bGdOb3FCZkkya0twbjFVYVBkUDQvSkVMcTEzdmZEWTM3SnlZ?=
 =?utf-8?B?cmttVnljejJCd1ZKOTM3RitBTEtadVBsZXdvYlhDNFlEUGRYYjBMUWk2d1Ay?=
 =?utf-8?B?Q3Uvd1RZOFFQdks1bDA3ZEFqWjdRV3ZxcExRb2RCMnBhUjR6WDJsaVJPdllD?=
 =?utf-8?B?TTgzdUxYaWc4UlVKWlh6dVoxazZHNlA5TERYUTNwZFhzMTlhU1g2SjVJczk2?=
 =?utf-8?B?am5EU0oyQmp2UkdocnlaVG5wRHNWWTByYk1pZkpmM25xejF1RDVXdytWaXJN?=
 =?utf-8?B?RTFEbnU5cG9ZWGZsQzgraUhzQ01tS05aOFdyZ0pNREVOaFFqTTgzQlJaT1da?=
 =?utf-8?B?Umx4ZkRJWnJINWRZa09GLzFMeGE1cThncFJOcmVkdE84Z3dMdzJLY21lbm94?=
 =?utf-8?B?a2pNazBnVHdzTHp2TkRaWW1jZ3FRQ2F4TGRwY1RWcUFGNGllb0xCZDRjSFRF?=
 =?utf-8?B?ZnFFQ3l5Ymp0eFA0TzVDR1JpU0NBNDJVWWgxTTZLRkNvUDRkcXQ1YmdrREN1?=
 =?utf-8?B?U1M0Mkp1UTQyQXdtZFgvYlJvdzlVclJNRFQ4cGlyemNLOEVOY0g2eXJ6d2xm?=
 =?utf-8?B?TVdMTitZdkJkU0E5emt4RFduMmlKU0ZYT2Fid1VpVTlqMmoyNHJZNVdCK25q?=
 =?utf-8?B?N0xuNGNHVUtQc1NTTWo0eXFxbngyMmJzK1JzV2VWNTFUWVVhTFlOQ2s3SXpV?=
 =?utf-8?B?RHU1TmZaQStIYmo5blNyVUM0Y3VqaERSS3dTdThNMFE3NGk4TnNxYVNaYWlr?=
 =?utf-8?B?UDdKZytvbFYyS2Rwc25iYklUbzZ6eUtGQUF0RTBSOU0vR0plNXorYldEOUJP?=
 =?utf-8?B?MkNIZTJ6emZtSFRmaHFBTmJqZWt5Zk1XbEhSRlp0QjBrOTdIUGxRSFBpRmZq?=
 =?utf-8?B?VGphWHdpMmtTUnJTS2gzaGpYb1FXd3Uwc2h0dUNJa3ZkYUZ4WG92bDBuSHA2?=
 =?utf-8?Q?hFoxeHaN1gdHysP5+pRvfYQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9227ECB03BDB439D4C3F5AAA77A8A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfacef3-5faa-4266-1fd6-08dcbe030c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 14:52:28.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ycaShlc64zYINeMxbAth2Se/7O+SE5QrdPw0XnC+QA0geiYn735CxiYCroffnQEScwj/FTuGE8gj0/2A1MQmyFUlHarayq9lgJH+8ygUZL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7468
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA4LTE2IGF0IDA5OjQ0ICswMTAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6
DQo+ID4gQWZ0ZXIgYSB0b2tlbiBpcyBjb25zdW1lZCBub3JtYWxseSwgaXQgZG9lc24ndCBzZXQg
aXQgdG8gemVyby4gSW5zdGVhZCBpdA0KPiA+IHNldHMNCj4gPiBpdCB0byBhICJwcmV2aW91cy1z
c3AgdG9rZW4iLiBJIGRvbid0IHRoaW5rIHdlIGFjdHVhbGx5IHdhbnQgdG8gZG8gdGhhdCBoZXJl
DQo+ID4gdGhvdWdoIGJlY2F1c2UgaXQgaW52b2x2ZXMgdGhlIG9sZCBTU1AsIHdoaWNoIGRvZXNu
J3QgcmVhbGx5IGFwcGx5IGluIHRoaXMNCj4gPiBjYXNlLg0KPiA+IEkgZG9uJ3Qgc2VlIGFueSBw
cm9ibGVtIHdpdGggemVybywgYnV0IHdhcyB0aGVyZSBhbnkgc3BlY2lhbCB0aGlua2luZyBiZWhp
bmQNCj4gPiBpdD8NCj4gDQo+IEJUVywgc2luY2UgaXQncyB0aGUgcGFyZW50IHNldHRpbmcgdXAg
dGhlIHNoYWRvdyBzdGFjayBpbiBpdHMgb3duDQo+IGFkZHJlc3Mgc3BhY2UgYmVmb3JlIGZvcmtp
bmcsIEkgdGhpbmsgYXQgbGVhc3QgdGhlIHJlYWQgY2FuIGF2b2lkDQo+IGFjY2Vzc19yZW1vdGVf
dm0oKSBhbmQgd2UgY291bGQgZG8gaXQgZWFybGllciwgZXZlbiBiZWZvcmUgdGhlIG5ldw0KPiBw
cm9jZXNzIGlzIGNyZWF0ZWQuDQoNCkhtbS4gTWFrZXMgc2Vuc2UuIEl0J3MgYSBiaXQgcmFjeSBz
aW5jZSB0aGUgcGFyZW50IGNvdWxkIGNvbnN1bWUgdGhhdCB0b2tlbiBmcm9tDQphbm90aGVyIHRo
cmVhZCwgYnV0IGl0IHdvdWxkIGJlIGEgcmFjZSBpbiBhbnkgY2FzZS4NCg0KPiANCj4gPiA+ICvC
oMKgwqDCoMKgwqDCoGlmIChhY2Nlc3NfcmVtb3RlX3ZtKG1tLCBhZGRyLCAmdmFsLCBzaXplb2Yo
dmFsKSwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRk9MTF9GT1JDRSB8IEZPTExfV1JJVEUpICE9IHNpemVvZih2YWwpKQ0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0Ow0KPiA+IA0KPiA+IFRo
ZSBHVVBzIHN0aWxsIHNlZW0gYSBiaXQgdW5mb3J0dW5hdGUgZm9yIGEgY291cGxlIHJlYXNvbnM6
DQo+ID4gwqAgLSBXZSBjb3VsZCBkbyBhIENNUFhDSEcgdmVyc2lvbiBhbmQgYXJlIGp1c3Qgbm90
IChJIHNlZSBBUk0gaGFzIGlkZW50aWNhbA0KPiA+IGNvZGUNCj4gPiBpbiBnY3NfY29uc3VtZV90
b2tlbigpKS4gSXQncyBub3QgdGhlIG9ubHkgcmFjZSBsaWtlIHRoaXMgdGhvdWdoIEZXSVcuDQo+
ID4gwqAgLSBJICp0aGluayogdGhpcyBpcyB0aGUgb25seSB1bnByaXZpbGVnZWQgRk9MTF9GT1JD
RSB0aGF0IGNhbiB3cml0ZSB0byB0aGUNCj4gPiBjdXJyZW50IHByb2Nlc3MgaW4gdGhlIGtlcm5l
bC4gQXMgaXMsIGl0IGNvdWxkIGJlIHVzZWQgb24gbm9ybWFsIFJPDQo+ID4gbWFwcGluZ3MsIGF0
DQo+ID4gbGVhc3QgaW4gYSBsaW1pdGVkIHdheS4gTWF5YmUgYW5vdGhlciBwb2ludCBmb3IgdGhl
IFZNQSBjaGVjay4gV2UnZCB3YW50IHRvDQo+ID4gY2hlY2sgdGhhdCBpdCBpcyBub3JtYWwgc2hh
ZG93IHN0YWNrPw0KPiA+IMKgIC0gTGluZ2VyaW5nIGRvdWJ0cyBhYm91dCB0aGUgd2lzZG9tIG9m
IGRvaW5nIEdVUHMgZHVyaW5nIHRhc2sgY3JlYXRpb24uDQo+IA0KPiBJIGRvbid0IGxpa2UgdGhl
IGFjY2Vzc19yZW1vdGVfdm0oKSBlaXRoZXIuIEluIHRoZSBjb21tb24gKHByYWN0aWNhbGx5DQo+
IG9ubHkpIGNhc2Ugd2l0aCBDTE9ORV9WTSwgdGhlIG1tIGlzIGFjdHVhbGx5IGN1cnJlbnQtPm1t
LCBzbyBubyBuZWVkIGZvcg0KPiBhIEdVUC4NCg0KT24gdGhlIHg4NiBzaWRlLCB3ZSBkb24ndCBo
YXZlIGEgc2hhZG93IHN0YWNrIGFjY2VzcyBDTVBYQ0hHLiBXZSB3aWxsIGhhdmUgdG8NCkdVUCBh
bmQgZG8gYSBub3JtYWwgQ01QWENIRyBvZmYgb2YgdGhlIGRpcmVjdCBtYXAgdG8gaGFuZGxlIGl0
IGZ1bGx5IHByb3Blcmx5IGluDQphbnkgY2FzZSAoQ0xPTkVfVk0gb3Igbm90KS4NCg0KPiANCj4g
V2UgY291bGQsIGluIHRoZW9yeSwgY29uc3VtZSB0aGlzIHRva2VuIGluIHRoZSBwYXJlbnQgYmVm
b3JlIHRoZSBjaGlsZA0KPiBtbSBpcyBjcmVhdGVkLiBUaGUgZG93bnNpZGUgaXMgdGhhdCBpZiBh
IHBhcmVudCBmb3JrcyBtdWx0aXBsZQ0KPiBwcm9jZXNzZXMgdXNpbmcgdGhlIHNhbWUgc2hhZG93
IHN0YWNrLCBpdCB3aWxsIGhhdmUgdG8gc2V0IHRoZSB0b2tlbg0KPiBlYWNoIHRpbWUuIEknZCBi
ZSBmaW5lIHdpdGggdGhpcywgdGhhdCdzIHJlYWxseSBvbmx5IGZvciB0aGUgbW9zdGx5DQo+IHRo
ZW9yZXRpY2FsIGNhc2Ugd2hlcmUgb25lIGRvZXNuJ3QgdXNlIENMT05FX1ZNIGFuZCBzdGlsbCB3
YW50IGENCj4gc2VwYXJhdGUgc3RhY2sgYW5kIHNoYWRvdyBzdGFjay4NCj4gDQo+ID4gSSBkb24n
dCB0aGluayB0aGV5IGFyZSBzaG93IHN0b3BwZXJzLCBidXQgdGhlIFZNQSBjaGVjayB3b3VsZCBi
ZSBuaWNlIHRvDQo+ID4gaGF2ZSBpbg0KPiA+IHRoZSBmaXJzdCB1cHN0cmVhbSBzdXBwb3J0Lg0K
PiANCj4gR29vZCBwb2ludC4NCg0K

