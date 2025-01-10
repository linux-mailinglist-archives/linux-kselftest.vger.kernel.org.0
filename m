Return-Path: <linux-kselftest+bounces-24240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7929A09D31
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD83A16A95E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5606A20967E;
	Fri, 10 Jan 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XMSZN8Ml"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47211A23B0;
	Fri, 10 Jan 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736544592; cv=fail; b=MvOp83BRIqVPBNwJV1PIV7g8CIjcTLNY01lRZQkeFVtAiUe9RVzEeOxZs4dz9G5hnu2sfhWAm0hzd/W/h3XgUd5N1lW0rSlEwQlTaLm9Xa8lo6DK5EGeiqdoabQBexX7N3pjEoZrhX/DU617pU7NzhDmGlQtijUgUYArjPnbwIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736544592; c=relaxed/simple;
	bh=QGMNdYHNHakPRYwZo56GMP3tJ8v2+CMYjW4RrkSvwCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3SQghq5nX+jfpbyPOKOpuxUy/yT/gj58q+JbKg3w7fxpqsJGVzIDa67algG/VZ1z4mC9pNcof9WarncMo1RfVZMeEFp8AmVla0QWUe2mjDnCONtJRMS/oRm205pnTKPllb5opDmlytOQn2Gl9ge8qh7UdaWF3mEG+0Kft9oA/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XMSZN8Ml; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bITiO08/3S+N6yjeuMUyqNW3YjtsF77q2LLAa7p/as8YaBVvH1fKnWZINV3gRD/MxerC5XT/uR/OgPDWIjcPXSty1D7pPgT1wTKmld73vkcMFysejIFh4vMyeg9p8OmplvbWDYQCzOZdW7f4+Hnm5DKmY1En2Zox4HsWPEHL8KjMzDw0vBVmDJCzxCc7CIPVukpFJRIQXLcWQwPjAq2Mba9YHScGeXPwEObqTOn11fQPiAkWenCC3N3+7YxYxMiR3aFVGJLdHeTBcF+czUNvHkyUZwsG4O23VEGSTpzXPB/4ZuXxA2YH1Tydj6ZNEhcrYHP7oBs01DcW5iU3MT8PMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIs5LblGpc1RpeJTogzUQU2mXOsxw9z5fzPG08VyKts=;
 b=aj8nk8CKnH8MkDJF5llBv+uq9rImVaJ9566hQgHGkKRHdci1h/Bsx23uWn+xHXZrYDjW4EgzNF0v3b6wVQEoQn9YMdFqfcKkDb7Fc48WkP4/Mckj0Pz0WbSfj410hMnTgTaWveCBMLNDFdh0hLpqkuBcvpqu9YJAMT/EIJXID/wGKhcL56LcJJs3VaI+kNjkUfTy38ybQVguTl1VH1dLW/DSvFvwYCgN11Rr5In3iq5vWN0hKt/fKBrF7ZSNU9W8j+P4EmgbVrmUV0XumK7kJh6QsMoAYepc+51/KlXlN7mzny/wPQJK0JN6tZemfKZe/WBHaDnF2bWrnlWBRaAeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIs5LblGpc1RpeJTogzUQU2mXOsxw9z5fzPG08VyKts=;
 b=XMSZN8MljQNCFS4VUFWGCtJ9FUoU/kBp/w5MIBWkRu3ub+OnbpR1XpKMEsyoGyqnaEn6r8EAj8k0/r9OcmkxVgf9QA1qu5FBnhW5+Eh5SXKXtQnrLSUd7PppkgrY+58FveZPzdIVr1zMIbXC3SIQCzXp2KvmdFvATAoiOsI1lYcbUTMklJewCdeWhyaPG5/CfaO6gDwXchOlauJWq28moia6orieIVfS6QAcRQoBqy6xGhvkRZYDdhXYRcQtmoVeYJqgEbLeIi59VE+8W0/k3DirlMRHkZrJ6o7Rw3N18oUwPJpVhl1DTDjE0xKk4yk3SLIEhinhy1t/7/LIe/R/Tw==
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 21:29:47 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ea) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Fri,
 10 Jan 2025 21:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 21:29:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 13:29:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 13:29:24 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 13:29:22 -0800
