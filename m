Return-Path: <linux-kselftest+bounces-24317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7CA0B129
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3782F165661
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB86232366;
	Mon, 13 Jan 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIS3dOoP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DD78F49;
	Mon, 13 Jan 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757184; cv=fail; b=o+wryx45x/0hBuVbhKJC6T+a1fS6MZv0uu+LVeXB1oA/WNeLGThNSkIZF9034DfoamNLKTw/RncvjpFZ4hohF5xcc4WAmQP45Pv0gIk/MQ/YDAwEYFbYvjqGw3I6X356HTS6Xx/99CcJgti0XjsGsxZUHpjTJcc5vgRP2x81cLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757184; c=relaxed/simple;
	bh=BNK/3N3lEHB8Dm7Hldw7mYJNiyRFg6s9UcmoIuzYnjk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=puN+cHZ2j3RU18IYNojz7vSPmCbj0A97M45y++6/PrXaS1nnXFvGt4umH9w4nWr098RFjxsbJkutdgPHCdvdWt/LWcnhp1sDCga3oSp9mOx/lyGO7JHbIfmzJQvMDfLKIliUAsZVwG3408AQD6UQvCEW8uHQ6QWnpgYhgjLLMb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIS3dOoP; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjvq3vzKnfnf6lQE+O0S8jtG/q9fVk5uN/j6yeC3MHYWltB/hk+E5WpaUkvopD48meGqPSkDrO/8PCeGxt6i/Qvtgx3KuNczsCy7U+S/e82eNHngEm1tawLbr1wAnnbmai7TOb+oOGg08gJLkT2OqtNFbLNJtMRaKAz0H/HNkJrJEPzMeSsfojVr7s1bhVCHY0ByZIE0z6yHV1YKVeiqcasyVyYDth7X1o9UM+wgEi3SrXspySBCJ90EKQA4Y1nDqv075NMNPGSdAXo4mkaPuVdAO8Z+Pe5b5TJwi4wS+nLSmnq2q8GWffl2You6SnPs6zEkN/q7nfUqb+aWJNq+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQOPnspPywHMNYyvUzVeP6MOxVN7mh5/LQwp5/Qz4jk=;
 b=mWapIqgzaMITey9mzxAyv61jRQ5ipCSR4rQ1Wc/yzfvsnELu354RyM7f13yMtQAMITFxuf21gK00cXoeOCcD+6xs3UXyu13vELLmTTLDIg+WMhgLzlEVzl0Rq0lBebP94mb5deuEZjMH2kH11KzdvOfpDEEpS+K3U+zM8JrNvPWy6WkHJV7kIxj0x1aVsqVKWcwr+/QqRBr7OE7Xrn2e6V+51BwYNpHjuoXzWrzSDG0SihtSlDZPWTB3E7QsX2a9C1i9s6AO2syE9aRj0o0qrJGaR3erujIg7fdX5FyOzsPaRylV3RBJwFUMnVZXfU2uXuYhvxmiwHa60kqDu3Evrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQOPnspPywHMNYyvUzVeP6MOxVN7mh5/LQwp5/Qz4jk=;
 b=CIS3dOoP680w2L7hc8Avp+qPL/eQmWuHAk4I0DaX7dkVp6Y1zsKCb2yahEoM8jMLz+Q/Gf7BrfNY7uJy/3IQKmOJaGa//UiyGbM/gsfEa0LjCraZrQqXZGC0gurneYF2um4O80H6GhO8avyIJrOTm6L0WLW0XavINvl8rLCYdXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 08:33:01 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::b890:920f:cf3b:5fec%6]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 08:33:01 +0000
