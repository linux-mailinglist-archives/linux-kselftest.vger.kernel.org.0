Return-Path: <linux-kselftest+bounces-42843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAE4BC2163
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A4C3E0FAB
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746592E7BC1;
	Tue,  7 Oct 2025 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WTfEyEuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6BE2E7BD4;
	Tue,  7 Oct 2025 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853954; cv=fail; b=L3Iq970KLJV8Z9WIuwzOIEPkedXFj1aRXWnSNW5xy5PRFDRewvPi6JiKywHsRIeQm6sRC5pui7F/UnuIgjSgyiV/RYB4rYjP5fv3IdJ5Fdl+yRCnGNnXTJg9qwcyh1mrMDBXK66nBqaBCRdKssTunlKSLv/MbplwtFIq0QWATpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853954; c=relaxed/simple;
	bh=jU/vqgiS04zGX+halIIp8U9t/7ZYEQBKfHA3KsjTmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCStKLZW1smHER90bAJNqof9zoxaxHwH8u0twVNfXvk2IlfjjL/zTFrc9r0egn+BJNQQByIDhBmFQpA/mFgV7/x/fAhlpJB4oJZ0CnPiGozQjWyYqTPRIPDyld5t9JEGiL1YoyrmsyE9OKaLLV0R0DR5yi8pqrzUxGsHCd8KOQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WTfEyEuP; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqCnqy+Np6ngHV7RWuBK5erRKcv3CCRiLwhLo0fB/7wFtAZ+etSI+02nELF85cIOuOkRi1aCVOXw/vERV5LNpKB9SVtu+5uL6FcE5FeFP29R2T82qYRnHYOQ9jrX4d0ozFiEuHP4pdOGcVzLv+3bGlMlQgyH10dVWJyjNl6HSwmr9e3znxrwjnCmTcJlfb+1KVrolEcToxKs8hWa1L+FWdoggVgpayWvqrjY2XySIxWRjpCxuTugUX3ADjKCa10rfPpZbcXCDZTnyZXmc54mLcJZzBDYdSgtOYMaFBjDpeq++GaPEgn72mBrbD7VkcsYvzRc+ByaxgWgNyWlzskW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZFHDJIgcXfcwszvmCQcqF96Vwmu7ymK5tg47oOI/G8=;
 b=keQdMDZB4Ll5GqJ2j936f6S1UaiDBCcXBKHIcai69hCxef4i3owu1E+CiU+5RqlF+SF7Lmsz5XSjAEEx5fGiv+OKqAKF+gqp9te5837lje2lMDUsIgHshoAnxXfrgfDozyd3C6eUfyn2S0GK03op3OpyDSwp/MmAuTaRxkIG/F8YFxU0GDhZBq3FtNm88MH6M0M5Td+3X9+bqnUwyphgPrus6K/MMWwv8LTu5MDtc5G0oca8V9iV/5ZsExsRNzcygIJo2uB2xWKRy6yxb7cT2dG3SSXwboojnV9kot6y4PuShMeakrdJTMeAZ5BdBfQXj51ZI3sV5ks7ZOhmS5QsPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZFHDJIgcXfcwszvmCQcqF96Vwmu7ymK5tg47oOI/G8=;
 b=WTfEyEuPPxMNxYJSlwi0MOITkbjCmrswmMRuvwscZJu3M1H+PBmIsSTHgVX+UwHlzARv3EYhXi8PSGNfoxEu/7DrkWGuLnJN/R/N7y9f0VkRrlBEvsRhSExRbYkaa41k1ihLvLJDQhW0gZF/woWA9nUq9+U7qZt6fK4T+VLMwE+EUg3zUnM74RQUdAg2MKmfgJgpYe7uLuNMl1jpZmOlkYkSQ4wESjMdb4u4CrQPFVCEtXYtYtbBPmqGSGZC6VkMf2fXNEebeLuc3kUIilQgotX+v/nCYB7nBknOK2xP8qtXUpRntYZC2ZZobsSSl/ricmJsugXcbOrDKUXKcALD+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 16:18:56 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 16:18:56 +0000
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
Subject: [PATCH v6 07/15] iommupt: Add map_pages op
Date: Tue,  7 Oct 2025 13:11:52 -0300
Message-ID: <7-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v6-0fb54a1d9850+36b-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 055f014d-839d-40c4-631b-08de05bd36b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVv+fd9ogvlINdfKc6krFgdBkML3ZNukLTlBnDTM3Yk16YW0HCigEqZvmIuE?=
 =?us-ascii?Q?1l9Eg4vuirAMdI9DUwZoAn40j4N68JyCdjRoFCtOQGGPqH96ZsORKnaNlXO3?=
 =?us-ascii?Q?AHlJBkT4KSVosw054KAAabqi/DVumMLu+J0+9nBzA/letzSHQV5cvxXotqy6?=
 =?us-ascii?Q?XRr+Zb7wHV0M5farSNBkDbQWchoPf0HFhWaH1A8fDmKkCXOFB0cPvw8oS7b0?=
 =?us-ascii?Q?OTTzeOvFBZFRcsHGMrUQrphYfeIvu5was+ih/oyM/BbpFE7Gv1D5jO4Io1Qt?=
 =?us-ascii?Q?E3cu39BGuCWJUBVCoUalkddA7gMvuT4INIRudhDml52bBHPwePde8+LiuLFk?=
 =?us-ascii?Q?gotShYL3KHeJIXZzLBNmwxldSsmikoZz84jY7CS5FRIpoGKDrOdLRtfajy4z?=
 =?us-ascii?Q?O1mBBW5hqpW6UfoYh7a2tyKzK2bpDObNXCB7abbP2OAetXGVmlzkqae3ofbT?=
 =?us-ascii?Q?FbTBOHROXGGanABHDOdBHk6R5nR402iYyTkwloWwznBaaLci4c4gmhvUh7mZ?=
 =?us-ascii?Q?Htf4ObJAxYIdKK+O1tmXE6eb548SNCAZPnuYiPz9tXAHcds4K5vQFTVhi0Vb?=
 =?us-ascii?Q?RXL/mK2IkJ0KMHKIDjaSdwHGn2FUFllgv8ANCpRAgu5JobjOGjLgNWLHX789?=
 =?us-ascii?Q?XD4Gim2HqEKV1TtJS3S+paEKh2c5a0lRn+H3Tl9r20X1FZ/jVUSNZ1rzxUtm?=
 =?us-ascii?Q?emzHBSY1aD72V4Bbo8bv3ul77v2uG6u4a9XVZ5T1DRBc7zwMLHErc/FKi65+?=
 =?us-ascii?Q?4uOp0GB2LE135GfW7zOh9lTW6wFk5mqLFxQseP6AHB7ubUfucaRzL8lW4bQi?=
 =?us-ascii?Q?C8m3dkihFGzz79BB9UDKbnspP3NDs4M2aq/sWXqGm2Kj8nSdxmgR2WHW3cJT?=
 =?us-ascii?Q?kYDMSUjxFcOcwJvxcxYPJmPFo9/8SqU2nwNp7hu3WYKHA3PS21vITcRHOshn?=
 =?us-ascii?Q?sMZT8jz7WdUOmeMZkjq4S1jw2pqVJR6dme6gc/lUuMi0SDPxf6en3DyR2dRA?=
 =?us-ascii?Q?SNBVanDZfhUeWsmpnJMHkfeJ7Ek+FY5BHm8bYEa7PFZcSly/98ZDIWToY6+8?=
 =?us-ascii?Q?2s1X+Ns8zBVR9AXZdPGS86EwXm8PMT299JNTtjynm+i3XNksil4RTbtMhxho?=
 =?us-ascii?Q?qzr1HCqavOH6nN1iM+zA6a7Jvezl71gmcEuA5pCsqtQUVre33m1EG653yzCc?=
 =?us-ascii?Q?8ykOtNmvHo3fU1kde7jptUr0lOEROZIvB2ROh0gsZCipZhD70Fbac6ZjyTmb?=
 =?us-ascii?Q?cdHhmsrbNzjHht1oIoN2g3+BOGOkA1ghB17bbOv/5+bEk72Bhf9WGBTSiKCU?=
 =?us-ascii?Q?/UzW7RfK3mYQWoO+UE1XUUZrUoNdkSOlThfKZqrsSCdv1UTh7Rh4IglCsr3c?=
 =?us-ascii?Q?u760EBGqtBvUjL8/Oz9cg/8+BVVs5syq1hKyV0/7G7zlBwYM7sDWJMfj9sfk?=
 =?us-ascii?Q?vm9XuQECRenLA8RD+mdOb879FCoKRFikp4Q7pcSdhWHzxWZlRmYZYu7hkk3M?=
 =?us-ascii?Q?V1C/kS5iBuF6cgg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYqbD79ukvrjL/E5zaQIso0MrLT4X2DYWfDDPf+cqIxBJs60lwqNa2AvTT5c?=
 =?us-ascii?Q?+pdVQKXx+n89OVkCnaZDckdibCOQCylBQm/n/Pa6nGU0jatiIvcOXRS4hKLv?=
 =?us-ascii?Q?3ngMavrfeOxxeR9neL3IwefrUrplMKGeDEXU9Go1w+fGhnWseBdGhmxomyeH?=
 =?us-ascii?Q?/rEcE8GUHSZKI3wlmKHhT4fc1FANjfxxIT/4MHEPAjMZTkXWcl09KWbys/Dx?=
 =?us-ascii?Q?Icd6hTo2kUNfK8BqPW6E0FFkirkQzZei7SMy/ok4WsHFP1SriCMCu2XJ9XZN?=
 =?us-ascii?Q?hqFlNe8fHKTvfQ6gA+7VeEG7nQukcM3d/DKUHHuAXDx4o7v35wmUH2l5MuRh?=
 =?us-ascii?Q?TxP3Al7uyBvTZGsAFXYJDM8oRh+zfica0mt03gCUL3UDSxsRQWD4VgvGsNwU?=
 =?us-ascii?Q?TtYiF1zHzP/0gfsWTKUue6rhtjEJI8tvg5xKGqr1b1HfKfAOfe+UAgM67EcE?=
 =?us-ascii?Q?poasnpHn/elpXCl8NtJcFnUqRj7myRILIz4ld01+oBhXa3W2K/IvEpXtBGGp?=
 =?us-ascii?Q?UxuhLAMl+LHOJ+wiGuHC1Za4YCSNvDv9Xf3zEMuzBVA3DbwJBtQw3083gTzl?=
 =?us-ascii?Q?n7j1wO3JiKuokNak1wHS+2su970BU+rKbhqNX2LPsLXj7LmXor9CbE82eUoQ?=
 =?us-ascii?Q?Et3ARnuEmVg7e/K9E/YkEEF3izIOEMfQhjOre9VZVatJiyc3OHAqwQhjhx9Q?=
 =?us-ascii?Q?8qd15k/6RoW+Lyly1ho2/OnwUBqDK71kgI5V7mNpMoTxoJpX8szoTJ9rjGfD?=
 =?us-ascii?Q?0OOI2RJ9gp3HVO3Lz0CEnyY6hmZKiL3FsobOy5WA1QodH2Xwp7cl0u8eoKFh?=
 =?us-ascii?Q?hv78PWpSpHAoq2HdU9D7SWV2bkmfsd/1hYtUQpQFqs4twXLBc8ot/GQn5HGr?=
 =?us-ascii?Q?3woo1aE6L+2wqy0UJWtcesj5VD2Z2i4qu93Me12+ZCPaReAJ0zWF4+A/Cuzm?=
 =?us-ascii?Q?2OMEKBBuzzWbuB5JNWSvO23TQuuA3m0heuf7DhvbEsbvGZ0W2oBtK/2C0jlb?=
 =?us-ascii?Q?XNS45PztIp3xCTVNYvu9BwtTXJM3WVuILnttn/x0lITF1BBytoQW5y941DwV?=
 =?us-ascii?Q?TXTkk9V+PEROYacqB3WknIhnxTplfbzpRUoI7ZpXzftyWD+7YPn5lpjITjF7?=
 =?us-ascii?Q?W13Y1oCu53ZzI2LE313EJgA/yUy59Zn8VieUFPu7G6sJJvtqXX1EBe/+nQ9p?=
 =?us-ascii?Q?/ZmUtXlIhriPNCREjdwSsf9dHsvSZulWH+AhML/QL3wg5FOOrbdVk8KetRR1?=
 =?us-ascii?Q?vfim8SSpZUYtWFlaPdtnNPNywvymlnJVrHs8q7U2iW8sJoB7gpaGxgUNMX0L?=
 =?us-ascii?Q?vZykDzU6XuXAz4nWjActRF27bwO30jdc/2LzusVksXtPe+nn7X2zvRIbdAY3?=
 =?us-ascii?Q?4D+moPtmxJw58gbuEYiR6p0bftXGQOwcsrEaD6mL3FiC7HpRVD1aab9Q4z33?=
 =?us-ascii?Q?NZMtC+jgoL6u9jVdTXt9JFTZ1JI3AsuAjulqOar7yv6dbT9/+pQV517ZKVkh?=
 =?us-ascii?Q?N6fs/pldQTTRIqIEIaUknXe6OEopmiLfRAQZjhKixkIuskkAw/agygesl62e?=
 =?us-ascii?Q?rB9FmF6fDdSfdfi0Qxk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055f014d-839d-40c4-631b-08de05bd36b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 16:18:56.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TB4MT5iTPyt4uPE2Kv0f/Li4/BBdWHwUx48sKYPpqwqwBtXqY97kHCWLV0FVPDPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

