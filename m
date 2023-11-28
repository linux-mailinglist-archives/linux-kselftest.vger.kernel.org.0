Return-Path: <linux-kselftest+bounces-772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319367FC945
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631D31C20E86
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E861481D2;
	Tue, 28 Nov 2023 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUakKBf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738ACDA;
	Tue, 28 Nov 2023 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209775; x=1732745775;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z+0sEwwNUwJYpgpUkdMcXm4u6hmq6+988Mc09iYn7OE=;
  b=cUakKBf+0/4kcCt+IPclxZU4IroyjQcB3s5Dxsm1UQteJZtut8dmr3zH
   KhfgMDEi2PY4vJ22kHi4wpHN7XSsnRnyBIRi158Z92s5L2iqs70bEfzTH
   hzbwR6gGWYOBes8XeTXK7Mc5Hcv6AvhHHzQhDRHLANtvdId8So+zySG1F
   cbsTymx4wc1ow0CledXtLp5TYEEt72Uk2SRCm1m+zbd8cxJFeMocqOAUk
   fR/raK9e5qXxv4jcHVtHG5cP01z1E8jT7wzoSmKONlAn7UJ0tT4adY/2w
   V2u6o14iNUp8l8ptqlAC+UjZ4gvE/q9/iVsnBVmy0XbLjFJCNpV65WHrF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="6248681"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="6248681"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:16:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="1016056414"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="1016056414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 14:16:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 14:16:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 14:16:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKw9iPgn6jNhbixZRETRcchcGOTseyt6MIpsFYbKcGHWJ4EWQyu9cUR2H8jf+MPaISfUVdHo928lNAb1MCsBeAz15duAHdt1/0MNUFyLG29MrHR+kYceASteFEUzHkDEUdHFXW74sosf6iaH+bc7+HsjquXGvfpfcSRQ2qIW77p5XQtZ/yM8Q/Dx75I0+o8gHLC1+xHFl65DW62qzvp+PWMPHh0JVv+ZSGEwVC9HZgw74YAl6aR5MjoZu4tW2doVrQgrVr6bSnEn3RsxyS1x98amEN+E3S2GOyxe9NpM/L10KEADSLXeCWG4Jlo2E0JnmNegfSHJKJCGMtVMgoHtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/G6x0/q5D0DSHVzFCapS4raD22UXp1eIVPQoP3oKCE=;
 b=kOH7oNbA2vRc99uvzPLHMCGtfvDcU06+pif+GSiFxWDtGnkw1df7n63/Rnf0nYjKWVouhAALQGJGvI93p/bAHCBX8wVH1fgA54wD5pz4GCb9Eh/l/ecUn2qdBYqNcL1fhsEb/1B/g8JfJuhavTW3jJJm8UWa8/zEzMTO0FMdcS/D0tI5XFI0GHi3eIL0jJqiOhGATbEglP7GJn8VnFatdqg3pPLSdoVlTWZ1H5Foe1tLmzUWdJEw+BVNw5RYUP1nEhpK4I64zOKoaEPaBemwxpSB6h0+IRw6kHswGHdLFGO4xJwE8OBQ0Rkt2tjXu4hB7D90N/dcaTsn1A0bFbpTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 22:16:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:16:09 +0000
