Return-Path: <linux-kselftest+bounces-20605-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F69AF908
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 06:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CBC1F224A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A018C935;
	Fri, 25 Oct 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MuUL09Tx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4301A18B487;
	Fri, 25 Oct 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832376; cv=fail; b=qqdGfLtu2SRlKzi6yG3Sa3FUwjX3pFAFSja74ZxwLUvMqg/EkWhL6HkrXnz5n3X3rUtzPmVvVmLOwGCuJKdKatu56So5olzDAnX4Z6UzNkV0DVJH2h2oiBYG4MIPUGQ+3e0vl/ARrIFKlI1FAdOc9kaB70JxiBHWl62nRoOd+oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832376; c=relaxed/simple;
	bh=XvsqnV1uqcYPdlmfLgXrW+Mbo4A5ue+u2r0DFyINtzs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9nFX/n+CmRYVkSGJPv9WbfdI3NywyrBA1sMRbZYmhPAcbibWqNdJ0eE0WmeY3hq1c2PSKLj/Hyl2eJXrnEpYpdMFm62NbUHb+0Q7jHRtoKr88XXDzxPdGT3PKr3+Y5+qvPftimYk+3t/2+SaLvs0BcrYkniYLaSjwRQ4PcUTH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MuUL09Tx; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIq0QaNgr9EROzPqdtTDPCxlfYx2RDjB74zi9Ao/QbVXtWZkdTuxoK+sdklv1AeaBJADg7XgdVa/RPKRN/ymUSgXBw4Xp48Zw8hdmraPkD5TBPVI3zXX9RKy/3JaA+QJ7g9rCyKuBaPb6x0S+R8YF08VWwRNe38Y9BSYCFG71Ng/j6pN/gnTM7GMiAL3OTelsH3xIpgYON2PW9hrXg7PSavEJp6rGHe8Yn58kTuM48UVFCtQybzLeoUWfJDtV6Vn5R86Voov/+DjHjET/ropJBRFxNSYkfSKvGAHMoY2Cs0R2Dde4a1zOczAY+V6KNQYeREMNnGC66FEdoYN0fkAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eweWppgL+Xt5gS+zV/BBlLpv7VvCaCG0CFpZXQ3MXNs=;
 b=iGnUQeutcs2hcnXT6MxPkKGjW6k0iQg3RJEdLMk5n69l7rOdVwZ6jNbGXXSVeqEB+Zz6xMe+lLJpbxW61fYHu2LpTxUWbk1Zw5Kw203nkX8TWFkDr8VLlLJHEo0ZfpdplrOyi8QPrp52CbtI4Jq25sRkBOtFo3VeKNg88ne1v9G69gswQW8bvAkBSKr59LbcyJeNENr5F2LN7u7xUcf9FMEunHX/mnUGCQ0payEqEfcvt3H75VyvPjVFGM1BAaigZv71CVlmW9FkCSlBjuD2wrVgcd6pyrHY2xbPdGZcwsm8TlmQz+LIjt4YOfa4ADLup3ogsL30MTZyp81ioT2+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eweWppgL+Xt5gS+zV/BBlLpv7VvCaCG0CFpZXQ3MXNs=;
 b=MuUL09Txc0sKX0CJssjeBFJHSqafVc/QKz0oHhp62OChVAyaSrehrgWq2PYe8iliqIYYkfFB1aljiU6EsavNpB4I3SaNh3rG5iV9ri99cwpI6mqTlVc/wYYo8Y1NcFPe0Umjnws8JCHqmPphXgIEYUiqDkLnROVmAGiPQlJLjJ3LjzMcTFLyCm4JRM1+gQNVJXcX6cWjJvyy4MFhV2yqbI8A6cYpcQ7+pIbdDB7alHqJxEO8UnloqESrxd4TK3DZ6JGD9uuhG7eH95dQwnZN5NDAVwT+VBAb68SvIxkEWWZBAQcGg5qNbW33wsThRGh8WfnKpBzpSqNFrzKlLIp4hQ==
