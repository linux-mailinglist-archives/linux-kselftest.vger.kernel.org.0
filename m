Return-Path: <linux-kselftest+bounces-13407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A96892C4BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC201F21484
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B1152515;
	Tue,  9 Jul 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="neszWRcq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA444146D74;
	Tue,  9 Jul 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557679; cv=fail; b=aL6YEHu06t3+BlpvWcxt1aRi+ZpSDHO6xElsWZHw+gpu02zuF5SVtGIe/i5xvQuZaPKlFL3uWyytmeG6QlAjnc4hRcIpxpu8h8rqLx8f81/UA9jmo2vDO+6dMdPYe0RIqsULtFBDE/FIeJXzF3RMVRQBD/CROs7smcNearahPQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557679; c=relaxed/simple;
	bh=UpMfGBSxplmNJno07ZrI4o3ZAY7WNMzTCtPnGMvZofY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=et8IJoge2xqS48Y0rKcb5azb1qqU0WCS4ZffVTnTyTGB7j182PLlTqwmRdoFh0O5FK204l6789w/iJJro1eD/FD9bf24touWgMotykA7Yl7l3eFSFWUY2tmI1mP7PMX30zBvDsmueVTWO1perMdx+R4GLJ7pt6wMmmAUvBp+X9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=neszWRcq; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2167jxtoJOCmLDy5ObZ9PIIzCDW1O1WkENiDb23blbDPm7vjETeZY0MrWd6ZmadOTdhrjyYURrWCmiFbgSBjNPXbMC3YwqjlLX8d0X9feeJ2EUE18hm0g/vDggT1Ljn4bVvKv5/F3kYivWMTKHW8EGqVPqby3W7G7bGmEcghQVahOslPD/LZPbxFzFbKkp56oy8525b/FM5wKo2YdiL73t93dnFQ37U7RVdi116xxApPcJRyXnl8IytL9W0ddeu58F887meG4hTY9gBGxGVvZA9t546+khi9BXyZEBJgiUMdHKYvVtstch7yr9r8rlOD84AVseB3LsAZXaWGY6d8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R76DRrwQCLBt0sx5H0KS2EJyGR6skjbmOA6HV9ZeAYs=;
 b=MgRHYuw3r198nqLkOdO1Rs7VDTgYtAz8JFqeugc2tFem9NPNnIrZaaUNZVsP5JaOw4N8NbCWimEK+qe0ZoEBXvA3AXb2YxySFBKoz+aOhvkOK6oMoYRenDvWBkCYUjfCrkUPTCvPIBMZROT9tsa1K2jf2hfcPQ4xhaEC2wSwujX0OUjWzQDQejvCJeHi7fG+ZK+DrceDlKCizo6W0zjj+sQ+xKujIZciMq2LpR/dUviP5VLHNUyIzHxTGPoPfp4H7j/8aJQ4XPzYr4Hi4J9SopMZf+L9zBTpj/YKjUsHad0B2bFcR/nwoh8g8/WbdA+liuq1vJT393vVKZaI8FSEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R76DRrwQCLBt0sx5H0KS2EJyGR6skjbmOA6HV9ZeAYs=;
 b=neszWRcqkf9Hwxj52/Q392Q/9C9mEmzailZdS2FEZHMjpAI70B4Y0oURUglXIX6fVQsSJRFrXIjGYT6y9ItY56FIrqwpWs3eRpEb4ipVMTB3YnNId4YHmqwwg5HSupqI1PNRLnVKgR1que1BeaMO94fsqCbym4yg1/o2F4xlL1ojjt7rrLKDC94DURyadUTeBVskeCKnkBDeNS+8is6z04QxSCwD9dMAN1dGer/wJVJPJzK8RSj8dAfPUmkStanyNP2z8ektn6L7H0K2QTmFfwScm+a4KP3HV3Opitb3qIjAOGXP8s1d+kYgUY7hLW3z6qAoGczl+nwU5rjMjWVIsw==
