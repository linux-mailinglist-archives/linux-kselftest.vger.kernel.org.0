Return-Path: <linux-kselftest+bounces-24180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1E2A0870A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C938188BBA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 05:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A12066CB;
	Fri, 10 Jan 2025 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GJSCRSIq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD5347C7;
	Fri, 10 Jan 2025 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488344; cv=fail; b=jHyAJVpoKfPEvaJAOdrWNmf/UDUgNp7Hp9qH3pSjzbYTpwH2eM3TOVngXQsXPLoXtv+MyNmCxq6gyySRZx/khiqFs9+MzTMX2Nht+DnnkXv2XC3rZIPF5Etu43KJAnIFAHE4yaae07fMMpoNQF7KFe/3dak+usF5OEQ/BgsG0m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488344; c=relaxed/simple;
	bh=OmMW09ueGXnmln5Nc4G7xDWEQ6NdZ2MNSGAMwLMHvKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gz78kieEQHKkQc2Ds/eE2i5QB5R1XJDgmdZVQKagUPG6eoFBIxn/UsnUVPgjBT7i2kWP0mhU/mLgF+4GYGnFxXPEfRs2rxAMcfrkRncYFLLlBiZftd9Ui0ddtItveAafbooxqXZoDxkNrqP06SWWvoLhAW8RJEdzNM7560S/dHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GJSCRSIq; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ero4B4bkYt1hGnglfDIryh1HtSwWp7wpz6zpkEJuspprnkmNRBNYvsDqN/oiVHdveG5ElfjVIJDvrkuYVzPFSQIpl85n50ecdm7Z49vCYWg6riK32J4gSeHJoixE68+m0zfxsQOx6DCBlqcu2WcsEJswQyWxQR6Vf72anoE22KoiuUwWxRPM6jX2L97XzDwHEsl+fNS2qfGj6KeAYomNmEMdICMFvB4XFiWrTS/q1uL+WuKjWwWjgx3W4muYlLng8meUMgear593KvRc/ZjmoV+nTrR+63hE3EWQyMRGDpgELjXuUWDoeAcAMym9POvrKMR2OiYJcZTjxzyIKVtNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQAQ1UJC2/DptjFrfaweS/Ay25ld7FGsW1i23SBvyG8=;
 b=hHiYpRrMmYJMzk/IxCjUcoIxxO5wCzF0hKZVLGEMzOpfNNbQetAMG2iTFxJLEziI4tBKd4agcRVwPC1L79Mx/qV1qz1Z0dBoi/Pq3yM7K46tZzQlQiXk17+O1KYw1Takobe/LZyTt8G+ZXi9RO2/JMcrAdx6NEdEBolKmUogCX5iKTxe7qIXEjzuk64+ie3MyjPjPJZee6D1J4wZRhbxTdKdFRF+KCJDYLr11KOMlxBLEpejJwu9nx5Dp9KkIx1riV4Mj+/JPt5ot9lqWmr1ucHXG6ko9G7+uD30cHFFoRX+zzzJWgAfhejwD+1I5zuRX2sPjQXSEsm2im6i/FO8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQAQ1UJC2/DptjFrfaweS/Ay25ld7FGsW1i23SBvyG8=;
 b=GJSCRSIqV/3845mCcDVRUSgCLfefrZiTTZkPKYmeixyFXt3dYGY6Vzo1TRpfiBVaZIRAs3/UrMmPXrk3kVwLnexkOngRnnrEO/HAZOyDDZcnT+QGp4mbqSJOqAbFgNNFBejMioDMzRswBEwvR99q5luzlayckBMwFrXtNRVlFkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.17; Fri, 10 Jan 2025 05:52:15 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 05:52:15 +0000
