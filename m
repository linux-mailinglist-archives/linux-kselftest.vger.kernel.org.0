Return-Path: <linux-kselftest+bounces-39927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23C2B356D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B037AC713
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DE32F8BD6;
	Tue, 26 Aug 2025 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/QQ3Sz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268B14A8B;
	Tue, 26 Aug 2025 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196925; cv=fail; b=dJnOfPR8PuxoMLScOLcHwna8ktPiAHzq7ySjna8Ms+MUVs7eTWldM0PZCxFq1iKhniVYkt/tLF71dMv6K/1FFfkWCZyjkTwDYAXOTHHyHJPbRgY5Nf893FDH0uk1iy5Mu9OY0waSfGoKfjs8pVgSPbdwaxa6nEbEnm8krWHgync=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196925; c=relaxed/simple;
	bh=WRj9Z2SqWWvj/LNDFNjDmUmi9R3ZLi9UoguuQWi826c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OWkeIgw1oPqfeCc7SHduFQ/KXTOYzk374O+ocbx26Tj1PSeESdVJ2pi+0LnxNzirPZkuLRYNokjepTbxsHmaascfR6xLngXfDtHrEZBxHCtow4j2CI38o5ZtF8VKHpF5b4NuMDpdJ4XdRE+56IIHpk8QfmpkbgYYKsSGD6Jqkvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/QQ3Sz3; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756196924; x=1787732924;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WRj9Z2SqWWvj/LNDFNjDmUmi9R3ZLi9UoguuQWi826c=;
  b=F/QQ3Sz3EJyKMu9dHUb0BNGlcGqlzTpKtMeI9P7GQAvqTdW3zHr3937d
   1HV8fPwPe39jkZYmcsut+WjmPlpeuNEpQElm9Jf+LvxRv5j6EErLjERS3
   KU7xlhmslQan/+9reuIv0FuMpG3c2wj2CEuXIBkzgqndJ2AxOrTHN7klU
   KNWIn14n32qNCX06HT1dqbXtyhVGR56SqQ01XnrtTh+6FkQ5aMTw30gRJ
   mrmUf0UzaBCWgEESmmmJ0PxYCAOSO9sQ4Amf126M5t7kKH6rxkEeQ0R5T
   8gfFF+YRazREKDGlbtS2wFwTWwEED485mrbGILtznFcl0nhWt3UsEgyRM
   g==;
X-CSE-ConnectionGUID: nUUrqW8HTNOmizxqMCH0Cg==
X-CSE-MsgGUID: UyXiTwbfTuWbZ3sRrlBsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81018759"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81018759"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:28:43 -0700
X-CSE-ConnectionGUID: wk4Eej4KQK+ZVWWoCB4ZrQ==
X-CSE-MsgGUID: 1xyVIzcYSzOwyewYcA7Ahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169448488"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 01:28:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 01:28:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 01:28:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 01:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkYMT6uFr/VPyL5RPdAtj/xaVjnvDZbJJChoP+pcfpMRmUN6cx5UpJsEGb6QOvHyl3p6yXFAOAgVm+REdwoFSyv3ubzn8fV7a6gDtRlopCgpt5eMfWkzOOUC1BujtUvLlHy9LCO5spaR/kTMkYjKavcZOZeLRDyUhCKE6eo9ZPJEnuZ8S4g/LeQbhBq/LXA0NM9OSNhM5BmEZzwGj0QRvt+sjsGlNwAe42KLt7iM3769fFk5YByI+OI/IZc+QxXsXfPILkspSSUbzNrxnn2VUC89ojdxTPjlZ8nGSb263v0OvIMIrrX0INNwsUPD0brZ/ZWJi9EJUxU2cHiSmLeJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li88JAf1YvdjfMcHao/+AcrfGv5/IpZNRe5RhWIRt2E=;
 b=A8JiuEn9UY47e3/kjsDt/RGcDDOafKqvbC0IAivFmX4NBOnBjDsJLr3sHIoFAjLsEHfw3R053cg+NpguntUTgEwORZcRFceCIAx/8GJlwWqjssP58r+sk4AgmhEr8/lVBz/SOT3vX83zgrkdM0NjESO6VYAUY4AlhwBuZa4N+cnLrQ4lilIIZ6+cMzjjdlxPxxkx92lRPx75jf0QqN67KhXhwqqbm30sOpC13qEwrFDszaswPZapPU9E/eT5399+6W3fwdN3mNr1BCVSnA6rrwgYdfFev5OeO5intf+1AZRXZkG2m2cXn722X0plLMrUDqCN2/9snfSbCfCpWxmimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:28:36 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 08:28:34 +0000
