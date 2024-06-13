Return-Path: <linux-kselftest+bounces-11902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A750C907E20
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CEA286EED
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30813BAD9;
	Thu, 13 Jun 2024 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZtYBjiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E072F50;
	Thu, 13 Jun 2024 21:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314072; cv=fail; b=X4c1hZ7Q3TdPdhp2d82M48B67ndz0BEtwsT0optz4PYcqEJf/889AtJGzJSJYadKEVyXTCfGKwMG4QIBdEk1vW4YPmG1CgPs9tYFyjN7r81P6JHGQwFPfpBYPPNdfLiypUg4Y4BFxVZQwd+qiay1Onsjo+b9u1Fo2wOrGCp1TUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314072; c=relaxed/simple;
	bh=X9ntUHDT6FhFfsHO3dp5GBcHryuJB6ipgdU7OyhQ0/0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=seUTbLaYICT8RXSviwvpXUFxz6WXjNrjEwic1u0/Ev4TKKjx8O2xbfKmL/82QUWQb4w4W3szGZQOXUE2y41IB4H+W03d/tQKrExVdR4BtNRKJv1JeEm6DOhWJE8lUnclTCU6yB63ZFsh24zRrUhk2iyVdNxpX9xmN+LAd1+m55A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZtYBjiv; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyArAknt/HGxWpjlI3G7HUAJWntj1HFIlnkassHcsliKpp0OU2buY7wTpiG8eeOKflURpgnTPYAgme2mAEiT0B/cWiqOSbF4+eeEvqRgSnHCDZrQkWJ0CFwsBJUDEcQwWbKGCzZ+CdE2K4Qqf0zNvXAFwrU5+VW2hqgYT39ZxJy/Me/hm9rCF2ViEdI3UqsKoz/LfAkGJ58jcxzkbrhoHO+/+3FVqXbTR4MGlm7/sqJknyGYC8qEuDdayhCIalhb64A6cBuPyIV44WlkASaE0ssqQZ9zUu+p7l2B/EKKv65HJUCn5r+t6Zp4QAnAsti2jr0BCUzRyFDE47PFGk3snA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCD2K9stkfF+DF07OeBSfogi05llm/h2UUmjAdU3Hww=;
 b=SzzlnIWkvpGp8yECZe2t7A0GO0uuv/qz/1Eg9mwSqZ81e07CUV9VuozQxVpKeWILwWRCggout9TbvW/wPfpQBX0VN23FFXgRkEmc57LSXcA/UxtCZz3WtJI+/PI701kUoW4bxhZXMdwyaaGTDXsz7zpevq5QlsrDrhgMxvNLU81yGhcwBeQbcCUhAm/Xz0ZK93cndPWinTXFIoJD5BEpJx+AoINWTEr2IHehmgqKPtjN3hOKvi+m3d9PfcSGy0syN7SzFX0rh1rtpnpba7zPU1sJePX08hkfoMuwHPuXBD7u9iRrpncgZWgUFeTK9JDDUS4wrKAfgHC4yeNNRJHXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCD2K9stkfF+DF07OeBSfogi05llm/h2UUmjAdU3Hww=;
 b=oZtYBjiv5VCSDJ+ZeZovd+EmpSFF3QHew1ZQEAw4ETfXB5s7u+gijYgMlj2ZEREDTXIhTL1255GnsnO8Ks8XP3/480ug+jd3GsfnPed4XiUx8ZRcRVw0hp20qx6n1eIMZdT+oSzN2uJNEqB1TaduBEX2t4QPfBlZcWt7VrY0YmTdvYetxHLV8HI3xAK49miNnKWY0Ra/1O7xMLncfwJQVQARZGqRfxeXvi0fqoMAC2SX7y19O/RnLXQicXomK6CzofdXpKp5CrW2BUZ4352b9n5iPeqXGJcEmcBy8XY4qp2PDHKllh+OdG1nUxF13/K7rk09VT6t7LCSB35fNVINEQ==
