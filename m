Return-Path: <linux-kselftest+bounces-15182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D763A94FA5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A9D1F21AB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1919AA63;
	Mon, 12 Aug 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUzEoGVp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18EE19A2A2;
	Mon, 12 Aug 2024 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506019; cv=fail; b=PmviErohlobjLq+l94gHJ01KS/pVaZn4MAnEuLpG3evkHkXnTQ53ZoxrEA9RAEg54qs0tyf1WQlEmSMwaXCd3Ydho9H0aG+E8ia0LmFnx44dxf631K5gaxl+KOqtkdu68CGN07wG0OoBFQHo49IN84f79cCSwrQxY4pZUsBl6fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506019; c=relaxed/simple;
	bh=sza68D85lzLGJ55QpX4YUgHenV3iivNxdQ1cAlKNPds=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iSSbl64RBUzAffEsUhkuJfeFewjlUz4HUj6KMG3wDHug903c6O9T/X+eageVJd6bsAT/HCApiXio6ttzRsdkqOYsLWhPF44CRhkG1pRhg9Lpk7dNZY+yGTHuvUn0WwGriDU5deOEvXfgekdZ0qfzuwZ9vTbqnCUyhZsQol6yBGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUzEoGVp; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723506017; x=1755042017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sza68D85lzLGJ55QpX4YUgHenV3iivNxdQ1cAlKNPds=;
  b=RUzEoGVpsM/Z31uAFgiKTsE7q55HVyDd1lUtrkvMBz9Bt32LYTC+pCmI
   zpB9dC1CvQBIarrPHZ6Xo2GMLYivsrhJYKdGsokred1U9Q8V4gULKM+mA
   nXwdvddTrq4Kt50OF99xP6uBBloety2Wuy6S1UAEe2VEPokUpMrcWbGiA
   SJED4ApKrasQBhcw8xeRhp2GRdZzx3w9a2Gqf2Jb6uwoKHOFicu8jKzEH
   dvC+b3dz3aOTrqr81kZ8dqygeXwcaiqr5QXuOZu8UoeyjZLWM/SDEvE8R
   dxmDD4/yMy/0Zi9z/G0j98t1ULkiBwDY28Pe3lvG/xR+qQyWn2mWOuidD
   g==;
X-CSE-ConnectionGUID: vtH/DqewTpGya2QqJuwOEQ==
X-CSE-MsgGUID: +CpqexNlSWGwHnXpw8Btsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33047064"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="33047064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 16:40:16 -0700
X-CSE-ConnectionGUID: cirifux9RNK7Z9jnRpuiKw==
X-CSE-MsgGUID: eyGQy64uQIi+b0EHq79Kpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="62867455"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 16:40:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 16:40:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 16:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTwxZ4iZBqsiQfN/hT6j20k2Mo4JtrPCJB0Dupz9Yv/YHcB6fx+K5OokLl0uECl4dkjK7Kb+R29X19lz1zJEQSCtEkk5yc8rKb50+wwAB1La7Rvsp+gjqqvJef2/aKAWoT+lwSkSJ2KC0wvAzOFO0ekYfHvuZ/txN2O1J2tfQMVuqgyIzNo82J0bhkTFdWOEN/iqVZTeGw6LAQdreg14y9puoGrrTaF5MM1w/BdPGdjxF0FuqO1taGSNem1ajZj5eBiEzZHXixIyGdD/X3hTgUwzilnsZ4jPEF+tngE5SpPiSihbm7YzugWTsQLGt041GACbtaGxwSE/CP4/iVoCLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUXaKMzUQZ7rut5Hn3OiicNRViBknF+K0KB0Hj0+ZAk=;
 b=Gk19Z9u08UIpiEdLVQH6lcn2XKwhxkCBjWFVM8XGTTHVeJFn349/0uOYndWoF1ENWpP7+czN4ZCMeTXC1YXUxedngyrVG84ofEH5nGyR26/QNwlrv4CvzoUSv/Bov8jrnQ0uRGv4LLxJkKYpf9PCjTz5XHrcdvFC4yBItXltG5MW/Esk0VFcciz4NLJY+daQf3OYptVv7xTKqesu6AuZq5qg3Ka1x/AX0V/wRwLyS/JUAaB31/DINHi4eqnS1nZ30Kc42iacT6S5f//ssH6YhUCKhHVvhdwJT49DlARYHNVWKSq8KDx4QK1iaJX9GOyR/hJiQiJ+ThaFaxLQSGBCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Mon, 12 Aug
 2024 23:40:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7828.023; Mon, 12 Aug 2024
 23:40:13 +0000
