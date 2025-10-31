Return-Path: <linux-kselftest+bounces-44486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91579C2337A
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 04:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4871B4E1B41
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 03:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C97285419;
	Fri, 31 Oct 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STQfR3o5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313C26E14C;
	Fri, 31 Oct 2025 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882844; cv=fail; b=Po1eLZN5ZfX5UIG6MTPy57JXk8KghbcKROpAhhHlcNx/NJh6ZnC6Z0qSknahiVgyxG0GhoXe+Q0DWLVVQNMe6KVdPE8KZLcbLw5YvjV3jdlOYD+iHFNiotY1AqsSbYhp9tWH3YNnF1DW1oToiScQ6QeWiNtgQzdknygVzzCqmAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882844; c=relaxed/simple;
	bh=mzK8u1MwBPdRZp8wHyAMhvKGpBsIGuOmvGznAQ3JM4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QAB8VM5a9MTGPtWwTobAs2ktosdSpMyP2fCcHB6XP+7iFtIem37/58GpHhAZ59ZEltooxBozFDXlflIiCP4gPlySpXyJ4M4ID63M4HWt++snW9nGbOGgfXVV7CGqMnv7CeNBsBE2RCEFFHPverkgQJHIN/3iNLAl211cxk5wDU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STQfR3o5; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761882843; x=1793418843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mzK8u1MwBPdRZp8wHyAMhvKGpBsIGuOmvGznAQ3JM4w=;
  b=STQfR3o5VSTSrBigBNZW69gOqcu0k2nnKi6gPSbJDiV655Jj8oFVurcr
   yGDjgPqBe3I/fdVT3jRO5iY1Hr0lRV4zxyNECAhzehIsFIUPW9u4+bZGv
   9g1hEq9eOMVjApund/CRs7IjfVDrUJ7Ejf7Pe/gykfvdGr5M09ooQlo7i
   UFdiap618JGh7r1ZTFKovKjRJTVkBfhiCkJFY0SPjx4C1DicDu1kPDg57
   4F/RVW1GqDh613jVbT3Z+ph0InH3P3UpDxScZzK5iavDAHGZesehLVW9Z
   ufIDoUMvRxDR6DGmvfmJ/DBHp6aA8ImABpYTR0c3W5HA6e6H2dUd0IMVK
   w==;
X-CSE-ConnectionGUID: hcJUHMbySkmSsssBffz4Dg==
X-CSE-MsgGUID: lYE9cnIFRYOyjeKYeQ+1Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67897627"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="67897627"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:54:01 -0700
X-CSE-ConnectionGUID: alkJBSiXROixvpBT17zf5Q==
X-CSE-MsgGUID: 2PrGjunKSeiVNqLg1mGQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185789671"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 20:54:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:54:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 20:54:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.19) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 20:54:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmJOB/6gaqvHgt6359CKCcUrOpuccWGS6CddlPA7Jie+1QnPaXYqxVW34Cd46dQXoRFDAcGyEhrNm/Xf4IcIfoLQgCSp9zmxOfOu6P9paf8o8tuWkTDCf6mRbEGDxJh079kVaTonWk5ruFYLMIxF7qfEYKG8OwN9GxsTC1ur8RRQs/Zxf8xub7MTWwh8GwK6vFgmE1MREqj0mQZpgN7ISu8McTnGVEC1WzpkvXidoLMs/nBmcvzgqqqiLpT20kToA5aywPL2jXKAhac+Q6p1ulgSJfhSLYDziPMf2c+1lYxmfrH9gLjxLyclig7ZWhC/krfPDfrgX835oM2lDIbFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US0tJewioGo8SNIe0qCL6aDrnLIOEbqRtmQeKqyDYhw=;
 b=TwF/UbXAP0sB/68lSkiyxrqhQrOt0V/Js+c6TpyNVT4Ey5Z9H6uRxk+CoeepTVhnS2cYrDEIhwrppAg60rDYUZgJPrxSEuO+3oqu6ahRzxDzZ7dUw2R2o37cEcIO04Mj2OnE0fleWjspRYZwbEnbTQdblhDECWG21E/6YL6pDsldhIGT4ofVzQCldlFA43m4VdjXFS3YvmJfkr7DhdyYQDexmO1L8oTiWS9GYdmcLILSg3ois+W6VHnK+JP7TX8F7ZBw3899tS8N043iM43JsggXiIiVwVAxRTOPpyyTCy18Vrm6dq20VQ6c3KRh9qH0ljetKKuh0fXKX9/0vYJ0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:53:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 03:53:52 +0000
