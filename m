Return-Path: <linux-kselftest+bounces-25786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29087A2827F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254963A667C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D121421F;
	Wed,  5 Feb 2025 03:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baztV1hc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34F2139D7;
	Wed,  5 Feb 2025 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725283; cv=fail; b=rquqZ2v7oRQSOpQv/yuKoY99IMk56IEuZIfouWN6J2n2dv5yWqWE0yR7Jr6/vUFgd/2q2N4EJAT/vRTo0BFAuRVE1XSTllUezFGRbmjxhf2C/qoviEw4JBptFERtsfq6Y/JmBXuPsOfRqwYJYFhQSJBCUAaI+KMEaCPs7tjFO2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725283; c=relaxed/simple;
	bh=dVnZrnVjLelBfXvBtZFmCkpeFhkWmePdtAwccpbrmOU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JFFA7OBDSKNBjzfShXbOiZkeEFmEFqOdmz5zsvDw9hT2GTebmyWQqYcvapFxQXTdyeWwnsWcFujr0NHGmK6Ax0QdSx4X/p4WH7j/T1MtQK/mR9wJdJV9RhCnB6P2Vrb5a6L+4NB/pMEJWR0/hFO5cEmYm2vNu7F/fbUr6TYkABw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baztV1hc; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdSM8lZu579y1FMsIPGVjkzIfzC3QLhNJJnKpdzim7LGDo/tuU2w2IyJq6dgizJ4/Vf5EurAcCUdbrmbfezJvYh6guiqJWLaXAezd+HZW/yIOd9FKFAvO1u4NW+0pnW1Z0TWNdiMjc9eqN6CfUnOZeRTlMjz3ID22qq6CO41I6ibnFGZtU6NkVnHUxUOHzC4MSxy/l9pBAsNKQuKZshKUuiWgBwVJmXm/w8survs33gVChlGeOjZ1MQW1v50Q3C6UlfV3y+Z4ZMz3fu44zaplsV05q84SMTwJ83NrnUdVM4XjxIof7Eize8Ykgz9G7jDlih6ahTYFY/UfAUZRBtYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6rnZWyVEKcmONQ1CX/Oq13/kGG7zneK54iw+H7F2Mw=;
 b=DgQWqM8TUAwDmhjz7HSzX0WzhvAy/1M8GBY9VR9ayv3aqkEhwIhteujRU53T8AewDPvxnOBjwDMimFSDsd9JAJxs/5ZoIZyUTocK88uFXwZ4n6paikobx8wc/v3kdFWIXBw5dBgfcdho6qJam5XCkgvsT76ungpHQHyqvN2BEfA0c1gN33C+n78DsVD9yLrEvYcfav+mo4uLis4pjTURR8g9mose3ZeTlHJmObGyzHFne5RonY6TZP5I5pvpMI4DWSicT4nExyYXsobOs2EetfNZxJ3mgn6nQfOcbWYJZfFzhSCzXnR5hHQ16Ob/2BOgOiwhKzQS0t5dcS3CIxCLRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6rnZWyVEKcmONQ1CX/Oq13/kGG7zneK54iw+H7F2Mw=;
 b=baztV1hc7orPuH8V03DPfJ6bMFer11Nr/3jGrONaVnbmMUmO9xjP6BcwV0fuy+oRgr/lcy+/mTJZ5yTJm+1VSovGDltxFwFDFCa8bcV2YI6yzT0CM99Pp3xT+ZYqC92En+xLgvfv7EfBnI9KWxbzBnxbz00RdKxpeg9L8bWGjKUp+L4gmptrkakIEN3wuzbsy9dVzUiaDyJXta9nVlJmIvaoNq+qYNB5Pa/tIqvJ5aPaWfygoa2yzFLdk03/vwjoJKd1NJn8T7B7Z5L0vepxrJOU+9ktYo6RBlavnrTBRYRj3j2DAmuCiRrnUu08eCMtU4bu3xo+PU2EG7spGPj+8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:34 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:34 +0000
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
Subject: [PATCH v6 0/7] Buddy allocator like (or non-uniform) folio split
Date: Tue,  4 Feb 2025 22:14:10 -0500
Message-ID: <20250205031417.1771278-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d7755-f19e-4e5e-22ea-08dd45933747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xO3pEMi21BiBRrHd4f1nBQV6/V6gejeBOws68dLSK8MSjaFA2p1B7So57q8Y?=
 =?us-ascii?Q?TDY/PLwG0tV4KlVa6iux9qaa5bbjumnCqiIXJkoOLt1vFeUD7hAtnGJdhPVL?=
 =?us-ascii?Q?WBM8fgruYQrUHKnWCArxTOX/Yrso1HI3ZjEXq6+m/it1/GaiF4dPV1VLmIiI?=
 =?us-ascii?Q?21sDQWUA1XfXB201NTYUCeRJfANNufz3IQreggDmqpmUBh/4R0wrPur3Gd9G?=
 =?us-ascii?Q?zaoDN90A4bPYI8rQ+YI/VzrCR+9Xp4k74mM8OZIPUvS6Zw3KMHdMN3JC9g+L?=
 =?us-ascii?Q?nglW/GWwmhMyPO5e1sq1kA0axSC7+T7mccmQ4cyaRusR8v0bTb1gJ5sSU5TC?=
 =?us-ascii?Q?mudlH7zPHMjt3u594mPSLXPUJprz7+vb1BxyKAeFYyG3gslcjGw7ZAJuSe+h?=
 =?us-ascii?Q?TJOBcoKAK7qXWlvXZDpX8glETwpABurTYpFpZRiKj2gVQpfBCXJtdtPE2Elz?=
 =?us-ascii?Q?5QM55Kv+nPZg2SidTxFs2d3LLsPM67oO5OF7RLbEOvjKYfcNwySWl+XZRGvm?=
 =?us-ascii?Q?F5VaV45w+8OfsY2w37t9a5FwU5xsT3MnCrslp6gwgu537w+jW3mQwCqn8l8Z?=
 =?us-ascii?Q?/5Rf0Fio2Mzn4fT4abtBcstlWCusx6q88B1VyHiXZci5KNw7gDuWVizVo9NN?=
 =?us-ascii?Q?hdDJu0fl5sT5bcjb38RPm4XUgI4GTecV1NC1trQ0O5FG4Uruj5KoqllQfCrf?=
 =?us-ascii?Q?XcpR25DpDvltEi8Ef+cDp7r3/BPIC/SklXuaALgI6VxS+75An7uV4Gjhf62m?=
 =?us-ascii?Q?9Eg4HuACrOKHhEth3A5ju8l9d+Fdd6kKfbmi+teGBrzTE+XQ9Yj7B9B3DLqg?=
 =?us-ascii?Q?x33goDqQLzciPFJHA8B3ymS8ruCTOzRj4oKNPDefvPGIEXTGALBBVkWPJnKQ?=
 =?us-ascii?Q?lILcPdhsdy4+sv73wteLDVeD2sZVwQdXR9+VHxt3j8u1bHxm1BedIt17CqkK?=
 =?us-ascii?Q?ZEsdn5SSIt2LOUXDSqO4NWD2yqaSNZOz8T0VaB+x/p4XMjcPBYUJsBfqxzfA?=
 =?us-ascii?Q?Flko2gck0+EuW9UbGIwBtHItohiTNd/tln1+xC1MppX8x7i17zEp8mOoEuxo?=
 =?us-ascii?Q?I33geZ/flljB7d8JBajwfPY538DSehdvNg1/vcB/0KgCT7tila/X3BSPIBag?=
 =?us-ascii?Q?s4t2U4GLwL1SU8ur17LMZhdE57a+caAwldJXOI7OetB0r2TBu70uVJRaENyd?=
 =?us-ascii?Q?uOMxLZ5HhjUus8nPLOYaHL5kQCecLfWVm4P+2jMhZ7sXtQJAeRaI8wG/CEqd?=
 =?us-ascii?Q?qNg/y+9SZ7wvfEjO6Rpm9uOltZ8L96ucLjScn0+qCmcqiqR20zwuk9DDj0FB?=
 =?us-ascii?Q?62ftFcqq4JUCK4AVau7mjVasDRSBcLwVK7UYRtH1R4D4NWy2dHuO9PyC3H/n?=
 =?us-ascii?Q?BG4cjf3CnUlkSUrCUA5iPw65/785?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H6xs/I5pe9tS9KKH9/t2013mtTbwuTR2jTPdq/v7RfPnZ+RIfKxX1/0SGVy9?=
 =?us-ascii?Q?4hmRLKxfLSV5rXt5NlvonqKMCvkDC1TSdfchWMPgKy+NAKmg4Ofdu9Ab0m6b?=
 =?us-ascii?Q?w09HFBIlIoA6nCt25AZzIxMD60DIdOp0aB60jAxMxD8PtLzSfvy98xQviftL?=
 =?us-ascii?Q?hcUc2C2MjQSaqOCjBVx8zUhy2tNobCx5tosNxn8ymKT/liIZTmvzVUctCsDd?=
 =?us-ascii?Q?WxN9eVk4iyxlcDiZVvQxOklI3KCuItfy0DrRdJGqqsR98ZrBbamUEV9OfBvC?=
 =?us-ascii?Q?I9cFgGx0obLV/Ij/h56ii6gsJEp3BPeJpxTSnQwR+3hHOYGb42+eEL1l/Yy+?=
 =?us-ascii?Q?c1DjvxmtqD2mVDFG19zKzaMbTZ/vpSEyn+lg4ZqCY4cN5oUDDE86hWU2Kjyh?=
 =?us-ascii?Q?CvkLSnZcK2EWiUx4Y7UdxFrXThpTEtrZqlXxN6di1/CO2Du75NPRWky/VY6V?=
 =?us-ascii?Q?boNL1VqRIPZd85r173Zss+8wSOXcG/KF15tmr4cKz9t9mFUzJVUUR/32XinT?=
 =?us-ascii?Q?M2U33/J7DY5xQvRap9cHZIGeX+H2z4DK05X7t63Jd+0XQYIcqq/H8ctKMzf8?=
 =?us-ascii?Q?HfnBmXL4MkUe5zsZ13gtLzL0VCmnq9qYmrkft9sPNzwTo4lYTouGmGuiLVV0?=
 =?us-ascii?Q?qBt9A0lChFRv2Ee3JJ9RLHI2shNhn3naMjmucUKNBoi3Cnr00JT9IQV8Iud9?=
 =?us-ascii?Q?Apugne3gJpW7eklt3/j/TmO8kuKuSfnp8e0SD+BHL33lTLIw/7NYr86INwpj?=
 =?us-ascii?Q?eg1keCuyTQj16PpjbKT5VTP3vLGTk3zWGFFIUuLNapGULOrS5x88RSyU1GdQ?=
 =?us-ascii?Q?k7TfK5eLTFhNF/GyXHdTyzWnKOPqMrlvBNxXptvBC7mwpsaHtypPpoZHc4Zy?=
 =?us-ascii?Q?YLVtTkSqAywqRJzfB2CF8RBZDdJFPSNtaA83PE8fWefCEkSu5SjVSsreMVbi?=
 =?us-ascii?Q?VxfppLfiG3UT/7JytMM0aLl1k8egWFHpI5fjbaTZ2uboOgD5uieQQ2Si1DPQ?=
 =?us-ascii?Q?48TZsHH5EAqe6v8DYyMEjILIQEz394uYfRZw/P1mxnFlVKkSq1PKJTenw7zc?=
 =?us-ascii?Q?f/JO86jm63EZuiT57RjeZKnq0p7HVOolCRBtzlv3c5ij2oixPydtXQJt1cWU?=
 =?us-ascii?Q?nIJG62cd5uSVaDyXFA+v5DM9gmPF7g4oeqcjlgK6Z/7dhjkAYC8GqnWWkyXX?=
 =?us-ascii?Q?UKbuSKEwjn9mkZi1Ja6guygwlkwkHDI2kd4cDGh3NATvctZZjcwGs1Yp2mUG?=
 =?us-ascii?Q?L7HATjdFkHBp6ukxY0dF+VeBgo3BTm9QPVBOsnnAMRtYuoRuj2UZ56VOaaIb?=
 =?us-ascii?Q?LKTu9+QY3iYZRxR0SklvdUGPrRaQMKjzKQPtKIqLNRZZlGNl/CYg0C+kRFXk?=
 =?us-ascii?Q?eT/itcyuBu/NH75YBDxrCCx3IqNI7cv/NChp/8Cyiq5pnOyUq1+tu5wcMBpz?=
 =?us-ascii?Q?pJ0HI/SNyKLVTeNj3UrG70APLtHxEDy4bgqdUYRvmFNjYLuNg/j7DXoxmXBj?=
 =?us-ascii?Q?Qr6uMKavUg2fWpCIgp4feXNML/mhjcaeKmbMzhmAFvgYsqbzNv42CMmXno4E?=
 =?us-ascii?Q?w0Ubz6lNgxMBDluMVrs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d7755-f19e-4e5e-22ea-08dd45933747
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:34.7711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4T0bjDc8GJkbwEatrxC3WET/SVi05BeRZ+X0pQxBo2WK+z5AGTay/tjOumq3Da4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

