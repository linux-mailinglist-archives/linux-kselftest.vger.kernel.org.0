Return-Path: <linux-kselftest+bounces-40025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0601CB3784E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 04:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46D420497E
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055D2877ED;
	Wed, 27 Aug 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRuDQUnO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9230CDA0;
	Wed, 27 Aug 2025 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756262791; cv=fail; b=i2+Ed6G0jI41o6XTRm53dSPCmmEJCq90FAQxt/hN/wuYLD4ZUcY6Gs2NjqW8jwA4vFcMihuSMDwCEfIRp7Y63NRnK7t6eWIjLMp65WdbxtbVrdKJJvwNq0G8qNnBJ90kB0aTEb54ZZs/27ifOKmj6yOIhne/fBG24hk9hUURsTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756262791; c=relaxed/simple;
	bh=lRLamTNzbdYAO0TyvFvFa8CwFWTy/XHtm7EjGhBHFto=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ASOqyCz3BwjZIq7k6B8TB6KWB7zgSld9rTgjjFoFIeXa+aVuWRgsB+jgzUNffbeIK/A33bLBUQ1x+XilLhiwCZmJYmKP/gsm0ee4zoH6FCAsnjADFqF4oJ0Sb+eldWT8amBCtiqJ/RrANEQUolWZL+mv/RNqDyWK/xBkb+acbBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRuDQUnO; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756262789; x=1787798789;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lRLamTNzbdYAO0TyvFvFa8CwFWTy/XHtm7EjGhBHFto=;
  b=CRuDQUnOKxu61FN3zPqt9uefSJtpR8PQkd+6MOTw+kJ2LrA86NMOQCw7
   ma16x61EjVPXGfTT02KJyOhhBAZC4/21c8V/nP/Xmc9BGaxxkPUg6FV/0
   grZnFiKBWQPBSjD6YknWjFRX81Asz0YlMMDrn79rdV0hf1777zKT/R9tq
   PcPwcMOajOJpwnkbJrFleN07dw1nnRfzYzpv1kCve9FOkJTKQCDp+WmzG
   gCNZEjF8cxCMlUSWq/7TRkVScyRSIovRhUGyMUT5Fn86nEz+eYo5GG6OY
   r6AeRs1rw5tlqRAY7CwRuNS5fVwqKoAjwoMtArRzGCSnhbWIL+genrmeY
   A==;
X-CSE-ConnectionGUID: GzzYiKjhS/utU9T5agRioA==
X-CSE-MsgGUID: eyqls7PnTR+rIGyAcE8rDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="57528550"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="57528550"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:46:21 -0700
X-CSE-ConnectionGUID: Banj6X5pSa6XbELyk3ykTA==
X-CSE-MsgGUID: suxe1cFmQSSoU4wgYc0WzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200624400"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 19:46:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 19:45:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 19:45:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 19:45:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCTHZ7foNwWBD7Yr4JED5khWRtqfxoqQiL/KQw71RLmwqu2pfXOprtPdc2toPTmLYQikSh6nM0ydKJ8L5ME4rP9GLGJcDo3CS765bYsb56SHXYdabxUgHhrGcPS2IBSefeFDwV6X6gmq3aw9SENMEv6ZJfRiJ9HZ5pGFOOrfNytFoxjjAVHr2xVngWASyrwELaTMk/XUT1sfUMVP7dvgjtbLrRrlVvo2Sm0Xz+1NTKMMbxehY91zMJkdKqf42/gsNOHsbeEqdJs2c7hvfohCjVEOf37SELC7xuRcrpGbZTJiB0SwxiW3NJFK1FREO5e5a9VLIriAfOPsTQ1MoR9GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dT1Cu09+z9yBCoUEGDgdXBufzYnhKRFEb9N9/wi/YPg=;
 b=ggKekUH95vpI3TYUaIRwaLXtCYbC5lOXPos2mNEK52ruLDRYNeMdz0zZwPdQHaPmKk4PPk82GeXkiZKTGtEAhaL2Duw7VE9+HETk36pgYHbzk2vyXN8PVPxS9jj9fdyPWHrAplS7MUwVp9v3k3kZaqfblMVBBMtSfnC57LM6rtzmyLWqDoSduPo8IiLxxLCgBMAGu55EEVRyFQNhmpd0aLLm3cTU2tCtW0YvZPTK1EUTjpNzH4YgDIJQWyfRJ0YgzzMBtAk/R+Pc538QE2hLdgQYvoBGDuxAi/859wO4bYdGC5VDUBvGsVX8hk1J5ouSUfR6Ecxlby/QNHfo0m2a8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SN7PR11MB6680.namprd11.prod.outlook.com (2603:10b6:806:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.31; Wed, 27 Aug
 2025 02:45:50 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%7]) with mapi id 15.20.9052.013; Wed, 27 Aug 2025
 02:45:50 +0000
