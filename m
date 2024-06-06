Return-Path: <linux-kselftest+bounces-11278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2038FDBA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D831C219C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 00:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691594A2D;
	Thu,  6 Jun 2024 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QazOTMB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBD748F;
	Thu,  6 Jun 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635120; cv=fail; b=F8gURsogN5mbhntY5wI08QHPQPZ7wW3ZdupqdzSrr3m5EUznas4PZi+xp3DsvrCJi/JMK9Vtn4OWehK5t2R94xizeILSVtDcQziflZGMxztZRwYjm/KyPSx5vTe/4EBbGMyjyUAA3ki5nJN6IHlj9mYlFxpz9TTLFTwgu8U0lCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635120; c=relaxed/simple;
	bh=i26ZNKjA5/26pTI7gMSKArdLqtUA+25UTzb3QW+Hhq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMr/wqphjZZYLxADBhTGz+Zulp4kIlWfl9vE3QjqjSlb+prX6hTgFrMW/MiJTyGXWrgKA9hKLCDRst++OOyz9ygGsslUjE8AdKQwIQuUQ4vqJNSzj7vD/sGiqtItCuL7qtgE457sZjptOqEFD3hiOl91kop0/LSlG4/ygK2x0uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QazOTMB4; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpkxLbM3a23A1hmcE/Rf8+6t/tGm3jHkG6iaPE6+ObktidyFTdGywPw3cJLuXbw2r6FNCzi2ImSHqPnRzRye/2R0HQaILJz4q9DH7KBV94UpY7dGF7JyPSbV/gjN5sdQ8mbAI/mPv6bMouAFOJUY5poLPLHISaVOJRgoRGJEihlU+yh6DOxfEkkdmmZ+vnKcIJXLI1va4OwJ5RGIiuvyBgtMG6MzcVnmwjyPb40bmID1wDyd/xP2rUUDEieByoUaZeMb/FG6+CAKI4C6bp9TuldPhrEF+kjIOB4YOBAbfJgN3zU/JsFAoo/OMbqddZsrfFNzCk7tmJs3tKx/FpWmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaiOYnp1ZQqOIkxg0wDszBgy0YlOZ6KL4syzDfCaeaQ=;
 b=VTBglN4yAJ9hZefZwTVZlg/CrIyjGarHUeR5HZh8e1r/v+5fi4dC2wj5ZqLHsNxnJAWUql1Ts48Ytvr3sthPrxoMtFZz03HwxUYXYnkZ4ZpI2ATeoiJ1JbuNqrhHpPCV8LpNNiMCeKt3T1c4+g9oM6Slo/NrZ8A+3TNEXY85Xuo86Ie5/fRsp7qobr17iq4wUxOgilVXIUNX+hakwhkV+Q/DaBC5DB9j27aW+L6R/nHw2m4n154PEyghGsu2XiZvRrfwL5ZkyksY3N4ATBKMrh15+lLuQTMtLjRNu7sKBznyC4u/qLPXhgK5DSXPMl6Qknv2EFHOiG9F2Yhb02UELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaiOYnp1ZQqOIkxg0wDszBgy0YlOZ6KL4syzDfCaeaQ=;
 b=QazOTMB4Q2ze62S1D6va6p12XlfdgKBbNkMx/sTccaIS6asBO6qJwVBNzBL2T19U4OTZD8YziCq8vMA/S2PGHV/YST2l30ImOxDC8T28du8UF/TKb73Q5KQHIZQo/WZ0bzgY10oNRxfVLIfl6K+D4fNxMyfv4ROXgeRU7+l7vNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV2PR12MB5943.namprd12.prod.outlook.com (2603:10b6:408:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 00:51:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 00:51:55 +0000
Message-ID: <3d13b669-ba74-6c63-8591-8e4eacd6524f@amd.com>
Date: Wed, 5 Jun 2024 19:51:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Reinette Chatre
 <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
 Babu Moger <babu.moger@amd.com>,
 =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:5:bc::34) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV2PR12MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 039e9dc2-3f45-465e-68d0-08dc85c2dcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmRhS0ZFTVJHaVY5a1dDTWFReVB6My9HcXlmZXp4TXZIaDhjMnI5WFRqaUdZ?=
 =?utf-8?B?Q2txcHpPaHF1QnJzZTdNZWJGaHBoN0lSTmNpZ1NnMUNFalZzcjRRK0Rsb3lo?=
 =?utf-8?B?VDVvallJVGNKYk9UcGxoVUZpZFFPb3NNVlk0Y2RmazBkV1VqS3RrOVkyb2JU?=
 =?utf-8?B?QWMrdHNrQ0tGQmlIYUlaMEZNUm1aSGlXRGJ1UVNVRzNWeFlLc0hwSEtzM0hq?=
 =?utf-8?B?d3VsenRwZ3hBUmRuUUF6NURkeHNxVHlWa0xFZ3BMU3BWdzZURVpxNzc2b0FG?=
 =?utf-8?B?bUozVDdtT0NTNWQwYmtweUV5QnhaajNQQ09QRXdLcmZNaExhaWhiMmVPd0px?=
 =?utf-8?B?bWNCR1k3bHNQdXpMTWJkc0lEUWxWQ0I1NWdoQWJRR1pzbCt1U0l5TUZoTDN3?=
 =?utf-8?B?M3NlblF6RnduRjh0Tm1id29RZzJad29xTDkzSFFmTThtU1NFVzNtYS8yZlov?=
 =?utf-8?B?bnc0R25ZM1dBMEQwR2tuU3ZMOTJKU212WGRhbFVuL1dUeFZtNWVaWlFGTHFl?=
 =?utf-8?B?UXB4TFYyQlB2aGZ5eDRkU2xoMFBLSWQ2YVNLL2hicEV1WW1acTRVQkExdkRM?=
 =?utf-8?B?RTZ4R0FWWlRUSmRQNnRXMWh0eVFvenJZU2d1VHRlaGI5S1dmU1NDd2NOdmRl?=
 =?utf-8?B?dWYvejQyT0lWVVBSdGNxMkl2eFRJODJhN0dXeFVXSkNuaWJ4SEwvTDBUT0FS?=
 =?utf-8?B?ZG5RRkhOODNTNC9yQ0NFQ25vbDZqd2lwWXphOGtyLy9jaHZDQldsUjBPUlRm?=
 =?utf-8?B?MCsycHROZGZIMEZuY2xYVENBaU9kckhIMWhBN1hmQzc3RGZwakw3bVV1MHNI?=
 =?utf-8?B?dUVNVFdaUlNlQWdMK2JEWCtteXN1MmlxWUNzZy81bVRGSUZhWXM5SzZtSitI?=
 =?utf-8?B?SSt0T2hWVnNTalJML2dzWHdMTmFtZm9zU2FkUGN5Q3p4aFozRjFtaG5iYzdT?=
 =?utf-8?B?RjcvVVBZc3pHMVRtc3hrci9BMWFsL0VuUkpWQ2l4QXBEaE50OEZETzV2em5v?=
 =?utf-8?B?dGNjT01US2J3NHBBek1BRmk0MTFFeXRDUkJya0E0c3c2UndIWkJTMm5LRThz?=
 =?utf-8?B?cU93eGtBT0ZRbWFPN2tmRnVqbHh2YTU2dUdMZzV5cVYwaWdoZG9WTVJyNVhP?=
 =?utf-8?B?c2xlcVA0M1NUb1RMcHg4czUxUHhHUVV5dmpQT3VCY1NPT05mMm5rMlNRekhk?=
 =?utf-8?B?Um8zK1JVWXpLcktGemlLdjBGZERubEk2UmVBTEZXNzRVMXNqV3V1N1podXRh?=
 =?utf-8?B?VjBlL1R4MUNiZ2plLzN3Q3Y0Mzd0VTRPTmlnQWxYcjdmQnpPbjRROTdiRGZh?=
 =?utf-8?B?VlljWFhnY0g4Wm8xUDBIMUw3UzJpRjNFeDYvRlEzY2grcnNmWTBRUXU1Nkhr?=
 =?utf-8?B?NW9iRVFnVURWVUhEMm5LeU85U1NDbDU3QkhEQXg2NTRlTFhNMlEwMjNkV1By?=
 =?utf-8?B?TGdmZk9rSkR3aHBlR0hySmx2Uzh5bnN3akVPcUxjK28rbTJEWW1sODlvcWNv?=
 =?utf-8?B?MExWTjNGaUJ1endZZ2RLODJmeDcyZEQreVczMmp0QnJtOUdkNW41MDRURmxR?=
 =?utf-8?B?Q0JyakhnVy9udzJQQ0VsSHUxNkNjUkVWRzhEL0ZYUGM4dVBLbWhwaFlGTlNw?=
 =?utf-8?B?bk5BREtmZUMzWEhSdWg4YW5HeVpqQVFHOTBpa0RaWFVxU1c3amp4WTFvMVlv?=
 =?utf-8?B?U1dCaklHSlgrc3E0cVpaTFdJNUl6UTdGam8yZEYyMkhnZEFhNER6RkZEM1lF?=
 =?utf-8?Q?8cPMmdwhDjB9OoLAFZCLHN43UO62gf0bzvivIli?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjBXM1VIalN0L2FPZ2N4ejRzdVZQZUVnQi9zL2ZvRWJWeDRhMWZHZGNDWElZ?=
 =?utf-8?B?T1M5cW5aK3NUcFFpb3d6UGtxbWxOQk4yVnp5MFpMTElIVGlPK0dTWVZlMGhN?=
 =?utf-8?B?d29MU05KTkhITzhPbGJLM2toakFXQkpjWllIZkN4VzFZZVNVQ2l4SHZ3dDBR?=
 =?utf-8?B?RGJib2o3R25YbHM0QXRldm9XNDJBSFYvb0Q0NU45akxRaWx3RGFYYm8yUlhN?=
 =?utf-8?B?Y3g5SzZPZ2laa293K3pZRmt0TjhvQUM1amlFcUpBNFQvRGEyZVBJMDdOclZH?=
 =?utf-8?B?cDdZQjdwU0Z1MXVxNW5zU2gzZEIwUHh0Ni94ZHhweE1qc2JEek1qWkI0L0xL?=
 =?utf-8?B?dk1kZWpXR0YxT1lCOEVJZ1dYcVdLQ3htK2NENlJqMWJvWjBIVHZzRkphZFJ6?=
 =?utf-8?B?QjRZNThZRDEvZ0NPZEt6Lyt0dVVoUGd6T2dNbTZra3Q1YVkvLzVhQVJsTkEv?=
 =?utf-8?B?am9WOVQ0bHdPdjFRemJVcmZnenAwTlNoanVObmlYS0pFVWxZeUJDZ20zZVI3?=
 =?utf-8?B?R29CU1lmOFI4Vkl4dlVqWTB0NXBDUFAzcFBSejhra0pXazVRYUJyMkU5YXlN?=
 =?utf-8?B?aU9VS3VHMGUxNlF0cjZWcmxpbXBqQzdCeml3bFA4Q1hVcjRhOUdSK0gxdHZq?=
 =?utf-8?B?YzBySTF6UVJ5UlZNUEREejJZdDFIM3EyNXpuWndWSHo1bmZkYmhQUFJxelQx?=
 =?utf-8?B?V0tQZ0RlVUlJaEo5UTByam91YksrTFZHeFdaYVFkMUMvTWF0WERidGpUdEM0?=
 =?utf-8?B?OW4ycUxDUE1LNTI2OU1GUEhjdlY1QkdsRlhqN3RaaFEzNXNEbDlzY2p2bEY5?=
 =?utf-8?B?RFd4R3VkMGJPN0w3anNqRUJYRWNpL2I4STM3L05KN20rSFhldnU2MTZQakxY?=
 =?utf-8?B?NnFHZ213K3U3T1M0VzBIRXdNZ0dadVBIL1ZGeTY1VHl3dU1aSTEwQktjbVZP?=
 =?utf-8?B?OUJPbk1wZ3lTYkR6K1R2VHpiVjRjZFV2NVFOb09McnQ1MzZUc0lYQ1k4ZFJH?=
 =?utf-8?B?dGpTdWZRcVdRUjBXQWVWeFJISWJZY1VSQUtvS3FQWkVBQVZlNEZNV3JRZXg3?=
 =?utf-8?B?WXZXR3pIUGppZFl3RlZpbERIampubmVJUTRjRHlrZ080N1NBR3QxbkFDVVNJ?=
 =?utf-8?B?dHlkcW0rYWdFSkUyOWp1dTIzWXYzUXFsUGdBMXQ1Q3NPeWpWbkZQME9kckF0?=
 =?utf-8?B?bDYvd2ZpeU42b2pJWERxc29qVGpHUjdUUi9LaVZ0Q21MSWNENXV3TFArczNY?=
 =?utf-8?B?Nk1uMldSbXRuZFZFR1pjQzJJUlFFWTZVTGl0K3g2SjhXQThLd1VKZ2swRzlE?=
 =?utf-8?B?RHN6TUd2azhvTVlYbWV2YkFyYkNEWmZUMXp5MHFwN3QyNytENGkwcGpjM1Y1?=
 =?utf-8?B?NzF5bzBBMnlzQklVcEFLbi9ZdXdBb1J6T0JKMHk5eG9EV2lxdit3enZiY092?=
 =?utf-8?B?OC9ZZW9rVlZvbnY1ajVDQ0tjMTI5eGdzS05VYVF1TC9lMnBoVDhiNjdpNjVU?=
 =?utf-8?B?RjVLMWJnd3hyU2EzeHFCTFJkK1k5RFo2aDBtejl0L2JlMkxaM3BUYmVVQmMr?=
 =?utf-8?B?V0lZdHkwYU03d1hwTDRqc2VvQTZEbjE2ZGRnaVN0Y2lTMi9rd0s1TGVGOFIy?=
 =?utf-8?B?YTJaYWpjOEhxY1o5SnUxcnAvM1BCVmVwR3ZQaWZwUEJDRlRTUlBzb050ME9T?=
 =?utf-8?B?eVlhWEI2VGwrbEVuQVVaMzlEL3Z0MTZuQkhHaTRGSWZONHR1bjQyNEhkM21p?=
 =?utf-8?B?WjFNWGJrZjRBR2swQ3lMVncvMjQweVBCaGQ2Z1lpZW9HbkxxL29BeXV6VWww?=
 =?utf-8?B?a2dRMlVpaVpiUkMrNnJ1Vk5jV1RPR1FJK2krRU14SDRZQUFuc0thZnBWZEpJ?=
 =?utf-8?B?OUpuSDNhUVlQYnFkUFkweGpzKzdGYlo3NUhhS3hnTVNzQ2V0MjllY3ZZWXBO?=
 =?utf-8?B?MUpLcnluT1NqallxUFRQMFNLYjBPSTNGOC9JZ0ZvV1RjNml2REJCam0vekM3?=
 =?utf-8?B?T3hGeThudXZ0ckpQRHFtOUFTK1BhbUJSQ3dqakg5bFNsUEphSGMvZkZRaGhl?=
 =?utf-8?B?L2xCVS85NlBJelU0RzJmZ2hyUHRjcEg0cU91dU4vd0Z0QkNXR2NCSm9EQmI2?=
 =?utf-8?Q?uJ7A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039e9dc2-3f45-465e-68d0-08dc85c2dcf0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 00:51:55.9344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dutm4lwZlEOWfN6fQZTOC1V3p7ayOxzpEQwZb0PenMrhQd3/s8vd2pjd5B5l9gwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5943

