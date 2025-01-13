Return-Path: <linux-kselftest+bounces-24316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC50A0B0D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71FE3A48C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E06231CA0;
	Mon, 13 Jan 2025 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZqiJcKVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445C231CA2;
	Mon, 13 Jan 2025 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756336; cv=fail; b=he7yWggpT6Qswbf/lNo79HcNga72i2Lrc6ILI9Ucf3eqchjDz9cRRj3kp4ju451X9Z/oZ/ZDX5OPyhPLo3OUkVc76LIyaF7tvsV69HdMQHftlvpQnFSZSEmu1wOff5ocrtFr/Q/z5o5zz5bEJd1rEVVcWw5mi0rbpCSzAwhU+jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756336; c=relaxed/simple;
	bh=l/FwG6xr9ddAAdQhtKFYXHXzjakwzhfoUNjRq2pCg2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NNWy6qU7/lAKRXfT8StzYsYUztKV0wv8Tu3+c+PA8ai+ALO4kd6jTzxTyM+B+Clg64ZCzkXURUT4YrDetk3YmKN502g5y+YK/54tG9uIG8vlL9fdB7MyeVDf7Ire3YxM09OMaZ/oipveW+wqUwmskFsDuckZfAB0LmVK+5UZNQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZqiJcKVa; arc=fail smtp.client-ip=40.107.95.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL35MXlrqsDN4MC9VbNHeDCPeKh0NPMbH56h2GF9W5Cyv1wUYHZc9MH47t64sKzXQcVo0Tv9IU/oIsnZv7XnYyeaGMRdQAiAQwZAjRIEgUJpWvem/OxdP2xc2UyymCu3+Qx9nGWPxVnLV99+vC6iRQB3G9vs9tq4pIhljVjCTX2bd9Zo+wI2Jl19yBnBvcO+4z50BS4d1WtF6G3I8rCsJqqnd0eblusKBjCxpekq3CjSeG5LiRP+RgmUu2bhKMvj/4l3CopxGv2BdsM639Y120dUU68QC4g9imu8hC9c0TPFks4+5FtInu6sivdX36ri+4XFXi8EU7woHGIkB+AGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrI6Cr7Nngc2ZH8qjPRJEZi5a2e7eGTSfI0s2OM+ROI=;
 b=JOE1GP98GfBRRwYo2SpApKvxMUE12qRcocMudri3awZzxNPBgM540mq4+U14Vvnh46PyUOOR7vPWts9N+fU4yoKfiUoB4u5K5rzzSqvmVusZ6T0+iQUCedxtCX92emp95K+fDwlNEbci/SVBI7uuKSFRfZOGAVrttEm2mFf4O1S3cYsprgSGnr/ZZkyXGMzrl53HaHOVH+nRsiiegVGVyIsDpRlPGSojyaP1UhuYVgDPkbnEI9RPZDH2OH7Ey4qH7khOiT6UI9I/kMiicbLVMb7UAbhVLHNAB82Prq+CwkvVkgKaOf1xCAsjgQhXTaRjiCRsjoi3v2N5C9fQQLoIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrI6Cr7Nngc2ZH8qjPRJEZi5a2e7eGTSfI0s2OM+ROI=;
 b=ZqiJcKVakfm8QbNGIegVKAwdQckJEvw6zuuT1gnFjXrL5zU9IhMbHEl0WxKUqclS0rl6zg/etRcc1Br+PQKLV9bbiZVnLSS6IyANx2y6DjJ6ny4/Ogz4z+zeXyMS84071LmpcyH49QLyDaZWD9dhP9rtjNZhoWxk3OY+IvyZmRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 08:18:52 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 08:18:52 +0000
