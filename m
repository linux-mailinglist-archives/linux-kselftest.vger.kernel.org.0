Return-Path: <linux-kselftest+bounces-11130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068218D8AC5
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9568C2855BC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F2A13B28D;
	Mon,  3 Jun 2024 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lYf2bfWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E7131182;
	Mon,  3 Jun 2024 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717445538; cv=fail; b=oKqRiM/vui4euqaA+7u/iQb741kesl34u7mkpwfGnJdJ6DZW9EN5G7OKp7GSN1fvoftbUVW0HGjRJ24CRpeNsQw4Coj7eS9ynH9H0/nKj4Qnk0QBb8SGH23IkO9gKN3g3pQMU9Eo7itRQDO/R9TL+TX2PbYGM8SNrAGlR85q6uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717445538; c=relaxed/simple;
	bh=h9u41ekSBKwelnPSWJXz+DjA9y5hoiGve0rt9fhsFKQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=gRuYmM20DE6lH5lVELFub7bI4UuTYLduvtTyuhFi2sFcOu6lk75hEM+uCHV+VqOYGCtN15xP8hA/2tBEakVowbXp+AL1M/q9E6Z+Ma8nqeBalmtvdSnvIr9GldNozoVkJtXHwQwghoAZjEsW+vQkUyFklvcUFBSFA8OxfdW171w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lYf2bfWf; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+pnJUGnHiqxfuHkjttsCmPU7+k7EqH7Y4qY9AaHRY2d1nW4vaT6jI269kr0i9N9WD/l0y5+ztJ3GQv+TflP2mzlnHXQp27CFgz7CkP+mzjj5XKxdpFEUY9HR58lA5+mznhpxXIBUns6TmemyrxkXGp3sO2Bz9Ko8eb8sBruSWaTouYiodmJs9Anui9/2sKCJO5TMeCYMOETpt5gUP4RD3bo5sCDizwtSuFBTw53Fk/g399zQucBKqnnzdlnDnp8O5NxIe/8sNbaIR300LCclcDku9uVmA2cdTHcQHwGWyR/EjYTiBNajrR1OipVEodfkq7n+fsHlhCzSSqo+JGtVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdYayFlTQxq04QDWUElZrQgpVN83oeiGXaSXz/7mswE=;
 b=LZX9how7TSDUcQn2hY9XkvZyQ2D9reuM1rGVO/qnMIteqoZe0RYVlhBVZt6sT8lCk0Snv986g+acv++cJn+NGvgqUYTOoquwOjGN/NKG0FrWrcBnocRTmWzYB31Yy6qncrxDCXH55g7mLqjGs0d8VsGxN2BnHPmQvyzKvuJW20Q99GsXHYCAzGodAzzlWHzXJGTvRGPXNHOWojlwyEF8aAZGpUnY438WMvQyNDhqJsK5oTLJDkEoPqkbhzXsugbw3m7jx0qVMvluQMoS5OC2OQfMkQMhrrbbMxJ4yX3jDFg8RVZRTJSrXO9wgRpZThAfq+jtCnzjgqlsf4HiFClEvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdYayFlTQxq04QDWUElZrQgpVN83oeiGXaSXz/7mswE=;
 b=lYf2bfWfld4zvEkdnaiiJxCdlirr5EVgCMIg1PU76G2gzW143QUDFgGfTNNpi+UQa5ykcThIrALghnB4WhLQo6ycA2Wt3v7L6wViUqvn7Amv+geMBBj16oPb1KmRcTHP/U9fFDmydURu70O4uqQc+5bsFbZwkh6y1mzyeO9zo03T3UudrSZwr2U5jM8ZBGsT+YV5OPLvsPAdSCj13+8Umrh+OH7pEZnh4IQGnSfd9eSd3ykBwhmmR7ZjsOwLXpfuDe6EmX3ROPwbID81lOZbS8Ryrh3vt1M1fyuFb1KZ0ornnWTSA0g4ACacbNBeio7YpdgtF9suwANmfbINFVH1LA==
