Return-Path: <linux-kselftest+bounces-23958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB09A02FEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B213A2817
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3D1DF971;
	Mon,  6 Jan 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mR86ZsHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4A1DF24B;
	Mon,  6 Jan 2025 18:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189201; cv=fail; b=UEt6eLfR3TgtOM7UTvECTYfxsJEqAhuv/I69lbXQRzdw0eYVtf0nDI4reSMtVgtB71KyZ3eQCn5Z8C8mg3a2jcUnv2VQRICjkaLQLieXNC7I4lgDNVA7X6XFdtBe1HNvdrFYXVlnN/ldozqGioiNH1na5iuYRSPes2DFKV8Qs4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189201; c=relaxed/simple;
	bh=BKnvbYyP9sHEuz1yR+C2wixPIW+WQnlx5/wC0sKbcfo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV59tpFe1WNdarLSkX8x25jm710s+o8dYOG03lubcklv4fk1u4adnds/kb1YgAAq9OFlGTc4G6khRuJsXL9UQl8sTBUVyU0cz1ssD4xMHoUmH1bafCZeq3vCy6TYxoMjedK388vo8FY274txSoiBX5waQey4wpgjAl9i/avp3pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mR86ZsHz; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE+TK9aiKl8/7KpEfnEtNGI+sGOHualbyKBzeneViVa91C2qt9ep6hPJ0AViouJqCIp2+8My1DJoITYDUyFOneaPAj3WfXpMqydDK4yNMqqvaWQL1BfQ8NCPTWbWejMXnSRbDFc4VHwsGa49Hn0uFPmTv2jX5UtklGTi4y5lIhJab/JKZHB7r1DHiKwGJhj5xlTHhcPclF3DKafehb/l6i+oBhZe0o2J9ccB1EE4MEC/RxQGR1gVYw2LYJi0mvVyYOAaxh8kjSYY24BVjehF/G1IcGscEafbU2BoPe+/Bwd9GPa527DBr5xBcE9rWxpq4hV5vQa/Wr7UPWq+EyUo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4pyQMQesI0VN6u/oMLqzRbScdAPSCw9Xw8P39SllYc=;
 b=MssWKiyI4sG/SrNB0slqZ11POqt3WL68z3AkXyiRLpWGOKQOR7bS9bsle91WMmRIae7wpQr6dFlXCGiaorH/CmTWBBZ31VDnaLk4X+bbFpxJeNqEg4mXw3UuHE5Z/lwYiAHVKhW4NEEn8g5DCZ6FTnmkKzOx8zTru6HMHBtk4Czo996gxEA9qegOc2RKtY1ka5XrGMkOcmaeuVh1bVxhkh66Qrd1kyL7PIN61Jz/Jq+54lWtYDK8CviWLw7EhGkIgezlr3Z2s4m2Sj+0jRdvQa8ABAbMMmxtv4nJfiK2OgLxDX2t2Q9QOJKUvGu4z8sjeURzgJ3W8uDjdOQI1piEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4pyQMQesI0VN6u/oMLqzRbScdAPSCw9Xw8P39SllYc=;
 b=mR86ZsHzIerCdRlHXJwq+LQ8ItceV28iTOT+JSKbFcxJdiuhp4y8AK/wfLUprddF0OvArWJPCmAR8MSysY/LTd6Jxt5lz2suSuucDPixtbuBmzWN8JzJwgvwE2mcV2hOZLWoxruW/MY2iL+gx3CD4847jRiRnWM3dCdrmYUSyLZ/zerByJ45zGB7mHVoSR901ubALKprPJlgH8cSwzPS1KRF2syfebE71+S8oiAKnr7Ny9am2aCtYI8SCCCO4NQMelSTFBd09mKvD5f2wCqt5I75904IQnmHV8DFY+g4Ea89Z93YttH0/wCBV0Pkq3VfS1Bhg2cxwAOItakUo5iQhQ==
