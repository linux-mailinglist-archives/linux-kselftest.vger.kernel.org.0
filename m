Return-Path: <linux-kselftest+bounces-20104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B242F9A33D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 06:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153EBB21EA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5FD160884;
	Fri, 18 Oct 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlhY2q+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD8416DC01;
	Fri, 18 Oct 2024 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225813; cv=fail; b=MZUtWvi/95FVvimjLk8VD48iATfsyRUdMjY7xqCA/ei0Rq9EuSUD1DcoVtjlJlRZIVNFnm/RSNkmsaKDLPInAuYBNy6/6HpEzLsZAFJ6gqTcpeqRqn0M/mCi5MKqBct4NwPlg+ck0OZ8Lj/Ri/VjsooqvpjE3LXd7bEI2xOS6dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225813; c=relaxed/simple;
	bh=MSTb+Qk1KvXs2qMOmXTsaPxn9vAQVJh/DxtRzPcXliY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EIOHfkIq9E6mcJR9B2IGZXePTWAYwkRE8b4anBRUlSNYg8n3bhferc6jyUOLskkE2NQznoBzcYJWr0j7HRFVx0NnZvntDOnxSqIq9nyS/7odDG02NCKJfwlfIMuW3Z7PmA+/wJVgnj5IejvmFgndZo48nKWlKn1b+87ht0WrUZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlhY2q+8; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CELdJXlvjOEdYnd/Qrw19BxZ5M1J18JLjagkCl3r6ftlT6HO1jRP+A0kDnfVo5qfnu0cAlZav5mL8loc7NgSIhSoIAIsod5nYgZ1lAFySZVK1UgGvqsd3s6K1S6jhBS29SPhz5ptu7i3aI5HZc56KuaJSDa4VNeplGQN8wZvqG5W7fdiEaZVw3eUAxV5McSuAuY2YUTXPXjpTcaW29kCk3vGzIysWwIIReLs2seWGIJVwrR1YDaY059Eaw5dBbfIxUSYjNSUqEWOnSSBdh/7EH3IVqrTyz9FmEzEootz7WlIln1It4+bGJMVzXoTdr9HfVEZf49OB/JfqOWJaQUfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRJc3eWfoOUrVNYRDPqV8MTkZLhKcmuI41+pP9aZyLE=;
 b=yl6JC30gU626wAL9C5kxC5bGseTnrfhc76VyWuWi5OlH5kmi3juY5Ifc2Dmfwpc6e3ekfIxxrgfFhp0hEmv/VkBdBFbG/BbsgV/fcBcV1UVLYgSQxqZ+D+ywrRlAyddoVnq9uilJpzmZVp02RkH3UlAjrcu2ngSeNu+/f5Mob1pEI7u4RHgp3EI4e1RMSXdc3hsNYPfNGh25AAUVuTwt0oAH2yOYHlBz/GOIo2VfqG1/w1SuIRwIVKkp6TJySuQZuqZbvi7FqLyJmMrItxDyMxEGkBhveT4vrdKpnDHjnxSq9+THbL1bvLlBWRWODN5BJleXV4aa/6BJKtWqNqjZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRJc3eWfoOUrVNYRDPqV8MTkZLhKcmuI41+pP9aZyLE=;
 b=NlhY2q+8GpGpYEGPpxT1p7h5DNynGs5uegniWxAmPO9VRSXG4MD8XCmIh9YyrxZraLEtbEGCFxyhlLlm1x9rjEcEvH3ocX3I3ijw5bHmLKvxbNuM6FzYqzNCEsKc8Q9xDiOGBx77QlqXeBh3s2vjLG+sIDz7ounMYHISkKOdVMQ1gctkXJx7E1Pn14ZjaA5fDdpOgwaOJZc5t9aq5t7RLGytZFVFmZ0y/HFTobOF3zWm2VBgumG3Cy9u8iJ2zylho/ZSfeW2yzxCRbuGduXiETq8QhfI34Uo46CT5UxdmVfSMa9gtktN/l2Rc+40k6yXQ+1zsroqlHu9Yr4mG9qWkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 04:30:08 +0000