Message-ID: <94f1eeb5-35c2-4edf-ace7-6917b06bb4bc@intel.com>
Date: Tue, 26 Aug 2025 16:28:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu
 creation
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-16-sagis@google.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20250821042915.3712925-16-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SJ0PR11MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c323c64-c9ac-4295-5ac9-08dde47a8c1a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0VLZUJ6TTdkelZXQkNTWEhQKzN2VWFacm8zNnFuWFdhSDdtalp4dEFoaFdi?=
 =?utf-8?B?NnBaN1VHQkpMT2Mvd0dLYVBtVUc5bnhvdzFCZzJ0V29VcmF5bFlvNlpDdTdX?=
 =?utf-8?B?akZhNTV3bDRCTzJ4TVhFc2twRGtFNDVBejliVjRieVZPb1NrbnRndmJlNENG?=
 =?utf-8?B?UEMrYnV1QjVCQjMzYVE3VWFkdnAwTzc1RWJ5anBGUHZ0M2JQR1ZpT3ErT3A1?=
 =?utf-8?B?Z0ovb00yTWs4SGZTOXg3Ujdac1dta0t5TGhiZ2FLUjNyQzBCUFZCRHNhbmhi?=
 =?utf-8?B?UlRPOElGVUJCaGFBelhxN20ycHRkNzljLzRtNzRKKzExK0xndVdvS3Jwd05a?=
 =?utf-8?B?MS9zOGRzbG5MUHdldjB0MEE2c0dEdUw4aU90aVE1TDJ5VWU4ZG9lcVdseGJO?=
 =?utf-8?B?cHhpQmFCTmV5NHIwQWZ4M21RT0xVY3hwekFoTFltL1k3dWttcEtmRDlvZmtL?=
 =?utf-8?B?Qk9PNXdqdWxZZFVhQjZQYzlDT1Q4RzZBayt1VWpVMEczUCt5M0dKRCtqYk5T?=
 =?utf-8?B?aUxJdVhPTkRrY1ErUXZNY3NLcDdHaUZHY2pPVnRLZ0VoSjJHaEpHWFQ0eldM?=
 =?utf-8?B?c2VDRnJWd2hFVFQzcGVuOFdsOWkzVDJyNzVTblh1K0hSOU9OcXBGdzNRczFC?=
 =?utf-8?B?Z0dCVVZVeVl4ZEtMRTlKcjlhcTkvcVJOaUp3VTMvZEhMZjRWckRhR1pHR2NQ?=
 =?utf-8?B?bkVybEdQNzNBQ3dlV3BuYWlLTkxZb01ULytLQStWbTk0MnJJTUd3SGZnQUs0?=
 =?utf-8?B?SG1aSE1SZXVOWTRXZjk3Ti81UGR6eFdjZ3hyczJBemZNbHRQNmRaWnowYTI0?=
 =?utf-8?B?L2FhS3NRR0ZIdmd2T2dLcXFram10WklVRkZmLzU0L2RPZGtmcitUaUZzY1Yx?=
 =?utf-8?B?dm9LVk9Jakx0UnJPb1hOLzExTGt6eGR1WEsvOTZnMTBLa2JoNW9HMEhLcW5y?=
 =?utf-8?B?cm41OXlTb1dUbnVKMENEWTBKTUtaanlRYXhmOGxNTUY1RTZaU1l0Y2NRaWh4?=
 =?utf-8?B?ditRVnU4eElYUmgydGN0bUlmdlRXYllIN2FsWTJjb3dIR05wYXNNUDVKclFP?=
 =?utf-8?B?aEg3MGg2aGU4enA3aGI2a014SEdESGZtd2N1YXBiamxRd2FRMlNWcGF0Q0tU?=
 =?utf-8?B?eG5WQk1RWVp1UVZvUUx0aFRFbWlsQ3VqR0VPMVMya2dsTVJJbnBtQlpvM0lD?=
 =?utf-8?B?T2ZwblV0c0JTaGhjeFF3U2tvWWQ5WG53eHJsWEFWRDUrYk9XV0xKUW5sWkVi?=
 =?utf-8?B?bllEUjVlZzk5VWdxblplU3BMTWxHN3BZR0VLQ1BRQ1VhMWdhUG8vUDNqNmF3?=
 =?utf-8?B?TllqMktDbHJaZ1Z3OHJ5aVJSTkd0MCtoUStBYlBqaEFYeEtkQ0V0aVo4K29V?=
 =?utf-8?B?WmZxY3o5L3hGL0M3RVlSU09MUTdpYkRHUGtLMk5EWSs5MW8rakJPZk9OQ0tL?=
 =?utf-8?B?NzN1NWRIVzRCUDhrTUJCelJJaFpHVlAvamtsaGtpWERXbDBxUzlrRDhrMkJF?=
 =?utf-8?B?NUtlb2lCNEJ4UHh6S1g1YVhBenh6QzFUM0x4dm9KejBiVFVmenQ5cXNWWXlu?=
 =?utf-8?B?amFFejBILzlXTC9YdFpwdjBuVGpCWnRtK2VuVEtCcjFjdHp4aDcxZFJGdnpi?=
 =?utf-8?B?VkhvRkEwaFFqTSt6WHp5TGVYNHRlRkRqd2xOc3ZaRlpzL2NFbkpwcVFyYlMx?=
 =?utf-8?B?SUYyb2NyUWgwaUlsOXFuRnY1dzJFb3pXeGNkWkNkNDU1eDl0TWlVQjFCdC93?=
 =?utf-8?B?N2dNK251MXZkMjY5a3hMKzg3S1ZHZStMa3k4bDV1a2JYM04vaG03L21IMjlh?=
 =?utf-8?B?NE51eCtSYnFFT01OM0hJZTNwdHhqYzRNRVFhS2ppaGJ0TnFaQ1poVlRCYVds?=
 =?utf-8?B?QTYwdkNTVmIyVFRMeTMySU1nd2dadWdIRm85bFM5b3c5eUZpK01sWmdJMzZU?=
 =?utf-8?B?NkhVTjJnNFpaaHB0ZkNaQVZMdHRGT3lxM2d3YlRSdGI3bXMwTlFMOGtsR0V4?=
 =?utf-8?B?NXJCSU5kU3p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8735.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHppUlpOTzhGdnVjbGJxTmtNc1BySk43VWhHL3BWblk2cVl5eVBrTzhNMWVZ?=
 =?utf-8?B?TktzNWhObkgyWjZaS3lIeHFsbFNGK0o2eDVZbVFyYXFIN1hhNkk2TnI1TnFs?=
 =?utf-8?B?Zmt1SE9KejV1eFJuYytOVzJvcTc2aEErWUQvOHJZTFdaamp5YU9wL2prb1hx?=
 =?utf-8?B?RjJoU0N0dlA0VHJaUkZRd1JFVzZOTUYrMTVJeUFzaG5sMXJIWEJFQkpKMGMy?=
 =?utf-8?B?d3diQ015cWd1eWFFd0FHRjZ5TStFYUhUb3dWMTUzaldtV00yUFFvTnpNa0s5?=
 =?utf-8?B?Z3h2QUNpVDFHT2pIUnZJTHVzZjVXTGV1WVBPbDluY04xUTc1dFlXVGNrKzdi?=
 =?utf-8?B?dUoxc2dLVlloUnc1R1VaQkp1eng0NkJhMFhncXg0anlvSk9KYnR0akc4Z0dm?=
 =?utf-8?B?c1U0SHRvT1hyeEkrMkJuRWZtRWcyUVVFRHdjYkNhY0NzWUk4Q0p1TmZ5VGdl?=
 =?utf-8?B?K1VmOWJWQkJPSEhuQTN3WUJtT0Z5MklhZDBrdW41Q3R5Z3owTGRvdTZwMDFV?=
 =?utf-8?B?TFBsVUZQaW4zSlJWK2w2ejRzL1NHREFrRUFMYXpON05CSjhGM3VvY2Y1V3Ew?=
 =?utf-8?B?ckhGenR3ZzczaGlLQTltTkNwU0FmMjZOR01ZZlR4ZzcrQk9DNmFGRWpPRURt?=
 =?utf-8?B?eCtKSWJjeVA5OExYbHFOYzVtVlNkdmZ5OXNMZVVvQW42ck93T25KS3lMa3JJ?=
 =?utf-8?B?ZGtRY3Zad01qZkdoVGVoaklxRE1PL1NlckxCeVp6ODdWK1hBVmMreUxXbFFw?=
 =?utf-8?B?TU9QNWpudUxkK1l1RE0xaDF6V1FHNkd1bXZaU0w4QnJSVHpkYnJqOGtYRDJI?=
 =?utf-8?B?dmtlZExXRGZvNVVNK0NIdlVsMkR2QXVxLzZseEl1QzdQcFdaUmo5T3doVDVl?=
 =?utf-8?B?NGZMVHlTeW5HK1drZWhqaGhxclRWZTZ5V2RhbS9hNitMbndNWFRqelNYelUx?=
 =?utf-8?B?dkJSZ0hTck1vQkpHaERrR25wdjJuK3ExR2xrK1RVWlNqSlYwOFRqdU9CN3FU?=
 =?utf-8?B?KzI1VTc1b2ZtZFRac09TMFpYZXI0eWhIRmxYMzc3bDVOY2FWcnF3L3A3azNL?=
 =?utf-8?B?eDdTYnBzM3F0djRHQTF0dkp6QUMvVTVIMWZxZndpNlFQOWhnd2VNY1VkQzZp?=
 =?utf-8?B?Ym5wNlFoNHFmMUhEZXc5aUtEN2R2RTh5cnl4RnhlMG5JVVZTQjhqLzM5MzZy?=
 =?utf-8?B?cWp1MWZQUVdtd05oejJFczVXN1dDQXpLWnlud3BBTDkyZ2plL200T0dUMER5?=
 =?utf-8?B?aE9YTk5aMUlMeFRhRzNPcmdtdENZbE1XTlcwa01sRmhXZTFabXdZditwSmVV?=
 =?utf-8?B?R28yWFFkTm1LcGQ4R3pBZzF2RmVzSmpJRVovdUwrVjQrMmczWTFtczZUY3Zz?=
 =?utf-8?B?aW9OVENLUVo1bmU5WVNacU1PU0w2eDh3V3JXR1IvUGdxeWpiMGtGZWZKV0s5?=
 =?utf-8?B?RkdoVEF4OERIb0U1Mlg5WkllSXBNK25rdXpPTE1wVUt5VmEyU215U3JaTkZ6?=
 =?utf-8?B?aXpzQ3dZRjBERGVwWGdWZkEwaFludjhkZXlnd1c3bEpTSVpiemdxQk9SRnZu?=
 =?utf-8?B?eFhVM2hZMDlxMWtKdnl2ZjJCbmVwRGlYbHZISWtIYlE4ZmxWL3lDNVZIVE1m?=
 =?utf-8?B?cHRrejVubG5kTGdxc2F2WGxZZ2hpeWNwcFBPYWJPamRQUHZDd25BeW1uOUo3?=
 =?utf-8?B?eXhyL1Yra2F5M1NtV0l1bG9BcEE1V0JWeHRKcTliNnpJS0ZYNTc1czY1VHQv?=
 =?utf-8?B?TFRQMnpqREF2OTZaQkdQVnpoNjZpZjV1a01vbDNIeU1lQVNuMXZuSkVnWnN1?=
 =?utf-8?B?TXdORUtpRkdwMGl6YUxZdHppR0hDYjhHa29hWXlPUVEzMGNocWVuLzlBaFNw?=
 =?utf-8?B?R0c5Y0p6QUs4SlhuRW56ZUJmQjNib2NBelVrK2ZzaS84NFoyWE5TTHM2YnBT?=
 =?utf-8?B?VDVxOWNoOVZHNS8rWFBMN0dXbktxRS9vaC9DajVzb0xpcFFucGZxSkdSeVJY?=
 =?utf-8?B?UW8yRm5xOG9nLy9tVXp3azZSRDBsVnpDZjBqeGg2emtxZ3pUMVRhb3BpaHU4?=
 =?utf-8?B?TE8rUHpjNFVwbkVzNUlqMk9teitYR3NwN0xWajJadG52SkcrV1BHWVNiT3oy?=
 =?utf-8?B?NXl6SFR4TWVPeGRMdnRoalk1d0hQY1RVL3MwU1NGSy9QSWhwWlgvbXI0MHVB?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c323c64-c9ac-4295-5ac9-08dde47a8c1a
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:28:34.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKhIC5VShx/Xo/6y2n6XpoZifRWYLXPRYw3goVbzFexucNhqsuY5zVbdxyum6Ovhuqz4BuGGGobMyBNpuk7NXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4893
X-OriginatorOrg: intel.com



On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> TDX require special handling for VM and VCPU initialization for various

s/require/requires

> reasons:
> - Special ioctlss for creating VM and VCPU.

s/ioctlss/ioctls

> - TDX registers are inaccessible to KVM.
> - TDX require special boot code trampoline for loading parameters.

s/require/requires

> - TDX only supports KVM_CAP_SPLIT_IRQCHIP.
> 
> Hook this special handling into __vm_create() and vm_arch_vcpu_add()
> using the utility functions added in previous patches.
> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
>  .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++-----
>  2 files changed, 61 insertions(+), 12 deletions(-)
> 


