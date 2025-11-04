Return-Path: <linux-kselftest+bounces-44743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE61C32AD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271C2425094
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B541B340298;
	Tue,  4 Nov 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N51mDZiv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB688340A70;
	Tue,  4 Nov 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281041; cv=fail; b=ZuyrX6dzyxArp9oIORD8QL7hd8SUqtgj1QVj8m8rZBLHlwa/ltNw5niKKqBh8TEBUFlVoX9RcdyvqJGnVvkdOrA1FW4PHRQshKftw5OEAyEXexwhsAZ/TZ0qyLkBuRzVi3RjLd1CUhIYLdXwcBZDRpB1Y3/dyYBYsWYSi74R+yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281041; c=relaxed/simple;
	bh=LKSJXEiY/vEsT6dIcOTb3sAETST/+dKm/b5WV6q1Leo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EStSt/ye9JasYrTPFcSPGCRSJEpGRDsopuz5yIMBy0NTNLQ2fj2yCp+mMd1cqk3FC3kNDnpP4RgtD7tyZijAZmJUumRXCT2SqvU006kTYZf94Y3gioRwjJfvrA1wX+mfElWg1/IGmxalkOAfMqXdeWCIn20LRsAuL0IEJUOoRNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N51mDZiv; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD8ERgZiz7GzlH69Eu6TYfaz0YKTPDOVFRkucnr+Ch0hhkcUnSKgigOAUowvJ96RKk5u6awUsH9OG0J7k3v2HVhcJ34i0zLIUIHJ0SJbsxI1ssxkFfTXqz2dngvYvt1PNVxEBwlOAb9Wod0jOipam4DgW+gmwbvQ0xXvZhTgsGK0uCevCeHSl0hRNv9MweHs5OV6SkFXVtFLCjCOXuntnKDCgh5ueWNW3qu8Wqx61dPXhpJnxPsMBwOW0lXoA/Aq5SkXVaCoIXN9MEfCk2ZEimePCib4UfkWZip9kQFx3q9DOG9djjUJSvCABE0uvcHza3yx5RmacZXfxu3sgrBV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTIbTFikbsip3TFCmP6eqg5dVrecj8/mDRywcc7mvb4=;
 b=yx2n8rWzfWRPabvK4wMIXjFqtEKzOCoRiIUH+eVLuVdTKlUXzeyAldy62D/9In2oTvvsl8I6VqKUuuSZvw6wldisoVON5oyk7/aJs6PkbOVsFFXgIYxYDWCDJa0uMHV4CBTTGgFggResYhbgoS4qWGaQ07Oo1IMV+PCfIM7G+Lv+GWMF+d4POTRupOtUEHvPdyVNutqaZRJu3kfrQs6mke9UAp1uvIKzjlfZYZJA7EZ5ci4lChE3hWX+ngNQJovgDCmCuoeBzoKfRJjww2h0wWPdil7jacSN5RFNIE5yJHbzkTgRV9Ar5rPxTMi3Tuwd+T1pjauswCmyef7o5Kd/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTIbTFikbsip3TFCmP6eqg5dVrecj8/mDRywcc7mvb4=;
 b=N51mDZivZw4jE+0zYeyEUF4E71REeewOEo8iYEsxt6x8QkyqX5fDBqMlDmgJk16ZdqSPMgYr9nEl8gm8A3kqI/SQSjMuIx7wC5mGxD/43Hz0o7BMZFvlA3rB7IpvgPnkwhP1mo8taBOK5WYrXcsfLUAwr+UH/znSUknCtPkbxfbYAEQI5ZSeHS65BYSPU3egWGIpZUvch1hTIXDN1qgt6hFe8fgYVsFGByJdumT2UHRPk0T8E5XPGhF1nDRFZVzc45js/jA01idXB51opN+U4YCEM5thNmmYQmTOx/+vjqgaCOg7cIWMhUa9O0YFwi2/k/Zm5jhdXfvHyQDgdtl7jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:20 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 13/15] iommu/amd: Use the generic iommu page table
