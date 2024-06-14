Return-Path: <linux-kselftest+bounces-11980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B390945B
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 00:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080C4286816
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 22:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E1186E36;
	Fri, 14 Jun 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QeARnWer"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB512137905;
	Fri, 14 Jun 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405540; cv=fail; b=eWWjgtBp3w2HI4HMUQYCZe5wQeFJjJtqMW5ZK38DmlmMJyJzlc1WKu0iWzcQAn9Ogu5Gcl9axys5I/hDttLaDDjUoVxl8O4DR3zTHPjG2qFIowxZt8PjXlN3iOHSSUdYzx8LZkh+6rOzR5dK5H0K7sZcdXSB7k6TtuA1Xy7OGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405540; c=relaxed/simple;
	bh=W/IYi4SVqEXurPkX+Rl62+E+iukcpUcHGm0jQUNrepY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eH6RmEge8sto/kwZ4wjZGzHKcBCY++EGsplgcBTqqO2KaI58AnSImHKK6Qjta7pU+vjJKO6mVKRMR8gjzpYI1rvrjyFy4DQEO6jsAODAgJbJ8RkLKHv8uKzeIV1ytbayN49uFb4KFbR46n+RtTCNbbrCWParDiX0Zg5F/rWsIlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QeARnWer; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzV06Ud8ud+54zBvCOf0+y/FCHvbdolEJ+csWi31/rvZiZxiOoos8frM7nWfja1OxKpbP7J+chCVH9POgucc/iYIFMGL9ZqvNh3twCxHG4lsTRjP709iefq/iCBI/Cc+8kIcJLAok37aCmKtj5YbwYuVTYWd5BBD/NQd2ykZAScTIxHaJEaH5Dtzjnod9WdJdQlVbIuEImancgxJCPsjOmorl1RMGH2/5TppIvzDRSGy54ps75P3ERy4kcKOFCo31ZVKJ1DuOaMVLCM0r5dckOzNcQ13D2EIjgOB2GSCUUqcPSSA7VjCSjmXeShdH4aCS5xtannp2b2wL+3IDNajuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDm5UwvaS3Itxuxhm8KZFwUZHBBKLgVVgGx1D159DDc=;
 b=j4f2SW7v54bJPw5iPtk44W5JtaKyducMywIFZaZoPJsgXVcDKYDxvqhW7W3irObgSew69d6cITiPwIBqm09SmX8Sf028GQH42eYE4rqXOwpaBBBb7ujSiHKv40glSWw3Pfo3CWwANPzisuHY9Wuwdsmt/88mRzPwnbjWVRcHOw8Rb/f0mCupFqGDFCJpwW1pOEu0dD6o8qkvbsjCWS21YRfLsKiqLhGoTdYSJJLFf3dOxR4qU3nfQZsCFxHRMZk60Yegy/6C++1BRb9ZyTLHTZfdBcJjY6ZwQHYSes9ZAJxGYURU+G+P3Qi9Mm6o1CVx0q6RSXinzhz4w+NXM/F+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDm5UwvaS3Itxuxhm8KZFwUZHBBKLgVVgGx1D159DDc=;
 b=QeARnWeraYL07ugAiTO7Feve7KHVko4YgiwvLSHReJ5d/ceCZHqFzUifDMoklkrB4GWDCiXrEk6x2eIJJroxbMihyLo7AoUIqgxF0DOFPdR6PnUhFHkdP9Iscvpqipn9nWSAJYe8okhKmTIbabWJk6uz9of/Aw4Fuz8S7xkJPUmJv/YO2tLBbeYqzFW49Vh6M9BuXeQP4GBojTq8TJ35dHGS6Y/7F2jF68GCzkW6xmHw889qZcCd0Icbq0HT33Z2KLElt4v6dpqWuswFWSynEcEla1KPkGfGhyRmC+k91R869P46456TyqY0OUDh/6Okacmg9yiz2fF3PasVMN9wAg==
