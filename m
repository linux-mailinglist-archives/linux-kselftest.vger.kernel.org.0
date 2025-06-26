Return-Path: <linux-kselftest+bounces-35855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB396AE9CC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AF23AD8BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D85275847;
	Thu, 26 Jun 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r+9v6vo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CE717BA5;
	Thu, 26 Jun 2025 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938278; cv=fail; b=a7xbIos3ZJUpAxqRp6vHwuaNOPIMsrqMq9mAVky+UxO3RemuqGaSeawT5PrprwHGUcxAuckKt8jBj1mQYE5v+uvOD+grvvZoC8SrvG8bo5UE01lVf0TP5JzMXCT6eta42oOUnXms6zgiKyt/yMTclbyjorVAvTuCTBvfBcTLzYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938278; c=relaxed/simple;
	bh=lSTvzTP/3RXEkT2qQ7ywtWzTnKCBuUadHGyZJj+xKgs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=jWN0D81q0dMwXrYM5cwSDzgibjKVOL+MUeMNN/xP2USWwpIBA6CT9UOwrlbXCihRAVo0HsVBu4okDaEctk5Q+hMifo0mtlWMEdI4OCAWXrnID4XacRXicf3TRxA5QCay6rNoyGnU7Mk9X7U4iRXxsgoVnEbF7mjfNtExJw8qgaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r+9v6vo7; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCqIslRhw8MrXHpBCUnvwba2PuZoiWlgXcTqvBTU0v8+0G7dmPSerLD7aDH+mD+lxi+lziR9S1paGW1LAbQq7OIfW8KRTKXhaiLVW1pRunWhVfwog0MGpCqB14TSV/T7KFKbNeh7HOteDVF+XJPAfo5Qe+CtbKBk5owp5TBYrSmqp8Nh7zX4NQHD/1e7FSQVBbg+LcVH6nOz+JkDwATAt1/owE/87lKLyhqprcdsKf10XPV/NXsMEWmdJ4yzdqYqvUX7DvhbF8N4WKv7QDt0U0PowQeLOgA1md1+xBAlD+VyYZBKIcKkZeH7+hXlpAZfSh9r5Pp98wnbRohCObIN8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TokoGOl/SdbjGMUpzu8qkGQZL8isezS3Qg79J3OuO8=;
 b=hHYM9J9/z+nWIfoTRfogZR7I1Ob6CCvx8Sv58uFgfmJzvvPJt0md2SePW+1pL5YEga6dEcqedvaWXoiUfLUf35W9NM4KrhrOFD7bRSP0RA0qASUgm2wiEMleO9K2UhmaaBCGRWfyngBaZnckeOe5opYqIUfoDL4K6iRpRA1JpglNw61HLhkb7wmBFZ34+TZq0xP+LR0nZSy0VZ2jn8Trf1i/NJ4jPg5YeajM26mpbfpxjsgkViZiDCP5W5ffx+u8KByDx31MnmiaIEFmx9tCqM+ivL0bvMcE7prq3AhF4YOjm9TBd/aGrE8SoVr6CR/k45PhZTpUJn9o248Axiz/7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TokoGOl/SdbjGMUpzu8qkGQZL8isezS3Qg79J3OuO8=;
 b=r+9v6vo7hcqS/s8Jk89arbJEmqg3Z7+5uRIkcJtNjk0VSc2dIstySlkHDUJHAWWqI22HwDdirklFu0YjavQlZUNeS5O3eZ/4YYUzjF/ZyJq70FMGtvNLVu4smxz9P0bQUao7BKupms6HrcFiCCJRuQQOxTEK6gNSP5zLKcZVupo=
