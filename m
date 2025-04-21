Return-Path: <linux-kselftest+bounces-31256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7720AA953AE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 17:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FCC73ACC22
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Apr 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22EF1DE4DB;
	Mon, 21 Apr 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtI1Dtnr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662214F9FB;
	Mon, 21 Apr 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745250192; cv=fail; b=JsiH3O4ggiOJtNVYYUgj4LYKK0ZDuijRC6tMFHTZwL7XbnpRtNyryvwkakl80mdnyMmNIq5uT3kfsbRL/WhDx5AD0x4TaceO/Lt2vVyf4sEma9V8+YFIxesil+Sr5nCzghiJtSnP6Pg88Xl/2zSUiR5w/Z89bJpi7ZiOL18ynj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745250192; c=relaxed/simple;
	bh=N0MMqZR2itPeOdT4tgz5nd43O4BO+g8WZrhohC+uDdI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9OgLAAo4R32u7/p1eA/cmgLvh5KoljG/JTprgxLAbW1eLHyBabo4IaTvonzDovDCppMWnaE6vYLpYQv4eStBqkbOkUZEOe2X8e7ieNGzcpZ427MyCQbeQ3V1TGGuS5NJkRe6b/B2hPYi+UIzT7fIRgUN0SKDOYonahwcl75db4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtI1Dtnr; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaaZPMVOULZFL6FLWjoTiQiVqhIII+uoaKba8BX9RNHp6OQIRiQvVvaN80IDI0zW9df1RI3t1Yah495cgdNTgl2YuV3rNxVTJzec5RIDlS5M9U7uxE60hsVSZIIF92UuBoueHpW1swZICAiy97YIvbfB7W5KxNLmEx5kTIOxj4kiSqJxfdX/P4Mfsn0mC3qJevi24pLAVf0gKeMneaXt5pSeuAuJreeO3PDDlLnneVn7VeUSwtpDgnSxtPASZPy/ogPyOpH27VE6f7PfLb1qDJBW6O56BP6j91CceWO6PEMFN0kyymchqMKKomk1QS/P5x/AyVlj94sBghgJirerXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TKqd7mWqqzRUirHIeediymt7eXLD2wLwsMa1eMtIac=;
 b=ia5lFEflD2uSgeZJfRko+2GJKvEmnsyW1QC8PH7KPMs271kgcL3yW4MbYQvK6Mzq4+3qer06EXoiedmM9yWsutu8AfscfB2egDeFmAeUNU81SmpC1ea7uSHC16LbtRj+c+4YfBWpc/kTqgMJZdWE2EE2WXQSeVupWClGrVSpeSEOX2LOGnRUFZEo1/+Dy9ECXT07yLdkiia0kVo0ZpJv+Yhz3TYeMzsIpysHjjnV0MIXQV6gWi8zbFum6qc413ugs49Rs11BMm9wZJ32XnIBYd5ykJz9f8himzC3GIE5IA/Qrs9yE0y0wMg5IT5TZKZecwOTqs58gaK0OohkdsJ3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TKqd7mWqqzRUirHIeediymt7eXLD2wLwsMa1eMtIac=;
 b=LtI1DtnrwB356m+3C3pUgt+9SfyXIZPjlQsNcV2qv55yxV6xF1jAOLvSmqxsrwUy1C87vPGwj6ObyjiiuCCqd18RR/bUEzdogEXyVtxEU43S1Nvpy131MICcWWWcLntSikBGT3mgjfeMh9Y+CuucBofc/NlvQw4+7BknQT7BbXUOQBcERG65c6VeBKKMISYEkmK9SLbZBTXBqTnk9OKvbNQuSe1Q9FPv7ft19KPbPKREPGWg6eU76bNhH4QnavQLoVG/ved2mLpB5ojmFA7xrh0ab7sOZJVF5JbS+KNZAT23mWhhJrWFkSMFr7cDW+Kts4wMQxks7fci2b0WazVCFw==
