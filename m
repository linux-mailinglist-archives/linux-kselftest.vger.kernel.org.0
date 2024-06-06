Return-Path: <linux-kselftest+bounces-11321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A70138FF7EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A801F23B37
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A213B7A9;
	Thu,  6 Jun 2024 23:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fp11/p7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D658535C8;
	Thu,  6 Jun 2024 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717715373; cv=fail; b=SgqRrw55frL+aaVsga1fN6vt77cl8IpW/FZdcYuLqiQW6offJBsuCn2kYQO5O3CZzoBh1g4+ZBTszWocE+SRo9yfIv5sAtqR/8kk5COGHlt1mEXMTRPV1YXbxktRA3ELJ0hu/AfEt425kXmGJmjcoqcjhTb0EjIl67O08miqylA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717715373; c=relaxed/simple;
	bh=nm7FuYU+qKRzUbBO1XdWqx+3VW3BiCey1raQc5ijE8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HcLPBH8iwykZomFokXgJyUK2g5hDNVB9usx52jlfOveT50AoOrrie4CKfSSje/RaaFFNaUR+gHXJzcZsnXi1TEFoRJOvURnxScDKXGAxo+4hofrmUtAdvzYtkSg3RMin/bw3Zpicapqn8OsZ8IvUDLv0ScnqlYn0NvDSDYb63ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fp11/p7W; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZPO7MXOghqh+5f4MmPviPhbCNcfTLlreE4ZF604zgUqrXwW2U9dFuubjYPN7/W7As1KsUNwBhP4kBt+vylK5zK3U/w0nCo42YmtXLyIAwyk8LBn94YhxQ94DadLXSm9KqZyBdDcduJF17vCuwTUDRJNp0tgLDM9uhg/n+jVFQyI2f2FRLxZNEcdSCRX5wSYxgKXltU7pPpJEpAo/zHJ5+6Npi+smmOmI/m2rCl4vDkVv7yOa0ZywksxqSWm/LsbFKR5lE3v/NkHiYN5rtX8lWtpRBpuiYxlm//b8IOfpup8DIjDsiJ+mgSv9BMe1ppoQimeii7+IuZNR2ft9SD0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnVszpHuOKbtVj4tLYmGAk3tx1qd+mZrYDZ/+ZMfMvE=;
 b=JregTz2732C40s6AIjeaggkXd6e4g4148WB2laYv8KU2dQ6O76GZwQtmaj6qnRLwZ+SS7WacD0rKjKoZYWHvo2j/OWaQsSdH42zwulCTCabIbKdY3GvMORqAIY0DN+k7rBGdMGuHTg7ImHYlQmKy62khh9oeh/5Ampy6Kpa70BOATv3E/8NpoFiH+L2l8BELk2KnPor1MQCSvivvo46X4c+z2mb4+avhpXbrWa2okYv69EHupbDVxHhu9nQBHtY/z0VsuZIw0s+nawUvCQgd8zTJw8WtTopUkz+5FJa41LYCvwoxM3sBDPgc/x7p83vhno0a43cX8Kn45QGBFw/VWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnVszpHuOKbtVj4tLYmGAk3tx1qd+mZrYDZ/+ZMfMvE=;
 b=fp11/p7WqL2JxhfZyOU4p3wQgw1hPDFGa3gBqHrdrHYAxFZqNjndQ2gfcPBMgUvEuV8iT/o2XiyZMjcWMxu7h8WNcIQ0Uug63018vf8C7BSRsx0K+L1ALFaBPsVsStwDCpor9Vo3tEp4DwRsqyrxj8Nn9lLNJGsfYtwkLavFdT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB7895.namprd12.prod.outlook.com (2603:10b6:a03:4c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 23:09:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 23:09:27 +0000
Message-ID: <3bd755d7-e5c7-3dc3-9875-4884c857e325@amd.com>
Date: Thu, 6 Jun 2024 18:09:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] selftests/resctrl: Fix noncont_cat_run_test for AMD
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <9a7213d2-a782-4342-93f2-acf191c745fd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:5:177::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 700478c7-2765-471b-c8b2-08dc867db67f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEJjUFFCcG5DYVlVUmpwbVBoaC9Ga2EyL1ZSZ1B5WFdsb0lhaE5scnlhTHY1?=
 =?utf-8?B?VWsrNHB5ZEhTaXBKRUtUYUM5ODJKM3FiU3IzRjdRYk56V2tEczB1RCtYa1Y1?=
 =?utf-8?B?eVNIYXJCV2hoY3FON1dhTGwwTko2bnBpTHBzR2Jaa2lCaTREODZQVnRpNDk3?=
 =?utf-8?B?enF0M2hFRmNuSWhWV1ZWSlgwR25zZS9KV0JycmVRdHVpeGorcFhYMjBURzdC?=
 =?utf-8?B?Qmo5b3RxYlJya1I2NXJhNHp1UVU2MDdCMVVKNEUxNHlBUlFYd1hFNVpkQ2Fn?=
 =?utf-8?B?Z1JoQXJIQzUrUTdLSGpZSVNGVis1QVV1NXZnQktGU0NmamtDQ05RektGN0h4?=
 =?utf-8?B?dW5CNHpWcDJKVk5WMk04eldPTXBRTHgzK0VqTlFyVUtqZFhqMU9FT0hDdzln?=
 =?utf-8?B?VzVXMHFMN29oMUNlUzlNblBCdVB6QVVLUW5HTW1YcUt2dEpYUkxHa3c3UFA2?=
 =?utf-8?B?UU5uK0tpYnNMeXRsdHA3azZxSkxiWXVrelVWZUhzZndnNStrWUp1KzV1Yzc0?=
 =?utf-8?B?S3pySm8rZlVvYXhJM3psbkI0UmhQa1F3WU5LOGdKb2tTbHlsbzlGWGx3YTJW?=
 =?utf-8?B?aGI0VkIyMUpiTks3WTZIWjZPbnNxVlJYQjJUa2JLWmhrRTAzdTZNUnRpVGRz?=
 =?utf-8?B?TWI1VXgzdHRycXdmdEdBNnNZaVIzajQyYVlLVStzcnJ2dzhnTlR6dHZIZlpO?=
 =?utf-8?B?MHV0ZFNIRnpxQlovcmV4RGE2N2ZQSWFTR3NLRkpmaGdSS0crYnk1T2N2OXJU?=
 =?utf-8?B?dGpqQnp3Tjh5d3ZGdmlXYmlVeFdoajNsVmtaY1FMV2JuWmdVL0hzNk5OV2E1?=
 =?utf-8?B?c3BPQWZicmRmSVp0WjFRTmtBWXhwYTVpZldrU21ydC8ySWJNWTVhUDVIL3gy?=
 =?utf-8?B?V1lKT0MvT28wS3diTkpzWjB2WWRGdkdlSDB4VnZqT2tJSDJ5aHhON1J0Zjk3?=
 =?utf-8?B?Z3BjcytVMWhsWWRLQ1UxSWpGZ29INVNCS3d3VlpKeTc2OTc4YTdqZHY5T3Zx?=
 =?utf-8?B?TUxlQ0ZFOXY5NEVhRms1L3N4Zi9abHdNeTJxcVhKZ1gxTnVOUWVZaWs5dHRV?=
 =?utf-8?B?Tm8wdDBITnFUbFREOHN6djlOOTVxNjRYWUFJcjZRR3VRdHMvMHVNTXJjTzMv?=
 =?utf-8?B?aTVwR0RISDIxSmlORzA0MzlubHhDOHM0dVRZZzZEc1cwa1RIZlZGWEJXK1Ix?=
 =?utf-8?B?WWVscjlCbncyN2VsVUNESXJabkFMRXJOa0hMNVMwRWhlS1EwYnFQU3dTL2Fp?=
 =?utf-8?B?aDJlclozbnlGSGU2ZGFiZjZSQU5nLzBKRkJQYVZ2Z3puOFJ1Yzl5NzIzK20r?=
 =?utf-8?B?bm92WERmU0M4Sk5jRERIeGc4RTE2SHVRUU85T1BudUhvcDR0TGdRNjlNcFlj?=
 =?utf-8?B?NE40YjRXZXFHL2JiMDlFVHJibXZYdk5XY3UrMFFsVmMwdmMzdlZxMU5hZFI4?=
 =?utf-8?B?MDhCa1dVOHBvT2hpekI2VHk5MnJ3MXdHMXByNTVEbVFta2hNUWk2SHp4U2Fq?=
 =?utf-8?B?VjBiZ0IwU2E4K3J3MUxpTGFpNGFTRjI3anZOQmJ3SC9UOUVjcy9hYmUzQ3p1?=
 =?utf-8?B?RlByL2tTOWdvSHZMM0s4KzQrZzlZMURSdm1qbGJ4UXV5eW1ZMVYxSXNDVkl6?=
 =?utf-8?B?eG55UE1uKzEvM3ZuMEFJaDE5YlU2NW1KcUUwWVFTK3J4L3ZhY2UrUERhSS8v?=
 =?utf-8?B?YUZzMlpFTTFBQkhGRFFxRGxTLzlCWlllTTM2OHJWTUo3WHljTWcyaUhYOUox?=
 =?utf-8?Q?uCEJrr8dqpidHmZWi0BleOKz9ycbLdkQYzWcoMf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmJvN3ByeW9LcnF5SkxtUjBJR29aeUtFSEpvSGxZOVlkM3I2ajFobEkzZjQ3?=
 =?utf-8?B?SDZmVmN5OUJxbkFta1dXMndSVklvdUZsVnYvZU8zY3Vqa2NlUzBIbHVkYS9B?=
 =?utf-8?B?L2RXaEZBbVBPcHlwYUhmd3ZkQ0t1R3dXQ3BZYWJCeVB5RTFZaG03ZjlqdGdN?=
 =?utf-8?B?UjBVcmNJS0U5VXlobm53SXZBSkJoTmJUak1IUEs0TXRPWENrZlBQWUZoL0ht?=
 =?utf-8?B?UTJ2d3lIMGxsU1hlRGNPK2VBMHVpZ2N4SDlZWGlkbVRFcEpxOTM0VVphUkFQ?=
 =?utf-8?B?a1ZIU01weEkxeGVwODVad0trQTBhMFUvSWZjd0hsSFJYUGlRcEdPNUU0ZTE1?=
 =?utf-8?B?Vm5UVEZTTjR6dmhhSUp5Q3lCZllNU2JHZWR2eWFSLzcvNVpQSXhFVTNFMC82?=
 =?utf-8?B?bVpBSkk1MFowRmpZeW9SSElIR1psWk9KRTlCRnlzYUNsMUJqRlZjZ2lrdStN?=
 =?utf-8?B?eU4wUldNWGUyeDRxNU50cjh0U3BsQllncCtZUlh3THVGaWFTWFlNSS9HZCtj?=
 =?utf-8?B?M1Bkalo5ZHNBaWJGN2MrYWNKZDFiS0RGWU5GQUU0M0ZvQkY5OFVOZEpXakx3?=
 =?utf-8?B?d1ZpYVBzYVVBNGdjd01MSUdiaUxqL08xejQzS1A0RmtKVGlPWS81SlYwZHI2?=
 =?utf-8?B?UkRvZW5WblZ1dldaZUljQjJOSU4vTytrT3ZWVWVVc3RsbFlXODFQVjEvdWlo?=
 =?utf-8?B?c1lVS1lZZkpmTnhmWmJmdzg3K2YxV3A0S2c3a2M4bGppajVCUkd3b3U3WFIw?=
 =?utf-8?B?ckc5dDNlbnNRYmgyMGowVmdtWmplSkJSbFM5UWEvWWcwSStwVkZYNWVUcmpJ?=
 =?utf-8?B?N3ZEeElEUlhSZ05hcW9XbFFCUkoyb3NvRkhESjY0dERzY3ZJMWFBRnMvNDFQ?=
 =?utf-8?B?SVNTbndISFN4dTZKUE9sU2pjMHJMQ2FndWlJZjFoTFNsdnJBcE85cHlhdXJq?=
 =?utf-8?B?Z1R0TU1KZ3NRbmpHRjlWNzNTMGVtUC96ZXFzRFg3dXFFQTFiMVo0aFYzRVBF?=
 =?utf-8?B?ayt3RWh3ckxZQmJIWEZsWGZva2twcEJ2dEdjdGNvQ0ZrWE1IbHpQa092N2pz?=
 =?utf-8?B?ZSsrc0V5aFNxMWFnNGdQQkNCQk1XYmxaQXp1dDYrUHdGODRka3IvbXk2Rk16?=
 =?utf-8?B?RmxkQ3g3ekE2emFma2g4QnI3by9aUWI0VXZpMWhjL1Y4RW9CRHIyWjNVcGk5?=
 =?utf-8?B?MUJOdHRwOTJmZ0J4NE0wRmxBLzY5N212cTdlZ01CSGJDdTZGYVYyUUtLYUls?=
 =?utf-8?B?alJIelcvMmJNazFTajNDcE9abWJ0QWNxVXVHeXgxRFVvN25JSEFvaGlqQ0Nt?=
 =?utf-8?B?dUhSemJNblFWWVlFalozQVRzbUMwVGlTZm9iVXhweU9LcXc1RzNGbW8xZEJp?=
 =?utf-8?B?KzFGS3JsVmxmVy92ZlB2cXZGWmxJd05BUDZ0eGJkSUN4UjRZTUViT09yNmM0?=
 =?utf-8?B?eks5SVV6aFp6ZFlybkpNZTcxUUJFYmFsNm1OQ2pVUzFHUFhDUFhhbFJrWDBT?=
 =?utf-8?B?bWlIWXFRV1VmSUZFUFFZcm5kM0Yva0VFZ2hSaXBRNkIzR0tzT3pVclF4czBv?=
 =?utf-8?B?bVlad0laSXFCU0Jxb1c5bzcyeHA2R0NVU25YbUtkdS9ldVhNSElUczBjYmlo?=
 =?utf-8?B?ekxxdUNSRURYajRWNFl4d0NOMFRjR3hEMkNGZk9Wb3BnejVvQ0pTTHZjRHRB?=
 =?utf-8?B?S25Ob0crbWg0QytjN0NkSG1oVVFmNGdhSHlyR3BFYnNPVmF4MTk2ZVdiN3Fq?=
 =?utf-8?B?SUZIelpWOGhCUDhrRmJtTndwa1kxNVNxdHV3Q1N3dW4vejIzUWVyWmtGNklN?=
 =?utf-8?B?K0hKNU94NHg4ZnA4NHkyQnZJYll2dUdNUWdQQnQwUm4wTExacm50TnpLNDNX?=
 =?utf-8?B?ZFloZmhNZmNJM21JVEM3WUFWUVFiSzFJZVNYK21qY3NZenRXTEl0cHZ2YTBz?=
 =?utf-8?B?ZFF6djZkUTN6clNzbzJCQWNlVzdXR2x3NzlHa21Ka1dYZnArL1ArWHA5OFFi?=
 =?utf-8?B?Yjgvby9kM3RNMDRCeE9BVzFLR2xJNlRlc0kyZ0ZsQTBGMExZWXhCVk00NU9U?=
 =?utf-8?B?YXBEVnJZVEh4a043YmlUYU0zM21OU2kzRXdoZk96Q1dsTDZrWU0reWVjbW1Z?=
 =?utf-8?Q?imxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700478c7-2765-471b-c8b2-08dc867db67f
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 23:09:27.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySZTfxAAv25F7VpU/IaLRIdk9Xu4hzB90sv2aEhwccixV+JiGZ2W183u6xvk4NXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7895

