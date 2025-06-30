Return-Path: <linux-kselftest+bounces-36097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B736AEDCAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 14:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916E11897652
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725B289820;
	Mon, 30 Jun 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcXg2QtP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E01DFCE;
	Mon, 30 Jun 2025 12:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286291; cv=fail; b=aypyTQ3cLrrc7MDfGN5evoIAM597BpBq6Cyp7G0lXePdz4tu2RDhRnYhcdvuEuz49shS7pnh4juVC+jG0D7mwQ7qNrqjl3n7Kc0cZ9mtyrvMxLf5lOy59bOhm2Hqg6/rItBlPaX9Wks+Rkoe2r3XgfayrvL6t6KshilcLTBUdlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286291; c=relaxed/simple;
	bh=CpPvCSG455W6iq09cjpwjr9KNzoudK0hAcu8xzf7dgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TUyorZzOo9Tgkyev8PKIvBf/09750768lKPTRdht6X9fwnf9GUR4CEo+AUGNfH1rEZfE34BBCvUh4IT3zyGpq8HoUZ57YtX8IrS3L94AoGJczxy1RePm2ba1rnvUXk3ngYJi3909KeCUF70M0GmeE8Em0g1hKbDdOv2dILzxpOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcXg2QtP; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6tbdJo73NomOr8t9bhg6mk5iHcfV5uGYXlw8RqODUI/SioSLs5r/eNadhussTZQa5ZtTnbHLgpHSejfHMMgjIc4Ny7YKPECQmjVeEPyVbk24bTZwQX7247iDOWSY+4ZZOD/ewKQplqgEs0tQhPq4vgoG+jDC2122eKQLGcOjypqCgtPLeq7fwwpnG3TAKBtnWc3wfFQ5SKM4Cp2lynDQ/7asABiOnTm4ICWbclEYi11NDs9/E9dLaxqBuXsQsQyoOlhQ7/pgkavpIv5bmyVKcY6ho9qXZnU2Fm/zzUxnBTViqPsqZSQ41+Aj0KthscaCE+ZStFZEka9SadsVMRfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ3KOkygRsV0hDvV8q8UHK4O4ZiQ9wTodkoWlsFq4/E=;
 b=cdkNR4seXEB6vLR/d6KnhyOQujkq/5ptexYS5PGppA+nu1BLeQBF6dABQRJAUehoSiTpmtuH0M3u7hk0IheQ961Fb+KgJ1qEaIPGAkyhw7qAkhvOyJWNMjc1GsQiBZqBcxsb0bHaUnJpzmKYasG+Ec021b7iXNBGdsKRyaB+auUjqwXxbxPfxFf9GITJFVbLkhRdy4QRblyCn8KkFQlFKGjFFUnihZixCXiWmBkz4aHC1Nl9vxfdUsfD51h45DOXXKRBIE+I8pOjl9be4cNnwC8YVwChzvscNPVYUOCWv5mrbBOo1sQUqHzjYD3wA4eNoCrVf/ja2JiKOIVy7Q4EUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ3KOkygRsV0hDvV8q8UHK4O4ZiQ9wTodkoWlsFq4/E=;
 b=HcXg2QtPfnu8/QJ4JtM+A+OsaZaZ2bA0PmW4tg3mkDYE4FL5MF9MCWMnGTkfAHOlLTCv2e0OxZccNWGqIduUfieE/CWAw3m7ApEWLeiTDs673CsCrBfEgI4Ke4TL/aj+f4qt3SYf4AvW7aTB1scux+oNPEtgHa9s1Fc586nRzg8=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Mon, 30 Jun
 2025 12:24:46 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::34) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 12:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 12:24:46 +0000
Received: from [10.85.36.84] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Jun
 2025 07:24:38 -0500
Message-ID: <97cb1442-97f6-4ec3-a11f-17469355a937@amd.com>
Date: Mon, 30 Jun 2025 17:54:30 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 17/33] vfio: selftests: Enable asserting MSI eventfds
 not firing
To: David Matlack <dmatlack@google.com>, Alex Williamson
	<alex.williamson@redhat.com>
