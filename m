Return-Path: <linux-kselftest+bounces-35129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DB3ADB867
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB289167D69
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B328936B;
	Mon, 16 Jun 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7DOcXTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0F52BEFE1;
	Mon, 16 Jun 2025 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097192; cv=fail; b=i5rfmhHRxGxEkFfB+1SJTSvx4LC5qWsXaef8eJVq3TwJ3FrP6J0k1hGk702bnHahGSZwb7MuObd+AqOd18A1ofXzkNnMPGv51RXGW6tVrXPctHrDV1QqEAfGMSTYar95NofP9ty2BPGMZkbJvcIv1erCglVr/IwahgXzby2A5/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097192; c=relaxed/simple;
	bh=pd7PGG8w9DiPDO48UYlxr2qE+LceGFAkBZYBYyl6uHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CxaTA7YKPj8WacxhiaFpDCNgo0tcXrrvZgpFDSXdtYsEA6AfOVrTHj+VFPgytV7LNI5D8GbqTSo5a2LS1y0CH2uHTga/+4td0jAd0cAC4reandLBx/k2coYHfxy/Za6FLwrOeFc4EQ5tknWd6WwCS4DcoGUBMQzAh+rwvg6rZnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7DOcXTc; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T00WbgxP4lQV9sEjg+/wgL7RZdgTNnB7HpnEllEYDV3xx5DNCKL52MqWQSCRwsQwCZ3tWtVSPDhXBSIlekcOJcUzNchgJdmLEqlFJCCDBgVIYKPgxWKagS1WgqWEqXrCNN8mqxnWuH3LZ/rbO9nfa4YNifwoLrwWRWFa2pAyjMcgEhj5Jb/sCacaMGIz38dnA7qoWsaQsuzF6xT78QXHqy2bFcahGqpLbFIKS1Qth8mdLE36aPjC1TPgettLmuLI69vncHsEYPMEAfyY8rOfqY+59MOKnZVpkPHxiADM4g7IqDjO01GBEuhTzl1gqVgYvf/+HGyXauNCx2ePdVL/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC5y6jZMWxHt4l3dVdpxyYgutV9RBc2G973f1sfBMkk=;
 b=oai3J3EzWsRsWWNnpLyIITjUjXnEBkBSR1BpaLJg7BlWsUP3BFio4p6Op+T1m5eInJxIuJBIOQYIXhKl+pGhhIyOUMIAM5aXq2Q++FnbzgLNUS/L9Jg3dvJJw6Ya/UZBY+oRhLI+w88nzVmlC2Uj7S7K+W4iqwADyABa9SlukRChG9FQ706JdUE2ZiAkBbbZzaq3l42JBhXGIOLCZbglZ0DUbH/eBvuvuaKT7Dw4u8a6wD4fsAb1PeckuxDy4qz1txYVEFXsrPN/kYrU8YbD80Oj6eXJwv8AUZAwyYJYNyEPWvhpQcQaVdR8H5ATo9FSJdszQnE8t1jmd1jtjjkEJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC5y6jZMWxHt4l3dVdpxyYgutV9RBc2G973f1sfBMkk=;
 b=T7DOcXTccpk7Q5hDlHI1X1XK4+s0bPu8dmM6eHu2xOXWKz7jeXTe6OK0cZyCn+dLExzKmuwHJMqrkj6fe77T4pKiZUMwDH3vqEtTi7cpCMpNk5Wxr8HwxWtHsZaaxtGA0KaZ/NwsacWOvyX7n6r9eJeMtIUdpPSWLJz47pa2mVXiXt1M6W09XePgjR2b2/DMpLB+pe1W0QvtImPOxN36BmSmA8Yw6VZ+UwbiPtxTOK5WG77it9D/OlWIfKFS2g3MhSebyPcagFwnEnnVotdLi+aSFU4HzRn0Hb+yOjSqchf/E8UI9r/k4+GW0gtqHeEkM5V90k+Lc32z4eoje/K6HA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 16 Jun
 2025 18:06:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:27 +0000
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
Subject: [PATCH v3 08/15] iommupt: Add read_and_clear_dirty op
Date: Mon, 16 Jun 2025 15:06:11 -0300
Message-ID: <8-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0063.namprd04.prod.outlook.com
 (2603:10b6:303:6b::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 3199ff6b-6f96-4e07-25de-08ddad008163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yDYf6Jd4Z6JA6GbTWB7yxu/coitRbafgBPv+hMdCCFMQhM8ZZ0nbfsxtNnaq?=
 =?us-ascii?Q?oD6ZUcsdlEuXk6DOjSGbF7mzB7fGGiJGqSq0sc8Qmu35gv1HlokU36e65lLq?=
 =?us-ascii?Q?oAZza2ofwJ6JdoOPFx3Cdjck3Blmye7VwHojNY77VLy8h2mrPf2xc2ENLvGe?=
 =?us-ascii?Q?7nsHfEWL2LUfYKc6WS82SpebLTnsu/VIL7se7a4WW/m5Czbypjsdu/YHSgoZ?=
 =?us-ascii?Q?PSDv01KH59B9TmB+iLbAyx1ipAdQxfamddhvZJlZe42tYb3YvQolYdig3s1V?=
 =?us-ascii?Q?wG/UNt2RWMXBkq6OyQGLcdo/vexEk7c5/AqMID8fd2+kf1JDqTabFr2u75jh?=
 =?us-ascii?Q?ZmAriXpc++X9d8MWTVCPa6Yq3u+L98oBw0dmTlWfwZFz3WU7GcvnHdHigWZm?=
 =?us-ascii?Q?sFIjterBywt23dCgiqe1FbLGPNCVygFG9UHxQhGq8jv3R1FR+TqfWBuyJZFH?=
 =?us-ascii?Q?3r9aEirT4jRi9yQbjJuqiO46sFTA3kXISnmF/QXTOjs29qYjxkuMOYE9LTDy?=
 =?us-ascii?Q?kulKg3moSDSCBMmcp5G6e8lPL1RlSgYkcVT7Q7mpSeYdcVld5llL7RwGMjiD?=
 =?us-ascii?Q?NrOWt48W27nYh6k6M8hdDvQliob+w2Zk8JGzQmgE1/Q/lpcSKQ1WPyiO/xr9?=
 =?us-ascii?Q?7Z6u2E+GSis5niPdkD5ichq1ioJZA0jqWeWcGuuEipCcikfv8GvvAS4bqbzi?=
 =?us-ascii?Q?t1l4OO8pPNfZ8aR/uC8Z1IqGlAkqQ1igipp9buTYoTpLKwAqOKvdd9/1YavQ?=
 =?us-ascii?Q?iOlwvONco/UniyEUtvqJcRUSs4JrQrVsSTZmextRtmtzLnKrDJUcJQ05baiO?=
 =?us-ascii?Q?lL+l0K5u4a82LP61CGITcHZqOR5/0Yh1Mh5KLfI4mfk8EvOZkdaP+QrV3FxT?=
 =?us-ascii?Q?YMRDLs4ytnfH2Hl2vkwYV6sc0ilLoqR4tMen58JTHh7i4X3Pga1zlpy5VZ14?=
 =?us-ascii?Q?mhR0Unrsc36lImg6Iy1aw9tjMSmV7Iri0l5V5yR5mcmDIY6Dee8sPRnp1P9i?=
 =?us-ascii?Q?bL4f4ONIMAXQI7hAHFTgwZLyjupzUtfAARw8yBzdoCRPnHzmLvLs0MZgNWMI?=
 =?us-ascii?Q?8xdQjgMNHje8yV7jZ2yQGkI1X2LBewbtrj2As7BPCUQerBqOiqbGTxGOWhdT?=
 =?us-ascii?Q?vb3u1t/1r7tmWE3NCSE47dHj8JwLTotVQWWwO0uPLABLlv1fsA5tZwg3ycuO?=
 =?us-ascii?Q?LkL7P/241BOnI/HPQ4k2qqOwEMlXIrpjyGCGHwmCA3rdOuKd/k1HZCypo4Jq?=
 =?us-ascii?Q?bCKb/xXN7ZKkpdISMNJFrCMzj69kIlEd/vvV89LKIH492BxQTXqJ2MzyD7rZ?=
 =?us-ascii?Q?CVf/AoM0a41+yIEHW1utLQGCyXULpxjWGmSj4ltypr9dJCyA0LCo1Rzmxeoe?=
 =?us-ascii?Q?wD3Nq4xRzHO2I+i39V/EX8IJPcwI0/4H3cd/aCp6VQhBWB9VO7snTsWfkxi1?=
 =?us-ascii?Q?OnX1NfM1nQL4cqLgKypv5iRTvdmSemVq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DrmanNCGCH5nCd2RJ7V2UsqMeFa+Z8QSzCz1DvlB97TK8s+rnXOAQ8UxPnXq?=
 =?us-ascii?Q?5jVWp2tRYZrYm+UOvFFkV1OMNDKmnkWkpq/O6JozKpesOMVzD40yjd9dxVjO?=
 =?us-ascii?Q?Kk5joJwyLg6HNxLscKzvmckPyR9I9uDsieP435ZWnL+kcPVdiG/b/TYvr+Ko?=
 =?us-ascii?Q?Y5WEvmOZ/o/646sbG9QFS08XX3c+ufRazjqVSAPvihJYlFMxe3xUg3ZNoMYS?=
 =?us-ascii?Q?I55J48LR1Fg3iitZUOnis8ZKlIX13ZtJNm3BpgKWGuIKxQDWJu8l6zTS2l5M?=
 =?us-ascii?Q?EIVIq+RsxHI3mvJg0zdydrw8Cctiy12+Cq8RSyxXxLFjUiXqBAaVvul830ud?=
 =?us-ascii?Q?FBEKNT1K/QIw474+cOJMRoQfVLG+5T2xPXh+3IH1Gul2QsScajRGD8FS6ZIu?=
 =?us-ascii?Q?JIZwYCOp01mroZFfr8MOwCdwHgGe1YNFsu9lur7XBKzvfVioADo/c3blQ8K5?=
 =?us-ascii?Q?O3OnVAiax3EQrkQfqa2JOFsN++n23GnTcOt0a/I/xNooM+wQzEYuAXXNCxTH?=
 =?us-ascii?Q?HaKIkoDLDysCHxEz0SV/h33xSmdvGp+d3uaokJx2C5Zd9om9Tb40Cx2CGeMj?=
 =?us-ascii?Q?OVIn50eemOB0KbInVBb+r7D3oxGGOS7zpSx40RKt5AcRuVjICDhDhGlzsLi0?=
 =?us-ascii?Q?akt2+mliCLPC1/MLGtlOC2Dp4acjxmkkwf2htI58J9phqKv4nhjmL2iVkqD+?=
 =?us-ascii?Q?3hyXiP2t7D0W/5/jtr9vqAYBwyV+bmzPGofuVC5vkA0XEBSPdzoAJqRkNFvY?=
 =?us-ascii?Q?arlYOZJG2BK+S2RlXmuhMNmF+np2hCmTgE8E3qYjQZRmouPtgdjaMHwzHGLW?=
 =?us-ascii?Q?T8ykxAxQ0FIwl5TN2NN+wuTOLnIEy1ZiM9fIgElx788H2zADOd3GWKfUIbD3?=
 =?us-ascii?Q?7b1VWoygG0t1UIs+53cPbnsrI+/2KHAdzpIEZXox0cXcYkDkCgLt7St77P4O?=
 =?us-ascii?Q?IKtShZkPMZ3GBcjKF+tNQf7FhgcUk0VhNCig/XCJrtjU6n3AGqY8SCcxZsTW?=
 =?us-ascii?Q?727axTaXf6cCy1lvksO21z0DOgu6KQN4xGrJWJcoHe9mdgszesQO04OlqOvM?=
 =?us-ascii?Q?/kvV2WB2E39fYsT3fYziGtPyN+svKQzjT2jUA+TZOWqKohMOAXa3Dl3VZXNb?=
 =?us-ascii?Q?KHUFZz9kyaSGAE7QfGZcFS4NL8fkZ/3wZk7aZ76j1ERZAl04ue1oP/vdk6Xz?=
 =?us-ascii?Q?hbUHOPPOJAvTJ8ruNqH8HV9xvCc5rDhM2VCdbmwuwDhAFvval7oHRJPV/uEa?=
 =?us-ascii?Q?B+uo17h0I/nDxLuDlYTxblExaGcUy8Xqi9nVsQ+VfeVWB6Gx9QV//FbQ/ocN?=
 =?us-ascii?Q?nqvpqrZ3iEfjy/yLA+6Ioul8xEPwa8v6mBDRY8wNffzMpw0BRPFOf1vQcrCB?=
 =?us-ascii?Q?SrWsG7Cd2O2dYjRbM6V1xrleu0IMgtnP2buXMCV7Fepn3RZHUi82iH5Cc5W5?=
 =?us-ascii?Q?8UNxv+OcaJkoDLuBxxW4RSFGNqJdNouRcsTViUl/ciQBVB2Pvglcd3HKXvHa?=
 =?us-ascii?Q?ImZIBZTXhzr1/BsshiEejk4AUB9FYMUGh1VwEUAKT5t1n7/tx5b5Qxoge8Ws?=
 =?us-ascii?Q?xMtg9Wx5CK2SOn9ccXtCPntorS8FDUauFYDATjv8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3199ff6b-6f96-4e07-25de-08ddad008163
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:24.2423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5v/i7I9HWpU77H1a4b2rBsKeSlIDDY6vEWzhXEqErjtkOpSFYIwSlKEM67r5sCD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

IOMMU HW now supports updating a dirty bit in an entry when a DMA writes
to the entry's VA range. iommufd has a uAPI to read and clear the dirty
bits from the tables.

This is a trivial recursive descent algorithm to read and optionally clear
the dirty bits. The format needs a function to tell if a contiguous entry
is dirty, and a function to clear a contiguous entry back to clean.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 103 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |   6 ++
 2 files changed, 109 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index b7c45c9152590c..9ad2d17f91ed33 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -162,6 +162,107 @@ phys_addr_t DOMAIN_NS(iova_to_phys)(struct iommu_domain *domain,
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
+		pt_entry_set_write_clean(pts);
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
+		if (pts.type == PT_ENTRY_OA && pt_entry_write_is_dirty(&pts))
+			record_dirty(&pts, dirty,
+				     pt_entry_num_contig_lg2(&pts));
+	}
+	return 0;
+}
+
+/**
+ * read_and_clear_dirty() - Manipulate the HW set write dirty state
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the IOVA
+ * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
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
+#if !IS_ENABLED(CONFIG_IOMMUFD_DRIVER) || !defined(pt_entry_write_is_dirty)
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
 	u8 ignore_mapped : 1;
@@ -1004,5 +1105,7 @@ EXPORT_SYMBOL_NS_GPL(pt_iommu_hw_info, "GENERIC_PT_IOMMU");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IOMMU Pagetable implementation for " __stringify(PTPFX_RAW));
 MODULE_IMPORT_NS("GENERIC_PT");
+/* For iommu_dirty_bitmap_record() */
+MODULE_IMPORT_NS("IOMMUFD");
 
 #endif
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 2ca62812b5a152..658ef69156121f 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -12,6 +12,7 @@
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 struct pt_iommu_flush_ops;
+struct iommu_dirty_bitmap;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -181,6 +182,9 @@ struct pt_iommu_cfg {
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
 		struct iommu_iotlb_gather *iotlb_gather);                      \
+	int pt_iommu_##fmt##_read_and_clear_dirty(                             \
+		struct iommu_domain *domain, unsigned long iova, size_t size,  \
+		unsigned long flags, struct iommu_dirty_bitmap *dirty);        \
 	int pt_iommu_##fmt##_init(struct pt_iommu_##fmt *table,                \
 				  const struct pt_iommu_##fmt##_cfg *cfg,      \
 				  gfp_t gfp);                                  \
@@ -201,6 +205,8 @@ struct pt_iommu_cfg {
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
 	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
+#define IOMMU_PT_DIRTY_OPS(fmt) \
+	.read_and_clear_dirty = &pt_iommu_##fmt##_read_and_clear_dirty
 
 /*
  * The driver should setup its domain struct like
-- 
2.43.0


