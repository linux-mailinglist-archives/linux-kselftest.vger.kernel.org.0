Return-Path: <linux-kselftest+bounces-6074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE5E875A61
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36A41C2171C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3F381C7;
	Thu,  7 Mar 2024 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8U5cEq8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596B2E648;
	Thu,  7 Mar 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851156; cv=fail; b=lVKLu6MSuZmLFp4JP2HpDxz5axNYWWZvG24yOCjNn9IyANuOP2h/O6i1Ww0g5mOBHwFiYVS5S3i/dZsdAVS20LZMOM1rGUu5GGFTQQ/wtlKGpf1vPcDp+S7MefYF28ki5hLZvBtmTpGJ0AKQRlUxirWquyHhfzzaYcqCWB0K6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851156; c=relaxed/simple;
	bh=egUYOC9AA7YleH8o7cyWmsWDn2Yy3maEsTLFzYBdXdI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzRYmOqAy+dr2bRKPDs/CfZcZPLZdWoGoqAu/kdMDP7t0Lvwkx+f9uCmolGIu/UKtq43KN7kw1JDPZGQn8Pv7XY5+eHnAVjbRyV9SEUPNfW9DQ+dA89mTkVfegTmOlt3uD3b331/aRu/PND6oSv53AMDAeKirY6/SJHJuLwnXwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8U5cEq8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709851154; x=1741387154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=egUYOC9AA7YleH8o7cyWmsWDn2Yy3maEsTLFzYBdXdI=;
  b=R8U5cEq81W650I1QaVv8cTNXuWAcUyrCgqvMV8pdS2QULIjKog5ydQGe
   gr08Y1CnBcWMvWRwg6MFwPjEO6ofOb4cwE+8m0HhxVjWmK4I7lk3Y0kSW
   iEJkZiJ9tiHO6sS8iamWCtLH1i+3AAiXxOypXPFz2sB9BJLdvhVycdk5w
   sPRHmmgx4t1VSH3POZv1ihweY3t2VxWy2whUdHAg3Cac+MtBKXRvZaUxO
   yzeFWG2OMq5yowXCtW9zpFJgNHiDibT4HA6hH2eMVSz705Tha42jQ/Nn5
   NxuyyjHdccJXkUkxBUTN3tNKCQgg/glAaQvJQBvUuMT5M98Q5uBgrKcJq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="22077231"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="22077231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 14:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10202981"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 14:39:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 14:39:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 14:39:13 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 14:39:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1SWZd0DxaL41X3Xux7K/TgNJYKca2wl2JrkuYAnGX1b21661iq3Ekno1x0eicj8gr1+3UHQ1nkMGVW9cfw0DU/HanuDzjH8JV1h8iwIf6RXcsVNoFnDQ5svIjRkpq6M0B+DpUXl8RyWD0sR9vTAndKbS0VfC1PjOtBvZ5TAkhCOPRIfdmlwDfqZf7Ml4MtV8AmyRFy4d2tanbWGnusHzwEXxchBs/wNNSIypZjPbLddAFNIh7kyATSPu5iAIZ3eP+n1SC3xtSCSWOBoqljDCMbTgSN8w5v7OcCLRtrRdazj4t4e+Aoca+SVJZQyNgXsV4Ug/M8jXXKyx7Mf7WqFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BeNeB4uq2vkFkQA1owmXxoKufWaYmCaEzKpXb7Y9g8=;
 b=DUeadszJ556jdrMTFBRNqeapFh7cHjME6Ciut8u97MUC9pqct2XAQi9dqYgv/yC3pxVgzjyIK4tOah7lGG3qk2Smu++zfIt5CXonSHFp2pHq1Fde6IWVieBe2BdvVsYzy2zAB4T2RF+91MkFDTMZ1W0qc0FY1ARVfeK6af3oRN7838o4mHiVd89yNmPWr1Ex/a+BU8GJKHlWOYNP/7HcQzO3MlyJlviD7e8/NCSJKRT8xPYz4HDHF+BvWzFLQTZIDbl6bmFrxPaULj8fZy4RkeCShqWo1HWKCx4IWxwfJ6XC5GOwwtRRURwvRadPwHIQIMNnAWlRpXnY/L/Jt0xgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 22:39:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7386.006; Thu, 7 Mar 2024
 22:39:10 +0000