CC: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vinod
 Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu
 (Google)" <mhiramat@kernel.org>, Adhemerval Zanella
	<adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, FUJITA Tomonori
	<fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, Sean
 Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger
	<eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma
	<vipinsh@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-18-dmatlack@google.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250523233018.1702151-18-dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: 5984b145-1037-4985-346d-08ddb7d11a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFkvWGExRmJVMXdMM0pXL3pycm9RZmZOaGpzNHBDejRabjFva2FhU2FUaTNW?=
 =?utf-8?B?ZG43UzBjK0xZYzFNWk01R0lPQnBlVlRZM0FTWGFNMkNoOUllZmpwcXdHUHps?=
 =?utf-8?B?Z2hORUJtNFc5Qkp1amVvb29oczRIaHkxVWo0ZFVEOUtPMEluZTBEWWJGYnJC?=
 =?utf-8?B?SkZpRFgrNWpUMHJMeUZqbzQzSUdzelBZcHFvZmRPNlhvL3h1Ym8rbmpoMkxy?=
 =?utf-8?B?bjJ4dlNmb04vakpRUVFrRzc0VCs5RFRCLzVvTktWNWRzbXQ2eVdhUW1Va0xk?=
 =?utf-8?B?WkYySDlJL0FlWWh3V25nYU1sb25QcndjenF2Zlo4MlJweXFEdVNDZXVnUktE?=
 =?utf-8?B?Y1Q0QlEvRklidEpVNDQ1M3hGaE1nTmNGRTZxWnRvaWorYnVUUTVHSmZOTHpD?=
 =?utf-8?B?bXk1bVc2Z1JzUjVTUEZrVmx5S1NTVHdnWmhrdjFVUTFUb3B4Q29JZWhOVExE?=
 =?utf-8?B?ekIweGVIbnpxcDZHbDFYemVuVmJvTFBZUWFKQW9sTUh2TllKSFd3MFhLNzll?=
 =?utf-8?B?REF5ZU96ZXltZUFZczBoOHRDZFhhRXRtcE9GRW4wYmR0UzNaY3JZeFpNR1BS?=
 =?utf-8?B?YUx1dk5BNktPN3BnUWlhanNWYVIzeG5HWm53Rmh6QndqR1VkcVp6RFhZNzcr?=
 =?utf-8?B?N0hpRFh3NXJsc2hqSlEvcDJaRFBmcHVWOGh6ZHNTaU0vQ3pJeWhGS2w5Rncv?=
 =?utf-8?B?NmZRczJCZ2lWYkJaeEVvQ0ltczVTeUI0bFFEaTBjR0dvQy9Yblh6N1BkT212?=
 =?utf-8?B?cEFsMnUzVFdub1p0L3BlQ0NLRHVIRCtXOGlKSFRFWnNCREpwbFNFYkYwWEpq?=
 =?utf-8?B?T0EzS0NHK0thM1IyUXdjN0ZVRElRMDZEU085SUdGL0Nsa1p2cUNadGNPSHF5?=
 =?utf-8?B?N3JjQi9PVGNsd3BDc0M4cHc3SnZVdUNjd2RaT3lNZ0RQOGlBTkJBT1lWSlRr?=
 =?utf-8?B?dFh3VGpyaHhZL01jY0g4d3dwL1pyT0RLNmVud1ZUTEJQZkJaWVY3Y2w4YmxV?=
 =?utf-8?B?cEpveFplU1BGNmIwaGpXWWpUWXZCY1hVeUpwUlBpZnYwdWxNNFlEeU9PZHZr?=
 =?utf-8?B?OEFuWjB5RUJRaTVOSi9rU094Zm9HVzZ0NEc3aDFaT21pdnVJOWd3QlpXd1ly?=
 =?utf-8?B?SXlDSjRta3RZbFlQekk3c1NteVl1RFR3Mm10Zm1nMmQzTGl2ZlNPRDgwanI5?=
 =?utf-8?B?TGpzbUxFRlpIZmR0MlFacWJidkdQYmhwKzhuTDFjbFMya1Riayt1elBrMHN5?=
 =?utf-8?B?U1hKaXVmMys1RkQ2enpwaUtlV3kwbDVtSnhtbHpVTFJnanFRRzc2eCtIcTNo?=
 =?utf-8?B?aEdvekdwaXBRZkwrcTlkYXVuVFozeUVHcmZWR0R1Y3haZndzQUJNaUtGWENl?=
 =?utf-8?B?eHVuYmNwOFBMeVlEb2lXZEluSnpNZit3SE5FVlM5VlQ5VU0xazhVTHcyZHph?=
 =?utf-8?B?ZUl3ZHlBRVlGdnlKRmhIL1Fld1ZDQWpJcm9qNEdpL3greENISEFaL3hlTUdu?=
 =?utf-8?B?V0VUSWU0R0kyZ0xuN20vaTVYY08rN052ay9qV2VmeTloTThnMU0vK1dzY0g4?=
 =?utf-8?B?K3Z0ZTM4RDlaZjJBWmtsR3lpN2dBNTdFWnp6RVFzdUFEdGxtazBZZWRXdmcz?=
 =?utf-8?B?bjJxcUJIT1BGak5jeXI2OFZBYTZsUFJQaEVmelkxK2xOdXYyOHQvSE1wUG1V?=
 =?utf-8?B?cjVwTU1tZnlSYjhpZENscVR4Wk5aZTBIYlMyTGxEZDBGUEc4L1A0TTNJbllX?=
 =?utf-8?B?cHFONVVNN3B4dGV4c0xmcjlyeVVnRUNoL25jSGRWbU8vZUp3VUhRb1Z5cWx0?=
 =?utf-8?B?ZHd5ZXc5bXphUnEvbERoTU5MWmhoamlzUThqb2VOaCtadkVIWmsxdElvNXZC?=
 =?utf-8?B?UCt5MmlKYXljRWtsbVNOaHUvMnd3WWRkb3IvQVVoelBsT1RRVmJLL29vYm9M?=
 =?utf-8?B?bjRKRDVOVXNyY1ZOYmdSNmVyV1ZMeDdWZlhzYmM3V3lUUU5LY2xlQ29OY29Q?=
 =?utf-8?B?QmQzOGk5WmpTSDYvMGVKNVBpaGNXR3ZqVmhWWEtQZERrdkNMdmhWSG9hSXZs?=
 =?utf-8?Q?XmO6jC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:24:46.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5984b145-1037-4985-346d-08ddb7d11a04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768



