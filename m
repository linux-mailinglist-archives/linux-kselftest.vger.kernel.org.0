Return-Path: <linux-kselftest+bounces-42930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9D1BC8E0A
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 13:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C631886ADB
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 11:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FA2E1746;
	Thu,  9 Oct 2025 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C8oU8yWQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42152E0939;
	Thu,  9 Oct 2025 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010218; cv=fail; b=k3DA1dtyiZ++gk5spbSs0sLSs0V7W8dK0XSeQrU9IdyKlh8VLGo3aK1jC6+iLf3e4p3fsfLF12TslOtoK4DqefFntiauhDS4ppt0qDjBNSTLOL+mFlSOq2KKZLC4oRz6wmsbb3jbLf9s9CUwdeI59/a4C42mluwyIoMnmGRBAr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010218; c=relaxed/simple;
	bh=H2noSx38XU+SsEHc3CLSB5WBBmql0eZdlLYbryQugTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olcycjItya0vlGETzXKj/s9ujI7ewqthxBBhUJfGVroB4EqSt6bnU8uxi4++GGj/enFp2muyY7CivL0esXtxebH13kcVwlkIPo4ZUE1jyhHaWcKp0atfsO55AA70Daxt4DeWdO8JuA3U3WsjOqKWS/zMgjLQil10U81vb9G6Pzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C8oU8yWQ; arc=fail smtp.client-ip=52.101.52.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcPYddNkO1yskEndB3lhVUWkF5bpK2cH+T/IGQiAakFpW6pJ/Gf0v9rRB1SvoM3Daj0mvMKMYxJKXqbHsiVnEBz3wklBfh7hTEimNxc/ilAyQBCKLDYO2MPSTZ3fFM4PoCUQexMtSLtHKXPs3Y2BK4psJYtx4l5Tszh76YOYrs3kr4S06a3tXnWhm5tlMpF5WrosbHIA7tWlrcPgPEHkFgeiVerlZIAfoZ6pE/hi0i3JrzDbxU64/waL6dbn7rB+KOPxyKzCK6/nD2vU/dAxJSK26/DJUUVFPZkxqPKVmFxl7wtvbn6TNgupNoejCLZF1+ItjOdzzf8V4uIz0n4Lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4fpd1vW9PBUxA8/4DWLIDn0Ze1AKMP7pFkQmIakdgc=;
 b=ZJ3XFWnPaO997LXijY/xP6YRIIj0bmpPScAFpziQLtkmdyN8+P0t9xpt/m5GvFgXN+ktUgUOtmGAuG+ZmsH4835IdF+vJeYp1aiaSXTAmnKNCuYCI8uQ1V2H8W8ag6UA5P6SVS/kIpwBITa54/AMrA0bs+//tQwpo4v2mF67oXRqKvecniLs/p2AsvNdHrnAM9oBQqTMxtpa7hOFud87zDDCDxEOfHUUN6r67OVzH2TxLl5wRw+1PMwHPtAXJ1zIC82p9kmJBZWC9i28OH+jhLTByVLFDbcTZFl/l+TQh15OlAJ2iN5yi9mfOIUE28vrO1h/EWfBfvcFtDNRJ+xK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4fpd1vW9PBUxA8/4DWLIDn0Ze1AKMP7pFkQmIakdgc=;
 b=C8oU8yWQOt7eLetCz6AJT0b0MNeNp5unanwK3PycttpN2z28pJOQHb/9jauIirb0Uumk6WNtxnmOEs/KOANAqbrjEFgUhS22VIYioaQ8KoLqQJ5wUV/pglpi/PBa9MOX7AwxaJSANYoxrGN83X/2wv77gkZC4kkjU1/d4zFXyIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 11:43:34 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 11:43:34 +0000