Received: from PH8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:510:2cd::24)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 20:41:15 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::a4) by PH8PR07CA0016.outlook.office365.com
 (2603:10b6:510:2cd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Tue, 9 Jul 2024 20:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 20:41:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 13:40:54 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 13:40:54 -0700
Message-ID: <49c14f8f-0c08-41e0-b987-7c4253edf6de@nvidia.com>
Date: Tue, 9 Jul 2024 13:40:53 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found
 via clang
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
CC: angquan yu <angquan21@gmail.com>, "Kirill A . Shutemov"
	<kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Binbin Wu
	<binbin.wu@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, <x86@kernel.org>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
 <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a08e6846-2f9e-4fb4-910f-b33fe779fa01@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 670c65db-3d89-427d-c45b-08dca0577a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTZiek84QU1JMjdRY0V3dDhDc2J3MTFQYVFMQUNSRVB2Y2ZYWUtWcE9rTUlP?=
 =?utf-8?B?U0diRmhjVHdpOTdSK2JPTkx6akg4ZC92UnV1Y2l4ellLN3pzK21EM0VvN2RL?=
 =?utf-8?B?T1J0eHVjMUVTV1dTY1dZQ04rYytzTkRaUVE3N1NsbUVjdFJjOVlDV0VvK2w0?=
 =?utf-8?B?ajFOVXFJNnFwQTB6OHJuSXV6OWtmS3J5bThkZ3gydndTOEpFT2JoaTBqV09a?=
 =?utf-8?B?Vy91Z09rUytqVTZWSzJzMnlGYkl3OWVIL2dNdTdUWnBUTkx5TmE4SVhmTmpI?=
 =?utf-8?B?NHJpQ0IvZFNoWDRFdVR2cFVIRE5xRTkxaktSSXlUbzlSK3Jidi90MHI4WWRJ?=
 =?utf-8?B?RGhGbEV5bUM2aUN0aVZNRUFZQXpJYXBZQ0VGZzBKRG8vcXdzemRIQmx5OHdw?=
 =?utf-8?B?NVVGdXpZQ0hGKytQM2Z1MURRTWlwT2hJUVVrV2xhbWsrcHIwb2FtcHdCQkpU?=
 =?utf-8?B?bmNRZjBQUFE0RjdqMmxWWGxiMlIwTTFIZk5CeWZ6TzJkUUx4VlRjUVo4cldu?=
 =?utf-8?B?N0d4R3FPQ2RTWGY3K05lbzZ1M2p6K0VEWE51Y0ZZNEtVS1FDcFJRR2l3bjZ3?=
 =?utf-8?B?VXBGZUYyS2wyWmgyQWc2MUVoeUI1SmtVTkRjNTBQcGVtUEtJcllrQzlpUzh0?=
 =?utf-8?B?VVpvTEp3Q05sNWQvUjM2MjlIQUNpVU9xSzVsaGhGL2VvNFgzMzQzYUFGRUNs?=
 =?utf-8?B?dGdTUjdtM1Q0NmhsdG9EZmVTczVZYWdxdndCVnB4OE43OEoxZ25ZZGZzTGNU?=
 =?utf-8?B?bm8vMGNaNUJ0QzdQeFI2ekw2U28vcjdDbWgybTlqWTJJazFzM1IxYm56Mmd4?=
 =?utf-8?B?SjV6bXdReXh4VHdVWlFteVhaN2NybTBib1JuZlVwd2NRZVBKeUJkbGZtVHBR?=
 =?utf-8?B?RkVveXkrN0VFRG5nZ0dvenF3aTErWTV2bElVM1lyaHlzVTQ3MGRBZGlKcHpv?=
 =?utf-8?B?STJhSDZjMkxlVFNyOU5DUTFKd29IVm8wZWRPbWRVUmRFdzgxd3hIcGlVWHRS?=
 =?utf-8?B?TXF1UTlFLzB6L21ucFhyaGU5Y2JETTRNS0pyRVp1VjY5ZUlZZ1hvSnp2UXpy?=
 =?utf-8?B?RStZOUY5NWc4NzAxcGJYakFFc3FXTGwwU0M3SmhPM2pLN1hNMlc1eTNjREU4?=
 =?utf-8?B?c2hiN3l0MEIzbGJGclhEQ3FlOVMySTRWd3h5OGtnY1ZnR1BSeE9XNTJVdkFZ?=
 =?utf-8?B?MFNXSjRmS3dLZjYwelVjS3dSVGJjdEdseUQwdmZ3aExGR0gyNkpENWVXMlpo?=
 =?utf-8?B?aFc3L29kWjFyUWhXR3EwVExEYyt0dWZ4UGZrQUM5UDdPY05PSHp3d3ZIK3Rt?=
 =?utf-8?B?N1JxOWd4RDQ5YXBHVkN3UkRhRGVQeUVyR0ZuYkdSRDVWVHp1WStKMXBReUN6?=
 =?utf-8?B?ZkVUTGpGL05GU2hwdGZURU9jRm50MVRhSDBmSWRTZzU5aTI1ZnoxT1BtNlhy?=
 =?utf-8?B?WmZ0WTRxRkdIVnB1VTVRNnNPQms3QUJFRStVMlhlUUNublIrMnpabjFoT2d2?=
 =?utf-8?B?Z1V3ZFlOL3JtSWR2c3pXeTZ3L2NvMWpDdWkyMURPZFZJTGp4bnRRc3RxRHln?=
 =?utf-8?B?U2s2RG5aNjY3M3dPbHlYbjNtdU9sanc5bitGWGRabm5idG45cDNvN0hIRjlp?=
 =?utf-8?B?RVArTC9SRHdTM0RIaFdwVjBaTUs3c0VqalcrRnNtUXBGUUUrdkcxNFNDeUlu?=
 =?utf-8?B?akFjWDdGMUU1UGwwaXdaUEtqanEvVGlIWitNWndJMXBGTmxsQjIzYzlodzY4?=
 =?utf-8?B?SldqYm80b0JzWm5CN0JHR2gvTnRidWREYWR2T0I1ejBOQS84YXJVRElOSkFL?=
 =?utf-8?B?bk9VVTgybDQxS3NtODFCa0xTUmx3eHcyZTE2SjI4SWZrN2U5VWRMSk1WUXJu?=
 =?utf-8?B?YWdxRUEwVzd0OThiUGZ4YjYxU0FnTHNibEk2UW40NnJHVStqOEgySEFnZnRK?=
 =?utf-8?Q?hEBXDFB1wBOmHR67+0ZwsZ6pl2Skk+gF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 20:41:14.9408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670c65db-3d89-427d-c45b-08dca0577a05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

On 7/9/24 1:34 PM, Shuah Khan wrote:
> On 7/4/24 01:24, John Hubbard wrote:
...>> Muhammad Usama Anjum (1):
>>    selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp
> 
> 
> Usama and John,
> 
> I am seeing checkpatch warnings in this series.
> 
> v4-3-7
> WARNING: externs should be avoided in .c files
> #210: FILE: tools/testing/selftests/x86/fsgsbase_restore.c:46:
> +unsigned int dereference_seg_base(void);
> 
> ARNING: Consecutive strings are generally better as a single string
> #156: FILE: tools/testing/selftests/x86/test_FISTTP.c:28:
> +    "    fisttps    res16""\n"
> 
> WARNING: Consecutive strings are generally better as a single string
> #165: FILE: tools/testing/selftests/x86/test_FISTTP.c:48:
> +    "    fisttps    res16""\n"
> 
> WARNING: Consecutive strings are generally better as a single string
> #174: FILE: tools/testing/selftests/x86/test_FISTTP.c:69:
> +    "    fisttps    res16""\n"
> 
> WARNING: Consecutive strings are generally better as a single string
> #183: FILE: tools/testing/selftests/x86/test_FISTTP.c:91:
> +    "    fisttps    res16""\n"
> 
> total: 0 errors, 5 warnings, 32 lines checked
> 
> Can you take a look at these and see if they can be fixed. Send me
> v5 with these fixed - I will pull these in for 6.11-rc1
> 
> thanks,
> -- Shuah

Hi Shuah,

These warnings are pre-existing. For such things, it's usually prudent
to avoid changing them--or at least, not in the same patch.

I think it's best to submit the patch (and series) as-is. If the x86
team wants the above things cleaned up (which I seriously doubt), they'll
let us know.

Yes?


thanks,
-- 
John Hubbard
NVIDIA


