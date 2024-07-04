Return-Path: <linux-kselftest+bounces-13172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A692927074
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9891C20C05
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97F61A0AF2;
	Thu,  4 Jul 2024 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+ZLXUYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB3FBF6;
	Thu,  4 Jul 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077925; cv=fail; b=owN5pyGFH86K+/PNmnI8YNmT2DSCZ5joJQGvRlIYx4zgpYaD+qvroT8Xua+uhAXW5ht4jiZ7UEpwyzqaM/JDaoSRn06eUULAyZUr8eOyJoCWnRazDBciRdrwCqNNFfmXj8lDZRKx/8xlSlqkfiVEx4TFy3mK84A+9lJRV45mKTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077925; c=relaxed/simple;
	bh=+r/caTVU7+hmaksrRkNzg6jg4B6JenlwNMrz4SAi5ds=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dfMYwiZPnS5p3me6qkf9NVadBm+w2tV29lJ3fY6L9n9bxBiHz/4Z7NfrXJzE/Zve9fFoj+6wwgAXCWyugkIckbEzt1Z5rSVgLz9n+Dv+5Uo5sfl9lLOI3xHuERYleN8I5GKTK/R9elyUSaWHUO66rpyQDLcibUWXsFWquXlYsVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+ZLXUYn; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+iL0BCV1/FbL7tasQUwLg0iI+OixEKQGNnpt6FDMxw/TcVyaIibJSOfLXfY9uID8x2rXevwwN9trRfd/KrPY1gJu24gwfmkBVkTmQdt6YqfuvkeEQjWvKHMqJlZLCeTveqJiz0cBXCu5iVwB4X/D32TgREJAQMP03Z+ZTXDHAkFc4T6xQHysCIWnLk47MtgPuCU0TqOoNC9chcBvRPreb9v9C0SlcLwSHOJHQBeYIiXbuiPkGl18N2A1lPY6Ou2AMrAxzE9OM42rcn8Xeh8pKUbJ9j3c1hjaPuZdVS4Fkexy1jCPJtRgfjU4/XBFIvx53Qqmi6FVYtbgKEfPLTKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua2cKYpBDMgb70zC/Qyj7u5icbVdIQutbiR5ekthnQ0=;
 b=RNeJ5wqLLtxym+FU139fncEScLNzgRzFN894SWzJpa8gNQ809zhVl/3XMqOaxv0CZah4qiB4TnaPZk6r8vDWN/uf9HBGdMXS8q0xvyF9hpfoMy88BiDvH4BNSIvDwHAsAgBydgjyERb7zFAWxYJzPH6WD4LKktR/6qiTGLX9HQyrQuzYUilqu+fQU8DVsuzgXOrpNJ8YiUWbsI0wzdaAx5fDd+o6g36RT1Xl2v1XVA8f3fIye+ryuqXgVquMJhmHUETeQ7Chp4vyB7iCGb6Y3aMn0APKDJ5Ua8gzmG9mP9JQcbdKV8QiqF+Zr3sfTpbhl+8DC1XNsVouTPdD/9eDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua2cKYpBDMgb70zC/Qyj7u5icbVdIQutbiR5ekthnQ0=;
 b=T+ZLXUYnqrfS4ApWBfqbbtNzOofJcvJbURkVAACYwMJ7XstHn0Ofqp5vELZLpu2GDif5tlqhW84FW6XI2gOKn65qEcjaQCP5NaajPfsOGfBDSak6LHXG2YlJFvVlikyKZQy9QFg5z/HMU+ecBOSDxGra9DnWlTGLCopnCERroQUCBGdJGvOt1uWN3cvIADN380RSdIw5q6CZOOUwoI60xNM69WOmTVYCneA8+cyeKdYEUkDn5iaWbpDgUKNIk8wXVxfu5J81x82pISra1GWUiC3lQSwqFvEz3wGyOTlKpmealA2kjabSea8de4WIIn9+NOWqBXZ+dpxKMfu7EIvEYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:20 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:20 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/7] selftests/x86: fix build errors and warnings found via clang
