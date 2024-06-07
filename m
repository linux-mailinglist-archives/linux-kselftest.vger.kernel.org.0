Return-Path: <linux-kselftest+bounces-11435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74A900CC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0DB51C20D2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C779148FF8;
	Fri,  7 Jun 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mdImtPvk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B04315F;
	Fri,  7 Jun 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791230; cv=fail; b=gi0EGsrO8MlpwHvicUeae4RB0v+wriOyMaW9xrT6yUMmyG6wfKf95UcHo8AVM8rs/SwgJzTcORnw4dQT5375UD5TMCm48g7C+eOt1ifAZPkb4PMCPZiHq+rRI569wGFVcZUx3Z+gsdJYpdMV34WwQ8h2qYzDSEaRGvb4eNCzSyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791230; c=relaxed/simple;
	bh=uVVVMo8JIdPn201vfklbFybtOQ0cP6mBgQ5eNXHU6Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q6ylpsnf0EIx9XNx+lGLa4ZcXGPfCzcbqkoZrQduu+lgeX94J7e+VXcbT70mQDOvG1fe+hdwNWavy6oWvLt/X/vsx2+NMSj0PTQx8H46j5T4ptgCQUJgFCrUHa1NWlzpBsoY4Gl83LvTfe7q0/JqbS6G2ACS7Oy1ETLdL+r5KE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mdImtPvk; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyzpnJBEMGfjWdjYEMCkntiqdDCWTzd5xP8Ks+8vDk62lnheT17qlVk1zyXslfPX3uRDVBIKMiEZuyJ6tuqif96eGq9xtARzXJV6DKqcHezkBYLKzpnVDAbpDa4PoG2i+FisB5zLsXaCO/kkTMQwsntEErWI9pkgdxofuTg0qhkfrsrFC50td7UABUzDAXofuMjUTZbXkHXRoYiGBLHG2uf0IqjfMOHfbNU8kBPnFWFGNRX3W2UItUr7ov+dpqc24i7PvmXhMrgTFNZxdIWAAr81RAuJN+w9ldNUm0jD+Sfc+xVbrDVXukLkdpnPIlzrDc5WJhdO2eNlBEHf5SkIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq8MPn4ZyXSkqVzEOk9v8MpJqc/2LWQ3ZEGCz42n4Hw=;
 b=Qm/9tc8XA72CIVghVGIo4feJzts5BXFsspIH8t8t2iJ4zQZyi7YUa9/TsocNECvYXn7YinybRZSTiPnwdzC+SxhzAuVJVbUM2RDdJ2X6Tx0bBOcT3mZRRzAZKkEz7gFTmjUD4l2EKGDLD1rPdUoi+MeQbDN9WCLX4TcVxAP0S0sWeGYFMxnxksU6K0sp9t5pJ6ohxwQFY6WYI4TO4FRUxWuMuYfQDdY0C9FPJ+yUwT8PAg18ldBfuTCLMcYsRq+YufbkZcIyM79FIWMwfcbYv0I8fPnziFkPi1yG5ktagqbQP/7ywJL9+lFjXw1aCypnSPmwfV/wLr49Vel+3+nWnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq8MPn4ZyXSkqVzEOk9v8MpJqc/2LWQ3ZEGCz42n4Hw=;
 b=mdImtPvk2LAt78MUteuh1lmLTjxPrxp5MUgdVdClTu/hxMsz7QgEsyF2eqQOROGVXM4omfkXsoTzkdfMXzPe7fiH06yPro0sd4i4B6diNPKgf+fVmOsMeI+vEPhRn152POR9X43j9RDkskuHloqktuGOnhOFHWe8B5iWQoDGVp4FZivEfUDdkZR1iILOZrpX19iAF+cK4btUSRR2nvkaXxKJYgU71auLEqNKFuVGpIWNxvg5lBsxPQqMKistptb4Re7X0BKnyL6qJlxEniSrIJHJsM1uRV7Epmp3/a61sLV1ISe2F+knlb2f59y7tUARlwiwymUJTrMZTP7pynRmQg==
