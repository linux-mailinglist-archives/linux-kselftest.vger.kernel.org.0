Return-Path: <linux-kselftest+bounces-32350-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27431AA9561
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26C97A7A79
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3825C819;
	Mon,  5 May 2025 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s3ByAJv3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313125A627;
	Mon,  5 May 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454740; cv=fail; b=fwSUKLvljwiGrBSTpweJLi/PbuzeHSy7N5Uabfl4XQE/8J28IpVlPJJoMRZIYVluDF3T/8Su0HXc3A0eGhdUTXUTFgoN53di0Si0htPTTn0+xOAVoZDk+0nVLn0IBp4Exche6kvTqtevG92tql27qu93u13IvMYkYVX+rH4bnUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454740; c=relaxed/simple;
	bh=E6z/aDL+mXtjuVFlx/h1q2MmzGNQnOzb9PfTgq/zPZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoBroRuoAZd9el+U47Z5m5gW8by2N7pkWV9ZSFa1p/nt4fUttbIWu5El8BZn9dEB9MVRpZUePf2qdN8DjTHKHFFF28B64rHL9yycQfiybWOy0YfFBX9iDvVBTm1MScBW7ndyZHIVr71bfM3Jl/VwNW7t+sR98TTA+fxzwJA6v3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s3ByAJv3; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3bA+S/dGxnsBbI6bFrn9I9alNVQtDnDzRhbCYgf/3YRoHf/0jXzMpSu/htODcnLLytcN2IJf8AwqUWbrEnNmX1uihpekmGUx5CpiN0Sg/JRSac0Qar35kFf4tGGT6UROKva0Y/v7Bzgpf+0AQNoCXeQeoJ/sBaekgP/pTXs3UJ1UAHuV3e78f1i3CTjAoDYpxSOXS2U336iAmImq0M9qZH7jIzdohma/ejFhIDa7HPoIRXRuv56g1SDl7gFqPqViouko1cPDb+wfvcTUtruB2U+86JFjSLgT5crNr6eAHLk30mVDUisS9N0nesCvHVkIkCEaW+iKSE+oLoXZGV/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXeNv6GCKxs9rcOIKBAoU8frnCJaNu9Nl6xpvuTBV6E=;
 b=ydaD+XClHsKWDWslQffchJWuFjXyhgJzDwfN/mOEVFMw2ytOyIvIhHNU0TkfT9Bce4kbThNlGoPMkdDNMxEnbZzBAma3HuqeSAcTLwEkg7GIWSLJwTdBkDnezAouf36CIbWp8LHyVQiOl578YxHlvSQJBrHapy2Jh8S8LWcARk04JPQD1gqp3zQAXoLH53smJPpDzQRtyOFrNQF+QkIYcQZRs4iBV2JQd/tKVy04djlay/FqSzpZ4g9gNF3ribpUTRxrKDJvxGHKDUH8DvRRlmg1TxAcKfmEIXrixU4qkdKtNXX+ByeasIWAKQD5BHtGfAOLCuKJtxlfiD8hwlXPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXeNv6GCKxs9rcOIKBAoU8frnCJaNu9Nl6xpvuTBV6E=;
 b=s3ByAJv3e+XUblIa5jp4r+Du4MrIPD8u6EhnsPfThy4XcNOfE+0mbQA9v7CRsDf2UINcVSTA0zMBuGPXy0GBnc4HhPCQNh7Clghl1tZdMFYnkd7wxoUcGuv0jx7VmlQMJrdt9zMI92gp9QwKFEEOqvLI4ruBSAFb56YrvTI9cnvI4LVRLXc5bGEGuSZk4YMf0abN9IAp3eZ9qyFGHO51LOwEHSCDXzkP3YsL+ubfWbPjGD9MILqAWtXbt/rCucQHCzbW+9NB7n3BNRsSwm+WbkKsVSMB6y7lKMmsn0RtevnkuWcI7MAv0riNyv6bCd4HpL6wBlzP0c8S9bvvwK614Q==
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
Subject: [PATCH v2 02/15] genpt: Add Documentation/ files
Date: Mon,  5 May 2025 11:18:32 -0300
Message-ID: <2-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0471.namprd03.prod.outlook.com
 (2603:10b6:408:139::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 31685daa-e6fe-4a0c-e076-08dd8bdfc01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwwbimFIjoPDGAMd6jMgbQ/aG/s3UHihwnLxbGgl4Dl0lAe1znSQRoLOwrXL?=
 =?us-ascii?Q?q9iu8U2OWBVcckaNO0iJHNR5/EWIwQzBrbmn9OqG0BQF9sJGs68G+GcsMmeU?=
 =?us-ascii?Q?f8EV+TQGaaL4EsrUNVM+g4CkO5sfsrJ6Pz+szt81vadKLx12zK3MVe3iwiyL?=
 =?us-ascii?Q?rZy5HCXkU54F7jVpvw4tl7rq1JEo2Rq5DZekK0Awjp8yxJNYVTmd12M+1hp2?=
 =?us-ascii?Q?TfzdqQMvc5nBdJ9Lfm5E2lJfKoty5bFSuKEeRtlKWknJviDHfRDlbnkCLLxK?=
 =?us-ascii?Q?n/TJsZVMt8kHROm+/bgNUzUuDdhboz5InAsk/H+2nCcVbFxEu2HZvY8O1UzZ?=
 =?us-ascii?Q?VeQsABfsNrqQTdq4llXVINcphuUK6Xf3UwF8i/nCxsScecqWNnYLjvU0S8Ey?=
 =?us-ascii?Q?hP1Vz2WaNfC3Qhlt/4P/elxhhoIse0dyV1gu3VrLdtaqO0BTJ8O17NGzmg3V?=
 =?us-ascii?Q?HEfBCGSRDkkdTVQwGqpGkreZEIiQsm6wZdVWX+H5n4XJTo0W5q3U/fPdMZ+V?=
 =?us-ascii?Q?l9Q9/8ZSBZvSoYyMo+O7gjcamhHXh0EnSmqZ9tES9njo9PozaH4VOm2sCong?=
 =?us-ascii?Q?gifxFqhKKQhhPZfa1e3G5Ul4kv+S7u8lvgSv+tk97yOh3LsUPgkp5D2yge2t?=
 =?us-ascii?Q?lOcFpbbTN2hB7/h2/paGLNFH9jsb2oKqwPC9mWUUzEsB6RLxCaTr6CBG53mo?=
 =?us-ascii?Q?GeHANOPtikY9T92UnahGAnFEGVXE34gc6lsT/YKT/ignqyuALYZR8o2a+wtQ?=
 =?us-ascii?Q?wDnx8R3RXpAJX3eb1l9fL668DmrgB1Pd20Gj8biPYGL7ZW9mdCMI4PAGOFR5?=
 =?us-ascii?Q?luzVcAKGtLNMiCC2BayZ0eQ2y9e+gqbxERHU3leLKbvr8DX9kbYZ2k+P9DYY?=
 =?us-ascii?Q?dEcC99sIrOSeE6f9wsNCxmb8d34WtHR14k+bTyl0Ee09ciCRACHDCPx6jYl+?=
 =?us-ascii?Q?YlzT7ouAXjPAUlGwZzXKfpK9oFQW2IoYuZ1TOtMToPlmfeW8efueeZENfgPR?=
 =?us-ascii?Q?6uGlCTQMG74tZqSI3FBXbGuSEujjrdBfUKHH9CF0X2T7LwiuXtqIxThlb/fx?=
 =?us-ascii?Q?3aN0KR4Op/Op2S8pCxOv71iucJJZTefPCphOt6bHu4UFS5N/EFlnTjcl2uxn?=
 =?us-ascii?Q?mzIPHB3tcFKFXuRX8sYVvBKR/5bcrtS/9gPL88Lf42S50+d6TTIN1UddNoVU?=
 =?us-ascii?Q?4HkxqbWQynbc3sTxq5+w5RS2Lvsa00djq/c6bQTV6IgZyFPush59B5uVlj41?=
 =?us-ascii?Q?iRA6pMAMIKfwIZ+kkCVYOBmC939i9lP6vVSq0UHcyA2WgZwRaRjyUpXsRp6K?=
 =?us-ascii?Q?J+PXSV5VrC+8mUi3423yLQqhHuHaxgb1PRBAKQrBUH2g960dYOb2x58ESQZt?=
 =?us-ascii?Q?+Zx4Opj69R9GJS/aUhyNEnUDcOcPVUjoh19ton2Wz+uV26GZ+sjLoMI1Qq/j?=
 =?us-ascii?Q?pX3Yslx3Bh/OBARqsS7Hxg/gJvofZmUJGiK3ZK4QRYI8r3mKkKuPUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?umiVw2R3bYnR5iakZdNVngfiPQm0valh6kaqTAVGvSOzn004Z8jyKXwnatp3?=
 =?us-ascii?Q?62SLHYHvRFifipEmZzoD1u8NNIRi3m0NFpnpuC8L94AhqEQXg2FmgmiDhxh+?=
 =?us-ascii?Q?QI1Uj9fd+upnFD5W3WNFWt5y2fnGmVHYIRHUdvtTw9sfeIublJvIHgnZiyss?=
 =?us-ascii?Q?R0wq6XEzVSW2MAczd/5tHkfsKdHgaTdAz6UjcxhtfynX3FuicqYng9PN427D?=
 =?us-ascii?Q?4WOZ7XW2zDx3T15sZoM8DhFvuKLvXnj8QY8d09/4Z/GLO38JkY9skQWr1G0z?=
 =?us-ascii?Q?OEhgHSb+qNamU3AOk//FmSTs70E+D1ssANXXPGBpeWzA7V179y6XBdPL3Vx8?=
 =?us-ascii?Q?VGSpln4Fr6nEpEXxNG33ItzQrAl1GVFqUBVFsiIcOPK/xfDXxK1iFSUT7fnE?=
 =?us-ascii?Q?P4Yh8qaR+5S9y426CmF93VvGpfXa55GlFpSKt10g54sfoSC6FhR5ZaV3x1gP?=
 =?us-ascii?Q?Lfc/B6MgUqhe838Q8fdoE6hs4pMhBFXMvRq9hv6Y3duKtCsQUFPEdGFEy36Y?=
 =?us-ascii?Q?OuR2PC9YzPpeymC1KkRQ6i9kE05mNs1WFt/XIQI+LaHYhkYunQbE9s5ZChjF?=
 =?us-ascii?Q?DquIvHPFoFWZUPOqfTYowMy+aE1HIWFHszj7bBDrx9GOoQqj5a3eHjn4I4z9?=
 =?us-ascii?Q?hqFJZar9Disl40f3o2OUw72TqHCtfZ7ur40gAqAA9BX+XlcrDflshfPfabLp?=
 =?us-ascii?Q?vpxtwat3ATwx3Fb7Jw7oujWf8T9+AxCKfyRcOBFqS18rx479Z0OFbhNihNdQ?=
 =?us-ascii?Q?jTedVnrwvay8ooUaHMeHuPTNUl9I0oiI8fBpsyBoWYtpvUl8Y+3iceVUyJxW?=
 =?us-ascii?Q?Jc+a30GRLVS1VSOsY/adW3KFyUSPigsdgNJMVwQRGLCLAez3BKOZiAxF+oZm?=
 =?us-ascii?Q?UGv5thERf3GjrTMshEsycyKURMHvtWQFeQ4mqifMS3CcYoXsg/u6eDwDWEqF?=
 =?us-ascii?Q?k9x8ynN/IZp+Q2W3wkFJhjGbWwS7/THZp7GKCQ90x/3gGM/xb8lMtoFS1LAx?=
 =?us-ascii?Q?nX5w10FOnsGhZ704E7EHQBP4RGwWuGGvfAjIQticI9TsLYnidjTuLbnytmIj?=
 =?us-ascii?Q?bucUXASO7y3Wly+N7IOUXdPSQRpY9//Pca7LjRtv4oEGVOWGAxP6cJkAZStt?=
 =?us-ascii?Q?pQ1FCMy5Fvc1jpcVUTT1QBTqJeQX6fNwjg5tGH055mq+S6f2RczbMEsOIdwf?=
 =?us-ascii?Q?IIJJPk24nFNghO66xVexKinX/rWbVsKe+zQ9D9tFu7pgeu2gT8FIi0frsBzZ?=
 =?us-ascii?Q?AWg5b4QnbTf9+dMHc/6v4/n3IIYI13uSPGNx7Hvwe6xRmZJ5N1QELnoZz42U?=
 =?us-ascii?Q?7T72dIMZxtDZWZnASS1PGSDu7dn5auIR1Sc47QJ1oRa97LC6q13AN5iqCviq?=
 =?us-ascii?Q?0wf+j1MHBexJPFI/do9CHsN1/PEgBiY6KhETdjiVUDErnDusH3yfIgB00lYg?=
 =?us-ascii?Q?gAfTx9pIxbE+nWLVUJrA34q3eVclQYxjCGgR/bvt/bGv4VDeDCNH9nwxzr1K?=
 =?us-ascii?Q?DijaNWYQyzloQ+w/ZUYiam+dH804n0WzkUyMePOhW612q+VTTc8v61liogc7?=
 =?us-ascii?Q?N8Y7AWrLfx9o0uImSiUrb/Dfrdq+8eLo7b0/MEPG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31685daa-e6fe-4a0c-e076-08dd8bdfc01e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:47.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01L1knhMB/+py0mytobW+o97NWiz+fWkPAJKKSh0WDDOVMeR03ye7jWFXTLGNDg9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 105 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..4fb506a95be40d
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,105 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Generic Radix Page Table
+========================
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:doc: Generic Radix Page Table
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
+	:doc: Generic Page Table Language
+
+-----
+Usage
+-----
+
+Generic PT is structured as a multi-compilation system. Since each format
+provides an API using a common set of names there can be only one format active
+within a compilation unit. This design avoids function pointers around the low
+level API.
+
+Instead the function pointers can end up at the higher level API (ie map/unmap,
+etc) and the per-format code can be directly inlined.
+
+Since each compilation unit can only access one underlying format at a time,
+code that is intended to be generic across multiple formats has to compile
+itself multiple times.
+
+In an implementation compilation unit the headers would normally be included as
+follows::
+
+	#include <linux/generic_pt/common.h>
+	#include "fmt/defs_amdv1.h"
+	#include "pt_defs.h"
+	#include "fmt/amdv1.h"
+	#include "pt_common.h"
+	#include "pt_iter.h"
+
+Which will build up all the definitions to operate an AMDv1 page table type.
+
+Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
+iommu implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+The format uses struct pt_common as the top level struct for the table,
+and each format will have its own struct pt_xxx which embeds it to store
+format-specific information.
+
+The implementation will further wrapper this in its own top level struct, such
+as struct pt_iommu_amdv1.
+
+----------------------------------------------
+Format functions at the struct pt_common level
+----------------------------------------------
+
+.. kernel-doc:: include/linux/generic_pt/common.h
+	:identifiers:
+.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
+
+-----------------
+Iteration Helpers
+-----------------
+
+.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
+
+----------------
+Writing a Format
+----------------
+
+It is best to start from a simple format that is similar to the target. x86_64
+is usually a good reference for something simple, and AMDv1 is something fairly
+complete.
+
+The required inline functions need to be implemented in the format header.
+These should all follow the standard pattern of::
+
+ static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
+ {
+	[..]
+ }
+ #define pt_entry_oa amdv1pt_entry_oa
+
+Where a uniquely named per-format inline function provides the implementation
+and a define maps it to the generic name. This is intended to make debug symbols
+work better. inline functions should always be used as the prototypes in
+pt_common.h will cause the compiler to validate the function signature to
+prevent errors.
+
+Review pt_fmt_defaults.h to understand some of the optional inlines.
+
+Once the format compiles then it should be run through the generic page table
+kunit test in kunit_generic_pt.h using kunit. For example::
+
+   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_test.*
+   [...]
+   [11:15:08] Testing complete. Ran 9 tests: passed: 9
+   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s building, 0.311s running
+
+The generic tests are intended to prove out the format functions and give
+clearer failures to speed finding the problems. Once those pass then the entire
+kunit suite should be run.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 16e2c4ec3c010b..7459f4068d32b0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -92,6 +92,7 @@ Subsystem-specific APIs
    frame-buffer
    aperture
    generic-counter
+   generic_pt
    gpio/index
    hsi
    hte/index
-- 
2.43.0


