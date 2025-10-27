Return-Path: <linux-kselftest+bounces-44125-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C53BEC0FA6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8AD74EFB47
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30F3168FC;
	Mon, 27 Oct 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WaZo8aTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44158314B9D;
	Mon, 27 Oct 2025 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586279; cv=fail; b=eegcXMSPAssT91BOocqvvMgEv4dtaGy8W0S8N9JfKsZbNIjRXtdiUM45L45pMKrg7Hosr8cCsCMajDMfGoil2PJt3pjydybInMWP7z6xX+7CPrhhKsA11RQ2FDZfcJyFOYmmCLd6O7STGhjlEl4zYMJkOUD9TaKurYYJzbFBOYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586279; c=relaxed/simple;
	bh=Na5qTz7qA52x4qcnnIdy0vOi+D8PlY5NdZXR5L/nSLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Iw3GcTxZ6S3jLicVhSbNhs3Gvwl7n8rZ7EuD2Gmy9YI7b3MWiVNId1mZZOz2tOlmAH5r/P1RaVgehJibHXbYXRsuE+9FY13T0CNFitbaiEuy4dbgVuXcju+3FQ3FGOmPFLghTxXN6W5KOKglsfTxOxhmRdATukBbgzn1lMrSo+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WaZo8aTS; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI2DGRIj9bbIuPjqViYTyXzS4IAVgu6bYBHh0JIFgX9p7vF0BHZR1jt8qUE44yS8K5odBGiHvE83BN6ZnMUW5j8EK8eX+I0N5Zf/2cJGPA/YIIvO6eUJ4rE1FMk8CCsp2tQRCu9WeG8RglfVoqmYKlw48SDamNZWKe3V7P8PAcqbZxNMFnztz0rd3+A+gqWyUYcjj9catqICPyiXt/96fj1CMMA1enjUB7qqiFQdDMJX4Y9AFNs12Hx60XpiH/9JQ+A31zoujroLH5hHAqnHjc86woLGhncjw3ZX0cj/22ZjlAhOkOg89njPsAh6P/sYxaNR4CFoIwarTBk0UtezIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iFhn8J08O8PYujndf4znn7L0ufuOX3WKb1SQG88Nqc=;
 b=y+3Q3ByF2TFiaYI3TTQOMA7Rtym6DtPeV/sfuQvRj8UfiYGj040gqwq3mRp2+Zsam76ogPzCPs3XoVyX8iugs1HnH9EJMXTvwMourOjHG0K/6PFC9T7XbUGQICzSYEfxPOJ8GMnWd0pDJa6v2QMU5EBLWGtrlmLY9hTirJrzIIWPLdOpDzdd/cE+b+r6HyUo41Hy4303fZ08t+ukH7h9MFI8v1X9XKnMHgAAmKhuinlgo5FH1+hYFSMPXYVbsZkhWAEjV4IktdTOysEB3NQQ8eZTxYfhXQkLag5H9OXvc6krhmy43+t6VJO6cE+18KZBIhoYIydL2XJNhx+tshuFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iFhn8J08O8PYujndf4znn7L0ufuOX3WKb1SQG88Nqc=;
 b=WaZo8aTStHddSt07pAjSCekaC20n0z+8JRhi2+9zFsXP+N4I9TNHkM7hwxfgkxD9K9w2MFpjaeXoiiinGqUOO+mubakEaXdowRp0Jll7DWCZ+/Klm/s8VpCyGpoBobJDVTX7Q5zeA2gHhq3OVFTkI+A76JaLkqGR8DAUoUBMGHq+pPzwMpy1u54plbGEJlXIBIW3e72WQ6uqTpARFnlFX6ZGsXGOTu9fQ0ncJNuU2m7c/6TS9Aj+8lAvbOPiICktUmIOsKeWz9aimFy+9ss0PoJ1HoxYaHH7U0PVYfFupJl+Q72NGjVeMF3EqFdY2E/KqgWIxrp/lBJQB9U4RKSejA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:31:12 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:31:12 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 0/8] Initial DMABUF support for iommufd
