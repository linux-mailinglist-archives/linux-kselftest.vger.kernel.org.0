Return-Path: <linux-kselftest+bounces-32642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 051E5AAF22A
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 06:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A724E6C6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 04:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13EF1FCF7C;
	Thu,  8 May 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CIBKKxZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F41ACED9;
	Thu,  8 May 2025 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679637; cv=fail; b=Hzxi5/TsVF+rlC6haYq7qW4LyKMDdtHmF1vA0NI/oVDj3cEuFZ186HoLjQ6Jv49mS2ZqFgtGL6z5MmCQuc84ylYDEwEmWwSpR/GkIKgwfo8zsUEv68JNyEPrg9QyQGF12lPNod0/oXF+zZqyliewwEgpEbJI1E55Q1ah5iqP4jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679637; c=relaxed/simple;
	bh=Xo6kMBy1BRKQS3DaF+4Sci3BUgeEchRNBL4cP7i2WKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GjGO+70ezRi4YQK5+1rej4Ddw5f0vo33xauaEzmsK3RkjwnovBNL1yaZxefLYm3RYxspAetnf0XmbbddDxh5KC9uce9fXPC7+bduH7onYTcvzBjzmzybbCvGKxLREzx2Geo8mTGNQYjOP6zv2gWX0GVxv+PtmTMSxWXP0uKAokI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CIBKKxZF; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyzQpBH8qGJXc6jgaeXFEoUA+E8wjT+4kXytReqzwFWpf1Y9jBzYjksvtavI0bUMLTavlz4x5a8haoJ8PTmHiJku3A5qevuYM3U5aIwitnGvbn1Xf/jEB3m834oGCKhVQJtsA61SsSLuPmhDfKr7E5VXgYCspEiKvh3RW5fQF1qEPMxETON7gJNw/0Si2R/K4p5x2VAjOQCQNZlq1EJjbuL7jSXgD0E6DINyCrzzAhn+cZ3Duiyb1DaLbA9OQLFLRgokqz4ShI6g1VQmlvEjXUuPh0xNxLhePjEooGZC7pg63yPJsJug95K5gcYpiLNOrJeGtR8S+OX8QDlFLCNkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk+WTsScYu4R4h657hZvcioksK+HnEDOlPtG2NTL/cg=;
 b=vtpr55MUkHbrsx2TZY0X83+XcjwJ/LTAzJxPgSxsaAHUJ4NKSVzjVJNjlFi7xw45BfC9mFGLCINzoEEUmO5l/jmKul0aLYrc6TxNH72HERr8Brz4RRBjCuu8D12DGpaisr/qdxUKl/TqhtpjNvIkYz6lB1g0w/lgD9IKmhoeaqGg5OPUjD+w0KzE4hlIxumgRXDPzs+YkjP507gvV8cRc0dgB2IXiCaKWDGvf/hpnEwNk+alJV1AxACrPQid3W145yx9jAGHkwHX44e1qJIriT8HkuWt7i0uHOu8nCQRwwk9dgFnAYMcPi9Tcy7ec7cGVk2bC3QowvzFTESE4aMPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk+WTsScYu4R4h657hZvcioksK+HnEDOlPtG2NTL/cg=;
 b=CIBKKxZFaLKzsnNMvMsJSlw5zMl8xBXf2aqCqAhv1mlIYQNJusj2O4B9OrjzOVnaZo7yAnx7WqPvCJVK9palN7gLA9IYl8PPB5gWqUqZ6vZuoGkZNxeXutYaB9SQwRm+w0bA529G4nlCAjm1wjwolKgro+ftb0Ren2z/YeNh064=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 04:47:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Thu, 8 May 2025
 04:47:09 +0000
