Return-Path: <linux-kselftest+bounces-24404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15E8A0C22A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41783A1EC5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934341D5144;
	Mon, 13 Jan 2025 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLkddGfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011401C760A;
	Mon, 13 Jan 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797996; cv=fail; b=KRQKqV8gekWJddZQSnu3PyEcuRL5gzNzYz5YwbLBk9TlRy+ORxmzEGj3VF1D3yEjGCr062Q2ftHpI0UetkPg1vSI+f2cvqbeX25c0xuEMOv1HLr+0Xf4JQ0dtty9hCVgzvIzpahmHQwRyHtNwediaI/oTU/oIRZ35ZHRfY7/bp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797996; c=relaxed/simple;
	bh=Fh+xN7rtbIIWq5E8sffWI5jtkkGEI+lbOcONcltTArI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMTJtwdJKAN3rR5ofmiyjcBgBCDo7WTnqjjnC9KhFU1dh0Z9C54eH7H1xdRm1Ak1NAcFPDM/D/Uuv6X8oNKWJQcuWchJvvQ8f0pzClnRt5Gk5ukHuh1ocMrW+Kso+wJ6eTDS65hXDEg9ssICI7zYRZLMgUnlsDtVXDGRiY1xx+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLkddGfO; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeRrtVEOg7Uua66Ik1cjw40G9deo0CKV449bP5ws4b3HHDJud8OmMRum+uVu6wdX/wHbjhX6qwbSlbMfj+B2ILDB7nXXokzQO7sR88wf7OjBQbftc5vATkxEtrSabq22+HLJ/dRUCc9QP/ymnbLKbgZBL0P3DzC7F/FhfeZHB8eCxxTXyarwONY8Bx3ubix1nysaJ8+n0fC2cHFDcLel+bQ36MQyhx2OVc1VbGIcE1K8f9/FxO3rGrA7zxaX0OQXui8JDebQuPpFl5jlzClO44R58vaasZw45NUfjrN99aD59fdzc1zexqSoF7JudR5oJI+59ROkPAmfiipWRma/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOLFhW+nTXVL7BxhdMvJBuznD8Y+66coDXImfXAuBI0=;
 b=Cgry4Mbz4AWdHLxGD4n2qjefh+i14RIb8fOvj2dZktucJJBspjSWUaHR+JlpByqPDeGQnRZr4uqa2Wc7inYVm4WpUmlTbL+jHXAHBEAfSSDIBNMG8l4kML0knFWmN9HWlxK3iB8s8b7zV9A5S7bMh20MJvrF/tS8++6xRod98BuYZltW8Q11hxv2noljpu/x29pLb65Hbaa/0JQL0HqXLDOz6NtmfCGkZuB92KKe97vjrTpMb6UN1ebcmbi9IW4sIgfQOHzAHEMewz0SVV3t7yWDQUuFvgttiKk/RsVH7tEty+2ccH7houmD9Vf4aey04SElR6XJytSn42uvIx8teA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOLFhW+nTXVL7BxhdMvJBuznD8Y+66coDXImfXAuBI0=;
 b=SLkddGfOSh7Kyvaxvugx8VbKvXI4YKdhoLE1KA7Foe0tL2NXlHvEcymDjKS/ccfNPQt5P0/By+vOglCskKWXS6nFlgn8dwCtFaxhWcqzmrPXkgCJZrIFcucxgROC11f0uLqf4rhX/KlV7c+90Kzqu1ohvVirO3GoWTXkhBX9SZiJRT+5WMuygtizZ94RShv97B+3apuINJMOFA5+WQPRoXfb0P9URvqUqqcDpmNg7zvvyMH2z4lBpc1zr1zum9Zs1sL5ngY3c3ulxREicJzPrayiqspJGAi0UVWEblsKzWJz0h0NlXAtM4Wwr8D7nXth/lE3iPg+j8hWK7JPCDl7Qw==
