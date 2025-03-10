Return-Path: <linux-kselftest+bounces-28655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C836A59B3A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E070D7A1F71
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F63230996;
	Mon, 10 Mar 2025 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="odOlQdBv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C7216392;
	Mon, 10 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624804; cv=fail; b=pQzbcJkR3U0RGRuvSFSITqf1G5s5Hg2H4vAabLDkN2XZQ3LsO/JKKfAF6tuPZ09erwgSKcoLLPrmJDNetgdv+Za2JDmw3M8yfQ8TbtBNKgaDRDURy+CCCeV52/mCrzaNQiDMHqzL8FnWFI4aK5RHwsTTHgADVntpHgzH7qSimgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624804; c=relaxed/simple;
	bh=bsejz0FMreXoN7+dF8xS1NVuADwRM7zg64AXPTg0w2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiRd5OZNQfJeEypnHCwJjeHw4kn9T0KavRBQ0w14vEf8UUmgF6gUwi1iwU/aPO5XoUNnPdbXQbkmDNo5PhcwNJf3KlK+BFyBUAUzZnQzSBdzvkJpk69qA01NRYNb5q8hjBgcbiEMjyBSfOfXu0zo5Lqu/ItU7nrGFPpGngYBS4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=odOlQdBv; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hwl4oZTG+4rliYJ7jqeV9GuyTp0kCx5okYL3FS/Q4+z4hn+f2wNi+2LO5uOCzxI/8BQjTq+t3xfIpwgepIRbiuNiKLYtpsU8zqzMV3hHpDMPe1qNFOiX5pEOCqXdIPiRxhHXwFifjXenPID8OBEiiD9x2NRDbkBfIhap6f6EQPatlj0/9Ln13/WNqMWtIlVuoL4BqJHwJkaU7NxmvHwYQNOqzwPSPIgKOa7GYrkCkVs2ZdCcQ7x+SoOB6HQwX3my1Wg82iMTTVKGfMFxZs0rtRzocrJfzYEfLxWJZLKXd2cLa8KQXO68kjMzHzN+lM/2VAIQdqJRbNhafgG0+kSOOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lkjAfIeA4pUEuG3GFURA5w4BSMDM4LF5uoM1UVHwPX0=;
 b=OecFmB0Vm4YEh+VcPY00LrP6kyIDnxseyupB9mglHklxly9uZCoY17zKq+LD5KbSmJ5X5aaA+2f04Q49qBPv5YDbulE0trnZdJDVMQuzBiu0T3DJ2WYAEZWVLGLaKHKLXv69mcLOIw0ua8/sSyOhKMkpZKP6EJTpTRc8J1ATjY7iL6SLdeRk4hNY/0if3E2DYhlOAA5UlhVcQnmrmsCcvm1zCe7i29GK1LGVHL9wmlPJsglEVUMd7wb0pAl+GA/fbGObli2wCnTuyFG6G5SqFuXqEI311xDaUyOHCRZp9wYJXC+gS4A1YU16u4rZj6y5wbcupvmQtP6KdFVpsMz9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lkjAfIeA4pUEuG3GFURA5w4BSMDM4LF5uoM1UVHwPX0=;
 b=odOlQdBveaXozHv4cP6gvjN14E/qLhHd2hfj1/ZbcEtS5ch61GrTgMq/m4wkVVvvpZ1/nyXHT1HnZ/ctztZpfWcpxWgMCwK294O9gkSFuY0rDH5ByFXw/DrtY6QlOCs4p62ae9KYSRPhhukFooh5kibqRxbJ/ELACN+dtbue81ou/RLr4kLAhyCg6v9HqO0FX7KlSveJlhav2y320nmUnbswhTfC1QIt7TC8qBD6vYdEx4Xym1SGVi+EQ3aRy4ANUQBxc3z55hE60ApQJX2iaAk7ZsqVkSFmzyWRD/erIx59sKZzpbQ+JaQWerci9VQZ1/QCak5V+1oM3jUNgUklZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.26; Mon, 10 Mar 2025 16:40:00 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 16:40:00 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v10 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Mon, 10 Mar 2025 12:39:57 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <A10312E5-F4CE-4CBA-B7CB-D435DFEA496F@nvidia.com>
