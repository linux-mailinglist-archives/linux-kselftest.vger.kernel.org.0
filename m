Return-Path: <linux-kselftest+bounces-13605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6592EC98
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6341C223D9
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B82C16CD21;
	Thu, 11 Jul 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wkjjGFTa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793F16CD1A;
	Thu, 11 Jul 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715015; cv=fail; b=lOcwCB9lHxB9VXJQWv/QRX/UHbaejfWRvTZqserzuN5z5cDmtI1dBZDK2KjZFOPD51C7Dy1JExJM5nM6m6wk96E/7ZwvJoO7/WXgYbUDtYcAa97ZVVAGh8ulBPo+bRIvaast6b9YLA5RiIFVS2lWnUTNrwBT0WOTfCz3fg7YBgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715015; c=relaxed/simple;
	bh=P0HKVlR/uvZPexeFNxB/JgmD26P3wZqe8TRkLrJfaCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDZRwFnPo0ALimvUOaaLGeNhaEmE5pBUTDuVTiSJA/ajeEWx8BZ3RcZDGCgdurhMNstw/NDK0nwV7ASB5xkGqZWNVHAo8CjUEJ9xyVf5ul/UvcuRZESZqjnlJEZEbz2s3OydkdAvZjzl+fsJQiCytUnm2QB2+RIwLtHJSrfujHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wkjjGFTa; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDIoEKgP99txb7xOlNjzQBBohl22BTbvaKS46IE1fpMGZV1k8QdxH/RNC0SuDyPEWfAr4x72XL8133PSFUZFC/HOSfYA6E/8eZpCG9+iPRAipguduJmtpHiQKhwVZahHCxVwmLTvIq14Zgar7oaRtYqI72EK9xzVwCVBWkzIQsCZNFkjaH9Gl68Uy3TXm+Ki53Mq6AwQklrsMOi7Nmt8nO/yq+HtLP8iOH8O6vUZBIVDIQCbpVHKenNZ57vfvS8JwYOzmeWZF2FG3JwbT2ouAmqSy5oUkWZewnFoKXoGaOYWCagmYezQJqjZgptn+Vz2pmzR2PUnFw20kZhW2BQoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eHjpEcoJctu/m6KMsvW2SgA0OnEz72J5dtB0/FsXoU=;
 b=WzrR8JQEFyLY8JcQAIkFzthVYZVTTS4J3Vn0opfeGLcnMErAumWze7ez3tA+zrsjK2g0Ud3GTEHCUjnSwjhldZolK7542Idv8Nl1lLTqafW4FhVZ0mrwr3/Yxxq9DnbHqe+Y3aUyb3/ocY/t55oBW0E0ImR5oElTnMGcrELMpEieepExtu1D/lY7PYNcC1ffpESFeJxtgBtonjRdexrOCNWbMNe3vmPjPCLQrcVHZ+Wxa2ogJFD5BqpFoo8CoC6oxEAscgYEOMspMAkSwF9FrCGtzRLg041h8mC4e2pN9eJXJcfRojEsGXVSt/F8LH07k+yZy05gmNTg+MT1BXdgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eHjpEcoJctu/m6KMsvW2SgA0OnEz72J5dtB0/FsXoU=;
 b=wkjjGFTaJkPnuPH7xzNFjZernhT+Hiony9jtoZ+fxrmM/GTcmfHGAByuWj2H2QygkplzbDV2B9scFby6xZx1H0is8rKmZn8i4j/KkaX+0NhS5Zmcl1kUinmBwnXZyq7fapsT6TBXINmqECNQ5u94FBpcBxKSHT5fkqZVBz9V8Uk=
