Return-Path: <linux-kselftest+bounces-11454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA9900DFF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 00:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FB71F223FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C202155315;
	Fri,  7 Jun 2024 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tkg1FErc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4F502BE;
	Fri,  7 Jun 2024 22:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799011; cv=fail; b=fmGECHU471ihh4B/krBRxoKgQyBgJc2icOSUnKZIROIprQm2E7kbT5A4bb6L70JJHogKGRuwfuC5fWm3VktFrdqVxnXe4Fc5cAABcwfVJymBlBc3tagF2MpAnfNhQp1knnYSIqluMH/BbVv+drriRlKHtaSAfLmv8/R1cWtiTwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799011; c=relaxed/simple;
	bh=Sbmll9+qAjdrNPRjrpAl0I2Z8ln8LKF67udN3txIwcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utzm1SeLZCfYYkc+T9Yx0CZGX7TjrgOKsIcaRHFlQCDH9k0s9yQvbxdPdajN/0LK1FNJq64ltR4RK/1i9w2ikgjao7Diihmt93o7YZ8KrtuhiMKxKLT4yqelSpIi7aXHqmoz8m1Tjf6OkLbrUHnTUEv/1Ar0S5zeMj1RoSWustA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tkg1FErc; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpX8TXTVqjg7wAiwhFxKQ6p+tl2n/+Ct7wHdVpNDs0BwYBpfKyQren9t7lQyr9dH59mnhErenj3nQwGQz6FA4N2Th5/pLDqxVRfqj1ibgXh6UXLavmtWLm6CarRjjp7Zv8Sp7n5oVlq9t9JyTQNLdY/gwunnIFFwpDAZe9/+Dk9ZLe/kZGVb43xiZV7Zk/1KAUEyyfwkWi5PPqaPXXMsMegchehzJ9Jcx5NC+WgaHU3U8EbZja6imW8jkQMf9LhAezdpvbGluvMZQcR1uYmA1Afint3gYj9CQT9jtgKaF4T0ej/NDz1RfkzPmYOhiulq+1GsI9BNzjKea8nOHWtIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffxxUmOl1qnu0YnFTRASpyfarCuN9RBn0Wjuir1F72E=;
 b=lSyo3cN6V2hR1dJSV1JXnT23t4IoPDZQowFXgcfRYldP0bweMtopdbA96pXD/pss+p4EhnZlD3qDWWQmkV/1mpYpHq/aeN2YSsgHvV7pUbC37hpn/VtNTkbZEsTCHxliYTfxnZj2MR8IKuZ3+Nr5q3Xfh0OQqRursqD6ThRT0K8RIGMiAMMS8BHEDcSAXu51v7Xi7jBhGPORoF3PKQUYTE/W7rDx+oZYs5RbIwpKRwzsMgYVBeBeG1tY9/0BsGMSe9BY81lld9ifZh0CVPRxulz2LT92RwKm8NMJfO+pDR/u7wHMg272oLmNV0+065Qmlnd+afq7uBLy86gGh4Azng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffxxUmOl1qnu0YnFTRASpyfarCuN9RBn0Wjuir1F72E=;
 b=tkg1FErc1Zh7ONWgFdmUeN2YOgEMGNuFe+XgZYjNN+OCsEddPP39EVrs/OkBWbMSRl13G/qJhsJXsA5XY29IZDd+riV1PtOuMtj59iZ6qX7helUBKyrj6Qc9dJSaLZjdVIE49qv7zWbQbOhKakFaoti0iGbNBKhImUBIqwp3iKvDoCr8QADm0ZFtrzcE2kIbP6cSGQ7Z/CfWslqktyzWC18jfvMNA4fKXh86PRhEjoMxrzA5HQ7o541bYYj1v2fJYB/spLtt+hqDec3KuoAdAq2m0ivlrwILU4q7TAIa2KeY125mcXDMGnINBBDYn/RI0scuD6Y6YAinEOMPz5tv1g==