Message-ID: <2048036f-332b-49d1-a753-3653136d728c@intel.com>
Date: Mon, 12 Aug 2024 16:40:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] selftests/resctrl: Adjust SNC support messages
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1720774981.git.maciej.wieczor-retman@intel.com>
 <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1fb2703ee27a0dfa13a7aa501b81439c433521ea.1720774981.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fece992-97f2-414a-c015-08dcbb281c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azBrZ05aZUJab25hdWpabktXVzZybnJNb0lqQmMrdW5nSjc0U3lLQTZ3Smt0?=
 =?utf-8?B?WDUrOG5zTmZka1NiZzNTOFp1a0NqNEh6Z29RZzUwMDh0RWJySVpSak9mdEpi?=
 =?utf-8?B?WE1PUjFtOFk3dWRaMjhLRXpkZ3o0ZmZwL0ExVWQ5ZDlmZ1NvN0ZteG5TSWcx?=
 =?utf-8?B?bjJZTjNNUTJaYWRJSEZiNnBSRU5QVkJuN1didHRLYnVwdjFDSjRISFNYRFpL?=
 =?utf-8?B?TmE0dDNrd2ZZRDlCbkg5WlJQWnFQc2pHdTdpa0NxcEljdlZNZmpsQkNZNTd3?=
 =?utf-8?B?YThoRTY3ZzJhNURwRms0aTV5OGhZRHlMMmFvYW84K3dMdyt2d2p4NXNNaVVM?=
 =?utf-8?B?ampvaVZlcXROT1VWN0s2NDFTNXlQNjJGY2ZlcGk4UmRhMTJNLzZ2eWMrVHNy?=
 =?utf-8?B?NEJYaVNhWGdTYmRoWmxXS0xJTE9ub0ZzYXIzRGorbmtQMzR1L080UEtSaklV?=
 =?utf-8?B?L2QrSk1LUER2SHBEek1oU29TR0M3c2J6WjRNZGdONmdKa211aDZBNURUcmVn?=
 =?utf-8?B?NVl5cVB4VlZ0Y005QXVBT2dqZ2xHSGRqdmd3SmZUK1N2cEMwVEJKTGVEQXND?=
 =?utf-8?B?M0xWemtMZXJsZVBoU05XSmxyZnFOc3lqMzZNM1A3Q01vV1BFTHdwTWVpZEFp?=
 =?utf-8?B?MWRSNkRaUXlNaXA4bW1aVVV1VUxLLzZ3L3k2Q2YwZVBWclBJaWJVdTZLVWhw?=
 =?utf-8?B?NDRmQ0lSb3YzdzRlWng5UllyOFd4Z3hoY1RHcEdicmhkazZ3UUF6V3Q2N24y?=
 =?utf-8?B?dVJwbjNSUUdhNi9RdE5vdjZrdzg2Skw5dEozL2p0QjRzcFY1ZVhCVFFwc2pj?=
 =?utf-8?B?T0NyWE1RYU1oUkVlUGVBbEgvK25NL2xNVDFmU0VOMldmQWROeUZmMXphUUVI?=
 =?utf-8?B?TmFQL0hpWTNQMUtreTR5Y1BuV1ViOFg4dkY5OVdLNlpUY0Q2RHlvVDNJUVl3?=
 =?utf-8?B?aGdMRS9IY3c4NU5MbnN2RXdZUEhGelE4OG5vNVRNSFNhV1Z2MnFSKzYxY1g1?=
 =?utf-8?B?bk16bGtMdWxOeFZTNVVab1kyT0JFZTh4RllUWFhKS0tPNEhjd1lqOXFYQk84?=
 =?utf-8?B?Y3lBcG9QUTVjeHBqcXR5SndERGFPdVNwem5ONzdhNGw0elkxcFdnNzVrR3pa?=
 =?utf-8?B?SnQ4cXlCNk9lZlBoNkw0Skt6UUFqRWdEVUdiSUdScGJiN2dyaHliQXBzd1V4?=
 =?utf-8?B?emRjTHlCaUk2VktPL3M5eDJ1dGdPeDdmTjBoSkJvZ1o5NVhWZk04UGsxMGN4?=
 =?utf-8?B?YzBMblJVUTA0NzlyS1gyeTA5VmZLZ3BoTEdzT3Y0QlZvNTVEQXdtZlFISnlv?=
 =?utf-8?B?Vjh3czJCNkl6aGZhREdKK2hzZW5LbjB0WUVwWmdjSmlRUnh4d2dVVWlSWGwx?=
 =?utf-8?B?RXJoT1JUQnF6aWRIdzRaY0NxOUNXUWE1bDFXSE5nSjRPcDdXM0JaYnJmWEYz?=
 =?utf-8?B?bmtpazNGMkl5Qm80OGsrR3NRbGRiOXBWMTVQQ0ZuSkYxblBvemF5TFBnTG9J?=
 =?utf-8?B?RTVITGhRQVRBMlVNbVNoVkNCNHNVZ1lTSWRnYVByQU8zcjljaXMwRVA5VlZr?=
 =?utf-8?B?MVJweEsvSkx5ZVdLYzdYNXcrZlRQNnNRRzNmN0o2ZTIraXBwQ3p3T2pFM1pW?=
 =?utf-8?B?L1B3SWk3RWpPRUN5RExzVlBaNzFFSlNiOWNsclIybC9kc2g2ZHduaTFlMk5w?=
 =?utf-8?B?YW1GaVZzMllLV0dNWGZmcEREdFo5N01JTkxwUzZSU2dueTJLUk9rNWtHRjE3?=
 =?utf-8?B?d2YzMXdodzRpY1Zpb3JjVzhRN1dTaUZrUFN1SFNSUHZkbFg1Y2lJU1BmUnBi?=
 =?utf-8?B?YmdqdWVTcjV4MUtQNW9UUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmRqbExnUWEwZDh5dGFGemJ2UGtJMFNNQ0hGQnh6TlRtaGpLM2RPVStibFAv?=
 =?utf-8?B?cmNwTXc1TlkzUUg4eXYyUVRRYTRGcWpuRSt5UWJMZWhYbzRmck1qYmI2QS96?=
 =?utf-8?B?R0ZBdDNTQTZudEdIdzJRbXdQaE94aGQ1b1d3WjFXWWU4RjZ5ZDJ3WGYvMGx6?=
 =?utf-8?B?K1JFeTRhY3E3V1hoV1piNGN0aDhSaUYzdVFRMm9VMUpOa29pM1BiS05WUFNi?=
 =?utf-8?B?MjdZb28ycGlHYXpNNlRaNlYrMEwvOVgxTFFPL2hOV1VxYk81bzBla1FFcWFt?=
 =?utf-8?B?MFlrYUFHdk5ENjhjTC9ORjlxTzFQWnR5Y21zdG0xTEtqeUViaDVOWVhqelJw?=
 =?utf-8?B?Zjh4ellMWTIyY1p6eGtQc1d2anNzTWVMaUZwNStna3ZsRFVBd0c1Q1RWZzZR?=
 =?utf-8?B?dE44dmo4elhiVmtleGx2QVpGSHM2MUd3Q1Qrbm1ObCsweWFJbEVaZk1UWnRs?=
 =?utf-8?B?TUxHbzVxRUpJbEErMm1UV0Z5cjhDUEYzd1B0RzhncTVtdnJ6T1AwVmRiZ3hI?=
 =?utf-8?B?c1FQdG51OG1MZk15aXhsalY3YTJFeGJnb1VzWGZiWVp2Y1hweVZleFExTVFv?=
 =?utf-8?B?bWdBSHZPNFp1S1RJUFhNQlhvNHdPUzZPRVlNcDA2THh1dzQ1TnBhZlp5NVk2?=
 =?utf-8?B?MjVpTzRsbVVWRGVoc0hyWk1OSExJeGQwd2ZYTWYyb1A1RDBNMmpmTnM4ZXM5?=
 =?utf-8?B?cTM4VENyRlY0RW1VbTBWMU9iMDNoQTBXaU05TG9QU3pNVTU3cDYwZVlkeXdH?=
 =?utf-8?B?UVdjVHJmQisvUnIvOVlYSVMyc3c5dGJjWkZsWll2NU9YczY1alRaNW5NRHZS?=
 =?utf-8?B?M21VSDZ0bTUwbEJHajdSaWV3d1E2MENyNi94UHF3QjBrbkVZOGVhZ3lUb1BZ?=
 =?utf-8?B?bksvb0tUcEJUZEl5N0VXdmdUV3lxdDJqdENlK3hVSzVMM1J6MGdRZ3dRTUpW?=
 =?utf-8?B?UlVXVk5TL0ppcWthR1RLbk1uU0ozTW9ObGF3MHYrNjJSSktwMnpwM2xxWU9G?=
 =?utf-8?B?bEVIVWRMcUJKRnJQNktMR0N4bUpvcVYwYnZPUHIweStGMFFKbCtGa2ZxQ0dz?=
 =?utf-8?B?NkV6NEpzWmE1a05TTk5vaVJDREs4UFl6ZVB2U2Myakxva0N3M3Y4d0t6dU9P?=
 =?utf-8?B?eUl6dXNwRTdEbVlKQ2ZpbWp6ZlRiVVFGUzFneFplTHJoZWJXc3pXbmhsRTk1?=
 =?utf-8?B?ZHJmWDFlTGNVSmdSSXlnaUlodElYRUFJSWJOTXY3WWR6aEY1eVhiV0txUlh0?=
 =?utf-8?B?ZGVVYWc2ZU1ZUk9UMVB2aTdLSDNxSXBGc04wekVORVBkeVU3UnJKd0IyRStr?=
 =?utf-8?B?Zzl1Q0l0VVNUYTdpOXVSK0c0Q0k4YnVvZHRwWGFVZE5Sa2dpSnZOTHBrZExv?=
 =?utf-8?B?S1hzbWJNTWx6ZWtTUUpEbEdndTVPcjlXQVFiVlpkbFZCc2p4ajRka1NWVlVx?=
 =?utf-8?B?aG11WHpZWlQyN1g4R2tzWXpxeEE3dStsblFyZFFLRFV1MUhuMWcvQnJ0NjRa?=
 =?utf-8?B?MDM5aWpOOUFrTXRKNUlhWEUyRnFHNkJzSDVhY1VhWEp3aXM5Z3NuOGZ1emtX?=
 =?utf-8?B?Tldha2V3UDlEbWY5NFFsZlF4dEwrdGJTTDJIVHhFUXJJQWxJajRYazNmZ2xR?=
 =?utf-8?B?MTdERXhhS3hYL1BNeXpPTStobjNXMlRwSDFCVkZaR01XQVRCZEhwRnRiL1hQ?=
 =?utf-8?B?YVJzOHlvNDIvaXBYTXJjYndLNThqT3U2bXVrL0cwV1kxU3VCS3RMMUkySHF4?=
 =?utf-8?B?WG9paVg3bm9Kd0VDSnFlRlhtU0ZBazdlSUd0SjhiSlF0Rmdjb0xsQlpSejY5?=
 =?utf-8?B?N0tZU2kwaW14L3pyVWYvQ0h3dFhVdDNSRFN1cWpkM1RQckdRUmI5QjVSdVJm?=
 =?utf-8?B?ZWpHTGUwMmZCR21tUGhuOGlqbTVRRDFyekFhblY5TVpqSm9BRDBubTQ3ejJI?=
 =?utf-8?B?SlpQVFpBUXdwZnBvN3EyOWhuQUZNMkh0RFB3emxoQisvZGxwblVSMFcwOVFu?=
 =?utf-8?B?Ry94MmdPbW9kTktHUXNKSWlNVWZoRmhmNDZqakZTTC9tY05hNzFZOGZQbE1N?=
 =?utf-8?B?cjd5L2llVW0wQVc0elZ4U214RlZJMzZNSjRzWTdBV0k4cnhrUldrcEtVdnBM?=
 =?utf-8?B?ZzFKNXhLak53a2o3alZuNk9va0c0ZGFvb1FqNlpFY0Q4bERDOERmV1ZaRXlh?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fece992-97f2-414a-c015-08dcbb281c77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 23:40:13.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQvPtVMjrTIqUXn+i2nO8R9Cpo+jZI4iyYM4RfBvtfC2yXYu4TZk2yv79BgCH9NfTcvUGBX+bUpF9t8vUY0r00ed00XTYhfm/9EQ2m/1w5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com

