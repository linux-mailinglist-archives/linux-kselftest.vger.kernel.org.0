Return-Path: <linux-kselftest+bounces-35132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC8ADB86D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D1F3A2CA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F2289355;
	Mon, 16 Jun 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGUU28HH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FDC288514;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097195; cv=fail; b=VPioxnD+ktP36ESKnNsr4FCW7o/7fY/c3IxHWJKqLdZ9CEgOSNGqGrNRvXlTIC7j5I+uemBMCd0DIYW5Td8vC49L33I8LxnxMBglXEK35D7uKMbveoKxDfhh0MI3vqWQG2Yn6iDUWAmcmxxZubBoAoDwQu5VXEC3DJGzE3eGGhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097195; c=relaxed/simple;
	bh=2Cm4vU47Spy4nhg0B8n0SgmFi/+NF9pEj64dlP7CSKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6pVgMRcanku6MqbUkuk4SGRMenfA33yRgH4vdNfNlpdtTwRGBtqip6pqN5h51RuNeKDH5bfJkgVdxhIBKJtftPS+hKsYcbCxQ3LyUe/XJZ8G5MXygEoF1kD7i6lvPH/LGxKYQ5TzFyl3W3MXe1CAo7R/6ui0vAkAcd0uIvwgfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGUU28HH; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsiBrMRgPyvSw6nmezoI29KvfAr12y9sAM5ejut0ncar5Sr6q0OEGBxTrjS6Gsp4bzBz6YfnNugWVs/yQ+C50oEJQ7NpKj0X6FAm9Na27FhhZqqxvvuTTOk4EDjYHcKDByCY52VrGiwN8y+s1QHURhJx/RfO+W3XbRi3+n8Zuo3uD3jgVjTOEIl3LQAw6Qb9yOyjlK1GHjj8imxDiKUHd1rVcJ1g1AnY3n1nDpzw2IBBxyoTo47YqqvfsqzLxKnq0dLH7jCPn7kCq5TyQDodyy86br7VniC1A8bzJq9FGG8k2fs2SWdmHly+K8DYy+/EnVXv0smX8jZFDdGaZ3GMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHYzF1TfVjUtNy9H9SEGfJ7AGNjegIdlguaGjw9z4qE=;
 b=f+4UuhH48tiM7qYquUbyq1IIF9S1vGjSjyWLgZvRyr3ETYYgPdEZDlecpckvau7enV/g9I0Di6yiGHd+Ph6lnfGJeGzU/Xt5bX+sSoxpRg1hD30aFPrrVziWa8AaqZJ8ph8XKMumDT79g7Ia1lkDnb/BlE2gIG8v02U9wNSHp5WLFlRNx8IUUZWWh8YDpv/OsjWGRsT8d0SYzfjQzi1eYhsUJtSsZxzPNI7//32ZHhgtKmFMT7LuVrS+w9hB0ghusqEVgcP9KGDzggIRK+kRpuRbPs8Qg89R7LiOntmffWZZ67KJY2AT2qrDLYCrzRor0VCoApNdWgCoINR980weKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHYzF1TfVjUtNy9H9SEGfJ7AGNjegIdlguaGjw9z4qE=;
 b=DGUU28HHwpATyI7F3kqZWspjHBTdol6nTuM0miO7tNhsE9X5+f8KEwuppQXgDlZyIOZxhoNRyMdC9N67c2ETL+9a8L2sWs9sW8KRrzCD3/85nX2o5iDglgDJZKRQPbu9ABl6aFmtfZ+3xJlMzPSLgrgf7SLxIi7e8y3jCCP3n+NQ9pFm/4PblMTFYbu4VaPhVe2QRlGpHRbuyqvBtEA+cWBxL3Na1wVnm/Ss/UbnTWY5QdqXZLliRB2ZKxjMWAaFMPm3vlO6NHnJWdDUpKn+yD/VZikYg9jc6rjB38D4XopaxfYw+8GxzxdFXpHFeVtsmY7R3c05uCzRV7G4BePXSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 18:06:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:29 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v3 06/15] iommupt: Add unmap_pages op
