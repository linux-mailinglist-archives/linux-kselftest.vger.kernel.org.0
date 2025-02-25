Return-Path: <linux-kselftest+bounces-27478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB22A446A4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EC0188819E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376FC1A00FA;
	Tue, 25 Feb 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCRvrTK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81619E833;
	Tue, 25 Feb 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501717; cv=fail; b=H4lnocWfBfGY0ETNDcBATQwJJ7DiPKs/wL51pwvLX/IkAPGhqBAQBg5TL0Wq3Tg+akVqHwNwmmPRtHkkgDdLtbqWoGkD46/RIkaU0GQcaYBWV29G/EKtS/joNvTVqPFi8xzgK6w7mtUJbd79mzQTlcJO6sZ3nNY5UYP/U9lud2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501717; c=relaxed/simple;
	bh=geutMUmGInbYPhEWNr/0mhLhtBnGxn72dK7u30t1UKk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDXz3ykSOh/VSTR+/wrGW9t1MzfB5BqnKzaa2TzHyg5fFTz+Fw+BiB94GwGlz1zH8L5azCHQOn8iOHiIxtiReDuoNhQc+03y728MuzZOaoET6KO0WOg//ldZINymp2I2/dM7fO4fiOI/EjP9uX9mTKVkZt9rTMAlr5kdyRwaAvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCRvrTK9; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF3ecVSxWlxQcYBEHebnmViCp0527kL/pJRuHNGU0HI4oiNguXYhZiV6VheNSoOCF22UgZEjUwZfWp9jf8Vla9cIv9ylKrcF9BUc8q7lnH7FlvJowAd3JM4UTyda+CUh5OnqHtwlmk5DH/vr5wODTDL65nrnG0jYS7CPGpWzjUmZ7WVhLACn7Myr+FsSuBIwiWlCAOH6RMQpd6Gmxjclc8HBE1p+fJlwEap+f6vwezWTTh3xwpGAUTYGSEwxlLDCBWZukAeqQJtd+6DGa86c/kQdhY9atAnLqW8bltMDSE2InIHHP4V3PaTacF0Q38RgyJvMZR7OwqM/5/LsuI14FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQzwjHZLgpxUYciJqtWuSoygM9wjRLKnUx9VAR3mK1Q=;
 b=X7Xguuljxx55Su6FXbC3nzG5ZHxwj4w7w+UnlZwd4Ju5yIy1K3V/MZ9gKIFg/1T5XoOnT6zhUZ+/jrciD8ZGGm8T8iWeL/wA4w0gwqHkEIIqvYYEyXh2m0jSXr93JGYCx2//Zo70aTkeYMfwWLxQRT2XGrctQ7l1HRuhzQk+wgn7CPG+HZc6NdE1YIKykum7oJo7ylMYPbPvKHqcVLnwmDOucj6L6dg2Q944jXiyRg2ZtYc0oqc3HBuiplggpcjVzPJLbU+5Je1JO/WDYO/YFHKmJ/Ml5bvpKVMw9iuemTIdKFU8gTtfwEYrk/FH3mM3PvFMf0aGWqhoDXJQruhGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQzwjHZLgpxUYciJqtWuSoygM9wjRLKnUx9VAR3mK1Q=;
 b=BCRvrTK9WNiPzCG2wZrLYh3KCUoYq5cbfm9yJry5wqB4NfUIpMpHUrPKc2Kv2ivjdidGzq6PPOreGoCJrnhfICgAI44bqBTlRQqm9vZiKhmm3E/bKBqgLl6hBjphVNoA/tJtCEjy85z2+wO/f63lNoY++SoiwN7oL6O41p/0ePe+ET9YI57hTZvC3hqH4/hdddZztJ5JWybVjOG3pGVyoPaazK+XBheCMEJOSPQMG3lNoRcN/rb8uwdvpObLcOpLB4xzPNeiPB2Lcz8W3Y2eINob+x/wteD+QhYzVryLtwDuIQKvpV8L81Cn6ILDIRRV3yc5K6pIx/a3+Ke2lrr4vg==
