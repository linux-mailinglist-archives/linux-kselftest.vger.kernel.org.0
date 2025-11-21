Return-Path: <linux-kselftest+bounces-46255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E2DC7AA74
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455E03A1A14
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306F341044;
	Fri, 21 Nov 2025 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mv7yuyKE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653734DB6E;
	Fri, 21 Nov 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740288; cv=fail; b=sVP54JQ0fFAMBFM1fU+8dVPA4BhxXGMeOG/wW/BQq+4XbriA0K73/HWl5lQ6IEubmtGtG0eO1azOHAFqLhqLO1FuAuUsuAO+taAeyfalOAcOlvOe+TlK/9Vn60lQiFoPRh6btojuDZmILf2cb+3hC7eabQsSSmWLRHB9I781VHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740288; c=relaxed/simple;
	bh=x0YaL8EzmNloWpsnmPtJIkKZSUlXJA6FayvKPAMPuEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VMYUYM4mdIe2NHWpmc6NA8jIE4V71RXFi2cUQrqnIeHMABch2bViM7TmosV81Eg9410944vl3qcO95aQRPv1xbRxkHT2q6SEo6aUB5aPwp2GWviwTCwDJAWNRDBxbh3SriPnHIVTnMZbmgYkyAWM/pfAKQjfpfOdXiQNX6Fno3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mv7yuyKE; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJBWsJtr9vVo7SRCAhOYLw54b+zRMdiJIb68GFFRJ/XLKj1t+ofqfAXt9lX71C/n/wf1zCiw4v9cr/0MyNrbifKDlxZHqXSKq4tYoVMJQdGnMyZ1HSi3br6NLsdzacHRmkQhP+UcTxs75uGSHbGX4RNhET/AnP+Nwc0ApgRVy6hr4MX6Kp49I0k4YjVQsAmz+nUf+meueTjAay5Js817Av/Y6TST0WLIk0NdrJu62QliaeJF9tt/nENgoHsT8FEacaPUFUfB6bPtuV166TSf4eOip1V0ACyHJ1qyI3QkHzK7TVHMaAOqPaEgaTiuMpUwLQADfUSN2rUXYUsYGDLEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GSwh1bPlKyFq+txf1BrObQxNDD41nCzEQb0PjG8i7I=;
 b=ti1146zdhuwoIjwC8/7v9Kh/G0HxYMxgOfHFztgbF48/xfIT8NoHMhAqMCvkPRJcAmWbOWXbifiqjhYNDm3xBSSzAR/eAQ6fJEqn+Mk4iXG9aHVABexJxjT4kc8zdJHJwa1+Tk94IFd6JsLUXD7nxhpGdRD7Lm4zoq5sM0ZYgd1SMvyHyDjJPm9GIiHMNq/saxdNt5JgywxWzLh+Yposq38c5q7n0AZaHM0Lw5KR8YI3Xw0iNGL7ks236tw908EMr2/wQ2H3JQiuE/Y0XCaiC7xYbpUeiYTKhtd9kcDhFddNQZui4UuLTHL2dYknR83jheL+lsX1Hfv/mZHKYHVTHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GSwh1bPlKyFq+txf1BrObQxNDD41nCzEQb0PjG8i7I=;
 b=Mv7yuyKENQBzQVC9eDz9V6TlbuE9L9gyKBNdtX7/JfxEkfWd7a95ILWLV5dDs5gIjZOoFSZzCbJKijB/NwSXdRXQnT13dJlB9CZkY3gY0F2tgOzEMfRdcnzpT0brAta55tWB5Cx5lcmZIXCB8zsVsljpph+v9rnVpqWW3hCr37LrRhQwlGw2qAbWeC2FfA/Xw8YxP9J9iWyt9YIVRXJ+pguRAEFnbk7rSdoj4o1xf4YycqfKZ3igNpalTD4J4YsOKXYnsayenWXd4QZw7fhGVsNzwzDp9XgprnYny1by/FCeOY235xE8vm2xne6rCr2nkVs0DaIn4LVpGnBB1dGSBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:09 +0000
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
Subject: [PATCH v2 9/9] iommufd/selftest: Add some tests for the dmabuf flow
Date: Fri, 21 Nov 2025 11:51:06 -0400
Message-ID: <9-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::7) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b5c45d-9bde-40d4-1def-08de2915c915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f16kzs2GkBSI8FPa0tEeB/+qrNGoPk2m1Kfc5MmzONZtpH9CbVyvNbpNwsP2?=
 =?us-ascii?Q?Lt4T+ofOd5YNbPxuX9fyFd17z4rTB9eLcCjJM0kwGztt9fD5FfzK79cjhrmJ?=
 =?us-ascii?Q?f77KSyDHcso1T//3ihX27POS6Rp0P6FxviwsSiCqVjTldWX2UYGP0qkukeHK?=
 =?us-ascii?Q?X5HxhrvBmRKLKUC9lK32x+het6pc1BmVemFJ7zYsVcW46wOzuFrjyxfIyCxC?=
 =?us-ascii?Q?WSHO16lS/7aoCDbCEKetXzNmUKti1Jsv2c5z9tuRRHwTHJIDzaOc8AGsE/+p?=
 =?us-ascii?Q?OGqEAdyk4WzZKk5GT00TxP0uODMQdif/9RoY/HjVeeaB4Nces168c8hYoNgZ?=
 =?us-ascii?Q?1L5yNP0Qnzp32e4BholvvJtKZbb55NaoxOpgnwYGsooiZTUb7Jr0Rk5nhk2T?=
 =?us-ascii?Q?0oNIQa1fIzOpXJxmvb60al0aHPl++tYUOZY1i238S+3FVbIO+o6Eap+bLcj6?=
 =?us-ascii?Q?ehpY9qSawGOu0lYStMgSiAksL3g/8aZU/aQ62mXOFGzcuhDwzgfWhSqtMYI/?=
 =?us-ascii?Q?eD1hLSkM8RtHCaWcSD01uF07a2ColcdetbAqdu5qNpHQ8fC2hm94UY13HUsq?=
 =?us-ascii?Q?atqa5v+OcLxpBI9JuakIicLHJ7w/V150Oy/K1+XfajP9PYrijaRWZTP4+WH7?=
 =?us-ascii?Q?O69/2OuLoXiPMk4dIfhRHhstghjgEltXCsDkuclt+XMcttJFIKE+fwFHFkAO?=
 =?us-ascii?Q?aD6l5Wdmj7oHUVWBOlJ3iG+P0O3GnuMQq/9D0Cc/4+QPzjvn+n6WFYZTDHey?=
 =?us-ascii?Q?q6OLA63br0lzCKRWSnLE1d8Xvh3n0mHtQahjE0Dykkr8UJ2xvW8EpBhwFBcb?=
 =?us-ascii?Q?YzjPSBW0T6KGQVQOYJY9g4FlrPrWqn7sfbryAMN/k75eoxR5IdLOYM/1R5Ci?=
 =?us-ascii?Q?Qdceri57SwWthZ/eIdDzK6uu/hSegHFRR/nmm/yHhmCZnkCqL3+tG3/BgKtl?=
 =?us-ascii?Q?Qhx9G8oYIuuI1NfGgE6ejhRL0aGy+kDgQytVcwcHupt4loNGznYKXUxTbFWc?=
 =?us-ascii?Q?A01XHWBwWuuL4/umi4Q/95FgyafbQdDwus3p6+xj28upx+DyR9xaPMaoZvMj?=
 =?us-ascii?Q?gMMvMLCjJiLLt5U0tvfjYyyGyU4nAv6p8o4HVvGPRCTZJen+Im3fKnuFKV6X?=
 =?us-ascii?Q?PaTQ/prRAdVX2wkia5EAtESbYj2LD88fQ8YdtIn0Vv085L0UMH3/W96EZ6Nt?=
 =?us-ascii?Q?qcq8cy/tq0TxYyIkommevlqTaHTtj2mcvgk3oXANseA/btvnaYDnEd3Ay9pr?=
 =?us-ascii?Q?lb2rhUKbpHPVAXvVSF73KnqQK/6FRVjfBeCRdk79Knu3XB9v0reBrFv1wUxx?=
 =?us-ascii?Q?rSqbLQICiFlAeHJPd3dQkOeat/GSe6qOJBXgZ1A4pk4+G0K3BkZ8vEDUF/Sy?=
 =?us-ascii?Q?Byqt8uh/9l2f4KoAHMY6jY9hNIWQgTnylm2rfGRrdzVMjYt1JaxcAAIVksLB?=
 =?us-ascii?Q?Dn83AZ87Jni7pbMqcH1NmgrdicBNDQj1COFwo3E1vdp/L245j0qiGVVlIM20?=
 =?us-ascii?Q?MX+qlZxz/vkFRqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPqHYtbF/ujpn1wSf/RFq1lp8baKAwJpkCeSHbWPj/FrpdM7J5djcZTT3WFu?=
 =?us-ascii?Q?/vecWPZCawFAgtFRFbpAc1v7x6svkrP1C26hLDf0D+UmXNJ4LJdx/7R7hDhB?=
 =?us-ascii?Q?N7S4/4eCJcpND5rPSXE8uQ/Ts4pYyQZh4SYnBUza6UBA0+eQbETyESUqLf6g?=
 =?us-ascii?Q?T3S0bx9wwvdoJBCaVv9FnoPGdWHCWH1xcTQtVO3HDppppt+AmGlCumPOwrId?=
 =?us-ascii?Q?VWftqxjqUDnMQjzE06LJ/J3TxMA0SzoSqpOz795WlpMy2bG4NWiHUfQbFPu/?=
 =?us-ascii?Q?Z/ee5buzmUrjPq38IOCojUIsuoiWnCozpeDC+CZqCgTSnuTAjJjPM4cfd8bU?=
 =?us-ascii?Q?WpwB+tDmrNbAHjTf5HhhZDUEq42QgpqMYBK3tTmPyb/CxeP/rJLsnDgDDThM?=
 =?us-ascii?Q?V2tjxme+SC8CdpOHsm+Pk0l35fjDFoLsDnjlIOcZhpeuLEKP0aImunrgP5nd?=
 =?us-ascii?Q?cUnohpaxMaVYDiv38rLPDyAk7DL7YBI+xYsxS2NOG/aH3PVsRPbY9aH5fuWb?=
 =?us-ascii?Q?fKXg4ZAWPO99P5MyUluSB6xYx7bzBNee8IAS6lEilmUVgtlpv33bPXdXc0IB?=
 =?us-ascii?Q?sPBdwpXLp3vmXGmDMcaSxECSL1iUIJ/egnBBn9aFgRS5CpnWBqQ4QGcVCGzA?=
 =?us-ascii?Q?4CYeWBPgYAQflnFc7AfrhPZj0tnpXFtWsvpU7bJtkk+JlIuvv0iRzpWK1Xcm?=
 =?us-ascii?Q?bitZwEQ1ohZnQkPv9mALpXx2MKxZr4MR1A1rSblHO8bl7Sm1JFKnv40Dbsh5?=
 =?us-ascii?Q?3kDZWUQl4Fkjrh5A7W03SiM67nyhuoaZTncHnmVxdi0C09E+9JpgakD5FtSV?=
 =?us-ascii?Q?kEAKp970rweP5yAGW9eJEsryEHAinfEdtFuGrwajkACzITGSQ0hfWXimZav5?=
 =?us-ascii?Q?hj8ZWxnwuvgkoi5bBTrq6ivdT9N1o461fjOhs/UR67NHuU5og6V4AGASvOuu?=
 =?us-ascii?Q?AWdLxWWxz3BgIO1zwDQIEN7xaulESWfYjL2rpCQmUPo2pv4oPcmfriEWoaSb?=
 =?us-ascii?Q?qbAFFw6aTMVhWMQqGrn13dVAdY4U+A+2uEKBhfuNopgGEx6J1btNmuuiY6Xq?=
 =?us-ascii?Q?IiPlxhh8kGtpQWJTsgZ2+isqESjzeAshmB4Lc0GTYpuYMqZkY/gtaGON8TDm?=
 =?us-ascii?Q?SxDsO2ZR8iEH5FiwAYByDZ8ypPH4tlNVMRZr7KNCFwMBnF+IDNI1M70PCSm8?=
 =?us-ascii?Q?ka9+NQuObNav2KNafcFipHvOmU7CFou/8BjbquepVHxrjb2G1Z46SX2dqhze?=
 =?us-ascii?Q?z6A1mngnROHtc6IPZzpgNUAheZ9dYKdrI2R9gEBzMqLBjkex7EtmKcllGbJD?=
 =?us-ascii?Q?YJp1fOesrinLM0iMQ0sZEr+bQpMODzoKw0JOFHN0MeUEJ9kOgtUT2db6Afqn?=
 =?us-ascii?Q?adSRP1I9LNhontVS5a6/P1KWezNvin+fBZW6r5CGBQKy0QF3Md3M5fanqdvC?=
 =?us-ascii?Q?6+ghbTolT/InSy0bpEuSG0FfocK/G2JFcdneA8H3IWpFANHBjmbLRs0pknTP?=
 =?us-ascii?Q?f8P2YeVxl86FkSRjYDs+ReZBQOgFJAKmTtw80KKBmIIVKCvEXqKbaf7CuHs4?=
 =?us-ascii?Q?QnHfOkV9eLWhGAPBOWo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b5c45d-9bde-40d4-1def-08de2915c915
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:07.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftS7x7GfB7vB6tet7ezQUolmq39V3gmhHLq0bvDQw/6YjdlOgaBC0PdbZ59Iq6kl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Basic tests of establishing a dmabuf and revoking it. The selftest kernel
side provides a basic small dmabuf for this testing.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h       |  10 ++
 drivers/iommu/iommufd/iommufd_test.h          |  10 ++
 drivers/iommu/iommufd/pages.c                 |   4 +
 drivers/iommu/iommufd/selftest.c              | 143 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  43 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  44 ++++++
 6 files changed, 254 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a2786fee7603f5..ef2db82e3d7bf5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,8 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct dma_buf_attachment;
