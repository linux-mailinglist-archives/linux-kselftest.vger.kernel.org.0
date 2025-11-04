Return-Path: <linux-kselftest+bounces-44742-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896CC32A94
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582D718C4119
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF3834029C;
	Tue,  4 Nov 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQSe2Z/E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41E33F8BB;
	Tue,  4 Nov 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281039; cv=fail; b=t2Y1txtp63u/reb+74rDYgelOZx/LqiZ410SA8XGJ2VzwosPjrB0ldLs3BxaoYSXBCB5AT5gtvtmOES8YU9NkL9qntk64tyYsNz4XUfS7tCEyo4m9L/5Y0/GLGQ9UJcPK7JilZAkFhL/8/dRz7BNS4SPaQuwkO3iVFrtgQTkiPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281039; c=relaxed/simple;
	bh=a7UFx2UXdESepXi+vWXbY7y372hmPPrrCoqy41/1EWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPDCTt8OyWckDRhwOazAVBhlR1KSB3Vc7GQ+2/Ln3eByZTuopcl78SRWkrGWojf/ah+PJF2i6QrLK2b/8cdaMlUJpKNAemy0v1AFBGNMPo4Qq7uYc/A3wHrg2jF80Fi4MP/4/7/d822eTQrujC0r+699KmMgutb7SGPtdbA1+Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQSe2Z/E; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ru5wBOGthYVkOIABiu1egmtuO8+BHg8mWakd8A0Iy4WFq6YcXkJXuTnNGaMuZLt5cnlOxu38j7iMMsO0IZuhua/EQ6ubppeaAFW6rCo6+qxqKKKhJL1xns63uf2OLtXIql+m/bQL8VHs/YAYtV9IlkI2TnlgFIXVLwZojacejy9Z+yULi5UHPeT6LWmVKFujO58mwyyUGisxrL2Z2S60THoQtslRHXS1HNKpN92AboKnmcGO/VsoyzyL40+BipqztpAeRh7TodEu1JKFa/uBDyH7y3kh2Kij6ukH5Wq/yB8VugvU1WIBXti9eMqO61SzexD3mIXl6PjpLHRmLUYMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36OaOne7LPnfb0EkF1nrkIGoqcAKilrmTqfPsRGLFpI=;
 b=CezJ1xjXVchEuWeQz0JMgitfVyvQAq86zk0h/OZF3GSdzu3RJZIukGJb8/s6SRE/sRj+auEwCh5Lm2DkzVi20wpEGTQF/p2r19Hsmse2fVNlkZMXf0DZDRhYu0jN9WdBeW2wSqwHN66OeeH/hAmqUdQikp7xCrCwDnKSGVHHHm0hFCIlbm6JXL5k0dwoihXs/0ndKQFJZnMqSTD5Y1MNjSzwnu1kfJ3BJHO2ggsMbcXL5SxoId13z0fcmYhvbtqCIPcEUQyR3sFR1nxcwqn7DOp5wYxq6iqmq+eH1gPQEjqic+sM9dpCK9ZuFAm45cv/codbtq0FVHyF1IZM5HhLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36OaOne7LPnfb0EkF1nrkIGoqcAKilrmTqfPsRGLFpI=;
 b=jQSe2Z/Ee6lEM2Zv3djjBJ0KtgSMTj+1QJlGY2JxnFuqJURv2nmZqmnrghP0bkTk4xFGEyq4PjTSISR50Z3KUzMnVvb+T5tVoml8QJjGkwQ7Q5iAhFJj8Gs3k7Alc/3BALEH+NP/DpNDPuegccKRNOnQ130636Ffaq6NPhsheoalnMUdQm9xnuaT2Mpvs8I+Qm2DpLfZAVhewhHLEofXeuPuYdb6upPgwW3cJCNxhNMXgobSscwPfYCRcDgYIxJ19/gpkvuWDOtYVKmvPhy7mxmHuXI4WfeWvW0GLVyPHBqBOCRnrZxQCIP6maXt+liP5mT5WmTonmP9NY00xTlbiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:21 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:21 +0000
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
Subject: [PATCH v8 03/15] iommupt: Add the basic structure of the iommu implementation
Date: Tue,  4 Nov 2025 14:30:01 -0400
Message-ID: <3-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:208:2be::33) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: e35994ef-569c-45fb-08fd-08de1bd033c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u0YluEqQsukfn+5WCOXEKN/6z+Yppj774OesrcZVZnjrwSril5AcGyPJtyX5?=
 =?us-ascii?Q?5q0FRbs9S3GBV8C5WE64jSG4T256NvCDyG04POlTgYLTiRg1Dd1phxbN4v/X?=
 =?us-ascii?Q?nx0Q+yWnSVVbY88t3Ul8vXhCdaDoDNe90voCSOUD6AuV0eGhkBOuqP6xoiwB?=
 =?us-ascii?Q?7VYAWoyE58yLhzIZN2RDS5fzcrENMUQ6AA3IPJM6dH/QNcRPgjpWH9pH/gmb?=
 =?us-ascii?Q?GKEMy1Nk3tvuyUqTzdmYFHHa7eiRT6INWlbgWr5JrBnVoVp41dQBmjMRtQSt?=
 =?us-ascii?Q?1yYIjzhOapV+8XKGJjPrtuW3i8PUvv74FvCASC5m2g6Fw+jtH6N171di8EqJ?=
 =?us-ascii?Q?apRu78j7ehjbN0Cxx+1wiXnf262LCvb4DHdKk9wx9tMdtD80NDIkY94CFVS9?=
 =?us-ascii?Q?gwp3vxqtvcw4gzhkefJUwHSLcZTPsLP+UhG1bsf0adL9duA8NeigBrz/fYOF?=
 =?us-ascii?Q?c0dQzV0w7/bm9f4Ge7ZG8ud6S9AX95Ku5AjfDnVCF8e4MWh1nfe1BzXYt93j?=
 =?us-ascii?Q?ySLwh5fytm+o1COs0fb6OO20OItCh81/HgKQJZsCemRRv0lJtPt5+LGSn+kq?=
 =?us-ascii?Q?4w09nmHMay3zmN1HstlDCZZl8Zg7RbgWpyK5KMHv0lBvr6O3riZ21kKlnkvU?=
 =?us-ascii?Q?xWfXN0a2NbgJpT381PvZhpxn0h+SiUbs7P3WELVeEBRGF6gNrNgmCf0j5Pvx?=
 =?us-ascii?Q?spU7yt5/fwH3PFcr+2+FBDXWezAG2Rdj7mQjE8tEt8mDnj3KlMbshJwBNuGS?=
 =?us-ascii?Q?SqF+AtSY7Hw2pWcjv+IUwNhebqjiuVMDn/uC424Dd3Q1SOlb4u3LIcRvgWrv?=
 =?us-ascii?Q?4Z4+j9EqD+eMEPC/ARRfN10EaEpJcgJ96aZiK18CsGOizmNeGkahiPe0BB6S?=
 =?us-ascii?Q?cl1IYVN4lwO/lRK7GZ8uUOjv2Mvj07+b9x60dMfxgih024RHvY65UATJ0pgk?=
 =?us-ascii?Q?JEstvYbcem5jwD2HI7gAovBmKjDCIVJOavmUiGtvVqP7F/cESy/N+5FJVvht?=
 =?us-ascii?Q?QMoe6F+rsCz4jLNe9PFJ+mpp0Sq3Qjuq2bkA6kilLbYnGDzWU1nS3+yWReMN?=
 =?us-ascii?Q?1N4pllmVnKZn7s66HdomGV75Y3zEI8MtJ3VLAe9iA2PEeQEBnu/tUbLKjPs+?=
 =?us-ascii?Q?0Y+jVZrx581rmaMq08mYXPMESAzvvFixP7bsApCA6+BSkIiUYfGsGrLA5REf?=
 =?us-ascii?Q?XgsP/BV08ji8lktRTSLPOZ6UixoJoz0N10sXdspD9i9/NjAfDWC9PTTrvWMS?=
 =?us-ascii?Q?NjI70UXxcwGiyk30gBtpN0V7LgvBcsSL73fFYpBMfzyWJ/IfxV3ljOEjmqRZ?=
 =?us-ascii?Q?NyDmNuOvfh3j8/Deu8KhD81xqjECIhDz6Fc7AoYVJUrdnMZN+9NbaxlyRipb?=
 =?us-ascii?Q?Tu9TNpseZfCtGNQeOZAjrljtKoxafKpbo1kvf3WByJjVMitGdQCmnuWrg9li?=
 =?us-ascii?Q?k5G7T6muRrL4cFgeMfjuhdsd7Pr8SQb8U1ivaBGGUojAyuS01HFL0i+1d09O?=
 =?us-ascii?Q?K6XiQQw9vgzPH9o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pftdm7ewbS1Ts85rGpYW1xwF8xa+48z52JDYmkLmbjpKkH5PqeZN8lXkKY6Q?=
 =?us-ascii?Q?NEDguLsXOrAS/1R7zulWCKwuJ/tGUd4I5S4gkFEtOOPrnGslcMuU2MorOAmY?=
 =?us-ascii?Q?iPaOe/rNwWP0I0kKX1FyhhIMErBwIZuB7qA63oXpSovZwkfBSPebywC7Nm/e?=
 =?us-ascii?Q?7JRMjylG70+6bqoijn0+oEOrERkIItCSiB6IrOnYYFSwvUgeqvcPGL7G2xDH?=
 =?us-ascii?Q?h6SKcakkMR5WQD95cCuBjcfqLYbtFcO8wx0rlxogpRxmbpkQQB5SO9Sd71oQ?=
 =?us-ascii?Q?W8F/mMMyw7uZQs7qtqNxkrjC3xilKAORgN/VQtN6Ek34LY4NQuAwzxeYp3Pe?=
 =?us-ascii?Q?ZzyKyfrqUm6d817DeYlkVCGvMtKu6s4K5WEAZDYPwbqcFCLU0yeTifhshxO2?=
 =?us-ascii?Q?BK3nFjx/VNigrX0Igwd0OTsXZgC32yIVgbUvvnHY/DL77OJ4OSgFnZW6PQOX?=
 =?us-ascii?Q?pZ0gdk2Yt5KBzgPNmTo+dpsdFX8jo/qJNg2CYp4sygangvKF+4n0AA209NVe?=
 =?us-ascii?Q?gL+Bdm/rxaNuk0IVSRwrk1L97GagZtL/y+nbQPEH5RJ9Gh9k0aD0W9A+Sbu8?=
 =?us-ascii?Q?ApJinrmxTP/5P4p0hhDbadw16I3jKlKh+UgQY5f34Gfc5fisnoKObHiy2tym?=
 =?us-ascii?Q?42wqyKhy1bUz+HP3D8sxiaiaaogsxYkVFtBNn/E7aZMD5gkqARD9qYnYnWF1?=
 =?us-ascii?Q?AERpbYcbz6YHP2L9bws0FA21rFinkxMJY1eiOsrxxLYuQ6tBIKhLXA7fIORp?=
 =?us-ascii?Q?Cn1mtD3aI2S7IplKUxVKVapuZUp5DrcYtY4G6HIfkQUDHJO6ZjsRU+bELjN2?=
 =?us-ascii?Q?R9kx7/oEvSC3Z07G/P+km7hO3/C5hiAswkv3xXgczvbseQWtXo5AKP83dLuN?=
 =?us-ascii?Q?0zBU2BrnxoKffilV4wGyusHKr2mfIZqmjaG11OFt/7CibNETOFuDq66r4Ekq?=
 =?us-ascii?Q?gcw/eDohAkFxPSGuvxadsL2Tiaakz6J8vHrqRgwNKdNo5ETUEDx33E5NNpBB?=
 =?us-ascii?Q?Sa1p3/9TBo8GtHZtyGsMKV2BO0A4JAaAS++ukTxhJyzxRUuxqNXbUp3EaCRL?=
 =?us-ascii?Q?VJ8ph4ewyH4xF6yOJBX1mJLKvqOjjaeTm1eHVGsm6ycsmUKdtJN0r3WFd+Cg?=
 =?us-ascii?Q?MmXit6UxetyUwkYRYqpW56WqvVAPvRLmVti3hfkKsvNrTDvIdMdXmVUgSQZT?=
 =?us-ascii?Q?4KHYw7w8xXrA7pLQwNc77OlW35ZLQNfHVrhXJ3A4N405yL+EmJBEXBialHCE?=
 =?us-ascii?Q?8bKn6/MFQKKksV4o83ZcNIgMH4zgW6OokGRFOYZ325wbBxGP+hVbfuaatoLM?=
 =?us-ascii?Q?tjt2XMeDkglRttslBD3juEE3updTmBiNmxyBfhcl8rS2R78wW9nV6Yd+LoU1?=
 =?us-ascii?Q?lJU+epCr2ZEvrw9qyrF8CpqrWHfP8QCdkbGQwwuHHvYcw4hF2La50N5rF0Fp?=
 =?us-ascii?Q?djm0KAKfXShUH4+gaF9J9lwQ32TNtI25nL0QiAi2+wGV8Rbqbm8qNh2jytxQ?=
 =?us-ascii?Q?N8zkH2hzpR/SBwfC/2vifhQornX0WUAI/Z/WL2j0UDZwurho7UWao677DcrQ?=
 =?us-ascii?Q?nPPbPvutgzjadztXyE0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35994ef-569c-45fb-08fd-08de1bd033c2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:17.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSEQv003emJVE+umFsRwHhAeI1EiOI6YRs1zLfr02JFQcI0iieA9+cdvjliI7Mob
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

