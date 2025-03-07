Return-Path: <linux-kselftest+bounces-28511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B3EA56F54
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 18:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7BD3B8456
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752E2459C2;
	Fri,  7 Mar 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3Xma+5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDD24501D;
	Fri,  7 Mar 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369220; cv=fail; b=QrKj8ly0XWG0ykHElQmzCvzmOu0X1Jr7cKtC/sMpT5Ps1XW54mJPCdSTu7A8dVpANBGC272YnICNwWn13TRM+g59P/5TlSE77oFZfYZifRtFujs7iLTGj8AM6IIV18m1TcTFTT8AqzPgbk/ggKnqxuD+CpEiQeIssSV85/gquIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369220; c=relaxed/simple;
	bh=BdUaXZ9cvvw04jVxrqHqD3fFkhgjhWCN5aIif9Fmlag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BPQ4TbGH3ENu1PzOxvIWwmKJiKxuoA7G8Uw4dRAKWVfNqPK3QMdtTGDe1yHF7dLsQQEDcK0SBYoRVQmlClsCuTQTjOlwNjwc0O703fgrsblB4Z1zcXRTTlo3fegNellfKENkqg+RkVWVXNQw+hTzeCQ1rlG+8KLA1jPHpARNGpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3Xma+5t; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxrEZqQn+lIt3no29wsYL4AhAmjfnVuc1JlK8z8tgwmHxEPLHGNAy+GG7xTiXhkwJj+5SgQk9mZxDgnD3kyp+Zj4LIoYY6pw400iRl4IZJvaW1X4Bp5Jf6m0ousQBegqdDe39US0odCCVWMVR3sV2D4gsk2rJS0w+IzIRoHPiB/ASC8mBZBXz3HSTzfJ9v6MqhbGg8p51VIUbLTIaG+SqKiscCupQOFpLuXIJzACiYb7DFuy6NbPQZYsySzF1g+lnc0a4SGQMXrTFW2Fe/qtC3YBee4+4iEz2c5V87feqixtuSxgY2sZpamfRtNnNqsc6pGKQMiq9oCq9EtSKz9TYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YAH75U2IxjioX4gzhQCg62wiGb6vowPt2F3W3wP32I=;
 b=nBZvUa/B+qemIWGkgSgbsXcxVvWiwqHnT+arHJWGy023bCWte6uGq108oxxjQjCbr0Vya/yZTuySGxmOKat6fVhweAMZP6vArgQeB+XcBMW459f9sx21mwBeeTAQNaPf3HW+X2NFmvobbh0SGepia+UlgNrLeYq08JSxAb5WLpRkXe3K+SkWTSOlDWOhdOrmzQyDBW9kR7n3KvhOavcR/1+gABLh7DL3EMC4F/JFvNaZxGAZmF2LtTFyuF3zPaerf6bvOdHVjNr8K+/qOJwAM2AOl8/j5fROWcVxGGB0toLDkY6MBbRD0ZHAVijvLxmN5U/bD2cVnp72CUV9mbmmEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YAH75U2IxjioX4gzhQCg62wiGb6vowPt2F3W3wP32I=;
 b=a3Xma+5t/phmPozdwB39gPnd5TQheHcwAouOANF+h9sv+x0vPeIhZeyEVgEzM5QHoafrBLiBQpdJhJoVtbAXVYo0MCAY4bhJDsDAVp7l+8ne8OjGCwbpL4KQVM50FWaUdzZNnKEoSxUlMlOGBTMM5nesVB4t0GXLJDDLDddgO8Ko7lSwBlpThMaK5OG2nes8N0Vd7Xm5UE/srpCaIzcoTfjrXhK4adVgWMChXTnzPUREno0/jk07GZlqgkmeN19eafE9z2mTQ1Qptkrdo2kiaoFh0RcAG5reO7ZD7p395JAbr0mXFMsIEd4Igd2ZDFk9IYgGPmtUEwWMQOYBs7qDGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 17:40:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 17:40:11 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: [PATCH v10 3/8] mm/huge_memory: move folio split common code to __folio_split()
