Return-Path: <linux-kselftest+bounces-36086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1169AED463
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 08:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EDD1891A9D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 06:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A21AA1DB;
	Mon, 30 Jun 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbh2xKHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104417BD3;
	Mon, 30 Jun 2025 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264301; cv=fail; b=oSLyKIcgAw6gmPoNZM6cVitdo7NbvjgeMhv2DOYoB4Nlxmhn7N7Z/54LiZLW5KOO0j1d8B8i6XpudGygAZCndsrEIj2Clgi33AuNilZRDKO7MQbEnvLgb2rt0pkbcsy47vEZqg3h7oW+BlJvt5vxNyDeHcBzZ9DR+L+oyKPi50E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264301; c=relaxed/simple;
	bh=DlWegF9TlJz9gcP5bKm5NVBM7UtpPLNmdPmNdvleeyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aHystE4W/VOlg/0Yz5Cf+COVuMYfCFoYT5+aoq/tFpNsVLZ4GeEm2Dj1+RAWGi0lpz1AnKAuM23cO94hTe2WL0f73ej8yoV4dCcvwQZNPvRz1rMt9tMGXpRRnpmb4i1/UxqBEI4efuFtq8gdtjizUvGXIaJghDoAICdB/iGloUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbh2xKHq; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqILkA4V/1p89exW95l3IFVMgd0q3QHCiVaO9pw+6vEml79bAWunsmgGa7K6TdBNEoJvfC1wk+6QXkE7zcD1HFbYRwHE6uLsJ0OQioVLlrDYDnc1Byftg8deGWyol3+aguxTr9CQJDugdlfjbvU1SjVXHK5gP5ymuVuvorQ3XhPltKXrYVGsKzDiC8/MFxfbyPmL1MH2wd15IZyYOt+mPC4Q3OuI+etRF5D5JCWWOVvJSxF7Ma6Gimyrkd/ZGzFWxIfSoEDh2MYCEXgpEevHnCZKhr45GYp4nJZoxsznLvyfDxUoTwtr6cpxVN+asXY1upbhzLjkCUj1I/+iZinnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBbT1EJx3gXqHfaCyA4n6Sa0wFrHXKVqBn6ZCRwH+ro=;
 b=ECP8bfFOGjaDSQM5QkgvE5mkeaf8LXfvkQuP85oV3KH5O4AGmNW1fLTHspeBaYk99G4/JptzZQ8oHERkPkx2jJ+Ov/5P2ylIpXWvpBWXjzP6zFOJBIZos7/1I+cNoEt7nq8EWFzO60Lu3wdpIqa7SfUv3ZlwbN5skPc+zLxgB+oJlHn+8ytt2xZDudtyxpHRzXI0VcR0G2L+t2z46DoHCdyTmcSRX5dPQV1bgwSqRIfNKhpDvEqC5ibiPJ06ZPYRsQEr4ke7O+IWlhtugV9cQti7CJtKrXnarX/0SAk6kIVGYV7CjvuJERNl8Epz0Dw0S5n8LFft23GIJsKa7kbgBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBbT1EJx3gXqHfaCyA4n6Sa0wFrHXKVqBn6ZCRwH+ro=;
 b=gbh2xKHqJ63W7qlZWYJM5d2kgAep2E4/7sJBPXEV9nDZdovHvEe9aNWnjr/okrEPai8dLbHDwn4TVWr6qs2WLws2VqG06pZQXgidDyuOPhHfYCSifxNRaF8QbNfea4cp3F6P9UshIOY5NRzaPO9vc0MxFnHR823jHI2658gw/dE=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by IA0PPFAF883AE17.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 30 Jun
 2025 06:18:16 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::43) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.28 via Frontend Transport; Mon,
 30 Jun 2025 06:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 06:18:15 +0000
