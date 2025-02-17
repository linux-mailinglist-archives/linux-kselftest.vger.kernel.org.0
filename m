Return-Path: <linux-kselftest+bounces-26789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E9A3876E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 16:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7948D3B0B29
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25072223300;
	Mon, 17 Feb 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YHx3Wv+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D01494DF;
	Mon, 17 Feb 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739805772; cv=fail; b=CxjOmBI1jEj61EYrFrAxfvQ2SG8Ui+1sutArcBedbw5obS7XKzo2aS+DK2mePVGGsRB/BSiqLQwo8u/BdCTeYZ8JY0WoxZHtlmb4m/WaNeSBrLtWNcWUMODJtQCHiEK5Bv54sBw6ZGgqDxXCzdoOV/PhsYO7PBU7EjNKv7VYn8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739805772; c=relaxed/simple;
	bh=ZOsHy1wHf6JRGfr2IAOQPRNCc8G/IH1qLB1B/UFwHiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGmPZXodFJ2xQv5W89G4D0Wox22/lu0HZ3Oek7lUkMVxL96lkWPWa+7Bq/E3f1G92Xm9j3ChDjuhVMIGG+WZTgdSTRNfs2V54BccT2PYWDa37FLdhIIeCQCWdoIQMsb9D7AvNBaDO8b4YLi4AOrlSzaqO7hng+//MDUdlb6kYJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YHx3Wv+8; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeMi+WKLmTRNNIPX+nqPQhizluHi60BDn+kohe0eNqlrzqjTaCCo8IAUUJ3VeVQ2/adiDb6NEtH+zwZw70R9yI6Rg7dJ+aBdsmPBgT7gjWpnO6iEJ2TMobNk1AaYbC0jHxfgFSp9gun5J2pSHzSX6cAN26nC6qAt/x7lS9cZKTnZf1c/cY4gky43v/4imxXd2EQrQ7aqUFnuloGiPRataG8IXnkqZ512tQxswF9/SC7QgSlmC1tj2gN5MlJFhKbceYbP3QYb15t9o6uV7A5m4BrPVqFjwQ6vlwQiDLzX1Ds5eUCbWE1OiQeyyWJcgSPq8XM+vA/DMLZXPWJJDoEnMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIIUDEIO+npXFeN+j7NOCrdWtmEwAQ1OuL9LgF/Wz+M=;
 b=FwVsy4fYIoAu2qBwnzaWhm93H7lYE7Onov4Z8qdHwSdq7wfd78URFTVxjKn8LIBF0Ogon2wla2kmjhIJgYFHnTkC0UTsvRcQ2xsOJxN1ovPF+VJvEkI6p3kDOcMZfjOfnTlqeTS2ljx/lA/RLOJXCN2o2I4vTasvIuaymF8HYwHgQuDE1Mq83xaHpFbw+h2rrenXmgDPBkEfDuA57OT/84HQ5+5OqSe+ZiQBJBLyHkkjCQztNPUqZzko3HvF8cI3fET27gxRDrZHJen4F2fLV1u0OOie4oQR4F4R6ariAyKkh0NXSooyXkiSk1evo0X1it0nZdaO6B1EOamI1VQHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIIUDEIO+npXFeN+j7NOCrdWtmEwAQ1OuL9LgF/Wz+M=;
 b=YHx3Wv+8QozMXPlZ0JPhZIgwfxdoCX0lNwpDNdkFcepclcHh40YveIS7RrRG1DQAA13J4FJGZDt2QZyj6XCgJn+dVXp0xnmCfpwkFJbtfxmewuomV2DJO59JUUamFPCovOlY5tkSJyj88zIQtKbbuRA+/B/AxmSOUUHkI0PVIS1mWgG5Ti8wp5JUx8uaTElAmXmbsO8G5GVdwJ7t62gp2jt9n8UCYFma4YzAB1mD5Rpoj7MENJvxDuA43I1t02AYng3ZOpDYzYJOyb6Bg8DHenmUPvKposcSFS41OTBT3oAfCiofTFbb+RmpJg7CUTxrJbVN9gtiQufB9l3WayRc1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Mon, 17 Feb 2025 15:22:46 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 15:22:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like
 (non-uniform) folio_split()
