Return-Path: <linux-kselftest+bounces-44734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8020C32A5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 565D134CBD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBC6335097;
	Tue,  4 Nov 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOcGx5Vy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A731691F;
	Tue,  4 Nov 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281030; cv=fail; b=Y+pp31i5auCK/c0huDPoxPjf70zSIlgpLbxJwTWffrKXPWuhcCeZUWzEATzXtXP6axGn6F+cMqDJhNSKwEv9F9aqrG3SZY1fFKg4zJWTRPrZioYzjrGgIt4DJQkf38jk4kOTiQXVyV5rjXb2ZjsM55I94Qm5B9s2Wnzjjvmdaqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281030; c=relaxed/simple;
	bh=Hl39hTp5+lYWZHnJUWLHjS8Xde3VTLrkO5IunClaSXA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K4LTk70npbLrbzz3JMN+dH97djKPW5zbosFrK4ANcrsIc6L0lfgBESk6nZxl/vUlqXL/HsctZQKvLfMEJdrvj7+sVgJTZxPQd7nibrDrl+ypulvja8fhVi2qsFhOMhurMaUpUBnzk/8o30gBdJ4g7vRXeCjUgMaaqBI67jJeDkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOcGx5Vy; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WtR7Hft9hzNUT9GE+yvo+zooVFNjckbPq5hhhHtlLTLT6FAedOizoNa2dv/aD77TC09laNkDA2j6LI0sJpvbEokqXYdakJ5HXjNl+Z2nuxsXFSXQcOFh43KPiEM/9lU3w0LbvygzjCbtYFdAWLcL0F9qWeSkZXVcxcgB4jRzdXRmAH+wMJnLTcpUXwE2H4Y8nwVQTV9mG2dMSUk6Oxlf8GiiP01E1KuPUhE5pG6Fnuq1ioUDUNq99d/k42iE6DkPgPKW4Vg/mALO1L3r2WFr70P5y9j7Q2y/HPB6EFU4swM6R1JXs8E0oBDIBvdN3DdtwNyfh8ws0KVxDXhXsZiqRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoZG7GXGL9NctINqQ+DKVzq8Y/6ktguAPqW2i2DCyPg=;
 b=dWiYjUlEYRhayQaL/Acim7Jl/T3hG3Hz+POCe8NPZZZmy0yGJRlRJtImYTTYTHp2ozUSrQ3L7HFAjlGI5QOvdUYHQ5XZ9q+xtJM5yeyeq+RNiEFh0eH9SMgaS/faLD/5/zd//izUnLjovb9M0LHg1A8KFN3oldZLh6kYClhgXif3Nc6oMRpIE25BH2h9vLBUHo+kOsvEpXDW49jxJ/EU2RwjVd0BZUFeSnEl2M4qnCLXX1R+GQAxB/DvEoiqASUx3GLGeGr5p6hurkJhiPRnfzNPBKP7kBg70gLJBJiFikuL7Ucqdnut0XeBDqU5rrm37G+jZGID2Xdv3wRawZ2FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoZG7GXGL9NctINqQ+DKVzq8Y/6ktguAPqW2i2DCyPg=;
 b=rOcGx5VyIS+jhh/zYAB9jGd4bXM2co9uR2RISGw95xzbzU0cvAaf9MxVVkt8p+yZ25QRqjDhZ6zhUPGXDXi56vZ1zgPHnUgk/W2NDI7Tubeqg7AX9EQX5vD20mkS28LpAscAq4y6aZTjhtj8jHlczcpdWr9mqToCiCWA+Pbdehj4eKy/GUBzpD2KYjltgyB2k3MwE7Zx2A+qq1fGz7cExatJfeAry1VrH0u7ktBrWaLjpYUYeSSTkREA48jGYuljb1ciRpBZAz2adWQGUcbYjTCwLefrlX1IvCuXx+ChcOoZ8RI8n1PHfzcp729Kwc5AOIMcAz7EJ/CalJt+2puegw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:17 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:17 +0000
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
Subject: [PATCH v8 00/15] Consolidate iommu page table implementations (AMD)
Date: Tue,  4 Nov 2025 14:29:58 -0400
Message-ID: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1448a1-28d4-436e-0119-08de1bd032f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wif9ceYzNfn6ANjrZY4yqpmKUXbXTpM1z8wuVjIEn3DCIXCtqPX7YLmjJq9M?=
 =?us-ascii?Q?Ec+3j0SelOnrk+0x9mymSvBxrMgBgi0kxNPEPgA76IX9aN+pIa8cT/cNAWZt?=
 =?us-ascii?Q?AOxoTblPX89CbUGWvbNSqqJ3BtAY5obzrlRyNyR8ULPhQ3T3SfQqinfI6PNb?=
 =?us-ascii?Q?rxdjw1ePZuGA/3O37uCOGPd/N9XGNXsTM9bVVQZX1P/Y4U/TyneuptmWxD1j?=
 =?us-ascii?Q?9QaaLpezwPhRNtl13KF+kouuD/wAslJTmuYlub5PGRjrLCZYMTo0PtHbIHzN?=
 =?us-ascii?Q?gymfag2D3uIg2vO/bD7pT93waWo0ExZpzXqTMhYE57+/TeF8ZMSWiyn2wzxk?=
 =?us-ascii?Q?qae/2nvKg2/c8NywpTjAYLcs43fy0QLjVIhou3VYK4ddpRfvFBRfWAJTOwvT?=
 =?us-ascii?Q?Vh3kzJhD7PCndUz8oV1FoFlDpDk+ITw8IVN2XtkF7ogsG7WbFUYy6J8J9K1C?=
 =?us-ascii?Q?6Jv7e7wLOkHri0qvlgljF9gM1JizQDgCd3CUK7rspG8HM7BSfzq4rvLG7tMj?=
 =?us-ascii?Q?isgdm6OI9451RSdgsp54GyPnfT/YBwS5KSAk1BqbVtZkfEl/UgRXe6XiWXBF?=
 =?us-ascii?Q?z5aXf9UboOCyUIK3UfgeWyR+fYU2rppd8c/s5CUYm1Rcgm1v4FAh4ALWbs8M?=
 =?us-ascii?Q?Z+9qI5GJJq0FAmaZqY1AB8BiBS05xffIyVyfDEmjKCAkI6juASVXt4sNLoaT?=
 =?us-ascii?Q?gubsP9H+/J9WvLqIAhoxoRxH02+ykswoNGda4SgraSIqaTzewdwcFpn2qunq?=
 =?us-ascii?Q?sl+HqoXsNN7B6zDsiLZmecrAIVayFAof9j+FbfqOnjSUFRdkAesFKuo+2FDs?=
 =?us-ascii?Q?LYPdn4nXyDF780Gdk8hdmIbDnyWo7ice5voi0p3VgdKMegYXYCHqHgdz2M0b?=
 =?us-ascii?Q?e64BthYYxIXumxECDTJypwnOy2mWJlYDOCCMZQQlXRSD0buSEZ1pAR7ajSpZ?=
 =?us-ascii?Q?vhpteWEjt3c95CgotTaYm1Fc3hwhqyyi4T8TX4ScZ1ekxZGbw1MMe+oKSqwi?=
 =?us-ascii?Q?5l6lCp0jlQeo12biA7yi9zXx+VotLretbyxUSawdsFoxfd2ZZ5abhvOnCACH?=
 =?us-ascii?Q?6YxH20a0QXR26ujAlFWzJSPZXZSahSgLrsl/oI4XV6R+UCfzhmkP0bkJMk7v?=
 =?us-ascii?Q?HYZDRqkaUj68KHNPgh/yOL2H6xn90UZCnKGs76mZ7G75Ir/n/WuYbBP6cuzY?=
 =?us-ascii?Q?H4FwnkEhGO5WRxCcZLOFLwghSNfQkYW87RaFXETjqRhhoVjhsLUnt/tYxDUq?=
 =?us-ascii?Q?cgz55rgrBuo8yaGhH7zRpCyc5zj1wVl5CKdGh0OTQhyLJQ4vU8ol2zRUOljK?=
 =?us-ascii?Q?gSiRJ2TjoQwjM+0arliLJ3AB231EzmCFxx9HVIiCgQqStHgtQwKQA8hHn7zP?=
 =?us-ascii?Q?i9YUSkPJRuTXo4hy9rzetY1XOXXh0shIpl/dqzcpC9imydJeV8NMvTNr9kku?=
 =?us-ascii?Q?a8WxqRIoUJqSvWB/xFgsXdTElTdesQXvZ0f8WeXFrxPWzBncVoolPLvTiXN2?=
 =?us-ascii?Q?P+pL6RoCq3dSLHD/j4FSN8qO72WtPmweQhKr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o3W2vtYMBgea0aVRRf5T4wvAqAfFPK9rUaKUv3d1NUlh8MuKdfvXwtCBuEof?=
 =?us-ascii?Q?+iQsdcRzJLOcWkE7mVhWlF7uZpTmqWd5GY0GdAjYc51KNckDE/rV28+lUT6D?=
 =?us-ascii?Q?IyrNP/gyiNGXeeF2TjiuFwgRcMdwqp39TTYmxAZWzO8/rRc+nOUf1Jdef7zn?=
 =?us-ascii?Q?uX40P/PdtRMtbYEqNGakyAV50KRELOxx6bFje48X2iz0yHrdTuwV/jTlzpq+?=
 =?us-ascii?Q?o2bVMMwIMUpVTzBCpUrFS9OyMvbRBqB2L0sdo6fyTVhEz6poJW18HwVBn0YM?=
 =?us-ascii?Q?KcG+qZNgfD237DciN/MLYU6zANxaNia4zUqmWJh7+iWCGJ18YIyvyCGDKva0?=
 =?us-ascii?Q?hHs6LROu2Y7JWvO7Efer3B/RGYm+ogn0lByf1xZwJmVxzUY33WNwBBSpdG32?=
 =?us-ascii?Q?pU3ciwAyceI0aSkBPgaZnyNlS0smw049+MJjkPrjEfGxZen6txTDE352HQ/k?=
 =?us-ascii?Q?eiqAhHXHlze+B9Uf6ftSW5HSGbKBOM5YZ82HHU0nDpJkKEh7KmqSD6dEwHVY?=
 =?us-ascii?Q?sHsX1i0iREwaQoDGCKFM8C+a72zCZ58SBdORAmkSf+zA3s3/xQ3ntBox1eQb?=
 =?us-ascii?Q?jnLsEn3F8NTBXIna8BQYkKqSAWQMddn0vLZEPiZedWUq1aEOWGq5RV0WTpPo?=
 =?us-ascii?Q?g53uRkQd2smZ29zh7KXAEGaaLN4S3z6g7ggtHcymVzX3hFv41gdm8f9vBeG0?=
 =?us-ascii?Q?me8Wi9WDw9egHsdvaNMs35i8djUEhXjF5jJ4vLcK25YcSYuPBXNW2ROIU/nU?=
 =?us-ascii?Q?BcMdtr8qCeDm3TD+OdVt/kIfk+QtnDb6Lh4K6CZYuc+mRDpF62nj69tTSLBa?=
 =?us-ascii?Q?eDxpfrsQv18yY2RLQcNCxL/A9u3NZzNT1noHiJIYP4ccz8PlltMGdbdrUZ2E?=
 =?us-ascii?Q?WnrUYX/DC5TnkQgZy42u8EtfYPccfkU0n6Km2D+7u/Oo+qhf/YNEiup5cnJz?=
 =?us-ascii?Q?lcSUoib40NA+DusPoBFo5Jj2zba4JNuO0xe8P15UMelemfKz7gpTV9EAa9TT?=
 =?us-ascii?Q?t4mhzQt/h3N5fLDEW4pk1UZd6g7gNY+j81Xhq00rvcosTQy1sd2mtECbJoz/?=
 =?us-ascii?Q?1kYsBJabunY6OKidSMDGPgPh8W6w1UhlfwqkkH308Yb2XViv2EYIhAraxbHZ?=
 =?us-ascii?Q?E3QczqS6/saB5mKtpTTIa+HxgkLR9lTEfreG6Y2aRFirqDxPaSjyPTBJ/KU+?=
 =?us-ascii?Q?JFwyQkeAQ1WrS8x7N1qEJB1HvDtD/R89Kvpudq9oRIObn5Q66NsN3SG54n2N?=
 =?us-ascii?Q?l3v2uQJXOgsOAILRLkLdVGDztwWPAAkKgLmfUMe26CAp6KGD2Xz6FGILxSYe?=
 =?us-ascii?Q?80xc0s0A+gORQOsUIRd1dj6HTgxzqUP4bO/+8EVdW1Ci6HNyrSfW6bI166xG?=
 =?us-ascii?Q?WdGitRjAKwPwn8AxkLB01Bl9YvpYZEbfd3UKYV7FsXUWhr6yENsEON8xWyQJ?=
 =?us-ascii?Q?94TiADe//yxnvub/hpCql41l+25vrFranghsMLqddf+EqwbXLMeWexEBAbdD?=
 =?us-ascii?Q?c2GA59VW1fO75OXUQQ1agb+cx4Ex7IT9hLSvDcr85cx94O3MyArWy4x+jqjN?=
 =?us-ascii?Q?nXyTvwVa+EMNtkAvxgg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1448a1-28d4-436e-0119-08de1bd032f1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:15.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELUoKJxYk68cA+d7kY7+g/QNbgSxJowZwcKok1rTOhjlfALWV4XJ/2IpMVAhFQZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

