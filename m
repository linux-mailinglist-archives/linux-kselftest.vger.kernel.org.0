Return-Path: <linux-kselftest+bounces-11705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89029045FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 22:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43224B244EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEF152789;
	Tue, 11 Jun 2024 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hfcYK48T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6F61514E2;
	Tue, 11 Jun 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718139306; cv=fail; b=hDcsHDKkSovIG3hnRqukhy64xu7/+FP0cyF+SliF92dRFe/5dacwcfEXSYob0qa/OjWhyLD/V+QqjxGv11vCnAIqNT1kFYp3DUWbGWDO1hxOAzGCexmN2BNUNBjOptAP+RZsMhz/+IRQG38vRnZFiL6N9q0LTUP9XobxbIbmD7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718139306; c=relaxed/simple;
	bh=lBcDB8pEG/CCLy+tAJJD6+dh1wrgKjMiaGNZIoMFsl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FfD3SiTO4faIWxEhs4yNIP3e8rnTjRBS9FGDsTwV9LDUyEZBWltMHCul1og+KVeI92ap2FpuAow8hG+6flgxOe1wzg0EjrAMtH96hcOet2YdMXYrMLkcZtuEEmOht1SO+Hp4fOvbkXZBT0qpKVojNRhoVdYDG6xyi5UvLXRuSj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hfcYK48T; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mlwea7e3cO0sWBCcDCD3+u7fTldjNMeNTUkr96oFIiONo+j0WKgp/rlKIqbFafm0w5LiXF7sFFIX2pjINsR71hTglTMWSKiHXGBdVwa6ME8XpbfWiX7eBEsvfUkDB7ap7hpZlrTeOS2nNeS6vdbGzqyh5gbcDsJn/zEtmwfzUnTB7x221M+x2cq1q5ejuYYO2bQCnBxzl4ktKv17payBoWmEAsRB2IU+QrPFwWeUwFjsVgqVt3iZ//grXJJWNmK5ITohfWYMICHRfZprvrPqV5OAleRwSxD141HY05L8zIwJlMipvglyCNgEcLaQlNgVAhG2dROmBjxewzBDOyx6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUyxsFbNMo6UmpP+hpDpf1R+2sNM7yNLcbqRr4A/AXg=;
 b=SMJSu60Da+UkyzNRLbM9C7zh/23qN9S+dSXFdgGa4yvCd7zSF+pgPyQt6/JObAg+0iDT9WfChQn0GKCdvTPGT+uSoGSJuD/hwMjH1Ox451IYFubYbmGf5yNUZmGzETnSKwFrLvWn1RWpj4SWhEYF54IOrCASkeSOf0eXqPd7zOnDLP1IV3K1Pkwkv9FencyC/TPSpu8eEUYZi7/oI1xclckjg0s1kIVMOaCFrLXx4RDjt02owswgk/pqL8KCE9pNG9ZckBWUyhcomVCAEWhISedsHUCEdmPtYIQxBEh11m4Xb0/Usk6uqe/yyOCiSe61GvTVKM+ddDo4W+1v8loADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUyxsFbNMo6UmpP+hpDpf1R+2sNM7yNLcbqRr4A/AXg=;
 b=hfcYK48TUs5VtSisjx+mRnwpxz6B9PEq+tyB4Aya98CEe3rLYTDxSHGSAkY6J+pzD+Yg7QBMJt+RKvKJM+L8PG5sJVaswt6SdnEvFwO3Q7YnkzLqEQf4KbeTg/bZXFMw2Fc9GzdR965hbyUkB/0TCiDtbahrEpbK8Vf52w9T0hn4RNzDnKZglwvFK+XDZbtwjHe36Q0136NOrP3Ch8/quhEj/ljhYNgU+MzlA1ennYR39JpAuVSiggud5H5kZkQP3QPRRXxxy1HWDVPowmZY1qhTOd3EUN8gkLbEQvNelD45K4mSpc0KC5cjSUZ3CBrhppb+2fBABKRHsP/buC89eg==
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 20:55:01 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::12) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 20:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 20:55:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 13:54:42 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Jun
 2024 13:54:41 -0700
