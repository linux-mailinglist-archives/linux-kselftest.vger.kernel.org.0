Return-Path: <linux-kselftest+bounces-45129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888D0C40EFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55EF3BC5B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1B33506A;
	Fri,  7 Nov 2025 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aaH/USfN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B2232E735;
	Fri,  7 Nov 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534193; cv=fail; b=TjgDfgnvOycNzwJesOPHIsibPiUtCUP2MzdZxLvRjphoi3AwVcX3PH6wWf2BXGajHTntkJcaYKb1r9mk2qtZ9fJlRC6xgBThEZSvbz5LmKSwOKuYT9UCBaffuT+jYi6kyCYMmBHr57aOLUZHCfbt3NOXc/kT73bXYgd+Uz3VxN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534193; c=relaxed/simple;
	bh=nTbuqY5NpPhZHQ/JFyKmUD+LSMIJmi11fKTgZvM7rOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t/Kbd5bB7NrsRt3Lq3q9UbXOigo7RsWvXav1d1y8qj3NhJovy8rb99OPmXtkPaLIooG7+4PxaoDXSPgMG5Nzf+quiN6lEguqoHJkN3r42/8JgXXs7o0UwPT2qB08jFy76S4DYz++vEdmpdEJtdFQhgEDHpgOvYFSPBAElyhYmO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aaH/USfN; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNSgm2HsnlAaanaesEm6xvvmp6pSt+AdPMDlJfPhT7kni0xImp6VVhT4oSmWo6vokfDbz7Gssq+OAO+sWWfA4FTyJuiqfUJDS0gd/pBdPj7U06uK3JiZOLda4gVp+Qj+mRGUmFZSf1X55k0NX46cXBtb1r2e7fbL1KrUXWbdXZ4A3uOe7XXGw4rM4Pdf9kAllywKQ2go6yucuyL9kZdYN1wfXR4jY2EFneGmH8tk0AD265tJYAM8+Fky+lAisLZdrgNIMOAjOTX24Ely8Fz3rSPbWf0BaiJvL0o2+4LKB3ecVB4g1+w3W8Z5z2MhXfGtgg9NqkF6g3La7FAyhfFDIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euxd/EXjrcjVaw3k/kD8nTFO5k8iPUw8AHe7JP9cRC0=;
 b=UMwePJKxaVlzcpWspv8PNAZnE7YidqwqpCQE+FV6hWUrgf7GivtZ/new1IXbIx62AHZSnRQehEtoT5mYrnMxu2MDBb0ecMIDqeTeMDc+J8Qb/MtmhiHFJ/I7FgcY3Ib1UB1skzX/WVzvQK5z50LD2UEj4l9S1Wcajgo2tT5ifSxzHkNVL3GU1b7lpG1T7yq7r7jwxAjboGs+E8zZ8YOkda2+KrkuwRtl7xBQjUOHUWZBg7zJR4yDuSwL3BGwgSJ9zjciMJMPoSIcvMWz5QA7qtGgt85yD6p7biWxOMYMe9Rf1rnZs92Izspq6oqxggnS/qxQqy3rpG+0bCvXZCwq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euxd/EXjrcjVaw3k/kD8nTFO5k8iPUw8AHe7JP9cRC0=;
 b=aaH/USfNxYZjggKX95EpFgBucpCMmZgIh9YQpzlaJ/UXFLc721K/XlOE7PoR2Wf7xdfsssRPsohqh+FPAlWejQJWnEX8rtCHzrT4oJstmgjYC1pgDeFttO2TPEOVRUHuO2UuSwABTckqwS/QCj/K2sx6sSfXQ7wqKuTHyKgl2QmB+VU0LbTD5XuvFA83iKbi1GLQFCAtcnrMX09jpkm/yyFdLBCApelgFeWp8SgSXa0QFZkKE0Skqh6r6QZZI8luC64b+8Mffd+wwT0WiI05FKpIuINXxrZ81NlJVpZI9HEPMWbW/DNjbczFsUza3RE81II//rfl1ed3A4sN4Pyhiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:43 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 4/9] iommufd: Allow a DMABUF to be revoked
