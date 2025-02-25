Return-Path: <linux-kselftest+bounces-27527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD4A44BBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C501C3B42A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C6206F18;
	Tue, 25 Feb 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y2dk9jy2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A051A7045;
	Tue, 25 Feb 2025 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512718; cv=fail; b=dlUIy+/IvPwT736FdW+ca7507QboFmL2518jqpeChoeJ3LcuM7iN9RtIiFaiexj0M2UI6U2oXbOzYiYmSrVF8JxHgkH5gKdmEVZaNklP77TuV8tjw0Cig9qjrUqc1ISpYGCdTqr/3ofreo9WyBkn+7+Jnyn/GZFEKOOq0rtFshQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512718; c=relaxed/simple;
	bh=LdRLnZIlyiO3BnY8Gr8zSHyB9MHTyj2Vu5IvHUZfDbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F1EJqoJhDHLcjPZR9YyhEDNSg3R9ssGJVB8My7foAiVYaC2IeoKm1/9nHcqzxwJjMkLBFbUw17oG/jJJu1W3ljewJmSB6NV2Gb3cX5I42bhXKPEPiiXY1kLi3dUaC0hQwQaOR6gAZ0PRpdV/kJht0Vn0BkpgGeJwJZKgRcQ5vcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y2dk9jy2; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iA2WI6GoQUlx6Wz51wMApjKLk8y3CYhm2VbNGXxlgc9c6c5a4yKDm+oJOayakO1ErvZYPN8bCQxe4q4zZhxDpEHRte1fN5QgVYYKWo/BV+pupLUY6wpiA/pfW0ItvZfZRP86KmnWSJiDz29aCmZLVtebBNBfxM1W2yp1p9ujd1zcEScPaTclOZoEcPA1xvNy3/0yc6oLY5Hu/idD28HxOzwO8SpjQVa4Arie1b6DTLsh3Di1q+0+MpHrqb66c/Gy3CFqJclTP9eKWdnfJskZTSJ883I0FLkJA5KBsuDyTEWfbMSsZp+gAYpeAPqLc6UHgnjD0Tvgv/t3If7RtX2OtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYo4UfYkYq2Uka5FO/9IZdOXRnt4fMoszkj8X9hpjks=;
 b=ZrdI5OfjnC0gLwaU6g383HYZEvtWJz/6QvzIpcRgFq8EPC+YJb5nCxq8cDsRDyUjWWL92AEKYNBQaueCo1clHPRIye4QQSVuuIz99f8eq+ge6dGsxKj96anWT3RN9RlUyQX47rZ+/aHP3zQMd1PQzTCMvVONk/5wTsR1sY2vecoROD90aXAGsRvXwlj/68s/gCAHjOlwfbdOiaidopZOlkHlrVNHhJCyewEsu9M9GmaF3GkPry7MtVbBjqtSyiGMYPFTCq/mcbemHzdWC8x/oo3TJ296qb7kXlnL5XERM5632BfKXXJrFIBpLdW3L4yR26EdJ1FG19xMW9XkeAiM2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYo4UfYkYq2Uka5FO/9IZdOXRnt4fMoszkj8X9hpjks=;
 b=y2dk9jy23iPQ+hLKBXa+lSl9ojVqAmeLWmWNGD+GKBVMkzpfTZ2iIfH9b/z8XG4xH9naAOXQEgnzmq11vEA1QXfL5ltzGmU1R674dgcs3DhZjTrUaifyBfOQEjL0nXA1A6pXFwlQAefGWNUqYT7Cm2S+iHAGO2PMvoeU0OKhIc8=
Received: from PH7P220CA0171.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::32)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 19:45:12 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::82) by PH7P220CA0171.outlook.office365.com
 (2603:10b6:510:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 19:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 19:45:12 +0000
Received: from [10.236.185.178] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 13:45:09 -0600
Message-ID: <6c497385-6447-4d81-8d93-20c46cad29f9@amd.com>
Date: Tue, 25 Feb 2025 13:45:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] KVM: SEV: Disable SEV-SNP support on
 initialization failure
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
 <a84a3d32-9cf7-4c24-87db-99132a450557@amd.com>
 <b0fe42da-b257-bf1a-94e5-77cd8c090341@amd.com>
