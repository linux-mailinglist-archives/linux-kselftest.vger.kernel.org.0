Return-Path: <linux-kselftest+bounces-32767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B9AB1BD4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52A3A05483
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960A23958A;
	Fri,  9 May 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4kgu420S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AA215060;
	Fri,  9 May 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813470; cv=fail; b=N87yjSZVN1d3rknpcvv119eFJWnPYt0rluzso1QuP5oGGmT0fnscByzrU2o27T02SBnrjUK2fGjjM1AQ0GTxKbfuq6F7gDybIAeyvHXnYQSbGrsPK8Yzu9f9BWY61XKoykLAwm4CkqA9ZPFNme3V9F8DL1YgCbtwFP6z8nec77Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813470; c=relaxed/simple;
	bh=gsc2eU9ayQOj24C51qQl9IV2yjb1lYZxf/4wBh3fNtU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CrGjAWZFyVx5+2XdMal8SWDg7+D3wJk5OksDXaLntWwwKx3Pij/9hBtLobnGVM1gkYHlCOR+K9HyY2x6Y55oO4FbbO0AG+Ix231W0s4c5zFSBFPAO9CUJ8mh/gK/YgXmRQv5DQ9RWUC0uTWh3YBkUo4UkWyf+WkKo/jckl6ANiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4kgu420S; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxyNgbznqZ4ajv6u0bD2nA01pyhENDIRaD3mo1GV46SCmnIWxBc8Pna1zLC+MMbp4sT4Z0QyQSCKicUISJ2DQrVEx3YKFblrvDvuSs2TDiVbkENtOYSoLathuHcIMeeTPL6FS3RoFxprSDBwuiVR2yLDj1sqnYEAmq21jQVNkSrMZqc2umGkG2uiwbxs0ccDin9EZwV6G0q3rlonncH/SVPKW69Xa6OCFJ0Vj3XcY0Q2jzRM+4bi4vH30hgqZfpyJh6n44GX+vZhgQspMSDbNP16NBFmsTV1GCCnXzKw/c0H9KxUz3Rsi1vpdtx40LiWamRZzjTTU69v9RK08m5LZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XuLmGRgzKxFLebkVtvmHzVBZNVavpslTnFKqGWeIFI=;
 b=uOiaTUnnNa96wpzSy6YSWdMXqSNbHdbS4Iom/MFH86sAKbMZvbnZi6PwVQvejrir3vtPhZpn09gP4xSWQJHPk3nGK8qy095rA6ETLO7qIDWvmoyB+cp6+limrLE7Us+zigljlbG39nS2znIRRxL6uvlA/+dzpQlKFo+TqyAdopgA9doh9MGjrQWbQJ+HQ4nmnMD1aXvtH1L8LbyP5ehVCIWLWdRHFfQDA4o99RGcqhY/0M/iG8Q/cIK6POIh/QVtOmZZceC7vPgvSufSS/VDSNAR7O6YcOZb5NIUuCKy600qzD4MhDwL/F5c7ElX8iPP4PixjLCFrDbdk7DXD9lmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XuLmGRgzKxFLebkVtvmHzVBZNVavpslTnFKqGWeIFI=;
 b=4kgu420S7X8UwZGTQAVjfbuDUyhucuIsobWCV8xPSowb5NouIvwXeHUgMM+qYTVFnzlNvuT5R2lbjKiM9tsxX1fQhL2upOnQ8pYxmz0qVRcg/GCZ6pNJhlSAbejBwMG4cnYc2BYQHi//p97azV3wJEVGnkGvVe0UBsG3rsa1jGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 17:57:45 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%3]) with mapi id 15.20.8722.024; Fri, 9 May 2025
 17:57:45 +0000
Message-ID: <2d6b64ae-eca7-ae1d-1695-4c2697a60616@amd.com>
Date: Fri, 9 May 2025 12:57:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] KVM: SEV: Disable SEV-SNP support on initialization
 failure
Content-Language: en-US
To: "Kalra, Ashish" <ashish.kalra@amd.com>,
 "Paluri, PavanKumar" <papaluri@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev,
 "Paluri, PavanKumar (Pavan Kumar)" <pavankumar.paluri@amd.com>
