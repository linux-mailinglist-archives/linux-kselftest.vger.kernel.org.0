Return-Path: <linux-kselftest+bounces-10333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC448C81C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 09:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6CF28208C
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9517BCB;
	Fri, 17 May 2024 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ih1OI9Dz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783517741;
	Fri, 17 May 2024 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932456; cv=fail; b=trHjvtmgT8J6hOrF3mldpo/ZtiyhK2/OEu2/u9NPLtNz61fSr8zIynU2Oa1pAiRDuac85qRuWpxLl4bHPqh70Qsx2dpKT8rd+IEKu7nPbM84hyQDkzaWonJbHxr1p7IPEfTiDQCN6LZzllAMNaB38oPcTF9Cvc7v5chhBj6KrPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932456; c=relaxed/simple;
	bh=2xljOK9Kas9is6wqwdFi3s8GLtOMCOASQr5bfc3cBxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5r8E4Sm4NxAYx5YVmECR4F1P4AONnVv+2UiWpgYH5crtaiSZmTSWwnrZHoxBnXiKgvDttI6R9hOEj3n/4vMNCvOoqndQFy0C78Cw+mRFmu9xx6tyxeJR+L23nnYTux2ENKCq0Vczwy8A3q1qoEWM9beEP2h4kNHrtoPLS89+UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ih1OI9Dz; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7esaLsgJNLQ8nhLiIvdA1wO87L+dHNBvzP1XPD7zAPewxm5GhFccVaeYsv5CtAlgKdBzsH16teNEK+YODaMLUyeuc8sno6B4vz3Ps7AtJW8UKgGR3T/glzKsZw7MJy64MUdEmPQRfn7ta7JE4usS9Rp1Wh9BU35qQ6Sef/oE7P4SWUQRT12x6onLH+uXpSr4R7+cDzJAQ/05QO519VipV+L/F/LkCM26GqEVHFDHWWyOTVw3ZB313KvrLsHa5XrDe43H6farjCyX/lX6FgOW1C8nWQeunBKXIi0n4qSF/nPByaST3eWqOvirnQF+hu6cXC2+ElPJtaQfpzG0wZIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQetnkxy68nJO8JhawkHqVbfce/rn/0woSu/XqdpKW0=;
 b=Q0nshReBMPTXiWjH4uZ7Qfd20Dec3fijkFJh+wsc7qgoXOswgBnIeyL6zm9rQ1L04IjZNROJafHlcGm+pkysdEvWLqH1Ed0a+hk9tt/ySN7DP4cfwDd+iDb5RoKTHHk4LU2SWff0XXPOPpP9ZYXH57TihYY9b3NnerIDYoX3B4l1y4qlsZbNojxOiNBazG3/HqYr79YUWvOG0BZFsSJIHpEqkpC9iUoZqX7yKXkYJz2m13/LWSwkvtFlWRajtfoF/WL2ltdxSp759SeZzKezBoInuwbACHX90QLE4H0AQjsATSXbpYokqXJxa/C3gh4xABLa1pha5RrPQDx2C8pbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQetnkxy68nJO8JhawkHqVbfce/rn/0woSu/XqdpKW0=;
 b=ih1OI9Dz2ddmKgR0gTBFXsTIpHJNTffGYR4i0ulXxtkj9hP470WFXT41ynDJ1qeT1K/aA837YpoWw6e7pakD87CIMzczw+C3VKq6s4xqdBKwd2CowqWJePF+qq6szwZE2j8ZJxKZXipEN9t8p7xs/JYEd99sASRnvU3o3QbwuMhaVswcqtNtfhVLb+1N8J8v+Rcjkr1/JHSUcx8Xgx5NvGU150eRxmmA5O3AJ7pfjV4jz9GpKlzmBR+V6+qDNhwYLR3rI3ugtxXpR2IRAh8IDfBQ+xXzGthN79nVmyHgM1N0mzgTjAcy3+3ETj3YmRn7+H4nZKrdoVP4sktPftyV9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 07:54:11 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 07:54:09 +0000
