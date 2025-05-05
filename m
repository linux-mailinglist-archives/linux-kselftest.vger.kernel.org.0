Return-Path: <linux-kselftest+bounces-32348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6077AA955B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E78189B485
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1260125C6F0;
	Mon,  5 May 2025 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXM862ZD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB952258CDA;
	Mon,  5 May 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454737; cv=fail; b=UAh1Bs8wR3PwbfJpV6VH/D5cUQ1HpLAtllKxT2UJ+XrmDl0tG3jtkz6AaEsw1QrhldCox4rCGuY8oa/HdvhYg0digdsiC0eRxw85Yls8Q9sfy/cusTXdRi9YFJbwn8ZRKWutl1LB3VDDprpvsQGZzzrMMWVPHOJ/IqD6STtY2oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454737; c=relaxed/simple;
	bh=PjcgniE/EtadHG/qcIuX3Ik65ZPTfJ3mnUL8MahgerA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ry14Qjtkjsr9aPH0Xwro4Ai428Z2gyZIY9EBYW3Tut1FZhXweHE9+HNmAl5cTLKfc9iUPZ1lkUXQ7UmUljRrqPr/pmw326ep1mUb9f8A74pnJVREq1P2zxhWlhH3YXE+xRlw5kpZLddljqxBb/mBhWI8nRxDZdpkkvwxZpbqPMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXM862ZD; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G674jMYoV1DT6Cls5nZY7z9GBacxNS6dzep8zSojki1kFoyp6EQbmlZOaVpz/5okXeLDeoniJJ5LhxRo9oARSPxZq+KbAJApU7vvmKyFpop0z1jysJyabWhW1RR5410CTqOelPgQ7BAU2UmzEz20swFuTWQKefyzaVfWZDM8GqWqx3ggz1MoaduGPOzdVBULy4Y/68b9zf83ai0hXbtuLlCliYjwB2x0vWP31u+nT7jHwBxZh2+Ge2W3+JdD9gFssE+rT24L/fx4ExoTQrDZOVo/ImDUOYDGP+SogzbjcAwb2I2PftHAdlA5KDCtLnnlb2SWkdq7zmGyz2hMw5+iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qAkcYoOT9a5lShRft9p0C15s3tJ4UF16tBSoNRvvU0=;
 b=cWaZmsMPqOJ4NVudGkkR4OC+ilEnzuIR3YD6Nr/LA9mZhS0gcJeSOxqABH3FvrCfYWFCJXPud61LDTkJTFVCvP8TTJ7C6t+es5JrcFHuCS9AgUEGhG7YF8VSQ0PKIjQdiC5eHQ4T9EakJZEW5JJCFJEl0swZKE26xyZC60lagp5WrWzT7QXqlDUixTM9rJBKMnFOGd1Zc84+6+Ygh14BICUbRZV5xWEWxTQSzahOstAExpOoAPS+zaSi/6msxzSHg0ZB7EMdikJd7VJ0/iw/a/YCndfrJHWy+/Ti2mXO3041T15u6NRGmdAoI+ztyyMcnM0s0KEq7Nff5G51oVIn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qAkcYoOT9a5lShRft9p0C15s3tJ4UF16tBSoNRvvU0=;
 b=JXM862ZDE5S8/oHlWSsBLF2vl4uw6JoS7BbfPxch37+qRS5dTHTIdDHm5UFo6FnBU4ByWLjp2muVkcpTZQtYDP+qXU82b31VM/7i9OTTYeOhYWDV4dgewFuUPozsyHerAZRGdl4fOhCCkJquGp3R8JmcSFfd7eSp62hg6lK7pH022uZksTwkTABXFiYLoPw6jUYuyCBYKTQ/ZSmZtO30NU5kfPBZS9mpgUdNjRZf/4qMuzN3fQqW4JKFsZyezNzEYFdZNIJOIRcwE+ibhocI1+6gH60iB0hFBKGAxNAyjdTA3QzzP7u67mNnLCzkHVlOUimLKHjoYcxKDwbsIdm7aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5978.namprd12.prod.outlook.com (2603:10b6:208:37d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 14:18:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:52 +0000
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
Subject: [PATCH v2 06/15] iommupt: Add unmap_pages op
Date: Mon,  5 May 2025 11:18:36 -0300
Message-ID: <6-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 851010f6-9cd1-4a79-12f0-08dd8bdfc0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TirbNhtNswQqqzGgJ2LpAOh6MNllCZp4qTC3Q7T1MXTJjUbEtHKhUX7BarWJ?=
 =?us-ascii?Q?/mc28JPkYztP4JFglnO0mSZ7E/HCvq9k/GOE9Thmn5uQymslT+KDYQogAqgv?=
 =?us-ascii?Q?OI3M6noyy5ffvScTl3dYhtrPelql9w7Uv61WiK/1cXG6FuaC4hqFLEVAkcAG?=
 =?us-ascii?Q?R7q1peGfOt6lTKHsR8N1Mx2A6Hqaf2zlCAi1PQ1xZhiy65TTkx99Toy2eSHF?=
 =?us-ascii?Q?2+yikNW0uCNJ+R6vs6Itv9SJbQhOJ/nvou1KWMg5f5wupF7GG350pHHlErph?=
 =?us-ascii?Q?Mc/+oJFiGzSaFcOMVveQstQouzh8M8hLMAsvzAPKOHgIQjGIrsiW3OzFkPZ2?=
 =?us-ascii?Q?Zx58J00/HcKfARi7smvAk3/zTtD4cMZvln4jnOQRrLGID9Zz9TOcwibgUKSB?=
 =?us-ascii?Q?7eLdqkc824y5CKHsr0swK3rgf2y2C877vblprUXfLyWk2rDmvH05lqFhrWFV?=
 =?us-ascii?Q?nHV5IDTgeQVePXOD3o7y3idlMlUsKD5+KPaG8MpVI7q/Ah/pnzl2nipyrEWS?=
 =?us-ascii?Q?D2HBJe6q5WWgK5C7SIHYss7y0UPo7jcS41VHUvij5YYZRiISfe7S+9I3RUMm?=
 =?us-ascii?Q?oeeHlYnaX1rNHeQxqcwjtUgijterwM5J0qh6oHZgmqMSfg0pXInAe2T0NwNc?=
 =?us-ascii?Q?Mk1RWygJXBwaPW8ZdQeS4W6yrBu9Fs3I3CQ6Dqdys1npzZPrjhTFQASIczzr?=
 =?us-ascii?Q?2hQzaNIkVahfItIaO04/6Mgd78oXhCU8Bs3z7ktvuZlpSQbUat9Nuj+nk8nR?=
 =?us-ascii?Q?cTLiDpJqbrikX7PAfWMl4V44OLxKt98OqWenagr6DBki0g/yMqDix8D4VvfT?=
 =?us-ascii?Q?YfSf1KctWX/A5i70z3T75W7ICeAqngYmKFdpZZAr8pgfdwdvm/CMqDOzL9Ui?=
 =?us-ascii?Q?QCVK8FPAgvCVjmmulwxnMeUhwk8P4HQbuEhTfmztGclaIhggw4m0uXTxQjms?=
 =?us-ascii?Q?Q07X//oXRqxCEIvjDkF7DxDPIrQqY5Qa1+kao8DZE745XMTEtn9oLwW4cvJD?=
 =?us-ascii?Q?U6z3AlZnQn3EAxAshUzcdWAAUgjZ3uQeP++UoGTidpvKl8kDUKTqlvYUBC0q?=
 =?us-ascii?Q?pCoQzOpNGKCTy8VD2m/d0GrZOnvO6i1oXBucO9KBf+SEU/f2hxLrBrMnLAOE?=
 =?us-ascii?Q?9NNYkC6SIcte7SqYbDtkq+h+82J2/vR7uVlTA36qI7IjbK6SMcXbp2jcKdy7?=
 =?us-ascii?Q?aWSS6d2MsrEkRNDWLDXzI6b7fbOJPwXUY96cRIsbJ8qo90CTTuw4SoURwKBH?=
 =?us-ascii?Q?aXJ34WodxQsWn/n5mBvYOqgi52p7jKaevW5WOErL3Glb/s++W1AytUBIjaz5?=
 =?us-ascii?Q?X0YlByd61VVQw5kl1nBT+LYJwCaBiyY/Eet8hOT0hfp9HH4WZryUo0f+1ZLx?=
 =?us-ascii?Q?wIay/8Wey6R8dXBYiS8Ep2VUMv1EuwOUb/WxMPoan3sHKoYHVaNUxfOnbZZa?=
 =?us-ascii?Q?iRJO0fe0/xS1Dkg2QQBCsTyCE+ydBuqf+jDpNB2fctGSYkW81FIp3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b61hoBi/6Z6E51Rag7358H+8bQ60Vk5AVcRIi7JIetwsdYNfLyre2FZZjXMb?=
 =?us-ascii?Q?iY9QTXXD+tD1WVtD/ss3itByqOmDV2kCKwwT7cWEhgZDpaEFpe3EOEZE0t6B?=
 =?us-ascii?Q?7luB2ZjqAqXy4U8LVUYyq03OS/f7tJIUj1WnJKMQRTbx6PVtr7tjtb7xu14y?=
 =?us-ascii?Q?qHZ6ibtjO/H+8jnWzb8GsTg+RWFo4UljnlFIY/6GT5I1ykqSDptK8q3V+lvj?=
 =?us-ascii?Q?VE782uYLM3RtfBVapRVgBl7IgpkKkU1ddwPwenrWTP7Fwucj+kchmbNLETsj?=
 =?us-ascii?Q?bQ8rmGtXe+wmeLRctYT3vaHu4x79nAj/eoe8Q2NNGC2Ca0GkC/osDLr6ZJiK?=
 =?us-ascii?Q?URbj0qfqQW6oldb4ySL+0Stg7ch7WVqFfMRovb2Hmyq4kibN97Us5UjEqTvE?=
 =?us-ascii?Q?XOFfzCjYhBUoTJWYIHyj0zRkAa/AVbZq57a2uQuYd0TCskIE0NktPjMKgoRq?=
 =?us-ascii?Q?2Gu4TxlAj0n0oSfXA5yGiwrIUXFfToX7TuSXx2fADMhQ//AiNOpE5go1D4uH?=
 =?us-ascii?Q?627d8nRjrsEWAd/PNKTdQn+QLRTro5GFTilTCWDaVDf7gVwLwNMYCLPBH/XV?=
 =?us-ascii?Q?vs+zwv6886zICGrXD6qZIuyncj5GXKRpnTSCnuVDKjM7fNFL9tCWVCe2nmYP?=
 =?us-ascii?Q?sB2n7mPIeJ0eevcX9Giho4T53EzMqbZ/Eagl3/4aWNnZTomU6FwnN6CEYo8d?=
 =?us-ascii?Q?jRwQPSDAQ6e4lup46m5It9v1yia3txU2smWxZ/RD0iJPD6KUm8iTcwndRHL7?=
 =?us-ascii?Q?/kW48vvuMx1csxnmEb6kBOktpLu4hjbrPFKn3/6HLJ89LmY4tKyrKtKNzAeP?=
 =?us-ascii?Q?Q5qonZtVpeaU5z8bp/jWHuELaikGuEg6y2qr1Vx412z3jHEv7otuM/ug7OoA?=
 =?us-ascii?Q?QwnFPRlQ/porBfcArxGw/cFmr83uFs+KvkbNTHOP3RquiCaClJFaGYTk1yLx?=
 =?us-ascii?Q?eimvcw1zKOsmwXF1icRGhRO9F7uupFaAnkE25AjuENX9H8/OAF/IPfxs9w6K?=
 =?us-ascii?Q?923HYJyLR8EOkjlmJzmb1Pj/wL+6wv4vlxYvnLX7pOUWfm+X+gPGvrnsGWND?=
 =?us-ascii?Q?TCOzY1jhjM6srJ8fR9nn0gO/1FWAp/MWR6tjABiLtI+bAMia7BiUG3C1R08+?=
 =?us-ascii?Q?EATZzjO+7DHP4NmDy1MAwJLrWv+Q0n2F7gzEbkpU4Wx5TMffxlXKwx7WRNqZ?=
 =?us-ascii?Q?PPl/Lb0n0waAng/1fgKRhXsiGu7KTuqmMtT79w3Uual6iQrDgzEpEGfFWi9V?=
 =?us-ascii?Q?MTLaTiRVp96cFwUcu72MQLeeVP4kbfGCiOI61tZfaiIgRm4uyApeNPXyfSNI?=
 =?us-ascii?Q?cc9OAA7y4T1dtxRqZlthRBOoH7dputxtKA5XtFeL51uGXerszvu4KVctJnCi?=
 =?us-ascii?Q?Gq8gPVGpIN1SvM/oi06Fqn04aTLcKmAW8rtfXmeEJqPdTDhb7xh0l3UdvtSF?=
 =?us-ascii?Q?b5CUllhMP5YlG2jnaLkEechr82VzArSPpbK6i/Bq80yG/crFCGn0sVUpyHL9?=
 =?us-ascii?Q?gtkmGisjjoQtitHV+f2cChFFqdxGG+28TYUjxJlrG1mdR/Qg6uGqzfwz2kg6?=
 =?us-ascii?Q?VNup9twuF3FpY2otg49+EVDPpIaBUaZgrX3V9KOI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851010f6-9cd1-4a79-12f0-08dd8bdfc0c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.6999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbFzAfoAmTAh4PsXwpiWbsEkP+dfvlt88Vigf3N8BFeEia64WLPcxHPlnp0IyVQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5978

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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 153 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  10 +-
 2 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index f66de4f6de6647..aa15fb79abf24a 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -14,6 +14,28 @@
 #include <linux/iommu.h>
 #include "../iommu-pages.h"
 #include <linux/export.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+
+static void gather_range(struct iommu_iotlb_gather *iotlb_gather,
+			 struct pt_iommu *iommu_table, pt_vaddr_t iova,
+			 pt_vaddr_t len)
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
+	} else if (!pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
+		return;
+	}
+
+	iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
+}
 
 #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
 
