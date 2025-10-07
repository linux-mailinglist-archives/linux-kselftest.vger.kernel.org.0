Return-Path: <linux-kselftest+bounces-42835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98DBC20E3
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0688350098
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BDA2E7647;
	Tue,  7 Oct 2025 16:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jBEDMvdr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1D72E7658;
	Tue,  7 Oct 2025 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853546; cv=fail; b=p9VZpZJEgLyb663El9eV4J1Z90SSMgQFMLTXUQuA5xtmtXteFo1wHKpBMwrcysf87uEt0pH1Ymj1E0tIWPmJ3gImPNI8JEJglnlQQzqozj34qGiLHLPolAhYkMpe/r/o6I12yEShLd0oBTMrAnqJlBm0INiF0I7eJSa5UNL7UUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853546; c=relaxed/simple;
	bh=Fz8/O0hZcQegD+AHRagNi7JtsUvbLMxhnqSvuWYQa3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a85JGE9Ml7WCAbnvn9GQORlg/pbMYwZcXq1Vuz3Gn8w+l9HlMyfuOJBjstW9Wye1cZL/Ejky8v8nG4OGbtPxvwRPR6fzrTtjojQOYDIbGuu6Sm+6ii+28+qc3QZ61z77ha+yL6y4HuWkiLsKiRCzLDsflpYoG4L2Q8+KUDuC3Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jBEDMvdr; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGqiMWc131y4TU9nvKMk1ukhCumTthGImXnE54cBo3/CsJbELo/fXMuYI2cgKSKplt06XPZ+c8HkCiINGsulYAJTBjyErKXgfDEr0rG4mVMKg5P1g3PHUBSjRBtIbRbiWyT5gtV4BJi6A6D3nDPro4SOdvLDaeJKB6ykZSPwT4ANCSJ4LMi9QTYVIHE4ytLVsnyXr4MMpGfzO3gEGOXzn+xEWMAveU2L7+x7h2UF6+tbwHxCtVEAq8uCUJxviLJ2d/S8z2gRC2S0Q6Ficuuea7sZDu2r4eNZZuEVR2y8NUfEpeHslyOsNY199SomA03WQH3TiO2+oLKfhJ8UjYWNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPfI75dKG/y6bauoFjY55kstwnnVI4PCMF50o+JK2h0=;
 b=PrQ/zopO78HtIrUoHv87mpJaLw2+i+HHNUNbsvigNXsN2JZggg93L45qwePgZm7Ya5+ygtxPr7u+jKGmtXn+C8mst2+tWYL/HoYHH7H7dGCK5C9Z6c7Fw8rWkqOvIEG4mDLHW+cPf4UWncEB72lz/PHVggDSiP6DyAnq6Pz7Q3BGx1rnC5VcOKZLkRu1GSQHDpxL9t/vzGTC+t5hikdDvdHbgK3n0cJCDMi7wpdNRFIVCYdSQPgv8CUKIYhslq1MgTsNhAP2kWtGBgucnXyRZ/NnAcGXsYdS06VavgG/REYckSDzgkaVFzVhuvYdS2KLgggvRVbNHxS3PmeqUxADsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPfI75dKG/y6bauoFjY55kstwnnVI4PCMF50o+JK2h0=;
 b=jBEDMvdrht2ql4dpJiN3Fm9YUXRglgbK9zzONnyOqGBTfsjd4c64BVv6TOErpDabhAVT4UzH4EfRsCweYQuU7fohicyo/zkrvkTDczBRGi0/+jUa2+LiwQZxoAieeqBDHeC9mKIP5Ez2JYb6Y5XS8igQJfoXYxNIRPCHwAhIrX7a8TDHfyMqzE7pLS25b+MLWIGGt6/LQy0jL4TApEEIT9fpZGYIlXzwei4ZNWMTXirw5ZHLO/4+uBI44EwAB07DtGD9kalj867HZeaPwwd2Zpe3MRKR4whtYYw4CHLN46X2fwvR8DBN4W8gxC0L2kfd2x5PPvdQIqVMOhnTf7TIYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:12:09 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:12:09 +0000
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
Subject: [PATCH v6 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Tue,  7 Oct 2025 13:12:00 -0300
Message-ID: <15-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0379.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::24) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: b40e4eac-d4e7-4934-f435-08de05bc4155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AlZGqOCz4xTrlDTOLXACFXWQJCz025M/Oefgw6Qa1zi6J4dvr6fGDWnu8Kzx?=
 =?us-ascii?Q?XWq+OH/9w8PD1k4M8yv8wB/zG3w9/bQ0oUYbDh1ANTD5oOm6AD1cTrevm9g+?=
 =?us-ascii?Q?OFZJNEQpYBiZb8pnqdiW5D1ckWrpzZzWAiWM6pWXIsWojjAkaArYYTpixdNI?=
 =?us-ascii?Q?eR7xIqGNQbRPdgIvZ26kmHZNomVjnjgaHN0ygC4qJwgHCrhAIqsDkz6A6xcl?=
 =?us-ascii?Q?CM6GaBjbMO8ZskBTUCTmOXOqd/BkBCB3u63JOE4ZKoQxbLO2nyXjZp/+TH0u?=
 =?us-ascii?Q?0jCrQouyrC3hKnr1QqNY+NpUJ/0+svtfScfRKN2ijMK2lDNLjkZsOI8YYyt1?=
 =?us-ascii?Q?O5fELtpCw9aaKR6WLqQ0ffJmX3fPOOkL2Jwi5p4bFuu08XHNaDAlaIbbMiho?=
 =?us-ascii?Q?BJmtUrjEEWtQoJn3SMjQ5uOqKv6L+bB9phWtKxvIqy/k4WXo2fyouiozJpt1?=
 =?us-ascii?Q?6PTeBRELIAmyDlg56m2naB0P3qD4e2re/JcLdk0CaKv0TgHDHNCXHBEfrh/Z?=
 =?us-ascii?Q?7CrUosesCpow9lGOCbcA/CNJMUtNJWSsQtUrU9JwGqR/NSKpAOvnTgWJBEC/?=
 =?us-ascii?Q?yHUn4r+rvYDGyHgxxCQCGNtDwnLU1fOpDLp7kMbym1FFtggJp0ZUK9PnKrPE?=
 =?us-ascii?Q?0RVEMg/H8cFvJaIrwzfV69qDK7iJL0tgr8+dd5h/BUEZommdb8GkNeyEdSY6?=
 =?us-ascii?Q?HBF+C1u7COX8O3LdkgSxaubWaK7tb9z/pzliRGSQpFHOIcaMkAHQWP//cAGF?=
 =?us-ascii?Q?I28ugpnJBHuBjHnpgOkwt6bFVwQCueMAUrlQscT4wHMS2wz2o8AkTlMON5RJ?=
 =?us-ascii?Q?113iAemBStgKaoPlwsbcVjzs4RqLDmoyclu9pgmXBwRela2xdnEG8DbPnuwU?=
 =?us-ascii?Q?7pdP1ldfVYq3VFseqEs/sBzQJQXxj/U5A/Qn8oxckY0wwkH/7tCpSoIGLJes?=
 =?us-ascii?Q?sAxVkpXoXq4pNH7IZpx/IodZK2Qq4jVQatAhOjn1/IWtK08spvWbcgiBAR+i?=
 =?us-ascii?Q?CBBGmakhJ687ToF+F3udl5r3x2Tk+BDAiVp6hTmI2ui+yKZ7gYtqKDlE+8kD?=
 =?us-ascii?Q?7PaD8uzyfIIGWup7fLdtUljcn+LsOFBmVbP9o1FrrBEko5e+HdFKMYYAIZgB?=
 =?us-ascii?Q?k82CJcEU0l5FTBjCHjEy43tplHhJ8mG6RrVtRZRqh6hHdFYP2cMnMVVop6jt?=
 =?us-ascii?Q?z6T0WaZwXzeHVViF+LIwUuvTI823bcycMBVFB9bITTyKkPMsYJUGYUf8IA6B?=
 =?us-ascii?Q?ByUa5A5WsBNHJiECe+xSowiMZVkVn0jTKPNX132r2Tq/Z3Gj7PT+a6CWIzaK?=
 =?us-ascii?Q?c2gRaIQQzFcdJtpC+Zrpq0+oX94XHATMBvmiNIfmwvnoP0/QCcXj1ssbrxmO?=
 =?us-ascii?Q?+2qNIlha+g+vUnmGImR8hwkR2vMG9aq8iDlsX9ooPxySb9NlrG822/bIbqVy?=
 =?us-ascii?Q?vKjMtPwplXtrnistXZafk5okDtvcDHlJjM3/OOkKy7LH40Yki1tAnU6cdCr1?=
 =?us-ascii?Q?hDCIX1sOTtnZjWKOKfyz1ZxA/QnLQnlaSUtC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l5f/Akwz9qPOiJZ2rjahrNTl4FQZ6eTfnRcJ6qwsvMfffrCaA/Af/MlXD5jZ?=
 =?us-ascii?Q?hyQbEgAQEUU375IJuGw8Cco9eyVIVTXJGmG5nkx3gO5qXRZEdZE0RfEEd8xi?=
 =?us-ascii?Q?74J/9fJ4ZhH5GtTVr4IMEP5tPcZ6aaGXE70tQJjCsZ5WGAHpO1ziu1s5VdUO?=
 =?us-ascii?Q?klaZxOXsA8SKxgfbhv6ESJsi8mznP/D6uFtdrzcWIl9XV6K1pn9Kt9McQZUQ?=
 =?us-ascii?Q?TPK4FVWPFagnSddCMXZ3gFrLcqhG8Ka26uDXiQzSKPBo8boY3ksRlipZ+zR+?=
 =?us-ascii?Q?ngy3W88+W6zSoEHv5LvMPJsL0mhdUcopxRF9yI6MaBQWcDtK6/h+ZdsVCBrZ?=
 =?us-ascii?Q?f/7Z+WXDyPLZmfNuhx4z7Ym1YRV5/dNtP3CoqSFSZEWMmnWx6mlmQIyt9OfK?=
 =?us-ascii?Q?B5lZSEk1ONygOXR6W/WuqLA7XaVUcnD/qL+AbtYXSF6hd46ii16a1GbQ+wZY?=
 =?us-ascii?Q?KyOB5MNZEtSsthxocAKon3JcrbD3+CXXamU/0QB0RuNrjULxiQkfNL5aPocn?=
 =?us-ascii?Q?EaliZq3ZyRRUJ53P/KxESDyMMzz72fA9n1RlvMTfMZjDvIsJgTTamVDSsLYv?=
 =?us-ascii?Q?tE5Ad/DiPMIS9D00xwg2eKe1eY0SP3vUNjev1hzRJXpXHPhWSOzgqaxZOlxc?=
 =?us-ascii?Q?I4MpG/JnV7l379Ej1RNfW73I6+wdJ5x7WO5HxkdhzB8vUJYlukaFaCgnUNoJ?=
 =?us-ascii?Q?HoGcJMleAxCptzMzoZ7YELQEnJa2XdVcs8P28O9QyyEQNvXdIU/Fl16xQNOR?=
 =?us-ascii?Q?HY37m8+0cDhhVvvyl02Gm8o0Tvs8asaMKV57pGqM868s4WriBF+zyomxLavW?=
 =?us-ascii?Q?1cLH4apguVqsV9zwace2amCa+gbd29Yjk+00YXlRv8TkrICmnjt455lrw8J8?=
 =?us-ascii?Q?Mq2xfPdzi9k/7QSAeXhoGHhkykrcRAPHsHf971RyHQOt5IpTI1Tly4X7VxgG?=
 =?us-ascii?Q?MF2UstoA9exCkiegAkuvUvBJIOyYxRq4EvsKFfdxSrdq5bmAmUKJzrstV6Va?=
 =?us-ascii?Q?gkfJqVgupyJSsmgIHKCfglXQMKKQdKNur8Ss24p1st34lcAS4USKu+raV/CW?=
 =?us-ascii?Q?iS1KeYn8ySWW4pOZVAE5Iu5FRbPHe0GvjK2Z0deHX9cLcysIPfh7+roB3/XB?=
 =?us-ascii?Q?GGk3KWdMfBEonSc53WKOpPXWJKQktTuC70eN3ODtof9DArpXzEk2ZrT3H7yW?=
 =?us-ascii?Q?cBVEaWobmZAlOdJDSSJe6FyHxxaMBhMP4/qxuBVCvOjBrkfotGbS6FGhzgtO?=
 =?us-ascii?Q?PEiieReL+lfPoOGnaxFFhcz/+hdIKtbKRQGchcs21RGeymIgLpHADfHgAqpx?=
 =?us-ascii?Q?/OrymzX4bE8f5q8XYQ6giNoc8jZSKD91Q1R/ovk+CaEijg6n7ZdPY0LP1IPB?=
 =?us-ascii?Q?cGZZJWH1p3fbW/eZocJtqAtdQYNBjWgWJ7SmKlo8+obfw7u2xCKxdf7MStaP?=
 =?us-ascii?Q?Aw5FaiXlu7RvWHFgTcpl88m4sDJTR+DMABidytooZza/pH4kxWouKCxut/Sn?=
 =?us-ascii?Q?TnVsGOPUwEAVGELDS1grlDFFc32jutclm8gw+wrh/zqBq19ddmc4HzydgD6m?=
 =?us-ascii?Q?EK+oGJceJO19Mz44WJs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40e4eac-d4e7-4934-f435-08de05bc4155
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:12:04.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpJt0iBVgfg0+gxXLvDNuIw5oF2EruCz9DQesldThirFJ/7A3wtXl0oX0X1vSlmg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit tests can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_WERROR=n --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID=100
tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386 --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_i386pae --arch i386 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig --kconfig_add CONFIG_X86_PAE=y

