Return-Path: <linux-kselftest+bounces-36674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0920AFAD5C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3A116AAD7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F68289824;
	Mon,  7 Jul 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="la0mTpdD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFD279DC0;
	Mon,  7 Jul 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874114; cv=fail; b=DfpXMMDV//zj94DJ9V7DJR+pkeoIZBe47iROklwi3soATKqpim+QV34J36NxbAlmsLtYSml9AFps1G0iNrRgQlB5FnYlhQx8lFLwGNLaC+80JFIPbebajHYEOqCfFnMNSgN0z14f/+7DMzId1xhpMujyPp4wjnWKwR1oJ9R79pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874114; c=relaxed/simple;
	bh=fJXzUCLnidTiUO64R6gVGjWIxXnSWhjoH4tgvxs785o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RpxUpQGZYtQdJFfNzg+Ai19ruWfVWRCWoNmDpi4+WbLF7AsrXxB4pPvawO+9frwruYQ8KKB5MqlvcwyVFxm71gwhYO5UhWE3GL7pL2Jx/1A+4wZezbWoGqk/7vskhzwAOKfLLk3dIQk8mGBHbZnJKAX88xvcJzjCRVaUbTluFh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=la0mTpdD; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8JHWjTbpxcY8BbMwmKkHZ5Ry25FVB3dLd5MBHh4o2uhyI1qxV/mbHhUftfBmrUr3ZI0eJW29urvSlv9PIhudauJHcrnzz4o7KOILwkYjsgXS3wLwd4sXYAOfSzIUjoJHFO3PYYzJKm7s6FXmE2zhSs0kK7y6m1JOc62HJS/nrFkDysCaKvMj457BOQVN2vcfxPzyVimCwPS3ViXCttXIgmnPGUmmHthrwdGqYZmmZVtXQRdOvCDyGh/1OAD/fN6dDQzC9fBDsMqf8OqjD57u+MYd/13nA2G49fLbyT/ap6hvUEASvVxLtoDdRdGU37fiTkfu3XYYje/Ml8CsXyxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkT0OowraBkO1wmq1sbXMDsRXG2ErhIPD65aQzAOLUk=;
 b=sHJCLAMBza4RyVxOsUV/3dYwxK9Zolpatgld7+1/Y7gGwu7DRb8xifbSuHRnMuLZTq8kq2gFanelHyM7bZ9HZo53oA4GkWb7efMgY+dFwAahwAqfqtx7PyZkkXRn+zIf9nXB/dbqf4DAnopaxCAgYIR6x564wMROGu48iAdfLm8gel+0heS7A+61o7c9pVVeTHCjGtsE+k6noL4rEmv7ksB09nyb8dv0KoFIKnd26apz3QIiLBpzalQgrk7UyTaxrOgNauc4UXf0jRSPmdzTq3DQ19QxdHwQe//zOFjpwmdvRsft8dSM+JhPsuzl3b8pRZJXVkNptO3kTXmgyx0V+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkT0OowraBkO1wmq1sbXMDsRXG2ErhIPD65aQzAOLUk=;
 b=la0mTpdDRM86YDG0ThtIkZv99EJxGVcpMWAPQPVS1Hi20sNl3LlapXPaigdlRObzvcPoBpXvPXyObxghqz4ccMprmi+XJDk/n1FOeTbEPiuKrSI3j7axo08HeIzCoWaxWIJegmpnK2KqeCrFmaCRjyFNUTHCFhMHjLlOA83bdUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.24; Mon, 7 Jul 2025 07:41:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8901.018; Mon, 7 Jul 2025
 07:41:50 +0000
