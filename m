Return-Path: <linux-kselftest+bounces-11131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB468D8B47
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B77DB2147D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0316213B588;
	Mon,  3 Jun 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lkq0VYc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B46131182;
	Mon,  3 Jun 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448806; cv=fail; b=nCaetNMMplTERyOOUdcPlnv3hKrrL6J9OCnsNvs5RPDVw9XHMOXdw6d84BfTyKVR3gZISXa7TbE3yIYtzkylI8U3+P+HPm7HFkMvsV1tMxjZUKPVohdCvX7RCwpk+a5+Lcl1ZuBLrT7KkKHn3gbvCTFLIdvRCLJVMPjPVJIrpT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448806; c=relaxed/simple;
	bh=qWeJxRKbDwY92uYHGjJZ+HVapxS+pTClxOoFOiLGwTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KwXRl4osLhaypK2A8Y1K+Nzf9JzfwcwxLAJJfikI5zkdccySoRmeBOd0vNKq8OSxQAdYWa+SHWt7KdSvspTbNpriH0HtXZ6GrlwAkB6EvRsx7t33Vzk9F+OntkCONmUumOa5LZq9FKL3erw9OScmmP4XXu5PIAETZ669NZJSWXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lkq0VYc5; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHfJTUHtcL3Zf/X0PVKdjAbhESUXD47r0RQSNIN9EfYpsJi0gEmzsW016TldgFQWLpQ2QPY22ECSk8CsFwyWU6wiVJo71QUv6ci4TC7E3HuUT45N6aRYUTqWDjEwwW/7XDdRWeMy4q3cQ9FjOLAgoWWaYm8pD1i+mWakg5dxxTho5WUnFJ1Jg2NlHQ7/fp4ha1xYx2t+oE/iem6OnVy1MrQVYOnaAuzNUeoammz9uLULIVz2PHPvOiWjzxtoTJBqCqVzNImcslTeTeB3tYTxwEgArn3vnYniYGueSijxXqLxKEIuE/kuJE+q5u0ymcL+iSYje3P06ZSGBEWq8vFUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d8laI4QXPJ6bZi75jewfwfk2a5/H8yWV1zQnus8arw=;
 b=ja00GK7tfq+WKho23cj5jUfF7po/hcHLRxT4Z5R/BmPHukCgq34HTDDKJi3wY2o5PTPDAA4cEtCZ6iVQ/v/+nqU4yodBPxDIPfGiHdXee4BijhXfbkBmJlQXR+nitzwokArJ2HlmoAvyXjQec8Q7tHBmzbzsYwwKmOfg6F8bAycNSnLO+DjDYAzUY9oWizFdvMXxT7T2p9Z8a4be7nha9PIDg3Z3sOii9RGdCoILeundz5tvXGamlMdfS79fR/BB2SIX8GR3CrUFJI281ao+BXJaqSNr7CQA1s3dOWgCuJO7jF+Y3wDspbjf8Hz7Jg2Ff0NbjUlV09RTF3izanm7tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d8laI4QXPJ6bZi75jewfwfk2a5/H8yWV1zQnus8arw=;
 b=lkq0VYc53nP52Dq5CS+lg3fmXfEZMkhczSJmEbBXng4KKFan9CAeHPYTFMXa312YGFIDsiT3TNJ3aOudRnDhYog4DClVNF9dFRPbFpJ2C/r3V2EuoZZXFtHHDybFSyFLKsZWIi59iLRFBAno5gbqYNWnOsVZleDHaPtCIsMYsvdoFKvIGM5d8cenMohN5Xe9bJpDBWgoDsw6XKlHARExzZv+HeLIdxsRKqlWe+WhAx/vK2/d7BCfdKhzqDTvlh5UxIhjl3gMVgC6W0H8XJgT2P4Y9KDTPt3k172D0PsgBpC0hyJ3GflJnGGCREprlOSJG9BB1AvapoI7FwZ3GaMEVg==
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Mon, 3 Jun
 2024 21:06:42 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::43) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Mon, 3 Jun 2024 21:06:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:06:20 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:06:19 -0700
