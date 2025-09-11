Return-Path: <linux-kselftest+bounces-41208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9572B52783
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 06:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A8E68099F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 04:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB9822154B;
	Thu, 11 Sep 2025 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tX1Zth1F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92C429A1;
	Thu, 11 Sep 2025 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564656; cv=fail; b=jTsnKIQJ/diE+t1s+LEG1i5N8QcxOKaT11Z0uEAE7Gk0Okr3BfkkAM0VhKcgAc2cQapAmmjeD7UvhD/HgVbBVYx5RzbSzWgPuSenUAUFb9wAxlhRylp/Ma8+Cu4KIgmJwL+Pgbn/FW7kS1P7gIxlaGzvv3prhLwraVaLkhZOSMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564656; c=relaxed/simple;
	bh=EtK/UQWfzhTxT1DaI4ydzd2C2iSuIJ1A9KH5yKZWZWM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8UoinJ9UbMbAX94pWAG+cHvIavxf183hw8IMvql4JJJflT0IoSptsYNjiYBnSCKXOHFcLlbquREVDqhUo7x8uUBOLGsNE9RynjsxcA9xt0U6V1sOoCivqx20+4pIg8kWOE2FCMwlFwTuD4UmjVy41MbtCSMX1pF07FVd1cvxWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tX1Zth1F; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bULQufMKnv1AohdmYQNAD+E+dqUJK32GQAcocEg76zthYRr08tTPcLxL7oIActj4kdOhgGyp+v/3HqqjO4K3ey93l3nAjFFi1aX5G8IIykT/y8JWRSznbjCYySBhAfmVpnMbHVMb1F+LlGmgecH6K0RoDZK2k0T3HR6iiqUSS7hn/9cU+uZg9zibVmqd7zXYcuWFmXnrx5BzOZHCzOxJ6b+j9cGGrBPUjQrSOZX3HVyWpeOwl7g/tlZ7WIN841gaIEMNY8gPjHGNREE+lkDxVsSNPhEVr1zrTgN1Vd3zYVQJr3d72b4OvNrWXSFFSmU5QImGhLGy1z0oClGcLNmTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUal2+K3yxQXBTsIil8WmLVw/0Xkrf5pk77UqqfCQb8=;
 b=pmFrX0Hli+GkSXEaITjs7TnIEhprXh79uyEBDFGuiCC3YuUJQGVo41dK625XS6kiSnBi0DqDO3wPGQ29XDY+sTLPML3Kb/xaUh7rd/9lavaZCVCJuyyhRBc6rgKrP+W4iWcYINAtuhrMPqNZid/q2ndgPTFnJutnb/gEBjlJ1Cqu7kwfQ0hw221OVAUcqj2gu/1G01911K7pyTUnJnIZIMfgasiM97RgSOWeP9TrgRdVPbLOPSovnsp+Dx+rX6NjZI5rGpqFMh4vU+9Xku49/mfjs51/cad55JSoJjM3FPROOILVHuQx7GXqk8TSlhFryUlx1IPtpwpH/agpcXg7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUal2+K3yxQXBTsIil8WmLVw/0Xkrf5pk77UqqfCQb8=;
 b=tX1Zth1FDBVdPs0j+oP5O9P8oZxv+rnWfhEsM4XkniFEQoXdUPO630Ve6BirHQjj8Y8fYrqJKLyPZV5MEW6lzMR2Xru71ozBxd5zDncBYVe8O5sVpDACXYUW8YtYIlyF/M7ihqatkHUE9Sk2GbxyoL+0VJ2mblYXvGqhbxUIwCWLoGwgDuhDbqYlVE0AcODLejs1evsz9pKgn4Om8CLLRAHSNr6XnjVG0ez1cyXyEtOByl3MUh4dk8Ha1JwpKdautZoCuYvAxtsYX1VhLbIdZk6ksr2yLBCcKLgPAojZxeFV735ycOeUcXuPjY2CKrCy9CqeZmD9Mxcyv7jBWx6VRQ==
