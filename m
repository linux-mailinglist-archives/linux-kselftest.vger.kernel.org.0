Return-Path: <linux-kselftest+bounces-37513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D72B094A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF29C586F01
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C82D1F7E;
	Thu, 17 Jul 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCVMlir5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB21FF1A1;
	Thu, 17 Jul 2025 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779717; cv=fail; b=Zu9Lk+xD+SudzwoYtAcF+jYXbi4LrUT6O2e2Re+IwV2shA6Q4rRbzLhn1S7ux8fTldRHUKZh9syg2ueUDiqHMjkZzRD6RmEkJk1G2NEafpAibE++Hwo9aQ8YaO2YPI8R5U+SvZKYQCnOyKE1szVy90wNXh5uNeYD13UqD5SyHgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779717; c=relaxed/simple;
	bh=eq7h+qvT9p1AzcyTwY2I9U5qwJ7KvBwjZeNHD9kTGcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oZED6FkANMhKD43oZMtSbom0PJ42I+IPhTPZan8Kf1ikHzHuA1F5qEkAdVhouyo2SgVHjvcmjeJjpVTarTVdr8qj4VZ+eaVCHxiRxsU9OI3e19giON7Av15fCP85OLPdZA2WJeWRbBSch4F4hFDH259IiMWmK3cFTVM8PqRQbfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCVMlir5; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILKtPFAL935QAgq/6ho4UYAIf2n7dHuV3NrUV2OKpIk4iEKJH65CuuYxYcFNNNWa9ffnDpFOQZLz+ni06U18ZQruYivw9faXjNYFxepqA7i5gtMPzLF1CIMfYbhj48n6p4sL5vJncmGdsXwHzyX/+a3BhmlFWf0sVgZWC6bgM6SpHc6jix2U65sNTRkawZRKOV44X8+t5dF+HCKx6R+KyeKdwOYnc7xZpjOLXRlkd6f4yfXHFiEG2Zbruz6wHMcTYCkYhk/hE5a+eGx55Njnt2e1rxXhlN8w/nSsM5cfvJLZLW5FGzvasXfmY+KfTGmBELpNG34EZA6K/aJcPsToQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phf9eVRa8TRG6gQmb4B77DX97DAsKysVBZNLckIQL5o=;
 b=AQClcaHQf2Sn7cGuloXzvddZF49sUYdoGq8kqkBzsBPRz14b9FxS10P+6gg4UnHuOPgVN4cpQH1r9BARNrcZBXgfMercCro3hcPI3tiKhPS/mEJ+yWh4/LzLfThdIFAOAV/obGvtN0DcfuMVdjwicXP5/rQ1gq7kkaGakauZRbsYA1sxwR5K/SeGRjd+qvWj0Dk1CC4jL2dW1JglKe/UA9Kpgsd4sA0c6BlGLo77VNeOyvCkDv3koRfhreb31Z/eZubJeUPyXCZU1N16u6mRpzfylm26G2OVvtuN7OIM4OmkoAWrYzsN9ZYWFL33kTuFURuNb9AnS6F+Cu1Y2EtymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phf9eVRa8TRG6gQmb4B77DX97DAsKysVBZNLckIQL5o=;
 b=qCVMlir5EyTbVi9uR1IhaMfdxdems6iJtiLxW2XAkJNvZU4qDcH/vYmRFbPZDRP/lmfMgIlKNsz32ckr6li9rQwiPBgae0Rsl0rYezq5FaxKOiGZye7l5EbsgKiVar9QAMBPXlRUz1Zf3m95wAnoDK7JCm5mRt+4RtJUdPZQZoCzYxL/hMTdGXtrl2t/jaluYu1QhInkZEZFXweFynslZP5HbJH1akBMairYdpuyx+L4Urigt9nDnf4E/iq9pTyioOV9IgPD7DKqvQ+dO7iBH+QnEbOwpIOH+ewu7KMZ1Nx1QMy5FiVMBBpHSXXjw148k9hBnQgDN8mNmTeFWsS4nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 19:15:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Thu, 17 Jul 2025
 19:15:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com,
	Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 1/2] iommufd: Prevent ALIGN() overflow