Tested the series.

Tested-by: Babu Moger <babu.moger@amd.com>


On 5/31/2024 8:11 AM, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> Hopefully these reach also Shuah successfully as I've recently seen
> rejects for mail from @linux.intel.com to gmail addresses.
> 
> v5:
> - Open mem bw file only once and use rewind().
> - Add \n to mem bw file read to allow reading fresh values from the file.
> - Return 0 if create_grp() is given NULL grp_name (matches the original
>    behavior). Mention this in function's kerneldoc.
> - Cast pid_t to int before printing with %d.
> - Caps/typo fixes to kerneldoc and commit messages.
> - Use imperative tone in commit messages and improve them based on points
>    that came up during review.
> 
> v4:
> - Merged close fix into IMC READ+WRITE rework patch
> - Add loop to reset imc_counters_config fds to -1 to be able know which
>    need closing
> - Introduce perf_close_imc_mem_bw() to close fds
> - Open resctrl mem bw file (twice) beforehand to avoid opening it during
>    the test
> - Remove MBM .mongrp setup
> - Remove mongrp from CMT test
> 
> v3:
> - Rename init functions to <testname>_init()
> - Replace for loops with READ+WRITE statements for clarity
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> - New patch: Fix closing of IMC fds in case of error
> - New patch: Make "bandwidth" consistent in comments & prints
> - New patch: Simplify mem bandwidth file code
> - Remove wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> 
> v2:
> - Resolved conflicts with kselftest/next
> - Spaces -> tabs correction
> 
> Ilpo Järvinen (16):
>    selftests/resctrl: Fix closing IMC fds on error and open-code R+W
>      instead of loops
>    selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1)
>      only
>    selftests/resctrl: Make "bandwidth" consistent in comments & prints
>    selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
>    selftests/resctrl: Use correct type for pids
>    selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
>    selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() &
>      document
>    selftests/resctrl: Simplify mem bandwidth file code for MBA & MBM
>      tests
>    selftests/resctrl: Add ->measure() callback to resctrl_val_param
>    selftests/resctrl: Add ->init() callback into resctrl_val_param
>    selftests/resctrl: Simplify bandwidth report type handling
>    selftests/resctrl: Make some strings passed to resctrlfs functions
>      const
>    selftests/resctrl: Convert ctrlgrp & mongrp to pointers
>    selftests/resctrl: Remove mongrp from MBA test
>    selftests/resctrl: Remove mongrp from CMT test
>    selftests/resctrl: Remove test name comparing from
>      write_bm_pid_to_resctrl()
> 
>   tools/testing/selftests/resctrl/cache.c       |  10 +-
>   tools/testing/selftests/resctrl/cat_test.c    |   5 +-
>   tools/testing/selftests/resctrl/cmt_test.c    |  22 +-
>   tools/testing/selftests/resctrl/mba_test.c    |  26 +-
>   tools/testing/selftests/resctrl/mbm_test.c    |  26 +-
>   tools/testing/selftests/resctrl/resctrl.h     |  49 ++-
>   tools/testing/selftests/resctrl/resctrl_val.c | 364 ++++++++----------
>   tools/testing/selftests/resctrl/resctrlfs.c   |  67 ++--
>   8 files changed, 290 insertions(+), 279 deletions(-)
> 

-- 
- Babu Moger

