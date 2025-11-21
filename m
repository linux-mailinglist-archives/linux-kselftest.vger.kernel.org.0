Return-Path: <linux-kselftest+bounces-46252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C0C7AA3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 16:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1803A1CC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EE734CFD1;
	Fri, 21 Nov 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rj7AJZqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4934886F;
	Fri, 21 Nov 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740284; cv=fail; b=Y00Ct7gsh0m3EZhpMHYBwFjWWjdGpBVTubc1pk43s0kkVaWVi4n0QLX9RPPvSsd1Byz6NODMSs0iracWfrZEDYH1xI3Tjs5LMj4iltIKoKPHZA7aOPKwv7FZWcZOSTgtB17rr20MCEdLzsLDWq9Sl06UqtEgJ0rSpDv78Whxg7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740284; c=relaxed/simple;
	bh=JehItpqL1oMlmG/pIfvnSw2QVNYFrIUB9IW7UHfPkW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=buxadQWDZnbqixupuBN2c32ks9kzs3vjRfsjAHjTHPu8kp9P+U5Y6qaUDnphxFkAPies0FpB1bJ0RIjzSLB6fg4k8GKvgQBQ+aH8tkVhRL1Fj/944V2k7SspdkP/01O/skkhXMWSzGRFwFzn0sLLpc0J7VoHluG5wSy03/1NxNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rj7AJZqn; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnwfEYA6ShmYekha0AfWq9N+C3DQXc35rbUW6SEOHlnAX54016ky4uFOsJDMuwo7YjWqeX+ESX/baIP39LbZyg9VFlGvdyvvklIJffAb13vP+OD3e/nKjfm/97U6o44cnUqAVVpC8nOo/vlwXjkzzC3u+BxZKwXnQhaCHFTLbz4NR/6VRPkjATvzJ88yN/j1donFcsyUqcwcKLkNe4ODe3nPlUj1931FigVGTAOvlwp5I0XZ6w35HSmwPhplgGwroL1pgsirllq7f8YJLZJO+3llmIXcACa3VigfYsqkBaCQHNLaeb4bVjW38NBbiZ9HIzlNxT3CQIpzf+O9TkZLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10/d5u1S3dQjNuklzqHobWQbm6hEM2JgqwHYkC8VNWM=;
 b=iZzDhqIA2SfKThar5AykzpM77paCXucq9NTAnyzYL4LcfWHix7Jqc87vxQ1giKXIXCvZHCVbHeqHcznDZoKOOX6kBeueuVnqavxmq7llFUxHEBAH0HKDHC00YgcJrr92KGnn+LI+zcCD5Qw2g0SH6nG7+KVymUwOHn8nhJVnD+QNxqxcIY3zMyG6iekltHDS+sycg+JAlaud0MsGr96SA08sFvM5iVGQcY37q+rX1CFjzL51KwsxsWQxMBPa7K53W9LPVjusbW8BHu9adMr23LqHpyODjm294g1rnO5S5IsBPuWm6BrAPjSmlXPTcNUkJydxffqlkYfxEf2am/dfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10/d5u1S3dQjNuklzqHobWQbm6hEM2JgqwHYkC8VNWM=;
 b=Rj7AJZqnflk1Swty68VtyPTYSrfIalWrOwccYMFVdwVBK9pVSJyf3EJZAfv1qlCW8ciNOb31U6JLU9o5cXZKpcK+JM5Vr4bb8YSWvk4l+1PyAsQPJ64Tst5lvzPkYzEz6m303xu16WUnRUgKo0GJI6iUh+Z3+yO0dg/az+ZD6jXCaq0dtUculYEr3WGdo6V9lpOfy9dg8wwQCCePTsrV3bR5zeljhh7O3QiBoEZt8JQfdw8tYwZU2vii4OmHTCKaL+wSlO3HlgvcURUfQ6evRicyQXblawCuKP+Q/C4bfaGK/5ECO3Bn9EhgC4eOMHnD7txJn7yq4blB3s6M25GQzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.15; Fri, 21 Nov 2025 15:51:11 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Fri, 21 Nov 2025
 15:51:11 +0000
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
Subject: [PATCH v2 7/9] iommufd: Have iopt_map_file_pages convert the fd to a file
Date: Fri, 21 Nov 2025 11:51:04 -0400
Message-ID: <7-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v2-b2c110338e3f+5c2-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7eb2b9-f9da-4908-32f7-08de2915c96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1/gRprS7mgLkRI20WsQhhSrUeIv39oautt2YzRrWLumR31IDUkop713TeLm?=
 =?us-ascii?Q?6RO5j5O95DazsU+dMmVY5Qp+TIM21LtgL2jW8FH24skERSf+ZmxNb+AqzCfg?=
 =?us-ascii?Q?x6jdl8EwMvITah8W6IokoG+1HqIFq64ZbXKns0rRLWgCUbjyTQ0i3+hP8CSp?=
 =?us-ascii?Q?957HZc702RRkCvA1J7/pYMODa+J/gQilIqsJkI3JD0+gO1J8BVX+6sNIH4K4?=
 =?us-ascii?Q?J2Sdz89wP2X+eaZ44/VgwdB2R5CqnVw/aZ5FAgj1+usc2ief9Io0xtNXnMhq?=
 =?us-ascii?Q?0/1YfSk24xKvUxRlb03gnLSVsTpdaCAcuZkFSTK06gy0hA1FzD6nqPeGHBtk?=
 =?us-ascii?Q?rA9PN7SBpSGxG4Roh7xD2J6goG9BTAw8GLS+3FjUTRJ2sAzkx5GlKDttBtPH?=
 =?us-ascii?Q?rAVJAnVFG0QFnH4JCmIKAtZyYmwy7xgb3Uy811qPZC3LIpqPVjPRYv9jVm1G?=
 =?us-ascii?Q?1/KjttpBcA1uONJizgO4rYhsHGBw/xlh0VomYx/NO9TWRuWNUv4UBBDEqNwt?=
 =?us-ascii?Q?lG0wGxjQckpy1OxTD5hdNZeg6WKcPr5JSuNCfmF1Yws7Tc8wmBNfEq941H3d?=
 =?us-ascii?Q?ETg36nXXCT6+jhGB3H7bub1mgOx/iOSH5mvRsJ215RVH1QI3gKSfrsy4IHVe?=
 =?us-ascii?Q?el+PWoEN13bWyVsDt+hol/X/vYQ4X7G1yIGmVjv6P4MYMEWtZ0Ienftl8Mfh?=
 =?us-ascii?Q?omsMXd7PxeZDBXj6NoNy2CoLbvbxf6x6qdg+9O/dqnb250qvS1cA/tfpNG7p?=
 =?us-ascii?Q?IZRrlIGbzm52meYX47qOnVnsNKVht3HarCg6qqJBnsM/dtryZCeAcjzUJ7K6?=
 =?us-ascii?Q?PPgZ11CxUmY9AY1lvLmO1tgFSS7UrKcdTzqB8Wt/Et9fJobntiHjyuNgiN8Q?=
 =?us-ascii?Q?Bk4c6X1QrgLIMtVjou7eYwF0uCEfAV74uM9HRINyKC4af4pvyXo1xeQYwNuy?=
 =?us-ascii?Q?69SSeu70owWErgLKsW1C9/2/j40gcoPM09s7Td8fvaSSsf8MP10ROWrJt63f?=
 =?us-ascii?Q?TU3ow08GZo92dje5sNY8SVED/tSq6yuFiCRkzA9mB+4IX18ZIaG6fjslK/d0?=
 =?us-ascii?Q?JAWGlmo3mA846zOwiTFR4ZWG4vloh6ricqabzOzdy3XfzDWCJJ+GewLyK24m?=
 =?us-ascii?Q?rBJBJqlTp/MP9PZy2cAWHC4LB27yYt4PWqMcM667yW3ntkY3DOOp4kM4Mbrv?=
 =?us-ascii?Q?ZdUMKB5Sx5jjvwdUi4ECLP5zLXN5BUnlMIuNsN08DHPATVVNRMhiVEatFzJ7?=
 =?us-ascii?Q?OfwE1CEm+wupGpqh8rWHa3HHpejwFEx2Tx2o7MBYfsmvd7aRkKSx3vBQW7Eg?=
 =?us-ascii?Q?u5x4kGKxrvgXJiMInTif1rcqbH+mVmdbuEaU0Fd3BAc+yjHrJgJBW9+ScoMH?=
 =?us-ascii?Q?1hljP83ib98ejd3cwujJpq71jW3GlVLHSbSglRkvFyl7kK2VVD2TApRMQXX1?=
 =?us-ascii?Q?luN8WFQj8h+1rzj4XoQhsfEXxkba0eWPxS8rradTdoQXNFIYMtBpTGz/4Edj?=
 =?us-ascii?Q?S3zu1oru9rGpvOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?85mxdjICISqxBLblfZLxh8g5fs6NJPN4Ul4Z0L/0kXkwVd/Nly1WZQER+86m?=
 =?us-ascii?Q?chp9tNoSvQjtwm4MGlycboy5X5i/pCzm9Lu/S5eXEA4lsGqdpicWT9R/Gzl4?=
 =?us-ascii?Q?crpn0u/C0D8s5m2js8SYewPOwFZ6g7YD9IW9dWMP/U99UfIhz89laSVhcOK2?=
 =?us-ascii?Q?RKo/slA4FPS/U5zbBYQwK0pgb4ZBiSeSbcakggM68W1riqXuNvNEz/VlTnVg?=
 =?us-ascii?Q?2PZVuKuDL6rl5l/0gANA9FHPJEr1aZNePu2riABtB26oSmu7i7UDbVn3gThm?=
 =?us-ascii?Q?iJqjDH/xX7m4ArtQUrc+P1CyB73/D5Kt1xRJWL15qJKwFXcdH7LkJvEUrzfp?=
 =?us-ascii?Q?mTCucT8wweAp0dIl9/SBI027AIQC7q3JzZbH0c9HK7Aop8h60vyptew8nNYu?=
 =?us-ascii?Q?Q6UJxHNo8hAZnPkzXJl1vZA3QrxJzAWjBIldCEViP+nVGT/OrctP8OVd5Gai?=
 =?us-ascii?Q?W7EH8/zrE4fByuV4S4na2uDGIXiHhZ58IzPrs+nl0MDJbTzV16722CgaxUlL?=
 =?us-ascii?Q?pAMN5OJGs2RxaEL6Fsqkc42AWcCzUoFXs1ysNK8pTdhBHU8x3mjiMf0bd/u9?=
 =?us-ascii?Q?kQnGS0BXj9BE1aZMFGAb1BlR8pmJQo4b916wRNYGikCTRMil2/yKbe9ScGRT?=
 =?us-ascii?Q?EPV5+B5az0qDWFsiIJJbLdsio6slusaEvhj0aYtL3Q5PUKBNmqDqKKvOhKjh?=
 =?us-ascii?Q?wlEjDLSaL9MKDn7yf1CV3VgdJgNIHO0gKKhXJinGZjmqW2tTrCZ5hGHTiNCX?=
 =?us-ascii?Q?E7vJ3lpXf+o418DcaBu1gNk6X/+3f88JtU0erKHm+SikQQN+sOjlbHiZ3Pik?=
 =?us-ascii?Q?T+5PP/dSLTE86al2motAvlar/vSkLJpQ3dfopnEfnz26EqyesA1+PhMCpeO2?=
 =?us-ascii?Q?AHLZNJ3AE0u8gvLjzR7DfWsJjhHSEtG6ntkJGCPxNDXTyzBm6D/wonGg5Hwt?=
 =?us-ascii?Q?D2mtsFLpVz9fRgPmTY7fNnXYknRIwRAeXyQIC0Kn3eFrwJGqmSTjFQu+bzMP?=
 =?us-ascii?Q?+NdJfZMnHQMi0M99CV+OFjx4RG4sZx16IBR2cmDg2b6ULFWwKizHlJZ/abso?=
 =?us-ascii?Q?34cr21inVp/K/cCXqPnluB+6aL22Gbd8Tfzi1HAUb8VmeZ95QnuDOKFlqjHm?=
 =?us-ascii?Q?GZ6U0wuXYGyWX//PL6wEaxDvsH9F+sV4vJ+kebBwMtwTRD1Ef/FTCKTCN8IK?=
 =?us-ascii?Q?Mo403qJDdnJIz35HhXcEbemXagqzyOaIf6e314bSVSpYc02EbdJbY5ADSrRL?=
 =?us-ascii?Q?kGJxCitbdWDZ61MWLTCKqwKSmGN6P8lZzckpfdywY2RM4YD1gHnm4Wfb2r6G?=
 =?us-ascii?Q?Fjurb1w9VV0vGWgrqZedzlbNF6WGqiDxSz/gk7CSCph5gF1UXT4gbdWTg3LT?=
 =?us-ascii?Q?TBKabqCBSyfObdXhy6i4jvrmyEJugCQEIpW61UkuBjPSaKo9SPOQnDIXLuKs?=
 =?us-ascii?Q?JnlrxVpVdSRLrBTEf9VUgS+HluVPZ3A2b9nV94XPbFagmBQNdpCP71Lo94zm?=
 =?us-ascii?Q?UF20/tj2yVDVhayro4e5lKPHViiBMp6LDeZxzoWWhmGqUGFuIpiLPDuGFMYS?=
 =?us-ascii?Q?/D1by8+Io79xq5yns3o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7eb2b9-f9da-4908-32f7-08de2915c96a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:51:08.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWf4VZWE0dAPz7JZE3YaLpydV2mFXwdSV8sOSzEZ52DHFjmKDD2LanxZF+5cHC5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439

