Return-Path: <linux-kselftest+bounces-26912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DAA3ACCA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A2F7A5B22
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DEE1DE3C2;
	Tue, 18 Feb 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kZQmPmJ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA461D8A0D;
	Tue, 18 Feb 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922625; cv=fail; b=DN8yYxerKJngyzihjK2opeSj7EtcGrLxr9mwJZQuRLJsK8XpfEDUZk+8refXS26K/dorUm+QzEm99S9rq838EtIaybT4X4qAIRGd1c0pT2OaKsl+5cvX3nxeqCBzMFprG/QgR7y+sgSAVHKiCw83B9E5JUnTzf5wp2tzt/0Xuw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922625; c=relaxed/simple;
	bh=KdkmW7tDzDjo1erXBiRihk/Gb0C2PVtzW0RA6w2ZXAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzFylFD5cfJk1w5rnCQRPzeeHHopfqcxBeYZXaKtYqc+acRWPmQ8MBhvHEUHpZWzU90ucrHJOCOnTqUXhffQP2czp3c+Dxeak56av1BNlMemwsSJAg9E1s7bU1UD5ROYC3QVDtyzXwCEcEPFVDQVbA5PIl1WGKhohpEbqDh3Ia8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kZQmPmJ1; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHestNL2GmPxGn2+8euWhFd7xmT9UknVJTeAvMNNfyp1e0RD+egnflA+hUHuPR4ol/dA1rAtLgwkQic/IFZ5RUInMcgm5Kn0+PfQ21d7pEVFKHXLUP2j+XGbiv6y+uEvcZFdTVO7jhlTjNgtFUv/sIqJkd4S1sZZKg4mlg2mXY1n9yRyjjzSSmkf8G8K/B2lRlaGMLKJJe9V4zbf3duFSq/+gFUIKXfNxRhsMQavnUR8i7N3gQBfBGbcizFMfvC6gQaOYV/dSQgm7EQmV/3XQNBIMJdFvg3kB1HKcKe+735xni2ERaJ8bBNSan62JT6veBDZ5AlFQalF2nsjmqlp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgICjOcm38ocqZikxGIl6O6eXZ912RghvM9zgt1IXPs=;
 b=WBfEdwKGhq/VavOSV+tLROmUqtnj7jPZsKeBuFiJBnTrjC25CQELQuml7b9VJCN7OdMHr86de+F6/QMAeAgD7HWDiMCvWKw9yZBB4dlSXl6itAymaXyiT21Y20/agxu9M6Blnvb/m4A6bnwSshdvVOs57iV/ln3FF7nu3uq8rjLVVDM+7YS/FGwOOViusEUO9vozAWZg0+xmkDDrv3p8QIlrvzfB3oLdZlXza3j+SkxGemyvn/KM/Ebylj3BayvhJfJ+REJ/bQrtxvHgIPVHxW6fFpBkfenJ0Wdo0IBiFtul47OiYuawUh4ZKKVauGhaaJ9xzZaUmZovk64hPXVGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgICjOcm38ocqZikxGIl6O6eXZ912RghvM9zgt1IXPs=;
 b=kZQmPmJ1/pxpSHyYrqZkOP53CZuhxatgk9phuru2DOiU9QeECM8xufcvsYg9MSSrz4pnjQ3lcY4Yzhv26i1es/nIjkWig67GPjtvsaNVEYOIVn4PCxU14ki8L1B+VE3aCN8W3gaRXWjtXyZHSSaz75/uwAUOy2rLZFP3VHRWoHrXp/esyNlfiiR3yIlOFCT3xQMUq1EWaUclP4EkgiowtmCH0YdSIrovaV0RVENqVG17IKFUVX61K4x4kOje7yWbb4utdlnrv6qYnE/aKvIBaHFUPot4gCljSm9MA0O2l0VT1h5EpKhwooduSnK4a2hJFL8tuLlwP+ZoCOXwXQEHbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v8 1/8] xarray: add xas_try_split() to split a multi-index entry
