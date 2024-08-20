Return-Path: <linux-kselftest+bounces-15759-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0B957E07
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 08:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D41C23506
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85E16B389;
	Tue, 20 Aug 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nTj2v0Mf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B252A1B2;
	Tue, 20 Aug 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135107; cv=fail; b=IE+2CJSML1dA0unx6boXuojqBJD9OdmVQ9fhQIp9iQkVFWTin6wr55lOMmLf4vclVr/Sc6MLefUwxQHoCohiGB9+9ce264aW5L2pK4aAIGNuwW7etTBS01756AqHN4ioPLmiAz7aSoE7ZePTt1R4QTTA6l0R3DGrDJVkf0aqssM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135107; c=relaxed/simple;
	bh=1yQK/gLl+k+iHXmT/5cCXoF3AOIbcAHPpIeuuvGozOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A6T9xXeVSAs94zr3zS7F/HrOsEpkPfD/iH4rpponPQFEfxBd0ZNjkC38nZRF9TOIskRqCp/sA1EU563AQsVEWuuhmcaMZjJhcTu1hnGU7O+2mWXRNeku4gUJdZo5p3YUdtIs4SyX5Z/410X3fxi3xkVQz2TJAgbmoeMlr9Z+oXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nTj2v0Mf; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmBqtiQR5e1fSyHPHy3VbNpfpGhA0NydHVDzBy9qixbzjygVHJbItfKgBAImUdrDpc6kSg8nEKybtW+3VSgftXMoibpJnYpZa9rfDBwT6uhWSVUeN3aQ0oQGU4dXtnxqirQ7wq3ybOREUCfEZ0b00OVZPaNBNAOIs3ODLxI0LlHPFKtNukYWLOm38mdt/wcTVi+b9vzvraoZzPvzpQLDgQWDamoK0Zf+9BiQnZtaM4aqKn0WkZjjT89QWROCftn1uv155BGcqRRAbSVBiPLqMkfWrLWxchqCuOuaP5Wl5uohNoaynq8u9mqapaJwXEKXO/VUj+3NOmyEDqB0g9yERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvIf1FZ4Qhu0mbDrV3ngaFdnJM4k1RainE+2T3hWy6k=;
 b=Y3/M2iD7qoJb/6JmXuxH2WAxawaHkEe5GXQzbLPypr3bJCrRCWWvVMcpDp+bXLXId7ewbbwt31CfxGg4petisx0b7wJMNf3ZD+ibLHG1JafGTTQB9VwB4SDj3v9qAg3YUFowXQZt5E0s7Sn1Uj0B/YqMKZkSuN9AreewAQehyiCLEp768N7A1ja1cODGbN79J3vKGRCbMKfn14bmrVfHQLpYCHvLQWQ6Vr07wUH5WKBOr9do39Y/Nqy9ImFvKCX8ctp75XL3O0UxP6VsHylgSKemaO8hN0HQjEgMqCPrxfvYUbXTeq5Q7v9tr6MH4Myh1HatMVZE0F9K5KJcFS9NFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvIf1FZ4Qhu0mbDrV3ngaFdnJM4k1RainE+2T3hWy6k=;
 b=nTj2v0MfLdecYRVDDt6hrGBinCBhJu/BBdZOucu8WTS1AepEQDkWyNL2Z9VHicSGJQug6HyDD3VxSIHxKw8qchB+3GsYqVK5cFdSnk+ZG9r1B7YFHQo0+6PamgcAf1F+ARNYCvEWwRylK4Bi6nTRKVd+YJgdMpmwN7HCmgqe8Kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 06:25:02 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.7875.016; Tue, 20 Aug 2024
 06:25:01 +0000