Date: Mon, 27 Oct 2025 14:30:59 -0300
Message-ID: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:52f::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d069eea-2b42-4c13-fd65-08de157e9e56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQoL0mk7YvNxdQPD9ZA8UsDYaQdhxbmbE8XX5+Y8vWVdbxxGuwkiHwvZ4XSj?=
 =?us-ascii?Q?JlgrO5h1fNVoRzQprk5MhOwh4HPa/3OYnnE69zwrKN5Hf6pP1pj9vIXy0hjL?=
 =?us-ascii?Q?MmUgqQl0IFN2I+6H/+gkbI3JP+a0efCKm3mDQNvGzG1sn6aNqSgvlWCyH0iS?=
 =?us-ascii?Q?8xn5XLIOXYGAvqkgnVpMZLyH9PBYc2zHBrrzFZQhBKOebuaqyVFgO4RkmCsS?=
 =?us-ascii?Q?jw/GuecOrQbm7ybD7YtaSdpU+hThVHjOsz9yJRhGuWUghAEJP7PeKrjRq8Mm?=
 =?us-ascii?Q?Iucrfex6IZl5qm8jbdepf3wXbOetbc49oLMbcZ1TWhY4cQnXk2ZYfToijFL6?=
 =?us-ascii?Q?oigR7BQyGBADVu8Im7zBCW7jtGugn875sRqmfMntZ2OoMK89gljdVWmjLiBs?=
 =?us-ascii?Q?FrSOQkM8WTmMejhGUxtkA7dr7jZmynErof0mymD9lDeoQx3uXo5kBJODTIz7?=
 =?us-ascii?Q?8CEwtMfSBs9ViRB1HSoBITl1yHTU81PxxQLo4RgrO0qmKDwgICEv6h0Ro4Cs?=
 =?us-ascii?Q?oJay3Vzr66kLGpL/z9Kvp5lglujn+80ZVjgOqEUKxetih+d4NyMFVCtIOqwg?=
 =?us-ascii?Q?cK5XRcGLb9NJRirSc0CY4cY2jy04pffO1uykDUTp/2u1MJV77r/piGPk5poR?=
 =?us-ascii?Q?8fIxVz2EU3HVa1bbD7a5cNYNPuT4+hvG9ctZ/k6JwwEIKfyEe0TAZJwcRyRm?=
 =?us-ascii?Q?XQH5P020OI0nESB1mzwjAfWzPKfx0j4EDVno2ZPkvgc4ds9rs3KSFvaSpJjw?=
 =?us-ascii?Q?XQD/fRRz7HJubshbSDsqeVPRAq1Bqn4S5ow34a4I6I9iwGwZiYsXIJ1kAxzQ?=
 =?us-ascii?Q?EPwABF7rAis5/iiQkrvq7vmANbEBjdmZrgpJlbuf99jZIQbrBB6+GJxJG/T+?=
 =?us-ascii?Q?k+XaXn+WI5m3v/zJWZb1Vr/qq+kWSdVXBDC1asKtqD3aiUZbF9ZvpP+XEfcd?=
 =?us-ascii?Q?Zuw4L7hTqAshKfHdxbgWL6ZTo26EzE3pMbiXiLWZOVZn/iHk2PcZlQ+XGdqV?=
 =?us-ascii?Q?PHAoqMMzGxxBJuVWkxuOwyxuaOIp06ZvNY8GKLDT9i0QPkl4tAceTu4DT/ek?=
 =?us-ascii?Q?ysCptfruiS9pEvDvmH3inFXX72CTlxkncBQFGmgYUssj+7TqrLkKAvD1PViK?=
 =?us-ascii?Q?vpz3blXffnnqWXHHOB7r4vIOaT2oaUcL458r7I4Ic1DRJYVTIZzK/37VlqoF?=
 =?us-ascii?Q?LWtKOMma5k+al9Y45uOH9LK49EoRGhAp0DlICKP3raF2Vk/VPYrj3ulPf7HX?=
 =?us-ascii?Q?IPUKkqbnbxUt6X+a4gprZQDWD2umMphOTSUvmL+Ji+wlDogfeSsv1vUKUdKE?=
 =?us-ascii?Q?05vpi0MzoXJ6gBGf4st4sFBq47Gig+3BnTIPm10eYPIjyUuA4+Qry6Yitqb4?=
 =?us-ascii?Q?VgF8mti7l7sCiTjYdMKwHSfcr4EJximY8k78PNDwohV+wOQPsU++zunqiG6O?=
 =?us-ascii?Q?ZBB/st2t6+whGE6JoA5M/vA7cRGs1Q5baON5peMKI0lIRUebBaIwOL4hOq70?=
 =?us-ascii?Q?ykJsL2au7EYGBVyddnAJJ5gcYb8DbSdjr56f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RSk/OAKqzptByfPxCfSv8BK1PXZbutwspzktrw5BCzOTx5exu+eqr5dkUOA?=
 =?us-ascii?Q?+WKuQqMVzH1SLG8jG9goty7qas8E6Uzp1tIKypgseE5fxlbPTMORc8oskYuw?=
 =?us-ascii?Q?Hf3XBeKl3kzan8HRWX5zND1tWgAg7hEMDkp/8WdLaN9103kNkpJ886P8leCp?=
 =?us-ascii?Q?/6b+J0eY/BPjzTfpbM7aqs2N0rescAGGg5XL94HemNyXOHrIrIP0x7NWGDW4?=
 =?us-ascii?Q?yHltbnRVg8/S4FAy97pJJR1J1uJcrHgGg7ffkfOCCFP9aoSrkdvS7pZI3pVD?=
 =?us-ascii?Q?DT9RcGXHeYocTWgOhceM6nW3nsQtyPbq0FqfYrLgj5fnu1Ebmqgl8tE93jeX?=
 =?us-ascii?Q?KAxJAIVawjzj+xbYOWvD7lCPyNTz9RocfIP8p6fdsbUnPcd6/JVT254x8Bri?=
 =?us-ascii?Q?PDmMwx1g9C9yw8YUbyxbbR7nhv1Glv01Alikrggr9i2wewImytls3DdjmAO2?=
 =?us-ascii?Q?WnQGQqwd47Mt89ZR4go0pWyZ3Jzo0UmMGXWXteCUueOzUt24qVX4KdhRuaS3?=
 =?us-ascii?Q?gZspf87lETM0PRcTXbVplZbRPJjcZhu9thyWZdUFv8j/Fr5T9WbLmTuUhv51?=
 =?us-ascii?Q?aHzFH6KQCywJ3RN0pAzaTiQICLT6DOK9GRpyfh0MrbSmlGSJHBz5RGFbpNNJ?=
 =?us-ascii?Q?gt8DLR2Y5kc/pmgVzdlRb4VzX0cmUZ0ADLQvIhF89asojCDE7qRZ6pDBjsWX?=
 =?us-ascii?Q?nayHe+bFozPQSEih1CUZoH9JY4bPLl/XMJpwwSsGxCeYLIbVtLkBIIBxPG21?=
 =?us-ascii?Q?PpXRoceAHK/QhT9m4CuZxFZZAhjHq3VOf01AxOfSBaE5F2l8CM1ctZeZxAR0?=
 =?us-ascii?Q?evh/Eko6bvAqfIxFkOWXxNWf83kjjTuBD7zkVmwULWI/h2PMuWs0ZfdnZ+Ho?=
 =?us-ascii?Q?CxrNXGERXqhIQirP7es1MpRy9JVXDod+VdTo0rcUXXtZD3TJoP9gubp9G8eB?=
 =?us-ascii?Q?LBoq4arvjTu98VUXuLQvMZDcidiwOQ+Ix3z7XrzEQp9zVaACXD87stNdlUBh?=
 =?us-ascii?Q?kP3IYZ4mdlEUYq7q/mlGxkMeQZQXogiq7HbOP2cTRCSlHOa/VjlLqteQ8aA7?=
 =?us-ascii?Q?xrhC27KR3ExYvQp20mU/H3w8nihGgDLrQ9RNJxSF0AV2piuAb2bmeXzOZQae?=
 =?us-ascii?Q?YyEQnsdbmAQ2+RJGrjDXpitWMr5tKQM6ax12eaj94iTJwQfhmPEHbF0TP0e2?=
 =?us-ascii?Q?ekpfHBSm1t0kZ2s7IErGAgqdkgRjvqJisk7OqdiyYhmA1EDwcMjbQOy8cvCp?=
 =?us-ascii?Q?ypuP4+9z1ZkjJdeJITPPSy25A99cqQBOWnoaYbsBX8sELbxdAi6TKGghMsQz?=
 =?us-ascii?Q?IdgdmIxftvVZUTw9Rg7qqum0O/QpID8h5PYT6Yt9vKXW4foDFkPUaR+hAYq6?=
 =?us-ascii?Q?K6A0QD3CSeZVmbMvxoGNb/lGtXC0vmErE/Pusf/Uj7uAdwqzsON2sTt2zy7s?=
 =?us-ascii?Q?xWSKhKRlW5X15G+It/DI5P+T3KMdUT4aJMy2mceuY17w6x+x5GfXbTeTD6OJ?=
 =?us-ascii?Q?fLdMqaeYy6w3z4FFKn0tVbMu3tnZ2o6iVJUi36QxaiOHCdsD2S3p/CnIJxXT?=
 =?us-ascii?Q?cWEhObjtxHDy3jlk1TE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d069eea-2b42-4c13-fd65-08de157e9e56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:10.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD9FwOx6fQ6ivdoE0r9JpMgQhlyQQ/bvRucdKixdL0SmTAP/HxsfBnXIUp64QSYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