Date: Tue, 18 Feb 2025 18:50:05 -0500
Message-ID: <20250218235012.1542225-2-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 86587819-ab44-4579-0fe8-08dd5076ffe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?03cCbxOFHLCLHRlOlr9q4y37+bmMdZ42ZLBnc8+JtZLPV2mw19aMYTLj6EQo?=
 =?us-ascii?Q?jrrjQJ89I8FsJaxks5OQlqFmOiHuXF3VQiGjoTR3wOO7H/DbOvHB7R5KuyhK?=
 =?us-ascii?Q?WHMgDVjHnBKdxc4SlHgqQ9ILe3rXm7aa/JHTrc2R5JtNxXOtYbnM/1ikYoLQ?=
 =?us-ascii?Q?7MliREnUFN3Xy/65oRuzTw2XwyF7j1RPKympJOw52WXEOCw1gDYfoDjD+k7V?=
 =?us-ascii?Q?oRhJLuBa9RjFfyjVT1wnJKQip6IylhIbEDT5aDOnVEkzrtVIrSkMCGWPPIDs?=
 =?us-ascii?Q?u3NsrLYUMK//U5nKLsALEGUhxZ8dAWlOhTZcmZnHH5af4cKITBH+3GqkrLd7?=
 =?us-ascii?Q?ZWNqokrb7srsfGf72KR31K/iTgvcvx0AAj3qAgNLI5DQf2F6DNeq96P/mza+?=
 =?us-ascii?Q?cs76IjjwEP5YGpOH+vizAAxLIZkx/IcAhPsZk/qw8uG1lfk5uIUmhqDee2t6?=
 =?us-ascii?Q?ihZ/mgnlBj/1paVvSgGBqWuVpwTRFKUOJaJeUhumprj6j/6Dtuqo2IF9Gros?=
 =?us-ascii?Q?UuEMf+to1NKx5Lf1EidvSYPXzDH8cf2DrodzX1DuVaYjuGG2A7M2u/UcZajz?=
 =?us-ascii?Q?xfBSh6IjmKk3tBFqqESaNX462/xeas0V2SyHtDZn1AESRxrdEWB3qbI2BuOp?=
 =?us-ascii?Q?4TdUBeRYvqeSXtnC2iXydBhF1GC7HSMVCVDwlZLDHdjpW+EPEYlY7zFquQd2?=
 =?us-ascii?Q?ZZWIlSVLhdm3/cGhsdD1D3adliEbUx0qBbQjc12vN61jQKa69FcNQNpz5M/h?=
 =?us-ascii?Q?hwiRw2GD2AoAZClP5h0BeKOCfSGvCwzEpOafxWkOsufyAkUzE650bSV2BLTV?=
 =?us-ascii?Q?bdyXXC3gKWkJVv/90775zWRc4cEYgcq+nUQCWRjmqr3Q+MI7iQYhrXXIpj6L?=
 =?us-ascii?Q?WKqoJ+v2b40qVF2NA986VnLVNawbVZQGd368PuMutjHhcNidT6WQ3mWYj6ln?=
 =?us-ascii?Q?x67rq3BmyWphDeqB21umOrRQ9X6ZzzGsQGrEpwzkI4NCB0Qpyo370Yf0Asfv?=
 =?us-ascii?Q?Ca+a+OMXmR8dQSNmt1tvPREIIJT1Iggp4fQ5RZT+h93UjNyG7ZQILwSO5RhM?=
 =?us-ascii?Q?ZcA2AQZE5GNH4A2dnM+Fp3HnQBPpW+ZaJk3VRCyh28aUw5c3lw/pXCwRZwKT?=
 =?us-ascii?Q?TncMh2EYnIBt6KUJnKfbb+EPE+dZO0XeX7yKmsYSAZE6bbuf6aqNL4yl/ZHJ?=
 =?us-ascii?Q?cPiRYLvsV28pwEB7b2Zf+RSGuHnG57jNvGlF+Z3wclUS2grv47dvZ9RFEBh+?=
 =?us-ascii?Q?fwPl9+CBPjeJnxMPBEFfG0R1XQcOB+sBsK7n0FVghQ3ynR67gstD6N2gStEX?=
 =?us-ascii?Q?elr0XmpdRkzQl0doqU+oVTvFlWvhShGzismXbzLoMSwV35bqClTIslJoVWy+?=
 =?us-ascii?Q?eJ+fYuVvkOoBwbe3Ar3U70myeIQQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IalGbAuNCZtsE6g8SPJqktoN74YSV+vRrw31Qbk2Yfg2/QbYA2UU3Z6uxQet?=
 =?us-ascii?Q?49mowjWfoyIEwFZshWv915VXHI1jd5qXpKHJ7Deb8GPYSp+LzUww7XYngLM9?=
 =?us-ascii?Q?K6H4ld2124SlBj/cqaI/ueSROzh4BWb/bHE2uSOZccjrXPJVoPvH7kVriTni?=
 =?us-ascii?Q?2/sDsMiCZ+r416wVVsFkuRoj9pVdMlmXjh1s3J5VcCGlnCmYbdCCYM4TR+Q9?=
 =?us-ascii?Q?QN9M1jLRVoce9GD19X/NVIzCn0tjqgMmuPBZ7XWNXntsO2epLOfwKocWBkUz?=
 =?us-ascii?Q?bfWOca2wzrsCn7YGILm/d+7LW/yTPBQKGR9SLq2h+8TFtEgaPaW+sU6/f3ME?=
 =?us-ascii?Q?Uxj4fYi8lwn8HRrW4T2RrIN5XYkyBcrKsllCE1+TFasX09m1/328Yj+zncrT?=
 =?us-ascii?Q?XFQ/2s/GI9pq74gvAispht/Q+r3WcM9kZnq6M7V07g5HIb4nPY7jd1E4XEuv?=
 =?us-ascii?Q?GKFEYY/+TjMmooffv+DWcHOEVruQ3A6jgUzoXPeWh13f5UqR6eBOHqlEbxtm?=
 =?us-ascii?Q?U5r5NPqpfDngM2XK75L254T+9PONZLxXBoku+3CYMx11TrF8S4xNpVuHVC5Y?=
 =?us-ascii?Q?lIEYwal+/efFJ934iLsh58mkZTfy576vLNW03v7ULq2BwzcUaHZuT2xsCGg5?=
 =?us-ascii?Q?YgLmBH95/3E7rYE1q3JhhEGgtG0zmWcFs3rd0iKv/BIvXu1oX5TAFkWRO2hZ?=
 =?us-ascii?Q?izg+leQ9/Qfe4YnoGFYNLr4Kckz/4eRonMhlxUhvwDMZmZwoROXIBo4IBWx0?=
 =?us-ascii?Q?LEwTAgySsikx4GqY8TtJKchmeDDPa0jHNHFjEjC7xCDLst/vjreGQkmWC9DC?=
 =?us-ascii?Q?guriarNzkkUUCT5XSpQbAJFUSs+mJnUsWwTkO3d5cXIlg2lYN3pZDM7DcZHf?=
 =?us-ascii?Q?kKfjw3WhXkHbOdME7mBqd11ulqjMgZ3s39Dq3slSjuTceKETZCMRZu9PAx4W?=
 =?us-ascii?Q?/ikJXBYkDsILsOnZcQm20Lr3Z5ZQ/YKTYu1nVorNHQetlnlDSLVoFjPae9NS?=
 =?us-ascii?Q?XyWkk6W6BvjOs34xofYJ68sa3LY0vB9OIUXaX3DcWk3BnVzguaw7t2mfJ8uf?=
 =?us-ascii?Q?ESGkXQiYBMauliMLrg2RaHcNuQHzI0q8BFKmkARP7y+1MeTHBrvI3Gu3wtOW?=
 =?us-ascii?Q?Fbp8ctNXyeC/o/Mwn4tDUbnnT+HJA0cWbKJQEmPuB3bSYrsCsbyIaMYLfaXZ?=
 =?us-ascii?Q?AAsKbHVeL2+xFXsoMpl+9OWrgSPrIBKKNw239Z2lDFx2gexZMP2cjHKp0O/i?=
 =?us-ascii?Q?5VtpPykCsZhM6wd1x9s2Vo+UXv6VoRiUOVdXIXuc6OkdRbMsXhVFnkvocL/X?=
 =?us-ascii?Q?sX9nFuL28WrSipkpVW3Xu8LE/V/C5il599FEgOrdvwzrRDKCgQWXk1WZpmfW?=
 =?us-ascii?Q?/lMAEIyMiBMp6xIiMWb4+1rNnwf+ZQsnvbAOZUtltCrtL/pC40Ssem4iALrD?=
 =?us-ascii?Q?Ihiraq9Zal0mhAoclMo8Atzg1yCFGknLLW4fEnWmlXm1oGAgOnAW5hQTT+FM?=
 =?us-ascii?Q?/majNpFYCzA5RNeJtnh7KQhLOD1wUpG607UnbViL7L+DinywLp9Q8Szk/1SO?=
 =?us-ascii?Q?/PC27O7J99RWm87BIrm1aJoQBgQGV+H+W6+mhqIC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86587819-ab44-4579-0fe8-08dd5076ffe5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:18.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ptw7INMBVHc/oZUmG5EtYvUzIrgKvYOqQ7xmaWSt2+BfzBC5ieYicryTyrjEtQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

