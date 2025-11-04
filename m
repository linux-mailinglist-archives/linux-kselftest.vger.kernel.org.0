Return-Path: <linux-kselftest+bounces-44733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D040C32AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48461420FFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB20D33E35F;
	Tue,  4 Nov 2025 18:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uO8X+MZ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C426F295;
	Tue,  4 Nov 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281026; cv=fail; b=QmUpuV0YsP4SBfI+bLdS9cPsjKzAac+aQRiQqCpcCvZleCRF9WQUeudSEoa/wzBcN6uoI+qslrBUsm+c556Xzr5VT9BaFjojJnO+aogGC11xdYLmJoc7m3bLL55tYaqZK/dG2b2VwMEO+CI8mwPJO3fG1uNBzQ7A8KZNqwbcZr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281026; c=relaxed/simple;
	bh=oJeLijWXwLqYTlzmJMuAgjnM+Uuum6jYwlqjvHw8TU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LsD343b8n0nBYqxqwWx/XQpz45oTgPvrwI6JS2xdGXj19m+aadgzzNP1V919hhONeqquzpJ8L05/jbf0jx3HvxzpZE5vhyQgrIDX0g3fjP9excv/S6+4amAIQipDsFZKMeh0/TX37dAtdURr+wiU8HtqAP4dHAh4LtfM9VCh7j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uO8X+MZ+; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cba8GqL2mssAYkAPxfpVtni+GLaya+BBGKrkV9mifJXopzVdUKALbAuEO0xRlUiiUFIAHuVRmx1TN/2ug+lpjz57FQW3IfGzmbiKd2XdXICCBrZscAT+dnceisqAT9ANcwSRp8gSt68owurSPvKG4WsMekRr7T/AItl2uSlPdv3K2E/vMoo8JnGLIP+YslLoWv3IEo6Py2RA0N8aDhwTBZ8OFxIc1gMw5p5xjbaIJIy9h6KAtZeCAhtMkcjHe11NtiT2Uxl95AN+5APDMgncBy/LtBH6XwPDNpdOrDpZJMGWq9X74rnxV2Zq5XMvugK2Z1uKIolMWj2gE1gyJUIbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB7AbniOYb/vB5kZY7pSrrfNGv3ZcCuVI/OAVKHNdiI=;
 b=FJHdeIZ/lGRzZftJw4reUUHJU/q1gmL6D8mzqfWEmikg0v2btoOu+7PWaHsdocG5nkxivNcUgKRVnS+JkPnIrU2FDheMP/yS7TPvg4BuWzRT0QVAeYQ6Pud6J6izbkAfLa+ih06LgPdvGhu3zSAnZUJloIVne9g3o0g9tk6B3AJpwYLMB++YL5a6bn62/bKf5YIOxEqZBEqkXq3dIGy3KWCydWY/Qs3gNmHuKJljVORd1Ont1FDctibYdI/SmloD+7iuYs4gp3MW289Pm2lD3Fuj0lnxRazJsad0fWWa3Wenx/uqMar/sUTrUvOO+AgwAN82pU/CIODaFoHZihDHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB7AbniOYb/vB5kZY7pSrrfNGv3ZcCuVI/OAVKHNdiI=;
 b=uO8X+MZ+QYNsl3FORScRO0ANBQUOz7AgrRzgjH8nnzFfQdARWTI3x1x+QkYG9jBJyj2tmCvulbWkTmpx3sKCGqR6doYQcDmIU2AxTcPqGbRCUDNTm6jQw4rkcDsV9pvuAMjeN6ecNugT94VJMn/xkJwWMgy3a33sVQyA5/6LIZ2DhrFHIS9AOIC5EWSo5LQvm4n7HCvyKSiWMI5W1dOqgyJTE4VHITmvVC1HtK9600B7g46IwAsbPI7SIitiCG9yIvuzrbzaAT97FqY+sISq466D1Fn9GT69hn4/jAju/aeafdB4dN8E1eKI8xHKO+UWG6qzIAE74g00Q/7OjZBz/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:15 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:15 +0000
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
	patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v8 08/15] iommupt: Add read_and_clear_dirty op