Date: Fri,  7 Mar 2025 12:39:56 -0500
Message-ID: <20250307174001.242794-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307174001.242794-1-ziy@nvidia.com>
References: <20250307174001.242794-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:208:35::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2f5eac-ead8-4ee6-98f6-08dd5d9f1c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RB74sPCA4mz/ktuzseFzFDZzPAKmE4mCiwmaMAdynVr7hZ5P6nNTASeQjWRr?=
 =?us-ascii?Q?SerBXyoCBK+7eW/v0tCOvyxHliQ88FgJ8BUPnxCQqo9s/E5cperTc7E965uW?=
 =?us-ascii?Q?Pmpcdgb24btxAl12gUT8GvW0RJvDk1O0fdHcf435kFxUVvIQvHjGqu1kbki6?=
 =?us-ascii?Q?za858UluZ7hAbExL3zbvffs5qeoKT5tkRkcZ1j5T1su6KKF3BWyn9R/Spi0y?=
 =?us-ascii?Q?FctuQV0lZD+8da++CgaIkVtICFI1+rXQZcoLVLUGByIt17U4kvUxViiCv2Ig?=
 =?us-ascii?Q?0jFCB8T2znILVsd0fnOlvPvq1JuEp8UEsST4WGk8233nCJjtwNRwPb/cQEOU?=
 =?us-ascii?Q?qvyMPU5rs4uXN9JfAoaaM8bZgECfJC9lI413bObOLBsjR19+XjkLaYgPWFCN?=
 =?us-ascii?Q?o1XpXe/+x8N1XXFbcfX64FvjyJoBBSPB78ELW50rr3o4crrSl+KBnJRln/CG?=
 =?us-ascii?Q?5GHAf1T3E+vxEAM+qu6rSPbS9YcZwo06ygmGKWeLDpKVE//IIEIIzFu/bs4J?=
 =?us-ascii?Q?9hE43H9pAa+lbxPilyPh+Cfuvufdp4ukzWPQci3f2aQbkAl9HoEnxiI2F2m3?=
 =?us-ascii?Q?VLC6lQ2u/uCyLJtx/93uZuBz5F2XnO+dZgPE8RsFkC1z2ARvz3PXEfaii7w0?=
 =?us-ascii?Q?6wueiD9aMXFtK2VuYOZb/sdD6x+cS5iHBpiVckfdWo4vrTflBijlg/VxVk8u?=
 =?us-ascii?Q?Mzow54DV3X5T992Gx70xUgr53q+MB3MdafWe77w1wwe0qYNGmctQ7D4RIKic?=
 =?us-ascii?Q?cLE73RXHgjVnDN0yXpnt5l7SHsnmOuXtOhNPe8CwRNzEFWdw+UGN6PIHy/pb?=
 =?us-ascii?Q?Io6ShYjdGyAG3ShrMO02NQavocjK3w3T6hOCFXtCcYZhZknqdb5fqFI+xldA?=
 =?us-ascii?Q?7y2BDupHn2YDvXQLdiFZYeDPazSG7EieYhIsblsvzk291r+30VdqVnBXbDd6?=
 =?us-ascii?Q?jIlbqkxFVvMYZEVMQdsSZZYnus3J2fKERVvZC2/BMDkr3xtbB13Vwrp4zQum?=
 =?us-ascii?Q?M6RD02vuO/h5UR9ysOlpXBSFk17ZOlYu27lAryO2VXixIvDe6pve9GOGVNhM?=
 =?us-ascii?Q?s+jpwEIO7gBLAmCY5j+KlQri5K4T0ohHvLFIb3fC4MoVMRagp5P7tcYIHzRe?=
 =?us-ascii?Q?TmKzGyNNCv5snpCH8lbS+B/E5MF70uU1eyBOkGBHs5uszIqrn7vlSGfl1hJQ?=
 =?us-ascii?Q?lhIYMcmL7HHQCsUxJmsBRmKxQVB35vcJ+Q2j506/iMmwE05uLQDcjsxitKeg?=
 =?us-ascii?Q?VO6RHMWzoUATFUI3y+qzXq5Jhimcu7/ZgDqotFwBoP6VHMjgObWfPPXQLaLW?=
 =?us-ascii?Q?5aIQEYNmSAu2P0EbIu6YCzsiESn12A0O1R6ugpgjYDRpFPQkMTgZ1WzMM20N?=
 =?us-ascii?Q?w2yPfl/ruQSA965wa9+X7uHCiYpt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p8QkKvqInpeUq4+oe5Q1vIPveV9cJS86x7tnmqHE+gvq4tE0pbCmOhsK+DKg?=
 =?us-ascii?Q?Ab1fyamA+QkgXl9DtUZ5Or1CoDWJdLmCz84/4r2acP49WZEkIYz6jR+Q63Qm?=
 =?us-ascii?Q?sCYpyjpsBUOvggWoV2lNoDBshfw4d1ldsywgH1Fim7CEkGyfKPvylyfRWfcH?=
 =?us-ascii?Q?jRCzQfQuK5hTQbiDA9yIjIcO8ZeKTtsLQJRe5sweqOzWcySn2crT2HOzVAzh?=
 =?us-ascii?Q?8u0f2Lyts2hkjytQy9B9CmpgP1Sc6J7ncLqyiYlrHaXz9/9A7XyRpiMbbvQB?=
 =?us-ascii?Q?u9Y0prIbPt9rcGey5LwA9pwHK+lsXuhEVBPwDZoJl6UwHpXWWhf8DmoTHuth?=
 =?us-ascii?Q?msRx329nNdOEPpH+BRzCrtkmeBC89Xjo834BRECabRNbs88Lgu+cUobraVR6?=
 =?us-ascii?Q?Ocv+FRbLUJd5Bhhb4bwu9f/xZ94Mgd0JZiOGyaJJuKE1vCYmBvxzRs/hpEJN?=
 =?us-ascii?Q?0N9cmIxjd6XnSD0/pajFVq+v7Q0WSVzx2S5HGwXRYQ6w6SW8ua6jho6D40Yh?=
 =?us-ascii?Q?BRwGKgzGc4Ih5Ki6OZvrekw0858PNkgQhIOGubFaOoTGT6W5LjTLTW4hu/hL?=
 =?us-ascii?Q?ILRy0b0Mk7WLR5b51dCYQE5TbsOQO4/LRiSSzkvs6OPJTFKPVv2ePevx/6Ap?=
 =?us-ascii?Q?qQTRtrkME0of1/ZhGjKa3l4OLqulJJ8z8IbjAoXC2OG+gq1ylCEikVmXQniu?=
 =?us-ascii?Q?zmaS+mCZfXvbyIDzPwIj5hgqjJrUg/ovnj7tHsVxJDSCTZ6Cbvz/lCZBybXY?=
 =?us-ascii?Q?IyOLD60z/4W90MfpTaZT3qgM43lVzOHihwnS/A8o46h7zj0JbGlRwzwxnGAX?=
 =?us-ascii?Q?T/gYIzlirYRhC9zh77jVjiddxzEpdBpNR9kxqhCJNL2A3EWgAH+RbNZhs304?=
 =?us-ascii?Q?KYxA0MM8JQmn2wOs1zv6rU+qx/spIRBYnJfabpz+6Zj3cziPAFqXJpOgMxn6?=
 =?us-ascii?Q?JFouAlosHuQxlGQeXmjIG+dv1dyhamRPPWz5Clw9FGFWQz+yOB+nxCOWJOWx?=
 =?us-ascii?Q?MJnIqSDJzzKprnm5IPWaQX2/o8k1oYEcP7BThSNNXqq/pNTZS9OlOFiHrRZ6?=
 =?us-ascii?Q?w5u+nxKr1Fidy2M2rsFI7SSc+qb6FdazeK+p1lTM5ftDRNwtLx57lw3mZFeg?=
 =?us-ascii?Q?kdA/lZ9KpJYOi9wEwfXqJiD7Ixb7p/QtXokUG1xgPLUxlkj3yFFj0iazr5VO?=
 =?us-ascii?Q?Umy+LUFZTw/zXI76KMmOFmYF/LwxjxEdGXTWW6P3/e96Q6ifkFpeqqVHjt5u?=
 =?us-ascii?Q?bM4JiVpLto4URy5CTO7IeGYSUJSmZ8NH2C+rLGBFrZHOTC3rLDUJfD6ErTgQ?=
 =?us-ascii?Q?vTbeO2qzpLF3wO/RQgYR0tAQ+FZsTshYn01glkZavOZVIYpSKwGhfLqRmEIG?=
 =?us-ascii?Q?kGqygrSzUmcAkYfX7jhTx8vxik8VYGjMbn95n+l90ubVR7BwPLdB/PTshooy?=
 =?us-ascii?Q?Gfhg8YhGrw52kKrTAJiJ3fbKMNy3rTVmh4deXLS0qv0SB0E/u4Sfauqv7Jdo?=
 =?us-ascii?Q?1vZxs9DOXtlUr7MehdU7GH5vuGVRWlett7+HcR818+A8CIQ1I9RTNOT7Si36?=
 =?us-ascii?Q?jbdF9WYqo4/id2Xb414=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2f5eac-ead8-4ee6-98f6-08dd5d9f1c77
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 17:40:11.6861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hoik0q7OdqE8yX2NdH2PJKXebYK+Ry6oFLMpyHGtIfVU8/cZlpFh1tljOpNz/Zn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014

