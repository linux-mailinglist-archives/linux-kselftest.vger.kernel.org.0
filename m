Return-Path: <linux-kselftest+bounces-26915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A658DA3ACD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 00:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D67174DB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 23:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2AA1DE89C;
	Tue, 18 Feb 2025 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eqRF+P2B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306611DE4DA;
	Tue, 18 Feb 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922632; cv=fail; b=K6TnEjWhZINIVlKWz+OVTM5fdUuAKcToXOPXIu7ywnrvVFw0OkvXB5HXlJ3WNNg10Sokyvjgz1UmYAZOETVR+2psPMHA5hR+NPhkuVfyZZMsLy2VvPi0I4X97JHis35Q6wo54wROjjdz4Ukig/Rra1lr4vQPxku+Lg1hT/KFqhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922632; c=relaxed/simple;
	bh=jtqwzLqkAkgMcKGpYB1a4b6/aEikdZRRDuSFALpnzVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W+fIdnfMapkNH5O11+uQ0XITad4Xr3BSTXee6PSkohgaj+1YXy/G7ePsOuLBWy11diN4xR0A8CvZTL446EPBtyZK/eENdb2Jkz0jBMsjDqJ2tLpXLMf4KS3jO4SuCTRw0BfjV0dXa3TV50ePRNf+vXawu1Fsj2zw8AYSX+OjzR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eqRF+P2B; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlWN3m4ZTFRkRMQ36PyOheGdwfE0IEzlXIudPHtqbHIuO1MCXtdW+GZIrGiJL4622wrQhrRCR1ZNB7DWrMIwySGFyHukbGvWzFswzSjPt2bx12fiTJVTETOskHNvq2r7gfBNEg9EXGsz3r0wepCcKLkuhBE45I5SxwgRGZ3JZWkcPnhI+Zd9fwBwbbbYoyaXmNaiP5NaOGnoMduI7EBfh2SiZ8McGyKkHp7WWm5HpvZ8TGLnA7kJN8u2sPUtSh5XvS0yqq07aCIcFSjGo41lVIt9fHk0/AVbE0HHxAq4vtNYeTPi76ZJkyHUrY+C2UbyII2D3yVQyL83Np1ldgp0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WCU82Jd1uNgVmSGztRSAEgr67cG0iKflrPCprWFeRc=;
 b=icoc8b+zhxE/HiQd15Pw6j9EhjzLlbiEbzXV/bOpYITtzdJg5AMZHaswtJR37JW/Pa0cCWqooiby4gLp3ixMCn/f6ySa1hQ+DM+bkTg0jn3sy3HQTGYQ/qk1C+6yJUmEFUz1W3mIA6sZeUcE9FVdnBYI9Z4gkkKLH/eq78fsrFa9rNB4oGRb3c0l/99AtHESwOZ6P87Jnxo6Gp3Pnb2SvPwxKvyPzsvAqDXb7YzK8BzCHTO++g+eK7WOKLjWC6Cg3Lk6wzyMRhOkuLJWWmXTzOV6M/tf47CcFF6Telj3tCMu0kHCRs83xVTkspIRhAzpI0OhaQ++ifee2msM9H8jUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WCU82Jd1uNgVmSGztRSAEgr67cG0iKflrPCprWFeRc=;
 b=eqRF+P2BqlPJWN0Koi8YXZaJkOG/+wrMSUw/QTXI9/ubt/TRBqpZVMRcehzI3Hslby9IJYXReDUY/3Jo8jyqRGh8CcdIjEr2eHl4rfwF7doGWLwtTqYnufDm1SGy2Aznu6Wzt3Hnupgoxpjuh5gnjkEqHy4/vCxb59bBnyObNEt4ZVXrOGxD2ABSuy42xJ2ngsFTSdo34d9p2RnTHkQkdFwRM4YxN+4lqPvb02R9CQroreW+hjhdXXH4/McmiikC+T03Sw+hsM9sgQYBQc/NxS8Q8moqqZT0lj1YDQIup0aXulW7FTQZNaLx/zqB7lWklsI4/XNfm2zeYyAkayTO6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.14; Tue, 18 Feb 2025 23:50:22 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 23:50:22 +0000
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
Subject: [PATCH v8 4/8] mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
Date: Tue, 18 Feb 2025 18:50:08 -0500
Message-ID: <20250218235012.1542225-5-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250218235012.1542225-1-ziy@nvidia.com>
References: <20250218235012.1542225-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:208:329::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 072bb02a-3076-44c4-7e08-08dd5077022e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?11Sh9pasSGqhsjPWwC22lqg6FW+mQH2Iei/jT/0v4QS4s+dpkrM5MTe33Vw8?=
 =?us-ascii?Q?pI9NFKXuKvp1WpW3Vmreagj+P+rCXNIIjhTOe3gpLfvfWLgiV+s2k3NOWPUs?=
 =?us-ascii?Q?VBDKDIecN0p00NnJlBSA+XLfwYaYImndIiDvZqC6e7yKC3Pmz4exxQxH+i/l?=
 =?us-ascii?Q?WNxXX6S/Vwy9MhRbUZyRwEeqpd3+Wb0jgGjndqsBvih1cpgp7OTqj/KX+RSg?=
 =?us-ascii?Q?FGVsVlzdnYMc9Ccis+KT3QGHoECJ2EycIy44eJGVIRGQsLo6DAPm6A/jXDjq?=
 =?us-ascii?Q?Cktec75/xHDlbOXDNV7J9TrjriDrCVAprRHzRX8uMFe+5xzBbW1tSd9Ag0be?=
 =?us-ascii?Q?yauY22pAUmpMyuMjTLo+6MyTWnJgsGakVK0fk2KMTBhBe3WEQ5rN3EJbmYiu?=
 =?us-ascii?Q?w/x8D9Bb7jPV+8ZWpV8bvPK3EqGeDpFWD0vM64x12SPSkZvIDdMQktU+yPMH?=
 =?us-ascii?Q?1Wd34K8qIfmovd65WDaeYNCc3wOHBbDs7phJv3EVK15U9xPFyOcen8VZfa1J?=
 =?us-ascii?Q?uzj/Ojm7TpwOEBxl6y/MuaBjwePwrXmeziVb/67b8jqgryntPLfbkINmmkCj?=
 =?us-ascii?Q?UpT3yjEE/SW0zVKQ3EsJxYQzj4C3Zzn6JEOv6afYleP6G+Y03YQfxiZrq0tL?=
 =?us-ascii?Q?qjMuWoiJWhXdCyB/DgRYV9BFhSyt/RewUvl3/JXPuHE8tTffGJcKjFAWfikW?=
 =?us-ascii?Q?YVNyWlRei+7JmQ45Bngtne7kIcca3xerv3GeSp+KlLaPyrY+9p44uk4DoRYe?=
 =?us-ascii?Q?DkzRYucirXcrn9SekvNhnrmEnp7n0Mh+WIAcWBljPmgXqBZT2QwOffZshoRf?=
 =?us-ascii?Q?VpdWUX/MkVGF4OVQkEcN+zUB5rEU18t3AK3FQ/PxUfICEcKUAFkPJiJ9Zra4?=
 =?us-ascii?Q?g7zyzi3iA2/SjeWmCa2Od3afrKe3Z/KM/Lf+J9HrK0E35sYj8lo980PRVK5G?=
 =?us-ascii?Q?fj/LsEL3rKSHV5xFJrsID2vjmcnks8JqWULKxXDzqcFjO0khnwydERNZr24B?=
 =?us-ascii?Q?p7iu3FOvsugeLIFWKnwD63FFfr4DUCwrGO90l1x12tgtB4H0cazn9oCEhLyg?=
 =?us-ascii?Q?XaO3NilBj60DTywuLEUldsxGKYpZQcA6W3hHUl42ueK+KacSFlVWA57ibeB5?=
 =?us-ascii?Q?W3ab+mlZJgeXJE9ijJyu/2qp78ggfK0+hRyauKRd0Wj5MOu+lcbwh+pZNgKQ?=
 =?us-ascii?Q?EpDtIVzD91PLKndFeRJZJApDO4iueAcKlsmozIbjUVLkPMQ+wLof3RfpZwpK?=
 =?us-ascii?Q?/25SIkDSOMPb4LSuv0Ej5Gk84LEgAFZXPhHd/eLKVXO46eg8WR8jKDFe2KBY?=
 =?us-ascii?Q?JNY3Ru0M1k0VFCxu3+MEuV9qTEmynvv43lcrxv+Z6O19Ikac2xwxQtWV3uhQ?=
 =?us-ascii?Q?mP4Sskyz81YfESvIie4F93zBpITj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iqZtUwHiAEP6JKB9RAfb9/pzsyTXsxbEPLmLHYM8sIv+NsA5L/Zxjd9fJmrc?=
 =?us-ascii?Q?n9B5esbqWChcziprvtQnUkv7jA/zq7uFK5W5uVOn1kKK0uFjOuZC2iTEvG25?=
 =?us-ascii?Q?IkrXaVCdXOVgo9GlBNx+Asc/AM/EuCd84SjR2dtlu+pL/rLIWjAOkqYRSuYI?=
 =?us-ascii?Q?ld0g7ODYP8rqv7wI5WSff9GIATJLojPKsnKgb9ggs1JjH9d3I1yEGEKPs5nj?=
 =?us-ascii?Q?IYWdkWRFxkjIYwqWtXVTsD0a2KqouEPkP47IRAY1qDcsolbpCbhDOGfTh03K?=
 =?us-ascii?Q?h/A5a042AllmhgO0GqiEiahytAZNGLfUnWuxoWiORS0uA1ZNTkBdImA1r84x?=
 =?us-ascii?Q?ywA4dQlFMNWpwftXExpbzUyMcLLO3a9e0idIxfCpM3L38ibfE2OBGiDCd2wV?=
 =?us-ascii?Q?+ZqvnrwUpP1pXEX6wTjti6F+qnBoWZLxUHVXQQM8ub6N5XxFRaXQ4I9hFfhC?=
 =?us-ascii?Q?0InrxWUTgitpQQe2uNq3a8F19Qt7raWvyjn1jxQ9E2SuD07URZ9lfDW07QfL?=
 =?us-ascii?Q?w/xcN69HoWS4W7Cp+6n9974i8p9Hn+PivaduPw0TiwZq/pn2MEhdjY0+BMst?=
 =?us-ascii?Q?S4KrMK8gcwzTDT1RJTFKa50I/9Uv1Rk8GArmjxYlrYSJSm6Sd7zhlYX1MI9U?=
 =?us-ascii?Q?2HVLvkQbj20xOAObiipxFrHy0BFOK4NaYGYCwS6OeLuYPOz+UkW+42guzHsB?=
 =?us-ascii?Q?u9u0Mf0CrBJywHsGllYRLRZL459S3UMyazOK5FyE7vS6jopIugmAiSSDp3be?=
 =?us-ascii?Q?l6/k1PJQYZH83nvAF+7wKl8BOlJDfKTxIn0kLlEl1HryA774ioy8rzReYEYm?=
 =?us-ascii?Q?L7eF4F3BYfgFs9QRCHKrC/NHgjGu19NfCT/foBvYWlOqZx2qHAqbOlWzoIWX?=
 =?us-ascii?Q?Z+8XqLhoUUBUPf1iIZrfBQ/ruWEDszW8I9Cxt6jbCcpKfqCoF7uA1nFmFuxE?=
 =?us-ascii?Q?W2fcHUsxhzib6wEKvGH+ygzYO2iLTszdiSwR/MSbQEvC/IijIS9hIIGx3RvW?=
 =?us-ascii?Q?xAAM0FuLBEmduRsSPKKJ+jc7HlPmyd/2IEfsmVRjmVfC7j6bBPzmIAjibPwr?=
 =?us-ascii?Q?3CS4Mme3FKRpERFj2M6AW+fAFN7oNwMIi7NVVhO0m41mtlEZnBduh6Z5nBJa?=
 =?us-ascii?Q?jwKm00HcqnbI3heGUm9cdQ6H2+CAcswGaO9Fmh93nKugFq6wnMsRDujIqV6+?=
 =?us-ascii?Q?08AkLhohzcQ+30ywDiWXCw2vd1zwZUpgsfaslvBxp5awYmpB2vjOtUu4Tm5Y?=
 =?us-ascii?Q?/LJnALzz+9m2QEM8y8RvYB8iQptEp56H6yaIW2H5NUmysUSYpJCIlqXmdax0?=
 =?us-ascii?Q?zHPtyneW3TfIYwzdRvZN2jO166IwH54gb8LTZIB7SrTIVMtskOyIh1o+aLJs?=
 =?us-ascii?Q?4KSpBRIqJkTDqqDRILc/r7IISQF9flxHvWhjWNEej6akLP52WhHTPn3/Fgnz?=
 =?us-ascii?Q?/KiqLRvrB2H7HyElwRvDDQjvXWXM/JazCszAVPZ3G/qpioaauNj2aqIuda79?=
 =?us-ascii?Q?zClTr4oBKVN3EIEHGXU/pYgdiv46LmA12oGTRu7gZG2mzHpHIC1XWhO/MZhp?=
 =?us-ascii?Q?TNPuI2l46Zudy2pAApkB4nPoKE9DfHIL3eDlgaGv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072bb02a-3076-44c4-7e08-08dd5077022e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:50:22.5773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1Hrepb7kn+S1SEmgERTlDw9ZIXeHwTv6VQroPpQS4eHNeabsOYqyBVUWn9dEgJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