Received: from IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12]) by IA1PR12MB6580.namprd12.prod.outlook.com
 ([fe80::789d:39c0:6386:9f12%5]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:30:08 +0000
Message-ID: <533eb948-a061-4d62-8d89-5edbdaf785e6@nvidia.com>
Date: Fri, 18 Oct 2024 12:29:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: drivers: Add support to check duplicate hwirq
To: shuah@kernel.org, tglx@linutronix.de, helgaas@kernel.org,
 mochs@nvidia.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
References: <20240904014426.3404397-1-jjang@nvidia.com>
Content-Language: en-US
From: Joseph Jang <jjang@nvidia.com>
In-Reply-To: <20240904014426.3404397-1-jjang@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To IA1PR12MB6580.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6580:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: f051f900-91e3-45f7-6590-08dcef2d8be8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVdub09ZcFJsWjk2Y2NrYnhESmwrVDRBaTlqcThzYlBSU2ZPZlR5ZHp2OUNj?=
 =?utf-8?B?bVlUOTVtamQzbFJEOFNCTVZoMjVJS1pZZ0ZHZHhoaHI3NkE2WG1TOWhlN05l?=
 =?utf-8?B?UW8zcjJvWkxnV0tiUXg3UTVuZkJpOHByVHpUQ2Uzd1czdGFMYVFxVndKb2Q4?=
 =?utf-8?B?dm9UUXZ2Nmg5SC90VU8zVWdCRkNGMVc3V2Y4enFqZlZWb0s3ancyZVZCUldM?=
 =?utf-8?B?KzVtY1lRSGJGY2pNdTNIRTBhTEptcnpIempxdElCUEE2cDBQeUlGa3FTellm?=
 =?utf-8?B?ZWxUQW16YjV0TDZ5cXduV3ZkbEhZUythakN4eFNoUEQ2VUhVVVZxVFErR1dm?=
 =?utf-8?B?eEpOTGI4UU9tVjB6ZDJ4TGhZQ1Zra25DaVZXZlVsYmdjZ0d3TnRFaUVpb0Zk?=
 =?utf-8?B?R1pGU0c2K0pSbkJjb2t0cmV3MEdjZ3ZqcGp2RVpnTzdPaVdRVzJXZ2xMdkJ1?=
 =?utf-8?B?RlZBR0VnVFJmV1htVVBrWFBpWlVMQkp6RVVyYVNVMnY5cFptM3Q3RXRyblFm?=
 =?utf-8?B?alFLWnVmV2VmMDZqNTErakdFZlJPZHVENVFFbXd2NnR1NUVlMXBnQ2VlZU5y?=
 =?utf-8?B?dHFrYW9oR2F4M3d0QXZNZytRMjJmRkN4ZDdLd3VRKy9WZmwrRXo2ZGlPVFBJ?=
 =?utf-8?B?Qm94bVN5SFN0T2xWYStlcGg2bjR5QXBNaDZ6bEhGMEdWWFRycWN5eGxUam1J?=
 =?utf-8?B?R1JYZ1lkNVZuTDQ4ZktIaEdRd3NIamdJcklrMEs3L0FtVUI2YzdQY3dIVngv?=
 =?utf-8?B?WS9CRWRUdEN5bitpRlRsWmMxVWhTWDBKWkp6VVZTZWdrSDlHdktNQXNNUno2?=
 =?utf-8?B?M0FSSkdIV0VhVktpZDduRWFEOTFCZEtNcWduQW80RGQwNFEzdnBQRlhWYU5s?=
 =?utf-8?B?cG5TSmU1MFN6VEs2UzR0VUVVSVpNMDFpVEFNRkNTUWFCaUZnNzJQNW9uRTdv?=
 =?utf-8?B?K2ZaNjErUVR6Wk9lZXF6Sk1jRFJhamRINlpuL3R5MlpoSllpS2UxN0NXQ1d6?=
 =?utf-8?B?M0xTb0hOZjBDdWI4d293aGIwTVlpUGQ3eS9xc0xBRnVuNEJvUFVPN2o4STZM?=
 =?utf-8?B?a3IxeHMrYTkzWWdpMUI3N0FrdmU1UXdqd0hWTk9zVWlja2g4dXpGcERiUFpr?=
 =?utf-8?B?OXF6SVVxQVUwMHcrZUpKVXhob3VYNEJzdExiL2lGTlZIcjc3SWVBNXZWNG9w?=
 =?utf-8?B?Yk1TVjZqbGhnOExFVGJyN3dGQ2JvQVdaRGRicHNJR1lMR3IzeTNQTkMydjg2?=
 =?utf-8?B?MURjVUNsTS9NNVV6d2ZpUVFwWmxpMTBsQlkrZXJwU0tNdkR0Mys4Lzk1eGtu?=
 =?utf-8?B?N0FsQWQ0ZEwvRHk3RmhieHZyVFB5bXRXcHJ1bGNlMVhHbWVwKytKUUZrbmw3?=
 =?utf-8?B?YWYzc3hsdC9mdytNdThJRFVVMVlaN2s1bWh6SEkzbXM4ZUYzNW5ibU1MR0lB?=
 =?utf-8?B?Zis0OW9qd0tPSmF5NGZSS29seE42WHZBcGp5R0lWZVJqYUVTa0hINTl5d3Jx?=
 =?utf-8?B?WWxHdGwzVXQxZTdpdmN6M2dqK2tyS20rYjFHbjluNW84QWIvQ3NiTGl6WlFa?=
 =?utf-8?B?c2luOW02czNhd01VaDE4bmVpYThZUm9yTHNkcFA0ak1OS2RQanR2UjdkTjhu?=
 =?utf-8?B?RmR5bkJCRk1pVXhvYmlXczg3L0JQRDNjNkJzVTJweDRVNU1aL2Vjd2c0Z1p1?=
 =?utf-8?B?aDVLU3ZlZW52WFpzSVJ0NEltVDZGNDc3UmpUcWgxcmhwMk5VUlRqNmU1bkgx?=
 =?utf-8?Q?PEEEXama53E14A/SInZobXa39KV/ZW9lHMCFgtd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFlkbGxPOHdEL3Q2YkJKWDdnQm9IakdyQmRsNVVpaVcyNk5mbEVJc216bEZU?=
 =?utf-8?B?WDlBRHl4Y09sbUlWSnZxVjBua000V0JGbmYrQ3JiVTllRWtnelR5SFVzVTlB?=
 =?utf-8?B?S3BtZkY3azdXbzRtU2VZdnhlTXhtWGRYdDRGbEpyclZrQlRxL21IeTNUUHJq?=
 =?utf-8?B?TVlUQTRDanVubjMrQjluWFNSMHd6Q0lSNHFKMFB6amdaQ1Zsc2g3VERzaTBG?=
 =?utf-8?B?SFg2Wi8zOE5UanJJMHVTSTdlbTArQTFRTGJNSzZjb0g5bnE3YnQxZkR0NjFF?=
 =?utf-8?B?MC93d01YU1c0L3BoR0dSc09tbTlXRkNDbUpzVXVhSmdiNHpwM2VwemZhVTVD?=
 =?utf-8?B?UEJMZTBjN0wyMDRSQVE5UkF2RmVxejBtKzZCdWR5TjJJQms1dnFGRTRTcVVK?=
 =?utf-8?B?TzRBU1dnY2txVm96eGpUZjJ6QWh1TG1RcGtKbkZDYlA0V3haSXFqekE5bDhQ?=
 =?utf-8?B?WER4L1JEck52S3I4ZzJ6V1hJc2Y2d3FoQzVFZXBYWG56SEhhckZVNTU0b29U?=
 =?utf-8?B?Z0tQcm1nYlJISjdDVDJpbThUcFdLbm1LelBBS3FwZmNtOTJxK2EyYzlPSXdV?=
 =?utf-8?B?K0MvUXAvaDcxb3pIMlpTdVltNGZDUGVVK2o2QXVYZjJHYU9ZNEZWaEhkbVFx?=
 =?utf-8?B?TzFydkZJOTVwOGxxZS90WjlaKzJ0ekdnejA3aFdPTEx4c01MSVJuK0phYUtU?=
 =?utf-8?B?dHlBeU1BbmtqblhrRHBLUU1ISUcxeVpOdENmMnhrZU50VDRJL2l2YzdPSkMx?=
 =?utf-8?B?RVVyRUxkMjhaVHpNU2dEWlBmSGJaOVVBc3lwamNNQ0dac3NLdnJRYzhTWFg1?=
 =?utf-8?B?aDNzV0p3VXNXMjR5Z1RUaWFZUWo5U2RDUEtiU3pWZ1k1V2VIZEMyL1dzRWgv?=
 =?utf-8?B?bWljUVhZTzJEK3VWaEh5NS9KazJ6dzdSZkpRTEF4Z1FwTzNqVzBlQ1piSlhS?=
 =?utf-8?B?cUJocFZMT0Y4Y2t2T0Y3WWIwcTZGVHhYZ3ZOVlV3alNaYjVXalNpaWVGUGlt?=
 =?utf-8?B?aytpSVkzNHNITldkdFdGcEJoTlNIa2JWcW91di9Scy9jNDhlZnBDMWR4cCt2?=
 =?utf-8?B?aTJqdnY0ZW53dEk5ZUwyejIxZW1lb1hEOG0rWHQ3ZmNqOWJPaUprSlZTVUg0?=
 =?utf-8?B?T1pqSnJ1VTZIRGNCSktaaXA5NVJNYzFEMkRvMlNrVk9UWnV0OEl4MGhsaHpy?=
 =?utf-8?B?cVVHNk9sbUxwVzUwSVNjdm9SWTcyRFZvWHM3U3lSSTVTVThWV1ZrcnYvYmZl?=
 =?utf-8?B?TWllTnRpT29NbU12TllCc1NVK3RBS01YTERLa3ExWE1vbzN0NEYvS29TNFc1?=
 =?utf-8?B?SmxNcDJGSWc3a3pNWFQ3d2p4bUJHc1BaQy9wbjBMSGpiK1MwWGd4YWRVb3J2?=
 =?utf-8?B?ZWRKeFhiRG1nOWh1T3dsOGZLUU83Z09yV3VUbUNYS0h3R214ZkRDbkhoaDA5?=
 =?utf-8?B?QjNZalJvVlVaaDE3Rnd2UnRHb0kxbitOek5QU0x6VXA5Nm5vS1g0MHNveDJ1?=
 =?utf-8?B?WEVSRWdDSVp3SWhtZlNlVk5wd3hRR3dHSXJjcmpjcURnajBMRXhINGFWSitB?=
 =?utf-8?B?blJ4dW8vTVRZVldHNnorYmdxM1JZNWZ5M3lyK1djYnBaR2VpQWRHM2UrQXZ1?=
 =?utf-8?B?UTBVVzVJdVJ1anNHc2NYaks2a0IxNVU3NjNlOG00UHNpckQ0MlFWT3g5VWVK?=
 =?utf-8?B?UzNDSEhwSHlEcldXL0lIZGZCdVNYRkRqZ2gvWUpOUDhBeURDZnMyVHZpcWlP?=
 =?utf-8?B?NzY1UHg1RkN3UmIwNW42ZFFuVktSMFRlbVlROFc2NG1XcGw0bnF5bWN6T25D?=
 =?utf-8?B?cFczdGhvWTJXNGlNVG15dXZ2aDB2cTJMYTVVYUh0ei9HUjhwa2p1UDl0cGd1?=
 =?utf-8?B?MWNxRFRDdkt3L2tEbEJ4QVUrSnNzNUlrbVozcjMwaTM0cTVSNFE5a3hzbVF5?=
 =?utf-8?B?UTJrcWV6bmR1WXdHazhaWHZFT1A2VTlNdzZJTFlhcDhudlZHUW1ENEJBRGdV?=
 =?utf-8?B?bS9oSXVjQldiclAyN1B1Mld2YlR1M2pOOXJiUndYd0tkR3JsTHZJSG16Zmwr?=
 =?utf-8?B?cjhvaDFjUVB5VUJUbXg4UmM3b20zQ3hzQWRMSFFwRU5IV3ZoWjUvNnRPY0Qr?=
 =?utf-8?Q?fCPHV/bGJPsg9scmwssOyKlPg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f051f900-91e3-45f7-6590-08dcef2d8be8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:30:08.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMzEPT1OYUZWLJRX5PBUtn+eqKDhhpMDqPZNcnyPSw9zh9X+6GGVPH0g93CbHpdfVBAw08c93YDrqasdjLRnkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128



On 2024/9/4 9:44 AM, Joseph Jang wrote:
> Validate there are no duplicate hwirq from the irq debug
> file system /sys/kernel/debug/irq/irqs/* per chip name.
> 
> One example log show 2 duplicated hwirq in the irq debug
> file system.
> 
> $ sudo cat /sys/kernel/debug/irq/irqs/163
> handler:  handle_fasteoi_irq
> device:   0019:00:00.0
>       <SNIP>
> node:     1
> affinity: 72-143
> effectiv: 76
> domain:  irqchip@0x0000100022040000-3
>   hwirq:   0xc8000000
>   chip:    ITS-MSI
>    flags:   0x20
> 
> $ sudo cat /sys/kernel/debug/irq/irqs/174
> handler:  handle_fasteoi_irq
> device:   0039:00:00.0
>      <SNIP>
> node:     3
> affinity: 216-287
> effectiv: 221
> domain:  irqchip@0x0000300022040000-3
>   hwirq:   0xc8000000
>   chip:    ITS-MSI
>    flags:   0x20
> 
> The irq-check.sh can help to collect hwirq and chip name from
> /sys/kernel/debug/irq/irqs/* and print error log when find duplicate
> hwirq per chip name.
> 
> Kernel patch ("PCI/MSI: Fix MSI hwirq truncation") [1] fix above issue.
> [1]: https://lore.kernel.org/all/20240115135649.708536-1-vidyas@nvidia.com/
> 
> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
> ---
>   tools/testing/selftests/drivers/irq/Makefile  |  5 +++
>   tools/testing/selftests/drivers/irq/config    |  2 +
>   .../selftests/drivers/irq/irq-check.sh        | 39 +++++++++++++++++++
>   3 files changed, 46 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/irq/Makefile
>   create mode 100644 tools/testing/selftests/drivers/irq/config
>   create mode 100755 tools/testing/selftests/drivers/irq/irq-check.sh
> 
> diff --git a/tools/testing/selftests/drivers/irq/Makefile b/tools/testing/selftests/drivers/irq/Makefile
> new file mode 100644
> index 000000000000..d6998017c861
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS := irq-check.sh
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/irq/config b/tools/testing/selftests/drivers/irq/config
> new file mode 100644
> index 000000000000..a53d3b713728
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/config
> @@ -0,0 +1,2 @@
> +CONFIG_GENERIC_IRQ_DEBUGFS=y
> +CONFIG_GENERIC_IRQ_INJECTION=y
> diff --git a/tools/testing/selftests/drivers/irq/irq-check.sh b/tools/testing/selftests/drivers/irq/irq-check.sh
> new file mode 100755
> index 000000000000..e784777043a1
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/irq/irq-check.sh
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This script need root permission
> +uid=$(id -u)
> +if [ $uid -ne 0 ]; then
> +	echo "SKIP: Must be run as root"
> +	exit 4
> +fi
> +
> +# Ensure debugfs is mounted
> +mount -t debugfs nodev /sys/kernel/debug 2>/dev/null
> +if [ ! -d "/sys/kernel/debug/irq/irqs" ]; then
> +	echo "SKIP: irq debugfs not found"
> +	exit 4
> +fi
> +
> +# Traverse the irq debug file system directory to collect chip_name and hwirq
> +hwirq_list=$(for irq_file in /sys/kernel/debug/irq/irqs/*; do
> +	# Read chip name and hwirq from the irq_file
> +	chip_name=$(cat "$irq_file" | grep -m 1 'chip:' | awk '{print $2}')
> +	hwirq=$(cat "$irq_file" | grep -m 1 'hwirq:' | awk '{print $2}' )
> +
> +	if [ -z "$chip_name" ] || [ -z "$hwirq" ]; then
> +		continue
> +	fi
> +
> +	echo "$chip_name $hwirq"
> +done)
> +
> +dup_hwirq_list=$(echo "$hwirq_list" | sort | uniq -cd)
> +
> +if [ -n "$dup_hwirq_list" ]; then
> +	echo "ERROR: Found duplicate hwirq"
> +	echo "$dup_hwirq_list"
> +	exit 1
> +fi
> +
> +exit 0

Hi Tglx,

I follow your suggestions 
https://www.mail-archive.com/linux-kselftest@vger.kernel.org/msg16952.html 
to enable IRQ DEBUG_FS and create a new script to scan duplicated hwirq. 
If you have available time, would you please help to take a look at new 
patch again ?


https://lore.kernel.org/all/20240904014426.3404397-1-jjang@nvidia.com/T/


Hi Shuah,

If you have time, could you help to take a look at the new patch ?


Thank you,
Joseph.

