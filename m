Return-Path: <linux-kselftest+bounces-44963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FDC3B195
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 902755069BC
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C061344041;
	Thu,  6 Nov 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1s1a115T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1969434402A;
	Thu,  6 Nov 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433777; cv=fail; b=n4S/Ss8lHpojTrHMO8dfjy5BvDBohr/R0i1YwBuznMVwr3req/72EludnPXpT/8VFjKGEIq4wFB9frasmLIFiOhgHc/RwnU5tAFv1lOrueLbgwz4dII84W6Y222eib/xu3xipjj/iQKV7XPQnAzFmljjKjuq83GFv7nB/EjtIvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433777; c=relaxed/simple;
	bh=VSEcRY8bl+NE6lLHLevw+CZXcc+iTA9Hbd15K/R+C1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hqQOF0pAy6VmXsfQQL8uCCMZiRtMgtSIPOjaxyspIAABEGycymero4YnyVOsYEai16HqGlaG1Ow0omyVqPmGk1FTn0hX5rBZfbXzHSX9sA2BoQoNfGufa/sfmBlKZQUMW4l+/USFIT+UNM3PcsW2w5UCANYUbAn4XIOQ27NqBg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1s1a115T; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2GHcblU6n5NlAmubrpUQkMUALr8qZZ/CXHFINW07sB90eTLQpMsslSeLhdlmOu30P8ThDCGO9soc+XrWZxfMqvj9PVLMgKL/8vHiRiwPCu7YE0De6JxFjkmiTXWDyDn507hni7ngLfobz7IEk16QYvY8w130NS1oq1cu/v4Jq0JIDhMPO/sSwlUjQTTLIxDW/SXZBzTO6dqbM5fKrDor5gPVDZMe0S0TYPGa/8rLzSSf074JNUMmaqoN8T965Ter42Yz75KvNK9lUwglVPC81CasxU5f7OFOCyyJTgzC0mvIohyNBYPTR8u9Uc+asxTDPeFB7AE5logbFxewneisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaH4jL/kGe8N/E21Aq+Ilky+SDexErt27SV2D0lZmWs=;
 b=EDU5/Rki3JVMceB1izlQO5xJfhe+NbiyGwlsrtDFXn41cd9V15tPBZmt0kqQQ4iOEEnkzTo43FUOBM862Zn83uH79UxXYmNLHxjWUU9/Sa9wYW5/p6ro1SzHS3jQ4Lng7cL/VA3uTTick+J++46W6lvC6YoRHtLgsm4QgbIH/IWZresoCFpWW2QpXuhKsf7347BCdqrLDtjbCHxZIKcOisHuxSwNuFdPVDNwP5vsmab3EnrACDxv+5SOMpjfixaLPqb0LZ75MxdBnfxCBipZdMqoOoKXHjqILy+pBL0nbn1jlIdJ7jrHOH7+zmX2dQTYykDeKvmrUoyxEg119oPzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaH4jL/kGe8N/E21Aq+Ilky+SDexErt27SV2D0lZmWs=;
 b=1s1a115TFEP1DrlJDqN4/IPRyVEJP//LsBSuVUSugCvldJ34+1Mo9w0+qCPEtJIsbklt7reTDvpov7CH7v7v6gp11enDxWblrtK9yJvbxFimeFeGA0AG8DEDcgwc7zrDXNdmgFwRh62AX+cg1QBcyWTQp/cM3uQftXpMSkF6Z+g=
Received: from CY5PR15CA0256.namprd15.prod.outlook.com (2603:10b6:930:66::27)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 12:56:06 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::4e) by CY5PR15CA0256.outlook.office365.com
 (2603:10b6:930:66::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 12:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 12:56:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 6 Nov
 2025 04:56:02 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Nov
 2025 06:56:02 -0600
Received: from [172.31.39.154] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 04:55:50 -0800
Message-ID: <c1b74f44-27eb-4e7c-a2dc-ee48ccfe34a3@amd.com>
Date: Thu, 6 Nov 2025 18:25:49 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/34] sparc64: vdso: Switch to the generic vDSO
 library
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, "Andy
 Lutomirski" <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Vincenzo Frascino" <vincenzo.frascino@arm.com>, Arnd Bergmann
	<arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, "Nick Alcock" <nick.alcock@oracle.com>, John Stultz
	<jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>,
	"Catalin Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
	"Vasily Gorbik" <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Shannon Nelson <sln@onemain.com>
