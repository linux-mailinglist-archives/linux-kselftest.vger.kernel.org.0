Return-Path: <linux-kselftest+bounces-16110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFAA95BBEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 18:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8241C2192C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF11CCED8;
	Thu, 22 Aug 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcbobesO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC41CCEC2;
	Thu, 22 Aug 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344068; cv=fail; b=dEhjIEUHwaT8RBc898vDV6a2eFcWcIonCfrQDOoOa4qPYXUuj8mBApKGZPK4XTLpidfJWkYHGS4vd3QWt/M2QXMoOOOQhN+0DwCoEIIR3K5bv+x6W8N14/HRFLYvNWyQoCh8iymFHTy1Nwawg886tjzH+VjHRiHTjxdj4yM2tJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344068; c=relaxed/simple;
	bh=qm3CM7UDuz3nswBIz2Ij7u+xD/3XvexSq8ul42XMPpI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMFbWy+mcwFJHSUmfpcNIxO7Ho80VcRosLJbqTMf+JEj07lqLLo0BZanma7sTO3vigwoTQIGJZncmjwzFCS37EJNFjn8HJ/5rjNWu2fGa5Mr4YO+6R4e0ugd5b08iaD/rpSQe2u+6AafDo2y0XfrhDYbTqK6I7X3w7LmJNKSIW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcbobesO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724344068; x=1755880068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qm3CM7UDuz3nswBIz2Ij7u+xD/3XvexSq8ul42XMPpI=;
  b=lcbobesO7G2xOKWxd3n00Ny7e/u0bs8AkfgN3jp9bNJob3OwOdOD0Vua
   zf7WyO1wkJ0PnmOzICT6K15lZP09oPWDZF0y3MmKl18lU4WURtRf3zGqb
   Ik8s+Vn44xZcXsANWUZCW9id9v8OSWozcK+FwEXu3q7PsICjHhNlDswvV
   JF7mFG/HS7tkXRfXaQbma4codNpEVHk86SFdHsXKPmajnWe11BW80vNqM
   LBnQnCdta4MSMks4d0SjDlYamaBZYryvJ6MMy74aufX2U0WvX+6zNwBM6
   Lm+DuO92npV7HXERasiR2Klxp1N4TQEaht0ROaPQ4G1ejY+f0FtB8RXns
   w==;
X-CSE-ConnectionGUID: WGvBmcaIROiG7l7Z6jPVAQ==
X-CSE-MsgGUID: GOaseHG6Qm2cBqpae5Nwwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40240097"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40240097"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:27:47 -0700
X-CSE-ConnectionGUID: LLzuF2DbTaCum22CiClDwA==
X-CSE-MsgGUID: lnqJ9yoQQyKRlwjMb6hL3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="84684904"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 09:27:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 09:27:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 09:27:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 09:27:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLodLc7eMrzfMSwg1S3n03MgmWa+KHXWwD21LzLg6SJhhKnqVci0URgZELE3ZLNu5BUe6zOSeIaCvZOZDb4yE0HcWNA3qhQOGrhRJDrOBsSLN71GpYJARXQlCcE0GwXMWb1q003voVVSG6NPeEQ+6Qa8OoGhk1NDYT9Md6boNx1qh54HHTD65zMWQRt4zoWJKcaSAYILANycXndL06FOA81wMZEwwzYu9QjxIsA0DBawYUUGm5PN3pWF8ZskR25hCtdHE202A1h2/aGsYu1ISEyxxvIQJHwZfpf3TZTQSD947JCMkM6r5YIVhZAfux8F3+5vC6MDF5r3Fjbc9zULMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+0lwDvIuVofaKyZKfwL+PFPHVisDEhYMSPGujnmeCQ=;
 b=YpW9+r6XAjbZWfX566bt1cXuNhibizSR7Pueka1ax64FR9HXVCAXCrODQmDZi7YbvzyowIulfJI0KLO/27Ye5sg6JrNGCx4Od91+Q8UtHOyyjnivwObxjJH0qHPAv92GwJIh4x0KDLdurV39N9Jiy2xOUD20qjkYmRoLlTMZc3wQytbI93al5w2i5yRU+BYlk3JbIN8to3FznUbjRb4jWj/OSOBYai4Wkml/xfiq0MLviGsyj7p7pzZJ8WC+9UWq1YTUDmZMp9Vhr+QUsDCSUzX6UcVN2rJGU22DnxmmA0SnUk7PySmOPRfUMnA7OZDSb6EzbKpI/cF9OZ953unKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 16:27:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 16:27:43 +0000
