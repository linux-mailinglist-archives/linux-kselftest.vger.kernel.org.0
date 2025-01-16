Return-Path: <linux-kselftest+bounces-24684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A37FAA143D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D707A7A145F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6CD2442CD;
	Thu, 16 Jan 2025 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TbPjbINV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E5243870;
	Thu, 16 Jan 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061872; cv=fail; b=XGTqbEI5C7+9r6Tr3oN8nySj8bzGysWXhK+U5QAKcFhGIJwc/8ZRuZTboc0mQVeNgccZAjK2Kifi5da3IYSNBuu5THNPF7w44ClBDwSd2wH7//J7bktQsnXWuN2po5wHeLFAKIdwGSv5WWnzo2gMgfi60hI0EYEbQxBKbAaJFvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061872; c=relaxed/simple;
	bh=z4BEJqjZQvhJk0Tk2kAY9Zs3C7Y5eyNsv/ji1H0CeUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuZ8rrLG+idbn4U0G15CsuExeQJuUD7Yhqe7luiwHk9Hg+XtioTEEIhsvD7b0wKKVA+kP5ZmsTFJ7Rle1HltSXEpmaM8Vj3ZzFbYD2c3bSDuf7txgzlQNKAWHoymWWGWOGtB3yD5QA9vY1dAcgegl0QPPR3cdoxz7c/+8aeJgZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TbPjbINV; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvq98UVtYpJaRAUzrtb1kMwVA8DDp/iHBzX0GZsQ5l/NoVM4HLlKZeMWbpU1SbOZRLrBd15yVIRxl9JITcRzVvTuCDZYf+wuTqn4XZw8OUfE4Ni9K6sKTDxt97c4PhA3Dxo9k5FPzSetzuXWovuEFmUv6ANtV85wiDT5s3BzkARo4UhPhSa61MaY/Y9aHSNGyieakU+CjSWoAbLnTCGFVbq3y0zJvViXEInmttKkwjBOkPBnCiSU3LS8A6SCWW4ed1+zutiv5zFbprfbRWVN+nyNtJALMIU0WW2F82qdss2jKMj+8wueB/e72WtZMjzktOG7FijiEA8hbmnX4NxZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h01OhGP49lQnm769uOiJuw7L8Wzui4j6wehMLlbisoE=;
 b=H20IKBnl9klOvFZDz9AN5O08ym2DvMlVVMhJiB/w14/yTVg2G5aIudsAxvSLSJ4FKKaP0nCbRMB3RB6CnR/nzNP1XFmN34OicQ9b5qPzGPj/TKLzMe77pJV200j3VJE25+S0qCiJi8Yo395VUEk7x4N4qeDTLWFNYXU7SeSUAjf8kjteHvGlrIcpjIgfgSEOrlLdPeWzpdG4lR0lDkFxDkhJzg1/LpjuaBtrfWCdCUOv+lpdREDY+NAl3zbpM/0YPCouV2AJ74TqvKXr73FymqJfyeY3ke0222GOC1iePL7fMgvpdMnZ3bP0BLyk/JXTQQv+dmTshyGoJeJB4rmRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h01OhGP49lQnm769uOiJuw7L8Wzui4j6wehMLlbisoE=;
 b=TbPjbINV9rOQcTfwXBtgHX10TDxVpjDksG9hWRZVXTmqk/2cpBEVUpd04N6CMnzvJHh6lxQ4g6JGtPUpLvifdtudB4+en/jkettXrnzuNfnKcpN0lKOrulsP5zlqIGcPolyyo094/VNlI22MuXi4nnY2PiNQhvQnOqLsaFk04EmpWWyTeuvI02fgnvQdNov69g1AGBe/ZkXCUGjIsG+kT4dz0PFq77uJ8gJ+anGY0iCTNpQPZjqHgLAmXYl9IIfK9AjPc2mvVRBM10dn+zB2rx6pQRBASUwI1ylqAvNDwSGS9pESZ8scCrA5QaugZ9FZSYmHxVrv0GY4TRGwY+OhFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:11:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:11:03 +0000
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
Subject: [PATCH v5 08/10] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Thu, 16 Jan 2025 16:10:40 -0500
Message-ID: <20250116211042.741543-9-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 755fba17-0045-4fd5-ea6c-08dd3672488f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcO3ixMNRM75MPDvE40o2lCnuFSMYL+EUCsif9Y1qsGYu18eME+JhcY3ht6Q?=
 =?us-ascii?Q?Yaa1Nc7rkmKgiGMtPtsYzqAOnwBN/mCL73aRSODE/isL+acULyRvGU1j1mGL?=
 =?us-ascii?Q?nlW1t3bDP5wFm3u0/zso39JAN8OmB2EJPfz4lz4djf80VaSshzPzvM2Kh/e1?=
 =?us-ascii?Q?oPIIcLcteyLCQADGsvDNAJLxFscYUo76RKo+pKeVjGDh4/LKfw60L56vz6Je?=
 =?us-ascii?Q?cGO5RLKyMdI5xJ+tkl9952D38fnJep+yjXZvWhPGOOf5bxhQ7CSzvxHBnL+k?=
 =?us-ascii?Q?PC6Gmg0P8Yi0tDh53pwU5pgihuosA4cX/aB9uFDrc2DrFVe0Y/5QTvgMzJs3?=
 =?us-ascii?Q?YB6CduSe33tFKghHvHpgrhBg3+khJ4WWpZeqr1YXP8wAdF0XQ3FuWCs1tra5?=
 =?us-ascii?Q?eh0YhTZPaYAOpo7aaGoFLKwLzbDZ/7tYzzTQGco4Z8VJ6eGFaXmkiRBBr/Oo?=
 =?us-ascii?Q?41TuiAAYyBw0LTC4YLNvpmzNZkjBQV1pqR8QABgRzazPVgZnPJlS3wGAC6fo?=
 =?us-ascii?Q?0Q7sKeXpcP9vuPYb0Jdn6zT5aqJXdbqj0vTD2r3NOIFGeJT9UjApQWLs7kU5?=
 =?us-ascii?Q?QhfHww63a4SabJHsPnhpGcdX7ISw6pp2QeAFDJ/Nj+CJDM6J52CfUzwcyLlS?=
 =?us-ascii?Q?+a8dTiv2Edhz4oePpwJvxFvKpSk+aJxVqLHCAZZg3yogrp0v5T4D/I+rxC+s?=
 =?us-ascii?Q?uxdQYSFnTw7cIKYm72gKNYByGmXSqEsNEM610lf+ZGb2fOd7w40Ka9yzlgXt?=
 =?us-ascii?Q?tAuu+8YfNSiZLfPe9WuUuCPgA1abAxncG4yBcFxqQwOikBiIL6PO7+Fzanuj?=
 =?us-ascii?Q?XdnoZTOT5kuNplKU/sYgDzj/L/93UckIs8bJtOMV5N534Ylmzk3C1MmS88+3?=
 =?us-ascii?Q?NpEAXKO4xWiuYK97cpdPSed8QWQ4+7q6Q0f32YK3X1lpu3Rd/fFqec3m4kfG?=
 =?us-ascii?Q?lBKASMTlmGv9V7nfN5MVMTizJHQIWA96rDs8g7N7hpeklskk93NPym8MYMe5?=
 =?us-ascii?Q?4jkSFjq1O5FEtQVMIuBNFrgiliOAgb7rw2QjyeIBTWd8NJ0rAVL6wZevucw2?=
 =?us-ascii?Q?cCDtU4EIv8x/OEOXvqzt9x4OVd4umVEz9K0PyU7b19QbEb/CwEr/SSYAc8ke?=
 =?us-ascii?Q?/OZSU7R7Hj54/pIdm3Gm/qymPWh5HvGlPKe6cuZ96cuk2ZMvEUaOlvO8vY3Z?=
 =?us-ascii?Q?S+UdRIhyFCsMSxdSduRTi04ZgrI/8wNQsbnOYWbQ4MrJooSmIDITpn0so4U7?=
 =?us-ascii?Q?xNPD1Shgp7OrlATxFthUXoM6N5TJUgL0Udxlxa0hHvATaSxY7k/qzXp6IFld?=
 =?us-ascii?Q?JFnEuAq7jvbNi3Lk2Rlr0KouiPLmZ2ONLG27P34yuv8pqUWQoLQQjq/g5biE?=
 =?us-ascii?Q?x6mYb4Bkv1ib843kwMNNvxto8bDB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ty1uiS/pYo92UUx0gsdBNfg+/NU05IIRLoVbVJS4lTDFIS23PlVMpxq7kiOE?=
 =?us-ascii?Q?NCSxYAOLaknzSqYKhBJKNDHp8ggUCRcmIjVT7n03ywwhzcaaLYMf0AqVx5/G?=
 =?us-ascii?Q?kLz3OjKaW+BNxZpZUuYhrBRlFQU0OB7yCl6HrUKj9H2lyR/0VAIk9Rg80NeF?=
 =?us-ascii?Q?fh+K5xFblnrejpirrAyjApDQ1yq4WhJGligCFM2AWJAAtCLpLaYP0HsqIe1x?=
 =?us-ascii?Q?tDp+ly014ZRuJnVENT5XV/4D92sOxYf1GiyVjrhQkSg9QS+FzoYiQfaMuFqB?=
 =?us-ascii?Q?O+Kc97PflGYAGL+qlCv17ZI3Cx2vCn1HECfM9oa4zYPIbzol/gTkppXPcbwm?=
 =?us-ascii?Q?SsnH88v0wlJq7n3bMJ08E9WQ/7aF3GGTgOw67Y0AeqBX6eWQY6t1JNjf2E7z?=
 =?us-ascii?Q?AXrn7T2MwD80pomxLOW+bxC26BFWxBAonzC9FjzzhyDiETVCZMWnaDaPlXmz?=
 =?us-ascii?Q?2ix/BBIogQGCVvozX7lextCaMAiZqY/WHR+ixPahAXYHHW1YzAfqmZA/M6aM?=
 =?us-ascii?Q?/SXyaszp43Stqig3srDsXckE+F1CRzBoaOFD9IA/pgPtw5lT+jMRkV7AnrIz?=
 =?us-ascii?Q?kHvKttQFIEUrBSs9goBfxYw1v2gHCpoYBTsnjgZqXeFhwFzqawIx6gYU9Xej?=
 =?us-ascii?Q?dfVKGkk3rISMygIYx7pVlJ0wsOve6z3eN6CLUqu+MBt4NhOmYtp3IrFWt/KU?=
 =?us-ascii?Q?A51IhIgRsi5kKkbZDt2IPxmv9L4KpQnrfLX+489CwuxdfirhZWVynBFuZk+u?=
 =?us-ascii?Q?VnXhg3Bxz/X0upIevlfDgCt+f4FevFkvwiMhBPDcFXpnIVZbKJ8uQqMw6ZB5?=
 =?us-ascii?Q?+hWsbOtccE8m6U3ZWqSg6nGEuJ6wdG2xo7TJt81kM0m7RGwvSpyEuN8YrcoK?=
 =?us-ascii?Q?1UtaXht9/Lp1UuL/7NJf7iOwO4zR9Zaz6j6in0eq3DhJtnOFuzq9s3mRII7o?=
 =?us-ascii?Q?qurRwRC+2pJdUk9et/e5fPgYqn4fTPPqwokqcsBG+/sOq4XFguw4OJPMh3yM?=
 =?us-ascii?Q?bEH3Ct/2pEgvWuKWtN8vW5xXbFo8EJn5WcBHDZnuhT+E01icG9oIpcUwX1Ju?=
 =?us-ascii?Q?jtqlJLW66blsqAqF4Wkmksfb/yAjatLi1tOI3y2zF9MqEO7C6XuU4xLt6T89?=
 =?us-ascii?Q?NnXCEv3vs113Tp4q24uWOc4XfptUrSUP3kxXSJmVlGo1Dex6vmVngBxoOsZK?=
 =?us-ascii?Q?O4HWa3esgLIV8X+s/i4gO6nhkPgo3s0fWZKAjE5IVI0dKIJk+DwvgKNsjCq/?=
 =?us-ascii?Q?qiC2UkQa20rcrKbLp9SE3swb3dJo430UqDsZKJLMsQUci+mH6sWR2DDjbUMX?=
 =?us-ascii?Q?HjFtFUMZVmbYn5n6Zk04OmNn0ZOjZl54LBWyVyeet9OTna3znRTjGIt2EkIX?=
 =?us-ascii?Q?MXqrQ6JUvUu/x6K6LqEhAfzNoCRXclShyottl1HpFBFK9BZ1Szj1LCvrC9IM?=
 =?us-ascii?Q?dtGzxNsMyKPB3eSm3J2F1a5Ljjc9JFsZYiNBayo/iHcUXkPkmP1D/4g0Od7t?=
 =?us-ascii?Q?pwnSAZGClJqGHd/g5UU19LNbwwYnx1+zfdsdZDt5x9JEL3bHuWQYwRl7ZOmS?=
 =?us-ascii?Q?4joYh77LuKPJUGB7rX9xj7ZXxw3UBpDngOtdNMST?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 755fba17-0045-4fd5-ea6c-08dd3672488f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:11:02.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZBE+N9JfeNqM3Meio58wx+0mWTBWw7tJDWMZeLwqxe9Gay6SQcNKJffVnCGol2o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 47 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fead9586e34..ddba3e36b46b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4177,7 +4177,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4261,8 +4262,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4285,7 +4294,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4334,8 +4344,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4368,6 +4385,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4396,30 +4414,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d", &off_start,
-			    &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(tok_buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.45.2