folio_split() splits a large folio in the same way as buddy allocator
splits a large free page for allocation.  The purpose is to minimize the
number of folios after the split.  For example, if user wants to free the
3rd subpage in a order-9 folio, folio_split() will split the order-9 folio
as:

O-0, O-0, O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-8 if it is anon,
since anon folio does not support order-1 yet.
-----------------------------------------------------------------
|   |   |   |   |     |   |       |                             |
|O-0|O-0|O-0|O-0| O-2 |...|  O-7  |             O-8             |
|   |   |   |   |     |   |       |                             |
-----------------------------------------------------------------

O-1,      O-0, O-0, O-2, O-3, O-4, O-5, O-6, O-7, O-9 if it is pagecache
---------------------------------------------------------------
|     |   |   |     |   |       |                             |
| O-1 |O-0|O-0| O-2 |...|  O-7  |             O-8             |
|     |   |   |     |   |       |                             |
---------------------------------------------------------------

It generates fewer folios (i.e., 11 or 10) than existing page split
approach, which splits the order-9 to 512 order-0 folios.  It also reduces
the number of new xa_node needed during a pagecache folio split from 8 to
1, potentially decreasing the folio split failure rate due to memory
constraints.

folio_split() and existing split_huge_page_to_list_to_order() share the
folio unmapping and remapping code in __folio_split() and the common
backend split code in __split_unmapped_folio() using uniform_split
variable to distinguish their operations.

