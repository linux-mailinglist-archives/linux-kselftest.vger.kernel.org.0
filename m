Return-Path: <linux-kselftest+bounces-17144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248B096C364
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B041F2199F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C701DC73E;
	Wed,  4 Sep 2024 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+ZVS5OX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F64286A8;
	Wed,  4 Sep 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465950; cv=fail; b=KEHUsfKRkt1eB9le3fWi8iWJCK+kXJky2tpwRAEdNcnZm77Zvtyt+3AjEFCgjbxyrNHdKF7T/aXBlV/MfzNbVCHUrMJN5Px3kj691SUfFVG2KuONeZ/AcW+effLMxAilXJuTgo6d/phlczWh4h5fpzd1zC/VATKoD8P3lp8Hgkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465950; c=relaxed/simple;
	bh=iTwinjvTZAERLfmsdvmiGDHpX/ByGasP787Qi2lpKWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sr7sfoIXGOHkkRaUcFeDVUTmVg71XC60qAIBsmXCVsRa97faY/JjTJxZHAjTSVtPEp89QoIBNe3lDVjkBhLpRojagoDl65rDnO1+zH4XgV/XP2ugEBZlPv3PYC1mTqgG5HvxuzloK2Y+1i/IOaCVC5hLN0atOBcIwFqT8B7i4Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+ZVS5OX; arc=fail smtp.client-ip=40.107.212.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4eBl+t9qOMX1RutnaCJVb4qFYs3F4D4ij4GGERB/JdbBusjwPhIEP7hWfZ3Xo5BPNVTV1AlGJEV+5T/XlxsAvBoB4FBJEwA/C/ydsbysi5VGn+kwKCGEiw+ZZZz6Zvbg8LfBdqUbnfPFLt7Y3xyhZyVHSmpFsCQhhAF0gYjg5mcomvo3ZoDyXIwqI+vI//CSGL9cYzupiij54fhffD+8eCpgSF3HLmLTCiJQvtYuh5fnVMOEzP+exG13qvVSc9mn73Y0snKzamg8PYwi0vCdDaJA6lAN3WE+whmyry2pPQiJ1NctqgZHcdQ2YqUtR3pSqlj2DRUUNAPjFp+iiX5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sz77v97D4gbSSwHIed/kI+F0Z5J6SA9fULjh5qTpo4=;
 b=OcNhaqldVD/i/wXHqOgcbDAzGTqTqthtiblG+Wnx7mIwZfGnR2vbRWxr4nwPRXiej3bi4ytGZtLLRsqxquIzWnDEpwuFttAZu13UhRyLkZQLDrPh84SRNlEIfuwS+eY0+4jgG02WYyHxgbB0VDLeWAWIdyn/ZtF3PPQn7KPPsY4n0c5FW0qNBnj7znRyaY7A8fQWWamHlQUVyWAIW3FhajWFM3J4yU2wwNTWu241oqbAV58+bgy1EnUXqSpPDd/Xr3Lutt1B90m9nA/ThDUSaB6cn1Q75WeglW/q0CIs1iyvuzpYP/EsNgULJKG7TDGl+tZt7WA1a/c518Gmgij6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sz77v97D4gbSSwHIed/kI+F0Z5J6SA9fULjh5qTpo4=;
 b=f+ZVS5OX1a+COep6cpYByKYiaMZGo7vmy9pjnOXsd7+/jWJR8yOj+PdG5o4LQwf5jH163yOe4/+JMpFIp0eRpcR64KlkUmIa+Ihj25F3rYQ50Xn0Jsy8IkqWw0KXdtG88vPhT7ia1JG2Jb/JVtuRJPHTnNW8q+7gQZ/A/3YEp2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 16:05:44 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:05:44 +0000
