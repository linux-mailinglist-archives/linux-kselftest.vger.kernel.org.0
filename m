Return-Path: <linux-kselftest+bounces-44129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C7C0FA8F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F23427CED
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C631691A;
	Mon, 27 Oct 2025 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWLp4ho3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523C3161BC;
	Mon, 27 Oct 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586288; cv=fail; b=Krgt1bXvi4t1ncqEpxIg5WBxikVYKIPAtRYt3gH8bOCxP6qsWfZaBXAuV3e5Q9yMENX9rxnzafTwsZ0qQYue7pVeX3T3zuhGFbkkb7/o+KZ6vI/KIpuqXeI5aq0rVvqMQrYFw4ttFZC2Ff26etVBwXI58gDtU4NO1DE3QkV3vCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586288; c=relaxed/simple;
	bh=+PwpJ2URa/lAIO+i8o+BJJ30VotliEv0Azm4QnXKdR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3DEbPAJkTVD9JBPqXWP/5F7DQjb1GT+zVJax4BZAsWUkaQpyX3qvTbUSRAglykf+QCAN/vQ80bP5rZ1v5ODgP9pSsGmFoNmfhs6b7xD+yrdKcj0zyFkS0hU2sFJigUaADDrLQqSqpQdVUIGakNURQoZbt9H/JUtnuJeDpyPzE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWLp4ho3; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YGFjq+8OUB7nH73b+QafZkFDNKaItC4N3cKLJ9gZex2Q86MZ/g7kl8jIDzwDs44EvnOwtu0xj4jYAH/sShaPznWcMBAZiKRgfOSR7XozL828K9J3uy/yEN4A9WlStt/jGsYvYIf3sAycqMFw2WmbZQamfzwwb6rI9t+llkTfqO7xWIEdRPufTPhJiMdTUTVfrO9ocZc0j6ftJs0WpRG8cJ0oUlInFlHZ1rObAosPcYwcM4/DZCLYaiXxXKxel4JO0SK23Je7031B8ldqdGu/m/Y45pIlkjZi3b/hcbO8bSSHTG4D9x+L3ZK6keITvuRbfVUiJg8aRzJCu4WZFUlVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgkgZgmOuAD5zZ7ynn13skUb2IMTG2JpnrHPG9QQvu8=;
 b=uSaYiOl0nOXxokkHqx1/12LbV0RGvkShndiRHalGPvIhhOl3yL153uylEkodTW31DjEKp1ZQ3IFB+Wnt25sCt7FmmN/A6YtmEa95cvUO5++meq2NVKEPh8umzIjwVYdUYHGqYmRg3mYwgHR2O1FldP/VIAca0OMqthPqa39Nu57NgNHPRvOU/cwXhG5yRHqnROP0kgJtI4nMqYTNChaITyrEI34fL9EDsMpR4eog6Rih4ux/eV9AeuCIqoSmK8rEo3B2+jkadj1Jzsn6TJY7doFT6AW0YfNyWw6Hp46qEN/N4gznjMsXpfsbyuZNbFvumZm3OHsgKGvT15ev0Fw2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgkgZgmOuAD5zZ7ynn13skUb2IMTG2JpnrHPG9QQvu8=;
 b=CWLp4ho37eWZtFLA+SdR4r7vF0MDkASu04IERT7FqGtxZtHE9RbcMOWmTV+G4b+oJabVH8MatHOGotS6YzxnRNxjDm7Q6R3BOdWrSTfhbus2ZDk2hA6TgQq5dkZVTDJSqWStNtX67D/UvKeZA75o6wLA8GoExvhG5ISYCJ17uqa0HPoOsSOReZorkjymcDWYBtBD/v+54syFogtJmHjcLi/FoHIodPZP8H9/4BRwlZ7aiCnN/7EkFjVPmvCfngOg+1RvWSFN7Mj+X0lOhs6YDMM6QrVJZOUrFALx2EvZPQm3LgoZh/GBk1oEBnv9jAU16zUX702xkSQHES6/6cIwjA==
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
Subject: [PATCH 1/8] iommufd: Add DMABUF to iopt_pages
Date: Mon, 27 Oct 2025 14:31:00 -0300
Message-ID: <1-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 773ce2d4-e951-4a33-1df1-08de157e9e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B0jzeY9H+cjsx/YBGKZuCk4Gol39VIGhCoomm7Q2vv6SBrKoIpwewGLyR2Tn?=
 =?us-ascii?Q?NHRgog3/uy86wyBs2lAknoi0ncjIrqXvbLpET0VgWJYp41EB/QC2XRcfEgan?=
 =?us-ascii?Q?Zqt+/0JnQc+stlCTlwGA6EBYNy+mAzBi9pHyVfvrvVm5Ncfdw553hVXIkSxU?=
 =?us-ascii?Q?eGCFqJE+fgxGe6d0sQqJPR30I7o/q7iM3f9MAgN6HXYtmGgqdbYjYtYB9HUw?=
 =?us-ascii?Q?FWwjd/etzRhRqLCc3qHc+R0mr9EQ6wbX05WwvxhvEWioX6eKtAiXuB85/GQ2?=
 =?us-ascii?Q?twraZ9Eel3QwBns14Ar18WEv3X8QhCeftcQf1kvU+11ctwEztSGaTv3AkkLX?=
 =?us-ascii?Q?xPsRJHda08mxNHFDEb+J8MEm4/QZFjuMBlyrzYTIYGVrTl0qOyP/eQby0yeZ?=
 =?us-ascii?Q?TL9ALVoh6Ie3aG+3NpUouKLPjVBf9eNO3H3ODS+MsTyPOCWImAIi0mQhE821?=
 =?us-ascii?Q?Bnjs46zHHy2NV9uGTtymhDvfwAhvtOx9hDq2j+1XdMELN4f89ZmhvtqRc8YU?=
 =?us-ascii?Q?yx/OqOeVgN9QE+Elg5jZPZmN5K8KTA4BOTdjwPwUudxK4pmLUp7feBK4qkd3?=
 =?us-ascii?Q?6PeGQn1dsmXl8DZ1kgBZwrUucTClO63v/uoz96vOOvGeGsdBLPL8SD4D/qcZ?=
 =?us-ascii?Q?gz/29TFW8wvvrZLz/CQrMIL94Mju5q2tLjUkvgfK7lf7jC7wCux3BrxjN6Rw?=
 =?us-ascii?Q?0Y4+XLaG8ytajC9xsJ6NOQwmLQ2MaDk1n5mKqA3pgh+TRlj3vRmBwEkNHPGu?=
 =?us-ascii?Q?YgaZLHN2HKhaRHj5Ewq9HlGPY5YcHp7H1bEoTToT24QsdedXP5Vafs+fWBJi?=
 =?us-ascii?Q?Uw9DyNuCSkqF0hjQL+rGmFurqRMPaE5Ol6VZMvgp80xqfcQO+/xANbepzeVM?=
 =?us-ascii?Q?PgxlH7wfG9uEZCzS/wnqV6pw2ZhszOWU/HbQRDNUxFviTGoXFgQtkFNLB+BP?=
 =?us-ascii?Q?ixXJGlPtjcqdTtcd1fDbh1qMNJ0JRuvwCcGDeS3LWn0nR7Jad6gJc8cwLoHE?=
 =?us-ascii?Q?QNnPKjhJVGkJGfmBBAC/kVM6HKQ0Pr6n4dIGl9zzP8ZZSBv+fy1XWzs1qQqi?=
 =?us-ascii?Q?OiAbIRt53164J2hosDeGoFdXiNxZEPYePCl//sBPbNJn3zTiwEpj1W/yyKGI?=
 =?us-ascii?Q?vGnsoLf7E8NGp5zdpHlUd6ksvk+t+GPiyRSR9byMcBEqaKaH1dd4yQQzbCjF?=
 =?us-ascii?Q?5ofKynaqT5XoDao8Nx/+ZICpwuTOY2Y0/SRhCxZhyPr+3b4HxoAid4mGpdJ/?=
 =?us-ascii?Q?on86ds7XNMdkAe/dc4PhXg+JqwoRMDFBS/pOBb7Rqp2dTTwloBcGKHJkFlpg?=
 =?us-ascii?Q?ERERK73dd1EdIh/h1RVuhjvX4HsGJw8O4JvynfoJmVIBs4VBIjvZhUjmMCY+?=
 =?us-ascii?Q?q60DPAtLnhm/bJFGZdHHMGuwQQtODy0AZB/t6PtX3cqEg8x1Xr+M1EUxx5tg?=
 =?us-ascii?Q?EkL++Ma0jDL0C5uQpzMc1dInp0olx3RrGYByUzSnPI+y5YmpzEroo6Xt+m5J?=
 =?us-ascii?Q?1mu7AHKAuJmKf90=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxGy/QQlKPXT2Y6r7fzYoc6mXAuk2NzfbYmNmk14LLc43VDHfV8VOHNkN+IT?=
 =?us-ascii?Q?yGWn+IqISAf7JTCY9xz7Q0uk6/6Rm7KN0z4Dtp2sv3EPUSNKiav65i+kesj3?=
 =?us-ascii?Q?picSleWHilVfeVsS6wssUrWlgg2IenahaNRsOlMGH5R6Col385LUBkxyyqRe?=
 =?us-ascii?Q?lMgCwH0yqiqwMOUoPWXhRfW7OiWNuQdNzawwKC+ACViipo0AHSyO/frGU2py?=
 =?us-ascii?Q?VN98ibjOUXu9ZBgYxqa3ohx8BT54DGzEy81kqxQWsTlNYAI3zQ2ceFGi6M36?=
 =?us-ascii?Q?F8qIGsVXhW05Q1r0BwnVljdzXt0izfTpoT8+qKXRZc/8Ocv8fMPqG2ylNjY9?=
 =?us-ascii?Q?Z9/agvWcImPqit36z0JMhscWbB5VzPcA3JuIDOEXuqACp7WR9BfgyDOvPj27?=
 =?us-ascii?Q?FQku4iCUApL8SxRJSRKY810njVXOwuBRBhQOskiuXcYbLY/u6K+1QgfNiDnx?=
 =?us-ascii?Q?eg2fM6V9ePQR8yZiD3fbMoAVV2kOg6ccumzpa/4NjBUpMc4ibcpnwrbPfKJH?=
 =?us-ascii?Q?moR+Vbnot7AX8b2Zd3Y5vBBHA4cMBwd7fBGp8+6+pvyt5STyEqeoaq8y9SG0?=
 =?us-ascii?Q?4khtj2+vkYeCkHNFlfr8E5FfotK44lCaobK4AT/zw2KOyY/9g2h0/ErjG+7F?=
 =?us-ascii?Q?WUp6QJcBSPf+mB0pi4FAstCqnH3wK47YUFQWmG/1hWSv5IsMvwNroj449KjD?=
 =?us-ascii?Q?cAdaZOhQnXZ/bv0sl5trcwX3XRm+53cowKXaEeKymrjnpXkRq+N2KjEFuaJF?=
 =?us-ascii?Q?MXQ9uB37ydLIxWP9Vn9N+LoAxah3ExnIOA2edCycin8fFRxbqUXYUudX6T7N?=
 =?us-ascii?Q?Zrlx/b57F25Nm4zMmkAw/7jO3AGszZjyp38bRMkZDNPRwiS+ag8ritopI2mX?=
 =?us-ascii?Q?/tKDUJmG3Fi/7YNpPPL/AG7bCIgVoT4Ps9N1K80l0y+0UAGFznN+DoQXM7bf?=
 =?us-ascii?Q?yjVjsiRgcnTSeMjgfzZ3oc2dSilCeB++PHYC6C83FlgicBM9j1lH7Ya51MwP?=
 =?us-ascii?Q?SNRMMc4QKtu/SbMFj9QVh9kMu9YdIvJ03HOyxPLRLxkgE6ojh9Jalpw3wRZ4?=
 =?us-ascii?Q?3rFC3vjz9eVLAPER8i59A7winow1q4EwWNjf0dIAaS3GDFrIkO7TGZlIn4Gl?=
 =?us-ascii?Q?s3mz5ZiQUhdpoCbZvHXXNsY0P0GW/6dJl0Lk5NDFO5f196tcVV3vru0PARHA?=
 =?us-ascii?Q?uEgy39Bn8z3GFWM/LDo60anOG9xIm+aW5RZLxFxS/WOjCF9zWniTED8IkVqP?=
 =?us-ascii?Q?PuNErT0cQ8ZfFCLzx4bCzn0mu6QktVI9ElvLT/9mCO58XiOBB+VVRVjEePbJ?=
 =?us-ascii?Q?My0FXyiZsRjl0WP4/ZoDoRXweaxy6pn3A7DkXuALfiBJoPHLQ03fE0A5Av05?=
 =?us-ascii?Q?T5uRFe41KFDqD8QSwDU2fiaXFFMUsFX6CmY1ZHUR//dw1rkVGVEPtrw17Wc0?=
 =?us-ascii?Q?scIiy5NYAZP9vStoiLsLpgFGr9Jp7XvAM99dj0Qd+Rf7DW2ioUZNE5vcFUVq?=
 =?us-ascii?Q?BYBZhy6GwsJgPh3LeUsvxehKHsN0KsSQVakFAOLADJx4drMa5fBYNqL75a2h?=
 =?us-ascii?Q?2NgIyXuvwPWQmmflKu4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773ce2d4-e951-4a33-1df1-08de157e9e7f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:11.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b81iYw5YXQdgdkV/BNy2qtXOLKhQJnktdzAeCYjNQ4y14kIp8pD3hOU7Nqt0BGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Add IOPT_ADDRESS_DMABUF to the iopt_pages and the basic infrastructure to
