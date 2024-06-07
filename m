Return-Path: <linux-kselftest+bounces-11428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4F900B90
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 19:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3666B22968
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 17:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ADB4317B;
	Fri,  7 Jun 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEclRyKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325C1C33;
	Fri,  7 Jun 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782884; cv=fail; b=R25nfuJXEHqRK1TU8zSjinUgI+IOC8mJ2W20/hNG4nk8UmiG8MprC644ouxz/AzNGOYBqgb9zAgW0Ls9hniqehcczCqONECiugbaoIoFaWKLF+BI+XHz2EB9XqLlN8uhWz/5I7Xdbh7dv0/D8fdKXAeYG4KzKD6D0x+18nt8zIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782884; c=relaxed/simple;
	bh=R9eJPwKeqvNFTBMHEPQ7Ubu93UWNx78RzwxDAtmLzTU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ty313ontzjZ38Zu/OemPVia1rZ8U+KGLz7X7Xy8AhI7jYclhRA2J4Q5kQ6eYgzj+xJyWdYcbDgdiDlAhFtBHGQlGJFXOu7busaOPlrRzRgGfjLGmQSFx4/XBaLJ1gtuS8Zwx1hKrbMt4xGNoJESzF1rsPLUGkHxx2x3VJK6nhyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEclRyKN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717782882; x=1749318882;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R9eJPwKeqvNFTBMHEPQ7Ubu93UWNx78RzwxDAtmLzTU=;
  b=HEclRyKNBEv1K9MgxBUhgpc20as5DPe+pZVf5uJwRNUftk0R6LY43j26
   yMWQ37+EfBKvPsS9b65oezp03JHEKNkaWl3mH8q6/0/Vw1EY0XcubZn01
   7Z3/n4NpZ9lQ5LULjXCrEoVbuh2g5B79V0G4pnI1qR3N/YkikMUDAHaxQ
   r5z7yPRzMgQzqzhP9Yr1A9AMxor36Gf/AAKWRvw2hvd6P4BrvH1nbtEz4
   eZlZeblkrGvrJGqqNEuP11wfOC32n5lLbIMweAMpTO+HdKToEC5lWlpYC
   9Xis69CYyHVg5RLx1lwe/g3Wwg1kXroRd2Gh247+sUJshZH/NnXxktro6
   Q==;
X-CSE-ConnectionGUID: +J4K5+JESX6G0UaVBiuRXw==
X-CSE-MsgGUID: B5tZRurvTjSr4KqJq6BLJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14399486"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14399486"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 10:54:42 -0700
X-CSE-ConnectionGUID: K3C4Cq98SV+d7qSuPFatKA==
X-CSE-MsgGUID: qvRYD65mRiKRFjwuLs4iaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="42841377"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jun 2024 10:54:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 7 Jun 2024 10:54:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 7 Jun 2024 10:54:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 10:54:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKpHBMrZb81th5IOlmuIw9DOxzX1tyQNsHMMK4b/MUyY6k9be36CqvHcmVgAU+YFmhUYa637fBKwah2CHiA0H4u0PAZFgfoGaV2rMzg6KdnNeZE3HljxIj32M2uFHrFSBpEq4tuzUCKB0t84vmlt6I/2D4ZmWzKU2XvegzhPXqhu0/lshNu5/dVDG6u57S/o1q747k86xaNwQn9GN7om18c9KvN2cHLh5b3D2M79NcKV6Erk8yRKZwLqsSvyuekKilBf3VYJ+UWLga67GMrvuFb1vBjRJRAroRnjFrXj0OdGAeb8EW4Wg1MZ1wx02Zx58KG3n75gaK3PQ6VpZDr4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue75ID+2OhdTRuMVQGN19ozn+50evrIoL1vr4cWb72w=;
 b=WrBcHnHOHkj7g19mtZuJVqSMQZRiX10Y27K3/SxeydlWCX+rYUl73vuWue/8cVZRSVgzAelK5hd447Ggx2DSrWS6nBf3gTnhUMJKvKHe/3N0Zy0M3YsjrKX8Kf+LlheLatcxCcytylTJsF8fPHkG6JGhxn/w3dIgZcgMfU3GUWwsFtLQ4pez8Gu/+MM+QKY2K5S0R4Oads0ofpez0IsajZzuXqJxMGK5T4UAOz9/l5MsCTjWQ3aF/NYX3ACFdqU1MF3w9DcpT6vnhGYW/96SEH+95KmGbfP6Uc6oxH1FONxwK2ZmNMWZL9rYN3+AidcmUihMYNKPuUTCDnwfNA+/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 17:54:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 7 Jun 2024
 17:54:38 +0000
