Return-Path: <linux-kselftest+bounces-32354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04AAA9572
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E717316EC4D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3B25C83F;
	Mon,  5 May 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JwowZGEr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79025B66D;
	Mon,  5 May 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454744; cv=fail; b=HaHmnkiMh8QaRxeoJydpinbjbRQAH5SN5j+iBOE00ICO6ebC9vbBsciuA8HXMNYXB2o6WfeL9IBgACQjoCMTqkW8Ofc49T2ep7TuWn8pAzNDMMIQrKeWM+Vm2y75ARSIdgkoC8lvOpisrxXX29UknjFgO4zvOJMk/Ze18kImtqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454744; c=relaxed/simple;
	bh=q88AhdmCO0WoolBaRi+I/JkHfMNA5knP5h8dUYZsLpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kaEOLa00c2g01jchglOhGr0WD/6IRkwrCdnZlC4zD+uGnPRRVwDNJ6HAYh17q1jc0vino5pIQI78mGox73Vi5nB6r/f7BzM4mxDFkfuf4PK0muaVxgrF/Us39htpfkm3dZb9+mJiXymbItKmpUNkbUUU2+2qFKV2UNiXTakcH5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JwowZGEr; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYBY4mtwuKzTIArYzGprP1zB2ap7z+jCSqAq4G+nlbOiTq06skrAGSqlZpAPuvDx4kAvb88qmsPo7tA4YFV6CbJ/g3+ryKkocvQZwuYTrc8J/1ukbGLLDrryYLAyor9aoPSm3ALBaG7k1nEgljIdQDqyZ+mfRkKltXvjMU9N9MPhlUIsf6SvQhs5jeUqsqhehNAzOoln5VsbaBA9emMmR0YfAGgnOMoWtjz14sKUvrCPP9v9XtNa68EkLdMVIsAbzCv1AcZ2ijcVwWRU6fNUcl1plpOPfwTspzBllW49NeBURkmFl57nCJWT4Y4EQbX6ORRTH7tNYW/zkJ9xgc+ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgE3kc79tCgLTRyylln7NCRiHnhgHqWBWtCimWnG+6A=;
 b=X/UhcC2J9rcdSJCtrjlWVsExRp7Y3vbMVz9ixyxOtSLemNn4kXo3DQoKsA19Rtep3zLdnc5lobKbFCcZ77BrwKeNz7+UqIiWOPTzxk9UUW68BxLbqGNUMdR5hEYI1HY0+U0ATZ6gCwq7iDbOob/uKRFvrbVAt3Gon/P4lD2JHhcMsj05tSApmw/vk442kPYgQvhyx388+V4uWWEvw9JFkCfxPJ1HszwJfD07nm+pjOkYTfZhIAeQdwr+Du6WKylK2sefHzHbJDs+UDsBnb26un7D+Z1adDFXy2S938d7jA8vK5YE9AqKVqyWOgpxkKQvWuiC8pKQ1Jes/VI3gDrtVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgE3kc79tCgLTRyylln7NCRiHnhgHqWBWtCimWnG+6A=;
 b=JwowZGEr1QEaWX1jBYxWL/Rg1GDIevxdedDLcqqywUAGBTeeT/8qaSLkThipfdhYiRTcICXNvIuBGY6MGb8jhj52KlA6PqkdBwgPbhdlvLz/oK3Rkn+rcFgTp4xfyExBmMwDpW4YC90FlxvCIOplG/3ORf6QARqCFB0rsXmvJb302ITpGDqWtj44i1XSeST/QplxUlsxv+iKezkkSV4/FtxzniNEY69U9V+tsd6oiSaLdl2w9kDJpKOABCs+lfH3x9mSBSgfA1TMBy2W+ABtAcGwBExM6vV1cn5v5pps5AW0+VR4OfPSUcR5+J3efqUexwSk/HCH+bgLiIeoAp0OYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:49 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:49 +0000
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
Subject: [PATCH v2 13/15] iommu/amd: Use the generic iommu page table
Date: Mon,  5 May 2025 11:18:43 -0300
Message-ID: <13-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0469.namprd03.prod.outlook.com
 (2603:10b6:408:139::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9889bae6-6120-4639-4b7c-08dd8bdfbfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOWI7HymI3dP6Mqr0b29hYQeUR//jHbnPcMO6xJFj2DxTqMuxRNn/SFGgYJ4?=
 =?us-ascii?Q?9CvD/zI3obRQvmMjCJGq3TJMcDzK6b1l/ov+uuDQVZPOv3dxZJmEfQy3q2V0?=
 =?us-ascii?Q?TV9mjdd2ral+IAKV066MHbWVC6Ao+oFtHVuyegha9txptCoO+fp3EtDLVDAX?=
 =?us-ascii?Q?qnoE3qw47TzSQi3htsQnlKA6gFoA3FPs1cHg1kHCsbuvqw7Hu0IJwHBDaelp?=
 =?us-ascii?Q?tRYK7DYKFLQcxhYnbNcBRCaHtSqHdseFdTYrDHWtx2/ztRUDMGHXy3A00PZC?=
 =?us-ascii?Q?/1eNHbDqN1L8XacfN1Lk9iwJXcUf5bpjBW8/7a4owm9jWvc0xr7C7I3abNAD?=
 =?us-ascii?Q?dzAdDJt07OWAj5i/xOlSXQmskR+jtATR1KUPLLTeW6d1f4FnyFVvNftoQyNZ?=
 =?us-ascii?Q?Fckh2LpWtOhFW6GSaWW6vF4DPt6VJZAOijJzcgVRxOmbJtHV/OTzK+mb77wR?=
 =?us-ascii?Q?RqXuE4FC7tWAw+phn2f9uqNGo0zykqu8Lkyu8v07YnroQHiSjfM3bLDL/E0/?=
 =?us-ascii?Q?X4MCHzN/GR8fs/FXeLDh+x+fZPWL4kj4DebyBZvxcX7mWDys3jcM4eASfpVQ?=
 =?us-ascii?Q?BETNf76eVIPlKRDmiVBEVgjx1GtlUhxtTrK4fltEQfybl7zyNC4/4cXSnDae?=
 =?us-ascii?Q?aa5i3PSf54nTOlcAb5eVTUJ0dn7H8sAYgbtJhWT6iKzT5ii4S4WZt4BwO4J1?=
 =?us-ascii?Q?+0ATXbH1BTm1sWkonGJNE3I9TySAR04xvjRdaD/H86yJjEhhETFVnO+p0sxl?=
 =?us-ascii?Q?FZ6sJByFDl1KhErIiW8Jzy1CZnF4nyDGQpOjrW7q9sT463S22KpaVApqeq4n?=
 =?us-ascii?Q?0ZbhGIdwOim7MnGCQA/8kUio4yajvhsDUik0zxG95ZZnQ7mowDakfYf94juf?=
 =?us-ascii?Q?48Qiks9iYd+7khMAXy82Jl32nn3jDma4nrMEZ605EJFhC/uTgO8aO+MGzjPs?=
 =?us-ascii?Q?91PeLuELa6B3u3XolwMJwEkIDuEEx1hnyAFIGHbA5gN/vXP6H/zZshEjW/fL?=
 =?us-ascii?Q?xWlUBdyEjAmSulwFkwiFmxVBcanNNwKeDmBMEo0lkoDfEUhwhlqYzmIJCTV5?=
 =?us-ascii?Q?Ih3SAwtXI2aytmYfsAIZAs7t68jT+O5METgKcJrIaNqXo4JQ+CKMR1x3yOeQ?=
 =?us-ascii?Q?N1i8W+prvmVVVfxwiNIshamZwJyLTmmrsVFJul4/u9rJg8nBi1PUbg5wjrTN?=
 =?us-ascii?Q?qEangDKp9Zyk1zwleE5tRS5x+ZVkyULsFDznaxrvrxsvw6CoeLpmUn9d8NfP?=
 =?us-ascii?Q?+FrdzdMQxKSe2x480Nm2JY6gwz7vO9hSAIN3cHiuSvQp9c5pWrIhxPYO6Fhw?=
 =?us-ascii?Q?AolMqOs7dSR0pV0Hns8cV4bXB4Dlb0YmGvfm8o3MEW6CMCMvakX3MBIBofgO?=
 =?us-ascii?Q?qvDliajwnU18M31fREBr72oFd0qXBQlvDhFQViVb1ppm+rpyemmbIcxDcPLB?=
 =?us-ascii?Q?0fVw46dDDDrl5cziLLGdYP+UzplMFrR4Hvlk2EdNnQOvTTFH8xjtRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?udmTrz1DiLyiUsHYNocucAZspN2K7TsCLUmA+z8Xx3Cd3N1NEaO+FZQeY+aL?=
 =?us-ascii?Q?ZHm4lnna+ftq4YvjH3P9DDAYIr2396MaUESjTCmpm7Ir9U3wQ4S71xD39GOp?=
 =?us-ascii?Q?q0nOAtJKrE1qpAjk0LpOLbQwenBITGodk1YwNeFq1eMC3QheD9OdVLwaQD97?=
 =?us-ascii?Q?LBPRnAMy2LrO6E0o9Osv8e37m1UnN3ddoJp+nw8bJ7Hx2UMtYp9EwuXU/omg?=
 =?us-ascii?Q?ozrrNnM6vXxFeDm2lYw5YgSy5w5TCVg5ovUCh9ohuLbTVcx115g3xwyK1oDJ?=
 =?us-ascii?Q?u+iWagCD/5nLdaZgT+At1hAl7xOPPctk1bxqxbhPBHRzQjmCiy/a2BplXe+X?=
 =?us-ascii?Q?YSAtyqetsWi3CwBIsmqDSuV/tYaCmEiZCH9O/0nT6yDNGbJH4C3UulpTN6Cs?=
 =?us-ascii?Q?O0ZFA0pLqASJZ2GmNX8DoPr84+6gFFn2vybadOn0C4VuDHpohg7Bb1zB+LR1?=
 =?us-ascii?Q?ZC6NP6+4VbKcVc1S7x/502O4Ssb2IJ3nh2Sj+XMbGMDdBPkQnbHlNBiSgEn3?=
 =?us-ascii?Q?moA6EKOZ1mGmfVVJ3H7jZVf/a19xZ3jJH24j8o9wyGZIX17rFLEoOCLGXrOJ?=
 =?us-ascii?Q?fcreJyNRd120h3RLNiKIUdfSOj+d+GbruJlIdsgYZGUCXX/6Cntvzrn8wOB/?=
 =?us-ascii?Q?L4m1aAIylphitTVOak/BZeGxw0PB+4upyLslHd6EpM/mDMJl+KHFbfF1zBD5?=
 =?us-ascii?Q?O2gG/nt8rQbFLFZu3uzrjaN7rbAC5sMeNFfl8s/X7F1yGy4BsEPfVuFfd7Zx?=
 =?us-ascii?Q?/SPimEoJ54s/+Ji5yuhs7HEKEGImvzElqRPk1qD6ZSbK9+ykQlZdrFIpKTgE?=
 =?us-ascii?Q?QPYIWBq4+o8AJh3A2KLNy5xAlqsQ9mHcGm28X9qmQmAYK0TSbBMr7IDKeydP?=
 =?us-ascii?Q?xThg9LOJYJqnv+AjJJoukrODZzkO5B/pCI4tzNs6itS9ic9B5OhfqeDIeeCl?=
 =?us-ascii?Q?jKBq8TNvIuxU0ll41timNcnUjvrldGWN0SqW2cZPkJj+QYzXlLAI+fJv99sZ?=
 =?us-ascii?Q?DLZK96wkWgG9c++Laf0SjHi28JDygZSzZY3k2x9o83h+6TbQRrz9iUPmd4DY?=
 =?us-ascii?Q?Y/WhTrKL/9yVJOLPT1/buli4cVNNqLoJ13XSn222Bkg6qZoLjlS0fllZzWmB?=
 =?us-ascii?Q?uXoIcx7o+ip5Am7B56BtZAmFRCGniVkK4j4Gfbuwz8AWzyiw7pwX/oKSk8xd?=
 =?us-ascii?Q?ufxbbXRSlaO55HB/+HRuq+fK8IY1gsFXNSR/culnuVQAVudMyO2vs3KyEDWN?=
 =?us-ascii?Q?48F4+sKO+F+lfdqWxzLvknKoeYhK/WFb4V8TDXrL/gI8RwI6U97rJTSwcW+y?=
 =?us-ascii?Q?DiH/ktslZ7uev13Epg3UWm8oxIQWmm7/Y9VxLFJAx7swB6Nf9PM4vkL4Lhpv?=
 =?us-ascii?Q?c1eM6flNVrj7d90E76UKDCSsAwsxlSsEPrOsfLvAaHzYWeOIWu1cmutbdGZ3?=
 =?us-ascii?Q?fjeyv5COVAbD35s8/sy4DsdBcZuwJSgwtWx+ib72xlMKYsLMz9pbduDgpKHf?=
 =?us-ascii?Q?sw+vZdUlbOpIJHtUj3WV6/2YuZhh/vZydFLmeev9oZDVX0e5ZMhU3jdOgXpa?=
 =?us-ascii?Q?pMIqzLv/AHCLwfGA+hiufkYpcd18ux4LG7ToPa8y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9889bae6-6120-4639-4b7c-08dd8bdfbfc8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:47.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVuzC4qZnva4pu/ZuTkl7nvvxnZ3cSQy6hSS9/IBk1qip9TVWckEOi63s1LB09Mk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

Replace the io_pgtable versions with pt_iommu versions. The v2 page table
uses the x86 implementation that will be eventually shared with VT-D.

This supports the same special features as the original code:
 - increase_top for the v1 format to allow scaling from 3 to 6 levels
 - non-present flushing
 - Dirty tracking for v1 only
 - __sme_set() to adjust the PTEs for CC
 - Optimization for flushing with virtualization to minimize the range
 - amd_iommu_pgsize_bitmap override of the native page sizes
 - page tables allocate from the device's NUMA node

Rework the domain ops so that v1/v2 get their own ops. Make dedicated
allocation functions for v1 and v2. Hook up invalidation for a top change
to struct pt_iommu_flush_ops. Delete some of the iopgtable related code
that becomes unused in this patch. The next patch will delete the rest of
it.

This fixes a race bug in AMD's increase_address_space() implementation. It
stores the top level and top pointer in different memory, which prevents
other threads from reading a coherent version:

   increase_address_space()   alloc_pte()
                                level = pgtable->mode - 1;
	pgtable->root  = pte;
	pgtable->mode += 1;
                                pte = &pgtable->root[PM_LEVEL_INDEX(level, address)];

The iommupt version is careful to put mode and root under a single
READ_ONCE and then is careful to only READ_ONCE a single time per
walk.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig           |   5 +-
 drivers/iommu/amd/amd_iommu.h       |   1 -
 drivers/iommu/amd/amd_iommu_types.h |  12 +-
 drivers/iommu/amd/io_pgtable.c      |   1 -
 drivers/iommu/amd/iommu.c           | 493 ++++++++++++++--------------
 5 files changed, 256 insertions(+), 256 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 994063e5586f0f..9f3e3ebd49a201 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,10 +10,13 @@ config AMD_IOMMU
 	select MMU_NOTIFIER
 	select IOMMU_API
 	select IOMMU_IOVA
-	select IOMMU_IO_PGTABLE
 	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	select IOMMU_PT_X86_64
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
 	  With this option you can enable support for AMD IOMMU hardware in
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 220c598b7e1486..9b3ee4cf23d14e 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -86,7 +86,6 @@ int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag);
  * the IOMMU used by this driver.
  */
 void amd_iommu_flush_all_caches(struct amd_iommu *iommu);
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 				  u64 address, size_t size);
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bc9f0bbf3c0864..abd05ef75239d4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
 #include <linux/io-pgtable.h>