Hi Reinette,


On 6/6/2024 3:33 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 6/5/24 2:36 PM, Babu Moger wrote:
>> The selftest noncont_cat_run_test fails on AMD with the warnings. Reason
>> is, AMD supports non contiguous CBM masks but does not report it via 
>> CPUID.
>>
>> Update noncont_cat_run_test to check for the vendor when verifying CPUID.
>>
>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT 
>> test")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> This was part of the series
>> https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>> Sending this as a separate fix per review comments.
>> ---
>>   tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c 
>> b/tools/testing/selftests/resctrl/cat_test.c
>> index d4dffc934bc3..b2988888786e 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -308,7 +308,7 @@ static int noncont_cat_run_test(const struct 
>> resctrl_test *test,
>>       else
>>           return -EINVAL;
>> -    if (sparse_masks != ((ecx >> 3) & 1)) {
>> +    if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 
>> 1)) {
>>           ksft_print_msg("CPUID output doesn't match 'sparse_masks' 
>> file content!\n");
>>           return 1;
>>       }
> 
> Since AMD does not report this support via CPUID it does not seem
> appropriate to use CPUID at all on AMD when doing the hardware check.
> I think the above check makes it difficult to understand what is different
> on AMD.
> 
> What if instead there is a new function, for example,
> "static bool arch_supports_noncont_cat(const struct resctrl_test *test)"
> that returns true if the hardware supports non-contiguous CBM?

Sure.

> 
> The vendor check can be in there to make it obvious what is going on:
> 
>      /* AMD always supports non-contiguous CBM. */
>      if (get_vendor() == AMD)
>          return true;
> 
>      /* CPUID check for Intel here. */
> 
> The "sparse_masks" from kernel can then be checked against
> hardware support with an appropriate (no mention of CPUID)
> error message if this fails.
> 

Something like this?


diff --git a/tools/testing/selftests/resctrl/cat_test.c 
b/tools/testing/selftests/resctrl/cat_test.c
index d4dffc934bc3..b75d220f29f6 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -288,11 +288,30 @@ static int cat_run_test(const struct resctrl_test 
*test, const struct user_param
         return ret;
  }

+static bool arch_supports_noncont_cat(const struct resctrl_test *test)
+{
+       unsigned int eax, ebx, ecx, edx;
+
+       /* AMD always supports non-contiguous CBM. */
+       if (get_vendor() == ARCH_AMD) {
+               return true;
+       } else {
+               if (!strcmp(test->resource, "L3"))
+                       __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
+               else if (!strcmp(test->resource, "L2"))
+                       __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
+               else
+                       return false;
+
+               return ((ecx >> 3) & 1);
+       }
+}
+
  static int noncont_cat_run_test(const struct resctrl_test *test,
                                 const struct user_params *uparams)
  {
         unsigned long full_cache_mask, cont_mask, noncont_mask;
-       unsigned int eax, ebx, ecx, edx, sparse_masks;
+       unsigned int sparse_masks;
         int bit_center, ret;
         char schemata[64];

@@ -301,15 +320,8 @@ static int noncont_cat_run_test(const struct 
resctrl_test *test,
         if (ret)
                 return ret;

-       if (!strcmp(test->resource, "L3"))
-               __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
-       else if (!strcmp(test->resource, "L2"))
-               __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
-       else
-               return -EINVAL;
-
-       if (sparse_masks != ((ecx >> 3) & 1)) {
-               ksft_print_msg("CPUID output doesn't match 
'sparse_masks' file content!\n");
+       if (!(arch_supports_noncont_cat(test) && sparse_masks)) {
+               ksft_print_msg("Hardware does not support non-contiguous 
CBM!\n");
                 return 1;
         }


-- 
- Babu Moger