Message-ID: <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
Date: Tue, 11 Jun 2024 13:54:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, Shuah Khan
	<shuah@kernel.org>
CC: Andrei Vagin <avagin@google.com>, Axel Rasmussen
	<axelrasmussen@google.com>, Christian Brauner <brauner@kernel.org>, Kees Cook
	<kees@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, "Liam R .
 Howlett" <Liam.Howlett@oracle.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, Rich Felker
	<dalias@libc.org>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
 <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <b5dd99c7-866b-467c-9f76-d043e887394c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 97363ccb-2568-45b7-539e-08dc8a58c2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TStKMGpkbVVOWWRYYXNDdzVvc05ZZGc1Y0NYNCsrNTZkeWtrMXJFZXIyeXZo?=
 =?utf-8?B?SzVZZ0pIcnNsZ0RyZm8wT0cwL0xXRCsvTXl4dHZ2UXNFWVZEK0hJTWp2bzNJ?=
 =?utf-8?B?ZERXT3NhT2s2TS9kYWlweU14Q2FaTEo1WkZicVlDUnpEdXNnajNMOU10bC9j?=
 =?utf-8?B?ZHpaY1lPNUVDOHlsNEJKWnQvTGgxTDBGbVZkcXhMZFZva212aWZob2N2VFEz?=
 =?utf-8?B?RFdnTjgzZDZzTEJTVEN1cUNnWXU0TzJvc3UxZi8xenMxVzlmOFJUQUdlenBv?=
 =?utf-8?B?MDJVc2ZVZjlQTVJDZEM2ZzZTSGNIbFpsWFJvSG82eEozVlhvSHZhTGxnMnk5?=
 =?utf-8?B?RTBLZXZuZnpjRzRCdVFrOTZJWHlyLzQ3ZVovZUYzaFpkMU9MWk1mMDlaSXlh?=
 =?utf-8?B?M1hRRGhSRXNLQ2R6TTJNU1Z6Y0NBUTV3ejViTjJNaUZhQmkrSG83WlBTVWox?=
 =?utf-8?B?ZkpCL2VraTgxU0pua25VS25IY2JENFhvaDRLZlZZMW0xLzcwQjQzalE0cnJ4?=
 =?utf-8?B?OTNqeEg4WWFjNXZyUkJCc0JYd204NVdNbWZqbmcwUFJzend6UzNsMjZ6Q1hI?=
 =?utf-8?B?eEpCUUovN0dFaXNKWFp0YWtlU2hxd29NVVNTNjBXb05iUEE0dGJPc3hIRXVY?=
 =?utf-8?B?OEVsMzVtblVRa2tDdmhVSEFRV2RKUncyZE1RSC94NGd1R0lFM1ZQa2tRNHAv?=
 =?utf-8?B?RGJOcTFqdWNKTzI2ZmtDKzZqajg0RkZzT05SbWZoWTVvcE9DWk5CZVh1c0d2?=
 =?utf-8?B?R2FuZ21MMS9uQW83Yk5GUHhrbFJnOXBxSXdrMHhkcUQ2WkNXNG5IdzFMaW1W?=
 =?utf-8?B?NW1ETEttcWwxMnBZWXZtSWx3TGE3Mm0zcHd4RiswblRiRlhBQSsyN3BWcXhQ?=
 =?utf-8?B?NG9NOGQxNDBrYUpTUkZUZWFFeDJnZXFUd2Roa1ZuNkNTR3JvekkvNHVMS0xz?=
 =?utf-8?B?ZmxDV2tHbWhmUk9JUFRERW94d0RNaHFDVGRqNE95Z1IyUTRtOGpKWGQxZnZu?=
 =?utf-8?B?WVZjbVhBa08waitxR2dteVdFemVrc1VldjRQMm5ZTnFxUXVOZStzcEVNRnkz?=
 =?utf-8?B?SFRMRC8raFpOUFQzaFpNeDMxTTRxdS84UzN1MUwxRGk2THZYWkgrUFEvYzI0?=
 =?utf-8?B?V0U3K0MxS0pHWnl5QUVNK1pZUjhDenRncHpvUWphcFpUUUVOTTBLMFMrdXA2?=
 =?utf-8?B?ZWU1czlJaVVnZmZVbVRGWVBRQW93SWp1WE4rMzNZNDZBSHZ0TnZCU05lZzRs?=
 =?utf-8?B?T2o2Ly9FQ0Mrc3FISGRLVFRUWTRCeGh6YmNuWStKRzZQTGs4VktFM3U1Z2d5?=
 =?utf-8?B?ZmpaSDl5RGt5cEZLOWVKRUxsTUxVazU4c0dJT0YxTGs2Q0JZaGlzZHRqY3VM?=
 =?utf-8?B?VXhFaG1LT0ZxdzFTUzN6L3d0OVJMaTR4M2JMTlFpam5ETXdlSkFtNlJEMStE?=
 =?utf-8?B?UWpWUElTMjlyR05WTG1FSTRrY0FZSnRaOTIvbEZ0L3Y4S1NjKzdnM1pEVm50?=
 =?utf-8?B?SnB6dWZZcFIvLzR1U2xKUWpRK2lWTldTdnJteUpKejE5SmlTaHJZdDh0c0F5?=
 =?utf-8?B?OHpsK202TEtEVEkzMUNVM0MrcWd3Z0U3a05LY2FsazVIeU9xL2d2YWhDTVV1?=
 =?utf-8?B?NFZ2U2Y3YXRzcm56SFBwbXZZS0lhOW9ObXRoSW1JYlAvaDVyR2VYeHlxUUtF?=
 =?utf-8?B?ZWdSRmdKUjZlWDdwcUI0NHhOWFNRY1hDUjV6cndtRmROc2UydUg4alJHdnYy?=
 =?utf-8?B?dGpUSTlYWkFJNitnZSszMlFVaFplV1VQSE5JZ0NIOTJpUGJ1UTNzd3Z5TTc4?=
 =?utf-8?B?a0tqdjFlS2FyTm9lMlZ1U0U5R2JLb0NHa2dpZWJqVUpCeWJQWjJILzNyVHpj?=
 =?utf-8?B?djI4b2ZyOW9uekxucTl6Y2diN3VabWQwcWtQQk12alFiK2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 20:55:00.4843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97363ccb-2568-45b7-539e-08dc8a58c2a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109