+#include <linux/generic_pt/iommu.h>
 
 /*
  * Maximum number of IOMMUs supported
@@ -582,9 +583,13 @@ struct pdom_iommu_info {
  * independent of their use.
  */
 struct protection_domain {
+	union {
+		struct iommu_domain domain;
+		struct pt_iommu iommu;
+		struct pt_iommu_amdv1 amdv1;
+		struct pt_iommu_x86_64 amdv2;
+	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct iommu_domain domain; /* generic domain handle used by
-				       iommu core code */
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
@@ -595,6 +600,9 @@ struct protection_domain {
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv1.iommu, domain);
+PT_IOMMU_CHECK_DOMAIN(struct protection_domain, amdv2.iommu, domain);
 
 /*
  * This structure contains information about one PCI segment in the system.
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 4d308c07113495..e4b33eba554599 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -132,7 +132,6 @@ static bool increase_address_space(struct amd_io_pgtable *pgtable,
 
 	pgtable->root  = pte;
 	pgtable->mode += 1;
-	amd_iommu_update_and_flush_device_table(domain);
 
 	pte = NULL;
 	ret = true;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dea0fed7abb044..6f0da8123101b2 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -28,7 +28,6 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
-#include <linux/io-pgtable.h>
 #include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
@@ -39,9 +38,9 @@
 #include <asm/gart.h>
 #include <asm/dma.h>
 #include <uapi/linux/iommufd.h>
+#include <linux/generic_pt/iommu.h>
 
 #include "amd_iommu.h"
-#include "../dma-iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
@@ -79,11 +78,18 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev);
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data);
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level);
+
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level);
 
 static void iommu_flush_dte_sync(struct amd_iommu *iommu, u16 devid);
 
 static struct iommu_dev_data *find_dev_data(struct amd_iommu *iommu, u16 devid);
+static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain);
+static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
+					bool enable);
 
 /****************************************************************************
  *
@@ -1730,42 +1736,6 @@ static void dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 					CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
 }
 
-/* Flush the not present cache if it exists */
-static void domain_flush_np_cache(struct protection_domain *domain,
-		dma_addr_t iova, size_t size)
-{
-	if (unlikely(amd_iommu_np_cache)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&domain->lock, flags);
-		amd_iommu_domain_flush_pages(domain, iova, size);
-		spin_unlock_irqrestore(&domain->lock, flags);
-	}
-}
-
-
-/*
- * This function flushes the DTEs for all devices in domain
- */
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	lockdep_assert_held(&domain->lock);
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-
-	list_for_each_entry(dev_data, &domain->dev_list, list)
-		device_flush_dte(dev_data);
-
-	domain_flush_complete(domain);
-}
-
 int amd_iommu_complete_ppr(struct device *dev, u32 pasid, int status, int tag)
 {
 	struct iommu_dev_data *dev_data;
@@ -2025,7 +1995,8 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
-			  struct iommu_dev_data *dev_data)
+			  struct iommu_dev_data *dev_data,
+			  phys_addr_t top_paddr, unsigned int top_level)
 {
 	u16 domid;
 	u32 old_domid;
@@ -2034,19 +2005,36 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
-
-	if (gcr3_info && gcr3_info->gcr3_tbl)
-		domid = dev_data->gcr3_info.domid;
-	else
-		domid = domain->id;
+	struct pt_iommu_amdv1_hw_info pt_info;
 
 	make_clear_dte(dev_data, dte, &new);
 
-	if (domain->iop.mode != PAGE_MODE_NONE)
-		new.data[0] |= iommu_virt_to_phys(domain->iop.root);
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		domid = dev_data->gcr3_info.domid;
+	else {
+		domid = domain->id;
 
-	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
-		    << DEV_ENTRY_MODE_SHIFT;
+		if (domain->domain.type & __IOMMU_DOMAIN_PAGING) {
+			/*
+			 * When updating the IO pagetable, the new top and level
+			 * are provided as parameters. For other operations i.e.
+			 * device attach, retrieve the current pagetable info
+			 * via the IOMMU PT API.
+			 */
+			if (top_paddr) {
+				pt_info.host_pt_root = top_paddr;
+				pt_info.mode = top_level + 1;
+			} else {
+				WARN_ON(top_paddr || top_level);
+				pt_iommu_amdv1_hw_info(&domain->amdv1,
+						       &pt_info);
+			}
+
+			new.data[0] |= pt_info.host_pt_root |
+				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
+					       << DEV_ENTRY_MODE_SHIFT;
+		}
+	}
 
 	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW;
 
@@ -2112,7 +2100,7 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (set)
-		set_dte_entry(iommu, dev_data);
+		set_dte_entry(iommu, dev_data, 0, 0);
 	else
 		clear_dte_entry(iommu, dev_data);
 
@@ -2130,6 +2118,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int max_pasids = dev_data->max_pasids;
+	struct pt_iommu_x86_64_hw_info pt_info;
 	int ret = 0;
 
 	 /*
@@ -2152,7 +2141,8 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 	if (!pdom_is_v2_pgtbl_mode(pdom))
 		return ret;
 
-	ret = update_gcr3(dev_data, 0, iommu_virt_to_phys(pdom->iop.pgd), true);
+	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
+	ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
@@ -2467,49 +2457,113 @@ struct protection_domain *protection_domain_alloc(void)
 	return domain;
 }
 
-static int pdom_setup_pgtable(struct protection_domain *domain,
-			      struct device *dev)
-{
-	struct io_pgtable_ops *pgtbl_ops;
-	enum io_pgtable_fmt fmt;
-
-	switch (domain->pd_mode) {
-	case PD_MODE_V1:
-		fmt = AMD_IOMMU_V1;
-		break;
-	case PD_MODE_V2:
-		fmt = AMD_IOMMU_V2;
-		break;
-	}
-
-	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &domain->iop.pgtbl.cfg, domain);
-	if (!pgtbl_ops)
-		return -ENOMEM;
-
-	return 0;
-}
-
-static inline u64 dma_max_address(enum protection_domain_mode pgtable)
-{
-	if (pgtable == PD_MODE_V1)
-		return ~0ULL;
-
-	/* V2 with 4/5 level page table */
-	return ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
-}
-
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-static struct iommu_domain *
-do_iommu_domain_alloc(struct device *dev, u32 flags,
-		      enum protection_domain_mode pgtable)
+static spinlock_t *amd_iommu_get_top_lock(struct pt_iommu *iommupt)
 {
-	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct protection_domain *pdom =
+		container_of(iommupt, struct protection_domain, iommu);
+
+	return &pdom->lock;
+}
+
+/*
+ * Update all HW references to the domain with a new pgtable configuration.
+ */
+static void amd_iommu_change_top(struct pt_iommu *iommu_table,
+				 phys_addr_t top_paddr, unsigned int top_level)
+{
+	struct protection_domain *pdom =
+		container_of(iommu_table, struct protection_domain, iommu);
+	struct iommu_dev_data *dev_data;
+
+	lockdep_assert_held(&pdom->lock);
+
+	/* Update the DTE for all devices attached to this domain */
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		/* Update the HW references with the new level and top ptr */
+		set_dte_entry(iommu, dev_data, top_paddr, top_level);
+		clone_aliases(iommu, dev_data->dev);
+	}
+
+	list_for_each_entry(dev_data, &pdom->dev_list, list)
+		device_flush_dte(dev_data);
+
+	domain_flush_complete(pdom);
+}
+
+/*
+ * amd_iommu_iotlb_sync_map() is used to generate flushes for non-present to
+ * present (ie mapping) operations. It is a NOP if the IOMMU doesn't have non
+ * present caching (like hypervisor shadowing).
+ */
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
+{
+	struct protection_domain *domain = to_pdomain(dom);
+	unsigned long flags;
+
+	if (likely(!amd_iommu_np_cache))
+		return 0;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	amd_iommu_domain_flush_pages(domain, iova, size);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	return 0;
+}
+
+static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_all(dom);
+	spin_unlock_irqrestore(&dom->lock, flags);
+}
+
+static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+				 struct iommu_iotlb_gather *gather)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dom->lock, flags);
+	amd_iommu_domain_flush_pages(dom, gather->start,
+				     gather->end - gather->start + 1);
+	spin_unlock_irqrestore(&dom->lock, flags);
+	iommu_put_pages_list(&gather->freelist);
+}
+
+static const struct pt_iommu_flush_ops amd_hw_flush_ops_v1 = {
+	.get_top_lock = amd_iommu_get_top_lock,
+	.change_top = amd_iommu_change_top,
+};
+
+static const struct iommu_domain_ops amdv1_ops = {
+	IOMMU_PT_DOMAIN_OPS(amdv1),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
+
+static const struct iommu_dirty_ops amdv1_dirty_ops = {
+	IOMMU_PT_DIRTY_OPS(amdv1),
+	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
+};
+
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_amdv1_cfg cfg = {};
 	struct protection_domain *domain;
 	int ret;
 
@@ -2517,25 +2571,106 @@ do_iommu_domain_alloc(struct device *dev, u32 flags,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->pd_mode = pgtable;
-	ret = pdom_setup_pgtable(domain, dev);
+	domain->pd_mode = PD_MODE_V1;
+	domain->iommu.hw_flush_ops = &amd_hw_flush_ops_v1;
+	domain->iommu.nid = dev_to_node(dev);
+	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
+		domain->domain.dirty_ops = &amdv1_dirty_ops;
+
+	/*
+	 * Someday FORCE_COHERENCE should be set by
+	 * amd_iommu_enforce_cache_coherency() like VT-D does.
+	 */
+	cfg.common.features = BIT(PT_FEAT_DYNAMIC_TOP) |
+			      BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
+			      BIT(PT_FEAT_AMDV1_FORCE_COHERENCE);
+
+	/*
+	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
+	 * Unless we run in a virtual machine, which can be inferred according
+	 * to whether "non-present cache" is on, it is probably best to prefer
+	 * (potentially) too extensive TLB flushing (i.e., more misses) over
+	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
+	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
+	 * the guest, and the trade-off is different: unnecessary TLB flushes
+	 * should be avoided.
+	 */
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	cfg.common.hw_max_vasz_lg2 = 64;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	cfg.starting_level = 2;
+	domain->domain.ops = &amdv1_ops;
+
+	ret = pt_iommu_amdv1_init(&domain->amdv1, &cfg, GFP_KERNEL);
 	if (ret) {
-		pdom_id_free(domain->id);
-		kfree(domain);
+		amd_iommu_domain_free(&domain->domain);
 		return ERR_PTR(ret);
 	}
 
-	domain->domain.geometry.aperture_start = 0;
-	domain->domain.geometry.aperture_end   = dma_max_address(pgtable);
-	domain->domain.geometry.force_aperture = true;
-	domain->domain.pgsize_bitmap = domain->iop.pgtbl.cfg.pgsize_bitmap;
+	/*
+	 * Narrow the supported page sizes to those selected by the kernel
+	 * command line.
+	 */
+	domain->domain.pgsize_bitmap &= amd_iommu_pgsize_bitmap;
+	return &domain->domain;
+}
 
-	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = iommu->iommu.ops->default_domain_ops;
+static const struct iommu_domain_ops amdv2_ops = {
+	IOMMU_PT_DOMAIN_OPS(x86_64),
+	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
+	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
+	.iotlb_sync = amd_iommu_iotlb_sync,
+	.attach_dev = amd_iommu_attach_device,
+	.free = amd_iommu_domain_free,
+	/*
+	 * Note the AMDv2 page table format does not support a Force Coherency
+	 * bit, so enforce_cache_coherency should not be set. However VFIO is
+	 * not prepared to handle a case where some domains will support
+	 * enforcement and others do not. VFIO and iommufd will have to be fixed
+	 * before it can fully use the V2 page table. See the comment in
+	 * iommufd_hwpt_paging_alloc(). For now leave things as they have
+	 * historically been and lie about enforce_cache_coherencey.
+	 */
+	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
+};
 
-	if (dirty_tracking)
-		domain->domain.dirty_ops = &amd_dirty_ops;
+static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
+							     u32 flags)
+{
+	struct pt_iommu_x86_64_cfg cfg = {};
+	struct protection_domain *domain;
+	int ret;
 
+	domain = protection_domain_alloc();
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	domain->pd_mode = PD_MODE_V2;
+	domain->iommu.nid = dev_to_node(dev);
+
+	cfg.common.features = BIT(PT_FEAT_SIGN_EXTEND) |
+			      BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+	if (amd_iommu_np_cache)
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
+	else
+		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
+
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		cfg.common.hw_max_vasz_lg2 = 57;
+	else
+		cfg.common.hw_max_vasz_lg2 = 48;
+	cfg.common.hw_max_oasz_lg2 = 52;
+	domain->domain.ops = &amdv2_ops;
+
+	ret = pt_iommu_x86_64_init(&domain->amdv2, &cfg, GFP_KERNEL);
+	if (ret) {
+		amd_iommu_domain_free(&domain->domain);
+		return ERR_PTR(ret);
+	}
 	return &domain->domain;
 }
 
