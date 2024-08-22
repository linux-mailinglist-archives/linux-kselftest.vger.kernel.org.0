Return-Path: <linux-kselftest+bounces-16037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D209695B234
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 11:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C945B26F50
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DF186E36;
	Thu, 22 Aug 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbXr0ycr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A250186E24;
	Thu, 22 Aug 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319808; cv=fail; b=m676kNeMxPOaTi0FQcb2bAuXA0CIHO8JPxgaP71MIDwvotPvVADrBHh5WiBSWt3jo221fUXSSicg3YnWT3Vziu4tmestkyapn98zGr3Dann81CTFoUipNMGBs45ES2Awrp7Mn0XGSd8RZvAgxadyhPwxFw6HBy0Cefl90fnvqNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319808; c=relaxed/simple;
	bh=Co1soFj5u7tBqqPUtxexWCeu6iVCXTMxFfdTDEhSCnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dpr/i+jpntX5KQZ8Z6y0CuHmjyLUjc80UtRUT53kkRpxkZzWCKqWWzruq5KTfULHKaanzTVSO9Dw8UWAtAlvb36BSTimicWub2cqqZh0MyY8ST3fDJv9X9YrAtLJ8+Qe/d0R6DPOJ9IOMtvHiDKob6oRitSlvwintEVcojjlNAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbXr0ycr; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5145eFow1bLAxOu7nFRvHPZVFWwReJarAw9nKxD4wfqUqqzTBviGqSPvpmwYMtmNcCsO+P5taUA4z1JupSPuBJhS8e0lLCslmOp7pTBgYslfhDBKiLWHMObTzoP6QJvPFlqEeB4XjCpubGFDBOgqe8JmchFlwrqKmehgQpcscL/1v7odhYF5DFuJr3kGjGA2c4lXX5ysRtljzFLXKGxuEZZGw1KdeDgQItT2AxyW7mPbdm/eUR7Gu01uFyNMVNJByudcrK1pBKwEC8lJnq9QlCFTdE1xh7XLWvLCvK6GjjGdr6nreI6veHfaAWm4NPi3Vj3Tdm3FdYxFqRRkD9adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UHbDC+UTeJEJ8inZ7fpBLcFCNoOK5zDH4Nnn2QJK3g=;
 b=BVv07/GRPQytr3caTb90kfQCZbMSZhzuk11HHBOW00Gjahy8twPs7dz9gilXK3EFWZgIn5SSohV5GnoCzyuDLfaWz7fEDghoA/xg1lHDh2SFhD1vzWlFXfyz3Xr62+eKEuoj4g7DW/BreXr5HsyiO8HFVTFPxVPuT4JroffXAJHNhq7yRVJnRQDgNk8VUbgfkohSm9e8Sbs3QKI4x7LojNqj/JsTGkuHFIMI/69+1fLqQBKzS1viAp0hu4bXQfWjuQEfyKTQZb/ug4LBWoivaut81JoEojJSfSZUVYLFonSj65Cl+X4Xrvls9Zz+sfwPrBDtYqkxwcmD+i9/RVVleg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UHbDC+UTeJEJ8inZ7fpBLcFCNoOK5zDH4Nnn2QJK3g=;
 b=pbXr0ycr5aq7nh7lowwXGZmOLulejJ7H/ReuNym215OyCPO2VYGZBWLBymriyRVEmT4D+eo2y6y76mVpHnLR47ZXwA9H02kxoA8ERtrlgLq9DkufocXr6EAX/hwpAYuj1S5g1DnGW4dWC1F4ywO+x0YO+a5cVP5yG8sM0ixvdm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.29; Thu, 22 Aug
 2024 09:43:19 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:43:18 +0000
