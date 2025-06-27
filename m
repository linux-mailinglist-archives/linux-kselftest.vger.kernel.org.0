Return-Path: <linux-kselftest+bounces-35948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16838AEAE42
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 06:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1174F1BC6417
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 04:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B11F1DB34B;
	Fri, 27 Jun 2025 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3LgHstKq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF618DB35;
	Fri, 27 Jun 2025 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000277; cv=fail; b=n5OEqYrhNmVUcoUWdL79KBURtzl6coL/JBzp+hqbsuwi3Ivktezv79x53z634EtFyu8XpPi0/xlGfwGk9BVghNHXgDDW0IEK/bNeR+G56lkrI0i+JAa+CF1n8vfGu0ugFym3cnGZ43cnHAZp9zfRNygzBVjexzcUX1FsBv2jr+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000277; c=relaxed/simple;
	bh=sICRRFZGGZuKdFb9I6hip+SCfFEu+t/dfJUu5eHUQ/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WqTAP3KiLnG9ZWFEZBJWFTSXMEUFOwqHR0npPik5h93hi9WQoPT0mdtppH+xExL5yuRr5CgxO/reJHR1NT9y0pq9XC4KVDcFSAZDV46qInS80Y79fj7oD4VWLtW5IoBVgA5eB+ROx5QEFCEoD4HwYjiach2NI/dAkuaWeBOSsBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3LgHstKq; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FX5N3e33ygtWlmTC8YV9kAZJ6WszjnVhCRsjc3TXNSTO8ruZuqb3UzkSq6Jis8RZCMC5d4Ak7rex1skV+OsYQdKGAXSrzCLVaXoEIsT+8ZKMccRu9DLu8alg8tdR/8Dtn4GCX4qmTJrY6EErFo+ZPHMTKvdJ+mVcAkjoG3se/HsHDyA4ZxtzBo4a7fa0pupmwJASzyk9UodwLk84QNknz+ieFF/UlQxt1ZQiqmnRBDFs1vgbgugrMdQqp7yleRXjEb6mfLjiQwCognQ7o4i+H2sOUlT5VwsX5CR4HMjpwAHi6nEKRmJ2mDPNcKiFQ7WwS6g7V6ImDC/YywIYMlQ4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evSmwbOaYR/9YlBY57z7acdzlx+d4OvLPNV8lBa1Nso=;
 b=BDHmpqeLYzSU+Dmc57JbNnVizTLoNG9NKrnvcKzqhQQ7X/kj6CjwyRP2tYgXHbnopXhyXNayPFtWMKXluJ6dFKiD925gCA0mUd99r/sXvCQEp2EEHIVXG3IzFfou7HdKWRFv6eWlGpAjrorE3yEqjG+UJQJvHDVPQeM9CsxuG46SOW+XjIhvy2ApawqF2B3BtxHoSF7SJn4q3mMZBaAPFqEKfULBNyQ4avH869l+9KOMVjpyoLnG3jbw5PX3XKvWGFuf7a3dfgiLdwt7gyhr2+GxvjpxJJbEOySmO/CH2XpqXkHcm+fgxhjuoYno4EVIcJ4s9G5pW1Ye3aEai+69CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evSmwbOaYR/9YlBY57z7acdzlx+d4OvLPNV8lBa1Nso=;
 b=3LgHstKq6Z5zo2A1P1hjvX4aHGpGk1rD02QuirXgNPw0hHJp7RZgmdQxy0p3+p3z3uqbq9ohn3zWciODDL5cVIZ4Qzhpui4lNG4E10lRtjXPfPlEWv8IQKiDeADiqfE315Ya+QUBquLwTL0cJNnM4YEi6c02lNa4W4gMwMciNYc=
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Fri, 27 Jun
 2025 04:57:51 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::f6) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 04:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 04:57:51 +0000
