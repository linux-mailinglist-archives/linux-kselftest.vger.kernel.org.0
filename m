Return-Path: <linux-kselftest+bounces-20982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FA9B4ECE
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 17:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D397C1F21B90
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF4194AD1;
	Tue, 29 Oct 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ICWS85ds"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2034191F66;
	Tue, 29 Oct 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217813; cv=fail; b=lnnW1V77o7ikhRyNlem3Ha5vVTgCGVZB7PuhbdfHdGnzi3/cNomqyNHcSYFnefJIE7GaOyFWLf5EXoEbhkSpuCoibHHhjYdpbPwi6M8Ew1BrbXyldH6zZBskJye376fhbvVw+hp37Q9BiKQ7FkSq9Wx6SQIPWEQN2vKTyoMNJU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217813; c=relaxed/simple;
	bh=Ir0FzN15B0i3ikqpfhM0sFEJxO/4qbCnoxkd0qTz9LI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NphP/6yDoRK77plp6YOAMaT4GSbERGE0Hc/bZwMn93uicRC2RDwbcyUl41IYowr52PCXUy6Bp75xazbGXhAUdassmzzQnv+gyrcCa45xkytpjgKu3MfTVa3Rqr5DDZkCLkIVm1U+nDkAfikbUpk3Ur8659tujHBmeR5/t5lx9e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICWS85ds; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoQqQCIwkJTrpsvdVKadwCVY7S1yPr0mygX+WEbGiBl1su01GGkQ7DejmWH9XQAGbBGF/4jPkHyo3OHS5rw7sBVOY+xHaFUhoe6LoeOZfKtwymtnuKS1kI6X3t4XDOhsyXjCXYPX6cmy4Aexj4ggZiX+P+1q92bTBtA1GhH3YfdqAUqKtffRojjefk/n9v7hvXkHktWurzkT7ILNNoPiWo5tcJzu3egm/tHKG/BpA0udHFzelXjB7YLDPM0pzjQAulL5rrSF7qqy5G9H4rOiYQEpW+DDfenpy+fsyNw9W7CT4MtjBDgs3dGNKWuONfXH61vmz133tmT4H9zcH7jdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nc3oOAYkIVH2K+Vb1WyqN9ZvBvS4TANHUyo0vFFgxE=;
 b=UAzy6iJZCZKc3Ir9mib5RziBsNbRCB9YLyLPPq4/Fs13owyXDCDa2rvLROR3o1vS/OkdvzNZhOBBiSzNta5hmVD8V+u5+GfZuNhNoZ+H+ITJ3sSsVFCQJpoerhzIEdi5NhkdeU+0BDb8ZRG+4zFD2d6ToRY+41V7APrBomc+PS1hutYjPEtJnb7XS6gQUUNYYXfbyR/LRflz9O6jq/5oFsscTAt7FUyFlDIwcwSo6rLOnTrhJzzUD95PsEevtau21v5HgCESInZNjIxZCO9eqs//vsLLxUNEAYSRUkCkiJC87aPPwOFyjAgUFqxLQiLoKMX0TJyhzf7/QZbd0sSkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nc3oOAYkIVH2K+Vb1WyqN9ZvBvS4TANHUyo0vFFgxE=;
 b=ICWS85dslu8O6CQPmlgh19DufP/+7E7NjrRWbf+7jRGmA7fJQ9PHtfMAQxRZuWAZzFOaKzNk55DlHiTQ80lbJH3b8i7947eCPwTmpVRc+Y7CcWd+HNVWRZrEQFxi3eMpXzDyTSe+HuDPRsI8dV9tGotZTp08/sV43PB49GkG+fs2kC4k7JFOk24YqctgrbE5JfZhG1+CWrQX9POlr2sq8g1nBrR2roe8cDY1HjKVogNFt6xRotDYSOrPlp3aiV0djd1N9d3y7+TNQZhJxh+K0Ga5Db+LsIkh8Tev2Wpq/yx12XH8JSl0vFfB9VNgzMJGBYeB/jlKji5jvIBl9+8mxg==
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Tue, 29 Oct
 2024 16:03:25 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::f9) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Tue, 29 Oct 2024 16:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 16:03:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:03:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 29 Oct
 2024 09:03:01 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 29 Oct 2024 09:03:00 -0700
Date: Tue, 29 Oct 2024 09:02:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 09/13] iommufd/selftest: Add refcount to
 mock_iommu_device
