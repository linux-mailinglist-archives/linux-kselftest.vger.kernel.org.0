Return-Path: <linux-kselftest+bounces-33682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70286AC2B46
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D77A23D3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E751F582F;
	Fri, 23 May 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oT1uBqdL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFE29A0;
	Fri, 23 May 2025 21:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035070; cv=fail; b=ez3DFgQ053NLFkBfU3ka7bpj00+AejFn/bJaO2+zDbo4po3Ogp1wIKF/wqwOYWYdn6q/k+1pepdcgigekRCgbHe0TmEzWsPRqBSQVShvg/TIics+kVRdNyKvg1a0mNhpDCzYeI6x82668QtyTPdhEZLT/Jw3wk1sBf81lS2l3VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035070; c=relaxed/simple;
	bh=6oXtJNUEM4p2eHi8v6/upXfaMGkyJspjBVKgwSFKpFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW2wnWGPOjhWQhOHFkvsWjGUsh3GzaSp+GNxGu8mewonrBo0iM/pGZS6l51TrvTOs6df6cvvvSNLTBZxjAFH9XVidup29Udy6u3jgZFzmLaoBeftFIGmxLvnpPb+e0mEYR5vv48CaV5Bpa39HQrNXa2Of8qdWrc41xQ75EBZB20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oT1uBqdL; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEgZdox6CWZJs6j5NaqacBdiFa4yoZxYcLxyLnxQcX134wzEhQfaKdZrd0MQs3NcsvaGyqmMBkMouSRVHdyCA5aG84pjrC/klLjGzFJu8Wvd89R5uoTpJKz70q0CQor/bZMPqjZr0I32+NPXyGbGs/5ysxG1E3RUbGl2DBng863dQM0S1lgSlW3GN88RZC7AlIEfn+eC+6bDdXkFqG8uhyoZZcU6UvmEtonV3OAHUYxrZydhqkcnPYmc7NamYSWl1RoXK5/C+A92i4Sd51JdtPQokNbHbLR+4q01bu+zqqLWupumE5LTrkoD2b/toUzeX0LuSvdIyKrE94hsZGHzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVeyY/JTasKpZ68J8KNVrZWeDLm4NEUigU3f0TSAdns=;
 b=D84tnXvhQFtxkTL3NUzTdc0O6f3lLOMAtYJWDSBT/GWovVR5Jx7dfCu/GYGMAxyuJzwCdzxBAlUnZhtt3/ubZm8tjDLZH5BMgu54Or8pEKR64rfCsG3XCkuNxSVLajR29SSeRIMUVg1Zq6OnQ0WfjDw+1GTGvHDNlMER9ahesVrxAeF00CyOTUmGr67SG1E4sMJcI7FvTgtT04F7zRy6YRSTOcIjhSRPnXo5HhSFb/mctQ4Kr4YBZiPo2n2aYVCI0cY9DYVmGPMzwsxcZTd3p9+5v5uca77kD8eKdeiAysPrQq6l58Ixlg9VMipBX4yCCggL4Fvryw+XWOzGPShT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVeyY/JTasKpZ68J8KNVrZWeDLm4NEUigU3f0TSAdns=;
 b=oT1uBqdLSs4GTyTlmp5/DjRLoL3/6Dz57VUCNOUv1DpozGUUfC9Y/FE+95MYVMrSMWJzzG7fMcIaJCH/3ir/itWoqmdZb3EepRzWeDiteh7tqEHFk1VTXXxTMLmyFr0mRpsNYuuy3R68vazzdmTo9rRVSEzrC7lNSG+0gaDl5OU29eE7wZ83lNiDMVu1jEM9RmthcfbIX6MZ9A0BDsFsR+k8KrjcCV+7i08/F6wjXyrN3EWkacqIoTtZNFL0wCV+Q3i57f/0RuA21pCZRY5lHTLM8dlXecalU8Q3h2c76zfNo5YZWvBRBPaud8unwY9kQd8ctZunGY7RNvPPkpGR0w==
Received: from MW4PR03CA0131.namprd03.prod.outlook.com (2603:10b6:303:8c::16)
 by SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Fri, 23 May
 2025 21:17:45 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:8c:cafe::7) by MW4PR03CA0131.outlook.office365.com
 (2603:10b6:303:8c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 23 May 2025 21:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 21:17:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 May
 2025 14:17:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 23 May
 2025 14:17:33 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 23 May 2025 14:17:32 -0700
Date: Fri, 23 May 2025 14:17:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "bagasdotme@gmail.com"
	<bagasdotme@gmail.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "thierry.reding@gmail.com"
	<thierry.reding@gmail.com>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"nathan@kernel.org" <nathan@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"mshavit@google.com" <mshavit@google.com>, "praan@google.com"
	<praan@google.com>, "zhangzekun11@huawei.com" <zhangzekun11@huawei.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/29] iommufd: Introduce iommufd_object_alloc_ucmd
 helper