Date: Tue,  4 Nov 2025 14:30:06 -0400
Message-ID: <8-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b0e65-5586-4cf7-bbcb-08de1bd032ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eCZnoJu3w73oJuwou6meNeKq+uWZMeUQLyZd/b3g6kkG6F2KWQOAEHpQ1Qw5?=
 =?us-ascii?Q?InX+KG2cKeXpZBLO8RY8SC+2H4Vw/iKRwbvnGVSjiZ0Ix25+b949Xxym7Ggm?=
 =?us-ascii?Q?VMAnS/zWt1o6qwwftX4lIdfvay7THlE4AtfhSe17BkLBDLBgGDg1Sw0H3mZx?=
 =?us-ascii?Q?G9O9x8sjW7Z9LEYZbvfs77A3ki+3w+MwIcXqdRf6se/QJRQhn608G83ibWqE?=
 =?us-ascii?Q?KItDjZQ+igH1VFgyY+i+K02+5PYq/uR1HfQDyc8rIpcXCcbRVhmMKVjQft3s?=
 =?us-ascii?Q?rFOAbt6IHTkEdoeoYxFgB1dk5P9X4bBuIY6B+RL5q4eXSkEzryA2lvz2Lp36?=
 =?us-ascii?Q?VsSPnpfJyh6Q70HWe2iwc+GnvTnb70SvWoWm4cKNtHNHbgkQ0ia+m0S2EZZ8?=
 =?us-ascii?Q?fIPdrDiDIbmK5yS7R2KhF91iOQnqIDxn11d9ULFG8f/Giqdh0hrIDmVXu0tb?=
 =?us-ascii?Q?0gjIVY5YDN4HWUneNwCrYHP2oEqNEsAP5LgEiIjEQQae2JUYGtXZywBonNxt?=
 =?us-ascii?Q?qr6jtXVBirsETRHJFKPBbiAdwokZf1mtQF2Hh0uIda1q71mOJHK8toEd7IIW?=
 =?us-ascii?Q?N4fiXFHOo9WwH3l/pSWYm9R2IovBtGQwTQwJDxcxAb6CDrv+CsLTJpCGlnDM?=
 =?us-ascii?Q?MG6vF9tLsshhI7i9f0UuhCqdspMl8GLJQoZdPcaV9n27fYIFEBnb7vuWj+id?=
 =?us-ascii?Q?VGkM6zrIC89er5/yAsXynFOcnvzxdSz46NuzeYWqg6/0xMVY5KHVPHH5G61V?=
 =?us-ascii?Q?3DZ+nz9yv+NfNjyAKPT9qtmkmSKsVSrYQ3pvxuRa+LcWONQQF2nziD6JZ5WU?=
 =?us-ascii?Q?FyyQepb55wlSNJkMWP9mSZt03ND5u4C4nyib48f8tV6d0wWxur2GgqgKZzO8?=
 =?us-ascii?Q?tTondq/sodiE0JmI9TWcjIf0WsjB84ax+rxM7rUKjKEihRQqx1u/HkYEuln+?=
 =?us-ascii?Q?VrYmycfNUupsRFYUG7yiWLOkD8rvqvqHunBPU3GEUqsEFmp1Cf5Wx1CqcMz7?=
 =?us-ascii?Q?mgoPhubb00cfzoi6wZHISYIWeRs8aWllxpUOHVZ/2FB+PhnlxXOQWWmeKzR/?=
 =?us-ascii?Q?kFkV7nsStdXMVSwPpFekL/h0NuvABmSTE5jIZAA6mcAWqZbuE9o+l90tN+FZ?=
 =?us-ascii?Q?cH8oPzSwnzPw1zZftQucdAAa61g6rl8Q+BRDOJUmhj8TFt+iogemeDNyXgcB?=
 =?us-ascii?Q?+vxt4gp1/DIkowZNvQkFTNeWVvCdMmqPJp3IJdcmTLeEQ1f21AKT89GFPUCa?=
 =?us-ascii?Q?iBTN9/YRH+zx3aXWXuD1icEgjPbrnLiWgwZAxHywoZ2MxuDbMZHkNFKxtOtd?=
 =?us-ascii?Q?2jdQNSOeKZRjmoY2Uf4BjhFpM0Ay8aD2YfgNBWWfpOqIj5Pccek72JSUXy3Y?=
 =?us-ascii?Q?nyyKzp9/fGwlNXNE1mHBVZ4dYSaVzVzK8NKkoK6ymqhk9qp8yMCgleOD66mb?=
 =?us-ascii?Q?vcOfFTbsczOHhUKcgY6rh778AwjL/Gco7vSxC5QzCM1D0Jf8EcZb4UBjQeOl?=
 =?us-ascii?Q?PrRjS81ho9FjNbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSXQ1eOU6a0JR8EEB30/2DMcXZG+WUzbXaMvl3zp0avAXZD8o58XORzSJ+qf?=
 =?us-ascii?Q?JpVJ+blCg2Zxf7XNCN1jsTHQpj992q2UeHM95qmy7V9qAwDOK9iW/mRZun6n?=
 =?us-ascii?Q?qe+qhP4c6Z+ymr3qp13CTknLdTkxh3g4VoSL4b+lZdh6NJ1IHOWNRbEoLnrQ?=
 =?us-ascii?Q?WtSM1FzlcMDOki8XQ4IidJCTKVkbddY/5cAWAYep4G1X1ypTnJm7qhPXA+ZO?=
 =?us-ascii?Q?3uZx4zqfL7m6MPFrbkznvoPAOa/h7CNQWs4ClexoAoNrQtOjEum0bPuUnyoR?=
 =?us-ascii?Q?u/SeszKVTGjDWtJM9tC7sjZ9P6MJIjERKUdUraq71k1mCp5RnQG+P0iD4Umu?=
 =?us-ascii?Q?uY31HsrI8Z9CFRV7H2XD4jDcLDootr1dTt3hJTT2H+xEWSr5QlGRJQauLmpl?=
 =?us-ascii?Q?D5eB61YgAqTcWjTrc7nKwEw0Dkru5qZdKtEcUu2Ofq8I8Bg0/UA2jBf3cHLX?=
 =?us-ascii?Q?KvWTA7j0WlC6kAUHtyjdTd4ghGxPE0EqpkRz9YXhe5dGtG54s00hzxO+5+WU?=
 =?us-ascii?Q?qomu/czC9wS+GmDbkna52ak5xFBryZHIxhg5+D4Wj7xgELdcJWdZfaHUR9z3?=
 =?us-ascii?Q?sNjeTnngl7JLqSVbnw3JjDi3LHPD3C2lQ9KyvMBEOjQYgj7SpSO8MO+3r1yu?=
 =?us-ascii?Q?yyHfGptC0MeKpNfe1UNDk5heWHf4ZCQiouKfzXdzDeFlNK7u2FwKRj7ZhVhh?=
 =?us-ascii?Q?b8M/dZMfa5sYz09h3TW7ryzN6l4DS84AVO8JLY4w2bCJTC3CLHL75bDmFydl?=
 =?us-ascii?Q?9jLANC8IWoFdqGCRqGqb8Dhj8YXGIl0j42botpwFO6QxzQUfGexELYDWNcQ9?=
 =?us-ascii?Q?BdRzBNrd9jDJGZqahbB61+T6cn9vvea4taXObgIrMe9R1kuxX6WT9BbBO4z0?=
 =?us-ascii?Q?mPFNXShtAIgX1ta610k/vKSJZJPsk4a2aiTKq59kTq2/v5tx8A+PQ21Py43W?=
 =?us-ascii?Q?fWILwdU9D5rlMBjxaBLIYLQF3UorcxTBNF5sIcJ8V94pgTD+UxpHa78QijR+?=
 =?us-ascii?Q?Kf5aHzzAs74QzqkDNwUEraFM/zJPW0hgaGajfjWfGPtlgp73ayvYyh/DqWqx?=
 =?us-ascii?Q?s60eIEbWg6fPXSEyWPWoph1gEXIuWOaqP4vdrjLSfLeKJKW+EFGU0nEZP9al?=
 =?us-ascii?Q?zqVsQrZM/juxAKi0U7zTfYCmPcWwJ6kJEszOzn5K9DxfqZJMm79Dv2VSiCc+?=
 =?us-ascii?Q?4+eDomEtO83hOepqMey7nD0bPWih4wM05kapyVGeXTfwQeELDUE3KRRq/SYA?=
 =?us-ascii?Q?fK/pwrHi8Il8mT9OffgmuKmZlH7ruJE1BRm4k1ScvypInYEPluNdKjuc5MvL?=
 =?us-ascii?Q?+jODGDn7r2TJqkInPG5A5YVcSo4Hbqzsz5zjsUpAKmaPSsInEUtYBFm0rWqS?=
 =?us-ascii?Q?E64/wiycE+44jDPxh52a3U6iuAwO8YyLBBY1WXHxSKF21Bp01A3dlZruHXbi?=
 =?us-ascii?Q?H2qyFVnIqqFIcHdIZJd4+fpawNabYnFQQsfdtwbTV41g2p1tH1FuYykNHf9I?=
 =?us-ascii?Q?KGmNUukg9gDPRRtchiEIZgLELa96hOeuxxGbQeDNMJM7Mq2ToSU14B2Ih92a?=
 =?us-ascii?Q?y00H/YDnssXRi26C6a4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b0e65-5586-4cf7-bbcb-08de1bd032ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:15.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pRN1vGe0Y8aW/Fw2ePVqZUmaarbO+2E0gGoxR/8zKG/MQP8Gd4qacaVlBhMVF7+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 104 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 110 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f32e81509f4f09..448c5796d4a861 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -162,6 +162,108 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
