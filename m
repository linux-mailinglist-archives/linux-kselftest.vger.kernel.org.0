Return-Path: <linux-kselftest+bounces-32361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44938AA957B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF8E3BCDC2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3AF25D1E9;
	Mon,  5 May 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DUnpmqtm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0E258CCB;
	Mon,  5 May 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454750; cv=fail; b=lQ+OLZ2mQHg6/E5Py/jPyNhFKzfq1NB+pmBEpNs9E8Hz9V16peqAAT2zFhenOMpqLdYv+mcMhX/53FZ1rAcLYkhEf6u5SFyO3MtC0FnAc6ZTAW1f55OP1d6jFdQ3DZlyXSeRyQ2YmSSEi06rNbk4CS1tBj1Izs11kDw/8nuvcms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454750; c=relaxed/simple;
	bh=XKqMjMJS+ZutSY84hZMOA/jraCtvuPE0p/gOYZ8OlpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvNrxlJ27H/i1JaQ6IzfOdSt10Y9YnIOhALq+sm5qxXPNamTvO3Dw5kbsK/46IaaeXSonLqI24ra8gnDgIvKoW3nkUrqfK4PARtuICibtMKRl7IQRJNcLHIO+B67bBs47gJQB0UuyW6kLVRBe7UFpjWWrMMIHdh8Wt1dQFQVUFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DUnpmqtm; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LanzOOOAxOZbP2Q7xPg/TIiGhBiz6qx1vi6wjID8kWNB7FWP0sHwZH8gH5auK+w76/SWW3YFbXHdvlWPEevVINPPSkVbUN1QvL/v2FLalb3Ftl8THSNJfpgoIR/ctPuVHSZtLLJ5BuksJXLw7tFnIdeCKYsc63hSjX3FDaioWnYAFID30PCcl7lRo+YoK+ptvjuz4C4KC0WbYpOKG6+Q9JlQrHsVC5VM5kukcKyA4pHb7RWM6jj/cfQQLY4k/oyaJUHwS4ncsNUVKIbpx9dPrmGWmyCfTY6PY+uTTx2l4K554ynp1DACtkEO+PUXb4HW26a6wkgwAmtJjBBWREjv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9qtfaEOt0aulBmfB79IF6A2mGFDRu41cVFQNmKfxsU=;
 b=B7NAwkjKO+f8LCnKsk/0zmSGoGh81LUnaxyRlqB5Zcw43n75GNP/9JXnhtiFzczoIG//ip2v9Hwk6F9wsaofIPNM4d3X5halRRBZ8wMk/xpEtW2pCUg7LDnKEP18Vk+JCvP8p9lIqKhABOq8k5ju94rZ6m0bjuZWXBpRkl3CnorgBNzil02puqPzp8GkwFSfIkOBEw192UN2UydlnqPUxdBiccS+1a6PLntrNP8kU+Z0tTH6fugsZLPpDw/7Htp3bs5TpDXEFP/ui4/nVibsFhsnxxH5l90j8sGLWrgOg6RntZvh+L77NlsuLDGMVFDCl3sNbeLx2K1LTk/oDBp/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9qtfaEOt0aulBmfB79IF6A2mGFDRu41cVFQNmKfxsU=;
 b=DUnpmqtm/lSs7aBkGs7bXFknk83RKQM6/RZEiwUzpC8x0LrrVU89F1JVNVwDf89ypTr9onfz3f9TnE9e+rJr/ft5RsNaakJcQNlp2Wv6GVofzQMK4ELknF02HruFCOU1vCMceSm7Vgl7unpSRtgjnwqdniCR4efO0OFjhCooFstAeDghDGQB4co7NnDHdgyGOKnQkkvfN3Gds0jub23P03obzOI5PLForwtCTzTCSXpWEmgZAXeOL2g0UFEqnd1Gc4FOrUZ26/qcjHaniFQJSz3n6TncrMGeRjflbCHQkPME3IPh2CTBZNoZouTQEIRBViNDd7bS6CT2XrqkuUoxyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:51 +0000
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
Subject: [PATCH v2 14/15] iommu/amd: Remove AMD io_pgtable support
Date: Mon,  5 May 2025 11:18:44 -0300
Message-ID: <14-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:408:ea::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b3bb06-6233-4206-b4c5-08dd8bdfc081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2RnBgzni5u9ZfcMxrCMAUm0Sn4J+7suwwI1MNyVSRcLrk73nb2AVZYs5ZRVV?=
 =?us-ascii?Q?yec0Pxptk7RJjNZRimXyj1nEPqmKOVxMTBIWdz2Qrt3I0WTDueQjARkbSMgw?=
 =?us-ascii?Q?j/FS4BCbPXE5SnUb4cwPMnfSg6HHV6B1TcAt8xbwUaR0M8AQC8GuDLeuR065?=
 =?us-ascii?Q?939L9fYC5WbhXftkrmmBnF+G/RVlY7G1Xud6sQMqsdn1ojBTxd/lnmy/oHHZ?=
 =?us-ascii?Q?Wc4yt9gDH6tdLTyrKHe8CfMO/0HCExBjDKYYfUVERYzzheJzS/5/FXavTgtV?=
 =?us-ascii?Q?q7lwq7/Q3tSiftNIOkhaYOV6Y0latc32d/6Ykwu6yKMg2keqJtH8KPQNK52s?=
 =?us-ascii?Q?QeBJRHKSPnoxhUKD04n36D9K3w0SPGTX520z6aC3j8r5BG/Af3fX0ufIHHxV?=
 =?us-ascii?Q?hXGUN/QKJ/2F8x8E9kR6MQR66rercnBMj0uTV1Hbyyvi2JPqDbw+sPkwdb2Q?=
 =?us-ascii?Q?nthiI8INrJOVvGknev6ke36tBUwDDvypBvc57Cwu3FuFZ6wRFJbNjJ4nqlh/?=
 =?us-ascii?Q?GCpeNrlNyFeGsDRO+RwlNDMRlR0Xomhd3wQastvxu5tyUyCRlbIiADLXUR8Z?=
 =?us-ascii?Q?U0k5IXj8+Yh1V/mY6ZO3tQJg0qQqbq66ze3D4w2H9G3KGKpO+cHnF0E/kQyF?=
 =?us-ascii?Q?7/mtOGd1by8RsVrUDELGEJ2f1AKNMPzCIyGea9V19S99seH4hcYL/tzhLWBB?=
 =?us-ascii?Q?oOvwjOw4IaI5bfE1C8V/8ivucB53dTM6P9HCFYFOB3bAY3DODCufMgaOgRjc?=
 =?us-ascii?Q?w+KpPbf1Jh5Y+yL/0HmkVOPl1ZFCV9Y0hoEKtdzQzxBHhSA1pxyHsF5anAzY?=
 =?us-ascii?Q?esl3UCcvnFRQdGSQWCFH0TcOlW2ZyjKNDjnvANMafFS6vULzFBxUCpV1LjXA?=
 =?us-ascii?Q?xPft5Icza7dJcn9AkD4ScWTXSqcuZaD0N9zYgbXVvbnZ4UBsS/hOiwQGxcOg?=
 =?us-ascii?Q?49ZjV9Ak0RyMq1f+3Q9KR1b9BDFCwGRoh10DPPYQELM24TqrPIx42njd62Q9?=
 =?us-ascii?Q?QxGbSt+Yfal0W8HygsRYz1AeHDp+x+KX3imWmiHk9eTIBO22puhigCPdramt?=
 =?us-ascii?Q?S7zjp+JU0L7ku8Ydqm12obNJfwfebnjxesTvaQHe1OOeq3hp7j9FS/aYrQAm?=
 =?us-ascii?Q?W4XJSo16SANAJ82+jFxNCPWgohQsrm07KmpvqWUoKujF7fYM+TjU+iibcf2f?=
 =?us-ascii?Q?GP8HNJ1xJD2dzTLJ7RLmHjUPdNvsDBFbN0mC8thdEdyqPyZnSjyn1ndQHbAD?=
 =?us-ascii?Q?Ks+U+bROl8/jnBL14VM7mSd3vyDxByvr3ZIsYL1zRQLGiyCXvzMZU53a8+v4?=
 =?us-ascii?Q?KTsyVNtY4L3HVWFRbb0hDzjLC9QLnHcmzTbQWFpHY0BqiCwiBzCn4O9b8XZ8?=
 =?us-ascii?Q?LASObXARp1mGXC6o9mg6u7wtMXmGREb28CXTcuVo0M/4/iek4U/ZQxpsBalz?=
 =?us-ascii?Q?FyeH1Nv2oeBxZNDRK4J13F6uES/N07yaTgAoymrB+8b65Bs2CuVDuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jWNd2NJ4YnRNa1EYB3YXkG85ZVAmKkgPYBRk3rmvis4on1j75JdiMZy7mamq?=
 =?us-ascii?Q?Sb4L1lq2VEClsTliE7LfzIHgspkbSQ9LCX3q15DO5b2IOexpccO0xypb7AAI?=
 =?us-ascii?Q?GVru5GHpdI+/KJy3yJJIEOSAqVGJcuS1pZcRfkuP2MUFMdOZdgwTeEHM+SE+?=
 =?us-ascii?Q?oY2ThjbnKjB6QjtsbGvEpWrr5D7BRqaZ7eyF3FNNogxqXA7OGsrypr0vKzoI?=
 =?us-ascii?Q?kjpiluGESlvXZb5eB1OS/UsFtOezl41g5ntTKa0Nja5TCfGK4faYIRJyqFS1?=
 =?us-ascii?Q?xofxQThaiDNLBn+ZFjbZNZ12VlR6ab9qVzAjTzqhQq3J/zSPGIy2kSiRKRXa?=
 =?us-ascii?Q?TzSW80Hkq1TXBlx7kKp9ZGD5jiVCjmpV1/iqIKBlJMPrsktIj8Pgfv7SWD1A?=
 =?us-ascii?Q?nUOPepdnPkjEQr9B4KXmTSU/CeBF2YKyesgcW4YQDblvk+EPNxXvQ4USJjyO?=
 =?us-ascii?Q?J1dvt7ll43Au2VW3smKi25HAV/BBxYJEcZjH89g273L6eTcEjMDgudjntH+X?=
 =?us-ascii?Q?oeLIjniAi692m4xuHj8hgyVoj9R/cqwz5mbyXd1eWANmOgLKpLuBL5/5yreW?=
 =?us-ascii?Q?DO8+Eg0kOg/fkUvpo8rYp/UoErmtnI3X6CeSUJYDWQIvpam5BIJ/zrTIx+OT?=
 =?us-ascii?Q?vEWsWAKvPAJQTsnHPLFjj25Prrj2ljMw3CwhZYsewtiDY/EsKggLbKWZm7w+?=
 =?us-ascii?Q?iLdZzK5iDhAYCcVIc+w7q6JsjiL3QMFaw1LzieLUxVHAqCMVDs7l6yJvTO/C?=
 =?us-ascii?Q?xy35Q+XHFdsj0++I0XrnPVZ2koINe7wfPXBHaa9X1c4ueIpTtNdwmq4xP1wq?=
 =?us-ascii?Q?l81oU0PX6GVD1UHMiCTa2QQ6oIUBwH7VQA+NruEYk3KbdHlq3Ce97SscfUKb?=
 =?us-ascii?Q?Xu27LNjoohmX/itdzEXKlZE2W6tzzspxfDabBxJVjnoU4T27BIdrlssCFhJM?=
 =?us-ascii?Q?hoaX1fCmB/l3cR/wMJT7l1CnG52cW0rYjU7PfY19XEz6zR6wY3/cd/Aq2/kY?=
 =?us-ascii?Q?PySa/ug5oMNqisJimG7oFY5GazS2Nmi1DDsYHc8jkrW0+7kuB3uRs5NDyjG7?=
 =?us-ascii?Q?1kmmLjoC5pHoRKIibvzMjTJt3gHyFkmA6SJmcJ826O7EGAuF3ac7yLRh/XOd?=
 =?us-ascii?Q?ciefHan7QKDNJ0qPZ65ttrGdgkR0alEha65iWoqbwAeAhqProhIVAiAmEO3Q?=
 =?us-ascii?Q?djGdIj35c+PvOSrPyxz7LT1kvOhPVTZtHu2NhpBGGVIu2RlbsNicPBSPGEoB?=
 =?us-ascii?Q?WL5Wpi7C9zlMsc9os9adQyU5jd4eyrvNkFs349Cf0VoT9fszGxtHT4EKpAnc?=
 =?us-ascii?Q?aFZR4i5s6VpBb/o5N62mnLCL4SPDJZZRn23lPVSQhtLxmvtx9wy5AO0exmtG?=
 =?us-ascii?Q?M4n+GT1Vr1Ead1x3k/ILBOIxq8aWnmnxApWVtuuqpxOKRJYzf4p6xtcb2rlF?=
 =?us-ascii?Q?X7OTQZzq7+9wFSCI9+i3uHTZmxa3zrgT94ZWPQUWNEAdoXuB2x+U02xnKKsF?=
 =?us-ascii?Q?Mtmz8UFj5q/4fDvqfCGBIF18R/Bh9Cqtjug8tj4Zweat95zfl8KdrxlBBtGy?=
 =?us-ascii?Q?uz9Nod3XY1vco9d1jRCeNJSNBgSj70ywWfqLQLpj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b3bb06-6233-4206-b4c5-08dd8bdfc081
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:48.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywo7jKq5cUm655WUp6oDQRgLAotT0TxWlEffonuVS/wKhR1I1EAHFWxhNAyW/kmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

