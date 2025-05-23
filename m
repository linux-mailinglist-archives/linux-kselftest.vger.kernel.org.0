Return-Path: <linux-kselftest+bounces-33608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9DBAC1D99
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 09:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5663B9E2F98
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782E821D3C7;
	Fri, 23 May 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rVHzZIAy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62921CA1E;
	Fri, 23 May 2025 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747985015; cv=fail; b=bidwe5+022AayEBF8nXnGV24tQ8LgxIGcxlPiyPh18VNAGfrgWFawlW82lscpQ3g9O1aNUh+ELoK+2RrK1ZOxDR3TiLqemsYUKrWc+uoFjFaks6+CMecFXGfRcxn/y3921T3bpnCi/3MvfS6DII23L8p283WCRGSI4jELLK7/YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747985015; c=relaxed/simple;
	bh=SkOAk+FTEdJluefeYtEE0k7VUoG0DLGfV2piKndm88c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bfyZS0qS6ZLdqk1IN/lOJq6QObRtj6RRriqwOH53fnB3DPFVGH4jMDRtmUqbckgjtrNmotihgSQ1xMgYdWk6Zh3DN5mGs0OAGk4ZRsBIORj6WrAUeP4BRWlRCGJ4PoH4z/YFlLbnDUfx+1IgVRDU9n2+E8EGp3MQLg3eNczjVKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rVHzZIAy; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgplzmR2ZWgceVGpqNh64nahYk2AIcXIKmZ6+qNqxQEBYbzDpXf5SzZ1+rG/4y0z/LmT9cKmBOfSV6dMMy3XHkfuXjcfqykKAClhP2QPI8gWfe+PLWplz9njJSj2Ccr+2rTIwpy8M0YfcStzXb1tZHQJWXEI2zfcMuLIHwl6UrWPyn2JTgn0Ow6Ku85svZ6TZx74NmMiBryTmwew6ZqTWYuilGVz/vsi7Trthy9hCwNpL3eL9xQ8toyFE6drqHTeEdMa0s8TwqF/i+QpTPWgYXzwBhSJ3aw8zjN0GAZRjhYJtQlGPVqbQdmjEtcBgJZe1a0hzPDGWFCFsJ9B6PxntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJudB0MHTWMo1Cv70g5UMQe8b9A5acgzYPfE7bqls9E=;
 b=jaGO6e+2ZRPlM4L7SP8RzOdmCG8r050In+1YjvYPosQBdHpeE4ABP4E0vlJpiUgphuFxPw+Msq9aF0O2EbqdfDTkdwaZqpjapubS4q2QzFIDYZeRBmfuWEoyBk0JtIO8Dv4qExkiv28UTyae7lpboHkySg7m8YoU1wUNh0gr342xMyAKEnMb3ARtIwhjfRGhNafVLTWgyfioHWPOwm2C44neGVOscL+WHMXcprCLjHbfLA8VtsaZsBC+GrUGPL2vnldsrgHXkEmdO1TYciG4w94H9CKlbHGsTYkRa9iKpmvjfAsPw2vgPy2L7839LdiQ5SQWKL2x3c91CdrF3iw/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJudB0MHTWMo1Cv70g5UMQe8b9A5acgzYPfE7bqls9E=;
 b=rVHzZIAyTBwPCfK66Hbe9XMeJK7HDjV25lrtlra8+ygkxUZlXQCWYMeUT/Y0JNoQOWFX56PVSE1QzIs5jox/VaO3umf5IdVJ2zS54pDFULFix5sEYqakwvJlNKeJAC/kVj3tcbn/cMN0Dshmi3+Zfdrko85Tv402l281375eoZs=
