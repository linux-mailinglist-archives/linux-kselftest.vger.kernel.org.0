Return-Path: <linux-kselftest+bounces-18933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF3F98E4DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 23:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126881F213DA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6F216A33;
	Wed,  2 Oct 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBjbozO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEE745F4;
	Wed,  2 Oct 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904314; cv=fail; b=U44Iu4oAJX7NS2FeBxuLvWxp1IWuSl4bga/5jH1p+dvDjNPsIqqCvTjiW8xey3V+/ydFeRKVBCK6XmbALxD1AkT/7TzsLeKTt3ht/GvMKS00RZQOviKbqVZicwuKjBuo1/OMfBzadE+k8NIR/7z93emy0EtE5RwNe8Oz+Aw/W7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904314; c=relaxed/simple;
	bh=PJ40VmxKOqKKGPd/LOZA+RlrQTi8SJFBTIagBUR0iko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zubw+fNPVTKrkd0XHVYpLzgKboQ8WKgPWrq4k7BEwimNdOzuOr9TR8lZqsYlmNhYg1iGSf/Syp8INJ6uw4nh7XdHKyJwtZCYUQqg3gR7/uYtUSHos6XkUEs7D3ZyriYfvjhwZE2BsydUo6Mt60xOsrVlKXM5t5ZsiQG1DCSrLkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBjbozO/; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727904312; x=1759440312;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PJ40VmxKOqKKGPd/LOZA+RlrQTi8SJFBTIagBUR0iko=;
  b=YBjbozO/bRDil1C0pT0RE8GvfArXCN/EcNjhzt50a4Ej7JhFOveYzplh
   siyzseVaWiOPqeJrTMUq7QxEdXa9ZYw0lcpI0O3WeioyrBm9QUNpfF4/F
   hOwAgRX5W6wAYPjBIVbnDdYPg9bz7O3AgqRqfxrCZPfTISetnxJTz3Afw
   oBLnYx9fSYffpoQyJYlhm9gBrCw99a1PjlwE3xklj+qv5z4MwvBpdTOfK
   4jwZKnapY4K1lv3f2MoF4SsyHs4rm9nuennn2BWB1n4UMKL0/SzWNi3e4
   4tz/MaByAH2zC+TiVvHvlLluXm/H+km4qKFXpUKw/VN3zHwOFI7NzQEKn
   Q==;