Message-ID: <d35a1546-e175-4894-94c1-970b5d82487b@amd.com>
Date: Mon, 7 Jul 2025 13:11:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/29] iommufd/viommu: Add driver-defined vDEVICE
 support
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
References: <cover.1751677708.git.nicolinc@nvidia.com>
 <d6fa98ad18a44d3df2ad9c9320f364affa9c03f5.1751677708.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <d6fa98ad18a44d3df2ad9c9320f364affa9c03f5.1751677708.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2d7b07-be52-4d44-bf42-08ddbd29bc36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FadHgzeWliK0orR3FLWEo1RXNGR0NyaG0xQlkyVTg2VVRZVUdITW5wcWRh?=
 =?utf-8?B?K2FobUxmOGFXMERYdWg3KzV1MnIrY0NMbGlFeG16OWRJbXhqa1RjUTNoUGhy?=
 =?utf-8?B?WkpxVkk2ekJPRWk3blZQV3g3V1Q4UFNydnVpL1FWM2xwUnV0aXZtYlhlTSti?=
 =?utf-8?B?UkZUb09SY0J3VkFwQU1LRmQ4aldNek9MM0t6aDJCRkcvRFNwdXJRemt3Y3lo?=
 =?utf-8?B?RWk1SG5ZS2lmVjczcUxQMThJUzRzeTRyRFJkUUpqQVd4SVc1TFpiNmtOc1F1?=
 =?utf-8?B?RkcwTWhTci9ZaTJxcktCbGxMUTE5UnhwOFJ2M3h2UEV5NGxzdWRUOFMzc2hH?=
 =?utf-8?B?WDVQYmRVTzd0Wmp6c0VOZHhJR2NFUEt4S2NzNnpjZVNLMWFJdnRTeW04RG0w?=
 =?utf-8?B?djdFMVh3Rk5yL0szVHBUcXFSYVA2elFxalhTTmk5SVlmbEh2c1VETUtjWDc1?=
 =?utf-8?B?cWhiM0Fqem9BeW5QZHg0Q3lpVFRMd1NOKzdTS2FhYkxkWSttbi9sbmJWblUy?=
 =?utf-8?B?OHJGTGhCK2dhc1F6VFpkZGh4aUZKSmliTEJ4VEEvNG41TXEwRSt1djQvb2VB?=
 =?utf-8?B?UWtPMnYvTVkraUpSZTdGdytqbnhQc0RZZC9QYVBtOUh1KzUvZ0plUHB1enJK?=
 =?utf-8?B?RENyL0Z0S1k2NktiS3BvdG9YNVltR2JqOUxwWnNYbC82d2J4UVFzdWJDdFlN?=
 =?utf-8?B?cnNNbWp0SzhlbXdYc3FkZzNEaWpqRHpwY2RMU0xQNGRTcS9ERjh3SGtML0Zj?=
 =?utf-8?B?aEdaZmdaUCtkbXgyTzYxYVBMZ0tXdDJGMU8rYzRDd3Npc0VqUEhLVHBhS2NZ?=
 =?utf-8?B?akR1bHRTbldpWHNKSmRIUnN5RGxZWmZlbGVwekd4QVFKRnBpejNGamd5U2ph?=
 =?utf-8?B?L0F4aEl5eEI5ZHVZZ3dHY0w4NFRRQjZ6YnU3OHcwdENOUGtyQjZMRUxCUURv?=
 =?utf-8?B?YmRneXZpUXhBdzlEdHAxaExsS05jRlFwZUgzNWczNmlETWFYTTIyRlB6TExU?=
 =?utf-8?B?YWI4OWN4TEtaV1BvTlNTd1lIT3pHL0gwaEpPQzNlWFltSkk0OVJvQUdjUzlQ?=
 =?utf-8?B?QUpZbjVwRHlKRXJZdzdZY0g5MHNtdGQvSEFMdlNwdi9LL09uRUpGWGRMYXNw?=
 =?utf-8?B?Qm9sQjNicVhsL2hUS1FHR0NFczVvcllHVFhIekxNY2JGcEVHVFdMYWcyQTAy?=
 =?utf-8?B?MEs5aVNVbjRzSndGdHpSYmptZExmcW9TTG94djhwYkg0a09aZWtKcTg1WC9D?=
 =?utf-8?B?R3RPRzlxcStOMkxGQkNTdWV6aGhkNTcyMlFsM010OHBiaVdKVmgzRERBUGFp?=
 =?utf-8?B?NUZRdndGTEZ2Z3ZQUG5vcXJsVmw1K1pPSlBIOTBuWDhReDlWQXZrTVEwSkth?=
 =?utf-8?B?UWREVlR2akVvaVF1NHY1MDJiaW1seE04OGt6ZG5wb2pVZnlENzhtMnVNUXV3?=
 =?utf-8?B?MmNSZXQvSEtueGlJaEl3bmpYSmFIWWtDaW1KdHM0SlE0TnVxZFgrN2N3dWdh?=
 =?utf-8?B?aGZCSWRhSkpPZ2N3dmF2dVRKUGtvcEpBSjFHTWxaSzZGNW96UTQxRzZQNVVI?=
 =?utf-8?B?bVZFOUVqY24zcjd1ZEVlYkdyT0FqZWJGbUw1dnAyUVg3L2Q0OVpZU3lENGs0?=
 =?utf-8?B?SkRjQlIrbkVidW1mb2NFSnJvNnVBT1FneVJwUDl1VC9SRXdidXJiWUk5VFRN?=
 =?utf-8?B?NG0wSG9mMGZpVm9Qam9sY2NnMlBCU1BqZ3hwaGlQTlptM2RxL09PN3R5VnJl?=
 =?utf-8?B?ZTA5d3hyZC9PL1cvaWRDeVBueGlDSXNUbWVxOWw3Q29vUEFjVUxYaER0aEJG?=
 =?utf-8?B?ZEpWTXdMbTRTQ0NMamZJOEpHOWVSMnJtQzQzdU5QY0t3cXNDOUEyYWtiZTM5?=
 =?utf-8?B?eFN6RWVyTU9JamhmdFFZUktHTTB5cHliSmlva3JoVjkybWszQXpqU3VEMS9X?=
 =?utf-8?Q?WCi/CQ7UF28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWVzeWg1bDVFdndiSGl5WUVadTliVURndFBTeGJWYVB2UG1MK3M3ZUgvcG9D?=
 =?utf-8?B?VEJOQXpWTWVad3kvci8rZU5mVTNIR1ZEaTFIbzErOGVDNUo4d29qY1dLaFFv?=
 =?utf-8?B?ZmNubE14ZHJkcUUvamU1NzBXaytLNmNMWEw3bjY1djlVamRNTjBwWkVkcDZO?=
 =?utf-8?B?aDlnNnIxY3g3QWpOZHVRUjNvUGRjeTFQNjE4czhELzgraFBGa1NuQjJNeGVI?=
 =?utf-8?B?SjJicEUzd0swR0FlZFlGSnJaTzJYYS9IaERweUp1QS9mcDF1eDVqckFBaGRy?=
 =?utf-8?B?ZmFlT0NucEZtZUhnYUx0MEY5WFN6OEl1eDRORDNXbjQrL1JsMnMvOGlUeHJT?=
 =?utf-8?B?ZE9wcUIyYjdwV3NUNFViSmwrVTg4bHdnREdWUDZpL2JiWmZwK1pSanIzUXQx?=
 =?utf-8?B?YkR5SkU1R0k0L2FTeS9CTmNIenIvczErRE5ObVVxb2IvSkE5WXJaN3JCbHdr?=
 =?utf-8?B?L0MxTDhLUU5JV1ArUW54amVjSXg1NDdkVWF6SDU3OStRZ3RaRXUwNkJjdmFz?=
 =?utf-8?B?VDNzR1FwSkxXcWZCaURRTWI4YU54VGFFeXBRdWJrZ2R4aEh6WXNWS0ZJeWRz?=
 =?utf-8?B?VkVBbG8xd0t2Qkt3ODM3UzlVWmZjd1RXaDRRK2VRL2k3bnlTZkU0RTdRMUNn?=
 =?utf-8?B?Nlg2aDcySFg0RU1RdjM3L1hodEpnc3Zva0FLSldodThvT0FnLzgzZG1pZE5O?=
 =?utf-8?B?STcwcmplMDJoL1A1TFVQdlF6ZWc5MHRtV0M4TUVqWmN0M1VYS0NpM01oczBB?=
 =?utf-8?B?MGV6eW05MW1POVlZcS9uT2lVVXdtYlhDZG9ZdnAzTVV1KzBLTkp4V3FEUmJV?=
 =?utf-8?B?ZmVFb3h2a01QRlNTd3YrZzRoZXJFdVpOVVQ1SXMvMVlheXhrcGhjYVBscW1S?=
 =?utf-8?B?SFRrZG9XN2RadUZicXlDcUpGR2tja3JoYzZhVXpxK2pWWW9tTUYzWnl3Rkcr?=
 =?utf-8?B?NjR4NXlOVHZMTCtHcm5iMGhMeU9xc0V6RFpGSzRMcnR3eDZQckVVMHJudVVi?=
 =?utf-8?B?QWs2VS8vY3pZZUx1bWVwd2szODRodGZPQjlxM2Z3VjM0anV5OHpJaHppRzlN?=
 =?utf-8?B?bjl3U3UwcUhPQjVMYmZsMlNCZVpwbG5hMGVXVWtuSEcyUVZHdkh6WU5OQjdJ?=
 =?utf-8?B?eGxTclo1Rng2Y0xndEd1WHorT1o3NjNRRWxyZGNKdzg1ZGE2c2E0RDZvNDNr?=
 =?utf-8?B?bkZBVkc5VUhYaEw4bHN5d1o1U0pJTDFIYlBSMEVSYnRPTFZEVmNiWW0vRlNi?=
 =?utf-8?B?c3BFTlp3K3pucFVmbWZNdU85YzZCQ01GZCtxSVhjUW5Vak9vL2dpeTNjcjhx?=
 =?utf-8?B?dHlDdXhmQUdIR0ZVbGI4SVRKVzFlQ2RiQldGWFpJQW4zcFo3MmM5UktmQWpn?=
 =?utf-8?B?UDdIN1Ezditmd0NzMU5KRThlNEdYN3graWFERnRaSkRmMnA2a1NqbDdRcFJ3?=
 =?utf-8?B?c2o4QkpHamxja0pNV2hUREpPejRxd0FQUDQzWlRtb0g0dSs5VDlOSmFmWkxw?=
 =?utf-8?B?b0dDTDRJaVd1ajAzSVFSS0FpTE52TmtCb3pmUkRMdG1tMHRWdEQxOVRWeEw1?=
 =?utf-8?B?OFNVMVVBMWZxNUNHeXVKd0xrM3h4ckNUb2FiNERsbXp2M1RsQTFKMStMbSs1?=
 =?utf-8?B?a0NaeXFvYkdRWlNFd29xQlJQYkNjNVpuaG83S3l0Nk1rUzVNcVkvdzhsTEdH?=
 =?utf-8?B?a1NvWjFFLzl0S2lqY1B0VGZQR0JNM2xaUS9kUm5TM3FxR2prZWx5bG5HVXhv?=
 =?utf-8?B?OEhPTXVLSS9CVmdlREcydnhqME9CT1RsRnA5SEsxdEMwY1VFTXc0TUc3K1k5?=
 =?utf-8?B?Y0tjeVIyeXJoUzc4TzZ1SmtwOTNOdE5UQ0JxSTlCQjd5SDRibHpZNzJDNDI4?=
 =?utf-8?B?RXljcWhYQVFFZXVobWVnbXAzYWhva3dnY2pKN3pQNEl1NTM2NE1qRzVoRnNw?=
 =?utf-8?B?Ujc0TUF3VlNUNXc0NzFMUFV5enAyT0xWckMzQWtuOTVicU9oSG9DWEtvR1VL?=
 =?utf-8?B?ejdlRWtGSUVnZEcweXgySldrb2JJeHN4eDJPbU00NHNMZkVEeEc4M2ZkRmIy?=
 =?utf-8?B?Q3VPWkk5dmRvMFBsWm9mem9Na2ZlcDNaSU1nemdFc2JaczR5SUxSZ0FocVVz?=
 =?utf-8?Q?ek5xsA2ejzAPEjb6vEsMKo0at?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2d7b07-be52-4d44-bf42-08ddbd29bc36
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:41:50.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXrYbCc6b0hTZekp1sTU5VewIV2T+YnDkWNEHABXTSggabWxjuLJsPXcO8VOuj9xTJiiPrWdFtRC5iHRg02rZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337



On 7/5/2025 6:43 AM, Nicolin Chen wrote:
> NVIDIA VCMDQ driver will have a driver-defined vDEVICE structure and do
> some HW configurations with that.
> 
> To allow IOMMU drivers to define their own vDEVICE structures, move the
> struct iommufd_vdevice to the public header and provide a pair of viommu
> ops, similar to get_viommu_size and viommu_init.
> 
> Doing this, however, creates a new window between the vDEVICE allocation
> and its driver-level initialization, during which an abort could happen
> but it can't invoke a driver destroy function from the struct viommu_ops
> since the driver structure isn't initialized yet. vIOMMU object doesn't
> have this problem, since its destroy op is set via the viommu_ops by the
> driver viommu_init function. Thus, vDEVICE should do something similar:
> add a destroy function pointer inside the struct iommufd_vdevice instead
> of the struct iommufd_viommu_ops.
> 
> Note that there is unlikely a use case for a type dependent vDEVICE, so
> a static vdevice_size is probably enough for the near term instead of a
> get_vdevice_size function op.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


