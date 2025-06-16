Return-Path: <linux-kselftest+bounces-35135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72135ADB872
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECE5167F43
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4C289378;
	Mon, 16 Jun 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUc3FwH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AE289810;
	Mon, 16 Jun 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097199; cv=fail; b=uCIXLot5arf5xsaIQVRcRFu6gEfWmlR+FoidKllLl4JUuZb83fu1jK90EEBV0ZI0O41MZcWAXku0Xs/BVlGwofGqs384jEELLGMhTUywZyMmH7+3Svg2J3l71AtoPxqzrkNQISW3Qmar1gijwFrjKWfLlFwpCl9w0WN6G/1bQUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097199; c=relaxed/simple;
	bh=ZnoNdAimSAtySbSL77CmBTZgSU4xosb0l3wXI1JXg5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qPcaBcM9b/HWRgjIK6DXq6qbiEqowFkuoaLeJyorVdrtyHZ7D9wmJLy8s2Cs9xdGPAeb4CLCTdc87/jprr3WcgbGyrWiKQQaMcFwEevXn/j7lAiEOrD+K2YXvJ6qaUIpe5OnPV1MOTYsBKMXOSAZIkCSXQPdQL4YzjSl8pEFSrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUc3FwH3; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZC8QGcK42rzHLjolNT53Sn6X7oo6adOwasx561Sq4Wb8MLb++EAKukV7FWqSMZwpbkKqiMYc8G5Mla/+XSdLPZadWSGQt+HNBF1zlbM7y3qewWsyHSEC6NWSJjn+IC8vfkV+8hVR01L7yg553yJAdLt0QB5N3HcdamwH35nKo87iczQBXhZaFZ/Cpl0ax+ICY4y0F1Qq0rxIgYpFqEeqpNjxshYvSLzDX/vaWnbZfzMidb2jinRBIPAH4vQYP7NiykqPM9ft4WDK6a/f0C1Cq8fIDK8rCKo2KaIkG8zvYd0gj6xpL+/KyMZTDKKYmub2GXH+BD4TZF9/6rY9ApxLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EifkbgrsATayZrN7ehbRS9GnZOOBa+JzkTXm4afvdYY=;
 b=JIWVqybRRG4Ks6OEt7deHWT2jY1v3ljZd1krtDZ2+4X/jm489obemBKaOqrz0OYzpyOq/4/5ahXqKfE9T7UTZwFhLul7ji/1pRVoBfVbU5EWV8rIDZUm0B8mqRRWxYa1HoPJROL2yCfMV63Zv1/t70NX0XTPlhga8qvyJD87j4GkH/UX/dKhvPjrQ51uxYlixjihha6BdPHzjoInbFZFBCaw27YZ2GtBRuW8rckyAmDs+fqKTorv0o0u/egoj62ok6iuv4S22LrtncqiLN4WJUHJBUYZJYil/M284lp8XGJBbh6YgWLTckJUstzcsG7Qxtxn0OTuXmy+jhsqnYcpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EifkbgrsATayZrN7ehbRS9GnZOOBa+JzkTXm4afvdYY=;
 b=HUc3FwH3KVyPK67uqrscMVr4jsZ80dZw/lDXktf3H/E/XxN08dIXSH/ewcklVGRTUrCicd1Mwc7GqVJRh/eFbbMVbTyonmd6Ye3oMulXKm/ENrU2OESKUaR/5HYDs59UQniLjqrgndiYeL4H8B6cVazsnMCoqraA/JDJYIVuvinn6sjEHwsYc1DR2JDLboSSRovIutWcftFMFIkGij/qcAeWpeELHv534JyU95bNm8yKOKI02Mg64mzuMfNo0IM5wBHyttBLRplrrzI1YY7H0xVz4KNUderd9+24IF/BHImTVQodllsJgMGbTq4gsrmIaah3XZzq0isrseWUpDIHbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 18:06:28 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:27 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v3 13/15] iommu/amd: Use the generic iommu page table