Date: Fri,  7 Nov 2025 12:49:36 -0400
Message-ID: <4-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
In-Reply-To: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:208:32e::15) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: bfc29ff6-3cd2-4f06-ac5c-08de1e1da5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkNRWkxCVo6H+8wXz5aRyIbIqNuAcFEkrBMs3vpe4kc0pneTXmWzqs7otJC+?=
 =?us-ascii?Q?FC7RojxxmO5aQVA1hOA+aURB/iGT/sNBxuv4Tfj4K7RnJDjW2q5PSLLXU+qx?=
 =?us-ascii?Q?mwBpSNAdTpRPeADgQYBToZsoPppBfbGKDdUZicZ+t9SLNr8ogs4DOOKmZRZJ?=
 =?us-ascii?Q?GmrCj7ju15gX94ZhBdr9g+d0V4VhKl3QIVQd7LfVAWRC7FuE7LfVueMAipBi?=
 =?us-ascii?Q?hO7nB8dHlz3ndRExyGtcpnuGwhHfoSnirr/O5C2KXXMlpMjWP/aJbxf1c8gD?=
 =?us-ascii?Q?lUxgES4/zaaHVVJgi9NxsyBkBJvGfC1xzf7JY09ebRQGbYDkvobaLIqbu6Bv?=
 =?us-ascii?Q?8oqX2PYRcbQKxI394/H3UUIJ4iOfTdYmwU4uKruJhexj/B/QKDQm3T75Sw3x?=
 =?us-ascii?Q?BWZCH0MWgmkvCsk01bRq6+PzapPyZ1Pcr+AWi2x+UANhVkqRt/o4/1uM4FLD?=
 =?us-ascii?Q?2adohVjoGgI0Harf6A9T5ouGGwa8Jw5uEIf6vjh6v4FqJNaAjS15739WA9Vo?=
 =?us-ascii?Q?cwalkOb4UMukgqCcw5vWj+Q2U2CGOXlo/mEeJhzQ7wP084uJUXdNqEFaeMcj?=
 =?us-ascii?Q?3w/ryGODu9IQW4rYWJEa9MqAmeAj3nF+jv0aoEyHbDEGKwCkJAqJcaZ+uqUX?=
 =?us-ascii?Q?gNao1sM6KeUx3CBUkGzqZ+jQsnbeUT6+Gom2JhQWRLM4jJsvWJ9w6DTy1NpV?=
 =?us-ascii?Q?OrrX11XiVAmsqMIUHENEsnptlq3f0wzZwYJIcFiXi0HEO8D1y5lgkZs+ldu7?=
 =?us-ascii?Q?yQFegfiEEg2QnIxMWZmg1ywpaLLM3LusJkaMduq9k11Sca0EDuu+f/Bu2hXT?=
 =?us-ascii?Q?JAgsvZWWO+giYtkZR1wiqdBMuBnSlPzWVABm5L8PE+b+FLPOivM1pFrvuuxc?=
 =?us-ascii?Q?f+SN3TMAwvC46rfelHhWqHA7inlEsoiTbL9D6YQ77sexDzBP+7myV04CPYpC?=
 =?us-ascii?Q?UE6gV4oUJj6I/KJVaPFv6Vx3Mt6ZB6GqBLw/QltEGa7QjwPwsd9EgS32FdXK?=
 =?us-ascii?Q?h7uHoGtejEpehO8rFjVNq+To6qydo3OvZ/P+GnVV8e41vWYyWparblaUckpr?=
 =?us-ascii?Q?/gIqxbtGTXOmP2SMoRkPZvKPqhrG8kfq3QUcJnzVLID4tjf5syNYFyf3l5ZE?=
 =?us-ascii?Q?iYXgxNytF6i1UNhlCkTR95CM3XmoTx1T6klkWnW0sDUUmVaFp1kNrp6Cr52I?=
 =?us-ascii?Q?JtCllX+OCQvh7HqUoa4xGV41xMJ2o/fZ43pMzPFi0QwiDuhtdjLSVpRagbrC?=
 =?us-ascii?Q?fit8JBJ3K7X0qxiWj+EMT8hhcvuU0kauDkRaOscv3syW6cpH2ptpYIc9heqP?=
 =?us-ascii?Q?B25i8xDfeTai6ZICxEMCkpiL0iVCwkHzUJXpophQfm7Cr+TGcIH1NQR3sp32?=
 =?us-ascii?Q?dT+pmP3sXSbi4YQzX9GCvrMsmE57jfsUOjmcdJ4XwHsfHn3ag//cjWQFP4an?=
 =?us-ascii?Q?fbexLmKD7eKkNCeL30944YltWPDPPPFibmapZnnoC2Kn8dDvE8IxsQUzS249?=
 =?us-ascii?Q?b5wiXKzs3JXUOJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8rf37KvBHstfjhTjdKliO7o3deym5kcDwoVpCxbCYCt4a+yEHTv+EBgUK3qK?=
 =?us-ascii?Q?e2wktM2f5PGsrsU7sJs4Xsvq1XmFyNX1XyT2TRIxWm85A6IJW0gVdFGt0ZBK?=
 =?us-ascii?Q?KlZCpxlZv9oXsAlAusN+7h3uZAJYNbMjjoJygYL0EY8/6mcht7+iBA4+zDRD?=
 =?us-ascii?Q?21GHkCNuurBvV+cR2tnw51Y+zV0scrWZXZzSJLyoZze1h1Qsme8ATGWbOWid?=
 =?us-ascii?Q?BlMiHPp513TMOz2e8AnT6ioHnjA+shCxtE++YmUEmneZHUngAKdmlUJvbSNr?=
 =?us-ascii?Q?mVu2Av4fcKXGbWTyN+9X4vzni31ae2DUxRKXQbm6NUztyt0zl6z+TCdKDvWk?=
 =?us-ascii?Q?1ItFhFyhvqvrXWa7qDzyZiec7l3gQc3S0oUHvgh0OFA5Dg4mNedbKa8nXYIe?=
 =?us-ascii?Q?HrgLR1OdTF4rv0KT7sp17xqg0C0L1b5moMiCjeWl5La1mDuewwg0BgBZTzvL?=
 =?us-ascii?Q?4j/xcjy+zdhjRPb11zO7bZFeq4RcLHb2Mz6y7/EXPXwnBWF61eRUo3+Eh6v8?=
 =?us-ascii?Q?O/QOt93C3v5iJYV+BsjIysjvzVdBdPob3GzSBKYJKVURyFpM3/GYWa/58HQ+?=
 =?us-ascii?Q?0g7I0ELydxQFhPYNLgWNbo6eQTlF6R0BV/0nYLgFq+HDaUJt8TjQZFSJWcig?=
 =?us-ascii?Q?lF2eaKkvhG9OszHDI9k7qx4XhaVCcwUtzMNzviYd3JCqW+VvelghgZk94gbj?=
 =?us-ascii?Q?I5e+X/NS6IZw/zK+ZzudYs4oz/sflPEvJsbsDQzvL89KVrffyMaqfz1NOTo4?=
 =?us-ascii?Q?fw1PemDY0gBPb8rnZMQ9mKehg9/gXjf6XlPUbASnRzQaNDfge/tSzbDyG6Mz?=
 =?us-ascii?Q?D+DPRevuFu7ibpwGShPM7So52cEol2RNTHakjFOdsvkqWe5/r3Lw3bM893B6?=
 =?us-ascii?Q?KLJObzX8xqvAa7kB4T8elumdTwLaoO7fW8KRAzuvQTo9tg0m4r9Jl7ouvkXy?=
 =?us-ascii?Q?a1iUyQhK+B+C9ruvY9hFpbj7ODTxMIusB5z9fQtOy8zibMuonbUuTCm9ctlA?=
 =?us-ascii?Q?zp8jP0bJmEyeKvOxPirLgNeZ4RhcPbqkZcS2kOyaGSeuiUbR50OhNGLmt+yb?=
 =?us-ascii?Q?7jW4iUwIw++QgcLIspu0SftQ5gfQKQpfLGjmVPTF1aNvaWNC9pyhbW+RglCR?=
 =?us-ascii?Q?Nesz9c4wHsb7KwjTIyeppLojnSlxOISldIByBOT2rKw9wxQAp8NGRYTSRq2A?=
 =?us-ascii?Q?RLmXnQh0hvr5ohg9vbPZLKdclLbsZE/v6cQN7imQtUwdB9q7YZefyw37Fucj?=
 =?us-ascii?Q?1RAjqKaK4Ub89spsrpfh0EVOyAW/1QVcGjQkboaClcVMsiGitqCGwggaHYF2?=
 =?us-ascii?Q?bVA29lPWfUVGowt/OpqSy7A703mO3Msn3RNQeYDG+YN/sEZxKo/9dvJKDUuK?=
 =?us-ascii?Q?HH6mD6RDppBBBYax/6BE/+16KzS/2n5WCZ1pKmmy7OGKW8teOKltUfTeQWMt?=
 =?us-ascii?Q?+0vIrD7DTpAVqLrAP1bwFxZ70Hxe5bzmJLGtYvIY/N7gKKjy69XCxi2HPS9B?=
 =?us-ascii?Q?zNR/w3XPvf2jfGJRanrnNyW+fvBouVovBF7EYbJvmu5AbyQtNdJMEbiK3eQ5?=
 =?us-ascii?Q?x5k/nWOfQi7V4CWe5fw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc29ff6-3cd2-4f06-ac5c-08de1e1da5ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:42.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFwYFqItmNZx2z+vtbihCF5dM89omAm5X2kA9U0ajcPbKYfI+4PPobCh4ngkbppO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

