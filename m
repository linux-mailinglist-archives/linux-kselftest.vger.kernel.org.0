Return-Path: <linux-kselftest+bounces-32880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29888AB46D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4238C0FDA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73013299951;
	Mon, 12 May 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5rTT+9w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525024EF6D;
	Mon, 12 May 2025 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086934; cv=fail; b=A0in/yLDlq4gD6/bvlDs88bqlI2MrEFFAsnRCQyf/KnwDG7Xn0se8liwQCTwkJ+XLbjw1PMJg/2JzXN9YXwZ04Oucw1b2QzectgKBIvdwzQ0gWF6gi0HZUbgwhztMTkaQUsfKJ+fWD5RMQxxK730nzj3fRS65OkQ+sE5iGi1QzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086934; c=relaxed/simple;
	bh=z4wiO0U8+oYhDMil6CvibPh+v949rIG/xUSru6e/bfo=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=gVD/Na3Vw7Z3I7SJyfIefJ5o9Hl1bAwp9kYxVZO0XQ+17lpH1oupabt5KuBxTJqIHlX/f2EUQkyS2G7q+gPfHitTjNpqgiO0QbsgbePFUes46SlI9Poj9Jv+jqyEfuy0vYvBGHQebhnqTK0+XTUcfgjK9E5FMEo/7RsNuXYKB2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5rTT+9w; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0FhfJJ80GcaZYRwbvZ40UOnrLMIeGggqmHxdFu0mWFYmLJBfwo0ZgSkHtPae2s1BEShADVZ5WjD9UCzW3dhc/XzohK7TK1Gc0Kaw+yRaZKvZ472ZnpOxeZTnpez4WGIMct5LB8BdYNQFGDXcJFpSsau+Gg4LDkB+kON49eHibyrTi2CFFkHFjy280BFzaYB7GENsj9YkKobxr4ZqoYEajWmGBq+Q2ycJypEGGvKYSDdbxaGVSCXDv7AYkL5HQnPqzrsBvj7lrQ0lw/jGvSIqn5aQWa1VebjBGmLhVkF7bhSr0UdGpXcZVYhWypQ73+IDtmwLoux8u9V3j2vnHUvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLYL00mVQTXO+8MhmgIAg+AZUppo4xX48gUYePXUuDo=;
 b=JkF2tjI19ExJHW7haxToBZREVGG3gpqJpPHbxVOeVSy1A41hdY4D22iN6bonEHgP8Lc8XF7aZBW+2MUa+q9j0ub56kXu14D+ajf3WS2fTzWOrXHmONW14AWgEY5rv/2zfEfBqSU/YqKBJw17O7fQ17aRU/lODrYRlJGe4tmJ+rHNnKmynhakA4LeluodYMMLGbjrh4+Y6Mk4CLkIf1daZOoWAjWGgMs0C4LgRGvDmZGQh0Owubvkm08xaVm1elkDm4JxhJIdpKa69SJzw1elewsoCTAusPq7Cy/XZTBGtLEbGPHHRbQ9uIHib16gtkGHcpRpVamwfGWv0LbRZ/o81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLYL00mVQTXO+8MhmgIAg+AZUppo4xX48gUYePXUuDo=;
 b=g5rTT+9wPVhImedj79INwLI8/Se4EWgO0eB/fySrbb9ebX1HFVYjGKvXjpC2mgawvjC0btcQZDruDz6gEpNARDq4RKPPrunPzc5X0EFRvmtSTSqLxfRNgHg7dj6M8cacwWV5/H06+PUl6TjfGFU5CvEGYnjn/Yy5WeOsLWv6yUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 21:55:30 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 21:55:30 +0000
Message-ID: <ed6cf930-bb1d-d082-a1c7-f5699ec46565@amd.com>
Date: Mon, 12 May 2025 16:55:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, seanjc@google.com,
 pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, shuah@kernel.org, prsampat@amd.com