Date: Mon, 16 Jun 2025 15:06:16 -0300
Message-ID: <13-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: bf03bb83-04d2-4f44-af11-08ddad008144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdsmT1UlmJhUBDUmqlNsYcWbUjvyWJ8L02/FWh2D4+0HSo3q+uTu5HMoXd5+?=
 =?us-ascii?Q?ptr6CKQfBX7TEYfKlwKayre6SlqBhr0UXd+FVQHHg5KqiII0MQ8ViuN8XiDk?=
 =?us-ascii?Q?8V6q11Lt5di37Wf6cGmCqxKVTNqZk34VMeONUs9mCK1uAw2RKLl79h8JNCQe?=
 =?us-ascii?Q?V3ozdvynI8bcglk5urAnat2bsTYeDVKEQ6JaxS6QG7Uw76I1iyo0LwAcaZTb?=
 =?us-ascii?Q?HSDwilcdK8aGwUTis+x7DL/dSdl3iubM/6Gz5AvB+BqyogCb0tvB/pzRKyG3?=
 =?us-ascii?Q?V4bmNateKXO3mAyLN4YZ3MvdnYpHcDUjTDfZTLAh8jiGsREFmn1sdJlWfbVz?=
 =?us-ascii?Q?G6YukrF/3n2XB0bWZ8OHzZTpgrx863RwzehXcQWw5UQXIU7PMyinFnueDQiC?=
 =?us-ascii?Q?5hRKp4BchyZa747faQJrrm+vbi2v95E2vK8u0O7BmQ9O3JQhPwNh+WgHUTrc?=
 =?us-ascii?Q?FtnJmuO2bXYPOI8kGQ9rqf2P/Yt2MYXK2DkdgZlZaZIowtNPcWqz3lqHfSyx?=
 =?us-ascii?Q?qvqrbG41LCZaD3ddsG8iVZ73Xmyaww90Ognvc1HDR7yhKuL5hijvNUwRjdsb?=
 =?us-ascii?Q?AV4aGDRT4hHFL97d/2uTJ2CFMnQ6X2SXxIdZ+yX4MvRQyz6IcnbcKycYGquQ?=
 =?us-ascii?Q?NlSnm35JFYyffyliPT8lYqn4w25VmGMLGqm1EXg44yhyy0VofAB5T93H9CD3?=
 =?us-ascii?Q?FTeKGHEnZvk0d39g6yUL/s/VczWUEdRakzJBTnbmiYw9G9pPUlom7bXk1/N7?=
 =?us-ascii?Q?SlxdQ4QvsRJtbnEhSpkC4GvGFutCsNBajo5qu5iSllMalXpXnCGFdZuO374r?=
 =?us-ascii?Q?wASgaJKBvYUpZikpqiR86FigNPxTm9XoXd3AnrmxIQtyVX+EmxdEfLQOU+wU?=
 =?us-ascii?Q?NunEAA5PCEwmoc5Zekr/0KyjYtgka5Zmzh2wvXta8xv9Sl9QTUDkfrofSymG?=
 =?us-ascii?Q?VOjJ/lvcw9npqZY/tjh4XNAOaZyNOusuh29KrZzM1giGEwk2LtAWW485YY1M?=
 =?us-ascii?Q?R5NZJRPRJ0d8sOB4NiuF7vPdqLrS8YlWVkZOSXU349X+V8VSmSal1uxwgoKj?=
 =?us-ascii?Q?J0zV3nFjUvHE55W5LpLyphIPqf1KgBJwP6HyXqmgkgrWrbpd/Jh40r0WSsyx?=
 =?us-ascii?Q?uXhCHLg0Ujxi/TfLKCkiL+4HG965cinuHJuvd47MARF3Yan/ezXxTjQfavIN?=
 =?us-ascii?Q?HDhwDKYt6a7e/D8hSZdlQhNxwamZTIOLmQXoxfkS9G94dBipj/Ir7bNKOBw0?=
 =?us-ascii?Q?40O3InKtcKRWGChsXllxt27lJAQlCuIxXLBv+RF27svXTR4n/gJ543W8x6Ts?=
 =?us-ascii?Q?ajHIl5dwJVKQUZL7QgQwzDyDx7hX+IBce9WgT7P0lea+tJUyJiEvEwMUdYaz?=
 =?us-ascii?Q?L5S7Bhye5O7XLggfCmn8Uzpgnd6WA+KbdrtdF8SUXR8VzYuRswOtkIwMrktD?=
 =?us-ascii?Q?MO5jIkAS09APJPPAs5eBTUUdfARgl6tB7oLiNYwma9broLaqVqo8+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPQmZG7kSw4l4yB1RlNRRDcOgQ79K02rtth7D/Euz3bk0fZiF7mJY7P8BFIl?=
 =?us-ascii?Q?uaKd5hPLmudrhzK+dEKbCBxdTTBdMvTNvTEegAOwXcOK4W+HQB8PffQQxDLO?=
 =?us-ascii?Q?vOD722NFSGq6rt1ktpxFLf1X1c2AoHe8XU6XalzIza7d3VBWOPhb+AxVvod3?=
 =?us-ascii?Q?jJc0wkx2Mq5kZG+C2FD/SIPkROT39C6soI0QWxC1YPZe3KzdeTMaqQFmM/s5?=
 =?us-ascii?Q?wlRwwJfPIuoMWZdqN3rpzW7TtLAXbXxcqJfnK2cXP/fWGo2esshEPAafg5dg?=
 =?us-ascii?Q?WWBDnoiS5m73SjzrTGtunCtDIMb/kjYnAUYMr6QAV7vtFjSW/kGKN0ywYMIs?=
 =?us-ascii?Q?EjmLr/ofJO03/3ifjJKhPWIUPDGls9TEw9UXHCSjkDid4k50Fgl60u57nSo0?=
 =?us-ascii?Q?aOyJcDUCXtilfbXPMEnuaz227JM2+Z3gjwKQ+W8IbeHhbl/fu7zDjmAYK0II?=
 =?us-ascii?Q?YxI0GOtAMkPW1sd6ZYQlKiKqP36ArgBa0BG7WT+bBaq3eH/h6MnK4SfDpN6z?=
 =?us-ascii?Q?b0u1B3Os1pY4ZjXBkGKooYIBK87oCx1SxYdSXGZfJ/IvHC8Ehy+ZOTGPR6C2?=
 =?us-ascii?Q?PdlT+XXeGvYPkWofam7SDymo/DOzInYt1HlFZjrexO0wdHy9MNpTBKFCxObr?=
 =?us-ascii?Q?lherc35myNHxilA2FHdobYPpz4yqKlIUabj3aSMGHRhpNr9A82Jx0D4/mg+t?=
 =?us-ascii?Q?kiO7AujRYXIJCs70VYI3Qgn1hcPQ58bIF9aofqqp5hR34RCpgytsJnNfeeJs?=
 =?us-ascii?Q?F/dFILAVPUrnW2/wt5nlu1TLZpIv6uFmE1/uqj+6oEaMbjiLr5IhNjdQE+5o?=
 =?us-ascii?Q?NQBIkg+d2zRvw0RAfYlpOI5qPzi5xFZQMqmiEstxA2/8A06Z/2+xxjHCu/Hz?=
 =?us-ascii?Q?pGucRPZyReSK3uQVE8QyCzmXlgxrXZpFroCpEEgGEpvPfj9+ElvwmSvrPMKh?=
 =?us-ascii?Q?YxQdVbmsL6UlITrlV1gEnKBjyzf6EFjPoxyq3Wk9KghjX1EeXEGCQdFhc5I+?=
 =?us-ascii?Q?+3QmEEKkQXPjmLkXXmd/lRhw5kaiLtqBZ9YxqctKjCqvbqSclkEnhjk6dgO5?=
 =?us-ascii?Q?lT4ZiXN8U9v9VI4ills94hS56K2LOSlNnURQ5QiXaSSKq4iqtrdzqDNdeq+D?=
 =?us-ascii?Q?h/AgjLDvTi94uTu5x920OYzju7lDBXRC/LWJUSBkeceKJ91iScYy2IA4pMkk?=
 =?us-ascii?Q?XXsqHHEdl3xWLTU+spvIU7EGCi8IaDO4VSyAbZB6e6auKCCxOEdhqDJeW4eY?=
 =?us-ascii?Q?Ty0Yk4EPX9f8NhNxSb3RnLU1WEIwkOsJ4GrW5k9kc/aLKsGSBhoCXcFIKTDu?=
 =?us-ascii?Q?aE3BatRsdgWeivQ0u0JQCX+CICEieLagRVd6a/ecpP7t2AKr/dS0C/j42i7n?=
 =?us-ascii?Q?+u1KyVeTkWbHVZ1WfprvmEgbbAKNTQyGqGDs29UOeJIJYYJjkTIacFe++Bw6?=
 =?us-ascii?Q?VmeLVPHp+4Kh16DYeGQG4+c9dlh0tby/e59b/57kUWxz0pOO2ChQteEAxC9s?=
 =?us-ascii?Q?2pzvJM0A6H/mi3hVkdV+Qwler8gGzroN50rukIhlh8UaCCLuuzuPcB1KfrUB?=
 =?us-ascii?Q?lOiA3EU9sWbk0n2YAaAwOSz/iQXSzncYZKx25nWv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf03bb83-04d2-4f44-af11-08ddad008144
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:24.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rd4CQLXWsNZH9KWEmlW6xIlsGijELxgQYk0DekU3GQFFWWfdQC1IpizhwUxX6AK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Replace the io_pgtable versions with pt_iommu versions. The v2 page table
uses the x86 implementation that will be eventually shared with VT-D.

