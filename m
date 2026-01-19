Return-Path: <linux-kselftest+bounces-49316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01A8D39BB6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6DE330012C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE9C1B87C0;
	Mon, 19 Jan 2026 01:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rEVQRj8B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D342581;
	Mon, 19 Jan 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768784471; cv=fail; b=U7HSVLlYf7Ahgb0cADO9x7XJDjDD7ABbSRTDg/fUoeNs/kkrEiyVR/I5JNWMmdXlwJlpeyFYe77Ds8ttXhkOyDc/mCch4RTHqFjrfnkNWK+A1cx3BPZDmqeydXh+B7Lg3PyWFpEDeFGqi1tACndH2LQDNisZdgsQgA9a9+jF95I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768784471; c=relaxed/simple;
	bh=WcNLW3QC/K5mLMCzgp4WhY1QDu5vn/bZIcLkDTeuQgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEdVO7d68IsrTys+fWQ1y6jtFpsKCiuFDKjxSOliLWkA7lDzRAjo9V1AN0u5uyYA2lQWme7DKKQO4ZMvneTLZ0IQnipdkfjHY1HlizVk7/9Ck+b03vjfNH6DTrf7L49y2J/up/kQ0K/1M6eu8YebLGJCwhegaMs+odILSj5WwXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rEVQRj8B; arc=fail smtp.client-ip=52.101.48.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neHH5C0fycOyapWj05vq9jO/Uwe1pGyWGKgNxUso556fJnf2mE/Sgq4JYPRV/fri4VF/fRfh08YFbqTZWkPTzTJkdcyIEwmGOKuPNWUD+fXHC/4V6Rb736izUzToiPic/717VzYD0PFjTCYnzkleEHmJn9Z5yQvjEoIwcmDSiXPsPMgz/eaa5zc+OosAfjAdggQR759bmHCmpr458ScgBDDTZGGXmkxpmY1GWuXJI+0+9lNJJmtt3P6JbNw0aFpMG3ILk3d+Rlic9XoaLGr+BptUTmac4/HLGN3VbrgLBkhFoqvYfiEzlmf2nhEFWK5obRsDGs7Y0XOr3fgYVoWP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsOVGdEeRIfKvwx5Fbs7466tMEZxcXUJWyGaAB9BlIM=;
 b=DLt2StKp7NnZuypFelLgYP9zVTH1L32ne8tjWouSonJqgk85/HGaMordZUOLeS/HPzB7vJfdY3jiZR4U7twCmBy9ypmVZKUGi6wm360b5eNIMSkTAp22JsLLTIbvL/rm0015OzvKMpq7W5a+RNx4C64pdfjLC+aoREx7Tdol5ZjH/mQRHFLdOgdEbG8CRlFd/7hq7AwOdSIKvk4m7csY7iGaYjm7QuVKvCPgVfW6NsEvc3SRldTlNwsExnI9vlwGCQqbd+iqvTAU2wnBESUBAcvY+GH5dZmEbDvMOpK0AtdB0B6PKJ+7P57EBqGq8Vn0Bb/JdUBTwM3u0Lm48a53Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsOVGdEeRIfKvwx5Fbs7466tMEZxcXUJWyGaAB9BlIM=;
 b=rEVQRj8BwdizYvb9YzcfSd+xGWqozCHDo4QGqrvKBbeagiPrZowDwb/cderJThhHFtdwmPgtEg8BN5okfUcuzivPNGugGknFs8cmMcEn18BYb7oePV671PZx+RaD2b/I5cMc60BVfpEgE++acgVCV+J4tSZTHxcPzgO43+8IJtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 01:01:02 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 01:01:01 +0000
