Return-Path: <linux-kselftest+bounces-33337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCDABC59C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1DA47ABC99
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 17:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1959288C3B;
	Mon, 19 May 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aYgt9dz7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4B288C24;
	Mon, 19 May 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675805; cv=fail; b=dCKoOgiboUNxkLe8qxfXYbVUoDjeOyetP+9onC6jZz0P/oX6ZSPNZ+lVBG3ziTgpvhzGiB8wgyirqcrhfietUdqFISOrZfetGUnXLmrGVolKyi7/Aziyb8qMmIg4PLJ8ue9pdhsQ5DN5vbJEpVv2vQLDcXE5ybu4uXWPlmz+7wM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675805; c=relaxed/simple;
	bh=pkQ928uzlLl2fS3brP69lBeB9vS+boj+V7MOY6scZKo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOpUwNtjVx4DT5v0CVXcMW0yPkeHhebWBsK+JMgkB5Co8/WVyoqWjYQNk/2HH6X9TCyABH9pBkPTahdVS0Y45/ZmBlTBrzyUE+OUwchVbzs2/1JOu9F/qevcOzCLtCMKK/+nw9XEuZNNe6bHX8Lyjf2EB6BaqnhLY3ADx0YEvdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aYgt9dz7; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lartnJqxmyMkZpYnexNVRlqpwcGo5OZiNcZlGJtvq84k/SxszgivKF5Vxai2qxT86WCo8se+izUnpACORKCBZZKkm5oUdTHiAFCXnYLN7da/flGcM/N/U0jRc4iLEbg6oCeyDsnpsjHKuBgjvU3OpuA6FfyUeuqMT1Q8Bm0fl2kkZpVBQ0WqcJ1OSM7P7GIKlJVWnZc5itlnnZITdRtKe/X7rYFcxZVgzwoqgv2BFOQFBLd1QiYD5l51Er/ZuXRkpnlp0DwK22zmkbPExLP2vLryjv+Xjm2LNiVdEK0EK5VxCYUduxuoCKgW4sn2p6nFksW5cmGz30wzOs9kDxje5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZBt/EyxRCnDcnDjgRPHdoPRtjbInXMzzI4lnO+exY8=;
 b=G8CoU/r7NBodeZD4O4xjq8gBsPzG6/5fmNTJi+nKH591kYSLoKlzRwJmvhkPKFzbd/Iavnxsvjsx+/5nyEaJnbQUJTagrWkzx4MYLwPzw6aQ7xdSN66EL7BC3aUFrfYjafAkI6pirEXWWSSgP/6ya7u1Z+8OMU7lPYCVDnT9KJYoai73GTSmnWpwMe+zdg8/O1qEky1+tSjZddLxveM3tz3Yka9Z30/afx1gJS/nbwiajk1PyeZfXRk4g7Z9qNmJLQfIYI3wiL7QTC3lLrDwnS+dqhGDMkunqX+tWba682jWXXQbKjag7auc/qfaULrDPS9j9/30gM/8Rs+dqasgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZBt/EyxRCnDcnDjgRPHdoPRtjbInXMzzI4lnO+exY8=;
 b=aYgt9dz7Ut1w7zTpHsvm6KI5a2Jh6ougUciGw3hhDZdX/c4MMIgB+7rgnw0FwDHVJQkNKn8l3c1WOPUsCNS+7HwnE6shg1DHphCqWo1nW4zhStfoWdDY+cq0jSEssTtypp2uT0b00wdwiSPq5eqTcHJ7jcSzZ5SlhZrnuZwguvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 17:30:01 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%4]) with mapi id 15.20.8746.029; Mon, 19 May 2025
 17:30:00 +0000
