Return-Path: <linux-kselftest+bounces-19775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA4099F5F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF9B71C219A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B792036F4;
	Tue, 15 Oct 2024 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AeKZkwDi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DA2036ED;
	Tue, 15 Oct 2024 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017890; cv=fail; b=rCToE0eDu+WZFxWTFiOBSRPKN6mmwm74k19PsVhF7jm0fBslEP5JxaDvdF35Jog1IAVKJ29NI3/3Pph25pJ4Gciw2dg1Ql8+IHvkMeEFilKGC4tPnmdB86ASSAKFD9wPHnG9ui+y2+/CZGNtB1dTZNHKMpTMLlpmIYbeaUNfAdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017890; c=relaxed/simple;
	bh=lV/waf3dj9ixD6WBUtBXclr9DKjZhoRshNVYIsNqkrg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFlAYGmmQcIEuNjPR/cbo/GpjEVn1ssv9u7Uikqsd50r8MDyKAZrQ0hjnMc3nzf4+l9ufjc6L9dCwaSj/QqrY6pDILxL0L/5GeKkVCRLMxDIESXjmDEXIIemtD20+l+sYglqXXzvZoR4h28krj471zaRmHiBMFpmo/K+uZcRdWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AeKZkwDi; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/kUlng1Gcdm/O1ZZX71RBKrbplcAznbV9EGKdKoMuoIZ6VO9TQayq2ABlt2dUM7BbkRBoDjzTgzu4kRlxQv8i2is1ojP+ECcfQ7istOGURu/2PLA7EIa5OO+psNtL5I1zQouXGZuYEzbOe1XXV6bwyLbbMyMI+2qv7T/LcGXUIHd9YMHy8+Ry512ajEkdxerV7+2jAMyJbpP4cb8JookCt8hqQDtx8zNWKNUGWaGZJoZ8Z+2i9JaeG1KELiGued/BJlwZ8FmtX6vMvfn/vi7mPFOea8BtND7RYO5Wni3lPStSc1CfBOTWtgL2OPiuzT5MfzYHPR2TKiLcMAtUdIKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gn2bfcvgxg4MTjebZXoAH7f67FBhAajiFIaOgzyY2Ms=;
 b=gPz+TJi4UH+WW9hUBz0R8I8z8HrEDnk75ll+MpLpaYTJZD/N3DXa/QchcX/yxHoi+5SAAxo0DCIVBl1YKOOu+5cT+cRbaLmIX4ey00ahuk4VH4ESmQRGCmQRVXuU7Xt9NcS1cGwMj+/iB/5lFmS6hqzajKM6CzojVOsqBz6LuE2kUPqnzMkMTplISdHbQBwT0yFKGuQk8+NOOv5tWdiVo9smVt9MXEcNbBTKSjv1NeX0Ssi8k5Rodzqn+Nw8hhKVvhlrJ/0uctHHt4EBMQf5kr5PYWx9IxEW4ALG/Nnpmc/Bg5em04BW1iFHJKsOfC0shCFncThrnU4hvscY9XNtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gn2bfcvgxg4MTjebZXoAH7f67FBhAajiFIaOgzyY2Ms=;
 b=AeKZkwDiKnI03DEUOsXdTjsXveMUbZK9lCgUUt8lObvtOWc34GDA+kfRJ/LrNjJJDZYDFi5UUtoUkGB3LCvEqngabO06ERes0PrmQDgpVdeYtOdKQ+VVp6zoUD4HUfQbDHqM6FsInCMlm7LeocCqsRKtdPm8YrEJbU2X7+9YYnGJtwCxzYNLQgZWnFo8C/NFYaVZaw3n5YQu6kdY07uoNISJUUsOVGG5so8rbiTBYiUu/gP+TTIpQ32QyjhSpoft3bwpsaigrHf2JcVSF7T7OAG95gCc+iUuVJEu9fTw5UH5P3JmMob1q0qp8+HhfTpxK4mWf4nZfUWEA5JBCd8m1g==