create an iopt_pages from a struct dma_buf *.

DMABUF pages are not supported for accesses, and for now can only be used
with the VFIO DMABUF exporter.

The overall flow will be similar to memfd where the user can pass in a
DMABUF file descriptor to IOMMU_IOAS_MAP_FILE and create an area and
pages. Like other areas it can be copied and otherwise manipulated, though
there is little point in doing so.

There is no pinned page accounting done for DMABUF maps.

The DMABUF attachment exists so long as the dmabuf is mapped into an IOAS,
even if the IOAS is not mapped to any domains.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    |   3 +
 drivers/iommu/iommufd/io_pagetable.h    |  24 ++++-
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/main.c            |  10 ++
 drivers/iommu/iommufd/pages.c           | 133 +++++++++++++++++++++++-
 5 files changed, 168 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880b8..b3cf3825a88c7f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -284,6 +284,9 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		case IOPT_ADDRESS_FILE:
 			start = elm->start_byte + elm->pages->start;
 			break;
+		case IOPT_ADDRESS_DMABUF:
+			start = elm->start_byte + elm->pages->dmabuf.start;
+			break;
 		}
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index b6064f4ce4af91..26a7cb1668e8db 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -13,6 +13,7 @@
 #include "iommufd_private.h"
 
 struct iommu_domain;