Received: from BYAPR07CA0067.namprd07.prod.outlook.com (2603:10b6:a03:60::44)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 04:59:31 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:60:cafe::4d) by BYAPR07CA0067.outlook.office365.com
 (2603:10b6:a03:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 04:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Fri, 25 Oct 2024 04:59:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 21:59:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 24 Oct 2024 21:59:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 24 Oct 2024 21:59:26 -0700
Date: Thu, 24 Oct 2024 21:59:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Message-ID: <ZxslrakslZbphayO@Asurada-Nvidia>
References: <cover.1729555967.git.nicolinc@nvidia.com>
 <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c111c4-b63c-4c93-aec2-08dcf4b1cfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ayP5XhxnywFvdscUpDoB6PGAXmeGdFMaiIqBDHLO9J1lChDZ6nhyjuWlRpep?=
 =?us-ascii?Q?0ZC5xY3jjrRDX8CiHlESYec2ntgpu+FDTs3dBHtxnCQtuz/GJIEnLse3jNKl?=
 =?us-ascii?Q?juMuiWJbbMSCv9JItAF0FCoHixd9uhQktYvGk3/P1SEg5bgMVrr8IY1NWays?=
 =?us-ascii?Q?qZqbwIwjikHjWzCffZtBrkFEgkp5pB84CmtCRYw56lLHAaBD5DV7O4Fftzpu?=
 =?us-ascii?Q?6K5ruZBrY6dewpn8yRHkb04QJzguSnAZv0GBv3enES6YQi7e0auzhMsOXYBd?=
 =?us-ascii?Q?BziY9kXWicK2+5BDzbYl5yBfzRDZCcJCj7OEZ+tBGpwyzVuuvV1nyH570sjC?=
 =?us-ascii?Q?CnWtBc+9igqCgU/Ad4UrrbbnfwebgYUloSCvj7BUphTHVx+PjtEvG5qlRJTa?=
 =?us-ascii?Q?iLPgaOyRdT7U2ImVq2wTspG3MSd3j8QV6gt3Gohq7ssqLEWOFh+JAITJx69g?=
 =?us-ascii?Q?E3oaTHKznJPIbf933haSaop3l2pBysXPfwa18Flgkb3l+yA6HcfeuSU/9qH8?=
 =?us-ascii?Q?9mYo1uV2KA8gSZ1Qn8WkLOjCbPiAcTTNhqz/zl2F+3lzl8Tq93P5QuVOT7kG?=
 =?us-ascii?Q?jwyvF4SUxVHdm6aFpqYJMg/OHaRFTwJidVb2P+vcvklQUHenSxOQotDmLG5A?=
 =?us-ascii?Q?QJQrUnpzuPTO23QUeon6oiv/k6/FtH42ZBeEReBamCNq6KzDRfOZ2XyxgFNy?=
 =?us-ascii?Q?JgaPWP2GAgFlTl8cOrB2sV9enR3thiFly4x2frfOAc/MCCEMIqkCzinwuMgO?=
 =?us-ascii?Q?jpDlewA1+UviRdPjmPoikY4IiKAJqg3XjGyIZQZNJxysjMzc6Fe6aYsPs4B4?=
 =?us-ascii?Q?WmrBRQ/m0lQrKwAseZex/tXrNk8W5+UJg3KZK3FMJhi7LBtDRQ4VP5o6xPJD?=
 =?us-ascii?Q?w4MMRnHs2Afh9fRLRCnxxVeZr+rvRAQaOfv6iAH0z3tXOOcwfdZk1mKi0K9q?=
 =?us-ascii?Q?Ese6cNH+ZllEn/m1QEWZ1q8hyF+qjRuQ9xP9vzhIx9GTt92edsJQvzuHT51+?=
 =?us-ascii?Q?LL9ItGQ3vIz2XnE32pFY9cEwtIr633Fozl6BQHwI+Cs/XqtMnV69zgP9Xr77?=
 =?us-ascii?Q?1tXdQQ/mcEtainVDxOuJtgOWJkmZDAONFnlddsqjLsJ6CI7qxpCmMjZpdxGI?=
 =?us-ascii?Q?sXEl0Rm9owczhULignOUYqAt4cNJkoItEddAm6iyc5KWVrFLoM6XDMSGA7sj?=
 =?us-ascii?Q?Gmr9T1JWtKMTUxMOZKHgvE0bxbvuxAH9yY2bpzXyX48nkTg6/gZkfaMYaDOX?=
 =?us-ascii?Q?ZDzAWonm9MdySFd4i6CmPvrgiuK2gmVjs5U9snKJai+m9m5fhEsk12yHfX51?=
 =?us-ascii?Q?Vx1kEUs27jjHW6t3WP8qQ1yTDjxWY92BpqNrKvSSOkV1eEuL9dUpffUAs80/?=
 =?us-ascii?Q?CbGORrqbCOTPnvHIo6V0DK1W0JolZv+zwZJni0wlr+GIeW0NuLuD9kqKvkhd?=
 =?us-ascii?Q?Sbf6TWwQgKw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 04:59:31.4133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c111c4-b63c-4c93-aec2-08dcf4b1cfe8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

On Fri, Oct 25, 2024 at 03:54:44PM +1100, Alexey Kardashevskiy wrote:
> On 22/10/24 11:20, Nicolin Chen wrote:
> > Following the previous vIOMMU series, this adds another vDEVICE structure,
> > representing the association from an iommufd_device to an iommufd_viommu.
> > This gives the whole architecture a new "v" layer:
> >    _______________________________________________________________________
> >   |                      iommufd (with vIOMMU/vDEVICE)                    |
> >   |                        _____________      _____________               |
> >   |                       |             |    |             |              |
> >   |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
> >   |      |                |             |    |_____________|       |      |
> >   |      |     ______     |             |     _____________     ___|____  |
> >   |      |    |      |    |             |    |             |   |        | |
> >   |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
> >   |      |    |______|    |_____________|    |_____________|   |________| |
> >   |______|________|______________|__________________|_______________|_____|
> >          |        |              |                  |               |
> >    ______v_____   |        ______v_____       ______v_____       ___v__
> >   |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
> >   |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
> >   |____________|   storage|____________|     |____________|     |______|
> > 
> > This vDEVICE object is used to collect and store all vIOMMU-related device
> > information/attributes in a VM. As an initial series for vDEVICE, add only
> > the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> > e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
> > a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> > of the device against the physical IOMMU instance. This is essential for a
> > vIOMMU-based invalidation, where the request contains a device's vID for a
> > device cache flush, e.g. ATC invalidation.
> > 
> > Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> > by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
> > with a given driver data.
> > 
> > As for the implementation of the series, add driver support in ARM SMMUv3
> > for a real world use case.
> > 
> > This series is on Github:
> > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4
> > 
> > For testing, try this "with-rmr" branch:
> > https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr
> 
> Is there any real example of a .vdevice_alloc hook, besides the
> selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the
> question. I am trying to sketch something with this new machinery and
> less guessing would be nice. Thanks,

No, I am actually dropping that one, and moving the vdevice struct
to the private header, as there seems to be no use case:
https://lore.kernel.org/linux-iommu/ZxsSYbK3gqyC84U7@Asurada-Nvidia/
https://lore.kernel.org/linux-iommu/ZxsTAANTTuQzQ9HR@Asurada-Nvidia/

Do you need vdevice_alloc in the driver for your sketch?

Thanks
Nicolin

