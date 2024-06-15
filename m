Return-Path: <linux-kselftest+bounces-11992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD7909564
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22B71C20E21
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF61396;
	Sat, 15 Jun 2024 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C3O6kXCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3668173;
	Sat, 15 Jun 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416409; cv=fail; b=WUFU+t/g7mlCy6x66tsexxwapgje/nNAlJ9H/m8mBBi9Xm++Qb6By55Hc8H0C3/diB0s6eq6CHUbzQyyo+qffbp+PNfpX4X0gz8/ciw/KZUlFOwJpoX5FkeWd9gRYr5MduWBNG6NkVueM4QcMr/W+vsxk3SnkIjhIQ76Qd7pnk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416409; c=relaxed/simple;
	bh=XH5HwRbAN49I4DV0rfBE92UYrVx96eroD+KUBq9x/IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bymswK0KdTN7VaodPnniWBkhWn9tqclt37+wxupw8fvxYFQNzfp+HLr/hpisaKIOSlZD081+ejJYWZnfQshVS28lYItjKAsS9yLIywLr65/UoJOUgGmafEc6Yk2/42/K3JopKY2GQIpFqUE+MHaOt7HS4dNuhysxBuLqSgkfbuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C3O6kXCf; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YX37pKcmrOYo4sCwtTBBDSGIhelmeQAJ1/sL/iJUz3eB8IyNgnF3QrvASCi1NU1EZNjB6SJHL1ea6Sr+Gps+tcJsNvyyoyyDrSep93dFzHU8n5TGy/oookKn1R/NFglDzBJNxpL24WkC6aJJ6PhicrnaPgmbxT51T5h+Z41zyEUNQP8JYDd2CEVSJSZudnW+lsrRQGmZVjHCWz7C0KSm0hbAWqaZVdHLrjDBy2+eZ94/Q6+lWYVBuSV60F8/Ev2eR3BC4KsfnP/5OAnJhPKSY4LfWhLrDnIPA1X3s0Wn6tHUk2uIlGKZgb8JJsIx1+BJ4VOFd5MpN+x3Qow1utd4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prCFSoVMAc9XTYLHXoCCUEL8AYNsjVubEjzHUE18gkk=;
 b=jFhHLi2M71PBeYD/nQr61C2Q8Kf/JUBrV+fNRPlMxzW2hKZqCpzRu0J4O0oBNQDQm0RU888NjJTELBf+Q5WDrpvj5lAsnu3LapDTIotPDdpAL64zeWafYJejZeuYyn4BmjJNU5tQ4OaBwZhUI4bptoe6rz5s/uCIxS2g7+inJED4I6SylH8q+qpiDG7QvYNMHm0AKwmrTDowFCSc5FiQayD9nIG1lIR32gLhO8wByapzs7EPfhZv16TAjgofggeokZ9FngmsAR49lj09eW5CI4FbkUQit1iuR98kE5wGxZ2iZQuzRVQ40fNz4gDku96AcXOZROvJG0F412frEBHxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=zx2c4.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prCFSoVMAc9XTYLHXoCCUEL8AYNsjVubEjzHUE18gkk=;
 b=C3O6kXCfADIG8iCPV35Hcd+lpHWlDEp0n7rsLsA+wBhkRjGLwxHgWbAXh4Vq/UWQWKtXE0bXEqxfB/mHXlUmbsqmjpWLhXtGtRv1sUuPGA6lvMq/GDm69Sg95n7gpnqp3lGGCdIe+Cdgm/1EhdfNHxeL83BFcv2AHa6kuVgF+txnr5TKbjgQRb5RQ34T9IX5/1sZWPiR0OrpWCn01ebP+VJo+AxQV7mcenrfdip2bmBeZqcgYD4cF6/yT/bksvvMYLyWZf9bEBlCoXAesDGDsEXn+00W/Fj6hlcsZDDeeBSoNjLBjLt0tgSEpVAowPF5foBIseCUHkzPCM8Hb3KG6A==
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 15 Jun
 2024 01:53:24 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::af) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27 via Frontend
 Transport; Sat, 15 Jun 2024 01:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 01:53:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:53:12 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 18:53:11 -0700