Date: Mon, 16 Jun 2025 15:06:09 -0300
Message-ID: <6-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0131.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: b88fecfe-0af0-435f-8a42-08ddad008263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5CHZX5sQbCPz8KEShNV5OaU9/OAT3n08iaX1dyw7haFqSaMwEC9kLq9DV2s0?=
 =?us-ascii?Q?E8IUhAfUYkz/9pJUIq0q9gZW5mZA1OLWuu1clZ1UwTn9L2I+3XwyQWasNfCw?=
 =?us-ascii?Q?NEnED0vCzDIm61+EoNgBFngYNdZ4HgNJNWMdgnKt2O9BUJkgIiIwk06gpruc?=
 =?us-ascii?Q?x1HYBL/4nIyAdHhIULt/uUjaTP3kfE2dxytdmgu+Zy1RIpMbAc4r5Ajw4Tpr?=
 =?us-ascii?Q?/S+Xv+rXHJPmnySrmhrvj4c4a9vNtzTqB4EcjQkouqDVWKvRLle8+L7QOouk?=
 =?us-ascii?Q?GmJoVvvBR5mCXfTPWysr0JPHAfyVD9b0Afa8JCdJRrgY63YwipNqv6oKX7lR?=
 =?us-ascii?Q?CAEXXb4YJw0QcZwoJcM03cCgMBXfgmdtLD45hHk7EMfiLpOuBbBBuxEDVW/3?=
 =?us-ascii?Q?Sf+7G9HlubnEQKPO7ez3XSnSqAu9CjQblFcYsT+altfj0oqhDCGQWuQ9cy9V?=
 =?us-ascii?Q?kOcoAP9JFyKMh1LTlF/D1mL+awcX7ewy8n6yy/h+vVmQ7v08qmztQYXrzzk8?=
 =?us-ascii?Q?OXayPW2dnSb3tUQe4DOyG2wGpK1oH+s7scxzfR/f8G+zYAjArmIqDISBt5GI?=
 =?us-ascii?Q?EjfwIHGEhRZxv5DfaeE6zB91zVS+/GU8qPM5sC9wrAioiofHMkoLidM+gNDm?=
 =?us-ascii?Q?qOUZ4UbAgwZ9FqdV4pxN/dE74lp0j4oJrbif9W06seZteMnTnFih+gEm8leH?=
 =?us-ascii?Q?PIWrkz3aOdLMl61OePM1XwkK6ivjDqvOZ+3OgzNc6Mk8UC3sj10SvIaYJ7yu?=
 =?us-ascii?Q?OriZi3Gn+w/e1g8kvaWKK/aNM0XPZJm88hM5ByS94P63WiQ2lMcJj/vSnGcV?=
 =?us-ascii?Q?2Duy2jQ9PrHMGZh5zWftSphJkvGTpG9aUTwc77oOFLd3WqFIF1koGqxZ1jOD?=
 =?us-ascii?Q?2EPlh3aOSbUqVt4/0g+W4A+LjZnYPpLom92JC/Xgp85G3+UXeNXzg2WdnM+X?=
 =?us-ascii?Q?cZ9iOdzp/gp+AiDmhbyZWgV5MHf+LoBCnb4DK5kgf0tfBIhD3fl9M7kMYlSb?=
 =?us-ascii?Q?yGE4J6YRcWn2R68WytqmFwH4mvZno4u8DopjlEDFcx5mfix9MW4j4XNWfJs3?=
 =?us-ascii?Q?LlyUOv4/TDadYboRId0TxTYYiMKDQvtJj6h8OaSYiloPJTaAxsjSsQ3Ps6C+?=
 =?us-ascii?Q?prCsJgPd+/pD2rNq5/s729QcsiNm2yxWUAWB1zqZPQrq8O7q7uicmp5zKjuC?=
 =?us-ascii?Q?11cpIqiKdulGUhMRcpUuogapwC3FeEHrl9zBTGkPOM11yPq77cHbsYA04vuT?=
 =?us-ascii?Q?60Y9Hjly6ujFgoAbrcN8VQmnZkkB2vmitV7R8gmcGYWD1TqFixD3Eccph9Od?=
 =?us-ascii?Q?KkANdKdZVw/yjG6r35oYSAcT6jPCe4mMYdGdGd9WBaRnHZplpOMp/zS/5wzG?=
 =?us-ascii?Q?kKt+jlN6CixJjj++eWyfIVjCI1rpIhbwgtG6Onw/gq4athDnTelAtbt4doAg?=
 =?us-ascii?Q?UeN3W9hJ72bLP+oyZFcxrIv3fBH4eu719c8dOoZ6qGff8RsmI4OP7Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B55/JAJhpkPVvQt6TRHkpo/53Iz16O3i84iSAX/6MYx9thlNjxdETCcEjcqW?=
 =?us-ascii?Q?TJuP0hWXOATCNy4qIP/xiLuVTovHVun5SrF2o2lC3YeFRHP2ao4nwhzA5dha?=
 =?us-ascii?Q?tMCiJOb78FG95ZqifZA4N5T6Vb1dQe3yTaJ5aihK16QKe5LLd39cZfYyYO5W?=
 =?us-ascii?Q?pMOtx/DSaRXUCgSce45SfbxRwLsQilCe2HCnRj48KNr/Ukmf5IL3wXv8iK6+?=
 =?us-ascii?Q?R9DC+5YV7zhejHTwobktwmh3P7lI5zUxl8yeuW2zGl0+5XtaqSraVfmOwZOw?=
 =?us-ascii?Q?Y5AQN++27oaSv1lXKRkIgLeFpualpD1NQIVLmorEChFyzOXOlTZ4tPxlXPZz?=
 =?us-ascii?Q?VCmgeL5VsSQC/03pkRoV953EydcoYyiKyMDnmKyUmItg9qWt+6qP9dVRWuIc?=
 =?us-ascii?Q?WA+ys9IvlDEPw6nOxOLi7cv/hU7yPutESYqMxe3qtW17UzgXvSxp90IfDgFv?=
 =?us-ascii?Q?wmEyvUx1kSbOLw+RNd9rgnuyOE8vzrHuPVSnw15Uh+qbm7yFOK/m7dfxqY8d?=
 =?us-ascii?Q?OTLQU+PFGASF2Bk0OzB1zgs61MuvfWOWgDHPM51LYKLFNkTzpXFtxsNPvyWb?=
 =?us-ascii?Q?qsJSQA0SVNZoBRfT5zMH1YjP57IoOnwAxtPyMaGmsNhZuVFlPO01Iy5sNv3N?=
 =?us-ascii?Q?pinLzuPr7VvAUsRYWA88BztNcJeLsq3NgAKzdSLAIJYMF8WZHpN75sk7cB2i?=
 =?us-ascii?Q?DeKt4awFcStFUc0GIThY/W5fRbjob7/CUzSDHoyJselCJtqKx75w/oLN19Xa?=
 =?us-ascii?Q?0phnPKoTKMkt8P/UA82uAKo1uQpFfIrMVWxAVw1hI09djK5gItA4UZseORxT?=
 =?us-ascii?Q?cQdgJYAFi/54BoMnCnN2VRq4sZP/wcs1Z5EbugI5Iu7pAa6wGiC3O3I/oJIB?=
 =?us-ascii?Q?KudeboGKwqDLfUWzeCXVdVIzWcvbtzYTqCbFawdevH37ZD3Io5ewqMxTOhya?=
 =?us-ascii?Q?BpFDgKqRDPWBV4ICfKhKXQb0BPGVN96OCqGiVHoLiz3IqeCksmh/ztWG76po?=
 =?us-ascii?Q?aj9M8oF4pQzCxMy93yB5uCATVyMB0TloTBBM/LkD2IQJCaqPhZxi4HmFNyx/?=
 =?us-ascii?Q?lNV0XKofcl48bBGev/1/EsUY3j1gfq0CBV+/PR1SvwpAVHxzR1v0o7UH3Wnw?=
 =?us-ascii?Q?txtE8B07WOnaphlRwL6SgSgEi1VTBE6zfYdRGK5jCT7uZXBat1ILlrNn7l7M?=
 =?us-ascii?Q?cyGqclYZmSOI132leqM0OQWDTemIA5io2TiSKaEL3NpdGA9H2Tr1D8tM8J4q?=
 =?us-ascii?Q?GMcJ3EmNu9tzdekvDTlQRP1BOvDFMo6dRIU+NqIhmqFMLT3Dxddgxas9N62v?=
 =?us-ascii?Q?WB09H4xGWuQHhjXo0i3guMEkOLnoizLJYkJPQZk+DLV6cHSdwxO3oWYP19DW?=
 =?us-ascii?Q?ok/bNSOYx62XB3v8gK4Qys0tg+kkCIVSJAydv7txQgZILt5aTkopmtKQ7C7P?=
 =?us-ascii?Q?FbhuSsTP0jPEIBoHz/SzcKJSFQzs4EefWzRNxQkUJGrEwtZKw/ECSemZq4QT?=
 =?us-ascii?Q?xrJCXBZyG3HHEJxbED/lknjaRGWZvGgsYr9zgi7CTtHz9Mn8u5SeqAwZxOo+?=
 =?us-ascii?Q?w47lAh6G2jVGx3uNA0McWay4SI0AHlj07porKPsQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88fecfe-0af0-435f-8a42-08ddad008263
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:25.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQeOSjWwwYg1mZBgY6Fr8bfr/I7getGnc/ElGERnGnSWx4pxW50iW9398Mtb/XEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