Hi all,

This patchset adds a new buddy allocator like (or non-uniform) large folio
split to reduce the total number of after-split folios, the amount of memory
needed for multi-index xarray split, and keep more large folios after a split.
It is on top of mm-everything-2025-02-01-05-58. It is ready to be merged.

Instead of duplicating existing split_huge_page*() code, __folio_split()
is introduced as the shared backend code for both
split_huge_page_to_list_to_order() and folio_split(). __folio_split()
can support both uniform split and buddy allocator like (or non-uniform) split.
All existing split_huge_page*() users can be gradually converted to use
folio_split() if possible. In this patchset, I converted
truncate_inode_partial_folio() to use folio_split().

xfstests quick group passed for both tmpfs and xfs.


Changelog
===
From V5[7]:
1. Split shmem to any lower order patches are in mm tree, so dropped
   from this series.
2. Rename split_folio_at() to try_folio_split() to clarify that
   non-uniform split will not be used if it is not supported.

From V4[6]:
1. Enabled shmem support in both uniform and buddy allocator like split
   and added selftests for it.
2. Added functions to check if uniform split and buddy allocator like
   split are supported for the given folio and order.
3. Made truncate fall back to uniform split if buddy allocator split is
   not supported (CONFIG_READ_ONLY_THP_FOR_FS and FS without large folio).