Date: Mon, 17 Feb 2025 10:22:44 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <A6E3A545-D2CD-46B6-A532-64BBBED42914@nvidia.com>
In-Reply-To: <4483B46A-FEAF-46D9-AFF4-F0DF34864633@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
 <20250211155034.268962-5-ziy@nvidia.com>
 <f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
 <4483B46A-FEAF-46D9-AFF4-F0DF34864633@nvidia.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: IA1P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::9) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: fea69d1b-0696-4797-c4ae-08dd4f66ee7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vXkm4HYyvetj8avQyHU7WAXK/4mqpY5yOTlC+QrBgZOsZmKRDaegHlsBqA/5?=
 =?us-ascii?Q?ACKv6GzgKzR3BIlPMB0Z/RAZ3gUTiKWftFYIi7sZB2nvlIc1+Fh9lJLQuTUX?=
 =?us-ascii?Q?flblhlCuOyjU2IvACvihBuZ07+h1RzQTCiVBoIdU7IOMOiycB2gz5kY7seLP?=
 =?us-ascii?Q?jN2Y/rwrZamznywexQvGQUlI0Z+WrjPdG/P8NX9tJOIKnqNVJo/h4mBmkCfj?=
 =?us-ascii?Q?QQe1ec0RRoGpNj4uhB48PCKFb8qexK5B1ntJccj4X/TsBIQqiX4w9ldvdIjm?=
 =?us-ascii?Q?YzYGEvOLNncZLW0uIo5gji/S/jCD9heJOVNlXVjblAmHZps8WPbWKe+0wTLZ?=
 =?us-ascii?Q?tWM3Ku0HCgLYZdpJw225iR8j/gHlB0nHgsw7EEVGwgu+UEIiFGHY63vRSb94?=
 =?us-ascii?Q?5PArfxg/r84jdtg5slwrrMbMS+NxrlLoW9VScgKsaIVnnNqjgEiO3kgxtb1C?=
 =?us-ascii?Q?TbXNgl0Q6A2fbT4EtrZtkETv/uDO/YWrtrGbpdEHdnJrjZeKhMUACMyMhkkz?=
 =?us-ascii?Q?BAguM3Q+wVbHFj9LMToLwcmFexkBd51R0dmHanAjEnE46Mn6dYfGhXOtpiao?=
 =?us-ascii?Q?/gwS6YBvvM1+Fz3dGnjvAqw1Y6FsqylvwwMQ3ikJcyeEkfQqVQIX58nqyCIa?=
 =?us-ascii?Q?+cXcXld8GmuDq6JWuCGP8iBf2WP5VfAzZflxvPIMiPJ5L69/DW64HFbZXk5/?=
 =?us-ascii?Q?gYMVUUS+TJi+JQMsSEG/g2rqBOXOHp3aFn6v5Xea9s6i+9UNXMNxEFTyWk2l?=
 =?us-ascii?Q?5yJPO9fyUnHSAPNzAHLAWDfbTBDRaLU5LoQw+cv5nHbp0eVg+dDuiErkG1OG?=
 =?us-ascii?Q?SK9tlTJMmpquk+0VBexP7evVvOe9VqPrLZTY8Bqi8gZ85pnYBR6WGTHAVZ5B?=
 =?us-ascii?Q?fSp2Fc2AQ+KbQZonahGn7CDsCLWdfwoGPsQy2rKEOARDPZqz9J2bvVLGjdv6?=
 =?us-ascii?Q?ORdsDsU93BA09Ca5/GhbJxo0HprqnlKAS3qz/2Lj6JPxPD3O4eOI5Wyfb+vq?=
 =?us-ascii?Q?ewBpX7IaG/KOLPA+CP070tdpOuiKxFgFDLSZ9f9mYotxowkQu3ZMErE0AGml?=
 =?us-ascii?Q?UAV5xD4WXLnPdi/PSWjMInOikaj+PAtx+Hjn7E+o42SReOnKIoei9bxKLSu+?=
 =?us-ascii?Q?yAUBdV7vGEjmAf7SjwEja/Ny1uRbme0fUdnRoDWrhZEEctEltco++TD+BtEc?=
 =?us-ascii?Q?tdwo1zMW87OCeYHtaqveK+Jwqw4BT6dPihoHxJerdnqHIvPRMNAmbJi4dTQa?=
 =?us-ascii?Q?lxPm21TqveIS0t0XANlqvnS8tb43PB+B0BkH92aqmGrjf0wR7dqG0imAiiCB?=
 =?us-ascii?Q?7RvNrmEO4jaYTFlbQIPrpU5osk4JQMIVU/Pv75vFmc6GwCIWQDSlXURa2x2q?=
 =?us-ascii?Q?BWUmBQr5eohkM5D3SxL6/lxchS0b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FJ7YneVH2m8PnYu6XYYSrBIzMGE9hTsADN3Ymdl5mUfUGHn4gLw84gqqf4uT?=
 =?us-ascii?Q?kg42OeoXMOsRXT4M+oSamLj9gv/B9gQswA83aJHRvASLUOrJfzCOkD6JbU9r?=
 =?us-ascii?Q?RwMYnAI9Iv1DTDAm1MHYgA+BV7LY3opWt4sHGvlAlmKC/6aWJfwwZuzk88SI?=
 =?us-ascii?Q?5+I0tD/i3231G5FYl3rMG4qKulfPUV1dEoaeE4g3TKqZd1cygPsSELeHfDwe?=
 =?us-ascii?Q?wzhTGQEoIlku406rxHnmNzaH9Dqd9B8i5LMUPBhZbw8buV+lGRhJfG7+nJ8P?=
 =?us-ascii?Q?NfJyRdDnaQX87ZOud0zPkwp64j03NbSl7T1EC8okeKaSNgjWS0EXDC1+zh36?=
 =?us-ascii?Q?6kZRFaP+QSNgBpdMBUmF0hKw8cNA5FP1nbD5cKZGqcU3pTUnb9YoBv15Q8E1?=
 =?us-ascii?Q?TDuWF/G5U2ZKETgMQ3V1GP15vQlczm7IETY2ooV5oHQsLCOPCou+W9ikYXW6?=
 =?us-ascii?Q?adlKbVl0mLXJLyR+au/IXNwPIO5TL1agu5QepmtNSAXQAjemBWC3ud05z2QX?=
 =?us-ascii?Q?2kqk79WJeHvVUHGbBZWUXtBpvw8WAtzF69/2HrgtJeERGp/cw1qnxaj98o6i?=
 =?us-ascii?Q?T7TuEHbcWwldO5hYwFp/mi+jutEB34Og85YRLjas5bufTuZE0P6mHifpk3p8?=
 =?us-ascii?Q?ROXxI60K8HpasVSuI/rUkIHb9z5aSPW5j5oS2qrNNCnkcd4HFMk6YDto4kTu?=
 =?us-ascii?Q?8dAx/hvK/QkWgCdSpRsvqoOxuAigI3+oet13PHgrZQL8i680UMwZs6SU7lO8?=
 =?us-ascii?Q?DWcDbqAm7h6OPC4tcIbTwnmMhq72yp+9pcCBMtdX+2Vdz9FfQ6tRvbZmhd12?=
 =?us-ascii?Q?vQ5kM+ALYh6WIpRSa72xyB/S972+TXKCetigd7Hm5L4T5nby36CXsTUPmbAT?=
 =?us-ascii?Q?7EFbwXs6o0nS1MpqJazUDDoEQTT4RBuAykY+NyJzvHiwH9c9lh+ktOcBb606?=
 =?us-ascii?Q?cQArSDAFp5oDRxaxkU2NNlLY6x5X/L1ziL3G7TUojWM66ero6BtH6sqPxudY?=
 =?us-ascii?Q?kwFDluP64+PBHY8ODtOZcVmILxdQCDkbauZ1vyxlfHTNBLr2E4B6yr87MbQ6?=
 =?us-ascii?Q?7qnENI8WlXuXH1xiT7xFo/LbIjzSwAoIACVlm0hfD5yA5VomQpwngDlmwZVi?=
 =?us-ascii?Q?x6FbMukVmvRfgSX6gMTguEXqTMN5x/YnxHwe69qe84m0eIwslOTOHYhgKPrY?=
 =?us-ascii?Q?B5QhFnmTz2jLKVM1Wi32sSwLNs8tl6inXcyN28WJ2iOV7kFjzCfJ3AtyU6tx?=
 =?us-ascii?Q?QsAudS40LuBC5J9v+5nd7xuja5hxhevoulOdRTDVPjoPCQCNw0O5+RXbCCFM?=
 =?us-ascii?Q?dUGzR+cUB9TVuVHNjq2XuYAf+WRAyMWkD7Tby4keSZXXMmj1BVhfkz1rv1Bo?=
 =?us-ascii?Q?5Bvbu9eA5TBl9YIGUKpdC/i7IaQRR69Au/3bsV6VNzoOjbxrv8wFEtykjGn1?=
 =?us-ascii?Q?/aSRKc/df6ekF4GjH68cqgyIdCrlIJBcIOOcQ+Ygsn7yq7GltvkNRsXFxQRS?=
 =?us-ascii?Q?uBJyoRwNb4svku4AZ8Hw8jyhkYgq94X+tmvL9Xq66cl8PuLvIcy9QykSDfPn?=
 =?us-ascii?Q?tpLkl5VXwBYxXQq2c142SHbETOgY/Hm+xZgV3mcb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea69d1b-0696-4797-c4ae-08dd4f66ee7e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:22:46.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX8TBT/aSlSmVccxOooDNcGO5A+v2b6XLwecbcasO26n+VdOI1/15pf3uRiR71Sr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