In-Reply-To: <Z88ToirSWa_meevw@casper.infradead.org>
References: <20250307174001.242794-1-ziy@nvidia.com>
 <20250307174001.242794-3-ziy@nvidia.com>
 <Z88ToirSWa_meevw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0251.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::16) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cf8f9f-c16f-400c-3c20-08dd5ff2330c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmlEenVHRStyK2IwNmJkdjhZVXJWRFRWcVl6Y3dQVi9GLzh3NTNrSUo1QmY1?=
 =?utf-8?B?RVhGbXpQSDhKbEJQRHYvMHJRdWMvQkUva2hQbGJKWGtHTGxEb1J2QnFXSmQ5?=
 =?utf-8?B?RnVBT2VWODBpbDVRa0Vvckl5L2hXRHZGc0pYcVN0dHRyZ3ZkdC8vY0F4a0da?=
 =?utf-8?B?d0lIaUZmaFpLNjdwRUJNUHh2RmZ5SlJHRmsvQWxGYlpNaWZJc2dnREtWT1VM?=
 =?utf-8?B?ZFFhSnlNUitHbVM3eVc5ZEpoTHhqYlpMR0FXcFdobXAxOUNMNk9PMytjUlZH?=
 =?utf-8?B?TFF3Wkd0RWwvUDlRQWR6U21vQ05pMmxQTWp5WjVxWGxFRDlsSDdQaEJxMnJS?=
 =?utf-8?B?VTEyZzBrcWd6ZkxSeVpWUEJYNXp4YlNhWnUwMURCcVVaeitLRVlzMUF4eTg1?=
 =?utf-8?B?SHAxNjdNQlU4aGxyVHZ2NzA4YVlKY0gyV1dsVDc1Y3pYdDVsSUhqQmRXenM3?=
 =?utf-8?B?NWdFYVRobkV3ZW14QjRtYWhOS21ZOTAzb0tMWWZlZnRIRm5mVzVjaUFxUmFF?=
 =?utf-8?B?VHdMd1JVMWVSWVRXSyt3VXZrNkV4eVprWCtXeExEbnIxZHJ2THh6STY5eWFD?=
 =?utf-8?B?V1JvU3AyY3JBSm11UmpqRVdNUitxaHAzYTlDVmlmTHFabFRzK2oyQnQ1ZG5l?=
 =?utf-8?B?U2dwcGgxcTMxcExHd2NnTWlQYjhmQzNaTU1palNJTWR4NmtpUCsrN1ZJdzRl?=
 =?utf-8?B?K25rcWRPaXYxbUtPaUt3ZXorcUExR2xLTStHc0hnSGIwMS8zZG5TNkZPUk82?=
 =?utf-8?B?N1FlbFBWT3pKS1ROcThkcGpNUkQzYm1McnBYNi9QVjhrM2JVSnQyN2FYM3Zy?=
 =?utf-8?B?VjlWenRGbi9VLzVBR3FSY3kvRDJoWFlZWlMrd01JZml5ZmZ2ZkU5NmM2eVdu?=
 =?utf-8?B?RXJRSTlWNGdlY1l5Z1ZwUnNXaks4bS9hdjllVUZYditMaXJIZFFJRGVHUTJy?=
 =?utf-8?B?QWhHckRGWGUrZ1hlaFU5MlhqdFZEUnFOTHkxNm9MY2lSM3B6Qm5FSjBETDZs?=
 =?utf-8?B?YUNNbGxuOW91RzlwQkFkRnkyZC9rdE01WWV4aFYxZ2VUdzEwL0grbVVzc3JJ?=
 =?utf-8?B?SGMwS1VPRERnRXRvOWU2cUNtaFUwWFVaM2NPTmNFeG9XZU1lNmxIOWx3MDJG?=
 =?utf-8?B?VTBydFZndGRXSVB6cXpZc3FHYUE1RzZYSW8wRjRmU0JuTllCZFpJd00xd1Iv?=
 =?utf-8?B?d2poRHJKTTdUZTJ5TFpjczVnKzRDVkNyMHkrdmZ2LzlFV2ZyU2pqcWVkZ0I1?=
 =?utf-8?B?RmFDNWo0cnF0YXp1SkZsZ0ErVWtucEhkVWJZenBPRERuTit5RjZqZ0xnY2lk?=
 =?utf-8?B?akVTRndqRldCTTlHSzl6VStaNmFaOVBqVC9kS042eTRkaFZCTFpqRVVPZkhj?=
 =?utf-8?B?TmJHTVZkaDNGN0tKNXdxYnk4c2Z4VVIyeWh3YUdHYW4vY3YrVm4xMFowQXdv?=
 =?utf-8?B?dFRMMEVBdlpTVFI1NStueExHQWdJV0MrY3krSDJpYWdmTDRpWDY2T2ZwYS9m?=
 =?utf-8?B?dUx6enB3ajJURGt0VG1ReDlHN3p1ZXRyNXN1YVI4b296Ylc4WkxPODRNRndQ?=
 =?utf-8?B?Zi9iSVRvTHlVdjF4Y3l5cjQrRUtuTkNGVTZqVDVwcnNqWGRNRm9tVUlPazhY?=
 =?utf-8?B?b3RvZ0tyZ2NXaGQ5VG9DMFVUMUc5clY4cmt3b3EwL3dacjVWeHBnNmYxTW1u?=
 =?utf-8?B?K2xGR0FFTFpiRHJNL2d3Yy9lOExxN3pMczQ0ZWk4Uk9LZUJNb2p1d21qOSs0?=
 =?utf-8?B?bDNKR3MwaEloSmMzUzVMTHlWK1M3Wi9ZRldnbStvYkUxaWVGTEJzR05xS2Yz?=
 =?utf-8?B?eXlNcmRtVHpPNEFIMURveFIyT2RLcjM4SStqaWV4enc3bFU3OFFLR2hqRDZT?=
 =?utf-8?Q?LeMsNQKNX5j5W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzA0dUo5UWVEZkxuT2tpOUh6M3VDSjdzQ0lWY1BoaFlQOTRTdGZCK0VJeFhN?=
 =?utf-8?B?QmhaSXRvZWlXTlM3Y0xKd0QrdXkrQitVL1FoUEVoQVVhRFpDdks0OG91dVM0?=
 =?utf-8?B?OENmSmptTDh3ekZvMTFBcGRDU01qdk1HR29GMkMxazJpOUJQVWc2RGtrWExB?=
 =?utf-8?B?T0UrWVNST1VjcTJlY2NiVEhvNEZyV3pwQjF2cWx4dmw3V0xMUkJaNUNGWEJX?=
 =?utf-8?B?UFdQVnNmdFVyWTFFWjMzQk04UTNCMFZEcnY4bGpvbmVybTExYVU2ajU3Szl2?=
 =?utf-8?B?ZFhwVDZ6VjdQVGJCRHBDekJiVmtEZURVeEcyK2UreWZ6aUpFNi85Mng4aDYw?=
 =?utf-8?B?UU9HRFgxbmFUL0xSR0huZzRFaDRDaHc5czd6U2J4QjJkcWVDelBEc2ZQaDVN?=
 =?utf-8?B?K05RMnowNGRKWUVkRmQ3aUJ4WVA1TGcvZzFjR0lvd3JBWG51Z3Q1VXBFUEVY?=
 =?utf-8?B?cktNQ25XakU1aGljcm5DMXMxSGZpbEVEVGI3RkRHOHZmcy9yaWZxV0o2eGs1?=
 =?utf-8?B?S2RuUEh5OU1CY1ZoNjR3dUNwak9ZeVVKSjV1YVR0R0JwdExqK3p4RFNjRmdy?=
 =?utf-8?B?Q3BLZ2dXdnRwVy91Tll3cEtzbDA4SGtHYnNscjRaZVlVL1FDNlZjMmk3Q2VF?=
 =?utf-8?B?WFQ5TlJwRkU0QUYrSHM1d3B3UlZaMThUY1gxZFBqWTJTd20xR3NmZGZwdERi?=
 =?utf-8?B?and1ek9XYjR1OG5XUU9GeXVCRm5yOWhlRDBSQ0VBcXlBNm84alA1blFhU1Uy?=
 =?utf-8?B?ZFNJVWZwTFZQTG96SEthVXFIVGIwNDE2VDRFTk5JQUlLQUZXTXdhcWVYcHM2?=
 =?utf-8?B?Y05RcHMvdnZrTlVmaFRVamQxSGxyaTByMFFhb25NeGxGRjJWMEQyM0Yrekh2?=
 =?utf-8?B?R2Q0aCt1VU9UclpiZS9qRHE2MCtQdkY4RTZlb2VuSkFjN1JSaGIxdDdVeGN1?=
 =?utf-8?B?UjhNTVhhMjBkRklocFZ4b0NiR1ZkWUtZd2llMFNWUTlwRk15Z2xMNWNpK3dp?=
 =?utf-8?B?dVNUTXRlQmtIamhTdmtkOVcyRnl4Z1VIdWovMHF3VWo3U2wxL01meVpDNzJT?=
 =?utf-8?B?SEl0UGNmU3Jlcjg3M2taV0NEckhSaktqdlROK3Y0dm81U082ZWJUaTQ4U01z?=
 =?utf-8?B?bjdmMUNaay9NS3VRWXF0aFpjR0poWUxWUlFOK1NJNk11di9kaDdNbWh4OWFx?=
 =?utf-8?B?OWRkZWcvSjJYYzZUUmZTcTRyRkhjMElodDQ0OUJZTldnK3JZZ0dYTTlDRzVq?=
 =?utf-8?B?cGZ4SU5tSVRvUzB3Y3JVYUJuRURrN0F2WE5xN1ZEUTJwM2xYQkdWd1NQeXB3?=
 =?utf-8?B?aVpFbFVxL0dIS2RFT3pTSlhIUHpSYm5CbEhMSXZpTllaZUZDMTN0ZSs1SjZr?=
 =?utf-8?B?Vm9LZlRxWnJpelBtZnNaVTBjM01GZUlTdUtrcWRJZndSK1YyaUQxTDdiQ0tE?=
 =?utf-8?B?YUJjUHFsc1lDMG05UzBPZzd4MWdUMkRnT3JMdTNJdEowV3laTFFRWWtNSmhU?=
 =?utf-8?B?cXpPeVpDM1Q5L0cybzVBNHFYQ25tN0VRRFE5QjNjaE9BQ3psVEVIdjU5NEky?=
 =?utf-8?B?V2IyclF5Z0Q1WFZtbTFvTVAvYmRhT2lsZVI0bXRLaXZSeXdVL25pYjBFK0pK?=
 =?utf-8?B?U1RyTlFxbk5MRzZZa2tTMmhtTGMzdWlzUFUxc3NqMGZ0UXVSODloT1FYaXpu?=
 =?utf-8?B?OXJlWjQ0N0JDSTRUNU9ibDJUOFJrNWJ5NTBOUFdoLzhRMU5YWXJ4aVlSYVpE?=
 =?utf-8?B?UWFNTi9PSXl1ZUtYYkdsRHUyRWRweWFGYzhaSkZLZE9wTlNXeVlDMm9UdGlm?=
 =?utf-8?B?QXhmV1FCWnZqYVdROFZOOUxKcGNZUTdqYWFSZFlKZVBMSStWQVExcnhWT0Zj?=
 =?utf-8?B?R2NLRWV4a2tJZ2tmNzdGZ2l5WHhGdm5yZXR0NVl5OXYzOGNwaER4TTBibUV6?=
 =?utf-8?B?N29ZKzNyTWtxOGpHVmhwVE9LdlhoblppbjN6YkRYWTEzdEU4Y3oxTnNUajg5?=
 =?utf-8?B?VXp4KzRBSjRzbzJ4TmRhTWRiZVJWSFdKSEVpNzlrSjFtZFZ6bGxFVlJkdVFy?=
 =?utf-8?B?RHk5ZnR4bC9NUzhoSGhkcng4bHlqQXI2Qk0zUlA3SjZMRzBXQ0hCNWNDUFJx?=
 =?utf-8?Q?mXu2zWQ6uwROHy/gQuPO0+S02?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cf8f9f-c16f-400c-3c20-08dd5ff2330c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 16:40:00.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kdf5d5iYRzeU12QDt6elwTva4X2ahCz8tQw95zGBMqpEq+X3HBlLJZYXMQidkZMG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204

On 10 Mar 2025, at 12:30, Matthew Wilcox wrote:

> On Fri, Mar 07, 2025 at 12:39:55PM -0500, Zi Yan wrote:
>> +	for (index = new_nr_pages; index < nr_pages; index += new_nr_pages) {
>> +		struct page *head = &folio->page;
>> +		struct page *new_head = head + index;
>> +
>> +		/*
>> +		 * Careful: new_folio is not a "real" folio before we cleared PageTail.
>> +		 * Don't pass it around before clear_compound_head().
>> +		 */
>> +		struct folio *new_folio = (struct folio *)new_head;
> [...]
>> +		/* ->mapping in first and second tail page is replaced by other uses */
>> +		VM_BUG_ON_PAGE(new_nr_pages > 2 && new_head->mapping != TAIL_MAPPING,
>> +			       new_head);
>> +		new_head->mapping = head->mapping;
>> +		new_head->index = head->index + index;
>
> Why are you using new_head->mapping and ->index instead of new_folio?

Because of the “Careful” comment. But new_folio->* should be fine,
since it is the same as new_head. So I probably can replace all
new_head with new_folio except those VM_BUG_ON_PAGE checks?


Best Regards,
Yan, Zi

