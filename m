Return-Path: <linux-kselftest+bounces-27477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E17BA446EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0CE881F6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FC19E98D;
	Tue, 25 Feb 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k1xfnxgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC019E833;
	Tue, 25 Feb 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501707; cv=fail; b=mnpmg0N4NZTm8nQ93qniFkSJyaGZDDNXZBC6HIPqpiGdrGjEVOS6qxOcjMrgfFZfjyOMuXsUTPk3KcRS4rLbO5+lusMiJvA4Jw8ig+qrwDufRXSWK/nOpIt7cV9eyB8G13FXYoCcKXtJYNPrA2YKorFvlN4dBZ0T4N1B+xMduoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501707; c=relaxed/simple;
	bh=xYK9y3lFjJQKjIbcgNjxi/kuZaR1aRwQm18MU5msT8E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Ud9kj9ZyBdKjFTaieyVTEq4/3L/VV3Xr1R2OFAwutcys/OHKiV5w7ucsvmQWtVR6OTc3eeHWGxTBV7JB26C4pA0gzwOLTNOceq4v6kIx727oMcT1O6YN7JWjuVyg9jY9A/qxVYnFjmBbioZv9vi8azIoBBZlQzdFBZOiKvcsfvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k1xfnxgN; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHEYH2aPZ49xSopO+u1kBpe4oE3w4zi7eSg1M8OuM7pEhtEB84qzmudlG+UukXNyNT8c2AyxH5j8UY9Won+8lS+TF8cr+DuxkNczelPAzp6v3P+eGJ4lVOZGUp0WmPI+mYg4/rCPxOGEWssMR84LLrl0Jlex32fZ5zW9vIJxCGA/iNEhTyTaL6A8FbbbjBvEA5zLzIk5KmMMVnR4fjGQu/WS+cjPDTZ0mDxZanLzN8wIMCasLkMrkeEbusTG/u/xuP0jwEuOW6H3lV9v09addAZ86NuYqhs5o+djOxPr+zW23hIwOT650+zEg1nszcBlzQK+5JDHtskBqZTBrgKjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G00Qy4ZHH3oDUYpIcYkUBvqdX+1Aeuy38x699yiEErk=;
 b=oz8l1AvJKLqj4/KJ8/laV1U83sUVtj6lzVCSAStrLIOMbuaF/4b1giu+VMrL6jS5Oci/0VICtj8lgnvJsu7f1E9AwL76oTPpSedA+5Kk7IO6kXT/hjvUL3iU5gAbCzUHwDO/CEGEWHaOkY+qnwG01MlmdTCtiwhEaeoWl/dl4pl9NUztLOIbFpD2PAzwmMWbCNLKk4UqWQoUyREUfTkj24u5wYjrvLOVS3sg5Juw8WsWxxBoaWEhg5ju7u7IGjln2769AGn7pbsejplY+0AD1S5bEGOyvNQmxveuL0QIvidMNem4qM0wF9HHiQjuTPxp+SZ/CVH9y8HsF5yVbtVUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G00Qy4ZHH3oDUYpIcYkUBvqdX+1Aeuy38x699yiEErk=;
 b=k1xfnxgNj3DTTdotUK7WxQbSM1xCR9xmg62pMUQERYLki+uMHioSegCfnJoc9v3slInt0Z6iD7Kv9TMK6YnQJah+XsxiAN+6o7KuOPNRfgiveabQEFkjUVNR/VOkBscGCdwQyEPiRlb3NDaoZtnl3+8FZ31LSo4q9CtuNOPRPGk=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:41:40 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::63) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 16:41:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 16:41:40 +0000
