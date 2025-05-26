Return-Path: <linux-kselftest+bounces-33811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077CAC4356
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 19:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D89C177426
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAC23E35F;
	Mon, 26 May 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JC0RsW1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB023ED63;
	Mon, 26 May 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279707; cv=fail; b=dvgdkKiyDayx6R9Ud9W8bi0/gEiZTfKBKsKQoW6FFcMx/73oRVkZPALI9HIVMRO9dpNKk1cs5OCBOxELLDIhNheJMZQbK0oINvvn+BUorR2XAy85m7ecEHoCen+rOpC839Gs7LvFFJsHaQCCCQDU4nAJphAud4oPjSRMc+vnsQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279707; c=relaxed/simple;
	bh=9Czl3ZsMFAgPhu21sqho1ibzPi9jQtVLeF+c0iz1rt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0mI2HWX7yd41+yR3gP8YiEsWmgSW77cCokPukobSmUUVdD8DGG7vdPMQnChcNArGBxpmSZ46USGqDvHZKfaEfBosRzDSmsHA03dyx/ctSSUtWXVwE9diHXrulOqFAGhQqZzx4mPK1Vj7JLYFXinX9yaual+TDKZA/Cbfs/5Um0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JC0RsW1N; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+szqpAGhi4tZP9eHm1cdwPSk+/xY+01pVbCV1GOWVjhcMHYv4/Y5cn+b3J/Lw6/0oohueNU6/ffCMLucUcNsWdpAFwEtXW/ms6jHekHWctwgnZVgD7sIhnim3dZS+fg24G/xYv/OINE85xSexKzsSOrHOQVtITc9N31nXcvZ5ubx+KQQ61fhEhEeRpT2PTmNqB5sQHN8ndGxrW70GBZ5jsafXlFBSBZf+2pJw6iBbW7Ph//XswnNyzD0jJBmGHCVZNv5t4IID2FeX+3DB2Kq/+VqLBSgaYLOGmZ60nYA1bFQmOypfXI4rKs1MrUdE9Ene8i36IqL6QQm5onlGkJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clZ0xLzV+ywFGGtaWE5ETeUb5Wn/MrtgjKaBaSNFoY0=;
 b=sukhIznzK+nPgRc44Ng4xYpHSVQIuywOtUf3IWhxtJoZzdUVnouULN/28URty2MZJapYDOD43gMOrcxm5Ma2YH8EzFFD09aN+I8qynGmt3aF/NBkzeaBBKHKiTF+3geyqFg6YmXrkhkm7clea6VEsfMX3H8fSZGfVqfYkslqaHUVrZSjXoKXYn+Zbmwq0PTN1RMkRd+1b1Xz4daEed21s2V+LO5cdghYBTgFkDwIQbenYCgEM8h6RCsHwqqXMaPG+pmlmVit3fWDxOjHajSxWx+FM3yqkM5h+nCZdvE1RnYKKWvpBAd/wbYWbxON9e2PNdOWMD3XbjZ2qlf9XmrYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clZ0xLzV+ywFGGtaWE5ETeUb5Wn/MrtgjKaBaSNFoY0=;
 b=JC0RsW1NGXMV9Hu6JI0eS5IOdukmb47ScCAT9bxET9z4oafvJD1oEjAEIaNVhJhxTKdJfkrjQMuLCu/mBG/hPT2wldHdTE9ta3sT1ufoSWKCFFpEUapfpu5OCTU/vNmLsOSFrT4Rqygm3W+l0AwF5RO+6NQNj381EgffT2V9b41iTTJeyiGwnwskEq/9jZsvue7+V2njBOHdsTdLznHlPKi32Vl+qQ8+lG5a3Mog+ZL4g84vD/7OXqVmfpNKgBx4gXKqbYJ6wKeJuN2TRlegjOuGBSxsrBKBuKKzenC6EZN0nBcxHPMK2irhfuUZRq4RZWKe0mtKktkK+s7SKt4jlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 17:15:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 17:15:02 +0000
Date: Mon, 26 May 2025 14:15:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	WangYuli <wangyuli@uniontech.com>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Auger <eric.auger@redhat.com>, Josh Hilke <jrhilke@google.com>,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>,
	Vipin Sharma <vipinsh@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 07/33] vfio: selftests: Use command line to set
 hugepage size for DMA mapping test