Date: Thu, 17 Jul 2025 16:15:08 -0300
Message-ID: <1-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
In-Reply-To: <0-v1-7b4a16fc390b+10f4-iommufd_alloc_overflow_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e1e5d1-acbf-4f14-d67b-08ddc5664001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yKuDK0qyuEZ4fKJtNdi5vMvz9IGvxIz05d1aPm16Xfl8c/qwkfI9S/B23PqV?=
 =?us-ascii?Q?PCjyMAGTjpdr9ua8UXxQmwmFa8g6iZVWB+ckQRmtPowFZk66TWr6wwednGQs?=
 =?us-ascii?Q?cbObQzxH0Wh4pD6Xm+V759jhscaG2AazWbEqxFouQmt/arhmp+JG7tflJnGH?=
 =?us-ascii?Q?bkQ/orj5PA4XMkI8recZOkWXFJuW6dbWl/qge+GxwLYyqC2aANcGO/SgOAN8?=
 =?us-ascii?Q?/yGiV8vJcypZLURufU3WrhdF6cfKGh5Q/aZBpD5U/2/2/gmYQTZnH+KNBRmU?=
 =?us-ascii?Q?ppTusVJ69SMfORNFnstWM3FdVytroT3ET/x1rkULF5NouNLq8yr6AoqnwMv9?=
 =?us-ascii?Q?aYUIwd9rT+YIggXZvjsik4sm709Y1miDRCn1+mwqnFN2fQZBaMeO3LoIjwbX?=
 =?us-ascii?Q?X+0SpqzhL/FpLAOt4tqgOf4AsHNpXDca5l3Dk6ulYhQxFxdiR78P4vu7k2MN?=
 =?us-ascii?Q?nF7p+46kgK5pkUTLi0ORRQryNwdB+phNd6LslIh/j3QxInkRsCVmkMdR5aqE?=
 =?us-ascii?Q?UXtPOJVKUBVDukSwyDH8qWVlTy3aEPN7utJR0KzymWD4p6eUBH7tGP7Fe9y0?=
 =?us-ascii?Q?k8120z8tqdU3SQUFjgacrykqOvxIbUbgbvawyq727kl5ETxVrI9eOr/QhuZo?=
 =?us-ascii?Q?g8uq6X9NTs6hlZ3iPY7eyzHDoXPCDeuwJ3UcL6ocnuZ6zU3jEha7mzTM0xNP?=
 =?us-ascii?Q?JufXxNvZOVFawKAllkejpEbHXk9QNCLghLMjDfCMmSaXkM3W3EHpETLJKJcO?=
 =?us-ascii?Q?DgawJBgkNJ3KHy5yIkwvi13gjcw6nlvHgo9/w/TFIFMIlXBkN5fHHkRYofxW?=
 =?us-ascii?Q?EbJ8I1sX2uqlNthO6ecNvStIZXEf/C3cAtOZ6XWY8LdLYjYniykQo4bP2tYB?=
 =?us-ascii?Q?iN9XXe1AesLy3k07JscE61vsahFtI1H6IvkvWBTkwcCNpsUH2MUf4lhNw6uu?=
 =?us-ascii?Q?MtCyErkgsGuYJ3oDpfpYS4P5/iMuGtjsTN/IKXvzUtMpW9aKqZYngHRWeoP0?=
 =?us-ascii?Q?FgrmrS3dvl/d9wcqOcXKldWG5oFY2hYL7IpOyODtTdw8KJ35totfwhqifYq4?=
 =?us-ascii?Q?IqaFs1u8NWFQdy0Gf47+Beu8U3kXVqkleMzYsbYz+joa62g3RwS+59QWzPjW?=
 =?us-ascii?Q?0+sGMeWkA+DtJXeczw0czSNBda5MxcbTGlb44MuN3FLux0qnuPO76Vk+fD8r?=
 =?us-ascii?Q?EyfXoXj2lrHKfGZLjXcfseWWgA2TliApBRlnZq4gBgL6rWdJv+BQaFC8kU7G?=
 =?us-ascii?Q?8TnLcWdc0lK7C02cKAo2awg4JLz80ySu+TQmZbNSq2PcdptX3sjQ/uCY4iEF?=
 =?us-ascii?Q?J/Dn12E+MOfswd7CEnfWN+gDEeReZyLf2WXkeialto6tQMQsJ0DB5GtIBHts?=
 =?us-ascii?Q?xLQdmmXSXCl88V/saOvD1nwET7OJF6ZrApv2tpsM72r/4p6Zf++3OtrMp/xp?=
 =?us-ascii?Q?R2M3aN8dQoc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H8JEGiaIC2yZDzZAlgfOPnHcwUqi60xPYVIqBpdHex3B3GwuQzwPaaTp0ied?=
 =?us-ascii?Q?JsiQCi4JOVOtqI9TonhWItuUzWjP0Pirnq9r+7Dzh0IidzMjd07lqbEUEMfr?=
 =?us-ascii?Q?WpdsuxVRDSu5rY2EcKYDftjzKMh5i1/YlPDNdC0U7HBsDnpKjtKrroJJiShG?=
 =?us-ascii?Q?t+/d19uhf9FcygyfMx3fm7MWl30CjmiS6CWl4cugQkSMrpQDJ8WkThUo2uIP?=
 =?us-ascii?Q?b8L5rK6DCDWiqhUOn+tYOryRIf7SdJSm3B0qDqcWczYIDOSUE+kV1I9fiSgD?=
 =?us-ascii?Q?xMgicPRqJCsbsyIjC+NWN9Wtef92JMmbgVhYJkxRLzqxEU+XB1RgY8wjZQUd?=
 =?us-ascii?Q?PjQvChA3o1CDWOqgCMolUQYLQrMIiAURNZGLwE7Wpiu3cnq9IyLxB/UBZvTR?=
 =?us-ascii?Q?rAdyU84qTSrwxmubCbf5H3LF0Xx/EbwkBxl/LECIht5sgG4XQbG3EpP3tF8V?=
 =?us-ascii?Q?h+TFzwX7QcUAuQ70Am57hFA27nhb6SSZkLS0pjGdiseIrn0lYnznMzueq0xM?=
 =?us-ascii?Q?6YEQPo/x4fPwfAnyWgqKfQdt0KJTaWChQSYbVjovFzBPN3pH1SC/AYSMSsfJ?=
 =?us-ascii?Q?ObdFlzWmj3MSXmVB0rVVY6HZRQ37dHBxY5JnodTPMsyQUJYZyDuwYHhXXlJC?=
 =?us-ascii?Q?l/ZJSIMriPrANlEAHDWcHPF59Uz2+Ut7+BeF5ijLTug2ozR833uAtkgbs516?=
 =?us-ascii?Q?uzQEiJm1RsXW/KzWBF2VDx2sfyTIavUJ4Fqg3UjXa+3eexGNV3UWtnRTU/Rp?=
 =?us-ascii?Q?XtbuP67KNjp11P7T072cbUA/e8fyVjapVbYQyPBFlXi22t+Ff/UwUQj+8FEK?=
 =?us-ascii?Q?SLs5APjlS5HzbPUaXf7O+HLQbj2oSqnJ880j7NR2jBe0PAbUm0X1tIsTkZtH?=
 =?us-ascii?Q?w/L0znUx5P75cqpzj11gKdnb5PK/pqwRLYD5J7BlmqRnlpmE5L7QpK1H/024?=
 =?us-ascii?Q?72LTsfY5gwI5pxkfJIXInwh+MP/US1tcyzj0a/gDYKS7624q7d7w7FsJLiDF?=
 =?us-ascii?Q?zsHnWMcj4tPf7T+5hN6Ic212cv8dquT+Xm6q8uX7ihMveBI1tUCF56doDFiY?=
 =?us-ascii?Q?u5h0nCFNAo8uwX+co3jhvVHr5zktcqxCoCiQW9nO5e9O4b8S1qgKhBJfq+nt?=
 =?us-ascii?Q?lOpVqHDejccvd7D27mkrqGYPf1qD3k0b3WTInQwl79NPFkbeySbxze8BYegX?=
 =?us-ascii?Q?X4jlMhDcRO8Ct+X2nRRTRckSiPJgHpXH98RMyaqJkpKQGN7rRjxQqCD+p4Eo?=
 =?us-ascii?Q?9Spa/yPI5xTS2sjnE+rXHJ68J8qOfZHy3T87Bj1zxbGin2ll0x+qslgHTpAY?=
 =?us-ascii?Q?TD137gCpx8BcOlJlySOmU3hr/2QENGnPuNbhann9sFKy4+BNVCKhvB6j0JAT?=
 =?us-ascii?Q?VF/a9HpAOZerEThI94K7ISlBZxAbHf+dcD5yVFHkQXHofp3UOc/TkWeZ+Vwz?=
 =?us-ascii?Q?CYDjDLvIa14wNW3A1GTskOONsuPkviKs/I/F9WJQA9MrgKKKmw5fs4Iuy3kL?=
 =?us-ascii?Q?/6+tVo8DUQOBfcs3E/S1ru590xiH6noffFAcKtMSG6EACKxM5171qtVyilpe?=
 =?us-ascii?Q?TTBFktOjAsPR6hlagONcsBVcjkcdWe78SiSGB8s0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e1e5d1-acbf-4f14-d67b-08ddc5664001
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:15:11.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvG/6T0K6ZTOYqbX0zdgqGRJ6JmEqehu2cxb/3ZBeVlsDs34ITX63+Ls40D1/vS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571

