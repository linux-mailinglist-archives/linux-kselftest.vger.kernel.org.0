Return-Path: <linux-kselftest+bounces-17323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6A296E3DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143AB1C22AB2
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC851BAEFD;
	Thu,  5 Sep 2024 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OspOcET/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB7E1B9851;
	Thu,  5 Sep 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567325; cv=fail; b=EGBJeVsvVpD61NEgUxKa0UK1PzZPGIFKFNf4mlLCOiBNpdSUVJWgd65mY2033Kz17Ohv215v17hjoP5Xe997N0nbbdEMdJB84eNQOorVcRpc3psLRonzCbqzPIKaaWnZkFTPaNGQgJyV/4ZbFnBZVExRbf6S5e3CktEin8nVNFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567325; c=relaxed/simple;
	bh=cMSGMQyyvRZ1r6tlCNQUQ6hi5O/TdFSPMaedC4VoUZ8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr+QCmsCs30aebKzASOgnQ9mVGbzgF7oH5B0QUX3NIraXQ4ZpOR0yMLISH+fMPxYyIAMc5hX3ifJVEc6hiDLizk2MmElFAIOUn1CQBNdrmyhLwyg7b2XR1WUiLTq1z9Ydi9voB8d2gQ/lvkVBvKTJu5fwwnM/aBAMp9mzbyPcuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OspOcET/; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9L3t37vDtAgRCtYqKYRszvImNBYKNJL6I2LFnyoDy4TByWgCgfqXAIA5XmYsNTTAT7BKpwshcbOsX8A0CM30a8iUOzWx0GCuJwsSvzuneJFV7Lv2WbS07BeaKN6s2cLwdVb04Ndt4JuJJtAa/mAWjYD/ItgifIqwplIkJht7hX+WHN1nxiFJOL/WKFM14yH+MzOxw4B3hjzonrSNBw2AO+iuhkPJtshsnxIjdfZX5TgjHouqZ9gv0VtSOZ4MIkVlQo/boHo0eSmp7mtvtVcb5sltgrg9izIenjfboITE8pBhJ/4dstYjILYdIBif4ELfQlD6dDLvFZLT4teNo3thQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHAxfFKQCRzgkI/utfJba+y/cg8LsxbxdS+xRzLDD/M=;
 b=IHXhyoW6PE4DiceJndesvgcUKo2JmKHLm99JV5Sun667V+wALgqlYuK1sHw5/lw5UJedJ22psgD/extMMmOxZaPwTP1iOjXmc1KptIv+jq7wpAWce0M8yi7LrZTw1LVbpsVDrXKHALT1/Si4b5WJ6oAAylbC7TNc59tWYZivVwA64gmzmCANlYcGDLnwFSnVxpBjMFlncYwd2pYVums7dLJfXFJxHIhH4dTC0N9w5cPdaMrw8K/zRIGbpfdisgFo7DqmoFtfa+FoCfIPXNsiuvKq0Uq7BL96Ns41isZV4aV0t4JfwpQ5/vcqun2IgRNXaxMD+1BUdoQt/7pX0zUzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHAxfFKQCRzgkI/utfJba+y/cg8LsxbxdS+xRzLDD/M=;
 b=OspOcET/JU3ipzVNv9f6GWk7hX2wCqK0KCl1Bw4YlGPs9XQUEIEsjLoncum7/3oGZ6yPdUU9M0Gb+FOf9cIsFQIMJs7m6+jUONb7HNEWcYiYJF51wTHSbA3aJO7w2/REQAd10S+Ae1V8iAQ1/1OEMGT5wdksw4ovatZkgp8WWbyNQZohHDo0oeNsf1pVpCeSYWE4jM1+exh6s3dx+GKXuKBzKZcAKi7D7ZB9yUqmvSEegihipFb3z/jwDfFJIQu4bK/ZNE9DecYdBRLbuJJ3LhNAuFYGwlbxf656rqTqs7B63faqEHlKqFFG8LLifOLfIdyLKannpmsTjOCy8B9ehA==
