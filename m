Return-Path: <linux-kselftest+bounces-42865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82326BC42FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4459C400D66
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D460244691;
	Wed,  8 Oct 2025 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j3zmxoBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012030.outbound.protection.outlook.com [40.107.200.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB156233136;
	Wed,  8 Oct 2025 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916886; cv=fail; b=f0+acXxr5nqhmhE6da7deF4bQckg3hZIvwLZZeyB1hi+eLOTVK5BtUyosDtLOglMevXFENEh51vJ+rW1Pup6AH0cC4Nur8wjPxYPfEiVJ3uvs/Bh823OlU4GIW0wICR+Pm1ULcpZ3RW+Oupf/vbtsxHAE3Qgck6YUcR/4S1eqoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916886; c=relaxed/simple;
	bh=TXhOS2adtiGqIOB5OnlVtBp1G4m4lUQYhqgw9O7FUQ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m98dYcvVlfcq1uzV19X5JoTjKJPJzgrMI+64vuzVz/4jxhWmR25j2OFkXiIYp8UPfhReN6H4toV2BkpNoiUANaDC8dAsD8aK+Ieu32rmU7GH9tdFDYiHBcgI4fqmkd3VQ3k2Ok7BU46Lev/muRHq6jn1nU9nRePjEksp0cp+r4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j3zmxoBC; arc=fail smtp.client-ip=40.107.200.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpzvdP471XBU4aDnRwx3vf84ryGTeSZwt0vnUdw5VAsjkhU+RYfbImcJDwEltRkU0376Iq7K4Yg1o1kISK3sHuFlY2PF6p1lrOMxlhMsQGrYGbe/5lxMvEMMfmY6igXPaLCcJqcM5U4kifi4qgqJ4VtcTvh0I4jfNeOni/vHQx/+OXRaxbpssR4PPd2zWTU5d52G8EHt6Qr62a+ODTcwlma948arRdo0lky0Pxzj7E/s2hy33LXh/4F6sjIvst5KeloSqesRmaju5C8pwjbFRxnFZGEGaN6gmDbXmu78EjO0k6PF2lOBDQIe/APm9zOpFbnoBJ6EyAHZ4fhoCkHvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eHjp1JIsRNbAB3eu/2TSEjaVles7PhvDULmAQMhCvI=;
 b=si73IbUr9D9T511vctmQKAS/uxUUEkn5DGG0pVpEE2KFHuJXanYkN6KlG49F5DXCj8CBVdTkEzyvOyj6m8QyERC1JumvF9N5VDhtfMNWMoxQbH8CNyDh/tRuiEiIWJrHLm01FAZxcyZNZdIZzV/vP+lbrvj3UXouOU8NkNovmdhO0+0v6kbqezl3q6p9060KZ4PUgeEO62lEsGsDyNw6gNoPalpM/yZBxSiT1gZTxjf9aaN3CbyVgZXiRlUeBubqZA5ZDZXrel4xKUNQg0P9I2+Jk7nqOXsH6q8Qb5SOUKrQKeXvHhJx4eM0qCBZGgPysJOtcsUQFrRSnIOLbzaWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eHjp1JIsRNbAB3eu/2TSEjaVles7PhvDULmAQMhCvI=;
 b=j3zmxoBCyI+ml31hKj1od6eU6LbG4425uE5YbCWVw3Ljpeb6jr7gMjgxC7LyxJT3BdI45IaIwYYTzVBNpyHuVb/1DJ7g2auWwdnRJPSq1xt2i1PqKUa3rN1crsGC2hthTZFzfilOKocgpNdJQ9SeZbDoZl96c1oEWLnPtHvcX3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 09:48:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 09:48:00 +0000
Message-ID: <329c0775-42a2-44c0-905b-7ad6910cc834@amd.com>
Date: Wed, 8 Oct 2025 15:17:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/15] iommu/amd: Use the generic iommu page table
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <13-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 16879d1d-5230-4b1e-05ed-08de064fc437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnhZZEdBOEZadTlTUWV6VFhrN0NxRUlyR2l5Nk5lRVdSU2VDUk5BQlZYajNr?=
 =?utf-8?B?MTdEeVRqelEvSzRabzBRMUt0U2dyaVRWZEcyQjlSQXBsdjhxbCt2OTZjYWlr?=
 =?utf-8?B?STF2ZVg2VEZjWXJoUEFNVyt1STBRWDBSU3E0WEZqdU9rd1krWjRaRk8zNlZi?=
 =?utf-8?B?aWhLZVpvZ05SeGVqbC80WkhyVGYrNEIxRXVIN0oyVGN5RDV6VkpSc0ovRkh1?=
 =?utf-8?B?NFJPRVRKYzZXK0VuamhsOHA2UkRRcW1UNE5RcnJqSWErZnVIOGVqM1FmNllJ?=
 =?utf-8?B?Zk1lR083c2ZkSHBTazc1NHNseitpYWh4TEdqMldjclpWYytMOHVqOGR4dkpl?=
 =?utf-8?B?VDdhYkFGeUFNRjFnU3NPQjM4N2NYKzNWc04rL0JicUFYRUVkQy9IdWQvbkJF?=
 =?utf-8?B?aU9SN2oyb3NSMzRKcjlaSmx3MUNac1E1eVdYRHZ6bW1XSVBxZzdidTk5dmYx?=
 =?utf-8?B?Tnl0VVpta3NQTEE2QVY1VEt4U0pNbEpaT05KclBnTUNEclMyUHNDNndBM04x?=
 =?utf-8?B?bmE0bkczUTZnN2pHQW1tREhrUDlhZWYycTNRZFFyNlkyS3FyZlpQdVdMNjZT?=
 =?utf-8?B?U2tibjA0R0thb2xnNGp3eWczVmFJeWVDVmlKbXlwNjQxczRZeVJ4R3ZnTmxu?=
 =?utf-8?B?OUFaUXRqYUhZS05WU0FRWlpjNkkvVSs0RUpBWjloMVNYeTdETldNanFkckQ5?=
 =?utf-8?B?N3Q4aWhPa0wrMXR4WkE1WlB6a1JjYVlzdFNrR1VIZEdJeFoxd0h0Z3M5VFJD?=
 =?utf-8?B?YU52R1g2eDBiVXpEK0tyMEZFeWxiR2xlYkt0V0h3WlJNVkxtVi9BL3NDNWc5?=
 =?utf-8?B?L2cvcWFPdW8yTGwweVgyQlh4SUViUFcyQXdzZ2xJWHR5a2RIK1lXMWxwNlRz?=
 =?utf-8?B?eVBLZ2VjNmdSTFVzdjJhK1Bud2FkbXUzaXRoenNaM0tWbU1PMVVTWUpENnFN?=
 =?utf-8?B?bktReSsvZ2pwZ0o3RUh5OFhneVZsM252WlVpbmkwVnFzczNDSFV4Q002VWJ3?=
 =?utf-8?B?ejdMa3pVS2Z1TnVMa0NFQmNOa2w3TjVjTTY5QnlGdGxYNWpoK1hBNGdEQUVQ?=
 =?utf-8?B?V1loMy9WMmthTzRJdDl2aktXRnc4MUtNV0x3VjdYMXlqVER2UjV5dTRrekU5?=
 =?utf-8?B?SDlmZkJ5Szl3MVZrM1NZeitrYkhCZlRickhFL1JibUhOdklzTWxYbDZPL1lF?=
 =?utf-8?B?Zi9iV2duTkY1cDU3MUpqdjJIMkZ2UnF0VEcwNUdBb0tFWlQ4VXhRS3VtMlR2?=
 =?utf-8?B?K0RsTGpyMEtPZ2FXdC8ydzdlTG01bDVkNS9LUENVZkNnQi8yZ3VoVG9pbXNs?=
 =?utf-8?B?eVRYSm1nZVQyMXFsb1pPLzQwYVF3U1pRcDlnLzcvMmpFRXpFTmlGUUtNUnNq?=
 =?utf-8?B?cTlvbGJSMnpBVHc0NWNCdEI0dlZDMEFRd2ZDaFBRRzNWRzdFU09pVDdiMkp2?=
 =?utf-8?B?b3RCOW1jRmRXS29vMzZmK0JJY1JMcHBCSjB2QWIwdkk4MmVmZWV6SGcrQUNR?=
 =?utf-8?B?MDBhNEFnM3ZldGRGMzl3MkxqdURoOEVYQkdRTDd3YnA5b29FcmoxZjJ0NE1p?=
 =?utf-8?B?V0d3Vi92Nmd4Q2V1aFNTZWFpNHZ6cHFGZjdDZ0FFaFlGS0VZMWsxUUJkNHlP?=
 =?utf-8?B?cDNYZ1YrZ2I4VE5IRHgyb0h2QTdYTFgrbUtkRzc4U1lGaVIyMTl0U0xsY3pF?=
 =?utf-8?B?VEVEZStYaExaUVBlYjBtekFqQkpsYXBlWEVXbnVJeWVLaElGUkRJS1c0Wlh4?=
 =?utf-8?B?UWY0RDI5QUNkN2lJV1BPeHp3ZlpkeE1TT3JNMXVqR3VDL2Juc1lZZDd1KzJz?=
 =?utf-8?B?WCt4UTdNMU5SSDdiQmN3WXVKL3o2TmNndk9HdWdacGpGMzhsNVE2cFFpZkVK?=
 =?utf-8?B?cGx3T09CQlMvVm5EZldPTVFhMlY3eUhFOWdJZHVBeVZBK0FYekJnTEs4Tnhm?=
 =?utf-8?B?aWlCUnJsUnEvbDNweTBueVRFSGNQdWxncjhQV3JtVnE5TTM1OGRDUTNoTzlr?=
 =?utf-8?Q?Zha7WO/UQqiRuOu9es0IjNU41lcgis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmdqbjZuRXIxRjdxUUVWVC9zU2NiWC9NRFhyenc0ZnNlTUlvM1JNa291WlQr?=
 =?utf-8?B?ZVUyblduc3kxSTFsZnRjbkJSVjZzcW5ac2tWTk0zME05U0JQblNWaEhYby82?=
 =?utf-8?B?ZUp6K2MxcDduR0JIZm1rUklpOHM5YWFWbkhXVzZoR29NSkF1YkhHcFgrODF6?=
 =?utf-8?B?RDk0YTdaNFlIM2FydGM5L1FUUDVoRllYQlB3dENnTjhzNFFZWHlQeEJ1UTRO?=
 =?utf-8?B?VzVab3V6ZEdHYXEzVHlhNW95ZEk4c0l0NVhSSUVXSjJtQ1RMcmhkYmJOSGlq?=
 =?utf-8?B?eXFBTmkyOGdtZk14aFZNOSs5bjFIZ3lVRnpMUVFXbU1pRVFYOE9CNkY2S3Ux?=
 =?utf-8?B?a09kQ2U2dmREbmxPWHFucGZnZU90QSs3YWY2QnBVNnM1RHJaTU5uV243T1JS?=
 =?utf-8?B?Z3d1VzNzRWJiVEdUOGNPN2lGRmROdXlZdUJGZWUzRGswOEFmb3VPT3lqTDF1?=
 =?utf-8?B?R0U4MkhKUkYweHVrajNXOURrVU9HSkcrZjFaaituSDBBL21VdWZUYUZHa3Na?=
 =?utf-8?B?R3NHWnBFSkFScmUwRnVjWHBEN1VTaUh6azQxNDQ5SmRYSkVFTjNFN2Jkb2VH?=
 =?utf-8?B?Z2dFUFh5ZzhpSmNGQzZhWFZxOGh1SFVkVHFjWEwvYlVGbVlZM0ZSR09mODQz?=
 =?utf-8?B?Ynp0dkRibVRBZC9xa1huNk9hMzE1S3ZydFdkOU05Y2RxSjJ0akVQa0pWbFJD?=
 =?utf-8?B?WGVQVkZTWmlVQUZ6TmRBRlo3WXlRd2x6NXpPSXRRTUxDZStaamZ6Yno1dEU1?=
 =?utf-8?B?RFFJRnVOWkxLeXFWZjNSdGtmdVd3cEZVSnMzeU9QaFJSdXJxY2VqVVFjQ04w?=
 =?utf-8?B?OERuQlZ3dlRsQWxGOGNKNlg5Z2ltVXFYTkpKbWtFRDdWZm5NVUphekc4MEl5?=
 =?utf-8?B?a05lalI5eFRCNzBzK2ZSRzROU2J4cmUrcGhQTlZMOGJrWndGK2pldkFDeUdJ?=
 =?utf-8?B?bFBxbUx3OTM0enRUcW1nSlFVRjRqMEJlVGRCU3pJWU15dGQyNUJLRlpXNnFa?=
 =?utf-8?B?ZXp4bWt1UFVyN1Jjby9rRGpqTkorQ1pKRFBzRHg2V3pKQ0hsN2JlUTR6My94?=
 =?utf-8?B?RUR4MkVhYmVMam9iajBmMDFVdjV6dElYTHU4aWM5MHc5SzhLMkVMZGhZM0ov?=
 =?utf-8?B?bGZYYi81WVBKeEx1aGU1Q2NxMUxOU3ArNENFQjZ0NVFQMmpFMFBGV1VTdkNz?=
 =?utf-8?B?MjRTQ2h3aFYzcVZuNTNBaENkU2QzZk5MS29BbjhsMHdwQ2xxbzltVWZwRVU2?=
 =?utf-8?B?dHVoM1BBWFZtOXJWRldiTjFnNnVBam1NeHhEY2U0NisyRm5hMldYQ2hVcDRl?=
 =?utf-8?B?K2h2MnlXZ3ErSmthc1JNYStDRzZRU2hGQVRGZFZPS0ptU3RDVUFxTStSd3Zv?=
 =?utf-8?B?MFJ3MXFVU3lLb09BSzI5VUpOUTJTZXpuQTk3SmpMTTdQK1NTdXhiU2VvU0ky?=
 =?utf-8?B?MWlsV3RpRXduZEVQWUgwNms4T3ZSdzhSR2FGVHJWN2JVZ1VkM2xSYlAxQzRo?=
 =?utf-8?B?dDI2RzBvalNrdWY5b1haRzVPMGV5SDV3YUZFUlJPOHpma3JsYm5mYnJjNk5X?=
 =?utf-8?B?c3JlejhpcTNkdTdLZVkzSWZzbDhDeTFuK2J2azJ5NlJBRkZtTGZOdkZCem8r?=
 =?utf-8?B?dGFVR2RuZDUxVHVZNkFSc3BUQ3NNd1NVdjJRN1F3ZG1PUUkxWXNYWngyT0Qz?=
 =?utf-8?B?VlNoSlRZUGN5cmdyazlLTE9kN0tNaGxHdkdWMTJPSnVCbWMwK0svaDdjY0dG?=
 =?utf-8?B?eVRKV0FMR2lGWENXcUUyWHlaUjh5VlJlZk4vSUdCQU43YzVhZnAzOXNkcnpo?=
 =?utf-8?B?byswcXdrVEtUREMrSzZlWDdsT3RJd2NSM242UzZCcU8vUWlkZ21zUjAxOHAv?=
 =?utf-8?B?bFh1QzVmMCsvd1FEZjZTQ1Z2aENjZlFkTEYxYkRRUktNWC91VUUwZHdjOHZZ?=
 =?utf-8?B?SGJIWjZ6KysrRmhFb3h0d0ZJTkdnRWVVSnVaaEMyN0Q1N1JTcDIvQjBQNmhB?=
 =?utf-8?B?Zk1COEhKTC9Ha2MyaW10elBUZXBqVmFjdDdtbUhBWWZFZkhMSEs0NEJST0dX?=
 =?utf-8?B?VWh0UjkwaEU1MEhzWUplc1o3clhHMUk5Z2RMS3BVd1lqNHQvQjNwMStUNzR5?=
 =?utf-8?Q?qTZIxMniF2mJjbUNg++wUnN8d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16879d1d-5230-4b1e-05ed-08de064fc437
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 09:47:59.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mywNaP+h6j05WpgzVB99vQxU9SspaQm7mA7MaP1zsGQM9nRj2CS2+vg6qgYPnftEnba4KEHzemA3fFEUP7NKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