4. Added the missing folio_clear_has_hwpoisoned() to
   __split_unmapped_folio().

From V3[5]:
1. Used xas_split_alloc(GFP_NOWAIT) instead of xas_nomem(), since extra
   operations inside xas_split_alloc() are needed for correctness.
2. Enabled folio_split() for shmem and no issue was found with xfstests
   quick test group.
3. Split both ends of a truncate range in truncate_inode_partial_folio()
   to avoid wasting memory in shmem truncate (per David Hildenbrand).
4. Removed page_in_folio_offset() since page_folio() does the same
   thing.
5. Finished truncate related tests from xfstests quick test group on XFS and
   tmpfs without issues.
6. Disabled buddy allocator like split on CONFIG_READ_ONLY_THP_FOR_FS
   and FS without large folio. This check was missed in the prior
   versions.

From V2[3]:
1. Incorporated all the feedback from Kirill[4].
2. Used GFP_NOWAIT for xas_nomem().
3. Tested the code path when xas_nomem() fails.
4. Added selftests for folio_split().
5. Fixed no THP config build error.

From V1[2]:
1. Split the original patch 1 into multiple ones for easy review (per
   Kirill).
2. Added xas_destroy() to avoid memory leak.
3. Fixed nr_dropped not used error (per kernel test robot).
4. Added proper error handling when xas_nomem() fails to allocate memory
   for xas_split() during buddy allocator like split.