There are several interesting corner cases on the 32 bit platforms that
need checking.

Like the generic tests, these are run on the format's configuration list
using kunit "params". This also checks the core iommu parts of the page
table code as it enters the logic through a mock iommu_domain.

The following are checked:
 - PT_FEAT_DYNAMIC_TOP properly adds levels one by one
 - Every page size can be iommu_map()'d, and mapping creates that size
 - iommu_iova_to_phys() works with every page size
 - Test converting OA -> non present -> OA when the two OAs overlap and
   free table levels
 - Test that unmap stops at holes, unmap doesn't split, and unmap returns
   the right values for partial unmap requests
 - Randomly map/unmap. Checks map with random sizes, that map fails when
   hitting collisions doing nothing, unmap/map with random intersections and
   full unmap of random sizes. Also checks iommu_iova_to_phys() with random
   sizes
 - Check for memory leaks by monitoring NR_SECONDARY_PAGETABLE

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 486 ++++++++++++++++++
 3 files changed, 489 insertions(+)
 create mode 100644 drivers/iommu/generic_pt/kunit_iommu_pt.h

diff --git a/drivers/iommu/generic_pt/fmt/iommu_template.h b/drivers/iommu/generic_pt/fmt/iommu_template.h
index 11e85106ae302e..d28e86abdf2e74 100644
--- a/drivers/iommu/generic_pt/fmt/iommu_template.h
+++ b/drivers/iommu/generic_pt/fmt/iommu_template.h
@@ -44,4 +44,5 @@
  * which means we are building the kunit modle.
  */
 #include "../kunit_generic_pt.h"