Date: Fri, 10 Jan 2025 13:29:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "jgg@nvidia.com" <jgg@nvidia.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
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
	<yi.l.liu@intel.com>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 06/14] iommufd: Add IOMMUFD_OBJ_VEVENTQ and
 IOMMUFD_CMD_VEVENTQ_ALLOC
Message-ID: <Z4GRMEjAIoBjHnMe@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <86e78625c48d0c8fb815496dbc57708b98a46ec7.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768B2EA84EDEFFB04662598C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB7194:EE_
X-MS-Office365-Filtering-Correlation-Id: eca64149-0d8d-4229-3373-08dd31bde80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CcIM5I5vFcDTqo6kIcPFEtMgQIbjqVtkpcV+o8kXWb5atlCS50nen1sCgfEd?=
 =?us-ascii?Q?Sn44yuBrp0sK/Gql8RjF8ycMICD2Ijn8iKKsS0/TMs95xRc+q5Llc+GqrRsb?=
 =?us-ascii?Q?qDs+ztokMWc0yXNPT8KN7jWP5G9vPtf1O95A0+9+Pp+rJVnw9ehjYYc0OgjI?=
 =?us-ascii?Q?vFOYlw2WqGdaSA8fOg9UJ164OvT+UOifTy+WBgaGNmBpjHnaZ9bBqLXiBG7F?=
 =?us-ascii?Q?KxTSG6Erii9JJkkjzwNhsev53QxIomN/IPGKXyOsg3EYGxQBYJ+Scc3ACzJD?=
 =?us-ascii?Q?AS/Gh1At3YqnOkUlmSJIEuNmk9AaXvLlqB9Cr25tR9nND6HpTd5j6UnZZakG?=
 =?us-ascii?Q?dPWQaRxLqUW57NNUT4ML33B1Ioath+aFxzGe/Kjf/WhYkUT+s0KicNanYASv?=
 =?us-ascii?Q?Ale57J6YhQlTisgtXGobnGxGhiSb+xgMs0MOghslezVHHfzj0P8bgn5wYeL3?=
 =?us-ascii?Q?QEZeqHwn6pHfA8KjYETR9oSuLI+xisshLZCWJJ13Oxf7w4a1BTrDpjeZLSgO?=
 =?us-ascii?Q?gU9OleD6AexMows0zcNWYyTSQ+DGOc7VqJK82uOkX1PuY0oyu+xY4/T3ERyQ?=
 =?us-ascii?Q?RdUx5NrupNlYveQ5LT+Z5LLZVVzTS7i1D098peqzWeOsTaX0iXijeHyMR968?=
 =?us-ascii?Q?BB2svTA3ZtqeMMANx8YEs+oqKhNAHwyzUFXkwnl6dWE+1WdR7SAOlUfugiA5?=
 =?us-ascii?Q?ApWmrTSwXAQNF8D6B85MVSdoB52JGHpoNnXDG/gbC/DHJ8W7cIRO3B7GR1V/?=
 =?us-ascii?Q?uaB8thumS9YDP98nqrpSq710zxxWq2KjCK8W7HA2Q9/m7yUfd1ocwlfeMgI/?=
 =?us-ascii?Q?Mqb8tdAsNoqQh01HrpaY79AHevPEP0YVptXaVKLpZ2GV1vujoZwj7bo59Bo6?=
 =?us-ascii?Q?LYQJvgncaaXwOamyKclUzcyZEnXUIwia4TmT4Du9N1xsA3bcCSYEVvSKJsJ5?=
 =?us-ascii?Q?LYKWqwnAZLbbn6IsIELZCDLzL4hefVimFpnm5BL4G1FXfMvS5nZL87Bnw8Vv?=
 =?us-ascii?Q?EV8jL8WL8Nmc64l77JDtsQF5L8sg3Zce838l8umPhzbMmhxuOG1AlPx0iOJT?=
 =?us-ascii?Q?p983fJd37BUVivwN8Ns8b9cAexdmXtrtgQan0AZnswAAL5beZCFW+9m2TqZI?=
 =?us-ascii?Q?jejQlyfcMcxXpLpZGlLchFQNJXLqkuhlI6xCzao6WU8ijB06pD/a4xw3jte8?=
 =?us-ascii?Q?J6gj2XVAV7tfByHRS2PdWJUQo8Eih8OhWqMJfPR5SE6FpfJaQZSMSGrCZ9Oj?=
 =?us-ascii?Q?8fjPndrN7c6C5K/ydy6LZkyAqOs6gOiMnLDaIUxInm+pcHBdJalClXq9O3g1?=
 =?us-ascii?Q?QT1kwZRRBGobC5uSUN+T9bGoP9+/GDNEl4869LnVS3ZsvW8XHgkS9ZXCtxO3?=
 =?us-ascii?Q?JnN2t3DZo1x/LFYiY99hogXgGjHSKeUVi10e95g4ZvMgGAmCFDgyMc2gajLy?=
 =?us-ascii?Q?VpsTDCcgPTWRB+qlh3b7DsI0m5CbuH2hYboqVfFMF2Ajv38XAArK4hwyZS2j?=
 =?us-ascii?Q?qZ09A5GJMf/zxUE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 21:29:46.6428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca64149-0d8d-4229-3373-08dd31bde80e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194