Message-ID: <e0514ec6-b428-4367-9e0d-cfb53cc64379@amd.com>
Date: Mon, 19 Jan 2026 12:00:47 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v8 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <7-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
 <fc4f0354-4e6d-452d-abfb-fe24e53253a2@amd.com>
 <20260117154347.GF1134360@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260117154347.GF1134360@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0155.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 383f7190-c7c3-4707-5887-08de56f636ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3lwWDZwVWo1dlhvcDdsQS9RME5SdWFiSm9tZE9GTW5ZT3ZreDBTK0dQUjdD?=
 =?utf-8?B?R3B2c0dJRjVidkZxWVM5TXI4K2hXb0ttR2dXU0hmTEtxOU83Rk0xSzZyS1dR?=
 =?utf-8?B?a3pJVWFIU2tPU2ZCL0FDSjgzKzR4NmhWV0FUbDk5QkVXRm9RcmM1RXNlUzlO?=
 =?utf-8?B?NVJwaGhhcDdEMGN2MmxDa0tTV0NOanFra1JwV2hkZmUzd0NmVzYvUXBQa2E1?=
 =?utf-8?B?QURHNnFoRzlZRmhsMVN6WVVBck1NeGR4RnFIYVN6cVk1T05sR1EwQ3F4bVQ4?=
 =?utf-8?B?UGRRZndOcFRoVHZuSnJFMGUrS3AyWVFkdFZsc3lqOGlidVVsUEV6SENHY0Nu?=
 =?utf-8?B?ZjZBWkNxbXFLczJpY2dnbDhzWW1jelh1MkdDUy96Z3p1VnJuN3lteFdoSXB0?=
 =?utf-8?B?WVA4UFJHVEg2WDJSSDlEVS85NnV1WjVibEJGa0FaR0h1M1ZtUEN6WmptQStX?=
 =?utf-8?B?cEltWThuT05KdzB2dFJMRTBsV3NjZ2ZhczRDVWdrUmM4VHJ4cSs1UWVkT3Vh?=
 =?utf-8?B?dFVHWlZvK1BIY2MzYnBnOUxOL3d3dDRnQ3hCQm1GY0IxNFVha0hhN0R0RVEr?=
 =?utf-8?B?K1VpbitwSEsyeDI5c2tMKzVNQy9pUWR6NXpWUi9IYmluOHU2bTFsdGhJQVJi?=
 =?utf-8?B?cy9PYkZBWjBvcVg1bWN0K3dxaUQ2ZmZNTjR6NGFzVnl0eDRBWUIyak81VUdY?=
 =?utf-8?B?WEpEMExLd1A1NEVhWWdFemhObitRbDNRa1RhTkJKVUI1Z0o3MUl3dDBBNzRm?=
 =?utf-8?B?eG9LQnMxY1lYVGgyVklkTmNLL3hEamRueWRuS2VwN2VxNXhIcGV2OGRQLzBO?=
 =?utf-8?B?YnNPMWZXb1hKT25zb0p0VVFHSkJHajN0Skpvc2Q4dUV1WHRvQmx5RmExcTNR?=
 =?utf-8?B?aVNlZGExeUZkazhJdjRUNS8wNi9VRVAvSk9YaXBsZVlEeTlUbG91NE1VQWp2?=
 =?utf-8?B?RzEycWRRbEM3dU9ibjA1N3loaTRoalBlTE5rTkwyNkxiVVE1TzJ1Q2Y2V09l?=
 =?utf-8?B?ZlFEZDFxNS9NRXVzMVlNSlNrYVRjcmtaTUNTdGR4UXpycEE0Mmlrd0kxdnZi?=
 =?utf-8?B?L3pjZ1lzd3ZxbkxQSkY3Zm5TYS91UUZxWWtja1RpSkJ4TW1YRlBHdmhmTUcv?=
 =?utf-8?B?TnRGaHZZOTkzeVF2OEh5UlNtSkZORko1UUZ5Y1U1RklpNEdhT1FTSzZYM1VO?=
 =?utf-8?B?TXZldDROV2lqY2Z6dHphZXNpSjJUUnJ2SG96YWVWeklPUm03anNNY1k0YkRO?=
 =?utf-8?B?SlBvSGxqREFpaEVXcVJuV2VqWmhMTGxqUkZQZ2lmNHhlTHpjWVhLeDUvOXNZ?=
 =?utf-8?B?d09lWHFKOXRqMVB3ZnB3dnB1SWZMWU5lYjJqeG1hMXJ5bkNIVkdkaTRsODE0?=
 =?utf-8?B?Y1ZOVlh5Wi83RUZqUyt0SVFFT085YStPQllpYno5SFBoR0pZQWF4SFdXa1FW?=
 =?utf-8?B?WDMwbUloSlpyRTFkQjdNUlBUSUMxZVdiV1RSdzNwL05jeDRZWDZ3Y09HK1V2?=
 =?utf-8?B?TVA4Rm42cHAzeFFaTVk5NnZFZzdDaXpmdEtxSEJvQVd6TXhHc0dlZUlxNDdt?=
 =?utf-8?B?a1BYclNad2xBLytiQnFFQmhxeXVRajhHSEhZQm1tUXdhRFA0R0pGZ21aeHor?=
 =?utf-8?B?VXZuUXV3YTFEeU1tRUF6UzV1ZXRzc2V4MHRrM0lQd0NRaVp4R1psbWNhclZW?=
 =?utf-8?B?NXRWQllMZ1FGc2RuS0lYUGwzT01Hc1pKeHVVOC81dGQxTTdLSFB0RTgzYXBC?=
 =?utf-8?B?TUQ1MlBDTWtZNjBHTEZuakE2ZEdvdDFBUWt6cGQwa0NERllkTzl1aXlkaFBy?=
 =?utf-8?B?WTVUbGsybk9qd1hvRjZFcSsvdE96aVBpZmdpUmYyOVJEa0dMb1VtM3Rxb2xv?=
 =?utf-8?B?bVcwazkwWGlwdVI2TDVscGwyaHdHSm1maFFUVFpOZElqaC9aNEtCSmJpdzg0?=
 =?utf-8?B?c3U5M2tsT05aVnlZQlpFVkdTZHJHQW9VL0MwNWp6b2RXNXRrOW1aZlh1a0sz?=
 =?utf-8?B?WmVyQ010OUw0V2Iydm9XZnBySXgvN0o2MUJ2L1BLWURkNkR5czdqc2JVbU4v?=
 =?utf-8?B?L0pqcXNYVGFlV3RlWkxPLzNsb29nZm1sUzIyOTdMZldIOXpBLzhsVSt5UHlL?=
 =?utf-8?Q?Drqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjE3cHY3UXczV2JMemlLWTJCNlhiWUhXR2dZMkxTdUlMUXlYbGY2QW1KbjR5?=
 =?utf-8?B?Z1VxYm1GRXo2OC8xWWtRRWMvYTNRUE03YU4wanhpRVRHZzYzTEJwdW9hR1pp?=
 =?utf-8?B?VUNQV1crTDhMOU5PcHRwcmhSZHpHSUlTcjd2V25BWElkaGN6N1J3Vko5Q3Mw?=
 =?utf-8?B?SXhTSXNnZHJNaWZTVm9rYmcrbmVRUzhyTmVoUlgrM1JjSGR1Ry9HZU9ndXFI?=
 =?utf-8?B?dElpc2p3c0FZd3ZvTTBmVUN6cndQZzNwS2JKRkdEMHNUSk9UbU5LeTJxaWh4?=
 =?utf-8?B?VHJjVVlpZXBCN1hMMkVwVExhSmVQcFRQOVRyeDdwK0svZWJoNWZSOUF5YjBW?=
 =?utf-8?B?R0pxdVFNdW9mZkU0YlpwOFc3Ukpta21xMlA5eDJsR082S21LVnRtbFI3OVpL?=
 =?utf-8?B?MDNqWlkwU3R3akhiRVpFMXNveVV6REZuVW1BNWdkTkpZR1QzV0R4d1c5N0g5?=
 =?utf-8?B?R3hjR3F2WWdyaW9KaFBLbHlZOXlReFIveklrRFF1MzFRYUt3VnlJSDZRanJW?=
 =?utf-8?B?dWFEQ0FTcFV4VDlPTENaZmxxcmtHUnlGQ2hqRUxzOW5lN28wL3VCWS9MWlR2?=
 =?utf-8?B?WDJqWjIrMjZmaHE1eGU5VndDRWpOMTlSNWxHcnZCS2IrOWhHSllyLzk3TVhi?=
 =?utf-8?B?UnhscFhKNFl4N3N1TTVnSGd0QUlBd0w0dXhtWmx3RmtheUFOTkpwbU4zc1li?=
 =?utf-8?B?dWxocERsWWt0VEFrUWtCU3VPTXNLNE16RXFPRDdSSGg2TGtFL05HQ00vQ0NO?=
 =?utf-8?B?UUJ3UThCRDdmdXloRW1IL2hMYml2bTkvS3JZVnFSZUxLSEZrUVRIalFxNFZs?=
 =?utf-8?B?MHBBVXRVbTE1QmtCMVNHT0tIN3JyeC9mV3o2cUVzUEpubDgrZk1qVnBWTSth?=
 =?utf-8?B?d1NlNXdSRXpvaUsvaVdzTTdPSFFFQnJZbHhPNFc5SWg0Yi9JTjAyNGs2ZHlx?=
 =?utf-8?B?aDhFaGtmM1AxR0phZnBNMVNlVXp3ZmxYeXNreC83ang4dE5JeDRlZlJYQWNH?=
 =?utf-8?B?aTQ4YXdmamNSQUFGUVhUM3EzQ0JWVys1V00rNmgyZktKeVhoSzRYdmZOSEZq?=
 =?utf-8?B?OUdHTzhndklVQWdSNU8zUFZlV1FwLzJhU0lrUmRtYWY3a1gxcmhMZkdwUFRK?=
 =?utf-8?B?REJtcVpYcU9nSGlZVHNJY0Y3dHAvcW9leE1pUjh0SkYvSUg4OC9DSUJQU01w?=
 =?utf-8?B?MmJtYUwwUWFyV0s4Q1VOM29SU2dtaUpBVGRFUUN1R0lnWGw2cTkzRWtmc2dB?=
 =?utf-8?B?NEJYQW9JYm05R3l1QmxSUFRKQWhqUC9SSXZJaVhGYmtPL2VKM1NPbmUyWkZz?=
 =?utf-8?B?V3dBSlZyZ2FKRGVlU3dYd2tuaDRlMHAycEdlaWtNVVI2MGpuSW1SOTNnOHJS?=
 =?utf-8?B?OXE1bUFKblVSYU41VndKZlBYRzBZd1dZdVpYdDMrbDdRSExSWmNlNmNjbkV2?=
 =?utf-8?B?Z0N1MnhzV0lGK0VhTUJNSDVQeGsrb0E3clhZVzVFUTZTd2tNNllLdUhnT0li?=
 =?utf-8?B?MWZISVA4eXY1ZUpRZHpFK1lPS3h3M2dKa1J3aXFRbHIzazRVMXdHRWJtZFk0?=
 =?utf-8?B?R3EvR0gzaUtMMEN4c1pkQnM3UGFnY1JYK2NNaEc4MkhtMXNaR1Q0RUwzck5v?=
 =?utf-8?B?dzZoYk9RaVNYcytMZVNpclhhZmRPZEhzdHdkaDdaaGlncWxvSkVvZGxtbWJn?=
 =?utf-8?B?YUtqK1NQeXY1a3RUU1pwa3VyU0dEL1MzWk5UR0trZkxzbFhLUnN1WkRPbnVT?=
 =?utf-8?B?MjhvN0ZjdUsrMGZHVEtRWWN3RUtoWGZUaXJzTkFIYktBdzh5VDhFZFZqdzRn?=
 =?utf-8?B?WWNHQW5xY3hKSzlZQWlyRmw1QjRYeC8vTk5tdGI1dHp4bEhCcXV0TjZMcUtO?=
 =?utf-8?B?eFNFVmVzMGJKV05ndGlBSnh5b2s5SWhDQURiUjJ6aTlPeVVHME1INnhTSDds?=
 =?utf-8?B?c3NCRThmTDdZanBxaEZRMGRXOHdnUzZGZTJTUkMwbXMxWHFXNXVJY1BmZ01p?=
 =?utf-8?B?YzU1Nk5rM2NnTXR3VEVNc2cvb3BwWG05M3VJOVZRa1dGRXJiWFJScTl5T09Q?=
 =?utf-8?B?bXQ1Q2xRWjd1SWZ5SEZnbExaZ3FBL1dOLzQybWo4NU9KN3FkNjBRVFkxRWxh?=
 =?utf-8?B?OWZnSndyRDlFOWF2L2UrR1pLTmpGOVVDY25mRFBxUXJvQ3k4LzhqZEdnUTBr?=
 =?utf-8?B?QjJEUlBZbHhrMDR6d2tlcU05RHNONFZKRWpMRTk5MHluR1FKdG5Ha1hMTTFQ?=
 =?utf-8?B?bzZYdndSRW8wT1drUDJieVYzdFV4SHNIS21qNGdMTHZhWkdENkxSamFNWnFz?=
 =?utf-8?Q?Q5qUrg/dDcbJFknFYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383f7190-c7c3-4707-5887-08de56f636ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 01:01:01.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nmGIGIozDeXhGtKvR9SmLE06VgELqt2HkXyYgPyxro5h21rd+RVBrhzl4gLlN3GIk3CUbcmYMzPWAhWG2hj1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897