+struct dma_buf_phys_vec;
 
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
@@ -713,6 +715,8 @@ bool iommufd_should_fail(void);
 int __init iommufd_test_init(void);
 void iommufd_test_exit(void);
 bool iommufd_selftest_is_mock_dev(struct device *dev);
+int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				     struct dma_buf_phys_vec *phys);
 #else
 static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 						 unsigned int ioas_id,
@@ -734,5 +738,11 @@ static inline bool iommufd_selftest_is_mock_dev(struct device *dev)
 {
 	return false;
 }
+static inline int
+iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct dma_buf_phys_vec *phys)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif
diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 8fc618b2bcf967..9166c39eb0c8b2 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -29,6 +29,8 @@ enum {
 	IOMMU_TEST_OP_PASID_REPLACE,
 	IOMMU_TEST_OP_PASID_DETACH,
 	IOMMU_TEST_OP_PASID_CHECK_HWPT,
+	IOMMU_TEST_OP_DMABUF_GET,
+	IOMMU_TEST_OP_DMABUF_REVOKE,
 };
 
 enum {
@@ -176,6 +178,14 @@ struct iommu_test_cmd {
 			__u32 hwpt_id;
 			/* @id is stdev_id */
 		} pasid_check;
+		struct {
+			__u32 length;
+			__u32 open_flags;
+		} dmabuf_get;
+		struct {
+			__s32 dmabuf_fd;
+			__u32 revoked;
+		} dmabuf_revoke;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c73456833d04d6..dbe51ecb9a20f8 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1465,6 +1465,10 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
 	int rc;
 
+	rc = iommufd_test_dma_buf_iommufd_map(attachment, phys);
+	if (rc != -EOPNOTSUPP)
+		return rc;
+
 	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index de178827a078a9..5d14dd0fb37d6a 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -5,6 +5,8 @@
  */
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/fault-inject.h>
 #include <linux/file.h>
 #include <linux/iommu.h>
@@ -2031,6 +2033,140 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
 	}
 }
 