Message-ID: <aaceb122-c64a-487c-9836-4436d7cf2607@intel.com>
Date: Thu, 30 Oct 2025 20:53:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/23] KVM: selftests: Update
 kvm_init_vm_address_properties() for TDX
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
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-6-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-6-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0332.namprd04.prod.outlook.com
 (2603:10b6:303:8a::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c56457f-13a7-4079-2e37-08de18311b16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmhBb3dSaWxIQTk4cFloWENEbGNtSEtpbFlBdUlGaFloWi9EWlg4WlRiaGRy?=
 =?utf-8?B?QS95UzNkRHhGVzc1WWc0MUNnWnV2cFZjYUUwb2swdGM2SThjM0hrSWZzd3hS?=
 =?utf-8?B?Z2J6MHJzRHQvV0ZOa3NickhkeHgwdUdVbkxTUmVhWklKT0RuM0pMTGU3aWRU?=
 =?utf-8?B?UFV4eE5LVGNCRDJoRjB1TGJxNXUwd3R1YlBDVSt6MWErLysyWGVWZXl6eFJH?=
 =?utf-8?B?bUJBUkpPSkdpZlVNQjRDSzJOQlZ5cEE2WitvcXY1dkVSc09IbjRVVXBkMm1x?=
 =?utf-8?B?Q2VvOVJ2Vm5HSk5vNFA4MjlJUHVTbWx0Q3ZUZVlzQmYwTG00ZmFNZzZQd1BX?=
 =?utf-8?B?YTZJN0h5dTdOeEV3MnpxQWZka2IwdlBTcXZzMkxTcHJON0NMTk5HMyt4aEMv?=
 =?utf-8?B?UFkrM1JMcE9KakpHZEhTK0k1RnhiL2ZydHdORndaeitiK2M1Z3MweEZOa0Vp?=
 =?utf-8?B?MG1ueUhXZzhuQStxQ1dqdjJCM29qTEVjMXpRYkZqNDA0UGRaZC9OdllrUmhW?=
 =?utf-8?B?TzZac3pDR3ZwTCtwd1JzRXZsbktsZGFaMFc1dUcyZ1J6WU9rOTRlb29yNERM?=
 =?utf-8?B?a0dGdlFreHdHeG5NeW1wOVd2Wm51TWZFSGZKdm11MHdKcjhXNlVubk9DeVBZ?=
 =?utf-8?B?eGxMSlhIWjNVYzlrbjhkYWNVeUtGK3Q1VExQM0lLMU9TKzljVVcxUXMyVERL?=
 =?utf-8?B?NFoxdEJnL0lNSXlEcG8zeU9HaVF0SUFzUTFCM2U3dFZZb0U2bFZiWU9kbkdF?=
 =?utf-8?B?cXVRN2ZPclpHd3NrTE5YMmVLSGJESmZORGkrVTdDQTJWdStQZWhrcEQwRXJ4?=
 =?utf-8?B?U3k4VzZBWHBNc09MQ1BNcW83a1lvdXo4c01YUy9pWjQ5UWVGZThMZjhKTjRx?=
 =?utf-8?B?MFpMWXJ6b2FEdzZXdUZYYzdhSm9Gd08yWmNSWWVocHE0anN3M082aUE5cm5p?=
 =?utf-8?B?cUFTaE9vUjU0bW95L09iNjBRMGhLMDBvSXBKeDc3UUhQVWM3YWNjRld4OG5s?=
 =?utf-8?B?TzJvUXpJakdNRXZQSForTzdXUUhObHBKYU8wYnRnYXJmT2tzR29XUmdBNVNn?=
 =?utf-8?B?ZDVIMDZpMzZOUDFiTjFTY2hOL1UvTmtNb2ZkWStBTi9BQVBOVFVFSkZhUHBP?=
 =?utf-8?B?UC9ZMElheU9FazBuUmpHaG9hVllUY2VZNlFBbWVDck1HT0tIUlZYTHl1cmZr?=
 =?utf-8?B?bVltQzRuclZjN0JKTHdvSEx0QkFVNENsck5lRDNxMlhPMGZhWE82NU03Wi9V?=
 =?utf-8?B?eHdBamgvQmhlVFdZV1NKNy9BN0ttUU8veUo5RXJ1YTJyd25QN29xbllrVG5E?=
 =?utf-8?B?ZXk1anc4R2hXbWxaYzA4NVhpaVhhWXNYaUtTNzUyaUlyRzVBNG5xMEVEVXpH?=
 =?utf-8?B?WlNKTytPS1p6NVB1TVN3aXF6SVNZTmtwS0ZUWTl1VDVkNmoyYkF4MVZiVkFH?=
 =?utf-8?B?cmtEalNkR0hoVzIrdyt6TUdraHV4b1NyQlNqYUJvTWc2Y2dzZ0huSlMxSkNw?=
 =?utf-8?B?VTBqdFIxM09pU0FwY1VldFhCSTRCcDdKaWNkVFQvT2o3b0xCR1NmeE5TTHBu?=
 =?utf-8?B?cEN1d3R0RXVUWXBxQmpxbklCa0t1UXhHdUdKMDlxOE94MlFJRE5MVG5MbnpM?=
 =?utf-8?B?MzdpYlFKMm9yd3FTcE9tOVhkRHp2bjd0bkRZdTYxbm1FTFNxUXNWeVNHSkZ5?=
 =?utf-8?B?djRLSG5tYWxIMEpkMHdnR1daQjVjcWU4QjdBZUhVY29LdFBZemdsZHBnYk9v?=
 =?utf-8?B?MzM2TGl2bktROEJmeE5qeTJHeWRwZllRdnBJOEc5UHhHSmhteGZsUFdpM2Ft?=
 =?utf-8?B?Qll0WWgybi9wTGhsSlUzanJUNytTT3FDVzRPSitVT3BnbGJqb3FMM0t6ZDFC?=
 =?utf-8?B?V3NLMkJQYlZGcE5ibXNmZnZYSENndXRmaTF2OFgxU1VFVERrMFg3bk5qKzg1?=
 =?utf-8?B?eHlUVXg1RVRNWnErYWdCcHEyNExZRi9lbTM0T0JwQk9kSDhNV3JkMDVxYlhR?=
 =?utf-8?Q?qrLJ+tG1J3RxvnI//nvA/UgKPUzU/4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGNtcDdLS3BIclFRUStxVXRtdXZqNXdCRDRKRllmRENDMWRiOUdMK3d5SFVp?=
 =?utf-8?B?TmFnQy81NDhxMjNCNUpEOVdkWDk3OFRqSDZjcGJ0cVFWNFlmRk5HZjgyam9l?=
 =?utf-8?B?OHJuVjVUbE5iVWYwUmR5eXRmd0hyOWF5VCtVeFZnckxjVTAzZ3pxYmtJV1Vt?=
 =?utf-8?B?cVFQQVZMSW40R0ZZbG9INlpON2ZxbXpnZkFVTXZBQUdFTlhFY2hwVngwYVJD?=
 =?utf-8?B?ZFRxSE1Cbmt3VmZhaUp3c2pHcFFtRi9MK2JBVWRLaENKd2tSUEZEWkxzNTJN?=
 =?utf-8?B?M0ZWZDRGMmhqS1NVNlRJZGF6VnV3REFyTHk1RXFpUmRML1dkYVhvQWg3UTE2?=
 =?utf-8?B?V25WVjZxOVBSdDJuZlVyN2JjZTZERDcwUnJNb0RYVFFmUTFPQ2M1UXFrSmpI?=
 =?utf-8?B?ZmVTcG1KQXZxUEZMVmlIajAxQS9hb1czZ3BqaE5zOHcrWDk2d1Rvd29nR1p4?=
 =?utf-8?B?RDFRTDZnZ29DZURFQW9wNDRISDBoOWZUMUtIOW5hQ3NnN21DaVBGYzM0SGpO?=
 =?utf-8?B?b2NEckUzUDZrTHVWOVNKQ1prU1Y4WjljWnpGR1hiS1hVcm1CaHloOEF4MVl6?=
 =?utf-8?B?ZUI5Zm5RcFp0eWhpQjhlUW0yd2EySjY4TlFZOGVVZk4vaEUxbWxiQWpLZ3Zo?=
 =?utf-8?B?SDJKQzFGb21MRitQa1g5cTZ6cHpMYlE3SkNwN2YzMzEwWi90MXBacUNsNWRr?=
 =?utf-8?B?ZTlzTkFydWZpY3dXeTFoWEMvZW84YklzRjlrMWtpTTdkdEFTWXcweEozTWxW?=
 =?utf-8?B?VXJucHRrRzE3Y1hpSm0yYmZJejdmYlNPWDZoSnNrYnFVaHlpNHNMMXFFT212?=
 =?utf-8?B?UFUwVDBqSjJUR3V4eHZHQWtvSk5Ua0I3emNzVTBCT2dlbDVjL21MVGR1aFJY?=
 =?utf-8?B?aXBsTU9HRUFadTUrMmhhWWNlclBEWHhoczN0S3QxUVI2L1E2NFozK25NaTVt?=
 =?utf-8?B?R3dOejNwaGRMNjlkU1lzdHRiLy8zZTczRVZOeGtQZ1RlUlR3Wk0xZUhqT2o3?=
 =?utf-8?B?UE9QVGt3djJmTnhvTnRHWDFxOCtmNFIyOTVOOC83RVFnclN2RzRQSnoxN1Uw?=
 =?utf-8?B?bk8rM2Zjc0FqU0E5MTJycjlkOFJDVVlacitPQ21pVGhlZHdCNGk0MnRJZVZT?=
 =?utf-8?B?aVUvUnVBOUZteUtLZkZnZkZLeHkvSkZMc05FRlNoR3lqcDhneFJzR2dxbWJY?=
 =?utf-8?B?UHdwSzVORGNuVjMyUElTcXFMcHpYTXVSMFUvRVpLVHc0S2srbzhFMzg4dmxZ?=
 =?utf-8?B?T1lDclNZUXNtMVN5OEprWmdIcXpPRE83MXJ1eFBCOWxvdTB2Y3ZFenhNKzlS?=
 =?utf-8?B?d2xQVVZOMDNadGsxZ1k5QVhIOUxvZCttb2JLWXdRY2FhWWxXM0J0WTVXUkJK?=
 =?utf-8?B?cjhuVEk2MnN2NHNoVUtoc201RmZMOCt4R0lRczh6QUdFZlJKS3dxK3BnaGps?=
 =?utf-8?B?Nng2cjJpbEZtdUtmSG1EUzY1d2N4dDJjWWJpYWJVbTVZa3ZVeDdBZy9mOEo2?=
 =?utf-8?B?WHZUYUNNSDBpWVFldG9PMXpPVnZIZm5EQ0VLVzRrMWhIV2Mva3VXOW8zb1pV?=
 =?utf-8?B?MVR5RXA0U0svRHlkOElwQ3NrWnN2eFFrR095YkNYTXc4blBPWmdqL0doRmpW?=
 =?utf-8?B?NW9MeUtDZnJEanJDY1ZtY011b2FqL1BDeVR4MVRXODZNZmpBbXBsR1h4cUdR?=
 =?utf-8?B?K0hCUE9QMVgyR2VadEJydm1ucHllVWN2Q1J1RTdwMnpaazMyaHNMTVpVNCt0?=
 =?utf-8?B?bFlWb0tQNkYzTDlnL1hodWg1Umg2N2EzSEdFQ3h3SjJWV1U2NHYwTFhLUk1w?=
 =?utf-8?B?am1rTmZkZk50a3NudjJOamhKdWg5eFZGclJUQTRSdFpzQWh3MEdON1U4Vld2?=
 =?utf-8?B?eVRFb1cxdGQreVdQWE04ZWlYSkt3VGZqMXI0R2U2OGt3emJCVWYxUHFaTlQ5?=
 =?utf-8?B?TmQ5WXoxSFMzQmdLZ29RRndyTHVzU3JpSUY5dzllenpUTGJiM09kT3gra2w0?=
 =?utf-8?B?WjEzNU0wZWZUYlNtVkltbGMxYTluMHczV0ZFZXpzQ2JtOFlqUWNFVmJrTUhT?=
 =?utf-8?B?bjVPdnZpMGZCalB6V1gvSm4yeWEvSEdoVnVsQnptcjljZ2MzSlpPamVwdnRH?=
 =?utf-8?B?VGJCdmx6RHF6a2xUa3U5RDZxTmZYRHBpb1VqaWZMOWlJYlVmdHFWOWQ4SE5F?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c56457f-13a7-4079-2e37-08de18311b16
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:53:52.2628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VL0gUodUTbVn+fKg/GQxIBm2U+vgbCrDr9savMaLK5/Zg79XRI4473pRgX8D6JCHO+HE2JFoIffPcpYAr0X4niZ9NnJJWBCt9A32eu5njM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Let kvm_init_vm_address_properties() initialize vm->arch.{s_bit, tag_mask}
> similar to SEV.

To me this seems like a verbatim description of what can be seen from the
patch self. How about something like:
	Initialize which GPA bit a TDX VM uses to tag shared memory in guest page
	tables.

> 
> TDX sets the shared bit based on the guest physical address width and
> currently supports 48 and 52 widths.
> 

...

> diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> new file mode 100644
> index 000000000000..286d5e3c24b1
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef SELFTESTS_TDX_TDX_UTIL_H
> +#define SELFTESTS_TDX_TDX_UTIL_H
> +
> +#include <stdbool.h>
> +
> +#include "kvm_util.h"
> +
> +static inline bool is_tdx_vm(struct kvm_vm *vm)
> +{
> +	return vm->type == KVM_X86_TDX_VM;
> +}
> +
> +#endif // SELFTESTS_TDX_TDX_UTIL_H

I recommend this work sticks to using /* ... */ for single line comments.
For reference you can compare the custom of all the other header files in this
area.

Reinette