On 5/24/2025 5:00 AM, David Matlack wrote:
> Make it possible to assert that a given MSI eventfd did _not_ fire by
> adding a helper to mark an eventfd non-blocking. Demonstrate this in
> vfio_pci_device_test by asserting the MSI eventfd did not fire before
> vfio_pci_irq_trigger().
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>   tools/testing/selftests/vfio/lib/include/vfio_util.h | 12 ++++++++++++
>   tools/testing/selftests/vfio/vfio_pci_device_test.c  | 10 +++++++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> index ab96a6628f0e..2b96be07f182 100644
> --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> @@ -2,6 +2,7 @@
>   #ifndef SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
>   #define SELFTESTS_VFIO_LIB_INCLUDE_VFIO_UTIL_H
>   
> +#include <fcntl.h>
>   #include <string.h>
>   #include <linux/vfio.h>
>   #include <linux/list.h>
> @@ -116,6 +117,17 @@ void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
>   void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
>   void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector);
>   
> +static inline void fcntl_set_nonblock(int fd)
> +{
> +	int r;
> +
> +	r = fcntl(fd, F_GETFL, 0);

fcntl F_GETFL does not expect argument

> +	VFIO_ASSERT_NE(r, -1, "F_GETFL failed for fd %d\n", fd);

May be print errno as well  ?

> +
> +	r = fcntl(fd, F_SETFL, r | O_NONBLOCK);
> +	VFIO_ASSERT_NE(r, -1, "F_SETFL O_NONBLOCK failed for fd %d\n", fd);
> +}
> +

Thanks
Sairaj