Message-ID: <20250526171501.GE61950@nvidia.com>
References: <20250523233018.1702151-1-dmatlack@google.com>
 <20250523233018.1702151-8-dmatlack@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523233018.1702151-8-dmatlack@google.com>
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8ea18c-0ea3-4c97-e0f2-08dd9c78da27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?porL4DqdTKj+RqkX/EwaqT3aACs9/e/wIOKLchZ4KafjDHxxO/aUGDW/Bits?=
 =?us-ascii?Q?FTQLGjzY9ZBCqVdYtmWh4+Tmt4BHG8nuCG0lxe5qrjX4ekZmkIL83lKfvXmD?=
 =?us-ascii?Q?uW9MWD/9n9y/jdSsiexH6xVsKoQ4+TbE6MGWGGiOGLkKfMBNaM/UdHyLrGg5?=
 =?us-ascii?Q?VJCI9btmnLKtBAobF0+PEiSZi6xxCe9k72Zh2pssLM2SkwkAjrbebPt28EK0?=
 =?us-ascii?Q?v5AvOB5bQHozv8zj5GwDmWipGbJI8cbl2ZDHR3j0v9lpBviJU1ytm6SIUg8C?=
 =?us-ascii?Q?RP83IPSpaQ03h+ybF3+VpmcqrTPeYtDIFmLQbXhy/CdwrMFI5igdrTYPK+/0?=
 =?us-ascii?Q?0TeRBzTpRJnTJij4W7D+QnyemfPCQdi+QBaly0UULkpxHtrRcqxNnK5BBUKJ?=
 =?us-ascii?Q?1/fXVhmhmV68rCi3cCuQUd9kgFO+kBUFpWkpjbXtatNB1ywdtzzOWGgd4sKN?=
 =?us-ascii?Q?0AQQtaRslLkhBZQeA6Ld5DbOMsmnu0VjJHCVx0vsHinnX9wWVbdmVGo4xJHF?=
 =?us-ascii?Q?MYle+ezaXfc5sW2hZbq5X+LXJy2tDo43J8A2QtYGa7PlmTM9IFPn9j+3OIv8?=
 =?us-ascii?Q?C/84JBBRVfkyywCcAfdRDE3MvxICkkb7oT+CyMYcZY0q4x54dU/4CxN89ScI?=
 =?us-ascii?Q?UOsyKEQRLBS6T3aqGlC348oCN6CnOdmLt3ilOuS7+QXmJALCag3xPRJpJ4P8?=
 =?us-ascii?Q?HzJ+P9UuMVLPJQBJrVC901m/e3Ban40xrnFe3mCnVb3bj7S68K0lVKH7l2Nx?=
 =?us-ascii?Q?4P8nfbQLQ/DRzO67sfJ5/fUbMpp+K66X6yIL9lAQOptGxFc/77flepRcNkjP?=
 =?us-ascii?Q?+hr+YbaQ+xRy3ie7p4ZAns49rIUJAaPnO6xwSG8yxsA0eLGGTlpIzw11wFtJ?=
 =?us-ascii?Q?32QAFxuiPE9WHC6GyzGJ49CjGWHnXM0B7hKxPPNopwab/5pMzlsbAEoYkWTU?=
 =?us-ascii?Q?dRbbkcGK4uIrqlTmExxsoskRe6h/ZDxsjI36SmCLXa294TGGjl12pLhlY7Dz?=
 =?us-ascii?Q?1gI9EqbrmsSGY+qVQf/Te48FwlILWXXJcAos7QfMzne27e4qfVgbmucVMv35?=
 =?us-ascii?Q?Gol5z7SJg5sjWPbZesnB9e04yD8JNQ2nmcNS/cMXMdR+OA4FQHxzz+UvKeS0?=
 =?us-ascii?Q?B1CIAe6qzyNK14uJlw8HXB3D2kSwb0ESITnZYa323UrwVHWn4/uopCGP6vR2?=
 =?us-ascii?Q?rbZSKBaXC8rr/Vmg6YKYApEOXGL6d4v6J9P9PNGLTZ3AJIgs5dI1NBhB1Lqs?=
 =?us-ascii?Q?VNMX6h9Seqcev/3TKEvDhfLCbJ4iMXHXEVbRHEreQVt5ZQW/F3fG8zpo8tFk?=
 =?us-ascii?Q?61r24czR6qMbmK/3GIRDGR91wL9F7H56zc+d1SWkDRfKVT243starkOl52uP?=
 =?us-ascii?Q?FGxUX4dODNLe4+ZQGjtgwuHK2u9MWSnLpZi4F5tgc2KUeDv+Dg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sH0Iv9v9WLBXQNcSARJryEzQLl7A8MUTj7pvZcQ5hIuRIKtjFmIjgi2D/6ot?=
 =?us-ascii?Q?yPZ54nTQMqCVjEGEV8cPBy/KdkSnVxfQOiivdsBv1rPcJrlTGWYu/bay1IPG?=
 =?us-ascii?Q?K7SaT70euxe9zQVwMN6e2gT7oPHTpfAIPnArO/aQnoobxQNPKZsm6y2L42RY?=
 =?us-ascii?Q?ZlQDXojuJbeOIPyW/wLZ8hFoAU2ICrq8+sg7d/Z3GQXeyLokOjpPcGsbK1PV?=
 =?us-ascii?Q?sPr9s6iV3cC5W9AtHS65R8JWe8ImJB7JRa3uPa0eMdiMgII1iz1Q2F29bgXv?=
 =?us-ascii?Q?jZo08gSMZMCOCS6vddTO+FUIy4ogz+B7mTFzfzIK3ZDKoxFvWXnJ+DM8NbIX?=
 =?us-ascii?Q?xpCqnbg5NyrNBU3ABaoQtezN6lyaRhPRXpV0ixqQSbCQOybPWIqQnTHif/gc?=
 =?us-ascii?Q?OeL26haGbNb/Csbc7clI+RCJ+k91wDiL6KQv82LdOgQAEsi53lTJ3an936Mh?=
 =?us-ascii?Q?G6vtyV2q9zuGJxKYBVWT+TUD3LxN+3Hb8qsB7txZMqVQgNDHpuXKmZKVtOMN?=
 =?us-ascii?Q?dwrsdJumw4Ub73KXocznR8x0yQA17xwHbHYcCHovCGB/yIX+p3N/S546bNZT?=
 =?us-ascii?Q?CXi+dQj1kpLjk57w5DnERfJtGB62aaJGi7ux2PACx7LgwAfVpdSOAM4NeJBs?=
 =?us-ascii?Q?xRImvpX5K9sdv/6T3V4D+ZpbF/gyoocWeVTtRVg/EQyoKcDetIwQxCDMIkWc?=
 =?us-ascii?Q?iLjfqcefZE3i2FhCq1AABJUK50G+d9FyOFsEBWJWCA9K+gPbqrevRbwUabxQ?=
 =?us-ascii?Q?1/l/vddPo6KdK83ml/9NSQmXFtSsyCO4KKJ1rGmhinJjT+DHm3Huv/b7A+wX?=
 =?us-ascii?Q?PUc6kEKNd0rDKDo86JGA6kwFwvGfyvChC1r1+bb+5dTxW/vN5RWJRcfOyh7w?=
 =?us-ascii?Q?2HTujP1cegLqLZuE7PjKMZKfS3qNZwSblltFTuhpIA5c2OG1YjXDN87UUeWr?=
 =?us-ascii?Q?ARLQOEkMY8aRH5l+nLfeDR0FKEI8bWhByCoc92j2VL4KcOVcMZNqgme+lEYi?=
 =?us-ascii?Q?aY6eWdP6Ox8nSC9TK4ehu4tbMLwwOcVQjUPWVyWR0ntPKa02+41gBqo1tk8n?=
 =?us-ascii?Q?ha/0RHLP67deTMnd7GK0ZOdxsfkEAz3xlvRXKg7QDpuFYX8LoZuTj5fpd5AC?=
 =?us-ascii?Q?BSIUthbOhcsPG0YZPyGho2u8fNgNYabuYhkyjSizt5aTQKuQYguPaWdZg8mG?=
 =?us-ascii?Q?mVpx7e8TX3WAGtJGUSfuLfLRvUdWXAsVClLNro6Hf30yi7YidBbEP/0TK1mY?=
 =?us-ascii?Q?/r45lTW/dRxY+PY6vo8LsGFX62/VUp1GovmVuFhVUvD+2yW4ZfR+9zE293f8?=
 =?us-ascii?Q?D86IiEN6AIw2HHmKu7zFvOeAO9/neAb0t3UtHxmwtR+2uGkguRZpKVw9mqr7?=
 =?us-ascii?Q?n7I0svZD82cc6HTVyI41GaIK30aKFyTehNbNgNwqBqqSHbHPlSqXMh9Ls0FN?=
 =?us-ascii?Q?dQyoQW0kL0MfUigqfgwxfNIhwtblsVaxRC/22Uoice6EmRpNRFdXVTJWTFMH?=
 =?us-ascii?Q?ElMhwwh+FRak8eA2PL9FRCjY/VYVZpnArM5QwfC/8RGgJoH4u8qiJkOost9c?=
 =?us-ascii?Q?wkPY46dCPxT12A5KjxAaag+vU5nGRcFdwAiS6p3x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8ea18c-0ea3-4c97-e0f2-08dd9c78da27
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 17:15:02.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DmCQhVMp1ZYwdl9quBbYQ6S5T9R88yepzHHMSR3eS3Mr0+bEncWsh3YiqIcmuH3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

On Fri, May 23, 2025 at 11:29:52PM +0000, David Matlack wrote:
> From: Josh Hilke <jrhilke@google.com>
> 
> Add a command line arg to vfio_dma_mapping_test to choose the size of
> page which is mapped in VFIO.

This doesn't seem right..

Tests should run automously, test all possible sizes using a fixture.

Jason

