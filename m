Return-Path: <linux-kselftest+bounces-44515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3698C2448E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 10:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 756244F26A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9432337B9C;
	Fri, 31 Oct 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iICN/kLU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA13337BB2;
	Fri, 31 Oct 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904318; cv=fail; b=TBoMyV/2R45wqYe1WMfsy4YW1PGGIdNojQ+2WXwqoq7f9Qd0vhXNK7J3YKZufOE4LIUf3us7SnNBS3JO/hrowSE7doyfmyS8HXvm6P60LJgXMPlvZ7F+kIMjs7aInxIRNP6txOEh4nPzvdvwBisDxZgr5/z1kdm0IvYO/Ay+k5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904318; c=relaxed/simple;
	bh=LiAgk5N9bQevBSZeLSo2JjiqSD77CjiumFTGP+Yu9tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RAxC491s2kXOe/+i4zXY2rCDzeGEWZ5GGTbxkUEkQBBiGM7LMLFOXI2PJ5MlkLP76qP+H+74BLataAOGOqFsBKBJELXRCJZ6na8z4sRuI9QNlQrQUWFhSctSlf0g4rHwQOyTpw0rhQUbhMwEHWnm3BBGwg7jzhMUshRZCTS4Dxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iICN/kLU; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hg1NRiDLNVRqrK+MzqQEecLFgRqRYzbqQvoGbHQKsXyWldPo1AJivPde9x3X6wGfIR0Z2KsbUzHrSChSvCvMBSiZoY+xCfzR/7RFluHqAt8BwHaz6X87yL7tXTp9stevoFgLuDPy/lGYcm5dkhJafQVXMW10lNq4YD2ECCKbPn4JtJbBcSwf9IKqbwYAkMIpqZ6k8jAz+pye28wxfrH0Rv3xGjgPC2U3sA03mfs+G8gS4+rWLsfnu9LhZnAiLULh1oH+YwndUF0oomaC4uSuu3VrLacrAZEMvnkXmSpESP2JeS4O/LE66ebalUWag1PL6oqHvazgg9p0/bc6Jwsnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qTxR3VCLQ8vVsWgzDdzZcDnGyoxJlHRfEcGaKUJ66A=;
 b=b5AdGPJ+pUC+hB5S0nzpc4Wsd6aEdsudbidMp/Y+YpaqHYloFBTAHazIg/iY2Ke3mpAUuL+LAWDzjASnJU2Eb4VmcYTImy8m2piS4islmpAVptRc4ZaupEFC183kYwYllFpxbG3B4MILzDUlFluJ+quRZimMzY6hFyFzdeYWi3897ZZ9cg802H0RqsSyK9DuN2ZFkf8ACx1d8ortGRNb1OpXSuRQvEb6BLlTFKVxFMvSwaawpNEq1tv262iwlZGekLDIX0cepyJriFAShVKaoNUSMH9crVC7zboqnT9t8JnbUajXLYX1Q1bTOeSzb3GRnBzbVtKTSLKHb0W0zwFRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qTxR3VCLQ8vVsWgzDdzZcDnGyoxJlHRfEcGaKUJ66A=;
 b=iICN/kLU9/yktYl3YM4hsnQGE1SmX35fbCyPqtP0Jpl+4zit895c38qZxDsY8gYriECSO44U5pu51CJ57CDhKTiFRxhhMm8zkRvkj+Uh74mxM3up0YM1qQnA22jILW9i4sXlU/JFZflVa110Wal+8SoFDAQjPIdECdL4k1jdxWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:51:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:51:52 +0000