Received: from BYAPR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:74::49)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 22:23:24 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::b5) by BYAPR05CA0072.outlook.office365.com
 (2603:10b6:a03:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.14 via Frontend
 Transport; Fri, 7 Jun 2024 22:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 22:23:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 15:23:12 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 15:23:12 -0700
Message-ID: <46d5479f-644d-4b38-8643-a4dd1fa221d6@nvidia.com>
Date: Fri, 7 Jun 2024 15:23:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] selftests/x86: avoid -no-pie warnings from clang
 during compilation
To: Shuah Khan <shuah@kernel.org>
CC: angquan yu <angquan21@gmail.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Binbin Wu
	<binbin.wu@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <x86@kernel.org>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
 <20240531193838.108454-6-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240531193838.108454-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: c1bcd039-5d95-46e7-fa55-08dc87407245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|376005|1800799015|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0FHZlpMZ1VjZExiK2VQYnkzSjl0MUxZVWx3T3FkUjY5TkxSek40WGFyNlV0?=
 =?utf-8?B?T1JWVkZHVXRTVWUremQrcmNpQk5tYXZ1NEpjSnVkV0lhbngzTnAwQkpvNFJJ?=
 =?utf-8?B?OUNvb2wwZ3dxVDRubG5WTk5zckJFQWZSbjJQSXpPSFFheUF4bVBNbHBhVEx4?=
 =?utf-8?B?VU1qZHEzQXZlckVpYVRiZG8xTU4wcWNsZjR6RjlVV2ZaZjBOZmIyVzVkWW1j?=
 =?utf-8?B?SURFaHBFdUZHWGxPL2ExajVSRTVoRnYvY2laeXhRUVBjZ1E3R1VEMXNnQUVN?=
 =?utf-8?B?L0xuM0dKYjBmakdvRGRTYUpzTmszWW5rb2pUZVpUWHRLWm9Gc0xOUUlBUFVO?=
 =?utf-8?B?R2V6OFU2cjFmTGtVYWpsZTJtNXNvVFlycjhxSG95dWljdGs2eWduTTg3VGZu?=
 =?utf-8?B?K08vN3MrYTBrQzdQeGNrajI5dVEwa2dsZnd2dDFqa2YwMGsxNkJSSHVtUnht?=
 =?utf-8?B?ZHpVb0pHaC9LeFdzelNBQjVyM1gzUHprRmp2Q1ptL0Y0YTV3Zlg2VXZXWS9k?=
 =?utf-8?B?UHFDb0FQUVkyR096TFVkK0N3UGlIKzNsRXl5eEEwSzY5Y09MUEw2bEhxU2dl?=
 =?utf-8?B?SHRSZjB1RWJZQ3R2bmMvTnkycU1PVm51aVBEdkxzelpNeEVNMTFId1ZJUU42?=
 =?utf-8?B?VHJONkxzMEcvNVRoamNLVGhwVEs5SkI2RG4yVWFaRC9vYUdHYmVta25RVk40?=
 =?utf-8?B?MXpPVXFZbUNWckdXZlZqWm1DL0ozTU8vWUlKdDk4b0NGUkx0SnZteUZkMXgr?=
 =?utf-8?B?VDRqM2dIT2QvMDVrdEVpSXVUS1YvM2M2S3BQUFJSc012YWo5Z0MvcWl3Vllp?=
 =?utf-8?B?aGxEeGhrK3JKUTJ5eHhOT05ta3EzRmpsSXZ5YXVxV0JtUVJwdjNvd28rOWdH?=
 =?utf-8?B?cTlmN1lEVTNITUFlbzVWOXc1Z0RoRjZ4K3lvRDVaNnEyRFlBNGNsek1tQjZy?=
 =?utf-8?B?eXZWOGxHR2lwbGJkTFhvczFoWGc1c3dXbGdJNXBBUEs5Um5ZSmxxWVVYUDFo?=
 =?utf-8?B?UHdTZWltSHcwQXBuRC90cDFCOUc3a1k2c2pRdVBVZXpDeUJXcmFMbHJ3bUpx?=
 =?utf-8?B?YVlJeG5hVm1pV2Y0akhmWFBkV0dRVUVKMkpSQitMWmlEb21KODF1NVdua1hU?=
 =?utf-8?B?bkJXdTk5VTN0UEdIdTVybCtVR2FhZmtJd01Vc3ExTmgwVlBsSHFmZFo4QThI?=
 =?utf-8?B?RGpmbHgrNnZsLytWeFZXQWdNdnM5bk9tTXkxOGMwRG1nN08xK0FQT1R6UXpI?=
 =?utf-8?B?SzNBbElKUElFaFBKbjRDakp3WjJVRFlCNWd2T0NiQ2hLR0ZlWENkV2JKQk5k?=
 =?utf-8?B?d2hwUHdUY3hyTVd6TlFYTzZWWWZNVFExS2hjTWlZNWM5Y01nSTNDV0Y5ditP?=
 =?utf-8?B?ZHNvL3BIbnBmWW5YMThMRmIyVVlFSkVCRzE5TGVSN01aVkRGbE1Kd2JXQTgr?=
 =?utf-8?B?TVBjMlZta0pLenZmcitEVTZicHByMDY5RnQ5eWJxMW1xT3hENmx3MUdLcFBn?=
 =?utf-8?B?MGxMaWZqTUxBYzRpcHFmREd4N2J4bmRENzlaUS9GVDhSd3RwcnRnN1YrZ2g3?=
 =?utf-8?B?blRWK2VJUFlUcUM1Nkh4QnJ5c1NVVkdnbncyTXlYb2d3NDJjMFQ0enR4d2h1?=
 =?utf-8?B?L3lYdnpmOEhsSmQ4YyswdllpWEI3ZHkvYW41aXh6Rk9qUmJWOW9RNXlpbGQ0?=
 =?utf-8?B?NFY1blRybDJ5ODgvTEpxaGZZREJydWFhVExRN2FzUTdUSy9OQm5XZU4remFB?=
 =?utf-8?B?TDlnWGFpdEQ3VTYxOTBSL0Y4MEFNaU84S05DR1V3eXpTNjBJRk5sczNHeWgy?=
 =?utf-8?B?U0xYSi93TmF4RlNSUzJGMEhGRTFFdER0QUVhbGNlbzdaY0k0YTdTSFNVYWNQ?=
 =?utf-8?B?V3I4VnRXWkxGdU1jN1BZODlGQ0RuS3NWUVJDckowSitUQkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(376005)(1800799015)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 22:23:24.3675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bcd039-5d95-46e7-fa55-08dc87407245
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

