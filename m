Return-Path: <linux-kselftest+bounces-24754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10461A15D36
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 14:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552051888485
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Jan 2025 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476118C00B;
	Sat, 18 Jan 2025 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFuo8vYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E22A1EA91;
	Sat, 18 Jan 2025 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737207722; cv=fail; b=b9C0PIreOfJOnXMighWlwgUHkMlDETYUnPmVfTjRWd4FwVbJHFFYZDjmJmGbDc8MJ9hXMpgqChnncQgAFuVJcMFuCzTaAtY5AXvBRrYNC8l3tZNcyNfVu90xfOr43Xs7AcDDE75S9Z+YwG+n0+aMRdHafz9XGnfGlpWZcrZ+zNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737207722; c=relaxed/simple;
	bh=27/jkIFNXlheWHvveNsUmNbOx7PADf+rNl9tI0w9duo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjfx2+yTde56nRVyUuzLK3E8RddIDYc9Nfp/RyTwZfbDcSwGl/n51YmYp8txuw2hLAC376ebU5dwfui4IGo69g2VsOsQIFd4ZF/YA8m2fnbPiGoL1g1BxTbaXjg0X2+essldPg/Psl/k7W4EbyKIxUXPwtN3kv8anFi9KiJ0uQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFuo8vYk; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MphAlof/4+dQpnV3PtMJr/4mBP3x6zfQI+nMNE4N9mY/e/U1hVRsRiWGrRqbZelAKvOazoXlA+cOhILQv3tndp8dj2/aOygweVAoAxSIgC9sh7gAoesDZcNcKVqJ2w2d+ahjXUYL5AJPViDIH2NdpGRJJzw/UswWvC0Q2amSr5yj4kFE/Rd8/+q6VLz3aqwERjPsXdnXckkVas/EntpC8pno/30iLfoFwqnbbbk4XeoNcyj80h6tiKFG+wJVvpNvvZC26uAwoKnNtLkZxhLUSFJaOuH4E0RK14Z+ZzuYcKyaOAKKyRoBl7OGQFo5j9sDE6EKyXmXVkWdZAVCmlnE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWs3J11jbcka4nma94hjgFA9d2qgO9pVGFoL5AKqVyM=;
 b=arRNABNfG/b+R8Fo9SFGtpLJhtIJSn85o7WvAXTm/kde1tK3gl1eUPnhdvhFksnPKLgZ3rHrXXV5Ub1L+Tw0p0wBm4wCHdFkKvNIb5EzPldc051DwICks1aNGKyir/UbA8hkN1vzIgc0Ane/W9DjXuxgI8ZgVnImDHLuMGMS6mfHD01UJ0Z4PAnMqaFR4FvPQkx4FUqN0aEgPPYdw/q6bMG0LjI2ilHbTPLjtwtg8lCiPZ7cQLEnLBoWcNDcocTcHAOZqm8IJDANP+AahbbQBo7Ilf2CriTjpxkhbqdu9WFpvqM010MwaOuDJXKXT9rcc57D+Nmd6RBuzLU2EE/9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWs3J11jbcka4nma94hjgFA9d2qgO9pVGFoL5AKqVyM=;
 b=oFuo8vYkLqQ8EflRy/ncrhqc/I2c82FMSkmIWnlmrT6p/h/b3FukU+TOi/r1AYjUfxegzdWEdOpYQ+zd46dRw9uNRjDjEa1S9KNx6QkuvbbicDvfQW7ECZK+dqcxV4edA1DlxxBA1iPrcAtZq3jBd2d6V8brhXw6iMlkLLRdq/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Sat, 18 Jan
 2025 13:41:58 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%4]) with mapi id 15.20.8356.014; Sat, 18 Jan 2025
 13:41:58 +0000
