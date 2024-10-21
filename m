Return-Path: <linux-kselftest+bounces-20307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AF9A9106
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB525281085
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACC1FDF93;
	Mon, 21 Oct 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S9FPhUJx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB91FDF8D;
	Mon, 21 Oct 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542176; cv=fail; b=Prb4meNf6wN/6RSgx/JQzAx0HlozAlgasU4xWGMbVbnPFgmp5tREcnEDxsXP9zfTKRjf/6kiVHdcRi7nFIhZ4FVP/fhKKYji85jBtvkywJJPsAg0Gw+s8Zkn1Jtav0AEVYdjJ57U3FTXpa3UDRNzs77dyNvLHiLNbOpiZVczTmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542176; c=relaxed/simple;
	bh=DxnMyPsBVUU7cpODPbzQH4kKZKXiEajG8WKOtZ3E/MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uh+UvubjK5Y1690c6xISFexV4R35VKUzsWRpyK7bBQjaSljlFWsHQJTb6sVPFgdpP94sWDflA4t5+bGpnsZAVjUI5fspeuQe7ewQatTcnoAcdKzfIttc5mPGoFs7CgHIwPtnv/MI5ljr5Y3fe0U+qFq9xvp9xqB2jn0xG3+DyGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S9FPhUJx; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZgXLQdLfnU6fjEBtHMT/yrJBXR7l1Qt5eYLE27aVPrAGd9MhZusVrZg11zV5rLEUBAo7NpmUKH9de3kD8ujcXksRfjCXPuiI7jTZ5XBmwX+BdI4Zxw231aTd4X67G8nPm2a3QzvDvWw67hO9x3wyzprMl116vQm5NsmegrRW4zduipZefiYp5cQhsnJTbgAnfZLjaH2Fmms/HnNiFDWIrjPNtIb4AMPEPqjNbu4kZNbiNwpJCF/YSO0Myi+xbMGNFFsZdnkTuzSVV59e+MZ/rAthogPKVmw0+utEOz48Zw/vhN0GhK+gX+eOJASqLh+vviybawduN9ZhmLOudhQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XKfRKk2uOgOGdjR34U90RkYmHnIdZuxDy6vt4eV3Ik=;
 b=zN8x/wg7kynCNmF0yxuNKTSqmBAZQeFIpAFWssZgBbpk1A0iNxUOz8Yx+lNQnEr5SsBObITbxMYfWMy1uzbl2LF27CXY/rPZh3FHtKOZPW5Ig4R5DKbxZY+ZTLvbgmdMq00SPsZxa5TmKiCEpotBj/GVgSks3F3vvN4kMJ4eGOgoOvehMGBEXSwdVepnIHZOAt0J3pHWCPcbIUUsW5um3SuuuBpQwQYIMHMKHmGOj8w4huDKSPTu6NTORm+Rtuu4D1IntPd5KC2vAvOHuh4AwrZCfzgP/J1VcqrZd/eER8OzO1wXCwG0PFkU0nOdqPfq3u9F12NrbwjHsUIRwq4lDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XKfRKk2uOgOGdjR34U90RkYmHnIdZuxDy6vt4eV3Ik=;
 b=S9FPhUJxqirmtBid+O6kuA99+wUvZh64XvHC94NhLPNlf9JSe6VQYMZ0+eYZ134PCDNVNIpjT+0mu7LRnvQ6H35mb4EBO1F4ixYiEt6TIsnzyRneit+8klG7/7wZXu+XLPELt4F7CWHBlTQ2rGneV47vg43HP1+W9nADpS06sPI6Zc6P+/BXDMErK2PcAsHCM/0mpYuWEj+AMxxuSDrW5yY8a/qhMmE6iDFwkpj7m2MqKs2LUNIj5CkFdTeiNYTjgZJOw7O8xEJyPf8LKsAg656hNQy8t7iTk+ZdtESy5G3qKHwDbrSK/2WgDsoKQRWT7aP3uDYPWC3XL3h1X/e2Yw==
Received: from BN0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:408:ec::21)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Mon, 21 Oct
 2024 20:22:45 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::e1) by BN0PR04CA0106.outlook.office365.com
 (2603:10b6:408:ec::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Mon, 21 Oct 2024 20:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 20:22:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 13:22:28 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 13:22:28 -0700
Message-ID: <b57c415b-752f-4e83-a8df-b5efe9b0b29a@nvidia.com>
Date: Mon, 21 Oct 2024 13:22:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] Wrong value of __NR_userfaultfd in
 asm-generic/unistd.h
