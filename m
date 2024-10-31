Return-Path: <linux-kselftest+bounces-21227-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D39B7EDF
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B602B209CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285281AD9ED;
	Thu, 31 Oct 2024 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sjlZkiUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8DE1A4F0C;
	Thu, 31 Oct 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389524; cv=fail; b=ED+eRYw63lSwDaE+J9V+sYV5whOdob6puqXwJxkg+L1gWNehNzV5ayRBqL1zTcP7PbA983wRmgd1URvkD3OnW/DDHVhKCAo9zq9mJsuwN1MSJ74hdBi3mLN4xuc/X4/CjRtqAcdLTfXEKdXwNxf3O0zjd5vULFvTaZ800XbQe2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389524; c=relaxed/simple;
	bh=jBMVZrYSyKlEElY1A1KJ8misrHcDGlWPHbNDvZW6934=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tF/rTmc5nAJRVRBVlb0Rxe8a1j+IjA2UoN+vp9AgNrn3CScEa3i7pMFCvx/MelUwza1zT/nuerzb5lstyBUPuG400buVF9CC6W9L+qEsDGUKOCE7BPlkEfTKAdHlJonT0uF+/5rs1InfiyB43FrGyn3FV/Z9moywbqJ2N9PpcaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sjlZkiUe; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGIy3+bZt08QMeRH11cn8rr94gZ2+3J6ZyY5wCqNVwj7fpIZ3Q+Bj4T6Aw5pviDIcEjPuKXPzMCgRoyKekznUmsoSR1giG62wL7tEW2FzZBqCo/tx/VUNbFRorZ/GCxsHqv8O/NUP/kitZasd4Ykc5R1n4P7owoOCmt9oxoiNsItd4fGm62TF0cweJE+mFZqk56cX7UwbX8bwsSHMa/NeMQdHh6ztC/b+hRLvOnwcpgcBfFBuZ2vcNPK1qmeo40zjeloedxbWqv8v4NnzGvlS+T7XfSUfmWomCRAoQxDS/RSQ3+2FkGGvIr/FgZziht+sbX5daDgZKKMOF0php1d/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuaH8HiwMBhqOk3r8DkMT8lp/nG3iBvGzqFlLv25Vs0=;
 b=rvIMT55MLsV8VLzpCWPlVMygtx4s8wau2xj3WpNqRE93pZqFsY1ZPov4NuHkjr0PiPqnl6epLSwdSSynzOHEFILDhW7YwsKNUcF36tXnp7lJ2W2cDtc52Pwd7F/bvGAxHRTadv63bKaXcSDKIg5xoX+5wZK1YDCyOfUtZ6zBuHfgpSa5CGQEo6T36XnvrNl46cBSNvVZQLrAuyoKpHo84BnQmTp7bN+w+bEdVEAKITNWI5yPzu4mnMRqFBj8cUE2DVOfAvu4vWg9qOmV73ZXRwTvR3A34G87IxkK6qqEIcPnkZ+aifVvTSh/s6LiEwNI0cSB+YIAE7chz0v/aphWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuaH8HiwMBhqOk3r8DkMT8lp/nG3iBvGzqFlLv25Vs0=;
 b=sjlZkiUewzg2jLJNwY7MDByQ/iTSJn4iC9xumnN2OCWaAFH70flsBDMPrnNzEG11bH6EOyMUc+4PiFKxhbQ5Aw6L5tmqa5xcNYaxRJ02mFOQed9z/ittkxoVbil1q2pGt7lFxcFYyWe8pMbJvLNhBJxFC31BJ5oqPNOBb1XlUGU=
Received: from MN2PR20CA0066.namprd20.prod.outlook.com (2603:10b6:208:235::35)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:45:14 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::f4) by MN2PR20CA0066.outlook.office365.com
 (2603:10b6:208:235::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 15:45:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Thu, 31 Oct 2024 15:45:14 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 10:45:08 -0500
Message-ID: <11787a92-66ed-41ef-9623-d6c7220fb861@amd.com>
Date: Thu, 31 Oct 2024 10:45:08 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] KVM: selftests: Add a basic SNP smoke test
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-3-pratikrajesh.sampat@amd.com>
 <Zw2fW2AJU-_Yi5U6@google.com> <4984cba7-427a-4065-9fcc-97b9f67163ed@amd.com>
 <Zx_QJJ1iAYewvP-k@google.com> <71f0fb41-d5a7-450b-ba47-ad6c39dce586@amd.com>
 <ZyI4cRLsaTQ3FMk7@google.com> <de2a6758-a906-4dc0-b481-6ce73aba24b9@amd.com>
 <ZyJzcOCPJstrumbE@google.com>
