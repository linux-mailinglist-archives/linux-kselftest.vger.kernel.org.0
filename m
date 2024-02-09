Return-Path: <linux-kselftest+bounces-4460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D7C84FAE7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7304B287603
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC337BB19;
	Fri,  9 Feb 2024 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSncgfeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7217BB02;
	Fri,  9 Feb 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499211; cv=fail; b=E4AwyrWVD9noltWEUn9F2zzPzbAyeXSGVQAnnZGthMCAdru0yDRGEMqj4xNYJ5AS69MQmjlhsX2jznAKwnZU2nW3BVIdnDgl2egiH9geDVPrhe+2o6VyBl9TBOS58Q24bcXxyCOgSiaRxH9G3AWZT9jtwc7hGRu+X8csXufydRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499211; c=relaxed/simple;
	bh=W6mEfDOPP63L/+2kuYcjHl4CZfCoKlOYDmlZEz77Y+g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J8MIMym4rpFvIUeQ9UzXRmFjBPrEcl7b6Ryu/mpeR8RiKrsvp53QvWyTLiefSnfk/Q0WfIBepP3GBeepra49AFuhyDVc2q18GLShBGAvdqHZydUH6yxrvXa4qgQc7IyeDrLZisII6m9bc1no1kbOe0M0EMlfUlC48TppeRxpL8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSncgfeQ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707499209; x=1739035209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W6mEfDOPP63L/+2kuYcjHl4CZfCoKlOYDmlZEz77Y+g=;
  b=FSncgfeQt49pu0geuSOQreeC4bC2Iln0Ak84icwfwk8Ycy2MuG27dyRc
   ZkLObE9EYC09NZHPfx5ZaCqZIoVJwgIf5PUP2mFzGkv6nA2H+WIUPa1RC
   O6Fdv7+GohiuBzZJL0EXUX07yf1MWVS9LZJUs+q2VKnWs8DPPXXdgL5vv
   5u9G6fJPwkvOSUr4EeT2+/d/BBJQbofZYuKzHurLeqObBJSk0ZjuDZb+d
   //lhSAL849BtlQZ8B1F4Y/WejoI8tA3yN+HBMvENwVXcquPIjoM1Ye75S
   aKyFqS1Y4zEN5D/W1FbfeUE39imUwQMRCdHZ7HB9SuvvWAVvu9VhM54Mj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1781620"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1781620"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2325519"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 09:20:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 09:20:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 09:20:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 09:20:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur/Z4+BdouwRTYOk4vZAz4fSiOFgYIgrc9RshPoik/Vnx7PXE94SznQVRNi91hJW4+YI2WzRCRY4lscrkEiRnm4lXymK1Fc+MgeN8tvjXuvmvY63eOmQs2TJ1X6+3jr3VZ0MGiix0a5pwzP7DSPpyK+QplasuHVTGCoSP2qPbkHnxCo0Wjhbm89MTQBlVPQTH6U6d5fFCWF2IDWR+03DV+QvSDnIwfXmDbBpjaZL3RoR4iNQQo0XLF8j/25vrMz1I6hjsiOumwVcrEjN0paWUTDSqpmWHUZ7mEmktkI24lpCR6CpobYMallaDnbQzssDa1tblJh7Pff6QWrrO7Llvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUXbnqmYGT/wCHvWrUaKzwHMwiTrQWTI7A753J79dIU=;
 b=gkbskfIYhT+1i12KMXl02pGR+Vfs8YFiyCEa/GO7Jqr+MaqHyTCzTr0L7JWVjO1AUEt0UI78OoiZFfHHwIbuycm51i/tQms7GTuR53wPeARLzlONvUqKxWI700okiY67mDn9aWcRMq7yQ3+qicqM0xHpx8VVANV0yGC2QCTKNdwE5uoYoptz529dZsVlLPaH+gBsWSiq5sKbe8bVTMId8IjDmwVrn3btX+TXXZZGP5nRMtUJylNAMVpGqDbKnyMqWoAQMQ/+U9BlokBcOvEkdYW/3/8SWMrRnmuI0FSATit59wTXuspm/EerdTMse3ui7+CivVAt9qCRuke8ml8nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 17:20:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 17:20:05 +0000
Message-ID: <66714dd6-b590-4ed9-acfd-22d2ef56ae3d@intel.com>
Date: Fri, 9 Feb 2024 09:20:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] selftests/resctrl: Add a helper for the
 non-contiguous test
