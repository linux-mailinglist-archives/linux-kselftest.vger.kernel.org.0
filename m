Return-Path: <linux-kselftest+bounces-9423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AF8BB3C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6006FB22141
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57FD157A74;
	Fri,  3 May 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhiMQcwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE615667E;
	Fri,  3 May 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714763595; cv=fail; b=X6hNNirV1ohMnnP/3XXdJBfjpuhzhkcRweps09PjJTDNAntghnx5I1+ZPi21fCzGmIcm8qm74qb/I5nCvl9mZsQMMRsG8KJexBj2XF4UA0DzdbcIGWOXxQ+KU4y8xBAowWdpa+C8xXJym4ZTkWD8K0RoA8yBEpSX8InWD9t1KRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714763595; c=relaxed/simple;
	bh=ReLZ85wneUWVcHmzVVO/NQDo3Xn4LBZmM+VJdzZ97S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t/oR4mhboZVIupzsDQJ4qVTKx/qovcHaJjKqE8m21ljC8p4U5VGy+OyZ5ITRHC59Bslap+oLeqToHAe8q+kIPfvXklP5AeLWdaGnLBbbWci//1mRs+vrgPxvkQCk+tmE9+CpPip8abTJ0whthrwR0dhzX2VWw60uuD++kc0jvVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhiMQcwW; arc=fail smtp.client-ip=40.107.102.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaLhtLwDZ9Go5S7ZN6qQHi7x+CULdE469/tGFcUvJCkUh0imVr3dqKKGg3KikEBT8nsThv1rU4oHgHleoXIMASbMaZK6pZ07J2+Odq1k8wK8DJPrA0TgYEycyvuhCXU9v9xwCHHboNQFqoYYCBnkLDMcbafMVY4Sx9pN8G1HretzbDTRk7c7TldtcW3PhOgITzNekfCWIRq1TnrFjqmg9n84IjMgGq/iJV8fsWqjEFDIiFUdC8cdy/fzBtjXip34cBnkMtbX3tmj1bvYW8/vQATWedlsmslmlID2YMkMrL/G1A1dF3mE1fyxEOgdGw6LzrntFu/fGDAN/h1HcPwYUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcRcMqrss6ke/H3hnso3CNAeIG79gu6+cSBQcMsnO3U=;
 b=P2Rhqwitk8snHpys6abwa8zUV3XXw0hc8FONPdcyKisO+VmaS+yzkIeuNRxFKOLlvqCJoxwAklcEjqLHBJhWRCVfyeHiqoxAvmuvz3IVisfZaS+PzUP85XUlTrx7FI/P0xIpG/yQnvd22AgveF3UHO/4BKEpMdSrJJ2CVWCJXVCw3MmJyDZM1WJMoqjty+aUO0gfjwdWPWmhbdwNNyJjgrW8bbbMhj+QjC0kz3A7Hi5GmMdf3UUtxZ1cDgBhHMroVqhHkpuw58Bn++6BW4ytH2cYKqEgcT5PqUUaRK8QdIEAzNphZf0lbAmBKPuT/JOK6ged4SysVrqgMLYHHh2eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcRcMqrss6ke/H3hnso3CNAeIG79gu6+cSBQcMsnO3U=;
 b=lhiMQcwWDv440Ei7g9WyhtdOfSkdnNm2zG3LHXUfXVfQpvD1JL1O8S3rxvrxV3BMHjsnyhxRkJboY0qibhKXYE8SvExvWv9mTVW0yhZvvgAdrZ5It6GSIk7MulME1L1vkahhP3gHyEK9V6XGYlbmosuHqHuY/lahpIu/xkmHlxasr+d5x3J+52zSx241pGvyeNyqeShwoMrc7jyqWlZUvWYKACdShdumPfroxShXJLOn6zji1PxCR/ph4uwRXWbrUC/Oa6ql0fvwiFsxtEURYEaIQUMGGiEDIOq+iQpIbR99m9oCwYbQ7i2LsGJM7hIUWQSYYUxkDCCuOWoxkMM0LQ==
