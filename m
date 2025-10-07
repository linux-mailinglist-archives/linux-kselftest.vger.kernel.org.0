Return-Path: <linux-kselftest+bounces-42842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E443BC215C
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306624F527E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F302E7BA9;
	Tue,  7 Oct 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LNg6ALhj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AD2E1C61;
	Tue,  7 Oct 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853950; cv=fail; b=sQJ+qkM3JC/kh+qbhLMBepRM9Kb3rZYJqltMgik9JqBSwhT51wDGPmHOubgD4eH4hD6IbnEV4aGrJ+8879aQwRIB1e/axCgR+2cBnKm7odLwbn+XoBdOJ6w9rAUqLF3yLZBkxlsgOLN8plECQmlIPD9veLhX8Ql70vgE/9c+Mz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853950; c=relaxed/simple;
	bh=MPxZhjpaRmo+45FgASKcZKDP8lgzWxBmA82fM10TN8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l4XWzEgHNmA3GtZ1jck3ag9/ChbmDyaSfCk6OmW9lMfpBoTASoAAlFxcUIZ8e8CXv9YoXiqUNZigDuNMKU1T060hN5pOpk+2aTc+4J43aOtObooiwz8/Lm+sSWJ35XlYKzbkNfJ8DZMM7P0BygRNCaIxjIwUIhm6QmosVBgtJYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LNg6ALhj; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6/2wPMJ2HILo4bOE5yeqKBtGhb2N2q2rMoqpHwxOA4rVzNDiau/8pQwFsEkUjhyvcMfHVwnUZY1aTfTr/yknqXT13ds5VVAIFUzicB2uj7z10LB6s0+JKUDQO7QpL4xUIaEndU+QFo3CNiWxyvJbZlxTQOwDg6sNVjMfToW8MHVkzzxCehwIoZMK3sX4pQrE6mC3yZcxotP/Ewn5RJBdM+Vtu6vkbTcUDgkHBUhW2az0mT0hT/HNnW7oR1BHSF1/FcsNN1WHJiTYcVugV7pPq9uJQwNkcrmpjlka0g0noPnUR+PTCqOfU331dOU0A67uBf96dHhiUfsdmkK4mQdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIDsrWKlDGNxR7fqzCSsJV+KMluE0hBfTG0aXxo33A4=;
 b=JBD5jgk2PveBJIm4e0Qw1T5HPCzmNGKxdnJZGFC+k7NkIhUGxTRZG0UyJx6cmHezCYJC3V0sZRnjdfurj8Mm1zKKruQZWd2JvgIwzo0u578TLxmO+f/wHsUqAvcKjqgx1M/x+nKNsU0elGlszqy3ubooVWPkWJolIem1xU+mAtZStgzpWw5m05vgsuuj98q8fLM8RX90vJXpKb6ME0+tz3SbZZ/ZrrANd7B8E/P6j4kfe8BQXnjqXOm1G/tQGSTYbCfaXc/UO//eUaJIK243vgx/T1HSZguHMX0mrnM7i0yBjp2rwlpmsgi7AsvW7almFoQK6fDluq6HJbJXGD+sZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIDsrWKlDGNxR7fqzCSsJV+KMluE0hBfTG0aXxo33A4=;
 b=LNg6ALhjYVUTSRUveefDF/N7yza/eSyBputYazjK6derLckwY8PveIFJRHshbw2IlvZvUK4AC4n5l0Csy+B9N3dOI/lobv6I9dv/lzoc46FcZ29RN9SETrSmNS2MD97+tRPjVE2V9ENhmUXdz5pI7nAMBKv/F7LoQ2CjI9XZ0AwR2xLF30rVtKr3tfdAVRQTDq93yfdSZR2Pd0wNnemPXcswUMgLKq204RvRPul6HAqGTrZ/r7q5PvDylj1faK74V+fcMf2rR/yERXo7wTpze4re6t5/Dvrb1Wm15w1B4KwOzH1DNTqYRjg84pUBsd40Ndqe14CZd3+QDL8Bw1zJTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:18:57 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:18:57 +0000
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
Subject: [PATCH v6 06/15] iommupt: Add unmap_pages op
Date: Tue,  7 Oct 2025 13:11:51 -0300
Message-ID: <6-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0503.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f801ed6-b348-4ade-cbf7-08de05bd379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYrs14ABpFBTHM8gcxWT4cHd1Ys9G7no3cQVsZ8z5QYvQUx+/rNEiwKDsud7?=
 =?us-ascii?Q?8z5c3ZOuWbUFw3hWgJvKJtsDgP0J95z+fJ2GqN+jQeERWzHvMU9gSrliPIlQ?=
 =?us-ascii?Q?IXseUPohpGDo1i/5Woyuk+NXPqkSU+iudibdJJAqTnVGSfphX8U0Ln6TiOhi?=
 =?us-ascii?Q?P2X+HYhvX4/yyli3AC0nmp4tQoOL3Agth0ckKGJUjvWD8W59pkNCkT0WrTbG?=
 =?us-ascii?Q?2mIGFd2SsGWllUohJCNrjaT/RnUhj/mdY70LANvPyZEh7ji163GNwvNv6VBX?=
 =?us-ascii?Q?F/Xw6/eed7mMOT8nxMIM8F661weJRdoUXYKdKwCmz0eLBxkJkJ/odK478bZC?=
 =?us-ascii?Q?7UNXqhJf4zwJ8osKZJESvz/+1zea/9RicPuSudLiFwmchSKnMhDCQkNvmL4V?=
 =?us-ascii?Q?z9qgzQPeitVD+6dVwzzpQ4ujELQ2UrtgMcDMPaSn6xLS5/uG0Ot/juN7F29P?=
 =?us-ascii?Q?4jN5sQ+lHzjzF7WqppLO14qGKDe923/cViiG5SxUSexIygX21DfpzNwnS01t?=
 =?us-ascii?Q?0NnXxNsyC2t1rca+8iZ/YBVyQczkWQoW2AGMebiqJPd12KhDuWJKT9OFB+Td?=
 =?us-ascii?Q?SsJj6Gpw3RC0vpo6kwJwyl/peLWco6ImehbJXxiusNcWHFrvhaUARsYL2jvF?=
 =?us-ascii?Q?o6DT7fPiKlNjwpqxanUZ6ZDSw7FlfdAORi9WUGgf1ldvpkc5SWsbuA+Kmz4L?=
 =?us-ascii?Q?Vo8B3naJeL/FFou4dco8Z9f8a/a+S7phdNNFyWfWYbwhGUIMHchM/CoB9mbi?=
 =?us-ascii?Q?quRyUSdWqyMFeGup4LibXgs22/UXDP+XvNWTS40OLEW/R6XTV1qg5uhG50FD?=
 =?us-ascii?Q?YSmnZBUoshKDMQr8R2Iv85gJqMymPHVshVQJnzCi7hzttokVeVDCPj4/k2p4?=
 =?us-ascii?Q?yHK/ofvUM/hARRd7ZL4Acs5qeWIgpvKhoZrXGF9OKBU1YVo4gkEp984T4QiL?=
 =?us-ascii?Q?1r7IPlfM+pHqjTjov3PLD5LrkeQhjmMAm4t3Uroatx3JagG7g94RvR4CaHqD?=
 =?us-ascii?Q?Jgt9kWcddVTXtIHFJudFdIuCXuEgwv2QgUAOJWHp49fNwgmyl3ZNkvFMGdWX?=
 =?us-ascii?Q?0dUyCJMfTrcabdst74iRLc8owu01laqsTtunutQULzJHhaudZYwBz/6NoIc7?=
 =?us-ascii?Q?wrHM5I2bve6ifmOYX8IlsE4wiqvA/X6lNtWv1olpmTbVCHwQQBFhmGflKkOH?=
 =?us-ascii?Q?oOxk8dqspp7q+KiE1IHJj+kgHUXAspcOEAl0fAocuxy458LmIO859OyE78kM?=
 =?us-ascii?Q?CBGTx+Q+VS8Tody90iko/VIJbTifKR4Wg+Zy6WaPJNTolbJ4B3nnbjF2VFjL?=
 =?us-ascii?Q?PWArYmlu8u1tZXLClYlP6kow9dQMFPAIRm38auysY+lIKRP+NepHw95x+zN3?=
 =?us-ascii?Q?VNNYXCUehdQAgT4ParM4BpEAGNcSpKwPzDN57n4SYlLw+fH0MFDynolP7Ngx?=
 =?us-ascii?Q?be/eaAe0k2/6Hgyd181JuXLA6yHnUSLYshLU3Ls5lzM4uPA4d8rYSWd5CIwo?=
 =?us-ascii?Q?kDVEi3iDFjwGYTE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtpB2X+lzvF7k1DYLCxANZRx3YIB+Gg3/mfGt/sKQ+uGpgyFz4CqkxL5T+Uo?=
 =?us-ascii?Q?WxxBCidTaIoXP0ceMUiBkK76s9pLcKwRS0INSYQW+UsW/49c2wUIcMBxwRh1?=
 =?us-ascii?Q?nJ6T2KKbAye3JJ86LSEt7BBPCpzyiOVBLESn2C59OOxZRQBT0xqRoaD10HcG?=
 =?us-ascii?Q?VVua2lyRzTGaUarHt5XmJ4rDQIA3q0cWP/GZs0taIei8UtZQe/ZM9dX7w8it?=
 =?us-ascii?Q?AECTA9RSqhmgXPBIDm0YiHjwfEP7RNM4dwuqnX1U5wocwTLagR6jCe+dbxAf?=
 =?us-ascii?Q?mWJLg/UI3zyg5iDRVKiFum4t3ul7lhWpGAL2qX+exoXkxBgwQMRfvbd5p/6t?=
 =?us-ascii?Q?p1Sw+rXa2zaswGCU+9ohkZiPUmAnPpkgdesZtfFerYqJmvbzFFVSQ022ZtNa?=
 =?us-ascii?Q?q9vvpzdmO9vBkI5u5KxeQSGMRh1Veae166wApHaEhyCrMlUjD5d5LWVEz2OK?=
 =?us-ascii?Q?N5BG/nC5Yl9wQczrqM19gr+H1mIuSe9zEFRGyzp0LEWLPnCvbb+4ug4VQt6W?=
 =?us-ascii?Q?lkVouUXrmcYTK/YOlXdqz2/mJBx0eVMlEJeZMy4DG9Ww9IJh7/3MXaBAgXf9?=
 =?us-ascii?Q?SfjatNOBdWd0+aCr1Qa9YNk2Vq7w2Qc25yVltZ0j61x87bViXXxsU6c+7Ynp?=
 =?us-ascii?Q?2I22PRn0zReR1We6f+191dgVrfMhxeFi3ksU6Yj0jqYP6w/llqOBF1DzUUQw?=
 =?us-ascii?Q?xQhz1kxTv51ZSaA+mSHFXstfQc+PXAfkqQUXFtBItZJ1wGM6nt13cxi7zGqT?=
 =?us-ascii?Q?RXYXsHfCnRkW9LTZANgXvjpL6zwr9J+dY1o1AuGixhiKQjbbtvJsJlN/gT+D?=
 =?us-ascii?Q?nljLTpZsShRkiM3cAcnRXb8TqCHwKEzpVbbP9hmr+mn8ME7nr9xJiMjVdNh4?=
 =?us-ascii?Q?wXpABerevlZWqq5uLWEDK5C+SCWSi1ICw3WB7k5AfJyG/dAa3BbB1imdiGz+?=
 =?us-ascii?Q?A4utxBYmTpinvAnwUm/KmKATE08OzHYi8bcyEx4qZQz3y79CuEssk/54FoZ/?=
 =?us-ascii?Q?rNOlCZxxs6LVma7i2jeER1naFT0HJ5cfODt4bL6YfoYfqF7eQUVQira3K5Vw?=
 =?us-ascii?Q?E5q7T5UTJyK9Fxq+x8ijyS1PPzYx6bVChPMC0RPy0+dNMSkH3KzGDj19dV/X?=
 =?us-ascii?Q?gVGwwzZ5cBxGbtqndrJRepYfJYdFyw8PTrJhuloBnlt5FOy2a0ZUVpkAnfXv?=
 =?us-ascii?Q?eboQs6B8E56psZQxrWCua4JHXnraZ5sPcttX0GnI4s9+p9mgvdEJvbRdTIYD?=
 =?us-ascii?Q?6kAzYq7DU3GZCi7VnRsiaRk91s8k+RWhfdvP48d/jH9VThSAM2eHchgoyHys?=
 =?us-ascii?Q?Y5eN2gOTWGFIzAwhL1WniSkUEXcueto4pBFp4JXNfbH90r8sJrdAMuwhJG4y?=
 =?us-ascii?Q?AvaXIJiO+geMRpo2/mvR2AyW3OlXJHvDtpce9bpSgS5T68QBhfkZVcNglB/L?=
 =?us-ascii?Q?VeCuAUih9iWz4dkoSwm2ZGfH3322izXZeARP+FaIXP+GjH88Z935PK5qaieb?=
 =?us-ascii?Q?JE6Z08OFmMOaBiDpe0zvQ6rVPYaM03pfu8aJF909nHF1ir7X+5S2tCzZcMri?=
 =?us-ascii?Q?WfhkILlsCBZIFMLnI0Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f801ed6-b348-4ade-cbf7-08de05bd379d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:18:57.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yoiLq+1NUaNtwiAbTxroLX5t1o4fQN1KPZwDVTl2loEBKRsdljO54W/y7orDEE0R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

