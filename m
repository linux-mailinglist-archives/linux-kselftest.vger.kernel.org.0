Return-Path: <linux-kselftest+bounces-44522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E4C258E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768564652B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F1F32C301;
	Fri, 31 Oct 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxHBiT7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064726ED22;
	Fri, 31 Oct 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761920360; cv=fail; b=ARKafsQwGHAkfAvPKoj+vN2a7ixFTKslSsrGE3ZTcWAwFOcrlGrLmTdKVXBab5JoIkkrgaMLWJMBXPqZhg9aySqvL4sj8esVgBZRdtLMl6mnX2ml69fjhyPN/bUSYMrwktPKgDlpuZM88KrsCfLr72+vNwaiv0XBpZL+xLnrNs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761920360; c=relaxed/simple;
	bh=5XfiP2OXUE8lPTsGVkuXpLQKtnYTrgPXkmQNarIdVhU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uQXBrXZ3yNFGEoIacRWsIKfwwmf8P5SV24HNJgM3poBvheZp0njzPeL12OF8t/C+lKsS0XBjsQIjyHkK6jAfcAadQ1gT7vKfvmIZMlifVzjXpTD1HLNq+HMU3XaMa1glAEROacptPgnsmdhuR7DMFe0dQzku5qqpRa/T4YlU1sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxHBiT7W; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761920359; x=1793456359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5XfiP2OXUE8lPTsGVkuXpLQKtnYTrgPXkmQNarIdVhU=;
  b=lxHBiT7WzVqYAQD5QPXBPuQ8Z/3IYFgWiP2LbfzY9CG17zgxU3CKRH9o
   vU4F/+OkfDAZIZhHaxljRtv/KHfaCDRFfm7mB8jLhO5YJ3J5k526mAW8k
   ZkN0VqL93w48R8j0f9S/JgDbxwqYwk0rsG0lB9D7x4JeBU5qz2NvEC0hd
   pfsKcjg/Qd1iQ9vWeEcQ5gmtVihtwp03FkXKakMlIYPRD9df0B8x/UVqV
   0/OA0Ilu+0B8vp+HKAZ7msdCwSmRLaEYs4zjMKwMBYDQkgf2yaTjyMogx
   GagMeHgGMXHnxefiHMlkBcAnjHUI64uE12qFkZRyCqwzPWnQuxxAqlgkB
   w==;
X-CSE-ConnectionGUID: 3J937tUwRUq4mnZuDzLdrA==
X-CSE-MsgGUID: vFjw2XL7RNmgc2FCln8I/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="86706976"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="86706976"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:19:17 -0700
X-CSE-ConnectionGUID: In328tGES6Op6iF2dgNrzA==
X-CSE-MsgGUID: 1oFevUCXQrOh/rxkYQKTAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="185518745"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 07:19:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:19:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 07:19:16 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 07:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip7iAM9VjIaSy8IJDrOZXocjnBNhk+MxnPkpdt5y2Hu3R9I+1XRyN3ZyY8gqm+rKFzkUd0f9YGQilXtJw6HVHMUQkV9Kn3FJ8xEATXo6BFtj//fs9atdq12H/KSqqrddi821jb9+3OgxNcGST2kzxhbL6ke0DWKuIwBxQPMaWT0E3edpfikBSOgqel1SL4Y7i98/rxU5XN5N3MjlUgbezQMsZ9lbcQROmiWY70RpIxq2dtDn0DQX0i1QBHRZp28fVMw+VsAtR/s8U8rAGnqLMMDRlv9Mtjki8MRIuO0NTuEIXZGKZwXjWR71TUiLvylXz50zEbN98rYufOJd3JT+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9opnyOwivUmWmLsxJ8evgEL9147lY8guEWaYJ1MSR+8=;
 b=syTPTMVq2XbYqrzqkkP5qxj/k9JKlHe5LH7sopfP9n6TO6/KT4WPWASeYf9YRXHK1UM553BV3x7Zx35pjwPZsGxpapYxbryzJJ22HdnnB+bS/oqzVfwuq1t2agOUDOHCgh26884V6SsmwPI0wWrtAmELE5IjCKjwDFw6vq7nqQT7kxz5Hv1ZgihD8kY8g5KrW2QAHsob8uIxQYOnAvX1gjWMQVg2AvuG8MWKt2VLfZGRlQt8qRjqIQFweqsiltCqKvloJfuSFjokQmDAEABKy+Ww2swqPaQAm9N7DSubRQ9/kQOTYOsiJDDYwJBgkFJ5l5mp9JGJ7mgz8+UrCWUSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB8136.namprd11.prod.outlook.com
 (2603:10b6:8:159::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:19:14 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 14:19:14 +0000
Date: Fri, 31 Oct 2025 09:21:34 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, Chenyi Qiang
	<chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH v12 21/23] KVM: selftests: Add wrapper for TDX MMIO from
 guest
