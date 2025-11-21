Return-Path: <linux-kselftest+bounces-46256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2AC7AA41
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E8314E2691
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ED0350A29;
	Fri, 21 Nov 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F3m77wTN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89E734FF45;
	Fri, 21 Nov 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740291; cv=fail; b=sgkuzjU3LUt87va0q6g5SX+LeCn0WKqyQQnhjPWWKSEFen4aA9kOoKoStVN/w4oIYUidjoYC4FTU73GUOBc/LUdP4Zbej/1bZf68W/khvDfzdZCmx7hhRH3BL75V8KSPA14AQ5Jn8sDGRgtzl0xjbNfet9RKbgB1Qzt56VNz1rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740291; c=relaxed/simple;
	bh=4rxs6Yy+X/sSsGGlIcgEQ0G319wgQ33e6UPR6ukuSsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9laWXnn78u9wD6WGB2NHc0LYl29easAjXznia7p4PhfaNdz56Myw7WaGMpu33pVFAVtd+NTYMFKINVXuCOt6VFtO2uJrMUwOWP4t+khlTO+hnxHv7bf7BVX6Hqcre/wHlMuarv94J9CMZGBwMPvrk6koWF5oFKhO1HNteK4Vm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F3m77wTN; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydvjnjXPmMWqlCkLPy+rjAYlWlW6ba0qmUQ634ACgn6OSXeu0eiHfXGfFFJzBW7qh+M8fhAaD5+aGodLcNKBQblDFgn5wzJWTKST3c1q6SQ4VXIjYFRrFTGZSvVTYtJmzEBSVNkozGccGXJQltk2q2+lXfyVtCiPtY4J6SHaAFULRR4QVEOKv3KZ2POhNsDV2P+d70bdvUckrRBNInY7MWaLYNIx3CQlUh+HV6KXfIufULXlutxrx4GEataiwql1v9DxfT/VJsv7D3sbdjsX+4zRXwjmHB7lAOBRuZ6+XFyNjdONaVb+jho20h7tK9mBHY+35/QIcoMWah16CGHJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/rb1rCs+OgXRjwyZb/xopxLtojgl1e6LheTlmXn5VA=;
 b=k2VtvYL2iBcZ7uYVNjGr+SBF2Mres7YwiSo34BHqKUAqm9KEmVyjOPqrRpwHuz2fbcPXALLKoX4mSLZ/eNtrwKdimv+sPlTNb9ALfeJ0UYJnkMmdP489oQSBYiOGCYN4yYdHG3RtC/L3QZpwglKJ/Pgz15I0SqhA1WzvINSks4gF4X3MNzUSXivNw9YzABJl44p8MbVviXZYHdgTTbfeo+PJvU7pQlQc/AX21ZilfQSawF8itbpJIRBFZqe5dVmeM+GOPOAXyOJDZwWZtlmz4TJBgUIJXMgrZbvAGbj7+xyOblUSydEOd2YXSft8Hjm/dsjY0+h0qxpMwu7rQINB9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/rb1rCs+OgXRjwyZb/xopxLtojgl1e6LheTlmXn5VA=;
 b=F3m77wTNH/C3eMEXs41X46t5xIF2kaesveyirQznhV3wji1OfG1u2SCVnfQ+DfBqtG723IyuKpHZkYjkmo8pVqZcuqrbLR6rCB2M/crSyKQD9UDT61c/2gevIun/T6YQASaF4knv3yKEudaKg/R2Zf38zdjDGfuCIFyPKa5JDMZkje80/qq6tJeJcNtbzpQNS0kkX9zEojxUmpkoulg4OCQNalK74Bv+yELor0sji0w7x3JwdnScDhjwQDqIMdXxL1cbq8ZE9X8Gts1khv/wP4TSlz5SuFMXkPwIfvuqnTC+22hlJgczGGhKAa4//+/CXLNudBcoEj0NbjQd1VhvkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:13 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v2 1/9] vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