Content-Language: en-US
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <42246fb33f396267431e8b5432554647179acc27.1707487039.git.maciej.wieczor-retman@intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <42246fb33f396267431e8b5432554647179acc27.1707487039.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
X-MS-Office365-Filtering-Correlation-Id: c98762bd-8534-4af6-7888-08dc29935b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oflb0CvIabKQWgQYwjoMoOo1oYsgpTsJRM9D3o7nTmhIJpulq6JyoysfqaGoLcyEH8x9Ea8DF9D11ViJlSCyqlfEboAu7PNqgUy3S/NIQuuMV/qpdYRS/QRnxUbnJ/1KiTY1Fu130hBeHFXdj8HvYd9z8cwp9aBgwvAB8DV6ubZH6zmWcjbluLIYpWWI2YzHM8OXgA9Bm4R8ebR0JwiWZ4gAy3HMi/GxrTsodHTG18Yonc6TlfYrhHMLkICSxr8iVJimjEDpiNrB9w5m0eF8kGGk0xRTXLt/66sNTzKKAOb6xuKAnK/uNeE+H+HWxi9b8lHQ62zKruxxQPfW7AKBqOmx2dDbdhwIVgXYaHxBXX4LtExG3l7RfK23HeMC3yXYtI8JwAYVjiFpCGHRsMQC68EQFcmdVihK/tZtWUEc7R2vRV/FRdOS8boMMqoRwAruzQH3+EwXFgVYKMuoVZlQ+Vm697dwnvEBiLiBOxewDhEvgch3QfEBrCabEllXd8xyuktn73U9K4CBH9brOO9rjiKLqHHyuOPWV17uJVHoASrxp+09i5EvDaGdVoa1o4+z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(82960400001)(31696002)(38100700002)(31686004)(41300700001)(2906002)(4744005)(6512007)(316002)(6486002)(478600001)(6666004)(26005)(6506007)(53546011)(2616005)(36756003)(4326008)(8676002)(8936002)(6636002)(5660300002)(66556008)(66946007)(66476007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZJeTN1a0RSYSs5WE9XRFB4U3BBc09VMU1vVE9PUmtwd2wzeldGZCtzSkxp?=
 =?utf-8?B?NnIzNVU1bUQ2d01zcW1hRlRMUW9TbjBLUmJnb2VnaWwxdjlLVjJmR3FWSW1r?=
 =?utf-8?B?UW1vZ045Yno5bWZKZk40TnVLOXhlRHNnR0pHZ0Rhb2pDMWVuV3Z1VE5KWndR?=
 =?utf-8?B?d2dKTmtpRTR4OENoRzBMSWhWWDRLelBSWVJKdENaSkh6TFlNSTVWZnozVy9w?=
 =?utf-8?B?Yk9lYTNJV0h4em9OTVoyd05KWXNEZzhlZHhVRTJWYTI0N1B4Y2JKUDN0UG04?=
 =?utf-8?B?WUJPYjA5RWtnMkFnWXhkYm01WG9tMHVtcnVRenlCWDFJV1NjNW5reEt6a0Ix?=
 =?utf-8?B?NVMweTlaVHNEMUR1VUl4Tnh1M1ExbS9BR2lDN2FJdmRKelFwSUdqWTJPR3VW?=
 =?utf-8?B?RHRWVnNUTC9pbVE0TVRDaFRxd1lBN3Q3UmQrZUlwK0ZpMEtUdzJpNUQ5ME9I?=
 =?utf-8?B?RWRpT0dVMnFQei8yS3R6dmRLeWVYdXlVRzQzVTlWZkx6d3VhYkJaR2s2eVZL?=
 =?utf-8?B?Y0R1U3RCaUNwNkwwRTM5Y2hyTmt4a0JadytBUXBoeHNMV0RzMnBxTVJCbUp1?=
 =?utf-8?B?ek9HR0ZPb1dPbGVXdDdDOHBramEzekgvTWMwTkpZK0dFdy9ZWFhwYjlwMzV2?=
 =?utf-8?B?b0N5SmQ3SWlGbVZnWTlvai9SVStQVEtoazFaeUNOdURnalBVSHpiTmdZTUlZ?=
 =?utf-8?B?Nk5sZTFNc3BRQXdmMWZKbGg1R3M3SjAyOWZndlFLb0k0YjdDM3BZZE52MG1Y?=
 =?utf-8?B?eVlMc3VXSWNXTDQvN0FIVlpJM3F4OTdnbUtvdG5INFIyWkpYMjlJREI0SzNZ?=
 =?utf-8?B?eHNsNWxLTGFkUmc4akg0RGIza00vbHpyNURGTUNvRXZiSU9MMVFuVk5CRkJL?=
 =?utf-8?B?cS8vZVlCT0pPVUs4QnVNeUh1cUFYWEF4VG85MFRHTkc4RXpONGpESVFaVStX?=
 =?utf-8?B?SU5DUzRvQ2JseUQxNjJlMlJWbHZzMHhCcHJRS05EOUsraDF0K2QvRWN3eGhF?=
 =?utf-8?B?ZG1OVDd0UGFIbEJOSHlNeXQzdnNrbk5CZWwzZ1c2Z1czSG9UalBWdWNBakI2?=
 =?utf-8?B?enV0cUlhME5CRXFwUnNKRHlieGx5VkZDRGVyNUozODMzUVdzTTZHYnlXNVZq?=
 =?utf-8?B?SkVENlBhSnZXTmpZUkg0RkFNdGc2bXNseEFVS2dCNHB0b0c3bk9WaFVHbVVy?=
 =?utf-8?B?aS82RjMyK2JpN01jWHYydkJkNldmN2VtZDdjRGVPZTR5NE1GdVMxSTZNeFU5?=
 =?utf-8?B?QmVIOStxVmZzY2MrZElGekpRaXIyQmRidnkwOFhoT3U4VUJFTkNyQ1NDUEov?=
 =?utf-8?B?aXFvaHpxbFlYM2VOQ3hVZlpodC9UUnBuRDQ4Z2RWZ085QXZueWNmNmVjaTBL?=
 =?utf-8?B?RzVkWmFqOUhob1B2YjlqUm1taTNOMWpLeW8vVG41aGM1WklDMm5wais1MmNC?=
 =?utf-8?B?dFlpRlVNc3BmUm96V2phb1lmQ2c5UGYxRHg5Wm1XeVlLMm1QM05kUjVqdHVu?=
 =?utf-8?B?WlArQzVCVlFqTU9WRktPQm9RNlpZZlRkbk9ndVNhdXYrYjVyTlBIS3lBQWFX?=
 =?utf-8?B?aDZPanhIdDFxQWg3WHRTUnU4M0dPZEUvYWVNU0Z4RXlBdnNHVWk3OVhWTjVq?=
 =?utf-8?B?RGF3c3dmMzgxVkU2K3RmbjJPd255WHFZV2hOUnJ2N1ZPRlUwanhHeVU5UnE0?=
 =?utf-8?B?NHpqY2tlTWExYlNhYnVsOW9GU3ZtRmR0NVZiYk1FYnQ0b1Z2dk5rKzN4UWx2?=
 =?utf-8?B?T3FwbzZvSEo4REV3K1hFR0t1QXN2V0xOQ0VoZlluTVdxTk9SZ1ZSRzJRaHlS?=
 =?utf-8?B?Skl3a2gzSWFtOVdKYkJEOHF6NDZCS2ZHUWRwTkFMOGdSaXUybWR6bDZrUDc0?=
 =?utf-8?B?NXFIQUJLYS9rMzZWbTRqQ3NBcy9rMlJvSVlyUHg3czk3bmdlb3JDSmxiajN1?=
 =?utf-8?B?bGNrUnBHTmoxM2gvYkFvMktDNDFhaXpGS1dpNmZjTVkwMW5zM21pVTczMFJ0?=
 =?utf-8?B?RHBId3NiM3BubEhRZVRZMjU4eE9BOXJVTXVCQVNtTEd3K2NrRkd5c3ZXMFp3?=
 =?utf-8?B?LzRMZlBhNlYya043YndFMm5la0RPb3ZyRWFoQkFSVC9leTJ3UVY5RjVtN0dN?=
 =?utf-8?B?M3NVSUNmY0dPWGdoQXpBVTd1MFUzUUVuZHNOaTRmeUVBR0Uzdm1uQ3ZaZ1VY?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c98762bd-8534-4af6-7888-08dc29935b5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 17:20:05.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuPl+5wGNo7jOfrZhGesz/iqQsUDb/BB9Cu8U/zpTKyhoBHVJyAchf9M3BZD/Bl7vKQ+9LHezvv5AQ7cPW+8jdq0hCzA/129Q1u36MGcNCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com

Hi Maciej,

On 2/9/2024 6:01 AM, Maciej Wieczor-Retman wrote:
> The CAT non-contiguous selftests have to read the file responsible for
> reporting support of non-contiguous CBMs in kernel (resctrl). Then the
> test compares if that information matches what is reported by CPUID
> output.
> 
> Add a generic helper function to read an unsigned number from
> /sys/fs/resctrl/info/<RESOURCE>/<FILE>.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

