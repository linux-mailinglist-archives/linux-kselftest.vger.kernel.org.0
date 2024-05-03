Return-Path: <linux-kselftest+bounces-9438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A638BB6D0
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595E82816E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3E56B76;
	Fri,  3 May 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OG79JLAq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4B60BB6;
	Fri,  3 May 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714773668; cv=fail; b=CJ9O5I7i0VZpu98CPp4+eZcsj5r7wF/5wsUrd7PwWLCts6E+fCWPT9xf9xC7JZUmkzXGKZWMJXm88O3H8J/YTqnLpICRFflkAKFJ+j3og+g4s/SMzIeXPBWy2ETAo5OAeQveasDg2EMsyiNrlBf/e/4Zml/jytz3fgJHcL4LogA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714773668; c=relaxed/simple;
	bh=UH6PmjiPmEI0L9zbQ2r4IaUitoM7zMka7Bu03VRggnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jTJI2LSg+TVV9+JLgmgT7P9vE+fOZMTI69Cc5kLSdX3vwe013dNYHekdYIqiu2P0q84ZmnI8jmUWMaj7EN1O4drcZ6WXWkgqt1H3dTzSgieUCB391JTOT1rA8uzMC4dxv9Xcs/kwNO2uT1QLxqTDRKwLDBLt6BfNGTogWbKsQ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OG79JLAq; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BU8ULqmI8W+W1oKa3KoZC9o4rxi4qNGl3l/kykFFsPFTzWt7NJG2kO8b/06LvIVW0GuBWtviHReCmL/zr7OuikCtd1E1vO4KiPV8qNh7ZL4xyFFcsvSIfG04csEe20w8yVEwxXeng9PA8L7s4P+PtIUtOzk3r0r8tQJUuPn2vpcFR3r6ye6cQ34axJQ92/GnAaoIOlt3TYpZaAtYEWIC7cbq1L1JhmqNMdAjf+uig+JBVS8pJfMgbFfNN3j4Q7C5Iy4Adn9R05Koa7qNz57LQksYMSG8pW822UC9GKyMbgjh1jjXAI5AvXXCslw3a5I67C9kS32Idjid8MW8xVYKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2u57zfoJduSdp0Sow1nf2I0kiy7AW2C0Q8aXlIOPWpU=;
 b=RWPtibLTTWb7ScZ7Zq+s5LPiAKtwHMFgm/cnLgMj/UU5b2xoCiEGnbTIZt+e1202Z5t1tRISFq7ebAXEI2Kt77y3yFjOo6Jn0NmqoDBM/YR7NuJSyYjMj2gskBBp0TkWG/inr6u/mbMWbUu2FvRl7IxvGf2aYvcYmRvJL68l0swDn6or76pTC8T7ENSD69cVZkWe/zSQJusds7Se4AdrpSwNATGLj9t/5zD2VnOdZYElwoV8v3k2YPjn4dxy22Lj5ROsuxVVZW9fjGWVxXP0gbn6WjBjpGxQCD+qUAFQeulakMKcWhhxmuF3mohtSw3caym9qt7IqQ14y+8XMTi/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2u57zfoJduSdp0Sow1nf2I0kiy7AW2C0Q8aXlIOPWpU=;
 b=OG79JLAq+tuHesyWj/bDViQAVlpd94Z/XiodoTuFRM0JR5WV4hj+ZjG19leVBKKd97Y4ziPxuZvfJp3oJ5kcopAXDHwyBit9hSMPb8/MgXnx/t2evZYDLgYUzL0CIBj/6+4o1bFj8WG1ykrExy0q86gMrcMdx6Cz2965Nanc2FTUKleXL7h++yRyuf1HCofbfSfMY4ZUEqbij51qk8EFUFRXlYDZi1GMIzKSY19hEg07DaCcxtjZ46ayM77eNVXMxkAGnMdGt0Rc9nx9EzIrtecPk6rBeMSiJ3LsonnRsAXYJkMCXQqzrwXnGUt1yOg92/O/Ga7aci5QMF/qYcnmMg==
