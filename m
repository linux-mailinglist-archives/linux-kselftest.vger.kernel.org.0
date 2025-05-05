Return-Path: <linux-kselftest+bounces-32347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C3AA9557
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB5A189BDF3
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281025B66A;
	Mon,  5 May 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="egI7DxMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC971F2BB5;
	Mon,  5 May 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454735; cv=fail; b=XvpW9LAiFRFHM9OxfIiHxuCk9UnXCzbDeJUkKsThp9lHzWxZDmXqW4PrCvTW3U/mwOujiFsHhk09vtZRsFiXXM3XQc3mIc1bgk6wwqSRy+VKVcAL1LM3vMn+Z9WtyQo2WspFh0vCy+sv1qAuT+zsRVDnDsBzEM3+Y2TKcSFGmpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454735; c=relaxed/simple;
	bh=4grURdNgXlBzW41chNneTs82/hEN8fYNFUBYbNa9nQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/UdWSuKGp0X0CW7k2JT9MD730nFFNFVunybiY6zEVKH5XU5r0CVVWH/NHU/bAJco89BoxkWNugTySEG0kEejBdBrE/SjBylV/GwOym74bd4FzxvHxgPcht78SGu+caXSk2pxeY06dmttN2uEwW2OXcEl7/vz4Ks/4rS8spXkeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=egI7DxMF; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWPMkZ8vnjW/eTmsZdsZREefHvmTvXeDxgphyu9NQsPUhGta/l9fLBLbReSvlmtNXUYCxM09PJ9d6/BWs/3OmqieQe3wdkyxhQSCSLLGdxbGxxmmDNl6fbUpRc2cZl9DXrPtgCM9B6U++ZEmEKnrgcBTwPBgneYv1Jq0JSVpR59ypmM3ttny5wgz4+ke8SSRE33AcaGzmG86zfIzfBZAtYPzPtK9mUu3gdrfXJcuFs9ki0+jwV6VWEsADHXUuxit9vPkHutrEOjoGmrtSla/uQqgE5NGaQ3MTqZW2x4sDoYRA8+Db3OwWrELH8iM1ssX9bFqTDuFQkXaibmN7DP7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gnqk0a2orMaoX8yf3I50dQPp2h8ScmPFTv44bwn8m6o=;
 b=sAAB0N6DfsM3tNKTW9YCYUuCA18qG29vUAccWJuC1dboOABle3XTgcC0H10GNtJKTr/gyslnnpzvSK9MpQ+zPTzIbZSi6t0JMKYDPdkJl58AW+GkhNLJqd3sVGurxfa9Nn0B0il22tztrP2N5PECtV1mV8Y2KhF1SmMkgX30LelCzLKXrMbX5ZLXqRzvb9FOKXNvqwKIEJsRZfnxnOCEufXnWARyYHim9w8VpHWJvtRvbNN3J/rYxI0G/AFp+tOuomUyPfdgbMRERn53lwqr2lWVvnO6lJ2BoxY4FPKDsQA77rLhdkAOmmqVNZw0GNAZa5Hu2CzJjX+eh5hypynnyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnqk0a2orMaoX8yf3I50dQPp2h8ScmPFTv44bwn8m6o=;
 b=egI7DxMFHo3/WzxOs/MJ+EWtLpDpRMlOpC3jiZnPJWhusRROX75S4gVyiFCR6p44jo9B6WssVO/FynvUsu8edIT4hxxHyGfggby7b8sMA0HZ1ROw7l8cfTjJAlaqn7BCrF5rzU7f4RwmudsIGxYmTOQXtQ2WC60x89KEj9B8pRbWZwAg+BbblGcD3PUpoIa2o4CoYlQnTdlH86SRbL9ZTamk8E7ApRJgAuplvmaTyo+R0yYQrpII8MpYZsCI4GGqDYkb0Hgju010F+x3T6eRRSJ4k+9KVIktmWTSoLQlqYfiTcr7huTc6MZ1TOBoaaqj4Jf02P/ghk1n/EuMADDJFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Mon, 5 May
 2025 14:18:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 14:18:48 +0000
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
Subject: [PATCH v2 10/15] iommupt: Add a mock pagetable format for iommufd selftest to use
Date: Mon,  5 May 2025 11:18:40 -0300
Message-ID: <10-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0469.namprd03.prod.outlook.com
 (2603:10b6:408:139::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe71e13-76c6-4fbd-1e9b-08dd8bdfbfc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YFlRCgq7fYPllGQK2W38f/tN75OkbgxRWHMxQGtVrCaBVRTKK9NyocBiYH6m?=
 =?us-ascii?Q?WAMBVZHJvwBuimQrsX0u514RJp1K0OiURr7GdhFBqbVdfUmt9JodP1erABYe?=
 =?us-ascii?Q?fczkM9ZfxbQ/ilccDIFHhUxSbPJzVQBwHRXlPOBuao/RLQKHN/EP2OS4SuM0?=
 =?us-ascii?Q?TAWypy1n1x0A6XV9O2VvYyiaVEaeUyr1dC/1A2l1PkBixC4bhRTF7Yer4a0B?=
 =?us-ascii?Q?n3DELELJLJRqmIf9zMepye6OEk1aDFBko9gvECA7dRWx4GHbgDj4ezKLTHfs?=
 =?us-ascii?Q?eSkT407dL298kP0NnYsFXWjx2bTjBLXQ2T3HWu4ewN47h8H3IE8vlQuIOw3q?=
 =?us-ascii?Q?RqwjDJoFyz8aY05hKylqPlSQVAsqrIUK17PUYprALzllvgw6EWsDnXW/Guer?=
 =?us-ascii?Q?LeZNUEdSALzF0MsWAjMsWGpBciDGHsPmK9PzGZEUVyPVRWFz75qrUWCsF/4C?=
 =?us-ascii?Q?tgdE05hSOHOtbMRzG35u2Tcs7J/oXDOROZqoqs+Qdw/56VXaEVXd/A+XB0Rc?=
 =?us-ascii?Q?kAcfs+ARF3oKpRJea9RyyphTw0PqqzVHmvOK3j9AY/fx3awMzovfi1nLA8bH?=
 =?us-ascii?Q?1C6215nyvYNICoEvHPbg4OnyLn7RYCFK3g9MRTQjcbAfGA7axfK8Zt+7is8k?=
 =?us-ascii?Q?a44wa2Nb5n6RH4dfopId9n3LKpX+X86aa0fmxTRNYhI5m3rSM+PZBpMrd1hO?=
 =?us-ascii?Q?Y+avhVLz01Jfso55gpOosqPQaV7U/FYQmTf+hihwqGFOFPL+GozDgj9iaqaU?=
 =?us-ascii?Q?p/CI7ejORm5f64f/QY37EAWEr7xVAlfpAIeVXoTlLEVDPdWyh64f73qVvFgd?=
 =?us-ascii?Q?UXQzVUccxFG9bcvwqkpmL0cgpGqZMhobL1XV7UqZARY1FzMilcDVyJKZEz3g?=
 =?us-ascii?Q?9UrrTs0w4/91A4qwenaq0ZTB9M/AMF8fzcJSAuf2pM5zZPcistjHe+KNjFVP?=
 =?us-ascii?Q?eeztGoorEq6TVUCa3C1cw91nRAInLXDpfPtrOp79BHAlAha/VakrnpNE4wwA?=
 =?us-ascii?Q?kChTg2MXe8ZiQpGFCd7MNysRCS/l/PoCMUovIe4FJirl97RzQgrI/PaLwlYw?=
 =?us-ascii?Q?PfizIicLoo1I8YTLVNvJyFEax7QhOMPp86TgLPkk8P8oyaAS+Xk+DIHMwLLe?=
 =?us-ascii?Q?WFRcNtyN46eepaxxu5iI6esv9hNBOutGbE2D+WZ3h6rs9Cx3CtunG+gemWV/?=
 =?us-ascii?Q?5vU8PWocn9zAkd0v2aTZ613XdcB90cvIU174Ed/uFGtVGSuoIMCPnkUsZjoW?=
 =?us-ascii?Q?EW04Vpr5fCZeU3K+Ku3eIYRg9aDUyBVpOkU2H3AHxOJOu5KRcYXbjYi4nC+A?=
 =?us-ascii?Q?qbHHCyJYnNmJFYUDdWJvdqANu6lj+xjZQrZkU8YtGDXPPsFThL2nxSZnXlA4?=
 =?us-ascii?Q?ugeN5i/hC3Znc4jTZCGleqN8M7oRGr+fkYQxI1b3H3YfGchnQjGOO0swAjhF?=
 =?us-ascii?Q?V+PQJ2Nl5549/bPwJX/zLw2vCIhWcibwlMMRQtFyFBd7K46U0jIuhw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hNUZd9A1wEC8OuOtv5WISC67TisNj0PCTDvNhqM9bW87rToDuwZcg0xtPZks?=
 =?us-ascii?Q?YFcP855i67HHATVNcKmfIYmFftz/VjyRgOQsX88SOgn5P8ObCn573iGqP4lE?=
 =?us-ascii?Q?4jCptMHBesNvjBbTu0sdqD5txto9iEKDl+2TrcMbbb68edx9znCe/UV+A6Qp?=
 =?us-ascii?Q?/6K8NsxXOOgSvH1WNP9Fo/29txY/b0Ilj/ZiJYR7p/C6+8yPRarsC9CKWQ+R?=
 =?us-ascii?Q?9NSbGEfhpy1d2bHTzFrkoBfnjHWE5g6OWob3W6aRveuR2XyhwN17Oq/p+LZo?=
 =?us-ascii?Q?1oFHw2QzGTXtNNoCNcduOm2I6MiCRrPsT/amsJ+qPQ68Nmq5NrWW+iTbl60L?=
 =?us-ascii?Q?Xn8tb1aqhr91Lz+Wv+9DIa5ORQm4RwXoAoX5k3uIlN3aGFusIj0Ohg9vjNQP?=
 =?us-ascii?Q?MC4I8PJ1YJnkPLBTwhD9xIuMb6iyLkLdpV1ixk1Zlou83lGQ8ID4E45R+J8U?=
 =?us-ascii?Q?U5zCW4HBBhTAj75plIaqccmRlSrwgTZ4PrExgRPCvptOa1dAwJU6OfGWu3EX?=
 =?us-ascii?Q?8Ip4ZU16EBhsT3qWbY4ueycN2HyOZ7L7VSPFNKke97Vkbo2ikqPZ9RldB7fL?=
 =?us-ascii?Q?UoUyu/CfdKv52w+hQuNTIMATle0QV4fquRQua18Bmjk6hVNnL6Ac0M5Md0BB?=
 =?us-ascii?Q?TTf9BxBwuz3X6JSYXYZWqn+53MKtx5g0L6fBPe7jtPAM0XecDTsMmdxaeQdb?=
 =?us-ascii?Q?nwjKFtvWa3dcU8UxVProEs7xJESMOiRcEKhohGH+K34pkuiHL+pWR/wsFsbe?=
 =?us-ascii?Q?VmBgJ8KfWahyxyrW2oBwgWfgzDCIkTu5G8VQaTxxyfBIAIzfXy871rkYSUn5?=
 =?us-ascii?Q?anc9mToY7yKMOucxWwpzJ14PrUqR9wTBDLMXKMrVC5OC7g0f+LtH3Dxws9dg?=
 =?us-ascii?Q?StChPICCnDjnUJth2AeC1zicRQaXtHWimXyxEDxNrUCKIggeJZj+wW6XNWXe?=
 =?us-ascii?Q?tuhw/Xz7eIywoXNCtDaavf1dz79C/Q8aQYKWdSs9kFoZyVbvjlFN3kP+XybX?=
 =?us-ascii?Q?KbJDqjXOCZrVSOpol6qIZMnC7+85Z72t6aRlCWgAoctVq++ptZcIvap0Q60y?=
 =?us-ascii?Q?DDXwcW/Hecl9yWl/Dwx5tkfsIXyt+T/BB4Y0P3kktgNdzXrOBK/q6AK30rGH?=
 =?us-ascii?Q?YqtQd0sxe/XO4boBiDKpAgBKzc4/PQihjEYGo/E/wgayt8VjkHVtWSJh21wA?=
 =?us-ascii?Q?2rCoPPS8XJgam2mFAqiBebo/Aqnob4QO3dTV0QMgPpRAoDAcdsuL/ibHt6Zg?=
 =?us-ascii?Q?ZIjOzTjMZzunqJ2EEQqidXioB0ys6Zz4/E1dqvZyebi/9+hVAPahoGyLsage?=
 =?us-ascii?Q?oZLib89Mbxr9WBzKb/xk/Wlktl/7d9TyDDGUQMgpvZdqrhD0VALDt3a+Q+mv?=
 =?us-ascii?Q?VDguS1tp4EHQGVvuC8fUmEuyIpRo9HRKt4GMYGG25dgujQ3cWhB7UiF0aLXP?=
 =?us-ascii?Q?SA0lTz07wIF4FkFFnOLKNlkVQZPWHP5q8Gl+xQ2kv2GictMngJQc7CF65tQi?=
 =?us-ascii?Q?oiM1vqd4JLjR1jISx+8hnsVZN2bwKRkWcQkP+yH0YegPEaRKHfb0o4E1xzcO?=
 =?us-ascii?Q?uazeUcD99VF+wOllDt5twH1jeFRlpZyOjNvhAxme?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe71e13-76c6-4fbd-1e9b-08dd8bdfbfc8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 14:18:46.9960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSfDWBPFLhNljo2onWU2ShBkYV4y/Ta16LVA3oG821ys5TSvG+19L10mHH5JVQfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

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
index c108ca97aa4ec5..33b4bedac61782 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -26,11 +26,23 @@
 #include <linux/string.h>
 
 enum {
-	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
-	PT_MAX_VA_ADDRESS_LG2 = 64,
 	PT_ENTRY_WORD_SIZE = sizeof(u64),
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
 };
 
@@ -370,6 +382,7 @@ static inline int amdv1pt_iommu_fmt_init(struct pt_iommu_amdv1 *iommu_table,
 }
 #define pt_iommu_fmt_init amdv1pt_iommu_fmt_init
 
+#ifndef PT_FMT_VARIANT
 static inline void
 amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
 			  const struct pt_range *top_range,
@@ -380,6 +393,7 @@ amdv1pt_iommu_fmt_hw_info(struct pt_iommu_amdv1 *table,
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
index aac565611cbffa..38a19b19cdc3dc 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -230,6 +230,12 @@ struct pt_iommu_amdv1_hw_info {
 
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


