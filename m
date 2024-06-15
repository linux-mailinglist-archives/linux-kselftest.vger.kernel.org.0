Return-Path: <linux-kselftest+bounces-11990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B29094F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 02:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748941F2280E
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 00:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C611621;
	Sat, 15 Jun 2024 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XoxBPTm7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED3173;
	Sat, 15 Jun 2024 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718410190; cv=fail; b=js56yWzUxXVQNkO3+Y4w7U4gTmayzLPFj3zHVNKCIRJHE1nkYOOBSNh17JFw9v41Yi+75AQLNxgXDq2RUBjnALzi7Y9bzSHXDMiMnQiuSQSzplMMX0HOL20IaFkzYGQrUun6Eupp6IdsCL0nX5QwSvIIaSotRqTYwvHDKjrida0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718410190; c=relaxed/simple;
	bh=1T8g8FWxH6cP6ZaCZLKFtRbC5cc61aK5eWks9bSi49k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sX1cs5XGeaBpV0782cKLmh9OZFngq0w3VpaQ7U+N5/pP1RZWfrWOvaNnf8uQ7KDewuywO4KYkyIvOD7QS5WR28RQ0idmZygyj5bEtU0RlMoQEJPGs7d7q8Orm20kTcRzJY5rIjX20r6MCFJx84IMxTKtyy3dw9yZhLdht4EHrPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XoxBPTm7; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GuxgQ8c6xnHqjAyOzneQf4EAepGAojLo201DAXaTkCJ4Z9TY8tlHyupaifiyyCGSfXMHRggZCwr3nnnILP5cVUgYjkdyjrNG/JQ3iP/DMQDBK4P/s9b+bBVopqxZYEfA5r3pF55WxVfTKLr+3bE+/uBJWrLr5IISENxq0Ifxm8rkKPj9WoLY1UOUNmRUtVIMWHP632RA6wjtdj13oLvk15xuTbr29bF46n9VRPql2EIjFVcr+d75GU1dnv43pHiSP/4HXlRxHhaaN0Km4RnIoErZsaAbZsVImKRaq6kg5sFm1nAj50dJI7LowDtj+h41Tq+g3RUDWX2rnJRT+VHnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tXPJM36LoSbmYU3iIxDDZE51zOTVTPmOvnoKNGIQj0=;
 b=OWaZV2YPprclVI7YVxuVM6vC4Wl0ROCEOBeJKYyLgkKbMTgGc/B3q6ZQ7vbIqXoinG3/7aPu9MyEl7s6z+6g/gRuYZfMAPnE8xV0IDq7+C4zPgpaytA+zFphzIBW6EyOHla7PLlWbusnmlpFm0eFVnKAze1EDwT2ctnkVg1LbO8VcifCAah6tGuhVjVJHwrfQSnRaB509fFxp5c3h1RkC2OCz1+dSFB1St5BuhBzBSQJ5pSFxyiqHVEKkBmCcyTHSfG2t15rfFkoqDi7eP4bPe9IUV4evsL03kz21L3bsTTsUrvuUYwbMLwB5V6zkV90HyoXtgvvO1CJwqDq9ofKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tXPJM36LoSbmYU3iIxDDZE51zOTVTPmOvnoKNGIQj0=;
 b=XoxBPTm7XuiGlFna1R+r+7/1XDLOyxkJm5iyHOR8XoO3P39vkq8imXbEFaW5AYPzEZk50vOn4lBkM3+3dmlpjjjApNsXJvi/DrbuiHGZT/bb9beS2uQqIIaGubU688cyDyyQvWQ4f7fOwe8D/fxxbtsScj2EgxUTys5EGWDHhMBna17x4S6cYl6Zu8zfJ5nKt19FIjlWsHyPT6qB56zGzWL6StLE0PNCe5GQIjhDiHW9RyscHmgFLC7AB34rKPIvTwLK2sZXmBB93dGaW83oJygjCkaIYzUj90BnTpaTkIbuMLtgr2yTr9avkYZOFb+ycCMOehMRWxp9yVC8BUlw8A==
