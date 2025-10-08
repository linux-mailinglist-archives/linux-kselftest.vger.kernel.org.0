Return-Path: <linux-kselftest+bounces-42866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75697BC4334
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690604E53C2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDD2DECAA;
	Wed,  8 Oct 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B78XtlO7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1AF29B778;
	Wed,  8 Oct 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759917142; cv=fail; b=rR5je8dseBOLd055iIjrZ++8hK+CW4tZshHpZA4sB2WvIPbfSXhFRiNBecZrO7j6HWXSsaMgWZJldbis6HJRZ1edf6JVLwZ0NffaFvVWkC+Cqh6PpE74vxaZ23iGO8LT/dQ7u0btQwYnXgE5RSYS5uu/sgCb24WuWQ4vkampyaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759917142; c=relaxed/simple;
	bh=8xRrm6o3K3KYpxQ0b8UO0prr7DyWKPaCfkhg4u520r8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ichqn3oGvz8WjmyKSC244UXfEG4U82rnLZWOIt1l8BKZ13CU6Nj1Ain4TfGHCNdXW3eg7mvD1U5M4H8a/oEoanoZU+tG0PXg7kiEvuzPzIxHPziJfYY58yBdHfoCYhQU+Pe/LDskholHRTEnEWid/PzTsXf/S7nqKFNy0lmrpto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B78XtlO7; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVEfPO0Dwj7juxQH65GuGRGeU72A/sjgg7CyfayuFNPz4kVeOpluSqsN7DN+10+ENZxI0up53tkNa5hVRky363V2MU+rVtZEa0FAJ5n9pV1XhEBnxMJ89j6IH/DJkELm3Q9JElc9udfnIalNEOxo4hQmrWuI9R9nz7lXbCQOa0CTgZuwL7YXqRXZinm4c2OddZtrst4uHwCEMYPIpzc8lodDaTmEocFDF4/qnbKaQcDmT6/gd03YGwPs/9evLM2+hn5rx4jgvhKRVwzxlNZ2r9zjYc3R0ZbpmwH/BwriAYIQcIXEmdaBVPRqDPP3tEC/qG7iTiac6ZiOY1DZhjZL3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR31bRxmDWIcL8DtKufMBHsgWmgLQYeb8NoFlXUhZ00=;
 b=xdwTnlsQk7to4sG1kL0VDPo2MLMOu75FAoYKbgm38rpjpxqHKUhE2G2Ly0x0DaMvcxr+YkVFyywK+oDcpekDyPawAqQ+1imYhi2jDOv5Z08vmsQiVaoSA1bBQfevoLbBN/DopquRvnFueXI+J2kObuA3bRyUZNlZnvuWsijir4JvStVF91/ib/8nEsi6ocCKy0XBitgqqRRb0WyCr5QH0YE5gtRkerRSggmwn1gAufj/VBL82o2tT1xM8hPxQ6H1fYFEFrlEB01w4um4GocQjJsNFMDvVuI3LsssACseSolggJBvoPbIWtZt6sd9tagG8AvPwcHLvPNKY/08fqGB3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR31bRxmDWIcL8DtKufMBHsgWmgLQYeb8NoFlXUhZ00=;
 b=B78XtlO7GFuNGpkE+Te3uM964xPMyqwIY+xRBBpkoq7BOvWc9nBuj207xbfcWuK79K+XQa9XAh4Qi8VD3IELOJRwPnN6relsI9T2vw+lZFsHUAMDZsa5XMBJIsY6T5aI5mfnFi3XjthEMZ0AtEZ5SfXUpl1WrOSEcXXtoDljDkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 09:52:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 09:52:13 +0000