Received: from CH0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:b0::34)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 22:00:45 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:b0:cafe::5) by CH0PR03CA0029.outlook.office365.com
 (2603:10b6:610:b0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Fri, 3 May 2024 22:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Fri, 3 May 2024 22:00:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 15:00:21 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 15:00:20 -0700
Message-ID: <63750681-92b1-4c21-8d58-6a22709822fb@nvidia.com>
Date: Fri, 3 May 2024 15:00:20 -0700
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
 <b88e73ea-d3f6-42d0-b9e0-f97665546178@nvidia.com>
 <46a6019c-b029-4764-8c66-ad61f4191716@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <46a6019c-b029-4764-8c66-ad61f4191716@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 10703489-1755-4b03-3b2c-08dc6bbc7bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlFFT21sZktYMStIa2dMY2xuL2plVEtNN1dqbExheWtKUVBjbGVQVjVZd2JK?=
 =?utf-8?B?UWF1cDF0K042R0F0RCt1d0VuTlJUaDMyZktMYXk1aXVLdzVPRGFZakpPbXZH?=
 =?utf-8?B?VDd6Z3Y4aFpXTDZEaUVyWnVsY0pJZTQ0N2hua0tsSkZUZFVNUWxhS0RFdnhU?=
 =?utf-8?B?dEhYRkNNa0ZmMitJSWRMdlVueEdBeFdzb1FadTlsRmx0KzJTc1VXcXZIZ09J?=
 =?utf-8?B?ZjdNWG5Id2hqczBjeUZzVmRyRk4zQ1MrQ2c1aEJPL1FRSGZFdUkvWGhybWpx?=
 =?utf-8?B?RHVzTmVHbWFsNCtIWmNEdTZvNTJ1eTBNbUJpelYxa2NkL25pRGF0MWM4RXBM?=
 =?utf-8?B?Q3lXdStvUlpiQWdtYUZFVy81bjh2MDMvWTNnUy9pTzRQRFNaYnZGUFhLaHd4?=
 =?utf-8?B?OFhjWUJ1SkJoc05tTDI2dHcvc2tiMW5PUHlac2RxekNLR253bWxYYlcwYmVG?=
 =?utf-8?B?NmNHR1p6U3I4bksvMG05TDJTQytxcmJaeHQvZEN0aENybkVHZHlybnhHS0RL?=
 =?utf-8?B?NGwzaUkxdlVFQmdBQjNxK3hUbVZjeDlRMGlIbWNlamVJM2JvMEdxaUV0NEFj?=
 =?utf-8?B?UytYekRuazBiWlI2ZUsrcVcwMUZVcUFsMlE3ZWNpQVJmeXVWcHJZYlJEa09n?=
 =?utf-8?B?VDVpR2g1eVkxUkEwQXdwQVpzVzNidS9QbjZhTXg0RDVIVXNGZlZaVS8wUEph?=
 =?utf-8?B?Z3NKVnE0dFB4TkxIeEl5VHpsL1RHdVdJRndJRDdUcjhrczB6dTRFMUl6ejl5?=
 =?utf-8?B?YlZTWitOMWdoaElJbDNtN2FqaGpMVkMxRzZVeXZKVjNQTmNzV3JCN1NGeEtE?=
 =?utf-8?B?cUZuajUwNXYyUkRNZVB2Qk1zdnVEWVZZWTc2dVJCZ3lYNExmTFR0K2RQaDVn?=
 =?utf-8?B?Mm4zKzFqbGJJRkNqakFWbTV6VDl6TWVXS0trYk9tNkZ5S2IwNk55alBlQ3pI?=
 =?utf-8?B?MDFwclNCeHNzeU00emlpS05aa08zdElJMjJDYVZvaDZGcjJhLzFzTndxemFK?=
 =?utf-8?B?Yk5qT3dscFBFUlF2aitoREVMSGFmN21hOG1XK3BseUhaM2x5d2EyZk5iV0FI?=
 =?utf-8?B?K1ZMekNYRFZjcjJiSnk1VWNFYzU5b2t3RG11RE54WDd5ZXpTQ3lCbldCUDg3?=
 =?utf-8?B?RmVRL2ltR1F6NHNjNVM1V0E0eDNIMCtpOHNMTmV0RU11Zy8xYlZ4Z3dyWDBm?=
 =?utf-8?B?WkNrcEQrY1Y5a1p1VEJTK0l4NVlUdUtoQVZhWTR5eTlpTkhGU2JDd1NucWx3?=
 =?utf-8?B?TFVkeVpvd3h6TTdIZ1JpZnc5WGtlOGsxdVNrakJkVEdnM0x3NjVFZmlOMFZr?=
 =?utf-8?B?NEpZS09BQlJJakZscjBLbC9BWDliZDhFUkJZdmI4YWRBVFRGRWRRN3RUeVh3?=
 =?utf-8?B?cWc2TkZXYW1GUytxUWVhY1NycDNHd3A3bU9MbW9IcmljRGdDTDJ4Y0t0YzV3?=
 =?utf-8?B?WUZQTVJuY2JHdXR0MlNickQrSllQSlR2VEp1K2pBS2ViUXVBMXBJVUxYM3JC?=
 =?utf-8?B?RTRGWlArQU16QndVQno3bXowamd6bGpmeVB1VW9Lem1yMVM5bFZIWnovSlBr?=
 =?utf-8?B?bHhqU3JnNUFad2xBWFA5S01FY0g3R3Q4SThmZDAwcGRjNGRZZ1R0YStuKysw?=
 =?utf-8?B?ZWlNN0FGbEQ0Tm1ZeFhqejJQVWs0MnoxOFdXbzJDVUVxeWMrZTJrak5ycVRC?=
 =?utf-8?B?YlIyR1VoY3kxenJVYWV1aE5sYjRkaUFoS2FWSkFEOEo1aXE0aFVBOVptbGpx?=
 =?utf-8?B?VWVXTU4yWVI1aW1lVDBZb1pVNUFTVGtPQzIweURjUk1mM2ZwV0RNZW9MbTlT?=
 =?utf-8?B?a0xuRzJpSXFET3J2d0l6dDd1cUFNcjluU0pUbS8vOTllMUxKWTV6b0I5b1dF?=
 =?utf-8?Q?2obHMmfvQks9K?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 22:00:45.1769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10703489-1755-4b03-3b2c-08dc6bbc7bb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283

On 5/3/24 1:46 PM, Reinette Chatre wrote:
> Hi John,
> On 5/3/2024 12:12 PM, John Hubbard wrote:
>> On 5/3/24 11:37 AM, Reinette Chatre wrote:
>>> On 5/3/2024 9:52 AM, John Hubbard wrote:
>>>> On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
>>>>> On Thu, 2 May 2024, John Hubbard wrote:
>>>> ...
...
>> I assumed that this code did not expect to handle negative numbers,
>> because it is using unsigned math throughout.
>>
>> If you do expect it to handle cases where, for example, this happens:
>>
>>     avg_bw_imc > avg_bw_resc
> 
> The existing code seems to handle this ok. A sample program with this
> scenario comparing existing computation with your first proposal is
> below:
> 
> #include <stdio.h>
> #include <stdlib.h>
> 
> void main(void) {
> 	unsigned long avg_bw_resc = 20000;
> 	unsigned long avg_bw_imc = 40000;
> 	float avg_diff;
> 
> 	/* Existing code */
> 	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> 	printf("Existing code: avg_diff = %f\n", avg_diff);
> 
> 	/* Original proposed fix */
> 	avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
> 	printf("Original proposed fix: avg_diff = %f\n", avg_diff);
> }
> 
> output:
> Existing code: avg_diff = 0.500000
> Original proposed fix: avg_diff = 461168590192640.000000

That seems "a little bit" wrong. haha :)

> 
>>
>> ...then a proper solution is easy, and looks like this:
>>
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index c873793d016d..b87f91a41494 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -17,8 +17,8 @@
>>   static int
>>   show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>   {
>> -       unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
>> -       unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
>> +       long avg_bw_imc = 0, avg_bw_resc = 0;
>> +       long sum_bw_imc = 0, sum_bw_resc = 0;
>>          int runs, ret, avg_diff_per;
>>          float avg_diff = 0;
>>
>> Should I resend the patch with that approach?
> 
> ok. That indeed makes the computations easier to understand. I assume
> you intend to fix the snippet in mba_test.c also?
> 

Yes, will do that. Thanks for spotting the bug in the original "fix"!

thanks,
-- 
John Hubbard
NVIDIA


