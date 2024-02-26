Return-Path: <linux-kselftest+bounces-5448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BA4867F7C
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3711C2ABA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Feb 2024 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD612E1F5;
	Mon, 26 Feb 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U2wKS7Ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758012EBC1;
	Mon, 26 Feb 2024 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970562; cv=fail; b=rYwL95deLBN7Y7RpcXlpdeGJ0Kbg//TIwzF5pcZIcX/k44As4clOGzFFGJeH3wIBv74opxJPDVrOu2sfMnL6d3BCkTGxzuVdicB5imJYhUsUohYCabevv3dFPGjXnvGGOZp659fhFU1T8fd1qF+VDS7prgKuznIsDm1dKrIj+8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970562; c=relaxed/simple;
	bh=FjOK5YKkXSJt4ZvEnErEKZJwNIVvj02qvXJsO5xVRE8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lg9xihMrF/8gihFLvHoo+WLS3u0me7SsF4msGmghS2qJ8l1LeWh8zliT7qa2vnoiynVv6ZsN8Et3dUviphJaE/pSMyejfrP9DyqsxSfv3pcnHd9bGQJHZSY7wuIqu37/+KwZ5pleSG6miuwIYaaOejpNw9kYfS5nl8APqR/mOzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U2wKS7Ii; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgP+GlWSYuNLCqh+hMSS+i6A+VK7WP4rnp/m0tUF5w8/Hem0trXxEv9JtJOzpJ/CtgPvPcK5uI5ojb2gVSLWxyBESldIp/HvxtoiB4oiANQs9ev3Fr1IhaKrNkLe2VxuhJkzbyupEgiNqnBl5lIJVbdWSvy8JbaAtMsgJpRDlFV8nF1saZhajWX548bGG3NOIEysT5hgWLoDrJv3U3XU4lwJawS7BGTFDHX/6aWOgEJ+l4HOPrX6TV/lJ5E5HkX/G4YmoXTCBQ58mSgSPjviXu80sQnlCII6vQ6EO/YpKsZacmZ6Of/ohBoZAgoeyCfN0Z3/Er8oBgDOkkldx6DEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMqgwB0TEyyICd+7D+DFsaoJVCFAmXPuCe2VZsANJNg=;
 b=bBy1J6xlygon6DZaSgVton8ewXM0wYpDCIF+fC+R5NxmiDIuvqvCi59t8Fzh9bO2VzmNrvBKHO9NyKl/RYbn/NJzPo+J3bxoPl5amNC/WpCLDAwBiYUCwIrZY97p+7oFZsM1JFo7c+crllC0aCEiZlMjeQRbfTddqUB9H50AOzOw4uN7BHH8Msa25J2VdOzNH0fVVNlsBwJSzBGEUPVADdgTR6yDx+Np/wJKGEYux/+26MyrSw9T2+JM1yPxatZN5AsLRrTE6E6mk8IZPobmqsL9+PIVZlRK02LyXTKTrBAg9L6g+M01KP8880rqer8nHuP08cofnUowSZbgKRpJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMqgwB0TEyyICd+7D+DFsaoJVCFAmXPuCe2VZsANJNg=;
 b=U2wKS7IiAAdQxq1Ru9RdONOYL/OqGve07g5QZ9ufkxbNYQhl06EiS/eph5mZZcL5c2qzRvbQn05O4CiU8K13FZ5gXXubQauWApuSd9zYUkUUuIgjufJMPoM+PpHZZf18wPPRggwz5vWF+x+IjYwVCzdZcryapVLBQb23ALHzQQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB8093.namprd12.prod.outlook.com (2603:10b6:806:335::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 18:02:35 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 18:02:35 +0000
Message-ID: <62200490-6dcb-4c35-b358-b9c63e580787@amd.com>
Date: Mon, 26 Feb 2024 12:02:33 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH 3/4] selftests/resctrl: Add support for MBM and MBA tests
 on AMD
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, shuah@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cc22790173de9978a6485baca5bc96a8ad8e05a4.1708637563.git.babu.moger@amd.com>
 <6f611a0a-f2ef-1017-07c0-5d805abb80d4@linux.intel.com>
 <efab7efe-d043-448e-bc7e-4a756b4f3367@amd.com>
 <fd71d5f7-08b8-4042-b94a-e81cc68c975b@amd.com>
 <9f814712-7189-424b-9af2-67f565dc35f2@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <9f814712-7189-424b-9af2-67f565dc35f2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c63e459-371d-4457-193c-08dc36f51c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s7OzXXHQ5o/0no5aDCuK8m4LCAm+YV7cfrq6OxaZNM6hd6OIF/RhxcIRY4AS2ULE7otWWjR2XmB8GWh2jl/uPBrZK+Ok/oD1V55NGp8FAVtVuy9tH9bY68V7yI6xOfKnJ3kAgQsPXe2jXVlD3TWAdQ7nAuHLpECgOTrp8Bp4tDD+b91W6INLaB4c7doKHWH90vdjr8tfp6Q8yVat5t2//va7nbeTqOHlFm/Drvdx5YpRjJ+fdNEMIUDJGvzt6K5OEQSoQ6wKFdmIgSvDqay1DJwtt6z9jZX+/zZGbkM3av2cF3yAH+1ovbNnOoIm4M4knNc95FDqe+enupf2IF9BW6Kh8QhYR9ei+jtp2LJfJkKIxGcrpsRji5CGOhiB3VeJ3UlkjADv+UUBp0+JNk2b8KUKpCvVsPgXC+eVaBAAUTMsSdw5kg/4GNepKcRHcH2bJSNS0l4hUaqhKmiDvDVbGBuD6cTFK41Kfl8dTwjEj5uI1LKXVIMwc8KYUohhH9Luavxow0AktaYzlbsyOT4PcoFFTjMWvRY2wOdoG6bn+Jfvuv+CXE8kNDveKU+3lqfxfwzhbDhwoTit1CSM6jIx+8/bGtzPukKwtmGW9AQF+V6UXhDGgsfmcrv+pAqIqZY6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1Y1SFZjZ0hlUS9ESGlsYUxSa3k2N3V6a1lpNDQ1Z2lKcnR3UUMvcWkrSzF4?=
 =?utf-8?B?V2xvVWtNQ1UxQ0pPSEhkTEp1elp2QWFNNHZqbUtTbVBDQ2dPQlQrdWZiZGdQ?=
 =?utf-8?B?MkVRc1EwYmVycmxYNk9pME4yNTh3N1k5V09jamI4d3FpWHlQSVZjK0R6dzBh?=
 =?utf-8?B?b2k5Sjh6S2hrR1p1bWpQa3ByVFVSSmtqRFpwNkFNaUt1TVBwTWhIMSticHVQ?=
 =?utf-8?B?S3g0MjBjZllvQ0EyclNFUDJnV1lNNVA5a0IvODlJa1VvU0pTYWFBS0h3RW55?=
 =?utf-8?B?cU9qbnlzZ1BTVTM4dTdBQUF5UkM2aHN4ZzBwTDFsQ3Vxd0U2QlFrd1RBaFov?=
 =?utf-8?B?NFBvMHpWZ1hGZWF2SlEzU3k5dDd1b3VTeFBlTHhpN2NxWktDbUNubXRRVUhC?=
 =?utf-8?B?THY1UXBIU1R4UmVBRFY4WGk0ZUNDcmlvaDVVeEdZN1RDK3NXOEdXRFpNZkZK?=
 =?utf-8?B?a2ZMMWEyQzJqYkNiWDJRR2cvMFBKRHp4eERrNEJ1VkltdzNHVWUxL3hNM1JV?=
 =?utf-8?B?b0lHTU5BaURBenRJYzVOUnNKZlNqVHhCSlBFTkwrY290YXlRbXJGckhMTml0?=
 =?utf-8?B?RHJyWjZrK1NxVmdlditUY1RBMnBwci83UmdkWlFrL3o0b2gxYjZuNDdGSVZo?=
 =?utf-8?B?MjQ4SHlqMDhIeGJBTDliS2lBY1VlejFKRy9MdGpNTkZCNGhXdkszVGN4cUdn?=
 =?utf-8?B?L2RZZ0FjSzlCOUxtSGlWTXdia2VJTy9tU0lnQ1Izbk0zcnhiRXcwb1I5WFFD?=
 =?utf-8?B?OVcrUStSNFRzSktuK2hVTHd3SGlTRTV6TjhlOUZ6NHBEUHBIZjg1QzVYTjFL?=
 =?utf-8?B?ZTFRWDhwVTEvai9rTi9RMlhJTStxajdDcFljbkk0cXN5Y0NVZytHN2xyUElM?=
 =?utf-8?B?bktNOHd0YStPS3ViOGlsdGJGUE5MNWJ5UUdVTllIMEQ4bk13ZGh4a3FUYUhP?=
 =?utf-8?B?SU85YlhDZFdXOHdMbDdsczJidlNjK0ppZENuR2toU3ZwL3FIS0lmQlUvWERP?=
 =?utf-8?B?cG83dTNPT25PSUN2aWdWVE5YOE1GV3BOaVlKTHprZkZEbXVoR1hHOEY5bFR5?=
 =?utf-8?B?eldwbUF4eGpJZmpvN3UvTnVmQ043c2tHV3lVZXJ3U1oxMTZ1dUdqTWNPSDBo?=
 =?utf-8?B?OXpCQ2ZkQytVYUhsT0FSRVYvUGFEaTVDSFZnTUVtQXd0TElJdmtDRDFrdjdv?=
 =?utf-8?B?NXhQWFdBRU04VkZBMEFCVHRZRzkyYmM2UkFLSXoxUE5NNXhzckhBT2VxTyto?=
 =?utf-8?B?R1JQMFRPTGNHKzVXSjV3YkZPWDVUcXVuUWNEN1ovQjVwVjJFd2ZDNTc4R1ln?=
 =?utf-8?B?MDExUWtFcWJFcFZ6eHBYR3dQOElTTVd4RHdvVHdGT3MwY1VOZWRRYmdhVWVL?=
 =?utf-8?B?SlQ3NElvZkk1R0hQVTFick0vckhZVFIyU1RXZEE5a2RpMDQ4TzdtN0I4b2t5?=
 =?utf-8?B?aDNYOXZyL2R2cFpYQ3lCbXluK0ZsNUl4WEhQUnJYR1d1SDYrdG8wWFpyVm9G?=
 =?utf-8?B?aUF5em1ZVmdXZk9NcVJ0czhqYmRJaW9tMGxWUXJTZVlSVi9Eb1pERUtoT3Ft?=
 =?utf-8?B?SnVhTzZjcFpXU2p3TDFiamVOd3JuVkFvUDFpYURxNjIvUTNvblJIc2hwTS8v?=
 =?utf-8?B?bWpDdEJ6NmNVVGx0RzZXWlFISzUyZmkxN21YQko3aEJpc3R1MHBxVGVic2lU?=
 =?utf-8?B?NlUwdHRQWjIva3hrbUVtOVdSTmtEaDBpYUd5a3ZWczdVTXJ0U0xUTkNEelZ3?=
 =?utf-8?B?Y3pIcGttb2tVVkcrb2orV1RteUlRRWpZK2xhb3I3N01nYllCV0ZucGhraHBW?=
 =?utf-8?B?Z2RRcW1tUkIxWDBNVC8yVEFjRUw0Sm0wdkZVWFdqSDJveUJ3UDJtSkdKZFJF?=
 =?utf-8?B?SkQ4L0FyV3J1U2JyOU4yWFZqN3A3Q0FzYVhhSzZ5cVRIcC9RbnV5RGNKNWR6?=
 =?utf-8?B?cExvQmpXUU9tMzd0VDdtSk9zWUdaUlBrZ2h1MzY5V2RqMjliZXFQdmhqZmFO?=
 =?utf-8?B?NUZrNklNcjVvTFZVSDY5WjRYaVBUY1NscW1nSXhCYlpmUG5MaDkrczR2UXJk?=
 =?utf-8?B?T2hZQjdsTjNoclMxRE1PRncrOXpDSDRpWW9EckdnMXd0SGxGbkpCRVpHM1p5?=
 =?utf-8?Q?y9h0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c63e459-371d-4457-193c-08dc36f51c73
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 18:02:35.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgL7Jc49W3KC53bXXRstJoX+ElaZM6F3YYdUXMKCdVGoAHcPxGf+Qt7Yi2qfdB2G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8093

