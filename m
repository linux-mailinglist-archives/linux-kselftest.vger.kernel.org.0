Return-Path: <linux-kselftest+bounces-2863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC582B36D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 17:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF791F21CF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05251007;
	Thu, 11 Jan 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNiOZbv6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801F4F5E6;
	Thu, 11 Jan 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyIDGZTJ2s/7ogacWnFbw4OTgsDCkfFYrPbdTwcOt7FTSRU2fFCFm643hulwcylRrbObES33NfjgDTj7ZdojLxSLPeIHRDo3l21t7AePGJftFfaSSn6cWCisJg8dWKhfjws13I6sLzke+eWhPDcGXnZ1dqmsL2QxrPrxGAIJAqbC0NaSqD+7xaMFZrNvmuiwC4uZOBc2XsxU34QkwOMcPwNEuWrsM4GYhQnKJd6BFVx6x5bouhn8rVGiAOy6racbKfuciBFwj2kBpuqitNk8y5M3PU/6y57aNrEe2V2p//GL5o4NhXLt6Rr44iEUbGPQVmYBhOTM+SchRdBvK5PCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KgiVcdlF3SvUWOo1CMyEdMY6v4IUUtsXG+FBDx6If0=;
 b=MBHtPUsMHbAMdZQwQnn1OLfkYsgQiab6/t80z86FXhFgwN4ZDSSNjCitt2gMJP8Bmhanhr4Q8xo07+83jr6A3M84YEYL7khy6bGCTDcdZ56sNOBS+Qj1w/xFM2aQL3q+NSuX38VIfnaTumLHaGfeKqMz0vrYFE7ONO0S7eldMSXTD9UtjadY/BRKTjU67P1hJchMDtqHdacRqG+l7f2zg3VGfialIuH0lWdUfmII6tnuqGRBAlE0HB4fKLsSVXY+XVmX53+r4pDwsaq/uCPMPvoaspYz8+44R2nbc3+2LzBzpsTkHMjxzzdVRJyhnlkcPwbjuxLmeta0joadsD2lSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KgiVcdlF3SvUWOo1CMyEdMY6v4IUUtsXG+FBDx6If0=;
 b=nNiOZbv6Mo44TdfO+4QvSDRcadGELHaIUHEDkaWZnqzyM+8XrzK2ejSoQBs0CLXCiqprUdSaLxGUApOuT3SqvNqao0ngz4TOjG1h5i3k5JwXhllKI54wHYdgPDFh30wN0igs00iqFV2pYkKdoDw+Q5AvF3s6KxXF2YV1XpjM6sc/3U8x9QYFmE3OxZJT4sEVam5Ohh5w0h26sBea1EtuKsyg+h/MWFTSa5jW4Y1pBXNXr/am8qMHWV1y2OZoIx5tPtnklmOM/806WM9oTkHEI2S0qJNmSWacIe8CsopUSuapObZiDT9rfYl1T5dXJUqAJacjwXyUC/ks8OBzvKvzBg==
Received: from SA0PR11CA0098.namprd11.prod.outlook.com (2603:10b6:806:d1::13)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 16:55:23 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:d1:cafe::17) by SA0PR11CA0098.outlook.office365.com
 (2603:10b6:806:d1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 16:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 16:55:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 08:55:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Jan
 2024 08:55:11 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Thu, 11 Jan 2024 08:55:10 -0800
Date: Thu, 11 Jan 2024 08:55:08 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<cohuck@redhat.com>, <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
	<mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
	<yi.y.sun@linux.intel.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>,
	<xin.zeng@intel.com>, <yan.y.zhao@intel.com>, <j.granados@samsung.com>,
	<binbin.wu@linux.intel.com>
Subject: Re: [PATCH v11 3/8] iommu: Add iommu_copy_struct_from_user_array
 helper
Message-ID: <ZaAdbHbV27msSxtV@Asurada-Nvidia>
References: <20240111041015.47920-1-yi.l.liu@intel.com>
 <20240111041015.47920-4-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240111041015.47920-4-yi.l.liu@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0ec8a5-45c8-4faf-349e-08dc12c61a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	juWp5b0oRQZNRwdjSNOEkhltKU4nRoDjhcKRG//jp94gfOEz+M13Vm0KS5fKR0BVHnL089vCofu1Hhj6qHW30jWpW6I7zw8BbQszNYIKc9y7SkrrAkPN3D9RmA1RWFZib1A5hLe3Wet5oZtYVRAXoXMpob1inSGfcCDi4b8+Or/XiRrX4xabZJZMwUcHt1vkF3tUBltXs/EaIFs6eNIr5VA0Yu0paN7MQnyQJ+nBn47yHmzgokWkVm6UmGrTTJEmWZoAPXvl6omeG2GZUWJq5HXefMZLyrmfK39zDOhwwyzl+IDICvsrHGqrpS4KRqd488fUm9jAC4aTXI518QO+DJZi173CRKhjJ91Tzrr6Z0tvXj0V4rMhpEt6NvOWIbxj/oTnX/g9FQEJycheLpiaAMK5/MJGF3LKEHdeUb2jAUJO5RdNyXMjsnjIXNrI78HswtLgn2yIG5O7TN8DTCL8tZggWPAMCDnIYROXmfvM4Ms//2N1o0J3K7+YyrN/uDB5kaBJW6yUdXZsdsCafj0pdTdGuXY9EBUYZtqhjkBxyNPpKWetCJU06kulxBnx5WmtA7oaI2STTxd5fJ48OqcSETCdhDqAF0qXkBtiw73IVjrPuWMek3JwFq/Gq0/6aEi0yeSPSIaqeciX6h3tGtbN8SpocoTOQ3MEzblCKKhv3xz94txCCpg9Nkl7MoId30hkiuvUwsx6Fv+HEgE9DboLGTps98aw8mXO+Xfgu1HlR/2ENo/QcKZqWrUAxBHa/SsP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(336012)(4326008)(426003)(9686003)(47076005)(7416002)(26005)(36860700001)(4744005)(8676002)(82740400003)(5660300002)(478600001)(2906002)(33716001)(54906003)(8936002)(6916009)(316002)(70586007)(41300700001)(70206006)(7636003)(356005)(86362001)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:55:23.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0ec8a5-45c8-4faf-349e-08dc12c61a29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

On Wed, Jan 10, 2024 at 08:10:10PM -0800, Yi Liu wrote:

> +#define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
> +                                         index, min_last)                \
> +       __iommu_copy_struct_from_user_array(kdst, user_array, data_type, \
> +                                           index, sizeof(*kdst),        \
> +                                           offsetofend(typeof(*kdst),   \
> +                                                       min_last))
 
There is an extra space before '\' at the 2nd line, making it:

390 #define iommu_copy_struct_from_user_array(kdst, user_array, data_type,   \
391                                           index, min_last)                \
392         __iommu_copy_struct_from_user_array(kdst, user_array, data_type, \
393                                             index, sizeof(*kdst),        \
394                                             offsetofend(typeof(*kdst),   \
395                                                         min_last))