Received: from MN2PR13CA0031.namprd13.prod.outlook.com (2603:10b6:208:160::44)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 20:15:19 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::10) by MN2PR13CA0031.outlook.office365.com
 (2603:10b6:208:160::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 20:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 20:15:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 13:15:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 13:15:04 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 13:14:46 -0700
Date: Thu, 5 Sep 2024 13:14:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Dan Williams <dan.j.williams@intel.com>, <kevin.tian@intel.com>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <ZtoRLlk3hLlP1c9Y@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
 <20240905174326.GW1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905174326.GW1358970@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3243bc-201b-4395-9f38-08dccde77643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EhnImwpqkvoBUExL6x9l5JxZ9//MaOhJ6n1ggNfTzi33hf6ZUCuneS1/44dq?=
 =?us-ascii?Q?9IO4d9rG/9diIc2Dx+JPxB0MChXz5MZgguo+pDuSZqgS6C3vEI+6uVHhqtft?=
 =?us-ascii?Q?rClWwdP65Mbiu2F8G9a8Avd1JOMEm+Oe2UOQlrDmRMdycmlWAFeyJLQAvTuP?=
 =?us-ascii?Q?yrefRsMkwC9XT3cSRjwzXcyCRr2udDdOhAn7WWWMoebAnEUzhbfpODMHDsbt?=
 =?us-ascii?Q?gXJf1iA0CRtOC8ugAAcZjRDcnuwv58vCEihykKVQTdV9rcW6rECvuR20DWqd?=
 =?us-ascii?Q?Ro1PMXtD1nxwB/IPa+Xma5lAdn5k0LvqdSMhv/sQ9PkqoQPQgtVOSzbJauA9?=
 =?us-ascii?Q?WtXoOv98SsVUWbPM1xKHvk6mU8Q2QUnlhdv78rmD56xxH7wdGSItUsheucbO?=
 =?us-ascii?Q?E9PIN2uj8wRmrndX0RwtwWILQKiDjPMnQwAVGlqqN7fPDKAyo2zrmmuU3N16?=
 =?us-ascii?Q?TN8+2LkPy7/gaEfV5ngL0Bcul33Q7ehgrYj1D048H1BMyfLUofKAbS/KNxRa?=
 =?us-ascii?Q?BncVr0UtI3BZGjWx8OaTae8UeZ0O48IggZs+xL8OyRo7LQmVb1mnE/xAmoN0?=
 =?us-ascii?Q?nZcCOkGtqNgz3WzBqE++M5JxQc5z10SX+OpN5IDfoToulejazpig67ICtrt8?=
 =?us-ascii?Q?NzNhgGKuYCHlv3UZlNnLePbmLnAUjCmC7HrEdjRES80AvNpV4CUF6tyRcYj0?=
 =?us-ascii?Q?qKJmAoRINFI+C6eHr3ZyO9ISz+v+fhm1GTDKvTtGPpjGCvH6tUQdyqrRCY5L?=
 =?us-ascii?Q?LtrOc5rL+6fsXfcJJxCZ15Zi2C0fw4f3rFbaOVXcpobmz8Zp3/mk88TpWTfe?=
 =?us-ascii?Q?yNPocIn7u2PsaV5jewY+cQ2cORLC6UWfMfSyWlqRiDECwxePwKGEj4TL5VSr?=
 =?us-ascii?Q?yGzG7tTC2kXtJEqeMfhQeqwBfENWnhi6sb4asiBgwSaIywO9D4XVY1XU6PUC?=
 =?us-ascii?Q?8lp9CK/V9xziPwx4kbyUy3hUtAHBSdRVDMdKSlQOKXGGZg0i9O2d6tdouXAE?=
 =?us-ascii?Q?9B3V51GCfZbHk3gzxLyN3ezkXpyQFJwQmO3ZomIu+5TZPrHTElI4H4czcO39?=
 =?us-ascii?Q?i5kO2UP9g2IuiQe8sJRQzhrfQzhRFKbkoxTwPVbPi9DVY5+rktbB/pP7OXtU?=
 =?us-ascii?Q?2HjcWL/Tgyz9Sv8xgJIkmeKv6wXC/kWcQXcKmktpfdYGiKUZZTiukzOT/h1I?=
 =?us-ascii?Q?5xqFKpu4IA/C5gz/fHcFsvbJV4nM1DwUDeUyrt2OZ/+GYU5eSoYTUfCNi34c?=
 =?us-ascii?Q?8tSuZT90Yyss2x/+k3knpqmYGd5UwoO4/VC0wbswePPiUEHAP4haY1+zNPAO?=
 =?us-ascii?Q?rTPjtsiNbYl1gnlEstso/nf0tbZsONAFa8Ax07Y7tJnO6raf0YYUvM7EygD8?=
 =?us-ascii?Q?zqz+ki4sCiQAOHAKNbagezeNFG3eNLecIIwH7v5Vu/PbzPoTJJvgpAOYLsVD?=
 =?us-ascii?Q?pGbFyY99L7UxZwch6RJpgV2CKAfZRBII?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 20:15:18.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3243bc-201b-4395-9f38-08dccde77643
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

On Thu, Sep 05, 2024 at 02:43:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2024 at 10:37:45AM -0700, Nicolin Chen wrote:
> 
> > we only have virtual device ID in its data structure. Also, the
> > virtual device sounds a bit confusing, given we already have idev.
> 
> idev is "iommufd device" which is the physical device
> 
> The virtual device is the host side handle of a device in a VM.

Yea, we need that narrative in kdoc to clearly separate them.

> > That being said, if we have a clear picture that in the long term
> > we would extend it to hold more information, I think it could be
> > a smart move.
> > 
> > Perhaps virtual device can have its own "attach" to vIOMMU? Or
> > would you still prefer attaching via proxy hwpt_nested?
> 
> I was thinking just creating it against a vIOMMU is an effective
> "attach" and the virtual device is permanently tied to the vIOMMU at
> creation time.

Ah, right! The create is per-viommu, so it's being attached.

Nicolin

