Return-Path: <linux-kselftest+bounces-16184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9095D7CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 22:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DD8B24033
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558A5192D67;
	Fri, 23 Aug 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLpdux1j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A8D192B6B;
	Fri, 23 Aug 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444631; cv=fail; b=uRN9HYMpQ2zn/aeQvdw7nP68g4LfRvNV1EsJV6pGDbmkrtRF/Mkfq5kLm7guIqlLo+WYAcCDmxLAmgdBqRrrK1vDclbOwRmHP2XmAzfHsyrM94BLEgVEcapwhpjbCpvUcXqVjA4BClt37c7Pq9IMk5tynW9HYh54LBr0eSBhxfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444631; c=relaxed/simple;
	bh=igEwogGOw2nxPSx29/n+mVn0owzkYMupoHcZvybBccc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=KDkzt9y42snx8GigbxeeymQ0gnnp9FDZ6xQggDB0QDNXaAajjbDeKGyPjjhPn+neFFrv05Ywuty7Qf92b3/8sqedCfuOmdWFPtwuGSfQaLWzbwsvSJ0F+8spYntcXUMJSR5Vad5th/XTj6Q9JgpMNQgP1mApbg06oxWW2yWreT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLpdux1j; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJg5pGVvZNmH+KNXzNDlbUUUPy49mMiRVyNXi2Oqb3rHBenIg0X/8kAWPL9KkJPZuxj22J64jAWDXZ69GF/IQdbkUYHS7EjbYX1S6L6huRcOOd9AvpByjcrkKX4cHLZh75REHf7sGzcMWQyX0fCGZba+nzqW5xbXWLqJXK/rw0gYR8N3nJaGs4gBcMWFQUydZaV1/rhD+dNkYR1VYYQym1YdIXhveBDVwutRfiw8gOeXtSXj306KDXRKBUu/l/ZeJGQxwkSD89p7qtPHr2tto9FZovnu7m3X4EHC0VWiRsiHY1+l5U9hCeCU5gZMyeON+vE269Xt0JXqMEy/9ajr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/O0Fh7PI2+TWFnRJXdk1LUQpNB7pe9ldt6jS02V46A=;
 b=K0msx16kOh2cU8aP/4t+NGpWCCLCOuxpO4CMhwULobh1MF9CYL639cbPD88g9siIqTXJaBOgEIvK2Z5XJfzNaxTD2pX4iItmfVnbfnRWsMymxgaCX735KVJs7LTVQ9ZydFL+f9BM+7PSCZDTxHl6UqFhhBtPRtyKDltYwq8meQ+NfNBdLD4Tbh7mXjjzXiqSUyekaROkUWLY/c+Bus45Dm1SRoL3GpEjKhVEczVvuk6hDDo0KeDTZhtsnfH9P9ChbOQRCSQqgdCmBc+L+hsKBrbeZun8Mscp9SbhsT5vWPVIqJFT0qk3FCDrcbHrs7EzaX+n1OL2ZX8YbIkrvnOMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/O0Fh7PI2+TWFnRJXdk1LUQpNB7pe9ldt6jS02V46A=;
 b=lLpdux1jmL30VAM4BG1Z2mR5K2donB2i/7iWl+Fm/uyQbdqDBRTHTi2uhsL7hroiicbLW3tTvqnC50FfqMGAj6q8+pJ3Lkdi8B+IZbv3qpliQfXJJlG2dVtBIxGpihLfRo4Mi7rkRVZQLWDkRoTJh8Au7OVuttuAuQe6MSZ3Mk4=
Received: from MW4PR03CA0328.namprd03.prod.outlook.com (2603:10b6:303:dd::33)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 20:23:43 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::28) by MW4PR03CA0328.outlook.office365.com
 (2603:10b6:303:dd::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 20:23:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 20:23:43 +0000
Received: from [10.236.31.51] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 15:23:42 -0500
Message-ID: <607e76c0-6e9a-4961-873b-0b952b51faff@amd.com>
Date: Fri, 23 Aug 2024 15:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] KVM: selftests: Add a CoCo-specific test for
 KVM_PRE_FAULT_MEMORY
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
To: <kvm@vger.kernel.org>
CC: <seanjc@google.com>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
 <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
