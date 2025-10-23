Return-Path: <linux-kselftest+bounces-43930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B974C02E09
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707443AECD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892D26CE2C;
	Thu, 23 Oct 2025 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZdqwviqU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792D26ED4B;
	Thu, 23 Oct 2025 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761243661; cv=fail; b=ntkDTfxaxvO5Gvzy4+7JTCF9GfJdQTThX35xLYHvzPajxv26CB7a4QQN0m66cSrA2r/qmsSU2aUT9R768VWWmyPguD0yYRvMPxyx0oPL6rH3U3HgwcbtN7Eyi6Q/eZD610IDgOhzER5VqLRslX1Fm8narZwfWMHpT7sVRk8cLu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761243661; c=relaxed/simple;
	bh=pnayLsWD0EetG5+R62EKNGU3i6OMUTff7CN3z3S3jmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKGapgY+QEqsIEH54I5CeAOGJwfxNdQfwgJSVmfUNYqzb+qz5o72W50V4fRigatj6/RhhtHZQ6YIsOUJa/tW5gotgqoDD3wzDFBbsoypDsgbCq+A1koQpvKKd+5pTcYB+VEgQM3fiSnuHwi+h/YjZMhKCeWMZTP7ytDnSSMDFYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZdqwviqU; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fAspTx78zglV3znqBWKsTQgFM/82YkSv34AGqrj4HM7sT2FsHha81uLtrYOLb+AjbewgYwC5fsZNE+HLE96b10xaVEf9s9FtF1DiW37jtWYKxuUe8+RBJ2EnZV1rQG4s7kynmQRvq9UJ8zVCvY51x9paE6lXm8zNb81VhqMGFnTtdTQ2FnqZeVw4bl5ofwKfvcVezqV9Qx03Qrpc7E0FIPX+FEBQb0h6XL2jAoMSsYjHe14vwQMiWhDgU9ekx4UvohiYgiXkBFKJBmHllXaaB3v1f6ngY2F2pFMVBqqmuPtgS1nIRVCjdljzLOhbs/RDxTFNqm7XCOs7TSvRydzssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFDuc74MVknN44uX7vo3y8KFNJDlc7WqUl2Ezs7OHDs=;
 b=Mbf8nLZ5ttHM9qOxmaHwV8S81KhN/k9eDUAEAtP8S3wpb8XeM4GGjTqpo5jezSzYseu4F4vA5h7C8LjInzOcivoG77xkmWCnbHiNS7a1SxLnMmrX7dqDIFMFawDu7hV9yAg3+dBMCH5XqfPfdxriFy0tecLMa+i6ohMfaPEau6Puc1PDZlnPfmcLf/tQ3lrWmEyYZ5zlI/F4YBScAxy3R1bfhj4ZJeeq+Wph/PaMhDFulsp9i6ikAy01zRd7Mo7Sl1DNbpZnP3N5+zSNZmI4u1mKcHxzzBucXD9CTJMBXiUGmElVQRjVjx71VmZNZP0SKOlkgXsKlrZEI12ZhT5eUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFDuc74MVknN44uX7vo3y8KFNJDlc7WqUl2Ezs7OHDs=;
 b=ZdqwviqUd7+epcyxNdwjypM3pB9gK0VUU7tjwY/FOaFxTid6J7hQ0J8h0WcWcurj863L2drf4SYRrijYvUqaWTi0vPTKT3YS0TMhm+E13sJ7COZEzyJKwylZ2J1Qm0y9WrSct4vUOo4+hCBzfQKXkqbgj034hoJfi+q0vDkWhwyS+19vAGhnt+77z8c4geXL5SGSUTGsm5fQHa1Dmh5KnUBxV1Zv+P/wSmTzYHzLvLg4ekJUn8fqL+6E4TCOZz8Pyt6NFLbZknT+Bu300sSGiNcCDm4z5kbL/X1oSV9354Bq2O5HgUW7SBgXSsJOEE4Y8HT67WwxxL2564tCjZyH/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 18:20:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 18:20:52 +0000
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
Subject: [PATCH v7 05/15] iommupt: Add iova_to_phys op
Date: Thu, 23 Oct 2025 15:20:35 -0300
Message-ID: <5-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d13cb2-96f7-4126-6be5-08de1260e38b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OFSDQ3z2A9wj3CnICcixYAEtFaAqJVZD205KRbGmxyEzFEiXqwrUWVYo9dm?=
 =?us-ascii?Q?/MdZFXt3om3U+JX7LmtxX6qo8b8CC9x2T/Bk3a7cmcqadyq62ufSBfUaDSh+?=
 =?us-ascii?Q?VQnfRQCcydu77VmUUZr/EBXGoTf4AW3ySZ8YKciX/cxgn0rnWGqCTcBHeoAq?=
 =?us-ascii?Q?W6jB5+4KnTIcpnYX9IdyHjVpYHuM1l0FXEt8ONofXIKoB/43k1X8FliwU1Av?=
 =?us-ascii?Q?L67b3nTNMMH5j+j9P57CdqvgX0G/mFkOHFn7FR4PJN77kRN2HZYmOc0KZuTg?=
 =?us-ascii?Q?/aaNjYWaD4FblkJodmTehZS+RHI1PCEdlwNNtembzpqF5vaoFZ/aHCwTYE46?=
 =?us-ascii?Q?CDitqBAC8Yv7oedPU5WhAUTZj6IE5I73tdd94jhh+GYnAbb9NZCEDDBwk4ie?=
 =?us-ascii?Q?SJkrQItgBQ5gzV5Nd2xGAsurQtAQSqtvykY67ELcM5lzeQZ7tGvN+RssygGq?=
 =?us-ascii?Q?w68Av58yqj7DxlgarIsPb5VOhZU8A2sr4m7shOPxRkne+H7JZIjDu9JhgnYV?=
 =?us-ascii?Q?55dDjSCT/K2S6PyoReaeQ/G2yIMPc9/HeXDXe4XxoS2pCS5YbHc/hgl4vyJz?=
 =?us-ascii?Q?uXRL5TPQvSRbvqYqDATCE017JKF18FKBc9u7MORlXE6JYWMXtEZBGQG1zNR3?=
 =?us-ascii?Q?CKG8kgZ5+YgM86uyqjSnkbKa8caKQGhbV3BuNPUxgp4PnvjXI0fL7qT3gF/8?=
 =?us-ascii?Q?vW+p6eqREqVdYm4Du14XK7jphm3ATepqoPfH/tugCtF3XLPPAo1VjdzycD58?=
 =?us-ascii?Q?l6hud2fL/HqfTKS7B4s7nyqwT3nPh+9idoulBuCyiYNK28smVOkiKJWFEAsG?=
 =?us-ascii?Q?6MC/DIPeO+2MdH2odWf5A6ISG21V5QQEeXmkoCgielXy1RKUMjFPWUR1/TL2?=
 =?us-ascii?Q?g+T8IRkIlZuTw34BSvQilioO7purlk/49B4++zBEqBALSvkOO8MLxNOpj9TR?=
 =?us-ascii?Q?zDwnq2Vf0Q0u4JGcWwy125LBdS5laWGeUXmxB6BXY/AL3XzhJ2MwZ0NwH8P8?=
 =?us-ascii?Q?VAnH3G9wuCY/g6OcO5l1re6d7Uc+qm7w/6Ahnn20ulG28H10D0bu2xcn3TaU?=
 =?us-ascii?Q?mPUBqqbxyPMKF4TdrAFe7iBclOUxj2PzEcDH05RHwIlw1lelJ1cw6k1J82Zx?=
 =?us-ascii?Q?B+KCij0pb08o52OzQ4wCuyqRrGsQtkEDG6G8RTZ6Q/hGdovZ83nZ9J9eiLe6?=
 =?us-ascii?Q?/ZOk48DwRKxXDEVCfPyrGp1INDP5u68K6oyXiJkkAMjDCK4SzkW9P4IRyeOS?=
 =?us-ascii?Q?f3+r8mrp/j3SCYuZAB6NB4BDldRSRSB4CYqe5D01UrMutwjyJ+I3+yLWXRB1?=
 =?us-ascii?Q?lSV9zDmdNEnCv+UKD21l2mrQlfj0X+J6O/z2niNlXnSV7K0LIdM1/H9j3j4T?=
 =?us-ascii?Q?MvMuN3ji6CiSAKGxvT1XSdELtsfuaDXciqUaCNmgNe7ri/bGadmFYRaUMXeU?=
 =?us-ascii?Q?be2FFMHCD89zaKVjkZTrvijpTcFKR8GK26TAcpyjqVoQtnnalOOXDGA174D6?=
 =?us-ascii?Q?dN89iZl6VEKDHDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVAXXIsLXtQ08XLq/KcrdjwE/IR4BmCcPAxEtYLFm0C1q4qy/MdjJC6Px+Fi?=
 =?us-ascii?Q?EGrafy2Me88OoWhoFO+Oroz/Mg6ZAO3Xpm0No9Hr8l6wRC6gTtdxH4/tLO3N?=
 =?us-ascii?Q?tCj/vnWfbwFYMbchceh/j9AuYOvP8N39ek1cRIOGB9qpNe4ziP8K1mBkcee/?=
 =?us-ascii?Q?7PzKLjGmaaKXUxkVwGakyCRmT2kSAE1Nriu3/NTPTPTeL9VEMuycjqGxgWTO?=
 =?us-ascii?Q?yxoIQCPujBemEMrWSVgpqVkCLWUMBlNMDou9Tt1CwJ2uHFYiS0Qja5tZVlAH?=
 =?us-ascii?Q?AspyGBiYh7wK9VnieL6zPt35WUvovFR08S9xu+CxUcG8xyF/+4N2jWVaWHAA?=
 =?us-ascii?Q?GL8LLtZurg/n7lIT0DniaDqEHV95Vc+g4lDrZTwmVkESfY70V6FPb8WG1Jbv?=
 =?us-ascii?Q?xPTsWsyg2HIq2yGwGqkdHp/2gR1iJS/N1Afy2lL1+ePKA8476sMBeE2WfsKB?=
 =?us-ascii?Q?7ewOBwfCrP5IZ+Jj/Vk5CbUH6GbXwnlazO4Li+98gj1Jtb5RALamJlkW7Dxt?=
 =?us-ascii?Q?lJi4+ybgC+6hOoKbtpqDnJK7m7ryJvkLIgpBKXQ6zXO3y0t7EVNKB0QdJd5p?=
 =?us-ascii?Q?Lae1Mmkel7Y33iwL3FKEshyC76V6YsWSraz8SAa/pAXJ3jNypOujkFZ+FGIQ?=
 =?us-ascii?Q?pWIpFifiAyZhBWnNM0YUZiRKIS34tdum0ummSOTpTEP2T/+PPap4I9grfWVo?=
 =?us-ascii?Q?NciNXSCFVoGaULzMR7lFgsSf15kRYOM8fboTZEwB+2AbOxhcuJhCNKwrT0Da?=
 =?us-ascii?Q?e4qkfY3hty1r5j3vnkZAFs0k2QF5NY1xcexnQ+IVtByyZ6ctQW9gyYjOW82G?=
 =?us-ascii?Q?5CPYkgRQgTq8yC+TPj5l61N42M9bb13x6a3e+a2B/3JGv/zuvOfwf/Q27DRR?=
 =?us-ascii?Q?wQriDAln0doh7s/CG2MuMDvL2U6RvLmFvLUVj9Dz+3jtu7mfpDql3j7WCYFq?=
 =?us-ascii?Q?3YEaZeZNN4UyHCmPL/HkS0/dI/UU/orQkB7VNIIA4njqQ4H8qw9LcS8Csc+A?=
 =?us-ascii?Q?W+jdPj+f04CbM7am+Sffkuq1vSKpUJfRMZbs9JMqWXAmOhkUwhwAPWsVDNAf?=
 =?us-ascii?Q?t8MbDe4M+3k6Td+9Sthsu+v7RFetUnFhmLL8lEL7jyOgRe1D6PYSJatw/8Dr?=
 =?us-ascii?Q?TseP8dY6vSHIhCarzWonU+fvG0wGFXTpCC9UE98UtVQDCZ5TaCTfTBVAW2qc?=
 =?us-ascii?Q?g6ee7+4zgUd72aGyfL4Lg9FO9K943QJwj3w0tC/gBu1i9yKSZ3LdMxZr/Qbd?=
 =?us-ascii?Q?BV3Qme02oKTdPm/RpRD+P/bTepHqSA3j2KXjSlih00CHQub3+83BzOnvaXmq?=
 =?us-ascii?Q?diNthb0onCMUEjeUM96zkmw4Y5KE39IwIIuoe+8p1ZFHr0Zr7aTXV1W3kEc5?=
 =?us-ascii?Q?abg4m2lC4nbz7laj7W5l/OWphbYrjkH1mqksqzC1rgfToOSgHWSFGze8IvJA?=
 =?us-ascii?Q?X7/L6HvsOlQBXhUnZzEHsA283OaggtzHk5prWEOoUpxOzBHbkDUy/2lVSE5g?=
 =?us-ascii?Q?EfK9qNvtsAAPBgxkGlJKyMsONGNyPkiLjB+oKogCZv+bH8JHGhhcWKeWrtqN?=
 =?us-ascii?Q?tx3gsxQijSyfkpqOwtYUrGYjeQx/fxDB4+ZMFkAF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d13cb2-96f7-4126-6be5-08de1260e38b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 18:20:49.8281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vngwu2aPtk+4/i7eOPNdKCiyZ+zz1qmthjpciwyajvax3mkhlHy/9z5kxE25vPSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

iova_to_phys is a performance path for the DMA API and iommufd, implement
it using an unrolled get_user_pages() like function waterfall scheme.

The implementation itself is fairly trivial.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 105 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  19 +++--
 2 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 564f2d3a6e11e1..5ff1b887928a46 100644
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
+ * Some APIs use unsigned long, while othersuse dma_addr_t as the type. Dispatch
+ * to the correct validation based on the type.
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
+		*res = pt_entry_oa_exact(&pts);
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
 };
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index dc731fe003d153..5622856e199881 100644
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
@@ -129,6 +131,13 @@ struct pt_iommu_cfg {
 	};                              \
 	IOMMU_PROTOTYPES(fmt)
 
+/*
+ * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for the
+ * iommu_pt
+ */
+#define IOMMU_PT_DOMAIN_OPS(fmt) \
+	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys,
+
 /*
  * The driver should setup its domain struct like
  *	union {
-- 
2.43.0