Hi Reinette

On 2/23/24 16:39, Reinette Chatre wrote:
> Hi Babu,
> 
> On 2/23/2024 11:47 AM, Moger, Babu wrote:
>> On 2/23/24 13:30, Moger, Babu wrote:
>>> On 2/23/24 04:53, Ilpo Järvinen wrote:
>>>> On Thu, 22 Feb 2024, Babu Moger wrote:
>>>>> @@ -131,8 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
>>>>>  	}
>>>>>  
>>>>>  	if (!validate_resctrl_feature_request("MB", NULL) ||
>>>>> -	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
>>>>> -	    (get_vendor() != ARCH_INTEL)) {
>>>>> +	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes")) {
>>>>>  		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
>>>>>  		goto cleanup;
>>>>>  	}
>>>>
>>>> These need to be rebased as this code moved into per test files with the 
>>>> generic test framework. The .vendor_specific field is the new way to make 
>>>> tests limited to particular vendors.
>>>
>>> Hmm. I picked the latest code from tip/master. Where is the latest code
>>> now? Is it yet to be submitted?
>>>
>>> I can wait for your code to merge first.
>>
>> Oh. ok. Here it is
>> https://lore.kernel.org/lkml/cover.1708072203.git.maciej.wieczor-retman@intel.com/
>>
>> I will rebase it on top of this next revision.
> 
> The resctrl selftest changes are routed through the kselftest repo. Shuah just picked
> up this series you noticed but it is based on the framework changes from Ilpo that
> is already merged. I recommend that you base your next series on the "next" branch
> of the kselftest repo [1].

Sure. Will do.
> 
> Reinette
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git

-- 
Thanks
Babu Moger

