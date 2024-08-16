Return-Path: <linux-kselftest+bounces-15479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF75953FC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 04:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7381FB22BB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 02:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C512C4D5BD;
	Fri, 16 Aug 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYnOM0nE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735783BBF0;
	Fri, 16 Aug 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723775971; cv=fail; b=KkjHuU42wgrVRXBFBEKKv517RTjdehrtcfcDw426qwSdwp3fh8Cl3GH6pvqRepxKCEW0g+/zszbCDWyApiUU9d5P17ak09pYb4B/HDOT5d+T0T4f9dmS/K2cZXVBuZRfCsGCE43vA4MN14uadIi+wlFlTgYzODtq0hLNFkHTaNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723775971; c=relaxed/simple;
	bh=5rZp6QEdzXSQTKiGgnxo1m1iDWW8BzuO/yYTS70wS4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PQMpYFTJJIoHz7Y79wLun9t+NTuTuQlRF9vl4wbBmSEMyJJ8ZCvPUv8mvt3VjAol230TyzopZhtnEsmg+apn0VRTN28qF1dl3daio6Z2MzYbdyuzwG3y5W0qN+fGegaIJ+++Rq3fjPhfj0y3JkoStp+s5IUq3xMyZDcKYjSVkoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYnOM0nE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723775969; x=1755311969;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5rZp6QEdzXSQTKiGgnxo1m1iDWW8BzuO/yYTS70wS4c=;
  b=VYnOM0nEqOgj/7GAD0DHzSVffQZYkXiSbxlRCQ+SqxxDVTXwpNvQOn2f
   PFvA1/p+JNsIypcWXfuZIIfGYuHUHooKnsbhanRLSuENX9l+68aPGcNcz
   k8oDB6/sIjhE71D+CHnbs/K3bg5/piK2k5WWbacnutd9BnK2hq2145Nkp
   blkGtlydoVn0ROHf7qD03+B+VROmlznC+Mw6hj0r5AJh3ADu9CX28eObm
   t635HnmvmBDrOcZItDQRx49CYSoBSQMKV4SX8JcOMl/WoYfP1m8nabo0S
   Fv6BlSf7qz31Sf6BqWXcFFd4OwpXkbUqMJJ+DESmg4LopYozPwchXFXiC
   w==;
X-CSE-ConnectionGUID: 8vTiwhnKSSKk550IY8mNdA==
X-CSE-MsgGUID: Iu+T9Qw+Q4OOhcZmgots4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="21919741"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="21919741"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 19:39:28 -0700
X-CSE-ConnectionGUID: RGXE1WI6TVaIQr/9FAM03g==
X-CSE-MsgGUID: d+o5BUUiTGaAKU4efDPd/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60106707"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 19:39:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 19:39:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 19:39:27 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 19:39:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmmixrQLZvO7wn+sDi5GxTrWVbgSnHvskvENzvkkswWHPfpHZL4vb0Wc9wLdk5mmwfjz2UDApOTZGSj7TB7LFrdarDFfwPtf0NkQFM2xdJJC9T3cYlVYgFp8o2QAtmBgzJexuk723mLbwFgjxTgE0UbMZHF4x1DOW//+8qPLqQqmxVtF/wJ46pUNvYjVvPBA/5EZ4jedlqx2LER9eCZQTSe5WbX3/FgYY1y2nxGkG5BGqMVW7Xv7VwSDU7ImH28tQBeCtfcyiIQBKNiWfxyodc7eN4fTCkf6Y7KdC8Es8+A8w4J7Uuc/TKAWwdNwZoElCIXItI/dtBepOLIZK0wcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMM1GPe0FLGcXp7lbCVrH6Nh5OnCre+O5wsbZj1vFW0=;
 b=ZqfYDXXnjy0TyIfrmLlExbk95rGAKKBEfSfMcY3YNWae4o7IMTEZCbp4LM1NobI661ps4ZS3BFgDMbIKgDyP0UfKEhw/YIfVRSQHpNrNgayBUfSr2KDj3g0sAFOyw98Yr3qOB6ZBN41rZFYmGIMmfL40q/p7+gMw61su0saXnXrHFcBxDvdrVVGeMfBUiEqwnFXb8yYT5kS2IAiT8fc7JRPQBlyXQfvgNLkJW5dT0mBPL+k7qEMHZohHjgD/R2S0nb/RVfs62kdhdJ0ymRho3PvSwk0ywAUH8DLYPyxn01wbi8IadKwx7sEMCpKNjsDYblicB8HtojsGac2ZgAamtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 02:39:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 02:39:25 +0000