This supports the same special features as the original code:
 - increase_top for the v1 format to allow scaling from 3 to 6 levels
 - non-present flushing
 - Dirty tracking for v1 only
 - __sme_set() to adjust the PTEs for CC
 - Optimization for flushing with virtualization to minimize the range
 - amd_iommu_pgsize_bitmap override of the native page sizes
 - page tables allocate from the device's NUMA node

Rework the domain ops so that v1/v2 get their own ops. Make dedicated
allocation functions for v1 and v2. Hook up invalidation for a top change
to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
that becomes unused in this patch. The next patch will delete the rest of
it.

This fixes a race bug in AMD's increase_address_space() implementation. It
stores the top level and top pointer in different memory, which prevents
other threads from reading a coherent version:

   increase_address_space()   alloc_pte()
                                level = pgtable->mode - 1;
	pgtable->root  = pte;
	pgtable->mode += 1;
                                pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];

The iommupt version is careful to put mode and root under a single
READ_ONCE and then is careful to only READ_ONCE a single time per
walk.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig           |   5 +-
 drivers/iommu/amd/amd_iommu.h       |   1 -
 drivers/iommu/amd/amd_iommu_types.h |  12 +-
 drivers/iommu/amd/io_pgtable.c      |   1 -
 drivers/iommu/amd/iommu.c           | 516 ++++++++++++++--------------
 5 files changed, 264 insertions(+), 271 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 994063e5586f0f..9f3e3ebd49a201 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,10 +10,13 @@ config AMD_IOMMU
 	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	select IOMMU_PT_X86_64
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 29a8864381c359..fa78df2cea4d44 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -86,7 +86,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * the IOMMU used by this driver.
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ccbab3a4811adf..08b105536a8e5e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/generic_pt/iommu.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -583,9 +584,13 @@ struct pdom_iommu_info {
  * independent of their use.
  */
 struct protection_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+		struct pt_iommu_x86_64 amdv2;
+	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct iommu_domain domain; /* generic domain handle used by
-				       iommu core code */
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
@@ -596,6 +601,9 @@ struct protection_domain {
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
 /*
  * This structure contains information about one PCI segment in the system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 4d308c07113495..e4b33eba554599 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -132,7 +132,6 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	pgtable->root  = pte;
 	pgtable->mode += 1;
-	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
 	ret = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1baa9d3583f369..8e749f60f7a7a5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -28,7 +28,6 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
-#include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
@@ -39,9 +38,9 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
-#include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -58,7 +57,6 @@ LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
-static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
@@ -79,11 +77,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data);
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level);
+
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level);
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
 static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
+static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
+					bool enable);
 
 /****************************************************************************
  *
@@ -1761,42 +1766,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
-/* Flush the not present cache if it exists */
-static void domain_flush_np_cache(struct protection_domain *domain,
-		dma_addr_t iova, size_t size)
-{
-	if (unlikely(amd_iommu_np_cache)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&domain->lock, flags);
-		amd_iommu_domain_flush_pages(domain, iova, size);
-		spin_unlock_irqrestore(&domain->lock, flags);
-	}
-}
-
-
-/*
- * This function flushes the DTEs for all devices in domain
- */
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	lockdep_assert_held(&domain->lock);
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-
-	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(domain);
-}
-
 int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
