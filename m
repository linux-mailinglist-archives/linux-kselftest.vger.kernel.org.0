Return-Path: <linux-kselftest+bounces-8843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BFA8B19F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027F31F21929
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E5381BD;
	Thu, 25 Apr 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTFZmDVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9894A374C4;
	Thu, 25 Apr 2024 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019910; cv=fail; b=kXPhyivlPtyLaIT3Afx5QLrkWB32i+vHcnZXIulmA/o1p64L51HDW6NVZoMPKLoEBrb3t10tC22SurSpWLqL8RazvMs8bTqBxBPvZ8H+JTeXtbCftCs/VUyiFtMfpN8PUJHbauUsO+tJ9aH9bNmGf75zLe7+bz7k3tT6OTGmjK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019910; c=relaxed/simple;
	bh=RsQgUSmd9+Q6ENRGd90XYEGfqtfyuxJQ+4CloknBLv8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=smfuj6q6+KtojRM4bwsiTdhvGR0jP6Oc4ZmiYagIJPoxN1l9jhRrZIXYfUVzy733r7VPZA5yB2oELbm6JV2PSe7IGaxqbHm9hyojappQAudNRRJDCE3RJbGvjS5gp/Q0ZplM1gF7ZF9vFqOeeNpPJtLi5qw50/JPKcpjjRNGAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTFZmDVa; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714019909; x=1745555909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RsQgUSmd9+Q6ENRGd90XYEGfqtfyuxJQ+4CloknBLv8=;
  b=ZTFZmDVatn6mscR9DutQnOUyakjBq5BInWZT3Puv/BEnKXR3QnHPQIxX
   M8lQThBEZXxJX5Br0yddgswoADCd91D+gI5sGFRv123G1sf4phiOUFr/D
   pn5zQItgHaHlecWfhxUFMcrYv9/ZtZTujAPHWaiIbmJg+4Ao2GESEMrXY
   eteJLSigAq8bn/0W0Zxx2gCm96vPulusFnYcvQt2gDsEBgLwDItHmm2XB
   18UHtMnlVqdYldi0545w6J7SqJAb0B/ZjITqnyz5DEJV1KIKHiQSiiWR4
   qCYdLlx64RQXq/qUreWOs0ScYp4howLLDALarkOgrhie3JJ6O/Y2yGmdW
   A==;
X-CSE-ConnectionGUID: JiouvDiUSIO7wGYrjkdCew==
X-CSE-MsgGUID: 7rLkpXXnSdqhl6HiTxa+SA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9795538"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9795538"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:38:28 -0700
X-CSE-ConnectionGUID: kbohtdXhQEuiVXR9tu1+fg==
X-CSE-MsgGUID: AB1Met5AQkGbnK54s8V/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="56113729"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:38:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:38:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:38:27 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:38:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA+LtHXx0dhUtaUuAkHAEYvd1lzvnoitE6VNOVlkiCve00eihg65j1uKHHfSBK2BNBl3G1eBjZ4wIaLO0pDhzET+GGcAzxvtpLryXHPOnJnHMkjfDoQPDSEjzlew4jGZt8YVQKpWO4hkcSCEkg0mQyr8NSkU74DCRnEtnKol5yt8sXPEF5XaYCe9oZkDCEWlicvtPtSzSer4BkSChDS9Xb7qYSati4f2gI1XsN5OBJzfvh7uMUin7AK8M7RaBwRr3UZ++dvI8eps4d1PNa7ABbHP+1Jhfo4Rr3PsQ6lluZQLNuVFHgm8Ta/gTxI6TpjcXGpvi079+C07HsMvl3pIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIDUf4iT9Zdq/0P20CPQ6ny5aL+rSJHYOQPZB5Pe4Oo=;
 b=PuWTL5MZDYG6VOLKCkG3WPtcMB6ZTV1OQSRkvbP1JXfFpoQ6lWB0oWHnhH75mMAio1q8TY5VUIvqGam4TGryDElCg3A7m3znili32crWpreSCa1ncU4C+G8ErMwiniWOyLUFPBXW+usg7Ysb+6PdId9Z/g/Xwp/UK0u0/LyTlnrZ6MzQPzk9mVVHhNDNKREDlsE1opOjODLms9FfcPU3XDvYuzEZIAD8Fsv9RKLWmfhOYRnkspe3PFOWzmM7r/AGNMWf6VRBEIMDztrkwW5U7uijKE6aPJVj1pNIujY49qvMISJEDfZknQHQX44a3hjZGW70pF3eIKBwJ3ioyLAfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 25 Apr
 2024 04:38:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:38:24 +0000
