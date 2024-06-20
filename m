Return-Path: <linux-kselftest+bounces-12359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6069111E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 21:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A326828164E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 19:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E641B9AAD;
	Thu, 20 Jun 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PCNEuYR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56C1B143E;
	Thu, 20 Jun 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910723; cv=fail; b=Rt1R21Rlv8ihT1XjHq6CajyieNzsAtIG9fUAEzscWAF2ItlAxmZZJHYlmEVnd5D64vWdirT4MrjFuAiC5yHnfHeSx/UtiUs111XNEQ/S5e4j5VNpbqahrWKRBI0Ce6fBJfSPZsJe6IIRZVcq11lc4vXNxPDooU0R+aQ9CdYgaL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910723; c=relaxed/simple;
	bh=fx5LSGJUutx/eycDlKM7YLL+YSYod6QGpuXTi34U3H0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H+nnC5t5MBLuxDwWK6awZEzwEu3O1pVePK6FABtec0LzwPMSsqQkD3MZ2qkW0q6yBTkEr7dv6y+S3H55DRK4GlsBLsLXmXHSrCiFbdVJQfkIJHtRv8X7sEMhsZroj2Q5TcsyF5cR+fA01sEB3b7mZPIccf3e5b6VTjED4fQHb/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PCNEuYR2; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfNaAnpCxUZHom/LvLKm2V+XJ9dIS87jKAkbPyl0lWYjvJSUxYyjFPbqNqDty3QMTeJjEMK3VpFRDy1ybTiQbderNGLZGMG89zosl8b7F0m99kS+2bIFfIIc4TmRIgr70/SbHNhAHtyETVENyKHa/UQ1VDsqGNBwie/aXc5i1LfDalL6LOulCEeZi0aRYvEOqY6k+Q0oBt2Hy71ihi24U0KovYbOG7EEMp8gvYZU3uB5M+u2sowZpktdSau1p87gZ0a7zYOJKJIWDg2I958A7pbumdCPt2lBKowuB2O4MqDjx9xMJfpRN1j0dmzdxvA+yAsJbh+FDMJb0+fl2YnEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulmO669s7AXqEAwNjaUHekaPhxM6t2cFXMWNI1ijEss=;
 b=cZJB7hLST6g/P013+Br1rqy6PxgXkS8xZqo9iLGrM2TWFYWDIccUyOoPabodDFbk0vX7vmREiYFbatDxwDBD2WyZ9NgqqfDLQF2N2WxUAaITxT27eMujjxFMmLVWpdOSN0LXbKdmEJv3MFhc/sk+Mwnuc4noouEU7JFEUxoPMfrO4ziSYlIqlwOyELFNIE3mGkb/k6mN07TgO/MMGDa08IWYdwIGHPfsEXbvkDqQbuGB+uyEaZk1YVcNW9uLhRohselOEyuG0bnHtjBtlV2wNQ3UhV630BC/oHVnuCM5f0RqpKQeWo4+3G02vxSlfNoxV5Ib4ZqYfFRB1z/JeFS90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulmO669s7AXqEAwNjaUHekaPhxM6t2cFXMWNI1ijEss=;
 b=PCNEuYR24Wm88FyLGUaCoSbaHKjZsvQEBIu2nWE0PHASlVJEs6ILs+rL7NiGjvxol+eKg8ufy0/BPNIbpbwMsWEh63tqxl9dDM5c/t6lTaW+OStS6nOKyT44GYfAmlvVAInO+qfVPinH3g3izuvsaceIZfG01iMF4Ek/my4UnUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 19:11:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 19:11:56 +0000