Cc: pgonda@google.com, nikunj@amd.com, pankaj.gupta@amd.com,
 michael.roth@amd.com, sraithal@amd.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250512210410.10172-1-Ashish.Kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] KVM: SEV: Disable SEV-SNP support on initialization
 failure
In-Reply-To: <20250512210410.10172-1-Ashish.Kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0067.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::17) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: cf04216d-21ac-440e-076c-08dd919fb619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0VuZW5lL0pySFNNbjhCS0JmbGhZcVFnN0VJbTd1bVVoUHV0ZUozWUpBa2to?=
 =?utf-8?B?Q0FJRmZKV2N3S0J3VnNMTWF4RUk3L0N1R0lCMmMrWlRsRWFqSzhmV2cwa01q?=
 =?utf-8?B?bFo5LytjN3g2S3ZLOVllTG95OXlUNWRIREFiU1pOMXVWVVAzS3RML2I2dVhn?=
 =?utf-8?B?N3hxbkNhR2FuUElQeHNZZUpoTFE4cGI3QUlPa3R2ZnN2VzNZUElHbDdDRW1D?=
 =?utf-8?B?MWw3THhQV2FGR29WRUROWFRXQThoN1JUSjZ5MXNCaktXeWQyNkZzV2Y3clMw?=
 =?utf-8?B?RzNQaXhUTWtKaWJPaU1HVDU5djhacHlvWElFUTJPaGZjSTJBRit5WlIrYk9C?=
 =?utf-8?B?SDU5QVYzRVVSdG0vL1d6M1NuYWZsbU5JR2NZdWdWT050TGNIUmN6MU9EQmNl?=
 =?utf-8?B?ajRaT1g3eXNwUGgzRXdrVC9DdGVEcVJKaHAyYzlndk0yck1IbnZqRDNEdzBG?=
 =?utf-8?B?b0VWQzRtV281N2dYakI5d09QSXdvc3FVTkpuRlJ0Z1Z0d3JUd2lRbUpFRjNP?=
 =?utf-8?B?ZFNsY2VPamJDaWtjOE9oSHJkWjNpeW8wdVMxWVozSGV4ZEh5ck95UzV1MGxK?=
 =?utf-8?B?a2wyVmRxVzJLMGxhNCs4WFcyS3FKcjd1dW04UXhrRlpWeFY3c2p1eGU0WURP?=
 =?utf-8?B?VzIyVlZwSWpzNWgxaG5wWGlkc0IyVlU4WmJpdWZpdDVYK252TWg1dW9rdnN5?=
 =?utf-8?B?dUVReU1UMUxyVmdkcE43ZmdUYzk5NFAvN0JjeWpUT3VWemZ0eWN4czdLVVNm?=
 =?utf-8?B?blJXTUdRbEJicEJ2a285OEtQR2NGQTByVDFobk10M0o4R0RYbGFIVG91Yklh?=
 =?utf-8?B?dkpGQ2luUnF0aFljcDlJdmlZUE14T1haWE10alRZalAwYmdmSCtrV21JYzZt?=
 =?utf-8?B?bmZmOFdhMmtqTjFjWEJiTGJkT1ZWUlZTZXppd3pMR2RnaHloeloyOEl6VEJI?=
 =?utf-8?B?TFpmbHlVNGRGanNoMHJxUjlwSUZ5RGNPUTk5Zmc3cTdmMm5tb25RS0RWdWVQ?=
 =?utf-8?B?dGtoaWdQTzNEM2lyU2pVMm83cGVKUC80ZnA4YURmRG1xRk9IQzNaalBiWE5M?=
 =?utf-8?B?YWZTR25oK0dkNlZkWSsyUDlRQ3ZkU2htVkdrZ2pKTk9oTjlrU3dvWVNaSStJ?=
 =?utf-8?B?UTEvN0NHWnE1UWxCVHVRTVhHRUlTNkZ3RWdBR2hpOCtnTkFjWHlYbWpkcHpi?=
 =?utf-8?B?TTRFL21CanQvZFdPVUZJMERrV2ZjcEdIM0J1dmZ3cjZiOWo0NzZOWEozR1l3?=
 =?utf-8?B?YnFxK3J1OWo0azBSeWFoYW1lTGhXbmFZdDdyUU9XdXRQNjJUZ0RUeDNEaW5t?=
 =?utf-8?B?QU1uaGpvNVBJaWp6TE5uNHZwUWc2eXpiQjVudEZkeHpXT0RtZE16KzFXRjBQ?=
 =?utf-8?B?RzFjL0tIdmloOE9jM2xlVXRnWTdLRHAxb0FKYU4zUCs4WWI5N2JZSllMYytm?=
 =?utf-8?B?Z1RRUnhoRzMxMmtEMDBsRTgxRFdQWFJ5VmlmQXNzR1diTTI2NzZaL0J2T2Fh?=
 =?utf-8?B?MVNHSWFIOXBPZTI2TjB4dzBpeEpIUzNZYjRxdW9BVHhWbnk3QWlnL1BRdTZv?=
 =?utf-8?B?L1F5WTRQcFEvQlR1eUUrQVVZQ3poODJWMVVvZXNrdXkxU2UrRDY2Q3BsbVkr?=
 =?utf-8?B?WFh4S0NHUFg3c0c3UWlXV3JTZWpLSzNFY0cvNldPVmVCS1MrVDJ5dEtzUURz?=
 =?utf-8?B?emFPQ2tvaUdlekhnbnU4TDMrN0ZSM2tCeEJlT2hRZWcvcnVYOEV6cFJiVDNx?=
 =?utf-8?B?bGgrT090OGJibFljUDE4MDhGbDIxV3B6R1UxMUpHSVRUWW13RC9ieDJMclFZ?=
 =?utf-8?B?Nmd6TXVCR1BxdVFnSTllVkNaYm5GWTA4cmwyMkdNS0wrb0xHdGRaU0wwOUVh?=
 =?utf-8?B?NHFvazZ1UHdmaWFGUWRhYjV3RDIvcjNaWEhzaExzd1FVajNoUXlQMzNEdDVX?=
 =?utf-8?Q?h8rnhaxCRFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2JFSmhDMDdzL1c1ME15YW1zTUlSUWJXQVdxQWF3dUJMSDNlK1lHQnR2RXFx?=
 =?utf-8?B?eEl5UFBRNVlZQ1dsbmMweGtsalM5a05Kbm8yRlNSSzUvSTJGdlJuRHNpUksx?=
 =?utf-8?B?dVNVcTJjNnBZZVN2MytmTGsrTHVrSHRwZGtHaURQNlBiTktyUnE0Um54ZjIr?=
 =?utf-8?B?Q1BJVkR1WEk4L0JwOXRXd2NNd0ZqWHMvS3R4TVZ6My81K3hFU0tTaGIyNXZV?=
 =?utf-8?B?bzR5SU5WaTR2WDdQcklHQmhaYTdSdXQ1VnptUm9kR2p4K3dnNk1QdTh6OWFF?=
 =?utf-8?B?LzJ3THNoZzZuQjQ4a2pnbzJqQ1N5T1dBN0pPeHZEUllCQWlkRy9ySVYrTTRq?=
 =?utf-8?B?SDVhQmdjM1NKaDlybUJNaXluUWIyTDZrRlFnZlBoTUtJR09mZUVuek4yY1lD?=
 =?utf-8?B?QzRtQllEemxHTUh5L05UZnRIMWlXamo0b3NNVDUvZm1vbDBHcXlSUENJVHBJ?=
 =?utf-8?B?Q3JMdTVka1hFaHhYWW14UjRHQnZ5S0NkTVM5UCsvcjUvL0NXQ2lwVFYyTWpK?=
 =?utf-8?B?cm1EbXhyRGVMVDc0c0tjMGlOcWUzQ1BWYkxaWjBOL2RJeDZwYks3SXZXckp6?=
 =?utf-8?B?eitzYU0wWFNQT1hvNlZpR0NCdEI4OGsxV0Z6ZG5wSTE2Y0JrWTNRbDVVWXNw?=
 =?utf-8?B?aStpaFRpUjJxbGx6WEFRK2cvamlKK0U3ejExcWVoWE9wb0UyTXBHYmhsdFBR?=
 =?utf-8?B?OXF6azhlVTErWit0bldnT3ZLQUJWUFF6TVRGajdMVDNub0p4YjVyZTlVbWRC?=
 =?utf-8?B?UGJXalhkdG1yRlVKbk45WlRqaVkzTmZEQkdKY2hOVnZuYlBFV3hSM01hM3lR?=
 =?utf-8?B?L0FQWVluZ1p5S3Q0TjVjckJmMmRuOUluMDFacjNJdkZobzdtR00walNnWTNS?=
 =?utf-8?B?Q3BCbjE4QUVFK0U4SGVOWDh5a1dwQnlTMVF5cWh4Q3NrN2Z6UnpqQ0tCbFJR?=
 =?utf-8?B?Rlp6QVpDM2dsUUZKdHdBaGhxVWhBOGR1Y2VaNkFiSkdVM2xqNVpCQXNDTG1t?=
 =?utf-8?B?VkozWkpud21YeXN0dDNEWkFvd1pmWVg2eC9lZWNzUUpja1RXazZENWVvZC9R?=
 =?utf-8?B?emZQajFQa1VqaHVYMWIwZFExLzlrcWNzalEyTWtWbHBYeXNyRlBsZ0ZNUWRY?=
 =?utf-8?B?S01JV2lZRTZlRkhEcEx6dFhwcWRUR3cxNzNWekZBUmw1bGdBL0hQUVV1MGlC?=
 =?utf-8?B?N2h6eWRxbGY4RkoxVnlIZUQwZlNoVUY1bmdmdzFYMG0zT0pHbVVCYmorOXVm?=
 =?utf-8?B?WFd5MktWb2wwWktxd0QzMXJhK3FNb2lTRjhUTUsrUllKZko5TFMrcVhFMFFm?=
 =?utf-8?B?c3hBZjc0ZzNrRTQrODZ6TlZ1RGZLR00zZzRZaStBZ2FBcHZyOTN5NWhhSUVB?=
 =?utf-8?B?TzlEVVRBSUpMcnNTRkNGc1dNck9YaWZGSC9FeWpKQlk0ZEc1UjJVeWVRbm1E?=
 =?utf-8?B?UGdSU2VYYWliTlNvRlNlU0NYZjJFSHlmYzJuVEc1S1hnWnlhRzUzK1N1TTZF?=
 =?utf-8?B?aVpxVW9YanZXMk5Ga2ZGZVA0VW5BKzdwempRcFVwVEtFeHNwRmIzYU56cS9P?=
 =?utf-8?B?bDdaSGNyVTV3aVNCSmx5dVYxSU5vbUxHUlZuVDRjZUpRZy9XeUJLRnEzMU81?=
 =?utf-8?B?S05NTTU1T2VZUkdFMDhGR3V1Zm1qd0tSbndxSEdSOVdLZ3RENlF1K3ZpMWo2?=
 =?utf-8?B?QnZ4NkF3U29UcWhjM3VOUWl5Z0xOMmJmcm5YeEk1M0ZGaTdmWUVRT3ozelIy?=
 =?utf-8?B?dy9OUktvbjY3cDltcWh5RE1MRlV1Q2xiU2NnSU41emRCVm0xd0Z0QXhSeExF?=
 =?utf-8?B?STVXdi9xNnJ3bGNyTWd4c3IxOVFWWEJMcHBxNCsvWmU2Rno1dEdaVktPRUNk?=
 =?utf-8?B?aWs1R2JicXVZcmRuRlVkREpJSVFJanNEOUExVmJKUlRrUHlWT0tFcmlpTWQy?=
 =?utf-8?B?R0VLeWJVRTVLUldScWJ5eHpHWEloc25vZGxub3RqbkhkazNTVEJrZTd3TXNh?=
 =?utf-8?B?dkVnblRua3JQMW5PZHQ5Mjd1c1o0QnM5YjBlOWxwaHNkeFJsa3Z5R3I0MTlN?=
 =?utf-8?B?Rml1VVREREU1SGZyUjR0clo2WHpaN1czMFE1NVp4cXg5RzV0NGNieUtleS9S?=
 =?utf-8?Q?TNN1+o4T+6CMMBeRZ0MLRepep?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf04216d-21ac-440e-076c-08dd919fb619
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 21:55:29.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJHf5RBQnUfl5YVSsCraWulmDtJ7PasWPnL87Fs2O3WWx+zfEAv9sDBSGJXDuGcIGLdaJsiyOua+umK0plHx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