+struct iommufd_test_dma_buf {
+	void *memory;
+	size_t length;
+	bool revoked;
+};
+
+static int iommufd_test_dma_buf_attach(struct dma_buf *dmabuf,
+				       struct dma_buf_attachment *attachment)
+{
+	return 0;
+}
+
+static void iommufd_test_dma_buf_detach(struct dma_buf *dmabuf,
+					struct dma_buf_attachment *attachment)
+{
+}
+
+static struct sg_table *
+iommufd_test_dma_buf_map(struct dma_buf_attachment *attachment,
+			 enum dma_data_direction dir)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void iommufd_test_dma_buf_unmap(struct dma_buf_attachment *attachment,
+				       struct sg_table *sgt,
+				       enum dma_data_direction dir)
+{
+}
+
+static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct iommufd_test_dma_buf *priv = dmabuf->priv;
+
+	kfree(priv->memory);
+	kfree(priv);
+}
+
+static const struct dma_buf_ops iommufd_test_dmabuf_ops = {
+	.attach = iommufd_test_dma_buf_attach,
+	.detach = iommufd_test_dma_buf_detach,
+	.map_dma_buf = iommufd_test_dma_buf_map,
+	.release = iommufd_test_dma_buf_release,
+	.unmap_dma_buf = iommufd_test_dma_buf_unmap,
+};
+
+int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				     struct dma_buf_phys_vec *phys)
+{
+	struct iommufd_test_dma_buf *priv = attachment->dmabuf->priv;
+
+	dma_resv_assert_held(attachment->dmabuf->resv);
+
+	if (attachment->dmabuf->ops != &iommufd_test_dmabuf_ops)
+		return -EOPNOTSUPP;
+
+	if (priv->revoked)
+		return -ENODEV;
+
+	phys->paddr = virt_to_phys(priv->memory);
+	phys->len = priv->length;
+	return 0;
+}
+
+static int iommufd_test_dmabuf_get(struct iommufd_ucmd *ucmd,
+				   unsigned int open_flags,
+				   size_t len)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct iommufd_test_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int rc;
+
+	len = ALIGN(len, PAGE_SIZE);
+	if (len == 0 || len > PAGE_SIZE * 512)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->length = len;
+	priv->memory = kzalloc(len, GFP_KERNEL);
+	if (!priv->memory) {
+		rc = -ENOMEM;
+		goto err_free;
+	}
+
+	exp_info.ops = &iommufd_test_dmabuf_ops;
+	exp_info.size = len;
+	exp_info.flags = open_flags;
+	exp_info.priv = priv;
+
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		rc = PTR_ERR(dmabuf);
+		goto err_free;
+	}
+
+	return dma_buf_fd(dmabuf, open_flags);
+
+err_free:
+	kfree(priv->memory);
+	kfree(priv);
+	return rc;
+}
+
+static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
+				      bool revoked)
+{
+	struct iommufd_test_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int rc = 0;
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (dmabuf->ops != &iommufd_test_dmabuf_ops) {
+		rc = -EOPNOTSUPP;
+		goto err_put;
+	}
+
+	priv = dmabuf->priv;
+	dma_resv_lock(dmabuf->resv, NULL);
+	priv->revoked = revoked;
+	dma_buf_move_notify(dmabuf);
+	dma_resv_unlock(dmabuf->resv);
+
+err_put:
+	dma_buf_put(dmabuf);
+	return rc;
+}
+
 int iommufd_test(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_test_cmd *cmd = ucmd->cmd;
@@ -2109,6 +2245,13 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_pasid_detach(ucmd, cmd);
 	case IOMMU_TEST_OP_PASID_CHECK_HWPT:
 		return iommufd_test_pasid_check_hwpt(ucmd, cmd);
+	case IOMMU_TEST_OP_DMABUF_GET:
+		return iommufd_test_dmabuf_get(ucmd, cmd->dmabuf_get.open_flags,
+					       cmd->dmabuf_get.length);
+	case IOMMU_TEST_OP_DMABUF_REVOKE:
+		return iommufd_test_dmabuf_revoke(ucmd,
+						  cmd->dmabuf_revoke.dmabuf_fd,
+						  cmd->dmabuf_revoke.revoked);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 3eebf5e3b974f4..de348d6412791b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1574,6 +1574,49 @@ TEST_F(iommufd_ioas, copy_sweep)
 	test_ioctl_destroy(dst_ioas_id);
 }
 
