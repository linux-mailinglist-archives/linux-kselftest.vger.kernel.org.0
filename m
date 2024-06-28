Return-Path: <linux-kselftest+bounces-12942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C2A91C706
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5B81F222C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 20:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1297641D;
	Fri, 28 Jun 2024 20:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMf5PUsI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64856EB56;
	Fri, 28 Jun 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605209; cv=fail; b=TUKfT4qaxUa581OvkUTE/PKoXDl4ncuYYz2m6Rvz82za7rq8rl0z4XGZmgM1C4XScKPt4t6QGpoX5AmE6ZNUOS+1hUlaoblVrhti3ZJXMOXwQKesCAvVrQCx4GAeU+r0Hg+oEN/FWZ8cJ4XbDqk5hVAbrDal5FEEOogpzfFOo0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605209; c=relaxed/simple;
	bh=LkOo+I3sEzdZ5/0q576r0E970NdnLtaFTo698XeHLHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nd2CgvGJU0tqcVKUPcPrpdUbE2d/P0nV9Z4Vu2YLNjKlieC0h6NEiHU7r0umYGl3oKuJN92xY3q4to1ujzFasjSItoQB/oYY8GRtwwIQxHq4QKTk2OX+WutihcfAWJCOk60oa4W1od93Sd4Jpln6dhW8r4MW8dquZYAv7frrTVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dMf5PUsI; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc4O8m4HD3xhh3t+L2iQOFN3o5svh7mgQ2GM3plgnVbx6qImIARFvlu7ezZkFx16v/MVknVet6fZy8Lbh8AxTPrYwMcOnPsSPlF2Il9bldQgxJyPqRG5Pu9Wl1+LCffDGD6RuOIAFWp72cN+BtcqsdqUJ8AMLZfkp1hlDqi/IJCnhg4QAhSeHk8sDLh2OTkj+/kYeGx6EdcJAtPWilggEgyq6zof0/OM2kJdfCud1HlVcjIjhbcTz2rfCoR/BJ0zXc6uYElBr+VZ8UMH8FmaKobZCEMcqCJX0kKvnT3GtjPYLOHaQi/FISft8K5BFF+22cb8+bQrbZSgigWPO/Uf7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JR8iVXnZdeKDigGW433l+j2NWxVpvqJBxaKw2PS0muk=;
 b=b8Gz90KbeLDSOvihhclR1e0rTo02vJoZZmgioGaU0m32EXFZZecqPsoorz0Pr4Le5Qo5AYschluz+y9wBdxo+U+6cMf/V1anIUhqMFPwxGeRvlNf5Z8bgDEs84ss2guzs6bRobhrn5KWQ8hEJGSELiyUWP/VuiNT6IDmiWkPtRJl0/Cdl1LQ0pArRQvbPp5ZbPWA8BVNoue4tOZJBFnDX1iOnHkZDVBszl5L1FNAbcUco129Ft8yZiNIrNNIsZdh7HXaeLUGMmhYppTo7G6RAVL88kA2XvZyZTDsExcpSRXaOJ2nJlmXXRZq45j+erTdy0LjTtPTu0gCprFEThHodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JR8iVXnZdeKDigGW433l+j2NWxVpvqJBxaKw2PS0muk=;
 b=dMf5PUsIzYdQEJbayuybz8t2Tok9tmo0qLtNBbNzN/169GdOKf7l1WbS/Nxu+BepA6B8njgXLHfROUjFeUasfQf/TAgDGleu4VP0ZjoKIQ0SScr8aQnBgCsLiU5Rt/frQngbS/OG4022aZ0xs6B7chW2UMEiwSeQA2NWyKHbm82QXqVN5BPXHHwGGhqS6Z+xtpIFe4xzw1qZcD5GZ0Jq2fRWHiE0ma7ySm5CQyT8YR2pleHxhdmb2+9RbbMsR61fQD7YbhlQkaqwUiAXGxnKY5ogHrgh7VcPZKgBSTbvyysMBEY/BH18Mg2pWmvDircCNyR6zPByFG26/ii99mI3Xg==