+struct pt_iommu_dirty_args {
+	struct iommu_dirty_bitmap *dirty;
+	unsigned int flags;
+};
+
+static void record_dirty(struct pt_state *pts,
+			 struct pt_iommu_dirty_args *dirty,
+			 unsigned int num_contig_lg2)
+{
+	pt_vaddr_t dirty_len;
+
+	if (num_contig_lg2 != ilog2(1)) {
+		unsigned int index = pts->index;
+		unsigned int end_index = log2_set_mod_max_t(
+			unsigned int, pts->index, num_contig_lg2);
+
+		/* Adjust for being contained inside a contiguous page */
+		end_index = min(end_index, pts->end_index);
+		dirty_len = (end_index - index) *
+				log2_to_int(pt_table_item_lg2sz(pts));
+	} else {
+		dirty_len = log2_to_int(pt_table_item_lg2sz(pts));
+	}
+
+	if (dirty->dirty->bitmap)
+		iova_bitmap_set(dirty->dirty->bitmap, pts->range->va,
+				dirty_len);
+
+	if (!(dirty->flags & IOMMU_DIRTY_NO_CLEAR)) {
+		pt_entry_make_write_clean(pts);
+		iommu_iotlb_gather_add_range(dirty->dirty->gather,
+					     pts->range->va, dirty_len);
+	}
+}
+
+static inline int __read_and_clear_dirty(struct pt_range *range, void *arg,
+					 unsigned int level,
+					 struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_dirty_args *dirty = arg;
+	int ret;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			ret = pt_descend(&pts, arg, __read_and_clear_dirty);
+			if (ret)
+				return ret;
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA && pt_entry_is_write_dirty(&pts))
+			record_dirty(&pts, dirty,
+				     pt_entry_num_contig_lg2(&pts));
+	}
+	return 0;
+}
+
+/**
+ * read_and_clear_dirty() - Manipulate the HW set write dirty state
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
+ * @dirty: Place to store the dirty bits
+ *
+ * Iterate over all the entries in the mapped range and record their write dirty
+ * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
+ * the entries will be left dirty, otherwise they are returned to being not
+ * write dirty.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Returns: -ERRNO on failure, 0 on success.
+ */
+int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
+				    unsigned long iova, size_t size,
+				    unsigned long flags,
+				    struct iommu_dirty_bitmap *dirty)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_iommu_dirty_args dirty_args = {
+		.dirty = dirty,
+		.flags = flags,
+	};
+	struct pt_range range;
+	int ret;
+
+#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_is_write_dirty)
+	return -EOPNOTSUPP;
+#endif
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, size);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __read_and_clear_dirty, &dirty_args);
+	PT_WARN_ON(ret);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(read_and_clear_dirty), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	/* Fail if any OAs are within the range */
@@ -1015,5 +1117,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Page table implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif  /* __GENERIC_PT_IOMMU_PT_H */
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 0d59423024d57f..03a906fbe12a83 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -12,6 +12,7 @@
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_driver_ops;
+struct iommu_dirty_bitmap;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -182,6 +183,9 @@ struct pt_iommu_cfg {
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
 		struct iommu_iotlb_gather *iotlb_gather);                      \
+	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
+		struct iommu_domain *domain, unsigned long iova, size_t size,  \
+		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -202,6 +206,8 @@ struct pt_iommu_cfg {
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
+#define IOMMU_PT_DIRTY_OPS(fmt) \
+	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