Message-ID: <61428e08-8b88-41cf-83b6-123a857920c2@amd.com>
Date: Wed, 4 Sep 2024 09:05:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] selftests: lan743x: Add testcase to check
 speed and duplex state of lan743x
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org
Cc: shuah@kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <20240903221549.1215842-3-mohan.prasad@microchip.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240903221549.1215842-3-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: d05c5dce-2d87-4066-baf3-08dcccfb6e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1A2S2p1ckUrUVA4TEQvQUl4WFQxVWtHR1hiZlRtZFVjbStsbVNkc25pdmp0?=
 =?utf-8?B?NmdyVUNueDRieGsxSDRpMG1hczFNbkRkcWkwMzhqQXBTVnF3aVJtanpRdFhN?=
 =?utf-8?B?YWtZNEZrSEVLNmQvcUsyODB6NjloTUJtQXZaRWoyeW5vTm9NUnpjOTRZaU94?=
 =?utf-8?B?TFYxSU5oZW9Xd3B0dGtORWxmVXhyNWcxUllqb09pS1AwK2RlMm5TbGVudThv?=
 =?utf-8?B?RDNVQ2VuSmNSYlBIQ0xobnpDQ3Bjcmg5M2FsZUJ6ZE5qYzYySFU3TjJPRXMw?=
 =?utf-8?B?aTYwcFJxZmUzajc3RDU1YW51QjlPZy9hZFZoekZCQW1NSm5rSmp1eWhpMUtM?=
 =?utf-8?B?eU5CTm9IaFdndVl4Z0RpeWJLZ3RDWGdWZGs4ZFNTc3d1S2E3cTJVem5aeW9N?=
 =?utf-8?B?bHZYM2UxV1JwMUlEQXRMNjFrUUlHUkJYWFFLMTZqLy9odjQ1MFdPVTdORlhj?=
 =?utf-8?B?Z08zWTlZdnRmcjdoUCtaMnVRUVdwemFHSjFNbGpyTndMWHBtQWlOQlg0R1Vk?=
 =?utf-8?B?R1NaTEsxODhvcXAyWjcyQWQ1NjZEclZhRjhrbkttaGNoZnM1YURiRUVBU1Nm?=
 =?utf-8?B?YUozWlVWUk1RZU9WTWQ4L201b1Z6MUxCTzhja3dBYnczL1FXY05DYTNsdVN5?=
 =?utf-8?B?Y0N5bXJGeFB1TjM4cnJoN1RMOW4yYjFZclBWK2xqaWFJbHBnMVFuMUNOOXF6?=
 =?utf-8?B?UUtJRHZOWUttUE9pbjZObDlvQzAydmorOUhFYzVTY1pZeWxLMGhEalg2bk54?=
 =?utf-8?B?T2p2T0RUbzluZWw0T0FkWW5QVlpad0JHam03MnltaDRMY0RtdlhnSzFLY2Vk?=
 =?utf-8?B?Ri8rZ05adGdQRDE4QjRMbWN2TkJzT1Zsei80OUF0NDNmVHFoMmpqWk9EMGZK?=
 =?utf-8?B?aWV6RG80YTdTT0loalVqQzZFWWZ0YzJTT0VSZ29qTDFOUlhlc1Jua3MxQUM3?=
 =?utf-8?B?WmZVTWI4K083anFKRDByWHRIbHBtRkI2NDhLalFONGsrdncyVlFCVDcrZFpV?=
 =?utf-8?B?K3ZxSzlvZTFBSitXT2s1MXRqQ1FNbXo3K2duaXVjNDVCUHI2UVFoTEFncldF?=
 =?utf-8?B?cE1pNlZXVXRaMGNRSzEwNk5weWx4NTVrZjFIRWxCTzMzVHRKaFY0V1Z1SjlX?=
 =?utf-8?B?NFdxbnJRMnZtcVVoMU9XeDFoNXFYeC93cHAwK1JVT2FyV2RWTk53bm1kU3Bm?=
 =?utf-8?B?VEh2RFJZYlhwYm9lNVJLY3ZobEYrZHp4QTBnSmJMRkd6amZVcSs1NEw1aVo5?=
 =?utf-8?B?UGxrUVlUcU00d1ZjS1VJSHBsRjZpS3h4QUlMTDRaSmtEVUFtbzFWU1hNVFll?=
 =?utf-8?B?NUxMdS9pSXh4dFpyUEtGaDZ0VnhYZE5jYktCUEo1REVjZzVRTWlOWXpzQ1p1?=
 =?utf-8?B?TEN0VmUxdUIrQXhocWpvSjJ1MGhRUG1HUVBmZXpXcS95cW1vOUJaS0hMT1JJ?=
 =?utf-8?B?T1dneTByWUtraHZvSCtlM1FFRDdHVFdjYmh1dmdXMVhQc245bTI1SVl3elNu?=
 =?utf-8?B?VUxlekhLRk84aWRURUt4S3B3aG1ZRVJ6S0hPWjlLNVFQQnFDOUw5aGkvelBU?=
 =?utf-8?B?bndYaCt2cFRsR1FaNHJCUHlQWlF1Tk1adnczUENURjFlRmFha3lyZzNibWpx?=
 =?utf-8?B?T0Qzc2llRHlXbjVadXg5MWdQNU8xbzZOSnRZVDdVc3Q2VHp1Zi9wUDN3cDUz?=
 =?utf-8?B?Y3FYM0Z0SWp2ZDY4T254RENEVGczQmc5QnRXTWk0WWF5R29ENnZhVjI1Nk5O?=
 =?utf-8?B?eUxKQ2R3bGFsSEtlakZNOWtpcGxOejFFVzBMZkVERXkyaDJsL2dtNFFBRUlM?=
 =?utf-8?B?aFE2Q0QyVVliZU9vTXBxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVFZYUdUamEzZ1FyUnpqWjhHbjZHZG9SWEl2ejBSTEZqYStzMWd6UmdvUmVs?=
 =?utf-8?B?ZFQzQk9wdXFoY2tNT05CQ1dmaFd6SFVVdCs1bGZhVmtmU29JM0s1YTl3azZq?=
 =?utf-8?B?bXhSSGVVdWxDMkVLOEs5ZjR4K0IxV2YzalBJVDhCNHloTy9ubkZEU1hINktH?=
 =?utf-8?B?UFlsMzUvOWhPK0tMd0xEZXprM082Q1AxdXExQTFteFFmckRYYzRWV21UMGdK?=
 =?utf-8?B?Ukk0ZlJqVDJ6MlhtL0FZd3NuQTZMVVFXejF0NEgzU0p4SUgzQ3oyUnFDWkZn?=
 =?utf-8?B?M0duMTh3RHhhbXdwYXBOMzBrMTYyMVBCTWVIN2xUdklqTi9PUkkvV3BVSUVt?=
 =?utf-8?B?T3RiSzJBazhSRUR2YzdacHFpMCtOS1JscWdUT2hqWllIdURSQmxZTDRLL1JJ?=
 =?utf-8?B?MzR3OHF2bHpmN0hSNEd2L00wdndnQjc1R1VFVWphU0d4UTVzUUdadW1PVUE3?=
 =?utf-8?B?SzcrOS9wS3JRRW9rQkdzNEpueGpRKzQ0alBYV3QzYlpQWDk4NHJoTE1ScGFr?=
 =?utf-8?B?NHRRZE5jbUNNZGlXSWxaMG5MaGRWNlRjcURibWxQa3RqaS9pTlNTTkswQVgv?=
 =?utf-8?B?cjJIMStUOGpsNGRxbUhHQzFhd1BPNEozQ0RRWEh5eU91cnZqc2ppeVdhNmtL?=
 =?utf-8?B?endiUU5rbkl6dGhPT0ZwZCsrTDBaYk93a2xPeUJJQWJ3QjdEcXpCR3QzT0px?=
 =?utf-8?B?TE9OUWtIMXF3WHFPTUFCV0s2UzNIOUVHODNRY09mSWw5UlJwZVRLL2FOUmhI?=
 =?utf-8?B?Nkx1SnFDWEFMVUtjRTFHQ0JsaE8yd1FJcElkS250QStqS1FTV3hwZWJkNERS?=
 =?utf-8?B?MzgvNzk2SmkrQjJiSFlIMG5Qdy9vbi81K0F6b1gvMVRuQU8zN2RQeUZtMnE1?=
 =?utf-8?B?eFZmZG1CM0NNNlBQb3VCV0V4Z2dGeitjbDNUamhzbkp3REJPczF0THVWQS8w?=
 =?utf-8?B?bFI5b29JZGpYaTE3NDFmVE9rc2NMTGduSGtEM3ZRUWpRR3l6dFVuUkQ4SE5i?=
 =?utf-8?B?N2dsSEp5bWxSYjMyMC9Vc2lYUXdrbE1EMDFma3VOYTRCai9VNGJjVGUrdlFk?=
 =?utf-8?B?YkhCdUt4UGtaNkpBdE9KODFtaFhJWWlWOERRY2RCRC93WEpXT0F3VTR4SjBR?=
 =?utf-8?B?enVHQ1B1S2JPSlZaQWNlRDI1U2JheWRBM0c5QzJPNlhINGZoOHNjQmVZelFI?=
 =?utf-8?B?ZWpqT3FhWllpK3hoQ1dSb1VkU0p4aHJZdDYxU2NSN2o0VWFMSnZIQUg5aTVQ?=
 =?utf-8?B?dUJFSDdrRStRY0dDdVMzYXhWVEF4VVQ0K2tIb2NZTm1mT3Z1Q09GdTdCaTVE?=
 =?utf-8?B?RGdJMWFwTE9EdUZ4ejUwTWg0bXhJZWI2MmF6VktpaDJHVGxlbkNUREJTTGMy?=
 =?utf-8?B?VGJwTXhoSXFBTkRHYVRoUksyay9PekZwZDArR1VyYjVBNWRDcDhyS2I0RGtH?=
 =?utf-8?B?RllCOEFKYW1wV0daKzFXa1E2NzVJQWVsNG5rTnQ2bXlObEp5dEdRb2ZOejFF?=
 =?utf-8?B?VS8yMFdkdVFvTTFNaTFoM3FnMnk1UU5HY0x5b3FPQlNGV0g2c0daLzJOa1Qw?=
 =?utf-8?B?MG5udE51UzdvTWZFWXN4TGR1T2F5S2YrTUxQalM2Q3hQd3pmQkpJQXdkbTlk?=
 =?utf-8?B?Z2hzdjBSL0ZpaEZkbHdkODhFWEpVbS92MEdUdDhzKzRjYW9KdVUrM0ZGVlZs?=
 =?utf-8?B?bzcvM0E1aksxTlVtOWY2c0dJKzdYekFXRTdkeXpwcU1yRDlmOVozY3VuNklY?=
 =?utf-8?B?NFk5aStrWWpjRlVHejhVSUVxRkxYSHN2L0g1K3hJL1pzNHdXbFR1ZEdUS0VU?=
 =?utf-8?B?NjY1Y1pKZlFjdC9XMkVseENDaGkxLzV3bHhNY1FNYmFvbkNRYnA2elRSMzEr?=
 =?utf-8?B?V0thaFRMaTFlNmlFSXNNQTBvOVNSS0t4Q09Hd0JGV3R4QnRNTXd2RFo2Z2l2?=
 =?utf-8?B?WnYwRXJPMG5oQ2huV1lLMnJCOHlFeEkrWGo1S0ZiOFEya2kxMkhScVRQc1Zv?=
 =?utf-8?B?WWNNb28reHM0WUJlQWMwMStHSFp6Si9EcmpoZzdKR01QckliL3pUQ0RkNFEy?=
 =?utf-8?B?NTNlVG80d0pUL1pkVE5hVk1NODIvNVJ5eTVVbFlwcWRGR2N0YUF6azVhYUJL?=
 =?utf-8?Q?7EhFn6zM43NjRTlStSs5MXEy1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c5dce-2d87-4066-baf3-08dcccfb6e3f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:05:43.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI7vSj3V19QLtND6uZnhCrxD5E0Mt1TTf0s3s8VsLyq1IMQTcWzRl8G5l38N/dvC86tF1VWJ4Lc8wdkfmLA+/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108