Content-Language: en-US
From: "Pratik R. Sampat" <prsampat@amd.com>
In-Reply-To: <b0fe42da-b257-bf1a-94e5-77cd8c090341@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e1df12-5325-4d37-ecb1-08dd55d4eb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGdmMDBrdWxqd2paN2FIMUd2NGVKTDlNb0ZMZ09ZdytYdDcyUk42MlJZbE5E?=
 =?utf-8?B?c2RhQityNzUwRUE1TDZWMzkyNndheGhmTEhhUkFzQWJoMXVXdi9XRTNOQ0N5?=
 =?utf-8?B?M3AxUVo0WDZVeFhMVHE5Y0E1dlZoYll2WWRuVFhsazd5a2JnS3g2NmZKVDMy?=
 =?utf-8?B?SDU2NWd5aEl0SnZ0L0Rna3VXOWY4WXEzS291c2hWRnFlcUNiUnVxWHlVRkRF?=
 =?utf-8?B?bDYvYlMrYithQnFMSm83Z3MrWDVJTGlvY0owU1lOMk03OC9rRS9EZ1k1M1F5?=
 =?utf-8?B?WTlUVEJ2b2xhRHZ5TnZBbDRTMzZDOEJjbmxDY2E5OVgzK0FkY3N2a1hUMUMz?=
 =?utf-8?B?cUJPN3dCblBQWWZYQjNiZjJ6NFNVb3lHWG1jQWw4T0JaQ3NNS2JrcE1xSm40?=
 =?utf-8?B?TWdpYjlhZ093TWJlZWRBQmdSVjZxZThYRWd5dGtUMksycXFZVmVJQUcyMG5B?=
 =?utf-8?B?ZDdlOHprQSswUlF6VlA3OFY2Q0R5aFdpNTB0RE9wRXphbm9QZFVQbE43V2xV?=
 =?utf-8?B?WFV0TmxDQWlhYlhIOWN1Q3BzdktiRXlDQm1KTWt6R2RzZGFvbVNYWDJyOEdi?=
 =?utf-8?B?QVBJbisrTHhnQStXN1hick1yb3BORGVMSDJ4RU5oZ21WQjIraTJiYXhtcDdn?=
 =?utf-8?B?WHpBVFI1bWVBK3JVMEJ4aFNvSlhCZTlDQVJnMWRBMWttUXlic3pFYXBMaWk5?=
 =?utf-8?B?Rm93NUFncE9DdVg0ai83SmlpOTNaM3ludE5QMXZOWmdUbFllR3gwOXAwOUll?=
 =?utf-8?B?QXRaVi9ERC81bTZ6TFJPSDc5MTNKUWM5NU40SmM2QlBwZG9pOWhoQUxuc251?=
 =?utf-8?B?alVrb3lYeGJMWUlHckdSUEdxT2dwVVU5ZTUyemZ4TW9EZVMwUWplK1pOMDQ2?=
 =?utf-8?B?UDhuczd0cnVnOHUxT1FuQUNqWmZDU0wyaUpxNC9XK0tpQ3FVZnYrWVAzWm1w?=
 =?utf-8?B?b1k1VE4xK3V4L3FEQW40SlV3L05PVENDUzNNKzNFemRrR21NZTdNcXo1U2NP?=
 =?utf-8?B?N09QbTdSWmVobEJKci9IbVNiNDdVZDFqSmY1YjhScXhSdVQ0ZitKbEVYMVYw?=
 =?utf-8?B?UlFPR21nbVByem44UGxYQ0ZLSVpudmhoeVVzWENUN1NYVHhZTG9oa2JpUXdY?=
 =?utf-8?B?b0F6RGhjVndvQ0wzUUZIODN3Y3NRVHh2SEhZYUJyVEFwMUJBUGdNUVhBOFJW?=
 =?utf-8?B?RFZlV1FTc3dxUHpONG1vQUIyTDg4dnFWbjBXdmZvTmRlZVRMNlFtRGZzcXRo?=
 =?utf-8?B?MkptcmhsaWFnOFhoZVJxRExWZnAzNEZwYVcxZE9RM1VZTTN2dzY2WVZUa1Ro?=
 =?utf-8?B?b2ZDMnhYeEpBSGFWeXRWbHJUUUVSUG5vKzA3THd6U3RRNVp2eDkyVFFSdkh3?=
 =?utf-8?B?WDRwQ1JlZ3N3TktnbHdWSjdNemgxQXJ4eThoOGhseDZlTzZBR24vOUJTUGNt?=
 =?utf-8?B?d1MvM01tbWFPcnkwV09rZ0E2Tzd3Tk1nZzkwY3lOR3VhaHo5ZjhwQ1FRZGwz?=
 =?utf-8?B?ZmI4ekI3OHpXRXpXZm5xRHVMRHY5T0tOSXN3N0dkbVU3bWpiVTVpUUxBMjdv?=
 =?utf-8?B?eSs5cTJDYjV0NFlJUFFXVDBEcHVZK2Y3anpoNU5QL0R0TmJ3WXFTM2RGc1dM?=
 =?utf-8?B?TE5zOHhIbjVmRFd1MUtNWFlVNEpQSUpKTGZVZzh1cDRuOFhyaVBTLzQvZzZB?=
 =?utf-8?B?M0tnZmtMdHU1c1JWUGlLUGFGdWxWZzQ1eEZ1b2pDL0VVK2hCYk9jbVFhREZL?=
 =?utf-8?B?NzVsZTZteU04NThIMjBmTlBnQTM5aEwzc1cvREJVTmU4dWVpSmw4WjVZVG9i?=
 =?utf-8?B?aGNsRUtFMTVGL1VRYVBIY0s0ZlBzdzk5c2s0dGtxZG5qbzJiaVZvS0ZyWXBG?=
 =?utf-8?B?d1ZwWjhIQ2w3ZUJEVlI3SE52M0twcTVtYzhSenduOEp0UlB1ZDZZdnFaQjJx?=
 =?utf-8?B?cXZaTmhkU3IwMC9BQktBOVNEMUt6S2FZOERMeU5aTHZiSm1kT2NVNnloT3ZP?=
 =?utf-8?Q?1Cdpl+atIWHR5aTriBKzrp6DgUrfGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:45:12.4262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e1df12-5325-4d37-ecb1-08dd55d4eb46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349