References: <20250508225257.9810-1-Ashish.Kalra@amd.com>
 <03114e3d-ff0b-498f-8aec-00a26276785b@amd.com>
 <e71453cd-3d7d-4c7b-b763-3e47236ac955@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <e71453cd-3d7d-4c7b-b763-3e47236ac955@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:5:80::30) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2a293b-3c07-4999-e360-08dd8f2300a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGpFZkJ6eXRscFMxQ3NpZ2hQMjZybzU5S045M0pWa2RNZEQ4aFd0K0tDZDA4?=
 =?utf-8?B?WmR2U05yTy81SzdWQnZJRDNiQi9rbUUyYzU2VkgySVZmV2RITkFqay9hYnpj?=
 =?utf-8?B?V29xVUtFcXlhZTViME9DemdIRVREWHdvU0taVDErR0VaNXNITDR4ejhPLy9q?=
 =?utf-8?B?ZUlzTEVnZXRGcTNmeTgydlBSUWxDRTRmaHQwMkFzbVJjQXdVVmhSTHBzUFdG?=
 =?utf-8?B?NTFmaEdjaUtpYTJhMVJMNnk5YnFIMDhrck13SkF3N2V0ZkxWTkNUWTJLS0NH?=
 =?utf-8?B?ODU5RW1QL0NudDFEUS9rNTBVL1dmVjhTbE9ORCtpNGhYN1MwdENCbUI3TU45?=
 =?utf-8?B?aHdzUkZFYi9MQ1NJWWI1QTlCU0hJdi9JQThiajloS09JME5XbnllbTAvbGtr?=
 =?utf-8?B?bk0yYlJETmpCb1dFVVRENVp3eWtOMVBuazJqUXdNU1laTFBQMmNOVHg2aEEz?=
 =?utf-8?B?TWhCOWZITFpHU1dINWI5WXAxQVpsaGVxaVBBekV3Y1owOUxSTXl3dWo4VmNu?=
 =?utf-8?B?NDBYcVVqcXh3R1lvZmVpaWRXempaMnRWL1I0VmwwOFRQRXRyZ1NlMHE4dHB1?=
 =?utf-8?B?OWI2c3Frcy9GU0tmM0ljRkNKSVRYSDhDT2psSmd2eHMvcDVseU9MNGx3Wisr?=
 =?utf-8?B?UmY3K0hoQmVCY3hHdTh5SFgzTEVWcHhhbC9admVhR0RlNmZISGFuY0x3UVlu?=
 =?utf-8?B?NGxZOUZISjREUHJDelArV0VpQ1p6N3N0Y3g3aUxRN1BkWUdyRUxtamZvWlli?=
 =?utf-8?B?bVNBZXFUQjRaTEFNWEJ4dWZJSkg3SytEQ1NUREVSbmw3Mjc3cFJ3VVpXSFFG?=
 =?utf-8?B?SVNXSlVCOUxldlIyQng1dng4VEVFckNLaURBWEdUQ0hhQkdxQjEwbmxoMzZm?=
 =?utf-8?B?aTJJbGV4OXg5Y2NzNlVoOHFsdFV5dWtyc1dXSlQ2K3k5ZUxBTFcvRU1hbkRN?=
 =?utf-8?B?L3JXeEdhU0h3Y2luSGF6T2Y2WFZhVUYzcUlCNVc0R0VHblJwNnJJTWhuM0VY?=
 =?utf-8?B?MTNUYmhZclczR3BvYXh2UFkyRzd4VEhwcGZVb1ZuVTIxck1PaFJDWjQ4UXJs?=
 =?utf-8?B?VHlCbDMvY2FuV1E5N3IvRlZjYU5ITUw3d0VYOEh5WTNIVCt5cXZ1TGhCWVFx?=
 =?utf-8?B?L0dmRjlzUmNSTkhtN2piTHVMcE1oaUI0ek5jQzVwNzFzQ2luOGZzOTVuMUlm?=
 =?utf-8?B?UEZ3VlN4ckExcUE4emc3UFhpS2JBN0F4czNCQVdhM0hzWHdPQmxNQkx2MmtP?=
 =?utf-8?B?SHZ6TGx4VFVDc0J6OXpRWEw2c1VhRnNWd3YxV0NoUW96RTZML1UzbG9Ib3Fi?=
 =?utf-8?B?TG9VUHV4UmpQU2twZXpEWVo4TzI2REhwaVBxY0hVZmFSWHFxMlY2WXRVTENT?=
 =?utf-8?B?TmVhVHBPQnpubWRnSzVpSjBJM0RvLzZTRFgwbW5RaWp6cWtmUmR0TmppZ0Vk?=
 =?utf-8?B?aU0wdU5sOWlKSDYyNVpnK1ZCQmVsWS8xOHBrUUh3NzFMc3ZMYUY1WnIyWWdw?=
 =?utf-8?B?MFk3M2pKL0lLUGdVeGFCbFNFbi93QWg4cVMvc2RjbFdYeDhacDR3V25sOFFH?=
 =?utf-8?B?SS9wNW1IWEtmMG44RllzbEQwckE5UUMydGF0SGlmRVRTb3pUamFwbW96T0xv?=
 =?utf-8?B?Sk1WOHlLYzJaaHBtZkxPMXh0d29UcFNvd3pJLytHZ0ZIM3A0RUZSNkM0bHdt?=
 =?utf-8?B?N0pkRVdJZ0QyUE9FSnAyVi8yMlhPK3hlc2EyZDFpbHdaaFMxcm1IZ3EvUTFM?=
 =?utf-8?B?U05WcExwb000bDdEaWoxQzNNSUJDZkNaalp6a2JrK3kzOVM1ZE5NQW5Vb0FC?=
 =?utf-8?B?amlOUUxidGdkczdUaW0zeEp5cjRuUHVvVXNsVWhHUStkdGtMbTZqbDJEOCsr?=
 =?utf-8?B?b1A3SlhTeEowS2VkZVBvbVI2dkNmT0Nxb3BlYjdNYkxWZ3ltZ1h5c243MDV0?=
 =?utf-8?B?dlJ2akRMU280U1ZkUlpDN1hHOEtlck1jYk9VbWc2THZwWHBJVFZvUXloM2JO?=
 =?utf-8?B?bEZrc0tCTDlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS9SYisxY29rQ1VRL043elB5QndiZDVkN2xLWEpJelQwSzJ6VlQxTnRPbjhZ?=
 =?utf-8?B?VkkrZ3ZUb1lSQVliNjV4bW5JZzNGYytRVDdRa0RTNEFVcTNvRiswdi8veVoy?=
 =?utf-8?B?V1JkUE9YQVlrUVlSMDkrSWRXSUR6aFRiZE52alltZlVJNkF3K2lvVEhkajY3?=
 =?utf-8?B?MHptSTdKMTR4Z2h1ay8xLzU2N3NYdk5JQ3RTTWpWdFhYY2ZSMG9XazdRS054?=
 =?utf-8?B?aXR3THhHL0UrZlFDY2ZiR3NHVjZLNFBnL3IwdWFlRjhFOFVibGRua1BvRHUr?=
 =?utf-8?B?a3A4NkZXMnNDbFpjclZOMWdWYitKcHpQUzlsR2ZUdEJ2SlhVdlBOZWdQaGNs?=
 =?utf-8?B?Z1FheUpmZGRFQURiTWljTmIvSFhrNlhmUXdQR25jKzAvbVNHTDI1VVdxZDJi?=
 =?utf-8?B?MkNRMjVPNHFhM2FJK0hMMm1oY1RxMExVVWMxV2dXQlArM3ROWTJyb1BUVGVB?=
 =?utf-8?B?eWdsRVo5cWNRYk95Zm43eHVrYnoxbkJWakh2eEl1QVR5Mk5tSlF2N2lUZzFt?=
 =?utf-8?B?MkpvSnVOYXRmdHJSVWlGV2g5VlRsRU90V3J6VG10LzJuS21WUGZoclJpVmdG?=
 =?utf-8?B?K1JMNGUrOWRWY0VpSkNSNkJKdTJTbUNobm1JNUZHTHc0b2hRUmJxSnNkM3cv?=
 =?utf-8?B?SXdQRXVqK2NWaFp3THdtSENJL3dhb2FHSG1qV2tJRWtPU3JHSVRTVjlRMXhz?=
 =?utf-8?B?b2V6UEdmaVVuNWh3cmxQV2dlZkVKOUw3RllEYXJNRnI4bnhaNHhydi82dzJu?=
 =?utf-8?B?K2ZZZ1daY0JHbStpTktZRXBYbndZUFlyUlRWamFHVThOdGNvUFF4MThySzNZ?=
 =?utf-8?B?bEhQOHlvYXdYVkpPQmE0NnN6OEZvczA0d3BuamhueFVEZ2czUGxmRGZ2UXc0?=
 =?utf-8?B?Qy9hdXppTENXbGozdWhMK1dobklaVWlFZXhPQ1Z5VGxLZW5qbnFFWUxDdkhR?=
 =?utf-8?B?eGFDMGF1NWxzSGY2WnJZR2xhWGJIRjlPZDV2Sjl5Nk5mby94aFVCYThoZXlP?=
 =?utf-8?B?WlFKSHUxZHR2T0Z2b29uSnF3b3Avd3ZIT1FNaGlGYm5LUmhBbTZyQk13WDV6?=
 =?utf-8?B?YzRPQmsrd1RRZjFkazNnTk9sYWhGc2NOYmhmaWhFZ1hvZHRUU0RQVTRqOUJK?=
 =?utf-8?B?d3k4Yk00N0lYR1M4VTFTbmlVbXNXa2ZJdHFtT3lzNERKQWlZZmgrWXBOT2o0?=
 =?utf-8?B?NGZVVVdSU0VvTStzWVFXUVN0aW9IczY4SC9FNlFBVExqbG5oY0NlSEZ3RFFt?=
 =?utf-8?B?UUJ5UDllSGJkb3ExQ05OeEliYUw2M1pOcVFxMVpLczlBYVkxaFUxaDJKMi9t?=
 =?utf-8?B?Q01TeEJETWpuZllNQnhGUFR3Um5raU1wQ2Z5NDlFTHRvdWRIZysvK2s2QVk3?=
 =?utf-8?B?TVozSDlpcUJBb01mMHhqb1p2ektjRktDS3pHSjVtRWFDQklBMU00RWpxQ3N2?=
 =?utf-8?B?MnBMazF4a3lKVHVRSkZybSsxem5NQ2grdzVzRy9BNHdaUlBSUEZ2OXVtaCsy?=
 =?utf-8?B?c1FEZUlRSUxJaDA1YXdMUjV1L2NGbk1JQ1c2QmFBSUdVeXM1bGUwWGJkL2pT?=
 =?utf-8?B?OFZySFRhb1AzOElpc3ZFc24yaXpxM3l6N2MzTS9pY1BRN29IVjgwMkZWT01P?=
 =?utf-8?B?RHhjY1pPK2hjdThEM3JVdklOSTJzVG40YjdjVEFjTE1KdzVsLythYmZGVnRI?=
 =?utf-8?B?OUJmOXMvdDVWb0dQT0xBZU1XRFhrQW1YVTIvUGF3T1ovNWFUWlArVGlVZXdX?=
 =?utf-8?B?eUJYdDZmTmh0YUhpRFVWY0g4Y08veHp5WGNuNlo3R08rWjZMbTZsdDJwT0I4?=
 =?utf-8?B?OGxuaFF4VUNWaHlQSmhMdGt6b1lmU2xWRTJwRlJ0bzIrcjJyZGk4dGxEcDBV?=
 =?utf-8?B?aVJ0TEM0VG1yUWpWMDlsZURsL29aN2ZGUEwwcms5ZUhJZ1NBK01NRDdtTHg4?=
 =?utf-8?B?YmlIZm05S1FOYk9YMTg4Rmc1L1JJTldiTmVENHhCeW4yaDh4YTFBNUxTWUhG?=
 =?utf-8?B?YXYwcFh6QkEvbkIxRlZBM1Z6ZURIU3R0QkRJQnNHdjluZ3dMR2pMN0pCRFh4?=
 =?utf-8?B?QmlKT1ZGa3JNS3JVYmtJcHJ6NDVnV2hzUXV3SW1kYWNkSkZxdERLQU1tcEZD?=
 =?utf-8?Q?sTJqnwnjFIYQrCw/USG5pFXAI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2a293b-3c07-4999-e360-08dd8f2300a8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 17:57:45.5870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiRpBIsw1AUEclmzHGOTsGcz/n2XFPTyzM9kPywjHM41IEzA50SyIshu7h7CCmPKV3qZECmuabasIUO56cDI1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