Message-ID: <cd09f5e0-2353-4223-b02c-aa8461c1dbe5@intel.com>
Date: Thu, 22 Aug 2024 09:27:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kselftest: Provide __cpuid_count() stub on non-x86
 archs
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
 <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240822081114.4695-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7ca31e-39b5-4c50-e1f8-08dcc2c75944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q011bkFkeE4zT002YmEyenNxOHlFSEM5MEh6MGI1eDBxYUF6QTF3aWhDUUpU?=
 =?utf-8?B?eWIxRDZTV0p2T25vRlB2V2VCcERUS3FSSW5WeUFFaThFMzNLWHJxY3RCMkdB?=
 =?utf-8?B?V0FIZTNkSjNUYy9OT0MvRDlKLzRIYXBIMUlWVmtzQ3lCWDA1dml2MktmN2pS?=
 =?utf-8?B?TmlJbWJGcWNlNDdCZXdXRWdKVENxbHhYaGtHN2NKbzhDVTQ4UkZKUXloY1h6?=
 =?utf-8?B?NjhTbDUveU5rK1l1eXovczBzM3RkTG5aNUlyWEJKZnhXcm5LSkxGT21OaFVG?=
 =?utf-8?B?TzFpRmpDQXU5ZXBQdzFITk9nVkNoYkkzZlIyYWdraEQwSXpiYkdvR1ljY1Jo?=
 =?utf-8?B?S3RzM0o5d2tOTjZwS3Qza3Axa0tEQ0Nab0FWbDQvbjFDNWo2V1ZIRDZsTjFX?=
 =?utf-8?B?UDBIRC9IVWgrS2pxQTczek1tbk43NUJ0bS9FcUxCd21WditpOC94NUNYd1FC?=
 =?utf-8?B?d2x3SENjRWYrcE9IUWNlVmVPeHN5cmFHdWIweUdoYlNaeHlNYmtTZW5MdGhK?=
 =?utf-8?B?Ry9LYmZFUXBNTVA2UE1aTE9lV1puRk0vKzlhSEVDVmxMZTZqLzIrRG5YL0Zn?=
 =?utf-8?B?N1JCWUlhTCtkVUNUbkNGK3pncEo1OVk1K2dVMjd3bHk4VHZOWXhWZy82VVJ5?=
 =?utf-8?B?dVNoQXF3M3ZKL2FSWUhMa0ZoNUVCRG05ZEtPWk5CRFpZVDcrSTdidG9KcllC?=
 =?utf-8?B?VDNsM0JtVzhqYzlWNmlXWXkrOW5IYnI0ckE4bys2ZFJDZzZQY0I4aEVCV1p1?=
 =?utf-8?B?YTZmT1hKWUlBOHdHVjFydDkvNnZsVk0rb2h2dUtycSttSTRLaWV2aWRCcmRi?=
 =?utf-8?B?cjUxZk9BdDBESjVuOVgybXlpRjB3V2wzbml5L3Z5c0FQc081RlpwSThIdFh1?=
 =?utf-8?B?aE9vbzB4QXNrWm84dzVybzhXZkp5ZkI5WUkzREloalhXZ0QwNm8weEVzdUsr?=
 =?utf-8?B?NXJxdVVjTWwxazRqZzkyaWxuWmQwTTBZSkJOQ2dtNURJazZWQmg1L0I5VmJn?=
 =?utf-8?B?RTl3WGhIUjdGM3NhOG11QjFVV1QwZklRSFRNTmhsdXlZQzhzcTlvRGZodWho?=
 =?utf-8?B?T3lkSFhma3MxVFluYW80eWhxOTJUUERaUUs0Y1llMmpnT202ak1QYnd4VytX?=
 =?utf-8?B?cXVlcGlOOTZhMjJGVHMvcllteElsNERtMEY5WXpvSFBscW92ckRsM0ZOMEo4?=
 =?utf-8?B?eEJiZzJ3Tlcwd08xbXV1YUlXVXlRR2x3MFV4eU9sQi9ta1ByNnBtaG1OTHhu?=
 =?utf-8?B?ZVJaWS9ZUjBzRHBkTUllOTcvVUJ0UWViNThTK3N3WjNBRlVHaGdvWUZPWnIv?=
 =?utf-8?B?c0twVENxV05PSy8yL2R5WHFqUStNeHJGYm9qM2Y0SEtDNlFNR3ZzeUhpajJX?=
 =?utf-8?B?bFV1VUhDamFoR3lrcTFhSm9hNko0Lzg1ekRVakFUTS9LNVNiM0lTWkcxR0Za?=
 =?utf-8?B?VHdCYnc5OUZpNzV3a2tJZnVkVzl3cTdOMlZlSXhZRjlCdyt5Sk9yWWxpanNF?=
 =?utf-8?B?T2pYVDJlWWcwS2VFMXphVVFmUnJTTloxb0IvR2hFQjlhalZhb0VqWmI0WFlq?=
 =?utf-8?B?ZCtZVVFtVXhndWJiZ0ZIV1c0YmJZa2x1anRESFd1bDAzaTBHR1p0UE1meDVP?=
 =?utf-8?B?NWlpUmdOdmFCQzFCQzNNVzIrNyt3TTYzVERFY3FiaDIrTjdTbUtVemYveklY?=
 =?utf-8?B?K3lEYWFKSWV4WklJNHNKU2NBMWxLTEtQemtCVlFKcG1wZTlOUGdrRm0vcjhQ?=
 =?utf-8?Q?z+FSr6xQsuLQcnaGfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U00yTXVpSWNIS1B3U08wYTUzeG1LaHAxdTRpQUZDK2E1Tkp2azEwTmpWSjZa?=
 =?utf-8?B?dEZmc3hGb3Bud0d0RExtRTRzWnJYS1REdWtpMW9kaDlRTEtHNHpJajRta09W?=
 =?utf-8?B?Q0FuVlY1akpLY2Z4TGptWEJwd0FQeUd6OSswWTYvVVNkNWdGRllVQ0lqTUJo?=
 =?utf-8?B?S3pVaE1yK09qeHdBVEFPbG50N3NLN0o4cTNHRUVqeVAxRWVkaVZGNlVMU2NF?=
 =?utf-8?B?MFlrZ3pBRVo4ZDhUUkFyWWQ0TG9NMW1KaDF0Y0ZzVnJJQnVteUUrRXR3YTR2?=
 =?utf-8?B?VmpFNEl1NytVaHJkN0Z5RUdrVENmYWI1TDRQbWdKYlNQdXJjc1AwM0pnb0tV?=
 =?utf-8?B?Uy9LK1lLWnBPUU1hTVFTZHFXSFovZE5Sd3N2RTFMK1VMYXd3ODVRQXBsNHNO?=
 =?utf-8?B?d0FmWFZvTmkvOFI4UHdEc05rVGVsWVh4WHJPc1ZwQk1VNXJrTHRWY3RmazZu?=
 =?utf-8?B?RkVxMEQzcWRPWkU2ZjJVY2Jhb3JjeDZJS2paQXBldDRtYnNOZmJ6cUs4UEFR?=
 =?utf-8?B?WjdoUEdCMUZtcEVjYTJRemVOcUtsRndtd1dVUkUrZUVRNGM2Yjloamt6Q3Rq?=
 =?utf-8?B?UDR2OWhZTis2Qk5HL0hZMy9wSkpaSktzTC83TW5DMGZybEJFZ1dOMUxWUUhD?=
 =?utf-8?B?ck1DR0lXTm9DNVhWQ2I2a204ZkhlRlpqazNzQTBzczdlSmRGUGZZNk1FeUha?=
 =?utf-8?B?UDhiRnZnV2Y2b3FRc3JSRnA5YkNwSi9henRaakpIRXA0SllGVnMwS05oVFc0?=
 =?utf-8?B?V2pHT2RnNXBBVmwvR0FNcHAxSFBWaFlXdWxSQklqYmdTdWNKUXZJQ2VhajJK?=
 =?utf-8?B?QlZzNnAvWDRCcXBDSHBDajdpcWtBOUlkWjR0ZjJ3elVYeXRtYmZ0dCtNUFY4?=
 =?utf-8?B?SDdXS0VWdWJoNEw4bmZGM3pMRHgwRmNpUHhjVUFKM1A0QUdWaFA4N25VV09T?=
 =?utf-8?B?d1FZVy9va1FPUUJYNUhZTnU4V0M5NWNxTm5yeG5NcHB3TU01Q1BOa2NMdW9I?=
 =?utf-8?B?QjNtbkVMM09meFZHVzdMbWpuQXV6d1RCN0RQNHc2bkNxVmh4MGxXTi9IUUVR?=
 =?utf-8?B?bXZFcHVPS2R6ZkdQSmd4THBSQUpKc1ZrcmsyYm9nWlVXbVFtZW9xbFdIQ0FT?=
 =?utf-8?B?UWJJQWNiWGUwMm9PQ3VrNnpFcnNOZ2VTaTlwQkdzaHNxZzlpTGNkQUdsQ0s2?=
 =?utf-8?B?R0tWcDM2WC8yTHp2Z2w2eWVXZ3d1NlpERXNQUXNMYlFFUkJUT0tWQ2lNbGhj?=
 =?utf-8?B?NmY4QjNBdXBaMzdHcVVOdEcwd3VyZUp0eFpSdDFxbWc5UitwakgrNXJaK3BG?=
 =?utf-8?B?NVNocXRWSUxsRnMzME5aWmZ0QlJLWnh6NC81Y2hHTFV4cTFXY0NuVFNGV21y?=
 =?utf-8?B?QjMxejROV0dlRXpGNlZIbHRIcmo3aUJaV0M3aGJsUVd5ekRUc1dFN1FZTDgw?=
 =?utf-8?B?c2tEdE82YnNjZ1EwYktrZjhBRG11N0dlVXM2b3FrV1lBZE1leHRqUmU0WWY0?=
 =?utf-8?B?Ri8vYUkxRkF6Y1VWOWFIZm12dEpMS0xtT1ozTnhpbGJ5eTR4d2lIVWRHSGtr?=
 =?utf-8?B?RURtYUV4K1M4WTRsK2RCbjZWT2t3NHFXaDFaT3o5M1FpR0JqbGRQVnlZYThu?=
 =?utf-8?B?WDc4QzFjVjRTNUh1V0lBS3Z1K0haTjRCaElkMjIrVGtLU051UWF4UC96Nkt4?=
 =?utf-8?B?M2dPUzF4cHRIek9jaWZzOEJBNzUwY29zLzE0VFhZeEJ1T1UvcEVRQVhCbzVV?=
 =?utf-8?B?ZHYrZ21wem5IZndWQ0pXaklyaEdLQlZSWmJ0TlcwR3dPT1krTDJRaDV2WVlr?=
 =?utf-8?B?Z2xxWTg5T0JFRUFWTEpoRXJhcmhVVU90dWhqK3JqU3NWcm9qc0o5ajA1Smwr?=
 =?utf-8?B?OFhpOGFpd3ZMSmpQSUZtOGFaMlB5K1p2ZnUrZjdwVGRpem9PUHg2MjdLTXZP?=
 =?utf-8?B?K0w4UUlFazJNMFJoN3V5WjFWNFhFTWtTSTJNK1ZXalpjb0hIU2xuSmdNZ29n?=
 =?utf-8?B?ZVdwYXJ6WWc2Z05lVnRvM3pmR0g0TmFrdFNjdmpZWjVnOFRkWXlOWldNU2N6?=
 =?utf-8?B?dFVnNkdZZFFpYUhtTUdFSmNuNHBJNmZPSFdQZkpXNncrOWhDdngwRlBEdi9C?=
 =?utf-8?B?Q0xaVjNTYVF3Tmo4bFBkSm92UmhDTmJXbTBWVGhJQmN6eXRFcWJQd1hzRzZM?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7ca31e-39b5-4c50-e1f8-08dcc2c75944
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:27:43.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqZGtR5qkywF48ekPF+rR8IBq97SzfJ09fKx/l5a4CJ3mxhK+3nnZs0v107ubqUB1whuvbWQmQj8xmvpDCY+VuIp5gg9rj8igRf0Gqrsa1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/22/24 1:11 AM, Ilpo Järvinen wrote:
> Building resctrl selftest fails on ARM because it uses __cpuid_count()
> that fails the build with error:
> 
>    CC       resctrl_tests
> In file included from resctrl.h:24,
>                   from cat_test.c:11:
> In function 'arch_supports_noncont_cat',
>      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>     74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>        |         ^~~~~~~
> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>        |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>     74 |         __asm__ __volatile__ ("cpuid\n\t"       \
>        |         ^~~~~~~
> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>        |                 ^~~~~~~~~~~~~
> 
> The resctrl selftest would run that code only on Intel CPUs but
> as is, the code cannot be build at all.
> 
> Provide an empty stub for __cpuid_count() if it is not supported to
> allow build to succeed. The stub casts its arguments to void to avoid
> causing variable unused warnings.
> 
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> 
> v2:
> - Removed RFC & added Fixes and Tested-by
> - Fixed the error message's line splits
> - Noted down the reason for void casts in the stub
> ---
>   tools/testing/selftests/kselftest.h | 6 ++++++
>   tools/testing/selftests/lib.mk      | 4 ++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index b8967b6e29d5..71593add1b39 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -70,10 +70,16 @@
>    * have __cpuid_count().
>    */
>   #ifndef __cpuid_count
> +#ifdef HAVE_CPUID
>   #define __cpuid_count(level, count, a, b, c, d)				\
>   	__asm__ __volatile__ ("cpuid\n\t"				\
>   			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>   			      : "0" (level), "2" (count))
> +#else
> +#define __cpuid_count(level, count, a, b, c, d)	do {			\
> +	(void)a; (void)b; (void)c; (void)d;				\

The changelog states that this casting to void is done to avoid unused variable warnings.
It is thus unexpected that not all parameters obtain the same casting treatment. It looks
to me as though this only targets the resctrl selftest usage where the "level" and "count"
parameters are constants. This is intended as a general kselftest solution so I believe
that all parameters would need this casting to handle the cases where "level" and/or
"count" are variables.

> +} while (0)
> +#endif
>   #endif
>   
>   /* define kselftest exit codes */
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index d6edcfcb5be8..236db9b24037 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -199,6 +199,10 @@ clean: $(if $(TEST_GEN_MODS_DIR),clean_mods_dir)
>   # Build with _GNU_SOURCE by default
>   CFLAGS += -D_GNU_SOURCE=
>   
> +ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> +CFLAGS += -DHAVE_CPUID=
> +endif

My earlier comment [1] when this work started remains. This technique depends
on environment passing ARCH, which cannot be guaranteed. Looking at other
usages of ARCH in the kselftest Makefiles it seems that the pattern is to
initialize ARCH with "uname -m" if unset.

> +
>   # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
>   # make USERCFLAGS=-Werror USERLDFLAGS=-static
>   CFLAGS += $(USERCFLAGS)

Reinette

[1] https://lore.kernel.org/lkml/db16db55-5f68-484f-ba9f-3312b41bf426@intel.com/