Message-ID: <3d6587a4-3e39-449b-a108-9f6893d4a405@intel.com>
Date: Fri, 7 Jun 2024 10:54:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Babu Moger <babu.moger@amd.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240607125316.7089-1-ilpo.jarvinen@linux.intel.com>
 <20240607125316.7089-3-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240607125316.7089-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: b1669384-a11e-4c94-4c59-08dc871ae662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUNuakxHN2ZsVktJUmN6WGdyaTh0WitpeUM5OXJYZHYyWHJBejgzME1FVUIv?=
 =?utf-8?B?dzgvVlRqcUFtSEZTNWtKNHdQUUE3M0hILy80QUd0Rkp5aUpoc0xHeThxdi9S?=
 =?utf-8?B?akdrWjhZd0hVbG9jdmRWaktLb1Zra08rWTgwMXR4SE9FRkRmSkQxT01DZVlv?=
 =?utf-8?B?djZBdGpCakVjQVdFdFVhL25FY0llOGIyT244VUNhTVFzeXIzRjBtQzQzdDd6?=
 =?utf-8?B?Y3lrMG8rVzBSeVZpd1RycU5XSU0wZlpHZndwM2dNVlFXa2EyK1l1VEdGMXRk?=
 =?utf-8?B?QUZOYU55dElsK1FUU0QxbzRLVUYyWC9jQ1ZDT2I3clBBTk1kdUpWSE5KK0hX?=
 =?utf-8?B?Zkk0QVN5dDlWUnRtU01GUVdWbmpVNmMwZDhXZXNuZXFuVG9IT3k5bERxNU9P?=
 =?utf-8?B?N0NET3R5eHUydDZ2NzdQcVRrZ1VWNndUaXRuSzB0aXZEV0Z5RXZWbWE1R1I2?=
 =?utf-8?B?MXNZTGlPRU5pSUUzKy9xeTJHRFJQR2psOHFFZGZJQTlpNGVtQkFxbXgzMmZX?=
 =?utf-8?B?QWFNWEx4U05KVytQSFhTSDJ2RVpqYSs3MWdhcnVyUnBPOVVWK0ZCNUt4QkR3?=
 =?utf-8?B?alVTYWFyZVUwUlVrM1lCbzkzSUdqYkZKdVN4Sy8rbzl1SDd5MW9FSnZpbnVN?=
 =?utf-8?B?NmxyekhKYXZHZ29PNTNrdWQzZTNwZWcrWEFta2ZVTDR3REd2THRKNTFNS1lq?=
 =?utf-8?B?cktPQTRQOUk3SWpRTGdBNGZSZUhnTkpNZXNCOG5DRVk1bmxzd0xaUHZBN2V1?=
 =?utf-8?B?dzJUTzJUcjJTcGcyeTdvSHVyUHc0bkJsejVkazFmTEVyTG1vQkhtNHltdGJr?=
 =?utf-8?B?QlkyY05jUDlCcWd0a3JQSC9DRm5NOExvbmdnbTNnV09pRkhBcmt1bEVldU9V?=
 =?utf-8?B?QWJ6R1E0RVo1eEVkeXc3NElVYjNQWGdMU01RQVl0eHhqRWJ4SWk4VkpRNFBx?=
 =?utf-8?B?Yk5OdFVEaHkzK09UZ3lWTE8zK0xuQXZwUzE3aEpOMXBBUklaakxUbUZYaUZI?=
 =?utf-8?B?YUViRTAralI5NENRVngxVUcvSndySzB3bWhycGpCeUJ2M0EvSFc0dDQ4U1p4?=
 =?utf-8?B?WkVERTg5cC9CNS9lSlVLTDFCeWZpYkU1STJKc2RYZDc4SVhGc2srZnVZbGdK?=
 =?utf-8?B?czAvcXAzRytleTh6eUV4YVZPZUZycUxpNUxhTGVvQkRqWHA4RVhZWDJlL2ZK?=
 =?utf-8?B?aDR6ay9JU0tuRWM0NndJLzRnTDN5ZVFPZDFLWDcvVXN0UGtQQi9pUlREdTVl?=
 =?utf-8?B?Q0NsMG5ZWG53eGFyM0V1WGZxako4L2JaNlVQZkQ3c2VSZFRzTnV6NE1PTGhC?=
 =?utf-8?B?YjRjMjNGbDVxd1FrRVpjN3Jic2ZEVkovRzhyZUxYclkwZEdMT2xPSkhyTHcx?=
 =?utf-8?B?VlFhRWdoZVZ6NTVNRlF4NzI0WnhGU0dIWGFQYk9KZmFqZmFTLzdPQUJUOERV?=
 =?utf-8?B?ZXBicGVlcU4vNWlBNW9Na0Rmb01tbDVNVGJtbVBsbGI4QzkyV3YwQTRaVGlX?=
 =?utf-8?B?REFmR2hXRWtLZC9FbmFaWkgwaW1NSjhJMmc5SnFOeVRFZ0pvZGFEdDJqbkh2?=
 =?utf-8?B?SEd2eTArU3ZDcEluQnJuQ2krZkdLUERvYkFRVHB0VUVlS3dRd2JReDNoZDlz?=
 =?utf-8?B?bjRlTHljWi9xRGhORlJTS0duWTFwWTk1dzNBTVJRMHA2aWRlM3puL09iNGZM?=
 =?utf-8?B?QW9OZUZYazZ4c2ZERHRpTTdiYkVlVmNPVzBsY2JralNkZDl2WjlUV1JYTzhr?=
 =?utf-8?Q?AhR0TV8iJnYI5KtvwVstfiiAOHnrMiKBiQrnnk4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytLMWpZbDhQTHV0NTRYZVhBYnpIOW40WGpmSXp1VzBOZzFjZkdPaitOMmYv?=
 =?utf-8?B?Mk1oLzVBeUdjb3BiNWdDV2FhZDNzWmt0alVsUkhNTHpXbFRBL2N2VmZSSmtD?=
 =?utf-8?B?bHZOWWhOQXljSkJBd0o1RVRNZ082eXBoZG15a2tYd0NoeXB1YkczK2lOSUQy?=
 =?utf-8?B?bmRzdzF5bEFHYjhOZ1lMZzdUSXZkeFRjS3RNcTd4ZUNxTkVCQUtON0cxZmdi?=
 =?utf-8?B?WVlMMEpJWEQ5MnhzQ1AwZzUzZ0ZJcTZvbnhQb041L0NscmtINUt6d0RZZ1hM?=
 =?utf-8?B?cnJFLzZ3QW9PcWlUWVB1TTBYM3o2MHgvcEZjc0ZLNXM1ZXZEcGFuTER6akRv?=
 =?utf-8?B?cGxKaVFvaWovR0tRT1VucUlmY0dFL0JGUHFnRDVQSU00YWtwelJjTEx5OURO?=
 =?utf-8?B?dWl4RCs4Qk1DaStXQ3RiOWRZMFpFNnBuNms3eEVhQXptTDVPT0RWUlhQUnAw?=
 =?utf-8?B?VWl4Qm9GMTd0cExrYUNKYnR6ajk1RDQxa3FtTDFueVh3aTVsRmhmVkZ5UlhE?=
 =?utf-8?B?WHJqRkllaHZyNzFrR2s2amZReURGZXhIbENwczUycWZ3dzJ5aXdoemNvTjVU?=
 =?utf-8?B?TUEwc1NOZXJpWWRxZGM5NnorQU5zc005RmpGM3c3dG4reWx3WVVQWmtWYjBS?=
 =?utf-8?B?dy9KQVJZNDY2a3ZLOE1KTldUcldNdE91VEhKRm93N0hlYTVQUjNhVVBxWjlF?=
 =?utf-8?B?SWhGUEJIWEFkd3pxQnc2dDBqbEdCTjd1aDB3QkZXcFd3MnVycmJMUmlUM21H?=
 =?utf-8?B?NGYxSkpqTFhvemlQSkhZbGc2aVhXWUJ1dEVEUEVXU3oyeXFlRTgyMmFGSDZs?=
 =?utf-8?B?akJMdGdMS3lsbTN3NTREdEpOMmtsTVNHdzVYU1l1a3VGMm9HTnFleEhvT2tw?=
 =?utf-8?B?TTA0c0tPV3dscEp6cU1oNXlWcDZFYXFCTld6UURxN1RHT2E2RmJaNGRLSlRT?=
 =?utf-8?B?MFpxUUMyTFNYSU5BSXJlTnVhWkZVdlNRdWhtUVVORDdSZkVkY1UrYUp0bWNK?=
 =?utf-8?B?Rk43ZmhrZnk3WjJLa2YyN2VjMFB3QnFVT1hOTTNXK1hybG9UWDNrRWhWc2pw?=
 =?utf-8?B?ZzJPM3hUNkZOOGdkUFdFQkpzNWJCa1dhVHRUZUNyczZnUVhKdjd0Mzljd0t3?=
 =?utf-8?B?YXlUSGxQN284U01Pa040c24yQ205bjJxeW1vdDN6SzFvVmdUYUF3WXh2YWZS?=
 =?utf-8?B?Q0JhbDJ6SlFic3lzZXJaOHZQODJyaEpHNDlqSUkwd3dnUU1NZnN2MmRvZitU?=
 =?utf-8?B?RU9JeVF4S2s0ZXhmeWZuVHJsS3hxdjhXSzNJbTdDeVAwOXBZaWRPb01aMXBF?=
 =?utf-8?B?c2ZOVnhjcDB5YVoyakwyZmFnSFpvNGdXTXBxMGMzU2x5Ry9BTEhoc3lDWlJO?=
 =?utf-8?B?cUtKUktHYXhMK3AzcW5FZG9XdkxuWEd5ZzdCS0lCR0xsVjNONE10cjFQRDB1?=
 =?utf-8?B?M3VvRTJQRllINHNha3Q3TlNHUEpWQ3JhNE9waG1FcHZJZUtqSVZGMHpEWGhX?=
 =?utf-8?B?MUZ4MVhrblh4OU1DVnMweVZLUHFSNEtOOFRRYXZlc1hhOTZXdzlBSlB6SXNE?=
 =?utf-8?B?REFSUFVQZnVYa2FrcmpDSVRrLzBsSHU4T0xwQWt0MWNmTVdCYjFFMk9SVzRq?=
 =?utf-8?B?cGQrTVk1UXV6RUZNZzhaNTF4eEV4aG8zVXhBVDJrMHZLVHRjRU9BUzd5Y0pY?=
 =?utf-8?B?SnY3QlVWdzdhSGxqQmF6Z3hzMElyZDQxQ2ZMZHE0c3dQMEtJQjVVU2RUaE16?=
 =?utf-8?B?dUhZK2U5MzZFSjJ6L1o3bWZKV2hkS0RtdWF6SmcrbE5pMnlwMmRDNDJXQkJE?=
 =?utf-8?B?QWt5L3BMZEw4cXk0WXNCeW8vNlhDRW40eGd0V1ErcER4RDR1RW5hZm54dmh2?=
 =?utf-8?B?VkxqbFFhYVEzaE4xYlFDNVEzbU9EWGwwUUp0QXdzZlpldTNPWXlJSHlZVExp?=
 =?utf-8?B?QlptRnZaWXNSMVhTTmFpQ3orMFhLTm84dFNSek40T2tidk9BTS9rMkUvbWtp?=
 =?utf-8?B?Y0xVUWRzK0ZQOERuNG9YYUFMMnRnbFNIQmZlOVRSQTNpRkZLdEpjazJRS05x?=
 =?utf-8?B?ejNiM2tqc1FLWENNb1kzU2FWaG1pbG1LUGV2MnVZeXRDYklSZWdaTnVqSmt0?=
 =?utf-8?B?VTBFV2VINkc1YkFFcVM4U0RFR0gzL2FaT0hvVE9sY2txYzFnVWx3aHZBQlpQ?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1669384-a11e-4c94-4c59-08dc871ae662
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 17:54:38.5355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Am6AP0/tU9VhcpiBoYvsb9B1Um5UuSOE/zir3be57aGkJ/0BoYUQdmUwjk3JrG5qm2iHfkkpWo0pw9Caxn7LTjnwOoMvxYLJQZRQ7cgI1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com

