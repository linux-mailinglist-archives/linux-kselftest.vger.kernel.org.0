Return-Path: <linux-kselftest+bounces-9549-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7488BD495
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 20:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220ED2846B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6C158D7B;
	Mon,  6 May 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibozrGuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BB8158D6D;
	Mon,  6 May 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715020193; cv=fail; b=oihr2uqMBO+4unrkikNXXH79cXQHIdzZjNmwhDRLbvKHmaGkbKCtMTVkJ2fk5bi1beQIIf0GHOn8rsv0A0gymB/l4zz4/PV1/IsaR6UGLdUV5071u4DwPfikR8Dph3+gho4rLXVm/QsQynJzQo8J8l4Q1w6ZO8irCohGmyrk68Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715020193; c=relaxed/simple;
	bh=TpqhSqrrhh0dRcR4ha5WZNsrUavrqEwWqOlUp8X7Viw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XOsRrfktk4JK1+VntUjmV2paVCQlYhGHVih6EJSBcPj/u1QK29vk+TPSU94aEV4w0V2m/4Zd11koafm7bm3giDVIcY0qGXMBPpS/iB2gnLTt7mkQsiZdmk+bnV2+rezmZhs5n0OsPYykNqXmsuQn39ijqJ2xtWUFbMD/e63b7JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibozrGuk; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niXsNyW1HnR8U5/VvfXQLrP1O0CVEJMstPOmTKT+Q8l+E9FUHzEtQ3Au9iaZg7ZiaG7FrmNGFt/vSPYbpXVjklJgX0fdx2XTqWNajGT9YlBuDfltwqm6m56fujW66qrW3hu39UOQT5697+8jqoCPG41uxoBJ7uBniydHEYqQy+faAEv//i0cl/3yhryAviYHMnLnO1y3YsjFtL6xL+RPFDT4UaWFM5qUxRySx/CNSQyQweEqtEAvN72s3iSLglVGn0xqInssD8mT4lj8kd0xebJp0cNa5LPhq52+M8Yo3NAQSW5/wQf4D3VOzhU7s5kg/5EeBwVguExNBpDY4g+Wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/u4hY935hJIwxdqw9TeO2KOJWhG/kbsIbNV0pSzxPU=;
 b=P2e+vvzYOB5WcL66TByWnNUKcQbGlm0ZCUzjjSWpjrGyaCcTi2xmCFlHrsGpAbhSEIjRy9JGI6gnsQEaD24FhoOKTaVTlQAWogM0XPlQknXQGTnEpIMAKAAS2Z5nhctFsrPfyjvuQXouyR6FoswcykrvGHDFl0vT/xoDT0LbcT5UV7bMmZojrBhhDUu6djNiPtBWEnqM6PGSWQaUywh0P8jY1Sjd8g4dk485z62iee3+V2NJ4WosqucBZ8H3Dfmn7vRUbgwOo0SlZDjx4sFHInKhuTFT9jdCzhJtq6wFRQDVavxlw+msAxM4H6CCKaVk+oRVEYTbj/j8CY/SL2yiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/u4hY935hJIwxdqw9TeO2KOJWhG/kbsIbNV0pSzxPU=;
 b=ibozrGuk2+ixyS7cNmN3X9RBysGMgksC+eoX/QbwBHMh53A1zCpwUguU67UIjRxTyEbiAshPNte+GSy/W1GKNzwUP+dVTf3REWNdC9dmp2iS52hfnr2HdESf83OxT1O3RMysd94wqkbheMV9KBy/egQY27C/VUdgTBoxezvEgOTxvxhHHrkzwbfKxFDfJC5OF02ugJ/miT+IV3cdnLebRhntP819uLinQ1cu3GT6ftF74VAMc56LWA2nkNP3GQ98FutgTVIZGcTNBlVS/Tcqt6EMUY2KNgPXL+pzCCEqwFlts30+WicYyb16f/ji6kC9WSagCyifG4yUL811xzb66g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 18:29:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 18:29:46 +0000
Message-ID: <b20d43d6-8d01-480c-af1d-90c0acd35d5c@nvidia.com>
Date: Mon, 6 May 2024 11:29:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/netfilter: return a value for several "int"
 functions
