Return-Path: <linux-kselftest+bounces-10798-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549578D268D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33431F265CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8771753;
	Tue, 28 May 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+ULAkiC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223D4C627;
	Tue, 28 May 2024 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929666; cv=fail; b=bEd5RgiC2O0n3X4/8t4zYJkuOAQY/zh5bKDgZ1qQ1TarwpbaDmPE8MUn97p1AeEtZVgh2YpRY92SVMx74JA/dbCv8stJmbFW+KXQx8Dm1xN/WZkTH1D65F250nnB2149NIMYCcojBptPh5KH++zR5Pydel3ta7rThuguQzXNhMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929666; c=relaxed/simple;
	bh=n5r11H/RYv2tpd0gl6Wd3ZuYqraeHaYeK+lES9K9Szg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jQAlgknBvByGGCAkF++OfQAkcydzsZJt5Vk0Uh057uZ4pd5zOIZ6kmDyEg5TGI0nbbdcd5dhf5MWHa6NCNGjr+P9JQC5OAukv62/fDraoP9twfoUi+iA2L1wJOLXh/fStqyXgKrUOg+F6Yf1mmquApyhF23ahmVvnfdQSTAq4Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+ULAkiC; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQJ4uxEY1Rg9s0qrWGhrKEzn44jm/vH+VYqdg3rDHGbJqaFutxTFE5feQukpQvvW1uB7pxtTQlKTNqROESuqozUyhVvJwKgUaBkpLCESjyEFER7d2PGADBEZgjomH9Laes06JU1wX/dSI5agFC4T2pXV1BkzuTbOV/fpw4WzJwDC319EAJfRRmv3bkjWoWTkkrU7YWxVY2qataY+KE+MxsjFWqH0bmm44hZZsOogoSQEkk0GEhQJIbdPkptJ6QCwhOTK1OG4JpabBP2vEiLBx0cmM9re6fEzQE9LCcCZIwBEccMslNY0Ae5O0bFoCff6OMCkOIve+ZUqf/+rgqFzWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SXaRiPXqCCc3/UMcyi2a3LepkN/skWXQwQ5K5Bp7R8=;
 b=m0VnZJtwnD9LymGPXwgQ12vhUGHWeNjAtfh+KsROPdf9Ppw0PWQryKGDBHkVJ+RcjVz3IvCs+n9OvTRcB44rYVQV/tcrmXRC/Q4CP1hLa2l2P25o4axclMiOfiQDket7nMH8zbrHE+guNOog63eUkfakYK697PEu2TSImQW+VhUXC2EH8sB4heyuqZJKS7G6ZZZISK85C9uHrR/X9dUFFYUaVGdHCh/0sl9mge0WfarbBIES05oS6dMk1uWZgk0aTA8v6mcBE223owkwMscq5AlyH2DVEsW+CuC+Jw4dst6bFpatkPsPDXkRaAdj8u60pLFc0q5RcqWQ2OMqHcUNwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SXaRiPXqCCc3/UMcyi2a3LepkN/skWXQwQ5K5Bp7R8=;
 b=I+ULAkiCtXsNzRiyYus0tN6qWyg/hllcO4ALoFMaouYnPKVYQsNyKR3dK1Hb7b6MbLe224xeqfedGaI/AWyHl/bQf3VTD6tpjjpBMZfLsLLJr5y7GYFXe7Ua5CVyzTK98wLcbwbsOEsFyv/ezV83/jCA8vcm3irKLpqcRqsrjBeQBEupZX9TB2oVPdU7AMM6w3WTFN9NouPYRufIl4LGLns/Y9kWEAc+Pg5Wv9difd9oMAXqYSo9AAnG3RmpzTIn0Zl+VKoN2+wMIc8x8LcHEbYGZS+O21f8ojfAeQmRUhI88kXaRG0/OpZMPxlAVojavQC3/6ERP3gP/cwFR6oPiA==
