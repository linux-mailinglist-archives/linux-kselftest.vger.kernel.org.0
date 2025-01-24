Return-Path: <linux-kselftest+bounces-25077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8616A1B275
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 10:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EAD164CA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 09:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0079A1DB144;
	Fri, 24 Jan 2025 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LoWrHsSb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9F320B;
	Fri, 24 Jan 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710317; cv=fail; b=HiMNL4b7oiaL7zsWMkiIex6uwEFy0KywXsDr97eiJfjjdbPsehYKEKzRZ/hEtqwohcoPJ6AGIg0abmPsFL7of1gtMsNZb7sz3AIQY5djTiI6ZJEZcG6ZVPDXbD+skj2FIjBUILaSlMmIDrlE2i1NQFWJf5oO+MkylnkTu7+pb9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710317; c=relaxed/simple;
	bh=U6fcGcoscRPoMWpgrUIUwbhaidCmb7NwPefWYaod9fE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Di3kMX/EP6iPz+sDJo9RyQv6jgZY9RMQkIfC/SZHe/+Qwj7Fv27/5rXbu3jraX9Z1Gsw6bTmHqV3fYOEWmpWbl1Nnq+i24CyqeaKYzoTfAh/ZKTMWYNOleDL+OjFWFCGBQXNNaC1qeRaVeBu5iPZWsl01k7wYK1KZhk7/McNT1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LoWrHsSb; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS5Q9OCU1AXVtdTeYaUg4wC1HtpeVV+1CQQP21ctB9ZW5rEFpBQAbRjMEtAfxk0WNvpOsJqoh4D0rQbzI8SmeuAXLsGR5kLeDeyeDBRn0oHreZYM4ZkauYFJNs+UWZB3K4FPFWcrkpdfgBV+dljbjGcbcAMpRLsVzheIDvRu7Q/n3a0pmI4V71wg/xf8j+0tTqmW3mrhQgLkVWCXD8z7wz3+7j0DCCOWi+sltlrc4kUwEDmWqdpCAgWFe73C1FauatKWSX0/ZJwGtEB3noZLc+j2A8TMGwbK2jqYhiVf3MlXlGY3DDh5/+nY+amM0q/02z6e2IzKyOleUURoRz985g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzX1Ivp3TBGZHvIZa68+775bZaT2ZVmrnM+SEPHrPs4=;
 b=Qq5e+sT5d1m+2p6vO0XvEE4cWa0eShd15yTGukeNks18upu9oNh+UD8v3lXda3kagEVDez689l423Qu9Kr33isyd/u03DUT6JSrIlxCbwlDYdLkDGjssisUwF+zOpCwbCh1WhhJhPNMUIUXOjfurxg2yEtAiPnqNPWJ2y4vzgbhFrK23AlIgLflq6Z+cAWQ1WhftOw8vAORlBbHQ6V8tffOd8KaKOYuAGVJtBHEMBIHONsx0cOTYyGXSUA3+N/FvBEEksq/TIfsUDtmIKOBi+vOxsCPLXJ2CfcqnyUCJx656im8IKitJaullnnruBClam6fr2gwLhg9HOQDtBFheqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzX1Ivp3TBGZHvIZa68+775bZaT2ZVmrnM+SEPHrPs4=;
 b=LoWrHsSbLmGDYCCHYBhKtlI5du/DJ5UkVuRM1kvbdw8vDDen4S2u/iEjVcILdQj4XnsnyJYIedj8G2uWcoDA8vqPACDrTrvC5olAehzO8ZR9A5E82B/uV+Z1MGsg9UVw7/GZ1EFU/LpDRb0UWvPycjSVgKzT+y2srRm2mV8+wLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 09:18:34 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%4]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 09:18:33 +0000
Message-ID: <09f57158-3b79-4c61-834c-950ed40b7605@amd.com>
Date: Fri, 24 Jan 2025 10:18:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] KVM: selftests: Add VMGEXIT helper
To: "Pratik R. Sampat" <prsampat@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, thomas.lendacky@amd.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, pgonda@google.com,
 ashish.kalra@amd.com, nikunj@amd.com, michael.roth@amd.com, sraithal@amd.com
