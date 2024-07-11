Return-Path: <linux-kselftest+bounces-13608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3092ECAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C581C21629
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A276016D301;
	Thu, 11 Jul 2024 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B4vXUIKc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E216CD12;
	Thu, 11 Jul 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715284; cv=fail; b=kuvn3ydf/cCH/bGul3nBULVpeKP1pVK2BuRRZsYn7Ekbg9GF3BFXOOHHLkSAU4UJOmu15hX/qsahXqomWfcLvVE5OgCR6fTf30nTUmb1hYjOjqDBXFOMfc/C2sXLmuGty1sgBE2rvt1VUlFJXZLnD/itU9Sy/8JIYqjt1aX/LPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715284; c=relaxed/simple;
	bh=YQpEC/qiBQroa3mm1E3KI5PbV+xGPjIZrAFY7CCxWqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cz8F/ZKLtzmRrjFiKMYrZYAx3M66Kd1yQKgZl2bIdWgJC/mHa8u3sXneHq+RrsP0dFX21dud+YOYj0TuOBsmQKLsoGLFT3hxEaRNWha9ukRHgaOFtmXrKX1j3ZpSkEAvXM1FwjmNinG2E1o+l9frJDI2VXUp00WKygUzGC7w+kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B4vXUIKc; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugAL/1omO5WSo3BzAXDObfA4NqNgBaPgN5C3FXvB5AZQwpmBkodev2IAu1AyG/3pbls7jmYVOdUnZdhZ9+WOzK+m/t2WcMLyDEyqqgUFUV95/LvhAqbGGqeirnsfc5UVZy/2hOJIlA65Gdpq5X/mnd5CGQ2lDAgg/D2MeivV+mST1yUwWCYeKJCLDTQesSroQr0bRQIrZ+O52wSlBuLITJrPDMZugKwYSpLI0k2jC+fzEbb8Z6vXOXx1kJP8pKJYWhFdpmoaYP6PfvqX5o5dpcpGXw8a6z2blNF/2+sdQqA5A/g8bS75WShFm1kdrDrtqq9826dlts2WuhHwrBwVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttBJGxeYpuClpbEojPLyU39jatLusNucKMm4ywTf4gE=;
 b=TNvlrpBGsgcEWHSNvUkmsRfCa7BAwaHD5gT/+RPSqXFpHfGi1kwHGk8hgvZhvdXCh2aU4Wbuz3JHUFtPNvP3a6DFDHSUVruL7tS1qzxaRxOAtHpdrMffJSyNCiVeX62Tf0LFckD7IfDHw7Jj1qh8/BfIdRjPfGJqt4um1QfLobguGFCgqUxt63cluJmS5/lVez3begKeY185sbit+CGJC8zua3qTcqfScIbVPfEOZxav0nKD5PS+JLrydzsiXVnj2Fm4w7FQTKmJ2wDBEpiDNzzbzP2AHijGKCmYIC/HvSo7cR1P8653W1D5IPYjad/ewKYRzf4SASknm66LeEbm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttBJGxeYpuClpbEojPLyU39jatLusNucKMm4ywTf4gE=;
 b=B4vXUIKcaGx1MGIIXd1svGVLVgOv6Vqi2ahE8CcGhPF4pGRO97O+hVl0r7BOdW5YEB4vuoZCSJvXrfxL3F2D7hoKoo8CpV/VdGTtzdP7UWjTtP9kQF4HHBPHI+PUhf2Yr5I2X6gQkGITQ/MRPHvZ/Akyc0BNlzgFhgRnXjxLpgk=
