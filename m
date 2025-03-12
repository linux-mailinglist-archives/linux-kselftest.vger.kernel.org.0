Return-Path: <linux-kselftest+bounces-28827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1EA5E18D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 17:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F7518860AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869C81C84AA;
	Wed, 12 Mar 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rnXY6dOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB891ADC98;
	Wed, 12 Mar 2025 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795923; cv=fail; b=VjEcvWjFPTm0nN4emP8tbjzWKgPgwwGAWtVOMt6iBp4sD+aCS0j2sAt35QT/m5KwYize3tsYS06biY1VSH6U6w3RXvmUGgcbd6sGVMcPS3eMlFKFYuC91t6F+9sCp/6+L4B44cUOBEHulgrlpjSgZYbF8jKru8+8JXs3411fIwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795923; c=relaxed/simple;
	bh=wn2S7zuTKMr0kXE4Nub6Z0wrF66o9WMsc7lVxtgT7lU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueXbDL4wfTlLEl9KS94ufT+ijkoTAHyNhdaT2zBSiolxdhp2KUXZhAvLleW2EZturSGZM2d87pTFjt3TaV0p81ld2DRxoODJEXiX0UG45CxEMarXL12DUHEiUl+UsHdC6Iu2Bs5lzf5c7MsK+WEgc+OnWKdyzPPQ/nm8qu9Lyf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rnXY6dOZ; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHpqJNHGjq5Djz9Bfh8iL7H7/cAnh3RFD3hAeOlGPUJC93t4WSmYowu15R8kZxTqODsvUlDw4Dp4083jxFwytT/wOdZHHgKOgmrGpecxCFUN0uH672qZ/ybErln+FML0oAEQ9MXacWAlKuuHjsW7MMZM4DCm5JTrI3djlxh9edMj2hQOAM75C3UjO1cao3NyJg9tNEMt5iWVg4A80aVYCIcEONI2dUHsQ5a00cm7m1+ncDHg/MP1nZbTpZITXH914E8M2/T/a9g4yWynTdfh2Qotcz5zOqrCpQD0fth1ALCD/D/P4ukjFMDYeABxMcvWYlI6WiYsTdPNslu36EUhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpnmuU6UnZU/vhW0oJrfVwZD1paxBq+c03L92hggNdo=;
 b=bEYMBc3GV3xNxg89trPLJ8GpvdhxWegRDkYwOS2N2hIH3ZkHBnw56FRzJKIoo2Tbp1OkEgLnqCsolKObiIsyxCS+36vHs4ulGGu0/okNhV/8lxW3GZw6aJSJwlGFrNbTXQOouzpsy2v8VYmVGdVPtfz7eekXZw3ajSn6/gYYjx+W67ooI3LqESMk2r+G+DYXdBXToemMnP44/1dbu5buVfqhuQl+rkGvI/93PBYoGwYS7hFuEsi/50bvwYYP9lYfJ7G6wL0wjJQOaEQJWQ0STH1uRZ+gpH2SvWmTAnlA0DEEsG2jMkZZxt2NnDz/+C57iKnt6b0f9SWDOK8+EqU/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpnmuU6UnZU/vhW0oJrfVwZD1paxBq+c03L92hggNdo=;
 b=rnXY6dOZglEmT+ZzXyoo5BkUKZxHkdJ/BCpJyyj8zhqOiqU/m4KvMgkY2pgvhfsg676ol7UjGklYzCHakyCXCjAufBKZPF7nPzM0dKOCYWyTZJN/CUpo90lIAgjtF8XE38qGVS1PM8vFxTX3GwgTtfTHKAj2LXHX24KF9qznXjwyBAbWNVjsDJ5gzcuQPA0UriIPzFFCq/kzM+M4jvk6xvSA2nhROA3qb8di3H/GYII//ULzxWh1PU6JKsDnspTw9V4mR11kTzn50MGkbtmy6M6LM3Qx0UBC4b7kaA4ElJsy8NRfbOJHFQ7eHZYDzvGE9f1jpo4HdTtMVOy2wwOlYw==