Message-ID: <5122fcd6-ec67-4508-87c7-9a9e688f01ff@amd.com>
Date: Fri, 31 Oct 2025 15:21:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] iommupt: Add the x86 64 bit page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <12-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <12-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: 03afe266-acf7-4c8f-ac15-08de18631e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?LzByWElGeTRGUEE1Q3J0MElLOGhnN2pwSmFwZ2pnOTEvd0dKb0ZHUTlxVlA1?=
 =?utf-8?B?dTlzZEp3QkRTZ2ZuS2VVNVorWkQvNjIrenEyelJkOHZvYk5yc2pGakh3NUhX?=
 =?utf-8?B?R2hDVlVkTWducEVtdnkrNkpvYmtqY2xVMWhzZUp6ZDJ4Y3JDZDUwbnlLVStP?=
 =?utf-8?B?OGRVd3ltR1JqNWJxNktsZFMrQjFxUmd0TXNnM0hTa0ljWmVCTXpHa2JNOGxW?=
 =?utf-8?B?cFJaQ1R5c2xBWGcwYU5LOHZ6Zk1Nb1ZoUGo4THV0WTZOOVk5NUJMSG9wUUo3?=
 =?utf-8?B?Y21ET2lQeTU2YyswV1NKZTkrODgvcUVSQzE4bFRxSmlHMXlWa3dqQXB4bkV1?=
 =?utf-8?B?Y0FvV25WVTI2eHZFL2hQbW5UeTd1bWpFS2lxRGFIVTlKWHc2NW03L2xKRDk1?=
 =?utf-8?B?ZDd1b2hPSUdCK0lEcUptaFlOSisrVVFNOWtIUU15ZVpHbUxyQ3E2MW5lWTN5?=
 =?utf-8?B?UGlnWFVRYzVSUWRaSnBGY2FENXRXcVdLUU0zZ3VPQWp6cDRid3EyRlRpR3lm?=
 =?utf-8?B?ZzR6QnhNVUFhaDErU2lRRUFWS0R2cXR2MzY0ZWFBMnBFcFBhTmJyS0N5VlBy?=
 =?utf-8?B?ZnBqL1VGZ29zMGJjV0FFdzNnMklKR0xSbXlVc1J2c1c5QjN5TjMzR2tqUmRB?=
 =?utf-8?B?emVlQnNnU3RvQ0l1ZGVNT2lXanhqT1hoNFFxYm1FQmlUU2JiYzJaVnkwZVA0?=
 =?utf-8?B?T1RhQmdmQVBzcllLaUVob0xYUXF5NlpGRVovd3QwTXovSXFKRXFmY3dPTVYy?=
 =?utf-8?B?MEx6VnpaYWtLWmpBb1dLRGFMT3UzQTkrcHpvMXBCNGtmcHExREdlZkxKZy9l?=
 =?utf-8?B?MU1MU1dTZTBPTExJRVYzYyt3TWhTY0xqMk1yZmcwbFEyUDVIcnpXdytmOWQ3?=
 =?utf-8?B?OThaVmtrNXIreFFzSXZsVHBxa0M5emlDSHlJR3R2WlZGeWRlZnlRN2Z2VXlK?=
 =?utf-8?B?YjR4aG9SdVBJbDA2cTlSVk5uSjBqcDlaQzdBVHdBbG1qREk0YlBHQTJzWnc1?=
 =?utf-8?B?bFkycVJVSVovck1McHpEMmFRUUkrNGhtUkJmOGZWNjJSK1dTSlAzdHlGSjVT?=
 =?utf-8?B?dkpRU0lxd0N3dllieHpmVmxWa3dKYldzR0hrWWpFVEJDUmFPOHNSUWtET1kv?=
 =?utf-8?B?ZHJJZy90NEVlSDF6MFVxd2xBcjRmbU1kRDV6cGdlUmFEWW9NV005dStQcy9F?=
 =?utf-8?B?bkRNRXpmbW5qa2lDMTVJUXJyVlNvanM1aG1adFpadWJPeFhsRCtEa3ZxWTdw?=
 =?utf-8?B?cWI0TjJjU1RWeXlCdUxiUE5xZGNTWHc3ZzA0aU8xUVpRdGlpOGpQcXQxVFNK?=
 =?utf-8?B?S0NRUVFza0pOcWVzUTB4djRSQWgxWjYvVkxZNXF4WTJIUmY3eUtoSHhiTURB?=
 =?utf-8?B?cjRPbFFtUTF3NE5mUDhkeDdaV1JseWw1Q3ZldjBtb0JSN2M4eEtMVElXTEVS?=
 =?utf-8?B?am1tYnAxWGd0dWF0UWFZL0tjT0pYZ2cxNzEvVmphM01ROW00eDJWZmhWNHJG?=
 =?utf-8?B?dDdIRk9TU0llaTNuSCtKYmlTZVg5b0g0dktPQ2RIYTJyb3VsWldLbC95TkFT?=
 =?utf-8?B?STRNdFpPTFNldnlpdUJFTG5lWEl3T2dzaHg3ZE9NVXpmai9BeWtaeXhLVUli?=
 =?utf-8?B?ZjlPVzEwRVhjTEpCbWpSaytWZnp2Yjk0RkFrR1plZTQ1UmNPR2Q3Zjc4UUNQ?=
 =?utf-8?B?Vk5MUXJTVk02QTJMQzlTL3JaOWVERk40bHRkeDBYRXlYNHk0aFZ5cmZPMEt1?=
 =?utf-8?B?dGN2MHROa1JVcnExNnlDVjZZd2dVbmlRMVhad3VhWFArMzhqNVRmdXFGVW8x?=
 =?utf-8?B?VzMyWFRpSzVPcExNQXpRanJ3clphcTBlc2o0dHhQYStBa0xFZHFqYXYzelBS?=
 =?utf-8?B?TXY5d0VoTGMrK095Z3djakowWC92TzFCWGwrbzNUbjRTTmwybmc2a3JpL1Ux?=
 =?utf-8?B?OUluWnhMQzlNNEt1OG1rRnB4VHFEK2VaZWlwcE4wZkhtWU1pL2NFZm1YZ3da?=
 =?utf-8?Q?FMlC1TP7UwohoOBBcXMje7bTEZqQiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRjMXZsNmJnbXJBRndiTXJabElBQUxzQkltdVBXSW9uV0pEOEtqaDE2RGRT?=
 =?utf-8?B?Sytla0YySlhOWm5CcEdXbUtvKzFHclVmQlhOMDY0MXJnSEJqZlcwOStNUENP?=
 =?utf-8?B?cWdPMU16M0lNNFJxWEM5NnFBazNpU2I4ZzJmUHhDMUd3MmJWRDFmVlc2bWFO?=
 =?utf-8?B?bGp1bnRNc0M4NGswMHVSampOcGJ3djdIaDBZVzB6d2szVVFFUWNPdzU0bkFl?=
 =?utf-8?B?eUlKK05DYzRjaTV3TlFtSlFBNjhHcHVsT3dLYkxRS0EwdDV3UVZ2cUtUdm9L?=
 =?utf-8?B?ZUxjQnZJdlB2WS9yTDM1RHZ4SEtrUGxrdURpU1g1OFl3WXI5WWxvZW5MTXUy?=
 =?utf-8?B?aXpieDNJZlBXK2pxVDNSYzkzZ1lST3pvdDF0Zk96emo0aHd4R2tkU1g2bisw?=
 =?utf-8?B?MUF5U0EwT2tWVUtDUzB5dG90OGpNY1h4M3hKc0NJK1ZYRkxIRzJDa3R3NHV4?=
 =?utf-8?B?S1lER3YvdGltdW1HY3hJMTcrWHhjYzFrTE4wYXY0bVV2MjBVSjNzbUo1WHZQ?=
 =?utf-8?B?K0VnQVpiM3JLSHF6MXpTZEJyWDdxbWJtZnI4RkVvVHQ0S2FIT0s0eWJvRm1W?=
 =?utf-8?B?YkZPckNVQkNKV01SWlhlVWVnOVZvN21mbW5GSW4wR1dUSlpsMVRTRkI4Z0Ny?=
 =?utf-8?B?RkdmcXVlZjRRZ0ZUbHZsbjJNMnhWc1hDSmFDcEZScEFQbFpmeVJzVVVZOTJm?=
 =?utf-8?B?TEZvc0lrNVdnUDlDYmVOM1RzRU1jemhyTm00Vk1nVG9MdHhhUDlTOUFMbUJa?=
 =?utf-8?B?YU4yUTRWdnl5Z201b1JwbzB5Wk9qNHdhMkw1MFlNd1R0MDdEUHZpVnFxVFg3?=
 =?utf-8?B?NDRrK1RnN0QycXBlRU04UTdHWmFWRk5CS1Zhc2o2d3c2Z0R4bENwV0xXbUsr?=
 =?utf-8?B?QXFxbFYvNHZxT0FSTHFzUW5PaGxVN3VGUDZaY0hBMXYreUhTTmNDTWZLRzJj?=
 =?utf-8?B?cEp5ck5seXFObmhMQ3RJeGkyYkhGeEI5Z1lHUnlPUzJOSkpEczB3THFWdFd4?=
 =?utf-8?B?SzlRMWVxSFQvbjFqbUtiMUVNY2pWU1AzSkk5dTRBUkxjZnh0UUhLZ0ZEaGRy?=
 =?utf-8?B?L29mRm5wQXFhWkVsS0JxZHJ6SE9ZdDZNOUdHQldYaVU5a2dwdHphVThROHc2?=
 =?utf-8?B?NGRQKzNrRll2djg2S3pMSWRrNXdWSGRVdWVyNzVsbVFjTEdvbkxoK3BkSmt0?=
 =?utf-8?B?cW8zQzJQSTFZUUQxRGFSaEpjUlREZ3huRGd5akUveG1Lc1hhcjdxQk5HLzVa?=
 =?utf-8?B?eDBoQnZ4Vjd3REJGNW5OcHdCdW1KZGp5STR1K0NpSWtESnNCeSs0NWpIQXZz?=
 =?utf-8?B?OXFJUytpMHNtU09FVTI1eFBJbERNRGdOQ01ZNjAwV3BtMTRHV1ZISzRscmdY?=
 =?utf-8?B?R1RKNUxkYlZzL0FrV05ZMGtyQ1p4UnQrUmZGUGR5OUQ0M25GWHN0UTZZMXRq?=
 =?utf-8?B?cHJKV1JkZFJxdFRodXFPY3FpeGJEeHIxbENkQTdHVWFNQUJVQURXZW94N2Nq?=
 =?utf-8?B?V0ZGVlV0dHQwb2toek4rcFczaDVRcHZmSUd1WUxEY1F2NW1mSG0zL1FUTVNH?=
 =?utf-8?B?WHd2K1JLaEhWbW5UdFQ3MHMwWVNpUWJiN1M2cVJZVkxZSGxQbzNUMmFkYjdW?=
 =?utf-8?B?amVhT1F3dTJlcWFIdE55R0Y3NUlTYS9Wck0xNmlyK2cwMlhld3RmMFlXaVhP?=
 =?utf-8?B?TVJ6N3pSbklBZTUyWEZESVZMc0srR2VLV2JiM2VlNVJEa1IyQ3BXTGpEOXpl?=
 =?utf-8?B?bGw1SXE2V1dRd04waGtadlBBYlJxaGM2NGRCRXg5RHFTMi9iYzVUM1MwN0ZS?=
 =?utf-8?B?QW9oakluN2YyTjRYVXQ0VHZsRlNxUzlTWkVXRVo4cFdQWE1xYVhDYWQvOEhJ?=
 =?utf-8?B?bUgwbS80VzlmaTZHRmxGUUlVK3kwQWdNSHJqSUZzZEx1QThzU0QxbnE5L2ZB?=
 =?utf-8?B?RFpzWlVCRWVuWStKc2hWd3p1aWpKVFA3NUJmMXcxMTBIdWdYSm9IQ3EvenNx?=
 =?utf-8?B?SWp1Y2dDV2ZsR1pMUWFlb1hwR1RjMnFoMW5QNnpua1RWbHJDbU4ydzd1KzB0?=
 =?utf-8?B?Nk0xOUlxRWNRNUVmYndyZkE3VEErTElMc2txa3hkV2h6RXU2UEdQV1hkL2pu?=
 =?utf-8?Q?1WOp8jyu2LkVB0dSsaCmnVpvq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03afe266-acf7-4c8f-ac15-08de18631e32
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:51:52.4966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huy8C8CEVIggeSk/s407De9SQjaSQLQIxwoH+gE2vDWD+S22ZX152YSX/ZV1RWxYcy4h4MAD83Pv0dFbCk9EtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944