@@ -2056,7 +2025,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;
 	u32 old_domid;
@@ -2065,19 +2035,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
-
-	if (gcr3_info && gcr3_info->gcr3_tbl)
-		domid = dev_data->gcr3_info.domid;
-	else
-		domid = domain->id;
+	struct pt_iommu_amdv1_hw_info pt_info;
 
 	make_clear_dte(dev_data, dte, &new);
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		domid = dev_data->gcr3_info.domid;
+	else {
+		domid = domain->id;
 
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
+		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
+			/*
+			 * When updating the IO pagetable, the new top and level
+			 * are provided as parameters. For other operations i.e.
+			 * device attach, retrieve the current pagetable info
+			 * via the IOMMU PT API.
+			 */
+			if (top_paddr) {
+				pt_info.host_pt_root = top_paddr;
+				pt_info.mode = top_level + 1;
+			} else {
+				WARN_ON(top_paddr || top_level);
+				pt_iommu_amdv1_hw_info(&domain->amdv1,
+						       &pt_info);
+			}
+
+			new.data[0] |= pt_info.host_pt_root |
+				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
+					       << DEV_ENTRY_MODE_SHIFT;
+		}
+	}
 
 	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
@@ -2143,7 +2130,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (set)
-		set_dte_entry(iommu, dev_data);
+		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
 