Received: from SA1P222CA0055.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::7)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.28; Tue, 15 Oct
 2024 18:44:44 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::3a) by SA1P222CA0055.outlook.office365.com
 (2603:10b6:806:2c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 18:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 18:44:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 11:44:30 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 11:44:30 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Oct 2024 11:44:29 -0700
Date: Tue, 15 Oct 2024 11:44:27 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <Zw64C7bQicoAmAM3@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
 <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia>
 <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
 <Zw3M/h1KYe9MjcZK@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zw3M/h1KYe9MjcZK@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e55e24a-7043-4696-d169-08dced496fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26u01tNFqHspxYmazKt6k7GGEetp0PXGBBVpY+Q3vDCGYPRwVx12uGG8ez3l?=
 =?us-ascii?Q?bXXBCmtVj2ekBwxJpDpArBsenWxhrZHH0zpEcIpCgWiADXKwKE5S5uK66WEL?=
 =?us-ascii?Q?FCpH+nSr5e5qua7bOTFzI4gL8k3fDWOjlrODKRecKcLkjg9YEkddH3VybVlq?=
 =?us-ascii?Q?s7geaiIKDx1nhfNXBBsCYoN1MulzVNdnOuMCpLKs/Jr7Leh9PX6w22MSGvYq?=
 =?us-ascii?Q?xPhvVgO2/+Ctp6B5UnfKaY3H3Oe/VRqibYeqA17O39w6ddt4HxO6t60paUwI?=
 =?us-ascii?Q?hBvH3wUbqw+NVYdjcLglPLTGBLk1JevzlZa/TS87AybMY2a74Lc/zUawQs4y?=
 =?us-ascii?Q?p8TgBYgkfXnKXgoUz1nCW6jB9uzPZ0NlmBFg6AVXBJamfCNxE3liFRQ5x7uw?=
 =?us-ascii?Q?WqVgbugDzD5uTGMobsD9Gmss34G6YlP9dcKQKNQprTPX8awwVqtTH+OuIv5S?=
 =?us-ascii?Q?ACusB+R/wr8Cq3AUaZdQeU6h/KY/dbloayoZxyYmVW+9dp9rCRkCKqiIhS/0?=
 =?us-ascii?Q?hVk7LdoxJGUTClwJ3eAkcev3J35OYq7vsAMuwE/+utSrsruu+NdAL1/AQ8nX?=
 =?us-ascii?Q?ERzZUo1lN/wb6ykm8IUpP6HtZ4T+GsK/091F5lh6VUMVDQUBfFY+rlap+eIS?=
 =?us-ascii?Q?HzeujPBdhdvaonBEHRcsI4lbdF3RrnbET6v0ck3xjdap7fxVvuBtPWqsSVVm?=
 =?us-ascii?Q?68Hm1q9mWFxU/DkXhhlpEZm3SrxipnG85lvcfqXI/YOU6+UdOkdv4ZoDQdsO?=
 =?us-ascii?Q?gX2+CUPvgpkLwTl9pyV81ks80KpqzZq/7altzXaYVftYuZhw6nAuGxXe1q65?=
 =?us-ascii?Q?+WlvV76gSdxDiP/KtxxYSxzIK/Xq6BN4WAzlG28zuNwbtLiBYJbv1WqR13bm?=
 =?us-ascii?Q?MJTettyJUt9ZiFz4Y0evJQONyH4x2jYwpaAlnsxEM1bzCkNk14gKpbOSgofL?=
 =?us-ascii?Q?1deIs3qf7FjIcQHlTQ4S9XEs36LMGZweisgxCOa82gH8KZwL1rqFT642Nwn1?=
 =?us-ascii?Q?cAXK8G4rp9pg86Qe+WAH1quZyH4Zt6XwF43AbfaGoGnG5xXdqAa1SiQT4TBj?=
 =?us-ascii?Q?2rxCfpDVUEx31upL3ihYYHgxbxF2U7qAzTH4WTv5QPP6//DirXCPKEQdj35Z?=
 =?us-ascii?Q?M/SgEussdXDlskmkW3ysGCOL9hzyVz+2qpTQTpX3nOl+eQudAB5t/Tc6M9D7?=
 =?us-ascii?Q?BcArniqj8yOjI8kRUEAfCnN7jPNjd+fRCoHe+k4N7CkBcvPqzhdLyADWmj4N?=
 =?us-ascii?Q?AfbuL1ryRU9BM8Vf/iNxtfl/njXaTjUFC0+Pgy6SDR1TRFTIXjIxOErx7aG+?=
 =?us-ascii?Q?XSBbd0yVjbWMGd5ea5ft9INxYCdVj8FB0eJqCbCjdbqlIfzV3OAk4Xgqr5JV?=
 =?us-ascii?Q?yFOT8z+ghALBWDcoduDnh0KnfGDy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:44:44.2294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e55e24a-7043-4696-d169-08dced496fcc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

On Mon, Oct 14, 2024 at 07:01:40PM -0700, Nicolin Chen wrote:
> On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:
> 
> > > > iommufd_device_bind
> > > > iommufd_device_attach
> > > > iommufd_vdevice_alloc_ioctl
> > > >
> > > > iommufd_device_detach
> > > > iommufd_device_unbind // refcount check fail
> > > > iommufd_vdevice_destroy ref--
> > >
> > > Things should be symmetric. As you suspected, vdevice should be
> > > destroyed before iommufd_device_detach.
> > 
> > I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> > this issue?
> > In checking whether close fd before unbind?
> 
> Oops, my bad. I will provide a fix.

This should fix the problem:

---------------------------------------------------------------------
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..13100cfea29d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -277,6 +277,11 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, IOMMUFD);
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
+	mutex_lock(&idev->igroup->lock);
+	/* idev->vdev object should be destroyed prior, yet just in case.. */
+	if (idev->vdev)
+		iommufd_object_remove(idev->ictx, NULL, idev->vdev->obj.id, 0);
+	mutex_unlock(&idev->igroup->lock);
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
---------------------------------------------------------------------

Thanks
Nicolin