Date: Fri, 16 Aug 2024 10:39:14 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jeff Xu <jeffxu@chromium.org>
CC: <akpm@linux-foundation.org>, <willy@infradead.org>,
	<torvalds@linux-foundation.org>, <Liam.Howlett@oracle.com>,
	<pedro.falcato@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-hardening@vger.kernel.org>, <jeffxu@google.com>,
	<lorenzo.stoakes@oracle.com>, <mpe@ellerman.id.au>, <vbabka@suse.cz>,
	<keescook@chromium.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
Message-ID: <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
References: <20240814071424.2655666-1-jeffxu@chromium.org>
 <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: e29c1532-1430-4d6c-474f-08dcbd9ca441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N25ubFRUc1BrNEt4WTdOTHJtcWJXQ2xPeEYwb2k0ZWE4c1pWWGFoc0t0WGhm?=
 =?utf-8?B?a3QzZHk0YVJrWGtwRFVSTlBVV1R1Wjd5cXI0TS9iQVlOdUxlYVZEaDdmSk9I?=
 =?utf-8?B?eGR4bTFjdldSUm9Rc1NsWVBxNE9hY2ViSE9OODJZaUZvV1ZnV0R6QUFRWVpK?=
 =?utf-8?B?cVJLUkdhQU1Gb0paMFhlbmViMEdzbUc4UWlQVGVBTFYxZDR6QUlGTGYvSkdt?=
 =?utf-8?B?aUdmNEwvOFpaZU13NmMvNGQwb25zdllrZG1UQVdlWUVQM2ZkVUowVWwvOU1i?=
 =?utf-8?B?UUxVUThIWnNaZWZqMGxHVlNBVG5KL29TcUJTRGEzd0JIbUhab2tNekRNNTgx?=
 =?utf-8?B?c3dDcmcyQzZYOHhYNldCSUtJOEpDTHQ2S085SEorcEUraUlQZ2ZpWFNYc2ZS?=
 =?utf-8?B?YWUvTmlNTnRXYThWZklHaHlHOEZJT1VQTTRUWEFxbHlQZmJsb0wza1g5Zksz?=
 =?utf-8?B?WUlqb2ZWbzN1SkVPZ21FczRPL2hoVU9ydGZVeXFEY2FjWnIvdmFoWHMzNlQv?=
 =?utf-8?B?dTdZMkJDTkZIbzV0TXJmR3VtZ2ErYmx6MUwrSzNLaWdNKzlva3RFeHJpMzY5?=
 =?utf-8?B?RklKcmFXSForUHJlc0Fkbmg1eStMeEdJREh0OVhyVTk5cVpwOUdNL0tyTjdS?=
 =?utf-8?B?cG43anQxWW9zSXE2MTlUekU0RUlHaW1YTUZRRHRNQW9KUWt2cFg3NVF4dHNI?=
 =?utf-8?B?VXNPVTlDemc3THVxOS9FMGx0UmhETW4wTlZIdzlHV2lzanZnYVZDSHY3YjdM?=
 =?utf-8?B?bS8vQ1l2K0tuclM3cnJjdUkwWGxBTHRHWVhqQk13VGU1NzhyYVNnZFlqK0VK?=
 =?utf-8?B?U0l2U2hHYnhBNThtQUZOZTZpajN3aDhSRmllNlZqTGpVOTNxemZTd3QvODQy?=
 =?utf-8?B?Tmo3U01mL2hIbUtQQW9qRFlnL2E0ZXZkTENXSEZab0dkRkdUOWJwKytTSlZD?=
 =?utf-8?B?U2NtT2lNcmVzeTZlb3FMQVhGQmxuTlBxRHNjRitXR0RKeS9oR3QvaVFXZ0Va?=
 =?utf-8?B?QjBlYll0b2p3bDd0aWRoQU5CYlNyWmFNN3ZBRmZ5K1lXaVdZR2F5QmNrc2VK?=
 =?utf-8?B?d1J1ZnVOMVpKUVl4dWhNNDVhdXJHc3dXVVRGd0lkcnVXaVM5K0ZaZnB6aSt3?=
 =?utf-8?B?VnladzhWSjlKUzFvOEVwZGpOTTUrNExINGpDd2NyejhYS2swc3dLK0dLa05t?=
 =?utf-8?B?VjJQd1B4eXRkNGFtM1NIWmJ6WCsyRGdGWHA3NHc2aVp4NUZ4bGN5WmE1aVVZ?=
 =?utf-8?B?Tkp2dlNMQ1NQQnZydU9PeGtjTHFtMThld2tRSmlRSEVpZU1ZbHRYQ0tzY2N0?=
 =?utf-8?B?WFRQcUZLQkhDaWlER2o4YlRNQWJTQlN3TmF6S1RJRGhYYTBCMm1UZFlvOXFJ?=
 =?utf-8?B?U1dJczJ4YmJadXczVWNtSlF3UVJOZXJBRlRicytyR1cwdFozUlVvdktmeDRl?=
 =?utf-8?B?dUgvZ2dmS3ZvenYxc0xoRmR4VmJBQzRKc3ZudkN4Z0ZvaWFXWjB6Z0NQVE9Z?=
 =?utf-8?B?MnRZVTh2bUhmWUFMYS9oQWc5MHQvNWt3ZFlzUlY2THNwSHBkWGJJWk1wa1g3?=
 =?utf-8?B?cjlpbVdTK0g3QnMzVGsyYXBBYktoU3RRNUNYL2s2THVxZWx3UkRlMktqU3dS?=
 =?utf-8?B?WUNJSkVoNWFTQnNWMVdkb3J3eUFOVUtqZ0tUVC9ISld6Ukd4SFpDZ1BsL25E?=
 =?utf-8?B?UE9lTnA3QVBhcG5MaHhxSldjVVhnc2VhOWVCUE9qalJUamgwaU8xY1J4dWRp?=
 =?utf-8?Q?Ol9BsSEvrQZwP3d+c8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z01TelhYR0hQN3pkNXdvVEdFam8zMExVeXlLaWVubTVrVkJNUTNJNXdpb0tB?=
 =?utf-8?B?YXRQRStOREw0Vmd4dVpWRmJuWjlINXBOdmtyMSswUGdNa2hKVXo0VWFZeklL?=
 =?utf-8?B?UCtXei8yVWYyTHFKUUJKYU44cDU1VEdIQnU0RXVzWkFnS29UbXZZbGozUk02?=
 =?utf-8?B?bjJqLy9aSnA3Q2d6b1VTTWsyZXZQOXZIV2hMUVBUdVJKMmNoOGU4eTMwbUNQ?=
 =?utf-8?B?MmJHTjRVQU94MDl6WDh2ZU5qS0JjNG5pby9tazZDN2xsZjFzUjQ5cExKWmps?=
 =?utf-8?B?U3Nuc25hNTZBK2ZyNXFPN1lUN0UxeS9OM1QwNGs3bXZvWTZ5bHRPK1czdVJP?=
 =?utf-8?B?ODRNYlNWdG1oYllsTU4ycnBvK0pPQ3g3Ti9ZdForc3ZjdDZ4VnpKRW9FN3dh?=
 =?utf-8?B?VTVua0UxU2Myb2VJL1M1emsxa3U2U0szcERuSUFBL2YyTzNpb1QvRmlWMVk2?=
 =?utf-8?B?Rk1CWHE0QzVwN3FibEhPcnk2N2ZuNjNhVU1XUFdmNDNXUS90M3JDdTZnU2cy?=
 =?utf-8?B?ZGljWnErS2oxNFZ3RHlrRU93QzRJcDg0eE9kL2FtWTB6Ui9Ec2hkNCt5ODZE?=
 =?utf-8?B?a1NUUVpoRWlrczI5cm9xVEprWEU3bmpnd0ROK3NLVlJ5dkhqb1k4ZlJFS2Jp?=
 =?utf-8?B?Y29uUlhZNzlISUMyWXYvUGIyWGhubDkvdnR1MlpkdUtOWWVUQUh1Z3FySlI5?=
 =?utf-8?B?TFJNUVJaQU9DTEgxeUJIaGk4TGVSN2VTRVJ0cDVXSFZsY3V1NGNKZ3BoWG0x?=
 =?utf-8?B?MlRRQUE0VGpMSnNON0hwQ05zRklPejN6dkUyY3dsamRpZElTTEJqODRIWDB1?=
 =?utf-8?B?eGFLZ2FyaFZGQkpZU3hLWGdrQUxkRjhvQWdPMEozS1N0eG1qa0hqeEVCY2hP?=
 =?utf-8?B?MjdQSFBrdlpSaTZYVXZTc1FiTXV0NG1lUUZxOTF5Q0FLQ3lZMFhxeFExU2FN?=
 =?utf-8?B?MG54bjgrSnkzVTRJY2ZGQmsrLzc5OWljNnhZTm4ydGhwL0FJQlBuMmxJMFBG?=
 =?utf-8?B?dllJTGpPNHVxT0pxbVMxeEZqbkt1b0FGQXVYTXluN1JyMGEwRGRMSzhIR3o4?=
 =?utf-8?B?QUNuU1NjL3JlOFdwR1BiM09ERlAwQmplWk14dVBLWVhkOG9neTVKajQ4L0lz?=
 =?utf-8?B?Q2drUDFIcDVlR0h1NHYyRkFGUU01QVUremh6anZUQ25sVzQyanZCdnIwQWR3?=
 =?utf-8?B?Nk53M0ZRcnBlM1FCS3QwK0lCd05XWkx6dGY5VTg4RVVXTVdJUWg4TDAxVVBt?=
 =?utf-8?B?Zjd3dmd3d1ZrVWlLRkU5aVZYa1pVM0xlZDNSWjV0c253Qlk5K21tV2xEcUVy?=
 =?utf-8?B?ZDNYbEowOFBJdDFIR1F3cjUwSlBSb3h0MUNHb2U3Y0tyQyttR3ZxMHByQVF4?=
 =?utf-8?B?bnp2c2l6YkI4Z0FKUnJVWkNiYk9vQmZNR0xMaHp0akw0dERTTVRjZG1lZnNP?=
 =?utf-8?B?TzFaTjlERWFrbWdMVEdtNzVWMDFWakVpWlRzM1VGZUw5Q3VXMTlmRFdqN3d3?=
 =?utf-8?B?M0x2STY0cWdYb0Y1REZ3K0JPOFphNUFkU0JVSUxkSmtIYTZYNlRFZGVseCtX?=
 =?utf-8?B?S2dlTkZSOGQ3V2d3aWJ3TmsvRGNXOGVrSGE2SjN6SlpteVlLR21JdDZuY2d3?=
 =?utf-8?B?cmVId01xWitFUGIxOUVUdEVHd0tRa1RSQm1BYkFrTlVndDByYlpYRURGMW54?=
 =?utf-8?B?YnhmWEViWTRxRW50dEJzOFNsTzBtenJ6UURsdUliandraDZ2cHhnTnZHbGZI?=
 =?utf-8?B?MXFDaXVrbElLTlFHS1JiUkhiNTM1NmtiazUxZDVnbWhhT3c2dGdqVHdVR3Av?=
 =?utf-8?B?OUx3N0dzcktnemxHR1MzZmc5ZWgwam9kdlJHeXgvUForUmlIb3U5V0Z0SVpJ?=
 =?utf-8?B?czFsMm90UUc3ZDk3dTkzdEJGZTBrek1DK2VYVTk5S2FHSnFPcVdsdFdEZWxM?=
 =?utf-8?B?aVR0eHU4eUg1K0E1T3ErdENCUUFFSW1WaGRkV2xtL3M4UzByamM0RS9WRXRJ?=
 =?utf-8?B?aEVJRDlmdzNJMWVUeHA0dUVlUTg3T3NmcmMyUE1GYjBOY2NxWXZYemJoSXpX?=
 =?utf-8?B?WWtNY3ZYSzY2anJHWk1rajdVN2VlNC9XeTNOZUxETGtKa0tuVXNNajdwTkcw?=
 =?utf-8?B?OXBRSVhnOENKWTdTemwrUEdFWmREcWVnZDI0dWZmV1E0M3BlL2xaVGxuT3dr?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c1532-1430-4d6c-474f-08dcbd9ca441
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 02:39:24.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dp/O0qkTv3GV0faOIivoz46YpWYoQriGggI/ZBbxI5rCkFvMUBn4uHXN2z8UK5I2+mB8s4fmgoQZ5Uf/klwRZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
X-OriginatorOrg: intel.com