From RFC[1]:
1. Merged backend code of split_huge_page_to_list_to_order() and
   folio_split(). The same code is used for both uniform split and buddy
   allocator like split.
2. Use xas_nomem() instead of xas_split_alloc() for folio_split().
3. folio_split() now leaves the first after-split folio unlocked,
   instead of the one containing the given page, since
   the caller of truncate_inode_partial_folio() locks and unlocks the
   first folio.
4. Extended split_huge_page debugfs to use folio_split().
5. Added truncate_inode_partial_folio() as first user of folio_split().


Design
===

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

The split process is similar to existing approach:
1. Unmap all page mappings (split PMD mappings if exist);
2. Split meta data like memcg, page owner, page alloc tag;
3. Copy meta data in struct folio to sub pages, but instead of spliting
   the whole folio into multiple smaller ones with the same order in a
   shot, this approach splits the folio iteratively. Taking the example
   above, this approach first splits the original order-9 into two order-8,
   then splits left part of order-8 to two order-7 and so on;
4. Post-process split folios, like write mapping->i_pages for pagecache,
   adjust folio refcounts, add split folios to corresponding list;
5. Remap split folios
6. Unlock split folios.


__split_unmapped_folio() and __split_folio_to_order() replace
__split_huge_page() and __split_huge_page_tail() respectively.
__split_unmapped_folio() uses different approaches to perform
uniform split and buddy allocator like split:
1. uniform split: one single call to __split_folio_to_order() is used to
   uniformly split the given folio. All resulting folios are put back to
   the list after split. The folio containing the given page is left to
   caller to unlock and others are unlocked.