Received: from BL1PR13CA0277.namprd13.prod.outlook.com (2603:10b6:208:2bc::12)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:11:55 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::65) by BL1PR13CA0277.outlook.office365.com
 (2603:10b6:208:2bc::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 16:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 16:11:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 09:11:36 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 09:11:35 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Mar 2025 09:11:34 -0700
Date: Wed, 12 Mar 2025 09:11:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/10] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <Z9GyL0Cvzf0/imHU@Asurada-Nvidia>
References: <cover.1730836308.git.nicolinc@nvidia.com>
 <20241112174507.GA35230@nvidia.com>
 <da17905b-f877-477f-bbca-9f9ba3483c05@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <da17905b-f877-477f-bbca-9f9ba3483c05@amd.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 733a67ae-ab06-44be-a3e0-08dd61809bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZUxVWR2OthR3I3SOo1kYtMEsI379fAFrCciSihGgqDEasQ7MXVeBRyBeOtLz?=
 =?us-ascii?Q?uNpGvETWNyMF7zCdWjvc2dMqkZjVeZTWc0xH9Jji0/FYxh92vwmk+WizWilV?=
 =?us-ascii?Q?AiDVfNz15W4ILVD5psq7jvT+y6dxdLc187eGCfC7kBua0naJYUgAEbWhMgw7?=
 =?us-ascii?Q?fM4sgV2s9BnNWwlu6lrXQlliXwGKhxBn8tWDJXB46en9Nn5GNSvwrTqSXWEd?=
 =?us-ascii?Q?8j636Zw9qhfMa2h1JZGlFgOXnlFcTOaMCIo4nNcxLFUuviP4IlaGvLxO0OFm?=
 =?us-ascii?Q?+FlFZURrzBTHdxF+umnxWMbKC7M9PCUDLBJZmUAOezeGVhu3/DeyXygTY1BI?=
 =?us-ascii?Q?IdCJ5txKtct5BZVXri5z5EJ/Jl4vkKoOSwcuackxOi2+dFzzcusr6mSGg2Qw?=
 =?us-ascii?Q?cRuS8gxL9lRNXxTeCXfmALZjZhc1D3rKsYVWPFtMHWyh9ty9XRXS9dO8F2ob?=
 =?us-ascii?Q?S8wUfabui3Kt8AFUDh5NMSz/ZdxQPGMi6dWlAOV6U2KTOKuE5o9o8TlHEVam?=
 =?us-ascii?Q?8cwtB19cAXEoEdN9UmIoJjRmqK86vQdhUV62fHHuZtKR9HizGwXXjKyBuuBg?=
 =?us-ascii?Q?CfVqS1/NYkTnUIxuwXubVvV7LBbhMsWLFg4SH2JgGP9K0kOxVKKwyk2jUZv3?=
 =?us-ascii?Q?02UOJ0bjLzToFRcz+NAaZ+vId56Y3809HDD/0vQiZxMlPye+jmfHCiEzXPqA?=
 =?us-ascii?Q?5U1Ht6b/FPl8yzUmG4ssCIhRcW8YFoVk6+Q7lFxHf4rLab3KSeFHzZ59IL1U?=
 =?us-ascii?Q?zTlrzTRXlQ/MnW/aHRCSCD1jMIC9Myb8q0VJ7UKctmP3ANxgxvHVeM2KRXwy?=
 =?us-ascii?Q?1HL4mTut8A2L2vZIsETd22FO0X1FDf14Q0SkB/vXeAV52LsMt/k7SBjAilV8?=
 =?us-ascii?Q?MKQiBRq55Q7PoEU1iHS8v6d8ehJxY6SN94UzYeCRbYkTlg9I7vHniGyWodkH?=
 =?us-ascii?Q?af/chIVFDaDTlAvYxxOG0hhEqrHn89/qJC5N8M9LmVgpaplELHZOwc/jq4sr?=
 =?us-ascii?Q?4QxC68CZERfOMtT6q2Y6RJUeZ4AHPfziToBdAS7aqOR7MboHG7cS1fCU67kf?=
 =?us-ascii?Q?ouY+VQxNgTlZ5GuitaqqVjlXLYYKNx0gmAWIeIqFF/jWtQKVKaChiNK8FWTL?=
 =?us-ascii?Q?92Vuu5mGIN1PyQDBIo/DlGZUw9uv5qL4TcVDE8K3D2TP5S+zeOLMZdEe5PS2?=
 =?us-ascii?Q?y1hKVOJEU0UM+150GgcINpPU43J/P/mZdJ9w7qVxox4B8LeyV9klFK9i4EXx?=
 =?us-ascii?Q?gc5R5W06Lw73NZWV/PHvQaPz/NWYr2+glddRbc/05/Yc7VkzInhjaXRXPJpR?=
 =?us-ascii?Q?4DaQdN5J6RLvC6wecPZJMTjtlw3r+Eou1pZ/0LD9L2YObQ3+U5UQ3T2FZMbX?=
 =?us-ascii?Q?tlgz9ptlmLuAMzbFE2qjRavm34xhHAknM/lwEzet9rprM4B7ILg0seX6Vt89?=
 =?us-ascii?Q?uF7FM5zzzIwQG4ICZDuheaXfKhSl/tRl1VzqqI/ML1Bu88CwLVJeT/VXQh7v?=
 =?us-ascii?Q?VFOM8gUYxGzJCvI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:11:55.4656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733a67ae-ab06-44be-a3e0-08dd61809bf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438

On Wed, Mar 12, 2025 at 04:27:55PM +1100, Alexey Kardashevskiy wrote:
> On 13/11/24 04:45, Jason Gunthorpe wrote:
> > On Tue, Nov 05, 2024 at 12:05:08PM -0800, Nicolin Chen wrote:
> > > Jason Gunthorpe (1):
> > >    iommu: Add iommu_copy_struct_from_full_user_array helper
> > > 
> > > Nicolin Chen (9):
> > >    iommufd/viommu: Add IOMMUFD_OBJ_VDEVICE and IOMMU_VDEVICE_ALLOC ioctl
> > >    iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
> > >    iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
> > >    iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
> > >    iommufd/viommu: Add iommufd_viommu_find_dev helper
> > >    iommufd/selftest: Add mock_viommu_cache_invalidate
> > >    iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
> > >    iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
> > >    Documentation: userspace-api: iommufd: Update vDEVICE
> > 
> > Applied to iommufd for-next
> 
> Is QEMU support coming soon, or any WIP patches to try? I am trying
> d0375b6e85be5c71 from Nicolin's wip/for_iommufd_veventq-v9 for now. Thanks,

Shameer sent RFCv2 recently:
https://lore.kernel.org/qemu-devel/20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com/

Thanks
Nicolin

