Return-Path: <linux-kselftest+bounces-20310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6F29A9111
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE511C21136
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD81FDFA0;
	Mon, 21 Oct 2024 20:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rj1Up3zD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA01FDF8D;
	Mon, 21 Oct 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542233; cv=fail; b=dd5gbuJz2UpgFOcQv/o9svB/OJl7RtWAl9v8p5W1c+lEVWMRVoUL9bJfyM1fkC/WJ+dIu7IC0mqf6K9Pcw+lD1xlGJeTt6glJbseHMNAt9chKWUEW5N2Ytg/KtQaBPOfLtdh1qCNpGlFrV30LS2nK2sSmukj2y4mYCVgET6zNJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542233; c=relaxed/simple;
	bh=h7PNcKqUPDSVjsDazIEl71hKLPlWtYdrAf2mtBgqz4k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=tOYIPejVteQThj7aHJyOfWrhhgS95bya3S+6o8YT7WkOC3xrGtsR4Jd99MVD1TY2OSJRDBDK0b9ZmvXXRyLmW+cVoIKik/pUmBYdS1V3V0W4mDRRgT6t/piaGi41n8v4n0GShgj6saNNOiMQXb93xM6BS+95kutnynmerHzuic4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rj1Up3zD; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIeGIjAQgiQ44eBcInbeAwAzLq1BxNlThoP98g6enkXeMaxgL+74M+GrMbOEO7IfqTTnXBHLGcBhU1o2xC9zN3FoTWxfXsDKQIUiDV5hGs209i2B+udycxAgFHJjHS0Wa3GKM3X5Bk7Szx1tAWp59k32vBBdvwercsnAjrvMcTtCb63hWQlzApaESwaL9aN5oGA9/Vbhm7HsGwZ1vCUKIFi09kKKOPnzIp4RDBqrQZrnr1EFagLXgxhepyoADDlkD+jSrhnLo49UvRrSnVXij4Tehvacw+i//IfQvjZ5Qxlpy4XKsLJJKomsq73YcEymGa9ACt/uj5NlkN+Gqu+ZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBm3X5tIcqpNeFVcllGYrprhj9i92HaOLCa8s3MqPww=;
 b=yJv+SPhubMxrCkdaV76aL+VEGUQcvVNdV2lvXt6qgqJDjRrOdndunm1C16HeRsn1SNOd7CQBWOS5YtACQgyetr2/mZ9K/TbW3w8Fs9x4EjWwuWzvle1pOu1RHBsc+rPldXDYPHlRfK3Zr/URxi4b9YCmSv+3a3RLWd4tSPgnXsVz0d6N9SJMcSwfQt0OmmwR5udKqR0auUbpA2GpY3wUjzckfs6qIuYgA/qpQTVv8FLUj5Wb/OEGsPonaOasmIC1ioEHADjQXQzq4tqDqkfVKSqOu1kfhNIskm2Kt8uGzBIDpu+F7ORfMDuwPwpicQ/Lp/WeNXOnM4hrYnbwtpWDVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBm3X5tIcqpNeFVcllGYrprhj9i92HaOLCa8s3MqPww=;
 b=Rj1Up3zDjwLooB8NdHO1pcks64msVeHLuNnPppTwUoOe6SJotco4gQMXm9n05nsNI5vIR/MQ48WnEJ1g+SMnrKh+/0BoSoGAuTTHrt3wbRF8z0STi4XXhf2r+hx/KSIDFd3mOMgo/18rygbGYCfERTlsmh2P+KmLtfF37PRq0RA=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 20:23:48 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::f5) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 20:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 20:23:48 +0000
Received: from [10.236.186.64] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 15:23:46 -0500
Message-ID: <93a2ebee-5d60-4f3d-94cb-62cac6b4b80a@amd.com>
Date: Mon, 21 Oct 2024 15:23:41 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Subject: Re: [PATCH v3 7/9] KVM: selftests: Add interface to manually flag
 protected/encrypted ranges
To: Sean Christopherson <seanjc@google.com>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <pgonda@google.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240905124107.6954-1-pratikrajesh.sampat@amd.com>
 <20240905124107.6954-8-pratikrajesh.sampat@amd.com>
 <Zw2iM0tVmwy-8nPe@google.com>
