Return-Path: <linux-kselftest+bounces-23275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A969EFDFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EE11881A91
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 21:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C91BEF82;
	Thu, 12 Dec 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nEWAvpfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829F1AF0B0;
	Thu, 12 Dec 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037866; cv=fail; b=WpeoGclQTkGi8AakxR2Z7BzNA6dPBwuGd6jxSVq1KzKEu76Ti2uEqfxhsYsUQm1W+fMBL5oozI85Q5Qcu066/+LI0e8EjJKz5W8yzzlfaoq6C179fVEqXOHzSoE3ecBt/wpdsriP59CmSEZ7IITf2iQ+wJ6jhGetrI8Giiir/eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037866; c=relaxed/simple;
	bh=g8KrUN+rnhwuokNRk870OCQ2k4r9A6ueG7fXozIi/ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtyLoc5hYOG9jDvnWYA8ZK8Q5xoGCEC0Pyh2mkmyZ4xXNq38sfSaBWPn+iY1Q704clWMuOHIIydImoVaPSHy+0h/RoxK+/psJfPJ2m8gbpZKLg+B9Mmjg3hP4Cpk4j28OrSJHWGC+u2Hvt+aAWFFoT2ZSu76suULwOdM6/pSmMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nEWAvpfU; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC/lyFIsg2xec0YfE/a/poZGxrwv2BkmCn1AcfLLlhnFSHRoM2K4qK+K9hA7UI4Im25m24RlgClL9jLjUFPbXqeYzdWZxHtNAaV9QN3GJhwZHUxzzqbNmVXaf+Id1/juawhrsknD2ocO954rCJ15gmWU0g2UaiTRiez4QLBZkGiVxj3uxLx+WjAO2ui0g0ernP9YlrA0nmIFSWXO0SVUG0KqjU2JgO1bFBJZnfmqTFkKl1prUghh1bvx4dR5owBEFgcraklxJyu3PCiRV1bkyS8MzHP+A4sx+278smIer7KMCFTsXWNJFnSkaroZ3E1ZMJuS6SJ1Oa8kUVeYQpzdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdl2QtTWOycY7R2M04/L9SefQd41TMvF6NdQFqNnWp8=;
 b=DfXh6ZHEyvSFoc32CIhlVXLuJQyUowWCPDJm/UAU3Uqw6/HBFw7AK/2c8SoU+z4DtxsE46vSovGmAee5H7jQT1Uh7ZIxEvlKhzaAs9lCkqC4PBREd/UVmd/rjsRw9qMSZifAnACDVwk6mbV/9o2GKuZ6IwOngkIAMxTGpqIeevmubakUAFtTEnBKO4xYzy2gpxlhaTzMVm0G75TSkORMxSB5LdJeNxjfeKmdP+nUCapEKBXNu+aWfiSjRFYdC2JObH2eA9NPe3Lj+GcfWBWOaa+uFgCp4S9a+W0T++iCAoILhg2b+gHyUtwdhuNAMSWIc2V9uT7KgedPjk812tLZlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdl2QtTWOycY7R2M04/L9SefQd41TMvF6NdQFqNnWp8=;
 b=nEWAvpfUoGGqjlkQRLL/IixESRoGI3/02QOapRryciYf1zCxdJGb1ApbBx3zRt0+qOOoZMrr/4bn2pYQY3V3GJD6l1xVpd+f35WrZa3+AhzYlZWOgQdCqFTtrAs6Hra+ttiRIBRNrSmW8jbNK3XBsfclr5unGE9XI9Z7I1s98YZWT8BEVK+4nCy2JqU/R5OvUsyF6+ZBA8/mV81hB5e0q53BAxcH6UkZlwVKplHNQPnA3xl5W1VEqdOw/ANs9IvqW0Unzpnvkab95Cbg02ojIpNXaiANhhpHZp2VBiMkMK0VVjMKv8hGU4dbpa22YbC0Sj9mWaNBcJ/rGT4ThsGK9A==
Received: from CH0PR03CA0328.namprd03.prod.outlook.com (2603:10b6:610:118::14)
 by BL1PR12MB5778.namprd12.prod.outlook.com (2603:10b6:208:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Thu, 12 Dec
 2024 21:11:01 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::2e) by CH0PR03CA0328.outlook.office365.com
 (2603:10b6:610:118::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 21:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Thu, 12 Dec 2024 21:11:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:10:44 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 13:10:44 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 13:10:42 -0800
Date: Thu, 12 Dec 2024 13:10:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "joro@8bytes.org" <joro@8bytes.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>, "mdf@kernel.org"
	<mdf@kernel.org>, "mshavit@google.com" <mshavit@google.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "smostafa@google.com"
	<smostafa@google.com>, "ddutile@redhat.com" <ddutile@redhat.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH v2 01/13] iommufd/fault: Add an iommufd_fault_init()
 helper
