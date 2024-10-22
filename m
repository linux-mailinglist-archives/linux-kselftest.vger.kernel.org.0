Return-Path: <linux-kselftest+bounces-20379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DE9AA023
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142041F22D41
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFA199253;
	Tue, 22 Oct 2024 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p07T82Ce"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9B6F066;
	Tue, 22 Oct 2024 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593327; cv=fail; b=RLpDrCkQCy98BgKWIF1u98HJGi0gqWfnejtPKysxBHWV0cA4aAsAqP/gmR9o3jp0TYa7S5j4GbrSiYkcxMKqmTytYYK3TCrQJNhfPu5r2FOmrsaLzNWly8UzMoDhYp6tzBoh90RIaew2TZVTHtV1w5VLaoXVikx1dZMz68RqQ1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593327; c=relaxed/simple;
	bh=d6gbv5SdlMXSBF4MFv6GTRkIDLd3wW9p8eNLDgBwMSY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GRrqbM+00eVS8NA6ZIhkDlvqcNb7RWUBaxdNsRz3UQ6u+ZJLrG0bDbxey34uHBIZbM0sJ+S7NZ713GB40aKm5FDlqFcqsA8B+2EtYC2GowdQtcqMD3tGELF7yA4SbhQdSal/7Q6oNpV0g8l+y2HCyb05C21duo9PSCnoQXhJDS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p07T82Ce; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axrmQqu5IGUHo78HZkuF4L/JfQJ5ci2s0dnLkre5KYaLSG3cpho266/X1WMqRVHhrfZ9YOCu2nlyeQLELZp3dj47bw43nku0kZgc0EAz4Vwo+9capGxVAZh0Y+nsivlxxfJwsjRU9UMrMYJJD8jdlCwt/2G5sc9qPEp1t/zsAOQaDW0oY8MKS7LRNdYKiO4gIoXb6s5+id0kztzDuyPmY6zIrPAr97aHc4TSUBxfNYFjq6MqMUf945QtZi7WeQSvrLcnfRbeBrOeuaJPRGQA81PMXPVqoppIYtXtldfv+tH7jPwmkYRTi8rTl+JTRCG0Mx2cO6vYYl4Nl5cCiALMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1tdXjHyi51L5XPYXm8z4NafTIMq6I57efMKFcaTeXk=;
 b=vxiRhlP1lJHvdHPKTlh1D6ZFNDu33uVY8KHBG9ICWDBNFOXBcr34poO+vyAI99vTpiDX+f0OY8ARpmNHKH7W6GIkf70wvgoL7D/BdC2i7I99QKiDZW3X1ARKUpcY3KDnytwnW1uMp0KQO85kQ6Ig5DfSm6LW/ITk/yyOU//WffcPzTZ07x+Hl9HQhe1ZYf8Gw/F731xoheF6oDO0Ul7mzoCn/QwQzjMzSsSnsSGN/lIu9ISK8Nh8jfVZpsK5gy0KoECiu45v0K9VznRJnh0+jD9dZR4GOIMxxHFbC7mqhmGlT1e+t/38tiF8Vv5fiYi8Y75eMYNZoKfCoRisphPgsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1tdXjHyi51L5XPYXm8z4NafTIMq6I57efMKFcaTeXk=;
 b=p07T82CeZK0Bp7y1re6f2hp8G2PPDzVoxzXp8aQzKt81X5rjZZGMNqP9KwCDMhrYDdZIQINPeu1Vf5R1Y/ZM5TPKCZKtGuOw0jdjp2RkSY+t1uaNUE5dJXub8i5pc5uRKYSSSZAre3i3YWsCwxzH5lkYacV6uAXGYwZxFI5svCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 10:35:21 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:35:21 +0000