Message-ID: <2996bcee-4687-4822-a5a0-e83d89301477@amd.com>
Date: Tue, 20 Aug 2024 11:54:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for
 KVM_PRE_FAULT_MEMORY
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, pgonda@google.com,
 thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
 <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: b9c22e80-c6c0-4ac8-3646-08dcc0e0d239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVlMZCttdVRSWk1BQjhNbHBLc3NXYU9BakEzajh0U2dYRGpITFVtQ3U5V3NH?=
 =?utf-8?B?MkVuYXVwWitocnozMERtYUJ0WEUxQzBsSmdUUHd1K2M1azh0Q2dLVFhlVnBx?=
 =?utf-8?B?TVV1WVNpR1d1KzJ3VSs4TXVNQUtFMlE0VFEveHZpUmtGbUUrN08za2FMck5I?=
 =?utf-8?B?Qjlidyt3emtheHhuTUZ4VmEydll0VGxvQk5OcWM2V3REdXRTQTkwNHpza2tN?=
 =?utf-8?B?V3l1SlN3Sk1kK3Zoamw0VXBoSzMvaWd6Zy9pVmJQdGlaalVJWDE3WXNYczd3?=
 =?utf-8?B?a21CZTBXQWVOc0pUOThMN1MzYkJWVFE2TVhIUnNacUlNWFVCUkw4VlNwb2dB?=
 =?utf-8?B?Q3dlN3lZc2hZU0hVSC82UERxRWRMUmtDMHkwUGZMR2NVZUpGcTdnOXI2dWNt?=
 =?utf-8?B?Zi83Y2tGZzkzbnJJN0x6dVhRa2JtczRsWkdjQU5aUDRERVRNTm9DL0d5UDVN?=
 =?utf-8?B?QVFwNk93TER2VWN6SVhDTHdDYUJrVVdNRkMrVGFzVW51bUlQL2dydUluMC96?=
 =?utf-8?B?UzVER1JzdlNwZWpmNVg2N09qRWkxZ1Y2SGtiOUNMd1JJN3piNjZKTjBENkU5?=
 =?utf-8?B?Z1RaMlJ1Yy9sc3pZU1FMVUhHN2diS0pDQXJXRVFIZjhhSWU2ODFQUWNydkVP?=
 =?utf-8?B?ZDRXL3lEbmgvMExvMEhJeElENjkwZWF1T0o2VVhpdi9MVmJhT1d0Y3NoSTdx?=
 =?utf-8?B?Vm42RE9ZNFpDVmlSdjJrZU9Sd2dUNlJML1REQ2hLbWF2YlU0NU5iSEJSMG9F?=
 =?utf-8?B?UlJhSm0rdytIRDM5a3BRWlVCRmVlaE1iOHpHZzQ2eVdKZnBoUkNlVkJicG5W?=
 =?utf-8?B?NitMb3UwWUNobDJHS1lXUXpYSnVGMUNQUXRaRmtDYVFSN0tZUmVrWngxMTFG?=
 =?utf-8?B?RHdTSFlzWmlGaVQ1TUdpMnBoU2lnVDNMTW9RVEhWdTBBWW5RbjYzczlQN2R5?=
 =?utf-8?B?QnJNNEZvbVZrY2hTZmpkSGNhaWFIODFMcWJKUEhtbDNKeXJSQ1FvU1kybWFr?=
 =?utf-8?B?WFRuNGptdW43bnFRMmxDR2g4Z0VUSk9Pc1ZWSmxzVDdIWFYwYk83NTNJWFNl?=
 =?utf-8?B?ZWVwTTJhdnQ5bTlYTFg0SU5kblJKMVNXRksvVURtZGpmNzgyaVV1WjJwVW0v?=
 =?utf-8?B?eUY2YXNHaVU4bmZBMGlvU29tVFN4Nm1IVWsweHB2RlM3TXJlYnVJUFNUYWVB?=
 =?utf-8?B?cDloc2IwTGJndTNnZmdlb3dTMW50VlNpL2Rqc0lmV1B1OUl5NmVURVdoSVo1?=
 =?utf-8?B?V1RuQzJ0eldlZ0xCc1dMYW9TdkliS1hPL2k1b0szcmVRSGRCWEp4cXg0cUt6?=
 =?utf-8?B?MjY2bkY0b0VkQUZ3c1VDNlFlOE9HRy8zdUxxak9YY0xnQzZUTnU4ZHp2amxL?=
 =?utf-8?B?N2V6YkxaTXhkSWRkcmh2RlVhbWpYUlhuMjhLSm81NmxQbTRkbkFGUXJsSGw3?=
 =?utf-8?B?YSsySVRhSnVHR1J3Nk5lYmZocFdabC9PMVZxV2VqbjB4MktoRDh6S3VGUHlp?=
 =?utf-8?B?Y0syTytkOUlFQ2J4WlBVZHVkdTVON1BNWTlOV2tkcXlJYzRiUUV5K3hyUy9k?=
 =?utf-8?B?UTV0cHhndi9QTmtiY2JyTXJjckJLcENyVmJubG45aXlQNGFwRmY5K2l2Tzlx?=
 =?utf-8?B?c0F1OUp3Q0gvbTgxb1pUdW5rNk96TXU0V0dpTjNxWGNHN01BNHZsbmhNV2Fr?=
 =?utf-8?B?WDFHSFpTMGlSMHRxZDhQOVJaUDZ2bmJPN1RKS2VGUmt3cEJxRUl4Q1U3Y29F?=
 =?utf-8?B?M1JBZ01oOWxrMzlncjc0YVAzMFlhbVYyUzNIbTRUMVByZ01rQU5hT1U4Z3dP?=
 =?utf-8?B?NTJ6RXZXUEczamhOOU1yZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXFhTFZNV29TUitvZW5OZWVzT3lvWmNxSkxXK3NTZHFicnVMbkFxSFpxMk9j?=
 =?utf-8?B?Y3BldzlSalBuRnc4bzZTYXFaWWFhd3dreS9uc2hiUFlnZmcwcmZHRWlubHdH?=
 =?utf-8?B?ZWRRUWswb09lNlJJUmlmVXdMSXNwalBBbCt4QzJUNUJlR0RCOXZaaTYvUWpR?=
 =?utf-8?B?LzFKTzl3WnRSNXptRE9JZXBZVmtIWGpsSCs3T1hPQ2I0T2phQ1hiVTNCRmZp?=
 =?utf-8?B?a1hOeHFyZnd6YzRjZlpDT2gwV0tmZ09yZFVYdnM4SEdVR2hOMWFBRVV6bVJj?=
 =?utf-8?B?bHNKT3VuZ1Z6ampMVFlMUkJvOWMzSFh6cmZWMlZLdm9OUXdiUkhCL05EeStV?=
 =?utf-8?B?VU0zQW04bU9xNmNSQTRkVVFXS3p0cWYxYmorbkpIYWtqdUFRRWJ1cHhSMlBD?=
 =?utf-8?B?ZUVxa2NFRzF4T2NGWEkxQjlLQ09mOGxQdllpeHc5cENjZ1ZPRU9iTkVPTkJ3?=
 =?utf-8?B?ZzFobSsycTFCZjJCc2NzL1NmVGMzK2hncjh0Ly82TG5VM0oyZDcwcEVyamNY?=
 =?utf-8?B?N2ovSHZFT29pYnNDME1ld0xHKzhpZDVoVWozSjN1NGdySkFBSGE5UG53b3Yz?=
 =?utf-8?B?d0VqMmhSTHlmcEpxUVkyS1FNWkxwS2szQmtWRVoxbUxDcy9CWnJ6OXN2K3dw?=
 =?utf-8?B?TXV4K2FKSzZvQWhNK3NnVmlaaEtFVUVBdHRVOU4xRnk5azRrdkZUUEdxdzdO?=
 =?utf-8?B?YW9Dbkh6dWRGSWVQMU9RZmR5SDZoNFNrSERQbDlpTi9kV2I0NHQzN3JkM3kz?=
 =?utf-8?B?cnhVWmxIYWdaMVEyMEhKSFZWK3lwSk42TXZlS3VZQkY3d29pdEhjWHVjSXBD?=
 =?utf-8?B?M1UyV0wwSVVkOHc5NnlmWWN2UCtTakdjd0UraElEYSs1UldrV1VWNGk0SnFl?=
 =?utf-8?B?THpEWUNDVzlyV1g5M0QrcVBWOGJHZnUramZ4cUM2SEViRElKbG9GSmJhWGRE?=
 =?utf-8?B?YXZrekwxQzg1ZmQyTGJBNkRlZ0JvdHdBQzlmN3hCTCtBam02d1E2UC8wVkdV?=
 =?utf-8?B?bVRTOHNFUmxXM3dUZmFSUTFJdTFacU80cTZwRi9FdGlMTjFnWWY5eGtZTktR?=
 =?utf-8?B?RnQ1TnpOczk5R3FURnRDdEhCWWtvQVBrV05XaHFFdTFEeDNPV0RWbDJYL2ps?=
 =?utf-8?B?c1U3YnZQN1h2VzBObFdpaTlvZDVjUTlYcmdwSDRuSUxCbk11WmE4V1Nzaktu?=
 =?utf-8?B?c1FKblRkYUIrNDRVY3FjY2F0WGlieEFSM2VYQlhwK3AzclVqSW1BdkVxTnlO?=
 =?utf-8?B?RGt3eUtqaW04Qlc3Qlp2U2d3U2ovbDNyanNWRFVRempXbk9vT1VUZVEzdDAy?=
 =?utf-8?B?bWxQcUhFUkVaTW9ta1R4SWhDSDV3cjF1KzVrUG9aUWplMTRJUHRmREhkTXVG?=
 =?utf-8?B?Z21iaW9BTzZBdkJ0QW4ybGxvbmowM1NTdFFOdFdxTnhtRWtQYUc1R3ZCb1A3?=
 =?utf-8?B?Z2dpZWdIdElCTWdjNTMrUlpRWXlEQzRzVTVwMGEyc3pjajVhYmQyalM0bExm?=
 =?utf-8?B?WVBreFFPM3o2OGNWMktxTTBoM3NaT0pwc2VBQm9CcTVob1Q3ak9EVnVVQ085?=
 =?utf-8?B?dklFZDBGZU1iZmx1M3hRMXVxdFpkaUdoNGlpRXNmSXVmekNlbW03TkxqVm1n?=
 =?utf-8?B?UzlMaVlUNEJZSTVrUHVBMktWYVY0YWR2dk5FM2dTTE8xYUxRWjQvanE0WkI1?=
 =?utf-8?B?R0RYcFp6bnJ2WnZhdHVreXQ3TEljQWU1V3B5VS9ON3A4cXBOQ01DYXArOTJs?=
 =?utf-8?B?cXFvR3BnSTVIMW5vbkFGRmQ1Wk9Sa2hUYkFRWFhLbmIvQU1zc2w1WGxRWFJC?=
 =?utf-8?B?Vk5ZOUNrYXFTZkprcng4RlFnWnN6bmdPNFdxYmZ3WExlTzVvY0JlaGFRMTlj?=
 =?utf-8?B?cGRMZk9qNnZScng0UlFENWR3UFZJNjRyd1YrMWJ5N1RTcDhXMUJUMm1rVHZk?=
 =?utf-8?B?WDVpc0xEUXQwdWdIRUhNNG9VbWtXZE1aZm9rNDR3SnhvYUtUNi9rOGExUGxT?=
 =?utf-8?B?YkJYT29MUE9kaUNoMkJCNklXMWFEYjMrM2dHN0phc3NrejRNdG9BMXFqWEdr?=
 =?utf-8?B?YUVYSDVQOXVlRk42WUJoZVZZNGkyRnlkbDNXMXU2YzdXZnlLTENFanp0Ujh4?=
 =?utf-8?Q?vNpxWnpWV0IDM55X+3WCEiRiS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c22e80-c6c0-4ac8-3646-08dcc0e0d239
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 06:25:01.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5UlOukwiB0qTHxSZUsfNe1ZVEutc+HOUBriUPon2V7A59WGxiIrXbR3EvNDGCO7rN4ageTiAyRCFaoY6etdjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815