Message-ID: <a443cb17-3d50-4cb8-8208-e74fdd923897@intel.com>
Date: Wed, 24 Apr 2024 21:38:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/16] selftests/resctrl: Simplify mem bandwidth file
 code for MBA & MBM tests
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <20240408163247.3224-10-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408163247.3224-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 654206bc-72f1-436c-b9f8-08dc64e18b44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWR2VnZKWFNjbEhPNWZyeUlyRjlZdi8wTnZhbm5IWU9iblFrWjd6QlhKNkU0?=
 =?utf-8?B?QjN1c1RuN3ovTGpHYkEwN25pdjE5dEZPMG5rYjF4K0ZDTFZwU2NRbVN6UThL?=
 =?utf-8?B?WGR3SGE2Q3Y3Njh5SjRpcEdLSW54ZDZVVGlReC9vbFRmUk12ajNLQ01oNGpI?=
 =?utf-8?B?ejZVaW5KQ1RmNXNnY3dFbkxCaWsvU0I0eVhUTU45UGxJNTJ6anVRb2Z0cGx3?=
 =?utf-8?B?S2UvN3BXQlNFeGduNHltZWlhUnBkRjVackpxNmM2TUdXdDJERWIwSVNxTk9Q?=
 =?utf-8?B?WDBDTjQvREl6eERnSEtPS1hud2JEdDM0dHRWZU94ZVBxMWhvOHhxdG9aUnZT?=
 =?utf-8?B?VTBBaEhpMzluVEhSbnB4K2VYQ1RqSVNnSWo5Q3VPTyttM2UxMWt4SnVLcUdC?=
 =?utf-8?B?MUY1VTNyVWg1MTQ3R2ViVXdjNi91YWhvK1M0N0lJWU0wcmh5eGlvbHV3WHJi?=
 =?utf-8?B?dkVvT2dwT0xxZ1JpVEw4Z3JidXNnYmt5bW4vNjVEcWlrMUpWTXlBMDh1V3d5?=
 =?utf-8?B?TTBIUzZlb29NbXFOajZjaXVmOU43Y0htTFNzc0FxTThZc1ZRaEpZeWwvdFE2?=
 =?utf-8?B?TDZZYThCK2tpUnNTN25JNUF5SmNkaUtiMk1pYW1lZnl2WkRjWFdQRjU3dHlP?=
 =?utf-8?B?NDhIWkwxaS96ZmN0MWpmVHZoMllVWGdQMnYzU242QlN5MndCSFdUNFlYalV3?=
 =?utf-8?B?M1F4Yy9ZYU02QnhaY29iSk8rUm8wSndDcm12ZUdHTWpDZ3QvTksraGpUREpn?=
 =?utf-8?B?WXFqOUsveThlUUxPeHJza2hBRk0wcC94S2xkZ1ZvOSs4eW45YmZsb1FtTFJP?=
 =?utf-8?B?ZnBkNEFIWi9WMndRenVSWWtKamRzb25TdmJrNGFMTkx4cHFyZkRNZVlKTkRI?=
 =?utf-8?B?T3BFOVI3SkwweTduOEJHTmVXSytSMmlJZzcvekFVdnhIZnY2RXhsYVFiOFFj?=
 =?utf-8?B?L0Z5MkQwdndsQkdkdnhWVUY0d1R5N2x2SXFEQ0JwR216WVY0dThydTN4WjBn?=
 =?utf-8?B?d0xUclVucGo0bVBwNVF1akRFTGs0Zi80TEQzYVozWDFzTUhvb2ZPemY4Lzht?=
 =?utf-8?B?alo3UHlBNVI3YklIaUtNZXczaHExaU5CN1p2Mnk5VmVnTjltY0lCczlUMVhQ?=
 =?utf-8?B?dktyS1F0V1VoYW03S3J3b2FQY25sVnU2UXVSMStBam56RVdsM0hzQ20wSEJq?=
 =?utf-8?B?WTM5aFYwZCtxTFF1QzcxOGRSZlFlbDRJQVp2U2ZvSGRrK0t2Q3NYZElmNWdE?=
 =?utf-8?B?c0VKRkNibWg1OXRCYW51NmIzNDJQYkpsUmFLcWc2eDhWRjJYNFYrN1NycTFR?=
 =?utf-8?B?UEp0bHJhVkdpUXpBcEhlaFM0aVBXeXhCYXMyNzRSS0lBeVFPQWpzUlowT2lO?=
 =?utf-8?B?TUU0M0laQmNzRG1YRTR5elhOOXB3VWtMT0srWTVSRGpjSHdrVGZQVjVVVDM2?=
 =?utf-8?B?MHZobzJubXJBcWtsS0U0THZFY3hOR3RvdUthMmFjWm9zVlBZZEF6akhZeENN?=
 =?utf-8?B?SjdvMmV5ckx3ZGZRVzJnVHgzVTAxSDNUL1lvODVuN1ZDVm5LaDExb2Z3Ymlj?=
 =?utf-8?B?TjRlby9VcTBKRmQ4ZXZGV3BBT0oyUE1uTDBqTFc4cjhhdENDbkl2ZGZDb0Fj?=
 =?utf-8?B?eWVnZG9lb2N3UFVvVWZtZTRXTUF5VlNVQm14dmtLWm5pc0ZhbURPc2gzWGZC?=
 =?utf-8?B?MVQwcDB0bGRTdHM0aWZyR3JCVUsyQVJYRnZwOXlueldCVnZxU3NpTTN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ly81bnNxMitZdklNMmphN0s3Y1FZYkYzdmV4OC9TYlVFVDdHV2lxRmNrUVZQ?=
 =?utf-8?B?TU9sajRXV1Iya3MzczJ0Tmxhb2VWRzlvYUdBOVZBbU5OdW1mNXVUTmZEeXcx?=
 =?utf-8?B?OTZyY2hxeXYrUkV4V3VqRkZ0QlQxMnhuelpzZ0FYL1ZOWG40bTRxakZ6L3d0?=
 =?utf-8?B?OWV6OWY0Uno3NlVBSVNnZDVvcmlnVmxUUXFZSVYxdDRWNFgralZYMFNtRXZ4?=
 =?utf-8?B?dWQwTGtQWG1Td0RqM1Z2bHpqN1diTUhxMDY4bmJGWE9hNFVUcHRkQ0ErU0Nz?=
 =?utf-8?B?NTdlcWJlbHJqdGFUWDEzbU94VmNJaG1lY28rdzBvdTJtdnU4dDZ3RnhHaDJ5?=
 =?utf-8?B?UTJqZXJGb2hpNmhiU3JoN0hqWk53bG84T0ZtUkxQekpIbmhMcFBaYWF2bEwz?=
 =?utf-8?B?MEo1ejY4OVhyc3NRK0U2d0Z2QzVVaVlrUlhRbXd3dlJ2NVhJWGhlZk9lMkxM?=
 =?utf-8?B?MXB6bWVuWTdkdGJzZ0k4ampTbTR2K0JmS2J2dTBXMldsTjRGbjZud0w3SU1M?=
 =?utf-8?B?Rm5hZ081VDkvcVB0dGtkOVgyQ3hPQi9sdDFNc295blJYRllIbG45d2h0UGpa?=
 =?utf-8?B?QVF3ckkyNXJsci94TklXTGVZa2tocTJoSGlpZUlGUmt3bUJKNHZES3BCTkc1?=
 =?utf-8?B?WFppb1BqQk1YejNKYkxBSHVVK2V1RCs1YlJrYy82ZkxGTHhFT3FiOVZnS2hC?=
 =?utf-8?B?OFFTMXVKVlI1NnplNDdTOHA5Q2lkZUZJY0wrQlk2cWkvL1ExUzhlSzRQUFlS?=
 =?utf-8?B?SmVPRzJZTjJsNTJMbksrYWhrNU5tV28yZTAvaGVYczFlVTBUQ3dLVWRlWjdy?=
 =?utf-8?B?bm44bCtoR2ljSzJlYWl1T1ZvdkFYZVJYb05NYklmbmp1UHRjNG50S2lPNW5K?=
 =?utf-8?B?QThSbkNwOHkxeWFyVDdJeDJFWmE0bis5WWhlRlBQRk5LRjFrbWRzQXVhSGZR?=
 =?utf-8?B?ckpiQUFkdDRSbUtDWEhzV1dRMllEYlZjMXRZZ2FsS2xMN3VDS0E5YVRRV1Va?=
 =?utf-8?B?Nk03RzVjVUNhQmc5STY4eWNsQ0pKZkRibTF0OHp1c0xVM3B5MFdGZDZTUXhL?=
 =?utf-8?B?N0k1a3A3azQ4eGQ0bkV4N2p0R2t3VjYxdjkvaDZSVjEyZkgxWjFXcW44Vmln?=
 =?utf-8?B?UVgrbElna2pQNktiN1ZhTkhKS1dxcUVTaDJVeThBUklVeEp1Wk5iYThtMnBU?=
 =?utf-8?B?Sk9pSzQyeGwvME9HVzU0SVJYQk43VDdzVW1TTlBzREhLZFZISm11R2hkQW5t?=
 =?utf-8?B?bmZRM256U0VSZ2hqSUxLMHA5R0F5c2xnTE5JaDBrMFZPVVp4MFJlWHQvQ3Y2?=
 =?utf-8?B?TVA5OWViajFZN3U5VnUrNGdMUE9VUks0OTRYeDRhdUNPcGJXTkNmaEZNL0VV?=
 =?utf-8?B?OHJrVWR0MXNPWXNKeW9udVF0a3RSVVZhZGlFNTNhNjlyZzl5Y3J5MnA0TTNO?=
 =?utf-8?B?ZjY2Wkc2WFhSakhjU3ZCbjJFOTV3elhPN1daVmU3aURIWTIxZ0JNVkRsQ0JO?=
 =?utf-8?B?TUlrM21QY3JyaytHN2U1U3ZERk1SdjhreVMyVWMxS2FsWGJmSTZUNG94Nlky?=
 =?utf-8?B?Ty8zOVpWZkFnMW52OTc1MkFZQVQ5dUlGcmhQcnhOQkRsSkdweXBDQ09mVWVs?=
 =?utf-8?B?TVJjQzhIL2lNL0RDdDF2c1FoeVVtWERFL1o3UzVjeGtCQXAxVnBFajR3Z0p1?=
 =?utf-8?B?Ukk4KzEvU3lLc2c2VG8vZEJOeE1KR3dyVkVvdytIcUpuVUN6K3E4cDdBU3Rw?=
 =?utf-8?B?UnV3VFk0dEFsN0hTZ3B3UTUrTEJ1QlR0SzZsS0NPUTRycGhWS08ycGFjSFJt?=
 =?utf-8?B?bTFDSDRmdVk5dzQxMUE4dHVyMndmVy83SmlaZE0yZWhIQ0tMTG9STVNSRTBF?=
 =?utf-8?B?Ynh0cHZnakU2OWtwOHlpd1pzVzhobDBRNVNSQ2g4KzQzako5Zy9rUHUxRmhL?=
 =?utf-8?B?OVp3eXphV2dzRENleE5LT1pNbnRxU1I0NzBDQzJ2M2J5SkxGbFhGeGVhazI4?=
 =?utf-8?B?S2xqRkFPSjNrSzVCQSt6aXY3V0tmT1FPRCtYYitwUERtYTJTOE93Z0s1TU9G?=
 =?utf-8?B?NHFEUGIyNENZV2lQQWlUTm9iUmE5MlhHMXZxeXZiUVRsdmJsc3lsL2U0YUh2?=
 =?utf-8?B?KzUzMHFkYkg2SmVNNDVFOSsyZmVEWE5kMmdod01XMHF5Y20yNVJrTWZjY1RV?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 654206bc-72f1-436c-b9f8-08dc64e18b44
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:38:24.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcfXqNbhFR5VRZYeM0/R7L0tMh8MGpWlk0JxAG0GD0a5MLoTd+HmLvK29h/S/SGT+bX6oBTtF2ERaLdMB3v125nXHxC3MSKkquRR5+L2Umc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Hi Ilpo,

On 4/8/2024 9:32 AM, Ilpo Järvinen wrote:
> initialize_mem_bw_resctrl() and set_mbm_path() contain complicated set
> of conditions, each yielding different file to be opened to measure
> memory bandwidth through resctrl FS. In practice, only two of them are
> used. For MBA test, ctrlgrp is always provided, and for MBM test both
> ctrlgrp and mongrp are set.
> 
> The file used differ between MBA/MBM test, however, MBM test
> unnecessarily create monitor group because resctrl FS already provides
> monitoring interface underneath any ctrlgrp too, which is what the MBA
> selftest uses.
> 
> Consolidate memory bandwidth file used to the one used by the MBA
> selftest. Remove all unused branches opening other files to simplify
> the code.

This is a good change but it seems incomplete to me. As changelog states
MBM creates monitor group unnecessarily, but from what I can tell it continues
to do so after this change. It is also optimized in patch 16, which I think
may end up being dropped as part of cleaning this up (here and for the CMT test).

Reinette

