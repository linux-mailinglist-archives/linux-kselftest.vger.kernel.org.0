Return-Path: <linux-kselftest+bounces-23843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E1A00329
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 04:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660FF160C73
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DDD1AF0DB;
	Fri,  3 Jan 2025 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m8hn85ia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848A1A841F;
	Fri,  3 Jan 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735875058; cv=fail; b=WcbvJNc2PQMYbpO2tx9a6RxIXnR+uRK4V3UMATe2EmZmtdffWZ4qeufhka7HRFBaxP+a0SWlO+YcwZqwx7/2gviexla8DQBMvxDW0qmiQU0b+rH9ARDr+Kgsepk+Jzt/LrV0IH+tbsitbLYpMDtdrOGPApZ+Vewy0JET/qAjFZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735875058; c=relaxed/simple;
	bh=Xh30XGBo73Frhq1QDT7A5HXd9SPLn5+PLCefq0QC/r0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8UoiouvP9xl3Mhzvdo/MkYG4BN+dWrGycp+42Xw5T793oJVdCGIGua+eEFTdHLoM0qRdSEmkZ/KWlKz+sP+gz/+RYSCRUITzD6IfhM+9iSKsH7BkThqD58cFBkoaQVPQRpt21C3jDUVQaBzcxfj+zP011rylIkxFKbsSdhhdGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m8hn85ia; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtfptRFuB+Uj7waYyGBj1wQxMW+/dH/iJCH6UL0bSHJX5aBdWQ7AYep27PkrMzQ1djOD9iODglQZeDv3ntWWxO14qKbAJ7dXTC2w2JpajO5jQ/zuF9kFRjvkYPPG1wVCBkTuu8hFK5rAedsmQMQEgX/MyG4t6A57ao0AHw6V3NaGpEU1YC0kpoMgKrMqTh/m2D79pf7ceR+wAXVXoBi4SnsMmvOU3bWyD4rW8s1LQFLdg6SQ0FGuBVz2weyf9faGrt4DFo0ipE8bSygqunbJOePe4ET/Tryi9X/yhD/VucBHIi5ZUCkhrjogOuUe/3Z4LLLoDN27GAwYFR/Zr2LQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VClTDqtsVt337smE9JJgA0ELO4R7gmBNJq7pGD0y0jE=;
 b=UjGnMyStCOPY22JbX91Dv7ifWPbKZkqyKT15vkYXyI5M76KE6YWb5xawBCJRsHlRkng+GmcU1p0KSGTIeoIrU7+H3TAUUVTU6s3pAfNYhGhlvPUBX44a8DMCNjS/gZGwmqRshzeYwVEaqEBhPWh7Q1P6Q88eg5vKxiW+SFLtL2J+ogH6tiW6N8NHgA+LsAX5tkCnvp+HaHcTTkC4z7k1UeszoW77adZ2s3R03Z8/oHfDAQl9Px4U99a5f++6iTByyzITacWHPK3CaewJ1yDji+ORRZ0fyOCWTdRjSsXSvF0VBfFDg8xfO35V8jdXVrxI751nhk1eZ8xyXBzNzVntgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VClTDqtsVt337smE9JJgA0ELO4R7gmBNJq7pGD0y0jE=;
 b=m8hn85iaI4UAaf0W6zvWroMF9Kn0pkojPM+zN2S5fLMpP9SrqZGsyLIs+673nC5AOSwjknPSusdKaQviOtAc5rSwhVEydPb70TmFciUPgUi0N1+hzFPJaFqvXzJNcMewh3RXv06ErFmtrc0HCFeKCn00y6U/FYwMPZvMzZHir0jPLv+LExMC3/S/3Mf7rDeC2RCxxIiRvkC6yCC9q3nGpmc86CFUdSvxkDI8sttZx2U4aAC8xEPdsTnxtufLESIADWULKg6XHOxip8udWWDRkoaPfJgkFR6KxmkfiSGUCMMlvc8GRBQglGtVNlKsvgW62Vh1BO8o39oKUm0E8ZqHwg==
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 03:30:47 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:23b:cafe::bc) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Fri,
 3 Jan 2025 03:30:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Fri, 3 Jan 2025 03:30:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 19:30:26 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 19:30:26 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 2 Jan 2025 19:30:23 -0800
Date: Thu, 2 Jan 2025 19:30:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <will@kernel.org>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 06/14] iommufd: Add IOMMUFD_OBJ_VIRQ and
 IOMMUFD_CMD_VIRQ_ALLOC
