Return-Path: <linux-kselftest+bounces-44738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC1C32A70
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B13D634CAF5
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB633E352;
	Tue,  4 Nov 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RiP8r0bp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E433E373;
	Tue,  4 Nov 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281034; cv=fail; b=TjLYp4Zo7dtoNro12FVI1YlgWOX0m3iBFKSJ6EU26ldsgD+Sz2KDH/HPaPHUwyVJ3iRlkrmH1hncP945qASgXUQaj0fTsvvOaa34YlwT/7P7gIcdknu78IBO0oLotCuBkWgRd5ILiUAi5hRmsyu9AJC/yOwRkNVCZ8uasO+2RMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281034; c=relaxed/simple;
	bh=4B0wSRQqiiMY7XcqUcEU+NpRYG4ARTCUo6Ne9b2qJqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OljsgV1nyeut9thN5AxQWRVr/BhgmjdBH8zZKhihhIbBok4BxdkN4ydCZ/Nd4qTqmKglH8qcQ2JxvNonkd7GFFjYghA+qarRFFsLsMzVylYMT6vDiU0nTxx/cRXrBQgwZ8KxTNQQQ6OtsSVXqFtiWEcWbhT/OrQsBfiRTr6q01s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RiP8r0bp; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuqVRMUFgoTJBo7W1MJ+QSdOHa7YJn5JcLO+RP9wIO+haSYwk9k6gE8OXpvCx/1S/fk7097Th76lSEE1h5IhdAfv0Ednk79GxsXq8VNB4U8jv74CyX8eO0zBgB0vsJPCy3ZZcStOSu+sjOcrrA6JhX+JXUN+0bTF1+4N5z9bUWcBjv7jnoT5YaxLWJexIqSN6ZBqOT8tYyIMqGg1S76fJB9s57ZxM2ph1CSJrLcHb6MLn+F+Xu8S7GOlD23OMMedASLxjqCt+JrlaiyVqWd3cctT2xLvE4snLvCA8RCReHP+K38zF7aRCziSsIcM5TTWQh3acyC4rMsTNGWDlmy8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vVVqJchEOZJ6L/WEplPvjpJkeDh4VwY6qcphZend6M=;
 b=livF8RPcvmhI2DcItVMQKDX3i9fy+z3o7JviCsDWEG25Blk7RVIVYmdRNfAmQGQV9JTMEzQRyAhGq+w7Br7MSmqAqJif4i1yxMoiVH7sOGcLBz6ANNFdqdb7gV/NtB0I0eUgEhDcUu4op5Mu3YWULfuCJApUnqgZ1+w1g3j/vD1z+VH9J9DJv1IiKQ6BFg18611mG7G5LOeP9HSj0fNNRmxzvB/0xtxKo0nAyAf7Pby+QVRsvcEfr5PrLEIa/YUtfWaZQZZjlCk7IIyFh51KOZusouY1cOchT2aZcixOnhghnFEno4uy73OJoDrMJ3PFK9L/3MAD3MdBQtM1+XQKhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vVVqJchEOZJ6L/WEplPvjpJkeDh4VwY6qcphZend6M=;
 b=RiP8r0bpxS8If5PNB7ZZwbGKDwXSAjQQSXzhwiIDx75OKj54LGMtQ3y4nMBr7DOW8qRfyxVr2D62oa2uZ6gJe2xyvuxRw8CcqdFseDEKhWkhnYX/F+2R1vmvw79IYTLx/yK15VhH8nV0G1zCzNUzlIYNOfwt1tUzlxkPjLEexwgi9yINRGE/PEgWvQpWWWM/dYZx7LJl109h/MJ4TLW0eql0SftRmaASQU1J7beLgN737/Cq3fj3o9fZQjENDoJrCaWFhZ/MUi4ntnMoNosIi5z1ADUhterrNmrsmVzG3yEg9E88EpkesHB9eqi2ujh7qiDZdRa8+ZCluoZcuM0UoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:19 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:19 +0000
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
Subject: [PATCH v8 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Tue,  4 Nov 2025 14:30:13 -0400
Message-ID: <15-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: b9df624e-7a7f-4329-0e4c-08de1bd0333a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u/WSMoOur2lTmmgYRYka41cvCRUAAU4lmyKvFMvvXWvHzJAScV72uPDTGJp/?=
 =?us-ascii?Q?stjBKeGTSTIw0BuZzWiHuu5cBPrtDfsylG6AzWKrcpR0n6qF+GWNL536PpRT?=
 =?us-ascii?Q?mBjkkSO0j40CzszeTVdwP5O1jlxv1y5n2ymC552VMj7yIcUG1Qg6WvMOxVzP?=
 =?us-ascii?Q?dgPFKqwGQI/LKXvhAxXZ1lIL7qdwSYBr0NFHOrqHIOSCAWHR6ljrBG8d/Mlo?=
 =?us-ascii?Q?rr2LBWza078LQm7iTgnDZtxH2AVR+sx1AdBudXMqzx4fuBFkm/4MHburWq8y?=
 =?us-ascii?Q?+N9PnWj7ZXTETeYN8wR23brBt86K3eqWMY+JNqJ6PcifFZIi8poaqusgUBAj?=
 =?us-ascii?Q?4hhMJ/q/W5LjiUBrGRKxjRvVdgmP6pUZN5rxdgcx2NNxqRlFT+kVYpP4yMSC?=
 =?us-ascii?Q?ipCPFKapnR4+n8iUCW28JoaNnZAJEPMpERL67yyRzyMpxoFXwJNhwbVUJqR0?=
 =?us-ascii?Q?c2xHS6xhyaSUuZJO6MdwXNGSmWRnmfIbaLIrgTOf1qeRSgzTE1KafLv18c7M?=
 =?us-ascii?Q?m9emPk6NODUFqbo6BxUH4+M3DEL6Cfk2MhuGFeGJ4IyTIH3yHD381IAbz9g8?=
 =?us-ascii?Q?rfn0WBDZTcZb5F6CT7xwJgtKZwMCIunhPPp/E3i0xOI6SgfWQdVWkCNFVhG3?=
 =?us-ascii?Q?J3iW2P5w8dnCilVS+cSJISv3oZCuYn8QvuOVkmRbGLo6Y5i586RV/rE4B81m?=
 =?us-ascii?Q?6JJ7ZCn7l3Y+fArjj6w2MMAkxDzDjkGYyOoHi1hX0/x5SLd/OZZBlx6Ib8Ob?=
 =?us-ascii?Q?vGeRnEe1yqluEvLwnrj55/EOA6+lxTsEXoJKKjLcJUNLOZyGA0A8L+9t7SZN?=
 =?us-ascii?Q?0BQVjN2s1QRtVpzVedfLWh4pwxXn5LroNkXvgZ57vqGozdINnSroJtdH3JqZ?=
 =?us-ascii?Q?4yiQbeYyStduPcfLU/C8Sh0U0ior8j91+R9z9AHHOJ15hl44xhNdmYHnRzUA?=
 =?us-ascii?Q?K1qrcBJw5J9dgnghAPj8lw1bP4T3d9eAz6bx4EKM+mDqGlZ82mnKjvbJ+U7G?=
 =?us-ascii?Q?vhOc0AoLcVKI8bu8FJ3yZHcaNn9wnmDbybsioZBH77wstQ53KPKIxg+iZS02?=
 =?us-ascii?Q?UzYVBJG7hgkIC8veMO1NlchXT+8tjymA6bTxbicdOdsmCzpZJPkIsfPdzuf6?=
 =?us-ascii?Q?Mc+5yIdynPxW3dmoGmR5hF1NNuBu3OAEUMM8q/eMlnrGVrH1nQeSO9SCx1lH?=
 =?us-ascii?Q?FX6dVoh3W97CA5h0O/3KLula1k1tCnekTlDFoTita8Tkp3ahHQyS0SMQerId?=
 =?us-ascii?Q?IXwVioCRpPrNd/FkdStxjfeNqB7quM5xLYDFMsf9BGtaj5VxJwriV0AXu8eB?=
 =?us-ascii?Q?jmx7kpt3XTRi9KsuWTWSJ98kJNDdMDhMmgRADrVGcTqO4pXhJwtXY2vDlYF9?=
 =?us-ascii?Q?EqQDGxjGXBCAiTsfPqNN8AW30EvHsQZ/x3Sy2N71ncx3hKWG58FiNEV+cIZ+?=
 =?us-ascii?Q?q+Eo+H/kiE3I58MJoCIiuPHicZdOLIXYIkE697ZeWK/Hyfs9rcjwr3FT3bmF?=
 =?us-ascii?Q?3d/KdhS5ECrOVxNPddBdhLzMJmkCsoJegeYU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FMzd5Smk83XPwJZR4Lqgd5zhydq7VpN2Yw6xbtixbqw85Cg9ti8GYLx2IwAE?=
 =?us-ascii?Q?yDDgcf+bbqJaDri9y0w/s0aruqpWWAjiPqYcLb9b7GJS+q69/g6OXQHlTMx6?=
 =?us-ascii?Q?hD4hz/ngwNuLr538AI6Q0QlXqiZMZiBfUuv4fDelJUn9Wn/1M8ne3QR1FJig?=
 =?us-ascii?Q?q0nEi2fUvjwX4v6NuOPwhue/u++pYJYlrgBMFBoArSeooTBFhI5+EIF3MuAC?=
 =?us-ascii?Q?D9w1+htjpYUz4Tf71SNCsf4tqCg5hU6x1oDuZzUY+2cb+Mxp6pb9DbYP8UmJ?=
 =?us-ascii?Q?kP/hVUQxkHO02+rFggqWc/oWUbjgX/2sozjS6bHYdNAVTQB6/sB1aovO8hX8?=
 =?us-ascii?Q?NSyKE6CBY5ppLleeS3jagCzKwRraY4fdV1XJl3UwxO0iveyt5WB3poo3Ezf2?=
 =?us-ascii?Q?C/FSeRyfQLd8dpjTC/GFijgmcF3lTeYm/ha5H/zsH8KAe48AWJFsWCUQFd6r?=
 =?us-ascii?Q?UGuFMENCFXG4ofww4nCqBaagPlZi4pCp2thmCHr8I1Je2e7XKKOK69eIoINO?=
 =?us-ascii?Q?SKBlA0ZMCWvqdrrOliyigvQWF9TsFSn/hv6p5K1vvuWeKJpPpznKtDHVhkTc?=
 =?us-ascii?Q?LqyDNAO63XPKZhHM/3/J5udUuSmtA/YVWZxko5Pq9u9rg9fvdCx3UHGEOe1Y?=
 =?us-ascii?Q?l+Se+hfWx8ZWfweZ6+0tchHCMu3vFrPGyB8WQb1LFXMPGw9x6i+JO4XRMUC8?=
 =?us-ascii?Q?/xzngltLJ26SMmSe5DdAbonmalt+wi8jcYyvExgyw0E6DfGxXTWLcYxwdpvs?=
 =?us-ascii?Q?FqBPPPi27vpqWUtihSbuugZKsMhICb8ZBPtegYB6KasD66sIInqMcFINngCD?=
 =?us-ascii?Q?/zP4REhBf8rmmzM4aFvTGo20VE69BAZ1jSM6UsPNMGvQbNUd8PAEHZxDv9F7?=
 =?us-ascii?Q?H9wKGYRtbRXqXV0qTEG8gB/Rh8InhsYF/DK43VqLOMi60uGvX7CQ7WPqm4L8?=
 =?us-ascii?Q?+bdCzZph6WgubNDteARmbmKftkD86j7rWzpnTdzwKd+gNE0u+U4h/Ck0yo3T?=
 =?us-ascii?Q?/AGZAeuJTFG9Y6HkHQZgYI5zlB9xF0lMOKbObqcVGod/2dU9GxhC1rxHpIKf?=
 =?us-ascii?Q?hZ5SiyV09JY9vOgt6CEVBJztz3RVEKYMKWc34OGJK3o7PaLUtwkWEHAmQcoO?=
 =?us-ascii?Q?bk60D8g/vnsQQgjl/rcpd7zvT64Tkcd3hqZ046RlCL5WjfJ+F04ukoKkUkWT?=
 =?us-ascii?Q?azV1uDmCFAkq2/UfRL7qS57cK18AvzL5uM7tzlJSuQCmRjeqmFdy/744XUZe?=
 =?us-ascii?Q?DcbF2Ayd7cNsQRIuJa1dHDdVtoQ7aMQiBrVJFt48Zkq+ABEyqyuw1ngaetz1?=
 =?us-ascii?Q?VYpAqjtC7UZBni2oUBfFUMCov7gVOST1+hs168/8XaUhYGeXE2V5v57tiGe7?=
 =?us-ascii?Q?NOopkSk8lTBGiVHQEMpC1umYxrigyimBg9NuZBdMXFKR2ZpVh7BSbFCEb+8o?=
 =?us-ascii?Q?CmZSdv3EDDjs8RBRjDMx44gdRum61YmJiPNOjBUiyvyJGeyxRC3liY3CtnHl?=
 =?us-ascii?Q?tZtfmPaWPNLmp/ayACdMrNHhNFudFMbDwcgpLJtz3ZIZdkfFUY4VDP5saTRG?=
 =?us-ascii?Q?mJZd5W2vMX6g8b/wJvY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9df624e-7a7f-4329-0e4c-08de1bd0333a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:16.1939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucPOxM2q2IqTvmiJm7wvsrNtKzMNEAHffXu9+TNalQBJya7GWIAAa5n4THJDhHTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit tests can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

Like the generic tests, these are run on the format's configuration list
using kunit "params". This also checks the core iommu parts of the page
table code as it enters the logic through a mock iommu_domain.

The following are checked:
 - PT_FEAT_DYNAMIC_TOP properly adds levels one by one
 - Every page size can be iommu_map()'d, and mapping creates that size
 - iommu_iova_to_phys() works with every page size
 - Test converting OA -> non present -> OA when the two OAs overlap and
   free table levels
 - Test that unmap stops at holes, unmap doesn't split, and unmap returns
   the right values for partial unmap requests
 - Randomly map/unmap. Checks map with random sizes, that map fails when
   hitting collisions doing nothing, unmap/map with random intersections and
   full unmap of random sizes. Also checks iommu_iova_to_phys() with random
   sizes
 - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 487 ++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h           |   3 +-
 4 files changed, 491 insertions(+), 2 deletions(-)
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
index 28ec313f151e70..d541235632aa69 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -71,6 +71,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..e8a63c8ea850e5
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,487 @@
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
+	max_pgsize = 1ULL << (vafls(limited_pgbitmap) - 1);
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
+				log2_div(max_pgsize, pgsz_lg2));
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
+/* See https://lore.kernel.org/r/b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com */
+static void test_pgsize_boundary(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+
+	if (top_range.va != 0 || top_range.last_va < 0xfef9ffff ||
+	    priv->smallest_pgsz != SZ_4K)
+		kunit_skip(test, "Format does not have the required range");
+
+	do_map(test, 0xfef80000, 0x208b95d000, 0xfef9ffff - 0xfef80000 + 1);
+}
+
+/* See https://lore.kernel.org/r/20250826143816.38686-1-eugkoira@amazon.com */
+static void test_mixed(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	u64 start = 0x3fe400ULL << 12;
+	u64 end = 0x4c0600ULL << 12;
+	pt_vaddr_t len = end - start;
+	pt_oaddr_t oa = start;
+
+	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
+		kunit_skip(test, "range is too small");
+	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
+		kunit_skip(test, "incompatible psize");
+
+	do_map(test, start, oa, len);
+	/* 14 2M, 3 1G, 3 2M */
+	KUNIT_ASSERT_EQ(test, count_valids(test), 20);
+	check_iova(test, start, oa, len);
+}
+
+static struct kunit_case iommu_test_cases[] = {
+	KUNIT_CASE_FMT(test_increase_level),
+	KUNIT_CASE_FMT(test_map_simple),
+	KUNIT_CASE_FMT(test_map_table_to_oa),
+	KUNIT_CASE_FMT(test_unmap_split),
+	KUNIT_CASE_FMT(test_random_map),
+	KUNIT_CASE_FMT(test_pgsize_boundary),
+	KUNIT_CASE_FMT(test_mixed),
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
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 7494952c55187a..7f3ff5c5ea5356 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/fwnode.h>
-#include <asm/csr.h>
 
 #define IMSIC_MMIO_PAGE_SHIFT		12
 #define IMSIC_MMIO_PAGE_SZ		BIT(IMSIC_MMIO_PAGE_SHIFT)
@@ -86,7 +85,7 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
-#ifdef CONFIG_ACPI
+#if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
 int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
 struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
 #else
-- 
2.43.0