On 16 Feb 2025, at 9:17, Zi Yan wrote:

> On 16 Feb 2025, at 5:32, David Hildenbrand wrote:
>
>> On 11.02.25 16:50, Zi Yan wrote:
>>> folio_split() splits a large folio in the same way as buddy allocator=

>>> splits a large free page for allocation. The purpose is to minimize t=
he
>>> number of folios after the split. For example, if user wants to free =
the
>>> 3rd subpage in a order-9 folio, folio_split() will split the order-9 =
folio
>>> as:
>>> O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
>>> since anon folio does not support order-1 yet.
>>> -----------------------------------------------------------------
>>> |   |   |   |   |     |   |       |                             |
>>> |O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
>>> |   |   |   |   |     |   |       |                             |
>>> -----------------------------------------------------------------
>>>
>>> O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pageca=
che
>>> ---------------------------------------------------------------
>>> |     |   |   |     |   |       |                             |
>>> | O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
>>> |     |   |   |     |   |       |                             |
>>> ---------------------------------------------------------------
>>>
>>> It generates fewer folios (i.e., 11 or 10) than existing page split
>>> approach, which splits the order-9 to 512 order-0 folios. It also red=
uces
>>> the number of new xa_node needed during a pagecache folio split from
>>> 8 to 1, potentially decreasing the folio split failure rate due to me=
mory
>>> constraints.
>>>
>>> folio_split() and existing split_huge_page_to_list_to_order() share
>>> the folio unmapping and remapping code in __folio_split() and the com=
mon
>>> backend split code in __split_unmapped_folio() using
>>> uniform_split variable to distinguish their operations.
>>>
>>> uniform_split_supported() and non_uniform_split_supported() are added=