+struct dma_buf;
 
 /*
  * Each io_pagetable is composed of intervals of areas which cover regions of
@@ -179,7 +180,14 @@ enum {
 
 enum iopt_address_type {
 	IOPT_ADDRESS_USER = 0,
-	IOPT_ADDRESS_FILE = 1,
+	IOPT_ADDRESS_FILE,
+	IOPT_ADDRESS_DMABUF,
+};
+
+struct iopt_pages_dmabuf {
+	struct dma_buf_attachment *attach;
+	struct phys_vec phys;
+	unsigned long start;
 };
 
 /*
@@ -209,6 +217,8 @@ struct iopt_pages {
 			struct file *file;
 			unsigned long start;
 		};
+		/* IOPT_ADDRESS_DMABUF */
+		struct iopt_pages_dmabuf dmabuf;
 	};
 	bool writable:1;
 	u8 account_mode;
@@ -220,10 +230,22 @@ struct iopt_pages {
 	struct rb_root_cached domains_itree;
 };
 
+static inline bool iopt_is_dmabuf(struct iopt_pages *pages)
+{
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return false;
+	return pages->type == IOPT_ADDRESS_DMABUF;
+}
+
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
 struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 					 unsigned long length, bool writable);
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a0e..10ee3510312132 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -504,6 +504,8 @@ void iommufd_device_pre_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
+struct device *iommufd_global_device(void);
+
 struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94e7..5cc4b08c25f585 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -751,6 +751,15 @@ static struct miscdevice vfio_misc_dev = {
 	.mode = 0666,
 };
 
