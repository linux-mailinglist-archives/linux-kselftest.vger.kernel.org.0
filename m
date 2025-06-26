Return-Path: <linux-kselftest+bounces-35853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AAAE9C81
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 13:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45DC3A8D64
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341F27381B;
	Thu, 26 Jun 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PvJL+AmA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7231F2BAD;
	Thu, 26 Jun 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937293; cv=fail; b=aNMLTvXZnXamWK6yPmH42Y4YtfqsKpU7wSKR3jFVTScyEnOwLB1KhTnCn/GDZD/rb7DPD/G0IgBcQakDRSRbitGtHKVssxpThSvTCVSD/AzBto/mAbBODgOOzU8nj8Qlplj7OgERG2KurnZhaW3qSv/FCQAPk4F608ybG647Yik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937293; c=relaxed/simple;
	bh=HzkysDuyhFokr/UmrIuzqdtR2yFeuiKcG90Ai9uJbeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SWbv8/9oDqINYf8eOqRN4hzTH3VwhNEOG5Fk+bOICMWm2Er0L45b/7F36EHYO8Yc6MDu5BFlrfSHbMJc8QmXb77LUzpPXNgV7SV6b6gT7wlIEP3IFY297P1+toKJVhdmVDOepopGPa3gZtajq7101eaWUik1G36IE1fEsCG6VyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PvJL+AmA; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usbQo/R3/WlrnGxMrRE04LEnaTzOOWBeyAg2vcfoT5fXPda1ocjnoftNnTMBppPm2UDgvenRwzRrLdgOq0lUI5RE/mseoNu9BkcypacV1EnIu8pS/TpUnQeSnGigOvP/XEMkpi+8wA54JzpcOmMcGtlinMQVEHsR/kXVCVAfxjH7IG78ZqzoPU5Zz53WfL6UFUV9DeG5K4lOw+mCK2d4wWJ3I5vc4cybVU35jiJZrKIheiX2cHJFKQ8vJHaQ8JGFHqCZFBK9rLm13ICr0HXLUowqqQD23+JerbcQn/XR1SJRqPbdFwMHTXwhfpVITzQq1gNSg2H2uDE/khwDryv0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=digQpWVQlIi/l41C1GRzZTcQ0KIvEuMbJXI24kfq9xI=;
 b=EW7GbDc3iEtBf12wtH2+RD8XfmkgNGJ7r66GlZzY/2f1HdlZrQ3B8aXG+weVbEgWLKgJt8y8q8tCBlsA4gme7NPfkwojOl3Oazm8btNCYU/N3KhrRK2GoTgDrv54QwAo0nPklz+4N+y+1cyBhKvtUe+LOp4Q1reFizhx6xptV6VUZEE9s52iUdFrvCL+dAFViWgrAFA81qun+eMdIktEn47mxY5zk7Dkr1DisH8FTcJ4hadbzVaMPBPsCro6rNDHtusSP/EKdO6fCpAhhhc9TQL49Gl6EdO9Jz4+kEjQ11QPJ6I8celeCF+pYfp3pUe/EtVZyOpQU90xb1wB1Iti6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=digQpWVQlIi/l41C1GRzZTcQ0KIvEuMbJXI24kfq9xI=;
 b=PvJL+AmAuzlzERPkCLM9wdKC0sNxguffcxUR0ik/t3VRz5vAEIbik2NaFQq75WKC+v9h5b/i3BCFA2lQS6weCib7cTjNQkzo0eIGJDBpiUykNQsQD+k+hY9X1Y0e2JZHAGoBPeov3uJDdsVEUbO3CPF0HIauYvjj3bl/cGSe4FE=
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Thu, 26 Jun
 2025 11:28:04 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::1f) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Thu,
 26 Jun 2025 11:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:28:04 +0000
Received: from [10.85.43.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 06:27:54 -0500
Message-ID: <fe4b1d31-e910-40a1-ab83-d9fd936d1493@amd.com>
Date: Thu, 26 Jun 2025 16:57:51 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/33] vfio: selftests: Introduce vfio_pci_device_test
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
	<richard.weiyang@gmail.com>, "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Santosh Shukla <santosh.shukla@amd.com>
