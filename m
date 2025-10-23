Return-Path: <linux-kselftest+bounces-43929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72862C02E04
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65973AF3AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B0626A0E0;
	Thu, 23 Oct 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+kqmu6x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9026980F;
	Thu, 23 Oct 2025 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243659; cv=fail; b=T063ta1DQRgC4lk3AY1dE6eMVrvi3AZ7FYXzzNkxYQeZPHgtA0TAu/Fi9nWViAZkT0niKdJCytGRNuEyh2JAcafAKurLZc5Ghv47dazcpGH4KEaF22Gm3BL5IP5wcEAe/qpNrozuJQpeoLOdoAiMiaU8IeIVwna9MWhYH+h/O2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243659; c=relaxed/simple;
	bh=YjweV/KehPjabYCKI5kya6aZOpsZ65KV5Maz3v2jC18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMaZGK/GwoyckzXQPc+CXZBkFnY1XmBSgawbu+/5ZZxPKs4+v8IXLa4QcK/LtXx2OqosVEl4wThG+tdrMEd0/omenDCBbUAu8bqivjvSMpy2zKBQTlpcK+WSqinwWW0O8Uzn6GCsZ6lq7FksL8x0HOIj3s2qrtq/B5wBcGy1uiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m+kqmu6x; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q01gys7JZc0pvg5pNqz1bALPmXum/QCnj/KYgqI4yZsNGgp+q/AcgfAXjE4Nz6cfpZ6/Lc8J3CfqIU11yEBQ3PJM4DRGmcgLviFVQ3Xxmqzi2zBjizI+M33poVIJoVw0vUQswS1wQy1qLarAbVy/z+aoldoNtAdULq+WMnQ1GUduSFjXWTRR0ljoV+4XeWdhHrH5rxnP3imYuiSsoF7VfkW+6gir1bnwB98DfH3AwrZ4Vlsxw9rTrvb8YJJeavL9FG/Us1sg4FpiJb8giunjPO867Lz8Q0Osp0AcE2XA+C450OEMhDDKRGECXBG2ToQoJD9ZSeSztdVeR0aBQrnCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gs4d43OESxpIJgopQZ0trYtZ3T2ADjdtU4wo4igbxPc=;
 b=t/OLlgSt3MOtgCPuGnx0gdiwE10y+tPDiaNNMkzVxp+tlfDNeyIwwyVt/WcILBPEI57SAGWvAV6RbBxhvKzypmi7xCFf43xzlR26dlZH++BZvKAOqCDn8zM1ppaMhHYtulM0Q5qk89/3lN/dyLp83ZspAVhBp7XN6PgLr5dnOkyrjuEC+XQ4NNWQ0o+XcQ+io9DECCxGoNdDRO977Tuteuq7kR4HfFVSQLUuwtYsgHGR6CivBRFPTr+Ol9JfUsUCTbqLjw5KveugrBO0SNOqZ2wb5O3iz2ajrDHHFvY4pMNd01dZlIfGNbvF1BSq8aIPcBZEVgiZVTRAVNY3/cdZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gs4d43OESxpIJgopQZ0trYtZ3T2ADjdtU4wo4igbxPc=;
 b=m+kqmu6x5yMVcdaegtGEGSziYBmJzzBOPXyjJ7mMiR3CVocbIyUSmmNsKdbaq4UdM8on7HOZkL8YGvDEwS1m8xg3VQst4L7jvXBFRePlVRw771mJQSntK/GzPZ5vCb+axs2q0OF/lLNCAXhPkSiZB6d7lHT6AiXO7HXGjdn5oSdQSPPycxBpvwW7F8z1JwxOarYtDe7r0zeVRN7Orc9zNwjPXv0siV4Xa5prBznmWJxjNsF/Mcpd+x57rSr9AImPtDukXUZb1nQK/M2iva+mD7N5f5oGH0H6EKNXviHqMKJ6tMRsZ/I+QrGDiHHj9ZI2NJDBAGwDylfncdPvOT8PdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:20:52 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:20:52 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v7 06/15] iommupt: Add unmap_pages op
