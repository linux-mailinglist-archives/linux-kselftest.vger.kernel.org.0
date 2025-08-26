Return-Path: <linux-kselftest+bounces-39973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF920B37113
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EE1367564
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F482DA760;
	Tue, 26 Aug 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ushLCTR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4A31A56C;
	Tue, 26 Aug 2025 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228725; cv=fail; b=c5twMHHZAV+Ja+7qzJK7EJq+0BYLlZOLCwdukF6DFjC6872+NZuyCczOqAQJigOS/BMiGHDyor4aeWxSVRew/2P9f6jrX7q/3RTmDatV5l2kJfC5lHHckY+t8v9CTrtkH3bvRToNR4W94Xtp3vTCaSDRf9RQLe8kWsc2BV/1lyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228725; c=relaxed/simple;
	bh=cbBIAFhIJTNYm2bMyizWNlZyoieUsRnMWu2Vzj8ViWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRavz44IXjs7FcNI9rTZfokc0/sKiZVs1o4Xs8yRWMknuftYYZwxeWqtNdN92GvIE6gmk9IGTxyQlaxTrJa1/CeXIoY0zP+U665+mur54BTPpqAryHZh3gm60pEKq0JLQiEcKeFLFBoelJfvc6qy0weI2PrqIkXMDAgXyRS4Bkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ushLCTR3; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP/a+XOLTvbKdyxoEo2fP1cSpC0iXPri8nD1Q3bRJ6hIQmJR2OjNgS7Ai6m3fCFZQbQ7sae6S1J+/W+LP4fxijAuaO8WPkxolBPwT7gFZjxqJv3PZEkwsA+4q/C2pWssFUjvkprosPvhQ5+MlLyKZhiTprFxCRILY1JJnfhrhpnzcIHljNJiaPjMIz0HROPv5HA9IMEP8DxaOm8heEC8VyXykCkzFEtTsCxfHcZ40qQKApj45u2moCah1EWa8mDLFyJNO/alwpiQTMnO2EO4W7b580zUMwms8T7JboUU2zMMkbdVWLxkjsnwjyM9j6jXjBlgb85iIkkapyksHkqY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svOiw7HFNfT1DhRkAkG8eNPOfDMThRKHaYuT59ZaEdA=;
 b=TPJ7nC3m3WVERY/LUQErOyt8ASxjYund28x3oI1lfsixYGKZ9IDqxsev1G3gJFVSDmrfsQzBOEUg/GltA/yEB5PSttuQez0+ASqQ60IUbYIwEkXVipjCBHvvEc1TURIniG8oVBaUre1JRooLqj4vI/hcZfWShNo7Rfhz6DxcE/NYX3BFyt27Hp2UnvAJq0WIfgl1SiyecqS9s+l80m8zEzcl5lvv+RU4kAU3EG5We2G0KtY/2mjVAs6HiuyOzwMuWMAn2ai9Kpk0NLEsYgMSQF7jF4T/wfNWIzgXH2OhbquRbDY7xTaM6hFp2gv+PF4yq85AGfKrDZiQ2kCw3OqEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svOiw7HFNfT1DhRkAkG8eNPOfDMThRKHaYuT59ZaEdA=;
 b=ushLCTR3JqywK4dMZjPHkBk/JoIy5c/w0MQU4EsuHpuPpMC5f07jmPhA8f1wA1tMothSfRlmMHwwzFMf14LCp4ukBbnMIF/mvEBDCpiZJW3GOKHOuQpb98DVqVBR5rT4PCmdNFHJwR2tVoS16YiIBbL7AX7sVZc4YxWby4CsWYvRnEDFLyspKI+XkvYakt5v8UX0YGpcS2p+kICmrUEui1SIFdyr0z+gGmFi7WJT9emsxJu8PJhTJdT+Wg9qfyE6cUqU0RKIJgsaWguaUDM31T2c+mzzkJ/Nva0TvnskYifDcg3mYeTmPIiyJairkC68bpkwN2xiZPgoRIzHQgSpPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:39 +0000