Received: from PH8PR22CA0015.namprd22.prod.outlook.com (2603:10b6:510:2d1::23)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27; Sat, 15 Jun
 2024 00:09:42 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:510:2d1:cafe::2d) by PH8PR22CA0015.outlook.office365.com
 (2603:10b6:510:2d1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 00:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 00:09:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 17:09:28 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 17:09:27 -0700
Message-ID: <0e239ad4-3608-4ac1-be65-5b61329eba77@nvidia.com>
Date: Fri, 14 Jun 2024 17:09:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] selftests/mm: kvm, mdwe fixes to avoid requiring
 "make headers"
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
References: <20240614023009.221547-1-jhubbard@nvidia.com>
 <20240614023009.221547-6-jhubbard@nvidia.com>
 <56effc69-b7c6-4e89-8cd3-e344f673d750@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <56effc69-b7c6-4e89-8cd3-e344f673d750@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 14568448-e4ed-43f9-6a19-08dc8ccf7466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEpkbXdKV0NRRGN0V0IxK0M1UUtCWmlzRVFWejFwT29VWWdxb25xSWxuUDdq?=
 =?utf-8?B?Z3M2S3pzaGUwdGFCVjRjNzVsR1NKNFJGa3o3aHlIRi8rMFBiZ3oydHRXOHk2?=
 =?utf-8?B?emRuUkIwbzRIa1U4NXM1NnlzZVhVbFZ2OXlQQkdSOXhvVDZKNlJXbllhYzkx?=
 =?utf-8?B?YmZRNlFBSGZjUU44NFlZeE0wSDBNTU1tL0JRczg5QmpVRFRWaGxybjN0dTZF?=
 =?utf-8?B?cVVIcVh6TlVZOWkzNUJyQlZoTnI5YkJSaVJIN29sckUxbTAxWG1pN0I1RlFo?=
 =?utf-8?B?aElSNEk4YkZZYmpvckhSM2QxdnZXV1lwQy9YbENWRWYrbTJrVjByTEx1ZGtS?=
 =?utf-8?B?azFmRzJVVWk3Z1lrWGR2RHhZN1pWcU9kRDYxUUlUUXRnRUVsSUsxbllhM0Uz?=
 =?utf-8?B?bGdhSkd4VTdRbjNra1RwNGM1V3BkWTRTVjBlQnp6Qlk5Q3d0YjhxY0tZOG9a?=
 =?utf-8?B?cStHcXZWSDFmbUZBTmlVdER2N1p3NXRHNU9pVlNiai9YK3lZTUdlVHdrb3hn?=
 =?utf-8?B?d1UwMUt2UG96Z3hYenpQNkk2RHlzTDNlTVZpMGxMcjNpYjFUV1NJeUJjc29F?=
 =?utf-8?B?b3ZiWEl2RzBQSFV4WER0MCtIcC9icWc0MWpRWUpuTEtFTlptbnRSaGV2YlZk?=
 =?utf-8?B?WnA3UzRxM25zTDMwdVBuN3dqZlVLaHM0S1M0UktBWXY1bElLTVZaK1pQZGNP?=
 =?utf-8?B?b1Fyb0FqUUNGdFlxQlkweTVwOWQvaVA2S3FCN05TY09UbXJRTTlPZGs4WC9P?=
 =?utf-8?B?bS9TU2FiSk14UHpSZ094U3MvVFpMdUUzc2dOSmM0UVFrbUVhSlNFekF4Y0NC?=
 =?utf-8?B?MVloZFdkT1hrZ2pBMXAyZG1YdHZYTnBEa25XeEhqSXNxanFPVkVpL0dWTU5Q?=
 =?utf-8?B?cXhWemRmTlAyMDNJb1RVeTZheEZqOXlGZTVqdlBxSk9oYUVOT211dm1xTTlP?=
 =?utf-8?B?c3JnbTlYS0VyWWRlUkFsY0ZpNWwrWlllVXFkaDNXcU1UZEtqNW5tWENvRGxN?=
 =?utf-8?B?SmlMM0R6TVBuN0VTWkVUcVR1ZDJ6Z3lYVHJDNWxmMzFMdStpcXdMZTJraWtW?=
 =?utf-8?B?SGJQRjFzNEdIUXRYMU1ETHU1eDd5bWFuaHhRZnZHYWZ4V2NkOCtoSTVKemg4?=
 =?utf-8?B?bTZBbkJmOVl0Z2IxWWFuaU9GNGlHL0lIa1BZb2tqVnd0ZDZuODZXVERNc3lZ?=
 =?utf-8?B?QWp1d21lNmh4L3pYTkJYbnQ0MGRjM3lqVVQ2VStab01XWU1lc0RSY215MTNh?=
 =?utf-8?B?L1E0QTQwWGxVUWg4eG5ZemcyMkVYYXRUYktCMnlpNmUyMXluU0xpbEFTQXEw?=
 =?utf-8?B?OUdFc09NQmt3a1p0VnNKaGdNQlJBL0pWS2NtQ3ArL1lqNloxbHV6QzhjNnZD?=
 =?utf-8?B?bXQvbG1OQ1R6RHZyOHcxVWkvb0NMTmRQMk1MbGQ5LzNLanpmVDdUVFNOcnVQ?=
 =?utf-8?B?L2xidVpWOEZ2N0g4cis5NTc2RERoSHg2enJtR2NlUStNNjh5SDJhVWJSSS9I?=
 =?utf-8?B?YTJtY2tFbmtEU0pHZmNjV3lSUFl2ZHBNMWdpT2UrMlVGS3hwY2grcVM5ak5v?=
 =?utf-8?B?OFVtZ2Q1WGZxQ0NiTlJEMmN2Vk5rVUdoUFRmMjBhR0lLOVZmWHVxVlZ2cVRo?=
 =?utf-8?B?NDdIQ3FuZEk2ampXSHhoY1ZLMCtjTHowYWloVStId2U4U3pwZFh6SGdIVEZQ?=
 =?utf-8?B?QlFNNjUzNW9sYWYzS1ZtVGpkbnIzNkVsQ2VtY1owMFhqSFZhbWEwb0ZmdUpL?=
 =?utf-8?B?cWZGMmpJYTFtTE9zWThJRVhlMCtPM3VZL1V0SDFvNWl6YVlGUHhmZ29hN1Rx?=
 =?utf-8?B?ajhSVjBDdnIva1hQZVRxUGNZY3JkV1FwWkFhbVNIZk5RVzBhY0ZFZmpZYjB2?=
 =?utf-8?B?ZWx0d1pNMEVtVUFtNFZmT1dNR2tBNEZnNkZkb1MzN0NDOXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 00:09:41.7193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14568448-e4ed-43f9-6a19-08dc8ccf7466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

On 6/14/24 5:31 AM, David Hildenbrand wrote:
> On 14.06.24 04:30, John Hubbard wrote:
...
>> +#ifndef PR_SET_MEMORY_MERGE
>> +#define PR_SET_MEMORY_MERGE        67
>> +#endif
>> +
>> +#ifndef PR_GET_MEMORY_MERGE
>> +#define PR_GET_MEMORY_MERGE        68
>> +#endif
>> +
>> +#ifndef PR_SET_MDWE
>> +#define PR_SET_MDWE            65
>> +#define PR_MDWE_REFUSE_EXEC_GAIN    (1UL << 0)
>> +#define PR_MDWE_NO_INHERIT        (1UL << 1)
>> +#define PR_GET_MDWE            66
>> +#endif
> 
> What's the reason we don't target "linux/prctl.h" here? :)

Very good point. This is the Old Way of fixing these up, and I overlooked
that even though I'm busy adding the New Way. :)

I'll change this to use a new tools/include/uapi/linux/prctl.h and post
a v3, thanks for pointing this out.
  

thanks,
-- 
John Hubbard
NVIDIA