Date: Fri, 21 Nov 2025 11:50:58 -0400
Message-ID: <1-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d46f57-e036-4bbf-fd30-08de2915ca04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JH8Xp78myfatmMsSfj4x9BeV+qvAFvQRbOkEHaGWGvwZmwJaRKGDc1b9tMW?=
 =?us-ascii?Q?p5VpjhPnBpFnL8F9xQgqUXS872sBhfDrchrf/KyIIKBkX31+j+kn1Z3N/Htk?=
 =?us-ascii?Q?5Rkxs9/+xXGxggRJi2c3bWGtV7Mz5ToapIqvTBnuHvPtUS7o2AICV2QQGaZB?=
 =?us-ascii?Q?Kfn5dwzRFPv8nOBL7x5sIyqKvkEV2D5qNmQoQdlvTqDRX+/hIRf9XspIpsme?=
 =?us-ascii?Q?NQkXmwzGgHkGZI/jSnFlhWfBfDWje8UlQA+6MpkWDoQDS2TTMh38IjoHlfZR?=
 =?us-ascii?Q?3QaR5M7iK3YR6QY1Da3IFE8HMq9r5ZINW2elWSAP+oSEDLn2jV1RKoOBYDdS?=
 =?us-ascii?Q?oji/UfuLHpInYFYmwHzUTHUd+9+SByL7PMcm+HBG4BewPEbRqklz4H5O/fPN?=
 =?us-ascii?Q?4k6RH2A6OKzatABGPUA2o+B6QB64XE2ZGXIphRSJx7K5BrPwwxUzW0c7yST+?=
 =?us-ascii?Q?GP98Vxe/RvQfvVi46IqIvPcRDz8TXt7EWsbcQ90CXmW4w6RvBM9JYAvKEzE6?=
 =?us-ascii?Q?xkLeHHmowMDuuH1bYWnfuIVoo0YPZboZo2pY9AQqnGT4veAbuZ9/MzzIkoMt?=
 =?us-ascii?Q?+Od6tSdbAkdlXdw0qa3CiJhOiqIczHPAA7p7Y/c1ZvqkGzHvxwqoYV7Jd2C5?=
 =?us-ascii?Q?vmK0UfXI7k+OT/jAOKwm3Rt5oZn67DTXoAhiTKxhTCWyfvWBfnl65XZv2zT2?=
 =?us-ascii?Q?9iOx1RDfDx4lAHaf9MeoAeEJoA9RN8r5IDR7397ltNO60xmT01D35tFWA1ee?=
 =?us-ascii?Q?bQagIxvRF+EhAY9Brbgn6ut4tsCaPBWYLZFVEFwR3OKjxb6x4vBS879H1HIw?=
 =?us-ascii?Q?f3qyUPGa54IVX1s/vgAejLbkOVhs5bKoc2kFhhoEFcdkL7FRkQi5gyZLv6mK?=
 =?us-ascii?Q?sXjG/+b7wE+4NNEzRQr6L3c160YOVwJoZ6ZKRqY8T5GLtWW25xI/9cdKDvGk?=
 =?us-ascii?Q?/aKRNDGfPZeYvEhmzAEHwf+X3Cm9qwbEcLYb3xQBP3t7KawVMsVaLgw1lY1l?=
 =?us-ascii?Q?xwQmlBtaR3cMSZdCXQ5RpS4RQtTTjYQZ5mhgTXfyRwK4XhdeN+e/SjdXyj/T?=
 =?us-ascii?Q?FHTGvbJs508AZYXhm9dhyKuX3SUZHnI8Imwe7272sDNh5wCLV7/iieeJ6Tnn?=
 =?us-ascii?Q?aZrB7bvhdtlTKl0JqlcN2THhoamheeWyB9RO3jt72Wy0/bR7gQ3KG9eutBgr?=
 =?us-ascii?Q?KjlMaaqbmEduuOHgx0a45xVB6HMaa1f5r3P0H6TdyF83A14OXLPiA+guxT6H?=
 =?us-ascii?Q?Z+3Vom4hGAK2HcalvJO+sPUaPP06B+Ryi1OgNbhzkI2AoBZS3PCs8V3ywJ5W?=
 =?us-ascii?Q?t7x/zFWHoySroarCstjSeNXkI4sOrnrMgCMWp181QO+HFM/OLcXGvWLYK5zw?=
 =?us-ascii?Q?vSSQ/s1ZnvmxIJV7yAivBlbJ3IwVsRluHNwJuJbizzEXcklf7K/vYdaF0d66?=
 =?us-ascii?Q?m/PqZL7IvDdlJKVAWp3Mqrs7BiC+1zd4NCuaK85LNYWDdaJqOpxVQRGVc2Zh?=
 =?us-ascii?Q?SWXmbcKYR8uSF5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLcNaeNigrFGLyuYH0EpNLmvyVkp+6IIoliRbuK7Qmer2t/mJsYJS6F+TL2G?=
 =?us-ascii?Q?xF5srvFtRAxrJ7L8SMJX4shlDD2qDhYeYXVLsChU3lJj40pdWHvpJFc2nZuh?=
 =?us-ascii?Q?+yXrcI7rZGttX21YHCNyTNVztAORJqPXGk2FgT9dW1Y2M+4LABifKt+pY+nw?=
 =?us-ascii?Q?HHusx2VtP6WGjTj1OtvGWCUHyvsLoLOSg2wnhxLXwNLk1fVWccpk8oxQi/kD?=
 =?us-ascii?Q?u1ij4ozddEHVK0yfzrnaZp6L4pcdbdvaT/lQqTHQAvvDpxK8DAiz2CIpXdXI?=
 =?us-ascii?Q?nqAKX6sm1TsvIY4lxXur+at9m2qG70BuSudIESwOqZbuHLz3lHP4tR1eki52?=
 =?us-ascii?Q?GORq4rfetXHFwjlBsO3vjfE1Slz5zQWrsD8DFaIUD3JrcE3XGwNUkMuUNSdC?=
 =?us-ascii?Q?Wjqg8i8yhVzCmp21BbK77sBOnzhMQn8K8iyQzL1eAVA6Mhn6HC4VIih6GE/j?=
 =?us-ascii?Q?j9MReuCb7pmg0gzYoFDhnv8kAXXSGXZXjSZhQTvjvIE9OxGfoaBzK9pUZXhD?=
 =?us-ascii?Q?RERwxynD7Xlb3cTRsRHIp8N9NNdJKZzLg9D16G7ol7Q8Rp0++eL4OsaO0DCS?=
 =?us-ascii?Q?60/Nk18FewP4++DW+WxU5fjeUb6Pe1YFKRKOC0zumxjoG6Tsqaj6AjBslj6q?=
 =?us-ascii?Q?+SWwKVskhNgjs67amKxpbHJEp1OszhQTF/fwb/Rg9w/Ll8rcpjSB12kaJmYI?=
 =?us-ascii?Q?4wABElIsaRr6RZWUmmfvwSYW5XVmWNBzvJBMfIQQ/K9clJfEOOex73zHDMFT?=
 =?us-ascii?Q?rbeN+/PGzqDDIIIz4chQDB5LQx7yQLRi7flGTJkmvILt9ot7j81Vh7mJYC7t?=
 =?us-ascii?Q?cp/7T9FokD77yzvfGT+4qX+7zxX5/zNpg86lFOP0rHyhk34JgDh/rSMkptgS?=
 =?us-ascii?Q?hX1CuJ0whtDE/Mnl9UbnUntwaz36n/JCt3zKbWvqo9iCC3JgHa+/YJe2iC+G?=
 =?us-ascii?Q?yFUkwXAqvNq0+zw+hXIbta8/E6XOeKNvNETURtH04uInG9YfokngAz6oBM6H?=
 =?us-ascii?Q?qM67EGwjWeJChmLrs2Ys5LIFaF+LGlMJjVO8fYGt3swPKyXtXE4pI8qDjJxw?=
 =?us-ascii?Q?cmTMv8OQzPyFgcLP6FCR+27pPqYTEWVgV0iY2kbUksmdTqpaDDUkhpbi9YqR?=
 =?us-ascii?Q?P0HWMlL95aYl8ljAJuxoddYuMrlfLbTnKyArbO9cmlVTb2I7MLF0bFJotowU?=
 =?us-ascii?Q?YZ5VpqF3DoWHV0RNb6wOVSB8HcCexSuD/JX4T9uMcNhglBX4tX/biE03xL/9?=
 =?us-ascii?Q?gh8W+tOmniihxUdc1R8sJ1JMBP4wB+zFNL8n4Gnu4Fp9oXuynr4yAhmQUIgv?=
 =?us-ascii?Q?1lUW1VE41a5RKJElVEKOgVFzHg5oJRZ7KTL85BW3OEiLuIVBNRs8YW/VzKlE?=
 =?us-ascii?Q?+chVZHB5l2NnzbwhhMsXDg1hAo6G6gpa+LjO4VXL2GtsaM2raMT2lRNpPlM5?=
 =?us-ascii?Q?ZEpwZhJ3iFY+ZvDN4F+zbeABqIAlhFE9rE/3wDQ5Jzh3G0iSoxgTmVRUDwGS?=
 =?us-ascii?Q?qdwfq1ZmhwZRlFE37nkdtSImkQZGH31l+oTFvASTh6m8qPlvVj2JvGMB9QHa?=
 =?us-ascii?Q?z6MkL/v87+PZqEhSXCE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d46f57-e036-4bbf-fd30-08de2915ca04
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:09.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8k/yL/sPCbOzh32DiuMbbmWZgQdqE66AP/LFRRiXwseqnTGHezpdCDZLBB4h0UM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