>>> to factor out check code and will be used outside __folio_split() in =
the
>>> following commit.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>   mm/huge_memory.c | 137 ++++++++++++++++++++++++++++++++++----------=
---
>>>   1 file changed, 100 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 21ebe2dec5a4..400dfe8a6e60 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3853,12 +3853,68 @@ static int __split_unmapped_folio(struct foli=
o *folio, int new_order,
>>>   	return ret;
>>>   }
>>>  +static bool non_uniform_split_supported(struct folio *folio, unsign=
ed int new_order,
>>> +		bool warns)
>>> +{
>>> +	/* order-1 is not supported for anonymous THP. */
>>> +	if (folio_test_anon(folio) && new_order =3D=3D 1) {
>>> +		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
>>> +		return false;
>>> +	}
>>> +
>>> +	/*
>>> +	 * No split if the file system does not support large folio.
>>> +	 * Note that we might still have THPs in such mappings due to
>>> +	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
>>> +	 * does not actually support large folios properly.
>>> +	 */
>>> +	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>> +	    !mapping_large_folio_support(folio->mapping)) {
>>
>> In this (and a similar case below), you need
>>
>> if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>     !folio_test_anon(folio) &&
>>     !mapping_large_folio_support(folio->mapping)) {
>>
>> Otherwise mapping_large_folio_support() is unhappy:
>>
>
> Thanks. The patch below should fix it.
>
> I am going to send V8, since
> 1. there have been 4 fixes so far for V7, a new series would help peopl=
e
> review;
>
> 2.  based on the discussion with you in THP cabal meeting, to
> convert split_huge_page*() to use __folio_split(), the current
> __folio_split() interface becomes awkward. Two changes are needed:
>    a) use in folio offset instead of struct page, since even in
>      truncate_inode_partial_folio() I needed to convert in folio offset=

