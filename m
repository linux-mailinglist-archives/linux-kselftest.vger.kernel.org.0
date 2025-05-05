Return-Path: <linux-kselftest+bounces-32356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A14EAA9575
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D2E175510
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0635725CC5F;
	Mon,  5 May 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UTUNhb4j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450525B1E0;
	Mon,  5 May 2025 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454744; cv=fail; b=XhW6p9TW+P7UCUnJp1y0PLVvcRbmwhMOeRX13e8JIm07X0ZPhwKStD6RcPjT5TLRzIfvT0uvTC6ulSTc7G1wKVBs3kfeX8x+29aAiTAcTcm5xds5PEK2ZX2mKs0QiXG0B6pPjlxTQMAa4gX9zMUXFoKXdXRaONj3+crrq0LjwQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454744; c=relaxed/simple;
	bh=1f5zkK2ikFEpn25AHbuTfAcX7PuFHoHywUP3Z2oCKXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X5LDAh33vIIDmWOixFggW9EWyVcS4Nh9JDo+5/aNBPav8GqIdQWU8qgLxVL1aPqNo0p5HkIHVYoPngTB1v/7ZJvY/agsQ/lfSwS3vmhDu02fDuh3JIbctx4ETtf+Z8FypFIbeITFGYCkPL9e3hMlOv4hTqIcdeyb1znjEGItxps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UTUNhb4j; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWl88TaR+3GcDmzFPWbZgpxlAxUHFHkQQIKceXYr5eQueXKmbF/XJ1VNmD84/wveHkhWiG8cAsAJOunyVhiraLJzS3bFJdT1XelrnJGOXWKGNsLN2fsjXuCIkvaN3vAbNZDYNrQGE87keEGla9W9YKyDpM4C+hHBTQgTPYDAeSJ4P8zBK4ZkQuPu3CSPs2in39FRmWSlpLAM+R6K9vKNf0Y7j9NNTK5DkYDBZ6YnpxVcPoZh36vXiQ3utsWZR8mmVvdj4NRX0JgZBLJJ4CM7+XZkg8AvTbJkfpgp037DqveLmR/x/F+tuUX20kP8Oiug45jpiKogDI2ojJ9axDmF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEMTstSqQ7nU9MLlSRGSKFvQzhZTiZ+oKPHzwjBHohc=;
 b=wDLcDkwXkh7uv7QP0UG3IIiilayIRD5NgQi1C9g6uFuMlC9ibGYrQsXShI/g0VDqUHI6Gqh7vM3B4kdTghJyQdeCpMpcYYmxu1fomAifuy2Wf8qpzgdYMa75eT61dBkBbeatVp3AV2Nwnv9NH1p8lS2q3LWMEiyEouHRY5D/ZEXgA618V41K86RfmhRItIDiCf5N+Q8t5dxiTQel4EA5bTx/+RNYqtRIGFi6dCU8Yp+hH+I2EkcM2dp5Qzdhb493VDL50wrXsFTl++U+DqjDlpNzMcO2uWtNhHrA1h4Vuyp/gyvhgI0kO1zWejKkG3kblLeuxjAPr4MIYEMy4rJH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEMTstSqQ7nU9MLlSRGSKFvQzhZTiZ+oKPHzwjBHohc=;
 b=UTUNhb4joMKuWnVIlTV7obg53XYhlKSlOdz26fcatR8525CZ216aO3CRyb8xjJwlcDpAwFNWGgvnITl8tWRBE+IQvT291MR8WHWiMnyImpQDFCHp6nzR1PLDTj8P40C9cevshlTn090dY4+Tdw0eP8TOKd3LSasWy0vMQYOD+5G2585gQp4nu8RC8xTvQU87NCeslxgOUyVTQup3NTy2y6iiI7VxoPZ+9kk+eoU9vm4iVclJ92dSKY9nYQtigLsh16ioY0ZsezxDPWULsM1svPppqMMJd7lJpRF6bEyIWwQ80EhW6kmdcz0A8qnQqeJaGof39CTZCAhZ8o+kVELmyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:50 +0000
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
Subject: [PATCH v2 04/15] iommupt: Add the AMD IOMMU v1 page table format
Date: Mon,  5 May 2025 11:18:34 -0300
Message-ID: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0470.namprd03.prod.outlook.com
 (2603:10b6:408:139::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9d7037-5a27-44d7-0686-08dd8bdfc027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dNaMgdYflaA/i2+hmYKP3fC1uzDuJ0RUALQYjgofwHJc3R/Pm8q+S6rNcoGx?=
 =?us-ascii?Q?syf+MNJMoFPly/gFeWMd+pI3ByYUVlMgn7IsWhsQwyp9F9QlLup6dCfUaw56?=
 =?us-ascii?Q?746Xei0C3C/p54xxeS9M66vdKH/dVyXuzwPVBouLq6VG14ECluFevAjH3wDm?=
 =?us-ascii?Q?TGTCQky3mHtmwTpDVgboWf1WAkaBYAJ/n3wUM5lV7mRlDnei645LPriyLhY8?=
 =?us-ascii?Q?E8gU1WLJvvYP3YnP0t4XoMlAlQdwA+/nKejKRnWiRtCPVP7f5lH5EZbsZAnC?=
 =?us-ascii?Q?tWH8a+y4uM/IZUTUdmfKhGpwPfKVp66iJA7g3ROpodk4p2kpQTV4PkONFOrw?=
 =?us-ascii?Q?0eYX9fsFNQKXYZPesm4fZNaNIaPK90+alapf+w7XbHT8PAAXSHvspnTAJKSe?=
 =?us-ascii?Q?Y/v2X+8DN0ZZfky29etWo0WHbmznLn5MPMd9cgrVMg6u4udiocYy1dDfjxTd?=
 =?us-ascii?Q?CPjpZtBBPwmrEwExtYD41fpqHrjpSb41ZLCbnkSoT4bSdIRufZxGcL34cqLO?=
 =?us-ascii?Q?L2MDOZduoEx/VpBd3XvQInkOz/nCCQX7XhyzTAo7kNw3VhPjBWXH5vBWSxGd?=
 =?us-ascii?Q?oFg4HYuL/zTmwqjae3Cpp8E3lEfQiDJ+8/MmyetWxaBs5U/FN0W2JqvOLfIY?=
 =?us-ascii?Q?vsjyIneWliRHOJWrD0TPWrVk+153obKQPMthWDPxpJtxnuCx/OomgyVqIChb?=
 =?us-ascii?Q?grB4zOSWplnYxIHZ8gZ6ufuoGVKSx4ak7OzJtifNsWICtRH7/zWoTQ69H43T?=
 =?us-ascii?Q?q1uwVFtAwCPmDoJTjor6DBWnquT/jEDcMP8z66nK5R4h3YwzkfsmHHTGSUJw?=
 =?us-ascii?Q?zvTlWznFh1cocxl18Mmh+cE5UI85cQIHH3QZwsKeDxOjoQFoH55NupUBYnnH?=
 =?us-ascii?Q?GT0OssS3hrmskCkNzc357zB6ph2NJMNtnAfNz+89aIQe2vXovtHC9FyjxE0G?=
 =?us-ascii?Q?NluMUgGkDo17XtonaBAb66gipgFbDq2UTN8eZb7zwThi7L+/aI59PelU9QPV?=
 =?us-ascii?Q?IdB4LY8G5FEBTaNsoKgkEZwkUXouc9u2mYpk7w5lWyHRMBiiaTs1jvqAUfdl?=
 =?us-ascii?Q?JhqTc80JM6zZ+pvrsL3Zozy4sggnGCKi5tF6tG0TAIMOaTJU87lQ17KrKjgE?=
 =?us-ascii?Q?MTnE/U4Hlgdk/P1JVRvwOlRL7KJ+rJWpfjkCVCG8XvhEVjmXchLgvHqoTER7?=
 =?us-ascii?Q?yHCVSX2NN0boFpxoJAQ/toGKD4nQJGeIhQEK1Za8q3Rq/UcKK7JfqdlXRhLu?=
 =?us-ascii?Q?sD/tVmoR6IzOmQjhyoF+y+kgeyI6dIxcwLAt1dFjbpYikszrTT+bnEjKrGyO?=
 =?us-ascii?Q?9U1g/IIX5HIwP70h4W6pwDeZ+6pdV4kDS7owdelu/636E22jdifwpFyO2Ohg?=
 =?us-ascii?Q?S/lPgb15CU8qHwpKO49HG3vIDvJQeKPUe5xSTvV6501tXyTcm91RALfUbf6r?=
 =?us-ascii?Q?VPjjjBqXoVf4ItRWgiMcnRy/vvDD+RJrC/FOuEbfIrYt8lOsgjJRWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EnOF0VlSK6bnwDtcMoAgi7UQKr23K/z/RKgbr4ZSEccNE+JWE+cvDg4ByXnH?=
 =?us-ascii?Q?Um6rLmP+uVw1+D8rsSFeuDNe2VkdytDgAA905v0VlHiwStUBmzIaniidNZwF?=
 =?us-ascii?Q?cRJY/TbxlwBwvzaEY+FAD/hVtG07HXPyA0iQjsOLcLLmLXgVV3Gv5yJE62pw?=
 =?us-ascii?Q?zIFGLnPmIgdOxnvtlitFW9VFuEIzwGiLu/mB33ifs1qGveabkU62cv+0FGuM?=
 =?us-ascii?Q?0c5Yh9OYw4W5eGWkfh/AC7pRz6SPYeaI9Z3i+XpkAHT7AxOVM0LxR48dew5Z?=
 =?us-ascii?Q?9TiK3bjCxEvTvWM7W1IM8krBsoWRUPz4kZ9bmTP5lLdccrcGZ5+ZTiSZKGpd?=
 =?us-ascii?Q?+gBKzSkejWWtZITpID1IvORsDGR7QL3mdJR1qiooGoyKc5l6vAw8BZkv7Ag4?=
 =?us-ascii?Q?2Tq6CcSkGyrEDEMvMma7MxSQaBP6v39uKV6q5eenL9gqLrmIkGkY4FWkC2Iz?=
 =?us-ascii?Q?mghKoOy3khNYHMMTJlLk0C5hve0q5lzHN0e9CJfbMWqEJes6Y1uZ2x1pMs3p?=
 =?us-ascii?Q?2V3kY5pBGPYmHckeT96MTGCgjybuXp3qERhj6yGWSMSjvJXBsUSkIlLWoF8c?=
 =?us-ascii?Q?Azk17Y8LeIRZY+cSALeseG001k0r6HGdTvTwJgjVJub72pCleBdGxvZy5ZBZ?=
 =?us-ascii?Q?o4+OKk72gKETEaXZV5dHxU/zB2MMTIHm4ARK5pp1xv7ij6NaAxowGxI3hxUE?=
 =?us-ascii?Q?K5bZM86BJpqoUZEHQ8Gbtd0g2UAKpy/RcGr34U4NfafZbuFAK95NO4rprCIF?=
 =?us-ascii?Q?EoyzjCfdSGw/X8asRC0SZ7AMS0sSuSuqaWwMiwkUe+Vapr1/OokacG3lc+A1?=
 =?us-ascii?Q?4DYtYbMMExus4AVbL8677RdV0sNZ2FNUkCo4tdPuQ1ZsFu3fEBvqXq66T0gb?=
 =?us-ascii?Q?brK5C57BunbYwhUv0h4xn3Hhqxru0eVGY8rIpN75EsPEoSJZ7PxTf6mHE1RY?=
 =?us-ascii?Q?x7xPLkDbqGAPIA/o4+o92z2FyQP6OslbDHCdAUJckfJTh/kfLA6gnjoCDtd1?=
 =?us-ascii?Q?EvZmQyUbZPtQs1HXSWePBseyg94vWXXrMIVhOqBxvw3crMx9wpo7cwAxnHLU?=
 =?us-ascii?Q?Bv0JkwIMiCDvYqK72y2OO/TZH2Lpt6sboHD8jzeHTBFwInscq2Qvf/9M2+fX?=
 =?us-ascii?Q?FE2kJHKVjQtk4gjFz2GAEQjUSpdIfEw+vPoA8LsNSbXP7fjyAIno4bF1hFoX?=
 =?us-ascii?Q?lFEC/508aknM2j+VFo7yhKuUykjnd4tme7eMHAwLIJIPCrPenBseDFCb7YEj?=
 =?us-ascii?Q?DmMRDilhU1N3fODtTfbwF20xjad4Y6fVXYQg7FN8p2Y7vnSJz88AiQUnOIxI?=
 =?us-ascii?Q?vjyQNfkkndyg9gOkjX/XMxpCWV6n+TeQ8UzvdvDFZ4LaL4DKlHFdlImObIhL?=
 =?us-ascii?Q?Q4sFxPZrf68UKOjPqp0CqDssNw0oyIJaMLSr8C4eywIWTCNQIHjUuoac6lWC?=
 =?us-ascii?Q?ww/8DeMpjkZqkv24x/bRhN6hl1TH3MbjQ0O+AOG9AAHUwRM35Ngrtx2Z5hFe?=
 =?us-ascii?Q?qR48r/yavK2OAqp26s6FxieeuR7BslvesbeFp6/D3XBgO86flcM+9E/UQh31?=
 =?us-ascii?Q?IMGxi/hcQaGpWgJH+OGs9onpqzMOzK+HGWN6fpI4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d7037-5a27-44d7-0686-08dd8bdfc027
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:47.8184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQPV2so8LzWtiTzwB15O41E9XhvgMJJHH/HRrZCpJLGxuS3mOKHoR0WcsXe7qZPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
and it can decode the full 64 bit VA space. Unlike other x86 page tables
this explicitly does not do sign extension as part of allowing the entire
64 bit VA space to be supported.

The general design is quite similar to the x86 PAE format, except with a
6th level and quite different PTE encoding.

This format is the only one that uses the PT_FEAT_DYNAMIC_TOP feature in
the existing code as the existing AMDv1 code starts out with a 3 level
table and adds levels on the fly if more IOVA is needed.

Comparing the performance of several operations to the existing version:

iommu_map()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     65,64    ,      62,61      ,  -1.01
     2^13,     70,66    ,      67,62      ,  -8.08
     2^14,     73,69    ,      71,65      ,  -9.09
     2^15,     78,75    ,      75,71      ,  -5.05
     2^16,     89,89    ,      86,84      ,  -2.02
     2^17,    128,121   ,     124,112     , -10.10
     2^18,    175,175   ,     170,163     ,  -4.04
     2^19,    264,306   ,     261,279     ,   6.06
     2^20,    444,525   ,     438,489     ,  10.10
     2^21,     60,62    ,      58,59      ,   1.01
 256*2^12,    381,1833  ,     367,1795    ,  79.79
 256*2^21,    375,1623  ,     356,1555    ,  77.77
 256*2^30,    356,1338  ,     349,1277    ,  72.72

iommu_unmap()
   pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
     2^12,     76,89    ,      71,86      ,  17.17
     2^13,     79,89    ,      75,86      ,  12.12
     2^14,     78,90    ,      74,86      ,  13.13
     2^15,     82,89    ,      74,86      ,  13.13
     2^16,     79,89    ,      74,86      ,  13.13
     2^17,     81,89    ,      77,87      ,  11.11
     2^18,     90,92    ,      87,89      ,   2.02
     2^19,     91,93    ,      88,90      ,   2.02
     2^20,     96,95    ,      91,92      ,   1.01
     2^21,     72,88    ,      68,85      ,  20.20
 256*2^12,    372,6583  ,     364,6251    ,  94.94
 256*2^21,    398,6032  ,     392,5758    ,  93.93
 256*2^30,    396,5665  ,     389,5258    ,  92.92

The ~5-17x speedup when working with mutli-PTE map/unmaps is because the
AMD implementation rewalks the entire table on every new PTE while this
version retains its position. The same speedup will be seen with dirtys as
well.

The old implementation triggers a compiler optimization that ends up
generating a "rep stos" memset for contiguous PTEs. Since AMD can have
contiguous PTEs that span 2Kbytes of table this is a huge win compared to
a normal movq loop. It is why the unmap side has a fairly flat runtime as
the contiguous PTE sides increases. This version makes it explicit with a
memset64() call.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/Makefile                     |   1 +
 drivers/iommu/generic_pt/Kconfig           |  13 +
 drivers/iommu/generic_pt/fmt/Makefile      |  11 +
 drivers/iommu/generic_pt/fmt/amdv1.h       | 383 +++++++++++++++++++++
 drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
 drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
 include/linux/generic_pt/common.h          |  19 +
 include/linux/generic_pt/iommu.h           |  29 ++
 8 files changed, 492 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
 create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index fe91d770abe16c..da5ff67134e6e5 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += amd/ intel/ arm/ iommufd/ riscv/
+obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
index 73b7a54375f9bd..887c585a66699a 100644
--- a/drivers/iommu/generic_pt/Kconfig
+++ b/drivers/iommu/generic_pt/Kconfig
@@ -32,4 +32,17 @@ config IOMMU_PT
 	  IOMMU_PT provides an implementation of the page table operations
 	  related struct iommu_domain using GENERIC_PT to abstract the page
 	  table format.
+
+if IOMMU_PT
+config IOMMU_PT_AMDV1
+	tristate "IOMMU page table for 64 bit AMD IOMMU v1"
+	depends on !GENERIC_ATOMIC64 # for cmpxchg64
+	default n
+	help
+	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
+	  "host" page table. It supports granular page sizes of almost every
+	  power of 2 and decodes an full 64 bit IOVA space.
+
+	  Selected automatically by an IOMMU driver that uses this format.
+endif
 endif
diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
new file mode 100644
index 00000000000000..a4d83b7e0cf691
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+
+define create_format
+obj-$(2) += iommu_$(1).o
+
+endef
+
+$(eval $(foreach fmt,$(iommu_pt_fmt-y),$(call create_format,$(fmt),y)))
+$(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
new file mode 100644
index 00000000000000..0f445ab59c8495
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -0,0 +1,383 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ * AMD IOMMU v1 page table
+ *
+ * This is described in Section "2.2.3 I/O Page Tables for Host Translations"
+ * of the "AMD I/O Virtualization Technology (IOMMU) Specification"
+ *
+ * Note the level numbering here matches the core code, so level 0 is the same
+ * as mode 1.
+ *
+ */
+#ifndef __GENERIC_PT_FMT_AMDV1_H
+#define __GENERIC_PT_FMT_AMDV1_H
+
+#include "defs_amdv1.h"
+#include "../pt_defs.h"
+
+#include <asm/page.h>
+#include <linux/bitfield.h>
+#include <linux/container_of.h>
+#include <linux/mem_encrypt.h>
+#include <linux/minmax.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+enum {
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_ENTRY_WORD_SIZE = sizeof(u64),
+	PT_MAX_TOP_LEVEL = 5,
+	PT_GRANULE_LG2SZ = 12,
+	PT_TABLEMEM_LG2SZ = 12,
+};
+
+/* PTE bits */
+enum {
+	AMDV1PT_FMT_PR = BIT(0),
+	AMDV1PT_FMT_D = BIT(6),
+	AMDV1PT_FMT_NEXT_LEVEL = GENMASK_ULL(11, 9),
+	AMDV1PT_FMT_OA = GENMASK_ULL(51, 12),
+	AMDV1PT_FMT_FC = BIT_ULL(60),
+	AMDV1PT_FMT_IR = BIT_ULL(61),
+	AMDV1PT_FMT_IW = BIT_ULL(62),
+};
+
+/*
+ * gcc 13 has a bug where it thinks the output of FIELD_GET() is an enum, make
+ * these defines to avoid it.
+ */
+#define AMDV1PT_FMT_NL_DEFAULT 0
+#define AMDV1PT_FMT_NL_SIZE 7
+
+#define common_to_amdv1pt(common_ptr) \
+	container_of_const(common_ptr, struct pt_amdv1, common)
+#define to_amdv1pt(pts) common_to_amdv1pt((pts)->range->common)
+
+static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
+{
+	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),
+			  PT_GRANULE_LG2SZ);
+}
+#define pt_table_pa amdv1pt_table_pa
+
+/* Returns the oa for the start of the contiguous entry */
+static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+{
+	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_SIZE) {
+		unsigned int sz_bits = oalog2_ffz(oa);
+
+		oa = oalog2_set_mod(oa, 0, sz_bits);
+	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+			      AMDV1PT_FMT_NL_DEFAULT))
+		return 0;
+	return oalog2_mul(oa, PT_GRANULE_LG2SZ);
+}
+#define pt_entry_oa amdv1pt_entry_oa
+
+static inline bool amdv1pt_can_have_leaf(const struct pt_state *pts)
+{
+	/*
+	 * Table 15: Page Table Level Parameters
+	 * The top most level cannot have translation entries
+	 */
+	return pts->level < PT_MAX_TOP_LEVEL;
+}
+#define pt_can_have_leaf amdv1pt_can_have_leaf
+
+static inline unsigned int amdv1pt_table_item_lg2sz(const struct pt_state *pts)
+{
+	return PT_GRANULE_LG2SZ +
+	       (PT_TABLEMEM_LG2SZ - ilog2(PT_ENTRY_WORD_SIZE)) * pts->level;
+}
+#define pt_table_item_lg2sz amdv1pt_table_item_lg2sz
+
+static inline unsigned int
+amdv1pt_entry_num_contig_lg2(const struct pt_state *pts)
+{
+	u32 code;
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
+	    AMDV1PT_FMT_NL_DEFAULT)
+		return ilog2(1);
+
+	PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+		   AMDV1PT_FMT_NL_SIZE);
+
+	/*
+	 * The contiguous size is encoded in the length of a string of 1's in
+	 * the low bits of the OA. Reverse the equation:
+	 *  code = log2_to_int(num_contig_lg2 + item_lg2sz -
+	 *              PT_GRANULE_LG2SZ - 1) - 1
+	 * Which can be expressed as:
+	 *  num_contig_lg2 = oalog2_ffz(code) + 1 -
+	 *              item_lg2sz - PT_GRANULE_LG2SZ
+	 *
+	 * Assume the bit layout is correct and remove the masking. Reorganize
+	 * the equation to move all the arithmetic before the ffz.
+	 */
+	code = pts->entry >> (__bf_shf(AMDV1PT_FMT_OA) - 1 +
+			      pt_table_item_lg2sz(pts) - PT_GRANULE_LG2SZ);
+	return log2_ffz_t(u32, code);
+}
+#define pt_entry_num_contig_lg2 amdv1pt_entry_num_contig_lg2
+
+static inline unsigned int amdv1pt_num_items_lg2(const struct pt_state *pts)
+{
+	/*
+	 * Top entry covers bits [63:57] only, this is handled through
+	 * max_vasz_lg2.
+	 */
+	if (PT_WARN_ON(pts->level == 5))
+		return 7;
+	return PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64));
+}
+#define pt_num_items_lg2 amdv1pt_num_items_lg2
+
+static inline pt_vaddr_t amdv1pt_possible_sizes(const struct pt_state *pts)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+
+	if (!amdv1pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * Table 14: Example Page Size Encodings
+	 * Address bits 51:32 can be used to encode page sizes greater that 4
+	 * Gbytes. Address bits 63:52 are zero-extended.
+	 *
+	 * 512GB Pages are not supported due to a hardware bug.
+	 * Otherwise every power of two size is supported.
+	 */
+	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
+			   isz_lg2) & ~SZ_512G;
+}
+#define pt_possible_sizes amdv1pt_possible_sizes
+
+static inline enum pt_entry_type amdv1pt_load_entry_raw(struct pt_state *pts)
+{
+	const u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	unsigned int next_level;
+	u64 entry;
+
+	pts->entry = entry = READ_ONCE(*tablep);
+	if (!(entry & AMDV1PT_FMT_PR))
+		return PT_ENTRY_EMPTY;
+
+	next_level = FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry);
+	if (pts->level == 0 || next_level == AMDV1PT_FMT_NL_DEFAULT ||
+	    next_level == AMDV1PT_FMT_NL_SIZE)
+		return PT_ENTRY_OA;
+	return PT_ENTRY_TABLE;
+}
+#define pt_load_entry_raw amdv1pt_load_entry_raw
+
+static inline void
+amdv1pt_install_leaf_entry(struct pt_state *pts, pt_oaddr_t oa,
+			   unsigned int oasz_lg2,
+			   const struct pt_write_attrs *attrs)
+{
+	unsigned int isz_lg2 = pt_table_item_lg2sz(pts);
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 entry;
+
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_OA, log2_div(oa, PT_GRANULE_LG2SZ)) |
+		attrs->descriptor_bits;
+
+	if (oasz_lg2 == isz_lg2) {
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_DEFAULT);
+		WRITE_ONCE(*tablep, entry);
+	} else {
+		unsigned int num_contig_lg2 = oasz_lg2 - isz_lg2;
+		u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+		entry |= FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL,
+				    AMDV1PT_FMT_NL_SIZE) |
+			 FIELD_PREP(AMDV1PT_FMT_OA,
+				    oalog2_to_int(oasz_lg2 - PT_GRANULE_LG2SZ -
+						  1) -
+					    1);
+
+		/* See amdv1pt_clear_entry() */
+		if (num_contig_lg2 <= ilog2(32)) {
+			for (; tablep != end; tablep++)
+				WRITE_ONCE(*tablep, entry);
+		} else {
+			memset64(tablep, entry, log2_to_int(num_contig_lg2));
+		}
+	}
+	pts->entry = entry;
+}
+#define pt_install_leaf_entry amdv1pt_install_leaf_entry
+
+static inline bool amdv1pt_install_table(struct pt_state *pts,
+					 pt_oaddr_t table_pa,
+					 const struct pt_write_attrs *attrs)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 entry;
+
+	/*
+	 * IR and IW are ANDed from the table levels along with the PTE. We
+	 * always control permissions from the PTE, so always set IR and IW for
+	 * tables.
+	 */
+	entry = AMDV1PT_FMT_PR |
+		FIELD_PREP(AMDV1PT_FMT_NEXT_LEVEL, pts->level) |
+		FIELD_PREP(AMDV1PT_FMT_OA,
+			   log2_div(table_pa, PT_GRANULE_LG2SZ)) |
+		AMDV1PT_FMT_IR | AMDV1PT_FMT_IW;
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_set(entry);
+	return pt_table_install64(tablep, entry, pts->entry);
+}
+#define pt_install_table amdv1pt_install_table
+
+static inline void amdv1pt_attr_from_entry(const struct pt_state *pts,
+					   struct pt_write_attrs *attrs)
+{
+	attrs->descriptor_bits =
+		pts->entry & (AMDV1PT_FMT_FC | AMDV1PT_FMT_IR | AMDV1PT_FMT_IW);
+}
+#define pt_attr_from_entry amdv1pt_attr_from_entry
+
+static inline void amdv1pt_clear_entry(struct pt_state *pts,
+				       unsigned int num_contig_lg2)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	/*
+	 * gcc generates rep stos for the io-pgtable code, and this difference
+	 * can show in microbenchmarks with larger contiguous page sizes.
+	 * rep is slower for small cases.
+	 */
+	if (num_contig_lg2 <= ilog2(32)) {
+		for (; tablep != end; tablep++)
+			WRITE_ONCE(*tablep, 0);
+	} else {
+		memset64(tablep, 0, log2_to_int(num_contig_lg2));
+	}
+}
+#define pt_clear_entry amdv1pt_clear_entry
+
+static inline bool amdv1pt_entry_write_is_dirty(const struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		if (READ_ONCE(*tablep) & AMDV1PT_FMT_D)
+			return true;
+	return false;
+}
+#define pt_entry_write_is_dirty amdv1pt_entry_write_is_dirty
+
+static inline void amdv1pt_entry_set_write_clean(struct pt_state *pts)
+{
+	unsigned int num_contig_lg2 = amdv1pt_entry_num_contig_lg2(pts);
+	u64 *tablep = pt_cur_table(pts, u64) +
+		      log2_set_mod(pts->index, 0, num_contig_lg2);
+	u64 *end = tablep + log2_to_int(num_contig_lg2);
+
+	for (; tablep != end; tablep++)
+		WRITE_ONCE(*tablep, READ_ONCE(*tablep) & ~(u64)AMDV1PT_FMT_D);
+}
+#define pt_entry_set_write_clean amdv1pt_entry_set_write_clean
+
+static inline bool amdv1pt_entry_make_write_dirty(struct pt_state *pts)
+{
+	u64 *tablep = pt_cur_table(pts, u64) + pts->index;
+	u64 new = pts->entry | AMDV1PT_FMT_D;
+
+	return try_cmpxchg64(tablep, &pts->entry, new);
+}
+#define pt_entry_make_write_dirty amdv1pt_entry_make_write_dirty
+
+/* --- iommu */
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+#define pt_iommu_table pt_iommu_amdv1
+
+/* The common struct is in the per-format common struct */
+static inline struct pt_common *common_from_iommu(struct pt_iommu *iommu_table)
+{
+	return &container_of(iommu_table, struct pt_iommu_amdv1, iommu)
+			->amdpt.common;
+}
+
+static inline struct pt_iommu *iommu_from_common(struct pt_common *common)
+{
+	return &container_of(common, struct pt_iommu_amdv1, amdpt.common)->iommu;
+}
+
+static inline int amdv1pt_iommu_set_prot(struct pt_common *common,
+					 struct pt_write_attrs *attrs,
+					 unsigned int iommu_prot)
+{
+	u64 pte = 0;
+
+	if (pt_feature(common, PT_FEAT_AMDV1_FORCE_COHERENCE))
+		pte |= AMDV1PT_FMT_FC;
+	if (iommu_prot & IOMMU_READ)
+		pte |= AMDV1PT_FMT_IR;
+	if (iommu_prot & IOMMU_WRITE)
+		pte |= AMDV1PT_FMT_IW;
+
+	/*
+	 * Ideally we'd have an IOMMU_ENCRYPTED flag set by higher levels to
+	 * control this. For now if the tables use sme_set then so do the ptes.
+	 */
+	if (pt_feature(common, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		pte = __sme_set(pte);
+
+	attrs->descriptor_bits = pte;
+	return 0;
+}
+#define pt_iommu_set_prot amdv1pt_iommu_set_prot
+
+static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
+					 const struct pt_iommu_amdv1_cfg *cfg)
+{
+	struct pt_amdv1 *table = &iommu_table->amdpt;
+	unsigned int max_vasz_lg2 = PT_MAX_VA_ADDRESS_LG2;
+
+	if (cfg->starting_level == 0 || cfg->starting_level > PT_MAX_TOP_LEVEL)
+		return -EINVAL;
+
+	if (!pt_feature(&table->common, PT_FEAT_DYNAMIC_TOP) &&
+	    cfg->starting_level != PT_MAX_TOP_LEVEL)
+		max_vasz_lg2 = PT_GRANULE_LG2SZ +
+			       (PT_TABLEMEM_LG2SZ - ilog2(sizeof(u64))) *
+				       (cfg->starting_level + 1);
+
+	table->common.max_vasz_lg2 =
+		min(max_vasz_lg2, cfg->common.hw_max_vasz_lg2);
+	table->common.max_oasz_lg2 =
+		min(PT_MAX_OUTPUT_ADDRESS_LG2, cfg->common.hw_max_oasz_lg2);
+	pt_top_set_level(&table->common, cfg->starting_level);
+	return 0;
+}
+#define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
+
+static inline void
+amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
+			  const struct pt_range *top_range,
+			  struct pt_iommu_amdv1_hw_info *info)
+{
+	info->host_pt_root = virt_to_phys(top_range->top_table);
+	PT_WARN_ON(log2_mod_t(phys_addr_t, info->host_pt_root, 12));
+	info->mode = top_range->top_level + 1;
+}
+#define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/defs_amdv1.h b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
new file mode 100644
index 00000000000000..0b9614ca6d103c
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/defs_amdv1.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ *
+ */
+#ifndef __GENERIC_PT_FMT_DEFS_AMDV1_H
+#define __GENERIC_PT_FMT_DEFS_AMDV1_H
+
+#include <linux/generic_pt/common.h>
+#include <linux/types.h>
+
+typedef u64 pt_vaddr_t;
+typedef u64 pt_oaddr_t;
+
+struct amdv1pt_write_attrs {
+	u64 descriptor_bits;
+	gfp_t gfp;
+};
+#define pt_write_attrs amdv1pt_write_attrs
+
+#endif
diff --git a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
new file mode 100644
index 00000000000000..72a2337d0c5510
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define PT_FMT amdv1
+#define PT_SUPPORTED_FEATURES                                          \
+	(BIT(PT_FEAT_FULL_VA) | BIT(PT_FEAT_DYNAMIC_TOP) |             \
+	 BIT(PT_FEAT_FLUSH_RANGE) | BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS) | \
+	 BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |                           \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+#define PT_FORCE_ENABLED_FEATURES                                       \
+	(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
+	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
index 91869fad33fbdf..b127d8915d48fc 100644
--- a/include/linux/generic_pt/common.h
+++ b/include/linux/generic_pt/common.h
@@ -131,4 +131,23 @@ enum pt_features {
 	PT_FEAT_FMT_START,
 };
 
+struct pt_amdv1 {
+	struct pt_common common;
+};
+
+enum {
+	/*
+	 * The memory backing the tables is encrypted. Use __sme_set() to adjust
+	 * the page table pointers in the tree. This only works with
+	 * CONFIG_AMD_MEM_ENCRYPT.
+	 */
+	PT_FEAT_AMDV1_ENCRYPT_TABLES = PT_FEAT_FMT_START,
+	/*
+	 * The PTEs are set to prevent cache incoherent traffic, such as PCI no
+	 * snoop. This is set either at creation time or before the first map
+	 * operation.
+	 */
+	PT_FEAT_AMDV1_FORCE_COHERENCE,
+};
+
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 636f856cc5fdcc..f454680027659d 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -109,4 +109,33 @@ struct pt_iommu_cfg {
 	u8 hw_max_oasz_lg2;
 };
 
+/* Generate the exported function signatures from iommu_pt.h */
+#define IOMMU_PROTOTYPES(fmt)                                             \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
+				  const struct pt_iommu_##fmt##_cfg *cfg, \
+				  gfp_t gfp);                             \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+				      struct pt_iommu_##fmt##_hw_info *info)
+#define IOMMU_FORMAT(fmt, member)       \
+	struct pt_iommu_##fmt {         \
+		struct pt_iommu iommu;  \
+		struct pt_##fmt member; \
+	};                              \
+	IOMMU_PROTOTYPES(fmt)
+
+
+struct pt_iommu_amdv1_cfg {
+	struct pt_iommu_cfg common;
+	unsigned int starting_level;
+};
+
+struct pt_iommu_amdv1_hw_info {
+	u64 host_pt_root;
+	u8 mode;
+};
+
+IOMMU_FORMAT(amdv1, amdpt);
+
+#undef IOMMU_PROTOTYPES
+#undef IOMMU_FORMAT
 #endif
-- 
2.43.0


