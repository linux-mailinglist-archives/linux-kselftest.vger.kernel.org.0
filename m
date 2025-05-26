Return-Path: <linux-kselftest+bounces-33764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FDAC383C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 05:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F655188F537
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 03:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6240B1917D0;
	Mon, 26 May 2025 03:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rG+8xNaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9948195811;
	Mon, 26 May 2025 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748230615; cv=fail; b=BduhRSKNFXB4gvM2pCS2hnntZBCsGqdVsif0tbhgC8yxcJ9zM5PjhtQ07K5PugKTab1lThtuR9+VyduxCgcvhzpqbA27mh1tIX/7AeQKKrY5iKBbPa8Texen2rf8+qgvzx02nWOQYZ1tCt/dZbmvFW/W2V0e6ZHFwYkGe3btsLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748230615; c=relaxed/simple;
	bh=gBikVCO8qyAuPJ8AQNllBoODkE5DywT1gzjCfjVBVVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cCfSm3rZbmGg01ATdVAruQdF40at+8xLjuWP6na34tn+VDqtaTpebHyyWAbS6U9a7dzSTcSF81N2K9nqvarZ2Nwfv8DCNDJV8mIvm+Cfk3e1jD3vf0zfb07MJLUJiAYKndskJRu5gzPEiHmQlG6H9+6dcQi8fANAbKoRDnKTW+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rG+8xNaa; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyOutsl0JWDdUi3VF7Fbf6XYNd983YSiFIUvcFbSIxsKWZ4E6PtF+PVkPMa+ox7yk8Af/jYb3/UIcjv7IPJJJQfpjEaGN8z3GwksmThm2mDxJEnchROPa2UJ5JY4XZpWum38F2Vhc+r/fb52x97T84egFUubcPHej6YBun/lkC8WGqFMi3fzIJuW/set3BJapPWeOatbCEyfy2CBc+lTUF3mEydLN9kUsyJurUXCmRY+k0X4GNeb5ry6D6UrZ6PRfBqOanMSfmqJPiMY77UfMBfBPn7EuTHhxEhJ+l5oPjInk4t7lW4OxcQNT6N3O0sUypGc0vrPIeShI1ESgu9Leg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcW/L6v+m+CrfjHxmtlsRoH+9g7AQSR4jQVgl1NCXok=;
 b=YWI93GBpJHbad4AzFVb6m92G5KJiIgT/GGpN4+agPRR/zGkGHnZfCvsLblFJcStwqyqcLQLv7Q2vgDDWjbjXW12wGI4oR0ER3zgmpimtKDw+BQFUECeaUA4wqRxhvOjzRrYnTGQkEQz+8Pg0U/tl0zrosiCL6QiMoEJBQp6o/3FE4khYJlvWkVDaVPW4Ag2mGcPAe44i06tnikyagiOqGVRLWIazAD0Vfpjla9hCErNEBLDc44T6VsBFZhor4dJZnRBGrdguCJQRowXe/FvBJ1+s6SebKKQ4yeCnPgfrwKhwNZrBVBiEZxfB6QEJEQMNytCfkVcus3Y4IVR9zuhffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcW/L6v+m+CrfjHxmtlsRoH+9g7AQSR4jQVgl1NCXok=;
 b=rG+8xNaa9F+5+WBOHbfSXgrc2X6ucBKfObO64gzRjAaLgcg5FEHYT82PL2sjILB1KLX9iS+JkPN5zxYguN6RWEy6PGe3h9Xk6ruVUktZ5d8g/WeBJtS2BLWAi1G40SbRM5nW4Mz6Bqk0pUGjUGFaYMGbb4OFTPjS+aMlshLEyyA=
Received: from MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::13)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 03:36:48 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::91) by MW4P222CA0008.outlook.office365.com
 (2603:10b6:303:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Mon,
 26 May 2025 03:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 26 May 2025 03:36:47 +0000
Received: from [10.85.47.107] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 22:36:36 -0500
Message-ID: <432193cf-e4bd-4cfb-a146-25b19c02d78e@amd.com>
Date: Mon, 26 May 2025 09:06:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/13] KVM: selftests: Add a KVM_IRQFD test to verify
 uniqueness requirements
To: Sean Christopherson <seanjc@google.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Shuah
 Khan" <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton
	<oliver.upton@linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-hyperv@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>, "K Prateek
 Nayak" <kprateek.nayak@amd.com>, David Matlack <dmatlack@google.com>