unmap_pages removes mappings and any fully contained interior tables from
the given range. This follows the now-standard iommu_domain API definition
where it does not split up larger page sizes into smaller. The caller must
perform unmap only on ranges created by map or it must have somehow
otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
scan for them)

A future work will provide 'cut' which explicitly does the page size split
if the HW can support it.

unmap is implemented with a recursive descent of the tree. If the caller
provides a VA range that spans an entire table item then the table memory
can be freed as well.

If an entire table item can be freed then this version will also check the
leaf-only level of the tree to ensure that all entries are present to
generate -EINVAL. Many of the existing drivers don't do this extra check.

This version sits under the iommu_domain_ops as unmap_pages() but does not
require the external page size calculation. The implementation is actually
unmap_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize __iommu_unmap() to take advantage of this.

Freed page table memory is batched up in the gather and will be freed in
the driver's iotlb_sync() callback after the IOTLB flush completes.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 156 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 5ff1b887928a46..7b0a6e5fb87f33 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,29 @@
 #include <linux/export.h>
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
+			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			       pt_vaddr_t len,
+			       struct iommu_pages_list *free_list)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+
+	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
+	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
+		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
+		/*
+		 * Note that the sync frees the gather's free list, so we must
+		 * not have any pages on that list that are covered by iova/len
+		 */
+	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+	}
+
+	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -164,6 +187,139 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+struct pt_unmap_args {
+	struct iommu_pages_list free_list;
+	pt_vaddr_t unmapped;
+};
+
+static __maybe_unused int __unmap_range(struct pt_range *range, void *arg,
+					unsigned int level,
+					struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_unmap_args *unmap = arg;
+	unsigned int num_oas = 0;
+	unsigned int start_index;
+	int ret = 0;
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	pts.type = pt_load_entry_raw(&pts);
+	/*
+	 * A starting index is in the middle of a contiguous entry
+	 *
+	 * The IOMMU API does not require drivers to support unmapping parts of
+	 * large pages. Long ago VFIO would try to split maps but the current
+	 * version never does.
+	 *
+	 * Instead when unmap reaches a partial unmap of the start of a large
+	 * IOPTE it should remove the entire IOPTE and return that size to the
+	 * caller.
+	 */
+	if (pts.type == PT_ENTRY_OA) {
+		if (log2_mod(range->va, pt_entry_oa_lg2sz(&pts)))
+			return -EINVAL;
+		/* Micro optimization */
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE) {
+				ret = -EINVAL;
+				break;
+			}
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_entry_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				break;
+
+			/*
+			 * If the unmapping range fully covers the table then we
+			 * can free it as well. The clear is delayed until we
+			 * succeed in clearing the lower table levels.
+			 */
+			if (fully_covered) {
+				iommu_pages_list_add(&unmap->free_list,
+						     pts.table_lower);
+				pt_clear_entry(&pts, ilog2(1));
+			}
+			pts.index++;
+		} else {
+			unsigned int num_contig_lg2;
+start_oa:
+			/*
+			 * If the caller requested an last that falls within a
+			 * single entry then the entire entry is unmapped and
+			 * the length returned will be larger than requested.
+			 */
+			num_contig_lg2 = pt_entry_num_contig_lg2(&pts);
+			pt_clear_entry(&pts, num_contig_lg2);
+			num_oas += log2_to_int(num_contig_lg2);
+			pts.index += log2_to_int(num_contig_lg2);
+		}
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @iotlb_gather: Gather struct that must be flushed on return
+ *
+ * unmap_pages() will remove a translation created by map_pages(). It cannot
+ * subdivide a mapping created by map_pages(), so it should be called with IOVA
+ * ranges that match those passed to map_pages(). The IOVA range can aggregate
+ * contiguous map_pages() calls so long as no individual range is split.
+ *
+ * Context: The caller must hold a write range lock that includes
+ * the whole range.
+ *
+ * Returns: Number of bytes of VA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */
+size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *iotlb_gather)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
+					       unmap.free_list) };
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_range range;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
+	if (ret)
+		return 0;
+
+	pt_walk_range(&range, __unmap_range, &unmap);
+
+	gather_range_pages(iotlb_gather, iommu_table, iova, len,
+			   &unmap.free_list);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 5622856e199881..ceb6bc9cea37cd 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -119,6 +120,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	size_t pt_iommu_##fmt##_unmap_pages(                                   \
+		struct iommu_domain *domain, unsigned long iova,               \
+		size_t pgsize, size_t pgcount,                                 \
+		struct iommu_iotlb_gather *iotlb_gather);                      \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -135,8 +140,9 @@ struct pt_iommu_cfg {
  * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
  * iommu_pt
  */
-#define IOMMU_PT_DOMAIN_OPS(fmt) \
-	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