This function is used to establish the "private interconnect" between the
VFIO DMABUF exporter and the iommufd DMABUF importer. This is intended to
be a temporary API until the core DMABUF interface is improved to natively
support a private interconnect and revocable negotiation.

This function should only be called by iommufd when trying to map a
DMABUF. For now iommufd will only support VFIO DMABUFs.

The following improvements are needed in the DMABUF API to generically
support more exporters with iommufd/kvm type importers that cannot use the
DMA API:

 1) Revoke semantics. VFIO needs to be able to prevent access to the MMIO
    during FLR, and so it will use dma_buf_move_notify() to prevent
    access. iommmufd does not support fault handling so it cannot
    implement the full move_notify. Instead if revoke is negotiated the
    exporter promises not to use move_notify() unless the importer can
    experiance failures. iommufd will unmap the dmabuf from the iommu page
    tables while it is revoked.

 2) Private interconnect negotiation. iommufd will only be able to map
    a "private interconnect" that provides a phys_addr_t and a
    struct p2pdma_provider * to describe the memory. It cannot use a DMA
    mapped scatterlist since it is directly calling iommu_map().

 3) NULL device during dma_buf_dynamic_attach(). Since iommufd doesn't use
    the DMA API it doesn't have a DMAable struct device to pass here.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 34 ++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h      |  4 ++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index 6698f540bdac87..d4d0f7d08c53e2 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -82,6 +82,40 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
 	.release = vfio_pci_dma_buf_release,
 };
 