Message-ID: <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com>
Date: Thu, 8 May 2025 10:16:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
 will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
 joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
 jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
 <20250507123103.GC90261@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250507123103.GC90261@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 796ee058-5547-47be-f298-08dd8deb6410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFFtdDBmckJDWGRHVWZ1dVB1WURCc3Raanh4T1dtaHZYb3hoV3piMlMxdnZw?=
 =?utf-8?B?S3JiMWs5NVlhV3FFd1oyQ3dFcWdQM0RpTzM0bDZhQjJsNjFQTnlSNXpxRnN4?=
 =?utf-8?B?T3dMV0Jzd1lxa2FPLzFsR0QwVWRZU3hnd2tjSVBlQUV2S2NERisyNjQxbGcw?=
 =?utf-8?B?R2V0czdUN0hHM1lzYmIzaDNackxYbWJkdVg2VExLbnpVYTRRR2NmblNkdFR1?=
 =?utf-8?B?MVlXcnVNbFZUbXNQdmpvTExjdGw0V2dMN0lNdC8xQVo1V2prdm5oNm0wUHcz?=
 =?utf-8?B?RHNYUWpvZ2VLSG5saUdhYUZENjJjc0J6MmRTbW56Qm93YnlhSnBQRnhPVVRS?=
 =?utf-8?B?STRndyt3NjIwd0lYREFuT2dsWkhOYU9QRWFQa0FjNHlKQTBELzVBSkRSZ0cv?=
 =?utf-8?B?YmR1YTlsZUlIUFFlakt6RzZZdEhxY3ZpdXI4c1lxK3lWdUJYL0h0WWVtcXh4?=
 =?utf-8?B?RGo2RnlJU1pNZVBYSER6bjJhbmdVRWxkdVhOVlI5eEd2YWlkT1R2cG9vb1Fl?=
 =?utf-8?B?RmxtQXFnV3JkbTNrcksvUnR2SzdoSHlDcjB0dHhCVUtOcGpBVC9FWDB4RWRC?=
 =?utf-8?B?YmY0bk4yWTlvUHRrK0ZuNlFSaThoL2tWa3J0N3UvcFgzRS8zWWI5SDJGV3A4?=
 =?utf-8?B?ZTZkbEZicmJFVEZyN09XMWtqcm5HK1RZRWdqTy9teXFRZVI5bzhHekxHdFpz?=
 =?utf-8?B?TVY5QnJHcTV3cmtza2xXYkVXRSt0Tmtob2F2aXFPWDhrWVYvQ1dVR2lBeTBh?=
 =?utf-8?B?N011cDVPdjEvOHYxQmlrdTRqM3pPOGh3UHYzWlhzdHVkNDV6cERDSnN1SEFX?=
 =?utf-8?B?aGppR05zRmFORTBCQndsOWpXOCsvVnhyVlB6K2JxbFhCTTVhUndoWHdjaHZT?=
 =?utf-8?B?b21SejZRY1oyZW5aN2xLcFIwVGplcUF4L3hxYXVPWHBSRkkrZXlaaW1YWHNL?=
 =?utf-8?B?bDVxU0kvOTFIb2N0VnR5WHVGZDRGWkVsb1ZWK0dHQ2pwZ2VWYWVrb1ZEK1Ew?=
 =?utf-8?B?cUM3dll6dFRmazNob0FIV2l0QmpQZUJ2ZE9XQlgyOEkzcE5IVVZxZDNaUnFq?=
 =?utf-8?B?UEdadnlJZmUrMjNEV3BMbzc2VzU1U0EvamYxbUt1MzBWYjNTcS9DMVYxd3Fn?=
 =?utf-8?B?b1BYS1dNYkpKTDhjVHg3ZEJDSUtDUmtTOFBYR0ZvYXNCamM2a0V6V0RnN0NE?=
 =?utf-8?B?ZkU5VHVlWTJVU1lrVkNyUnJTa1dCd2RseWVvb0kwcXdQbDVmNVpURzVzbzlm?=
 =?utf-8?B?NWFyMVFGY0xVMXZvWGlidUU0ZVNTaW9PUzlJNjVPN1h4REgyTUFIRm1GbG96?=
 =?utf-8?B?MnpOcWFwbEprWVM0U1V5NllRVTlnTGF2WFJGMGpDWnJJZVVQYlZndTRualFU?=
 =?utf-8?B?TkhDQjV3MUpTZ0lQVzI2bTlET052UW1NSGRhc1ZYWDQyMndXQ1dEK0lESVl3?=
 =?utf-8?B?angrN01QZ0NESDU5YU1Ha3hmZmdRbmZFYzJoV2ZSOExkczlyZUhLWUhXUGNq?=
 =?utf-8?B?RHdKYVF6OUlXbjJ3OWM5UHlhUWhJRTJaVkpIVW1TWEVoTzF4UE4vWUxEYWdI?=
 =?utf-8?B?NkdrbjNyQ0FROHlTckNmOFlMOGQrUmxsNlhKSGtaL0QrOVhlU2djVUtMVjlV?=
 =?utf-8?B?aHp1TVhITkhsMXFkSm1DYXNjRDduaUZuc3h4QlpWUnRtTXIyaDlGR1FYNU1R?=
 =?utf-8?B?TnRhVnAwbzRzYjhXTm93UjhyTUdoWDBFM0ZibytTWmUycU9ENEE1TnBvTUtP?=
 =?utf-8?B?Nng2bkZwbkxaa0FKOVJNeDNmSHM1cE1HamRvY3RQT0tRWUZYdXNlaEQyRVIz?=
 =?utf-8?B?SFFxc3RVVzVkNDhTRkJTUjhWZDNMeEp1V3hPTEhNaTlMN0dDK2w3UFZMRTBp?=
 =?utf-8?B?VVJTUUlzemViU2trL05hQ1A3WUVaREhIaUJBSzZOR0szYTU0TFFRQVpPbU9q?=
 =?utf-8?Q?2lQG9Rh9bH8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEx1S2hnSkVrcnBZVTRWUTFFbnlNeUw5bWlLUE9ZUmZKNUt4Y0FGMXVVT0dQ?=
 =?utf-8?B?Vm1BZUdBRmNGVCswdTRKd3VMa0lKd3UxZzlDa0RYNVhCWm1KSUhPL1NQbVJ5?=
 =?utf-8?B?TTdzQi9GODJNNjFUWGQ2a0pWeVFvYSs4ZjBTOEpKMVQ2YWlwQkExY0RwV2k3?=
 =?utf-8?B?Ni8xeDYvRlBScWl4T3RIZ3Z1ZnZEOWFaUDg4ZXVXSUIzZ0FyWVNqVlVJc0hQ?=
 =?utf-8?B?Sy9WN1hFK3owVFFsTHZ6RWRBR05hem92blBDZHJnWDJEQzhnc1dqeGdmbmU5?=
 =?utf-8?B?bEdCaHhDYjEvcXVyZDF0KzFJbFoyakZONWkva3RxbHdieGttdFJwTFAyWVNm?=
 =?utf-8?B?a2pleGdKWXVlM3oyNUNyZ1FwaEhWWG9rZ3oxQTFrNFg0d2hmcDRaQ1I1T3Vn?=
 =?utf-8?B?UUprR2xjU0ZUQmVZQXdTZjdSL3JqRGtyem9iUThqQnN1dTYrMDlVYmFiZzVF?=
 =?utf-8?B?YWRRZi9IenVZMjFLcDhJcVgvVGUxd2xOSjJmUjgxOUpBdnhmMjk5N0ZzbkM5?=
 =?utf-8?B?WllwSys0alM4UEYwZU0yZGRXY2xVaU1XaWFjSDZxbk05dUdScWw2eHVXKzBQ?=
 =?utf-8?B?VzFjWThSekZ5d1kxbkM0eVg4VkpyS3k4ZkJ0d3NoTFkwc1pIcE44NGJTYkpl?=
 =?utf-8?B?bFNKNmN3NHRZdUlIMG1hSUtrUlk3czRiZVJsTExaNFRNQXBFLzkyRVNIQWdD?=
 =?utf-8?B?cVNSR1BrcHhENGJGYzRjeEJMdHFJaTFEdzNmUGlpZTlQd3NUMGxzRy9BR29J?=
 =?utf-8?B?cklaUGdIQ2VCL1UxNzQ2YnU5Wko0dHlma1gwWUNFYkhPZmRXUU12T0pGMTVi?=
 =?utf-8?B?TzNVSHhBZjVSNDlmVHJNUnJ1RnVBL0xDNE95ZmVBb1JrZWhaWkFyNHRCb0V2?=
 =?utf-8?B?YlY2SUVxLzJmcXVvV0xlSlkvQW4wWlI0c1J1M3BVbktubXJVWCtRUkp6L256?=
 =?utf-8?B?Ykwvb1RpZ0xQUUtRdC9ac0dCYURxRS9MQUp6Sk5rQXkvZGQxMWN1b1dTODE2?=
 =?utf-8?B?SjY3Q0lLTC9tb3E1d3pGK0piYzlOeGdZanFvVkpTemMzbzR1QW9nZGs2SkRm?=
 =?utf-8?B?Y21aa2JWSE5FOEQvcXJVRnpEWk45VnBocUYxUm1RK2lSTWcwd2hUU1U2QVVk?=
 =?utf-8?B?a3pGQ3FhTkJMbGpUZ2g4K0V3Mmo4Y1NxREE0QVN0R01qWGZ4Qk5aT1VwRlRT?=
 =?utf-8?B?allQUXpRVzVxWWpMZFlTc0pXZCt3emJyVWNWcFVNU3UwYk8yb2hFeTlERkdT?=
 =?utf-8?B?MGhVTjdyekt3aE1WMTgwalJuL3hnOG5nenEvRXdrbEJDYXBOamRXWThKbGZp?=
 =?utf-8?B?SDYra2Q0YkpucStWQzAxT0tEZDdsUm5Uc1paUFRLaXZ4b2pnQnZ4UlhKYUV6?=
 =?utf-8?B?MUtGNFVpZnFvLys4UFozdnpiZXNZc09KMDVtRzVCd3g5MnN5M2sxMDRyVXpt?=
 =?utf-8?B?Tk9PNEFNNWVQaFljOFQ5VTRMSXZ0OUFabXdEMFNZYTlHMWxNcmhUbXlLZ3Ni?=
 =?utf-8?B?bmtWZmhHeHNsWFUwV25SQUNDS1A3dHRVVGVydmYyZ0pLRXdjVHBQSEcra1lQ?=
 =?utf-8?B?bmhMVCtxMHd5VTVRWEs4WWtBbE9pdTdYczJaQ053aU1BZHFtUWZYNVJtb2Zw?=
 =?utf-8?B?UUQ0Uzc3ZFV6SHdLd3laa3ZOMEdycWRDQU1kWEtDckg5TWV4MlNkMEdkbVB0?=
 =?utf-8?B?Y05OZ0l1WFpTMXBwWG5qaUZ6dmpQV0lNMEd1UE9BVFJiSUE1eWFaamtSYU9n?=
 =?utf-8?B?dnBFWXdwRzg1QUFmUEJSTTJoVGV1RXNZZXg4RzJRQUpjdm5Xb0lpU3hzNyt6?=
 =?utf-8?B?SzZEOTl6dFN0QzVFOUxoTEZvcVRKaHAvKzltdm4xeVdWMmNGZ1FEdDNxak94?=
 =?utf-8?B?QlJXVTlZSXpvMGpqUTd4cEpQa1o1dS9iWmdVU0ZrQmpZWHBCUzFhL0ZBSVp5?=
 =?utf-8?B?MW5sdWhaR25Ta2VCTnVNNWVCMEpLTXJTdjhRMFptNHd6RlJTcUJkMHNVY2xs?=
 =?utf-8?B?ZFNRb3RGZ1NMaTE3cVVFSUlLWEFpSDFnbjZQanBuVHhNNGJNNXk1Q2FyaUc5?=
 =?utf-8?B?YUdvNC9aRGxzeGQrS1ZlVUJBUlNRZTFTU2dzWFJPOXdveGYxQUV4VnlMRFI3?=
 =?utf-8?Q?7KlVOokX0nojJWkAZxdJHTIzU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796ee058-5547-47be-f298-08dd8deb6410
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 04:47:09.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVti5w0kQqTY00r2+tsOr8veiZInA3chzG8sZ/fMS9tjcIygQj3JR13lhdj2lCQ42QfPgi7LNs7JU6gVO0TSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283

Jason,

On 5/7/2025 6:01 PM, Jason Gunthorpe wrote:
> On Wed, May 07, 2025 at 01:11:43PM +0530, Vasant Hegde wrote:
>>   -  MMIO Offset 0018h IOMMU Control Register
>>      EventLogEn: Event log enable
>>        * When guest sets this bit, qemu will trap and will send queue_alloc
>>        * When guest disables this bit, qemu will trap and send vqueue_destroy
>>
>>      This part is fine.
> 
> Ok
> 
>>      EventIntEn: Event log interrupt enable
>>        * When guest sets this bit, qemu will trap
>>        * this needs to be communicated to Host so that we can program VF Control
>> BAR and enable the interrupt
> 
> This sounds like modifying the vqueue? Or maybe on the viommu?

IMO its VIOMMU as it informs HW to trigger interrupt or not.


> 
>>   - There is other bit "Completion wait interrupt enable"
>>     This doesn't related to any buffer. Instead if we configure this for
>> completion wait command it will generate interrupt.
> 
> This sounds like a modify on the VIOMMU object?

Again in my view its VIOMMU object as it tells HW what to do when it finishes
completion wait command.

-Vasant


