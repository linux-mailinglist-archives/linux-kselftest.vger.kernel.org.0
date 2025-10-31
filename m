Return-Path: <linux-kselftest+bounces-44538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608DC2609B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1501B25E1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFC427FD75;
	Fri, 31 Oct 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNjjjXVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F30F263C8C;
	Fri, 31 Oct 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926647; cv=fail; b=pPwGk41YoboHusq4SDOViWsIyRyKSZaZhuE0ekEdcixPsBuhW/p+8U5kBTMTXuNcAufUKVNc1Py3uQ0Oaci9LPk3XJ1CCWltyFVv6+wNCHsBOi/x0HN2u+o3KLI088E2MDTsuVmL/34sY8cxX30fnzZ3UN7aOA1LSvuLrtvxtvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926647; c=relaxed/simple;
	bh=pR3onbLxaf4WCLUsFsEhQENgGILt0wp7cfcLh3YNEWw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjCqUWsAnovYu0B8SqXMxV5IyPmbmburVmAwOvds/yxWWatwN7XDcMHjVrHkwz1VmFMeJ7CJl03TTtG/JM8jKMRTR2UNanuw8Suxse4re6kBkjskINsv3CQuX++aNBO6HmheCqp7qe3Tlnx2vVizM0TQQlBGlC0/ftN287hALkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNjjjXVt; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761926646; x=1793462646;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pR3onbLxaf4WCLUsFsEhQENgGILt0wp7cfcLh3YNEWw=;
  b=bNjjjXVtjMhEmU1n2xIdva5U/QojPJSLHCTUczVK0sy2TOu0pSGm4VQJ
   7sSWpTMiGScmHau9FKrhNjv+tjOl2H8Ii5dVGLe9C17mYv4WFGZaqAr80
   iC6NzHUMbzK7/ZD6rB0KyG5sFvtQnT4sZBxjtJk//Q62aZN6nUXqJqmqu
   yZjoZo31B6L66XIP0VVLS0vGb/IJvltndxNUA8HfhgQEikKv98YVYeKYq
   gOX/B/avJLHFxsJ7n/4Bt3+DH/SvDBUiG74yzfGhRNJX6J83hoITZ9tsD
   mjvmUYkkQWvmwxBgilnX1kgr3zaF+4xfHXCUb8tA8BhNZLAbUsx9YE/cd
   A==;
