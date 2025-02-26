Return-Path: <linux-kselftest+bounces-27666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF63A46CEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 22:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A01188756A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529425EFB8;
	Wed, 26 Feb 2025 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BX1XHPOc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120225E45A;
	Wed, 26 Feb 2025 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603666; cv=fail; b=hB4de8AmK1PsE/GuaVUTGktoN7Mz62GkCxIotP0ltKu4R6CfeMUR63scwLIGlg9+aXFA+UGYKlzinglBbmhtX3Ucot+kiuVSqjR0ayHoEGVEwcfOdG1lT5ZW1109CRry6QvG1YALU+M9Lt7XrMIhnBCHdivUQF1R1vCyDKUG+ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603666; c=relaxed/simple;
	bh=ePKHPNd/12/QDBb2J7DYmLXztnyGngBeXOUF1oT+6a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pssDdj124R8+tG4UIYlqm34bzm8uqEjFASRC6cyIWj1DqB5y+rAP3v2wuhML1JMf2TPuNgZ6vgRspawq9KmOWqt9A1aDPydIMrwfBIRYFw+Go4IOERx4SAyFtk0pOkLS96LSW1D4M14IqB8/fdLrZOXLsLQd8t1Eam/5kakY7u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BX1XHPOc; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rk4DpLRL1yN4ZN1bVo3NObDAj5zE9OkJccYZUeVRmTnoz7LgZ8MokMgCjGHIuhG8QYXftcxyxRci8RxF4HrR6tJ6OZNfQ30SlaHbI0fOxe/nEHflkUnjYBTiOur/IYoncLNDqEvS5st2jUsyVpkGTbanE5fvxQDebLRUur0x6N9482vGiZ01M/wWUl67KNHrPs2fR45chDfY3N36d8LucJz/9wZVu5kjzG4ju3g6ZNwufvC+OTmdlYIFP0VKy/cAkqbPAuJiOOdAl1xuIXaSD5QylcbV0l/5+Lv78hx+YxAXKEZTdo9RbOvrD1QOBWRvFygZSDxiXTVsg3M5rDpUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUKzKxCp18RebI50HRcVVot1Kh1u8K/QFu7z4xJIdFw=;
 b=smB6biVbcqjM/+XKqDux8SaVTxBig7GaA5pjxccUr2g9dswsn1S7QQ+ZitDPQDvhimrns3XVp+T4ew2St/VUu1J7wyDPwN2fM6a3txlCsIkb2V4vKxOz0RTttkdy6miTB0ThWJA/EJanbbEdMB9XUjMoDoLbLso3Q3/nf8y3uLFlM2jC9NoKcq13f0pDriiNJ2R4lI3N+8fSqYw/cd/SUBfjUtUfoZddU1LrU2CNScDLr7IGmI732aHruQoAnKK/flGtJR96ZiU4zVmYwvn4Z6u2BuAznukxDu6lggoiWlNnOxtKgseR5mSbBm9jWnZmUNrN0dYQMrr/PdWQs9uEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUKzKxCp18RebI50HRcVVot1Kh1u8K/QFu7z4xJIdFw=;
 b=BX1XHPOcxJvcPh/BULYh3UNq7Nvyk7plK/xnM7SL7pQ+2sJ5g+IWE2OCBiG84IcdlCyd0kWdBMxhTl9/kNe1G6MEIJ6F8Ogvrt5vb2hmDvHc5pCUnEofoD667oAEiaopfMkcRl5WffqyQsf3RPn4fpF7F/ouyDis+yC3CYpDDCS0z+BV/o3hWkBghuoPdw41R1PViHCC+J6RrsjmUncTLoKKRezBS9dbTQRF/gPPAyEmORwun6Eobt8q9no+yOHE8vK7pdR9+0ITBCZoya97u6jpjqu83giqjpCSAQCbPDvxWna//wMKsXBXyaMbxEUBmuB8SwfUT1TnvltFQKXGkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Wed, 26 Feb 2025 21:00:50 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 21:00:49 +0000
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
	Zi Yan <ziy@nvidia.com>,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v9 7/8] mm/truncate: use buddy allocator like folio split for truncate operation
