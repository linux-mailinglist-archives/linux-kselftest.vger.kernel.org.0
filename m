Return-Path: <linux-kselftest+bounces-43939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C645C02E37
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52ABC4F4BC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B872D2ED15F;
	Thu, 23 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j0d/IV9a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55405277035;
	Thu, 23 Oct 2025 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243675; cv=fail; b=t8Yj4sqxanUzE00HYg0aeGpi1cfC/BrQEz87rcaAyKwrN6OvMm9oqeGaGnjslxyZ6shxUTtEoj4n8exlSTiK56eWIWx72nyw35KjN1sgedVjcW/GgyNIQps/eYUc+/qKJq+OCF7kKQpCeoPlrXXTIQreRsCs72+Uaf56cfbA6pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243675; c=relaxed/simple;
	bh=TICt7o/oprGUp4MJ9lUz4+oop7ze7hn6AHUf5bXmX2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mfii5jHueEb6C6d9ulOhc2G9Imz+5LVycDZW5SzpVnC5qt1NiPItpau3E2BnUp1JLSqmhshvTt/mTtbgFO1NqDh+sRYSp6t+4EuTTWvMrKkIzcCBKo9FfbjQntqQjx7TP6qY05ZPX5UFt5EEJIjYMY+pdXDb7nG81o9R4/P2QRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j0d/IV9a; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHi9vqCrfzevR8j1jiicJjfxel+ASm3gZabmD+QSbJbx7OUlD7cEm4rKLzntsxvXCrf+neVOa60K96NQBa/0czUGy5FhXvWpqXimK/1idYPbXcn57tZU882D7jQHpWyQ89MNlZKS6QFMWxFSGy6PbrZBL4blknytbQw7CnPqMzw7PPEnviuomOPp0unjHJomdYLdzAOeTwGIEzW85hVAjelDXZ0IC0eKrspYCsjngfC7LG4Ps+X8dn+tVq/DgFoxWeHnfa1y4QmcmYh7vFcvEwc4VPhfjS6Gj0MDgJv5h8+HiRkyz7Id5hzv6QbhTWxZ04O42irmKKGor+CKqjNWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qjIuxmJZ3jSW6hX5pjy8Qj2rwSACM2F58bdWWNUwJs=;
 b=UtHa8h5BoYns/UhgjB24Th71Pad/xAQccezo/38rdNL3KvzkwO0viLjRc8GTjwGMLkP7QZNEo/54tKXmSxHiaPG38EWB1IamyvmqVrEjK9m5cpGsxbIvVDhTo6THPQpu6k0CyhhSnRATidcdGWo7kyObhORzWxy2nCK5mh4tV3AAf4dVjilpWHHCiYwPVyk+nt00ZAC9LLNjurVQNCNNWUuyd4WsARDEriiWbZUZv1ho+JlerStYR3Lt7PiunWJNyKz3V7Pj3Te13PVLG2P8TX0tQiy3kjYMYuxeI3NvsiBPLGjeg3tykc8X7NX0nCCvDluudPEycozEbZOu+eCyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qjIuxmJZ3jSW6hX5pjy8Qj2rwSACM2F58bdWWNUwJs=;
 b=j0d/IV9ah/4K60L2eOwzOuGbWlCYughGRLakJE3fvpSicS3vJoxqKKxiJgsy1pIMj4QjcQ0rr9JJp+9T5QOu9tZQ5skQEMHf3cCtLUZrpAO6Xvf3J3rTU+S6rT2kupCrDEUblQbB+HY36RWCYUieFiWMxiOqnXlsucmMtbrvcT2QwRzhapJiGWkXMH7YcBkDwplLYy9qG/IVLZ0lNvUEql/jfnPQ3N+5KFXGhfxuDs4+vcErfdFN37wfN+i267O6YtUiydo6WBJsqk2amJARgvZ2PTrsJE9JnoTQYOilUm+mzP+3OVIJM5V7O0iFH2ril31UQDXg3s7wT153WDlUJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:21:00 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:21:00 +0000
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
Subject: [PATCH v7 15/15] iommupt: Add a kunit test for the IOMMU implementation
Date: Thu, 23 Oct 2025 15:20:45 -0300
Message-ID: <15-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe2ebab-088d-4f47-9f28-08de1260e62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3/hCLO5vzX/CZv2ImtTbUeeXjGvfB122+h0F8TZdagd4FL/kgxFBX3284bP?=
 =?us-ascii?Q?j+8E82om46Hr3Azw5y1BwVcDyvTaIS4GOjAzFxC+PL/0ka3tsqL/250EoFfn?=
 =?us-ascii?Q?/uCRB7E79fs32JUjD1qFljN5I8hikjASqmCmyJtlyAoWv7XWjcH8QkT/X8KF?=
 =?us-ascii?Q?YnDNTzb0XLxGN8lxrHhujACfQ2sZ6gotTfVU2vaW0/mGUaqXP/noPYHBDg5N?=
 =?us-ascii?Q?A1qFByVVQH0kKDnSRnetl4ZKRGeD2A1X0sebkdt9yx+4EoKp/vwbhS7FTI3n?=
 =?us-ascii?Q?LMjXFXHR7RlM+XDLtoXFvzxuAF2Sn34PC8uEgW0z5oRw1RtIc90zqxzlTMQY?=
 =?us-ascii?Q?WIeYWeCsIKcTyPz6q1CQYIXwXV1EW5qiOxr5GrCNi6ttU8NJQV7Pwdt6i14M?=
 =?us-ascii?Q?j1l3O7zekfR3Z73YYXhnd8xKL/VAFLvm9aLWyb8NApdIyNwIBlyTwQnaw/LF?=
 =?us-ascii?Q?ATekfOzmyGvRSS1OMxkpy+W1XGa3NV83jRBwiB1OEGB4Rx5SGjkIS980emcS?=
 =?us-ascii?Q?2aN5KLOxxA4XLSlImxtvMjy5DpaHGMx39T/Aef7nzwtCXQ4EOdmkiBuxk+Gg?=
 =?us-ascii?Q?+o/uedCWWmK88r55D+nsMEwG0tyXmdoQtZF9K5DAoLSObvKhkaPh3Na4k+XN?=
 =?us-ascii?Q?0ixaKOVtTDepRNnEex9ZIpbk/WmhuXIGXLUJ0OavyeW9l4DYnt+exkrVzKX2?=
 =?us-ascii?Q?TTXg3Z7SddYkiAMbVoHh6I4axoYBA9+kAUk3y0xOXcGZMwtV91H+iXexEsee?=
 =?us-ascii?Q?R4pSi1nrqIOYsvNFeVN3IYsoPc34kYIweTFU/fCp4+wEUpfnmT79+3lAu0Zo?=
 =?us-ascii?Q?kQiFmkvbXuginrN63TQ9068yRBkV71GcK92I44RsIhc67nEm+ICX9ozW19E6?=
 =?us-ascii?Q?cxcikN4l5lZBBrlG3JUeCXTD39Vj8R4Q+p25k8Lul02mXHdQoEHtXGnZuySx?=
 =?us-ascii?Q?tMQM659Q349CwKgCi4iDySHxrFhJ02pbJnG1SdwrIcNFFiZ3mdaZrRodGuV4?=
 =?us-ascii?Q?Uo4fmnjmVqzK+s9TQPw4x0qXJ9wfR43SlqnNyZhj4imYdM0VPVYeVjaNoS5s?=
 =?us-ascii?Q?lFT7Ae8PboTsm2HqS6Y19+RCAMiyNd/fOvx6ko9FSRGyf/7H7BLK3aEZmB7B?=
 =?us-ascii?Q?A8gMhylb8fkGp2Z3+bUh7btqCkNOh5UoZ1FgQJ6gXsWEqtlDVWn8imSx24UC?=
 =?us-ascii?Q?xGf1VnHsbNK8fSRd/n74hCnu/ZF2IqFVTk+I+E+2leJ/0qWW6nqZjC0gnY5V?=
 =?us-ascii?Q?lgyj+MyDaiHY8sA+/if67t5Ktt6xUebYdlLc7Zbq3xJgYSW3KVc6ZaqRj0qL?=
 =?us-ascii?Q?QWjY0TNuG0QGBNQH/0M+RBUFsegujOcGMwZOkMxb0lvS9OTrBUPLXD7OX/9Y?=
 =?us-ascii?Q?Tkf7WqLS81P3lVsWBaqKdFRHGdk9mFskqTHC/2V8zuZiaVWzu4SZcimxFT/f?=
 =?us-ascii?Q?Aub+fYVNXyZay6pnldcEfvW4z60H2rQNKHv53BjcgjWLlALIM6GJ7PxIJuqp?=
 =?us-ascii?Q?6RUkJKhXaJZjnoXKJ5O0hTFJyWeOhzY3eZEX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qAQUyMTgfnm6nHZ6vRFDDGjzEZ4rcRK342zKbLrPhPrQRZy+M2K7tlz0pLeB?=
 =?us-ascii?Q?VnEpVu2njQRqT27c7EXGq/U0zSBypXkn+VXJR7S8iEg5KDEObut47SfxTgKb?=
 =?us-ascii?Q?l6xaoc9ANXKPKymI8Zs9H5yWMXnF8B1a2Kk+/wCSe1Ce3J5bNeKPf/NdhCdn?=
 =?us-ascii?Q?1sZ/v6W7BoXJtXJufiPHarCaB5bvoiA5oHdOjShdmzkGQm9KdvvMF+h8Hm4p?=
 =?us-ascii?Q?0iw8aaANph3giUVUzGPo4FXesUd0CDpGPgKifvea87cF21oHny1WKhUqS4qt?=
 =?us-ascii?Q?VCwdTtbAALnMxXcw+JdxVbC3EbM0JdcO8F9j5XeBS7U672Nc3B4lJq32RqPz?=
 =?us-ascii?Q?92FrgmjE6JHCrkZWm972yKKXvRwOKDwxRNGdxC6FOlNeY6EasZWNX8Qn+hvn?=
 =?us-ascii?Q?qCIawg7xjK/st6oa1NT4S9jJ91iUMyU6wHw/2nkgI8F+O8h5bT1ExZL2xMW9?=
 =?us-ascii?Q?jzamhGvNRbOI2cE558FrZMIrKG3S1KfWl6OSVnbl0Nf3hAhcUn5PvA8w9P7+?=
 =?us-ascii?Q?T1XYRsShVO7+Ti2t8RKutCPClDgGLM9Pubcl/pTLCbP/oas+D3i69qtNmvEi?=
 =?us-ascii?Q?NuRLQwGOKXEawThAYCOg+NN//fUPVW/GEJR5TZOD0KtpEiKKi6lESdxAGZc/?=
 =?us-ascii?Q?nklgIfVOQ72BwQuZCZ66ml8/hKcH++CGr/VTy79zKv7asV3UWgBJ3nT5AYSs?=
 =?us-ascii?Q?9LI6eAuthRIAWiiXUHDOR9755XmGw5MH1EkcBfq+De8ngwxGgbU007EmN+xh?=
 =?us-ascii?Q?kfYOsryQ1qo1dopFi2AO/t3zEuxpv8U4xPL5UlTIM7YbUXgL2RNxO9HqPN+s?=
 =?us-ascii?Q?C0ZLQ+WG98JfYmt+b1DzEv2OjiSXXLH8inQ4cP0L+jbirLXWDKl0GhkU8p5e?=
 =?us-ascii?Q?n62nCxKPVc3w6Ob4q1T/SVY9E3Khmyhzu5gUWRmPzFPxeQ289i0DQlu8QDMl?=
 =?us-ascii?Q?lsbMak6SVtu0R+RUMgPxsYcn/V44+rEauJ91ck9jGpYsAGqi/Ao7MgK4iy9F?=
 =?us-ascii?Q?wbiPMVFSTKZ81lQH/7u/PYMnKQ3duh9dFIPFxOGLt7UXHvBz4W1atGnJY9bc?=
 =?us-ascii?Q?VuV+IIvmosBbFMQ6cq5bhBpub1xAlwsFePGUDs3SW47XdHKmRHgbryTYrtgS?=
 =?us-ascii?Q?cJ7xkLrxm+5Qz6uwSfGgR4ttMUn7fOTAAeor1gbwcKHOlZvWclVomOLB5rTx?=
 =?us-ascii?Q?VpGXaEnVsVC2WVVmlTYfZPBxPMldPKJ6twrtlLGLLbu8iPHk4BepROzD6nGP?=
 =?us-ascii?Q?NDe2GGMVWPBzLKFvTiKldaIXI/W/xQIENTL6AwzEJXU/aVo7XlavW0kwTZyU?=
 =?us-ascii?Q?mr/39afCJzqkgO2fXnG8WS+Z7EsDtaTudP+FQFDA7zfVCBq2Ej8EdwUiNu6B?=
 =?us-ascii?Q?uOF4yn1TCRcxFne36TWEnEdkBWdgTlC6FsXTFLYyd+3odOuvB8UB28bIJ11z?=
 =?us-ascii?Q?QXT8dR2oL44tbKXb0ncHSoXxIJ+nSp88NeaYFIO42tC41jjzH28TafruhhIC?=
 =?us-ascii?Q?OttXDbuvO6Viteg0WtNWEr4RjLWFjTOanhy279/HDq4ztlmVbCXcGA2boL7v?=
 =?us-ascii?Q?4tVlUKW7z0NLe4w9Cai9hzprHFS379JWrwaX46d8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe2ebab-088d-4f47-9f28-08de1260e62e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:53.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2lQELzGjJ24YOWFk0F/SkCJmPpHLCmB/YID6BrApDfBSt55xSHKLvXHofdHNZF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

