Return-Path: <linux-kselftest+bounces-20311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4B9A9114
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2CF51C21E77
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C81FE10B;
	Mon, 21 Oct 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I3bekNpA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC721FE0FE;
	Mon, 21 Oct 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542248; cv=fail; b=j8PR6s9IZ5QPymfD1y5g0fFGUHZB7cJSgI92f2CM3uf8TSqkenPcS9sud06gKkcW9fJ9EC07fZ98EgZALb6WktRXMasuqyJpfNSW2/8+4yknVtwzhR481SnE9guodJ6/PzBxyxDpuy5Lpn3d3xXN+uVRhu+YQ2cJC5hL+f7/tk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542248; c=relaxed/simple;
	bh=1jrdzJjbJD7pai/lWLfo6GpyPqKzKbTFoa/Qmf5LZ8w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=M/D+E2Shw6RyaLZvIRxvlSFxUED8IlwpdveHosSpCnQsaEr7kbSV0qPSIp2w72AAl/WoYJcur3beFlJ5miy3H2x0LiT9yHUilpkUjnDkgVwtmFo6B8fgt3lqnsqmQa/fudCwQIPAPMQSSlmYARm7TzIA8M5z0U+qgMCKWeEUBiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I3bekNpA; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6YFrL3sxc+GQJHD1KhnsnCOCWwIP39yPD0dHCWbLe0MCeh6dGWSZHog/vazFPC7Aj3DvAOqBIn+bauktBJ1Iy7YvoyskBgaxibeSRRFlhkxdy/3idKH7nv8UT24s/oZOMmIBmD+hnDQ1poG0EhFFtUqAlf39xROG1u18hk+ztT1vcHcYf51ihKbk3yk1hkXpb0MybP4ARjnkvUE4ntdAE93iJv7t24aK8AvoIZ+5dSpa/z/339pEIxF8SV0F4i/xQTdAjMtX7UdTzhKS0D7xzTtmwYnyeJWpE73R/afB/1DHnuvUAI75KPTAQRCtUZVeSLvFPSOeZ21KYlxIoZJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkqTk4lbJPcv7rcOnDTtiTUguYlf+38EB4HzPQ2RqGY=;
 b=mYPisEaMQBZ1QFttCJrTzLQzp2WrMKOqLRYo7DdZrSIjyfIvNayhDZ0IS3XyXOe27J/UZosUEZx7vrlYfByh72zcFyBGp9GEx9cOKu9Ys0BjiF5nRmz+Sy+ovLXnO/qfbzTjlwTLMzWeU15QIM11jmwclYqe7SkaIKcDUqaQAJ08eXErF6hd7FnNnXAoFPTY4MI73KclgiqpCH64YUcv/nUm1YqPWhX7APeREP1bLraC6tFfdI9YbPaLhXP7gNnmQ6IYUGeWWy4rDipcRyXPDhmZCprbuDPKGEg56hP82c/c2T7ZHQByeSPZlc4EZNY6n1tLQZHYhFlpF02M/WSoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkqTk4lbJPcv7rcOnDTtiTUguYlf+38EB4HzPQ2RqGY=;
 b=I3bekNpAFyoFPBMqjbDXcRvd3HyUmoXOPw8z5Ujg7cdCshKWVC5++LhDEbrNXE7SkLZ1Hank7D1N9yKI2tOP1G/LSN/xdwblzRFV1Kmwfny31QkFo7e8YdK2hTyleGxLsfXqeVmw00Gi+qSNVUywS1Sel3KGXIg/x6d9x1Wt1VE=