On 18/1/26 02:43, Jason Gunthorpe wrote:
> On Sat, Jan 17, 2026 at 03:54:52PM +1100, Alexey Kardashevskiy wrote:
> 
>> I am trying this with TEE-IO on AMD SEV and hitting problems.
> 
> My understanding is that if you want to use SEV today you also have to
> use the kernel command line parameter to force 4k IOMMU pages?

No, not only 4K. I do not enforce any page size by default so it is "everything but 512G", only when the device is "accepted" - I unmap everything in  QEMU, "accept" the device, then map everything again but this time IOMMU uses the (4K|2M) pagemask and takes RMP entry sizes into account.

> So, I think your questions are about trying to enhance this to get
> larger pages in the IOMMU when possible?

I did test my 6 month old stuff with 2MB pages + runtime smashing, works fine, although ugly as it uses that page size recalculating hack I mentioned before.

>> Now, from time to time the guest will share 4K pages which makes the
>> host OS smash NPT's 2MB PDEs to 4K PTEs, and 2M RMP entries to 4K
>> RMP entries, and since the IOMMU performs RMP checks - IOMMU PDEs
>> have to use the same granularity as NPT and RMP.
> 
> IMHO this is a bad hardware choice, it is going to make some very
> troublesome software, so sigh.

afaik the Other OS is still not using 2MB pages (or does but not much?) and runs on the same hw :)