Date: Wed, 26 Feb 2025 16:00:30 -0500
Message-ID: <20250226210032.2044041-8-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250226210032.2044041-1-ziy@nvidia.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA1PR12MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d80e5b-333a-40a7-67d7-08dd56a8a5ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56v4tAawdl7CSnrQzTvBlhzKhbu26f366tq3VEh1kuBWoQNYlekzBJAx3dTs?=
 =?us-ascii?Q?b/epmXPN78tnOGvWEYy/3303u07L2RZnR4ltodHCDF5SEvA9ibCMh8vRgb8u?=
 =?us-ascii?Q?+fNVhvAdVMVBS3kUA9LtdwUpW9v/DiMB+TUMoJfZKil5eP3dykXbyQFhLedb?=
 =?us-ascii?Q?0dMmNKDF1rc0uG/uZ3M6Ul25039a3EjaFqlhOm8HknwBv3RxPsfgwvuGEjpx?=
 =?us-ascii?Q?ln5dB2Jr/eL6Q8b2eZ/fC8MqTrOp0juUwYZtjWDh5iAotvIiVD/94BdJPbDp?=
 =?us-ascii?Q?BFNPNdSKb2DfySkVz2ZB710DOEsn4xkiwBBbpwolpcJtU44tAqWyaLdcQzfK?=
 =?us-ascii?Q?tE3BWeyq/WPb4pN0bPQdQ8DRwQlT0tu0TA48x4kQDStCrAq5sETvavWWfyoH?=
 =?us-ascii?Q?G8NWaf7bfMV1QStzg+uTTY0mZhFQpzGzSeU/fy12aZVG/9ywDaTPfKhruv0f?=
 =?us-ascii?Q?XCtzZX6trzQ+owOnJEU/lHknSgvDACnnuMcoMNw2PF/7NgNiwpnTH/Vgx4yY?=
 =?us-ascii?Q?8351H6qemo+PsbXJzNE7wjq5hm9SEyL3wyDdj54AVXWC2fP9oARbwca5Lx8e?=
 =?us-ascii?Q?Mvrd2RH03t5oq9m3lthaL6ny+Gc5KqDkqL+9/taWET7/iEf1Yo61sPPUQgQU?=
 =?us-ascii?Q?64BmoOYhg+qH+3RGIYe7xxxy/Px4PMOyS4TlFR8ljZRl78I3/7HsQB9XV7/L?=
 =?us-ascii?Q?kH4NJQoSCV1rqrFv+9QuI0xiyjfjFwVzMe8axOmX5oTPBF4NJ3+gMCoXpxds?=
 =?us-ascii?Q?mieqYRb36I/4Xuvk2HjpnB48xDQqbl19TeWXNHLttQBSpqWJv26xJvJCKTRP?=
 =?us-ascii?Q?Yj+MewTBY5XMsMR3mXesUdnKdueJZ5sIK0BVE6FZsL63IYdMTF8JChXC5aeh?=
 =?us-ascii?Q?UFoiJAHwvM+JpTD8PnYyKqE1CLe9+hnbUlCW+Y4z5Jv7A5adLdAq/wTZi52C?=
 =?us-ascii?Q?ruqh9ODB1aX1K8OO22QQfFBowAimKcxrpzXm/wEhrRUkh7T4ZwGit8Iq/sMh?=
 =?us-ascii?Q?O7KkrAMFSldIDutcmRAoAqn+917G9WaF9FB8va8tXYoif/fic1PSZH+ZxnUg?=
 =?us-ascii?Q?4K/qxNobiPjufh4nbGXViJIyGdRK4XDwWcoNOEl5TCULGgFfc4Ykz1tUk0xK?=
 =?us-ascii?Q?2WN0BPWRHZwpwOQtqhRYmrPttQpgxNldMOjgEJWF2uiel8lefjts3rTl1xZO?=
 =?us-ascii?Q?OB1vWcakLl1UWLhLOOZkiI8Rhru19YFqcC/x1q73BYSQ5GR9xaUhueurJZmN?=
 =?us-ascii?Q?voGEY7O9TAwQCe9KmYBaACRKwTtAB4SksQG0KhXCSkBhz8DsX4Lddind4r86?=
 =?us-ascii?Q?sMS0JyB5ueOseD9zaKrg01K7nRYpgyGtHokiO1GjsMVEmvvTg5FqTJrl9egN?=
 =?us-ascii?Q?u4IvZz1C6VK/+C/NDRMzeEUnKehd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGSf0MM3p7XGXE+974Au8iGhXGjNzd/I/z6ZAW8udS8KQgl7ANmZpwXgFbDf?=
 =?us-ascii?Q?heFSrOz6PCtfAq8xwPEAqUlxc+TS76SA4PBtJpdbuwIIAEtC1H5wddSCqB6D?=
 =?us-ascii?Q?ghFnIinLr6VnbfE1qFIG6grhj3eCox81p8EF9CtmE/D/a/APvRJ8A0bcc7bl?=
 =?us-ascii?Q?P6NjoAeG0c+Tr6LPmaVatBMbzXo1DzlhiclrslhLnKiOLhebCvdnsiY5oPun?=
 =?us-ascii?Q?YdRdZycSR+T0XGdorP9tITLuKuIJUzlU0swG2ml8LntNYluTSLL359rxIU1u?=
 =?us-ascii?Q?oRWFRZ0sOp/3Xx2ohJzevQXLnXHMI5sWgsdfRze+7PSmm6Zh+P7cU11jd9Jj?=
 =?us-ascii?Q?6NSsmHh8pLGkOJ1oRCyRbbJZEx4jJnkryvF4sNqGJ/tZjZYbWTIz8aWwgev6?=
 =?us-ascii?Q?JkOvRdZVDB037u55H3uqDK2AO7k5Ue+Xr8qKumqwgxkXkFzM5Q1X9kLlAZRW?=
 =?us-ascii?Q?qHCDEJvWIVjlxwn2ZL7LrlyxXncEB1myzmw1EfBLPjJI8TbddKRyOipz/uby?=
 =?us-ascii?Q?14eHhxCYip4C3FumuO7ED3VrqsJihDTSSg51AbZyMSQRu23QNoKQVLLxW+Kp?=
 =?us-ascii?Q?cH4Du8ABfTkivCbWS6k/Q6zi1v2jXDN/6srDvjyiibGHlbgJk6AroGctca8a?=
 =?us-ascii?Q?erZzGMpmp1R/8yRb2zbnZqstIAz7mqgGN9JBLbTOZc/pSlHtHV+6mS7sDj8K?=
 =?us-ascii?Q?MzecwvWYxfRoYR7s4wIcYTDthNiwA8/+ppai3NUs5bhlp3OhO5IKsZMMK5yQ?=
 =?us-ascii?Q?1TlyEE0jtUWt2V/+DGomfiLQdY9A/DfTSE9jlm/HMewJiwFHlvPgMOPFyliR?=
 =?us-ascii?Q?KSf7L+384NdB/8xojPsZIsKYrBdFYcomHtjFma7eymhrm/G0akwi2zqRgNIL?=
 =?us-ascii?Q?6oOWrS1do5iNkLDaN54q5ZNkwloWfyyAYFd0p52Jsd/anX7q3RR0C7Hh63ZT?=
 =?us-ascii?Q?I6hYy4Wvj5KJ/aXjMaRJaMNgf5QamvEeAwviEt3faN9TOPThi+eoYsuoaHM7?=
 =?us-ascii?Q?Z2UVMh8caZpK3wCHYHwcJtjexn3bNZTRqThFmVq96lBmztw3dblET1+S8c/v?=
 =?us-ascii?Q?1gPPChp2CZKDYt/0vfbYBXoapo8wgctE6t8Gi1pHJoHyy/eUlE9fy0II9FU9?=
 =?us-ascii?Q?riVe0gmj8QcotOQUIUV2dCuZ/d9BRkiviLOYaLwzL+EW33IWdUJ98xPCHKOl?=
 =?us-ascii?Q?X545OHOvMab0rPklA1rBJujA7V/z8k5XzjPz/81o9HXC2Yz7q8VDQZF/+VGl?=
 =?us-ascii?Q?e9KE9VazS8sqVPTwQr5bCbubEq8Fx58ZlLiS8epuo+fydmEsysk8GdLma1kR?=
 =?us-ascii?Q?2RSeHmTDtGWvZdQA5+EB+VzvJiG6oz/WG7EE8JqEHBKUTW53if+HuJTYJSwT?=
 =?us-ascii?Q?+yUph3F3qQNrY+mkKxurtJRpOi8c5WOuCt9hYJf+cFgm8HroizSXM+2/+1eO?=
 =?us-ascii?Q?CLSx9AEAqPF/UuEzpjNZCVfr+rCrexkr91EoNE+lXOQ3HbaGkYv/+ZURPSIB?=
 =?us-ascii?Q?wuzGCj6D/HqYCPrw/LJYfkOnqcz2HdpGVBw/ge0sj2CGSpNDC5capwzy3qGX?=
 =?us-ascii?Q?b9yhOcg1SnN0VNQxt/W4pbSztZ1SIq3CWdnGI1XV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d80e5b-333a-40a7-67d7-08dd56a8a5ea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 21:00:49.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmjg+yIW+UVgf6vtGlc7nrqmHEL94eKwE7WtD+BrWTbkTgMS31yRHRh59vtQG0v6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5614

