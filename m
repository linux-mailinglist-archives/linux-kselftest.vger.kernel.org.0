Return-Path: <linux-kselftest+bounces-36359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9DAF62EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 22:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4675B7A3085
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72A2F5C2F;
	Wed,  2 Jul 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d2sbH4OX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5D22578A;
	Wed,  2 Jul 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486401; cv=fail; b=WUtuXwViSGtxnXScjkGKC76oyMQzIjk/vSzacfEilQBrDWiZkaEW/WkHosYlpeifgY0celGtzosQ0uK1w/lUhFX44DX0QhonQQL7KyQEruXse7efc5nqyffyD5qVLI86L2xtpM9qErPcx4bFf0doERAbWHq37eL8l3CRppPgOG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486401; c=relaxed/simple;
	bh=A2161jCx+rHlYh1SqWBiufkR5fUCJckjYtPibxoKbvg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5sq8tgwADsQtwrQf8FSSl8xhuZayR0gDdBWnDITOtIhCVK7cwYUhzFLqRstA7H2/gr24ulqhjwXQYw40daA9NtvhPQzq9Y3c62ySwQF94umFJ1xOXJclP+95bRhuXrsEnBvxAu40mpyPY4w/LQcSVeT1KjWDwqjrrsxvdFyDls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d2sbH4OX; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQnSrEDT9Msa+i5D4U56FfPg/EvmBkx2NHY3iQ2Hp5ftPG6ycMvRqHkO/FGL5tbJ3e9AVb8NX025Cof1ZUkUnPHkRlbFMZtzCUyk30bOnldRZVqOuFjj74non3YDphlyMvfygwz8F8ilpNwbB0I74es1bMDMhEQ5QIYX8s5t+1CWelHLHmhajC46P6AF5mxal85Uypd4ImlZVuDxNQUpJYuSwCqiLgbNgRrRPoZVvrJUiX4bhpDTrFpOqe8zwAyZ51cW+68rsV2C1MK4fHU8IsUWntgo+ebkxK1NYMJahe8Djx1epfDtS7FGFg5j69oh2mXdpGi0DzYDoX3tCh3+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQlbAaO2/24slCTjg4NQFYj3zkSgI583kd7LCwPUJBI=;
 b=y8oaunn5AyOvrh+4oHdnH9AvkTv+c/YjVUEVh+Bwa5kFzt5UtUJ0pzSCsOwdxGwQlMwBtzj2wSIQ74Tqka6PPgqHc5EFG9rO5ndeKb/NFscYQZLtGpSR5dxyDoBIYjoQz6pGIRALny7waWOZr5jiuMp/E+ylj0fVWkx7EskdEkOHndncblNQHqrpkI1dNKoCBf+egdJwFZSUilnyZ8JspjT01z2I692smfCBSYd1StSnSvP7xL7CI4vtjA1bQw7oLzWajWbmBoqBGB8OlG6+HKUFIkktZk6dKmebJYmtNeszqQwTX5ZedK818XsEoLwlr5XANNSgcD0kdz5Sak0vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQlbAaO2/24slCTjg4NQFYj3zkSgI583kd7LCwPUJBI=;
 b=d2sbH4OX73ODV81s+HEx8DgBwumN5IbrBh0mOyPIGlZncF42vZJ71lpXh5X5E+c+v0BylpAd5FUTnr24hzcnxJg5HEDi5FlQyx/7sGkdOMKi/dL0FMc8mKg4AUb5SX9KdqCEYeO2Je32+k92Rweo4j+hQAVYI1pI2lI7vuZjfWP3MhgcSTz/cxlW5l9WbULY33hZ5EmkhB6Osaz0JgLtiCtQhYJkJSmOhq8NINiyflbqBihxfBSb4Y95zj+CMt3Tn4Pgfg/z/u7Fpes5Pk+3Z0wp3AOWepO4sb1xpNPGXfYo35AnHSogh+lBDhoye1Cy7zP/WdQd2PiuEFs0rpZw3w==