None of this is used anymore, delete it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |  97 -----
 drivers/iommu/amd/io_pgtable.c      | 559 ----------------------------
 drivers/iommu/amd/io_pgtable_v2.c   | 370 ------------------
 drivers/iommu/io-pgtable.c          |   4 -
 include/linux/io-pgtable.h          |   2 -
 6 files changed, 1 insertion(+), 1033 deletions(-)
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 9de33b2d42f526..28535a210dd8e9 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index abd05ef75239d4..410808c265a719 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
-#include <linux/io-pgtable.h>
 #include <linux/generic_pt/iommu.h>
 
 /*
@@ -336,76 +335,7 @@
 #define GUEST_PGTABLE_4_LEVEL	0x00
 #define GUEST_PGTABLE_5_LEVEL	0x01
 
-#define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
-#define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
-				   (0xffffffffffffffffULL))
-#define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
-#define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
-#define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
-#define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
-
-#define PM_MAP_4k		0
 #define PM_ADDR_MASK		0x000ffffffffff000ULL
-#define PM_MAP_MASK(lvl)	(PM_ADDR_MASK & \
-				(~((1ULL << (12 + ((lvl) * 9))) - 1)))
-#define PM_ALIGNED(lvl, addr)	((PM_MAP_MASK(lvl) & (addr)) == (addr))
-
-/*
- * Returns the page table level to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_LEVEL(pagesize) \
-		((__ffs(pagesize) - 12) / 9)
-/*
- * Returns the number of ptes to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_PTE_COUNT(pagesize) \
-		(1ULL << ((__ffs(pagesize) - 12) % 9))
-
-/*
- * Aligns a given io-virtual address to a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_ALIGN(address, pagesize) \
-		((address) & ~((pagesize) - 1))
-/*
- * Creates an IOMMU PTE for an address and a given pagesize
- * The PTE has no permission bits set
- * Pagesize is expected to be a power-of-two larger than 4096
- */
-#define PAGE_SIZE_PTE(address, pagesize)		\
-		(((address) | ((pagesize) - 1)) &	\
-		 (~(pagesize >> 1)) & PM_ADDR_MASK)
-
-/*
- * Takes a PTE value with mode=0x07 and returns the page size it maps
- */
-#define PTE_PAGE_SIZE(pte) \
-	(1ULL << (1 + ffz(((pte) | 0xfffULL))))
-
-/*
- * Takes a page-table level and returns the default page-size for this level
- */
-#define PTE_LEVEL_PAGE_SIZE(level)			\
-	(1ULL << (12 + (9 * (level))))
-
-/*
- * The IOPTE dirty bit
- */
-#define IOMMU_PTE_HD_BIT (6)
-
-/*
- * Bit value definition for I/O PTE fields
- */
-#define IOMMU_PTE_PR	BIT_ULL(0)
-#define IOMMU_PTE_HD	BIT_ULL(IOMMU_PTE_HD_BIT)
-#define IOMMU_PTE_U	BIT_ULL(59)
-#define IOMMU_PTE_FC	BIT_ULL(60)
-#define IOMMU_PTE_IR	BIT_ULL(61)
-#define IOMMU_PTE_IW	BIT_ULL(62)
 
 /*
  * Bit value definition for DTE fields
@@ -435,12 +365,6 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
-#define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
-#define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
-#define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
-
 #define IOMMU_PROT_MASK 0x03
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
@@ -530,19 +454,6 @@ struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
 
-#define io_pgtable_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl)
-
-#define io_pgtable_ops_to_data(x) \
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-#define io_pgtable_ops_to_domain(x) \
-	container_of(io_pgtable_ops_to_data(x), \
-		     struct protection_domain, iop)
-
-#define io_pgtable_cfg_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl.cfg)
-
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
@@ -550,13 +461,6 @@ struct gcr3_tbl_info {
 	u16	domid;		/* Per device domain ID */
 };
 
