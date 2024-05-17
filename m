Return-Path: <linux-kselftest+bounces-10336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715448C82B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDE4B209A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC08489;
	Fri, 17 May 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kphP8B0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D391A28B;
	Fri, 17 May 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935690; cv=fail; b=moUIBzSBTDUIV9M4VjbA6P4Mr2LzUzjdxv01bw81KozpbiCAbEV8/R0qa3cHXFG2es7zg2dDW4U/VCZD/2w/2rnDFpxyIdY1ktXIIl10hZ/nZjXbJojzjfHYtcxD6q5fo8QLx3nGAjFcgPJzsam8FlkymEN4vGi1DnltVFvN3ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935690; c=relaxed/simple;
	bh=NHwWOdkeV3KZw+Lz/x2/xhqqrnvQPu6AEafg+T+0VSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lUBaOs3PejD8CVrezHFiQqCmt+EVnB84TqNq7TWNg4guN81AXnjAZ8yMR0Hno3p2qAyko3+gFCIRnDK/x/rZ+GOCa9svtVdpEfp0wZm27R2T5rtHLCmD2cQUWDy0gENJTSM6b3/BNYvxKLkt6J2bFDMijQAJZQgQwP/k3B8+puc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kphP8B0t; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4pSSpUg752hV/GeKZRU++yUMs2LAxvojiRcqrtSkjm163jXOvqcBcCu1xbATcOABJQry3etC6NWjfswUt2Woy8Wk0ewryr+O/S34pPjY/tiZRpVYA4plZks3n9L6aQkgMM5we296nfdqvdIYuuJsVyDFFZSK0PHMkF4yJqpiv6GyBmR2w4rDPrF/aYvrmTSXRXuqT8qcIFmICOd1ENiIhikUump3EwMBk1tInHVZIWVyBfTcMTPDELAzDV1UH20sj/l2uOq6IP+KtMeHxs5IS5KumhX0PSr8IYHORjYfYiBZHVDKQd6B9yQ3jOUcdB5Tyz5JSYGLI9+c5PGV78rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86dVHmLiZ1OdxlgkerOQK7/M1XiZfw3o8LWdfC2Czlc=;
 b=CdQn3M8vaRU4rKSdLQiUXtvh/iNavVHLz65A9w4z+hOCfVQG+dlqaR73zjni4r3rYannepA/hzA82NhF3gR34B+2lOChTlU0ZPqMWJnekWd4rd9sS1GHOA5IJUGJVVpX1ayFYKOZ0Iegf2sl9AJ/Wkb0vI3DKxbB7jYkD1MhyMtJMOetFXnDrccgjbnctnEdJk0bLsYYkEaXwEkhhp7lO/n6KHmA0ce/YlFudONwpVGwi2hfJo0ly6jlchlYhimTkaDSdVxuZHYpv+PYMqSkER+0fFOv7MLdzFfz4lErzX11B/L3yOfiUDTSoJxfPfSFvXyK4Jv94okXk/xHyW/FHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86dVHmLiZ1OdxlgkerOQK7/M1XiZfw3o8LWdfC2Czlc=;
 b=kphP8B0tDeJmoYzKwE/PIqbwgaGo0svPV2ZYB397K2a4+TAK+T6xWRke0GvMptY72DFIbPBPROh12y0nb9RED0LuaOJn++zPw/fALnpkcbR/JBb46JLE+jvDz1KeZSlZ3YQ3B7FQJbMiWUpRpBg5uZTK/z5yG7YWrDIiVin97ymSKLNXofH/EeOG2+TX+Hfoxg5Q5ImqtadxiLNHS2tz738sK9fumnTBvZYZW9tbgm1ObsUFdhUIOEMvbZPMN+lWXaAQE68kMIAxICvqYzZWy2vHnDReBidc+26n34OrF05JpCINe+EakViu3KNgg5e2eoJwFUmY5B2oU68ZLP1jKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Fri, 17 May
 2024 08:48:05 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::bbac:e733:5c7e:19c6%5]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 08:48:05 +0000