Received: from BL0PR02CA0130.namprd02.prod.outlook.com (2603:10b6:208:35::35)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 20:12:13 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::c2) by BL0PR02CA0130.outlook.office365.com
 (2603:10b6:208:35::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27 via Frontend
 Transport; Mon, 3 Jun 2024 20:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 20:12:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 13:11:48 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 13:11:48 -0700
Message-ID: <d3b4bc6a-36ba-4716-b94e-c0e9217f6ff0@nvidia.com>
Date: Mon, 3 Jun 2024 13:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
From: John Hubbard <jhubbard@nvidia.com>
To: Mark Brown <broonie@kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>, "Nathan
 Chancellor" <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
 <20240531183751.100541-2-jhubbard@nvidia.com>
 <306eebf8-bb5d-4e1a-9fa3-ad3f4ea11b9c@sirena.org.uk>
 <96216e54-ba8f-4fd7-b95a-13477c143575@nvidia.com>
Content-Language: en-US
In-Reply-To: <96216e54-ba8f-4fd7-b95a-13477c143575@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d63e2a-a61c-47a1-6a3a-08dc840973b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|36860700004|82310400017|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWxaSlRqU0pKay9oOVhzTC9QNmVkSm8rdnBTQjM1azdtV29pK0kxUThERjRS?=
 =?utf-8?B?c1hYbHUza1VKcEE4SVJZMkxQWU85RnRCbTVGTHFIMDVWRXErYWk4UHRTdmVj?=
 =?utf-8?B?Y1B4WkZ5d25FY0xwNG4wN2s2Y29ka3pXSWRsU1poaHBiNHVIbWdBaWZOdXJZ?=
 =?utf-8?B?bXRtQlhKb3J3VTdUdG9zdEFsYmQ4ZnloYSt2eGZ2aHFXbnBpekZSZFJCbTV4?=
 =?utf-8?B?WHlId0cwMDk5QVJ3dk1qMCs1dEltQndWdWFwcm1pbkEvNSt5V3NuTVQ4ZXNK?=
 =?utf-8?B?bVRNS05jK3kzOWVBbGtxbFRWcWdOZWxhSjZvOFlRVmFyMTJtYWo5aFh3NzRU?=
 =?utf-8?B?cWkwM1QvdDVuLzJzSzhndTJpbk5pcy8rbWQ4eEx5VWhCamZYR21Db3ZVSm50?=
 =?utf-8?B?M3hXaTg1bjBndjExdFBWSDNUVm44VnZ5NWZUNUN6RnJGZzl1L2hVelYveG5E?=
 =?utf-8?B?WlhabXRRclJnemhtMGdHcmdyNjBCOEdSTFBxWDc0RkZ1aHdMZEx1ZTQ3MkE1?=
 =?utf-8?B?bUlxT3QvaXg1LzByK1Rldm5lWjdKOUI2NW80STZWc044SFVlZUtReDdjOHpp?=
 =?utf-8?B?MTJjQ1hnTVFzVThtN05RWk5ZN2pDeTczUEZvMmJuOVFMaXZ0L1F3dVJoL1Fx?=
 =?utf-8?B?VUJVakcxd3hFWlA5NTdrYTlwK0orNVdHT203a09iaTgvN1ZhM1l2dVQ0WXZ1?=
 =?utf-8?B?ejlST1VBRXFhRFpSejl2d3NsWER0dmw3alYzbEpmUEFOQ1dMSEN1ZlluZnN0?=
 =?utf-8?B?ZTM3MTlPYjV2WFpmdXNUMUtuZ3FTeTg4azRXSWk4ZEV1bGdmSGNSRVg4L3Yv?=
 =?utf-8?B?Q0dock9iMjUrY2poaWN2OGFaRXk4MEdHSjdnTHE2bUxveWcwd1NEWXJaVm1v?=
 =?utf-8?B?RE1pNGtld1RkSTlNZkNtNFF6cWMrR0M5VFcyTkg5cTFYUHZRUnZIbWxNams4?=
 =?utf-8?B?ekM5MWs4OFZVSThPWmVDeGZ2aDFUNVZoNjBadVBuQ2tQZGMxWXNtTCtuS3JT?=
 =?utf-8?B?bXYrWGJyc2Q0UncvSTF3YTZac0hBaFpmalM0UXNhNkY3NmRzZERLTS96Tkx1?=
 =?utf-8?B?Mkh2cDZVMEl3b1FUZXhjRGx1VS9wQXI2bzg5OU5OVUZyNWtuenE2anRpeDZB?=
 =?utf-8?B?QWk3eTBEODhzR052RDlWcFNNclZRM3NmUFNGQUcwTzNUdTl6bE43eUFzdkQ1?=
 =?utf-8?B?cjVMcTlhMmRlS1NUTmlLRzkxTWl6L1E0UHV5MTFSNWdFWlpra2t3RnFnN1A3?=
 =?utf-8?B?TVl3dVRjM1YzOWt3NmJ3cnlLclRKNk5tZW40bXppWkJpSSs1c3VnMW8ya3dp?=
 =?utf-8?B?cTdVdmlzLzhrRDBCQmt0SUxXb0xJTldDUlpNTnRxc0lWQVZHVTNycXF2ejdN?=
 =?utf-8?B?QUYzVHdydyt5eG02dW4rTG02a2pDaXpIZWcxdW9OSFV3aXVBdHl3aDBFbTl0?=
 =?utf-8?B?Z2doWDdMbGFqUFJGNTZDa0hwMzBka1IzODB5SnJDTU8vQWFNcFUxajM0OC9a?=
 =?utf-8?B?SkFwbDM3ak83bzkxbHRZdnhEWFExbHZPbGI2OXJ6cjdadm85S0o5QW9qT2p6?=
 =?utf-8?B?R0lYaEZQMkVzMVFvR3Y4M0kzNjBQS1FnU3lUSVJpS0I1bithNEhMODJjMUl6?=
 =?utf-8?B?VnlXdUFtM2JyMmJjWjFMZDJxdW9EMng2RThSWkVHRHg3MTJNSFIxSjI3dk4v?=
 =?utf-8?B?eDdFYXZpSjUzYjJEMEhyVVNEUzVwRnZpNElEWkFWTndXNWxVMm5QY1VURlhG?=
 =?utf-8?B?c0prUGh0VHRFbUdrdnVzaCt0bnRSRkxmUDR5cGJGd295TWtpU001dWlUYlIr?=
 =?utf-8?Q?z7UWkjRXF5WiHLAHhzoeaQDT8wDTooI4pnF18=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400017)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 20:12:10.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d63e2a-a61c-47a1-6a3a-08dc840973b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

