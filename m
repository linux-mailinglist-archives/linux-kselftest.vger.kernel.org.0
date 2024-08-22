Return-Path: <linux-kselftest+bounces-16069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B1B95B8DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A4EB254FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D01CC8B1;
	Thu, 22 Aug 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TF2fTJ5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CD1CC172
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337961; cv=fail; b=XkqyO2t9/vzNExXEUSvSmmTkFGjc2yTlAIXg5MRmXznM2zUVMjot36TR5A6YmzYJ9zw6ROtZtb4ng7MjdsILxg9MQEccWV81lgug8IjwYJbRNV7ObsSnT+i3fA0S/2Yx6dW1a8CyQQLcYir7l5/tyCOEtw3ZDlvNQ1yFOWHJSdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337961; c=relaxed/simple;
	bh=mSCo+qIbwYGsrzeFEZ5i2qEJZHxFJNsyDEBdTY1kcwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncCMKAjD/dYgfRM+SiwntzPsGPoQAa3Bd4TzNFmb2EHDo40/GU9OKeizhP7QKAGr3SriGUUjPOonyo9CcfzhO3KJh+l0r5zh+pkJQaT1Qj9/racwZ5Z7OP7fvarp+URHuU2513ELOEcAa0+dfpnOGLTN4mwHqRGq0BepgwxMYZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TF2fTJ5H; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfNuHdCpzZsjCK5ktOOLqTENyi2lBtZBh5xUXkfQqB1hMp/dVCcF9kC9/T9uJeKuQpZTYHKrIAsN+9anEsj+DInKnrAjy3r90RVULFnD21qMbHPtzW25WOa8qN7sVt66aSyKfCNKnIf9SDobg/nb+s6ARH6vQozOglx0E/gk9/OqXDDU2Iz6fCaVvr1+KK2WhgSNNnLuNtHyA7J+F181S0Y8wttl+hkyAw5A2MU4C4IYc2Sk5vroJeHb1BAWReAM5a5S9cRE7lgmI73LQGoyZMgohusvC4lM/m+SnrLRRCqEFHwK53+krEZXD26lTzHIvdA1OoZ8TcLjxzaMvQJJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bniip3OlQHmIpoUbt1Eu7JQNJITIadPtNd79nLHSkRo=;
 b=O9WbqMKE+DY2yVRniwV7jjVCxRsl8k7r+P1eExFN60ad6cE/inqFx+IkPIkhqTYPtFF4LCrekmzWSUqsvU4IIL6Up1Z4XbvRYk7i3PjpHPqtFaWKMJIsGy4mZYcV80Sw49kMccXtJzjZj0znhkf5MGjUc8rut7RgKFTH5dc/yYPcRA1XTRsjSXnSUNIxmEg0NZ9tTP5sPBgXyb4eu+IbgqMBwfd7JxI2VPzmsxWHJ6aN+Otzp+jJzBT8WrSXpyb4JM/BPirvsHHMCbCeKgFgET1ZfIwDvoPK/hulPXrYFU+DLobDLFIkZL64XjtsKz3yswBCijb/xnnpU/3S61A2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bniip3OlQHmIpoUbt1Eu7JQNJITIadPtNd79nLHSkRo=;
 b=TF2fTJ5HvjkdDq/0Miug6RUcnJ5oZRyhIMK6x0h48FKyvnW1Ei/yIlT1Wt8Qf1uBvzPVGZuXvk+bQ7N8tuUE/BiLvM8EDlE1aJqKVifQzuu0/7MNtIdZSvzY51DSLCql7ShJI6buEKgwryJ15rqMPqS3flD01nq4h11TcZutN/oOSIcCWJWzvh9iAvk8B7sJ/4Y2DFkYy5HIY3BCk6KFpruk0oGLnj2uptBUeKahh9OMEHM1oLmfxZ+MCG5Xeq2QZmLieg52RkLKpg91o5d3zCAj17q+HDJLQegu18g43ySwoDeMbo9MGB5A2wNzoKFhFJMNDCy9NKKYNSgCJ3X4sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CY8PR12MB7121.namprd12.prod.outlook.com (2603:10b6:930:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 14:45:56 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 14:45:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>,
	Will Deacon <will.deacon@arm.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH rc 1/2] iommufd: Do not allow creating areas without READ or WRITE