CC: <linux-kernel@vger.kernel.org>, <sparclinux@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
	<linux-mips@vger.kernel.org>, <linux-s390@vger.kernel.org>, Arnd Bergmann
	<arnd@kernel.org>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: sraithal@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a55891a-6f69-4c80-2198-08de1d33d95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azRLNUtMRXJ1bHRwcjMycEZIa1k5TCtTemZreW5HUzQvckNLY1krN1RQVW9s?=
 =?utf-8?B?U2VJQStFbXlHU2hLOWUwMWQ4SXhrVmxkaHhKSkJyRU84WUh1dytzM21GSUVu?=
 =?utf-8?B?SFRtTlRSUll0UmxVMW9NWUw2Q0RmaVlGVHdOb25uYU1XZXlBamZ1bG9zMGp5?=
 =?utf-8?B?eC82QVhjeDVYRDZLanpXS3lNeDdPam9UUGxZOVdBWEZaTjR2ZlpEWUtkSDRX?=
 =?utf-8?B?VVcrbFpBTUxvTmJkT2lpTnVEeUpBOThMcVJuWGRIVWRhUTZrejI3MzFMeVcx?=
 =?utf-8?B?WHRNR1BaazNGVWd1UGgxNVp2OFBVYmZYamlEYXpQQmtoRTZ5Rk9mRTRDMjls?=
 =?utf-8?B?Vmlzb0UyY0tHa3p2bW9JbEorMnJabytjcEszbVdESk1lNDRBL0IvMnRuemgw?=
 =?utf-8?B?Z0ptQzBPV1lSZmNJUXAxU2UxeWlZU1ZFbmxGempoRTMvT1I5SzV6VzVNbVlK?=
 =?utf-8?B?OEhCU0psa2dLaXJYWWJGaUptbEFKcHhOcEFqUDdjMGJuZFdDNUVyNFVaNzhM?=
 =?utf-8?B?TFNoQi9NeWVReW95V1NLQVVuTnRsZzFnUnhTZFpjSFBVMjNhdnlvZVV5aFFw?=
 =?utf-8?B?Y0RmL2s0b2xyOHEyaElISVVoY1RXZmJzU3dXN09GVVc1c0VoQjYrVXJ6dkhN?=
 =?utf-8?B?NldadHVOU0N5QUg3VE5Ca1diTWM1QWhNMWowejNZT1lDZCtVZnM1VnlRd3Iw?=
 =?utf-8?B?WGZ6YWtkSlZnM1JDU2ZhbmVxRDY3RUkrYnhDQWhsRk92ZldBNTU3OSsyRFpy?=
 =?utf-8?B?UmhFenNGQnRmb2JWT3N1YkhMbzEvTVBYaitmdjNLRzZsYkl3R2NmQU5Qb3Uv?=
 =?utf-8?B?YkN5cU5PT045OVljc1Z2TUgvd3BHbThKaDRGRFZlYjZWbVdqSDR1eCtKT2hz?=
 =?utf-8?B?UTlFeFBJc3J6TWR3UEpaRHNYYXU2OFI1bWJKV2RLem4yeWp1bmVoa3dMNUJP?=
 =?utf-8?B?QUk0bVVMcTN5bnlqOWdpRm5XQkZkM3hxVWpzNkxyRFRyelVIR3NpQzFYNUhY?=
 =?utf-8?B?WDBuNTlpVFFNS3hIaUpPNXlRMXBkNnJqOFZWclRtSFo0TE9xVk9XUGc3c2xu?=
 =?utf-8?B?czl0anF2TFRLV2dXeWhRTXJNRXNWL0pFWUdDSkhYWlVuYVQ2MTN2bDBnSzdU?=
 =?utf-8?B?ZmV2RlVDeTRGSUFHcngycXdZeUo4WG5qbndCTVdWZHQ5ZDc1SDJmWnVEZXR1?=
 =?utf-8?B?OCsyVVVGaWp5TDh1b2o5ZGs3aEQ4bkRMb3ZVeXkzQTFBSW8zQ1FVMVRicVJZ?=
 =?utf-8?B?TTduWGlrRnpid281Yk5xQXQyNHJGNndUdE12bjlBa05ZbHBFbVFiQU9lUGdY?=
 =?utf-8?B?a0xCSDF3aWhmY3haZ3BjVnVUbzg3U0tOUHRyTlVlRWxGYWJjVFVKSlRPTmlZ?=
 =?utf-8?B?YzFkMjJwb3dhRVVJK00vbC9na0dkbE5WTEhVU09PT29JcDg0MUw4Ri9UMzNo?=
 =?utf-8?B?eW5yUGFncFpyQS9UVE5iM0NDT0NXMTJ3UkNWQlFUMFhJVVhEWktsd3BsU0J5?=
 =?utf-8?B?M3pDUUxtNjl2UWZCVWR1ek42bnBPUDZVblg0TnQvWHE3V080NDBlaHI5NGMx?=
 =?utf-8?B?NGhNNnVxRUVpRFJHZi9mOThNK21mTlZLU08zdlhodkszVTFuTGNXMWpvTHVm?=
 =?utf-8?B?M0k4eGhPeG45TVczeTg2cUFRd0RUSjVXZE1WSHpsb2R5WDRCdmJTd1ZZS0Uw?=
 =?utf-8?B?MnFSUG5kVDZ3VTVGV2FVQWo1VEM1bjl3UEdoc3k3a0gvRXVuMkVkOURJdDZX?=
 =?utf-8?B?UCszMm12b2dMc293aVBwc25RYm1NUVBDWVE4dzhhbUIzL1kyL2NLV05CSTVI?=
 =?utf-8?B?eWJKUUJZa2dqb0lacDVWbEJZM3Z4Wnk5ZzB4OEV5Q2pqNXNjRngvNmRDN2lV?=
 =?utf-8?B?dHRlOG5HSWlsSmJWSjBzbzJIcWdtL05tN0tiVzVuUHVTcFIvZUJ2TitOQUI0?=
 =?utf-8?B?NWFmbGVDaXNiaUdnSkxEN2lTbFVNMkpMTUp0VlhhaFNNMFoyWHBCaUR2a28z?=
 =?utf-8?B?WTdJdEpjV1FrOXptL1NqaFhsblBFYWU2VHBzeDkyY013MUxuVDRRODl4WnlM?=
 =?utf-8?B?L0V2MG1KSHA0VnhGdTRKMnYxYUNvOEsrT3JLa3I1UG02cC9vaFR5Zmc4eldW?=
 =?utf-8?Q?aa8f76PjUIX6n7lAN6xooVZBM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:56:05.9668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a55891a-6f69-4c80-2198-08de1d33d95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