Received: from BN7PR02CA0029.namprd02.prod.outlook.com (2603:10b6:408:20::42)
 by SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 22:52:14 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:20:cafe::91) by BN7PR02CA0029.outlook.office365.com
 (2603:10b6:408:20::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 22:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:52:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 15:51:57 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 15:51:56 -0700
Message-ID: <2461f002-fdd4-4bf5-b797-827069cafc4b@nvidia.com>
Date: Fri, 14 Jun 2024 15:51:56 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
To: Carlos Llamas <cmllamas@google.com>
CC: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, Colin Ian King
	<colin.i.king@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
 <ZmiXqOHYaLLX557z@google.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZmiXqOHYaLLX557z@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ0PR12MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 357ddfb9-54af-435f-9d05-08dc8cc4a1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2Iwcjg0TTVzdlJHaWhaNTdnUkV3RGpMb3JOOXB0TDJDcjBOT05SeXVzZFlk?=
 =?utf-8?B?aEEwUTVBelJ2OHRuYTM3RE5rL29VdDdGVUhEVzZ4cXFwWXJIQjRnLy82NzRx?=
 =?utf-8?B?K0tRWWorNjdGZFpLTjlDRjV2MElHdTlacTlHRVcrS1JXbzhvdWEwTStXOWx5?=
 =?utf-8?B?OWNjamFLVUxmWDJVYlBha2ZKRVRMTTA3bXBGaEtLMzFXcERHMGt1RzBndGlC?=
 =?utf-8?B?MnBkWitOSm13Z1BTeTRiZ3pqTkw0NW1MbUdNU2NkeGVTVm9hSVJHZlZDZFR3?=
 =?utf-8?B?UGM5eXdWd20xMGRVNk05dldwRWxTQklPeHpvUlg3MVhPdEw0YXlFMXYyTHlF?=
 =?utf-8?B?Qk5yYUpjQ2FtNlRtemMzZG1vVFN0NHM4ODhVa2tlMDl6dFVQekk3SHpwdmN3?=
 =?utf-8?B?aGY2azYyR3BDSklpaWRIN0Nsa2RyNkZqWHV6cEZ1d09hdytVaHB4S05qVVlm?=
 =?utf-8?B?cDNFZEtId0crOE5zZEpEMnU2N0RXVjhGMitpOVNYV0x5S1dIMk5aRlBEUk93?=
 =?utf-8?B?eFFOeHg2SVpHaFpqWVRIM2Z0U3ZNckIybWcwbUJrTURyd1g1eXE2Ukd1N3pj?=
 =?utf-8?B?cDY4SUNMUHY2UWxCem95VHk1bVRTS1JjZjJrd1VjRis3Uy9WRmRVa3NDUU9N?=
 =?utf-8?B?TlJ6RTVoMnpYenBDUlZmV2V3ajU3T25sdTFkUngrMzhHU3lDVUtNMGF6bTU5?=
 =?utf-8?B?TGQ1TzJ2R09OQ1VmOGFuY0hiMFlsaGpYNENhVUhzTDVtVWZ0bjZ1VEFsVEJ6?=
 =?utf-8?B?RjVPMmdEY1FFNGlkekJxYUNDR09LMDF3RXFoc1U1eDBlK0xFZDlMcnhYZHBG?=
 =?utf-8?B?TVZSWUlCYXBXYmFUUEZZWTY2RSthdU1GQ2MzY0U4WDZISFNEUjdTeDJHY0dI?=
 =?utf-8?B?TzM1bmhXTGxVUmhyd1FENlpsK3AvY1k4TmxkVW9MYzFFUUtONStaRmM2ekl4?=
 =?utf-8?B?clRMcHVxZEViNTVLcDV5em1pbVQ3ampiZExpZUpMbTJKOE1tOFdJbFo2MlBy?=
 =?utf-8?B?QWd0ajRXREpGWWFxcHJpTnpnNFBTUENOcUFHRWgyZjRTT3k4RWcwOUNEK2Zy?=
 =?utf-8?B?RFByTXYzazFRTEwyL3pocUdsR0daUmt5eDRieFEwbWFrb2x6VVBGQjRJWkR2?=
 =?utf-8?B?dGlMS2pYOU9NamhhY0RzcC8vcVZvYllYMUwxWno3anhKWCtiRGgrOE5kS3BR?=
 =?utf-8?B?ZDI0bDk3SlFFczdVM1ZQUjM3WWJSQWd2eWVrN1RHVFgvaXdBTm51L0dUbThX?=
 =?utf-8?B?Z0grVDhvZWk0RDRCMlVobzRWOEFVellRSGNndlJsMkJDUkJEYUltVnNTalZu?=
 =?utf-8?B?SjBBYTBFUmdFY3Y2czVwckVnY1cwSWx0NkNRTGpYbTMyVnZRbkY0TlUxRnJH?=
 =?utf-8?B?aFhkcHZGYjlsWUJXWlpkdEdQWE9rNHN2dDVZQm9VT0F4aW1hQkk3UW9LbktW?=
 =?utf-8?B?VkVMdUtXMjFZWXBnSlhBSFU1VHN2Q1Z0NHpiL0grNFdmS1dyWXVkYWFUYTlW?=
 =?utf-8?B?WFFTWlA5SVk1aWNjS1c5Y2xZVVZvN2V1Tm5NalRMbjNzeWN5UWxwMnFOWXdC?=
 =?utf-8?B?UjNNVkJlN29yM3lvdksyM2xROFYyTzA2NVcrdU5jRnVqOUFsT1ZmeXVOWk54?=
 =?utf-8?B?WlIxWFNSMnNnSi8rTlVlNjFYd0FZK1p1QzMzWVNvK3pkK1EwZ3JYbGY5N1py?=
 =?utf-8?B?YjViaDZBcUhBWFNWM0ZKR01nbmVxZWRIY1l1MWVmZW1xNXBvMWJHQml5aTFj?=
 =?utf-8?B?YkQ5ekJSMnAyTFFMemcxbXNjMFlPUkgraWh6RFRabHcrTFhzU1Z4UGMzS2pk?=
 =?utf-8?B?R3V3NkU0eEhuWkpiMlcwSURiZnZCMnhoTTBlUytiRWptMEN1bnRwMGdNTDBM?=
 =?utf-8?B?V1kwUDA5TmN1bEtNQ21HdE9wUEVVODRFeTVuT21Lcm5FWXBCMUdua2s2dVNa?=
 =?utf-8?Q?FjjIWv30X+k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:52:13.6408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ddfb9-54af-435f-9d05-08dc8cc4a1fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6967

On 6/11/24 11:30 AM, Carlos Llamas wrote:
> On Mon, May 27, 2024 at 02:16:22PM -0700, John Hubbard wrote:
>> When building with clang, via:
>>
>>      make LLVM=1 -C tools/testing/selftests
>>
>> ...there are several warnings, and an error. This fixes all of those and
>> allows these tests to run and pass.
> 
> It might be best to split the 4 _different_ fixes into separate patches.

If necessary, that can be done. It's sufficiently difficult to attract
attention for selftests (see below) that I'm reluctant to make it even
harder to get it all fixed, though.

> 
>>
>> 1. Fix linker error (undefined reference to memcpy) by providing a local
>>     version of memcpy.
>>
>> 2. clang complains about using this form:
>>
>>      if (g = h & 0xf0000000)
>>
>> ...so factor out the assignment into a separate step.
> 
> There has been multiple attempts to fix this. I can see these two:
> https://lore.kernel.org/all/20211206102931.1433871-1-anders.roxell@linaro.org/
> https://lore.kernel.org/all/20240501002150.1370861-1-edliaw@google.com/
> 
> ... I guess we somehow missed those?

I guess so. :)

> 
>>
>> 3. The code is passing a signed const char* to elf_hash(), which expects
>>     a const unsigned char *. There are several callers, so fix this at
>>     the source by allowing the function to accept a signed argument, and
>>     then converting to unsigned operations, once inside the function.
>>
> 
> There is also a v4 fix for this item that was sent out here:
> https://lore.kernel.org/all/20240506181951.1804451-1-edliaw@google.com/

No idea why these fixes are not getting picked up.

> 
>> 4. clang doesn't have __attribute__((externally_visible)) and generates
>>     a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
>>     to require that attribute in order to build, run and pass tests here,
>>     so remove it.
>>
>> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> What is this about? Left over from v1 maybe?

Maybe.

> 
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> I would prefer to pick up the fixes from folks who sent out the patches
> first but I'm fine either way.

I'm perfectly fine with dropping this and letting the other patches go
in, but *something* needs to go in.

> 
> Reviewed-by: Carlos Llamas <cmllamas@google.com>

Thanks for the review! I have no earthly idea what will happen next.
I'd like to hear at least something from the maintainers about their
intentions here.

thanks,
-- 
John Hubbard
NVIDIA


