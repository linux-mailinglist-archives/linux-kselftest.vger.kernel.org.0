Return-Path: <linux-kselftest+bounces-35126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CD7ADB862
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2A57A2E97
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2C28852F;
	Mon, 16 Jun 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iTZsVTCt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101651DDC23;
	Mon, 16 Jun 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097189; cv=fail; b=tjA+5327GRcStHQDEMGip+eWl1prhbwvC6sg+kGCBAZG40v0ojE7oMgjOJomw9EV0oXoVj/Gkk7fvu4pzvX6PH8zE5+qXvXo7stBNTv6PRkUx9C88MFbbyjkpaKChSrUDm2etEOuTGkWxyTxxbgHmfHIcV0DGbcCZt28T9Gxp3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097189; c=relaxed/simple;
	bh=eeRDbU/3fY1tkiQ78NGa8Pks9esi3AF0ocQtO6ULo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oyzo/Ds5WRR8bdo2ywkG/+lSEmcQWcKjJbIxei5OWBfJaej1OkpRfpfK6ghVCGiCazqqZrlsJZfQiRzd1xLQECcHrBFWNO5KfuJnPYcTbmx0yKk9ckgG77m2nykGhH8ha+Yaby7S8s6Z/PLMQjKIX4tq1HWaSOk1RQoCxrzNcUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iTZsVTCt; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khzYBMe7TAmPAsJkNaEWyzMhDxM5HJcx6EkKYoFt3JXnV3APQ47yh3BOngyZgAOdKfFqnJf07MN8kgQzQaBGVg+kVZe42RL2hTeJZNz/Uu5qT4Z7cslOzcYIZqmG+PiBVe5ND0KGUzmEBnq91yJ2VButSBnQPqDMF8J12xiq+4RcJoKFQ7/6glAqdcTBoHQfW70zDRpZH68tMuJ5gSYxMYEvnwLGM8W3rxdoxNo/OwQYV6YwSPiLvTKIyJAmCTXWsFYunMd3um7w/CYMQVZnKfdBpTJn4393EIv2gyJ8mDqTWCCp1QMW+uDUPDi+LK9Pxf6kRKcr6uXO6DvMQoBR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA596Vm/ZHmNIz+0LwIRqzEPDcGZuT7WHKu+MdE/JJU=;
 b=mSR08zJ7ldKD2+ennkSdY91d77bmpwn6GnEFWhDnG37DMIJLLLhB2R7JYCBfVipnEOP++lXCUZ2b+vRw0IWqNFk8aaMI1JpAUHNtlc3ut4ghiwX5DNVkijvHDxVnIbQadP8b3NNr+gg6ZdzSEIruhC8zh92Uu5ljRPFJlwhcDtH/iWY9TRxj79qpl6VxfHrMuiubEz8vFBgg6cYb5JSmyxWAggkGk9XA2HIeiblm91F+N8Ip48wyN9RP0rfRL/BSysPJT4wBIZJmhLnnBqSt65HAXvFsZJMt1ynZS07bOYzSFZEQMXXogUNkefPSz6yfoSeEloCC8cXuQkwpGuC0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA596Vm/ZHmNIz+0LwIRqzEPDcGZuT7WHKu+MdE/JJU=;
 b=iTZsVTCtVJjc4AaYD4uwR6oDRIOd8iIWOb1D6PJSborullXnsVtK5Wxx+SLN1osfFtluU91r0h9V3ThtrXJ+0DoZ2B8rIXU59WgsgYaNcotwW/RO5K6GGb/9kmjaMzcx6XGq0MSJAaut4hFQAmx+7s3/Mp6iXy3ks8Dbh87DsHh5S2q9Ith+lQif5Va036faGKrix5j1EyMBBOguZ0bNDO5cL0YPADVLLoM3a+cCo1G3Cap3giJkcfAEYiR162CFLwF1A/ZhRHV0FHxhaWcyb7fPeTQMhMlWn2hkmJBiapRwZZ2LHPZMOz9KvPXkBCviPjAHOc5irCURBaqXJi6Ikg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 18:06:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 18:06:22 +0000
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
Subject: [PATCH v3 05/15] iommupt: Add iova_to_phys op
Date: Mon, 16 Jun 2025 15:06:08 -0300
Message-ID: <5-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:5:335::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e44ca07-5ddf-4cd2-bd2f-08ddad007ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mfOaDXyqaEEEBm4ochLBwJxwR2rtzhTLgmbuLBfIgin2zXN3z8Q6mcBbjoeK?=
 =?us-ascii?Q?umB4RznokIsduN+EiqGu5HYKy/Qa7h4kszZLBZhIoxAqwmJp8XJQApAAwWQW?=
 =?us-ascii?Q?ngnfkUOMKPGsPFTQRecJlqB5OBmVF7t69/gkecBz9HJ94MCJUGEm5zE+KQzn?=
 =?us-ascii?Q?PjwmBAVfcdX3ugvnBRSg47XNA7+yeyYiKoyWBXzZWipZ0hG70kGo+dFAONxW?=
 =?us-ascii?Q?AKB9DI4eLCJ3q1sBQGoSpymTqlG+YPiaeebtw9B3m9CRrboUQVXklJVT5enY?=
 =?us-ascii?Q?/7hiJ6X/aB3xpNbjARw/42012HCCjTAFsZWCWZV7c0zzpqmHEeVl6TTvMZsE?=
 =?us-ascii?Q?HvZrkEOBTbGo1lQFrWNVxTzU4sR0284H3xHZYgcYWh2Aa1aY9d8n4gbRJDT1?=
 =?us-ascii?Q?IB7wHivG38jXG1cK1BTGPqWytuZU5NCUTTC+8oJJhygk/oiXp6uyFH/jnvsR?=
 =?us-ascii?Q?EL/wtZ2qHK3A9QjcD8RjKpdsGPFTWL1a2ksp0UoCV0gp1X/fom0SybKSbx7G?=
 =?us-ascii?Q?rtYn5VEqmwP/cEWUO3Bjs/aBCpvaLNTdlc0kIwaBJqjQqVlO6r2uXrwmbFvI?=
 =?us-ascii?Q?mlnnHb8XC0UTHJ/lEfc/RfVLOLhgjj2szkPu+qSuYbW2JyHGLVb64w9r5BY7?=
 =?us-ascii?Q?dzxEK3ED97i3nFgum2c0o/CKvmhIbzBR1NcSOArHnoywxyf9/xjMg3E4NOlz?=
 =?us-ascii?Q?oMll6cho1CGL/oFE4FaWKmMYfUDniK1R1m/IyYrpmwHwND7ltRJ3EkDLjkN9?=
 =?us-ascii?Q?NvoL27PVos0Ma2+5CZ/gXIBHZCyZs9RCekpNfVaUs+YIvuATXcDIr1kl/QSw?=
 =?us-ascii?Q?VE1rMG54AWKnc7YrISaeVp7DqOyYOm2WhBNNcoPksSwuk3LPYF/Xdy59DESU?=
 =?us-ascii?Q?m8u+NSP/0KRQDgeJ3E2YTqTSmm3/jEsBI62QS7e14qvM7lAXtgMsO1/dMPo4?=
 =?us-ascii?Q?X7tLJR13I66oXIxWpHv/PjVtujVf94OhRP9xleuCMRdOAlcYZ6lME3Zp4/za?=
 =?us-ascii?Q?wuurz2gnzQiCh0NL7DMbpdYJxg6EUnQLI8UR6rJ+4ROiQPeBF0pSzcjZSFVA?=
 =?us-ascii?Q?oJif11bgjrWsaPzzPe/e4/vTDXE1fUcXSFU0WuTjSBB7GLxBCB77xN9/XqlY?=
 =?us-ascii?Q?0W3rB0PRhmKvvL6tgNAl+ojjJj6x2WVcqkHkVlueuBjmt3LXH8Gdas9S/NGS?=
 =?us-ascii?Q?u/KyFvgtfkLmUpeUjS4DzWUhzCWt58WxjaoTBGTANlQ/BRdldIIqQ1EJovtm?=
 =?us-ascii?Q?S/f4XgoEQj2OGnEaupE7oC4WF/m2rBANFyuFZ7yghkH4uCpvVUtDdVwv0AEy?=
 =?us-ascii?Q?/FW8v+pVkyeYf11CBMn+KFzFn9fGt8mimi8Vj68PmvnXITWlmqv1IgSbCu+h?=
 =?us-ascii?Q?cMjXdZhrKctq8ZZZbvceBVjNx9GfI0FSQ/Zlvljf66F+ra9SBMWs0dE5BAhE?=
 =?us-ascii?Q?nsFYpo9a8lx7S3Dgr3Wu2Y3FyF9Qqk8T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNUp5b93vmmboAdi15aWsL2H3FwQN+AcaLS5NurNPICSZfMyDThTzscpGphO?=
 =?us-ascii?Q?FUZmsfc94NgSgRIXL2v6rwPRgp/f0xbqmtTNfTV3++FIBaVBXlbUhyTuH/r0?=
 =?us-ascii?Q?X1rBVk3wVgpOUuw7SRT259tYZSRdwDR8lTNHHQ0RW0t9OpP0IVYKFN7583Rs?=
 =?us-ascii?Q?YTEBxUmR163lxtZWspVvL1lDtC7AH5Qzfd+tp4QYJzAsjr4jimfQKgclffJv?=
 =?us-ascii?Q?3BZIHJgsBGQYtOO2zAzwTA1gEJheA44JmEvs+RlrKJ8dJW1Qrjxbm14JqCLf?=
 =?us-ascii?Q?H/jJRda0WjnbhEdg+h4Z6XjWizCyWyJfttGxNqicvuRwbebsyk3ONf5TiIJO?=
 =?us-ascii?Q?RaywRISBRilcFHcEq7Lj/yEbj987zCBwaYXX/FdtWdeRkmNAAAGGWExVFUHf?=
 =?us-ascii?Q?LoI5NlPT0uz6uow/PERgZybo0uRDsVy4Eq+dq9Wsux+xiKB2XBIJCIs7eXk6?=
 =?us-ascii?Q?tVMoIR6Dlucy8pwgekG3LM4f3IaOJTvI3jZ+39qi76uITyzbEignG9tYkoM6?=
 =?us-ascii?Q?qt/kW89gsqskwSEwQ5Py6Bd9W9XQzOP1JGGs56VWFUeM+ESAL9sLL2VGbfOK?=
 =?us-ascii?Q?2zlOqzvtNwtVV6AW+VJX0+u5qocm0c6edfb49DRfmJG2PsSBgSow3MTwd151?=
 =?us-ascii?Q?+9OSZFTiLz2Zcu97zf8jtJkD5esp2QRaY5DLPASru2uJO/Cn5xxl24clJoEE?=
 =?us-ascii?Q?mVki+yiZsuGVQq40u+75V17/k+TGPPrLLLLAFp+BP39KC8LbQ5gtNvwQvrAv?=
 =?us-ascii?Q?xYJhZf0xqdw7j5hhdiHVMXx1l+QSen87OT7Gy8MRLdEM6/jOanv9+5KAL0JA?=
 =?us-ascii?Q?uCVE/iklHmr2A4lsqNvlmgbVgWWo1CXzWawzJUK3jIkJiRsAT2igRfM0vGXC?=
 =?us-ascii?Q?ipCE03P7h443qpsS5gYICle+BU6va3Bz2b/bOLgmPl9E5EK9RQw8OB/GCPrG?=
 =?us-ascii?Q?I4HYLdNaaTuLysL8QgabFquNmkGZdBGax72pypJRs/0p/1cyM6lXSQlFOrBp?=
 =?us-ascii?Q?t1f3ZdSpf9v5A1b2NN38X4DbBrlnk0LRus45cNEnZge1GIGzD6ou9TFtJgjC?=
 =?us-ascii?Q?XUGEpN5BFQb8UvFs4izlpvaxNZTkHWCbIjxQPKlryfhMCf4gLG10SDeS2TEU?=
 =?us-ascii?Q?JGdlkOuF/i2ocFoyqK1Siy4FHoSW/uvDpDmaGtzg5TWLBs2k38dBansl+kAK?=
 =?us-ascii?Q?udo9Re0UL/PU0GJ4DzVKsjYzJ6pDTXZf2OovFZ/bU2NZWfC4bSPRbEK+zWLW?=
 =?us-ascii?Q?BD4/RGNbtp+WzRGw67/00OibzB5svtCy4MU3q96JxBsU4qFV1iIJ9Gmhmrel?=
 =?us-ascii?Q?VzIN2r6aoVoWCciWwWDyMNnFhcmHRoP8oNpa1dpAVyqFeJdgQb25yEsI26HB?=
 =?us-ascii?Q?n8r9DYaRw/WOIk7sEKAHmrvVNyB1h5Rc8iN8dFIXVvWo+4nFKkHFQNe7P0zM?=
 =?us-ascii?Q?TgYWDNdTqjfJBPh4cKFYHfP7RbzXN9hesSD3ypUAUL5R6shjaumOpYTIg1SG?=
 =?us-ascii?Q?xGxXA2rWp8fC4eU/8KMouNRfeUan6z6i1pVrI/kLK3xE6oZlDko9o9b0y4zY?=
 =?us-ascii?Q?q+8e1zO681icRXX3ovX4aHmE8q66qF2/8gazUeBI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e44ca07-5ddf-4cd2-bd2f-08ddad007ede
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:20.3473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxeM2KeVo3e2IcbD1HovkLFqrfOsB0GuTBFOmhY/tndErCChBjgTP+Xfo27NbhkU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

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
index 205c232bda68b5..bae87ff34b8043 100644
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
index b51de39c03c431..1fe5106997f833 100644
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


