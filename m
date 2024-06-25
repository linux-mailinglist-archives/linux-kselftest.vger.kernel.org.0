Return-Path: <linux-kselftest+bounces-12705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAF1916E23
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 18:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82D81F21FE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 16:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8F4172BB5;
	Tue, 25 Jun 2024 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2eqdG8h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB316FF59;
	Tue, 25 Jun 2024 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332945; cv=fail; b=ZnIhSxDlBlL6oX0N7EBkZ6mqpYtrPxDFkk7PHU25RhyITgl9fXR16+nJQM5jdMx2Zc/06SFOv6ZqAzSrArLMtjbpwa1rDTEw8vJI3x3D+OphIzaUgIlDWlJ9S6mR2qbir9rxfapVG7yXwr4jK/eQdNJg/0fH3oQapPndmaklgs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332945; c=relaxed/simple;
	bh=8ci/btWRnhPwdtnmkeuRv9rk3RCb+KSA0faCfzrO2Tg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r8rRj2kMTJweUeNdOrjrIX/XdLc+/p6Ah40vluUYe6kRAA5PfGDm9N3apk0pkjC4ZNXMFj9LG3pm65mxXNOl4Z3ypoRH/J0mJwrTGkeMcE3DZGflKKH00/3KddxIZQP5V8EELkmLBTAaLdu7368LEDATebA7Op8/d1Led3Dp0jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2eqdG8h; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719332943; x=1750868943;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8ci/btWRnhPwdtnmkeuRv9rk3RCb+KSA0faCfzrO2Tg=;
  b=S2eqdG8hOaA+QAmBQmZKLiIZzwbzBLjiAicS39gXTGYiBwGWQhDZxX4p
   DYKb9HeEWLuYvn2cI/fCH1Drhk8VXF9KdLoK87ajkTdUPaDfhs+xuTgwG
   JD3pvswY1TE9Bfgq+2Lgu0yqrFo1DDe93n/cAfFokWoMntJ4Ogl1/LXEv
   SlxyNffr4f3cbrgWbuf9yGQZSRprIBVW29s3CCjvYW5B8ZLMOm04ckXY0
   My+DpFwwaEWWVuJ8qlIcxpU8KdhRbI1soLh9VzICtRSVodRMXqaUkjRs2
   RKGrbYDqzrDwlNjlR+TddSPUgBosc4UtFlYr1sWcu7n5TxPHuScPZ/Zoh
   w==;
X-CSE-ConnectionGUID: h2qr75oSTA+u4A7NfhKuwg==
X-CSE-MsgGUID: vyoYAaKTSBymKcdRvAOoIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20173688"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="20173688"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:29:03 -0700
X-CSE-ConnectionGUID: ENviMhgUSFiByDLm5JgqhQ==
X-CSE-MsgGUID: G4AcgG0mT9qNg2HsJbndmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43803214"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 09:29:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 09:29:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 09:29:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 09:29:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 09:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBP3miq1Y1lPysyI4bv+vc1wMcCHdZBz/k6u34rQmDd3SolBfbkfFImcuzkNEHc648zVxnaI9xNTEwUNenue8pwmxGTs9ZaQq1DBS9PhhyeuKJ2vncSzPbAh5XikEBgxSQzqbj4F671DHegfuew1fX0lyA7XV/yO202WCHSrjQmboTmhTtrsqKtRsj63RqIBOIEtyFvVRHSvZC6gLkPtH4JrjexDgEsHxzsKsZdCu9r1kwRXX5d0tjPzWX7CJKqoOM7z0hcbEndUDCuaam3V75vIfjtcG6SZYEWxTRfcZkOMmDjtV8t0ev7clKnZ49Ohq6fm+Wyo9bHpxofqfxUapw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqlb13wynwltNzpqF0H0M5bI6KPMCPFpMGq4OdHptH0=;
 b=gq53jhFa56LFphi2a0btKCQ1umLcTgGVlUhqB+Xhb1Sn7LLlk5s4nwTS8fTuzWVAJN3SchO7Wly+44BWXlmxs0loVNjHRf+TflEFMZutnqw4PssDedb95ZM/tp8a/GJ3UJ1NriTPVUgadJKrTFCAnpuVgmWcF98T7SastDLbWCh/6rSRF8Dm3bJfsVejXzlHtPk1HqftoZlqcZSxjuTPO2PuVuRYmOzMbhCrQFqeQGYGxNqD/WMVtnjQ1Ou41UGn2wkYBBwD6+9qd4a1ZYfZPXvnUw9LUHm4gSyc4ZaY/GCmjKnynOwIovwDFgEaWqThaebPGsTefLJRc//peYlUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7138.namprd11.prod.outlook.com (2603:10b6:806:2a1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 16:28:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 16:28:58 +0000