References: <20250620232031.2705638-1-dmatlack@google.com>
 <20250620232031.2705638-4-dmatlack@google.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250620232031.2705638-4-dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bde1f5-5fc5-4bad-e611-08ddb4a48478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU01MnBhVTdSOFV4MjRzR250eUtONVl5NFFCNmdlNU9kNDk0cWtwUjRQZDJS?=
 =?utf-8?B?WTBBM1ZPYW10VHN6YzBjOThKekI4c0hhUlZjR0NzcTc5ZWNqaVR0VFJLRXJ4?=
 =?utf-8?B?b3NlL0tFSmJPUy93YnM2WnpRZWRnU3RVWEJUMHRJNTZ0TjVpMzZHM1dQbCtW?=
 =?utf-8?B?QkZNbFh6TzJZMjRINmZxZXBOVHJGcXR0RlYydXdPemppVnhLUlFpQkw4T2U4?=
 =?utf-8?B?UG94WWpsTkR6TkJRQ09reHpWMmpqR0FBeEpqWUdwQlNCRGlSNVF5d2RNczJh?=
 =?utf-8?B?dmhpYlJ1MUhCaEhzQ0ZwTjJTdE5IU09DRlhuTW5wWTN6NWtaQW9QelpnczNZ?=
 =?utf-8?B?WHNsZ3dONjhIVjlUNzRMYUQ3M0tTbFRmYmJQQUNLOVM3a0VJSUpPdWtPQU10?=
 =?utf-8?B?SktPQkRiRFA3YlhVcUhmcVBPVGNBTUFMVHRGQ09SekhWYk1tV3FBNlBrTmdN?=
 =?utf-8?B?cFFua0NjN2xtdGIvN25tK1ZYajNsU3ZPV0h1SHR2ellZMHRaZ2VRZHFoTUlp?=
 =?utf-8?B?US81NU1sRDkrNTMrMXRSaENRQ3JxRHRKVkVaSXJUQjZmZUFZNHBCdXJ1VHZB?=
 =?utf-8?B?d1R1N1d6eTl3eG1wM1dUaHhrbHYwcVNXS0tRUzd1bkNIVVB6MHZrSWN3M0lG?=
 =?utf-8?B?aGsyZHJ3V0hYZng5L0ZlZElvVG54S2Uyd0JzV0tGOUxTcVZHRjFlSG5IZmZY?=
 =?utf-8?B?eFYzZlJ5Vk5mMnl3aU91V2NPQlpNOWpsakh5ZThDWXU5eTh3Mm9kaU1keVFU?=
 =?utf-8?B?UnlRZTR2NCtSekpCWXpvQ2NYLzdaMDU5cWhCUG1saVNqdEhGcWg0SFNiZFRk?=
 =?utf-8?B?SUFYTjFvSThlaTRCL0RTdkxnVGdka1dhQmR2WXExL0d3bEc4Q0tyT0xmWGpZ?=
 =?utf-8?B?MHE1bTlydXZ4cmlqUkxKaGgxaHA1b0p3dnJBcDhXYkp5TFlHdGVNN3ZwM3g2?=
 =?utf-8?B?S1c1aE5hR0J4aEt3MGV4S1poU05yNG1IdXk1SngxYjBWZXdmcWZCU0hocTJX?=
 =?utf-8?B?QnI5RzRxRWRVTDZjUCsza28vcjhBYTVkMVFmaVl5cG05YkJRbEhnZTdpdGdx?=
 =?utf-8?B?Y2c4T1E2emNOUUJFWmtyeVJCRThvaUNsZTJRVWw5THNTYy85SlJzWDNYd3pn?=
 =?utf-8?B?bmY3MzR0OGVPUGsrU3lxUjh6c2pzR05icDYwaUR5c1RQY1BYSGRuWTVFSGJw?=
 =?utf-8?B?V09hemdIQUNWZjdFVDFmZk15emF5NnVVWFRDdWpjcUk2dXRxZ1g3ekNnMkpN?=
 =?utf-8?B?amVkYnJNbmRUTlQ2Ykx4ZnlzY0FJUWV3amNVLzZYY25PZzVqV3FYT05uTkZE?=
 =?utf-8?B?Y3RNV3RSWXpmc1pSQ0xuUTZ0TGJ3N3hVUXFhYkwxa1BQeXVXL3lKVUwzZ0M0?=
 =?utf-8?B?UkJxZ0RnbGVGd3JrWDZtRFMzcWF1VzJNQkRYYWRldW5Bckx6N2N6d2wrV3J4?=
 =?utf-8?B?VXNHN2ZQb3g5cGNVdFF2M21EZll5aTF0WlpXVS9WVllEQTZZcVpjanJPZk5h?=
 =?utf-8?B?MTExZDVrWWwvQXBSeGU4ckdBRUxsMEYvcGtmSkZRNFpaQUZrbVhMd3VBYktF?=
 =?utf-8?B?UkxFN0RLbmdJN00yZFBDeTN5TGJHU2x6S0FqWnNqTHZMWHQ3VnhJMUFKVXdC?=
 =?utf-8?B?V09WcVNaRkRXdzU5dU9HbElpN3JZdGwwbU8waTM4SWREZERQVG5GeWdSQ2ZN?=
 =?utf-8?B?RktxMDBwdzBxdkpSaFhxU3B5T1JuWUtobTl3d3F5TmpSamt5MlB3YmFhQzVE?=
 =?utf-8?B?U1Fnb1hKS05GZG5ocEdoa0EySDNzMHlsSUpveFR1V043YXM4UUZVMTh4U2o1?=
 =?utf-8?B?aVBYb1hac3N5RnJidGRmMXppTDBqUlZzekIvM0JqSExoa0xwSVRjUG9maFVq?=
 =?utf-8?B?S0RwMDVKMVdxaWJaZWtETzZIVmN0YWJkbGxOdmg1aEpXYW5qYkZJb3ZWblUw?=
 =?utf-8?B?NFhFTWkxTysvaVo3d3hxYXBQU24rYlAxWkxHRTRYOVJKRzU2R0xTYzdxWUJa?=
 =?utf-8?B?TnhwbmVjVzMwRC9jN0I3Zzh0U0tOcGJJOWhNdDQzM1VnaUxvK2x1YWkyeGNi?=
 =?utf-8?Q?cScPcy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:28:04.6211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bde1f5-5fc5-4bad-e611-08ddb4a48478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736