Message-ID: <a19d0168-2a6d-4070-bb34-0606f9e4e3c0@amd.com>
Date: Tue, 22 Oct 2024 16:05:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add support for the Idle HLT intercept feature
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 ajones@ventanamicro.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <CABgObfbz5kZZObu9dO=KPu8_mZvGmV1752SQzQckkrj5jPaTQg@mail.gmail.com>
 <009cbe00-dfc3-4a94-b6ab-9d6ec9605473@amd.com> <ZruHqe4in12RnNuf@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZruHqe4in12RnNuf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a19aa5-da34-4592-9101-08dcf2853b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjFOSFg2RUFxN0tpS2NQazhZa3JsN3FReGJYaFA3bytqTktTRXhzZHphQ2dB?=
 =?utf-8?B?NkZCSDA5VncxRWxtYUdjOTFmTExaN2VxOTIzQU1Wa3Z2RVRXU3dIU3pQa3BE?=
 =?utf-8?B?c29uQ0JOL3UrY3puZk5TczNJM2xMbm15WjNZNUFseDhHVVRnRFd5d3JCRGYw?=
 =?utf-8?B?ak9CV1ZLWk93SzZjMFAwWUVlNW1QNTdNNTN0dnozeDRqbVl3NC9VZ3ZjVzhH?=
 =?utf-8?B?K3NTcmI0Y1hqaXRFNUlkU2NBQjJGVVV0ZzNJQVlKd3ZqcHVnbW45KzZmUzF2?=
 =?utf-8?B?MHVqcDN3dk5sTlJXdEJVMjQrTk1wREFKd0h1MDc2bEVZTnZ0NzBqWWtkY01h?=
 =?utf-8?B?dGNPdE9HWTduKzRjVC94S0pVUVN3RGhxY2RMVjJ1NGtoT0JzejBmUFFMbExq?=
 =?utf-8?B?NzFsd2U5TlZsMXBXV2srdnhxWkt1UjBWNWNrTENiaFB2VUczU3p2OFZVc1Z4?=
 =?utf-8?B?MnRGZ3U5QjlaRFgwTXhSTExxSGxYZ1RGZ2hSVWc3V1Qzc2oxQ0dxV0RzamN1?=
 =?utf-8?B?OWMrR2VJZkFXcFFBUEl2eG9nbC9tSnJVb2FVN2VmMjM1WVpucXRRUFJmVnVV?=
 =?utf-8?B?bU10alMrRmY3WkpEem44QW9taE91cHJaUXI5aWc4eGhGN2x6aGVWVGUvQTVC?=
 =?utf-8?B?S2hEOVBheG11U3NzRHpmZnFDazNOT1ltb0hxbThQd3hPVTNwZXJSdWxORW1z?=
 =?utf-8?B?clpxTTFOZkNqR0VkZE1tTWdFRkR1MzlyT2VCWWRhUjZEaGlqN3o2eTBTOGp0?=
 =?utf-8?B?MUZnS1Z3RitkT0dDNEVkNW5lVUlTUFloeTVUZmRJS3BKbCs1UUd3bVFXOHlz?=
 =?utf-8?B?cUNnRmdjTGhaWStwUUNmZlJJblRkR1BCYWplOE1UUzdsK1lTWVV1RGlmaVl0?=
 =?utf-8?B?NjRaZGdnQnk4Wm9nTDVpQnRKVDY2VkhJaWVwRUNPYmJuNHVueEtLRlpaWkVy?=
 =?utf-8?B?a1I2dVR2ckg1N1d0cW1QVEs0Z0ordXB0cmdBY0hqelN4cFNtYXlGYU04UUJx?=
 =?utf-8?B?ZVorLzd1RlJyNGxIRUpFRkNyc3MxZ1F2UHAyVVcxbGlqNnRCR0hNNGFQNEZ2?=
 =?utf-8?B?WHJZRTl3SVYvSVVFc1Q2czVrV3ZqYTFHazdrNEsyVzJUUVpUeUF3RUE5Ri9h?=
 =?utf-8?B?TFRXUnF5WGpXeHd5WHVpNzR5VkxoUjhDZUNJandrMU5UanE4RlgvYkZGN0JP?=
 =?utf-8?B?ZUlFc05lZEtsQ1VINUdWekE3ZHN2bXhwSmJoL3JPYTlzL0FBTlNZdVpBODhr?=
 =?utf-8?B?cjRHZjJXNzdLNGlnRGZBZnQ4eXNQT2JIQzh5alFrRkVhVkViWmJaN25kbDBR?=
 =?utf-8?B?aUFhekRQMGF5blB6dDNLd3J0MHNVbzJEbDhaS3gzZys2OTFRb20vYkdwNUJC?=
 =?utf-8?B?MTE3aTVKMGNmQmwyTDk5VHViV0R1NWYxR1FWb0tBTERqZjFVak8xQkROdWpO?=
 =?utf-8?B?QXJiNEd4TEU5UzJZZmU4c05xZThqQXZuTnNEbEFsNkFDcys2ODFFblFYektZ?=
 =?utf-8?B?djJpMkNTTzFpYVl2aVV2U1dKZFByRzFUa2l6UFBicnlhS05EaGR6dTNMbFRn?=
 =?utf-8?B?MWJiQStzdzQ5NWhGdTZvNytiWlhkUE1OaHRnamh0VWR0cnhObGhNZjFkMExy?=
 =?utf-8?B?WS9ta3huZEpiSVJ1Z2xDRVFJVEhmR3lRdmNmdGU1Zngvd0lOZjNaUDBzUjIy?=
 =?utf-8?B?ZFJjK2doUC9TQ0gvb3NQdXZZRFd3Z0tGZzdaVE5LaXpGM3QzNTRPOTB4UEkz?=
 =?utf-8?Q?Ae3A+6VicYdskSgqjMZexPCSCKwaBRB5kkpKHks?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXZpRWQ5RGM1amZxUmtFKzE0cnZNS2gwZ1lkU0xLa0VwZ3M1eVNBb05RVEFU?=
 =?utf-8?B?SWFFZ0VVdEd5ZTB2U0xabmNDQVZNcVNGN2pNTnJzNk95Z3g3ZU9yU3czM0g1?=
 =?utf-8?B?UkdaSmVObUliUlMwUnVLQXNkRC81bU9jcDVIeVcrSU9UTUJCNWhmSVN6cWFr?=
 =?utf-8?B?SFVBbjNDeFFhS2ptUEhFejV4ZUZYNkFLRncyb2JETlJ4NzVYNUVRZUgyVTRD?=
 =?utf-8?B?b056Tk5lWU5BSXRmOEpLL2dZZHVJaENQZlhNTFpZc0Q1ektFcTNTRmVuQ0l5?=
 =?utf-8?B?NFhUVHVJc2g5dVd0MVNoT0NMRUthZ3FqZmlrUU9KcUduZGxrNWZVWEtGSW1S?=
 =?utf-8?B?eHEzS3k5SENUYVNJaVNVYkJKbEM3ZGNzY3VaSGI2MXVJVkIrY1ZBYTYydWtQ?=
 =?utf-8?B?RXBEeGZNc3hCeGZiN0lCSTZTVElldHFhWkRHZXc3VlAxL1VGNjVWaG4yL1A1?=
 =?utf-8?B?VFRXNjhzNlpoS0x6ZlNyN1hEZzVsd21rSlFQYURMTnpsZ21UUUk3K3FpYVpI?=
 =?utf-8?B?dzFlSzdyQ2lKV21HdGxFWmk5YVE5cXFzMmRsbmo5N3ZLNjVOaDZqRlI3VytX?=
 =?utf-8?B?UmVHekduaG9vS01vNGtFNHdYUHpZZk9sSWJvSFZBZTE5NU1LTm5rdnowZ3lI?=
 =?utf-8?B?YW5JNlkwWW1WQldvcVdRYS80enlib2x1d3VqQ055akhCL1hFZTVBeFhZcmk1?=
 =?utf-8?B?bTVacDlOeUZ2MmNRWnVlV1hFSy9zV1I3VDZqU0ZUMXBndWhMY3VhaVJIemdS?=
 =?utf-8?B?RFZtTjFZZERQenliNW9POTRmSUxyS1k4a1FUNFo5Y2U5cHpHTFAzUklLVW9G?=
 =?utf-8?B?NEZsQm56RVFCQk1oR25mdjhhMnZ2TlViQmdqYUNzcjkwTXpzM2t3OC9XeVBw?=
 =?utf-8?B?Q1ErMStNSndCcXVOSVhLRTNKUFZoOVI3c0JSbVJoajhqOXE2VGM5YzVDbFhK?=
 =?utf-8?B?MHV3ZDk2Z2FOUjNybFNsMk1jcDM1NWdtQ2FuUkZlRk1rdlJtZVExdHdFSjAy?=
 =?utf-8?B?NlNNeXZxR0pRM0xEenJSS1FHSENTcE0yeEdKdE1YR1RtSnVrYUpPUnhkcGpk?=
 =?utf-8?B?aTZOQVlTWlNibStWYmtWL3lLRVN6ZldkaStTSEFUZDRoQ1hSL3FXSU96S0hO?=
 =?utf-8?B?V1p3aHJnbWpwTHJyR0NxdUYyby92U3ZmZTYvM0JhempkeEFOWFFhbko1UGhl?=
 =?utf-8?B?S0l6dnV6Ymt0NEs0VzVDeGg5WTBxV2t5Y2VwK2U0eU9hdDNHbEhXcHlhODh6?=
 =?utf-8?B?MVpUQnk1VEk3OXA4cytUNkk0dm9YamVZWmduWThrYUJ4b3hFNzQ3dnI2TVQw?=
 =?utf-8?B?ZzhsZkg2dXk4U08vd1BOS203NHd4SGZIVHVMQ2NSbmV6N2E5VlkzMU15cFZ1?=
 =?utf-8?B?SGllUzlHSE5NMEJNdFlJUnVaVitZeG4zTitka1JEWXoyYzVyWUErbVYwK2pp?=
 =?utf-8?B?ZVhMdnJFRFZZQk9iSXBNTHhSYTlkdkczTjZsekFqSGZFRUp5ZVRaa0U4L0s1?=
 =?utf-8?B?SWZQMW8yUWtlaURUbGFTTFkrMDBtMFIzSGE3a0FzSHFQNUZRTm1vcWVNMnkr?=
 =?utf-8?B?b0c0S3RmU01vS1BiZC9kdGlNWkxRdmVOU2thQ3JTTGZQVS96NXNIMGMzMExa?=
 =?utf-8?B?Lzl5V3VNV1ZFNlIyWVJhRnE5cTgzK3dXeklsZU50MFFhVno3cW5jSWdKdlVO?=
 =?utf-8?B?QnBwS3dpS0lzTEpBbkFNMkV4bno2MFh1QkdYRkhqQk9Wd0xTY1d1UG5IUkNZ?=
 =?utf-8?B?RUMvZGNsSGFjT1Z5ZU5TNms0c0dYVzJXa3NTWDJONyt6M1BMMTBZcEdBdVlp?=
 =?utf-8?B?NEtKclhsY2JSMkUrKy9XT0ZHWko0Z0ZHVmhteS8rQlVTZm0ySTFwMm1lLzBr?=
 =?utf-8?B?UlBkcFhTem5ZNjExVENETXRxeDNRdUYrVTliZHFNb2lvb0pVWHlYZkpuZjdq?=
 =?utf-8?B?L24wU2M3NHFxL1NWSTR3NGhxSkptZ1RVOHliRk5veHBNUkJ5QllrVjZIaEN5?=
 =?utf-8?B?YUY3T2ZibHc5MWN2WktKbnZMN2hVTnl4WjhvYjVZdFZYNGt3eFUrY2ZQSHJ3?=
 =?utf-8?B?TzBLTzlpVkdTSGhOMU5iV1FXZ1JPYlNIMm9KcnRLYzZDRmY4K2JGc0dBOExi?=
 =?utf-8?Q?AGPzdyDiqoLpQs+LfXyjTrSJz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a19aa5-da34-4592-9101-08dcf2853b04
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:35:21.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRxZKAyJQ6lJBUxJjTMet+/vq8wjKz90ix46siWX4m59Kie3b3AMvrLOdDqmfosr45pvxDbBq2dNjLDAfwwD0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