Sure we can force some rules in Linux to make the sw simpler though.

>> So I end up in a situation when QEMU asks to map, for example, 2GB
>> of guest RAM and I want most of it to be 2MB mappings, and only
>> handful of 2MB pages to be split into 4K pages. But it appears so
>> that the above enforces the same page size for entire range.
> 
>> In the old IOMMU code, I handled it like this:
>>
>> https://github.com/AMDESE/linux-kvm/commit/0a40130987b7b65c367390d23821cc4ecaeb94bd#diff-f22bea128ddb136c3adc56bc09de9822a53ba1ca60c8be662a48c3143c511963L341
>>
>> tl;dr: I constantly re-calculate the page size while mapping.
> 
> Doing it at mapping time doesn't seem right to me, AFAICT the RMP can
> change dynamically whenever the guest decides to change the
> private/shared status of memory?

The guest requests page state conversion which makes KVM change RMPs and potentially smash huge pages, the guest only (in)validates the RMP entry but does not change ASID+GPA+otherbits, the host does. But yeah a race is possible here.


> My expectation for AMD was that the VMM would be monitoring the RMP
> granularity and use cut or "increase/decrease page size" through
> iommupt to adjust the S2 mapping so it works with these RMP
> limitations.
> 
> Those don't fully exist yet, but they are in the plans.

