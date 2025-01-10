Return-Path: <linux-kselftest+bounces-24232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FCA09B46
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 19:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969027A0670
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEF22577E;
	Fri, 10 Jan 2025 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkYnmQFK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187A21D5A6;
	Fri, 10 Jan 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534494; cv=fail; b=VEOD4qdcsU4p1iCZ9lHhsch7JLQZ8kWUxwyJTfQ+EJLBkOGsdwW83G2niy8Mfq9LlMLAonYAUwSu7w5R6/FOZzB41fTUwqxbKJ3TSRDagA2Zm+hwisCYzLiiaumUId+69K/wAiyFhxlD7jNQZH/yYrHtjL2Nk8s9lJN8FWQR99Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534494; c=relaxed/simple;
	bh=+vuIxCA+BEpJEC7H3Ep4JkgssuEk5bGx4KtVKdaOva8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/OXDH7JfzC+TYtlqzczfWDxU8uYrj0EfcuM+hVn/7O8f5gINpBFqa4JHlCaP+BUBNIkg8u5ZHCt/iSmImZ+cu9TevjwOp29aaC7u+eekyjSm2OIbE98cY32P+PELT3zeZOyn8rzoKzbEO9IXM7WR5sNevgQoYctNclevwTh0qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CkYnmQFK; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6BnY3PQHcMHtXkPLXUepUy8/wmFmQom6UESrQgsfZ488I4U0FmdKjfuup1yq6CAHLFaGCXh3s1/CbCrKViUO/pm6EI+wsG/cIKex++nJTVoDYnn86363SFEaBpNfip5d+yZcDzHYmhftKsw/AnpgKS6hbiuT67OBVecDQcXo2CuvRzQrEcJmLqSI5yhmnxxI5BP0S1kgqPD/vV8yRe2sqVDRrglhpi/kkT+cOOYbBdnbD7mP4IczF2e7+7dvlC+OPBMaZBT3RQvJz6mQ0t9qDoL5+6GSBsaNO5ufeTcwefgqO85S0jTntZ5P7kjj/Jh3f4zFtldMf+IUR0fdOPRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0B/g7fr/RTSmqjO4ZGpjBsNc5NsVi3crxLrQ07qLkg=;
 b=PlCseDRjN2ShlbKvG3YyISPFQImp0bda0tMVoZHxOidiEkA5qgjjWIxXpfsOXaAX8kAGGQgT5IlsRUA/cLZb1ZcPw5ZAvMrv9w+jYSedIQB1R2Mh7A7q+mhlbsyjOl6WpmBKwCML9VVZpFS4mxyD3NELu8vaqBVyI5iXzMyzOAjyGDhpPxkcWc+qwWQez1iVgTcy39zrGN4UFMteSqp6OPIUoZyCVs60iruGuQWj+Lvin3DY98jDJaQ3GLcc0LvmaUl+FYFjdZQ4JV20RyZLWN82ksyeTwgy7rDN80AiVoOCDcGHOGwA+slsuGg1r0edmhaxoGdfYnWl+1RJHothPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0B/g7fr/RTSmqjO4ZGpjBsNc5NsVi3crxLrQ07qLkg=;
 b=CkYnmQFK4Kig3s6B+HV7puTCjKAcImVLkfiaT27Q7BFKNiZ7OgZ4mPaR/1BHO+xoQNIBMahO3zsDYCmreB7jRkM9FLyGpCGBgPAdvVn1tKlTXLoMJY+3Fd2PmD7wF2mE52D7w9YkbvQpdQoq0LNWL7EstRPPPUDjRABSCtNNfUFI0Iju1quiLzDJlNAx1ESB2HIwCO9EZw1Rwjvjgp34zuk93A+fw5tEtUxcXf7ld0y73X9pYFLjmLcQ+Vv4w3kCAGsczunHgWoIEhBZHMORjukByjjfTzWQsFvkOstIj8iPXkICn7kKq1gckX9kB8n7u906eDloiFniDu17auyKBg==