@@ -2161,6 +2148,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int max_pasids = dev_data->max_pasids;
+	struct pt_iommu_x86_64_hw_info pt_info;
 	int ret = 0;
 
 	 /*
@@ -2183,7 +2171,8 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (!pdom_is_v2_pgtbl_mode(pdom))
 		return ret;
 
-	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
+	ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
@@ -2498,62 +2487,113 @@ struct protection_domain *protection_domain_alloc(void)
 	return domain;
 }
 
-static int pdom_setup_pgtable(struct protection_domain *domain,
-			      struct device *dev)
-{
-	struct io_pgtable_ops *pgtbl_ops;
-	enum io_pgtable_fmt fmt;
-
-	switch (domain->pd_mode) {
-	case PD_MODE_V1:
-		fmt = AMD_IOMMU_V1;
-		break;
-	case PD_MODE_V2:
-		fmt = AMD_IOMMU_V2;
-		break;
-	}
-
-	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &domain->iop.pgtbl.cfg, domain);
-	if (!pgtbl_ops)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline u64 dma_max_address(enum protection_domain_mode pgtable)
-{
-	if (pgtable == PD_MODE_V1)
-		return ~0ULL;
-
-	/*
-	 * V2 with 4/5 level page table. Note that "2.2.6.5 AMD64 4-Kbyte Page
-	 * Translation" shows that the V2 table sign extends the top of the
-	 * address space creating a reserved region in the middle of the
-	 * translation, just like the CPU does. Further Vasant says the docs are
-	 * incomplete and this only applies to non-zero PASIDs. If the AMDv2
-	 * page table is assigned to the 0 PASID then there is no sign extension
-	 * check.
-	 *
-	 * Since the IOMMU must have a fixed geometry, and the core code does
-	 * not understand sign extended addressing, we have to chop off the high
-	 * bit to get consistent behavior with attachments of the domain to any
-	 * PASID.
-	 */
-	return ((1ULL << (PM_LEVEL_SHIFT(amd_iommu_gpt_level) - 1)) - 1);
-}
-
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-static struct iommu_domain *
-do_iommu_domain_alloc(struct device *dev, u32 flags,
-		      enum protection_domain_mode pgtable)
+static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 {
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct protection_domain *pdom =
+		container_of(iommupt, struct protection_domain, iommu);
+
+	return &pdom->lock;
+}
+
+/*
+ * Update all HW references to the domain with a new pgtable configuration.
+ */
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level)
+{
+	struct protection_domain *pdom =
+		container_of(iommu_table, struct protection_domain, iommu);
+	struct iommu_dev_data *dev_data;
+
+	lockdep_assert_held(&pdom->lock);
+
+	/* Update the DTE for all devices attached to this domain */
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		/* Update the HW references with the new level and top ptr */
+		set_dte_entry(iommu, dev_data, top_paddr, top_level);
+		clone_aliases(iommu, dev_data->dev);
+	}
+
+	list_for_each_entry(dev_data, &pdom->dev_list, list)
+		device_flush_dte(dev_data);
+
+	domain_flush_complete(pdom);
+}
+
+/*
+ * amd_iommu_iotlb_sync_map() is used to generate flushes for non-present to
+ * present (ie mapping) operations. It is a NOP if the IOMMU doesn't have non
+ * present caching (like hypervisor shadowing).
+ */
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
+
+	if (likely(!amd_iommu_np_cache))
+		return 0;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_pages(domain, iova, size);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return 0;
+}
+
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_all(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
+	spin_unlock_irqrestore(&dom->lock, flags);
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct pt_iommu_flush_ops amd_hw_flush_ops_v1 = {
+	.get_top_lock = amd_iommu_get_top_lock,
+	.change_top = amd_iommu_change_top,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
+};
+
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
 	int ret;
 
@@ -2561,25 +2601,113 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->pd_mode = pgtable;
-	ret = pdom_setup_pgtable(domain, dev);
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.hw_flush_ops = &amd_hw_flush_ops_v1;
+	domain->iommu.nid = dev_to_node(dev);
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		domain->domain.dirty_ops = &amdv1_dirty_ops;
+
+	/*
+	 * Someday FORCE_COHERENCE should be set by
+	 * amd_iommu_enforce_cache_coherency() like VT-D does.
+	 */
+	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * multiple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	cfg.common.hw_max_vasz_lg2 = 64;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	domain->domain.ops = &amdv1_ops;
+
+	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
 	if (ret) {
-		pdom_id_free(domain->id);
-		kfree(domain);
+		amd_iommu_domain_free(&domain->domain);
 		return ERR_PTR(ret);
 	}
 
-	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
-	domain->domain.geometry.force_aperture = true;
-	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
+	/*
+	 * Narrow the supported page sizes to those selected by the kernel
+	 * command line.
+	 */
+	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
+	return &domain->domain;
+}
 
