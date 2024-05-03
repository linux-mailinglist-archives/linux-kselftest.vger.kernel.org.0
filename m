Return-Path: <linux-kselftest+bounces-9380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC238BB142
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED842816A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F66156C52;
	Fri,  3 May 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hAq1rGU0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EA219FC;
	Fri,  3 May 2024 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755183; cv=fail; b=UAcqfeT7Z5LvGchJtR9ZYRA6D1ObFfYau8J89CIUz6uikPhKKCE0/g+/ECWIJun0u0MbKvyhOXwVZq3UFlNulnfoRVNsakUMGhlwXgtD0iQ2IqkyOZWtZ64bnTNqDiQalg+b0hIwcO/UoKIoNSz56N5L1pL8pRp9eUiEHXv09MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755183; c=relaxed/simple;
	bh=PbxUL7G9ApwTG22on5No4AjDTWfHmV1zynn0l7L/T8U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EKHDlfQGW02lO1RDiiQNI0MiimCgfLXo+ktQJFJcJcGkQIpFm9FGUeudbOHEp6gVpRgbshuNxqgt5lU38WgdbLQalBlreeINQCmVVxIgJJZXWv4/qi3ffvd3n+JxOjvvbht1BHB91jxbpVH5B9CHk19ZfV/eWFBUd8XOJeSHgOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hAq1rGU0; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhT3yNybS8uT9ljY3adBw9jxHb2MkVnxer0f0xGo6K6YLsSXGheqYzN4zZvDrEJ7TuLb2nn1iPnsZ+k4r613y0/Z04wNecBaoD/aWKARt2EpBe8eojssTMqMLVdjE7ydR00VDfNrI/R5H8P2aB0yv2RmVsMG9S7rSDfdYNE0d8vIcCT8kiPhOhpOhCayh0iBQBe6dkBifBHYliLToSoIQsuNR3xJ/5qHqI0HBlU8c4NYLde/16yP4o5kL0YHndtxHq6GQn6E2mmPBoeES4JmAHuOSmP1YwGRgB9xpuosl5koXn8YR0/B+4DcEZ6v9TCiOeL6moMAhnGJ8tFLgFPQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urrta7fDyoZGRmp8+AaheVqEVxf5U6lLhSDf+gWl1Q0=;
 b=QYhrfqj7B0O2A0JdX0lOxxOYIvV4wL5gbxQDFAEWdqDJjNOkuNikn9Xv0R1KyhIsj8nyPEYSMWqBEK/06IOnmM/HFDHA9mBBYeH30xA05ocX7+MECBR+a9GYzUCrKGAQm9wYDgJeBDerj7ADmDABJ1IZZKcd4pKe+EMv7HP/bHHjNvEbvCu+A9S2iYCV6UttwnOmLtN8c38s2PlJteJ/o6LtXCCO5NuoZgBeRQczGYdRkEQbtqqluP/YWLra6eU3j44i8crrGh7F35iajxv6uT79wru4OHEJnb7YFubP0zy9VsGs3R3QcN1ESFFIH24nDY9huSz/+BQlgdrygBZCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urrta7fDyoZGRmp8+AaheVqEVxf5U6lLhSDf+gWl1Q0=;
 b=hAq1rGU0KOzULA8oxsqMUhLzv78F322ODfomdHG1MKTDEtVsBqXj0rwERq73H62oGhNtnv78MC8TUrPacTFbrYh1VuzlBj83xO1CL2s2OC1j6mt/nZcHs6SF54vf79DQvq1jB2kssQrfIjWzxMoggXLcCws3m50fNIsuqSott9XiYW//sagRPv5hWM9NNT2E5XPhSQlrx58aP1u9PAkFRsCPSmgkhCq+S7faIl92GRLqrnqWBYFhmb3sIH+GHScRK41sxyvAVgRiZre+Qu9AKUhlItzs75u7Gdz2ScgR7ZCRFaZmEKFD5oFJt1LZug/+CzC6NO2j6bX639DempHgTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 16:52:58 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 16:52:58 +0000
