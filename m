Return-Path: <linux-kselftest+bounces-10846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A18D3D9A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36EDDB214E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D94C181D07;
	Wed, 29 May 2024 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbEjHB0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B27492;
	Wed, 29 May 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004787; cv=fail; b=oAvubCnezeUBtFLLzmK0Nv9uXJ7xGHDRF+i9FDhJKRerGHAtI82ghuKzh8IKVq4Nf3fgTN/2NjZrf0U7BGZh8gYT7l6tgche9mnP+Inxt8PYhmDEQKxrbHdyxZoG8DtvsQqM9AGI7+Xr7HWdCyGwuYjV38PGFtPpRMzBbPSX5VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004787; c=relaxed/simple;
	bh=s9mOwT2EnVN/y6UfpD5c+xUOj0WnO74XQ7HUW0WQXWs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6+leeQ1pnimvr48zW+pPOwm8qAfM63DVqT+f3thassm8w4iZ7RXGEIaOL8M41AoGcxyOLVmC7i4pjAF2gdbZabokHi9L5BLZFkBVIIb9oNFHrOFEQYPdXQq7aPz3hHqQQswlNvDGLyoIphjgKpNMFMygya6UXF9t1rbS/n/OpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbEjHB0w; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004785; x=1748540785;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s9mOwT2EnVN/y6UfpD5c+xUOj0WnO74XQ7HUW0WQXWs=;
  b=YbEjHB0wcBVZTsLMwOrWOFn8BriDfD1mTugkarF6AC78fOV9wTqx2hhe
   6MSJBYCpMwoL8UschySUg6mD1uysle37OqXinvTw7d+ZEU4V10+10LPuj
   ew+5vCKY4OMhYCz7RbvENd69rFkF2/kQILQeBqgR5jRzGWgZ5+YV6zMTg
   UL0fpcDNXClma8FrJZdHzcMSkf0kCPZq76lZmPZPLFiSPZ94ftk6GwnZL
   I4hD23lV/Jb96vKZ3wtE7TYRmyS8EBR4J+ZeQ8+UB2YO+j5LUlbxEY5Wx
   u7iGHAR+QSiJ9GeN4nNCI0qC3el7kKGGgmKoR2I9kF5k62CBMANRlSZh3
   w==;
X-CSE-ConnectionGUID: k/AKh3rxQ72lsuz5MRwMiw==
X-CSE-MsgGUID: WdJJZT42QE6iC11kZoaxKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24042216"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24042216"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:46:22 -0700
X-CSE-ConnectionGUID: BPvKxk8qR4mWjcdr84OWww==
X-CSE-MsgGUID: rHpZMOSoRMScTQcDakmXKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35540461"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:46:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:46:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:46:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:46:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:46:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcuJHE0X5kXwJhJdKjG/Iv0YYgB3HccpATptWWtIHThZWbPiIauzt6u6X01N5siOvSZBj/y+of4Kd2GUWboZJNXGH2tCy+ASOfUEaKlC9kp2AETQ6RARBMkvQe8fYW180q3U3925TnfUYp/SAgvZYtjdvTq4VxmxQkMJZ4OGrio2G8NMAif7QbvPmyisfTxHwCrdS0KDvxCJnPXSWi7kDrWnMfH/n2uDQXWvjLe5GLXTzRZVyS+TVwEpkS2nMAht8xa9RCuYNF5CUb98SpP8wIaGbkAbIYLviloTvlT1FkTaoX3RldxKdsbfoUgVsldkUfrBLMXxM7uf/zT/VzWhCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6SQIhM0u0WjFtj3QNFs+svU/KVACkIhq3ftVSvBbUU=;
 b=Mmg740MIijAbqad8IXnTOZiVGdmM1RwJdZGTQ/MKFDlpVc3drYLaquDYTIsps2KRDZQuXXtrpErF9TEpxOzGNarwfDcN1ofaLH6o7wPuifZxpew8adbWzuZOQpfvvdR4VogrSt3h/u5Ic2WBVNQKEp91vePURoD8Jdsrk+LeEAZbf4qAmqrORqhOg0G53QpeucpxZy2lKpHWkz8qdCt4QNeYiLJSEGYYLhUZp/t1sdIhoHCxRJfZFqiMNz3AUBKj3A2/5HI72vfm/VNSAKAKayd7o3Qgx580kP/0Uus+HosLgiOAgvF5gwQR1TW1odi48JZr8Po3qI/cYGIJpedjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 29 May
 2024 17:46:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:46:10 +0000