Received: from BN7PR06CA0069.namprd06.prod.outlook.com (2603:10b6:408:34::46)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 23 May
 2025 07:23:29 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::db) by BN7PR06CA0069.outlook.office365.com
 (2603:10b6:408:34::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Fri,
 23 May 2025 07:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 07:23:29 +0000
Received: from [10.252.206.76] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 May
 2025 02:23:22 -0500
Message-ID: <2c52daad-0b64-48a9-8e73-d1aba977993b@amd.com>
Date: Fri, 23 May 2025 12:53:19 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add a KVM_IRQFD test to verify
 uniqueness requirements
To: Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Juergen Gross
	<jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, K Prateek Nayak <kprateek.nayak@amd.com>, "David
 Matlack" <dmatlack@google.com>
References: <20250522235223.3178519-1-seanjc@google.com>
 <20250522235223.3178519-14-seanjc@google.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250522235223.3178519-14-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cdb81f-cf79-4bc0-f097-08dd99cab76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVZLVE8xang3VndRdm9OanJ6a2pUS1QwMUVHVFJwTkhjRWhDWnlzMWVJVnlI?=
 =?utf-8?B?WXBHSklxbzEweFlvY3plNkMySFV2N3E5K25kbENoRnRkRXkrVmF6RHF1ODNU?=
 =?utf-8?B?S1pOMnVhOElpNkQ5dFFra011aEFtUTE0dmJIa1piNEE0NmdDeUZEejdrZjA3?=
 =?utf-8?B?U05YZFdRaXE1TEtBN3EyZEJVWUdEOUMzOVoyRGdpaUlTdGF2YXhTUU9KUTl3?=
 =?utf-8?B?cVlxaXpkajVxVlBLb0tTZGNaeS9qWlNFcXlPbnRUUUtLUVF4SFI4N0pIR0sz?=
 =?utf-8?B?Wlp2MHhBRG5RaVNzVmhKeDhEV3Z5M0FPNjkwZk5ZN210M2ljMlhNMWxDWldr?=
 =?utf-8?B?T3psVy9rNUcraEtlK1N6dUozUjR4a3ZCcU5OTFpCZk5GT3MrL3d6aUZwNHpH?=
 =?utf-8?B?eEswZXFvTk0ySVd6dWlPZ0ZwNmIyaUh0QTBFaTM4Q0dZU0hFNmtIMmc2clJ0?=
 =?utf-8?B?bEREZUI1N1EyS3JzTkRnWDVQOUQ0aE93OENsbHliaUloN0cwSUVPTTc2OGpF?=
 =?utf-8?B?WUdMcmtHTGtiK05DYklaZ3JGcWtmTzFBMnhSdDhKTEhscHBvQ3JVWncxb0li?=
 =?utf-8?B?c2dZRGJ5M1g0Ym85TXhzVTlJREhaWldvR3ZraElmYnpTSkxzRDhJZ2t2amZ1?=
 =?utf-8?B?bS9DcEE3YWtBcTBMem1UNUpFeDNuYml4WjJRdGlTSDk1dlVDdllvZkxyd0dM?=
 =?utf-8?B?RWNEWkc0UTJWZ0tQa01aUlV3dUt2cDNxMVZZREN1WFVhdTV2VmlEUjA3c3J1?=
 =?utf-8?B?M2xxWFFNVGE4K00xQXRaUUhQSkpXK1FzQm5nVGY0aHdZcUIydFlBa1R1ZlJM?=
 =?utf-8?B?UGlPbWlnR2M5WEtPOFpZeXc0Z0tPYzJxTEF4bUtYWEhaN2JWV25ocks3SERH?=
 =?utf-8?B?cStsTlRSSnpoYkxRRnQzcHdwa1Z3amhyV3N3dGhweWlVQ1ByUjFVTUkxYjRQ?=
 =?utf-8?B?eEx0UW9PYW9VTFcva2JLcXk2dnJRd0tCb0djVHVhTHpJdkp3cVE2N1RoUnQv?=
 =?utf-8?B?dFFDTy9wUHYrZ1Z6RW9hdGMwbE9XZFhmTUZtQUNTOVF5TWJwTm9LQmVwUk1Y?=
 =?utf-8?B?ZWV6UWdlMGtkWFdSSUMrb2FYYWJlZDV3TUxnWkhuR21DU1MyMGJldEJ3K0I5?=
 =?utf-8?B?VS95WVVudjcxUi96NFhCR0FDQ3Z2bGswUEd4SWhGcGM2Z1BWK24rend6ODBk?=
 =?utf-8?B?MkM1YlVIdzk5Um5KaTM4QVFsMkZEVUk4d0ZTWUNsY1pDVzlVTDNLSmJIZ0FD?=
 =?utf-8?B?dUI0alN1aU5ieTUrTGFlL0FIUXJ1VFZXc1hkYkZNOTJYWHRMdk1vZ0FpajVs?=
 =?utf-8?B?L1dZU2JvZW1CNUVkaS8yWUhTWmVVNHNRVVpnbkt3bC9hb3NYbUNmQWovZU91?=
 =?utf-8?B?V0k3bERlRksxcHcyU3d6ZklqTjUyWWFXOTAxOW5DMTBOU2NGNkxUa2prTFhN?=
 =?utf-8?B?blFHbWNyOHVKVHZqczlQdTFaWUNxQ3BVUFAzazlreUJOeGlCN0xacTIzY3dD?=
 =?utf-8?B?NDlydEZuZjhMajltRkx4dnNqb1RZbVJkRlAxMFJHN0hEWTlXYlJ1RmhWVmlW?=
 =?utf-8?B?d0ZOaEJXbVFHM3hjYmJOdVZUaWQvN1ovN2N1M2RUanNBQWc3c0ViYTBza3FH?=
 =?utf-8?B?WDNrZHNPbytRSmRDaGNuNVFOQzdJdDJMWm9lM0xiRS9oZXEreU5FRHZiWjl4?=
 =?utf-8?B?TmRQQXJkZkl3NkswTlNmVHA3cXFsdVNyazc0VzdVZ0Z3Y1ZDMFU0NjZHdG1D?=
 =?utf-8?B?YTZJTzJxa1dFaDB1UkJtNk1LTkxqZnJDWFdhZ1hHakYrMkN2UnlnQlNvaDVt?=
 =?utf-8?B?cmxwMUljdlYvbk55S3NmaWlDUW9ac3lBMkM0ZEZqWEJPUmJyTXkwRGUwMlZG?=
 =?utf-8?B?aTI1RFVOUUlETmI5eEt4QW1ieHFNcGI1cEx6czZ6TVpNUWMraFJqdDNvL0tp?=
 =?utf-8?B?emJHSDZYb0ZxR2NtSXNCbXNBZVhLR0RzaXJNa3UreEcxSWJwMENqamQrY243?=
 =?utf-8?B?Mi9VdVR6SjhRUnI2cmRsMU9MRXRreGJGaFAzRFljL2xITktoUXQrcVNqWXZ1?=
 =?utf-8?B?NUppWWpxWVRPdXRQcWxJY2YyRUt1cytBVEpjZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 07:23:29.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cdb81f-cf79-4bc0-f097-08dd99cab76c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532

On 5/23/2025 5:22 AM, Sean Christopherson wrote:

> +
> +int main(int argc, char *argv[])
> +{
> +	pthread_t racing_thread;
> +	int r, i;
> +
> +	/* Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. */
> +	vm1 = vm_create(1);
> +	vm2 = vm_create(1);
> +
> +	WRITE_ONCE(__eventfd, kvm_new_eventfd());
> +
> +	kvm_irqfd(vm1, 10, __eventfd, 0);
> +
> +	r = __kvm_irqfd(vm1, 11, __eventfd, 0);
> +	TEST_ASSERT(r && errno == EBUSY,
> +		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
> +
> +	r = __kvm_irqfd(vm2, 12, __eventfd, 0);
> +	TEST_ASSERT(r && errno == EBUSY,
> +		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
> +
> +	kvm_irqfd(vm1, 11, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
> +	kvm_irqfd(vm1, 12, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
> +	kvm_irqfd(vm1, 13, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
> +	kvm_irqfd(vm1, 14, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);

Hi Sean,
I dont see any allocation for the GSI 13 and 14..
Is there any reason for the deassigning these two GSIs ?

Regards
Sairaj Kodilkar

> +	kvm_irqfd(vm1, 10, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
> +
> +	close(__eventfd);
> +
> +	pthread_create(&racing_thread, NULL, secondary_irqfd_juggler, vm2);
> +
> +	for (i = 0; i < 10000; i++) {
> +		WRITE_ONCE(__eventfd, kvm_new_eventfd());
> +
> +		juggle_eventfd_primary(vm1, __eventfd);
> +		juggle_eventfd_primary(vm2, __eventfd);
> +		close(__eventfd);
> +	}
> +
> +	WRITE_ONCE(done, true);
> +	pthread_join(racing_thread, NULL);
> +}