X-CSE-ConnectionGUID: OCDWifKdSoqRS2180wDXuA==
X-CSE-MsgGUID: n7k1gwptS8WqzNftw3Ozyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63994469"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63994469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:04:04 -0700
X-CSE-ConnectionGUID: VVx87LhpRRO474iVD6BF8A==
X-CSE-MsgGUID: 8eD0FpPYRHOKPt4kPnPhCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="190616116"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 09:04:04 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:04:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 09:04:03 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 09:04:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jikhZvXLMYXjznYleCbQ1R1vBNh2PEdL9lLMj/sjx71n3s3b56ccmDKfQPHEJTcWMaKX8WSbJgA7jEQYNfvYCZ/virLZJWuUBUBb9Y0T9f2/Q3tQnpPcH5XcwJBK0E2qS/3E+VV1Sc/E0hdNVBgUUS1Blcoyq0ZJOW8oST+Jw+ht7pFBP2Zj9E2a5k0SuGhMwx3scI1KEbnNC1xUytHMayqMOye+K6t31WYtd30UVaiTF+lIFwXJ1rp1X75Vf5z/ISggBHrsHvcBrmwCGpQFQ7UjveGz0QOMTj+ADnWZ+goHV82SiAqSGOGq0lWWLjEZ950HX2L4EdDfgL6OQbPsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W6lKS2lB4dTsXIy/LVsuFDymQPYjQpqhiEsquHxvyo=;
 b=LnAPHSDHZKdKT8JSO32G0VKhHu1x4BIk80JDg02ARy20uX/vC12twsDBT8o6LELoCbjzSOQe+OXruwHpKbVwF9EcoImRc0H+gHhUAHqz0YPTkUrfLHJ5hIYaCacQQx/SE8aqq0pw0vZ1KpbuznVa4r7spmtKEJrw9Rpdbh84xsHk62p6EqaMIliGg5dGeYJRnO6XRzAI/ZbuK+uxYDgoVmEiZa5I+ZSHWm0rfuYloAZV26J4b2Ju94pH1u4A+NCbMSEXbs8hsxZoBNPycjd2+28CDfnG3Hl9YemFY5Ld7X3uGNmNvuUzn6fVGcigvckqVWxWNGRxRa4dpV5DskGakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS4PPF46B98A11D.namprd11.prod.outlook.com (2603:10b6:f:fc02::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 16:03:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 16:03:59 +0000
Message-ID: <3035f3a0-5d0f-49e7-88e5-1898a554dede@intel.com>
Date: Fri, 31 Oct 2025 09:03:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/23] KVM: selftests: Set entry point for TDX guest
 code
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-19-sagis@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20251028212052.200523-19-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0147.namprd04.prod.outlook.com
 (2603:10b6:303:84::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS4PPF46B98A11D:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fc0eaa-543e-4383-e8c0-08de18971a7a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MW5xeGtrd0s3ZmlMK3JrbCtZdGZJUEd2NXcrVU56Q2VYNmV1UkpTN1hEWFFY?=
 =?utf-8?B?YmZMM1d0cml5bC9va29wT0NLZExxb3hiSW5rUUJyd2ZSYTN0Y3MvZXJLTnZa?=
 =?utf-8?B?OTB4M0xUUFo3bVQrbmNMTXA5amQxdXJRZEhUZ0RxQXRyaHYweGNTR2hrRDBS?=
 =?utf-8?B?NlpnQXU3TjdORDBYaTJodlNya2UvSEJUMktzR0ZrU3ZqaU5taW5xQUNoVW9N?=
 =?utf-8?B?MytvQnp0M2VPSmtpbno0amNCdW5ENFdHY1FrR1Nzdk9MYlhyalJtSjZmT0Fy?=
 =?utf-8?B?cmZHZ1lSR1dBWCs3VC9LNldkZGl6VE5OQjRKRktxbUk5YUdISjhqRUk4SUlM?=
 =?utf-8?B?ZFdMcS9SWk91UE00RW5WNGZMY29XTXl4TlhWZHlZOUpWazRreE5vT0g5ZEZR?=
 =?utf-8?B?eVFwOVZCeDFoY3h3Nmt0REROSlNBdUhxOGxYMFhpQndxTDJBdW1DbWtUeDJS?=
 =?utf-8?B?cFA5Tmk2YjJsNnhRNnBDKzJSWS82bm5aUEZScXB1WTFnUWkvTkVOWnpUUTFv?=
 =?utf-8?B?TFBRSitGTklkbEpnSS9ETERtcHlLNzVZOUR5a1lscW5FaCtvYjQwQWtoVGRa?=
 =?utf-8?B?Y1lkaE8yNW5zTVNwUFdwLzdPalk3NENBYzhQNlZ5SElMRFBocmxSZk10Z3lO?=
 =?utf-8?B?Z1JFSTNQdzFpYmNkRmVNeUM3Z3Z4SHVIWU9yR1BpajYrZWc4NVBSVDZMN1BC?=
 =?utf-8?B?TThBUWE0OU9iMnpnOXhTQWN3Q0JGZ29hbWFKNnkrQ0JmM1dWOGFEN2VEZm1L?=
 =?utf-8?B?TlNLT2Vydm9WRnk3TWJyYTFMekZRNjc2Rmt6cWFXR2tNQnA3ZjNCeHRUSm5w?=
 =?utf-8?B?VFgxZnBoYmtTd045bnV6Sng1Y2FhdGdJNllXVnBFaE9PRTc3QllUWGJ1eE5x?=
 =?utf-8?B?amxCaHhkNWRNT1crTm52bVhVcEh1YzlKUTNwV3ExQ3pUd3lJMFcxVXJ2bTZ1?=
 =?utf-8?B?WnFUamFPRDR0M2NVdURxdEF6QVpPN1ZGR0QwdEF3YnZhTjN4QzdaRGUzT0VZ?=
 =?utf-8?B?bGVJN1BUNnhNZ3h6V1l4N2lKaklQTWFtZHpmcU1sV1E1d0dwOXoxdHBZNm9M?=
 =?utf-8?B?YWVFUllYOEcyd2Z3QUphL2ZlYXNoUFNRUkJuaUJhTkxGT05zSGh3RFdIQTUr?=
 =?utf-8?B?RWdaOVF2T2dlTGpvNHdNb2FOblA1cVN5SkRpMjlwQjQrb3I0TEFqVkhhS1B6?=
 =?utf-8?B?OEVSNVpsUitSWjhzbk5Lc2FXVGdnV2ZVakdEKzQ5Wm1Ya3pucmxZNE9GeVUw?=
 =?utf-8?B?S3RGc1R0KzVrNVVqN2UzUGY1c0czSzF2bGtFdW1Wb2NMNXR5bWZaSEliYXFS?=
 =?utf-8?B?NkJoY2txNUVLMlZidHRSdTJCQklOMi9Ibk0veWdERld2SXhPcTNOaGJhNkdL?=
 =?utf-8?B?L0xGdzRkek1DdDNhQXBZNG5jVWhLcldjb1FUSTBSMnFDTlNXdUlJYlFaQ09N?=
 =?utf-8?B?SFVydlozbnBkZEhqcitPRUw5a25FaEhJbEExV1BjMnBGYVplZ1ZhdnJ0WXBI?=
 =?utf-8?B?TlFacVUraGdxVUpmbXovMFBFdGdRRThqd0l1ekg0WVd3TllQYk1lb0lxRmRR?=
 =?utf-8?B?Mk0rcXo2UHY0djVBa05lMnErd21TR1EySUt3NDRMbHVSZHBrZHU5cHErSVY3?=
 =?utf-8?B?SEE4T3I2Tm9mcHYzbS9meFBVanhMSTh0YXF2RVduNk9pT2RydzdwQW5kVXUv?=
 =?utf-8?B?TWxiZjAzQVFXRU9EM0RMbEdmWmhrbHFnMEg3clNvNXBiS0RWVE50QzE2aE1r?=
 =?utf-8?B?RzVaaFFPVnh6bG1Bc3VzWFZjbUdwQTN3cXBsRk5rc0EybEkzckJtMFpRY0RP?=
 =?utf-8?B?cmxqN3JJbHpDMnBOOCtlNktEWHpSUE9MWXdSdk1QRzBvV255TEp0aEtvWDdU?=
 =?utf-8?B?N21mdlNLclF4azgzQXN0N08veU55Q1ZlV203NUhmemxRSDBtbzl1bVpMdWNP?=
 =?utf-8?B?eXNLMzdWN2taTG1wTGFyMDluU3RSU05GMFltMlpYRFRLc1o4K1k3bUVheUZV?=
 =?utf-8?Q?71ZahVuyoe/ysnXnVosSUR7M94Ob4I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmt3ZEhpWHV0MUxoVzZTSnBFS0V6aU1vWHJlU3NPeUJYbXlMRCtzc1hWbmhv?=
 =?utf-8?B?NXE3NVhlTFgzdmlXenlsSlJlalFjR0lITXBCQWVYK2hjR1pGQkVvL0pvQXo0?=
 =?utf-8?B?RXNoazFub0ttb29pMndmYjVnRlF0RGNKdVJONnA3a05HcWpqclhuZ2FsWHZz?=
 =?utf-8?B?YmhFZzFnRjlLRFZud1FaTHdGeG5kWXdoaFdBOVB2SDNVekhZWGlSc2hMVDRk?=
 =?utf-8?B?RkVPYVVUb0luTjZQMlgzVlFaM2pINExJNzRITGt3QW9ySWd1WkowRVY5U1Yx?=
 =?utf-8?B?dVN3YlFjRDQ1dWVITFNiSjZUMHVLZjYvcGdVLzdlYjkvRFVlNnpQaG43c3BU?=
 =?utf-8?B?Q3VTSFdwSmE4UWZIZ2V5N29mNnFYVUhxUnlIbjRreFdndnFiQk1XRmEranEv?=
 =?utf-8?B?ZUQ2UzEzQ2Nqak11UUwraFJOU2Uwa0hpRHJPVDd2dUIwUkZzQVRxRmhiaWNM?=
 =?utf-8?B?bVFOZVBCQVpUcjhDdWttN2owLytTd2t1SWd6Rk52SnFtQ3Q3MFBwNXZ1Y3ZZ?=
 =?utf-8?B?TGVGczFlYm0zZ2lLWWl0TkI3dHBBRW1KUTZWMFVrOCtZUXJ0amE3MXJ4NmMy?=
 =?utf-8?B?QWJMM0xINUttU3FseS9ZQU9MRzFEYjErUGJnRVFnTnRFbURQNGhTYUVmRU92?=
 =?utf-8?B?SDhRWHRaLzkrWHU0aEFoOXd6UnRWaHZkbExQM0dPOEhhb0xDVDNGWi9EOWxI?=
 =?utf-8?B?Nko0RHhMd1A4QkpFV2ZNRHkrOW5qUklEaE9zdG9jcHp0MGZHWVFTNkJ1aVhU?=
 =?utf-8?B?RGl3U1FHWUtFb3VLNkNBYkhEd254alRKQ2tZaGVjWEdFTkRlVlZCdDhPWlY3?=
 =?utf-8?B?ZnlscVhYb2tONk5xdEM5K2p4WTBTdVYwYTZUOUJOZ3JCLzNJS28vOUdXZDhN?=
 =?utf-8?B?b3I1OVJYTm02M0xDK25yczRnVTM5RHozUXV2bmxzYkNpQUFPVXVwTlpFMy9C?=
 =?utf-8?B?UGFZcDJGSVVpM0lIYVl0SW8yeW81cXp5QVdlc1lzVlhNWnh4ZS9vQmRsNy9J?=
 =?utf-8?B?QUxYTGxkZG9xOXFubzZOQTYwdlhOQzJqU0VjNUZyYlF0dTd5Q3c3dWNDQVFs?=
 =?utf-8?B?NkJmYXNPOWJmOTVyaERzVGtjRlU5emh3Ym8zZ0lMMSswZytQWW5VZEwyMTFZ?=
 =?utf-8?B?ZmZheU1TOGxrd3pwU3NGbmNXcVhqa1ZDZzdteFlvRTN1aTQwWitlaEpDdDM3?=
 =?utf-8?B?aWxtUVg0ejFiRkNoazNDTklKRERBMy9DdHVZWkdVMkVHUCtuamlseUkzL0Rz?=
 =?utf-8?B?TUluRVErbG80V2NIZ01LOEJSbWpNYlcwWklZczRUemZpbjlNdTQwR0c4UmZl?=
 =?utf-8?B?SUlDSmFBcUxvcFozK2cxNWEvTE1yNDRsSTRwZUNHSDd6NDU4cGpvRUErUFNQ?=
 =?utf-8?B?aFdKU1dqYUVycHZVRDdzczNxS2t5S09tRWQ1QlVwZGYybndzWU5KMXI5UFdo?=
 =?utf-8?B?Y1ZHb2c0MjczQnRpTnBuazFKMEowemFDRVlEbXpMWWdTYmlYVzMrb2Z4Z2Yx?=
 =?utf-8?B?SWZwSWVCZ3BqR3UyZURwODhPOTFqbzVwUHZRS1lGWnoxVDBpcSsxUmZiVFhz?=
 =?utf-8?B?eFVWTVNqRkxzT1IzYVRKaGozNVlZVzF2Yzhrd0dJVGJ3N081U1o1cnNWTlgy?=
 =?utf-8?B?NzFudyt6b2JHSkJpSTg3aUtRZjFYWENoRTRPNVR4ekQza20yUW9uZFc3SkJW?=
 =?utf-8?B?QXByMGMza3ZFSU0vZ002eWlrRjVjYk1iQWp6eHA3dFVYUmdKU2x6NUwvTXQx?=
 =?utf-8?B?aVJwb1cwaDArM203cG5jUEw4MitJa0ZjdUVBbmxtVStCQy9NcHZLVzY0V0Jl?=
 =?utf-8?B?NjZXMnI3SmFuQTdZRmluNmVVeG50UDlWdDR6cEtiT3hhaGg5ZzRpZUl0MWFU?=
 =?utf-8?B?WndMYkNkV09vbjRwUmlmUlVCMGRjd0FZWjNSKzhWVVdsVlEzR3lNOC9KdlFP?=
 =?utf-8?B?VHpnUkRwTTk1SnlSTDB1Mmp4d0VjWGhzcFVaaDFKZ0xQZlpNQ05RRnZPL3FQ?=
 =?utf-8?B?eTZjM3lZcHdJYlVQSE5TVjVHTWZ5bkZMRTdxY2liVnpwdEM0TjNZMFdiSzRz?=
 =?utf-8?B?dlVVV1VOWnpsMWE2S0VsL0M1SFVGSWhwVjdTbXlRazIyQW14SndFMmdobW10?=
 =?utf-8?B?Tlo5eHFRUFZ0b2pIdU53SEo3Ni81NTAyQTFyK2RXaTd3Ni9GSHBkTWZjeUZE?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fc0eaa-543e-4383-e8c0-08de18971a7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:03:59.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPjpmkUn4IIQ6m35/Wy51ab1b2PrXhxegPZ35OSicXcv1dU55Pmv1JuwQtkbhSSlSMceu0AfUIgPlTg9HQl8YacjD61mCqR56IJpFj3toQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF46B98A11D
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> Since the rip register is inaccessible for TDX VMs, we need a different
> way to set the guest entry point for TDX VMs. This is done by writing
> the guest code address to a predefined location in the guest memory and
> loading it into rip as part of the TDX boot code.

Check the changelog for code impersonation, imperative tone, and matching the
KVM requirements.

> 
> Signed-off-by: Sagi Shahar <sagis@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86/processor.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> index 036875fe140f..17f5a381fe43 100644
> --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> @@ -691,9 +691,13 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
>  {
>  	struct kvm_regs regs;
>  
> -	vcpu_regs_get(vcpu, &regs);
> -	regs.rip = (unsigned long) guest_code;
> -	vcpu_regs_set(vcpu, &regs);
> +	if (is_tdx_vm(vcpu->vm))
> +		vm_tdx_set_vcpu_entry_point(vcpu, guest_code);

Please use braces around both branches. (for reference
"Placing Braces and Spaces" in Documentation/process/coding-style.rst)

> +	else {
> +		vcpu_regs_get(vcpu, &regs);
> +		regs.rip = (unsigned long) guest_code;

You can drop the space after the cast above.

> +		vcpu_regs_set(vcpu, &regs);
> +	}
>  }
>  
>  vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)

Reinette