On 5/12/25 16:04, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During platform init, SNP initialization may fail for several reasons,
> such as firmware command failures and incompatible versions. However,
> the KVM capability may continue to advertise support for it.
> 
> The platform may have SNP enabled but if SNP_INIT fails then SNP is
> not supported by KVM.
> 
> During KVM module initialization query the SNP platform status to obtain
> the SNP initialization state and use it as an additional condition to
> determine support for SEV-SNP.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

One comment below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index dea9480b9ff6..f7d343ab9acd 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2935,6 +2935,33 @@ void __init sev_set_cpu_caps(void)
>  	}
>  }
>  
> +static bool is_sev_snp_initialized(void)
> +{
> +	struct sev_user_data_snp_status *status;
> +	struct sev_data_snp_addr buf;
> +	bool initialized = false;
> +	int error, ret;
> +
> +	status = snp_alloc_firmware_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!status)
> +		return false;
> +
> +	buf.address = __psp_pa(status);
> +	ret = sev_do_cmd(SEV_CMD_SNP_PLATFORM_STATUS, &buf, &error);

You'll want to initialize error to 0 or you'll get a possible use of
uninitialized variable.

Thanks,
Tom

> +	if (ret) {
> +		pr_err("SEV: SNP_PLATFORM_STATUS failed ret=%d, fw_error=%d (%#x)\n",
> +		       ret, error, error);
> +		goto out;
> +	}
> +
> +	initialized = !!status->state;
> +
> +out:
> +	snp_free_firmware_page(status);
> +
> +	return initialized;
> +}
> +
>  void __init sev_hardware_setup(void)
>  {
>  	unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_count;
> @@ -3039,6 +3066,14 @@ void __init sev_hardware_setup(void)
>  	sev_snp_supported = sev_snp_enabled && cc_platform_has(CC_ATTR_HOST_SEV_SNP);
>  
>  out:
> +	if (sev_enabled) {
> +		init_args.probe = true;
> +		if (sev_platform_init(&init_args))
> +			sev_supported = sev_es_supported = sev_snp_supported = false;
> +		else if (sev_snp_supported)
> +			sev_snp_supported = is_sev_snp_initialized();
> +	}
> +
>  	if (boot_cpu_has(X86_FEATURE_SEV))
>  		pr_info("SEV %s (ASIDs %u - %u)\n",
>  			sev_supported ? min_sev_asid <= max_sev_asid ? "enabled" :
> @@ -3065,15 +3100,6 @@ void __init sev_hardware_setup(void)
>  	sev_supported_vmsa_features = 0;
>  	if (sev_es_debug_swap_enabled)
>  		sev_supported_vmsa_features |= SVM_SEV_FEAT_DEBUG_SWAP;
> -
> -	if (!sev_enabled)
> -		return;
> -
> -	/*
> -	 * Do both SNP and SEV initialization at KVM module load.
> -	 */
> -	init_args.probe = true;
> -	sev_platform_init(&init_args);
>  }
>  
>  void sev_hardware_unsetup(void)

