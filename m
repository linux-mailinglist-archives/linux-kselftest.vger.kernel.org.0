Return-Path: <linux-kselftest+bounces-10807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B78D282E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49171C233C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 22:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222B613E40C;
	Tue, 28 May 2024 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aNlqCA++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7F13E052;
	Tue, 28 May 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716936237; cv=fail; b=oZMXpz7Yesgzb5cgazL3o1cgIzu6LaSZtr857rSX/aF9YPm+osSKHCqFpSmH2o5GFWdZnmuncCHUu1kpxn95I7uLQLYAro/uo253HiVKWfRZvdvvIJEdu/4K1yABTLZApVJAy9++cr4ek5Pj8jkuzMfaHBg1QU9bmjz3TchokHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716936237; c=relaxed/simple;
	bh=0lxCFvvLq9PuQmTqYjpBpDpkrCPs4XvuULU/5f52I4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iFO+1It3wWVlXzc1O/bjrR/02do0fmjPCYAVLzebTAoS1Fk0E/r7BjtAxhECd5QHfzCFov5DKRJ+RlxwVxyLrurfu6jLCnBAMo6gigMGwydAnK9qdqmM0nSD3NzfmqXZy8Khuil+NJGb11o6NssaF/7RUDydbO6R0aqNFw6m5Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aNlqCA++; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5roGZpc7Tf8lTXy72idvJa31gPqBYQAZ9d7PyZC4hE16teWOfwI24B02qqiVw7OnL1L6QPUpcu2zrHQRCT/la/lDwud8bHyC7kwNjxiNCxcBTqnEQ9lE4oWKQlPsh/8PQhKTZ892T5vG8qKvvN9b7v78rPeS/wWWyLQYAprl1jJ3NCtJhAvdEkR8PkETd3lfLxuwGMYgr7MGK0/G8OuysJ3EGiDeCksJJ48qa2mne5OC3uU8n+CrjTT9HZSN+nAUaua21WRT3+yBNQcC/MbOvTugA8LJHXIyV36biIJ79owDh697AdR3+1H0yQu6a6WyBT+wa/GuTfTk3OGgJ24NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBCVCam2HIgrjwWQzhpfYBIJIZb8RCbCanl6dgERaj0=;
 b=YN2Mxv4ODqraqIYRd7SSbYfLJuqhjwullsMg6S+KvH2w/XdPQqfjhFSYQT1GVxHxfb688Sa3wNivSLqDgVDNcOlzYnhvIRDvc//u99N1UmPkCEche/WV2tS+b/6xAQGLcTl48ySvxKtAhEURwDC4YzTjdqicKegTnfaIC0ikvIj4GJuxYr09uTPECNg0+R/tOIg4o0enHB+9uEdOAm6POhSQYNVdQjFe8FmnhFwCdB5Od7lKC+TekeNn4GcE+d0SBD8g/8LwnPLR3PiXH6OO8Zj4bCcRM/OjWwU/f1lHSEDmyrtitR784uBDgSNnhiPIpOkk+uqCvs5/J9Jss5etJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBCVCam2HIgrjwWQzhpfYBIJIZb8RCbCanl6dgERaj0=;
 b=aNlqCA++7EU9k9TyBKT+ngUUqIGNCwoxkFQ5qWNH7aPs/kpOlycNLptXvjYqrHEdZvV4g7XHpLOgaT2QvEJxNsQLcMyBFiPuEClpTHDZQGCSoXMXgJWRnoEqBhEgOv2dTAbDEVgTnxlqWIIKg96PRXtJeFTd9kuWe/jUHpIWgSN1nbZ0jlO3S3DmpZPmW055QEP1Igf3qEn/7dkb9siPkUhKVt2BG51XoS3qkO35VE3b0y+I7qXdxIXsb7S4R3+hSeXxH3/zMRP9C1pIRzi264bF2FvgaHtTnlWrCIOt/I2ByiNAwdP0WUVgc0Eo8MIOZVUVi8pScxqdlBBTQhu55Q==
