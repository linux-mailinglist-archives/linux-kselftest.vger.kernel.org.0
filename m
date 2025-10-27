Return-Path: <linux-kselftest+bounces-44127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2DC0FA66
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E434FCB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE78316907;
	Mon, 27 Oct 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qd69Q+ZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E6316918;
	Mon, 27 Oct 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586283; cv=fail; b=oSGW1PnGx03acwMb45m6b6hZCXE4+M+MN+PdzNJx97ktyjmOJQWkztcJ7DCHZhQ+6V4S00AY+4dISxvnHu5sIpiHxRVc3WyHsBeTOly6jqJVvNUKHyWVPNPfd/IoS4Ap5HtwSBCepRS7wCahbisUBo4Qs+G/CHSmpGc6zZIxEcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586283; c=relaxed/simple;
	bh=6wuUgCisFPR8Qylo5R42180+nM1pM+YjnpZsVkhTe+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8giYq7Ih07ltcuIrrzMjwHFbA2V4hB13oIQgpAg8+DOsMTJ1z6SNM++8d0izXuNaorx9TFpXfbBJWymD3rgL0fIUD3PxXpJdKn26M5izXMNsNmQf+9tPo49bE7zCHi3eDVsH3Rqrlm40x8psd+FfVGt6nIGV1EjQ47l8rCDxIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Qd69Q+ZA; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXp+6y6yPMpH/EEHwLu2O8Q68aIKCcVkoGhJpXQtF0Qn8Hogw2isSsM5PLfqM9sG49Uz2gWCBJ044huxu5gYwO+4PArhhqNin0kgi4/AxFi4vCCWV47LtpcScHgQt54C+iT+HXt2iJOxooBgjdDNj3mQRu4INf8n//Wa5+ONV7OZhOAy40Pw9/Js4FElQfkb55IwBx4epWQzT9qyk6lYXmtmoK4zjyiJ+YP4U+iZh4OeMGTgP8S0h+6SE31pjCs+DxFzWMLPmSh7+2e05jJuOM0fh7k71DnYclH46wJR9U4uMmGkTJTeH6hff2DgVl3lRcSB3/y7NMwAVi05JbBbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkyik+euRNNxEzSV0olTz8E3fBZp9EXTdhwrDkKdHC4=;
 b=LfpIznVmFgQr1lWxGF+dn+1a1yh0HkDDP1n4ozeVXv9iENMQhVw40NUy1bxV3Zqw+pNEGr0eFzH0/mg2PuTS+L6BXKy66rt+2PeiiyrqYERTxWrwreibFSU/ztnib1uxWqAXucZlpU+RtjB+Ce0/g9p9PR+aYLFVeljeQn142vB4ISltudYCP70IHBFfIK9YDcDBSOd4ynT2OBQSR7Jf45TjRqV662qBgw9Vahpt+WbM3WG88PQO8q8cEwWLbZX6Zy2Iji1dvc+8bF52FysdKDsrk6nw19nkjp3ZMXod+mCKaeiosA6Fu+Lxso+U6WdqZ6U+h765cHqOLVSV7d8mwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkyik+euRNNxEzSV0olTz8E3fBZp9EXTdhwrDkKdHC4=;
 b=Qd69Q+ZAlbcGWP7jAnH2U6gewAR5cbcKIcUBGAfWTgApb+YlmHXQBgK4/AZw5H+0cmfdqug8LjK43xGZHf8o0GGQS6cOBnByIaRYN5lHLhmgMSjBk2fMvo3kv2MnPrNdHcyaDDE8qDCl1o5I4TyA3Mk5/VPonQHvEM7lXhqv2mvUUdx0+wLYB+n4ClMqNDtbsXKYwpRDCd+U8ABdIG43OQSl0u9rp0ifJLfLyh/ZeaA4ylMnbDV9GpqCfCBi+HnsaN6qgvBiR6Nq3ZQYNwwinTFDlXNDIA0DDMvNuLKOiRYnm0TZQ5/GHfzpYP95j+kroFghl8FzMgaqhPEB1b8JkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:31:13 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:31:13 +0000
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
Subject: [PATCH 7/8] iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
Date: Mon, 27 Oct 2025 14:31:06 -0300
Message-ID: <7-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:91::36) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: a33b760e-d1d2-465d-27a7-08de157e9ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vyxpfoJc5z0JrUM4QfmWpo9mapdxWmbfXCcK4oE3LEBa12EwYuTat81G3Dz2?=
 =?us-ascii?Q?VwMqd+TnMWe/AK5aZBu/FDSIZpHIvMU+F29qi4iLDucvN+axiKxRzDME6ir1?=
 =?us-ascii?Q?8epCE/KWi4+EwB9zCzsKzQuxU4REHXSv6KfZpYH0wgy16Pwh36iRc5Enkfwm?=
 =?us-ascii?Q?m3RZVA6RJ0UV77RtZ/APgU5w42u+mZOoxO654Dx5xAssBioRW8K42XVFOdio?=
 =?us-ascii?Q?RR7Zg0Df/iKLUSKL+YBdQsMDZeik//zCthFhpu8SMiRjxOWIHhLs+73hRzWq?=
 =?us-ascii?Q?CabOEhr5CHvrCnVxI7oYknJQ/1fFR44uCKv4mIeK09AX/D7wfXHP5FoTgq7B?=
 =?us-ascii?Q?UL3YbQqOWNmrPXdJVcVrd13iQCELRZ3iJL0XnceDqcREWDOReKIEKNQKKI23?=
 =?us-ascii?Q?+dYnflCrCjASYi1d0wU0DFXlfIMoUe9ebFtyOSM5TD2rH9yvzy/hzUEouGny?=
 =?us-ascii?Q?0MDB+Mw6INUn5LVCBcXKCDCDeOzHoe6w1Edx3Un3BrKLoyRJ8uIBntPfhfpk?=
 =?us-ascii?Q?lcDLfoASRetld9PgDGOAey+68E4nczLL0jKGnqBRAbgRTEFoTzTdUild5lrN?=
 =?us-ascii?Q?2/IdsC5OKd8zOezFVILQwoE5NVUcP1zL2W1pZWp+FcG65OFpL8WbSwdmQ6o2?=
 =?us-ascii?Q?goFGskk1Dl6+bcGBNGyF+dZR8e8tpik0997RQ9JDexYrGTd//huyO9yCOwCs?=
 =?us-ascii?Q?u5mV30mUw/psu3RPx6NT4FbOlIwFK7OmQ0Ly9fPTiPfh/kCR7u9nz9J6ms7z?=
 =?us-ascii?Q?Ok8BarO5/B1FcT25reQhHfjHfRPg6O+mHtrUtgDyCJ6PlT7kWh7RQBVaw7fd?=
 =?us-ascii?Q?E8I7bftEZ5NxlyXdIR/EaqNzJuejVHRpvmFVfD3+ObxsVSHi+flOVzC5VaWH?=
 =?us-ascii?Q?UdH/oN8LEWy6SIcq+ThQqa+B5pGbeIswlL9lv9GoHdapIKNSSPbQXwS89ohp?=
 =?us-ascii?Q?LcY3YGDdcLei1LlxcJcTSUWiaLDXzkmtqltR0uLSBIrxqxfajzq/lMD3CjJ4?=
 =?us-ascii?Q?o+oX8WYBWwMGFSNFav0pE6Fg7y5wS0aQNhox16ovy788OGkkxWwBvBBfduAb?=
 =?us-ascii?Q?2K2wOPqjZrnoKJFaTKsCcunLTnx8kEYDOXHHfPBCoLNVEFbiNstQMcc5Ugy3?=
 =?us-ascii?Q?CxvGWv735GjMCrmv1wsBg3rajEE0aLkoi58QW/IjR/yzcjzoG3YpeswDskUS?=
 =?us-ascii?Q?69qAr+Opp3PW+soOq+92A7Ps5mqDOEl0oV0ASvt0Cymb0JxZafIHz6BR+VRA?=
 =?us-ascii?Q?+dY7qnNj6+xRrauut3S5Z0pBjwPZM0lcrXA2qqxHn1UwLv/IVM1rgsG0MqaY?=
 =?us-ascii?Q?nfOfmsayrWjtaBcduryZatOhlBhDmRDIHjKISUCfWr4atB/wwZCNBPLzgSCn?=
 =?us-ascii?Q?IkCcjRzsfPbujg9TsQMJ3HNpkLPJs74rP+GERB2B2HtaBFmzfG0wEbrHtKzF?=
 =?us-ascii?Q?v0Lu/68ng2P1CQ+jlQ49k/uuZloy8hkgA4iZagR6pKZrpovL6nuA65zK3dZv?=
 =?us-ascii?Q?4SuVCaF5UikAnVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EB4axHVKkcWs1hW0GjUPihgDrEIZ4IbyCvPAGf+2LuLGfXQFWHhT1CZbBlIK?=
 =?us-ascii?Q?O7t6dw08m0w/WNIPy9jtkJifkaONDs0wuvJlLKgAqt29pImDPOU9JK9P7c5d?=
 =?us-ascii?Q?Y7sy1yGxklv+WP17x+DB51PdjFZgEkP8VjbTCNBld6qnCy7LT1jGKKq80oE6?=
 =?us-ascii?Q?XzK1JowlXR9r850Ly/FcpfyxlfsN6roDsSo85cNecEMPcsTsUYoZHm+Tc0mx?=
 =?us-ascii?Q?dMvwJ4XPBQpkXdV1aia+uZe/3+E/y0cEV5fYSioZjN+1wKzW028Mrti0oVDu?=
 =?us-ascii?Q?jDP6iHvGP+s4UZo2RfypbV/8IIiqno8MEE+gnm3yN9ke1oxrB8NPNQuGAJEs?=
 =?us-ascii?Q?2veqOaRm+eWk+VgmVuhFYER16CRB2jRmykBS4K8R+PzGyyyN/iseFUZUqLq2?=
 =?us-ascii?Q?6564EsdHuB07A0Y6gnNivgRncZEEEt4UMr8/sVW7fmsc3iWfLvfuD2lVEAZH?=
 =?us-ascii?Q?N4YZvrzZBGlEzn+zBMs8D73dPSD5t9g/XCef5rTt/H0FL2XiEpdbwUH9g8rM?=
 =?us-ascii?Q?aBmPAJmpiueTFgOFuiD8pQJFp97BNu62RzJCzkSD4kbGkoVyye6DjJeXTvVM?=
 =?us-ascii?Q?2qDDmowBo5OWJDVObLdpqNQvPHn0osoyPestbojU0G1YXebXmkyP61VvqNeO?=
 =?us-ascii?Q?6HBTwRB/gty2DFLGy5n0EYsNKjXhnSQJTjxr1Mx5IrOjY+ZaJ916UxA0Lf1m?=
 =?us-ascii?Q?DWzFSIgodgAEvyaPDkOSvLF/1Dv+MHRqQ0klaDLjHC/0K7Qa/ZrhyQ/J5Pth?=
 =?us-ascii?Q?74aU3cJPYpyqfZg0JJIWyCAWxuNrPb4WRwGW7bo9ExqSnODplqYGpOuW9+DI?=
 =?us-ascii?Q?JoEsi+ZucB6kc+SpfHgvU/0l2+U5+TJw398XUjRJKEpJaDNKcJjIj2hSoo8g?=
 =?us-ascii?Q?XcGxXMB7HfEpw0Rsl5+k8ZMkNcjCUS0wz8qDxG/mcPcXZ1oF9ldlgqata/HV?=
 =?us-ascii?Q?AmdaH+KoduOu4JOgWh47QhVkpbXnC//lX8QtvXtYIBO2pON/J1b1RoBUu8g/?=
 =?us-ascii?Q?heSVcQkYy7J6lsJNhztCKVrll2kAZWQwlEgD8Tlb2GytyuTnUIaqdo/onmRr?=
 =?us-ascii?Q?ddj2whjPIwseYggaFHF/+JDRQegle7eotjxBBCNgbmiibtCbj1NEBayvy3Pz?=
 =?us-ascii?Q?xFHZr7PySnupD0cVQOeLnXKjDn9MjRGTW4/icv9seoo2OGCl0+yb67pswgvz?=
 =?us-ascii?Q?M+Q1HQiXFFbrH6ilHnmD9rehE+9lQ1+XM6GvWmVXJZpEx8WLmsDuLltnWwpj?=
 =?us-ascii?Q?jdJPQmMarL5tlewMuEZOGwyBkN++LaYXk2uaDD3vWiNjsyuZSBZjt978SiPz?=
 =?us-ascii?Q?Ee/JpHNnQijqtttXt20mjZ4bl/fJ8C24RnBUyUpSVcmiT8MjTiwYsf8mQnDa?=
 =?us-ascii?Q?P9IrEXiszNdMuHLCHwubSneWVwWs1Op8J+1cFS3i9zmYLyXEDy7H2vtK2K2L?=
 =?us-ascii?Q?71h1y3QJKyye3dRNyuU2qldDLtKWTWuKpGFuIqTEoIHeqqpX2IDlnwpQn8FA?=
 =?us-ascii?Q?/yKn1kSham42biZv1aVktzveEx92u5C517hyN0EX9MJsGrvHmqdjY1Pxxz7c?=
 =?us-ascii?Q?cdOa0Wkuh+Yo4S+UjYE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33b760e-d1d2-465d-27a7-08de157e9ed0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:12.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6DCdaREWJNe586leu75NKKMVF4vB9rstfLPco/jWSejy1IXO/xTPP6o6vY/yzrS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Finally call iopt_alloc_dmabuf_pages() if the user passed in a DMABUF