Hi Maciej,

On 7/12/24 2:04 AM, Maciej Wieczor-Retman wrote:
> Resctrl selftest prints a message on test failure that Sub-Numa
> Clustering (SNC) could be enabled and points the user to check their BIOS
> settings. No actual check is performed before printing that message so
> it is not very accurate in pinpointing a problem.
> 
> Figuring out if SNC is enabled is only one part of the problem, the
> others being whether the detected SNC mode is reliable and whether the
> kernel supports SNC in resctrl.
> 
> When there is SNC support for kernel's resctrl subsystem and SNC is
> enabled then sub node files are created for each node in the resctrlfs.
> The sub node files exist in each regular node's L3 monitoring directory.
> The reliable path to check for existence of sub node files is
> /sys/fs/resctrl/mon_data/mon_L3_00/mon_sub_L3_00.
> 
> To check if SNC detection is reliable one can check the
> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
> are operational and the ratio should be calculated correctly. If it has
> any contents, it means the detected SNC mode can't be trusted and should
> be disabled.
>

This belongs in previous patch.

  
> Add helpers for all operations mentioned above.
> 
> Detect SNC mode once and let other tests inherit that information.

This belongs to previous patch.

> 
> Add messages to alert the user when SNC detection could return incorrect
> results. Correct old messages to account for kernel support of SNC in
> resctrl.
>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Change messages at the end of tests and at the start of
>    run_single_test. (Reinette)
> - Add messages at the end of CAT since it can also fail due to enabled
>    SNC + lack of kernel support.
> - Remove snc_mode global variable. (Reinette)
> - Fix wrong description of snc_kernel_support(). (Reinette)
> - Move call to cpus_offline_empty() into snc_nodes_per_l3_cache() so the
>    whole detection flow is in one place as discussed. (Reinette)
> 
> Changelog v3:
> - Change snc_ways() to snc_nodes_per_l3_cache(). (Reinette)
> - Add printing the discovered SNC mode. (Reinette)
> - Change method of kernel support discovery from cache sizes to
>    existance of sub node files.
> - Check if SNC detection is unreliable.
> - Move SNC detection to only the first run_single_test() instead on
>    error at the end of test runs.
> - Add global value to remind user at the end of relevant tests if SNC
>    detection was found to be unreliable.
> - Redo the patch message after the changes.
> 
> Changelog v2:
> - Move snc_ways() checks from individual tests into
>    snc_kernel_support().
> - Write better comment for snc_kernel_support().
> 
>   tools/testing/selftests/resctrl/cat_test.c    |  8 +++
>   tools/testing/selftests/resctrl/cmt_test.c    | 10 +++-
>   tools/testing/selftests/resctrl/mba_test.c    |  7 +++
>   tools/testing/selftests/resctrl/mbm_test.c    |  9 ++-
>   tools/testing/selftests/resctrl/resctrl.h     |  3 +
>   .../testing/selftests/resctrl/resctrl_tests.c |  8 ++-
>   tools/testing/selftests/resctrl/resctrlfs.c   | 57 +++++++++++++++++++
>   7 files changed, 97 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index d4dffc934bc3..a8bb49f56755 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -285,6 +285,14 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>   
>   	ret = check_results(&param, test->resource,
>   			    cache_total_size, full_cache_mask, start_mask);
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");