Message-ID: <0019943c-44c4-4dae-a175-8a5bdc02f017@amd.com>
Date: Mon, 19 May 2025 22:59:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/23] iommufd/viommu: Add IOMMUFD_CMD_HW_QUEUE_ALLOC
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com
References: <cover.1746757630.git.nicolinc@nvidia.com>
 <f52937c027e2fd25d76bc47f4965ba46f82c77c0.1746757630.git.nicolinc@nvidia.com>
 <20250515160620.GJ382960@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250515160620.GJ382960@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|DS7PR12MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea3bd95-e20f-4b45-263c-08dd96fac83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHNYWGRaL1dBWDVUcnplUTNMZUExdEROcGc5b3o4T01MYTMyS2lqeWJ3V0Zs?=
 =?utf-8?B?KzVPVVN3M0VYd2NxK3lIcEF1VjdsZ3E0N2xIZjFBT0RNN2hqRENmMVJrTE5Y?=
 =?utf-8?B?TkIwZDMrVCtUblU3eVBDWlJHaUFZRWRxQmkwcWRoSHZENEp2ZHhORjlzQTIv?=
 =?utf-8?B?QWM5eE55TjR0Y1B5cXlsZkZBYlVFellEQUlCSndXUEM0VStrMXI4V0xOdEpv?=
 =?utf-8?B?cWtPQ3VyNEdmbXdJZVY5R29NMGp0aTN6emhLbElnSnoxVGFtZCt6dnMxRURS?=
 =?utf-8?B?c3dpVUl6L1IydHh3SFcwVWxnUVZaandxTDlkMTVuQWpkc3ZFeXhtdG9LUFlN?=
 =?utf-8?B?b2FPTE0wamJuNGsvblBtSDQyWEtIdDFkbldsYkNCRjEwY1ZnNzRRV2cwZmJv?=
 =?utf-8?B?NnZoSWlSUnZCVks5M2RJQkZLQTd5Zm5JVXhORHdSRm5DOFRRVHZoelNGTmcv?=
 =?utf-8?B?eXc5WVRFQTN6bk1JYkVTd1hIbytyQ3poZFNnak50WnJkVWtHNmx5dnlmTTRV?=
 =?utf-8?B?VGdDd1NoNGNSN2M4Wjd5dWFpMEtKNnJlOWFubU12WDlndnVZSGpYbW9KdGJM?=
 =?utf-8?B?cFRZZEwxSTM1K1J4Y1Y0eXNMUEZxbHE4dnpJb3FUbThMd0QzaG5QN1lRZ3la?=
 =?utf-8?B?VjU0VlB3anRGOW5GM2UrUmlSTFRrK0VCNmxXVUZRZVdKU24rTzd5T0FDdXVm?=
 =?utf-8?B?K1Y3eGVWNWxmQmFTdnhuaXpkY205VlZnOW9vRjJFWUtsRER1cUNFcFRWUDNo?=
 =?utf-8?B?Q2QvZDZadEgyaWQ2eG5NSXFKMVpsVGpyenp6enlHWmpJa3Z1c2piczhsQUtJ?=
 =?utf-8?B?N0dxekVmYitPellXeWlsdnJyTm9hSXllM3dtT3RpQzZaTnJPOXpQVkNwdUJ1?=
 =?utf-8?B?TUtxTEcwb1dlTklKQ3E1ZU8xZThaNGZqUDBsYi9MM2FGVk50NnVJanp1eWJY?=
 =?utf-8?B?MGVkdjZpQjlwbTJXL0JHK3RHRk1BckNKdnZPMkxnVFFFait2eEhLOTRzUzZC?=
 =?utf-8?B?ZkJkZGRvZldoL1VaOEtHanZacWRsMnk4cGdGT0toYzlUUERYcmxZMXJGb3k4?=
 =?utf-8?B?VTh5Rk5NME00dlRTcUprQkxkT2gyZ0FCRmdFNERiQ0ZTa2lueFgwUFFsVEdK?=
 =?utf-8?B?d094QmFJQlh4djY3alNEdTNqNXJNYjRJbzhoa2t0QVNub0NPQ3NOOU1pK2Qw?=
 =?utf-8?B?MEtBSE5VdGdNV21rWGxkbjczcC9aNlNURzB6Y0xiWEZUR1dCdDhwUG5LNmRx?=
 =?utf-8?B?OTRkUXM3RW05TTdGOXNGdGM0aHlZWG5EZjkvOFdDMVFDZ3VYZGpUd2VVTUIx?=
 =?utf-8?B?bElWdmE1VnNZbDQ5NWhNd2RtYVIyRjBWbDRLSllXZFVnL0h1U0JVRys1eHlU?=
 =?utf-8?B?NDNNek9RclNhWlA0WW1CNWdST1dpU2Yzb0crMWNOUy91Q1hOVUJwQ0gxQ3VY?=
 =?utf-8?B?R01TdUtKVVBPK2tRU0hNUWhFZEpqc1hRb05leExocmRaNGNmQ2gxWE9Oa2hx?=
 =?utf-8?B?elNITldWOUJMTWRKMmQ1MFJQQXdweEloWVpFQS9iL1lGZWR6dWY1S1ZqM1pt?=
 =?utf-8?B?WXpQMi9sVE9uWW9EMHFpdDZOcmYyZ05kdFhiZnBUT0pNZXFTWHJpa05qeVlo?=
 =?utf-8?B?MG5JQjh1WFV5a1REVjljNnV5MU5xUE9QTDdiejNCV1MxT20zYmFnLzJHQXBV?=
 =?utf-8?B?L2JxaHptdWVDR2FTRUJEM25ma3owbzIwS3JZcG1WN1pPZ2xTS051TWt5ZUNY?=
 =?utf-8?B?RTFjbjB2aVFBZ1E1WWdWUGxKdWZKN3hka2xuMU1vKy8rbmwvUlZLMDY2RWF1?=
 =?utf-8?B?N0NKam16RFhBcTcwTVU4WldDN25wZ0xSbHVMTUh1VldLaGlFanlERUZSZW8y?=
 =?utf-8?B?OWdrQlFjNmNhRFhvdXB3aWM4b3RqbGp5YUo3OTdyM1F2dzhEakFSNU9EbVIy?=
 =?utf-8?Q?HFNxKSOpUyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlVTVVZGSmNuWEp2U29zRkQ4NW1VTlN1NWlhb2RENlpTc0U2TGdWcTB3YThS?=
 =?utf-8?B?aDN1dmZwZWpIRjd6ZVc0Wm10QjVFanBsaGVVVkgzeFFNUlBxT3BicHFGRlFr?=
 =?utf-8?B?VDBIZVNTT0JsNHpNRDhOcnNNQnpHWWRQZ2x6bHVxUWlkNjdZM2hROGExM2lj?=
 =?utf-8?B?OWFObWx5SnNtWXFzN3VGQm9tZ2hLbHZMTVNVVCtPWTczdmhxVmlNNml1OFYw?=
 =?utf-8?B?OE9RVVpBNDh5UUdwL3ovVmliREx0OVlVK0ZtMzF4WTA1RWdlY2p6K25HV0hO?=
 =?utf-8?B?WDBma2ZPTGp6d2Z3VFh2T1BTdEwwb3JpS2NyTjFpREJDZnZybUZWS2lOaUZn?=
 =?utf-8?B?Qm95L3ZLaklaNWFlY0N5UmJxVUpQR1RqUFVtZU1sUkQ1ZzA2dFl2SUNlK2RD?=
 =?utf-8?B?ZDR0Q2xCaHF1TjliWXNZeVRVM2Rkb1pRK3Q2Njk3UDZQbWZoMjByRm9hUEZs?=
 =?utf-8?B?OTliQmdlK3VOeDQ4WjNJczVvd2hCT1pPUVczalc0UFdFK1FZWTZLQURTM3NU?=
 =?utf-8?B?c0hsTk5PaUZrUWExOXM2R1lyY005Yyt6T0lVN3lUY2srdGN0UFg5RU1lM2pG?=
 =?utf-8?B?M256RTF4K2d3VTlJMnlIYjlVaGs0cVBKUDBDQnFreFdyZUdiNkV2S3AwT0Qr?=
 =?utf-8?B?cGN1Z1VVNEdLV21oYlR6eG5HZnVKazhLU002OVNrQmw0Y0Zwd0FOMGZFalhp?=
 =?utf-8?B?SWVYUFdQN1dVZXFJWW94ZnpxUzhzazZCU2EyR2d1dE1ZWitNc3hvckJqY1dJ?=
 =?utf-8?B?ajR0M001c09IdkEwMk5nQmhDTFZsbE0weUVTek9LdWZ3bzdhWlNmT3NNUnFi?=
 =?utf-8?B?dTBJNmFYVS9aV1gwdVpCRDJ2RFZsbm9PNGhiKzdIZjJPdXVLYVZJdlVId1dD?=
 =?utf-8?B?R2EyODFNL1hUK0orVDQ3ZjVBY2MxMG8rbk1hM0VtelhhTzRkOFdoWkloUUpJ?=
 =?utf-8?B?aHlndlAvNnVZcUxSS04xT0RNT3h6VWVLanNLWmpNaHFxazE5WmdTazcrWi9F?=
 =?utf-8?B?Y0cvekdBTkRxY3lpakdJYVZFUVJXZ3d3RGlCMDArWTFKa01nOG9wSDhEZDha?=
 =?utf-8?B?M2JuZjA2L1UrazI4aDE5Z245eHEvSGtSbTQxcEdXWWlaUFg4MFNibGZlMzdU?=
 =?utf-8?B?M2Nlb1hpMlpCelB1RTNDNGtTMktMZHJPR0JyNkRicFVoZXBvVnYxbFdONkR2?=
 =?utf-8?B?SnZ3MXRxYnNqT0xLY3lhQVNaWlZ0TlpQSitXVjZ2VEtVQzZNWGdOdmRaU1M2?=
 =?utf-8?B?Q3NIUmlvK2l0Unp1c1IvYmg4RHM4Y0cySmNyQ09oSzZzMlNBL3d0QzdyQWhR?=
 =?utf-8?B?UUR0TmxNQWNReEVTRWhsMVp4RGNmM3VreWs2eWRJNmVNcnpyWUlHQUpuOVQ3?=
 =?utf-8?B?WGluOUt2cHpXZG1qRmVFY2U4U29JeXdCdFVHTTUvQ0pyVTU5NThTMlpXdzhB?=
 =?utf-8?B?K3N2SklIN3RtY0g5a1JCcHREMlVYNVc1bVdONXpLQVI4K1ZibE1BLytnT052?=
 =?utf-8?B?bWx1aWMxSGhXNms0WkhITlBuWkhjUUJDOG8zYlNVSjZCWE9jS3BoRTJjRTlO?=
 =?utf-8?B?TFVzNjg3K3U1Q0wrVUw5ZWtZWnZhQUhJbGJTN1VsTnNKRXoyQTRmY0p6MFly?=
 =?utf-8?B?N1B1TkttcFhjQW0zTU5xbndueEdkbmkyWUNYSXZmaHJGaXEvd0xVbHNFdG5a?=
 =?utf-8?B?UEJrNVFqbHZNV3I1Q01PQ3dBN2s1cVVDZFZJVEphUjRsQ0hBbnd2RkV0QWZr?=
 =?utf-8?B?dFlJTTlXMDBYRXlhMjMrQVAzR2tlWlJ4ZEdBUTk3b2c3VE9vRkxBRkhsTkF4?=
 =?utf-8?B?NG1TZU5kTnNyUDk0K3RpeFREM3lRVzdkRXdCZlVEdkpUZ1pQSlpUUjF1U253?=
 =?utf-8?B?N0h2Y211Z3dXWUM0emFjSlVEaHFHOFJLTXVwYnpoUVpCdG54RTFmSCtaR3NV?=
 =?utf-8?B?enhrWldLNjB0dytiV3pyQnBhakFwWjlwZFJHanFHSllvNFFKVFZ4UmZ0dEpE?=
 =?utf-8?B?SWIrUEVQOHkzME83OGZwTk5Tbkp6YXhhYjNoMVBpTkxobG5tM2w1S1JVUnl6?=
 =?utf-8?B?MmlzOUluTk9DdjZWOWNrMlNDKzB5T0hpTi9OaU5JdmJBeFZtajlOckgvbVNw?=
 =?utf-8?Q?82bC0Rk53kj/FTbWLA4Sy2uhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea3bd95-e20f-4b45-263c-08dd96fac83b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 17:30:00.5698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXlSg1fIMcA04p5d9JPsy2kr8/ENKw+5PuTvYWzDxYzkHIims7b48o/YmBEaboEptY17MkrjBDs3H8/osA6bqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5958