Message-ID: <f908ba74-86c0-409c-854d-9da5f3917b05@nvidia.com>
Date: Fri, 3 May 2024 09:52:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240503023209.80787-1-jhubbard@nvidia.com>
 <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <793bd068-c3b4-6330-41a4-bea597b1d820@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c896a7c-fdd3-4e6a-6217-08dc6b917c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE83NExEZVZvWGIvRXplSVRXVjJiK3NHck11eWdockk5NVBLaFpWaGJ5c0ov?=
 =?utf-8?B?Kzd2cTJ1WDhGTFk5enpUNnVRQ29OUWdSZjFVNzZlOGEvbTlMc0RBVUU5bEZ0?=
 =?utf-8?B?a0JHdjZpbnpLZi9WVzA1aXdXM2FGNGdFUHRUK3EyOXJQclZBc2tjb3VDWmxB?=
 =?utf-8?B?Vnl0cnQ1aGpReUxVa21DdEgrNWJ0QW9qQU03cE5LY1BjaGREV3RVT3Y4bGlS?=
 =?utf-8?B?ZFd6OU1qNjdwanJ1RDI4NmswMWp3Yzdqb3V1THNXSzZ2STMzclpDWGRJWFZG?=
 =?utf-8?B?dDlwc0FFZzJONnlxQVBvb1p0Uis5MG9YdUovaUpOT2FvTWpWcGR0YU1Yc1gw?=
 =?utf-8?B?aHRycVR4K0VULzdMMVJpWnZpMzIyRmhvY1B3aWZEeEtyLzN6QW1zY1RWRWNX?=
 =?utf-8?B?cU1ZeW5GamJFYkhBNDEzMjFpUmxHQXpqKzJOZVJDRjQ2b0NHUkZYUmcvVmx3?=
 =?utf-8?B?aER5eTZzdzJzdW1Nc1JNKzJFd1VRN05CNW5xNE9jYTMvV2lyUVF3bmZFWmRT?=
 =?utf-8?B?VWs3TWxyY09jQWsyT04vRVpTRFR5SDFJNTU0QW81ZENBRVFrYWJIM2VWak0r?=
 =?utf-8?B?R3dIQ0tIalVXYTlsejZGZS9kaGhpNXhyUSt5QzQvZ1dRMjdET1RyWVZWc21x?=
 =?utf-8?B?Szk4dUZvMnBpclRyZVpsTkRPcXBTNDJLVStwdUFXM0U3TnlQVVEya0FUTWtH?=
 =?utf-8?B?WUZ2TU11R1hWc1d5aFBwckxKeml3YmVuanFkM3VNSkloVFQ2a1Q5ellETmdB?=
 =?utf-8?B?a1BnR0RXeUZGQjZGdEdoWDZqRmNiOG50QWFBZ2ZHTDgrVDFQWlVLMXIzTUsv?=
 =?utf-8?B?OWZiUUtUOWhISWRDNktwYU1BUnY2M1U5WkpJSUxyYUpwbmo5SmgwU3hGaHdB?=
 =?utf-8?B?ZHQ4WnVyR1AwTWFwUHhhc3hEUTJKbXl4NmtmZkZXN0dlbTZ1R29mcjdQaS9C?=
 =?utf-8?B?T3RlOHY5VnJXSkQyVlVVZWM3T1c1a1IzVHVVRmgvNmhDTWRPd3A3OE5lOGVT?=
 =?utf-8?B?ZmpxZzE0TzdXYkRqNVFrbjZPenRsWjRobC91OXZQV0FTcW8ydStZbDFMSFp4?=
 =?utf-8?B?MWM1bGJ2dE9hOStrTElERWxYTXgvNzJLNW5aL1ZIZ1ZUT1BuN3dCY2xWcnA5?=
 =?utf-8?B?QzJ4RDVndXBJbGpkYmF2OUsrVW9KaDNsbFBDdW1VYW0xVTRHZDhQU1l1dVBB?=
 =?utf-8?B?SWpkMkoxeEN0SXV0OC9ZeDZZNkFTZ2lIbVFGRHFCOXpScGdhRzFzOURpQW5K?=
 =?utf-8?B?elpPZ2lHSWFoTit6L2xEVjh3T0M4SWhsNnRmc0VuNkVNNFhnWVZoQ0FlTTUx?=
 =?utf-8?B?c0wwcTR3aEdLeTF5RXMvT1NkRnRqa094NWlmWEtQQjVnV1hlZFROK00xMlNE?=
 =?utf-8?B?Z1VtSEdXK2UrZjNiNUM0M1FISmNoODNOSHpBVU9mcVgvbkxkQm9VSFU3bEtn?=
 =?utf-8?B?b2pyNWdwUSsva0wzT0NoajE4dGNKcDZkMDVMNFhiZkpnVmFXczlGVzl4RUZE?=
 =?utf-8?B?SlZEMDRmc1dSVjZqZ2NoaHlJSlhDbUN0TGZLeUxFN2lsR0d1UG9XWEFuUWhS?=
 =?utf-8?B?QldFTjkzRStTWVVFWFIzeWpvUndqNk51TDY4cXdVTm1YdGZaTXRlUS9mcnEw?=
 =?utf-8?B?SXVTR2RCRGlFLzh4dWIyMFc2aHlWZTlBM2xKS1h3R3FnUUY0ZUEwL3RxU0di?=
 =?utf-8?B?ZEc2VDYrNVZHQSt6RDQrekNlL2VPcGxvWmhJdXRPMFJHdGVzby9BWDRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmtmQUpTODNLWWdDb04xYklVeHVIYVdsZDB1TzF1TkJ6TllCOHgyRjhNN0hO?=
 =?utf-8?B?VFc4SVJ2NC9KTm95aWdlUExSQVVBeGpEbHB5L0Z5US9CRmtLVVk4RjZ1c1VL?=
 =?utf-8?B?bXZmUndnd0Z4WlhXbHpVWEIrSUh2NTk1Wmx0dXJYalgrQWo3ZUpJYkFRMnlY?=
 =?utf-8?B?MVlLNVBxem51MzJVVFlzSVlHQTJjWWlSR0gyOXI3MjlQVDc0TzVYUlJxRE1w?=
 =?utf-8?B?U3RXWHZWTUcvYzRDWnN3b0UxS05sV3B4cmM5L0lLZWxoWUU1d2lveTZXZzV2?=
 =?utf-8?B?NHNBcDg5RmF2OWJnS3Z2U0hOR01ZK3ZFdnRLRlNwMkFrbU9HaDBIeVFxY21i?=
 =?utf-8?B?K0hTTklzeGhKUEx4cEhNRlRQYkxlMGNwUzU5N3hjOEhzd240dGdHdW9lVk5S?=
 =?utf-8?B?UGhENmdyZzkzbmRUUE1KMlNiZXN3YTNyK3hzL1Zjd1pQMFNrcTJyMVVpeUk3?=
 =?utf-8?B?Vk8xQ1hYT1ZwYkV0dHNYVjkzVnRjaGJzNjhIaTgxMXVSbndCZzllZllJS09x?=
 =?utf-8?B?Y1VCbStLcG9nSXZJcExLbU9ER1hkMjh3L1dGYmN6dE03dEJicS8rVHRSc1Aw?=
 =?utf-8?B?VmtubUxiK1BrT3FJRnBBZ1duMWhyY0ZPMWpYTkVSRkFJM1NSdGdLVUorbEdM?=
 =?utf-8?B?VzVnUXFIN0h6ZlVwd0pCN0oxdENEaC9TWDRTQkZQbnhJb0RtYjlYUVZ0dEQy?=
 =?utf-8?B?UmdqTzB1TnFWWE5KSkdtNk1WcHNoUys3c0Q1M3NGVlZrSjl1TnIxT3I3dHo5?=
 =?utf-8?B?SkVmUGdJVS94M25YTkc4WUJ2NThTNzFZLzdDZGF2dyt3OVlWeGZJQnZoU2Zi?=
 =?utf-8?B?TU5xRzJ3a2NwWThFZE1TdFJONGo4ZFVzMUtBN0J1VGh6Nzd5eFI0VGJhNkky?=
 =?utf-8?B?YzhYS2FkQ05VSVNSM3VDVzh4SGNGZTAyVE1ybkJJbk1oNVEwaFZHeGp1cmY2?=
 =?utf-8?B?QTNFMEg5bDcwUDJpamlHaFFtSTQyZWV1WHBid1pMR1psWHlFVlRKdzhDZWY4?=
 =?utf-8?B?emw3ZmxuM2ZBNnQrOEpyeis4KzU5L1JXNXpWTEhtcFl2eEQ2SVdpQWxkUk9G?=
 =?utf-8?B?cGFXd3RGSjVlb3dQQjhhQlFXcldGL0Z2cG1VTm5CeUZUZUdXQllkdjFIeFIz?=
 =?utf-8?B?Y1I3WitBRmVBdWlNb1JjSkt0WnBGTjFKOWpxT3ExbEErQ2pYQWVTVG9QV1ZN?=
 =?utf-8?B?a0FPaWcrNUlwYkROa1h6RmF6QjZZa1kvZy9yeTBaRjNhLytQSzhIWXpkRkpI?=
 =?utf-8?B?VjIvcEtBMGFWQ2RrY2pISnBnRks5eGNxbkpxVnRkMnRZYUE2QmFPVWE2WFEw?=
 =?utf-8?B?WkI1UXlWSTc1QlZSV0tLNWlUR1BZTjZLRFhFM2VydW5JSTc3MGtPUkVSbElM?=
 =?utf-8?B?anRIUEF3WTNSRnVSVk5jdFBEUnhKWllEM3Vtblh4cGNqK0VVdTRtSnhGcnEx?=
 =?utf-8?B?amJndG1LZFFzWDlwMlozZ3ZEdmcwN3RwUHo5OVV4USswcVFEYUkvMWVWYk5F?=
 =?utf-8?B?VjNJcVViWDdEVm1TeGpTTi91STIvSEU4dENoNjVIdlBVMzQ2WmcxQit6MU5C?=
 =?utf-8?B?Snd2emgwZW9NMk5nZ1VySjVzQjNNa3RVTDM5SXNWMFd0VWRNd0J3U1Z0MXhs?=
 =?utf-8?B?MXRrU0ZCTkpIUmpYa29Ud3ozNy9raG1zeWh2Y2JSd2NlNGRXdGNzeXV5OExp?=
 =?utf-8?B?OXpldldQUEtUZzRKcmZqWmhSaU5pcU83eXArUU05Rm9EL2kzYkkxRGwzdXVS?=
 =?utf-8?B?TWRiRktubERGMXBxbWhUSGtIcDBXc25BV3o2Rk5DdnNST1NqTEwwa2NlZVlt?=
 =?utf-8?B?UFhVRXdiWDhveDZXNnM5bVNhdWVYb2hXYThobUF3MTNWdVM2Y1U5RDRKK21E?=
 =?utf-8?B?eU0zQmIyTEwvcU9HWUgzZmZ4M1ZZUkxLZy8vL2dic2UySHczMDdpQ1g1VzRD?=
 =?utf-8?B?dmtwSW0xbW1sTzN5d3prdnBvQUU3bWZJVVl0S2hhTGliTEM2aGg2alhjd2tK?=
 =?utf-8?B?ellGTWhnVGc4UEJ6NlREK2UzWjZmZUdzakhtSG0xTlRiajBSTkZMTVhHU2lz?=
 =?utf-8?B?Q0J3ZXJiM3hadFZQM2hGUm1GT1dlLzUwd1dBQW1zSXNYa3FEbFpMZ2ZDbmpl?=
 =?utf-8?B?UDBtT1VxUlF2NTQrSG8zVUw4ckNCU2ZMK2REZ3gwdGMzMVZZcU9aYlI5TGNq?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c896a7c-fdd3-4e6a-6217-08dc6b917c4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 16:52:58.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRkVTzJMSMQp6vw4JZYwEgKmiRUpsLNmTkWOZ7IwedkN4Da6P+6x5RmRTiFRm4bLuM6cI8jmY3116DACHaLKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

On 5/3/24 1:00 AM, Ilpo Järvinen wrote:
> On Thu, 2 May 2024, John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
>> index d67ffa3ec63a..c873793d016d 100644
>> --- a/tools/testing/selftests/resctrl/mbm_test.c
>> +++ b/tools/testing/selftests/resctrl/mbm_test.c
>> @@ -33,7 +33,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
>>   
>>   	avg_bw_imc = sum_bw_imc / 4;
>>   	avg_bw_resc = sum_bw_resc / 4;
>> -	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>> +	avg_diff = (float)(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
>>   	avg_diff_per = (int)(avg_diff * 100);
>>   
>>   	ret = avg_diff_per > MAX_DIFF_PERCENT;
> 
> But how are these two cases same after your change when you ended up
> removing taking the absolute value entirely?

All of the arguments are unsigned integers, so all arithmetic results
are interpreted as unsigned, so taking the absolute value of that is
always a no-op.

thanks,
-- 
John Hubbard
NVIDIA


