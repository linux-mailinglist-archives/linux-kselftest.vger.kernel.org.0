Return-Path: <linux-kselftest+bounces-33769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C681AC3C15
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 10:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11C43B10C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4F51F2BAB;
	Mon, 26 May 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KI2ed8D8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762491DE2AD;
	Mon, 26 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249545; cv=fail; b=QcT/2TPsac8adONi0zde/NDsp/y9/4q74tNkotniS98xTBbFUMiXjFryCzdqdy1/2R8h0VIjqOFOAEAuxHGPMLKOIeFEwE3JEG39zStb6amjeDeMLHhfFoWXz8feY20id/Ods2ikXz9JqkrwQgGU/p3gYu1G4h6jq/KLhpdibuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249545; c=relaxed/simple;
	bh=h7uRSKB0H2NKIzR94aIXteAVwBotb3d07s6rBlWrxrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VLl2+8QKJevrfgLAjfrOI2lgw7NxhD4zjSM9Ut9MuVu3hvPiNGhL+XwfijbFR9HkXKlPjzMHmJwYb14/aibDiolennwbl8ieEEyfeASZlhHZ8RVFFHnzOcv6j655XlDBd5nxtRlwlruq2Cx812iHRHZ0QePXaJmcxM0KhuzOBJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KI2ed8D8; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZJ5q4K+1/5mjUTAdZTGb+ey+dEVTBlk2M0axseLZaXzGBWwp4IqxUnVlTajuMQyE1V7j4DvEmsoxtSauDT37GFHso6BaAXvOrVMC3AIofJST39I8HnQuCqber/Qw/BolxJm+pEiRHUQntw2xzHMyZwyJzeEf1JGcY6xy3Rd0z/y2+yhpcbvkm6oGztPaf40DiEi81xV5mV78U1pMcqKvox348BVwX6wHZyRcwDWAwfqeDHR8WnF2v7mTYM3ymBGuvUjM2WZizOKRmAi2HmhjCNkZ58KEWFL8SR3fjwt20AFakrhvhgnWInDQinPzTENpH2LPblS3/7J9N3w1yWRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCVWm6aj10XvkEBP3F6pSIheRN+bS2GNzljGXYnaZ1k=;
 b=Jcp92uewmwrrC4nuKA/zZSIBcu4iYxmqI+UFOwVTdENH5V+BkxMSCpmbF3sUBYdKFYVw+zHQ0WdPrsLcnOak/lGIV3QPFVr1oAeoejr4DAO+ngAQz9nVRj85zX4AMOnBpcOEFY5+zkO0fkOgHfP9irXI4W+eFCSGP4WJEY0wRCZ+uzunf6n/bef9PfWNOwdacmD3JTbF/Ajy71PlJ7Iya92nCD/ycl/PA5WXLx11PYNdZTm6yhB7b/VcSwpkwNjUQD0j0NIZZwnMJZJwgKOeagPGEak+E7rD9s5Kf50FGZg0DF7PDOcvPDbmhmCM2lDZI03af9UyMg+FUS/PwTD04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCVWm6aj10XvkEBP3F6pSIheRN+bS2GNzljGXYnaZ1k=;
 b=KI2ed8D87NcZ8Hi+sS2PSJM/fdfXyB6ioLmnsJG2+V2qWJZxzSPOstCx5aaIU1UZYl0QRkqqXxoXllO0UuszLNE0UlkYnDOuYM3K8ACZN0suxMwN3OOsDCA7wIucqRT8d4BsN6Fu/uWC5E2nsGS0z81OFz5umebj3PpBNu8K+Eg=
