Return-Path: <linux-kselftest+bounces-39974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D27B37115
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDCC8E3C48
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6432E371D;
	Tue, 26 Aug 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZEGn+nip"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67222DA762;
	Tue, 26 Aug 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228727; cv=fail; b=mgaxoiokvkzR60nByUCE2VQxuRmBjuEVBzwu1GMjKQLz/zOCU+w1/qjR2zjSQZwZy0bSi5RRVf9k+/Fm2H0y264Q3EN6Ob7v7xFQvMZq8LBPbk+aO4x0P3awpCrFLwdQMmMC2bDH82fD9ckPbG7RJnkVzuQkO5z4p5JQ99/nWiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228727; c=relaxed/simple;
	bh=1QGmstL4DCWHV3zA4t/PYRZOtI8I3s+Y/fBdC2TpDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DlBkzx7z5owFDpCgibzxq2w69n1kilz8VRKrkDfRxp1lUKkH3CsVnBNgeTEAUssgpgdD+GdRNeE+JUkEhpV7/yRPqdTkki8nh1M82jUJdUI50j8zePlffKWlUNOHawC1dsXu3kusV1MRVv0DeCoSQ3vFXzrbGIuSgbAW3hYmd8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZEGn+nip; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs4spNOK3mgRyXNJEGdw/yipAa2Qw3RHzxCvX0wXYfX4p57irJ3Tpe77o3SeLwgMKUYis/81wbFZZFMXTNXejWmuzLL3F76mxKMC4lJI20XC5HwwKu3MFPc/Efc5HhFdrC+IpiqyDM8woqrMdYttjr8cebGvUGf4kygotpm1Ce2bDFu14OEd/EbqljHlFbEt+8K4gQc8lWhI1hEoNBsz6GGoe6d19CVsFWUwpYjNRgcCPlqiDe8YQIskjg78048GWDNK7pL/kqwOmjqniI9p3yQe56iQMc2oURwI4IVWILZ04UKfj3Vrb4NokMs5IigXCg9pxpB/qpzHgg5aYsvIBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFGwFNaMlTTSdnT67S7f4626J/kkMOV+6BmsYXxPB/c=;
 b=K0XjN8d7Khi0dGexQbt7x6UjJzRKWXxmUbwaFq1LX65qvX6iZF+X+n4dNSB2gj9ERdvBH2/qmlom57ZnK73NQtmyrsdI/YpOB/6hlMrP8S9WzR6n0E6IMFESBP0u+kLW3TlpuOG6OJvccDhb00aYgkWC1IE5ik6/5DqGJqD4oCutaRc/CRpYs0mmp2gr3IkfXgXFgaZ4hpSauhGFjxQdhvAKGPzbSTnqYr4XWTKX09Git+OuBhGSznueR6lEE3yQC1R+FP3+cQN7BOi80OcL582nnM574XR2lx0RK6BFS3HqS3dO4PbacbAh4qH5tJMQ25HzikZ9fliDGddPi9l3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFGwFNaMlTTSdnT67S7f4626J/kkMOV+6BmsYXxPB/c=;
 b=ZEGn+nipxxdGmb2coBIo8fSdaFjPVZ76J5zQM8+S7OnRSrvLlg5qmaA/993VuY6DRNjF1LuRziTcgk3b97CETPSr+N+c4tKRfzok+Tk9McuG3U05o1p3ABIYeU7abhyk+BFTxwV9iiyySGcFSvy614NENjGktz6O/qyVFD6rukmGBl0QHiy2JN8Xpe2x70E8cUlMUGcndfaTc67fHyV6vo/d813x2+YnrsGoT4MdzZNBgBECbeeyYlBteL0wjRDsP9kGZIVdyNlCRuIdNLpggfDyxNRmEysh9ZGPbLa/d6VkOdLGvirTDZsaT7j21RJX1hPAazZbjf2RSXggfMZvgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:39 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:38 +0000
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
Subject: [PATCH v4 05/15] iommupt: Add iova_to_phys op
Date: Tue, 26 Aug 2025 14:18:26 -0300
Message-ID: <5-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 62865e59-0941-4152-bbad-08dde4c4987e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pOGZNx17ExdyEJfaFN+ReJnyPyxDv2oA45adbhxnJdIE8GpCaWdOF7KrsRup?=
 =?us-ascii?Q?9Q4IZUSrbhAUyjVadfgkd30SgUI5glAlIMUxI8MEh9nfJ1u4ndcpZEO2MU7A?=
 =?us-ascii?Q?tBPyrf05cce4adE32SVfJRUR/rwRhCiNLKa/NR2/nVlJd3P/U6R9wAsJbecG?=
 =?us-ascii?Q?+K+MjnMI+WUev1fdiRqlo+BVNEbB4fFSgoTmcHIY7VRoBR53H4b7s2XyZzan?=
 =?us-ascii?Q?98kifiXSFMYsRNckY/IqQWMaDOjyVxPSN5QHoW8VjJTZCileREAS8N8IxfIx?=
 =?us-ascii?Q?PR7u2QAik+/VugNpjsvoYGr6TQJ979/6VOd6SJMDI0+3ESMhDa0WuJkdk20I?=
 =?us-ascii?Q?98Vtx0OefaSR983Lqz1CQ+rkd9rPX/4K8B5CFfo7XRCBCiNlwfqR1ABhqzdh?=
 =?us-ascii?Q?9pjWc9/mbwqFnJ8LG4FfV4m1g4CAw3Ob6aNfVGqhxcZqiVs55hkxl1n1hqhV?=
 =?us-ascii?Q?t7Daddf66PSUM7Xc5E+Mq1W4m6brKX9uRfdph+2CV5a3Uk8R4nE5Pye7WM1e?=
 =?us-ascii?Q?gwMzEEhEDvJPnrN/5/gSjtmLgaJdsa9iTtFCda+vcyQ3WJynZ72XtJdAZPEd?=
 =?us-ascii?Q?dYUVBQNXkg63TNvTloOYfraMrtOT4rwq0tEAxqlJDxvTHJWR9Amp30DCpnqu?=
 =?us-ascii?Q?/SPicGR44rCPuPcwASz1i+kj7mW4fZIslgEBn11KMuWQ6G2/k+X1v+2L7a48?=
 =?us-ascii?Q?W+ScW81NajlJlUSgaQ6p/1JYDI/I9odBtGoB8xWPkeh1vTMNUWCMVYRafZLP?=
 =?us-ascii?Q?/4fEYCqjPp1e6wS+Tr3KRF4gegPYWMHXPzAYMux8PGe/OKhPIxTfFwM95v7t?=
 =?us-ascii?Q?ZkHyRdKAWSKKVqQcEndN5DD9r0tL+/3Oc4PT+EyAg8uI5Z154l2yOLKbzqQF?=
 =?us-ascii?Q?bSWv+wj4gJbtLu10N5vb8uazZ6j/G4YMon9u8wbu57WKtKUXYKuI5bWQA9Oj?=
 =?us-ascii?Q?KLMsmCP2woyg9+1ZoXCfDu0pYpP7b+B/SnYhHt+5YRn4KrUK54N32BNLzqT8?=
 =?us-ascii?Q?YHuZnwql6W8P1D6RoL8BSnMa1kS5IbnrsaJAJSfr7IKGCp2jtct/UEX+um+T?=
 =?us-ascii?Q?HhhEp/M2Xn5QtoEtv95HpfwfrcVk/CPMbG5yGf4V/WBUqY1TXme75wRTMTIt?=
 =?us-ascii?Q?6tCMHxE1wYm+ccGvifoY2FvL7GJwcE/II3UYHsHqZEZwsMLo1Gu3kOyYDt7W?=
 =?us-ascii?Q?lv284yqmqdgQlvTxqnxT941oVarBLAMivGZB5JVx7mY+CqjoeZ+2kix5waTK?=
 =?us-ascii?Q?8JqTa0y0xErgYHZMl+jcYzzlUjUGIyzS4xJ1IZCWTT9MH5Hyx7vNWZaZG5Xk?=
 =?us-ascii?Q?JBOSArZXmq6h/AIyVgYAbi3xr+f7YPU/FgjWXCQUKZs0Kiao+Vvxj8x4mt72?=
 =?us-ascii?Q?/0foUSVHNd5SI2ygS65EPcG8xaH5/TlHQHdK3LtBqC8q/Xfun7dUTeZ9y1PW?=
 =?us-ascii?Q?6KlAMh0EAS5IDhv3Gj3WNT+9dHHDWw8Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZSdQPxaVT7nLIcyhI1RBLstYpJnpZT0D3HQW3WYb+AHIDkBC2yuL7/zbqfd?=
 =?us-ascii?Q?rPUx0jjF5+cgHlMK72+/nqeUUjX5lPg4I0KcylQAMdbPo9BR0Cx+QHxuWTfa?=
 =?us-ascii?Q?W4W8Gavalv1ioPGma9wrbn2M3YI2RbqDgO0bsCPmXEf0e5lavDapuLUukwzw?=
 =?us-ascii?Q?NXTIeDetxbGRTyKBxAW0fq8jFSdAEeBpGuDphWsPPOJjb4uv2PWtI9l+xlhU?=
 =?us-ascii?Q?exmqZgIw2OASJ5/91D1rZHbE5qd285yqI1f9hXl690TRd/fmSKo7p3vuXJPt?=
 =?us-ascii?Q?hOw7h2RCJcrd/+DFNwtTDd/v+P/LsgdK0CjvjP8hkxsOIaq+xQojQl+xaykt?=
 =?us-ascii?Q?1tGgS5HqI2hVl8GMaLnHrNyT5kSrycDVATP983EbGa4VIsH8FfxSa0423CMp?=
 =?us-ascii?Q?FQDrjMvxeaYWMmQ+e1Dw1OY6/yQtiKhmnGhQVgn1rI+S74e3fqNtmiMuPZs/?=
 =?us-ascii?Q?r5I1O7QO2WLqg+ZYAHeP8+v4LCHz9B4l2X8m5axLj72LdoTkJGGiv4sBdomh?=
 =?us-ascii?Q?LO1mtHS+ArVymNJ3L9qW6+g61RaxKoEvNedv3re4ZpB/FOjS/gvIV6vsoAAQ?=
 =?us-ascii?Q?xqMn//7MLxlCL1/9uoMnQuLq9/a8APc9jKGrKAMn62vaLahZF5Rxx2mbvIl5?=
 =?us-ascii?Q?SQMwTM/0XqtqDveGhzysCzMqdtyc4gZP4uTpYlHEbRFTP5wHZeZL6frI/mob?=
 =?us-ascii?Q?5oji5Nmh8cDT5Zbwhl5bwtmLROi+yWpT1zDVo6O7MnRElYTqFBCC0V5OjaNn?=
 =?us-ascii?Q?Vmf68SE2FfmcZ2+lkcb63Gz5Fy3wVdJpRNuqILIXVJ4qGPXR+TAUiGTVY8aX?=
 =?us-ascii?Q?eOmgK3K59eOxUkq+ZlDan/Ilk6C67JT4QEaRh9grH6s0XRRtdvibZvV2yo3H?=
 =?us-ascii?Q?3zR3OYIGekILQAaIzymvB4K1MyaalRYbDR4bmfH/Yy/PQVXs9LI9VLria2ZQ?=
 =?us-ascii?Q?bh44WsrXEqx07xiUDgRU6cEbangAA4G5fAMQh70zOEbarWq9a00byX+X9UC8?=
 =?us-ascii?Q?t2I2hP1FV157rdD6G7NXpbsjcmf36XoCu9zUVdcgyzncsIh4DXWQxEbCUFf5?=
 =?us-ascii?Q?v7YaRYMX1ZCDGG+cVQ/BUHPXp5scWpb++wLHeJ6rA7sfNCiPIvYgh8olEPAJ?=
 =?us-ascii?Q?PhSuCcJ8XNnVPhMfgYkWMqJ/OVdu866bitNZYydkIOLkncNOYZMR7/9rYNrv?=
 =?us-ascii?Q?0MDal+S5mYdJ2sHXl0pioWb+EfJNXqeRyaf4o6/MLB72IPSudQuqRE7MWtvn?=
 =?us-ascii?Q?gOGzbRaBFBDrqrIw4Gk/xOb+fx7tUWFMMOIDvj+FYGCccveb/I1bQPV7Oztu?=
 =?us-ascii?Q?U1hj26+GwIKA0ZsJApopGqdL2i7LPZfjqMsgQE+M31SMqJbmN3h0g2B9e3j2?=
 =?us-ascii?Q?uICLfcx090LSG9diQE1HFYKK0chSs8PBRHxVCXL1Idf4yLMfbwBCDSm9PA6h?=
 =?us-ascii?Q?DbKYVHjMwNARQc8JVvDGwRX4h9jcSjNGfs7tNk5ATTn5H9zXlY2IU+Yz4LBh?=
 =?us-ascii?Q?elm7HXpXMaRVB4/7JoafdqQ20jMuNmPKmnZv3edKxI7bCqdDlJvLyPNBrbS/?=
 =?us-ascii?Q?S5BA/xO8ABMJx0IdE3z+VnpHjqYlTwHlhHI9viz1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62865e59-0941-4152-bbad-08dde4c4987e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:38.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyRk0cwlWeMMU8SVF78nGNMmKDDWnIw/tJPdMaextrWQZmnU54gOc+2K25GL2xxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  34 +++++++--
 2 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 03e1f3daa7a2ef..9413f868a65bfa 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -17,6 +17,111 @@
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
+static int make_range_ul(struct pt_common *common, struct pt_range *range,
+			 unsigned long iova, unsigned long len)
+{
+	unsigned long last;
+
+	if (unlikely(len == 0))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, len - 1, &last))
+		return -EOVERFLOW;
+
+	*range = pt_make_range(common, iova, last);
+	if (sizeof(iova) > sizeof(range->va)) {
+		if (unlikely(range->va != iova || range->last_va != last))
+			return -EOVERFLOW;
+	}
+	return 0;
+}
+
+static __maybe_unused int make_range_u64(struct pt_common *common,
+					 struct pt_range *range, u64 iova,
+					 u64 len)
+{
+	if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
+		return -EOVERFLOW;
+	return make_range_ul(common, range, iova, len);
+}
+
+/*
+ * Some APIs use unsigned long some use dma_addr_t as the type. Dispatch to the
+ * correct validation based on the type.
+ */
+#define make_range_no_check(common, range, iova, len)                   \
+	({                                                              \
+		int ret;                                                \
+		if (sizeof(iova) > sizeof(unsigned long) ||             \
+		    sizeof(len) > sizeof(unsigned long))                \
+			ret = make_range_u64(common, range, iova, len); \
+		else                                                    \
+			ret = make_range_ul(common, range, iova, len);  \
+		ret;                                                    \
+	})
+
+#define make_range(common, range, iova, len)                             \
+	({                                                               \
+		int ret = make_range_no_check(common, range, iova, len); \
+		if (!ret)                                                \
+			ret = pt_check_range(range);                     \
+		ret;                                                     \
+	})
+
+static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
+					     unsigned int level,
+					     struct pt_table_p *table,
+					     pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	pt_oaddr_t *res = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, descend_fn);
+	case PT_ENTRY_OA:
+		*res = pt_entry_oa_full(&pts);
+		return 0;
+	}
+	return -ENOENT;
+}
+PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+
+/**
+ * iova_to_phys() - Return the output address for the given IOVA
+ * @iommu_table: Table to query
+ * @iova: IO virtual address to query
+ *
+ * Determine the output address from the given IOVA. @iova may have any
+ * alignment, the returned physical will be adjusted with any sub page offset.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Return: 0 if there is no translation for the given iova.
+ */
+phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
+				    dma_addr_t iova)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_range range;
+	pt_oaddr_t res;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __iova_to_phys, &res);
+	/* PHYS_ADDR_MAX would be a better error code */
+	if (ret)
+		return 0;
+	return res;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index b51de39c03c431..1fe5106997f833 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -116,11 +116,13 @@ struct pt_iommu_cfg {
 };
 
 /* Generate the exported function signatures from iommu_pt.h */
-#define IOMMU_PROTOTYPES(fmt)                                             \
-	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
-				  const struct pt_iommu_##fmt##_cfg *cfg, \
-				  gfp_t gfp);                             \
-	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+#define IOMMU_PROTOTYPES(fmt)                                                  \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
+						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
+				  const struct pt_iommu_##fmt##_cfg *cfg,      \
+				  gfp_t gfp);                                  \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,            \
 				      struct pt_iommu_##fmt##_hw_info *info)
 #define IOMMU_FORMAT(fmt, member)       \
 	struct pt_iommu_##fmt {         \
@@ -129,6 +131,28 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
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
 
 struct pt_iommu_amdv1_cfg {
 	struct pt_iommu_cfg common;
-- 
2.43.0


