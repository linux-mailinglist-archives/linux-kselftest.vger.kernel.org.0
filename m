Return-Path: <linux-kselftest+bounces-25352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F148A2175B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 06:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798E71888C02
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 05:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDF518C011;
	Wed, 29 Jan 2025 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TxQRDfhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254618E75A;
	Wed, 29 Jan 2025 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128398; cv=fail; b=BPPqY1A18AyTFiJV3pldjNCxVkScS20p6nasRdk6oLa8bn7RUZT7lLFv1ULb7hkQ6Tu0msEOIp1yfXLXCbR58R3kVW/x2NLL6hN0H3iQK1m2kwGPyzSOlsMJMH0vWHvB4S7iNyI5DLaqOc3nbmGrDAukOJiBgXUwWm3E9ATHO2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128398; c=relaxed/simple;
	bh=IBdGnXyhBGRQJzXkoOimlejCwVriEJ1B1BnJ/PcZbBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l7RfrRWAuIFvmvWSelCCn/5kXW6EboN66qIdo59xe3swje2vGDYsnMXvKjSEDlINeC9zw0oFOEDon2Cx5RUoBMzv5UoQV67MDw/ruF/zd3OZNFYj8FRFkgkjrqYOpd6oqbYIDyRSJBgarLeD0CJF/w16oMzzoBSrToHIr/amzYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TxQRDfhd; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4Wse7H19TCkTlXkJ2raFf4pr9lpIIaOj3Fkf5yaXDM11Hq9nTwXOnx/+TOEeuWCeTiHMgKKoYzHNkGoQy+JHL0rwqv360SXNTENbaI9lhSka3CHQmDkFdVFr96C9qMPgF3UpAfb3djvNCdfGmAXmC/GLuhg72rCvl3vrXPTKz3dpm27TrQN4RhReFzVGBjuVqAcAsMQep4pd94yESMTUtRTByZf/Rh62vfP1pYypAZP42bSD/bAPXh0oA+AIkscxp8RJNxYWEX4QJB9q/5eAHjmJlXKqgGr9+93AW8DHjLX4IypqWO5jhBjMdTdBmy5idv3xtkUTJwSrCU3i4VvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYoPw85qQZkfwh78HjTAK0Q6To3S94cggBIb15bIo7k=;
 b=UJ4VT1ziVoj6PVDQLIxoO4wJSIF7Xr/MYbqzWfGnpQUlQNbn3BLzJnEBVHarAjUJm3Q14oK4YKWKYJmuAk15AvmRrCNEumhNfSgbicrfSApr/PCXq2q8TSx69qlOR3gPwflEPsJcKfQl5Pi2Jejm/VbDtU4a2ddehEqhVwNL8gyrx3rELzl74d5Hp5cVzcwIQtPj0IdfRQmqyC11nEg7lSoPQvsKGKN5cHjChxVFFG8XD58w54kh+/BZDoK/hdxjbR6ywWUFIr1q3fqudtRhmDhm0FHVdMNm7usp9a7I5NmCOXqnkBbTQrj+dbC446QoSl7icqWf50Dgi9H2o4Z8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYoPw85qQZkfwh78HjTAK0Q6To3S94cggBIb15bIo7k=;
 b=TxQRDfhdK6etEa0YJ5dlRs1I0zOV6gXtPyBeyS9JG5Jgc0UDoqHO1Gtor5DlrCJ5Sr6wi3jHW+LqN+wAcYLv5ebtzcrKbCBiLjZCo5rK/BXrPGajCTo7aDQW+0W76zeujxaTuqJQC46QlnNDfw+Ta3+MbBech7sQXUsGFU7sY9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Wed, 29 Jan 2025 05:26:15 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%2]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 05:26:14 +0000
