Return-Path: <linux-kselftest+bounces-17179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CC96C969
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575DC1C21B28
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCD15530F;
	Wed,  4 Sep 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRuI+U0d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CE13B7BE;
	Wed,  4 Sep 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484530; cv=fail; b=ZAmyR/vKhi5TpAztcIZlkC30sMYEqUQdNmnrlWndo7v2+8vZ7WKpUT6EcX7ZQBWTiv7KHgoUILfBTfwCJ20gkS7kE/rQbgSBJUS6Moe6XuYQLR/NGRcLYjozsGXON6S7Szn45wr5+hOxVFVGRL3alj1gNuRKUC19v/wm28O3lPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484530; c=relaxed/simple;
	bh=lW9skic1nIFZEpfKx/qqlFu3B0T0Cnd3RUstnvdZd0U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SzuCIAuswVNKmVaEoE5bowckTe5G6w4we/ZN5yXCJ5jkatF9Kn6HGF5sp8OJ+MnQUmS4VdXX7iF/gD5n6hfnOvzFnQY2olOXhZPX221EqhoPjRdwVNZ1iSSLc5F1L8l1CGEPRpKoGhbz8hweSg60s2zVajg4Kx3dvgpgBIgYEBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRuI+U0d; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725484528; x=1757020528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lW9skic1nIFZEpfKx/qqlFu3B0T0Cnd3RUstnvdZd0U=;
  b=RRuI+U0dc2Wf9LNseXhYwokf25WnPpvvwiN+o1TH7uK+ov7NYw88uSRd
   8UjtIKWgt53bUDi0AhC35UUGlAF6YoFRope0tnJ/UPWxY+vX7dYaM8pcW
   hZTIWQfgpM9+94XcoyNqqpSc9HR/aR/R0irBWUwu6SXLwAH/cQOgIhRVG
   jhJ2/XQbj3LrScylqAf/RsEdIzlR69FKvP2nW33dEWJwMEfS4+xWu8q3c
   E+uHDQJs96n0SNnMFnGvwJmIqKgbJoFtTXIdazjoGyC3dmOpFX/100WNa
   wZdONBeHsGZ4QEfn95BTL5fYH7nzAqcg95xFMRmwFrMvfyf4lf3pkh3TR
   w==;
X-CSE-ConnectionGUID: ZLPLFFesSk+d8fmY5bjAVA==
X-CSE-MsgGUID: Lsdb1tIrQD+mtd3jMMpR1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34774610"
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="34774610"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 14:15:27 -0700
X-CSE-ConnectionGUID: giijQqNLTPW9t1hJKOLzZA==
X-CSE-MsgGUID: YLTIQUDhRIuI5Ur0fyYsBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,203,1719903600"; 
   d="scan'208";a="70009667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2024 14:15:27 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 14:15:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 14:15:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 14:15:26 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 14:15:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGDWqWcFrrbN4rON6E2m7jUNgFhrX00Xew/l9xaCVMRBj4CjhztnFVDv+wg8e7taNYPPBK/BgTvVpbM4eQM+RuOuxVF7Wcoq7UFBD5K7M0E38llsfhzhUmci1keBiCYbJaD8grqVlPcQ+YdWqCdwktZ00yzCTWwmGTxt7f/1Jx+tm3DB8Fc37O0zdpt49tNVTC9ZZXV9QxY16XlFDxepN2vCGJMxPU7z2AWO7j3yhzSIiQl5sdfjXj4/FkT9Fcx9WN2d5IFQNi92sMSmmT9/oGyes4ADDipHU8XqA6l2/1Up47rGhrYKZjmtQCe6DA4KnPt44RanYLXTOQsax1WNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e7/xeVy45Jkd2Ft7WEDGAfz5dScJilbcfmx5JHH+OI=;
 b=IjnC1DgYEbyeZlBd9Cjsw7LTnIWs171OzJlQwIWf0PKOcnRXLv6L6IGchTZNAKjTSTVkzQrAboPmRBbfQMAc7NM+av3IusRQ2FTzbayAtMTUqmlfj8h2jxJCMMEnC3cskYOrG3RON+3LBb829h3tUWOeYEIsQlwYjR6sAMu8xvuywMW1hdzNKtaEE6k+j17LH/qMh65iXDuuffMCj5440DhqasYAibzkfJC/BSyUh8V4V48R/rnxUSj0ncYr/T+3JH1c2zPFyN/Ni1AWQ3MKXI9X2pDTVn1iCsMIm08CD2T3n9xreyB8ogZLzSAug7yuP0At5/BFHtiW3QfZlFM4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 21:15:24 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 21:15:24 +0000
