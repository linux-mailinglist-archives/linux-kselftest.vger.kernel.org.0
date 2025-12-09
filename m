Return-Path: <linux-kselftest+bounces-47349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9BCB1609
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Dec 2025 00:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C73B3049B12
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Dec 2025 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF034266B6B;
	Tue,  9 Dec 2025 23:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxhMvi9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76D1D61A3;
	Tue,  9 Dec 2025 23:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321350; cv=fail; b=sJd7CYz0q66BefJDNDs5t1yfvMTuuWJgVMZ1Vk/1F34MsVtnCeXHvjZpxjI4a3AzmGuOpn/NkU/papX10zq8Nt67ulXCvqh23YsImJhOHludKRDIzzTHLHmWnGGVWXQpTEolmSjMgZ763mtilKYq8Puf0myH6hNJn0kh8zlxapA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321350; c=relaxed/simple;
	bh=wFaWF1SgCh9BUrIROIC5j27MIZCxi1rmBkaChDO+59k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F2G3bdBFH/EeeDH5HwV0HIOf5xxtFNVi0tTOrhJfJ3M1AZ9z+S6rcRqJuIxOG06LsTjV/L1+dSbuC9dR+mla0aCtfdiKcM6yxMrmnAD8pYYE/2JUZBZkeOHo/pDdSiBEvxoXBcovbh+GY8mOkd4Vn06EyTMIsiYs5FfbPlD2blM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxhMvi9a; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765321349; x=1796857349;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wFaWF1SgCh9BUrIROIC5j27MIZCxi1rmBkaChDO+59k=;
  b=YxhMvi9a1ERwazUtXAjuYGxcwdygideqWnK8JC+aBHgfkzsjB5PkeUE2
   fUvpG4CtlUAsUh1VivXGPRdbl/HlkKdHrZxIPoaZWeVukWiNIbAv+ZsGY
   c50vnw/XWtEn4zT3COmTRUXIg6NR6gpudzyEGLMMhl4tI53d4wcLHhYNL
   GItgmCma6OZATYdHPktsIZUhhoMJlG4s9noh8QxLnQd4TIbdQfrwG5pyQ
   zxBDVhMrEWN18/AgHIXew2GmV9DLKAuXiAC4KIWLVCjQK0GCo1jxwZAF4
   8Mk4E91n1+qbCW9TLlAPabRThuWtIEKeoBf5Tv7LA8C8BcLb5fT4bg7AR
   w==;
