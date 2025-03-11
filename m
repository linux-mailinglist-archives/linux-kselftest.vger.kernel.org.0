Return-Path: <linux-kselftest+bounces-28761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B64A5CC71
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 18:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13030179A49
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4822627EA;
	Tue, 11 Mar 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D+njOau2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6F24EF6E;
	Tue, 11 Mar 2025 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715011; cv=fail; b=pwlUD0KTXtG9Bk3TM5K406DWQNw5zf5/VZIdOjqhiU9+BVuDCk2mw2uoTX22t16RpTEO60gD8lNHYRY45yU264+IDh9/f7YUZuTUR3VhhdzzFexlYpfxF/f0C9sgXoKN7eE4UUC4+YKfouZxs2iM2s4/gNuFLX/OG6VMrrdOur0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715011; c=relaxed/simple;
	bh=JRuQKFTknIoaXJQFgPF+Jcu0DPfkxrRAmrlaMi9ICd8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSiIDXKr2v4AiJE97eDHH+V65u3utX58ZUuLxwfzYWVwvOQ29bVON84wFyqW6dyba4v8R4H4uVdFfoglh57ZO08eerjDDgiNGnXUCIhazxkV4xqZjtGIK2fvO0TxALEO0stlDPrbX+fsyNtndy47gYas5Z3RzUSDKRcd520O7hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D+njOau2; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5p6tF/qA9+03qrcvuKIq8WgOwoVHQ8EvWYaoadhpuz7wC5Nf34vnVyZgFaBJf8rr0O4NVC/QnyXBZpIToNiQ32l1GO4cEn9auz5utJzYuJJc/b/iWoLm49ypmaSOg/uXHzGIrgflXyibJt2fqvvtpgJ5GLONWBDvnREALPu1aty1BAw6AXtHzGtcfNBj8vYCLNxfkp4dZ/aevIF+b8lCPfJFnVkE3v2MspTgIjCJhL1L+2H5DoVjhaUp4/D4DFbw8QcZPLcOwtxWviBitwm62Plgps0FYaMqu058ObvtMeFw60JQ/JhB1p+7Q6cObZ8069PRO/w34D7WC0xY3lTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCLOmqdJV8OPhXkANBA+/oVpKtM1y/uLiXOXwfwYlkc=;
 b=nS2fpqcRQVvjkr05nN6BgIwQJQHX6GJQAT2Ntz5yeGxEitd2GYeBjJNH3gXGGo3ewqIpTKvCI4NWbHoqMdMlkcB/Zo5FUEyM46DXDpZB+YzYAoNv+e2tuDgkAxFxiO3s+MvofveHubrce7ldDrycIockatUyQHXwt7RQNVGNdwzPJQ9un5AA6SKzuAKen8QO2eamZYXfJPKhpsxQnCFe3tJHjxE6PfPI+ukgxXPCPneL9GjmPHZeAKpgIIJnfC/4l6DVkBzzJBpRDtGonrJFtqlNEgGx4jUkzjgxlCNx1iKYj22bu8o4rwuNa1LjlzHb0Cnu0B3mdxZYm9VJb3fAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCLOmqdJV8OPhXkANBA+/oVpKtM1y/uLiXOXwfwYlkc=;
 b=D+njOau2LEJ+G0whx00DLHqU4wmPfCwgS50Ov7eYRr+S4ma0vzbo00VYzkEqdNg52hseI0x7lisOLmD3cRMNN5iZhKdoOs3j95G2TT5fo4A7nWz88Ow7xOmakPYbFhK+rEElAowdwf2wPjw/LY2cKPuGVUxtkYclMdXvaegM2GpTLuCAHj3+neTn2MklYUOkDL4sX2DEfSFvCbZVYuqRV1Vv9AIl54NITMoCPUO2Ozw79ZD4p2jH0N5UunXObzw2CK/4L4UbGrnDatf5MQ5lwuF3TJCig+IGrp5sQWunTiMHtq7lpWxNc1zMczBLhivbfpwoE23t/oGYPfEIi2cCcw==