Received: from CH0PR03CA0217.namprd03.prod.outlook.com (2603:10b6:610:e7::12)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Mon, 21 Apr
 2025 15:43:05 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::bb) by CH0PR03CA0217.outlook.office365.com
 (2603:10b6:610:e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 21 Apr 2025 15:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 15:43:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Apr
 2025 08:42:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 21 Apr 2025 08:42:53 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 21 Apr 2025 08:42:52 -0700
Date: Mon, 21 Apr 2025 08:42:50 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "praan@google.com" <praan@google.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "mshavit@google.com"
	<mshavit@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: Re: [PATCH v1 09/16] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aAZnei9tnO8Pjy+d@Asurada-Nvidia>
References: <cover.1744353300.git.nicolinc@nvidia.com>
 <5cd2c7c4d92c79baf0cfc59e2a6b3e1db4e86ab8.1744353300.git.nicolinc@nvidia.com>
 <BN9PR11MB5276F362FA971F6A5861BA418CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F362FA971F6A5861BA418CB82@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 175c7346-bf2a-45bd-a437-08dd80eb3548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p/UYrMln642Rn3MqK76N0TXyosWYWo9WnVjbxLZEyCVhTgdxkv5jcrhzeBT2?=
 =?us-ascii?Q?FCbwZ+kVxAgJZYrPAA28YFUgkUIQP3IMaXUc5nkauwTjpmJ3+s92S/H1HUdh?=
 =?us-ascii?Q?uMuQjfujvP+acv+oWF6vPuci6XG1EwzYSHfhK36LG/BV5SeaGAtT84xxePNt?=
 =?us-ascii?Q?KaDab0SK/PaIOnTkHuvAR53+CeCczq6yLUSaWpb75wMAJzefekxsTpnbnGTY?=
 =?us-ascii?Q?6rt8iXwJJ55MZ63P4RrBvpDvICWep7RjA0wUhDXr6wqH0CpllIPoKqno/+bX?=
 =?us-ascii?Q?46JqFx46g/Rl7PXq8RtXfK0ta/+Jvz14uqbRelSQYVBNvRa25amchz6VvUSC?=
 =?us-ascii?Q?BxYQSn4rQEONPtpC+oEpPszPqTKNS8yXm4KFcLZrKZqmrgnmQiq0d+UnQxAU?=
 =?us-ascii?Q?VT8gMXo9LtPjMxkQTAW6tc4+jt9G/x0zt2VNYYvawGfqqnOIxMyLa9WiyMSI?=
 =?us-ascii?Q?WfuNkKnviI5PU8pVPRB8+rQrXgltntmxXWEZCV+SpCJF49AGBZTn4bHB48I+?=
 =?us-ascii?Q?vRA/ohEUnfgip6s77OZLedf/llr0cPfi7SIdlZYKjUzG18E5cFaKQOOPCqPR?=
 =?us-ascii?Q?m2qX6Egw8Iaky/pLXX7q+HvGpvczaMFG3s0olAM4cYKeB60dyFhpAMgwtqMo?=
 =?us-ascii?Q?IXeet8VX9prl0ge/1wKoFv3weBDR9qCI5RgoxuUR/oaAWOWrONeDVBJNH1k9?=
 =?us-ascii?Q?bZs1TzzqpFvqJMO8aMx3/0iYqCZJFyZkGcfuH5PoNB7j3GD81alP1CZIaWW3?=
 =?us-ascii?Q?Xr0PhQ+2Z4tZH1iSaudtu4KvgOtI0a8jfeY7Mr1YE21Zab+zkqaEWDGUlICf?=
 =?us-ascii?Q?MUH7BA3SFZEEHZsWsN50jjTGN2iWWKm7O4/Ba681/O+GcPhBvdlZrMi7N4Wr?=
 =?us-ascii?Q?C0tFENAdle0ThyBL+8Q4fm7OG4kHyS66CcBcFD6kE8uBLkakL3xp6rZeZVcL?=
 =?us-ascii?Q?r0vvIfeYWeYLdXaXLrTonFg8LYsuXjotqAlFAZEcp+dz6OAQRoHgdPIWVC2Q?=
 =?us-ascii?Q?fcmhz5NGyhUtZcpD4nSnArcvyZWX9f+zYOpaybyponBy7FTRKAe99vPetoxw?=
 =?us-ascii?Q?4g/9MYyKXRS50o0e0q2H1yDAriHSvcV6EeZE/UDNTRsnaDfVsHj+JDQgZQi3?=
 =?us-ascii?Q?/WQCcjTWU6o9S5p5elkiF3zmULczYm2Md0ZPZSLjVG2oJpwiEspIvtR1NCdg?=
 =?us-ascii?Q?/Bbidgs9WNmgtkG4OdyQTliQdUOksBRq9wuEuVi3+Q+bu6xINeyCdPjIPS1c?=
 =?us-ascii?Q?CueI4jzzictTiMIYgotYTY00/2pITYRx+iE87baszHH9nUS+0DfUzZO1ExJL?=
 =?us-ascii?Q?NLTujy3W9uq2/45QPCmXgr78M3ARdYhX39sQqkvAaILuPp+bFvUYXVDu5U6v?=
 =?us-ascii?Q?QU53LByfI13Ui3TxxaE9gPgoh7SkCWeWEBBL09j+5+sI4ecEDlAYP/iOZqD5?=
 =?us-ascii?Q?SIT3WtLDlM0jn9V6DbGSPOJvTBmO+0qAjJLl42p9S7xhkVzNZV1t5JcEBTSf?=
 =?us-ascii?Q?pdpcvtqNv55ycUs64ohopCGr7AnmdXV/NbWV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 15:43:05.4653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175c7346-bf2a-45bd-a437-08dd80eb3548
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

On Mon, Apr 21, 2025 at 08:05:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, April 11, 2025 2:38 PM
> > 
> > +
> > +/**
> > + * enum iommu_vcmdq_type - Virtual Queue Type
> 
> "Virtual Command Queue Type"
> 
> > + * @IOMMU_VCMDQ_TYPE_DEFAULT: Reserved for future use
> > + */
> > +enum iommu_vcmdq_data_type {
> > +	IOMMU_VCMDQ_TYPE_DEFAULT = 0,
> > +};
> > +
> > +/**
> > + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
> > + * @size: sizeof(struct iommu_vcmdq_alloc)
> > + * @flags: Must be 0
> > + * @viommu_id: viommu ID to associate the virtual queue with
> > + * @type: One of enum iommu_vcmdq_type
> 
> s/ iommu_vcmdq_type/ iommu_vcmdq_data_type/
> 
> > +int iommufd_vcmdq_alloc_ioctl(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_vcmdq_alloc *cmd = ucmd->cmd;
> > +	const struct iommu_user_data user_data = {
> > +		.type = cmd->type,
> > +		.uptr = u64_to_user_ptr(cmd->data_uptr),
> > +		.len = cmd->data_len,
> > +	};
> > +	struct iommufd_vcmdq *vcmdq;
> > +	struct iommufd_viommu *viommu;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_VCMDQ_TYPE_DEFAULT)
> > +		return -EOPNOTSUPP;
> > +	if (!cmd->data_len)
> > +		return -EINVAL;
> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu))
> > +		return PTR_ERR(viommu);
> > +
> > +	if (!viommu->ops || !viommu->ops->vcmdq_alloc) {
> > +		rc = -EOPNOTSUPP;
> > +		goto out_put_viommu;
> > +	}
> > +
> > +	vcmdq = viommu->ops->vcmdq_alloc(viommu,
> > +					 user_data.len ? &user_data : NULL);
> 
> the length cannot be zero at this point due to earlier check.

Yes. Will fix them all.

Thanks!
Nicolin

