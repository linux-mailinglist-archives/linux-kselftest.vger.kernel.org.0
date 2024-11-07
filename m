Return-Path: <linux-kselftest+bounces-21572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585039BFBAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B21E1C2136A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A41D268;
	Thu,  7 Nov 2024 01:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WqJ3+7AM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7818FBF6;
	Thu,  7 Nov 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943372; cv=fail; b=Iw7dvp3ILNFTmXKGqMEcTTUduRCRbZvwHY3QvAgIcE6VSzOslOmqMMFxN+OUCzzG8trnBgO9qIMcTon8FdnzuIjixgX8JtDcR892ox9p548d3sogZe6TCMgrz/BLbx3bfIlxmhuIUN7ptE2sZZH9ZbfPomHiR4y0zTFb6hwy8Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943372; c=relaxed/simple;
	bh=2vzRv34U2ITnQ6a7xv8ZsMA12Us4J5yhUCeTp58vGvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUKz73rawwULnBV1b3h20R3gbVon3wM1bfNjb7yCq/sw4fo9Ub466CbzSCsceIRxPXwpDg8wUwzaoleAts/jbBV99m0G7U914Gw50Cx0BRv5f6VY9cpaAXFfm8h1JsVM2RNpr1Jc0ei3/MFd3nc0Zej5/rLWx7f44Umjc96uJqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WqJ3+7AM; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPAl2osWRnuGpOVA5y1m2knpYRD0n72xWIAqyVjOMSRL5fri00JG4N56x5oxbVIjN8q5WEsQBeqH10s8mAgYz0WIdx8s6bXU5w9LQLURJAxcvFjBJrjynfZFh5g/ngiu9zo/9yifS31e0gGXjEvCbBDjE5DvtgZ68vEwv3Mg2euqdvATRpzqP8zCToKwsMHtM1VKeb+UbrL3ODCJfrCNaaVqTZDYksjhwz+z1HQKTKMsNAWYTBCCmlA5PeQ0E8MjBCbI95CN3UOdkiKXT40idwZZSbavJiJU0p3YnqscB4jTHBtTmrGeTIDWymmPYnfThPHrLomGcCfMtIYDFs9U3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWrZxnY0Wv7ovBw6NOWCDrQeWRFLdjg8ptkKITUquLg=;
 b=luu/VrAJUGSnUM+HLYN2yh6tPDehqd1Za2STh7ioR65Ph2Vd9Qr+PA/Y7974ACUEecO7Rmx4aYNsalVfUxMhzE4qaLAe7xMr3xpBP5OIYl4UAKOmNnmFLjxKwA3JxtgoTxtg3RoqJ1DXSSnUfatZBbrBIp05A0LQAhHHdpy5uSMMdiwMyecUXOlc2ukz9L14PGtiw6hFe90mCUxgVN4U8oLh8O+pAKyfosjLumf+wqO09Nn9pd/Sr+0MUbvyyfe8dAmwdi/l3tezAwW1fS2qsMIv18zich587GbGnyJl7DD/k+bgnofjgdZAb7Xjr3PFAqALz/lUhR3UwRr7goA4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWrZxnY0Wv7ovBw6NOWCDrQeWRFLdjg8ptkKITUquLg=;
 b=WqJ3+7AMlXvSTTLSkqtHjW7ho0uXj5xTIzNRirndq9COeBkvAkSTQE72h2rbOvHyraYDztf4Bi8tk5r0yDIqDWSG7Fgkx1W6Jb5nYn95vUQD3n3Ya1X23Av5ccAuvE/ND3lsDUfE48+fY+VxCcwPMZWCziCBW8yICIUPLH19d+dBn8QZNZ6ZS8jKK9BU9SCZYrMIZit5v1xFFNqr1Nam3kWvwE8Bbqgshbung6LDM9/BllEnlmZttnMWXQXxsi0QDSgPbfDXAwhDCNEyPhEwGoDMCmRla7EpL3Zt9IGlvXQ0sypr5BtDf9muIa2KvHK4DV6CTvUoFBCVL8OEEm/rFw==
