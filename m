Return-Path: <linux-kselftest+bounces-29614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53923A6CC33
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 21:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53731898566
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD37230BE4;
	Sat, 22 Mar 2025 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Y9+klrHY";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="KSIGnPog"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F3142E86;
	Sat, 22 Mar 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675319; cv=fail; b=HFondefx5U8S12TdT71SglOitbDDk+zNlUswMIlmrdp5On94PnZMfxBmC1WkVnAW94QAaIaKr9Bji8721clkB4xcbz1us1BoU/Xdte5Plipp8yyNFhDGREsOBpAJnK+6ygEiEPLmFpxUxDGS6uhLIMDD4Pr2iKrwsZRAeouP4iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675319; c=relaxed/simple;
	bh=Z2GlB+sxEJJgAV80LsFd7qaYtzE88PQL8hBElRnWfS0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ryx+e96l52Z0sCMu49csS7C+B0KfxGP8w+XMwjHHZOECJSMxH6jQ6BTmg98AZMxt3s/UtJI8h15Y/5Gb81QlKMgp3SxkxngnY9u+dpZ0jCpH08qMuWLRHEs27KuPsazmxNjWVMQ0DtQMIlYH4mWw4Nvi1qhExZLwqcA5P3GM3QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Y9+klrHY; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=KSIGnPog; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MK0D0U012218;
	Sat, 22 Mar 2025 15:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=fNJn5j8wGOEotQMz6Ud+kA5MGFcRSFEDMEoLlDO+tdQ=; b=
	Y9+klrHY376bFkS31zb/X6WELGWVvZPzw8TVkJcXCSHfZ2yVWElP0AnPoHx5p0bn
	UknM/TGRPjBxhs9ni7+xoDJh+i2wtPv5QZvrNpb45U9vaZZiGp3f7Qs9MjHpneuy
	yIL2hm7UG2FA/+5XDVAdbASKZkPimDwTTiQZYEltfNmygK92cwJ6lpyAAjF99CGM
	NwPKDPSXOp9o2hbw24XEjuSRb/Y3X9ec7rCPhTgQGdqv9LsIu0GcKXzUS0z313ah
	0KISDeLrK9PYwqN6hok8fOmHkPw2MpmW/1FbIej/7jMfkPQXN/QOqT1Rnd4nMvvL
	bVDlgeiktr4eIpM4u4qleg==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45htm1ghwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 15:28:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRg5uJNewM7ppM4v9OiWiWyGhTRZxJBdbTsqqTtjYz83EfwIPCyzssAepZyZlligbDuBQmaCzRHoAq4ym+McUJBoBN7brFEumVh2px18qMYd7xY6qz7bKm8zupYsX0sqORxuzsTEAlDRb7socC5/HAlmtpxcd1eUlRWq73LczgGnuj3sZeMFzY9qiT3yQdnqrdIduMUH5RCwwjgnJp2RCh+SjONGj+9yYLzpMLN7S0tKvqYPL4sPBOpDLXo77kBBwVtIjCRfiw+/4iBhsCQ1lEM4yyuFw8GrR1STApsnQAYuyc91bkRxaEi6AiDYJNarXTw/qvefngr0qlW2LYuH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNJn5j8wGOEotQMz6Ud+kA5MGFcRSFEDMEoLlDO+tdQ=;
 b=BjyvbCSiceYLnivzheATshcJdSA4f67zqHFw98AuAI3je+COTxXcLQc69LxIS7rTnnQcuKUMzYodmsJfgu7jo5bV+PJ0q2KuJajynm4OYGNn7uxb4BYGeA1XXuiWXkq+A5Sjn13C99+eXQ1u2MothfeugpWBHZuubyoeUsaV3Ap86JrrnypDQlylm3bV3+S8jSfJRPq9ZJbQkXNXtUOnfxIrAsg52ubhta9+jXOy0/Y8Y6JeHQsC1Q67RJ/7HkgQEqPlxFkovILuXUgwawrmMSasP6vHvFIRRIdEfr79slejPCm/AAE16YMJJavP6Soj89owDA7bd2SKrRXInlU10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=temperror action=none header.from=opensource.cirrus.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNJn5j8wGOEotQMz6Ud+kA5MGFcRSFEDMEoLlDO+tdQ=;
 b=KSIGnPogWLHotSKHqnwP+I7Z3IcV7L8EfUCI8zCZHlXwM83WH3w7fQASbCwy98c10KE1BaYSPFkzSqDYDCOnXBHWyoFlWfqM5qUrAPSe6EHpt/J3ArMiPukHYt7iKfImvLjItj+nRAHoCk6HJ+IcN2fvfRIyCEeEXR/8KMNn1PA=
