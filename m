Return-Path: <linux-kselftest+bounces-25788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096FA28284
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 04:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514EA7A1713
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 03:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD5215044;
	Wed,  5 Feb 2025 03:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cm7gZ5K6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D50214A78;
	Wed,  5 Feb 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725288; cv=fail; b=ZpfoxTx4Jq31NO2cShOJHtCWYnFVi0RICoYWHgXkzpE8Puwk+Iq+0OvcEcNu+UQtZO5jzNQY+UG5CcXL2icOcd2lxoNdIqqGyQ/F532DHauvsZPBN2F/zLAyjUhNBPWhWVVEc0JmDXi/Y1LLaQJ8A/Gnhlwo6TBAPXKRdg8QtCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725288; c=relaxed/simple;
	bh=Qe7Zu51Yoj1Bho+dn3xJ3yUXCwtoz5Ncj63nD55sUhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwgCegSQuXA7hnZSJMipGBwA2aK4qhE0x6a6hBmQnxEdauZgxYrHIML+7d0v3GutW5rgR8uit0yJbYdYIE13ypHUIYuff0biJGiC/0uQVeDreqKvgla5Kckc7kjoOga3KJU6T+z5ApttBQApaT81e8aDM2n7tmAazrGVQxyKyr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cm7gZ5K6; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDjAh+0h84qFq4oh4cZSMT40f5nT86XqG0+B7WNPm4hPZpOXz7k/4eDkg51nYNyX5QgrjBZCTzRYOi8RjgFxtKjdMXEo41KvUWQ0PGLFAr6mkDYgrfGd3fsr+ZriML/hF5B//+8VGNvyKkwk/ZjHOf+RKTZg637QVE4fj/unGTfG7KztMSwcYwnEYoELBn2Ur8FkzubqUKxOHYdmGPAprQVd2QCLSHdwo5Sa99o5mQRO3zOszwcFNWaXmnpPb1ZfE84cEuHB1cDbPseNAvsnx03OTw8wj8y+cql1Yat2kwZajdQn6W+BRSdQgHyR7BGZp8VQmy7H1D4XevE6MWachg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzWG5ERT8VgWun3QsLhrd/RvRcNSHM5c6WUx/NfEVqk=;
 b=TtQAvrmcVepixcx4JnkHgTdPo+CFntc/JstoON7dKYmuBWxcR0A8qumCp32K9ZjM1XjMj+nAnA3sYSAf6F56jSobnpexdNOkUunrzry84wT2Y/KrDGQZTM8KAjHAkud8Z4B2UTGVEWfs+9Wv8yPR9XnSOb7jCuZqX99/RBXHiNWfRVlDt71q6XqPsjPbl5ahponIAOm1DqIGbJGNVdzW9ilOFXX6k9fkH6NChjGTgOJlvmtff7gyYIMuf1T3hdf2L0IqwbKwtsww/HSriiWVgq6Gm9vRpDrRpC+8CYcHWalejgDLlORNN9aMunorOl94GRcSxsn0YQQ/RDiA4du5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzWG5ERT8VgWun3QsLhrd/RvRcNSHM5c6WUx/NfEVqk=;
 b=Cm7gZ5K6Y2olsZcad1/wm9arZUN8w6rPJDvvIZtkPWfMjs8CEnHm3q6iI3NrpUn4oHfPcw/OKYEW2nbhhiyfqpI9oCNZcTM9e5yOUOteE81zo8LuDgk9wHZcVftnMw8U936lpx2c2J2LldUv3KyXwdPo8aH5mPmcL77Xcq9hMQZWKd9IDXG6WWrqeojfVMnQGUsYp50QImHDCVAy6BoNEcuOo9hB3SOXwBN7UDEI44rEc0jIiBZHmw8yO3/qWGE9P4PUBJGKoOnm3VUYm5Nc9t09dYztjFsEcu/hq/aJ0JfmGzx1Xsv+8u7fysX/6FuK5nDrKMjjcsOBGPkypzNE9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:14:39 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 03:14:39 +0000
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
Subject: [PATCH v6 3/7] mm/huge_memory: add buddy allocator like folio_split()
Date: Tue,  4 Feb 2025 22:14:13 -0500
Message-ID: <20250205031417.1771278-4-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250205031417.1771278-1-ziy@nvidia.com>
References: <20250205031417.1771278-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:408:f4::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 530884e8-2f75-4a96-4d3b-08dd459339e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kxx4RrBBW60SEdG9ClslL6RLWw8o+5hrXHaLwMx6eYU31lIvthpI3QFJBdgO?=
 =?us-ascii?Q?BiGyrdz1pjIf5+4bAnsJC2Sux2qRXuaV1vJcvQf58ZXw8bMRyZ/NPDhH0ITi?=
 =?us-ascii?Q?Thw14IfnjQbANWJuQXIoiT8h/iMrgOtrX92s+/UI+pW5bYGHzbh9NmMgoKJu?=
 =?us-ascii?Q?/G9JHIylmkjRqhSjwZMZ8jBHzxP5gjVijg72UwjC3Adgb3oGjEycxwAl5LoO?=
 =?us-ascii?Q?QgSsEid+Y6+m+Qp3ChfQyan5GuBZA7wr8BY1NqjnnhnzvIiHxsvOgSvQE009?=
 =?us-ascii?Q?uRkiKXkNjFbyfG6ixWWVJ7IdGJ+ViDHwZ5kQDDS3nCYXjwAJZFw5kbbXRCHA?=
 =?us-ascii?Q?9ZkXW+q9qwjqoaoI3B5PhTwFcbgZyE7NJtX9xiK42ALN2grMc+YQdmyus/fl?=
 =?us-ascii?Q?BXpZ4aOoURTlgKYnGrUv4fK6nbvzDLUcy7W0YIU9HD47ZfqBU/jzMgPW50x8?=
 =?us-ascii?Q?PbqQ/Nljk/9I5lj99VPE4/b5n1KdPXzI//649qw2ZKNwaAsrppbujCtE56hx?=
 =?us-ascii?Q?qGDGweRumnUaXV4pJ1dvKW4IHwcGgpMRXriB/iuqtgtAKUgfymswBa18ozh4?=
 =?us-ascii?Q?cmMPOcGLis0c5p9VfOQrNLmNkqLTjC/zhFYRpah0oPIMueC0FnQeRmmm0Odi?=
 =?us-ascii?Q?1W9jygcXAsQoOSuMVJ8z7Umv9rhUcKI0WmHpXurOQhHWi7q2c7cS1W2SOEnu?=
 =?us-ascii?Q?iBbl6Q9b+oCRkzT4o3SRrDckY/s+GXzFfnVgSZD7Lm9S3lVUBiyJcB+imrfs?=
 =?us-ascii?Q?9FKFZrJIWJ6IECsDXvcf0SDqoeMJ5abYNiDkH2sdE3Mwjy+o6BFrZkno0vSj?=
 =?us-ascii?Q?rc5Yuq9rEp+gDfVkBNtEZa+TzkDuq3DVpuuvR3shAHC2UVOAr7lINoWLBiYe?=
 =?us-ascii?Q?nzWxJdqGLV2EuSLtrCgqeXPwcBp/NbbQuK8lLqCiMx5rDTtm57ksSNh8LG1F?=
 =?us-ascii?Q?ZBD8IGGtzL+qkLbrubjY0RXBQC1R3gCp1GP4Fw88i6h9XdZPv0tABmOammw1?=
 =?us-ascii?Q?DKAyLLp09rLoB6K1Lf4BJa3trKazUP9/xP1hY3aKHo7PmoPTCZEDvfJ3hWMT?=
 =?us-ascii?Q?jIdZrE07Xwlrb27yG0cD1CV2PFnbTNgHDSGNaUBssW1vVeVq7shOJChIfBW8?=
 =?us-ascii?Q?cUhbISdhy7AI20+YRKAbQInCuNoqc35Nukdr8TQMED2VPWiC7pdy2HUHBqDW?=
 =?us-ascii?Q?S47MXD3QS38vVd7N0lXNggwCIWi0EEpSRhbF9YeQ5GgKiKflGH58O7vULVuk?=
 =?us-ascii?Q?kqUtfRh032H5bk1hS8Ly7gCu1vlnago8dwl9sl3OGBqky5N840S6/NXZxhhi?=
 =?us-ascii?Q?s7JHqJPNMZrhCCaImGfV5hiQrEVJH0REss6J4b3CzIhS5XgCX5zxIG4DqQQn?=
 =?us-ascii?Q?hTpB+AlcsrB970V3lHmnvvolqI7R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RxgMQedwVZb02AuBs3yg0R9AtS65uevfRFw+wbkRUUPfuNKb6p6Wpe7bQzHB?=
 =?us-ascii?Q?dG5QtDU+44c01T+zut+NwyNefzYA64Tjexvy7g7hOxKAQhCA3qRzd81nn6Gt?=
 =?us-ascii?Q?32sfHgM6oWsJ2c3V0SMNSMvTMvDZwwuLJEgemJ38sLNiLXLvTaEzUo6rhQp5?=
 =?us-ascii?Q?yhEVfmcCTte+x72tk3zLpFnxxhJvzTmCPKfqVIZIgvIfHQeXnedyduBOROjZ?=
 =?us-ascii?Q?UomE7U42+CoPj14IESowFdL68ajN3zfCabN9ShoRIlpp6VlZ/UsSUL4t9I+p?=
 =?us-ascii?Q?CyuO5n+hDGAEe/dXdSeEqntAohe81YxVwIf09WUt+aILnRXxLCcVGfRrnbTk?=
 =?us-ascii?Q?OUQpsZUO9CYYXQXjqpbxnGFqD4HVMNHUemKF6jvVDsjviAqmkrUfSK0FTIcB?=
 =?us-ascii?Q?94GKRHLg/quX56ROPmqSOriUqEhpyDWRrzKKmMh0e+ePItXwvBL08HtEut6A?=
 =?us-ascii?Q?16ymJJ/5udzd79u+G/Z05tTZNB/WOEWJH+Pg5dC3/qUOM7jqpdjCtKbIF6Jk?=
 =?us-ascii?Q?BgYdst3Xw+XS8AsFt6ebX62JXpQJatKKT+3FM6S//13lRyCysldRXzRrWEGy?=
 =?us-ascii?Q?JJMcwgY8tP+eF3QBSBrh1vzg2BOWBQ+HP9Rp1O83cZOYzrPp802YxOEE+az+?=
 =?us-ascii?Q?FKGMDoy5jAtWCIfwGOxGi8jPVvfiUyJkw8IvOqbLcB83HiEP6ExYZ32tCXpJ?=
 =?us-ascii?Q?RmQ57H9S1IVOERRvHjawX/HgijfK+co/how5hKvA7jhQkvZ8M4I1IXkuV6xI?=
 =?us-ascii?Q?lr7rAzYNcTrFjkTN5k9jWwn4n3uSbIGLq6hW0JfXZs+mLyqpbImUaRNe7cth?=
 =?us-ascii?Q?SfKb0I4AhZxrCZ0+IlColUjb435NoJOOA0nFsn/XHlyaCTAsjmRgBCpiYtAG?=
 =?us-ascii?Q?MGaDJvg4oChEXnviV25qzCqwrdhnO7TRZdOF/pNVVjkzBJCwizPOH0gSpeR0?=
 =?us-ascii?Q?OWMjvqr8+Tcr1o6cFAfwtmPc04tngC76enfEJSvzliIofHvOn7wVTHB6dx1K?=
 =?us-ascii?Q?WcHj6NuskUe4ci0Kh1Xli9Ewhwc5A3Y4pEqEHcQMgltd5XDaaQm7TpI/uihE?=
 =?us-ascii?Q?7PwFqLfR6Iohfhisld0eCph4PaZ6GvbL/I/ONFiqS/DolEovkrwH4QM3Rt3e?=
 =?us-ascii?Q?OQwbXnELOZXHpblawXfCVvUf59fymSgA2ay+s9A0dz36Oqf10IfqE4JY4pTS?=
 =?us-ascii?Q?PfVdCYWzTzMGlXycuNyXQU2Hb8S0YanVnl1SN8ZAJHmysr2lJdLW5RT3GksX?=
 =?us-ascii?Q?+YqBZBKyeSQUDPfFbXrSmVH8VQkeLSf4/2IQeVw1NQZC0aiJNaH5+90OnrJu?=
 =?us-ascii?Q?bcmH21eyfNLSPToDrk0e3ns1sSu/UE52HHon6zvl1aHfWmhPLTtlNglCOEtr?=
 =?us-ascii?Q?vUz9Fs7RODn6iA+G1gpjboBPUlvbFJ5WZTBljUX1aSb8q9upPyDfslGuCWTL?=
 =?us-ascii?Q?rY/qtzniAmmRCySJZV08q7d6m++uJGCgDBjR1jBE0gjtS1vFjOWOs3rQPLVZ?=
 =?us-ascii?Q?Ok8Gr9eJe6vzGlXVF7b5iWIew7NAGlmSeP0DTHGR078zVpFqdBMYgkQa5v3Q?=
 =?us-ascii?Q?H4CXQxMzVPMRyuhYA4CJG0Chnkwh4UNyIBUyk462?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530884e8-2f75-4a96-4d3b-08dd459339e3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:14:39.1744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJY5IMvfPDTbM58wA0oR0L0SIkzH/hGSQ4aOGAtRKFDxv7PvQzI47JfziCJvxBkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation. The purpose is to minimize the
