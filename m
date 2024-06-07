Return-Path: <linux-kselftest+bounces-11449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D176D900D7E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 23:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E991D1C208C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5015531E;
	Fri,  7 Jun 2024 21:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cytbmDA8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6513DDCA;
	Fri,  7 Jun 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717795523; cv=fail; b=dosHaiFIt+1oLqEY+GavU5vZoGI9rl0Yayi148qQchiX9CZM5R5TWF/i6TxMy+29Pbn1PXfJcE77iMiTFCjw73nIaMP1YhY8v4w2Ds9popc8+Zn7iVTWzPXqPm3zoCg3zzkSwNui4p6+HMmJHuSt0FmsE9W0MvSKGE3jCjyNBdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717795523; c=relaxed/simple;
	bh=cxQMw9rCaQTTdGxElZVgWi1nEZM2sn/lm9YQgvJkJF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GRI94bBL2hBYavE//1/W6QyR5VM2U0rQxUhRnEZBY+n3aWgQmVWmD7GpMlqEZTAJQSo1qV8vupTBcVH0CCUnMhUusq91DRIyWoRYewqxfF0GcnLCBqA5hyvU8iaXZX8bi4Nn9UjP+t75pyhsutFKFm44wCA3rgqr80sychmexxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cytbmDA8; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIvIUlQnFaHGztlry0XVhp3j5rAvCkHhV9an/GOZrTuFD6V7Zk1PCLdQgUcfyqCOiZ/WlmQDglVxO1P25VQZ++VWE372WNFBG0RyOSHDq/y6+2RAEYF/AHGG1Kae8s3E5wZf7683OuXes5UuwsEOFLaamMpQnzksFWQe4tll+LtSHQB0bY92SFHmHVKhtu3anGLgXGoTBDe6tuYShE044RGUeYrQHRE5aeqDJRBipjTpXrVH2y0fSJ5Ttk3W2oRXBNldjrZQd6hSQ84tsIA7ZJDxN6j71dkxCGfxxA+NhDTWwcAy9gKp8ALHXoRq+GU65YsaAWFiK07wRC687PtUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOOqzXsgBC6Nl7ohiKHizTTedoIoKYz/3/x3DnZwzwg=;
 b=eRmXGAwEUriBB3X+aDLZfT/RkoD557FodEatxicqGO/OXK50421TnxpGfsBA4zxqa7m68ZH1+d85hruOOBNwLYjr8DFMXLArOYohO6nN0sUxMCr/vZ35LuvWM1uJ6gxLOwgeQ+NjvamhmYCweh/qaDmV3olDfCr3DXq16ktEpsODTn7xWTkmMU6SitTL+mqbxNFqmX40Ctf9XbLgCYnsDn0GUxdN936s+klivoo1QCDRD1+hlDChAg3DzLBJnoy4/GOGQ1nUUtGKYFOsLPmuX83VG/2vD+ZOW6bX8lh3gySIWYUCCmG7TthUHf/NKqtFfG4IULGHCrHA/SkZLZYxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOOqzXsgBC6Nl7ohiKHizTTedoIoKYz/3/x3DnZwzwg=;
 b=cytbmDA8Gm1JJjytTbjXSpd8Hp5pKrdkiBHK03pnTxSqC2H2ihWOZ8gt58eZsiC+bSZH8ofmzP9tSgNV4II266xNcIHqH/y/Ucr7vhj8AYbMicrpyekCDIwXE+krMLU1tKavX7p2YwR9I5yfyXx4O2n6wsODkgpwoGUDtLMhJV4fpl2TR9WZu7QD016bwKm884QbcXIETNjyH8fnl16WZGQ0eOpq20ljzSdFSeKZQ61VMrN7LjjySUgBRIhGyzf2ZPQfpj+hh680p3ut5moWD4DmnO0Ca9+DZZnpo5oxP+nLe/dNjU3XuudhCBqfcmPhxjMfNw/5LGbqWci4iItrYw==
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 21:25:18 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::86) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 21:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:25:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:25:07 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Jun 2024
 14:25:06 -0700