On 10/23/2025 11:50 PM, Jason Gunthorpe wrote:
> This is used by x86 CPUs and can be used in AMD/VT-d x86 IOMMUs. When a
> x86 IOMMU is running SVA the MM will be using this format.
> 
> This implementation follows the AMD v2 io-pgtable version.
> 
> There is nothing remarkable here, the format can have 4 or 5 levels and
> limited support for different page sizes. No contiguous pages support.
> 
> x86 uses a sign extension mechanism where the top bits of the VA must
> match the sign bit. The core code supports this through
> PT_FEAT_SIGN_EXTEND which creates and upper and lower VA range. All the
> new operations will work correctly in both spaces, however currently there
> is no way to report the upper space to other layers. Future patches can
> improve that.
> 
> In principle this can support 3 page tables levels matching the 32 bit PAE
> table format, but no iommu driver needs this. The focus is on the modern
> 64 bit 4 and 5 level formats.
> 
> Comparing the performance of several operations to the existing version:
> 
> iommu_map()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     71,61    ,      66,58      , -13.13
>      2^21,     66,60    ,      61,55      , -10.10
>      2^30,     59,56    ,      56,54      ,  -3.03
>  256*2^12,    392,1360  ,     345,1289    ,  73.73
>  256*2^21,    383,1159  ,     335,1145    ,  70.70
>  256*2^30,    378,965   ,     331,892     ,  62.62
> 
> iommu_unmap()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     77,71    ,      73,68      ,  -7.07
>      2^21,     76,70    ,      70,66      ,  -6.06
>      2^30,     69,66    ,      66,63      ,  -4.04
>  256*2^12,    225,899   ,     210,870     ,  75.75
>  256*2^21,    262,722   ,     248,710     ,  65.65
>  256*2^30,    251,643   ,     244,634     ,  61.61
> 
> The small -ve values in the iommu_unmap() are due to the core code calling
> iommu_pgsize() before invoking the domain op. This is unncessary with this
> implementation. Future work optimizes this and gets to 2%, 4%, 3%.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