On 8/17/2024 12:53 AM, Pratik R. Sampat wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> SEV, SEV-ES, and SNP have a few corner cases where there is potential
> for KVM_PRE_FAULT_MEMORY to behave differently depending on when it is
> issued during initial guest setup. Exercising these various paths
> requires a bit more fine-grained control over when the
> KVM_PRE_FAULT_MEMORY requests are issued while setting up the guests.
> 
> Since these CoCo-specific events are likely to be architecture-specific
> KST helpers, take the existing generic test in pre_fault_memory_test.c
> as a starting template, and then introduce an x86-specific version of
> it with expanded coverage for SEV, SEV-ES, and SNP.
> 
> Since there's a reasonable chance that TDX could extend this for similar
> testing of TDX, give it a "coco-" prefix rather than an SEV-specific
> one.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Co-developed-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
>   2 files changed, 315 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 48d32c5aa3eb..65d19b277b06 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>   TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
>   TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
>   TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
> +TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
>   TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>   TEST_GEN_PROGS_x86_64 += demand_paging_test
>   TEST_GEN_PROGS_x86_64 += dirty_log_test
> diff --git a/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
> new file mode 100644
> index 000000000000..e16fe185fb5a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/sizes.h>
> +
> +#include <test_util.h>
> +#include <kvm_util.h>
> +#include <processor.h>
> +#include "sev.h"
> +
> +/* Arbitrarily chosen values */
> +#define TEST_SIZE		(SZ_2M + PAGE_SIZE)
> +#define TEST_NPAGES		(TEST_SIZE / PAGE_SIZE)
> +#define TEST_SLOT		10
> +#define TEST_GPA		0x100000000ul
> +#define TEST_GVA		0x100000000ul
> +
> +enum prefault_snp_test_type {
> +	/* Skip pre-faulting tests. */
> +	NO_PREFAULT_TYPE = 0,
> +	/*
> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping non-private memory
> +	 * before finalizing the initial guest contents (e.g. via
> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
> +	 *
> +	 * This should result in failure since KVM explicitly disallows
> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
> +	 * initial guest contents.
> +	 */
> +	PREFAULT_SHARED_BEFORE_FINALIZING = 0,
> +	/*
> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping private memory
> +	 * before finalizing the initial guest contents (e.g. via
> +	 * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
> +	 *
> +	 * This should result in failure since KVM explicitly disallows
> +	 * KVM_PRE_FAULT_MEMORY from being issued prior to finalizing the
> +	 * initial guest contents.
> +	 */
> +	PREFAULT_PRIVATE_BEFORE_FINALIZING,
> +	/*
> +	 * Issue KVM_PRE_FAULT_MEMORY for GFNs mapping shared/private
> +	 * memory after finalizing the initial guest contents
> +	 * (e.g. via * KVM_SEV_SNP_LAUNCH_FINISH for SNP guests).
> +	 *
> +	 * This should succeed since pre-faulting is supported for both
> +	 * non-private/private memory once the guest contents are finalized.
> +	 */
> +	PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING
> +};
> +
> +static void guest_code_sev(void)
> +{
> +	int i;
> +
> +	GUEST_ASSERT(rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ENABLED);
> +
> +	for (i = 0; i < TEST_NPAGES; i++) {
> +		uint64_t *src = (uint64_t *)(TEST_GVA + i * PAGE_SIZE);
> +		uint64_t val = *src;
> +
> +		/* Validate the data stored in the pages */
> +		if ((i < TEST_NPAGES / 2 && val != i + 1) ||
> +		    (i >= TEST_NPAGES / 2 && val != 0)) {
> +			GUEST_FAIL("Inconsistent view of memory values in guest");
> +		}
> +	}
> +
> +	if (rdmsr(MSR_AMD64_SEV) & MSR_AMD64_SEV_ES_ENABLED) {
> +		wrmsr(MSR_AMD64_SEV_ES_GHCB, GHCB_MSR_TERM_REQ);
> +		__asm__ __volatile__("rep; vmmcall");
> +		GUEST_FAIL("This should be unreachable.");
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +static void __pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
> +			       u64 left, bool expect_fail)
> +{
> +	struct kvm_pre_fault_memory range = {
> +		.gpa = gpa,
> +		.size = size,
> +		.flags = 0,
> +	};
> +	int ret, save_errno;
> +	u64 prev;
> +
> +	do {
> +		prev = range.size;
> +		ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
> +		save_errno = errno;
> +		TEST_ASSERT((range.size < prev) ^ (ret < 0),
> +			    "%sexpecting range.size to change on %s",
> +			    ret < 0 ? "not " : "",
> +			    ret < 0 ? "failure" : "success");
> +	} while (ret >= 0 ? range.size : save_errno == EINTR);
> +
> +	TEST_ASSERT(expect_fail ? !(range.size == left) : (range.size == left),
> +		    "[EXPECT %s] completed with %lld bytes left, expected %" PRId64,
> +		    expect_fail ? "FAIL" : "PASS",
> +		    range.size, left);
> +
> +	if (left == 0) {
> +		TEST_ASSERT(expect_fail ? ret : !ret,
> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
> +			    expect_fail ? "FAIL" : "PASS");
> +	} else {
> +		/*
> +		 * For shared memory, no memory slot causes RET_PF_EMULATE. It
> +		 * results in -ENOENT.
> +		 *
> +		 * For private memory, no memory slot is an error case returning
> +		 * -EFAULT, but it also possible the only the GPA ranges backed
> +		 *  by a slot are marked as private, in which case the noslot
> +		 *  range will also result in -ENOENT.
> +		 *
> +		 *  So allow both errors for now, but in the future it would be
> +		 *  good to distinguish between these cases to tighten up the
> +		 *  error-checking.
> +		 */
> +		TEST_ASSERT(expect_fail ? !ret :
> +			    (ret && (save_errno == EFAULT || save_errno == ENOENT)),
> +			    "[EXPECT %s] KVM_PRE_FAULT_MEMORY",
> +			    expect_fail ? "FAIL" : "PASS");
> +	}
> +}
> +
> +static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa,
> +			     u64 size, u64 left)
> +{
> +	__pre_fault_memory(vcpu, gpa, size, left, false);
> +}
> +
> +static void pre_fault_memory_negative(struct kvm_vcpu *vcpu, u64 gpa,
> +				      u64 size, u64 left)
> +{
> +	__pre_fault_memory(vcpu, gpa, size, left, true);
> +}
> +
> +static void pre_fault_memory_snp(struct kvm_vcpu *vcpu, struct kvm_vm *vm,
> +				 bool private, enum prefault_snp_test_type p_type)
> +{
> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
> +
> +	snp_vm_launch_start(vm, SNP_POLICY);
> +
> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
> +
> +	if (private) {
> +		/*
> +		 * Make sure when pages are pre-faulted later after
> +		 * finalization they are treated the same as a private
> +		 * access by the guest so that the expected gmem
> +		 * backing pages are used.
> +		 */
> +		vm_mem_set_private(vm, TEST_GPA, TEST_SIZE);
> +		if (p_type == PREFAULT_PRIVATE_BEFORE_FINALIZING)
> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
> +	} else {
> +		if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
> +			pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
> +	}
> +
> +	snp_vm_launch_update(vm);
> +
> +	if (p_type == PREFAULT_SHARED_BEFORE_FINALIZING)
> +		pre_fault_memory_negative(vcpu, TEST_GPA, SZ_2M, 0);
> +
> +	snp_vm_launch_finish(vm);
> +
> +	/*
> +	 * After finalization, pre-faulting either private or shared
> +	 * ranges should work regardless of whether the pages were
> +	 * encrypted as part of setting up initial guest state.
> +	 */
> +	if (p_type == PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING) {
> +		pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
> +		pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
> +		pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
> +	}
> +}
> +
> +static void pre_fault_memory_sev(unsigned long vm_type, struct kvm_vcpu *vcpu,
> +				 struct kvm_vm *vm)
> +{
> +	uint32_t policy = (vm_type == KVM_X86_SEV_ES_VM) ? SEV_POLICY_ES : 0;
> +
> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
> +
> +	sev_vm_launch(vm, policy);
> +
> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
> +
> +	sev_vm_launch_measure(vm, alloca(256));
> +
> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
> +
> +	sev_vm_launch_finish(vm);
> +
> +	pre_fault_memory(vcpu, TEST_GPA, SZ_2M, 0);
> +	pre_fault_memory(vcpu, TEST_GPA + SZ_2M, PAGE_SIZE * 2, PAGE_SIZE);
> +	pre_fault_memory(vcpu, TEST_GPA + TEST_SIZE, PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +static void test_pre_fault_memory_sev(unsigned long vm_type, bool private,
> +				      enum prefault_snp_test_type p_type)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	int i;
> +
> +	vm = vm_sev_create_with_one_vcpu(vm_type, guest_code_sev, &vcpu);
> +
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    TEST_GPA, TEST_SLOT, TEST_NPAGES,
> +				    (vm_type == KVM_X86_SNP_VM) ? KVM_MEM_GUEST_MEMFD : 0);
> +
> +	/*
> +	 * Make sure guest page table is in agreement with what pages will be
> +	 * initially encrypted by the ASP.
> +	 */
> +	if (private)
> +		vm_mem_set_protected(vm, TEST_SLOT, TEST_GPA, TEST_NPAGES);
> +
> +	virt_map(vm, TEST_GVA, TEST_GPA, TEST_NPAGES);
> +
> +	/*
> +	 * Populate the pages to compare data read from the guest
> +	 * Populate the first half with data and second half as all zeros.
> +	 */
> +	for (i = 0; i < TEST_NPAGES; i++) {
> +		uint64_t *hva = addr_gva2hva(vm, TEST_GVA + i * PAGE_SIZE);
> +
> +		if (i < TEST_NPAGES / 2)
> +			*hva = i + 1;
> +		else
> +			*hva = 0;
> +	}
> +
> +	if (vm_type == KVM_X86_SNP_VM)
> +		pre_fault_memory_snp(vcpu, vm, private, p_type);
> +	else
> +		pre_fault_memory_sev(vm_type, vcpu, vm);
> +
> +	vcpu_run(vcpu);
> +
> +	if (vm->type == KVM_X86_SEV_ES_VM || vm->type == KVM_X86_SNP_VM) {
> +		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_SYSTEM_EVENT,
> +			    "Wanted SYSTEM_EVENT, got %s",
> +			    exit_reason_str(vcpu->run->exit_reason));
> +		TEST_ASSERT_EQ(vcpu->run->system_event.type, KVM_SYSTEM_EVENT_SEV_TERM);
> +		TEST_ASSERT_EQ(vcpu->run->system_event.ndata, 1);
> +		TEST_ASSERT_EQ(vcpu->run->system_event.data[0], GHCB_MSR_TERM_REQ);
> +		goto out;
> +	}
> +
> +	switch (get_ucall(vcpu, &uc)) {
> +	case UCALL_DONE:
> +		break;
> +	case UCALL_ABORT:
> +		REPORT_GUEST_ASSERT(uc);
> +	default:
> +		TEST_FAIL("Unexpected exit: %s",
> +			  exit_reason_str(vcpu->run->exit_reason));
> +	}
> +
> +out:
> +	kvm_vm_free(vm);
> +}
> +
> +static void test_pre_fault_memory(unsigned long vm_type, bool private)
> +{
> +	int pt;
> +
> +	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
> +		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
> +		return;
> +	}
> +
> +	switch (vm_type) {
> +	case KVM_X86_SEV_VM:
> +	case KVM_X86_SEV_ES_VM:
> +		test_pre_fault_memory_sev(vm_type, private, NO_PREFAULT_TYPE);
> +		break;
> +	case KVM_X86_SNP_VM:
> +		for (pt = 0; pt <= PREFAULT_PRIVATE_SHARED_AFTER_FINALIZING; pt++)
> +			test_pre_fault_memory_sev(vm_type, private, pt);
> +		break;
> +	default:
> +		abort();
> +	}
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
> +
> +	test_pre_fault_memory(KVM_X86_SEV_VM, false);
> +	test_pre_fault_memory(KVM_X86_SEV_VM, true);
> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, false);
> +	test_pre_fault_memory(KVM_X86_SEV_ES_VM, true);
> +	test_pre_fault_memory(KVM_X86_SNP_VM, false);
> +	test_pre_fault_memory(KVM_X86_SNP_VM, true);
> +
> +	return 0;
> +}