Message-ID: <6914d826-d1fc-4645-b39b-5bba4fb13901@nvidia.com>
Date: Fri, 7 Jun 2024 14:25:04 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] selftests: x86: build suite with clang
To: Dave Hansen <dave.hansen@intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Shuah Khan <shuah@kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>, "Rick
 Edgecombe" <rick.p.edgecombe@intel.com>, "Mike Rapoport (IBM)"
	<rppt@kernel.org>, Ingo Molnar <mingo@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Binbin
 Wu" <binbin.wu@linux.intel.com>, "Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
CC: <kernel@collabora.com>
References: <20240501122918.3831734-1-usama.anjum@collabora.com>
 <ae9de160-c8dc-4e5e-9ec9-4846a5dc643e@collabora.com>
 <5b8e50e1-8705-4ec5-94ae-2eae010cdf20@linuxfoundation.org>
 <01105cdd-38f7-4f33-a358-11a33df2a66a@intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <01105cdd-38f7-4f33-a358-11a33df2a66a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: fa051648-3d82-4681-eac3-08dc87385490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|7416005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVBaWEFGa3ViTmx4SU44OVZibnFHZThxS29JYmE3Q3N4SkREMU92M1R1ZEV2?=
 =?utf-8?B?aFgzbTV5dWxVRjRPTG1qZE5UdGl1Ni9UWnhPVzNsclhBTFUzRmRSdFJwdGFZ?=
 =?utf-8?B?ZWhDRU9nVzFGS3RyRXM0Z0tibGI0Wnh5OGdZVHBpT1p4NU1FYlVMM2lidmVi?=
 =?utf-8?B?YWNTQWd4ajc0TkhhVUc4bzFZR1d1cVBka1FhUFRSaDNOTUFYSVlKL3RDS3RN?=
 =?utf-8?B?SUZjRzhKUWZaaWo3VzRZVlhuMEdqT2xxOUdmdnExTzZrRTRWbjNhS2ozMTBo?=
 =?utf-8?B?bERtckJmSWJmT1NaYktrTGNZWno4R1VSYlF2NUlja0hsZ1RuWDhEcjA2VnNK?=
 =?utf-8?B?eExvdnE3a3o1ZDVQSVFYTDAxMmpIOE1kSUFXTy92YUNhSWFGVFljZkxQYk9H?=
 =?utf-8?B?TkEvbnZkQU5NNTEranhiWVFYNUY5SUVISFJsYlpLYmVUbVoxZjJvZ3daeWpY?=
 =?utf-8?B?WUEybUloM1ltbFpoOUZUczdIMWpSREh6SEpOMktOK0NvUW9vNmVmb0I0S3p0?=
 =?utf-8?B?M2xzaG9jeTMwSGczbklVdngvUWR2R090VC9CQ2hKVFEzQUp3bUNVZmFRL1pO?=
 =?utf-8?B?YWF6TFRvdHRpSHNMWWp3Um9iaTNaWHpUWE5rZ01Lak1ybWNLQzR6TmlsNkRQ?=
 =?utf-8?B?WkFIZmhQbk9VUmwzUlQvYzMvK0ErUUpvdXBjaHpOK1oyd3oxNGdsaHpUOW83?=
 =?utf-8?B?ZS9JK2o1OHd0SHVTNldNWXQ3bEFvOG1KRmFiVUppK0JzWCtJUThzODJoaC9t?=
 =?utf-8?B?RFlWY0pSV29qeTFLcHpyaW1BTUxJMXV5N3lSNnZCd0kyTUtDWGF1QWhsN096?=
 =?utf-8?B?L0pFS1J6OUlOekFud3c2dlVpbTQyZjNHakhVT1EzaytSRVkycFpHZFBOVFFS?=
 =?utf-8?B?NnhIQ1hlZEdZZFBxL3BwZy9QYzFKV1hUT2hVS1BhR2sxWGRiYUJpV05sQlUv?=
 =?utf-8?B?blp6NFZhZ0s3R2kyRStnTUpRQTBzTUs4bTFNTnI5UDNtc0xrOGZWaGhIQkVM?=
 =?utf-8?B?YmR0aUx5SjFnYXJjYlFyaDBGRmhESy9xcCsyN2JUUlBRZmdER2MwWnN2ckFZ?=
 =?utf-8?B?TlJ2elhQWUw2OEFYKy9UUU1mNUhGQm9jSHZMMndSa2IrWXdoem00ZnR0S1RQ?=
 =?utf-8?B?UVdKV3RicW1IL2FUdVgxNWZFZllOTUlzelRVdHoyRUFpa2t6aDFsUmNSTDdi?=
 =?utf-8?B?MGE5ZERZSWhYQUlXaTZPck94aWpzaFdlaHlwSGFveXZQMW8xNGdEdk9CSW9R?=
 =?utf-8?B?REdwNWF0RHc4aEFsRFc2YXNGTDM0bHZCV09NYm9ZcWJlRCsrc01qditpZnE2?=
 =?utf-8?B?SS9ET2xDVDcxTzBCQWRXK1NYbHBJa2loa2pqYWlPSWVXTjQ2MzhZdk9KT3Vq?=
 =?utf-8?B?ZGdNU3ZBbENWdWZoT01mYWJQNzZMMkpPUHQ3Y1RNbkV6bGJTSitSUC9LcTRF?=
 =?utf-8?B?K3pOYm9aU3ZiR1lmVy9IeWdUUzkwOWdQYS9FaUpUY3UvY295T29QV3BzK0Yx?=
 =?utf-8?B?a0Vsekl4eGY5MjdPeDZuWFJQZXhtNnJqQmdBb1JJM3lNdlhKNzBFUnZFelpW?=
 =?utf-8?B?U0piVlF5eFI2VmRreExmU213a1k5WXdKZ1ZHT1RWUHpkNU4zWXh1V2txeHVQ?=
 =?utf-8?B?ZU9nWTFHb2ZFS1REYi8wRWVDem8yVUdBbGtMMXl4OVM0bndISmpWTlpxYXRN?=
 =?utf-8?B?NUgvcmlCT3AxOExqVE44ajRDY2w4ak9jMXdwNUxHZXV6cFV1azR4WnFLbkVL?=
 =?utf-8?B?UzJydzgzMnFRYjhEOURiTUhMc2ptUVg4aStVMlFPVXczUEJoY2IvTGZ5Qkkx?=
 =?utf-8?B?NVo0MUJ6MzAxSkovQXd6ZUNQVTJVTGVTbVpjQnZqSFNIeWJ6L2tSU3pIYXJn?=
 =?utf-8?B?YWdsOG9Wa1ROUmNLTnVpSzNSdWJMVFJBa0loZmk4U2lIRmYwOHZXU1p5YVJR?=
 =?utf-8?Q?e+AkroEmdQkEFg1Dbhmm/TyZSoKcQHap?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(7416005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:25:18.4750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa051648-3d82-4681-eac3-08dc87385490
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198

On 6/7/24 2:17 PM, Dave Hansen wrote:
> On 6/7/24 13:50, Shuah Khan wrote:
>> These patches usually go through x86 repo.
>>
>> I need ack from x86 maintainers to take these. I don't see x86 list
>> cc'ed.
>>
>> Please make sure to include everybody on these threads to get quicker
>> response.
> 
> John Hubbard (cc'd) had a partially overlapping set with these.  He and
> Muhammad were going to work together to get a set they could both get
> behind.  I _think_ John picked up one of Muhammad's, but we haven't
> heard back from Muhammad last I checked.
  
Yes I did that.  My latest series has 1 fix from Muhammad and 6 more
from me. Muhammad hasn't formally ack'd nor responded to the latest
series [1] yet, although he was OK doing it this way [2].

[1] https://lore.kernel.org/20240531193838.108454-1-jhubbard@nvidia.com

[2] https://lore.kernel.org/046d2d1d-3583-426b-b745-59f3696fb418@collabora.com


thanks,
-- 
John Hubbard
NVIDIA