References: <20250123220100.339867-1-prsampat@amd.com>
 <20250123220100.339867-5-prsampat@amd.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250123220100.339867-5-prsampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: 701df5c4-df03-4fbb-fccb-08dd3c58134e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0Q1VDhiSjJrT2V3REY5NjFsTE85WURSZWpIWEFISTNFWFBkRlNmcnppeGVL?=
 =?utf-8?B?cnJ5Mng0cHA5NWRxTGJIU1RxbWRQWXhtN2RldEtITWxrbGZONUFoaVFjR1Rl?=
 =?utf-8?B?ZGNWZnUxSVVaaDZpc010TG43bzRkeW1jZ2VzWGhWMG16SFh0NCtKZ09aWDE5?=
 =?utf-8?B?cVpWUlFFVzV1elVFaWFoYmxFcmZrR2dnaDhoRnRiTEIxQ2tsdGlPWEUzZlNw?=
 =?utf-8?B?TFZzTThwSWpndWJlUXY2SWJUQWx6RW4zcDBSSFVYeDdtdUxzU09peEpJM1lH?=
 =?utf-8?B?dkZvUVIyK0VpV25HWFVGTmV3Y2w1VmlpanRIdTVTUkRhOGxUK200NmEzQjFk?=
 =?utf-8?B?ZVZNV2pQUTh6d0cxcGhOZXhXNUpRVTZXL3MyeHRIQndubFlNTDZ0eWhUQ3R5?=
 =?utf-8?B?bk1VRGtzN3V1SW5jRkpOLzNPeFRqSWZHTURHb3E0bGtKMkZMRHdUSDE4NUt0?=
 =?utf-8?B?VFU1TXFWWkVObGFuMHJXVVIyVFFUdEhYK2kxU041VmJDcFVGV09nVnIrSzJM?=
 =?utf-8?B?U1FMK1NoWGpRTGtERlRsM2VPUHBQVkRCcy9qZzV5czY5L2JXNlFTQUI1RkIv?=
 =?utf-8?B?OHNadVZCZVYzRFk5aEZRM3VWL2V0TlN6OWxmcWRSN0VWbmRjemRVWTNnN0Ji?=
 =?utf-8?B?UEhzVU5Cd0kzRHVjWE82MW5JYlllb1hHUzNxU3Q5TFVMa2NkazhodWh4Ym1n?=
 =?utf-8?B?NlhXREt2WVVkcEdScmNEQ29aSml5NThJeHlsaHhwK1dBd1U5SXExSEU0cGR4?=
 =?utf-8?B?R3JVblBCNTVqQnNsNXRuMXdQaThIZUU0ZHdBR2EzbnV0WTFWM25PbW93bm5a?=
 =?utf-8?B?S0lnZFN0YnRwdmN6Nm03UFRxSDdWVTg2cmlIVUZMRnQrSFhDY0J5KzU4NGxY?=
 =?utf-8?B?UGpONWRDQ3pBNHpJaDF1MVRtZnlQbzI4dWVpMGsxb1hjWCtxakJyYVhMSWNn?=
 =?utf-8?B?eHRicnNOL0lVS2Nha0IyQ01FdmJXRm55cXZHMWpIUHhWNUQzK05kWk9EV0xr?=
 =?utf-8?B?VWJBd2EwMjFiOE9tZXFhb0Q3NTQ5YlNxYkJVWGwzWEsxeUY2VGZwUXdkOCtj?=
 =?utf-8?B?N250elUwWXlYWW90RytsQWpuUm1ZSlhqUFJ6dkpHdkdQVWdwTGxWOE84UDF4?=
 =?utf-8?B?YVN5NEtyTmY2c041eGptMGZOaDl2V3FCNVdxRUFRQlkyckJVb1Q1VVVITjYx?=
 =?utf-8?B?blFKbGl5cngzQURSRHdiSE9nYW1STC83N09HQ1lBZkVzUVl6aThqc1VnbGFm?=
 =?utf-8?B?b0pzMWVTQjN4SlBJOWlSdCtHYVRJcFJPWjVIUWdqT1Y4TERuTU9WMjlabSt4?=
 =?utf-8?B?aFVDQ0xkTlpYZCtMbmZsc2E5cFlybVRnMnlSdkdxdGxBWHRiTXNkVWR6VWRi?=
 =?utf-8?B?RDd3SkJmMDROTU9DQmhTOWNNdklmaWpPbmUzU3dLcG1nMHN2NHM4N1FlU21k?=
 =?utf-8?B?RWN2T2FITUNGeXdjRHArYmdKT29NdEQ5UVM2YW9ZL3MwUnF0eTEvMS9LWm4r?=
 =?utf-8?B?TU1tN3VoQWJiaFlpeXQvbWZQV2dxWEZNTmZXUG9IM1IyQjFXcTI5N0c1RlhH?=
 =?utf-8?B?cy9WdVQ2ckNhSldyYW91dm0yWnozNWM5V2VUYUJCSGpsMVlPTG9RSnZXSk5P?=
 =?utf-8?B?eWV1M3Jmd2xlSWM2bE8yK0svUG5JczdSTGpGN3E4Q24weFIzbUNtWTlQQmZI?=
 =?utf-8?B?aFVVNE1lK0NDazBmU2Vtb3Z6ck1kNS9VMlRZaTB4clNRcEhuOGd4TWhSN1FX?=
 =?utf-8?B?Y3d5ZTlhL0Q1Y0syRTlCUS9HMzBId0VtQ21uSVhKQ0RzNmxsUEdRYWdlY3E2?=
 =?utf-8?B?RjBieWYrWkxtRjRZNkJycDNsemZuZjdQdVUxckV6c0RpNkFJdE9Wd0svQStN?=
 =?utf-8?Q?CJIesDFCcJTdT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0JlWG1DS2xjL1ZUdkFmcDd2Q2lkcDlZL21FMWNSWnhsUGYxb1VKMTEwRGR0?=
 =?utf-8?B?S0hoSzBibVZSRStMLzNBYVoreE5iWWFRSlZiUE9US3A4eGZ6R1MwTnhOVlh1?=
 =?utf-8?B?ckc4N0lrUG02b21lNWZwUVdFcEtiWmJwbHBETC9wODNDejQ1amZjb2JKRjhT?=
 =?utf-8?B?c1Q3L3dPS1pURFdzWk10M2x0SGxFY3lpd1BCeC90U0VueUdnRCs0MEViSlJC?=
 =?utf-8?B?T3NycU1CNmlJY092cjNmV1RnaXNNNGpqNHAxK3UrbmtkTlBDSzQ0QWxTVU9v?=
 =?utf-8?B?NDZVQmJvSmhXcXNWYlprVUVia01lUkpVYkpyZGZpS1d0ajRjUEJCR0Jzcmp6?=
 =?utf-8?B?OXQ0eCtTd3h4MERhczNPaHFrTXovVm5yek9OM2gyRXVEMEFBZmdaeEN0eXpV?=
 =?utf-8?B?b093WGMrS1JUdUV1WHJLcUxPSTlrMDZHNnFhaTA4VUxvUzh5ZHFQMkRyNVph?=
 =?utf-8?B?NzdyclVKQVZqNWY2RlA3UVhhcGtsKysxVVVnQXR1cnAzbDM1RU0rWWxMemxa?=
 =?utf-8?B?bnM4Y0JVek9ETWZMWVNCTlRrRTVoWk5iTDZQNE44dGdkVVFydmE4clpSQkRz?=
 =?utf-8?B?d0VsRE93RWlFd0V6UXU0MnppUjF3YWNSeHdHZm5OcVJWb3h2Um9sRzdPd2lG?=
 =?utf-8?B?TXpDNWFBVnVTeVB3dmtpZUpSbmlDNDVwZVlwT1RPNDFpWEwrT3NZa1VuL3hD?=
 =?utf-8?B?ZE4wblBGdjlOek5PaS80RGRXbnN6ZHRXcEdReWJkcmgrenNrclkvQ05iWEhq?=
 =?utf-8?B?dWRrdjNFYmRXSFBwTk13RzQ4TE9Gcy85cFNNcG05U1pjRnRVb1VocUxaRzdS?=
 =?utf-8?B?eExCUi84OTJMNFBYdFgxYVBQWlk2SEpqR0oxSVRNVXhFajhnaEl1aHZWN3hJ?=
 =?utf-8?B?anVHQmdYdjZEVDJCVjFWSlNJTkFFL1JsY2EwR3Z5YjNrTXlRZU5tNDJSaVFP?=
 =?utf-8?B?K0QyRDhaQnNsK2pSbnRWZWhMT3VJREtQTkoxS3lhRXRQbG9iaGdHd3ZLM25n?=
 =?utf-8?B?ZGVhRklCMXZYRE5sSCs2dHlsNm9pUTV6b01xaVpZdXFhN1NjVXd4RFdSTXZi?=
 =?utf-8?B?UzZrN1krZzUvQzRZWnJuTStoQ092Y05MaDNWNWprcUlvMTdWTkFsREFYa2gx?=
 =?utf-8?B?dHAwZEdrR0lRT3hxTlgrdTJGUnppaU5VT0hCMmxJNGVEQjUwL0psQ05xcEVH?=
 =?utf-8?B?cHdOOXYvR1hPbk1MSkZRL3FadEh4dzU4TVQ3SzYvTUJ4bjhCd2UySHVKWDhS?=
 =?utf-8?B?RW1zWjc3V0hUdWZEQ3hQQ05qUHFId0RMOEZnNXVrS0ZhT2I0M2Y2K1pZci92?=
 =?utf-8?B?K3VqanFiNXpDMEIxbEJiVmNNTnZnNDdYaktRa2ZDMmRSY0VHTXhxeGYyd2dn?=
 =?utf-8?B?NXBwaGR3bGE2UEZ0dFRQbFZYYWVLOU4rZHF3MU1vbHhxMjdXd1pGalY2RFFS?=
 =?utf-8?B?S3FObURFKzltSDRqbkRycDRTczNMZVlWb241bWFGaXpUcStmYWFtcExVd2Jn?=
 =?utf-8?B?Z2RwbFY3VXU4MjZDTnhPTktycGZNRExNU0xmekFyMVUzVTJnUmJuMmFHWGRt?=
 =?utf-8?B?KzFWN3lpbXFCK2NHeVNZTTBQRjBFUjQ1aTFsMnpyMUtvYlk5Z1lFRDUzSTdD?=
 =?utf-8?B?MGdPR083Rm43T0V2OGp6V2t3bS9iYzF6RWRKaVg0VlJXRnJJNWUwbDhiTzBT?=
 =?utf-8?B?Si9pbjN1N3UwTmhZci9jVGhvRDllUFM4WnBFRWxKeVh3UXQxUUN2MjNjR3k1?=
 =?utf-8?B?Yk9zTSt5a09qUWV5V1dKN0VmMjB2NGJsVXNlOC90SDA2SlpxZEY5WndKKzMr?=
 =?utf-8?B?U2F3VFN0THhGbTBkejZLMldueXZqTUZXai9Hd3c0cUFMZ0xEM21BOGdBZTVT?=
 =?utf-8?B?cjdlK0tndlhZSFNqa0w3Zk5UVVYxTzdHREJ6YkMrUnl1b3k4alV6NDJmVGsx?=
 =?utf-8?B?SG9DK2FkcDQ3d3hFaTVvZ25HcDg4aEtYSXhTbHRJZ0NNb05aWTllUkRYMlpY?=
 =?utf-8?B?TUlKMkZnaEMyVk5jM2ZSOEtXVmZMOCt2ampMRjhwRDRzN2hzZFdhaWlEbHpM?=
 =?utf-8?B?bDhobXRyNFM2YWp1OFVuaEh1bGM3SEtMVjZtNXFrdlh5K2FMWllZOHZVcFln?=
 =?utf-8?Q?XQP5XH3wk9UT6QBdq1cvXP5Tt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701df5c4-df03-4fbb-fccb-08dd3c58134e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 09:18:33.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FqwgaEfoUzdPzO+F7oOd5wWPczCg2OIPy/eZFwN6bMp4K3kbEa/ZLvEHJcHIa82exlMJIQuPjS/pvnGq5A+G4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