On 9/3/2024 3:15 PM, Mohan Prasad J wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add testcase for checking speed and duplex states for
> lan743x network driver.
> Testcase comprises of varying the network speed and duplex
> state to 10/100/1000Mbps and half/full via ethtool.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>   .../net/hw/microchip/lan743x/lan743x.py       | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> index f1ad97dc2..59f0be2a7 100755
> --- a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> +++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> @@ -36,12 +36,45 @@ def verify_autonegotiation(ifname: str, expected_state: str) -> None:
>       actual_state = autoneg_match.group(1)
>       ksft_eq(actual_state, expected_state)
> 
> +def set_speed_and_duplex(ifname: str, speed: str, duplex: str) -> None:
> +    """Set the speed and duplex state for the interface"""
> +    process = ethtool(f"--change {ifname} speed {speed} duplex {duplex} autoneg on")
> +
> +    if process.ret != 0:
> +        raise KsftFailEx(f"Not able to set speeed and duplex parameters for {ifname}")
> +    ksft_pr(f"Speed: {speed} Mbps, Duplex: {duplex} set for Interface: {ifname}")
> +
> +def verify_speed_and_duplex(ifname: str, expected_speed: str, expected_duplex: str) -> None:
> +    verify_link_up(ifname)
> +    """Verifying the speed and duplex state for the interface"""
> +    output = ethtool(f"{ifname}")