Received: from MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::14)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 7 Jun
 2024 20:13:43 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::f5) by MW4P220CA0009.outlook.office365.com
 (2603:10b6:303:115::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Fri, 7 Jun 2024 20:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 20:13:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 13:13:25 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 13:13:24 -0700
Message-ID: <6b32399f-d9c6-4df5-b1e5-755ef4acf25d@nvidia.com>
Date: Fri, 7 Jun 2024 13:13:23 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
To: Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
CC: Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, "Naresh
 Kamboju" <naresh.kamboju@linaro.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, "Bill
 Wendling" <morbo@google.com>, sunliming <sunliming@kylinos.cn>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <20240603224706.GA245774@thelio-3990X>
 <2c57be33-77b8-419b-a708-e99aa9b44395@nvidia.com>
 <0d3fd536-5036-40e7-9783-80533914e32d@arm.com>
 <20240607171533.GA2636750@thelio-3990X>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240607171533.GA2636750@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7b5c24-cba7-4ee3-72b2-08dc872e5419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWhwZTFsbkpobVdMNlJkREZoQ01iZ3J4SnJJN3lCbFhZak5WQmc1VVAwS3Nv?=
 =?utf-8?B?S3VqYkZzQVBMVDk1SllITlFPcmRjcGJRNWlIR1FlYmhhaTBXY1VnTkV0cjZV?=
 =?utf-8?B?YTU4LzBWVFM3WVFMbHNqK29BbnlUenYzNVlvMkFKYU00ZFVqdUtLc1lORy9F?=
 =?utf-8?B?cGQ4VzRwZEdQU3RrS1RqUjcxRlpHeXBGZTJMRnRGTk5kdWRHa2p5a2lmV1Bl?=
 =?utf-8?B?cEVJUytTRnJDTjQ3cVp6T3NtZ2pNWDdpUkd3OXl1b3krU0JxVHBUemRqMGNq?=
 =?utf-8?B?Y1JMQUVTM0thM1VCcENGTGRYb3pVMTJuYy9jclU3YWhQdWIzNUk0NFJnUjhn?=
 =?utf-8?B?bXB4RHRJRGFhRm5KNmZUZDdMOXl4djJyM3Rkd1ZNUHZZaERBNzVIbC9ld2ZG?=
 =?utf-8?B?bVgwWUVJU0h2OHpLd1h6dG5TbkNLMXh2SVlHb1VRV1QzTG9DSytEeXpESm1Y?=
 =?utf-8?B?YUlQWlJaZVBSTVRzZzlvS2h5akttYzUzalRrSVhoR3hyZE9PV1JTek5IY1B5?=
 =?utf-8?B?dkJubFpIandkYlNLZFVqcG50T0dydndLUVRpZEYyWlBPbG92NElUY09SK05l?=
 =?utf-8?B?c3I3UkF2cm8wQ09udkRSaGttWWFSUUdjMFNiWE4rTkp0a3cwSFMraytraGV2?=
 =?utf-8?B?WGg5SG9lTGxRUExWVHkvVktWS0JjMmM4dFZvZ2JQWHBwRDdmVFFIZlRXdGQ2?=
 =?utf-8?B?d2llTE5vMGdQUlM3WkI1UmlkRFRuNnk3TjZsbVVCUHdHVWw0bW5zdlRtZktr?=
 =?utf-8?B?WG0zZmVic1RMM1R0SHR1MEoxcHRKcXQzUlBiYjNvdFlFS09rbXA0TzB6RUIr?=
 =?utf-8?B?RzFQUXNyWWdoN0gyUVFQQ1h5TkxFL05FaHJEeTZjazFOa3lCcTNsMHBncUJa?=
 =?utf-8?B?ZFo2WXNRcnZqZE1HNUc5RUpYcThSY08rams3dTVVdmhIcExNQTdYMXQvZWZZ?=
 =?utf-8?B?NUxadXEyenN6WHJrRHNOdVA1Zi82ckVlNm1ONFphUWZwM093d3ZQQnB0SXUy?=
 =?utf-8?B?dldhSDhjUDU0dGoyS25VZjZKWW1sWXVTL2pPZlJHQXlGQkhaU3JUaCtWMXQw?=
 =?utf-8?B?aTZDcXkvaEUvUlc5S3hCd2ZtUldpWmhMdkM4OVhDaEJwZDlVK0VVemNQcGdl?=
 =?utf-8?B?Z2UvdEJkOUdkdEZLaEtpdGxxOHNjaFJDZklNbWc5dEdtdWlsbVdZRWU2N2ZL?=
 =?utf-8?B?Tm5pdW9CczRjVis0OGx3WGdBblVHVnB3OThBcTBYSEhCQ2lwUlI1dS9zUmwx?=
 =?utf-8?B?aThKUXJiY3FUZ09jdFlmVmdScjN5ek5GNFJPbVYrL2RSbXNyWEs0YmE1VkRu?=
 =?utf-8?B?WG55U1daMWl4ZDZxZFhyTkRsRUhLM2ttV0hsUW1CV0NjdkZsbm5lemlPdmFC?=
 =?utf-8?B?VmFKZjJsSXRDM29lWHNvKzNMUHFPQkNWaHhpUEJpN2hNb1VadnV0QWw0Nnpx?=
 =?utf-8?B?ZmRxcjlJajZOTVp6ckdLb3BsSms3MWFoeDI5bUt3SVV1OXRqQ3htNWo1aERZ?=
 =?utf-8?B?UjRhenphbzlYRWJKWTIrQ0J1UDNrYk0yNHJwMDJmU2UwMnpjUlVKaDV0bVZ2?=
 =?utf-8?B?alltOTdndjc0YTAzVDZWOFVURklwdG1meit6T2hoVjJtcVFYUGUzQ3B2VmQx?=
 =?utf-8?B?QUY4OXRDVS9ndzNJN0xJRkVJeDk5NVBVc3JhcVlkc1hiVXhXNW1NdWl2d0E0?=
 =?utf-8?B?c3ZKdW1Qc3J2Mi9SYkJhVndyY012bm9OYldDa21CK1VucjBpTlAzODF6ZmY5?=
 =?utf-8?B?cXBkOHhseTByZVpFMUIzM2ZpaVg3QzNWQ1JjaERxbFBpTWZGUjc3N3c0SlFz?=
 =?utf-8?B?SXQwL29tTVNzYnZmTHdOcm93QTFuOEN0ZkhCb3htS3pmTlVJM2RqRWNsYm5C?=
 =?utf-8?B?ZnhpTUp6bGtJbStWRFFZbm1SMlV2Qk5RWUZJbnhtNEFSak9nZnZhaGZPdklF?=
 =?utf-8?Q?rLiDX0UWUiE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 20:13:42.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7b5c24-cba7-4ee3-72b2-08dc872e5419
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093

On 6/7/24 10:15 AM, Nathan Chancellor wrote:
> On Fri, Jun 07, 2024 at 12:12:19PM +0100, Ryan Roberts wrote:
>> On 04/06/2024 05:55, John Hubbard wrote:
>>> On 6/3/24 3:47 PM, Nathan Chancellor wrote:
...
>> If we are concluding that CC=clang is an invalid way to do this, then I guess we
>> should report that back to [1]?
>>
>> [1] https://lore.kernel.org/all/202404141807.LgsqXPY5-lkp@intel.com/
>> [2]
>> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
> 
> I can only speak from the perspective of the main kernel build, as I
> don't really know much if anything about the selftests, but I think
> CC=clang and LLVM=1 should both be valid. Ideally, they would behave as
> they do for the main kernel build (i.e., CC=clang just uses clang for
> the compiler and LLVM=1 uses the entire LLVM tools). I realize that for
> the selftests, there is probably little use for tools other than the
> compiler, assembler, and linker but I think consistency is desirable
> here.
> 
> I am not at all familiar with the selftests build system, which is
> completely different from Kbuild, but I would ack a patch that does
> that. Otherwise, I think having a different meaning or handling of
> CC=clang or LLVM=1 is the end of the world, but I do think that it
> should be documented.
> 

OK, that can be easily done, as shown below. And there are so far only
a handful of selftests that key off of LLVM (plus a few of my pending
patches). I can post this, plus a few patches (and patch updates for
pending patches) to use the new CC_IS_CLANG where appropriate:

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..ea643d1a65dc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -43,6 +43,15 @@ else
  CC := $(CROSS_COMPILE)gcc
  endif # LLVM
  
+# CC might have been set above (by inferring it from LLVM==1), or CC might have
+# been set from the environment. In either case, if CC is an invocation of clang
+# in any form, set CC_IS_CLANG. This allows subsystem selftests to selectively
+# control clang-specific behavior, such as, in particular, compiler warnings.
+CC_IS_CLANG := 0
+ifeq ($(findstring clang,$(CC)),clang)
+    CC_IS_CLANG := 1
+endif
+
  ifeq (0,$(MAKELEVEL))
      ifeq ($(OUTPUT),)
         OUTPUT := $(shell pwd)



thanks,
-- 
John Hubbard
NVIDIA