References: <20250522235223.3178519-1-seanjc@google.com>
 <20250522235223.3178519-14-seanjc@google.com>
 <2c52daad-0b64-48a9-8e73-d1aba977993b@amd.com> <aDB-2lcq4jJm9-OV@google.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <aDB-2lcq4jJm9-OV@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 93188829-a743-42d1-a849-08dd9c068b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0EralROS043WjhCbHFOZ2lydDZJaGFDRUdGR3JxZVVwT3FYbTZJOUdvZGhZ?=
 =?utf-8?B?YktPQXg5Zy9EMXcwMzFHaFNFOVBPc0UxUHBiUFlIeThjRmVaSW5IbDNKekpI?=
 =?utf-8?B?bWFnbTR5VXZ6WEVoTUFRcWN2alVDbHlKRU9BRzA4bEU2Qlp5aXZZcVl4cTgx?=
 =?utf-8?B?UHFqYm9Wbkx6ak9oWGpMRldMbmxsdy9OQ3ZxWVN6cTFSK2dmdy9pMFlHYVU5?=
 =?utf-8?B?MnNUWHZRRFNYNXRhR3o4blBQbksxM1FkN2dqL0hjdHhpRE9oTkRwRmFKY1Na?=
 =?utf-8?B?bUN6NG04UlBxM0tZczJqSEVOZ0FSNW44NFNLTWZMTDFCbERJQklhWnVvalFK?=
 =?utf-8?B?RDJsOXMxL2txVWl5cGJqdFU1OEwwSGU2eGtWaVNweWdJWVRscWFsNDQyNFdL?=
 =?utf-8?B?QTZBYW5Fd1RyY3pENHYzNmJsME0xOU5XOGovNmNkWmlkaDRIME5ncEFJQ0Fh?=
 =?utf-8?B?N2MwT2JydW15VWFOQ255VGxxNXhiM2FxSnFFRzl6dVo3UEo4bGRnS3ZzbnFq?=
 =?utf-8?B?SERiUGZpQnJndmRmbGc3eko5aFFhNGozUUI3d1U4TkorOHlpSFp3USs1NnZU?=
 =?utf-8?B?TjNJTnVTYVhlR0dnRWQzODlNQWQxTk4vWTgvVjI5Vm5pTnJEam5mOHdBWVdK?=
 =?utf-8?B?akE4MlVqRzM5R2UxTUZMSjFZbVA2T2hWQ1VHVHVkaC9mWWlldXFEdCs3NTk5?=
 =?utf-8?B?Mkd4Z21aSXViUG92ZHJaUkZxeHlteFcyNnRiTEZEd2F6QWhURS9ESkNFbmlB?=
 =?utf-8?B?N2FZT0tnTmZkdzU0eDFoSzhHbS8ydHJsWmRTN3FWdGlOVUhVa09ydSt5N3Fm?=
 =?utf-8?B?UjIvZnpVYkluSVVUdENzMzE2ZGdtd1I5WHZ1bmIxSGNtRzhLaElWc1JWZjFt?=
 =?utf-8?B?VW14b3dOVDMxU1B2bnQ3d0RBam5mcWwwUzdCRkZjWFJHUk1tTEN6aE9TTFhI?=
 =?utf-8?B?OVUvUzg2d2N1QjZGdjI0QkxFMzZDTEZOanYxQWdJcURDT3J4bnFZVkxhajht?=
 =?utf-8?B?dEF0cEs4SUhyRVNyVTErZzRqRS91ZXU2d2pDd3B4L0tJN2VBMEV6cDlidGJX?=
 =?utf-8?B?NkhxQnM3dDAyQnNpVDhqTVM3Ly9QS25NMWtUa3IvbE0vM2pVMmlrOHFPampn?=
 =?utf-8?B?LythNmVYUDN4ajFQWmdjbXpMbzdDUW1mUWpJb0E2aGdTc2dLZkNTdXU2MlBD?=
 =?utf-8?B?TnFLakZzWUlROWJNWDRXL3Rsb0dDYWhzcTFIQ0pPakp6VEVkWWNub1A0dFpP?=
 =?utf-8?B?MTRKSk1LRkYvYnJYb2gvTjRDbkx3ZFRqL3BtdUtoeUZmcFh2ZHBRMlJWSkRF?=
 =?utf-8?B?R0xVOEVEU1crVEJlV0ZzVlFTcWtCQmt0NWpHdnp6S2JmN3hacmgvMG5jOS9E?=
 =?utf-8?B?RWg3ZjhNMy9CRjhCS1Z4VGppKzdoYzdjbVhJREJ5ZGZobUFGTUtPVEFWZVUv?=
 =?utf-8?B?OVhySWhOVzBORXdmajJxK25TWE5JWnlxb05IRUVkcGt3RElRek1ycStzbFFG?=
 =?utf-8?B?NkFkTi8zb29TYUd1bGVWdXdtTENaQUFKOHpka0JSaUF0NVZZU2ZwVE9OM2M4?=
 =?utf-8?B?UGVRWHdTWE5KNis4STd1Mm9pU0FjUU9MUnBPT3l0cnpPTTRLaGY1dXZEL0Qx?=
 =?utf-8?B?czNURXVwUkFKS0JoMzFOalo5VzVNU3VYVHFtQnFSVkxzbGdicndNbU03dDla?=
 =?utf-8?B?TnRReVQ3eFM2dysxNThZWUgwZU9YUWRKNjFRb3RMMFNLdWdqUDFGcDAyS0VN?=
 =?utf-8?B?NldMbW5sWXNwb1JGYmxmd2lBUS9SRUZTNDdiT0l5MWtpc3YxaDFIdUdnQTFM?=
 =?utf-8?B?dmFtWEtaVEhtdUxjMjFCZU5rSXpCMFBUREJQdytINW5BN3dWT1NhT3FrQnMr?=
 =?utf-8?B?dGgvQThnVmJsd1VnVnIzRy83NlQ1bUdDWStmaVRoczk2WnhXSk9HZVFVcGQ4?=
 =?utf-8?B?WFhOL3FiZUxsck5KZ2lObjZTNXlIcWM3ajgzd3IzU1pUVmNqeVpzTUduYm16?=
 =?utf-8?B?bnNhWnJORGlUcVRZNGNuV21vbEFqYkl2Y2huT2dxTkwyYWIvbmQ3VktodCtF?=
 =?utf-8?Q?nSkLAd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 03:36:47.8886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93188829-a743-42d1-a849-08dd9c068b78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049