Hi Ilpo,

On 6/7/24 5:53 AM, Ilpo Järvinen wrote:
> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
> the measurement over a duration of sleep(1) call. The memory bandwidth
> numbers from IMC are derived over this duration. The resctrl FS derived
> memory bandwidth, however, is calculated inside measure_vals() and only
> takes delta between the previous value and the current one which
> besides the actual test, also samples inter-test noise.
> 
> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
> resctrl FS memory bandwidth section covers much shorter duration
> closely matching that of the IMC perf counters to improve measurement
> accuracy.
> 
> For the second read after rewind() to return a fresh value, also
> newline has to be consumed by the fscanf().
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> ---
> 
> v6:
> - Adjust closing/rollback of the IMC perf
> - Move the comment in measure_vals() to function level
> - Capitalize MBM
> - binded to -> bound to

This change does not match the patch.

> v5:
> - Open mem bw file once and use rewind()
> - Read \n from the mem bw file to allow rewind to return a new value.
> v4:
> - Open resctrl mem bw file (twice) beforehand to avoid opening it during
>    the test
> v3:
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> ---
>   tools/testing/selftests/resctrl/resctrl_val.c | 141 +++++++++++-------
>   1 file changed, 91 insertions(+), 50 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
> index f55f5989de72..1575c5c09ac7 100644
> --- a/tools/testing/selftests/resctrl/resctrl_val.c
> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
> @@ -306,18 +306,13 @@ static void perf_close_imc_mem_bw(void)
>   }
>   
>   /*
> - * get_mem_bw_imc:	Memory band width as reported by iMC counters
> - * @cpu_no:		CPU number that the benchmark PID is binded to
> - * @bw_report:		Bandwidth report type (reads, writes)
> - *
> - * Memory B/W utilized by a process on a socket can be calculated using
> - * iMC counters. Perf events are used to read these counters.
> + * perf_open_imc_mem_bw - Open perf fds for IMCs
> + * @cpu_no: CPU number that the benchmark PID is bounded to

"is bounded to" -> "is bound to"?

Just the one nitpick from me. The patch looks good to me. Thank you
very much.

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

