Return-Path: <linux-kselftest+bounces-42833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF840BC20DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0DB83C429B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B22E6CD8;
	Tue,  7 Oct 2025 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b1iXjPOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2842E7179;
	Tue,  7 Oct 2025 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853541; cv=fail; b=nZzQX66BPdHyjgXNe1ut3JRELJiu+HLDb3jU5x7kFzwapHmPW06XfoFwhCJ92DjsqEKMwbicmH39ms5EUjT907WEUfcqtNVamTpRHPp7H8PspeuLk1JiSrUGSAHRLQ+2zyJ4hh+x3M7fNtnrGnhiwpSr3R5QESEA1eOaMknLPQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853541; c=relaxed/simple;
	bh=pnayLsWD0EetG5+R62EKNGU3i6OMUTff7CN3z3S3jmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6QQYL0kHwJ7Okex/buiSmmRnsXOFW8sikAi+HXnx1qkelVr4Segiw2AsoH2ZIjagglWg6GUqO7WRjJm+ehhIMb1/aRblUGrUb7o9QrlOzVdMPo4FKZ+bCwBYgn0w6L+5vrz79VKp6XQEzIJRL2A5L8Y6vMR9W0FJQccl7UMfDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b1iXjPOv; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK61kScACN/bCFOSPTdbEptKVua4g45zN5a/eFW089OMlS4Fs8BxL4N4DXHGM3YNzIv0n/yZOUnZgn7+2Ie8ur4KazX+rUeMaCdgiHi/ymCtOfQjJBcElUG+ybkQLR0r1llAuJRWrduiuBbSrvelYGDnFV/Q+K0p0c57GuPAeMaWbZ8/d9fPj78cI3ruQ60Z2S1Te4yIel+T4IG7kokj4gFDTU3OpQ+S/Zc3xWQ5BkAXfHzUs8yWyTpYo/mafXM+nX8PiHMytkua6QwN2MTKAfRirncOGH9xzRjC2bTXGfuJHBvnQXIEsPNHe0UJZvMMR2pTpb2/m+d4opYLUM6IMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFDuc74MVknN44uX7vo3y8KFNJDlc7WqUl2Ezs7OHDs=;
 b=Wfl/Z0g/C4wP+r/M1YvjJys0pn2I01RswozeHxlELXYO1XVpU307ukOj+aS6++08gSmpbrb9Lz+Gwb+iHJvHsU30UbI+kpfKhF8F8+VIhwz+JY2qUC3zJ5jT+I629snzf0R6uemht6Tzu/roadhDR2STUzR6fTaqygC2lvMQX/IC4yjb/Z1MPDV2gapQljhfVkTzo1a7js6cY9UX8VqizvNkaCby8f1lkD5F16+idDfJHdz/1C1N68X+nmhUQY9B0Bgy1U8wcW/mHArb/HPyM2AszN2g2Rfvq/jTF7ctRu1IGL4wnwgNax84UIm0irOhCI7kR2+hpYb8XV/o/VZUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFDuc74MVknN44uX7vo3y8KFNJDlc7WqUl2Ezs7OHDs=;
 b=b1iXjPOvAzAjK2qN2HjIgzewx31fblc5In+wSIQHER0+W3TEvsOF5g5q6+WCd83imrFWDagVqMN/wZ+HEAeOHvKi7RUrIYUTTqZSWEyJvLRcbpbTEe1eKtLUSAtNdAcKU4Y9AcnJSfxlgArAzPiVKmSqTr/RWU6p82qtAyqegm8a3/2WsYv70pop1ewqtP7eYV/114M0L1wB4BdhKG/zGg/pBIiC1DUdTKOD281gc22XghgHEaF2A0SIghxn8RYUeBOIRFxacULEZpWKUGtEBkwp/II0O4UBs88FcKonshHL8ITg2dbl1G24fAzRLxVfkUzJ3ctR8DpxWoOh2RiNgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:05 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:05 +0000
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
Subject: [PATCH v6 05/15] iommupt: Add iova_to_phys op
Date: Tue,  7 Oct 2025 13:11:50 -0300
Message-ID: <5-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: bb096eed-4017-4e54-77a4-08de05bc406a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqGFktiX1LbRo9yAEYTfw9+uFSep/EQ47br45z4alX9VhXb7QhAnqNWi3TtD?=
 =?us-ascii?Q?aZAHB1KLP/q069ab1va1Rdb1HlPKI9GIztVF7i9CGRVn5QYERD46O9T/3phd?=
 =?us-ascii?Q?BiuTEHlZfCnCnUrPdHViqAMw9kHR/z0E9jxWEiWu8v/L0cmvWbDNPdxk2SpJ?=
 =?us-ascii?Q?T9tmv0D/WiG++NnUF2MQ4KSzUU5Yb0+2u1NYxenPMWdHyMsK3H7q+A+KVZUz?=
 =?us-ascii?Q?GjKKiw0bdBWGfOqj/Yh/i8flwZlyOIg+10bUk6UNERU7XF9It7eq+1CC6WGC?=
 =?us-ascii?Q?u6OUmpCe3omkx92N2Lux480qrnKdQQulfcDUU7MvqlAs6W2TVbLkFLUqSJ7X?=
 =?us-ascii?Q?xFo3UWrSPWp6cUBVGTqBbpKl6ltjC1rDqKGdgIO49lSc1K6At0wLGGsoIay+?=
 =?us-ascii?Q?pXZg5R+84QHNQ5d/89uyLbjKIW80h2N+nyvv9JiLq4CjGfDxy8uDv0/EbIdm?=
 =?us-ascii?Q?uUtTs4hEwbvkCw4OM9lTmAFlavL03dHd7kKFIBtluHtT4LK+qQtfgt4WJCgT?=
 =?us-ascii?Q?FHrcQq8e1jGkwbzeGjz+5OQrsClylir1Qs/oGTwFqWmSCFTprR+squ8Ppwoz?=
 =?us-ascii?Q?GVim6SqHEZQNRMZLcREAeoL5AJiit99ui5IPa7xohunZrTVdChn5eRZOnHs0?=
 =?us-ascii?Q?uSLNOzMBZiAhvLTbhAip1hxsJNaXKYVN6neC2eJ2ZqeJvcKVla32U2dcc4Xz?=
 =?us-ascii?Q?6z7XSPLvyDP3epzRYE/78qo4laZ4HLMuXjqiqQcTqkEGFK2mirYXxT2xr0XZ?=
 =?us-ascii?Q?GBa9vkWJ0VUyDqx7wmna4w/NOEw585j0xxv7bvFhg26mUjZX3He2tF0RNM1d?=
 =?us-ascii?Q?GUnjHJ8vpQu8/zR+y0FWA/AvXtPlBRW8UPQgnIKOh56CilXO8qOEQfh65TIu?=
 =?us-ascii?Q?SkZVHZoTL+Pdmwfplaz6Jxt8anrLk+7j+aKErzVnVTmIT/hJqXqYlZvLW2U7?=
 =?us-ascii?Q?IbTKPD3q1nvj0Fz9oNG9eTBd/L3it5uTMk6+Qcuju4Ybou2TYOqblqpQ9Vj0?=
 =?us-ascii?Q?GFjmbq2H47AHrVLWZlMWffh4P7tCi1cs9k8gPhVVdpmTbpXnSalEGXdlJSfA?=
 =?us-ascii?Q?VHgDmINTq3h8WR/WSHh9oIgUMfZ6jAMsrzVqEeGYxCGy9NMMo/TE0xrKmvXc?=
 =?us-ascii?Q?hKEfAapeYco/b08IHPc909nEYrnGJnrl/6p/Rw3pCWFO2lJKVhZiqPKiB76T?=
 =?us-ascii?Q?+q6ixR0VyZfSsywi9BkY7uY0mZPeFL3CgzeJGC5mAWSD2zSfc0fTeXYUiku3?=
 =?us-ascii?Q?trGaKqXvv8TDkRZW/VqQZTaukvKSJeRxGUrAHOY3eVxPNC9so8dudX+xSxfw?=
 =?us-ascii?Q?DtQlNbACrgdaKEwZvbIjAOgDETSE22O5lPq9+QQ+OxQSafvnb6qeWACM/n8h?=
 =?us-ascii?Q?m8H4LYKwdCVjRQf+qxxdWOYYoUNIna/d+D22VHze7n1Ji6d8EpEhpiO8r2nZ?=
 =?us-ascii?Q?j2efq6gEDDFtUaRDN2/aV/iG0NoJPQ5Wrz2ZmBhXvJno7hzOqBp/preV2UvF?=
 =?us-ascii?Q?3oSDQoEi8fScGmk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HkZrWrIiVfdXd6V6KN/hSvkqnGmChO6TpBRA0BJJ4b2tfIXghQlrJr1142G?=
 =?us-ascii?Q?ya4+edYch1DmrZrdsKK0ULSZy5roUVbxqFcBlDJnyITjrA051HQdodP0dgmZ?=
 =?us-ascii?Q?U1aCfQmRU9BkLvenwgU8Wsy2T7Wqsj7CWN/BHmhcOSfLsPHUEF69rv1JjJpb?=
 =?us-ascii?Q?f7C6EJdNFEf+tBy23C6q2PUxqCKkT+e5PIsMI5/1r1AqfYrI16bdK0HfDiuV?=
 =?us-ascii?Q?SUddflyolX5Ri2vzcQsaXm7igaMBSeMEcgOmDP3uQgOtVJc0dJLKPQD3PTzB?=
 =?us-ascii?Q?n1/SwyqoykBblIO2roFi48VsETnz5+OFMT/rW1GuR5LtDp2riSYCkAYxo8TU?=
 =?us-ascii?Q?10ZXTZYZQAcxfEwXv4t7gwiFvrDa0Sk+NEg68JtW2iCmnfIeXl/CsGLEKh6Z?=
 =?us-ascii?Q?nSufboGQ/fAMNNHrAxHas8b6QGq7KVsaix1QsqXw8OQMIwdVK67IyODu2IKw?=
 =?us-ascii?Q?WZWsQfcP8iDrbWH6h6TrwmAzXr8gUC9wIXcXQSE+6Uj0ZFgKPh0d3cDotUyV?=
 =?us-ascii?Q?PF1QHaO2T+OeCO9oG6N/U067LnjJ8fk9ge4e3VfGMtFHPJjJMXeW9+u75jfY?=
 =?us-ascii?Q?dQLV/RnLREPNe7/a77MrLP5mUEVT6r13TtXEVLw4ooZihf3GXjYolPFbgJIV?=
 =?us-ascii?Q?ONe87+fzPnsOKZbrQikwu2sVsPkFGGxwa4FBigN6Kk3jbJxW4CBpSZcDMxfs?=
 =?us-ascii?Q?I81YajmzVXn9HwOMhUTt7tnq6my75wHIuvz8GD/l1ZLqgXSAHAqxOUttJauH?=
 =?us-ascii?Q?GZwlHlsq3wOc1KeYr7j5AO/Ow9NjxfzVP/LVcxNEvjljVpt7cRXkNW0t5mqT?=
 =?us-ascii?Q?0Z3pEkNb436GJtBMo87xHjF/TKPvAQUznT6/VLMTLxLmzACazjrdY6snl0lv?=
 =?us-ascii?Q?LanT4Ohbc9BlI4wPuBHGTpW18CjZ7Ae6Z8n7s4lniMzasSsORB0k5sveEdXK?=
 =?us-ascii?Q?SrQznw1A4Df5My4sOnWtvlJlwvX3DkSMnH0sHMYAzr3FNdX3YrjCewjcvD3E?=
 =?us-ascii?Q?aVOeQi0Bd/vN9HClUAhe4ituLIF3j4azcPqtk5nsul05YxHlmWBRIKpFthoX?=
 =?us-ascii?Q?wGnym54QtttxpO1V53E3vcn5UeZRsPrVLSqEWrfPY75wvC1v3RRRv2KWEhHs?=
 =?us-ascii?Q?7o8ywjq/+LT2lg4odWOYxygWZvUsN2NdeQXKhctU/tYq/J1UQlmxiLykmnLO?=
 =?us-ascii?Q?f85XZmH2Mfy1f2AoWNaHpNV9DvyoSIA/oYIoyfqs9YTYGeKk3HXLTNcKvT0y?=
 =?us-ascii?Q?UfyriHHIu/007BFKKMxir8DYTM4GRHifKGbOKcLuu0DFflt+g+Eh4sqZzy2Y?=
 =?us-ascii?Q?BNYaL0ted6OD1d/gnj7Y5YHR8ecor9DpxsVd7/jzYijmc2gW9jJqhMkYxY9K?=
 =?us-ascii?Q?yfFshJhs2hvApIleIZndxwoU7rZV2WYPqu7VhEuOJTv+MNHdhTZasS9HkGGg?=
 =?us-ascii?Q?LI04lFqpK2gX9kY0PamAPi+djeadNQgk6No+ieoiGYIIQgo3QSv9VPku3bcN?=
 =?us-ascii?Q?YwfWkvac1DDVni1ev6NEi4ofsyOGYGB/lwbJELseVH7EPmffpsF2wZRwXMTY?=
 =?us-ascii?Q?CEnmgdxaHEPpjsApAVE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb096eed-4017-4e54-77a4-08de05bc406a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:03.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8nZL+jr8YY/btJssPf9oNHPW5rD0BMMW6ZR6QzbAOQQIY0oSCOqgfRLfeTV49P5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  19 +++--
 2 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 564f2d3a6e11e1..5ff1b887928a46 100644
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
+ * Some APIs use unsigned long, while othersuse dma_addr_t as the type. Dispatch
+ * to the correct validation based on the type.
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
+		*res = pt_entry_oa_exact(&pts);
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
 };
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dc731fe003d153..5622856e199881 100644
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
@@ -129,6 +131,13 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+
 /*
  * The driver should setup its domain struct like
  *	union {
-- 
2.43.0


