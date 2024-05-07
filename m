Return-Path: <linux-kselftest+bounces-9582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3298BDD74
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAED1F2305E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 08:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6514D2BD;
	Tue,  7 May 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5joAMGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A313C9A2;
	Tue,  7 May 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071660; cv=fail; b=k7RKTIYdMCHQ+t4gwiMQ0LBKkgHBSe4jfJTJVhct2t3nuEuY0Rs39DjEYYXFlEbWy+mLmVEIXkm0EFr2u21oUY8BjUfdUYwEzhJ5ilYoheprgd6zOf+k+Mf4RQSDejuB4etNCUSJY5ZpknGLP2NntfKZHIHOSsdLicNWj5qID0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071660; c=relaxed/simple;
	bh=BQ8OmVPkzGwOA1SLJNC1KQhYe+wZR2mOnl6BuhXgUf0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FbUFP+2PD4YVrKstHwi+TyJzlN5U+tTX3yduEJ37VnE/k1JxGlnYtb685SNYjFcbfQy3zm+JYk7JgAhEtUz4YyqTEYQEWAtwNSwUUQdhpISv7BQkYR2yudxN3ohMZx9HAobDUL2S2QvxKlc8rCjflAzgKnXF5YMwQqMhyl0q9KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5joAMGZ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715071659; x=1746607659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BQ8OmVPkzGwOA1SLJNC1KQhYe+wZR2mOnl6BuhXgUf0=;
  b=l5joAMGZv336eYmCtAjJYA2jn+FUxVnu8u3pmxZDHjfB0R2cL6TWeeaE
   VvWb3Q7WqNAvwSvnrDNLdhg65OFvZnioO39MfQvKy0v5Q2Lz7OPFoJAtj
   MC4ndJtvf/uSjKHseQXwjoZVLMAp+1jycMnf2L/Qsbes3rG0ZHMzDtDEz
   K7qEWDPWegIBF6SndyLgHrBwumfCLE8Bfbysz4xe03j3K5sGDEmkD+X8R
   BFdThmK2aHb/7tu3bknWVBZjUQ6MAT7WvbNxnuvkTZbmoWiki1kKEizzw
   ud49EzzFdwkrPbxF4/76GwOpPDLgcefrysuXNBMDnXpnAHckIN1Zg3ZNj
   w==;