Received: from SN6PR01CA0003.prod.exchangelabs.com (2603:10b6:805:b6::16) by
 IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 26 Jun
 2025 11:44:33 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::a5) by SN6PR01CA0003.outlook.office365.com
 (2603:10b6:805:b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 11:44:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:44:33 +0000
Received: from [10.85.43.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 06:44:25 -0500
Message-ID: <4aef95a0-a0de-4bd5-b4ec-5289f0bc0ab1@amd.com>
Date: Thu, 26 Jun 2025 17:14:17 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
From: Sairaj Kodilkar <sarunkod@amd.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Aaron Lewis <aaronlewis@google.com>, Adhemerval Zanella
	<adhemerval.zanella@linaro.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Andrew Jones <ajones@ventanamicro.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<dmaengine@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>, "James
 Houghton" <jthoughton@google.com>, Jason Gunthorpe <jgg@nvidia.com>, "Joel
 Granados" <joel.granados@kernel.org>, Josh Hilke <jrhilke@google.com>, "Kevin
 Tian" <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, "Mike Rapoport (Microsoft)"
	<rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, "Pratik R. Sampat" <prsampat@amd.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Sean Christopherson <seanjc@google.com>,
	"Shuah Khan" <shuah@kernel.org>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Vipin Sharma <vipinsh@google.com>, Wei Yang
	<richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-4-dmatlack@google.com>
 <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com>
Content-Language: en-US
In-Reply-To: <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: b309fe84-1bbb-453f-1d04-08ddb4a6d19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1FSWE16eHdJV0k2WHdIcXBMWmY2TkxlS2o0Z3FpOHdyV2Z0a001TmppQW16?=
 =?utf-8?B?VWp2KzREeGVqTWQ5NVRUdXdlWmJFV2xJL00wdzR6dXBOS0hKcUFhWCtkSUww?=
 =?utf-8?B?RlR2cDU0d1IzdjNyOUU4SWFlclJJOHpxR0VBdWhTNHFLWlRkQlh5VmtJVG13?=
 =?utf-8?B?WGlhcnpCQXExRHRRbE5KRUhGMk8zYTBqdFJaRWNvOVl5cjloajNraVhhaHVP?=
 =?utf-8?B?SHNMWVRkSDg1WVZybkNuWmFvQlZzSEdaNEtTVEI3TFJrVnNUeCs0WW5UQ3g5?=
 =?utf-8?B?WnpPajdrbDJtZVBXSWhVc2ZURkNNVHdBYm9sbmVOQ1pZcmlUZjZWdlBJUElk?=
 =?utf-8?B?VkwzbzdHVVlrZlYzMHdiTDJnczlmaGVCZWxtZ01LSkpoRm5GMXZZOUVnVE5i?=
 =?utf-8?B?aFR0VDJMTGlNS25hdDY5M3QvS1ZsMXpnKzdjcG53ZytnOVYyejczckhIRFlQ?=
 =?utf-8?B?QWJJMFhUdzFjRS9ieVFscE9kWmJqUTVnVjlBVW9BRTBoNmxCcXpVU2JCNFpM?=
 =?utf-8?B?V1Y2d21sQXgvU3RxL0M1cTMxcldPdW4ydWdBNE1RU21MQVhBTFpjcVRYWWpM?=
 =?utf-8?B?R2h0NGw1VVRoUGhXQlFwZGFrVFR0ZnRudVlIRnRldzRDT0praHIwR1QzYW9z?=
 =?utf-8?B?dEF0eEt4OWt3UWFrUzJET3NJYmNQV1dUd1FLeDYrOHhzcVRickUvVUlGWUpJ?=
 =?utf-8?B?eFF0dHdWVVdYM3lRRE1Mcno1WnptalNXckMvL2s4Nk01ZTMvVDVrZ2Z1d0FO?=
 =?utf-8?B?K1U5eVNxYndHZ3h6K3g1RmhPWS9DTDhKY0k3OE1wYVB4L052aEJXWE10Z1FQ?=
 =?utf-8?B?YkhQUmJoWSt0cjQ1SG1hU1RZS3VDV3V3MGZucmpmTUNUUlNRQStpMjZZQ08y?=
 =?utf-8?B?ZFcxVVVwcmhRVVFTUkQ5QUE1Q2F6OTF2RzhhS1VZM3ZUWjNEYWV0RjVJTTZx?=
 =?utf-8?B?MG56YWF3Um8zOGozK1dRZjBHeGM3ZzYwZTB1M2tJeXppeWRQNHdLUWpUZVV3?=
 =?utf-8?B?MkQ5ZktYQ0dWK3FUd2lncm9qakVvT1NjWEFPaEZJczFhUDJRSmFWamFLODFs?=
 =?utf-8?B?MURHOS9Ldm5xQVErcXJFYVJuZEN0Wi94bUFLaGlKSzlPUHlPZXhVanFmZ3dQ?=
 =?utf-8?B?L05US284dnVJNFRHbkFUMmtremtYMmc5Y280d1JsMnFoLzNzRVErVTErYWdp?=
 =?utf-8?B?THNUZWY5RDUvZ2lJUUYyNUxLY1JLaHV1eXloZFZTMCtKNC9FaE1qK2tJd0g1?=
 =?utf-8?B?VlBNdyt1dzQrRGpySWREbjdLbjVmSFM4aXg4cm12TFE4RGlVSU9Qbk1VOGZW?=
 =?utf-8?B?bTVhb3pGc041aWwrOTB5ZmpKaXdwRzJXdEY5ck5ZSGd2Y0dFbVpRV0lDK0JT?=
 =?utf-8?B?d2t1VFZnS0pWWStEVmZ5ZXd5UExyM2ZGcENEdy9MUWNNMDRYc0J3b1BxU1NP?=
 =?utf-8?B?N1NtUVRnREJETzNmaEVWclRvSjU5eGVEOXFiLzBpVDdHaTZGQit4dWV1cjBQ?=
 =?utf-8?B?Z2U0MWJIM3BmY1FWSmw3K1JNT0JXaGpOSnhZOWs2L2VUS0M1ejJHZVZLZTg1?=
 =?utf-8?B?cVVMcHZtS3EzNkpXVExVOWJtZEFDMjV0Q0dpajhuTUs5U2pHbFdkaGFndFNi?=
 =?utf-8?B?U3VITW00aVpHOG5zRXg1ZWg0dlNvWkZtUktjRE4wbjdtS0cwKzhJdURzdWI2?=
 =?utf-8?B?ZHZvemVYVi8zckhmcXdsTjdQNlBUTHZ5TDlmQ2VXMHdleXpzZWZmTXV2NzJC?=
 =?utf-8?B?Qlk5dGc5anVmc2dWUlVEWVVDWWh0UlNSczVCL2JCam12cjFhRmtpSUtLOXdS?=
 =?utf-8?B?a214Q2QvRjhFZHZXdFoxd2RSOXhpUVdiaDJ5UjhqVmwyRFdxZDY2d000cVNQ?=
 =?utf-8?B?dXZscU82SUFDOHYrNXp1WlFabENFU1owVlhhTXJJZ0x3TUNJZ1dsa3E0a0Za?=
 =?utf-8?B?WjU0ajA4bnJINEJHc2VZNW1sUjU2dVc5bGRQem9YOGhKaHpwTkRySXVYdVpV?=
 =?utf-8?B?a3dHeFpHSFhmZVljU2Y3aUZlOVBIZzZuY09WV0xYZENpUm5OcDlIZ1BMMDFW?=
 =?utf-8?Q?FUkJB9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:44:33.0088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b309fe84-1bbb-453f-1d04-08ddb4a6d19e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325



On 6/26/2025 4:57 PM, Sairaj Kodilkar wrote:
> On 6/21/2025 4:50 AM, David Matlack wrote:
>> Introduce a basic VFIO selftest called vfio_pci_device_test to
>> demonstrate the functionality of the VFIO selftest library and provide
>> some test coverage of basic VFIO operations, including:
>>
>>   - Mapping and unmapping DMA
>>   - Mapping and unmapping BARs
>>   - Enabling, triggering, and disabling MSI and MSI-x
>>   - Reading and writing to PCI config space
>>
>> This test should work with most PCI devices, as long as they are bound
>> to vfio-pci.
>>
>> Signed-off-by: David Matlack <dmatlack@google.com>
>> ---
>>   tools/testing/selftests/vfio/Makefile         |   1 +
>>   .../selftests/vfio/vfio_pci_device_test.c     | 178 ++++++++++++++++++
>>   2 files changed, 179 insertions(+)
>>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
>>
>> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/ 
>> selftests/vfio/Makefile
>> index db3e4db1a6dd..828419537250 100644
>> --- a/tools/testing/selftests/vfio/Makefile
>> +++ b/tools/testing/selftests/vfio/Makefile
>> @@ -1,4 +1,5 @@
>>   CFLAGS = $(KHDR_INCLUDES)
>> +TEST_GEN_PROGS += vfio_pci_device_test
>>   include ../lib.mk
>>   include lib/libvfio.mk
>> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/ 
>> tools/testing/selftests/vfio/vfio_pci_device_test.c
>> new file mode 100644
>> index 000000000000..6d3a33804be3
>> --- /dev/null
>> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
>> @@ -0,0 +1,178 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <fcntl.h>
>> +#include <stdlib.h>
>> +
>> +#include <sys/ioctl.h>
>> +#include <sys/mman.h>
>> +
>> +#include <linux/limits.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/sizes.h>
>> +#include <linux/vfio.h>
>> +
>> +#include <vfio_util.h>
>> +
>> +#include "../kselftest_harness.h"
>> +
>> +static const char *device_bdf;
>> +
>> +/*
>> + * Limit the number of MSIs enabled/disabled by the test regardless 
>> of the
>> + * number of MSIs the device itself supports, e.g. to avoid hitting 
>> IRTE limits.
>> + */
>> +#define MAX_TEST_MSI 16U
>> +
> 
> Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
> can include a test with max MSIs 2048.
> 
>> +FIXTURE(vfio_pci_device_test) {
>> +    struct vfio_pci_device *device;
>> +};
>> +
>> +FIXTURE_SETUP(vfio_pci_device_test)
>> +{
>> +    self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
>> +}
>> +
>> +FIXTURE_TEARDOWN(vfio_pci_device_test)
>> +{
>> +    vfio_pci_device_cleanup(self->device);
>> +}
>> +
>> +TEST_F(vfio_pci_device_test, dma_map_unmap)
>> +{
>> +    const u64 size = SZ_2M;
>> +    const u64 iova = SZ_4G;
>> +    void *mem;
>> +
>> +    mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | 
>> MAP_ANONYMOUS, -1, 0);
>> +    ASSERT_NE(mem, MAP_FAILED);
>> +
>> +    vfio_pci_dma_map(self->device, iova, size, mem);
>> +    printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, 
>> iova);
>> +    vfio_pci_dma_unmap(self->device, iova, size);
> 
> 
> I am slightly confused here. Because You are having an assert on munmap
> and not on any of the vfio_pci_dma_(map/unmap). This test case is not 
> testing VFIO.


I missed to see ioctl_assert. Please ignore this :) Sorry about that.

> 
> Thanks
> Sairaj
> 
>> +
>> +    ASSERT_TRUE(!munmap(mem, SZ_2M));
>> +}
>> +

Thanks
Sairaj