To: Felix Huettner <felix.huettner@mail.schwarz>
Cc: Shuah Khan <shuah@kernel.org>, Phil Sutter <phil@nwl.cc>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Max Lamprecht <max.lamprecht@mail.schwarz>,
 Luca Czesla <luca.czesla@mail.schwarz>, Xin Long <lucien.xin@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>,
 Richard Guy Briggs <rgb@redhat.com>,
 Boris Sukholitko <boris.sukholitko@broadcom.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505214716.62304-1-jhubbard@nvidia.com>
 <20240505214716.62304-2-jhubbard@nvidia.com>
 <ZjjsGW314qCgpTKs@felix.runs.onstackit.cloud>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZjjsGW314qCgpTKs@felix.runs.onstackit.cloud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f365ad-1c64-453d-5af2-08dc6dfa81d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djF2cU80c3VRdGdnU1B6UHdrZ3J2RXdTSm1zcHNucGhsQUFuRkt1TDkxSVUy?=
 =?utf-8?B?QzlaTEw2Z01hbVhTQ0d1amZMOW5hc0ltUlQ5aGVuT1d3aGVIcGk4Uk5vNnhl?=
 =?utf-8?B?b0NLMEc5VU1SSy9kcnZOd1FDdy9rOExMM1RDRUhqUjEyRjJNY1d1TEoyZnVu?=
 =?utf-8?B?YjJpR2xOY0dpWXRpWnBrdGV4UTZlVG5FeUtQOTh0cVB1Mll6RXZZTTlySThB?=
 =?utf-8?B?ZTI2bTczU1MyQVp3TVhuZzQ5RXJ0ZUJJNGprSEppbDVMQWV6WG9mRFpEWlc0?=
 =?utf-8?B?TllZb2NQU2UzNEZkUVVtbGxvVjgwd01OVVFncEhnMDRwZ2pHM1BZcitOZGhE?=
 =?utf-8?B?Z0FXdkI3MTh5L0dHM2hLVkZ0TlNkaEVpcDBHTy8wU04ya3A1c2xFamVjcTRX?=
 =?utf-8?B?M3JGN3NLaE9BbTh4ZkoyS2RuSGN6QWp3em90b0J1WGgyVUpDYkY5eTIwM1Jt?=
 =?utf-8?B?eS9uVHFQYWhCamNKRm5kK0drdnl1YnRlRUoyWFVCN1h4QUxkSmFYdWZucHpJ?=
 =?utf-8?B?UEdNdTZBVkFQU1BRK2EwOEdwbHVFOVVqM3czM0J4UFNSOFlFS0RpUXVDejlu?=
 =?utf-8?B?Q0ZKazdsRVpYZ3QxQW1tRmQ1T3A0UVVPbWJ3a2NGKzRpN1pKeElVUXVmbDNk?=
 =?utf-8?B?akFnMStHL2trTUl1OUp0WW5YTkF4WjFGNDhCSkFUZzF0YnlGVEdVUUNUYk9t?=
 =?utf-8?B?cnI0cEpLc3ZqUG9LU1cwbzVob3kxQU9ZUElaMlpSMjF3MG5RL245NWxBN1M0?=
 =?utf-8?B?bmxSTjlqT0t5dXBiRk5YdDBMVVVTeHFmdjNiQktpSjhEdlNxM1Y5cHlEWTh5?=
 =?utf-8?B?ZUpWVmphbVFNVktlQWFCbU4xdkQ0d2lsdVdZN1N5RmE2dGd2NDBnbTJ1ZVlB?=
 =?utf-8?B?WW5WMHJUem53Uzh3UDRtampBM0dXSDVTVERqZ2tVRTY1SG9vdVUxekR0TEho?=
 =?utf-8?B?RmlyMm5NcnYraEJjN2h2SEpMZnRwVGszU0M0MlhoTkN6SjM5V1Axdnkzem0w?=
 =?utf-8?B?dGVRUXBzZzljMFdIU0lCb2s5b1NNQkJyNGxEY2JlSXJHNXJBODB0ZVlxMVZW?=
 =?utf-8?B?aTBmbXdiS3RkL3paRjBRbERyTW9IdHhkRll5aXJPTjFZR1FzampFb3NUNU9C?=
 =?utf-8?B?cndESnJ1YjlBZXhZRStQWmJ2bER5TDR1bk42MVpINVNKSFRMQ3FjYXQ2K0Nk?=
 =?utf-8?B?ekRaSStqb04wQkF1cG11VXYrcmkxeEgrRXVDazczWGJVVWxvQjlKU0VWdDFP?=
 =?utf-8?B?NGhNTWQyQWsrdnlxSnlDM0F3TWYydXNXdTZMbWdjVkt1MkF1cHFUcFh2MWcr?=
 =?utf-8?B?b0xybHdDTldreUZWQ3FCemRMNFZMcllwVEZJdXc2bGhvUm1JaThzTmsvbm5m?=
 =?utf-8?B?WTdFSjg5MysxVitLYU01d2dTTG1HWUsvSXdJZlR6TmdrdzZibCtCS3JQLzhw?=
 =?utf-8?B?VFY4SVNNWlRnaXZUZnVlaGJzQ1FhajRpbGhqRlV4cXNDbGxXaXpMMEdhSk9J?=
 =?utf-8?B?bjF5elY1OTBubUt1SXdQbklpZUNTNUNnYkoxWWxhNkc0ajU1N2F0VTZvWVZM?=
 =?utf-8?B?WUpRY1hraUw5L2kwd2xCQWQveWNOUGE0blJYb1pyM3BGZERDTm1vaWhJOVNs?=
 =?utf-8?B?L0pPWTVISjZuWFNLQzFKdG44SzRoUXRuMUxLdUtqZHFnSzFZWFI4blpVUTQ5?=
 =?utf-8?B?YWJYaFM5c1pyZCtodkl2bW9RaTZuVnFsMTRTNkZkRm1QOHhvekhjbGJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHBwVTNKN1NSZjBCRnNxMURkUllvblV0c2RhNnVJOS9mVlljS1ZPYUd1a2tl?=
 =?utf-8?B?SnJDWmRwTitkZERGdGVBNnBYL2prRzBIYjhldjk5NlhjR2ZuTmUzZFcxRCtn?=
 =?utf-8?B?SmdvK2VLNVRVa0dXTUE3MW01RnIxRU9ZM3RuVHRZODdEQThmZ3hxYlpZZVFT?=
 =?utf-8?B?VVFFOHRSWDdaeGcxYWs3Rzhwcm90U1V3UHhLN3VPUUdGM2I1NkFqRWgvcWI5?=
 =?utf-8?B?d003bnNXRG4yOFErS1lsSUp0dFIzbUtkVTJPSHNpaUg3THlvbWwzTHlNcmVQ?=
 =?utf-8?B?UDVLdlBZMzJTdEEwUjFWMi9BZDJLRThxWXRnczYyUTZ4U3ZtVnhqcVF5YnNP?=
 =?utf-8?B?aHNBS3B4bUU5TlVLODFsVmhrV3l4cjJ1aUJSTUVHdmp0Rnd4b2RzYmRwRW5j?=
 =?utf-8?B?TTJRVWV0a3NUL0lPNTB5TEQ3Y09zdkFOcmRmZ2IzOVMya2tXVDZqamtKaHM1?=
 =?utf-8?B?eHF1aXJ6Qlp3R212U2FNdk5ta0dtYjE2dnovejdoRWpBaGxSWUI5WFo1TGE3?=
 =?utf-8?B?SXJxaUhIdHdCWHkxOVVCL0pNb0VQQm12MzBKMFlLNkZCbFhzVHc0QVNqc3dN?=
 =?utf-8?B?OXh2cmJYakQwM3EyRTZQbUFmU1JQNE1YMXZYTXVpQ0FzcjcyMlgrUkZrUTZX?=
 =?utf-8?B?UGdSOFVGRXJSZkFIOHBEdktzR1lsMmRLcnFhU0ZKUExxNmJnV2JFMWxveWFh?=
 =?utf-8?B?SE9HTDVTUk9TNmxBVnRocVlVRHRrbDV1MWVwZG5NRkRNSEhSU1ZITU41QlBk?=
 =?utf-8?B?cXFsdWl0WXFJNHFwRWptQTJHSGFrUFMzdWJrQS9ZNzhmQzBtQ255U3U1U1R4?=
 =?utf-8?B?d2hqZ2ZrTFVlQzFRb3FFYnBLOUVDMU1PMVhnZFE2VVdTbHNYUzQyNXBEVDY1?=
 =?utf-8?B?Z2p3RTZOaGxPcUpFSG9uc1ZpcnV6M2hCdm15UTltZGVLcytBcHdZalhSZ1F0?=
 =?utf-8?B?NDIwN3gxU1JEVWhYdGhjTGMvMHV6RGE4OFJtY2JCV0RzU0kxTUsrcnkveW1x?=
 =?utf-8?B?MmxkL3Q5clIyK29vdDZkalRidWg4ZnpiT3F6UVFVZHo3MzArZTR3QTJVNTZL?=
 =?utf-8?B?TVpKY25tVWxyU1lVb3hrdGlXTXZSQXZYbWRBb0FFZUw3ZTZ0bWdoWGszdzVl?=
 =?utf-8?B?SCtOLzJYaGJuNCtSTHBOSTBVamVwM0xjeGRBU3BrTUw3UDU3ZU5FNlo3c0hH?=
 =?utf-8?B?TW0xY3l2d092VkMxSW1ETkF6c0JXR2lidTBoQlFSVXZGKzBMMEZrL1RaYk53?=
 =?utf-8?B?T1VxQmhENTFSQmlkeEp1cHpjZnV4YVZablNLWndaUG0yUjJISTBOTnhuUWh2?=
 =?utf-8?B?ZnYySXJRWUpVYXlGbjl6OVFqTkY2a0FRZUxZMEFSZmdwUWhRWUt6NThpd0h0?=
 =?utf-8?B?THNDa0JqbER3UXZuNzhnRWtmRnJnMnBVM2EwYmxXUWpLNlE2TEtkYksxN1NG?=
 =?utf-8?B?V2VNUjY3ZlJaMVcyb3hRa2duTHZrcjQrRXZPMG1PVmZxbC95Vm4vcjdaVUUy?=
 =?utf-8?B?RzFFQlNIZE1uS2tnL0Z1VHUzbHk1ZlBCN0hQa3VHdjVVeWhhUUJWTzl1a2Ny?=
 =?utf-8?B?dXVtSm16cm8rQzRsd1pKcXNqNUFRYlVHUHp2TTZad2ZwYzF5WUNuUkpLM3B3?=
 =?utf-8?B?YXZSa0pFR3RZTWZIeXhKaGhmUzB1dGpPTEZ6aWozNE9xaHVZY2JjaktJajV3?=
 =?utf-8?B?MWtrRXlmblJlYzZqUzJiYTkwbWZrNUpCWTYrNGVVL3JUd0g5Uk1KdlNhdVUw?=
 =?utf-8?B?RWxUNmlhSkZ2dnRVWU5xSVdKbUszbVBQMlZLbzdOa1Z6OWNuL0ZadTdDL2Ex?=
 =?utf-8?B?UWVPaEtYRmljUzMraTBXRUJ4R0R4NWZsZ3IrN1BhcXpaUW41ZmFzQmd4dVd6?=
 =?utf-8?B?WWZyT28xeVc2VHBRSFMyN3lyU2pGZlpvMm5yOHgwK29uQ0FGZzI2SGNFT3dl?=
 =?utf-8?B?TUdtbjlHTHU5YSttZjVrbVZLbkNTYjFERWlqdFowY3J5TTVPaDR5NUlRR0RM?=
 =?utf-8?B?V1FxdVMzcE5SMFd5b2Uvc2Mwci90dllxOVhFYTl0N204ZDVFMytVMHFVZW41?=
 =?utf-8?B?MEVvQ0xBVVlFSjljRGR2WHRMcFV1VElkOVBpRU5TcUZaWVNBT2hDRmc5VWFm?=
 =?utf-8?B?cGY4UitVWmVRUDRvWTBXME1OSTZRdkN1SzBON0pjS3dDY0NBbk9CTXBPVXVs?=
 =?utf-8?Q?1D7ogjlmLDKo5/1ir4fuaM0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f365ad-1c64-453d-5af2-08dc6dfa81d1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 18:29:46.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+FkiTWesRiZbgjS2z3y/OWMohOoeaMUhVb3YG9uDyx6zh6eqUNpS8Cb4hohQhhFdZoSt+LUf8k9OI8XUocCqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276