-	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = iommu->iommu.ops->default_domain_ops;
+static const struct iommu_domain_ops amdv2_ops = {
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	/*
+	 * Note the AMDv2 page table format does not support a Force Coherency
+	 * bit, so enforce_cache_coherency should not be set. However VFIO is
+	 * not prepared to handle a case where some domains will support
+	 * enforcement and others do not. VFIO and iommufd will have to be fixed
+	 * before it can fully use the V2 page table. See the comment in
+	 * iommufd_hwpt_paging_alloc(). For now leave things as they have
+	 * historically been and lie about enforce_cache_coherencey.
+	 */
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
 
-	if (dirty_tracking)
-		domain->domain.dirty_ops = &amd_dirty_ops;
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_x86_64_cfg cfg = {};
+	struct protection_domain *domain;
+	int ret;
 
+	domain = protection_domain_alloc();
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	domain->pd_mode = PD_MODE_V2;
+	domain->iommu.nid = dev_to_node(dev);
+
+	cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	/*
+	 * The v2 table behaves differently if it is attached to PASID 0 vs a
+	 * non-zero PASID. On PASID 0 it has no sign extension and the full
+	 * 57/48 bits decode the lower addresses. Otherwise it behaves like a
+	 * normal sign extended x86 page table. Since we want the domain to work
+	 * in both modes the top bit is removed and PT_FEAT_SIGN_EXTEND is not
+	 * set which creates a table that is compatible in both modes.
+	 */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		cfg.common.hw_max_vasz_lg2 = 56;
+	else
+		cfg.common.hw_max_vasz_lg2 = 47;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	domain->domain.ops = &amdv2_ops;
+
+	ret = pt_iommu_x86_64_init(&domain->amdv2, &cfg, GFP_KERNEL);
+	if (ret) {
+		amd_iommu_domain_free(&domain->domain);
+		return ERR_PTR(ret);
+	}
 	return &domain->domain;
 }
 