Message-ID: <9b976e89-0320-430f-9f0f-48e25612ec98@intel.com>
Date: Tue, 25 Jun 2024 09:28:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
 <fe9295c6be677d187b1607185e23993dbfe74761.1715769576.git.maciej.wieczor-retman@intel.com>
 <9fa47acf-86b1-4602-8790-39ed80fd775a@intel.com>
 <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <n2el3evhluilmjhrwgpkkb7ld2g26zhmctxvm77b3ome6u6egf@hym7rnr3h2o7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 91dc4244-dcda-438e-21fd-08dc9533e9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?empZUTBKNHAyQThlZjJmbEppVFhwT05jRHFJTk5IV2VKVGpZVCtUV1NvZlht?=
 =?utf-8?B?QUZjQ29BdFUzckU3QmtENnFoSXZ4a0dLZTJBQkFCTVMwR2JPTzFWZWlwS0N3?=
 =?utf-8?B?aXE0bExwai9VNXJTTDVVTFhCanIxaCt3Y012ZUNOQTNCNkR6WHZlNysrU0tM?=
 =?utf-8?B?TS9HWjR0UXhyMHFMdjJVOWxUYkxNWG1NWU5NbnhQZWxNYzc1NFByY0MwMkNG?=
 =?utf-8?B?YlQxZHBxQy9RZFRzUzVNMmI3eWtlRGh6R0NJT0xSQlBQN2RqNk9UWHkrTERV?=
 =?utf-8?B?Q1RSQWEram1HSzBSU2c1bDEyOCsyc29Pd3NsbjYxK3NHcXBOT204MDdMTDQ1?=
 =?utf-8?B?K1BNVjZRdGd0eVpaakQ4WXRXSDhFSko2a2QrbXc4bVBCQW94MlBsbzZiN0ZS?=
 =?utf-8?B?dldvQllvTUE0dWJubmNOQ2JuRnp5QjlGVlBQRGx4UXUxM01ZWmNtb3Y1OGxa?=
 =?utf-8?B?clgrSXk3bzV2MGNNZ3RFbnR0dWJ5dlZSQnF0V2pXS0R6KzFLUzR5UVNCekRB?=
 =?utf-8?B?L21ySmIrYTNLbXQxUUszOW9odDNLUnl1bytUTmRqNFJEU3Vka2ZETDRJamRT?=
 =?utf-8?B?SjZwR01PUzhUQlIrVlFtOG5KbnlWTXQ3THVNbmFBdnRHdzhJTmJtellBckx1?=
 =?utf-8?B?OHp2cmFLeFlSTGJZMkJCN0l0UXAzQ0RyWmxMQk1peUs2NDUwOWZWUVFPTWVO?=
 =?utf-8?B?d3ZoRWk5MGpTZVJSVkdram9FOEVCM2VKRTduZnRBd0liYi96U1p3azlNeDRO?=
 =?utf-8?B?QWNHaFRSd3pydFpvcXF4b2JUL3V2OCswcklEdGRDNmhVS3RKTUNYMmVwVVRE?=
 =?utf-8?B?RFBETXBTU2lZU2t5Y29JRVV2TlNBb1NqTFU3OWVuZVBRM0JJQ3pwcHlKRjdR?=
 =?utf-8?B?dGlGZGxOOWhZbTJUVU50N3ljbGthL0pXRjBPYk44a0F3V2VqZHRQaTY3dTBK?=
 =?utf-8?B?SW9nRW9kS1c1WEpkTjBLT2VPVG44VDZzOXZxa08yMno0T2FETkxBMStETVRt?=
 =?utf-8?B?Sm1ZNUVKamw5WlJhYW1hZzlJOFNINlFuUEpFajM4aWxwcEhxYnRMbXA5dTlI?=
 =?utf-8?B?VVJSM0lkOUJaS2lya0x4Zmh5Tk1DRitoRklvMElobWd3b2E3VWdVK2txTEpV?=
 =?utf-8?B?ZVk1UlNiVmdhb2pWUW1SOW5kejZkc3BESzVQRjNZZ2loRGQwTXNaMy9ZQ01h?=
 =?utf-8?B?YW5IRnJWSEhvSVhUam0xK3JDSDdKS09vV09LRW82Rno3dklsVUdxMTNWQUg3?=
 =?utf-8?B?ZFZrWWxvRlhFTVVFOW5waTJXcytsV0cyMno3OUFoWGNTc1pib25ySkUyWk12?=
 =?utf-8?B?T0tPdEpqeXlJK2o4bFRtTkMyYnZQWkMwcXFtVGl6Z3JXa3JkMnhreTdZekR4?=
 =?utf-8?B?ZVlqTEREMmRyYnRBeGJQT1A2cVBxa1RFTXhSaWN1bG16ejZMeEZjK3FJV2hy?=
 =?utf-8?B?by90cG8wakJOSHVnRnZwMG9KQVQvREYra293MzVGeDY1Z1FLWXhVZ2orOEZn?=
 =?utf-8?B?TEppUERGYjVJekJTMkhrV0VwYnl3Qlh3VU9pRUhhUmIwSDBwcE1ld0s2T3VJ?=
 =?utf-8?B?WWEveThNU2l1dm8wcEptaUg5ekpyZFNKTUhSMDViQnBTcmNKUm1CbHRjZFlh?=
 =?utf-8?B?cGl4Kzk5T3FsRjR0SDJuOTdSOUUyZHlraDRqNDVuUVJnaEdzR1JXQUowWUg4?=
 =?utf-8?B?dWNOT29tT1B6T1VNNzgrZUlIQ1dvRTU2aVIwUVlJQzNyY2tneEJIK0lVVzUr?=
 =?utf-8?B?OVdMWi9XTkZHZ1RZSitkbi9aRGdMVmlGOUczZTErSGxaa25JL3FIbkpPMnhD?=
 =?utf-8?B?SGpQZWVGKzhWUlNrZ0JDdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q29GekU2M2JPSURZM29xOHpxUTZKRUZHVU90eENkMm9pN1UzR1NPVll4QUhs?=
 =?utf-8?B?RFlZYVpVaDBsTklkcUJNdGg0UG52N1YzQ2F4aGVoaVo1MENpbFg4dWRwV0tu?=
 =?utf-8?B?YnArNEwwaENGNXlDK2t3V3RuWFpLRlcvaXRPYytSZ1owTDlzdTRRZTRjZjAx?=
 =?utf-8?B?VENhQ0dHQWhnOXlrU3hEQ2lMMmhxM3laTDZBNHlkMEt6VGRFRTlnOW5NVlFm?=
 =?utf-8?B?dUF0TWJmcENHMmhGMDZDeGh3YVBuU3pwYlh2a0RoekNDdzk3T2luRDYwL2dY?=
 =?utf-8?B?MTJIMEJoZk80SnVOUyt6OXhvajd5TjZHUFBCaERmd1JpQUM3cVhEcWVjVGJo?=
 =?utf-8?B?eVRWanZUL1FiU2NwWGp2c0hCSFZFT2xFQ0VSbkFXRCtWeDRkTFRjaGwyZUpu?=
 =?utf-8?B?MHYvdGY5WFhXVG16ak9VS2JyQzBaTVY2YkFFbjgrSytEbGFhdXpvN3JKanMv?=
 =?utf-8?B?eVR5K0NQQ0tCTnc1RStKdEVpd3lMUXE2eTdWamRLSlBiL0xrMmp6U0l6RGlB?=
 =?utf-8?B?dkJwby9KVVJYdlVNVWE1bENoNTVyZ2NTbG9lVXMvRWpVN2JSK1lISkFMWGlw?=
 =?utf-8?B?QXdiV2JTR3RObjhtQzZKUTlMcTlEZUJaVS9JQ2dpYXdYanFKV3ZYZ3FDNmFK?=
 =?utf-8?B?S0lBaFdEV0c3eWhyVGRNenJvOTNJSnJUN25lODljTGNCam1IaVBYOHhjWi9G?=
 =?utf-8?B?Y0VpMWVNZkRXK0c2SVB0Z0JuR2pCc0F3TzVhRFhOcEZBb3JncXpvbDFCTTZx?=
 =?utf-8?B?NllDMStIT0N4Y2U5U1Y5cGVTYjFoRHBUVGlDT3N5Vkx6anhmUDJYOG5ta1FN?=
 =?utf-8?B?eUt0OXVXMk5wTlhweEVmVFlMTkxEU2dVMU5objVIZ3JTOWF2VFdxN3dkVFVa?=
 =?utf-8?B?T0dUZ1FFMlVycVpKZXVRYjFKVloyM1d5YlVNdld6V0dsQWJvanpCVFlabm9J?=
 =?utf-8?B?OUFzcGk4YTM1cmdPQUFBSi9aSXFmaytiTWNzOEF5VVgzbDRiS0tia2lyWktl?=
 =?utf-8?B?blFrbEx5OFJsaTIycmE2SG9GckN4Ly9aQ0l4T3VvQzVyQWRQNjVsSnJ5L1Rh?=
 =?utf-8?B?MnI1TVQ1eHY0c1FnME05OVlibzN6RlBSaDZDSG9lOStMOURYaTBzc3dhakdK?=
 =?utf-8?B?V2UrTEtDeXlTbUhvM1NOTllrK2dRRFQ5eUszN0JwVnlxYTRBN2RzU25zbXI4?=
 =?utf-8?B?RzJNczZ2UjZqWlZuRFlpMDJLUVZJY0tRSnhvUVZzeEhDUFVySXZsSVMzRCtj?=
 =?utf-8?B?cXZ5VUg1R0owRjd0dXA4c3NSQjJSWTRDcE1WcUJEN3AyWFB6ME9GRVpPc001?=
 =?utf-8?B?K29kOVZURWttQjhvMkJmeDVaVVV2MmtQK1pqRk9ZYnhkY3hScmNvRGFPdGtu?=
 =?utf-8?B?dWFpclBXNFNDMVIvdURGSHNWUkNZWFdraGkvckNHKzNOcVB3VXA2NlBxam1Q?=
 =?utf-8?B?SGtzK3VEdjlzbXVlWnJzb0djcWxBUElLVFU1UlVLVGwzTHJKT2RPNzJIbzFT?=
 =?utf-8?B?MWxyYWkvQUdaa3JlYzdlQ3dZTkdFbXlJY2o1Y0hUN1VDQ2NMMTZTL09nbTdx?=
 =?utf-8?B?NFozSysyK00remhEdi9ScSsxNWtrMENuY1BSOEdJTTBaTG1ZTFZkT2h5LzNY?=
 =?utf-8?B?ZjVtb3lwbW8ySzhWa3plZVZrelYrR0Nlc0xSR2dCN3FHNGQxRE5IUmRqekx4?=
 =?utf-8?B?aTBxVWtOZUF3MVgwQWNxOG9Rd1A2UWVQcENmTEJBbzcvbW5Oc2RHMXhXdU5F?=
 =?utf-8?B?a2o4OFRjWU5IYlF4VUZGSkNUY0dVdGp6QnlCZkpPU3I4ZnZjMHVabldmZVg1?=
 =?utf-8?B?V0RCcDdyc3ZnSldsRVJxOXhHMVJicEV0VmU4VU5SbXU2cm1DL3VYNTBLUlRB?=
 =?utf-8?B?ZW5zUFpMSUd1dU5TNHdZNXhHRmlUUngvWkFLN2orc1BDZ2NSYlpkc3MvMktB?=
 =?utf-8?B?YUwxdG1VSzk4VmQ4dVZ0RkdXcUozZmFsNFhSeTdwWU9ZZVFBSTMrYUlNeVp0?=
 =?utf-8?B?RWdrZEZXZC9zNlZlTXY0a1ZKYkZQVzBkM29BN0Y1OWxvLzR3OW80djVMUVZV?=
 =?utf-8?B?TTlCT1cvWGF5QnRyOE5LM0VGcFdESzBiVTRkZjZqMEZRQWZuZ3M2MlFETWI3?=
 =?utf-8?B?M3BiTWRDODNXanpCeTRUNUI2RTcvQlhpNDhQWm9HRVB4NVFJTTZjMlFRUlox?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91dc4244-dcda-438e-21fd-08dc9533e9eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:28:58.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWdUWffvhHV4CKpmEck9nWGJqJU0DvwOeOkXdJS4EC8x/08Dby7xTnts5TvcKvY7FZVk4xc9yq8jqyzY4/S0Z3y4cjGPk19jS3DfoNKlCkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7138
