Return-Path: <linux-kselftest+bounces-31624-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C35A9BD69
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 06:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5221BA1546
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 04:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D4215767;
	Fri, 25 Apr 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdr1E/lh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0180D1BC2A;
	Fri, 25 Apr 2025 04:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745553925; cv=fail; b=VH3kcujp6Lqa+MSxnpU9C4sSfBPl9nQZI8zFiQ2tzFURChY0P0tB00rjjef5obAUInfIccUJnGQzMKQ/p5cBp1/0+UJlWFdGRl8HL0SMOTbqpUUc70N8jVQ00uTfa6OIt3U78LFT8V74tU1AQ0wRGLZDcby8qwAnCleO/TrrNdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745553925; c=relaxed/simple;
	bh=gB3vqbWrovIcdC2E+9Oz89F6oAO91YCLZYfuCBxcxUw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CaupdGndaJ3D/qOLNkjiLo2cGuIHbbXxR0UwbViyU/vwWQEyUrh1SvywQWrHHRYIZYAxYm3ekgnXBO50rKYC/LqLHDRmglAhrIHhJWYvRTWOus0hEzt9MlBtYdpznSbVx3hfwICs3ZKxupEE4CTY9u7xCYlpkSey+UillQJPGCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdr1E/lh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745553922; x=1777089922;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gB3vqbWrovIcdC2E+9Oz89F6oAO91YCLZYfuCBxcxUw=;
  b=cdr1E/lhrhkdbAbqzJV6yvcvpqitEK/Ambb8NyPf6aQTWvrNG0pi3a0b
   28NwyGKWtE+GKRMASkm+rYzG7FWlTWS1iGcxu4+/cJ272jJjPUH7Ag7hc
   2Ijo7IZ3rilUnHe/e1o9kLbtn6qXlg4j1enCp0yyg0T9lU9NTzu5U2KPD
   Wp+Q5sS/t8AEsEmMhNO/RrtD9PF169ahU+GxzYKin0/U7ulGBxeBLLPCF
   fzZUsOI2JB9HXRexG7AtvteGvvP+bkym+yU9ALe4kLc6xJhyOLteBxhI5
   Vcb6nlEA/QVJmk2fWoqac78h3t+iqi+83SB48gNIMezeX1nxizcuFiJf+
   A==;
X-CSE-ConnectionGUID: 7+auSrBgQkm5V+U9B8DFBQ==
X-CSE-MsgGUID: H3ENqC8HQcSkhMTqcc7ZcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="58572849"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="58572849"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:05:21 -0700
X-CSE-ConnectionGUID: Lu39YxnpTWyhcDhmIHkxKQ==
X-CSE-MsgGUID: 1eVr8877T42NMfAQAlNDmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="137959479"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 21:05:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 21:05:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 21:05:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 21:05:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zjv9VpQ8YfTABkMZ8d6VuLfKwo1H3nJdw+czF95ZpwyCCRDY9YeNyGs4xo7AhUDaSyu5sja/xzVqJvakpc6dteXTa6YTxx16yzpt1DxHvPAfjPpZugrkkCNzD188GA4tHui0v3BL4k0UVxsp16wqlluSBFcUa1yMk6TEEvCztu2UIh//tPZbHQMk2zEW0VTHlVyoyFNQcJbFEDzyojGAw+8/3Cm83mHmnfw4aNJqD4O0nGVe/iz6UfGJTMzHV1eMpnCzsjSi+TXkvUowgmW7hp8b26dpnoWem8tJqlOCrgMHU2dHc4UIpKmkQ7Lpv7wtCGQtUrqG8RGrMjolCcXtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64NUIuj0/mJn1A6FXyzbKthJl4IZ4SikzSZ74Rn7UxQ=;
 b=uvUkxdO96Sod+er6PKy1HiT7ViyvWTVQfU3ii+5Q+mR5jJY2rENnIGhiP+RXzAEzR/IbXbsmJdtQuuvOCHef7j33ipFRlmhKGD7hajHcjlxN4zhNFxb0zO0z8Klep63oM46gO4zBB4qQnh9fdH6e/L0WkAC/uhKvnGN0fp6hZkw33gUp6z4gsD3HvCRs7d9YmQlRIDbqfnaw40AskXtiX1F5xOC3tGAeFX5hWzd0pTfB2doxbyZIQev5vw1z000K0BGSiPWYPPJAQaotIYHE6QD5skHV+Jy84s2RYirmNPg0brTV+lOTpK5bNQJft1UK0r5CAqcvhUvksfGmQxQ0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 04:04:48 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 04:04:48 +0000