[Joerg, can you put this and vtd in linux-next please. The vtd series is still
good at v3 thanks]

Currently each of the iommu page table formats duplicates all of the logic
to maintain the page table and perform map/unmap/etc operations. There are
several different versions of the algorithms between all the different
formats. The io-pgtable system provides an interface to help isolate the
page table code from the iommu driver, but doesn't provide tools to
implement the common algorithms.

This makes it very hard to improve the state of the pagetable code under
the iommu domains as any proposed improvement needs to alter a large
number of different driver code paths. Combined with a lack of software
based testing this makes improvement in this area very hard.

iommufd wants several new page table operations:
 - More efficient map/unmap operations, using iommufd's batching logic
 - unmap that returns the physical addresses into a batch as it progresses
 - cut that allows splitting areas so large pages can have holes
   poked in them dynamically (ie guestmemfd hitless shared/private
   transitions)
 - More agressive freeing of table memory to avoid waste
 - Fragmenting large pages so that dirty tracking can be more granular
 - Reassembling large pages so that VMs can run at full IO performance
   in migration/dirty tracking error flows
 - KHO integration for kernel live upgrade

Together these are algorithmically complex enough to be a very significant
task to go and implement in all the page table formats we support. Just
the "server" focused drivers use almost all the formats (ARMv8 S1&S2 / x86
PAE / AMDv1 / VT-d SS / RISCV)

Instead of doing the duplicated work, this series takes the first step to
consolidate the algorithms into one places. In spirit it is similar to the
work Christoph did a few years back to pull the redundant get_user_pages()
implementations out of the arch code into core MM. This unlocked a great
deal of improvement in that space in the following years. I would like to
see the same benefit in iommu as well.

My first RFC showed a bigger picture with all most all formats and more
algorithms. This series reorganizes that to be narrowly focused on just
enough to convert the AMD driver to use the new mechanism.

kunit tests are provided that allow good testing of the algorithms and all
formats on x86, nothing is arch specific.

AMD is one of the simpler options as the HW is quite uniform with few
different options/bugs while still requiring the complicated contiguous
pages support. The HW also has a very simple range based invalidation
approach that is easy to implement.

The AMD v1 and AMD v2 page table formats are implemented bit for bit
identical to the current code, tested using a compare kunit test that
checks against the io-pgtable version (on github, see below).

Updating the AMD driver to replace the io-pgtable layer with the new stuff
is fairly straightforward now. The layering is fixed up in the new version
so that all the invalidation goes through function pointers.

Several small fixing patches have come out of this as I've been fixing the
problems that the test suite uncovers in the current code, and
implementing the fixed version in iommupt.

On performance, there is a quite wide variety of implementation designs
across all the drivers. Looking at some key performance across
the main formats:

iommu_map():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     53,66    ,      51,63      ,  19.19 (AMDV1)
 256*2^12,    386,1909  ,     367,1795    ,  79.79
 256*2^21,    362,1633  ,     355,1556    ,  77.77

     2^12,     56,62    ,      52,59      ,  11.11 (AMDv2)
 256*2^12,    405,1355  ,     357,1292    ,  72.72
 256*2^21,    393,1160  ,     358,1114    ,  67.67

     2^12,     55,65    ,      53,62      ,  14.14 (VT-d second stage)
 256*2^12,    391,518   ,     332,512     ,  35.35
 256*2^21,    383,635   ,     336,624     ,  46.46

     2^12,     57,65    ,      55,63      ,  12.12 (ARM 64 bit)
 256*2^12,    380,389   ,     361,369     ,   2.02
 256*2^21,    358,419   ,     345,400     ,  13.13

iommu_unmap():
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     69,88    ,      65,85      ,  23.23 (AMDv1)
 256*2^12,    353,6498  ,     331,6029    ,  94.94
 256*2^21,    373,6014  ,     360,5706    ,  93.93

     2^12,     71,72    ,      66,69      ,   4.04 (AMDv2)
 256*2^12,    228,891   ,     206,871     ,  76.76
 256*2^21,    254,721   ,     245,711     ,  65.65

     2^12,     69,87    ,      65,82      ,  20.20 (VT-d second stage)
 256*2^12,    210,321   ,     200,315     ,  36.36
 256*2^21,    255,349   ,     238,342     ,  30.30

     2^12,     72,77    ,      68,74      ,   8.08 (ARM 64 bit)
 256*2^12,    521,357   ,     447,346     , -29.29
 256*2^21,    489,358   ,     433,345     , -25.25

  * Above numbers include additional patches to remove the iommu_pgsize()
    overheads. gcc 13.3.0, i7-12700

This version provides fairly consistent performance across formats. ARM
unmap performance is quite different because this version supports
contiguous pages and uses a very different algorithm for unmapping. Though
why it is so worse compared to AMDv1 I haven't figured out yet.

The per-format commits include a more detailed chart.

There is a second branch:
   https://github.com/jgunthorpe/linux/commits/iommu_pt_all

Containing supporting work and future steps:
 - ARM short descriptor (32 bit), ARM long descriptor (64 bit) formats
 - RISCV format and RISCV conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_riscv
 - Support for a DMA incoherent HW page table walker
 - VT-d second stage format and VT-d conversion
    https://github.com/jgunthorpe/linux/commits/iommu_pt_vtd
 - DART v1 & v2 format
 - Draft of a iommufd 'cut' operation to break down huge pages
 - A compare test that checks the iommupt formats against the iopgtable
   interface, including updating AMD to have a working iopgtable and patches
   to make VT-d have an iopgtable for testing.
 - A performance test to micro-benchmark map and unmap against iogptable

My strategy is to go one by one for the drivers:
 - AMD driver conversion
 - RISCV page table and driver
 - Intel VT-d driver and VTDSS page table
 - Flushing improvements for RISCV
 - ARM SMMUv3

And concurrently work on the algorithm side:
 - debugfs content dump, like VT-d has
 - Cut support
 - Increase/Decrease page size support
 - map/unmap batching
 - KHO

As we make more algorithm improvements the value to convert the drivers
increases.

This is on github: https://github.com/jgunthorpe/linux/commits/iommu_pt

v8:
 - Remove unused  to_amdv1pt/common_to_amdv1pt/to_x86_64_pt/common_to_x86_64_pt
 - Fix 32 bit udiv compile failure in the kunit
v7: https://patch.msgid.link/r/0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com
 - Rebase to v6.18-rc2
 - Improve comments and documentation
 - Add a few missed __sme_sets() for AMD CC
 - Rename pt_iommu_flush_ops -> pt_iommu_driver_ops
          VT-D -> VT-d
          pt_clear_entry -> pt_clear_entries
          pt_entry_write_is_dirty -> pt_entry_is_write_dirty
          pt_entry_set_write_clean -> pt_entry_make_write_clean
 - Tidy some of the map flow into a new function do_map()
 - Fix ffz64()
v6: https://patch.msgid.link/r/0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com
 - Improve comments and documentation
 - Rename pt_entry_oa_full -> pt_entry_oa_exact
          pt_has_system_page -> pt_has_system_page_size
          pt_max_output_address_lg2 -> pt_max_oa_lg2
          log2_f*() -> vaf* / oaf* / f*_t
          pt_item_fully_covered -> pt_entry_fully_covered
 - Fix missed constant propogation causing division
 - Consolidate debugging checks to pt_check_install_leaf_args()
 - Change collect->ignore_mapped to check_mapped
 - Shuffle some hunks around to more appropriate patches
 - Two new mini kunit tests
v5: https://patch.msgid.link/r/0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com
 - Text grammar updates and kdoc fixes
v4: https://patch.msgid.link/r/0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc3
 - Integrate the HATS/HATDis changes
 - Remove 'default n' from kconfig
 - Remove unused 'PT_FIXED_TOP_LEVEL'
 - Improve comments and documentation
 - Fix some compile warnings from kbuild robots
v3: https://patch.msgid.link/r/0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com
 - Rebase on v6.16-rc2
 - s/PT_ENTRY_WORD_SIZE/PT_ITEM_WORD_SIZE/s to follow the language better
 - Comment and documentation updates
 - Add PT_TOP_PHYS_MASK to help manage alignment restrictions on the top
   pointer
 - Add missed force_aperture = true
 - Make pt_iommu_deinit() take care of the not-yet-inited error case
   internally as AMD/RISCV/VTD all shared this logic
 - Change gather_range() into gather_range_pages() so it also deals with
   the page list. This makes the following cache flushing series simpler
 - Fix missed update of unmap->unmapped in some error cases
 - Change clear_contig() to order the gather more logically
 - Remove goto from the error handling in __map_range_leaf()
 - s/log2_/oalog2_/ in places where the argument is an oaddr_t
 - Pass the pts to pt_table_install64/32()
 - Do not use SIGN_EXTEND for the AMDv2 page table because of Vasant's
   information on how PASID 0 works.
v2: https://patch.msgid.link/r/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com
 - AMD driver only, many code changes
RFC: https://lore.kernel.org/all/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/

Cc: Michael Roth <michael.roth@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: James Gowans <jgowans@amazon.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Alejandro Jimenez (1):
  iommu/amd: Use the generic iommu page table