Message-ID: <1d988e21-506b-4dd7-8a55-649ed939ef56@amd.com>
Date: Sat, 18 Jan 2025 19:11:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Add support for the Idle HLT intercept feature
To: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20250103081828.7060-1-manali.shukla@amd.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20250103081828.7060-1-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a30f40-82a7-43d7-f833-08dd37c5e0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzJrRklsWWpaSFZIaUl5TDdON3paa0NHYy83ZCtFQW5IRDFvemVIbUlJNEla?=
 =?utf-8?B?Wi9OUDNWNHQzUFZaeWZWT01HRE4rWXpocEdvRmhtOTdNMWV4c0wydXowVVlu?=
 =?utf-8?B?Y0xxTFhWUVk4SklmY0dBOXQvK3kxNVU0ZHNVRG5WR01MM3RYQmMxZXJiTm9U?=
 =?utf-8?B?empKTkdCc3UxRkp2bU1TUDBIWlQrSTY0VCtkK3h5Nmh1VUg0Tk5MODJYWHIr?=
 =?utf-8?B?blowSDNGME5kVERaMzhYWHVDbVpLRjNDbE9ZRUZJWkJKdW9HeEUySnROc0hv?=
 =?utf-8?B?UGE2WUsydzhNRThoWVR5d0dlN1M2Z0RmbnBNYXJEVjQ2b2R0VlByaUtsc2h4?=
 =?utf-8?B?NlMwd3pLQXhjYUw3Smw5TGFSNkkrUVJUVXFwcjc2RWFudytvQUppVGNmcm9X?=
 =?utf-8?B?RXVMT3JObXcxaDJMTFI2Z2h3b3FaSG1jSzloaWF6RGVMckxzQmZpYkRCN1lt?=
 =?utf-8?B?Wm8yVDE5azdqVzRETE9RLzNMbEwrbExTcWRQTmdSbjB4RlR0Qlcvc1NjbzZN?=
 =?utf-8?B?TzAwSTNISkk4QWdPcHo4VTJzZ0pVeC9wakFxSU8xL2dSYTJxdEZCM0I0UXZZ?=
 =?utf-8?B?VEJySXlBaFFQL3c5a1dFKzdtQU8wSDV6WTJmY2NvelJrZFNQM3c3ZE4xZFVO?=
 =?utf-8?B?T2IvRnRRaCtaaW1SVWN0dFVZRU0xSTNRZFJpSWxKNmJQRE1HUW0yOWJ1Yk16?=
 =?utf-8?B?VDlPMm45VjRDMnF1S0pXTUxBaWVqZ0ZjMldEaHFEbnVabmhXWDUvR2lXRzdJ?=
 =?utf-8?B?TEw5WnBvOXpJN3VyWitYRXB2TDVKMVFqaDVYZ1AxcHZVVVlRc3paSm5BQXZs?=
 =?utf-8?B?ZkhjVVhjTWt2dW5Oc0lFZkNHRzErczhhZkFDV0FnNWZtcldYU0dSRS85WHVU?=
 =?utf-8?B?RjhMYVhZR1Z0M1l0QzB6ZlpMN2l6SmFWVWl4YzBDdEpTN0toQTZDblhSelUr?=
 =?utf-8?B?a0dSeDZzekNWcGFwbW8vSjZ1dnJTL3V2VDBjTmtQRUZ4T05TTlZXYnlubFNl?=
 =?utf-8?B?bnpuODBDV2ladC9xbXJLbm9iOE5wMmkxdldDdXM2QWwvd1J2cTF4ZUVDUlhR?=
 =?utf-8?B?TFlMaFIrWk81UXBXTUdrYWtOQVVsVE5OMUdudlJONzdHWWlsQjFKMXpicjNL?=
 =?utf-8?B?UHJHTVN4SHltTXN6Qk84WjJrK0xIb2I5MjhPbjdXcVRoQW44bmYrdnFkRFFm?=
 =?utf-8?B?TkdDMkk1WTF1eHZoeGM3M0NMN29LdEtHY2s4bHdycWxySzFUcFVISlRJQkxp?=
 =?utf-8?B?QjZFUm1PbzFQbWVZa0ppNjhnU3JUMEl5MW5MajN6Q1hFa1JGbUx4am5rNWwx?=
 =?utf-8?B?VytmbHJOVlhtZHFtNmVVZTdqNko1MTB6dVdERFZCdnVTb0RLbGE3Mk4zWFUv?=
 =?utf-8?B?RkphZzVXLyt6eDBuMzNqTFVnMWltblRDaXVvb1pLaG5RWjMzRTU5SWNUejI1?=
 =?utf-8?B?bVE2YlNvSVF4NlFxMzRvMVorbnV5K29JM3hBdERVcmdNMTN4R0JVdkNUUzcz?=
 =?utf-8?B?L1NmdUFvUHVudGFFeGp4SjFUc2kxOCtJYVFqdzRVanhWV2Uwb2hrZWdMVVFj?=
 =?utf-8?B?NXFmbjdTem52MTBzUFVRTS9sVGtiODBMRnBndXF5bUlFWEU5dG5hbWsrOWNo?=
 =?utf-8?B?L2plaG9sOFlodG1YUVE2N1RnZXJXemhNek9mT1hZMjZpQ0lXL3VWUHZ4cllZ?=
 =?utf-8?B?UVA2dWxGZ0NCLzVhSHhDZVBTWHp6V3JBci9kaDZlQkhaQmtRN29Wci8ycjRh?=
 =?utf-8?B?b3I2RU9NWUNnbnpQWExvZzlmcDFwSXJUY1ZCR21xcHcreHVVdHEwZ0Q1dTZQ?=
 =?utf-8?B?dWhEUFNrWDllbWdIUmVSdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUl5SUFQcCtxVlVwRmVFNXo3cFZseHl5bzAvYitlL2YwNVpIaWQyekp5ak5k?=
 =?utf-8?B?bUxZNXJCaDN2Z1pJWkxIdjlGQTF3N3oxSkRsVUExd3JZdU9vTHZGbEJlK3ZF?=
 =?utf-8?B?VGhBTGlXZ2dseTNEdmlvRXBydkVhWUpTQnoxbFd2a1ZER1dvQ3ZlUGdCZmNs?=
 =?utf-8?B?ZDE3S0RmbXFWYmpMWmh0NEhFNXpscVlBdHliRW4wNkVpbW9kdnFFdWRSVXFm?=
 =?utf-8?B?UDJZRDFEMnVPUGk3VmtYbEtDUmlMUEdFaHd5WVpVOHkrNGcrVTA3NXMvcGRh?=
 =?utf-8?B?c3EzMGE4SElyMDBnZ1ZaWkVvQjR4Z21RY1B1RHdNNGFjbEFuUWhFTFp6WCs1?=
 =?utf-8?B?TkFiM3QzRDhhRUc4UlNqbDNjRXNjTFlMM0gwcGdBaFo4eFVoVmpEMkRVSkZi?=
 =?utf-8?B?UmFKanMwbkhDNmpQZ3ExNEhRYXBNUDk3NnBPeFNOSHZvOE00bUFMdiszdFFM?=
 =?utf-8?B?S21TamtSNXUySVVzOG1FOTVTVDY4N3dZMjhTZlBNT2NxS3BoNUxRUDdiMjJ4?=
 =?utf-8?B?cnptVlBGR2k5dDVBRWx2WjdYTU12R1lEN3lPTDBPSnJDcjZkeEthNUgxR2hD?=
 =?utf-8?B?RjJkVlZOYkxzRWZmSURkSGp5NGtydktKVmJGdUpXTEM3VVVFS3ByNEpna0U3?=
 =?utf-8?B?bDJNeTg2dU9xOStwcHkrM3lpMTRZcEptYVNLOFo3d2VmRDFJaUZsVSsrSTlD?=
 =?utf-8?B?S2hVdyt2SzJjQmxTdFNsRFhxMlpIM3VCYkNRSEtpS1N1bU1FKzVaQ1NUTWZQ?=
 =?utf-8?B?UW1YeGFrNCtqVVZHODk4cGE0ZWp5QUgxSEF3eE1WYjJMeC9iRDZVZW5GWHA3?=
 =?utf-8?B?ZkRDZDZvTjUxdnNFRUlLNXJQa0NZdUJSWWY5dDV2Smo4aXhTMkpxZWs3N1ZX?=
 =?utf-8?B?aVVCdnJxcFZ4V0l1MEVVeVdrZ3llY0dPaCt0b2JXU3dwK0RXWjFJMFlVMzV0?=
 =?utf-8?B?TDdKQ0pEVFd5enBOR25qaTJkay9HdndGTi90QUZoSG5WUUNISlo1N1FTbDZy?=
 =?utf-8?B?bjZVQ0srSm5renFKVy9BNkRrZTM3U0xWRmJHOXFDQVZwTDE0UVpGWlBxMGpz?=
 =?utf-8?B?WkxHQ1JVNW5OV3lCalV5UXNnSjk2d25MaEJ3YVd3OTBNZGJCWlFvbWtNS3Yw?=
 =?utf-8?B?MDdyRnp2Y0dXQVFyOWRvdkxPdUxFQjU1eGtOdmxCUmliMEk1WVFxMVc2S09F?=
 =?utf-8?B?ZzNqc3M5eWdoK2ZKM0lvRFFrUDE0cHJyVzd3TGdXRWpOenhiQzdHM1B1QXpL?=
 =?utf-8?B?WmRNUmY2OHhYbjcxcUhncWFQYll4WVVQMExXSUN3dkVqNlAwamVQTWkxTDBD?=
 =?utf-8?B?Z0Z1RmhjYU80ZEVNQnVBZFFsV01Pc0srbWhodzRlZll6UHNaY0JXZW11QUZN?=
 =?utf-8?B?QUF3N1Y5S1FlM0tUMzhxWjJBMlZDN0pXalNQVis4WUJScXI0dGIrUS9Kclg5?=
 =?utf-8?B?bm1penpTMVJDTDNyc2NDNlZrNW01NVNYbjZQSFg5RmFUdGtKL3pMMlFZbFBw?=
 =?utf-8?B?ZUxYNWtjTUFzTE5zeWk4Q0xEYm5ZdUZMRnorNzQxVkd6R0RXY0FVdXJzNjRm?=
 =?utf-8?B?OTJOTC9pdzJqd0ltZjI0dEE1bnAzTEZ5UXVBa2RTdk9BTXhlWWpCYTFneS9O?=
 =?utf-8?B?Nm9RM05PRFJIdk9tMFkwdG8ranpNVUVNZjVNNW4xYllnbnA4eWNSZElHVS9n?=
 =?utf-8?B?a0M5c0xQd202bXdaUUNmLzd6ZVpRMCswMGtnN3BveS9YM250cGc4L2lpWXh6?=
 =?utf-8?B?YlhmRWdjVFFWSFlhcVA1MlJhRitLdVJUWEVFLzBLRkg1U2xnRU9DWEZSUTZk?=
 =?utf-8?B?V096b290bmNUdDlVcTBHaXFoN1dVR3J2OXVMdlY5SFIxOHcxOGI1OWZpeE5r?=
 =?utf-8?B?bVZjWjVrRzBWekdpbk85UCt2aDVNTDdQMzNxK0ZoQjdlYVhtWENIaTFEMlhH?=
 =?utf-8?B?b1RqQWd3NE4yQVNEbHpKZWJ2SjdnejZBbWNxRkJ1RGIzK1pFdEdObGxXUG9t?=
 =?utf-8?B?Ylh5S3ZNTjRGSjUzd3FhRnQvcnpVc1J1OGc1bHo4Qy8yRnJHTTk3ZU1xY2Fu?=
 =?utf-8?B?aW9LVGNtSlVkTENnSkhuMWl6RXphUjd5RmRnQ0dYOG43NUE1b042dXovbVJm?=
 =?utf-8?Q?VIufJ6kjuYpZ+QumH4dNw4qXJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a30f40-82a7-43d7-f833-08dd37c5e0df
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2025 13:41:58.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAlyALZ/JaRdPN08sfuyH8IVpaLKukdIIB0vBgGin2QGTSvkEua4DbuVmU1rKD0Ve5CBnx/VxaItksfiAbxGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