Received: from CH2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:610:50::22)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Mon, 13 Jan
 2025 19:53:12 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::b8) by CH2PR16CA0012.outlook.office365.com
 (2603:10b6:610:50::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Mon,
 13 Jan 2025 19:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.0 via Frontend Transport; Mon, 13 Jan 2025 19:53:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 11:52:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 13 Jan 2025 11:52:59 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 13 Jan 2025 11:52:57 -0800
Date: Mon, 13 Jan 2025 11:52:56 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 13/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z4VvGIYtbCOj53qf@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <115d6015219e5850ea49dc9f1247f9c3eb515770.1736237481.git.nicolinc@nvidia.com>
 <20250113192927.GJ396083@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250113192927.GJ396083@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 37eb0476-a2c8-451b-b36e-08dd340be767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eR1EqBjs/rI+xzDFpsoeAGa8JR5XgkH/vSjGkCI8TqoUiQlOR88R8/EMfLF7?=
 =?us-ascii?Q?XlajTZphRSBqOUv1C7psFnnOxt3vJ9HmaqTpMbf9gyBSY6vVZzTaABAPWVoP?=
 =?us-ascii?Q?QGrpE12uN8lTOAVnRgyM/cntKUoUnIiOJDVIkCxjpdwwH2gTxqVPfMaDGEu7?=
 =?us-ascii?Q?Q9R5WN3jAwGiJ+q2NGBibHoPGRQGDmpNWPEWUBETNNrPiTYqxLILTEm7F0Pu?=
 =?us-ascii?Q?7Ss/cGnO9v2ppS4F5Q6J1diEzfFqcdK7bHK3cpuIdISkxiGw3ac+EOmi+iAx?=
 =?us-ascii?Q?s3ZviuKkoRlm5B8On31GMuGqpLtiquZEVMQ4LZMX2Ay+OKGb9cR1oNtA/Mnv?=
 =?us-ascii?Q?zRPJ0Rq7kW9kLdHTGqLWzNGfk8esCVQlss+gmcY7OiLa1uraVNMVhw99ynrW?=
 =?us-ascii?Q?yGG9GAZc1oBBKXb62dOR06oK9METGV6tdMKPFGTsz1ZM53akk+HjXNIvSWwH?=
 =?us-ascii?Q?921Bk+ppESu/NgO7uy+sUpxoHG8Z4TLKWcEovCoy0lzE0FYlGLA0o2a2Txnq?=
 =?us-ascii?Q?jluMeWu6CmZopEtfRZq23C0d4efRYODDk8ASC0014xVaxYHcTCXBmQgrQygC?=
 =?us-ascii?Q?ar3UZAGArVO3+I3FLc/AxEw2zIr7FTrz2/cK1lnHSs7imQAEqguxOoQ38kOj?=
 =?us-ascii?Q?0JwJ8fOM7pdZPzNqpFCGn9ChNruC31ywhdKgNR8SzcucueTA2P1SPHvbxTj7?=
 =?us-ascii?Q?nZtI7JG0wrQuZjyKxVjAAsW7BwsX5NJt/zzfl8bYUVOcPAZxBuS5A4ih8puu?=
 =?us-ascii?Q?76lVLQXHCneQW4eX+2QM+Mvq/BuLujonttZImOxQsKx7Qb+NErXvttMscRZs?=
 =?us-ascii?Q?v6drf1k4qf2Dr/Vwh1qhnwTX9KsLS0rh21BqHv3TdILzMYRNlivsPUFgFEZN?=
 =?us-ascii?Q?4T530gl+VR2hI5hUD+1KjiWsunRKIoExb9JVY1SXlaoBdHwKs+3Ghf40Vsob?=
 =?us-ascii?Q?JRf2pVRdtXfpTRyFdwshgILnaHD30LXAtrRDubomTX84j6rFJokSVDbFebPj?=
 =?us-ascii?Q?Xn0TcUbyfMnWMWmZzTqm4k4AZCZr918ip9rUMheHNoLYMYvM+LwOcB+cza9N?=
 =?us-ascii?Q?WCUZ7oTfqkoUZ+BM0PKxeIlGa63L9klfMo9ajQk9k2HJbZH8mlMZSs+hI3g9?=
 =?us-ascii?Q?Lc2vQ1wFAYP9mpa37mYSj2WKgGHwsXLvWGjZnC1VNoqCYW0Tf1qSM5VAyw5O?=
 =?us-ascii?Q?lyFPvbrmjlqyvYQcmwCJzORNjGhvxzp4JtJZeYpLwoKFpVlQB9Hl3sQZCz3Z?=
 =?us-ascii?Q?C77a4vuwbuKOYEDp1kD5GtelnFVh4hUdPXRSTbiZ5e8dAHoO2ljTyLRgQfqU?=
 =?us-ascii?Q?Uq44azfxk787uV+/5st8cjdBRD/iXG3SyVKlOE+DF4PnKp8yvoLnLHNIUK5b?=
 =?us-ascii?Q?+jQxqgfLtfpOtxwTYUW2nul6gDosY9ty52icRsDz2h/MGaFE67tTu13SoVyS?=
 =?us-ascii?Q?x5B70m3vtbv2sV9LAiX4KJou2G3iOK+3I62TvPKmHyvzJUg9but8UZ/wwhQX?=
 =?us-ascii?Q?FF932bA/FQjXtX0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:53:08.6689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37eb0476-a2c8-451b-b36e-08dd340be767
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156

On Mon, Jan 13, 2025 at 03:29:27PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 09:10:16AM -0800, Nicolin Chen wrote:
> 
> > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > +				    struct iommu_domain *domain)
> > +{
> > +	struct arm_smmu_nested_domain *nested_domain;
> > +	struct arm_smmu_vmaster *vmaster;
> > +	unsigned long vsid;
> > +	unsigned int cfg;
> > +
> > +	iommu_group_mutex_assert(state->master->dev);
> > +
> > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > +		return 0;
> > +	nested_domain = to_smmu_nested_domain(domain);
> > +
> > +	/* Skip ABORT/BYPASS or invalid vSTE */
> > +	cfg = FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
> > +	if (cfg == STRTAB_STE_0_CFG_ABORT || cfg == STRTAB_STE_0_CFG_BYPASS)
> > +		return 0;
> 
> Why? If the VM sets an ABORT vSTE then I would expect that any
> protection violation events the VM triggers are captured and forwarded
> as well?
>
> Basically any time a vSTE is in place we should capture events that
> are affiliated with the SID?

I see. I will drop this.
 
> > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > +		return 0;
> > +
> > +	vsid = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > +					  state->master->dev);
> > +	/* Fail the attach if vSID is not correct set by the user space */
> > +	if (!vsid)
> > +		return -ENOENT;
> 
> Is it really OK that 0 is being used as invalid here?

Hmm, perhaps better to do an int function for -ENOENT. Will fix
this.

Thanks
Nicolin