Message-ID: <11485f4f-1d26-4320-9d2a-2032a8e19653@amd.com>
Date: Thu, 22 Aug 2024 15:13:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/4] x86/cpufeatures: Add CPUID feature bit for the
 Bus Lock Threshold
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-2-manali.shukla@amd.com> <Zr-qkJirOC_GM9o6@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zr-qkJirOC_GM9o6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bea94f8-1849-4897-2eb0-08dcc28eda37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHRUWi83ZEZQanRReFJtN2RaWm9ONmJJUkM3bU9NWTF2eFZHUGpZY29Zczc0?=
 =?utf-8?B?UjU0NFdpSktFZEwyTCtJOUxBZk5ocTNkQS84L09HK1dmRUd0NTY5bE5rVXI0?=
 =?utf-8?B?VVVKTUxHUWFxYnhZaGx3ckdJSk0vL2RXYVhCay9qTkxEWi8wNkxMRFJUT0VN?=
 =?utf-8?B?c25mdTB4ZUxvNE15TXBDWEZYVkpFdG5UZ2U4YXgrT0QyMEtqbVRXVUt4emVQ?=
 =?utf-8?B?Qm1jRUxWbDBITngwOGR2ejZ1c2RpME5RT2hPMW5hNVFxODhscWFmQTNOMVBB?=
 =?utf-8?B?VndPaHZyanJHVGlLcGlNSUpzSmNYL0I5ZmxDbE5EQm5CV3Q5WDlSa1UrR09v?=
 =?utf-8?B?S3ZLTDh5RkRIZGNYNGV2akZsTDM1Njg4cGREVjVmZW9pQ2Fsdkw3RVRGSU1P?=
 =?utf-8?B?SzgzbktIN1lramw0U2t0Q0JqRFk2alhkSWpTT1RhMTlINURDdHgvRXVuc1hm?=
 =?utf-8?B?d0dudzBMQmxlcjFtUWFtK2pQZDhxUERtYjM1Yk0vbU11V09JSU5HYlNFampp?=
 =?utf-8?B?cSs5RDc4dG1nNEpNQ2tsOExTMjZ3UEFsbDdWbGtnVDRaSk1oTmVEZ2s2cVVz?=
 =?utf-8?B?eUZIVHYxRWs4TFhSZlR6b0IvZzJtV3JDSTRpK3JHNGdMY3BYdCtJdWgxT1Zq?=
 =?utf-8?B?SkVqYXB0dHRiVmdyWUkzdUkzZEJPS2FVcFNBb2RqWTFHemc3M1FWdW9QRmFx?=
 =?utf-8?B?b2EyeWo4YUZ3Z2pEODNDV0h3L1YwcFBDWkthN0Z0c2gyNjA5QUNlV2RTOFBF?=
 =?utf-8?B?M2UvVXV2MU9FUG5YWTAxR3ZGRUlYNmFvZkQ1c3Fna1F0dENmcm43bDVURTBu?=
 =?utf-8?B?SVBQWVRHYUg1azMxZGcvYlJoR29Ta21vNmVyQ2Z2OEdGVzI3RFVBMktWVHZ1?=
 =?utf-8?B?TW5WV3hNeEF0NllzNzBrWGJwVHBMdHd2bzM2STFoSkYyZEFRdE1vU3BBY3p1?=
 =?utf-8?B?R3gzazlORS9HcGM0YlRUMTJOV3VleHZCZ2JVanV5clJhT1VOVDE1YTY0bXV1?=
 =?utf-8?B?MWpndDVmek8xQnR3TlRMK1BWMnZKNkdNdEZ6dnN0amRpVWw2TmJXMktsVG81?=
 =?utf-8?B?OUtidWwyUEZtM0d1YmFJdEtFaU9SNlRQOFQ5eUIxQk0yNUcxeGFMbW4zNlBX?=
 =?utf-8?B?bnVDZEpQT0wwOUFDY0o5dHR4aTFES1JiUnQ4Q2lSNTRxa1AveEhvSHI5UWxV?=
 =?utf-8?B?Mk92YzZvQVFMbHZnaS9KRkp3eHhWc051YlBxMFhMNWJHc21UaFhWSnlXZzZ2?=
 =?utf-8?B?WTZFTCtvQVoxcjNLRVZmVnhhbVJ1SlFjakQzWi84bitEbVZKeGVpamFkZlh3?=
 =?utf-8?B?SHk1a0sxeXdGODByZXF3b3pQaWQ3d1FYL3B2SWFyazhUMHVtVzluMFpUOTRo?=
 =?utf-8?B?QzNKYkZ1d25RNmRveTBWbjF1L2s3SlVHampaY1hQNkNBS2FsRi9IcHZXSWdj?=
 =?utf-8?B?NjdINlkycjNZM3NjdW40M0VaNHdrYldjN21ndzdKM2IwSkRBZnJ5UUJLWHlu?=
 =?utf-8?B?NFNsWXJMRVhVdWIwZ2owd1p5ZDJrL3lxM3RxVkp0SmtBakJNcm8rVCt3Q0FN?=
 =?utf-8?B?TE9jTzVBaUYxY2lBSTdJbzE4MUJKckxReldpOEZyT0djOTBObjZjdDFweFZ2?=
 =?utf-8?B?V1JqK1VLMmRKZUhMWXNuVmJtT2V3dkZmVHRya2ZTbkZLUTNHdHZSVTV4M2Zp?=
 =?utf-8?B?RlhpRlo0N21MNHZ1Yk9BT1pxRTBDbTBGS3JyZTh5OHlmcmxsY2s5aWpjeC84?=
 =?utf-8?B?ODhvY2ZFcWlQZjNHaHNQOXlGRkZ2TnZEVXNMM2xiWmlhV1paV1VKRFRuQTE1?=
 =?utf-8?B?d2I2K2RVVHJFYnRNd2oxZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5Tc3M4LzJZRU9SUm93L05qYlA4ak9DRlVZaFNJVjN6THh5Njk2OUJ2NkY4?=
 =?utf-8?B?dUJwOHhCWHFZbU9zYVY2a3VhRGx5NGpYY2RYUTM3N3gxNjNYQUE5YnRKRG51?=
 =?utf-8?B?eFF1MTdrdU42LzMvd0VaWlRJaDg2c3lXMmZPcmFwdW1PT1B6aFhYK0t5d3dT?=
 =?utf-8?B?TzBjWmNDbEQ2MVpSOElhM2ZWM0s3VUJINzNzQmJUTDBXMzluTDVZTUZJVEJm?=
 =?utf-8?B?SHd4NmRMOEI1U0l4azZSK1h6bmZkcU50NVZ5Z291UFVFUm5paVl4YVZWbE1a?=
 =?utf-8?B?d2czTFFFOWtqZGlGVThEWlRKTncrRWRoOVdSOVNmQlE3NUpoNjVLaGpWSnVN?=
 =?utf-8?B?azlwQUgxb2s2OU9jOW9IMytaZEg3NkRaKzdOZFdoOXkzdzd1aW5aRW5taVR6?=
 =?utf-8?B?eDQ2ektUdCtBM1NiSW05cGNOUG5Jejd5bzV2amJESWR1Ykh4bWZxRkJQdEpJ?=
 =?utf-8?B?ajVOWXBzdzMrWkZUNDFaWVJIaHMxUVhsRjBzeXl5RHE2Vm8yRG5TTk5IQUZn?=
 =?utf-8?B?bGlTRUxlcWhRQ1djeGlyREVpNjJWeGo1MG5zZ1hwOFQzWWpVMjFBS0RvTW9J?=
 =?utf-8?B?QnNGc0lSekl6L29DTkc3SUJHSVJQSlpLUTFPbWZvVFlvanoyM2JrT0FYdThT?=
 =?utf-8?B?QUdPekxqM2R3QjNyOHhSMFFON0dRVHNRYnpycmFoVnV4cWxtVmlKQ1Z4VkVG?=
 =?utf-8?B?aXkzeWVwcm4yRzhqK04wNkVLNy9WWmNQNkx3Z2s3TVVJOHNyVFJhWE00N3ZY?=
 =?utf-8?B?Y3IvdzRKQldHK2lBMk1hcmV0RzdldGRxYlJDTnFySklVR2FlNjhwWkp3WGQ1?=
 =?utf-8?B?OC9NcmZaek5TRklZZlNXUVBxTjVhZkNYVTNFSGFlbWh0SnhBR0xhZE9hbk5i?=
 =?utf-8?B?bC92dlUwaldkQVVwRnM2Uzh6cUliY0puUGVWdi9GdWJWUzEzZ3hLR2Q1MXYz?=
 =?utf-8?B?U3JESUM3YkZ2RERLYXhnMWYrK2RQTHFlbnN4VFl3MGVndE9JTjlyMzdKUDNR?=
 =?utf-8?B?Ym45TWxtT0w1cVZQdmR1YXNDeFRCMmNwblYzaklKY1FJN2RrY2FCTXJSVUg5?=
 =?utf-8?B?NXZGOTZhZW9KdVhndWltcWRtLzlScWtjWnFaZCsxemFBei85dk9YUmszMTA0?=
 =?utf-8?B?M1lzakljT1JSKzZ0d3M2bFdoRVpCWVBGaGF5MWtoMGt2dWNlRFF1eG1lUmIv?=
 =?utf-8?B?THJZN0NJRVgxOHp4SGw3WTRoc0wrY0tXRjkvM2pKRlZ4ajIvbEI1eGh1dmtW?=
 =?utf-8?B?TnRvczJNVWJVcXFycW8wUzVrMTk3MjRudk5objJ5QndncHh4ZHptTlhqRlhP?=
 =?utf-8?B?QXRKSUtlRXpQOThVOElmd0lHNmtCTUhSQi9PRGJEaGp4cUxpT1lhbVI5RlVB?=
 =?utf-8?B?VDRRUytsZHB4VlQwZ3Y2aEMwa0wvWDl0a3BnK0ZWQXhWZ1lwOERKbHlvbWZm?=
 =?utf-8?B?WHdNV2dsL1pjQkdGNlZ4L095b2dCWWQyUVMyTDF1Q21Ec1gvcVJXVHpPN1VX?=
 =?utf-8?B?Rk5wcFIxaHhoTWJNM1JoSHpTcWptZHJvaWJBR1U0Yk9oaDFjSlVlZG11QnJr?=
 =?utf-8?B?NlhLNUxHa3gweVRka1hjQVZ2YytjMklGaDRzZEw3TzlMS1RMTUxLVFcrT1Zw?=
 =?utf-8?B?cWE1cXRPM2F1TU1yUmVDOFovaFZjNm1LUnZraVprWExrZmQxc2xoWVVlOEdh?=
 =?utf-8?B?d1g0aE9WV3pnaVE5SUdGdHYrUTducVJ5Z09XZWEyRW1VUGdDZ0FWZ1pmUjZx?=
 =?utf-8?B?WUNub0krTHFJZW1seVdzTnloeU0vODhTbklNL1FMTWJkUVNWbE83UGN6ZXJF?=
 =?utf-8?B?THZaYkxoMmhueUM0cDBVWjgwa3ZRanRwZ3VqL2htY1FxNTN0WXp1VHBaQzlL?=
 =?utf-8?B?OU1aSy90cWM2TkJBajVMSHY1eXZCTGU0Y3dWeGZnbVNlWTN0VHI2a3JxTFlt?=
 =?utf-8?B?Q3dDbjBSaXN2L05vcGpDS1NwWlhzcWl2ckRhd3BKN3VEaFhIam14RkVrQnAr?=
 =?utf-8?B?Z0JMTlNQZjZORDNwQVduN01UbE1mSEVCSXBId1RuQnh5cW4vbzNsK0RaTENu?=
 =?utf-8?B?QnZsQW1NR3d0T290NWdhY3UvYWx3dGpRL01xRGRsTkFHVkROUS9HaGpwTEdO?=
 =?utf-8?Q?HNjQQTJOyRICPn3hZR2xx/sw8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bea94f8-1849-4897-2eb0-08dcc28eda37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:43:18.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dJ2SoD0wxvJukleBS5giatDMFUmmz/tYSxv2c+yqy7oP4pwEN88kW4NdL02XEw6MMsMtH0mCTH1/8raGoqGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254

