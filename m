Return-Path: <linux-kselftest+bounces-32049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795C0AA55A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 22:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CD0466785
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31029AB1F;
	Wed, 30 Apr 2025 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GQVshBsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C1E188A0E;
	Wed, 30 Apr 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045626; cv=fail; b=V7anJkUWc3T4gjNi7tPG/e/nWk3veOAIoOOVb37L7TymnGxw1dfcEywp4j7l31XbFwEMK/fsqg9G7xsI8voshGJRp4ELoK0H/L1eQVlSzHB0wQsGFdfRsGxPZjEZpRxCcfAKronzynKUDALSNXVPuKo1w0nujuu+HMcqav1nDg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045626; c=relaxed/simple;
	bh=A6eqpslx0WuIewM0/7N65nM5GE6LQRfjXAsVFW4VKfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlVtA2EJ1s1h5nierKjvs15irMWUBFxcu3PcmElpVqCFb6fDHP2fX0eOrB6Di4977/RBw/7GwECpaLCZRi/1udpjKjOV0jx4DLBGeVrkvZwfb/thQLFMTCbyrrlIud8qwERtQJb2pJ2AVA5FWzUdU7vskKp603BFLd5sNs+L2kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GQVshBsD; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbotCSudcEo0nRdhQg7MUILXxdSgXnfUYOcbj5LnEVT44eUs19sWB2uCjIGdR/fv6jMe2fZK4/QshZV5AAqhqDAEGcaSKelRgBG2ZCs7zZizOwdeKR4uW8f+vXBQ9L11Cpl1zQAQw6BH/4kU1HfQbmWrsKj4JJyt5GwriYxY/xkO1fTzn0HW536IIPQpzPyWurMQpXAC3EYk69mTVfLHgicxGyN2d5OsWEDtRrV+/4y7n0/KfZfXenm91a3m2KFOF7UwCmcmHikv0r5g0SQ4+X200mZ6qQYvj+iu4DmPJJ5l1fByGJxLe+Qz0Tlz3l1opGbm0JHIHy1XfiSDE70sdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A84Ej4d2RS2wGneA1vY+yI/4W/vvZD4GkZnbmOBemm0=;
 b=lyZfM99QrzCJVhF43r4daQbA9nDh4IF4riK+KnyZvJuaiV0mD5FHM1oLVtHFzOc3kzvA4Kf2rEYOSf+/eKCSzZ+rILL104txLa0IE9pC+N+KgcQlz2etW4B8n1nhjtHootASd7P8m4aa3AIzFHBy1ytXikWXecPNfiWkH+3vYrbP+zSvvV2nN9X/CWS54KCs5C0jS+UP+4v0zisUcC3dAsPaGAIYNyDiJGpAsO/8h1J2XC5KnTVQm/G+yYGoT8X1fzDn9CB9QgLD0f5dIXkIGn+Qk0qB1QqWy+0rwE3zQoFDXyJUHTKgJdCPlHm7nUY7j0EvXOcpOg+o3kQwzM95Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A84Ej4d2RS2wGneA1vY+yI/4W/vvZD4GkZnbmOBemm0=;
 b=GQVshBsDa4oteiVorLTkqIjhEMtoLzwa/FnNgI2tnkW5OHKGPfVvtI87OPypdrk7kgwekwDpBBrBI4LmNXMKe4tE2LTryoI6uccWY/LjKYwIwUUYcJR/tZonEr+axntdZTukJUbSnj81k2DLDTc13zoSzgFY9tLTZn8HRN1nxr541Vd3AiHPCLcyyhxFTDxnRnQCanH2Cc9kmqJ9sWEq6D1eDVdHGMewgtxWK5yWlLji3Ovd76HTjzUJt4hi+KDtdIADRO9fI0b5sUzRaxm6aFTmQA+Qq0GL7CLUFzwLUfs2sslRag61sAJVKDh6As5fnixwUsArb/zwUcCmVp9qbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH1PPF2C6B99E0C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::609) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Wed, 30 Apr
 2025 20:40:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 20:40:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, shuah@kernel.org,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, hannes@cmpxchg.org,
 rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 4/4] selftests: mm: add defer to thp setting parser