On 2/25/2025 1:09 PM, Tom Lendacky wrote:
> On 2/25/25 11:45, Pratik R. Sampat wrote:
>> On 2/25/2025 10:41 AM, Pratik R. Sampat wrote:
>>> Hi Tom,
>>>
>>> On 2/24/2025 3:28 PM, Tom Lendacky wrote:
>>>> On 2/21/25 15:01, Pratik R. Sampat wrote:
>>>>> During platform init, SNP initialization may fail for several reasons,
>>>>> such as firmware command failures and incompatible versions. However,
>>>>> the KVM capability may continue to advertise support for it. Export this
>>>>> information to KVM and withdraw SEV-SNP support if has not been
>>>>> successfully initialized.
>>>>
>>>> Hmmm... rather than creating a new API, can you just issue an
>>>> SNP_PLATFORM_STATUS command and see if the SNP is not in the UNINIT state?
>>>>
>>>
>>> Although reading sev->snp_initialized is probably cheaper to do, it is
>>> cleaner to query the platform status.
>>>
>>> Querying SNP_PLATFORM_STATUS requires the pages to transition to
>>> firmware-owned and back, and the helpers for it are implemented within
>>> sev-dev.c. So, similar to sev_platform_status(), I'm thinking it is
>>> probably better to create the snp_platform_status() API as well and use
>>> that within KVM to check the state.
>>>
>>
>> Although I am guessing the initial intent was to not have an API exposed
>> at all from CCP and only make the SNP_PLATFORM_STATUS call instead?
>>
>> Since that may not be cleanly possible (we have helpers for page state
>> conversions such as rmp_mark_pages_firmware() in ccp) without
>> duplicating functionality in KVM as well, I guess the question really
>> boils down to whether we export the cheaper snp_initialized() or the
>> snp_platform_status() API instead?
> 
> Taking a closer look, we do already have APIs that KVM uses to allocate
> firmware pages (output pages for SNP APIs) that can be used:
> snp_alloc_firmware_page() and snp_free_firmware_page().
> 
> I think that should be enough to use sev_do_cmd() to perform the
> SEV_CMD_SNP_PLATFORM_STATUS command without exposing a new API.
> 

Ah, I had missed that! Calling the SNP_PLATFORM_STATUS this way works.

Pratik

> Thanks,
> Tom
> 
>>
>> Thanks again!
>> Pratik


