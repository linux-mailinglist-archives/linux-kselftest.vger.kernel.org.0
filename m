Return-Path: <linux-kselftest+bounces-27512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302EA448D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94224173DE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A83919922F;
	Tue, 25 Feb 2025 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4jiItHi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036AB195B1A;
	Tue, 25 Feb 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505543; cv=fail; b=Jro6cRR0oDmLjsX7iYR6y+i5jfmfLJeBPjJN3BlGcCLOpzIt2g2Y5Stl0aoqQUiws4gUF4yWfYTsoV651tdR9ap8SQQNYI/J3XsEarxXt0+C92om11aPKTcrmzNJ2epNQl/hJSSGSpGgW0O+sP0pVpvqhraZQLLX1OIk8BuwozY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505543; c=relaxed/simple;
	bh=8CD6XSse73UE9ZAwrB9O5M9dh5PHnLsYR4/5m5eJc3k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=P9qR+WNoGMEJEzOkQDCINylVTKRKw8rnDS/v7PzaYR0nQ8qutaKq6DzB+HMl9WjgEI9ypibiKaHjIDFLsAOkvc2yJSQHVAe57SfuOEcWoxsFPhnJbTgLLpo/eLZNJquGaaQgnTfBYBLZXzaBefLini71XlEFOYIfKzzEJ6nDVj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4jiItHi; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6F7MLKeTyvj1a7ntqD7hAxzUP99tdy/1rSagIQNkLmXrLoXjwK8IsN6L3eWSxBdPxKOIxpOm8lOo35b7rUebBM1cSKSbJlzEdCmISH8QzE1TvHN7SxY46uqS4A9RaxjDYlfUO/AG5W5tVz60U7UBEODXvbg02W5zSPVO9vAsHnAcx2ryYjRC5n9exRmOWSjUI0Fa+IkhTIbnHuD3UOM4him56F5UZZoxUBbdiyg9ZGbm6FhkNpnmaLLvgzfvdIL2tEo8Nj1lOiuhD1G2iBiYp/a+/eMvEcGt3WEp2QBPAQdgJw7V/QL0UsCFiGjjJkwnnF25scaq6iqtPA2yAqTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdRen1BHsOsGWHv0bv5FiTq4VBTXN5rYpYwLxf84czU=;
 b=mS+MEMTVt1XKctMLFuYeM2zVCZyqm9dnqjl960SFXvxr6UWzTlZY2AlWdrIk6E3x531zcfqfvQInjRJpgKADmLAODCA8XWZ+5cLn4HSi+NcUMyTsQOdv5jazZCBvWpEjqVKbWxU5yt10TwMDVq5dV9Fu9QNy/3as8q/emGk6hYTlwULimOk6gdbpApV7ooV6nDD9HTOJptfTnm9z7wWZHYMOTrBLRjEV987xo0/41PQ1UpwTRO6oyVLMOsbifH9RuPxggcJtlhPaPg7hqE5DXJdbMCRj6w00qkBnm5Uyx7wPQD2Pl1M9VITKfq1WdX6G/s6qwixxWQA3J5JxywBxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdRen1BHsOsGWHv0bv5FiTq4VBTXN5rYpYwLxf84czU=;
 b=k4jiItHi0rtxwqWP505Qd6LBPm5ORl3a51R1m+3cGjqsw34fSaXHEDqbHsjLLKjZqOTX5NCjlQhWODqx8rLDLOzG9yiKT2dhit5lhmk/vS/LNtkLA7vUCAW4tanWrRDNWIEpjznjz9u61Bva3Ud/qvK/nuy1WT8Ai8GBYBcU6rs=