Received: from BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18)
 by BN5PR12MB9510.namprd12.prod.outlook.com (2603:10b6:408:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 04:24:10 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::da) by BYAPR05CA0041.outlook.office365.com
 (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Thu,
 11 Sep 2025 04:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 04:24:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 21:23:55 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 10 Sep
 2025 21:23:54 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 10 Sep 2025 21:23:48 -0700
Date: Wed, 10 Sep 2025 21:23:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jonathan Corbet <corbet@lwn.net>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, Kevin Tian
	<kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>, Bill Wendling
	<morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
	<nick.desaulniers+lkml@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Will Deacon
	<will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez
	<alejandro.j.jimenez@oracle.com>, James Gowans <jgowans@amazon.com>, "Michael
 Roth" <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v5 02/15] genpt: Add Documentation/ files
Message-ID: <aMJO09VXljI3eOAA@nvidia.com>
References: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BN5PR12MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 8855930f-0bca-4343-d344-08ddf0eb0e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z9B+18eC0kA/1cn715kvXlYzupidP/vJ70aonVQo3nE27pTf6Y2vaWC/e+06?=
 =?us-ascii?Q?HPDitedZ1JWUq0JxnNphVwodm5zt0x4tAsh5iaHUV3vLNrbyQxCtAQwvZ0Ax?=
 =?us-ascii?Q?VTLM9a54SJVYHqtaHHDGYR1whtux8DdvUbpFWOv2/mTy/rEP9LgXsz7+Ll99?=
 =?us-ascii?Q?ri5j9ewcTGVlQwYYIFdkmK0nB8K903nM94SQgymU8Xr5LSBJ3afhv+GP8YRl?=
 =?us-ascii?Q?odBt71adhDlRVzPFz+5iENRuw6971jLcsQb01qo9vCDnDHrOIXizYiXzeGW/?=
 =?us-ascii?Q?9PcFou2Z7rvrtV/j2uMEPx2A+9wiZ0iOxywAVpoiVPzxvPdQmlhLC+A6DV24?=
 =?us-ascii?Q?xIrhQmzSBLfsl37ypFD7dwowuKKlVrB3YqYFQvU2MR5u1hnkVHwU1MncHYfk?=
 =?us-ascii?Q?pXT+Ng1xRM1eAFpuznftkjhlykrUYvut6vzvVEqaa4qjE3w2eLcU3wVaK5Ct?=
 =?us-ascii?Q?mfyjNKNcNI6KhJkIVdgGLKjKxQUYIj9jFfgh09VBhahtbA62sdd9ZpYDtjbl?=
 =?us-ascii?Q?osMQ1o4do7CeMrFa12thj+xGNVY7LrgMQW00fBOvIgzPYzkNDFI5hewUW9EV?=
 =?us-ascii?Q?k80QyCnVc83PU7XoTFuvosYLqKC6tCzMSkWU3C0s7ootcaXRACRnWW6b1bg4?=
 =?us-ascii?Q?w4Z91VwkFD8HqmCKfVtgKU3lB6GpF+jI0z8lxW6S5R1fzxnPZjFzJ2leMIYR?=
 =?us-ascii?Q?WWSZb5QbDhnQBR6/RiPT8rO3yObPRTGXafZWtyYRRT64f+zlQO+UQyw2+Klf?=
 =?us-ascii?Q?PIdj2X9AAHClmVARhxYkL9eFhahpaQKqOgma+T6vC/ZszeWNYfecbBvOF7dB?=
 =?us-ascii?Q?HMUqNWaNqx5Fj8nHlp2YHMq2qlXuMGwEARbttHPDfwx/FvC3fHi8Xbd/uoSd?=
 =?us-ascii?Q?ZwC0Xnncy+8D2SrwQpuR92g990XFf+mHUxCGohzBWIAXBpEuTGECHNhw33Fa?=
 =?us-ascii?Q?S6QOBjHhBnNQ+5xyNh9Ncp4GmQy8+TltJ88QvOvDwFFzaf/3k8AxTu0tP8px?=
 =?us-ascii?Q?y1cgWcjdFuSjLda0rVkru1XqsmWir3+RXF1kGZcHw5SjzulgvLjVbfVRE3zN?=
 =?us-ascii?Q?qly1sZQ9hKJafTtETMWCOZ8pyJgN/FkyVBq4YgRmybWn1VXlUn47/sQ9ZgaN?=
 =?us-ascii?Q?c8Saw0cVKiugwRjGkzKEY5HB8FYtOiOpMlTorFiH1r4VZSKEyu7lUM7T2Kkb?=
 =?us-ascii?Q?dOBbapnnAEOy1hH1RbpxWxbqe6Ulq68rB8kztPtu7vyiNs1EZz1ibZaYzd5u?=
 =?us-ascii?Q?t5V83DfkquKK+frnskknd74vTw1SYJ0LkVI9wQzK5tcljJPYhUsQqF1o2TqE?=
 =?us-ascii?Q?UktqABjPuFT4r7aufnolFMssV9dmDD1zhuYJcR543+YR6/P80o6oNu/F16KG?=
 =?us-ascii?Q?WiMU//Utl/DcRi/L9Ev4xdsihXaUpVr8LckDlAOgMAppwqWm+RyaXfBsV6sX?=
 =?us-ascii?Q?vVVdcU2O6yyDqtX2O1MukgFcBAnpBJ4HhQ5UFtlKmhLLG6Pjk2mbLL8CAt9r?=
 =?us-ascii?Q?Yio/qVTAhHl8MHA1vYQprF8msvKRdOctR+Gn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 04:24:09.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8855930f-0bca-4343-d344-08ddf0eb0e11
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9510

On Wed, Sep 03, 2025 at 02:46:29PM -0300, Jason Gunthorpe wrote:
> +For this to work the .c file for each compilation unit will include both the
> +format headers and the generic code for the implementation. For instance in an
> +implementation compilation unit the headers would normally be included as
> +follows::
> +
> +	#include <linux/generic_pt/common.h>
> +	#include "fmt/defs_amdv1.h"
> +	#include "pt_defs.h"
> +	#include "fmt/amdv1.h"
> +	#include "pt_common.h"
> +	#include "pt_iter.h"
> +	#include "IOMMUt_pt.h"  /* The IOMMU implementation */

Should the last one be "iommu_pt.h" that's mentioned below?

> +iommu_pt.h includes definitions that will generate the operations functions for
> +map/unmap/etc. using the definitions provided by AMDv1. The resulting module
> +will have exported symbols named like pt_iommu_amdv1_init().
-----

> +Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
> +IOMMU implementation uses multi-compilation to generate per-format ops structs
> +pointers.

It should be "generic_pt" in the path, instead of "generic-pt".

> diff --git a/drivers/iommu/generic_pt/pt_iter.h b/drivers/iommu/generic_pt/pt_iter.h
> index 6bd84f96f5ad6e..0956c8a45646c9 100644
> --- a/drivers/iommu/generic_pt/pt_iter.h
> +++ b/drivers/iommu/generic_pt/pt_iter.h
> @@ -21,7 +21,7 @@
>   * pt_check_range() - Validate the range can be iterated
>   * @range: Range to validate
>   *
> - * Check that va and last_va fall within the permitted range of VAs. If the
> + * Check that VA and last_va fall within the permitted range of VAs. If the
>   * format is using PT_FEAT_SIGN_EXTEND then this also checks the sign extension
>   * is correct.
 
I suppose it should be squashed into the previous patch :)

Thanks
Nicolin