@@ -167,6 +189,137 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
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
+		goto start_oa;
+	}
+
+	do {
+		if (pts.type != PT_ENTRY_OA) {
+			bool fully_covered;
+
+			if (pts.type != PT_ENTRY_TABLE)
+				return -EINVAL;
+
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			pts.table_lower = pt_table_ptr(&pts);
+
+			fully_covered = pt_item_fully_covered(
+				&pts, pt_table_item_lg2sz(&pts));
+
+			ret = pt_descend(&pts, arg, __unmap_range);
+			if (ret)
+				goto out_unmapped;
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
+out_unmapped:
+	unmap->unmapped += log2_mul(num_oas, pt_table_item_lg2sz(&pts));
+	return ret;
+}
+
+/**
+ * unmap_pages() - Make a range of IOVA empty/not present
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @gather: Gather struct that must be flushed on return
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
+	gather_range(iotlb_gather, iommu_table, iova, len);
+	iommu_pages_list_splice(&unmap.free_list, &iotlb_gather->freelist);
+
+	return unmap.unmapped;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
+
 static void NS(get_info)(struct pt_iommu *iommu_table,
 			 struct pt_iommu_info *info)
 {
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 6fe52d6fc8fe87..862d224c59281e 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -9,6 +9,7 @@
 #include <linux/iommu.h>
 #include <linux/mm_types.h>
 
+struct iommu_iotlb_gather;
 struct pt_iommu_ops;
 
 /**
@@ -113,6 +114,10 @@ struct pt_iommu_cfg {
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
@@ -129,8 +134,9 @@ struct pt_iommu_cfg {
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