Message-ID: <1d0ccfa2-05f9-4614-badb-91413a064e23@intel.com>
Date: Tue, 28 Nov 2023 14:16:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/26] selftests/resctrl: Open perf fd before start &
 add error handling
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Shaopeng
 Tan" <tan.shaopeng@jp.fujitsu.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
 <20231120111340.7805-17-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231120111340.7805-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:303:86::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 8953e366-16c7-44d6-3993-08dbf05f9f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn+Z7ZogelCOsIh1WBvKCASxIs6Ee6BjWFBX6UQ9JpVC5tKL+WHvtXOUm90Y5CRoLkbEpNjjjmuHDwSEuBmCoHmQk1eTa7Rdn3cnTFDfmDvdSplr82CIPNn1+POmW79HUvZaucjMtSLV/J9HwxsYHqA3tZKE1L3ZsYM3bkCL3xDcAmdPKjcvw/sXt661iaRrN03Ch4731XlZer3GFC531yGF4dcKABdv/BTFQw+IlMk29xMjWtCh4nesPVRpx0VpPV7f3bP4LgHBAs4yRZeLXJrd2XfuJdrGpGp5OMEaI8qTQs17p2EL1SIVZFdlcf57n7MxJ3Jfd3szs2qjQVoX1QEWc+xk0tm19rTCOZ7vnG7S01sEEpI7XFU0L/+q3ukbUgGjRpNXlcCmY6G/L1fo++y/L1eSjrTxydFHT95Yq8/QVUkXxppMPlP+nd9uquNn4AfqBpU+Sgnk+7Zy8gQoA9UXHxyZq8wEo45yOn12RnJTqosyQprz6vkdbQIawF3c6vXtLME1uKJijGvyZAUQwO+ksB3dxQkHOmrEePjgGOhvesprfpFnKkY10S857oWVCtA37OdsuzOjTAITUMKLax2fVEvYAkGbDNXdGtdl2gP+Tz1BRd7F03Vlh5tfkOedvpaG9AJe2nLqfjtl5Na/1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(5660300002)(2906002)(31696002)(86362001)(4744005)(26005)(316002)(6636002)(66946007)(8936002)(66556008)(4326008)(8676002)(2616005)(6512007)(6486002)(66476007)(110136005)(478600001)(6506007)(38100700002)(82960400001)(36756003)(53546011)(44832011)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2l1WUY0cDl0MnJjVC9qdW5TRzlFYng0SXBTemZWVGpseldZZ0FNc1lTM1dN?=
 =?utf-8?B?K1BLVDlaWEFOUFlHOWp6dEcrNGltT1JZeXd4WG9zVURlUy9PTnZjRXdsRmlL?=
 =?utf-8?B?b3FvY21QMWtkdUxxQkpkMEZ4TzVEYVNvdHZzMWd5aTNpZ0p5RHphTWljdDdJ?=
 =?utf-8?B?dUpoUE51d1FtOURFVEZuSTdpeTVLTmlqNk15UVpNeVlNOHJJcndyQU5QaHJC?=
 =?utf-8?B?TEk3YVVUaDMwbDhobXdyRVY1OFNIN0djeUNDV1pPUFY5cklRVFZsaUNDbnQv?=
 =?utf-8?B?NCtyZTJmNnJFQVNkZWM4aElOSEQzM1VWemxhK2hmNFNGaGgweU54My9sZ0hw?=
 =?utf-8?B?VlQzQWRPK2JwV25Cb1VuRkwwaHlUVXNNTGJyN2NpbGFnRUc2bXl1RGE1bEsr?=
 =?utf-8?B?aCtlQm15bHpxTVdIbnZOU2JnUTVHKzN3UnVNU0RzQndIWWtsazNoN0xocVJB?=
 =?utf-8?B?M0gxeGFKbExaRm1xa3lnbS9pRWdCelJRNXlkR3piK0FuZU9HZy9lNmE2eEsr?=
 =?utf-8?B?VlgyYnUxSnFwYUpwajlWbkpnc00rRURTUEFEMm0zbjFSdXVhS3h1R1NhcG5T?=
 =?utf-8?B?VkZKVWpHdzlyMW11N1hUUFpHenZqQjYrUnVkejQzSGhDcnpLS29hcXd5dUF2?=
 =?utf-8?B?a3oveDIzS0FoQU80WHlFczJqTW5QQ3JGS2hFRnJWQ3ZKYnY3UW02UTI2Q2N2?=
 =?utf-8?B?K2lGSk95SXRXc1BQK0ZYQlZWeEJIa2pMMmpFRjFUT1hwVFdYamg5V2NlSloz?=
 =?utf-8?B?dUtRR0llWU8zN01VR1Jpb244b1V2eVB2NWZlSzNaVStFOGNTMW5hZVlHY3hv?=
 =?utf-8?B?a2tNdDFHYzlWaHVWVVpCbGRvb1NneURGNExhQVREYksxRXJNblg2MVJ5ejQz?=
 =?utf-8?B?SzYrd1JZOCsveGFtYXU3THpFOVlyYm80bXBGc0lZMnpJWGJIQzZ0WlZrcFJV?=
 =?utf-8?B?Y1hjc3VTeXdITkMxZ0hsYXcyc21HbVkyZHV0UUU3TVpaOWc5K1M5ZmFsNDMv?=
 =?utf-8?B?UUdyekwwc04zakY2NGlETmFzanFrS3hXZ2N3aURJL1BtWGxlMUtKd1Q1a3cr?=
 =?utf-8?B?VDNLYjAyS0Q3ekF4ZEZyVUFldUpPSjZ1bGRoZ3VTdkFYVnFBcU9ERUpHMTNz?=
 =?utf-8?B?UHNZKzN1c05SUDhDL1FzcnNVRW5rWVlpdHl1Q3FJSzZIQi9xYWwwNWVFNGNk?=
 =?utf-8?B?UkFhS1ZISVFUWm1VOEMxOC8vdWpEV29aQWJBb1ZIaWNTMEdvRWlHMnJaTnlB?=
 =?utf-8?B?MXpxbit2eVlkT2M5enR2cDR3ZklsK2hqY1gxcEZBNTNWNFZPMFdFRFlKemhY?=
 =?utf-8?B?M0JaWmVHSkNla3lMTTIxbk5yZ2pGOWh1ZFJvNCt3Qy9Zayt6OWRGZTNlbGVy?=
 =?utf-8?B?MGJXMU4wSy9ZR2pVVVNaOXZSOTJxM2dDakpEbWNLbEpHL0NxRXNUb1FIWUR4?=
 =?utf-8?B?M2M0a1A5blp5OWZkZmF2OVFRYXo2YVc2MU9IVThhM04wRUl4U0dKd3lBOFdB?=
 =?utf-8?B?UEtJMU0za01IUEI4dGVQcnc3RUtsSzNCTFlwWFRYZ1hBbmh5Z3U5V2V3YTRG?=
 =?utf-8?B?SjkxMk9MdVNHUXlzSGZTZmtGN29ZMFcyNUoxMVFMTldyYmR5eHVwU1dUVjI3?=
 =?utf-8?B?Z0dPTXZ2MGt0UDNiTXFZaDdpNkV4WFZydXJtMjdZOFZDWTRTL2xVcWovTWlh?=
 =?utf-8?B?SkM4V1ZvOS84bXVJclVNRFlaZXZ1UHJBQ3ZJZFNyUG4xQVFSTmNQMnhBY1Bp?=
 =?utf-8?B?U1BBNmtXTTY3NElFUVdWNFVXNG1jcS9la1ArY2tzTVBMR2pscUN0dmRWN0dp?=
 =?utf-8?B?RmVZTFRqM2YvY3dVZmZYU3pUcFB4TXYveWZ6S0pJTEVCUkJCMVlGcDhLa3Ni?=
 =?utf-8?B?czExS3hGRkRMTnRkcWtEQ0hpQVQxbTVtOTUzSEFtZS9pOTlSemQ0amdwZDZI?=
 =?utf-8?B?SmlYUW5FeUpwM25LdENiaWR5U1pEekkvOHlMSDU4L2FGVnRIZ0NSRUlmcmYw?=
 =?utf-8?B?YlV0d0IrenQ2RitYa2R1bnduMk15Szlpbm1oYXBaandHc09tdHNZV25qWGpR?=
 =?utf-8?B?Q2c2elVoYWVDWmZtc3VFdTVldzVsRUkwTkhvY0FidmxIaW9nYkhXMTd6aGxM?=
 =?utf-8?B?ZFNnbFg5dnZIbDRXYzk4WkNBTkYzQzJveUxTaWpWYjRvRyt4dlpkQ0VybUhh?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8953e366-16c7-44d6-3993-08dbf05f9f66
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 22:16:09.0831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvwAPStbiHUKR/XXIqHC9xcBaMkul1mShz38uDidqUspwboBmcCsv74aUSLA14528NuBv5LTToqKNTQWdoy3mFt68bFhknXZXkfmJPi9Cog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com

Hi Ilpo,

On 11/20/2023 3:13 AM, Ilpo Järvinen wrote:
> Perf fd (pe_fd) is opened, reset, and enabled during every test the CAT
> selftest runs. Also, ioctl(pe_fd, ...) calls are not error checked even
> if ioctl() could return an error.
> 
> Open perf fd only once before the tests and only reset and enable the
> counter within the test loop. Add error checking to pe_fd ioctl()
> calls.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

