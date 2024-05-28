Return-Path: <linux-kselftest+bounces-10790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E98D202C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 17:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFE0B231BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 15:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80126171069;
	Tue, 28 May 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btqNN/eD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3216F8E0;
	Tue, 28 May 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909453; cv=fail; b=pjWnW2vIAqd8NRJRdtt4u+8CzBxy8umcsNmSyZD9uelroecn9mk76JfqKQJqLdtkt9rGl5KCfsmceJM/z53evIYEKy3zrzSOJPeVoyzXOWMhHvqemBP1DO3S8csIfzISjGn/q5CfN9fyxMOdOrjnnelaAvdEssa4xsiJVO2cqLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909453; c=relaxed/simple;
	bh=nZgXku84x5M81kLbbjr5qPJUfG1cY3o0pWIBbTv5xzk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BaWYg9lY5hSoopre9MOL+kvcaHev9yMrdRhoogc/owu/3ikNE+6cT72LIDD87YNz6hbInEou875CxTZeYJ8TgDpWHUOemr/Q+wmO2Ie+9ZhU8bmBTgRW0DJkvDcvhsELP1i5EvInGG4KrfemonQI7VVzlhywIJKec76i9nehdUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btqNN/eD; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716909452; x=1748445452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nZgXku84x5M81kLbbjr5qPJUfG1cY3o0pWIBbTv5xzk=;
  b=btqNN/eDvOw71xrTuKTg8spRhxtVrU4+U+8+TrbhRB+iySxC5HBSYUN/
   l0R589m1deasRs92iwFH9huwDNoZuZYRiNz60HP435OMcblFpEXsfwizk
   pG2Yv98q/Ysl/fnbwqfY/O4bnN2XWwSHm3WSh4eAT8RPUXuBNz7x38199
   epu+lM68K74nPapcs3dHNV2LCpQpxKQaum9zHfsHU/igVuQTe48CTRljo
   Z+ZHrkgb9ZNyizlo7csQThUoi3plr6dOO1k7j/+rbByl9oaeHduAT9Sm6
   31gqQJjrQVYp9IEq5QKN5n13saG4gXXxCpWfMLM04lKJb8mnMicueCBjM
   A==;