Message-ID: <a5aa635d-b03a-4e77-aa6a-032886d1bc56@amd.com>
Date: Mon, 13 Jan 2025 14:02:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] KVM: selftests: Add library support for
 interacting with SNP
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114234104.128532-1-pratikrajesh.sampat@amd.com>
 <20241114234104.128532-6-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20241114234104.128532-6-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::11) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f731757-7238-478d-b09f-08dd33ace3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3Z5d1AwejNjY3lGUmxyNWcyZVVnZWppRStORC84cXVaMjVDWVRFMHl0Rk5H?=
 =?utf-8?B?bmw5bkpCelVIZWJRWEQxZzAxV3YrcHlhNDI0TEVkcmVTRXBDbjVIZ3FUbUsy?=
 =?utf-8?B?c3N5TzJPSEoycnA5ZmhsUjd6aHNiVXk0aXA2RnZzZER0SjJVelRLSm45eWJK?=
 =?utf-8?B?NTB0eWFzOHF4TkpNcXJ5bWpwZWpmVGFTQVNaY2xFMWVkVGJHbHcrME5tNEha?=
 =?utf-8?B?QUJLb0FnUlNOSGIyVUF1djY4cVJYRVUvSC8rY2J5Zjk0dmFidU0wdmUvN0xP?=
 =?utf-8?B?U2ZXTUVzS3MxL254VzZ3blVvNWpUUTkwZDBVRzV6Z2pDVDZONXhqV2Rsb2th?=
 =?utf-8?B?YlhkWG4zVDZoMWhpRC9UM2JkTHIxaEFCeXV0aUh3UFMzQXoyVGVGeHhrdWJa?=
 =?utf-8?B?TGdoOTFvMUNDcHpCOFBrUUQ2bW8wTmxSaU9UUjFHV2Z3bVFSZ012VEpPaVpl?=
 =?utf-8?B?bFdiaE5CMlpDYmgxczFaUFc5SkJCWlNPYS8zK3U5WFRBbEV4ZGJQbnZRUlk4?=
 =?utf-8?B?bmwrd0VZQWNMK3cyV0xNTmh2MDJ3OVM5RU1lZVQyeW92c0s4NzdlMnZwZUJm?=
 =?utf-8?B?eTdiNzl6bHd2WXZCUVVySUN0WjlpTnJpVUpDdFNNa01UVWxjeFFCUzB2Q2RR?=
 =?utf-8?B?KzA5aUFqdjJIeFMwTThuNHU0RGpvRExackpSUS8vdGF2cjc4bDhPVlNnaElN?=
 =?utf-8?B?R0VqTi9OTDg3SWgvdUhzRzhsdHJRTitiM1BHQVFVYzd1ejB3R3gxcHBHb2RP?=
 =?utf-8?B?bWR1SzdNeVRCUmpTYzhURnVqM3pKRlZ3WjJjcW1sUjd2UUpWcElnRjF0QllN?=
 =?utf-8?B?NTZRd3psMEgwcS9VQVRLaFY5S2JhVG5vVjl1ckh1NzhQR2I2d3BKMUlrOVor?=
 =?utf-8?B?NlJWbm1XRll2d2syZjJYd29VUnExekNtUzlGVXdMU1JteDRmbDcwWU8zczNS?=
 =?utf-8?B?M0RWTTBtWnNyUnI4TGZyVzV4T3V1TytUcE9SNHhOWTE2bEVtajhBTG9Oc20x?=
 =?utf-8?B?bUp2eVVTZzkvQTNqb0hyc3VWTDBqYTExenJuc2ZHZ21FbnhMdlFmY2Z6NXBa?=
 =?utf-8?B?UlZQa21sV0cvUkVVbGs4Yi9QYU9hWUNwcjZuVTJGUzdxTDJVVFhTZTlrY1lr?=
 =?utf-8?B?a00wR0JtRlgrVzNzNE9FZzlSckZiSmZNbklyUzJLUHJRY0U1YVVSM3RlRXY5?=
 =?utf-8?B?TjZQMXhvN1o2U0E3QWg3T2FDSWtvZFU4VEtWZ2VZNW1Rb0JKRVVDMkw5d3kz?=
 =?utf-8?B?RnR5eGJrazVQZG9Wc3hHNnVwRDI5T1dmT1RKOFNKTmUrUVhoV0Q1RHkwd0N2?=
 =?utf-8?B?MHlnWVV4N0dRS1pnZWo5dm9ER0NPTGRsVkh3MGNWNWdSeThpYlVvOXJkOGlw?=
 =?utf-8?B?MTdlVEVETXY2S3lETk0xSjlSbnRUT3VDSlVYQm12WlBOelozTzkvM09ZSkZS?=
 =?utf-8?B?bHMrWmNoK2EwRXVZUTNWYnduQzNhZXNCZWtlOUlvSkM4UmQ3YytlNk91amk5?=
 =?utf-8?B?MlpmZHdzb3R0a3N2UXJKL3FQMCsxUXhPdDduUDI5cHVCWWU0RkUyZllXUXdl?=
 =?utf-8?B?R3lXcHI0OEw2eGZ2UFRGWkJaNUU4WEQ2SUJtSHlQUFpxRWQ2ZkFqa2paZXhn?=
 =?utf-8?B?RklGRGlUMk5ZUWYvbFdSeGljaURBdVpaM3BONDNRNXA2am4xRXhSN2pVeFVZ?=
 =?utf-8?B?allOTnNFVUFDMlo5bGMxY3VqRmFpeGx4NWlKdjFVWTgxam9keCtQU2pXMmZi?=
 =?utf-8?B?alh6dnBLRUlyWTkvMlIrK2gxMlNqM2lVNHU0WHVyUjlZTDlRZVZPR1QwUFBa?=
 =?utf-8?B?a1F4YkF2aEVFWkpYZnBsL2ZDelFCWUM4bE04SDdXU1I3ZVc2ZnJidHA0VGhw?=
 =?utf-8?Q?nUueA88cnKUjr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2lqcVBBMzBqVFNBS2N4UFlibmJ5UkZHMVZsWTV5cEcrTEdaOUZRUHJTb0lp?=
 =?utf-8?B?d2E4UjQrMWN6R0d2VzdZc2xVdVRWMXBkbUY0b01RVWVienhYeUFJSWE1U0Fq?=
 =?utf-8?B?cTA4V1VWT0RiS2xqbXNsU1YrMC85dEl6M2VTUmRZWHphN3E1WTZqNlhvS0lF?=
 =?utf-8?B?bTY1cDZPSEpFQTB0em9pVXBkeEI4VDROdFI5NWJ2MFliQmZhUThyM2RTSEdP?=
 =?utf-8?B?TXBoUm03akF0c0NtK210SVVpUFpBQUpkelBVd29iVTJwdlh0WC9LRmxET3J4?=
 =?utf-8?B?ODhtc3NLMnBvQ21TL1g2UU44V1k0TEM0SkQ2dVNIQks0UjU0N2Z4ME5Dc2Y5?=
 =?utf-8?B?TVVCNzFVd1pDVWVncWhwcmJkK1ZyQlkxTGNwYmdZUnUyZEhsSmExM3BHOWtZ?=
 =?utf-8?B?Y0M5b2NHOVVpUUhadjY0eGlPWHhQRkJzaEVPTGJ6Z0xPbWZ1TXAzT1dBWkND?=
 =?utf-8?B?Y2luY3QzTTkwVmdENXpvUisraDRRN3hwNk5tcjNZYW1rVzRIdkQ5RHVDUmhO?=
 =?utf-8?B?WUtqRjdXL1ZRK2hsMGxxRWZYZVEwbHZ1b2Juc0EzK1loL042MWtlM3hveUU2?=
 =?utf-8?B?V3VrSEJKeDlsY1VHT3F4OEJJQm42My9wRFVIMjBHUjRKcXBzYjVZK3FIQWFL?=
 =?utf-8?B?Z014amdFbmR0SmVSRzdXMTJHQXY5dVh3RE5kU1BhWTVSZTliK2xOTVYyY2lV?=
 =?utf-8?B?S2N3ejYwMkl1S1R1MTJzZE1iWkl5RVZ2RWN1cTFvb3o0NlRja2k5RzRrdFF4?=
 =?utf-8?B?ZDB5T2tDOVh2eUo1QngraVRyQytYZ2ZnZEZYVEpEMzNDaFM3S05nQ0djMEtH?=
 =?utf-8?B?TWUvZGcrN2EvZ1F3YndsbzE4azhwWlFDUTcxT0cyTGpLci9sNytMY0J5WDNX?=
 =?utf-8?B?bnVGNy9hZGpjM055aXljYTJHRUltYnNrZ1VNYTdPVmo5N0w4MDFmdnlybkRP?=
 =?utf-8?B?dEcrQ1ZEeWhFdkd1NzlBSWZqK0hJbDZBUkd4UXFTZ1hJa1lVdnZKNy8zNExO?=
 =?utf-8?B?YklOSllzRTkxYU94QmZ0azNIdTNtVlNJL1RIZWZTZmc1Uk9pK2JWQ3Qyb0FT?=
 =?utf-8?B?Mmx5eWdNL0dERkxYVzhFd1loUmlJSDZxSlFTNEdTYUxCd05ZN202NWtZcWdX?=
 =?utf-8?B?b2RXUXhUYkVtR1lFbDQ4YWlsdlZpMEZnM3Jib1UvVEFxZzRSMTlHekdoMFFx?=
 =?utf-8?B?UWIvdlRQSThyYW95RDladlgzOUdrOHI5VlVlR1V2UmtaSGE3dFE0d0lrVCtO?=
 =?utf-8?B?Zkt4eFUzZ3UvVyt3UzNjbnU3bTdhK2l4aEdranhLVzJWZjNVYXgyZHFCV2ln?=
 =?utf-8?B?WFNLVXFYUW9OcWdQMEFSRG9hemNjalBoS0VPYnhCdVNFWVFxcFkzRFp1SjF5?=
 =?utf-8?B?SFZQc0ljbjQ4WWNHTVRJUW9mVldWaG9pL0xWMVlnWkEzK2xjbklLMFlZTzNR?=
 =?utf-8?B?c0I5L3B0SnVNZnljbWpBYS8wVlRaWFdXeUJhQkg4Y01NYWFmWFlCQ0cwWGYw?=
 =?utf-8?B?Qmg3M2c0T0sxZkV5Y1NSU0R3MHpTMnhZWElTeGorL3l6VmVHdjRuRDEzZGsy?=
 =?utf-8?B?cm5JMjBockVMRXVGVHR4eEx5MUxHN0ZzZThFWXp4OVU5b0xvY2I2cVZoZXpv?=
 =?utf-8?B?dHJUQTZyWGpWYWZUYVd6b2FnNllKdmhjY2tXYVJDRlRlZTNwUFJqS2s0SWd5?=
 =?utf-8?B?Mkl4S2dyRGpnb3hDdUZOM0JyUFA5UWh3U2prbVVEbmVhTi9mUGFjYldKR1Fi?=
 =?utf-8?B?bzNrK21FZlNOZE1NOWtBQm12ZncwR2kvUXlmMWxaM3c3Zm5IbzdDNFlHVnl1?=
 =?utf-8?B?VnpLWTA1OVFNNVFaL1lJMHl3NXNmdy9JMUV5NWRsUUJ0WTd1cVdwS2p2NUV6?=
 =?utf-8?B?Sng2MldRNldhc3pZRngrV0w2OUpJMHZrSG1KR0orSlVHakVPTlFlQWlPV0p3?=
 =?utf-8?B?QlE2VkdVZXo1WThRcEtYY25DL3VaZm81aDZCdlU3UTFobFlmTEN6YXRXc0M2?=
 =?utf-8?B?NGZmWlFpUGNWbmZaQ2MvcnhXWlF2Zjg4U2p1Sms4bDNrelJjcXZublRKVFli?=
 =?utf-8?B?b3NyV3NCUnZvNFo0RjJkemI0VGlSK000NG4xVWtNalptcVd1Znk0WVBYa01w?=
 =?utf-8?Q?WBYMmW5GOpPWwTLDQNDniMYPo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f731757-7238-478d-b09f-08dd33ace3f3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 08:33:01.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOvOI/gjN/u0COrH7EOVmcbXuRln0A4oo2RABW22T4+/c3c7Au+wA2J6lsjo98oxvFBJ793hHkaWuZCMHRnC2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988