Received: from BN1PR12CA0030.namprd12.prod.outlook.com (2603:10b6:408:e1::35)
 by CH4PR19MB8710.namprd19.prod.outlook.com (2603:10b6:610:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 20:28:11 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::63) by BN1PR12CA0030.outlook.office365.com
 (2603:10b6:408:e1::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Sat,
 22 Mar 2025 20:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 84.19.233.75) smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=opensource.cirrus.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cirrus.com: DNS Timeout)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 22 Mar 2025 20:28:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 88ECA406540;
	Sat, 22 Mar 2025 20:28:07 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id B3FB8820244;
	Sat, 22 Mar 2025 20:28:05 +0000 (UTC)
Message-ID: <6ed7f92e-f621-4680-8f80-dc793e093a39@opensource.cirrus.com>
Date: Sat, 22 Mar 2025 20:28:05 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Nico Pache <npache@redhat.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
        davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
        sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
 <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
 <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
 <9d6831c7-053e-4414-ba9f-f5e71c690588@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <9d6831c7-053e-4414-ba9f-f5e71c690588@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|CH4PR19MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe5b534-f759-43c6-3690-08dd69800f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|30052699003|61400799027|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3FrcVpTSWg1UXJ6OWJjbm1uM0RkcEdURGVha3R0SUFzQ0J3ZDQ0cEU3aHVq?=
 =?utf-8?B?ZFhQQXN5Ymg5K0J2cDZZNkRPTEZhcEZ6czY4L3pQbCsxak5send4eEJiQUZZ?=
 =?utf-8?B?bGZzK3hNTjJSeUJhZEcwNGRUcDE2ZFRXNEVRV0UxZnJLV09hUnJZbzExSzlp?=
 =?utf-8?B?Q3VHMWczSFF0d1p1WU9DWW1ERzFMallQZUxvVHNkMnhpSnJKRU9Ea2lwdWxy?=
 =?utf-8?B?cFoyb2hidzdZMzF0elRwM09IbTBOREpua2d5MUFrcFBMQXJlVlByQUpDTnNw?=
 =?utf-8?B?U3ZsRFVWSDFtKzN0UzlFODRFL2ZGMWNOSk5aZU9rdWh1dlBqc1lMTmxzS1lL?=
 =?utf-8?B?TDZKRExPbFpwejBIUGdGRThHenVQZVBhRm4vc3RBZDFYZExkellFTzVIbnl2?=
 =?utf-8?B?aE5rWERPZkV3cUFrMmNIb0MyS0pYMjA4Z0Q3NXZYTHVtSnA0dEF1SEtDTFJW?=
 =?utf-8?B?eVpVUDJtVFNmbElEckZUd3g5dEtTUjNEM1oxckYrcHhzdlFwS0VOVVhLQlY0?=
 =?utf-8?B?UlJiR21wekh5eVVBTmlKL01PSFlRQW1SRjN1ZDZiWFgwUlphdm01SVFHS3hy?=
 =?utf-8?B?MC9NYURuRkdObE5wdTQ4NzBBcHUvZCtTc3dYa0dlTG5aVlFXRnI5UHZZd3Fk?=
 =?utf-8?B?U0s2VERIMk02R3RmK0dWNlFNUVR3VHpjZzZXQWF3YXVsdUM4T1NaZ2Nja0dH?=
 =?utf-8?B?MXpDV0JrT0g1QUZHcHYwa2pnSFJ4TzdNZGFHZ3hYVWpTZ1VXR1ZoYVVEOGJU?=
 =?utf-8?B?dmMzUGtGNUxOMGhqUVlibzRNQ0xKRml2NmN4ZFpOZUZqaTlJRzRHM3hKMjZP?=
 =?utf-8?B?N1Z5QmJwVStNNU05VGhVWitIOGVWZk8zZUVmYnhMZ21DVWFNbTAwbTlrTWJN?=
 =?utf-8?B?eGlCcjY3ajZLRmFWVlk2ZncwclVNclBJRUxhZTd3SjgwU28zS1MrTXNPVyt6?=
 =?utf-8?B?b3dmUnFhemcxNTVNRVJydkFGdXhPUWtmazhPVkNWTFo3V2Q0SzYyWmh2Y1Ny?=
 =?utf-8?B?SnVwcUphQkR3eEZpSklmMk5uVmVKZDgrNFZ4NlF5RGs0UG8xWStEaFFIZHR1?=
 =?utf-8?B?NHVLT0YwcVNTZ0VWMkxBRGJCWElsQnpXS2ZzZTVoV3J1Y0FwQmFkcjQzbGtR?=
 =?utf-8?B?MTdIN2hJSHUyTFhNRDlRWUllNmptU0xGN0JXQ0haTGJkMFZPdnhzdU1Sanlk?=
 =?utf-8?B?WkVXSUdSWnFzdFNQTmZCOHFTNkVzVVg4UU5HdjEvOUFuNS9yNTFBSGxjeElp?=
 =?utf-8?B?dXBGS0ZPTTZJbkNCMktnTnE5NkgzQVZGSkNkd2wxOXJmRCtVQXlyK050TVA2?=
 =?utf-8?B?cGRJQW4xTGxkUlJUa2Z4alNNSGYvdVF1THpzT1BpSlhNRHU1eEVPMGZsa3hM?=
 =?utf-8?B?anVnRkwwQ29Vc0RqNWVLYnp5V25MeWNkcllqSzR3Qm5oeW5JVUNrWVpPOTdP?=
 =?utf-8?B?dm1Ibm1xc1BNTjUvcndJd05GOXFlNU03V3BUeXArbm1qUWpUUWY4YnhnZ1M1?=
 =?utf-8?B?WllzTURsRTlFRzQ1bVZrYUwrS05kVi9xYmNiWjJxbk5KUXdrWmNXT2tuMDZZ?=
 =?utf-8?B?RTR2VDZrR3dNMERCcUhjNlNNelk2WERrL3pxU2lCWXpaOWRRYm1KVmYzWjIy?=
 =?utf-8?B?TG9iOW9DNHd5Ujh2Y3N1Z01yUnVxTjJKdk5BaXJhNjdZV3VIUy9pRVovQmh4?=
 =?utf-8?B?akN6dHViY3loTk9DVEQ0ZjJrNjAySlJoZWtpdkRxUURWRmljZUNsYk9rZ2lN?=
 =?utf-8?B?WCtES1dEOUZRTUJVTGZDWktPMnNZM3hDUkZsRmM4TGZEci9PcmtyeTdDUXhJ?=
 =?utf-8?B?QVZZendlWFhlY3pkSSsrU3NjQ1hzYVdIZFVnUkdVNG43T0ZROEVGKzdTM0FZ?=
 =?utf-8?B?MCs3NlpYMWxXcmFWNCtvdzNuNkd0K2krSmY3dlhHL1kycHZLQ2JXanBicWEw?=
 =?utf-8?B?dytVUGZUUmpkMko3Q0pGbjV0WEhBTmRyLzkzWFRFcmhGdDdaSU9ZSHpEekZV?=
 =?utf-8?Q?lXAoxLC/ktwb62/JfWFgR6NHmWdAP4=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(30052699003)(61400799027)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 20:28:09.2377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe5b534-f759-43c6-3690-08dd69800f93
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR19MB8710
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=67df1d60 cx=c_pps a=QfxD4CzqCnNUzUqh5S/TIg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=Jfib6UNXmi7HvEEacrEA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: YI6Yg0ahBF2QXJwxl21A9pikFZsd4gH_
X-Proofpoint-ORIG-GUID: YI6Yg0ahBF2QXJwxl21A9pikFZsd4gH_
X-Proofpoint-Spam-Reason: safe