Message-ID: <b656fa77-46ea-4f7c-bbbf-235cffcdb14d@nvidia.com>
Date: Fri, 17 May 2024 16:47:56 +0800
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
 <ea0bacc0-2765-4d8f-8b62-0e9c45c560fc@nvidia.com>
 <20240517080843aeb408e4@mail.local>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <20240517080843aeb408e4@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: ea92c917-4d8b-4f50-5d24-08dc764e1111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckNKUEpQQ2pNeFBLN0FacFpiV0FyQVd0UUVDeitSNytSMnFXTnhWczZ5RVJP?=
 =?utf-8?B?bENuVnpWY1BYMXNmcW1HbkVRSmtjWE0zRExBT2J2YzErWjAxN3pxaVRvRGUr?=
 =?utf-8?B?b3hzUzlXMUpQOGg5SVhFdnAzdEE0d1Q3Z3AyWFEvQ0JzS0VQaGNHSzBMRVhq?=
 =?utf-8?B?NnMvb1J5K0FWTHRRY1ZENks0MUx2SXFSbmE2eEpRZmxpeDB0MUtzWUkwbDFl?=
 =?utf-8?B?RXNTMjNnUzB2UEhiUlh0VEsrWDBId3N0RW01Mm9JNmlMbHJxNDh1QzV0aGRZ?=
 =?utf-8?B?eDlkaE5HbzFIT1pCdEpzaGRTTTFHYTY4Y0hFUTZCMjYyWkFSTG9ndmx2Q1dj?=
 =?utf-8?B?c0lTeUYrSzFaUnJVSXZCYnIyeitpcXlHanFlUGpVNmg5NFprYWtIdUhQeWxS?=
 =?utf-8?B?RTczK1M0L2V5bEQvRjJ3M0dDS2VueTR3ME9vSkpVS2UzOExVak90dVFUOEwr?=
 =?utf-8?B?bXprQ21DNVNYS1BUcXVsUUhuMjVSTzJrdlY4dEtYL1pCcU1FNGx2RVdVanZs?=
 =?utf-8?B?MGFuSW5oY25Ed1VkQ25nbWg5Nm9Vekd5QzlzRDZJMUZSZG13T1FwL2g0NXpt?=
 =?utf-8?B?aDJvYURwK0FWNXVndkxjelNwdTJLU01LZkdKS1pjelNIMHFWa3ZBQVZma0ZE?=
 =?utf-8?B?YmI0UFpjWWY3a3Bjcy90U2FFM2xpbDI1c05zR2RNVW1rOWRPK1J4ZWdNaUlV?=
 =?utf-8?B?Wm5RNk9Ub1JQd2Z2dmpCWkd4YlZxTm5rY01LbG5md2NoUU90VzJwbnJ6d283?=
 =?utf-8?B?OGhWQSsvUFZCSkJqZjhGcXVNY3hkSFFxZTVUQmIwZHBJNnJtcDNaSTJPUTJ5?=
 =?utf-8?B?YWE3WnhIZ3k5THJ3WE5IbEpEQXhKNVBhU1MyRklWLzUxdFhvU0UvZVlUV2ZS?=
 =?utf-8?B?bEFUQ1ZpSjZ0b2h3VCtKYk8zWlk3UDdHaXhZNHZYWWQ1b3ozeEwzaFRqaGZu?=
 =?utf-8?B?ak0vZG90WWpBTFg0enVqcll3eThrZlB1THgvVTVDSGdCWERhM0JxbE90ZFln?=
 =?utf-8?B?SEIzdFdGZ0lnMXN3MFYwTWhXOUJTSXZmVTZ5MGt6RUJLVHdtOVVPa2o3dXJ0?=
 =?utf-8?B?VHI0MEo5Tkt5MHd4cm9jUmRtSytYRTdiYW4yU3phZ0hBaTRNS1NiSVQzY1FR?=
 =?utf-8?B?T1NMRkFhOW9TNUs4TGVscVFGQ2VJbENYeFY0UnpVWFlqMFVlZlByeWxTMk5t?=
 =?utf-8?B?SEd4dWQwc1ZIQW9KQ0JFeVVsMVhzNDZreVp1VFBaclFSTmlJSnhZQWtnVXBo?=
 =?utf-8?B?ZlZ1Ujl6dlhSclA5RnlmN2tkeEYrUlBWdDBiYVhRb0JidEpwU08vVHdTSEk1?=
 =?utf-8?B?dVJ6NFBSUk9nV3JMVXU0RlcwNFhtMGpMNU9DRHpUTGdRbE9INm9EeW5LcWFv?=
 =?utf-8?B?WStQL1Q3RU5INGVyc0JFSXNOaENzYld3dURjZjRsRm9CSk4yVVlkQUpHQ2li?=
 =?utf-8?B?bVNXZ2I4a3pKT0FaaGNqaStxWGhCSk9jZGFsa1dPS1VFeDloelV2OXNsak9m?=
 =?utf-8?B?L3g1S0gvbHhQU2Z0cDAzOEJUM1kyMmdENTk4ZTJma2VBa0t1MkdocFA3aTc1?=
 =?utf-8?B?OXpKSGQ3U1M4RzdReFNIMEhzd2VUTldsSGZYUGZaRStscURialRmamdDZTYy?=
 =?utf-8?B?eS9vTGNSTmhwem1SclRWdWFlV1VESjY0aXB2UVlMb2cySVorVXVReXVFUlVY?=
 =?utf-8?B?ZDdrbWZsSWtmeHlLTnlCWXlXN0JhQzN6T0VmT2ozNUFRcVBSTmFaWjFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENBRXVCclJxMW82Y0diWGNRd1ptUWhmbmx5bUhvU3hSZyt3ZEFiN3psMms5?=
 =?utf-8?B?cVNKa2hWa0gxQUI5QWFNaVZYNFU0R2QwRnkzU3p2ZVZNa0VXa0crY2doaHRt?=
 =?utf-8?B?UEhsYjBaVnVsTzRnTVdIN2ZINWRvejAySjVldndFL3VodmF1cjlTeXR1N2lB?=
 =?utf-8?B?Z1JuazltVmVjUUNEUjZ2bXV3c3d6RjVOUXQvelNHWFpXS2tmT2EwMlUxUGJQ?=
 =?utf-8?B?NW5lSEU2eVIyelIzcWViRFgyVnpBSjB3cFBMU21IOGVaa2NCbDNGUjZQbjRX?=
 =?utf-8?B?TjRUV3krSGFkYzIycThweHdVeXZmYmRhbmU5TTM3Mm9YcHRuV3IyeVhrV29z?=
 =?utf-8?B?N1VlM0huelBFUXY2VlU2VU9KT3IrNG96SCtoT2NXb05YWStub2VIK0QzbHhU?=
 =?utf-8?B?MlJRZmM1alhiQmZmMnlUOGMxN3VaSTlkTnVsRXkzeGE2VERTZUJQUDZkcG5S?=
 =?utf-8?B?YXlKbU8yUnlXeGs2OXFiVm5DY1FzWXJoa05BaEY3dEtSekVMa1lDLzJIdUxB?=
 =?utf-8?B?b1JjQkFKand3ZG5yMHFjWmZabmxaQXc0NTNmdGUvQ09ra1RPbVFLOXVPZnJD?=
 =?utf-8?B?aU1FOU1GSGcxVEpnYTZXbWpnM0d3em5vT0d2N0hvdmNaS3hqTjJDZlp5eWRZ?=
 =?utf-8?B?VTdkanVGU0Z3OVNmeUFEbE1GSUFuMnd0Zk4yR0N3WU9McVFTZ1FISGVmTDRm?=
 =?utf-8?B?SStheFNsYUVxTVBLR29iVlMxaUx2bVFsOG43a0phVDlUa2Y4THB2Y1RKVXYv?=
 =?utf-8?B?b1lzeHpxZW15UnNyTFRFd2x2VkRzOTREQStOdDlEZlBzOHJETTJzblVaZ3lq?=
 =?utf-8?B?VUlZVk13Mk1YUVkyeFdnRUIzK2pRVDFJMGFkWkN0WmlHUUpwSGthZzFJb1R5?=
 =?utf-8?B?VUxqMUdyc3lTZ21zSDNlaW9jY1NpcjdYUWROSkk4aUlYMi9QM3NXZlJzeUlX?=
 =?utf-8?B?S1Bya09NeWZxMHk4eGdYcVdNbDNWdUJTa0ZXanpzdXUrT2JQMzk0ZDhYUG1P?=
 =?utf-8?B?QlZiVUlraE9LQVdVSzk5NE0wNmVOU2kvRThIeTNZT3RQQ1BBOFJDK2VEVHBt?=
 =?utf-8?B?ckllK1FsdnFQUGs5N3lKVTRsWWtMU3VuanRzRVlFK0xnTHFWWThsRjl4Ukc1?=
 =?utf-8?B?L2dEcU41U1FJbkZ1aHlwTUU2NmdZdjNXVTdKYlFzRnllSGQxYm1tdXByUjhY?=
 =?utf-8?B?ZkMrdVZZTHVrSHlwaGhtaE05bS9CRXBxVlpUQkNyUU9QU3VqV29VSkV5STQr?=
 =?utf-8?B?c3ZBRXJaYnJQNDNZdGNuNFR2clFwYTdSSXpkY3pLeVRTVHBRTVMzcVNXYkNQ?=
 =?utf-8?B?VkR3UnNYcXRtTjFRWDN4ckxVenhUYmw2TXZ6cnNRQWZmTmo1ZTdyTkhzb01v?=
 =?utf-8?B?M1JuK1FUMEwveDVxbCs1WExrV2NtZncxaEliVzBUUDg5eVo4NzE4dHBUTjNR?=
 =?utf-8?B?aStDT3d3UXRKZW52MDVZNlV5dTcyamVtOFBhVGZCNnlhbUhwTHBGRG5rZkRx?=
 =?utf-8?B?SkRLR2ljcTJHK3MwSVRRTEI4d0lNVmxudkE1R1Z4dDZndFVWb3dJa2gzUnZy?=
 =?utf-8?B?RTN6eFI0UzJ2b3V5OUI5VWZpVEJPWXgyK2lUN2xCQisvaUxjYXc1bHR6R0gy?=
 =?utf-8?B?WWZ6b29SbFdmMSsyV3VlYXA5MDcwdHIyTnA1REt0OTJMcEFqSUIxZExDdlZz?=
 =?utf-8?B?NDJ2MjVIaFhybmUvTnljTGIvdU93Z1c5clZ5MnUyVXlvTW1mc0V1bjhlMTJ3?=
 =?utf-8?B?d21Ibks0M05VTkNKMllMaEpjNUZQeEZ2S3NLTEZaWUVDdFYxVU5xUWxLdWg0?=
 =?utf-8?B?bXhKOFNDR2NOTVhTZG42V0huWHBrZG9FaXF3MmZnekFweW83R2FwYlVUSml2?=
 =?utf-8?B?b2haeVlqOGpoMzhUR2VEOGNyOXJNNVQ2WUYyZ2h0K2FCNjFYaFZidzNFZEpI?=
 =?utf-8?B?a0dXUFM0UytLSmNlaTk0YzVjZmRFUnBqSFFWNUIyaHJwdlB3bVJmcEdNQkkz?=
 =?utf-8?B?d2piS3FZandFb1gwS2NEa2hZSmU5aTZwYzhzdEd4T1JHOUlSbVhzSzBQcjlM?=
 =?utf-8?B?dTZKb0NwNFFhWXRjWjFPTW5jU2ZsaTlkUmlpWVpWVERvNkZJWExKZVNNMjdy?=
 =?utf-8?Q?tKtdfmXh1gomU2h+GfK3iWQJS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea92c917-4d8b-4f50-5d24-08dc764e1111
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 08:48:04.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zEjI87U6wkT33z5A99A2ZIl7KHtTRBX6/1/l5yKqXDXItY4StMKxfHpvZyRNxVkGRbO6DSGUR/JzJ4WVe/PIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477