Date: Thu, 22 Aug 2024 11:45:54 -0300
Message-ID: <1-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
In-Reply-To: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CY8PR12MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: c1016b6e-abf1-42e7-597a-08dcc2b92118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8wbC9w3HtGMlC4bBHKHpVxED3Tenb5CiGcA/3VgPz6vcUSaoHJl1oY1T+gkl?=
 =?us-ascii?Q?RrmOU0M6npRgx98go2nEC+V6Lgh0smLkhtUDIiWWY5nOLzQaJG2b2KHL9qjP?=
 =?us-ascii?Q?SQIZ3yP6mj+u2IBwsAe6wVWurG42+h2PU1Ib+NZbbHjcbyGIbbpNhYND77+q?=
 =?us-ascii?Q?sHiVhTgrNjVtr9NukV1dnrheNhiqAKDNNVYalr6HyRY369uGjg0PO5cTgNYP?=
 =?us-ascii?Q?zxlKxNGYAN6GFjOoKCLdbabBEeUPJf+VXS8BlP0Z+xweVXw7thdFVMJO7N3+?=
 =?us-ascii?Q?c8ZoDcdehLG+jViBlhOvngD8aSV7FBar/1ZYydMmE0P/DXyaVNlBgTluqX14?=
 =?us-ascii?Q?OtBo2qCAgjobOHCXZmiAHz8sG+khA8Tt+5cEkl9qDX63hjja0sTIni0Bk/3C?=
 =?us-ascii?Q?nVWADOnPsV194CUcTCTTBwacTKTfeUI0VHVhku0LwU8E2YhdelLHcVW4SZ5k?=
 =?us-ascii?Q?CQPsuJkKdaDN5Sv2SwrLc4p+LDNfzvu2z3jXtk2c1AhuCELpKyK0GmGWhSsE?=
 =?us-ascii?Q?YWIDSS/t1UwiDcdWszSWxG/2EkQPBqZoxYPlIrfrKcwVmXh9aqCjWEz7xTJk?=
 =?us-ascii?Q?XTmeF0Sb3tRSYVpQfBTHrtFqUe8q+WMsagx35tWHQI19rclDyFRR2nL6Cgoy?=
 =?us-ascii?Q?dApTDuDLbFgeXIrr5Yv1LLz557TCekmmkAvL5v9P+ccvmwy1BS5O6nC9EA01?=
 =?us-ascii?Q?eyv2vmZABmLDsuL3FEVDK0Jg3rbZW2efvXEOYg159sfA0E+RMjrliiBqZB0q?=
 =?us-ascii?Q?bwHA0rvc8046o+/Q8dRpZtD4tcrk4JzcOcEyna27WYPP6ReejLa1UIuykr2O?=
 =?us-ascii?Q?RyLh6Q+7SV7GOgniHSWoWRtd7yMXFwNgn4oLO9QjhtAHHCM5dzciLz4DNf8Q?=
 =?us-ascii?Q?6t5rgW2y4QT+kwhztV2QaB5vV5CbFBkCTPkhaETCyAoE1p23D11KTMLs7T4V?=
 =?us-ascii?Q?/ZTBlQ+POebb2SoCVhyBVCpW3tCL+v/qx+xR3EGr1Y8yhI4Aa4Tm3p++PZ9P?=
 =?us-ascii?Q?qVTd/CDOyFMkzApLA82CqEPZh2OSKYwEDPYhG45mVRgRuG+xexgrJfHv3esK?=
 =?us-ascii?Q?DpxQFm+RihtpgkfmeKLjS1Al0qGla4E+ZdgSyA/WBStoSKNNeq3B0WAJleiQ?=
 =?us-ascii?Q?Qe2vi6KwoffkgZZhR2/wcYLUtCE+psMhwGQEEhUuTgSpDFSEkHEnnejmKxl6?=
 =?us-ascii?Q?p/F8jyWNRa06nG4T/q5EB44CMa4wYL/5gjVdSrkpaxecSh4yUF/wLJnD2M+Q?=
 =?us-ascii?Q?OJ6Zm2dRHPkoMK07XbdKnyMDyhJBcfgFYic+0gmtnbsd2HYEqwW1FKVZWqba?=
 =?us-ascii?Q?F7a+F2V+U0zNzghxCXHBH3/FiHoERCXARY+RHvYOFWEcZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UH25TAbopC/2ZUQYlR0V1iSKF5XVGtdP14r8JPJHtgg6Rb4r1H+RKRqFW5c0?=
 =?us-ascii?Q?g7kzWDov7I6WYOkxSMl9y1Es2ZWL1gXYSD+eHNAOPZ2PXUF8alSPxL1+5Ms7?=
 =?us-ascii?Q?o0awuPTfjgH41Xz54WNnCBdPgMeOrGvL6c76KKpAEoWYvu0j3xqzyeZXuuRX?=
 =?us-ascii?Q?Ec01Lrmpy3OGmzNYpAtfUsgXbIuyraVRxKzMxeuyHx5/c98/8NzjU1SiMpX1?=
 =?us-ascii?Q?sy2kolIif3Molz5cXIRBCHIHZ6BeJj8qWnwXMxX6LFQnogbJr4ptaATOor8v?=
 =?us-ascii?Q?o+FM3C+Pa1HtEwRnPVpMuvtWGITCgf7BE2hqJ1xwmJlfTKDqn/1enC4InUNX?=
 =?us-ascii?Q?soa/+EDVYaUP3NLv1gT0UkJPSoKok82ptjXIVxK7bbM055CiueQNJwXhcYFG?=
 =?us-ascii?Q?IpJkp9ySKi9C46sx8/UCF0IjyGeOjGO8LQbVwaPY8NZy9wxylWPuGw4uDciO?=
 =?us-ascii?Q?Imwf+WJNoDPFQTKjBUx70uyTLLYfV2iSNqy3SIrvf+2bZPOZtSCcXR1yLO7N?=
 =?us-ascii?Q?6AXeeRuW8t7tJE7q8RfhqGe+D+iPzmiWqSr0734wn8bCgnXVNq4s6FE1/OFa?=
 =?us-ascii?Q?YJVTrTMN6Lw2VCaU5hbbjvv2CVfRHBEwNSi4v0y5//2UAvPzpGy1mIXnQlMD?=
 =?us-ascii?Q?D035GvsZvTZM0c2ROWmaUVEOWHjAS02ua84j0hZFGVS54b/+trzSj3Ew7hx1?=
 =?us-ascii?Q?aYxpLhFRFBfi9tzBv/Hlua/twO4jvrlUEmVV7GNwnh7tRsP6nbv85XMvtOFj?=
 =?us-ascii?Q?mdujsACEQQlhPlDyfeplTjaB8knphRy0+q7uCGzAAo+lrI0vnQMUNAzcSBSY?=
 =?us-ascii?Q?pTGjmVEMPCIWKx9DCiQ1dNXnRB7NKw3z3b3oMUCAGCFTNBetxFbbgDXXK0If?=
 =?us-ascii?Q?jPgLqtyYTDYsAZZqGdc18yPDrEP8vxOrupdb6N/m2cU5CUrP9XLgSPLPHZXH?=
 =?us-ascii?Q?ENzCmphkQiKDVslTqVZdMe9x4zlc56qeanSY01W7v1l5DRXCV1q/vdLLiUv2?=
 =?us-ascii?Q?lRJPEv1rbwMwQMJTo8C0Ahqn11fejZDHea5oYYKEJku5vIkjO8exG4DykFxa?=
 =?us-ascii?Q?+1YcosmNDXP3PEASZDksGNZdk7Z4X73a9K2rXqattD7H9MoQb/fSJ3DoWBDX?=
 =?us-ascii?Q?ZCr6uHP/gfK/S830109fjqBgKSWSE89yZ06kyoutebZkBOG/Zt7cfdPoYix8?=
 =?us-ascii?Q?c12xX06kARf3AZKXwiwHzgRoVX/+AljA5tJpn2BuXfcYOFLhqgEQMsZOBr8J?=
 =?us-ascii?Q?uHcA83pKwXz62MaMnUK/a6oaB0x31N4PB+M2lYdimNRRsTseZ7pHjJTOcbdn?=
 =?us-ascii?Q?Ob3/aWCUooOzDclxVXpIKSYQVbLPnxuwo8VHkJa1gg28is+0GITki+m1wBbY?=
 =?us-ascii?Q?DoYI1XsXLVRLT0ngMLKmB+1Q0sVlQDpMqMIZjdorlihQtDunBIb8ZXu35uGQ?=
 =?us-ascii?Q?NMoaSscLokYZakK95TfibUHpF4bIyI8Z+caTECsED7DPW7C3Lp3kFzL5i8Sz?=
 =?us-ascii?Q?cayISRUjg8TNzhGpBMr7nW6/vDzLoF2oFe0n4GsCt5XguffZzhZliUL6BacA?=
 =?us-ascii?Q?5jhmyaTUEA+LtLrPtLwnOMMo51XqFZ8x9WI5NB31?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1016b6e-abf1-42e7-597a-08dcc2b92118
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:45:56.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZcbBiYY6NH7homoYyXYkOOoIuUwa9PdU3M87+kjC+NZH4bhwXJ7YfbjXr7klhCf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7121

