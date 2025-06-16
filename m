Return-Path: <linux-kselftest+bounces-35133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17388ADB86F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 20:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ACB188D17E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26549288CAD;
	Mon, 16 Jun 2025 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeaZro1W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC2289371;
	Mon, 16 Jun 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097197; cv=fail; b=oiJkxdLE2DF03cXr15g/Rahpkho7/2jq5s/7gds7vyK9TPW3LgQUkrAnpYVeICtnm6iIfNHAK6+wF+0i5PlLNulhjdN25WM7nQKRFRPbWuWwFzrrdQP4R0iZ9njpXcD7G1KoDSR5A2fqUpqbEyJ3nM2eSktC+rT2rsA2HYMhxFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097197; c=relaxed/simple;
	bh=04e9PAXziHNd+W0fvNUmvK6y5cK0yUGfHLdbHizIqj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EHOiG6VIF7SDk4OlsHAK61hKXTMCP9K/rK7cp2o/JbpTuemr6TICF6EVmt4S/CIavvp1rMzSVC9m7eJGUzQWUeTj3klvpttLvBJXhhUYVBxlG30VoBlYxg4CbO6a+oM89sHy8q3iAWuJsR1M7JqppphQc7ftSviaa0p79uA1MJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeaZro1W; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE9PUQbDQsQHNq0+wtA2iHyhtMgzkxeiSENYuTClxIiYtqi0UxHK3d7VfWJTcSD2F2wFsQMlQyvWBRc8nT/jinganZDuRc8dC8P5/thzgV56gJNqCeh2OKYXyKu5aXl003e3Nl4h+0thpTfTW0O6t4rXof2gb1lhP4v6Y77NuMZGJl4QBVu8Bb4zP9CHOicxABpkjrCAV0JVRT3nnFSP91G6RaZ4r8/mYX50LHu2bpuXyQy/SnDto99jXiQ7FizBKm+SDOuQh/2JBn/1r8ZT5pqeWfVi0l8/k7TU6H5dhlsWPrdIBDlhAYk1AMTOukQR61ITze8PVLO316c6L0/yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKd/flOOypp/VglPvwCHxWcNL2jCgzCOduCQODQy2hM=;
 b=NefSguITW/6OGgVW90GwYVYQ0bNMTnxfB6FGPlt8QGMxpViO6i45mGh5NmZcdg4pnInWyk9q63xXsGaVTfF62KFjDzEb2As7V1yqG8PeZKEA7A6MEQ4yUFY+XauBbJRSSfY62LRnVDMSqSD1DV0aMXOe3gtgmQYn07o3t9+ystKWk8LcMt46D1M9d13tNrQ7gET+n9PWDD79yuV69CU1moSLc3V81jFiJrnl1boMLnBuxD7O0upuyu8zqfkS53TDxEMV/JEEZskn0eQ6zGIJr5xw3kfnPnfc0u1ndRFKm8H67moOPGVtynE7xHM0JWaE1c1H5axmyyG5iLEH2LA2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKd/flOOypp/VglPvwCHxWcNL2jCgzCOduCQODQy2hM=;
 b=OeaZro1WCfbJmsm5RfGLn2UOxOaDHIY8EiCX5M67MDSXz5s4UJr1+XoqNr3Mdmzy2OvRy4ySObe9vlbcPpCfBbDe9afH7kc6pQQfCRMQJEJWXiBf2O6cCY7HFgBfpgVWkDn5rLC78MscgMzW1BFPZ4Ic7D8v7pxVK+CyPPeMGvvrxTUIqCOZMsWvuWxDvrWvacWs0vzEID20cjLxkitLj07fEHWG7wXd2P62oRirh/QaHPLWfD/QWpzSxftvh1u15eHC25qu0sSdScsbEJHoFBxbnWJyTT80Xc2ioTy0tiJpHpXK7BvRqliGAPCJrju9J5IVdhI3qOvCXQO9fFLASQ==
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
Subject: [PATCH v3 07/15] iommupt: Add map_pages op
Date: Mon, 16 Jun 2025 15:06:10 -0300
Message-ID: <7-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: d61a81d5-842d-4ab8-8ce8-08ddad007f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4E5Nmkmqzg3SkeeLZyisuHeOPQaKpvg6PQhMQz1XSrUEx+hLAEwn11kVEVRF?=
 =?us-ascii?Q?VbuYYsQ8XBenT6uEqkJLHdX/hWHAxMaHrrmpX5paOkOy9fBsZMg7aFDyTCy2?=
 =?us-ascii?Q?MMt92kZvixhhzUrJFKSnP5aVXud9/ZCDyeOngR1nRAjLcL+EhOlknQf5rBdc?=
 =?us-ascii?Q?nyYQ9VS4AfHmxJcFhPQMWbUi0LiZFLLTofbZ+e89JdUcgcM6fzw3l3JFvjwx?=
 =?us-ascii?Q?P/5DQSaNCp/O+CQeGU8X+oCXXMQAq4pUWiB+Pcha4FJU9N6vBFmeV6Bd3JfQ?=
 =?us-ascii?Q?8CjiAJlQOKflSIC0ANfL7b8g705NesBEOd3AFPQDG7+J3Nuro1FVbEZrsr+e?=
 =?us-ascii?Q?wlKHBO44M+PxFSUW24wuzu0Bgy3plTjtseUbIvAVkHMPmRV+HETn9xIgsIre?=
 =?us-ascii?Q?jGfvcRrcrXPimYvn7JDnRIIRZAlxlWbEskWIBssvB8gQs6dQHaxjUqBERTtU?=
 =?us-ascii?Q?6/RSlN6/yhvvFEujmDH3LSAQQuZYok1s1fHC30Q3hvH7GugsaEAMZayJQEBj?=
 =?us-ascii?Q?cXzdKm/uhYJ9wVnUQ7a9/5wrCxDenvIJswwOjRFERfn2eOyayYuRSc8Py83k?=
 =?us-ascii?Q?i6N6ksTUSx4vYIwi2daEn85TX88qbUBn2/phWq+8m1iZwwzBkES3F2fRqiUH?=
 =?us-ascii?Q?d4ON9EKDrEm67LICchrNyFqntoGuwqNsDcorIrwjZKLYg8k8e0JrL4ga6yHq?=
 =?us-ascii?Q?fwci1QEINDRJFw80wo2tzhuzECC/SPjy0KZXSMjDEvbkm1jj/RD2gkwYVZYW?=
 =?us-ascii?Q?wOxag9Mb+4GyW7KnUG/EBRxGZOj6YKqL/klD+baalKB3aheP2ttkye67dWtZ?=
 =?us-ascii?Q?hm2FEro0ATP2EkVhMV7+nHYU7cOOthjx+vSxECUPEBwTlxH8D9xlRHIv6PEs?=
 =?us-ascii?Q?HR8nA2Vy8ePOQCgFsFyOciegVNbDNcFlfDXXMn8xAfOUrymRb4H6ZCnuIOmi?=
 =?us-ascii?Q?Sk6C/Clv19aKlFvgAHt+XijjDYsk2vFo0yOL7vmwSktJM3gkrQJpPNiNci4C?=
 =?us-ascii?Q?uQrX9Cy7PZ7Sg7TVXQQ/hs9GhWgP3DHcUAcqKXMJWSyJpmqRLYYFRtGS0Pn0?=
 =?us-ascii?Q?m6/l8M1UBdf5P/3ReSYc5bVZQu0+DvTHxfEX+oXHKbQgqXgn22sc3XibLTzR?=
 =?us-ascii?Q?9UJMZc4Lu6ER6S2TVIi1GFhYh9LTlUW0pb0S1pZ27KNk/KUWUhVuN8Am0wto?=
 =?us-ascii?Q?iKocOk3/d3OwytPhmy3c4XlgOTOEUzAjB7GAZ7mrn66/bc5S08ZUZ8697Jql?=
 =?us-ascii?Q?9ipSEEDphKwLumHCAbmY3XDSU0T8DKplPdv5ZTwHXP4KFCv86TH155Cr0awm?=
 =?us-ascii?Q?G6dSZQbv4JpQD4+hbrRfTdMFT1IXLvbh8rrChELEt9+lJls/MSrkrwUFs3Nc?=
 =?us-ascii?Q?Cg/CARb6a3XuWvqhpPxS12JiAi93xSQGIHIWwds8CONGkAd8t3H9b4FyywKm?=
 =?us-ascii?Q?1N+kL5T4dInWEhxzkIm6+ZHxyAb+c+qvPC3WNEmRCParewKXpZ+a+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9B4EEqiYarKGpcZCoqpRwpfvCjJ7depS8eNPF1syLibNi2IvKa706UdBAKc?=
 =?us-ascii?Q?c6WeGbUnP+GTbFov8tDPWIenNU+fKh4IdXoCWXJv4vbtqCcEG2IibaVC3FPZ?=
 =?us-ascii?Q?nlXYvrPNBdBMWg6infUYAuNmrYWjCUZ4XZCrQ3iwC8vK3ddtCD/E1zuezwN1?=
 =?us-ascii?Q?RCT1uJA/OsxlIQ1acAMI9D1urR2u7d+oAI35LZOCD/tBaVBHtwANL5YBpXVx?=
 =?us-ascii?Q?gLVYW55c7bqSndKR1YPAy+fvZvXFjbh9Vpg7xqExKSyZdh80k49yNaYzda3/?=
 =?us-ascii?Q?QI3P36djewPjgnwtGxwlv+wTLsHsYwiBRmz3Pw2xA5ut3MhgMXHHdCJPNS/r?=
 =?us-ascii?Q?zMR6Xra0syFuWpstqBcro/WE0J7VNI1NDB6YJEfsqQxhSKFmye+tVKts8HX2?=
 =?us-ascii?Q?8FFcsaIT0BgMTvxwR7MnICMo0MR1CQqK4v/P1Hq4FNMB6p/G0eBQYS0FIfPa?=
 =?us-ascii?Q?7BEZ9oT/oFabwucrQGT1sZOhzWhyAk/FZbzaH7zC6j4tdHEDpZwTYbCN/jec?=
 =?us-ascii?Q?F9NdVGhW+rr571uRO+YSmbEB3pHnreXh44kSPI6LUVEuF2IRLth9dTfAqBI+?=
 =?us-ascii?Q?PIVo8QoNK9tQRO2kxDgLQRvR6gurDQuuD3wUy1I4AjNVblmvBUF6lPsRqG2r?=
 =?us-ascii?Q?kVMx3+O2Qx8CKvuUxP1EbICTkqQanl8kfJe4nAu2Ui03JpSNtjoasVRx84z8?=
 =?us-ascii?Q?BeBYwxhNbJrKDT6rJbXdqga2mPsEdnUIpxHG6j86VmEu3lgelmaI5Tg8D/fn?=
 =?us-ascii?Q?vOzJynnatMj3eUMnBHx1UNYGfRfvBDiwruLw2A2gzXUEXlWr/tOxYoi6JZUo?=
 =?us-ascii?Q?CjHS92iNDZXTnHc4QwS2TOKaXYCejiIW8ePGB5tQYZA2TW3XVRFl3CV+7ehC?=
 =?us-ascii?Q?qXRXedkiJa+k/9oApxl6rrGLFmG+wf9qV3GF+rWL5Lewq98YBnHTlwDFs9yq?=
 =?us-ascii?Q?SoHs1Z1H+HpI3h2eL9nUsIdp1u3Ffr0pzQq3dSb3nCwYhzphQ7a40DS9yPYm?=
 =?us-ascii?Q?9JJGqW6xYqzdKx4ibuKdMLaBLa658scaxOkimaCmysftj+F7PGK+poQrzpjq?=
 =?us-ascii?Q?3wN4LIJLl7Dh/v5TuLKU2MFpFgwZOEuamp8fc5sf+cadSL9tUaT63hplaTjI?=
 =?us-ascii?Q?46dLxnr4GW/XFnkZo4cTuz715Jrt2iCQPRKXHXRYqDlZTAmkRzO5NDs4hxU6?=
 =?us-ascii?Q?SLoQ2lEnlIFS/uPYQ4HQMyTJVadWha94CUrtwFfd/3tTxBCvADCvN24hmm3o?=
 =?us-ascii?Q?WE/kEYy7shDsPMJQ7W/5gnj4GAZtHFjXL2vSJfUnUO+3twI5OKprTM4nKCWR?=
 =?us-ascii?Q?gM9NW52YZmlSGzK6vg0g1Wbc44Jdev3xaoy1ynkegBZ50mk3yqY4I/MrBdm9?=
 =?us-ascii?Q?Bo8VVjVhbGK/w9slEZP3r5QpXVDYtFJgTXkwxWujz3uvD+43+2yuElbOJWIC?=
 =?us-ascii?Q?TbeXQIvqUpM3YW/Ykf+1JCn8An3xetXxOx9u2u9VY0aZ6xY9GUoL5XErpZyn?=
 =?us-ascii?Q?ZaaZlqVFZvFGuMLs1YxUGBpdXIN8l4QzRIdAQ+6RZQL11pCfZkHgmO/yPMpY?=
 =?us-ascii?Q?f1GOA7/ywKgBG3KlKq6x3pbxBw5TC+FdLoj/DbHN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61a81d5-842d-4ab8-8ce8-08ddad007f55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:06:21.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7fxPAOdK+W3QbaIL8ZiA0FMkT1j/4hsZp/T3nJ2HdM4IFO4D9SC0M7KqZWMVBLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared table with an OA - requries validating
   and freeing the possibly empty tables
 - Doing the above across an entire to-be-created contiguous entry
 - Installing a new shared table level concurrently with another thread
 - Expanding the table by adding more top levels