Message-ID: <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com>
Date: Thu, 7 Mar 2024 14:39:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Shuah Khan <shuah@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>
References: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
 <8a158ada92f06b97a4679721e84e787e94b94647.1709721159.git.maciej.wieczor-retman@intel.com>
 <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com>
 <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com>
 <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:303:8d::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 2579f775-b003-4fbd-b89c-08dc3ef767e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: By/10pncIIIWWfdS7PPX5RkzJd/px8iHSEouxpXBlXbqSQBazaCqaGaWA1sgeF59lum8oaxUpG8KG7kXmh5iSyJCap+Wi8m1hozBPoMwaOc+YwWmnOpQ/3Z1zshq3NQQqItD/djrhVchl9HCVSBHgBdVC9pEDn4gOqhuGioq0/o566rZ1NlmnYgKsyjDojLLJIdHGOYgxKaQ+PxW/dh0722+qYTX1bytZ/m1EvZzkhXS1rNsEswRVhNBILtTqHXf3A/u4TjWQorrI7dK1swPSA2KCfD9CFo8xkQyYTYjE14i5wGWaMnfwsecrMtsmChWXzf6X4CQNLSkV1z1tzT3hHAPUZ7ca4fYhTE0UBqAzqNTAdX2skqmatpqZnzEkqnAyePiUb74UZbJ+JPKy1xv+5n87ayx6iK1fU9/bfp4BNN7VvbfW64FMOh8DQ5AR7IQ8m2EMBseVJJDXi5TfMLZkxv0CcLdqxt31tq41bit+DDbNTD+5fFMq/KsD91NOTo6ANusaRxunXsvswY97Lj3TNXjfLMqUc/lRAPKn5ZUO+QoxyC7svknLqzfVmRTPz3ntNLS8V+egIAeNS+vtOkuqI6ljnXXJ6uZZaPPQmu0CwI8WcGIFaaACmgi5rRQraIu7KTOyZYTTjdXwEOuvLbNKcRAT3KEtmimjun9x6I/e7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXlIUzVTS3ZkQWlZYldtbFlOcm4rWDd1WUUzL0Znd3RRME1hVTZyZXgyT3Zu?=
 =?utf-8?B?NFRieWVMQk9rZzNKbUNJVVFyc3oweE1QRnJlYlc3S0Z0dnhqeVFERjRjVkpI?=
 =?utf-8?B?UU1xZ2VBclFpQkZrQjRFMklqa0pjOEtmNDFLbERLeHRLMUdXQVdlSERieUMz?=
 =?utf-8?B?NnRmY3Bkd0dTNTdpWC85QVhlZHJNK215VUEyTlQySDZIYW1KNTJIUStsQS9q?=
 =?utf-8?B?MnFMSzd3M1paWUtTZjVDTzZNUURWL2tDU0dsUFRueTV4QnZ0UGlqQ2MxaUFt?=
 =?utf-8?B?WUZWc0p2WmJTUzFvQVNVZWk0K1p0dTdvMWZkNndSV1g5VmVWdG9FajVxUTFE?=
 =?utf-8?B?dWZPTmVkWXdXVk1yNzA0bWkrQXBZWWhIWXUwbm83aWExWkNsVXc0Z2JCbmNX?=
 =?utf-8?B?SDZlSTc3NVA4aGpLdzVxRTlnc25JNDlCUGc2MGlzaUxKV0JnM1M4R21rZWF3?=
 =?utf-8?B?bzAxOXhrc2FsRXN5ZnFZOWcxTDJ3WUtESmpEVFkxVVVPaWg4UWFEYXZYcVRL?=
 =?utf-8?B?RHhUMlN5dzYwZUFvUklMOTQyWlQrZDNNS2JTTStZMjg2a1R0UkFwVHpnTWg3?=
 =?utf-8?B?eHdFUVpiTE5RNXlUQ3lmQ0dqTGdCYVk4QVFRZE1aVlJqWjlrK0k5R0swVnhY?=
 =?utf-8?B?dGU1TGx0S1lKMGNrU1p4Q3dwTTRvbFNzWFNqTExrYlBkSkF2cUZLNk9pa3ZS?=
 =?utf-8?B?clo3NjI3c1N1ZlNPK0d0R1E0MytvNU1GVGFoalNBdENTRXpwdU44QUVHUlgv?=
 =?utf-8?B?cVdvSERXVjY1b0xlQ2Y2TmI4R3RaWEtSMURkK1VFNkJEQTBMa1BTYWV1R0Y0?=
 =?utf-8?B?UjM4dDFQVE1BRE1GNnkvY1d1aHVyWFNjL0NCdE5ZUStXTWkyN2JjVSthZlNz?=
 =?utf-8?B?SnFmNDBPV205b2ozb1dyWHZoUjIyTWpza2pqaGwxWWxHM1FNa01hNUFGVkxv?=
 =?utf-8?B?cklib05wMHd0VUVBcVh6MThzUmh4ME9RcDNnMm9oK3FZWXV4YUJaK0NkTGhq?=
 =?utf-8?B?V2ZlUFpSSTFsWXE5ZXJHVStzYW82eFc3RERKa29Dd21sUzFuYkhqTHo2bHZE?=
 =?utf-8?B?RkhSY3NEdkFRdFJ1cU5GUnVZSmF6NHN5aGdqVGpCQ1QzMk9qU2EvYTRzYXZs?=
 =?utf-8?B?OGZGejNZNlA4NmJGSTMrRTlqUGJqV2NXWWxDKzhLSWZudnlBZWVMTkd6eHBa?=
 =?utf-8?B?UXhVZGxVZ3lSNjVra3c4TjNYL2FzOHFqa3crbnBnNktDbytJdElxc05iUi9Z?=
 =?utf-8?B?Q3NJbE5iOHBkSnVnRUlzdG16NUQ5U2QxOVhrb3JHeURPb1lUT2ZodXJkTnFt?=
 =?utf-8?B?cUxsOGRYKzVuck1yVEZlaXd0M1ZXSS9nekE0eGVLYlZIU2F2TC9nTHhZajV2?=
 =?utf-8?B?YzFCOWY2cytPR3BoaXhjUVIybVBlRm9WUkNvbTUwTEU2NVR3SDN6V08zSnc5?=
 =?utf-8?B?YkJSNlk4YkhVS0dBUUhMeXFsZ3BNOHRVV0V6N1pSd3NXU05jRkN1ZEhMc1dv?=
 =?utf-8?B?NWZoRlRiY0gwcE51WWlPanViOTYwS1FibkRlZ2JJblk1eHA5T2J0S0J6M0Qr?=
 =?utf-8?B?aWsyUnR3UmlZcTB6K1lSQ2NQdHZ6bHdOd3FLK3duSmdFOEptYWl4VlpHemVG?=
 =?utf-8?B?OFBMV2lMeis5bzI4WjZTUWFJVUNFTWYvbmtYTFM3V3lCN0JWekN4TkFVNFZ1?=
 =?utf-8?B?NWVYWlNZdUVobnF1bVVkd2pERlc4V0U4ejhaVTJYNkliZUFveU5vMFBZS0R0?=
 =?utf-8?B?SzlZTUQwQjJvbFJWYm9kdjFUNTRqQjF4Y1NOd1JhdnMwR1ZneXVFcXRnK0Jl?=
 =?utf-8?B?VE9pVnhvYno5MjZLMEx1U0R0WUxmQjFRZHgyREZEZzFFMjAxSExXeGtyZnpv?=
 =?utf-8?B?Zm5UQkNXd0NMdGdwazE1UDdCdVNMVFdqc29pS1ZmUzlwSWJ2ME5qaC84aU9T?=
 =?utf-8?B?dDhFNjFLdGIxaHgwdzQ5N01hNVZZZkZrY2dMWnlHbFV2OFRPaS9Zb25HVXJk?=
 =?utf-8?B?ZE9YbGtpVDh1NzlmY004dytIZHVoQ1cvd25LdmpzVlMwK1N1Y0o3dkJDTCt0?=
 =?utf-8?B?VzFsWlJSOWkwRTNyaDUvek1WQTZVb1crVTN4b0lzZDIwbE9vWWRISTJtUmUz?=
 =?utf-8?B?cnFobGJNNjBCclJKU2FUU0NDdGdrM3RFclIxMkl1dTBTWVMvTWZwUFRraFQx?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2579f775-b003-4fbd-b89c-08dc3ef767e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 22:39:10.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afiJma6h1FX1qhjOMjnB95Tv2tcNxlFBhjRWVgljF9R1Apkc6eAuw2PiyO7LWcG1hYQ1x9rue5TWwXNpJYHCp1O629Aoe22f/qwUE/zjBGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