Message-ID: <156ad739-3f80-456f-92df-74da9266dca0@intel.com>
Date: Wed, 4 Sep 2024 14:15:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] selftests/resctrl: Ensure measurements skip
 initialization of default benchmark
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <a0fe2be86f3e868a5f908ac4f2c76e71b4d08d4f.1724970211.git.reinette.chatre@intel.com>
 <3add783b-74cf-23c0-a301-aa203efdd0f6@linux.intel.com>
 <0ae6d28f-0646-48b2-a4e7-17e2d14f6dd5@intel.com>
 <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <85a11091-3c61-2d8b-28d4-2a251f3b8ffe@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:303:b9::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4861:EE_
X-MS-Office365-Filtering-Correlation-Id: 0518d78a-7cfc-4407-96f9-08dccd26b0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHpmZVozaFpYVWpPQzZqd0hNelBLL3ExZDJRZ2tzRWdKOXgrVTVzREZ0bGxn?=
 =?utf-8?B?blAzemE0ZWJrM295SzMzcStYQ2Y4OER3bzUwT0RaTmFNeWgvODkxcUhqenlO?=
 =?utf-8?B?U1BxdEh5cFdKRmVNRVROZ0h1N1dNZ21tc3RaSGVyMXVmMm0vUWc0c2RWYlBv?=
 =?utf-8?B?R1JMK1FKcGc1Sk5CcHZOeGpkU0JNWkdRZTdLZmpQTVlSUEJkczBUL1lEMkhi?=
 =?utf-8?B?SitXUlVWUmJPc3l4eUR2dk5ZcEJubEJtcmZtKzU1d21sQkRuWkp1NlJubWxN?=
 =?utf-8?B?TjMvM1Z4RWVrU3JEWjFZcFFJSFc5MHN1TzVKbUcreHk1MFlvbXJtQjllN2RY?=
 =?utf-8?B?TkF3U0ozVUJha01KaW5ZQURwKzdlYjJYQWFBSmtiWS9ROWpGMVcxVzlycWNa?=
 =?utf-8?B?Wm9zcEFqYUtjTFZUdGRsWFJMZWxVWHgySDlRZlBKVDB0VkROemRDS1lyVDgv?=
 =?utf-8?B?MVRlWTZFZGJBUVgxVmV6a0xRNzF2NDJHZzVVWjlDUk5uSnpjQ2NiL3dMR0Nv?=
 =?utf-8?B?YnFUTnFLNHZZTDl3RXdwWGpJZWZ0SlVhNkNjTm53UjdaVlZTQ3NwcEpqN0dD?=
 =?utf-8?B?Q3NDNzVjV3R4cUNOSDVvdlp1WFZGa2g1VkVLTm1kdUlPZG5vK0FKQy9wbzE1?=
 =?utf-8?B?dlRONjg5Tzh4MkVUeUVKRDdpUHkrOUJUY0lxK3BHY0FZVHBvUnJKY0NXc2Fa?=
 =?utf-8?B?V0gxUGlYL1F1Ly9VNjR1RFRYdGUxVzFHL1hqTDcxc3ZZaU5oWlN1NDcxbWpB?=
 =?utf-8?B?NU03NVhrejRxSWlCeENjQUtCVXFqN2RwQng1aGpKRzRuZjVENDNCbDhYdVBW?=
 =?utf-8?B?cHZVaXRHZ0ZLZkNkS3Q0WGJpTCthS1J4aXoyV0M0c0hxbTFVNUY5Y0VLd1ZS?=
 =?utf-8?B?L05EZzUrV1dwb0oxMlNQc3BzVFMzMW9WRnpXT2hQTFZlbzF6S0ROYzRiVkxs?=
 =?utf-8?B?dTVIMmlUMUU0TlJHbitzK2RRZndTeG5NbENyYWRLYmNEYTM3SGpnd0dubVZq?=
 =?utf-8?B?S1JSYTJ6QzRxVDVFNkluTmtKcGRrQmJFNzF4bmJIanRoZ1hQUy9zaStMVUZx?=
 =?utf-8?B?djVERHRLdzZ3b3pPaExrcnhGckk4Zk1NTmVwVm1oQmJjNmQzSmgwLzB3L0Nl?=
 =?utf-8?B?ZXorYTloQUN1T3dlaVNFaTFYT0c3cGw5Z3lUa3N3SGt0VE9oQ2hxSWlmZm5Q?=
 =?utf-8?B?RE9ENUUrNk5tSHB6UFhMekh1aHlYdGNUS2VDVFVYSXpuSm9oME5mWVF6MWZP?=
 =?utf-8?B?dVE4NHhVeElCRTFlUFVYZFFGRG43QmZKUkZ2Y2FHdURqVHgyY2VESGVJVnNB?=
 =?utf-8?B?WnZVcjlzcW5BOElCYVlreExhRXkwWGdXZ0RkMzFCTUxpYXpTTk40dFU3S3pO?=
 =?utf-8?B?eWhoNlFCMFJpZ3lqVktMTXN4RUorQnpkeTZzZUZVUFpIOERXTVdpTlFaMWJj?=
 =?utf-8?B?T2owNVVNVE5KQWVTc1VvbkVYTHFQTnZHOTJEOWtuelRucXJwMURJMUkyNDdH?=
 =?utf-8?B?RUtOSG9ZYUludmZNa2hueTRDSmRMbkNaQXE1UERFK2RqT1FqTHBqZjlBZFJq?=
 =?utf-8?B?dm1XQ1ZQWUVKUGZKS1B5bGkyeG5SKzRpVHZRSkpJNGhua3hkSFJvdy9oeW1r?=
 =?utf-8?B?UEcvSExmTWlCMnZITnlHM093azdZQmVNd3lmbGI5QUs1WWt0MmhuMWg2YWV3?=
 =?utf-8?B?S2J5RnNJeHRWeTI4Y3pYMTJyUVBUZ28wSllsMDhkTVovY3BINDZXZHVZMGYw?=
 =?utf-8?B?WnBTR3B2ejd4NnpyeUZnRkt4SExFaDVMTXJGSlpibERVVCtqWXIwN1RPczJl?=
 =?utf-8?B?QTZVdDlwUkVaUnQ4Q2V4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdLdnJCQ2R2RlRoVjZOY1BkNnJEWHBhdGVYRWJqSE5TbDNFNVd4YnNNdW04?=
 =?utf-8?B?WTVIeDJBNGZrQzhHMzhYbkl2VnJ4eXZ1VmNldUJDSDh4WHpmWkY0eEYrcmVr?=
 =?utf-8?B?YmxkdmlsdW1BaEx6bmU1V2lTOEhPY2J3NFE4Qk1ucDVVeXFjRE9MVEpWNERY?=
 =?utf-8?B?Zm14VWZmdUp0YXdncHdwZXdXdkVST0N4TXpwM2FsK3FSRVVCbTlZZ0dnYnkx?=
 =?utf-8?B?OU1IWDRRWit5VnhWYk5pSi8zSS90SXJGQVNlWFRlRzhDL2dBczA1ZVArZVYy?=
 =?utf-8?B?UnRpVmhTYTExdDFudk9DVks4bUYyK3lWM1lPM3plcVBRUjRnclpXczU0aERE?=
 =?utf-8?B?MmZ6cTl1TzAxTlBlZUFJOEwrZkhBRmFIV05PQ0RlQW1xSnFudGxVbGV0dGpY?=
 =?utf-8?B?TUlqYWhFa3R3VXE5VG1WRGJ6d09lVHpBNkN6WXN3dzNvbjJhWDhpVEVJU3hV?=
 =?utf-8?B?aHh4S3JFaVJlWXhvMjZQbnZKNkxmZ0VQOU1IeVV2Nk9VdVE5MW5ZQlArb3VM?=
 =?utf-8?B?NEtlZWxQU3VlZEFGQ0QxMlkrd3NVZUc5T2ZLMWhLU2pIcjZZOVhMNlVLYitk?=
 =?utf-8?B?OXA0VnVxVEhzRENXaVVRcDE4YWlBNVEwcm1qa2xUUDA5eVZXSk9nc05VMzdl?=
 =?utf-8?B?NXhDSy9UYU9qL2hQbTI5NExTWUxkWWNlTTBBUmlONENMaGgwN3ZzRnhwaHVx?=
 =?utf-8?B?Z1dYZUF5SVhRT0p0UGRnLzlSZnhtYWREcG53SlJJTmVxQUp3SVdqOXc5VENq?=
 =?utf-8?B?ZGFMSFE1YVpSZ05BN0QrKys3aTNXQTBGdSs1akpSYXZpbGNRL1NaQlI2OFpF?=
 =?utf-8?B?TDNXVk5GZWFmRy9nb1dKdlV5UmRXWEtoTDdLdUlqSkJMWExEV3dNb2JqNXBm?=
 =?utf-8?B?RjJwQXpxWDcyaWNYdzhFdHFrNUlsVElMT2x5MFcrVTJWYXF6SnlVK3hYbEtw?=
 =?utf-8?B?MWRDOEdpSkltYlByTVJiWVpUa3VlZkMzMUNyOEVpVVk5eGZ4dDIwUzR2Kzk1?=
 =?utf-8?B?a05CbStGRVU2c2VXYit0d2QrZ2VWbDRFenhtcGp6V2VMbDk1SWdvQ2ptMWl3?=
 =?utf-8?B?bm9uNVg1ZjhoZWFBSjJuU3lkUkNWMjZoMTYxd2dhNzF4S1owRm4wbTBaQ0xQ?=
 =?utf-8?B?c3RDU0EzL1pMaW9wbW8rdHFpRlZJNWtobkplYnJRZkFLSG0ydkh5TGY1OEJV?=
 =?utf-8?B?QWxlMjFWZktuUjM4ZXlTejQ5UXNaMjYzQVRwUVd5bXVOdlRJd0lqUlcvakVS?=
 =?utf-8?B?aEtZbXJTYXcvMXVOTm80WkdybEhVVDlDSThjK0phMWk5YnlOdURPQzFadXl3?=
 =?utf-8?B?RkpqN3RIRUpxZ3I2YnZsYVFuY2VJTXdjM2lOenBIQ09CcTJTZzJObW1nM09k?=
 =?utf-8?B?Z3M3SWhKWU5renBhSW5uZ3VoeTdwVHNJdU5DbjI5Rk50cVdKR3BRN1lHNHVo?=
 =?utf-8?B?YWtZUHJ2SFZHRjdTdjVZTmdncSs4V25JcW5VQmlMRUdhdDI2d2svZjJ4R1VC?=
 =?utf-8?B?My8xTno2Y2RHVFE2OWc1T3g4U21hcHF3VHY0Sy9MbHdZNk9yTUFSZ1I2OTB1?=
 =?utf-8?B?NHlkdElHMVNzdG05TjhZRDNOS3U4T0srYXhSUG1OQ1BYWThoT1BVZURkWTN3?=
 =?utf-8?B?UjEwWi9qd0tuK1dBVCt0bEdNVWhseVo3SnplV2F5M1phRmsvVG83ejJkKzcy?=
 =?utf-8?B?NDZLSnhyWVQ3a2RTWDlUZnJPaVIwK3FuT1NNOCt4cFlUWlQ0WWYyTXQvT1I4?=
 =?utf-8?B?YW1nY1FLcWtMekZEcVRHQVVmZElWZ0pUZVcyWkJXd1dzelFVVDFENnFyMWVq?=
 =?utf-8?B?ZG81TUo3eFNDa0Y4UVlvay9LV3BRdkFlSFh0eG81b3FZdUdrWXlFOUIzNktF?=
 =?utf-8?B?dm80VWV5Yjg4MFVQTktoWWx2NUdsYmo0YkdFSXRIR0d4NWJFN3hCdTQ1bm9v?=
 =?utf-8?B?c0YraFMwMHNZcjhrVXRkZjM1Y2RUbkxMNC95RDBGRDRXK0QxaUl4MWZ5bU1v?=
 =?utf-8?B?VkdZYjU1cXAycldEUTFiY2U1TzdkUzgwcUgzd0FPTk50bzh1MTU5NnpIcVZP?=
 =?utf-8?B?eUJuczlWRlVWcnRiNUZKWkVmQU10ckNVdXU2OGNRZXVTK2RWOHh4b0RCQ2VF?=
 =?utf-8?B?VTJ6elcrVnJ3aDE5elRLNlhyRXdySzJVdGhYTDVGMm9DOEcxVjV1aUxkaXBo?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0518d78a-7cfc-4407-96f9-08dccd26b0cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 21:15:24.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJ9S0frIG7WMXJaZMpTLve+8ngkWJXrf20dO9kIswPVYEemQfsHD4OYe1hvwpHOf6xxNVEDb9CTWB+Z1V+DCNbmdmK3l1Y1UBJiACRpWLR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
