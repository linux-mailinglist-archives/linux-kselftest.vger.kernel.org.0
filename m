Return-Path: <linux-kselftest+bounces-44962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD39C3AEB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566881A466EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB98A31D382;
	Thu,  6 Nov 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="egDMC77C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A375695;
	Thu,  6 Nov 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433018; cv=fail; b=uI2ef9bqfLkwLhEUXYkcvoS2i+Wgg1cQw6HgY7Xg1HjdDJaTQLtaCWYsLRMd49hLfN6DY4b68NvuD3zAYSiJX+qiAuALVaV3HdkDIJxhUY7w7HIN6MkD1unnLPaSTte5GRmhfq7Rph+1wrqoPYljwdNG0HebI5lqeQ3CknN9Vog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433018; c=relaxed/simple;
	bh=k+1odOBQl+kJL9k95lI/qEYRzJKKwOOovbyaCGEonDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPIEISYbd0S7rlA+/VObwJ4v6CYY9l3zbTlIjbFEzjHsJmjfRRZGAQsUL2V2i0rEXY9JyeilyVe1NhzhOiRZhvoLV+PvPr6JlnkPX1g1PXIEziYh252NIVKXh9cNT5E8ysLaGdtYzlGcDxqOURAYMy/whp66EIBJeBXZKn07rVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=egDMC77C; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYd823quS56tcIJVJB/qVz2NO752/wWJYJ9HX8GMpT1mCiRut9LPnwFSsxGhA93PWWUzB2S6Sao+ACLeUSGv97ZIEjUhrY2zQy1KBKlAtxVBivDJWEoT5nchVQC8hUe8HhvEUnK/TKCDaIkLwoyuo7aWvocbZEeeCCDCpVSmSJLlVxavqW6fd8a1g0Ysy1kz47cWX667JDZ8iBG9ywowSK45XC07S9waqMNGp/K//fFGq7SftSo5XoKFrV6JNUehcaI66UhP8eOwY+bb0wEGFflcZm8c0WvWUR/uV4xlIlH3GZ0rNnxcEVFTCfzp0ShBF9jCKNmVxOHGzcm3HsbV7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhs4+8dcbkMAZTBfzvawWLtLzaXRFwQ3evVG0RTFMz0=;
 b=QqX4TgJMnBq/APyvySsMH+xpNaTdF0ErQX04ADrvmarZ9A4mcnTmiVmNRN6RGhDsT+BSVPy9qrvCx1rJuIxbxW5LVzQia9vMCVnGzbN0Frg3w+JbxLuYFyiW/x0Ch4wEMp7v4VkRrt8C7c6GVTys/rUUBV3QhoIqzCXiGI36qJyvAeatCIcG5ryEnB24FW2rDUXBi3tE91MJ+mbNS+aKYEl1m7WCR6pVZgNGy1kxQ54ep8GOYlw6DiHbyRB3Q+SxgLJ4vdZSvLS8XRGbvaS0p0YDC45Vs5pB399FWKIDIpBqu+Jt8UO3Xl5Kh+IF+MLQp59GIkiX/OElE+B1syJi0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhs4+8dcbkMAZTBfzvawWLtLzaXRFwQ3evVG0RTFMz0=;
 b=egDMC77CxUlUHvYrbiIdYLawG3LjRA+wYdJ7kMYN/8DYyPekGfpAjH/akJSI258AIdNQ6jOPOhoao93DGZiQeq0Oa8oM528wsn54fPucEMDqgXsX27wDb+jMdaUDZTjQCQdR7K3GWznwoockBnB0A4BcNcIgqtNfMcxzf8kcUHw=
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:43:30 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::dc) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 12:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Thu, 6 Nov 2025 12:43:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 04:43:29 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 04:43:29 -0800
Received: from [172.31.39.154] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 04:43:18 -0800
Message-ID: <977b68ad-6796-4c3d-9c34-d023597f8ab2@amd.com>
Date: Thu, 6 Nov 2025 18:13:11 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/35] vdso/datastore: Allocate data pages dynamically
To: Heiko Carstens <hca@linux.ibm.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
	<thomas.weissschuh@linutronix.de>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, Nick Alcock <nick.alcock@oracle.com>, John Stultz
	<jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, "John Paul Adrian
 Glaubitz" <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Huacai
 Chen" <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, "Thomas
 Bogendoerfer" <tsbogend@alpha.franken.de>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>, Shannon Nelson
	<sln@onemain.com>, <linux-kernel@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
 <20251105153426.16228C13-hca@linux.ibm.com>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20251105153426.16228C13-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: d2eee96c-9b85-46e0-9f63-08de1d3216d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2s3YWdLZTI3SUZFRHhyZkdPUmlCSFlndkFaZ1YwQ3NmNlFFRmdMaEhvMDht?=
 =?utf-8?B?YTNrekZOeWk2anYxcWt6Umk5S1MwNlJjaU54ZDNxaCsxT1FVSkFmSlNSa2hJ?=
 =?utf-8?B?N0tRcVNRZndKWnpNcmtCUWZvbWkzTzhJUkFBN1ZSeTY5cWpWaUVxeW9rMFAy?=
 =?utf-8?B?aXlINHlRc0gzRjF1bEloNTR5SlNjd1BQMWt6VTZ5VlRLVmxIbHZMWHZoanVQ?=
 =?utf-8?B?S3FCaU52djljQlFMVTlYWTZTTFNZNDNCbzB4TEQ0alZrM1FjOFF6Y1d1WlJx?=
 =?utf-8?B?YlF6cCtHcmExRHdGNkxSL0p0SXhNUjR0VTYxUjJ6aGUwNzBCckMzcnNPVkFr?=
 =?utf-8?B?QUNSZWpSbUR3V240R2dEQThYdjkrV2ZYb0I2d1ZqT2wwSmFJRUw1VmplUGlM?=
 =?utf-8?B?TGNVVmY3bS9VTEo5MnNoM3kxci8vWkE1RmhJZm9JY0tqa2k0YU5GTUtvdVN4?=
 =?utf-8?B?UE96b0hTTmNRZTdISGc3OEhFdkZrSmdmM1pERkJqa0oyVHp1KzI4ckUwQUJp?=
 =?utf-8?B?Vy85U0pOcEF3RFVpcFFHQWo2U1U1aWRScWRMRWQ0VEI2ZGtLMmtVVWd5dG01?=
 =?utf-8?B?bEZRS1l6SUwyV09KbG5neDJYd290a1I3aER1am1aQ211SW9OVldmM0lNM3pq?=
 =?utf-8?B?ZnZQWVh3T3o2Y3FZRnhGQTZ2YU9hUnAzNCtkUlBiR3IwcXFKN3ZqTGdLdytL?=
 =?utf-8?B?ZHdDdFdkQ1dNcUlrVEdtY0l4bDdQK1ZaK0t4T1lWTG5kKzlSc0ZDRmoyb3RZ?=
 =?utf-8?B?bDBRTEF4OU5NSlBlV08rajkzbnRpUXpiRmxwakRobi9PL1JBbGJaVndxVnox?=
 =?utf-8?B?WHRDMVd4Q2cwek0rNzNwRjV6RW0rSTAxZEQ4emZwQmVYSTdPdzhELzJIdDhq?=
 =?utf-8?B?ZGVsdXQ3T0QzdWZDN3VSbHIrSmdyOENLSHR6azVncG9mOHN3NndSS3NCMHBT?=
 =?utf-8?B?VzMrSjVjb0ZFQ0tMbUZucEpnTzhHL1RUdGhZUFpMQ05SbnJDZ0I4NUZzdXR0?=
 =?utf-8?B?YlhQRWxQSkg0ZHgveVNPamkxSkE3Q0hJUVc0ejJpQ21tK3FMSGZzemFDS1Uz?=
 =?utf-8?B?L21haEROYXdnaWI1QTd4Rk1lQ1gvSEhEMENMWmpZV3d1NU9EYmVKU1VhVkFS?=
 =?utf-8?B?cERzWXVuQmdaVmFJNHZudUJEdERPU2FUK3BwUTlnbG0vTjFqT2hoejRXMUpE?=
 =?utf-8?B?cHpSOWk5RGUzR3hrYnZJZVpYekZ0YytFNWFGSktxYk9PM2ZsOUVRSnk1RXMr?=
 =?utf-8?B?MURKdm9kanhxbnVabHlzS3BHMEYzSC9XaDRqelJoOUp2TXhhOTBYNlNwYXEz?=
 =?utf-8?B?UVNxWkJLSjl5UU1nY0w1RjBVbTMrNkM0bHJheE9Hcnp2c045d2xkNHNGeE8v?=
 =?utf-8?B?RmVsT2VXeGQwTGd1bGpydWFDWDA2V0gwY2hFV1RzZ1kxL05rdzBhQXdJY29U?=
 =?utf-8?B?TTNzNHpUOWlQOU1yLzlKZEt4ZkVBclZHeEZvSUEvNjBab3FUbkMvMWRjeHFZ?=
 =?utf-8?B?cG52bW4ySGFrVHpPdDFIK1Fxc3Z0QlZWRUhCa1I4a29JWnFPbHV5MHg3Uk5X?=
 =?utf-8?B?UGZESHJaQ0xhZ2pDSURSS2NKZDF5TEZ4VzNtenN1Z2J6R0xPcG9JR21qOVNX?=
 =?utf-8?B?c1NIeGp2K3pUQU9Jd0tLMEdLWC9GTTNvSW1TeStEOVlrdURVOEtnc09DUkVV?=
 =?utf-8?B?TmdOTnZzZTZWSXBLZUp1ajFJQSttWHA3SC9LMTFEZDhtYzNraEpEcUZLZnlR?=
 =?utf-8?B?cGJ0ajN0WGhIL2Q1QzVsUW11UHpjeTg1a1VrTjJ4aU5FaisrZ29BQkdoM1l3?=
 =?utf-8?B?UUdpclkwcmV2RVNYYkVweGtCZXRTVUJZUHR3N3lyL01hSFV6dy9DM3NPZ3RR?=
 =?utf-8?B?V21yaGI2bGE1Q3FVMGJGN0pkaWVyK1JnOElzRGZnbGhySmdoVEozeGY0UW9Z?=
 =?utf-8?B?OWkrQ1lSVFhGRHFsbXNJT1JMNklseHBBbUEvQm56OStSQm95OTVrb3FvekpH?=
 =?utf-8?B?bGhOWHFkd0c3QzVObUdGbld1alZPVmpNYVdBRzdXMUhKK1lWeGZBZDNtRnFN?=
 =?utf-8?B?Mm55UzcxVEE0S0hiUXgzNEdRK1F1Um12M3BMdHFVUlVsT3ZpQUtQT0ZFVnRG?=
 =?utf-8?Q?gUrU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:43:30.0259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2eee96c-9b85-46e0-9f63-08de1d3216d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