When connected to VFIO, the only DMABUF exporter that is accepted, the
move_notify callback will be made when VFIO wants to remove access to the
MMIO. This is being called revoke.

Wire up revoke to go through all the iommu_domain's that have mapped the
DMABUF and unmap them.

The locking here is unpleasant, since the existing locking scheme was
designed to come from the iopt through the area to the pages we cannot use
pages as starting point for the locking. There is no way to obtain the
domains_rwsem before obtaining the pages mutex to reliably use the
existing domains_itree.

Solve this problem by adding a new tracking structure just for DMABUF
revoke. Record a linked list of areas and domains inside the pages
mutex. Clean the entries on the list during revoke. The map/unmaps are now
all done under a pages mutex while updating the tracking linked list so
nothing can get out of sync. Only one lock is required for revoke
processing.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c |  16 +++-
 drivers/iommu/iommufd/io_pagetable.h |  17 +++++
 drivers/iommu/iommufd/pages.c        | 106 ++++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 38c5fdc6c82128..a120c2ae942a8b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -973,6 +973,7 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 			if (iopt_is_dmabuf(pages)) {
 				if (!iopt_dmabuf_revoked(pages))
 					iopt_area_unmap_domain(area, domain);
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			}
 			mutex_unlock(&pages->mutex);
 