map is slightly complicated because it has to handle a number of special
edge cases:
 - Overmapping a previously shared, but now empty, table level with an OA.
   Requries validating and freeing the possibly empty tables
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
 drivers/iommu/generic_pt/iommu_pt.h | 496 +++++++++++++++++++++++++++-
 include/linux/generic_pt/iommu.h    |  58 ++++
 2 files changed, 553 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
index 7b0a6e5fb87f33..f40eb3e398545e 100644
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
@@ -147,6 +164,8 @@ EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(iova_to_phys), "GENERIC_PT_IOMMU");
 
 struct pt_iommu_collect_args {
 	struct iommu_pages_list free_list;
+	/* Fail if any OAs are within the range */
+	u8 check_mapped : 1;
 };
 
 static int __collect_tables(struct pt_range *range, void *arg,
@@ -156,7 +175,7 @@ static int __collect_tables(struct pt_range *range, void *arg,
 	struct pt_iommu_collect_args *collect = arg;
 	int ret;
 
-	if (!pt_can_have_table(&pts))
+	if (!collect->check_mapped && !pt_can_have_table(&pts))
 		return 0;
 
 	for_each_pt_level_entry(&pts) {
@@ -167,6 +186,8 @@ static int __collect_tables(struct pt_range *range, void *arg,
 				return ret;
 			continue;
 		}
+		if (pts.type == PT_ENTRY_OA && collect->check_mapped)
+			return -EADDRINUSE;
 	}
 	return 0;
 }
@@ -187,6 +208,472 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
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
+	struct pt_iommu_collect_args collect = { .check_mapped = true };
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
+		if (IS_ENABLED(CONFIG_DEBUG_GENERIC_PT)) {
+			pt_index_to_va(&pts);
+			PT_WARN_ON(compute_best_pgsize(&pts, oa) !=
+				   leaf_pgsize_lg2);
+		}
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
+/*
+ * Fast path for the easy case of mapping a 4k page to an already allocated
+ * table. This is a common workload. If it returns EAGAIN run the full algorithm
+ * instead.
+ */
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
+ * map_pages() - Install translation for an IOVA range
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @paddr: Physical/Output address to start
+ * @pgsize: Length of each page
+ * @pgcount: Length of the range in pgsize units starting from @iova
+ * @prot: A bitmap of IOMMU_READ/WRITE/CACHE/NOEXEC/MMIO
+ * @gfp: GFP flags for any memory allocations
+ * @mapped: Total bytes successfully mapped
+ *
+ * The range starting at IOVA will have paddr installed into it. The caller
+ * must specify a valid pgsize and pgcount to segment the range into compatible
+ * blocks.
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
+		.leaf_pgsize_lg2 = vaffs(pgsize),
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
+	if (pt_has_system_page_size(common) && pgsize == PAGE_SIZE &&
+	    pgcount == 1) {
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
@@ -445,6 +932,7 @@ static void pt_iommu_zero(struct pt_iommu_table *fmt_table)
 	memset_after(fmt_table, 0, iommu.domain);
 
 	/* The caller can initialize some of these values */
+	iommu_table->hw_flush_ops = cfg.hw_flush_ops;
 	iommu_table->nid = cfg.nid;
 }
 
@@ -478,6 +966,12 @@ int pt_iommu_init(struct pt_iommu_table *fmt_table,
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
index ceb6bc9cea37cd..621c3165d30f68 100644
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
+	 * @hw_flush_ops: Function pointers provided by the HW driver to flush
+	 * HW caches after changes to the page table.
+	 */
+	const struct pt_iommu_flush_ops *hw_flush_ops;
+
 	/**
 	 * @nid: Node ID to use for table memory allocations. The IOMMU driver
 	 * may want to set the NID to the device's NID, if there are multiple
@@ -84,6 +91,52 @@ struct pt_iommu_ops {
 	void (*deinit)(struct pt_iommu *iommu_table);
 };
 
+/**
+ * struct pt_iommu_flush_ops - HW IOTLB cache flushing operations
+ *
+ * The IOMMU driver should implement these using container_of(iommu_table) to
+ * get to it's iommu_domain derived structure. All ops can be called in atomic
+ * contexts as they are buried under DMA API calls.
+ */
+struct pt_iommu_flush_ops {
+	/**
+	 * @change_top: Update the top of table pointer
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
+	 * @get_top_lock: Return a lock to hold when changing the table top
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


