Return-Path: <linux-kselftest+bounces-44739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D959C32ACA
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE32422EF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C2B33F8A5;
	Tue,  4 Nov 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nup93D3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4033EAEA;
	Tue,  4 Nov 2025 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281036; cv=fail; b=d/+HKGLYGR9j7YECGZS4yjK+0/YISIp+WklOz0OcNkTPH/MR3B2VnYEM6oXFnZXudvrFFNfroWLXl+zw2tNav6LWtx900ZY73AUUr52QvXOnzeLDD2JcyXjgfep8l6M9U94A0Tk/n9qFNHqTlZ7fOqAi1wudVcqUAJ55crq8x68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281036; c=relaxed/simple;
	bh=CI0xk1/NBD4ANpsNyUx6V0dQJKCguhu047bP+8fTC+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYEnFaSSzW2x44OYMGHNLZsD4dQyU5B3gN0BQzTDSKJHDf8DR0jpKCNBPWMoehQHNdHftBHB6abApQ/S7hNoU1xqe4FJOs3S7lMPXb0OMDkC0Mnl1JIo6gq5mXvyT+KNwcXGnjMe1SVZj93s6rj7zuUr1fQ29pByYDhIYUp0+SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nup93D3u; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcmpKk3PAVVqbDi/8dvQ0M2xK/cFAs69LVe3+C9iG9oxwV0bgclozK0Aa+JjNFPYdJ0734eTM8+Jp7uB1Xu5/Qo/k5J8ADwpb7yxbaZsOs6EWC+wOa655IwCM9kQaSftOz3yJUfNPJ5iddp73I26FStN6fByICE4jy5cvKYJTn50WWcXv0EMMpaYbKtqBm3PFodcs4C+04ZmnvmGpEHAyh8AhPSlwvodZVSsu7FfTdrx/3MQNqGzE3+qEq2cki0TOHb6UVIGCFIYasVCd+7WNYRZltFinFEmF854P8fd4eRT1ZvWQU6cFLOHd4tsgyXxpNVskQ5UJREHt1wPZ9XdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5oPLcXlvDNQeU3+CT6x4N6GSOiy6tDuUeh08IKa84I=;
 b=JiNrwLzVDBEfsTsn/+YtZ/rd3BIaw2ozBNIQLqiPen8sVRtIHUGRkv+x3ujYPwmjgbkdX+kkuCWvJ8ZR3zIGPDOdX46K9gUPgGEmPsCPNMrzA6q814Zy4cyeBGmWOZl1FyOUFyOZ1FxzFM+Uacouk1YJI0BMJRtDSkHUgoPKuBs8WjxcfAZehTuACNE1KEU9bmHvxYBcQjbPMijigVhv1Sxv3ahK5htKp3goHFCW3BniX3rs5DRqlevEX+LOf4mT2J/d2E7dINWNhY5HSn9qJR6XQ/vMOA1pfC+PcxdcMbnDFgMFJqxypzu5Je0iJ7ORzJTIbozvL6qpTrdpfxnoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5oPLcXlvDNQeU3+CT6x4N6GSOiy6tDuUeh08IKa84I=;
 b=Nup93D3ufkvAK8fKgoz39AKGl/yI4V6Q1bAaRrhwL9Su7KsUBBMeAG7SIdpoU5qSQf+jhp6ka1IWWKxPfT0XZjwiI5h4RWdO81ppMnku4U/AFOt1TxpeU/elHEuCq4r3M3iQmLkZrsbSwnlkD93S+kOiTQQY6hqYWSem1kAhd5TTbsAbPv3d2YT+UTIeuXli4iw2nOCGJa7rgBl8ycWZyNH0bgsmeyNpTbMM04fSYgVdJe269TUeIQKdv+lzz6F6GecQ1giVfFanscR/wsGxTHuFrqg6FSMMT0Rs5kRy6ubwMbI3FQDNlTMNVD0NipNGTa+hzoBO9R8gA81HE1PRuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6302.namprd12.prod.outlook.com (2603:10b6:8:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:30:24 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:30:24 +0000
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
Subject: [PATCH v8 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Tue,  4 Nov 2025 14:30:08 -0400
Message-ID: <10-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::30) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 516f8398-b1d3-47e5-2f2b-08de1bd03437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aa2KoSfILUkKM4teGtN2L79mV6xO+UuxzjTkveyyUQRQV0AYtoFen1DKPGid?=
 =?us-ascii?Q?80ISPgPjWrtFsP4+mSbo8JSewKxfRNcxpLZei5YZBT/xT4BoyU3wKppTXEt6?=
 =?us-ascii?Q?Rjgh1hh29kNQ9Xg6R7Qs5Ssmkj0tlO+DMYG8Soyv3IMpCZhIRgFDtt6/uwA9?=
 =?us-ascii?Q?VaqTfwWZqYWNbMU2oPSvxsWAsqvzXqt+wSrFhfipGcHzXE2E89DldtdxihDB?=
 =?us-ascii?Q?KwXIPsze7F71iXo3E2tjrGBTASrxaeZRsUKF5E74SW3a+f2D4P2HYhZ6ydYS?=
 =?us-ascii?Q?oejeLaHgz3xkHnAAAA2no8xBs8UlSctgGmeBMZgcoOAtkzLClJA4Uo38HZQo?=
 =?us-ascii?Q?7T4Wm4guLDcDXtAKJSZH/GEj5GjJ+M8bJAlo+hiaUMqkRhTSl1u4o07nBrTz?=
 =?us-ascii?Q?DFZmWztth0ahsgiNuAFc1dhnWVeMqv0kTUV4+LbpANA3Z4EIQdaEzXUA8DpQ?=
 =?us-ascii?Q?fLVI/8iPFwBtyZg9d5DNGPP6lTa0r3PaGEgEznrIFMtUJAAwfPPAmzmUfj09?=
 =?us-ascii?Q?gKzQ/+S0lKhoLFsz0jZtEkGq7yO8sJJPvFg7rL6nZVii89Pn+pGgLsKo3XQP?=
 =?us-ascii?Q?kTyUcihobm/HfXWcE7QmJWmO1Mh7e3KZF/rSxuMLE9obFjBpfStNEwgLEHmZ?=
 =?us-ascii?Q?4QjVqYAS8R+GnI5cKmBtzq9Rc5jtEcENestTgRW6kf9OpUjRMCb39hxbZ6IH?=
 =?us-ascii?Q?ZJKLBvWBkDneUViiRVxU3Yk7ih2PFG2ITvu7YONYYN8tfbF8kcR+OiPPpO08?=
 =?us-ascii?Q?L1L4VC/SpwjzZcT3NdWLrURji1kiR36+rwdmyvVYi8v3fheaWCltlaw+c/zE?=
 =?us-ascii?Q?wd0SrvP0sTRXXhXPtJpRX5FhLVPbpVedXta3x87oOd3slWcdAkxS4vnnLM0V?=
 =?us-ascii?Q?P36rebpGujLRQ0NtY4ccSv31Cx5mMndlXymoPECLtHo1Oh91fkcg5bcgK+34?=
 =?us-ascii?Q?KvZe6mSE1DvKNx+zl6taNOacuKvIz2HE7sfBF6hB999W8zNFz1rTVAQk3fT7?=
 =?us-ascii?Q?ubIYdqTtziv/1thzOf9k2DHQzKJca71RztzQ0vAJMq/CXCTt4aksMCP3d3Wi?=
 =?us-ascii?Q?Q0pI/O4u2OkUZ4Tk56iIcEhz/fD0dQQbAZ3vyMppq2xeo6BNx4vCiSdCXi7x?=
 =?us-ascii?Q?bdYsSRYywWpU3FArybK9IPqAdk4JXXrQTewaDzgJMQeSctUgJe7WrWqNWNmd?=
 =?us-ascii?Q?FoSFD7zQpjDA+fBb7DFMiw897ig2Uwfe4DxIGO2TZmoLf278WlYaOL3gu8DH?=
 =?us-ascii?Q?WGcCqazNsGG3EkPneWKRgJ6AeWUlbE9X2jYLURSstFtlqlhdbKL1qa8b/KhT?=
 =?us-ascii?Q?Di1CK4AyGcpGIs7sqBft2qcNINu4X8AzsLZUw3wDbBR2PtUBTWZ78IJ/YRme?=
 =?us-ascii?Q?ENe+0QXAobU1YBvCtz+woBkvtiyDaaEbHQPYDZMQVAz3G+aukcYD9l9FaVh9?=
 =?us-ascii?Q?gczdPsSSQHrLUoXixuoEc5Xy7xgMl7OSePVFA3sbsi+InKUmtnVjO4twoVxX?=
 =?us-ascii?Q?Qa2ZoL9g1MlJeIQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/kBsdZi+MUjWpBhQEex9ulFGFqZbHKlpRRQNlcGm7BSWnki8Cio7th8peSB?=
 =?us-ascii?Q?QlEQN0n0zQm1Im/3xtcggvztmtM+SOlH23upGBVclwr+zKPHk3TflluCtTkG?=
 =?us-ascii?Q?JVS6VoGZ9s8O9w0f/PqL2MBzsZqAUo0K4JO6DasygKXPZk4cexPcKQsRUViB?=
 =?us-ascii?Q?Is4wFr4OlFefaOhlvhDWXCpCVr6/lmxedMEJDoDPxOouPZoiN3pBn2oPRNPF?=
 =?us-ascii?Q?LPGLrN8N/UeCOam+0e4QtqCWhV8H1JanELd4wZbjhn0ad8k1sjUyh12YF9QV?=
 =?us-ascii?Q?rhzQXXnF48HehfLD9LEuQHqQNU5TmG2g5GilBi/PiheTJTgxc3Ymg/e9FRmy?=
 =?us-ascii?Q?7xVSoGBvk/KQYcmJdzkzk5QUedDsdayHulaYq+YjREA4T5mPzG/ZBiZUtg1T?=
 =?us-ascii?Q?t5bhBYdLITfdOObs2rm10LRRh9ZkslgysspmaoGEanhFf8aFqIVnRNUIHtfZ?=
 =?us-ascii?Q?msVILqS0XaNsIMjY2eygXjz+UVV7RooHw7StocrK1V3GRFzCd87GDHdS/ArW?=
 =?us-ascii?Q?b99iMtV/k1N9aANSzGozuwws5R8Ft5uPWr2ZTgabXaKKNYvb2dviZrfWd5mb?=
 =?us-ascii?Q?QBgcWZhPcY3rERuIreCjDdj0ci8ayujePpTDNKW0/43kzrLU/o/oH1qSF2ls?=
 =?us-ascii?Q?gSXh0UfCMUdX+hTbxgpNkc9OX/PbCnyVFoVjNZ7aTOeXYImaXt9u55VoESHx?=
 =?us-ascii?Q?tnKVVmhPUDggV69hvep/SsRdU/zbQGQ058ubYWY1Bd446GcJXi6YtEVyhlcQ?=
 =?us-ascii?Q?Gnqe0xHaWLLnl1mUF8RiDTuXI0ACp0HOg5jmbL5MshUvtTVQVqYhBB50znDA?=
 =?us-ascii?Q?0rVlBTmk8BwO/9n9dUb1RLsbWCScE1heXsz0YXzjTK0FHoxto0b2OidGDjyA?=
 =?us-ascii?Q?hly5LItsoztKaDPpOX8ePLbzSVWDDWx3X95XQ3ie+m6oeLEA7kepOnieapnE?=
 =?us-ascii?Q?aJ1OWv7C/Fwdlm058Jg1xE6uPgwc3qUwjdUAhanM/RQamuafeVCqwFw288ke?=
 =?us-ascii?Q?OJLCi8CrB3u61SyYll2CgMUjCQDNOR1k5k/cujDRk95NMYM1uopo3Vb632ui?=
 =?us-ascii?Q?Ut5v80Pw1oc9mU9xghb2qA59Kc111x8cxfb7BU3fyNqewUCnlFu5Q7NRXiLi?=
 =?us-ascii?Q?Nm5Dg68PtqgdJtQfgflZN200iRsJLILv+XO1TpA+O+XDYTaouD4H6EHy7zWN?=
 =?us-ascii?Q?C5T48berJulWrCAVZ14t7Np/lOk4A9Yo/XEhuwvmPFufRUSIDcgAmVwOC3lO?=
 =?us-ascii?Q?RGAWY8VasHwQDmwPXiSwYitSi57p7NAnUbMB+zGq+OibWy4H+tKse/bXf8Ec?=
 =?us-ascii?Q?tw2zrqiqj3RXmhqjasduL/2y8MmSI+J7ZJtlLkRrDEMslptzVTmKMNHd2/+B?=
 =?us-ascii?Q?rTKFwFJ2nz3+/CJ2+ezubzwEi0MuHIICpVHICS3a/gxS4qF/NyaKxZpv/r8d?=
 =?us-ascii?Q?GRIwq1PVZeQCNzcPgSmMe7Ljy7v/UVNuhJOg3Sm5JCjhwbui059pr9PC+AEF?=
 =?us-ascii?Q?LvRzRRm8tEA6DHcO6tCOWCfuVqWknF907v+vvKZ++Iwg/x0EqnO7n8X1p3TZ?=
 =?us-ascii?Q?8qgi6OWK6pqkujAxFBQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516f8398-b1d3-47e5-2f2b-08de1bd03437
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:30:17.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mn0QomEwsi9yYmxb4Q/YOllMMoEeLj776ed/9e5x/exm3GsK69Jnwf2V0UFoFrle
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6302

The iommufd self test uses an xarray to store the pfns and their orders to
emulate a page table. Slightly modify the amdv1 page table to create a
real page table that has similar properties:

 - 2k base granule to simulate something like a 4k page table on a 64K
   PAGE_SIZE ARM system
 - Contiguous page support for every PFN order
 - Dirty tracking

AMDv1 is the closest format, as it is the only one that already supports
every page size. Tweak it to have only 5 levels and an 11 bit base granule
and compile it separately as a format variant.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/fmt/Makefile     |  1 +
 drivers/iommu/generic_pt/fmt/amdv1.h      | 18 ++++++++++++++++--
 drivers/iommu/generic_pt/fmt/iommu_mock.c | 10 ++++++++++
 include/linux/generic_pt/iommu.h          |  6 ++++++
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/generic_pt/fmt/iommu_mock.c

diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
index 32f3956c7509f8..f0c22cf5f7bee6 100644
--- a/drivers/iommu/generic_pt/fmt/Makefile
+++ b/drivers/iommu/generic_pt/fmt/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
+iommu_pt_fmt-$(CONFIG_IOMMUFD_TEST) += mock
 
 IOMMU_PT_KUNIT_TEST :=
 define create_format
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index aaf76bfd21dadc..aa8e1a8ec95fde 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ITEM_WORD_SIZE = sizeof(u64),
+	/*
+	 * The IOMMUFD selftest uses the AMDv1 format with some alterations It
+	 * uses a 2k page size to test cases where the CPU page size is not the
+	 * same.
+	 */
+#ifdef AMDV1_IOMMUFD_SELFTEST
+	PT_MAX_VA_ADDRESS_LG2 = 56,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 51,
+	PT_MAX_TOP_LEVEL = 4,
+	PT_GRANULE_LG2SZ = 11,
+#else
+	PT_MAX_VA_ADDRESS_LG2 = 64,
+	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
 	PT_MAX_TOP_LEVEL = 5,
 	PT_GRANULE_LG2SZ = 12,
+#endif
 	PT_TABLEMEM_LG2SZ = 12,
 
 	/* The DTE only has these bits for the top phyiscal address */
@@ -374,6 +386,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -384,6 +397,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 	info->mode = top_range->top_level + 1;
 }
 #define pt_iommu_fmt_hw_info amdv1pt_iommu_fmt_hw_info
