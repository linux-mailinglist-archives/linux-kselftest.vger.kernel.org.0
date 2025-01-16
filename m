Return-Path: <linux-kselftest+bounces-24678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCE6A143C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 22:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB63A00B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00EC232364;
	Thu, 16 Jan 2025 21:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnyfl1v0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C91D61AC;
	Thu, 16 Jan 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061860; cv=fail; b=Kz1sukwC25jLORzMkNuYYqJgbyKYf+ZdHwCHK3FwfphvCXiFRe/13j3xOt2kC9Gr7KJ9ubbMQ7oowhVdpovLooMm0h2GEWFDl1HJnmQXAJeH6xa0gV+c+g+7KznlSZS0EOX04RQT1+DowpzZc2eL6sZxAe8k1czot597Y68Mkrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061860; c=relaxed/simple;
	bh=ohiCuA3Py0JetU8gAtYQOiTzAMsNBy9/ujazVI/GD/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxcbvi5MSmPNYkYi3UxrWWFkYg31tENiW4OL+q3AtviXNSVNAUerASpg6hZbfF00+FiB3QR9xl24Uf3d6w33qN4zUU4rJXzkFYFzl4TyO7N67KUP31+EG1DJNmCz+BENkzjxnnwyHFWiUToBmMLVBNyC0WdVl8cKD6psKhWHHEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnyfl1v0; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJvVKWCd2pk397RlFfxag1pf2HLc18EzWNOd/eIiZzw1G0dikOw4EGkovXDcK9YOYhZ8Nrg8vkA9lvLIaQUsOzHCaXAAoaGHkqTc8Rx1j9TC27AOQofio+s4/KN+TsuTQIHPp8WVVXla4L8Dcb+iHK/GRiFR+pO6hFI9wgUDz3u+fjHwtm+9ou4+fxpDvmtbS4R72EQYCtpAx6kFkHnHfcyFkgkfnm7NfsaeGpNoh0+ee/i/hMjeJK352dMAT8sx5Qyi2hLl1PsXpRLoW4zHqT81zsBuSBap/QkpyI7NJasej/JdHiTY8z9ZqpzNykq/UFKEZ3RVmmvay69h50xfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3071ObV6LLc9U2n4A4HNDAeWGiw4e+9oj47G1aIi6QM=;
 b=Rn7mD6TgsOjEMJ4lrelAf3JQXPIJEuwm9c9NL+nzs15op+l/Aw20KjNPLsCfKrMLowkVvOqLfhKUcFRc/LSJ6Pqk6CT58dsRMFpNyv4k6XbOdsqnmM9xFDFAlFtjqMteYjFLZWGyKlUkTGx8REfoozZMjPHZFzvN61OLsXH1C5ABLKkraTHYAn6NyFsCzNGzQiC4fOn9t/WpIwdT0JDPtRBCPXHocL2FuBFGROoY8Jea+AsoToEJ7Z0VUCPwOOzCXs0+aXu5cur3KInwr4j8SqulXoWGB3nkOI2OglGzK1pY/tMEWjo/qwUQteTGa6QOI+NTbDuC78vNat/kmZ10WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3071ObV6LLc9U2n4A4HNDAeWGiw4e+9oj47G1aIi6QM=;
 b=mnyfl1v0NwRCYLPfI+YWv0guSMrLTKdsXpylyX2Qjl6RQnm57KQd2XzpmXR8cBpM7uytZ/wqHgfhjLai1zkkM7mtcMxLJmVGOYlm43M1agyVpMJojYrI4iMWQmpwfJtRBOLz9EKrFIDbUK5ARMP5SzPHea2XNx+KwC4K2raRzLcVPR/Gu/nD48q6cIPLRMIMDNx0DZR/hQvCO/QlC04deu90AJn+hdl8hFAjzVO8PQWDQi94z8Z1xIOvm1hUnT58s9Rax2TNV2y81f1n/wUbe8emq+S0l3tULjRqa0Mqy1NztqcAwY8FP1/3hvXbZ3dIX9vwgvq6HorX9Px4G/QF/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Thu, 16 Jan
 2025 21:10:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:10:54 +0000
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
Subject: [PATCH v5 02/10] mm/huge_memory: allow split shmem large folio to any lower order
Date: Thu, 16 Jan 2025 16:10:34 -0500
Message-ID: <20250116211042.741543-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116211042.741543-1-ziy@nvidia.com>
References: <20250116211042.741543-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:408:ee::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: f12e5b71-44cd-47a4-72a1-08dd3672436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZQYn1aM4/lPi5k8hOsgidyCiH+tkMJXtw5Oihff+tOiye1Dr1RZx4M2y4Vo?=
 =?us-ascii?Q?fn0ZFcUt7Xd004e7LqX+KFbROPR8ZYGDeSqUDLYgT+DPwx/72TUeLNt6VRYp?=
 =?us-ascii?Q?GP3xZr4qP2NnJnRXA8IffG+IT4hwioMwDCPlM/oM28nhF8d7t22lsd5ajDTz?=
 =?us-ascii?Q?r242zdT4o3MaVUyoAs4pBEL97nH9iG7O1kgeMlQCcOzDi2voQruQAuEc+hRl?=
 =?us-ascii?Q?GzPbOfxFpZQcC3lOjPcjOw6YDMshu13/E/wzPCzTWyzidT/mHQIAhBe/3Np3?=
 =?us-ascii?Q?SZTR1bGEVzgGR4J4n9p8A1khC8ZsKwJ63/Yy1liMBbrUu/myzrJUEhGzCbbe?=
 =?us-ascii?Q?yvXRJpSEgjZuEHI6chzlIhIrx66XnMZEHJlY1sf+CEFGskbxw5wAv3wS+OSh?=
 =?us-ascii?Q?mPBbtkvwtOy9cpqHFBtZBSB9Yi9mJyMREdclzxzNQXYUzIDksYi3F/tt7CYa?=
 =?us-ascii?Q?oqgd7dzefOXtXodS0CUDoihRjyG9hxm5WUQ7GjbEtGA3jREftYoL6Ty27TDC?=
 =?us-ascii?Q?UGAtJqh7/fBk7H1zGRZ7I5CySNBH3pOPsucxlO6BaK0sIR6WnqD9lLE9hXEf?=
 =?us-ascii?Q?JZgjD/OB0qQySfVUmC5kG1lYE02H+ZaC64b1yGsH1yxBkzjLZ6hSeM8K7w14?=
 =?us-ascii?Q?8G1jUrH4j154iac6aLyUYjHM0bTkyqoifQ9JGgt9molnFsxnfgIi0RivAy3g?=
 =?us-ascii?Q?cehcwz9T5sCGMXZMBo5Yw+45JO40yzfZM4IBVeNKQv4fHUf+zRnkcEKeKWTb?=
 =?us-ascii?Q?JGVYi8lQJdF8zMbk0C3/l0tX0MybZJ5fc72voYITNkgtbOCQmxkQKp3S9BxB?=
 =?us-ascii?Q?idRM7vSntJ0AyUmdJaVMPv0fVzVhbqC9TJaLDdyuOmH6TPFELjK8GhxFWWXw?=
 =?us-ascii?Q?S4++ib+mcI/gZtKADPrSngCnh2iTi6yZlFH+DHjaQTDR2ALw3xJUdzo4AboE?=
 =?us-ascii?Q?eXJcR8kMj/GUT4PhyYTtOqyAbfodNvYsbWQyNDRiNUjTt9PjOShmcLjB4VSH?=
 =?us-ascii?Q?2nm32ZqewFhC5MQSpCsRJq8F+beOnsMJrSB8W4F2S+aSgqGlJMG6EjJpEhUG?=
 =?us-ascii?Q?Y656BDz2M/PJEjtDMnLNeluT2Mo8QFHx+HudmOIGwIcIVNcsT4QQh2b2hSwQ?=
 =?us-ascii?Q?x0KuxXtCuZg1vGavm/p+m79Zv9URABdEdn6hYYissS8JYJyUtRoRK8m+kWFP?=
 =?us-ascii?Q?02KyxCH4WUEe7j8FUmobrF+8L0K7hAncTbZAQyRiwEbQdfthG2rDlH50Cpyf?=
 =?us-ascii?Q?lWS6iC1LDm8J4iTZzitSHxmIMW5x9dhuNIu56aqvAriCMR3rHDFuE1T+1Jk2?=
 =?us-ascii?Q?S++RuwFUNMcrwMa78n7M6ureKK9pt9IfMAP2Azbjszwo7iKAT5Ya+roFTRni?=
 =?us-ascii?Q?XJsPNLSaSlSWsgJhBQ3FrqvsIjUv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr0a6ZkBwTwWIN4Lx1sAsIOWcobGzJEUfjau2OjYne9FvdwGiiYHM22E+Ca/?=
 =?us-ascii?Q?cyJdpVcpBOxOt47Mohw7K7ywKhHIkx28hIzisBvxu4jfJYUhHGGRAgKVE65H?=
 =?us-ascii?Q?G1BictkIPGBJPkc9dqd4yOMS/twcCguL0n+mePZYweQLaXzBTUxDi7ux+2U3?=
 =?us-ascii?Q?L8k2HrtG1Ih7TuwmIYA0QAGhE8lY0B4JQAaSEYLOVbO+CRMYBsSLL7t4y2ah?=
 =?us-ascii?Q?EIhNbUJ3Uu2+4PEAbHliknhsvoKbeBTyEtxZcLq8zQpG2qsmVD0k91CGN44y?=
 =?us-ascii?Q?bqQOpFxPcHRPbOxu5M53dcEFlmR2K8MqDzyyGKocjO5tjweaxrUa1zDCL1Rl?=
 =?us-ascii?Q?y5sXu+19dYGoIdMdCICJ3vKhlMtVmViHivpqnHLQCnZMLAGCljpHMhnRDj+e?=
 =?us-ascii?Q?0DmZgEN7DkBeAhUdVYHIJAqvxW64ILtx8bx/R3n2hOvHhR0qvQno86Tis3Xz?=
 =?us-ascii?Q?lnp9QvUrXh79JoO/vWutBkhhUg8U0kkT7HD69YDrhMAacC8EvxPQyAnkeB1y?=
 =?us-ascii?Q?g+bJzu3zE9MNoR4WveMEm+OoD3eDc5yzJvPTKpJwE+IfIHh+cxXvPg6dWgqT?=
 =?us-ascii?Q?6i1tBBngRqtcpXPiDVu+N6UZFMzojxTjm9GkIPxEqZzQlUwai3wIbTWELWdn?=
 =?us-ascii?Q?x3C6udAVodYvHaDrXI03+a2Gr5s5lupBUhcJcu8Ri6q0MpiZsKi9aqH7ceDE?=
 =?us-ascii?Q?5bxax6Fpoi3DNv544KYwyd1TWNDqrhoiF1PrKsUTDhpgZCtM2+eCQf8VShje?=
 =?us-ascii?Q?cGyrUK21zsd4qvvGvh6daDA54v2tD4c7t3iCDaOej6WMUv8gE608DV/9n7BV?=
 =?us-ascii?Q?sQ0Ct3Z6VaZdyLnXRRDgL/Mp77JBG3mwGf8VeUBj94FNItrO9mG1JjYNd/ij?=
 =?us-ascii?Q?KRPE30aqeptqvKsTn6bLW/TgKsFmt/gFxJclnrwwhqkNg7ckNeP2ATxcAVCQ?=
 =?us-ascii?Q?8lF6KD77y1hDuAI2XxkHOe470NyIIkPbNQP80W2XoBKHQqg2vr0I1MIghc+s?=
 =?us-ascii?Q?3LTB/3roUNQKNj0ogvj8ZUXuY9kh/y7WBUX4GUR9UU79cMmXlm7kgOksgnNt?=
 =?us-ascii?Q?e58WMjiykGHJG5veHljBgs0c/oiRmw5rT2QqqePNVmQOr2Zk3uv0WALdJiX5?=
 =?us-ascii?Q?JKG+LakAQeoQkUNdXuIPs3vtfFR9WD1az9+h2wwvwPSqKg6OMzSda47ehN7V?=
 =?us-ascii?Q?m+8Ntf3Ub1lbAzcgptmuRsFcJASxac+xwogh8caBVGMGJzvkbISC261mQbgO?=
 =?us-ascii?Q?nXiHSnWVwwm6xKB/nSAf3fyNeyY/NxmJTP386OefJTVcHCLVqJcidUwdJkls?=
 =?us-ascii?Q?VVbyGkPV10Foi2Nxw2RySJcH7JnYjql9TiU7II3SIpvhiFqMVfDObz1yxy/1?=
 =?us-ascii?Q?eMyim9rjgA30kazC8SMUNbpW1caL2LOizCJ9ajyxedMITsA6TohKtpvDeOSe?=
 =?us-ascii?Q?CyxNj3k3JaY2YOAl7+E8IG8p8ZqAxgz3hJCEyEOAMRH/l9x62biRHRounZlL?=
 =?us-ascii?Q?aV1NVFwC43TefgKYjOxWorPiPn9tGZP2qQ6swOH8lW3wUsl9trrX7KcZieDR?=
 =?us-ascii?Q?2YOIr8jvx8lXw9wKTwTEDHBnA30pKjKp9yXHDXXI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e5b71-44cd-47a4-72a1-08dd3672436b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:10:54.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wsfY/K6+5DPNB6QjWp3xpL6o4MQU5T9op2I7WLu4bIXD8mFF+qlycRzkdZCEVCHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

Commit 4d684b5f92ba ("mm: shmem: add large folio support for tmpfs") has
added large folio support to shmem. Remove the restriction in
split_huge_page*().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..deb4e72daeb9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3299,7 +3299,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (tail->index >= end) {
 			if (shmem_mapping(folio->mapping))
-				nr_dropped++;
+				nr_dropped += new_nr;
 			else if (folio_test_clear_dirty(tail))
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
@@ -3465,12 +3465,6 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			return -EINVAL;
 		}
 	} else if (new_order) {
-		/* Split shmem folio to non-zero order not supported */
-		if (shmem_mapping(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split shmem folio to non-0 order");
-			return -EINVAL;
-		}
 		/*
 		 * No split if the file system does not support large folio.
 		 * Note that we might still have THPs in such mappings due to
-- 
2.45.2


