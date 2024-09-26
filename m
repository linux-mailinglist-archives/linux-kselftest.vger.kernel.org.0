Return-Path: <linux-kselftest+bounces-18428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9D9879FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 22:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36051F221E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318815A862;
	Thu, 26 Sep 2024 20:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dDCNlFxA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B541BC58;
	Thu, 26 Sep 2024 20:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727381453; cv=fail; b=MoBS0LnHyvoK14r0pzwcAkOGUS/ou7vitPXlkR5TEwg34jO/MYf24V72it/IA3q4dfAZVHDZ+gAQJwN8wDDnOVr5yiUfG9oWZ9uVIhIhmLBdOpHN2gXZ+ROFOzRMiNhnyRnlqUImpd931YraF1x/q1jGWpGKrBn8WDqw1cnEIHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727381453; c=relaxed/simple;
	bh=Lo8KCptgx3xpUCfpx5/dAXC7R0bywG8o3D8Bb0/iGxo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dgj0quyY0V75crYdbTxldEajqjq+I66kE4PVnDXT9ylubRKr8/h4G9KmvFlr0XAzcsihWFOiwJMLq7c6NeFz+ncZerUJ99Rk57PdcviIZdhcNJoD3CvZZN7lMQftmLniwwNMovuKnXeTbSnAPAzXsXxHl7hzWuna9/qQPswI8pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dDCNlFxA; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRM4a7XeafX5uQ6rTm/gKfmSsl+kgHnewVWei7t8Jn8r5Xf+ZyZnO71BBbTMKrAR4+C+XWUUv0ywkOJOoKDsiSOrjbeeweRCG4sHHviI0rwEn7/ifzjDaPaXik7FCtCIq14Sv4LvmUu1l9oz+ZlwRhjUjvAPnGYJ+BdfqPfAl+hYdSJdNQsmNFnZqfFTaA+SYIUNesR/xclRNiDbrXXCTg5VjZ3E7zpqnRAl7kMDZkwARMLGRChkfnYZsuhLQRQCH8PEWR9VooMWaGuiur2fEcRKTfeW3zM+67tA2Fu/sINeLzf5dl5otLleaJ3Qv4sX0W7uKoPFitrFtCsV5TeK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IvCX5/R8XMHp+Ih+iOiKL48eGlOMs10hOmuQZyhYVc=;
 b=pbH8bzJZxJM0YdCFnZ4NEhB7z8GME7wwOGEoh/PM7bQ5PHiOSUSm4/Dad47GzdJ3peNjbfyj4Bm6qCpzHXWnKnUVVoS/lIynVLotQvLaCK4nNhDclnR18fld9lVyKcrd6/PdDGTHl8pRASScDGEU+xdXTVsYwzHq2rAo0BfQmQaR0nZjJrO6ThPIjDBulIHlU9iOwAnT4kYkGikrk/sVoMBN7pt6M8DL/Nu22LfrowXpeqD4OfbIES7V7fUXA2laZCT7H17Bq088I1FFJI40tPsA+9hifxN9DCFvKFnG4FDgPjJnDmsnftb+yYABmWr9SWOejg4GOu/KbXJQozyWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IvCX5/R8XMHp+Ih+iOiKL48eGlOMs10hOmuQZyhYVc=;
 b=dDCNlFxA2Q+xvn6YeuLQqfy5R+dg1b0kTauxoe8RUIH4o+sE++lPvlOrZRUMHWdD6TJ87hK5PQdsymg4gAwUDDsc5zPuDJw2QM+2l47/QPfrXh6hgKJlxpYYUBWhcwQcXNYW05pCwbQp2sjU1QxG8UqYBmNsY9ciXtYQarh3slEJL3TwjaKeARHBhCbwA6X/jQbeH6FlSYwIw81nPwwO9NfRuP9vWURDo97tnLN5XkWo5FKDsNxRQjI6FkgRPhLzHdiebGSAH5Ca431s0TonzqNdhuIL9gIAZlwEeL4MX+57X7EJ9lZBqWf7IKLMgTJvRysyF55GTSV33FGypqxR4w==