This is a preparation patch for folio_split().

In the upcoming patch folio_split() will share folio unmapping and
remapping code with split_huge_page_to_list_to_order(), so move the code
to a common function __folio_split() first.

Add a TODO for splitting large shmem folio in swap cache.

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
 mm/huge_memory.c | 112 ++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c10ee77189bd..871c260163f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3863,57 +3863,9 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
-/*
- * This function splits a large folio into smaller folios of order @new_order.
- * @page can point to any page of the large folio to split. The split operation
- * does not change the position of @page.
- *
- * Prerequisites:
- *
- * 1) The caller must hold a reference on the @page's owning folio, also known
- *    as the large folio.
- *
- * 2) The large folio must be locked.
- *
- * 3) The folio must not be pinned. Any unexpected folio references, including
- *    GUP pins, will result in the folio not getting split; instead, the caller
- *    will receive an -EAGAIN.
- *
- * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
- *    supported for non-file-backed folios, because folio->_deferred_list, which
- *    is used by partially mapped folios, is stored in subpage 2, but an order-1
- *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
- *    since they do not use _deferred_list.
- *
- * After splitting, the caller's folio reference will be transferred to @page,
- * resulting in a raised refcount of @page after this call. The other pages may
- * be freed if they are not mapped.
- *
- * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
- *
- * Pages in @new_order will inherit the mapping, flags, and so on from the
- * huge page.
- *
- * Returns 0 if the huge page was split successfully.
- *
- * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
- * the folio was concurrently removed from the page cache.
- *
- * Returns -EBUSY when trying to split the huge zeropage, if the folio is
- * under writeback, if fs-specific folio metadata cannot currently be
- * released, or if some unexpected race happened (e.g., anon VMA disappeared,
- * truncation).
- *
- * Callers should ensure that the order respects the address space mapping
- * min-order if one is set for non-anonymous folios.
- *
- * Returns -EINVAL when trying to split to an order that is incompatible
- * with the folio. Splitting to order 0 is compatible with all folios.
- */
-int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
-				     unsigned int new_order)
+static int __folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
 {
-	struct folio *folio = page_folio(page);
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
@@ -3989,6 +3941,11 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		mapping = folio->mapping;
 
 		/* Truncated ? */
+		/*
+		 * TODO: add support for large shmem folio in swap cache.
+		 * When shmem is in swap cache, mapping is NULL and
+		 * folio_test_swapcache() is true.
+		 */
 		if (!mapping) {
 			ret = -EBUSY;
 			goto out;
@@ -4123,6 +4080,61 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	return ret;
 }
 
+/*
+ * This function splits a large folio into smaller folios of order @new_order.
+ * @page can point to any page of the large folio to split. The split operation
+ * does not change the position of @page.
+ *
+ * Prerequisites:
+ *
+ * 1) The caller must hold a reference on the @page's owning folio, also known
+ *    as the large folio.
+ *
+ * 2) The large folio must be locked.
+ *
+ * 3) The folio must not be pinned. Any unexpected folio references, including
+ *    GUP pins, will result in the folio not getting split; instead, the caller
+ *    will receive an -EAGAIN.
+ *
+ * 4) @new_order > 1, usually. Splitting to order-1 anonymous folios is not
+ *    supported for non-file-backed folios, because folio->_deferred_list, which
+ *    is used by partially mapped folios, is stored in subpage 2, but an order-1
+ *    folio only has subpages 0 and 1. File-backed order-1 folios are supported,
+ *    since they do not use _deferred_list.
+ *
+ * After splitting, the caller's folio reference will be transferred to @page,
+ * resulting in a raised refcount of @page after this call. The other pages may
+ * be freed if they are not mapped.
+ *
+ * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
+ *
+ * Pages in @new_order will inherit the mapping, flags, and so on from the
+ * huge page.
+ *
+ * Returns 0 if the huge page was split successfully.
+ *
+ * Returns -EAGAIN if the folio has unexpected reference (e.g., GUP) or if
+ * the folio was concurrently removed from the page cache.
+ *
+ * Returns -EBUSY when trying to split the huge zeropage, if the folio is
+ * under writeback, if fs-specific folio metadata cannot currently be
+ * released, or if some unexpected race happened (e.g., anon VMA disappeared,
+ * truncation).
+ *
+ * Callers should ensure that the order respects the address space mapping
+ * min-order if one is set for non-anonymous folios.
+ *
+ * Returns -EINVAL when trying to split to an order that is incompatible
+ * with the folio. Splitting to order 0 is compatible with all folios.
+ */
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+				     unsigned int new_order)
+{
+	struct folio *folio = page_folio(page);
+
+	return __folio_split(folio, new_order, page, list);
+}
+
 int min_order_for_split(struct folio *folio)
 {
 	if (folio_test_anon(folio))
-- 
2.47.2