+/*
+ * Used only by DMABUF, returns a valid struct device to use as a dummy struct
+ * device for attachment.
+ */
+struct device *iommufd_global_device(void)
+{
+	return iommu_misc_dev.this_device;
+}
+
 static int __init iommufd_init(void)
 {
 	int ret;
@@ -794,5 +803,6 @@ MODULE_ALIAS("devname:vfio/vfio");
 #endif
 MODULE_IMPORT_NS("IOMMUFD_INTERNAL");
 MODULE_IMPORT_NS("IOMMUFD");
+MODULE_IMPORT_NS("DMA_BUF");
 MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index c3433b84556172..4468ef3510dbee 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -45,6 +45,8 @@
  * last_iova + 1 can overflow. An iopt_pages index will always be much less than
  * ULONG_MAX so last_index + 1 cannot overflow.
  */
+#include <linux/dma-buf.h>
+#include <linux/dma-resv.h>
 #include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
@@ -53,6 +55,7 @@
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
+#include <linux/vfio_pci_core.h>
 
 #include "double_span.h"
 #include "io_pagetable.h"
@@ -272,6 +275,7 @@ struct pfn_batch {
 	unsigned int end;
 	unsigned int total_pfns;
 };
+enum { MAX_NPFNS = type_max(typeof(((struct pfn_batch *)0)->npfns[0])) };
 
 static void batch_clear(struct pfn_batch *batch)
 {
@@ -350,7 +354,6 @@ static void batch_destroy(struct pfn_batch *batch, void *backup)
 static bool batch_add_pfn_num(struct pfn_batch *batch, unsigned long pfn,
 			      u32 nr)
 {
-	const unsigned int MAX_NPFNS = type_max(typeof(*batch->npfns));
 	unsigned int end = batch->end;
 
 	if (end && pfn == batch->pfns[end - 1] + batch->npfns[end - 1] &&
@@ -1360,6 +1363,121 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 	return pages;
 }
 
+static void iopt_revoke_notify(struct dma_buf_attachment *attach)
+{
+	struct iopt_pages *pages = attach->importer_priv;
+
+	guard(mutex)(&pages->mutex);
+	pages->dmabuf.phys.len = 0;
+}
+
+static struct dma_buf_attach_ops iopt_dmabuf_attach_revoke_ops = {
+	.allow_peer2peer = true,
+	.move_notify = iopt_revoke_notify,
+};
+
+/*
+ * iommufd and vfio have a circular dependency. Future work for a phys
+ * based private interconnect will remove this.
+ */
+static int
+sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
+				 struct phys_vec *phys)
+{
+	typeof(&vfio_pci_dma_buf_iommufd_map) fn;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
+		return -EOPNOTSUPP;
+
+	fn = symbol_get(vfio_pci_dma_buf_iommufd_map);
+	if (!fn)
+		return -EOPNOTSUPP;
+	rc = fn(attachment, phys);
+	symbol_put(vfio_pci_dma_buf_iommufd_map);
+	return rc;
+}
+
+static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
+			   struct dma_buf *dmabuf)
+{
+	struct dma_buf_attachment *attach;
+	int rc;
+
+	attach = dma_buf_dynamic_attach(dmabuf, iommufd_global_device(),
+					&iopt_dmabuf_attach_revoke_ops, pages);
+	if (IS_ERR(attach))
+		return PTR_ERR(attach);
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	/*
+	 * Lock ordering requires the mutex to be taken inside the reservation,
+	 * make sure lockdep sees this.
+	 */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
+		mutex_lock(&pages->mutex);
+		mutex_unlock(&pages->mutex);
+	}
+
+	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
+	if (rc)
+		goto err_detach;
+
+	dma_resv_unlock(dmabuf->resv);
+
+	/* On success iopt_release_pages() will detach and put the dmabuf. */
+	pages->dmabuf.attach = attach;
+	return 0;
+
+err_detach:
+	dma_resv_unlock(dmabuf->resv);
+	dma_buf_detach(dmabuf, attach);
+	return rc;
+}
+
+struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
+					   struct dma_buf *dmabuf,
+					   unsigned long start_byte,
+					   unsigned long start,
+					   unsigned long length, bool writable)
+{
+	static struct lock_class_key pages_dmabuf_mutex_key;
+	struct iopt_pages *pages;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (dmabuf->size <= (start + length - 1) ||
+	    length / PAGE_SIZE >= MAX_NPFNS)
+		return ERR_PTR(-EINVAL);
+
+	pages = iopt_alloc_pages(start_byte, length, writable);
+	if (IS_ERR(pages))
+		return pages;
+
+	/*
+	 * The mmap_lock can be held when obtaining the dmabuf reservation lock
+	 * which creates a locking cycle with the pages mutex which is held
+	 * while obtaining the mmap_lock. This locking path is not present for
+	 * IOPT_ADDRESS_DMABUF so split the lock class.
+	 */
+	lockdep_set_class(&pages->mutex, &pages_dmabuf_mutex_key);
+
+	/* dmabuf does not use pinned page accounting. */
+	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
+	pages->type = IOPT_ADDRESS_DMABUF;
+	pages->dmabuf.start = start - start_byte;
+
+	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
+	if (rc) {
+		iopt_put_pages(pages);
+		return ERR_PTR(rc);
+	}
+
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1372,8 +1490,14 @@ void iopt_release_pages(struct kref *kref)
 	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages) && pages->dmabuf.attach) {
+		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
+
+		dma_buf_detach(dmabuf, pages->dmabuf.attach);
+		dma_buf_put(dmabuf);
+	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
+	}
 	kfree(pages);
 }
 
@@ -2031,7 +2155,10 @@ int iopt_pages_rw_access(struct iopt_pages *pages, unsigned long start_byte,
 	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
 		return -EPERM;
 
-	if (pages->type == IOPT_ADDRESS_FILE)
+	if (iopt_is_dmabuf(pages))
+		return -EINVAL;
+
+	if (pages->type != IOPT_ADDRESS_USER)
 		return iopt_pages_rw_slow(pages, start_index, last_index,
 					  start_byte % PAGE_SIZE, data, length,
 					  flags);
-- 
2.43.0