through IOMMU_IOAS_MAP_FILE. This makes the feature visible to userspace.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 43 +++++++++++++++++++++-------
 drivers/iommu/iommufd/io_pagetable.h |  4 ++-
 drivers/iommu/iommufd/pages.c        | 13 ++++-----
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 0ab609509a81a4..b78a44cf54a431 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -8,6 +8,7 @@
  * The datastructure uses the iopt_pages to optimize the storage of the PFNs
  * between the domains and xarray.
  */
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -484,19 +485,41 @@ int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned int flags)
 {
 	struct iopt_pages *pages;
-	struct file *file;
+	struct dma_buf *dmabuf;
+	unsigned long start_byte;
+	unsigned long last;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(start, length - 1, &last))
+		return -EOVERFLOW;
+
+	start_byte = start - ALIGN_DOWN(start, PAGE_SIZE);
+	dmabuf = dma_buf_get(fd);
+	if (!IS_ERR(dmabuf)) {
+		pages = iopt_alloc_dmabuf_pages(ictx, dmabuf, start_byte, start,
+						length,
+						iommu_prot & IOMMU_WRITE);
+		if (IS_ERR(pages)) {
+			dma_buf_put(dmabuf);
+			return PTR_ERR(pages);
+		}
+	} else {
+		struct file *file;
+
+		file = fget(fd);
+		if (!file)
+			return -EBADF;
+
+		pages = iopt_alloc_file_pages(file, start_byte, start, length,
+					      iommu_prot & IOMMU_WRITE);
+		fput(file);
+		if (IS_ERR(pages))
+			return PTR_ERR(pages);
+	}
 