Message-ID: <e7e90e69-36ab-45f6-ac7d-2295c4cfbccf@amd.com>
Date: Thu, 20 Jun 2024 14:11:53 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v3 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
To: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <cover.1717626661.git.babu.moger@amd.com>
 <24ac6e8dba1b42aec8c33bd3c26f58344dad34f1.1717626661.git.babu.moger@amd.com>
 <5b9588f7-9bd9-4fff-b363-099160ca657c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5b9588f7-9bd9-4fff-b363-099160ca657c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0014.prod.exchangelabs.com (2603:10b6:805:b6::27)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 553a2891-6b73-4785-b7eb-08dc915cda1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3A2V0ZvRWVNK1d3TFl0eVFaNUlVYTZrUEZHd1hYb0wxRmtIY01pK1l6VGVE?=
 =?utf-8?B?TTY3VHFkNFJ2aDBHRjdoaG9rcDluWkZJWHFPU25TQzFTeGRkTGlIb2pHTlda?=
 =?utf-8?B?cmNQVXV0bzdwVzhpdVN1UTZPOW1ERmpjalFUdEUvazBsTjZFbzl6anZxU05T?=
 =?utf-8?B?RTJ6eEcxZUZhTC90anJySWh0YnRVOVd6KzlFd29aNnpKamtrRmkxOGRVeVVn?=
 =?utf-8?B?Y3dmT1NQdTNRNlBnRk5IVjFLY0c3UkUrMUxnS3hUZ283cWRLUDRQY2dwbUpy?=
 =?utf-8?B?UDRGbjMxYkNYREV4WVdQZ2cramhZV0h3dTlPQ21WSWhZNzdIQTQzVEpDU3g4?=
 =?utf-8?B?ODNlZXVxS1pGU1hNcVQ5U0JpK0xUbCt2bG9kbzZEVHR5eE0vcWFicnJFekJq?=
 =?utf-8?B?empCek1JR0pxblpjUEZaVnlaelFQVi9mUVo5Tld6RmVrbkhES0JBUEFyZEI0?=
 =?utf-8?B?UFpPMzY4UGVicncvb2kvNlo1b0lmV2h2K2E5SnFmeVNDcU4zczdCK0NSSGdo?=
 =?utf-8?B?UHBoODdBRzhMLy9UU1grd211MDUrZm91WldISWR0YmR6cStrd1dsZFlCYmZY?=
 =?utf-8?B?cWZNYXZtNTR2RDdqdzBFbnNnaXo2Ryt2VnhvaGY5Rmsvb09Ka09lRGJmZloy?=
 =?utf-8?B?Uy96WG9KTU5TdkpsQzNta1lreVNYZ2JwVkIzZUlFM090RnZ2bjhONVB2VmZv?=
 =?utf-8?B?RTlaK3U4ZU40VlVKNzNlVkJCVmViR3ZJL3VFeHRQZGdjbDBHUE9XbmVYbUR0?=
 =?utf-8?B?TDlUWUlBQmJpK0MySnowcmEzQy9KaUkwTXZqT1M5dlY4UTl0bTdkMUF1eUJY?=
 =?utf-8?B?VDZlYWErUjZVZTJFa0liUFhmV3ZzODJFSVE0bFYwenNwMmtqRTVsNFNZQ2cv?=
 =?utf-8?B?TTJ2aDB2Vm12bnBvRm8zU010Mnp5R1puR0hqNFd0bllkTENUcGE3bDFzUUpU?=
 =?utf-8?B?STdWK0Jpckc3M3VCaEN2ZE9GckhLdkErNGxGTHhpbWZIVWsrVFV1MEpJUHVm?=
 =?utf-8?B?RXd0MzlxT3BXSzU3T2I0T1EwMDBDaWpxSzJPRCtOT3NrZlNBNUVscEF0Ni9S?=
 =?utf-8?B?b3pLT1oxUU96S0c0UXcybTVGSWpXL0MrY2tJREVnb2l4VjdoRVdoM3FUalgz?=
 =?utf-8?B?Z24wTDdmTElJM25xeDRBQjRJUEE5NVk5QVZWcGI3TVFJRDhTUkt3NWt5SWlq?=
 =?utf-8?B?Wi9xc1I4SjJvMVNydy92d25PcTFQR2EyY1hZaE5XTlF6VnhrcXo2bGZCYjAv?=
 =?utf-8?B?a2xQZXRITHB6OVRoUU9Ib2hJK3JFSEhRUTJVQVM0SWVLSitsZ1VWYlZQK1pz?=
 =?utf-8?B?Q2NoUTFVRUQvUVQ5SEliRitJTzkwbDhDUnFaTFNISjZuTWVOU0tyK2Nma3Ix?=
 =?utf-8?B?UXB2aDRUT2g4OXZ0U05ablY2UVNDTURUR2EyTG1kdU1mSEROWDd5STkrcW8z?=
 =?utf-8?B?bEtTNXJCaWhsNXgzNGhxU2VsWFgxVkVCNzB1SDRTUk5oeWMzTWhQNzlNS0t3?=
 =?utf-8?B?QmpDSzNsN0gvREdiRE1PWmtoQWlwY0RKS3QvbXAyLzFSSzh0VkJpcGNkSjFr?=
 =?utf-8?B?N1Q0VXdEOFJ3OVQ1L1Q1YTRxUUtxL01XUGgrNXg0MjVHcFZtSmtrSzl6M0Jt?=
 =?utf-8?B?bWk0ekJ0UEUrTnNKUmZHelhQUzFhYVRxN1JaUUVEbWo4MFJBVTlDa3MwaHl4?=
 =?utf-8?B?SFJYdWZEWjI1Ykw3NnFnZGs5OUQ4S1ZmRTFyajlldFFESGhJODFobWc2ZkxJ?=
 =?utf-8?Q?GLNObiW403RdRNo9Zw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmNtT211WWhyc0xiT2s4SXptTjlBWlFVd2piMHRKclNLZ2UyeHFzSnpiMUxw?=
 =?utf-8?B?dzk1VENTNnU2ZTZPcVFWeCtaRndPQjVkaFV3US9FM0VXVTRjaGpwNWpPaFRD?=
 =?utf-8?B?NGRPS0luSVlEc3ZTSGc1RjQ1LytmWWl0aDRWaHYxQ1grMHJTa2JLejBKamNE?=
 =?utf-8?B?TmoxOGtzMC9VVkFFWU1oQUllVlpTU1dXeEVKeU1nYjZ6Ulc0UWhhM3VhU1pw?=
 =?utf-8?B?emdkb0VzaVQvZklRVzQxaHhPM2xkUmFLcUFxTk45TjNMaHFGdFdjbXVrMlVV?=
 =?utf-8?B?OTVWeWVyQ2M3UFFoeXpvY3RPREp0SndMQ3JReWlEbmJ6ZnZkVFk4N0pjOWRY?=
 =?utf-8?B?R3hMOElQUWhwZDFvaUhFYWJVb3YwYkpHZGd1WEp3WjJuT1JqTFJKaHUzYXpH?=
 =?utf-8?B?VHZPZ3NUZHE1UkRpUUQvRE9Ca1RxSWNsbmx4ZHpnK1NaY2ExeVBTZXNRTEVu?=
 =?utf-8?B?d1AyWE9odDdJL09QTXA5NklZR25QUENlOHdiY3FSb1M0eEhZdm1ZYldnNVR1?=
 =?utf-8?B?aGk4ZzVYaVdUZ3Y2akp2K01ZYnQ1S3BwUzNYaUE0aE42VGJjckowK0JnYTh0?=
 =?utf-8?B?c2ZyVXlRc1VGaTk0OVYrUC82c0dyWng2Z3FoSUIxdGRMSGxnamdRSnZCQnIr?=
 =?utf-8?B?ZFFsN2tXbXo3K1RmTzZNS1BLR0RVZWVOTXFXR201LzJ1bitoNUNLcEgvSVF6?=
 =?utf-8?B?eXZ0RGRpdG1IQzk4WlpxRHlIKzloQzNLTmp1Q2drYlZ0YVMyYWRNUW1WNmdX?=
 =?utf-8?B?TDJkci8reWwrN051R0pEd216bmpCSkNOZ01UTDRvSmp4VW5ZVjJGZ2docEIz?=
 =?utf-8?B?OXBJT2pBRE12RjZURDlLTlAzRVQ5akx5MGF5V1F1LythMDRGQzRXOE91emdq?=
 =?utf-8?B?N1VqVU45YmxBQjNwLzNPd3hLUXN2dWt0dmwxaE95VUt6UzAvcEhoTjlGalpB?=
 =?utf-8?B?ekluQk5jZEZSUE9pcll2eTd6MGd4cnJqU3ZVVm1FUFhTNFBneEJHRG50ZUtj?=
 =?utf-8?B?bjVCdVVxRnRKeWordlBLb2JWcHFJdVVJYUR0WUpIMzJwYmFmdDc3bzFISkhi?=
 =?utf-8?B?NHloVi9JWm0zOU1TelF6ZWpBZ1FRbHpjb0hlVjN3QWZyTThWV3RkZzRJcUxZ?=
 =?utf-8?B?SXI4d0IyVmxkSnhjdllodFBvbVBzaUxRKy82aElLNlEvS2k1dVNYK1NROEs2?=
 =?utf-8?B?TDFWTDRUUzRQZ1dLY1VjYld1b2NVb0hBREVJR01XOWlPNWJNZitMYlpMRTdo?=
 =?utf-8?B?ZEVYTjNsb09zRTRoUGFvbnl2L2VISlR6M2VTMUJKeGRCdWk4Yk93MnBPaVdK?=
 =?utf-8?B?M0lPdklRaHlaWktrZVdjK1pmYVR0bU5QM05HamNoZVdlKzRFZjVXTTU2VFAv?=
 =?utf-8?B?azFlN2JiRHNYMThVWjcrRlZmS0ljcnFOb3ZSbWJ1SFNiRjBUZmluU0NjU3pE?=
 =?utf-8?B?TmZYelI4dTQvVS84MStWVzhQY3F0eUlaeWFBMEkrL2R1MDZaZWVoSnk1Lzlm?=
 =?utf-8?B?UDlHcUcrcHloNzlNTTJnNXhDVkJUSjVrOW41UTFRL2dvUnJMK05HWjM1LzRD?=
 =?utf-8?B?Z21HTWVUY3d1RkVtNENpak1QdVJRZHYvSzQ5VjZrM0oxOHdSOW5lRWFMUTNF?=
 =?utf-8?B?ZURpbWFhOFlXbGJOaUc5dU9Mb1VKMUpGRHdab3djekEzSlFhVzJRQ0EvMnR1?=
 =?utf-8?B?cUhSZjl6VTZXNFVMUmpIUWdkZndHYklDMVQ0ZmtqcVUrNS96anVJLzQyOEIw?=
 =?utf-8?B?UG0vWDRDR2l1cmsra09jaytxYWVHK0U5SlBvVTNWOFU3Q1UvSmNzdEs0RGdN?=
 =?utf-8?B?Nis1cDlnTFJCSWFJUTI5L2NOWU9OUkg3cyt1WE5scTlWS0tIOFFBeVkvLzdJ?=
 =?utf-8?B?MlZZUHBKYkVoRTdpZy9GZmoyeldpQjloejJ5SFBHY3RkQU5kdGlNczhqdU5O?=
 =?utf-8?B?UW55VXMxZDV5cXJ3TTFuUFVYdk1ldC8yNnFwakU4RHBRZ0N3dEVnT2tIWVgr?=
 =?utf-8?B?MFYxQ0hnZFdjSXNVRWxuMUxlbUxaam1NQTE0LzZ3cVFNLzVXMUdXaEx0ZnVp?=
 =?utf-8?B?T0pCTEZVNURDc1pXS2Q2VVZHT1NhOHFUZ09Ba3B5eS9FZEdkTjNjc2k2OW1w?=
 =?utf-8?Q?goQE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553a2891-6b73-4785-b7eb-08dc915cda1e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 19:11:56.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNvNx6+qyesTYtNqaTb+OhEbL4chLUkzwLa23pXR02bkVZr9HKoi0F+GGN3eb0wJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

Hi Reinette,

On 6/14/24 13:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/5/24 3:45 PM, Babu Moger wrote:
>> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
>> available on the system. Tests will be skipped otherwise.
> 
> Could you please point out where the test is skipped if UMC is
> not available?

My bad. It is not skipped. It will report as failed in UMC is not
detected. I will update the commit message.

-- 
Thanks
Babu Moger