Message-ID: <ZyEHMr7bQi0fFoUv@Asurada-Nvidia>
References: <cover.1729897352.git.nicolinc@nvidia.com>
 <f91cc278a173a95969af16c46442f18b639d4ea9.1729897352.git.nicolinc@nvidia.com>
 <20241029153438.GH209124@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241029153438.GH209124@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac85655-8b1e-45d2-f70e-08dcf833388e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+UizP5ad71aOc3Ex5+H7I8lb4MuZiqouHVFjEf8OLK1GvUKh4zOJTZfWsdhJ?=
 =?us-ascii?Q?0t8u/nHKrRbt6u/rwCVf2qsrgoztQYfqjLd9F+INu/NLUGRlmS+/5VM7wBaf?=
 =?us-ascii?Q?xxL47hD3QlMJOUnb57bbGu7gwU4aHEkO09a2cFS8tyZG2eUlVmFYLK71QXTF?=
 =?us-ascii?Q?Da1ruScnElvPPWs9UIjDmTDl8acytSc6E9zvlVuMszUNA4uGtLx8Gn9MrW7c?=
 =?us-ascii?Q?qTGII/KdGWZY69PWxOKkQjW1qtuTT8q9dyAEn2SNPjye2SfKdwF516jIXEaY?=
 =?us-ascii?Q?Q3mDKAoTZ3jJ//PblkCbvze0HTajREF5h/cPwUJhuezzL9OWujF9ExABW0G9?=
 =?us-ascii?Q?lxxjaxd+W8WCYx5mgIVTlze8GP99t57lqRwneUNy6ozGUJfAZBtAOS2VO7cE?=
 =?us-ascii?Q?bjo3XCZgfLb3QgPYORrT1o3SJSFvx4EBH3cNxYS26veLKBjHdXvlxjLPALrs?=
 =?us-ascii?Q?AhmjccjX0AAMT77+JJc+cZmfZvXpE8puxhyO2kZ0gahT6rJB1Tjaia8I3GQM?=
 =?us-ascii?Q?FNJTGcEe7usJeJcT9icKXWkI36jHwIs0Kz/W/b0RNuMA8c3cBzjzUoXhk0Qb?=
 =?us-ascii?Q?itDPQVhZnYE+kt0aHGdHZ/iiTHM0cSAFwrWmBmgyt6AHS1Z48xIlUG0zrIGY?=
 =?us-ascii?Q?me7XpHdAm2wYOO2rlqKlToaaX4Iyo3vfRgBfojfX3CYWehDYPCn60InlISS2?=
 =?us-ascii?Q?o7q8ExLXt4Ijc4eCW5GlX4sPhfvROK4G+VXOuPnM+bWkTWoOrj4uBJEabUXi?=
 =?us-ascii?Q?M+Pv9lSYF39ESZjf/Zoygd0tQHbq1nwz9ZXRKVjX1i6vZlwPfD8x5SjLIgLw?=
 =?us-ascii?Q?1U3wcFHAIRmG0JK8qpRcO9Mf8b3jh7RAi61OHV5B9aCJzJXHX0IaFvSKY28F?=
 =?us-ascii?Q?1iTy6yqR/pQI299udkDpS4wvAIhvdJMB+PzEndM+xD/TnjZ9LaMPl2bp9AeD?=
 =?us-ascii?Q?gobokkMSmkDwPnsj3d02UukalFAeu13tHVPV3ilzkT4iUJ5xGyLg2FWkA3tQ?=
 =?us-ascii?Q?b1o18Q3/T8M9++WM2/5GdKaWSlGguy3EsQnuyyuEWE9xYo5twtQYhY96nSIW?=
 =?us-ascii?Q?AaSxra3sheKbNjX45PNvByXfjbjsWhWTGpuySoQDs5Xptjwdhyjdgg3O2v49?=
 =?us-ascii?Q?RDuHlWl52o9Hgav8jEMKTG/F1oAJnfXm+VtzH5Jr/zHp6gARsgBy1hX7qsTs?=
 =?us-ascii?Q?89i0QLG/l24D9AK0ojiiOFiASkGpH2buxPAz8oYz+pIVGIFxfsZXeXKB4Gh4?=
 =?us-ascii?Q?P7ENqy3LxwpLna9mRoUKGnRSn5P+GIjVqaJm8iJKDbUYeuQRqBzn0qK8aTwU?=
 =?us-ascii?Q?/lSaTSXNu2wY0XGmA3eWr0suTSXYfRar8j6n47NLvRA/NEKdAt9RADkR8KZw?=
 =?us-ascii?Q?wjf8FfX6lKgO8iGHcmb+uwIylJ1S/6hRiDV6p1TdX+MU09MSXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:03:25.3963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac85655-8b1e-45d2-f70e-08dcf833388e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

On Tue, Oct 29, 2024 at 12:34:38PM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 25, 2024 at 04:49:49PM -0700, Nicolin Chen wrote:
> > For an iommu_dev that can unplug (so far only this selftest does so), the
> > viommu->iommu_dev pointer has no guarantee of its life cycle after it is
> > copied from the idev->dev->iommu->iommu_dev.
> > 
> > Track the user count of the iommu_dev. Postpone the exit routine using a
> > completion, if refcount is unbalanced. The refcount inc/dec will be added
> > in the following patch.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/selftest.c | 32 ++++++++++++++++++++++++--------
> >  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Since this is built into the iommufd module it can't be unloaded
> without also unloading iommufd, which is impossible as long as any
> iommufd FDs are open. So I expect that the WARN_ON can never happen.

Hmm, I assume we still need this patch then?

Could a faulty "--force" possibly trigger it?

Nicolin