Date: Fri, 25 Apr 2025 12:02:46 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: Vishal Annapurve <vannapurve@google.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>, <tabba@google.com>, <quic_eberman@quicinc.com>,
	<roypat@amazon.co.uk>, <jgg@nvidia.com>, <peterx@redhat.com>,
	<david@redhat.com>, <rientjes@google.com>, <fvdl@google.com>,
	<jthoughton@google.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<zhiquan1.li@intel.com>, <fan.du@intel.com>, <jun.miao@intel.com>,
	<isaku.yamahata@intel.com>, <muchun.song@linux.dev>, <erdemaktas@google.com>,
	<qperret@google.com>, <jhubbard@nvidia.com>, <willy@infradead.org>,
	<shuah@kernel.org>, <brauner@kernel.org>, <bfoster@redhat.com>,
	<kent.overstreet@linux.dev>, <pvorel@suse.cz>, <rppt@kernel.org>,
	<richard.weiyang@gmail.com>, <anup@brainfault.org>, <haibo1.xu@intel.com>,
	<ajones@ventanamicro.com>, <vkuznets@redhat.com>,
	<maciej.wieczor-retman@intel.com>, <pgonda@google.com>,
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aAsJZuLjOAYriz8v@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
 <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
 <c4dae65f-b5e6-44fa-b5ab-8614f1d47cb5@intel.com>
 <aAnytM/E6sIdvKNq@yzhao56-desk.sh.intel.com>
 <CAGtprH-Ana5A2hz_D+CQ0NYRVxfpR6e0Sojssym-UtUnYpOPqg@mail.gmail.com>
 <diqz7c39zas0.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <diqz7c39zas0.fsf@ackerleytng-ctop.c.googlers.com>