-	pages = iopt_alloc_file_pages(file, start, length,
-				      iommu_prot & IOMMU_WRITE);
-	fput(file);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
-			       start - pages->start, iommu_prot, flags);
+			       start_byte, iommu_prot, flags);
 }
 
 struct iova_bitmap_fn_arg {
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 2d5b8778735a56..7424d9514d4685 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -264,7 +264,9 @@ static inline bool iopt_dmabuf_revoked(struct iopt_pages *pages)
 
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 					   struct dma_buf *dmabuf,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9c017064322b41..524cd64df8ebab 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1412,22 +1412,19 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	return pages;
 }
 
-struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+struct iopt_pages *iopt_alloc_file_pages(struct file *file,
+					 unsigned long start_byte,
+					 unsigned long start,
 					 unsigned long length, bool writable)
 
 {
 	struct iopt_pages *pages;
-	unsigned long start_down = ALIGN_DOWN(start, PAGE_SIZE);
-	unsigned long end;
 
-	if (length && check_add_overflow(start, length - 1, &end))
-		return ERR_PTR(-EOVERFLOW);
-
-	pages = iopt_alloc_pages(start - start_down, length, writable);
+	pages = iopt_alloc_pages(start_byte, length, writable);
 	if (IS_ERR(pages))
 		return pages;
 	pages->file = get_file(file);
-	pages->start = start_down;
+	pages->start = start - start_byte;
 	pages->type = IOPT_ADDRESS_FILE;
 	return pages;
 }
-- 
2.43.0