Date: Thu, 23 Oct 2025 15:20:36 -0300
Message-ID: <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f791a49-08d9-41df-7a65-08de1260e390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?soWHcTAz5gTBmyNLyRh1Saz6fA7/VyYsKvji2fncHCwtsUd5FG21Ex4WfUce?=
 =?us-ascii?Q?rJHdWLyaqVxBuc+6671xg9MCHxWZJSx7O//Sz7iaLiovNPIehXRZblclTDuH?=
 =?us-ascii?Q?nhjPfvZ45NAEpjaA/ePTJvP9XDsBlVLKwzXoNqc5pihztjS43tar+XkE6Ep+?=
 =?us-ascii?Q?JHSko3SGcv2zMzb0YlYsEYoXt+KlESGfgVF/KjuIDqTdUyBJ3nkPkyori5TG?=
 =?us-ascii?Q?bMNEBMsWy9+e1BTeo2FQgL+3u54chk3JjrY6w/O9UwSHM0K0H+HDkpHfMzuw?=
 =?us-ascii?Q?+VJyGu2Csj37hxwTGxfUGi6+nwKY+zxuLfBpWP0Cz6ug0uvFHSKnS2YJfHbt?=
 =?us-ascii?Q?0elhXN0uN2ajv9YvsSX4dByeUGa3wQmHDIXRc9rK7A52IlqgJnBySvZVJ9mY?=
 =?us-ascii?Q?xqIvpgVNWnM2O3XHr72SC1MH5W2YcsIEgPGjfhQw+Khp4yD2x2eEuGstInyD?=
 =?us-ascii?Q?t/wigoX7892b7RM/Wlq/fLhvqE12CBCa9vKuudKP5p6kAocw047DrqodL2Q8?=
 =?us-ascii?Q?D/HpF5WX1fHrkAFu+caXXIYvkZFFxZjhUX4axGC+srexoFplLz7QFWMKIBGB?=
 =?us-ascii?Q?5CZHVJ5lZIuLrlwoZQYanimI29uO5ysI9fbZd/AsQHaDqKpVJx1w7ah904UJ?=
 =?us-ascii?Q?R7WWThH1fqw8ZJOAJD4pp9HnXCowpX3taZxEeGqyH1Q8E1ElmN0+qiVlXC6D?=
 =?us-ascii?Q?riZl1pGWhcQgF0F/VCr5zDngtM766ukomplvtqNNBgQ1SNnX5qut9gYdbUVz?=
 =?us-ascii?Q?OL6+vkOvRGNmdefuB4SjK5b+DmNrQ5+Lx8JT/eZ4Cj5lrxtAMdWg45jvuO+j?=
 =?us-ascii?Q?Gkly8WjlQ7JYtCvMQ0ZcT9q08oTw3BFXtwWzx132d9hhr0LdZF0Y+4b6Wea+?=
 =?us-ascii?Q?ONKDovXBHWR8Og6SwDj42H49cxMhB8htxRkVYLPSKL+BDllqYvsoL5TlEA63?=
 =?us-ascii?Q?1yd21lQF+Ke7Lrpt7ITNMmLUQ+95l+4/OISEmpI18ze13Z8nlVt3ryooHwZw?=
 =?us-ascii?Q?oOVHBVV3ajTLT3dRm3DPifvSMxoky0GyYCkOB5YlDPtbLuonUQMLj7AwzuFs?=
 =?us-ascii?Q?vYkJwpj6rL59sQaM8ZU6PiYNiwSf3T+NjOH1UdlqneiCL5vU2qcxzIUiOJUL?=
 =?us-ascii?Q?fIGHoIMab0Qdm6zcil3mpgMayS3R0hLeJE5rCCE69RNy/V+CPvauZOVwst+o?=
 =?us-ascii?Q?Xy2eauM/JW/pWPO8d0crvEk/vng+0X/swVsK2sdk9NRonN5DiUnlDpQZF4IC?=
 =?us-ascii?Q?sQ/urOmrg4/RQvgXXsrgGWgF7nmkdLst4Q5D1yPBQwlBjP8TBckJ83/gkKcV?=
 =?us-ascii?Q?J1+VnL6MNS8EtNHe2O54fKkVhEBT7GfT+EkwGpgrM02uhZ/lVI+BLfgiJ74C?=
 =?us-ascii?Q?LWFW7/PRN4+EefJQ+jsGMwUBn2nknUiL/cJRoS59t4kGxWKIAgMcgbq9btzK?=
 =?us-ascii?Q?sm9Mz98ejEirQWP1HvZgnSvjux28YcgInuQAxJHDtYftLpktLP308B75nSFS?=
 =?us-ascii?Q?uybyMSTa7L7DVbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yvm/AW6uPDj43c6/5TjccxebEhtgOs5sZfhsQNTeeRruWRpQ3vq5mUM12MoG?=
 =?us-ascii?Q?Y+hmkxAHZiGoOBAuWy4e5z3MGlclF2Mymhxf653LElJCAQ2odf5vPVMX+pia?=
 =?us-ascii?Q?VutwwXF2yMxuIF8+NUtUCzrhzQjkDNVBLWrEfDp2sRPvEjor4503zOUeYOzm?=
 =?us-ascii?Q?er/4iWyikbqLyl1Zpq9wpXFvHnwzcmsW4gwBQLDRUxeIT2mu1shIefHL5S+W?=
 =?us-ascii?Q?5vsfsP9qQ0D+LKHrVf0o/l3kQO6vInXWml6vBJUzcXzmtcGuLQJF8Swb0oXN?=
 =?us-ascii?Q?3e/ro9bT5LlcURU/oSRVbtvlexreRLTmHdrfYt1TtRly3h63+oIFFaipiYDv?=
 =?us-ascii?Q?JjJPw8nUuW/n9eu1UI8FSZK51/zVw0cWbDyKD0mQ4IBxQUtaERY7ytnD8u7o?=
 =?us-ascii?Q?8DzDQ0pndilhllMsIDoEW8RoPRVvNc/qL6qUfZVuWMC4Ena9EEX+rykWRs3z?=
 =?us-ascii?Q?fCvCa9uzMf4SGC+nDNxzqVqmre+SL4MevK/DDVYWD7RRbLiP96mcbMPqvoDA?=
 =?us-ascii?Q?W7YoZBp49djn6CALQ2RfBz58z3jicZV+UZRhgspyudoR4UlZADRYCQKBXqNv?=
 =?us-ascii?Q?cpd5QzQ1Wa45UzJBW8UbDq8THfPqtISJ7V14/9lLbFLsbl46VLfOt7a5bC3F?=
 =?us-ascii?Q?m6vPyzJuT0xBTk79JhSsSi+DWccDQgDLIQ9+/gkttMPtA2V5YtQvE/LnWDll?=
 =?us-ascii?Q?gl+BaDcd2zmDkNEP9JqrrcdkikPojftL1UZgb/wlwBlAPwRpxfM1f1iBaek9?=
 =?us-ascii?Q?vrxFLAVkv0VL9FV6o/V0KE7uGn+o/Ah6fpVRCJ1SRaSXYc+6BfpZQxCZvokT?=
 =?us-ascii?Q?EP/IXfX5eaWZMMnwY3D9v7w8F69fWz5jy3uEilUmubxIJB3r4bjm7sdvwcjk?=
 =?us-ascii?Q?1NobWeR8Ax9knI72MmTAjq7f6iBRwedjO5sw1hydlchnPuxuyf+hfFCbn5Jq?=
 =?us-ascii?Q?1gs0lgU0qWzZTUbMmtX2LtUWcErPPsHNLaLWFVA0kGVXbeeDc6Jitv4IZLbN?=
 =?us-ascii?Q?HZlwzip3xTYBp0OfKDjn9ecYgrAY9XdIqnbmIMZU31q+tjkY984BjM87pbMR?=
 =?us-ascii?Q?epEtOGBj55qToIBLNnX5XZtI7sIKXB9p41fdZQZ5Wr482mue9U3ShDWT2tma?=
 =?us-ascii?Q?2vej7bGD/WizAmkLZDGQFQOxk2TL1CVT9vK/SOZuARvG6rsOiX0VIvEoXx0V?=
 =?us-ascii?Q?2QK4vyhuXcVoFGP6nKLGUTHMPtqJU+MyHiATy4olnpKycE8a9C1kmFK7hWBw?=
 =?us-ascii?Q?g9jGd5g9c7nMCge/axuy9+aKAU35JVDfLRmh/hHP4NaC4CqbZWBLMLmgLAnE?=
 =?us-ascii?Q?ttyaXgVGfIA0djahphPV/qr+HQMLC3nZmqjWdHri1yVPyxndxoLjDLMKwrF4?=
 =?us-ascii?Q?BtCIEyswM0T+ySRcyM/hjiyGcimPD6NVzk/NieFQIpw2SghldIaGHNq5N+aD?=
 =?us-ascii?Q?JjvrEx5z73x0v8Vfkb7EJ8UgoF4tzeTTLCpdpd7Q+UQ6fAv5OEjJ9dxcKvtL?=
 =?us-ascii?Q?dXQWR+3D92Q+U/ronCIqOaVJ1AmhGaF10BGcQmt4R5AVuliD6tKfRaEJoje0?=
 =?us-ascii?Q?5hHASPW9kpaxxTtF/C0tL/8K3x7esRD1ooOXdB5n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f791a49-08d9-41df-7a65-08de1260e390
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:49.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPLt7HMFON1uRXDA5veeOZj5XzOen5cl58zXQb7PHyaurH0X9TX7t+Q2KdhP86ej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 156 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 5ff1b887928a46..e3d1b272723db0 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
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
 
@@ -164,6 +187,139 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
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
+		/* Micro optimization */
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
+			fully_covered = pt_entry_fully_covered(
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
+				pt_clear_entries(&pts, ilog2(1));
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
+			pt_clear_entries(&pts, num_contig_lg2);
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
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @iotlb_gather: Gather struct that must be flushed on return
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
index 5622856e199881..ceb6bc9cea37cd 100644
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