Message-ID: <aDDl6+HpkzrxQH27@Asurada-Nvidia>
References: <cover.1747537752.git.nicolinc@nvidia.com>
 <4cc3e95520bbade9004615d04fdf5624e0b2d51d.1747537752.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E1932E77354694D45C678C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E1932E77354694D45C678C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 084b79b3-fa98-418d-8d6b-08dd9a3f42bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lm+5bf6VFZmGaXXP+HxWhM9PcXo62Jfm4uQ/mE7UDaaM9XkkT1umCbk4rBEI?=
 =?us-ascii?Q?kP+bEOWa4Q91++HVT+JJx+gqI4ONjoEH4dTEuR+3X7XXgLd4FJuER4rKiW6K?=
 =?us-ascii?Q?ppqw1/auyxttVQNTL+1AIyycflh21EyIdQiJcQgaVOKKT0FIP5X6hqhiLKg8?=
 =?us-ascii?Q?DhVHr+gqBd+G5aurmmYEfvta6O76QHPUT/Y0PtRpwcpSMRj8qX3K92uVVuLD?=
 =?us-ascii?Q?UTyF+JZPLaZp1sJm7/wYsM6Kduk2mBrds/FYiRyJVjiB3ih9JLRwEABdjtoQ?=
 =?us-ascii?Q?ztWpkvGm94CDsHJCQRN7AsVoEQ4d2NW08HxeSKXLa1HqCCT+EK8lBFQiAEOM?=
 =?us-ascii?Q?JPLxeNy02GGxtSGkPASIJozj1xaEEr5+W0H8QWnsALREPZKuJxvn1a+1y1yt?=
 =?us-ascii?Q?wpIDC30jSoEsJ88I9AjKN17HSyw5dOztxjZNq96baGu3vHbAf0RnuntPQFmS?=
 =?us-ascii?Q?sVm1bDilb/QkOwcRYe9r/WeDhQsxWzr+FyFdbQSBHEnAK6GTO/DGImjGMZKI?=
 =?us-ascii?Q?zaSfyoU9hop3d2mtc9g+JSoHcn3lRrQDcdqZifWwpF8nIOQg3iH31As5a/b+?=
 =?us-ascii?Q?UmHMQa6KRj9Eoru4wGUfdFLVn9vILcUWILNdgLUgRjviN8X66T846/brqtop?=
 =?us-ascii?Q?YX2pyrhVShxtu0UuzZjDeyZ4VTYg8KXvjaJTZoUdObpDXR5dMZiNJymjQgss?=
 =?us-ascii?Q?TenQcRNd05GOvcF81kPX6ycWRR6waGteEMQF2sgUaEDjZ6y6nc3QwJpQhbVK?=
 =?us-ascii?Q?QkSypBiqDy0qr8l63q2RoJOL2ktqGlQawElVeqXh8R1+grv1/9QAu+tZTxP2?=
 =?us-ascii?Q?o3y2klQvXaTVJOIl6Cr9+VEU8fbc3o9eQ6ERTUWF1rxlIIAdrlcrUGMmMvH/?=
 =?us-ascii?Q?f3bgOIgqz2FwYhg6gnA0PII3wggIvzjpWCotDgkPg6L9rFOQck36rT/iToih?=
 =?us-ascii?Q?CaJiRtEPBs4Jp/W4DzzNJGNG2m2Id9SRdca16SXBQb0k58b0MyuVWcyOxJ58?=
 =?us-ascii?Q?blfQMjVKiOtPMGoggJ/R3Uf7Bj8/mpFg49AnPAs1B1qhLaBDXWyOivYQ/TcQ?=
 =?us-ascii?Q?mHDtxLxb5+0Cdb4beB9aqBvh5xHQCTvQwUNrx/Wgi5Mrs1rXMLaRR6VGQqHv?=
 =?us-ascii?Q?CSOLGeMGdDLNi04SHZ4iZFtO22tXStmhQqrNceT2vfa9nRfRt81i7yGVXWV1?=
 =?us-ascii?Q?Dlhu58pVyp9cC4hbwM44O6WGovZelgxMa5xUrVhOoOjDoVlOgEgohZ901AJq?=
 =?us-ascii?Q?+Nc0YpmoU8njdIYWd5a8q5RNoRhgOnMkD2WwZRBJILFXhmOy8ML3CHXJUZEA?=
 =?us-ascii?Q?23OKVbvOvMyExvmqRII1NHvv2UXxU0A52hz6u0fKXpmDtWURsofxISTJgvDo?=
 =?us-ascii?Q?CTaQBYjQc4wvBn9JuKM+PmabY35ZG/11p2atc5X+sMB5Ea1Q22KDOJeN4mta?=
 =?us-ascii?Q?Po+NQLmSCcmpqMwr8ApoGaTO6qhLIb820kaVNRWtkzDPBCn7MYH59ahkZdnb?=
 =?us-ascii?Q?0gzu2edO5Wr5KN1TKCEHOnWqYy/k39+MFGph?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 21:17:44.9417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b79b3-fa98-418d-8d6b-08dd9a3f42bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

On Fri, May 23, 2025 at 07:46:13AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, May 18, 2025 11:21 AM
> > 
> > @@ -135,6 +135,7 @@ struct iommufd_ucmd {
> >  	void __user *ubuffer;
> >  	u32 user_size;
> >  	void *cmd;
> > +	struct iommufd_object *new_obj;
> 
> Could just be called as 'obj'. but not a strong preference.

Jason named it "alloced_obj" to clarify the purpose, I believe.
I picked a shorter "new_obj" while keeping its purpose. I think
I will keep it in this way.

Thanks
Nicolin