Date: Wed, 30 Apr 2025 16:40:17 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <AD8EF22C-9726-4D7C-807D-563B9BDFD475@nvidia.com>
In-Reply-To: <20250428182904.93989-5-npache@redhat.com>
References: <20250428182904.93989-1-npache@redhat.com>
 <20250428182904.93989-5-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0590.namprd03.prod.outlook.com
 (2603:10b6:408:10d::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH1PPF2C6B99E0C:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fbda09-3459-45cf-e0ba-08dd882739e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2a5qRFWtyrvs9+tF0LcYFsBJJwmC2YTjL4OuWEo4UFnKBjsUpi1/LeMjdOGk?=
 =?us-ascii?Q?GSdNHbOA61IWkSYZOELilqpupiC5+XJPyukQQoc1A6foq0wBMK5EUwSCDQHT?=
 =?us-ascii?Q?m31buV978CEzMFk3VVExpiKVaSN8D5xMvNc0XYJugO8nnqne0iPrGxeqLi27?=
 =?us-ascii?Q?k7P3gpleDsGDWPLw2dsdwROAmxxaatsLrzBykgY0GnO9PVaGCF1MGsMSRfHQ?=
 =?us-ascii?Q?d7B6ZtlgNV964oehJUiXupYp79aeQmhaFeZ8ruVRA1hrb5wlsoTUlBpaGwzU?=
 =?us-ascii?Q?EyBNLAWebXT/FKiIIRuBAPZHpS8crCEu7+nDyWghQr/HqDKPXdxcc3WJV5T/?=
 =?us-ascii?Q?5nSV2moi9qKLaKmjq5RjDHOHaiYGcGtl9tM7/R/SAS2ZazhdhS4oOrbGtMNu?=
 =?us-ascii?Q?Qip/T9Y2w8gOJjez5PGyDhsOXsZQoD/5N/W9EwY4STDzzjbpD4l58tOiBebd?=
 =?us-ascii?Q?IhlY+oLd1xmgjrQfZL7fdeDf3C2DAj2/gvMChnhtcmeeN/m5+HbA0xtu8WxJ?=
 =?us-ascii?Q?fQ3pF54sxHXwCEGQ9AJrjSBNBsBRQ68ljtwq+K2J+OhFmJNCPa/1Rqf2IkDS?=
 =?us-ascii?Q?y/G36oW/QFRj9QEb8Q01fMXl+FUMmwJpW6thVMynZKrjnS1RXMWn3o7O+3Vb?=
 =?us-ascii?Q?98s3Dttm8S7TOJXmerX+TBde+4AOUhUTQsn0GHqgJEQDfd6TZj2Z8nfvnR6E?=
 =?us-ascii?Q?lhbMSnRqwYsMoW2qCQrkT5Qa4jZULnKArv8zsVv5B/oq++KwwpkD5FXoQBQm?=
 =?us-ascii?Q?0ND0zr4GKl+wrUbBqeQJpQ5B8u7/q8bvAFtarjzyh01YnN4TKNla13sgvQXD?=
 =?us-ascii?Q?zJRs28kGahGQTOwN79yxGLDrN4aEkF6+QvXVU1A3LRhVA5cFXUoXuzil/O1P?=
 =?us-ascii?Q?2p8iZnhYa73Bye92bXJZwz1N4cocuztC92YQ8xA2x2T7LB7rb9OvYXUZnNPe?=
 =?us-ascii?Q?A3otFsTsd6d9IA6/JcLRl4NvTsUuEYbRk55cIuQq0APEzBPvjtqu1ypj/KDA?=
 =?us-ascii?Q?oxUkmAgX/EV2BrSqVLsc7tHKInp5pukaw5RXvaJOQC9+LayqwWyd8XJX0zRq?=
 =?us-ascii?Q?Dwo11ocPawK24FH4eiE0emMpjIkaqQ7LKI8vmBWplO7/JG4/tYcDejPcQMje?=
 =?us-ascii?Q?3aF9vsVugQMZ3nxo4XA8UhQ9NawY0G0dx5bSIXjkjDX31PO8AAP+rZ4rHp9z?=
 =?us-ascii?Q?jHsO4vXke3GGPxwLXzOLs7pq/ydqVcgmfTp+7S2y8JmmNzPUokVpiZiCgJCw?=
 =?us-ascii?Q?WbzEbtkt2G8zTzSM583ahzKdmt5iTZgywbhnKqZ562HtcuBThY/9CJndly+q?=
 =?us-ascii?Q?1lcTBeNDuyjiryQNKLoYf13G/Rdit4mboeBX6ginENjeIDgiKVYqSMGfh7Vg?=
 =?us-ascii?Q?iXcJwZFfHlh6nbML3NInb/9EBqrAZl+u+rnglU+v5l1X+M/sPUj6xaDVtXWU?=
 =?us-ascii?Q?qZnh2LAUj3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7jy1xoE18hx9haVbtV3eWud7aWRuQ7CcvOXdPGH7FX6GHDVLNFxrZig4xiX?=
 =?us-ascii?Q?58RMWTEmW7qD+6wgAvd+5wms/uQXkLcosfyq+GccQYvYxYIVsBQaphqXIwbk?=
 =?us-ascii?Q?sZ6NmBEOehrhoLQVvqE4rnS1QVf1j8mqpVhAAalRVNBWHAH+NsSVmStKqeY1?=
 =?us-ascii?Q?p0PNrzll5tHojlkBesHMkgI9flwgReLSQz9tpBVSNmr9UZLZoBB5prDyUgTr?=
 =?us-ascii?Q?NgIjtQjNEVNIg3dFvV3S/9duZKROBKDCY86yyVEUXDyO/Wh8+41BdtVONsog?=
 =?us-ascii?Q?80qVMNdYncA7khkO5y3xG33BxvDbR407GpYeOSuvKtq8FHxJC260MEWeauj6?=
 =?us-ascii?Q?LvW4/QaEvsKJo+iCH/EsdsOTvHUdUZS0ilbRzdsQBQlTlziqNq/vT6v/+q13?=
 =?us-ascii?Q?2d+zmTnzdLbjmJ8OaxDIB1I35Th/QTsrFWw6nc2DCB+N5AE+w7ZVDMlIOmiz?=
 =?us-ascii?Q?it+qj276Qu300mAWh1/5O9KHBkRTWRwONSnzaNxbGJxKCVgFV2YW5w6E2Hw0?=
 =?us-ascii?Q?472oEMx4xhq88LED2T5JEqD9ULbRSmS+/TdEJ7E4x7dAWql7E0MuqwypgibH?=
 =?us-ascii?Q?VyjqI0Q8EmbRsbHlTfqZwuzsDgvmQz+YCiM9KC34SoMUXmzbP7w9G1sVgDKE?=
 =?us-ascii?Q?vc/42FAJ+Po3/DkF5O3O++/wVBA8wYeBaDN4vnedZdkOJHDiKoFAL2nUK+1B?=
 =?us-ascii?Q?VhKO8VfZXqsZ1a4caRjxhZxB0P2fzuEVmkPN7ScPboG1cAq8gLA4T85GXhjy?=
 =?us-ascii?Q?YwtO7bxw27EyIChcxIifdzXivPtUUgFqoLjsiiWYE8oTEWSYLzPaviTW+I3g?=
 =?us-ascii?Q?2gSPh9jargPnVuVpvX/sr5wrnF0wYfqRcdBnnTckDwOHeIUboEFYwgAsFr8S?=
 =?us-ascii?Q?3BBQHyfi1TLZIQM9+6zScEewHFIbnUaMwJigEZKJuSRRj86/gndynHRDnhN4?=
 =?us-ascii?Q?r2uK+FShvU9SbXZ+whJRRJB0Maw1O/roWkvsabP7wL+cYqtJuf/GFfvtaXWE?=
 =?us-ascii?Q?DeQu6QnzN8zKnZwvJiqgTmbNIchKJ4iLlhfnM8/glQ4Zj6UEJ42UMjdD1WVJ?=
 =?us-ascii?Q?gvJbNTe6l41G/oQqgwQ5fSD9yDQBSQMIgI+R+OYum3vCEn1di0jdAxOkVvUx?=
 =?us-ascii?Q?xDvT27nFO8y0j1AajRd+lUChAM2YMvGBWe/0gvJAW4ae9VpEtLO0M5b/HNKX?=
 =?us-ascii?Q?VodEwWODXPhBcqyHsTbp+d+OebSfb2x5ANartVS7MDl+lYmzg3POZLscNjSh?=
 =?us-ascii?Q?4R9EZx5QeZNp059HHX5iPC1TN9QYOlxgfYCNfBJ/PhCwaBFzKu0eUoAzhWmL?=
 =?us-ascii?Q?QU9XRBkQZhDQMxwtGY+Ls1pidPQGITHuXuf0G1a17kcXWerhaIHUFaTLBfHP?=
 =?us-ascii?Q?YloouFJbXVLU3pkUYFADpGxr/heKuhqR0HEG3fe3y/u47H4aKcjGC8f9uuW4?=
 =?us-ascii?Q?e1m8PBFR2InEKEnZGZ0NDw7gYh/imMy2HBM7Z2P5C5Dz4iiAVjzBqj4XqiTe?=
 =?us-ascii?Q?lKbMlz0qudl7VdRMs5kRwJOfRCQXKhc/+BtnaZ5Whoz6w2KszwOGc7C0SmwY?=
 =?us-ascii?Q?5sbxHNPzm8FQRmYbn6FxCHsYz4JEUcDXLQFz1NAB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fbda09-3459-45cf-e0ba-08dd882739e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:40:21.4096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5Y/TdpNOK9yvnDRjmCEhL2PkDMFHe/8iTGPWfi7mH63ocd2iBxqLyNEnlFVLpwe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2C6B99E0C

On 28 Apr 2025, at 14:29, Nico Pache wrote:

> add the defer setting to the selftests library for reading thp settings.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/thp_settings.c | 1 +
>  tools/testing/selftests/mm/thp_settings.h | 1 +
>  2 files changed, 2 insertions(+)
>
Acked-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

