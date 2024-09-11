Return-Path: <linux-kselftest+bounces-17714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8249974AFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 09:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F6DB22246
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 07:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C62130A54;
	Wed, 11 Sep 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DtGcCTR1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B813AA20;
	Wed, 11 Sep 2024 07:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726038510; cv=fail; b=RBCuwsUmVtW4jHgpL5PSxvYx0s5yvkrdvpjeKjFXtIcaBQ2t6y6IgihgOgkVMAmioh8gX8yLHVR/jAk/lCqZjxWxYjeoychGFBfOJHwg9G65sczM/pv+5qqKN8aeyiCKLNeh6FhXJnuBGrbLFUaJWtcrmYeDpC2epCaPJRBAx58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726038510; c=relaxed/simple;
	bh=sd95g4j64dfeGYaoIC8bzNRlJdjlB3sxNHATTX6iX74=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOGE4wLCVH9Eud29z7eljAbXSQYvrmO55UiMTpwze2f1gTRcC7mJQFjqE3LeWryxR4Wf/qpBl5yM530tBtQyEfPoJ5cgy3zfkndSTkiWRQbiAiklsMk6Kj1jNKrQUIYFH43TIMQlAbFnkTl9LaTc2sRtTHK4IBlw2RnBpiZRxi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DtGcCTR1; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVBVHjGBs2jbwxRrMqKmu4zhviXY0ATPVhRhYVnvs50ikqE5dtcnNHFV6St4TILe/KaY/YKcQdX0FMRLbhE2BlOvvYwazOqM3990ACSSbiWTGJEcPJNUqt9E+DHRdCxRwZYr79iv17P4vW9oEMu7ESSfnZBgUtnbS4SWXjYt/uyhcwtwz9D74ydRRQFehoxgCTEDmFXoBfUDec8zrsMwBldU38h3WbGIOzCJxgf2hDyYk3UlU444ShxYHzwX1HUx6olA9+Myr7IDaOFzi86fe1BnSEgfwprhkL/RpWnnJf0vEwCB77cF9n5zyjxdfm3k1Ne1FbG8lYy8O+e3QFWdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vowlUdiqIpsUVMjy7bT+i7kGwuN5c8biAO4+oKvqvBA=;
 b=tlxwxkIYi41vvxpRIx9fd7wV7ORut2CJAIFzCiLQW+EZZduDs1KeQbJVnPZH0ZG/spXIwCGt/GHSuwGQcHIpRXwnhX3DOg5iSc91o5aLofEGCY7Pr+kaIjGpK8kG7vCBgdmQ6+JMvMTOSqXi5T/mwSL5uD0cl3ELI+r9sFlslAxF5e00bxFjvRMIqljBXfAtPZIzdAn1CeK70gWMeQStTaZEyx0vuVSFbIM5B2rotfGFG16YDEPvZfzuK1olgaYfIf98YP0jJUBS83F8FUvuif5zaKmatNgDTiRFq0H7mm6bzrWuVqbozUBrx6Po8sbxofgIO2WYNfvVswNQdDeMQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vowlUdiqIpsUVMjy7bT+i7kGwuN5c8biAO4+oKvqvBA=;
 b=DtGcCTR1sQlqMiPZDdmwyRypK1sCq+p8NrUx71E619TNdM0l/uOvYq0w+nZj5MP8IXrtK0JvI067dNOo+C1r+70M2UuHjuj94gWb8Dkp50fdb2lFxnq0epae0Vw+NaPbo/p11IM9rh6ALyFvzldgm/UwyYtZmGFBv519rzM81uI4QAueC+4jzRqK6yG7sOxz6VA4NqKM2M5KqENhlPvS8suURXGtBVBh0nc5TRajU5UrmuoU0r7ztMbeQbwWdMBNSTPGpjwWfLKjIFvCiqT4hNwobr5rebMLmHfEP9EHY0kvGA9b+1NiP7IEN9FcCIgpBBpzl2f1Jx0uqxh6uOUCZA==