A preparation patch for non-uniform folio split, which always split a
folio into half iteratively, and minimal xarray entry split.

Currently, xas_split_alloc() and xas_split() always split all slots from a
multi-index entry.  They cost the same number of xa_node as the
to-be-split slots.  For example, to split an order-9 entry, which takes
2^(9-6)=8 slots, assuming XA_CHUNK_SHIFT is 6 (!CONFIG_BASE_SMALL), 8
xa_node are needed.  Instead xas_try_split() is intended to be used
iteratively to split the order-9 entry into 2 order-8 entries, then split
one order-8 entry, based on the given index, to 2 order-7 entries, ...,
and split one order-1 entry to 2 order-0 entries.  When splitting the
order-6 entry and a new xa_node is needed, xas_try_split() will try to
allocate one if possible.  As a result, xas_try_split() would only need
one xa_node instead of 8.

When a new xa_node is needed during the split, xas_try_split() can try to
allocate one but no more.  -ENOMEM will be return if a node cannot be
allocated.  -EINVAL will be return if a sibling node is split or cascade
split happens, where two or more new nodes are needed, and these are not
supported by xas_try_split().

xas_split_alloc() and xas_split() split an order-9 to order-0:

         ---------------------------------
         |   |   |   |   |   |   |   |   |
         | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
         |   |   |   |   |   |   |   |   |
         ---------------------------------
           |   |                   |   |
     -------   ---               ---   -------
     |           |     ...       |           |
     V           V               V           V