number of folios after the split. For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:
O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon
O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
Since anon folio does not support order-1 yet.

It generates fewer folios than existing page split approach, which splits
the order-9 to 512 order-0 folios.

folio_split() and existing split_huge_page_to_list_to_order() share
the folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using
uniform_split variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added
to factor out check code and will be used outside __folio_split() in the
following commit.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 134 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 97 insertions(+), 37 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 848bf297e307..20d7be07cd7b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3741,12 +3741,68 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	/* order-1 is not supported for anonymous THP. */
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	/*
+	 * No split if the file system does not support large folio.
+	 * Note that we might still have THPs in such mappings due to
+	 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+	 * does not actually support large folios properly.
+	 */
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split file folio to non-0 order");
+		return false;
+	}
+
+	/* Only swapping a whole PMD-mapped folio is supported */
+	if (folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/* See comments in non_uniform_split_supported() */
+static bool uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio) && new_order == 1) {
+		VM_WARN_ONCE(warns, "Cannot split to order-1 folio");
+		return false;
+	}
+
+	if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+		if (folio_test_swapcache(folio)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split swapcache folio to non-0 order");
+			return false;
+		}
+	}
+	return true;
+}
+
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *page, struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3761,29 +3817,11 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (is_anon) {
-		/* order-1 is not supported for anonymous THP. */
-		if (new_order == 1) {
-			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
-			return -EINVAL;
-		}
-	} else if (new_order) {
-		/*
-		 * No split if the file system does not support large folio.
-		 * Note that we might still have THPs in such mappings due to
-		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
-		 * does not actually support large folios properly.
-		 */
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			VM_WARN_ONCE(1,
-				"Cannot split file folio to non-0 order");
-			return -EINVAL;
-		}
-	}
+	if (uniform_split && !uniform_split_supported(folio, new_order, true))
+		return -EINVAL;
 