Received: from MW3PR05CA0027.namprd05.prod.outlook.com (2603:10b6:303:2b::32)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Wed, 11 Sep
 2024 07:08:24 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::f5) by MW3PR05CA0027.outlook.office365.com
 (2603:10b6:303:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 07:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.0 via Frontend Transport; Wed, 11 Sep 2024 07:08:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:08:11 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 00:08:11 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 11 Sep 2024 00:08:05 -0700
Date: Wed, 11 Sep 2024 00:08:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "jean-philippe@linaro.org"
	<jean-philippe@linaro.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <ZuFB06X7ZTg6ZhWT@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271EF54689B9666360A0F188C9B2@BL1PR11MB5271.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 800da0db-0f93-4579-419a-08dcd23086be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ssRtepI80JNOnigLxVtIAK6B5OFLK6Fa0wnrYqffUtNiw88NmFqHtlGZa+t?=
 =?us-ascii?Q?hbySo6I/QLBo6Oy+lVNFUyh3UKnjwN2env2PdUxfq7z8a78Nq21OXC7EMAX+?=
 =?us-ascii?Q?2d4H0FZRFq/c0i7EEA4nvj9Ec1jUYUa7jjdk5b5xR7vRS/xUUKi1iSG7CWbV?=
 =?us-ascii?Q?4/AAxg0Xl/hvdNWVokNSiX5obpeaweBTdNHui9rtlLVdBPnUfH99tFuhH+FJ?=
 =?us-ascii?Q?W2NXuf82s2J1pdhHeJKFRRjExejoZ3yz9MSd4Qs3Bqr92VmPPT/k9FzwrwKh?=
 =?us-ascii?Q?4PpbW8xgBQIzXzc892wJ8wHcn8g6yzKDIs8061RLbfkrj0lnyMQiF+kWH2CS?=
 =?us-ascii?Q?IXslkxxASzdc9aTRS8vtTl+flAJ41BMc5PsJwYrgNEqO6V2peadfYmfWfUkg?=
 =?us-ascii?Q?Q299ykBoa8GsjkKb7guYX73LfURjCX/kwyF9R6s8xWAMDXBIQhhQ8vqmGcXZ?=
 =?us-ascii?Q?LakL2ghFkhkXu/ZEX8qx/oaLSmkoFa3rBVUWDgt2Sz3SifveLvHQjURhpjsl?=
 =?us-ascii?Q?PylSoYxKzyh0jpmYuqaBh2MeOqRTOjo7HH89YtOTDNJsFV++McbxsSDVpONl?=
 =?us-ascii?Q?K4ZAZs9D/oQ7nvg9GjT+UzVnSIVobK6fFAuJn9RBphZcaJlrTKNc4yfuoJ6x?=
 =?us-ascii?Q?7Oa2TQVvwloFKpw4MpvXuA1kOlQVkFgdGFqSsVr5nGAUyWwIUav5QAfCp3MP?=
 =?us-ascii?Q?2JWcLOZuVy+hOhH0yoc+JYVtd6juETGnK93Rj+Fk8yhYOE98eRb7npkcdO7F?=
 =?us-ascii?Q?0yf1p/7sWVmw4yyBoaxflOMrEyfL7KmR9YQ+E9sBNwcga31j6ai0Rh9CBObn?=
 =?us-ascii?Q?oFPHkrPn/dRinlFKkBkDOpxD5guxzd+nbaTHfHgQP8LtPQnP04uUAmXf3YjE?=
 =?us-ascii?Q?5Y5PVvCGnO4KPYJEVIF6oxmntClYs/qId9QOOx3gfW173sOgqO2X8OlwJjgm?=
 =?us-ascii?Q?xrUWTtpfCph6OUmnE93HHQUk9jZ/8T66U2ocRQH1pfdLlKgD9fuKIsA8MPNO?=
 =?us-ascii?Q?rWIaGrCEp91ZLN36qWjDzkAeI6o3lnY0nV76MnacBE8oYWkIAno49Mty31dU?=
 =?us-ascii?Q?bL3ibhIJGY65oULrz5/RwpT+s5uhw1g9YdZJuqs+50bkRYD4pLTWMJSZFxq3?=
 =?us-ascii?Q?IB6hxXO302JEPCN4B1g3x77ekTdwUcKH6xyg9fMS2tawr8eSiDpY4yxkmP1i?=
 =?us-ascii?Q?dTjm2GMS1/3yInH2oVJNj+4UebG9sYAt7TgG6Syw1RB8x229/byITwPkpPGT?=
 =?us-ascii?Q?c4qKCzY9jkkYJe9zgf4pfT+UZs2V86Brwsh+MBbQ2SMmp50Tugj+cn0pFQ1O?=
 =?us-ascii?Q?hQUW7tn1lQ+M0/Jjl3espoHzxKFW58EIRAUz2mwpS3RFW5qolya3YZYJMz1E?=
 =?us-ascii?Q?pkvvRR5Nln8liGNBY9XMKYxCHSNLWuV/yb+k1zF0QprmmCJvo263an6CZAVv?=
 =?us-ascii?Q?aTIFroALwpBJ27Kn/K0eUCYwyfc41Z6s?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 07:08:23.9865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800da0db-0f93-4579-419a-08dcd23086be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

On Wed, Sep 11, 2024 at 06:12:21AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, August 28, 2024 1:00 AM
> >
> [...]
> > On a multi-IOMMU system, the VIOMMU object can be instanced to the
> > number
> > of vIOMMUs in a guest VM, while holding the same parent HWPT to share
> > the
> 
> Is there restriction that multiple vIOMMU objects can be only created
> on a multi-IOMMU system?

I think it should be generally restricted to the number of pIOMMUs,
although likely (not 100% sure) we could do multiple vIOMMUs on a
single-pIOMMU system. Any reason for doing that?

> > stage-2 IO pagetable. Each VIOMMU then just need to only allocate its own
> > VMID to attach the shared stage-2 IO pagetable to the physical IOMMU:
> 
> this reads like 'VMID' is a virtual ID allocated by vIOMMU. But from the
> entire context it actually means the physical 'VMID' allocated on the
> associated physical IOMMU, correct?

Quoting Jason's narratives, a VMID is a "Security namespace for
guest owned ID". The allocation, using SMMU as an example, should
be a part of vIOMMU instance allocation in the host SMMU driver.
Then, this VMID will be used to mark the cache tags. So, it is
still a software allocated ID, while HW would use it too.

Thanks
Nicolin