On 11/6/2025 3:31 PM, Thomas WeiÃschuh wrote:
> The generic vDSO provides a lot common functionality shared between
> different architectures. SPARC is the last architecture not using it,
> preventing some necessary code cleanup.
> 
> Make use of the generic infrastructure.
> 
> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
> 
> SPARC64 can not map .bss into userspace, so the vDSO datapages are
> switched over to be allocated dynamically. This requires changes to the
> s390 and random subsystem vDSO initialization as preparation.
> The random subsystem changes in turn require some cleanup of the vDSO
> headers to not end up as ugly #ifdef mess.
> 
> Tested on a Niagara T4 and QEMU.
> 
> This has a semantic conflict with my series "vdso: Reject absolute
> relocations during build" [0]. The last patch of this series expects all
> users of the generic vDSO library to use the vdsocheck tool.
> This is not the case (yet) for SPARC64. I do have the patches for the
> integration, the specifics will depend on which series is applied first.
> 
> Based on v6.18-rc1.
> 
> [0] https://lore.kernel.org/lkml/20250812-vdso-absolute-reloc-v4-0-61a8b615e5ec@linutronix.de/
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
> Changes in v5:
> - Merge the patches for 'struct page' mapping and dynamic allocation
> - Zero out newly-allocated data pages
> - Pick up review tags
> - Link to v4: https://lore.kernel.org/r/20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de
> 
> Changes in v4:
> - Rebase on v6.18-rc1.
> - Keep inclusion of asm/clocksource.h from linux/clocksource.h
> - Reword description of "s390/time: Set up vDSO datapage later"
> - Link to v3: https://lore.kernel.org/r/20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de
> 
> Changes in v3:
> - Allocate vDSO data pages dynamically (and lots of preparations for that)
> - Drop clock_getres()
> - Fix 32bit clock_gettime() syscall fallback
> - Link to v2: https://lore.kernel.org/r/20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de
> 
> Changes in v2:
> - Rebase on v6.17-rc1
> - Drop RFC state
> - Fix typo in commit message
> - Drop duplicate 'select GENERIC_TIME_VSYSCALL'
> - Merge "sparc64: time: Remove architecture-specific clocksource data" into the
>    main conversion patch. It violated the check in __clocksource_register_scale()
> - Link to v1: https://lore.kernel.org/r/20250724-vdso-sparc64-generic-2-v1-0-e376a3bd24d1@linutronix.de
> 
> ---
> Arnd Bergmann (1):
>        clocksource: remove ARCH_CLOCKSOURCE_DATA
> 
> Thomas Weißschuh (33):
>        selftests: vDSO: vdso_test_correctness: Handle different tv_usec types
>        arm64: vDSO: getrandom: Explicitly include asm/alternative.h
>        arm64: vDSO: gettimeofday: Explicitly include vdso/clocksource.h
>        arm64: vDSO: compat_gettimeofday: Add explicit includes
>        ARM: vdso: gettimeofday: Add explicit includes
>        powerpc/vdso/gettimeofday: Explicitly include vdso/time32.h
>        powerpc/vdso: Explicitly include asm/cputable.h and asm/feature-fixups.h
>        LoongArch: vDSO: Explicitly include asm/vdso/vdso.h
>        MIPS: vdso: Add include guard to asm/vdso/vdso.h
>        MIPS: vdso: Explicitly include asm/vdso/vdso.h
>        random: vDSO: Add explicit includes
>        vdso/gettimeofday: Add explicit includes
>        vdso/helpers: Explicitly include vdso/processor.h
>        vdso/datapage: Remove inclusion of gettimeofday.h
>        vdso/datapage: Trim down unnecessary includes
>        random: vDSO: trim vDSO includes
>        random: vDSO: remove ifdeffery
>        random: vDSO: split out datapage update into helper functions
>        random: vDSO: only access vDSO datapage after random_init()
>        s390/time: Set up vDSO datapage later
>        vdso/datastore: Reduce scope of some variables in vvar_fault()
>        vdso/datastore: Drop inclusion of linux/mmap_lock.h
>        vdso/datastore: Allocate data pages dynamically
>        sparc64: vdso: Link with -z noexecstack
>        sparc64: vdso: Remove obsolete "fake section table" reservation
>        sparc64: vdso: Replace code patching with runtime conditional
>        sparc64: vdso: Move hardware counter read into header
>        sparc64: vdso: Move syscall fallbacks into header
>        sparc64: vdso: Introduce vdso/processor.h
>        sparc64: vdso: Switch to the generic vDSO library
>        sparc64: vdso2c: Drop sym_vvar_start handling
>        sparc64: vdso2c: Remove symbol handling
>        sparc64: vdso: Implement clock_gettime64()
> 
>   arch/arm/include/asm/vdso/gettimeofday.h           |   2 +
>   arch/arm64/include/asm/vdso/compat_gettimeofday.h  |   3 +
>   arch/arm64/include/asm/vdso/gettimeofday.h         |   2 +
>   arch/arm64/kernel/vdso/vgetrandom.c                |   2 +
>   arch/loongarch/kernel/process.c                    |   1 +
>   arch/loongarch/kernel/vdso.c                       |   1 +
>   arch/mips/include/asm/vdso/vdso.h                  |   5 +
>   arch/mips/kernel/vdso.c                            |   1 +
>   arch/powerpc/include/asm/vdso/gettimeofday.h       |   1 +
>   arch/powerpc/include/asm/vdso/processor.h          |   3 +
>   arch/s390/kernel/time.c                            |   4 +-
>   arch/sparc/Kconfig                                 |   3 +-
>   arch/sparc/include/asm/clocksource.h               |   9 -
>   arch/sparc/include/asm/processor.h                 |   3 +
>   arch/sparc/include/asm/processor_32.h              |   2 -
>   arch/sparc/include/asm/processor_64.h              |  25 --
>   arch/sparc/include/asm/vdso.h                      |   2 -
>   arch/sparc/include/asm/vdso/clocksource.h          |  10 +
>   arch/sparc/include/asm/vdso/gettimeofday.h         | 184 ++++++++++
>   arch/sparc/include/asm/vdso/processor.h            |  41 +++
>   arch/sparc/include/asm/vdso/vsyscall.h             |  10 +
>   arch/sparc/include/asm/vvar.h                      |  75 ----
>   arch/sparc/kernel/Makefile                         |   1 -
>   arch/sparc/kernel/time_64.c                        |   6 +-
>   arch/sparc/kernel/vdso.c                           |  69 ----
>   arch/sparc/vdso/Makefile                           |   8 +-
>   arch/sparc/vdso/vclock_gettime.c                   | 380 ++-------------------
>   arch/sparc/vdso/vdso-layout.lds.S                  |  26 +-
>   arch/sparc/vdso/vdso.lds.S                         |   2 -
>   arch/sparc/vdso/vdso2c.c                           |  24 --
>   arch/sparc/vdso/vdso2c.h                           |  45 +--
>   arch/sparc/vdso/vdso32/vdso32.lds.S                |   4 +-
>   arch/sparc/vdso/vma.c                              | 274 +--------------
>   drivers/char/random.c                              |  71 ++--
>   include/linux/clocksource.h                        |   6 +-
>   include/linux/vdso_datastore.h                     |   6 +
>   include/vdso/datapage.h                            |  23 +-
>   include/vdso/helpers.h                             |   1 +
>   init/main.c                                        |   2 +
>   kernel/time/Kconfig                                |   4 -
>   lib/vdso/datastore.c                               |  74 ++--
>   lib/vdso/getrandom.c                               |   3 +
>   lib/vdso/gettimeofday.c                            |  17 +
>   .../testing/selftests/vDSO/vdso_test_correctness.c |   8 +-
>   44 files changed, 449 insertions(+), 994 deletions(-)
> ---
> base-commit: 28b1ac5ccd8d4900a8f53f0e6e84d517a7ccc71f
> change-id: 20250722-vdso-sparc64-generic-2-25f2e058e92c
> 
> Best regards,

The regression [1] v4 series patchset [2] had caused as part of [3]
has been fixed by this series.

Tested-by: Srikanth Aithal <sraithal@amd.com>

[1] 
https://lore.kernel.org/all/977b68ad-6796-4c3d-9c34-d023597f8ab2@amd.com/T/#u
[2] 
https://lore.kernel.org/all/977b68ad-6796-4c3d-9c34-d023597f8ab2@amd.com/T/#m5a310ed22ed9203672b0d0d85ecda0a8fec481c4 
specifically "[PATCH v4 24/35] vdso/datastore: Allocate data pages 
dynamically"
[3] next-20251103, 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