Message-ID: <3455a300-72e5-421c-8866-7b05d1607252@amd.com>
Date: Wed, 8 Oct 2025 15:22:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com>
 <20251007131159.GA3474167@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251007131159.GA3474167@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: b3da957b-311e-47ee-61b2-08de06505ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFBdnhla1gveW1IZmhXMkxPS0hxMzFwYzRMbTJzSmx5QzFSaEtNMjd6cDZZ?=
 =?utf-8?B?MjZWNzI2L0ttUkhQOXBvL01pdzIzaDN3aUtJcVBBRDZwNGRybThuZnREQXZi?=
 =?utf-8?B?WTRQV2JhUFgwVnk1Nzk2RWZHZW9sUkFXWTNwbzY4UktjMVI2cVVqbGlHeWxo?=
 =?utf-8?B?Vzd2MC9zaWZuelJab3l2KzRCSGVOcmkvczk4TUJrcHdzbXNoYmhZRXJpZDlC?=
 =?utf-8?B?S2FYQXU5RVRFTVoxVEpGekQyWnZObUVZbHBJUEtma2xrTWxsRGVyZUhuYmdS?=
 =?utf-8?B?enhrMUo5WnVxSlA0QjdqbXFscjNqcGFoRWwrajNUU25pbnZnRFRSSEw4Y0sr?=
 =?utf-8?B?NUJKWUw5ZlZEd3NFQXZ6RURpL0xQcmVZcGtIZnRDZkMxWlVFS3BvbUZhYk54?=
 =?utf-8?B?M1BPdVVZRWo4QVJUbFJ5YU5wb1dHNlMrUG8xYzVCeDh2UzBhckRJdUFDcHpm?=
 =?utf-8?B?Ukk1VDRQWXdpejZjK0dCTXM2clJGYWthclUxVE1zcmpXK2VZd1hSMFFjT0tr?=
 =?utf-8?B?WlROTzc2dys5ZDM3Kzhjdk04KytxcTh0NmZnSFRKT3l2OU9OZW9oQjNLZEVG?=
 =?utf-8?B?c25MQVVORVFMRzBBdjBQNnVlWE5XbkQ4T1BGcjNJQVNmVWVndW9rODJCSmY1?=
 =?utf-8?B?NVZrRzcycVp6dzhKNmpqcGZENzRiM2lBMUNsbWI2NmhaOExRQjJuWHlDLzNi?=
 =?utf-8?B?Y0VNUTJNenZxc1lRTUxUNFBiVCs1OGdhRHFyZzBMeGo2cGZsVHgxYWN3Y0x0?=
 =?utf-8?B?RkZXSWFnQTdEdUc3UHNQN280MWIzaGJXLzZ1dHlFalF3WUZnUmwwWmJHVEVl?=
 =?utf-8?B?NSszT2cvdFZNSVBnM1Fzb0hVWWlBUEFHMVcvdkYxaWpjVnNCc3JHSXl0a01T?=
 =?utf-8?B?Y2YzdUdYbU1lWkV3bUZSRzVXeG1rNmp2Q2lxMFBLb25WTjgzOHFLTWdKN291?=
 =?utf-8?B?VEIvSGhJVCtOcHVIUkp6K0hSOVlkNmVUbWFUNTQ2eDRUZEovK1ZTM2kwTjdO?=
 =?utf-8?B?OGtIU2MwZ3l1WndkQkZFaytJRjVzdTRaRGlFVkE2U2lrNkxSMEsrQTJGdm1E?=
 =?utf-8?B?clNERVM4YmwyOUp0VTB5UVFMQk1lOXpsemZlWlRCZ2NiUUdlczVrZHpVeWVw?=
 =?utf-8?B?SG5ZdzBacytGVjZJYTdiNWdvUXNIQStSUUtIMUx3V0wxYVFOZWlKeW5CT2V2?=
 =?utf-8?B?dWJqb1ZXUjVQampFdlRHb3VZL2h1alVXWXMxSHFXemFxVEYwcTFCYTBkVlhk?=
 =?utf-8?B?K0FDRUVVZ2RyMDVIZTJKay9WY01RVGZiUDRsQWlHb2JleVRYZEpWVzlUcnJE?=
 =?utf-8?B?V0NjTnRjYTd1Q25KdEJhQ3lQZHp5Z3JlYk8rY2U1aWowSldkcFFDYU1Ya0tz?=
 =?utf-8?B?OGF4Nkk5WkNGaC84Uno3c0dPeW56L01aUitXaUV0T1hwcjZVbEJ0UHVFVEZ0?=
 =?utf-8?B?Wk5CcWdPdmg4SkU5WVFkbWZ4T0ROalZIcWtJZ1hTbVZtaWx5c0pJWEdlTmoy?=
 =?utf-8?B?UlF5eURuanRCNWdHeHYzeWJJNHNvR1B0MDlKZG16RXBNUGlPMzQ1Vm4weG1t?=
 =?utf-8?B?OVB3cXk5aEluZW4vZFBSRlB6ZjZ2RVptZEVldDNRRmRodEMxMktpTTU5WW44?=
 =?utf-8?B?SlMweTdOclBpZ0VTRld5eTNKYkdRN2xpMlhiblhVOGhyRjFGbnRPbk84UCtK?=
 =?utf-8?B?bkRGQnJoWVJObThXRHNEYktCbXZ4ZlVEY1ArZlNRRGlnNjZKck83aldqeHhN?=
 =?utf-8?B?TEtPRE1yRk44aGY1d1FZTVdDZnFwNTd5S3AxT3VCZGFmRlYveFIvRTYvdU5Q?=
 =?utf-8?B?cStrYi9lNlgrdGs5dnRLM2xVUDQwU1NydG5ZQXAwaTRnTjRSaE9Pd2hKVU9k?=
 =?utf-8?B?S0JDKzBnRGZTRkVkNGYzaXdCMHZ6dEoxS0NhdGpLRnJuM2h3azVKZSttM2J0?=
 =?utf-8?Q?xJzGORrW7MIPJY0k1G7ruqt7fTHUmFhh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUtxbFQraHdUZytsY2h3bjE3YmNOTUxVY3RtTDVwd0pmdTlaMit0bW1yWU9Y?=
 =?utf-8?B?MkZjZEF4TTRGSUxlNEZ5UktONUg0Y0pnN3FXQ2p0ZWdHdFVPTCtBNEgydnNn?=
 =?utf-8?B?ZVVQVzFnV2lVbUw5ZExMY2VadmxienBsQ2ZhZ3Yrc1ljZGkxWXRDMC9mdTJa?=
 =?utf-8?B?c1FrZ0hNbFJNdkpieVhMcEJKTGo2UVF0MDRyWDF3VmcvUHh3QmJDUGNFcDBj?=
 =?utf-8?B?QzMwc1pnUHRzVC9sSk5zZ3U2S3FZM3Y1UmxzYWd5clN2MHVsaGZOSGxNVk43?=
 =?utf-8?B?SGlvdE1GNGdmTUdzT2txUEhhQXNjclpSZ2xFbWljWXVqNHo2OER1UnBLaFFn?=
 =?utf-8?B?ZDZwbXE5SmZjamdOcFZkZEVNbURnN3RnSVFRR0xQOWRUQzlBbDhzeGU5RzU3?=
 =?utf-8?B?eVVkWXBNZWxVVm9OVUR1aWNBd3hKNzh4TDBRODIva0w1QXBKTTBkMEFLeFpN?=
 =?utf-8?B?aVVSSERYNU5KZXI5VFZHT1ZJRXppNkZzN2Z2WkVhT0NHSVRjeFY0UkdwQU54?=
 =?utf-8?B?VzA3a0hCVGluK2hCa3BZN3J6ZmhVeTdrd21ROXlrc25CczFnVm1zZUx6NVZV?=
 =?utf-8?B?bThKUHc2dHRnUklHY1FIc3ZuWmx6MUVNSjVEWnVBdTJCUHRBcEpsZFdJRzZ6?=
 =?utf-8?B?ZVBWTzI3UVo5akhyYU0xS1UybktnS1kxa01zMHpDaktMQmllUTZ5OVZpK3Jz?=
 =?utf-8?B?b0d6U2RuSWYxWGlIUmU4d3pGQWNQa2R5TllPWkgwN2FxZTdqTXJCcUNmcnlo?=
 =?utf-8?B?dUJkUkdzNFFEdmhkTlJJUkxhZnJ6OHRIdzRTN0U2RVNtWCtKMU1tWHNuNkF0?=
 =?utf-8?B?ZXRCdlMyU3BzczVYeng1QmZaRHZFQkk1djdmMU55eTFrUGNMdFdoYUUvREgy?=
 =?utf-8?B?MUxRZ1B1UGUyUTk5eUNlQVExblhKQ1VnclFVcG81eFVMM2pFaGg4bmlUZzUx?=
 =?utf-8?B?YTF0bGhpY3JLZUJGaW5BS2pESzFkVHFlc29XcGZTbnNDV3daYjhLY0FqNmtu?=
 =?utf-8?B?YmhPellnUXdZYjJhVitMRFBrdFg3aHpWNTEyY1JaRXBvaUlmL3hiT1grOXJT?=
 =?utf-8?B?akVrcUNBczc4TS9Fd3JOMUdjeWFvVlo1NmVhRE54Ym9Ra25XaFBpZWR4ZWp3?=
 =?utf-8?B?K3BGR053bFFCa1lPcWNqTU9Cbm1mTU5Zd1ZyeVMvZ0JteWNjWnNwYWxuYWRh?=
 =?utf-8?B?bVVIMW8rS2I2aUwyT0RZc0FkZURKcGpSZmxwWnRwcW1hRGorVGkwTTU1R1Zu?=
 =?utf-8?B?MEYwVXU0bkphZnpmUVVXclVQMElHaWRiWDQvSzV1dXE0VXVZRnJ3cjBnWnNh?=
 =?utf-8?B?Zm5sMGRJb0NvRUlWOGJvbVE4Z1k2OGRjQnppYXZDaTg4Y3AzQjN2U2VuYlI3?=
 =?utf-8?B?VmloUllXTHh3Wk91VkEwSzdLOStzSWdFQmJhK2NSditKQW1DMUtYUHp2cGRv?=
 =?utf-8?B?dlFzcjRrRUVETHgyOURveTcvUU1YN09FNnlsbUdSdXJ5UE4vQlUwd1FMVHJp?=
 =?utf-8?B?TVBIWEt3UWpZRTlKajF0Q0FVbjNWWWJkeWNjZEtVN2V4Zkh0bTBEb0NqdWtk?=
 =?utf-8?B?TXNSWkJaTC8vMW00MzZvTzVpN2pRSVlybDBrSE5sT0VHNkY5VElZalg1cUNu?=
 =?utf-8?B?SUhuVWpTZE1PcWdPajN2aDR3NkZGaEZLUFRIUTJ0QUZnV0U1NUVMWVZucnZr?=
 =?utf-8?B?S1ROUERVckUvczNSRmdsSVpTRGdSc3dkc3RWSy9DT2VoUDVveVpVMzZvY1h4?=
 =?utf-8?B?RnR5bzRwOUlpNldTelNndFA5VE5HbXpub1NrWlFzYWNEZFJxYUhMamF2OHNw?=
 =?utf-8?B?eEI4SjBGZi9vV1E1bnJNRGlpOVNUNnNxaWMxa2dvWmhFd0FIUkNpYlBsV09w?=
 =?utf-8?B?MEVpeWZJejFZVW15cDNTL3Y4NGtRczlFSlB6ZkJHUWNWZ0hzckIwdUdqdXFs?=
 =?utf-8?B?YTF1b3BiU3R0c1d3U21aRE52aVNlMWFBMVhYSHNNSEFRQUZVc1FFOHByTDhx?=
 =?utf-8?B?RW4waEI5K1lrd0ZjSTJrcGcwTlpwNDh0RlRHTGU2YVBWV05vSXp3ZjdHWHpD?=
 =?utf-8?B?Tnk5N0RCVlpCY3E1RVBXVFJkV0pHYzgvR0xXaGYvQ3dLMEZXSW52eUgrWVlz?=
 =?utf-8?Q?ndQ02FPLzbuT+HuJ+UvjQg6Sk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3da957b-311e-47ee-61b2-08de06505ba9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 09:52:13.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0RDNjjxH3vRagceU2XMNKddb4Sn8QPif6rYNaF2wshAE0M5foM90P9zTdI65uXPn2zWOecny9HonHO4ylZevg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