Hi Sean,

Thank you for reviewing my patches. Sorry for the delay in response.

On 8/13/2024 9:49 PM, Sean Christopherson wrote:
> On Tue, Jun 04, 2024, Manali Shukla wrote:
>> On 5/28/2024 3:52 PM, Paolo Bonzini wrote:
>>> Does this have an effect on the number of vmexits for KVM, unless AVIC
>>> is enabled?
> 
> Ah, I suspect it will (as Manali's trace shows), because KVM will pend a V_INTR
> (V_IRQ in KVM's world) in order to detect the interrupt window.  And while KVM
> will still exit on the V_INTR, it'll avoid an exit on HLT.
> 
> Of course, we could (should?) address that in KVM by clearing the V_INTR (and its
> intercept) when there are no pending, injectable IRQs at the end of
> kvm_check_and_inject_events().  VMX would benefit from that change as well.
> 
> I think it's just this?  Because enabling an IRQ window for userspace happens
> after this.
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index af6c8cf6a37a..373c850cc325 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10556,9 +10556,11 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
>                                 WARN_ON(kvm_x86_call(interrupt_allowed)(vcpu, true) < 0);
>                         }
>                 }
> -               if (kvm_cpu_has_injectable_intr(vcpu))
> -                       kvm_x86_call(enable_irq_window)(vcpu);
>         }
> +       if (kvm_cpu_has_injectable_intr(vcpu))
> +               kvm_x86_call(enable_irq_window)(vcpu);
> +       else
> +               kvm_x86_call(disable_irq_window)(vcpu);
>  
>         if (is_guest_mode(vcpu) &&
>             kvm_x86_ops.nested_ops->has_events &&
> 
> 

IIUC, this is already addressed in [2].

>> Snippet of the Test case:
>> +static void idle_hlt_test(void)
>> +{
>> +       x = 0;
>> +       cli();
>> +       apic_self_ipi(IPI_TEST_VECTOR);
>> +       safe_halt();
>> +       if (x != 1) printf("%d", x);
>> +}
> 
> This isn't very representative of real world behavior.  In practice, the window
> for a wake event to arrive between CLI and STI;HLT is quite small, i.e. having a
> V_INTR (or V_NMI) pending when HLT is executed is fairly uncommon.
> 
> A more compelling benchmark would be something like a netperf latency test.
> 
> I honestly don't know how high of a bar we should set for this feature.  On one
> hand, it's a tiny amount of enabling.  On the other hand, it would be extremely
> unfortunate if this somehow caused latency/throughput regressions, which seems
> highly improbably, but never say never...

I have added netperf data for normal guest and nested guest in V4 [1].

[1]: https://lore.kernel.org/kvm/20241022054810.23369-1-manali.shukla@amd.com/T/#m2e755334c327bb1b479fb65e293bfe3f476d2852

[2]: https://lore.kernel.org/all/20240802195120.325560-1-seanjc@google.com/

- Manali