This series is the start of adding full DMABUF support to
iommufd. Currently it is limited to only work with VFIO's DMABUF exporter.
It sits on top of Leon's series to add a DMABUF exporter to VFIO:

  https://lore.kernel.org/all/cover.1760368250.git.leon@kernel.org/

The existing IOMMU_IOAS_MAP_FILE is enhanced to detect DMABUF fd's, but
otherwise works the same as it does today for a memfd. The user can select
a slice of the FD to map into the ioas and if the underliyng alignment
requirements are met it will be placed in the iommu_domain.

Though limited, it is enough to allow a VMM like QEMU to connect MMIO BAR
memory from VFIO to an iommu_domain controlled by iommufd. This is used
for PCI Peer to Peer support in VMs, and is the last feature that the VFIO
type 1 container has that iommufd couldn't do.

The VFIO type1 version extracts raw PFNs from VMAs, which has no lifetime
control and is a use-after-free security problem.

Instead iommufd relies on revokable DMABUFs. Whenever VFIO thinks there
should be no access to the MMIO it can shoot down the mapping in iommufd
which will unmap it from the iommu_domain. There is no automatic remap,
this is a safety protocol so the kernel doesn't get stuck. Userspace is
expected to know it is doing something that will revoke the dmabuf and
map/unmap it around the activity. Eg when QEMU goes to issue FLR it should
do the map/unmap to iommufd.

