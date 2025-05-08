Return-Path: <linux-kselftest+bounces-32664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE62AB0120
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C250D5027CB
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499F285417;
	Thu,  8 May 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iSzJdNu3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412431C5F39;
	Thu,  8 May 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724381; cv=fail; b=RQreaW9MSi+MYPUR/lkQQzZBffoY7q8EVUfyJmEpYDwqI2aOmmFIwCDPNESuwLer8O7g9M9cBOTvqlnEc6wxGSjSQgDd474FkUiTQoGU+KPN/j80HYzEPIo6C9lKGFcIiuW1xlnybb37SjQjPfnM0Uegu1IBBpcwjgjjUJ3M8XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724381; c=relaxed/simple;
	bh=gqtimxm0sRw8EdYNhhzL591Hl2LEIzRf0af6Nrr/ao8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovexs9iB2n7TmCV4m/5ZsttzSAQV8gs16cUJyJJmuohheb2/tUclkQO8Ca2gXSzald3i98qXh7wMXAGwZLzMYVDsEnB6r+nz8vizZ51waTnPosCNpeYl5NvU/X+KB+B6EdQZC0U2f4H7FTg4Xp/+GZPD4+5T1Njz4GJiFHLZs1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iSzJdNu3; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGvoZe1yw/oF1nwuucU85GRiZZ/QPCHfKgTT1pTTv0dWrjZxuWEJAhAqeO8qRfw1dhEVRoCAzFsAUcdxnQ0ZXA2gaCQ9B0FN32HSnBmz5O+0McF3L3Xl0xOqZprpYMrv7FUjvO7tcQNAxdrLlaep525Y+6f8cHr3MntMjMe2Of8zO0AHtdQoPgmctCYxkxhy6B6o4fvGcSp+xokk/pyB57VIB0vJeJcR1jDkKt10eznjxLsqPxq76yTDR9pJ1A/DzEmuMZfsazqHlLiIbnf8AbiOk55EmLRDvLGqk8x6l+2XGziTC4EEmezvEcqT5uodfhKi8MqcU4PytKdKk+QjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2jufH6Mb8YFcG4HRF4WogEi13g/KqlNBYLNd6T3iVE=;
 b=jHPECjwOpe2lonX9d1PI4wKeIiPQwUBX40/afFip+zsUknYmW/LNFnPuaFZ0h/oHjJL1BV9ik70C+5hw1Ze5AeHBC1b+DZpzUDyCoTROhU7WIBCJxYEFZ3Xbv1oBQaqHy2pX5KWOAdQHFeZO9bt0o0yNU0OQNyLefKsroKjHrk03FGH3lC+1twLT8oBM5YQqR3KZzh/aU2yD0qXS4UeRHXASfwvwpWSgeXuw2mC06NctluTsfX0WoBN+YqB7PQgfpnOeGEmhUdUY0TbLvn2b9XoZYx4lUJdKPBj6aTQUckQh5ZyyK3ySUrstdvodugWrTQHcBJNrzigAcmkQPRvzNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2jufH6Mb8YFcG4HRF4WogEi13g/KqlNBYLNd6T3iVE=;
 b=iSzJdNu3Zf66iDd0Lkx5KMTKPYmPLDdPAD70eqFri4ehTor6X+oGZ1a0cvvGq80Svp6P/sPM4G/VTSd24fGg8THuQWTWfsJi9w1RO2pNLL82g8DyJ2LBnTvrlydLOY+fbdXXXgALE+OEfz/8aX3OTLThJcHGXO+PXvgJUt2RhynCLj5ZkZW/3imiSmNBOVzPClKOCOzZCQFIBM81xR+rSl7lB/EvTopNRy+Iso+twdilz2G5Bh/NwfSZbQkAhT/7ZTl6QXNeLLFHDk87aRrSDY6AXSWB++uy8DyDOT+jpF4cao6+ClDNTQhVANd8NpepryIn6WesBgPHpMPdFA+g7g==
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by DS0PR12MB7801.namprd12.prod.outlook.com (2603:10b6:8:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Thu, 8 May
 2025 17:12:51 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5a) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 8 May 2025 17:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 17:12:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 10:12:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 10:12:34 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 8 May 2025 10:12:29 -0700
Date: Thu, 8 May 2025 10:12:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, <kevin.tian@intel.com>,
	<corbet@lwn.net>, <will@kernel.org>, <bagasdotme@gmail.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <shuah@kernel.org>,
	<jsnitsel@redhat.com>, <nathan@kernel.org>, <peterz@infradead.org>,
	<yi.l.liu@intel.com>, <mshavit@google.com>, <praan@google.com>,
	<zhangzekun11@huawei.com>, <iommu@lists.linux.dev>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <patches@lists.linux.dev>,
	<mochs@nvidia.com>, <alok.a.tiwari@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
Message-ID: <aBzl+mn+N4bnUsPN@nvidia.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
 <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
 <20250507123103.GC90261@nvidia.com>
 <2356ff85-6651-47d9-90c7-f8cbf43b053b@amd.com>
 <aBxHgf4llBd7vA5w@nvidia.com>
 <20250508121456.GB5657@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250508121456.GB5657@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS0PR12MB7801:EE_