X-CSE-ConnectionGUID: LtpfB7SiSpm4fzUgWQpyPA==
X-CSE-MsgGUID: k/IPpcoSRSWIMLDDbvXOAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27033628"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27033628"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:25:11 -0700
X-CSE-ConnectionGUID: esvjfi5pQOW0s04EskCvTg==
X-CSE-MsgGUID: R9RcYDcsQZSLp+oyaSqKnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73989631"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 14:25:10 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:25:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 14:25:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 14:25:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 14:25:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzyUeecvjlDKCr8uEmasEGfoCQ5CX6PpnDABZHv486ZJG52ir1H9rlgu+v9tV/sQlsNm9zLTrc9Wz+Yy25dgY2vr9AzmBW3I9qNQ9aallVvDdcsuaXCsn/o9KWrURzEuJ1v38RoOTC92wQWybj/5g8MfB7VXynouaKqCWyExIKrsxMZ/G04O+MPXnZlFZDJd7zmDzcnTlZOpqVuzwRo+PHUPAPQlLY6loP4D3YJiNC3acPA3MiRNZchsYw5xmOzbYyQb4YVSj3N+WjINjtYcScIV1B0mhrobdKJnGjfXutXqZAJDQVTWM8pk0rSOLakPre3fZE7VDfFyIKpNev8tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ40VmxKOqKKGPd/LOZA+RlrQTi8SJFBTIagBUR0iko=;
 b=cQDG1DqhUO2+6qGQHnQ42OFvhwsIAsptJQBxLZ2oCk9Lq/oJc0DQ2wRTiZoRuMZ0vruo0Q7BtflJ70tCLv+Z6Unlr8TI1aGMavsimXjc95omkumt0e/aY9Rq9Fw4wzTh+o9Eblp1UInLKCUFES7SgmXzmls3p0Og5QsbiJ+I1eO8Hkezw/PaiRxr1t3ej0SfRQwC3UT5Xgt15wqu1kuiI+VYhQ/NaJrCtjWBxSb4r2kKuVjvGtdYDybRE4MzBwKs2rjPCdqHErlT9Gd96EqLlmFgYg7Y4JeUPbgoeUO99GEhJq/kDB/kFQYxBd3KFYf8kk8anlFMEaJjLPLW2r04QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7246.namprd11.prod.outlook.com (2603:10b6:208:42e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 21:25:05 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.8005.026; Wed, 2 Oct 2024
 21:25:05 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>
CC: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "x86@kernel.org"
	<x86@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "hjl.tools@gmail.com"
	<hjl.tools@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "kees@kernel.org"
	<kees@kernel.org>, "will@kernel.org" <will@kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"jannh@google.com" <jannh@google.com>, "yury.khrustalev@arm.com"
	<yury.khrustalev@arm.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "wilco.dijkstra@arm.com"
	<wilco.dijkstra@arm.com>, "bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Topic: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Thread-Index: AQHa8m26gF70aSw9iE+4TuW+hH2kDLIwrUEAgAAg74CAAAZZAIAABi0AgAAX+ICAALiNgIAANM8AgAAYugCAOZcagIAAbUIAgAZGuACAACdJAIAAXC2AgAD1xgCAAHp6AIAABq0A
Date: Wed, 2 Oct 2024 21:25:05 +0000
Message-ID: <b81b2994e286259a78f3d20660469e88a8b08c31.camel@intel.com>
References: <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
	 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
	 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
	 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
	 <20240927-springen-fortpflanzen-34a303373088@brauner>
	 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
	 <20241001-atheismus-stetig-4f6f3001715c@brauner>
	 <6bf15851-03fe-40cd-b95c-f7e2ca40ac54@sirena.org.uk>
	 <0999160fd5282ac129aab300b667af35d7251582.camel@intel.com>
	 <b7ef38c9-1e87-468f-94a5-a3c7f209d200@sirena.org.uk>
	 <Zv20luC6us-LEMqN@finisterre.sirena.org.uk>
In-Reply-To: <Zv20luC6us-LEMqN@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7246:EE_
x-ms-office365-filtering-correlation-id: 0bc5fc36-ef99-42fb-8cfd-08dce328af12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2ZhNDBwajVDZzJYcmpIMFA1M0VRQWYyN0ZOSGwzQi94WTFuempQdUhDRmda?=
 =?utf-8?B?Y2Q1aTQyOHpyS3RxZksxZExPT3g3OGFXOVoxSmNzOTVmZ2RqQ09Bd0RiVndr?=
 =?utf-8?B?ZVA4eSsxYkZUdHo4eDROOXhDZlB5Y0x4S0lkZDFqbUU0dFpmZEFyUUFzaVpl?=
 =?utf-8?B?VUI5VHBkdkpDY0FPNFRpdHV5S1lZVHRpdHFaVFN6UnNSTEdFMkFWaEh0MmRI?=
 =?utf-8?B?SHNRL08zYW9ncnk2MHVJRWZHTkt0ZWFxMkw4Y0QybzRaZTJuSUpwQ0dKVVhJ?=
 =?utf-8?B?YmNadm1jSkZ3cHNlS0s4OFJsc2lOSnNFV01uZUxGVDNGd0dTM3g0bUppNDdB?=
 =?utf-8?B?a0luN0hKNjZNK0lzZTYvZUVyaFpyeTlPWG9yS05KM2Zhc096WGkzanJ0eFFv?=
 =?utf-8?B?Z2ZHQnFKZnZLUTE3TXh0akFDUVBmM1hBN2IrTFQ5V1djYjk1dXdWWkZLdkJn?=
 =?utf-8?B?VWNGajVheFhRL0ZmUTFET0dzK1d5MThTaHdna1YxY2NFOFFSRE1ydWozQmFa?=
 =?utf-8?B?d0ZVNFM2VHIzbnIxeTlRNEk3VForbUpMV0MyM0NtNEUvQU8yWjR6MFB0MjdW?=
 =?utf-8?B?TWpWeCtIMUhKbU5vRGg1TTgvbTFrY2NyZzJIR3ZvL2REekVKOGlJN3Nyb2RP?=
 =?utf-8?B?V1hRRjV4TktidmxhVXIvSXRMcXpYY0s3VXQyK1l5K1h2a0d0Mms0cUttTUx6?=
 =?utf-8?B?N1VEazk2TE1Od0FxV1VXb1MyeEZRM3U3L05obVVmWGk5RE1vdzJlMEwzRVRY?=
 =?utf-8?B?Vms0V1BmazVEV25uTEtkTk1PUkROVXRicENremZzTlRiT2dYRzJnQlV4QUp3?=
 =?utf-8?B?dElBRWo0TFhueXNPa3BQZm51TGRleWNlUm1YaXhSQUU0YWNjYlUvU0ltdXVX?=
 =?utf-8?B?RStVN05Kc2E1aW5OVW83aURJZkxpNEdFZ3I5Ums2UEx1NHdSSnRHOHZXK3lj?=
 =?utf-8?B?alZjWTRxY2huQVE5ejJ2eEIzSFFHQ3VMT1Bkdm0rTnltNVNqTmIzL1hpTUVx?=
 =?utf-8?B?UElZNnRyT1pLaFM4SUpXYTdpTVJuczRSTnFtWFFlTk01cjVmM1l0Szdyb0Fw?=
 =?utf-8?B?TjhTTEdMN2JZdFo2ZFEwUHdvelFYNkYwS3hOZTFwbDJ1dGNDT092Y29xSDhX?=
 =?utf-8?B?UzFORnQxaDRWaEtsVkxxRXdIMmdDdTZCYVFPUDA5NVFMT0haQk1qdS9SYnFu?=
 =?utf-8?B?TFBPQUVSOFJFZW5xVzNqNnpuRHBJQks2eUdrTGkyWHBuVHZxUXZaWG1IN2V5?=
 =?utf-8?B?bGttWENsbkpUVXZIaVAzSHdRZ1N6UEw1U3RHUjFZekE2RHhvbDJZL1RZUkxQ?=
 =?utf-8?B?eTUyditxZHNEYm1UeTYwdkFPbS8zQzYyZGxRWVlxbW1wdkJLVUlyaFBER0w4?=
 =?utf-8?B?S2h0WmdBbCtKMDRWaXV6NFFCb2d5alFpZHdkWUdOOGFES3ppS2poTWMwZ1R1?=
 =?utf-8?B?TWM0YXVydFAvK083Zm5QVGpiczhSQTFod2t1cm95MjlqVnBhRXFxSzdJU2pu?=
 =?utf-8?B?MGJZTndpdENGZGVVT2NUWHN5clBhd3N1U0RpYnJqQTFNZUlySGdQL054ZHVt?=
 =?utf-8?B?a0VraXRxVVZ2dk9CaDV5ZWhiclRvbkN2ZjEyYkdsRndMSUc1eDQ4UzZZRjV5?=
 =?utf-8?B?d1JhYUdBODNQWnZ3WHNiZ2lDMldIKzhPN0NhVEp3VU5ucXo4ZVVjcm1KdmRr?=
 =?utf-8?B?bUlVK3Jrb2ZVRGI5clNUWmZuQjM0b01iR0Yydk9YYkNHOFMramp5RVFMWlVW?=
 =?utf-8?B?MTZHVS9FUS9MZTN2dmt4ZGRkMitYbjZZbnJhNEJEdzRxWW81MTBDL1FEc3pq?=
 =?utf-8?B?Tk9TeGEvT0t5akttVS9VUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW5aUGhrRGR6czM2czh1dFBnOS9wQkJLdFRvWkJsSGVBeW1XczBScmFvV1R2?=
 =?utf-8?B?QS9FbWZaOVJhR2pYK3BrMm1nSERVT1N3YnY3RGpUU3VFOC80dHg1Y1MwWDd4?=
 =?utf-8?B?SDZ5dlArTnY5ZVlYT1VTamRFcTJMYStIQnV6T2o1TGNBb09UUzJkM2pmZ2NK?=
 =?utf-8?B?QzBuTjdOMVNFeHNvN1dCZHJXTkZnalBXOUM5bTFRWU9NRGtyZVlUb3Q0MitI?=
 =?utf-8?B?TzNkc2pLbUlYUmRHVkpzMWptSGFvY2ljVmw1cGRCS0ZmWjZQTzJ0dXllVjBV?=
 =?utf-8?B?QVhRZDl5cFIxckVVMmEwajJFUUhLcUVteHpzemFOR2hkNWZrb205ekxvWkNB?=
 =?utf-8?B?VkNRYnJqMTB2UHd2eFRMODRJQm01bzMyZXVKeG1zUWtPdzI1enpldzI5WE5V?=
 =?utf-8?B?ZVFSL0VtN0RLb2ROMmVEYklMNXo3VGVaZGQ0c21mb2pZRWV6MkZUb2R6dXBv?=
 =?utf-8?B?QlpoMDhqcGwzcWhjTnVWYitVcnBzMkp0cXlwSU01OVdqdUZ4anFPZ3h4UkEv?=
 =?utf-8?B?WCtCdjcwSURqdlBheFJVVXJGV2hWdXFhN3VNcGE3Zm8rQkxoeTFwd3hERTlV?=
 =?utf-8?B?MmxSSTlzZVkvSnlOTHlhNkVaU3NkU1g0ZTErNjJNYklqTnBIV2o2Sko4cVZw?=
 =?utf-8?B?MDRlblVGSFNuUFBWaTRBb2Q2UDltYWIrUWJTNWxMb0w1dGZ3UUtrTlJ1NlRN?=
 =?utf-8?B?Mkw4NmdjWFB4alYxa2dMTkpxdnJDZDJ4VUUxRG8vMFBpVmVDZ3h4blc0OW1V?=
 =?utf-8?B?bEJrM2Zsa1pHazFhSElrai9vTlNVakRHWTJ1Yk1Jclp0SUI3UFVEVzk1U210?=
 =?utf-8?B?c2NuWXd1ZzRKa29hMGVDbklDeEhXUWFGWm14cFdNSWxxRC9iUG11eEYzbjQr?=
 =?utf-8?B?TFpvWUJIK0RMNDRQdkV6U2Zjc0dWNERDUkFCYlAzdkhLTHFKVGZKTVA3QitM?=
 =?utf-8?B?WWRacERScENmYkhrZkVxU3V1Y05PNGxyT1FDbXhHU3FCaGF1TGs5cjcvQ1M1?=
 =?utf-8?B?NGE0N2JjTjVqTDdaZTAwajA5L29zTjA5SGp6SjlmODF1RkorcmRkNXA2ZVRp?=
 =?utf-8?B?ZjNjK00yVFdPYkFrUnVUcUpxVlcvVnN0MkJXeVBZTDUyUU5EUWY0QWpGRGcv?=
 =?utf-8?B?UW5aeFROSCtBTVJTZ0w2cGd4dHlzZmpTcWNoN0lWc2w4OWZ5dlJaNExQVDlh?=
 =?utf-8?B?L3ZNRU1zZkNXK2QyOUQ1Uk4zVEp6SU55c05MN1JPVm9iLzU5eFFQa2dKNlR1?=
 =?utf-8?B?emhjRjJWcWEyVjVuUU96U0U5TkxrOFdXK1F3QnFCY0l2bFRFbjJWY2Zva3Rw?=
 =?utf-8?B?STUyQm84bEJlUGZhNmVmRGU1YlhKazkvcUFNcWZaTy9xVDZMYldCSG5pY1B1?=
 =?utf-8?B?TkdVclkzNkRjN3B0TjE1clZYdURtSVh1Rm5ESWZwUTdaWkZaZ09CQ1pFZmdY?=
 =?utf-8?B?M2NtZk5NY2tweHJ1VEw0OFhCSHZTWXVMQnRCU3FCWm5GckNSb2p0bzZwcGc0?=
 =?utf-8?B?RWRaeEl0ZG5TdFFyREo4SFhqTVFXNmtPL1cxT2NicUh0L1JpbHFGdEFHTkxB?=
 =?utf-8?B?M0xJR0pocmt5OEVkbi9Ycm5Wc0pLNzFOemtiVi9yVWZQSkc0REI4TktWSVha?=
 =?utf-8?B?TCtBdG9hWGV6ekhhZlpSODdFZ3BISFk3OUU0NTFKbUQ4RWJkV0pwbWh0US91?=
 =?utf-8?B?RzAxOG4yMEwxT3NqR2Q5d0NFYVAzUmQwSzYxem5xaG9PZ2c2SDVoVDY4bDZY?=
 =?utf-8?B?bHEweGJrWFdiUDNlblB3SGcrWU9aMVBBc1pXMlJjZWVTSVZLcGFqMUFDNTdT?=
 =?utf-8?B?bjJyWC9OY0VoNUhQTjFxZ2Z6SC82bGN4dlBwT0xSSGRjUUFyVEtNaWtFY2hx?=
 =?utf-8?B?TjdIdnY5L01nSm9KemM0SmtkQnBIc0NyMGhQWU5JSnNva2Z0VVc5WmRhVEI1?=
 =?utf-8?B?NmxKVkQwNjNHZTVrZVoyVW5jajFwNC9Vci9ZUkxReFRkYW8yY0IrY1ExMjda?=
 =?utf-8?B?VmtHM0ZXZ2tBUExMSFErZU1iNGc3SUNJTjFtbjY4MVJ4d2I2QmxjbEhSTml4?=
 =?utf-8?B?Q21BWGxtNlRXK2JlVHlPOVByOVlPZ0g1dXlmbHVhNjF0TmJIc0NuYnVqTC9W?=
 =?utf-8?B?R0RVUjMwbjFJSkY3YmR6RzBSbElGRmpxazZDRmJOd0c3MHR4UmdYS2dUc21s?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99E3A33BCA56D346967DB1CE672BECA0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc5fc36-ef99-42fb-8cfd-08dce328af12
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 21:25:05.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cA1CZjFoDB+LmVvCAZ1di2HTIp4boGgQnoqDBPHpzSOgerDpZoqvVAAxUXcqUmS5tW4UlUkUdkJtelxg2gA2Pj8aoQ/pMdjH9YeauWXZwS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7246
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTEwLTAyIGF0IDIyOjAxICswMTAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBC
VFcgaXQncyBwcm9iYWJseSBhbHNvIHdvcnRoIG5vdGluZyB0aGF0IGF0IGxlYXN0IG9uIGFybTY0
IChwZXJoYXBzIHg4Ng0KPiBpcyBkaWZmZXJlbnQgaGVyZT8pIHRoZSBzaGFkb3cgc3RhY2sgb2Yg
YSB0aHJlYWQgdGhhdCBleGl0ZWQgd29uJ3QgaGF2ZQ0KPiBhIHRva2VuIHBsYWNlZCBvbiBpdCBz
byBpdCB3b24ndCBiZSBwb3NzaWJsZSB0byB1c2UgaXQgd2l0aCBjbG9uZTMoKSBhdA0KPiBhbGwg
dW5sZXNzIGFub3RoZXIgdG9rZW4gaXMgd3JpdHRlbi7CoCBUbyBnZXQgYSBzaGFkb3cgc3RhY2sg
eW91IGNvdWxkDQo+IHVzZSB3aXRoIGNsb25lMygpIHlvdSdkIGVpdGhlciBuZWVkIHRvIGFsbG9j
YXRlIGEgbmV3IG9uZSwgcGl2b3QgYXdheQ0KPiBmcm9tIG9uZSB0aGF0J3MgY3VycmVudGx5IGlu
IHVzZSBvciBlbmFibGUgc2hhZG93IHN0YWNrIHdyaXRlcyBhbmQgcGxhY2UNCj4gYSB0b2tlbi4N
Cg0KSG1tLCB5ZWEuIEkgZGlkbid0IGhhdmUgYSBzcGVjaWZpYyBpZGVhIGluIG1pbmQuIEJ1dCB5
ZWEsIHlvdSB3b3VsZCBoYXZlIHRvDQpzd2l0Y2ggdG8gc29tZXRoaW5nIGluIG9yZGVyIHRvIGxl
YXZlIGEgdG9rZW4uDQoNCklmIHlvdSBlbmFibGVkIFdSU1MgKG9yIHNpbWlsYXIpIHlvdSBtaWdo
dCBiZSBhYmxlIHRvIHJldXNlIHNoYWRvdyBzdGFja3MgaW4NCnNvbWUga2luZCBvZiB1c2VmdWwg
d2F5LCBidXQgaW4gdGhhdCBjYXNlIHlvdSB3b3VsZCBwcm9iYWJseSBXUlNTIHRoZSB0b2tlbiB0
bw0KdGhlIGVuZCBvZiB0aGUgc2hhZG93IHN0YWNrIGFuZCB0aGUgc3RhcnQrc2l6ZSB3b3VsZCBm
aXQgYmV0dGVyLg0K