Received: from [10.136.36.22] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 23:57:43 -0500
Message-ID: <62734f4d-8883-4145-a483-5bf2c462fad5@amd.com>
Date: Fri, 27 Jun 2025 10:27:35 +0530
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
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <CALzav=fZcLpQ+9J=XOZ-=Cr1UA8qKa5NHXB1dJpqhCp7pee7Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 97412185-b618-4bff-cf17-08ddb5372b9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1VkQkhIL1NwZWIrZ0QwNWZPSDhHODFFTnB4Y0owZGEvaUV0YnY2eUNIcEZY?=
 =?utf-8?B?WkErbXJKWnVLRnd4NFR6SWVHaGNRN2dZZk9BT2FyeGFlUFB6SDBPeWV4dGRI?=
 =?utf-8?B?TlkvRkMvcEZ1QjgzdnFGSmtEeEJzamRQYjM3U2VMd1k2S2VXcndJUmRObGk3?=
 =?utf-8?B?MTIxbVQrWVN4WGxxVjZLYW1zN2dLMVBNYmFobGN4RUVLMnNoQzFWMkQyUm1y?=
 =?utf-8?B?QnpoWUdzWStoVk9GQjFWV1VrUDJWY05xZWI1SzQyWUNyMzdYcVpDNDVIYk5o?=
 =?utf-8?B?YS95Y2RPQm4vcXZXVW81cjRza1lnSEkxa1lGMFRXUUpnR2R0VEl3LzNMejlp?=
 =?utf-8?B?S0Juc1FqTXNnUzEwZFlBeVdmWTNyVjRiZHZtMWpDV1AvQWFqcHZZM2VYQTM5?=
 =?utf-8?B?Y3RlZWFZdlh5bUpsRkpNajBIT2NoRjZ0bWx5b0xyMnZCQUt5ejhBNnhqSEJq?=
 =?utf-8?B?QmpiakVrZWN6RmcxOERNWmxlN0M4R3ZHZXMzaGZUUFJmc1VwakJkV3QrejBm?=
 =?utf-8?B?cU4za3o1RXViTjhkVUpFclZCWW1iclNKeG1MWU9NVVVvK0ZMYy9FUEVNRldC?=
 =?utf-8?B?OXh0cFh5Z2pXNStkUkZLYlJROGVWcFVNejhEQ3lDdFNmdVlJc21ma3ZoQmxL?=
 =?utf-8?B?Uk54V21kckV0UytiSW5ZL3VUOXNJeHZ4YUZENjVmL1kxV1FhdlpLcmJ3Wmtn?=
 =?utf-8?B?L1FVUEFKaElrYUs0QmtiQWd3NEp5blhOS0lFVXZvQm5yR3JGNWI4SWdUcGZH?=
 =?utf-8?B?VlZtSFZSVmI4bmxFbk4yL1BnU1R0dzVrUnBxdVBBRjNFVkpwWHZLK2xkNkFL?=
 =?utf-8?B?OFZWSGhsdDF4R09ZZEJDNkNxR3czcVJBUXdTTFdYNDFyWGxKdFhIbGNleG5i?=
 =?utf-8?B?Q2l0WlMzUHZnVlBWbkRneVpRb3MrM241VWRjdzBlT2RYRTMyZGxkODU1MjAr?=
 =?utf-8?B?VVltK1hvWm8wVDlZdWNpNUJ4R3N0SHVuYzhSUzdaejBmODFxMkFHQ21TOXlS?=
 =?utf-8?B?KzVpZmlLcnZpVjQ4SUQ5Y3FESHdscXoyQ3gzRTdFTlBtZENhbElHK1B5WHNS?=
 =?utf-8?B?REN4eWFoM3U4VFpOVVNINERZbm1vdVZmWVFyYkdUL09YTjVlamhodHhmd3lS?=
 =?utf-8?B?MjYra28rQ3ZyMFgzNzRLMjcvdjQwOW1hS1VkdERlVDA4ckc1aVVBQ2JNQ082?=
 =?utf-8?B?elY4SUlUMmYwVXRsL3pJMDBNSUhwN1dlQnovWlFjdk52clFkTktUMHJyNWlV?=
 =?utf-8?B?cjRJZlF2WjY4NTI2dlB2UnM4VDMxMmpuRU1xTUNHNjJWdTF6WG9PQXp1YjN6?=
 =?utf-8?B?em9rYklwVkc2R0tCaWVQTWxLQmpmd1N1UDFZTDN6RE5MelFEVGpmcG1HSENZ?=
 =?utf-8?B?a1hSUGpUKy81UUFSbWNna0ZKK0drMnR4Zk04YkQ2eit3VmxNaCtpWnVxQlBR?=
 =?utf-8?B?dUxpeTdPd0kyVm5Bcm1PR0VIdXNCNkVXc0EvZlhIazZYckVMWWs1YlllWWJJ?=
 =?utf-8?B?c2tNc3FjeTByYzlaMXhVOFNQU2hwZVk4MnYwajMzTEdlVUJLV2JpeUd5RnpN?=
 =?utf-8?B?WHdVNVFOV1JWeTVtc1hOWDh0OW10TFNIWUFNUWhsWTFkTmdTZW92aHZRNnhz?=
 =?utf-8?B?SVhBU3hoN0xqZVVSQWpwbTJiRUExeFlIYnlkU1J0YXpnY2ExWVRxaVVOTWtR?=
 =?utf-8?B?LytXV0MvWHJGeTdWR3dxazhQR3ozLytpV24yK2F3OG5qVXJVczFaVjd4YnM5?=
 =?utf-8?B?M0MrQ1FVdlR5aWlTaWZmSStyVlJjRkZyYTVyZVMrb1o0MmJVSnFZWVRXbzIy?=
 =?utf-8?B?OGR4NkhQVWwwVE1KczVZUUFnRjdOLzVtREVOeUJmdzVUMnNCcC9VRjlUMTNV?=
 =?utf-8?B?WmM3QUJmd0FZL1JHY2J4VURNMFh3enRpUCtHR1RydXV4N3BUa3N1ZFZtUmJt?=
 =?utf-8?B?TnlPTzN0QlY4c3M2eVhZNllQRFYvTkk5ZW9hak9TUUhHdUFSZ1UrdTlnQ0N2?=
 =?utf-8?B?aTFBMUFBbENCcGN4czR1U2lsRU5pSnVJd0U3SEdOaGRUWU5JWmRFckFRYmNp?=
 =?utf-8?B?ZVZCRnhvSnh4MG40eDJ0d1Y1ZGFHMnEyVnRZZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:57:51.4990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97412185-b618-4bff-cf17-08ddb5372b9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019



