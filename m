Return-Path: <linux-kselftest+bounces-4462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D9884FAEE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1DF1C25DE3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9C7BB1E;
	Fri,  9 Feb 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbEHsfP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93F80C0C;
	Fri,  9 Feb 2024 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499235; cv=fail; b=J/U8kDjWaowOo/1WKtBhD+g3hZ65Se4iD3H5dkSmyNa51rPrOsXY1nBTq1CMKvK0uBbsfoX8AIhRL5ujWmH4P1aToUv0VOvXOeWMJReoaZ+iuPEbksqucwheBDdkevY+5BCfk4slQuUxq0T3TZZwn9xbY05pRqYp8X8PkUceFys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499235; c=relaxed/simple;
	bh=zIU4MIW6MQfuak/w2DymJZDrEo1ibRXW6U65hfYQcWA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YG5pg+Zxc5aKwAEY3inbEpMgerW08CvZBGX9Wufyk5rcLz6x/QOyY5cExBo0hNYD3Q1GNCalLq4Uhm5EfAfQ2ltQhn8aaKoM0r+tN9iCf46YaFa6hr4dnTuCdflttySUD1nlW53NX0X5ju/6WbeOq7WB0xzwGqNOaORsoSQEdZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbEHsfP8; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707499231; x=1739035231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zIU4MIW6MQfuak/w2DymJZDrEo1ibRXW6U65hfYQcWA=;
  b=dbEHsfP8ODLUBVD6XJ0PuDGlZWMUhyGybtUDdqGeR7bE/kcwT/SttV0b
   kWppHg5/87Bt348uPtddiyq/+P8TFcvAfTtFAG6f/L5ix2+yArYcM/Ojo
   UoWJ5zZs/InLoEzB3KmR/ScGhihDHisjxCMj8IuABmDQeqE8541R99h1y
   YV/iZJIX+VGmdhqcfwHa3iy1XrrbRtdW9rGYJc80kh2hP7EqzHdf0E9gD
   RcwVh0c+ziuxPra1HCwbL+qgdiNZUvFccRaokJWTQTQ851kdHspwIhHZr
   p+0sSRF1r87V/wFUpy8zySv08skY1AO4s5rPwh46llQ45eKNXf2yBaaHZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4445898"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4445898"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:20:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="25217665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 09:20:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 09:20:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 09:20:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 09:20:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niwI80k72lrObb/Y9i/2siQhHDVPBldzTsl1chuCL9wFO50gbBL2RrsKfOyJOOFVrN1o8ZYokRINEqo5v4ih45/8JOZeq0Inq2qkvod7Zbg8sbRhCVtKKsV4bqPIF7OAuGwASodO9BJQUhGFVg1y9f9ZDiavr7+she3MtNF2L/knChmwvVqaC1OsGGDb/6ZIOBePMzelXjscK0yIVhj1ztA1kAJOERF3aBYaMs58d2BCaxe094Mq+QUZGA7ccZu8r7HMhoRZwIpxrZreVUkjWXKqkE8QkdC+OwEApW2jkwetswF2AHIereXFCIUG4X6dtozRj3R6as3naFebQptCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhhRBGLJoEIoSP6SkUEXtc8qW5IBvhEOM/3XNC6VgwM=;
 b=SnJkhtHmCZm61pjaiHxRD+WBye8sktU2K3ywZWDqy9qkl5+GqvnDbHackwHWP59cBSAYYOQiqreyJzM2BwVjuDSwaiZaAWKINkITl1IlQayhTkDUHo8wt0DRA6tOUel30g9VN9mc8TVTVKqV6av73u5Z6t/JCKBt6z4VtT6qIB9X0ZD7/j8VPT/5QM8VtTwFYPj3eV9ItDglMoYOlz2nsFr+/BqsPwJ5P+e5OEQWEMojoOfaO7FZeQxHHpzzbngk8AoZ9VWdfEl49qnapqcqxM2tU2RsO6WjJJdAG7ya2sPcQTI6otbXfuWB+JrLsA/zFWMk/7epQEVVMzD6OHS8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 17:20:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 17:20:27 +0000