Table expansion is a unique feature of AMDv1, this version is quite
similar except we handle racing concurrent lockless map. The table top
pointer and starting level are encoded in a single uintptr_t which ensures
we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
that fixed point as its starting point. Concurrent expansion is handled
with a table global spinlock.

When inserting a new table entry map checks that the entire portion of the
table is empty. This includes freeing any empty lower tables that will be
overwritten by an OA. A separate free list is used while checking and
collecting all the empty lower tables so that writing the new entry is
uninterrupted, either the new entry fully writes or nothing changes.

A special fast path for PAGE_SIZE is implemented that does a direct walk
to the leaf level and installs a single entry. This gives ~15% improvement
for iommu_map() when mapping lists of single pages.

This version sits under the iommu_domain_ops as map_pages() but does not
require the external page size calculation. The implementation is actually
map_range() and can do arbitrary ranges, internally handling all the
validation and supporting any arrangment of page sizes. A future series
can optimize iommu_map() to take advantage of this.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/generic_pt/iommu_pt.h | 480 ++++++++++++++++++++++++++++
 include/linux/generic_pt/iommu.h    |  58 ++++
 2 files changed, 538 insertions(+)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 2729422d12dfcd..b7c45c9152590c 100644
--- a/drivers/iommu/generic_pt/iommu_pt.h
+++ b/drivers/iommu/generic_pt/iommu_pt.h
@@ -91,6 +91,23 @@ static __maybe_unused int make_range_u64(struct pt_common *common,
 		ret;                                                     \
 	})
 
