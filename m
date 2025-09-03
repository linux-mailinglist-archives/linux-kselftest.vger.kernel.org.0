Return-Path: <linux-kselftest+bounces-40691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88FB42829
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDD41B28023
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA9321F34;
	Wed,  3 Sep 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rEA3a2g/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE32D63E5;
	Wed,  3 Sep 2025 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921610; cv=fail; b=MmpHwt9FXL8kiENCvcxDv9Yqqpg1WzoaUyrMCFr55aY7QC03vgxXXpuGJdMk8oRs62Rc6120ECfpauh7AKEyitLPorHmbn8QMrjZXemy4WgXCLQ6eYDvhiXrHKrv5FChxA8jn4bzBnDdCL9LefvNE+L5U9G4QMWTTdFV3xjuDq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921610; c=relaxed/simple;
	bh=iK6NFLVwnqzk0at9UlcUXDHiyuEyCbFJpBUyeLRKl6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wgtg8H/lKt0rF2Z7gUWVZyFpp+MuGOBhY3BfTt4DSw3aAWlS7GDolZ4m7n++NmVBD4cCiEXzBKAcD1AqhhNQdfNI9w57fBd7bdujM95crWor3Ff+jglUN7ICXMElKuZfD+38X5ewuxrT8qs+4S8YjdkOXPB6NUzPzlCS5/wXxCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rEA3a2g/; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS7fDNIiK1gj1NJl/17iZiLgXLJOFSYupdUfk+/PVSRGoj0jtA/KxnNwStQGLDrNcAtWx/SElyAMzNkkj80zUkz0DqO66D0Ph2pZ4keaflDJshs7pa7vn+srpgN1nuGIAM4lzymSkt3sNcO+I4mXXbyJdqogf5GRoPeCDDpJNsSVR4yEvugOqHwH31O/2oHOdrwwyEtGZ7GsRoWHIk63gYDDeo3Xo1R/4cPX4ehzWonkc0fj7hM1QSD0H6P9IFng1MJqaKLMr0L66+VB+6PZVHdJgB7ci4dn9HdxL5zxagMQ76g7QBPkaM1B99SMIMUxc0jXNmRh8HSUP+hpTNp6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3YJQ/lm59KtTa5pdC/HGMnvA5p5ACFLQdXJTkf1r54=;
 b=HKAnP/sHRr5eETV9DtdsdRq/RKF1OEd7xC5sZs6iYGp2Dk6+LSUyQzml3/FQZKVM0+wZCCyex4wY0s9BBcQ6RgH8inn3CJ0OmS4JbYk4+QF5hL1CNf5owIk3PsZ/ZITEMlFUvc6Szouvh6dsbIwFsz2wWZH+guOvxY5QCDuBuvuG7p3K1Vg0eTtss9UGYoY711E2+TCmS8fA9cSQUoB5LdvDXTFCwHecwLsVtj60FqaYuMWY8K4HqquyBe4oV3A83q0ZZGHR8w5KDNF5niCtnuq7Bw/54m1JMID28vW92MZrG1p0PpA8xiz1T5w8/MBskUq8XEIcB/dzBc5no0Wl7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3YJQ/lm59KtTa5pdC/HGMnvA5p5ACFLQdXJTkf1r54=;
 b=rEA3a2g/CuU+kUdmtq62id4E4qBcR9WdCF+sCtV8KbJjWMS+b2hfog4R5O2BKoeFlgLTtZJVSn7PTWnVJpdWOw4zup9QC3HmmV1asCgECEc0XBwb6r8ulHu6If/W48kGNyEgQ7ExgKghUhR3aZDGSPGSP09eX3P/IRHNipzSB/9R3laorQBz9plxjeQOFknPTTEvT0Dw7AO2xol/80cMqXOeAR609ky71hyN6OYHOzNxiMEDoLYfqrYF0wnETEdNbbWrelJ7Dqmv92JkhJmfAZ6D9NCGEVhjNYEFGIR3Riyw6VGHw9/KlSOWOdAiQ9y85HrvnWbwwRBJQ7J60Im70w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:44 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:44 +0000
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
Subject: [PATCH v5 05/15] iommupt: Add iova_to_phys op
Date: Wed,  3 Sep 2025 14:46:32 -0300
Message-ID: <5-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::21) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 71924339-9f11-41f8-7744-08ddeb11d8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M4xD+h1FHIPiYu3eyp0/JlWEyv82q/6i3MuTwhdSJSNjNd3+FOqR/Ukd7Ckm?=
 =?us-ascii?Q?2sGx4ojLoawMp0Ftn1ZkkC0OjxSv6JsBm/hp6eiTlqG/YTS0rGtlDlUurjnd?=
 =?us-ascii?Q?SCcINtvozvzsVRL66FLCyJiFzqoz9PuxvBEzJr5lE16WPp5dgEoXuTsHxHMW?=
 =?us-ascii?Q?oUDJ1ooGEtxlESEWbVZo2qPYBvHW6/oI0mnWdGFY/y7LfBcNfraxDScnn47R?=
 =?us-ascii?Q?0QiP6KyLhLlLGeR4pizkBvwll2rDu54aXBeC+kZQJAB6n2zlKqi2w69lgoin?=
 =?us-ascii?Q?6WGLyA+snOvvBjRMc8np2Jxloi/qSc1KjLSCHXaJ5SPKZVL5C6O9pm23RgF9?=
 =?us-ascii?Q?PnoySzEVzR1s9Xi0hg0EX/U5egZzJAiPXZ32HvkVEsoIIOcx5PseCNWi9reP?=
 =?us-ascii?Q?KIGkNhF7TDN6NFEDujgl+Vtn/lL7Ep+raFuuomtzIjsldntMaVBbeIqDJOPC?=
 =?us-ascii?Q?4tCup/Jl1e+X7tj0MjfnyetutQ4mIyED05pjkTDyJvwP/Rpdzekm0GZLBaWK?=
 =?us-ascii?Q?+8net9lIewsceUhai4f8ETwGsxxZYMlowmx/rXbb7h5KSZN2LZ9tRXjChviQ?=
 =?us-ascii?Q?JlydbVCGi7SpJwncGY6Lxe7DUvE/vcPH9BVYXMF1woeqpkA5eL587uwvIsrC?=
 =?us-ascii?Q?CMN/R/OgSUPHhxc8kfT1SoQ0qnY3s2ig/nLXkC8NIP0LtX5k+v+Th+Lv/qGv?=
 =?us-ascii?Q?oRBHwfcmQ/ZbNwCRWSx7aUC+VZ+cnUwt8zXGu8xYn+JRTYolUWf5kNBhAazx?=
 =?us-ascii?Q?mlGgy0VhDIYVQLKR4vmpkWoC5BXTyqOM56Z+1PPitxj02bSdxIHxXUxXcTts?=
 =?us-ascii?Q?xYFFiMkV89QwTBiZ+a7c4IjEu5PetUzWe5ENh87y7jB+b0jOvnwzy0jiQyRq?=
 =?us-ascii?Q?wQ/TTLeuRs9aWcmKYaVSx4H+wYbQrLx7HmVik6lFqJdVvqw/9WZ1WhQyLy13?=
 =?us-ascii?Q?6TOOgX951kiBLKw5MhkPr7n9z+zcMVfOXGvp16QH3uI8mqlYPQcQaCyhfQmY?=
 =?us-ascii?Q?qtL/CBLyb32/rjVfp6GX/zPcndDMPDZMTe+9ysyqdZoo0xZ05G3QCG7doHIc?=
 =?us-ascii?Q?DZsn4Jtsrtyh9E5bVjM3ye3uGw3DEYLbAVmhkv1ro+QX5cDQMz+2YGecufSw?=
 =?us-ascii?Q?Lz6pGP2IRI9nuZD25TY6fMzxbnTOIFQRkzIiHfPz8FHltUyd4tUTEqqp3y/7?=
 =?us-ascii?Q?zBnTPg0Kqhoy6Brc+RMTjq6eMArhPjlYFMC+qLUIMiigq+DfW1AyYMajWYym?=
 =?us-ascii?Q?i+79r50uVnZ3DxeeRo7I4QU16mab9yHKys7kAZiFXvWDuNZR0V8Sc4NQvhmb?=
 =?us-ascii?Q?O5G8josd/rSoBOC7FDfP4+JrnKtbzWJk+u4Gev81ykKOkzQHodhi6doA+ZPX?=
 =?us-ascii?Q?oQpC6qeEIECQ0oKgeM9l23x+MlYJ/LjE0yrde3rQ4fcmoAIxcqo2UssLj0bT?=
 =?us-ascii?Q?hAN+vLVqNtSpt712Di61qUgfKMo6Bwgy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ZZQcySyc2sLkqP2napeZkW9QAj80OyfZYWOjCw2207Sfl+UVVEgXMt0rW6w?=
 =?us-ascii?Q?UqpRrGKMn1DrBfTcBKDV3kXNZcdyVbEGxwB1vqB9LeIOMbQY++rpnGH25BE1?=
 =?us-ascii?Q?h9mP0Yta33Vie1bo+fpYa8gKmuaVOuMR5aboyFLBcfvq+Vww6QvS2TNjVnPc?=
 =?us-ascii?Q?nWXJMCPG4FUwosl95rG+UJtir4ANq60709Z3YOuv/nXaP24OCVUC5r3y/3Px?=
 =?us-ascii?Q?f3mIOaCFAYyM0WOw3+EVGpTLbf5sHKxaBfrvwPYAZTSfz8KiAt69NVlblEpM?=
 =?us-ascii?Q?np59Xe+aOwCWIv4AC07y3aO+oacW3xwmwN567p9S7/IWyqdUzxx74r8k4PZD?=
 =?us-ascii?Q?jUFGA34oDhUQgBAjIGiGQ9bVZgb33CbpQWexNJvuMQ2+xv0bZY50jsN9Qwxa?=
 =?us-ascii?Q?Q7AtijQlBrAtDYlf59+I3ajHLFsZ3cq3H9ek4yUpLPWDZBtc276GutZcFk3p?=
 =?us-ascii?Q?sAphLut3SHHJ0hgXpkSgu7j78fN085iLB/O78R7PDxWY3dOf7M9s9+bBsD9C?=
 =?us-ascii?Q?0ADUxyR8NdRX6VaLdNgE7/e0u6GoAO899w4lfVrhYAxxrNXo0YQNDOw+/9AS?=
 =?us-ascii?Q?pOSoQ4X1H6eRU868lNWStxo09DSzpF4Fl+XcWmr5NW8/5rkjpN+t4UViHteW?=
 =?us-ascii?Q?36fv9odjcefTNW9tk55bTGSINQvjyqzGyRsckPAuF10kD+V9crjawW5nBS06?=
 =?us-ascii?Q?8Mv2ul7XVDIWQ/QhW2zdB+DAYzuJ/EEMzPD0srq91vBFBunUxOG3rYvc0rpW?=
 =?us-ascii?Q?y0rjoVbrtqSyJLf40pb//AJz2/LId0ZSH5whwG7bwJKLIwL+ZC1L2JTEkgH/?=
 =?us-ascii?Q?ji8bFpFyqlvKmsw0B/SiChbqnJWRntAcghP+QxbpMf5yDNH3rxiFAuKint4A?=
 =?us-ascii?Q?xLDudw6ZntPsSxEw6NLGC8OP/vIDUJJX5K9OHfHR3C4IprPmSXUdz2PV1Jcv?=
 =?us-ascii?Q?h9lvKf2Y9uy8PhQtG+PTOmwgtevxLBu39vhMo4GlGRjQl7nxR5xbPM8SLmKd?=
 =?us-ascii?Q?xUtaExc8Bt/veTQ9LQ95Fc2Ha4aHkpHGhhN4Q4zf8T6dGmBX0B7TLVAftrXp?=
 =?us-ascii?Q?YSOTetFfI4Xx3AY8HrI8BGjyPGmem8VNjECsUj7o5UArVqySfljmWJFu8CoT?=
 =?us-ascii?Q?sd9lG9Enab+JM3zelW7y8Btfxlc4SjDLkJl0mnX+xDIjgdZfCUtqqurSoAKI?=
 =?us-ascii?Q?zYKvDQFAmJc8xwSGk7roJoQPlIPLZLtgy4/Nh3b58axtAdveNw4ip1E/+ERU?=
 =?us-ascii?Q?nyR9TY5xcubDDd4ybEYYLJcVGCn7+WQEoIcrhFPN93Y/OKvJ2i3xCA1VsnaN?=
 =?us-ascii?Q?sSjgwTW7lyDjOdpM0AG01mUn2zKtoRrc2Q3ivPxdb5O9F2q14ppFyRRkm0kU?=
 =?us-ascii?Q?hIhTYkvk+07ZgcQdnWWYP3p6EJ2JF+IVCgKrjGoHzduVaFPq8qzOcxfIYtfk?=
 =?us-ascii?Q?I0nSjUGEfiYkp2Bxx7uiH90AXtbL0vn1xZaxfcWFzu9Oe2FJGiJrw9Iv9sC8?=
 =?us-ascii?Q?7xrwCmgdBR5md63vyisAEDPM8sRGnkiXkB6+ft1xlY3cZjEhWpL7M6HNcpM1?=
 =?us-ascii?Q?1GqKFBjLriL+WDOhFIE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71924339-9f11-41f8-7744-08ddeb11d8c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVTImlBIoMfRhQHbAyGroK07AfrR24DKi5dxvMr9s0Z4+cThG2EJRUphEu2lr3mv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  34 +++++++--
 2 files changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index da711dafc2c160..06e1c85340439e 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -17,6 +17,111 @@
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
+static int make_range_ul(struct pt_common *common, struct pt_range *range,
+			 unsigned long iova, unsigned long len)
+{
+	unsigned long last;
+
+	if (unlikely(len == 0))
+		return -EINVAL;
+
+	if (check_add_overflow(iova, len - 1, &last))
+		return -EOVERFLOW;
+
+	*range = pt_make_range(common, iova, last);
+	if (sizeof(iova) > sizeof(range->va)) {
+		if (unlikely(range->va != iova || range->last_va != last))
+			return -EOVERFLOW;
+	}
+	return 0;
+}
+
+static __maybe_unused int make_range_u64(struct pt_common *common,
+					 struct pt_range *range, u64 iova,
+					 u64 len)
+{
+	if (unlikely(iova > ULONG_MAX || len > ULONG_MAX))
+		return -EOVERFLOW;
+	return make_range_ul(common, range, iova, len);
+}
+
+/*
+ * Some APIs use unsigned long some use dma_addr_t as the type. Dispatch to the
+ * correct validation based on the type.
+ */
+#define make_range_no_check(common, range, iova, len)                   \
+	({                                                              \
+		int ret;                                                \
+		if (sizeof(iova) > sizeof(unsigned long) ||             \
+		    sizeof(len) > sizeof(unsigned long))                \
+			ret = make_range_u64(common, range, iova, len); \
+		else                                                    \
+			ret = make_range_ul(common, range, iova, len);  \
+		ret;                                                    \
+	})
+
+#define make_range(common, range, iova, len)                             \
+	({                                                               \
+		int ret = make_range_no_check(common, range, iova, len); \
+		if (!ret)                                                \
+			ret = pt_check_range(range);                     \
+		ret;                                                     \
+	})
+
+static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
+					     unsigned int level,
+					     struct pt_table_p *table,
+					     pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	pt_oaddr_t *res = arg;
+
+	switch (pt_load_single_entry(&pts)) {
+	case PT_ENTRY_EMPTY:
+		return -ENOENT;
+	case PT_ENTRY_TABLE:
+		return pt_descend(&pts, arg, descend_fn);
+	case PT_ENTRY_OA:
+		*res = pt_entry_oa_full(&pts);
+		return 0;
+	}
+	return -ENOENT;
+}
+PT_MAKE_LEVELS(__iova_to_phys, __do_iova_to_phys);
+
+/**
+ * iova_to_phys() - Return the output address for the given IOVA
+ * @iommu_table: Table to query
+ * @iova: IO virtual address to query
+ *
+ * Determine the output address from the given IOVA. @iova may have any
+ * alignment, the returned physical will be adjusted with any sub page offset.
+ *
+ * Context: The caller must hold a read range lock that includes @iova.
+ *
+ * Return: 0 if there is no translation for the given iova.
+ */
+phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
+				    dma_addr_t iova)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	struct pt_range range;
+	pt_oaddr_t res;
+	int ret;
+
+	ret = make_range(common_from_iommu(iommu_table), &range, iova, 1);
+	if (ret)
+		return ret;
+
+	ret = pt_walk_range(&range, __iova_to_phys, &res);
+	/* PHYS_ADDR_MAX would be a better error code */
+	if (ret)
+		return 0;
+	return res;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
+
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
 	u8 ignore_mapped : 1;
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 58f365d0cc418b..5622856e199881 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -116,11 +116,13 @@ struct pt_iommu_cfg {
 };
 
 /* Generate the exported function signatures from iommu_pt.h */