This results in passing 0 or just IOMMU_CACHE to iommu_map(). Most of
the page table formats don't like this:

  amdv1 - -EINVAL
  armv7s - returns 0, doesn't update mapped
  arm-lpae - returns 0 doesn't update mapped
  dart - returns 0, doesn't update mapped
  VT-D - returns -EINVAL

Unfortunately the three formats that return 0 cause serious problems:

 - Returning ret = but not uppdating mapped from domain->map_pages()
   causes an infinite loop in __iommu_map()

 - Not writing ioptes means that VFIO/iommufd have no way to recover them
   and we will have memory leaks and worse during unmap

Since almost nothing can support this, and it is a useless thing to do,
block it early in iommufd.

Cc: stable@kernel.org
Fixes: aad37e71d5c4 ("iommufd: IOCTLs for the io_pagetable")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/ioas.c            | 8 ++++++++
 tools/testing/selftests/iommu/iommufd.c | 6 +++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 82428e44a837ca..2c4b2bb11e78ce 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -213,6 +213,10 @@ int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
 	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
 		return -EOVERFLOW;
 
+	if (!(cmd->flags &
+	      (IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE)))
+		return -EINVAL;
+
 	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
 	if (IS_ERR(ioas))
 		return PTR_ERR(ioas);
@@ -253,6 +257,10 @@ int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
 	    cmd->dst_iova >= ULONG_MAX)
 		return -EOVERFLOW;
 