Date: Thu,  4 Jul 2024 00:24:24 -0700
Message-ID: <20240704072431.111640-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5a47c7-3c1a-43af-9d5e-08dc9bfa762b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OzJnyIq1QL2BhAEn0ylMiXU7eX/VeDptvcFOiPkuJ/T5BbWU8PNbiWtTlLcr?=
 =?us-ascii?Q?jIhocWIztSVpJ6w/JLx3yIsemFcBj2JvAC0+zJTXeQKKApAT+T/gybcbw/4N?=
 =?us-ascii?Q?Byj4pFTKd+QyVXaZ+Arbuwp+g7oBUXaWBiOzF5+rfBtndkNGDi7impJMludf?=
 =?us-ascii?Q?Bm0vKAiMcoEoCEdJIuhJoALbkgLre8psJP6kJxj3RhWGRQYdkbdbu8KV1vJH?=
 =?us-ascii?Q?69ejUYG4XCiBL9dAyiVcdB63hptbqq2nsnrBjLsf43J9IcfqkIRi5VetRs5p?=
 =?us-ascii?Q?nH/7Ft0ly4n+AHEFd6d5bht3uNKUx9Uh1J8VMYRsMJ5e1S7CDiz8YE1OH+q3?=
 =?us-ascii?Q?nn+P0/EJU1koQPd5UmjsMPWnDYFNQAJDtJ6YM7R+0MMIMRvpzSE+/Ln8C65G?=
 =?us-ascii?Q?2FDVc+eDHygN1kCBC2CWQU5vim40z//C+lFbNle563HvPBxIVvq1zmaLuJgO?=
 =?us-ascii?Q?zI1+4PW8ervsBfPO5eA/d10/teg95fHFEK+cpTPQK8UzP39KXIA9TZim0+Hq?=
 =?us-ascii?Q?CDQ5ZzDgUWl/ttQT3MWknA1CJlX3QqQIiRcgmas6fnfR8f+SuHL6xzA9aYvc?=
 =?us-ascii?Q?icP+08IgMEKoZVyP8U2FokvTEsySm6F7pjcfXMEO2PLDvHws2EtDE43h6217?=
 =?us-ascii?Q?Ync7zQ3G5ICVrCdDqD6Z4Ash87dNV/Sjc5pTNvsESynwngql0qiOGgmxnXSB?=
 =?us-ascii?Q?3nmw6UcIbrbPQodVbKGcQyqr3jWQIJS/a7A/UPxwPCpYebVhg8ooqT+KQelD?=
 =?us-ascii?Q?46M1YaVodElF9OU1JsQiEjz4VwrEbvDchoEb5iFI2RJGHNzI9KyTDrA+Dl0k?=
 =?us-ascii?Q?q5mvBItFBCfn26zaQXyPHtumKQW+tI4XO8wxtG2ZpQB1PPb5qpwQkklZO5q+?=
 =?us-ascii?Q?KjP8t738BEz8ifeDNn7KGxkAH2XdJ0LETrBsoptrDOp7jQG4rXL8zTsWnyoL?=
 =?us-ascii?Q?s/sSez4B0OACxrfvq7cCqvH1Wj+mfRPJJJ1PNWUubd98qxVbERr2CZMAYnG/?=
 =?us-ascii?Q?kn8Sr5OXutTYMAy5FtUMFg2fO6xUWXOpeW1kwFPZFe/u2ZGh7RKw5Pck26la?=
 =?us-ascii?Q?PbHGERAhX4AcPQtRl19nldLML8Yh4knLgeE2yK8CSwk1IceUEvCt/1XrFe7s?=
 =?us-ascii?Q?BfLhdzIfp3t+X6lCPFcX96npgDWydvZOHZKE2S9W62lG63vWl5VhAYtCZ5bx?=
 =?us-ascii?Q?elAYfhehUOCqbMMOxqhMBIFj5bnjeTNe5BfWo4/sN6YciBYdYSEvVfHNLX5n?=
 =?us-ascii?Q?7+j+fQ2+9b1vgqg8zTzJW0chlB24ZuqyffCtqh/vFFFsisx92wBMTbYUZR//?=
 =?us-ascii?Q?ve1/3xTr/U0/yyyoj687WMK8wqKlFj5nxr970ZtJPCqfyuoHaQUATf7V1bLA?=
 =?us-ascii?Q?tDJ+tHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hAQAQ01TsQf8m/DXaSxEb/l7MgaQgH5okrOzeMVUXRLfK/5wyIR9qVVfACtw?=
 =?us-ascii?Q?7UOKutJii1PPy1aN3H+ZEuKhNhmWAd36qTNQj5Ek2cjx0pYoELIaHP6C5/gl?=
 =?us-ascii?Q?u+os2x8pLkP1yv+3objAlIV55Z3zu/f3Cdo7poqIw7Ig/Wq7eQVq4A6Cb6eH?=
 =?us-ascii?Q?PE2XBEliblI5kyCPNrEFQhHZ/EXInjmuFTkD9dCDxH/E5mFufMG1Hq0DISLH?=
 =?us-ascii?Q?STNJvlP20L6PQA3war0VMev/RVxWbzKFskeYKefR5lQyGZmBduKgPJcxlihk?=
 =?us-ascii?Q?AlHIGWtB3FYBaU7DM0EVSkgjhN1WDhwEieqXpYV5H5frBqxOIZGC8SV0JXI1?=
 =?us-ascii?Q?WRZ8OdmvILZNLNJG04C4zQ6t0Tu1gRTMD3R9G7he6W5Kl4dMZcmj2b/1Weee?=
 =?us-ascii?Q?oyNUHbAPBk9f8XvU7P77N22ERiLKXRL2Rj3eKg7oDO+xex6hJmBPgGFg8ByB?=
 =?us-ascii?Q?YnGEe9zXZGseeGl3EoaQ7XjW5GEnjg08g/5/GxiXojPBogTyEeShFtSNeM/n?=
 =?us-ascii?Q?O6F0ARMRI62XbbkyEEvfhJEpcSjT3K3YQcn1pljEkL4VbWBjbPG/QXVLP4A8?=
 =?us-ascii?Q?yFj0I0l8Knb4tCnpzuKUQnFaOsM27m5+gNwP9qMA43LQBYKEIE47K1gsr2nC?=
 =?us-ascii?Q?wntmUkL/tyjL+YT7sQBhGY8D3tCyIBREFS5bYMRF4iW7+zxn84SSLAj6gDhv?=
 =?us-ascii?Q?YRZHTVnPmEP1MT9s6obSVKUP9dcCw3bTP5axOZ9KGBgYEXatZDcBJlm2hA+3?=
 =?us-ascii?Q?1IcRFLtNYj082UMR9GwR0c+UxwO5Qvgghx+2N23X92zL1OStBKh07DiKx+Ei?=
 =?us-ascii?Q?ESO0mDIKVyv+kDY+E43OvFMnl4XrO4yV6A1woK6Pu9vwqK4XSkZUg2uXjFC+?=
 =?us-ascii?Q?hHQd9klLfWbwqkeuSsos6sjVbcNQo18qr45944uOAHMJvDvGNaumAI3LzMMX?=
 =?us-ascii?Q?K2taIG6KoucPXiakxgmnkO8umiCRk/NKCQaYOdh61uCrs67gBDNJfjzL4bak?=
 =?us-ascii?Q?QYADngRN28kJr/uXwa/vYSWb6GrLNlfu8LG6cGPM9SobP5447od/6iesVh2m?=
 =?us-ascii?Q?BAWc3345kKh5Wcz3XrQLAnJQp/J3eEWJWRWHWEhIG29ayid0555fGiOS3ZJ9?=
 =?us-ascii?Q?uAMipzQr3Rol/o8NRdweWsrwrTyScFB48L5+bnecT2fwwJPaSzud813nStPJ?=
 =?us-ascii?Q?tDTwP22l4+vVGsnhGuMzKQ7BlpgiF/r7M6hBQT5xdk/loS4oTFVb4l5a7aEY?=
 =?us-ascii?Q?WHiymPOQIziwZG+Kv4zcFSG+GbueyJDudstfJWtb4WpQJpmrqJvyyFNf8JJO?=
 =?us-ascii?Q?yC2RuBNz3LDlU375BdRsCGR1mEVocJBF8wBmfISOUUREl42LcN76pNHxwruu?=
 =?us-ascii?Q?sZjzAy653dfxAjGb5pEKwpl67A6Y/+SiB6ahFliJzqFXYCTkQ28ScJusXmTY?=
 =?us-ascii?Q?J7rKdLSGiduG4Ic+vXNcXKm5KmkLVHvVHY/LNGqUVyVNiFRw8NMuzeQTUklE?=
 =?us-ascii?Q?s89f/rO1vv1PNYMWVK9FDYz17gOo6ehwApYMphadH3bPoVKqOu+wREnj0iYy?=
 =?us-ascii?Q?TfB8mQbB43Ikh2gPppzt3oa2D4ud0e6ul9ef2dH0c3htl9h6g6kH3yoVCfSz?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5a47c7-3c1a-43af-9d5e-08dc9bfa762b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:20.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH+Jc95Do/uNQsyYEojiXw6jV8mpVf7cZ1a2NyBd16l8q4m+Fx5yDo88vRQch8uHJyAnhYkbcDz67bZHoXeeKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