Message-ID: <Z3dZzXblPIlxXEQ+@Asurada-Nvidia>
References: <cover.1734477608.git.nicolinc@nvidia.com>
 <dc1252de7ff06c944cb7d91c91b4f61c25182f91.1734477608.git.nicolinc@nvidia.com>
 <20250102205246.GG5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250102205246.GG5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd02fda-d8fe-4b3e-edfb-08dd2ba703ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AP10rSWv2wCR6rDunCXMhMAtY2hhFImzJrDFtNjIlD+UANJH2QfFTGv/gmMe?=
 =?us-ascii?Q?Vh2k+IH0lAqqeLEJBsXKrn+E8jOif7aiDEH7UyCsAqNXg6KAj6B9RehrSlxv?=
 =?us-ascii?Q?J8jMCGoQaeCpwrXjgxUr0NXbOES4livux+hSen+1XGHzLKl3TyLnO9sY9haP?=
 =?us-ascii?Q?0sQcMVujJqwZd1SYozz3y8M5xYGYarAPSd7l9ZByFseQOd7cb2xSwxp6FUA0?=
 =?us-ascii?Q?gWn2cVQvhJTDgGfvJVGoJaPSlWVJEcFCWpjmg0yYuA/n5VFpMBvlOAlNJQE5?=
 =?us-ascii?Q?dCvk1/Q5RMWR0p+D2CP+anePxA2xTJzgH5+8VAn6IWbTP9mrj5gp1Hh6vlx2?=
 =?us-ascii?Q?BgTR6ByOH8KIGCIvMe9p1yzUpul+j0P3FRWhB/heN7TFRcRh5trhHlDRcQSS?=
 =?us-ascii?Q?nOr+Thg9pSOBS7j4Bk2hUbQ45p7aMMeyLnwvq62orurrUWKM/8iL1tcr5H0K?=
 =?us-ascii?Q?5G0i78ZUhTThMmuQTmuSx2jsS0rFNyV+iU92fqMOsQgOsOcPsz4cBmL12GJP?=
 =?us-ascii?Q?jvNpAYHTu6zBTZlXRnd6ROcwWpUDG/eUbuvj6ptNflFipPPzif6f/2tJudPg?=
 =?us-ascii?Q?OG/ygJin3qiEFE3HL0SduOXjDssGtZEII5AeLfO6T2cGpnyZ2uU6pfKUop0d?=
 =?us-ascii?Q?8/am6YoO8SvQoWgXFzxNNBfHQcD2LbUHHIJ2O+HbtmmdJyyZOoPrWH9XHvMk?=
 =?us-ascii?Q?aicIBV6zB0S1ayLG9TDIQbkRCpfJCGQMtYie5jNFdmeQdiejWjr3hCNcU5Z5?=
 =?us-ascii?Q?9jPIKCq+RFsTRATfJ6mH0aMFwndQJVjYCQlLoLnY5eBvqByBtl92KmslTm7s?=
 =?us-ascii?Q?+gxdNXF0aN6hGMO6kTVVNcqu7mydZTKaqygN0DJISHiqnJg/T/cu/P7eyO2N?=
 =?us-ascii?Q?K1uGrMVBoKUPCDW9Z8cnRB0scAXXDL14XbO1LrFQy9DfzeCJcPbTK+4nyg7z?=
 =?us-ascii?Q?Tt9r8oNI30fdVnElva38bSigzdDxaqbsMaikqYD6c6KgSAAckjLU+EMZEEg1?=
 =?us-ascii?Q?snnLBcRTWf1RvqJNbYAeJ3Dil1EKwr1xzewKBUhX5pyHAwCoGPdBNRgk8A/i?=
 =?us-ascii?Q?kNZp4lHWT1UBWfJqt4H3YFmo57V9AZ322KnB6DDk3vVXGFNblhRtu6WISOV4?=
 =?us-ascii?Q?GNyhxI+FWtTrgwRdNRhlJSze3EqBrhpvzGhZYw4j6c+oLAxjLcIGIHvXmXfy?=
 =?us-ascii?Q?Msozz5x1AG90s6JRxw7XYIFkPSCNc7kmj/wBqPxL3uz9TIVyhj0gfevzWsWS?=
 =?us-ascii?Q?Gi4325N6Q8ncO6iEWmZnowVk0Lz5QeMPSA/fo5eUJhYEWBB8a2ziQ7D6uYZM?=
 =?us-ascii?Q?AqnG8SQKLmQ5g4xR9qpwPKwoICtruKgLQbRY1UtpoKoRfZMWLPFOrkNhhPYA?=
 =?us-ascii?Q?kyJ0yPjyvIoItQpmLFWj1xkybRsMNk7DH4ZvCUbJNsT3sgmvbetKZvoZxDTF?=
 =?us-ascii?Q?KMRpXA3Cs2OTryCyTgHt2ReDMpMGkz0xbcfLPfWXk1c7UqirswCBiHomb3a2?=
 =?us-ascii?Q?16HfmFujEdRp7S0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 03:30:47.5710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd02fda-d8fe-4b3e-edfb-08dd2ba703ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996

On Thu, Jan 02, 2025 at 04:52:46PM -0400, Jason Gunthorpe wrote:
> On Tue, Dec 17, 2024 at 09:00:19PM -0800, Nicolin Chen wrote:
> > +/* An iommufd_virq_header packs a vIOMMU interrupt in an iommufd_virq queue */
> > +struct iommufd_virq_header {
> > +	struct list_head node;
> > +	ssize_t irq_len;
> > +	void *irq_data;
> > +};
> 
> Based on how it is used in iommufd_viommu_report_irq()
> 
> +       header = kzalloc(sizeof(*header) + irq_len, GFP_KERNEL);
> +       header->irq_data = (void *)header + sizeof(*header);
> +       memcpy(header->irq_data, irq_ptr, irq_len);
> 
> It should be a flex array and use the various flexarray tools
> 
> struct iommufd_virq_header {
>        ssize_t irq_len;
>        u64 irq_data[] __counted_by(irq_len);
> }

Changed to
-------------------------------------------------------------------------
/* An iommufd_vevent represents a vIOMMU event in an iommufd_veventq */
struct iommufd_vevent {
	struct list_head node;
	ssize_t data_len;
	u64 event_data[] __counted_by(data_len);
};
[...]
	vevent = kmalloc(struct_size(vevent, event_data, data_len), GFP_KERNEL);
-	header->irq_data = (void *)header + sizeof(*header);
-------------------------------------------------------------------------

Thanks
Nicolin