+	if (!(cmd->flags &
+	      (IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE)))
+		return -EINVAL;
+
 	src_ioas = iommufd_get_ioas(ucmd->ictx, cmd->src_ioas_id);
 	if (IS_ERR(src_ioas))
 		return PTR_ERR(src_ioas);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6343f4053bd46e..4927b9add5add9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -825,7 +825,7 @@ TEST_F(iommufd_ioas, copy_area)
 {
 	struct iommu_ioas_copy copy_cmd = {
 		.size = sizeof(copy_cmd),
-		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE,
 		.dst_ioas_id = self->ioas_id,
 		.src_ioas_id = self->ioas_id,
 		.length = PAGE_SIZE,
@@ -1318,7 +1318,7 @@ TEST_F(iommufd_ioas, copy_sweep)
 {
 	struct iommu_ioas_copy copy_cmd = {
 		.size = sizeof(copy_cmd),
-		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE,
 		.src_ioas_id = self->ioas_id,
 		.dst_iova = MOCK_APERTURE_START,
 		.length = MOCK_PAGE_SIZE,
@@ -1608,7 +1608,7 @@ TEST_F(iommufd_mock_domain, user_copy)
 	};
 	struct iommu_ioas_copy copy_cmd = {
 		.size = sizeof(copy_cmd),
-		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE,
 		.dst_ioas_id = self->ioas_id,
 		.dst_iova = MOCK_APERTURE_START,
 		.length = BUFFER_SIZE,
-- 
2.46.0


