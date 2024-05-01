Return-Path: <linux-kselftest+bounces-9226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1948B8EDB
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3001F217A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71A17C9E;
	Wed,  1 May 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mx4f71EG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C7914012;
	Wed,  1 May 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583667; cv=fail; b=APulUF2MAJ2sCz4MHEp1LHS2F+/UEDEfK+n1/Zr1zu3Xiund9az1ILhaZsGYapCE81fGCbY1dRzgzZUs35Q2O2upcS6duqMpn0Ily7/EpYum79z1ARolRQ38muvRcgg68Nipys3f/9bZyPbRCJugUKUG7MnvOAT1and5FpjOxKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583667; c=relaxed/simple;
	bh=zjtrgpIp2X3M4Dgz30xld9WSKejk3Q5v3FcwhSuNUS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNMv90qxqjZANDy/MKYV+rISpHf6Bl7WxXw2R7PNtVc/+Ptbe9nm1zzIBw6/KmH6pYmEhW/oxS5zoFTpM12/h9jFphdAO7Ul69rBeYux8sYUHhTgGJrGOBRklZFtlIRVO7WBvb+Y7qNAQSpop2v1Np4azd737HuJJ0mMpHlZSjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mx4f71EG; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ5vMG6uWFHZFSuGt5FdNoAqP9lY7NrvNa8oCl1VzH/tYoEBqQHhP+48xO6khb+321ZqXjjc9VlpZCx+k8xRwvyrFetNDwdZYByF1pbEb+tx9a71/BbnPPSjTfHMokydOJFKU9P9KB8eOLQRP53jGCNYpo45thF7bOpOM/NB9CZSJZV+x+HW8i5nd4PrLMTMCUy2uUY0bXosXyfoxYJbuAEuDFka0q7xvzAW6YZZMVUIRzeAg5B0pHgtXZSuEyeolYuG6hnB+CEo8xdeDatpk6sVXqrjxJtz/veLQCCsxwS5QqaG+J22f/dxAOMTVZXmwHGyyq6S5s4d9eUcvG9QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRgPck3ub2xtx2rXFl2+3E78FV153Em99LUlha1hxJs=;
 b=mVxR5F6dqDcjio/oRgny49WQb25U+HNsehMMsclgqVTjTKIc2NxQWjU/1pT7LU9CyatWlxLYS8WMwp8XBrrTvVxxojYizrBBxl45VMpAXE6GisXglSmjx6Rggf/gx7Hm1uQv9ALwWBBUZV8wL3DRfIeGOYRFrVne6RG/Ikht4m+hNf49Z+0nbcsNzGwg79A1v2DLN1BcZu8ydCc/JlhFMKLkU4WiEad9rFEinmRBtoKPcDlD7NvJ1JMEYxgRHZcRJp02f0Fgs2EcFMY5XtJEK60PHscBzUIDNlJBxXt+5X4KoVj9bfJCvM9/LgsG+iU2Ha08InwoRwo6fnijcHHNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRgPck3ub2xtx2rXFl2+3E78FV153Em99LUlha1hxJs=;
 b=mx4f71EGRgtFFV/IeEjG5MXcpN4V/QsKEpmf8Nxfi/Pf47FSt91IngcP/Hf0wRXz0zQd+H9ucXoA2vs6sHdQJwMlDuV7nswWgxpB+g4LgXwDB9Iflltwt7/EczCVLURvSMHf6SgeXMoiL+XQ5c0Y42/ASKqwhSEmWWDVV9JgSGY9uaR858wHyAzReSsHyDPmo4kqSQAAT2s3xoFSnMuZvd0IEOncMToQEIPZRFuJDP5MutleGbNkH5/5nmhPsfNhiIX3giB6ds8kmv94qUVachHGukm2sDohvRlOdToSoQq3s7wXkDltkMhR61P7aleXFGHkO0QZ9TCnfIheEVReNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 17:14:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 17:14:20 +0000
Message-ID: <26435372-004c-4f8d-b16e-a26a1806147e@nvidia.com>
Date: Wed, 1 May 2024 10:14:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/harness: fix many "format string is empty"
 warnings
To: Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 Kees Cook <keescook@chromium.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>,
 Bill Wendling <morbo@google.com>