Received: from SA9PR13CA0086.namprd13.prod.outlook.com (2603:10b6:806:23::31)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 17:43:26 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::1) by SA9PR13CA0086.outlook.office365.com
 (2603:10b6:806:23::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via Frontend Transport; Tue,
 11 Mar 2025 17:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 17:43:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 11 Mar
 2025 10:43:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Mar
 2025 10:43:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 11 Mar 2025 10:43:10 -0700
Date: Tue, 11 Mar 2025 10:43:08 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <praan@google.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v8 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z9B2LMIi+88hlfza@Asurada-Nvidia>
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <f205a4e2f5971cd4b1033d7cac41683e10ebabfb.1740504232.git.nicolinc@nvidia.com>
 <20250311155714.GC5138@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311155714.GC5138@willie-the-truck>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: eb47b2c9-3fae-4e78-4fa5-08dd60c4399e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oXrMpIVHQ5Cfx/LzaxXTHPpkfR5lXHosB6/gn6xuf7XSPVfKjnnDsQknbDL?=
 =?us-ascii?Q?FIiU/rQQyzzBqDhXv81ZyzW4zqWSrnMDYjeor/wbxX7JcUz+DJb2UaQ0RVhZ?=
 =?us-ascii?Q?8KEG/HP+PIgNzO1k6apvvsZXSq87PJcbvggEgoXBch6wOUJRaMDEGYRL/4DR?=
 =?us-ascii?Q?eJdN3PQpt6BgPhCjZij3d0x02RiDy9PjBsEUKOuyBfOy0p9GocyydNb04j8Z?=
 =?us-ascii?Q?y1z8t7Y8JJUBQjSU6tVqlZu6oAJogwDp87UA1mGaf4036xmKZ9wzpnQ6+Qhs?=
 =?us-ascii?Q?+O8QBKEUPh8OTsALOBdC7eZLVNZMfWIjsXSaiuhjP3MFReNUZ5uXuNKehLVu?=
 =?us-ascii?Q?DX60s7Ae6Yeb/WQzZ/xy8L5YXMoRX6Z2YoR3mR17+VgDRoWw6JPQk6IQvm3H?=
 =?us-ascii?Q?MLAzth7betRHgUrhYMqviyM7Bshc8Yhggn4lRENehdnqzvmFF247EHR5wQpm?=
 =?us-ascii?Q?aCN4j7sf/NJb6jxHnMgJJ7AsbtIUEs5p+PK6CeCRvSQH13NZft/Vyhi/+Zhl?=
 =?us-ascii?Q?DnLnaeagW3Jvcygm4XHDKT8ykt2lnm+gt2goJdPPsR/to8A/xnItZmXpUIZe?=
 =?us-ascii?Q?rLxbTHllvyD2EzvlMWHJQTIAXOE9Cv7to2x8Ad3LdwVgvD/WJzVPVTYWXCtc?=
 =?us-ascii?Q?mz58JC0q0/6CHsV1ghMQLUwaXOOqSQ+G25WR5rwVTkRSTVVnaWYHLUsNvF2p?=
 =?us-ascii?Q?C4zOcXJ5PgWSjayipoJFvS78Mo/KQ0W3yhMa93+Zo8gE2l2qZVKOlq1mNo91?=
 =?us-ascii?Q?KYaMJiKS3sHf+M4iHV7uBbsXxW5xvQxK9wDNNDXXsD6uACPUR+jB+PIwacxN?=
 =?us-ascii?Q?jIPK+0vTuAXWfO6pNIczXlYoZdacG2NoHSZ9qALWdqMuoToAwePVgZZaNZhf?=
 =?us-ascii?Q?Qa9PSkUT/BKcx7Y5kaarJjMo4zdaTndIGW6ZZgmwlOx1nIkSd3lw2mmDli4f?=
 =?us-ascii?Q?fXZp+HIwupwDtpA5Yr/MCQI+GD3mFFueooCfSfONh6Jid/mi/sS8FTSXxncs?=
 =?us-ascii?Q?MWgM2wHym30ShR3gqz9Gwgptx+Q1soAbq4R/UmCdyuViPkeEnTmD8lQBOfel?=
 =?us-ascii?Q?apz0w3bDepA+aMktzVYvUShY/LNcF9YDAcRz8JHtkFWdQwpT1KOSm9mXFtND?=
 =?us-ascii?Q?mHso6Kl8fnL9Fx6/4T2UCr5oyiak2dHriKWqXP9tPly0q7eWyKZqH4XyUweu?=
 =?us-ascii?Q?vYteoyizJqe4NL9SkB0ufSXtTDeajHvo2XsFHMeS0ZY7sYkUe5Dm25u8u4q0?=
 =?us-ascii?Q?d2imbJ5omh5lX3altz+awamUCHGCIz3/7qpzaO3r4N7rd7i0DgKGsmbQSYDH?=
 =?us-ascii?Q?GcJsCsnL1W3AkR0t8TwVB5kxUlavN5VXQHiG97/urobDrsB6h6u4EI8yeMkJ?=
 =?us-ascii?Q?YcM1fw8pdWJGZXV7cCK1itoSIS50STIucy+H21Ntd4PaIu5+FKXRySSWago6?=
 =?us-ascii?Q?y0x1H96JZ4p9cm+F0YGb1aQkNntDjsX/25tAhlcHvMvIu9LJuW2PFAZ3TIBv?=
 =?us-ascii?Q?CSy/ueGllHjMHQY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 17:43:25.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb47b2c9-3fae-4e78-4fa5-08dd60c4399e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330

On Tue, Mar 11, 2025 at 03:57:16PM +0000, Will Deacon wrote:
> On Tue, Feb 25, 2025 at 09:25:40AM -0800, Nicolin Chen wrote:
> > Use it to store all vSMMU-related data. The vsid (Virtual Stream ID) will
> > be the first use case. Since the vsid reader will be the eventq handler
> > that already holds a streams_mutex, reuse that to fenche the vmaster too.
> 
> "fenche"?

fence :)

And I fixed other nits too.

> > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > +				    struct arm_smmu_nested_domain *nested_domain)
> > +{
> > +	struct arm_smmu_vmaster *vmaster;
> > +	unsigned long vsid;
> > +	int ret;
> > +
> > +	iommu_group_mutex_assert(state->master->dev);
> > +
> > +	/* Skip invalid vSTE */
> > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > +		return 0;
> 
> Ok, and we don't need to set 'state->vmaster' in this case because we
> only report stage-1 faults back to the vSMMU?

This is a good question that I didn't ask myself hard enough..

I think we should probably drop it. An invalid STE should trigger
a C_BAD_STE event that is in the supported vEVENT list. I'll run
some test before removing this line from v9.

> With the nits fixed:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thanks!
Nicolin