The existing IOMMU page table implementations duplicate all of the working
algorithms for each format. By using the generic page table API a single C
version of the IOMMU algorithms can be created and re-used for all of the
different formats used in the drivers. The implementation will provide a
single C version of the iommu domain operations: iova_to_phys, map, unmap,
and read_and_clear_dirty.

Further, adding new algorithms and techniques becomes easy to do across
the entire fleet of drivers and formats.

The C functions are drop in compatible with the existing iommu_domain_ops
using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
compilation unit will produce exported symbols following the pattern
pt_iommu_FMT_map_pages() which the macro directly maps to the
iommu_domain_ops members. This avoids the additional function pointer
indirection like io-pgtable has.

The top level struct used by the drivers is pt_iommu_table_FMT. It
contains the other structs to allow container_of() to move between the
driver, iommu page table, generic page table, and generic format layers.

   struct pt_iommu_table_amdv1 {
       struct pt_iommu {
	      struct iommu_domain domain;
       } iommu;
       struct pt_amdv1 {
	      struct pt_common common;
       } amdpt;
   };

The driver is expected to union the pt_iommu_table_FMT with its own
existing domain struct:

   struct driver_domain {
       union {
	       struct iommu_domain domain;
	       struct pt_iommu_table_amdv1 amdv1;
       };
   };
   PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);