Message-ID: <7abbc35e-1399-4d05-90b5-6c048ff4de14@nvidia.com>
Date: Mon, 3 Jun 2024 14:06:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] selftests/lib.mk: silence some clang warnings that
 gcc already ignores
To: Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>
CC: Beau Belgrave <beaub@linux.microsoft.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-3-jhubbard@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240531183751.100541-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 30df030a-e1e1-4f5b-736c-08dc84111186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enR2ZW1zbnlvbWt3M0JsU0Q4b2VSQXRMN0VtYWpLcWFwSUhpSjdnUDkwbk5U?=
 =?utf-8?B?aC9vdU1kNXFyMjBEWGgyZXM2blZsOEpxeE5aTmxPZHQ4cllmd2gvUzY3TFBm?=
 =?utf-8?B?QzdsNytXRjMrWU00YThHeUMzTTI0aDE0MXFiYmwzaWRxanc1T0p1SU9ybnE5?=
 =?utf-8?B?SG80K3p4Qk9XWWNPQitWUFUvYU0yaDZWeXFJOXpOT293UkEzeFA2dlN4QjFH?=
 =?utf-8?B?RWdONmV6RDFUTGhDZlBaM2FpZXJicE9VS3hZanp6eitLcVZGdlJkMHFTanoy?=
 =?utf-8?B?THpSd0xOY1pnc2ZjVkUzaFYxSm1QQXdTV1VFS3ZFTFBnZlRjWTkwbDVYNzhu?=
 =?utf-8?B?Tk94WW9pMHFxWWNGQWFZb0ppL013K2F5eWtFV3F4a3JiR1lQTXJwazlLajVU?=
 =?utf-8?B?bGduYjN3bGpzU0FLRC9aTVZxUS9BdmFiWUlKTHdaSkRCT0s3TjkvSlM4a0No?=
 =?utf-8?B?V0loVkNiS0oyaUdFMTQrRDBGd0JYaEZaNFNabVBBNm5USVlFTG5WSDBzbHJk?=
 =?utf-8?B?NVA5QzBGbStlMjY5ckJwL1F6K01sWXhiZlFvMVc1Wk5HbGlCUnNHWHZDRVlH?=
 =?utf-8?B?ZVpkblA4QVNYL2FMUWhQclJCaU5GSnVlSHM3SDFWQ1I2S1RLMXZJQnhIY3N4?=
 =?utf-8?B?KzRZcW1qNS9ZYVJVWTA1MHo1OG9MQUZ0RUh5OHRHMUdKUDE1M2l3YUM3YVZw?=
 =?utf-8?B?UXFkd0lKV1NVQ1IyeG5TMjBjUGFVeGp1NTA0NjBzZitQclZHcjdUZmVxV3d4?=
 =?utf-8?B?NE1YU3FKeHc2dWNDbjNXTFI4RUpPdzNkZE91cTM0Z3JUZm5wVlF1MW9ka2tk?=
 =?utf-8?B?ZkhuaytaTHN4UlpvWG1weEQyMjFmWFcrZ3RlYjZVeGhQcDIyL2txSmVKbUs4?=
 =?utf-8?B?Ymw4dUV6ZlJNVXZhK2FiOUJJazlZbDF0Y3JaN3VCRnR6ODBKNEZJNGpCV1F6?=
 =?utf-8?B?VmFXYUlkQ2N6YVZFa0xlc3M1a1FPSlR0Znl2U3JIN29WblUxc0NzR3pDbzRx?=
 =?utf-8?B?TThBU0p2blJFenhLdjBtTjRqU09sczdpd0c4WkR0RHcrakxzTHB4U1hzYmZR?=
 =?utf-8?B?TGJVcVRMRVFnWGM2Y0pqYTgxY0g2bTV1aFJYMzd5RFVRT1RmMm5MaVQ2cFBq?=
 =?utf-8?B?bUdhTEZ6MEZxdkdTc0NWcFVIUVg0Z0l0R2pwbnZWSHFpVWVoMUI3TEhZbGJ0?=
 =?utf-8?B?U0xrWlUwd3B6dnBZL0RQSVp5NEVPU1IvY0N5VEtadjVhL1JpVGpydDNyZHcr?=
 =?utf-8?B?K2FnN3o2ZjZTYitWMllnUTIyTFhPTXZWZDJvT2ZYN21kT0dnNE53WDdIZ29x?=
 =?utf-8?B?VTZ6M1owRTBzdmVjYVcxQTl4Sjhxd1pFRWhBVGZWZ2RMZ0ZMcGJSRFkzcmdJ?=
 =?utf-8?B?ZWVra3ZIano0ei9mdHY3VFFyRVJyTXNWT1lod0FWU2RML3IrREdVYmdaeDJV?=
 =?utf-8?B?STFDUUJReTZ3aEZqZFNNa2RBU1N2Unk0STM1eEhIYzd0NUxCMmgrUnUwVVFH?=
 =?utf-8?B?Z1RlRlRFSG5WeExlaXVBQmN6K1YrMlhDVldYT3dHNGtlczF5QVZ6dHpYUWhl?=
 =?utf-8?B?Y2dYc013aUFpUUFEYWdSelZKbjFWb29peGdkeDRQdDNzeWpPdktXZnA5NDc4?=
 =?utf-8?B?TTh2eUF0blYxNnhkemFCQ3lMdHRhb3NubUdmQURzN2NKdWFTRTZqWENPby9y?=
 =?utf-8?B?Si9VSitDYnYxTC9oK0FaeFNhZ1k5b1E2STlTZ2djOHpVcDdyMmMydktjSUo2?=
 =?utf-8?B?N3liTVZORlY1ZmlYNnZ2Vkt0SHVtWW40cUZGODMyOUFza0o2STF5alhZZjB3?=
 =?utf-8?B?ZmpyQldjWFgrWjRabng3a01nU01vdVoweE1QZnJWR0d6YU91NWswRkVxaHgy?=
 =?utf-8?Q?CM4LuzQmgNBQK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:06:42.1227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df030a-e1e1-4f5b-736c-08dc84111186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