Received: from CH2PR14CA0039.namprd14.prod.outlook.com (2603:10b6:610:56::19)
 by SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 20:54:21 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::24) by CH2PR14CA0039.outlook.office365.com
 (2603:10b6:610:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 20:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 20:54:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:54:09 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 13:54:08 -0700
Message-ID: <9042e305-051e-49a6-9f8a-e19424509a20@nvidia.com>
Date: Tue, 28 May 2024 13:54:07 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/user_events: silence a clang warning:
 address of packed member
To: Nathan Chancellor <nathan@kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
	"Naresh Kamboju" <naresh.kamboju@linaro.org>, sunliming
	<sunliming@kylinos.cn>, "Masami Hiramatsu" <mhiramat@kernel.org>, Valentin
 Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240527214704.300444-1-jhubbard@nvidia.com>
 <20240528202833.GB2680415@thelio-3990X>
 <20240528203515.GC2680415@thelio-3990X>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240528203515.GC2680415@thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: d931bbf2-8c13-4235-df5c-08dc7f58595a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0VZOHFXT21QcFVydy8yQ0hsbzRuTzMyby9Ec01hcTlWSjc4RmRiN2swaG85?=
 =?utf-8?B?d1hBWWV5UEdQcmFZRmdXV29BaUkvSW53WFRUTEN4Z3dvTk9lVisyek9GUWZk?=
 =?utf-8?B?eFBhdVZLV0tJQjRYMkJENm5JWEdsbmRuWnhxbUdvbzlkOHIzZkc2Qm5HYjl2?=
 =?utf-8?B?ZFR1bVJnSkc1cWNaUXFnOHR6bkFOYjZMbndNQ2txQmd5SVZ6dHFKRG9WZDAr?=
 =?utf-8?B?MTBoQWo1YkNHSGJUMFFtYWRTdVRMY0lydGxzd3E2d2ZzWXdhZEJuVEZhVDdj?=
 =?utf-8?B?YldKWUU2REdNTFBSdHJBQmtaa2hiVXN2a1lPbXlMOUFJdWp2NHU5b2hRYXBE?=
 =?utf-8?B?RU42UWYxeWJGR09xZmwvdjFWRHAzUnE1NFFNTVJ4eDJYMThhcExZYjVhbFk4?=
 =?utf-8?B?THo1MkpRU0xKUTM2WkV3VjAxK2tzWDVhcUFEMDZvaThXZXhYQzZ6bzU2YVUz?=
 =?utf-8?B?dzFuUHpuelJvL2VMa3JOaEIvaUhONGVwZWZENDNrRmErTk4vUldObkttSkFi?=
 =?utf-8?B?SGdSYnJnc0RXeXdid0RkbmgwOU9LalhQL3p1MU1Gb0dkakNBdXNXZEtDQzNO?=
 =?utf-8?B?SG80L0YzcnFWb3dQaFdhandRTmZPdU8yREx1OXQ2bFZpcXVpdmVnR3BQK1dS?=
 =?utf-8?B?YkhlWDNLK2psNWZMOG1reXdVZk0xYmhXRU5IeS8xZU9mQ1d5bFR1cTkyS2po?=
 =?utf-8?B?ZFZzdWZJMUNXaDIwSXYyUVBqNFdWYSszaE8ra0ZFcVlsbXA1Yk5EbXBOSFM3?=
 =?utf-8?B?VHFrS3k3TkcvNi9BUERoTHJ5Mm9jSzF4bkg5c1A0d3FlRjdsUUFvU0h1TzlP?=
 =?utf-8?B?eEpneGo3MUxUTjVzWkg3bVRQSkZXL1IrQWJXazlZYjJrakxzdUp5SHlmYWJt?=
 =?utf-8?B?aXMvT0I0cDRONEJsNmhycEdlRnRmTHpxV2Y4UG1VOHE5eGZoUm1qZllWUVd4?=
 =?utf-8?B?dVJrM0I4NzZzMStWRWJDam9qZEl0MHluSkE1bFV3UFBRWHFidjdpRUI2OEdp?=
 =?utf-8?B?NEVLTEhTZW54NEdYWHZPWjJZQXFWbDNVOVZLam96UWJsRDJ4VkphWnpSV0xh?=
 =?utf-8?B?V2RIcnE0dCsrcFEwbmlHSDFnUkJQMHVQeXhTWkl6dVd0U3BHOFBXNmJ2QThv?=
 =?utf-8?B?eFFPZ29lRXh3bWxqbUluV1VOTnV5S29yaE9JUXZSeUxVYlhJaVRibVE2eTdk?=
 =?utf-8?B?WkxCOGdVanJKbVVJQS9VR0RpZHAxOHVvclR0Y2x0TnhrRTlTUnNaVTYzTmNY?=
 =?utf-8?B?bkM5TXI5Z09SWjd1blVRVGpHY3hWT241aTVzemxnRzA5N3p0V2FJRGFjTEdn?=
 =?utf-8?B?d0paOTE5T21wY1NSNVNobklJbUlRUVVaOGY2U3hsMTFRVzhrQVpqNi9hZnlF?=
 =?utf-8?B?eXBobis3Z2F3R00wNUVDbzBVazhQWmJZRHoyS2tINUlSL3VUU3N1enIrMnlE?=
 =?utf-8?B?YXZZS0tEQ29WY2g0YzJBdFZjR1htS0cvRG4yQnp3OHZpSzNMNEFWM1g4ZlpE?=
 =?utf-8?B?NGN5eDl1YXNzRjNqUVdOOFlaQ0tHd0l5YjdoRzZoQUxIR0tZRFpwNXpmZmoz?=
 =?utf-8?B?ZzJNc25mRUZqeEpLOGFSWmpWeGcvNUhITWw0RzJlQVNER0ZVUjJDVGF2RVVl?=
 =?utf-8?B?eUtVcDR0N1ZEY2xPVnBtSW1HZnFZOTNWUmthNk94OUlwZFpwN29Fb0NyV3lQ?=
 =?utf-8?B?QlVPaVFWTlNibnpMK0NtdkRwdDNyeUxoMklPaGZYUS9XZWNjUUlKelpNYzZD?=
 =?utf-8?B?aWFQbk1JdHJaZUlsdWR2eWZoSGxxeGlzcW1aWHFrWGNaakVzUEJHdnVDUEhi?=
 =?utf-8?B?NXZlME8xUFZ6MktBSDFLcnRmMWZ5R2hOT0IvOWFSYndYREZRNlBzNVhqVHhB?=
 =?utf-8?Q?KjoieEvkldrC+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 20:54:21.1026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d931bbf2-8c13-4235-df5c-08dc7f58595a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970

On 5/28/24 1:35 PM, Nathan Chancellor wrote:
> On Tue, May 28, 2024 at 01:28:33PM -0700, Nathan Chancellor wrote:
...
>>> diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
>>> index 10fcd0066203..617e94344711 100644
>>> --- a/tools/testing/selftests/user_events/Makefile
>>> +++ b/tools/testing/selftests/user_events/Makefile
>>> @@ -1,5 +1,10 @@
>>>   # SPDX-License-Identifier: GPL-2.0
>>>   CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>>> +
>>> +ifneq ($(LLVM),)
>>
>> Perhaps it would be better if this were
>>
>>    ifeq ($(CC),clang)
>>
>> as that would catch both CC=clang and LLVM=1 users? I haven't tested
>> this though.

That exact fix wouldn't quite work for the LLVM=1 case, because there,
CC is set to a horrible long mess, like this:

     CC = clang --target=x86_64-pc-linux-gnu -fintegrated-as

...but I see what you mean. It's not covering the CC=clang case.

> 
> Hmmm, now that I am actually looking at tools/testing/selftests/lib.mk,
> it seems like CC is only set to clang when $(LLVM) is set, so keeping it
> the way it is now is probably best. Sorry about that, I am not too
> familiar with the tools build system.
> 

That's true, and the patch here was admittedly only attempting to fix
the LLVM=1 case. However, I recall someone is building these kselftests
via "make CC=clang", which caught me by surprise, so I suppose that
should be fixed too. Maybe all of these checks (there are a few other
patches, but none merged yet) should be effectively:

     "if LLVM==1 or CC==clang, then apply the clang fix(es)"
	

>> Additionally, I think it would be good to mention that
>> -Wno-address-of-packed-member is GCC's default, whereas Clang enables
>> -Waddress-of-packed-member by default.

OK, I'll add that to a short comment nearby.

>>
>>> +    CFLAGS += -Wno-address-of-packed-member
>>> +endif
>>> +
>>>   LDLIBS += -lrt -lpthread -lm
>>>   
>>>   TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
>>>
>>> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
>>> -- 
>>> 2.45.1
>>>
>>>
>>

thanks,
-- 
John Hubbard
NVIDIA