Content-Language: en-US
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
In-Reply-To: <ZyJzcOCPJstrumbE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|DS0PR12MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8c703b-1acc-4d65-42d0-08dcf9c302e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEhCNktSaE9YUExtYWZyQ3ZJVjRTb2gxYzNVOEpSVUpQSmc2dHNyRkIwOXd3?=
 =?utf-8?B?MS9qZWs4U2FOOWc0RVozZXQxUkxQR2pnM0Qxa0tkb2dNRXAvV2sxOTMrdnkz?=
 =?utf-8?B?VXdkVEFsU3hLTGlTZWw4c3ZsWmcwdE1oazlVa0gvUjVMWGFHdVB3TFIwN1Nj?=
 =?utf-8?B?WjRyNkZKRFFPNGh4SGZxanBvK3RDM0dRTklranpwVExleTQ0QkE4WWttQnA5?=
 =?utf-8?B?MnM2bFFxLzZ0dmN0dThtY3BYMkJtK3dKcnQ4QjNJN0FoSGJNK0dBaDY4RnBZ?=
 =?utf-8?B?SjhSU1dOVUg4dFR5Yk51TnRkWmgvL01VYStVdUZ4L3JVYW42Q3pWcDEvSmNl?=
 =?utf-8?B?TjVBY1g2d05HaURLOHB2d08rWkZTZ01VZG9lNlRuRFlXQXlCdnRJTkFqRldI?=
 =?utf-8?B?ZFZzYkw4MEdod2tCZ1pSTm1GTEFJcFJBSmI1a3N4bVFqMlRhczZpYTV5R3Rj?=
 =?utf-8?B?dXdWVkdSS0JBMTFPNC9EVnNlRitxVzRxWHJQd1laNXYvd0lPWjlmb3NYVExw?=
 =?utf-8?B?bzVVTzloM3JmUHk3alBEbTJJSnh1MnJ2ZVc0WDVLWWtZMEFVYW5YUVBLOGVt?=
 =?utf-8?B?cTJWeG5uT1hzV2NBU0hhTHUrUmF3eWFUNk1aR05ZeW8xbWYxbU54NUp0MGxX?=
 =?utf-8?B?Qm9XR0VaZlE2aHhtR3A5ZlVPUkxORnEzakRwdVltNDNSc3BXaXdzSTZnSFo4?=
 =?utf-8?B?MTJOT3JSdFFITlFGTVFTL3hwdUNJUHovM0VGZkpSM3RCRWZHb2FTL1FLcHkv?=
 =?utf-8?B?enFBMWFvcERIeXRlSVNMUjIvMkt1Y2haZGRDaHVDZUVHeHRjTXhwSndMYVpm?=
 =?utf-8?B?b3J1VVdJODVndklseitPWlRwQmJUR0JSWVVxdXlHbHRKZWd0YmtYcXRYd3lq?=
 =?utf-8?B?S01OUDFIZlVlOWs4a1lwWTlUSnF2aFQzUFFOSmhFYlZjY1pIZko2cGJkQmFY?=
 =?utf-8?B?WUdHQUJpVVhxZjBETHM5ZjB6NnA4aGdTdkZpY3hFbUxrQVlMcjVCTWtRdDZh?=
 =?utf-8?B?bDl0b056QlhvOWl5cVNlWlRSYTA0QkhNSm15OWlGRE13S1NQR2MwL2h1SUkr?=
 =?utf-8?B?VFB4cmZIcWNrWXNnZG9PalByVklhNkU2LzFaT3NaeTR0YlVYR2dzSUdWUDZB?=
 =?utf-8?B?V3BpMFZHNTVqb054ZEQyS1FuT0dRUGZZa20rYzdVeUNnTW8vaGxnTzNtVnRj?=
 =?utf-8?B?VmN2QkROemNSMVgrREdzSTl3Ni8yOWtxMFkxdmVCRzBmWmFqWm9Sai9ueHBr?=
 =?utf-8?B?ZzMrYkhTaWV0cUNlNHV6OUpmdGdxZmZHZW4za1FneEkwMHR2d0hXWkU1WFVY?=
 =?utf-8?B?ajhlVm40clI0cmxETWo4TTJiY0Z5a0k5eGVsQ3RBZWtoZFhYSHNmYjcyelVo?=
 =?utf-8?B?MjN2RUFLZnVUY1NXbnUrSm1NREVNSDQzaWFrQ0NIOVdZclQ0eWRGVTVMVkhY?=
 =?utf-8?B?NzA0RW42TDhiUm9ycjJUUy8xc2xoaU84Y0lGQ2diaDBLL25KUGZMWXEvVFlV?=
 =?utf-8?B?Yi9pbU85ZkdHWVFsSVdSUUgvV0RFMHdSdFVITXVxejJ0Y1BxdlFqUFJDWDVv?=
 =?utf-8?B?WGZlN29Vd3VLSXFab2wrclJ0ck5tOXRXRDJzd1VDRytGcUhIUXJhbHlBZDBN?=
 =?utf-8?B?MW5pR0x1RlR5eCtiS3Z4My8vSWVUcFRmOUxaeWVpemQzUHd5NXpHV2FHQmdz?=
 =?utf-8?B?SHB0cXpDc0tFbWhLZWU3K3UwTzFKQ3NZS0k5NWp3Z2lmTWRqUW9ybmtKZ1Zm?=
 =?utf-8?B?SW1VYnhUVnhZc015SDRadE1VbHFkcUgrbG1Nc2hyaDRkMVJYYW5Od3l1T3pv?=
 =?utf-8?Q?C2ymyHK8PsoBZTzf1k5sobsdYmSY3avVuSOY0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:45:14.0058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8c703b-1acc-4d65-42d0-08dcf9c302e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072

