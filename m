Return-Path: <linux-kselftest+bounces-28411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6972DA5506F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B44170E6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C820E03A;
	Thu,  6 Mar 2025 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IfMi1TMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5D1FF7CC;
	Thu,  6 Mar 2025 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278123; cv=fail; b=a1XlbXGppAtF0WKGuRHw+iiH94Soo2GtQ9XXCoggbsrKZOxDuOiM54c5fjnERmzsXFcpaB2KQQ7cyV53J7V09OITkjQ80gfTBrqpqvlHq34zg3LJrQui+vRt51ODJlOjZCJt0hJqwP/WjWfZvn1bdPPUr48TIeMyq8569i5wLm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278123; c=relaxed/simple;
	bh=c2mSGHuFPP6MqsBQhqOrWCa/lDmtkakuNTtrXL1auZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1xrB58eEFkmV1Pzz2o+1MU7T1juQ6XBC1HtQHNtUOpicT2po0Nf/M+YJX+2/DAk5LPbcx9WwqriyXAd+DNh7gaxhlJeP0o50tJVCdvIcrA4savCmNqgOR3WChIMLfh1XWIIicQfzTZKyQZk1U5L6egXiaSrYoesf1P48Q9mvT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IfMi1TMV; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcdSCgDVY4Y25z96TkndMnC0Limo3urJdJJkcMaIar68o+1+m2m+2LrByS3VaBOUAT4UrKoz6epynddF+0oRZjLX4veyca+IjPhkzqdvc+Fe7FXtuRVR5UbOeg/tTBZ0fHT8hRCUDLG76p6mRB7iZau9a5XblUI4F8JMg0l0FPR1/LKD99QabXVuWUFN0ZX+jaC0QN8JzMsMLsgmWAUU3puzYoOCOw7ICOAJZXpgJZ88WiFQhH0LpsdHQte6FFWDmRW1ndrufBJeqOuk11hxyCqee3fX/8yyQjVGNpf4yYUN9Uq3aFfUfiZYapC11rHCQq5icl4DBcIzRNBxGr5mSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUIUSWJqlUzL922u/MBHuBhyIcGtSUeM4KM/8uqVp4s=;
 b=pu4nL7lW//Exbg4JSMoEq39RndhGjFGxacS6a9quGXgjD7Bx7SuY1JoElsK8/0MTWnHudHqLv0e/RVaNb0pAht16DtnvZKCDKkKHC1xWS5glvwS9PdNQnLvJsSEBhUrj5NZfwp5JVQ+qwwr7VVXgl4mxnrd+n4zYIkuvogOyfPIPL70uky/179sJxDbq66EKNehtMCslUi1H9pNuodSALxfPAYKZpMwMqKc8wejFgL4xnDm7RmeExOKfHpKEmgYGolP4ze7JRXYuLZ7ZGsHgTCIRg67Efo4n16a+XDtsMOcMmym6JyoZYSS/9z8TfFaEeQYVehElnDzLrRzrnWvfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUIUSWJqlUzL922u/MBHuBhyIcGtSUeM4KM/8uqVp4s=;
 b=IfMi1TMVDm8v3X5OwNjJrazbfo56bG3LtM+hL/Wbj1jwrBIG3RhxNObtxxA7CSSpLRIOYOeaarIQTp/4SV8H+AfLDon/ORwxbumknXz/qzz3g4BwsFLvaZlFUbnxSrWI5MPdmOKEnNDz47IekpUIUVPdbpXywu1SvZhHuiuVSH6fhkjxKgKNLS7ZZkneE4NKaMBWcsmAYIdK6t7Ju+tlwa6OoXsGf3Jy9LrFq2UhNoCY8YbMeXGl84WU5wwO2xIrQgKdMeZgYWVKzWtSoIW46Uh4h9hJImqxhFpsJBV9HGFAB+8s8oWDzjizoSnqMa5l7jnPePWHFrLL4hV8BlbfBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Thu, 6 Mar 2025 16:21:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:21:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Thu, 06 Mar 2025 11:21:54 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <D45D4F01-E5A5-47E6-8724-01610CC192CC@nvidia.com>