Instead of splitting the large folio uniformly during truncation, try to
use buddy allocator like split at the start of truncation range to
minimize the number of resulting folios if it is supported.
try_folio_split() is introduced to use folio_split() if supported and fall
back to uniform split otherwise.

For example, to truncate a order-4 folio
[0, 1, 2, 3, 4, 5, ..., 15]
between [3, 10] (inclusive), folio_split() splits the folio to
[0,1], [2], [3], [4..7], [8..15] and [3], [4..7] can be dropped and
[8..15] is kept with zeros in [8..10], then another folio_split() is
done at 10, so [8..10] can be dropped.

One possible optimization is to make folio_split() to split a folio based
on a given range, like [3..10] above.  But that complicates folio_split(),
so it will be investigated when necessary.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
---
 include/linux/huge_mm.h | 36 ++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        |  6 +++---
 mm/truncate.c           | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e57e811cfd3c..e893d546a49f 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -345,6 +345,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		unsigned int new_order);
 int min_order_for_split(struct folio *folio);
 int split_folio_to_list(struct folio *folio, struct list_head *list);
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns);
+int folio_split(struct folio *folio, unsigned int new_order, struct page *page,
+		struct list_head *list);
+/*
+ * try_folio_split - try to split a @folio at @page using non uniform split.
+ * @folio: folio to be split
+ * @page: split to order-0 at the given page
+ * @list: store the after-split folios
+ *
+ * Try to split a @folio at @page using non uniform split to order-0, if
+ * non uniform split is not supported, fall back to uniform split.
+ *
+ * Return: 0: split is successful, otherwise split failed.
+ */
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	int ret = min_order_for_split(folio);
+
+	if (ret < 0)
+		return ret;
+
+	if (!non_uniform_split_supported(folio, 0, false))
+		return split_huge_page_to_list_to_order(&folio->page, list,
+				ret);
+	return folio_split(folio, ret, page, list);
+}
 static inline int split_huge_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