Since dmabuf only has APIs that work on an int fd and not a struct file *,
pass the fd deeper into the call chain so we can use the dmabuf APIs as
is.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 15 +++++++++++----
 drivers/iommu/iommufd/ioas.c            |  8 +-------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index a120c2ae942a8b..0bf6ca77888c0f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -10,6 +10,7 @@
  */
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <linux/lockdep.h>
@@ -471,21 +472,27 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
  * @iopt: io_pagetable to act on
  * @iova: If IOPT_ALLOC_IOVA is set this is unused on input and contains
  *        the chosen iova on output. Otherwise is the iova to map to on input
- * @file: file to map
+ * @fd: fdno of a file to map
  * @start: map file starting at this byte offset
  * @length: Number of bytes to map
  * @iommu_prot: Combination of IOMMU_READ/WRITE/etc bits for the mapping
  * @flags: IOPT_ALLOC_IOVA or zero
  */
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
-			unsigned long start, unsigned long length,
-			int iommu_prot, unsigned int flags)
+			unsigned long *iova, int fd, unsigned long start,
+			unsigned long length, int iommu_prot,
+			unsigned int flags)
 {
 	struct iopt_pages *pages;
+	struct file *file;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
 
 	pages = iopt_alloc_file_pages(file, start, length,
 				      iommu_prot & IOMMU_WRITE);
+	fput(file);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 	return iopt_map_common(ictx, iopt, pages, iova, length,
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a85c..0dee38d7252df4 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -207,7 +207,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	unsigned long iova = cmd->iova;
 	struct iommufd_ioas *ioas;
 	unsigned int flags = 0;
-	struct file *file;
 	int rc;
 
 	if (cmd->flags &
@@ -229,11 +228,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
 		flags = IOPT_ALLOC_IOVA;
 
-	file = fget(cmd->fd);
-	if (!file)
-		return -EBADF;
-
-	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, file,
+	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, cmd->fd,
 				 cmd->start, cmd->length,
 				 conv_iommu_prot(cmd->flags), flags);
 	if (rc)
@@ -243,7 +238,6 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 out_put:
 	iommufd_put_object(ucmd->ictx, &ioas->obj);
-	fput(file);
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 10ee3510312132..a2786fee7603f5 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -108,7 +108,7 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long length, int iommu_prot,
 			unsigned int flags);
 int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
-			unsigned long *iova, struct file *file,
+			unsigned long *iova, int fd,
 			unsigned long start, unsigned long length,
 			int iommu_prot, unsigned int flags);
 int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
-- 
2.43.0