Message-ID: <f65f7c8a-e2d8-444b-abbc-d28eba0f86f5@intel.com>
Date: Fri, 9 Feb 2024 09:20:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <f914c55b9b9f635cff082b0b4a8b636598580821.1707487039.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f914c55b9b9f635cff082b0b4a8b636598580821.1707487039.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb8987d-a230-4a50-1fb6-08dc299368e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dB/TQ9Z6iMtbRC7OEw402LVioCo0xwIkN0K8jwXSExNgC0GA1L/MNf5n9OnaTKDJH0dhFzns/4i+BAylKTaije/MRAzatQDLbPoM0CXzMRfDcY7OnoiZMVSC9VAuIb236c8s4jjALBJUG88HHjP0W9O+jaoozb2Mvu7R2qhRqm1jmaknuf2+3ltsPT4qmlNBuYNi/DY0U6krmD24HMuMWofNTCWgUDt3y2ipOZ6s2VZlR137N62pMNA0ldLQjnZNt03XBDl6AEgML2TNIx5Rg0D7NkQ0o9Z2EfND31DogF7UNmxyTIIqxMIZa0w5KaS9ggiFIjza0kjFwCtyONFMCH3JUbUm9xDBa0rQcmRh3wj3XTyCSO9zVI7ARoJpeTiCmmVgY977GiRvON3A6C/NZReLlTClEGiNfN/DSrsqwtqGR8l0kSL0cdUOqJNH7hG1goqVPTLlrpb82HasJHtyB9fHUDeWfeP3Ywd6jpOz6XGyCMNxdTdn7pjeXZX/gm/OmQpRf0u9369t8tXXW94E0rsqXpXw9oesbltoL19hoILT8oXqo41LOeiqSQA4VsHt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(82960400001)(31696002)(38100700002)(31686004)(41300700001)(15650500001)(2906002)(6512007)(316002)(6486002)(478600001)(83380400001)(26005)(6506007)(53546011)(2616005)(36756003)(4326008)(8676002)(8936002)(6636002)(5660300002)(66556008)(66946007)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmFmVzdtVXBzQjFrSXBFc0tkL0ZhRTFQWlZWV0JHZWVsdVowaWROakFqUk5N?=
 =?utf-8?B?eExVTTh5TFRadUxMbjRHeU5PTGtNc2ZEQUwyS0hVb1VNM2UrcDUrV0h4YlNa?=
 =?utf-8?B?VVpQRlY2MVpwZGVRNzRaVS9uSFJkbm9wZXNic1hTemFqNDNWM2xXcmxpYVBJ?=
 =?utf-8?B?a0F1QittV3dhVWpjQ0tWZU1zakk4NHlMOHF5MGdDN2pRUkg3cXdKK1FWRktL?=
 =?utf-8?B?NGs5R1NQNjE4bmY2TlJNQTRLLzBjTm0zSlE4T1ZKdzVNWnpiRGlXVUdtQUdt?=
 =?utf-8?B?ZFdyVi9XQkpiMXRHSm5wYXhSZC8yLzlmUXJ0elY3Q1ZheDNCUjBCeStlQTJD?=
 =?utf-8?B?NnV3cExVY2Urd2JnVGZGSWFWaExja2lFUnNPV20yQkMxcDAra0NVaGNjV215?=
 =?utf-8?B?QzhiTzBmSTVHMFgxR0E1MVNmTTNNbFNXRVhvQjk4akpRdnFvbmdnVzg0ZmE1?=
 =?utf-8?B?U1VSTmN2ZEF0c2wwaklnVXJDSUJFWUhlbEdVQ0t3YXNaZ3h2ZnZGQ290Q1VO?=
 =?utf-8?B?V2FlTHJkc09pMXdtU2h6V0hSQnJqbCtrVDVsaEJGZXBPNGVxRE04dXNpd2w5?=
 =?utf-8?B?anY2OSszQVpQdWFFYzdkQko3ODBFSjZvS2YzSHlRVUt3ZGtQUklFZEVycjNh?=
 =?utf-8?B?bGRRaTFNWC9zNnF0WUlLSVZDYlQ4TXU3RElnQzNhVysrUzhGWXFzdUpGRlM2?=
 =?utf-8?B?dTNXSGc5MUhhODcvb0hDZW9aV3ZVZGlzVVh5VUZYYUo4QVRNcUlBVDFySnlz?=
 =?utf-8?B?QlRaU0xGRWZSQjNPTVlWWjJncUdKYmVXcW9qbXo4dTVYd1VjSHlFRDIxbEFQ?=
 =?utf-8?B?c2RsZWVhYU1NYm1KOWk4OWhkNTkvT0xYTFJlQmJjaFVOUm9QSVNYYUkyeUhx?=
 =?utf-8?B?aXlQMFBOVTQyVW01OUNldkNmZS84UFJnMU1pUC9GQ0tYTys5TTZKRGtBV2Zs?=
 =?utf-8?B?SWMwUTZqaEliYWxoUkxCVFRkb1NRSkFQa2QxNVlyZExsR1EyTEtzSlk1VW9F?=
 =?utf-8?B?blgwRzVaVysxVTZhdFJJb05Ja0diZXhYbFJ2Ry9zMlYwZHlrRGRNQjFBQk9I?=
 =?utf-8?B?UHE1R2hEdythbFNTTVMwWm9pa2VhVmRDaHlkOENVQzJZUHBXV09hOGJBTWNL?=
 =?utf-8?B?Q3hqTy9EUVR3MjJGcGxqdjNBRnpZWjd5Z0xLS29GOFFOeFJCSjlnZVFUWHQw?=
 =?utf-8?B?SlhRWmZOZkJJSXZtOTFOd0dBUHpublRwQmNpU1VJcm84anJhdGZNWjZKR2kz?=
 =?utf-8?B?Q0luQm5oOXc1YmpYUys2MUN4VCs3VktoZ3BGKytlWlBzeVJvUy9lT1YzQVBF?=
 =?utf-8?B?YVRYTkhRV2MwMzZkbENLdVYxc255YjZzM3FId1p1M0Yrd0MzbkkrVW5na0xT?=
 =?utf-8?B?emZaS0s4NTRmM1JCSWhWdDBiSFlMM0UwRUZtbzNkdEpKckRJUkIrRC9ickpk?=
 =?utf-8?B?YlhJM3RaUDBCdTVaZU9MN2p1d0dIeWtLRmZhMjBxL2xjdzZVelFZTTJNQWtm?=
 =?utf-8?B?NGxXUC9JUk9YZzJzVjBBOHp0R21VKzYzcFJ3YnVpQ0lDYm1vSGI3c0tnZTZm?=
 =?utf-8?B?STVMQytoS0tNaFM3WDBDblR4ZE9sR3FXempGT3RtcVA1cnE1QjNtS25QQUlO?=
 =?utf-8?B?Y3EzMm9iMEFNVTR6NFdjbXlLekNBT3ZwL1FzUTZ0NktJZ01BTjlOaGFneXIv?=
 =?utf-8?B?dGhoR05wVXhGSHhiMTR1L1lYbHo1d1JKZDFpbEZGNGdPRmZTSHpWSUJDNlQ3?=
 =?utf-8?B?YS9OQWtqYXlYTXlHdFdITGpGaXlYR3FvOGpPM2JZREpMcDJYQUpYaXI3ZUdx?=
 =?utf-8?B?cGxVZkpibVlpcDd0L1VUWFUxMURaSGxRci9weCt3NkRuSlpvRzEvMEpIclhL?=
 =?utf-8?B?U3ZQeG1uMmRxRE9KZGp4L09mMTM2Slk0dGxIUTdUNVVPWmh1UUJnam5uWVYy?=
 =?utf-8?B?UnpFZEREZEFZZ2MyVEdqUmZnWkpaN20xSm1KUzdxWWhjdEYxblpVL0hJTmZi?=
 =?utf-8?B?U2dFZFlISGFHZlZVeGpWMWRBWkNlMHpVc29GdDBSajB3eFlHdWg4b3MwOWk5?=
 =?utf-8?B?SjB3QlhxdC85US9CRDFxalJLendGWThrSDlGeTRLT05iMStlZzI3YXZGeXVl?=
 =?utf-8?B?MGV1L0liZWpqQUNGOWE5LzBMdlh4RDFPTDVTaHhoTGluR1VIaUluMXlyNW9T?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb8987d-a230-4a50-1fb6-08dc299368e0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:20:27.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm1JmSAAdq7CYVbpXHllZoNth1cDcSUG7p6LzuWKT9Qyl3veCWlhUiM09uI1anSZ4CTzjVeCAL2THGBX+qTG9mORUUFxnE72JS632EqGcDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/9/2024 6:01 AM, Maciej Wieczor-Retman wrote:

...

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 5116ea082d03..f434a6543b4f 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -136,7 +136,9 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
>  int mount_resctrlfs(void);
>  int umount_resctrlfs(void);
>  int validate_bw_report_request(char *bw_report);
> -bool validate_resctrl_feature_request(const char *resource, const char *feature);
> +bool resctrl_resource_exists(const char *resource);
> +bool resctrl_mon_feature_exists(const char *resource, const char *feature);
> +bool resource_info_file_exists(const char *resource, const char *file);

Portion of next patch sneaked in here.

>  bool test_resource_feature_check(const struct resctrl_test *test);
>  char *fgrep(FILE *inf, const char *str);
>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 8a183c73bc23..af4f800ab23d 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -708,20 +708,16 @@ char *fgrep(FILE *inf, const char *str)
>  }
>  
>  /*
> - * validate_resctrl_feature_request - Check if requested feature is valid.
> - * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
> - * @feature:	Required monitor feature (in mon_features file). Can only be
> - *		set for L3_MON. Must be NULL for all other resources.
> + * resctrl_resource_exists - Check if a resource is supported.
> + * @resource:	Resctrl resource (e.g., MB, L3, L2, L3_MON, etc.)
>   *
> - * Return: True if the resource/feature is supported, else false. False is
> + * Return: True if the resource is supported, else false. False is
>   *         also returned if resctrl FS is not mounted.
>   */
> -bool validate_resctrl_feature_request(const char *resource, const char *feature)
> +bool resctrl_resource_exists(const char *resource)
>  {
>  	char res_path[PATH_MAX];
>  	struct stat statbuf;
> -	char *res;
> -	FILE *inf;
>  	int ret;
>  
>  	if (!resource)
> @@ -736,8 +732,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>  	if (stat(res_path, &statbuf))
>  		return false;
>  
> +	return true;
> +}
> +
> +/*
> + * resctrl_mon_feature_exists - Check if requested monitoring feature is valid.
> + * @resource:	Resource that uses the mon_features file. Currently only L3_MON
> + *		is valid.
> + * @feature:	Required monitor feature (in mon_features file).
> + *
> + * Return: True if the feature is supported, else false.
> + */
> +bool resctrl_mon_feature_exists(const char *resource, const char *feature)
> +{
> +	char res_path[PATH_MAX];
> +	char *res;
> +	FILE *inf;
> +
>  	if (!feature)

Now that resource is a new parameter should it be checked also? It is not obvious
why only one parameter is checked.

Reinette