In-Reply-To: <176731de-6a3b-270b-6b5d-dfce124c8789@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
 <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
 <0582f898-bd35-15cc-6b4d-0a3ad9c2a1a4@google.com>
 <2D7DFB2E-DB80-4F6C-A580-DEBC70318364@nvidia.com>
 <176731de-6a3b-270b-6b5d-dfce124c8789@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: e496ac65-5e6e-4a45-076b-08dd5ccb045b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2JFOUlYbThON3dyd3hGa1N2M1NZNEk4Lzl5MVl6Ym1heDlGaFF6b1NWb1BQ?=
 =?utf-8?B?UCtNMHU2Z0ZjL2hJWS9tNmdCUGc0cnBCVEM2Vjd4c1kxLzNWRUpZTHUyVGVC?=
 =?utf-8?B?ZDRranF3MTB2aXEveHlRTG4yLzl3MStncjVNU3M4YlJPSkhmVUNjTzBZYnox?=
 =?utf-8?B?VTJQUDVCcUhJS0FtVmJFYVU1ZzBqMHhUSUJMRXJIL0xhM0grOWZrRjczMnRk?=
 =?utf-8?B?Rkt6MzlmeGk0Smsvb2hIaHQ3T1d4cVNsTXhqQUNzRHh4MGU0T2pUSVhhWHhz?=
 =?utf-8?B?T0YwQUF0SkNrc3dYOVNHRmcrQ0VkajRTNFhtMk5DUGUzRlV5dEFMRm4zZzJV?=
 =?utf-8?B?NjdSRFp4Tll1cHZnNFdIV3VJZmxkKzJ6NWFoR0RqYmFlNW5BVXo0U3BlOXBp?=
 =?utf-8?B?QkkwK1d4dHV3S3hacW1JclRtV3Y2VzhFMkxBVFNjZzEzQ1laTCtjZTRVWEJQ?=
 =?utf-8?B?UitDOG01YWxoTU5FTS85MzI4VnM4Y2JCajVZaUdHL3pRUGxOSVAxMXpxNEVJ?=
 =?utf-8?B?ZjY4K2ZjbitzR25BdGN1bHRWT1ZkTDN0cWNVNDhHZVNnUHRUblRMOElDREJO?=
 =?utf-8?B?K1l5Z1gwS3BLWXA3bEpJSjNFWW43dTlwa1BrMHhjeEdqN1ROVXl1U0h4TnRn?=
 =?utf-8?B?ZTVWSnRjaTUrRFJLVG9DTXk1QjNFVFlsclVXSGczbmlnN2NjNlRxdnF4NmlD?=
 =?utf-8?B?d2hMTmNzNGRjcFp6Tk05OFV0N21KS0xXYnNQUEV1RCs5cS9OU2h1K0FkU3dw?=
 =?utf-8?B?NHpJNHQzSk5SdzFvbHpQY0tDT0FYTitSRmhmUnNFWDNRZ2FaNW11Nk1STHBY?=
 =?utf-8?B?UDIvZ21oNXFtSTRQemlVMnZiTXBRWHpFaFY0VWI3Ym5WZ1o5Z1FKWGxZczdG?=
 =?utf-8?B?YjROeFRPd2dpZFFScHFPZ2daVU1uM1RRSGVDWFlTeTFBenpwNW9FQUpPMDQ2?=
 =?utf-8?B?TXQxZk1hVCtTY1RoY0FmZWhtV2dTYUJhc1lGdHNzZUhyRTVQNEMxSFhEQzFq?=
 =?utf-8?B?bStUMURoOWhyTlVIa2ZVL0xrMFMzbWhsTnNZY243ZWM0WCsvV01nUDRuMWxy?=
 =?utf-8?B?Ny81Z1hnUk9Za3pzUXljYk1NRDJCbU5KczFFcnZwSmh1S3lrenZ3anZBb0J2?=
 =?utf-8?B?T1JYaFhERHE0cEcvaGNGMENMRTdsZWVrcEtJZlVsQjNhdU1SVzZWZWdFV1B2?=
 =?utf-8?B?ZjE3eW04QWEya3Z5QkErdFpZKzJoaUtDZ0tpV3RFa2tSekxyTWM3QTU1Y1hw?=
 =?utf-8?B?Q3RxQXVmOWN0dGZWOEkrU0pQeks0TzRxOHZuODEvVkpDMUpLNmswNHJPWFFt?=
 =?utf-8?B?bmlZbXo2MU5qbWxNQ3pHQjRlSlA3MVlOUndkL3BRR1JnSjdFNS93TUdYcVVS?=
 =?utf-8?B?R3pMTTBXT08yazdCTEJLMmM3WUJjeTRDU2hGYTVDajhLZGxzckJHVWE0RTBG?=
 =?utf-8?B?eXlxMkNyNC9FRkJQb3FpSDYyOExQZm5DT0R4UEV6dDZQeHZtaDdUQVhzbUVV?=
 =?utf-8?B?NFBFSnFlOGdCM0pJYmZaNFlkQnNzT1dCb3BkWnVibWRHUUUvYmUvUzB4ZVY5?=
 =?utf-8?B?aXVRYXlPb1QycmR2UVJOSC9uakNWcTJoa0ZUY1dOS0tvQU1sVk9PRkhkRk9E?=
 =?utf-8?B?UzRDajlQWmtnSGdsbWVJbnhXeU51OWJGZjFkL3l5am42WHdzWS9CcEFjSVhF?=
 =?utf-8?B?d0s2dE11WFBuSk5PZ3ptbnpuSEZPZjN4TDNTNVNXR1lOcXpNUW5uN1RWeWd0?=
 =?utf-8?B?d1lhQVJ4UmZDdFVVdFNrVVMwYkVXYS9UVEhpL3JnWmEyYnpvZVg0YTBiSDl4?=
 =?utf-8?B?R3QrMEd4d2JncUhNeUF4TTEyeW43aWh3NG9EUFlxbXpWYzFpMm12bHdJV25U?=
 =?utf-8?Q?8fT1hJFdN3+gq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVRpS2k1UldLTEQ4bVZ0dDB1NVhDTFFERnpSOWducER2WmZMWUNMNGl1MlB0?=
 =?utf-8?B?ODMzZ3NyRkZSUHpERFNNTm42dS9tbHRYWldCekxPSHgxeGxFS2tLZ3JlSk4z?=
 =?utf-8?B?Y3cxU3cwRkRlSVkxaFI3UXZyN3MzY2hsNGkxZU5mQ2lCUjRZTEptVG9nNVBp?=
 =?utf-8?B?ckszUVhyVE5CN2oydmEyT1BaOGtnaVlETUxPdjNLank3a3RaSlk0WmpvdnJi?=
 =?utf-8?B?U3JDRnU4MmhnODNlazJCamhNc2hsT1ZubVJVRThYd21tQXZSR3YrUEhUZnZu?=
 =?utf-8?B?TjhLRjZIbmNXM2NhYkU5aWlBLzh6RUc0Nk1FY3RWdzRUSTc0QktMSm1hOHRu?=
 =?utf-8?B?ZkxrYzVzbXUyNTlTSlF5T3VHUFh4NE9VcWlNdklDMWpkbjlzUXgxbUdDclBD?=
 =?utf-8?B?aytoYkRTUkR4bjVIUGJBb2l2RGpyVG1ZTitzQTBUeDhjRElDUysxRXdCVHhM?=
 =?utf-8?B?YUR0bzVwUzBsakh1OWcvMFJTR3dkWHdYSU5SRzlrdExZYzh3ZWo4dGN3ZnFa?=
 =?utf-8?B?Qi9SMjI2WHFiSjFJdjBPc2QzSTZkT3Q2cVlNaFQvQkpYMS9EYmR2M2NGckdv?=
 =?utf-8?B?WGczcjBxeE5mZTZrYTFwQ1pGV01Ma3VQQ1NsRTNSWmd6QXIrRllkMjVjQ1Az?=
 =?utf-8?B?dGFnWHpWVXdablNJZGxlaHE3dk96cnk1QmxUVTIxa1VvSXNPUEoybTJtZG9Y?=
 =?utf-8?B?eGdlTFVONVQ0Vkt0dHlwRXRNcGYvbVVRYUEyWWl1TXJoRWZNaHgzd1ZuVTA4?=
 =?utf-8?B?MXI1TmFadmd3by9KMk1LNkx4S0I5RTZwZW4xZ1hmR0NmL0ZoQUdPUnpFMzA5?=
 =?utf-8?B?eVFIVEQzUUpualZna2dNR0VHTEFuMndHdFYyb1Y2by9IRGVoNDRYekZTZjJa?=
 =?utf-8?B?U2RUMDhvd1pNVnN1T2FVOXl5a2JVaGVZKzA1cFBRK2s4YlN5OTdPMVpJNU11?=
 =?utf-8?B?WWpiMk1sTVJFUkZqRlp5eWZ2WkdicGFpZHlzb2k5TndvcldhM2lOaWp0R1lM?=
 =?utf-8?B?UXZlMFRXUCtLMGtvaWFCMnplelFOQVZ0ZzNIUnh6ZktWUDNiVEU4enJ2TGNt?=
 =?utf-8?B?anl1OVR6VzU2VFVGTXpwRmZQY1JGRndXcHJTZVFpaGN2eWc2R0NVeVBoUzN3?=
 =?utf-8?B?ejhZOVd3Q1pRSGJ2dnJadU5nNWs1T3o5dGVaTURULzM5bHV3dzJVQ1BjSDBh?=
 =?utf-8?B?Y0wxcU1QRzZmcFZpRFVQcEhTb0VkcE9rUXYvOXAwWHBnZ0IxdUpDQndjaDFC?=
 =?utf-8?B?ZDdjYy9ZbmhMMDhzalZzWXRkTWpkSGZBT01ZRmlrajNSNzBPUHc0bGxSTEVW?=
 =?utf-8?B?aTVOTnE4S2ZpUldFOGdaUVdHQXVTTDlvS0Z2MmlqNmQrMXVBbUs4aWlObktx?=
 =?utf-8?B?LzFGWnF3T2dSaFppTDk2clhsaEZhRVdkMGZ4QjRMQ1ByN2hTclJuVk5uVnZ2?=
 =?utf-8?B?RlRYY0FqOU4rUVc2Z0llWVdjK0VKOW8vZCs0ZWJNYkFtUUlKRGtTek9PM292?=
 =?utf-8?B?R250Q2YvUFFkU0JvYWJrKzQyQ2JKR0FiNFpIbWcyWWxLSjNzZVhtVGVvaFRX?=
 =?utf-8?B?V0ZXVlpleFVETVZDOVZJdFgrK0NCelJuQnM3MlQ5cmdrYjBJaDArTFFVbmUy?=
 =?utf-8?B?Q3Jmc0F5VGwzN0lPdG1TL2lHRmR5RlRVTzdpUURYR3Rlb0dybkZyaWQydjZM?=
 =?utf-8?B?NmhUTDhENXZTL2xTdzJXZ2pLUHArM3VmMFd2YUZhMERyaG03YmZBbFd0RnJ1?=
 =?utf-8?B?UDFveFB1QmdkUTZxaHlPcDE0U0xBaG1CYWx5cVVvQXVSK3p0RFYwbHFPY2xr?=
 =?utf-8?B?T0tQTXZZcVZneS9XODRFYVFwUnJWd3RudUpUL0ozZ0xsYTVHUE16Wm0rYkFy?=
 =?utf-8?B?SGl3UXdFTjlKL0NGQWRHTlBKaTZveFJUcEE2NUxwY2wwcnB6SHpsNjgrYWhl?=
 =?utf-8?B?MWdpM1dTeVo5NTB2UytVZ1pMZ1pJQkJ6T0pmZ0RZVXR4TFprTmJDSHY1aFZy?=
 =?utf-8?B?ZFpPNVhIdFU4NHdyWXd3Z3lYbEtJMU5hYmw0SEsxcERLaVhYUkhrRmc4TmZh?=
 =?utf-8?B?dW80NUVUdkVzSTQvMVNxSUppRkFqOUd2a0xTb25xZmpnWm1GY2ptankrZ1R0?=
 =?utf-8?Q?OMcaGqQF23rnn6yu0pgQE728b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496ac65-5e6e-4a45-076b-08dd5ccb045b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:21:57.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdcMoGFaFQcHDU4Z43MJHA8+lSdknp7qyy4Y8f0seglPHNgeryBmY+5rflTZcDSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764