On 11/5/2025 9:04 PM, Heiko Carstens wrote:
> On Tue, Oct 14, 2025 at 08:49:10AM +0200, Thomas Weißschuh wrote:
>> Allocating the datapages as part of the kernel image does not work on
>> SPARC. It is also problematic with regards to dcache aliasing as there is
>> no guarantee that the virtual addresses used by the kernel are compatible
>> with those used by userspace.
>>
>> Allocate the data pages through the page allocator instead.
>> Unused pages in the vDSO VMA are still allocated to keep the virtual
>> addresses aligned.
>>
>> These pages are used by both the timekeeping, random pool and architecture
>> initialization code. Introduce a new early initialization step, to make
>> sure they are available when needed.
>>
>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> Tested-by: Andreas Larsson <andreas@gaisler.com>
>> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
>> ---
>>   include/linux/vdso_datastore.h |  6 ++++++
>>   init/main.c                    |  2 ++
>>   lib/vdso/datastore.c           | 44 ++++++++++++++++++++++--------------------
>>   3 files changed, 31 insertions(+), 21 deletions(-)
> 
> ...
> 
>> +void __init vdso_setup_data_pages(void)
>> +{
>> +	unsigned int order = get_order(VDSO_NR_PAGES * PAGE_SIZE);
>> +	struct folio *folio = folio_alloc(GFP_KERNEL, order);
> 
> I'm seeing random hangs on s390 too with our CI, but unfortunately I cannot
> reproduce it manually. But looking at one of the dumps it looks to me like the
> vdso time page contains (more or less) random junk at the end. Or in other
> words, shouldn't this be:
> 
> 	struct folio *folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, order);
> 
> ? At least that is a difference to before as far as I can tell.

I was also hitting random hangs with an x86 KVM guest boot on an AMD64 
platform. The bisection landed on this commit as the culprit.
I see that v5 has been posted. I am in the process of testing that 
version and will reply to the v5 thread with the results.

Thank you
Srikanth Aithal <sraithal@amd.com>