On 5/31/24 12:38 PM, John Hubbard wrote:
...
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index d0bb32bd5538..5c8757a25998 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -40,6 +40,13 @@ CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
>   # call32_from_64 in thunks.S uses absolute addresses.
>   ifeq ($(CAN_BUILD_WITH_NOPIE),1)
>   CFLAGS += -no-pie
> +
> +ifneq ($(LLVM),)
> +# clang only wants to see -no-pie during linking. Here, we don't have a separate
> +# linking stage, so a compiler warning is unavoidable without (wastefully)
> +# restructuring the Makefile. Avoid this by simply disabling that warning.
> +CFLAGS += -Wno-unused-command-line-argument
> +endif
>   endif
>   
>   define gen-target-rule-32

This actually can be improved slightly, as per our latest tentative
decision about how to handle both LLVM=1 and CC=clang cases [1].

If this series goes via Shuah's next tree, then I can put the
CC_IS_CLANG fix from [1] on top of previous patches, that will work
nicely.

In other words, I think we can use this series as-is, and let the
CC_IS_CLANG fix proceed just after that. Because it gets better a piece
at a time: first we get rid of the warning for most cases, then we get
rid of it for the odd "make CC=clang" case as well.

[1] https://lore.kernel.org/6b32399f-d9c6-4df5-b1e5-755ef4acf25d@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA


