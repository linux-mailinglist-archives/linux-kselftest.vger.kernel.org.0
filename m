Return-Path: <linux-kselftest+bounces-32351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAFFAA9565
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE923A65B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56A25C827;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g/aKX0jT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEFF25C701;
	Mon,  5 May 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454740; cv=fail; b=s0XJA7YImD9J0ikNVnwbKXD+BOuNnrLr7RcqKcE7infI3vVrMkXlGQ/qNPzjjSyuS7wLnErfiFsrIEbiPlkLZjMuv9HIkRBU+5BtH2efSjfvaEMLGIQOvnOB+9mQZj2RfbJ/R1AcJJX9jEfjUsngO6w7Revo8UwyHaPiwOvDKto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454740; c=relaxed/simple;
	bh=tKyNkqb0tvRdNT4wEL+aymlUYwUXs+39WcSSv6/k6CY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZyTrZbk8tS/gswxr426m8WXK4GJKJxwQ9p+FXtzG3GEs5+Vm44TQXVgH/l1G87yIbB4cvMqAi8kztFVZrUQy5rf1MCWhjA9wbJ8b71S4PvnTZRIVI9VPBoH8+pfAog4CvSPrZ8rHyMW2DIOsy8er6vCLfloH2+Tp80Q3BWOy66c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g/aKX0jT; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzmwsDu7+asonbh1mcBSAeTpgcl1/Rz4oRUI+dvFgspbOfqD4PpL78EM7FM8qIofRCSTFMKv+47iRx0Y8O9HaYwXZO74ywyeyEgYsisV3rOHwhDXfjMHZsBK6uyKYK0rG1wI1r3Pey6GsBiqDh5dgWjWtuaGpWDqRDiGgNo1dEW2ZrbUPWgYhfB2GwFoSqfy7ZbObEW5cMUt3skQB3bPsW1Sq9T1I4Vm1v24iyxeg4Ry9txl5II2gG5qtyfqVQ5F6+1X3a1+hwld3nf/3kdzt0QikuEBG5fv8RDflqEC6X8NBoXFrzPU7MWlaED3QnIf6NQBh18lfy2qwyNsslNixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72NaUz1jSop/csvkqH+zE3T1zuLmyXyUJgFgDHohaPY=;
 b=OvyzKQHhIuoy8ZHD+sUi1Q0W3h6hAr5GD+DQNU8veAwvx4D0zxIsAbjy3wozz1LBshxhoP9rJnqrM4Am7alezWVty8pvIVDKzRzU0u3xNVX1FERoPEzvte887UoJpucc6dOthlTJwxIT001FYmYngpFqNFTtDerjp7AouTDAgLz+xMHmDyeWHwxld5gMvB3yQpHfwI2PATycEEhs0AE/kt/+o4XONqOEaly21bu/6O6V7dp4v8rrLab9AXME0fK5GDV7WloJ/1P/G/LG8OPuSJjz/G/tKa1CQXQ+AYqGNV6te/Hs9EWI1F8U8hzr6pXNg02/Y93V7vZxpa5aTvemYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72NaUz1jSop/csvkqH+zE3T1zuLmyXyUJgFgDHohaPY=;
 b=g/aKX0jTiE2u7WbyG9bAJsPuIUEypixiSMtMPXBAoacFo8lQ1zM2/7jiYAEU6Yh1QTGw8r3c+Xf5qnKuwIH3zXzuxKcKKPW6XwByM4aaduRkCwk/YSLlXGH0J6psm5RV1GsmexR4G6r2+SfW2R5dcuiqoyL8nXFCsciYzKkcH2O2DXM0vNYsCvx488vDNcUje0XSSEP7BZ7HoJAy4mfz89Qz13CAvzmAsuX0KAer65zLQaLLuf19ldsbeJ4uqsjoz4apd1DC8QHG2t9NGhUfbPJKh+0jz0QwzI/Xfmilf9QfydiL/D/IrzIGkNynCh70r+W7DpNe1neFxmOIOJdZ1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:18:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:52 +0000
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
Subject: [PATCH v2 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Mon,  5 May 2025 11:18:45 -0300
Message-ID: <15-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:408:ea::30) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 440d00b3-d71f-40d1-58bb-08dd8bdfc0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?loGP4QbZC+aaq/ZrCFacC03s50zmO3WU0QGQIOqUslNSmU+B5IdXSNH/d7ho?=
 =?us-ascii?Q?RDVdb0YX0C6pYLKWJGZMAxMi7dMCtagzQydb6QhCNofl15fALF7aVv9na/2a?=
 =?us-ascii?Q?XE3g9i7a6VpqjRVbS9tVb9wpV1jl+pAwGfateF7tzI1u8vNcsvfJDkGGeDzW?=
 =?us-ascii?Q?I/Ftd+LyMWAg7v6rP0OV7uRh8tPrR9sn2++/rVGjxuzsxaYj3OA3nZS7gn7Q?=
 =?us-ascii?Q?3dizghFhCOIBjUDVrl3LnKRp2v8KvRvI6SE34jVWAME8BwbXRwcBYU68qI0Y?=
 =?us-ascii?Q?PXiw5RL+vdOX7D6OuajeNQequBUGu+3cpqrS0sDyfnS8OWpG/3MYbrLNtlWU?=
 =?us-ascii?Q?Lv7RNRDgOG2ds93nOX6VU4XW5wNwrTvIfagJvYsh5VlmfpRXW5GsxjZyji89?=
 =?us-ascii?Q?S2Bb58Scer3Nq3k+ffyjnktzmig41o5/Rgw0HbkPtQ4CoWft0/c7GVxiO3fC?=
 =?us-ascii?Q?llDrJ+lI+XEZ6UURs+4in9z19rMa8I3Yn/T4SA6CyTt8DO5UIH39CRjp2Zy/?=
 =?us-ascii?Q?Fzav99DAXDfJhm4+EO1FRivyW5mf5j589s5bVziOwIkBgMJ0x//t1qD/JTfn?=
 =?us-ascii?Q?tYgkonxEyYLEw2YYRCEB2jlaZtTl94YhNYXSSiptlO5tZdk2xCA/NSC++Yvr?=
 =?us-ascii?Q?g+9bhHCd9L4q1atZbCm/EvyUU3xYCgyG9dq/2v6hHsfZdeAJpzEaF0dPubRX?=
 =?us-ascii?Q?82a7tu5Xo02k2pLuZrGwZfcSdmtWhnmdO8ACohdc0wY021d8++BjN3oMDm64?=
 =?us-ascii?Q?wCfHSb+4jjAln+bbTW8g7/tCaF7geclVyK7VXHHj6qFUQlvz5xk+JbsY6bOS?=
 =?us-ascii?Q?hOXtMYIxQCdzN1JKYi9WA4BLKCPCfOU1GEhw0/2klJPQVJ9Aw5frxKxs+aK7?=
 =?us-ascii?Q?libJVte5QhpQbjnZKaMsGGO9qsatGoxUnSSu5qrAxohvKNhoXg/l5dTlcf/s?=
 =?us-ascii?Q?DqtP7KqZs26ylUNW2S6SUetRN48/qkgkrEE+zjJCti7C+IMUztHuYCDaPvmr?=
 =?us-ascii?Q?dY1BrqRfu1mLcFVoaBDKqSs6CXAu/VrUJ5hHwbxSECEOnW9NxE2DJfxNTlQv?=
 =?us-ascii?Q?P9oVr66i/HMjfWl38OMqRJgZ1VPpiRJdAFhHv21Vm7tNsnBepGQhCk4IOPfm?=
 =?us-ascii?Q?8ZbA4w8LfANByOunUEYx8aDqnUYujHyizUqyuIuQyuyOKqjYcgVTIARvYRds?=
 =?us-ascii?Q?WHpQ3fqEoXp+q6q2SPi6r3F0tbVeft1Ov7872X7n3J6bZuYN182/WTv4g2LS?=
 =?us-ascii?Q?J4SD8Q5m9bKUKl9Cd531sSw7d5YAMvVPncvoWUkXRhXEsLaMFQXUXhbokzt5?=
 =?us-ascii?Q?gffOtPHb5gdLESRYUq3S+1f1mWPz3CQObsBFgQ99hJKEfreE/tzCUV+hkAZM?=
 =?us-ascii?Q?oDSlvLD3NoTdSjxrYFnh8XNuOWmepBk8NsT5e+08TearbjJMkzFkQqmugM3y?=
 =?us-ascii?Q?gOQH+ivCF1glh+yP9q3HktkDySVupMYblONFYFeE0hVuZNLaJBwNdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kz6tx2ff1Y0ukNxVV3wCHTYvPdTIqojHTHTYWCcyWxhgUY8blQmtL0GElDTA?=
 =?us-ascii?Q?AH2h0WcRGfI0nWvNdMGIWlbuEC0TgH5Ti75ctOXFd2IhYWMQ3CN07jv7iA0J?=
 =?us-ascii?Q?QK3zhUIDTzaGFtc/m0K4cAs+4pwd8JcyeLR2/8nBBTiZZdYLHlXkdDMPaoyb?=
 =?us-ascii?Q?NtGvlL4sBgsYyl1BT9+6jMp9fIntGRVLXyYseuF5gxdFPYD4gfpoHy+9NeSI?=
 =?us-ascii?Q?NE8EX1Z470yZkYNmuaJUApgFlZGwyP2FOJZmYccZBPJ9Hrxmqxk/SfsNIrcS?=
 =?us-ascii?Q?ywGreBcZ64Nm5/BqDurYXcn1RgEgytjzPr8SGTYZgqgfmgqcjmwFa7qtflOy?=
 =?us-ascii?Q?UW8+kZTxVhqFkdAl6NbFGX+S7zNmh592HiAPaI+/gfYSRqisENHkBpt+DBeu?=
 =?us-ascii?Q?L5vXuN0+6v45L2LXyoHdgeVZ36Hs4Cotp6NZvCB/Edt9GtppyJs+tuzEH121?=
 =?us-ascii?Q?t+7vEQa4tRRJiwvF/z80FjTSq8AKhRbuWieq/pk+lxut1NUHVI/ErxSp0HOl?=
 =?us-ascii?Q?1MHKLr3ijppsYfZf9pY/alry9wSUH3GBqsAFQuTSr1foYQ8s0ZhejHIFsJMR?=
 =?us-ascii?Q?o6tl/QLYnf9KPl+QXikrlxVvdgRiR0MwVXQcXY/QvftFVbck3D9SmsVNaGrZ?=
 =?us-ascii?Q?1AwTKMaqBSWlZbRrbptxAxNc91UAbsDAobRoK0I3ltpGaEP1YIhq9YTaeD3f?=
 =?us-ascii?Q?talssIoJjoeRWl5U4829lnXhM1Y9GBQizxvv/C3A3SOtLu9Ec8p79Q17Kuq8?=
 =?us-ascii?Q?DL6Gr332v4apmJYX7ly4r5vmmd5OcM4WBcxwTGfR7dKZlZJvE99gURgM2Qyj?=
 =?us-ascii?Q?pyWME/+JzoNnzIhY+V64YHXu3moyxS5y0wCMKk/+33At7Y4z3Ywv9ZnaN5GO?=
 =?us-ascii?Q?wB5KmL/tScqLqHoYg0mxW+nVRhXLWtOf5AKngpIxXr7e8mkqXZIckaDKD/ds?=
 =?us-ascii?Q?gcudm6Pdz7P3yuTBHLh8Sn+njp/oLpfbOfqMUQjGrDQQ5H3x5M+VXPGFMZl/?=
 =?us-ascii?Q?cDpTmHB8uVHAPxTnpllUwGe66+851P7YyKri5jubXuliijvOg5qf7OESc/ct?=
 =?us-ascii?Q?Pqo8GFVz+nfXqpzpFeroM920njDABPGkJMRzaCL9Vx79f+K6e4aQs7XHJ+Em?=
 =?us-ascii?Q?CrLpVp31G6EAgyqLB0wv4aQZclocVAqDeCFQGEuVSVs+lt4WXTvjysOeOc/X?=
 =?us-ascii?Q?hzwski6L0qXI/ia6W2HgmRSEZii9i4U8OjF8kO4HNWVxciSvsqyy6UoPDpzJ?=
 =?us-ascii?Q?rmGNa56aZNT1U0+dIYByGVFnPM15aKCuPjOTYuJAkOyIu5o5QHX48GpMxXzS?=
 =?us-ascii?Q?DzA0p477U7M1ZriAtN+5nWCbbY5bIX6Sg41GzsTb6SMzky/0pYpep5vBmvZg?=
 =?us-ascii?Q?tZ6YuzCjeAQhTeL7NpIxWn8RaEhYygw/kQWtPp+wzJAiaL7OZ6Ttjxy+wX4Q?=
 =?us-ascii?Q?tSit9ph41+Ukom2Xnu1vY7L6QxBiHp1bTjQQDkrAiabElhLbyCZjBV9yw9+B?=
 =?us-ascii?Q?RNjWVaC0cs/b5WpZqUAQgd4GBgxhEVZtkqg7sGOmdySfq595bYY7edIgbf9f?=
 =?us-ascii?Q?FNl/rPuyT7ueNOTQkQloh3c5MiZugh/lEuGuxGUO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440d00b3-d71f-40d1-58bb-08dd8bdfc0ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbCzC3XLRrmW7lF5xCd6auVMLAxYLBAyRYmUkaqcl77ivGRpwG+WmgMcpQRFqRBY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=1 --make_options LLVM_SUFFIX=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

Like the generic test they are run on the formats configuration list using
kunit "params". This also checks the core iommu parts of the page table
code as it enters the logic through a mock iommu_domain.

The following are checked:
 - PT_FEAT_DYNAMIC_TOP properly adds levels one by oen
 - Evey page size can be iommu_map()'d, and mapping creates that size
 - iommu_iova_to_phys() works with every page size
 - Test converting OA -> non present -> OA when the two OAs overlap and
   free table levels
 - Test that unmap stops at holes, unmap doesn't split, and unmap returns
   the right values for partial unmap requests
 - Randomly map/unmap. Checks map with random sizes, that map fails when
   hitting collions doing nothing, unmap/map with random intersections and
   full unmap of random sizes. Also checked iommu_iova_to_phys() with random
   sizes
 - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 451 ++++++++++++++++++
 3 files changed, 454 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h

diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
index 11e85106ae302e..d28e86abdf2e74 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_template.h
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -44,4 +44,5 @@
  * which means we are building the kunit modle.
  */
 #include "../kunit_generic_pt.h"
+#include "../kunit_iommu_pt.h"
 #endif
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 8a53b1d772ca9d..cca4e72efcaa04 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -70,6 +70,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..5e25d698450783
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,451 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "kunit_iommu.h"
+#include "pt_iter.h"
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+static void do_map(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		   pt_vaddr_t len);
+
+struct count_valids {
+	u64 per_size[PT_VADDR_MAX_LG2];
+};
+
+static int __count_valids(struct pt_range *range, void *arg, unsigned int level,
+			  struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct count_valids *valids = arg;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			pt_descend(&pts, arg, __count_valids);
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA) {
+			valids->per_size[pt_entry_oa_lg2sz(&pts)]++;
+			continue;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Number of valid table entries. This counts contiguous entries as a single
+ * valid.
+ */
+static unsigned int count_valids(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++)
+		total += valids.per_size[i];
+	return total;
+}
+
+/* Only a single page size is present, count the number of valid entries */
+static unsigned int count_valids_single(struct kunit *test, pt_vaddr_t pgsz)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++) {
+		if ((1ULL << i) == pgsz)
+			total = valids.per_size[i];
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[i], 0);
+	}
+	return total;
+}
+
+static void do_unmap(struct kunit *test, pt_vaddr_t va, pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	size_t ret;
+
+	ret = iommu_unmap(&priv->domain, va, len);
+	KUNIT_ASSERT_EQ(test, ret, len);
+}
+
+static void check_iova(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		       pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t pfn = log2_div(va, priv->smallest_pgsz_lg2);
+	pt_vaddr_t end_pfn = pfn + log2_div(len, priv->smallest_pgsz_lg2);
+
+	for (; pfn != end_pfn; pfn++) {
+		phys_addr_t res = iommu_iova_to_phys(&priv->domain,
+						     pfn * priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, res, (phys_addr_t)pa);
+		if (res != pa)
+			break;
+		pa += priv->smallest_pgsz;
+	}
+}
+
+static void test_increase_level(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_common *common = priv->common;
+
+	if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		kunit_skip(test, "PT_FEAT_DYNAMIC_TOP not set for this format");
+
+	if (IS_32BIT)
+		kunit_skip(test, "Unable to test on 32bit");
+
+	KUNIT_ASSERT_GT(test, common->max_vasz_lg2,
+			pt_top_range(common).max_vasz_lg2);
+
+	/* Add every possible level to the max */
+	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
+		struct pt_range top_range = pt_top_range(common);
+
+		if (top_range.va == 0)
+			do_map(test, top_range.last_va + 1, 0,
+			       priv->smallest_pgsz);
+		else
+			do_map(test, top_range.va - priv->smallest_pgsz, 0,
+			       priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, pt_top_range(common).top_level,
+				top_range.top_level + 1);
+		KUNIT_ASSERT_GE(test, common->max_vasz_lg2,
+				pt_top_range(common).max_vasz_lg2);
+	}
+}
+
+static void test_map_simple(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	pt_vaddr_t cur_va;
+
+	/* Map every reported page size */
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+
+		cur_va = ALIGN(cur_va, len);
+		do_map(test, cur_va, paddr, len);
+		if (len <= SZ_2G)
+			check_iova(test, cur_va, paddr, len);
+		cur_va += len;
+	}
+
+	/* The read interface reports that every page size was created */
+	range = pt_top_range(priv->common);
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		if (pgsize_bitmap & (1ULL << pgsz_lg2))
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 1);
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 0);
+	}
+
+	/* Unmap works */
+	range = pt_top_range(priv->common);
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+		cur_va = ALIGN(cur_va, len);
+		do_unmap(test, cur_va, len);
+		cur_va += len;
+	}
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+}
+
+/*
+ * Test to convert a table pointer into an OA by mapping something small,
+ * unmapping it so as to leave behind a table pointer, then mapping something
+ * larger that will convert the table into an OA.
+ */
+static void test_map_table_to_oa(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t limited_pgbitmap =
+		priv->info.pgsize_bitmap % (IS_32BIT ? SZ_2G : SZ_16G);
+	struct pt_range range = pt_top_range(priv->common);
+	unsigned int pgsz_lg2;
+	pt_vaddr_t max_pgsize;
+	pt_vaddr_t cur_va;
+
+	max_pgsize = 1ULL << (log2_fls(limited_pgbitmap) - 1);
+	KUNIT_ASSERT_TRUE(test, priv->info.pgsize_bitmap & max_pgsize);
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+		pt_vaddr_t offset;
+
+		if (!(priv->info.pgsize_bitmap & len))
+			continue;
+		if (len > max_pgsize)
+			break;
+
+		cur_va = ALIGN(range.va + priv->smallest_pgsz * 256,
+			       max_pgsize);
+		for (offset = 0; offset != max_pgsize; offset += len)
+			do_map(test, cur_va + offset, paddr + offset, len);
+		check_iova(test, cur_va, paddr, max_pgsize);
+		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
+				max_pgsize / len);
+
+		if (len == max_pgsize) {
+			do_unmap(test, cur_va, max_pgsize);
+		} else {
+			do_unmap(test, cur_va, max_pgsize / 2);
+			for (offset = max_pgsize / 2; offset != max_pgsize;
+			     offset += len)
+				do_unmap(test, cur_va + offset, len);
+		}
+
+		KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+	}
+}
+
+/*
+ * Test unmapping a small page at the start of a large page. This always unmaps
+ * the large page.
+ */
+static void test_unmap_split(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	unsigned int count = 0;
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_vaddr_t base_len = log2_to_int(pgsz_lg2);
+		unsigned int next_pgsz_lg2;
+
+		if (!(pgsize_bitmap & base_len))
+			continue;
+
+		for (next_pgsz_lg2 = pgsz_lg2 + 1;
+		     next_pgsz_lg2 != PT_VADDR_MAX_LG2; next_pgsz_lg2++) {
+			pt_vaddr_t next_len = log2_to_int(next_pgsz_lg2);
+			pt_vaddr_t vaddr = top_range.va;
+			pt_oaddr_t paddr = 0;
+			size_t gnmapped;
+
+			if (!(pgsize_bitmap & next_len))
+				continue;
+
+			do_map(test, vaddr, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			/* Make sure unmap doesn't keep going */
+			do_map(test, vaddr, paddr, next_len);
+			do_map(test, vaddr + next_len, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr + next_len,
+					       next_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			count++;
+		}
+	}
+
+	if (count == 0)
+		kunit_skip(test, "Test needs two page sizes");
+}
+
+static void unmap_collisions(struct kunit *test, struct maple_tree *mt,
+			     pt_vaddr_t start, pt_vaddr_t last)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	MA_STATE(mas, mt, start, last);
+	void *entry;
+
+	mtree_lock(mt);
+	mas_for_each(&mas, entry, last) {
+		pt_vaddr_t mas_start = mas.index;
+		pt_vaddr_t len = (mas.last - mas_start) + 1;
+		pt_oaddr_t paddr;
+
+		mas_erase(&mas);
+		mas_pause(&mas);
+		mtree_unlock(mt);
+
+		paddr = oalog2_mod(mas_start, priv->common->max_oasz_lg2);
+		check_iova(test, mas_start, paddr, len);
+		do_unmap(test, mas_start, len);
+		mtree_lock(mt);
+	}
+	mtree_unlock(mt);
+}
+
+static void clamp_range(struct kunit *test, struct pt_range *range)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (range->last_va - range->va > SZ_1G)
+		range->last_va = range->va + SZ_1G;
+	KUNIT_ASSERT_NE(test, range->last_va, PT_VADDR_MAX);
+	if (range->va <= MAPLE_RESERVED_RANGE)
+		range->va =
+			ALIGN(MAPLE_RESERVED_RANGE, priv->smallest_pgsz);
+}
+
+/*
+ * Randomly map and unmap ranges that can large physical pages. If a random
+ * range overlaps with existing ranges then unmap them. This hits all the
+ * special cases.
+ */
+static void test_random_map(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range upper_range = pt_upper_range(priv->common);
+	struct pt_range top_range = pt_top_range(priv->common);
+	struct maple_tree mt;
+	unsigned int iter;
+
+	mt_init(&mt);
+
+	/*
+	 * Shrink the range so randomization is more likely to have
+	 * intersections
+	 */
+	clamp_range(test, &top_range);
+	clamp_range(test, &upper_range);
+
+	for (iter = 0; iter != 1000; iter++) {
+		struct pt_range *range = &top_range;
+		pt_oaddr_t paddr;
+		pt_vaddr_t start;
+		pt_vaddr_t end;
+		int ret;
+
+		if (pt_feature(priv->common, PT_FEAT_SIGN_EXTEND) &&
+		    ULONG_MAX >= PT_VADDR_MAX && get_random_u32_inclusive(0, 1))
+			range = &upper_range;
+
+		start = get_random_u32_below(
+			min(U32_MAX, range->last_va - range->va));
+		end = get_random_u32_below(
+			min(U32_MAX, range->last_va - start));
+
+		start = ALIGN_DOWN(start, priv->smallest_pgsz);
+		end = ALIGN(end, priv->smallest_pgsz);
+		start += range->va;
+		end += start;
+		if (start < range->va || end > range->last_va + 1 ||
+		    start >= end)
+			continue;
+
+		/* Try overmapping to test the failure handling */
+		paddr = oalog2_mod(start, priv->common->max_oasz_lg2);
+		ret = iommu_map(&priv->domain, start, paddr, end - start,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+		if (ret) {
+			KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+			unmap_collisions(test, &mt, start, end - 1);
+			do_map(test, start, paddr, end - start);
+		}
+
+		KUNIT_ASSERT_NO_ERRNO_FN(test, "mtree_insert_range",
+					 mtree_insert_range(&mt, start, end - 1,
+							    XA_ZERO_ENTRY,
+							    GFP_KERNEL));
+
+		check_iova(test, start, paddr, end - start);
+		if (iter % 100)
+			cond_resched();
+	}
+
+	unmap_collisions(test, &mt, 0, PT_VADDR_MAX);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+
+	mtree_destroy(&mt);
+}
+
+static struct kunit_case iommu_test_cases[] = {
+	KUNIT_CASE_FMT(test_increase_level),
+	KUNIT_CASE_FMT(test_map_simple),
+	KUNIT_CASE_FMT(test_map_table_to_oa),
+	KUNIT_CASE_FMT(test_unmap_split),
+	KUNIT_CASE_FMT(test_random_map),
+	{},
+};
+
+static int pt_kunit_iommu_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_nr_secondary_pagetable =
+		global_node_page_state(NR_SECONDARY_PAGETABLE);
+	ret = pt_kunit_priv_init(test, priv);
+	if (ret) {
+		kunit_kfree(test, priv);
+		return ret;
+	}
+	test->priv = priv;
+	return 0;
+}
+
+static void pt_kunit_iommu_exit(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!test->priv)
+		return;
+
+	pt_iommu_deinit(priv->iommu);
+	/*
+	 * Look for memory leaks, assumes kunit is running isolated and nothing
+	 * else is using secondary page tables.
+	 */
+	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
+			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	kunit_kfree(test, test->priv);
+}
+
+static struct kunit_suite NS(iommu_suite) = {
+	.name = __stringify(NS(iommu_test)),
+	.init = pt_kunit_iommu_init,
+	.exit = pt_kunit_iommu_exit,
+	.test_cases = iommu_test_cases,
+};
+kunit_test_suites(&NS(iommu_suite));
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit for generic page table");
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