Date: Tue,  4 Nov 2025 14:30:11 -0400
Message-ID: <13-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c03d581-41fe-43ac-dc34-08de1bd0339f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJmhNAe7kHlSZdvQvRMXThQN5mKjXk7BAEkRzUUJa1tw8wCXh61mkqiTUuhl?=
 =?us-ascii?Q?N+4irTl3Zq19pvviWBY3ju5QV88bfvKy1OlHaTOBjdOShgBh0myCC4PcDNpX?=
 =?us-ascii?Q?2BmeJxpPdS750nMTOBbQc8rCXmwznEIYwyCW1IqiX4Wy6THju2sS/P9HZDZD?=
 =?us-ascii?Q?VenPSBxfDvlhtcOObvY3hf+FhOlnC6crSTZHoc7S2+Ip2rdJKSxSNnYETUDn?=
 =?us-ascii?Q?mrbjlJAgv+srz4bQ8mApP8cxsyjECxlW1w4roLdeBagwCIukJkgKSNAeBBXD?=
 =?us-ascii?Q?SYmkz7aDLwFga+jcDadBnUOREYN/sHshszxBvTBQjbF0mIWIhxyLXo/tVA3X?=
 =?us-ascii?Q?46WbO+3Ysu17zU6ILOxVqs7ii2y5neFi7yojuPnP4CrZ1dYxZq2o8zcqBhQV?=
 =?us-ascii?Q?+qbuPPryhOeJKsIh5O/8sirAv4+IVfa2A32kOykIN45E7QTzjr4JcO+1x72n?=
 =?us-ascii?Q?dRUVzz22iMcsidhpvW3Eox3xxXMkgmRutvlRpRFWmfUegbalt25mvJanVJDi?=
 =?us-ascii?Q?SiPDzmgIsBCh+qjuckzf8+TcCQ5mKqqKBQXLi6C9e7PE36pfH4fQ1ro1qSKD?=
 =?us-ascii?Q?H8HiqT+vJ6FKVpwQXq9nb0rlRe1q4JihzdGNpyflzPzUkQcs5OMp/FTaNtua?=
 =?us-ascii?Q?faeagekkqmQIRosq8jIVkjzejCJIHJb4V9g6T9TB8Kb0fswy4L2Ba4fYuBFS?=
 =?us-ascii?Q?KxW1Y3o9yUxihEGmwbFxTF/7NWjAx/w/a10VK4pZuBZpsiItiDZSbkXNXHHQ?=
 =?us-ascii?Q?Vyb2BWL9ofhJCedfPByECYUf7+c1uNE44n7K0e3v8eLnqptxRTDYc/k/YF4k?=
 =?us-ascii?Q?PSKHtM0iP567EuiAj3tlpF3J3nF9UwBmAg3p7vzIBGBWQgYb3SeVMTA8WHnA?=
 =?us-ascii?Q?2LbfpiRqQeBINPl5+jb3gsU8Uk0xab9RRWg6CCc0HWpCbT/1mVjo82bJeqlB?=
 =?us-ascii?Q?0Dp80luBnayMZ5nDVKOYRWboYTBVszZFnGs9TCcFXA/ZG/fsHXvp70uj0XNV?=
 =?us-ascii?Q?G71R9+Kh+yGt5DgeO0Ly/eHz0bmNRBZZRLC4Pr28wMQWidE6AK+L3NLBxYew?=
 =?us-ascii?Q?cQ47c21gs/reGmPcKTS86C23sF+e1ouvbmzApfg1up1g3y9Bg7cZz2Qa5aE3?=
 =?us-ascii?Q?f9y/6XvgDltYJqhVgmKBCqoQgjeM1isDct+cJPE63s1iIOcJjRwxnWfT5Ol/?=
 =?us-ascii?Q?pTJKuv8qrYwdb6sk/3cU+seMPYTRE9LY/CkzO2xbmN+hto4/nI6imJIGafTE?=
 =?us-ascii?Q?ElAFGj3161d4RJNBmXqxaxTAFwS3PWTf8zDW6jjuku3b6WJwlglLjlY6wK2P?=
 =?us-ascii?Q?00aQPwPDMAO8H2Xc6rx59a8q6SgqoDpbIisNy2Y9JTgEj8q3codUovWzdK/Q?=
 =?us-ascii?Q?c2/58XfgUC0QqTTDlKuoUmllIPqF+YdN4IP4BAyOgC8HS5nNQ/LPcWfMMFvM?=
 =?us-ascii?Q?ITDnmUZwK9oEgCbJB7vDDn98qMDk+hfpSINb4vJKqMYTYBMB7bATRGacizGd?=
 =?us-ascii?Q?O5c2F/gMoslRigg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QXls+Cu4kEWCiyXKRANJFmRGJH2mSvrBhhRF1O0CCAeFzhmxFS/KV7qJRzA/?=
 =?us-ascii?Q?85dKwkdYs/8AU3JrQUz/klPrWNnHDnlDkoXtNT98HcU0ghFl+hLKB1wN2ooN?=
 =?us-ascii?Q?msrUKdNAio3UKHY03f0EYamm5fE0+VJK//86+40nhzGraPnDYNDHB7tjmLhj?=
 =?us-ascii?Q?G6phuWhWWP6sC8YyoHe1lqD7KE+m+mZTTt/UsG2TFVM5PSvBv99zTAQRBNgm?=
 =?us-ascii?Q?Mf1tfTddB9HmGFDp4v+FIuR4yuLP8CZhwgzVs+GNVCJUbxvPF70LRmdsGDC9?=
 =?us-ascii?Q?HD9EeO8cho/cQ4Za8JIAa+/c5KS48zF1a3JzcAj2jwm8o9L2D4hiZG6tmdC6?=
 =?us-ascii?Q?+ZOLvPUlm53yqyEdVrXXv/lfGpCTMPyEqqyYrgi+63fgEpvz78BsK6paUCkG?=
 =?us-ascii?Q?0rSJGMDjLMcygfP0+yMmkBbKdk0H3/w/fljEhnKRV4fB+ETxmlViHJlKtZ0U?=
 =?us-ascii?Q?5Wl7qEtpcMGVEXrQ28g/lRkTASFTl2PRYfdY6qKPlsV29ZE1MNw6ThyV3/np?=
 =?us-ascii?Q?m0QNLGzCxTwLOzZTJ+whUp8DSOg+vBBiLwmXyO/mI7LkeX5kgsy0IR6+Fsbv?=
 =?us-ascii?Q?ABbKoIl9BKFdrlrWtI7zEEi/ABpmKAwUyLBNQ/L8H9iZwQLgTn6WxTpFedLh?=
 =?us-ascii?Q?gcFSJfSJENKbANAS4G7j3HzHvn6NP7TiYyBbtJqNSLyfUh4F+dEoTLIXEKHe?=
 =?us-ascii?Q?03CXkz+IeWQcheNJdEKSeQ8NC7BBdDUtS7EYZntWZUP+nSSrnQQZg4Op+Rme?=
 =?us-ascii?Q?TLEwyUWoprh3E69+tBjpsDBK7vczgSeewygtbA5JoYhGUEPOf5n6SvrGyaZG?=
 =?us-ascii?Q?ckpWveUuGRIHCisgxIGlWelovIOoBL0XUQWXbFAKXVUZWZ8WY6SIir/Nxj2Q?=
 =?us-ascii?Q?TJYam1ZQgHMsYz9fq6WsYn0oL7XSQ5BelRDzEufmcohyIHsMXNqghmSe3MQl?=
 =?us-ascii?Q?V8RaNQxPptWvq89bVEwdJy/043XahvmS7raiwLhWkPlT683VsbtoZ2Ean6af?=
 =?us-ascii?Q?7Jlfgv+9QOPe9d/8RC6nfJP2tnZQMHe6AMKpPNcaA35U0QsdV9aEmJ7iiq/3?=
 =?us-ascii?Q?ZRfwxrWH00EMQGes5TwmLtDK/BiLcLO4GLCezY7T3opfpnZW9Q8aT4PyPBur?=
 =?us-ascii?Q?HpSeTU4XEuYRgt1Zq3FBnClvoNKNcodRZ69tq1ijRixxnerIiEfWVJqkCEm/?=
 =?us-ascii?Q?5ZlYDrUZWTxldgoTt2qj74SZqWtAdzH1pJzkEcf+BjCtRb+ocTunmZB09CC1?=
 =?us-ascii?Q?yPqyd0rVFuGz2bEKrSClYqppmkpu64hX5zdbvWomeTjJyczsIp7XdpUIK+eG?=
 =?us-ascii?Q?cMv9YzxMf5wN/djzeYCxHU93QTvxpUPcS38yTFveWz+p5tQ6xYss/qpEcyk2?=
 =?us-ascii?Q?gq46vjW6rNNdfiNKBfUIgJt7kvqT9suJKrwhlt9IEm24gylrYsyakre1p737?=
 =?us-ascii?Q?sEaamONmB4jVJYRxB1YRhCuzwrRbUJBQbEEZMDTdUHBsa3EUSCcUJnsVjNVN?=
 =?us-ascii?Q?qAc4zLst+iznQEb0p28Dyd6/+GEXsShP/LFl4dTZiG5guywrwLXZxNWYSK6N?=
 =?us-ascii?Q?Z2xaA29ZmgsFDUibOL4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c03d581-41fe-43ac-dc34-08de1bd0339f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:16.8883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkptgiEbw5aBH0oc/B+jPqLopH0ImH66txd6FoylFsRlQNvXZejQ8fbVkO2nIOLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Replace the io_pgtable versions with pt_iommu versions. The v2 page table