+#endif
 
 #if defined(GENERIC_PT_KUNIT)
 static const struct pt_iommu_amdv1_cfg amdv1_kunit_fmt_cfgs[] = {
diff --git a/drivers/iommu/generic_pt/fmt/iommu_mock.c b/drivers/iommu/generic_pt/fmt/iommu_mock.c
new file mode 100644
index 00000000000000..74e597cba9d9cd
--- /dev/null
+++ b/drivers/iommu/generic_pt/fmt/iommu_mock.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
+ */
+#define AMDV1_IOMMUFD_SELFTEST 1
+#define PT_FMT amdv1
+#define PT_FMT_VARIANT mock
+#define PT_SUPPORTED_FEATURES 0
+
+#include "iommu_template.h"
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 03a906fbe12a83..848a5fb76272a9 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -237,6 +237,12 @@ struct pt_iommu_amdv1_hw_info {
 
 IOMMU_FORMAT(amdv1, amdpt);
 
+/* amdv1_mock is used by the iommufd selftest */
+#define pt_iommu_amdv1_mock pt_iommu_amdv1
+#define pt_iommu_amdv1_mock_cfg pt_iommu_amdv1_cfg
+struct pt_iommu_amdv1_mock_hw_info;
+IOMMU_PROTOTYPES(amdv1_mock);
+
 #undef IOMMU_PROTOTYPES
 #undef IOMMU_FORMAT
 #endif
-- 
2.43.0