+/*
+ * This is a temporary "private interconnect" between VFIO DMABUF and iommufd.
+ * It allows the two co-operating drivers to exchange the physical address of
+ * the BAR. This is to be replaced with a formal DMABUF system for negotiated
+ * interconnect types.
+ *
+ * If this function succeeds the following are true:
+ *  - There is one physical range and it is pointing to MMIO
+ *  - When move_notify is called it means revoke, not move, vfio_dma_buf_map
+ *    will fail if it is currently revoked
+ */
+int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	struct vfio_pci_dma_buf *priv;
+
+	dma_resv_assert_held(attachment->dmabuf->resv);
+
+	if (attachment->dmabuf->ops != &vfio_pci_dmabuf_ops)
+		return -EOPNOTSUPP;
+
+	priv = attachment->dmabuf->priv;
+	if (priv->revoked)
+		return -ENODEV;
+
+	/* More than one range to iommufd will require proper DMABUF support */
+	if (priv->nr_ranges != 1)
+		return -EOPNOTSUPP;
+
+	*phys = priv->phys_vec[0];
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(vfio_pci_dma_buf_iommufd_map, "iommufd");
+
 int vfio_pci_core_fill_phys_vec(struct dma_buf_phys_vec *phys_vec,
 				struct vfio_region_dma_range *dma_ranges,
 				size_t nr_ranges, phys_addr_t start,
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index c9466ba323fa9c..6a3074f2cf1cea 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -28,6 +28,7 @@ struct vfio_pci_core_device;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_phys_vec;
+struct dma_buf_attachment;
 
 struct vfio_pci_regops {
 	ssize_t (*rw)(struct vfio_pci_core_device *vdev, char __user *buf,
@@ -203,4 +204,7 @@ VFIO_IOREAD_DECLARATION(32)
 VFIO_IOREAD_DECLARATION(64)
 #endif
 
+int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys);
+
 #endif /* VFIO_PCI_CORE_H */
-- 
2.43.0