Message-ID: <13483c92-cac5-4a3a-891f-22eb006c533b@nvidia.com>
Date: Fri, 14 Jun 2024 18:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>, <tglx@linutronix.de>
CC: <linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>, Carlos O'Donell
	<carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Jann Horn <jannh@google.com>, Christian Brauner
	<brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, Samuel Neves
	<sneves@dei.uc.pt>, <linux-kselftest@vger.kernel.org>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-6-Jason@zx2c4.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240614190646.2081057-6-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM4PR12MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: 9255a5e8-c346-4d7e-db56-08dc8cddf0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUcyd3dMRndtTGNidnNPZHRHZ2hiSGRwdE1RTmZZZms4ZzFUYWZFdEQ1Q0gw?=
 =?utf-8?B?QTh4bHZDbHBGZ1B0Y2pBc1ppTHd5bWZoNXBiM1k3T3U3eWZaMkdobnk4VytY?=
 =?utf-8?B?YWpHK1hvajRnWWJ4eWIxajBlS0ZYZStvejRiQ1ppRGZHcXpNNVFaVDBXalBU?=
 =?utf-8?B?em94bVV3WGducGxYcllIN0gxYVlZaExPeDVHcDVKQ1N4TStjUTV5MWdqU3lP?=
 =?utf-8?B?MWJwNndzbzZ2NFJnK1c4c0Q5ZG1tWGRuVDAxMnlnVjdrdXJxYzAwa3lSQTI0?=
 =?utf-8?B?Y2hYOXpVSnZMdUYvbmhld2pCUmVXQzFidWkvNGJNd0dmS0NyTWNkQmYxdXkx?=
 =?utf-8?B?bE9selZ6cnlRZWk0SjRRcDIra1FHQktlRjBPV0gzOUlncnJieFZCM1VPcVVT?=
 =?utf-8?B?UU9zVjUzaVArNG5xTG5YU0ZkT1VKQzRHcElwNGVBUGZnd2YvMzA2U0NSMnEv?=
 =?utf-8?B?OEEvdDNvTXJUQTc3bWVOaWZRVHhaME5jUThHN2dERlZ2MXJ6REZEU3pjcGNS?=
 =?utf-8?B?ZDUzNUVqbG9KRXpuS1lEMFcyWWxYTVp3VlBQa2NMaCtqNnVXQUNPN0pHRlNI?=
 =?utf-8?B?YktSQ29odTE0WXFiREZ4Vk1wV0NZNFBMbkRDK2ZSeld4M2x2UUZlaktqU1JL?=
 =?utf-8?B?ek5aUi9CZjc4ekpzMmM5WlRQeW5Pd0hBSVFyZG9QeFB2Yi9OdHJBeVJzQ0NU?=
 =?utf-8?B?bWgxYmpScUJwTU1RWXZkYlRXY3BGZVJ2NlhJQW16YldZVmJ1ampHSlZ3UC9Z?=
 =?utf-8?B?NHlaNzc2WVZzQ0wvYldoMW1sSkErSEUwY1c5MEY0cHU4bHF0L1YxeDlTNTgr?=
 =?utf-8?B?Nno5L1RWL1JCTndrNEdyeDJqLzdPRDBCRlNMSjFHYTdOb0JWaDR1WEVwTlpZ?=
 =?utf-8?B?cVo2Q0Q5QUYrbG9xcWtOTXU2YUwzaUtuTnlrMTNQY2MvZlJCVENHTEVwTldX?=
 =?utf-8?B?bkx3RmhXNzFnSW1Ic3VLaXlEbk5PZW0xOUt3SDIxL2VESkFKd0ZMZWxtR1BU?=
 =?utf-8?B?VlZxaGdicXpoUDZKWFZpZk9lVkYxL21jY2w1QlRIZGJSMmJYN1ordXVRWEVi?=
 =?utf-8?B?RXZqQmFsTzAzRFVZNWcvRGJvQzNXRG10amRGSDE3Mk40VVdUSnJWU3gxS0l4?=
 =?utf-8?B?WFM0WUh5bVRDTCtCN0dVcUhINHNjb3B6Yi9HOThoTDV1YVpQYXMzNEJLYy9N?=
 =?utf-8?B?K1JqamdlTVlYTGxBMWRneVhiUXRER0c3OXlvVlhaZVg3ZDc1UkwreEZVOWdq?=
 =?utf-8?B?ZytVVGxCVHg5QUVHY2trZTFhTVdId2NaY1JOTE8xSmhKdUc1aFBiVXBTdzVB?=
 =?utf-8?B?VEFrcVVwd05tZVlRRWxIeWlUQWtkWXZxY0Y1MFpJRC9hWjRiVlV4dVlFc1Nw?=
 =?utf-8?B?Zyt2dDJFMUZVMHFaSXZ6MnRjdVFDRUh0cE11L2MzZmJmZ3lZZFZlbzh1ZHdW?=
 =?utf-8?B?Y1NYTytXdnBWNlI0bm9JOTNvajZhaEw0ZmVPYklKakZsMDRCcnNNcHd4TXBj?=
 =?utf-8?B?eVp1REVNTnVVWTRWbjhzeGNuUkxuSUlhWTFBNlBvcWJEZVpHY01YbVdqZVJS?=
 =?utf-8?B?U3V2cTByS1Zsa3RNaysxSkVoK01aUlk3ZTdTdUx4WGs3aWxvOHozNWlLK1d2?=
 =?utf-8?B?QXB3K0lpZUJBRk8yZFNBdUN1NWtDVU5PSTRLb21BQzZZdmFqNy81N1g1Rmg5?=
 =?utf-8?B?WGVIVkF2YzRyTUZaVTZnN2NlU0V1MDFLRnN1bnlkbFpxekNwSU9uL25LRjJY?=
 =?utf-8?B?OXRrSmNsTFJDQmU3MFI4ZVlEbXpXU0gzMVM1UmdvdmtXaUJDbGE0aFdxT1BV?=
 =?utf-8?B?dWVhbEw4bWlUWjNEZEd4ZkY2ZFhMWnJlY3ZMYTRqYmU5WlYybVJUNFpHMWpB?=
 =?utf-8?B?L2ErYlpkQnVMWVZCa2x0MWRGalZwUHVCQlAxK0t3emFoaTdiNnVmOHVYVkVV?=
 =?utf-8?Q?tmpdWE3X41s=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 01:53:23.7226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9255a5e8-c346-4d7e-db56-08dc8cddf0f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501