X-MS-Office365-Filtering-Correlation-Id: 979fb648-f84f-4bf1-d318-08dd8e539053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6sugoYpvVaycDGkI16t3b3KNKW202fdwdoTx5btfS3x7RjZ8Fj2CYIylAbP?=
 =?us-ascii?Q?w1UVPg+N8Cl5Ye5rVVXBasJevHPdWoEjvUQlp7CpFqlMlkDwY9p8Azy01vhi?=
 =?us-ascii?Q?Sn5aiZiTEYkv9sZkgiTQVUQ1TsWXBv6tUlJrg/GCsDNJadWkRLO/1oicqPMd?=
 =?us-ascii?Q?ge4ibzb+EOAww7fDVjOJeUlWwzeEnk3GUljajIXkd6mzfw5QWXipdZ58n0l9?=
 =?us-ascii?Q?+UVEA0sZyMwgSlA/2MWf80chOH/nARYRy7tS/Jjl5WZsKJqIFSeBXRX25lz3?=
 =?us-ascii?Q?ko239grQ0LZhoRXoIfRT9dgoN2n0ToTI8yIpNFpcASRCiQemHBS8JwOMUfWf?=
 =?us-ascii?Q?EyWG06OV+yZ+JdpeGrFelcTkRgWfJutHmdwjrudP0xktQrdIZisXdGX1rqdL?=
 =?us-ascii?Q?4iNTSZ7L5DVG27SA2cf0yDQ80Jpj+xz8YJ+EKzPBkEL/Ynn7/oYJBXLuE3tk?=
 =?us-ascii?Q?m/A/VsH8NrAUZZMywxpnBiktZJNcgDpewZTzIv7UF6CagzI0Q8EJwglJeBe2?=
 =?us-ascii?Q?cma/Tl/+M3upwJRMC7hQ3YuxdYSEpGXgGJj9Ws++l1zgJfWjznDHKRyQF8IR?=
 =?us-ascii?Q?mLQHef15BZh4SnWqBxpFFVStqosgXFo+YpNkr7LbD/w8KrqW72rAIc3mClF4?=
 =?us-ascii?Q?bqIByeL401Veioq9HjDvTGHyksY2EOhKglqnI7L9+6U6TFptU9cEnUW/d7q/?=
 =?us-ascii?Q?g8rtIUEXLuZ/eMMPNydehtYZf3ZFd+j4f0Ww40XZCA8he3s5dLAYOHufivBH?=
 =?us-ascii?Q?zG6r9/OiliUte+SHSf+cuJgyNyctv1AZcTK742dSZn0mgMQKqkzIZrQ6+02B?=
 =?us-ascii?Q?NbkzRL8J5ohxx0gWbWPGMwaNMZgmdodyN4ChYvkBImfhq2y+izW/l6Fp9mFJ?=
 =?us-ascii?Q?Wmmdgqul0eDTZ+ooiR5Srcu3t3VLK6m8YDas5dluxnLXITL1nbItTXCsJ+mY?=
 =?us-ascii?Q?YQoF9CxJNhBZ40sifr7AXBvGX+FOPrzjUcGD2k/YmuGTmHk9Y0GADhYF/OZt?=
 =?us-ascii?Q?wJnHOuiUf6r+KgSscQPh16k4I9ZEy9WXut5PJIyGy6WhmgR5RhNFqsW46slS?=
 =?us-ascii?Q?wu3yCDpEWy9+NxOGBrW8x8qv1Z/LPoMIb6CyA2i6+S0UoeE1mvt+nw7hZQUv?=
 =?us-ascii?Q?VMcnP4XZAtDMWrHtefnvgc/vTj/R1MHNnJjEPXi5KA8inpu+c07tGVMyzCsa?=
 =?us-ascii?Q?T3+wGSTsRAwO6T9PZln6OEvnHFpD4nd74EN5r7SfqD3SBAiyed72EIubzkT2?=
 =?us-ascii?Q?Z78EDbBhoxMWPyjgHh3qQXg/xnE/9dbf8sp5ktIjD5U1w74pljW+m6crCwPC?=
 =?us-ascii?Q?EWnXFRiS35vNkGMJXI9gAYZ6CLducaMEzwfECr+SbcfpWlgAeMEulR8aLvZM?=
 =?us-ascii?Q?kL2AdEkVjTqpEEI3Xdpb9Yw9kaP05OsADzuCOh4vx4E3sZb3UU6Jc1pbG8UB?=
 =?us-ascii?Q?r6i68IkmC+rs5aozW8siAYn0vII50jKsXulxmmCmrYprF0cr7tGOIYhWJSSa?=
 =?us-ascii?Q?3zL+icK64UQJ/9v3TsqWOP/bl/Fv+qV/9XOG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:12:50.9218
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 979fb648-f84f-4bf1-d318-08dd8e539053
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7801

On Thu, May 08, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
> On Wed, May 07, 2025 at 10:56:17PM -0700, Nicolin Chen wrote:
> 
> > What I am not sure is if the HW allows setting the ComWaitIntEn bit
> > after CmdBufEn=1, which seems to be unlikely but the spec does not
> > highlight. If so, this would be an modification to the HW QUEUE, in
> > which case we could either do an relocation of the HW QUEUE (where
> > we can set the flag in the 2nd allocation) or add an new option via
> > IOMMUFD_CMD_OPTION (as Kevin suggested), and I think it should be
> > a per-HW_QUEUE option since it doesn't affect other type of queues
> > like Event/PRR Log Buffers.
> 
> The main question is if the control is global to the entire VIOMMU and
> all its HW QUEUE's or local to a single HW QUEUE.

Oh, that's right.. I recall AMD only has one Command Buffer,
but can have dual Event Log Buffers and dual PPR Log Buffers.

And the EventIntEn or PprIntEn bit seem to be global for the
dual buffers..

> If it is global then some "modify viommu" operation should be used to
> change it.
>
> If it is local then some "modify hw queu" operation.
>
> IOMMUFD_CMD_OPTION could be used with an object_id == VIOMMU as a kind
> of modify..

Vasant can confirm. But looks like it should be a vIOMMU
option.

Thanks
Nicolin

