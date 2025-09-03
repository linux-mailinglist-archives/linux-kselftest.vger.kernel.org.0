Return-Path: <linux-kselftest+bounces-40697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE487B42835
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD56683A85
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA79432A810;
	Wed,  3 Sep 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJlqnv5U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1E29DB99;
	Wed,  3 Sep 2025 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921622; cv=fail; b=q37VHWKFv+TWFqWyR8zciMCPeAKZ5XGMffrmjRDAieVGCJbhTBzSaKv+PuPTMzPZmpA3PfwL88aPiTDsiCcM8R6el1SttNq276QgfR3kVtO+6LQEIrTOANQvkwJdmThKA2L5SIWXjJLhgLqyzucS+MRBheki5WAtcQVmijzVEL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921622; c=relaxed/simple;
	bh=fDXcoHXp4KV5huo6pB9XJ3YyaOLx2zGVXbJeyg9U2RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ARVwLPqmhcpBZVXhZZ86vi0pkGjWtaQA//e2VdhVjEbJzn4azaNwOnQCqIc4nKXw2WMlLvel1e5XKSbedL4UEb2e5Oxm1EtlDZ8xdg75E1Z7USby6KV6BDmHmAx6dUD5dEDaN4+gd0VVAnOeh0h7hoadFNuadYB4eOZ2KiBhYYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJlqnv5U; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZjTubdefLNeZw/OxL/3rZEFbwHcsgud/H8ww1Dby5xgk/3R9mOhtr1cLWj1a5J3jWwVJ7Q0RSpt8rK+orxoIiSrcQACIhZgcEMrnNOfbkkr6Xi3/PgSMICKZFNAajnpNf/9nhLn3QhKqldqnN2qx+3LWK5fR5/zJntbXoqXqqJpA5H4HoRXuEn/b0YGG0zvvGEaiFpZnJWHuEWpGOzh7XullGwAp7B0b1PSNz+gCtgh0yzX8TQAIEasse1amzNCxXDj0AeIO88UxyHuKdJQu69Aqkp8XYaLMcYrfzB7U7NCqN9Ek9VdexJZ0eggKMmKv5+zVfVxf9hkWsacsrWtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yffrgpGhH69T+g0fBFNPj/rAEjcIxjOLYRFpcT4KWDs=;
 b=xdZSwKa42+T9KpMMdlMsRMAdMCQlZLlJg3tpMC+jwwT9xTJbB0I66Z0r6VAsqOTKAMXXJ/xD5I9PiWmCjsrpKGjnfntMXnlmNRB89pcS1se1WAUYOrjre79aBvoyz7fvZlxmB4MONLvJd5jbdnQDt0T4N3MjieyLxemEGM7DhcpVT9fdkfPg5NEk7sHzMA3LZTmkOtDP63mZ6fG1/sizbMC1rXlQuBtrDpLqoc3tUr6Mim0OAvG3hvDHDjIwM957CzkMg9Gai4HNbyByBmke0d2NtmUhPw/jcycerIaoPG4oY6UjAYPCSI9b0C7YrtGrRVZHuhC4eRMOjhm4m/vXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yffrgpGhH69T+g0fBFNPj/rAEjcIxjOLYRFpcT4KWDs=;
 b=iJlqnv5UbBSyArTznGcRVYMg7tv7UYB3TQ+D1D2ESJtrHW36kDlNy5Uvp+meR4uuBEBoEhDdiIo88gTKAm9J8EwADYVsH2KDPixskF5znzc0DjavGyii6JIDg8QlxADA2pDRG4m5A3V0xyMcJqolcITxE41Q0QH1G8dGrXUJNFNV+G3bbMpVtkfaq/K+3frOXa/qKT4WfpgN7NiygR+N3J6AtYlwLZJpwslna4KJBOiL13H8UJnpYvsO9JC65k6RCrcJRCDXjOd7ncU/PwhtKR3uw4QVN4WvyulYMXUP0DtH/CKVkAKSlcqj/fWVqpvLUZzzOVbKUy0ZxU55OAU6Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ5PPFDF5E260D0.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:46:53 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:53 +0000
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
Subject: [PATCH v5 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Wed,  3 Sep 2025 14:46:42 -0300
Message-ID: <15-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::9) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ5PPFDF5E260D0:EE_
X-MS-Office365-Filtering-Correlation-Id: af78af0e-1b5e-4ee9-f5ee-08ddeb11da01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+8UCtycUGKx1qTKAnx49gUI7/g+kQHVgofJO8Ma6Ou6BZN12B3QSxE+JxSN?=
 =?us-ascii?Q?KooRny5VkSe9ZDhC8bhmFyuDr/BtX03WSeHgIheJWjgq1oaAgdIQjTFrymgt?=
 =?us-ascii?Q?+uJU2kuEdw6R274lLxMUL9RtsAqgQWa1Icsru20Lg/Nhx++lRWqdp2mvkMUt?=
 =?us-ascii?Q?xmMp7EPqFLXRMiOnRS70eEA8tqZ8Z3wPqhQrGUKjfDeg6QXCI49ZEv0B24BK?=
 =?us-ascii?Q?4Prv3DH3cxDx2znaSJ+tWSSW8K3p55mxzlZzdGr2mLr8juWDiy4fUdzB7aOa?=
 =?us-ascii?Q?/kUPxy7Qn+6yuVU9wY22PsygHyWaaCLTXNqkbHP28c61Zk3A+QSn4pBC8fMJ?=
 =?us-ascii?Q?DF7lufsoFi1AoXR5FEXaZLLJDQKCRqJOQOqxOfEieVZQwIpF0nYF6yFwyc56?=
 =?us-ascii?Q?5ViVldc2bSac4Fr6SiyDVXbJQQ+LrU+TvKHgVKi/sPhFpTeK1gEpYY7NySKQ?=
 =?us-ascii?Q?lm18KHv/PwdN9n89hf6J8ET0JOQtFXyWR98oGwyAlu+XGizopft/2/oAnBCD?=
 =?us-ascii?Q?8OoGAEevYInjGlcV68XjbF5vn2XbdGmcvKwxemOuhxD+7aZszZi5orOVE4QM?=
 =?us-ascii?Q?U470ae0ZTZAoJD4LvrUQwKP/sDD+Zikv/VLSyP+HnuBPc2eBEgNf2dEqxcdp?=
 =?us-ascii?Q?CGWmxMNnjtcUxjVJybRL7VtW85qmkvT+BUYX3QnqkLfq2JGh5n4B1WTsWnkX?=
 =?us-ascii?Q?TNDI+wE8nXgTs5zW3+okyh4r/+Kfhx1iznKneKEixli+GSRVuf+4luzabzFa?=
 =?us-ascii?Q?muhtdgtPRKh7Vq03bB3ai+x6ipJg6KpZ9d/B7My8nEY863jLMKAMURnhJGq2?=
 =?us-ascii?Q?b2fuuhZGHBR+T/PUnT57eESbMpWUIzmf+JoFuV7v7roSwW6VrXUZSAzVL6Ip?=
 =?us-ascii?Q?R4KhbiUFZaTuyZICybUw7G4BXg3afgANed3PD0c8CtHx0AwPWZj5b/Dky6Og?=
 =?us-ascii?Q?SmORcW9aEJxH7T9OliyzHwC697VLnVdVuUExD0nksj3N/kXBi9o4HTNGIA5c?=
 =?us-ascii?Q?fZvooX7k8wfxYePeLwenTLgOpV16arQRXo92W8cYxG41lYBwN5HzvNHOVUqH?=
 =?us-ascii?Q?M1Lmt751kJkvgS5fxSZ4mXsVKclfb/f64YMYdUjQdoqh5RpTd39yzcHE8tWZ?=
 =?us-ascii?Q?fHTGjstweFwSSHIPmUq83dWMAB2yu8ugwDOycJVOK8NtU79jCYSoAt4iAhLP?=
 =?us-ascii?Q?ahLyDps4Pe6c5uA347HRcohSr9ux9Em+YDI/7vEsHd1AILLiurkBdSMMNw8Q?=
 =?us-ascii?Q?Ug4hPD2Bhjt8WLaDS0jJ5fqdJvBE0vZ7X3cERenALIyOr3md/I0J3KiQndM4?=
 =?us-ascii?Q?5jDvEWkKr0Adb1AqSFFWQFya3Om4bvGXKM5J6En96tJI6s4zXhFozMNNOeLQ?=
 =?us-ascii?Q?MhyDaaUDArVW2gJjJRcGdgHsTyIqkQU6YKVQbaIARFqQg8H82sS3yPjiazvI?=
 =?us-ascii?Q?oShtxubd2qluY1/CyWZ7z1XYAFT4K/MKZK0D1mAcaW8OoDJ6eVKEIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EszloOG5P26QZ4P1R6ydbCSwRrrundQPToedZ8oEaSGF7tHnBd6Zxv19w1g4?=
 =?us-ascii?Q?Wi+PhcWOZtxxoLywc/BLrKVtodVrhy+ukFy1F9ugUyzdc15RrFp06atd7DC+?=
 =?us-ascii?Q?548wWaLt0PoPES6JKvYBcsYV5jh06z6IWu4egOjNGR7r2FnPn6TOiSyFRZOK?=
 =?us-ascii?Q?QBvQMwgTTocbP9XkdMyhl+ullGoSPH85jRhfyFgpYEjiigcRDVSRfdTGO+3Y?=
 =?us-ascii?Q?Qp5L39VEzfReKqg9qyKQu5qnJbEhVrDbB8Wuxc1QVOtewBHZ6q5Gi5mZKD71?=
 =?us-ascii?Q?0rcyuNT3ygJjJ+cQa6MavcH6IEHjzBslnDgpF2GivAo42e8rhEVS5ydo7U6N?=
 =?us-ascii?Q?UgpJHl1dY3vSZ1t5bxDyhJJ/p45Taj+lkxV4ktRsbRcqwjmOwDQ7SNIu+flH?=
 =?us-ascii?Q?1Uv8uWGynMOaauG8rsB4Aih4UQ9/O0lIPAM9/x+MntbVpSQFQNT0YCr/ye0I?=
 =?us-ascii?Q?H+HyDMHnlPYFMes/7l4XzMxNSinfDSbDKZ2FE9+sSQ3zI4CU/CS+gYhI9l6z?=
 =?us-ascii?Q?GWy89A6Yk8BUSRlLvX/Slh46Q0fgktXNCJVRC8/qYnIfS2Pb1SHp4DtokK1m?=
 =?us-ascii?Q?nbsjmFrNC69NxnDPCi+li1HlPzEvRGtdfuGwDx6AreIKfEECgA+8iXW1627I?=
 =?us-ascii?Q?wZTj3C7vlJ6IeWvxC95ajrcSuhkoUVVPs9aYaWFjlC9uEtELZdFc1X9bDluZ?=
 =?us-ascii?Q?wtPCtADmA78LUl8T0dE9a0zWtmlmzgqP4/h1adWFdPtis8CbjUygIObX1dH4?=
 =?us-ascii?Q?aK30tXyvHh5mAyCijM3LVTH/CdAD9n6+6dExmddeKQ1ascH0Gp72OLYFsIHM?=
 =?us-ascii?Q?6KKLRoomGO++ZWBkZkYoNaWy0Kcb4h4wb2ZcH3guBNq1HnxVgPwagFZiTxdg?=
 =?us-ascii?Q?ArFrwRpv9U/ToRkZReq47C9xqh+gAhiDqXyqxGApwWxI1fSU43HKLUfIP0IY?=
 =?us-ascii?Q?8nYirWVOA8kQTvmYY7tjivBDQuqdW+fx/G/jaoVsVASeCxaUlz7Sb9WA4tA9?=
 =?us-ascii?Q?RRncKgtieIIVILlkO/0hQwnegcxHNvPWR1T9oUCNg7fBrykZJbVnvlfXd1r4?=
 =?us-ascii?Q?l5F9rVFfDwdlWCP1p6YWhYSbyt35lKJKCQC7oPFozbLG4aCRZV7f7GrjNjx2?=
 =?us-ascii?Q?7ocl9APaXv9kgea9KneXOwZcFZyx80/QALJsJFGRF10yQFbicagowLEFeW/t?=
 =?us-ascii?Q?eijaTN8bJNbytzDRwiSGxufJHSgoXsABu3HVDXUicNWe5bepA/VU8l6ncP6V?=
 =?us-ascii?Q?bjWeaBzYDfK82c2akYUYdd3zXGLApMHvd6CRvxDKhvQuMnrrp2ouqy48Q+Eu?=
 =?us-ascii?Q?AweVRzje8A3hKrp7IM+tdzzNbbhRxpZQ967YdjGqpjw76uNkayYeI541tTa3?=
 =?us-ascii?Q?Pqns2D5SsXi6EvvJGwKqGv1kvvhzMHSpx1bYdnZbHgTe5LFeST8MZYSxosu/?=
 =?us-ascii?Q?Mzd1OruCHrGMTfSgWvsZjYQMfk72SAWUwK5OQuUvik6wl2VK13byAan7lAQk?=
 =?us-ascii?Q?+unjWUeBdSBuNIc5Qj5gkkqjkN3NMZf7jNCIcI1Mq9quA6LPe4t/dCjTuosm?=
 =?us-ascii?Q?NHrLPny4Br9jFawvGeU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af78af0e-1b5e-4ee9-f5ee-08ddeb11da01
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:46.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVB5SJt5Y0RrzI9nBsxw69iZGaHiFBKlP6HGpHivOTdvimjfzOLId5Y2e17fFRsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDF5E260D0

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit tests can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=100
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

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
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


