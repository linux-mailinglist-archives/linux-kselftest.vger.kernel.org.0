Return-Path: <linux-kselftest+bounces-45520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974FC5612B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 08:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F3A3347170
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC732938B;
	Thu, 13 Nov 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LbwEYlhQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA20289811;
	Thu, 13 Nov 2025 07:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019301; cv=fail; b=j5+VMFWQdwGKSRGogbhtOk7ZNuSkCOtZ7JHVoEByvqZNrlGngV3nIyfVUpZo4VwgYuFanHhjnSGSKfP0dzTqAmuAW5kbwxtNNOF/YXdcqRr/C8HsLbCwvunMF8C9ZbL1bP8C21y/ILUy/Cf24OZ6tid+Cpp1FFNTxRIarQDnY0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019301; c=relaxed/simple;
	bh=VdgN71Y472ndn1eHAM1178hUgCslTQqL8xnilIYACbI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3nUgUwwMEPwfqyVMHpJBPd4jGVSEvurvTksdDTaaPKWTo+LEbZSMZ8sm9osOu/pHVAezdrRRjWj0NB0+8TfnpSxD6ziuA3knJUN7Ki/7njKCW/H7o/WpgFopZRioHYkHKkPzFvIs6XfEW6D0wkjs4Rbz9ohecuP5QaAWUdz0Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LbwEYlhQ; arc=fail smtp.client-ip=40.107.209.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mndNhZJbwOjJrTZz7tRcq0FEhmq0BDXwS6vFz3WC1cweTc5L+FbBcJvnDmGaKnsaS9o45moI6OWQWyNZtVDGMHXvDWWkGDeJ4chgCNYdA+RKx0lOahakZgZLgKnjAZn3cxizLjGTNF/x8ffBa72xQ7Wv89FIAPfcV8nCpjhUWYj4G+HouP1nkhBN1E2DAQPF+TYxuiEREvct94GqNhr/l/PFZ8BwLFcM9v6wCeUjgjB2fWzDdKGxKaYodSVOwyTy8wvGJUteZXlHFsPv4RbpYmypiTgG0rjKCcEl5IMUPSYlAsgCOAHAzq4Ih+PpCkRQRzFlIjVxhcsf62GqoLm3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCZ0XglH34C/Iul5rD9pykqKZznnRfeyxZ4h5peZcrw=;
 b=cPLnnTlHj4VlwYPPq2dm35m5RjKFXjDWGSDTjptqnYxFQmLn9RCAx7xnOyU4AN9e1DHUcsJyGFTTAbaNM5VwHBS21CgqRPla9dkjJNJq390Z7A1Uu6MD3kdzSb5pq/hUCi8b87FBziyNFvch1i19EvOp/illQ3IzIwZUBYJ/aR7A9JbyxPGUPbpLbWU8am58B2yEMGhmvyhTfIhca8MzF7x7UNDx8a2qtaDJ66YXyyy9LxSsxuickma+Wp46cIVYOZVEod82BL/kFNOFZVA0sAHtL9Kww9S4HQ+J64jgkZ4AG9lr/BXyN1WGoaa+nokP2MEV93Cy5PNgUSTE7duo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCZ0XglH34C/Iul5rD9pykqKZznnRfeyxZ4h5peZcrw=;
 b=LbwEYlhQRjcXXkXrMl6jCzBEZek8PaeTJJZk3Ofa0KXW1s0398gF6/Hlf/i55BOv4cXniHFCVN8NYfiGe4wuDgxtHd4o9CLkh1YvAh8vFp2SiBXhVCEizCFYNDLBKcjkxCZ2Z3gFxP03nqTMYMHe0muejVtWTGx4T9Ig4eNeyatW9Rv6juIbdelykPZm/UWh7IK/fPIh4mnGQ0zpdU8jFEXGWRDuK9ejCq6ziVYWSbTRteCPk34bTDoz3GEXQtS7/ZzE/3+P6LRfb4r99qovWWN4CGVK5BKskMu25IprQaEYPSWMFCb17OXxyGBy5NpsXj9w80dX9zs+b8bUrmaWzA==