Message-ID: <bc5650c3-e759-42d7-b993-1af838fd6a80@amd.com>
Date: Fri, 10 Jan 2025 11:22:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [sos-linux-ext-patches] [PATCH v4 2/8] KVM: selftests: SEV-SNP
 test for KVM_SEV_INIT2
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-3-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20241114234104.128532-3-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7393be51-9254-44de-6724-08dd313aef90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2NvNDRQUTE3UHlJRldpdUxDK1ptQ2tmaTlrRzh6OTJydVptd1NUMEI0VGxG?=
 =?utf-8?B?dmN5RDBNN3o0OUVMYVpUbXUyRzl3c1krcEVnOHM5ZGJuM1N1Q2U1em5TendR?=
 =?utf-8?B?NHJnMEpqV3hDVzlqbXVUSDlsN0JJcTNLaWY2YlozeVlmWWZSRDVXMFFSNFhr?=
 =?utf-8?B?K0drYWVUUG90cHFFUmsxcTlydklCclArZFVlQW1hTDljMGpEb2NyNXJITThh?=
 =?utf-8?B?K1kxbEtWNGl2c05DTHdNMGlRcXhjMGkyMTBvTFhsTndQU2pZY002a3c5ZXFS?=
 =?utf-8?B?amhJcStjU3pBYmU1OU1VSjlKSDFHN2l5R0RMRkRmalJYV0I1Q0lTQlpFdGxX?=
 =?utf-8?B?cGp1aWZOQU1VUFZQUWdYRk5qTmhNb1kvVERMWlM4OFcvemdTZk8zYzlXaHp1?=
 =?utf-8?B?WXZJeXpVZmIrZlhjblZuRFJWeVVRZENyVUFGSkEybDhvRHlCa3JCd1VwQWZM?=
 =?utf-8?B?eER1bENHa1M5RlcvZmQ1VlZocHhDN21BaEM5ekdNYnJ2MlhpMmNaUjJ4UFpa?=
 =?utf-8?B?MExzQnJyMThEM2FkUWkySjFTWlo1ODhnV2V0ditYVlV4dFBSWDlmc1RZNHhl?=
 =?utf-8?B?cStBYnVIY0tqWGFPNkxlcndxY0dRT01xNXcyaWI1ZXhnTlU1VWhxK0MwSVFu?=
 =?utf-8?B?MFdqQ2l6TFBWZ0h1MXp0VzZ3ZFpvQ21Oa1hwOGhRamk5dDNnVVU0WEJGVWlE?=
 =?utf-8?B?WDdBT0NSMGkybG5QZHZpZ01sSGhORWxocnNTcnE5b0l3WCtxUUhGZkU5aHdl?=
 =?utf-8?B?TVM2Nmw4WGVEVzh5YUEyTU5CRFh6amRsQjBGOVEwZld0emZtaWc2TEtqemdu?=
 =?utf-8?B?dXRoSkRIc1ZXVDFLdDIrRVRmYVBMblpRYzl3SUdua2xqbUlLOTVJd3hDb2d6?=
 =?utf-8?B?TFpGQmc2djY5dDB4MDVvOFJ2V0J5RjV0TUVTL1diL3h0ckNVVCtBb3pqQ2Z5?=
 =?utf-8?B?QmxPdXZhRi94eDdBZXlTdmh1aFVvaVJ3YXZGK3c5cHVnMk9vT1dSMGVINkFZ?=
 =?utf-8?B?Skd2a0w4Mm5oUFZUQmZtUXdUeHNKMm9kWmE3dHFzU1RSTjdrc044RnpBZmsy?=
 =?utf-8?B?aC9GcW5HM0FYWVJxR1JmbHlxQnEyQTFiRGE3NVlPN1QreHVhZUlXbFVPbytB?=
 =?utf-8?B?QnlML2V6OUVZTFFOOUpyN1IrM0U0MVpxMEtIOG4wMFVVVHlHVHU4bVcyTGtO?=
 =?utf-8?B?U2g1WFJsZmY3cGpnclhNRDNseG9VanRXNms3TENqeEhUVDZXbndaOFBvT3pC?=
 =?utf-8?B?aFdrclJiaitETU0zNlRpNTJISWVnUnA4eEx1QkYrY1kzc3FnSXRKTlhidWxN?=
 =?utf-8?B?RmJsRXFGS3pYWWQyeEROLzg3RUREZWo2TU1xOGpsTmZVMjlpUDYrRWlBS3dH?=
 =?utf-8?B?QjhaTUJmWnAvNXJZRWdtTEMxWWh1Q0xWNlZHUGp1ekduSDVLUDNNNWJKcFh2?=
 =?utf-8?B?YzkwOEl6bzhvVk0xVk1jYlF3dEN2WHpuZy9ZcmROeis0eTBaOGVmV2lPdXgr?=
 =?utf-8?B?Mkt6RXRnN1RKNFFUOTJYbmZvaXl3QkpWN0FhRmxyZGlVbXYyd09MdjlsMlgr?=
 =?utf-8?B?ckp5VEpOb280NGN5NnBRdjZReFpRV1JPdEpHQzlzOEduWnpvNSt1QnIzRHFt?=
 =?utf-8?B?MXdxd1JOeEhydUpGZWlSVnF5WE5SK1IxN2t0ZHlBcUYxUWtBcDljTTdvc3ZF?=
 =?utf-8?B?N0JMUGxjR21heDZvcDkzYUtxdllkYWFUTXhiYXdrd0VGTXVmaVhZSS9LNElD?=
 =?utf-8?B?Ny9wa3hBVThnenV1ZGNodll4MlBGeWNPVWNkUTIzTTFrOW1QUEt5Wm5NUzl5?=
 =?utf-8?B?QlhERjJuL1ZVTmptUXNxWjVYSHhQazdvOTc3ZTRDU3U1NkRScE80dHN1NE1G?=
 =?utf-8?Q?2NBS4Yhdu6YrH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJjaGE1SXVBSmtiTTdBM3NYOHJCVTVvQWV0SGY1SFlsYWNVLzBRbWFpT0xG?=
 =?utf-8?B?VWxzZnZKbmlFRWx0dEg0cjIvbUI2MG4zTnlVblQ4RDNZRGhvOFVVb2JCNzFa?=
 =?utf-8?B?NVk0d244WHlIN1BOTGQ4SGsxT25LS3lmSE5mNzZ0YjlET1krdzlYbFVvWUZl?=
 =?utf-8?B?emcwZ1N6TDljSGNJNEZwVjlKc1FNTkpPaE5ORW9UM0ZqSmNkMjVQYWpiMHJF?=
 =?utf-8?B?clEwWm54NDlwYkFLZjM3QXB2L2xCTDh4d1diSmZZb1Q3d291UVR1ZHBUem5B?=
 =?utf-8?B?d3pjb2t6YjdBQ3crMTBTSjZQS3d5TGlvMG5wVGtDSW1DRXFIR0ZUbEppQzhC?=
 =?utf-8?B?dVpZanRaYlpEcUJWcjBaT1ZXcUZMOUhka21OTS9RaldYb3VrQm9sWU9JRWlv?=
 =?utf-8?B?UW5Wa24zdlY0aUpCTDVOWE5HdFRrandSbGNWQUlIWFdqN1NWZUJmZUhKUkdv?=
 =?utf-8?B?Mks0Y0NXK1htaS9KZ214TDBwRWhVaTZEK1hVSkdRSmlqUGhWdGpUUUZQSWpv?=
 =?utf-8?B?NWx4YlFsQndGNkQ4dHN0QzU0UDVaMmx4bWNXMVk1ZjlIWGJlTUNPTU53UnZQ?=
 =?utf-8?B?SytzMSthdzU0OUNDYzJLNXRlRGFVc3Fya3JQS052NzBMdE5wR244OWhPRXdh?=
 =?utf-8?B?bnM2UFRadmttNVgrbWtBcnRqNklnMlJVdml3QjZVNlFZRVRHSEFIUXdxWVdv?=
 =?utf-8?B?Tzh0aTJEbkM5MXY0Nno0c3AxRmtaRExzVzFGcW9zbURNOHBuUkpUTWQ3OEY0?=
 =?utf-8?B?dEtlR0VCLzBtTkhxalJxcjdnQ3ltSEEycEhSL3JyZ2VrMzFsWmFIcnptMGd2?=
 =?utf-8?B?bUpvZll1WVVDa0FxWjVTRit5U0tXRGN6NXhsYTVsWi8vdEdTTnd3RjlnSVg0?=
 =?utf-8?B?eVhLY3dCdTQrdlZmdXlXdjd2Q25jTnd2OTdzbGp1Vmhvb1QvS2krYXQybGsr?=
 =?utf-8?B?QmxHM2ZMREpsOEFPRC9EMFVjc0J4aVQyWFpXWWxjelZLRCs4cmpqcWowVno1?=
 =?utf-8?B?eHV1RHV5MFVhdWh6eGpiSnlHVlY1YWs4UGtKQTV2UUJyMzFSbG5BYjVoM0Q3?=
 =?utf-8?B?bEtSUCtqaUh0NW1DNHluYzVqZDJvSmZDci9KZnBWQzFkSldaVDMvaklVOGg5?=
 =?utf-8?B?TEJNWjFYQ0orU0tDTDdyc3V6WnZkMFcrd2lraE9pb0hzSHU1SWV4YjhpU3dz?=
 =?utf-8?B?bGlDdThaMDE0MmZuajRvVlFvRFJ0L256WXZhOTNYenVwamUxQWw1eFI1eFZt?=
 =?utf-8?B?L1JhQjFlZXpTNzhIVEJ3RWI3ajc5Y3lqWkpIVm0xYlQ5SElGMjhPRUZwY3R5?=
 =?utf-8?B?SGNIRHlOT2V3eEhwajgzSFVTMmxJT0JLa1ZHUlpCS2NuaitrNkdBOVdlWG45?=
 =?utf-8?B?ejIwRWtmQm43Z3R6RmNhUnU5aDNmKzh1ZFlLcmhvQW9TK2lNQkVXZHhLWFR2?=
 =?utf-8?B?TnNsUTBXNEpmTlRVM3NDb3hpMVdhakh1MUdyeEtNR0xPb0Vmakh3Q2h3MGpq?=
 =?utf-8?B?TVVSNEdiUnpQYTJBOUcyRk5FSXo1L0N6MGxMeFErRC9UckZGd0d1TGg0eElH?=
 =?utf-8?B?MWF1dElocUxZd3MzRlI1c1lPT3JlRHZoTmlzNkFnKzBMaDA5TVpsV1pIejhP?=
 =?utf-8?B?dTFXV0JVTERVVFJkYWRPd1EyZnZSWTZ0aXJyN1g1NjNKZmh1bTJJdllYeWVZ?=
 =?utf-8?B?eElkVEd1VFJvd3RHUGdnYU04UTcvVFh4bnFua0l1eTNEbSsrcEQ4UmpKbCtq?=
 =?utf-8?B?YjdlTm1POGVObTRINDJyN3NxbkZXYXhCTm1ScnhEWHhJdnlnaWJHc1RJU050?=
 =?utf-8?B?VzhlOXdnRkQxVG56MTJhWnQ3dEtwNkpoTjByenZwa3V1ZVdkRzRCaVA1dERT?=
 =?utf-8?B?cDhsc2o1cld3bHdaYkJ6cmJiR2dEU1c2VnlVT0M2MHdnc2Q5dGlZeTZYQVJx?=
 =?utf-8?B?UEUyazVPR2JVQTYvSFZHcERFdXFpRnpwbTV2RW5zazJNNnlYMjFXMldLQ3A3?=
 =?utf-8?B?TEdNSjhocWVlcXBTQ011NlNXZXJIMnZadEorblI1T0JxMWhaWFBibUtwVHl0?=
 =?utf-8?B?Q3RVbUMyMGNkdmowQkRLUzd5VDFHM0lMYk1KU3VWUnBFdUFibE9ROXowR296?=
 =?utf-8?Q?/x6MXLKin1NxydRHbS737DJGX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7393be51-9254-44de-6724-08dd313aef90
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 05:52:15.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E00w+1KJOtWM09cuVloUOuJb9V3vBq5XS0NW2irB3yFMtxA8kyKxfNhs1MLu9eSsHl3yOZytfmxrn9qnOUQmgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104



On 11/15/2024 5:10 AM, Pratik R. Sampat wrote:
> Add the X86_FEATURE_SNP CPU feature to the architectural definition for
> the SEV-SNP VM type to exercise the KVM_SEV_INIT2 call. Ensure that the
> SNP test is skipped in scenarios where CPUID supports it but KVM does
> not, so that a failure is not reported in such cases.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h        |  1 +
>  .../testing/selftests/kvm/x86_64/sev_init2_tests.c  | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index 645200e95f89..c18d2405798f 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -199,6 +199,7 @@ struct kvm_x86_cpu_feature {
>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)

Unrelated to your patch, X86_FEATURE_SEV does not match the KVM API definitions,
1 is used for KVM_X86_SW_PROTECTED_VM 

  #define KVM_X86_DEFAULT_VM    0
  #define KVM_X86_SW_PROTECTED_VM       1
  #define KVM_X86_SEV_VM        2
  #define KVM_X86_SEV_ES_VM     3


>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
> +#define X86_FEATURE_SNP			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 4)

Additionally, please add KVM_X86_SNP_VM to the Documentation/virt/kvm/api.rst

Regards
Nikunj