Since DMABUF is missing some key general features for this use case it
relies on a "private interconnect" between VFIO and iommufd via the
vfio_pci_dma_buf_iommufd_map() call.

The call confirms the DMABUF has revoke semantics and delivers a phys_addr
for the memory suitable for use with iommu_map().

Medium term there is a desire to expand the supported DMABUFs to include
GPU drivers to support DPDK/SPDK type use cases so future series will work
to add a general concept of revoke and a general negotiation of
interconnect to remove vfio_pci_dma_buf_iommufd_map().

I also plan another series to modify iommufd's vfio_compat to
transparently pull a dmabuf out of a VFIO VMA to emulate more of the uAPI
of type1.

The latest series for interconnect negotation to exchange a phys_addr is:
 https://lore.kernel.org/r/20251027044712.1676175-1-vivek.kasireddy@intel.com

And the discussion for design of revoke is here:
 https://lore.kernel.org/dri-devel/20250114173103.GE5556@nvidia.com/

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf

The branch has various modifications to Leon's series I've suggested.

Jason Gunthorpe (8):
  iommufd: Add DMABUF to iopt_pages
  iommufd: Do not map/unmap revoked DMABUFs
  iommufd: Allow a DMABUF to be revoked
  iommufd: Allow MMIO pages in a batch
  iommufd: Have pfn_reader process DMABUF iopt_pages
  iommufd: Have iopt_map_file_pages convert the fd to a file
  iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
  iommufd/selftest: Add some tests for the dmabuf flow

 drivers/iommu/iommufd/io_pagetable.c          |  74 +++-
 drivers/iommu/iommufd/io_pagetable.h          |  53 ++-
 drivers/iommu/iommufd/ioas.c                  |   8 +-
 drivers/iommu/iommufd/iommufd_private.h       |  13 +-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 drivers/iommu/iommufd/main.c                  |  10 +
 drivers/iommu/iommufd/pages.c                 | 407 ++++++++++++++++--
 drivers/iommu/iommufd/selftest.c              | 142 ++++++
 tools/testing/selftests/iommu/iommufd.c       |  43 ++
 tools/testing/selftests/iommu/iommufd_utils.h |  44 ++
 10 files changed, 741 insertions(+), 63 deletions(-)


base-commit: fc882154e421f82677925d33577226e776bb07a4
-- 
2.43.0