-#define IOMMU_PROTOTYPES(fmt)                                             \
-	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,           \
-				  const struct pt_iommu_##fmt##_cfg *cfg, \
-				  gfp_t gfp);                             \
-	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,       \
+#define IOMMU_PROTOTYPES(fmt)                                                  \
+	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
+						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
+				  const struct pt_iommu_##fmt##_cfg *cfg,      \
+				  gfp_t gfp);                                  \
+	void pt_iommu_##fmt##_hw_info(struct pt_iommu_##fmt *table,            \
 				      struct pt_iommu_##fmt##_hw_info *info)
 #define IOMMU_FORMAT(fmt, member)       \
 	struct pt_iommu_##fmt {         \
@@ -129,6 +131,28 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+
+/*
+ * The driver should setup its domain struct like
+ *	union {
+ *		struct iommu_domain domain;
+ *		struct pt_iommu_xxx xx;
+ *	};
+ * PT_IOMMU_CHECK_DOMAIN(struct mock_iommu_domain, xx.iommu, domain);
+ *
+ * Which creates an alias between driver_domain.domain and
+ * driver_domain.xx.iommu.domain. This is to avoid a mass rename of existing
+ * driver_domain.domain users.
+ */
+#define PT_IOMMU_CHECK_DOMAIN(s, pt_iommu_memb, domain_memb) \
+	static_assert(offsetof(s, pt_iommu_memb.domain) ==   \
+		      offsetof(s, domain_memb))
 
 struct pt_iommu_amdv1_cfg {
 	struct pt_iommu_cfg common;
-- 
2.43.0