@@ -537,6 +567,12 @@ static inline int split_folio_to_list(struct folio *folio, struct list_head *lis
 	return 0;
 }
 
+static inline int try_folio_split(struct folio *folio, struct page *page,
+		struct list_head *list)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6298be12e843..6ac6d468af0d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3640,7 +3640,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3672,7 +3672,7 @@ static bool non_uniform_split_supported(struct folio *folio, unsigned int new_or
 }
 
 /* See comments in non_uniform_split_supported() */
-static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+bool uniform_split_supported(struct folio *folio, unsigned int new_order,
 		bool warns)
 {
 	if (folio_test_anon(folio)) {
@@ -3986,7 +3986,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
  *
  * After split, folio is left locked for caller.
  */
-static int folio_split(struct folio *folio, unsigned int new_order,
+int folio_split(struct folio *folio, unsigned int new_order,
 		struct page *split_at, struct list_head *list)
 {
 	return __folio_split(folio, new_order, split_at, &folio->page, list,
diff --git a/mm/truncate.c b/mm/truncate.c
index 0395e578d946..031d0be19f42 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -192,6 +192,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 {
 	loff_t pos = folio_pos(folio);
 	unsigned int offset, length;
+	struct page *split_at, *split_at2;
 
 	if (pos < start)
 		offset = start - pos;
@@ -221,8 +222,36 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) == 0)
+
+	split_at = folio_page(folio, PAGE_ALIGN_DOWN(offset) / PAGE_SIZE);
+	split_at2 = folio_page(folio,
+			PAGE_ALIGN_DOWN(offset + length) / PAGE_SIZE);
+
+	if (!try_folio_split(folio, split_at, NULL)) {
+		/*
+		 * try to split at offset + length to make sure folios within
+		 * the range can be dropped, especially to avoid memory waste
+		 * for shmem truncate
+		 */
+		struct folio *folio2 = page_folio(split_at2);
+
+		if (!folio_try_get(folio2))
+			goto no_split;
+
+		if (!folio_test_large(folio2))
+			goto out;
+
+		if (!folio_trylock(folio2))
+			goto out;
+
+		/* split result does not matter here */
+		try_folio_split(folio2, split_at2, NULL);
+		folio_unlock(folio2);
+out:
+		folio_put(folio2);
+no_split:
 		return true;
+	}
 	if (folio_test_dirty(folio))
 		return false;
 	truncate_inode_folio(folio->mapping, folio);
-- 
2.47.2