Hello Pratik,
I see below failure while running this test [kvm-x86/next + mentioned 
patches]:

# selftests: kvm: coco_pre_fault_memory_test
# Random seed: 0x6b8b4567
# ==== Test Assertion Failure ====
#   x86_64/coco_pre_fault_memory_test.c:145: expect_fail ? !(range.size 
== left) : (range.size == left)
#   pid=202665 tid=202665 errno=9 - Bad file descriptor
#      1        0x0000000000402870: __pre_fault_memory at 
coco_pre_fault_memory_test.c:145
#      2        0x00000000004031c9: pre_fault_memory_negative at 
coco_pre_fault_memory_test.c:184
#      3         (inlined by) pre_fault_memory_snp at 
coco_pre_fault_memory_test.c:202
#      4         (inlined by) test_pre_fault_memory_sev at 
coco_pre_fault_memory_test.c:344
#      5        0x00000000004033c0: test_pre_fault_memory at 
coco_pre_fault_memory_test.c:401 (discriminator 3)
#      6        0x00000000004024d7: main at 
coco_pre_fault_memory_test.c:417 (discriminator 2)
#      7        0x00007f9474829d8f: ?? ??:0
#      8        0x00007f9474829e3f: ?? ??:0
#      9        0x0000000000402574: _start at ??:?
#   [EXPECT FAIL] completed with 0 bytes left, expected 0
not ok 66 selftests: kvm: coco_pre_fault_memory_test # exit=254