Date: Wed, 27 Aug 2025 10:44:58 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
CC: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, "Pratik
 R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v9 14/19] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
Message-ID: <aK5xKg58V5BLAPDr@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20250821042915.3712925-1-sagis@google.com>
 <20250821042915.3712925-15-sagis@google.com>
 <aKwhchKBV1ts+Jhm@yzhao56-desk.sh.intel.com>
 <CAAhR5DGZnrpW8u9Y0O+EFLJJsbTVO6mdrh4jbG4CrFgR13Y60g@mail.gmail.com>
 <aK0IxsvmlNvc/u7j@yzhao56-desk.sh.intel.com>
 <2a97db5e-ee82-43b0-a148-e4af1b93ca10@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a97db5e-ee82-43b0-a148-e4af1b93ca10@linux.intel.com>
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SN7PR11MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: aa0cb080-a49b-4801-d663-08dde513d563
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHBDb3Z5aTcvZUZnMUVQTjFIUzBtaXBJd2t1aitUamQySGFCYzV0cFZHN3Vj?=
 =?utf-8?B?cmRkK3BSeHBIK2ZXTDB5L0FMbm1hbkVpRW43NzA2QmJLY1k2TkRrKzlzNnll?=
 =?utf-8?B?TE5vY2kzQWJmYlFwQVhlWGMraGRuczFnTE1DNXFnTHZNUGptOVFEQXFkbngy?=
 =?utf-8?B?NGl5TlZzU3EzdVRMR25UMzRKV2xRdVlha1JPeW90UzFJbDFlczByaW5WNGNo?=
 =?utf-8?B?TFpSa1lwWnAzUHZiNGRmMHpPMHlMWm9jRkt2QTJPNzVkN1l6VkgzaWx3VjI5?=
 =?utf-8?B?L3VFd1RFU0FMd1RGTGJNZnJ3TVVvTWpFUDU1Zko0Q0Y3cUxzY2NQL0xVMDdT?=
 =?utf-8?B?TUxkbnJXTHlObjNpSkpnaUlnUGN6TC9QbHVwcVVDZ1dKZ2t0em52UU9Oc3dn?=
 =?utf-8?B?eXdpbS9UUW5BQzF1OE84TjI5UWorMFNDUTVRbHVjc1VhdVluL0tXaG5zZmhR?=
 =?utf-8?B?cENWa2crR2IrQklFQzRKQ2w2RFVOb1NxK21jeGxNTi9XOUh5ZXFRcUFET1NL?=
 =?utf-8?B?VVdFdi9UU1lFZGpOc0Z2Z2p0dFphSmFoSStrTytvUmNLR2ZsZDZlZVp0UjJx?=
 =?utf-8?B?dklYUUF1bzdqblAranhpMWlyUXdGUjhOTUl6OGpmS2xYck9XV2k3UnIzUGxN?=
 =?utf-8?B?NExpdTRMM1pnTlEwcVMzZVdmcFJzWUYvZVRxbnE5Y0VFNTVQYTM4M3k2Qmh5?=
 =?utf-8?B?SWhFYkhYVlZOcUNmOFczK3ZqcFo5VDNnNFdkbGZyREduYU5MNVNacTJaVzdk?=
 =?utf-8?B?M0JHRHM0RUQzY3NiOHRsTk9PWTBrdVdhSmhLVGpqOU16K2VXRlVZV0RrSEJX?=
 =?utf-8?B?TFI3bkxxS0tPeWxZYmJHNHh0NlBVbHI4KyttT0ZLbTBtRlBweDgwbkp5bWR4?=
 =?utf-8?B?dm9aaUhFQ3NsbytKQXl2dkdhVDQ4RXJIaHA2NW5Pc05peE5XUW52OGpXd2p6?=
 =?utf-8?B?cnpESlpBUXQzMzRqL1BLMDRDSmp4Vzd5N1F3YXZZdXM0UFg1WElLdlM3RzEz?=
 =?utf-8?B?Zi95Zjg2VzFyNXJJNnoyVWlpSk5yUy9HNWQ3TW55NkdnSzl6OWNBMXJQMTln?=
 =?utf-8?B?ZVZ1M1V2bGQwc25ZS1F2UG5obTdmUzdlbVdTY0o0VjNMU3BOT1dzcTNzMHNQ?=
 =?utf-8?B?YWI1eDZBZytyemJSR2ZBaXhXdEJBVEZuV2gxL1M4SHkyVXZOMFpOVzB4Q1VM?=
 =?utf-8?B?UXRpRUM2cFdxeVhaUGxQMVZvQnlOaTNjWWczZlNtUWJudTRiRXRRc244UmJi?=
 =?utf-8?B?MkdJRHVFY2Q0enlIQmNIS0RST01mV2M1djRJRDZ5VFdxZ3pvMzd2L0xXY3F6?=
 =?utf-8?B?L051akdCbTZtSm9RMTh4Wnd1VkNXbzBWU3VhZWVKVkRWWUF1U3FqUUluV3dV?=
 =?utf-8?B?M1dGbUlBY2VlQ1ptM2NaczBoRm16VWRKY1VaclZZREJRZWpOS25pTFJpaTc1?=
 =?utf-8?B?akNCRlJaMURkcWFvaWRPR2xYazh1c3Z0bUVNbUR3YWY0R3VQbTc2aHA5OWp4?=
 =?utf-8?B?SEpYOUtzd0taTWpiM0lDelAzemlmbnhHYzU3aWJBcS9oSFlHN2Vtekd6c2Iy?=
 =?utf-8?B?a2V0dlh0YjRBVkZQNVdXRjBkelN6TWtiYW9id1o3bEYwM1o5aTNyU2pOczc0?=
 =?utf-8?B?Q2FrZkdrL0hoN0lHeTRZYVVRYVVBajBOQ0EyaktWV01Ub2hwdmI1U01Qditk?=
 =?utf-8?B?ZGQvcngrWWVhZkVRd0xtOXF4OVh6SVMxQWJGRm1RNnpQMFdKNlNqTVh0Z0dI?=
 =?utf-8?B?V1cyb2dSTjEzVnltV3BtMVNIV3liTkFYbVdKRmpOM1pidTg4U0R5bDJZeTdH?=
 =?utf-8?B?YUxxNW5uaWVWUUprSG8xaG53RjRxMksvdjVTZHhlZkFpeXVzQkFxVXlKMmpF?=
 =?utf-8?B?a244T1ZBdHJzeVlzdkNYaExnOUhKS3JLUFBIRElnWWlBQlFlNUkrS0RyM2hI?=
 =?utf-8?Q?fgftJ4Bfmo0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnlJUXo5L0ZtNGptaWE3MmRnVlMzSGJJWGZSMWp5bTRsRkRxVUhtZ2hsWGdM?=
 =?utf-8?B?cmdiQ05YV2tGeFo5RXlkVGJtSjRka2VFM0hKT2VoQzJBa0R1V3pzRWRWREJP?=
 =?utf-8?B?U09pOEgwRTZIdG1vM3p2UmdkR1Q0bXZHUWl6blFCTDFXd2p6OEM4ZHNhTVdI?=
 =?utf-8?B?WDlpNkZBbHlBeHAwd1JZYkkxNlAwcm4vOG9ad2RLeWdidStaZlorQWsxV2tN?=
 =?utf-8?B?UDJSdWJjVUxmOEk4YXdxRXpVVlVFVDlmVEtPQnpoOGxPWGVBU0s4YlJBVkpU?=
 =?utf-8?B?WFlZRnltNEtFbFVlTDJMMm1nM1BIYzY5eEZ0RjA5ZjVqellLYm9QUlFJMmJG?=
 =?utf-8?B?OE0veVJHYzNMckJnbXI3cml6NVBzWDBYeTN5RU5jaWdRTUdiSHVyaU1IUEtE?=
 =?utf-8?B?Q3ZvdjR0ZitvVnJUMUFCdU5QTzc5TSsyUmVKb0FLclFNUVJ2VncvbnJ6cHRS?=
 =?utf-8?B?dENKQ0s4Wm9aV1VzT3g0cUIyM0IvQU84OE0xSlFwUWMrbVZEQnF5ZDR2WThQ?=
 =?utf-8?B?VjlKdkc2OHkzMy9mY3hzL0JqK1BNM3VEakFNYml2QkIwK0xXUTlGQUpYVkRv?=
 =?utf-8?B?SzdVSXpjSllmcDhNaERJbjYrMDdiNDVmQ2x0WkRpM0E4N1NLV2x3TGhPZDBY?=
 =?utf-8?B?Z0pPSkFMWGE0dkd0RnB2K2JrT0JiMGlyRVpOMGlHaEZoRTIydUFJdDU2cHNG?=
 =?utf-8?B?VDFzV3VtNlhQY2kvUmdMdjdZSVFMMWFXeVRNSW1BZ0pMaG0rTDBtKythNGp0?=
 =?utf-8?B?bWVNNnhIK3crU0NZWXkwMDVzOHdNcmZ4aUJoZ2NQcUhiY204OTFIcGNiZFRC?=
 =?utf-8?B?ZEE5cTJRbGdGQ1ptaEVpdXZtcWxEVStHdXExWGVTRFBwdjdHQ1JNT1FCVWp1?=
 =?utf-8?B?YzNSc0FHdTBqVWpZSU15S3BTd3VET3EyOThSdldPOEg4L0hwNkpsVnk0SUxS?=
 =?utf-8?B?VVVucy9HQ2kzL0JvZzZkWGFTQ2hJK2kxVlRIRHZoa0N6am9WNEhWcjBrMFM4?=
 =?utf-8?B?UmtucEpKM3NZYktSU1BDRUlBd0VrTVVjWGNwM09JODhSZXh4TzNZalY2WEQw?=
 =?utf-8?B?SXdCZEVMZExRckF2Rml1bjV4SmZwY2RFbFMrMmVqWkZ4SXg5WExwODJqRVFI?=
 =?utf-8?B?NTA2dDZsemNtdzBUTWpIcVFyQllrWGY3KzNyajRsSWpBTkJobnhjK1llZ0k2?=
 =?utf-8?B?RVI1bWNxbWxQRVpaVk54NTViYmMzTHpxTVJSMWRCUVJ4QUdWZSsrNm1nUWRi?=
 =?utf-8?B?cC9xdWRlTXRpUld1UjFwWmt5dlZ4blN2VXN1ZFBKRXF4cDFhWm5HamJjczkw?=
 =?utf-8?B?aStGVlJWWFg4cEZrcDMzLzFCKzBkTkVVTTlJWVJuTlhVZTY0cm9XbVFleVRZ?=
 =?utf-8?B?clA4NkdnNG42eW16SjJxeDBwNzljakRnVk5JeHBUaVh0WUcyc1VhM0hCNHAz?=
 =?utf-8?B?MTkxZGlhZnZFd0hQaUxvUUFiMVZkUVFpUkxBd25yMmQ0TGFXM0xDTDBTVmlF?=
 =?utf-8?B?YzZBUFozQUFMM1c1RXcrWUU1UlIyckJkaElneXJWZndFQnNOeFlQeUZoRmpn?=
 =?utf-8?B?cnVVVjVVTGI5NFE0Z3ladS9RWmlieHM4REI3YWRNYzgrUTQ1ZzA0aFFBd2d6?=
 =?utf-8?B?ejVjU01xcTdNOG9ZajhtenNtZHVza0tIQkRTZFNTMWx5SmZYbDRySTBSTnd4?=
 =?utf-8?B?R0M0c2pxYWRJVkhjRWZRQ3JzRWZzTzNrZXdVb0RSWWNLKzNxWnBERkcxM3Zm?=
 =?utf-8?B?ak1aa2lGNDhiUE43SmFBV3NTUkxZU3FSam44djZBdGJHY0RrYWVZRnQ3VEIx?=
 =?utf-8?B?R0JXd1RQVEx0ekE5VHpaQ3ZZeW9yZ0d2ZFlGOHJvcGc0alNaMUtjQVFtN2JQ?=
 =?utf-8?B?cVI5Q01TMVJ3RTZaRFBrbFhKRE9Pd2NNQytVRGV3eVJXT2ozR2FMbHdsbllk?=
 =?utf-8?B?MWEwRVBKRThoS1UwMS9QUEhDMmxBcGg3b2s4VEk0RUJHUnRPR3ZsZDNPTHYz?=
 =?utf-8?B?Z3pBNzJiRUNCV3Vkd1JSa09vcWRTWkxiMlhveThwMG1URUVHc3BtT2o1QXVK?=
 =?utf-8?B?dHJzQkxpdmtnRjc2VjFGOE5kbXVLNmVYT25zL3VDdEpyQnhNc0FKMG9yT3dO?=
 =?utf-8?Q?1GZW0e2hCxNrN17s/TZcpp437?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0cb080-a49b-4801-d663-08dde513d563
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 02:45:50.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gWf+aWgBXTfRWpMHWZtZKMI6fizUOTvvLcpkeowv3I+u09fiOqZCCkdqh05HZOeaIRhrlKOs2I3K6SLHqM1uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6680
X-OriginatorOrg: intel.com