Message-ID: <ea0bacc0-2765-4d8f-8b62-0e9c45c560fc@nvidia.com>
Date: Fri, 17 May 2024 15:53:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: rtc: Add to check rtc alarm status for alarm
 related test
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
 brauner@kernel.org, mochs@nvidia.com, jszu@nvidia.com,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240517022847.4094731-1-jjang@nvidia.com>
 <202405170719515a9c6d2f@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <202405170719515a9c6d2f@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 006e10e1-c2b0-4eaa-0737-08dc76468896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1FlT2JmUEZEWU9PYVpXOU01UU9XcU5zRzhrQlYwOEJqY3djVGpRa1NEWDls?=
 =?utf-8?B?dVV5ZUVTWWtteW9RT1BqS0hRRU9KZ2hFZGNRSjdtU2VUWklIdXFYSjhjSGM3?=
 =?utf-8?B?aVlET3ZXUlBMU2lCZ3ZpUk5LeU5MNmNWUkpsdjVDZW9UVzR5cHVFaWRaN2dH?=
 =?utf-8?B?MnRGb2tNUnNUaHc3RWtadDZsTmxUL2Y1ZFU3L3c2OTEwd0pVUmFDcVYxTW1i?=
 =?utf-8?B?L0hJZlRRSEhvV29jN1VCdVNmdlFSY2JVaGhtOXVJY1ZvWFc4VXdNbG00RktE?=
 =?utf-8?B?ODBCSm40NzNwRzZQaFJKcHhwaE5ROTlFWjFHT2JzUko4VDVMYUllcFF3eFdW?=
 =?utf-8?B?QWhKNDdEdm1hWHljOW9sUjBkNHdmZzdXcHZWWUk0Wm10T09HeEFBUllEbmQw?=
 =?utf-8?B?RHdNTFc5ejlPbzJjOTMyM3BNc09kSHJlQWFIemY1dHdOcFR1SnpHTHk5VGlG?=
 =?utf-8?B?a2NROG85ZCsvYzlHRzdEYWYzeldnMnJ1eEprWWV4dlRDMlpNa0VnWjBPUENn?=
 =?utf-8?B?ekVGM2hxODM3eDUrdGhwbS9IU2RFdXRtZjkvWjhKK3ZTM2RaUmVndEZUZ1ZM?=
 =?utf-8?B?WGx1YUlJakcyeDBHajZTMzZKUUZtN2Ivdi9sc3NNcVRGN29NN2lJMXhYdzZ3?=
 =?utf-8?B?WGYxL1hxQ1hmRmdLY0gwUFRIU09BbC9uRTN5bWxNSkEzSUhpcS9DdjZvSHFh?=
 =?utf-8?B?aW8wUjRIZGhhd3B4bUNVUnpJTi9TaGE1cXdKVHdWTllEQmVqRURsaUNoYVZi?=
 =?utf-8?B?a0lLT01WT2xldDE5cDV0MUFPSmI2SlFYOVhxd3Y4ZHF1SVk2T1g5Nk4rako4?=
 =?utf-8?B?Y011Uk9YLzQycmdybXY1TC9yMThESWlXL01pbVdJeU5tMW5sOUZHMFR3S28z?=
 =?utf-8?B?bUFla3lyZjNxZVZsM1dmbytJUXRRS1hHN3o5OUVxY3RBQldiQVJZRzJicmZy?=
 =?utf-8?B?TDU3RlpsdjZyRFBKQ0dIdnZENG5wb1dyYXlLMk5PeVlTbXQwWU1nRk5BWUhj?=
 =?utf-8?B?UjVHdXhmaExITVV2Z2ovNVBlVTJLY2lQcTdGSGF1eTI0OCtCOElIVFFuZ21K?=
 =?utf-8?B?cGtiWHZkeW03UXlrQmRocEo1YWxQWVlmQjEyODZLc25RdUt3U0JaVEVIM1Zt?=
 =?utf-8?B?N3pHQWVBaytqS29IUWJpNnlEcDFKdUNiUFJWQjNtWWJ3QUo4ekVheFJJblNj?=
 =?utf-8?B?WU85cG1GVXhPMGpmb2tvQlpKVll4dVJUanI3SFo3VTUrZTlXdUMra2VLTHI5?=
 =?utf-8?B?NEk5R3NVKzJPTGpCTXdoVWc2L2dNZ2xmWlh5LytGMzNmT3RxZ0VKdlF2OHQw?=
 =?utf-8?B?VEplTXFNdWdOWVNJTk5HNk05cTJ2Skhpb2pXT3oyNUxiUHVZajloMWtGY0hD?=
 =?utf-8?B?NzBzZ2lReDE3UlhtRWtNNUt4alZqK0JRbjNQWUIxd3pUQUVGeVF3OUgzdUdL?=
 =?utf-8?B?eXdpcXFQRlJPNWIxYVhJY1phaHU0WGNhdGZaWVMxUVhLRnVpc3E3aDNiL2JP?=
 =?utf-8?B?cGFka1JSYmhIajJxRmFuNnZ4NEhyajhoRGpIMXRxY2hpclVtRnZmbVVod2th?=
 =?utf-8?B?UmRENHFydWI3RXp4WWtwdGx6bW5teW5FNFFLYlV6dFAvblZNdXpVUWFZZXlT?=
 =?utf-8?B?YktKZmxQUlQwVzl0eC9hNUJKNktzQVpiMHZTWUFiMm9jNDB2RElKd3JJNWlj?=
 =?utf-8?B?b0RZLzl5K3l5eDdOSkJhZGJ3WTBpUHFESGNIMXlBdlIwczU4dUNWa3lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFJhN29PeUQyRUNaMHpMaGkydjkxdjdQa3lDNnkxRWVBdDd6di9NeW5vNUJG?=
 =?utf-8?B?K25URkZNMnR3L2NTVm1wTzh1WXBFNk9mSlVEdURpRWpzaUR4ajQ2VlFERW9G?=
 =?utf-8?B?eWV2NHlnZytPM1NYMGJyR2pJZzVnSTBXV2RKUVoxbk90VTlOK2RqUlBnTytW?=
 =?utf-8?B?RDBRNFdxQVgvVG9WM1dpUmN1bHcxSjdyZEtsUDBWaTBYRDVrakRzRkJOOXc1?=
 =?utf-8?B?V2kxc24rTzluVi9IV0FzSk8xcnlOdEl3MVNyVEZLQlZ1ZjMvcjA1UEtjVmxJ?=
 =?utf-8?B?TzJzT2NjYXFVR2JBMXduVVJRYkJTdUZ4SnNHYm9TK3JuMENITFMrbm9SK0Vw?=
 =?utf-8?B?QUcxbmtPSWt0cllMZFdvTHZIL0xSV2d2bk4rUklCZHozOTVSRWtHUXQ5d3BF?=
 =?utf-8?B?Mk9pSUMwUkZpaWJqdmsyZldiV2dQT3pOSFFKQlJ5em5NS0d6QlUrWnNLQlBB?=
 =?utf-8?B?RGJiRG93aWZCV2owTzQwTkVXRjVKelB3NGZQL2ZIWGRxdk9RSXdRSjlzYjkw?=
 =?utf-8?B?NHVvYi85cUpyd3NHNitkbXdwRnVwbmtENHlSWmRnWk9iVEQraFV3VXE4ZWpi?=
 =?utf-8?B?c0llbHBVaFduRUxEcHJIZ0dWT25oRVhrWjY0R2d3SmpBcmJYNXJxbDBTQWgv?=
 =?utf-8?B?SlNzdnVkQUozNHp3ZVFIck5Ya1lvU0RPTlpGTEM0THZYR1dKUnpXRkx1ZFZE?=
 =?utf-8?B?cndFY0RqWWcweGQ3bnpaZTl4d0I5dmgvVkFMWno5U3JVU2NxSXcxNElJT28y?=
 =?utf-8?B?ZCt3bDJxcTl4VjFxdnFmL0UzeVF0SjA1Y01xVzc5QklSZ2pmeFRnL3MrVHNL?=
 =?utf-8?B?aWY2aDI3N3BLSU5RYXMwS0NPTis3WE03Mk4yK3ZVRG1yNldUREt4bVVTdmx2?=
 =?utf-8?B?YnlwQmE1cFR5OVp6ZjhFYXpaWWduTW4vVS9TRnlaLzAyd3VoZ29wM0JSallQ?=
 =?utf-8?B?YnZUa3lyeXYydXdhZjhiLzZvNkdzYVRXZi9jeGVWSFB6QzBhTGpIMEN4T3Rs?=
 =?utf-8?B?bnpTQko1L0RxZ2dJQXcrMy9LUE1PbG8xTVlEUXZOcGc2NThJeElKNHd2MFox?=
 =?utf-8?B?czZXdzN4ZHY0dWpHekNyNmF3SnBLM0xIdEo4Sm5ScVI3anp5ZFd1Y0NDM2hN?=
 =?utf-8?B?SWJlY1UyT0tIR3FPTXZYaWpaellIRUdOVFRBaEs3ME9VeXVCd29Ec0tYaVhY?=
 =?utf-8?B?TGlRVVF1cVFnMnU5Zk5LeDNLS2hSSDl2SUY3SWpLbXNJY3NCV1RVQ1hXR1JJ?=
 =?utf-8?B?NFdqVDB6bjcweUZGNUc2R3Zjc1g3KzVIc3JYeWtYRFdCS1h4U05TVlhXbFpD?=
 =?utf-8?B?ZzNSYTV3T0xISlY4allrQWlZOTNiN1NneWJmRm9sUGlrU0NzRG82eDVpdit0?=
 =?utf-8?B?aXpYVENUT1ZobjlmYTJ3S0dlbFpuN05tWXo5SmwwZFF2SWthZThuVVkzUVVS?=
 =?utf-8?B?MWxYZXBUS1UrUG1uWFZKZlpVSUd6L0t3aTlrcnJGWU9waitoRjVpbVdvUTBi?=
 =?utf-8?B?akNqS0liL3B6Smo1KzE3dzVWNGdLQ0JVbWdGY1ZBR2M4cVFCVG5jY3liZUVJ?=
 =?utf-8?B?bUp0R2k4KzZMTjJtTHNUYnd5MmtpQUVhaDduaVExb0I2bkFscWJ2YVZOQlJS?=
 =?utf-8?B?NGIxQkJOYnZpNHk3VUlMUVY3WEk3cmNtVFIva1l3NUVvUXhSeU5LMy94enBy?=
 =?utf-8?B?dHNQVDhRNW9aUTZ1RldYc3l1TGs4S05sZll5VmhSSTZpM1EybVJ4bkhvOEhN?=
 =?utf-8?B?OFBSS3hEbGlHM1dnVlhzelBrVnFvUU0rQ3hIandoZzJxdTMvRWl2SlNzenBJ?=
 =?utf-8?B?cHM3d1RZNmJlQkxCN09ubzROOGZZSDdjODNxTktQUzBmYUovL3puRnIwcE1K?=
 =?utf-8?B?bnh3ZUhMdmN1cW51enhDZHlTcEppOVJpMFZHczBjelhYSkZaTHRhMUt6NDFO?=
 =?utf-8?B?SjdCNDNDVFpZdmE4S2dhT1FHdWNqeUJSTkRlc2laQXBzaUs3YmZ1RnowbERU?=
 =?utf-8?B?NGd0azJYLzlaSElVOVdwelVqMmJLMExnRlZyMjVlajBEUGdIYmI4MnNFMEpm?=
 =?utf-8?B?bmNBamIwVzYzVW9Pbnc0ei82elBoV0F4RmhFYVFQMWpGYURNa3AxNjVQQWFs?=
 =?utf-8?Q?n0diI0vNUhwRHvNgojP2hltAe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e10e1-c2b0-4eaa-0737-08dc76468896
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 07:54:09.4783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/fgsylteoQ+jUzKMndhqr4GxI3k8jv6IGlysjSKPv1VEPtU5634kQ//m5eBe1vjyprM1ddiHsgvjkaFrOtH0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049