hi, Jeff,

On Thu, Aug 15, 2024 at 01:19:06PM -0700, Jeff Xu wrote:
> Hi Oliver,
> 
> On Thu, Aug 15, 2024 at 11:16 AM Jeff Xu <jeffxu@chromium.org> wrote:
> >
> > On Wed, Aug 14, 2024 at 12:14 AM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > > refactor the code to check src address range before doing anything on
> > > the destination, i.e. destination won't be unmapped, if src address
> > > failed the boundaries check.
> > >
> > > This also allows us to remove can_modify_mm from mremap.c, since
> > > the src address must be single VMA, can_modify_vma is used.
> > >
> > > It is likely this will improve the performance on mremap, previously
> > > the code does sealing check using can_modify_mm for the src address range,
> > > and the new code removed the loop (used by can_modify_mm).
> > >
> > > In order to verify this patch doesn't regress on mremap, I added tests in
> > > mseal_test, the test patch can be applied before mremap refactor patch or
> > > checkin independently.
> > >
> > > Also this patch doesn't change mseal's existing schematic: if sealing fail,
> > > user can expect the src/dst address isn't updated. So this patch can be
> > > applied regardless if we decided to go with current out-of-loop approach
> > > or in-loop approach currently in discussion.
> > >
> > > Regarding the perf test report by stress-ng [1] title:
> > > 8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression
> > >
> > > The test is using below for testing:
> > > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove 64
> > >
> > > I can't repro this using ChromeOS, the pagemove test shows large value
> > > of stddev and stderr, and can't reasonably refect the performance impact.
> > >
> > > For example: I write a c program [2] to run the above pagemove test 10 times
> > > and calculate the stddev, stderr, for 3 commits:
> > >
> > > 1> before mseal feature is added:
> > > Ops/sec:
> > >   Mean     : 3564.40
> > >   Std Dev  : 2737.35 (76.80% of Mean)
> > >   Std Err  : 865.63 (24.29% of Mean)
> > >
> > > 2> after mseal feature is added:
> > > Ops/sec:
> > >   Mean     : 2703.84
> > >   Std Dev  : 2085.13 (77.12% of Mean)
> > >   Std Err  : 659.38 (24.39% of Mean)
> > >
> > > 3> after current patch (mremap refactor)
> > > Ops/sec:
> > >   Mean     : 3603.67
> > >   Std Dev  : 2422.22 (67.22% of Mean)
> > >   Std Err  : 765.97 (21.26% of Mean)
> > >
> > > The result shows 21%-24% stderr, this means whatever perf improvment/impact
> > > there might be won't be measured correctly by this test.
> > >
> > > This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
> > > And I reboot the machine before each test, and take the first 10 runs with
> > > run_stress_ng 10
> > >
> > > (I will run longer duration to see if test still shows large stdDev,StdErr)
> > >
> > I took more samples (100 run ), the stddev/stderr is smaller, however
> > still not at a range that can reasonably measure the perf improvement
> > here.
> >
> > The tests were taken using the same machine as (10 times run above)
> > and exact the same steps: i.e. change to certain kernel commit, reboot
> > test device, take the first test result.
> >
> > 1> Before mseal feature is added:
> > Statistics:
> > Ops/sec:
> >   Mean     : 1733.26
> >   Std Dev  : 842.13 (48.59% of Mean)
> >   Std Err  : 84.21 (4.86% of Mean)
> >
> > 2> After mseal feature is added
> > Statistics:
> > Ops/sec:
> >   Mean     : 1701.53
> >   Std Dev  : 1017.29 (59.79% of Mean)
> >   Std Err  : 101.73 (5.98% of Mean)
> >
> > 3> After mremap refactor (this patch)
> > Statistics:
> > Ops/sec:
> >   Mean     : 1097.04
> >   Std Dev  : 860.67 (78.45% of Mean)
> >   Std Err  : 86.07 (7.85% of Mean)
> >
> > Summary: even when the stderr is down to 4%-%8 percentage range, the
> > stddev is still too big.
> >
> > Hence, there are other unknown, random variables that impact this test.
> >
> I could not repro the 4% degradation with my test machine
> (Chromebook), this can be entirely due to the specific test and this
> test machine.
> 
> Do you think it is possible to do a few more tests ? This time I like
> to have a larger sample size (100 run)
> 
> stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove 64
> 
> Please run the test for each commit following the exact steps, e.g.
> reboot the machine, run the test, get the first 100 results for
> sample. Please don't select or drop any unstable report because then
> the data will be biased. If possible, please includes stddiv and
> stderr for the data (or raw data if not possible, and I will do
> post-processing)
> 
> for 3 commits:
> -> this patch.

what's the base of it? could I directly apply this patch upon the commit
what you said "after mseal feature" as below?

> -> after mseal feature
> -> before mseal feature

could you exlictly point to two commit-id?

> 
> Thank you for your time and assistance in helping me on understanding
> this issue.

due to resource constraint, please expect that we need several days to finish
this test request.

> 
> Best regards,
> -Jeff
> 
> > -Jeff
> >
> > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel.com/
> > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > >
> > >
> > > Jeff Xu (2):
> > >   mseal:selftest mremap across VMA boundaries.
> > >   mseal: refactor mremap to remove can_modify_mm
> > >
> > >  mm/internal.h                           |  24 ++
> > >  mm/mremap.c                             |  77 +++----
> > >  mm/mseal.c                              |  17 --
> > >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > >
> > > --
> > > 2.46.0.76.ge559c4bf1a-goog
> > >