>      struct page to use my current interface;
>    b) split_huge_page*()'s caller might hold the page lock at a non-hea=
d
>      page, so an additional keep_lock_at_in_folio_offset is needed
>      to indicate which after-split folio should be kept locked after
>      split is done.
>

Hi Andrew,

I am planing to send V8 to collect all fixup patches I have so far plus
the one below and change folio_split() interface and some of the code.
What is your preferred method?

1. you can pick up the fixup below and I send a new set of patches to
change folio_split();

2. I collect a new V8 with all fixup patches and folio_split() change.

For 1, the commit history might be messy due to my new folio_split()
change. For 2, Minimize xa_node allocation during xarry split [1]
patchset depends on patch 1 of this series, which adds some extra work
for you to collect V8 (alternatively, I can send V8 without patch 1).

Let me know your thoughts. Thanks.


[1] https://lore.kernel.org/linux-mm/20250213034355.516610-1-ziy@nvidia.c=
om/


>
> From 8b2aa5432c8d726a1fb6ce74c971365650da9370 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Sun, 16 Feb 2025 09:01:29 -0500
> Subject: [PATCH] mm/huge_memory: check folio_test_anon() before
>  mapping_large_folio_support()
>
> Otherwise mapping_large_folio_support() complains.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 48 ++++++++++++++++++++++++------------------------=

>  1 file changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 87cb62c81bf3..deb16fe662c4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3629,20 +3629,19 @@ static int __split_unmapped_folio(struct folio =
*folio, int new_order,
>  bool non_uniform_split_supported(struct folio *folio, unsigned int new=
_order,
>  		bool warns)
>  {
> -	/* order-1 is not supported for anonymous THP. */
> -	if (folio_test_anon(folio) && new_order =3D=3D 1) {
> -		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
> -		return false;
> -	}
> -
> -	/*
> -	 * No split if the file system does not support large folio.
> -	 * Note that we might still have THPs in such mappings due to
> -	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
> -	 * does not actually support large folios properly.
> -	 */
> -	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +	if (folio_test_anon(folio)) {
> +		/* order-1 is not supported for anonymous THP. */
> +		VM_WARN_ONCE(warns && new_order =3D=3D 1,
> +				"Cannot split to order-1 folio");
> +		return new_order !=3D 1;
> +	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>  	    !mapping_large_folio_support(folio->mapping)) {
> +		/*
> +		 * No split if the file system does not support large folio.
> +		 * Note that we might still have THPs in such mappings due to
> +		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
> +		 * does not actually support large folios properly.
> +		 */
>  		VM_WARN_ONCE(warns,
>  			"Cannot split file folio to non-0 order");
>  		return false;
> @@ -3662,24 +3661,25 @@ bool non_uniform_split_supported(struct folio *=
folio, unsigned int new_order,
>  bool uniform_split_supported(struct folio *folio, unsigned int new_ord=
er,
>  		bool warns)
>  {
> -	if (folio_test_anon(folio) && new_order =3D=3D 1) {
> -		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
> -		return false;
> -	}
> -
> -	if (new_order) {
> +	if (folio_test_anon(folio)) {
> +		VM_WARN_ONCE(warns && new_order =3D=3D 1,
> +				"Cannot split to order-1 folio");
> +		return new_order !=3D 1;
> +	} else  if (new_order) {
>  		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>  		    !mapping_large_folio_support(folio->mapping)) {
>  			VM_WARN_ONCE(warns,
>  				"Cannot split file folio to non-0 order");
>  			return false;
>  		}
> -		if (folio_test_swapcache(folio)) {
> -			VM_WARN_ONCE(warns,
> -				"Cannot split swapcache folio to non-0 order");
> -			return false;
> -		}
>  	}
> +
> +	if (new_order && folio_test_swapcache(folio)) {
> +		VM_WARN_ONCE(warns,
> +			"Cannot split swapcache folio to non-0 order");
> +		return false;
> +	}
> +
>  	return true;
>  }
>
> -- =

> 2.47.2
>
>
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