On 2024/5/17 3:19 PM, Alexandre Belloni wrote:
> On 16/05/2024 19:28:47-0700, Joseph Jang wrote:
>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>> code. This design may miss detecting real problems when the
>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>
>> In order to make rtctest more explicit and robust, we propose to use
>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>> ioctl interface, we will fallback to check the presence of "alarm" in
>> /proc/driver/rtc.
>>
>> The rtctest requires the read permission on /dev/rtc0. The rtctest will
>> be skipped if the /dev/rtc0 is not readable.
>>
> 
> This change as to be separated. Also, I'm not sure what happened with
> https://lore.kernel.org/all/20230717175251.54390-1-atulpant.linux@gmail.com/
> 

I apply above patch and seems like still cannot detect the read
permission on /dev/rtc0. I guess the 'F_OK' just check the `/dev/rtc0`
was there.

I share the error logs by following for your reference.

TAP version 13
1..1
# timeout set to 210
# selftests: rtc: rtctest
# TAP version 13
# 1..8
# # Starting 8 tests from 1 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:53:date_read:Expected -1 (-1) != self->fd (-1)
# # date_read: Test terminated by assertion
# #          FAIL  rtc.date_read

Not sure if we could skip the testing by following change ?

FIXTURE_SETUP(rtc) {
+     if (access(rtc_file, R_OK) != 0)
+             SKIP(return, "Skipping test since cannot access %s, 
perhaps miss sudo",
+                      rtc_file)
+
       self->fd = open(rtc_file, O_RDONLY);
}