To create an alias to avoid renaming 'domain' in a lot of driver code.

This allows all the layers to access all the necessary functions to
implement their different roles with no change to any of the existing
iommu core code.

Implement the basic starting point: pt_iommu_init(), get_info() and
deinit().

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/Kconfig              |  13 +
 drivers/iommu/generic_pt/fmt/iommu_template.h |  39 +++
 drivers/iommu/generic_pt/iommu_pt.h           | 259 ++++++++++++++++++
 include/linux/generic_pt/iommu.h              | 150 ++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_template.h
 create mode 100644 drivers/iommu/generic_pt/iommu_pt.h
 create mode 100644 include/linux/generic_pt/iommu.h

diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index fb0f431ddba0a8..a81dfdd72ca016 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -17,4 +17,17 @@ config DEBUG_GENERIC_PT
 	  kernels.
 
 	  The kunit tests require this to be enabled to get full coverage.
+
+config IOMMU_PT
+	tristate "IOMMU Page Tables"
+	select IOMMU_API
+	depends on IOMMU_SUPPORT
+	depends on GENERIC_PT
+	help
+	  Generic library for building IOMMU page tables
+
+	  IOMMU_PT provides an implementation of the page table operations
+	  related to struct iommu_domain using GENERIC_PT. It provides a single
+	  implementation of the page table operations that can be shared by
+	  multiple drivers.
 endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