On Fri, Jan 10, 2025 at 07:06:49AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, January 8, 2025 1:10 AM
> > +
> > +int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_veventq_alloc *cmd = ucmd->cmd;
> > +	struct iommufd_veventq *veventq;
> > +	struct iommufd_viommu *viommu;
> > +	int fdno;
> > +	int rc;
> > +
> > +	if (cmd->flags || cmd->type == IOMMU_VEVENTQ_TYPE_DEFAULT)
> > +		return -EOPNOTSUPP;
> > +
> > +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> > +	if (IS_ERR(viommu))
> > +		return PTR_ERR(viommu);
> > +
> > +	if (!viommu->ops || !viommu->ops->supports_veventq ||
> > +	    !viommu->ops->supports_veventq(cmd->type))
> > +		return -EOPNOTSUPP;
> > +
> 
> I'm not sure about the necessity of above check. The event queue
> is just a software struct with a user-specified format for the iommu
> driver to report viommu event. The struct itself is not constrained
> by the hardware capability, though I'm not sure a real usage in
> which a smmu driver wants to report a vtd event. But legitimately
> an user can create any type of event queues which might just be
> never used.

Allowing a random type that a driver will never use for reporting
doesn't sound to make a lot of sense to me...

That being said, yea..I guess we could drop the limit here, since
it isn't going to break anything?

> It sounds clearer to do the check when IOPF cap is actually enabled
> on a device contained in the viommu. At that point check whether 
> a required type eventqueue has been created. If not then fail the
> iopf enabling.

Hmm, isn't IOPF a different channel?

And a vEVENTQ is per vIOMMU, not necessarily per vDEVICE/device..

> Then it reveals probably another todo in this series. Seems you still
> let the smmu driver statically enable iopf when probing the device. 
> Sounds like iommufd_viommu_alloc_hwpt_nested() may accept
> IOMMU_HWPT_FAULT_ID_VALID to refer to a event queue and
> later dynamically enable/disable iopf when attaching a device to the
> hwpt and check the event queue type there. Just like how the fault
> object is handled.

You've lost me here :-/

Thanks
Nicolin