----------- -----------     ----------- -----------
| xa_node | | xa_node | ... | xa_node | | xa_node |
----------- -----------     ----------- -----------

xas_try_split() splits an order-9 to order-0:
   ---------------------------------
   |   |   |   |   |   |   |   |   |
   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
   |   |   |   |   |   |   |   |   |
   ---------------------------------
     |
     |
     V
-----------
| xa_node |
-----------

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zi Yan <ziy@nvidia.com>
---
 Documentation/core-api/xarray.rst |  14 ++-
 include/linux/xarray.h            |   7 ++
 lib/test_xarray.c                 |  47 ++++++++++
 lib/xarray.c                      | 138 ++++++++++++++++++++++++++----
 tools/testing/radix-tree/Makefile |   1 +
 5 files changed, 190 insertions(+), 17 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index f6a3eef4fe7f..c6c91cbd0c3c 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -489,7 +489,19 @@ Storing ``NULL`` into any index of a multi-index entry will set the
 entry at every index to ``NULL`` and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
-and calling xas_split().
+and calling xas_split() or calling xas_try_split() with xa_lock. The
+difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
+that xas_split_alloc() + xas_split() split the entry from the original
+order to the new order in one shot uniformly, whereas xas_try_split()
+iteratively splits the entry containing the index non-uniformly.
+For example, to split an order-9 entry, which takes 2^(9-6)=8 slots,
+assuming ``XA_CHUNK_SHIFT`` is 6, xas_split_alloc() + xas_split() need
+8 xa_node. xas_try_split() splits the order-9 entry into
+2 order-8 entries, then split one order-8 entry, based on the given index,
+to 2 order-7 entries, ..., and split one order-1 entry to 2 order-0 entries.
+When splitting the order-6 entry and a new xa_node is needed, xas_try_split()
+will try to allocate one if possible. As a result, xas_try_split() would only
+need 1 xa_node instead of 8.
 
 Functions and structures
 ========================
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..9eb8c7425090 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1555,6 +1555,8 @@ int xa_get_order(struct xarray *, unsigned long index);
 int xas_get_order(struct xa_state *xas);
 void xas_split(struct xa_state *, void *entry, unsigned int order);
 void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