+static inline unsigned int compute_best_pgsize(struct pt_state *pts,
+					       pt_oaddr_t oa)
+{
+	struct pt_iommu *iommu_table = iommu_from_common(pts->range->common);
+
+	if (!pt_can_have_leaf(pts))
+		return 0;
+
+	/*
+	 * The page size is limited by the domain's bitmap. This allows the core
+	 * code to reduce the supported page sizes by changing the bitmap.
+	 */
+	return pt_compute_best_pgsize(pt_possible_sizes(pts) &
+					      iommu_table->domain.pgsize_bitmap,
+				      pts->range->va, pts->range->last_va, oa);
+}
+
 static __always_inline int __do_iova_to_phys(struct pt_range *range, void *arg,
 					     unsigned int level,
 					     struct pt_table_p *table,
@@ -190,6 +207,462 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
 		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
 }
 
+/* Allocate an interior table */
+static inline struct pt_table_p *table_alloc(const struct pt_state *parent_pts,
+					     gfp_t gfp)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(parent_pts->range->common);
+	struct pt_state child_pts =
+		pt_init(parent_pts->range, parent_pts->level - 1, NULL);
+
+	return iommu_alloc_pages_node_sz(
+		iommu_table->nid, gfp,
+		log2_to_int(pt_num_items_lg2(&child_pts) +
+			    ilog2(PT_ITEM_WORD_SIZE)));
+}
+
+static inline int pt_iommu_new_table(struct pt_state *pts,
+				     struct pt_write_attrs *attrs)
+{
+	struct pt_table_p *table_mem;
+	phys_addr_t phys;
+
+	/* Given PA/VA/length can't be represented */
+	if (unlikely(!pt_can_have_table(pts)))
+		return -ENXIO;
+
+	table_mem = table_alloc(pts, attrs->gfp);
+	if (IS_ERR(table_mem))
+		return PTR_ERR(table_mem);
+
+	phys = virt_to_phys(table_mem);
+	if (!pt_install_table(pts, phys, attrs)) {
+		iommu_free_pages(table_mem);
+		return -EAGAIN;
+	}
+
+	if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+		/*
+		 * The underlying table can't store the physical table address.
+		 * This happens when kunit testing tables outside their normal
+		 * environment where a CPU might be limited.
+		 */
+		pt_load_single_entry(pts);
+		if (PT_WARN_ON(pt_table_pa(pts) != phys)) {
+			pt_clear_entry(pts, ilog2(1));
+			iommu_free_pages(table_mem);
+			return -EINVAL;
+		}
+	}
+
+	pts->table_lower = table_mem;
+	return 0;
+}
+
+struct pt_iommu_map_args {
+	struct iommu_iotlb_gather *iotlb_gather;
+	struct pt_write_attrs attrs;
+	pt_oaddr_t oa;
+	unsigned int leaf_pgsize_lg2;
+	unsigned int leaf_level;
+};
+
+/*
+ * Check that the items in a contiguous block are all empty. This will
+ * recursively check any tables in the block to validate they are empty and then
+ * free them through the gather.
+ */
+static int clear_contig(const struct pt_state *start_pts,
+			struct iommu_iotlb_gather *iotlb_gather,
+			unsigned int step, unsigned int pgsize_lg2)
+{
+	struct pt_iommu *iommu_table =
+		iommu_from_common(start_pts->range->common);
+	struct pt_range range = *start_pts->range;
+	struct pt_state pts =
+		pt_init(&range, start_pts->level, start_pts->table);
+	struct pt_iommu_collect_args collect = {};
+	int ret;
+
+	pts.index = start_pts->index;
+	pts.end_index = start_pts->index + step;
+	for (; _pt_iter_load(&pts); pt_next_entry(&pts)) {
+		if (pts.type == PT_ENTRY_TABLE) {
+			collect.free_list =
+				IOMMU_PAGES_LIST_INIT(collect.free_list);
+			ret = pt_walk_descend_all(&pts, __collect_tables,
+						  &collect);
+			if (ret)
+				return ret;
+
+			/*
+			 * The table item must be cleared before we can update
+			 * the gather
+			 */
+			pt_clear_entry(&pts, ilog2(1));
+
+			iommu_pages_list_add(&collect.free_list,
+					     pt_table_ptr(&pts));
+			gather_range_pages(
+				iotlb_gather, iommu_table, range.va,
+				log2_to_int(pt_table_item_lg2sz(&pts)),
+				&collect.free_list);
+		} else if (pts.type != PT_ENTRY_EMPTY) {
+			return -EADDRINUSE;
+		}
+	}
+	return 0;
+}
+
+static int __map_range_leaf(struct pt_range *range, void *arg,
+			    unsigned int level, struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
+	unsigned int start_index;
+	pt_oaddr_t oa = map->oa;
+	unsigned int step;
+	bool need_contig;
+	int ret = 0;
+
+	PT_WARN_ON(map->leaf_level != level);
+	PT_WARN_ON(!pt_can_have_leaf(&pts));
+
+	step = log2_to_int_t(unsigned int,
+			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
+	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
+
+	_pt_iter_first(&pts);
+	start_index = pts.index;
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
+			if (pts.index != start_index)
+				pt_index_to_va(&pts);
+			ret = clear_contig(&pts, map->iotlb_gather, step,
+					   leaf_pgsize_lg2);
+			if (ret)
+				break;
+		}
+
+		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);
+
+		pt_install_leaf_entry(&pts, oa, leaf_pgsize_lg2, &map->attrs);
+
+		oa += log2_to_int(leaf_pgsize_lg2);
+		pts.index += step;
+	} while (pts.index < pts.end_index);
+
+	map->oa = oa;
+	return ret;
+}
+
+static int __map_range(struct pt_range *range, void *arg, unsigned int level,
+		       struct pt_table_p *table)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+	int ret;
+
+	PT_WARN_ON(map->leaf_level == level);
+	PT_WARN_ON(!pt_can_have_table(&pts));
+
+	_pt_iter_first(&pts);
+
+	/* Descend to a child table */
+	do {
+		pts.type = pt_load_entry_raw(&pts);
+
+		if (pts.type != PT_ENTRY_TABLE) {
+			if (pts.type != PT_ENTRY_EMPTY)
+				return -EADDRINUSE;
+			ret = pt_iommu_new_table(&pts, &map->attrs);
+			if (ret) {
+				/*
+				 * Racing with another thread installing a table
+				 */
+				if (ret == -EAGAIN)
+					continue;
+				return ret;
+			}
+		} else {
+			pts.table_lower = pt_table_ptr(&pts);
+		}
+
+		/*
+		 * The already present table can possibly be shared with another
+		 * concurrent map.
+		 */
+		if (map->leaf_level == level - 1)
+			ret = pt_descend(&pts, arg, __map_range_leaf);
+		else
+			ret = pt_descend(&pts, arg, __map_range);
+		if (ret)
+			return ret;
+
+		pts.index++;
+		pt_index_to_va(&pts);
+		if (pts.index >= pts.end_index)
+			break;
+		pts.type = pt_load_entry_raw(&pts);
+	} while (true);
+	return 0;
+}
+
+static __always_inline int __do_map_single_page(struct pt_range *range,
+						void *arg, unsigned int level,
+						struct pt_table_p *table,
+						pt_level_fn_t descend_fn)
+{
+	struct pt_state pts = pt_init(range, level, table);
+	struct pt_iommu_map_args *map = arg;
+
+	pts.type = pt_load_single_entry(&pts);
+	if (level == 0) {
+		if (pts.type != PT_ENTRY_EMPTY)
+			return -EADDRINUSE;
+		pt_install_leaf_entry(&pts, map->oa, PAGE_SHIFT,
+				      &map->attrs);
+		map->oa += PAGE_SIZE;
+		return 0;
+	}
+	if (pts.type != PT_ENTRY_TABLE)
+		return -EAGAIN;
+	return pt_descend(&pts, arg, descend_fn);
+}
+PT_MAKE_LEVELS(__map_single_page, __do_map_single_page);
+
+/*
+ * Add a table to the top, increasing the top level as much as necessary to
+ * encompass range.
+ */
+static int increase_top(struct pt_iommu *iommu_table, struct pt_range *range,
+			struct pt_iommu_map_args *map)
+{
+	struct iommu_pages_list free_list = IOMMU_PAGES_LIST_INIT(free_list);
+	struct pt_common *common = common_from_iommu(iommu_table);
+	uintptr_t top_of_table = READ_ONCE(common->top_of_table);
+	uintptr_t new_top_of_table = top_of_table;
+	struct pt_table_p *table_mem;
+	unsigned int new_level;
+	spinlock_t *domain_lock;
+	unsigned long flags;
+	int ret;
+
+	while (true) {
+		struct pt_range top_range =
+			_pt_top_range(common, new_top_of_table);
+		struct pt_state pts = pt_init_top(&top_range);
+
+		top_range.va = range->va;
+		top_range.last_va = range->last_va;
+
+		if (!pt_check_range(&top_range) && map->leaf_level <= pts.level)
+			break;
+
+		pts.level++;
+		if (pts.level > PT_MAX_TOP_LEVEL ||
+		    pt_table_item_lg2sz(&pts) >= common->max_vasz_lg2) {
+			ret = -ERANGE;
+			goto err_free;
+		}
+
+		new_level = pts.level;
+		table_mem = table_alloc_top(
+			common, _pt_top_set(NULL, pts.level), map->attrs.gfp);
+		if (IS_ERR(table_mem))
+			return PTR_ERR(table_mem);
+		iommu_pages_list_add(&free_list, table_mem);
+
+		/* The new table links to the lower table always at index 0 */
+		top_range.va = 0;
+		top_range.top_level = new_level;
+		pts.table_lower = pts.table;
+		pts.table = table_mem;
+		pt_load_single_entry(&pts);
+		PT_WARN_ON(pts.index != 0);
+		pt_install_table(&pts, virt_to_phys(pts.table_lower),
+				 &map->attrs);
+		new_top_of_table = _pt_top_set(pts.table, pts.level);
+	}
+
+	/*
+	 * top_of_table is write locked by the spinlock, but readers can use
+	 * READ_ONCE() to get the value. Since we encode both the level and the
+	 * pointer in one quanta the lockless reader will always see something
+	 * valid. The HW must be updated to the new level under the spinlock
+	 * before top_of_table is updated so that concurrent readers don't map
+	 * into the new level until it is fully functional. If another thread
+	 * already updated it while we were working then throw everything away
+	 * and try again.
+	 */
+	domain_lock = iommu_table->hw_flush_ops->get_top_lock(iommu_table);
+	spin_lock_irqsave(domain_lock, flags);
+	if (common->top_of_table != top_of_table) {
+		spin_unlock_irqrestore(domain_lock, flags);
+		ret = -EAGAIN;
+		goto err_free;
+	}
+
+	/*
+	 * We do not issue any flushes for change_top on the expectation that
+	 * any walk cache will not become a problem by adding another layer to
+	 * the tree. Misses will rewalk from the updated top pointer, hits
+	 * continue to be correct. Negative caching is fine too since all the
+	 * new IOVA added by the new top is non-present.
+	 */
+	iommu_table->hw_flush_ops->change_top(
+		iommu_table, virt_to_phys(table_mem), new_level);
+	WRITE_ONCE(common->top_of_table, new_top_of_table);
+	spin_unlock_irqrestore(domain_lock, flags);
+	return 0;
+
+err_free:
+	iommu_put_pages_list(&free_list);
+	return ret;
+}
+
+static int check_map_range(struct pt_iommu *iommu_table, struct pt_range *range,
+			   struct pt_iommu_map_args *map)
+{
+	struct pt_common *common = common_from_iommu(iommu_table);
+	int ret;
+
+	do {
+		ret = pt_check_range(range);
+		if (!pt_feature(common, PT_FEAT_DYNAMIC_TOP))
+			return ret;
+
+		if (!ret && map->leaf_level <= range->top_level)
+			break;
+
+		ret = increase_top(iommu_table, range, map);
+		if (ret && ret != -EAGAIN)
+			return ret;
+
+		/* Reload the new top */
+		*range = pt_make_range(common, range->va, range->last_va);
+	} while (ret);
+	PT_WARN_ON(pt_check_range(range));
+	return 0;
+}
+
+/**
+ * map_range() - Install translation for an IOVA range
+ * @iommu_table: Table to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @len: Length of the range starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @gather: Gather struct that must be flushed on return
+ *
+ * The range starting at IOVA will have paddr installed into it. The rage is
+ * automatically segmented into optimally sized table entries, and can have any
+ * valid alignment.
+ *
+ * On error the caller will probably want to invoke unmap on the range from iova
+ * up to the amount indicated by @mapped to return the table back to an
+ * unchanged state.
+ *
+ * Context: The caller must hold a write range lock that includes the whole
+ * range.
+ *
+ * Returns: -ERRNO on failure, 0 on success. The number of bytes of VA that were
+ * mapped are added to @mapped, @mapped is not zerod first.
+ */
+int DOMAIN_NS(map_pages)(struct iommu_domain *domain, unsigned long iova,
+			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			 int prot, gfp_t gfp, size_t *mapped)
+{
+	struct pt_iommu *iommu_table =
+		container_of(domain, struct pt_iommu, domain);
+	pt_vaddr_t pgsize_bitmap = iommu_table->domain.pgsize_bitmap;
+	struct pt_common *common = common_from_iommu(iommu_table);
+	struct iommu_iotlb_gather iotlb_gather;
+	pt_vaddr_t len = pgsize * pgcount;
+	struct pt_iommu_map_args map = {
+		.iotlb_gather = &iotlb_gather,
+		.oa = paddr,
+		.leaf_pgsize_lg2 = log2_ffs(pgsize),
+	};
+	bool single_page = false;
+	struct pt_range range;
+	int ret;
+
+	iommu_iotlb_gather_init(&iotlb_gather);
+
+	if (WARN_ON(!(prot & (IOMMU_READ | IOMMU_WRITE))))
+		return -EINVAL;
+
+	/* Check the paddr doesn't exceed what the table can store */
+	if ((sizeof(pt_oaddr_t) < sizeof(paddr) &&
+	     (pt_vaddr_t)paddr > PT_VADDR_MAX) ||
+	    (common->max_oasz_lg2 != PT_VADDR_MAX_LG2 &&
+	     oalog2_div(paddr, common->max_oasz_lg2)))
+		return -ERANGE;
+
+	ret = pt_iommu_set_prot(common, &map.attrs, prot);
+	if (ret)
+		return ret;
+	map.attrs.gfp = gfp;
+
+	ret = make_range_no_check(common, &range, iova, len);
+	if (ret)
+		return ret;
+
+	/* Calculate target page size and level for the leaves */
+	if (pt_has_system_page(common) && pgsize == PAGE_SIZE && pgcount == 1) {
+		PT_WARN_ON(!(pgsize_bitmap & PAGE_SIZE));
+		if (log2_mod(iova | paddr, PAGE_SHIFT))
+			return -ENXIO;
+		map.leaf_pgsize_lg2 = PAGE_SHIFT;
+		map.leaf_level = 0;
+		single_page = true;
+	} else {
+		map.leaf_pgsize_lg2 = pt_compute_best_pgsize(
+			pgsize_bitmap, range.va, range.last_va, paddr);
+		if (!map.leaf_pgsize_lg2)
+			return -ENXIO;
+		map.leaf_level =
+			pt_pgsz_lg2_to_level(common, map.leaf_pgsize_lg2);
+	}
+
+	ret = check_map_range(iommu_table, &range, &map);
+	if (ret)
+		return ret;
+
+	PT_WARN_ON(map.leaf_level > range.top_level);
+
+	do {
+		if (single_page) {
+			ret = pt_walk_range(&range, __map_single_page, &map);
+			if (ret != -EAGAIN)
+				break;
+		}
+
+		if (map.leaf_level == range.top_level)
+			ret = pt_walk_range(&range, __map_range_leaf, &map);
+		else
+			ret = pt_walk_range(&range, __map_range, &map);
+	} while (false);
+
+	/*
+	 * Table levels were freed and replaced with large items, flush any walk
+	 * cache that may refer to the freed levels.
+	 */
+	if (!iommu_pages_list_empty(&iotlb_gather.freelist))
+		iommu_iotlb_sync(&iommu_table->domain, &iotlb_gather);
+
+	/* Bytes successfully mapped */
+	PT_WARN_ON(!ret && map.oa - paddr != len);
+	*mapped += map.oa - paddr;
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(map_pages), "GENERIC_PT_IOMMU");
+
 struct pt_unmap_args {
 	struct iommu_pages_list free_list;
 	pt_vaddr_t unmapped;
@@ -451,6 +924,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->hw_flush_ops = cfg.hw_flush_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -486,6 +960,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
 	if (ret)
 		return ret;
 
+	if (pt_feature(common, PT_FEAT_DYNAMIC_TOP) &&
+	    WARN_ON(!iommu_table->hw_flush_ops ||
+		    !iommu_table->hw_flush_ops->change_top ||
+		    !iommu_table->hw_flush_ops->get_top_lock))
+		return -EINVAL;
+
 	if (pt_feature(common, PT_FEAT_SIGN_EXTEND) &&
 	    (pt_feature(common, PT_FEAT_FULL_VA) ||
 	     pt_feature(common, PT_FEAT_DYNAMIC_TOP)))
diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/iommu.h
index 382596b70e394e..2ca62812b5a152 100644
--- a/include/linux/generic_pt/iommu.h
+++ b/include/linux/generic_pt/iommu.h
@@ -11,6 +11,7 @@
 
 struct iommu_iotlb_gather;
 struct pt_iommu_ops;
+struct pt_iommu_flush_ops;
 
 /**
  * DOC: IOMMU Radix Page Table
@@ -43,6 +44,12 @@ struct pt_iommu {
 	 */
 	const struct pt_iommu_ops *ops;
 
+	/**
+	 * @hw_flush_ops - Function pointers provided by the HW driver to flush
+	 * HW caches after changes to the page table.
+	 */
+	const struct pt_iommu_flush_ops *hw_flush_ops;
+
 	/**
 	 * @nid - Node ID to use for table memory allocations. The iommu driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,52 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain dervied structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_flush_ops {
+	/**
+	 * change_top() - Update the top of table pointer
+	 * @iommu_table: Table to operate on
+	 * @top_paddr: New CPU physical address of the top pointer
+	 * @top_level: IOMMU PT level of the new top
+	 *
+	 * Called under the get_top_lock() spinlock. The driver must update all
+	 * HW references to this domain with a new top address and
+	 * configuration. On return mappings placed in the new top must be
+	 * reachable by the HW.
+	 *
+	 * top_level encodes the level in IOMMU PT format, level 0 is the
+	 * smallest page size increasing from there. This has to be translated
+	 * to any HW specific format. During this call the new top will not be
+	 * visible to any other API.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	void (*change_top)(struct pt_iommu *iommu_table, phys_addr_t top_paddr,
+			   unsigned int top_level);
+
+	/**
+	 * get_top_lock() - Return a lock to hold when changing the table top
+	 * @iommu_table: Table to operate on
+	 *
+	 * page table from being stored in HW. The lock will be held prior
+	 * to calling change_top() and released once the top is fully visible.
+	 *
+	 * Typically this would be a lock that protects the iommu_domain's
+	 * attachment list.
+	 *
+	 * This op is only used by PT_FEAT_DYNAMIC_TOP, and is required if
+	 * enabled.
+	 */
+	spinlock_t *(*get_top_lock)(struct pt_iommu *iommu_table);
+};
+
 static inline void pt_iommu_deinit(struct pt_iommu *iommu_table)
 {
 	/*
@@ -120,6 +173,10 @@ struct pt_iommu_cfg {
 #define IOMMU_PROTOTYPES(fmt)                                                  \
 	phys_addr_t pt_iommu_##fmt##_iova_to_phys(struct iommu_domain *domain, \
 						  dma_addr_t iova);            \
+	int pt_iommu_##fmt##_map_pages(struct iommu_domain *domain,            \
+				       unsigned long iova, phys_addr_t paddr,  \
+				       size_t pgsize, size_t pgcount,          \
+				       int prot, gfp_t gfp, size_t *mapped);   \
 	size_t pt_iommu_##fmt##_unmap_pages(                                   \
 		struct iommu_domain *domain, unsigned long iova,               \
 		size_t pgsize, size_t pgcount,                                 \
@@ -142,6 +199,7 @@ struct pt_iommu_cfg {
  */
 #define IOMMU_PT_DOMAIN_OPS(fmt)                        \
 	.iova_to_phys = &pt_iommu_##fmt##_iova_to_phys, \
+	.map_pages = &pt_iommu_##fmt##_map_pages,       \
 	.unmap_pages = &pt_iommu_##fmt##_unmap_pages
 
 /*
-- 
2.43.0