Received: from CH0PR03CA0417.namprd03.prod.outlook.com (2603:10b6:610:11b::6)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 19:13:04 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::6c) by CH0PR03CA0417.outlook.office365.com
 (2603:10b6:610:11b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 19:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 19:13:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 12:12:48 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 12:12:47 -0700
Message-ID: <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
Date: Fri, 3 May 2024 12:12:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: Reinette Chatre <reinette.chatre@intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	"Nick Desaulniers" <ndesaulniers@google.com>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Fenghua Yu
	<fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240503023209.80787-1-jhubbard@nvidia.com>
 <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
 <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
 <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <26f3effc-6ea1-4670-a301-76df3a710fa9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 15994343-9285-4824-7041-08dc6ba50ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1NXT3lnU1FZTUZ0T1JFam5nY0tybUVxQWVFS0RxK3gvTEpUNUhPa1hTcG1N?=
 =?utf-8?B?OWdiOVJDTVJsK25LVDUwV3lhbERkcEF6dWdDMTdIQTNSd3ZMYkR0YmJLcThJ?=
 =?utf-8?B?Ynp3UkZVeXBxdTBzcTFUWnorTzlBZEUvb0R3VHJXR0RCKzZyNFFMUk9ncGpB?=
 =?utf-8?B?elI4Z1VLL2x5alNEY3BSb0xadDNhRXpzMkYwMHlJd3pZUktwaTZPbXNLNzY5?=
 =?utf-8?B?MzZEMnc1SWRYUytPUEZRamlUQ1VQb3M5MllIazhORklnQUo3anBnTzVNWHov?=
 =?utf-8?B?b2xlNDRjREZBYTFmOGRqMFhaVy9LYVNwait2dEVsU1RxWWxHWUJneEpNMWF2?=
 =?utf-8?B?cHBYY3FqbFhBZFduT2RLTXNVZDdKeUk5cTVFRVVZVUg3TUxwUHVKYzZlTk9w?=
 =?utf-8?B?WWl2WU1CRW0yK2VmUnh6YVFWUlMxNk5tek9WZW11T1lXSURZZW1rT003ZkV3?=
 =?utf-8?B?WVVIYkthZlQ2d0dWNEk3QjlkSVBYQkNxdFZTVVVEdGdMQllaMFRKQUZoYmtU?=
 =?utf-8?B?YVc3RUEzdlp1Qy85SWFqWnQ4bm9EWVJYREpzSTh0V21lanNQa0o0WmJ6VEND?=
 =?utf-8?B?N1BESkUwVlpUaG8wSlg2UnB2YWFGbjdVMGsvU2V1bmxhSmg5bE55alJxVG1E?=
 =?utf-8?B?dm9FV01tUEl2Qmh1dXFJV3V0disxaE9oSGVqVlVVdXZNS3puR21SM2FuY3Ri?=
 =?utf-8?B?NzR1cXV5K0l5bDdZNEpMRGlCdHNIcU03a2R5WEl0NWJ1ZEdwVE5mOWs3Y2dQ?=
 =?utf-8?B?MmNTcDJ6Zk9EWXNUUUNOdGo5dHBzaXhXNE5VWW05L0F1TUczL0p1VmMzSExI?=
 =?utf-8?B?UWx6RU9rUjA5OFM3eUhKRkpGaEtBei9VejIzc0cwNzAvY0xPTFdPQktNb1dj?=
 =?utf-8?B?bTNxRmN1OGQ4OU1pSEhVOUJ0U2FpQTJUMVJCRnQ5UFhEU09USENOdUU3d3pV?=
 =?utf-8?B?djRIbWF5ZlVwd3YyZWtHNXFvejR5V1UrMWZJczg5eXdOcnlRaGlIdG1IejhL?=
 =?utf-8?B?LytTY3FlTDUwNWFLejMxcmVBKyt6bXFBM2k0K2RURjFhaDdEMTlQSW9lelNj?=
 =?utf-8?B?bEtmdmtuTE9URG92NS9Mek5PdnVndWJhdzdsRWlzeXZxMFN6WVFxdGlpOE53?=
 =?utf-8?B?YWlsYWtCYU03MFlNbnJIemgvVnVlSUlFUEVlV0xDRGtzWFVOK2U0MWh4Rkw1?=
 =?utf-8?B?MGExYzFPaWJ6R3JZZGEvcmRYM2F2ZGI3Ykw0RDQya1R4VUd2VThCVEh4QjNS?=
 =?utf-8?B?UmR3clFXOSs4MUdmNVVMVTVqWW51cFgyM2s0KzNrSGpvU2tmRnQ2bGtQcU1K?=
 =?utf-8?B?NE93TTMzcy9HLzdYQVFHdVFrNWc0bDhqSTNDT0Z3VlNLdGtESFhhUVNkSW5x?=
 =?utf-8?B?SFpkZS9XUmdnOFdYOUhpS1J2UGJqTXNCNHNuS2F6KzZYZVNwbnpONHdob1lD?=
 =?utf-8?B?dUhma3FoM09Rb28remd0TUFkQ3hRL1o4bEFTSkRNZEdtdTFJME9TR2VrRGNU?=
 =?utf-8?B?MzlMYllaNHhqTnZBczkyS2pMRjk0QXZjWnJjR2VoeHpzRG56bEJpNVpTTWFG?=
 =?utf-8?B?TjJHWkpzWXRidDhtQzhVOHRDZlFicXRaVUEwc1MyLytna3pESTltK2tpNFdr?=
 =?utf-8?B?VzExMkR1SzhiUENqVkN6aExkUG9SdDZpYlZ6MFc4N1lybHl4NFFQTUdnem9o?=
 =?utf-8?B?eHBuZVFlcWVoT0twNkZSUkh2ZWRISTRnTVAzN1RoSnY2K1U2dElkeHRqajRV?=
 =?utf-8?B?OUwyQ0tEVWZkSG1kZVNzZDdyN3ByQmdwaFN0YVV4VDlMcGNobW9OdmxLU3dj?=
 =?utf-8?Q?JJ9STjLu3whX2/gxCg8MPUfWeS1fxl9DCYvJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 19:13:04.3053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15994343-9285-4824-7041-08dc6ba50ef9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604

On 5/3/24 11:37 AM, Reinette Chatre wrote:
> On 5/3/2024 9:52 AM, John Hubbard wrote:
>> On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
>>> On Thu, 2 May 2024, John Hubbard wrote:
>> ...
>>>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>>>> index d67ffa3ec63a..c873793d016d 100644
>>>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>>>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>>>> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>>>          avg_bw_imc = sum_bw_imc / 4;
>>>>        avg_bw_resc = sum_bw_resc / 4;
>>>> -    avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>> +    avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>>>        avg_diff_per = (int)(avg_diff * 100);
>>>>          ret = avg_diff_per > MAX_DIFF_PERCENT;
>>>
>>> But how are these two cases same after your change when you ended up
>>> removing taking the absolute value entirely?
>>
>> All of the arguments are unsigned integers, so all arithmetic results
>> are interpreted as unsigned, so taking the absolute value of that is
>> always a no-op.
> 
> It does not seem as though clang can see when values have been casted.
> I tried to do so explicitly with a:
>   	avg_diff = labs((long)avg_bw_resc - avg_bw_imc) / (float)avg_bw_imc;

The subtraction result will get promoted to an unsigned long, before being
passed into labs(3).

> 
> But that still triggers:
> warning: taking the absolute value of unsigned type 'unsigned long' has no effect [-Wabsolute-value]

As expected, yes.

> 
> Looks like we may need to be more explicit types and not rely on casting so much
> to make the compiler happy.
> 

I assumed that this code did not expect to handle negative numbers,
because it is using unsigned math throughout.

If you do expect it to handle cases where, for example, this happens:

    avg_bw_imc > avg_bw_resc

...then a proper solution is easy, and looks like this:

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index c873793d016d..b87f91a41494 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -17,8 +17,8 @@
  static int
  show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
  {
-       unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
-       unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
+       long avg_bw_imc = 0, avg_bw_resc = 0;
+       long sum_bw_imc = 0, sum_bw_resc = 0;
         int runs, ret, avg_diff_per;
         float avg_diff = 0;

Should I resend the patch with that approach?

thanks,
-- 
John Hubbard
NVIDIA