How does "output" get used here?

> +    with open(f"/sys/class/net/{ifname}/speed", "r") as fp:
> +        actual_speed = fp.read().strip()
> +    with open(f"/sys/class/net/{ifname}/duplex", "r") as fp:
> +        actual_duplex = fp.read().strip()

Should you check speed/duplex from both sysfs and ethtool? Maybe that's 
overkill.

Thanks,

Brett

> +
> +    ksft_eq(actual_speed, expected_speed)
> +    ksft_eq(actual_duplex, expected_duplex)
> +
>   def test_autonegotiation(cfg) -> None:
>       for state in ["off", "on"]:
>           set_autonegotiation_state(cfg.ifname, state)
>           time.sleep(5)
>           verify_autonegotiation(cfg.ifname, state)
> 
> +def test_network_speed(cfg) -> None:
> +    speeds = ["10", "100", "1000"]
> +    duplex_modes = ["half", "full"]
> +
> +    for speed in speeds:
> +        for duplex in duplex_modes:
> +            # Skip for speed = 1000Mbps, duplex = Half
> +            if speed == "1000" and duplex == "half":
> +                continue
> +            set_speed_and_duplex(cfg.ifname, speed, duplex)
> +            time.sleep(5)
> +            verify_speed_and_duplex(cfg.ifname, speed, duplex)
> + >   def main() -> None:
>       with NetDrvEpEnv(__file__) as cfg:
>           ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
> --
> 2.43.0
> 