Message-ID: <6904c5ee707e1_231474100ce@iweiny-mobl.notmuch>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-22-sagis@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251028212052.200523-22-sagis@google.com>
X-ClientProxiedBy: BYAPR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::29) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f2e13b-ad58-45c6-8731-08de188877cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKQTfdfxEUC47wS7LR9P85hkBQWVwOthvjxJyzCC40Mxsi2ld5TaAmBrH2YL?=
 =?us-ascii?Q?TtjE/4J9/7DBoHf1yHSvRL+wEhIBe5MjCLOZLRJbQbbSfFS52raFppB0L+jX?=
 =?us-ascii?Q?MmhrzOTgWJyVDw7AyntSgsVlpt3bmJYaLb7YXVUM+yCx8F+OKvEYsQ+teqjc?=
 =?us-ascii?Q?YChXon2GkkGruPqn4+Z/TcG4RatA67ug2toI51zTSBjI4d8/1LqnSFmLI2AX?=
 =?us-ascii?Q?gTeVyoLkqETl0hwxL1qLNA4LS+UUp6BJbxXDHNIC59mgISN8mfKv9yhUYYS7?=
 =?us-ascii?Q?45TngVWxpOq2i53NuhUFChDdn3FYcJjyBrDeLK6PO2ehqOlSn2UzVU8g0Jz/?=
 =?us-ascii?Q?6E4HvsSZQr2ME9Q3VPtGgXWsf2JUV8AbSZyDIEzawplQqRbbYC3q6NMY3bMj?=
 =?us-ascii?Q?WI7nAuZOE2yLRiZsogWHOLKT8+eKbB1XOKm50dUDjsUMJlDG5nEos3cfLKwC?=
 =?us-ascii?Q?CN0JyDLlaIA6ZFVH90NxCDwSI25G3rZWytLXx3d7jyb59X3X8fQ5+eeYcFe8?=
 =?us-ascii?Q?Ee/tIXyycTRX0RIha36mR1eU3eW+ouUThem9OREF6CW2qoLJAZAa80Yb2bup?=
 =?us-ascii?Q?YaLBhKakMeCDP50WQbVHQnoIu9YeJ+QnPFqtwyqvt8rYoKX0wjMIoVps+OZ3?=
 =?us-ascii?Q?fnuEP0R7tEaQUrqTT8I2jtwTIJneO+B0oAF3t1K5R4PwKsyOCOWZauB4thdG?=
 =?us-ascii?Q?Yy2SO3ajTRdssfkRYzQMvFRSskD6kzH9e9d8lxsaSiwSEr6kEQ1iQLlUMfdp?=
 =?us-ascii?Q?cRbv3tOQgKKrdu4tTMIZDvZJF1SVhFr9YYODYniP9ghLQnKhSIm6AMGLiB/t?=
 =?us-ascii?Q?Mw5XD7BnKWKxBkl81FkErG0E1qki/RmMJ00ir+2q++8fV2SwFmuPRW8GRVQp?=
 =?us-ascii?Q?ga7r9xPBtfa3gGoXG+2zoVssfuDBsCKMqUn9Dd/vclBc0IhCXt4U5ehOS4L5?=
 =?us-ascii?Q?EWWGr2ikU9lEu+DWNRXt/31iTyl55bwVx7GLchhBLkqGFsi3UUW+4AqmAK5D?=
 =?us-ascii?Q?ZXZpgcBNPUnNEe3H67WHGdeHufdAKwSygjEG0gVYfkhVFI+IbhZMcgHWOPvK?=
 =?us-ascii?Q?OA2k4h5/yIEQUpThTthBsEeWomr2mM4fvMYahsJWRw0kcYDhR/s3bdGg30YN?=
 =?us-ascii?Q?eLlmAskBmkTKZPORN4e/7ulBboPD9VvGI7b05KGxsj8d1hjfUeTFO2HUP3C/?=
 =?us-ascii?Q?AuXytZBVoRiuStMdpVK89sdZx2o0KayEJ88Na10swNftTb7lGLNRGoRCAZ3q?=
 =?us-ascii?Q?EB7YfehmrrLvilwo0y+F0XcsiKXIhsEELztSRmCNM6pql+xSJ/QMEUOI7/9g?=
 =?us-ascii?Q?Bp7HWkb3NV3V9SpnhvXHj5rtK9Z56YleEvBRVpz3+Q7iF/x5xSoEAWbbF5nr?=
 =?us-ascii?Q?zpUod32whHJj4vj2xRaXn2GHcT3B5Ov451hwC56/9tuhtFiLGk3LCwdDVQUv?=
 =?us-ascii?Q?GQQShYHXG9OJn17p676D4LHXS4HdbsfJDxuRfBPZEVo0VekVuaOwIlvH9DlE?=
 =?us-ascii?Q?AKXdSRdKtpb3L9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BupssJZdJijmDzW4anIHx/rJZ6ycHtsOmnbfAEYwVcIKhlJ4A6RD1j54qBHY?=
 =?us-ascii?Q?xRp0VagiuAod+Zz3p8hx/eFePxjq6hX7O1KYAqn6pAArHtkYZiqfHO5hYjsV?=
 =?us-ascii?Q?Rymjsl7JWO/hdNahq4oWOR7gJi2dWei4DA+YbtJDZolEI5ZiaqJUXcWmiA36?=
 =?us-ascii?Q?qr/RAXbsHKpbbnRD0FVwRrV9kTukQQdiaECeXAzO9qX78MW5pMJ0eVzHaMKr?=
 =?us-ascii?Q?NsQL8rl32lKLMPvtS2xF2CsOM1RE0mYNqWn83XYHkIAxRd5FXtnQTYqReOpo?=
 =?us-ascii?Q?ve1E7LAKBd2D96oWmuP3/PGHaQqCZriW6tIAN9rUzRnhOh9kBKLtnVD6Rg75?=
 =?us-ascii?Q?eFPO6GZblXbOCw22PZMxLMqiHt3U2oQ+BfP6kyJNRD/QHKJ38Ve0k5ZMgONT?=
 =?us-ascii?Q?PfPy4JucndgkfXguNTa+p/5KGVB2e2st8tw99MYa5Uo3VK/GnT2gPst65J5Z?=
 =?us-ascii?Q?Pbe8Hc284yc1gdvbyBA/pI41mU0sqsMb30KHVzi6jnwmOj0ySG8fmMChhbpO?=
 =?us-ascii?Q?jg1CF8zycMxmY5eMpMSoHI/oj55aDA+VLHw3MglvdJco5OIV+77V/oUxhd7i?=
 =?us-ascii?Q?UM3KCv460Bl2aKZ61ierWUze7oxkIDG3SRnXSeqno69ULJCM0gPCVCIg30sT?=
 =?us-ascii?Q?UtJ18yEMmjDJmyXgskcSeQ1zrF+f4LRvX8FW+q5FarUqho/QlOBkM5qwU5lk?=
 =?us-ascii?Q?INOwsoOJ7rvZkVsMUMgapFeKPHK60p68AiiE9E9IYotBhWbvFGdHy2tsAX+O?=
 =?us-ascii?Q?c8G4v40Bz8jtguDOZuONoKFilK2oqPlYdQR3ya1XQkd4kw15kR3fTifMFhjU?=
 =?us-ascii?Q?4gUCR7yGzOppGARn3YdjoCi1wpfMBYtykmGPn88jGTA+ObvhB0xg8npMWAAy?=
 =?us-ascii?Q?psMkrGM4EN9/w7NTTcdhVng4SFPVthw3ll6ObufN0+Z4lqcEWP3csW9UnoH6?=
 =?us-ascii?Q?UClHT0ts3uAc5lt9ZzEvsN7hR6SJitOlZSuocrxxwhQMPs3kx8+ZO7BCkLPL?=
 =?us-ascii?Q?ssibvFrp6hZEW726KC9zZQsPlxo6kCsXjFL06TufdQIRphJXcuwwge1NwVcd?=
 =?us-ascii?Q?WQkk+i1reAvsLXONySRo5w4hxhBZnTQCORcd8cKZb0aFIKf9PpZaL9i6Fw9A?=
 =?us-ascii?Q?nS2I8KH4D1QH+6IHpKnDA5lGUFidZsybX7c3Mag8i5cQHZIFRNmmbPPUGjPJ?=
 =?us-ascii?Q?74qDngSwpvCCQwWmaw3Wgx15jViQriCg3RrjoIiQgw6M/PNHDvKpYC/x8nzy?=
 =?us-ascii?Q?9HR1exKGzynqGPKEZQ0PoChrq/4tliQPAgYymJcCVdfCyI8fiRQKx5oh9Ze2?=
 =?us-ascii?Q?aA3kY5PV5deoLR3h9xoTb+Ra4u6baQqZKzw8hiDTOy961h4UdVTgX22C0bJw?=
 =?us-ascii?Q?3NRu8ipED9vTMyIgAuXDy+af+wLCY+blqW06AaFB5wXaJzWtZlef7LQ/zzmX?=
 =?us-ascii?Q?8IUtRxY7E7LodQVPxPzj9UX70erb59B8cKn/VS8RpptLxkIpLpsVoldydwtH?=
 =?us-ascii?Q?sUVg5LGVb0s2OS0uVBJMFdmn0fFgxoI7r2enBlwKyc2531PWR3rZZaN69nEg?=
 =?us-ascii?Q?eQJ3o3yzXZjW8DPikVR1zQEirrJvc2t0VPtVZrrg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f2e13b-ad58-45c6-8731-08de188877cb
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:19:14.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pnGaKyyoTOeqarcin5eSUtDC+uAjPk/Pqx5dJpIE444k3dMkS0oEhw3eMk185vRjl05UWdzNAgxMsu3gfcVqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com

Sagi Shahar wrote:
> Add utility function to issue MMIO TDCALL from TDX guests.

Some detail from the spec would be nice here.

[snip]

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> new file mode 100644
> index 000000000000..f9c1acd5b30c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include "tdx/tdcall.h"
> +#include "tdx/tdx.h"
> +
> +#define TDG_VP_VMCALL 0
> +
> +#define TDG_VP_VMCALL_VE_REQUEST_MMIO	48
> +
> +uint64_t tdg_vp_vmcall_ve_request_mmio_write(uint64_t address, uint64_t size,

Size is limited to specific values.  An enum would help here to self
document/limit issues.

enum mmio_write_size {
	MMIO_SIZE_1B,
	MMIO_SIZE_2B,
	MMIO_SIZE_4B,
	MMIO_SIZE_8B
};

Ira

[snip]