X-CSE-ConnectionGUID: +zQJTXLaRAmUGDt6dVUomw==
X-CSE-MsgGUID: 7/Rwt67fT8C6vmEk8eHvBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="38643468"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="38643468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 08:17:30 -0700
X-CSE-ConnectionGUID: 2beEaKTCThCRAuCHJF4k7A==
X-CSE-MsgGUID: dK2Ygkc+TieHseZ7sTRjFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35720622"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 08:17:29 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 08:17:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 08:17:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 08:15:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAMhxwP5NF4pF/ESCAMYBWP2sobQ4vneJAHFovQBX160MyPLzNjLWPmd6JMygpXaA0SLbMnI0gihu49DtPUtsdeGsp42N3QL7RK6MwX5g3JDH6Kr3PLIimv382dR62vwCNbYYy2R+/Wup4slijDeF34p8PF1Sq2k7zq7cR5BDhx4cFOxKxa5yKwMfR/OJAOiBEmeJj0cSq8c8iyufCZftrcfssWQfzjM3tHJir9fODQaSskE4U/VOdeX9fxjhWBNHzEE0SasiqiDRKBAzdeJ8Xj8+ud1GbXIshZ7NZRxMlHp2YRyPDtCD17w+V7P55Hyblw+wU8PDdOKYP7QjmZxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMaYj+GZQUFbx875iPq7nZb8FNoVJXQ45ZfSMFbfPy8=;
 b=T5undNgIi2xNYwiyWT7XJs3LbJHYJK48M10m9W1mWe7L2AYzsv40ROR0z2eokHZEmnxmZB1ySClRuWuY1D9QD/LocdF+31iMMRSnKx1nKnBRLDHqXclAL6jQsp6DTDAaWMb28+rt6AaoD5Im6Sl9qibi4XizwX7LVppO8E0wMn4BcOIsE1YpM0P9sooPcHprJkJiHU3MpZ4/Ei16paRugbj9seJFmuC0bF58eitUbqvMr1g2gZnrJfK45KBqyF6wtC8vjne+VEObU43uBSNhwTybFv0owDsnuGuc5Hix5WqZktiQYCRlJ4fXJKXnjeeS2YucHPW4mWaQ5TgbG4UTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5031.namprd11.prod.outlook.com (2603:10b6:510:33::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 15:15:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Tue, 28 May 2024
 15:15:43 +0000
Message-ID: <700e3df4-4e10-4870-a1df-49d4616cbc45@intel.com>
Date: Tue, 28 May 2024 08:15:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] selftests/resctrl: Calculate resctrl FS derived
 mem bw over sleep(1) only
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Babu
 Moger" <babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-3-ilpo.jarvinen@linux.intel.com>
 <04d0a5d6-82fa-4cc7-bd80-ee5cbd35f0c3@intel.com>
 <ea0c86b9-ae77-c2d9-b52b-239ae42603e8@linux.intel.com>
 <d8063ee7-1744-45a2-b6b9-506e68106baf@intel.com>
 <b029db88-2e09-0b4a-f46a-84b5e535f178@linux.intel.com>
 <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <904aa442-9fc5-c6dd-f367-07b197085f7b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: f9557854-7c2c-4ef9-ace4-08dc7f290ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmV1VzdWZGtDdzJHVTlaUXp0azBRaERoMjAyNkJZYnMvZUM0M25DdzN3MTJq?=
 =?utf-8?B?U1V1Q1czemxWdU92bkVBYkFGWjdGck9XeXlzaVpPcUZzeDcybVFGNVV5YXpl?=
 =?utf-8?B?d2J4UkQ0RmVPc1pLTWYvcEZRenZiWk4xL2dWVGNUTTVDdHZySVM4amVJV0Jk?=
 =?utf-8?B?ZWNwaU8yTkxmUFBiRDhMWXArc250bURSVGJySGpEMG1wKzVMNGFRK1BLVTZt?=
 =?utf-8?B?SC9SWE8yd01WMU5lSDdSRGdXTzZ1WUlZcUU3TFQ3TWJlZDVJaEZ5RmRqSlFY?=
 =?utf-8?B?QWR5UXF6STl5Y0lFbi9SbmtGV0lwTUFXWEhvMmlBTlBXYlNJOStTU2RGd0V0?=
 =?utf-8?B?Smwwb0FMYlNqeVhqYWN0dGZmU3FubkN2NXlJOGlLRVU1SVJLTHZMeFR6bk5O?=
 =?utf-8?B?dStZcGIwZ2M2YmdpRlJDUlhRUnd3Y3A1TXRKR0tkS2xLVXlwNHJlNWFLYlNh?=
 =?utf-8?B?OFNiVHh4QVg5WUY4c1pPanQ3dUhlSUEyUU44UTJtUGhiYUQrWXdzQ3hzcVhB?=
 =?utf-8?B?dnc1T2xPZVY4Wi95TzluMDcrcDFldlFuTmgvZ1FGUVp0Y3hxWXB2K1JkcW5y?=
 =?utf-8?B?QXI5MVd6NmROUUwzUU1CSzFvd0Vjd1M3TTdPcWV5cWZzbXdLeVVMRW90RWU1?=
 =?utf-8?B?TlMzUE5kd0xGVFdyWDZveDVrOW1qNlFsTHZrRSsyRkx4UDZSQ3hCWWN6cjRC?=
 =?utf-8?B?NnNVUGpZYnZoQXZ6VTNoR2Q0cXFsNXNhelVpbG1nUnlJR25QL2xNTTZiZVQ4?=
 =?utf-8?B?MDhWOEdNa3g5ZVVMTmY3OXVwbmFDRXgwQUNUOUZ2aG5UY2ZXYWR3Y3JTcld3?=
 =?utf-8?B?K0lxZHFUUGhtNk02VWJ5Qk9aWVhlQ0xzVmFtR1BRRUs4dTIwaG0yVG1UdXZB?=
 =?utf-8?B?VVZyeWJudWRkTzFTQ1k2N1Q0Vm12ZTBqcGdBVnJ5M293cnRrYkxZRGhmbjdk?=
 =?utf-8?B?bnU2bEY3aW45TjlONHE5RVpDZWRGbmtRWExtMEVtZ3hKWTJmd0dneUh6a1RI?=
 =?utf-8?B?ejFsRTdZRkpBMWcvRVUzR1dVdVJMbWhUeGxKU2MyQmFWNmhaalRaUVRGUVdG?=
 =?utf-8?B?RkczdVFrNmJpWlBlNUVBc01KY0NWZzVIeHV0WjlZRFhkeENLZFlLN2xNUVpZ?=
 =?utf-8?B?dWY3VUtMRmxtOG9NbUJGeU9lbTFodW94TlZZNy95cGg2K2Yxeit6NFc1MTF6?=
 =?utf-8?B?RHBnVVUrQlZoSTZRWS9yMmNDN2pwWDQrTmgzbWM1cWNpRFZRY0tMRVFyemJN?=
 =?utf-8?B?T2tjcnpyUnFRTlM5V3pqeXJKdUJqdnNyUWFUb1BjMUFTRG1ETnZoSmdJUmVS?=
 =?utf-8?B?M3gwNjZMSGpvMWF3ZldjZUxPYjFFNjFKRmVuZ2w2cEl4MlhKNkhUbGd1U3JE?=
 =?utf-8?B?emZiekxDTnBnUzF5T1BoV3dVclJJN3hpZGovV0VsTXYrbmNZUUc3S28zSmhD?=
 =?utf-8?B?eUJoSU1obGpoaTFyY2t2Qm4zMXNsS256anRCbE5IbVBKVFUzd3hpNzUxRnVN?=
 =?utf-8?B?MkFiS2NGM3M5aXBuU1BMZ1FhckxHUTI0VkU4U3hZdEFsSzM4OXdLLzlDdWNh?=
 =?utf-8?B?ZjJpU3dsRjQ4US9LTHJFOHErdnRxa0IrcGZzdlVoemUxUHBtVzNaK1VBdUNv?=
 =?utf-8?B?bUdUUEZ0MlhqRGlKRHA4NVpGbGdPTGhuclRUdjZUK3oyR3JyRzNyc1gzQWpQ?=
 =?utf-8?B?ejRFQjl5RzNGUWtGemZHWlN4VlV1dWpVMDZyVE56OUFKcXlxdzBzcUF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2JOSzN6K0lYQWlSekNFdklwNjEyNmdHQlpQaFRDWWtXNjNzRTF2aHBQL3FY?=
 =?utf-8?B?d0VXeXZtM0JHMHNzQitiZjVZcmJRdUlwSzBOeG4zVmtuRmE3MjAwcVZpek9Y?=
 =?utf-8?B?ejhjbVFNOER4bjhVZkNnUmp1amZ2dFdzZG9YY29hblFkRERGeXoyZTVFTlJT?=
 =?utf-8?B?L1d2UjcwVldXNDdjVlh4Rllkell5L3NTdkNnME9vNEw5eFFpVHBoY3AyQ3Ba?=
 =?utf-8?B?MDRaMThCMWF3OTJ0bElaclVEL2YvcEwvbGhRTE42VkQyVDlyUFg4NEFSWXlH?=
 =?utf-8?B?NE1Yb0R3ckM0RmlGa05qY2xWRlkrNmhhK1M5R29yRDROOVZxT0JMZGJ4VXFj?=
 =?utf-8?B?VHNwZXc2Q3pGZ3dmeWNrTzJ4Q0QrNXB3bnZCRDFXZVdoTmFINkZ1TTNkbGVJ?=
 =?utf-8?B?WWNENFYxaGVsVVNaOHZyempoWDAvWWczcHlhc3pWMmdJdWlLRk1HbzBSYk50?=
 =?utf-8?B?R21NSVpEM0hHNkRnQkxOcXR3YUdCMEF3QW9JaHU3MHRmU1g2dlNZekNkZWtN?=
 =?utf-8?B?S21uTnBxTEU3UmYzRExtU1V0TUhWa1dwMFZIeE1SdUNRSDNyVkUwQ2M5WU5B?=
 =?utf-8?B?cElET1VYZGIwRENZNGZPUnoyL2VON1lhbW9NK05jUXEra1pUWlYyVEdtSFV2?=
 =?utf-8?B?N3l1QjRkM0hxdGszU1dzSitlTE4yT1laZXNMOEZWc0NLWUJBMHRKeDZkMWNU?=
 =?utf-8?B?MEpvSklqSE9SMm9hSFZSQ1pyNG9iMHZFYkFaUGhvU09yaFcyU0pYN2o0ZzZX?=
 =?utf-8?B?VFF1VGljUWpid2FCdTZ0UkxRUFZLQjZ3eTRqaSt6VzBLK2pPT0l1VWNXMGlQ?=
 =?utf-8?B?Sjg2V0NtQksvMC9oc0l2OFhiQnFidWhGR1dwYS85MnhHTXJjaVc5MmhmMS9P?=
 =?utf-8?B?TThON0tscGo5MzJWUktCa205TTVnMVFLQ2RBRUNyT3ZEWTEvREhKTDdBcHpx?=
 =?utf-8?B?TnlIRXpBT3FHalVJenpwZHdrS2lBeVU5YWtsaVFhNGoyS0p3VWREME5LYU1T?=
 =?utf-8?B?T3NLRit2U2k3YW9BT2dMRG9SU21WdVc5UnRvM21mekNtWVhocXFUSXo5UHRK?=
 =?utf-8?B?b3gxcXVJY3gwOHRFTDNJQ0cvOVhqczM4bUc2dk00VEMzSU1keS9LWXcrenFi?=
 =?utf-8?B?ZUJ3Vm5sYlptQTE0K1g0SmUxL085S2dxUkFPemFOWjBFeFNIcCtHMitxN0M2?=
 =?utf-8?B?U0NscnRNSHEyUlUyeThGUC9PelFsaFZWRUZ4OG5ZTEt4TFRVUmJxVFp5NHcw?=
 =?utf-8?B?UG41T0tVTmhkWUtRYWZHVVdmSUNZUHF0VUlmWEVsUFc1ODQ1RnI0RjJRWFZW?=
 =?utf-8?B?cnIySkJmSFV6WVAxT01XVk44V2Y1WXJiVmJBR3JIQitDUXVRN3cveWNxcHdU?=
 =?utf-8?B?SjRmMElqc2F3MlQ5RHlSdTV2UHhVUGxzanAzN1B5c2c5Qy9VQStLTDA5ekhO?=
 =?utf-8?B?cTVQMzJEYzNMWmNFaVY0cHFOYmZFK2ZhdWVIRVh5QnBYbGl3aGNjMEt5WUln?=
 =?utf-8?B?SnVZZHN6dUM0eC82a1lVc3FJcXJFZWRBUkNaU2xwOTF0aVlBZVh0ZjMwQTFH?=
 =?utf-8?B?ZVdmNzNabDRyMDg3dnIxbGVRbXBkc1ZtSGgwckNab0hhUkJkZ0pYR2Z0S1F1?=
 =?utf-8?B?SktIT3ROSWF5WVVsTXJqRXFENDNEUTNBNzFmVEt4RjNmZVVPYVBTZGRQcDdx?=
 =?utf-8?B?M1FtOXJyOEZqaVYrVzdMeHFkbVE2SVVFNTdGMlRLcE1CL09iVDc4VDVhM3BC?=
 =?utf-8?B?aFMybm9CUVA2a2dtTlFTT09JRzRzWVFCVHhKZlNFVDlMNi9yR2pnTk05Mk5s?=
 =?utf-8?B?ZUxGZ3RUbDdQMldzRnBuQTVlNmFxSnJySGVUZWVITnVVZFBiUHIxbkxZYjIx?=
 =?utf-8?B?OTMxTE55N21veDB2YnZoQXhkRkFRK25JTmZBaWNXQVVQYVh1LzE4Zk92L3I2?=
 =?utf-8?B?bDNqbEEzZDFSQXdGdkFtTklTVUtNOHpjQlYxdkN0akpVM1NxUkV0cm9zTHVE?=
 =?utf-8?B?ZXNnSFhZN3cyTWNWNXloQVR5T3ZOK0NNUXVVaHlTOHpvSzBzUkFJRkdQa3Fy?=
 =?utf-8?B?NHZHTUYxSjNFZE0xbkgyek5PNzFyLy9UQzVOUUVMYmgxODZWUkxaLzlQbi83?=
 =?utf-8?B?eG5yUkpndjFsZEIxTUttWjMxbmdya1IvcXZPRmNPY21lTlo2NzNXT0tVb1Fv?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9557854-7c2c-4ef9-ace4-08dc7f290ab1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:15:43.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXeUo+djZuDDsoT5v3FURZQZOUyqbVU7DnOuQr0FqYKp/VGzhrwBOokguwtrW/gu7bnloxUxkauFo4SyLiZgVYpHXMlxMC58Kxw59IKl0FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5031
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/28/24 3:19 AM, Ilpo Järvinen wrote:
> On Fri, 24 May 2024, Ilpo Järvinen wrote:
> 
>> On Fri, 24 May 2024, Reinette Chatre wrote:
>>> On 5/24/24 12:57 AM, Ilpo Järvinen wrote:
>>>> On Thu, 23 May 2024, Reinette Chatre wrote:
>>>>> On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
>>>>>> For MBM/MBA tests, measure_vals() calls get_mem_bw_imc() that performs
>>>>>> the measurement over a duration of sleep(1) call. The memory bandwidth
>>>>>> numbers from IMC are derived over this duration. The resctrl FS derived
>>>>>> memory bandwidth, however, is calculated inside measure_vals() and only
>>>>>> takes delta between the previous value and the current one which
>>>>>> besides the actual test, also samples inter-test noise.
>>>>>>
>>>>>> Rework the logic in measure_vals() and get_mem_bw_imc() such that the
>>>>>> resctrl FS memory bandwidth section covers much shorter duration
>>>>>> closely matching that of the IMC perf counters to improve measurement
>>>>>> accuracy. Open two the resctrl mem bw files twice to avoid opening
>>>>>> after the test during measurement period (reading the same file twice
>>>>>> returns the same value so two files are needed).
>>>>>
>>>>> I think this is only because of how the current reading is done, resctrl
>>>>> surely supports keeping a file open and reading from it multiple times.
>>>>>
>>>>> There seems to be two things that prevent current code from doing this
>>>>> correctly:
>>>>> (a) the fscanf() code does not take into account that resctrl also
>>>>>       prints a "\n" ... (this seems to be the part that may cause the same
>>>>>       value to be returned).
>>>>>       So:
>>>>> 	if (fscanf(fp, "%lu", mbm_total) <= 0) {
>>>>>       should be:
>>>>> 	if (fscanf(fp, "%lu\n", mbm_total) <= 0) {
>>>>> (b) the current reading does not reset the file position so a second
>>>>>       read will attempt to read past the beginning. A "rewind(fp)"
>>>>>       should help here.
>>>>
>>>> (b) cannot be the cause for returning the same value again. It would
>>>> not be able to reread the number at all if file position is not moved.
>>>
>>> I know. This was not intended to explain the duplicate answer but instead
>>> describe another change required to use current code in a loop. I
>>> specifically said in (a) that "(this seems to be the part that may cause
>>> the same value to be returned)".
>>>
>>>> I certainly tried with fseek() and it is when I got same value on the
>>>> second read which is when I just went to two files solution.
>>>>
>>>>> A small program like below worked for me by showing different values
>>>>> on every read:
>>>>>
>>>>> #include <stdio.h>
>>>>> #include <stdlib.h>
>>>>> #include <unistd.h>
>>>>>
>>>>> const char *mbm_total_path =
>>>>> "/sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes";
>>>>>
>>>>> int main(void)
>>>>> {
>>>>> 	unsigned long mbm_total;
>>>>> 	FILE *fp;
>>>>> 	int count;
>>>>>
>>>>> 	fp = fopen(mbm_total_path, "r");
>>>>> 	if (!fp) {
>>>>> 		perror("Opening data file\n");
>>>>> 		exit(1);
>>>>> 	}
>>>>> 	for (count = 0; count < 100; count++) {
>>>>> 		if (fscanf(fp, "%lu\n", &mbm_total) <= 0) {
>>>>> 			perror("Unable to read from data file\n");
>>>>> 			exit(1);
>>>>> 		}
>>>>> 		printf("Read %d: %lu\n",count ,mbm_total );
>>>>> 		sleep(1);
>>>>> 		rewind(fp);
>>>>> 	}
>>>>> 	fclose(fp);
>>>>> 	return 0;
>>>>> }
>>>>
>>>> Okay, so perhaps it's your explanation (a) but can libc be trusted to not
>>>> do buffering/caching for FILE *? So to be on the safe side, it would
>>>
>>> Coding with expectation that libc cannot be trusted sounds strange to me.
>>>
>>>> need to use syscalls directly to guarantee it's read the file twice.
>>>>
>>>> If I convert it into fds, fscanf() cannot be used which would complicate
>>>> the string processing by adding extra steps.
>>>>
>>>
>>> It is not clear to me why you think that fscanf() cannot be used.
>>
>> This was related to fscanf() not being able to read from an fd which is
>> different interface than what libc's FILE * is.

The part I am missing is why you believe syscalls are required. Could
you please elaborate why FILE * cannot be used?

>>
>>> Could you please elaborate what the buffering issues are?
>>
>> I'm pretty sure that by default libc does some buffering (even std*
>> streams are line buffered and others streams even more). I'm not entirely
>> sure about the extent of that buffering but here we need to always read
>> the up to date value from the file itself, not from some buffer.
>>
>> Maybe there never is any problem that the earlier read values are returned
>> from some libc buffer when lseek/rewind is used, I just don't know that
>> for sure. You seem to be more certain but I've not seen on what basis
>> (other than the anecdotial test you provided).

I demonstrated that it works. I have not heard a clear reason why this conclusion
is incorrect. The above remains vague to me and I cannot find a description of
a clear problem that can be studied.

>>
>>> It is not necessary to open and close the file every time a value needs
>>> to be read from it.
> 
> I'm bit unsure where to go with this. While I could change the code to
> match what you described, I realized with the two files approach there's
> no need to do even review/lseek() call during the measurement. It might
> not be very significant compared with the open that was there initially
> but it's still extra.
> 

We are discussing the resctrl selftests that will accompany the resctrl
filesystem in the kernel. When in doubt on how to interact with resctrl users
use the selftests as reference. Needing to open and close a resctrl file
every time a value needs to be read from it is not the correct guidance.

Reinette

