Return-Path: <linux-kselftest+bounces-10845-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A908D3D98
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C78AAB24D6A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712D181BB1;
	Wed, 29 May 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ4cnefa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826827492;
	Wed, 29 May 2024 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004759; cv=fail; b=ps6/MWnu4zumxYwIm4tWlesnK68DwDMg2DEXGAFPHwRJarLvE+kEnOOu53h158K9/r6+VeQj6Xiz7u5+luZZGJzmf/CY6nFCNhkNN9i3QSUBFglGze2QFt2P6jbA965jd0/GO6+Ya5naoG0mIdDG7i+DnhmFiN1DDzIqjnVar30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004759; c=relaxed/simple;
	bh=nk6svPhe0jAYR1kV/vkU7fRa8AWbFLmzRMqCQjEcZJY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7hCOGpnvsZftxJO0uKI45r96BdhWctJVGwCvvC4pT9FJ4R6Cu/WtMYIOoHs5JZkFWhCMieWqNLAzJ8iEwBZd/eTxGiNoJZMujoCSlbjAkywVCbIN5yxDBvBQ08VVvCNnywyn2rxSddKdDGCQbg+nzRnu7ocfvIp42QddYU3vOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ4cnefa; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004758; x=1748540758;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nk6svPhe0jAYR1kV/vkU7fRa8AWbFLmzRMqCQjEcZJY=;
  b=KJ4cnefaIsmXR6heSZ5vP9DvJ4iFF/szfPFEWRjWz0FkBvbLDTh5wedW
   ZCu85Lea5f/UDx0FeGM3FM1EX4GO5kq+Hz+69Lg11Rvq8lsEVaWoFllTq
   2djHrMIEf2FVJNCmDjrsqhKJUFfxdhoxo7QamTNDxEGw305rJIRD9FTiS
   aHV+lkiGN6tZy2ogypRcpc7hwzE5Lkn6DJ6wnx9wRiy7YCSjOk+4Lao/3
   k6V+qGeaUzTOxShqNPpaP8nzQMwss9Dh9Cs5nBLqi6fuh3PPIjBc5JA6L
   qqtgo/Icb+x3kDT4M47ptrp848tASoWuH2GvB5elNWtpTKzxoGmJ78068
   g==;
X-CSE-ConnectionGUID: 5RQGhPfAT32WfnRl1//2/g==
X-CSE-MsgGUID: m3VlnFocQru0DUc0K5xHig==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="11755360"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="11755360"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:45:57 -0700
X-CSE-ConnectionGUID: +NCc+Zy5TW2DBGOW4QB8oA==
X-CSE-MsgGUID: Nfld6iOERKKK22SNRxj1WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35583449"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:45:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:45:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:45:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:45:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRgwX+Ihc2OC4fDetP1VOvSJqEg+823cueHHO27c7SGvxMVa7OqDW0I8Qhsl2ifDS1JRkzh5x/qkRJtV3p+Yt51UqRfmokUVpeDNF3cmV1esqQfpuw86+YhOXDkp9EJV4Vy4lqaf/hX/waDQhwtQ9tWGfCtkMhIN9rPujQBVBXSidBsj5dUwugURDkQj+V55EyvcCMh92+xSMm8eHKTzGVrQHDAfqC4OAzHaIGbuJtOLNo0qKxySkGZSMbf/yI9AUHgZmkoZWNQ2sAEzGmNabrEW1eXwNONi8HzgQi7T7XCvZBr4qEwUJ/9Q0xED6JHZ4o2XkAKVZWi2xSQjrATFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdla1JVQxaj+dlmQmxYXRJjn64u9zkCYwOQ5x5KM3Yk=;
 b=TrKzKkpT+z/kLqh+C2YXH2S4AcNOlxYh+JuOpldBXK83yKa5TKAvjBUdIS+taoZTI/raIBpdC7mz0DBZhq7LAVuKBbaZouX03ulEhIMV8QsTv9MAsRArIZ1s2hS6yFkJg0QdZoTw0DR29YMRns/4jLyj9WDBudsH+VRMMbfenzqO08rJtuoMP5e1fFy11nC0jvz+ld4PW+/++vZ3ovxSOl3jm7Ja+JueXBEongJCC1vfRN2qbVpm3bjnOWU1yHfV712vJdOL4Pvu/3gdHaUPY6Z4vP//iMf+LVjUH4h16xLGaLHl9KCeaD/WMa/IY8DOOesHZ5g7qmKawZnCuUk6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6446.namprd11.prod.outlook.com (2603:10b6:8:c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:45:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:45:53 +0000