Received: from MN0P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::30)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 07:34:45 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52b:cafe::a0) by MN0P223CA0003.outlook.office365.com
 (2603:10b6:208:52b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 07:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 07:34:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:34:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:34:29 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 23:34:28 -0800
Date: Wed, 12 Nov 2025 23:34:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
Message-ID: <aRWKA4zBwi+JagaT@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aQ4x7UiMMCB0m0dH@Asurada-Nvidia>
 <29f0cddc-3c23-4ab1-92d9-8c9918ddc187@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <29f0cddc-3c23-4ab1-92d9-8c9918ddc187@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ce6efc-9f1a-4dc8-444c-08de22871df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1zZhUM7ULSyU3f13CFdfioGK84MVCTv+Ki10q46C18JP00K4NFFqzl6VcRU9?=
 =?us-ascii?Q?AQmL51ssyfDEOgYaPOCW9OI9wfcWN6j4utknwwEHoi+1oppZm3pDqT31VC+E?=
 =?us-ascii?Q?NFKJ8gSBs8glV7S5FKBv0IMVi1EuJtKJaBVbCjKo84m/dIkB/pMuem0mHAHQ?=
 =?us-ascii?Q?CPb40kIZt5/wLxNfmrCVM/8MiiGiTGC2DJj4DzMS8G3TtUElGRz+n/iYu6yJ?=
 =?us-ascii?Q?58rLjf891Dg8KTdibjpx+M6kJ6momA9YyhT3GXQRy75CIfU05lVqbe2U6lVK?=
 =?us-ascii?Q?WrWCJR2WmRCb21cQtEr1P5MVX+h/hm5sPs1ryUvImOEG5JlxE39t37TWQGsZ?=
 =?us-ascii?Q?mezvU9plvy3BeweWeYV8hvibOmfmjS64zW4ZH0DvQ9FSftbCQF9orBS2Sun4?=
 =?us-ascii?Q?ydx6A0cnzXd8dxS8mhfpDvienfLiFUjba2qpBNzA0XEOl3XJCq6XPjUyVVl/?=
 =?us-ascii?Q?ZY3rWobUfjnB42slj+36s6EW4y1RE6hR8dlQ2C226A1ABCZLwml6zTTuR9X2?=
 =?us-ascii?Q?TvDFwtkUUHTtjmnHPG1NFdYr+MMRw42dROaJeUxZHHMJz5NspI5XKdoi6u2T?=
 =?us-ascii?Q?EJZ7D0T7yVmUELStMvRFJfaAOXixNXF6yM/uFFqQ5DEaDzQzj78fc3UHjYcb?=
 =?us-ascii?Q?rMqbQdn5UVlM433fWVFqeSzifWz0uqoE8CfdhYf9/odrTvHDWVOViI+y6W3S?=
 =?us-ascii?Q?NQUXYHGssxoEGLKQjQAgNwmDmZTxLWsukBpW2cKyKt+CTTIbHSddEgbi1Nv5?=
 =?us-ascii?Q?MAqEtYL1ptny2ywLXKdfhigEIxgowQdqNmIgkZwaDN7QkUof/HcxRRWlun/T?=
 =?us-ascii?Q?EpD79KMyndP6c4gaMTR/X71+SRnRWPstg3i+hI7n7E5oqt6awnNltvSOGTpS?=
 =?us-ascii?Q?PIdVcHphy9upgWbNjOEvwtOayc2jxlEc+f67+3TlDL7NAznhbYC5pX84iNBS?=
 =?us-ascii?Q?mXLWypu2Lx9Wt7RGDk5kDFDuMShZy5mWo5+UNBMx2pHvEK+HX1KeM/pl9ly4?=
 =?us-ascii?Q?VLQuPSi474LkCuS2RfFOoWNCM5Q/fy0qfg0iYGQHoQt2Q9hHPRb6Qv9z7RAj?=
 =?us-ascii?Q?qQl+vP27dQGc8WGICPQa61QiU8x6VrmNIhsZTi6VXmzHtJkzt/4xDDJszwUS?=
 =?us-ascii?Q?8Ae1aTpKxGJO5+9epYT7e3ShHF2S84KHocnKlOJI8CMTBmIwD/cnyRF9c3Mf?=
 =?us-ascii?Q?i50JtrF95aDLB9R6igjrTfNXfL3MiL80MKN7hpr1Ww7Hq7xuRWRfDdULGmlQ?=
 =?us-ascii?Q?oD7YVKVzlcaHIjFBZoPdU0ST2y+LM0pIKgUUGjZ04vc3ZyG6sMELeVXTVNNL?=
 =?us-ascii?Q?VPcM32/ezw3lWID2AOfamHoLUpQqu1+U3g0B3o4YOwmDQpwD9eYvgOBtyTFZ?=
 =?us-ascii?Q?koctQNO4/+T1FHLpRTV4u2PBOMkF6PQWe3AIpZ1qHc/tb2kBpEE7pvYb93aW?=
 =?us-ascii?Q?ggeMn1FGIyoGU8v9+2uGspCGa/G4uHkK0rWqZrpllj/vpuL0jR/kLdkGqTW3?=
 =?us-ascii?Q?JoGxbwyWJPVJRi/NFPtBbbtOmUzH6DtbXWUyzGX5/alZZEQ/J2tgI2zwqM9X?=
 =?us-ascii?Q?S0fBKKMM5dnR1LHJWbA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:34:44.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ce6efc-9f1a-4dc8-444c-08de22871df5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

On Thu, Nov 13, 2025 at 02:33:01PM +0800, Shuai Xue wrote:
> Could you share more details for testing?, e.g. QEMU cmdline,
> Guest kernel version.

My v6.8 and v6.14 kernels can boot cleanly in the VM.

vm_image=PATH-to-FILE
e1000_rom=PATH-to-FILE
qemu-system-aarch64 \
	-object iommufd,id=iommufd0 \
	-machine hmat=on -machine virt,accel=kvm,gic-version=3,ras=on,highmem-mmio-size=4T \
	-cpu host -smp cpus=62 -m size=16G,slots=2,maxmem=256G -nographic \
	-object memory-backend-ram,size=8G,id=m0 -object memory-backend-ram,size=8G,id=m1 \
	-numa node,memdev=m0,cpus=0-61,nodeid=0 -numa node,memdev=m1,nodeid=1 \
	-numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 -numa node,nodeid=5 \
	-numa node,nodeid=6 -numa node,nodeid=7 -numa node,nodeid=8 -numa node,nodeid=9 \
	-device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1,accel=on,ats=on,ril=off,pasid=on,oas=48 \
	-device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,io-reserve=0 \
	-device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.port1,rombar=0,id=dev0,iommufd=iommufd0 \
	-object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
	-object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
	-object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
	-object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
	-object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
	-object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
	-object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
	-object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
	-bios /usr/share/AAVMF/AAVMF_CODE.fd \
	-device nvme,drive=nvme0,serial=deadbeaf1,bus=pcie.0 \
	-drive file=${vm_image},index=0,media=disk,format=qcow2,if=none,id=nvme0 \
	-device e1000,romfile=${e1000_rom},netdev=net0,bus=pcie.0 \
	-netdev user,id=net0,hostfwd=tcp::5558-:22,hostfwd=tcp::5586-:5586

Nicolin