When allocating IOVA the candidate range gets aligned to the target
alignment. If the range is close to ULONG_MAX then the ALIGN() can
wrap resulting in a corrupted iova.

Open code the ALIGN() using get_add_overflow() to prevent this.
This simplifies the checks as we don't need to check for length earlier
either.

Consolidate the two copies of this code under a single helper.

This bug would allow userspace to create a mapping that overlaps with some
other mapping or a reserved range.

Cc: stable@vger.kernel.org
Fixes: 51fe6141f0f6 ("iommufd: Data structure to provide IOVA to PFN mapping")
Reported-by: syzbot+c2f65e2801743ca64e08@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/685af644.a00a0220.2e5631.0094.GAE@google.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 41 +++++++++++++++++-----------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index abf4aadca96c0b..c0360c450880b8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -70,20 +70,34 @@ struct iopt_area *iopt_area_contig_next(struct iopt_area_contig_iter *iter)
 	return iter->area;
 }
 
+static bool __alloc_iova_check_range(unsigned long *start, unsigned long last,
+				     unsigned long length,
+				     unsigned long iova_alignment,
+				     unsigned long page_offset)
+{
+	unsigned long aligned_start;
+
+	/* ALIGN_UP() */
+	if (check_add_overflow(*start, iova_alignment - 1, &aligned_start))
+		return false;
+	aligned_start &= ~(iova_alignment - 1);
+	aligned_start |= page_offset;
+
+	if (aligned_start >= last || last - aligned_start < length - 1)
+		return false;
+	*start = aligned_start;
+	return true;
+}
+
 static bool __alloc_iova_check_hole(struct interval_tree_double_span_iter *span,
 				    unsigned long length,
 				    unsigned long iova_alignment,
 				    unsigned long page_offset)
 {
-	if (span->is_used || span->last_hole - span->start_hole < length - 1)
+	if (span->is_used)
 		return false;
-
-	span->start_hole = ALIGN(span->start_hole, iova_alignment) |
-			   page_offset;
-	if (span->start_hole > span->last_hole ||
-	    span->last_hole - span->start_hole < length - 1)
-		return false;
-	return true;
+	return __alloc_iova_check_range(&span->start_hole, span->last_hole,
+					length, iova_alignment, page_offset);
 }
 
 static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
@@ -91,15 +105,10 @@ static bool __alloc_iova_check_used(struct interval_tree_span_iter *span,
 				    unsigned long iova_alignment,
 				    unsigned long page_offset)
 {
-	if (span->is_hole || span->last_used - span->start_used < length - 1)
+	if (span->is_hole)
 		return false;
-
-	span->start_used = ALIGN(span->start_used, iova_alignment) |
-			   page_offset;
-	if (span->start_used > span->last_used ||
-	    span->last_used - span->start_used < length - 1)
-		return false;
-	return true;
+	return __alloc_iova_check_range(&span->start_used, span->last_used,
+					length, iova_alignment, page_offset);
 }
 
 /*
-- 
2.43.0