-struct amd_io_pgtable {
-	struct io_pgtable	pgtbl;
-	int			mode;
-	u64			*root;
-	u64			*pgd;		/* v2 pgtable pgd pointer */
-};
-
 enum protection_domain_mode {
 	PD_MODE_V1 = 1,
 	PD_MODE_V2,
@@ -590,7 +494,6 @@ struct protection_domain {
 		struct pt_iommu_x86_64 amdv2;
 	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
deleted file mode 100644
index e4b33eba554599..00000000000000
--- a/drivers/iommu/amd/io_pgtable.c
+++ /dev/null
@@ -1,559 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table allocator.
- *
- * Copyright (C) 2020 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- */
-
-#define pr_fmt(fmt)     "AMD-Vi: " fmt
-#define dev_fmt(fmt)    pr_fmt(fmt)
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-/*
- * Helper function to get the first pte of a large mapping
- */
-static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
-			 unsigned long *count)
-{
-	unsigned long pte_mask, pg_size, cnt;
-	u64 *fpte;
-
-	pg_size  = PTE_PAGE_SIZE(*pte);
-	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
-	pte_mask = ~((cnt << 3) - 1);
-	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
-
-	if (page_size)
-		*page_size = pg_size;
-
-	if (count)
-		*count = cnt;
-
-	return fpte;
-}
-
-static void free_pt_lvl(u64 *pt, struct iommu_pages_list *freelist, int lvl)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		/* Large PTE? */
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||
-		    PM_PTE_LEVEL(pt[i]) == 7)
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = IOMMU_PTE_PAGE(pt[i]);
-		if (lvl > 2)
-			free_pt_lvl(p, freelist, lvl - 1);
-		else
-			iommu_pages_list_add(freelist, p);
-	}
-
-	iommu_pages_list_add(freelist, pt);
-}
-
-static void free_sub_pt(u64 *root, int mode, struct iommu_pages_list *freelist)
-{
-	switch (mode) {
-	case PAGE_MODE_NONE:
-	case PAGE_MODE_7_LEVEL:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		iommu_pages_list_add(freelist, root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-	case PAGE_MODE_3_LEVEL:
-	case PAGE_MODE_4_LEVEL:
-	case PAGE_MODE_5_LEVEL:
-	case PAGE_MODE_6_LEVEL:
-		free_pt_lvl(root, freelist, mode);
-		break;
-	default:
-		BUG();
-	}
-}
-
-/*
- * This function is used to add another level to an IO page table. Adding
- * another level increases the size of the address space by 9 bits to a size up
- * to 64 bits.
- */
-static bool increase_address_space(struct amd_io_pgtable *pgtable,
-				   unsigned long address,
-				   unsigned int page_size_level,
-				   gfp_t gfp)
-{
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	struct protection_domain *domain =
-		container_of(pgtable, struct protection_domain, iop);
-	unsigned long flags;
-	bool ret = true;
-	u64 *pte;
-
-	pte = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp, SZ_4K);
-	if (!pte)
-		return false;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (address <= PM_LEVEL_SIZE(pgtable->mode) &&
-	    pgtable->mode - 1 >= page_size_level)
-		goto out;
-
-	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == PAGE_MODE_6_LEVEL))
-		goto out;
-
-	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
-
-	pgtable->root  = pte;
-	pgtable->mode += 1;
-
-	pte = NULL;
-	ret = true;
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-	iommu_free_pages(pte);
-
-	return ret;
-}
-
-static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long page_size,
-		      u64 **pte_page,
-		      gfp_t gfp,
-		      bool *updated)
-{
-	unsigned long last_addr = address + (page_size - 1);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	int level, end_lvl;
-	u64 *pte, *page;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	while (last_addr > PM_LEVEL_SIZE(pgtable->mode) ||
-	       pgtable->mode - 1 < PAGE_SIZE_LEVEL(page_size)) {
-		/*
-		 * Return an error if there is no memory to update the
-		 * page-table.
-		 */
-		if (!increase_address_space(pgtable, last_addr,
-					    PAGE_SIZE_LEVEL(page_size), gfp))
-			return NULL;
-	}
-
-
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	address = PAGE_SIZE_ALIGN(address, page_size);
-	end_lvl = PAGE_SIZE_LEVEL(page_size);
-
-	while (level > end_lvl) {
-		u64 __pte, __npte;
-		int pte_level;
-
-		__pte     = *pte;
-		pte_level = PM_PTE_LEVEL(__pte);
-
-		/*
-		 * If we replace a series of large PTEs, we need
-		 * to tear down all of them.
-		 */
-		if (IOMMU_PTE_PRESENT(__pte) &&
-		    pte_level == PAGE_MODE_7_LEVEL) {
-			unsigned long count, i;
-			u64 *lpte;
-
-			lpte = first_pte_l7(pte, NULL, &count);
-
-			/*
-			 * Unmap the replicated PTEs that still match the
-			 * original large mapping
-			 */
-			for (i = 0; i < count; ++i)
-				cmpxchg64(&lpte[i], __pte, 0ULL);
-
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE) {
-			page = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp,
-							 SZ_4K);
-
-			if (!page)
-				return NULL;
-
-			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
-
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		/* No level skipping support yet */
-		if (pte_level != level)
-			return NULL;
-
-		level -= 1;
-
-		pte = IOMMU_PTE_PAGE(__pte);
-
-		if (pte_page && level == end_lvl)
-			*pte_page = pte;
-
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address. If
- * there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long *page_size)
-{
-	int level;
-	u64 *pte;
-
-	*page_size = 0;
-
-	if (address > PM_LEVEL_SIZE(pgtable->mode))
-		return NULL;
-
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
-
-	while (level > 0) {
-
-		/* Not Present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
-		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
-			break;
-
-		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
-			return NULL;
-
-		level -= 1;
-
-		/* Walk to the next level */
-		pte	   = IOMMU_PTE_PAGE(*pte);
-		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
-		*page_size = PTE_LEVEL_PAGE_SIZE(level);
-	}
-
-	/*
-	 * If we have a series of large PTEs, make
-	 * sure to return a pointer to the first one.
-	 */
-	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
-		pte = first_pte_l7(pte, page_size, NULL);
-
-	return pte;
-}
-
-static void free_clear_pte(u64 *pte, u64 pteval,
-			   struct iommu_pages_list *freelist)
-{
-	u64 *pt;
-	int mode;
-
-	while (!try_cmpxchg64(pte, &pteval, 0))
-		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-
-	if (!IOMMU_PTE_PRESENT(pteval))
-		return;
-
-	pt   = IOMMU_PTE_PAGE(pteval);
-	mode = IOMMU_PTE_MODE(pteval);
-
-	free_sub_pt(pt, mode, freelist);
-}
-
-/*
- * Generic mapping functions. It maps a physical address into a DMA
- * address space. It allocates the page table pages if necessary.
- * In the future it can be extended to a generic mapping function
- * supporting all features of AMD IOMMU page tables like level skipping
- * and full 64 bit address spaces.
- */
-static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-	bool updated = false;
-	u64 __pte, *pte;
-	int ret, i, count;
-	size_t size = pgcount << __ffs(pgsize);
-	unsigned long o_iova = iova;
-
-	BUG_ON(!IS_ALIGNED(iova, pgsize));
-	BUG_ON(!IS_ALIGNED(paddr, pgsize));
-
-	ret = -EINVAL;
-	if (!(prot & IOMMU_PROT_MASK))
-		goto out;
-
-	while (pgcount > 0) {
-		count = PAGE_SIZE_PTE_COUNT(pgsize);
-		pte   = alloc_pte(pgtable, iova, pgsize, NULL, gfp, &updated);
-
-		ret = -ENOMEM;
-		if (!pte)
-			goto out;
-
-		for (i = 0; i < count; ++i)
-			free_clear_pte(&pte[i], pte[i], &freelist);
-
-		if (!iommu_pages_list_empty(&freelist))
-			updated = true;
-
-		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
-			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-
-		if (prot & IOMMU_PROT_IR)
-			__pte |= IOMMU_PTE_IR;
-		if (prot & IOMMU_PROT_IW)
-			__pte |= IOMMU_PTE_IW;
-
-		for (i = 0; i < count; ++i)
-			pte[i] = __pte;
-
-		iova  += pgsize;
-		paddr += pgsize;
-		pgcount--;
-		if (mapped)
-			*mapped += pgsize;
-	}
-
-	ret = 0;
-
-out:
-	if (updated) {
-		struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&dom->lock, flags);
-		/*
-		 * Flush domain TLB(s) and wait for completion. Any Device-Table
-		 * Updates and flushing already happened in
-		 * increase_address_space().
-		 */
-		amd_iommu_domain_flush_pages(dom, o_iova, size);
-		spin_unlock_irqrestore(&dom->lock, flags);
-	}
-
-	/* Everything flushed out, free pages now */
-	iommu_put_pages_list(&freelist);
-
-	return ret;
-}
-
-static unsigned long iommu_v1_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long long unmapped;
-	unsigned long unmap_size;
-	u64 *pte;
-	size_t size = pgcount << __ffs(pgsize);
-
-	BUG_ON(!is_power_of_2(pgsize));
-
-	unmapped = 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (pte) {
-			int i, count;
-
-			count = PAGE_SIZE_PTE_COUNT(unmap_size);
-			for (i = 0; i < count; i++)
-				pte[i] = 0ULL;
-		} else {
-			return unmapped;
-		}
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-static bool pte_test_and_clear_dirty(u64 *ptep, unsigned long size,
-				     unsigned long flags)
-{
-	bool test_only = flags & IOMMU_DIRTY_NO_CLEAR;
-	bool dirty = false;
-	int i, count;
-
-	/*
-	 * 2.2.3.2 Host Dirty Support
-	 * When a non-default page size is used , software must OR the
-	 * Dirty bits in all of the replicated host PTEs used to map
-	 * the page. The IOMMU does not guarantee the Dirty bits are
-	 * set in all of the replicated PTEs. Any portion of the page
-	 * may have been written even if the Dirty bit is set in only
-	 * one of the replicated PTEs.
-	 */
-	count = PAGE_SIZE_PTE_COUNT(size);
-	for (i = 0; i < count && test_only; i++) {
-		if (test_bit(IOMMU_PTE_HD_BIT, (unsigned long *)&ptep[i])) {
-			dirty = true;
-			break;
-		}
-	}
-
-	for (i = 0; i < count && !test_only; i++) {
-		if (test_and_clear_bit(IOMMU_PTE_HD_BIT,
-				       (unsigned long *)&ptep[i])) {
-			dirty = true;
-		}
-	}
-
-	return dirty;
-}
-
-static int iommu_v1_read_and_clear_dirty(struct io_pgtable_ops *ops,
-					 unsigned long iova, size_t size,
-					 unsigned long flags,
-					 struct iommu_dirty_bitmap *dirty)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long end = iova + size - 1;
-
-	do {
-		unsigned long pgsize = 0;
-		u64 *ptep, pte;
-
-		ptep = fetch_pte(pgtable, iova, &pgsize);
-		if (ptep)
-			pte = READ_ONCE(*ptep);
-		if (!ptep || !IOMMU_PTE_PRESENT(pte)) {
-			pgsize = pgsize ?: PTE_LEVEL_PAGE_SIZE(0);
-			iova += pgsize;
-			continue;
-		}
-
-		/*
-		 * Mark the whole IOVA range as dirty even if only one of
-		 * the replicated PTEs were marked dirty.
-		 */
-		if (pte_test_and_clear_dirty(ptep, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v1_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
-
-	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
-	iommu_put_pages_list(&freelist);
-}
-
-static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-
-	pgtable->root =
-		iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->root)
-		return NULL;
-	pgtable->mode = PAGE_MODE_3_LEVEL;
-
-	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v1_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v1_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v1_iova_to_phys;
-	pgtable->pgtbl.ops.read_and_clear_dirty = iommu_v1_read_and_clear_dirty;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
-	.alloc	= v1_alloc_pgtable,
-	.free	= v1_free_pgtable,
-};
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
deleted file mode 100644
index b47941353ccbb8..00000000000000
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ /dev/null
@@ -1,370 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table v2 allocator.
- *
- * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- * Author: Vasant Hegde <vasant.hegde@amd.com>
- */
-
-#define pr_fmt(fmt)	"AMD-Vi: " fmt
-#define dev_fmt(fmt)	pr_fmt(fmt)
-
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-#define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
-#define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
-#define IOMMU_PAGE_USER		BIT_ULL(2)	/* Userspace addressable */
-#define IOMMU_PAGE_PWT		BIT_ULL(3)	/* Page write through */
-#define IOMMU_PAGE_PCD		BIT_ULL(4)	/* Page cache disabled */
-#define IOMMU_PAGE_ACCESS	BIT_ULL(5)	/* Was accessed (updated by IOMMU) */
-#define IOMMU_PAGE_DIRTY	BIT_ULL(6)	/* Was written to (updated by IOMMU) */
-#define IOMMU_PAGE_PSE		BIT_ULL(7)	/* Page Size Extensions */
-#define IOMMU_PAGE_NX		BIT_ULL(63)	/* No execute */
-
-#define MAX_PTRS_PER_PAGE	512
-
-#define IOMMU_PAGE_SIZE_2M	BIT_ULL(21)
-#define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
-
-
-static inline int get_pgtable_level(void)
-{
-	return amd_iommu_gpt_level;
-}
-
-static inline bool is_large_pte(u64 pte)
-{
-	return (pte & IOMMU_PAGE_PSE);
-}
-
-static inline u64 set_pgtable_attr(u64 *page)
-{
-	u64 prot;
-
-	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS;
-
-	return (iommu_virt_to_phys(page) | prot);
-}
-
-static inline void *get_pgtable_pte(u64 pte)
-{
-	return iommu_phys_to_virt(pte & PM_ADDR_MASK);
-}
-
-static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
-{
-	u64 pte;
-
-	pte = __sme_set(paddr & PM_ADDR_MASK);
-	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
-	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
-
-	if (prot & IOMMU_PROT_IW)
-		pte |= IOMMU_PAGE_RW;
-
-	/* Large page */
-	if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
-		pte |= IOMMU_PAGE_PSE;
-
-	return pte;
-}
-
-static inline u64 get_alloc_page_size(u64 size)
-{
-	if (size >= IOMMU_PAGE_SIZE_1G)
-		return IOMMU_PAGE_SIZE_1G;
-
-	if (size >= IOMMU_PAGE_SIZE_2M)
-		return IOMMU_PAGE_SIZE_2M;
-
-	return PAGE_SIZE;
-}
-
-static inline int page_size_to_level(u64 pg_size)
-{
-	if (pg_size == IOMMU_PAGE_SIZE_1G)
-		return PAGE_MODE_3_LEVEL;
-	if (pg_size == IOMMU_PAGE_SIZE_2M)
-		return PAGE_MODE_2_LEVEL;
-
-	return PAGE_MODE_1_LEVEL;
-}
-
-static void free_pgtable(u64 *pt, int level)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < MAX_PTRS_PER_PAGE; i++) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		if (is_large_pte(pt[i]))
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = get_pgtable_pte(pt[i]);
-		if (level > 2)
-			free_pgtable(p, level - 1);
-		else
-			iommu_free_pages(p);
-	}
-
-	iommu_free_pages(pt);
-}
-
-/* Allocate page table */
-static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
-			 unsigned long pg_size, gfp_t gfp, bool *updated)
-{
-	u64 *pte, *page;
-	int level, end_level;
-
-	level = get_pgtable_level() - 1;
-	end_level = page_size_to_level(pg_size);
-	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
-	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
-
-	while (level >= end_level) {
-		u64 __pte, __npte;
-
-		__pte = *pte;
-
-		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
-			/* Unmap large pte */
-			cmpxchg64(pte, *pte, 0ULL);
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = iommu_alloc_pages_node_sz(nid, gfp, SZ_4K);
-			if (!page)
-				return NULL;
-
-			__npte = set_pgtable_attr(page);
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		level -= 1;
-		pte = get_pgtable_pte(__pte);
-		pte = &pte[PM_LEVEL_INDEX(level, iova)];
-	}
-
-	/* Tear down existing pte entries */
-	if (IOMMU_PTE_PRESENT(*pte)) {
-		u64 *__pte;
-
-		*updated = true;
-		__pte = get_pgtable_pte(*pte);
-		cmpxchg64(pte, *pte, 0ULL);
-		if (pg_size == IOMMU_PAGE_SIZE_1G)
-			free_pgtable(__pte, end_level - 1);
-		else if (pg_size == IOMMU_PAGE_SIZE_2M)
-			iommu_free_pages(__pte);
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address.
- * If there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long iova, unsigned long *page_size)
-{
-	u64 *pte;
-	int level;
-
-	level = get_pgtable_level() - 1;
-	pte = &pgtable->pgd[PM_LEVEL_INDEX(level, iova)];
-	/* Default page size is 4K */
-	*page_size = PAGE_SIZE;
-
-	while (level) {
-		/* Not present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Walk to the next level */
-		pte = get_pgtable_pte(*pte);
-		pte = &pte[PM_LEVEL_INDEX(level - 1, iova)];
-
-		/* Large page */
-		if (is_large_pte(*pte)) {
-			if (level == PAGE_MODE_3_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_1G;
-			else if (level == PAGE_MODE_2_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_2M;
-			else
-				return NULL;	/* Wrongly set PSE bit in PTE */
-
-			break;
-		}
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
-static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	u64 *pte;
-	unsigned long map_size;
-	unsigned long mapped_size = 0;
-	unsigned long o_iova = iova;
-	size_t size = pgcount << __ffs(pgsize);
-	int ret = 0;
-	bool updated = false;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize) || !pgcount)
-		return -EINVAL;
-
-	if (!(prot & IOMMU_PROT_MASK))
-		return -EINVAL;
-
-	while (mapped_size < size) {
-		map_size = get_alloc_page_size(pgsize);
-		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
-				   iova, map_size, gfp, &updated);
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		*pte = set_pte_attr(paddr, map_size, prot);
-
-		iova += map_size;
-		paddr += map_size;
-		mapped_size += map_size;
-	}
-
-out:
-	if (updated) {
-		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&pdom->lock, flags);
-		amd_iommu_domain_flush_pages(pdom, o_iova, size);
-		spin_unlock_irqrestore(&pdom->lock, flags);
-	}
-
-	if (mapped)
-		*mapped += mapped_size;
-
-	return ret;
-}
-
-static unsigned long iommu_v2_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	unsigned long unmap_size;
-	unsigned long unmapped = 0;
-	size_t size = pgcount << __ffs(pgsize);
-	u64 *pte;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
-		return 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (!pte)
-			return unmapped;
-
-		*pte = 0ULL;
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v2_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-
-	if (!pgtable || !pgtable->pgd)
-		return;
-
-	/* Free page table */
-	free_pgtable(pgtable->pgd, get_pgtable_level());
-	pgtable->pgd = NULL;
-}
-
-static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-	int ias = IOMMU_IN_ADDR_BIT_SIZE;
-
-	pgtable->pgd = iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->pgd)
-		return NULL;
-
-	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
-		ias = 57;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v2_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v2_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v2_iova_to_phys;
-
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-	cfg->ias           = ias;
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
-	.alloc	= v2_alloc_pgtable,
-	.free	= v2_free_pgtable,
-};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 8841c1487f0048..843fec8e8a511c 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -28,10 +28,6 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
-#ifdef CONFIG_AMD_IOMMU
-	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
-	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
-#endif
 };
 
 static int check_custom_allocator(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index bba2a51c87d26f..ef9be258069de0 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -15,8 +15,6 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S2,
 	ARM_V7S,
 	ARM_MALI_LPAE,
-	AMD_IOMMU_V1,
-	AMD_IOMMU_V2,
 	APPLE_DART,
 	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
-- 
2.43.0