Content-Language: en-US
In-Reply-To: <Zw2iM0tVmwy-8nPe@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ad434c-d2e4-40c9-049e-08dcf20e4525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlphNkJPQzNSMzl5SzVqTG55ZFh1aDRISnM5eEdOcDlUZkx4VlltcEJleWx1?=
 =?utf-8?B?RmduUGhyTE8vUUtSd0h3NDRpZEJkUjRibEVIdzNYU0dkWVBLSWJWclBPdWZQ?=
 =?utf-8?B?TGNJdC8wcUptVG5DS29IR1ZDdlpvR1ZuNWM0OTZhckRFNnplbXhwbFJOYVlS?=
 =?utf-8?B?L0tPUFRaL1hULzVudCtzS3l4TjBMR1pXRGJCWGR1aDArS0drcUNzUDRXaGtF?=
 =?utf-8?B?QUFyc2hZekJjb0FacFBNdW5xMFRSQWkyRTB0YWxGZUk2OHUyME8rWGhkbFpn?=
 =?utf-8?B?NWJOcjc4dStQbXZmNytYMjVnbFg1Um9DNnhsNXp3TGo2NDNCWTBIOTNYZWdi?=
 =?utf-8?B?ZEhnZEVVNFdUNjcvUXRCRnhUaFk2b1pLQXpLd09sa1RLUExJYnRPVjJtNEU1?=
 =?utf-8?B?ZHhrODZSZVhnNWtmQ1Y3T21NRm1ZUVRVRlNpcUFGeEM5a1hNTmxwQ3BhNU9C?=
 =?utf-8?B?akhNY3hZZlBBMXljK3JUVVh4QnBlMnE3VHdyQUhiUm55Y3hQT1FTMDJrZG1r?=
 =?utf-8?B?VWhOZW00L1RtSXNxRjUrWnZJTXh3YWc4NkZvb21HNFBwYXBqT21qUDNZVHYy?=
 =?utf-8?B?SnZBWlBZWHI2blZnUXRqajZJcnlmbDVEUVU5LzRrQTZsZ0pQR0pETnNXUS9T?=
 =?utf-8?B?OWRxbEE4alNOZFFDSjZBVmtacDlPRUd1WGs2VWRIMzZEQmhtNm8zQXZ5ZkNO?=
 =?utf-8?B?MURkL3BMQ1QydTRwaVJqZXNKcElxeElhZ2NEUG0wY01nWUNjMEFsT0RqSHhB?=
 =?utf-8?B?aE0vRlF6RnlnV0IxRnR2ZXRRa2RScE9Nb2hxbi9hdGJ6V1hIWTRKblJoeVhQ?=
 =?utf-8?B?RER2MS9lekZwNWhNZmU5WlQrUVlpR3FlSmJld1FsaXdwOUl3TWdTemFtcGRK?=
 =?utf-8?B?MTlXMnFIT25ObEg4S0dPUEtVN1RPVVJHdnFDUE1BS05QWXJ0VzR5bm12VzdS?=
 =?utf-8?B?eGpMU1N6bHN0MDJad0xXbHRkSytLcVMwSVlrd0tsQTRiTWc4UjFQUkRtOFQw?=
 =?utf-8?B?NXlHKzMwQUc2Tm1NR21jZ0RuYzhFWTZIS3VlUXg2V1VqbEhoS01Hc2xNME4r?=
 =?utf-8?B?b1lWbTh1VU1LcGVmczc5akNGVFJsd05CTStYZzB3K3ptU2d2Wm94SUViMitl?=
 =?utf-8?B?T1NLM3hOalJrdGhpUDh5YXZDQUszbVd3c1RYb0NmbThkUmY2YTVkZ2dWZ0VZ?=
 =?utf-8?B?TUZsd3VmTkl1TzI4Sm5OZU53OG5jMmlxbjNpbG5heXRkMk5rUTVid2VPc1Fn?=
 =?utf-8?B?TnFOa0JSanM2MGZlSVJlZVZKcnVRdkdLQzUwMERSY2FJbmdvRXdoNXptS1Jt?=
 =?utf-8?B?MWc4Rm5aQ0VhZCtoME5aSmRyR29IWTNHRk1rZk40QVRSKzdWdk5VY3VCMjZy?=
 =?utf-8?B?UjVnSHE3enhESXlPQWVEbEptRnJMN3JhZ2dRa2s3dEg4ZGdqNlJFTW5Sc3d5?=
 =?utf-8?B?L09lajBFaDRLbUxlSFpEbTZUMzhnM1JuYjdFaGNYV01wRDllQlV1RHhvYTZp?=
 =?utf-8?B?UzJhYlhxV2Z6eG1GWFZqNWhEYnV2TFZrdUxqYmhoeXhoOThjRVNOb3BOdFV3?=
 =?utf-8?B?bVBNNGl1YXlnZWpCa29LRG56cjR2eWxQbnphVnR0c2dxT3J2Sy9Yb2NJWDdJ?=
 =?utf-8?B?MS9IYnNVbWhNb2V6aE1WcXNWVGJOK2hyN0hBeDRSZ3BFZWQzTXNGWWRMVXNV?=
 =?utf-8?B?RnZRUDdIc3FTaithd3ZWVU9nTDY4a0xWNi9OcWk0blNvaDBzK1NZVXRuUGRS?=
 =?utf-8?B?cm5sRGRVR3hjd2JScmE5L2RRVjkzbnhTek5mcFhrVlV4b284YndKRUhXdDNj?=
 =?utf-8?B?N3lPSVVWVkVFSHhXcEU2NlEzU3JsamRHSXI0T2hsREdUTkVHVGJ1dm5HOWN0?=
 =?utf-8?B?a0FPNGFrZmlhejVOc2ZnTHl6eVlUTVFjci9nakVodisyaVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:23:48.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ad434c-d2e4-40c9-049e-08dcf20e4525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