Message-ID: <0aa15270-5de9-4fc9-a459-f1665f8d8624@intel.com>
Date: Wed, 29 May 2024 10:45:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/16] selftests/resctrl: Simplify mem bandwidth file
 code for MBA & MBM tests
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-9-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9ca04e-dab4-48e5-b97f-08dc80072fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0txekNmaGhEMTgzUnNaQ21sMlF1YW9NOVg0dmNuYjVUUTFTZTJOZ1JOZk9M?=
 =?utf-8?B?bWsrL01NUWZzZEI1NWZHamF6anJKTkJxR012TVdab3hFcnp3U0tQR3VEdEh5?=
 =?utf-8?B?eTRNM0Y3T2piK29CL2p5SU9odmswZktOelBUeGY5bk1VNHZ3V1dIdzJHMlBJ?=
 =?utf-8?B?cHRFMUNXTytHbGUyT0pOdUZjTjlJV1VlSDlTR25YS3NpRnFFMjMwNjc3K0NV?=
 =?utf-8?B?VWlqNksvWWhIeWc5c2hWVW9kU3Y0QkV0bnNyNHpORU5sMG4xcTZ5UFZpcG5X?=
 =?utf-8?B?bFFGWXRYU25uYXlWcjFMelNlUU43a1ZlWFJmMXBIY3AvQ3BjTENUL0F1eWQw?=
 =?utf-8?B?NVVZdm9CR0NSV1cwZjNLK21HY0xjODJpQmsrT0lSQlR4VnRjOTRKcXExeW9m?=
 =?utf-8?B?SHlyS2h3aUpKdjY3N1ZZR2lJeUFBbjZ1Z0NnYmdYNWU5cVRLNGRyUW5QNXJx?=
 =?utf-8?B?WkdOTDRoaEhQcHNjQysyZ3pvTTVVMlprQmh2bzdwbVZRN1pNWmV5a3VuZnVU?=
 =?utf-8?B?UnlZZGpEZTY2VjRxc041NHlBaGhnN1JhR3J0V1VxclM2ekNBMnZwMVI2SmM5?=
 =?utf-8?B?bklYR1ROSHJuUEgrSk5jaWkvZ3dHK0ZHMFFiVlpLZjVKb0srbXhjQ2k5NkQ0?=
 =?utf-8?B?QS9CRENmb1Ivd3N1ME8xZVJlTXpXcUdzNUFWeTk1VjJWVUxDRkkzVFZta1F3?=
 =?utf-8?B?cENkaVFlS3hJTUc1ellzK3dSWTlaMjdROFJ1NEk4ZTdURlNDSU84ZlBmVy9J?=
 =?utf-8?B?bFY3b2MrMWVWbHpveTFPbGo5QWQ3RGZ0dytyNXlYMjVsVmh0WjZxcHNFUmxq?=
 =?utf-8?B?U09LY3NjMHZtV1dNVjlHb0hzbW1rNGZXYmZWYlRqQ2hNMURLM1NwSGp0Ymxa?=
 =?utf-8?B?cTM4anUxMHJNcjF3dFRYamcrcWcyc3UraTVMQkEyNzR1a2cwYUIva2F5WU5R?=
 =?utf-8?B?b1dlVHFMWEM3ZGIyN1FCQXBSZHBKNzlmRjdKSU9iVkhYUk5OVWZ4NitnUjdE?=
 =?utf-8?B?QXUxTGVhTDB1ck9UVFlzVmtZbkJQbXdsV0Y5L3R2SVZ6OUE4YU5wZU56cDdZ?=
 =?utf-8?B?YXVvVkFmSFV0N3pENWhtM1VCN0VtN1MwL3E2SnRZa3hOME4vc0tGOXF6Nmc2?=
 =?utf-8?B?WHgyVFIraFJxUDdrQVZCOENuWjJvNXdHQzNBOENzZElRRE4yTThTbjh6UDk2?=
 =?utf-8?B?WDUzdjRkVGhGU09WTXY3SEZWVUh2TExnc3BhUDZSSWhtR0JVenJlSk96UUx6?=
 =?utf-8?B?RkhXaXhpZDZuRHFxS2RjTDJmdHpTOHNSVW41L0hQdmtsZUNSNE5VNEp1Z3ov?=
 =?utf-8?B?bEEweElCL09DdDZ4VlJPRUJzeXpTM2JIVHFZMFFUb015NnZmb0JNQk9qYTJ1?=
 =?utf-8?B?ZTZXci9DQUJocVBYU1JIdndueTYyOWdVWktDWGkvRGNtTzVTQXhCMzlVR0NF?=
 =?utf-8?B?V3VzWmVSSDVEZG9SdGhXVzJYTVdreVVBSUZCY3JnRW5iQXJVZk1XYnA0ODQv?=
 =?utf-8?B?WFMrem5aNzNFUnBYSkoxK3kyYmxKbk5tZzVQWGcrQ3QvaGNScnpFWlRReVVs?=
 =?utf-8?B?MmRzdXpZaktXWmR3ZGMweWZGOXhBTXVXWHlSempCUVBpVGo1N2tpdEk2Y0tx?=
 =?utf-8?B?aFV5V3VQV2hlcEQ1TitZZFZzZVJjV3ZRcVl6cWIwRGlIcmViWHJMZ3pIUFFw?=
 =?utf-8?B?ZTBIUWZ1Y3pXS2swb3pvMWhyR3FMcDlkTUczY2d1VzM0Umg3dm9US3F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxHcXQzRVZ3UG5yNUNJeW04UDVoUEJYK0xmbkM3S2hGeXpSUzZBV0lHUi9T?=
 =?utf-8?B?bWQ0RFlLbk5jVHg3NDA4ZXE5UGpmaGkrWmR3UVdRUjdBU3VWWklSZ2x6U1Ra?=
 =?utf-8?B?WGcwUWVKQWZ5M1lLZi93bjBScXU5cWFNSmNxZjZSOGx6SEVmSVNUTVg1Y3lu?=
 =?utf-8?B?UFNsbGJ1bzFBbWYvMnUxbVBEWUVHbzB3UkxUcHR6TGgxVlJvbjVjOG1lRTBw?=
 =?utf-8?B?RWduQ1V2RnNITkNqN1l4a3RWNWFXeE9YT0Iyc0l0U1RWVXZSY1dqVFFkejhI?=
 =?utf-8?B?V3pOZVB2T3Bva0FCVHF3dmRmYnZXNGtRQnFKV1dNL3JUUHBIVVNFVDdvZXJU?=
 =?utf-8?B?cFlOMy8xcGFiYU1Hb1l1eFlBeUo4RTZWam1XaDJSV2t0MitVWTJhYmQ0SHA0?=
 =?utf-8?B?czNYYXlwUzY0ZWt0cXZCRjBia0xSWkNMRmtRMTh0RlROTEtocXltZXVpWTdr?=
 =?utf-8?B?b1cxWDV4L2R4cWJtTXhwU2JkM3JlWHkrUDVSaGFWalF3ZWVGQmJ0VlMrTWJ0?=
 =?utf-8?B?aWtNZklPejF6MHRxdFk1V05LQ2NvWjAzWW02MUJIRkc4djVkNzh0Qm1PWUxU?=
 =?utf-8?B?dGw2bkpMYzNxQXRxVkJ6SUM4OUVIVTBCTko5WWlLcEVqRzY3SnpMZis5MSti?=
 =?utf-8?B?cW01ZHlLWjRqK3FHTTBtcDh5alByRXgzR2lLVENvTnE0RFBiekVDSmxWcFJp?=
 =?utf-8?B?NzJLZk16dU5EZ3R3MTk2UUtOK29CK3g1WmZDQWdNN1Jwc1RGUWowQ1lKN3hP?=
 =?utf-8?B?Q1NuWTU5ckFqdHd0TjdtZjFpaVp4YlM4N1JXT21GMm83SytCTnZqekttaGtK?=
 =?utf-8?B?cHhKOHkvbVFodzVOczJWaXIwOXEvU2FSbDVldzJOQkYzcXhJbE45ZE96elZ1?=
 =?utf-8?B?Smd4cFJzSThESnZYZU1jYjZLZUJRRVZoV3hHbTgrcVlrSUhUZ1ZrWTBGeTNw?=
 =?utf-8?B?eHg1K2hDVXZOeVpJSVNDT0M3YmNrczZjT080WFhUcXhFNGtYQm81bk1LMURU?=
 =?utf-8?B?NjJGNm5uL0xSeEgvaHExQ1VGWFljaGlKYXhwRXhjZE9XUlo4TkxMS0ExZEI2?=
 =?utf-8?B?RWxyYmxYdENIQlc4ckhLL2d5UE0yY0EzSW4vUTNaSm9haE9TREdMWUV4VnU4?=
 =?utf-8?B?UjVlSXk2Q0QyMm10dlJKQ3IydkFwTEhScElXemc0dXF1aWN3WU9FSU9PS3Zw?=
 =?utf-8?B?VytkMy9SN1cxSjllcVVkMWRDOXdlYURuTXJqV2xsYysyWjllWVFBTWZ3S0xE?=
 =?utf-8?B?dk9wdnEwYVNkb1Rmb0pKc0gzZklqM0sva3NYM0JyVVBseVlXaTFyMjJXUDNK?=
 =?utf-8?B?VEdpVExkWTBhd2JONUF5V3diQi8yKzh3M3lWbW8vdWlIckJqYUR5T2ovS1hD?=
 =?utf-8?B?YWpxN3h5Yk5DYk9neDhQWTVvblJuQi81RDVwTFoxWU9ocENpVDV2SlFTdG5C?=
 =?utf-8?B?TDgzd3VPQmZNR2V6R1J3YUpkcTcra3A5cWFyWVg5K0dlcnZCbU5FOWIvdjc5?=
 =?utf-8?B?L2hHV2YvMForWUlkcklCaFFaemRweCtZTXFFSmRNWVlEd2JuM3lEeHBZOHh2?=
 =?utf-8?B?MmJnL01SZk4rQXdmVlI3SDI0d0V2TzRaSWg1TWgvdU1ZWTVyY0RzRERNUVF5?=
 =?utf-8?B?YWpseHNWVmRHekhBRk5vNStnNTNXQmI5cWdoblhFajhXa3NhaUJsVXhwNEpv?=
 =?utf-8?B?MDRaZWV4OEtjNXlNMnRzeStsVzBvUlpLMUtGb09uQjBrWjZJSGFPcTdVaDV4?=
 =?utf-8?B?T1U1MkhrRVpBVFVHTTNUWi9wbTZnTVlCaUhUcEZKU1VscWJoYlZURkVZemNE?=
 =?utf-8?B?QVNPcDlIbVQzMUFHTEhLbVhjcnl1M0ZDZEtjUEY5MHZua1FObEFQdmY1RnBK?=
 =?utf-8?B?enhMdG9NV2VFempTN3duSm1Jb3lzMTY4b1RIWE92em5rcDFxZVpxaXZKNy8x?=
 =?utf-8?B?bkpSZEpKSVEzb2J1RDE3RFBNazNpQlBYSWNxVDJBVVlGb3RmKzNMSkorekI1?=
 =?utf-8?B?Sk9vcUgxaWNhWUE3QkpIZS9nZlFXRjUxNUMrUU5QTWxJYjMzTzdLb3VFVDZp?=
 =?utf-8?B?SFQvZlZ6N1FUVHFKSHo4dUozalVUY2ZkSDFHL0pEM0dNSTRON2x3SnQydTNM?=
 =?utf-8?B?RkFPTnoxQVc2dEtMMEtxOUhXZnZxL3lMdFRYN3ZxM0VZNUVDcG1wTHQrMmNw?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9ca04e-dab4-48e5-b97f-08dc80072fcf
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:45:53.6396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKEXqbdPtAgJvn5BwcFBl9UsQu1OBiiVZSwE3BTuBnx5D0LXOO48zBUthMAURyrnSjFwe1EG6/8SzG6V8YpIaj0cIp/9b6rBkP/4TP3mmPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6446
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
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
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

fyi ... if the write_bm_pid_to_resctrl() fix in patch #16
was closer to this change it would have made this series easier to
review. That fix is clearly needed here and its omission makes this
patch as well as later patches #14 and #15 harder to review. No
need to rework the series at this point. It is just some comment on
how a simple patch ordering change can make a series easier to
understand.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