@@ -2556,15 +2691,17 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		/* Allocate domain with v1 page table for dirty tracking */
 		if (!amd_iommu_hd_support(iommu))
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
+		return amd_iommu_domain_alloc_paging_v1(dev, flags);
 	case IOMMU_HWPT_ALLOC_PASID:
 		/* Allocate domain with v2 page table if IOMMU supports PASID. */
 		if (!amd_iommu_pasid_supported())
 			break;
-		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
 	case 0:
 		/* If nothing specific is required use the kernel commandline default */
-		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
+		if (amd_iommu_pgtable == PD_MODE_V1)
+			return amd_iommu_domain_alloc_paging_v1(dev, flags);
+		return amd_iommu_domain_alloc_paging_v2(dev, flags);
 	default:
 		break;
 	}
@@ -2576,8 +2713,9 @@ void amd_iommu_domain_free(struct iommu_domain *dom)
 	struct protection_domain *domain = to_pdomain(dom);
 
 	WARN_ON(!list_empty(&domain->dev_list));
+	/* Passed pt_iommu_XX_init() */
 	if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
-		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
+		pt_iommu_deinit(&domain->iommu);
 	pdom_id_free(domain->id);
 	kfree(domain);
 }
@@ -2682,93 +2820,6 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				    unsigned long iova, size_t size)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	if (ops->map_pages)
-		domain_flush_np_cache(domain, iova, size);
-	return 0;
-}
-
-static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
-			       phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			       int iommu_prot, gfp_t gfp, size_t *mapped)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	int prot = 0;
-	int ret = -EINVAL;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return -EINVAL;
-
-	if (iommu_prot & IOMMU_READ)
-		prot |= IOMMU_PROT_IR;
-	if (iommu_prot & IOMMU_WRITE)
-		prot |= IOMMU_PROT_IW;
-
-	if (ops->map_pages) {
-		ret = ops->map_pages(ops, iova, paddr, pgsize,
-				     pgcount, prot, gfp, mapped);
-	}
-
-	return ret;
-}
-
-static void amd_iommu_iotlb_gather_add_page(struct iommu_domain *domain,
-					    struct iommu_iotlb_gather *gather,
-					    unsigned long iova, size_t size)
-{
-	/*
-	 * AMD's IOMMU can flush as many pages as necessary in a single flush.
-	 * Unless we run in a virtual machine, which can be inferred according
-	 * to whether "non-present cache" is on, it is probably best to prefer
-	 * (potentially) too extensive TLB flushing (i.e., more misses) over
-	 * mutliple TLB flushes (i.e., more flushes). For virtual machines the
-	 * hypervisor needs to synchronize the host IOMMU PTEs with those of
-	 * the guest, and the trade-off is different: unnecessary TLB flushes
-	 * should be avoided.
-	 */
-	if (amd_iommu_np_cache &&
-	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
-		iommu_iotlb_sync(domain, gather);
-
-	iommu_iotlb_gather_add_range(gather, iova, size);
-}
-
-static size_t amd_iommu_unmap_pages(struct iommu_domain *dom, unsigned long iova,
-				    size_t pgsize, size_t pgcount,
-				    struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-	size_t r;
-
-	if ((domain->pd_mode == PD_MODE_V1) &&
-	    (domain->iop.mode == PAGE_MODE_NONE))
-		return 0;
-
-	r = (ops->unmap_pages) ? ops->unmap_pages(ops, iova, pgsize, pgcount, NULL) : 0;
-
-	if (r)
-		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
-
-	return r;
-}
-
-static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
-					  dma_addr_t iova)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	struct io_pgtable_ops *ops = &domain->iop.pgtbl.ops;
-
-	return ops->iova_to_phys(ops, iova);
-}
-
 static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