And I make sure we need root permission to access `/dev/rtc0`.



>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>> as optional")
>>
>> Reviewed-by: Jeremy Szu <jszu@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>> ---
>>   tools/testing/selftests/rtc/Makefile  |  2 +-
>>   tools/testing/selftests/rtc/rtctest.c | 72 +++++++++++++++++++--------
>>   2 files changed, 53 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
>> index 55198ecc04db..6e3a98fb24ba 100644
>> --- a/tools/testing/selftests/rtc/Makefile
>> +++ b/tools/testing/selftests/rtc/Makefile
>> @@ -1,5 +1,5 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
>>   LDLIBS += -lrt -lpthread -lm
>>   
>>   TEST_GEN_PROGS = rtctest
>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
>> index 63ce02d1d5cc..aa47b17fbd1a 100644
>> --- a/tools/testing/selftests/rtc/rtctest.c
>> +++ b/tools/testing/selftests/rtc/rtctest.c
>> @@ -8,6 +8,7 @@
>>   #include <errno.h>
>>   #include <fcntl.h>
>>   #include <linux/rtc.h>
>> +#include <stdbool.h>
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <sys/ioctl.h>
>> @@ -24,12 +25,17 @@
>>   #define READ_LOOP_SLEEP_MS 11
>>   
>>   static char *rtc_file = "/dev/rtc0";
>> +static char *rtc_procfs = "/proc/driver/rtc";
>>   
>>   FIXTURE(rtc) {
>>   	int fd;
>>   };
>>   
>>   FIXTURE_SETUP(rtc) {
>> +	if (access(rtc_file, R_OK) != 0)
>> +		SKIP(return, "Skipping test since cannot access %s, perhaps miss sudo",
>> +			 rtc_file);
> 
>> +
>>   	self->fd = open(rtc_file, O_RDONLY);
>>   }
>>   
>> @@ -82,6 +88,36 @@ static void nanosleep_with_retries(long ns)
>>   	}
>>   }
>>   
>> +static bool is_rtc_alarm_supported(int fd)
>> +{
>> +	struct rtc_param param = { 0 };
>> +	int rc;
>> +	char buf[1024] = { 0 };
>> +
>> +	/* Validate kernel reflects unsupported RTC alarm state */
>> +	param.param = RTC_PARAM_FEATURES;
>> +	param.index = 0;
>> +	rc = ioctl(fd, RTC_PARAM_GET, &param);
>> +	if (rc < 0) {
>> +		/* Fallback to read rtc procfs */
>> +		fd = open(rtc_procfs, O_RDONLY);
> 
> I think I was clear on the previous thread, no new users of the procfs
> interface. You can carry this n your own tree but that can't be
> upstream.
> 

Okay ~ If we use RTC_PARAM_GET ioctl to detect rtc feature only, not
sure if that is okay for upstream ?

Thank you,
Joseph.