Hi Sean,

Thank you for reviewing my patches.

On 8/17/2024 1:07 AM, Sean Christopherson wrote:
> On Tue, Jul 09, 2024, Manali Shukla wrote:
>> Malicious guests can cause bus locks to degrade the performance of
> 
> I would say "misbehaving", I bet the overwhelming majority of bus locks in practice
> are due to legacy/crusty software, not malicious software.
> 

Ack.

>> a system. Non-WB(write-back) and misaligned locked
>> RMW(read-modify-write) instructions are referred to as "bus locks" and
>> require system wide synchronization among all processors to guarantee
>> atomicity.  The bus locks may incur significant performance penalties
>> for all processors in the system.
>>
>> The Bus Lock Threshold feature proves beneficial for hypervisors
>> seeking to restrict guests' ability to initiate numerous bus locks,
>> thereby preventing system slowdowns that affect all tenants.
> 
> None of this actually says what the feature does.
> 

Sure I will rewrite the commit message. 

>> Presence of the Bus Lock threshold feature is indicated via CPUID
>> function 0x8000000A_EDX[29]
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/include/asm/cpufeatures.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 3c7434329661..10f397873790 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -381,6 +381,7 @@
>>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
>>  #define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
>>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
>> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "" Bus lock threshold */
> 
> I would strongly prefer to enumerate this in /proc/cpuinfo, having to manually
> query CPUID to see if a CPU supports a feature I want to test is beyond annoying.

I will do the modifications accordingly.

> 
>>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
>>  #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
>>
>> base-commit: 704ec48fc2fbd4e41ec982662ad5bf1eee33eeb2
>> -- 
>> 2.34.1
>>
 - Manali

