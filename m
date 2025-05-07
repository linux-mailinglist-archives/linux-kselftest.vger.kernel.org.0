Return-Path: <linux-kselftest+bounces-32608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B7AAED77
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB9B21B81
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5E28FA9F;
	Wed,  7 May 2025 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ubejLry6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BEA1DE3DB;
	Wed,  7 May 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651123; cv=fail; b=ike2pLIhHjywfyBXUQD5Q63Oomh5XwRiA6Hn5HIF+Y6UNhHC4Ks6EfZufYGBhoHmWmdS++BewrbUcB8S7Ki22U+S+j+ebuW1unXd3Z5d518bws4HjKbXlQbcBWsPR48O6aBtNWIvK3a1ML9j4zNldq/mY5VQeBgTpGYTARnPvS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651123; c=relaxed/simple;
	bh=Yc+Jr2OLMkHMin8ZCd0+w5qeuFS4rXf7C/1jsNU6gDE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSpQLD1KqNo1hC0xzPG5ZGQFXch2NgXu7X/D1WyYAvj0ymKZezUG/JOhKAeBpSdx6EYYNDvSsUYtSlL261VTaytI3qcyTyG757kkZ2cDJUij6+DucyY87l/moh7qA8u6douR8EtVJdFTeuCS//avrPc3lIKY/IletQpSTH+I978=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ubejLry6; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbSPLLrKYdN/7zRA+zoSyrVp+ZGA2ju+VJMRMmgDPb+4RVoXnED+GNAubKw/HqQkASeV/0KPwd7TIi/gMVigspAneGci9Z8Bk0Jtw/3eJrbEjjEYaKvsWJmLPrY2OUApURtvXznEfOghdbnAN49mf+v727dM7gn53zfqyV8MUhC5KZhzMupzY1PD342Kpd7h672nX92Z6MRgYB1frH2KzX6XFO1FdAy2FUgG73jBEtxymwyUFZjEBp5rpdWvYKXWektBe2zd9boO9od1ZZQ19WE+V7xzD9PoHP4EWzZ2jOrFs0s5hpHmVXT4LOMR55257+tcD8qE2V1YzOgZAKEaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVKR0I8f8dVv0OY3V11gaRYIUu1t/U8DlDvdZLegwYo=;
 b=Fm7ZpXy60OQwu8b4NUURoUKrALcdbU4t+RXwlezS/71jtrGHgeRFHDzT4QVZ6ksiJUW14Bobx06Wn10XEA1b2Vf/3LpVMTFkXVERnbHgnCeo5fn3nDsbRAQnudrcyyUtmvC9ymaPG/FhZJZeCSaDmvlCJkotfwuIDgOagtSN/SNS3uPkHSBSXIatgDTbhw0vjP5J9VTRvRAkFafq/WjldKm8q17U2XNnOqgodxDQl5ZUWurDjKxEKsUpVm589/AU1AD4lNFawpyybUJpCGANYBZephYvf/uVxhaqtszDp3VQ6yoJEBGYNNSFPtSBu+GehJKS4vmtzxp9tVCvzCJ/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVKR0I8f8dVv0OY3V11gaRYIUu1t/U8DlDvdZLegwYo=;
 b=ubejLry6vTYbtZ+r7OpQXOEH1vnc1rHo65f54q8Qdv/NnhTbpb+tOfCVPf0sSz9N1DMuWHl3WbHfOtXgdiu6XRSdYrrZNK5qUM+34MQgUEDGwzxli276U8YLp0ISsOMeyhdy5++zVfcuTiOseI3+0uVpfRPPbUJPygBOoigf18H7kLiS8esibeH2ANuIIL7rBlPvJoHzMcOkRaXvDL54ZqooAa9nnzGx5bP0N9sr49yJhcqPa0lTs4vJa7+BSMosxBHrD28wyuLMtbwQFQIH9USOW4mV4TlwLcVN6IunHaVCscXIsQbgBNbhVS0iQyzGztb4hxvqHkjWli3ujvwlRg==
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 20:51:53 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::4b) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Wed,
 7 May 2025 20:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 20:51:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 13:51:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 13:51:38 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 13:51:33 -0700
Date: Wed, 7 May 2025 13:51:31 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>,
	"bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