Received: from DS7PR03CA0188.namprd03.prod.outlook.com (2603:10b6:5:3b6::13)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 16:23:26 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::21) by DS7PR03CA0188.outlook.office365.com
 (2603:10b6:5:3b6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 16:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:23:25 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:23:22 -0500
Message-ID: <f76021e4-12bb-405a-9c7e-e8ca990af34d@amd.com>
Date: Thu, 11 Jul 2024 11:23:22 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] selftests: KVM: SEV IOCTL test
To: Peter Gonda <pgonda@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
 <CAMkAt6qxaJwobxesMyg8vssgVDCH+fBLb_vW_vARxAcRFQQQ4g@mail.gmail.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <CAMkAt6qxaJwobxesMyg8vssgVDCH+fBLb_vW_vARxAcRFQQQ4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb1d548-c34d-4c97-b68b-08dca1c5cac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXRkQ0dTcEhFR2Yrblk5ZUZkOElxTUdIY1dNcXNHQUs5bmp5K1N5a1VOUEZY?=
 =?utf-8?B?YmRVZ09zYTNNdDFzdktyN2twQVRYL1BwRW1xVmpidzJxN3NqSEp4RTk3VWFo?=
 =?utf-8?B?cXF2KzR6N24wdEtzSVNRblF3Z2VhY1pJOXh0b2NCYnJmczhwTy9LWjd5eTJp?=
 =?utf-8?B?L0Y4dWdvYmxaTEN0NTJDWXZZdGRld3V1UE5Kb0pMUEIrb2ZRczVxby94K1Jp?=
 =?utf-8?B?RWlCdTgxOG1leW42MnQ2eVkvUTNNWmxpWmplOFR1TUZWZmNVTjdnRXZpWjQz?=
 =?utf-8?B?R0xMMEZvbCtNQU9YZXJuZHlKZXNiZzVsaStWV2d1dFpxN1JRbThBZmphei9v?=
 =?utf-8?B?V3pPdVQxbTZ4NWJxd29nTEcyclB2cDBUVEpQTFdlRnU4UEZYck82dGVORFYy?=
 =?utf-8?B?K0RlWEh4MGlnbUxSczZkTzNJeEViRWt0T3BOUXplZ2k1WnN5bTJoQnY3dk1I?=
 =?utf-8?B?SlYwTThIUllMelQvS0RXa2Z2Y0tHd2o2TzdYUEZuUDAxSmpIWk9SditxcmVn?=
 =?utf-8?B?MTFGZ0htY1huV0ptdmZyNkI2TmJEdkw3YnlVRGJLTEhUS3oxa3FPZDlnRE1i?=
 =?utf-8?B?V1VGeGk2dytSWTcrcXhCNWFmL0Q5VFlmZTVJOUUyQThRQjE3QmdobXNockx6?=
 =?utf-8?B?Z0RtV2MvY0VzN1o2bnI1QTI3TGJ3ZnFLOEZIZExtYnM4eHVveUQzMGVTcFAw?=
 =?utf-8?B?dXNmSlZnSUhwWGRVZi9HdFEzQVljOSsvV3UxSlowL08yVjdPRjczZmNsQTNv?=
 =?utf-8?B?U0I3bmRPcklpcm1zeGkydXRNbE1vM3cxbWN0MUQ5UEQvaXNVK1dBN2tDVVlv?=
 =?utf-8?B?dkdqbTFsVEpmcjhpWGtMVk85ZnlhVEkzTDI0cWxVRCtWaWUxakVQdm1XQm96?=
 =?utf-8?B?dkdFNTExanZ5ZUF5RHVOY0dKYlk0RmlTbDl1WmdSNUVlN3RrWDZYclZKdVdk?=
 =?utf-8?B?VWVBMktQeXdLWVQxWDZuWTFkR1RMdGVPRFlBa1JpUlBrblpwdUtXK09ZN1I1?=
 =?utf-8?B?eGwzaFJKWVBCd2tWYjdqM3luSGlCZVhtaTR3TGxIRm9KN1FSMnVFdGhuZVR3?=
 =?utf-8?B?WkhuRWpralp4V1Y1UjZWaTc0ZTJ3aXJFMGhjdk9aVVdqdHdRMFRzVkJqbEtX?=
 =?utf-8?B?bzJCTXN1dDFzWXVJcS9jbzUzRnFMS3Ezb24vNm1wZ0tjYUwvUjR0MmpzM3Bh?=
 =?utf-8?B?bkVqdzNCSHA0Z09DalBRYmY3NE9EdGxjeTI1RUpTUkMrYWhZUUsvM1FtY3Bv?=
 =?utf-8?B?NjZnSFhJTUc5bkpMeE1SK2M2TzVIWGhWN2tCZ1h1UDJDWVpiaE1keVIrYnNO?=
 =?utf-8?B?WjI4bzhDNHkzWTUzbWFVNCt4V21XKzRvdzZHLzc5WjVFTWtNN0FNaDdSOVdu?=
 =?utf-8?B?cnliQjBhMyt1S1pjSjJndmpUbEZTQXkvUVpNSnRKOEhWNnNhVTkzcU5HbWcv?=
 =?utf-8?B?SGpmQmRqaVR6TlRqdDM3OElVcCttSEVOZDBwdVRLZ2YvbFpBaGtRZUFCR0hK?=
 =?utf-8?B?SUg3U0x2NEo1ZkNMVDdXV0taTGhyOTlwVUxNV3VpOWZBd0xUTHlBYXV2a3l6?=
 =?utf-8?B?NXRNUXJlUUJvSDgvN0xRdDNGVVQyQnB2bDhvZUw1b2lucWJIdlZYSm9KUWxs?=
 =?utf-8?B?WjcxTSs3WWM1VGNpZHc4MHhMRExrOW5wMVpIOHBEaEVNUjV1QlJWbnpYRDhx?=
 =?utf-8?B?NXZGSGQwQTYyQ1p5bVZDNFJpaXEvd1lLaXZKUHF1Z2I5M1J0VTlldGtmZ2VX?=
 =?utf-8?B?c2VEd0VrbjhOMGk3a05yaW50WnZLWTJuTjFVTEdCZDhiNkU1UVkweVpleEZw?=
 =?utf-8?B?TkN5LzFDaFpleWFVdzkzckkvZlZ6cEt1eHJ2ODJIWlphejB2QmZZTExzQ0Rw?=
 =?utf-8?B?UFIrTTJSejNMN1JycTBkYjFtMHhyckNVbnQ4ci9OSjZsbkVwY0IyN2ZGN1Bz?=
 =?utf-8?Q?m+yvoxA77q0XNniq8p/1ukPt7TYlUj6F?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:23:25.8848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb1d548-c34d-4c97-b68b-08dca1c5cac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197



On 7/11/2024 10:23 AM, Peter Gonda wrote:
>> +
>> +static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_vm *vm;
>> +       struct ucall uc;
>> +       bool cond;
>> +       int ret;
>> +
>> +       vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>> +       ret = sev_vm_launch_start(vm, 0);
>> +       cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +       TEST_ASSERT(cond,
>> +                   "KVM_SEV_LAUNCH_START should fail, invalid policy.");
>> +
>> +       ret = sev_vm_launch_update(vm, policy);
>> +       cond = type == KVM_X86_SEV_VM ? !ret : ret;
>> +       TEST_ASSERT(cond,
>> +                   "KVM_SEV_LAUNCH_UPDATE should fail, invalid policy.");
> 
> Isn't the reason we expect all other calls to fail here because we
> have not successfully called `sev_vm_launch_start()`?
> 

Yes you're right. The idea is that none of the consequent "good" ioctl
calls should succeed if the vm_launch_start was faulty.

>> +       sev_guest_status_assert(vm, type);
>> +
>> +       ret = sev_vm_launch_measure(vm, alloca(256));
> 
> Should we free this buffer?

Sure, I should store this into a pointer and free it.

I guess this also happens within vm_sev_launch() where we should include
a free as well.

Thanks for catching this!