The kernel support only applies to monitoring, there is no kernel support/changes related to CAT when SNC
is enabled.

> +
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
> +		ksft_print_msg("Intel CAT may be inaccurate.\n");
> +	}

This is still relevant but unclear why previous message checked "ret" but above does not.

> +
>   	return ret;
>   }
>   
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index 0c045080d808..471e134face0 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -175,8 +175,14 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>   		goto out;
>   
>   	ret = check_results(&param, span, n);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
> +
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
> +		ksft_print_msg("Intel CMT may be inaccurate.\n");
> +	}
> +

CMT may be inaccurate in both scenarios (no kernel support or unreliable detection). Why only
check "ret" in case there is no kernel support?

>   
>   out:
>   	free(span_str);
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index ab8496a4925b..a805c14fe04b 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -179,6 +179,13 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>   		return ret;
>   
>   	ret = check_results();
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
> +
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
> +		ksft_print_msg("Intel MBA may be inaccurate.\n");
> +	}

As I understand there is no change to MBA when SNC is enabled. These additions thus seem unnecessary.

>   
>   	return ret;
>   }
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index 6b5a3b52d861..ce3c86989f8b 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -147,8 +147,13 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
>   		return ret;
>   
>   	ret = check_results(DEFAULT_SPAN);
> -	if (ret && (get_vendor() == ARCH_INTEL))
> -		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
> +	if (ret && (get_vendor() == ARCH_INTEL) && !snc_kernel_support())
> +		ksft_print_msg("Kernel doesn't support Sub-NUMA Clustering but it is enabled on the system.\n");
> +
> +	if ((get_vendor() == ARCH_INTEL) && snc_unreliable) {
> +		ksft_print_msg("Sub-NUMA Clustering could not be detected properly (see earlier messages for details).\n");
> +		ksft_print_msg("Intel MBM may be inaccurate.\n");
> +	}
>   
>   	return ret;
>   }
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 851b37c9c38a..488bdca01e4f 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -121,6 +121,8 @@ struct perf_event_read {
>    */
>   extern volatile int *value_sink;
>   
> +extern int snc_unreliable;
> +
>   extern char llc_occup_path[1024];
>   
>   int snc_nodes_per_l3_cache(void);
> @@ -167,6 +169,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>   int signal_handler_register(const struct resctrl_test *test);
>   void signal_handler_unregister(void);
>   unsigned int count_bits(unsigned long n);
> +int snc_kernel_support(void);
>   
>   void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
>   void perf_event_initialize_read_format(struct perf_event_read *pe_read);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ecbb7605a981..4b84d6199a36 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -118,11 +118,17 @@ static bool test_vendor_specific_check(const struct resctrl_test *test)
>   
>   static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
>   {
> -	int ret;
> +	int ret, snc_mode;
>   
>   	if (test->disabled)
>   		return;
>   
> +	snc_mode = snc_nodes_per_l3_cache();
> +	if (snc_mode > 1)
> +		ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
> +	else if (snc_unreliable)
> +		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");
> +
>   	if (!test_vendor_specific_check(test)) {
>   		ksft_test_result_skip("Hardware does not support %s\n", test->name);
>   		return;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 803dd415984c..4d0dbb332b8f 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -13,6 +13,8 @@
>   
>   #include "resctrl.h"
>   
> +int snc_unreliable;
> +
>   static int find_resctrl_mount(char *buffer)
>   {
>   	FILE *mounts;
> @@ -186,6 +188,25 @@ static unsigned int count_sys_bitmap_bits(char *name)
>   	return count;
>   }
>   
> +static bool cpus_offline_empty(void)
> +{
> +	char offline_cpus_str[64];
> +	FILE *fp;
> +
> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
> +		if (!errno) {
> +			fclose(fp);
> +			return 1;
> +		}
> +		ksft_perror("Could not read offline CPUs file!");

No need to scream.

I think it will be more useful to replace "offline CPUs file" with
specific "/sys/devices/system/cpu/offline".

> +	}
> +
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
>   /*
>    * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
>    * If some CPUs are offline the numbers may not be exact multiples of each
> @@ -199,6 +220,13 @@ int snc_nodes_per_l3_cache(void)
>   	static int snc_mode;
>   
>   	if (!snc_mode) {
> +		if (!cpus_offline_empty()) {
> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
> +			ksft_print_msg("Setting SNC mode to disabled.\n");
> +			snc_mode = 1;
> +			snc_unreliable = 1;
> +			return snc_mode;
> +		}

This can be moved to previous patch and that for loop simplified/removed.

>   		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
>   		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
>   
> @@ -942,3 +970,32 @@ unsigned int count_bits(unsigned long n)
>   
>   	return count;
>   }
> +
> +/**
> + * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
> + * SNC resctrl support on the kernel side.
> + *
> + * Return: 0 if not supported, 1 if SNC is disabled or SNC is both enabled and
> + * supported.
> + */
> +int snc_kernel_support(void)
> +{
> +	char node_path[PATH_MAX];
> +	struct stat statbuf;
> +	int ret;
> +
> +	ret = snc_nodes_per_l3_cache();
> +	/*
> +	 * If SNC is disabled then its kernel support isn't important.

Please expand comment that this does not take unreliable SNC detection into account and
needs to be done separately.

> +	 */
> +	if (ret == 1)
> +		return ret;
> +
> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
> +		 "mon_L3_00/mon_sub_L3_00");
> +
> +	if (!stat(node_path, &statbuf))
> +		return 1;
> +
> +	return 0;
> +}

Reinette