On Wed, Aug 27, 2025 at 10:24:03AM +0800, Binbin Wu wrote:
> 
> 
> On 8/26/2025 9:07 AM, Yan Zhao wrote:
> > On Mon, Aug 25, 2025 at 02:02:00PM -0500, Sagi Shahar wrote:
> > > On Mon, Aug 25, 2025 at 3:41 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> > > > On Wed, Aug 20, 2025 at 09:29:07PM -0700, Sagi Shahar wrote:
> > > > > From: Ackerley Tng <ackerleytng@google.com>
> > > > > 
> > > > > TDX protected memory needs to be measured and encrypted before it can be
> > > > > used by the guest. Traverse the VM's memory regions and initialize all
> > > > > the protected ranges by calling KVM_TDX_INIT_MEM_REGION.
> > > > > 
> > > > > Once all the memory is initialized, the VM can be finalized by calling
> > > > > KVM_TDX_FINALIZE_VM.
> > > > > 
> > > > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > > > Co-developed-by: Erdem Aktas <erdemaktas@google.com>
> > > > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > > > Co-developed-by: Sagi Shahar <sagis@google.com>
> > > > > Signed-off-by: Sagi Shahar <sagis@google.com>
> > > > > ---
> > > > >   .../selftests/kvm/include/x86/tdx/tdx_util.h  |  2 +
> > > > >   .../selftests/kvm/lib/x86/tdx/tdx_util.c      | 97 +++++++++++++++++++
> > > > >   2 files changed, 99 insertions(+)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > index a2509959c7ce..2467b6c35557 100644
> > > > > --- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > +++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
> > > > > @@ -71,4 +71,6 @@ void vm_tdx_load_common_boot_parameters(struct kvm_vm *vm);
> > > > >   void vm_tdx_load_vcpu_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
> > > > >   void vm_tdx_set_vcpu_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
> > > > > 
> > > > > +void vm_tdx_finalize(struct kvm_vm *vm);
> > > > > +
> > > > >   #endif // SELFTESTS_TDX_TDX_UTIL_H
> > > > > diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > index d8eab99d9333..4024587ed3c2 100644
> > > > > --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> > > > > @@ -274,3 +274,100 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
> > > > > 
> > > > >        free(init_vm);
> > > > >   }
> > > > > +
> > > > > +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> > > > > +                             uint64_t gpa, uint64_t size)
> > > > > +{
> > > > > +     uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> > > > > +     struct kvm_tdx_init_mem_region mem_region = {
> > > > > +             .source_addr = (uint64_t)source_pages,
> > > > > +             .gpa = gpa,
> > > > > +             .nr_pages = size / PAGE_SIZE,
> > > > > +     };
> > > > > +     struct kvm_vcpu *vcpu;
> > > > > +
> > > > > +     vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> > > > > +
> > > > > +     TEST_ASSERT((mem_region.nr_pages > 0) &&
> > > > > +                 ((mem_region.nr_pages * PAGE_SIZE) == size),
> > > > > +                 "Cannot add partial pages to the guest memory.\n");
> > > > > +     TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> > > > > +                 "Source memory buffer is not page aligned\n");
> > > > > +     vm_tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, metadata, &mem_region);
> > > > > +}
> > > > > +
> > > > > +static void tdx_init_pages(struct kvm_vm *vm, void *hva, uint64_t gpa,
> > > > > +                        uint64_t size)
> > > > > +{
> > > > > +     void *scratch_page = calloc(1, PAGE_SIZE);
> > > > > +     uint64_t nr_pages = size / PAGE_SIZE;
> > > > > +     int i;
> > > > > +
> > > > > +     TEST_ASSERT(scratch_page,
> > > > > +                 "Could not allocate memory for loading memory region");
> > > > > +
> > > > > +     for (i = 0; i < nr_pages; i++) {
> > > > > +             memcpy(scratch_page, hva, PAGE_SIZE);
> > > > > +
> > > > > +             tdx_init_mem_region(vm, scratch_page, gpa, PAGE_SIZE);
> > > > > +
> > > > > +             hva += PAGE_SIZE;
> > > > > +             gpa += PAGE_SIZE;
> > > > > +     }
> > > > > +
> > > > > +     free(scratch_page);
> > > > > +}
> > > > > +
> > > > > +static void load_td_private_memory(struct kvm_vm *vm)
> > > > > +{
> > > > > +     struct userspace_mem_region *region;
> > > > > +     int ctr;
> > > > > +
> > > > > +     hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
> > > > > +             const struct sparsebit *protected_pages = region->protected_phy_pages;
> > > > > +             const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> > > > > +             const uint64_t hva_base = region->region.userspace_addr;
> > > > > +             const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
> > > > > +
> > > > > +             sparsebit_idx_t i;
> > > > > +             sparsebit_idx_t j;
> > > > > +
> > > > > +             if (!sparsebit_any_set(protected_pages))
> > > > > +                     continue;
> > > > > +
> > > > > +             sparsebit_for_each_set_range(protected_pages, i, j) {
> > > > > +                     const uint64_t size_to_load = (j - i + 1) * vm->page_size;
> > > > > +                     const uint64_t offset =
> > > > > +                             (i - lowest_page_in_region) * vm->page_size;
> > > > > +                     const uint64_t hva = hva_base + offset;
> > > > > +                     const uint64_t gpa = gpa_base + offset;
> > > > > +
> > > > > +                     vm_set_memory_attributes(vm, gpa, size_to_load,
> > > > > +                                              KVM_MEMORY_ATTRIBUTE_PRIVATE);
> > > > > +
> > > > > +                     /*
> > > > > +                      * Here, memory is being loaded from hva to gpa. If the memory
> > > > > +                      * mapped to hva is also used to back gpa, then a copy has to be
> > > > > +                      * made just for loading, since KVM_TDX_INIT_MEM_REGION ioctl
> > > > > +                      * cannot encrypt memory in place.
> > > > > +                      *
> > > > > +                      * To determine if memory mapped to hva is also used to back
> > > > > +                      * gpa, use a heuristic:
> > > > > +                      *
> > > > > +                      * If this memslot has guest_memfd, then this memslot should
> > > > > +                      * have memory backed from two sources: hva for shared memory
> > > > > +                      * and gpa will be backed by guest_memfd.
> > > > > +                      */
> > > > > +                     if (region->region.guest_memfd == -1)
> > > > Why to pass !guest_memfd region to tdx_init_mem_region()?
> > > > 
> > > Not sure I understand your comment.
> >  From the implementation of tdx_init_pages(), it also invokes
> > tdx_init_mem_region(), which further invokes ioctl KVM_TDX_INIT_MEM_REGION.
> > 
> > However, if the region is with guest_memfd == -1, the ioctl
> > KVM_TDX_INIT_MEM_REGION should fail as kvm_gmem_populate() won't succeed.
> > 
> > So, I'm wondering why there's a need to for the case of
> > "region->region.guest_memfd == -1".
> > 
> > Or anything I missed?
> I had the same question in v8
> https://lore.kernel.org/lkml/4b7e7099-79da-4178-8f16-6780d8137ae1@linux.intel.com/
I agree with you.
In patch "KVM: selftests: TDX: Test LOG_DIRTY_PAGES flag to a non-GUEST_MEMFD
memslot", virt_map_shared() prevents the non-guest_memfd region from being
searched by the load_td_private_memory().
Otherwise, the tdx_init_mem_region() would fail on this region.

> I guess the code path for non-guest_memfd is due to some old versions of TDX KVM
> code before upstream. Currently, KVM doesn't support private memory from
> non-guest_memfd backed memory.
I guess so. Maybe just drop this case and assert?

TEST_ASSERT(region->region.guest_memfd != -1, "TDX private memory only supports
guest_memfd backend\n");

> > 
> > > > > +                             tdx_init_pages(vm, (void *)hva, gpa, size_to_load);
> > > > > +                     else
> > > > > +                             tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
> > > > > +             }
> > > > > +     }
> > > > > +}
> > > > > +
> > > > > +void vm_tdx_finalize(struct kvm_vm *vm)
> > > > > +{
> > > > > +     load_td_private_memory(vm);
> > > > > +     vm_tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
> > > > > +}
> > > > > --
> > > > > 2.51.0.rc1.193.gad69d77794-goog
> > > > > 
> > > > > 
> 