On 2024/5/17 4:08 PM, Alexandre Belloni wrote:
> On 17/05/2024 15:53:58+0800, Joseph Jang wrote:
>>
>>
>> On 2024/5/17 3:19 PM, Alexandre Belloni wrote:
>>> On 16/05/2024 19:28:47-0700, Joseph Jang wrote:
>>>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>>>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>>>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>>>> code. This design may miss detecting real problems when the
>>>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>>>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>>>
>>>> In order to make rtctest more explicit and robust, we propose to use
>>>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>>>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>>>> ioctl interface, we will fallback to check the presence of "alarm" in
>>>> /proc/driver/rtc.
>>>>
>>>> The rtctest requires the read permission on /dev/rtc0. The rtctest will
>>>> be skipped if the /dev/rtc0 is not readable.
>>>>
>>>
>>> This change as to be separated. Also, I'm not sure what happened with
>>> https://lore.kernel.org/all/20230717175251.54390-1-atulpant.linux@gmail.com/
>>>
>>
>> I apply above patch and seems like still cannot detect the read
>> permission on /dev/rtc0. I guess the 'F_OK' just check the `/dev/rtc0`
>> was there.
>>
>> I share the error logs by following for your reference.
>>
>> TAP version 13
>> 1..1
>> # timeout set to 210
>> # selftests: rtc: rtctest
>> # TAP version 13
>> # 1..8
>> # # Starting 8 tests from 1 test cases.
>> # #  RUN           rtc.date_read ...
>> # # rtctest.c:53:date_read:Expected -1 (-1) != self->fd (-1)
>> # # date_read: Test terminated by assertion
>> # #          FAIL  rtc.date_read
>>
>> Not sure if we could skip the testing by following change ?
>>
>> FIXTURE_SETUP(rtc) {
>> +     if (access(rtc_file, R_OK) != 0)
>> +             SKIP(return, "Skipping test since cannot access %s, perhaps
>> miss sudo",
>> +                      rtc_file)
>> +
>>        self->fd = open(rtc_file, O_RDONLY);
>> }
>>
>> And I make sure we need root permission to access `/dev/rtc0`.
>>
> 
> There is no need to test for every tests of the suite, the check could
> be done once. To be clear, you don't need to be root to access the RTC,
> you need CAP_SYS_TIME and CAP_SYS_RESOURCE.
> 