X-OriginatorOrg: intel.com

Hi Maciej,

On 6/25/24 4:04 AM, Maciej Wieczor-Retman wrote:
> Hello,
> sorry it took me so long to get back to this. I prepared the next version with
> your comments applied and Tony's replies taken into account.

Thank you very much for sticking with this.

> 
> I wanted to briefly discuss this before posting:
> 
> On 2024-05-30 at 16:07:29 -0700, Reinette Chatre wrote:
>> On 5/15/24 4:18 AM, Maciej Wieczor-Retman wrote:
>>> +		return 1;
>>> +	}
>>> +
>>> +	for (i = 1; i <= MAX_SNC ; i++) {
>>> +		if (i * node_cpus >= cache_cpus)
>>> +			return i;
>>> +	}
>>
>> This is not obvious to me. From the function comments this seems to address the
>> scenarios when CPUs from other nodes are offline. It is not clear to me how
>> this loop addresses this. For example, let's say there are four SNC nodes
>> associated with a cache and only the node0 CPUs are online. The above would
>> detect this as "1", not "4", if I read this right?
>>
>> I wonder if it may not be easier to just follow what the kernel does
>> (in the new version).
>> User space can learn the number of online and present CPUs from
>> /sys/devices/system/cpu/online and /sys/devices/system/cpu/present
>> respectively. A simple string compare of the contents can be used to
>> determine if they are identical and a warning can be printed if they are not.
>> With a warning when accurate detection cannot be done the simple
>> check will do.
>>
>> Could you please add an informational message indicating how many SNC nodes
>> were indeed detected?
> 
> Should the information "how many SNC nodes are detected?" get printed every time
> (by which I mean at the end of CMT and MBM tests) or only when we get the error
> "SNC enabled but kernel doesn't support it" happens? Of course in the first case
> if there is only 1 node detected nothing would be printed to avoid noise.

I agree that it is not needed to print something about SNC if it is disabled.
hmmm ... so SNC impacts every test but it is only detected by default during CAT
and CMT test, with MBA and MBM "detection" only triggered if the test fails?

What if the "SNC detection" is moved to be within run_single_test() but instead of
repeating the detection from scratch every time it rather works like get_vendor()
where the full detection is only done on first attempt? run_single_test() can detect if
SNC is enabled and (if number of SNC nodes > 1) print an informational message
that is inherited by all tests.
Any test that needs to know the number of SNC nodes can continue to use the
same function used for detection (that only does actual detection once).

What do you think?

Reinette