Received: from PH8PR22CA0018.namprd22.prod.outlook.com (2603:10b6:510:2d1::24)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 16:27:58 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::a0) by PH8PR22CA0018.outlook.office365.com
 (2603:10b6:510:2d1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 16:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:27:58 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:27:57 -0500
Message-ID: <7a449bc1-8ae6-4242-a8ce-df917042a1a6@amd.com>
Date: Thu, 11 Jul 2024 11:27:57 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/5] selftests: KVM: Decouple SEV ioctls from asserts
To: Peter Gonda <pgonda@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-3-pratikrajesh.sampat@amd.com>
 <CAMkAt6pYAKzEVkKV1iriQei3opD9j3M4bM3-0yB4sX1wss+jsQ@mail.gmail.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <CAMkAt6pYAKzEVkKV1iriQei3opD9j3M4bM3-0yB4sX1wss+jsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: d2be62a2-7b77-41fb-bd5d-08dca1c66d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3pTM3dKcERCZ1BudnZRaW5uSGVKbENyOWVQY29yclZqdTZ1MzdGNHNYT1Rt?=
 =?utf-8?B?SWJoUFl6dHBheEhmT2xUOFBnMWYybTdLcTBpU0h6aFVqTE13bGo4UHJ3amhN?=
 =?utf-8?B?U3I5S29rRFRMc3RjcGVONG9GL0ErNmZZQVRCWWo3Wlg4bGNIQUh3SGNaS2Fp?=
 =?utf-8?B?NlEwL1JFMTRmWnhRZ3paNkNjOWNjNzcyMjQzb0xzM0Qvd0FNZHNnd3h0VlUz?=
 =?utf-8?B?SDkzKzdlR1JZRnhJeDdDSkxRVnR6NG84dnNhWWRUSHdEYmlOQ0MwL3N4cmpU?=
 =?utf-8?B?S0tNOGNSa21pOFRzaTJFTU54SXVxYTQxSkIrNG9xTlZBTjFLZlhGclBaQTVw?=
 =?utf-8?B?M0V6amgzZWlZdTNmY2kyKzJTVCt3dnlBaTJDRm1tbUFaVCtmM2RKcWowSUEv?=
 =?utf-8?B?RlI2ZUtmK0xud2RvSkRIdFpwbExHUTkrVjlUYkZ0Z3JvaWwxeS9WcVhnQmRG?=
 =?utf-8?B?UXlIU2lLWEQ1ZFhPd3cxOTExQUtJWjZnMHhOempJazdtWlZKSTJwcGRjNHdI?=
 =?utf-8?B?bitXQmdGMC9GbFRUdGt4d3lQK2lVRnZYZGNKSFhlM0FscVJJY01CR0NlZzJC?=
 =?utf-8?B?eXh3YUZCN2M4YUxzYVA1dHVPTDNTZWk4QU9ZWExGMklkeGt2cTVvdzRJUnpI?=
 =?utf-8?B?a0tHRm9uNWk1RHhOS0s1MkI5bEtPMWFKV3YrRU0wbkhjbnRPMjRCbkZkK2FV?=
 =?utf-8?B?a2x2d0tWdjhObDhqOEdYam1COXg2bGdzcVlsRS9XN2tCUi9LNkRVa0QxamFW?=
 =?utf-8?B?RmJieEJtV0N4cWtWdnFLNS9ZT2pGMEZLK0NlLzloUVBkK0VkZFR3Vmw0TDQz?=
 =?utf-8?B?OVpXR0o2MVJMd2pBQTkyczFnS0dONGdrZzRnNHNsZjlNK1hjU2VnNFhMNWV6?=
 =?utf-8?B?L3JxUXJzajRuRDNmVHdUZWVoMUVPL2M5L1grcHJOK1NldHdDemF6VXFMT1Fh?=
 =?utf-8?B?QWtIZ2luVlVJRkZTUWorMVhqZ0Vwam9wc2dXWnBtVllsQk1NaURidzErcjd2?=
 =?utf-8?B?UW5CekErMW5mTWczWDMzOTErc2xlbmlsUFVvMEFUaTV3cEJna3ArbjRSZnJM?=
 =?utf-8?B?TWpDaWdicklsZ1J4azRvd0N3Z1BSUmZXSGNuSVhCK091ZllaWmRxNjVyWkQz?=
 =?utf-8?B?RlRSeU02YUVRdmxZc2YzelUxMTZTUUlPSmc3a3A2QTVrOEZTWDNOUFJrSm5R?=
 =?utf-8?B?d3JMQmhWVkZaZ1VFc3lvS0FLampoOEw5RlRQcHo5SkFkeWxDRGVoUXYzN0w5?=
 =?utf-8?B?L2IrSDR6VFc5dkNURFZ4UnAxL2E0QXp6RDZUZXh3WWdqVUhRMHJkVkNwZVFH?=
 =?utf-8?B?VStja2lqcGJ2bENEM0hVcHp1TzNsbkhMRExnTCtMZlNnZUJnR2Y0MkFibWR6?=
 =?utf-8?B?VUFQTnM1TDB6bllrRnkyLzhUTkgyTmdoai91MkhYeUNtOU9UQjFNcXg0Z3Y4?=
 =?utf-8?B?TGlGWDZ4cXFCZTBCSzMwS09ZSGdKQnVub2xLMEY3Q0V1YWZHallVR0JXL3hY?=
 =?utf-8?B?d2x3Z2IwK0drVkU3MHdrakxqQml6UVlYRHRRQ0g3aVE1a2E1TlN6ZitSaGpT?=
 =?utf-8?B?MHpLam1wWnBESVNpbmV6S2NWeWJOWlRwMEdneTVuK3lCNUNxWGlNWUVYZUdi?=
 =?utf-8?B?bzlGM0x3dGR0b3JkSlhSTEpMM0lobXY2U2RhY1Ztb0tJcWVmWkM0RTU5djhm?=
 =?utf-8?B?YTd1SEhxcEtRUU9sUmlEamRMZ3R5ZDRPV2IzUEJFTXhXUlpIZnd6OUJ6Zkl6?=
 =?utf-8?B?QU1XbVZwRkwyclhwSUtobzRTVUZXcDZ6K1JJeFhLaTk2RWl0aWF2OEpZRU85?=
 =?utf-8?B?R2tOZ0hSVEEwVnFrMHdNUWNNdERZWEVxT2lZaDBSN25SR0d5b2k2UDdJY2d5?=
 =?utf-8?B?d0lZaHZacG9mRHVyTlNrMTV0aS8yWDMzakwvcDl2ejVBTWoranM0a0RBSlh2?=
 =?utf-8?Q?u/Rl9kb2go/BAkH0MkHZYnTX38AI9HLA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:27:58.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2be62a2-7b77-41fb-bd5d-08dca1c66d2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766



On 7/11/2024 11:11 AM, Peter Gonda wrote:
>> +int sev_vm_launch_update(struct kvm_vm *vm, uint32_t policy)
>> +{
>> +       struct userspace_mem_region *region;
>> +       int ctr, ret;
>>
>> +       hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
>> +               ret = encrypt_region(vm, region, 0);
>> +               if (ret)
>> +                       return ret;
>> +       }
>>         if (policy & SEV_POLICY_ES)
>>                 vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
> 
> Adding the sev-es policy bit for negative testing is a bit confusing,
> but I guess it works. For negative testing should we be more explicit?
> Ditto for other usages of `policy` simply to toggle sev-es features.

You're right. Although it works because the way we want for negative
testing it does go by exercising a different path meant for a different
policy.

Maybe I can refactor the old code to all test for type instead like I
have done with the rest of the patchset just so that we are more
explicit. Would that fare any better?