I remember the talks about hitless smashing but in case of RMPs atomic xchg is not enough (we have a HW engine for that).

> It assumes that the VMM is continually aware of what all the RMP PTEs
> look like and when they are changing so it can make the required
> adjustments.
> 
> The flow would be some thing like..
>   1) Create an IOAS
>   2) Create a HWPT. If there is some known upper bound on RMP/etc page
>      size then limit the HWPT page size to the upper bound
>   3) Map stuff into the ioas
>   4) Build the RMP/etc and map ranges of page granularity
>   5) Call iommufd to adjust the page size within ranges

Say, I hotplug a device into a VM with a mix of 4K and 2M RMPs. QEMU will ask iommufd to map everything (and that would be 2M/1G), should then QEMU ask KVM to walk through ranges and call iommufd directly to make IO PDEs/PTEs match RMPs?

I mean, I have to do the KVM->iommufd part anyway when 2M->4K smashing happens in runtime but the initial mapping could be simpler if iommufd could check RMP.


>   6) Guest changes encrypted state so RMP changes
>   7) VMM adjusts the ranges of page granularity and calls iommufd with
>      the updates
>   8) iommput code increases/decreases page size as required.
> 
> Does this seem reasonable?

It does.

For the time being I do bypass IOMMU and make KVM call another FW+HW DMA engine to smash IOPDEs.


>> I know, ideally we would only share memory in 2MB chunks but we are
>> not there yet as I do not know the early boot stage on x86 enough to
> 
> Even 2M is too small, I'd expect realy scenarios to want to get up to
> 1GB ??

Except SWIOTLB, afaict there is really no good reason to share more than half a MB of memory ever, 1GB is just way too much waste imho. The biggest RMP entry size is 2M, the 1G RMP optimization is done quite differently. Thanks,


ps. I am still curious about:

> btw just realized - does the code check that the folio_size matches IO pagesize? Or batch_to_domain() is expected to start a new batch if the next page size is not the same as previous? With THP, we can have a mix of page sizes"


> Jason

-- 
Alexey