Message-ID: <71ed4121-83dd-4b09-b1a0-1f0654512c2b@amd.com>
Date: Mon, 13 Jan 2025 13:48:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/8] KVM: selftests: Introduce SEV VM type check
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-5-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20241114234104.128532-5-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb53096-5e83-43ba-993a-08dd33aae9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU1LazYrRTVaQ3krL2xxMExmVmpCT042aGhRbjBrSVpFdVBJeUxqcGZmbHU1?=
 =?utf-8?B?NWJtZnRmVDZEWmlPaFVBZWh1VkxPVVVMcEh6L0FCOHdESmdvWlJkSm1DQmo1?=
 =?utf-8?B?ZFlvZGhPNUlMVVVXZ2xNQkRoRVVPVldhV1k3enJqRzAwVnBVcmNIYnhpVmZa?=
 =?utf-8?B?ckVCUUJhZVRrY1V0eGkvbzhMaFpvN28xT2IxWjRBMHI2REo3TzJMRzVyN0dX?=
 =?utf-8?B?Q1pNMjJKT2hPeHcvRmNodStTdVlLYzIrb3ZROFpoSStjYkNTVG40bm1ldnZk?=
 =?utf-8?B?T0QzTXBKSXpGNUgrOHdXQ2RHOFpscnRZeDd3dDJUcHRWdHR1MTc4NVJRdUZw?=
 =?utf-8?B?Sjh2MTdOYXpQT2FUZ1UvQTdZUUxUUWRiWUc3TFhBSmFhRVFzYTRzeU5FbXk5?=
 =?utf-8?B?YXRlRlZKZkhCWVhGVWRtUTQzZnlQdFQ3Tm5TUkJJSkdrdm1ncXZ1RlVkL3ly?=
 =?utf-8?B?czRrMVJPOWhtbEtIU3RtdFpzQ1RaSHpIRnZvS0Jzd05talNtQ0NjMjBhSnFD?=
 =?utf-8?B?S3RwYWdUaFRMZi8yc3pxcTlxb3pXeElWRis5YkdDZXc0S0sybVhaM2k5REJW?=
 =?utf-8?B?VUhuMG5LNWhXQlE2M3RMZTVMci9tNUc0elVDcGZvUFdJVk41N1E0LzlDQzlk?=
 =?utf-8?B?M0RtdmJSQXhGWStrSVdCYVlJcTgwRERhWjlrSUd1ODk4MTlmNXhXblJmY3Jy?=
 =?utf-8?B?cHo2Vm1qUDRBYTh5b3pWUGVySXpLa0lEcElUNTY0VkRVSHRMYktsTnNMazJS?=
 =?utf-8?B?bGRBWDdoVGVmazJVN3AxeGZaYzdWUlZPNTlGSEpieHA0c2ZnL0J1cEZxRlpJ?=
 =?utf-8?B?MkFjaHVTWVdaaVNMM1Y2REEyM1FaNG5EeEl1WVBsd0g4U0JHZHVXckpvaWM1?=
 =?utf-8?B?NWFiSXhCSW5jVk1QdzAycW55YVZteG1xT2Q2TUhPWmptQjVobU5INk9SdHNS?=
 =?utf-8?B?QlJlNE5QVkNkZ2F1WFBWVFF1YjlMRmF1aTkwc1BIeGFPNWVkbTJQdklGcGNR?=
 =?utf-8?B?dVYxOENMMTBMb1NaeFl1WFpRRUFVQytwdUZzVmYwTkFLWjU4T01Gc1ZQUDM3?=
 =?utf-8?B?QWpEemcrVDlqMCtzZ3pKSEZNLzZIQ1ViUVppdjluMy8yRytLNHBkYnVpd0t3?=
 =?utf-8?B?aUdYcG9IYktkN3RpdU9Qc0ZsY2xnQzMySmpMS0lwOFpic1lyamxWUDhldXVi?=
 =?utf-8?B?YzUxZ2R4MllvY3hJZm1mQ25HRUNiY3RBd3Q2ZTRWY1k0QVgydUhzc0xYYVZS?=
 =?utf-8?B?WUI5K1QyK1pHU3VlOTZlY2tuK3RQNzUvL2RsLzY3a25KU1QrY0t2RFpUM0tK?=
 =?utf-8?B?aTBaRjZHVUhoT0wxTEpxZVpiaEtMaXJRQ0IvcHlpUzlNODNyR09NckFhUzNX?=
 =?utf-8?B?bWg2MlBZZXVNK0thR21mUlhQNDB1YXkrN3RUMXNIakd5Tm1ocFlzaXBMdWtM?=
 =?utf-8?B?WlNUSU9EUUdYd05seHJGejlUUFNtMzVtdWkySllIY1RVeEU3S0ZLZE0wQWRo?=
 =?utf-8?B?YWFlTjVBT3I4RG5HNms5UlJuT2E4a0hCb0ZnSWtCY0czUEMrSHB0THZnUE4v?=
 =?utf-8?B?c1hWM29WcWFveFoxNWM4eVlOTGNhRG43RDMxUlNHNzNnUE9GQ1Fyb2c5ejRY?=
 =?utf-8?B?WkJrUkV0ZG9ubE1KU2I5aktYKzk2UU01Z3JhOEVhSE1uZU9xcm95YzVxeUpT?=
 =?utf-8?B?OStUZXl6MDlQVWcxVEpMbXlPQlEvdDlhdkRBVnU1bWlYWUpSYUlzUE9EZHpW?=
 =?utf-8?B?OUJtRDIzMlUreGFXZUxKR2RMVDY0T0E5c0F2UWJ2YzIyLzNIWS9DRm9GR3Jv?=
 =?utf-8?B?NzF3QTl4OTFVNDkvZ2VmWk5oSUFISGNIZ1NYZVBlS2RZRUhQbmUrTmxZYTV6?=
 =?utf-8?Q?nX5byCbCJ6d3v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDAvWStHOU9IMUVqbURRdmdKNFQrcURnaSt2eWhEQWdhSlMxcDNwbWcyTzBX?=
 =?utf-8?B?WjkxbVNrZnl0bnRQRWVxNnVXbHZRK3RSSlczVGJSU1RSQklvdTJlV1I0a2dT?=
 =?utf-8?B?a2hVWGg3S0hYZ1NkZk1NcGpDeU5pSzlqU0xNM0tlNGhjbDUzQlZVcE0xS21H?=
 =?utf-8?B?a3E2M21qUWxITElTa09qNkpWdVNIT3BmeTcrUEhtSmo3WVdXZGxLUTMxS2tZ?=
 =?utf-8?B?Ynd0dEtzL1V6MjJvQkhGSDZOV05BV2NDOUZybGJ6SFhsZDRBa2pyNHQ1dDJo?=
 =?utf-8?B?b3NxUHlCUGliY2lNRHVUTVhjTWZabTV5aUkwcVZPeVhMaUFYQmh5di9MMUE1?=
 =?utf-8?B?Nmg0UGlrUktvdkYzOU1tblRZQ1V6K3ExYnhHa3pQc0piQ05WNVN6NDRHbHNs?=
 =?utf-8?B?K016MmQyS2YzcEEzOTVjVHdUNEROVGorYm1aOGF0WDFYcmlUbjRVZU5XZkVk?=
 =?utf-8?B?ek5YMGNobmFrMUxrNkM3d0Z2ajRaVVlhWnpsNm95emNsenJ6YXRvVWNoemdZ?=
 =?utf-8?B?S1RoK1JSNlkvUWI3dERlWTUzbWt2YmovMDNRV0tSZ1dvbEs3MWlZQStmWlBk?=
 =?utf-8?B?M2hWM0prM3BUQytJYXF0WEZNbmZjZVFVUHZoK0VVUWp5aTBWZVByWFhrNGx0?=
 =?utf-8?B?UVM3T1BLUGRFdis2eStmcEdBMWJhU2t6cmV3RGlKM2JZUVduM053V3lpMkh0?=
 =?utf-8?B?ODdOM0YyTVRONmZuOFFocnUrcjJYNnkvUWNGakFhd0NNMk5GRkNlWnFOVWVJ?=
 =?utf-8?B?QlRaNHBOYkh4RmtqbmRzYzZPN2JzMTRja1B5Wmxsd2h4eUZyc3FsZ1VpSWFs?=
 =?utf-8?B?NlpJeHF4QXdvZHFqUzd6a2pvVmlNNHBRNzloSDc2VkNyZ1cxeVJKWFdtbnNZ?=
 =?utf-8?B?WUZvUkFyQzNCRCtPSWdoWndRbEo0a2RyRy83b0Q4dkx5dWI4N2FJb0lHRTk4?=
 =?utf-8?B?MDVDdlQ1eDBpa0lQNjVlQTIrWFZUSytqRW1xUnM3VTduMXJSb1hMakk4dVlV?=
 =?utf-8?B?WDJJNjhsdXRmdVYxc3Vkc0JVbmdaSGFTaHRxOWhMWTFQTWFZWCtobHVDSnRI?=
 =?utf-8?B?dktncjFRd0Vpb3Q0Qy9LbElXc2RTanhtSkFKdnV2dmtjN0lyVWRZeVRSTFRa?=
 =?utf-8?B?N1IxVXZWYWVWL2MxK2lqc1YxRFZjOHBIL1B1ampWZDVNb29ZYnBFV2JySE9a?=
 =?utf-8?B?MStUdXVqLzM3QlFsNmJXTXlHeEJIVHAvbVlaNjR4SFd4dmJHZFVBL3FIL1Fw?=
 =?utf-8?B?NW9yK1d3T2pxY2VEbkpsbyt3S3cwMVQyRUN1NDFqV042VzJkTlh5czJvV3hz?=
 =?utf-8?B?LzFwV0pac2dGc3FTazhUOElrWDA4ektyUWFBTng2c01YZlN1TERyMnZDV2hM?=
 =?utf-8?B?cnpkZlpzQWxuak5lanZwejJrR2lUakVWQmF6ZUF4dVMvWTBYN01JSG95c0py?=
 =?utf-8?B?UjY5UlJBUFJwcWJoYWFnUVFmUm1ZQWhJaTQ0Ym03V2IzeGZMTzl6bWUxaFdn?=
 =?utf-8?B?SEl2cCthRjVRUm1VbmRsVGFRMytiTFVXaGwxYzJqVkU0cU9CUzFmNTFiOUJJ?=
 =?utf-8?B?NXEra2JkM0hDcVMwOWgxVENuWWRXbnQzcjA0cVI0eWNQSThucXBaelY1NVB0?=
 =?utf-8?B?Z09tZExsM0hoZElmMksyR2hXcDhUdjJDOUFER1llZWNkUURWbUl2dGJIK0Ir?=
 =?utf-8?B?ditEb24rQnVyb3pNN1BKZi8rZUlka1g4UFdzNmJsN29UTERqdk5tbHFFNXgy?=
 =?utf-8?B?NzYwaDEwZzdWQk9tWW1aVGpMSnlJbTZ2QmRva0dBUkNURGpLU2k4ckdGTmhY?=
 =?utf-8?B?d2VCbHJnNTc5VnNjUTI4NGVqYjg4VjVDOUZ5d0dNMFBGNi9CVWlZV1FwQ1hs?=
 =?utf-8?B?Zlo3REV2eXV6aDNXMXdzUmNBTTdISE5QejE3bUU1Ukd5Vk5rWWE3Zll2NmRS?=
 =?utf-8?B?S2ZWcU4xdk53aVJ2ekRGN1d2aWl2Z0VIT284MzRUQnFaYUxoQ2loQWVMbDh3?=
 =?utf-8?B?VGhBTEhYazNIeStKZjJtVUZiSkgxS0lFenFGZ1ZVdWdTRkovRXZFbkFWTmJa?=
 =?utf-8?B?cDRyQkhRalFyVStvWFkwNHVyRjg2cC8yRU9mZFNzcmpPYldZd3NKR2pVMDc5?=
 =?utf-8?Q?8DF5jf1m7fMezzVJyPabSMRog?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb53096-5e83-43ba-993a-08dd33aae9b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 08:18:51.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3cGs5VISFG4OkqimpuK2+aX0jsrjZIWOaX/eed2V5Ij2cKN0zGekPiyDuXgreIqKHJmBVtA9Vd+nv2iyFNjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084