X-CSE-ConnectionGUID: NoDGqTpcQ1qGmJaMoFRnoA==
X-CSE-MsgGUID: LCWHonAFQcyJwK9CaWYV2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10686891"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="10686891"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 01:47:38 -0700
X-CSE-ConnectionGUID: s5vdfWzyTviV7YrQXVujZQ==
X-CSE-MsgGUID: LbqtTxlDTlSZrJkghj4wAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="32957798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 01:47:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 01:47:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 01:47:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 01:47:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYaAuNQyrUnK2Iaol1rezkppuNTBEJmVBXdHW1pPy7xs+M/GduGdB/+O4KI7P+JXNFdQsLDv9Svzpu1mKkqpMUKzXwOMZJlAT6qfiAOA/b54upLvsDEXgrqiT/pwHNCHBqsYKANMQhQqKMUNFRy9FIn/ekX8qjzeWAT9GL7uIt8kBwPhIWAP+oi++97sD5/d+9eVlLC6Tco8icVw/JCfCp58Gwd+I3C+gS2gDjqvmXHw1qHlpWZ4HgdduocD1KRyeGeNYbejAFiA7YeHjh25SBT1LD21vo16JCnpRm+pUb1Kb6+v7VVXLUmfAhsL9FbxEwMblXt4x/IjyLAGl+OVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuSNyW3PmrFcRbTCM0WKJNjauDuaDWwC9+7zl6wzUCg=;
 b=dAz9x38NIbUCnErE3zZPJ/wcYyGYIkk6vYlJ+YFpB80i+vtEB5tqVrn9t9Tic2+AUHBeMGQ7Fx3nF04ggHxlXTH5Pyp33aWyal2CMcvRqmFZBUPCiIBMEmoZQp+DhHfhaIVSzFIKVSUtwmT9fzl4h14nOlkziWPNTAzdkydMQznfOGidVgsH0a3uWGpo7D0enYSTaZjMvHkSzqMjkqViaYAt0RQCBrl+EQlvzq4tWZT0P5o47zdpk2V9idR74upIBJCPq8HB0rgZ+pWScL48DaA8Q3Vik/GvKz8prm7zDp+84IRS200og9o6OVVIZ8cmuLnFd/MhjA61NOo7U+ImEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7313.namprd11.prod.outlook.com (2603:10b6:930:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 08:47:34 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 08:47:34 +0000
Message-ID: <327aafc5-2bea-4cc2-9ada-9320146b5e28@intel.com>
Date: Tue, 7 May 2024 10:47:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests/bpf: fix pointer arithmetic in
 test_xdp_do_redirect
To: Michal Schmidt <mschmidt@redhat.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240506145023.214248-1-mschmidt@redhat.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240506145023.214248-1-mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cd10ee-5865-4b13-f090-08dc6e7256ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0Faa25Hc2sxL1FVQU5DbXhidVFhTEdrUFl1K0I5MTU0K2xVZUpTTHZGVksr?=
 =?utf-8?B?ZFRVS3A3THFQVnpEa2tIRXdXV3QxaFJXZkhrV2hJalZvZ1BmaWM1TUhSeFl4?=
 =?utf-8?B?S0txcDIzSUpmNXRwN0FSeElDMWJ6RXZXVXBjQkdPT29sY0lORlU5NWVOV1RQ?=
 =?utf-8?B?TDI5cmE4aC9mL2REeGpmeWVoUkFMUFpmYS91cXY3bFdUNEZaZUFpSUJFbEZ1?=
 =?utf-8?B?cFRka1h6d21Wamw2UmVKSldhY1RkL3RrWnloMXl3Sjh6bmNzV2xsZ0F2YXNT?=
 =?utf-8?B?dzE4R3lhUFpwUG9yRkp1MzNkQ0JocktnTzdwcWlaTTc2akVVMTBJTHpPTVhq?=
 =?utf-8?B?dTZBSFF2SGx3WHl3TUxIeVlHV3RlMkIyMFQ4WlQxMmxVSWtPR09kLzBudEcz?=
 =?utf-8?B?T2w3TUhBbWZPT01MR3JPWWJyclJuM1RQN3hCeEMzZEdTN25UYmIvTUhVZzhx?=
 =?utf-8?B?dmVKQnZTaUJDOUo1ZjRRY1V1eWYyQS9JaTI2V3FzelV6V1psdkk2VmRINFJS?=
 =?utf-8?B?VGNQNm8ycG5YdXBuVlkrVlo1YkZ3WGNSS0E4UjNoWEt0UzFkY0pzMitmNTU3?=
 =?utf-8?B?djJiQTJXVjROQ1BtbU1SUGdycUozVDNkTHJXZ2pyTVlLbHdjMVlZVFlWN2d4?=
 =?utf-8?B?UXQ4SGJJOXpjZE9Gb3FpMUxWWHY3aW9mZnkyVnFlalhhNVNMNm02allnMnBo?=
 =?utf-8?B?VHJkeHhYQUYwamM1K0dTNlFTNTJrRmlzcFdmbnhDN2J4VFpZNlVYVER2M3Qz?=
 =?utf-8?B?NHRhcVlUeHZDQUlsQWsydTlLMFJ3dHdMaFVYOUxjWTZJQ3BRMGVFZmVrOHRT?=
 =?utf-8?B?ZFFuNTZLM3VIMTgxUFBnRlRRdHVBbUExRW9Ec1Zka3h0WWtrRWZFR2tsSUlk?=
 =?utf-8?B?TDdyQno4TEF2dVpyUUN3K2xtMmR3T2VPb1Q0bDRRN3pJM1hmRUhtUnpEbGk0?=
 =?utf-8?B?SjAzWGhxbmNSQXdxU0c5dmdla2NweDVFK0pxYjdIcWhEbWpkMGdpMFlOa1NC?=
 =?utf-8?B?dEI2ZGVTSGh0K3g1dk4xYW5sSGQ3VzU5djJER1Fyc3V5cFVnY1NWVEYya3V1?=
 =?utf-8?B?WGorYXBocDVqWEp0VTRvUEl6YWZmWUZFN2REMm5VRFJSbGNrYzArcVdlNTRm?=
 =?utf-8?B?L1JYamtUeDl1Vk9oNE4wVTFUcEVQRCtjZSs5U1lscG5QVWFlcElmNkpDaW1v?=
 =?utf-8?B?bWhQbUU4NnYzQzZlUmIybXQ5MDZoR0dEQ2RhbzVSMGQvbWI3YkpOZkdxVndu?=
 =?utf-8?B?eWU2YkY2WnY1aWZXa3N3T09FajZIZlpqTTVEN2lUK1p3d3NNRDk0K0toTWw3?=
 =?utf-8?B?N2dTRmxaWlF6MWp1NTBDUjhNamdJbFBRWUFXTzVvV1IwMWg4Tm93Q29DdDJh?=
 =?utf-8?B?K0VHNFpubTZlTHdQRUNob2dKK0RncG1rV0pvQUlZai9tcnUwS0NmR3RzcUJv?=
 =?utf-8?B?eTZXR2liL0x6SkZZV3R6VUdNWHBwN2ZRQ3BqYWJWc2trWDBrOTUzWkJtclov?=
 =?utf-8?B?MlREbGVvNmRoWDRxMkFkZVFOc25reVU2ajZlUVR6TlFUNllEa2xkTGoweHlx?=
 =?utf-8?B?aXFnOW9XaG9Ub1RjRmVjMlFyMDhCN2xmVm4yb3pzRUN6Slo1MWlnN1kwdEZS?=
 =?utf-8?B?RkpQUG5NWEp1YVg2RG0wa2VZd0h5Zmh3NUllekcrNGxqUGNyaXR2VnZSbmdF?=
 =?utf-8?B?UnBkQUhhZDR6VkoySEdQdFJrS0pJeVBHMlNMbEMrZU9VUkZwSXl4MFVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWEySzBPZGxESkRHRm1EbU9JeDJreEZLM2JWN3dTS25xbjIvekF1K1d4cXRK?=
 =?utf-8?B?YW5oUkZRRXBKYTRHRTZraGxrT0FQdllxNTRZN2wrbm4wb2xDTFJURWttbHo0?=
 =?utf-8?B?eXZhbEIyYnM2c2F4UlU0VXV4YVprRitYdlg0eEhwRHhRK3JnTFozZFlMZ0lo?=
 =?utf-8?B?RGJKMGxjNHB0T0VLSDBoZzNJZEsvWVMvaURuY0xEVHIrb2JZbmFQWXY1a1NF?=
 =?utf-8?B?dFJFZUpVT1RuNFJmSEZiSFJYWnNIQ1JiaUh3c1RNTjN4U1hKQ0pwL1ZOekMr?=
 =?utf-8?B?NzFxVnhEa3hGY09tYmt0NVhUbHZmWHVsTFI0bFdlblkvTVl5MzJua3pNYjRJ?=
 =?utf-8?B?WUoxOEw2YkdsNjFkbWlLVzBXODkzVjJESlNSZ1ZGZU9OWDJxMWJOdEE1QUh5?=
 =?utf-8?B?MDVQWjNwai9GSEZ4dFJwNy9UM0xLd0gycTRKRGJwSjROZHd2eU1ZYjdzVkYz?=
 =?utf-8?B?VGNGU0pjbCtiZ25WbGFIa3luU1FiVUNzMXNYd1h0OXprUlB4ZjZ4MHhpNGdu?=
 =?utf-8?B?UUxQeWVWeVFoa3c1RFVLL2h5dnhuRTh0N2RuN1hCWG9McWp4Zk41SEVReFZY?=
 =?utf-8?B?dzg3SXJKS3p3MElzYUF6M1Jvb2hVaG5WVzlrK1VxUFlvbE1zL0tQdFJKOFg5?=
 =?utf-8?B?UzJHb3dGUmVmVkNxQ2piT1dHRWI3Y05KZXQwZU5IK1BLazc2eGJ4bk1QWWhw?=
 =?utf-8?B?Y2RZN3p1aXNzck9jZmxKaU5PeGQ4YmJ1TUlUdjV4VVFJbloycGNFSm4ySDBX?=
 =?utf-8?B?WW5ZMzVnSXA4Y1VES3VXb1JCYjJtRkM0Q3VFS2hMQWM0Tk9nZkZDL011cmpo?=
 =?utf-8?B?QzRFKzEwU0RFeXNmQnhtWlRjNTZWT1A5WVZqMkFWNmV1Z0pudmx2SmhRTlMx?=
 =?utf-8?B?NmJUeWc4SlI5NlgzTzFtUDc4VHY4SUEzamZYYTN6R0U2UTB5a2I2REQ3Z3M5?=
 =?utf-8?B?N3I4U29LTjAyMUU2SFJLa1RLN2hvSWRNakg1cWppL01Vem1vMUF2ZDdqc01j?=
 =?utf-8?B?OThJMFc0VEdiU0FzS1c5bEIzYkxtOHlyNXNhS3RFMytRWTZMdUpvNDdLNG96?=
 =?utf-8?B?NUVrRitiSGQwR2Z0S2RSdSsyWWt2c2Y2bTkxbGxVa01KTTZkSjFOdFBIYXFC?=
 =?utf-8?B?blE4TTZseDlLN2g4Nm53dkdvMTNMSnlMcUhrVitQWVRPaUlKYmRzR3J5NE0v?=
 =?utf-8?B?RUNCSGV3MEE4am1YYzdjcURYY2h2aUlyam9FWGg1RS85dFlpQjZVZDFJc1Jr?=
 =?utf-8?B?eGdBV0YrUDFMM0w3OFEzeG9UeFN5ZFc3YXVjYmU4YUNCUXRzOWtVTXV3dWYw?=
 =?utf-8?B?WkhtN0lDM2hDMDdpRk10NTBmc0xVUzhqWkxKUk0yellicDZxYVJqQWZYNVBm?=
 =?utf-8?B?L2swakNSOXMyby8zQTN0OEtJRkpJcFFDL1grY3hLNVVMYko3TGpCeWtYTmRw?=
 =?utf-8?B?d0F6UStMQk9EMkdTczdjUkpmenZTaithaVZPVkhEOXJVMWVBMUtqTVlwS0do?=
 =?utf-8?B?azNBWGJ5YTI5cGNBb1VlbkxTdEN2Qk8rS1RjWEhrSXc4S3N5YU00NHFlK1Rs?=
 =?utf-8?B?dzQvRUhrdWtvWkloK1BWcTVIL0psRmM1cmd4NWxHc2E5ZHJUc0dRaXhmdmxY?=
 =?utf-8?B?NVFXdjZIbkZzTFg1NVcxRnBrbklSVmE4eklVR3FCV3g5d3JuRjlUQTVXRVJo?=
 =?utf-8?B?NThPajkwYTJ6aS9qRTc3ZWY4WEVPWnNKYk43a2wrdEJYSXhMcVAwYUZDR1lV?=
 =?utf-8?B?cUNSZjhrS3h3MGdhR1E5cCsrdEVSMmNjbm93Q3FKeDlDMERnTUJ5c0ZTZ1RD?=
 =?utf-8?B?T0ZvTVFhVkdzVXlsUFJLSUEvcUJUQVk3bE14bTdRbjIxWis2b1ZkRm5oUzJN?=
 =?utf-8?B?akpMRmdwM0pXWDFsaTgxZUc1WVFhYXpTcFUveHI0OXRhR2xaVjJvN05xWUhz?=
 =?utf-8?B?MVZ6bXRSOG1tWmM2VUZwa3VxNmwwY1BIcENSa3ZMV2ViOEhNNjh3aDlUQnhh?=
 =?utf-8?B?Qlo5ZmE5a2Fwd3hSak5ibndRVlR1KzdaY2ZhMW54Q1NaV0lQKzR1aHphRFMz?=
 =?utf-8?B?U0Zhci9vbDJHSmJxQ3pOSnk3Sld4c0NoUmtiY2E5T3pzK1h4dktoR2hseGtY?=
 =?utf-8?B?dmVUMThQVU4rL0hNbVlOVDEyQ0dBeEx1MXZ3UGRmaWR5dXZIQmVOQlhQU1B3?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cd10ee-5865-4b13-f090-08dc6e7256ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 08:47:34.2691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRiQCI2wIxxu/50cpyS+R726gZo01OWNWpVbWc+BW6BGLLlJMfDicwvzJox+n1ZEuhfHu4dg4QdK60Nz//Izz5XvhUuDpjRLTYOop+oVXsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7313
X-OriginatorOrg: intel.com

From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon,  6 May 2024 16:50:22 +0200

> Cast operation has a higher precedence than addition. The code here
> wants to zero the 2nd half of the 64-bit metadata, but due to a pointer
> arithmetic mistake, it writes the zero at offset 16 instead.
> 
> Just adding parentheses around "data + 4" would fix this, but I think
> this will be slightly better readable with array syntax.
> 
> I was unable to test this with tools/testing/selftests/bpf/vmtest.sh,
> because my glibc is newer than glibc in the provided VM image.
> So I just checked the difference in the compiled code.
> objdump -S tools/testing/selftests/bpf/xdp_do_redirect.test.o:
>   -	*((__u32 *)data) = 0x42; /* metadata test value */
>   +	((__u32 *)data)[0] = 0x42; /* metadata test value */
>         be7:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
>         bee:	c7 00 42 00 00 00    	movl   $0x42,(%rax)
>   -	*((__u32 *)data + 4) = 0;
>   +	((__u32 *)data)[1] = 0;
>         bf4:	48 8d 85 30 fc ff ff 	lea    -0x3d0(%rbp),%rax
>   -     bfb:	48 83 c0 10          	add    $0x10,%rax
>   +     bfb:	48 83 c0 04          	add    $0x4,%rax
>         bff:	c7 00 00 00 00 00    	movl   $0x0,(%rax)
> 
> Fixes: 5640b6d89434 ("selftests/bpf: fix "metadata marker" getting overwritten by the netstack")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> index 498d3bdaa4b0..bad0ea167be7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
> @@ -107,8 +107,8 @@ void test_xdp_do_redirect(void)
>  			    .attach_point = BPF_TC_INGRESS);
>  
>  	memcpy(&data[sizeof(__u64)], &pkt_udp, sizeof(pkt_udp));
> -	*((__u32 *)data) = 0x42; /* metadata test value */
> -	*((__u32 *)data + 4) = 0;
> +	((__u32 *)data)[0] = 0x42; /* metadata test value */
> +	((__u32 *)data)[1] = 0;

Uff sorry. I was a bit in hurry to fix BPF CI and did this braino :z
I know pointer arithms obviously :D
I'd give a Rev-by, but it was applied already. Thanks!

>  
>  	skel = test_xdp_do_redirect__open();
>  	if (!ASSERT_OK_PTR(skel, "skel"))

Thanks,
Olek