References: <20240501020813.264878-1-jhubbard@nvidia.com>
 <20240501151343.GA1018661@dev-arch.thelio-3990X>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240501151343.GA1018661@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:a03:338::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 517832c5-0fc9-4cd2-6804-08dc6a02239f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUhTVm41ZjY3aDFyblFmOEUvVUlReUdhWVI0aHBSTDh2L1VVSko0a2phSEIy?=
 =?utf-8?B?bjZ3akpMZ2Y0RTltRjRWeXFXaUZNNkU5cUJFOTJUZGw4SDc0dktsSXh5a25Z?=
 =?utf-8?B?R1NiZWFaYzMrTzJDUTg3ODIxcWxVbC9GY3QyNjV5WXVqeFVQSkFQNlBWVzRZ?=
 =?utf-8?B?Si9EczdSTUZpbUZVVWM0VXV5elowbkNTYjlhRmd5M3JCQW9ISjVqT1ZxaEtF?=
 =?utf-8?B?MW1qQ1JIMHAwWUJRQ3hoZ2Evd3pHS1R2VTFMMDdSRis3K3JxNkZBeHNibTAx?=
 =?utf-8?B?SXdLSUZKcFhFbVRNaTRBYjE5UzhZNTdqQ0h4aGgvRWQyOUtQdzZrT2RzaXlv?=
 =?utf-8?B?OEJhY28zNXBrVmxPcDRoc2ZRMmJnYXdxcUNzazRVWGtiMzRmNU0zMW9MTzhk?=
 =?utf-8?B?dWVmZ1Uxc3hsK2dwZTBvcUsrSVBoUWVRbHhoREhvbzREK0F2NXpvcUtvRVo2?=
 =?utf-8?B?eUFuVndnenV5bGZUckpzeHFZWmR3ZGJMaVEzQ0xhUzYwZW9KREowZVRudEJr?=
 =?utf-8?B?MEpLdWdjenJjdWRTT1FscnlaeHBWaU56OFcwN0VWVSsvTlRtMExUYzVxeEFZ?=
 =?utf-8?B?YmR0bnZmaENONkJrdk14ZWhFOEpnOHBaa1NWY1RweFByc3YwVmIrK3N1VXFW?=
 =?utf-8?B?MEN1emxndHk4VkZHbjBlVTBDcW53MllWajhST2Z6Yk1YaGJ3UGV0NUJSS2M4?=
 =?utf-8?B?Z3lXbWFNQi9UWUUyQThseDlXK296QVl0TWtYVk05QytJNVFXQjRYSWc4bzBM?=
 =?utf-8?B?N0Zadks1SWtPY21CaWxhR21kQmN1bFZ4N1VxdkhDTVZpcklFdE1TMWpFR2Yz?=
 =?utf-8?B?MjEreUVDYlhRNnh0dnJNcENob3hmVWVuU3lNSUN6N0x5TUdFTGhaMmJLellL?=
 =?utf-8?B?ajdqTXk0eko0SnhyTjNMVmd3STVLaC82Q0YrbHlObDAxQldkbGdzWjI4NFdQ?=
 =?utf-8?B?UFAwM0tPRTBxc1V1QUZsQ1hEdm9nb2xkOHREbzBoVHRSS3dHaW0xcTJrUEVq?=
 =?utf-8?B?M0hLclFYM1pyazFSL2M2bURLbGVMaGRiQks2RVBrRU44NitwbDgxSGI3WElw?=
 =?utf-8?B?YWwxeWg0eHYwdU0zR0lqT0xTaE0xa0xqNERNM21ZcGV5a3UxNnVldE9YT3RJ?=
 =?utf-8?B?c29aODVtd3VaS0QxbUo4MWpCRUMwUlNhUzY3ZXpneTNrUmJySVdWcmZzc3pw?=
 =?utf-8?B?RzM1aDRYVzE3c2NLRmZQVDU2eEY5emN1Y3ZwejUrUTNlVmlFMmwvcGdreTlM?=
 =?utf-8?B?ajVSdE1mbFVJNGlFT2lzeTQwMGNwTG01bFhKYlhTeUZCNHY0dkUrQU9UeVJF?=
 =?utf-8?B?dWpRbjJ4dDhQdVdlQzE0OXE0b256WU1hQm1tdmZLWlgvb2VYV1pWYlFUeUVK?=
 =?utf-8?B?SGFuTnVQdWFacnJ0cDB0MlFZUUpub0RkSTFNeHFkTmsrU3JsYzZnV3hKb3Ft?=
 =?utf-8?B?U2hGL1crVUZlVlM2L3N4NVRkSU96dWVHOXBPcDBUcUtDbjhIL0JpSDdqYlo4?=
 =?utf-8?B?SnppZG45ZTFhbHVZcmNTK1R3YkdhZUk1S0dVOS8yeGEyM3ZDc0dNaS8zOGxa?=
 =?utf-8?B?Q3RXdnVLQ2NMbk55WUpHeW00bHI2WDlOVElUbzdzcWQ0ZFlMT0ZKd2JJY3Bl?=
 =?utf-8?B?RTVLeGdKQnBlRDJKb0taTGFpbkRmRG1QOTFFUzU4aDhSckpDWlRLTDZUUnpY?=
 =?utf-8?B?TEdVSlBEV0NSS29USU5yeHFTelpBTmczMmNIRXVPQWJVUEw4M1FWYWRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDRXNHNpNTVzZklqaXZ1aXc5M0x5MkZRaUFJWlRjWWV3YklmWk1mc0orZXND?=
 =?utf-8?B?blJHNVY4OFp1K1JrdVBkTlRKaExzdW1RNmw5UFZQTmczM3IwWkNVY2JUZE5H?=
 =?utf-8?B?UFM4Wm95QWlReStreTlqRWRNcHJyR1JCSVlvQlVGSGRENlBEMjhnUjdQdGdl?=
 =?utf-8?B?SGpwL3hKM1JUTXJMcEdqT0hvYzBINjJTUnpyY0hKdUsvZ0FTdmNHejRUdGdh?=
 =?utf-8?B?aVlEaEJiTmgzcTJBVjRwM1JZTkVkWGFvRkswOUd2WC9pajFHSHRhZUJKUWJZ?=
 =?utf-8?B?RGFHUlkza2c3QTVTWDdITXVEQ1Y0SFNqYXhjVy9FL2VIMFpReTF0ZitZQzE2?=
 =?utf-8?B?MUVzSGQ1U2ZEOFBMbHNNUmZoMmpiUDdGdFhOVmI4Sm5FN2NuUU1XTUZ3UW1W?=
 =?utf-8?B?dFN5bnQwYnM3TjJPSEFzdG02LzhkOXc3U1BJS29rRVY4cldwOUtsN2JWcGNS?=
 =?utf-8?B?bXo2Y2pJL053WTEzRWNpWjJtN2YvNnovYUxsZUtSUzJJZ3ZUcFBhaEJUS2pD?=
 =?utf-8?B?RUJ5OXV3bmNLRlRKUG15aHJZUVJwcG9ycUlNbVNkWG5nclo3OXhtNlMrdFY2?=
 =?utf-8?B?NmVIOStZNGdvOVovVllDS0ZSckxYM0ZDR25yRGxWNUcwb2xHNFpldDJ5bUlL?=
 =?utf-8?B?YUorM3htck9iRjd6M0JYVFhzQytLVVFRdHMveXZSdUVka3RmS0M1dXYveE5k?=
 =?utf-8?B?N3VtckFoY3BPUDR4dDd5UmQzQWY3RWdYdFJYZU1yRExwaUxvSGR3TzRZcGZu?=
 =?utf-8?B?QklrUnp1NFI3eFJxdEFSNS9EVFVzNWVtNFd5dDBsRU12OW5PSFdVbzVMbHpP?=
 =?utf-8?B?Q3l4bWhRaDAxWG84ZjU1SldHNWxEKzNKR0FEL3hmVUN0S3lGRENwV0poRU94?=
 =?utf-8?B?aTlxaVk5R0t4eEFXYWppRmJCbEt3VlovdWx5Y2hyQ25MQ0RjbTNhTVdiRzk1?=
 =?utf-8?B?R2daQTVJYUpWKzhzS3RFSXVkTkhhTml0aVJkRzc2d28yVWR5L3pFRktyd2Rh?=
 =?utf-8?B?UmRFQlRFaVlFRzZ0VjE1MDl0aUxMenk3aGp5NExEcTJjaVZQUXY4cjU2UUpm?=
 =?utf-8?B?VXNmcE1ZbmZ0Z0t4bGhEL0k0R0Q4K2hGb1o0V1c1NytJdnczOUNuZjBjQk5m?=
 =?utf-8?B?MkI4OUxiZjR1MU1JejRkZmFXWTZUUXBnVmJZNUE0dllVbzQzWkJNSzVpenIz?=
 =?utf-8?B?aEZMZnYvcDNRQXhkbTBiMjArK1JWUmJILzJaMWhyKzBwK3ZWOEdPVkdOZ096?=
 =?utf-8?B?ODVNeDEzc1o3Y0wzcThhb0VHdGRKU3BpWi9QQlBsWloxVkowcXoxV0wyR1Vx?=
 =?utf-8?B?SkdkMnlpVmxQNEhJQ0NpaVFwOHJNUjFrbGs1VGo1TlJHZmVySWJpWVYxTjQz?=
 =?utf-8?B?VnJRS01HQ3BCbzdqSkgzNnR2OTRUQy81SGFrYjVHdWpxcCtOb2FDaWNtcHQz?=
 =?utf-8?B?N0MrRWgzYjZoU2FGWEd6MFBtRzE4WXo5bnVrVGdKbkhWSWpGYk9rYTBKQTRz?=
 =?utf-8?B?dlYrV0xKaGlaQlBKd2RzK25mVTZZU29RbFAzNkxvejVFR2p4TDlJdDd3Z0RF?=
 =?utf-8?B?c0VIVTFsTHpqQlY3NjUzbzNtS1pVUG5tc3RoeGZGaWhKZldmelFQZTZlMU5q?=
 =?utf-8?B?aGYyVTJRamwxdjU0ekpsbFBzTE5mS1VUaUltNlRvTmhXS2JRaE5MRkFlQmFw?=
 =?utf-8?B?b0xBY2NzVjVXZUdxWGxoMWEwUjBZUEIrVlZ4YThzM2E4ald1RW5Sd1piSkdp?=
 =?utf-8?B?UmJvMWp0a3YxOHJ0UWxDSW5zdFdEWDJBYnhQNjFYMlh0N3hHSEZFU1RFUlFI?=
 =?utf-8?B?aGxmR1JwQ1BzUlB2N0RPbjg4aUlaNXhCd3hSa0ZBcmhUcFdKNWxvYjF4cjY5?=
 =?utf-8?B?VGJVT1IwY1lIdjFOeTl0VFVzU3NaQm9LZllwRWFwOVdrd2hnV0F3eDZoMkNt?=
 =?utf-8?B?cXhjbU9jVDZFb2VHME9YM2xxTjV2R2ZRNm9oanVXSU4yaGtLL09QQk9kRGgv?=
 =?utf-8?B?NndIS2pQNWVWQ3llVHBDT3pxcXJnYi9BbytUUDNzVDl4MDQwWnVucjZMR0VF?=
 =?utf-8?B?MnpkK0ROUklhdnMxQnhyMDJoekExRUFsa3h4eDcrUEJrUEJBTkdHaVMrc0Nz?=
 =?utf-8?B?S2xHODlpT1NBaVVaNzhTckpmK2FXOXpNVzZRVHN0OFpvYnEwMVZtNmx4RWto?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 517832c5-0fc9-4cd2-6804-08dc6a02239f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:14:20.1117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbgLK7JSu8481ukBr56SQCeSzROwxbgQBPkHwXkaU0LQQ74Od1rLOTRYRJa8f5GjYRBY3W+48DrZzki4+MJE8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625