+TEST_F(iommufd_ioas, dmabuf_simple)
+{
+	size_t buf_size = PAGE_SIZE*4;
+	__u64 iova;
+	int dfd;
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, 0, 0, &iova);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, buf_size, buf_size, &iova);
+	test_err_ioctl_ioas_map_file(EINVAL, dfd, 0, buf_size + 1, &iova);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova);
+
+	close(dfd);
+}
+
+TEST_F(iommufd_ioas, dmabuf_revoke)
+{
+	size_t buf_size = PAGE_SIZE*4;
+	__u32 hwpt_id;
+	__u64 iova;
+	__u64 iova2;
+	int dfd;
+
+	test_cmd_get_dmabuf(buf_size, &dfd);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova);
+	test_cmd_revoke_dmabuf(dfd, true);
+
+	if (variant->mock_domains)
+		test_cmd_hwpt_alloc(self->device_id, self->ioas_id, 0,
+				    &hwpt_id);
+
+	test_err_ioctl_ioas_map_file(ENODEV, dfd, 0, buf_size, &iova2);
+
+	test_cmd_revoke_dmabuf(dfd, false);
+	test_ioctl_ioas_map_file(dfd, 0, buf_size, &iova2);
+
+	/* Restore the iova back */
+	test_ioctl_ioas_unmap(iova, buf_size);
+	test_ioctl_ioas_map_fixed_file(dfd, 0, buf_size, iova);
+
+	close(dfd);
+}
+
 FIXTURE(iommufd_mock_domain)
 {
 	int fd;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 772ca1db6e5971..f6d1678b310e1f 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -548,6 +548,39 @@ static int _test_cmd_destroy_access_pages(int fd, unsigned int access_id,
 	EXPECT_ERRNO(_errno, _test_cmd_destroy_access_pages(              \
 				     self->fd, access_id, access_pages_id))
 
+static int _test_cmd_get_dmabuf(int fd, size_t len, int *out_fd)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_GET,
+		.dmabuf_get = { .length = len, .open_flags = O_CLOEXEC },
+	};
+
+	*out_fd = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (*out_fd < 0)
+		return -1;
+	return 0;
+}
+#define test_cmd_get_dmabuf(len, out_fd) \
+	ASSERT_EQ(0, _test_cmd_get_dmabuf(self->fd, len, out_fd))
+
+static int _test_cmd_revoke_dmabuf(int fd, int dmabuf_fd, bool revoked)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_REVOKE,
+		.dmabuf_revoke = { .dmabuf_fd = dmabuf_fd, .revoked = revoked },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret < 0)
+		return -1;
+	return 0;
+}
+#define test_cmd_revoke_dmabuf(dmabuf_fd, revoke) \
+	ASSERT_EQ(0, _test_cmd_revoke_dmabuf(self->fd, dmabuf_fd, revoke))
+
 static int _test_ioctl_destroy(int fd, unsigned int id)
 {
 	struct iommu_destroy cmd = {
@@ -718,6 +751,17 @@ static int _test_ioctl_ioas_map_file(int fd, unsigned int ioas_id, int mfd,
 			  self->fd, ioas_id, mfd, start, length, iova_p,     \
 			  IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE))
 
+#define test_ioctl_ioas_map_fixed_file(mfd, start, length, iova)          \
+	({                                                                \
+		__u64 __iova = iova;                                      \
+		ASSERT_EQ(0, _test_ioctl_ioas_map_file(                   \
+				     self->fd, self->ioas_id, mfd, start, \
+				     length, &__iova,                     \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |          \
+					     IOMMU_IOAS_MAP_WRITEABLE |   \
+					     IOMMU_IOAS_MAP_READABLE));   \
+	})
+
 static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
 {
 	struct iommu_test_cmd memlimit_cmd = {
-- 
2.43.0