Received: from MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 08:52:20 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::de) by MN2PR22CA0012.outlook.office365.com
 (2603:10b6:208:238::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 26 May 2025 08:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 08:52:20 +0000
Received: from [10.252.216.136] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 03:52:16 -0500
Message-ID: <76b4dd65-43a9-4d34-88bc-1632c08a9bb6@amd.com>
Date: Mon, 26 May 2025 14:22:08 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <shuah@kernel.org>, <gautham.shenoy@amd.com>,
	<narasimhan.v@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
 <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
 <8a2149ca-a0fe-4b40-8fd4-61a5bf57c8b6@amd.com>
 <20250522094520.22zwevl6vgrjf3aw@vireshk-i7>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250522094520.22zwevl6vgrjf3aw@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: be3dd064-05bd-40dc-832b-08dd9c329fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eENjVTRvUWZRVDZGL3plZUtBTjJTdnBUYlZ4WnN3dzRsYUJva0d6KzZPSFRj?=
 =?utf-8?B?Ky9sTHF6WmdrTWJQeEp0cFVJdVR3TUU0SGMyTnp5UlhLWHZlM3kyZ3hwVHFL?=
 =?utf-8?B?QU0vcndxODl1bHVIdmt5VDFka29SUldWOGhjakw3K0lpc3d6MlhtR2cwWW5R?=
 =?utf-8?B?REhmbHZHTkMxNS9POUZZTy9rV0tBLy8wVmJJdCs2S25GSGxmSHMvZHVVenNo?=
 =?utf-8?B?Wmx6bUYyTk8wL0tZTzZIeExBWDNrY0VvbHhVR2V2dXFma2FLc3FOTVhtWC90?=
 =?utf-8?B?bDYyK3U1R3pXcVhRK1RhV3RKR1VLS0QycE84WUV0TXFGbkNSWit1SW1JSFJx?=
 =?utf-8?B?d0xvWDVRRmYxREk2bWM0R0F0N2hQbnd1OURHSjVqcytmZjFCYUFKUkFDVWRH?=
 =?utf-8?B?bzlhcUcxc0NkZHBEanBiNWdCc0lpS04xVTkzVzMrcWFUWUw4S0hGWWRhSHBB?=
 =?utf-8?B?SVNkYzl1YlQyQkp1UzZNSC93VjBaSlNhRFpTcDU1bSt0dnVULzlBTHJVaUZO?=
 =?utf-8?B?bVlYeVZEOU5HTndGYUxhQi8zM1BJV0tBRUdQYWoxeFQwamIzTlowMk5UaXZn?=
 =?utf-8?B?eXcycE1BMjN0dm1VbEphVTVqbXVORzgzV0Z1Q1VkY3pzOWY4TGpuaHJKZWI3?=
 =?utf-8?B?bVduMU9ETlgvcjdFd3I1Tmg0NFlQWGo4TVZPbDhodzZSMHZET2d4RzE3ZlNY?=
 =?utf-8?B?VHZGcllEb1NLNVFmMjVOaTZSOXFQOU1uYlZNdGRhNXIrcVliRnR2UklzY0g0?=
 =?utf-8?B?ZUdLcWpCeXpDbkJISXppTzZtL0tDKzVoKzlsYTk0VHpNZVNKZm9kSEQrWmZB?=
 =?utf-8?B?VEVMY3Y3RUxmMkp2T054WCtRUzBwbU5vZGw3M21rMTZIUkNXSHNWQTRkdjZD?=
 =?utf-8?B?ZWpNaEhUV0NSTEtubVR0SkJNTkpZd3grdUtadGtSSDRzVVF6aDVYL0I3TWV2?=
 =?utf-8?B?M0p3dU5wbHpHbzBaaUpkMFM4cVRIZzJCM3dTUXJFL1Zrem1HbDJzdVRvVllQ?=
 =?utf-8?B?UzRDL3JSd0ZzTnJqdmwyU2pETHFmNEZmcTR1eUVsNEtHc05ZdlZXQTlXRmE5?=
 =?utf-8?B?OTRwamg0TWIxaHptQTFCVFRDcys1dEtPVE9NRjhsL3I1Y29WaHZCYWN1aUp0?=
 =?utf-8?B?SjQvS25UWVcvRXRUNzRzdWdZaHRYbGhxeVhnSENKazMzbENiaU9HSTZ2QzNx?=
 =?utf-8?B?c2ozZXBzTmYzUzdCeEZ2QUN4QjIxa3VncFB2MjUzMlZPL1c0cDBnUjFxbmJX?=
 =?utf-8?B?cEIrYUFPTUxoMEFaWGJyemVHZDVoamRsQWVicWxXa2ZmK0RwU3F3eGdmcjhV?=
 =?utf-8?B?dTFWWHo2a3hzV2Jjb2JNSW5ScDl2dUJ3N3ZqZ0VJdktISWJMWW50TzhPVmxq?=
 =?utf-8?B?cVFPeDBRZDNUMGg4Z2thaWg3MHVYbFVjNWhCencxak1hNTlzZk8wbDc4U21P?=
 =?utf-8?B?YXQxblhnWFRkT1pqNjlUM2hCZEV4dXdvdXNiSkFUcEQwWkRqdDZ6RjlQbTFV?=
 =?utf-8?B?ZC9yV2VxaGFaTUcyREh1OHRHMlo3WXhheFZuYVo5RkxoeW1VcFIvRVQ1Vmtn?=
 =?utf-8?B?Z05GcnRSU3NYbGdqRUlaeUFTZEFxK3E1K3NXckYzNTg4eU9NQWJ0dWQwVW5y?=
 =?utf-8?B?VHNYSnNybU9wck8zZ0ZEaFFSY1VtQVAzTW5OdVE1L2hMeFdYWS9WaDM0SWV2?=
 =?utf-8?B?UmNrYW1VdmZZMnVpVUkyMWpObGswQS9NMUQ1RWZpcmdTTUFTbEkydHl1UjlJ?=
 =?utf-8?B?ZmJZR0E1Mm4zZER0R3NwWUtRUFFaeWJMMGVkZjRFUThHU0V3VEdQd2hQekFR?=
 =?utf-8?B?RTZIekdwSVpCY05POEVIZzNFZ3BaZXkrd3AreE1jWjBjSGs1TFBhOS9PYkli?=
 =?utf-8?B?bzQzSFlKTTN6K0FGbHN0aFlSN2V4UHlVUU1RcGJKMHpVYnRsWFNwUHJVVW1S?=
 =?utf-8?B?TldBZlExajArc3U3RVJzT0R1NVZqTDdwWUhZV0wvRW9Ga2w3QWZiMElOUzNl?=
 =?utf-8?B?TmpSRU51RGlCUlJBQkV5TlpYM1JpKzcwQjF3a3l0KzVPM21UYU1TbVJkQjBO?=
 =?utf-8?Q?GX0oKo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 08:52:20.0835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3dd064-05bd-40dc-832b-08dd9c329fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728

Hi Viresh,

On 5/22/2025 3:15 PM, Viresh Kumar wrote:
> On 22-05-25, 14:07, Sapkal, Swapnil wrote:
>> Initially I tried the same, but it does not work properly with the root user.
> 
> Hmm,
> 
> Tried chatgpt now and it says this should work:
> 
> if ! cat "$1/$file" 2>/dev/null; then
>      printf "$file is not readable\n"
> fi
> 
> - This attempts to read the file.
> - If it fails, the cat command returns non-zero, and you print a message.
> - 2>/dev/null suppresses error messages (Permission denied, etc.)
> - This works reliably for both root and non-root users, because it actually tests the read action, not just permission bits.
> 

This looks clean. I will send v2 with this change.

--
Thanks and Regards,
Swapnil