uses the x86 implementation that will be eventually shared with VT-d.

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
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig           |   5 +-
 drivers/iommu/amd/amd_iommu.h       |   1 -
 drivers/iommu/amd/amd_iommu_types.h |  12 +-
 drivers/iommu/amd/io_pgtable.c      |   2 -
 drivers/iommu/amd/iommu.c           | 538 ++++++++++++++--------------
 5 files changed, 282 insertions(+), 276 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index ecef69c11144db..f2acf471cb5d9f 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -11,10 +11,13 @@ config AMD_IOMMU
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
index 9b4b589a54b57e..25044d28f28a8d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -88,7 +88,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * the IOMMU used by this driver.
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a698a2e7ce2a6e..d90a285b44eb3a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/generic_pt/iommu.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -589,9 +590,13 @@ struct pdom_iommu_info {
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
@@ -602,6 +607,9 @@ struct protection_domain {
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
 /*
  * This structure contains information about one PCI segment in the system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 70c2f5b1631b05..f64244938c9af7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -136,8 +136,6 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 	pgtable->mode += 1;
 	write_seqcount_end(&pgtable->seqcount);
 
-	amd_iommu_update_and_flush_device_table(domain);
-
 	pte = NULL;
 	ret = true;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1cee8..0dc4d9682000bf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -30,7 +30,6 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
-#include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
@@ -41,9 +40,9 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
-#include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -60,7 +59,6 @@ LIST_HEAD(hpet_map);
 LIST_HEAD(acpihid_map);
 
 const struct iommu_ops amd_iommu_ops;
-static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
@@ -74,11 +72,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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
@@ -1756,42 +1761,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
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
@@ -2051,7 +2020,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;
 	u32 old_domid;
@@ -2060,19 +2030,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
+			new.data[0] |= __sme_set(pt_info.host_pt_root) |
+				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
+					       << DEV_ENTRY_MODE_SHIFT;
+		}
+	}
 
 	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
@@ -2138,7 +2125,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (set)
-		set_dte_entry(iommu, dev_data);
+		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
 
@@ -2156,6 +2143,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int max_pasids = dev_data->max_pasids;
+	struct pt_iommu_x86_64_hw_info pt_info;
 	int ret = 0;
 
 	 /*
@@ -2178,7 +2166,8 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (!pdom_is_v2_pgtbl_mode(pdom))
 		return ret;
 
-	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
+	ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
@@ -2500,54 +2489,6 @@ struct protection_domain *protection_domain_alloc(void)
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
-	case PD_MODE_NONE:
-		WARN_ON_ONCE(1);
-		return -EPERM;
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
-		return PM_LEVEL_SIZE(amd_iommu_hpt_level);
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
 	if (amd_iommu_hatdis)
@@ -2556,38 +2497,229 @@ static bool amd_iommu_hd_support(struct amd_iommu *iommu)
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
+static const struct pt_iommu_driver_ops amd_hw_driver_ops_v1 = {
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
 
+	if (amd_iommu_hatdis)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	domain = protection_domain_alloc();
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->pd_mode = pgtable;
-	ret = pdom_setup_pgtable(domain, dev);
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.driver_ops = &amd_hw_driver_ops_v1;
+	domain->iommu.nid = dev_to_node(dev);
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		domain->domain.dirty_ops = &amdv1_dirty_ops;
+
+	/*
+	 * Someday FORCE_COHERENCE should be set by
+	 * amd_iommu_enforce_cache_coherency() like VT-d does.
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
+	cfg.common.hw_max_vasz_lg2 =
+		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
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
 
+	if (!amd_iommu_v2_pgtbl_supported())
+		return ERR_PTR(-EOPNOTSUPP);
+
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
 
@@ -2608,15 +2740,27 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
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
-	case 0:
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
+	case 0: {
+		struct iommu_domain *ret;
+
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		if (amd_iommu_pgtable == PD_MODE_V1) {
+			ret = amd_iommu_domain_alloc_paging_v1(dev, flags);
+			if (ret != ERR_PTR(-EOPNOTSUPP))
+				return ret;
+			return amd_iommu_domain_alloc_paging_v2(dev, flags);
+		}
+		ret = amd_iommu_domain_alloc_paging_v2(dev, flags);
+		if (ret != ERR_PTR(-EOPNOTSUPP))
+			return ret;
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
+	}
 	default:
 		break;
 	}
@@ -2628,8 +2772,7 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 
 	WARN_ON(!list_empty(&domain->dev_list));
-	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+	pt_iommu_deinit(&domain->iommu);
 	pdom_id_free(domain->id);
 	kfree(domain);
 }
@@ -2734,93 +2877,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
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
@@ -2887,28 +2943,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
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
@@ -2978,28 +3012,6 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
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
@@ -3034,11 +3046,6 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
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
@@ -3053,17 +3060,6 @@ const struct iommu_ops amd_iommu_ops = {
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
@@ -4072,3 +4068,5 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 #endif
+
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