Hi Sean,

On 10/30/2024 12:57 PM, Sean Christopherson wrote:
> On Wed, Oct 30, 2024, Pratik R. Sampat wrote:
>> On 10/30/2024 8:46 AM, Sean Christopherson wrote:
>>> +/* Minimum firmware version required for the SEV-SNP support */
>>> +#define SNP_FW_REQ_VER_MAJOR   1
>>> +#define SNP_FW_REQ_VER_MINOR   51
>>>
>>> Side topic, why are these hardcoded?  And where did they come from?  If they're
>>> arbitrary KVM selftests values, make that super duper clear.
>>
>> Well, it's not entirely arbitrary. This was the version that SNP GA'd
>> with first so that kind of became the minimum required version needed.
>>
>> I think the only place we've documented this is here -
>> https://github.com/AMDESE/AMDSEV/tree/snp-latest?tab=readme-ov-file#upgrade-sev-firmware.
>>
>> Maybe, I can modify the comment above to say something like -
>> Minimum general availability release firmware required for SEV-SNP support.
> 
> Hmm, so if AMD says SNP is only supported for firmware version >= 1.51, why on
> earth is that not checked and enforced by the kernel?  Relying on userspace to
> not crash the host (or worse) because of unsupported firmware is not a winning
> strategy.

We do check against the firmware level 1.51 while setting things up
first (drivers/crypto/ccp/sev-dev.c:__sev_snp_init_locked()) and we bail
out if it's otherwise. From the userspace, calls to KVM_SEV_INIT2 or any
other corresponding SNP calls should fail cleanly without any adverse
effects to the host.

From the positive selftest perspective though, we want to make sure it's
both supported and enabled, and skip the test if not.
I believe we can tell if it's supported by the platform using the MSR -
MSR_AMD64_SEV_SNP_ENABLED or the X86_FEATURE_SEV_SNP from the KVM
capabilities. However, to determine if it's enabled from the kernel, I
made this check here. Having said that, I do agree that there should
probably be a better way to expose this support to the userspace.

Thanks
Pratik