On 6/21/2025 4:50 AM, David Matlack wrote:
> Introduce a basic VFIO selftest called vfio_pci_device_test to
> demonstrate the functionality of the VFIO selftest library and provide
> some test coverage of basic VFIO operations, including:
> 
>   - Mapping and unmapping DMA
>   - Mapping and unmapping BARs
>   - Enabling, triggering, and disabling MSI and MSI-x
>   - Reading and writing to PCI config space
> 
> This test should work with most PCI devices, as long as they are bound
> to vfio-pci.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   tools/testing/selftests/vfio/Makefile         |   1 +
>   .../selftests/vfio/vfio_pci_device_test.c     | 178 ++++++++++++++++++
>   2 files changed, 179 insertions(+)
>   create mode 100644 tools/testing/selftests/vfio/vfio_pci_device_test.c
> 
> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> index db3e4db1a6dd..828419537250 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -1,4 +1,5 @@
>   CFLAGS = $(KHDR_INCLUDES)
> +TEST_GEN_PROGS += vfio_pci_device_test
>   include ../lib.mk
>   include lib/libvfio.mk
>   
> diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> new file mode 100644
> index 000000000000..6d3a33804be3
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <fcntl.h>
> +#include <stdlib.h>
> +
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +
> +#include <linux/limits.h>
> +#include <linux/pci_regs.h>
> +#include <linux/sizes.h>
> +#include <linux/vfio.h>
> +
> +#include <vfio_util.h>
> +
> +#include "../kselftest_harness.h"
> +
> +static const char *device_bdf;
> +
> +/*
> + * Limit the number of MSIs enabled/disabled by the test regardless of the
> + * number of MSIs the device itself supports, e.g. to avoid hitting IRTE limits.
> + */
> +#define MAX_TEST_MSI 16U
> +

Now that AMD IOMMU supports upto 2048 IRTEs per device, I wonder if we
can include a test with max MSIs 2048.

> +FIXTURE(vfio_pci_device_test) {
> +	struct vfio_pci_device *device;
> +};
> +
> +FIXTURE_SETUP(vfio_pci_device_test)
> +{
> +	self->device = vfio_pci_device_init(device_bdf, VFIO_TYPE1_IOMMU);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_pci_device_test)
> +{
> +	vfio_pci_device_cleanup(self->device);
> +}
> +
> +TEST_F(vfio_pci_device_test, dma_map_unmap)
> +{
> +	const u64 size = SZ_2M;
> +	const u64 iova = SZ_4G;
> +	void *mem;
> +
> +	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	ASSERT_NE(mem, MAP_FAILED);
> +
> +	vfio_pci_dma_map(self->device, iova, size, mem);
> +	printf("Mapped HVA %p (size 0x%lx) at IOVA 0x%lx\n", mem, size, iova);
> +	vfio_pci_dma_unmap(self->device, iova, size);


I am slightly confused here. Because You are having an assert on munmap
and not on any of the vfio_pci_dma_(map/unmap). This test case is not 
testing VFIO.

Thanks
Sairaj

> +
> +	ASSERT_TRUE(!munmap(mem, SZ_2M));
> +}
> +