Received: from SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0]) by SA1PR12MB8641.namprd12.prod.outlook.com
 ([fe80::9a57:92fa:9455:5bc0%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:39 +0000
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
Subject: [PATCH v4 02/15] genpt: Add Documentation/ files
Date: Tue, 26 Aug 2025 14:18:23 -0300
Message-ID: <2-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:806:d2::35) To SA1PR12MB8641.namprd12.prod.outlook.com
 (2603:10b6:806:388::18)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8641:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ef1cb29-f54c-408c-8d1b-08dde4c49885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtzmMAJi7XWU/NoqIaO/SdExdrd/GRm/IBkbFJLmz2ptd4yhINexYHF8XxmP?=
 =?us-ascii?Q?XZBvh7Q0dPazLzJ0LsdZY6wUI4tGnXb7CEZ0VulEn+TCIjTF51pv5iUFt6WZ?=
 =?us-ascii?Q?Bon4xL/7bT6458bpa/oEEhhbZh7VNW1VDJ7sMGxBeOsrvVMdChFYgvMfoXdd?=
 =?us-ascii?Q?GXnPnCyy928QlP0yqQlpFEKwlSHl//iv0AubG85WBDMkbW3QxpMmbXOMA8Kk?=
 =?us-ascii?Q?xQBQWg5aS85ANAF1qWi2lXvJCIN/K1Pcw0hDDm/GUlDyvbruItdc0/BKoqch?=
 =?us-ascii?Q?nBnakoU29baw87a+DhKIxLr5GayELJ7yQ/wMj4ZKKXppJ1uRtWahC/I2rfXF?=
 =?us-ascii?Q?Q0T48RGrulZisGaSLe+TavpjFzzfGncEEC6xELpAo8eovK56WPkGjQ71C4RB?=
 =?us-ascii?Q?XKQCeIZmufzbmLsuV/58NfaSAKe7CgGy03CfRd9ObQMg2DPDLeQzBkHJiS96?=
 =?us-ascii?Q?DoCDcRS8Ecr+JW3rzECIy+uMHkY7LZAwJ5emG75htWVrysVmrs1COQewDnB/?=
 =?us-ascii?Q?LYMyXrdUs802sOR8HpQuB2h1msLjvAi/7a2ypioEMkx5jVAoodG6t1FK7L6K?=
 =?us-ascii?Q?CXQC7jBQU+mT/KpnzFp5GW7xBjbS90shK9eylU61pzEDjJ5hlsr9Ry41m5sD?=
 =?us-ascii?Q?phDncSBprzLYoaddAl+lZPhrbM1+/zxKJFvh30tYQ3RYazH7xefRrkVM3GmU?=
 =?us-ascii?Q?67+MRuZ9PztuwoVm0gKVgpQcT5GYmdWbh3Ws4aY6mUzNSn7bcSq5Xb1Nvtej?=
 =?us-ascii?Q?e5GbzcUsTzQ+HYLi8tqM8HCW3TQqk86e7dM2Qw3AdCFu6zK3rnZw3POFZITL?=
 =?us-ascii?Q?et9VDOGjqxkK3S/FjtzbQZOoX1S/Y5zIcT1ltF4Q1F0y5brToR6ayOcb+Yse?=
 =?us-ascii?Q?FMs9NSszEDpdsg8RT+CEPIsgbE0If+Kr9S3TIb1njzvaJvGUr+3uScMOTwT8?=
 =?us-ascii?Q?OcojNwWeEO+uh7sjpjC0ukxYDI67mnZrSaYHt/Uez/6O16QB+wjG+h/Y8aAS?=
 =?us-ascii?Q?8ClXUNOu5XYszYSa3fNHnYbaqfFn7yvR0cHYOdrxv2khLtpB5pdpXm8Rkemu?=
 =?us-ascii?Q?NDJEY21Htgg3zMPMF+qL2j2wVgR7yt60izQ7vQUeRXVdvj4y1VU3Xco96cLL?=
 =?us-ascii?Q?mavxbdyRs34Lv2vFuDmpy/gnixFo/gLlEENmGsAw1ZcWU+khkb4MRCcewOeo?=
 =?us-ascii?Q?EOHNEN9VWW3baW5uqOfLq+mMP2SEnX/VgGcolivGGmEhb7TqaIiDNDuIV3ij?=
 =?us-ascii?Q?2uAuBBA1wLjNx6DWWz7+rI2fMLeEyeu8ALF74HrwbbDy/ucSWW0xXZ15rFWA?=
 =?us-ascii?Q?fj7U2TzNWaweFG8YGcw7qb3rMcgBaCd2d6dzHgAknQ7TlaOhhv8GsuytyZDG?=
 =?us-ascii?Q?6KkRyjx80X9SlvNWIzsW4/oUX6AHz3/TSEA2GlrQa3Zpq9NSRvAd6l8rU8ks?=
 =?us-ascii?Q?4Ate6FsDfaLJb1CDQzE8IUf/uYzwBZMZsZ3bw5AvY/hbu6EY4ZKRgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8641.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lq44XAimUyN1RUp5irr2zIvDB/SyO/kC7IdYxtzeCtjYiyvJYqfbrkqYF9vr?=
 =?us-ascii?Q?3mJaBqNwcOTUjc4qLMTofjDhKB3HnC8G2YufXemyEmYfByCeq2MD7sP1FVM5?=
 =?us-ascii?Q?bNof7k9b60WVINN95JZg67YXeWh9MNwPkPg6xAJxVyF0hNL/HdJloRZvNo7d?=
 =?us-ascii?Q?9OJqKywNpHe+I4oh7NjoHmYVvHSLiSiq3rNORKg0lb/xriNRxhyasgORDq/C?=
 =?us-ascii?Q?Y6tgDu4O+78n75vUg2iLoKRNH8pBnavFX6Z8RLx47F7aaYAr/6pw1uvFrzKd?=
 =?us-ascii?Q?piIMP6miM32BhI2M/oix1wvu2lD5GQuGxCZSgXe7dYqlfP9FDP3SiWG6wa75?=
 =?us-ascii?Q?BY2ENxvy3ah7mDmmUyEr1sZTOg9PAMUGtzlnjaswB+ppGr+2qcr8jQcPoMI3?=
 =?us-ascii?Q?ixBfjkBSnBrrvMxpRHu+1v+fSSpwaUpKxN8ctp9FUPPHbgoQo4iP/PjYvlt/?=
 =?us-ascii?Q?/nyxURsKHlv4zl5iEPlGwRToS9PNx8w1x8ZfL3pYvb7VhmlCISZtjL8DpmqH?=
 =?us-ascii?Q?wxJPPcyxiImLjnaO/9jcPH6dGoaj01wS3PscSZquKcBIqPaUGinDujOCAov3?=
 =?us-ascii?Q?hONA8nCSYOn6IuSv1vHlFphD609vcB/6PMa7MvKo6feGoL8GAB/C55XVS1fu?=
 =?us-ascii?Q?WpdsHzqQDMI0pb38vLxp6l2V1oMIN9AC5TrApvNXRYLkS+efr4dcQDGg9w9e?=
 =?us-ascii?Q?6oMWRnYtvtnkQhyJ8WVXA/jTi93N7Mf7c1wnB6tXQR+4nrACf9dUoSAAsG35?=
 =?us-ascii?Q?vRkPpWv7eITkXr/WvUps2xrRTiEM8ua0D8S2YVrvPPBKnFFmFHLEmLdoTNfJ?=
 =?us-ascii?Q?aXHmzQQxZYrITMsUuDxiMNZshc2m/B+41u3zX//XIutX9wQA63cJ03bgekwp?=
 =?us-ascii?Q?bTVmd6hL21ZKfn79O0T+VmutJWaF0e5MlPsjdbZ3k8/cGs6IZqHwF1918Y08?=
 =?us-ascii?Q?DwhuWln5dTIw/GMbtbziFBHvv3qhSS/bcOreynfcEuD2S97EeZaSwnvx6TgL?=
 =?us-ascii?Q?YvlenPav6YhGwNynLLRNlLKrho9xbkdiato9/4S3U0jVaB39Ihw4yJ+jbhEl?=
 =?us-ascii?Q?+DY9E+kCVP0iftKCzEMk26MLKGzP95BjwI/lcMrMl6hWohw2SeJ5kLDj1KoP?=
 =?us-ascii?Q?nCHUel61oS2ik2iqln3+h5UCFJJLviXPHf91Vj7PoFnVooJU1etxBQVrViBO?=
 =?us-ascii?Q?NDfuaC2LKjN88EwrQL5JLlmzkLT+TNTx0ORfCSj3giSJ3QONThkLqtlu6O25?=
 =?us-ascii?Q?o7MgOOhN8A/MNV24PbKIoV5SiBPmoufe8dj8+PP8P3M7DYDtX6TcW80uzkTu?=
 =?us-ascii?Q?sEtCrcUJ5vJx3MNqhJ9jWQYcUg0heQu8DY8vc8ehO9wcuACPicSKOhxR8r1w?=
 =?us-ascii?Q?LhsWddzxfBpExS/hOUrXb2uY29zIyqpa+4P7lKklUkKYzp10X79Hvj58HD6v?=
 =?us-ascii?Q?99Mo3FzUL6Bj0xQO1QooHxmsuaTkKw66V3pIJwCd0cobmiQ9jujQYVCBshQl?=
 =?us-ascii?Q?oHIzoOaoJrzTW1xtmfKfJLJYzN++UVa38I2qy0+Q6Xc4VfXMicRF7SlxnHs+?=
 =?us-ascii?Q?N6r08N4W/p4Zz9RVRCdUcUQ6Lg/fePNu+jMLd+q/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef1cb29-f54c-408c-8d1b-08dde4c49885
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8641.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:38.3184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEZq5q8BIuBdsPdui2/0QH/UXm7PlXD4PH7nL8Gf1PiZq8iW3OTC8lH28ytySarY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

Add some general description and pull in the kdoc comments from the source
file to index most of the useful functions.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 Documentation/driver-api/generic_pt.rst | 140 ++++++++++++++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/driver-api/generic_pt.rst

diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driver-api/generic_pt.rst
new file mode 100644
index 00000000000000..45b05dafece814
--- /dev/null
+++ b/Documentation/driver-api/generic_pt.rst
@@ -0,0 +1,140 @@
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
+etc) and the per-format code can be directly inlined into the per-format
+compilation unit. For something like iommu each format will be compiled into a
+per-format iommu operations kernel module.
+
+For this to work the .c file for each compilation unit will include both the
+format headers and the generic code for the implementation. For instance in an
+implementation compilation unit the headers would normally be included as
+follows::
+
+	#include <linux/generic_pt/common.h>
+	#include "fmt/defs_amdv1.h"
+	#include "pt_defs.h"
+	#include "fmt/amdv1.h"
+	#include "pt_common.h"
+	#include "pt_iter.h"
+	#include "iommut_pt.h"  /* The iommu implementation */
+
+iommu_pt.h includes definitions that will generate the operations functions for
+map/unmap/etc using the definitions provided by AMDv1. The resulting module
+will have exported symbols named like pt_iommu_amdv1_init().
+
+Refer to drivers/iommu/generic-pt/fmt/iommu_template.h for an example of how the
+iommu implementation uses multi-compilation to generate per-format ops structs
+pointers.
+
+The format code is written so that the common names arise from #defines to
+distinct format specific names. This is intended to aid debuggability by
+avoiding symbol clashes across all the different formats.
+
+Exported symbols and other global names are mangled using a per-format string
+via the NS() helper macro.
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
+clearer failures to speed up finding the problems. Once those pass then the
+entire kunit suite should be run.
+
+---------------------------
+IOMMU Invalidation Features
+---------------------------
+
+Invalidation is how the page table algorithms synchronize with a HW cache of the
+pagetable memory, typically called the TLB (or IOTLB for IOMMU cases).
+
+The TLB can store present PTEs, non-present PTEs and table pointers, depending
+on its design. Every HW has its own approach on how to describe what has changed
+to get changed items removed from the TLB.
+
+PT_FEAT_FLUSH_RANGE
+-------------------
+
+PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to generate a
+single range invalidation for each operation, over invalidating if there are
+gaps of VA that don't need invalidation. This trades off impacted VA for number
+of invalidation operations. It does not keep track of what is being invalidated,
+however if pages have to be freed then page table pointers have to be cleaned
+from the walk cache. The range can start/end at any page boundary.
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS
+---------------------------
+
+PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE however it tries
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