On 10/7/2025 6:41 PM, Jason Gunthorpe wrote:
> On Tue, Oct 07, 2025 at 05:38:48PM +0530, Vasant Hegde wrote:
>>> +		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
>>
>>
>> If I select CONFIG_DEBUG_GENERIC_PT=y and boot AMD system with V1 (Host page
>> table), in some cases we hit this warning. Code path looks ok. may be silence
>> these warning?
>>
>> [   31.985383] pt_iommu_amdv1_map_pages : oa 0x208b95d000 va 0xfef80000 last_va 0xfef9ffff pgsz_lg 0xc pgsize 0x1000 pgcount 0x20
>                                                        ^^^^
>> [   31.985384] __map_range_leaf oa 0x208b95e000 va 0xfef80000 last_va 0xfef9ffff pgsize 0xd leaf_pgsize 0xc possible_sz 0x1ff000
>                                              ^^^^
> 
> oa advanced but va didn't. It's a a little bug in the warning,
> since it doesn't recompute the va each iteration.  I'm surprised the> random
test didn't find it..

I have not tried unit tests. So far I am running on real HW.

> 
> 		if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
> 			pt_index_to_va(&pts);
> 			PT_WARN_ON(compute_best_pgsize(&pts, oa) !=
> 				   leaf_pgsize_lg2);
> 		}

Verified. This works.

Thanks
-Vasant


