Return-Path: <linux-kselftest+bounces-43936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EFDC02E36
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E94B3AF135
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2949C274B53;
	Thu, 23 Oct 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kk/jX5EZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAB272E7C;
	Thu, 23 Oct 2025 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243673; cv=fail; b=WobtwMypW0fsPetY6DqxmKeFSCGzwifO8lal9Kgbvx43I/ZZIeQXz4/480jDVB2CihdzY5qeTvw+xiQser1WL4sGWMcwlvMtpNnWv//kqQqMJmt7MhafNM2xQx+mbWBHe11aq5QzeioZ4ybjuLN//amr3R9st/P69nwGvYTME50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243673; c=relaxed/simple;
	bh=TgPBt14kDd+f7apDI1jOtceVXhtRJ2g/uUd5iddvOQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKVHSysMBuwZHM/dR3PYzRvGQ/LmsivUy5Hr/VZn78qDZOBOZ5HC1HIhF/yOxqAngLxUv1QrO0+3YBWKxftCz7n8nFG6uP4vigJTdwn/lhYhkUeCyZ3MimyEpyIwL+rEdos5HXcU2esYuomOnNQmdZ+S8P8usbx0H4nHRBE1Plo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kk/jX5EZ; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEg4dsdgYHEUwi0La/abv59AKT7gl8FyuujH4GJq3EeTD44T8YSt2FvUj96kyTrpURRf1V6cU9sqtOGvdvij+p92eEVMuCftedWoF1xvryiX8EcXuSTQguzDwwVCce+WP+jel11Uki6rjPhjVy7MM/fe36BsnPEe9UJabDyQxDqtQSdpgUj0Wsl9V0v0kZGD4ec2nQUQgb6IERnqAyeo1TR65ngseJO1LlLI7mIhEV047HydXf6VAt6ILAennifpxynFJWSR3p/zMUscd0zTtX1T6fRzsYFJ6Ghlk7nr7/p84Dn/E3DhpzLAVG7OAnL+YEPIzjocJG5G3uy5gwoo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiYWWSGwTlxVPlU8arGnl1NUvE67MQbst4H7BRkfHqc=;
 b=XyxozbLI5wNWcJir4tkINqWWUPS/PsnfGxDfhhkpc9jpjHF3b9/wd31/Nd+mxVQkQBpaSyoo20VT6cpZEdgHHtnRsQOpIGVPbkJZiZfkhHQFD6MrVBgyh6DyTDUUhSFYP2BnRBOWFfVXHTwa6c6Z5CvLjTUQoJZxSGOC+AEJ1+2OUAeZzZjyXvOmYtDcmEzsiWdPjeLfLBNZ2lZUVmAXhOgCDBXj8HQZSxplCL/TyJWHsKpMVDHQbpF81Y3/z+WCRi/hoRVUupoiqVL6hN92vAfwj0wkKzcWZkH4SrWdvjMY7u/4Lr38ucNH9keDuMIcNbuajVC5xK9GqfouSo2o2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiYWWSGwTlxVPlU8arGnl1NUvE67MQbst4H7BRkfHqc=;
 b=Kk/jX5EZfTmAAl9/CER7M1TnqBNwolZSGdbMXUnoKBNi8kRwY+Oc131IaBFhpUxgrxMOgAA03QS/cmNHsV6+GcNLok9/fXxiTGG1nmqite5dMiiMTCOHWFe3pHSQQDMbdlqtkHP2aMNMY4mImKpXK508kt7HFOqdAM4YziZQS8qWKJTZyXZ1u65ltr3od7FAcoeu60Dx8+bSlBMxHRFKYWRuycBPEv5Z5RDUEZMGabhR70stTb1strCXjApZReZ+sfxxXLFIgEn4hmdSMSWZmPMG3Tei2eMrlvwsdy7ea2WwEMo8a5WFmdiVgJYrsleP6htt5rlk5llHscUT7EvZnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:21:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:01 +0000
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
Subject: [PATCH v7 02/15] genpt: Add Documentation/ files
Date: Thu, 23 Oct 2025 15:20:32 -0300
Message-ID: <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: b4c8ad25-bbcb-4711-3e3b-08de1260e6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXd8Glv293SQ3roB6s+wH5BfXSG1QVtTwlcZstBF1jRi/4s169lFCwsjiF/h?=
 =?us-ascii?Q?SoO5U3i/+Kp8Kq3fn5HZb7ZN9E1h0NDzZkFeQ1fLGlUe0w1xIy0vsl9mbqup?=
 =?us-ascii?Q?iym5oF3IOT3wCul9MlDHstNZFyepkZIPaBD9tGUjlYh2QsuEFWqtAUnt+kC6?=
 =?us-ascii?Q?Dr45K/pFCER83eXNy1FxmCXyao5f5+0bQkInlkjw5VtDwv/neYMfLuZ2bBq6?=
 =?us-ascii?Q?oVkuE2fYbZb1SIAneVUDnuLQHsEWd3CtBJS6iK7AYt1wKHn7ONSDLDtkkInm?=
 =?us-ascii?Q?mGlQKwClKbjZxOhPL51ot8fhvgQspeKJgdUU4llq3AvxnhvXoDGJTJu0V9Xb?=
 =?us-ascii?Q?yyu3zssm+qQbmmQnF9Syi1DMThZYEkM1eR+fcCAWYbJG868Ilqr7LjwpIL8Q?=
 =?us-ascii?Q?P0KY0O7QPDg4KHku6dJNtIsHaARaXa7Opkxmojfk6J9U7bHNpK+If4EXS1Zw?=
 =?us-ascii?Q?zi6CEgmLK8PWaJKXstg8x7o5D8df6ZyH1KfknFfsK0GY8BsQqWuHrSTzDfkx?=
 =?us-ascii?Q?PW/e58djrKWPE2EAZ/0oqf28TRP6Hn1vL/4KeGtbGXzx1b6yuGonb4Ye5uDj?=
 =?us-ascii?Q?lpmpecsjvR27LrTic9Bf+fbzXnd1ZSYlVTXMu0bTRyGPrpyGxX7SDjV5B50S?=
 =?us-ascii?Q?/tDuQrDeRBQgdV0i6axoSUO99iSMAvn2KJoh4tP3NnweWBQfJq6JqbcauN0M?=
 =?us-ascii?Q?nz0OLCkudWyPrNvWElcxQru3de4c1+aDKmeiSpcRLgVOnp9xd2L7fN0+tEQK?=
 =?us-ascii?Q?Sc2W6exVUfyOveBKAVXUA6KQJpHHG7v4gwOI/0nDPsp25l0zIUhfpwFPnAxf?=
 =?us-ascii?Q?MExengVSBXRk4uPbqFT5bmQNSFF/2TpTqPMBNSAxOqTw4hQC5MKf/Jd0hnTL?=
 =?us-ascii?Q?goUYfsbB2aKeKPAH5V6F3MMJ0oKG/TSRt3s1JZa6DgS7m8kuTnypw/RGhYNJ?=
 =?us-ascii?Q?ncVoJEX2mhtrnEMH4wpMx5Wy7652L61dhCLm0B/2s/Uiz46TfrT8Lzqe/DEw?=
 =?us-ascii?Q?5STZocnEjSER7cedhuD7VsUKepnRw/9AQnM1IblMKJyKtqVg2T1+a7Ox4rv4?=
 =?us-ascii?Q?oHt6R81SDjqzaDdee+Rjm6CgDY9y2BXfl1nullAdlH71r1etx+RcQrxS7fnY?=
 =?us-ascii?Q?SLiZkp+gYCqZORAEPY9Eff9UelT56JA6XZUCpJeWxDc8eeQSUiNK6EeJjbnc?=
 =?us-ascii?Q?6+AnF/OBjylQm8Whf7hvqGhLHQcKfRBf9b0thJEhOC5XlnYhTVCW70FgLUKU?=
 =?us-ascii?Q?jjxYDKMqa/rFjLua6jEkVhn17Y18e4Ry3b3oIcIM+r1y6Y1G/ukAGzc7Zwkn?=
 =?us-ascii?Q?ZvVbH5hMvRedP/jB3n60VEBE/HKP6nUargDlV5uHYojnDNkbvNgxEbzNcTsD?=
 =?us-ascii?Q?bm2/7HItCcUK6MCZgest1wRuaKJGnerRoe3U0hSeZCYATiqvisHYQcI9Onol?=
 =?us-ascii?Q?zpg8r2Ce7L6epcQXQZjRn+ijYuA39xmINhuFp5PSny39PzXAx2sZ8zWwL4P2?=
 =?us-ascii?Q?45iqLK/mc3kA8o0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TZvoxms8I6PYoTubNhXZeRv7zItZZ+vtyklMBLJvUipYKEI3+4O5UPG8EJJm?=
 =?us-ascii?Q?bb71GZNo/j7y9fobEZaRXJZwAgfWayr/0JWwbYSqPD0WKbKh5qjMxXAw6ZgX?=
 =?us-ascii?Q?pW05vinCiAHWUt4C13MFNP43DV/CUqoPG7qjvhQdZaVl3fcgzEMUSWzer4Qr?=
 =?us-ascii?Q?LeD36XxB3rJQUF/diR6ZC1luz7yOHxjMVcH7roaA7NI15SZ/7pYKto95Qfox?=
 =?us-ascii?Q?Boq3gGo0YkLBy378JaPWkDUivrbBM4L1w3E6U9Qm4iGf8mirtKKuQQBQXr50?=
 =?us-ascii?Q?H8cnhuSX8FVqMG4aNpatJuoQuUSNRroH17tVH52CD1u1WMqhYKD6xJocEvrp?=
 =?us-ascii?Q?FOqPB2q2FS/RGjkLYsNrNpj+1irLVM6x4iOsoq291dmY9Ajv0RcDqg+u0nkl?=
 =?us-ascii?Q?rSyU7pmoaWIJ9bAo9LK9AJa9UoVV6ZWedsUIYHJZXihflNycpNDDJPIvzEmZ?=
 =?us-ascii?Q?+6ePsN8rjx3uNdJVpGnGNgdXuFt1RyDtNUBdqWUZLSJM16+PlpeWFODOjc5x?=
 =?us-ascii?Q?65s6xDoLAlvz7HgdddYT+9COGsGPC82Xsb/EXtEfOt9mkn/1rW6+YFdp80Ad?=
 =?us-ascii?Q?AZYd68/No74KqKOZOfnIFeuedQQl34WPdZ5ak6eHw6A+wCfmdPvlKjBkDgtj?=
 =?us-ascii?Q?SW7Fb4kisIgz8qSjfSm5GTS0UORY6axaaEGxGftVDlvwAvqz/K+XlPgzZJoU?=
 =?us-ascii?Q?0ndFFb/hNiWQYTjrhfa4XlP5vXAeEMIrbli6Fc+JOR4X5PG+A2mQukSDRg+N?=
 =?us-ascii?Q?nqjI0TfWwdAaVk5+Txy4Grk6oGCA+y5XpMj2R3yP5VlKMTdjCLCHWG+I2/zx?=
 =?us-ascii?Q?sktI97IwazIviC1DnI/sinpP6uDa8RAxV4ptuf3t6uAWG85z0u11gESNHVwo?=
 =?us-ascii?Q?OAAoMUBpbL5PYju1Q5Nx1jb3sC3VZaO6PebM89fU/kdnZL6Lk8U/S/UH2KRf?=
 =?us-ascii?Q?Zr5pd8QBeqq1hjsHyhPVpxYwGRRv5/cDkmi4+ogBZK91iO08LTgwQLHB/RA+?=
 =?us-ascii?Q?DpRzMXzKHQDgIHIp89phVpht93Dm/yHTe7Pks37PM0MMAx8/XkiA06EdMpxm?=
 =?us-ascii?Q?My/Q+6bdZ+y1cAe3YH+VKA/UG4Yie/TCZDvIgUtZv9Om+t00avTsDTwDUan2?=
 =?us-ascii?Q?cBVycN/tbSEMcTDNVz9uy6VjlTUPr8TfqG3lV2qe1JKMIDsZuo1HWtfrJH5v?=
 =?us-ascii?Q?Dqly9d94UK6H/HlxsOLX96jKQltFAP0RcWKHOPFSRZHvq8krCDJESUM/DOJS?=
 =?us-ascii?Q?BxjtsDCoCtcE6FPHwAXZh/V7XW0PTsMUgBFSauGMRno/7XBONdxs8hSgqfIJ?=
 =?us-ascii?Q?Ga2VUlAQScX2788M9C4jtmUOBG5r2rnJbXIzJ/yaOO5BcsMgQqBoCMILj/UC?=
 =?us-ascii?Q?y1DyoRh8puif/VTDoSVQQnIq8uANh2wSf94/p1t4e0ZEnPrG1Q2n4glYI5BC?=
 =?us-ascii?Q?yJqn85TIStJ8LP7od+9jwV8FUMnGI+YHkwbN01aV34ExDmRLmPic4LDY5xqv?=
 =?us-ascii?Q?o45aQ8APFjcNVOXfb76r79DmmsJg1kaDFZ4xaN4RMKCsxtvG+0b9OAiCOvK9?=
 =?us-ascii?Q?ccJjIKDOB21qhwCfPSUWz7rOo+BkdUX9pKFWwYDQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c8ad25-bbcb-4711-3e3b-08de1260e6d3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:53.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fW7fzxz0kiYxgsg2vIFbDoBgQl2SEjRNHqvyXbqhCIDT9+tDxEdN9SLPZF5fgAMZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 142 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..210d1229aa1c1f
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,142 @@
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
+Instead the function pointers can end up at the higher level API (i.e.
+map/unmap, etc.) and the per-format code can be directly inlined into the
+per-format compilation unit. For something like IOMMU each format will be
+compiled into a per-format IOMMU operations kernel module.
+
+For this to work the .c file for each compilation unit will include both the
+format headers and the generic code for the implementation. For instance in an
+implementation compilation unit the headers would normally be included as
+follows::
+
+generic_pt/fmt/iommu_amdv1.c::
+
+	#include <linux/generic_pt/common.h>
+	#include "defs_amdv1.h"
+	#include "../pt_defs.h"
+	#include "amdv1.h"
+	#include "../pt_common.h"
+	#include "../pt_iter.h"
+	#include "../iommu_pt.h"  /* The IOMMU implementation */
+
+iommu_pt.h includes definitions that will generate the operations functions for
+map/unmap/etc. using the definitions provided by AMDv1. The resulting module
+will have exported symbols named like pt_iommu_amdv1_init().
+
+Refer to drivers/iommu/generic_pt/fmt/iommu_template.h for an example of how the
+IOMMU implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+Exported symbols and other global names are mangled using a per-format string
+via the NS() helper macro.
+
+The format uses struct pt_common as the top-level struct for the table,
+and each format will have its own struct pt_xxx which embeds it to store
+format-specific information.
+
+The implementation will further wrap struct pt_common in its own top-level
+struct, such as struct pt_iommu_amdv1.
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
+where a uniquely named per-format inline function provides the implementation
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
+clearer failures to speed up finding the problems. Once those pass then the
+entire kunit suite should be run.
+
+---------------------------
+IOMMU Invalidation Features
+---------------------------
+
+Invalidation is how the page table algorithms synchronize with a HW cache of the
+page table memory, typically called the TLB (or IOTLB for IOMMU cases).
+
+The TLB can store present PTEs, non-present PTEs and table pointers, depending
+on its design. Every HW has its own approach on how to describe what has changed
+to have changed items removed from the TLB.
+
+PT_FEAT_FLUSH_RANGE
+-------------------
+
+PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
+single range invalidation for each operation, over-invalidating if there are
+gaps of VA that don't need invalidation. This trades off impacted VA for number
+of invalidation operations. It does not keep track of what is being invalidated;
+however, if pages have to be freed then page table pointers have to be cleaned
+from the walk cache. The range can start/end at any page boundary.
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS
+---------------------------
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE; however, it tries
+to minimize the amount of impacted VA by issuing extra flush operations. This is
+useful if the cost of processing VA is very high, for instance because a
+hypervisor is processing the page table with a shadowing algorithm.
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 3e2a270bd82826..baff96b5cf0ba4 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -93,6 +93,7 @@ Subsystem-specific APIs
    frame-buffer
    aperture
    generic-counter
+   generic_pt
    gpio/index
    hsi
    hte/index
-- 
2.43.0