Thank you so much ~ not sure if we could have the following change ?

Use `access(rtc_file, R_OK)` to check read permission on
`/dev/rtc0` in main(). And user could try to figure out why cannot
access rtc file by themselves.

@@ -430,5 +433,11 @@ int main(int argc, char **argv)
  		return 1;
  	}

+	// Run the test if rtc_file is valid
+	if (access(rtc_file, R_OK) == 0)
+		ret = test_harness_run(argc, argv);
+	else
+		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", 
rtc_file);
+
+	return ret;

>>
>>
>>>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>>>> as optional")
>>>>
>>>> Reviewed-by: Jeremy Szu <jszu@nvidia.com>
>>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
>>>> ---
>>>>    tools/testing/selftests/rtc/Makefile  |  2 +-
>>>>    tools/testing/selftests/rtc/rtctest.c | 72 +++++++++++++++++++--------
>>>>    2 files changed, 53 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
>>>> index 55198ecc04db..6e3a98fb24ba 100644
>>>> --- a/tools/testing/selftests/rtc/Makefile
>>>> +++ b/tools/testing/selftests/rtc/Makefile
>>>> @@ -1,5 +1,5 @@
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>> -CFLAGS += -O3 -Wl,-no-as-needed -Wall
>>>> +CFLAGS += -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include/
>>>>    LDLIBS += -lrt -lpthread -lm
>>>>    TEST_GEN_PROGS = rtctest
>>>> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
>>>> index 63ce02d1d5cc..aa47b17fbd1a 100644
>>>> --- a/tools/testing/selftests/rtc/rtctest.c
>>>> +++ b/tools/testing/selftests/rtc/rtctest.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <errno.h>
>>>>    #include <fcntl.h>
>>>>    #include <linux/rtc.h>
>>>> +#include <stdbool.h>
>>>>    #include <stdio.h>
>>>>    #include <stdlib.h>
>>>>    #include <sys/ioctl.h>
>>>> @@ -24,12 +25,17 @@
>>>>    #define READ_LOOP_SLEEP_MS 11
>>>>    static char *rtc_file = "/dev/rtc0";
>>>> +static char *rtc_procfs = "/proc/driver/rtc";
>>>>    FIXTURE(rtc) {
>>>>    	int fd;
>>>>    };
>>>>    FIXTURE_SETUP(rtc) {
>>>> +	if (access(rtc_file, R_OK) != 0)
>>>> +		SKIP(return, "Skipping test since cannot access %s, perhaps miss sudo",
>>>> +			 rtc_file);
>>>
>>>> +
>>>>    	self->fd = open(rtc_file, O_RDONLY);
>>>>    }
>>>> @@ -82,6 +88,36 @@ static void nanosleep_with_retries(long ns)
>>>>    	}
>>>>    }
>>>> +static bool is_rtc_alarm_supported(int fd)
>>>> +{
>>>> +	struct rtc_param param = { 0 };
>>>> +	int rc;
>>>> +	char buf[1024] = { 0 };
>>>> +
>>>> +	/* Validate kernel reflects unsupported RTC alarm state */
>>>> +	param.param = RTC_PARAM_FEATURES;
>>>> +	param.index = 0;
>>>> +	rc = ioctl(fd, RTC_PARAM_GET, &param);
>>>> +	if (rc < 0) {
>>>> +		/* Fallback to read rtc procfs */
>>>> +		fd = open(rtc_procfs, O_RDONLY);
>>>
>>> I think I was clear on the previous thread, no new users of the procfs
>>> interface. You can carry this n your own tree but that can't be
>>> upstream.
>>>
>>
>> Okay ~ If we use RTC_PARAM_GET ioctl to detect rtc feature only, not
>> sure if that is okay for upstream ?
> 
> Yes, using RTC_PARAM_GET is ok but I'm pretty sure this is not solving
> you are seeing following the efi patch you are pointing to.
> 
> The patch clears RTC_FEATURE_ALARM when the alarm is not present which
> will ensure the ioctl fails and so the test will already be skipped. My
> guess is that your ssue ias actually when the alarm is present and the
> test will run and wait forever for an interrupt that will never come.
> 
> 

Thanks for helping to review our test again. Our original intention was
to check whether miss the efi kernel patch on target testing kernel.

I verified it and make sure we still could use RTC_PARAM_GET for our
testing on new kernel (> 5.16). If the target testing kernel miss the
efi patch, rtctest could detect the RTC_FEATURE_ALARM was enabled and
the RTC_WKALM_SET will report error due to efi.set_wakeup_time() return
EFI_UNSUPPORTED (3).

	rc = ioctl(self->fd, RTC_WKALM_SET, &alarm);
	ASSERT_NE(-1, rc);

And if the efi patch has been applied and it clears RTC_FEATURE_ALARM,
we could use the RTC_PARAM_GET to know rtc feature was disabled. So the
rtctest will skip the testing without reporting errors. That behavior is
what we expect.

Not sure if that work for you ?

Thank you,
Joseph.