Message-ID: <634c27ab-8ec5-431b-b024-fb8f86f05886@amd.com>
Date: Wed, 29 Jan 2025 10:56:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] KVM: selftests: Add self IPI HLT test
To: Manali Shukla <manali.shukla@amd.com>, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com
References: <20250128124812.7324-1-manali.shukla@amd.com>
 <20250128124812.7324-4-manali.shukla@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20250128124812.7324-4-manali.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ab8b2b-d888-473b-977d-08dd402572eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUN0am42U3RDbnQrcVFnelVYbFVEYUQvL0pDTjk1N0orUEtUL2lNUzAxYlVr?=
 =?utf-8?B?YktrdXpCTlJldU5tT0xKdjNtVDMyRHdlQ3hhRExCbUdGQlJKU2xrenFFMWdo?=
 =?utf-8?B?Y21FRHRYdy85M014UDkvZEY0STFmYSs4QWZBazNGR0I0dUxaampaYzUrV2pa?=
 =?utf-8?B?OWdCNklVZVRUdzdPOUphSFozTElGZTY1dm9CWmxrTXo0TzhoRVhsOWE4dkk2?=
 =?utf-8?B?WjBYTVBxL1B3WW9hQjU0UE1kbXhXOVBkT25oMi9OWjJHVzlmRlBNMERJYTFT?=
 =?utf-8?B?cVI2UU1oVkhVMk0xUmcyRUU0bEJOU0hadE94NU8wbmJLZnJ6THMyVGd2cTUz?=
 =?utf-8?B?ajdCUEZwSGRWMXNlYmYxWW9maTFqcFZrMGloYVZuTnNxTVNER0pSZFB2WXZ5?=
 =?utf-8?B?Z05lNWl1Sy92cStHTGVHOGJOenlETWZBaEI3M2dLYWFFdWgvZG94amRPWm45?=
 =?utf-8?B?cmU1Z0NKbmxGQThOL2VwZHVQS1NvZVpqZ2hlclYvL2lMQlE5ckF5Rzk3Smhm?=
 =?utf-8?B?cVVLWENLNHlnN0VWVGptTEhiOVg5RVJieVc1ZWFVak52eCtmcFBWYVdsaXhu?=
 =?utf-8?B?RFRscU1RVEFIOFFKbEVseTdkOFBGeFE0K1QvNHE5N2VlWk9mWThqZEpOL1RL?=
 =?utf-8?B?TUV3b0tCMlhnby9RQkRCcTFDT0dqUzNwN3FQQThTVnN1Qi95WDZ5UWZrM3RU?=
 =?utf-8?B?OENHN0VjejNGKzJiZDZOYkl1WFlEempoMHRxMnpVcnJuM0pQekF1QjcrM0Ew?=
 =?utf-8?B?ZlNtK21XT2xlREFtRW9MQUIxdVlWbEpwYkFsUzJBcnpVaGhpNmJBMk5FWXQ1?=
 =?utf-8?B?L1E3UTVKNExCeHZDOVdEQ01KQUdqZXFOd2ZoT2dvNXgyM1JKZElqdkVwRWZD?=
 =?utf-8?B?YXpwdUlmdzBuUkE0bnNOcjh6b0x4RkpXeU9OSlR6Z0FJN2MySGY4M3FWSUhn?=
 =?utf-8?B?QWl5NjEyZzI4bEl4dkZTeHl2akRObnJnekhRNFlMV0xHWFRHSnN0WnM0RjV3?=
 =?utf-8?B?akFxNm5RYXpUcGNEWS9ERTd5Tm1HQ0pHcWpqSUdVaWJQRlJ2U1Fpd3lUdmxr?=
 =?utf-8?B?b21ya3NBaVBFaWwyRGxpenVhaU9JdUNtZWt0RTZIZEYzRkRZZHNvRkVmcFJ6?=
 =?utf-8?B?N0pUNElyV1k3MXBnbFc2eUlLdjZQLyswMXYxSndBclZ0NFAxR0p4RDlnUUx6?=
 =?utf-8?B?VC9tNTdmU2NBMElIYTZpc1oxZWVlNjFxdjhucDJnRHRkY3hKZlJpQW1sOWp1?=
 =?utf-8?B?ZSsvaEtsS3RjS3U2VXhrT1NWK1hIdTJwL3BGSmgzUVFqSGp2LzNuNXN5Qk9D?=
 =?utf-8?B?czVNOUZpa2lKSFptNXFYQzZFUklLSnphblF3djRXUkg3bHVlYTMzNzdubWhU?=
 =?utf-8?B?OU9aaDZQV1dKd0tKTkpwL0ZPZW53SnFRcWJtU1dzV3EwRm0rbHBXVjJWTW1V?=
 =?utf-8?B?K1IycjNwaVFtZThWZktsaHNhbmRQd1VXYUJzc0wwcWxQVUtkUzh6aU0rRmpn?=
 =?utf-8?B?RmNJTnYxNG9NZTZjdDhkR2tOZ093cDBSTFBsNk5UZ0FndUZyOTIyWE9laTlh?=
 =?utf-8?B?VG9BanFxd3FYU2lxRGxrNDN2RVB2RGNVY2NXWXo3UW1zc1lOY0liV0doQzBl?=
 =?utf-8?B?M3d5QlNvZEVGSFNuYzMvcWlBOXdYN1h2SnRRbU1zd0ZEaHlxeG5pMnJtRHVT?=
 =?utf-8?B?ckVUMG4rY3BkZitwRWhyVkkySUpBaTdOdlJlQkJncVJyeHlFZzRTL1NaOXBQ?=
 =?utf-8?B?aldHY1ZWV3I0MzB4ek1JcU4zU0FBUmJZN2p0REZXb1VmZGc5Z0FqTFoyZ2tl?=
 =?utf-8?B?Zjc4U05EQUtxc0hLcllvY21Rck9xNGVCbENvRmswazFLcmtaSXExS1VCcGNK?=
 =?utf-8?Q?teXbWzodD4nc9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGRxVjVXN09mckNkek15aXNTd0UrOEJLRGxnUmt0bkt6TmJvVmE3NzBaOHI1?=
 =?utf-8?B?VmlkWG04NjQ3NVM4SUNGMVl3WThMUkJ1YnR3cTRkOGNtM1F6ZU5hcEppMHhI?=
 =?utf-8?B?VnJwckx4YU9zTW5tSFp2bTVHdU5PR1Z6TWErZnFMa2J4MnlMWTlDWGgzVzhG?=
 =?utf-8?B?SmYzcUpEeHdwcEFQT1hPRG5NdlRhYXBveUVzTk1EQk1EWHdBL1hMbU5IZ3RJ?=
 =?utf-8?B?VHZsZ245Q094UzIyQTViL0p0RGNqZ2toaVczVlp3TUtxRkpndm9qTnZsRW5N?=
 =?utf-8?B?WWlmdWU1RGNtenBKY0NDbHdHNGFNRC93ajZ1Y2tsNkUvSE9QUXMvVFA1Szli?=
 =?utf-8?B?Q04yTVdCaU9KRnM1ZHFpZFl0dWJkS01UOE41K1kvZ1hNblFNZVMwaW5FcHFl?=
 =?utf-8?B?a3djRDVGV3dJTCs3V2F6MTNzRWZ1d0RGWWZobXg3MXZsdFJkaVRnOVVjdFda?=
 =?utf-8?B?b21zS0xIZ3Jvc0UralVkNjhxWUV6S0M2Yy9ydEVTRytzU2xmZCtsZFlOYWh0?=
 =?utf-8?B?bGN1bEFNTllSNURlY2pVZUVoVEduS29uNmhWam43NlVjR3J4NEY1bXd5SU9D?=
 =?utf-8?B?elVNRy9hd2M4L0ovdm83azFST0Q3ejFBM25GNDRUOXNscEtLWFZTa2NVVWJE?=
 =?utf-8?B?Zi95cjRkTWRjYlBnaHFVWGtHR0tyUHU4ZWZ6VndMeUdybE5FOTQyRTdVa0RG?=
 =?utf-8?B?UXZySmU4VDBIUFNiZzF4MmZDb0MwdTljdW8vSDNHL1pDaEJCc3pHaTdJcTBy?=
 =?utf-8?B?MzdyWGhyeEhlSGRiZUVoQllqeTlzc0xSOEcwV0tnWjlPMXAvb2NLb05paitU?=
 =?utf-8?B?ZEpPUmk2aVFoYlNnS0I5WnAxRDZOa2JGYzdoZUVVcU5oRVhaUkFtNUY1RjVv?=
 =?utf-8?B?dTZ3N1kzQkFNUmFSZ2hRTjk4WDA3dkxBbjBJK2twb2pLSVUyWm9Fa05EaHZs?=
 =?utf-8?B?dFJtcS95WU5BQ1o1cXZiNXJUOTVwdVVKSWk4d1FFdkdPSGVaOVVaRE4xRXRo?=
 =?utf-8?B?cUhDOGNQaHpYTGxIT0dBS1RuUFkyeno4Z3NBWTlSU0U1R1g2cWZIcmVBZVhN?=
 =?utf-8?B?bEV6WWNBRWttc2R2ZUtRVUtqdTR0RWUrWVR4YjhDNkhjTXh2eTRqa2dEeUNy?=
 =?utf-8?B?UE12dks0K0xQeUd0a3owVVd6WTdpWi8wZVUrWCs0bDk3b2JyREdrUi9rM1Nt?=
 =?utf-8?B?VWxIeVBOa2ZZblYxbWU0ZWJkUnJPcSs4Z2pGbzdkbWp2aTZjTkgvRmFaVENF?=
 =?utf-8?B?MWR0WTM4dFJPZFhwaXk2bkdpNUd0a0pGaVV6UWhhNXIyamVjK1hrKzlzUFRI?=
 =?utf-8?B?ZHdGR3ZndXdMUUVkNWlIa0pBYVllUGJSNG8zT0txSVErN3dTQmRWaHNGc0RH?=
 =?utf-8?B?NFEveVgwQlhHMFY0eEROY0R5R2J6eHYrVitZYzR0ai85d3hYVDNLZjRBSW1j?=
 =?utf-8?B?SHpmS1Zadlg1ekZmbWNQV3IyMWlZUDYweTkyZ0tUQmRHb01ZQjRtMGdiN0ln?=
 =?utf-8?B?YkQvc3BNNVJKSmt4Q1o5WDhZaGhyOVFqaFlrNzkvb2ZEZ2JLQ1B1MUM0WkM2?=
 =?utf-8?B?YVQ3NjBLbi9OSWFHM28wWWUvZmVET3FBSUthZEpEZS9nRFBtQ1VHTlhTZ3lM?=
 =?utf-8?B?TEIyR0s2SWdTSXlnaXRQWG9vOGNlT0ljUm1IcXg0OFlKSFFmREVtS2xaYTUy?=
 =?utf-8?B?ZG8zSlgwTVR6ZXZJNUQ2bngwcjBGYXhMUVYrYkZxYk9GVHdkSXZQTE5mUkg2?=
 =?utf-8?B?Y2o0ZTRSM25VTlQzRjN1N2JDWEo4ZGpGbTNSZmcyRCtab2pnTm1KaGRHcHBV?=
 =?utf-8?B?RjFEZGIrK0xKTWhIdG5YWjZoZTd3N3ZacWR0WmNOc3h0OU1DKzFpdzNsclVW?=
 =?utf-8?B?alVhQW1zQ0tidUpaTk05aUVoZldIVm5WVmhsT2tkc28zcENubStCbGZhaXJq?=
 =?utf-8?B?R1NkeVk3K1VDVmNzVXIwNlQ3c29Rd1AvOTFaL2N0cjNyTDZCTzh6V0JicXpu?=
 =?utf-8?B?bUlZY1Jnby9OZC9qRXhZSWlCTUhMd015UXZxajZNdWFrbE0wcWU0K2VhWm5E?=
 =?utf-8?B?TGJ6emVvVzhCT2NFSHljUHVSY3dPT0lkNGJSRVRTd3YyMWJBT29Kd2MybEdn?=
 =?utf-8?Q?QMN3v9qxEValKxLXpMVRNbXsu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ab8b2b-d888-473b-977d-08dd402572eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 05:26:14.7053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRYGeJTATz8OOFLRKgOoLnTqg5/h+j5sKfd+Je7ML5lvehfUZvzcBjUQ3C3iVvoChulzfhNoEW6cPOSKEeylCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454



On 1/28/2025 6:18 PM, Manali Shukla wrote:
> From: Manali Shukla <Manali.Shukla@amd.com>
> 
> The IPI HLT test simulates a scenario where a pending event is present
> while the HLT instruction is executed.
> 
> This test evaluates the idle HLT intercept feature of the AMD
> architecture, if available. If the feature is not present, the test
> exercises halt-exits/guest-entry for pending interrupts.  It can be
> extended in the future to include cross-vCPU IPI testing.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