On 1/23/2025 11:00 PM, Pratik R. Sampat wrote:
> Abstract rep vmmcall coded into the VMGEXIT helper for the sev
> library.
> 
> No functional change intended.
> 
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   tools/testing/selftests/kvm/include/x86/sev.h    | 2 ++
>   tools/testing/selftests/kvm/x86/sev_smoke_test.c | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
> index 82c11c81a956..e7df5d0987f6 100644
> --- a/tools/testing/selftests/kvm/include/x86/sev.h
> +++ b/tools/testing/selftests/kvm/include/x86/sev.h
> @@ -27,6 +27,8 @@ enum sev_guest_state {
>   
>   #define GHCB_MSR_TERM_REQ	0x100
>   
> +#define VMGEXIT()		{ __asm__ __volatile__("rep; vmmcall"); }
> +
>   void sev_vm_launch(struct kvm_vm *vm, uint32_t policy);
>   void sev_vm_launch_measure(struct kvm_vm *vm, uint8_t *measurement);
>   void sev_vm_launch_finish(struct kvm_vm *vm);
> diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> index a1a688e75266..38f647fe55d2 100644
> --- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
> @@ -27,7 +27,7 @@ static void guest_sev_es_code(void)
>   	 * force "termination" to signal "done" via the GHCB MSR protocol.
>   	 */
>   	wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
> -	__asm__ __volatile__("rep; vmmcall");
> +	VMGEXIT();
>   }
>   
>   static void guest_sev_code(void)