On 6/26/2025 9:59 PM, David Matlack wrote:
> On Thu, Jun 26, 2025 at 4:44 AM Sairaj Kodilkar <sarunkod@amd.com> wrote:
>> On 6/26/2025 4:57 PM, Sairaj Kodilkar wrote:
>>> On 6/21/2025 4:50 AM, David Matlack wrote:
>>>> +/*
>>>> + * Limit the number of MSIs enabled/disabled by the test regardless
>>>> of the
>>>> + * number of MSIs the device itself supports, e.g. to avoid hitting
>>>> IRTE limits.
>>>> + */
>>>> +#define MAX_TEST_MSI 16U
>>>> +
>>>
>>> Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
>>> can include a test with max MSIs 2048.
> 
> That sounds worth doing. I originally added this because I was hitting
> IRTE limits on an Intel host and a ~6.6 kernel.
> 
> Is there some way the test can detect from userspace that the IOMMU
> supports 2048 IRTEs that we could key off to decide what value of
> MAX_TEST_MSI to use?
> 

The feature is published to userspace through

$ cat /sys/class/iommu/ivhd0/amd-iommu/features
25bf732fa2295afe:53d

The output is in format "efr1:efr2". The Bit 9-8 of efr2 shows the
support for 2048 interrupts (efr2 & 0x300).

Please refer 3.4.13 Extended Feature 2 Register of IOMMU specs [1] for
more details.

[1] 
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Note that, when device is behind PCIe-PCI bridge the IOMMU may hit IRTE
limit early as multiple devices share same IRTE table. (But this is a
corner case and I doubt that 2K capable device is kept behind the
bridge).

Thanks
Sairaj

>>>> +
>>>> +    vfio_pci_dma_map(self->device, iova, size, mem);
>>>> +    printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size,
>>>> iova);
>>>> +    vfio_pci_dma_unmap(self->device, iova, size);
>>>
>>>
>>> I am slightly confused here. Because You are having an assert on munmap
>>> and not on any of the vfio_pci_dma_(map/unmap). This test case is not
>>> testing VFIO.
>>
>> I missed to see ioctl_assert. Please ignore this :) Sorry about that.
> 
> No worries, it's not very obvious :)
> 
> vfio_pci_dma_map() and vfio_pci_dma_unmap() both return void right now
> and perform internal asserts since all current users of those
> functions want to assert success.
> 
> If and when we have a use-case to assert that map or unmap fails
> (which I think we'll definitely have) we can add __vfio_pci_dma_map()
> and __vfio_pci_dma_unmap() variants that return int instead of void.

Yep we can. Another question, why do we need assert on mmunmap ? If
mmunmap fails then its not really a fault of VFIO.

Thanks
Sairaj