Message-ID: <aBvH046KK9V2YMRx@nvidia.com>
References: <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <BN9PR11MB5276A00FDB2685B394FB9D4D8C892@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBptQO9VBnO2AG9V@nvidia.com>
 <BN9PR11MB527651D1ED8E6CA4677FD7678C88A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aBsN1ZDr+jJJ5EG0@nvidia.com>
 <20250507123333.GD90261@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250507123333.GD90261@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: 75a4f5d8-479c-42c5-3d03-08dd8da8ff25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T/58WjCzOo7+M9ylm7OqfN0KJGKy7wmWaogLnS8yDKkoGALsU5nXIrSw5K98?=
 =?us-ascii?Q?PItnvgHUEClNmxWdBw6oy67Yp5B+NF9iNhmW078s+05R3VXQjarpML+UJzVJ?=
 =?us-ascii?Q?cCwmqgzypTBoD5p8e1c1EZ/CGVJQP4E9aJDOMUK8lT266+QY5xSd2qxFT6Tj?=
 =?us-ascii?Q?XgpBJD8bSy+RrY+MWkBoRJATCik08Hf78lFvwm1tyJGKLAgeUNqnP9RO/m/V?=
 =?us-ascii?Q?Yry4113ADtEvdqZEwYrCLfYgShlSzP2pXo8DeCogu9ep4GH8GysQ03nWCRDo?=
 =?us-ascii?Q?oq1P07IHacKcpE4Ix/HXUQl2VTepXYrk1Nm7adhPfMbJp/MDVjkoKQ4LW+uA?=
 =?us-ascii?Q?eIlPK/+nmzFx9Hx45heYAtxo+mfHJAut66YiX2Kt6ABd+toUvN+3JeArCrIk?=
 =?us-ascii?Q?tUPl+VYq2QBnJ6PzfnN20CB0/jqATif/jpWVYshzZV6Iv1SgQx+XyrzPuKDi?=
 =?us-ascii?Q?3uZSZbPgmlr2XBuKtHjJ6wiPc4D5xSHV+NVpS58C5w8j350Mlgiuq3dnx+aP?=
 =?us-ascii?Q?1C0z/KgrRdMXQCP9J2nb+DQt1x92JwAB2eMWYuutl4p0DiNv7QByMtPnwUim?=
 =?us-ascii?Q?7+clvYQprwGDBiU1Qml6yYBnJLNCphema/IMLNc6dNtgHJOBKqMNx/tWP5Ni?=
 =?us-ascii?Q?HkKMjgMfu7DXpB4xhFav5K4oX760Ojg/TLryCG9/p3TsPatG5OKrKoGM/0Wf?=
 =?us-ascii?Q?VJ6rJiYuUKAjqj8LL0+BTAQ8nWiK/581o7Y0kB62fouAWWxquHRo4UwjFEQA?=
 =?us-ascii?Q?fCKhKrUgruIXKsbJ5BXU/uL72exH6ROmPGgbpDHSztSpX/ahboU2GrTKCtF6?=
 =?us-ascii?Q?aiWM0U5tgY1PYjHcRdP+C48XZwPrMuVp/2GG8Q3cQf5aJyttp0ADQmbgF3al?=
 =?us-ascii?Q?FxkWFZfygJO5yIRlkm95oDV5PV9ugke+EH7Cnihp/Ybw36cB+LILkuBCJRgJ?=
 =?us-ascii?Q?OwmiGc5PvKx37qjXff+XJ0DlenB46HyIzD6WCpanvKcDxjgLK2VGYfyh60RJ?=
 =?us-ascii?Q?DNVuExUJlSMlAHbDPaJ1ng0afI91tKknXp4nAvmydR28KlAYHyMPDFis5tLT?=
 =?us-ascii?Q?Ffq7PgYC3pin9Mg7+jjqb7CqPdNNJ1M28hsJMKp4T0a65UeUphCxGd/QMwAD?=
 =?us-ascii?Q?abTYFvGNwCtANts35VAZrG4bm9dDNZfECq/zPuczDRXTLT2D4r20N2h5Vy4j?=
 =?us-ascii?Q?UCbsvqVRrgoK8737jAm9hSDfCK1qUHwE5WXCIgL1eN4MmZXHh9V0ibQgCOzp?=
 =?us-ascii?Q?waCsBeaYkrZcGTDALOwd9U4n2iBZEY+E9EygFoVz31HGcDLj/5srnIy7WPux?=
 =?us-ascii?Q?5/SJslP1ObqVYlJ+7TGaLPXTCUOX2piEdshYuMWbo6ay81p7kAknRlCDTwcO?=
 =?us-ascii?Q?VEvQWqPYHSMfrzIkiBXC/+5XZhDCieKdkykOYCwv41zOHmElDk4t7G7l8QUV?=
 =?us-ascii?Q?0efGfPfRpzoEAC6ipIGNh1EWx53i8tu+ehJykBsEk78Pht/+yaNej9t0PVjZ?=
 =?us-ascii?Q?GqxGqw7PWnXpREfoGG17T7izddX5Zf1DPoaA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 20:51:52.9190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a4f5d8-479c-42c5-3d03-08dd8da8ff25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845

On Wed, May 07, 2025 at 09:33:33AM -0300, Jason Gunthorpe wrote:
> You could just call it what it is, "DIRECT QUEUE" or something along
> those lines to indicate it is mmap'd and so forth, vs being a SW queue
> with read()/write()
> 
> HW QUEUE is good too

Will do HW_QUEUE, as Kevin +1ed and it's short and understandable.

Thanks
Nicolin