On 5/31/24 11:37 AM, John Hubbard wrote:
> gcc defaults to silence (off) for the following warnings, but clang
> defaults to the opposite. The warnings are not useful for the kernel
> itself, which is why they have remained disabled in gcc for the main
> kernel build. And it is only due to including kernel data structures in
> the selftests, that we get the warnings from clang.
> 
>      -Waddress-of-packed-member
>      -Wgnu-variable-sized-type-not-at-end

Even if patch 1/1 here is not merged, I would still like to get this
one reviewed and merged. It still solves the problem for LLVM=1 builds.

thanks,
-- 
John Hubbard
NVIDIA

> 
> In other words, the warnings are not unique to the selftests: there is
> nothing that the selftests' code does that triggers these warnings,
> other than the act of including the kernel's data structures. Therefore,
> silence them for the clang builds as well.
> 
> This eliminates warnings for the net/ and user_events/ kselftest
> subsystems, in these files:
> 
>      ./net/af_unix/scm_rights.c
>      ./net/timestamping.c
>      ./net/ipsec.c
>      ./user_events/perf_test.c
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/lib.mk | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 2902787b89b2..c179c02281e9 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -50,6 +50,14 @@ else
>   CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
>   endif # CROSS_COMPILE
>   
> +# gcc defaults to silence (off) for the following warnings, but clang defaults
> +# to the opposite. The warnings are not useful for the kernel itself, which is
> +# why they have remained disabled in gcc for the main kernel build. And it is
> +# only due to including kernel data structures in the selftests, that we get the
> +# warnings from clang. Therefore, disable the warnings for clang builds.
> +CFLAGS += -Wno-address-of-packed-member
> +CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
> +
>   CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
>   else
>   CC := $(CROSS_COMPILE)gcc