2. buddy allocator like (or non-uniform) split: (old_order - new_order) calls
   to __split_folio_to_order() are used to split the given folio at order N to
   order N-1. After each call, the target folio is changed to the one
   containing the page, which is given as a folio_split() parameter.
   After each call, folios not containing the page are put back to the list.
   The folio containing the page is put back to the list when its order
   is new_order. All folios are unlocked except the first folio, which
   is left to caller to unlock.


Patch Overview
===
1. Patch 1 added __split_unmapped_folio() and __split_folio_to_order() to
   prepare for moving to new backend split code.

2. Patch 2 moved common code in split_huge_page_to_list_to_order() to
   __folio_split().

3. Patch 3 added new folio_split() and made
   split_huge_page_to_list_to_order() share the new
   __split_unmapped_folio() with folio_split().

4. Patch 4 removed no longer used __split_huge_page() and
   __split_huge_page_tail().

5. Patch 5 added a new in_folio_offset to split_huge_page debugfs for
   folio_split() test.

6. Patch 6 used try_folio_split() for truncate operation.

7. Patch 7 added folio_split() tests.


Any comments and/or suggestions are welcome. Thanks.

[1] https://lore.kernel.org/linux-mm/20241008223748.555845-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20241028180932.1319265-1-ziy@nvidia.com/
[3] https://lore.kernel.org/linux-mm/20241101150357.1752726-1-ziy@nvidia.com/
[4] https://lore.kernel.org/linux-mm/e6ppwz5t4p4kvir6eqzoto4y5fmdjdxdyvxvtw43ncly4l4ogr@7ruqsay6i2h2/
[5] https://lore.kernel.org/linux-mm/20241205001839.2582020-1-ziy@nvidia.com/
[6] https://lore.kernel.org/linux-mm/20250106165513.104899-1-ziy@nvidia.com/
[7] https://lore.kernel.org/linux-mm/20250116211042.741543-1-ziy@nvidia.com/


Zi Yan (7):
  mm/huge_memory: add two new (not yet used) functions for folio_split()
  mm/huge_memory: move folio split common code to __folio_split()
  mm/huge_memory: add buddy allocator like folio_split()
  mm/huge_memory: remove the old, unused __split_huge_page()
  mm/huge_memory: add folio_split() to debugfs testing interface.
  mm/truncate: use buddy allocator like folio split for truncate
    operation.
  selftests/mm: add tests for folio_split(), buddy allocator like split.

 include/linux/huge_mm.h                       |  36 +
 mm/huge_memory.c                              | 749 ++++++++++++------
 mm/truncate.c                                 |  31 +-
 .../selftests/mm/split_huge_page_test.c       |  34 +-
 4 files changed, 582 insertions(+), 268 deletions(-)

-- 
2.47.2