Message-ID: <Z1tRUWZrSWJRW4J7@Asurada-Nvidia>
References: <cover.1733263737.git.nicolinc@nvidia.com>
 <3bc49512a42b88130cf447a7ac10acf5c02e056c.1733263737.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A65935F9E6339FBA49918C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A65935F9E6339FBA49918C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|BL1PR12MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b34850-74ea-4631-c25f-08dd1af17b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MHWbbTImoRMTertcxy280mxADI+8E8ECz5AKDgp4r/ohW+XK7Q4FBdHeghWC?=
 =?us-ascii?Q?rUVDTl8mFl0KVN5KnkXY3huasmY+Q9kOxI6n5V4Ab2bt0KhZMutdYyFOlaTe?=
 =?us-ascii?Q?aWB0Vik8mA+nfqr10KQu61GgYUeoSAkFprpx80Au2Ti9b/rLOUB8TIWvn4Or?=
 =?us-ascii?Q?Wg9aW1mlsnYxWbuCAL3+mKIg1V9/gWHRlbkCKEmEvdOAoKJ3rYcqTW/pSjk5?=
 =?us-ascii?Q?WmmCm/4obso2x8dWvSyXEdTRnaeA1OjAoJLc0Negsh1n9wyopw4P9Y3KQ4iY?=
 =?us-ascii?Q?OhmqPpXV6WnxCSD+Y3H/TCqQ7rRVJPaSHRw/7Vx3AMK73sQF7RwVORk4XG4v?=
 =?us-ascii?Q?BEG1kr3gA0QYLjYNqawaBfGKhRfMwRGbQJWSHgSeWmfJbEFqeoZnL//JssOU?=
 =?us-ascii?Q?52dXzDvufGJgsMdEmSGLzlgB6GCbdd5mmC8V3hNCxZDD6njc2oc8pRZNtpLa?=
 =?us-ascii?Q?5oqTUJ0+iprQxjW2X03VkccTD0zEF6OXFhWsP1XA+vNKtWww1jRHeyLuCo+R?=
 =?us-ascii?Q?IqBnW59EReGE4qcL2prtLCMfhifFapKyEpxfUokx/frsJgQqxT1Cx/LHafMU?=
 =?us-ascii?Q?xAiDIqtcLMOXAz/gR1TTKtfiFZRqLmlqamGxYHJl0GVYLh6P/mhVds3B1HiI?=
 =?us-ascii?Q?wWSCnGIvxfWZkHDP11ilfrAhXCJAdJyf+b45cJSymrLy/EJfI5aW4Rb7y1JQ?=
 =?us-ascii?Q?/OTi1keoUWzasY5QlQKM3l6H58Hn77uSz/zgI1A10p+TfW5HUBbw99Vm8CDr?=
 =?us-ascii?Q?0YOD3evNFDGuA36jLS7qVTKLiri1pq4We6o+ahk0DzMnVYtzgcsOhmSxt1oe?=
 =?us-ascii?Q?vqbeg5rwHFlgQbyZ/2sfi01AYuGyIwvidA7jlXmGzbZMvnI9MDIAVgfoQ3dI?=
 =?us-ascii?Q?xVJaLyNHEC3ljIZUXTnPV+YE49rh94cSTf5A5LP6fzmFw7nKCb+NBULUZoDK?=
 =?us-ascii?Q?FZhUwxgrgS/tSPzntqRKogAgEiNoifCePtMJ5aPsWqKFFs2WZIecqKx346EJ?=
 =?us-ascii?Q?wGQ/Wa8diw1AsUiCwO76Xw9iiTMd9CUX1SmkID7QQU3ENCTK8qFgX6eXm1Td?=
 =?us-ascii?Q?dkDJriImr4ZPe7jwAVb1Ce09aLDa600s+GBq1ewbDSrGb7w6yvxfRf/CnmfT?=
 =?us-ascii?Q?uUZWTZGMqRrrtUP9EyAs41nqcyn+Xdw8gSwfFBi56hPIkZ2Mrn1IXHTfyhFA?=
 =?us-ascii?Q?8R0te5TIF7gzIBC6+JWKkENjVRtrkUnEfRuELFWd2Zm3LTbjS4f9o1qsmWI2?=
 =?us-ascii?Q?P+FNfKufOK91La/FMCagfUla0vsD9z3FIF0QdJLeLMR/D4X9Got3Z6guea7z?=
 =?us-ascii?Q?DHXVYzlVwA7sOSYjCmG2uybisaskI46K0VZVeuDUyG2nOrBqn8+/mpBCRTHp?=
 =?us-ascii?Q?7mScJ/01qx45lSJ/Fou45/Va6uZPR7jUlPTuuFECOpzY8Kb3PJJjBFNgK4u1?=
 =?us-ascii?Q?RAURyZL6SehAUo1m/6YTtE5wuhmDuQ7m?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:11:00.8175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b34850-74ea-4631-c25f-08dd1af17b05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5778

On Wed, Dec 11, 2024 at 07:27:40AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, December 4, 2024 6:10 AM
> > 
> > +static int iommufd_fault_init(struct iommufd_fault *fault, char *name,
> > +			      struct iommufd_ctx *ictx)
> > +{
> > +	struct file *filep;
> > +	int fdno;
> > +
> > +	fault->ictx = ictx;
> 
> while at it could you move this line behind iommufd_ctx_get(fault->ictx).
> usually we want the two together.

Sure. Consider it done.

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nic