Received: from DM6PR03CA0078.namprd03.prod.outlook.com (2603:10b6:5:333::11)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 22:43:52 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::23) by DM6PR03CA0078.outlook.office365.com
 (2603:10b6:5:333::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 22:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 22:43:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 15:43:36 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 15:43:35 -0700
Message-ID: <a666bb5c-ba85-4b57-bfdb-217da150fb36@nvidia.com>
Date: Tue, 28 May 2024 15:43:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/futex: pass _GNU_SOURCE without a value to
 the compiler
To: Edward Liaw <edliaw@google.com>
CC: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren
 Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, "Nysal Jan K . A"
	<nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>, Valentin Obst
	<kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
 <20240503041843.99136-4-jhubbard@nvidia.com>
 <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
 <CAG4es9Vi3Kmvb0Nn2FNGmVL2YB_5qcJHunUaTRuSy=mkiLhb0Q@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAG4es9Vi3Kmvb0Nn2FNGmVL2YB_5qcJHunUaTRuSy=mkiLhb0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2585acc4-2e76-47fd-5643-08dc7f67a5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXhVU0tsWEdJU2dxd2tNNmtLZG5VYkNCSEtKOUwxTDFsTmFrSWRNcUl4a0R1?=
 =?utf-8?B?VGFxQmVld0RrdVdYcmIrVGNtVzc3RTE3NW9UblQ4elZRWmFWWVpqZTdSeUFr?=
 =?utf-8?B?K0lvODRmY1N3dUJsUml3dGh6bzdhODdod0N3eEpRRW9yb1piVnRZL1ZQaWYz?=
 =?utf-8?B?NGdsbEo2ZGZYeXB6bnRlQm9Cd1JxMG5Dc1o4cGZ0YVV0bW5KdGVyTHQzY1hh?=
 =?utf-8?B?TnViOFdVR0dHQiszQStsekFnK1JMTk5XOGtLeHhnM3ZuNGFsRG1aZlpHY0Y2?=
 =?utf-8?B?RU9YVXV5czZVbXdGYU95VWF3Y0lqTXZ4eURFK1FzY2txOTUycWJSbTNuaTVB?=
 =?utf-8?B?OXRUcE5IQlNydUNYMnNnZmNGaFFaa0RzODVyWTNtVTRnc29wdjA3NE9BRFhy?=
 =?utf-8?B?blI1N0pZSkVaR2NhUDEyZWh5NEJSMEVmSlZpbU94N2lLZW1uN1ZXR3o5QTVK?=
 =?utf-8?B?aXlVRit2SERCT3ZaMFpVVEtlNzk5MHdoT3cwSHRzekpMaS9yL1lXeGRpS3Jj?=
 =?utf-8?B?Q3VtNWl5bmZlaHBOc3VnYVRuZG94T0dqZDFVcjVMbFFoL3VmNkdHbm5VYVcx?=
 =?utf-8?B?ZWNVd1ZzMy9ON0l5Vis5THJMSkJSNjJ2ajkyZEdkWlZ0SHRkRndFVGtPRkZX?=
 =?utf-8?B?b1BwTjNCZGJpSGM1SDBCNmgxK0tLMW5TUU1pUFl4K0hIY24rM2lwMXM3Mzdx?=
 =?utf-8?B?MmhEYnk3cHRHeFFVNURVNHBzaWxIc3RicEdkc2dSdVUrT2dyWlhjbmwzVXl1?=
 =?utf-8?B?UmpNRVNmQlZWVDE2bWlIYUQwcDZTbGJKaHkxa0FPdHdDQ2FpTzMyM29XSlcv?=
 =?utf-8?B?VjloYU5zeEp4dCtLRDNFUllIMEJGTUlwQWtZN3k2UTlUUk1tYjhhRWhoSm5W?=
 =?utf-8?B?bUQzYTlVblpqZ3dTekVqdlRCLzdsLzNZYnlLektQNXl3d0NocGRFN3Y1V2E0?=
 =?utf-8?B?ZTY4a09GcXVkR21iRElZeWlIRi92OFA1V3IvRlRQWkhaZWs3ck8xckd5UFpX?=
 =?utf-8?B?a25kU1p5M0laZHdWbjZUUVI5NlRsSWlFSXBEb2ZyUE10dHBPVUxZTmlyRG5Q?=
 =?utf-8?B?NXZsQXdHZlJPSGZwU2dLbFgrc0J1YUNUNmVhR0RvSFNrc0ZRQnRpVFdzN3Vx?=
 =?utf-8?B?OXZpNkw2RTlRc3dPY3F3L2RoNDkxNGZVMHVtKzhNR3ZISmFxajVVbHA3Si9o?=
 =?utf-8?B?UnErcTRlL0ZqWklUR2RMRjBCYW9GRllPYkVTS2xLb2pnUzgzajg2c3VMZ3lS?=
 =?utf-8?B?TjMwZGw0cXZQeXRVaFdhM0poLzBURFBubU81cjBiTnNDbnBsdDl6T3NvMTk1?=
 =?utf-8?B?Y3F5bXR1K2RTQTdicy8vWHNRZHdxWE9ZQ2UyRkxXb3JuZmRjWVAvOWZKSzdr?=
 =?utf-8?B?WXdKbE41ZjVUZEM1WDFZMUpuM2dKNG45U2o1cVR6VjhrUzJjNmRkZ3lwU0xO?=
 =?utf-8?B?bnhUTW8wZCtJNUI2MFAySDBQTTVDZDE2WGpWckVJNEEzL1poVnNZb29HZjR1?=
 =?utf-8?B?aGl5ekFRUEVsc2c0NERYL2pPdFVrQjEySm5VZ3ZjSWlmSTJHOEVuSjljbmRK?=
 =?utf-8?B?VDMxQ0JvSU9kMjRjQ3N0eGxxdUtydU5ydDlrbGxvYTh6eFBlMHRiS3E1QVUy?=
 =?utf-8?B?VkFyTUZMVHhoQi9JYTRBc1dzK2g3UzdXcDNibXdiMzZoYkpVWkUvYUcycmRM?=
 =?utf-8?B?WGowOE1LRXNWZkR3VlU2S3krV09uZDJ0V09OZzBranQ3dVZ6dUc5c1Urdksy?=
 =?utf-8?B?eFA3ZllsTGREMXJRampOSmhMV3hUaEhSVHQ0QnppOWd3N2k5R1NBeU43bWNm?=
 =?utf-8?B?cHVUZzFwTTZsQnM3QTQyVmJJcUtQemtWb0ZwWG56NDh0YWtnYjhWYS9leWZ5?=
 =?utf-8?Q?bMq+dvrSkuqAl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 22:43:51.5706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2585acc4-2e76-47fd-5643-08dc7f67a5a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284

On 5/28/24 3:24 PM, Edward Liaw wrote:
> On Wed, May 8, 2024 at 2:05 PM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> On 5/2/24 9:18 PM, John Hubbard wrote:
>>> It's slightly better to set _GNU_SOURCE in the source code, but if one
>>> must do it via the compiler invocation, then the best way to do so is
>>> this:
>>
>> Hi Shuah, Edward and all,
>>
>> This patch now seems to be obsolete, due to Edward Liaw's comprehensive
>> fix, "[PATCH v2 0/5] Define _GNU_SOURCE for sources using" [1].
>>
>> [1] https://lore.kernel.org/20240507214254.2787305-1-edliaw@google.com
> 
> Since we're dropping that patch, would we be able to merge this one?
> This should resolve the futex_requeue_pi compiler warnings with Clang.
> 
> Reviewed-by: Edward Liaw <edliaw@google.com>

Thanks for the review! I can post a v2 of this tiny series that has only
patches 1 and 3, rebased on -rc1, so that it's clear what to merge.


thanks,
-- 
John Hubbard
NVIDIA