Content-Language: en-US
In-Reply-To: <20240816192310.117456-9-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcc614d-8da3-4f84-56aa-08dcc3b17bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXJCS1B1UnpBVklaSFBtekt1K1dhSHRHRXJuV0JOMnF5bUdyaFBXMkF6azhi?=
 =?utf-8?B?TUhLaWp6bnR2cHJTSTg2bURvZFArRDRjM25OWC9CcjVPdFNlMjVCcjRGOFNR?=
 =?utf-8?B?VVh1ai81NlNobVVsaDVhMkNaWThOYmhYZlZMZDBIcW12NnhnWUtGNlFoeGhy?=
 =?utf-8?B?MXdMTURpZkp6UHNKMGN0MExLSk14T25NdGNaL3UydHpmS0M3MGNKdnh5aG1r?=
 =?utf-8?B?dE13d3BFMzZKNUc5SlhOd2xZdU9IUlFodDQySHRQbVkrWHhuQ2tWYzBLUVd6?=
 =?utf-8?B?a29mKzVCcWF1bG5LVmVLK3o5emZjYTdGSFlGdVhMNms4QnBWN2ZoQjZBT1Ba?=
 =?utf-8?B?b01raksvck1OQlY4SzZBWElLMFB1SUZXNW1NbmNEbmV1dHl2TlhsQkd0MlJX?=
 =?utf-8?B?di9hTzdSYktGcGo4eUxMS2dGUjAvaTdHcW5wRmtRbUY3djZZdXBIUFI2T3ha?=
 =?utf-8?B?cDFtdjF6MzhrN1RQbmVlNmdMYk9XaXQ3aXRaNVVrejdUc0p1cSt1dWtXYW4y?=
 =?utf-8?B?ekRnODFoZVF2WWsxT1k1VDhUNDM0L1NlaGloSTVpRHZNQkV3V3IvL0pSTlRX?=
 =?utf-8?B?R2VUTGJCNlBIckJ6L1BSakxsTjkwQmFzUEF4WTRYTGJTb2o3eEFBVldxVkVy?=
 =?utf-8?B?R1laYmw3YjNxN2UrcHZVL3V6NDk5YjZxdkx4QmFKUEVUd2FSd0VySnlWcDVV?=
 =?utf-8?B?S2xFV3BxQWNXUUxCNnIyKzB3cFZoeDFTZDRlSXlGYmplY1pRaEJBUTM1OGEv?=
 =?utf-8?B?SmhGTlZlSmltRWJtNlY0cFpJVFVrY2xCMXJvODA2MVVib09RSElDTXpGL3l2?=
 =?utf-8?B?N25Ndi9UdDlrRy8vZ29kZTE3VlBMN0dvYnppRnc0UmVOV01SVjJTYi93R2Ux?=
 =?utf-8?B?MFJoYnVCMDNCdGZJZTFrVGY1OEppTlRwNHdQa2p3U09QTWpjdmdDUWNwQUhy?=
 =?utf-8?B?RTJzTlBZYnZSMnZmRk4vbDBXY3BlN2ovUjVvVlRIWGhUZ1lwLzF5dkhaT2ta?=
 =?utf-8?B?UTdSeUUyMERaOVRYU3JpczZSNHdxbHptYklqUGo3U0NoOTZOTlgzYVNqVVpV?=
 =?utf-8?B?TVFMNU9KcHIvNEhDT2p1azk0YkZHTFRvTXFNUjU5WE1UOWpXMXZNdWVYeVh5?=
 =?utf-8?B?MG50c08zeWlob3dHR1hPdFEzQ1NDVDNwT3VvRk1PdjUxN3J0OWFCZUxtTjBN?=
 =?utf-8?B?dzF6L2RZNzlqTUVSdG1Od0lKV0IvRzkrcjN5M2k2RGFTVE9iZ1Q3WkpMNGF0?=
 =?utf-8?B?RE5DWTNqNTdFZGNXY1BYcU9sODZYZXpnNWhyYmVtWmNkUmdYS1habGdiUFVS?=
 =?utf-8?B?Vlg2MVk2UGxLZWIyOFVCempkaVllNkxrWmN3c3k1cnVleDhmaTZrRVo1UEJT?=
 =?utf-8?B?OEh1MXZWak5aRS9rTzByQ2RBbE5vaFRTWnQ5dFV1cFdCRlRKcEp4Qit3ZXll?=
 =?utf-8?B?Q2UvYXhaMlNSRjFsWGxsbEJQeXZlakpDbzRhczJ1cTQ1QmNYaW96bUlPMjNX?=
 =?utf-8?B?U2JuQ3BxN3N2N3hBeThlQUNzR3BVWWdWL3UxUjdVSVNRMkIrc2hJTjlnaG9J?=
 =?utf-8?B?MFdWUStuTkRZeTlQTGhHQzZTemU2QktveTR4dmNFTGdmYllmMnVuU0FrK3Bj?=
 =?utf-8?B?b25ybTRzWlh1YU1ML2hEZ1VTa0VRK1I0dXZqcHdNVlp3T0xZZEtjMHgxU2Fw?=
 =?utf-8?B?eTNxUzlFdEh1V1hwRFBvUnZYZ2ZZYXJhTUxST004YjVscGx6ZG03ZHZGRDhi?=
 =?utf-8?B?V3V0bWxtbGtEY1V5ZllmM25keWVmMXpRdWdPQzI2cDk5S0FwTUVyd1FoY0p5?=
 =?utf-8?B?RHROdUJWYnFSTjlPV3VPTWp6NGxzaTNMVzFyTUFQN2lZRlBNRzJYT1NoWU9a?=
 =?utf-8?B?Y2dlb1d2LzdhUUg3eWZrUm9xZ1ZpeEE1Qyswc0lRUnZGTWlZNFNCQW40QXdi?=
 =?utf-8?Q?JWhAyQoOiwhgP95V4m/aV4oQimnW6R0q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:23:43.2946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcc614d-8da3-4f84-56aa-08dcc3b17bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364



On 8/16/2024 2:23 PM, Pratik R. Sampat wrote:
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
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/x86_64/coco_pre_fault_memory_test.c   | 314 ++++++++++++++++++
>  2 files changed, 315 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/coco_pre_fault_memory_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 48d32c5aa3eb..65d19b277b06 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -129,6 +129,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/amx_test
>  TEST_GEN_PROGS_x86_64 += x86_64/max_vcpuid_cap_test
>  TEST_GEN_PROGS_x86_64 += x86_64/triple_fault_event_test
>  TEST_GEN_PROGS_x86_64 += x86_64/recalc_apic_map_test
> +TEST_GEN_PROGS_x86_64 += x86_64/coco_pre_fault_memory_test
>  TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
>  TEST_GEN_PROGS_x86_64 += demand_paging_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
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

Just spotted that I have initialized both NO_PREFAULT_TYPE and
PREFAULT_SHARED_BEFORE_FINALIZING to 0, effectively running the latter
test type twice. I will fix in the next iteration that I post.

Thanks!
Pratik

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