Hi Sean,

On 10/14/2024 5:58 PM, Sean Christopherson wrote:
> On Thu, Sep 05, 2024, Pratik R. Sampat wrote:
>> From: Michael Roth <michael.roth@amd.com>
>>
>> For SEV and SNP, currently __vm_phy_pages_alloc() handles setting the
>> region->protected_phy_pages bitmap to mark that the region needs to be
>> encrypted/measured into the initial guest state prior to
> 
> Nothing needs to be measured, no?  (because there's no attestation)
> 

Right.

>> finalizing/starting the guest. It also marks what GPAs need to be mapped
>> as encrypted in the initial guest page table.
> 
> ...
> 
>>  static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
>>  				      uint64_t size)
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index bbf90ad224da..d44a37aebcec 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1991,6 +1991,43 @@ const char *exit_reason_str(unsigned int exit_reason)
>>  	return "Unknown";
>>  }
>>  
>> +/*
>> + * Set what guest GFNs need to be encrypted prior to finalizing a CoCo VM.
>> + *
>> + * Input Args:
>> + *   vm - Virtual Machine
>> + *   memslot - Memory region to allocate page from
>> + *   paddr - Start of physical address to mark as encrypted
>> + *   num - number of pages
>> + *
>> + * Output Args: None
>> + *
>> + * Return: None
>> + *
>> + * Generally __vm_phy_pages_alloc() will handle this automatically, but
>> + * for cases where the test handles managing the physical allocation and
>> + * mapping directly this interface should be used to mark physical pages
>> + * that are intended to be encrypted as part of the initial guest state.
>> + * This will also affect whether virt_map()/virt_pg_map() will map the
>> + * page as encrypted or not in the initial guest page table.
>> + *
>> + * If the initial guest state has already been finalized, then setting
>> + * it as encrypted will essentially be a noop since nothing more can be
>> + * encrypted into the initial guest state at that point.
>> + */
>> +void vm_mem_set_protected(struct kvm_vm *vm, uint32_t memslot,
>> +			  vm_paddr_t paddr, size_t num)
>> +{
>> +	struct userspace_mem_region *region;
>> +	sparsebit_idx_t pg, base;
>> +
>> +	base = paddr >> vm->page_shift;
>> +	region = memslot2region(vm, memslot);
> 
> Please no, doing a memslot lookup in a helper like this is only going to encourage
> proliferation of bad code.  vm_mem_add() really should be able to mark the region
> as protected.
> 
> E.g. practically speaking, the only code that will be able to use this helper is
> code that is marking the entire memslot as protection.  And ability to _clear_
> the protected_phy_pages bit is conspicuously missing.
> 

From my understanding, vm_mem_add() only allocates the protected
sparsebits but does not populate them. For that maybe a better path
would be to go through, vm_phy_pages_alloc() - something similar to how
the set_memory_region_test.c does? I think we avoided doing that because
vm_phys_pages_alloc() takes a paddr_min rather than guaranteeing the
specific paddr and even then would need the similar virt_map() logic to
stay. If this is a cleaner approach though, I'm happy to redo this code
that way.

Thanks!
Pratik

>> +
>> +	for (pg = base; pg < base + num; ++pg)
>> +		sparsebit_set(region->protected_phy_pages, pg);
>> +}