@@ -2835,28 +2886,6 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 }
 
-static int amd_iommu_read_and_clear_dirty(struct iommu_domain *domain,
-					  unsigned long iova, size_t size,
-					  unsigned long flags,
-					  struct iommu_dirty_bitmap *dirty)
-{
-	struct protection_domain *pdomain = to_pdomain(domain);
-	struct io_pgtable_ops *ops = &pdomain->iop.pgtbl.ops;
-	unsigned long lflags;
-
-	if (!ops || !ops->read_and_clear_dirty)
-		return -EOPNOTSUPP;
-
-	spin_lock_irqsave(&pdomain->lock, lflags);
-	if (!pdomain->dirty_tracking && dirty->bitmap) {
-		spin_unlock_irqrestore(&pdomain->lock, lflags);
-		return -EINVAL;
-	}
-	spin_unlock_irqrestore(&pdomain->lock, lflags);
-
-	return ops->read_and_clear_dirty(ops, iova, size, flags, dirty);
-}
-
 static void amd_iommu_get_resv_regions(struct device *dev,
 				       struct list_head *head)
 {
@@ -2923,28 +2952,6 @@ static bool amd_iommu_is_attach_deferred(struct device *dev)
 	return dev_data->defer_attach;
 }
 
-static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_all(dom);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
-static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
-{
-	struct protection_domain *dom = to_pdomain(domain);
-	unsigned long flags;
-
-	spin_lock_irqsave(&dom->lock, flags);
-	amd_iommu_domain_flush_pages(dom, gather->start,
-				     gather->end - gather->start + 1);
-	spin_unlock_irqrestore(&dom->lock, flags);
-}
-
 static int amd_iommu_def_domain_type(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -2979,11 +2986,6 @@ static bool amd_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 	return true;
 }
 
-static const struct iommu_dirty_ops amd_dirty_ops = {
-	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
-	.read_and_clear_dirty = amd_iommu_read_and_clear_dirty,
-};
-
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
@@ -3032,17 +3034,6 @@ const struct iommu_ops amd_iommu_ops = {
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
 	.page_response = amd_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev	= amd_iommu_attach_device,
-		.map_pages	= amd_iommu_map_pages,
-		.unmap_pages	= amd_iommu_unmap_pages,
-		.iotlb_sync_map	= amd_iommu_iotlb_sync_map,
-		.iova_to_phys	= amd_iommu_iova_to_phys,
-		.flush_iotlb_all = amd_iommu_flush_iotlb_all,
-		.iotlb_sync	= amd_iommu_iotlb_sync,
-		.free		= amd_iommu_domain_free,
-		.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
-	}
 };
 
 #ifdef CONFIG_IRQ_REMAP
-- 
2.43.0


