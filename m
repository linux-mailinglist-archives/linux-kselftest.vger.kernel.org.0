Return-Path: <linux-kselftest+bounces-41813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA0B836EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8347542390
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809C2EFDBE;
	Thu, 18 Sep 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e+Xt8Bgf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012040.outbound.protection.outlook.com [52.101.126.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947014286;
	Thu, 18 Sep 2025 08:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182766; cv=fail; b=kYBbpLE+FA3B/80Ey7wLxG5V7jFCzg7Lsu41OL3yibHVvfVmMPiQ0gZ5pJSA6Owrl+T0HPRyOopO+FMD3u+Bg1mqbf3lHqnwcexDRzj95yb4TpW6s3tTJwejDf1DdEAIx6LgsGCnZkafO1CjoFwQHT+47brBIbBAwzMegPPkTRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182766; c=relaxed/simple;
	bh=i0v1qupZ1Lw7DzZXmF3f4OBEw+pMvjugqa42p8L4q/E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YYUELBgsi8ImgfPbaws2eGcg3dV45tOQUppRnm7hJ3Lg97r7tYXVZTMgrWvFVAZi9xbxK4aCBcrcLvSmPRe1nHfNLc7BU3OyqKfkEpF5qhUVlif6Ve0pRVWoCDoybtkVifjMqlscHUdBTijmI9p6d0VnrMvTGysFemPE/1GJwxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e+Xt8Bgf; arc=fail smtp.client-ip=52.101.126.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzAeJyTAQbqOW83s0Oxw7nT3TShULeTxpVBU0adeyIRA7/eWX8wJF7oDpe3gBVKhnQTAZQyutI000Sz13foCda+mF4unsVZLLXze8Kbbijrmkthjv0pDZkfyv5yhuJG+mu3mh8YVV2giqVQpfBz3+4x2HmFrMCgPXDFM5A3yRt+zKDgwgUugSMg2j84KFeC/5YXIupTN6f3BBpPmH6CxbZAF+81djx7B53kuagBmtovLj6kdVN5EPn8nls5e1hCG+Y1KNVAMuFsU51Nstkvz9OguyCt6UIP9Y53Z6q6f9cyDA7DJ8GylB76YUMAYhP/IHspDV3ZRyzJSAzjhVisj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAPSjyf49N0FzA1VxsWtwh7KHZ90x2A//+txXxGYRGk=;
 b=GpNLCsAz2GCwJBia1odgk6PmFGZ39hRGW/QRF/0djiAN8EUSiBQRvIuwxfhkrBQ3idGXG7WoIFuFkju6B9c4hC/jNSFDX5SpAg+cd/0nvgM4cYNyaniZUnKsqEt1np0W3qzcxdj0637o0N9pPFliMgzi5CNfF0iFKANoR/RopzRorPUmrAR0M/mN+wgQ0Lqjes42RnbhBQhpuLrrAySnpkbrkR/e1+Jey+05TPwpMMmK/xs4CaFf1BSDwiIWH7MBfsWNhJMH5odFBXu5W8VjIud9nsrr1Uj5y/XCYEGzeBh6xL2kvp5pij+IUFOO/cdYEEynYYsDGA5tlP7xpA+27g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAPSjyf49N0FzA1VxsWtwh7KHZ90x2A//+txXxGYRGk=;
 b=e+Xt8BgfirTLYaJ9JVmHEg48+NyH7F6OC4LmmfOwA7OIol9agaLl27PUANAp0u/qn18GB8GoGOlI+Dz4Gq+MhnZUw4/9ZolCS2rq3HSFXozAim9q2SJZ9DuHwiwHuDsoSCy4oHCpo+I+u1VutTUiJNGzG0kZrn1+9T74qKTa4dE6O1Chh4O6aUc1tCIsrK5JLSfdOnsXv7OfjatVWo3zIyEH9FvPxazC2MfK+FE9nlJS7WzY5+iI42SeX3w5StSnvOxxoWCSKYU4K5C6DcbH+ore9ABepd/ajceyZM/34AoOIqcIoVFnQFYVprcWbVppJJRByPGPTK7S7406x4qRaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI2PR06MB5091.apcprd06.prod.outlook.com (2603:1096:4:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 08:05:57 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 08:05:57 +0000
Message-ID: <b23ef4e0-afa1-4d94-b4aa-28c02c3499c6@vivo.com>
Date: Thu, 18 Sep 2025 16:05:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for
 overriding tracepoint probes
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, yonghong.song@linux.dev, haoluo@google.com,
 jolsa@kernel.org, eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 shuah@kernel.org, willemb@google.com, kerneljasonxing@gmail.com,
 paul.chaignon@gmail.com, chen.dylane@linux.dev, memxor@gmail.com,
 martin.kelly@crowdstrike.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 yikai.lin@vivo.com
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
 <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <CAPhsuW47BVGsszGU=27gKa1XOYLH+de1FgrHPVL4mftB2CvX9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI2PR06MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: ddcb9df1-9e0b-4912-eacd-08ddf68a326b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2dQODhyNkVrWHZ2cXdUQU83VytLYWJUTUExS3piem9PRExrWEJXTW93R2x0?=
 =?utf-8?B?bFRQSVVuUXZFSjNzOHBBVlhvQkZyWkh1RlRNeitJRG5uYjVjNUhzQlB5S0ZX?=
 =?utf-8?B?Q1ZsRXFDY1dMeE5XV0dtOWtKNzJyM2s3VEtycWZNMUhJdTdTNkhnRzdubDJm?=
 =?utf-8?B?M2RHVUIzTXNxcmlaVmlHZkdXaXI4cSt0QTZZR1UvdzVBMktldnAvWFZ6Sjhi?=
 =?utf-8?B?a1l0WHZzQWxOM3dCejlnS1RCTVkyM3NYYWFXd0NINjVuei82K1MrRVpTYVFj?=
 =?utf-8?B?emJHdU4wQ3h0NGNKTkxGU3pXemRaMjcvR3ZKY2FRSWY3RGV6ZDFCbm1ZQkZY?=
 =?utf-8?B?UFNDVzNyMEpNWmhVT2U3eWl0SzNLU2MySThSQWRpMmo5aHpBUENxNmVMcnAw?=
 =?utf-8?B?anlPVTVVazJYR3hzWk1nN2RsbEI0d3BOQTV1MDV6bVdsczVZR0dWVXBudGNP?=
 =?utf-8?B?SnRSQytzSGRxamJYSTltUXpJa1ZTaGFIWGNEb2V6eW5KTnNQNjRzWXFHdEx0?=
 =?utf-8?B?Ukw2YkFPWWkzK0Z4M3hGbGpldFRyNkhFV3J2aUtkZm5NeW9qR2NXZmpjRHVq?=
 =?utf-8?B?M1J6SjFWa1BvUWhZcFdUclRvR3N6ZUkxdjIvOHdqUEdwYTZiWGZGRUNrVXFh?=
 =?utf-8?B?TDJQRGIxaWVXM3B1ZWt5MDdXMEt1SDVpQ2paVzVQTTB4cllJM3ZGem0xamlu?=
 =?utf-8?B?bk0vc3NGRkU0cmFsTU1iUXB6YlFZQnF0ZU5USWZDZnF6UEtIVjN3cG1MRFEv?=
 =?utf-8?B?ei91eXBTZU1DQmtsS2cwSnVoY0RmNnhCeGNIZTVQaW1uNi9yd3ZFNVhXbE4y?=
 =?utf-8?B?UlB3dGNRQS9ZWDBwRkRYV2FMbWxCUHdqMCtVWkRqcjM5UkZLZWd3TlNGMHdV?=
 =?utf-8?B?L2paVmo3OGRPSnhRblJvTTZUVVppd0tNLzYrZ2lEbkFCR3NBSVJlN0YxTkxP?=
 =?utf-8?B?QnlpKzdPd3Q2aXhFUDdKbDc2c010T2lKblBZaW01ZytMbll0NHdpQXI3TElw?=
 =?utf-8?B?Yzd5Y2pwWWo4cEVhRHFadEIrUXROWFlZSnVuRlpQZWRucERSaFZLaVdqckgy?=
 =?utf-8?B?L3R5SjJkYjA5c2FOOFFsTUNyMndXOTZlZnJaZFYrV2pPSjE3UHkxaHJyK29P?=
 =?utf-8?B?V1A3MHEzQWwvb2dmMW1MeTNNblVyWElJL0VvcUNvUTQzYlVTN0hJOVFOQWpq?=
 =?utf-8?B?SUFCRFErZTlIeTlyUTZlTmU2VERvK01zejN4VWxnMjE4bFI3dElTSitDbERx?=
 =?utf-8?B?YzRxYnpZaGNmN2pxSkEza1pVcGtoZE1GdjFvQ1FTaVJWa2w2cDEvZWJFM1dZ?=
 =?utf-8?B?ZGhjb2JVdENZOVd0TFIvSjVNM0h1ZlJGSmFtTVpJYkpWbjdNenB6ampOS01i?=
 =?utf-8?B?L1FYbWQ0RktzSXloVk1xYWRNVkkraTB0dXNqeUhDbnNqNk9tVGdUclZxMGpj?=
 =?utf-8?B?TG9zWWM1VGFwUUNyZk53WDIvNUJKem5ka0h4RnoxRTZhNWNONE1nSXVOcGQ0?=
 =?utf-8?B?d0NQSGJ1NzlmNXZhM21sWDF2L0VoazRRSlBjb3J4djlDcUN4S0NxZzFKK2lT?=
 =?utf-8?B?VVZWU09tL3ZWaHlERUN1Y21KMDFDM0NnN1dlN0c5T1NwaDVKSngrcGROazU3?=
 =?utf-8?B?VU1lTGJ6ZFdpQUVuekh3WjFaT3dCWG04RmRZMzNzYXpuZEJWNVhrTU1LL000?=
 =?utf-8?B?b0JxMnk0aVZ1YjBjdXNVS0tqSGdVYVovendKTEcwOVoyaFFkL1g1RzdOVkRw?=
 =?utf-8?B?QjJDWGlVM05Kc0FNWXRVQTdpdmVQaTRiNFpYUHpWeHB2M29lWU5PYm9GamZV?=
 =?utf-8?B?eWtPdmw0c0Q5NFJDek41Yjd6Q2QwYm12OW1PTFd4ZFpqQk10V0hUY3IxVDVz?=
 =?utf-8?B?VmtYc2lKc2JhU214MjVKY2xyd0hSU09UZlBQNVMwekhsZzJhSVIraUcrUnF1?=
 =?utf-8?Q?Rd1spTzFBoM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ky9iYTVaUTloajQ3N09BMkQ2dUJ5RkhqZ3RyTWgrazJUWUN1eEo3Z0hLTTVq?=
 =?utf-8?B?QlRGV3dDeEIxaStnQzEweXVKUEJyOFhxOGM1YlVQcUZTTElqMHNTUng1eTBL?=
 =?utf-8?B?M0ZWU29MdEllVG1HekFGZWpHQWhKZE5OYmNGZDR6dTRra0F1NXBHcXllVE1X?=
 =?utf-8?B?aFZYSDZYeWJZbGZYaTVPdUJnbGhVdDIxMzkxVkFwdWRodWV4eXhjam52U3Jx?=
 =?utf-8?B?aEg0c05Xc2hhbGlZTTBKam5SQ0NObThaeCsrQTd2WWJDT2ZXdkRHd2QrSlYz?=
 =?utf-8?B?ZGI5WCt4RUdtZXNWUU5MU3dvZDFQa1Ezcm5mQnE0WkJzR2tTaGZGQUUxdlRj?=
 =?utf-8?B?M2VYbjVsRWQydjBaOGNZbUVRK1JwK0tFb0JYR01UN3BsM1VYSGpPbzIyc0ZM?=
 =?utf-8?B?bnRjeEdnd0Z0Z2dmQ3dWUjJZaEVvRWdodnlVQ2hXQjhUeFQ0d0lJVytQZWx0?=
 =?utf-8?B?cXFPVzVXem5ZVnAxd2lNQW16YVFEVWhkNGI1MVhpVUtaai9vUWRXMVY2SXFQ?=
 =?utf-8?B?OFpTMkhQMlNvVHVTS3VWdVBoUDBsMlZvWVdXd2FGMlBsSTFNT0Z5WldraFZI?=
 =?utf-8?B?SzhQVUdKcDBVclJlQnpQNkg2a0F3SGVRaHQyMk1ycXRYdjRzWG9sU2hVbGor?=
 =?utf-8?B?c1U4RDNTT3RTRm5rYTNMZWI4Y3ltd2NWMkZWZlZNbHVaUGVld1BYckJuSDFm?=
 =?utf-8?B?NmZaR1RMVWszbFVVY3RCTmduaHE4WU0wb0x2YmIzQ1dJR205dzVyUU9VNUtY?=
 =?utf-8?B?V1pIZERLRlA1ZjVoQmllUWtGcWFXUlIrd3FiYmIwY2t6bkluTDZIb0IvRXI0?=
 =?utf-8?B?UTBBdHFIeFNNTlRXVmFGZHNFNDdHNWtpdHNMcGJIdXNjZmF5T0JaTTcyeW5r?=
 =?utf-8?B?UEdBLzZ4YWJIdWNRdjZXTkhTZVlJTnArcTF0M01xS3dPYkRESTdwN25XMjZw?=
 =?utf-8?B?ajBMMExUbENNZ1FjUUtxME1UbXZpM0xwV29rWk9DMnpuMVZsay9rTlR2S3Bt?=
 =?utf-8?B?UjcwYnNQTUE4ZFNiZ1JpcU8yczhNNTJ5VTI0NWJEaFRxQmlHa3FRQS9DLzN0?=
 =?utf-8?B?TDJ0ZWI0dFFqUE5IZHV6cmNEbGI0Vkc1VWJvUjM0cTJlb0taL3NKZzNodWFY?=
 =?utf-8?B?SGVoUS9ENnR3emdaZzZTaERBTXZ2Q0U4U3VITi9uRmZaRG9jT2hqK2RoRTBD?=
 =?utf-8?B?M1FzejJ5UTdoM285RU1INUhPSkNwWXc3cXhkS3ZTQXhXWGgrMHFPUUYxR1Vy?=
 =?utf-8?B?b3J2dGREZ2dzWkNNRnFZWHRzOHRRQ3c5dlVvd1NPV21wUWpPbVIzdWlKY2FY?=
 =?utf-8?B?c3lUcW03dTRNdmVmSzE4WkpLdkpBdkZua1lLM1Nyc0xHb0RjNzdNMWlvRzJU?=
 =?utf-8?B?NmZIVHBnWEZOSmJEWVdSS1MreUdCQXNFdld4aVI4b2kwSTB6cCtEOHEzdHUx?=
 =?utf-8?B?NlF4YkZtdHdDdDY4NlBOQ1ptSmx2Zi9YWGRZTXFOQnc4RlhYZFptSVVNaitu?=
 =?utf-8?B?ajRhb2hhZ1hzZlRHZkM1SGZjRXVZVGY5Y3lsOS9QZGZiS0Y4UWI4cXZKQWh1?=
 =?utf-8?B?N0hlVkFBUjJiS1dCdUgzZUQyM2dpaWU0VkFCRk81c3JlcGVjblduc01Gd21j?=
 =?utf-8?B?K1NRVVdUbCthTFFkT0RpbEdyeERzWGNIVVZZY1JZSVNITUlteVZYSmxVN3VO?=
 =?utf-8?B?MGZZYjhIcmlPUXpNb0l5cXgwTWwwVmNocDBHbzRSVy9pcit0NkQrMUl6ci9i?=
 =?utf-8?B?Zjk2aWVTcXRZNjhxWXFJSGQzTWZ0ZGhwdjBpc2hTb0RLb3lBS1lVdkprYW1Q?=
 =?utf-8?B?eEcwaHdhNEtKR3llUWJZTTE1ekRpR0dZSllNVlRRUy83NVloeVc5alNySzB5?=
 =?utf-8?B?MUNqUUtVNmZJeE82dCtLQnRhZVJUK1hPSUhpSGN6bGVZM0NweXI5d1poendu?=
 =?utf-8?B?cEExeTRTZG1VMFVVcE0vVWxad3F0T05FSk1DWjVuRGJqNXpoVXF6SEp5eDRS?=
 =?utf-8?B?cFlwT054VEtYVWY4YlNEamRhT0xuWlMvMWxwN3JGT1A0WEVDbGFhTWk5V2Zn?=
 =?utf-8?B?TjRHcTF4NzIxaEl2eU1qL2YvMHg3SERjcHF2MEgxSHRWV1hiWktJa2JUTTFo?=
 =?utf-8?Q?JUkvvH3bdMXTL122QyUQ4AGs+?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddcb9df1-9e0b-4912-eacd-08ddf68a326b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 08:05:57.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcMZ4acSa1stu/wztS5s2iVGAN1gRr9LEqngU3mp2QCxsIfHEoOLQKQS434kWrWReV36SSVC195xqAmCrycvLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5091



On 9/18/2025 4:02 AM, Song Liu wrote:
> On Wed, Sep 17, 2025 at 12:23 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>> Hi everyone,
>>
>> This patchset introduces a new BPF program type that allows overriding
>> a tracepoint probe function registered via register_trace_*.
>>
>> Motivation
>> ----------
>> Tracepoint probe functions registered via register_trace_* in the kernel
>> cannot be dynamically modified, changing a probe function requires recompiling
>> the kernel and rebooting. Nor can BPF programs change an existing
>> probe function.
>>
>> Overiding tracepoint supports a way to apply patches into kernel quickly
>> (such as applying security ones), through predefined static tracepoints,
>> without waiting for upstream integration.
> 
> IIUC, this work solves the same problem as raw tracepoint (raw_tp) or raw
> tracepoint with btf (tp_btf).
> 
> Did I miss something?
> 
> Thanks,
> Song

As I understand it, raw tracepoints (raw_tp) and raw tracepoint (raw_tp)
are designed mainly for tracing the kernel. The goal of this work is to
provide a way to override the tracepoint callback, so that kernel behavior
can be adjusted dynamically.

Thanks,
Fuyu