Received: from PH8PR05CA0020.namprd05.prod.outlook.com (2603:10b6:510:2cc::27)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 21:27:47 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::f6) by PH8PR05CA0020.outlook.office365.com
 (2603:10b6:510:2cc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.14 via Frontend
 Transport; Thu, 13 Jun 2024 21:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:27:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:27:32 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:27:31 -0700
Message-ID: <2c6f86b4-8151-4bb8-8400-3ea546ca10ac@nvidia.com>
Date: Thu, 13 Jun 2024 14:27:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cleanups, fixes, and progress towards avoiding "make
 headers"
From: John Hubbard <jhubbard@nvidia.com>
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
 <c1277bf6-a211-49eb-80af-726f16ca1802@nvidia.com>
 <17b503f8-5d0c-48a3-9eeb-85b01583f9bb@redhat.com>
 <b60c8c02-5497-4c6c-ae60-86309e55f1bd@nvidia.com>
Content-Language: en-US
In-Reply-To: <b60c8c02-5497-4c6c-ae60-86309e55f1bd@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 93452456-e830-405f-57a4-08dc8befabb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|7416009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2JHYVZSa1FTQXZZL0tiQzZGWmdnU1JUVTUyVlJLK1Exc3IzRHloQ3Rhbk5p?=
 =?utf-8?B?WWticStQTW0vQ1FoN09nMWZwbDI3SmtBOTZ4U1VUY08yTVdMOXlNRzZCTUVT?=
 =?utf-8?B?ZzgwM2hwYmNSTWdIK3NLZDZGS3h3WVlSM2tOVTB3Qk1uaWpjaG5JOEtxSmF4?=
 =?utf-8?B?VlNCOW83Z3NRaW9aTlVYTmNpQzUxSlBuTUlrUWorYjM1bXN1ZzZnTTdxQi9N?=
 =?utf-8?B?aFFNWTc4ak5vVk5CRUJUZUx2SnBqN2RWd0RBbVFnRkQvMW9wWXlKTDFQOVlv?=
 =?utf-8?B?YWJnZy9NN3U0TEJ2RDJXWlE0NG5HZS9ILzczQXhvcnB2akl2TElMOWNjTndX?=
 =?utf-8?B?bE1hblFIZkIxNGhHUXVZTTdCZXFpbjVVaklUVU9MOGtObFFGQkJrS202U0ww?=
 =?utf-8?B?UVc4NmlOdmJzMFYvRnN2WGlFRFRxMUdkKzg4TG1nVDNXclFpb0JVNFY2K3BK?=
 =?utf-8?B?Vnpwc1ZEbjZwbDE2OWtrY0drdTFCUjE1d1dyMktOdjhBc1BiR3FWUWJFanB3?=
 =?utf-8?B?MkFpWmxGYTE4RDc1b3R4c2Y0d3NlWWU4ZUp5VFBOUHVYRmNoZFBWUUgrUmlS?=
 =?utf-8?B?ekdSUXFRaituTlUxRXI3c0RxNmpCbVY2aDVwRlVLK3BnY3lIUERNUzNtTkFD?=
 =?utf-8?B?NkhWbGZwVXNkZlBkaFhnUzE4S3Z6Y2szOS9rTGppM0NmZzZvbStJS2tycDRH?=
 =?utf-8?B?WVYrSjVyKzFRMXFnbnlDTWlJQVo1WVZ0eXVQTkVMK3NtQ0thWTVoUUk2TjIx?=
 =?utf-8?B?Z3ovcit0eXVaVTRzZ2UyUVV0ei90WXZaRkxwb2pJcUZBb2NJd0Vqbzc0dzl1?=
 =?utf-8?B?Q2dPakJKK0FqMXFJSWpWSm1zVXhiSWN0dVRFQW1pSjc2ZXRuUHFMNi9Sa0Uv?=
 =?utf-8?B?RFpPR2ZNSTZLMkJCUlNQYUF3TzIzTE94Wk5CeUZwU25HaUp6QWU4NW0yTitT?=
 =?utf-8?B?QUJ0YlFXNlI3TFJmWEx3OHBmSlpsQXNUNzhhbENaRWZLVnRLQi84Zi9acUdZ?=
 =?utf-8?B?VlNTb1F4WUU5TVVQVzdtYzUxdVZRcHZzT1ZBL2IycHlqbXJxQUV6bGVxM1JR?=
 =?utf-8?B?YVJPQnphbkZCN0Vnd2FhUTBkenVCNXRoZVZRL2tUcFVpSmxGMCtNTXJrT3ZC?=
 =?utf-8?B?clphbDZjTCszQ3hFVnNmNkMrY0U4Z1UrU21tV0JJUFc5RitHMi9ZMkhPK1RK?=
 =?utf-8?B?VFlNUVVaZjZSNGhMVWY4SXpyVnpWeDArbkQybnNjcnVCTEdXY1ZoeksyN0U0?=
 =?utf-8?B?bEVkaHJ2UkVJYXE2SWhRWHBWanFtRmdraVd1T24xa09zWUZjQlNZS1JyNXF6?=
 =?utf-8?B?c3lzaEdJOXp1NnhtZUt4YStvRGJKVWRSMjRHaTJvUVdtMStqdmhpQ1FjenRL?=
 =?utf-8?B?UUcwZDR3eW5yaGNreEhtRFlkM0Vqc1psdXIrbTVmc255MnNyTDdOcUZDa0RK?=
 =?utf-8?B?RzB3a0dsdlZ4Q1cybnRwQVI0MWVqNmxvRTcxMDhyVU4wRDA2ZGVyampnZ3Vo?=
 =?utf-8?B?a05uU2o2b1FaN2RMaEZCQUp5RWhZMmdxQjVoYktJZUxCZ0JKZXkvVXJ3RENa?=
 =?utf-8?B?QmJ6ZHd1SkZPTHlIVXI5ZEhDV2o0T0hSL0lrUFZtWjcySCt0Q0VVaFdzQkxF?=
 =?utf-8?B?Y2E2SGI1OG5uT0paUElFK2twQllQN04wODJjTUMxd0NQZFgwZk43MTJsZ3VH?=
 =?utf-8?B?M2M5czlXeHZ0QVN6UUJqS0FRaVZydkNISThodjJDbTBnclI0WW1Cc3FhaDZK?=
 =?utf-8?B?SmdGbjI5YjF3TmdEeDZxcm5ueW5KMGY5RWZoMVFja09Mb0F1c041c1gvdWt2?=
 =?utf-8?B?Y1BmUnpZYzFncnFiTkdyMW1MaDExemw0Vk9MSkdqQldFZVM5UFNwNlF4SG9H?=
 =?utf-8?B?YmE1SUI1SkkrRFg4TnVsVWk5aklLY2dnNjF5U2plbVVZTUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(7416009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:27:47.2866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93452456-e830-405f-57a4-08dc8befabb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

On 6/12/24 7:11 PM, John Hubbard wrote:
> On 6/12/24 1:24 AM, David Hildenbrand wrote:
>> On 11.06.24 22:54, John Hubbard wrote:
>>> On 6/11/24 2:36 AM, David Hildenbrand wrote:
>>>> On 08.06.24 04:10, John Hubbard wrote:
...
>>> You remembered correctly, but the situation is slighly muddier than
>>> one would prefer. :)
>>
>>
>> Absolutely, and I appreciate that you are trying to improve the situation.
>>
> 
> I think the attempts to further tease apart the include headers could
> go into a separate, subsequent series, yes? And let this one go in
> unmolested for now?
  

On second thought, it is actually much easier than I thought, let me
post a v2 with the unistd.h header fixes, after all.

thanks,
-- 
John Hubbard
NVIDIA