Received: from [10.85.36.84] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 01:18:02 -0500
Message-ID: <d112f9fd-5ccc-4b77-a670-4a2f3a443dbe@amd.com>
Date: Mon, 30 Jun 2025 11:48:00 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
To: David Matlack <dmatlack@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Aaron Lewis
	<aaronlewis@google.com>, Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>, Andrew Jones
	<ajones@ventanamicro.com>, Ard Biesheuvel <ardb@kernel.org>, "Arnaldo
 Carvalho de Melo" <acme@redhat.com>, Bibo Mao <maobibo@loongson.cn>, Claudio
 Imbrenda <imbrenda@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, James Houghton <jthoughton@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Joel Granados <joel.granados@kernel.org>, "Josh
 Hilke" <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, Wei Yang
	<richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-4-dmatlack@google.com>
 <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com>
 <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
 <CALzav=fZcLpQ+9J=XOZ-=Cr1UA8qKa5NHXB1dJpqhCp7pee7Ow@mail.gmail.com>
 <62734f4d-8883-4145-a483-5bf2c462fad5@amd.com>
 <CALzav=eYD85ydnpAwYsTArDHbxOLd+D-BtYWaiYQxeJ1tGGp7A@mail.gmail.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <CALzav=eYD85ydnpAwYsTArDHbxOLd+D-BtYWaiYQxeJ1tGGp7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|IA0PPFAF883AE17:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b024be-c56d-4b8c-b393-08ddb79de5fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NThtdERWQnlRS2FrVWl1aG5vZm13VWNBU0hjNEN0YzN5ZEtNSWMzL09PWXcr?=
 =?utf-8?B?ZWdJdDBZQXNZc2VDVXl5NzdlUS9OSC85aG5ZSHJNM2d5U0hIaGxXTjYxbXo1?=
 =?utf-8?B?M3RySy84WEc4QlNTb0h1RERrV1l0YytjUXVxeDVmS0k2SXB0RExBWmg4VDEw?=
 =?utf-8?B?TUszV0I1dVVLcHlHTFhZMWM0M29uK0Y2QWlyN1hIMVZGZDFISDh2QS85TjBu?=
 =?utf-8?B?MExEZE51cGQ4Ty9pNXJpZVdYL21GUTBuNitBVUxJaGM3WWh1Sk1HL09WYS9r?=
 =?utf-8?B?R05LcWdnMHlSQ0ZUekZCQnMwcmFpeEtZalBJUDRBS1hTZmtuQXN5VEFhOW5s?=
 =?utf-8?B?SU1HaFp1aWp1cXkrRWN3anZmT3cwZytobWhqcThLZ3pLd2l1R3I3SmthOTFK?=
 =?utf-8?B?dFRpV2d6Y056dWtwSHcrUkliSTVpQ3QrV0dVcHBSZ1NQM1hiaVlzdVJPSnov?=
 =?utf-8?B?MlBNZXdjSHBaRmJjaFk1RTF2WEY3d08yTXdxWk5mTmxRRkFBZTFvcFdPTmtF?=
 =?utf-8?B?YUwzVnZPWExMejVoNVRjN0UzcGwwQjlScHFDRFhSSmxQcW9zMC9VNHFxRFNT?=
 =?utf-8?B?ODdTZkpNUHdrMXVCblRDSll6SUx5QjRtcENYTzh4Rk5OaU91VUlXZFNGbHZa?=
 =?utf-8?B?amY3WnR0ZUN4dEJiQ0ExSGNvYUtBaGFtSHI4NUlzdmRDMEh2U1lRNXJ1ampE?=
 =?utf-8?B?bGdKc2x1ZUR0Z0tDY1k5b3R0OGp3NnhjUzVqekh5VWlrTTd1RjNmSnpiTk9X?=
 =?utf-8?B?aFlUb2QwV2g4cURZV05JaXJQdWZzSnM5OXhkcXUxZUJQaGYzOE5PZDdNZEg1?=
 =?utf-8?B?WndRSnpBdWE3VlFoN0VOMmN3WFk2RU1DTWk1TTlUOGRPN043cThOZHVaL1dW?=
 =?utf-8?B?cGJIMTdJeVovUm5LQ2ZTV2Yrc00rWTNEN1haQjNWUC9TM2JWZHJkektEK3BV?=
 =?utf-8?B?dU9SWUZZMEFLekR2aGE1S29sdEMxYnFrMndQcmZqS1dQYXVRcXVtdDMyaCtU?=
 =?utf-8?B?bytFSXlWQWlYWnBUNTQzcVlwOGppS216UkFJYTNCRC9YYXlQSktWdTVmakta?=
 =?utf-8?B?SzNmbTg3VnNSRVZEc3o4cnNNeHNhanNpV1JmTWxIaStEb0hqUXhlU2lYS2Ux?=
 =?utf-8?B?ZktZeUYwa0s3dTFnZk1welU1WkUwTWUzdXJXZmQ0Mi9NbHJCa3JXcW11MUty?=
 =?utf-8?B?VTZsd2RTK3hpb01ETE5YZTRqRkw2NG9VSDFzUEpORHZyWWl2SHJySEd4K1VO?=
 =?utf-8?B?TWVlaDJDOWdkQXM4QTJRclc3UjN5RmViMmVIU3ExOVhHMXRHd0ZyOHNtZEkr?=
 =?utf-8?B?c3FyNmhzUE85a0hqMitKYWcxYWpuR3luTW83dVhOcW93MEp1NUNGTVdGMGdO?=
 =?utf-8?B?QU9waFhuQkVKbENnK3o2c21SYmlZWnAwb2gvV2JBQnBRazFscDZKSlEweVhJ?=
 =?utf-8?B?YjlDSUdLRHgvOGtvd3crR0RSUnhaOFRyVlI5Q0Npb0lMbmkxb1c5dW5KTXVN?=
 =?utf-8?B?YkRva3RBUFc4S1huazlac3ZRb2tZVisvUFBKcjM3T013cDIwWm9qYnFLOWRW?=
 =?utf-8?B?MlFUL3puSnpWYnNSdUhSSUQxMUhrcCt6b3RVaGlzd0FTNHdEanVZTG1UVlY4?=
 =?utf-8?B?VUhmSFcwenRJR2cwVlMxSE1uUDA5T1VxUlVoVks3L2F3eVFhbHBTV1FiVVNp?=
 =?utf-8?B?NVh6ZEZJOUFsY3U0eXZlUGljcVpVVVBadkFjWEt5cGFFdEpMbzlWTlo0aGFi?=
 =?utf-8?B?dWtUVm5OakNvdnNZaWc3ZkxxSUZmSXU3SUdxZXprVkczYnFHdmpaQkxJSTIz?=
 =?utf-8?B?OS9QMUoxNHd3SkZDdmg4cHptVlRmQ3ozei9oSDBCT2REbzYxR2lYaFNTNENV?=
 =?utf-8?B?SHpPRTA5eFpiTXoraG1OSWhVOGJ0d25XTXQrV09Cc016OHZGUDJlbEZSOUdI?=
 =?utf-8?B?UTVNODNkMVJYTXdTR3ZURmhGcGQvV2VZOUNjVnp1VGtwNEt0TWJ3ZG96YjVs?=
 =?utf-8?B?V0IzQkx4QjZlUG13MnBESS82RUk4WGl0dDU1ejRJYXJ6YW1ORGpuQjZFeDIr?=
 =?utf-8?B?RjdaQjZwcyt0YjVxMVZmajArL3gzeWFIeUZtUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 06:18:15.1430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b024be-c56d-4b8c-b393-08ddb79de5fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF883AE17