Received: from [10.236.185.178] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 10:41:38 -0600
Message-ID: <9480ce1b-2c35-499c-b60f-1c02ea9cdc16@amd.com>
Date: Tue, 25 Feb 2025 10:41:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <prsampat@amd.com>
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
Content-Language: en-US
In-Reply-To: <88fc49a9-d801-5d8f-f156-28fa06910cd6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: df0e2d9f-2d8b-4a59-8117-08dd55bb47ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJyWVliTnU2ZlRGVnRVR1ZqNG90M0dsNVNmb213WVl4eXNtTWwxdHdXNTNt?=
 =?utf-8?B?MHplZnhobm9ZRGRjQzkxUlEzSEhMOHZrRzRtakJCU1NWV1Z4NHBuSW9lK0JX?=
 =?utf-8?B?MC9PVDFtbFJ5NUxsbFJoZFcyTGFZV1lNaUxXQUk1WHI0ODN2RWRGeUdOb1Bt?=
 =?utf-8?B?SWFUS2FlSG5hMDUzUkVsaGR4a0pxT1k2a1NSYlh4amhmNXJ2LzVhcHlyT0R2?=
 =?utf-8?B?Y3N3RjdleVNzZ0ZTdUtnTnMweTdCdnFVQmI5QjRZZHZzZ3lRTHhrUUJQcHg3?=
 =?utf-8?B?SklIK0hQbVB5b1h2cTJsK3lsVVlRT1VTMUlPVGVxL01QQys4WFJBL2ZvZ3VE?=
 =?utf-8?B?UHBxUXcyQVlYakRtQVA2ZVgyL3Y2WUlXRHFtUUhpaC9xcGxCWW5wSkx1VGRS?=
 =?utf-8?B?eURkWWxCMkxGSUFLN096NU1ITjVnRExmbmdJcFBuZ29tUVNRTVlQU2lKaTds?=
 =?utf-8?B?alkxRHZEUkgvQTk4NkM5K3hGeFVkTmY2QW1UQ3VHWVV3MXRCOWk3b0dCd0s1?=
 =?utf-8?B?TVJjZk12Y1RmTjRPTWJJR29uUm1wQjg1VC9nSEM1NlJINlZnNVRCZ2wwczVB?=
 =?utf-8?B?YUJENFpZUUpyMHQ0ZVFtckxSVzRiM0sxd2NKMlpZbzNvZnBxUjFoZUN6K2Jx?=
 =?utf-8?B?RitGNzlNV1lHN1hKNXRTeEloT0xJRjc0MlhjZG5RTGZ1NHhUQlpUQ0NkZTFh?=
 =?utf-8?B?VlpobU5LTHYzNXNNMHNQQXlKTTZ5WmkyU1NOTHd2VFRPb2NLcFIrNEZaTkZU?=
 =?utf-8?B?QnZVVm54M1lJdjBINU5Ubm1xcHJ1Rk8vdzhVYUZnd3JEaUNUZG9OL0tDck43?=
 =?utf-8?B?TmVDZnM0a3lLdHRkQVRDZXFLUkRGdU5zQjRGSFJIejRPQ1JuUEZydTBVb0V1?=
 =?utf-8?B?UGZnc3YyeHM4eFZNamJhbVNtbksrcU54Rm1FOVZCbFo4VGZtVU5DVEo1bEtG?=
 =?utf-8?B?b3B6S1dvU1c3U0FhMytuQ1VnZmFmdlBwWk1xdEJyM2ZXUE1mN1JGQmgwaURv?=
 =?utf-8?B?aVRZS0FOUkVLWWxTNE13Z2NYMDBUM1dBMUNKeEVVbW1YYmJ2RW96TDNjSEVw?=
 =?utf-8?B?by9UNVFBaW1vclJJbWZ2M2xjSlJzcjBZQTFUWFNjQW9odUF1WUpyU2x5WTIz?=
 =?utf-8?B?UTdSNUtUSVVGcTBpSFlRMy81Rm1sV1BNZFpBUjd4d3FDaFV1MW81ZGxkeEE0?=
 =?utf-8?B?c3F3UnlmY25ibEZieUpKRmFwNWdSSEFsU21YMUNEellOK3VtZU53SVQ4c09M?=
 =?utf-8?B?MktaYll1TUNaZzl2S2VORjVmdHptdE9MdXU1aVN3cW9vYWVXRWxKMUMxY3N2?=
 =?utf-8?B?NkhiVWlDYWR2OHFjS0Npa1FROWp2Zlh5bHlwdUtXNXhKWEV2RWE1RHJPcEFZ?=
 =?utf-8?B?T0V1bEYzOXVRd1RZSi9DaVFRTmtzd2h0OHY5ejdrbGhsQ2dua1FMRzVjeUdD?=
 =?utf-8?B?SUtJcm5KNmZBYmRCVFdxdTNFRFpDT3ZRekRDaElHRVk1WTVOMWRrbmhZcCtw?=
 =?utf-8?B?Y0wrV3R0aUtwVmQzMmQ4alltaEM3d3ordlBNdk1SK0ZLQXlGUEVmVG9DT1Er?=
 =?utf-8?B?bXBDRUlBQW1pK1JvNWNWcnYwaE9wTjBCeWZYUWUxZ1VWL0ZBREgyMDN5WFli?=
 =?utf-8?B?ekJwbXpsM2ZVNTZObU5QTkJ6V29ISnRIWk0zd29qMXZ6T0lDUHZHN2hqNTkw?=
 =?utf-8?B?ZlE3TExFbnJrbnhQWkpCUEVZa2phSGR0bytvZVl3dCtnVytOMVJJTm44VCtv?=
 =?utf-8?B?VFdicUFMcGFWdnJqUFJ6UkJCcTYwZDBMaXZQcmwwSEQ5WktYMjc3MHNxWUtV?=
 =?utf-8?B?WU1ZYVpxb1JmTG01cXNIY3hibWpSRG1rRm9ONW83c0VOVmJkUWs2TjVRNGxX?=
 =?utf-8?B?UVFEUzN0aVBpVk1Bd1BNcWo2RWdnK2o5NVZoaW00Qi9DUHg3L2NPZVdQS3gv?=
 =?utf-8?B?NjdsSGMvbHp5K05pMnhaUnhXYVUveVBJRldjQk43K0VWTlIvTTZsemFCUnpy?=
 =?utf-8?Q?apsszmArfIVUwDgybIbCksGIN4IU8E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:41:40.5248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df0e2d9f-2d8b-4a59-8117-08dd55bb47ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

Hi Tom,

On 2/24/2025 3:28 PM, Tom Lendacky wrote:
> On 2/21/25 15:01, Pratik R. Sampat wrote:
>> During platform init, SNP initialization may fail for several reasons,
>> such as firmware command failures and incompatible versions. However,
>> the KVM capability may continue to advertise support for it. Export this
>> information to KVM and withdraw SEV-SNP support if has not been
>> successfully initialized.
> 
> Hmmm... rather than creating a new API, can you just issue an
> SNP_PLATFORM_STATUS command and see if the SNP is not in the UNINIT state?
> 

Although reading sev->snp_initialized is probably cheaper to do, it is
cleaner to query the platform status.

Querying SNP_PLATFORM_STATUS requires the pages to transition to
firmware-owned and back, and the helpers for it are implemented within
sev-dev.c. So, similar to sev_platform_status(), I'm thinking it is
probably better to create the snp_platform_status() API as well and use
that within KVM to check the state.

Thanks!
Pratik