Changes since v3:

1) Rebased onto Linux 6.10-rc6+.

2) Added Muhammad's acks for the series.

Cover letter for v3:

Hi,

Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
discussed yesterday [1].

As I mentioned then, this is a bit intrusive--but no more than
necessary, IMHO. Specifically, it moves some clang-un-inlineable things
out to "pure" assembly code files.

I've tested this by building with clang, then running each binary on my
x86_64 test system with today's 6.10-rc1, and comparing the console and
dmesg output to a gcc-based build without these patches applied. Aside
from timestamps and virtual addresses, it looks identical.

Earlier cover letter:

Just a bunch of build and warnings fixes that show up when building with
clang. Some of these depend on each other, so I'm sending them as a
series.

Changes since v2:

1) Dropped my test_FISTTP.c patch, and picked up Muhammad's fix instead,
   seeing as how that was posted first.

2) Updated patch descriptions to reflect that Valentin Obst's build fix
   for LLVM [1] has already been merged into Linux main.

3) Minor wording and typo corrections in the commit logs throughout.

Changes since the first version:
1) Rebased onto Linux 6.10-rc1

Enjoy!

[1] https://lore.kernel.org/44428518-4d21-4de7-8587-04eceefb330d@nvidia.com

thanks,
John Hubbard

John Hubbard (6):
  selftests/x86: fix Makefile dependencies to work with clang
  selftests/x86: build fsgsbase_restore.c with clang
  selftests/x86: build sysret_rip.c with clang
  selftests/x86: avoid -no-pie warnings from clang during compilation
  selftests/x86: remove (or use) unused variables and functions
  selftests/x86: fix printk warnings reported by clang

Muhammad Usama Anjum (1):
  selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp

 tools/testing/selftests/x86/Makefile          | 31 +++++++++++++++----
 tools/testing/selftests/x86/amx.c             | 16 ----------
 .../testing/selftests/x86/clang_helpers_32.S  | 11 +++++++
 .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++
 tools/testing/selftests/x86/fsgsbase.c        |  6 ----
 .../testing/selftests/x86/fsgsbase_restore.c  | 11 +++----
 tools/testing/selftests/x86/sigreturn.c       |  2 +-
 .../testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++--------
 tools/testing/selftests/x86/test_FISTTP.c     |  8 ++---
 tools/testing/selftests/x86/test_vsyscall.c   | 15 +++------
 tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
 12 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S


base-commit: 795c58e4c7fc6163d8fb9f2baa86cfe898fa4b19
-- 
2.45.2