@@ -994,6 +995,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 		WARN_ON(area->storage_domain != domain);
 		area->storage_domain = NULL;
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 }
@@ -1023,10 +1026,16 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 		if (!pages)
 			continue;
 
-		mutex_lock(&pages->mutex);
+		guard(mutex)(&pages->mutex);
+		if (iopt_is_dmabuf(pages)) {
+			rc = iopt_dmabuf_track_domain(pages, area, domain);
+			if (rc)
+				goto out_unfill;
+		}
 		rc = iopt_area_fill_domain(area, domain);
 		if (rc) {
-			mutex_unlock(&pages->mutex);
+			if (iopt_is_dmabuf(pages))
+				iopt_dmabuf_untrack_domain(pages, area, domain);
 			goto out_unfill;
 		}
 		if (!area->storage_domain) {
@@ -1035,7 +1044,6 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			interval_tree_insert(&area->pages_node,
 					     &pages->domains_itree);
 		}
-		mutex_unlock(&pages->mutex);
 	}
 	return 0;
 
@@ -1056,6 +1064,8 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 			area->storage_domain = NULL;
 		}
 		iopt_area_unfill_domain(area, pages, domain);
+		if (iopt_is_dmabuf(pages))
+			iopt_dmabuf_untrack_domain(pages, area, domain);
 		mutex_unlock(&pages->mutex);
 	}
 	return rc;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 00fe06bf533d62..81c6093beee2a5 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -70,6 +70,16 @@ void iopt_area_unfill_domain(struct iopt_area *area, struct iopt_pages *pages,
 void iopt_area_unmap_domain(struct iopt_area *area,
 			    struct iommu_domain *domain);
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain);
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain);
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages);
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages);
+
 static inline unsigned long iopt_area_index(struct iopt_area *area)
 {
 	return area->pages_node.start;
@@ -184,10 +194,17 @@ enum iopt_address_type {
 	IOPT_ADDRESS_DMABUF,
 };
 
+struct iopt_pages_dmabuf_track {
+	struct iommu_domain *domain;
+	struct iopt_area *area;
+	struct list_head elm;
+};
+
 struct iopt_pages_dmabuf {
 	struct dma_buf_attachment *attach;
 	struct dma_buf_phys_vec phys;
 	unsigned long start;
+	struct list_head tracker;
 };
 
 /*
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2c1a59ab1cc123..97f5a173122b4a 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1366,8 +1366,19 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
 static void iopt_revoke_notify(struct dma_buf_attachment *attach)
 {
 	struct iopt_pages *pages = attach->importer_priv;
+	struct iopt_pages_dmabuf_track *track;
 
 	guard(mutex)(&pages->mutex);
+	if (iopt_dmabuf_revoked(pages))
+		return;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		struct iopt_area *area = track->area;
+
+		iopt_area_unmap_domain_range(area, track->domain,
+					     iopt_area_index(area),
+					     iopt_area_last_index(area));
+	}
 	pages->dmabuf.phys.len = 0;
 }
 
@@ -1468,6 +1479,7 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	pages->account_mode = IOPT_PAGES_ACCOUNT_NONE;
 	pages->type = IOPT_ADDRESS_DMABUF;
 	pages->dmabuf.start = start - start_byte;
+	INIT_LIST_HEAD(&pages->dmabuf.tracker);
 
 	rc = iopt_map_dmabuf(ictx, pages, dmabuf);
 	if (rc) {
@@ -1478,6 +1490,86 @@ struct iopt_pages *iopt_alloc_dmabuf_pages(struct iommufd_ctx *ictx,
 	return pages;
 }
 
+int iopt_dmabuf_track_domain(struct iopt_pages *pages, struct iopt_area *area,
+			     struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	if (WARN_ON(!iopt_is_dmabuf(pages)))
+		return -EINVAL;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->domain == domain && track->area == area))
+			return -EINVAL;
+
+	track = kzalloc(sizeof(*track), GFP_KERNEL);
+	if (!track)
+		return -ENOMEM;
+	track->domain = domain;
+	track->area = area;
+	list_add_tail(&track->elm, &pages->dmabuf.tracker);
+
+	return 0;
+}
+
+void iopt_dmabuf_untrack_domain(struct iopt_pages *pages,
+				struct iopt_area *area,
+				struct iommu_domain *domain)
+{
+	struct iopt_pages_dmabuf_track *track;
+
+	lockdep_assert_held(&pages->mutex);
+	WARN_ON(!iopt_is_dmabuf(pages));
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm) {
+		if (track->domain == domain && track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+			return;
+		}
+	}
+	WARN_ON(true);
+}
+
+int iopt_dmabuf_track_all_domains(struct iopt_area *area,
+				  struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iommu_domain *domain;
+	unsigned long index;
+	int rc;
+
+	list_for_each_entry(track, &pages->dmabuf.tracker, elm)
+		if (WARN_ON(track->area == area))
+			return -EINVAL;
+
+	xa_for_each(&area->iopt->domains, index, domain) {
+		rc = iopt_dmabuf_track_domain(pages, area, domain);
+		if (rc)
+			goto err_untrack;
+	}
+	return 0;
+err_untrack:
+	iopt_dmabuf_untrack_all_domains(area, pages);
+	return rc;
+}
+
+void iopt_dmabuf_untrack_all_domains(struct iopt_area *area,
+				     struct iopt_pages *pages)
+{
+	struct iopt_pages_dmabuf_track *track;
+	struct iopt_pages_dmabuf_track *tmp;
+
+	list_for_each_entry_safe(track, tmp, &pages->dmabuf.tracker,
+				 elm) {
+		if (track->area == area) {
+			list_del(&track->elm);
+			kfree(track);
+		}
+	}
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
@@ -1495,6 +1587,7 @@ void iopt_release_pages(struct kref *kref)
 
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
+		WARN_ON(!list_empty(&pages->dmabuf.tracker));
 	} else if (pages->type == IOPT_ADDRESS_FILE) {
 		fput(pages->file);
 	}
@@ -1735,11 +1828,17 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		return 0;
 
 	mutex_lock(&pages->mutex);
+	if (iopt_is_dmabuf(pages)) {
+		rc = iopt_dmabuf_track_all_domains(area, pages);
+		if (rc)
+			goto out_unlock;
+	}
+
 	if (!iopt_dmabuf_revoked(pages)) {
 		rc = pfn_reader_first(&pfns, pages, iopt_area_index(area),
 				      iopt_area_last_index(area));
 		if (rc)
-			goto out_unlock;
+			goto out_untrack;
 
 		while (!pfn_reader_done(&pfns)) {
 			done_first_end_index = pfns.batch_end_index;
@@ -1794,6 +1893,9 @@ int iopt_area_fill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		}
 	}
 	pfn_reader_destroy(&pfns);
+out_untrack:
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 out_unlock:
 	mutex_unlock(&pages->mutex);
 	return rc;
@@ -1833,6 +1935,8 @@ void iopt_area_unfill_domains(struct iopt_area *area, struct iopt_pages *pages)
 		WARN_ON(RB_EMPTY_NODE(&area->pages_node.rb));
 	interval_tree_remove(&area->pages_node, &pages->domains_itree);
 	iopt_area_unfill_domain(area, pages, area->storage_domain);
+	if (iopt_is_dmabuf(pages))
+		iopt_dmabuf_untrack_all_domains(area, pages);
 	area->storage_domain = NULL;
 out_unlock:
 	mutex_unlock(&pages->mutex);
-- 
2.43.0