Jason Gunthorpe (14):
  genpt: Generic Page Table base API
  genpt: Add Documentation/ files
  iommupt: Add the basic structure of the iommu implementation
  iommupt: Add the AMD IOMMU v1 page table format
  iommupt: Add iova_to_phys op
  iommupt: Add unmap_pages op
  iommupt: Add map_pages op
  iommupt: Add read_and_clear_dirty op
  iommupt: Add a kunit test for Generic Page Table
  iommupt: Add a mock pagetable format for iommufd selftest to use
  iommufd: Change the selftest to use iommupt instead of xarray
  iommupt: Add the x86 64 bit page table format
  iommu/amd: Remove AMD io_pgtable support
  iommupt: Add a kunit test for the IOMMU implementation

 .clang-format                                 |    1 +
 Documentation/driver-api/generic_pt.rst       |  142 ++
 Documentation/driver-api/index.rst            |    1 +
 drivers/iommu/Kconfig                         |    2 +
 drivers/iommu/Makefile                        |    1 +
 drivers/iommu/amd/Kconfig                     |    5 +-
 drivers/iommu/amd/Makefile                    |    2 +-
 drivers/iommu/amd/amd_iommu.h                 |    1 -
 drivers/iommu/amd/amd_iommu_types.h           |  110 +-
 drivers/iommu/amd/io_pgtable.c                |  577 --------
 drivers/iommu/amd/io_pgtable_v2.c             |  370 ------
 drivers/iommu/amd/iommu.c                     |  538 ++++----
 drivers/iommu/generic_pt/.kunitconfig         |   13 +
 drivers/iommu/generic_pt/Kconfig              |   68 +
 drivers/iommu/generic_pt/fmt/Makefile         |   26 +
 drivers/iommu/generic_pt/fmt/amdv1.h          |  411 ++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h     |   21 +
 drivers/iommu/generic_pt/fmt/defs_x86_64.h    |   21 +
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c    |   15 +
 drivers/iommu/generic_pt/fmt/iommu_mock.c     |   10 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |   48 +
 drivers/iommu/generic_pt/fmt/iommu_x86_64.c   |   11 +
 drivers/iommu/generic_pt/fmt/x86_64.h         |  255 ++++
 drivers/iommu/generic_pt/iommu_pt.h           | 1162 +++++++++++++++++
 drivers/iommu/generic_pt/kunit_generic_pt.h   |  713 ++++++++++
 drivers/iommu/generic_pt/kunit_iommu.h        |  183 +++
 drivers/iommu/generic_pt/kunit_iommu_pt.h     |  487 +++++++
 drivers/iommu/generic_pt/pt_common.h          |  358 +++++
 drivers/iommu/generic_pt/pt_defs.h            |  329 +++++
 drivers/iommu/generic_pt/pt_fmt_defaults.h    |  233 ++++
 drivers/iommu/generic_pt/pt_iter.h            |  636 +++++++++
 drivers/iommu/generic_pt/pt_log2.h            |  122 ++
 drivers/iommu/io-pgtable.c                    |    4 -
 drivers/iommu/iommufd/Kconfig                 |    1 +
 drivers/iommu/iommufd/iommufd_test.h          |   11 +-
 drivers/iommu/iommufd/selftest.c              |  438 +++----
 include/linux/generic_pt/common.h             |  167 +++
 include/linux/generic_pt/iommu.h              |  271 ++++
 include/linux/io-pgtable.h                    |    2 -
 include/linux/irqchip/riscv-imsic.h           |    3 +-
 tools/testing/selftests/iommu/iommufd.c       |   60 +-
 tools/testing/selftests/iommu/iommufd_utils.h |   12 +
 42 files changed, 6229 insertions(+), 1612 deletions(-)
 create mode 100644 Documentation/driver-api/generic_pt.rst
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c
 create mode 100644 drivers/iommu/generic_pt/.kunitconfig
 create mode 100644 drivers/iommu/generic_pt/Kconfig
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_x86_64.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_x86_64.c
 create mode 100644 drivers/iommu/generic_pt/fmt/x86_64.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_generic_pt.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu.h
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h
 create mode 100644 drivers/iommu/generic_pt/pt_common.h
 create mode 100644 drivers/iommu/generic_pt/pt_defs.h
 create mode 100644 drivers/iommu/generic_pt/pt_fmt_defaults.h
 create mode 100644 drivers/iommu/generic_pt/pt_iter.h
 create mode 100644 drivers/iommu/generic_pt/pt_log2.h
 create mode 100644 include/linux/generic_pt/common.h
 create mode 100644 include/linux/generic_pt/iommu.h


base-commit: 8440410283bb5533b676574211f31f030a18011b
-- 
2.43.0