On 11/15/2024 5:11 AM, Pratik R. Sampat wrote:
> In preparation for SNP, declutter the vm type check by introducing a
> SEV-SNP VM type check as well a transitive set of helper functions.
> 
> The SNP VM type is the subset of SEV-ES. Similarly, the SEV-ES and SNP
> types are subset of the SEV VM type check.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../testing/selftests/kvm/include/x86_64/sev.h  |  4 ++++
>  .../selftests/kvm/lib/x86_64/processor.c        |  4 ++--
>  tools/testing/selftests/kvm/lib/x86_64/sev.c    | 17 +++++++++++++++++
>  .../selftests/kvm/x86_64/sev_smoke_test.c       |  2 +-
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/sev.h b/tools/testing/selftests/kvm/include/x86_64/sev.h
> index e7df5d0987f6..faed91435963 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/sev.h
> @@ -29,6 +29,10 @@ enum sev_guest_state {
>  
>  #define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
>  
> +bool is_sev_vm(struct kvm_vm *vm);
> +bool is_sev_es_vm(struct kvm_vm *vm);
> +bool is_sev_snp_vm(struct kvm_vm *vm);
> +
>  void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
>  void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
>  void sev_vm_launch_finish(struct kvm_vm *vm);
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 636b29ba8985..13f060748fc2 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -641,7 +641,7 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm)
>  	sync_global_to_guest(vm, host_cpu_is_amd);
>  	sync_global_to_guest(vm, is_forced_emulation_enabled);
>  
> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
> +	if (is_sev_vm(vm)) {
>  		struct kvm_sev_init init = { 0 };
>  
>  		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
> @@ -1158,7 +1158,7 @@ void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
>  
>  void kvm_init_vm_address_properties(struct kvm_vm *vm)
>  {
> -	if (vm->type == KVM_X86_SEV_VM || vm->type == KVM_X86_SEV_ES_VM) {
> +	if (is_sev_vm(vm)) {
>  		vm->arch.sev_fd = open_sev_dev_path_or_exit();
>  		vm->arch.c_bit = BIT_ULL(this_cpu_property(X86_PROPERTY_SEV_C_BIT));
>  		vm->gpa_tag_mask = vm->arch.c_bit;
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index e9535ee20b7f..d6e7a422b69d 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -4,6 +4,23 @@
>  
>  #include "sev.h"
>  
> +bool is_sev_snp_vm(struct kvm_vm *vm)
> +{
> +	return vm->type == KVM_X86_SNP_VM;
> +}
> +
> +/* A SNP VM is also a SEV-ES VM */
> +bool is_sev_es_vm(struct kvm_vm *vm)
> +{
> +	return is_sev_snp_vm(vm) || vm->type == KVM_X86_SEV_ES_VM;
> +}
> +
> +/* A SEV-ES and SNP VM is also a SEV VM */
> +bool is_sev_vm(struct kvm_vm *vm)
> +{
> +	return is_sev_snp_vm(vm) || is_sev_es_vm(vm) || vm->type == KVM_X86_SEV_VM;

As is_sev_es_vm() already checks is_sev_snp_vm(), we can drop SNP VM check here, right ?

Regards
Nikunj