Message-ID: <7c5d83d2-3d65-4d75-ac25-dc818624db2d@intel.com>
Date: Wed, 29 May 2024 10:46:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] selftests/resctrl: Add ->measure() callback to
 resctrl_val_param
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-10-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0220.namprd04.prod.outlook.com
 (2603:10b6:303:87::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: b362f9ea-1924-4e66-2df1-08dc80073a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlNacUhZVDB4TWJjc3haWDBYNTgvK1VlZElvZ3VCNnpHTzBaMkJndERaQUhj?=
 =?utf-8?B?amdERld1Q09QS0FGTzJ1c2s1aW0rZUFoTkkvN3h1citxcm9lNVVRVUxvKzhT?=
 =?utf-8?B?YW0wYTdINi9QMWp6MWhudmIyOFlPbXVFQzNrVkVPZ29SazhPVEJjOUI0bWpr?=
 =?utf-8?B?MkJkUk9iUWs5Mi9yVm1OK3gxZS9DWFVXNFBsQytTMENQcFd3NkVWYzlFK2M5?=
 =?utf-8?B?bFV3dXpoOUxkalIrcjdPK3RNTkRMT0FIRzlheml5bEsxb01kZFpVdzRqZUdi?=
 =?utf-8?B?RmdZMStWTVk3TDhHOHZvZHRyL2ZLYll2Y3JvZ3dyKzFCWVpmb3VWK0o1Qllw?=
 =?utf-8?B?M01KdW9IWSs5ckpKdEpoZ0pyK0pFTFZ3c1FjMXpZWDN4OUhaeXB5c2hheWdt?=
 =?utf-8?B?c1BIWFRneG52a25EMnRzWDRBSEJuMGpBQWU5OWh2UnpHejAvVVlaSnpwU1V6?=
 =?utf-8?B?WW93bU9td252Qk1FTThsa2RFWk9ORGN0djY3cTVKbkpPYS9GTEhFUDVMRUg1?=
 =?utf-8?B?c2pjTjFybHQzNDZQUVZuc0RIbnFlQUU5N2FvN1ljNXJxcUJ0S2pHSjREc0lx?=
 =?utf-8?B?SitXSFRya2pXUjNsT1BtUyttQi80ZDY0d244WVRuQ25vZzJhc3NrbWNtNUdY?=
 =?utf-8?B?YjY3a2Z6NjczU3R3R2dCZ3VlL1N6Ky9TS3NFZi93b1crU3VJQUNMVjA3cDNN?=
 =?utf-8?B?SHIzalBSeUttdlVkQXNWMVkyWHlsOW9iMDAxalBob1M2NFVzWWZ6ZjZ3SkVS?=
 =?utf-8?B?U1g2VE5UY2IrYStEOHpWeUVMQ05nNml4UkZUa0s0NHRBd3F1RVNaZnlTaXhz?=
 =?utf-8?B?QTVlUXJiNW9ramRoQW5lZkJyczMwWDB2ZnVvdEJDSUJIaUI5cmNmc1BvWFQ2?=
 =?utf-8?B?QlEvb3JHMk5KMm9rcFlKREt0N3ZNQWJpY0dEdHMwSmR3a1Brd2srNlVtdVZr?=
 =?utf-8?B?bmVHaHhFeWtzSmxrSGlkdTlDZ2oxSndPbGRrOVBRL3VVYjUxUFZrcHBHMnd6?=
 =?utf-8?B?bG9QQXVSczU3SDFTb1BSUVRMbktZZWpKUWdENDFkY3lEMHdqVUVSQmNQYitn?=
 =?utf-8?B?NGY1NEVxK2ZsUjdJN0tMTzlpUUhpdEZaWlFXOFA2Q0xaYzVCQmh2ZTYxM3VV?=
 =?utf-8?B?TGJKdTA2VExGYXlTVkE4RThLK1dzK2NFc2ZId3ltRmozdEVNYzhDT3d5YmNY?=
 =?utf-8?B?T3dxUGg1M3hOc3ZrcGFXT3VIeEFPTGZwSlhzUkJsTitqQXFkSnFBYVdoaE9w?=
 =?utf-8?B?TjROa2swbG5wdmxBM04yenJvUjR4TmdDN3VZaTYwVnRpRjhiYndxNXJuNWMr?=
 =?utf-8?B?emVXYVVVTW5keENRcEMwSnU0eUJnQUMwYzhTamVVK1BGaTF4Z1UxcjhrOUtS?=
 =?utf-8?B?VUNJd3pRTXp0TG4zT2duaGtVU1FIeXpLd3NTNHRvK1hmd0kxUGRLVEpZOVd6?=
 =?utf-8?B?blEyckRoQmlMR2VIeVdscFUvTlhvRGhGNmQvZW53Y2hmWkk0S3lkWUhPc0E2?=
 =?utf-8?B?eFdieVlJUkl5Sis1ekNqTXVTeDZwRjA5VmpQU3dPTFhSOUdkTXJXMDlWbmtG?=
 =?utf-8?B?T3BUVVFIRmxrUHpvWm5SYTd4K0E1NVBWd1p4VUJFSnVYdWwxWlY1Y0w3SElD?=
 =?utf-8?B?czRMU3V4RmtoSnBDaHJPdkU5anlMZ29wR3FHY1ZLbU94YnUvcjgvRkpWclNo?=
 =?utf-8?B?OWZkdGNPUnR0Q2plU0EzUm8vSnhkWGRYd1NQMTI2amV2VjdXVll3aExBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFpPb2ptaGlIaW1EWDJxSDhzWkg4VzZlWTFSSG9UeE5IOVFmN2VUc3pUL0NY?=
 =?utf-8?B?eTFmckViOWpqeEU5YVVXTVdZWGRjL3A3Z0xHWjVBcWYvbVZYV3hTZlNnck4w?=
 =?utf-8?B?WHFTQmliaUNHdGp1bXJyN3ozUkVvdlM5QTRob2UrOWZhV2lQWmtaOVBHQUhm?=
 =?utf-8?B?eUZGTlA3NFNiS2tLN3BFT2Fza3dRUEVjbCt3N3U0RDBuQnRZNVVUc0dNUUU0?=
 =?utf-8?B?R245b3JtODFvM00xZFhsWmcybHZramNOdzNuYlREU244dmJvMWUxaFJxVUp2?=
 =?utf-8?B?N1h5QmhheHlsVVFUL2NnU2YwVXkrOXVReVhSVHU5aWsyWkhTQnd4UUQvK2di?=
 =?utf-8?B?VmVtYXNVS3RmVUxRYzJvcjVqSTNZT3JBMHd3THZ5NDltT1oyTit1MHowUDZ2?=
 =?utf-8?B?d0IwL3NWOE1jZnEyMXllbVNGYlZ5dXdTdlFFdDM5VGNIUFkxbVJVcEZoeE5E?=
 =?utf-8?B?QTVQbEFiOFZEbUZXWlRzMnlYN3d6cVdRL2ZVd21zQld3ZkJnZmZFd0NHTWJv?=
 =?utf-8?B?NUFNd3Y4OGhWeVB5NnE3NlVERVhORDZoYkRGN0RVZ3lrdlZHU2NpQmNSTkJL?=
 =?utf-8?B?emVqUkw3cGcrN0hKaktGSjlkWG1OY1hWWmlVWDh5a3VIQWxPamhNOEFkWjl6?=
 =?utf-8?B?a2xUcEQreFo5M2JPY2p4Z3pEdkJBSk5kekJwT3A5dDBXeTdOeisrRVZic3RF?=
 =?utf-8?B?SVpMTkhFVzhERnl4VXh2YzdHSDA0T2N3ditBL3YzUHJ2anFtSFpsRGhrdnpw?=
 =?utf-8?B?blVVbzEwNHIrcFpBN29TQmNKWG4vUldvZHV4VzkySS8wNm5UeTR2Q1cxMHho?=
 =?utf-8?B?aC9tOVFoSFhVU2xlejBwUkRnUXhiRjFVWVZIUUVSZ3ZjbFAveDZzb3VTS0Vz?=
 =?utf-8?B?NzUxQkRycFh2YjVWRGhtL2traEVkSE1HTm1YdTZuLzBlQVFvVjEvWlkvMzJN?=
 =?utf-8?B?dnltWW14TG5mWTNKbmdEYmh5K2RMY0dsSDFHcUNjWUdodGp1a0JDNkhSQjVG?=
 =?utf-8?B?MzdmRHpiZmhVcHN4SUpudll0eldNZ0dGUDdCQjRqZG5FV3l2QUZxR2kzMk9y?=
 =?utf-8?B?Nm45K24zWHluTFIxQThXM0luUmlBTDdzVTRya09RLzFvcEd1ZGhEQnpyMExV?=
 =?utf-8?B?Wi9sQm9ZcVJzQ0w2ZHhETGNUNmg5Rm53ZXlCdUViM3JqQURnemtCT1ZWUUtC?=
 =?utf-8?B?bVpHODVZNHVzTjlnNTcxZTBoQ1Y1Z2ZWMFZIU3hQWGhvaDNMQTRUckRiMU9F?=
 =?utf-8?B?eGZOcFltRG85WnF6RWpYZmw3Mk93OUp1WXpRQkkxaUVtNVMwbUhJcFJHQ05w?=
 =?utf-8?B?RHd1ckYycGpTeFZpOENaRjhIU0pZc2h4M1JPVWhjdFh2cVUrZVRxOXNJWjdv?=
 =?utf-8?B?RVp2a2VndzM5T0tYOVIzNXpRUDl2dFBtQS9sZG9XMEVOTjZkb2tScDR2ak01?=
 =?utf-8?B?S2VrQmd3endkb2RVZUdkMVkrMUVLYXR1N3RnazFPOE5uTVEvUFlzT1VYLytk?=
 =?utf-8?B?KzNVbGxrZ0tnNERrV1FuZVBrS0QzWWdhc3k0d3J1SjBpR2J3bnV4bkx1emtD?=
 =?utf-8?B?T3pqZHFPaEtqU08zNHdxNFZDMVYxZkI0dDk3TkpLV3BaTXRxY3ZFQ0tZSzdW?=
 =?utf-8?B?eElpb0tFekpnVFZHRG5oWHFLM0U3MXUxRHhkelp2Y0lGeEtOVkF0Q3A4Q0V1?=
 =?utf-8?B?am5mbkNQbzc5L3E4S3A2U1lJVy93VVh5T3NhQmIvRHp0OUswTUhyWXp1Tzc5?=
 =?utf-8?B?ZzFZbGV3S3dxRGdML3huK1lkRlBHRlVQQUw4ZHBmSFJ1blcyNW85bzdYNHVF?=
 =?utf-8?B?a2lZRVFqU3J5Sm1vVFQxVGtHSFNFZUxJV094TkJydGdJdDROYVkreEtrYkdt?=
 =?utf-8?B?bk01dUxDMWhKTlh1TmY2cGIwNE5rVkF6a216N1crZ2hzd05XZGZ3bnByZU5I?=
 =?utf-8?B?S2pCNUtONkZWakhGbzA4Vm41QmduZXhtODRSV1RPREt1QjJvZVphMlBJZmxZ?=
 =?utf-8?B?MkNOVC9LOFJnR3dxeEpzYUpGbkJPZHBYbkg1N2FiTXZ6OUhuL25nUzVMZnRI?=
 =?utf-8?B?bFVlTjhxNHlMNW1SakJsUUpRUjQ0Q3BRYlRiQ0txdWE0eGR1cjUyMzZyTjEy?=
 =?utf-8?B?UW5obzFaL3JSSnpEWVlwQmZjM2pSYXhFcHJSVjJaenFNUXI5cFpsNGNIOFFS?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b362f9ea-1924-4e66-2df1-08dc80073a0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:46:10.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CegFe1Vv4LaNat6lw5qdZAzdS8wMb9cf7cXUUWXZtu9iUOHLJMf4+UOOgZQ0uXfu+ur32lXz/TZcXHfVGr8jKb6JWNYXGJQ/wFiH5QKoFl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> The measurement done in resctrl_val() varies depending on test type.
> The decision for how to measure is decided based on the string compare
> to test name which is quite inflexible.
> 
> Add ->measure() callback into the struct resctrl_val_param to allow
> each test to provide necessary code as a function which simplifies what
> resctrl_val() has to do.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