Received: from BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21) by
 IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 01:36:06 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::9) by BL0PR01CA0008.outlook.office365.com
 (2603:10b6:208:71::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 01:36:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 01:36:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 17:35:49 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Nov 2024
 17:35:48 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 6 Nov 2024 17:35:47 -0800
Date: Wed, 6 Nov 2024 17:35:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <corbet@lwn.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<yi.l.liu@intel.com>, <aik@amd.com>, <zhangfei.gao@linaro.org>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <ZywZcSidYCWkJgrw@Asurada-Nvidia>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <ZywQP3_TpdttuCy8@archie.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZywQP3_TpdttuCy8@archie.me>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ab5b71-20fa-4bcc-f3c3-08dcfecc8cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyoF/FdFIfjDsEpZ0LAdq7HdPxbEhGJ21iDaiXzb/ZlxIBLagC+ZsxyN8aDo?=
 =?us-ascii?Q?qJ/P7pwVxBj4zHDCYKh5judl0nCqMOK1EiNAcSM39Ttq8j5IwnLHerYDz7aj?=
 =?us-ascii?Q?DFsrl52mS9YL+FD+S5fu0l7kvPTAru7ktJCPRHGlZdEtKAsZ04Iu8zKLJ4+q?=
 =?us-ascii?Q?Odzjw4CV89YRSBzNZetUPJ0uGXcJ54cVSv0Uk7s6DBxw6yztx9UKikh64rUE?=
 =?us-ascii?Q?4XtvxJ4FGErNhe/HkNQWE4ZBQ60wJQpVz8iY1AFQgxexuzmYN9bkiF+hluiD?=
 =?us-ascii?Q?9k4KMTEK4QDLeKSOifFE8JES6JIf2ZlGExaRPfV9VuPIRUL4otq6Avt4hvTB?=
 =?us-ascii?Q?vLbDP5oXabYL0csjUs362zLyoyXFJLBDxWqn5aMhDH/OoSblPSIskXcOsEob?=
 =?us-ascii?Q?W+PNG/whNcVATtM4iFNjL+Vdx/P9iLRTndoXlCjeOhYDa/zu9aERolvwU2ky?=
 =?us-ascii?Q?O3dme3V+7Bk4TabkgxDWNmNzF3NcvDPEXuWK2aVlqZOJEHbF2IdwCVB6elb5?=
 =?us-ascii?Q?V+L0ErhxZkiT9abcfk6FiluLAXCdyA1hCBUmngJVTLIzBaYwbbzHLtph1twO?=
 =?us-ascii?Q?GaMZH6PX1J/0DCnVSLXvputOrWhz6RFuWhLPTI2/szdc3AtET05LfEzmRi5V?=
 =?us-ascii?Q?a/EeZQ8REjvcDjep87mTFyGYisl5gRk5qdxAELgFe3MNLbrO1AWXLRAofWLX?=
 =?us-ascii?Q?wMhiC7NcsJsqTQKXpqRrkYli2R0zzM9iw73tAj8fH2e4KzKbrSftoGu8W39r?=
 =?us-ascii?Q?VmiQSrf5KdwNbVmIHYIwUBVf96FoLy8rv/Qd6BDPN+FBfPiYqbInf1Al7qu+?=
 =?us-ascii?Q?O4TGpxXMRFubHXRV6w8EsGlsSXVe8NC0Z1aO1qblMLkktya/eFSihNrDUU6P?=
 =?us-ascii?Q?hWFVPAk62bzLZtZyeJYWzlsdbsMWyiuXEVwyZ9AkcSQyG/e6JphlHCr8OC+G?=
 =?us-ascii?Q?TQHLvM9Jhw0JtOcauxDxomJi1rK7pgS3DNQ1JnVkso+8992Qlt4NdCps9ZJx?=
 =?us-ascii?Q?nDInze3Jzo9QqFfGrF+Q19vvSP5ASgOJB44n9cD3KJaEh6bUWbEH6GRmF6DU?=
 =?us-ascii?Q?IPD8O1bqnMsqKfXnxFD2lRUZ+meyzDMq9+TsJK00I/VOiHjqcJizZRUqqJMO?=
 =?us-ascii?Q?1tLd52aTiwK/cSs3JsWaCKhoK0zY74GYcG9rIKaPHOSRCsU0ypp5dpTBE4ka?=
 =?us-ascii?Q?QwsVp2QBcVCEo4BHCy5/kLVpA7y8fKvJSBL4szo/hGdPMPuwaMimgnfub9vO?=
 =?us-ascii?Q?u4NQI4arHDT7C5OA0V87gsBqUlIXR2AewgXixgoDafpZaxplSBhNLNMq9XHr?=
 =?us-ascii?Q?mfwMALqx9ubqNGVebsTkMddon7wwBw3QP3GzoiD9XXWwmqRa38QKEDT2mR6O?=
 =?us-ascii?Q?9tOihIoh79Brl9ubFNvCdFHohhSR9U4bTKziXWx27G+8jLZXsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 01:36:06.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ab5b71-20fa-4bcc-f3c3-08dcfecc8cba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907

On Thu, Nov 07, 2024 at 07:56:31AM +0700, Bagas Sanjaya wrote:
> On Tue, Nov 05, 2024 at 12:04:29PM -0800, Nicolin Chen wrote:
> > With the introduction of the new object and its infrastructure, update the
> > doc to reflect that and add a new graph.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  Documentation/userspace-api/iommufd.rst | 69 ++++++++++++++++++++++++-
> >  1 file changed, 68 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
> > index 2deba93bf159..a8b7766c2849 100644
> > --- a/Documentation/userspace-api/iommufd.rst
> > +++ b/Documentation/userspace-api/iommufd.rst
> > @@ -63,6 +63,37 @@ Following IOMMUFD objects are exposed to userspace:
> >    space usually has mappings from guest-level I/O virtual addresses to guest-
> >    level physical addresses.
> >  
> > +- IOMMUFD_OBJ_VIOMMU, representing a slice of the physical IOMMU instance,
> > +  passed to or shared with a VM. It may be some HW-accelerated virtualization
> > +  features and some SW resources used by the VM. For examples:
> > +  * Security namespace for guest owned ID, e.g. guest-controlled cache tags
> > +  * Non-device-affiliated event reporting, e.g. invalidation queue errors
> > +  * Access to a sharable nesting parent pagetable across physical IOMMUs
> > +  * Virtualization of various platforms IDs, e.g. RIDs and others
> > +  * Delivery of paravirtualized invalidation
> > +  * Direct assigned invalidation queues
> > +  * Direct assigned interrupts
> 
> The bullet list above is outputted in htmldocs build as long-running paragraph
> instead.

Oh, I overlooked this list.

Would the following change be okay?

-------------------------------------------------
diff --git a/Documentation/userspace-api/iommufd.rst b/Documentation/userspace-api/iommufd.rst
index 0ef22b3ca30b..011cbc71b6f5 100644
--- a/Documentation/userspace-api/iommufd.rst
+++ b/Documentation/userspace-api/iommufd.rst
@@ -68,2 +68,3 @@ Following IOMMUFD objects are exposed to userspace:
   features and some SW resources used by the VM. For examples:
+
   * Security namespace for guest owned ID, e.g. guest-controlled cache tags
@@ -75,2 +76,3 @@ Following IOMMUFD objects are exposed to userspace:
   * Direct assigned interrupts
+
   Such a vIOMMU object generally has the access to a nesting parent pagetable
-------------------------------------------------

The outputted html is showing a list with this.

Thanks!
Nicolin