On 6/14/24 12:06 PM, Jason A. Donenfeld wrote:
> Hook up the generic vDSO implementation to the x86 vDSO data page. Since
> the existing vDSO infrastructure is heavily based on the timekeeping
> functionality, which works over arrays of bases, a new macro is
> introduced for vvars that are not arrays.
> 
> The vDSO function requires a ChaCha20 implementation that does not write
> to the stack, yet can still do an entire ChaCha20 permutation, so
> provide this using SSE2, since this is userland code that must work on
> all x86-64 processors. There's a simple test for this code as well.
> 
> Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   arch/x86/Kconfig                              |   1 +
>   arch/x86/entry/vdso/Makefile                  |   3 +-
>   arch/x86/entry/vdso/vdso.lds.S                |   2 +
>   arch/x86/entry/vdso/vgetrandom-chacha.S       | 178 ++++++++++++++++++
>   arch/x86/entry/vdso/vgetrandom.c              |  17 ++
>   arch/x86/include/asm/vdso/getrandom.h         |  55 ++++++
>   arch/x86/include/asm/vdso/vsyscall.h          |   2 +
>   arch/x86/include/asm/vvar.h                   |  16 ++
>   tools/testing/selftests/vDSO/.gitignore       |   1 +
>   tools/testing/selftests/vDSO/Makefile         |  13 ++
>   .../testing/selftests/vDSO/vdso_test_chacha.c |  43 +++++

Hi Jason,

This is a large patch, so it might be helpful to split out the selftests
into their own patch. In fact, my comments here are only about those.

I'm adding linux-kselftest to Cc for visibility, and I've also Cc'd you
on a related selftests/vDSO series I just now posted [1].

In fact, I think it might work well if you insert patches 2/3 and 3/3
from that series, and build on top of those for the
selftests/vDSO/Makefile. See below for details.

...

> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index a33b4d200a32..8b87ebea1630 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -3,6 +3,7 @@ include ../lib.mk
>   
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>   
>   TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
>   TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
> @@ -12,9 +13,15 @@ TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
>   endif
>   TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
>   TEST_GEN_PROGS += $(OUTPUT)/vdso_test_getrandom
> +ifeq ($(uname_M),x86_64)
> +ifneq ($(SODIUM),)
> +TEST_GEN_PROGS += $(OUTPUT)/vdso_test_chacha

Unfortunately, this is "pre-existing wrong". :) That is, it is following
a pre-existing pattern that is broken: the $(OUTPUT) is not supposed to
be part of TEST_GEN_PROGS. Fixing it requires other changes, though, as
I've done in [2].


[1] https://lore.kernel.org/all/20240614233105.265009-1-jhubbard@nvidia.com/
[2] https://lore.kernel.org/all/20240614233105.265009-3-jhubbard@nvidia.com/
[3] https://lore.kernel.org/all/20240614233105.265009-4-jhubbard@nvidia.com/

> +endif
> +endif
>   
>   CFLAGS := -std=gnu99
>   CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> +CFLAGS_vdso_test_chacha := $(SODIUM) -idirafter $(top_srcdir)/include -idirafter $(top_srcdir)/arch/$(ARCH)/include -idirafter include -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 -Wa,--noexecstack

Line breaks via "\" are allowed in Makefiles. Might need two or three here.

>   LDFLAGS_vdso_test_correctness := -ldl
>   ifeq ($(CONFIG_X86_32),y)
>   LDLIBS += -lgcc_s
> @@ -35,3 +42,9 @@ $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
>   		-o $@ \
>   		$(LDFLAGS_vdso_test_correctness)
>   $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
> +$(OUTPUT)/vdso_test_chacha: CFLAGS += $(CFLAGS_vdso_test_chacha)

This also follows an unfortunate pattern, which I've also fixed just today
in a patch [3]. Please just add to CFLAGS directly, rather than creating
these name-mangled intermediate variables.  See [3] for how that looks.

> +$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/arch/$(ARCH)/entry/vdso/vgetrandom-chacha.S
> +$(OUTPUT)/vdso_test_chacha: include/asm/rwonce.h
> +include/asm/rwonce.h:
> +	mkdir -p include/asm
> +	touch $@



thanks,
-- 
John Hubbard
NVIDIA