new file mode 100644
index 00000000000000..5b631bc07cbc16
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * Template to build the iommu module and kunit from the format and
+ * implementation headers.
+ *
+ * The format should have:
+ *  #define PT_FMT <name>
+ *  #define PT_SUPPORTED_FEATURES (BIT(PT_FEAT_xx) | BIT(PT_FEAT_yy))
+ * And optionally:
+ *  #define PT_FORCE_ENABLED_FEATURES ..
+ *  #define PT_FMT_VARIANT <suffix>
+ */
+#include <linux/args.h>
+#include <linux/stringify.h>
+
+#ifdef PT_FMT_VARIANT
+#define PTPFX_RAW \
+	CONCATENATE(CONCATENATE(PT_FMT, _), PT_FMT_VARIANT)
+#else
+#define PTPFX_RAW PT_FMT
+#endif
+
+#define PTPFX CONCATENATE(PTPFX_RAW, _)
+
+#define _PT_FMT_H PT_FMT.h
+#define PT_FMT_H __stringify(_PT_FMT_H)
+
+#define _PT_DEFS_H CONCATENATE(defs_, _PT_FMT_H)
+#define PT_DEFS_H __stringify(_PT_DEFS_H)
+
+#include <linux/generic_pt/common.h>
+#include PT_DEFS_H
+#include "../pt_defs.h"
+#include PT_FMT_H
+#include "../pt_common.h"
+
+#include "../iommu_pt.h"
diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
new file mode 100644
index 00000000000000..564f2d3a6e11e1
--- /dev/null
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -0,0 +1,259 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * "Templated C code" for implementing the iommu operations for page tables.
+ * This is compiled multiple times, over all the page table formats to pick up
+ * the per-format definitions.
+ */
+#ifndef __GENERIC_PT_IOMMU_PT_H
+#define __GENERIC_PT_IOMMU_PT_H
+
+#include "pt_iter.h"
+
+#include <linux/export.h>
+#include <linux/iommu.h>
+#include "../iommu-pages.h"
+
+#define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
+
+struct pt_iommu_collect_args {
+	struct iommu_pages_list free_list;
+};
+
+static int __collect_tables(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_collect_args *collect = arg;
+	int ret;
+
+	if (!pt_can_have_table(&pts))
+		return 0;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			iommu_pages_list_add(&collect->free_list, pts.table_lower);
+			ret = pt_descend(&pts, arg, __collect_tables);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+	return 0;
+}
+
+static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
+						 uintptr_t top_of_table,
+						 gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(common);
+
+	/*
+	 * Top doesn't need the free list or otherwise, so it technically
+	 * doesn't need to use iommu pages. Use the API anyhow as the top is
+	 * usually not smaller than PAGE_SIZE to keep things simple.
+	 */
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
+}
+
+static void NS(get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_top_range(common);
+	struct pt_state pts = pt_init_top(&range);
+	pt_vaddr_t pgsize_bitmap = 0;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP)) {
+		for (pts.level = 0; pts.level <= PT_MAX_TOP_LEVEL;
+		     pts.level++) {
+			if (pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2)
+				break;
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+		}
+	} else {
+		for (pts.level = 0; pts.level <= range.top_level; pts.level++)
+			pgsize_bitmap |= pt_possible_sizes(&pts);
+	}
+
+	/* Hide page sizes larger than the maximum OA */
+	info->pgsize_bitmap = oalog2_mod(pgsize_bitmap, common->max_oasz_lg2);
+}
+
+static void NS(deinit)(struct pt_iommu *iommu_table)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range range = pt_all_range(common);
+	struct pt_iommu_collect_args collect = {
+		.free_list = IOMMU_PAGES_LIST_INIT(collect.free_list),
+	};
+
+	iommu_pages_list_add(&collect.free_list, range.top_table);
+	pt_walk_range(&range, __collect_tables, &collect);
+
+	/*
+	 * The driver has to already have fenced the HW access to the page table
+	 * and invalidated any caching referring to this memory.
+	 */
+	iommu_put_pages_list(&collect.free_list);
+}
+
+static const struct pt_iommu_ops NS(ops) = {
+	.get_info = NS(get_info),
+	.deinit = NS(deinit),
+};
+
+static int pt_init_common(struct pt_common *common)
+{
+	struct pt_range top_range = pt_top_range(common);
+
+	if (PT_WARN_ON(top_range.top_level > PT_MAX_TOP_LEVEL))
+		return -EINVAL;
+
+	if (top_range.top_level == PT_MAX_TOP_LEVEL ||
+	    common->max_vasz_lg2 == top_range.max_vasz_lg2)
+		common->features &= ~BIT(PT_FEAT_DYNAMIC_TOP);
+
+	if (top_range.max_vasz_lg2 == PT_VADDR_MAX_LG2)
+		common->features |= BIT(PT_FEAT_FULL_VA);
+
+	/* Requested features must match features compiled into this format */
+	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
+	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
+	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
+		     PT_FORCE_ENABLED_FEATURES))
+		return -EOPNOTSUPP;
+
+	if (common->max_oasz_lg2 == 0)
+		common->max_oasz_lg2 = pt_max_oa_lg2(common);
+	else
+		common->max_oasz_lg2 = min(common->max_oasz_lg2,
+					   pt_max_oa_lg2(common));
+	return 0;
+}
+
+static int pt_iommu_init_domain(struct pt_iommu *iommu_table,
+				struct iommu_domain *domain)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_iommu_info info;
+	struct pt_range range;
+
+	NS(get_info)(iommu_table, &info);
+
+	domain->type = __IOMMU_DOMAIN_PAGING;
+	domain->pgsize_bitmap = info.pgsize_bitmap;
+
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		range = _pt_top_range(common,
+				      _pt_top_set(NULL, PT_MAX_TOP_LEVEL));
+	else
+		range = pt_top_range(common);
+
+	/* A 64-bit high address space table on a 32-bit system cannot work. */
+	domain->geometry.aperture_start = (unsigned long)range.va;
+	if ((pt_vaddr_t)domain->geometry.aperture_start != range.va)
+		return -EOVERFLOW;
+
+	/*
+	 * The aperture is limited to what the API can do after considering all
+	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
+	 * to store a VA. Set the aperture to something that is valid for all
+	 * cases. Saturate instead of truncate the end if the types are smaller
+	 * than the top range. aperture_end should be called aperture_last.
+	 */
+	domain->geometry.aperture_end = (unsigned long)range.last_va;
+	if ((pt_vaddr_t)domain->geometry.aperture_end != range.last_va) {
+		domain->geometry.aperture_end = ULONG_MAX;
+		domain->pgsize_bitmap &= ULONG_MAX;
+	}
+	domain->geometry.force_aperture = true;
+
+	return 0;
+}
+
+static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_iommu cfg = *iommu_table;
+
+	static_assert(offsetof(struct pt_iommu_table, iommu.domain) == 0);
+	memset_after(fmt_table, 0, iommu.domain);
+
+	/* The caller can initialize some of these values */
+	iommu_table->nid = cfg.nid;
+}
+
+#define pt_iommu_table_cfg CONCATENATE(pt_iommu_table, _cfg)
+#define pt_iommu_init CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), init)
+
+int pt_iommu_init(struct pt_iommu_table *fmt_table,
+		  const struct pt_iommu_table_cfg *cfg, gfp_t gfp)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_table_p *table_mem;
+	int ret;
+
+	if (cfg->common.hw_max_vasz_lg2 > PT_MAX_VA_ADDRESS_LG2 ||
+	    !cfg->common.hw_max_vasz_lg2 || !cfg->common.hw_max_oasz_lg2)
+		return -EINVAL;
+
+	pt_iommu_zero(fmt_table);
+	common->features = cfg->common.features;
+	common->max_vasz_lg2 = cfg->common.hw_max_vasz_lg2;
+	common->max_oasz_lg2 = cfg->common.hw_max_oasz_lg2;
+	ret = pt_iommu_fmt_init(fmt_table, cfg);
+	if (ret)
+		return ret;
+
+	if (cfg->common.hw_max_oasz_lg2 > pt_max_oa_lg2(common))
+		return -EINVAL;
+
+	ret = pt_init_common(common);
+	if (ret)
+		return ret;
+
+	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
+	    (pt_feature(common, PT_FEAT_FULL_VA) ||
+	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
+		return -EINVAL;
+
+	ret = pt_iommu_init_domain(iommu_table, &iommu_table->domain);
+	if (ret)
+		return ret;
+
+	table_mem = table_alloc_top(common, common->top_of_table, gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+	pt_top_set(common, table_mem, pt_top_get_level(common));
+
+	/* Must be last, see pt_iommu_deinit() */
+	iommu_table->ops = &NS(ops);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_init, "GENERIC_PT_IOMMU");
+
+#ifdef pt_iommu_fmt_hw_info
+#define pt_iommu_table_hw_info CONCATENATE(pt_iommu_table, _hw_info)
+#define pt_iommu_hw_info CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), hw_info)
+void pt_iommu_hw_info(struct pt_iommu_table *fmt_table,
+		      struct pt_iommu_table_hw_info *info)
+{
+	struct pt_iommu *iommu_table = &fmt_table->iommu;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct pt_range top_range = pt_top_range(common);
+
+	pt_iommu_fmt_hw_info(fmt_table, &top_range, info);
+}
+EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
+MODULE_IMPORT_NS("GENERIC_PT");
+
+#endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
new file mode 100644
index 00000000000000..defa96abc49781
--- /dev/null
+++ b/include/linux/generic_pt/iommu.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __GENERIC_PT_IOMMU_H
+#define __GENERIC_PT_IOMMU_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+struct pt_iommu_ops;
+
+/**
+ * DOC: IOMMU Radix Page Table
+ *
+ * The IOMMU implementation of the Generic Page Table provides an ops struct
+ * that is useful to go with an iommu_domain to serve the DMA API, IOMMUFD and
+ * the generic map/unmap interface.
+ *
+ * This interface uses a caller provided locking approach. The caller must have
+ * a VA range lock concept that prevents concurrent threads from calling ops on
+ * the same VA. Generally the range lock must be at least as large as a single
+ * map call.
+ */
+
+/**
+ * struct pt_iommu - Base structure for IOMMU page tables
+ *
+ * The format-specific struct will include this as the first member.
+ */
+struct pt_iommu {
+	/**
+	 * @domain: The core IOMMU domain. The driver should use a union to
+	 * overlay this memory with its previously existing domain struct to
+	 * create an alias.
+	 */
+	struct iommu_domain domain;
+
+	/**
+	 * @ops: Function pointers to access the API
+	 */
+	const struct pt_iommu_ops *ops;
+
+	/**
+	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
+	 * may want to set the NID to the device's NID, if there are multiple
+	 * table walkers.
+	 */
+	int nid;
+};
+
+/**
+ * struct pt_iommu_info - Details about the IOMMU page table
+ *
+ * Returned from pt_iommu_ops->get_info()
+ */
+struct pt_iommu_info {
+	/**
+	 * @pgsize_bitmap: A bitmask where each set bit indicates
+	 * a page size that can be natively stored in the page table.
+	 */
+	u64 pgsize_bitmap;
+};
+
+struct pt_iommu_ops {
+	/**
+	 * @get_info: Return the pt_iommu_info structure
+	 * @iommu_table: Table to query
+	 *
+	 * Return some basic static information about the page table.
+	 */
+	void (*get_info)(struct pt_iommu *iommu_table,
+			 struct pt_iommu_info *info);
+
+	/**
+	 * @deinit: Undo a format specific init operation
+	 * @iommu_table: Table to destroy
+	 *
+	 * Release all of the memory. The caller must have already removed the
+	 * table from all HW access and all caches.
+	 */
+	void (*deinit)(struct pt_iommu *iommu_table);
+};
+
+static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
+{
+	/*
+	 * It is safe to call pt_iommu_deinit() before an init, or if init
+	 * fails. The ops pointer will only become non-NULL if deinit needs to be
+	 * run.
+	 */
+	if (iommu_table->ops)
+		iommu_table->ops->deinit(iommu_table);
+}
+
+/**
+ * struct pt_iommu_cfg - Common configuration values for all formats
+ */
+struct pt_iommu_cfg {
+	/**
+	 * @features: Features required. Only these features will be turned on.
+	 * The feature list should reflect what the IOMMU HW is capable of.
+	 */
+	unsigned int features;
+	/**
+	 * @hw_max_vasz_lg2: Maximum VA the IOMMU HW can support. This will
+	 * imply the top level of the table.
+	 */
+	u8 hw_max_vasz_lg2;
+	/**
+	 * @hw_max_oasz_lg2: Maximum OA the IOMMU HW can support. The format
+	 * might select a lower maximum OA.
+	 */
+	u8 hw_max_oasz_lg2;
+};
+
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
+
+/*
+ * The driver should setup its domain struct like
+ *	union {
+ *		struct iommu_domain domain;
+ *		struct pt_iommu_xxx xx;
+ *	};
+ * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu, domain);
+ *
+ * Which creates an alias between driver_domain.domain and
+ * driver_domain.xx.iommu.domain. This is to avoid a mass rename of existing
+ * driver_domain.domain users.
+ */
+#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb) \
+	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
+		      offsetof(s, domain_memb))
+
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
+#endif
-- 
2.43.0