Received: from PH7P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::20)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 20:06:41 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::2f) by PH7P221CA0016.outlook.office365.com
 (2603:10b6:510:32a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28 via Frontend
 Transport; Fri, 28 Jun 2024 20:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 28 Jun 2024 20:06:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 13:06:20 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 28 Jun
 2024 13:06:19 -0700
Message-ID: <d9c56b70-6120-4de7-920b-9ece52905c00@nvidia.com>
Date: Fri, 28 Jun 2024 13:06:18 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
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
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b5eec-e144-488d-2b3e-08dc97add31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0kvWkN1ay81QmFMTnZqYTBWVFY5elRlMkM1Tk42b21UcEU1bmFRemthcjBF?=
 =?utf-8?B?Q29TMGFxcS9NWTZDZ1d3NVVHVmJIMUhtRGlRRXFFZlR3a2ZoVGRJcHBFejN3?=
 =?utf-8?B?UEY3TmJSNm80SFdEcE1wWjV1ZmI5S3Vvc0lZelZseXNNdmdyQXV3R3l1NDV1?=
 =?utf-8?B?cllGQzhsc2VCSFFzVFoxcWs0MndDRlNVbUUyNWxlLzVMSGczUW1kMnpQdWJC?=
 =?utf-8?B?eFRyUm1VTmlZc25FM05tV1kyVjk3TTJ4blRpZlpwTW5rOWVCMzdyeEdlTGVX?=
 =?utf-8?B?andZcGwzc1kwUzFNZ2xMK2hETE5CRmJVdG04VVBBWndnVVVSUEk3b201TXJJ?=
 =?utf-8?B?Nm9oajBkSm1CNkc3MWNxVktUOUFzSEgvUmRrL1N6UnVIVnRwRFhEbTcwUytK?=
 =?utf-8?B?aksvSVpMY29Id1hJdG5mV0FtVExsdlJlcnl2czZTN0tHQW02UUV1bjU5Z2d0?=
 =?utf-8?B?RnFLUEI1TFNhVUpCNlNaUXowd2pEc0VJY0JucllTeVRDSWh5ODdaSklWS2ll?=
 =?utf-8?B?MG5sYm8vM3l6YyttWWNsUHVSR0IwMVRDa0wzTW1vSWh1YktiM0hIV2x6VVRU?=
 =?utf-8?B?QVBEaXJORStsaE1WY0RCOGMwVTdmYlJnMlJlZFdUbVNpZjFobm9DUll0U0xy?=
 =?utf-8?B?M1NuL21FYVdXNk1NVS9QbzdlOGhIblFLcWhPcys3bGhzb1F2SHdLODdxQ2tw?=
 =?utf-8?B?cFJnM1hMVm1OTkdVL2NMUEtoMnZneTZZL1VSRzhFMFZLVmpwK0E4TW5jTEJo?=
 =?utf-8?B?OW13MHNKQkJwOU84YnRSN3U0Vy9aQm1aeXNGdkl2ZitxMlZrQlV6aVVZN3NR?=
 =?utf-8?B?R1BRS2ZOS2tpdkVtUytGMTdQYmxlQ0U0TnhpeEg2MTg2eEpmWGcyeTdHWmNm?=
 =?utf-8?B?QmZTSFR0RWdVK21ObXJiQTlzaVhNNTUvRXNHNElmWUFpVkpSNytyVTA3K2ds?=
 =?utf-8?B?MjlURlVTRHpwUlQyZlhjdEdWaUl3RW1WWjIydHc5REJGbDRSTU5IOFlFY3No?=
 =?utf-8?B?M3F2by91YldXQWVKam5hYzVmeWp4SGxQcnltWU9oM1FhQnNkYXNKMmxwZElH?=
 =?utf-8?B?ZExJS3h6WW9sWnVxWUkwM3lrRGRPd1VuQmlqeTVmdGJXMnBYZ0RVdGxPVGdY?=
 =?utf-8?B?QXdlQmJsV0RERTUxZjNtYzA4NXJpdU1selFDaDVpcGlSNTFTUDRwNmo2aEZC?=
 =?utf-8?B?bXJwSTl6TUVRUThyOXBTVFNBUnF5N2c1ckg5MXI4ZVQ2SGsvVUxWY1JvZFZV?=
 =?utf-8?B?QmxhSEN0QjA1MmphcmV5WXlxTjhuYTdVL2FLdkx1Tmk0NUF3YjM0T1hHTzlV?=
 =?utf-8?B?cjlaWnNaaStsNTM1NE1BUGZveEVOZW8vSVpYNkdXVmE1NE5XY0IwUy9TSUF6?=
 =?utf-8?B?dDVITnh0dXNtSDJuaThHejRwWkZZUXdtN1hDSWJFRmJSZHRXdFNUb09Ja2ty?=
 =?utf-8?B?V0NoS2J2OXZEbUwvWmdOSGg3RmpvNjZ1VFhoU1U0VGtRTnZNMjRobVY3UWty?=
 =?utf-8?B?eGkwNThsN2VEK3l1bExJQWE1V2hYS3lqc2Jkb0VHSXUvSFhrRThXbFZvSkdz?=
 =?utf-8?B?WWs0bjJKT1BybExvVVk2NEFVQUlOWm4vaEk0NWZaRUNjRkc3WUdhWHZZeExL?=
 =?utf-8?B?YWppZmZINk90U1RqWGZXNVpscDlKTllHTlkrSTIzc0t2QXhiTWpPSGRKSEV2?=
 =?utf-8?B?eXhEUlhZM3loSkQ5TWVtMUtoSVRqS3UyMnZzY0dXOEh2elhBc0QraHNvQ3hQ?=
 =?utf-8?B?Q040eVVld1pvT1g1MXJrMkRYdEtocHlmc3pQcWtoR2hjdExKTy9ZZTFRWDVx?=
 =?utf-8?B?UEh3dWpNQ0JrYytIb2drVmZ2eUVRYlp5bDczTmd3SzZ1KzZWclVFQW1OdlFi?=
 =?utf-8?B?Tm1Kdk42bDVadTdGTjNYVHdJUTlDeFR5VkxFNnV0ZWdPZk5xTERwNGQyWmVo?=
 =?utf-8?Q?oU5j4wh/lHTAi2kmPMLhf/mAYTSz5Vee?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 20:06:40.4998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b5eec-e144-488d-2b3e-08dc97add31e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932

On 5/31/24 12:38 PM, John Hubbard wrote:
> Hi,
> 
> Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
> discussed yesterday [1].

Hi Dave, Shuah,

Are either of you planning to take this series? I ask because I have a
very slightly overlapping series that enhances the LLVM/clang checks,
that I'm about to post. And I'm not sure if I should try to include
a small fix that would apply to patch 5/7 here.

(This is not urgent, because it's merely a deferral of adding LLVM/clang
support to these kselftests.)


thanks,
-- 
John Hubbard
NVIDIA

> 
> As I mentioned then, this is a bit intrusive--but no more than
> necessary, IMHO. Specifically, it moves some clang-un-inlineable things
> out to "pure" assembly code files.
> 
> I've tested this by building with clang, then running each binary on my
> x86_64 test system with today's 6.10-rc1, and comparing the console and
> dmesg output to a gcc-based build without these patches applied. Aside
> from timestamps and virtual addresses, it looks identical.
> 
> Earlier cover letter:
> 
> Just a bunch of build and warnings fixes that show up when building with
> clang. Some of these depend on each other, so I'm sending them as a
> series.
> 
> Changes since v2:
> 
> 1) Dropped my test_FISTTP.c patch, and picked up Muhammad's fix instead,
>     seeing as how that was posted first.
> 
> 2) Updated patch descriptions to reflect that Valentin Obst's build fix
>     for LLVM [1] has already been merged into Linux main.
> 
> 3) Minor wording and typo corrections in the commit logs throughout.
> 
> Changes since the first version:
> 1) Rebased onto Linux 6.10-rc1
> 
> Enjoy!
> 
> [1] https://lore.kernel.org/44428518-4d21-4de7-8587-04eceefb330d@nvidia.com
> 
> thanks,
> John Hubbard
> 
> John Hubbard (6):
>    selftests/x86: fix Makefile dependencies to work with clang
>    selftests/x86: build fsgsbase_restore.c with clang
>    selftests/x86: build sysret_rip.c with clang
>    selftests/x86: avoid -no-pie warnings from clang during compilation
>    selftests/x86: remove (or use) unused variables and functions
>    selftests/x86: fix printk warnings reported by clang
> 
> Muhammad Usama Anjum (1):
>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
> 
>   tools/testing/selftests/x86/Makefile          | 31 +++++++++++++++----
>   tools/testing/selftests/x86/amx.c             | 16 ----------
>   .../testing/selftests/x86/clang_helpers_32.S  | 11 +++++++
>   .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++
>   tools/testing/selftests/x86/fsgsbase.c        |  6 ----
>   .../testing/selftests/x86/fsgsbase_restore.c  | 11 +++----
>   tools/testing/selftests/x86/sigreturn.c       |  2 +-
>   .../testing/selftests/x86/syscall_arg_fault.c |  1 -
>   tools/testing/selftests/x86/sysret_rip.c      | 20 ++++--------
>   tools/testing/selftests/x86/test_FISTTP.c     |  8 ++---
>   tools/testing/selftests/x86/test_vsyscall.c   | 15 +++------
>   tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
>   12 files changed, 87 insertions(+), 64 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
>   create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S
> 
> 
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358