+		gfp_t gfp);
 #else
 static inline int xa_get_order(struct xarray *xa, unsigned long index)
 {
@@ -1576,6 +1578,11 @@ static inline void xas_split_alloc(struct xa_state *xas, void *entry,
 		unsigned int order, gfp_t gfp)
 {
 }
+
+static inline void xas_try_split(struct xa_state *xas, void *entry,
+		unsigned int order, gfp_t gfp)
+{
+}
 #endif
 
 /**
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 0e865bab4a10..b76d9809f5c1 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1858,6 +1858,49 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	xa_destroy(xa);
 }
 
+static void check_split_2(struct xarray *xa, unsigned long index,
+				unsigned int order, unsigned int new_order)
+{
+	XA_STATE_ORDER(xas, xa, index, new_order);
+	unsigned int i, found;
+	void *entry;
+
+	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+	xa_set_mark(xa, index, XA_MARK_1);
+
+	xas_lock(&xas);
+	xas_try_split(&xas, xa, order, GFP_KERNEL);
+	if (((new_order / XA_CHUNK_SHIFT) < (order / XA_CHUNK_SHIFT)) &&
+	    new_order < order - 1) {
+		XA_BUG_ON(xa, !xas_error(&xas) || xas_error(&xas) != -EINVAL);
+		xas_unlock(&xas);
+		goto out;
+	}
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		__xa_store(xa, index + i, xa_mk_index(index + i), 0);
+	xas_unlock(&xas);
+
+	for (i = 0; i < (1 << order); i++) {
+		unsigned int val = index + (i & ~((1 << new_order) - 1));
+		XA_BUG_ON(xa, xa_load(xa, index + i) != xa_mk_index(val));
+	}
+
+	xa_set_mark(xa, index, XA_MARK_0);
+	XA_BUG_ON(xa, !xa_get_mark(xa, index, XA_MARK_0));
+
+	xas_set_order(&xas, index, 0);
+	found = 0;
+	rcu_read_lock();
+	xas_for_each_marked(&xas, entry, ULONG_MAX, XA_MARK_1) {
+		found++;
+		XA_BUG_ON(xa, xa_is_internal(entry));
+	}
+	rcu_read_unlock();
+	XA_BUG_ON(xa, found != 1 << (order - new_order));
+out:
+	xa_destroy(xa);
+}
+
 static noinline void check_split(struct xarray *xa)
 {
 	unsigned int order, new_order;
@@ -1869,6 +1912,10 @@ static noinline void check_split(struct xarray *xa)
 			check_split_1(xa, 0, order, new_order);
 			check_split_1(xa, 1UL << order, order, new_order);
 			check_split_1(xa, 3UL << order, order, new_order);
+
+			check_split_2(xa, 0, order, new_order);
+			check_split_2(xa, 1UL << order, order, new_order);
+			check_split_2(xa, 3UL << order, order, new_order);
 		}
 	}
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 116e9286c64e..b9a63d7fbd58 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1007,6 +1007,31 @@ static void node_set_marks(struct xa_node *node, unsigned int offset,
 	}
 }
 
+static struct xa_node *__xas_alloc_node_for_split(struct xa_state *xas,
+		void *entry, gfp_t gfp)
+{
+	unsigned int i;
+	void *sibling = NULL;
+	struct xa_node *node;
+	unsigned int mask = xas->xa_sibs;
+
+	node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+	if (!node)
+		return NULL;
+	node->array = xas->xa;
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		if ((i & mask) == 0) {
+			RCU_INIT_POINTER(node->slots[i], entry);
+			sibling = xa_mk_sibling(i);
+		} else {
+			RCU_INIT_POINTER(node->slots[i], sibling);
+		}
+	}
+	RCU_INIT_POINTER(node->parent, xas->xa_alloc);
+
+	return node;
+}
+
 /**
  * xas_split_alloc() - Allocate memory for splitting an entry.
  * @xas: XArray operation state.
@@ -1025,7 +1050,6 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		gfp_t gfp)
 {
 	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
-	unsigned int mask = xas->xa_sibs;
 
 	/* XXX: no support for splitting really large entries yet */
 	if (WARN_ON(xas->xa_shift + 2 * XA_CHUNK_SHIFT <= order))
@@ -1034,23 +1058,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 		return;
 
 	do {
-		unsigned int i;
-		void *sibling = NULL;
-		struct xa_node *node;
-
-		node = kmem_cache_alloc_lru(radix_tree_node_cachep, xas->xa_lru, gfp);
+		struct xa_node *node = __xas_alloc_node_for_split(xas, entry, gfp);
 		if (!node)
 			goto nomem;
-		node->array = xas->xa;
-		for (i = 0; i < XA_CHUNK_SIZE; i++) {
-			if ((i & mask) == 0) {
-				RCU_INIT_POINTER(node->slots[i], entry);
-				sibling = xa_mk_sibling(i);
-			} else {
-				RCU_INIT_POINTER(node->slots[i], sibling);
-			}
-		}
-		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
 		xas->xa_alloc = node;
 	} while (sibs-- > 0);
 
@@ -1122,6 +1132,102 @@ void xas_split(struct xa_state *xas, void *entry, unsigned int order)
 	xas_update(xas, node);
 }
 EXPORT_SYMBOL_GPL(xas_split);