unmap_pages removes mappings and any fully contained interior tables from
the given range. This follows the now-standard iommu_domain API definition
where it does not split up larger page sizes into smaller. The caller must
perform unmap only on ranges created by map or it must have somehow
otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
scan for them)

A future work will provide 'cut' which explicitly does the page size split
if the HW can support it.

unmap is implemented with a recursive descent of the tree. If the caller
provides a VA range that spans an entire table item then the table memory
can be freed as well.

If an entire table item can be freed then this version will also check the
leaf-only level of the tree to ensure that all entries are present to
generate -EINVAL. Many of the existing drivers don't do this extra check.

This version sits under the iommu_domain_ops as unmap_pages() but does not
require the external page size calculation. The implementation is actually
unmap_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize __iommu_unmap() to take advantage of this.

Freed page table memory is batched up in the gather and will be freed in
the driver's iotlb_sync() callback after the IOTLB flush completes.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 155 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index bae87ff34b8043..2729422d12dfcd 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
 #include <linux/export.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
+			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			       pt_vaddr_t len,
+			       struct iommu_pages_list *free_list)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+
+	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
+	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
+		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
+		/*
+		 * Note that the sync frees the gather's free list, so we must
+		 * not have any pages on that list that are covered by iova/len
+		 */
+	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+	}
+
+	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -167,6 +190,138 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+struct pt_unmap_args {
+	struct iommu_pages_list free_list;
+	pt_vaddr_t unmapped;
+};
+
+static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
+					unsigned int level,
+					struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_unmap_args *unmap = arg;
+	unsigned int num_oas = 0;
+	unsigned int start_index;
+	int ret = 0;
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	pts.type = pt_load_entry_raw(&pts);
+	/*
+	 * A starting index is in the middle of a contiguous entry
+	 *
+	 * The IOMMU API does not require drivers to support unmapping parts of
+	 * large pages. Long ago VFIO would try to split maps but the current
+	 * version never does.
+	 *
+	 * Instead when unmap reaches a partial unmap of the start of a large
+	 * IOPTE it should remove the entire IOPTE and return that size to the
+	 * caller.
+	 */
+	if (pts.type == PT_ENTRY_OA) {
+		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
+			return -EINVAL;
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_item_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				break;
+
+			/*
+			 * If the unmapping range fully covers the table then we
+			 * can free it as well. The clear is delayed until we
+			 * succeed in clearing the lower table levels.
+			 */
+			if (fully_covered) {
+				iommu_pages_list_add(&unmap->free_list,
+						     pts.table_lower);
+				pt_clear_entry(&pts, ilog2(1));
+			}
+			pts.index++;
+		} else {
+			unsigned int num_contig_lg2;
+start_oa:
+			/*
+			 * If the caller requested an last that falls within a
+			 * single entry then the entire entry is unmapped and
+			 * the length returned will be larger than requested.
+			 */
+			num_contig_lg2 = pt_entry_num_contig_lg2(&pts);
+			pt_clear_entry(&pts, num_contig_lg2);
+			num_oas += log2_to_int(num_contig_lg2);
+			pts.index += log2_to_int(num_contig_lg2);
+		}
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @gather: Gather struct that must be flushed on return
+ *
+ * unmap_pages() will remove a translation created by map_pages(). It cannot
+ * subdivide a mapping created by map_pages(), so it should be called with IOVA
+ * ranges that match those passed to map_pages(). The IOVA range can aggregate
+ * contiguous map_pages() calls so long as no individual range is split.
+ *
+ * Context: The caller must hold a write range lock that includes
+ * the whole range.
+ *
+ * Returns: Number of bytes of VA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
+size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
+					       unmap.free_list) };
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
+	if (ret)
+		return 0;
+
+	pt_walk_range(&range, __unmap_range, &unmap);
+
+	gather_range_pages(iotlb_gather, iommu_table, iova, len,
+			   &unmap.free_list);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 1fe5106997f833..382596b70e394e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -119,6 +120,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_unmap_pages(                                   \
+		struct iommu_domain *domain, unsigned long iova,               \
+		size_t pgsize, size_t pgcount,                                 \
+		struct iommu_iotlb_gather *iotlb_gather);                      \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -135,8 +140,9 @@ struct pt_iommu_cfg {
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt) \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