This intends to have high coverage of the page table format functions and
the IOMMU implementation itself, exercising the various corner cases.

The kunit tests can be run in the kunit framework, using commands like:

tools/testing/kunit/kunit.py run --build_dir build_kunit_arm64 --arch arm64 --make_options LLVM=-19 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
tools/testing/kunit/kunit.py run --build_dir build_kunit_uml --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/iommu_template.h |   1 +
 drivers/iommu/generic_pt/kunit_iommu.h        |   2 +
 drivers/iommu/generic_pt/kunit_iommu_pt.h     | 487 ++++++++++++++++++
 include/linux/irqchip/riscv-imsic.h           |   3 +-
 4 files changed, 491 insertions(+), 2 deletions(-)
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
index 28ec313f151e70..d541235632aa69 100644
--- a/drivers/iommu/generic_pt/kunit_iommu.h
+++ b/drivers/iommu/generic_pt/kunit_iommu.h
@@ -71,6 +71,8 @@ struct kunit_iommu_priv {
 	unsigned int largest_pgsz_lg2;
 	pt_oaddr_t test_oa;
 	pt_vaddr_t safe_pgsize_bitmap;
+	unsigned long orig_nr_secondary_pagetable;
+
 };
 PT_IOMMU_CHECK_DOMAIN(struct kunit_iommu_priv, fmt_table.iommu, domain);
 
diff --git a/drivers/iommu/generic_pt/kunit_iommu_pt.h b/drivers/iommu/generic_pt/kunit_iommu_pt.h
new file mode 100644
index 00000000000000..4e388d5e417d2d
--- /dev/null
+++ b/drivers/iommu/generic_pt/kunit_iommu_pt.h
@@ -0,0 +1,487 @@
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
+	if (top_range.va != 0 || top_range.last_va < 0xfef9ffff ||
+	    priv->smallest_pgsz != SZ_4K)
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
+	if (top_range.last_va <= start || sizeof(unsigned long) == 4)
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
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index 7494952c55187a..7f3ff5c5ea5356 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -10,7 +10,6 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/fwnode.h>
-#include <asm/csr.h>
 
 #define IMSIC_MMIO_PAGE_SHIFT		12
 #define IMSIC_MMIO_PAGE_SZ		BIT(IMSIC_MMIO_PAGE_SHIFT)
@@ -86,7 +85,7 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
-#ifdef CONFIG_ACPI
+#if IS_ENABLED(CONFIG_ACPI) && IS_ENABLED(CONFIG_RISCV_IMSIC)
 int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
 struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
 #else
-- 
2.43.0