@@ -2600,15 +2728,17 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
 		if (!amd_iommu_pasid_supported())
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
 	case 0:
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		if (amd_iommu_pgtable == PD_MODE_V1)
+			return amd_iommu_domain_alloc_paging_v1(dev, flags);
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
 	default:
 		break;
 	}
@@ -2620,8 +2750,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 
 	WARN_ON(!list_empty(&domain->dev_list));
-	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+	pt_iommu_deinit(&domain->iommu);
 	pdom_id_free(domain->id);
 	kfree(domain);
 }
@@ -2726,93 +2855,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				    unsigned long iova, size_t size)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	if (ops->map_pages)
-		domain_flush_np_cache(domain, iova, size);
-	return 0;
-}
-
-static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
-			       phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			       int iommu_prot, gfp_t gfp, size_t *mapped)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	int prot = 0;
-	int ret = -EINVAL;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return -EINVAL;
-
-	if (iommu_prot & IOMMU_READ)
-		prot |= IOMMU_PROT_IR;
-	if (iommu_prot & IOMMU_WRITE)
-		prot |= IOMMU_PROT_IW;
-
-	if (ops->map_pages) {
-		ret = ops->map_pages(ops, iova, paddr, pgsize,
-				     pgcount, prot, gfp, mapped);
-	}
-
-	return ret;
-}
-
-static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
-					    struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t size)
-{
-	/*
-	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
-	 * Unless we run in a virtual machine, which can be inferred according
-	 * to whether "non-present cache" is on, it is probably best to prefer
-	 * (potentially) too extensive TLB flushing (i.e., more misses) over
-	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
-	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
-	 * the guest, and the trade-off is different: unnecessary TLB flushes
-	 * should be avoided.
-	 */
-	if (amd_iommu_np_cache &&
-	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
-		iommu_iotlb_sync(domain, gather);
-
-	iommu_iotlb_gather_add_range(gather, iova, size);
-}
-
-static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova,
-				    size_t pgsize, size_t pgcount,
-				    struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	size_t r;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return 0;
-
-	r = (ops->unmap_pages) ? ops->unmap_pages(ops, iova, pgsize, pgcount, NULL) : 0;
-
-	if (r)
-		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
-
-	return r;
-}
-
-static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-					  dma_addr_t iova)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	return ops->iova_to_phys(ops, iova);
-}
-
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -2879,28 +2921,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
-					  unsigned long iova, size_t size,
-					  unsigned long flags,
-					  struct iommu_dirty_bitmap *dirty)
-{
-	struct protection_domain *pdomain = to_pdomain(domain);
-	struct io_pgtable_ops *ops = &pdomain->iop.pgtbl.ops;
-	unsigned long lflags;
-
-	if (!ops || !ops->read_and_clear_dirty)
-		return -EOPNOTSUPP;
-
-	spin_lock_irqsave(&pdomain->lock, lflags);
-	if (!pdomain->dirty_tracking && dirty->bitmap) {
-		spin_unlock_irqrestore(&pdomain->lock, lflags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&pdomain->lock, lflags);
-
-	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
-}
-
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
@@ -2970,28 +2990,6 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
-static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_all(dom);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
-static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_pages(dom, gather->start,
-				     gather->end - gather->start + 1);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -3026,11 +3024,6 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-static const struct iommu_dirty_ops amd_dirty_ops = {
-	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
-	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
-};
-
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
@@ -3045,17 +3038,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.is_attach_deferred = amd_iommu_is_attach_deferred,
 	.def_domain_type = amd_iommu_def_domain_type,
 	.page_response = amd_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
-		.map_pages	= amd_iommu_map_pages,
-		.unmap_pages	= amd_iommu_unmap_pages,
-		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-		.iova_to_phys	= amd_iommu_iova_to_phys,
-		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-		.iotlb_sync	= amd_iommu_iotlb_sync,
-		.free		= amd_iommu_domain_free,
-		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
 };
 
 #ifdef CONFIG_IRQ_REMAP
@@ -4034,3 +4016,5 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 #endif
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