Jason,

On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
> From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> 
> Replace the io_pgtable versions with pt_iommu versions. The v2 page table
> uses the x86 implementation that will be eventually shared with VT-D.
> 
> This supports the same special features as the original code:
>  - increase_top for the v1 format to allow scaling from 3 to 6 levels
>  - non-present flushing
>  - Dirty tracking for v1 only
>  - __sme_set() to adjust the PTEs for CC
>  - Optimization for flushing with virtualization to minimize the range
>  - amd_iommu_pgsize_bitmap override of the native page sizes
>  - page tables allocate from the device's NUMA node
> 
> Rework the domain ops so that v1/v2 get their own ops. Make dedicated
> allocation functions for v1 and v2. Hook up invalidation for a top change
> to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
> that becomes unused in this patch. The next patch will delete the rest of
> it.
> 
> This fixes a race bug in AMD's increase_address_space() implementation. It
> stores the top level and top pointer in different memory, which prevents
> other threads from reading a coherent version:
> 
>    increase_address_space()   alloc_pte()
>                                 level = pgtable->mode - 1;
> 	pgtable->root  = pte;
> 	pgtable->mode += 1;
>                                 pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];
> 
> The iommupt version is careful to put mode and root under a single
> READ_ONCE and then is careful to only READ_ONCE a single time per
> walk.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/amd/Kconfig           |   5 +-
>  drivers/iommu/amd/amd_iommu.h       |   1 -
>  drivers/iommu/amd/amd_iommu_types.h |  12 +-
>  drivers/iommu/amd/io_pgtable.c      |   1 -
>  drivers/iommu/amd/iommu.c           | 538 ++++++++++++++--------------
>  5 files changed, 282 insertions(+), 275 deletions(-)
> 
> diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
> index ecef69c11144db..f2acf471cb5d9f 100644
> --- a/drivers/iommu/amd/Kconfig
> +++ b/drivers/iommu/amd/Kconfig
> @@ -11,10 +11,13 @@ config AMD_IOMMU
>  	select MMU_NOTIFIER
>  	select IOMMU_API
>  	select IOMMU_IOVA
> -	select IOMMU_IO_PGTABLE
>  	select IOMMU_SVA
>  	select IOMMU_IOPF
>  	select IOMMUFD_DRIVER if IOMMUFD
> +	select GENERIC_PT
> +	select IOMMU_PT
> +	select IOMMU_PT_AMDV1
> +	select IOMMU_PT_X86_64
>  	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
>  	help
>  	  With this option you can enable support for AMD IOMMU hardware in
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9b4b589a54b57e..25044d28f28a8d 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -88,7 +88,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
>   * the IOMMU used by this driver.
>   */
>  void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
> -void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
>  void amd_iommu_domain_flush_pages(struct protection_domain *domain,
>  				  u64 address, size_t size);
>  void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5219d7ddfdaa8b..90cf2bc4e14528 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -19,6 +19,7 @@
>  #include <linux/pci.h>
>  #include <linux/irqreturn.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/generic_pt/iommu.h>
>  