Hi Tony,

On 3/7/2024 1:14 PM, Luck, Tony wrote:
>> Thinking about it even differently. The goal is to give information
>> to userspace so we need to think about what would help user space?
>> For example, what if there is a file in info that shows 
>> which CPUs are associated with each domain?
> 
> Reinette,
> 
> Interesting idea. That would save users from having to chase through
> /sys/devices/system/cpu/cpu*/cache/index?/* to figure out what the domain
> numbers in schemata files and the mon_data/mon_L3_XX values mean.
> 
> May be extra useful for ARM which seems to have big random-looking numbers
> for domains that came out of ACPI tables.
> 
> For SNC it would get the user directly to what they probably care about
> (which CPUs are in which domain).

I agree.

> 
> So something like this for an SNC 2 system:
> 
> $ cat /sys/fs/resctrl/info/L3/cpus
> 0: 0-35,72-107
> 1: 36-71,108-143
> 
> $ cat /sys/fs/resctrl/info/L3_MON/cpus
> 0: 0-17,72-89
> 1: 18-35,90-107
> 2: 36-53,108-125
> 3: 54-71,126-143
> 
> [maybe there is a better name than "cpus" for this file?]

Thank you for the example. I find that significantly easier to
understand than a single number in a generic "nodes_per_l3_cache".
Especially with potential confusion surrounding inconsistent "nodes"
between allocation and monitoring. 

How about domain_cpu_list and domain_cpu_map ?

Reinette