Received: from SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::28)
 by IA4PR12MB9763.namprd12.prod.outlook.com (2603:10b6:208:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.26; Wed, 2 Jul
 2025 19:59:56 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::33) by SA1P222CA0146.outlook.office365.com
 (2603:10b6:806:3c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 19:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 19:59:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 12:59:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Jul
 2025 12:59:47 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 2 Jul 2025 12:59:46 -0700
Date: Wed, 2 Jul 2025 12:59:44 -0700
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
Subject: Re: [PATCH v7 02/28] iommufd/viommu: Explicitly define vdev->virt_id
Message-ID: <aGWPsGEg3kFeX52k@Asurada-Nvidia>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <cc7a558bfcdce5c2ea0d53b0c9c382f944df33ce.1750966133.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E7F8A69CAC8F4B0E416F8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276E7F8A69CAC8F4B0E416F8C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|IA4PR12MB9763:EE_
X-MS-Office365-Filtering-Correlation-Id: f9da97c9-55d6-4704-a2e5-08ddb9a30491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2IbRa2YqvUHBezvEwJOYRLsgG+ytR69T3x+noPj21yPwdrLWAUh47XWM9zo?=
 =?us-ascii?Q?iZavD5szVg17hdDX7ufhGqAlOOqdbhiegCS3Tn2Za3SlnD0isfbCLpzgb9e+?=
 =?us-ascii?Q?AHHWHHAp9VSckYPDOT2mFx0hUKbte+W5kJcB0VMpq97jyBLgHbCT63wW1baz?=
 =?us-ascii?Q?LBh85O1orYz0SBg6TNIza8sNojVBkPh4XmdvibyB/S4jiWrz/U0JwVcZAy3a?=
 =?us-ascii?Q?jjvaTuxY2R4XUeVcfPSAjteieLsbsD/YDCB9YjBbYhV/ZYtdxwPQppGtlkm0?=
 =?us-ascii?Q?FZjui7rsLUTATJlIw2t9mXWhSyzmS5peaP3shmjZc7BUdRczbjR7+FGsf/+T?=
 =?us-ascii?Q?fAuhDifvVPqK0hbf7LeG9Qfxb9sQaG1Z4PpvLEs0L2OadHA6UPeJeyYMmwG6?=
 =?us-ascii?Q?eXyGIExDS1dVUk7FW1YgDe2GbMtDwtqa31mNazVukEXNE5dMx1jigsVsL8Kc?=
 =?us-ascii?Q?szYQbLFAIhVk+afhQtoRI4wLcdj197Fk3LPZm4HO2htpLIvy5R9XZ8lX4VIJ?=
 =?us-ascii?Q?oInKRJEDMuAAdWpMlJFsKIcgzp2TFHcA0/paak+OFBFB99C94/YclwiQg2+B?=
 =?us-ascii?Q?ohi8zKvuxPa2JX4IN+xJiEFtP1V4weEO6h5OgxyI/jTjl8SxehTMAO21lddR?=
 =?us-ascii?Q?pTm+75G4XCfzCLnDLIP/lcFAKFYBbPyDbvBHiQzjNRSQqR+TASTNbz3olHQD?=
 =?us-ascii?Q?G9cGs44vy5NFWtm15wLNFcWq8d2a06IuKO0hJpn6qqi6JPvlkr8hRBQ/Ka5r?=
 =?us-ascii?Q?ApG8lOzCrDLei+Vjay8z6j+jPRgm47oTuuoOJyfnaX8iz3rEydZwX7gcQAXQ?=
 =?us-ascii?Q?o7d3ZlCJNm8gV172twZGXTUgoaiC8en/3Ufze4IOvWKrTiVYFEguThMZssAP?=
 =?us-ascii?Q?86B6XdpPWoKw8q2KRrAHeya+Ugz/r3s3hfx9Kk7MfcRuKTrrpWZeAotWBX1e?=
 =?us-ascii?Q?QEW4PROJBKOTW3EzJWYop2XJnlxtDo48eA2hmo5I+Hu9t0hQ6nAew0eUsI7l?=
 =?us-ascii?Q?3Gg0S6W8L/TNLyijHdqJt9/gYSVtVNAbGnffmyQSJmWAb/EqK2pZOuvYmDvQ?=
 =?us-ascii?Q?hUlhS+XLCNmfXXoympqC7SMohil3r0rCaLn+tFyZ6RYqZAFGNfLCUvIJKc5D?=
 =?us-ascii?Q?M7cDg/YIM9vnSwJifqbqp63xB33IXDjLnukwh/v8qd5bfdxhnHvD+oY7J1hn?=
 =?us-ascii?Q?rbFnD/ckzv0IW1SDOSur5AwUCiZPIchmUj0fTWKluiK3yLqPl48Dp4rwFMvS?=
 =?us-ascii?Q?Qi3/GtLvTogT7+twVu/r+q59usf85ZMTBAJr6k7Dux8w36mazlTZBk6WnyGT?=
 =?us-ascii?Q?NTUhRTYmivp5Rch0S66jCLw/mu6BBpV48uCDgm6WLPb+iLj3h4ajP7ulMgIn?=
 =?us-ascii?Q?0bG8r5BQegX4O5RGidwI0xOVNkGNC+Wg8cR8b2NkZg9sutx/rRLB+n+h5P1i?=
 =?us-ascii?Q?wfhcD94ARhC/wKSRFCFNWAGg/BMzvT7O3ibFCmgEA8aLy5C+zVh/b63lVzW6?=
 =?us-ascii?Q?HBycYjMfsLMNlUmX7ThMCFxawfDblqCYlNBp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:59:56.2574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9da97c9-55d6-4704-a2e5-08ddb9a30491
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9763

On Wed, Jul 02, 2025 at 09:40:50AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, June 27, 2025 3:35 AM
> > +
> > +	/*
> > +	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3,
> > vDeviceID of
> > +	 * AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table
> > +	 */
> > +	u64 virt_id;
> 
> Just "vRID of Intel VT-d"? the current description is not very clear
> to me.

Looks like we use "vRID of Intel VT-d to a Context Table" in the
Documentation/userspace-api/iommufd.rst, but forgot to change in
the uAPI header:
 * @virt_id: Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID
 *           of AMD IOMMU, and vRID of a nested Intel VT-d to a Context Table

Let me correct both of them.

Thanks
Nicolin