Received: from CH2PR14CA0042.namprd14.prod.outlook.com (2603:10b6:610:56::22)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 17:45:39 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:56:cafe::fa) by CH2PR14CA0042.outlook.office365.com
 (2603:10b6:610:56::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Tue,
 25 Feb 2025 17:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.0 via Frontend Transport; Tue, 25 Feb 2025 17:45:38 +0000
Received: from [10.236.185.178] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 11:45:32 -0600
Message-ID: <a84a3d32-9cf7-4c24-87db-99132a450557@amd.com>
Date: Tue, 25 Feb 2025 11:45:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
From: "Pratik R. Sampat" <prsampat@amd.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <kvm@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<shuah@kernel.org>, <pgonda@google.com>, <ashish.kalra@amd.com>,
	<nikunj@amd.com>, <pankaj.gupta@amd.com>, <michael.roth@amd.com>,
	<sraithal@amd.com>
References: <20250221210200.244405-1-prsampat@amd.com>
 <20250221210200.244405-2-prsampat@amd.com>
 <88fc49a9-d801-5d8f-f156-28fa06910cd6@amd.com>
 <9480ce1b-2c35-499c-b60f-1c02ea9cdc16@amd.com>
Content-Language: en-US
In-Reply-To: <9480ce1b-2c35-499c-b60f-1c02ea9cdc16@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: b15e1f2e-b37f-4219-1080-08dd55c4375e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmYrMU5BN1pYaW1nM1BYTzI0L1VJeTBMU2tRQnY2Q3VDTThOWnhuY3lxdWVi?=
 =?utf-8?B?d0VxMHNab1ZJU1QwOXhxTXoxa2psNnJYZFF3SFVHek1oMjBxTldUcDhYaXZ2?=
 =?utf-8?B?WGFZV1pvcVJPT21CTkJQK3V6WUJsWXRLYzF2Y3B6Qjc5dEhzR3QyUVh2cU9D?=
 =?utf-8?B?SG9FeE9Uc1VaMVNSWlZKOGdBR3VyR3RvVVB4VU85TjRlRm5YNU5GY2V2VEp1?=
 =?utf-8?B?Yk5NamI1N1hXMEFVcXdsZkNSc1JVU2dUdG9vV1FhenRVcFp3cmFhRHpEMmRM?=
 =?utf-8?B?VkhDem9GNEdPaXNQa3AyUVBiWmlyclNYYmRHWUExQlpKQmJuZ3UzcnZzWi83?=
 =?utf-8?B?VFJESktBdjdubjBSNHpoemljTFRza1hscTVCd0JZamY5YzFsYTVpSjZWWnQ2?=
 =?utf-8?B?ejBKNXpDTTZveEdoS3R1VVB0WDdxWlR5alZzejlwU3lpczl6RHJXNkpuNDh5?=
 =?utf-8?B?M2hpNUJ1cFNBZXMxNHIvZGNab2pqcjg3ZGpzWCtYTFhncGhaQXMvcHE4SWxV?=
 =?utf-8?B?b3NGejBuWk9iQ0duUEhTTzdQSFlVVUNuM1ZDeUNkb2docEZKTTRTOXJyMFE1?=
 =?utf-8?B?QUpqQUFGaEg1dmZmZkthbXdDNHNwbDYzbHhjNlZTclA1YjZQYlM3OUZ3b2dT?=
 =?utf-8?B?TXN6QnVvR29qYlZjdWNLTkg4aEpja1l3NjNZVGR0LzZMMFJsTVBOM0plb09v?=
 =?utf-8?B?eVUxRUVFWW5YNW14N2pSRVNFTFRrRklPeThmTjVMNHBDL2J4N0pGS3AwM1JL?=
 =?utf-8?B?TDVqdDhnWXcrMEZYc3g0WlVCQWwzZWlFZlViZ1I2QWFjYVA0T0gzNEw0U1Zr?=
 =?utf-8?B?VDVOclVHTlRlemozM3pnVnpLWlhWSW00MUw3cm54OWd5NHNKcysxcmw2b3F2?=
 =?utf-8?B?R2xxZEplZk40aUFsdmdtTC9vdkdqWnN6T2xxY3grTHc5MUpKNmJoeFo0bVNF?=
 =?utf-8?B?NEVLeGJ6VVEwNG5iekh2UzNyRmZnMlhJbVg5S1l5WXVDT0lndGVPV2dqQUdr?=
 =?utf-8?B?Q3hSWFJwanJ0U1ZsYm5rU3F5b0JhSG8zbDdzbkRMYU5jRkNLUDY2dnQ3M1R2?=
 =?utf-8?B?MDNqQjRFeHgyWEFFOGtPZFhwVklMTVR5MWlHWFRlT2hidS8vM3BhQW5uOVhP?=
 =?utf-8?B?aXpwWUp6T1VPM2w0b2pCamRQV29TNS84YnllUXZVWktUay9MVVBWbVJ6aVBy?=
 =?utf-8?B?Y1BKZUVzek5wd2l1K2xndCtWdTFMdis5Vkx0Q1M1QSs1VTA1K0VHZjRaWkpR?=
 =?utf-8?B?TFB2Y28xL1hjRE1QTXpEMTFPc0I4NWVOQXJ4TDZESnFVMUk3OXRFN1gyejJ2?=
 =?utf-8?B?VzFFeWEydStyd0ZCN2M5cUI0UVUyeGRJYjhnQW5SYWxSNXhtWTV0RjNUSW5N?=
 =?utf-8?B?Q2dBMVFoL01COVZicjZoQ0ZBVkcwYlQzeHFEMldsMXFNVzJvNEJzbmhUVk93?=
 =?utf-8?B?TGd3WDRtelkxVG5rZmZYY0FtdVJ3b2dJbk1uZmJkblltckxhdG9lZEZOUXdX?=
 =?utf-8?B?QXg2ZTNUOWVlWHFZWE9qYVBtU1hBajYzSFhDa2NEN2hYWi9BaTFaNzYwRW1N?=
 =?utf-8?B?bmdtUVNhYkxaSnMva09zTTRKdFhOeHN1TGNkQkQ4aEpqNU0rRWdiUmRpcURj?=
 =?utf-8?B?OXg3MVRFOEUvejBtRlA1L1hSRjc5TEgwZ29yTWFxaGlCb0g5cEZDaTJwQUJC?=
 =?utf-8?B?T1duMzd6a09TK3ZTcFZLMkRFNjl1VzNLWjBxS0xwVkJPd3ZOOG5SVW9GOFdB?=
 =?utf-8?B?N2hYM3lRcmpDOU5KeENvVjFCeStnSWJXYUZQU1NDNmFldzRUbzFIeVZobk1y?=
 =?utf-8?B?Z2dwMmtGL3crWFpMbm1mQTJoTDcwVFY4dFpNVlE2ZEg1MjdpNk5PUkJ5RG4r?=
 =?utf-8?B?VU4zV2ZUWXFtdG5Sb3hIazNZc2JNVDVlMEtlRWtQS2NoY3ROckxudjRxT2R0?=
 =?utf-8?B?cFRxbGs1SERDWTZ6WWxVZ2M3OGM1V2FndTJ0aWdndGdNRW9XQ3RUVVZJdTJY?=
 =?utf-8?Q?SKO4w/wULnGfPHn2R6/y58+w0jfosY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:45:38.6715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b15e1f2e-b37f-4219-1080-08dd55c4375e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071



On 2/25/2025 10:41 AM, Pratik R. Sampat wrote:
> Hi Tom,
> 
> On 2/24/2025 3:28 PM, Tom Lendacky wrote:
>> On 2/21/25 15:01, Pratik R. Sampat wrote:
>>> During platform init, SNP initialization may fail for several reasons,
>>> such as firmware command failures and incompatible versions. However,
>>> the KVM capability may continue to advertise support for it. Export this
>>> information to KVM and withdraw SEV-SNP support if has not been
>>> successfully initialized.
>>
>> Hmmm... rather than creating a new API, can you just issue an
>> SNP_PLATFORM_STATUS command and see if the SNP is not in the UNINIT state?
>>
> 
> Although reading sev->snp_initialized is probably cheaper to do, it is
> cleaner to query the platform status.
> 
> Querying SNP_PLATFORM_STATUS requires the pages to transition to
> firmware-owned and back, and the helpers for it are implemented within
> sev-dev.c. So, similar to sev_platform_status(), I'm thinking it is
> probably better to create the snp_platform_status() API as well and use
> that within KVM to check the state.
> 

Although I am guessing the initial intent was to not have an API exposed
at all from CCP and only make the SNP_PLATFORM_STATUS call instead?

Since that may not be cleanly possible (we have helpers for page state
conversions such as rmp_mark_pages_firmware() in ccp) without
duplicating functionality in KVM as well, I guess the question really
boils down to whether we export the cheaper snp_initialized() or the
snp_platform_status() API instead?

Thanks again!
Pratik