On 5/23/2025 8:03 PM, Sean Christopherson wrote:
> On Fri, May 23, 2025, Sairaj Kodilkar wrote:
>> On 5/23/2025 5:22 AM, Sean Christopherson wrote:
>>
>>> +
>>> +int main(int argc, char *argv[])
>>> +{
>>> +	pthread_t racing_thread;
>>> +	int r, i;
>>> +
>>> +	/* Create "full" VMs, as KVM_IRQFD requires an in-kernel IRQ chip. */
>>> +	vm1 = vm_create(1);
>>> +	vm2 = vm_create(1);
>>> +
>>> +	WRITE_ONCE(__eventfd, kvm_new_eventfd());
>>> +
>>> +	kvm_irqfd(vm1, 10, __eventfd, 0);
>>> +
>>> +	r = __kvm_irqfd(vm1, 11, __eventfd, 0);
>>> +	TEST_ASSERT(r && errno == EBUSY,
>>> +		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
>>> +
>>> +	r = __kvm_irqfd(vm2, 12, __eventfd, 0);
>>> +	TEST_ASSERT(r && errno == EBUSY,
>>> +		    "Wanted EBUSY, r = %d, errno = %d", r, errno);
>>> +
>>> +	kvm_irqfd(vm1, 11, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
>>> +	kvm_irqfd(vm1, 12, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
>>> +	kvm_irqfd(vm1, 13, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
>>> +	kvm_irqfd(vm1, 14, READ_ONCE(__eventfd), KVM_IRQFD_FLAG_DEASSIGN);
>>
>> Hi Sean,
>> I dont see any allocation for the GSI 13 and 14..
>> Is there any reason for the deassigning these two GSIs ?
> 
> Yes, KVM's rather bizarre ABI is that DEASSIGN is allowed even if the VM doesn't
> have a corresponding assigned irqfd.  The reason I added these early DEASSIGN
> calls is so that there will be an easier-to-debug failure if KVM's behavior
> changes (the racing threads part of the test abuses KVM's ABI).  I didn't add a
> comment because the helpers already have comments, but looking at this again, I
> agree that main() needs a better comment.

Makes sense, thanks for the explanation.

Thanks
Sairaj Kodilkar