Message-ID: <6efb1dbb-7c18-4e53-b9ba-ad795a16c0d5@amd.com>
Date: Thu, 9 Oct 2025 17:13:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/15] iommupt: Add the x86 64 bit page table format
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
References: <12-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2daa4e59-f5ea-43ca-bfc0-4a29e904e29a@amd.com>
 <20251008130328.GA3765120@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251008130328.GA3765120@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0098.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: e523102d-bd0e-466f-85c2-08de0729138e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2hWQnlmL2R4QVNIcUJrZ3ZIUVFrTXpaL1ZKamZmQmpQelAyT1oxY0ZvUkZJ?=
 =?utf-8?B?VnBWSWN0d29lTzRlR0l4N1pkeWQzTkcvaXlsTVhQc1M4cVVkMTZiUDl6dk1r?=
 =?utf-8?B?d2t3cG5lQWpKWjMxYXhGQ0QwK1lrQWg3TEU4U0dmcUVXc0tkSThJc3pHYkY4?=
 =?utf-8?B?dWIzMXlwL1M1SS85M2JKQVAybG4zT2JybHBmaTg2R2hFbWh6MDR1ajhtR1d2?=
 =?utf-8?B?QnR2K2g1OHJZWWFSc3hiTjBVUkNoZ3VDdDY1R2VsWi80VU1BQjc3NHo5dmFV?=
 =?utf-8?B?S3pvQWcyazYwT21iZ2xoVG9GUmV6NXo2R2wwb3pYUlJKejZwdmtaWnJ6cEJt?=
 =?utf-8?B?dklablZZZDdlY0g5YXRuZ3FoWEJzWUhScUxQOEFadWFlRmN0WWdNbjQxVmwr?=
 =?utf-8?B?a0RRSHpQWU9IQ2wvMisvM1A1N01Sam9rcEVROExTTFVWNm16WjMvaFlrYjYv?=
 =?utf-8?B?aDVoRjdHdVUwdnB5OFNVck9qYzBWTW8vTHJwNzN1MnJSelJiTTBmVkJaaUh3?=
 =?utf-8?B?WVBNbll2L3N3bEl5UHNUQktidnB6T2FPcEQyc3pDWmd3OW5xa0cxV092b0NK?=
 =?utf-8?B?UEZON0VQVVpySFVENlZTNi8vZ2JJRC9zYm5IcDNmaDkzUzdWcm9ORFdObnJ0?=
 =?utf-8?B?MjRYZEtkSjgvemt1bmVNWCt6ZFJIU1lHaUNSMk41OCt1YWpNMk9wbC9lT0NC?=
 =?utf-8?B?YWxNd1o5TzFGWFU5bm0yYzNoNURjUXlLbXlCcWdHK0F6bW5KMmNYR1VWWVgr?=
 =?utf-8?B?aDVORUZhbnJ0ZGE5TDE0ZlY3UEtrWkxpdEd0Q2p5anVqOUhVcE9EOHJ3NDdY?=
 =?utf-8?B?ZDFLQ0dIRWgwd2xRbVQyU203RmFUd0pOME5XOU42QmNCdHJYNnY3S1NIWkxl?=
 =?utf-8?B?cFF3dUJBNXVVTmt2M0JBVGE0TWtQa0pIbGdHZkdaOEtIN0NNdlM1RlM5cllT?=
 =?utf-8?B?dUdVaUlXV0hUbjFTWTlta2tjZDVjYm1Ncm1uZXJpcGsxNmhHRWJFQ1ZjL2dN?=
 =?utf-8?B?V3loVmNNMkJFT3ZBU3MzOXpkbkQrdTh3cnU2N2M3NzhTMnRxSTkvdzNLWGxs?=
 =?utf-8?B?dWk5ZjlpSzhtVjJZaDJSZEFqbUFKYm4ybGJvWStxZ01SOWVjOHJ1WU0vYWh2?=
 =?utf-8?B?NndWaWFCeFVwR1BxcVpOcUc0VGpwMzQrVGppbGxCR28yNnNhNkMxRnBrUGZx?=
 =?utf-8?B?ZDluTDl0RjVPblJVdjNXU3NCblJ0YWYvc0lqV3VTelVYTUtCcXcvcW5EMWp0?=
 =?utf-8?B?OGJQVDFPRGFNWHdRbXV0cnM5S0pvTytoYjB6ZW9XbTBnMjBaOEVpTWc2RDcx?=
 =?utf-8?B?Ujk2aTVJZFA0QWdBQ04xam92NFVoOWExazB2ZHBsaTFvTVpyR04vdlovL20z?=
 =?utf-8?B?Tk1kOTJIZWR6VHVxeCtYR1IwSUV1eG44T2N3aFlRWE9BRkFsdUd0cCtOTkxt?=
 =?utf-8?B?UmkwZi9WVDdjTWN1cGMva053U2pxZmZ0NEpRNXlNZFZOZVJTMTBlSDRMc1F1?=
 =?utf-8?B?MXJRZk9Gb3V6VmlzZnJTaVF6aHloNlZQZEJENXBhNU5YcFJwTkFlNjEzbjRa?=
 =?utf-8?B?RG92cEl4RDkzTk1ZQWFtcmdTbnc1OE5ndlJGYUZxdWxxRUZHY3dRcmY1T1R3?=
 =?utf-8?B?TWE3Y3pxN2hDTGR4NzB2UnlzeWNEaVpnRzk3dzlxRG5rT01MbVRmdWg2QUUw?=
 =?utf-8?B?RkRVa0Iwb2E4MVFDSTlUempVcFc4QkFHOU53T0xxbXlyMUlnZFJJaXBHUmVV?=
 =?utf-8?B?Z0lNSFNlcE1wM0c5cm90R1hkYks3WC9uYXJpcENDb0R5ZzFLN2EzOUpaRTBV?=
 =?utf-8?B?UExsYTZ5akFDUlk2dnVGYkRMbE1YTFU4OGFVczBwZVlCYlNYcm4rVzNFQ1NL?=
 =?utf-8?B?ckswK3VtNlk1SjdVeDFIbVRMYVBoUUt2MnJrWmtXdUg0czFvdGhSM29ka3Np?=
 =?utf-8?Q?6BmFPRSjCj5mzPpPgcflx6wbNlpQF5+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akNLS3k2NFpQMDBFN0hxMkRyOGovQVZDVHkwanU2Wjd6V1Uvbi9WbExFdzUx?=
 =?utf-8?B?aEU5dnN2OGxDRzF6WEVkdTJmV3pZN1NrVUZRd2VraU84QVJiRDV4TVpDWGxP?=
 =?utf-8?B?eHNEeTlyMFBiaVhHRzVKUlFiL3FmejM2a2h0bUI5aWlaVy9Na1QvM2NNSE5h?=
 =?utf-8?B?d2lLeHRYSmdhb0gyL2grYm01anh4QkU5bnJlNm1HT0lNM1lQVTFBZVhBMXJq?=
 =?utf-8?B?bnVzY1ZjL1F6ZWJWOUVUSWFVTm5Vck1DY2pPa2l1YWpLeVFIakJMdEdOc3JO?=
 =?utf-8?B?VWJyQlE5aHBwRkJyT3lMN2VJZTNNNmszc0lSQTVoZEw1dldlZjdCVHJZMFdh?=
 =?utf-8?B?eGNkaGVHSFpjMmpjQWpXMk5VbCtsakc4U0RPRThCaTBJS2FoeGNqWTArNGZY?=
 =?utf-8?B?NEg5cEMwTTRHRW16YWlBWUdHV0h5cEx4SXdtT0VyQmVBcDlha29CMHlQd053?=
 =?utf-8?B?dG9zTThEOWZsTzZ2ck9HZTBGczZjV2NXdnk4UWNEblM1NWhqcVpxT3FRTUV4?=
 =?utf-8?B?NVNEeG9CMEE3SjRWQW5sL3ZYUmJKRDRKUHR1bzE4cmt1Nk1iTlNvdkhXWm9k?=
 =?utf-8?B?ZzNVKzNsRzBTbXVqUzFqOEM1TEE4bG9tdjIrakZ3azV3dkQ0OWtJUHp1WHYw?=
 =?utf-8?B?ZGhjY2MrYlZscTBwQXgrUXNCaUJ0Z0l1UEE5UG1RbmlBSDh6Z2J5QUgzZWpR?=
 =?utf-8?B?eWVXYkxJb05KUGlxVm04SWhTMzFaZkFJTFVuWWZIOXRKMHYwUTR2Nnh3dE9p?=
 =?utf-8?B?TnRjWnRFK28ydnc2V3hkaCtBYVphb0F4TTVoZDVRdkt0WVlOejlTcGRiR0dp?=
 =?utf-8?B?MWFkZXBBbGU1WUJyTXpQd251bWR2RTJLczlqU1B6a1NjYTZNamZKWlVWSVlp?=
 =?utf-8?B?WFA1WWNWcmNqSWtlQ0RhOWNJUGx6Ym5MV0xLcjU3K1JxQnZ1WDRiNFRjemcz?=
 =?utf-8?B?TnJFYmR6L0RKV1YxMm9OcTZaQitrVllvUklSTEtOblVWNE1wNU9vSXRveTl0?=
 =?utf-8?B?SzEzM0djQms3UU53Zi9SZllBV0RTMnZyRkhBT3ZUZTRJL0dPb01qYUthM3Bj?=
 =?utf-8?B?SmZTMkdwV1IxRTFOYlhBYkhNWmM2b3JkbUZBYWxaWUc0b1IvYlRvN1pPcW5Y?=
 =?utf-8?B?VmtpMDVZQzZVVjYzQmJsald6d2pqUXo2VXJpNE1LeEx4MkJrZCtRRm5SN0tk?=
 =?utf-8?B?K3NxV0tOK1FjZVc5RTRidDFDYm5rekI4eXZjM1B0d0ZROXhCa1hVbU01OUpa?=
 =?utf-8?B?ZWlOcmNlSjF2emJIUmlHQ2lxZHhrT2dzeTA3U2RvaHc3ZllpQnlpRU9MS2pG?=
 =?utf-8?B?OVlSNU1rcGdXbjR2OVNUQmFxZ3NhTXlrNVB6cEJIV01QZGJFRjNXNGxVMUhx?=
 =?utf-8?B?Y0ZhNFpqcHlTa0dUNzhoTUljMFNlaElFYU9iaklSR2srRktaOVdmSTVIYmZN?=
 =?utf-8?B?YnZRUFcvdjQwdUVaZ25lNmQxZzI2OFNaZmdVMDl5clB0MlQrUmlPTGlQcmt0?=
 =?utf-8?B?TUltUURSVFYwYjRCeWNEUEY5Z0J5UndJTVlJejA0dy9MYTdKNDAyMTA1QmQ0?=
 =?utf-8?B?QVpLK1lsYUVodzJ3bVBRaW0xcTFvQmNxTlA0NG5vRktlVVRwWE1IeWppMXBZ?=
 =?utf-8?B?SjNiSmppV1FMWGxuQVpqZTRwdFZodTNMdGZoYmhvQVBGcWpUcXdEQmpmbGti?=
 =?utf-8?B?VFlNbzV0bGpKTFVFYUJQUWtVcWI2UUplTGdiK210RVhmQncyNzFlVmNTeERF?=
 =?utf-8?B?eTNSL294R1VPYjFsNmFFR2dmVkVqSFVkbkg5VWY3MW1VdTFwQ1ZjbmtiMjJG?=
 =?utf-8?B?SmNzSDh3QVBKV1VEdnBhLy8rVHRyZ1ZDTU5ERG90aklBa2hueFdZNHFrcUtU?=
 =?utf-8?B?VDl1b0UrSVhIMzh3U1RoVXNGQ3BJK20vV2hrQ2xaaG1oS0ExdElvSkhsaUE2?=
 =?utf-8?B?bVBESFY2eU9maEtLUGtUanFFV1dYbklpNE1YdnFJMExUbmFVSE5wdCt6ZGRF?=
 =?utf-8?B?elEyZXJVRGZqUFBaYkRYWUtmOC83NjBzVDFGNkFGQXBBaVdVUWdhUkxNb1U0?=
 =?utf-8?B?MUROMEpYcEVIeXlUT0tQaklNN2JQaEQ1YllKaFBaT2I1K0lQMDZYemhsY2hs?=
 =?utf-8?Q?3LU9k7oYKpiVfbi0+eKIT8cMh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e523102d-bd0e-466f-85c2-08de0729138e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 11:43:34.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yikIkte3kDN7MdME8nB0n6bwWdX+WTLnMDSZMO2KwqqHKDfdOv5+ZG4MqJMnOBCmnItKgJf4RdykVNHa/7+MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686



On 10/8/2025 6:33 PM, Jason Gunthorpe wrote:
> On Wed, Oct 08, 2025 at 03:35:39PM +0530, Vasant Hegde wrote:
> 
>>> +static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
>>> +{
>>> +	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
>>> +			  PT_GRANULE_LG2SZ);
>>
>> Also here.
> 
> Presumably this as well?
> 
> @@ -2166,7 +2166,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
>                 return ret;
>  
>         pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
> -       ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
> +       ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
>         if (ret)
>                 free_gcr3_table(&dev_data->gcr3_info);

Right.

-Vasant