On 22/3/25 19:02, Richard Fitzgerald wrote:
> On 22/3/25 10:11, Richard Fitzgerald wrote:
>> On 20/3/25 17:35, Nico Pache wrote:
>>> Sorry links got mangled
>>>
>> Thanks. I'm on vacation right now but I'll take a look through
>> all those when I have time.
>>
>> The unterminated string bugfix is this:
>> https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1- 
>> d9bc2035d154@linutronix.de/
>>
>> I got lucky on all the UM, X86 and ARM builds I tested.
>>
> It looks like that bugfix has got lost.
> Mark sent an email on 20 Feb to say it has been merged into his
> sound tree. But that patch isn't in torvalds/master.
> 
> It's possible that the unterminated strings are causing the problems
> you have seen.

I've reproduced this, and it's not a bug in the test. The test is
correctly finding a change in behavior that was introduced into cs_dsp.
This doesn't affect normal firmware files that have real content. But
the tests create an "empty" firmware file that has only the header. This
is useful, so we can have a dummy firmware file that doesn't create
side-effects when it is loaded.

A normal file contains data blocks, which will set ret = 0 when they are
processed. An "empty" file does not have any data block so ret is never
set to 0. The end of the function used to do this:

ret = regmap_async_complete(regmap);

which would make ret == 0 on exit from the function. But a recent commit
removed the async regmap writes and so removed this line. A real
firmware file will already have set ret == 0 when it processed a data
block. The dummy files don't.

So... we have a kunit test, but KUNIT_ALL_TESTS doesn't mean "run all
tests". It means "run test for modules that are already selected."
Modules must be manually selected to get a KUNIT_ALL_TESTS run to
actually run the test code. So it didn't get a kunit test run.

I'll send a patch to fix this.