Received: from SJ0PR05CA0172.namprd05.prod.outlook.com (2603:10b6:a03:339::27)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:24:04 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::50) by SJ0PR05CA0172.outlook.office365.com
 (2603:10b6:a03:339::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 20:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 20:24:03 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 15:24:00 -0500
Message-ID: <87115c3a-4e8b-4cad-901a-07c7f4f77ac9@amd.com>
Date: Mon, 21 Oct 2024 15:23:55 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Subject: Re: [PATCH v3 0/9] SEV Kernel Selftests
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <Zw2Z3WUYjOZ1rP59@google.com>
Content-Language: en-US
In-Reply-To: <Zw2Z3WUYjOZ1rP59@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aba8a99-6e3c-47ac-9bea-08dcf20e4e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0tpaVRmZDhkSFNLZi9mNlVPa1ZIU0g3czNvWFFnemZVa2NsK0M5blowbVgv?=
 =?utf-8?B?bTVPUFRsSXJoVFREY0VqSGQ0dTdFaTFLaTBGQ3Z4VGxxQndLRExDQU9pc2ZQ?=
 =?utf-8?B?RS9oU0J6RzRMYzRLQlFwelNUQ0JYOWMzUVRnMkNwelkyMHF5dU5IWS93TVJa?=
 =?utf-8?B?YXZ5SWpIbm44R2F1LzQxY3hHUUZOWC91eXdCcHI1dmJkbm52Q2VmWmk1eVAw?=
 =?utf-8?B?c0V5MGthUXNiL21ramtqRWpYdWpvUzEyb3VoQUZIRGFFV01sUVJJVEZPdlhD?=
 =?utf-8?B?d20raXhVRS9vOGRqck1uNnlyakJZT2ViM2ExV09NY2oyVW5MNXZOWWt3dGYz?=
 =?utf-8?B?UFJnam5LVGpYU1dhMUJTWFFwQWZ6a05kUlQvQmJyWStNTzU1UUZvejM4dDJU?=
 =?utf-8?B?amhPZURhZjF3aXE4M21icEhDYkthVEhTTW10OUpyWTRTY1ZKa2tlUjAzYUpw?=
 =?utf-8?B?R2grWWFCUlFiR0I4L2trb3FieUE1eDZObE5nTkd2aG1zZlRvNlREUXJuMTR6?=
 =?utf-8?B?QzBnR01mamRWTGZBN0ZGWVI4Q2czTXpDZDNHOFFIbXE5VERzZmhjbnV6UDk1?=
 =?utf-8?B?Yi9EM0JVNCtkMm54a3VjZzlXay9BZlVYTkNzZUpTR3RGUjU3ZFcxd2Jkc25Q?=
 =?utf-8?B?YUcrUVNZYTJhN1RrWkZNckVoa3pZSW5rbVpVMjNZYko0c3lQZVhNN3ZHbUxJ?=
 =?utf-8?B?dktEQjMreXhaYytUWmlTTTdRK2xMWDVFV2ZzZzBrQlhPMEJraHJFTjZneWtL?=
 =?utf-8?B?WCtEZ0hjOEFPMURJREFBOCt5ZDFxSzFKMStqWS9rYUo5ZlR2eFEwZjVGZ3V3?=
 =?utf-8?B?UnR6YlVPUTJWY2I2ajMrdGJ1Ui85VFdack9zVHltbmlndk9NU3NjbVRic3Rp?=
 =?utf-8?B?bVErM01oaUNXZVAyZnVJeWdwblZjSG45a25xRHl3aTk4OHBlbDhhT3hkQWh3?=
 =?utf-8?B?WHkwNkRoUEJsa2lJMmc2V1JUT1JLRTl6UTQ2SWx1U0hBNmJlUGJnZXE4N21U?=
 =?utf-8?B?Nk5IaDJZbW1ud2owRTFLbTZ2NkpxUndSc0VaVHNWNW5hQ3FyZXFhbVhTR1Ax?=
 =?utf-8?B?Vkt5b3Y1SnhNQ3NYRW55OXBpcjJieVlPTkZFTzlSckNkSG9nSUNLRkZLM1Ri?=
 =?utf-8?B?WlBLeTNPaFpWazJNWWR4SER3M2ZCd1NUZHVoczlBOXlTNkp5NmhXWGk1ZjZw?=
 =?utf-8?B?ejZ0ZjJJTUZvRkI1aEdRaDNETGs5YmpRcFZlTjN4Ym9MUUdreXZCQW5EMTFJ?=
 =?utf-8?B?T1dkMmRyWFRGRDBpdzEwbWUxdzZMOEdIaDZmT2VkVURnWlg4N3lUMHdFa2Ux?=
 =?utf-8?B?UzhnWjRpU2Y5a2xWV29lRFVCQklDc1BVTXd2aDlNelozOU5JWE9hQnpJY1JB?=
 =?utf-8?B?R0NwYUt4TnZKL05PNFFHdkVQUmUzUGh5NDNPUGFMWG5ZYnh4VVI5ZVhxR1pL?=
 =?utf-8?B?RVlOUG1JZDlwM25Uc0VNNXFaajhNR1VOU09NWnFJKzdlSUMveFRaMmVsUWZi?=
 =?utf-8?B?Q3c5T1VrbUkrcmVwUkJJdit1K0NiQkxBazZRWmxRNEMxcldZVHY0aXQrUkF2?=
 =?utf-8?B?YUM2djJJTVUvOE9DNDdCR0QxQ3c1TWJjQ0FWamlrOGRmVVJBdkxmcGlnbEtU?=
 =?utf-8?B?MmlmMndSN1BZVXNQdFVNRkpjL2dJcndNemVUc3hIRnQzRzgwK2JNYzY4RTV4?=
 =?utf-8?B?NGRCT20wUytkRXJFRFJFOVRqczNNQjYzbnB3dS95bWE3QzJva09abms4c3lH?=
 =?utf-8?B?QVpSaDVwVjdVWkFLMFBMQVlaUGNmczJxZTJIbHJCREgzZ2tkODNEQUU0SEQ1?=
 =?utf-8?B?a3Q1MDNXSXlnRWJTcUM3ZFlLZG85WkY5TzFURm9kOEhhV1dqRDA0a1NrNEhk?=
 =?utf-8?B?QUtJMG52dTdLZkhIS0hERnhiWjZlSkNraytSUExwKzRZblE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:24:03.4435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aba8a99-6e3c-47ac-9bea-08dcf20e4e41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118

Hi Sean,

On 10/14/2024 5:23 PM, Sean Christopherson wrote:
> On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
>> This series primarily introduces SEV-SNP test for the kernel selftest
>> framework. It tests boot, ioctl, pre fault, and fallocate in various
>> combinations to exercise both positive and negative launch flow paths.
>>
>> Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
>> asserts, which enables the use of negative test cases. No functional
>> change intended.
>> Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
>> calls and sets up memory to boot a SNP guest VM
>> Patch 3 - Adds SNP to shutdown testing
>> Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
>> Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
>> Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP
> 
> There are three separate series here:
> 
>  1. Smoke test support for SNP
>  2. Negative tests for SEV+
>  3. Prefault tests for SEV+
> 
> #3 likely has a dependency on #1, and probably on #2 as well (for style if nothing
> else).  But that's really just an argument for focuing on #1 first, and the moving
> onto the others once that's ready to go.

Based on your feedback on the rest of this patchset, this makes sense to
me. I will first prep for the changes for patchset #1 and once we lock
that down I can introduce patchset #2 and #3 based on that design.

Thank you again for your feedback!
Pratik