Received: from SN7PR04CA0159.namprd04.prod.outlook.com (2603:10b6:806:125::14)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 18:41:22 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::f4) by SN7PR04CA0159.outlook.office365.com
 (2603:10b6:806:125::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Fri,
 10 Jan 2025 18:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 18:41:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 10 Jan
 2025 10:40:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 10 Jan 2025 10:40:58 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 10 Jan 2025 10:40:57 -0800
Date: Fri, 10 Jan 2025 10:40:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z4Fpt9ftiZByVEpO@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <BN9PR11MB527634DAD9FE43A6DD50A2348C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250110145149.GH5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110145149.GH5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f92311c-cb4d-4fb2-7eab-08dd31a66139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DDFlpr/yyOxNRBEZ7P3XQF4y684qmSLdnWFflcolL6fJcBCR9xdnyV3qIf1Q?=
 =?us-ascii?Q?OOn5/oRJcLrKitWwLd4KgC/J6GRkhu27e/MnRrUIdAzxUo5qp7uE9zNdqFQb?=
 =?us-ascii?Q?t4kZltkwoZBQsMH8R0bXRDXNzklqoFhn6evO6kj72XBSObvtjZ5+ZLAz3OFz?=
 =?us-ascii?Q?S4clYmBw7j5He2Jm0KC8OyVN7lb9h9N+PkWHkGrKG0w+5FbvMVevIOhkKBVn?=
 =?us-ascii?Q?V0A65yDUOE+ClP52WTYtYstm71HkjPyxWeq8Wf2KUa3zvk1PBHZg7YVRDADP?=
 =?us-ascii?Q?PF599RzrB/DVuJRgxWMy+NK3k0M6LR4aL4oSX7sQoMwZjRmYhaRKv7fBwr02?=
 =?us-ascii?Q?jYvWDZ918Xy5Je6tXmlP39H7LbgBQGQZpcVX8cxBFwgEWJSN4m6kR9S13JIf?=
 =?us-ascii?Q?hOz7ahzD+jxbZ8CrFqSN0+a+BrLYB2i/+hqe8W+NNfufYQFoV8kMJkqF5Qw7?=
 =?us-ascii?Q?a4qVcOldtLDHw+UsdSslnLTtQCRHo948f3maF5leprg3wHwh3OsEmhsaCBvu?=
 =?us-ascii?Q?Mif+kY72P5RvImK1kC/T8KUp/u7AZ0BUwq9wW0Umm884foEBg9gDfqIYfmFy?=
 =?us-ascii?Q?VXWsJzaxuGzAdCuqEaKmTPOEEscGi8HrLeD5fwFBHFPH2WcUbdnPbp50roYE?=
 =?us-ascii?Q?+c4Zy0jur2M1qGdCdXkMgp6BjvgKUTzDbN84opxcQkpXKhW3S2bhDQGZnV11?=
 =?us-ascii?Q?BVtl4WUtqSg0Katk12yI2Qyalvt1tVI9cyfT4LI8t1VCQ+NU+ma5uNsgQ1K5?=
 =?us-ascii?Q?883CHeYvCarCGfsAhbYIOYT9H4qNQ/yXbKKeLArGO+Ixa31Od9wUpq5rgmAL?=
 =?us-ascii?Q?x5ErIdeilPymSvD3ltRNy5VEPfoZxYuyvQHPa2tzJ3YwPuGGaiyrEucuPAng?=
 =?us-ascii?Q?GpkC8BvtJ5pcDZ7NAvE8maYYP9xi34XH+HB+2Esgm2bhrpunxqDV8AGdZwV0?=
 =?us-ascii?Q?d02F4zn5ivF415paHDS6yI5WTCNP6s7lnRm9lndi52y4X/ncE55ej9hQ3MBp?=
 =?us-ascii?Q?638abs/djIBLGBEG4oLktbI1FyCYw26lBixleYy+ywh7NWQPj64k136KK9Zy?=
 =?us-ascii?Q?HphfC6Ltinv5w5jArglgUKsR+GjeSd9ebd2W+JFVX5zCKB67Rw9Z1SO8eAts?=
 =?us-ascii?Q?bb8yaRR2X8amE+oVQ1ktP8vGnMGDUYC5lumsEZp4GbxyxfEyClbUAt5wprRn?=
 =?us-ascii?Q?zlcs6eGoZbKUwFPl9/lWM8LkuzbMFBIYSCzPFTD6rYuM0m7QJ7UcqtGU9x8r?=
 =?us-ascii?Q?aNiOyEC8lXY4bnzB7Yp+BbTzzdYaU1oN7Xh9hzESJJxpTX1DsfZBTTaHkhts?=
 =?us-ascii?Q?Mmy12LnttOnOO2m7hpVLbGam3KHExP0q2+HSKHLcRELy/PPYEnlURPdx182b?=
 =?us-ascii?Q?Rd3IYO1a5OThXv5aFPnxCh7X1glpHkB4FtLMJK3mqTaCT2WLNkN/BNNlEdes?=
 =?us-ascii?Q?SmzKOMyfU+aBYyuS5Ft/ZwmptSykZmSQIZJ9D0XH7OEmxTJ00da2rTz6YYVo?=
 =?us-ascii?Q?1sLGhrbz/zpynRo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:41:22.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f92311c-cb4d-4fb2-7eab-08dd31a66139
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416

On Fri, Jan 10, 2025 at 10:51:49AM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2025 at 07:12:46AM +0000, Tian, Kevin wrote:
> 
> > > +	if (!viommu)
> > > +		return -ENODEV;
> > > +	if (WARN_ON_ONCE(!viommu->ops || !viommu->ops-
> > > >supports_veventq ||
> > > +			 !viommu->ops->supports_veventq(type)))
> > > +		return -EOPNOTSUPP;
> > 
> > Hmm the driver knows which type is supported by itself before
> > calling this helper. Why bother having the helper calling into
> > the driver again to verify?
> 
> Indeed, it might make sense to protect this with
> 
>         if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
> 
> As a compiled out assertion
> 
> Or drop it
> 
> We shouldn't have unnecessary argument validation on fast paths,
> !viommu should go too.

Ack. I will drop those two if-statments.

Nicolin