On 6/28/2025 4:38 AM, David Matlack wrote:
> On Thu, Jun 26, 2025 at 9:57 PM Sairaj Kodilkar <sarunkod@amd.com> wrote:
>>
>>
>>
>> On 6/26/2025 9:59 PM, David Matlack wrote:
>>> On Thu, Jun 26, 2025 at 4:44 AM Sairaj Kodilkar <sarunkod@amd.com> wrote:
>>>> On 6/26/2025 4:57 PM, Sairaj Kodilkar wrote:
>>>>> On 6/21/2025 4:50 AM, David Matlack wrote:
>>>>>> +/*
>>>>>> + * Limit the number of MSIs enabled/disabled by the test regardless
>>>>>> of the
>>>>>> + * number of MSIs the device itself supports, e.g. to avoid hitting
>>>>>> IRTE limits.
>>>>>> + */
>>>>>> +#define MAX_TEST_MSI 16U
>>>>>> +
>>>>>
>>>>> Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
>>>>> can include a test with max MSIs 2048.
>>>
>>> That sounds worth doing. I originally added this because I was hitting
>>> IRTE limits on an Intel host and a ~6.6 kernel.
>>>
>>> Is there some way the test can detect from userspace that the IOMMU
>>> supports 2048 IRTEs that we could key off to decide what value of
>>> MAX_TEST_MSI to use?
>>>
>>
>> The feature is published to userspace through
>>
>> $ cat /sys/class/iommu/ivhd0/amd-iommu/features
>> 25bf732fa2295afe:53d
>>
>> The output is in format "efr1:efr2". The Bit 9-8 of efr2 shows the
>> support for 2048 interrupts (efr2 & 0x300).
>>
>> Please refer 3.4.13 Extended Feature 2 Register of IOMMU specs [1] for
>> more details.
>>
>> [1]
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
>>
>> Note that, when device is behind PCIe-PCI bridge the IOMMU may hit IRTE
>> limit early as multiple devices share same IRTE table. (But this is a
>> corner case and I doubt that 2K capable device is kept behind the
>> bridge).
> 
> Thanks. We could definitely read that and allow up to 2048 MSIs in
> this test. Would you be ok if we defer that to a future commit though?
> This series is already quite big :)
> 

Sure ! no problem.

>>
>>>>>> +
>>>>>> +    vfio_pci_dma_map(self->device, iova, size, mem);
>>>>>> +    printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size,
>>>>>> iova);
>>>>>> +    vfio_pci_dma_unmap(self->device, iova, size);
>>>>>
>>>>>
>>>>> I am slightly confused here. Because You are having an assert on munmap
>>>>> and not on any of the vfio_pci_dma_(map/unmap). This test case is not
>>>>> testing VFIO.
>>>>
>>>> I missed to see ioctl_assert. Please ignore this :) Sorry about that.
>>>
>>> No worries, it's not very obvious :)
>>>
>>> vfio_pci_dma_map() and vfio_pci_dma_unmap() both return void right now
>>> and perform internal asserts since all current users of those
>>> functions want to assert success.
>>>
>>> If and when we have a use-case to assert that map or unmap fails
>>> (which I think we'll definitely have) we can add __vfio_pci_dma_map()
>>> and __vfio_pci_dma_unmap() variants that return int instead of void.
>>
>> Yep we can. Another question, why do we need assert on mmunmap ? If
>> mmunmap fails then its not really a fault of VFIO.
> 
> You're right, it's very unlikely (almost impossible) to be VFIO's
> fault if munmap() fails. But it would be a sign of a bug in the test,
> so it is still good to detect so we can fix it.

Understood. Thanks !

-Sairaj