On 11/15/2024 5:11 AM, Pratik R. Sampat wrote:
> Extend the SEV library to include support for SNP ioctl() wrappers,
> which aid in launching and interacting with a SEV-SNP guest.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/include/x86_64/sev.h        | 49 ++++++++++-
>  tools/testing/selftests/kvm/lib/x86_64/sev.c  | 81 ++++++++++++++++++-
>  2 files changed, 125 insertions(+), 5 deletions(-)


> diff --git a/tools/testing/selftests/kvm/lib/x86_64/sev.c b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> index d6e7a422b69d..40b90d3a5769 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/sev.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/sev.c
> @@ -31,7 +31,8 @@ bool is_sev_vm(struct kvm_vm *vm)
>   * and find the first range, but that's correct because the condition
>   * expression would cause us to quit the loop.
>   */
> -static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region)
> +static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *region,
> +			   uint8_t page_type)
>  {
>  	const struct sparsebit *protected_phy_pages = region->protected_phy_pages;
>  	const vm_paddr_t gpa_base = region->region.guest_phys_addr;
> @@ -41,16 +42,39 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
>  	if (!sparsebit_any_set(protected_phy_pages))
>  		return;
>  
> -	sev_register_encrypted_memory(vm, region);
> +	if (!is_sev_snp_vm(vm))
> +		sev_register_encrypted_memory(vm, region);
>  
>  	sparsebit_for_each_set_range(protected_phy_pages, i, j) {
>  		const uint64_t size = (j - i + 1) * vm->page_size;
>  		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
>  
> +		if (is_sev_snp_vm(vm)) {
> +			snp_launch_update_data(vm, gpa_base + offset,
> +					       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
> +					       size, page_type);
> +			continue;
> +		}
> +

Instead of using continue, if/else is the better code flow:

	if (is_sev_snp_vm(vm))
		snp_launch_update_data(vm, gpa_base + offset,
				       (uint64_t)addr_gpa2hva(vm, gpa_base + offset),
				       size, page_type);
	else 
  		sev_launch_update_data(vm, gpa_base + offset, size);

Right?

Regards,
Nikunj