> ---
>  drivers/iommu/generic_pt/.kunitconfig       |   1 +
>  drivers/iommu/generic_pt/Kconfig            |  11 +
>  drivers/iommu/generic_pt/fmt/Makefile       |   2 +
>  drivers/iommu/generic_pt/fmt/defs_x86_64.h  |  21 ++
>  drivers/iommu/generic_pt/fmt/iommu_x86_64.c |  11 +
>  drivers/iommu/generic_pt/fmt/x86_64.h       | 259 ++++++++++++++++++++
>  include/linux/generic_pt/common.h           |  13 +
>  include/linux/generic_pt/iommu.h            |  11 +
>  8 files changed, 329 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
>  create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
> 

.../...


> +
> +/* Shared descriptor bits */
> +enum {
> +	X86_64_FMT_P = BIT(0),
> +	X86_64_FMT_RW = BIT(1),
> +	X86_64_FMT_U = BIT(2),
> +	X86_64_FMT_A = BIT(5),
> +	X86_64_FMT_D = BIT(6),
> +	X86_64_FMT_OA = GENMASK_ULL(51, 12),
> +	X86_64_FMT_XD = BIT_ULL(63),
> +};
> +
> +/* PDPTE/PDE */
> +enum {
> +	X86_64_FMT_PS = BIT(7),
> +};
> +
> +#define common_to_x86_64_pt(common_ptr) \
> +	container_of_const(common_ptr, struct pt_x86_64, common)
> +#define to_x86_64_pt(pts) common_to_x86_64_pt((pts)->range->common)

Unused macros?

-Vasant