X-OriginatorOrg: intel.com

Hi Ilpo,

On 9/4/24 4:57 AM, Ilpo Järvinen wrote:
> On Fri, 30 Aug 2024, Reinette Chatre wrote:
>>
>> Thank you for taking a look.
>>
>> On 8/30/24 3:56 AM, Ilpo Järvinen wrote:
>>> On Thu, 29 Aug 2024, Reinette Chatre wrote:
>>>
>>
>> ...
>>
>>>> @@ -684,11 +622,13 @@ int resctrl_val(const struct resctrl_test *test,
>>>>    		const char * const *benchmark_cmd,
>>>>    		struct resctrl_val_param *param)
>>>>    {
>>>> -	struct sigaction sigact;
>>>> -	int ret = 0, pipefd[2];
>>>> -	char pipe_message = 0;
>>>> -	union sigval value;
>>>> -	int domain_id;
>>>> +	int domain_id, operation = 0, memflush = 1;
>>>> +	size_t span = DEFAULT_SPAN;
>>>> +	unsigned char *buf = NULL;
>>>> +	cpu_set_t old_affinity;
>>>> +	bool once = false;
>>>> +	int ret = 0;
>>>> +	pid_t ppid;
>>>>      	if (strcmp(param->filename, "") == 0)
>>>>    		sprintf(param->filename, "stdio");
>>>> @@ -699,111 +639,80 @@ int resctrl_val(const struct resctrl_test *test,
>>>>    		return ret;
>>>>    	}
>>>>    -	/*
>>>> -	 * If benchmark wasn't successfully started by child, then child
>>>> should
>>>> -	 * kill parent, so save parent's pid
>>>> -	 */
>>>>    	ppid = getpid();
>>>>    -	if (pipe(pipefd)) {
>>>> -		ksft_perror("Unable to create pipe");
>>>> +	/* Taskset test to specified CPU. */
>>>> +	ret = taskset_benchmark(ppid, uparams->cpu, &old_affinity);
>>>
>>> Previously only CPU affinity for bm_pid was set but now it's set before
>>> fork(). Quickly checking the Internet, it seems that CPU affinity gets
>>> inherited on fork() so now both processes will have the same affinity
>>> which might make the other process to interfere with the measurement.
>>
>> Setting the affinity is intended to ensure that the buffer preparation
>> occurs in the same topology as where the runtime portion will run.
>> This preparation is done before the work to be measured starts.
>>
>> This does tie in with the association with the resctrl group and I
>> will elaborate more below ...
> 
> Okay, that's useful to retain but thinking this further, now we're also
> going do non-trivial amount of work in between the setup and the test by

Could you please elaborate how the amount of work during setup can be an
issue? I have been focused on the measurements that are done afterwards
that do have clear boundaries from what I can tell.

> forking. I guess that doesn't matter for memflush = true case but might be
> meaningful for the memflush = false case that seems to be there to allow
> keeping caches hot (I personally haven't thought how to use "caches hot"
> test but we do have that capability by the fact that memflush paremeter
> exists).

I believe that memflush = true will always be needed/used by the tests
relying on memory bandwidth measurement since that reduces cache hits during
measurement phase and avoids the additional guessing on how long the workload
should be run before reliable/consistent measurements can start.

Thinking about the memflush = false case I now think that we should use that
for the CMT test. The buffer is allocated and initialized while the task
is configured with appropriate allocation limits so there should not be a
reason to flush the buffer from the cache. In fact, flushing the cache introduces
the requirement to guess the workload's "settle" time (time to allocate the buffer
into the cache again) before its occupancy can be measured. As a quick test I
set memflush = false on one system and it brought down the average diff between
the cache portion size and the occupancy counts. I'll try it out on a few more
systems to confirm.
  
>>>> +	if (ret)
>>>> +		return ret;
>>>>    -		return -1;
>>>> +	/* Write test to specified control & monitoring group in resctrl FS.
>>>> */
>>>> +	ret = write_bm_pid_to_resctrl(ppid, param->ctrlgrp, param->mongrp);
>>>
>>> Previously, this was done for bm_pid but now it's done for the parent. I'm
>>> not sure how inheritance goes with resctrl on fork(), will the forked PID
>>> get added to the list of PIDs or not? You probably know the answer :-).
>>
>> Yes. A process fork()ed will land in the same resctrl group as its parent.
>>
>>> Neither behavior, however, seems to result in the intended behavior as we
>>> either get interfering processes (if inherited) or no desired resctrl
>>> setup for the benchmark process.
>>
>> There are two processes to consider in the resource group, the parent (that
>> sets up the buffer and does the measurements) and the child (that runs the
>> workload to be measured). Thanks to your commit da50de0a92f3
>> ("selftests/resctrl:
>> Calculate resctrl FS derived mem bw over sleep(1) only") the parent
>> will be sleeping while the child runs its workload and there is no
>> other interference I am aware of. The only additional measurements
>> that I can see would be the work needed to actually start and stop the
>> measurements and from what I can tell this falls into the noise.
>>
>> Please do keep in mind that the performance counters used, iMC, cannot
>> actually
>> be bound to a single CPU since it is a per-socket PMU. The measurements have
>> thus never been as fine grained as the code pretends it to be.
> 
> I was thinking if I should note the amount of work is small. Maybe it's
> fine to leave that noise there and I'm just overly cautious :-), when I
> used to do networking research in the past life, I wanted to eliminate as
> much noise sources so I guess it comes from that background.

The goal of these tests are to verify *resctrl*, these are not intended to be
hardware validation tests. I think it would be better for resctrl if more time
is spent on functional tests of resctrl than these performance tests.

Reinette

  

