Return-Path: <linux-kselftest+bounces-44128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF1FC0FA8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFBA427E94
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7B53168EC;
	Mon, 27 Oct 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MADKo6La"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12723176EE;
	Mon, 27 Oct 2025 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586285; cv=fail; b=b9MhbKfZupofhLRSu1NBOWd82wFA+1kYX4gO0k60aiY/ShBbfYmT2OPhni1LrHu8r2IaEI8bMG7b5GJHHm70fHiwMJnp8gyrxEDkkpCJEb5HqMJi5E66m58gyNSDXhaQFhBaNy4EYTfHr7ez8AevA2clTz3mBvpA7ubeE+lsUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586285; c=relaxed/simple;
	bh=a5UiGOn+Qdv/F3JYms48jikpaYEzDjh90WsrVjdowbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l26GZOHPU7W4JFvgUuTZCulu3m93MBy+m9S4NtiRWiGKy8Z3t6TYcVFa4bwBQO3Ii2fc0Tx1OXIsf17JJViM1OA6sj+TLbYFVY3uOhdc2iX/K9tE144l33wi6z53LwJ3XecOQYYCtBxYykLQVjAms8HEw/wGuk5634SneYilb1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MADKo6La; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPY5O/4VEYtARwfUl0TAP+MnkTGyHiV03EkdiY3PnysP09/dBJfMgrcQPDKmYXsStANvx0ps1Zg0af51/3rgWGotf5Ck274cBQ2tdhyEWyRvoSKhZAXkf78J3w11LSmhwuOLn35cZRR3te/U8LYEK/Nx/hhDob6ta8E2WS1lWI0rrEo5Y8E8r5hTeXHq5lfiwsi0cOKBzOdlZiq8OZQOYIdrGNFQHJrtfqcHkvv7Hz9bJf97Y674lAxgUrws2w0fVqgfOfKxUWTFgLCigZYG5moeeQoUC/9tI5JZCGnmN2PDgM8qwaqvZO2Z9pxIzYV54kRVBdkH7A7MgKBCymhqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/DANawnybbft9tI320iSKoDIEisqNqNgp2Wb21wyEE=;
 b=GUDC7RzBBsJprmCmi/NWxFhnKs+CKWI8IDNHV+g9KWI4UfNjR57NTW/MxFq0RVytzleXjc1GADFDPwv7gkqV58BEA+nuoYrdf1BkhbOphrk20GXGjRnU84ipP0qxy/dV3EccvrZpo3gIbbX0ItXcw3y6YDSKC4I0NSJ6Fm+baZ5WB2u47lhcTDtLUy3kAoEQAoy3gxVlowtEeaKmlpuIS7lMM0qPwzrXpqDFkaV24IMTBTxNPmsv4fHYNW65J+A2Dn5CxN0yoT/yVkEF1nVhq/WnGJJCgHI78aNVW2BFqT0h1outyrkqI23bLItBKTI/7DpcEQMrh7gXEX8L4RDRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/DANawnybbft9tI320iSKoDIEisqNqNgp2Wb21wyEE=;
 b=MADKo6LaVjxLScYBJAMaygkwlREzwdocndpFmEt0/t5kAXBGC8i4RAWIq6nr1K2KIeIviPIFtYFLnTD0m2HSBWY7x4zgLdcC7GgvpHGL0fJ6StJr6aC7l0WaIx/3HsszaqjJfppvvAA0UCC91WzwNdEdUxg74JeDs80YwwA50QrvC/AsZ8Hnmc/xXl0RptnVxYSXDEWSrD8rPLG0iyHSQIrJFvtxU6CkwbqTKAhuq95uWiQqxZunIDUBVL7/Jfr8toPX30j0u5PMPyGr8xw7mq7kGqzLO9XI8T0FOCxa9QW0NfI/ief3zkYgfCtXSy4G5+Meq2T1vjXnpnOoxM5uzg==
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
Subject: [PATCH 8/8] iommufd/selftest: Add some tests for the dmabuf flow
Date: Mon, 27 Oct 2025 14:31:07 -0300
Message-ID: <8-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:208:52f::10) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fd1b5a-d0b5-4603-06da-08de157e9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NxkQJBB76I/LadY9u5V458rq82CHMLeKyRodRGTM8fnRVoPpdih5B8Wth8Ni?=
 =?us-ascii?Q?Svp5BYcbfi7L4zLkD5t0VMr7I8WweYyftE7DN9DaDubvsd1mw5qu890i+VpB?=
 =?us-ascii?Q?sGD77CTKMGncobpnx21fGqthlEtFx6heJncIFcQwnn3E+lIDJ+Dk++JE6gJj?=
 =?us-ascii?Q?5VjUfUisITAgp/JO2sgRXdSBzVPfCedbO9LK0m+UL6kFl38F8b9oVAz5IXJp?=
 =?us-ascii?Q?ykRMU1jUu12JfYXByESeLX4yKaekEWyX9eNiAudhRNuaQkvehYx00ZpZd5ta?=
 =?us-ascii?Q?UWXnbn4AyRPG9/QUVXd/nTTd9oQDLdozF5glIHAOOl70pKDj3t5MsqdtgdH+?=
 =?us-ascii?Q?d7bhRYhgsqOXojb+zN0SOLC3EsxCjWrZ38WJVMvjz1IIv5rjZjh4fpV9UDwD?=
 =?us-ascii?Q?qlFeFfY8Ta0J9wUhwc+kEgYM+jychCkp3vZOpt26ohEqy0GmLshUwJ67wLQm?=
 =?us-ascii?Q?GaUh4VxDBWltzvFsla0KdjAYGKRdioA1bU72eH6IQGJPqApbjrnfTHruI7/X?=
 =?us-ascii?Q?GcvlpoX0rnmnMc00ZyJAxb4ogJjQYmwZPERyJoIj2Cz/awWhXdMgRhZENpxE?=
 =?us-ascii?Q?eitcPFZR+8ti8pfF+rircqRAaQRYkihlt45ug0OlsujUk6LqM4GXIvisXP28?=
 =?us-ascii?Q?wC+0Q1q9toPypC74/1hPwgcqsXbAkZfWgbMkSGaof0d/T/hI3RCUNv30PpL5?=
 =?us-ascii?Q?JdsCosEcykQ26cdbaE2rrF8K2MXWpwFAK1j1lqhD6M5/HU05n05hC6094lm3?=
 =?us-ascii?Q?bf64alZcNKwf7gJA2EkpbwrGmkueOETjrQX50kHof3Y0YmBsUvBL4GZRhz04?=
 =?us-ascii?Q?/+IeyWcVwnb3QeMlEEZq7rmHL2HxsCdxBznhDd9G6SmqqpA5MwTdYL3w6n8N?=
 =?us-ascii?Q?97PpkjtEDwPU9UocWoPf8U6Jp1hen95o+1xP9wBF0FbCiUFSJx3I/jhu7gQi?=
 =?us-ascii?Q?3EQYhdwyTe6g87nl42y84EK6/eGj4vtHaC6+eCqnLTAQjM+wid6NfUJJAej7?=
 =?us-ascii?Q?wKrE39i73eQen1dovvTUzpMILSzbuGsEEKYPXuvzfg9AYfWy0GQsgXofQEmR?=
 =?us-ascii?Q?nzYrBk7H7TCjTKUtfUSOnRDCWCwWRLHJsQvLemXiE9/Z2fnYKYsj5E6mhX+H?=
 =?us-ascii?Q?ozGVpvlnnwLbfmDiBmCWi5hAfNM5zn8rAYDnFjrmbacd6yrXSkqv7RfmLa7l?=
 =?us-ascii?Q?lN3VAm5ZsLe9LdbGwj0jSP4OmjF/z+3PW7d4G9FTkCEdxFoYG+EptB5EuXVO?=
 =?us-ascii?Q?yJ6V8xQqGSIWZca1cCjJaMp8dQNBdVa1Me62s9xfiAzqc7mJ8ZBcwvI/dPFM?=
 =?us-ascii?Q?Y62hnLu0hq7/EpEc/8tKd1sWYqX2y9vYRDnCKBGZRa06rDFUw5cPwGcZ8fif?=
 =?us-ascii?Q?/aChONmqm6Xe9m/dBsNLs4XU214k7AVPBiSwG16ckeU41nVebU1BwhywL/sA?=
 =?us-ascii?Q?vrKKLyTTgZa30YRu2+lSaxcrk4qh4uZdjRKcytgnY6pFUfZY9k467TrIrfi8?=
 =?us-ascii?Q?Kd9QvGixUU3LRJk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeAJCf0AuMwvYm9RkbBwYVB1DxhSbyhRz1LbAgK4JbFjThr7N43mnVTWH/hl?=
 =?us-ascii?Q?DMvKojl7p9jFtj8QllLD5VXVl7MJMI2e8wCEndNi0uvhvt93nmmuD0ubXNRu?=
 =?us-ascii?Q?E81g2QiSsKX6zRQpJUTDpxBO2flelJ3QkBPgp4DRc33FRzISdhluh0GiLRQz?=
 =?us-ascii?Q?NX68cFfZx6SDwWz1lXy5MolFTT1lrIqMhNhPPZm7DXfBTKcM1NaHf7DYbVrO?=
 =?us-ascii?Q?f1eX3SrpxS5IaquUjE/JV3awdGnylwAsaR8xWZhsAu+PWK0QAFXVHqbtt4kS?=
 =?us-ascii?Q?dVFXpp9/WHa8hqNNJCuooxo2QDB2AaW4f9Zlqm7F9BAnYWw+V8EV0hlTlOCM?=
 =?us-ascii?Q?K/401q8KGpxQjW19GpzI35aUFY9HGwZzt+NRpBpt1M2oUVagRxKKGgMw7ij/?=
 =?us-ascii?Q?5iuHWZ4XbwLvZTkubgL/gL8ilaLHCIHd3Q50OWHMrlgWnZEcUia6nGG7Rtx6?=
 =?us-ascii?Q?kku/IY28CYd2IEpnhebE+Qq81uQuhEv2RC2TggmWInINv8EUI9KlKVvjiPbU?=
 =?us-ascii?Q?yLmiLO4vNicdbB4zyEJCr2qbEM4WC/GofnxbXDa5an8yb20QS22UtOVJN7S5?=
 =?us-ascii?Q?fN7XAaWILO7eDblozYb2gbm6AWGYYnbo7UNGF70xrQIn1UuwS0ZIsFYaz4kS?=
 =?us-ascii?Q?RQrtL7ZcLeEjzzpJ6dLBUFrfplolIbzfBbWejN2UNOHLhG7tLerG3nAGFbl9?=
 =?us-ascii?Q?xV5o9gxcC/b6FD8EnupGZ3xzFzIxTR49qlq+XFO/hcSEIh7LI0t9Yg0RvBXz?=
 =?us-ascii?Q?g3UWrrFHLA7pQn8rH8YP/vhNMO585EgZobP3S6Yl8gqKvfKjqspD6EKZKhnn?=
 =?us-ascii?Q?IK2C4Ua51Ji1zyE6cN/VIG07ONCm5+k10sCzp6i6d0DELgJGEHCMfPTg5JoT?=
 =?us-ascii?Q?Ysloohy/T7EXUyfY9btLSExNa7dbVf8DeGGc+ph76rkTWVPrB0yId16Ctog5?=
 =?us-ascii?Q?dmtX3MGPjCAUbCrFlbQlaLVcq1GVzgUWdzFjw9GoKeJnh52qUNvV1eXNofT3?=
 =?us-ascii?Q?bf0sE9/plWU+c7WE+NsHuIlgwcwLjwkK/PlzMIKNVfHyjh8CP3oeiGk61WHt?=
 =?us-ascii?Q?M/XR6uhFG1hNxj1eLUoxsjU+KfOkcZAGF+YBH1PV8rYWXEdLPwNin+6jZzA5?=
 =?us-ascii?Q?+YUJxm6Xigh6uofYTu+O34QSb3anUno1a9gqubxWe08cyMaWU0vVH07/4sQO?=
 =?us-ascii?Q?YRWGCUcl//wQzQEkmyG1/nkUhIVMRSkxh9WWNKOEIIdkVi8DfWOXxcI2mr++?=
 =?us-ascii?Q?F6hWPt7dgZUJIVFKy9u7V/bDj9+1dFX5H3GBvb4JjpTy5larGvoozt9a2ihB?=
 =?us-ascii?Q?0Eb62QQ7Ez7fkA+3sb5IX/KvbyqaV3NDNv9+HArLTtBCMRCXHgpyVTy5ejSa?=
 =?us-ascii?Q?tELBBoppfFcdu3me/Kut8lnFj4tW0UFzlCfnt+OkhlCKDvscR8AmpOzbAdcZ?=
 =?us-ascii?Q?iWpiLk80KB91oJecj2lMG9KWrKbnhhT5kJxMe8+OwS8U/ai4pv7cvO8oZmFD?=
 =?us-ascii?Q?g07D05wWKwgv8HKoc859ZkAu1Pwb6ZhyVkBpcUTeZHOgbA5eUNmagSWwf/Q2?=
 =?us-ascii?Q?rg7+VSYAS6mpSlPKN+k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd1b5a-d0b5-4603-06da-08de157e9e79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:10.9332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eipHTFsfcBPVq36OnUknyyxcRXLJOxk8x6H1TpdjLWUfF6Y2HlrlqOe6HJgLS48f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Basic tests of establishing a dmabuf and revoking it. The selftest kernel