On 5/6/24 7:41 AM, Felix Huettner wrote:
> On Sun, May 05, 2024 at 02:47:16PM -0700, John Hubbard wrote:
...
>  > @@ -207,6 +210,7 @@ static int conntrack_data_generate_v6(struct 
> mnl_socket *sock,
>  >  static int count_entries(const struct nlmsghdr *nlh, void *data)
>  >  {
>  >         reply_counter++;
>  > +       return 0;
> 
> Hi John,
> 
> This will need to return MNL_CB_OK.
> Otherwise mnl_cb_run below will abort early and the connection count
> will be wrong.
> 

Thanks for catching that, I'm sending a v2 with that fix.

I was thinking about it, and expected that the pre-existing code
appeared to work because the return value was some non-zero garbage
value scrounged off of the stack (or %rax, for example on x86).

However, just a quick test showed that *any* value (O, 1==MNL_CB_OK,
or no value at all) allows the test to report success...oh, I see,
it's reporting PASSED when it really ought to say SKIPPED:

$ ./conntrack_dump_flush
TAP version 13
1..3
# Starting 3 tests from 1 test cases.
#  RUN           conntrack_dump_flush.test_dump_by_zone ...
mnl_socket_open: Protocol not supported
#            OK  conntrack_dump_flush.test_dump_by_zone
ok 1 conntrack_dump_flush.test_dump_by_zone
#  RUN           conntrack_dump_flush.test_flush_by_zone ...
mnl_socket_open: Protocol not supported
#            OK  conntrack_dump_flush.test_flush_by_zone
ok 2 conntrack_dump_flush.test_flush_by_zone
#  RUN           conntrack_dump_flush.test_flush_by_zone_default ...
mnl_socket_open: Protocol not supported
#            OK  conntrack_dump_flush.test_flush_by_zone_default
ok 3 conntrack_dump_flush.test_flush_by_zone_default
# PASSED: 3 / 3 tests passed.
# Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

As long as we are looking at this, what do you think about
this:

diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c 
b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index e9df4ae14e16..4a73afad4de4 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -317,12 +317,12 @@ FIXTURE_SETUP(conntrack_dump_flush)
         self->sock = mnl_socket_open(NETLINK_NETFILTER);
         if (!self->sock) {
                 perror("mnl_socket_open");
-               exit(EXIT_FAILURE);
+               SKIP(exit(EXIT_FAILURE), "mnl_socket_open() failed");
         }

         if (mnl_socket_bind(self->sock, 0, MNL_SOCKET_AUTOPID) < 0) {
                 perror("mnl_socket_bind");
-               exit(EXIT_FAILURE);
+               SKIP(exit(EXIT_FAILURE), "mnl_socket_bind() failed");
         }

         ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);

...which changes the above output, to:

$  ./conntrack_dump_flush
TAP version 13
1..3
# Starting 3 tests from 1 test cases.
#  RUN           conntrack_dump_flush.test_dump_by_zone ...
mnl_socket_open: Protocol not supported
#      SKIP      mnl_socket_open() failed
#            OK  conntrack_dump_flush.test_dump_by_zone
ok 1 conntrack_dump_flush.test_dump_by_zone # SKIP mnl_socket_open() failed
#  RUN           conntrack_dump_flush.test_flush_by_zone ...
mnl_socket_open: Protocol not supported
#      SKIP      mnl_socket_open() failed
#            OK  conntrack_dump_flush.test_flush_by_zone
ok 2 conntrack_dump_flush.test_flush_by_zone # SKIP mnl_socket_open() failed
#  RUN           conntrack_dump_flush.test_flush_by_zone_default ...
mnl_socket_open: Protocol not supported
#      SKIP      mnl_socket_open() failed
#            OK  conntrack_dump_flush.test_flush_by_zone_default
ok 3 conntrack_dump_flush.test_flush_by_zone_default # SKIP 
mnl_socket_open() failed
# PASSED: 3 / 3 tests passed.
# Totals: pass:0 fail:0 xfail:0 xpass:0 skip:3 error:0

?

thanks,
-- 
John Hubbard
NVIDIA