.../...

>  }
>  
>  static void set_dte_entry(struct amd_iommu *iommu,
> -			  struct iommu_dev_data *dev_data)
> +			  struct iommu_dev_data *dev_data,
> +			  phys_addr_t top_paddr, unsigned int top_level)
>  {
>  	u16 domid;
>  	u32 old_domid;
> @@ -2059,19 +2029,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	struct protection_domain *domain = dev_data->domain;
>  	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>  	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
> -
> -	if (gcr3_info && gcr3_info->gcr3_tbl)
> -		domid = dev_data->gcr3_info.domid;
> -	else
> -		domid = domain->id;
> +	struct pt_iommu_amdv1_hw_info pt_info;
>  
>  	make_clear_dte(dev_data, dte, &new);
>  
> -	if (domain->iop.mode != PAGE_MODE_NONE)
> -		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
> +	if (gcr3_info && gcr3_info->gcr3_tbl)
> +		domid = dev_data->gcr3_info.domid;
> +	else {
> +		domid = domain->id;
>  
> -	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
> -		    << DEV_ENTRY_MODE_SHIFT;
> +		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
> +			/*
> +			 * When updating the IO pagetable, the new top and level
> +			 * are provided as parameters. For other operations i.e.
> +			 * device attach, retrieve the current pagetable info
> +			 * via the IOMMU PT API.
> +			 */
> +			if (top_paddr) {
> +				pt_info.host_pt_root = top_paddr;
> +				pt_info.mode = top_level + 1;
> +			} else {
> +				WARN_ON(top_paddr || top_level);
> +				pt_iommu_amdv1_hw_info(&domain->amdv1,
> +						       &pt_info);
> +			}
> +
> +			new.data[0] |= pt_info.host_pt_root |

When SME is ON, we need to set the C bit for root pointer.
(__sme_set(pt_info.host_pt_root)).

-Vasant