side provides a basic small dmabuf for this testing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h       |   9 ++
 drivers/iommu/iommufd/iommufd_test.h          |  10 ++
 drivers/iommu/iommufd/pages.c                 |   4 +
 drivers/iommu/iommufd/selftest.c              | 142 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       |  43 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  44 ++++++
 6 files changed, 252 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a2786fee7603f5..d6fddd6054ccfa 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -19,6 +19,7 @@ struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
 struct iommufd_device;
+struct dma_buf_attachment;
 
 struct iommufd_sw_msi_map {
 	struct list_head sw_msi_item;
@@ -713,6 +714,8 @@ bool iommufd_should_fail(void);
 int __init iommufd_test_init(void);
 void iommufd_test_exit(void);
 bool iommufd_selftest_is_mock_dev(struct device *dev);
+int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				     struct phys_vec *phys);
 #else
 static inline void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 						 unsigned int ioas_id,
@@ -734,5 +737,11 @@ static inline bool iommufd_selftest_is_mock_dev(struct device *dev)
 {
 	return false;
 }
+static inline int
+iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct phys_vec *phys)
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
index 524cd64df8ebab..ea9671b5385fff 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1464,6 +1464,10 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
 	int rc;
 
+	rc = iommufd_test_dma_buf_iommufd_map(attachment, phys);
+	if (rc != -EOPNOTSUPP)
+		return rc;
+
 	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index de178827a078a9..5da12635a8ba27 100644
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
@@ -2031,6 +2033,139 @@ void iommufd_selftest_destroy(struct iommufd_object *obj)
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
+				 struct phys_vec *phys)
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
@@ -2109,6 +2244,13 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
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