X-ClientProxiedBy: SG2PR06CA0189.apcprd06.prod.outlook.com (2603:1096:4:1::21)
 To DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: d950e5ce-6b10-43eb-45d1-08dd83ae5206
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXBzZ2ZDTmRncnY5eVF2MUVOakNvUURKbndISU9kbjRYd0pPUHMyOGJkdE8x?=
 =?utf-8?B?UUlOWVpTdmR1ZEp0SVcrSmtUeDNUMXZHbTdOVE1ZQmllY2crZTFDY1NkenZp?=
 =?utf-8?B?M2dYMU9YdDlIbndvY1h3a3BFeVRmQnJtTVRRdHdzTlNqSkp6N1dkMUh4Q3lm?=
 =?utf-8?B?QThqRFlvdERMOGhYTE9NbjNSU2tjUU54WTd2OHRZb0dHcklsek9ZeFc0TzNM?=
 =?utf-8?B?ZU81OWhQMXg1TWFiZlpodFRYazNBSXY2RnMxTkx6RmRTcm1ZSzRlZjFWd0E0?=
 =?utf-8?B?SFgxQmNDOGdiUDVJSzhIZ2hnKzR1WFVDUmpQck9taU81RHIva243b1Nhbzhy?=
 =?utf-8?B?V1VyeDN6N0lMbzRVK0k2WGNLakhjblFKbURZcjZkZC9iQi9RYkdpQWVSNkpj?=
 =?utf-8?B?Zzk0UHR3RE9Ja1dSd2pCeTUvM3d6VnltWjBpbEt3MnZLR0FPQ210bGUzRHlT?=
 =?utf-8?B?OGllOXcwSFBWTnRPUFFKTHZqQWpzc1dINFlwQW5TaUZkTlUwQnJGakt2MmNt?=
 =?utf-8?B?UGlYVmp4QWNqSk96Z0RsamRWeC8wcmxuSVhrSUFiWm9seDR6aldxY2NBbXpF?=
 =?utf-8?B?bk5wZWRldG9ZUVNnbkJkY0hXYVdJVmJ0c3kwM1JZN1A3YUVPY2FJRHlCTWJ6?=
 =?utf-8?B?dGtHbEpEODdOcUhWTjdSMGVMd2N2cHFPby9ZS1k2QTNlTkp1V0hTNGltR2Nt?=
 =?utf-8?B?UXo4aWh4ZC91cktoM0RaUkNQdUovOGRJeW9EWEJ3NWNtMDExV0FkOCtqL25D?=
 =?utf-8?B?Q1BNeldid0d0Z3NPVjZPWTBiYUJKU3VmSHVxSysyVHU5TGl6S0hCSGdzWkZx?=
 =?utf-8?B?dEVCYWE1YVJqUiszdkJrZGQyYllrVExad3lYRFY1bEtSZm53WHg1aDlFeUVa?=
 =?utf-8?B?WUFNT0hNeHMvWnhKangzNENYRUcwLzZIU1g4bjdWcmp6U2RvMnRGV3VCL2ZI?=
 =?utf-8?B?NW8rT1JSWVZ2MTh4V29LSSt6WmFVV3VMck03aXVESi9BWVNhTWxhR2p0dFhO?=
 =?utf-8?B?MUlQOFh4cDVNTHh3R1ovMUNodkphY3JiVlMrMTJCQ3IrNkdReWFubENuRFRW?=
 =?utf-8?B?Vjg4U0ExS1pUWHNPR1ZhWEs0cS9yTkdDYnAyNTc1OGRyc29jWlRUVlM4Y1Zo?=
 =?utf-8?B?M0hUMjRBeGM1emxXL3lkNS9DenhRRnpqWWdGVEFzOHp3ZythR04xb1dSQW9C?=
 =?utf-8?B?ZTY5MmR0TW5mUFlyaGJwSW9EMWl1M0lhcXdoNzkzdWZpdnlyaS9PL3MySFFP?=
 =?utf-8?B?M3RWc3NCSWRyNnJaSU1LbWJKV1JmSHVtNDk2VUdtaFFNRFVCNGVldlpHbS9B?=
 =?utf-8?B?Y1Nzc2djYWxZamxVWUNzcVdJbXNTa0t5dms0USsyNUQ2VmFpTDl1ZHRzTHA1?=
 =?utf-8?B?S2tQLytVSVAyT1RXaENRQ3c2cGwreE45ckhmVGo0LzlpbjMxUzlrSmVhSCtE?=
 =?utf-8?B?cVpZUVJWenpTbEtXMk1oWEFmMDNNMmt1djRObllNS1JuaHBxNFlxUG9na3Ro?=
 =?utf-8?B?UGY5K0JHd1pRMHJpa21ucTdpNTl0YlJPbllWVUZlNjhXbldSTnpDcXZ0TmN5?=
 =?utf-8?B?Sk9EMVRqT0hsaGZSSDJFNDZIcG8vSFZZTXJmbFIzZzBjTnRZcFg2aEtxeWdI?=
 =?utf-8?B?WlZjeU0wWVhCNmVnZEp1UWZRNmlMRUtBUVR5TnAxQ1hPSmNqaU15MHBjRUE3?=
 =?utf-8?B?Nml0SUVjdGFja0FsSzExb1VGNWswUnJuci9DQjdQeUx0bjNZODhmYnJURE4z?=
 =?utf-8?B?djJFaCs3V2lCbG5EbHR6RHhqckVkSzUxeVUvRExqby90c05RZXp6NW15N3c1?=
 =?utf-8?Q?HDR6aczf9cBcLoQpPRUl5eb3+Jc/LPGMpf/tI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnVMSjNNWHE0OWpXTVl6RFBkUWYwdEhOcDVXSzFVdC81Wk1vLytWaGlGNmR5?=
 =?utf-8?B?TTZES2hmOExLbUFINVJ5bG1ZYk5Ja25EL3RmbFlkOXRnUGZza21jSXpBRCtZ?=
 =?utf-8?B?UVVrMzBKRkdwSXE3VVoyaGhWMG9NaWFRMC9aSDBHcDl6VHpBMXVGdTJ1eVVZ?=
 =?utf-8?B?STJUU3l0TGNvMTZabkw0NjVFTE4vc1I3RHNQRGp3bzhONWN6ZUpBOXBIczVr?=
 =?utf-8?B?bVdGOXczTnZJQ3J6TUFDclEwZEtXSUhyMnBQR2dYV0tKckFudEJ4NVBlbVFW?=
 =?utf-8?B?SWdObWE0VThTVGlIRkRXejY4UVJ1RC85YUw0RGpiY2o4Nk5yS0xRcFdBRU5z?=
 =?utf-8?B?d0hnamdQK3ZiYlhxUjZqNUZIL1JWMUNVeUVMaHZrRHJVWjFNek0rLzRUY1ZF?=
 =?utf-8?B?b1lqNkEwcmpydDIzblZndGZRWmhMR0VaYUV4MWZ4aU1lcFNGZTVLS1FUbmJX?=
 =?utf-8?B?TlhBU2JydHQxU0lLeXJORkVndExQcE1Ldm5BSzloZHZSejlTMVlLZlBCdDV0?=
 =?utf-8?B?LytVTVJOdmlCblZTZ29nSmFodE9kdGczUUJvWjQ2ZUFlTzg0Z0F0c2RtV1p2?=
 =?utf-8?B?TnRSaVFqbGU1RE4zUmhpa1l4UmtwVGp4WDJpUDBTdnNsZ3hxS3hGcWJDSFlD?=
 =?utf-8?B?aW9OSnJxVFIrYUdJZTg3SVBzK3V0dUJDNlgrakhyVzVzTngwZXJkQXR3YmJn?=
 =?utf-8?B?Q2Eyd3I1VHFvRnpiRVlhUDg5eHl2VHBWQWtkQUswbHl0NVdndEdyLzNlc2JF?=
 =?utf-8?B?N0txa3VBSEVyVElib3duMWltT0dONU5mdHRnYzE2bzNjZkFUdk9OVnl4L3F4?=
 =?utf-8?B?NE8yaHZhM29mZ2xGTWp4Zk5jaFdGeUFLNDNZMC9EUlB5dld5UjMyTEFlMVFa?=
 =?utf-8?B?NzEzUlUwOVR6QzFNd1lFOEVPMWVsR2RkNlZxZTN4dk9wR2REeTZWemsvd29I?=
 =?utf-8?B?Ly9RUFY4ZW5lK3BrQzh0Z2RFYXRXYXFWR2V5Mm1ySExNODVYaXJINDVKenky?=
 =?utf-8?B?MnpHbzF6NERteWFlZ2k5YktFUkptb0JWcE9aZ3RMQy9SNlNQaGVBMGd5QWVE?=
 =?utf-8?B?R1Jwb2NVR3RzNi9Pc3ZRZUJrQk5OT2s3N0xTZy9naG4wMld0QXF2MGlFVDhZ?=
 =?utf-8?B?cWVNZGtzOGxvVS9BR0E3SXhnNXlNaWxPd2tiOEtzcXhFc2VWZ2VCb2ZEenBN?=
 =?utf-8?B?dGRFK2gxSXpzMVp6SENWa1c4YjBFOVE4QkxQbEdlTkhVVGJYeVdNUlI5clNk?=
 =?utf-8?B?S041VDVCMWdCNlRndFMrbWhMM1E5NUQyWUd5c1l4SjdJbVBpM0Y5RU5EUGlw?=
 =?utf-8?B?MHJzZzd3bmJDcWE5dnI5VkNVZXAvM3ZPdTNXSUkzNDNwcUkxSXpPV1JMNmw0?=
 =?utf-8?B?RnVwUU9IU2t5eTN5Q3ZwbzN6S0JPemZqZVlyV2NPZUpiYm1ieVZWUXhLTi9E?=
 =?utf-8?B?aUtrUmtWUnNabjN5MWhRdVI4VmhDeFB6NjlJL0xwdWY0WmFBQ1NTY0kyU0F3?=
 =?utf-8?B?Y0tBM1RnMXV5WFNsL1JZMyttSEJhUHNzQ2ZlQWRGRDBwc0hpTTZZYnhGNklr?=
 =?utf-8?B?L1BvVWZ3VmhCR1V6MFVnbGhwMHZranh2Z0kybDV6Vko1c3ppM2hiM3AxalU4?=
 =?utf-8?B?YVU1cWhFNUxVODFZMnFIQzJFVlhPaEQ4TzdRWWtrUnhkQjNyOTJFbnZrVTcw?=
 =?utf-8?B?a2NqdnlZL3RMQ2lJMkhrSnh2aDByYjVjR0dwb0hkQ0hHbGl1REhMejhFdzMx?=
 =?utf-8?B?SUM2L29iY2VjWGZRaVc5SzhpSG4vL2FZK3g2MzJPOUQyTUV3UjRyTEllVkRi?=
 =?utf-8?B?YW4vV255RHBtb3NJV0hsUGVrSmRjcVhySmxycHNBWlpoQnNyMThwNU9zb1FC?=
 =?utf-8?B?MWkvZURuaThCNlphWEtUMUdKQlFudFhkazVYWCtJSi9MN0FpWXB0Wm15N2px?=
 =?utf-8?B?anhlb3RmMFRTc28rd0QvNW90RzY5L01nVEJ2dGppcnVWYno2Z2c1eHcyREVl?=
 =?utf-8?B?MnEwVlBlUTV5N0V6Sm1uVVhucitFZk56K3lpMm1KdFdFU3ZFUkhQVkNVNmgz?=
 =?utf-8?B?Wm9uWG1ubm5XaVA0N0pnV0NWSFhIRVpRSE1xZjg5TXBtRGZzWTdsMGpGKzho?=
 =?utf-8?Q?1LkqQdsdiC2vE6GnRg3jPMLri?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d950e5ce-6b10-43eb-45d1-08dd83ae5206
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 04:04:48.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW6Zhwz3wHpgveI5yPAWXsM2014jTgxVM6t6Wi0o7UUs6QaQ1+R3OcvDK5i9w4SplzTNC+ErsmUOqGvuiQ9f8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