To: David Hildenbrand <david@redhat.com>, Muhammad Usama Anjum
	<Usama.Anjum@collabora.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Shuah Khan" <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>,
	"Kim Phillips" <kim.phillips@arm.com>
CC: <kernel@collabora.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<skhan@linuxfoundation.org>
References: <3d07e4c3-e413-4378-82da-265a477bedb3@collabora.com>
 <4a775fd6-cb07-46eb-aa15-026e61317c16@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <4a775fd6-cb07-46eb-aa15-026e61317c16@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CY8PR12MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 233ce7e1-b0b3-491d-7558-08dcf20e1f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0pkRG9QVlgwME9wTDlrTkx5QTZSdGRXczUrVmVHUHR1VmFCeGZlK0duV3RB?=
 =?utf-8?B?M2dJSDE4NS9PWXZ4ZGcyeUI3NVE0eExNeWt3dnlISzZiRkhnbi8xaWtQZzIz?=
 =?utf-8?B?b0haUXF2OG85a0Erc1BtMFB5dzlhdlZ6MG9SNVo0UDlxV01rTTczVmhOcTh6?=
 =?utf-8?B?SUdnaUJnMlIxWW1oWi9KQmxmMVFpR0xnY1VuQk9Wc3FFc0M4cDNqUWpWVy94?=
 =?utf-8?B?KzQxMzNSYXg3TFhHTUZqQm9tOEdEOGM1clJxZmVuUGpjQ1MwMkFGNHFGTzRy?=
 =?utf-8?B?TmZjVjNPOTlxd3dRaHl2UnQ2djFrbzVuNTN1YTRqZkpINDMyNWhTMzZoVkw2?=
 =?utf-8?B?ZnU1UXV6cy90V2RydjRhcFQzY2RGNTdiRTV1ZG5JOEY0ZTB4dkw3cEpLb0wx?=
 =?utf-8?B?a20rS1VWK3RkS29GUk5DM0xUTVJGMGZ0QzN0VFNIT3pSbWx6OEo3bTdtdjVP?=
 =?utf-8?B?RWhqcTVYZGdNTnNObDNqMzFJSUJXdHo4NC9CM0Vpc1NIeEMzam4wdmdJNHZC?=
 =?utf-8?B?amxlSXFnVTFHRVlhS0hjbDdVRW4xaTdwL05jekp5YUFUMXFzVU5OMXJqeUZs?=
 =?utf-8?B?em0wTndISUE1WmEzR01SeUZQSjhMTEt4bUxKbjFXTi8xSFFYb0lsZ3c0aWor?=
 =?utf-8?B?amNxb3BXMDBtQktpcXRPMERFVCtDWUM2d2xPUnNxRTUyN1hPUURFbEFWR0Jx?=
 =?utf-8?B?N1doYkhERDdzZk8zL1RSVTEyYWxhbnNhZzdiMnhHWEU3R1JyNjNGZEhRYUd5?=
 =?utf-8?B?aUFCNUpjanZoY0svVnRpalVLN3BkdG5BdjNlc3I0ZjZNb2FWUW5ONWkzNFgz?=
 =?utf-8?B?QkNwOW9WSk4wazhIMW9vUFZCckIrSjFxaS9XQWN4SS9DZUtGSHNDMVRhZjBJ?=
 =?utf-8?B?Tkttd2tOQ1MrWVgvOWlSRlFZZENtNXRmZm1DdFNBanFGWDVaMURvTFdKR1g4?=
 =?utf-8?B?YmdJSnhqWk5QandUY2lYdnRnZGswN3hxcG1Fak1LK05YdVVVZVJsVlhJWjBN?=
 =?utf-8?B?UTJaV3VjdWhJZ1lSYnFrV3Nid1prOW9oZEQ2bDF0U3dRUzFycUpPekZ0OXVj?=
 =?utf-8?B?T0JTZ1c2S3E3T1p0MXNkdnlhejNPZDBxWmxFWVBXbU5wV0ttbjlDYWxvQlo5?=
 =?utf-8?B?bmZ6cGcyaXVXWDdvSG8yWG05K1ZiTzMwRStkR25laDRta0xpdWxkQklPVzYr?=
 =?utf-8?B?TzljbVZkNVo4NEhralJPQ21MSmJxaEVPYUJLTmZPTDQ0ays5ZlRDUy84WUpZ?=
 =?utf-8?B?bnI2dkkvaUJjK0Y0enZTODlib2gyTnNkdXFnbmZyTVJMRkVpMXhhaWRtZGIx?=
 =?utf-8?B?V2ljVTNKUXhObno2NkNkSzNnaHp6Vng0WVdaamZhK1pwc1BDdG5qbngxK01l?=
 =?utf-8?B?eWkya2JTZGFRZWZndTNSSmhReUNiNW1lTGFCTFRsUS91T29xRlQ5dmNCUzJi?=
 =?utf-8?B?Y3Y2TzdVOWdKRjVqZGloczQzeWs5Nm5VMnNIMTJ1ZWdvZE0wZUJaaDdrcDN4?=
 =?utf-8?B?Q0kxTHZ0UFdvMW5zb24zR0l4TXJRVnZIUHBqMWM3L0JNNEN4emNUcXlNQzNl?=
 =?utf-8?B?SHc3bVZMV2ZIKzRTdzBKN1o5Q0lGMS9MZXdoVElCK1NlTkkwbHRJWXdzL3F4?=
 =?utf-8?B?VUNYbGdOSjdOY2hyRlVSc2NQQkhJSlErZldIN1B6YkVqUFlGYjQ2bWpScmp6?=
 =?utf-8?B?Slk1dDlHUTJtYjVTc25TRzBGTkFmOTF0YmpSandsZlA5UnJYblBOME1VRDJa?=
 =?utf-8?B?bGdLcHZad3UzQnFrQmlzMXU3V1FTTms5RFJhM0hhbkZVQUE1VU5sQWtSQmZY?=
 =?utf-8?B?dEhDYzN6M2hDVHBzM3MwaUYvbkFydW1aOGxHK1dZdUczcmVGcjkwVFp5Zy9J?=
 =?utf-8?B?eitWdjQzVmxNUnFycVRjMml2cHVVK0J1WTJlUFhDNXJBZHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:22:44.9606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 233ce7e1-b0b3-491d-7558-08dcf20e1f7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