-	/* Only swapping a whole PMD-mapped folio is supported */
-	if (folio_test_swapcache(folio) && new_order)
+	if (!uniform_split &&
+	    !non_uniform_split_supported(folio, new_order, true))
 		return -EINVAL;
 
 	is_hzp = is_huge_zero_folio(folio);
@@ -3840,10 +3878,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			goto out;
 		}
 
-		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
-		if (xas_error(&xas)) {
-			ret = xas_error(&xas);
-			goto out;
+		if (uniform_split) {
+			xas_set_order(&xas, folio->index, new_order);
+			xas_split_alloc(&xas, folio, folio_order(folio), gfp);
+			if (xas_error(&xas)) {
+				ret = xas_error(&xas);
+				goto out;
+			}
 		}
 
 		anon_vma = NULL;
@@ -3908,7 +3949,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3922,12 +3962,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(page_folio(page), new_order,
+				page, list, end, &xas, mapping, uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -4005,7 +4041,31 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at offset_in_new_order to a new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @page: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * Split a folio at offset_in_new_order to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * split an order-9 folio at its third order-3 subpages to an order-3 folio.
+ * There are 2^6=64 order-3 subpages in an order-9 folio and the result will be
+ * a set of folios with different order and the new folio is in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *page, struct list_head *list)
+{
+	return __folio_split(folio, new_order, page, list, false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.47.2