Received: from SA0PR11CA0094.namprd11.prod.outlook.com (2603:10b6:806:d1::9)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 18:46:31 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::d) by SA0PR11CA0094.outlook.office365.com
 (2603:10b6:806:d1::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Mon,
 6 Jan 2025 18:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 18:46:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 10:46:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 10:46:17 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 6 Jan 2025 10:46:15 -0800
Date: Mon, 6 Jan 2025 10:46:13 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<will@kernel.org>, <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z3wk9TvmUhB3/zlk@Asurada-Nvidia>
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <69a46c72e43ed086840be462eef731167d90a9d8.1735933254.git.nicolinc@nvidia.com>
 <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <585fc99f-c2dc-459c-929a-c7c7631b9caf@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 77764df7-e657-45ff-f8ff-08dd2e826fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGOlOI6BMW2nbGCbJ20oaNvRebmWx/aSrVKG/eZtEMBj2YLTPiMM/s41SfJj?=
 =?us-ascii?Q?gO81cPJU81IV8Wz0JCSUxnIHtbGHja0KE4Uoui5aTlOt5zOavXwxiNZAhF9n?=
 =?us-ascii?Q?1VSdPrqZlDlBnjNORbTr0gObWzc7YcjGuaGl5Gn0AZjT6TDw8jW1Pz0K5qh5?=
 =?us-ascii?Q?IcNnl4ELRD5WimUfWelXNX8ZIk6JT3FLefadOewQeOz0rhWJsHjpZqAyI1JR?=
 =?us-ascii?Q?waTO+WRy37xXnz0HWiOUSDgm5mZXGA2wAtWui9+IClGsqN/E/IvWROW9P1O7?=
 =?us-ascii?Q?RGQq6bauU6G7UrES8x3JS32pJvX4lkL3Yhss0oL8zBKIsjc3QPtGdLQKNxhS?=
 =?us-ascii?Q?1z6r4hgg9zrsYdfXWYhn5Exdm4YSdLh32FjszModqG8sqz9+AYAhKQ0Nm/my?=
 =?us-ascii?Q?UEVyDYIV731UO/AiilNsjJnBBbRsq/ljDwn5vDh03BnmKxHNSH3joNJDHxp6?=
 =?us-ascii?Q?Cla+kEsa5VhWKpAyDG7eNFS43eJH8ZatXqO5SaBZFeZ3PbpgxLH2536TSMOx?=
 =?us-ascii?Q?50Nbbqf9SvwztiVwTYh2cA8ypJ7yNQcsZCS3xF28CIEEdAjCgadWXddsN7R0?=
 =?us-ascii?Q?0NedL2nT4NneDLiAP9ovo4Xm80Lz7V84av87zu/RymbGW1S+sYl4Mmgno8Dg?=
 =?us-ascii?Q?+l3EatahAORr2E2JgnCVrIo88i7e1B0OijJaGxgzBEjEcpHF/COl1Y5RhmW0?=
 =?us-ascii?Q?0qdtDAbB+rirEDgL8OwrRSxURuvRHrn/suNynF9cShTGIpEhtrYjsYzq0JpZ?=
 =?us-ascii?Q?WgkzQK01vM0NbtSzWmw3d2lx0XXQ2ut+DTJlfVR6miwd5EJCl252ZnpyXkUl?=
 =?us-ascii?Q?3Ng60aaEwW+iXZWoCm1Hkc29oVoRbUj+JllBzwf+M2LzTIK8YBezdaatK2Jj?=
 =?us-ascii?Q?hbcmB61AnsDoZ2rmmezTdUr5/PiHqEdIy3Ex47ICvMvh6/sB8dvNYaZLseOc?=
 =?us-ascii?Q?cTqVKQdHvzObg+Qctl0s4Rd4l7a4v9AoRUhcz23nXvyN+z7JjDz45frhHQZ8?=
 =?us-ascii?Q?Bo4BK0U/874Bj69418kJlxCHGe1PITVNXG06B+k5+c3Xh8RHjsavHMBy9jt2?=
 =?us-ascii?Q?wFTsauhJQWquobjF+LAO1Q0zUgOyhHan9qeplO5W46jvsrNZG4eNj8/9wCyV?=
 =?us-ascii?Q?Uq8vCoSrKxP/AXUaW5/pYktEFG6HFPp9vGRLeXxeeUNLlcz5Dzggp3h1Vn+7?=
 =?us-ascii?Q?0taLbFfoQwhQvPcvzvBE09EqKH6R7iRUXx31W/VqfjSj//0zVKQy5GXb5kiz?=
 =?us-ascii?Q?H33vv0iXZdWsSapO7wJ4rwbvtVZPBDjAZ7NEcKSHZ1GrNgeBx1T6Nb4dY6bL?=
 =?us-ascii?Q?8SmIXMIFe7icRW33hsAXK99WQLBLFeEtjId5dq5j9yIo7HaCeh7mAfnNqPXb?=
 =?us-ascii?Q?TVloh6YAqFG/yWAe0OZj4QO/3/RIY+slSocvEIKZXtdtrkmK3m6mi4ddb8UC?=
 =?us-ascii?Q?Ks0PCpY6HcX4asta82hg0/pTyXPYpSBg69bhu0iFQNWSAxIGOPnn4M40rZ5R?=
 =?us-ascii?Q?duWGRkUn4M+xnpo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 18:46:31.0812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77764df7-e657-45ff-f8ff-08dd2e826fc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

On Mon, Jan 06, 2025 at 11:01:32AM +0800, Baolu Lu wrote:
> On 1/4/25 03:43, Nicolin Chen wrote:
> > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > index 0a08aa82e7cc..55e3d5a14cca 100644
> > --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -1016,9 +1016,24 @@ struct iommu_ioas_change_process {
> >   /**
> >    * enum iommu_veventq_type - Virtual Event Queue Type
> >    * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
> > + * @IOMMU_VEVENTQ_TYPE_ARM_SMMUV3: ARM SMMUv3 Virtual Event Queue
> >    */
> >   enum iommu_veventq_type {
> >   	IOMMU_VEVENTQ_TYPE_DEFAULT = 0,
> > +	IOMMU_VEVENTQ_TYPE_ARM_SMMUV3 = 1,
> > +};
> > +
> > +/**
> > + * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
> > + *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
> > + * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
> > + *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
> > + *
> > + * StreamID field reports a virtual device ID. To receive a virtual event for a
> > + * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
> > + */
> > +struct iommu_vevent_arm_smmuv3 {
> > +	__aligned_le64 evt[4];
> >   };
> 
> Nit: I think it would be more readable to add a check in the vevent
> reporting helper.
> 
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 77c34f8791ef..ccada0ada5ff 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -86,6 +86,9 @@ int iommufd_viommu_report_event(struct iommufd_viommu
> *viommu,
>         if (WARN_ON_ONCE(!data_len || !event_data))
>                 return -EINVAL;
> 
> +       if (WARN_ON_ONCE(type != IOMMU_VEVENTQ_TYPE_ARM_SMMUV3))
> +               return -EINVAL;
> +

Hmm, that's a good point I think.

>         down_read(&viommu->veventqs_rwsem);
> 
>         veventq = iommufd_viommu_find_veventq(viommu, type);
		    ^
		    |
We actually have been missing a type validation entirely, so the
type could have been rejected by this function. Perhaps we should
add a static list of supported types to struct iommufd_viommu_ops
for drivers to report so that then the core could reject from the
first place during a vEVENTQ allocation.

> Or perhaps the compiler could automatically make a warning if the @type
> is not one of those values in enum iommu_veventq_type?

Just gave that a try. Mine doesn't give any warning. Not sure if
needs to be some "-W" augment though..

> Others look good to me.

Thanks for the review!

Nicolin