On 10/21/24 2:33 AM, David Hildenbrand wrote:
> Am 21.10.24 um 08:48 schrieb Muhammad Usama Anjum:
...
> But now comes the tricky part: an architecture defines whether it wants to
> 
> (a) Use the asm-generic unistd.h
> (b) Use a custom one
> 
> E.g.,
> 
> $ cat include/uapi/linux/unistd.h
> /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> #ifndef _LINUX_UNISTD_H_
> #define _LINUX_UNISTD_H_
> 
> /*
>   * Include machine specific syscall numbers
>   */
> #include <asm/unistd.h>
> 
> #endif /* _LINUX_UNISTD_H_ */
> 
> 
> For example on riscv arch/riscv/include/asm/unistd.h  will include arch/riscv/include/uapi/asm/unistd.h which will include "asm-generic/unistd.h".
> 
> If you follow the flow on x86, you'll find that it will not include that asm-generic one as default.
> 
> So the asm-generic variant only applies if an arch wants to do it in the generic way.
> 
> $ find tools -name unistd.h
> tools/arch/x86/include/uapi/asm/unistd.h
> tools/arch/arc/include/uapi/asm/unistd.h
> tools/arch/riscv/include/uapi/asm/unistd.h
> tools/arch/hexagon/include/uapi/asm/unistd.h
> tools/arch/arm64/include/uapi/asm/unistd.h
> tools/arch/loongarch/include/uapi/asm/unistd.h
> tools/include/uapi/asm-generic/unistd.h
> tools/include/nolibc/unistd.h
> 
> Consequently, the asm-generic one should never be used directly.

ohhh, I think I may have inadvertently started this problem! Via a few
commits such as:

     a5c6bc590094 ("selftests/mm: remove local __NR_* definitions")

, which did things like this:

-#include <unistd.h>
+#include <asm-generic/unistd.h>

So it seems that it should have been:

-#include <unistd.h>
+#include <asm/unistd.h>

...and each arch's unistd.h needs to be checked to ensure that it is
up to date with all the symbols that kselftests need.

thanks,
-- 
John Hubbard