+
+/**
+ * xas_try_split() - Try to split a multi-index entry.
+ * @xas: XArray operation state.
+ * @entry: New entry to store in the array.
+ * @order: Current entry order.
+ * @gfp: Memory allocation flags.
+ *
+ * The size of the new entries is set in @xas.  The value in @entry is
+ * copied to all the replacement entries. If and only if one xa_node needs to
+ * be allocated, the function will use @gfp to get one. If more xa_node are
+ * needed, the function gives EINVAL error.
+ *
+ * Context: Any context.  The caller should hold the xa_lock.
+ */
+void xas_try_split(struct xa_state *xas, void *entry, unsigned int order,
+		gfp_t gfp)
+{
+	unsigned int sibs = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+	unsigned int offset, marks;
+	struct xa_node *node;
+	void *curr = xas_load(xas);
+	int values = 0;
+
+	node = xas->xa_node;
+	if (xas_top(node))
+		return;
+
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
+	marks = node_get_marks(node, xas->xa_offset);
+
+	offset = xas->xa_offset + sibs;
+
+	if (xas->xa_shift < node->shift) {
+		struct xa_node *child = xas->xa_alloc;
+		unsigned int expected_sibs =
+			(1 << ((order - 1) % XA_CHUNK_SHIFT)) - 1;
+
+		/*
+		 * No support for splitting sibling entries
+		 * (horizontally) or cascade split (vertically), which
+		 * requires two or more new xa_nodes.
+		 * Since if one xa_node allocation fails,
+		 * it is hard to free the prior allocations.
+		 */
+		if (sibs || xas->xa_sibs != expected_sibs) {
+			xas_destroy(xas);
+			xas_set_err(xas, -EINVAL);
+			return;
+		}
+
+		if (!child) {
+			child = __xas_alloc_node_for_split(xas, entry,
+					gfp);
+			if (!child) {
+				xas_destroy(xas);
+				xas_set_err(xas, -ENOMEM);
+				return;
+			}
+		}
+
+		xas->xa_alloc = rcu_dereference_raw(child->parent);
+		child->shift = node->shift - XA_CHUNK_SHIFT;
+		child->offset = offset;
+		child->count = XA_CHUNK_SIZE;
+		child->nr_values = xa_is_value(entry) ?
+				XA_CHUNK_SIZE : 0;
+		RCU_INIT_POINTER(child->parent, node);
+		node_set_marks(node, offset, child, xas->xa_sibs,
+				marks);
+		rcu_assign_pointer(node->slots[offset],
+				xa_mk_node(child));
+		if (xa_is_value(curr))
+			values--;
+		xas_update(xas, child);
+
+	} else {
+		do {
+			unsigned int canon = offset - xas->xa_sibs;
+
+			node_set_marks(node, canon, NULL, 0, marks);
+			rcu_assign_pointer(node->slots[canon], entry);
+			while (offset > canon)
+				rcu_assign_pointer(node->slots[offset--],
+						xa_mk_sibling(canon));
+			values += (xa_is_value(entry) - xa_is_value(curr)) *
+					(xas->xa_sibs + 1);
+		} while (offset-- > xas->xa_offset);
+	}
+
+	node->nr_values += values;
+	xas_update(xas, node);
+}
+EXPORT_SYMBOL_GPL(xas_try_split);
 #endif
 
 /**
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 8b3591a51e1f..b2a6660bbd92 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -14,6 +14,7 @@ include ../shared/shared.mk
 
 main:	$(OFILES)
 
+xarray.o: ../../../lib/test_xarray.c
 idr-test.o: ../../../lib/test_ida.c
 idr-test: idr-test.o $(CORE_OFILES)
 
-- 
2.47.2