On 1/3/2025 1:48 PM, Manali Shukla wrote:
> The upcoming new Idle HLT Intercept feature allows for the HLT
> instruction execution by a vCPU to be intercepted by the hypervisor
> only if there are no pending V_INTR and V_NMI events for the vCPU.
> When the vCPU is expected to service the pending V_INTR and V_NMI
> events, the Idle HLT intercept won’t trigger. The feature allows the
> hypervisor to determine if the vCPU is actually idle and reduces
> wasteful VMEXITs.
> 
> The Idle HLT intercept feature is used for enlightened guests who wish
> to securely handle the events. When an enlightened guest does a HLT
> while an interrupt is pending, hypervisor will not have a way to
> figure out whether the guest needs to be re-entered or not. The Idle
> HLT intercept feature allows the HLT execution only if there are no
> pending V_INTR and V_NMI events.
> 
> Presence of the Idle HLT Intercept feature is indicated via CPUID
> function Fn8000_000A_EDX[30].
> 
> Document for the Idle HLT intercept feature is available at [1].
> 
> This series is based on kvm-x86/next (13e98294d7ce) + [2] + [3].
> 
> Testing Done:
> - Tested the functionality for the Idle HLT intercept feature
>   using selftest ipi_hlt_test.
> - Tested on normal, SEV, SEV-ES, SEV-SNP guest for the Idle HLT intercept
>   functionality.
> - Tested the Idle HLT intercept functionality on nested guest.
> 
> v4 -> v5
> - Incorporated Sean's review comments on nested Idle HLT intercept support.
> - Make svm_idle_hlt_test independent of the Idle HLT to run on all hardware.
> 
> v3 -> v4
> - Drop the patches to add vcpu_get_stat() into a new series [2].
> - Added nested Idle HLT intercept support.
> 
> v2 -> v3
> - Incorporated Andrew's suggestion to structure vcpu_stat_types in
>   a way that each architecture can share the generic types and also
>   provide its own.
> 
> v1 -> v2
> - Done changes in svm_idle_hlt_test based on the review comments from Sean.
> - Added an enum based approach to get binary stats in vcpu_get_stat() which
>   doesn't use string to get stat data based on the comments from Sean.
> - Added safe_halt() and cli() helpers based on the comments from Sean.
> 
> [1]: AMD64 Architecture Programmer's Manual Pub. 24593, April 2024,
>      Vol 2, 15.9 Instruction Intercepts (Table 15-7: IDLE_HLT).
>      https://bugzilla.kernel.org/attachment.cgi?id=306250
> 
> [2]: https://lore.kernel.org/kvm/20241220013906.3518334-1-seanjc@google.com/T/#u
> 
> [3]: https://lore.kernel.org/kvm/20241220012617.3513898-1-seanjc@google.com/T/#u
> 
> ---
> 
> V4: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/
> V3: https://lore.kernel.org/kvm/20240528041926.3989-4-manali.shukla@amd.com/T/
> V2: https://lore.kernel.org/kvm/20240501145433.4070-1-manali.shukla@amd.com/
> V1: https://lore.kernel.org/kvm/20240307054623.13632-1-manali.shukla@amd.com/
> 
> Manali Shukla (3):
>   x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
>   KVM: SVM: Add Idle HLT intercept support
>   KVM: selftests: Add self IPI HLT test
> 
>  arch/x86/include/asm/cpufeatures.h            |  1 +
>  arch/x86/include/asm/svm.h                    |  1 +
>  arch/x86/include/uapi/asm/svm.h               |  2 +
>  arch/x86/kvm/svm/svm.c                        | 13 ++-
>  tools/testing/selftests/kvm/Makefile.kvm      |  1 +
>  .../selftests/kvm/include/x86/processor.h     |  1 +
>  tools/testing/selftests/kvm/ipi_hlt_test.c    | 85 +++++++++++++++++++
>  7 files changed, 101 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/ipi_hlt_test.c
> 
> 
> base-commit: 13e98294d7cec978e31138d16824f50556a62d17
> prerequisite-patch-id: cb345fc0d814a351df2b5788b76eee0eef9de549
> prerequisite-patch-id: 71806f400cffe09f47d6231cb072cbdbd540de1b
> prerequisite-patch-id: 9ea0412aab7ecd8555fcee3e9609dbfe8456d47b
> prerequisite-patch-id: 3504df50cdd33958456f2e56139d76867273525c
> prerequisite-patch-id: 674e56729a56cc487cb85be1a64ef561eb7bac8a
> prerequisite-patch-id: 48e87354f9d6e6bd121ca32ab73cd0d7f1dce74f
> prerequisite-patch-id: 74daffd7677992995f37e5a5cb784b8d4357e342
> prerequisite-patch-id: 509018dc2fc1657debc641544e86f5a92d04bc1a
> prerequisite-patch-id: 4a50c6a4dc3b3c8c8c640a86072faafb7bae4384


A gentle reminder for the review.

-Manali