Received: from MN2PR12CA0022.namprd12.prod.outlook.com (2603:10b6:208:a8::35)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:41:48 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::c7) by MN2PR12CA0022.outlook.office365.com
 (2603:10b6:208:a8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 16:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 16:41:48 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 08:41:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 08:41:29 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 25 Feb 2025 08:41:28 -0800
Date: Tue, 25 Feb 2025 08:41:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Pranjal Shrivastava <praan@google.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z73yt4r0iDFwbty2@Asurada-Nvidia>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
 <20250225160225.GA593877@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250225160225.GA593877@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: f160a562-86b6-4b43-20f1-08dd55bb4c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rXpPdERVcJpT2AV1PouQTcJUQKzvmGjIfdiuhzoTyUnZyZaQsSZjD0KzvylR?=
 =?us-ascii?Q?IXb76n4TgsUenOlIqH4C1iiSNPJdh0r2dKWRNWffzZ7LYgEcxw85vTCdXxRB?=
 =?us-ascii?Q?8K0SOxP8WqrXPViGUK7O4Xt4ZUV1zLBBzGhozvYfxekjRbOEVUa0Vwl6DS2y?=
 =?us-ascii?Q?1PVEpLwjG03EQIeGwQa6ArVozhzFZ+nf5YROP28mmbF/zCgiRcU0DWF6+X/Z?=
 =?us-ascii?Q?f0bGbRhzet64XekbzB2i5sC9YPCjRKnO6zSVOp4teMwJ/XU0nWowawPkbIH4?=
 =?us-ascii?Q?4/7EUSquxm3m5PdC590sDvmrGNw/+aT2EsryApuPkGKzn7VRJh1KzyYxOWQA?=
 =?us-ascii?Q?ouATWC9DwyfLcv5GEVmOsTDpgnR4RgU35aqN7I4m4LCC5IEHztd9TFgOpbjK?=
 =?us-ascii?Q?LzcMN1HwnKtVeRPbToN5pHM9QPcR/PAliCO6LBmvrNreeW7z5vxnyfuDLhyS?=
 =?us-ascii?Q?/VY0DFFLS2NseZ/Ymkh3mjvbjtM/ixsr4pHNXKTeMVt2t0IP+Ovr+T+oawY6?=
 =?us-ascii?Q?LmuTr75dRPF4GCACNI2HRrdh4DPsEh5EOTHZ0gd0HnsANsR+/h7XkCxqkDqB?=
 =?us-ascii?Q?ZdULKJkPitU5i9If72fpJTRRpibM3N2x01UNnJU/y0AXXzgmvlkxGj1uQxSc?=
 =?us-ascii?Q?GJv5PVhkSYe2ptnK2Zg+dpgep8YWOMrffD+OVmk3wVniVIvoKgCBi+4bicFl?=
 =?us-ascii?Q?5YBomFPf2QsuAn0psUeH3AfwiKeUtm4nRl9plR8gl4BvrRlLArkLh8+Oe04U?=
 =?us-ascii?Q?ap/GP86eh1WBsdZn6TS96FOaSSV/JDbTiJo3AnXKTiRd1iNqxg/Of/RG1tQV?=
 =?us-ascii?Q?YF++95XQC7DwQFSQok7b8QjhHx/ZpxWo8IS/C5ZG86324t38Swgyub79NgmB?=
 =?us-ascii?Q?rZncuv3TdzqLq9HP34frHvjb8jjV/lpdWpx3pagpL2BBC79gsY4otEbnelkX?=
 =?us-ascii?Q?jpPO6PjKmISmbe1Z8aPaHq8CERPrtRllwE4XXw8/5QZaibtUeJn2GCnk0RkA?=
 =?us-ascii?Q?Yaf6Usxnh3Gc6KVNMyG5rXJkPEOPvpwxIG5LPISbv9SYXaj28+W1zTwQdXpM?=
 =?us-ascii?Q?myWecQS+9owGtaA71AqR8YsHg7M5lPw6nkab+LRlTMMNGcOAxBi5HmHOUiN6?=
 =?us-ascii?Q?Xrufk4rg+Dm4x/mPSuisc3u7K6D4xrO3CQRVm/mVswx62MVwUw5lp4ax1rBx?=
 =?us-ascii?Q?WQfMrKpJgVyt59etGje5rgC2oPnsSp5/KwILM8zepkK5wUEjHSYcDC+9xq37?=
 =?us-ascii?Q?lU+XBCDgZE3Xcf4q4AKUqAUPN8b8WL6A0PvjBhTI8BwppQYtXh7YT1UVywX5?=
 =?us-ascii?Q?v+8zeriaFUhk4OqFH0D+TkaZjKvuCbfyJ/qM84np8p+b4l9V5hzuMMghZ26h?=
 =?us-ascii?Q?YPYBUygVY9Tt9kzQ4rwMsYB8ZH97CjLwcvEBvj36Uw8hsvTepn+cpbyee0Ck?=
 =?us-ascii?Q?pCsoi8meoc1WOZ3OXPTLV6kC0NOSwSw28zdFpVRG0HUoeHX2p9jRKsDVOLJw?=
 =?us-ascii?Q?3K5cbYc+RQONuMI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:41:48.2733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f160a562-86b6-4b43-20f1-08dd55bb4c5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

On Tue, Feb 25, 2025 at 12:02:25PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:
> 
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> >  
> >  	iommu_group_mutex_assert(state->master->dev);
> >  
> > -	if (domain->type != IOMMU_DOMAIN_NESTED)
> > -		return 0;
> >  	nested_domain = to_smmu_nested_domain(domain);
> >  
> >  	/* Skip invalid vSTE */
> > @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> >  {
> >  	struct arm_smmu_master *master = state->master;
> >  
> > -	mutex_lock(&master->smmu->streams_mutex);
> > -	if (state->vmaster != master->vmaster) {
> > -		kfree(master->vmaster);
> > -		master->vmaster = state->vmaster;
> > -	}
> > -	mutex_unlock(&master->smmu->streams_mutex);
> > -}
> > -
> > -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > -{
> >  	mutex_lock(&master->smmu->streams_mutex);
> >  	kfree(master->vmaster);
> > -	master->vmaster = NULL;
> > +	master->vmaster = state->vmaster;
> >  	mutex_unlock(&master->smmu->streams_mutex);
> >  }
> 
> I'd leave the clear_vmaster just for clarity. Commit should not be
> unpaired with prepare in the other functions.
> 
> It looks fine with this on top too
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Ack. I added it back and a #ifdef to the vmaster: 

+void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
+{
+       struct arm_smmu_attach_state state = { .master = master };
+
+       arm_smmu_attach_commit_vmaster(&state);
+}
[...]
@@ -824,6 +829,9 @@ struct arm_smmu_master {
        struct arm_smmu_device          *smmu;
        struct device                   *dev;
        struct arm_smmu_stream          *streams;
+#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
+       struct arm_smmu_vmaster         *vmaster; /* use smmu->streams_mutex */
+#endif
        /* Locked by the iommu core using the group mutex */
        struct arm_smmu_ctx_desc_cfg    cd_table;
        unsigned int                    num_streams;
@@ -972,6 +980,9 @@ struct arm_smmu_attach_state {
        bool disable_ats;
        ioasid_t ssid;
        /* Resulting state */
+#ifdef CONFIG_ARM_SMMU_V3_IOMMUFD
+       struct arm_smmu_vmaster *vmaster;
+#endif
        bool ats_enabled;
 };

Thanks
Nicolin