On 5 Mar 2025, at 17:38, Hugh Dickins wrote:

> On Wed, 5 Mar 2025, Zi Yan wrote:
>> On 5 Mar 2025, at 16:03, Hugh Dickins wrote:
>>>
>>> Beyond checking that, I didn't have time yesterday to investigate
>>> further, but I'll try again today (still using last weekend's mm.git).
>>
>> I am trying to replicate your runs locally. Can you clarify your steps
>> of =E2=80=9Ckernel builds on huge tmpfs while swapping to SSD=E2=80=9D? =
Do you impose
>> a memory limit so that anonymous memory is swapped to SSD or make tmpfs
>> swap to SSD?
>
> Yeah, my heart sank a bit when I saw Andrew (with good intention) asking
> you to repeat my testing.
>
> We could spend weeks going back and forth on that, and neither of us has
> weeks to spare.
>
> "To fulfil contractual obligations" I'll mail you the tarfile I send
> out each time I'm asked for this; but I haven't updated that tarfile
> in four years, whereas I'm frequently tweaking things to match what's
> needed (most recently and relevantly, I guess enabling 64kB hugepages
> for anon and shmem in addition to the PMD-sized).
>
> Please don't waste much of your time over trying to replicate what
> I'm doing: just give the scripts a glance, as a source for "oh,
> I could exercise something like that in my testing too" ideas.
>
> Yes, I limit physical memory by booting with mem=3D1G, and also apply
> lower memcg v1 limits.
>
> I made a point of saying "SSD" there because I'm not testing zram or
> zswap at all, whereas many others are testing those rather than disk.
>
> swapoff, and ext4 on loop0 on tmpfs, feature in what I exercise, but are
> NOT relevant to the corruption I'm seeing here - that can occur before
> any swapoff, and it's always on the kernel build in tmpfs: the parallel
> build in ext4 on loop0 on tmpfs completes successfully.

Thanks for the scripts. I kinda replicate your setup as follows:

1. boot a VM with 1GB memory and 8 cores;
2. mount a tmpfs with huge=3Dalways and 200GB;
3. clone the mainline kernel and use x86_64 defconfig (my gcc 14 gives
   errors during the old kernel builds), this takes about 2GB space,
   so some of tmpfs is already swapped to SSD;
4. create a new cgroupv2 and set memory.high to 700MB to induce memory
   swap during kernel compilation;
5. run =E2=80=9Cwhile true; do echo 1 | sudo tee /proc/sys/vm/compact_memor=
y >/dev/null; done=E2=80=9D to trigger compaction all the time;
6. build the kernel with make -j20.

I ran the above on mm-everything-2025-03-05-03-54 plus the xarray fix v3,
folio_split() with your fixes, and Minimize xa_node allocation during
xarry split patches. The repo is at: https://github.com/x-y-z/linux-dev/tre=
e/shmem_fix-mm-everything-2025-03-05-03-54.

It has ran over night for 30 kernel builds and no crash happened so far.
I wonder if you can give my repo a shot.

I just boosted khugepaged like you did and see no immediate crash. But I wi=
ll
let it run for longer.

Thanks.

Best Regards,
Yan, Zi