Jason, Nicolin, Kevin,


On 5/15/2025 9:36 PM, Jason Gunthorpe wrote:
> On Thu, May 08, 2025 at 08:02:32PM -0700, Nicolin Chen wrote:
>> +/**
>> + * struct iommu_hw_queue_alloc - ioctl(IOMMU_HW_QUEUE_ALLOC)
>> + * @size: sizeof(struct iommu_hw_queue_alloc)
>> + * @flags: Must be 0
>> + * @viommu_id: Virtual IOMMU ID to associate the HW queue with
>> + * @type: One of enum iommu_hw_queue_type
>> + * @index: The logical index to the HW queue per virtual IOMMU for a multi-queue
>> + *         model
>> + * @out_hw_queue_id: The ID of the new HW queue
>> + * @base_addr: Base address of the queue memory in guest physical address space
>> + * @length: Length of the queue memory in the guest physical address space
>> + *
>> + * Allocate a HW queue object for a vIOMMU-specific HW-accelerated queue, which
>> + * allows HW to access a guest queue memory described by @base_addr and @length.
>> + * Upon success, the underlying physical pages of the guest queue memory will be
>> + * pinned to prevent VMM from unmapping them in the IOAS until the HW queue gets
>> + * destroyed.
> 
> Do we have way to make the pinning optional?
> 
> As I understand AMD's system the iommu HW itself translates the
> base_addr through the S2 page table automatically, so it doesn't need
> pinned memory and physical addresses but just the IOVA.

Correct. HW will translate GPA -> SPA automatically using below information.

AMD IOMMU need special device ID to setup with  GPA -> SPA mapping per VM.
and its programmed in VF Control BAR (VFCntlMMIO Offset {16’b[GuestID],
6’b01_0000} Guest Miscellaneous Control Register). IOMMU HW will use this
address for GPA to SPA translation for buffers like command buffer.

So HW will use Base address (GPA), head/tail pointer to get the offset from
Base. Then it will use GPA -> SPA translation.


> 
> Perhaps for this reason the pinning should be done with a function
> call from the driver?

We still need to make sure memory allocated for page is present in memory so
that IOMMU HW can access it.

Pinning at the time of guest boot is enough here -OR- do we need to increase
reference in queue_alloc() path ?

-Vasant