On Thu, Apr 24, 2025 at 11:15:11AM -0700, Ackerley Tng wrote:
> Vishal Annapurve <vannapurve@google.com> writes:
> 
> > On Thu, Apr 24, 2025 at 1:15 AM Yan Zhao <yan.y.zhao@intel.com> wrote:
> >>
> >> On Thu, Apr 24, 2025 at 01:55:51PM +0800, Chenyi Qiang wrote:
> >> >
> >> >
> >> > On 4/24/2025 12:25 PM, Yan Zhao wrote:
> >> > > On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> >> > >> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> >> > >>> Yan Zhao <yan.y.zhao@intel.com> writes:
> >> > >>>
> >> > >>>> On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> >> > >>>>> +/*
> >> > >>>>> + * Allocates and then caches a folio in the filemap. Returns a folio with
> >> > >>>>> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> >> > >>>>> + */
> >> > >>>>> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> >> > >>>>> +                                                           pgoff_t index)
> >> > >>>>> +{
> >> > >>>>> +       struct kvm_gmem_hugetlb *hgmem;
> >> > >>>>> +       pgoff_t aligned_index;
> >> > >>>>> +       struct folio *folio;
> >> > >>>>> +       int nr_pages;
> >> > >>>>> +       int ret;
> >> > >>>>> +
> >> > >>>>> +       hgmem = kvm_gmem_hgmem(inode);
> >> > >>>>> +       folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> >> > >>>>> +       if (IS_ERR(folio))
> >> > >>>>> +               return folio;
> >> > >>>>> +
> >> > >>>>> +       nr_pages = 1UL << huge_page_order(hgmem->h);
> >> > >>>>> +       aligned_index = round_down(index, nr_pages);
> >> > >>>> Maybe a gap here.
> >> > >>>>
> >> > >>>> When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> >> > >>>> 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> >> > >>>> corresponding GFN is not 2M/1G aligned.
> >> > >>>
> >> > >>> Thanks for looking into this.
> >> > >>>
> >> > >>> In 1G page support for guest_memfd, the offset and size are always
> >> > >>> hugepage aligned to the hugepage size requested at guest_memfd creation
> >> > >>> time, and it is true that when binding to a memslot, slot->base_gfn and
> >> > >>> slot->npages may not be hugepage aligned.
> >> > >>>
> >> > >>>>
> >> > >>>> However, TDX requires that private huge pages be 2M aligned in GFN.
> >> > >>>>
> >> > >>>
> >> > >>> IIUC other factors also contribute to determining the mapping level in
> >> > >>> the guest page tables, like lpage_info and .private_max_mapping_level()
> >> > >>> in kvm_x86_ops.
> >> > >>>
> >> > >>> If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> >> > >>> will track that and not allow faulting into guest page tables at higher
> >> > >>> granularity.
> >> > >>
> >> > >> lpage_info only checks the alignments of slot->base_gfn and
> >> > >> slot->base_gfn + npages. e.g.,
> >> > >>
> >> > >> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> >> > >> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
> >> > >> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
> >> > >> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
> >> > >> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);
> >> >
> >> > Should it be?
> >> > lpage_info[2M][0].disallow_lpage = 1, which is for GFN [8K, 2M);
> >> > lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M, 4M);
> >> > lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M, 6M);
> >> > lpage_info[2M][3].disallow_lpage = 0, which is for GFN [6M, 8M);
> >> > lpage_info[2M][4].disallow_lpage = 1, which is for GFN [8M, 8M+8K);
> >> Right. Good catch. Thanks!
> >>
> >> Let me update the example as below:
> >> slot->base_gfn is 2 (for GPA 8KB), npages 2000 (for a 8MB range)
> >>
> >> lpage_info[2M][0].disallow_lpage = 1, which is for GPA [8KB, 2MB);
> >> lpage_info[2M][1].disallow_lpage = 0, which is for GPA [2MB, 4MB);
> >> lpage_info[2M][2].disallow_lpage = 0, which is for GPA [4MB, 6MB);
> >> lpage_info[2M][3].disallow_lpage = 0, which is for GPA [6MB, 8MB);
> >> lpage_info[2M][4].disallow_lpage = 1, which is for GPA [8MB, 8MB+8KB);
> >>
> >> lpage_info indicates that a 2MB mapping is alllowed to cover GPA 4MB and GPA
> >> 4MB+16KB. However, their aligned_index values lead guest_memfd to allocate two
> >> 2MB folios, whose physical addresses may not be contiguous.
> >>
> >> Additionally, if the guest accesses two GPAs, e.g., GPA 2MB+8KB and GPA 4MB,
> >> KVM could create two 2MB mappings to cover GPA ranges [2MB, 4MB), [4MB, 6MB).
> >> However, guest_memfd just allocates the same 2MB folio for both faults.
> >>
> >>
> >> >
> >> > >>
> >> > >>   ---------------------------------------------------------
> >> > >>   |          |  |          |  |          |  |          |  |
> >> > >>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> >> > >>
> >> > >> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
> >> > >> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
> >> > >> So, guest_memfd allocates the same huge folio of 2M order for them.
> >> > > Sorry, sent too fast this morning. The example is not right. The correct
> >> > > one is:
> >> > >
> >> > > For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
> >> > > KVM will create a 2M mapping for them.
> >> > >
> >> > > However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
> >> > > same 2M folio and physical addresses may not be contiguous.
> >
> > Then during binding, guest memfd offset misalignment with hugepage
> > should be same as gfn misalignment. i.e.
> >
> > (offset & ~huge_page_mask(h)) == ((slot->base_gfn << PAGE_SHIFT) &
> > ~huge_page_mask(h));
> >
> > For non guest_memfd backed scenarios, KVM allows slot gfn ranges that
> > are not hugepage aligned, so guest_memfd should also be able to
> > support non-hugepage aligned memslots.
> >
> 
> I drew up a picture [1] which hopefully clarifies this.
> 
> Thanks for pointing this out, I understand better now and we will add an
> extra constraint during memslot binding of guest_memfd to check that gfn
> offsets within a hugepage must be guest_memfd offsets.
I'm a bit confused.

As "index = gfn - slot->base_gfn + slot->gmem.pgoff", do you mean you are going
to force "slot->base_gfn == slot->gmem.pgoff" ?

For some memory region, e.g., "pc.ram", it's divided into 2 parts:
- one with offset 0, size 0x80000000(2G),
  positioned at GPA 0, which is below GPA 4G;
- one with offset 0x80000000(2G), size 0x80000000(2G),
  positioned at GPA 0x100000000(4G), which is above GPA 4G.

For the second part, its slot->base_gfn is 0x100000000, while slot->gmem.pgoff
is 0x80000000.

> Adding checks at binding time will allow hugepage-unaligned offsets (to
> be at parity with non-guest_memfd backing memory) but still fix this
> issue.
> 
> lpage_info will make sure that ranges near the bounds will be
> fragmented, but the hugepages in the middle will still be mappable as
> hugepages.
> 
> [1] https://lpc.events/event/18/contributions/1764/attachments/1409/3706/binding-must-have-same-alignment.svg