On 5/1/24 8:13 AM, Nathan Chancellor wrote:
> Hi John,
> 
> On Tue, Apr 30, 2024 at 07:08:13PM -0700, John Hubbard wrote:
>> In order to build with clang at all, in order to see these symptoms, one
>> must first apply Valentin Obst's build fix for LLVM [1]. Once that is
>> done, then when building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...clang emits a "format string is empty" warning. (gcc also emits a
>> similar warning.)
> 
> The warning you are describing here sounds like the same exact one that
> commit caed8eba2215 ("selftests: kselftest_harness: fix Clang warning
> about zero-length format") should have addressed in 6.9-rc5. Is this
> patch actually necessary?

Apparently not!

> 
>> Fix by passing NULL, instead of "", for the msg argument to
> 
> Because this text is describing what was done in caed8eba2215...

Yes. I took a while between discovering the issue, and posting a fix, I
think that's why.

> 
>> ksft_test_result_code(). This removes dozens of warnings and a few
>> errors (some tests have -Werror set).
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
>>
>> Cc: Valentin Obst <kernel@valentinobst.de>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Justin Stitt <justinstitt@google.com>
>> Cc: Bill Wendling <morbo@google.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/kselftest_harness.h | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
>> index d98702b6955d..456b8694e678 100644
>> --- a/tools/testing/selftests/kselftest_harness.h
>> +++ b/tools/testing/selftests/kselftest_harness.h
>> @@ -1207,8 +1207,10 @@ void __run_test(struct __fixture_metadata *f,
>>   	else
>>   		diagnostic = "unknown";
>>   
>> -	ksft_test_result_code(t->exit_code, test_name,
>> -			      diagnostic ? "%s" : NULL, diagnostic);
>> +	if (diagnostic)
>> +		ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
>> +	else
>> +		ksft_test_result_code(t->exit_code, test_name, NULL);
> 
> but this diff is not doing that because it is based on a tree that has
> caed8eba2215; instead, it appears to be a completely identical
> transformation?
> 

It's nice to see that someone else had the same fix, anyway. Sorry
about the noise, and yes let's please just drop this one.

thanks,
-- 
John Hubbard
NVIDIA