+#include "../kunit_iommu_pt.h"
 #endif
diff --git a/drivers/iommu/generic_pt/kunit_iommu.h b/drivers/iommu/generic_pt/kunit_iommu.h
index 346e05f56bf540..0f389af6f7c2fc 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -70,6 +70,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..215276f644066f
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,486 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include "kunit_iommu.h"
+#include "pt_iter.h"
+#include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
+
+static void do_map(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		   pt_vaddr_t len);
+
+struct count_valids {
+	u64 per_size[PT_VADDR_MAX_LG2];
+};
+
+static int __count_valids(struct pt_range *range, void *arg, unsigned int level,
+			  struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct count_valids *valids = arg;
+
+	for_each_pt_level_entry(&pts) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			pt_descend(&pts, arg, __count_valids);
+			continue;
+		}
+		if (pts.type == PT_ENTRY_OA) {
+			valids->per_size[pt_entry_oa_lg2sz(&pts)]++;
+			continue;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Number of valid table entries. This counts contiguous entries as a single
+ * valid.
+ */
+static unsigned int count_valids(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++)
+		total += valids.per_size[i];
+	return total;
+}
+
+/* Only a single page size is present, count the number of valid entries */
+static unsigned int count_valids_single(struct kunit *test, pt_vaddr_t pgsz)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	u64 total = 0;
+	unsigned int i;
+
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+
+	for (i = 0; i != ARRAY_SIZE(valids.per_size); i++) {
+		if ((1ULL << i) == pgsz)
+			total = valids.per_size[i];
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[i], 0);
+	}
+	return total;
+}
+
+static void do_unmap(struct kunit *test, pt_vaddr_t va, pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	size_t ret;
+
+	ret = iommu_unmap(&priv->domain, va, len);
+	KUNIT_ASSERT_EQ(test, ret, len);
+}
+
+static void check_iova(struct kunit *test, pt_vaddr_t va, pt_oaddr_t pa,
+		       pt_vaddr_t len)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t pfn = log2_div(va, priv->smallest_pgsz_lg2);
+	pt_vaddr_t end_pfn = pfn + log2_div(len, priv->smallest_pgsz_lg2);
+
+	for (; pfn != end_pfn; pfn++) {
+		phys_addr_t res = iommu_iova_to_phys(&priv->domain,
+						     pfn * priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, res, (phys_addr_t)pa);
+		if (res != pa)
+			break;
+		pa += priv->smallest_pgsz;
+	}
+}
+
+static void test_increase_level(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_common *common = priv->common;
+
+	if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+		kunit_skip(test, "PT_FEAT_DYNAMIC_TOP not set for this format");
+
+	if (IS_32BIT)
+		kunit_skip(test, "Unable to test on 32bit");
+
+	KUNIT_ASSERT_GT(test, common->max_vasz_lg2,
+			pt_top_range(common).max_vasz_lg2);
+
+	/* Add every possible level to the max */
+	while (common->max_vasz_lg2 != pt_top_range(common).max_vasz_lg2) {
+		struct pt_range top_range = pt_top_range(common);
+
+		if (top_range.va == 0)
+			do_map(test, top_range.last_va + 1, 0,
+			       priv->smallest_pgsz);
+		else
+			do_map(test, top_range.va - priv->smallest_pgsz, 0,
+			       priv->smallest_pgsz);
+
+		KUNIT_ASSERT_EQ(test, pt_top_range(common).top_level,
+				top_range.top_level + 1);
+		KUNIT_ASSERT_GE(test, common->max_vasz_lg2,
+				pt_top_range(common).max_vasz_lg2);
+	}
+}
+
+static void test_map_simple(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range range = pt_top_range(priv->common);
+	struct count_valids valids = {};
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	pt_vaddr_t cur_va;
+
+	/* Map every reported page size */
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+
+		cur_va = ALIGN(cur_va, len);
+		do_map(test, cur_va, paddr, len);
+		if (len <= SZ_2G)
+			check_iova(test, cur_va, paddr, len);
+		cur_va += len;
+	}
+
+	/* The read interface reports that every page size was created */
+	range = pt_top_range(priv->common);
+	KUNIT_ASSERT_NO_ERRNO(test,
+			      pt_walk_range(&range, __count_valids, &valids));
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		if (pgsize_bitmap & (1ULL << pgsz_lg2))
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 1);
+		else
+			KUNIT_ASSERT_EQ(test, valids.per_size[pgsz_lg2], 0);
+	}
+
+	/* Unmap works */
+	range = pt_top_range(priv->common);
+	cur_va = range.va + priv->smallest_pgsz * 256;
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		u64 len = log2_to_int(pgsz_lg2);
+
+		if (!(pgsize_bitmap & len))
+			continue;
+		cur_va = ALIGN(cur_va, len);
+		do_unmap(test, cur_va, len);
+		cur_va += len;
+	}
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+}
+
+/*
+ * Test to convert a table pointer into an OA by mapping something small,
+ * unmapping it so as to leave behind a table pointer, then mapping something
+ * larger that will convert the table into an OA.
+ */
+static void test_map_table_to_oa(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	pt_vaddr_t limited_pgbitmap =
+		priv->info.pgsize_bitmap % (IS_32BIT ? SZ_2G : SZ_16G);
+	struct pt_range range = pt_top_range(priv->common);
+	unsigned int pgsz_lg2;
+	pt_vaddr_t max_pgsize;
+	pt_vaddr_t cur_va;
+
+	max_pgsize = 1ULL << (vafls(limited_pgbitmap) - 1);
+	KUNIT_ASSERT_TRUE(test, priv->info.pgsize_bitmap & max_pgsize);
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_oaddr_t paddr = log2_set_mod(priv->test_oa, 0, pgsz_lg2);
+		u64 len = log2_to_int(pgsz_lg2);
+		pt_vaddr_t offset;
+
+		if (!(priv->info.pgsize_bitmap & len))
+			continue;
+		if (len > max_pgsize)
+			break;
+
+		cur_va = ALIGN(range.va + priv->smallest_pgsz * 256,
+			       max_pgsize);
+		for (offset = 0; offset != max_pgsize; offset += len)
+			do_map(test, cur_va + offset, paddr + offset, len);
+		check_iova(test, cur_va, paddr, max_pgsize);
+		KUNIT_ASSERT_EQ(test, count_valids_single(test, len),
+				max_pgsize / len);
+
+		if (len == max_pgsize) {
+			do_unmap(test, cur_va, max_pgsize);
+		} else {
+			do_unmap(test, cur_va, max_pgsize / 2);
+			for (offset = max_pgsize / 2; offset != max_pgsize;
+			     offset += len)
+				do_unmap(test, cur_va + offset, len);
+		}
+
+		KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+	}
+}
+
+/*
+ * Test unmapping a small page at the start of a large page. This always unmaps
+ * the large page.
+ */
+static void test_unmap_split(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	pt_vaddr_t pgsize_bitmap = priv->safe_pgsize_bitmap;
+	unsigned int pgsz_lg2;
+	unsigned int count = 0;
+
+	for (pgsz_lg2 = 0; pgsz_lg2 != PT_VADDR_MAX_LG2; pgsz_lg2++) {
+		pt_vaddr_t base_len = log2_to_int(pgsz_lg2);
+		unsigned int next_pgsz_lg2;
+
+		if (!(pgsize_bitmap & base_len))
+			continue;
+
+		for (next_pgsz_lg2 = pgsz_lg2 + 1;
+		     next_pgsz_lg2 != PT_VADDR_MAX_LG2; next_pgsz_lg2++) {
+			pt_vaddr_t next_len = log2_to_int(next_pgsz_lg2);
+			pt_vaddr_t vaddr = top_range.va;
+			pt_oaddr_t paddr = 0;
+			size_t gnmapped;
+
+			if (!(pgsize_bitmap & next_len))
+				continue;
+
+			do_map(test, vaddr, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			/* Make sure unmap doesn't keep going */
+			do_map(test, vaddr, paddr, next_len);
+			do_map(test, vaddr + next_len, paddr, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr, base_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+			gnmapped = iommu_unmap(&priv->domain, vaddr + next_len,
+					       next_len);
+			KUNIT_ASSERT_EQ(test, gnmapped, next_len);
+
+			count++;
+		}
+	}
+
+	if (count == 0)
+		kunit_skip(test, "Test needs two page sizes");
+}
+
+static void unmap_collisions(struct kunit *test, struct maple_tree *mt,
+			     pt_vaddr_t start, pt_vaddr_t last)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	MA_STATE(mas, mt, start, last);
+	void *entry;
+
+	mtree_lock(mt);
+	mas_for_each(&mas, entry, last) {
+		pt_vaddr_t mas_start = mas.index;
+		pt_vaddr_t len = (mas.last - mas_start) + 1;
+		pt_oaddr_t paddr;
+
+		mas_erase(&mas);
+		mas_pause(&mas);
+		mtree_unlock(mt);
+
+		paddr = oalog2_mod(mas_start, priv->common->max_oasz_lg2);
+		check_iova(test, mas_start, paddr, len);
+		do_unmap(test, mas_start, len);
+		mtree_lock(mt);
+	}
+	mtree_unlock(mt);
+}
+
+static void clamp_range(struct kunit *test, struct pt_range *range)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (range->last_va - range->va > SZ_1G)
+		range->last_va = range->va + SZ_1G;
+	KUNIT_ASSERT_NE(test, range->last_va, PT_VADDR_MAX);
+	if (range->va <= MAPLE_RESERVED_RANGE)
+		range->va =
+			ALIGN(MAPLE_RESERVED_RANGE, priv->smallest_pgsz);
+}
+
+/*
+ * Randomly map and unmap ranges that can large physical pages. If a random
+ * range overlaps with existing ranges then unmap them. This hits all the
+ * special cases.
+ */
+static void test_random_map(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range upper_range = pt_upper_range(priv->common);
+	struct pt_range top_range = pt_top_range(priv->common);
+	struct maple_tree mt;
+	unsigned int iter;
+
+	mt_init(&mt);
+
+	/*
+	 * Shrink the range so randomization is more likely to have
+	 * intersections
+	 */
+	clamp_range(test, &top_range);
+	clamp_range(test, &upper_range);
+
+	for (iter = 0; iter != 1000; iter++) {
+		struct pt_range *range = &top_range;
+		pt_oaddr_t paddr;
+		pt_vaddr_t start;
+		pt_vaddr_t end;
+		int ret;
+
+		if (pt_feature(priv->common, PT_FEAT_SIGN_EXTEND) &&
+		    ULONG_MAX >= PT_VADDR_MAX && get_random_u32_inclusive(0, 1))
+			range = &upper_range;
+
+		start = get_random_u32_below(
+			min(U32_MAX, range->last_va - range->va));
+		end = get_random_u32_below(
+			min(U32_MAX, range->last_va - start));
+
+		start = ALIGN_DOWN(start, priv->smallest_pgsz);
+		end = ALIGN(end, priv->smallest_pgsz);
+		start += range->va;
+		end += start;
+		if (start < range->va || end > range->last_va + 1 ||
+		    start >= end)
+			continue;
+
+		/* Try overmapping to test the failure handling */
+		paddr = oalog2_mod(start, priv->common->max_oasz_lg2);
+		ret = iommu_map(&priv->domain, start, paddr, end - start,
+				IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+		if (ret) {
+			KUNIT_ASSERT_EQ(test, ret, -EADDRINUSE);
+			unmap_collisions(test, &mt, start, end - 1);
+			do_map(test, start, paddr, end - start);
+		}
+
+		KUNIT_ASSERT_NO_ERRNO_FN(test, "mtree_insert_range",
+					 mtree_insert_range(&mt, start, end - 1,
+							    XA_ZERO_ENTRY,
+							    GFP_KERNEL));
+
+		check_iova(test, start, paddr, end - start);
+		if (iter % 100)
+			cond_resched();
+	}
+
+	unmap_collisions(test, &mt, 0, PT_VADDR_MAX);
+	KUNIT_ASSERT_EQ(test, count_valids(test), 0);
+
+	mtree_destroy(&mt);
+}
+
+/* See https://lore.kernel.org/r/b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com */
+static void test_pgsize_boundary(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+
+	if (top_range.va != 0 || top_range.last_va < 0xfef9ffff)
+		kunit_skip(test, "Format does not have the required range");
+
+	do_map(test, 0xfef80000, 0x208b95d000, 0xfef9ffff - 0xfef80000 + 1);
+}
+
+/* See https://lore.kernel.org/r/20250826143816.38686-1-eugkoira@amazon.com */
+static void test_mixed(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+	struct pt_range top_range = pt_top_range(priv->common);
+	u64 start = 0x3fe400ULL << 12;
+	u64 end = 0x4c0600ULL << 12;
+	pt_vaddr_t len = end - start;
+	pt_oaddr_t oa = start;
+
+	if (top_range.last_va <= start)
+		kunit_skip(test, "range is too small");
+	if ((priv->safe_pgsize_bitmap & GENMASK(30, 21)) != (BIT(30) | BIT(21)))
+		kunit_skip(test, "incompatible psize");
+
+	do_map(test, start, oa, len);
+	/* 14 2M, 3 1G, 3 2M */
+	KUNIT_ASSERT_EQ(test, count_valids(test), 20);
+	check_iova(test, start, oa, len);
+}
+
+static struct kunit_case iommu_test_cases[] = {
+	KUNIT_CASE_FMT(test_increase_level),
+	KUNIT_CASE_FMT(test_map_simple),
+	KUNIT_CASE_FMT(test_map_table_to_oa),
+	KUNIT_CASE_FMT(test_unmap_split),
+	KUNIT_CASE_FMT(test_random_map),
+	KUNIT_CASE_FMT(test_pgsize_boundary),
+	KUNIT_CASE_FMT(test_mixed),
+	{},
+};
+
+static int pt_kunit_iommu_init(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv;
+	int ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->orig_nr_secondary_pagetable =
+		global_node_page_state(NR_SECONDARY_PAGETABLE);
+	ret = pt_kunit_priv_init(test, priv);
+	if (ret) {
+		kunit_kfree(test, priv);
+		return ret;
+	}
+	test->priv = priv;
+	return 0;
+}
+
+static void pt_kunit_iommu_exit(struct kunit *test)
+{
+	struct kunit_iommu_priv *priv = test->priv;
+
+	if (!test->priv)
+		return;
+
+	pt_iommu_deinit(priv->iommu);
+	/*
+	 * Look for memory leaks, assumes kunit is running isolated and nothing
+	 * else is using secondary page tables.
+	 */
+	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
+			global_node_page_state(NR_SECONDARY_PAGETABLE));
+	kunit_kfree(test, test->priv);
+}
+
+static struct kunit_suite NS(iommu_suite) = {
+	.name = __stringify(NS(iommu_test)),
+	.init = pt_kunit_iommu_init,
+	.exit = pt_kunit_iommu_exit,
+	.test_cases = iommu_test_cases,
+};
+kunit_test_suites(&NS(iommu_suite));
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Kunit for generic page table");
+MODULE_IMPORT_NS("GENERIC_PT_IOMMU");
-- 
2.43.0