On 6/3/24 10:09 AM, John Hubbard wrote:
> On 6/3/24 8:32 AM, Mark Brown wrote:
>> On Fri, May 31, 2024 at 11:37:50AM -0700, John Hubbard wrote:
>>> The kselftests may be built in a couple different ways:
>>>      make LLVM=1
>>>      make CC=clang
>>>
>>> In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
>>> of lib.mk, and any Makefiles that include lib.mk, can base decisions
>>> solely on whether or not LLVM is set.
>>
>> ICBW but I believe there are still some architectures with clang but not
>> lld support where there's a use case for using CC=clang.
> 
> I'm inclined to wait for those to make themselves known... :)
> 

...but thinking about this some more, maybe this patch is actually
a Bad Idea. Because it is encouraging weirdness and divergence from
how kbuild does it. And kbuild is very clear [1]:


Building with LLVM

Invoke make via:

make LLVM=1

to compile for the host target. For cross compiling:

make LLVM=1 ARCH=arm64

The LLVM= argument

LLVM has substitutes for GNU binutils utilities. They can be enabled individually. The full list of supported make variables:

make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
   OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
   HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld

LLVM=1 expands to the above.

[1] https://docs.kernel.org/kbuild/llvm.html

thanks,
-- 
John Hubbard
NVIDIA