Received: from DM6PR06CA0097.namprd06.prod.outlook.com (2603:10b6:5:336::30)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 20:10:48 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::e1) by DM6PR06CA0097.outlook.office365.com
 (2603:10b6:5:336::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Thu, 26 Sep 2024 20:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 20:10:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 26 Sep
 2024 13:10:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 26 Sep 2024 13:10:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Sep 2024 13:10:38 -0700
Date: Thu, 26 Sep 2024 13:10:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>
Subject: Re: [PATCH v2 04/19] iommufd: Allow pt_id to carry viommu_id for
 IOMMU_HWPT_ALLOC
Message-ID: <ZvW/vS5/vulxw3co@Asurada-Nvidia>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <2d469a5279ef05820d5993df752d32239878338d.1724776335.git.nicolinc@nvidia.com>
 <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3ddf97a3-cf5b-4907-bbe4-296456951e6b@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f93d362-7ede-4737-6d88-08dcde674fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VgMwvHzIuqt6i26Xl3M3LoL345ioZmZkF/YB9YlUdKvGj6jIZoksozozHar0?=
 =?us-ascii?Q?TOTr2jW6W2fIMfMgQVVsvYm+cABwfbZKluEnHZcU6ESQ2i5zL8eJnIlXNQwK?=
 =?us-ascii?Q?vUGqHWWDUIV4HFubAVWhL5go3CjGvflSVLo7dnSBGHOBHZ02vxXNS5uommhu?=
 =?us-ascii?Q?XLeQjX7Ch80KEMBeW1o1mXu2pfrCNYI8ws+8LANqCF0vpcrUoqn3gmvbgFBY?=
 =?us-ascii?Q?T/MGa/PYmAZZYzLSZnZFkCBrWlyrxpmApXmTw8eDWyWoBQ4mRgLxkBCN1+1d?=
 =?us-ascii?Q?c6ViPiuDvHwkzEe4fUVYQC3yg2plNs7JLWP0vXbhrMU9hw/X55lUTyitNsIN?=
 =?us-ascii?Q?jY/2D3uVRQJ2t/aDCHtQ2XFUxIDqBcJK5CWfHvRgF3YbxClORVk/oOP5buGU?=
 =?us-ascii?Q?uXbrRD03vlauv7WRm5TCCubR/tsHBllnfJaIaknINL9EPKRxPQ1ymAEw74X3?=
 =?us-ascii?Q?xVgjrFyaSZa/hY8phNDiXDgRNF3pVn+7X2ee8KBrMGz/18iYGr56UXhuLG54?=
 =?us-ascii?Q?Ex0kP+9xMODnlcELh5gkK0tVl5MvUrTdo0pABgs+hStw9A9jBywsjJ3LLGBK?=
 =?us-ascii?Q?5Dr7FgkDlW7nC2OBj72HsFlByFedElWlaZCi3BEzdYMNgBWDDvnYzFaqO80S?=
 =?us-ascii?Q?FRLJIljO0zOhjr1kJFBoFNph7Q095zyXpz2A/NfD077a0Wc2NTvUL6PlCzUA?=
 =?us-ascii?Q?aSQDclWy2zOKaE8GS/FjQNGXl6EicBRouH9vRuMgQ7UrnoyCOHPeqzg4EFyh?=
 =?us-ascii?Q?KaUWheBOG+afIEM2o4mrP5ipNQspNeXHf2MuxiyY9lSDIb7OmHPgA4+bHx1p?=
 =?us-ascii?Q?BQMV18fCxLvUo0wZWX2mdSRkiA41xNRIpsUBi+9g7TVPozuIz18UoQMH0M5a?=
 =?us-ascii?Q?cK3+YvELDbHGMe+7mvW8KxtZUnH6ZnTX2jsqm0s7ySPptjec8j086vfTCxSD?=
 =?us-ascii?Q?K3hBpu8Or7TzdCy+Ole6iGSzVb4G3OY355+rg9V7lvR6yaUfMBrDXtJlUkiy?=
 =?us-ascii?Q?Kk7bQsT5A0l/slpvhz49WqZDUX5xtLInWce9oSO4w+U5POWXcwR6SaZur5LG?=
 =?us-ascii?Q?qHTLX3wcJqez8RcQLGMX8+8p5CTpvsSBfJo7hS4sGJOvAi6/fb6Y1hQVteO6?=
 =?us-ascii?Q?Z+TtI1ldcefFs+DECbYrVg5r0t6fsI+dp34e7GYBvRzqJdAjh6ZMiO2zIEyS?=
 =?us-ascii?Q?WkGmUaORWkqPtV1GzzQumjB51gc3eUn12ymEO97Py+Pb2CGi9CGJC+NQ1ArA?=
 =?us-ascii?Q?XR4qMbJRxmerUE3VBQ1AUee0H3+RE09XkVUeD1aLBHMluEpReuzIrEOmH5xC?=
 =?us-ascii?Q?5SMIW4QFkmhDiVNvEyoz+LBJ915ewRdIlDPCA6xhwiXf+XuPBCZUtswCUniX?=
 =?us-ascii?Q?6CAHiCd6/rHaeCG3mo6ZufizVBDQuvecSf3H6l6BI0x4vaFSYaIcBGiBoDll?=
 =?us-ascii?Q?smC/a1arX1MvJy3LgLkgTKkk/Eo8pepD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 20:10:48.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f93d362-7ede-4737-6d88-08dcde674fe1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805

On Thu, Sep 26, 2024 at 04:50:46PM +0800, Yi Liu wrote:
> On 2024/8/28 00:59, Nicolin Chen wrote:
> > Now a VIOMMU can wrap a shareable nested parent HWPT. So, it can act like
> > a nested parent HWPT to allocate a nested HWPT.
> > 
> > Support that in the IOMMU_HWPT_ALLOC ioctl handler, and update its kdoc.
> > 
> > Also, associate a viommu to an allocating nested HWPT.
> 
> it still not quite clear to me what vIOMMU obj stands for. Here, it is a
> wrapper of s2 hpwt IIUC. But in the cover letter, vIOMMU obj can instanced
> per the vIOMMU units in VM.

Yea, the implementation in this version is merely a wrapper. I
had a general introduction of vIOMMU in the other reply. And I
will put something similar in the next version of the series,
so the idea would be bigger than a wrapper.

> Does it mean each vIOMMU of VM can only have
> one s2 HWPT?

Giving some examples here:
 - If a VM has 1 vIOMMU, there will be 1 vIOMMU object in the
   kernel holding one S2 HWPT.
 - If a VM has 2 vIOMMUs, there will be 2 vIOMMU objects in the
   kernel that can hold two different S2 HWPTs, or share one S2
   HWPT (saving memory).

Thanks
Nic