On 6/11/24 2:36 AM, David Hildenbrand wrote:
> On 08.06.24 04:10, John Hubbard wrote:
>> Eventually, once the build succeeds on a sufficiently old distro, the
>> idea is to delete $(KHDR_INCLUDES) from the selftests/mm build, and then
>> after that, from selftests/lib.mk and all of the other selftest builds.
>>
>> For now, this series merely achieves a clean build of selftests/mm on a
>> not-so-old distro: Ubuntu 23.04:
> 
> Wasn't the plan to rely on the tools/include headers, and pull in there whatever we need?

Yes, it is. You are correct.

> 
>>
>> 1. Add __NR_mseal.
>>
> 
> For example, making sure that tools/include/uapi/asm-generic/unistd.h is updated to contain __NR_mseal?

Well, here it gets less clear cut, because the selftests pull in *lots* of
system headers. In this case /usr/include/unistd.h gets pulled in. If we
force tools/include/uapi/asm-generic/unistd.h to be included, then we'll
get many many warnings of redefinitions of __NR_* items.

So what's really going on here is that we have this uneasy mix of system
headers from the test machine, and newer versions of some of those headers
in the kernel tree. And some of those are easier to combine with system
headers, than others. unistd.h is clearly not going quietly, which is
why, I believe, the "#ifndef __NR_* " approach has flowered in the
selftests.

> 
> ... to avoid hand-crafted defines we have to maintain for selftests.
> 
> But maybe I am remembering something outdated.
> 

You remembered correctly, but the situation is slighly muddier than
one would prefer. :)


thanks,
-- 
John Hubbard
NVIDIA