X-CSE-ConnectionGUID: GRIPRfKUS/uuJOw0b7wWEQ==
X-CSE-MsgGUID: 8Si2SFsATsWaBF5U2hK5Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="66467050"
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="66467050"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 15:02:28 -0800
X-CSE-ConnectionGUID: NOgPyx7LT8OuNQfEvT0LzQ==
X-CSE-MsgGUID: Eg8oI0SxSoqVOWVcBGD1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,262,1758610800"; 
   d="scan'208";a="201277083"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 15:02:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 15:02:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 15:02:27 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 15:02:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW0QZwFiDpXA7SIU5QDi86QopYJ+w7LjrFqzMXYnZthPb9BpeU4SVpuwXGWbYaLUH8Kp8AJu+V3Sv/z56T/op3fo3DdOwo86q4crlGtVg/o40qB+yjcsREMQQ6i5vTW86T5X3ZiRjNkwiuigp80cZkkarr3gbieSNFVsMV2a/3aDejKb52bkp3Q+B3VUOA9NmS4dix/GL4f5dPER5aEgqe4qopY9ODnYRHkdmcFGXY7zL4NIINbAVKrH06bDd/JM9bSZWTBooQtY0V5DweJsewlQ5xn/HOHs65fYXNEwHoPZIfE0CCzYTBjLkCcCjuDyJ/bzDdQx+NpWHboTQd4mMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSkDOiX58O6lDsC1I6VGk4ds1rz0sMXcCkt5+sAJ3DU=;
 b=h8UJB7+I6PMtByLiUB/mQgJjgsVMWJwnrxF8bNk6NXCWp8GCwOtJ3b7/m8fRjp+/UPgg27dIYByBrC+yO5waKl/AEkXomjZvz0O+VJcUCCZCXpdWYKGlRESmu3IpNMcHk3mGLVDKVfLSgrwGf1+Zfuay1Q8Stl43wpqMhQo26c47a065NEI4mIqJsnJ6Pmer1gu/h0B9IlhPGcnpmOExK7Wvsa+BTWTmuFnDJ5Ghqf8VP6wzlxvLbw+LHuEiYpHSjG11/2nW82qo7NZGHBcqHKWMtgD8xenie5WGywUM/8FOsSemqr0UwP/XKtk4P9axCr51BbKIolrlPaSNRY1epw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB8266.namprd11.prod.outlook.com (2603:10b6:303:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 23:02:15 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 23:02:15 +0000
Message-ID: <d713c903-b8fd-4909-a520-6426fabc003a@intel.com>
Date: Tue, 9 Dec 2025 15:02:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, Fenghua Yu
	<fenghuay@nvidia.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<shuah@kernel.org>, <skhan@linuxfoundation.org>
CC: <babu.moger@amd.com>, <james.morse@arm.com>, <Dave.Martin@arm.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
 <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
 <f2e30c0b-018f-4988-a1ad-9ead6af7994d@open-hieco.net>
 <ca161ef9-c9e3-498a-9e6a-aefcfec46dea@intel.com>
 <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1ce7ea26-6e97-4640-86df-c8dd3e623002@open-hieco.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9f1cfc-275b-4e79-a834-08de3776fee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm9paEIyaHZUNmM5RWFzT1BSY3UwMi9OS2x2cUl1NHJFVHBaWGlUUjJidkx1?=
 =?utf-8?B?c3ZDMmJ4d0dhRWdSc3pVSk9SdGMrOVpEYUFnSm81RlU2aUlyZlh3REwyWncx?=
 =?utf-8?B?TXdUWGFnREZvVGNrN2RZZkhIc3FJTTN6NDdUdWFvdEtXd2gxL2NRei9MK2Fk?=
 =?utf-8?B?dVB3ZzJyNFVRWnpzUHkzcXRnRUhKajVoZ0NDaTlWQVZHcFpWcVBpbmlOZDlM?=
 =?utf-8?B?aGh3RmNLam0xNlY5akxMaUkwWkFrT0x0ZU9mZU9GTmo0eDhPY2htYlU4QlJm?=
 =?utf-8?B?OWdCVjVyWUpnTncxK1hYdzhuRjk2OWdhRE9NdFROS0d0YWZuWjJzOU5uMGlj?=
 =?utf-8?B?dUJzUDMxOTFPUDBteFdsQXhsbkxPTHptVjVBMkRIZmVOak9KcEpzMldxNExZ?=
 =?utf-8?B?UG9HUTdYQ0RITUV3RFJVRjFNdWhlWTVNa2xoL1dQTlhpd3hoZVlxMUZaTmhW?=
 =?utf-8?B?N0laVk1sbXV4OGhTZkJFYWJ0bXZ0WGlia1d1NHhvNm03c0EwckdQb3hvZGoy?=
 =?utf-8?B?N0h6dzFhMW01cGVNMUxwbStmdWhIMTFCT3puZStLTEZaU240Z3RLdjZPWEI5?=
 =?utf-8?B?VVBSN04wMGJ6dGExMitPQytub05qV2dtOG9aMEFWUjlhbkxrYkRaQ3d0WUl3?=
 =?utf-8?B?ZU9qajdtdksxc2xjZDhmVXhZUk5rSDV4ZUhIOCtyVThEUzZ1NUFuVndMM0JK?=
 =?utf-8?B?SXhwdDZwWjR0clA0SVZzQ2dubW9yajZtbTRRZkZTSjJUK0dzN3JpMjhlTUxa?=
 =?utf-8?B?MGgrZ2R3cUhPV2pGc1NYQm5VajVwU1lTMmNTU2Zyem52OHY0czJtaW5oaitt?=
 =?utf-8?B?ZGF1WjRSUklRQ0Zpc1NhdHc2UVd1RFR0MXYyM0VFQm9Wd2hrNys5cWg5Q0Ez?=
 =?utf-8?B?WTBvZ05PVU1hMTJnZGpMLzVQNnpDOGdkK2pKSkV2bTJEaFZYSHRGSHFHWk5R?=
 =?utf-8?B?L2d5VHhVamdzeTA0QUZ3N0RFWDhYYk9wUHpXcnRUNEUvZGl2QTZ3V1BZNTkx?=
 =?utf-8?B?T0tWR2Q4TXFROExMUGM3M3VQOG1YSXI4dmVhbC9ZZEZFNFVxZUxjNUVicERu?=
 =?utf-8?B?ZklKcHdwa1RVKzd3UDFVbDJKWWMwNDhzQ2pjbGo1Zzcyck84ODl1cHozRzNw?=
 =?utf-8?B?Rk52YUJtVm5BZ0c1c1lCSFhIYzcvRGt2Qy8zbXB0YU1ZQ3lxTTFqZndZUHhW?=
 =?utf-8?B?UGY3M004RFBJQVpRcWlIb3RoeEtob3ZHbmFiWUR1NlVMZDlLMWRZZEJkZG5H?=
 =?utf-8?B?eER0K1BKWFNrOFF0YnBrQnFxNEhHV3YyY1RTYU9GVXdCczNQeE9meDU3UW9R?=
 =?utf-8?B?aEQwRVAwRk5wT3RNQkJCQ2ZJbUpUcndBcnlxU1plN2JBWmcza1BXOTkwQzF5?=
 =?utf-8?B?QXh4dHBSR1ovdjlxMjZaWGxQRXREVVJ6NTFFdnZxRFM2TnlkRHZ4RHVxMHBj?=
 =?utf-8?B?T29nU2o4VUI0T2RGUDR2amtCWFU3NnVTaHpIY24zcWpKS01HdXh3b0Z3Y0NV?=
 =?utf-8?B?eGIzc2U5MzZhZGxLaS9GK3hHWTlteXhNL1lUaFUyQk9ncnhVdnYzcVA4Wk9V?=
 =?utf-8?B?WisrUFduSEJwcDRneE9zTVQ0Mm9Qd0pSYzYyeC9rY2d0Vi80c0hqY3A1Ym9i?=
 =?utf-8?B?RzBPUElhUXllNTV0K3JkOTdNMXpEVXlIbWtmY3oybDZ5R2ducWJ6amlYa2pV?=
 =?utf-8?B?UjlmRVJlYWJ1aXpXZEw5U01KcnBHNUlYRy8zQVhzc09QbTk1NjZFR1RjVEFj?=
 =?utf-8?B?aVhIa01yRVY2SGJldEhqR05JNXd3ZVZTbWM3S3RnTFE3bUk4dUhHVXplTmdj?=
 =?utf-8?B?Wm1UQi9qU09FOEJvSEtZWkZLcjdtUmpnMkhHM3ZLclJBU0VKNTMrdEt4MGt0?=
 =?utf-8?B?ZVNZaHlhZjgwSlU0ODZ1dHFaMnJWODZhUU1LeHMzWUlzcU14dnBwM3k3V05r?=
 =?utf-8?Q?+GcVV6ijhO2Hi/Y8Sv8+f6p8MYooxQRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDF5S3ZmeUFaWnNCT1BjSHViVTRJS1FvODU1dnY3QkZ5ekptamxkeGhZSzRV?=
 =?utf-8?B?dUJFTXR5TmxmTWlmMGlOMzZRK3NXZ3dTL2VTRnVqenZKUmRhMHRTam5OQTNs?=
 =?utf-8?B?dXphSnR6cWIyWE9JR2tVT1FzOGJyckU2UTZVeTFMdms3dkxqMFA4WjZWaEk2?=
 =?utf-8?B?ZU05OG5YckNkdlRUTzlUU0lqVXcwQUVBSGVlUmRoRTV4TTlmSWxHdTcwc3l4?=
 =?utf-8?B?emxaOFlxNlN4RFNsbmtuY2FQa0dzT2o2cEZrQ1NEWldselFxOHdLaGdoRTM3?=
 =?utf-8?B?bjRiUXE3M2tHdWs3RkxIZ1dsTHErMGd5VFdZelFvbGw4OWVIQVdLV3IvQzZH?=
 =?utf-8?B?NXgxOHd0YUUxcFhwMGxJb29seElCSlBjdmxEU0lNMGRwL2tSYnBJTFgvRUVN?=
 =?utf-8?B?ZER0aDFLcWdLN1R0Qi9nSUJKc3Y4d1V0aFI5bjZMRk5IdUhZdTJWTmxHU01s?=
 =?utf-8?B?MG5VUExQSWRTOTFTZXNOYmJHcU9UM2g1QWNoYlJyaUdYLzcvNzg2Z2FEaEZk?=
 =?utf-8?B?MVZsVjB4WkFFQ1ltUXpoMTFmRWZXSkdXVzRvMzBKRU9Mb25RQVl3Yng1VTdq?=
 =?utf-8?B?ekhpOWExVTBHQ0w1WFFhMjlwMjN5V0NvZlVxR0llMTFUbUJOR1U3SHJhMDZD?=
 =?utf-8?B?OHROSmJWYm1TSXk4azgxaTFSS0c1MXJ0UDJuMzk4aHRDVndENG1BN2VQQ05V?=
 =?utf-8?B?dUR0N1ZRWU9LYkFQTHN1SHZvYllteHNrcll3TGIrWjNQR3Y0MFFvQTFZbXFP?=
 =?utf-8?B?TkxTTlJiNmp2bEI4MVcyRXZEaEpRVDY0TG40Y3ZxcDd2NjdSdE1DalpDRURK?=
 =?utf-8?B?aEdyMDNIby9QemlLNzVCTU9PUURkSTdFSDRlQ09jcTRxQVBGRkVRdkFlaldN?=
 =?utf-8?B?MEp6UzU1My80VUYrK0ZSdm9XdFE2bzNXZEw1d1JtQ1Nvc2RKdnNNYkwyRkxp?=
 =?utf-8?B?dVRkSG5nUWVxZ05jalh6V1QvbGVsRTNlbUZJenVOejJIMlU4T1ZaNUdtRWU1?=
 =?utf-8?B?eTdTYkpqTEwwcUt4Uno4M20wdGJKTUQwbkhWRm1MLy9nYnQrWmR6SS9oL2s3?=
 =?utf-8?B?ZldPYmQ3T3RQdURCeWNxb0NZK1dnM0RTWVdWYm13aVdrRGNxZE9BN09tQS9h?=
 =?utf-8?B?d3R0aG16RjFZMzh2NHdSRWp6SjFXcmlPRGdsSjhGZ2JwQU9nYVNIV0JmdzlY?=
 =?utf-8?B?dXBSa1VubDdsY09HTkJIN2FCRVRpVGk3RTNXbEFhbG90SEhPVWhqY2dCMHJJ?=
 =?utf-8?B?a1RUanNXUGpHKzArdko5OXZ6M3F1MzRXd0RWcG43Y0FKcGxZcjcwckNmQzFo?=
 =?utf-8?B?L1BnK3FVdG0yUHhSTUszMkNoUjgycm5OZHVoRlFHUi9ZQ00zUFZLWTBZamdR?=
 =?utf-8?B?TmZRMkI0MVBqeVlGdHNJeHZXQVpvTi9sSkZmWUN5UWR4ZDhyd3ZMc0NDTGxO?=
 =?utf-8?B?UklhM2lYZCtYTThDc0QzSnFsMnM2OGt5bWprTEZ5bTdFV3VCUFg1VmJEdVBs?=
 =?utf-8?B?U21Bc25OSmVyV25odnJXZ0VWcDA5SGttekQ4c2JxNTJiNUlsRjhueW9jUXZl?=
 =?utf-8?B?b0NtaEVJMDJGVktJNGhUcVYwNUlaQmZMQXF4SWVUTms4dEcyaDdjc0drMVRP?=
 =?utf-8?B?VWcrdllFWWdvZE82NnUrS1RMTTBIUmtHSUkra3k1dWtkendZSUVNWkg1c3pR?=
 =?utf-8?B?MTZTekVCWG9sT1ovRlRhTFk2UjYyU0FhMFA2MjlOTDJXcHVwYzlVZXdkU0hZ?=
 =?utf-8?B?SE9nMWczM29hMHVVSUQzQ244QmJBSXN0MVFvUGxQbzh6ZEFJYTR5L2EvU3NF?=
 =?utf-8?B?TkNNT08zV1IwRVRqcmxFYitmTU5ObFdEZ2xEUGY1TXpINVhUbUY1VlFQbml4?=
 =?utf-8?B?UlRVYnhKWkpMakFpZ1ZYcElHVEowbCtVaFJLbkNDQ1N0ZmU4Z3UyRUFEUVFk?=
 =?utf-8?B?a3RMWXB2UTNjVzVrR0VKSjh1dXhXM20zMlNlZDd0Y21QNi9sbytzcXA0eW9t?=
 =?utf-8?B?S0UxdVZValV1UWE3eXRtQWhRdldKa1BCcVNzeHgyeUU0ckhxY1lMS1o3Y3Qw?=
 =?utf-8?B?bXRzUFNUTHp3bHVJYWU0V3poR2xhcGp2Z1JTUUJMZVhFUExCbzVZSVNjYWV6?=
 =?utf-8?B?OVJKUnd1Umc3eEhFamU2TVRyZW94Nmc4S0o5M3plbWZPOVJGZDdNY2U3L3ls?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9f1cfc-275b-4e79-a834-08de3776fee1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:02:15.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUVe4sSN7vrtDWdoPxGwq+9kzsKN86pGyaA9Pylo9kjOlzPUK021GOvH2hsIQwz08ivmKEMdfuXSDz4BcYsi68Dmo16zJDUVOc7bTiqPnjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8266
X-OriginatorOrg: intel.com

Hi Xiaochen,

On 12/8/25 10:10 PM, Xiaochen Shen wrote:
> On 12/9/2025 1:57 AM, Reinette Chatre wrote:

...

 
>>>   In file resctrl.h:
>>>     -----------------
>>>       /*
>>>        * CPU vendor IDs
>>>        *
>>>        * Define as bits because they're used for vendor_specific bitmask in
>>>        * the struct resctrl_test.
>>>        */
>>>       #define ARCH_INTEL     1
>>>       #define ARCH_AMD       2
>>>     -----------------
>>>
>>>     The comment before the CPU vendor IDs defines attempts to provide
>>>     guidance but it is clearly still quite subtle that these values are
>> I wrote "clearly" in response to the earlier  patch that did not follow the quoted
>> documentation, implying that the documentation was not sufficient. I do not
>> think "clearly" applies here. This can just be specific about how these values
>> are used ... which this paragraph duplicates from the quoted comment so either this
>> paragraph or the code quote could be dropped?
> 
> Thank you for the suggestion.
> The revised patch description as below:
> --------------------------------------
>     The CPU vendor IDs are required to be unique bits because they're used
>     for vendor_specific bitmask in the struct resctrl_test.
>     Consider for example their usage in test_vendor_specific_check():
>             return get_vendor() & test->vendor_specific
> 
>     However, the definitions of CPU vendor IDs in file resctrl.h is quite
>     subtle as a bitmask value:
>       #define ARCH_INTEL     1
>       #define ARCH_AMD       2
> 
>     A clearer and more maintainable approach is to define these CPU vendor
>     IDs using BIT(). This ensures each vendor corresponds to a distinct bit
>     and makes it obvious when adding new vendor IDs.

Thank you. Looks good to me.

>     ...
> --------------------------------------
> 
>>
>>>     required to be unique bits. Consider for example their usage in
>>>     test_vendor_specific_check():
>>>             return get_vendor() & test->vendor_specific
>>> -int get_vendor(void)
>>> +unsigned int get_vendor(void)
>>>  {
>>> -       static int vendor = -1;
>>> +       static unsigned int vendor;
>>>
>>> -       if (vendor == -1)
>>> +       if (vendor == 0)
>>>                 vendor = detect_vendor();
>>> +
>>> +       /* detect_vendor() returns invalid vendor id */
>>>         if (vendor == 0)
>>>                 ksft_print_msg("Can not get vendor info...\n");
>> detect_vendor() returns 0 if it cannot detect the vendor. Using "0" as well as
>> return value of detect_vendor() to indicate that detect_vendor() should be run will
>> thus cause detect_vendor() to always be called on failure even though it will keep
>> failing.
> 
> Thank you.
> I got it. In original code, "static int vendor = -1;" does it intentionally.
> 
> 
>>
>> Can vendor be kept as int and just cast it on return? This may be introducing the
>> risky type conversion that the changelog claims to avoid though .... 
> 
> This is really a dilemma.
> I could keep vendor as int, even thought the code doesn't look graceful. I will try to add a comment for it.
> The code changes may look like:
> -------------------------------
> -int get_vendor(void)
> +unsigned int get_vendor(void)
>  {
>         static int vendor = -1;
> 
> +       /*
> +        * Notes on vendor:
> +        *  -1: initial value, detect_vendor() is not called yet.
> +        *   0: detect_vendor() returns 0 if it cannot detect the vendor.
> +        * > 0: detect_vendor() returns valid vendor id.
> +        *
> +        * The return type of detect_vendor() is 'unsigned int'.
> +        * Cast vendor from 'int' to 'unsigned int' on return.
> +        */
>         if (vendor == -1)
>                 vendor = detect_vendor();
> +
>         if (vendor == 0)
>                 ksft_print_msg("Can not get vendor info...\n");
> 
> -       return vendor;
> +       return (unsigned int) vendor;
>  }

I suggest this be simplified to not have the vendor ID be used both as a value and as a state.
Here is some pseudo-code that should be able to accomplish this:


	unsigned int detect_vendor(void)
	{
		static bool initialized = false;
		static unsigned int vendor_id;
		...
		FILE *inf;


		if (initialized)
			return vendor_id;

		inf = fopen("/proc/cpuinfo", "r");
		if (!inf) {
			vendor_id = 0;
			initialized = true;
			return vendor_id;
		}

		/* initialize vendor_id from /proc/cpuinfo */

		initialized = true;
		return vendor_id;
	}

	unsigned int get_vendor(void)
	{
		unsigned int vendor;
		
		vendor = detect_vendor();

		if (vendor == 0)
			ksft_print_msg(...);

		return vendor;
	}

Reinette