On 5/9/25 12:52, Kalra, Ashish wrote:
> 
> On 5/9/2025 12:01 PM, Paluri, PavanKumar wrote:
>>
>>
>> On 5/8/2025 5:52 PM, Ashish Kalra wrote:
>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>
>>> During platform init, SNP initialization may fail for several reasons,
>>> such as firmware command failures and incompatible versions. However,
>>> the KVM capability may continue to advertise support for it.
>>>
>>> The platform may have SNP enabled but if SNP_INIT fails then SNP is
>>> not supported by KVM.
>>>
>>> During KVM module initialization query the SNP platform status to obtain
>>> the SNP initialization state and use it as an additional condition to
>>> determine support for SEV-SNP.
>>>
>>> Co-developed-by: Sean Christopherson <seanjc@google.com>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
>>> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
>>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>>> ---
>>>  arch/x86/kvm/svm/sev.c | 43 +++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 34 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>> index ada53f04158c..a6abdb26f877 100644
>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -2934,6 +2934,32 @@ void __init sev_set_cpu_caps(void)
>>>  	}
>>>  }
>>>  
>>> +static bool sev_is_snp_initialized(void)
>>
>> s/sev_is_snp_initialized/is_sev_snp_initalized looks better.
>>
> 
> Actually the convention is sev_is_xx(). 

Except that it is a static, so doesn't need to start with sev_. See
is_pfn_range_shared(), max_level_for_order(), etc. in the same file.

Thanks,
Tom

>  
>>> +{