uniform_split_supported() and non_uniform_split_supported() are added to
factor out check code and will be used outside __folio_split() in the
following commit.

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
---
 mm/huge_memory.c | 160 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 123 insertions(+), 37 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 94ed85aadecd..2880dd010bff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3730,12 +3730,85 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 	return ret;
 }
 
+static bool non_uniform_split_supported(struct folio *folio, unsigned int new_order,
+		bool warns)
+{
+	if (folio_test_anon(folio)) {
+		/* order-1 is not supported for anonymous THP. */
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+	    !mapping_large_folio_support(folio->mapping)) {
+		/*
+		 * No split if the file system does not support large folio.
+		 * Note that we might still have THPs in such mappings due to
+		 * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the mapping
+		 * does not actually support large folios properly.
+		 */
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
+	if (folio_test_anon(folio)) {
+		VM_WARN_ONCE(warns && new_order == 1,
+				"Cannot split to order-1 folio");
+		return new_order != 1;
+	} else  if (new_order) {
+		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+		    !mapping_large_folio_support(folio->mapping)) {
+			VM_WARN_ONCE(warns,
+				"Cannot split file folio to non-0 order");
+			return false;
+		}
+	}
+
+	if (new_order && folio_test_swapcache(folio)) {
+		VM_WARN_ONCE(warns,
+			"Cannot split swapcache folio to non-0 order");
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * __folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ * @lock_at: a page within @folio to be left locked to caller
+ * @list: after-split folios will be put on it if non NULL
+ * @uniform_split: perform uniform split or not (non-uniform split)
+ *
+ * It calls __split_unmapped_folio() to perform uniform and non-uniform split.
+ * It is in charge of checking whether the split is supported or not and
+ * preparing @folio for __split_unmapped_folio().
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ */
 static int __folio_split(struct folio *folio, unsigned int new_order,
-		struct page *page, struct list_head *list)
+		struct page *split_at, struct page *lock_at,
+		struct list_head *list, bool uniform_split)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
-	/* reset xarray order to new order after split */
-	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
+	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
 	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
 	struct anon_vma *anon_vma = NULL;
@@ -3747,32 +3820,17 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
 
+	if (folio != page_folio(split_at) || folio != page_folio(lock_at))
+		return -EINVAL;
+
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
@@ -3829,10 +3887,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -3897,7 +3958,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		if (mapping) {
 			int nr = folio_nr_pages(folio);
 
-			xas_split(&xas, folio, folio_order(folio));
 			if (folio_test_pmd_mappable(folio) &&
 			    new_order < HPAGE_PMD_ORDER) {
 				if (folio_test_swapbacked(folio)) {
@@ -3911,12 +3971,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 			}
 		}
 
-		if (is_anon) {
-			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
-			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
-		}
-		__split_huge_page(page, list, end, new_order);
-		ret = 0;
+		ret = __split_unmapped_folio(folio, new_order,
+				split_at, lock_at, list, end, &xas, mapping,
+				uniform_split);
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
 fail:
@@ -3994,7 +4051,36 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 {
 	struct folio *folio = page_folio(page);
 
-	return __folio_split(folio, new_order, page, list);
+	return __folio_split(folio, new_order, &folio->page, page, list, true);
+}
+
+/*
+ * folio_split: split a folio at @split_at to a @new_order folio
+ * @folio: folio to split
+ * @new_order: the order of the new folio
+ * @split_at: a page within the new folio
+ *
+ * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
+ * split but not to @new_order, the caller needs to check)
+ *
+ * It has the same prerequisites and returns as
+ * split_huge_page_to_list_to_order().
+ *
+ * Split a folio at @split_at to a new_order folio, leave the
+ * remaining subpages of the original folio as large as possible. For example,
+ * in the case of splitting an order-9 folio at its third order-3 subpages to
+ * an order-3 folio, there are 2^(9-3)=64 order-3 subpages in the order-9 folio.
+ * After the split, there will be a group of folios with different orders and
+ * the new folio containing @split_at is marked in bracket:
+ * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
+ *
+ * After split, folio is left locked for caller.
+ */
+static int folio_split(struct folio *folio, unsigned int new_order,
+		struct page *split_at, struct list_head *list)
+{
+	return __folio_split(folio, new_order, split_at, &folio->page, list,
+			false);
 }
 
 int min_order_for_split(struct folio *folio)
-- 
2.47.2


